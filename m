Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDEE739732
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFVGFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFVGFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:05:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A610D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:05:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f766777605so9029347e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687413938; x=1690005938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d48QL4xYBkYPSQ79byiwt7gdoiHpfP1AngpKZiSgsmo=;
        b=pDGDZPRo4LMAO7LsAH/HPtgh50sV9icy1ai8AYAceBTMnBNTj1tVmVfdCPiK08qAbV
         AcnPZtdnFMkoT6VmBJ4I+uCbZyqzZ774UdpOG28TCqTJ0i0K89bz/WxETQTn4YbI6a3p
         z7RflGIlSy23sVd2SN0S9a0dFcvPo0/QFg1lLh03K99ZuUJvK2jsiumW3SkPSzmeScGR
         f5bmfeA12+9Jz4cPzg/zp9AtCRNGiTJsStJYQqIokHb4C6N+X8e2l1EQC4X/9Wu0rZN/
         OEJDVWNzgxf53MjydCSFoxCjMTnA+F45B99E25OgqI0pGq82DgOBaYVLLZTpQ8cOzF0m
         TOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687413938; x=1690005938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d48QL4xYBkYPSQ79byiwt7gdoiHpfP1AngpKZiSgsmo=;
        b=ch820Ianj4+Yj3hrJ4qxegJFbQACWYkvOls4cp5+1irf55u40kMLuO68fkB5fnzBWd
         CDvqHx+Znn+MVF6a7jd5qdxdzcuoembN9tHKG9aYiXLd+YSi3Mlj2oGRnsXNmQA14RRr
         6X+p+rojBOXRpVCtgLTDx7BXb/uVAPbZVvlznK4Vvu+FBmCH9Qgcuskp7CIuRRw/6bGf
         kdpEz0X3MM3Xi1MsZPVkayzzi1sK94fMdkmZHhrspQ96szcocT/M97mZpNBjsYQRPWpB
         LO/KUnytetV4SdKJRKHt6wmdFK/SjR4wkj3s8X/Zqvgd4RP1z/mezGjMOIvFDG8LoR6L
         2PQA==
X-Gm-Message-State: AC+VfDzOgVZLJaNQo0yiV8B7nbDhp5P3HINxf3MQwfZmFZbf9AXdd9JX
        /sLFwIh/TN1nuQGtvdn0zgJ4Og==
X-Google-Smtp-Source: ACHHUZ4mzF9dz2D1rbqamqE5oOM4nBo5i0YkWVxNocvrS9XvQU+a+JjvBtryfGC6QIeOVmUOk9dGHQ==
X-Received: by 2002:a19:7b06:0:b0:4f3:a051:58df with SMTP id w6-20020a197b06000000b004f3a05158dfmr10488956lfc.59.1687413937848;
        Wed, 21 Jun 2023 23:05:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y17-20020a056000109100b0030c6751a49dsm6057792wrw.115.2023.06.21.23.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 23:05:37 -0700 (PDT)
Message-ID: <e4c993e1-8409-1ec0-c1b2-175603052e46@linaro.org>
Date:   Thu, 22 Jun 2023 08:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
To:     tanure@linux.com, Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230621133215.109254-1-tanure@linux.com>
 <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org>
 <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
 <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 07:32, Lucas Tanure wrote:
> On Wed, Jun 21, 2023 at 7:12 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> Lucas,
>>
>> On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
>>> On 21/06/2023 15:32, Lucas Tanure wrote:
>>>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
>>>> There is no need for an extra compatible line in the driver, but
>>>> add T7 compatible line for documentation.
>>>>
>>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>>> ---
>>>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>>> index 01ec45b3b406..860ab58d87b0 100644
>>>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>>> @@ -33,6 +33,7 @@ properties:
>>>>                - amlogic,meson8b-uart
>>>>                - amlogic,meson-gx-uart
>>>>                - amlogic,meson-s4-uart
>>>> +              - amlogic,meson-t7-uart
>>>>            - const: amlogic,meson-ao-uart
>>>>        - description: Always-on power domain UART controller on G12A SoCs
>>>>          items:
>>>> @@ -46,6 +47,7 @@ properties:
>>>>            - amlogic,meson8b-uart
>>>>            - amlogic,meson-gx-uart
>>>>            - amlogic,meson-s4-uart
>>>> +          - amlogic,meson-t7-uart
>>>
>>> It does not look like you tested the DTS against bindings. Please run
>>> `make dtbs_check` (see
>>> Documentation/devicetree/bindings/writing-schema.rst or
>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>> for instructions).
>>
>> Check back on the previous version, I should've posted an untested
>> version of what you need to add.
> I saw that, but adding a S4 doesn't make sense to me. And you didn't
> show the entire change, so I can't understand what you want there.

For sure you need something which does not trigger errors. If you claim
adding S4 as fallback does not make sense, then why did you use it?
Sending a code which is clearly incorrect does not make sense.


Best regards,
Krzysztof

