Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7907F663A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjAJHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAJHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:37:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438BB7FA;
        Mon,  9 Jan 2023 23:37:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E67CB810D2;
        Tue, 10 Jan 2023 07:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F676C433EF;
        Tue, 10 Jan 2023 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673336254;
        bh=yyBOKFhrCvYd11DKsv7H9EdXoPHAesnTP8S2RO2fISM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=V63Eu2pOQj2CNEJEp7UxZxAmbxUNKrHlTIeriGOqqdUZbZPdzgD5kz078zJkTycPs
         VMc8vDYmBzyjQVGnzZj4W0Lkzd14+vcOVAMCwIewgcrXG1MDaeF1YZH2wEZGp7RTlB
         wuYYTo/+oSKYpFJM1Jww1QxPboFpc85nU6IjecaT4ifVGWWe/lYyB7wIsXBH1KHjLr
         4I8/5suum23hAIwuZJX83JJd0cvWocvrn1t9rdft9Bo12OudKlcLPG2ldOe7N/NuzV
         qut4qEpX6n46Vxn627A4sy/Y9zA8kxcSiPGFdo7rrBZzWfkHT5ThF1nnvn44Uc019r
         oj68fsnDJ1j/A==
Date:   Tue, 10 Jan 2023 07:37:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     JiaJie Ho <jiajie.ho@starfivetech.com>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v3_3/3=5D_riscv=3A_dts=3A_star?= =?US-ASCII?Q?five=3A_Add_TRNG_node_for_VisionFive_2?=
User-Agent: K-9 Mail for Android
In-Reply-To: <31f6c05b2836450d86560c3efda4abf2@EXMBX168.cuchost.com>
References: <20230109165249.110279-1-jiajie.ho@starfivetech.com> <20230109165249.110279-4-jiajie.ho@starfivetech.com> <Y7xWtFZO/Y7GaYRQ@spud> <31f6c05b2836450d86560c3efda4abf2@EXMBX168.cuchost.com>
Message-ID: <50178BB5-4698-4A52-AD89-7235C3802411@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 January 2023 00:59:58 GMT, JiaJie Ho <jiajie=2Eho@starfivetech=2Ecom=
> wrote:
>
>
>> -----Original Message-----
>> From: Conor Dooley <conor@kernel=2Eorg>
>> Sent: 10 January, 2023 2:02 AM
>> To: JiaJie Ho <jiajie=2Eho@starfivetech=2Ecom>
>> Cc: Olivia Mackall <olivia@selenic=2Ecom>; Herbert Xu
>> <herbert@gondor=2Eapana=2Eorg=2Eau>; Rob Herring <robh+dt@kernel=2Eorg>=
;
>> Krzysztof Kozlowski <krzysztof=2Ekozlowski+dt@linaro=2Eorg>; Emil Renne=
r
>> Berthing <kernel@esmil=2Edk>; Conor Dooley <conor=2Edooley@microchip=2E=
com>;
>> linux-crypto@vger=2Ekernel=2Eorg; devicetree@vger=2Ekernel=2Eorg; linux=
-
>> kernel@vger=2Ekernel=2Eorg; linux-riscv@lists=2Einfradead=2Eorg
>> Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add TRNG node for Vis=
ionFive
>> 2
>>=20
>> Hey folks,
>>=20
>> On Tue, Jan 10, 2023 at 12:52:49AM +0800, Jia Jie Ho wrote:
>> > Adding StarFive TRNG controller node to VisionFive 2 SoC=2E
>> >
>> > Co-developed-by: Jenny Zhang <jenny=2Ezhang@starfivetech=2Ecom>
>> > Signed-off-by: Jenny Zhang <jenny=2Ezhang@starfivetech=2Ecom>
>> > Signed-off-by: Jia Jie Ho <jiajie=2Eho@starfivetech=2Ecom>
>> > ---
>> >  arch/riscv/boot/dts/starfive/jh7110=2Edtsi | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/arch/riscv/boot/dts/starfive/jh7110=2Edtsi
>> > b/arch/riscv/boot/dts/starfive/jh7110=2Edtsi
>> > index 4ac159d79d66=2E=2E3c29e0bc6246 100644
>> > --- a/arch/riscv/boot/dts/starfive/jh7110=2Edtsi
>> > +++ b/arch/riscv/boot/dts/starfive/jh7110=2Edtsi
>> > @@ -455,5 +455,15 @@ uart5: serial@12020000 {
>> >  			reg-shift =3D <2>;
>> >  			status =3D "disabled";
>> >  		};
>> > +
>> > +		rng: rng@1600c000 {
>> > +			compatible =3D "starfive,jh7110-trng";
>> > +			reg =3D <0x0 0x1600C000 0x0 0x4000>;
>> > +			clocks =3D <&stgcrg JH7110_STGCLK_SEC_HCLK>,
>> > +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
>>=20
>> Which clock source is this? I see syscrg and aoncrg in the v3
>> devicetree:
>> https://lore=2Ekernel=2Eorg/linux-riscv/20221220011247=2E35560-7-
>> hal=2Efeng@starfivetech=2Ecom/
>>=20
>> Have a missed a patchset which adds support for this particular clock
>> controller? At the very least, I don't think one has reached the linux-=
riscv
>> mailing list=2E
>> The clock driver patchset only has aoncrg & syscrg:
>> https://lore=2Ekernel=2Eorg/linux-riscv/20221220005054=2E34518-1-
>> hal=2Efeng@starfivetech=2Ecom/
>>=20
>
>Hi Conor,
>
>Thanks for reviewing the patches=2E
>Yes, the patch for stg domain hasn't been submitted yet=2E
>In this case should I drop this patch from the series until the related p=
atches reach the mailing list?

Since it doesn't apply anyway, no harm keeping it IMO=2E
Having the dts can make it easier, although not in this case, to look at t=
he binding and driver=2E
Just mention it in the cover letter if/when you send another version=2E

Thanks,
Conor=2E

