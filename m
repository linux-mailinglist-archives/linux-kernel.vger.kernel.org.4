Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4F5F31B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJCOCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJCOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:01:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249384456D;
        Mon,  3 Oct 2022 07:01:43 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293DqcFh011549;
        Mon, 3 Oct 2022 14:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bTHb/iTIJ515U9ZD/ZdvnV3tGnX4kfcrHGl79HkwpXw=;
 b=kzSXosTovEm4qg1oKiF/uejTMv5JM2wcPDM2kYxlnZzZg10TGtlMMiishu/9ZCJFFEzm
 IWJceL5/vSTIVKi67qyh5ungGhrKBuDxc7tA9dy0IJD3weGxJZnKCgCtcD0afjAnKm06
 XbSzeb/jCgEpR4VabIqTIHu4acQGr4F5gnz+q3AZsG1W8HozU4CClbulytEJUxvCUo0d
 ekgXL8pspiBKeH0gGMHSUybvSe/Y8HepQE0Dxdmnu6NxVkaFGUIHnUTC7IQ0/9tJgUin
 9e5KEX9ixYPnSlS4P8SSVy0trTtwA+lvJ74e2chWiXrT5U3+ACxneeTBpJjLu2TivxXW 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxd58kr30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 14:01:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 293E1WsE019770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Oct 2022 14:01:32 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 3 Oct 2022 07:01:27 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Subject: [PATCH V16 7/7] arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support node
Date:   Mon, 3 Oct 2022 19:30:31 +0530
Message-ID: <10acb24d06a9c7c4266b6b1689bf0e1d39a76420.1664805059.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1664805059.git.quic_schowdhu@quicinc.com>
References: <cover.1664805059.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A1qfAX5bn8QT5nPiFwVgnGPfXvp-iubS
X-Proofpoint-ORIG-GUID: A1qfAX5bn8QT5nPiFwVgnGPfXvp-iubS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=896
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DCC(Data Capture and Compare) device tree node entry along with
the address of the register region.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d761da4..7d476b2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2137,6 +2137,12 @@
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		dma@10a2000 {
+			compatible = "qcom,sdm845-dcc", "qcom,dcc";
+			reg = <0x0 0x010a2000 0x0 0x1000>,
+			      <0x0 0x010ae000 0x0 0x2000>;
+		};
+
 		pmu@114a000 {
 			compatible = "qcom,sdm845-llcc-bwmon";
 			reg = <0 0x0114a000 0 0x1000>;
-- 
2.7.4

