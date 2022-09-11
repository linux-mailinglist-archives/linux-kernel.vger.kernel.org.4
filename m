Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9C5B4B77
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 05:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIKDg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 23:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIKDgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 23:36:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883527CC5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 20:36:51 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MQFf85V4VzNm63;
        Sun, 11 Sep 2022 11:32:16 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 11:36:49 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: pxa: add __init/__exit annotations to module init/exit funcs
Date:   Sun, 11 Sep 2022 11:33:20 +0800
Message-ID: <20220911033320.122799-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 arch/arm/mach-pxa/corgi_pm.c | 4 ++--
 arch/arm/mach-pxa/spitz_pm.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 555a5c1afd96..694e869a8cab 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -188,7 +188,7 @@ static struct sharpsl_charger_machinfo corgi_pm_machinfo = {
 
 static struct platform_device *corgipm_device;
 
-static int corgipm_init(void)
+static int __init corgipm_init(void)
 {
 	int ret;
 
@@ -212,7 +212,7 @@ static int corgipm_init(void)
 	return ret;
 }
 
-static void corgipm_exit(void)
+static void __exit corgipm_exit(void)
 {
 	platform_device_unregister(corgipm_device);
 }
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 6689b67f9ce5..6711c94d15e9 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -224,7 +224,7 @@ struct sharpsl_charger_machinfo spitz_pm_machinfo = {
 
 static struct platform_device *spitzpm_device;
 
-static int spitzpm_init(void)
+static int __init spitzpm_init(void)
 {
 	int ret;
 
@@ -245,7 +245,7 @@ static int spitzpm_init(void)
 	return ret;
 }
 
-static void spitzpm_exit(void)
+static void __exit spitzpm_exit(void)
 {
 	platform_device_unregister(spitzpm_device);
 }
-- 
2.17.1

