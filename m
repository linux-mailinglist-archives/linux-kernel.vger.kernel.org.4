Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFC1673191
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjASGMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjASGMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:12:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165A4DBEE;
        Wed, 18 Jan 2023 22:12:00 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J4AB0J027488;
        Thu, 19 Jan 2023 06:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ndoih95BtyqHjZ2gHLIS1jsE7+cfyr3PpCgTpjy8BiY=;
 b=LycrCrxBz7+i4/oAYXkGYiPjaKAPLrt7qCOMil6i687H8BI0gMX+EN0s39QXrC3Zc29z
 nmGxwfbDfdBJmlY8aNluIQfWZV0kiYWgpKJtUnR0N9kEHyMYc4/hcXNshPXcLewQMzWz
 E/krbF+EJC2+4s6ga9Jh3yCKFgespNlF7LmcPjutL8aZBjAgxU+V1wfS2w6gWdbdEV2t
 J9zUrBDwySrOIvcn0MQgCxBRlTDSL/SapwoSSFDfWWEz++3sLMohoEqJ8xwpandvGV5q
 InE7amxzwpp6jwb39cWRYIBDxq/ayRVgrlGIc4lLOw6YJbj0onOgJcYvJ9PDzXNqSNbB Iw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vjbgcg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 06:11:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J6BXf1021111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 06:11:33 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 22:11:27 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 0/3] Update lpass dt-bindings
Date:   Thu, 19 Jan 2023 11:41:11 +0530
Message-ID: <1674108674-8392-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aSyoPueBklSXdRfDQUCx70P2AH-V-SrZ
X-Proofpoint-GUID: aSyoPueBklSXdRfDQUCx70P2AH-V-SrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=861
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190048
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update va-macro driver dt-bindings and add missing properties in sc7280 
machine driver dt-bindings.

Srinivasa Rao Mandadapu (3):
  ASoC: qcom: dt-bindings: lpass-va-macro: Update clock name
  ASoC: google: dt-bindings: sc7280: Add platform property
  ASoC: google: dt-bindings: sc7280: Add #sound-dai-cells property

 .../devicetree/bindings/sound/google,sc7280-herobrine.yaml | 14 ++++++++++++++
 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml     |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.7.4

