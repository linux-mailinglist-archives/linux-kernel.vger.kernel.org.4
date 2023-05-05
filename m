Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2C6F7EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjEEIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEEIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:22:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1F1161B;
        Fri,  5 May 2023 01:22:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34580Dwl010410;
        Fri, 5 May 2023 08:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WYrLfNctlHC0zQd+1qhdOywPx+RCuci0//8rOx7EPM8=;
 b=C1irO3nbzOOKMdSq1oaww6v+qhRoIYUzW82lX/VFkl1eVDT6HYTQOSSicnxlE//Gnv5q
 NO3QibwfV2Uie4kUJZQU8YEBRQiQtHQRfyJC4AVBDbYLNV7A3y/vEpu4uHZJrL54HN/i
 4XnLZFieWCUmCw6T45+/f7WhX6TKj5fH25cFUoT0opnoMIFth1VPYSjezErZrF+CwfOj
 jSh8gbdIPkXbXXpA5mOl3+TIcYRUNELnTohJeBp2Xk8cwsyuwX/u01gQBVuKsRrBgSmc
 luQLiETcTCFDI9XuPcrNAR7iYKW6tMHGgACsVtk2saDm8891aKY/QTqxdkcgRz/oUi1S HQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcf24hty6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 08:22:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3458M5Oh023648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 08:22:05 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 01:21:59 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v10 0/9] Enable IPQ9754 USB
Date:   Fri, 5 May 2023 13:05:01 +0530
Message-ID: <cover.1683183860.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 85E7EeZO04de2_AaM0ppfw3kSfARRNhX
X-Proofpoint-GUID: 85E7EeZO04de2_AaM0ppfw3kSfARRNhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1011 mlxlogscore=689
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the relevant phy and controller
configurations for enabling USB on IPQ9754

Depends on:
https://lore.kernel.org/all/20230217142030.16012-1-quic_devipriy@quicinc.com/
https://lore.kernel.org/lkml/20230407155727.20615-1-quic_devipriy@quicinc.com/T/

[v10]:
	- Fix regulator definitions
	- Address couple of other comments

[v9]:
	- Update bindings to make power-domains as optional since
	  IPQ9574 doesn't have GDSCs

[v8]:
	- Update bindings for the clock name change
[v7]:
	- com_aux -> cfg_ahb in patch 7

[v6]:
        - Incorporated review comments
	- Resolve make dtbs_check messages
	- Fixed pcs_usb offset
	- Board dts file name changed

[v5]:
        - Incorporated review comments
	- 'make dtbs_check' giving the following messages since
	  ipq9574 doesn't have power domains. Hope this is ok

		/local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
        	From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
		/local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
        	From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml

	- Move qmp phy DT node to newer specification

[v4]:
        - Incorporated review comments
	- Address all 'make dtbs_check' errors

[v3]:
        - Incorporated review comments regarding coding style

[v2]:
        - Incorporated review comments regarding coding style,
          maintaining sorted order of entries and unused phy register
          offsets
        - Removed NOC clock entries from DT node (will be implemented
          later with interconnect support)
        - Fixed 'make dtbs_check' errors/warnings

[v1]:
        https://lore.kernel.org/linux-arm-msm/5dac3aa4-8dc7-f9eb-5cf3-b361efdc9494@linaro.org/T/

Varadarajan Narayanan (9):
  dt-bindings: phy: qcom,qusb2: Document IPQ9574 compatible
  dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
  dt-bindings: usb: dwc3: Add IPQ9574 compatible
  clk: qcom: gcc-ipq9574: Add USB related clocks
  phy: qcom-qusb2: add QUSB2 support for IPQ9574
  phy: qcom: qmp: Update IPQ9574 USB Phy initialization Sequence
  arm64: dts: qcom: ipq9574: Add USB related nodes
  arm64: dts: qcom: ipq9574: Add LDO regulator node
  arm64: dts: qcom: ipq9574: Enable USB

 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   3 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |  41 ++++++--
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   3 +-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts        |  30 ++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 104 +++++++++++++++++++
 drivers/clk/qcom/gcc-ipq9574.c                     |  37 +++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 115 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
 include/dt-bindings/clock/qcom,ipq9574-gcc.h       |   2 +
 9 files changed, 330 insertions(+), 8 deletions(-)

-- 
2.7.4

