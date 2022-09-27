Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62815EC58B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiI0OKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiI0OJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:09:33 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E691BB21A;
        Tue, 27 Sep 2022 07:09:16 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id e61f74234d24f0c6; Tue, 27 Sep 2022 16:09:14 +0200
Received: from kreacher.localnet (public-gprs524514.centertel.pl [31.61.168.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E783B66D739;
        Tue, 27 Sep 2022 16:09:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [Update][PATCH] MAINTEINERS: Drop records pointing to 01.org/linux-acpi
Date:   Tue, 27 Sep 2022 16:09:13 +0200
Message-ID: <5618537.DvuYhMxLoT@kreacher>
In-Reply-To: <2648886.mvXUDI8C0e@kreacher>
References: <2648886.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 31.61.168.35
X-CLIENT-HOSTNAME: public-gprs524514.centertel.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepleevudevgfdvieeftefhkeevgfekveetueevfeektddujefhieekudetjeegheffnecuffhomhgrihhnpedtuddrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeefuddriedurdduieekrdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddriedurdduieekrdefhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhp
 rghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] MAINTEINERS: Drop records pointing to 01.org/linux-acpi

The https://01.org/linux-acpi web site has become permanently
inaccessible, so drop the records pointing to it from MAINTAINERS.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The previous version of this patch was missing one affected entry.

---
 MAINTAINERS |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -348,7 +348,6 @@ M:	"Rafael J. Wysocki" <rafael@kernel.or
 R:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
-W:	https://01.org/linux-acpi
 Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
@@ -427,7 +426,6 @@ M:	Rafael J. Wysocki <rafael@kernel.org>
 R:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
-W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
 F:	drivers/acpi/*thermal*
 
@@ -10379,7 +10377,6 @@ INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
-W:	https://01.org/linux-acpi
 F:	drivers/thermal/intel/intel_menlow.c
 
 INTEL P-Unit IPC DRIVER




