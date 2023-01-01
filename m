Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E697965AAF2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAASR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAASRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:17:24 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D012BC3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 10:17:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 731815C0039;
        Sun,  1 Jan 2023 13:17:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 01 Jan 2023 13:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672597041; x=1672683441; bh=E0
        6gK8B1k5R+4obR/pb85rIU152DGA90BBobWIrecS8=; b=0Ln4PadVciBogZjekQ
        2pS+AmcHB3Z/l6e+7rIqjIB1Ssvq2CPP9JIv3KgdkWVpWx6y3N1yTgkX9h+6OY7+
        HW9L/p+8GM5YwcNe4q+ymkSZIqzqhaiUF6iFiH6ZlbYkTcGOdr2gAqNLzApOExY7
        t4ODXJgoMa0zqp37nj5D9Q2WONTWYkBP5jWrw2G5yqCEJviHU+OyfSqUzZ0R6P/b
        ZRd1RQMhbixVW8rZmOcW4BTz28NpNrOUZiRr1dv3eR1OhEBJUIvcfV9/r1w1B1qQ
        6D1SfKlxAadkQThAzExq/M7hRYv2N4MtHXP/TD2dy7HmYBGbGdQs4ylf4nAOWYU5
        r9rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672597041; x=1672683441; bh=E06gK8B1k5R+4
        obR/pb85rIU152DGA90BBobWIrecS8=; b=D5gzXsaYc/R85U8dvuMeHjfDFIJ/v
        VQGQAZppwsjhHP9B4u/ijxQXtOxc7S8Nodp/K5uN7ggP6w7adlq3Qz1A2C7YcveP
        ikUcAJfVVl/FHkxO7MWOw6bQUPc6kWZeQYJcBNitjSqZGLwlyd1xQZ+3hU/+hOFH
        slR7xlmlrsGyWimgPppH3IuyDDaOXp17lOn99TRWeMWmKLKriTiSn8wjw5IRg3bX
        XEHtGiz6YXRQLjBce3NTgP/ZdQ8Hkulix9+8wCh92E5aNakx6G0sd8eAkw0JcjKk
        Lh3IZk80esbjQYk2xSIGJvRHU7VbxpsV87CECfwN4sMD5TRapmzyJQ9RA==
X-ME-Sender: <xms:MM6xYwQFLyjDCUgASPQ4s01wyatskScV_mbldqOrnbINYd1gzyFOaQ>
    <xme:MM6xY9zWLLrrZOZghmP-wkYP767NH79R88KUzUkjYWMVGQeZQgdUO25eZmk-u77ug
    M8XHtVf4a9yUz1rEw>
X-ME-Received: <xmr:MM6xY917UWDGPfTd-J5kJBsKOcxipSXlCiqBJYBYwpYG-JZWTcD0jGo9UFK42DoCMd4nS_BrsfqHSmtD-ILYvfBre3p6_2cwCN0KrFa6vBHQTI2lbUhSimXzYXNmC8UWuunlBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:MM6xY0C3mVJ90UiUoy1Xt1i52eBfnLGHtkNJNPyQMVbnMwuj5ffddw>
    <xmx:MM6xY5hKWvFiX9NykCt5QWG93QhCHxectXwkHoPF0DMwRKn6FRpVBQ>
    <xmx:MM6xYwrvfPelMtC4L_KLju_OTBOjY2bPJfTdLY4Of-pEonQXcWFZiA>
    <xmx:Mc6xYyYXVXMfCbmI87tafHWH3zhGEZ9dEEdK47uq4MFjII2Y404oag>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 13:17:20 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v2 2/2] firmware/psci: Switch to the sys-off handler API
Date:   Sun,  1 Jan 2023 12:17:15 -0600
Message-Id: <20230101181715.42199-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230101181715.42199-1-samuel@sholland.org>
References: <20230101181715.42199-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any other poweroff handlers registered at the default priority will
run before the legacy pm_power_off() function. Register the PSCI
poweroff handler with the correct priority to ensure it runs first.

PSCI_0_2_FN_SYSTEM_OFF never returns, so the value returned from
psci_sys_poweroff() is meaningless, but that function must return
some value to have the right prototype for a notifier callback.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Update commit messages

 drivers/firmware/psci/psci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e7bcfca4159f..6d528021925d 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
-#include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -322,9 +321,11 @@ static struct notifier_block psci_sys_reset_nb = {
 	.priority = 129,
 };
 
-static void psci_sys_poweroff(void)
+static int psci_sys_poweroff(struct sys_off_data *data)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
+
+	return NOTIFY_DONE;
 }
 
 static int psci_features(u32 psci_func_id)
@@ -603,7 +604,9 @@ static void __init psci_0_2_set_functions(void)
 
 	register_restart_handler(&psci_sys_reset_nb);
 
-	pm_power_off = psci_sys_poweroff;
+	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+				 SYS_OFF_PRIO_FIRMWARE,
+				 psci_sys_poweroff, NULL);
 }
 
 /*
-- 
2.37.4

