Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39805F2B74
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJCIND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJCIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:12:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8B55809C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 00:47:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u14so872668ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 00:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bB4QODiV4ix6zkRrvYNhY3GV2ClzEd5J+34STuLCzKw=;
        b=yZ5ng242zRMNlTnRBjTZtxobncF3M8tT6KrSVOIR2XyKNpVv8ggJpdPN+rPLdlpGNL
         sPFvj6JbmhwHVfzA3eDj9eT7NWDi4F2nvyFlLWJvZ7MebMNACswGxSTlTtSoDH3oRYtg
         3PAaOCFesm7gfsx4C47Z8N11ICSaWRgvEmguT05aqsi8Sajet3NUHYKFAZr/XKMso/7n
         o39yxNo1PRx2b3MeyKIDtyHNmTsoSwydwd/vnVqYVwzhTFujKSDLdVytMZFhVZfV+KoB
         z6pX0OE0kPF5suH5jVt2eRrwhnMrrwBpgKn4TXSp/16ecozMkQI9SdpEZ9o0sIkdwRPd
         dNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bB4QODiV4ix6zkRrvYNhY3GV2ClzEd5J+34STuLCzKw=;
        b=zuLgDJpGY4X7oZG8fYBBvf6ZO0gS2tKQCgJQ99pBtDCt1YWpKynGaa5PNcxwGYQr+R
         hycPSPths/k6Xx0RJUAJhjDbd5U/NUaM+4b28xUGOLQFWHZoDnceq8A2zVhZkghydpRr
         T/Rvb76vzD8+3Tk3lnis95E5mX4h+9KmWd9XVAgnTisX0GFJIFresHqmMSNgm0x4iMYv
         MiBDoITiITXHVsdrCBwt//1nsOqTWV4+wv7fGlZlZdKH7v4O8xndjinz5TCiomCgT2Ml
         ik72MVB8eNCsE1EPBW6RgQDXJK2MqgklgFhwuDg6kgnzIj0iiJ5ixihO7aEi5cTtKzq0
         DZ4w==
X-Gm-Message-State: ACrzQf3aDZWCUxE95jcmwBVi4bpaw8SlluFsY+vFOM7DUU61h8hPeb60
        brwJOgU0tkTjVkRdwfnWECWOlw==
X-Google-Smtp-Source: AMsMyM6oHyT1f+Ni6PLeXacAjkpE6naKgTyswsbAsDu1OnUxvpPuNqtcoODYeCbSnrRiT8UBoIhs3Q==
X-Received: by 2002:a05:651c:1a0a:b0:26c:d1e:7b3 with SMTP id by10-20020a05651c1a0a00b0026c0d1e07b3mr6508293ljb.160.1664783159226;
        Mon, 03 Oct 2022 00:45:59 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049d83646ce7sm1350514lfb.110.2022.10.03.00.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 00:45:58 -0700 (PDT)
Message-ID: <7b253e51-30d4-7a71-2b14-7b987c3045fc@linaro.org>
Date:   Mon, 3 Oct 2022 09:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 27/30] RISC-V: Add initial StarFive JH7110 device tree
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930074914.6757-1-hal.feng@linux.starfivetech.com>
 <Yzgb0GzpLsV3RJyk@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yzgb0GzpLsV3RJyk@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 12:52, Conor Dooley wrote:
> On Fri, Sep 30, 2022 at 03:49:14PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>>
>> Add initial device tree for the JH7110 RISC-V SoC by
>> StarFive Technology Ltd.
>>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> 
> There's little point reviewing this dt since there's a load of issues
> that you can trivially find by running dtbs_check/dt_binding_check, but

Yep...

> this SoB change is wrong - if Emil wrote the patch, then Jianlong's SoB
> is either redundant or should be accompanied by a Co-developed-by tag.

Depends. Jianlong might have just rebased the patch.

> 
> Ditto for patch 28/30 "RISC-V: Add StarFive JH7110 VisionFive2 board
> device tree".
> 
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 449 +++++++++++++++++++++++
>>  1 file changed, 449 insertions(+)
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> new file mode 100644
>> index 000000000000..46f418d4198a
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> 
>> +
>> +	osc: osc {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	clk_rtc: clk_rtc {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	gmac0_rmii_refin: gmac0_rmii_refin {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <50000000>;
> 
> I assume, given osc has it's frequency set in the board dts, that these
> are all oscillators on the SoC?
> 
>> +	};
>> +
>> +	gmac0_rgmii_rxin: gmac0_rgmii_rxin {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <125000000>;
>> +	};
>> +
>> +	gmac1_rmii_refin: gmac1_rmii_refin {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <50000000>;
>> +	};
>> +
>> +	gmac1_rgmii_rxin: gmac1_rgmii_rxin {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <125000000>;
>> +	};
>> +
>> +	i2stx_bclk_ext: i2stx_bclk_ext {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <12288000>;
>> +	};
>> +
>> +	i2stx_lrck_ext: i2stx_lrck_ext {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <192000>;
>> +	};
>> +
>> +	i2srx_bclk_ext: i2srx_bclk_ext {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <12288000>;
>> +	};
>> +
>> +	i2srx_lrck_ext: i2srx_lrck_ext {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <192000>;
>> +	};
>> +
>> +	tdm_ext: tdm_ext {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <49152000>;
>> +	};
>> +
>> +	mclk_ext: mclk_ext {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <49152000>;
>> +	};
> 
>> +		syscrg: syscrg@13020000 {
> 
> The generic node name for syscons is just "syscon" afaik.

Yes.

> 
>> +			compatible = "syscon", "simple-mfd";

And this is not allowed. Needs specific compatible.


>> +			reg = <0x0 0x13020000 0x0 0x10000>;
>> +
> 
>> +		aoncrg: aoncrg@17000000 {
> 
> Again, syscon as the node name?

Yes.

> 
>> +			compatible = "syscon", "simple-mfd";

And this is a NAK.

>> +			reg = <0x0 0x17000000 0x0 0x10000>;
>> +
>> +		gpio: gpio@13040000 {
> 
> Someone else (Krzysztof maybe?) should comment, but is "pinctrl" not the
> genric node name for pinctrl nodes?

Yes, for pin controller nodes, this should be "pinctrl" and schema
requires it. The problem was that his driver did not use generic pinctrl
bindings, which is no-go on its own.

This could be a gpio controller (so "gpio" would be fine), although
compatible suggests otherwise.


Best regards,
Krzysztof

