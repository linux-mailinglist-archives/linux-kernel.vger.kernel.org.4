Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF74D5BCE59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiISOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISOQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:16:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4AF32ABC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:16:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w2so17028326qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gi0TnNbGqxYHjuOkweth3voflohQx3+OCCEOwCUfQSM=;
        b=lq61+2uFX+UjcC1s4RAx7rx9aBCHZXEUBJI7L53vGqd2Fh/3gcaDpU6LF/Am7ZIQKB
         3nieaq+ZvBN8KGV4S4QeGeMGTa0qJCPRqXmOz8EVqerjpVDENvt1Mo/vvznll1Z4nB0H
         XrYxDmfldK7uhhZiYEi64TgqTypg2BNFUMYvx7KrZHgN6TNj46NNd1NwWMmF56EpTQSZ
         +DqF9YlEERlNMFF4A5Ois7OJsoha+qa7Wmv0J/DOrQI5ipoW6m1mp+Fo6xzkG8u7Y7rM
         LLJ83xhLt1l9BHD7ldYULLBFB8LMeP+uxg03p7US2uRTIXJg0qyB4bDV9VOaVzdbVIAp
         Qweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gi0TnNbGqxYHjuOkweth3voflohQx3+OCCEOwCUfQSM=;
        b=esmpLa1AE7K3FObUQhOjJdAxI8I5rlUYa4ntjpcO1UrEIdpbvNuVXW8VVGsDjUsoDc
         4Lz/UyCywYS5zLhX/v8LUYmJEv7DrvclzhlVl68DOcO5s8yQmUK0hQF5Wz304bCT1ibc
         aRD0aNum6VupG+UDGzFSOvadoiqR5wqqq/HBQqwfwKQ5KNCEEwAexWTA96xd1+1h3j6C
         HhK8GU5E8vD1R1eL0Xlx6Y/LnSIlEz8Jm+zC7kX/yLHS7n9kXnZS/gRtlxvO0NEW+fC4
         MmR8bpno/KY0whP5cKXT2vDucEhmGqhUeM/IV2HOC5QCeNIa8ccLTZsKlJ2F9Gat9tmF
         8smg==
X-Gm-Message-State: ACrzQf1rPlNbR9OfYeGtQCGyVqG63Hr6+usWzdlbHbODqiib1lHYYZYB
        huLujP/NdqcWC1JLHMDFGfA=
X-Google-Smtp-Source: AMsMyM4FhYhpHQBMEPreZIWLNq+qEzxt4809sJ350dYwnOQ/wEb2PyYBsTAI8KxLoUb7ktsDXVCzcw==
X-Received: by 2002:a05:622a:1886:b0:35c:b9f5:cbcd with SMTP id v6-20020a05622a188600b0035cb9f5cbcdmr15464555qtc.290.1663597005287;
        Mon, 19 Sep 2022 07:16:45 -0700 (PDT)
Received: from localhost.localdomain ([142.126.147.56])
        by smtp.gmail.com with ESMTPSA id w4-20020ac86b04000000b00343057845f7sm10377369qts.20.2022.09.19.07.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:16:44 -0700 (PDT)
From:   Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     f3sch.git@outlook.com, guozihua@huawei.com,
        linux-staging@lists.linux.dev, aruna.hewapathirane@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8192e: spaces preferred around that '<<' (ctx:VxV)
Date:   Mon, 19 Sep 2022 10:16:24 -0400
Message-Id: <20220919141624.8765-1-aruna.hewapathirane@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes 2 checkpatch CHECK issues

Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index f651947f6b44..933f347fc17e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -818,10 +818,10 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
 							     header.addr1));
 				frag_hdr->seq_ctl =
-					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl)<<4 | i);
+					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl) << 4 | i);
 			} else {
 				frag_hdr->seq_ctl =
-					 cpu_to_le16(ieee->seq_ctrl[0]<<4 | i);
+					 cpu_to_le16(ieee->seq_ctrl[0] << 4 | i);
 			}
 			/* Put a SNAP header on the first fragment */
 			if (i == 0) {
-- 
2.30.2

