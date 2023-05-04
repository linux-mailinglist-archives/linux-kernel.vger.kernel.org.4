Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89676F6C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEDMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjEDMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:35:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A86194
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:35:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so792093a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683203755; x=1685795755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMm9zCgjmjqNBT9qCeY66Oq88bASTTs9Y+/BD6bZYEs=;
        b=FAui2AqzZXpJO8prSuWYpbOdwOoBt1DM86uMzzlBJNjubAbUVJLjz68SIWf+1DNjMT
         D9pRsLdjCNNy8X+dlyzybOLQdiH/anJx6wADdOhvlnpdFbvXPrKZWnrvikegyPfacnld
         t+AqJgnnucN1HQq3Rz900vQDddW1T0P7qkS2VuauOZ9n7uvBAm5Ason0sf/q6Z21LNfB
         2hT5sfWpXOCQGYLAB1RERoLKl+k11XMPvG9ovvNL4JrwzNyl99UI/SnH4ugY7mQAFN09
         OimEVhL1S3DfgIdX42zSK2wpQJ86qZTvG/Wvm6xMnkHf0ABXgBOiYbZcYwz1mkOi/gsZ
         ZEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683203755; x=1685795755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMm9zCgjmjqNBT9qCeY66Oq88bASTTs9Y+/BD6bZYEs=;
        b=LiHm9wSatL/zB173HBeXI182N2/XmSdOZdx104fY+jXTEMA356uoBZ3vC64/RLZpNn
         AIWKChuGBxUbHGK2VGROcpp7cHCqDB5/aFIqkXbKIXDulYYTCX02gQryGENgsYpXUZTU
         0qQcPrrv0QTU7Ns5WCUT4IFCiNGVUp/ay3M0v2DZTRZue16bNpZHftE5okh2UqYdZN9s
         oQgCceI9PMxwd+U162SLiR9YUb50w1kvXdVoJNK6Lrj2I/MUjTN13W8UEdG79UBD150v
         WgLCyE49BzGSMdBptzkZyecAL8O10cx3d7HBBRTBe1VixfvjWjkvH+IGkM2znMsHFdQI
         RJZw==
X-Gm-Message-State: AC+VfDzd+UAqx9d+qlASuDr0nZpjJ5L0GAOxT3UL30Gq4pg+mTD1SPEw
        FiVvYDBzx1k1drOpUpp+NcNCCw==
X-Google-Smtp-Source: ACHHUZ4ePHckfpUMq7oTFQIk9Sgbk5MDYXHYzVoBUcorr/dy7jEqin2VrXavka0/Elf5F2FDEMGK+g==
X-Received: by 2002:a17:907:7290:b0:953:9899:d9c1 with SMTP id dt16-20020a170907729000b009539899d9c1mr6609952ejc.1.1683203754788;
        Thu, 04 May 2023 05:35:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060e1200b0094f3338129asm19010078eji.141.2023.05.04.05.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:35:54 -0700 (PDT)
Message-ID: <e963d4a4-4159-53ee-1008-4bdec8b48268@linaro.org>
Date:   Thu, 4 May 2023 14:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 01/18] remoteproc: qcom: Expand MD_* as MINIDUMP_*
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-2-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-2-git-send-email-quic_mojha@quicinc.com>
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

On 03/05/2023 19:02, Mukesh Ojha wrote:
> Expand MD_* as MINIDUMP_* which makes more sense than the
> abbreviation.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/remoteproc/qcom_common.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index a0d4238..805e525 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -29,9 +29,9 @@
>  #define MAX_NUM_OF_SS           10
>  #define MAX_REGION_NAME_LENGTH  16
>  #define SBL_MINIDUMP_SMEM_ID	602
> -#define MD_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> -#define MD_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> -#define MD_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> +#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> +#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> +#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)

You remove it in the next patch, so no, don't touch the line for trivial
cleanup and immediately remove it.

Best regards,
Krzysztof

