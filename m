Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D256D7E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjDEOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbjDEODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:13 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6E7299;
        Wed,  5 Apr 2023 07:01:29 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 0304bcb383289d58; Wed, 5 Apr 2023 16:01:18 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E10031B4EA73;
        Wed,  5 Apr 2023 16:01:16 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 08/32] ACPICA: Update all copyrights/signons to 2023
Date:   Wed, 05 Apr 2023 15:38:21 +0200
Message-ID: <3517127.iIbC2pHGDl@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 25bddd1824b1e450829468a64bbdcb38074ba3d2

Copyright updates to 2023.

Link: https://github.com/acpica/acpica/commit/25bddd18
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acapps.h                             | 2 +-
 drivers/acpi/acpica/accommon.h                           | 2 +-
 drivers/acpi/acpica/acconvert.h                          | 2 +-
 drivers/acpi/acpica/acdebug.h                            | 2 +-
 drivers/acpi/acpica/acdispat.h                           | 2 +-
 drivers/acpi/acpica/acevents.h                           | 2 +-
 drivers/acpi/acpica/acglobal.h                           | 2 +-
 drivers/acpi/acpica/achware.h                            | 2 +-
 drivers/acpi/acpica/acinterp.h                           | 2 +-
 drivers/acpi/acpica/aclocal.h                            | 2 +-
 drivers/acpi/acpica/acmacros.h                           | 2 +-
 drivers/acpi/acpica/acnamesp.h                           | 2 +-
 drivers/acpi/acpica/acobject.h                           | 2 +-
 drivers/acpi/acpica/acopcode.h                           | 2 +-
 drivers/acpi/acpica/acparser.h                           | 2 +-
 drivers/acpi/acpica/acpredef.h                           | 2 +-
 drivers/acpi/acpica/acresrc.h                            | 2 +-
 drivers/acpi/acpica/acstruct.h                           | 2 +-
 drivers/acpi/acpica/actables.h                           | 2 +-
 drivers/acpi/acpica/acutils.h                            | 2 +-
 drivers/acpi/acpica/amlcode.h                            | 2 +-
 drivers/acpi/acpica/amlresrc.h                           | 2 +-
 drivers/acpi/acpica/dbhistry.c                           | 2 +-
 drivers/acpi/acpica/dsargs.c                             | 2 +-
 drivers/acpi/acpica/dscontrol.c                          | 2 +-
 drivers/acpi/acpica/dsdebug.c                            | 2 +-
 drivers/acpi/acpica/dsfield.c                            | 2 +-
 drivers/acpi/acpica/dsinit.c                             | 2 +-
 drivers/acpi/acpica/dsmethod.c                           | 2 +-
 drivers/acpi/acpica/dsobject.c                           | 2 +-
 drivers/acpi/acpica/dsopcode.c                           | 2 +-
 drivers/acpi/acpica/dspkginit.c                          | 2 +-
 drivers/acpi/acpica/dswexec.c                            | 2 +-
 drivers/acpi/acpica/dswload.c                            | 2 +-
 drivers/acpi/acpica/dswload2.c                           | 2 +-
 drivers/acpi/acpica/dswscope.c                           | 2 +-
 drivers/acpi/acpica/dswstate.c                           | 2 +-
 drivers/acpi/acpica/evevent.c                            | 2 +-
 drivers/acpi/acpica/evglock.c                            | 2 +-
 drivers/acpi/acpica/evgpe.c                              | 2 +-
 drivers/acpi/acpica/evgpeblk.c                           | 2 +-
 drivers/acpi/acpica/evgpeinit.c                          | 2 +-
 drivers/acpi/acpica/evgpeutil.c                          | 2 +-
 drivers/acpi/acpica/evhandler.c                          | 2 +-
 drivers/acpi/acpica/evmisc.c                             | 2 +-
 drivers/acpi/acpica/evregion.c                           | 2 +-
 drivers/acpi/acpica/evrgnini.c                           | 2 +-
 drivers/acpi/acpica/evxface.c                            | 2 +-
 drivers/acpi/acpica/evxfevnt.c                           | 2 +-
 drivers/acpi/acpica/evxfgpe.c                            | 2 +-
 drivers/acpi/acpica/evxfregn.c                           | 2 +-
 drivers/acpi/acpica/exconcat.c                           | 2 +-
 drivers/acpi/acpica/exconfig.c                           | 2 +-
 drivers/acpi/acpica/exconvrt.c                           | 2 +-
 drivers/acpi/acpica/excreate.c                           | 2 +-
 drivers/acpi/acpica/exdebug.c                            | 2 +-
 drivers/acpi/acpica/exdump.c                             | 2 +-
 drivers/acpi/acpica/exfield.c                            | 2 +-
 drivers/acpi/acpica/exfldio.c                            | 2 +-
 drivers/acpi/acpica/exmisc.c                             | 2 +-
 drivers/acpi/acpica/exmutex.c                            | 2 +-
 drivers/acpi/acpica/exnames.c                            | 2 +-
 drivers/acpi/acpica/exoparg1.c                           | 2 +-
 drivers/acpi/acpica/exoparg2.c                           | 2 +-
 drivers/acpi/acpica/exoparg3.c                           | 2 +-
 drivers/acpi/acpica/exoparg6.c                           | 2 +-
 drivers/acpi/acpica/exprep.c                             | 2 +-
 drivers/acpi/acpica/exregion.c                           | 2 +-
 drivers/acpi/acpica/exresnte.c                           | 2 +-
 drivers/acpi/acpica/exresolv.c                           | 2 +-
 drivers/acpi/acpica/exresop.c                            | 2 +-
 drivers/acpi/acpica/exserial.c                           | 2 +-
 drivers/acpi/acpica/exstore.c                            | 2 +-
 drivers/acpi/acpica/exstoren.c                           | 2 +-
 drivers/acpi/acpica/exstorob.c                           | 2 +-
 drivers/acpi/acpica/exsystem.c                           | 2 +-
 drivers/acpi/acpica/extrace.c                            | 2 +-
 drivers/acpi/acpica/exutils.c                            | 2 +-
 drivers/acpi/acpica/hwacpi.c                             | 2 +-
 drivers/acpi/acpica/hwesleep.c                           | 2 +-
 drivers/acpi/acpica/hwgpe.c                              | 2 +-
 drivers/acpi/acpica/hwsleep.c                            | 2 +-
 drivers/acpi/acpica/hwtimer.c                            | 2 +-
 drivers/acpi/acpica/hwvalid.c                            | 2 +-
 drivers/acpi/acpica/hwxface.c                            | 2 +-
 drivers/acpi/acpica/hwxfsleep.c                          | 2 +-
 drivers/acpi/acpica/nsarguments.c                        | 2 +-
 drivers/acpi/acpica/nsconvert.c                          | 2 +-
 drivers/acpi/acpica/nsdump.c                             | 2 +-
 drivers/acpi/acpica/nsdumpdv.c                           | 2 +-
 drivers/acpi/acpica/nsinit.c                             | 2 +-
 drivers/acpi/acpica/nsload.c                             | 2 +-
 drivers/acpi/acpica/nsparse.c                            | 2 +-
 drivers/acpi/acpica/nspredef.c                           | 2 +-
 drivers/acpi/acpica/nsprepkg.c                           | 2 +-
 drivers/acpi/acpica/nsrepair.c                           | 2 +-
 drivers/acpi/acpica/nsrepair2.c                          | 2 +-
 drivers/acpi/acpica/nsutils.c                            | 2 +-
 drivers/acpi/acpica/nswalk.c                             | 2 +-
 drivers/acpi/acpica/nsxfname.c                           | 2 +-
 drivers/acpi/acpica/psargs.c                             | 2 +-
 drivers/acpi/acpica/psloop.c                             | 2 +-
 drivers/acpi/acpica/psobject.c                           | 2 +-
 drivers/acpi/acpica/psopcode.c                           | 2 +-
 drivers/acpi/acpica/psopinfo.c                           | 2 +-
 drivers/acpi/acpica/psparse.c                            | 2 +-
 drivers/acpi/acpica/psscope.c                            | 2 +-
 drivers/acpi/acpica/pstree.c                             | 2 +-
 drivers/acpi/acpica/psutils.c                            | 2 +-
 drivers/acpi/acpica/pswalk.c                             | 2 +-
 drivers/acpi/acpica/psxface.c                            | 2 +-
 drivers/acpi/acpica/tbdata.c                             | 2 +-
 drivers/acpi/acpica/tbfadt.c                             | 2 +-
 drivers/acpi/acpica/tbfind.c                             | 2 +-
 drivers/acpi/acpica/tbinstal.c                           | 2 +-
 drivers/acpi/acpica/tbprint.c                            | 2 +-
 drivers/acpi/acpica/tbutils.c                            | 2 +-
 drivers/acpi/acpica/tbxface.c                            | 2 +-
 drivers/acpi/acpica/tbxfload.c                           | 2 +-
 drivers/acpi/acpica/tbxfroot.c                           | 2 +-
 drivers/acpi/acpica/utaddress.c                          | 2 +-
 drivers/acpi/acpica/utalloc.c                            | 2 +-
 drivers/acpi/acpica/utascii.c                            | 2 +-
 drivers/acpi/acpica/utbuffer.c                           | 2 +-
 drivers/acpi/acpica/utcache.c                            | 2 +-
 drivers/acpi/acpica/utcksum.c                            | 2 +-
 drivers/acpi/acpica/utcopy.c                             | 2 +-
 drivers/acpi/acpica/utdebug.c                            | 2 +-
 drivers/acpi/acpica/utdecode.c                           | 2 +-
 drivers/acpi/acpica/uteval.c                             | 2 +-
 drivers/acpi/acpica/utglobal.c                           | 2 +-
 drivers/acpi/acpica/uthex.c                              | 2 +-
 drivers/acpi/acpica/utids.c                              | 2 +-
 drivers/acpi/acpica/utinit.c                             | 2 +-
 drivers/acpi/acpica/utlock.c                             | 2 +-
 drivers/acpi/acpica/utobject.c                           | 2 +-
 drivers/acpi/acpica/utosi.c                              | 2 +-
 drivers/acpi/acpica/utpredef.c                           | 2 +-
 drivers/acpi/acpica/utprint.c                            | 2 +-
 drivers/acpi/acpica/uttrack.c                            | 2 +-
 drivers/acpi/acpica/utuuid.c                             | 2 +-
 drivers/acpi/acpica/utxface.c                            | 2 +-
 drivers/acpi/acpica/utxfinit.c                           | 2 +-
 include/acpi/acbuffer.h                                  | 2 +-
 include/acpi/acconfig.h                                  | 2 +-
 include/acpi/acexcep.h                                   | 2 +-
 include/acpi/acnames.h                                   | 2 +-
 include/acpi/acoutput.h                                  | 2 +-
 include/acpi/acpi.h                                      | 2 +-
 include/acpi/acpiosxf.h                                  | 2 +-
 include/acpi/acpixf.h                                    | 2 +-
 include/acpi/acrestyp.h                                  | 2 +-
 include/acpi/actbl.h                                     | 2 +-
 include/acpi/actbl1.h                                    | 2 +-
 include/acpi/actbl2.h                                    | 2 +-
 include/acpi/actbl3.h                                    | 2 +-
 include/acpi/actypes.h                                   | 2 +-
 include/acpi/acuuid.h                                    | 2 +-
 include/acpi/platform/acenv.h                            | 2 +-
 include/acpi/platform/acenvex.h                          | 2 +-
 include/acpi/platform/acgcc.h                            | 2 +-
 include/acpi/platform/acgccex.h                          | 2 +-
 include/acpi/platform/aclinux.h                          | 2 +-
 include/acpi/platform/aclinuxex.h                        | 2 +-
 tools/power/acpi/common/cmfsize.c                        | 2 +-
 tools/power/acpi/common/getopt.c                         | 2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixdir.c  | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixmap.c  | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixxf.c   | 2 +-
 tools/power/acpi/tools/acpidump/acpidump.h               | 2 +-
 tools/power/acpi/tools/acpidump/apdump.c                 | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 tools/power/acpi/tools/acpidump/apmain.c                 | 2 +-
 174 files changed, 174 insertions(+), 174 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 0a50b4912515..9d4cbd956627 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index bb329e34ee7d..4536dc9d3979 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -3,7 +3,7 @@
  *
  * Name: accommon.h - Common include files for generation of ACPICA source
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
index 476d21e67767..c6ba6a36cfb5 100644
--- a/drivers/acpi/acpica/acconvert.h
+++ b/drivers/acpi/acpica/acconvert.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index d629716aa5b2..22f1f7a9e5a3 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -3,7 +3,7 @@
  *
  * Name: acdebug.h - ACPI/AML debugger
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index fe2c3630a38d..73eecbf62f06 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -3,7 +3,7 @@
  *
  * Name: acdispat.h - dispatcher (parser to interpreter interface)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 922f559a3e59..ddd072cbc738 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -3,7 +3,7 @@
  *
  * Name: acevents.h - Event subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 777457a58340..778241173ed4 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -3,7 +3,7 @@
  *
  * Name: acglobal.h - Declarations for global variables
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 6f2787506b50..ebf8fd373cf7 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -3,7 +3,7 @@
  *
  * Name: achware.h -- hardware specific interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 6bdf133a2767..955114c926bd 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -3,7 +3,7 @@
  *
  * Name: acinterp.h - Interpreter subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 901b1543b869..2b876dac7558 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -3,7 +3,7 @@
  *
  * Name: aclocal.h - Internal data types used across the ACPI subsystem
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 2f3e609df47d..de83dd22292b 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -3,7 +3,7 @@
  *
  * Name: acmacros.h - C macros for the entire subsystem.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 7b27b9cc5916..9448bc026b9b 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -3,7 +3,7 @@
  *
  * Name: acnamesp.h - Namespace subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 6af5dc995085..1bdfeee5d7c5 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -3,7 +3,7 @@
  *
  * Name: acobject.h - Definition of union acpi_operand_object  (Internal object only)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index a224926bd9c8..da96d80e6b3a 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -3,7 +3,7 @@
  *
  * Name: acopcode.h - AML opcode information for the AML parser and interpreter
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 4511c2bd8bc3..6dad786a382c 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acparser.h - AML Parser subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index f7d65a20026b..e64aabe3d33a 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -3,7 +3,7 @@
  *
  * Name: acpredef - Information table for ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index f7749c63d277..c2e6c8455587 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -3,7 +3,7 @@
  *
  * Name: acresrc.h - Resource Manager function prototypes
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index b859de96a1e4..f8fee94ba708 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -3,7 +3,7 @@
  *
  * Name: acstruct.h - Internal structs
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 1c29325e4c7f..b6ae979b01b6 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -3,7 +3,7 @@
  *
  * Name: actables.h - ACPI table management
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 71175b664f49..dd060844189e 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -3,7 +3,7 @@
  *
  * Name: acutils.h -- prototypes for the common (subsystem-wide) procedures
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 62a7ec277513..effe52b40dce 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -5,7 +5,7 @@
  *                   Declarations and definitions contained herein are derived
  *                   directly from the ACPI specification.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index b31779ce204a..89093111bfd2 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -3,7 +3,7 @@
  *
  * Module Name: amlresrc.h - AML resource descriptors
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index 105e6ceaa887..e874c1dddefa 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dbhistry - debugger HISTORY command
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 2963d1579c05..4354c175e12e 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -4,7 +4,7 @@
  * Module Name: dsargs - Support for execution of dynamic arguments for static
  *                       objects (regions, fields, buffer fields, etc.)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 8492619149d1..80c69af06948 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -4,7 +4,7 @@
  * Module Name: dscontrol - Support for execution control opcodes -
  *                          if/else/while/return
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 2d99ccf5bde7..c5c8380a3114 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsdebug - Parser/Interpreter interface - debugging
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index de175f1b4beb..532401ecdab0 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsfield - Dispatcher field routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index dffd54fdbd51..6e0e362e461f 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsinit - Object initialization namespace walk
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 9332bc688713..e809c2aed78a 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsmethod - Parser/Interpreter interface - control method parsing
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index e3dfc734ace9..555f148d666b 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsobject - Dispatcher object management routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 2b9b6a974ca9..dd3059000885 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsopcode - Dispatcher support for regions and fields
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index 1624d6e7dc46..ecf793fe9919 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dspkginit - Completion of deferred package initialization
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index b082eb942a0f..a43336f05206 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -4,7 +4,7 @@
  * Module Name: dswexec - Dispatcher method execution callbacks;
  *                        dispatch to interpreter.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 9f6573646ab5..f7b8496c8bdd 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload - Dispatcher first pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 778df616aaa0..541235f498c2 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload2 - Dispatcher second pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 634b9100f674..1fdd07ae862c 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswscope - Scope stack manipulation
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 0aa735d3b93c..95af370a7dce 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswstate - Dispatcher parse tree walk management routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 82d1728b9bc6..015a3338a732 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evevent - Fixed Event handling and dispatch
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 9aab54797ded..989dc01af03f 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evglock - Global Lock support
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index a6bb480d631c..934b201d3820 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpe - General Purpose Event handling and dispatch
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 39fe4566310b..58e1890ab25b 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeblk - GPE block creation and initialization.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 2f1a75fee61c..0dbc4d88919a 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeinit - System GPE initialization and update
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index c32eb57aa21d..ee3b1ea656d4 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeutil - GPE utilities
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index be9a05498adc..1c8cb6d924df 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evhandler - Support for Address Space handlers
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 6172cddc1b39..e68e876d3b84 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evmisc - Miscellaneous event manager support functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index d035092799eb..18fdf2bc2d49 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evregion - Operation Region support
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 792d1a5f0052..46d1b3f5582d 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evrgnini- ACPI address_space (op_region) init
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 18219abba108..24fa6433d562 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxface - External interfaces for ACPI events
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 8187b081e0a6..48bf845191d2 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfevnt - External Interfaces, ACPI event disable/enable
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 340947e412bb..4eeeb3b7ab7e 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfgpe - External Interfaces for General Purpose Events (GPEs)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index a5c19f46ec17..3197e6303c5b 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -4,7 +4,7 @@
  * Module Name: evxfregn - External Interfaces, ACPI Operation Regions and
  *                         Address Spaces.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
