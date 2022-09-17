Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65C25BB79E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIQJzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiIQJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:55:10 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DD851CB2C;
        Sat, 17 Sep 2022 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hQA/h
        gaxpSM5m+voV8D6UD8jhdskfEOr91e3ZIlQsQU=; b=Pl7+JUAITsJEn1c/h4ret
        ZINgPNs6BI1RH6Bz5+/YKWB+uPfyfvk/0MhUhTLL4A52dvqwb2GFVy+5S6S+6MBl
        TfKdzehtW3ezgSCCU8cyH2dZV8m4RgpyseksVGWIvzrzECa6Fm7lJZIcAdl3F9IL
        AgMMs8YvoT2z7Mb6ec/ChE=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp1 (Coremail) with SMTP id GdxpCgAHhKZ6mSVjP6EJdg--.59666S2;
        Sat, 17 Sep 2022 17:55:07 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@163.com>
Subject: [PATCH -next] hwrng: Remove duplicate include
Date:   Sat, 17 Sep 2022 17:55:05 +0800
Message-Id: <20220917095505.5646-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgAHhKZ6mSVjP6EJdg--.59666S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFW3Cw1ktw15Jw4DZFy5Arb_yoW3urb_uw
        1xCF4xurn7Kr17Jw1avFn7C34Fgr15ursYvFnYq3W3JF92yayDKwnxX3s8W3yUWwn7Ar92
        qFWDt3W09wnxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_dbbDUUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB0Bx-g2Esr704xwAAsQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@163.com>

In file: drivers/char/hw_random/core.c,
'#include <linux/random.h>' has included at line: 18,
now it is duplicated include at line: 24, so delete duplicated include.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 drivers/char/hw_random/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 16f227b995e8..56d171cd2fc6 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -21,7 +21,6 @@
 #include <linux/sched/signal.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
-#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
--
2.25.1

