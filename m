Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF77336FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjFPRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346358AbjFPRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:00:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE15049E6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:59:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5196a728d90so1265792a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686934759; x=1689526759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mx45Gb+XOJkrBIEOQGfyEEPJszl2aIrpIEmyleHuzAA=;
        b=oRadAW9LWnD262uK2pxmP5H40mzdqIIoSFwtmKhwYhURgjOAF1K+nhkRzojy3cLt3O
         ZV9QVOCWHeJ70snod2xzhMr++SyUkZCkk52zXtnAV9eYqu5w/I8o0JVQeplagrkNdgJq
         StAIQKvXLx3Iqb86k6ALjzMlY5FpwqSjSSM+hOHM1S6V3TcahlOrPrRguCogeZBKgCJ/
         67xBYPJv5Yjl78YG54OHJ6mwjHVMoyPzLS71qbAB0F/stMl3MMABgtRk/d69jycvF3Br
         PP7u6318cEznzU1ynPTb8tVDvPraT22NIWhpZu2VAdPjt7n4DgvnaU8k1IfASnNwG6RH
         +8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934759; x=1689526759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mx45Gb+XOJkrBIEOQGfyEEPJszl2aIrpIEmyleHuzAA=;
        b=A7gKP7lVmsWvxvA/2sPRTRKg4WnpBOHmIuCEh9wOe7PzAgOtJf+iqJp5YMxESC5NbP
         hY3orC3JmptDzCeXiFYHEZiF7UK6K8EPvPu1VF/VbNrlLLYMXBehhnnY/Q1dmRWMRDql
         Sr3zA2aoFnuAtokNeLiWzmXDliW9U+57nvz2DnkAfil0VD6D6C3PLdSVnef3Yx4UUyI0
         ccBx5OuvJyxGUL1A6D2Q571eJkXE/5bu1gN2qfsgAU/0PGF/1LliQDJn4Q/fwtL9Ah7v
         v3PgWpTjE/QavfoUyiM4J9EJjIIOOruLwVKyjIsj3qJMSxwZ10nFJOnAZcT+BOhTb2vU
         1ZPg==
X-Gm-Message-State: AC+VfDxhva+Rlu52OoJC9KzPkUV5on1bX8Eyo4ZACSvte5vJ5WqbCpRC
        Ew62zjdRdYlBb2lffDUkzBTxzA==
X-Google-Smtp-Source: ACHHUZ7wllev2biqWgYIidoYvTlpr/fZdLupzoU9AbrYoM7SCIfM4LPZ/0xDi5+7EbQ0/3tuQN2dQg==
X-Received: by 2002:aa7:c851:0:b0:514:a685:aa3b with SMTP id g17-20020aa7c851000000b00514a685aa3bmr1432750edt.41.1686934759403;
        Fri, 16 Jun 2023 09:59:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g25-20020a50ee19000000b0050bfeb15049sm9980703eds.60.2023.06.16.09.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:59:18 -0700 (PDT)
Message-ID: <f6283bf7-2c38-8257-e430-d17dd4dd233b@linaro.org>
Date:   Fri, 16 Jun 2023 18:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog
 Board
Content-Language: en-US
To:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <20230616110610.32173-1-josua@solid-run.com>
 <20230616110610.32173-3-josua@solid-run.com>
 <a9098664-ac16-eddb-3e2d-78eb08ac973f@linaro.org>
 <5139b72e-cccb-43b3-ba37-35f0011e4a2b@solid-run.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5139b72e-cccb-43b3-ba37-35f0011e4a2b@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 15:32, Josua Mayer wrote:
> HI Krzysztof,
> 
> Am 16.06.23 um 14:36 schrieb Krzysztof Kozlowski:
>> On 16/06/2023 13:06, Josua Mayer wrote:
>>> Add DT compatible for SolidRun LX2162A SoM and Clearfog board.
>>>
>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index 15d411084065..438a4ece8157 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -1373,9 +1373,11 @@ properties:
>>>         - description: SolidRun LX2160A based Boards
>>>           items:
>>>             - enum:
>>> +              - solidrun,clearfog
>>>                 - solidrun,clearfog-cx
>>>                 - solidrun,honeycomb
>>>             - const: solidrun,lx2160a-cex7
>>> +          - const: solidrun,lx2162a-som
>>>             - const: fsl,lx2160a
>> You change existing entries, breaking boards and changing the meaning,
>> without any explanation in commit msg. That's not how it is done. Please
>> provide rationale in commit msg.
> 
> I'm sorry. Given your comment I think I did not understand how these 
> entries are supposed to work.
> So perhaps you can provide some guidance based on my explanation?:
> 
> - NXP LX2162 is a smaller physical package of the same LX2160 SoC, with 
> reduced IOs and some silicon blocks disabled.
> - SolidRun LX2162 SoM is essentially a different form factor of LX2160 CEX
> - SolidRun LX2162 Clearfog is the reference platform for the SoM. 
> Despite it's naming similarity to clearfog-cx, it has a different 
> feature set more similar to SolidRun Armada 388 Clearfog Pro
> 
> So I believed I could just add to the existing entry "SolidRun LX2160A 
> based Boards" also the new LX2162 Board & SoM.

But you added much more, didn't you?

> I see now that adding a fourth const messes upthe existing 3-part 
> compatible for those already existing boards.
> 
> Please can you confirm if it would have been more correct to replace 
> "const: solidrun,lx2160a-cex7" with an enum?:
> enum:
>    - solidrun,lx2160a-cex7
>    - solidrun,lx2162a-som
> 
> Finally, is it okay to add a "solidrun,clearfog" given my explanation 
> above, or should it be more specific "solidrun,lx2162a-clearfog"?
> 

Test the binding and test DTS against it:
Please run `make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/

It might point you to answer.

Why do you make solidrun,honeycomb compatible with cex7 and som?

Best regards,
Krzysztof

