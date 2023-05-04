Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AD6F70C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjEDRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEDRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:21:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798061722
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:20:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f122ff663eso892574e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683220857; x=1685812857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x03inJk1u8Dl+C485ZgejmLGtZM16EKxZlLJMRQD5GU=;
        b=CI0xsUrSJoPZc3hn8va7m74kLj9rg4kPxmQ2T1/R068MJp5jW7mBh1Pcox80Uuf7B0
         Q3Gbvi8g8KBRtJcqNzvdrg3aMMfdsVinB7BvmCIpUN1coOQnGsPPpo3fSSnGPTgN049X
         h2HJZnYfUVjNz1qBnbciaG59E7P6UEsvBdFvd9MocP+XJmek9XdZWZp46gpPcmLqrknQ
         Yr9RRdTU6LvcA6J3aztC9CgYtnQThTNbivXAnrv6zJtCb93ckSpOgkHzGqW3axD5I7sT
         Kdqaz3BS06CYmvqURLZlutmRWo1lo0vKRg40JqAC5NbmxUQiEX0D7Ol8No6LOdBxO42E
         UKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220857; x=1685812857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x03inJk1u8Dl+C485ZgejmLGtZM16EKxZlLJMRQD5GU=;
        b=EF7oF2pJOIbHJbKCmfUVI8nJ1QCtp2M9AXiLWt7KoOXfemyzcTQh0Kgc9DSWzHRWFH
         l+zPI2HeBIJvEzyF74KHGZ274X/MOixJRxeOb/xm/OS+r7trwE8tXDwTlRiLeADEkOY3
         UGwg9hzBhjiOd6fveH8MGJszPFW4T5BEwpVmAW7HwBgGvVjbZQFXHVPSuVDoU9/KGQT3
         I0CRObUDI1cyyhYR0l1+bRM5m1GqnL5xRgJhbYhqz13sMAPA9IvYpoPT73jusJg5vXaT
         NdxRP1s7WeRgasde7DN9wNTvGYK748LMuZJDvIcMPxexu8yI8K328FDLmp4/WSL5ZZ9A
         7D8Q==
X-Gm-Message-State: AC+VfDz7e1AiJkzRDDGGkARE2FFyTw/00ZnoqwI5kJPgLWNCv45IWgyh
        IAAy5S/WLp0INsL81UlWbU8EnQ==
X-Google-Smtp-Source: ACHHUZ4C6t1iYtTRYW+vZQQ/bmsstMMU41QpxPtkhpn1Yrgd4/LIy3h5wflkeRXteZ14Wf2EjtrHUw==
X-Received: by 2002:a05:6512:38b1:b0:4ec:a9c5:f3ae with SMTP id o17-20020a05651238b100b004eca9c5f3aemr1879977lft.11.1683220856716;
        Thu, 04 May 2023 10:20:56 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id i20-20020ac25234000000b004eb07f5cde6sm6591133lfl.297.2023.05.04.10.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:20:56 -0700 (PDT)
Message-ID: <02f5d449-a64b-8f5e-6b72-2fdf8d9bafbe@linaro.org>
Date:   Thu, 4 May 2023 19:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] venus: return P010 as preferred format for 10 bit
 decode
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
 <1683196599-3730-5-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1683196599-3730-5-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 12:36, Dikshita Agarwal wrote:
> If bit depth is detected as 10 bit by firmware, return
> P010 as preferred decoder format to the client.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 69f7f6e..ed11dc2 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1468,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
>  	inst->out_width = ev_data->width;
>  	inst->out_height = ev_data->height;
>  
> -	if (inst->bit_depth != ev_data->bit_depth)
> +	if (inst->bit_depth != ev_data->bit_depth) {
>  		inst->bit_depth = ev_data->bit_depth;
> +		if (inst->bit_depth == VIDC_BITDEPTH_10)
> +			inst->fmt_cap = &vdec_formats[3];
> +		else
> +			inst->fmt_cap = &vdec_formats[0];
This doesn't scale and is very error-prone, please enumerate the
entries and assign it using the enumerator, like:

enum {
	VDEC_FORMAT_FOO,
	...
};

... vdec_formats[] = {
	[VDEC_FORMAT_FOO] = { foo, bar, baz }
}

Konrad
> +	}
>  
>  	if (inst->pic_struct != ev_data->pic_struct)
>  		inst->pic_struct = ev_data->pic_struct;
