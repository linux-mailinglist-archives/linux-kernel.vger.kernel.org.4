Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD16652050
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiLTMU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiLTMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:20:44 -0500
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 04:20:37 PST
Received: from mx.mvz-labor-lb.de (mx.mvz-labor-lb.de [IPv6:2a01:4f8:c2c:899::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2D18B05;
        Tue, 20 Dec 2022 04:20:37 -0800 (PST)
Received: from webmail.labor (p57803e15.dip0.t-ipconnect.de [87.128.62.21])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mvz-labor-lb.de (Postfix) with ESMTPSA id 9D07B3E8A6;
        Tue, 20 Dec 2022 13:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mvz-labor-lb.de;
        s=mvz1903; t=1671538265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=MeF+loUfLla3SLpOMCygh1/fpaH0ayyGK6IQfRkdgm4=;
        b=I9UHBq/v2G0mw3TRViJ+kz895YLKuZjmnzFJUn/XBYQ0QNWIbUWXcrXcFgris490OqDZAG
        iIPh91gJ+PPEwdQSjnW0Ypd7TCwp/E9B3zGsNc38lbu/Vk0+caJoPRHHkXi5xaww6OI37U
        Be7wQgA5/K4lnbMbpt6Xi/GzQ0kTI1I=
Received: from localhost (localhost.localdomain [127.0.0.1])
        by webmail.labor (Postfix) with ESMTP id 144A4300C002;
        Tue, 20 Dec 2022 13:11:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at mvz-labor-lb.de
Received: from webmail.labor ([127.0.0.1])
        by localhost (webmail.labor [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sidZv4dgWY0o; Tue, 20 Dec 2022 13:11:05 +0100 (CET)
Received: from LLGMVZLB-0037 (LLGMVZLB-0037.mvz.labor [10.30.4.35])
        by webmail.labor (Postfix) with ESMTPS id E7E30300C001;
        Tue, 20 Dec 2022 13:11:04 +0100 (CET)
Date:   Tue, 20 Dec 2022 13:11:03 +0100
From:   Michael Klein <m.klein@mvz-labor-lb.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the CSL Panther
 Tab HD
Message-ID: <20221220121103.uiwn5l7fii2iggct@LLGMVZLB-0037>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the CSL Panther Tab HD.

Signed-off-by: Michael Klein <m.klein@mvz-labor-lb.de>
---
 drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index baae3120efd0..f00995390fdf 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -264,6 +264,23 @@ static const struct ts_dmi_data connect_tablet9_data = {
 	.properties     = connect_tablet9_props,
 };
 
+static const struct property_entry csl_panther_tab_hd_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 20),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1526),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-csl-panther-tab-hd.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct ts_dmi_data csl_panther_tab_hd_data = {
+	.acpi_name      = "MSSL1680:00",
+	.properties     = csl_panther_tab_hd_props,
+};
+
 static const struct property_entry cube_iwork8_air_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
@@ -1124,6 +1141,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Tablet 9"),
 		},
 	},
+	{
+		/* CSL Panther Tab HD */
+		.driver_data = (void *)&csl_panther_tab_hd_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "CSL Computer GmbH & Co. KG"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CSL Panther Tab HD"),
+		},
+	},
 	{
 		/* CUBE iwork8 Air */
 		.driver_data = (void *)&cube_iwork8_air_data,
-- 
2.37.2

