Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759A16947B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBMOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBMOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:07:33 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716A1A641;
        Mon, 13 Feb 2023 06:07:31 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31DE6x7J041095;
        Mon, 13 Feb 2023 08:06:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676297219;
        bh=8Y0OYbS4fdAewdB9+FGdvfWhIU9qJDnWJuRH7rldSd0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=rsdc/e69SeX/g/KJvpqK/NtEmWdVY9KM6ZF0FOjPUSaa39VG32Ht740UbGX1UCdgQ
         ZQUP7v/BMPdqWCREehECZfTNNh+QAv9aIt3HzsWOcVi5QtHSv6PtV3ucI6bPhDSX6h
         gg5Qau+LBLMFOvIJ/vDiBFOrCvDTCBgoTxg/g15s=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31DE6xv9005112
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Feb 2023 08:06:59 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Feb 2023 08:06:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Feb 2023 08:06:59 -0600
Received: from [10.250.233.148] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31DE6tdU061344;
        Mon, 13 Feb 2023 08:06:56 -0600
Message-ID: <6ca5d863-8382-0b13-97f8-a69c3271e3ac@ti.com>
Date:   Mon, 13 Feb 2023 19:36:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: K3 AM62x SoC dts/dtsi include hierarchy and naming scheme
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>
CC:     Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <francesco.dolcini@toradex.com>
References: <Y+KcJdvgDw9EqFCz@francesco-nb.int.toradex.com>
 <20230209153352.5tgkqe3xbby7pmju@polio>
 <Y+aHh7B73mkAjR7Q@francesco-nb.int.toradex.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <Y+aHh7B73mkAjR7Q@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2023 11:35 PM, Francesco Dolcini wrote:
[...]

>>>
>>
>> Typically, our strategy has been to introduce the superset device,
>> primarily because the device variants are quite a few, and without
>> actual users, it makes no sense to introduce a dtsi in kernel
>> in-anticipation of a potential board. Now that said, also keep in mind
>> the part number definitions do change depending on the market demands
>> over time (qualification requirements etc..), The initial device tree
>> was based on the definition we had at the time, as usual, over time,
>> definitions are changing :(.
> 	
> ... and from my point of view this is normal and fine. All good :-)
> 
>> Considering the potential combinatorial explosion if we are trying
>> to constantly catching up with variations of chip configurations as
>> market definitions change over time, we need to be a bit pragmatic in
>> the various dtsi files we introduce. With that in mind, If we have
>> just one board using the part variant, we should reduce the churn in
>> the tree by keeping the processor variation isolated to the board
>> (See arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi as an
>> example), on the other hand, the AM6251 (Single A53 variant) promises
>> to be a variant that will probably get used in multiple boards, I'd
>> suggest introducing a dtsi that is reused across the boards.
> 
> Our current plan is to have multiple SKUs that will differentiate by the
> specific SoC SKU, not sure if this was clear to you, as an example we
> will have.
> 
> for board in variant1 variant2 variant3
>   k3-am6251-${board}.dts
>   k3-am6252-${board}.dts
>   k3-am6254-${board}.dts
>   k3-am6231-${board}.dts
>   k3-am6232-${board}.dts
>   k3-am6234-${board}.dts
> 
> that are just the same apart the AM62x SKU.
> Do you expect something like that (18 .dts files, in this example) ?
> 
> To me this is absolutely fine, I just want to be sure this is what you
> expect.

I am not sure if we need 18 files, IMO having dts for superset SoC per
board variant for each SoC variant is sufficient:

for board in variant1 variant2 variant3
   k3-am625-${board}.dts (assume k3-am6254-${board}.dts)
   k3-am623-${board}.dts (assume k3-am6234-${board}.dts)

And then fixup num CPUs from U-Boot as per SoC detection as long as
board remains **exactly same** as super set.

This will limit .dts files to 6. Also limits bootloader's role to just
disabling CPU cores instead of fiddling around with too many non
transparent DT fixups.

Nishanth: feel free to chime in if you have different opinion.


> 
> For example we do have these dts boards file here
> 
> arch/arm64/boot/dts/freescale/imx8mm-verdin-*.dts
> 
> and the FDT is patched in U-Boot in
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-imx/imx8m/soc.c#L1245
> 
> with the this approach we have 4 dts files instead of the 16 if we would
> use the exact SOC SKU variant [0].
> 
> Francesco
> 
> [0] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-mini-nano
> 


Regards
Vignesh
