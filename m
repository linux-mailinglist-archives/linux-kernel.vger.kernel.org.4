Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CA682D58
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAaNI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAaNI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:08:27 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D623AAB;
        Tue, 31 Jan 2023 05:08:24 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id b5552f1a09772976; Tue, 31 Jan 2023 14:08:22 +0100
Received: from kreacher.localnet (unknown [213.134.183.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9515678167E;
        Tue, 31 Jan 2023 14:08:21 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 7/8] thermal: intel: intel_pch: Rename board ID symbols
Date:   Tue, 31 Jan 2023 14:08:20 +0100
Message-ID: <12166249.O9o76ZdvQC@kreacher>
In-Reply-To: <03b213dd351605d34f3d2ebc29fc3795cd2a58d2.camel@intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <2144306.Icojqenx9y@kreacher> <03b213dd351605d34f3d2ebc29fc3795cd2a58d2.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.17
X-CLIENT-HOSTNAME: 213.134.183.17
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefgedggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudekfedrudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekfedrudejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrvgdr
 sghogieslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 31, 2023 12:17:55 PM CET Zhang, Rui wrote:
> On Mon, 2023-01-30 at 20:04 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Use capitals in the names of the board ID symbols and add the PCH_
> > prefix to each of them for consistency.
> > 
> > Also rename the board_ids enum accordingly.
> > 
> > No intentional functional impact.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/thermal/intel/intel_pch_thermal.c |   54 +++++++++++++++--
> > -------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> > 
> > Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
> > +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> > @@ -135,38 +135,38 @@ static struct thermal_zone_device_ops tz
> >  	.critical = pch_critical,
> >  };
> >  
> > -enum board_ids {
> > -	board_hsw,
> > -	board_wpt,
> > -	board_skl,
> > -	board_cnl,
> > -	board_cml,
> > -	board_lwb,
> > -	board_wbg,
> > +enum pch_board_ids {
> > +	PCH_BOARD_HSW = 0,
> > +	PCH_BOARD_WPT,
> > +	PCH_BOARD_SKL,
> > +	PCH_BOARD_CNL,
> > +	PCH_BOARD_CML,
> > +	PCH_BOARD_LWB,
> > +	PCH_BOARD_WBG,
> >  };
> >  
> >  static const struct board_info {
> >  	const char *name;
> >  } board_info[] = {
> 
> Now struct board_info has "name" field only, so maybe we can remove
> struct board_info, and use a "static const char *" array instead?

Good point.

I think that the last patch in the series can be replaced with the
appended one.

> BTW, I'm building a kernel with this patch series as well as 
> https://patchwork.kernel.org/project/linux-pm/list/?series=717084,
> will update the test result later.

Thank you!

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] thermal: intel: intel_pch: Drop struct board_info

Because the only member of struct board_info is the name, the
board_info[] array of struct board_info elements can be replaced with
an array of strings.

Modify the code accordingly and drop struct board_info.

No intentional functional impact.

Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |   42 +++++++++---------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -145,37 +145,20 @@ enum pch_board_ids {
 	PCH_BOARD_WBG,
 };
 
-static const struct board_info {
-	const char *name;
-} board_info[] = {
-	[PCH_BOARD_HSW] = {
-		.name = "pch_haswell",
-	},
-	[PCH_BOARD_WPT] = {
-		.name = "pch_wildcat_point",
-	},
-	[PCH_BOARD_SKL] = {
-		.name = "pch_skylake",
-	},
-	[PCH_BOARD_CNL] = {
-		.name = "pch_cannonlake",
-	},
-	[PCH_BOARD_CML] = {
-		.name = "pch_cometlake",
-	},
-	[PCH_BOARD_LWB] = {
-		.name = "pch_lewisburg",
-	},
-	[PCH_BOARD_WBG] = {
-		.name = "pch_wellsburg",
-	},
+static const char *board_names[] = {
+	[PCH_BOARD_HSW] = "pch_haswell",
+	[PCH_BOARD_WPT] = "pch_wildcat_point",
+	[PCH_BOARD_SKL] = "pch_skylake",
+	[PCH_BOARD_CNL] = "pch_cannonlake",
+	[PCH_BOARD_CML] = "pch_cometlake",
+	[PCH_BOARD_LWB] = "pch_lewisburg",
+	[PCH_BOARD_WBG] = "pch_wellsburg",
 };
 
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	enum pch_board_ids board_id = id->driver_data;
-	const struct board_info *bi = &board_info[board_id];
 	struct pch_thermal_device *ptd;
 	u16 trip_temp;
 	int nr_trips;
@@ -249,12 +232,13 @@ read_trips:
 
 	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
 
-	ptd->tzd = thermal_zone_device_register_with_trips(bi->name, ptd->trips,
-							   nr_trips, 0, ptd,
-							   &tzd_ops, NULL, 0, 0);
+	ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
+							   ptd->trips, nr_trips,
+							   0, ptd, &tzd_ops,
+							   NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
-			bi->name);
+			board_names[board_id]);
 		err = PTR_ERR(ptd->tzd);
 		goto error_cleanup;
 	}



