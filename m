Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68BE6532B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiLUOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLUOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:51:06 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A5617B;
        Wed, 21 Dec 2022 06:51:05 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BLEooZS050205;
        Wed, 21 Dec 2022 08:50:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671634250;
        bh=Bv5widqpyas4qVvAZ5Qis86pK9FKLXes1YkCFHKQuwM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Bv4PNO7OMqoCfcmfZ+zQ9XIwRP0P+2Fb3l+JoE5YrNQP9jH0jKFuQgne+U7eNpiMV
         xYaJYuAtfkhZYlBQWaznSe/x6N3CpdH2OfTCTMqgYA/LU9xwJ+EQE6uusDBX6FIoTN
         1Yq3vjQIi0ZAtP0R1Tu/PQNgMBU/h2IbpaSSZQBY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BLEoooe053530
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Dec 2022 08:50:50 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 21
 Dec 2022 08:50:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 21 Dec 2022 08:50:49 -0600
Received: from [10.250.235.211] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BLEoj3g070098;
        Wed, 21 Dec 2022 08:50:46 -0600
Message-ID: <8411f1c0-29e4-cba3-6cce-8b343d40d8aa@ti.com>
Date:   Wed, 21 Dec 2022 20:20:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62-main: Update OTAP and ITAP
 delay select
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
CC:     <martyn.welch@collabora.com>, Nitin Yadav <n-yadav@ti.com>,
        "Aswath Govindraju" <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Tero Kristo" <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221216143624.23708-1-sjoerd@collabora.com>
 <20221216143624.23708-2-sjoerd@collabora.com>
 <b22b6349-9cec-2e86-294a-249f24de2345@ti.com>
 <a85e08c6af0fbdafaa6f3799264e92bba7607b9c.camel@collabora.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <a85e08c6af0fbdafaa6f3799264e92bba7607b9c.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/2022 6:37 PM, Sjoerd Simons wrote:
> Hey Vignesh
> 
> On Tue, 2022-12-20 at 16:49 +0530, Vignesh Raghavendra wrote:
>>
>>
>> On 16/12/22 8:06 pm, Sjoerd Simons wrote:
>>> From: Nitin Yadav <n-yadav@ti.com>
>>>
>>> UHS Class U1 sd-card are not getting detected due to incorrect
>>> OTAP/ITAP delay select values in linux. Update OTAP and ITAP
>>> delay select values for various speed modes. For sdhci0, update
>>> OTAP delay values for ddr52 & HS200 and add ITAP delay for legacy
>>> & mmc-hs. For sdhci1 & sdhci2, update OTAP & ITAP delay select
>>> recommended as in RIOT for various speed modes.
>>>
>>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>>> [cherry-pick from vendor BSP]
>>> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>>> ---
>>>
>>>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 46 ++++++++++++--------
>>> ----
>>>  1 file changed, 24 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>>> index 03660476364f..28c250a8d1ec 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>>> @@ -391,8 +391,10 @@ sdhci0: mmc@fa10000 {
>>>                 ti,clkbuf-sel = <0x7>;
>>>                 ti,otap-del-sel-legacy = <0x0>;
>>>                 ti,otap-del-sel-mmc-hs = <0x0>;
>>> -               ti,otap-del-sel-ddr52 = <0x9>;
>>> -               ti,otap-del-sel-hs200 = <0x6>;
>>> +               ti,otap-del-sel-ddr52 = <0x5>;
>>> +               ti,otap-del-sel-hs200 = <0x5>;
>>> +               ti,itap-del-sel-legacy = <0xa>;
>>
>> This is pretty useless without corresponding driver changes 
>> to pick up ti,itap-del-sel-legacy as well
> 
> Right; itap-del-sel-legacy is properly documented in the device-tree
> binding and was already previously set ofcourse so i didn't pick up it
> needed more driver changes. That said the dtb change itself should
> still be valid even if not actually applied.
> 
>> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/mmc/host/sdhci_am654.c?h=ti-linux-5.10.y&id=93d22fc56007ee13e589debf0d32c8b1d5fdc6d8
>> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/mmc/host/sdhci_am654.c?h=ti-linux-5.10.y&id=9c878c3dc642f7f1f3ab6ca7f812cd43fe7ed7d8
>>
>> Could you list that cards affected and fixed by this change?
> 
> It's a Collabora branded UHS class 1 (SDR104) card; Matching the commit
> message indication given by Nitin. So that in particular i guess, will
> have been fixed by the change to the ti,otap-del-sel-sdr104 value for
> sdhci1.
> 
> For the two patches you highlighted above; Is TI planning to upstream
> those as well? 
>

Yes, the plan is to post those patches to mmc list post 6.2-rc1

Regards
Vignesh