index 66201742f499..2fb78b35565b 100644
--- a/drivers/acpi/acpica/exconcat.c
+++ b/drivers/acpi/acpica/exconcat.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconcat - Concatenate-type AML operators
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index e82faabdf907..473115309860 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconfig - Namespace reconfiguration (Load/Unload opcodes)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 8de5d47ad485..3729bf3b74f7 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconvrt - Object conversion routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index fb2453fa9442..1bea9d97652c 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: excreate - Named object creation
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index 8a99aadb9d15..3f86bfada510 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdebug - Support for stores to the AML Debug Object
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 24b3d041b3e5..2e2da8790224 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdump - Interpreter debug output routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 657f4002f9dc..61ff36189ace 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfield - AML execution - field_unit read/write
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index d769cea1468b..cf6c812a8b6d 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfldio - Aml Field I/O
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index b4bac8c60a13..c6f2a9166ac0 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmisc - ACPI AML (p-code) execution - specific opcodes
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index e9dcfa1e93eb..65c487facdda 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmutex - ASL Mutex Acquire/Release functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 318eb769058d..9a448165bfeb 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exnames - interpreter/scanner name load/execute
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index d108a1a86f12..20fb34b68bee 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg1 - AML execution - opcodes with 1 argument
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index ebf7c89d52d9..743c258bf2e8 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg2 - AML execution - opcodes with 2 arguments
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 4b069bd6bc71..d3091f619909 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg3 - AML execution - opcodes with 3 arguments
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 2a506ef386cf..1af35e143ba9 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg6 - AML execution - opcodes with 6 arguments
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 08f06797386a..08196fa17080 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exprep - ACPI AML field prep utilities
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 6d4a4cc14850..8907b8bf4267 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exregion - ACPI default op_region (address space) handlers
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index b81506d73447..873de01b8ad2 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresnte - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 61ee7fb46006..24a78b5e266c 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresolv - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 3342780230af..3a437e6ace5c 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresop - AML Interpreter operand/object resolution
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index fd63f2042514..5d99b1a76c83 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exserial - field_unit support for serial address spaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index f99e8cf27a6c..575c7a39f1aa 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstore - AML Interpreter object store support
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index c848b328e760..b01ae015e1b5 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -4,7 +4,7 @@
  * Module Name: exstoren - AML Interpreter object store support,
  *                        Store to Node (namespace object)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 45c757bbf9a9..37c3131a82fa 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstorob - AML object store support, store to object
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 7b5470f404f3..f665ffd9a396 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exsystem - Interface to OS services
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index b570d7a7e134..f1730221ff13 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -3,7 +3,7 @@
  *
  * Module Name: extrace - Support for interpreter execution tracing
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 87f01ce1c1aa..f4d4a033f166 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exutils - interpreter/scanner utilities
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 2f1c2fc8bd2a..790f342dcd25 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwacpi - ACPI Hardware Initialization/Mode Interface
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index d8597e052912..a9ba9190408b 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -4,7 +4,7 @@
  * Name: hwesleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                    extended FADT-V5 sleep registers.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 13d54a48e6e9..e0c847ab8324 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwgpe - Low level GPE enable/disable/clear functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 37b3f641feaa..c4d7c29f398e 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -4,7 +4,7 @@
  * Name: hwsleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                   original/legacy sleep/PM registers.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 46f3ae03ab99..192c04b5a599 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -3,7 +3,7 @@
  *
  * Name: hwtimer.c - ACPI Power Management Timer Interface
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 0d392e7b0747..b8de458f0368 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwvalid - I/O request validation
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 55d9b897e70f..c31f803995c6 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwxface - Public ACPICA hardware interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index aff51ceea02c..36ea48f64110 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -3,7 +3,7 @@
  *
  * Name: hwxfsleep.c - ACPI Hardware Sleep/Wake External Interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index 22586b90e532..3efb46f0dc54 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsarguments - Validation of args for ACPI predefined methods
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index b02555fe38f0..7e5a683ae957 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -4,7 +4,7 @@
  * Module Name: nsconvert - Object conversions for objects returned by
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index f154824d4eb6..90a26cb0c472 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index b9a88b7b518b..fa116ebe49a3 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 3e6207ad18d8..86d126fdb27d 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsinit - namespace initialization
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 880260a30c0c..fcb9de0f77a2 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsload - namespace loading/expanding/contracting procedures
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 4b893676ab5c..31e551cf4ea6 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsparse - namespace interface to AML parser
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index c0db6690bb32..cf57bd69616d 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nspredef - Validation of ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 82932c9a774b..dd37fc108fce 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsprepkg - Validation of package objects for predefined names
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index ec512e06a48e..b8657004190d 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsrepair - Repair for objects returned by predefined methods
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 957d7eb4861f..1bb7b71f07f1 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -4,7 +4,7 @@
  * Module Name: nsrepair2 - Repair for objects returned by specific
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index ef531b145add..06ffdb6808f5 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -4,7 +4,7 @@
  * Module Name: nsutils - Utilities for accessing ACPI namespace, accessing
  *                        parents and siblings and Scope manipulation
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 82a0dae349e2..eee396a77bae 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nswalk - Functions for walking the ACPI namespace
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index a0592d15dd37..5d5bcf165298 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -4,7 +4,7 @@
  * Module Name: nsxfname - Public interfaces to the ACPI subsystem
  *                         ACPI Namespace oriented interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index f7ec5606098c..422c074ed289 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psargs - Parse AML opcode arguments
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 840512fa9fc6..d0fd55636129 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psloop - Main AML parse loop
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index bca249e67c6b..54471083ba54 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psobject - Support for parse objects
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index bef69e87a0a2..09029fe545f1 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopcode - Parser/Interpreter opcode information table
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index f10afe699ad7..bccf606e08b4 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopinfo - AML opcode information functions and dispatch tables
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index ba93f359760a..10a072953d78 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psparse - Parser top level AML parse routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 400f001631ea..a0035bde7556 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psscope - Parser scope stack management routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 3012a9342367..7f7f5ecd4011 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pstree - Parser op tree manipulation/traversal/search
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 49b39aeded12..d550c4af4702 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psutils - Parser miscellaneous utilities (Parser only)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index 7735a01dab90..d92817c72b8d 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pswalk - Parser routines to walk parsed op tree(s)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index a6509aeb2955..6f4eace0ba69 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psxface - Parser external interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 1f7677e0dbbe..a1f10e4409a3 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbdata - Table manager data structure functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index f04dc6051320..44267a92bce5 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfadt   - FADT table utilities
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index c31a5ddb0ffd..1c1b2e284bd9 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfind   - find table
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 499efcaf798d..0dc003c20e4d 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbinstal - ACPI table installation and removal
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index f07aa9b46f3f..58b02e4b254b 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbprint - Table output utilities
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 17ad9c227d42..cfe50c53ad4d 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbutils - ACPI Table utilities
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 37da09dca940..275b52dc42e9 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxface - ACPI table-oriented external interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 258796e02be1..0f2a7343de3a 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfload - Table load/unload external interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 53afd75bbc06..5b413bbab338 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfroot - Find the root ACPI table (RSDT)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index 915321806cd7..be94d2fd99a7 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utaddress - op_region address range check
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 2bab6017d827..c1fb70457e20 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utalloc - local memory allocation routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
index 72fb7e9ec485..2be37676edd7 100644
--- a/drivers/acpi/acpica/utascii.c
+++ b/drivers/acpi/acpica/utascii.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utascii - Utility ascii functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 59c4050b8e91..b054bb5eeaf0 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utbuffer - Buffer dump routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 5425968dd2a8..85a85f7cf750 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcache - local cache allocation routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
index c166e4c05ab6..b483894c3629 100644
--- a/drivers/acpi/acpica/utcksum.c
+++ b/drivers/acpi/acpica/utcksum.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcksum - Support generating table checksums
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 63c17f420fb8..2e17e657dfa4 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcopy - Internal to external object translation utilities
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 64ed546cf19c..1bbba8585fa6 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdebug - Debug print/trace routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 3176393a729d..95a4b7509e01 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdecode - Utility decoding routines (value-to-string)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index df20d46ed8b7..3e5173d03953 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uteval - Object evaluation
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 53afa5edb6ec..ae46cef891e2 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utglobal - Global variables for the ACPI subsystem
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index c811ee2a8160..e62802791dcf 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uthex -- Hex/ASCII support functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index b6caab49f1bd..15c2ce91d403 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utids - support for device Ids - HID, UID, CID, SUB, CLS
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 18177e4f26f7..92fbaef161a7 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utinit - Common ACPI subsystem initialization
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 84abdbf5cfca..ee6d72385c5c 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utlock - Reader/Writer lock interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index d3667bfff401..f4aae8f0d3a8 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utobject - ACPI object create/delete/size/cache routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index b8ab0a3cb5b9..251bd396c6fd 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utosi - Support for the _OSI predefined control method
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 2524f013be7a..29d2977d0746 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utpredef - support functions for predefined names
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index d5aa2109847f..42b30b9f9312 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utprint - Formatted printing routines
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index a06988ac409d..f5f5da441458 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uttrack - Memory allocation tracking routines (debug only)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index e24bc670b53e..8f10b413e928 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utuuid -- UUID support functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 86e76b443da7..aa2e923462b7 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxface - External interfaces, miscellaneous utility functions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index f2acec3a0ee3..1915bec2b279 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxfinit - External interfaces for ACPICA initialization
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 8cbfcbca7b7e..252b235dce5a 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -3,7 +3,7 @@
  *
  * Name: acbuffer.h - Support for buffers returned by ACPI predefined names
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 151e40385673..d768d9c568cf 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -3,7 +3,7 @@
  *
  * Name: acconfig.h - Global configuration constants
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 28943c900be7..c5ecd0a0170c 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -3,7 +3,7 @@
  *
  * Name: acexcep.h - Exception codes returned by the ACPI subsystem
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 6f22e92b1744..d71291f25a80 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -3,7 +3,7 @@
  *
  * Name: acnames.h - Global names and strings
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 73781aae2119..b1571dd96310 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -3,7 +3,7 @@
  *
  * Name: acoutput.h -- debug output
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index 416e59bcf149..8b4a497c1300 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -3,7 +3,7 @@
  *
  * Name: acpi.h - Master public include file used to interface to ACPICA
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 52844cc5eeb5..914c029f64c9 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -5,7 +5,7 @@
  *                    interfaces must be implemented by OSL to interface the
  *                    ACPI components to the host operating system.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 8e364cbdd14a..c961f0d99c5e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -3,7 +3,7 @@
  *
  * Name: acpixf.h - External interfaces to the ACPI subsystem
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index a7fb8ddb3dc6..e5c875f91203 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -3,7 +3,7 @@
  *
  * Name: acrestyp.h - Defines, types, and structures for resource descriptors
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index c6af579f74f4..e5dfb6f4de52 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl.h - Basic ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b5e011da5271..7a3ad28b86c6 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl1.h - Additional ACPI table definitions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index b082175906ba..e0f205f9ab4c 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl2.h - ACPI Table Definitions (tables not in ACPI spec)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 832c6464f063..f51c46f4e3e4 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl3.h - ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 46878cbb7d39..ce1db1c2e9d3 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -3,7 +3,7 @@
  *
  * Name: actypes.h - Common data types for the entire ACPI subsystem
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 171bb0b708a2..52a84523bfac 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -3,7 +3,7 @@
  *
  * Name: acuuid.h - ACPI-related UUID/GUID definitions
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 9e4f7564201a..0fa7bbf85c83 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -3,7 +3,7 @@
  *
  * Name: acenv.h - Host and compiler configuration
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 72cc7bab469e..7e67e3503f7b 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -3,7 +3,7 @@
  *
  * Name: acenvex.h - Extra host and compiler configuration
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index ac80111f503c..c9d418f9395e 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -3,7 +3,7 @@
  *
  * Name: acgcc.h - GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgccex.h b/include/acpi/platform/acgccex.h
