Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C286D7443
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjDEGMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbjDEGMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:12:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1C212A;
        Tue,  4 Apr 2023 23:12:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r11so35001028wrr.12;
        Tue, 04 Apr 2023 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680675155; x=1683267155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbX3TeyHNDS5eFyrTFp/ekNijmuXxfBTS/ZCafcqI+U=;
        b=bUhpcLkgBDZrHVZX/L1h/2Q8sXiQ6RyrYFilkMFWpG0sY/GfKGd5qB2i1l6gA//NG3
         fRRSo/kfie/96PKlLt6ErGc1CPHXQaShszYqpkeDgmsFIjL/LBqU2lFYdhkm1aRGmB6F
         jEOxRM7UqZGqzGIOg6TqhRCh5eVwzibtSj4lkIE3qr01Vtyy/RTa7bFQdPW2606wzGSa
         dP6J4JH2NFOk1soEQHgsdYQRPdg8oVIFKuBq0GvZKXxiw6e4fniT6Rf0WAUEpeLYVjxr
         vPMA+WzKf1Ub+5XanQp1qebcD/+BLP6UCbsSVoln9DjdjpqUk43g+NyhlT6ifhe8KmdZ
         bScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680675155; x=1683267155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbX3TeyHNDS5eFyrTFp/ekNijmuXxfBTS/ZCafcqI+U=;
        b=Z+EksUA/3xN1zXrOOjOI6M6x/q5V23wZjJQf3WxjAQZBeZZCRLan8Z5dqtQGmWVsXu
         vN7fxs9DiHHypM5cCs0B5jJA11r5fVKJGJQJtJ2f6F2tx9lCmI/Y2N9q0NpiZurAwnk0
         LJBYWK8Lz6vUxB1AbudOzJzf2uxwE7YCzAob2GliMY36JCRZ4mJevUED10bPBgJHS0U9
         WMoSDcYXVwaB+PRqd7Ux/bZkQAPucCBjfZyBPKa/1duX+L0mWDKfXqaN5cvcr9v14yyd
         wWwrHs7IDxwe6GTyJ6r9DvNO19ExZrchmCKokH1c1m3YPXJRTwPZQTWCzjmkt/44u58e
         6cyA==
X-Gm-Message-State: AAQBX9fesl9QiVI6PkbGzg9zR5OT8wX7uHmc0LievzAuLJAf4zdZYNjF
        C4xny+FoX/bHl5wzRmAE66w=
X-Google-Smtp-Source: AKy350bOpHgbA24Ur04Byt7cLkAIYy73rtEZzt7rBi1+vMa4OyfNdKs7IG2LFotuIQlQaC8twTLdjw==
X-Received: by 2002:a5d:4d41:0:b0:2cb:76d4:42ea with SMTP id a1-20020a5d4d41000000b002cb76d442eamr2862131wru.36.1680675154909;
        Tue, 04 Apr 2023 23:12:34 -0700 (PDT)
Received: from [192.168.1.45] (hst-221-66.medicom.bg. [84.238.221.66])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0ad200b003ed2276cd0dsm1026572wmr.38.2023.04.04.23.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 23:12:34 -0700 (PDT)
Message-ID: <e962ecc5-1a41-14b4-5c98-f9f1ac284267@gmail.com>
Date:   Wed, 5 Apr 2023 09:12:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] venus: venc: add handling for VIDIOC_ENCODER_CMD
Content-Language: en-US, bg-BG
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, quic_vgarodia@quicinc.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        nicolas@ndufresne.ca
References: <1672843496-14111-1-git-send-email-quic_dikshita@quicinc.com>
From:   Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <1672843496-14111-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.01.23 г. 16:44 ч., Dikshita Agarwal wrote:
> Add handling for below commands in encoder:
> 1. V4L2_ENC_CMD_STOP
> 2. V4L2_ENC_CMD_START
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> ---
> change since v2:
>    add a check to return EBUSY if CMD_START is called
>    in VENUS_ENC_STATE_DRAIN state
> 
>   drivers/media/platform/qcom/venus/core.h |  9 +++++
>   drivers/media/platform/qcom/venus/venc.c | 66 ++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
> 

> +static int
> +venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
> +{
> +	struct venus_inst *inst = to_inst(file);
> +	struct hfi_frame_data fdata = {0};
> +	int ret = 0;
> +
> +	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&inst->lock);
> +
> +	if (cmd->cmd == V4L2_ENC_CMD_STOP &&
> +	    inst->enc_state == VENUS_ENC_STATE_ENCODING) {
> +		/*
> +		 * Implement V4L2_ENC_CMD_STOP by enqueue an empty buffer on
> +		 * encoder input to signal EOS.
> +		 */
> +		if (!(inst->streamon_out && inst->streamon_cap))
> +			goto unlock;
> +
> +		fdata.buffer_type = HFI_BUFFER_INPUT;
> +		fdata.flags |= HFI_BUFFERFLAG_EOS;
> +		fdata.device_addr = 0xdeadb000;
> +
> +		ret = hfi_session_process_buf(inst, &fdata);
> +
> +		inst->enc_state = VENUS_ENC_STATE_DRAIN;
> +	} else if (cmd->cmd == V4L2_ENC_CMD_START) {
> +		if (inst->enc_state == VENUS_ENC_STATE_DRAIN)
unlock the mutex!

			ret = -EBUSY;
			goto unlock;

> +			return -EBUSY;
> +		if (inst->enc_state == VENUS_ENC_STATE_STOPPED) {
> +			vb2_clear_last_buffer_dequeued(&inst->fh.m2m_ctx->cap_q_ctx.q);
> +			inst->enc_state = VENUS_ENC_STATE_ENCODING;
> +		}
> +	}
> +
> +unlock:
> +	mutex_unlock(&inst->lock);
> +	return ret;
> +}
> +

-- 
regards,
Stan
