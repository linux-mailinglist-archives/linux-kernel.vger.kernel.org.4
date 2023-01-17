Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0184F66E3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAQQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjAQQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:35:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EECA402F8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:35:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vm8so76637115ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKt6FUbs0NRTdylWMz2ns+XH+sssUdEr8LiKsXM1UOA=;
        b=IONHL8M211hbqnvHJxhpzV+DBFTwMzWtBVbmOPsSS8ORin6BOLQpdh8nIh8ieg2vr6
         /f3kq87LpUlDR0iI22hK6hBpwRHBQTwWhiQYbXHExWcYCnpzHXd4m3kxyoqlpvbp44W/
         RMkUDbU8yFK2iQ611Rlt7md+mq4Sdw1ZWuVjVXNk5vjReROJ4f832nd735JNRluMHFJZ
         n8Dht7hxfenVzjd1HCrW6OjavSCxjsqPAcEaF+mbykBFM2kCLxnuRaDQRc4nUNdau7vd
         O+ENqN9cOLLdkVrH3h3no6ginShLIOsGoNucPoq8kRBuZO9j0ZO2xPXF3IiUkUl5xTmv
         nopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKt6FUbs0NRTdylWMz2ns+XH+sssUdEr8LiKsXM1UOA=;
        b=1h0JXMQ+4lgG85jZfXrD8f/hJz6HV1Dtjn/in+pYeMd+nzZnf+mqddyjCFktQDfT8K
         NlkBzdQHGseeaitH0kt3M0Y88w+weIzIAg7wRcCGlkGFBEOP4730w1EyzC07F5W4tuiU
         fdmuMNiIocPdlzYpkukau9Yf8dF9hEzOrIag/lOfe6J7MpkIae1kDtMV2R8X/kXm7Fh2
         3Vff54pgr/Bf2Hy20LBVpgOM255s30TzJB88GTrPrx8ewPrZWpuVs6Ll43WrrMm+p9yp
         9nooJBmDdNJkvvfmFsNV4bAs7k23N7MjFfZ9nMsYZ3XqTGv99brJaEw/Vy+78jo2r1Me
         QguQ==
X-Gm-Message-State: AFqh2kpGF04au0tvZcYtc1/X5DwYK6hgGA2Sm42PMESYGiswWrpwnn/u
        j414mH9VMZCOIO3w4pEURD3MSg==
X-Google-Smtp-Source: AMrXdXs5AVHAIlz7sxihSBRcrZGbFCUjXMBelpA5amhed2x0+IJYDSZ+Pgu3xgl9UUHwffn6H0R2xw==
X-Received: by 2002:a17:907:a2cb:b0:871:dd2:4af0 with SMTP id re11-20020a170907a2cb00b008710dd24af0mr3566417ejc.26.1673973314968;
        Tue, 17 Jan 2023 08:35:14 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id ss5-20020a170907038500b00856ad9108e7sm9201315ejb.70.2023.01.17.08.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 08:35:14 -0800 (PST)
Message-ID: <0a845c24-b1a5-a961-103f-0d8840a8f17d@linaro.org>
Date:   Tue, 17 Jan 2023 18:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] drm/msm/disp/dpu1: allow reservation even if dspps
 are not available.
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1673972488-30140-1-git-send-email-quic_kalyant@quicinc.com>
 <1673972488-30140-2-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1673972488-30140-2-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 18:21, Kalyan Thota wrote:
> if any topology requests for dspps and catalogue doesn't have the
> allocation, avoid failing the reservation.
> 
> This can pave way to build logic allowing composer fallbacks
> for all the color features that are handled in dspp.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 73b3442..c8899ae 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -343,7 +343,13 @@ static bool _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
>   		return true;
>   
>   	idx = lm_cfg->dspp - DSPP_0;
> -	if (idx < 0 || idx >= ARRAY_SIZE(rm->dspp_blks)) {
> +
> +	if (idx < 0) {

The change doesn't correspond to commit message.

> +		DPU_DEBUG("lm doesn't have dspp, ignoring the request %d\n", lm_cfg->dspp);
> +		return true;
> +	}
> +
> +	if (idx >= ARRAY_SIZE(rm->dspp_blks)) {
>   		DPU_ERROR("failed to get dspp on lm %d\n", lm_cfg->dspp);
>   		return false;
>   	}

If you'd like to remove duplicate for the (idx >= ARRAY_SIZE) check, I'd 
suggest dropping the second one


-- 
With best wishes
Dmitry

