Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA264E00E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLORyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLORyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:54:47 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93C2A96B;
        Thu, 15 Dec 2022 09:54:45 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BFHsBIh074336;
        Thu, 15 Dec 2022 11:54:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671126851;
        bh=dfl4riunx9/vsckoIqhbcncF2BLRdYLcE2m8tUkN8lM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wCDRsX4gv7j/zhhzpUZUO9M7Ft1Pqlt7O5z9HdWYDyDF5Xtj1fYqjC8tX0PZ7uID+
         AkRadICMYbN35T+4kT0M+fZEYLUWw0FB6RrAwCze0vJEhxhOoyAz3j6u1PuABVdPwy
         dHmcdDrmNVUT7OMbAzgmO95FFBMMzxbTxdtENTSU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BFHsBS2015667
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Dec 2022 11:54:11 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 15
 Dec 2022 11:54:11 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 15 Dec 2022 11:54:11 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BFHsBMg067845;
        Thu, 15 Dec 2022 11:54:11 -0600
Date:   Thu, 15 Dec 2022 11:54:11 -0600
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
Message-ID: <20221215175411.znxy3d6ussq2iq5h@grieving>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
 <Y5tGzjgcAWPqdFNE@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5tGzjgcAWPqdFNE@sirena.org.uk>
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

On 16:09-20221215, Mark Brown wrote:
> On Thu, Dec 15, 2022 at 04:51:40PM +0100, jerome Neanne wrote:
> > On 15/12/2022 16:09, Wadim Egorov wrote:
> 
> > > I am testing your PMIC patches on a AM62 based board with a similar setup and
> > > running into the following error
> 
> > >      VDDSHV5_SDIO: bypassed regulator has no supply!
> > >      VDDSHV5_SDIO: will resolve supply early: ldo1
> > >      VDDSHV5_SDIO: supplied by regulator-dummy
> > >      VDDSHV5_SDIO: failed to get the current voltage: -EINVAL
> 
> > > Have you noticed problems with LDO1 and bypass mode?
> 
> > I did not noticed this on am642 board but IIRC this rail was not used. I
> > heard about similar issue reported to me by Nishanth M with a fix proposal
> > here:
> > https://gist.github.com/nmenon/e4dd6ef6afe31bc9750fa6cbee8d3e25
> 
> That proposal looks really non-idiomatic and quite unusual, if there's a
> fixed voltage supply to the LDO I'd expect to see it modeled as a fixed
> voltage regulator.  I'm not sure what the use of bypass here is trying
> to accomplish TBH.


Correct - My hack was based on a time crunch hack ;)...

The problem is this - the default NVM in the PMIC is setup such that
VSET value =3.3v and bypass bit set (makes sense since the vin=3.3v).

Now the constraint is bypass bit cannot be changed without the LDO
being switched off.

regulator-allow-bypass property allows us to control bypass bit, but we
should'nt toggle it when LDO is active. Not providing the property
implies the bit wont be toggled by regulator core either.

What we need is a scheme that will disable the bypass bit with the
intent of operating the LDO with just the vset field. I did'nt find it
possible atm.. unless I am mistaken..


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
