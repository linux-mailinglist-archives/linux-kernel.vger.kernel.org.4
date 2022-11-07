Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7494E61F5EA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKGO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiKGO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:27:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B3F1E723;
        Mon,  7 Nov 2022 06:21:19 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7DDKBX028968;
        Mon, 7 Nov 2022 14:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=2olvCibVQvG11bQHdiz8vATgc0US1wRb2k1qy63um2Q=;
 b=o1Y7t1m+qzLMECLK/HC6XAO7ZEOjTi2BQr1GOPswe+PGOxqc9NWvPT3Rlbc9mi8sNkRF
 ++cecIYLJ0oYOoRA0amrnnctBBHrINl9zM3ykpmtmqtNTJYxOGeEIX8+BE16Vo5/Xuvx
 BMUsg1oSwoU2PhFrIkiNz67csSZhCK2YpgLfWdveSuv39Rx1I2DmUlUZ2MSg2ARqN//f
 9uxPU84aQkV1EdA9ujY5EuiKL4AWdvycWycuXwPHebNSKoBNInNjRJKGeFjWMBYziOh9
 qBjbgdPcX+pML4/3Ph3FG0DIXDESKOEkGudofk5uV8b9VTmAt2rG8QyzgSBA3AwrDYp3 CA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kpvkygur8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 14:21:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A7EL7xd010031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 14:21:07 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 06:21:01 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 0/3] Convert soundwire bindings to DT schema
Date:   Mon, 7 Nov 2022 19:50:41 +0530
Message-ID: <1667830844-31566-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8uQr7pGJMG9PEDdaSYIsFKfyA8QBDtg-
X-Proofpoint-ORIG-GUID: 8uQr7pGJMG9PEDdaSYIsFKfyA8QBDtg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_06,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=909 bulkscore=0 malwarescore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert soundwire bindings text file to DT schema and update
device tree entries to follow strict dt-bindings.
Changes Since V3:
  -- Remove subnode description and add appropriate pattern properties.
  -- Add interrput names in example.
  -- update some properties description.
  -- Revert minIteams change in previous version.
  -- Rebase to latest code base.
  -- Update dtsi node names,
  -- Remove redundant property in soundwire node.

Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: Update soundwire slave node names
  arm64: dts: qcom: Remove redundant soundwire property
  dt-bindings: soundwire: Convert text bindings to DT Schema

 .../devicetree/bindings/soundwire/qcom,sdw.txt     | 215 ------------------
 .../bindings/soundwire/qcom,soundwire.yaml         | 241 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   4 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   1 -
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   4 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |   4 +-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts   |   4 +-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            |   4 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   1 -
 9 files changed, 251 insertions(+), 227 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml

-- 
2.7.4

