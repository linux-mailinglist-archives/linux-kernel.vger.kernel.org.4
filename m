Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9639731115
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbjFOHnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbjFOHnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:43:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643EC5;
        Thu, 15 Jun 2023 00:43:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F7cFHm125965;
        Thu, 15 Jun 2023 02:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686814695;
        bh=JclRRAhzf9DqHjP9Y/7b/X8I+5HiyhTF7fpvD2bxBdQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Co9DMNu3nFnjH1yxNeFq3kUiZ3gJoGFar4vZ4Sqb9fy3PWlCZ1S6cZRQMRsLFqYlN
         JSay+RFWKhgVoHvpxMdjPJieH4zDB4KISTQETnmL3gq36HpELxoceSi+czNRtPKS9K
         F/eyDNK+N6QueH8qrc5MJD+iOrGsw7dIIwtCldS8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F7cFE7101934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 02:38:15 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 02:38:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 02:38:15 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F7cB2K001995;
        Thu, 15 Jun 2023 02:38:12 -0500
Message-ID: <bf392830-c157-b819-2de3-8db952adf39b@ti.com>
Date:   Thu, 15 Jun 2023 13:08:11 +0530
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
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <ZIq02whTEce8C1P8@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/23 12:21, Francesco Dolcini wrote:
> On Thu, Jun 15, 2023 at 11:38:00AM +0530, Vignesh Raghavendra wrote:
>>
>>
>> On 01/06/23 18:43, Francesco Dolcini wrote:
>>
>> [...]
>>
>>> +/* Verdin I2C_1 */
>>> +&main_i2c1 {
>>> +	status = "okay";
>>> +
>>> +	/* Audio Codec */
>>> +	nau8822_1a: audio-codec@1a {
>>> +		compatible = "nuvoton,nau8822";
>>> +		reg = <0x1a>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_i2s1_mclk>; /* Configure AUDIO_EXT_REFCLK1 pin as output */
>>> +		#sound-dai-cells = <0>;
>>> +
>>> +		/* POSTDIV4_16FF_MAIN_2_HSDIVOUT8_CLK -> AUDIO_EXT_REFCLK1 */
>>> +		assigned-clocks = <&k3_clks 157 10>;
>>> +		assigned-clock-parents = <&k3_clks 157 18>;
>>> +		assigned-clock-rates = <25000000>; /* for 48KHz ± 1.7% */
>>> +	};
>>> +
>>
>> Oops, this node fails dtbs_check
>>
>> make ARCH=arm64 CROSS_COMPILE=$V8_CROSS CHECK_DTBS=y ti/k3-am625-verdin-nonwifi-dev.dtb
>>
>> /work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
>> 	From schema: /home/a0132425/workspace/k3-next/Documentation/devicetree/bindings/sound/nuvoton,nau8822.yaml
>> /work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: 'anyOf' conditional failed, one must be fixed:
>> 	'clocks' is a required property
>> 	'#clock-cells' is a required property
>> 	From schema: /work/.local/lib/python3.10/site-packages/dtschema/schemas/clock/clock.yaml
> 
> This properties are needed here, it will not work without.

Agree on the need. But, I cannot take the patch w/o binding update. We
will end up with messy dts files that would have deviated from bindings.

Could you please post an update to bindings yaml? I suggest to drop
audio codec support and add it back once bindings are updated/fixed.

> 
> Not the expert on audio codec and sound cards DT binding, but to me this is
> just the yaml not being correct.
> 
> Francesco
> 

-- 
Regards
Vignesh
