Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66F5643D25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiLFGdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFGdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:33:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9357665;
        Mon,  5 Dec 2022 22:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CF66157D;
        Tue,  6 Dec 2022 06:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EB0C433D6;
        Tue,  6 Dec 2022 06:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670308396;
        bh=EDB501nrhkqSiyDdVoSm8DT/Z0wlMc5J7EKvKmO5Ap0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=j8t/3vQg3aak8yu64eOB42ZeADSUk4T6L5Rj5cTlwzp59/Tp/tRrySYfBHaA/hcvc
         ciRG3yCuLTqoRfQRRhCwjB2LcQt1B+jFWRC7EnRotqSNW0m928DMnTNO9zarktepEN
         holI3b+sJd5SBscz08+lQgq6XBYtV5icWpWv15YUHPc7ymyl0ZRQ5NynHGxI+yz4kL
         OVthxMnm1Dzoora5ru14VsxRwjyEDniwK+ntexaoHqef7R9lNS99UkvwC2lODlyxiu
         7s6Ew9T5wZiojtyf8rMJXAxbrEghJLOJ2Itob4DoehppodBp0MiYv9xvbHOSHBatjW
         rdqU8M32Kp3TA==
Date:   Tue, 06 Dec 2022 06:33:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_dt-bindings=3A_timer=3A_si?= =?US-ASCII?Q?five=2Cclint=3A_add_compatible_for_OpenC906?=
User-Agent: K-9 Mail for Android
In-Reply-To: <86d822f73f6e61c9f286e800db50e9959aef05a0.camel@icenowy.me>
References: <20221121041757.418645-3-uwu@icenowy.me> <98005150-83a7-5439-0db1-d93d459c3809@linaro.org> <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me> <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org> <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me> <20221130181330.GA2544489-robh@kernel.org> <Y4j+Gpptk3NAFBNV@spud> <4ad56fa249a30167844abcedac53d198606511d8.camel@icenowy.me> <Y43Jt3YOSbFyh954@wendy> <75a3ef9a175b16c46b57b2829ecbe4f97737de8a.camel@icenowy.me> <Y44IoC765yztZ6VF@wendy> <879345cd8609cddccbf7bcf230923139af320b17.camel@icenowy.me> <B1B2FC9D-D971-435B-A9FD-B092DE726367@kernel.org> <86d822f73f6e61c9f286e800db50e9959aef05a0.camel@icenowy.me>
Message-ID: <04BFA351-92E6-442F-B065-9C287C174A0E@kernel.org>
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



On 6 December 2022 03:46:11 GMT, Icenowy Zheng <uwu@icenowy=2Eme> wrote:
>=E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 16:54 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>=20
>> On 5 December 2022 15:59:44 GMT, Icenowy Zheng <uwu@icenowy=2Eme>
>> wrote:
>> > =E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 15:05 +0000=
=EF=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
>> > > On Mon, Dec 05, 2022 at 07:03:17PM +0800, Icenowy Zheng wrote:
>> > > > =E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:36 +0=
000=EF=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
>> > >=20
>> > > > > You lot all know the situation here a lot more than I do=2E=2E=
=2E
>> > > > > I don't think "letting" people use the bare "thead,c900-foo"
>> > > > > makes
>> > > > > much
>> > > > > sense as it gives us no chance to deal with quirks down the
>> > > > > line=2E
>> > > >=20
>> > > > Well, after rechecking the manual, I found it possible to
>> > > > handle
>> > > > quirks
>> > > > -- T-Head has a custom "mcpuid" CSR (@ RISC-V CSR 0xFC0), which
>> > > > can
>> > > > be
>> > > > used to retrieve some identification info of the core,
>> > > > including
>> > > > its
>> > > > model ID, version, etc; and the T-Head PLIC/CLINT are part of
>> > > > their
>> > > > C906 SoC design that there's another "mapbaddr" CSR that could
>> > > > be
>> > > > used
>> > > > to retrieve the base address of them=2E
>> > > >=20
>> > > > So I think it okay to just use "thead,c900-clint" here, and
>> > > > when
>> > > > necessary, try to retrieve mcpuid for dealing with quirks=2E
>> > >=20
>> > > I'm not super sure I follow=2E What's the relevance of "mapbaddr"
>> > > here?
>> > > We've got a reg property, so I don't think we need "mapbaddr"?
>> >=20
>> > Yes, it's not relevant to us here, it's only to prove that
>> > PLIC/CLINT
>> > is part of C906 "Core Complex"=2E
>> >=20
>> > >=20
>> > > For "mcpuid", can you be sure that implementers will not omit
>> > > setting
>> > > that value to something unique? I'd be happier if we were overly
>> > > clear
>> > > now rather than have some headaches later=2E Have I missed
>> > > something?
>> >=20
>> > These values are set by T-Head instead of individual SoC
>> > implementers
>> > as a CPU CSR, and it's not for uniqueness, but it's for
>> > identification
>> > of the CPU core revision (thus the PLIC/CLINT that come with it)=2E
>>=20
>> I really am missing something here that must be obvious to you=2E
>> Let me try and explain where my gap in understanding is=2E
>> If someone takes the open cores & makes a minor tweak in the plic how
>> does knowing mcpuid help us identify that that plic is marginally
>> different?
>
>No, but my point is that in this situation we shouldn't use C900
>compatible at all because it's no longer the vanilla C900 cores=2E
>
>My assumption is that the same IP cores are the same unless specially
>customized=2E

Ah see that is assuming people get it right=2E
I've been in the mindset of "what if the difference is only noticed after =
the DT has been shipped"=2E
I guess that's where we've been at odds=2E

>
>>=20
>> I must have missed something that should be apparent and look like an
>> eejit right now!
>>=20
>> >=20
>> > >=20
>> > > > > I don't think that using "thead,openc906-clint", "thead,c900-
>> > > > > clint"
>> > > > > makes all that much sense either, in case someone does
>> > > > > something
>> > > > > wacky
>> > > > > with the open-source version of the core=2E
>> > > > >=20
>> > > > > That leaves us with either:
>> > > > > "vendor,soc-clint", "thead,openc906-clint", "thead,c900-
>> > > > > clint"
>> > > > > or:
>> > > > > "vendor,soc-clint", "thead,c900-clint"
>> > > > > right?
>> > > > >=20
>> > > > > The first one seems like possibly the better option as you'd
>> > > > > kinda
>> > > > > expect that, in a perfect word, all of the open-source IP
>> > > > > implementations would share quirks etc?
>> > >=20
>> >=20
>
