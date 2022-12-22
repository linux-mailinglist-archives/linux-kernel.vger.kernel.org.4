Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77646540CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiLVMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiLVMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:12:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F512CCA6;
        Thu, 22 Dec 2022 04:06:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBmY1L015206;
        Thu, 22 Dec 2022 12:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=r/pPEbroEmGbejvtkaFEgasQ1s3Bh3a8Jr/qPya89Iw=;
 b=eXF3NFI2PspEnrZ7uEaBWKYYG/68d3J6FyG0Qbefmm2rbj1vrYymLieEhiJn4m/9dHEA
 4qDB1g1ABuU3BBG/N5+gDqZf5V2v5CFOeuu0BoL502DUuJFBym46AbxwYmikuvFQfzwJ
 7t+gSQ4jd3FrPnry3CAKVSG7mH7X08Bq+hsvcDPm8XUKgD9JPUuQwrljyNkM+pHpTHDy
 wY2n1Joplxgj50/JYk9ZUENZGiBKtVwfFDt2hhWiRAKmopT56qeR6JnVtuTzRRPaeRE9
 guFX73GBLjCdrX/1KeFUiQdKmg4kUYSitlpDO1plF1J7V2z2zYC+lgxlY+nD8FlG5VQt Jg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm5r2j2vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:05:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMC5q5Y012341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:05:52 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 04:05:50 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 0/2] Update the channel list if the change in channel flags 
Date:   Thu, 22 Dec 2022 17:35:27 +0530
Message-ID: <20221222120529.31436-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SgtG3stDz-2jJBmmxQ_-XzQBBylySYjf
X-Proofpoint-ORIG-GUID: SgtG3stDz-2jJBmmxQ_-XzQBBylySYjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_06,2022-12-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=781 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

