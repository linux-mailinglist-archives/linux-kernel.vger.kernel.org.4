Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1A6971A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjBNXOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjBNXOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:14:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDCCA26F;
        Tue, 14 Feb 2023 15:14:20 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGUAsO008732;
        Tue, 14 Feb 2023 23:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BFjOj0iAZj0jpbxYxNKUBJKv1Zdoc7mNQv09Ov/bF4M=;
 b=HT5lAB4SZ5O9RDDVAon5LCMrnHe8o2fPLGrxEDkGCHbYMQKlLZxRJogcIRa1yV7/Gpt/
 yBYjTTfP+J6Zxv5AGd/TkmbpI3sIxounODt+ziCPmeeTTW6UPMwcPdMhzhLqBMCaut9t
 qo6COW5wwuxT+NgJgKFoR+kguR6kOguummSYEI5wFb3pC4teUc0s58+lt3QoC5nXrXNr
 85GnvnL869h5sJXKevtb+1KAyberhdrv6Y745MEzxbUaX2ZPZ40gu8MqjccD9zjcZoem
 wM99qpvtmbkAlh9OLuBivR6Inn1hlAv/zPN9IenplfZQ3GfO4bGB8YyJtzcopPytr+qi /A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmm9fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:14:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ENEGvK005900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:14:16 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 15:14:16 -0800
Subject: Re: [PATCH] rpmsg: glink: Fix spelling of peek
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230214224746.1996130-1-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <0d90b7d9-977a-6aa6-6654-0fc239346c63@quicinc.com>
Date:   Tue, 14 Feb 2023 15:14:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230214224746.1996130-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b5Mujf9q35WGPs7G2TK_gijF3PfahyA0
X-Proofpoint-GUID: b5Mujf9q35WGPs7G2TK_gijF3PfahyA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140200
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 2:47 PM, Bjorn Andersson wrote:
> The code is peeking into the buffers, not peaking. Fix this throughout
> the glink drivers.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Can't believe we didn't catch this earlier :)

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

