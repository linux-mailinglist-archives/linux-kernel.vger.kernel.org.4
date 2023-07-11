Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC04874E6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGKGEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGKGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:04:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E4E8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:04:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so7252034a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689055444; x=1691647444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvCt/5UUakg9y6Uz7bMa30FSsOZLuhTPgz6oZIUp0Kc=;
        b=rpVmZDJ1sscanLTJgRpgPg+4t4KCrN8zEUYKkDCKvv7t+79iNFixblf3RQlutTUpAd
         VXvtPg7kBoNvPVWEEJDyrhsbdNOl09awrB3U+gULPZHHVYrMhbL0nVHuX/ULUC5TtU0Y
         ILBBXnYPEcuDAbuROjvjQY2qiFzqqmif9D6MbUA8zb/ItmnwWUnKbii0OFiI8lpVF3pT
         eZw0A3UvMZKZZRyC8oGmBm5ZfZ2uZjGLZ1/6K/Bp3hvdTEiKeJ4QuCHUTEmHTwyouzeL
         qhKXGGskGxjGT44I810ahOK7f6wvFNcuQHeCl4DA99KmGQJAebYS4jvnTg011JVCcLa6
         Lhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055444; x=1691647444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvCt/5UUakg9y6Uz7bMa30FSsOZLuhTPgz6oZIUp0Kc=;
        b=c+t5M7rPtDE0lafc/BV66B6PPAQ98oFugqkcGxqv+Deit1jyIBAlYP2LUguFwx3FLt
         ROGlumtaBgI2v9+yl9M6Dj+XpAwWKitLOM0nNAXAgaqECNrY9lDyjXg3s4zTkv01JXLT
         O3w92EKpUZ4/jH9KidhoYOtxxrxsKMq4gtNiLoGno0FWML4ISNDme9UmpwWiNJdfBS4e
         aSQPsRZl3BwHse26vXuNudanRxG3R0FNddTIwKjNYpl29WVyJZrgR5AcrkarJm4a+zyx
         HTreOkf1TFuyMPpt2FW+rIFehRhQ9M0WHbQv+Oa3xLG48B8XteDZVobZNwxKD/o0CUNC
         mKOg==
X-Gm-Message-State: ABy/qLZvSLl1Xq6JTJIZxWUU3DdFT+/Hl3KoettuKd8UmDnm0pnmOLao
        mveR8a5+p6b4GYBOkP8OZEIZTg==
X-Google-Smtp-Source: APBJJlGgYimDY0Oj0VI1rKXq7b5qdw4gFm0es77gwE01R6rrwMsb4e+ODeQbfbmQ7lZCmEBCv7JjPg==
X-Received: by 2002:a17:906:72c3:b0:994:1845:1e72 with SMTP id m3-20020a17090672c300b0099418451e72mr1279642ejl.1.1689055444273;
        Mon, 10 Jul 2023 23:04:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00992eabc0ad8sm674339ejt.42.2023.07.10.23.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 23:04:03 -0700 (PDT)
Message-ID: <97436a92-2cbd-0498-8aad-444ac3fab99b@linaro.org>
Date:   Tue, 11 Jul 2023 08:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: ti-serdes-mux: Add defines for SERDES4 in
 J784S4 SoC
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, peda@axentia.se,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-vadapalli@ti.com
References: <20230710102712.155195-1-j-choudhary@ti.com>
 <d136d58d-9582-3833-861f-086b64c1ad36@linaro.org>
 <ecbb6d34-e024-f6c6-5921-ba7bc6fe2e5e@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ecbb6d34-e024-f6c6-5921-ba7bc6fe2e5e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 07:55, Jayesh Choudhary wrote:
> Hello Krzysztof,
> 
> On 10/07/23 17:11, Krzysztof Kozlowski wrote:
>> On 10/07/2023 12:27, Jayesh Choudhary wrote:
>>> SERDES4 has 4 lanes. Add lane definitions for it.
>>>
>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>> ---
>>>   include/dt-bindings/mux/ti-serdes.h | 20 ++++++++++++++++++++
>>
>> Where are the users of this binding constants? IOW, why do you need to
>> add these?
>>
>> I don't see users of existing constants either...
>>
> 
> These constants are propagated in the idle-state property for the
> mux-controller node (named serdes_ln_ctrl) usually in the final
> board dts files and occasionally in the main dtsi files for TI SoCs.

So they are not used. Do not add headers which are not used - neither to
the kernel sources, nor to the DTSI. The header constants don't even
look as suitable for bindings, although this is tricky to judge without
users.

Best regards,
Krzysztof

