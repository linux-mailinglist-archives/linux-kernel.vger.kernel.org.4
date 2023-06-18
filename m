Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91AE7347B4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjFRSrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 14:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 14:47:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D791C12B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 11:47:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-970028cfb6cso457693866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687114031; x=1689706031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hab+VindhIOG0MIUDS0WqXLDAI9UcPdnEWEsRW9fqc=;
        b=ZM/AisTFRxQG6THFbpFj/rf7+PFQtOf3iKCt0TX0vBuKInKVxU6SQDMqBWoBvQodmk
         YOfDmL2hHDXRiRVyDzMS67QL/v1n8uDJF836+WH9tfaWoVJ4joWl1JttiSnnPNrG3HuY
         9oBaGRKxWBBzut7ITbCxsBTzFkjdaa89+Cwc5wbG05jBUJVMt55yQvr+VhtDBY8hOLIK
         j+2KktXJTTUauqXO933Ws/O7LlIp/LBDv9m1vIGiu69qDpcp8aibwCDA2xZ1WEjTpVw2
         bhWcKJJ7ooNXA+sY13+VmIE1iPVqDtQ/+d0iee+jfKz0w+xFvD5hV65bbxmaz02Rt4+d
         rADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687114031; x=1689706031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hab+VindhIOG0MIUDS0WqXLDAI9UcPdnEWEsRW9fqc=;
        b=YPC0g6zUOWBvCVjHlHfC/7/e1Zrf8RpoXQxeZSXaUPAwuIBddvcii8fvMDBnKFTqa0
         yCVVA9kWbC/Fx8MYNVu6hzYRH6Q8A95nJAUDFEdQj07derGsD0UA7d1exK+3m6NLV0wl
         Y/gFGalNLf/9e/y1dct029tV9Ois+cjOR4S8498YDhgTNx0XpuBUgOR8mxJFQ9z8Vrw4
         978tVGX/MTrjg88uXlLdvLpBnoMpHRu9bbePcQVdUPx6g3McopjreRyeBWVII72STEM5
         N7CPkyujwjGqDKxR9Yrwv5DOD5xf9U06+lqpsEMyMMdoZkiBe8wHPAfnbHopgNwmDc3U
         Idbg==
X-Gm-Message-State: AC+VfDwpEZlYKX7PoloetprNijP0faDgr49/n2t5a2VzpFWGEV08oS+t
        aHjSKiFzuFKApwe6nkG3Z8+Olw==
X-Google-Smtp-Source: ACHHUZ4/1pQ31Dnx/F8V/OARE1r0jXPs8y2FLx7mi/eQ9jEw6dIHfl6LoHV08X/SgkAqP7hdTKkwbw==
X-Received: by 2002:a17:907:2d28:b0:96a:3e39:f567 with SMTP id gs40-20020a1709072d2800b0096a3e39f567mr8911168ejc.47.1687114030722;
        Sun, 18 Jun 2023 11:47:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kq17-20020a170906abd100b0098885494649sm928632ejb.128.2023.06.18.11.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 11:47:10 -0700 (PDT)
Message-ID: <254978f3-3bf3-7cf5-e2b7-69d413acf092@linaro.org>
Date:   Sun, 18 Jun 2023 20:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] dt-bindings: intel: Add Intel Agilex5 compatible
To:     niravkumar.l.rabara@intel.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wen Ping <wen.ping.teh@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, netdev@vger.kernel.org,
        Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230618132235.728641-2-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230618132235.728641-2-niravkumar.l.rabara@intel.com>
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

On 18/06/2023 15:22, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add new compatible for Intel Agilex5 based boards.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> index 4b4dcf551eb6..28849c720314 100644
> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> @@ -20,6 +20,7 @@ properties:
>                - intel,n5x-socdk
>                - intel,socfpga-agilex-n6000
>                - intel,socfpga-agilex-socdk
> +              - intel,socfpga-agilex5-socdk
>            - const: intel,socfpga-agilex

This is agilex5, not agilex. Why are you using the same SoC compatible?
You have entire commit msg to explain your hardware and avoid such
questions...

Best regards,
Krzysztof

