Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348FA654129
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiLVMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiLVMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:40:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130362C7;
        Thu, 22 Dec 2022 04:40:53 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBBHOV007356;
        Thu, 22 Dec 2022 12:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nqjGoOHjHNSgovETUOR5NWPAiQbG8cHIjvCBrOxlN1k=;
 b=gAqS6hp+uKmgoyl70T+fZtevglk81ed7yWEFtCkDsIPFxHeyseVOC8q7O9ws/3FG5LqC
 WYuoZvnwRWeH//JOonnEtwmjXEOM+7WpcH5jDXbEqtGeEDsvO0QjpIL/ASNxg07a5y5V
 j469yezMdLW+uqT4ZJn8gSF48sdKmMOHaWBuiZPIoamSZGpMy+xdDewug6NO18M1y6V1
 QZKUulORIs+5Rusayv+rerpXJN6GwtU/kwulQ2vTJrfLT5l/9nIUht52ebVY0XEqhn5Z
 IBg5f+bgLoTB6xBtbMUptvuD+n1gzlr6+QHNL6rcEcmBMLIkL++Kic+U+8eph1a8yyUv tw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm0wfjqxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:40:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMCehED019868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:40:43 GMT
Received: from [10.216.55.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 22 Dec
 2022 04:40:41 -0800
Message-ID: <1ab41b6b-545a-4a51-97d6-0020381736e3@quicinc.com>
Date:   Thu, 22 Dec 2022 18:10:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] Update the channel list if the change in channel
 flags
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>
References: <20221222120529.31436-1-quic_youghand@quicinc.com>
Content-Language: en-US
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <20221222120529.31436-1-quic_youghand@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QYy0BnwG_A8vWTgjix_0hpfs1pdPkQdq
X-Proofpoint-GUID: QYy0BnwG_A8vWTgjix_0hpfs1pdPkQdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_06,2022-12-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220111
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/22/2022 5:35 PM, Youghandhar Chintala wrote:
> There are connection failures in hidden SSID case when the device is with
> default reg domain WW.
> For WW reg domain most of the 5 GHz channels are passive. When device
> listens to the beacon on that channel, the driver is updating its channel
> flag but firmware is not aware of it and firmware is not sending probes
> on that channels.
> Due to this, we are seeing connection failures when the device is tries to
> connect with hidden SSID AP.
> Whenever the driver detects a channel flag change, send the updated channel
> list command to the firmware.
>
> Youghandhae Chintala (2):
>    wifi: cfg80211: Add beacon hint notifier support
>    wifi: ath10k: update the channel list if change in channel flags.
>
>   drivers/net/wireless/ath/ath10k/mac.c | 11 +++++++++++
>   include/net/cfg80211.h                |  2 ++
>   net/wireless/reg.c                    |  5 ++++-
>   3 files changed, 17 insertions(+), 1 deletion(-)

Hi All,

My bad. Wrong list added. Please ignore this series. I will resend to 
right list.

Regards,

Youghandhar

