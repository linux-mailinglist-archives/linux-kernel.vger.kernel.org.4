Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF93B74522E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGBUOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGBUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:14:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCBBA7
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 13:14:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31438512cafso133758f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688328879; x=1690920879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/msN/aF74Dw7L5vp0UJekcbvD89qyKZgROZ3cEOh1Hs=;
        b=Uhkby4bQCZI750ftvrp0r1LBbPbfegZuk7UpAh1rQjWk7GufTeCqQBkeyW09rlE+Mn
         6CC032Jedh2SqZBAFpu8+ruy1rnfwhbgOrG86r/SFfL5Pf4B24ACtAUj14bbp20Epb5u
         7ZeuyzneodyGhKnxKWISBvpXeHt7m+8s+CLPXo7Ksf9Pjn4FvLOCSD2AqWIzfAMDPHmr
         rnq0aGqYg3KgTIpreyr+n8LZrEOKZE8BJAR0XL2xmCOmx2s0GU/PHo+VPqVYxX5yqdqa
         pcXqBei6CJ7tjaPBKWB1vfqafqmjY2/f4vr8CfSrpv9nhvc98bE0Kfj3IaTabM0apTEz
         JHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688328879; x=1690920879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/msN/aF74Dw7L5vp0UJekcbvD89qyKZgROZ3cEOh1Hs=;
        b=Gkr4pA/CRYoD9+sndDQuiAC/R4AXymXereen+eiP027wI6Wi6uMQyz0ekwzIdm6nME
         s8gr4+zK1WHkkDdJP5OvEwClIEUPqsOdmR6Yvlpm2KDM6fZi/GYurnZ+HJs1oCumagJF
         RWWqQpd4cAqBUxKTf9BfpOW44wMKSN/VHFLYwYW6zLvDM3yHTpuS7EFUvRT6DTbJpttx
         8fiOMwmBGWHcsVuU5oJ7x7q1G9tRF18sxWLDHp/9YWgR4PDZOuPfJtwNUprq3zPnFOva
         vdRGJMl/vpv+/B635PuL+3rXXMXDRQ1daOpo23eFPoEOoxQSvLCktdHaNY71XgNdSuk6
         7/YQ==
X-Gm-Message-State: ABy/qLbGi1CSfoe2f9F3Pa7px1E/lBfOs1wSviEn8mpkVGKRrSooPpXf
        xzkE2BRdSLoqLkx/y8GEolOoug==
X-Google-Smtp-Source: APBJJlEaMjzxW+IotAZmesVA1vpJP5bdewGQX0Ffdx0+UU5lShCdfPz6r+z4c0n+yANGdCIWVevPAA==
X-Received: by 2002:a5d:6844:0:b0:314:1d26:4e66 with SMTP id o4-20020a5d6844000000b003141d264e66mr6377336wrw.63.1688328878745;
        Sun, 02 Jul 2023 13:14:38 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0051def9be785sm3405866edq.85.2023.07.02.13.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 13:14:38 -0700 (PDT)
Message-ID: <11ec64ad-8fb8-e94d-2019-d3deb399084b@linaro.org>
Date:   Sun, 2 Jul 2023 22:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ARM: dts: st: add buswidth property to stm32f429-disco
Content-Language: en-US
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230702103516.139440-1-rgallaispou@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230702103516.139440-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 02/07/2023 12:35, Raphael Gallais-Pou wrote:
> The ili9341 is left without a mandatory buswidth to properly communicate
> between the SI bus and the display. Add the device-tree property.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f429-disco.dts | 1 +

There is no such file. Please rebase on recent Linux.

>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> index 3b81228d46a2..5eaf95afc8c7 100644
> --- a/arch/arm/boot/dts/stm32f429-disco.dts
> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
> @@ -197,6 +197,7 @@ display: display@1{
>  		spi-3wire;
>  		spi-max-frequency = <10000000>;
>  		dc-gpios = <&gpiod 13 0>;
> +		buswidth = <8>;

There is no such spi property.

Best regards,
Krzysztof

