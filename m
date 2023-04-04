Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2B6D6BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjDDS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjDDS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:27:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1FF65B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:24:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g19so30376113lfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680632647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTjk12GIKKTIia9ABj8PkyRcpDv94/vMXDAo0UPhu2w=;
        b=h2K9vqiluXgjc1ezR/gt6odoRYf3LisnMikRkrrvirKSiFCEDSBtLAE6uS4h48M1mp
         I3T50j0v/BH28GRnb02TfFdK234DZTuDRdgujY0X2uqxKAZJze6m8zowGwGrXLG6k8Bc
         plhlsrjZcW2z+LGRT8Io2bxXw6Gn+tu6j4Q1qgNI45KBrVqMygVaDbVy4gzkF3mzySrZ
         pmca7OSJP4XRdAWktF+UG4oqTzztM92mrPE6pxjPFN6ZyaMimfIA+4zHKT73CMZMkYyV
         u0qDL9QyX7yzoV4x2xDIeUTNc+RqXq4F8eHxJQ2FkX3Iqckl0TU7u6HcgovwvRJZ0DXt
         I5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTjk12GIKKTIia9ABj8PkyRcpDv94/vMXDAo0UPhu2w=;
        b=ObZpbjuCeOq/SPjIprPiWk3y094ifdIdD9CGQC1g/hYEk7u+zMBL0CerC5H3PJI93U
         amEFcjJDu/JS/wqKM+Lg6wRtUMtN0csbi1gODR8hocjkKoF37xwJltqYiRaKLMFcu6Rm
         lkZgnnfkJF64JHFwquMTVBm2yuJy4A8IK5OE/xiaZrdrwy4VfG+8SRvXdYlATAXm3DRg
         CEAEfNML485M8DRah3A6aKIXkI2dgwZtAb74CYK203Dmi+Z3Uva4+Em348AcHIbEixRk
         zrcRrF5PrFdjIwIUZjWuAR3MXb5GFGmgoOC5TSghdhMuc4NJa46TyzJteHErB2ZZbt/n
         2dqA==
X-Gm-Message-State: AAQBX9d36spVnLAYDh0ypUP21UQkXVa7ixg+NgSbijJFfLuNsqRtyH1w
        UdGgljjf2XxmUebROdvlGlXS9Q==
X-Google-Smtp-Source: AKy350ZkOhS8aYKMlY70EG2uYrpVKg7dfLmQWh0Qawc9ebe37v1BLpgGdHbyPs0MM5kls22cQ3lDWw==
X-Received: by 2002:ac2:494e:0:b0:4e9:85e5:23ff with SMTP id o14-20020ac2494e000000b004e985e523ffmr895777lfi.40.1680632647108;
        Tue, 04 Apr 2023 11:24:07 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id f13-20020a19ae0d000000b004dda87ecae3sm2425858lfc.246.2023.04.04.11.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:24:06 -0700 (PDT)
Message-ID: <93b78f82-d2db-fc1d-4bad-732f7a1b33de@linaro.org>
Date:   Tue, 4 Apr 2023 20:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] venus: fix EOS handling in decoder stop command
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
 <1680589032-26046-4-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1680589032-26046-4-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.04.2023 08:17, Dikshita Agarwal wrote:
> Use firmware version based check to assign correct
> device address for EOS buffer to fix the EOS handling
> with different firmware version.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
Does it only concern fw 1.0.xx?

Konrad
>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index f0394b9..c59b34f 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>  
>  		fdata.buffer_type = HFI_BUFFER_INPUT;
>  		fdata.flags |= HFI_BUFFERFLAG_EOS;
> -		if (IS_V6(inst->core))
> +		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>  			fdata.device_addr = 0;
>  		else
>  			fdata.device_addr = 0xdeadb000;
