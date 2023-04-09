Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73C16DC0CA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDIRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 13:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 13:10:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C7E30E1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:10:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y4so3091837ljq.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681060202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uCMXg3qktyRsiu4kaOaI9ivh//X7GtEehAzDrbc2ME=;
        b=TzTEX6yDh1XKr7Lf6+zCMXYxsCPludeRQxOSZIvW7IcRjb75zyNKUmXp/uNv+HRS13
         YaxahZU6eQKmbNgo6kJ9bFWfrvTIkDRJA0EPArnsb2D5YE0mNTyfJoQ2aBYCt6vJZW6K
         FJSL/Sz0DRYzXQ8T1I2uFZjdOivJulBQTyVcynYBTVtjR3YmpYWUEqm+S6UP1v3lnGac
         2bUuBkOiBq8+uEHvdMsHGdqw7WDztqGufjwog3QrvtC2Y9YD+ar7dxfHDvKALRgT2OsI
         DjRiaBLinsAKY66cFU04BjAWuCQ5AIAfdvQd/nFh/JcQP70nISV0r/gW7rklPKAfg6zL
         mxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681060202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uCMXg3qktyRsiu4kaOaI9ivh//X7GtEehAzDrbc2ME=;
        b=CAA8xBiu7+VJJnaX8xvqFpbkR6+tT6i23GPsu+HDFziIzefDfwTmyOcHyC10bcrB0W
         lHq8xPtY5X4I+DTjRJp3kVK91mbViV7O5Y7uqhFty3Ik4zjEsvzF7eoxSIIvDCh7TEyg
         m/BmkzDhk6FSeX7bzc6ugbwwZorznzTzT1Rp3pStPT1FQOyMKyp/RZ54D2mhEIZ5rU13
         XbQCOB5fmmntyWW0kF2iYZ80nHMnhXnwhw+VYMnfOxHw8nExDoNFYGg9JKPJHC5ZaTtq
         5Rl4TPhsPLYpIVUKryK4cTU+Ft4IWTyhCywNXHlUw9u8yQEbo7Q+JJtLnWYo7ebNKwW6
         LE/Q==
X-Gm-Message-State: AAQBX9ccPpx5/qEosdMzWmIwQI0GS4v7oDd+jnca1cha9UsQzwQBhisa
        X3FnpCNtUQ1YH7+Hn7gpW6C35A==
X-Google-Smtp-Source: AKy350bhaQbNkHbZKI6ZhxOOPajs7ZcQwLq5npTcqkh7MGlNK5WWLXvyyDDc1hKZq8WdvocVH2qQ0g==
X-Received: by 2002:a2e:3812:0:b0:2a4:fe3d:d4b2 with SMTP id f18-20020a2e3812000000b002a4fe3dd4b2mr2179483lja.17.1681060202404;
        Sun, 09 Apr 2023 10:10:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z14-20020a2e9b8e000000b00298a81f5d70sm1849710lji.136.2023.04.09.10.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 10:10:01 -0700 (PDT)
Message-ID: <ccbf905b-2c0b-e5e2-1ee2-485d3af52247@linaro.org>
Date:   Sun, 9 Apr 2023 20:10:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] venus: fix EOS handling in decoder stop command
Content-Language: en-GB
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
 <1680848758-3947-4-git-send-email-quic_dikshita@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1680848758-3947-4-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 09:25, Dikshita Agarwal wrote:
> Use firmware version based check to assign correct
> device address for EOS buffer to fix the EOS handling
> with different firmware version.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>

Order of sign-offs is incorrect. The SoB of the sender should be the 
last one.

> Tested-by: Nathan Hebert <nhebert@chromium.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index f0394b9..c59b34f 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>   
>   		fdata.buffer_type = HFI_BUFFER_INPUT;
>   		fdata.flags |= HFI_BUFFERFLAG_EOS;
> -		if (IS_V6(inst->core))
> +		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>   			fdata.device_addr = 0;
>   		else
>   			fdata.device_addr = 0xdeadb000;

-- 
With best wishes
Dmitry

