Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F156F18DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjD1NJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjD1NJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:09:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE51E46;
        Fri, 28 Apr 2023 06:09:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SC7v67005683;
        Fri, 28 Apr 2023 13:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZL5/JD/Drh/dxAmEDRIWOzwDjmp5D5m1E43a19rtE+0=;
 b=OM42HIdm76iBp3LLT+1xY5SzWUYBqad2oEFugtswbrkmSCFcNT4+tUglmoTU/uEc3Q0B
 V68FOTpaGHGwSdJl4C55PJ/i6zWGZJ2Za09BP72WFjwUlod+qxnxYaakx+jY+ecQ1/hS
 LlBLdOnuZv9/Gva9VaXgSQ81+62ap0bzheXr+aiZ1YBHr3CsE1GO5kQMk/NoJuZ3OTkn
 YnS14hsmBpaSxiQu3yH6KNxT5TVKJ13furcHbSVrAFe78PeA+X7mtQMoPT6dxj9P6qQm
 JHHk1HK75dmUUHtjX+bp37KmVfrUX/D44W4LvAAaRPs0CSt7SYXIdndHiWn4k7T9cyI5 Ow== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q850csp4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:08:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SD8m6E003190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:08:48 GMT
Received: from hu-shazhuss-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 28 Apr 2023 06:08:43 -0700
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmitry.baryshkov@linaro.org>, <athierry@redhat.com>,
        <robh@kernel.org>, <konrad.dybcio@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v2 0/6] arm64: qcom: sa8775p: add support for USB
Date:   Fri, 28 Apr 2023 18:38:18 +0530
Message-ID: <20230428130824.23803-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a6LqkUgj-DKO6lfB0rvfvIjdwvlTdG9K
X-Proofpoint-GUID: a6LqkUgj-DKO6lfB0rvfvIjdwvlTdG9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 mlxlogscore=583 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update relavent DT bindings for USB, add new config to the phy driver,
add USB and PHY nodes to the .dtsi and enable them in the board .dts
for the sa8775p-ride platform.

v1 -> v2:
- correct dwc3 device tree bindings for irq's.
- collect R-b, A-b and T-b tags.

Shazad Hussain (6):
  dt-bindings: usb: qcom,dwc3: Add bindings for SA8775P
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SA8775P
  dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add SA8775P USB PHY
    binding
  phy: qcom-qmp: Add SA8775P USB3 UNI phy
  arm64: dts: qcom: sa8775p: add USB nodes
  arm64: dts: qcom: sa8775p-ride: enable USB nodes

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |   1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  21 ++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  92 +++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 239 +++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  45 ++++
 6 files changed, 397 insertions(+), 2 deletions(-)

-- 
2.17.1

