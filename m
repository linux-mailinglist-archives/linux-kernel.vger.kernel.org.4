Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355A071209A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbjEZHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbjEZHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:05:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34C125;
        Fri, 26 May 2023 00:05:08 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q5L5PN001500;
        Fri, 26 May 2023 07:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=6oD03ngMDUWk/J4S4ucYRij9/TVw9gupynW4GcKiVNM=;
 b=LrnlKxJVNgCtPQQ76WqvxKg8/ERsAkvRe7BnGGCcnVXTqyX/roKfg0jZ5IBL0lGMIjfg
 dam61ipGz+xDEtLpAzOUxEeEbxzXGWV7lphIc/QaprDxtlzdwQ3NpslIDK6etTTqTX9H
 8kO+Kxbu35z03ih8ZF2cTnPHiuIANfCqthLWmIyChzj6WHVRh9nKLcrrC3SwmC2L8skh
 pe9Az55nZmMRRifOCsbTzSHcwZYu8NexVxXMjT2S/WAAVuXyyE7/oGf8NRWwko6GZm3z
 G9Ns/lkjNncpO5J9hI4YDwnD7PRndrcSXq1hFJusdsc5ZsDoKLhlH2ECILohqPjU6ha/ 7g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt1tqtuac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:05:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34Q751Lc032512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:05:01 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 00:04:58 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/3] Add QFPROM support for few IPQ SoCs
Date:   Fri, 26 May 2023 12:34:17 +0530
Message-ID: <20230526070421.25406-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LGgJniwDC2uY8l8yeMW6P_Cmul4zH2Se
X-Proofpoint-GUID: LGgJniwDC2uY8l8yeMW6P_Cmul4zH2Se
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=579 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like any other SOCs, Qualcomm's IPQ SOCs also have an efuse region which
exposes the HW quirks like CPU Freq limit and so on. This series add the
basic support for the efuse. Feature specific fuses will be added along
with the feature set.

Kathiravan T (4):
  dt-bindings: nvmem: qfprom: add compatible for few IPQ SoCs
  arm64: dts: qcom: ipq5332: add QFPROM node
  arm64: dts: qcom: ipq6018: add QFPROM node
  arm64: dts: qcom: ipq9574: add QFPROM node

 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 3 +++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi                    | 7 +++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                    | 7 +++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                    | 7 +++++++
 4 files changed, 24 insertions(+)

-- 
2.17.1

