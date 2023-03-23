Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E16C65E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCWK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCWK5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:57:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3315543
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:56:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i5so37685917eda.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679569008;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6+PtX2uAhZSqkwPYfEsl+TAxiQ67+WZc+Q3dIOuMcE=;
        b=QF4wyHEiRl6KTQlDrBxHTuc6zD+l1XJy36k0jCRJcisHJMysi95BCcxghDI7ienVF4
         BAEKND3VKq8+GSUllrtcaWuZDNXV0rGoY0IqjiLgRHSkPxsB7u+Xf++DTaBcGAYUQLYz
         kjEIHUjgUpYMM0Q98E50IXWFIWhUwewgcWvrq5wVTxBirQejr7KnBmoZJMLeMjqZ7sfo
         U/WWyzEPvK32ireuXnw37q0HhoPfpqAUQLMBkS6Yxx8LsdrvcLfr3k20plquW3iRFgCu
         b/oVclZ0R16z0dTwU7saEwa0pubJpafm+pyx/GUeq9sy45ScR8Wc4gtYfpLbOrIB1vJb
         WwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679569008;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6+PtX2uAhZSqkwPYfEsl+TAxiQ67+WZc+Q3dIOuMcE=;
        b=gtvKbAml4202GcnNNdteSHDMHVu+R2L0+3tg1hDbYVPKiJXROk1f/T4Cpgh3PnTjny
         kZepBvVpRZns8IEM1J4sGwAQwpUhIiX9sIO+dz3Fq3PXrtvNH83uCjidUDlGSrSMygQa
         QUJrm7D/ol09tyCT1se2dOJRsTylKnZ18zgG3Eb3qqgs253yyJfTOdUN4mNHAnb4dFOv
         pc4TV0VJSpBJzAKEx5uNjT3vsb0kqi+YnAOY3OrzsMKoCBJ8b44V6XvmZRkuH/caWuJe
         t1/PK4kpemMx1IqMtSD3vIZBM7uDrSowiZ0E8MIkoh1I39uxyMc8F0Bt78UHKpGS4bOd
         g7qg==
X-Gm-Message-State: AO0yUKUV5zfi2ULwCeUYIfcFFIOwgQaa35w9VQvMxIdEe+uPgJnHrQy9
        f6+4aeiWaXj0nsAfhkkOVdm6eA==
X-Google-Smtp-Source: AK7set/mMtMtX2/IfUIgWtPTy/0NZHA5/5OfRAjpSqAKYNcqEPYo/cIqYY26nGF46BVIjlQl/PeqOA==
X-Received: by 2002:a17:906:d057:b0:932:e141:29be with SMTP id bo23-20020a170906d05700b00932e14129bemr10221290ejb.75.1679569008614;
        Thu, 23 Mar 2023 03:56:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709067d9300b008cff300cf47sm8473200ejo.72.2023.03.23.03.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 03:56:48 -0700 (PDT)
Message-ID: <3b2e7b07-7598-45af-0dce-a60310aa5d60@linaro.org>
Date:   Thu, 23 Mar 2023 11:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: ipq5332: add support for the
 RDP468 variant
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230323093120.20558-1-quic_kathirav@quicinc.com>
 <20230323093120.20558-3-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323093120.20558-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 10:31, Kathiravan T wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 468 based on IPQ5332 family of SoCs. This patch carries the
> support for Console UART, SPI NOR, eMMC.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- Moved the 'reg' property after 'compatible'
> 
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 103 ++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts

Hi,

Your v1 was reported that it does not build. Does this patch build fine?

Best regards,
Krzysztof

