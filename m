Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AEE602C23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJRMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:51:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE012C3558
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:51:36 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h24so9186036qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVdCQKWiBBXHEsRPEL3ACgqoSkagQ+GB1TtAZi9uOBU=;
        b=GhCSsLS+B2XDm8XixguHrCvn2HJ5xXyuPFfMlfM2Cebo5naD7VkbQ28SndGB26qRJu
         3SrG+8WmXpln/9qYyuZJXUzZ9e7U5TidOtEM6BTIv0gXfn2wg8Yk87SfvZsiCY1EtsOv
         qNdcE0pbixpJeYpER6xT7rqMBFCclpBdv0l7JmOClnSq59SIsv4vAHmFvd5DilabexcJ
         N7TLBxHcqXizdF3vBWatAH6FjOQU9k/X3RqNJUQvq+Wwmn6SAji9p0TYLmqabnyUdIgI
         sK/bmLana3+sQjvENj/rLl+Wta2zM8YlzuK+nAD6Lx8//0RkFEeaE/J46ZjrnDroY3tH
         eCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVdCQKWiBBXHEsRPEL3ACgqoSkagQ+GB1TtAZi9uOBU=;
        b=67hEisDW1kGFRuHA6umTl7Z76UZYCj2rfA+rMd2A/KiJCPTgo/i++7ZyzynHRqfv/6
         0OIq/fEx4qUKslEz53Gc05PTSObAtTTR2oJO37OTPa1yXDrrmGoQaL0YVePcOvsKC2a/
         Ddg9QxJbdy68o6XtamIXnlBLIdmUuN6L1hT8oSmbSFnzBHGArTgkadVDJr9mDHabfotC
         KaCrgtYUXRIRS4TFfpXB3KHGDj8SvbaWQ9YslXm0gSnl1niPYsBzhJ3mHkB5VidWf7BQ
         obmtBo82aeUf5HBq2St7NlIweXTkc/qktroJ5qj3NFBzWVGCQEkFHjxhcaWmxnkD7g9/
         AIFg==
X-Gm-Message-State: ACrzQf13McJZ37uztLfF9jOwTniCHzkeZKFqJaewobYD4HOXUBDSi44j
        viQaGEGI9QtNCtE2XyWQWuu3iA==
X-Google-Smtp-Source: AMsMyM6JGm04MqT0u2iZhlGgCaC8P6JbYf05oWlqJG/gFIDk14T9YYpE5kwvgvJpQLoV1on6yiGaGQ==
X-Received: by 2002:ac8:5f84:0:b0:39c:e5a2:6cc4 with SMTP id j4-20020ac85f84000000b0039ce5a26cc4mr1935175qta.40.1666097495962;
        Tue, 18 Oct 2022 05:51:35 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id g5-20020ac80705000000b00398ed306034sm1818674qth.81.2022.10.18.05.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 05:51:35 -0700 (PDT)
Message-ID: <37fff2b8-a798-dea3-c010-714a2bac695f@linaro.org>
Date:   Tue, 18 Oct 2022 08:51:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] arm64: dts: mt8195: Add Ethernet controller
Content-Language: en-US
To:     Biao Huang <biao.huang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        macpaul.lin@mediatek.com
References: <20221017095834.7675-1-biao.huang@mediatek.com>
 <d6bda69e-d331-3e64-2100-d41e84c3fab7@linaro.org>
 <b5d18b4b631cb19d435f37ccacd296a2282c2a1a.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b5d18b4b631cb19d435f37ccacd296a2282c2a1a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 02:37, Biao Huang wrote:
> Dear Krzysztof,
> 	Thanks for your comments!
> 
> On Mon, 2022-10-17 at 22:01 -0400, Krzysztof Kozlowski wrote:
>> On 17/10/2022 05:58, Biao Huang wrote:
>>> Add Ethernet controller node for mt8195.
>>>
>>> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88
>>> ++++++++++++++++++++
>>>  arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 87
>>> +++++++++++++++++++
>>>  2 files changed, 175 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> index 4fbd99eb496a..02e04f82a4ae 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> @@ -258,6 +258,72 @@ &mt6359_vsram_others_ldo_reg {
>>>  };
>>>  
>>>  &pio {
>>> +	eth_default: eth_default {
>>
>> No underscores in node names. Please also be sure your patch does not
>> bring new warnings with `dtbs_check` (lack of suffix above could mean
>> it
>> brings...)
> OK, I'll fix the underscores issue in next send.
> As to "lack of suffix" issue, do you mean I should write it like:
> 	eth-default: eth-default@0 {

I don't know whether you should have here suffix or not - please check
your bindings. Several pinctrl bindings require suffixes (or prefixes),
thus I asked.

BTW, In the label you must use underscore.

> 		...
> 	}
> If yes, other nodes in current file don't have such suffix.
> e.g.
> 	gpio_keys_pins: gpio-keys-pins
> 
> Should I keep unified style with other nodes?

Check what bindings are requiring.

>>
>>> +		txd_pins {
>>

(...)

>>> +
>>> +		eth: ethernet@11021000 {
>>> +			compatible = "mediatek,mt8195-gmac",
>>> "snps,dwmac-5.10a";
>>> +			reg = <0 0x11021000 0 0x4000>;
>>> +			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH
>>> 0>;
>>> +			interrupt-names = "macirq";
>>> +			mac-address = [00 55 7b b5 7d f7];
>>
>> How is this property of a SoC? Are you saying now that all MT8195
>> SoCs
>> have the same MAC address?
> The mac-address here is taken as a default mac address in eth driver
> rather than a randome one.
> Actually, there will be a tool to customize eth mac address (e.g
> through "ifconfig eth0 hw ether xx:xx:xx:xx:xx:xx"), so every
> MT8195 SoCs will get their specified mac address in real product.

So this means this is not one MAC address for all SoCs, so this does not
belong to DTSI. Actually it doesn't belong to DTS either. Look how
others are doing...


Best regards,
Krzysztof

