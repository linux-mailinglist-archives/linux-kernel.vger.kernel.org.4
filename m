Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CD654133
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiLVMnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiLVMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:43:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142AF26A84;
        Thu, 22 Dec 2022 04:43:18 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBcOAk012045;
        Thu, 22 Dec 2022 12:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=r/pPEbroEmGbejvtkaFEgasQ1s3Bh3a8Jr/qPya89Iw=;
 b=doJQuSyGmkxI4Hy9QlgaacZXH/4oIwaJgsmEpPZquP9oFdiqW0WGJu+t5cUEg1lizSPY
 tLj56qF+yMGe6d8IbSnYN1xXIzbTb7NhtxkCjCnLpOuhybqgGwHZOoR1B1IvzAF2yOSJ
 +SHIiRN9u+29vgQEsOl+JISB9iE/LMaIOhKJaGu3BljNPGI2Mg1xURv3V37D9DYJbsSX
 P0U2EVQy+lZNeACrtCvwk56R7pSJJD420ipbYlaXv3vyteOkmliDqw70PUndFgKRglOe
 WRHrVlyV3VY+O/7K+MJ3Oa7VRaPXw33AZOJxqizzp2EroYBbZ2wFgZzVsxPlipnYTQpH 1w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm8x39m56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:43:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMChAmW020877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:43:10 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 04:43:08 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 0/2] Update the channel list if the change in channel flags 
Date:   Thu, 22 Dec 2022 18:12:19 +0530
Message-ID: <20221222124221.30894-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CX5wimk5mAOc1XVhF0oPOw09ssxH-CXE
X-Proofpoint-GUID: CX5wimk5mAOc1XVhF0oPOw09ssxH-CXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_05,2022-12-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212220111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are connection failures in hidden SSID case when the device is with
default reg domain WW.
For WW reg domain most of the 5 GHz channels are passive. When device
listens to the beacon on that channel, the driver is updating its channel
flag but firmware is not aware of it and firmware is not sending probes
on that channels.
Due to this, we are seeing connection failures when the device is tries to
connect with hidden SSID AP.
Whenever the driver detects a channel flag change, send the updated channel
list command to the firmware.

Youghandhae Chintala (2):
  wifi: cfg80211: Add beacon hint notifier support
  wifi: ath10k: update the channel list if change in channel flags.

 drivers/net/wireless/ath/ath10k/mac.c | 11 +++++++++++
 include/net/cfg80211.h                |  2 ++
 net/wireless/reg.c                    |  5 ++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.38.0

