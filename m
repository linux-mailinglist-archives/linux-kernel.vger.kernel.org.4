Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15536F70E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEDRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:32:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F940CF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:32:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so920339e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683221570; x=1685813570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctm3V/2tsb+HwfAuPCFA+h4VPFxJVgdGiqFdK+yT/Ko=;
        b=VImILlN7TwlrC2uXONDFXi6Aue+UKaDLDAMGC/L8XA5cP4yvrbGOh9H65T5TSYhSph
         eFrGquJT5Wwjt9UH0DlTvVzq1KoPyqYJT0Q+xgRbKON/0lmvOvyB3Y7HWkbIxaTNg5p5
         Vf53nkfRE5OwqEqTsyZua7yo18Ds/H07DdqnS/deFk6AeU+ONA44CSaaBRjaHNIX1NIO
         tY76TUNagwbXIAKT2vAzK5GWq5Z7zZZYMoYo0/EmjoqRKLuIDHzsv47loY7c3zCEH23Y
         kct3impCR99aQSF8DMn+SxJbXqhosJYi6AdUQlmG+ypxE0TnU/QDgrx5PMseyQypzwem
         0SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221570; x=1685813570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctm3V/2tsb+HwfAuPCFA+h4VPFxJVgdGiqFdK+yT/Ko=;
        b=VT6exwpicUoV1p3C8mW8U2Ntm43D++IlGYS83ldgq2zkDy7JTNIWNgJkjlDJUXtYNx
         PrhzHFVzeFrMDdxqlrcIIeE9QGIltJSkq70FdJI5+cOUGpo0/MyKbTcahU11wMBAw9WX
         wq5IBWGqWq7W+g9/qdfkOdSccXpMFm7/oj4oSvrLw8gF+ObMp5OkkrktbVJip08IZpNd
         GGdzqVEwRAtQAJ5OFF9t+72cw+RT9c42ZZ6CuW6/AlMp0Ax4Ctxi0r5ahGvTvL1oDClY
         eNt5+o5wMrhCa4VAyFDQ3Q6M/ZbOnr2nsFYOpkoz0EB5ImIAEOIx5hm2yh+WbSXRXVyX
         WcNw==
X-Gm-Message-State: AC+VfDxwsftHoJzXek4qxBOj82wMXbsI3r/U8hGem8QxmMLXKQXWWcNN
        b6jONGJiN8OvZUkzDIQ25x4gTg==
X-Google-Smtp-Source: ACHHUZ4NV4hGbvdi43PO5Vfgh4RnSDqET3vkzuhPeAbGnXSF4kwthrTDz9w8iz/OekHTDhivXOWdxQ==
X-Received: by 2002:ac2:5a4a:0:b0:4eb:40d4:e0d2 with SMTP id r10-20020ac25a4a000000b004eb40d4e0d2mr1815554lfn.38.1683221570096;
        Thu, 04 May 2023 10:32:50 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512218900b004db3e330dcesm6646261lft.178.2023.05.04.10.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:32:49 -0700 (PDT)
Message-ID: <9dab4e48-6deb-76b1-4eb9-f0831bdcf7bb@linaro.org>
Date:   Thu, 4 May 2023 19:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/4] venus: add handling of bit depth change from firmwar
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
 <1683196599-3730-4-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1683196599-3730-4-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 12:36, Dikshita Agarwal wrote:
> Set opb format to TP10_UWC and dpb to client set format
> when bit depth change to 10 bit is detecting by firmware.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 18 ++++++++++++++++++
>  drivers/media/platform/qcom/venus/vdec.c    |  5 ++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 4ad6232..4f48ebd 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1770,6 +1770,24 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
>  	if (!caps)
>  		return -EINVAL;
>  
> +	if (inst->bit_depth == VIDC_BITDEPTH_10 &&
> +	    inst->session_type == VIDC_SESSION_TYPE_DEC) {
This could be unbroken

> +		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> +						HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
> +		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
> +					   fmt);
This could be unbroken

Otherwise I think this lgtm

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +		if (found_ubwc && found) {
> +			/*
> +			 * Hard-code DPB buffers to be 10bit UBWC
> +			 * until V4L2 is able to expose compressed/tiled
> +			 * formats to applications.
> +			 */
> +			*out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
> +			*out2_fmt = fmt;
> +			return 0;
> +		}
> +	}
> +
>  	if (ubwc) {
>  		ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
>  		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 687d62e..69f7f6e 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -701,6 +701,9 @@ static int vdec_set_work_route(struct venus_inst *inst)
>  }
>  
>  #define is_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_UBWC_BASE))
> +#define is_10bit_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_10_BIT_BASE & \
> +				 HFI_COLOR_FORMAT_UBWC_BASE))
> +
>  
>  static int vdec_output_conf(struct venus_inst *inst)
>  {
> @@ -748,7 +751,7 @@ static int vdec_output_conf(struct venus_inst *inst)
>  		inst->opb_fmt = out2_fmt;
>  		inst->dpb_buftype = HFI_BUFFER_OUTPUT;
>  		inst->dpb_fmt = out_fmt;
> -	} else if (is_ubwc_fmt(out2_fmt)) {
> +	} else if (is_ubwc_fmt(out2_fmt) || is_10bit_ubwc_fmt(out_fmt)) {
>  		inst->opb_buftype = HFI_BUFFER_OUTPUT;
>  		inst->opb_fmt = out_fmt;
>  		inst->dpb_buftype = HFI_BUFFER_OUTPUT2;
