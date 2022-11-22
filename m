Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EAB633767
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiKVIrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiKVIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:47:46 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C77DEC7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:47:44 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z24so17186542ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVyULofyXcnVVQ29vB0Fko3SwHgoM4faRFcX0yYLiSg=;
        b=LLjsjh325lx3Ti3P8ylbumojC9SaeLhxq9yEV0Q0SYfFQK5mGtZk+nObijV1kB+VVw
         3bXGTyizOVpbY4Bd1q0DMHkF5f8iB9R07KTEkpBUWl4BcgWCSTHc/O0mVCs+qCQLWIA8
         HgwdruD1rJo8CnOjo6Kv5cxkt1inlFBsl0+Ck/yd3F9Y5JbEq7Iwj160Jf+O5OyXzEKx
         J+gMFN1dnt/nI/XKsgJvJNn7Dzu9+NXYMsjK9uLw8EA9H5wz7tiUQpI1FTwF3rU9xctL
         VLa6UElvOQK1EwiaJji5baNFknS9WtFELui4kkgJNnqEp+v6u8Ss1MfaixIfyrqt7x7I
         CKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVyULofyXcnVVQ29vB0Fko3SwHgoM4faRFcX0yYLiSg=;
        b=MzEU7IBn2eEE+iHOFk55SO0daxUHLGBnIJ3Up2WnsDZ1Fl3+bTxspl+EZkmX+YL/PM
         E8zFFUhkF9BvhlhNaq95Flxq4jVyIHfFhc3kT/uI0BUxjgcMZbjMeBpfx7ecwRqb2B0F
         aDzJdl8Oz7hcRhPbBZeXzx8LzSiY1iVsbGajNFSRpZ3uIWAwTvu7DzRhv+Yn8tqw7tjv
         ZdjyhlRgqNLciHI/LKfqjAIY1fi3mwFfO7frnwRtjT8AdQW1OCfg+EgEd+kFiWnho1VZ
         TKniJ3oM7jPBGaXg1HQZfO0NnXigKVhsWJ9Tor/YvS/WvxiZ704mKBVbVquJHRBP7Ss0
         awFA==
X-Gm-Message-State: ANoB5pmRxSR/k2O5YD1G13DNHWQprv4sP79OxF37K84gniBpEoOw7gfd
        DXHugHJhL2CttP/Zd78DxfLXGA==
X-Google-Smtp-Source: AA0mqf7k5iwY141yncd+8E0m1ND/kel/yIq78tBa2St5zPKWuRN693lQjtLUesOm2KUbPH4OKCzj3w==
X-Received: by 2002:a2e:a4b4:0:b0:26c:5cf3:cc89 with SMTP id g20-20020a2ea4b4000000b0026c5cf3cc89mr7258771ljm.483.1669106863018;
        Tue, 22 Nov 2022 00:47:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l7-20020a2e7007000000b0027776efa48csm1784076ljc.91.2022.11.22.00.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:47:42 -0800 (PST)
Message-ID: <46ce4cdd-45c4-3470-d89c-b58219d90838@linaro.org>
Date:   Tue, 22 Nov 2022 09:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible for
 OpenC906
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-3-uwu@icenowy.me>
 <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
 <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
 <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
 <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 08:41, Icenowy Zheng wrote:
> 
> 
> 于 2022年11月22日 GMT+08:00 下午3:35:48, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 写到:
>> On 22/11/2022 08:18, Icenowy Zheng wrote:
>>> 在 2022-11-21星期一的 11:06 +0100，Krzysztof Kozlowski写道：
>>>> On 21/11/2022 05:17, Icenowy Zheng wrote:
>>>>> T-Head OpenC906 is a open-source-licensed fixed-configuration of
>>>>> C906,
>>>>> which is now public and able to be integrated.
>>>>>
>>>>> Add a compatible for the CLINT shipped as part of OpenC906, which
>>>>> should
>>>>> just be ordinary C9xx CLINT.
>>>>>
>>>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>>>> b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>>>> index aada6957216c..86703e995e31 100644
>>>>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>>>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>>>> @@ -35,6 +35,7 @@ properties:
>>>>>            - const: sifive,clint0
>>>>>        - items:
>>>>>            - enum:
>>>>> +              - thead,openc906-clint
>>>>>                - allwinner,sun20i-d1-clint
>>>>
>>>> Add entries sorted alphabetically. This should be squashed with
>>>> previous
>>>> patch.
>>>
>>> I make it a seperated patch because I think it's a questionable
>>> approach.
>>>
>>> If you think it's okay, I will just squash it and put it as the second
>>> patch in the next iteration, with adding openc906-plic as the first
>>> one.
>>
>> What is a questionable approach? Why commit msg is not saying this?
> 
> Ah I mentioned it in the cover letter. The problem is just I doubt whether
> binding strings for single SoCs are necessary.
> 

There is no question in cover letter. Just some minor remark *at the
end* of it...

If you have questions, be explicit, not force people to grep through
several paragraphs and figure out your concerns.

Best regards,
Krzysztof

