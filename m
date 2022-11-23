Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA73A636193
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiKWOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiKWOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:22:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4F74CE9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:21:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso1539282wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s2W7b5464QZ3y8H83iSDFZMEw1jsrSlHRDfoJncclTM=;
        b=je7shZ9Gyzpr/PD97g5u6A8HMxCq+ZUWuC6+eSmw1w+GMN3pmylKToBeH88Mmd3koX
         QHSzHgYt8kTUWugIAOwWDugqG4cABuFnbkv79xI72zd2/sCE+6pyABpf//s4kFQywozf
         tH1f1CGcl9yt9/A5ALUoA4s9hTG3NTMwAqiqbNCUiBQpImNtVqt3tbgWi+TA4sbHA2gA
         wBGO3B4FGCl8KV+TmFoMdHUUMPNbqXAsBw/rm/A8KbFxVXUw5BsbJjmmMQwcoOnXHhM7
         ePjTgIoJRYRLojiixYl41sbxg53tPS5MMWvtY1IYihALpHJbl5CKDpVsBzCMwhYgGSR1
         oNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2W7b5464QZ3y8H83iSDFZMEw1jsrSlHRDfoJncclTM=;
        b=B+F8lEU/oMFgNac5d+tysG6EMYOXnb6Fw/0jnNodkrLo8cNeCIHAVpMfh2HdUw94BQ
         o+JX7wSoxdoBLFeBKCIdJTRKJAZO0uLYHuJJdBLX3Rig7lmN1fMV86S/08PVOrEURMGH
         XYeM5M9QEmEduDhYRhBRaLUjN6D05X4+ofmCWc3RjaQLXd8xKrJVrYUUUzY3DJsofV4v
         +bITEX1GQghKI+GKXjwdZW5YY78dDts4ADz1/CrkN/63rn6H+QNyw1Eb/K3D5hniisO3
         LqFu9kdUWRX6/o0aKGYzpcYlhH6P09ixQtT5Eym+uhFKJNznN5GXYHwytn6EiOq2Av4k
         HSsQ==
X-Gm-Message-State: ANoB5pnZSdihA3tEZ0K28iusN3DCJWW050mCb38kosWouARckR8wy9s8
        Gl8yK2ksUEVQVLTITmZS2u54fw==
X-Google-Smtp-Source: AA0mqf7f4zOfnnJVMh7RSMvMRxhALijsWR3bI/57+eyW7MsHBRlpNG3HN3A/HVPrKXZDhtAtQQ/Qog==
X-Received: by 2002:a05:600c:5389:b0:3cf:a343:9a28 with SMTP id hg9-20020a05600c538900b003cfa3439a28mr10285608wmb.186.1669213301323;
        Wed, 23 Nov 2022 06:21:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e551:24c3:152c:7c05? ([2a01:e0a:982:cbb0:e551:24c3:152c:7c05])
        by smtp.gmail.com with ESMTPSA id q6-20020a1c4306000000b003cf774c31a0sm2006778wma.16.2022.11.23.06.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:21:40 -0800 (PST)
Message-ID: <2153a111-d5f0-94cf-9cfc-f8ce4b084a1c@linaro.org>
Date:   Wed, 23 Nov 2022 15:21:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V5 4/4] arm64: dts: meson: add S4 Soc Peripheral clock
 controller in DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-5-yu.tu@amlogic.com>
 <ae43fadf-9255-7db7-8b5e-01200e02a2c6@linaro.org>
 <9961d579-9463-c585-34a6-a3abcd4b3e52@linaro.org>
 <7f3a34a0-a5b0-3a72-8e0e-00656bd77ff6@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <7f3a34a0-a5b0-3a72-8e0e-00656bd77ff6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 15:13, Krzysztof Kozlowski wrote:
> On 23/11/2022 14:27, Neil Armstrong wrote:
>> On 23/11/2022 11:10, Krzysztof Kozlowski wrote:
>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>> Added information about the S4 SOC Peripheral Clock controller in DT.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 26 +++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> index bd9c2ef83314..e7fab6e400be 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> @@ -6,6 +6,8 @@
>>>>    #include <dt-bindings/interrupt-controller/irq.h>
>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>    #include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>>>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>>>    
>>>>    / {
>>>>    	cpus {
>>>> @@ -100,6 +102,30 @@ clkc_pll: clock-controller@8000 {
>>>>    				#clock-cells = <1>;
>>>>    			};
>>>>    
>>>> +			clkc_periphs: clock-controller {
>>>> +				compatible = "amlogic,s4-peripherals-clkc";
>>>> +				reg = <0x0 0x0 0x0 0x49c>;
>>>
>>> This is broken... did you check for warnings?
>>
>> This is actually fine, the parent node has a ranges property:
>> https://github.com/torvalds/linux/blob/eb7081409f94a9a8608593d0fb63a1aa3d6f95d8/arch/arm64/boot/dts/amlogic/meson-s4.dtsi#L93
> 
> The parent ranges do not change here anything. You cannot have a reg
> without unit address and the tools report it. No need to use reviewers
> for this...

Oh I see now, I simply looked at the reg property, not the unit address.

Sorry indeed it's wrong and DTC should complain.

Yu, you should probably update your DTC version.

Neil

> 
> Best regards,
> Krzysztof
> 

