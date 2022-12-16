Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD264F4D5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiLPXOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLPXOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:14:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5153ABF48;
        Fri, 16 Dec 2022 15:13:39 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGN0J0r010507;
        Fri, 16 Dec 2022 23:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=JXZSQEEM+X1A84nZcYbVaRFPiODcApf3DmivOiIPCes=;
 b=imFintER2fGSyKULZUBKSA+jKfJHbfXPP9ybxsZdT+xNRF+uk0hzlKEdrdvv+YL/xnMo
 nICQRK4zRFTLykOcYo8XXaEY/jlvwNq1M2ZuPcB5Pj2Av5WJ7unC5ZciZFwVqie1BocS
 bjsJhIfupXV6yw/1QVDONh5zNELh9aral2g3okwgDCEnDN1DrxeP1KB078KEJT4IgxeL
 0sekjAKrbWTHlwftVKdOVuykQg2sjnjVCLzLx6xI7HywL1P3TDf357LKWzkoRDGU+vGF
 p7FmKpLkYF+mv4omtWSSD/uroGD18OLGCffyFd68jKO2NhIBaS7V2PLHUQJFxzLoS2T3 Og== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mgufm17wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:13:34 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGNDXP1017300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:13:33 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 15:13:33 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
CC:     Melody Olvera <quic_molvera@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatible
Date:   Fri, 16 Dec 2022 15:13:12 -0800
Message-ID: <20221216231312.22574-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jfo8YHa1jdjUaxhh6eWCJl38en0CU29W
X-Proofpoint-GUID: Jfo8YHa1jdjUaxhh6eWCJl38en0CU29W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for scm driver for QDU1000 and QRU1000 platforms. These
drivers only require the compatible field, so update the bindings
accordingly for these platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
This patch is separated out from [1] and includes
changes addressing comments from that patch set.

Changes from v4:
* rebased on top of [2]
* removed redundant allOf

Changes from v3:
* removed unnecessary reset-cells

Changes from v2:
* Dropped qru compat strings
* Marked no clocks on qdu/qru scm device
* Revised rpmhpd constants
* Updated socinfo driver to new format

[1] https://lore.kernel.org/all/20221026190549.4005703-2-quic_molvera@quicinc.com/
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 8e6e9ebb343d..9312a0953ea8 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,scm-msm8994
           - qcom,scm-msm8996
           - qcom,scm-msm8998
+          - qcom,scm-qdu1000
           - qcom,scm-sc7180
           - qcom,scm-sc7280
           - qcom,scm-sc8280xp

base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
prerequisite-patch-id: d5d17b3d720b358b8478cb1ad87e21a70992f228
prerequisite-patch-id: 6c92672973fdc1524516942fa21c340e68e7c4fb
-- 
2.38.1

