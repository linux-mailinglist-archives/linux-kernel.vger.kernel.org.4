Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533E6C0FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCTK7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCTK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:58:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BC13D6C;
        Mon, 20 Mar 2023 03:54:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8OlqD017738;
        Mon, 20 Mar 2023 10:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=wOFEbWs9Cw33LhoI4x7uWEBuX97sD4JEm+1a7zgmROw=;
 b=LvoB6rv/ZdFR0D6QdmjdVP8KS3MlnGIGq6rWURgHAKwDj2VXjPjAfwZg/TQX4355kmXO
 vkGtD385GB3JPE1XE+ySkD1LWWIbJ+VENwMgGw/Yg2X/qELMLdCV/emK+Lj0X2fPs2Ee
 clRgkd9TxQCUAJRDpc7SAw7UG0lyGzmwKqOSozdpK10F/5xvyHh0jvt8HB8M75OPie1/
 Nk4yruJayZJo7FvKWPB7AWuA5+KUjEnmj05UCu8PcHfByTTS4ESff4/XCEYdikgZDv4G
 1c08TkNykp38jqNfdTqtZ2AkKs6UfOik5yy4mHSeTVGM6DhgveV507IC6rbowotg8/12 lQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3peg57ru01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 10:45:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KAjmh5023616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 10:45:48 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 03:45:44 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 0/2] Add few device nodes for IPQ5332 SoC
Date:   Mon, 20 Mar 2023 16:15:28 +0530
Message-ID: <20230320104530.30411-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4df9pUOpMs9NWn9PQR7hz6ehNyp8yeqq
X-Proofpoint-GUID: 4df9pUOpMs9NWn9PQR7hz6ehNyp8yeqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 mlxlogscore=644
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the support for QUP peripherals, PRNG, WDT for IPQ5332
SoC.

This series depends on the below patch, due to the node ordering
https://lore.kernel.org/linux-arm-msm/20230217083308.12017-6-quic_kathirav@quicinc.com/#t

Kathiravan T (2):
  dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-ipq5332 compatible
  arm64: dts: qcom: ipq5332: add few device nodes

 .../bindings/watchdog/qcom-wdt.yaml           |  1 +
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts   | 14 ++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 67 +++++++++++++++++++
 3 files changed, 82 insertions(+)

-- 
2.17.1

