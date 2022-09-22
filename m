Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195BE5E5BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIVGwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiIVGwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:52:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3FB6029
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:52:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s10so9809125ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HpPp0BHUrPNweVTZtr7NErbLRKsWdneVoqjGlBiJPh8=;
        b=NKMnWZgS5BSvCK945ZAajPqZeW1VEAPF/K92kxSO4ojFqEyhY8uY9CH+GHuAXdXtOd
         SfSN5wRHjrXBzsEv2ctbxRIk+0qiV8ELcEryUMxTeLdWAxOYJhtm4pVh4nX611N262zw
         btTtSVEQlc5bzd8yrbHKYbpE+5XChRGCVaGtbwozWlmXAF70qot5gRQS8AhJ+KwdGUtV
         BAv7WxehOAK1Go0BWI1ZwmbfAD66AxqIxc5g/1txVRCAqFK/Ar1RKkdYZig5/oV8jbjz
         S0NAZ5x8Uk5mvit51bkHuua9/6uHPIy150GK6No/16fjALgvzhVK1961Gf4rf4YawyYC
         SiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HpPp0BHUrPNweVTZtr7NErbLRKsWdneVoqjGlBiJPh8=;
        b=7xTZTLUKsQwX6zQPYz1ZJjoTrT4b4LYgZfUC+AfwH6wZ/hKnmuLTF/1u7R5zEpNNSv
         qBP6C6YhT3nRg7+/gvc0SD9SrmRoMzHfevm/BL4EZsM1o4l/cXU4xVHLRQGxjbSaM2oZ
         Vc/+JpvsyGGr57bLU9AZQwmbTSRrHwR1yyL6BHWMMMmvBRvh1l484KNqKw5Fvjipo72f
         K0t74evws/uEPjAvoa+lhmwzHdyRxPepd1E8KZ0H1z6CxnFABcbLolayqThd9P92sK35
         CFkaKmuczjqI2JBGHbrziDwZjC82jp/363krO4QfK5Pv9Vv8he37/X6tDW+ATk0jAOkT
         UmaA==
X-Gm-Message-State: ACrzQf3Bc6E8cnCirLNbCiLD4RQ3hEywU1eIJaWZ7ErWbaERz59JAVHC
        8o54E65FXeHew/Q9YPBmvpZ7ZPuAUXc1Zg==
X-Google-Smtp-Source: AMsMyM78If/cBNQ1SnC+v6xychOd6uY7sVFoQMHHASjrPCwbCyMRcKsSoHMRnkbuxCvoylYmkrHGyw==
X-Received: by 2002:a2e:7309:0:b0:26c:3db7:8fe2 with SMTP id o9-20020a2e7309000000b0026c3db78fe2mr525386ljc.387.1663829554770;
        Wed, 21 Sep 2022 23:52:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a7-20020ac25e67000000b00499b57032c1sm784269lfr.144.2022.09.21.23.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:52:34 -0700 (PDT)
Message-ID: <f84250e7-39fe-80d9-9e50-700f9752367a@linaro.org>
Date:   Thu, 22 Sep 2022 08:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add AMD DaytonaX BMC
Content-Language: en-US
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
 <20220921210950.10568-3-aladyshev22@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921210950.10568-3-aladyshev22@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 23:09, Konstantin Aladyshev wrote:
> Add initial version of device tree for the BMC in the AMD DaytonaX
> platform.
> 
> AMD DaytonaX platform is a customer reference board (CRB) with an
> Aspeed ast2500 BMC manufactured by AMD.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts | 319 ++++++++++++++++++
>  2 files changed, 320 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

