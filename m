Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45CD6D8FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjDFHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjDFHBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:01:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3299EA5F5;
        Thu,  6 Apr 2023 00:00:57 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3366S7Xi019083;
        Thu, 6 Apr 2023 07:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=eHJw8CHh4+/6PLUlX9ualJ18zAlphh0+gkGDJjdWpKI=;
 b=miU9887+0SKTSE24eJI0VnL4qbhCE0HC8+41ocaFTb53YCc5yYQPUekSB3i6Q33DhTMZ
 IywdNQH+Zh5KKT9n52+hs4aS2CqG/Jul0EDNsx/pY00a+66qvMWG0L5ORuHAEwT7BTFm
 qzc18Ps58ZLkMxGJMsYc51D8gU55OYa0DSrsZQ+uceieeZeNrmG27eUDT6H8oXPzK9qb
 9AO6MUHqJYLiyUo4BjDqjb45lMOnHjDV7cgIlICbwj5h4b/o7jyr2c7Os4JkZ27mCqbo
 5C9/Bcz4BhcMAbDbleufQ92B/+xt1HgFTGTXpVnYbs1LFt1TVut3n4N6K6e7Y8kzEjgl NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psr2605dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 07:00:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33670qWM020720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 07:00:52 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Apr 2023 00:00:46 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 0/5] Add regulator support for IPQ9574 SoC
Date:   Thu, 6 Apr 2023 12:30:27 +0530
Message-ID: <20230406070032.22243-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4_rB9I6VXwT2chJZ8cS9MB1H_rvvEf3q
X-Proofpoint-ORIG-GUID: 4_rB9I6VXwT2chJZ8cS9MB1H_rvvEf3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=433
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060061
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator for APSS voltage scaling.
This patch series adds support for the same and also enables the RPM 
communication over the RPMSG framework.

DTS patch depends on the below series
https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/

[V3]:
	- Dropped PATCH [1/6] dt-bindings: soc: qcom: smd-rpm: Add IPQ9574 compatible
	  as it is available in linux-next/master
	- Dropped PATCH [4/6] regulator: qcom_smd: Add support to define the bootup voltage
	  and updated the nominal voltage in the Board DT as discussed
	- Splitted the board DT changes to a separate patch as suggested
	- Detailed change logs are added to the respective patches
[V2]:
	https://lore.kernel.org/linux-arm-msm/20230217142030.16012-1-quic_devipriy@quicinc.com/
	- Reordered the patches to have the bindings and driver changes
	  in place before the device tree support
	- Dropped the 'soc: qcom: smd-rpm: Add IPQ9574 compatible' since
	  it is already part of the linux-next/master
	- Detailed change log is added to the respective patches
[V1]:
	https://lore.kernel.org/linux-arm-msm/20230113150310.29709-1-quic_devipriy@quicinc.com/

Devi Priya (5):
  regulator: qcom_smd: Add s1 sub-node to mp5496 regulator
  regulator: qcom_smd: Add MP5496 S1 regulator
  arm64: dts: qcom: ipq9574: Add RPM related nodes
  arm64: dts: qcom: ipq9574: Add SMPA1 regulator node
  arm64: dts: qcom: ipq9574: Add cpufreq support

 .../regulator/qcom,smd-rpm-regulator.yaml     |  2 +-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 19 +++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 75 +++++++++++++++++++
 drivers/regulator/qcom_smd-regulator.c        | 10 +++
 4 files changed, 105 insertions(+), 1 deletion(-)


base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
-- 
2.17.1

