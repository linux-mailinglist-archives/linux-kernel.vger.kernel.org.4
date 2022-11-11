Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC8625FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiKKQsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiKKQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:48:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87087BE51
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:47:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso3469422wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzIj0FbLWchm5YW+Ojb+mjYmHVpc0ognIOdlvY0jJmc=;
        b=ORhWQXVLVCj32JAAdbD6We+SlO95hOo3Z4kePacUi0Y4dFJNCDHuu8Or4jGVP5syl/
         tv0XO4ztzdwyoOGsjdOHi2kp9D12+rOGHjXiiCm/ytEKdvPXsJsAXhr7h/kicaYCeKfY
         Ey8pwYYntRtXa9S7Oyd5k1u6h4KpNdVJeY5TGI6VA1JWDyPNUxU1WUwGr+F+iDr7IuKg
         FLaWLRPXpqWBk3LRuVQF7Bi5OoZMGySUSndVWQiCAy9W5FuJQDgdK7hxa4vA463AJbOI
         QPp9YBXHbZMTJVnPpDOGseekGWa9esEzo/3aZew/HbQBRzZIreOMoFHelwsCG8phCF7C
         oxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzIj0FbLWchm5YW+Ojb+mjYmHVpc0ognIOdlvY0jJmc=;
        b=UT/kifP3NF+NW8sYwSymR5kJ+bq2kWbTe0Jjs7tEd8rIS8NtDeXpW1gKY4ePd6I67+
         NAYlCOPG/K+ckcF7o7SNKC+rN8wVp/hGEmgKxRI9ziznoR+qpuQRXrjSnhZagSvPqjeL
         fMplO+rnZjVL3FOL939sW1lky5Fs7UcJaWSo6Xa0zDUS0Ka702CbxXsTZQOOKto+spgF
         2Ogpg6/9KATxfuDtfZ/xLSlj8bzR9qznkGczJjEvYEp6eaf1oIaxKjrGcUmT0IeY9iAf
         auORJzpSFhbsFcbpLz55fhYghJzo/1hwFOz8fXsMWPoWInBZDXcdINiMXh0ISon7NX62
         YbwA==
X-Gm-Message-State: ANoB5pn3XuLnQFEqUmsh4pDTJVpL0JA1Jojc8tFdRAUrgw/0LsK3giyC
        /K2qlAGOh9Qp8vXuVMAmIdZUIQ==
X-Google-Smtp-Source: AA0mqf4lxHD2VhR2gUmwYJipW4ys4Uden0b2CxCOUYSldiDwhdTomovtUeokqfW6glhyz46sxexSFA==
X-Received: by 2002:a7b:cd12:0:b0:3cf:5080:412c with SMTP id f18-20020a7bcd12000000b003cf5080412cmr1821930wmj.99.1668185278322;
        Fri, 11 Nov 2022 08:47:58 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm12135959wmo.27.2022.11.11.08.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 08:47:57 -0800 (PST)
Message-ID: <c17ec8e0-a0c9-dc18-dbbe-3844b4147437@linaro.org>
Date:   Fri, 11 Nov 2022 16:47:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/6] dt-bindings: nvmem: Fix example
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-2-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221104163833.1289857-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2022 16:38, Miquel Raynal wrote:
> Despite not being listed nor required within the top level nvmem yaml
> file, the "compatible" property is mandatory and is actually enforced by
> all the nvmem provider bindings.
> 
> Unfortunately, the lack of compatible in the nvmem.yaml to level
> description file lead to the example not matching anything and thus not
> being checked at all.
> 
> Let's pick a compatible almost randomly (one which is already used with
> the qfprom label) to make the example at least valid on a semantic
> point of view and getting it checked.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied thanks

--srini
> ---
>   Documentation/devicetree/bindings/nvmem/nvmem.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 1eb22dba364c..0455506fc30f 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -67,6 +67,7 @@ examples:
>         #include <dt-bindings/gpio/gpio.h>
>   
>         qfprom: eeprom@700000 {
> +          compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
>             #address-cells = <1>;
>             #size-cells = <1>;
>             reg = <0x00700000 0x100000>;
