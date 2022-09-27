Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836D95EC522
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiI0N5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiI0N5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:57:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35A5148A3D;
        Tue, 27 Sep 2022 06:57:24 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RCx1tF005993;
        Tue, 27 Sep 2022 13:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EbZ8P2QHGBsmzMMNq1xlcxkbkA3vcqR6YFkf1gXCvDM=;
 b=nS4C+3G46aI4QoWIk7IE+CAKpnhiZpoVxXuL8rgue1DF6pfyKdeOR3b2JpBXcT+MQZJv
 HqojdKoXv5kal8mN678oVms0RnNR6zg8hsn9cSAp0iADrwg8ghIZ9Xig5+Pg5DC194TV
 7O4Fh0EiWWVJw8rv1orjtf8NST2Xt5Oo6kk1wOraz3SongUt310VHtno2x1yqnE5Y+et
 WZTJswe0Vt5wonhzru9jGbcW4+uuBCfq82+Rl5Mx0NJ3YWGS4XfjY3ESBPuiGhyUJ643
 ifjEe704c8VF3p4l9NYE8tQfTWOUrs7IitZV3uKEkRXolWLnwWCOFNugzGfJZ3cQ1Tnm IQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juq77hj6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:57:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RDvC6C016596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:57:12 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 27 Sep 2022 06:57:06 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v9 0/7] Update ADSP pil loader for SC7280 platform
Date:   Tue, 27 Sep 2022 19:26:36 +0530
Message-ID: <1664287003-31450-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HxtwUNqyf24YfnkRW-KdN_WXU3JYPZcl
X-Proofpoint-GUID: HxtwUNqyf24YfnkRW-KdN_WXU3JYPZcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_05,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADSP pil loader driver for SC7280 platforms.
Changes since V8:
	-- Add glink-edge reference in dt-bindings.
	-- Remove redundant glinke-edge properties in dt-bindings.
	-- Make all reg propertioes as mandatory in dt-bindings.
	-- Add iommus property in dt-bindings.
Changes since V7:
	-- Drop out of reset time out patch.
	-- Remove redundant clocks in dt bindings.
	-- Fix dt compilation error in dt bindings.
Changes since V6:
	-- Update dt-bindings with glink-edge
	-- Add qcom,qmp property.
	-- Update parse firmware callback.
	-- Update commit message.
	-- Update smmu map and unmap function names.
	-- Revert adsp_ops const change.
	-- Move iommu check to within smmu map/unmap functions.
Changes since V5:
	-- Remove adsp_rproc_unmap_smmu, adsp_of_unmap_smmu, adsp_of_map_smmu and 
	   adsp_rproc_map_smmu functions.
	-- Remove find_loaded_rsc_table call back initialization.
	-- Rename adsp_sandbox_needed to has_iommu.
	-- Update parse_fw callback in rproc ops.
	-- Remove qcom,adsp-memory-regions property in dt-bindings.
	-- Change adsp binary extension name.
Changes since V4:
	-- Update halt registers description in dt bindings.
	-- Update Memory sandboxing with proper APIs for resource
	   allocation and free.
Changes since V3:
	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
	-- Update sc7280 compatible name entry in sorted order.
	-- Add smmu unmapping in error case and in adsp stop.
	-- Revert converting sdm845 dt bindings to generic and 
	   create new dt bindings for sc7280.
Changes since V2:
	-- Generated patch with -M flag.
	-- Add Clock property in dt bindings.
	-- Add qcom,adsp-memory-regions property.
	-- Add is_adsp_sb_needed flag instead of is_wpss.
	-- Initialize is_adsp_sb_needed flag.
	-- Remove empty proxy pds array.
	-- Replace platform_bus_type with adsp->dev->bus.
	-- Use API of_parse_phandle_with_args() instead of 
	    of_parse_phandle_with_fixed_args().
	-- Replace adsp->is_wpss with adsp->is_adsp.
	-- Update error handling in adsp_start().
Changes since V1:
	-- Change reg property maxItems to minItems and update description.
	-- Fix typo errors.

Srinivasa Rao Mandadapu (7):
  dt-bindings: remoteproc: qcom: Add SC7280 ADSP support
  remoteproc: qcom: Add flag in adsp private data structure
  remoteproc: qcom: Add compatible name for SC7280 ADSP
  remoteproc: qcom: Update rproc parse firmware callback
  remoteproc: qcom: Replace hard coded values with macros
  remoteproc: qcom: Add efuse evb selection control
  remoteproc: qcom: Add support for memory sandbox

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 194 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_adsp.c                | 124 ++++++++++++-
 2 files changed, 314 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml

-- 
2.7.4

