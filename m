Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DFC6C5134
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCVQuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCVQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:50:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54095D895
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:50:10 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MFCGu7005417;
        Wed, 22 Mar 2023 11:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=CvbpM7WR/Bt259MLfa0S+iPS8KiWtnrCFDI2DEjN9Mw=;
 b=isjU5ftyTyQItP4ozsULwY35Z3mk3JTyt+2b4qmIPHQWH9/Arwxce4b/YRNRQ46mThQo
 GUjAN0vv+g+THVnaqJLUeynewT2hrfzd7ykcKIVpW2+gzrhFpz8ha7YEWk2C6xhvrKHG
 PvivcE4QqMkBO3m2PAmFgcfuCKYeB8+Vk5GjNIOBuJ+CMHfx+SKOH+p8gBiBnGh8O1TI
 XSTfVaByZHfbGwhs42aljcsO8Dm2WViDd1BWurWOhbjKIvgM3+jhNjkwPrx80JePCVl1
 hpuhq2pcY2/Hz4U5B9jF1oyFmf/ZW2VceBMbmLsALdqYNUkp1zW8k+5PbVYkajywooCO Sg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pdaq35kas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:49:50 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 22 Mar
 2023 11:49:48 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 22 Mar 2023 11:49:48 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9C50211D4;
        Wed, 22 Mar 2023 16:49:48 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/3] soundwire: bus: Update kernel doc for no_pm functions
Date:   Wed, 22 Mar 2023 16:49:47 +0000
Message-ID: <20230322164948.566962-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230322164948.566962-1-ckeepax@opensource.cirrus.com>
References: <20230322164948.566962-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eiduvY9ibwKfy8BCiu322qMcjZXVzvqn
X-Proofpoint-GUID: eiduvY9ibwKfy8BCiu322qMcjZXVzvqn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel doc should really have been updated when the no_pm versions
of the sdw_write/read functions were exported in commits:

commit 167790abb90f ("soundwire: export sdw_write/read_no_pm functions")
commit 62dc9f3f2fd0 ("soundwire: bus: export sdw_nwrite_no_pm and
                      sdw_nread_no_pm functions")

Add the missing kernel doc.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

New since v1.

 drivers/soundwire/bus.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3c67266f94834..f1ffb8e0839dd 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -386,6 +386,13 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
  * Read/Write IO functions.
  */
 
+/**
+ * sdw_nread_no_pm() - Read "n" contiguous SDW Slave registers with no PM
+ * @slave: SDW Slave
+ * @addr: Register address
+ * @count: length
+ * @val: Buffer for values to be read
+ */
 int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
 	struct sdw_msg msg;
@@ -403,6 +410,13 @@ int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 }
 EXPORT_SYMBOL(sdw_nread_no_pm);
 
+/**
+ * sdw_nwrite_no_pm() - Write "n" contiguous SDW Slave registers with no PM
+ * @slave: SDW Slave
+ * @addr: Register address
+ * @count: length
+ * @val: Buffer for values to be written
+ */
 int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
 	struct sdw_msg msg;
@@ -420,6 +434,12 @@ int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *
 }
 EXPORT_SYMBOL(sdw_nwrite_no_pm);
 
+/**
+ * sdw_write_no_pm() - Write a SDW Slave register with no PM
+ * @slave: SDW Slave
+ * @addr: Register address
+ * @value: Register value
+ */
 int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
 {
 	return sdw_nwrite_no_pm(slave, addr, 1, &value);
@@ -492,6 +512,11 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 }
 EXPORT_SYMBOL(sdw_bwrite_no_pm_unlocked);
 
+/**
+ * sdw_read_no_pm() - Read a SDW Slave register with no PM
+ * @slave: SDW Slave
+ * @addr: Register address
+ */
 int sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 {
 	u8 buf;
@@ -538,6 +563,9 @@ EXPORT_SYMBOL(sdw_update);
  * @addr: Register address
  * @count: length
  * @val: Buffer for values to be read
+ *
+ * This version of the function will take a PM reference to the slave
+ * device.
  */
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
@@ -562,6 +590,9 @@ EXPORT_SYMBOL(sdw_nread);
  * @addr: Register address
  * @count: length
  * @val: Buffer for values to be written
+ *
+ * This version of the function will take a PM reference to the slave
+ * device.
  */
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
@@ -584,6 +615,9 @@ EXPORT_SYMBOL(sdw_nwrite);
  * sdw_read() - Read a SDW Slave register
  * @slave: SDW Slave
  * @addr: Register address
+ *
+ * This version of the function will take a PM reference to the slave
+ * device.
  */
 int sdw_read(struct sdw_slave *slave, u32 addr)
 {
@@ -603,6 +637,9 @@ EXPORT_SYMBOL(sdw_read);
  * @slave: SDW Slave
  * @addr: Register address
  * @value: Register value
+ *
+ * This version of the function will take a PM reference to the slave
+ * device.
  */
 int sdw_write(struct sdw_slave *slave, u32 addr, u8 value)
 {
-- 
2.30.2

