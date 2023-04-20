Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC36E8A28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjDTGJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjDTGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:09:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6F4680;
        Wed, 19 Apr 2023 23:09:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K4eYlK031646;
        Thu, 20 Apr 2023 06:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6w5K+Mk7hdpNhLg++HOxNjdTmWn0JIggDB70drsLPDo=;
 b=DU87snG0P6RoUcRqmH9vlp/+F8kz2Y+Z31lzEvLA0BcqGh2cvG6l+ueVFQzfXcQ0LI4C
 LESMrFSW1lDHaWLWChe15nRrNPRqo3eWBvbDfqLAshJKwDt1I5xAB6pLyAlO9E29C771
 +nixKtvwXJWOYo3xr4gMdVk0BFPN2Dn2ErRQZq07sjpoSShvgRL7UVu5Ked1yAZ940yD
 G+qpAa/elSG9pOr8tFEU0IY44k/O7Cu/PtBO4lsNXyfyFN8SSRI9Aex3EQUXljVvgP9f
 VfduNGINZ1qFYUYLTGcGUCHxBSz2a9eM93vKn8L4Hgtaa37SiJKrHTpHMB+DFZK0kUVk Wg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2nn815gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:09:18 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33K68v2p021269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:08:57 GMT
Received: from [10.110.10.142] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 23:08:56 -0700
Message-ID: <480c5a09-e6c1-eeb6-fa14-7190f22cf727@quicinc.com>
Date:   Wed, 19 Apr 2023 23:08:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V6 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1681912409-25248-1-git-send-email-quic_sarannya@quicinc.com>
 <1681912409-25248-2-git-send-email-quic_sarannya@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <1681912409-25248-2-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R64ankminEC88hvx7Zkp0ftHcexZR0As
X-Proofpoint-GUID: R64ankminEC88hvx7Zkp0ftHcexZR0As
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_02,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 clxscore=1011 phishscore=0 mlxlogscore=990
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200049
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/2023 6:53 AM, Sarannya S wrote:
> From: Deepak Kumar Singh <quic_deesin@quicinc.com>
> 
> Some transports like Glink support the state notifications between
> clients using flow control signals similar to serial protocol signals.
> Local glink client drivers can send and receive flow control status
> to glink clients running on remote processors.
> 
> Add APIs to support sending and receiving of flow control status by
> rpmsg clients.
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> ---
>   drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>   drivers/rpmsg/rpmsg_internal.h |  2 ++
>   include/linux/rpmsg.h          | 15 +++++++++++++++
>   3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index a2207c0..cd71a6a 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>   EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>   
>   /**
> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> + * @ept:	the rpmsg endpoint
> + * @enable:	pause/resume incoming data flow	
> + * @dst:	destination address of the endpoint
> + *
> + * Return: 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->set_flow_control)
> +		return -ENXIO;
> +
> +	return ept->ops->set_flow_control(ept, enable, dst);
> +}
> +EXPORT_SYMBOL(rpmsg_set_flow_control);

Why not EXPORT_SYMBOL_GPL?

---Trilok Soni

