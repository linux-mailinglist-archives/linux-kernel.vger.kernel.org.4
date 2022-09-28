Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5540C5EDC91
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiI1M2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiI1M2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:28:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B0E91D3F;
        Wed, 28 Sep 2022 05:28:37 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SCRw7s015032;
        Wed, 28 Sep 2022 12:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=LJiOaGL2VVuoViglQqnwwg6m1j1+ldTNGNUKoaPwF/A=;
 b=OrhXGJuv4TQxrN7njd0cDelmAUgflzjYQB5bNrMe7b60KpAxHb6u8GgWLJibnk9jWgQt
 9a9++w5651q9pzXteD9mEBSToU7mHDDQIQmVOYQcSKX6TJ+fK8Qpw3O+aSTPjkdxQqdC
 fcY0OW+GjsM5LOz5LfHnkiRjP0ip0jn3HGhqAWc4rKp6pRPgezRhyQRcjmwx1TkVTfXw
 +Qb4z5ClIPNUtjYHxDL0KeN0tl72m2ifef/pzgEgFAU3hupWG72g+fN7Yqp4B90mtEeB
 7Sc+n4lurdR9YSYuWKwGdTSnwVK6sXXNmlRNYZ7q6LY1bIgIbX//BZdWuZtWZS/4wcqJ 2w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvm4vg7p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 12:28:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SCSIrJ028982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 12:28:18 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 05:28:12 -0700
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
Subject: [PATCH v10 0/7] Update ADSP pil loader for SC7280 platform
Date:   Wed, 28 Sep 2022 17:57:46 +0530
Message-ID: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5ltP-N2xlDEkrKbm4mGJo01E7aDAeZDv
X-Proofpoint-GUID: 5ltP-N2xlDEkrKbm4mGJo01E7aDAeZDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_05,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADSP pil loader driver for SC7280 platforms.

Changes since V9:
	-- Add missing unevaluatedProperties in dt-bindings glink-edge.
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

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 195 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_adsp.c                | 124 ++++++++++++-
 2 files changed, 315 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml

-- 
2.7.4

