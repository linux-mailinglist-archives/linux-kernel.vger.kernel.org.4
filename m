Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F41638C02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKYOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKYOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:21:47 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C323157
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:21:46 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AP8g14d009072;
        Fri, 25 Nov 2022 08:20:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Hf+p2XLDxtDu0bixw/WcTYV02K3jKz11jQ4Wh7jZWhs=;
 b=JNbcaxIq890baQYfRP7F1/m0qJBfIKzCHx/iWaXRDWaEJ3gEKV6fmFydkme2QwFY4abH
 FW16PxoQGsQvUurmsm+2KoVD5L7DhiY1VJWYGcAdeCU/2G5UjeI7EwFIazH4CdpNlbab
 AzvNxf1ycQjR6nrQhdTMSbtQgnwCHAOeEz0SsjJCvWSZxDYCtZG8YkyaLDW37HdqaLdV
 uGLYfuPojsKQAOpOAi1pOKrNzWdaKB63KSWQa2AR+URNqNzmvRhTTsqPXskKHkjDr7ZA
 WUgTc89qYhsP6Sc7d24fLqrGup5nQZTR9mizO/0uixx2WwraqcP4ejeEU2KcaAqHlDe3 DQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet7ccp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 08:20:30 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 25 Nov
 2022 08:20:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 25 Nov 2022 08:20:29 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F523B10;
        Fri, 25 Nov 2022 14:20:29 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v4 2/4] soundwire: Provide build stubs for common functions
Date:   Fri, 25 Nov 2022 14:20:26 +0000
Message-ID: <20221125142028.1118618-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221125142028.1118618-1-ckeepax@opensource.cirrus.com>
References: <20221125142028.1118618-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -RykCZ5n6tuVbhrgytsuMh0k7okAmOu6
X-Proofpoint-GUID: -RykCZ5n6tuVbhrgytsuMh0k7okAmOu6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
that are quite likely to be used from common code on devices supporting
multiple control buses.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v3:
 - Return error code and add WARN_ONCE in build stubs. Note I returned
   EINVAL rather than the discussed ENOSYS since it turns out checkpatch
   informs me I really shouldn't be returning ENOSYS :-)

Thanks,
Charles

 include/linux/soundwire/sdw.h | 105 ++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 10 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 902ed46f76c80..132a0ee97b804 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -4,6 +4,7 @@
 #ifndef __SOUNDWIRE_H
 #define __SOUNDWIRE_H
 
+#include <linux/bug.h>
 #include <linux/mod_devicetable.h>
 #include <linux/bitfield.h>
 
@@ -1021,15 +1022,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 		struct sdw_port_config *port_config,
 		unsigned int num_ports,
 		struct sdw_stream_runtime *stream);
-int sdw_stream_add_slave(struct sdw_slave *slave,
-		struct sdw_stream_config *stream_config,
-		struct sdw_port_config *port_config,
-		unsigned int num_ports,
-		struct sdw_stream_runtime *stream);
 int sdw_stream_remove_master(struct sdw_bus *bus,
 		struct sdw_stream_runtime *stream);
-int sdw_stream_remove_slave(struct sdw_slave *slave,
-		struct sdw_stream_runtime *stream);
 int sdw_startup_stream(void *sdw_substream);
 int sdw_prepare_stream(struct sdw_stream_runtime *stream);
 int sdw_enable_stream(struct sdw_stream_runtime *stream);
@@ -1040,8 +1034,20 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus);
 int sdw_bus_clk_stop(struct sdw_bus *bus);
 int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
 
-/* messaging and data APIs */
+int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
+void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
 
+#if IS_ENABLED(CONFIG_SOUNDWIRE)
+
+int sdw_stream_add_slave(struct sdw_slave *slave,
+			 struct sdw_stream_config *stream_config,
+			 struct sdw_port_config *port_config,
+			 unsigned int num_ports,
+			 struct sdw_stream_runtime *stream);
+int sdw_stream_remove_slave(struct sdw_slave *slave,
+			    struct sdw_stream_runtime *stream);
+
+/* messaging and data APIs */
 int sdw_read(struct sdw_slave *slave, u32 addr);
 int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
@@ -1053,7 +1059,86 @@ int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *
 int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
 int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
 
-int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
-void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
+#else
+
+static inline int sdw_stream_add_slave(struct sdw_slave *slave,
+				       struct sdw_stream_config *stream_config,
+				       struct sdw_port_config *port_config,
+				       unsigned int num_ports,
+				       struct sdw_stream_runtime *stream)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_stream_remove_slave(struct sdw_slave *slave,
+					  struct sdw_stream_runtime *stream)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+/* messaging and data APIs */
+static inline int sdw_read(struct sdw_slave *slave, u32 addr)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_write(struct sdw_slave *slave, u32 addr, u8 value)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+static inline int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
+{
+	WARN_ONCE(1, "SoundWire API is disabled");
+	return -EINVAL;
+}
+
+#endif /* CONFIG_SOUNDWIRE */
 
 #endif /* __SOUNDWIRE_H */
-- 
2.30.2

