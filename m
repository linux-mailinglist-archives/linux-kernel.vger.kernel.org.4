Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0618B73148B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbjFOJww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbjFOJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:52:32 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB05A296F;
        Thu, 15 Jun 2023 02:52:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F9pvHM117940;
        Thu, 15 Jun 2023 04:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686822717;
        bh=+PXHiJxF2You09qtn+qZYU2PSNozSvPbpSZGAJseXB8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LIehbQjF8PJUurXhQ/QZZi2iTXAkMafGJ+CQjYlorYOPYop6aQavF9y8MUnRwKKIv
         tAghqQqjM/JaSHmoYiIra9f/Abu9pLXHETxNLL/oVYiml1CC6CCZo7gztsQHOlXJAi
         uxPPq2J6dp789QU1O1gb30nhXTGexI6/2nQukCj4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F9pvfh059297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 04:51:57 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 04:51:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 04:51:56 -0500
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F9prEv081011;
        Thu, 15 Jun 2023 04:51:54 -0500
Message-ID: <46380d90-02ca-fc14-d7c1-d24223e5b262@ti.com>
Date:   Thu, 15 Jun 2023 15:21:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] arm64: dts: ti: add verdin am62
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Nishanth Menon <nm@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-4-francesco@dolcini.it>
 <62ca6112-0aca-788e-fc9b-8a2c3ce9ba1f@ti.com>
 <ZIq02whTEce8C1P8@francesco-nb.int.toradex.com>
 <bf392830-c157-b819-2de3-8db952adf39b@ti.com>
 <ZIrCXA6kp2Z1Je6A@francesco-nb.int.toradex.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <ZIrCXA6kp2Z1Je6A@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/23 13:18, Francesco Dolcini wrote:
> On Thu, Jun 15, 2023 at 01:08:11PM +0530, Vignesh Raghavendra wrote:
>>
>>
>> On 15/06/23 12:21, Francesco Dolcini wrote:
>>> On Thu, Jun 15, 2023 at 11:38:00AM +0530, Vignesh Raghavendra wrote:
>>>>
>>>>
>>>> On 01/06/23 18:43, Francesco Dolcini wrote:
>>>>
>>>> [...]
>>>>
>>>>> +/* Verdin I2C_1 */
>>>>> +&main_i2c1 {
>>>>> +	status = "okay";
>>>>> +
>>>>> +	/* Audio Codec */
>>>>> +	nau8822_1a: audio-codec@1a {
>>>>> +		compatible = "nuvoton,nau8822";
>>>>> +		reg = <0x1a>;
>>>>> +		pinctrl-names = "default";
>>>>> +		pinctrl-0 = <&pinctrl_i2s1_mclk>; /* Configure AUDIO_EXT_REFCLK1 pin as output */
>>>>> +		#sound-dai-cells = <0>;
>>>>> +
>>>>> +		/* POSTDIV4_16FF_MAIN_2_HSDIVOUT8_CLK -> AUDIO_EXT_REFCLK1 */
>>>>> +		assigned-clocks = <&k3_clks 157 10>;
>>>>> +		assigned-clock-parents = <&k3_clks 157 18>;
>>>>> +		assigned-clock-rates = <25000000>; /* for 48KHz ± 1.7% */
>>>>> +	};
>>>>> +
>>>>
>>>> Oops, this node fails dtbs_check
>>>>
>>>> make ARCH=arm64 CROSS_COMPILE=$V8_CROSS CHECK_DTBS=y ti/k3-am625-verdin-nonwifi-dev.dtb
>>>>
>>>> /work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
>>>> 	From schema: /home/a0132425/workspace/k3-next/Documentation/devicetree/bindings/sound/nuvoton,nau8822.yaml
>>>> /work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: 'anyOf' conditional failed, one must be fixed:
>>>> 	'clocks' is a required property
>>>> 	'#clock-cells' is a required property
>>>> 	From schema: /work/.local/lib/python3.10/site-packages/dtschema/schemas/clock/clock.yaml
>>>
>>> This properties are needed here, it will not work without.
>>
>> Agree on the need. But, I cannot take the patch w/o binding update. We
>> will end up with messy dts files that would have deviated from bindings.
> 
> Fine, however, one question, is this a new policy? Or a specific TI
> branch policy? 

No, this isn't TI specific. In general if YAML binding exists, then the
DT nodes need to confirm to that schema.

> From what I can tell so far there was nothing mandatory
> while the DT binding conversion from txt to yaml is in progress. 
> 

I understand if the bindings are still in .txt format. But, in this
case, bindings are converted to YAML and prohibit other properties
unfortunately.

>> Could you please post an update to bindings yaml? I suggest to drop
>> audio codec support and add it back once bindings are updated/fixed.
> I will proceed like that, thanks. I would be happy to see the
> verdin-am62 added in the next merge window.
> 

Great, thanks!

> Thanks for the review,
> Francesco

-- 
Regards
Vignesh
