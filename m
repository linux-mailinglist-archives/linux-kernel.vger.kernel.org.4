Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5E745CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGCNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGCNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:01:31 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DDCA;
        Mon,  3 Jul 2023 06:01:30 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qGJBG-007U36-UD; Mon, 03 Jul 2023 14:01:26 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qGJBG-004BQD-27;
        Mon, 03 Jul 2023 14:01:26 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     acpica-devel@lists.linuxfoundation.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, nvdimm@lists.linux.dev,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ACPICA: actbl2: change to be16/be32 types for big endian data
Date:   Mon,  3 Jul 2023 14:01:25 +0100
Message-Id: <20230703130125.997208-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the fields in struct acpi_nfit_control_region are used in big
endian format, and thus are generatng warnings from spare where the
member is passed to one of the conversion functions.

Fix the following sparse warnings by changing the data types:

drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1468:41: warning: cast to restricted __le16
drivers/acpi/nfit/core.c:1502:41: warning: cast to restricted __le16
drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/acpi/nfit/core.c |  8 ++++----
 include/acpi/actbl2.h    | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 07204d482968..0fcc247fdfac 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2194,15 +2194,15 @@ static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
 /* enough info to uniquely specify an interleave set */
 struct nfit_set_info {
 	u64 region_offset;
-	u32 serial_number;
+	__be32 serial_number;
 	u32 pad;
 };
 
 struct nfit_set_info2 {
 	u64 region_offset;
-	u32 serial_number;
-	u16 vendor_id;
-	u16 manufacturing_date;
+	__be32 serial_number;
+	__be16 vendor_id;
+	__be16 manufacturing_date;
 	u8 manufacturing_location;
 	u8 reserved[31];
 };
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0029336775a9..c1df59aa8855 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1716,18 +1716,18 @@ struct acpi_nfit_smbios {
 struct acpi_nfit_control_region {
 	struct acpi_nfit_header header;
 	u16 region_index;
-	u16 vendor_id;
-	u16 device_id;
-	u16 revision_id;
-	u16 subsystem_vendor_id;
-	u16 subsystem_device_id;
-	u16 subsystem_revision_id;
+	__be16 vendor_id;
+	__be16 device_id;
+	__be16  revision_id;
+	__be16 subsystem_vendor_id;
+	__be16 subsystem_device_id;
+	__be16 subsystem_revision_id;
 	u8 valid_fields;
 	u8 manufacturing_location;
-	u16 manufacturing_date;
+	__be16 manufacturing_date;
 	u8 reserved[2];		/* Reserved, must be zero */
-	u32 serial_number;
-	u16 code;
+	__be32 serial_number;
+	__le16 code;
 	u16 windows;
 	u64 window_size;
 	u64 command_offset;
-- 
2.40.1

