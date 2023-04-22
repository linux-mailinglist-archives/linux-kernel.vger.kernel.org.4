Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B56EBB0D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDVTxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 15:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 15:52:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4A1998;
        Sat, 22 Apr 2023 12:52:58 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33MJibxM008268;
        Sat, 22 Apr 2023 19:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QkzYTtZavaI3dVG2dI9TcdW5SxhPXbG2yuGeqx1Htzc=;
 b=gX1TrWUujkpZeBSy6qpVXPXxcoxf0GTHZKw3S2U3TJlfrwBE+9w4AtiIa2PZ0fLQa3Kr
 QFVT2KDLeecPfIjKzleRvNdXXI8PI8vW1g0qKYEtGcYKXn9D1zMj302BPTw9zDafc/QG
 S3bD86PcZNaoZlMxKJ0Ar5hbnmCHRYB12Jep9dZWhrs3BEVKYAfoHTLlB/EHGWsg7bYD
 MhV/TadIEl4fhMqFgWpoW+BpBRvW2b6NnjsuqXiMH3KRX+eiNyeM49mhYAxtzda0zNur
 BzM/eXQMFDhOINJn0h7fhdOia05Sdvu+MTytfyDRsyRRnzwtGMUnjHYCRnewljK2WK+p Rw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48ch0tj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 19:52:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33MJqmtq013298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 19:52:48 GMT
Received: from [10.110.78.235] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 22 Apr
 2023 12:52:47 -0700
Message-ID: <eb88f4de-4254-f315-1e98-fcdc712daf1a@quicinc.com>
Date:   Sat, 22 Apr 2023 12:52:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V7 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL
 support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-4-git-send-email-quic_sarannya@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <1682160127-18103-4-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -2voPLIpA1xfT3gwE61zxR2N_y_Yxgkt
X-Proofpoint-GUID: -2voPLIpA1xfT3gwE61zxR2N_y_Yxgkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-22_14,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=884 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304220183
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/2023 3:42 AM, Sarannya S wrote:
> From: Chris Lew <quic_clew@quicinc.com>
> 
> Add RPMSG_GET_OUTGOING_FLOWCONTROL and RPMSG_SET_INCOMING_FLOWCONTROL
> IOCTL support for rpmsg char device nodes to get/set the low level
> transport signals.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>

[...]

>   
>   static const struct file_operations rpmsg_eptdev_fops = {
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index 1637e68..c955e27 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -10,7 +10,6 @@
>   #include <linux/types.h>
>   
>   #define RPMSG_ADDR_ANY		0xFFFFFFFF
> -

What is need of deleting this line in this patch? I am not sure if this 
was asked in earlier reviews.

---Trilok Soni
