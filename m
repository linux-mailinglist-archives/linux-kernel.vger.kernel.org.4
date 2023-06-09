Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B17298A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjFILvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbjFILva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:51:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF2535A7;
        Fri,  9 Jun 2023 04:50:52 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359BN8LN022324;
        Fri, 9 Jun 2023 11:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=WKbDxd8L8ISCDrL4/pwMcGwoEU9qmC7+747cxLc0jnI=;
 b=CX5oROG1Jr9TfqUtD7q7cPBL+UyiY+59uzPK1QzKyQFTxyKYKHIJowUGC9sxgdmB3RfL
 r+8YwVzGICiJantvLyTSwRjYpALuR1pxSe/7SulH+2dMTzVT1kzAV7MJv0bvGJ6gEOpI
 Qw8BTflfZ6OHMbP21vsCI11CmqgiUBZFgxmv5YxirCg+xoncgxpJOlAzpb+Rc89kYcVi
 SnTAWuIJOxQb3aUX3dLRTE7ayhu3VVC990WFdriqXM/q0N4oufrqCE7lk/Jefw0s027I
 0Q9vmcZulv+s1eVQGrms1GFtIWg9WzirvAol+vPbdDBSHsJKSa4BGaBA2mLESn4rLA4D uQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3nwesd2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:50:45 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 359BoeuP019488;
        Fri, 9 Jun 2023 11:50:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3r2g35rh4w-1;
        Fri, 09 Jun 2023 11:50:40 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359Boelu019475;
        Fri, 9 Jun 2023 11:50:40 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 359BodTV019472;
        Fri, 09 Jun 2023 11:50:40 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 47F8D5F1A; Fri,  9 Jun 2023 17:20:39 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        tglx@linutronix.de, maz@kernel.org, mani@kernel.org,
        robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 0/5] Add devicetree support for SDX75 Modem and IDP
Date:   Fri,  9 Jun 2023 17:20:33 +0530
Message-Id: <1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SvpVtmEuWJbIVHthEpXTdoY8avObjHWg
X-Proofpoint-ORIG-GUID: SvpVtmEuWJbIVHthEpXTdoY8avObjHWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=536 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090100
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v4:
 - Addressed some of the dt bindings check mentioned by Krzysztof.

Changes in v3:
 - Clubbed all the dt node into a single patch as suggested by Krzysztof.
 - Removed the applied patch.
 - Addressed some comments from Konrad and Dmitry.

Changes in v2:
 - Added the CPUFreq support patch.
 - Collected the Acked by tags.
 - Addressed some minor comments from Konrad.

This series adds devicetree support for Qualcomm SDX75 platform and IDP
board. This series functionally depends on GCC and RPMh Clock support
series [1], and pinctrl support for SDX75 [2] which are under review.

With this current devicetree support, the IDP can boot into initramfsshell.

[1] https://lore.kernel.org/lkml/20230419133013.2563-3-quic_tdas@quicinc.com/
[2] https://lore.kernel.org/all/1684409015-25196-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.


Rohit Agarwal (5):
  dt-bindings: arm: qcom: Document SDX75 platform and boards
  dt-bindings: firmware: scm: Add compatible for SDX75
  dt-bindings: interrupt-controller: Add SDX75 PDC compatible
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75 compatible
  arm64: dts: qcom: Add SDX75 platform and IDP board support

 Documentation/devicetree/bindings/arm/qcom.yaml    |   7 +
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   1 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sdx75-idp.dts             |  33 +
 arch/arm64/boot/dts/qcom/sdx75.dtsi                | 670 +++++++++++++++++++++
 7 files changed, 714 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi

-- 
2.7.4

