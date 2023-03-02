Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28866A8819
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCBRtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjCBRtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:49:16 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B65C17CD6;
        Thu,  2 Mar 2023 09:49:15 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 32703731c8ccc0ca; Thu, 2 Mar 2023 18:49:13 +0100
Received: from kreacher.localnet (unknown [213.134.183.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E1AFA206173F;
        Thu,  2 Mar 2023 18:49:12 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: docs: Update the pm_profile sysfs attribute documentation
Date:   Thu, 02 Mar 2023 18:49:12 +0100
Message-ID: <12163052.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.41
X-CLIENT-HOSTNAME: 213.134.183.41
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudeljedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudekfedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekfedrgedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The list of possible pm_profile values listed in sysfs-acpi-pmprofile
does not include the tablet one (8), so update it.

While at it, rewrite the description so it is more accurate and somewhat
easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/stable/sysfs-acpi-pmprofile |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

Index: linux-pm/Documentation/ABI/stable/sysfs-acpi-pmprofile
===================================================================
--- linux-pm.orig/Documentation/ABI/stable/sysfs-acpi-pmprofile
+++ linux-pm/Documentation/ABI/stable/sysfs-acpi-pmprofile
@@ -2,16 +2,17 @@ What:		/sys/firmware/acpi/pm_profile
 Date:		03-Nov-2011
 KernelVersion:	v3.2
 Contact:	linux-acpi@vger.kernel.org
-Description:	The ACPI pm_profile sysfs interface exports the platform
-		power management (and performance) requirement expectations
-		as provided by BIOS. The integer value is directly passed as
-		retrieved from the FADT ACPI table.
+Description:	The ACPI pm_profile sysfs interface exposes the preferred
+		power management (and performance) profile of the platform
+		as provided in the ACPI FADT Preferred_PM_Profile field.
 
-Values:	        For possible values see ACPI specification:
-		5.2.9 Fixed ACPI Description Table (FADT)
-		Field: Preferred_PM_Profile
+		The integer value is directly passed as retrieved from the FADT.
 
-		Currently these values are defined by spec:
+Values:	        For the possible values refer to the Preferred_PM_Profile field
+		definition in Table 5.9 "FADT Format", Section 5.2.9 "Fixed ACPI
+		Description Table (FADT)" of the ACPI specification.
+
+		Currently (as of ACPI 6.5), the following values are defined:
 
 		== =================
 		0  Unspecified
@@ -22,5 +23,6 @@ Values:	        For possible values see
 		5  SOHO Server
 		6  Appliance PC
 		7  Performance Server
-		>7 Reserved
+		8  Tablet
+		>8 Reserved
 		== =================



