Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEE64B2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiLMJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiLMJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:49:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D391DF84;
        Tue, 13 Dec 2022 01:49:55 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD7gwPt005496;
        Tue, 13 Dec 2022 09:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jyRFcEYbCAGOwHyG7yTZo9lOauMWyhtaWoRjshBIHmM=;
 b=f1qTIed/n1AVSaXmpRYPN52n4Y6NFNx/xFRerDbSdo+xfky/D6/47l+8Ub8h5/UnWCMg
 lKi1KOMUAx1o+Nw+ERaZ9uqZ1z71dQlYkbl6qed8GJVmq6jSGNgZ7wUyBdqQ2o3iqtE9
 gTz9r8wYdybJd4dPtqOuWNg/Y25oNIRmm44OY/xr1L4Gn0FUtLuegBYep5TQti2KvORr
 GHFJOSH7HAPn990rfP/bk/y+0wNUL88APREfZSTr3OtnCGMOkcfYeHfQWkahIz9nCMyb
 C/ACCAhJg39OP1EAMXKNck/L+26BJkrHGQd4Y+wCFE9hz1CcHA4BUZNzu4/L/r/n/9yn Ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meh7u8ud0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:49:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BD9n8Mc026380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:49:09 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 01:49:02 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>,
        <corbet@lwn.net>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 0/2] Update section header name check
Date:   Tue, 13 Dec 2022 15:18:47 +0530
Message-ID: <1670924929-26507-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4HxwTjFWrxsg_5gETpFqeDTi4YVE3OmS
X-Proofpoint-ORIG-GUID: 4HxwTjFWrxsg_5gETpFqeDTi4YVE3OmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=886 impostorscore=0 clxscore=1011 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update section header name check and corresponding documentation.

Changes since v1:
    -- Update the commit message.
	-- Use strstarts instead of strstr.
	-- Update documentation file.
	
Srinivasa Rao Mandadapu (2):
  remoteproc: elf_loader: Update resource table name check
  docs: remoteproc: Update section header name requirement

 Documentation/staging/remoteproc.rst       | 2 ++
 drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.7.4

