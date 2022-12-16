Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276D364E745
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLPGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLPGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:22:15 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23612ABF;
        Thu, 15 Dec 2022 22:22:13 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BG6LbIX020947;
        Fri, 16 Dec 2022 00:21:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671171697;
        bh=vq/yRTby3v73HVfc8rzJdeyYdfruLu6aFOu42qYAcvA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=rR4fFn0aBAhMt6u09KuLdh6Dr9IWgE1585BGovUaIqNdEKFtpElUWSMcuegSwOhyR
         LNUh9u8C39BVFn+SMwTgTjMdlklbVdFioX4hMrIOwEG/OMLhslUw9nN5i5WzO38RQp
         FYXarQ4dTekDjuRirTWcEXeyihnv34J9XekuZ+ME=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BG6LbaC024635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Dec 2022 00:21:37 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 16
 Dec 2022 00:21:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 16 Dec 2022 00:21:37 -0600
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BG6LSkO115733;
        Fri, 16 Dec 2022 00:21:29 -0600
Message-ID: <b6ea8cb7-38c4-13cf-a08a-ece973859342@ti.com>
Date:   Fri, 16 Dec 2022 11:51:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>
CC:     jerome Neanne <jneanne@baylibre.com>,
        Wadim Egorov <W.Egorov@phytec.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>, "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
 <Y5tGzjgcAWPqdFNE@sirena.org.uk> <20221215175411.znxy3d6ussq2iq5h@grieving>
 <Y5tl3+2pJispcXy6@sirena.org.uk> <20221215214149.whcjdphxxvvedrih@affront>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221215214149.whcjdphxxvvedrih@affront>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/12/22 03:11, Nishanth Menon wrote:
> On 18:22-20221215, Mark Brown wrote:
>> On Thu, Dec 15, 2022 at 11:54:11AM -0600, Nishanth Menon wrote:
>>> On 16:09-20221215, Mark Brown wrote:
>>
>>>> That proposal looks really non-idiomatic and quite unusual, if there's a
>>>> fixed voltage supply to the LDO I'd expect to see it modeled as a fixed
>>>> voltage regulator.  I'm not sure what the use of bypass here is trying
>>>> to accomplish TBH.
>>
>>> The problem is this - the default NVM in the PMIC is setup such that
>>> VSET value =3.3v and bypass bit set (makes sense since the vin=3.3v).
>>
>> This implies no voltage drop over the LDO?  Sounds a bit suspect.
> 
> Not the choice I'd probably have made ;)
> 
>>
>>> Now the constraint is bypass bit cannot be changed without the LDO
>>> being switched off.
>>

Per https://www.ti.com/lit/ds/symlink/tps65219.pdf (7.3.6 Linear
Regulators).

LDOs have two modes:

1. Load switch mode: in this case, output voltages of 1.5V up to 5.5V
are supported.

2 Linear regulator LDO mode where output voltage is programmable in the
range of 0.6V to 3.4V in 50mV-steps with possibility of bypass.

(CAUTION on page 25):
A mode change between LDO(/bypass) and LSW-mode must only be performed,
when this regulator is disabled!
A change between LDO and bypass-mode (supported by LDO1 and LDO2 only)
is supported during operation.

So, seems like bypass can be toggled even with LDO on?



[...]

Regards
Vignesh
