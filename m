Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2655FE41A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJMVS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJMVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:18:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D3B1570C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:18:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o22so1303895qkl.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpUcGMMTLEomNjTCrbBwsAmpnz2xKhZqSnjc0ThAaUs=;
        b=ZXurGH/Z4HQBw7HeSk8mIe1MIcC65s+3gMCung+gK5e1TVWaUu5UE4ut+gVQgOVgNu
         7vAVI12Ug6bikn9Yez/wuV9fxQi/E1paOrQPL/RH77TWxADk7Iq7sJ2wx0Mbopj+qlUf
         oWxnaJajVbqB/XwNll/lE13lZeDwiGBNN55x8mozLJOkoOqBNCWl89f198HCHS3AL1iW
         4A+z7nQoos4ya1yhP6F26Or/8TgSPIBknW47u2fUIWOY/+G984ns+ifd3BiCKFZ4N08X
         AuNIucYlVrxjXpaFTrJDJDvm1I1thWgtHBtfTwh0Iy9PA1uVdM09zJAuJI1a8f7DJTEk
         VnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpUcGMMTLEomNjTCrbBwsAmpnz2xKhZqSnjc0ThAaUs=;
        b=nHBMNs5jjpdmItu3ZzyQh0XAFmySIo1vkPk4Vwa/DKyYVoEBInEA/O4sJCeEtGRDtf
         /VSJepN3I2PUQlhRnLEFWfDMCoWCxSLNwr7K3s4xiud1+2nN8wJuzsqCu1vcFbJ/hzZA
         xCWL+TPVOD2kTnj6lkxBv3Wjda/0bjzFKGB1rMHVOSXkRlDrdSNZ4MqvbNaR48qp4ReZ
         5cIuGSVnpEu9EpMlc2Ok+3xti2UKxtDhbOxQD3joOCXAzyhUDkCo1NMrNE1po6QuMZn5
         bgcJYIvySSMm4Zp5l+ZFiy2aKPLr3vzPsF91mMH94X0RkB2Dim4glHQ20fsPGUfrEujm
         FwqA==
X-Gm-Message-State: ACrzQf1M4EhZsvthQEA3qCiHvkulbbHKKOBJs5ShnDKuFH6t3OeAs54d
        Zi4maGnZlrKqpkXh0rm/HtpUtw==
X-Google-Smtp-Source: AMsMyM6+0K3K9x9m57Jyeie2QSjIrUGbpa5EzJY5X1qA1AoyhSlTz4c/SQDE11VdncG3Y6RT63+Zqg==
X-Received: by 2002:a37:9a46:0:b0:6ec:55c9:7872 with SMTP id c67-20020a379a46000000b006ec55c97872mr1597614qke.102.1665695844921;
        Thu, 13 Oct 2022 14:17:24 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i5-20020a05622a08c500b0039bfe8acff6sm740039qte.58.2022.10.13.14.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 14:17:24 -0700 (PDT)
Message-ID: <4ab5d9bb-36e1-2375-4803-d6c0df438de4@linaro.org>
Date:   Thu, 13 Oct 2022 17:15:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 1/3] media: dt-bindings: imx412: Extend compatible
 strings
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, sakari.ailus@iki.fi,
        dave.stevenson@raspberrypi.com, jacopo@jmondi.org,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221013125142.3321405-1-bryan.odonoghue@linaro.org>
 <20221013125142.3321405-2-bryan.odonoghue@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013125142.3321405-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 08:51, Bryan O'Donoghue wrote:
> Add compatible bindings for imx577 which uses the same silicon enabling
> reference code from Sony in the available examples provided.
> 
> Cc: sakari.ailus@iki.fi
> Cc: dave.stevenson@raspberrypi.com
> Cc: jacopo@jmondi.org
> Cc: "Paul J. Murphy" <paul.j.murphy@intel.com>
> Cc: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-media@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
> index 26d1807d0bb6..d1561841ccbc 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
> @@ -19,7 +19,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: sony,imx412
> +    items:

You have only one item, so drop the "items".

> +      - enum:
> +          - sony,imx412
> +          - sony,imx577
>    reg:
>      description: I2C address
>      maxItems: 1

Best regards,
Krzysztof