> ---
>   drivers/rpmsg/qcom_glink_native.c | 14 +++++++-------
>   drivers/rpmsg/qcom_glink_native.h |  2 +-
>   drivers/rpmsg/qcom_glink_rpm.c    |  4 ++--
>   drivers/rpmsg/qcom_glink_smem.c   |  4 ++--
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 324c75d59a6f..7a3cac62ecfa 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -274,10 +274,10 @@ static size_t qcom_glink_rx_avail(struct qcom_glink *glink)
>   	return glink->rx_pipe->avail(glink->rx_pipe);
>   }
>   
> -static void qcom_glink_rx_peak(struct qcom_glink *glink,
> +static void qcom_glink_rx_peek(struct qcom_glink *glink,
>   			       void *data, unsigned int offset, size_t count)
>   {
> -	glink->rx_pipe->peak(glink->rx_pipe, data, offset, count);
> +	glink->rx_pipe->peek(glink->rx_pipe, data, offset, count);
>   }
>   
>   static void qcom_glink_rx_advance(struct qcom_glink *glink, size_t count)
> @@ -808,7 +808,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
>   
>   	INIT_LIST_HEAD(&dcmd->node);
>   
> -	qcom_glink_rx_peak(glink, &dcmd->msg, 0, sizeof(dcmd->msg) + extra);
> +	qcom_glink_rx_peek(glink, &dcmd->msg, 0, sizeof(dcmd->msg) + extra);
>   
>   	spin_lock(&glink->rx_lock);
>   	list_add_tail(&dcmd->node, &glink->rx_queue);
> @@ -841,7 +841,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
>   		return -EAGAIN;
>   	}
>   
> -	qcom_glink_rx_peak(glink, &hdr, 0, sizeof(hdr));
> +	qcom_glink_rx_peek(glink, &hdr, 0, sizeof(hdr));
>   	chunk_size = le32_to_cpu(hdr.chunk_size);
>   	left_size = le32_to_cpu(hdr.left_size);
>   
> @@ -906,7 +906,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
>   		goto advance_rx;
>   	}
>   
> -	qcom_glink_rx_peak(glink, intent->data + intent->offset,
> +	qcom_glink_rx_peek(glink, intent->data + intent->offset,
>   			   sizeof(hdr), chunk_size);
>   	intent->offset += chunk_size;
>   
> @@ -973,7 +973,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
>   	if (!msg)
>   		return;
>   
> -	qcom_glink_rx_peak(glink, msg, 0, msglen);
> +	qcom_glink_rx_peek(glink, msg, 0, msglen);
>   
>   	for (i = 0; i < count; ++i) {
>   		intent = kzalloc(sizeof(*intent), GFP_ATOMIC);
> @@ -1030,7 +1030,7 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
>   		if (avail < sizeof(msg))
>   			break;
>   
> -		qcom_glink_rx_peak(glink, &msg, 0, sizeof(msg));
> +		qcom_glink_rx_peek(glink, &msg, 0, sizeof(msg));
>   
>   		cmd = le16_to_cpu(msg.cmd);
>   		param1 = le16_to_cpu(msg.param1);
> diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
> index 9462b37eccee..8dbec24de23e 100644
> --- a/drivers/rpmsg/qcom_glink_native.h
> +++ b/drivers/rpmsg/qcom_glink_native.h
> @@ -17,7 +17,7 @@ struct qcom_glink_pipe {
>   
>   	size_t (*avail)(struct qcom_glink_pipe *glink_pipe);
>   
> -	void (*peak)(struct qcom_glink_pipe *glink_pipe, void *data,
> +	void (*peek)(struct qcom_glink_pipe *glink_pipe, void *data,
>   		     unsigned int offset, size_t count);
>   	void (*advance)(struct qcom_glink_pipe *glink_pipe, size_t count);
>   
> diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
> index 5179f834a10f..f94bb7d4f1ec 100644
> --- a/drivers/rpmsg/qcom_glink_rpm.c
> +++ b/drivers/rpmsg/qcom_glink_rpm.c
> @@ -81,7 +81,7 @@ static size_t glink_rpm_rx_avail(struct qcom_glink_pipe *glink_pipe)
>   		return head - tail;
>   }
>   
> -static void glink_rpm_rx_peak(struct qcom_glink_pipe *glink_pipe,
> +static void glink_rpm_rx_peek(struct qcom_glink_pipe *glink_pipe,
>   			      void *data, unsigned int offset, size_t count)
>   {
>   	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
> @@ -333,7 +333,7 @@ static int glink_rpm_probe(struct platform_device *pdev)
>   
>   	/* Pipe specific accessors */
>   	rpm->rx_pipe.native.avail = glink_rpm_rx_avail;
> -	rpm->rx_pipe.native.peak = glink_rpm_rx_peak;
> +	rpm->rx_pipe.native.peek = glink_rpm_rx_peek;
>   	rpm->rx_pipe.native.advance = glink_rpm_rx_advance;
>   	rpm->tx_pipe.native.avail = glink_rpm_tx_avail;
>   	rpm->tx_pipe.native.write = glink_rpm_tx_write;
> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 05b4fe0a7387..7a982c60a8dd 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -91,7 +91,7 @@ static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
>   		return head - tail;
>   }
>   
> -static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
> +static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
>   			       void *data, unsigned int offset, size_t count)
>   {
>   	struct glink_smem_pipe *pipe = to_smem_pipe(np);
> @@ -324,7 +324,7 @@ struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
>   
>   	rx_pipe->smem = smem;
>   	rx_pipe->native.avail = glink_smem_rx_avail;
> -	rx_pipe->native.peak = glink_smem_rx_peak;
> +	rx_pipe->native.peek = glink_smem_rx_peek;
>   	rx_pipe->native.advance = glink_smem_rx_advance;
>   
>   	tx_pipe->smem = smem;
> 
