Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4A72A682
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjFIXBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjFIXBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:01:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3563A82;
        Fri,  9 Jun 2023 16:01:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359N1ChB020206;
        Fri, 9 Jun 2023 23:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=LMJVHlHhMZI4SpJaHyjinsTGEr+QQn9d2EX/jsNMrr8=;
 b=FiTiPH0ulmgU9k2qhInhWlB5ruEL9XMkn6L8LtKtfsp66wc5hiJ2gokic9QlhsVb9kkb
 rzth/xq1xWQwKPghan4F/XDuN9zy2qFjYE0X9HvTN5vkepoJFMmzK45gLMpAVT8Lt7z4
 auXsFS223Daj1F3IIloqPUsgc50d+9BzoyFT0tYSifjzrYMk71SjY7xRQopeAn3PzYVp
 9pwou7YiKgn/vl0XJ9Y+yPfymeVi3uyvL7vm81Lpa81WI6YcwpBp9VkFGSeHYH+Zrwbj
 WpJgBIe2GcG3x3gSBFHOIhK4GhFujETmdJX+oGp4eQZXDYPJ8HeT/mGuR1yVgaSvMPTP Uw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r41r0sg1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 23:01:12 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359N1B1L028107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 23:01:11 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 16:01:11 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 9 Jun 2023 15:57:17 -0700
Subject: [PATCH v6 5/6] drm/msm/dsi: Remove incorrect references to
 slice_count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v6-5-95eab864d1b6@quicinc.com>
References: <20230405-add-dsc-support-v6-0-95eab864d1b6@quicinc.com>
In-Reply-To: <20230405-add-dsc-support-v6-0-95eab864d1b6@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686351669; l=2866;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=y+xbbNOzdpo1ciwApSAYM8x7xkoQT9uKx05zTyfwVCI=;
 b=2moGigoETOo3tpgVsD4dgSkfEiBy1I237eKqRNO5C7ZgsJN7Oa45vXJjIMlYpUtSYxKncUufO
 djuhh+oSxFrDx8ch9pbPVg9PFt806m6KB4KNC1A0NNqvI5KcW+AzM53
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -GUSTAZNwfBGjZzTGfXX78FoCFgrmheu
X-Proofpoint-ORIG-GUID: -GUSTAZNwfBGjZzTGfXX78FoCFgrmheu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, slice_count is being used to calculate word count and
pkt_per_line. Instead, these values should be calculated using slice per
packet, which is not the same as slice_count.

Slice count represents the number of slices per interface, and its value
will not always match that of slice per packet. For example, it is possible
to have cases where there are multiple slices per interface but the panel
specifies only one slice per packet.

Thus, use the default value of one slice per packet and remove slice_count
from the aforementioned calculations.

Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
Fixes: bc6b6ff8135c ("drm/msm/dsi: Use DSC slice(s) packet size to compute word count")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 98ea1da492c7..fb1d3a25765f 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -863,18 +863,17 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	 */
 	slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
 
-	/*
-	 * If slice_count is greater than slice_per_intf
-	 * then default to 1. This can happen during partial
-	 * update.
-	 */
-	if (dsc->slice_count > slice_per_intf)
-		dsc->slice_count = 1;
-
 	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
 
 	eol_byte_num = total_bytes_per_intf % 3;
-	pkt_per_line = slice_per_intf / dsc->slice_count;
+
+	/*
+	 * Typically, pkt_per_line = slice_per_intf * slice_per_pkt.
+	 *
+	 * Since the current driver only supports slice_per_pkt = 1,
+	 * pkt_per_line will be equal to slice per intf for now.
+	 */
+	pkt_per_line = slice_per_intf;
 
 	if (is_cmd_mode) /* packet data type */
 		reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
@@ -998,7 +997,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 		if (!msm_host->dsc)
 			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
 		else
-			wc = msm_host->dsc->slice_chunk_size * msm_host->dsc->slice_count + 1;
+			/*
+			 * When DSC is enabled, WC = slice_chunk_size * slice_per_pkt + 1.
+			 * Currently, the driver only supports default value of slice_per_pkt = 1
+			 *
+			 * TODO: Expand mipi_dsi_device struct to hold slice_per_pkt info
+			 *       and adjust DSC math to account for slice_per_pkt.
+			 */
+			wc = msm_host->dsc->slice_chunk_size + 1;
 
 		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
 			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |

-- 
2.40.1

