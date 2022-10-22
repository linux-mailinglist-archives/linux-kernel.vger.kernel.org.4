Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D9608E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJVQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJVQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:35:30 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9614D1F6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:35:29 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1324e7a1284so7211820fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBm0P3FPX2F4B7EXDqIEp1ZB1xk9MTQmB4rl3mZnXIY=;
        b=f8pvx7q1zwdMngBbP7ZEUPfZkrFHxQxA48Ai3+mygs/GLpdKI7VUvGM9oYNvRDbn7Z
         wN6FxU3NQy5sPMsOsv9WTOWxhSIjy/2yUBxTdnSvOGLlcC0e13wS4G9ESzgnU4eiawhs
         GIZSfDlMmqkgJB/SeIPZ00hAXb0qbYUtM8jzuEb0oUrzg1e6Bt0vZOgCMd40Puy9dPDq
         k4bSgofMU1/EBkgKSo8CboheihaEoNiSe6lAQYuvJOBq50v+aFqQHJL51JL/7VqabJj1
         dTXTdzZ4/eSOnTVpQHuqjFafZ+aruePF6z/neyN5p/quTJuiJTeaHzsHiXMdyqzxA7eH
         CNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBm0P3FPX2F4B7EXDqIEp1ZB1xk9MTQmB4rl3mZnXIY=;
        b=wGWHn+PRzXfnXanTD1qGOo2DCvIM+Ybq0pa4Ps1hPPgtRyuDJkwucqzm2g60wrtyTs
         3Vt0v5rXAki9yzy2dfha96iCD4x3WKgRwBxBu82RjSc4a3exdboM+HW5ffyEZ3B7WiBW
         hD1QI+OiF1PtKSOUJAyctiTGFamc7HQRv6//mpPEyILJ9nyZI4CpUPfxQn74mpkKn8OI
         hdt+zd/UHNcXrz933n+nd4rzTGJQHPH4O+JQCURA9Ras7hyKWh9vYzr9fWq1u/ki1o1f
         C4V+wxTAkFkOGynFDpEpS09YAcNx+bNFCtrzh3GufyOSph715H0abGMzQK/uB6m48b7a
         vu9w==
X-Gm-Message-State: ACrzQf2kGDqe5kwW/9WS51NtaH0m2slzlQVuJe6frtmqs72YIzI0wvJ7
        hU6k6LBVkC/iTrpm+03G2Kyxow==
X-Google-Smtp-Source: AMsMyM76MhMoHP1Wv+m5Kd8A1kqDnYPXtPFcM3+UoKXjBStkyLbBUXCXUx5uQ9P3gSSkMeyo69lA6g==
X-Received: by 2002:a05:6870:8193:b0:13a:e465:ad18 with SMTP id k19-20020a056870819300b0013ae465ad18mr9607934oae.30.1666456528592;
        Sat, 22 Oct 2022 09:35:28 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id k14-20020a9d7dce000000b0066210467fb1sm2443640otn.41.2022.10.22.09.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:35:27 -0700 (PDT)
Message-ID: <5182e3c4-9e5e-2c36-408b-9029c65c8803@linaro.org>
Date:   Sat, 22 Oct 2022 12:35:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: pwm: mediatek: Add compatible string for
 MT7986
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <Y1K53n7LnjoMoIfj@makrotopia.org>
 <20221021222338.GA565200-robh@kernel.org> <Y1MkIdFXrBrrv958@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1MkIdFXrBrrv958@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 18:58, Daniel Golle wrote:
> On Fri, Oct 21, 2022 at 05:23:38PM -0500, Rob Herring wrote:
>> On Fri, Oct 21, 2022 at 04:25:18PM +0100, Daniel Golle wrote:
>>> Add new compatible string for MT7986 PWM.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>> index 554c96b6d0c3e0..6f4e60c9e18b81 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>> @@ -8,6 +8,7 @@ Required properties:
>>>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>>>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>>>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
>>> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
>>
>> This version of the PWM h/w is not compatible with any of the existing 
>> chips? If it is, it should have a fallback compatible.
> 
> No, it is unique because it comes with just 2 PWM channels.
> Otherwise the driver behaves just like for MT8183 (4 channels) or
> MT8365 (3 channels) which also got distinct compatible strings.

Then something would be here compatible. E.g. If you bound MT8183 with
mt7986-pwm compatible, would you get working device with two channels?

If so, they are compatible.

Best regards,
Krzysztof

