Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7E73B6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFWL4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWL4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:56:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608B991;
        Fri, 23 Jun 2023 04:56:00 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NBDZJn025775;
        Fri, 23 Jun 2023 11:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EMYcB5EQMk7xfxoD5jZL7SCS7GloqAQ/+Tu1J86+LpQ=;
 b=NZy6bGFulUZ12QdAXr4mNWuVBCdZ/ObG+VD/DB+pwH1w5HouEsEsImUfkC8l7oxo7JAg
 f/JWWKGBKF+Am14b6K5AkFpJVbxaiVx5Nf/K2TauNl7aydUccpO4LWNh55FVsQb0+t4G
 jU7sdxck4yGaUBWnM2N392kQEXJZ/I7lNQ+az3e3loObzYApjb1FKtKFrXcGtm8iQ4W0
 LDG924xmxGe9Y+y+4Ftl6Iq3XCkfnonZqwbV+nevxPfzitGmMUto/D0WHxQkQ3Rwb+6t
 1RRojD3fiyqd6mxhL58Hh86NgUT5bqfm2gk/2mLLWiMeeU6oKp/feqOA1Ljp1P+YAaO+ Ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc6b2cjc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:55:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NBtlb2007364
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:55:47 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 04:55:39 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <quic_anusha@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <bhupesh.sharma@linaro.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <quic_arajkuma@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_poovendh@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <thara.gopinath@gmail.com>
Subject: Re: [PATCH V4 3/4] dt-bindings: qcom-qce: add SoC compatible string for ipq9574
Date:   Fri, 23 Jun 2023 17:25:25 +0530
Message-ID: <20230623115525.7300-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526161129.1454-4-quic_anusha@quicinc.com>
References: <20230526161129.1454-4-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 43NMBdc0BsON7s9os7zyfujjANOw3q6T
X-Proofpoint-GUID: 43NMBdc0BsON7s9os7zyfujjANOw3q6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=384 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Document the compatible string for ipq9574.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>  Changes in V4:
>	- Picked up Reviewed-by tag.

A gentle reminder to pick the dt-binding patch.
As the dts change is picked, this patch is required to resolve dt-bindings check issues.
