Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C77342FC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbjFQSQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346423AbjFQSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:16:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CE6173A;
        Sat, 17 Jun 2023 11:15:53 -0700 (PDT)
Received: from [192.168.1.131] ([89.1.214.195]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3Kc6-1q26EK0AFO-010Pfd; Sat, 17 Jun 2023 20:15:30 +0200
Message-ID: <5d2eb5af-b674-751b-1583-e048fbf8c3a5@mweigand.net>
Date:   Sat, 17 Jun 2023 20:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] dt-bindings: backlight: lm3630a: add entries to
 control boost frequency
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Maximilian Weigand <mweigand2017@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
 <20230602-lm3630a_boost_frequency-v1-2-076472036d1a@mweigand.net>
 <17576d81-a342-0b77-367a-eb9f2b97b734@linaro.org> <7491264.lOV4Wx5bFT@diego>
 <c29b2b0c-2b0c-f79c-9de5-58a67edd5c87@linaro.org>
Content-Language: en-US
From:   Maximilian Weigand <mweigand@mweigand.net>
In-Reply-To: <c29b2b0c-2b0c-f79c-9de5-58a67edd5c87@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bV9uqzgIsGllvko+cxd+BlB62CSSsLP5A90XEJ+9cqd1n+07lc+
 AfZkzBcAE+RV8jmhmYvi7ZBTU3W3R7AlJCe1I4Kn5uQTVqpj3r/ox+IW7poeTyFs4hLMuhj
 9XrXA3fiYg+eFkeddVpPQItFoaFs3iaHTpK5cl9PbjUYoKZHT0H24ESmlq9xEHyoBHU5ca1
 Bd+ymstKQAx8B71uT2pAg==
UI-OutboundReport: notjunk:1;M01:P0:25qzwWuEuJA=;SVGc/5dvXzWRF5cOZD0NSglS10i
 Mjr6t2rtiy83DfLVRfBX5GUKRRdMRlaWmJe34yyXjKalRWoW3tDENB5uTDSaR5+W/zLzd0fka
 ehqA+xuQKkQEMmc4FcIchWDQVmgMYHgWIIiGDgtK1F1Mk0DfQql5l45JrjJ8Yc/bPruOAo1YA
 +PYRAREqSd1M7zkCYwpafdYaIZ7J568TLPz36dHk9JqtIXNbpTU9DdP4ZKcMkQhgT1pIZASvo
 zijqDqWHGNe9P9dbPhGb47lYTkTHFXedFOi95dvk57xsnQTZi1UDi73XsRl+6DeuWU9h6H+OU
 JwCxFrq1VtokvzaVCA2JfjLlGoSFpWGpKjciNKgW7ZHWLYdQvkvCTdLbxBi3XbGSI8HZ2zt7G
 z+u9SUcbsDkLumGfXwh+58rmwffBXj+E2Jq63hKTfbJcytqcjpp81+Go+MMnetLecVZSpQWoR
 7tkThgHMmQ1RAFvcoUfpkG6ErXY05ayeVwRWEwDCxg3YIAgkTCeBparFVNhohf794HdP7/KVf
 Dus9PoqxmwhJ4+touPvIMO39BTZcBDOqm0CFYjqAW+FpU0sNzZHopm761MdGtfHKN6FogSNt+
 jsRkUI5HtJ8/ssNdKyKTth5LvSfFleua07eXEXaSYfhNxqk9CjEau2nRg+x1yx6q4Se+tKkSS
 ACUK1ubkwqRY5h3RfmlJB+Y+P4MUqW1WdUURnJp7pw==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17.06.23 19:42, Krzysztof Kozlowski wrote:
> On 17/06/2023 18:34, Heiko Stübner wrote:
>> Am Samstag, 17. Juni 2023, 12:12:17 CEST schrieb Krzysztof Kozlowski:
>>> On 14/06/2023 21:08, Maximilian Weigand wrote:
>>>> From: Maximilian Weigand <mweigand@mweigand.net>
>>>>
>>>> Add 'ti,boost_use_1mhz' to switch between 500 kHz and 1 MHz boost
>>>> converter switching frequency, and add 'ti,boost_frequency_shift' to
>>>> activate a frequency shift to 560 kHz or 1.12 MHz, respectively.
>>>>
>>>> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
>>>> ---
>>>>  .../bindings/leds/backlight/lm3630a-backlight.yaml           | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
>>>> index 3c9b4054ed9a..ef7ea0ad2d25 100644
>>>> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
>>>> @@ -33,6 +33,18 @@ properties:
>>>>      description: GPIO to use to enable/disable the backlight (HWEN pin).
>>>>      maxItems: 1
>>>>  
>>>> +  ti,boost_use_1mhz:
>>>
>>> No underscores in property names.
>>>
>>>> +    description: |
>>>
>>> Do not need '|' unless you need to preserve formatting.
>>>
>>>> +      If present, change the boost converter switching frequency from the
>>>> +      default 500 kHz to 1 MHz. Refer to data sheet for hardware requirements.
>>>> +    type: boolean
>>>> +
>>>> +  ti,boost_frequency_shift:
>>>> +    description: |
>>>> +      If present, change boost converter switching frequency from 500 kHz to
>>>> +      560 kHz or from 1 Mhz to 1.12 Mhz, respectively.
>>>
>>> So just make it a property choosing the frequency, not bools, with
>>> proper unit suffix.
>>
>> i.e.
>> ti,boost-frequency-hz = <x>;
>> with x being 500000, 560000, 1000000, 1120000
>>
>> with the driver failing when the frequency is not achievable
>> with the two knobs of 1mhz and shift.
> 
> Yeah, with a default value (500000, I guess).

Thanks for the feedback, this is quite obviously the better solution! I
will rework the submission accordingly.

Best regards

Maximilian

