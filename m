Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610966BBA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjCORAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjCORAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:00:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84F591FE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so48707527edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678899617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmF38oC9lqp4yElAVF5IokX21ysRVn5aKj2yBWpwkNI=;
        b=clcNdh4Dqr5kllYj4AL+2TjsVGG9//ajmdM/XFlWJ0SzufWH6PIyuHQtaezgThDd5N
         pwlG31czpWB8qfFE1SHgPibqEA78GfCsgCEbt/+aW5BMHmq+lDPCgtmJ5BKBVUHwqjBD
         zSJylmKzsHA0JJrm8+ZD3GfH/Ymd6220pEitaqLfvRwXsDPDe5XzhkhznW1zM0GQXwaL
         XDn/7Zv5Yv22AjtLGHejxZUwYQR4NYsxCRp/Ej8BEw/6SJ7uR94q//Hs8hbzqqwZBxN6
         MazxyLIx9qoawZsALAC3LeREEEzwWU3KWjhCjp5a7E4ViWiDnZGqmdDNBaQGXKYq47CH
         smSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmF38oC9lqp4yElAVF5IokX21ysRVn5aKj2yBWpwkNI=;
        b=I5nudk+Jq+o1qWOA0SJwIQwcnsYx3YIE3Lcm6mPMt74eVYfNO77k1gAMf0ClUDC7ef
         jOOWSnwe1kg7nrasUBQDNITfgzqg8Xg6y0a/wRGCgW8dcYTWd1QGFHi5SIlo41wc/3DY
         gIwbzR6asugeSlBDz9v/erTBaMeIqkZgmBWtP9aAMeG0DdlDqSkXbI/sPPLO22KBYPE/
         7K4CeqeOGkixYWYJSnBQr2wkJIpBfDqq2yqeHD7vE6s7nLnPYrQZ4+cH/1D8p0PU2/Vb
         aPbua9670QI6wNUtbJZpEXgxgl1g0XdzpH6xl3TMdAO4Fg7G4q8dk1Cimpr5Liexta/B
         p3Zw==
X-Gm-Message-State: AO0yUKX/xM5ngNYzGzIfJWG1AQBNs3vwi8R1eVdmJ+UFecXdVHJxeadw
        vkvlZhQX/dK6dAb0KcQ8R32jHZxseS0=
X-Google-Smtp-Source: AK7set/4rWn+WhUM9VZz6iFaX67MB0WCm1wbBjyMH+1qJ41OoDvBiZEmmhcOz/PRkV2NtTXryHAS2g==
X-Received: by 2002:a17:907:8c07:b0:926:fce:c080 with SMTP id ta7-20020a1709078c0700b009260fcec080mr7522445ejc.17.1678899617418;
        Wed, 15 Mar 2023 10:00:17 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id q22-20020a1709060f9600b008eabe71429bsm2771895ejj.63.2023.03.15.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:00:17 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH v4 2/2] staging: vme_user: remove unnecessary blank lines
Date:   Wed, 15 Mar 2023 19:00:07 +0200
Message-Id: <c8fedfeca9a56dba26846a5bed56642cc694bcbe.1678899549.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <57006c151d4d95550b987143a6650f8b3594ddea.1678899549.git.eng.mennamahmoud.mm@gmail.com>
References: <57006c151d4d95550b987143a6650f8b3594ddea.1678899549.git.eng.mennamahmoud.mm@gmail.com>
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

Remove unnecessary blank lines before a close brace
as reported by checkpatch script

"CHECK: Blank lines aren't necessary before a close brace '}'"

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v2:
	edit commit message

change in v3:
        edit commit message

change in v4:
        edit commit message
---
 drivers/staging/vme_user/vme_tsi148.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index bfa604043355..2f5eafd50934 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -1023,7 +1023,6 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 err_res:
 err_window:
 	return retval;
-
 }
 
 /*
@@ -1741,7 +1740,6 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 				  list);
 		prev->descriptor.dnlau = cpu_to_be32(address_high);
 		prev->descriptor.dnlal = cpu_to_be32(address_low);
-
 	}
 
 	return 0;
@@ -1773,7 +1771,6 @@ static int tsi148_dma_busy(struct vme_bridge *tsi148_bridge, int channel)
 		return 0;
 	else
 		return 1;
-
 }
 
 /*
@@ -2220,7 +2217,6 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	}
 
 	return 0;
-
 }
 
 static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
@@ -2530,7 +2526,6 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	kfree(tsi148_bridge);
 err_struct:
 	return retval;
-
 }
 
 static void tsi148_remove(struct pci_dev *pdev)
-- 
2.34.1

