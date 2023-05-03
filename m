Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4C6F4F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjECEqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECEqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:46:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FE272A;
        Tue,  2 May 2023 21:46:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3434adn2019345;
        Wed, 3 May 2023 04:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=pXJ0xPBspsyhkpRul5SAxVkyR8JhuYOMZ/pgfTpeX6w=;
 b=i448YWU5yjFuf4a1wd624qrviw7UTjBUysOm6q1UYLtaLTlU8oG+hLaDH3zs1I+keC4W
 aKEybZPvVcBKzfGNmK9heip3Yb3+AcK4qfNV02d9V+sC6XFwQvWtbVhipRJu8ol1QBeM
 WwFsQOg+qE+AznHV+Mf8hnhpiNpCapXCO4XfgrubaLv9957P3VYrg5GFlcRuwHJs+Qlh
 lz4xilYRqgDznilopGzRiPxO6M/xbH11oQXviCn5fG+ifkTwLKTYlW5w2Q0aJeTGXTxo
 WLuBit9buogiTeDBcn2VIQDvGr4dsn16FjXp++Qb2VVyCDpmZ9Xy9wgMCUDnZF3Rnjpc kA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawb0tjr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 04:46:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3434kS7X010739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 04:46:28 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 May 2023 21:46:23 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 0/4] Enable IPQ9574 TSENS support
Date:   Wed, 3 May 2023 10:15:58 +0530
Message-ID: <cover.1683027347.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: --bdR7Rab9yETjY1S1NdVYZcXCNK5OxM
X-Proofpoint-GUID: --bdR7Rab9yETjY1S1NdVYZcXCNK5OxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=832 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030038
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
[v1]:
	Fix DT node names

[v0]:
	Initial patch introducing TSENS support

Praveenkumar I (2):
  dt-bindings: thermal: tsens: Add ipq9574 compatible
  thermal/drivers/tsens: Add IPQ9574 support

Varadarajan Narayanan (2):
  arm64: dts: qcom: ipq9574: add tsens node
  arm64: dts: qcom: ipq9574: add thermal zone nodes

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   3 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 217 +++++++++++++++++++++
 drivers/thermal/qcom/tsens.c                       |   3 +
 3 files changed, 223 insertions(+)

-- 
2.7.4

