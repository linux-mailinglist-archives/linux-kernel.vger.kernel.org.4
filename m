Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FAA66715D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjALL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjALLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:55:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415BFAC8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:46:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i15so26482475edf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0wMg8B+r7Uh0cXEXrMRR61VwVmslR4aMO0Co5YCjg4=;
        b=jfW0ER6XAvO3XpL5d0jBIwp9w5hHbxKvWUQpMOrrIVtgvEv2y6Deb3b31gYIbqA7Lc
         0uvaFYiNtNHcoMpCk81Y6NR+ZGRtP0ugQnW9W7LzWfHBICUZEQFEtlHgMw01QzMcZSR7
         ni3MPC4z4QmjvaurSdSs1tL0k9st6RJ5zN8YDrSiSsjTKD3xRTvJ9byZPBecQvDe6rj+
         WNrXXg7NKXTWfDYFwZED1N+usQaDDy/EZL2Mz7I5vovd/8SYbd3OIda9pl6ULDs469C8
         PVZ1h4SU+ZEbUuy8H+8b13oeRb44gnCtafU0GLU2BDRbjFF9+3rKIY7EBPajzFUAw8cO
         xOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0wMg8B+r7Uh0cXEXrMRR61VwVmslR4aMO0Co5YCjg4=;
        b=zfi0QQyI+vRAJwCS7E3QLu7teKc81QRCQldPa+4e0koaGh3xM8iNEPl63NJCTQRQIO
         P48e/7vbTTvre4DfD/GP1GS820pLpdxowPevXyF+AQIPE7zhpUtH6xowtRbqf2GULcEd
         h8qL2TotOUmzueP3D+9HAkcWpL1ylaKhfB0VE+Hb/GY1qK/WsYLvWrPm/90ZIPZh9T8H
         Z++TZgRbF7D/NqZWGZPzpP+3nsHVqify9wHgrMCJpcQsCnRZAIuQCPEPlJDbi3+k2x4B
         v3vyb9cc3u3t5MvSsNQ32v392IXa4F0rXKMQWbIYJBAG3MNyfhHE09ohhzkB8Jeqsh+k
         sxJA==
X-Gm-Message-State: AFqh2kqggXmsktNCI9eWjoUTj2IFuJEnrrqzOuRHEm3PSe9bZrriQAr+
        DKKr28RQoxr9RvLK6HpxSVe5Ng==
X-Google-Smtp-Source: AMrXdXtSbLH+vPTwFa7s5QFzuqgmjnm09Vumds9TuMIKXzbtvRe1pyrQK2tDi1jhB1ftncECuNBnFQ==
X-Received: by 2002:a50:ef12:0:b0:499:c516:fc41 with SMTP id m18-20020a50ef12000000b00499c516fc41mr8248842eds.36.1673523990236;
        Thu, 12 Jan 2023 03:46:30 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w1-20020aa7dcc1000000b0047a3a407b49sm7107913edu.43.2023.01.12.03.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:46:29 -0800 (PST)
Message-ID: <3985f697-d363-0f1f-0b4f-bc5e9e2b7b34@linaro.org>
Date:   Thu, 12 Jan 2023 12:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/10] ARM: dts: stm32: add vrefint calibration on
 stm32mp15
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
 <20230112104446.1140551-3-olivier.moysan@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112104446.1140551-3-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 11:44, Olivier Moysan wrote:
> Describe vrefint calibration cell to be retrieved through bsec.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  arch/arm/boot/dts/stm32mp151.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index dea1c53f2b1d..eec5e9992bff 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1632,6 +1632,9 @@ bsec: efuse@5c005000 {
>  			reg = <0x5c005000 0x400>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +			vrefint: vrefin_cal@52 {

No underscores in node names.


Best regards,
Krzysztof

