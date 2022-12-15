Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BF64E364
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLOVmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLOVmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:42:39 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BACA5C76B;
        Thu, 15 Dec 2022 13:42:34 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BFLfnha052913;
        Thu, 15 Dec 2022 15:41:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671140509;
        bh=WLpVP2bWfliAogzAGVvfrb8O9z6xT+DatR+7Ps4pVB8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YkRW9VrIYluAbll9dwl1NaXdtykQ7/RwaMYW9TfyfocH17R2Oxf/oe4ljablDsk/y
         9UlFYgkNzoEhKp8WSsbOz8FJ3YrvKGoM5/qTXEXUa2IhZHLu0AmWmRzwG5U8ew57Kf
         2R+TII0CdC9MeRqbpfF+76gxynynnU7qQj+W4C4M=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BFLfncA110061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Dec 2022 15:41:49 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 15
 Dec 2022 15:41:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 15 Dec 2022 15:41:49 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BFLfnGb072680;
        Thu, 15 Dec 2022 15:41:49 -0600
Date:   Thu, 15 Dec 2022 15:41:49 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Mark Brown <broonie@kernel.org>
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
        "vigneshr@ti.com" <vigneshr@ti.com>,
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
Subject: Re: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Message-ID: <20221215214149.whcjdphxxvvedrih@affront>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
 <Y5tGzjgcAWPqdFNE@sirena.org.uk>
 <20221215175411.znxy3d6ussq2iq5h@grieving>
 <Y5tl3+2pJispcXy6@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5tl3+2pJispcXy6@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:22-20221215, Mark Brown wrote:
> On Thu, Dec 15, 2022 at 11:54:11AM -0600, Nishanth Menon wrote:
> > On 16:09-20221215, Mark Brown wrote:
> 
> > > That proposal looks really non-idiomatic and quite unusual, if there's a
> > > fixed voltage supply to the LDO I'd expect to see it modeled as a fixed
> > > voltage regulator.  I'm not sure what the use of bypass here is trying
> > > to accomplish TBH.
> 
> > The problem is this - the default NVM in the PMIC is setup such that
> > VSET value =3.3v and bypass bit set (makes sense since the vin=3.3v).
> 
> This implies no voltage drop over the LDO?  Sounds a bit suspect.

Not the choice I'd probably have made ;)

> 
> > Now the constraint is bypass bit cannot be changed without the LDO
> > being switched off.
> 
> > regulator-allow-bypass property allows us to control bypass bit, but we
> > should'nt toggle it when LDO is active. Not providing the property
> > implies the bit wont be toggled by regulator core either.
> 
> > What we need is a scheme that will disable the bypass bit with the
> > intent of operating the LDO with just the vset field. I did'nt find it
> > possible atm.. unless I am mistaken..
> 
> Can the consumer just disable the supply as part of startup?  Though
> that's starting to feel rather board specific.  There's not really a

Yeah - this happens to be SDcard supply (at least in my case).. I'd
rather not change the mmc host or core layer to handle a case where
LDO happened to be in bypass. it is a regulator driver's problem, IMHO
how to provide the stated voltage OR fail to transition the voltage.

In this driver's case, it happily accepts and set the VSET voltage - for
example to 1.8V, but then, since the bypass bit is set, well, voltage
sticks around at 3.3v.

> good place to put a board specific setup process like that in the kernel
> at the minute, you'd ideally want the firmware to leave the device at
> least disabled if not actually out of bypass on startup so we don't have
> to deal with this.  Ugh...

Yeah - that would be the other option - I could plug this bypass clear
in the u-boot or someplace early so that the LDO behaves

Also the reason why I did'nt send the mentioned patch (or the like
upstream and the patch was done just a couple of days back) were the following
questions:
a) Why would'nt we handle the case where bypass bit
   is set AND voltage change implies bypass bit needs to be disabled? (i
   would expect it to fail but if i did provide regulator-allow-bypass,
   then if bypass is set AND requested-voltage != vin-supply, then i'd
   have expected framework to probably disable bypass and switch voltage
   to new voltage - which this driver, based on it's constraint will say
   "nope, cant do" - but that would be better than silently telling me
   all good, setting vset and leaving the bypass bit on.)
b) If I wanted the LDO to poweroff the bypass bit at start (define the
   startup hardware condition), I dont seem to have a description for
   that either.



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
