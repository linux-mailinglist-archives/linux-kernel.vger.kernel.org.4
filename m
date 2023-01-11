Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA766655EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjAKIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjAKIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:22:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A15FD9;
        Wed, 11 Jan 2023 00:22:17 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B81HIh024541;
        Wed, 11 Jan 2023 08:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=4FYnXEeJ5EbrufiM75NTGqsaVjICHmXYbKsx49ByQdI=;
 b=eX/q+DEJ+VuCbi7B5tfIukmUEGak9ES6hwQJ7h32uwGWLZDizz9EyWfoU1RwaCMVP2bv
 x4VuS6h29tkAEdbw92BTs47ZrYD/5M9ba1cf0okIOTZPQWasIAa4ljyKhtsbJ6XL8jVt
 H6i5wiGUkKVOgMbuSKioElwVqOrqxAoQ/qV1W2MqSTFHh6ECkjgS7kLMYUaRyvbzvqvk
 cUR8LZt1OMi3EQmprsiNnQllRGRCorIRDOu5FyD9TvFQ8Z2nXh71a2Ef/Vol5sDSpPq6
 p6Dg+U0b8uz8NaGQh+KkzqvTn/XJ/6JCHG4vl5qiUTspd8PV2L41XV6uVlzYnWivLYWY Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kbq8rf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 08:22:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30B8M56m021299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 08:22:05 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 00:22:02 -0800
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>
Subject: [PATCH 0/2] soc: qcom: socinfo: Add fields in sysfs custom attributes
Date:   Wed, 11 Jan 2023 13:51:39 +0530
Message-ID: <20230111082141.18109-1-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qfu1kxRbu6pTRd8W7l5SAV9RV9154VRD
X-Proofpoint-ORIG-GUID: Qfu1kxRbu6pTRd8W7l5SAV9RV9154VRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=867 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support to have SoC info fields available in sysfs
to enable the use of these nodes in userland scripts and test scripts.
This is to provide the interface to these scripts to find the details of
parts present in the SoC and decide to execute a set of shell commands,
that are supported/required for these parts. The decision to extend sysfs
interface is taken as debugfs is not mounted by default and the use cases
for this information are not essentially for debug.

The patches add the following changes:
1. Restructure the code to make the scope of socinfo variable, from
   function to file. Also, make the socinfo variable name more descriptive.
2. Extend the sysfs custom attributes to incorporate fields introduced in
   socinfo format version 2 to 6. Add name mappings for hw_platform field
   to make the sysfs information more descriptive.

Support for versions 7 and above will be added in future patchsets.

Also, patch 2 depends on patch 1 in the series.

Naman Jain (2):
  soc: qcom: socinfo: Change socinfo variable name and scope
  soc: qcom: socinfo: Add sysfs attributes for fields in v2-v6

 drivers/soc/qcom/socinfo.c | 261 +++++++++++++++++++++++++++++++------
 1 file changed, 223 insertions(+), 38 deletions(-)

-- 
2.17.1

