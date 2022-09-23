Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A765E7B58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiIWNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIWNGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:06:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA413A397;
        Fri, 23 Sep 2022 06:06:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NAM92I008871;
        Fri, 23 Sep 2022 13:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=XBJx2C+f34IKeltlLUeH2UNUQtkB+UXQx3yq1YuUJH8=;
 b=kBisovzr6rEzaG4z6Nl50kWIj6MMJF7ljjRNm2J7gd1bx9jIizlqpG4ecaO/mVXDU+Ew
 VXuISMJexOXO7M0VFrDvFessmE0yR/cTL6dlMt382o+TbkguqUPwUrN+uKxpcRYNh9Sv
 +XiArbDadL3o1/p5oz4Q0gG+5W3qBsSkRSgVF+4EBSBynLqZFtGyhpHKAevwvJXf/ocx
 6jLUE+8Ayi2+u0qI2Lm16asCJ9Fk1YfecFpgIgRMJbGOnieRAbPNHJ0IVzO6ymiYeeCj
 2Qv26Y9JOJo32LNa05YeMu16iKL+hNYfmyaNa8uQYwApBizm5N3mxbPXEgbBX1tVJZsG 0A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3js9krrwsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 13:06:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28ND5xSk017773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 13:06:00 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 06:05:54 -0700
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
Subject: [PATCH v8 0/7] Update ADSP pil loader for SC7280 platform
Date:   Fri, 23 Sep 2022 18:35:33 +0530
Message-ID: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HWkh1EpMkOoEQBbMF-TOOuBM61VbgC0M
X-Proofpoint-ORIG-GUID: HWkh1EpMkOoEQBbMF-TOOuBM61VbgC0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=966 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADSP pil loader driver for SC7280 platforms.
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

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 207 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_adsp.c                | 124 +++++++++++-
 2 files changed, 327 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml

-- 
2.7.4

