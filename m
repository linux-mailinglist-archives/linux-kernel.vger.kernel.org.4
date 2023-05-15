Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73E2702A23
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbjEOKOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjEOKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:13:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4237F13E;
        Mon, 15 May 2023 03:13:58 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F9BAlc019247;
        Mon, 15 May 2023 10:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=tyxOOd++tn6u/tO3C84eUNqvzBUsntMNJVOCKx6j1nc=;
 b=W+giTwEPa2txCBgedR7Pg3cA9vWhS7QY2ssUjGnysPXiJhr60UxVLMz7J4dOcoVhy8Hu
 1CNMgOT6oWVg+6+SNW5U1ioVnH5+VNQVfejCrU7QpRHZ714vkmO4h9yRIwJyTaSZA1WV
 bgQvQ2/rkCu49HkbdA7CQj0PEcQLxpwzLG4mfzRhrOSLlCGnTOSDXYqaH15k1Y0Cs/t1
 RZfRzCou9TtfJvhJS2BwOud46PEUTenC297Ejs+Bmt8j0RDucSX1eBuu4pnm1uOh7A/y
 kSTmoSuOaxLsfQOCVj6y3vtvgz4vAcCyvjsva1I3AAH3qj17lIPslhPH1qPlOG8MrOUk hQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj3qw38v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 10:13:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FADpeC027683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 10:13:51 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 May 2023 03:13:45 -0700
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
Subject: [PATCH v3 0/4] Enable IPQ9574 TSENS support
Date:   Mon, 15 May 2023 15:43:31 +0530
Message-ID: <cover.1684140883.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dUda5Y6pTIsirtHdm2nGL2ZNWPuNRz-K
X-Proofpoint-GUID: dUda5Y6pTIsirtHdm2nGL2ZNWPuNRz-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=798 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set enables tsens in IPQ9574

Depends on
	https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
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

Varadarajan Narayanan (3):
  dt-bindings: thermal: tsens: Fix "make dtbs_check" error
  arm64: dts: qcom: ipq9574: add tsens node
  arm64: dts: qcom: ipq9574: add thermal zone nodes

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  15 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 217 +++++++++++++++++++++
 2 files changed, 230 insertions(+), 2 deletions(-)

-- 
2.7.4

