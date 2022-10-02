Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2F5F2258
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJBJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJBJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:34:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB83ED76;
        Sun,  2 Oct 2022 02:34:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7B3A83200094;
        Sun,  2 Oct 2022 05:34:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 02 Oct 2022 05:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1664703240; x=1664789640; bh=cjGLp8baAy8gDB43lxC6c1sR1
        usQtIeP/SEmMm6Ncko=; b=iGXwYYFIGkITvhamFXGXrzLL+ACVq3L4BxmyppZ6A
        fKUd+jea9gFAjLc0dyzlRqt7gFO+bYv2cNpJob2MxfxT8tkO/UdGgjOK1zE3rZ81
        5iqIT8ieqMeEwXMKxDFXePdo10rSXEAVV4tmuQJBWnK8BQD56FfVlBaKU/KapeW5
        aT7yFCQQpnZYnPbVu0RRfh4y3pV2tegv2tpS81BHC7VYAHVZ3pbXwWVtIM4pHdEV
        wmbDRTcaYAUl+Jso4DLFSVDZdX2P2vW8KeJQQWWw5PdZqwKen9mIm/uppbHFzaIR
        T2NfIcpKzT9tz9Vt7vIdiFdTo38It5FMMq8HGjDGaWuXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1664703240; x=1664789640; bh=c
        jGLp8baAy8gDB43lxC6c1sR1usQtIeP/SEmMm6Ncko=; b=jBOrU6r9lE0SuLIlv
        GPWtPfxu9DfVMSCmEjzqYpcZCFcPRFNL4QECz0K0TmC1ssKLmgK+ABy7oA3rRRft
        VoD5fKER5jktGZw3nt42oPNw6QuVe6Fkiw7uPM+6+xuyZpJp+ilG/GBA42WgPw6x
        sAKVxGeghYwQFpV4Vob74vy4rhrGJl5U5UB0VuAkFgmxAIiZtnvRpt0GTgOmryWb
        iTw0zvi6WTTmzFdxNzOlguzJ3+2dW9v0YC662VbPpEy2NxvJQx03mfsjOZFWAyHM
        njqLG0MgvjOic2KYFARy0jYtwXmcYCJxeEyw2jAIfLIhydZUZHAeDlux+cXoW9DR
        6Hf4A==
X-ME-Sender: <xms:B1s5Y_mr1VNhmwK74hrKPPGObgYIQvYKGxer_Eo_SPTI74ZL_RfWcg>
    <xme:B1s5Yy0L_mnWUMPxZljgN8zu1VVWna349wAi67DkhkCzSPupiNRibne34zxoz18mV
    3IbP8-2Q1Y7eJO1-A>
X-ME-Received: <xmr:B1s5Y1qIEap8thcOkUXZRDo-uWLany0sQYKfkpy-WG_s9xBCFvwFq0ox8D98OuW7xoZkZNP-l2Aa9PjtY7EYzVE6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehjedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeejkeeggeehvddugedvgfffhffghfejheeigedtieeuveei
    gfduueevfeehfeeuvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhf
    ihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:B1s5Y3lW0y0GgnG2O6wiW8CeQMf9BleNaU9G-ia7lz1HbNl2Ckdy3g>
    <xmx:B1s5Y91LfETReAcu7BM85ezRadzldgDWZ-EiPYooCb01ystkNNfavw>
    <xmx:B1s5Y2t3t-s1Nf8C4zSFdEqFA1tKDIhFNziyg3stnGceB1TjbW1g1Q>
    <xmx:CFs5Y-s6lsOTqxfK5G9sIqIJsdd7VG7Y0Zb-V4AKgkoOq0RS-rlrJw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Oct 2022 05:33:57 -0400 (EDT)
Message-ID: <54e14c57-e30b-5a39-00ca-1dcc7b352844@tom-fitzhenry.me.uk>
Date:   Sun, 2 Oct 2022 20:33:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] arm64: dts: rockchip: add BT/wifi nodes to Pinephone Pro
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20220906124713.1683587-1-tom@tom-fitzhenry.me.uk>
 <20220906133539.6ghjlzbs2ozgsa7v@core>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20220906133539.6ghjlzbs2ozgsa7v@core>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondřej,

Thanks for the review.

On 6/9/22 23:35, Ondřej Jirman wrote:
>> +	/* Power sequence for SDIO WiFi module */
>> +	sdio_pwrseq: sdio-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = <&rk818 1>;
>> +		clock-names = "ext_clock";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_enable_h_pin>;
>> +		post-power-on-delay-ms = <100>;
>> +		power-off-delay-us = <500000>;
> 
> Do we really need such long delays? Almost no boards in rockchip/ use such
> delays at all, and if they do they don't usually use power off delay.

I have checked the datasheet, and updated the delays accordingly with 
explanatory comments. This is applied in v2.

>>   &sdmmc {
> 
> see below
> 
>> @@ -380,6 +414,20 @@ &sdmmc {
>>   	status = "okay";
>>   };
>>   
>> +&sdio0 {
> 
> sd'i'o0 comes before 'm' in the alphabet.

Done. :)

> 
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cap-sdio-irq;
>> +	disable-wp;
>> +	keep-power-in-suspend;
>> +	mmc-pwrseq = <&sdio_pwrseq>;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
>> +	sd-uhs-sdr104;
>> +	status = "okay";
> 
> It might also be good to add the wifi node, and hookup the interrupt line and
> pinctrls, so that WoW works, while you're at it.
> 
> See eg. https://elixir.bootlin.com/linux/v5.19.7/source/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts#L30
> 
> Looks like WIFI_HOST_WAKE_L is hooked to GPIO4_D0/PCIE_CLKREQnB_u according
> to the schematic. Let's hope GPIO4_D will consider 1.8V as high, because SoC
> GPIO4_D is in 3.0V domain and VDDIO of wifi chip is 1.8V.

As discussed off-list but included here for posterity, I'll leave this 
out of the DT for now, until we know the GPIO that the firmware is 
expecting.

Regards,
Tom
