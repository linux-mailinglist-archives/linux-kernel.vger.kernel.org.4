Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3CC6210FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiKHMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiKHMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:39:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F9850F1E;
        Tue,  8 Nov 2022 04:39:53 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8B9C5F007152;
        Tue, 8 Nov 2022 12:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=q9qehZe1/+k/iE/NA33eOV6DMpMRqdCUVApIAg5+EFI=;
 b=iuLjNTr8p9MKkDdNHGYHpag9FMdp2nh3jD9MUjzNqY/USuFdpegEdRQVOkD90E+gV7KY
 anMAtfImFUudK3sOaISgtEHepBnAGpTUq0tKnV5Fq9q3x2cUtmV6+v7jCh+qdQrXdq+A
 M7ZsoEpP/eQFJIqHqVu77tnAtyKBqRMZL1hE68mdvTq7BEPT9517bnb7Dlfy4sMCKBNU
 aiv6PgZNW+Xye9p+41/2u8hzlx7o+0UNph/g03+jwkKo7ubv1M9QVNZR3k1S7Sc3hFDl
 CBNT4WblDGIcaVRe+VAdI7PxFo1IUnN/oFWYfGXf3lVSQyEkA2gAkhROLboYVowp62M4 8g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhvj0svu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 12:39:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8CdeHS031182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 12:39:40 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 04:39:35 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 0/4] Convert soundwire bindings to DT schema
Date:   Tue, 8 Nov 2022 18:09:12 +0530
Message-ID: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: THRXcTmLHAV2Pp3N4Y50e_F4OdglklPM
X-Proofpoint-GUID: THRXcTmLHAV2Pp3N4Y50e_F4OdglklPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=859 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert soundwire bindings text file to DT schema and update
device tree entries to follow strict dt-bindings.
Changes Since V4:
  -- Update interrupt names in example.
  -- Fix blank lines.
  -- Remove dependecy patch info.
  -- Split dtsi patches as per SoC.
Changes Since V3:
  -- Remove subnode description and add appropriate pattern properties.
  -- Add interrput names in example.
  -- update some properties description.
  -- Revert minIteams change in previous version.
  -- Rebase to latest code base.
  -- Update dtsi node names,
  -- Remove redundant property in soundwire node.

Srinivasa Rao Mandadapu (4):
  arm64: dts: qcom: Update soundwire slave node names
  arm64: dts: qcom: sm8250: Remove redundant soundwire property
  arm64: dts: qcom: sc7280: Remove redundant soundwire property
  dt-bindings: soundwire: Convert text bindings to DT Schema

 .../devicetree/bindings/soundwire/qcom,sdw.txt     | 215 ------------------
 .../bindings/soundwire/qcom,soundwire.yaml         | 244 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   4 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   1 -
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   4 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |   4 +-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts   |   4 +-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            |   4 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   1 -
 9 files changed, 254 insertions(+), 227 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml

-- 
2.7.4

