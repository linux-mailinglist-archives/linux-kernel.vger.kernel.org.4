Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2ED67CBB9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjAZNNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjAZNNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:13:48 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC865EDA;
        Thu, 26 Jan 2023 05:13:46 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id cd0bcdb537e2997b; Thu, 26 Jan 2023 14:13:44 +0100
Received: from kreacher.localnet (unknown [213.134.163.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B32E9781613;
        Thu, 26 Jan 2023 14:13:43 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/3] thermal: intel: int340x: Use generic trip points table
Date:   Thu, 26 Jan 2023 14:13:43 +0100
Message-ID: <5926007.lOV4Wx5bFT@kreacher>
In-Reply-To: <10ad845597c47b8b7d1ba1aa9fe93825d249f56e.camel@linux.intel.com>
References: <5665899.DvuYhMxLoT@kreacher> <CAJZ5v0iVqGoVq1TVvYoQLxRWnP1nTPe7seeQvbVPancxH_6J1g@mail.gmail.com> <10ad845597c47b8b7d1ba1aa9fe93825d249f56e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.174
X-CLIENT-HOSTNAME: 213.134.163.174
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudeifedrudejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddujeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
 rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 26, 2023 1:02:59 AM CET srinivas pandruvada wrote:
> Hi Rafael,
> 
> 
> On Wed, 2023-01-25 at 16:20 +0100, Rafael J. Wysocki wrote:
> > Hi Srinivas,
> > 
> > On Wed, Jan 25, 2023 at 3:55 PM Rafael J. Wysocki <rjw@rjwysocki.net>
> > wrote:
> > > 
> > > Hi All,
> > > 
> > > This series replaces the following patch:
> > > 
> > > https://patchwork.kernel.org/project/linux-pm/patch/2147918.irdbgypaU6@kreacher/
> > > 
> > > but it has been almost completely rewritten, so I've dropped all
> > > tags from it.
> > > 
> > > 
> 
> [...]
> 
> > > The series is on top of this patch:
> > > 
> > > https://patchwork.kernel.org/project/linux-pm/patch/2688799.mvXUDI8C0e@kreacher/
> > > 
> > > which applies on top of the linux-next branch in linux-pm.git from
> > > today.
> > 
> > There are two additional branches in linux-pm.git:
> > 
> > thermal-intel-fixes
> On two systems test, no issues are observed.

Great!  I'll move this to linux-next then.

> > thermal-intel-testing
> branch: thermal-intel-test
> 
> No issues, but number of trips are not same as invalid trips are not
> registered.
> Not sure if this is correct.

It may not be.  At least it is a change in behavior that is not expected to
happen after these changes.

> At boot up they may be invalid, but
> firmware may update later (Not aware of such scenario).
> 
> For example, the hot is not registered.
> 
> Current:
> 
> thermal_zone9/trip_point_0_type:critical
> thermal_zone9/trip_point_0_temp:125050
> thermal_zone9/trip_point_0_hyst:0
> 
> thermal_zone9/trip_point_1_type:hot
> thermal_zone9/trip_point_1_temp:-273250
> thermal_zone9/trip_point_1_hyst:0

So this means that _HOT is evaluated successfully (or the trip point index
would be negative), but it probably returned an invalid temperature (likely 0)
that has been turned into an error by the temperature range check in the
new ACPI helper introduced by the change.

OK, thanks for testing!

I've added the appended patch to the thermal-intel-test branch.  Can you please
check if it makes that difference in behavior go away?

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] thermal: ACPI: Initialize trips if temperature is out of range

In some cases it is still useful to register a trip point if the
temperature returned by the corresponding ACPI thermal object (for
example, _HOT) is invalid to start with, because the same ACPI
thermal object may start to return a valid temperature after a
system configuration change (for example, from an AC power source
to battery an vice versa).

For this reason, if the ACPI thermal object evaluated by
thermal_acpi_trip_init() successfully returns a temperature value that
is out of the range of values taken into account, initialize the trip
point using THERMAL_TEMP_INVALID as the temperature value instead of
returning an error to allow the user of the trip point to decide what
to do with it.

Also update pch_wpt_add_acpi_psv_trip() to reject trip points with
invalid temperature values.

Fixes: 7a0e39748861 ("thermal: ACPI: Add ACPI trip point routines")
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |    2 +-
 drivers/thermal/thermal_acpi.c            |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_acpi.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_acpi.c
+++ linux-pm/drivers/thermal/thermal_acpi.c
@@ -64,13 +64,14 @@ static int thermal_acpi_trip_init(struct
 		return -ENODATA;
 	}
 
-	if (temp < TEMP_MIN_DECIK || temp >= TEMP_MAX_DECIK) {
+	if (temp >= TEMP_MIN_DECIK && temp <= TEMP_MAX_DECIK) {
+		trip->temperature = deci_kelvin_to_millicelsius(temp);
+	} else {
 		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
 				  obj_name, temp);
-		return -ENODATA;
+		trip->temperature = THERMAL_TEMP_INVALID;
 	}
 
-	trip->temperature = deci_kelvin_to_millicelsius(temp);
 	trip->hysteresis = 0;
 	trip->type = type;
 
Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -107,7 +107,7 @@ static void pch_wpt_add_acpi_psv_trip(st
 		return;
 
 	ret = thermal_acpi_trip_passive(adev, &ptd->trips[*nr_trips]);
-	if (ret)
+	if (ret || ptd->trips[*nr_trips].temperature <= 0)
 		return;
 
 	++(*nr_trips);



