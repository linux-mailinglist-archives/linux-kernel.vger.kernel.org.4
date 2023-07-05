Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54184748095
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjGEJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjGEJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:15:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C104170E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:15:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso8097099a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688548538; x=1691140538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJCzfCbfP+uuklVnWKKFWLGAIMomZXFAF+p78y6SU4Q=;
        b=AkpViPs4fGT4ZA3tALgBPTJKdU2Aq8uIRkXm91IFJm94eZa2oH9rg7elk8c6S/nGdQ
         wvus5F0WNiCKJ+sZdvGPIo0/kegN80yJ87KdZjlu4a7/Sk+tHQXnLvpEoGP7xhpqf15N
         LGpJUFdK25RU7UhSQ+ohQgD246XMcAaiWsg/baVZ0H3rPoCkKRTjYysBvlPmPsX5Qt8f
         0TrjGtKMZGJEStRTkcwHDK8D38MmYLm08lxk+cbQAJGUytmifn9fxnqNQC72E19nVG3B
         U9AaFYx3YndwYZ0zCqT8e1QyIOXP1UFqLnwJxo24RNXbiRKnVS/bTGXYwH861J9+bTd+
         9Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548538; x=1691140538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJCzfCbfP+uuklVnWKKFWLGAIMomZXFAF+p78y6SU4Q=;
        b=ewQlwEeGmmvUYNUNI3c6YY/A1KU/SiUoqa9dZPSMzr3sMj86w62HfKVrEkuXVzQ1Xf
         uJSboIky+r9Ae848B8CoOvKNceIXeSYknPt5TSANj00YjAsZuMzteiEjz384j5TadtSU
         WRxXAxE//oqk0DDB94zD0Du6e0AsIxo2qdoXLJf6z3V9cBIFY5RsnxhWvsFrOlPkNB+t
         kJTH4HPOzWVu2loX3pOU/ltON4Rry2nxoEHoVUJCcHvGcRK7FPFutdSO/Dmbc05IyBMb
         mWGIfrbwgTE9lwnFLK7fB7cyRtgPx/AEFwkqpe/wjKHUlg5eamMbr3xnzSxv8UwvGCSa
         QkoQ==
X-Gm-Message-State: ABy/qLYUPaTkBByfV5AWUF+q1CvsW3oFTg9TPKCZDT6Qz3jOLDOEy7iX
        jqifprM69uB6OYpm9aXvKA2jcw==
X-Google-Smtp-Source: ACHHUZ75COoZeSKc6xhwnQVXiL09syhh7QxYpUoNOdQcNMbMhSebB/nKk7rf2jkp6kQtIl02O9QlvA==
X-Received: by 2002:a17:906:38a:b0:98d:63c5:d135 with SMTP id b10-20020a170906038a00b0098d63c5d135mr11511755eja.54.1688548538530;
        Wed, 05 Jul 2023 02:15:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0096a6be0b66dsm14279852ejb.208.2023.07.05.02.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:15:38 -0700 (PDT)
Message-ID: <fb0e8dcf-5397-9e88-15c3-16a044ea6cb8@linaro.org>
Date:   Wed, 5 Jul 2023 11:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: fix DEBIX binding
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, marex@denx.de,
        frieder.schrempf@kontron.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
 <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
 <20230705082853.26kfb7thnxkb5tz4@pengutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705082853.26kfb7thnxkb5tz4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 10:28, Marco Felsch wrote:
> Hi Krzysztof,
> 
> On 23-07-05, Krzysztof Kozlowski wrote:
>> On 04/07/2023 20:41, Marco Felsch wrote:
>>> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
>>> corresponding bindings by adding an own entry for it.
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index 15d4110840654..d9e763ef932e5 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -1019,8 +1019,6 @@ properties:
>>>                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
>>>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
>>>                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
>>> -              - polyhex,imx8mp-debix      # Polyhex Debix boards
>>> -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
>>>                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
>>>                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
>>>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
>>> @@ -1054,6 +1052,13 @@ properties:
>>>            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
>>>            - const: fsl,imx8mp
>>>  
>>> +      - description: Polyhex DEBIX i.MX8MP based SBCs
>>> +        items:
>>> +          - enum:
>>> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
>>> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
>>
>> Same comments as for patch #2. I think this should be rather deprecated
>> - not a good pattern.
> 
> How can we deprecate a binding?

git grep "deprecated:" -- Documentation/devicetree/

Best regards,
Krzysztof

