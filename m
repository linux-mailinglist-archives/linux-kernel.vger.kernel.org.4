Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F765885B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiL2BaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL2BaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:30:07 -0500
X-Greylist: delayed 911 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Dec 2022 17:30:04 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECF0CCE00;
        Wed, 28 Dec 2022 17:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VE/6IL+NyZmYYt73YY
        RzDpOKhISVzB3dUqOTz13Lnzc=; b=ga/7wCMgvI5X0MnKgHctK2L2G3/hm/itQf
        LnOwSFMK2FA+KUlTcIHWQKILJcM1JquOgOKLgGjhUIrBeKWt6upJSCc27mL0SEhu
        MwLIBB589RKszzJTY0hjsM+++DWpb9TVESuxDKnHiwLk4t69Y70kkJo3IGBVmEuo
        uYXmds9Yw=
Received: from localhost.localdomain (unknown [43.134.191.38])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wD3__Pr6axjhyEfAA--.12469S2;
        Thu, 29 Dec 2022 09:14:22 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] bus: mhi: host: Update mhi driver description
Date:   Thu, 29 Dec 2022 09:13:58 +0800
Message-Id: <20221229011358.15874-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3__Pr6axjhyEfAA--.12469S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyUurW3Ar4DJryxAr4xZwb_yoWxKrg_C3
        9rXr1xKwsYgryqkws5Z3Z5ZFyIyF4xXr43AFs2gF1fX347ZwnxJa4DWrWft3ZxCrWIyFyU
        CrWqgry0y3W7ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKiSl7UUUUU==
X-Originating-IP: [43.134.191.38]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiMADmZFWB0K6zKQABsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be a mistake. MHI contains "Host Interface"
already. So we shall update "MHI" to "Modem" and the full
name shall be "Modem Host Interface".

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index bf672de35131..7307335c4fd1 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -1449,4 +1449,4 @@ postcore_initcall(mhi_init);
 module_exit(mhi_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("MHI Host Interface");
+MODULE_DESCRIPTION("Modem Host Interface");
-- 
2.17.1

