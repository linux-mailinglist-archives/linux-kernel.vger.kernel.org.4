Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62D72C3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjFLMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjFLMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:07:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2010EB5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:07:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f644dffd71so5005223e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686571626; x=1689163626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmfHMfm/QZbaLCmlMQ4zvEcNR/SiU66kdau8E/a1GJk=;
        b=aZLGPwcK+PmzDbxtslqxfBhuVo/a8rJkhT4/binDK8Yab3fjaQmqez4VG3S3escKhi
         YnOpxYG7f5DyJ3NKmwywcWnisExoWHckaicT2heAacYlDoo597JQsubHgldXvrReUMP+
         LuKahVJtHLmIjYokfYzIq+djbEi8XR9w/NgkNhl2Brx6xjzu7j0cCYJWKj5IPeDlB0Vl
         nDtKlD5q5Cms0mhNM6nLbS3dukOJJI9CKF9aY2WoewXHI4ouQ6xH2M6zLCuA1dbNhMMX
         hkZk+c4B2zWTuTjxoetRxJLFd/MLCe8tck8thTxFCsEmOTGgzd7ORu0uN+/7gJXrISQs
         jL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686571626; x=1689163626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmfHMfm/QZbaLCmlMQ4zvEcNR/SiU66kdau8E/a1GJk=;
        b=J9J/4x8nUyf56FXu6Ru9nWPTbv4C2z+1nMp27E3y/R7wrlXny1OZv0AOXReb4MU2z8
         0SjP1FfOKBI/kj0Dtj3AOLZqKa0yygrHhW1uNHIIc5VdKV9i8F5Hm00tsN5QcIcDK4Fc
         q/XvDTnxBvT46qTq6NCGgf8dOxzFP3aqLIIC2JehbmxuDF3Tb7SgETiImrtvZeh/5CPx
         R2jL+i3QMtapXzig4t5gNfFuD7M4vSyYGSzWrNVDojEu3OPgSUcfZckmzq+3T+ZITpWt
         968jbZhXrZUPzQDG29RERQzec3fAJBDIULKdXyt1GSYItDYd1i6tT+898KP4NHqZGWAv
         8m7Q==
X-Gm-Message-State: AC+VfDzo3DW0cayXWTzjIWsIR+kHPWhXM2ZDlqxgLk8Xu8goZZgWzwDJ
        ZkBqz5ns/fKKsiuNawI7GoljGm8QlfgJSo5RJJE=
X-Google-Smtp-Source: ACHHUZ4dsXqJxPR7N+XXrWVJdsnFa7kd6Dfnt8y1ebrPc5TW+mnhPQ69RNxDbK2MQJlqNMyFI8yn+A==
X-Received: by 2002:ac2:4d9b:0:b0:4f3:a61d:19d2 with SMTP id g27-20020ac24d9b000000b004f3a61d19d2mr3711812lfe.36.1686571626179;
        Mon, 12 Jun 2023 05:07:06 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id x25-20020a05600c21d900b003f60faa4612sm11264878wmj.22.2023.06.12.05.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:07:05 -0700 (PDT)
Message-ID: <c9ec63d0-7b41-1757-b8d0-47d07cb50d1f@linaro.org>
Date:   Mon, 12 Jun 2023 13:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] misc: fastrpc: Collect driver-remote processor
 transaction logs
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com
References: <1686070555-11154-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1686070555-11154-1-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2023 17:55, Ekansh Gupta wrote:
> Add changes to collect driver-remote processor rpmsg transaction
> logs. These logs will carry payload information for the rpmsg message
> instance. These logs are channel specific and are collected in
> channel context structure.
> 

Can you provide details on who is the actual consumer of this?

Are you planning to dump this data via devcoredumps?

--srini

