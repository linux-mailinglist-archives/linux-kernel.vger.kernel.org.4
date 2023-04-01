Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE366D32AE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjDAQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAQ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 12:57:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E3CC3A;
        Sat,  1 Apr 2023 09:57:33 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 331Fk4VQ027431;
        Sat, 1 Apr 2023 16:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=p+9jihlrSFZgB2eBUCx0dZ9L0V64SZG/10WisCIecLQ=;
 b=o6UTf/lkCz9pc4Ckd7+T5GQfjwXnq0tvF+gAem6ogwfnBe/ImyZOXErlZQl3WgZIbW9E
 y6CUwqOS1hZKMWfAfmGVb/ewYc2NXx5Se3Zl9nuyNdF/6Ez1ZOrhWYEb2xamkRPd45Xx
 lw8OzjH6Z72j/KbtGOjX+r/XAnz4mYoeQPK5373BD5MlCGR4nRWVsOqstwhtLPwfu7mL
 V6JmIStKTeHTuoRRHtBml9M+SawPuT2pMIZAKfygpwy9qNBuMC13p81Im0O0Hyae+9qL
 WZikBjtIztpAjDXw3uu6+2q0p8TPAkHTfjNEDAcecH3coCTwwhDCft5R+k8OxdWrkcws SQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ppcq3h2e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Apr 2023 16:57:31 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 331GvRMv006674;
        Sat, 1 Apr 2023 16:57:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ppdpk2udr-1;
        Sat, 01 Apr 2023 16:57:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331GvQvc006668;
        Sat, 1 Apr 2023 16:57:26 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 331GvQSk006666;
        Sat, 01 Apr 2023 16:57:26 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id F0394504928; Sat,  1 Apr 2023 22:27:25 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_sachgupt@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Sarthak Garg <quic_sartgarg@quicinc.com>
Subject: [PATCH V1 0/2] Introduce new vendor op and export few symbols
Date:   Sat,  1 Apr 2023 22:27:21 +0530
Message-Id: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ZmnscFKtjUJ3lp370yyogy9g4U7TIvw
X-Proofpoint-ORIG-GUID: 8ZmnscFKtjUJ3lp370yyogy9g4U7TIvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=5 priorityscore=1501 mlxscore=5
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0 spamscore=5
 bulkscore=0 mlxlogscore=130 adultscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304010154
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For our earlier discussions on clock scaling and partial init features
we have come up with a new design where we have moved the entire logic
for both the features in our vendor related files.

But to support this new design we need a vendor op in
_mmc_suspend/_mmc_resume functions to control our feature functionality
in suspend/resume paths.
Moreover export of few symbols is also needed to make core layer
functions accessible to our vendor module.

Old discussion for Clock scaling feature :
https://patchwork.kernel.org/project/linux-mmc/cover/1571668177-3766-1-git-send-email-rampraka@codeaurora.org/

Old discussion for Partial init feature :
https://patchwork.kernel.org/project/linux-mmc/patch/1650963852-4173-1-git-send-email-quic_spathi@quicinc.com/

Hence introduce new vendor op in suspend/resume and export few symbols
nedeed for our feature.

Sarthak Garg (2):
  mmc: core: Define new vendor ops to enable internal features
  mmc: core: Export core functions to let vendors use for their features

 drivers/mmc/core/core.c    |  6 ++++++
 drivers/mmc/core/host.c    |  1 +
 drivers/mmc/core/mmc.c     | 31 ++++++++++++++++++++++---------
 drivers/mmc/core/mmc_ops.c |  1 +
 drivers/mmc/core/queue.c   |  1 +
 include/linux/mmc/host.h   |  4 ++++
 6 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.17.1

