Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B561DEFF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKEVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKEVsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:48:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77213DE7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:48:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DF302320027A;
        Sat,  5 Nov 2022 17:48:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 05 Nov 2022 17:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667684928; x=1667771328; bh=H8
        veXpvoO34Pl6tFHer7gYF/PO/WldpA4cjeFDX9dV0=; b=BOQ+xVr9BgNBJ53Np2
        2GVbC01Gy1k7LsisJ6a4HuFQ3aNwUYuzdzm3kSYYjx33wwfxPd0z3fECkRdEfz4F
        62Ckj0vTqo+3S0f1R73TNu9D4AXuFNon1dbIpj9aF4IKjZk2tDFoPyojbI0oQ5Ix
        g4FwJgG5IO77IGz6Jr3cpRjq8dhQogtGz1IRhP3LwNipbhXviPOBoGB0/NIncCQX
        U6qCvJNceg91LP93s5iTTQdXCfCxWf/1fTzpJYAwa0dbpMGBt99el8lLAPM6Yp7U
        8YPb8yfCQd5ZeWTXhK6J515XXEX+UQMNrnHpZaMMKsQ//xhb7epA0EqIw7JVLRUT
        T8bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667684928; x=1667771328; bh=H8veXpvoO34Pl
        6tFHer7gYF/PO/WldpA4cjeFDX9dV0=; b=ttfz6Ev9+nb8DRzIFbSUQXXoxy9ds
        MqMYAiRBBZ3/WgwsScVNN2kM2Sgat6JoK3cuvMFUt1Aoicg3XsJDkqDiCmPBy2CE
        xVzfbYRrCAn7ViWfA2DrzmRnqphG4AkBaJqKRIpfjTH3FZs6uwmdxs1RKs0MPlYY
        obe6NpNuqQ7Flq1zyG6ykN3p32xcz59OpwqWmcetbOYO38K/MBODaAO6H7SSz5a3
        ZwZYYEKPHLxBZ5QkpWMj9Ehqi9tFw8tX6MgvREmHH1+IqcDUZtVj5K6BJLrIQb3l
        U9cQtO+CZYTwm+FzVVabUcWH9lVZBKk/yzLK2u3Qvnti3H5yt22pP7a3g==
X-ME-Sender: <xms:QNpmYxEKKrp7uWJIs2nOfxdiDiviudbQ4u6zgg7LYq4xP_b0YWvKjw>
    <xme:QNpmY2Wrk1aJt-SvJ_2rusqeK_oyXJaMYhqcmwCDgeVawAToyYSxZR9cwEjAvSWEd
    lJvGO_kjBaiZ5z2qw>
X-ME-Received: <xmr:QNpmYzIQWRev5acjGr12qjqZeAf31D22Cg36yxZaIBghro-yf4DKcLWbmbvL21o9M_dJWV5gARqxibkyZDZrbMOb-3r3_AoMYAJ1iBo8aAkHJhlMNSimr-aqtCmjGEHKQTRnGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:QNpmY3E9dIRV572n1FNnXs48kLP5eFikRvqy4lAjKaD7JQUPNc3-Hw>
    <xmx:QNpmY3VzIbOolxSI_pIQnOJt6czjIdbdI0YEzJvByflcOeHTrYOz2w>
    <xmx:QNpmYyPju7kpwaWWvfD3zrAgMwOnoSiCp8__JwaKeCgi_60CgYyPpQ>
    <xmx:QNpmY9cDe-5BFzgVrDKqPDVCDqF-Br0gtMszVFcZcdPw_XOw5hiB3w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 17:48:47 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] firmware/psci: Switch to the sys-off handler API
Date:   Sat,  5 Nov 2022 16:48:40 -0500
Message-Id: <20221105214841.7828-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221105214841.7828-1-samuel@sholland.org>
References: <20221105214841.7828-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any other poweroff handlers registered at the default priority will
run before the legacy pm_power_off() function. Register the PSCI
poweroff handler with the correct priority to ensure it runs first.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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
2.37.3

