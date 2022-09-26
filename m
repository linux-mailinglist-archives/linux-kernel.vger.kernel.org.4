Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4335EB203
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiIZUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIZUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:20:07 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7B933371;
        Mon, 26 Sep 2022 13:20:05 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id b2b7e29611829f54; Mon, 26 Sep 2022 22:20:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DDA7F66D6B6;
        Mon, 26 Sep 2022 22:20:03 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ACPI: docs: Drop useless DSDT override documentation
Date:   Mon, 26 Sep 2022 22:20:03 +0200
Message-ID: <5606509.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.0
X-CLIENT-HOSTNAME: 195.136.19.0
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgudegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvueeuvefhgefffeejjeeuueeutdfgtdfftdfhffehgfevuefhtefftdeuheeukeenucffohhmrghinheptddurdhorhhgnecukfhppeduleehrddufeeirdduledrtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhv
 rggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because https://01.org/linux-acpi web site has become permanently
unreachable, the "Overriding DSDT" document in the kernel tree
pointing to it as the main source of information is useless (and
the config option name mentioned by it is incorrect), so drop it
and drop the pointer to it from the ACPI Kconfig.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/acpi/dsdt-override.rst |   13 -------------
 drivers/acpi/Kconfig                             |    1 -
 2 files changed, 14 deletions(-)

Index: linux-pm/Documentation/admin-guide/acpi/dsdt-override.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/acpi/dsdt-override.rst
+++ /dev/null
@@ -1,13 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-===============
-Overriding DSDT
-===============
-
-Linux supports a method of overriding the BIOS DSDT:
-
-CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
-
-When to use this method is described in detail on the
-Linux/ACPI home page:
-https://01.org/linux-acpi/documentation/overriding-dsdt
Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -347,7 +347,6 @@ config ACPI_CUSTOM_DSDT_FILE
 	depends on !STANDALONE
 	help
 	  This option supports a custom DSDT by linking it into the kernel.
-	  See Documentation/admin-guide/acpi/dsdt-override.rst
 
 	  Enter the full path name to the file which includes the AmlCode
 	  or dsdt_aml_code declaration.



