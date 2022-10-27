Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6960FF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiJ0R7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ0R7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:08 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDF1799AB;
        Thu, 27 Oct 2022 10:59:06 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 036444268490c277; Thu, 27 Oct 2022 19:59:04 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E90F066D838;
        Thu, 27 Oct 2022 19:59:03 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 10/11] ACPICA: IORT: Update for revision E.e
Date:   Thu, 27 Oct 2022 19:57:42 +0200
Message-ID: <1841510.CQOukoFCf9@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiledrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

ACPICA commit 54b54732c5fc9e0384bcfd531f3c10d3a7b628b5

The latest IORT update makes one small addition to SMMUv3 nodes to
describe MSI support independently of wired GSIV support.

Link: https://github.com/acpica/acpica/commit/54b54732
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/include/acpi/actbl2.h
===================================================================
--- linux-pm.orig/include/acpi/actbl2.h
+++ linux-pm/include/acpi/actbl2.h
@@ -375,7 +375,7 @@ struct acpi_table_ccel {
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049E.d, Feb 2022
+ * Document number: ARM DEN 0049E.e, Sep 2022
  *
  ******************************************************************************/
 
@@ -546,6 +546,7 @@ struct acpi_iort_smmu_v3 {
 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
 #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (3<<1)
 #define ACPI_IORT_SMMU_V3_PXM_VALID         (1<<3)
+#define ACPI_IORT_SMMU_V3_DEVICEID_VALID    (1<<4)
 
 struct acpi_iort_pmcg {
 	u64 page0_base_address;



