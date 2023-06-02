Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05F171FEA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjFBKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjFBKMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:12:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F38E7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:12:04 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3529pNL6008786;
        Fri, 2 Jun 2023 05:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ekNDg+VFCiYjY12i1sso3YR2oeivSEZ1eM5g+XhkXVk=;
 b=NwA0aBf3TP7NpVjiw0EJV/RbeZGd/UWQBsdeOCVAoHm2dIV1bdvQGWLFpj+QmDsv0Elx
 rm7ePWFnD3/nRGRpNgikcS0BhQZIlcMXnHS3FDqc4gtTrps94rGMRjRgGGwICe+05tHb
 BjBzgzZlugbEjjnvPNZxdwUu4YKS+fVjp1am948cd5MhcRFRhDZeCBV5dxpPSd7JVyDQ
 atsunAqrrWB9YkOsNBU1/qkfUguMiuYm+y0o2IGzChlwAD1MGnLhe2b3rJDI7nIXB70x
 dn9S5y/4EOVRrAACMbbOuapNl5Eh2NO4w8zzqwnQt6+CgvFzDOTR5kJwMhAVk7105suK fg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90y83v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 05:11:44 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 11:11:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Jun 2023 11:11:40 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D662E15A4;
        Fri,  2 Jun 2023 10:11:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 5/5] soundwire: stream: Remove unnecessary gotos
Date:   Fri, 2 Jun 2023 11:11:40 +0100
Message-ID: <20230602101140.2040141-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uhKsbTLYac5TE4X8JYzcO27_iefRGppW
X-Proofpoint-ORIG-GUID: uhKsbTLYac5TE4X8JYzcO27_iefRGppW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of code using gotos to skip small sections of code, this
is a fairly dubious use of a goto, especially when the level of
intentation is really low. Most of this code doesn't even breach 80
characters when naively shifted over.

Simplify the code a bit, by replacing these unnecessary gotos with
simple ifs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Split out the inversion of the alloc_*_rt logic

Worth noting this patch has no functional corrections it is just a
stylistic change, so as Pierre said on v1 we could just leave things
as is. Personally, I would prefer to merge it though, whilst the diff
is a little more of a pain to review (hopefully eased somewhat by
splitting out the alloc_*_rt logic into a separate patch), the
resulting code reads much nicer and the code will be read a lot more
times than this patch will be.

Thanks,
Charles

 drivers/soundwire/stream.c | 124 +++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 68 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index df5600a80c174..93baca08a0dea 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1355,25 +1355,23 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 			return -EINVAL;
 		}
 
-		if (!update_params)
-			goto program_params;
-
-		/* Increment cumulative bus bandwidth */
-		/* TODO: Update this during Device-Device support */
-		bus->params.bandwidth += m_rt->stream->params.rate *
-			m_rt->ch_count * m_rt->stream->params.bps;
-
-		/* Compute params */
-		if (bus->compute_params) {
-			ret = bus->compute_params(bus);
-			if (ret < 0) {
-				dev_err(bus->dev, "Compute params failed: %d\n",
-					ret);
-				goto restore_params;
+		if (update_params) {
+			/* Increment cumulative bus bandwidth */
+			/* TODO: Update this during Device-Device support */
+			bus->params.bandwidth += m_rt->stream->params.rate *
+				m_rt->ch_count * m_rt->stream->params.bps;
+
+			/* Compute params */
+			if (bus->compute_params) {
+				ret = bus->compute_params(bus);
+				if (ret < 0) {
+					dev_err(bus->dev, "Compute params failed: %d\n",
+						ret);
+					goto restore_params;
+				}
 			}
 		}
 
-program_params:
 		/* Program params */
 		ret = sdw_program_params(bus, true);
 		if (ret < 0) {
@@ -1876,30 +1874,25 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	 * it first), if so skip allocation and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(bus, stream);
-	if (m_rt)
-		goto skip_alloc_master_rt;
-
-	m_rt = sdw_master_rt_alloc(bus, stream);
 	if (!m_rt) {
-		dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
-			__func__, stream->name);
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
-	alloc_master_rt = true;
-skip_alloc_master_rt:
-
-	if (sdw_master_port_allocated(m_rt))
-		goto skip_alloc_master_port;
+		m_rt = sdw_master_rt_alloc(bus, stream);
+		if (!m_rt) {
+			dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
+				__func__, stream->name);
+			ret = -ENOMEM;
+			goto unlock;
+		}
 
-	ret = sdw_master_port_alloc(m_rt, num_ports);
-	if (ret)
-		goto alloc_error;
+		alloc_master_rt = true;
+	}
 
-	stream->m_rt_count++;
+	if (!sdw_master_port_allocated(m_rt)) {
+		ret = sdw_master_port_alloc(m_rt, num_ports);
+		if (ret)
+			goto alloc_error;
 
-skip_alloc_master_port:
+		stream->m_rt_count++;
+	}
 
 	ret = sdw_master_rt_config(m_rt, stream_config);
 	if (ret < 0)
@@ -1992,46 +1985,41 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(slave->bus, stream);
-	if (m_rt)
-		goto skip_alloc_master_rt;
-
-	/*
-	 * If this API is invoked by Slave first then m_rt is not valid.
-	 * So, allocate m_rt and add Slave to it.
-	 */
-	m_rt = sdw_master_rt_alloc(slave->bus, stream);
 	if (!m_rt) {
-		dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
-			__func__, stream->name);
-		ret = -ENOMEM;
-		goto unlock;
-	}
+		/*
+		 * If this API is invoked by Slave first then m_rt is not valid.
+		 * So, allocate m_rt and add Slave to it.
+		 */
+		m_rt = sdw_master_rt_alloc(slave->bus, stream);
+		if (!m_rt) {
+			dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
+				__func__, stream->name);
+			ret = -ENOMEM;
+			goto unlock;
+		}
 
-	alloc_master_rt = true;
+		alloc_master_rt = true;
+	}
 
-skip_alloc_master_rt:
 	s_rt = sdw_slave_rt_find(slave, stream);
-	if (s_rt)
-		goto skip_alloc_slave_rt;
-
-	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
-		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
-		ret = -ENOMEM;
-		goto alloc_error;
-	}
-
-	alloc_slave_rt = true;
+		s_rt = sdw_slave_rt_alloc(slave, m_rt);
+		if (!s_rt) {
+			dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n",
+				stream->name);
+			ret = -ENOMEM;
+			goto alloc_error;
+		}
 
-skip_alloc_slave_rt:
-	if (sdw_slave_port_allocated(s_rt))
-		goto skip_port_alloc;
+		alloc_slave_rt = true;
+	}
 
-	ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
-	if (ret)
-		goto alloc_error;
+	if (!sdw_slave_port_allocated(s_rt)) {
+		ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
+		if (ret)
+			goto alloc_error;
+	}
 
-skip_port_alloc:
 	ret =  sdw_master_rt_config(m_rt, stream_config);
 	if (ret)
 		goto unlock;
-- 
2.30.2