index 302ea1b724b9..7c9f10e9633a 100644
--- a/include/acpi/platform/acgccex.h
+++ b/include/acpi/platform/acgccex.h
@@ -3,7 +3,7 @@
  *
  * Name: acgccex.h - Extra GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 14ac657a7ded..66285e054e1e 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinux.h - OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 28c72744decf..600d4e2641da 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinuxex.h - Extra OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index 38f9b9da8170..68b9ea86b86c 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -3,7 +3,7 @@
  *
  * Module Name: cmfsize - Common get file size function
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 96fd6cec78e2..6a0cdba6fdfd 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: getopt
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index bd08f36df4a7..9d70d8c945af 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -3,7 +3,7 @@
  *
  * Module Name: oslinuxtbl - Linux OSL for obtaining ACPI tables
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index 5107892d054b..39f3bffd9355 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixdir - Unix directory access interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index 6ff4edd8dc3b..2b7d56252684 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixmap - Unix OSL for file mappings
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index b3651a04d68c..46429417c71a 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixxf - UNIX OSL interfaces
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 153249c87fd7..643e3e722340 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acpidump.h - Include file for acpi_dump utility
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index ea44b0ed5dcb..0742b00b61a1 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apdump - Dump routines for ACPI tables (acpidump)
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 2d9b45a9b526..13817f9112c0 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apfiles - File-related functions for acpidump utility
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 44b23fc53dd9..666a9675e743 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apmain - Main module for the acpidump utility
  *
- * Copyright (C) 2000 - 2022, Intel Corp.
+ * Copyright (C) 2000 - 2023, Intel Corp.
  *
  *****************************************************************************/
 
-- 
2.35.3





