Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C469A5EEBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiI2Cd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiI2CdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:33:12 -0400
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85B1251A8;
        Wed, 28 Sep 2022 19:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1774; q=dns/txt; s=iport;
  t=1664418791; x=1665628391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUmn4h/jHcavrMs8olxHnFY+3B+4DhAb+5+8neZPgLo=;
  b=EaRGEF4OKXL5bBZ/p35JkHphhaDY9j7Ba0IljivzEXqDL0T27poUXcFw
   dVGcGB7LpbzFnB7kpVBbS1lrwAtMKQDZOtW1WK0t09ygoMs7XM4pK+wql
   BeuTt1s12k/tpNUKWf2bai8Yl6dtU2w4MPH5nIOIJC3C9OKaUJG+9JTTN
   k=;
IronPort-Data: =?us-ascii?q?A9a23=3A2okHEquGjomQFDMpJRyqOt7YyufnVHVfMUV32?=
 =?us-ascii?q?f8akzHdYApBsoF/qtZmKT/XPqyPZzOnLo8lOYW080pUsZPRmoUwGgRsqS02Q?=
 =?us-ascii?q?XwSgMeUXt7xwmUckM+xwmwvdK/shiknQoGowPscEzmN/39BDpC79SMmjfzRG?=
 =?us-ascii?q?OKlYAL5EnkZqTFMGX9JZS1Lw4bVsqYw6TSIK1vlVeHa+qUzC3f9s9JACV/43?=
 =?us-ascii?q?orYwP9ZUFsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRp?=
 =?us-ascii?q?gs1/j83Ad+j1738aEBPEvjZPBOFjTxdXK3Kbhpq/3NplP1kcqtHLx4L111ln?=
 =?us-ascii?q?PgpoDlJnZC5TwYkOrLFsO8cSBJfVSp5OMWq/ZeeeSjk65TMlBaWG5fr67A0Z?=
 =?us-ascii?q?K0sBqUc++BqESRN+OYeJTQlcB+OnaS1zai9R+0qgd4sROHvPYUCqjRjxyzYC?=
 =?us-ascii?q?foOX5/OWePJ6MVe0TN2gdpBdd7Ya8cCYCdrahXNeQZnNVAQB5Yz2uyvgxHXd?=
 =?us-ascii?q?jxTqFuR46405mz7yQVr07/zMZzTd8DibcBchU+Yp3jB7kz6DwscOdjZziCKm?=
 =?us-ascii?q?lq3i+bJ2yr9VI8ID7q+3uVni1rVzWsWYDUfVkO+if24jFOuHtxYNkoY8zYvq?=
 =?us-ascii?q?q5081akJvHxVhu5rXqssR8ZQ9dUHvM74wHL0aPSpgiDD24PTyVKb5otvYkrX?=
 =?us-ascii?q?lQCzFiDn/vqCCZpvbnTTmiSnp+frSmzIjQSNW8PIysJVwwUy9L4r5s0kwqJQ?=
 =?us-ascii?q?8sLOLG0itndGjzqxT2O6i8kiN0uYWQjv0mg1UrMjzTprZ/TQ0tloA7WRWmiq?=
 =?us-ascii?q?Ah+YeaYi0WTwQCzxZ59wEyxFzFtZEQ5pvU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALkR3UK5pZQfRW8BMTQPXwPPXdLJyesId70?=
 =?us-ascii?q?hD6qm+c3Bom6uj5qSTdZsguyMc5Ax6ZJhko6HiBEDiewK4yXcK2+gs1N6ZNW?=
 =?us-ascii?q?GMhILrFvAB0WKI+VLd8kPFm9K1/J0QFJSWcOeRMbC/5vyKmTVR1L0bsb+6zJ?=
 =?us-ascii?q?w=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A8AAB2bIJi/5BdJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBgXsIAQsBgiqBSz1DjG+lUYF8CwEBAQ9CBAEBgg6CdAKFPgIlNAkOAQI?=
 =?us-ascii?q?EAQEBEgEBBQEBAQIBBwSBCROFdYZDBjIBRhBRVwYBEoJ9gxirVoIrgQGIGYF?=
 =?us-ascii?q?lFIEoAYlDhRwnHIFJRIQIdYp/BI1TiEsDCQYHBYE+EoEhcQEIBgYHCgUyBgI?=
 =?us-ascii?q?MGBQEAhMSTQYMEgITDAoGFg4ONBIZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyM?=
 =?us-ascii?q?LAgMYCQcKAx0IChwSEBQCBBMfCwgDGh8tCQIEDgNDCAsKAxEEAxMYCxYIEAQ?=
 =?us-ascii?q?GAwkvDSgLAwUPDwEGAwYCBQUBAyADFAMFJwcDIQcLJg0NBCMdAwMFJgMCAhs?=
 =?us-ascii?q?HAgIDAgYXBgICGScxCigNCAQIBBgEHiUOBQUCBzEFBC8CHgQFBhEJAhYCBgQ?=
 =?us-ascii?q?FAgQEFgICEggCCCcbBxY2GQEFXQYLCSMWBiwRBQYWAyZSBiIdl2EBgQ4Bo0i?=
 =?us-ascii?q?CFp4qg1aBQ54tGjGDdaRilmYggiqkXYFhPIFZMxoIGxWDI1EZD5wzAVwkMTs?=
 =?us-ascii?q?CBgsBAQMJkRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1083207338"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:10 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Ys007711;
        Thu, 29 Sep 2022 02:33:09 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     xe-linux-external@cisco.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] scripts: insert-sys-cert: change name to insert-symbol
Date:   Wed, 28 Sep 2022 19:32:49 -0700
Message-Id: <20220929023301.3344694-4-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023301.3344694-1-danielwa@cisco.com>
References: <20220929023301.3344694-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the tool is used to update the command line and/or
to update the certificates, I think it makes sense to
changes the name of this tool.

Update the name of the tool to better reflect it's new use.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 scripts/Makefile                               | 2 +-
 scripts/{insert-sys-cert.c => insert-symbol.c} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename scripts/{insert-sys-cert.c => insert-symbol.c} (99%)

diff --git a/scripts/Makefile b/scripts/Makefile
index f084f08ed176..57a02ccce92c 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -9,7 +9,7 @@ hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
 hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
-hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
+hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-symbol
 
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTLDLIBS_sorttable = -lpthread
diff --git a/scripts/insert-sys-cert.c b/scripts/insert-symbol.c
similarity index 99%
rename from scripts/insert-sys-cert.c
rename to scripts/insert-symbol.c
index 77d3306cfbfb..6866e3a84974 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-symbol.c
@@ -7,7 +7,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: insert-sys-cert [-s <System.map> -b <vmlinux> -c <certfile>
+ * Usage: insert-symbol [-s <System.map> -b <vmlinux> -c <certfile>
  */
 
 #define _GNU_SOURCE
-- 
2.25.1

