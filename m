Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561B2741FED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjF2Fal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjF2FaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:30:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA683297C;
        Wed, 28 Jun 2023 22:30:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35T5Tuoc040060;
        Thu, 29 Jun 2023 00:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688016596;
        bh=ryLOadtKY1Ezda+Ho7YZF9WQLrMVCh1hKe7UO/PWB5g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QV/S6Ol6RuWqc5kFMwp/gW/08bPkTjjb5ASAJcmTvER6kKtHXdQfhoXyfoi1m0sYk
         dKpwD25L0eUXO/tcFrQE+ob0oaqtN8qcmLAoJIwbCkKq8DcgJ3DrlR7rMjM+Lgv9TK
         sfxYixHP9GoiN2RDaPMB77acyq2P//aTzfKd1yn8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35T5TuTr004043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Jun 2023 00:29:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Jun 2023 00:29:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Jun 2023 00:29:56 -0500
Received: from [10.249.133.19] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35T5TqPq073289;
        Thu, 29 Jun 2023 00:29:53 -0500
Message-ID: <d85fbd74-6470-f664-2eb6-ee02b8135b23@ti.com>
Date:   Thu, 29 Jun 2023 10:59:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2-main: Enable support for
 SDR104 speed mode
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>
References: <20230412121415.860447-1-b-kapoor@ti.com>
 <7fe4adef-9be2-6dae-d53f-692f9775439c@ti.com>
 <20230628105911.rdpqwxuhshgaj2ik@kobold>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20230628105911.rdpqwxuhshgaj2ik@kobold>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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


On 28/06/23 16:29, Nishanth Menon wrote:
> On 13:50-20230628, Kumar, Udit wrote:
>> On 4/12/2023 5:44 PM, Bhavya Kapoor wrote:
>>> According to TRM for J721S2, SDR104 speed mode is supported by the SoC
>>> but its capabilities were masked in device tree. Remove sdhci-caps-mask
>>> to enable support for SDR104 speed mode for SD card in J721S2 SoC.
>>>
>>> [+] Refer to : section 12.3.6.1.1 MMCSD Features, in J721S2 TRM
>>> - https://www.ti.com/lit/zip/spruj28
>>>
>>> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>> ---
>>> Changelog v1->v2:
>>> 	- Modified Commit Message and Added Fixes tag
>>>
>>> Link to v1 : https://lore.kernel.org/all/20230404091245.336732-1-b-kapoor@ti.com/
>>>
>>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> index 8915132efcc1..95c6151ed10c 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> @@ -400,8 +400,6 @@ main_sdhci1: mmc@4fb0000 {
>>>   		ti,clkbuf-sel = <0x7>;
>>>   		ti,trm-icp = <0x8>;
>>>   		dma-coherent;
>>> -		/* Masking support for SDR104 capability */
>>> -		sdhci-caps-mask = <0x00000003 0x00000000>;
>>
>> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> Please confirm if there are any changes in *tap-delay attributes.
There is no changes in tap delay values .
>>>   	};
>>>   	main_navss: bus@30000000 {
> --
> Regards,
> Nishanth Menon
