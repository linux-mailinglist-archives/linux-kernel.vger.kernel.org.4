Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255B974EC49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGKLH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGKLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:07:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5F18D;
        Tue, 11 Jul 2023 04:07:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso5145005ad.2;
        Tue, 11 Jul 2023 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689073673; x=1691665673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VAbigd4Jr2Fpxzw4zXpvjjl6jteztN/7xaUcM4mF8yg=;
        b=Z9p3jVWhMV/c2wpyEfRmAYwSlrJqkpeLAcNG6rK4qh7mDOCQgMya8F2pVS0JWyF3Ry
         s26ZCLIySjYoiMhRNjHDmPmm4+wcWc9ctTcufWyqB1c3gO7IDQ5+cQdcpWOgQJFu0hRu
         1JYevGGs6ghwb9nBsr3ju6qlWPf1EIR2wQ1Kz8EWpGTySToBpAVTa5tNMxhfUNlVEklA
         C7HZUYdN3X6m4Y3sWkQD2PQGTc5IcPkti7Rs30CoBT6fwS7Gc8f132ewjSkA7U0gMxh1
         w22cShaVFIq6k2G+C2Y3ekgkXAviVkzMCqJVVHljXv17rmI+A54Ty13erxsCmAFVIJiz
         m/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689073673; x=1691665673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAbigd4Jr2Fpxzw4zXpvjjl6jteztN/7xaUcM4mF8yg=;
        b=QfThBWqs64P6+NXwGQMjdBA27Tu5KMG/AjtAVME1a7BJUhWeQV2QUIhTbJD+4hrz+B
         gWCc9Xm7kzeDk8c3sLIGKEeMq1dZ3lhQeSjPqIncJ0RjAiXMwvvWszgzNDqg+MlkLdZ+
         Ru7ucgWgoCKtDHkypP4RJ13VSdkUGQUwZwWKppfSy/a2XNEbm6/OTF2cykQ5VT8SRVRY
         yLLL8Ecmpq9d6ejsl57DGczRmLJPJzgrIRFFAqwRn+NtetKp+pW745VvrWYY2QgBgYVJ
         ORGeBJjvR92aztcBvS8XM9xTP6at5H9QuA51fth3K85GtvMjTzHeKYoOcpWxZq42r55m
         9vEQ==
X-Gm-Message-State: ABy/qLYLgcMipoIjAa72er11gdYdQ1c8gPxFuaGyCNCrIwTafyhY1zCP
        F8oDpNNk2s1cKDAzuP8nd2qocCbPZeKFTCCU
X-Google-Smtp-Source: APBJJlEkBptODe2A0mVXfRnbLcZtVjmpzHzGpx2ENBDHNvRvTI9qIBydJG2CofJ2lXW8bPiRqBPF2Q==
X-Received: by 2002:a17:903:2351:b0:1b8:86a1:9cf with SMTP id c17-20020a170903235100b001b886a109cfmr15113690plh.32.1689073672740;
        Tue, 11 Jul 2023 04:07:52 -0700 (PDT)
Received: from localhost.localdomain ([81.70.217.19])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001b9dab0397bsm1628764plk.29.2023.07.11.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 04:07:51 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     michael.chan@broadcom.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
Date:   Tue, 11 Jul 2023 19:07:43 +0800
Message-Id: <20230711110743.39067-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

In bnxt_tx_int(), the skb in the tx ring buffer will be freed after the
transmission completes with dev_kfree_skb_any(), which will produce
the noise on the tracepoint "skb:kfree_skb":

$ perf script record -e skb:kfree_skb -a
$ perf script
  swapper     0 [014] 12814.337522: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [003] 12814.338318: skb:kfree_skb: skbaddr=0xffff888108380600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [014] 12814.375258: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [014] 12814.451960: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [008] 12814.562166: skb:kfree_skb: skbaddr=0xffff888112664600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [014] 12814.732517: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [014] 12814.800608: skb:kfree_skb: skbaddr=0xffff88810025d100 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [014] 12814.861501: skb:kfree_skb: skbaddr=0xffff888108295a00 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [014] 12815.377038: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
  swapper     0 [014] 12815.395530: skb:kfree_skb: skbaddr=0xffff88818f145ee0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED

And the call stack is like this:

$ perf script record -e skb:kfree_skb -a --call-graph fp
$ perf script
swapper     0 [015] 12915.386236: skb:kfree_skb: skbaddr=0xffff88b0473cd000 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
        ffffffff81e5b0a7 kfree_skb_reason+0x117 (vmlinux)
        ffffffff81e5b0a7 kfree_skb_reason+0x117 (vmlinux)
        ffffffff81e6dd1e dev_kfree_skb_any_reason+0x2e (vmlinux)
        ffffffffa04510d5 bnxt_tx_int+0x95 ([bnxt_en])
        ffffffffa0454ee5 __bnxt_poll_work_done+0x25 ([bnxt_en])
        ffffffffa045b9d2 bnxt_poll+0x72 ([bnxt_en])
        ffffffff81e7b47e __napi_poll+0x2e (vmlinux)
        ffffffff81e7bb34 net_rx_action+0x294 (vmlinux)
        ffffffff8218ff5e __do_softirq+0xfe (vmlinux)
        ffffffff810ad51e irq_exit_rcu+0x7e (vmlinux)
        ffffffff82175bb5 common_interrupt+0xc5 (vmlinux)
        ffffffff82200d27 asm_common_interrupt+0x27 (vmlinux)
        ffffffff8217ae54 intel_idle_irq+0x64 (vmlinux)
        ffffffff81dea7ae cpuidle_enter+0x2e (vmlinux)
        ffffffff811057e3 call_cpuidle+0x23 (vmlinux)
        ffffffff8110b16a do_idle+0x1ea (vmlinux)
        ffffffff8110b3cd cpu_startup_entry+0x1d (vmlinux)
        ffffffff8106dc08 start_secondary+0x118 (vmlinux)
        ffffffff81000263 secondary_startup_64_no_verify+0x17e (vmlinux)

Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
to reduce the noise.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
v2:
- be more specific in the commit message
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e5b54e6025be..d84ded8db93d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -685,7 +685,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 next_tx_int:
 		cons = NEXT_TX(cons);
 
-		dev_kfree_skb_any(skb);
+		dev_consume_skb_any(skb);
 	}
 
 	WRITE_ONCE(txr->tx_cons, cons);
-- 
2.40.1

