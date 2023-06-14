Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B3727B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjFHJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjFHJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:28:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6817213C;
        Thu,  8 Jun 2023 02:28:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3588QUwG024541;
        Thu, 8 Jun 2023 09:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=A93tllnqdpd1P7mdoUsxMlSaMMTdYZnUoeb8k3ffiwU=;
 b=XhvoWajNJ19DSdCBl6zE1q+5cGnS1/oR8EYG06A5zrCxJ6CBMI4wahKjG2ERzx59oPLA
 GaZ0FNbY/ArywlTMBlxCPxqDvdZClOGkhSwjS/9PmiEgTWjM6FUhNf1+QE+uCaFZvzZ/
 XXQGkqCPMLQvrFw3e/g2umvG6TQ8gU7wdDCRlI4YdfxitTXqQVSm148AhAx+dEIW9GZx
 KazH5f39kK3Y3VHcxfeiyliCkCTbxnUMeKP9bmMHVO6/pPzHsn19m0kDCjKRuO3B+YhS
 t4zhGnHGH+J3fx7y4PzbG0GoUhyLlMHlgDSi/JKxudT7G+o+D66Fbj62yn6iRO84EL54 eQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2w551nks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 09:28:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3589SdKX023774
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 09:28:39 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 02:28:34 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v13 0/5] Enable IPQ9754 USB
Date:   Thu, 8 Jun 2023 14:57:59 +0530
Message-ID: <cover.1686215358.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6_2-Lhlshen1k-WMwJ7H1XCZWofrJfpl
X-Proofpoint-ORIG-GUID: 6_2-Lhlshen1k-WMwJ7H1XCZWofrJfpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=684 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the relevant phy and controller
configurations for enabling USB on IPQ9754

Portions of the patchset have been merged. Please see
	https://lore.kernel.org/lkml/ZGN9gchu7dRb6QwC@matsya/

[v13]:
	- Move fixed regulator definitions from SoC dtsi to board dts
	- Remove 'dr_mode' from SoC dtsi
	- Move 'status' property to the end

[v12]:
	- In dtsi usb@8a00000 -> usb@8af8800

[v11]:
	- Rename dwc_0 -> usb_0_dwc3
	- Minor change in qcom,sc8280xp-qmp-usb3-uni-phy.yaml to factor in
	  latest updates to the file

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

Varadarajan Narayanan (5):
  dt-bindings: usb: dwc3: Add IPQ9574 compatible
  clk: qcom: gcc-ipq9574: Add USB related clocks
  arm64: dts: qcom: ipq9574: Add USB related nodes
  arm64: dts: qcom: ipq9574: Add LDO regulator node
  arm64: dts: qcom: ipq9574: Enable USB

 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  3 +-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts        | 48 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 85 ++++++++++++++++++++++
 drivers/clk/qcom/gcc-ipq9574.c                     | 37 ++++++++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h       |  2 +
 5 files changed, 174 insertions(+), 1 deletion(-)

-- 
2.7.4

