Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF676E8AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjDTHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjDTHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:12:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378426B3;
        Thu, 20 Apr 2023 00:12:46 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K48Xhr021482;
        Thu, 20 Apr 2023 07:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=37XHkCZOOQ8eC/NsJV5nE4fRFYXWaAq93jLiXc8uf0I=;
 b=owKsn03JOuJ256QOS24SWhNwq+TgzPpo1N9NMghJ8g+Jr8dkGfMQygdtPr/iTnX6q8/i
 pyRTH1L328IO8259OdsQVTn70JovB7EXBWk6aYBLSQAshp22pUgSewMa6UdU3tfbuJ6I
 88kbk9TT4oi3cc7c/3xQdbXhTD9TrSnSosLeEPwToIAcFcOHh4b4MW5aUEDdf9FUybN3
 fORmhwOtGZhWqEhyTzJVIkw8S8nS+ayJVERJGfsRMBQ7T3WzEXcp/9iBAYnSbqDpwX8F
 uRSt/ZrMDAjzfqUBvqxh5GvURUUpZmzXzbWgu8Gf9iVC403n6QUG1jKMoo6TrAvb87qI Qw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2p7as6qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 07:12:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33K7Cg17012729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 07:12:42 GMT
Received: from [10.216.57.203] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 20 Apr
 2023 00:12:38 -0700
Message-ID: <52028f1a-e7f4-0ffe-e359-d95fbbc86cf0@quicinc.com>
Date:   Thu, 20 Apr 2023 12:42:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V6 0/3] rpmsg signaling/flowcontrol patches
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1681971690-28858-1-git-send-email-quic_sarannya@quicinc.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1681971690-28858-1-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TOWT3vKEL1cs4b_NXUyknD8i0EvhrizE
X-Proofpoint-ORIG-GUID: TOWT3vKEL1cs4b_NXUyknD8i0EvhrizE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_04,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=989
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200058
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2023 11:51 AM, Sarannya S wrote:
> Added new IOCTLS- RPMSG_GET_OUTGOING_FLOWCONTROL and RPMSG_SET_INCOMING_FLOWCONTROL
> to get/set the rpmsg char device's flow control signal.
> Updated the cmd name 'RPM_CMD_SIGNALS' to 'GLINK_CMD_SIGNALS'.
> Changed 'remote_flow' to bool type, and updated it's evaluation.
> Updated evaluation of 'set' in rpmsg_char as 'set = !!arg'.
> Add destination address of endpoint as parameter in rpmsg_set_flow_control.
> Addressed review comments to change variable names/descriptions.

Something to notice, you are not changing the version number as you have 
sent v6 here again.

Also maintain the changes happened from the last patch series properly.
Like

Changes in v6:
  - ..
  - ..

Change in v5: (a lore kernel link will be helpful here for reviewer to 
remind the conversation happened during last review)
  - ..
  - ..



--Mukesh

> 
> Chris Lew (2):
>    rpmsg: glink: Add support to handle signals command
>    rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
> 
> Deepak Kumar Singh (1):
>    rpmsg: core: Add signal API support
> 
>   drivers/rpmsg/qcom_glink_native.c | 64 +++++++++++++++++++++++++++++++++++++++
>   drivers/rpmsg/rpmsg_char.c        | 49 ++++++++++++++++++++++++++----
>   drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++++
>   drivers/rpmsg/rpmsg_internal.h    |  2 ++
>   include/linux/rpmsg.h             | 15 +++++++++
>   include/uapi/linux/rpmsg.h        | 11 ++++++-
>   6 files changed, 155 insertions(+), 7 deletions(-)
> 