> These rpmsg transaction logs can help in improving debugability as
> all requests from processes are getting captured in channel context
> structure.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..6447cee 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -104,6 +104,9 @@
>   
>   #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>   
> +/* Length of glink transaction history to store */
> +#define GLINK_MSG_HISTORY_LEN	(128)
> +
>   static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>   						"sdsp", "cdsp"};
>   struct fastrpc_phy_page {
> @@ -181,6 +184,28 @@ struct fastrpc_invoke_rsp {
>   	int retval;		/* invoke return value */
>   };
>   
> +struct fastrpc_tx_msg {
> +	struct fastrpc_msg msg;	/* Msg sent to remote subsystem */
> +	int rpmsg_send_err;	/* rpmsg error */
> +	s64 ns;			/* Timestamp (in ns) of msg */
> +};
> +
> +struct fastrpc_rx_msg {
> +	struct fastrpc_invoke_rsp rsp;	/* Response from remote subsystem */
> +	s64 ns;		/* Timestamp (in ns) of response */
> +};
> +
> +struct fastrpc_rpmsg_log {
> +	u32 tx_index;	/* Current index of 'tx_msgs' array */
> +	u32 rx_index;	/* Current index of 'rx_msgs' array */
> +	/* Rolling history of messages sent to remote subsystem */
> +	struct fastrpc_tx_msg tx_msgs[GLINK_MSG_HISTORY_LEN];
> +	/* Rolling history of responses from remote subsystem */
> +	struct fastrpc_rx_msg rx_msgs[GLINK_MSG_HISTORY_LEN];
> +	spinlock_t tx_lock;
> +	spinlock_t rx_lock;
> +};
> +
>   struct fastrpc_buf_overlap {
>   	u64 start;
>   	u64 end;
> @@ -277,6 +302,7 @@ struct fastrpc_channel_ctx {
>   	struct fastrpc_device *fdevice;
>   	struct fastrpc_buf *remote_heap;
>   	struct list_head invoke_interrupted_mmaps;
> +	struct fastrpc_rpmsg_log gmsg_log[FASTRPC_DEV_MAX];
>   	bool secure;
>   	bool unsigned_support;
>   	u64 dma_mask;
> @@ -1097,6 +1123,64 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	return 0;
>   }
>   
> +static s64 get_timestamp_in_ns(void)
> +{
> +	s64 ns = 0;
> +	struct timespec64 ts;
> +
> +	ktime_get_real_ts64(&ts);
> +	ns = timespec64_to_ns(&ts);
> +	return ns;
> +}
> +
> +static void fastrpc_update_txmsg_buf(struct fastrpc_channel_ctx *chan,
> +				struct fastrpc_msg *msg, int rpmsg_send_err, s64 ns)
> +{
> +	unsigned long flags = 0;
> +	u32 tx_index = 0;
> +	struct fastrpc_tx_msg *tx_msg = NULL;
> +
> +	spin_lock_irqsave(&(chan->gmsg_log[chan->domain_id].tx_lock), flags);
> +
> +	tx_index = chan->gmsg_log[chan->domain_id].tx_index;
> +	tx_msg = &(chan->gmsg_log[chan->domain_id].tx_msgs[tx_index]);
> +
> +	memcpy(&tx_msg->msg, msg, sizeof(struct fastrpc_msg));
> +	tx_msg->rpmsg_send_err = rpmsg_send_err;
> +	tx_msg->ns = ns;
> +
> +	tx_index++;
> +	chan->gmsg_log[chan->domain_id].tx_index =
> +		(tx_index > (GLINK_MSG_HISTORY_LEN - 1)) ? 0 : tx_index;
> +
> +	spin_unlock_irqrestore(&(chan->gmsg_log[chan->domain_id].tx_lock), flags);
> +}
> +
> +static void fastrpc_update_rxmsg_buf(struct fastrpc_channel_ctx *chan,
> +							u64 ctx, int retval, s64 ns)
> +{
> +	unsigned long flags = 0;
> +	u32 rx_index = 0;
> +	struct fastrpc_rx_msg *rx_msg = NULL;
> +	struct fastrpc_invoke_rsp *rsp = NULL;
> +
> +	spin_lock_irqsave(&(chan->gmsg_log[chan->domain_id].rx_lock), flags);
> +
> +	rx_index = chan->gmsg_log[chan->domain_id].rx_index;
> +	rx_msg = &(chan->gmsg_log[chan->domain_id].rx_msgs[rx_index]);
> +	rsp = &rx_msg->rsp;
> +
> +	rsp->ctx = ctx;
> +	rsp->retval = retval;
> +	rx_msg->ns = ns;
> +
> +	rx_index++;
> +	chan->gmsg_log[chan->domain_id].rx_index =
> +		(rx_index > (GLINK_MSG_HISTORY_LEN - 1)) ? 0 : rx_index;
> +
> +	spin_unlock_irqrestore(&(chan->gmsg_log[chan->domain_id].rx_lock), flags);
> +}
> +
>   static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>   			       struct fastrpc_invoke_ctx *ctx,
>   			       u32 kernel, uint32_t handle)
> @@ -1124,6 +1208,7 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>   
>   	if (ret)
>   		fastrpc_context_put(ctx);
> +	fastrpc_update_txmsg_buf(cctx, msg, ret, get_timestamp_in_ns());
>   
>   	return ret;
>   
> @@ -2323,6 +2408,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   	INIT_LIST_HEAD(&data->users);
>   	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
>   	spin_lock_init(&data->lock);
> +	spin_lock_init(&(data->gmsg_log[data->domain_id].tx_lock));
> +	spin_lock_init(&(data->gmsg_log[data->domain_id].rx_lock));
>   	idr_init(&data->ctx_idr);
>   	data->domain_id = domain_id;
>   	data->rpdev = rpdev;
> @@ -2398,6 +2485,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>   
>   	if (len < sizeof(*rsp))
>   		return -EINVAL;
> +	fastrpc_update_rxmsg_buf(cctx, rsp->ctx, rsp->retval, get_timestamp_in_ns());
>   
>   	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
>   
