Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5D71FFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjFBLEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:04:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3402118C;
        Fri,  2 Jun 2023 04:04:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352APYTk012137;
        Fri, 2 Jun 2023 11:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ktJlFLaULAZpuZUg7No7ulmBRAHD7ttLKDsv2gciZRw=;
 b=kUrsOQf4gndw7v8PNuRt/ZizXcgs8jdBdKE7irB1ijxqEIokKQ3vs+rv2o1ftEMCyG7z
 3Ot+VP3iX/YrgU2QHS/NX6BrqPV810f/zFMot55Y4wqOUrBRZr9TfxMVdqXJhFTodtBk
 biF4qvvABiueKVuDqiTPcqkuzeqLxFYP5pL0ijhaSS0Zo1eNDrYgqKu5Zzt/8nc0huB7
 QBd3r7S5u2qxHP5pJ5mnbRZR5uyPgZy2p9srzxD8Ydg1yREH6EkraS24IA3aZLn/PvKt
 sc7TLfHoCoRinV6a5omI2158FVwKEgp08ObJMLYZN/qufqGwZWSD4Ek00ahVS4cAtqju nA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qybnbrebx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 11:04:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352B445u016234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 11:04:04 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 04:03:59 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v5 0/3] Enable IPQ9574 TSENS support
Date:   Fri, 2 Jun 2023 16:33:49 +0530
Message-ID: <cover.1685703605.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PYwUe1mFMGttagEK6jlrRVxXqNXd75L8
X-Proofpoint-ORIG-GUID: PYwUe1mFMGttagEK6jlrRVxXqNXd75L8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=800 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306020081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set enables tsens in IPQ9574

Depends on
	https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
[v5]:
	Fix make DT_CHECKER_FLAGS=-m dt_binding_check and make dtbs_check errors without removing existing entries

[v4]:
	Drop the sm6375-tsens and qcm2290-tsens related bindings
	fix as it is already posted

	Remove unnecessary changes from previous version

[v3]:
	Fix make DT_CHECKER_FLAGS=-m dt_binding_check and make dtbs_check errors

[v2]:
	Drop the driver change (https://lore.kernel.org/lkml/b45d33d38a334aabbd52c83b0d6028af1f4c74c8.1682682753.git.quic_varada@quicinc.com/)
	since the tsens device is compatible with 8074's tsens
	and use 8074's compatible itself

	Rename clusterX nodes as cpussX

[v1]:
	Fix DT node names

[v0]:
	Initial patch introducing TSENS support

Praveenkumar I (1):
  dt-bindings: thermal: tsens: Add ipq9574 compatible

Varadarajan Narayanan (2):
  arm64: dts: qcom: ipq9574: add tsens node
  arm64: dts: qcom: ipq9574: add thermal zone nodes

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   6 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 218 +++++++++++++++++++++
 2 files changed, 224 insertions(+)

-- 
2.7.4

