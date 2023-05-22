Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9A70CDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjEVW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjEVW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979E110;
        Mon, 22 May 2023 15:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8FC562C53;
        Mon, 22 May 2023 22:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCDCC433D2;
        Mon, 22 May 2023 22:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684794458;
        bh=jUlZ1O2Cbsh9SfN/Yy703X/c15uKYJ0gTtetpIgZ2S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiNLVKc17r/cJ4HWwHuvyIz8vM3BIDWsStXKy3YJ72j6CnPPVjujExI2+gDkgxJKc
         Tztnm2SF/vHe4ofGmtcSA8WAJ3iNrC1CVtsr/8wmv2oRkKrcldUU5JFwZ0UOEV5M/b
         BOx6j31aV0L0vX5GCLf2tjtNWNWeKSw+cTethqtmilyJnqye/dNqNMpPNYX6igQqYx
         Ivwtya1CrxIDBSs8awDppMytm6Ef3Vs6lZGxbTbh46I1cBC6PIJAKs/g+992F1FKdi
         H0xie8ukBsHwy/uUt4HXd4Qj41UA/tFYAyBmwwhSrhQgnaIeH/RoXD4PwKl/laChsg
         dN3Ep20H9UYUA==
Date:   Mon, 22 May 2023 23:27:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [patch V4 33/37] cpu/hotplug: Allow "parallel" bringup up to
 CPUHP_BP_KICK_AP_STATE
Message-ID: <2ed3ff77-c973-4e23-9e2f-f10776e432b7@sirena.org.uk>
References: <20230512203426.452963764@linutronix.de>
 <20230512205257.240231377@linutronix.de>
 <4ca39e58-055f-432c-8124-7c747fa4e85b@sirena.org.uk>
 <87bkicw01a.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnLTz5q6oum7yiEn"
Content-Disposition: inline
In-Reply-To: <87bkicw01a.ffs@tglx>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lnLTz5q6oum7yiEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 11:04:17PM +0200, Thomas Gleixner wrote:

> That does not make any sense at all and my tired brain does not help
> either.

> Can you please apply the below debug patch and provide the output?

Here's the log, a quick glance says the=20

	if (!--ncpus)
		break;

check is doing the wrong thing when CONFIG_NR_CPUS=3D256 as it is for
arm64 defconfig and the system actually has 256 CPUs, the Odroid looks
like the same issue as the Exynos defconfig that fails there has
NR_CPUs=3D8 which is what the board has.

[    0.048542] smp: Bringing up secondary CPUs ...
[    0.048545] Bringup max 256 CPUs to 235
[    0.048547] Bringup CPU0 left 256
[    0.048575] Bringup CPU0 0
[    0.048577] Bringup CPU1 left 255
[    0.124561] Detected PIPT I-cache on CPU1
[    0.124586] GICv3: CPU1: found redistributor 100 region 0:0x000000040108=
0000
[    0.124595] GICv3: CPU1: using allocated LPI pending table @0x0000000880=
910000
[    0.124654] CPU1: Booted secondary processor 0x0000000100 [0x431f0af1]
[    0.124759] Bringup CPU1 0
[    0.124763] Bringup CPU2 left 254
[    0.195421] Detected PIPT I-cache on CPU2
[    0.195445] GICv3: CPU2: found redistributor 200 region 0:0x000000040110=
0000
[    0.195453] GICv3: CPU2: using allocated LPI pending table @0x0000000880=
920000
[    0.195510] CPU2: Booted secondary processor 0x0000000200 [0x431f0af1]
[    0.195611] Bringup CPU2 0
[    0.195615] Bringup CPU3 left 253
[    0.273859] Detected PIPT I-cache on CPU3
[    0.273885] GICv3: CPU3: found redistributor 300 region 0:0x000000040118=
0000
[    0.273893] GICv3: CPU3: using allocated LPI pending table @0x0000000880=
930000
[    0.273949] CPU3: Booted secondary processor 0x0000000300 [0x431f0af1]
[    0.274050] Bringup CPU3 0
[    0.274053] Bringup CPU4 left 252
[    0.351345] Detected PIPT I-cache on CPU4
[    0.351374] GICv3: CPU4: found redistributor 400 region 0:0x000000040120=
0000
[    0.351382] GICv3: CPU4: using allocated LPI pending table @0x0000000880=
940000
[    0.351438] CPU4: Booted secondary processor 0x0000000400 [0x431f0af1]
[    0.351540] Bringup CPU4 0
[    0.351543] Bringup CPU5 left 251
[    0.431068] Detected PIPT I-cache on CPU5
[    0.431099] GICv3: CPU5: found redistributor 500 region 0:0x000000040128=
0000
[    0.431107] GICv3: CPU5: using allocated LPI pending table @0x0000000880=
950000
[    0.431162] CPU5: Booted secondary processor 0x0000000500 [0x431f0af1]
[    0.431264] Bringup CPU5 0
[    0.431267] Bringup CPU6 left 250
[    0.503403] Detected PIPT I-cache on CPU6
[    0.503435] GICv3: CPU6: found redistributor 600 region 0:0x000000040130=
0000
[    0.503443] GICv3: CPU6: using allocated LPI pending table @0x0000000880=
960000
[    0.503498] CPU6: Booted secondary processor 0x0000000600 [0x431f0af1]
[    0.503600] Bringup CPU6 0
[    0.503604] Bringup CPU7 left 249
[    0.580128] Detected PIPT I-cache on CPU7
[    0.580162] GICv3: CPU7: found redistributor 700 region 0:0x000000040138=
0000
[    0.580171] GICv3: CPU7: using allocated LPI pending table @0x0000000880=
970000
[    0.580226] CPU7: Booted secondary processor 0x0000000700 [0x431f0af1]
[    0.580328] Bringup CPU7 0
[    0.580332] Bringup CPU8 left 248
[    0.660158] Detected PIPT I-cache on CPU8
[    0.660194] GICv3: CPU8: found redistributor 800 region 0:0x000000040140=
0000
[    0.660203] GICv3: CPU8: using allocated LPI pending table @0x0000000880=
980000
[    0.660258] CPU8: Booted secondary processor 0x0000000800 [0x431f0af1]
[    0.660359] Bringup CPU8 0
[    0.660363] Bringup CPU9 left 247
[    0.741063] Detected PIPT I-cache on CPU9
[    0.741102] GICv3: CPU9: found redistributor 900 region 0:0x000000040148=
0000
[    0.741110] GICv3: CPU9: using allocated LPI pending table @0x0000000880=
990000
[    0.741166] CPU9: Booted secondary processor 0x0000000900 [0x431f0af1]
[    0.741268] Bringup CPU9 0
[    0.741272] Bringup CPU10 left 246
[    0.817643] Detected PIPT I-cache on CPU10
[    0.817684] GICv3: CPU10: found redistributor a00 region 0:0x00000004015=
00000
[    0.817692] GICv3: CPU10: using allocated LPI pending table @0x000000088=
09a0000
[    0.817747] CPU10: Booted secondary processor 0x0000000a00 [0x431f0af1]
[    0.817850] Bringup CPU10 0
[    0.817854] Bringup CPU11 left 245
[    0.896094] Detected PIPT I-cache on CPU11
[    0.896137] GICv3: CPU11: found redistributor b00 region 0:0x00000004015=
80000
[    0.896145] GICv3: CPU11: using allocated LPI pending table @0x000000088=
09b0000
[    0.896202] CPU11: Booted secondary processor 0x0000000b00 [0x431f0af1]
[    0.896304] Bringup CPU11 0
[    0.896308] Bringup CPU12 left 244
[    0.976966] Detected PIPT I-cache on CPU12
[    0.977010] GICv3: CPU12: found redistributor c00 region 0:0x00000004016=
00000
[    0.977018] GICv3: CPU12: using allocated LPI pending table @0x000000088=
09c0000
[    0.977074] CPU12: Booted secondary processor 0x0000000c00 [0x431f0af1]
[    0.977179] Bringup CPU12 0
[    0.977183] Bringup CPU13 left 243
[    1.053939] Detected PIPT I-cache on CPU13
[    1.053985] GICv3: CPU13: found redistributor d00 region 0:0x00000004016=
80000
[    1.053994] GICv3: CPU13: using allocated LPI pending table @0x000000088=
09d0000
[    1.054050] CPU13: Booted secondary processor 0x0000000d00 [0x431f0af1]
[    1.054169] Bringup CPU13 0
[    1.054172] Bringup CPU14 left 242
[    1.133133] Detected PIPT I-cache on CPU14
[    1.133182] GICv3: CPU14: found redistributor e00 region 0:0x00000004017=
00000
[    1.133190] GICv3: CPU14: using allocated LPI pending table @0x000000088=
09e0000
[    1.133248] CPU14: Booted secondary processor 0x0000000e00 [0x431f0af1]
[    1.133352] Bringup CPU14 0
[    1.133356] Bringup CPU15 left 241
[    1.214963] Detected PIPT I-cache on CPU15
[    1.215013] GICv3: CPU15: found redistributor f00 region 0:0x00000004017=
80000
[    1.215022] GICv3: CPU15: using allocated LPI pending table @0x000000088=
09f0000
[    1.215078] CPU15: Booted secondary processor 0x0000000f00 [0x431f0af1]
[    1.215179] Bringup CPU15 0
[    1.215183] Bringup CPU16 left 240
[    1.292692] Detected PIPT I-cache on CPU16
[    1.292746] GICv3: CPU16: found redistributor 1000 region 0:0x0000000401=
800000
[    1.292755] GICv3: CPU16: using allocated LPI pending table @0x000000088=
0a00000
[    1.292810] CPU16: Booted secondary processor 0x0000001000 [0x431f0af1]
[    1.292914] Bringup CPU16 0
[    1.292918] Bringup CPU17 left 239
[    1.371926] Detected PIPT I-cache on CPU17
[    1.371982] GICv3: CPU17: found redistributor 1100 region 0:0x0000000401=
880000
[    1.371991] GICv3: CPU17: using allocated LPI pending table @0x000000088=
0a10000
[    1.372047] CPU17: Booted secondary processor 0x0000001100 [0x431f0af1]
[    1.372153] Bringup CPU17 0
[    1.372156] Bringup CPU18 left 238
[    1.454059] Detected PIPT I-cache on CPU18
[    1.454117] GICv3: CPU18: found redistributor 1200 region 0:0x0000000401=
900000
[    1.454126] GICv3: CPU18: using allocated LPI pending table @0x000000088=
0a20000
[    1.454182] CPU18: Booted secondary processor 0x0000001200 [0x431f0af1]
[    1.454287] Bringup CPU18 0
[    1.454290] Bringup CPU19 left 237
[    1.530831] Detected PIPT I-cache on CPU19
[    1.530891] GICv3: CPU19: found redistributor 1300 region 0:0x0000000401=
980000
[    1.530900] GICv3: CPU19: using allocated LPI pending table @0x000000088=
0a30000
[    1.530956] CPU19: Booted secondary processor 0x0000001300 [0x431f0af1]
[    1.531061] Bringup CPU19 0
[    1.531065] Bringup CPU20 left 236
[    1.609799] Detected PIPT I-cache on CPU20
[    1.609860] GICv3: CPU20: found redistributor 1400 region 0:0x0000000401=
a00000
[    1.609869] GICv3: CPU20: using allocated LPI pending table @0x000000088=
0a40000
[    1.609927] CPU20: Booted secondary processor 0x0000001400 [0x431f0af1]
[    1.610032] Bringup CPU20 0
[    1.610036] Bringup CPU21 left 235
[    1.692060] Detected PIPT I-cache on CPU21
[    1.692123] GICv3: CPU21: found redistributor 1500 region 0:0x0000000401=
a80000
[    1.692132] GICv3: CPU21: using allocated LPI pending table @0x000000088=
0a50000
[    1.692188] CPU21: Booted secondary processor 0x0000001500 [0x431f0af1]
[    1.692296] Bringup CPU21 0
[    1.692299] Bringup CPU22 left 234
[    1.768877] Detected PIPT I-cache on CPU22
[    1.768942] GICv3: CPU22: found redistributor 1600 region 0:0x0000000401=
b00000
[    1.768951] GICv3: CPU22: using allocated LPI pending table @0x000000088=
0a60000
[    1.769008] CPU22: Booted secondary processor 0x0000001600 [0x431f0af1]
[    1.769115] Bringup CPU22 0
[    1.769119] Bringup CPU23 left 233
[    1.847956] Detected PIPT I-cache on CPU23
[    1.848023] GICv3: CPU23: found redistributor 1700 region 0:0x0000000401=
b80000
[    1.848032] GICv3: CPU23: using allocated LPI pending table @0x000000088=
0a70000
[    1.848088] CPU23: Booted secondary processor 0x0000001700 [0x431f0af1]
[    1.848196] Bringup CPU23 0
[    1.848199] Bringup CPU24 left 232
[    1.920945] Detected PIPT I-cache on CPU24
[    1.921015] GICv3: CPU24: found redistributor 1800 region 0:0x0000000401=
c00000
[    1.921024] GICv3: CPU24: using allocated LPI pending table @0x000000088=
0a80000
[    1.921081] CPU24: Booted secondary processor 0x0000001800 [0x431f0af1]
[    1.921187] Bringup CPU24 0
[    1.921190] Bringup CPU25 left 231
[    1.997836] Detected PIPT I-cache on CPU25
[    1.997908] GICv3: CPU25: found redistributor 1900 region 0:0x0000000401=
c80000
[    1.997917] GICv3: CPU25: using allocated LPI pending table @0x000000088=
0a90000
[    1.997973] CPU25: Booted secondary processor 0x0000001900 [0x431f0af1]
[    1.998080] Bringup CPU25 0
[    1.998084] Bringup CPU26 left 230
[    2.071111] Detected PIPT I-cache on CPU26
[    2.071185] GICv3: CPU26: found redistributor 1a00 region 0:0x0000000401=
d00000
[    2.071194] GICv3: CPU26: using allocated LPI pending table @0x000000088=
0aa0000
[    2.071250] CPU26: Booted secondary processor 0x0000001a00 [0x431f0af1]
[    2.071358] Bringup CPU26 0
[    2.071362] Bringup CPU27 left 229
[    2.147890] Detected PIPT I-cache on CPU27
[    2.147966] GICv3: CPU27: found redistributor 1b00 region 0:0x0000000401=
d80000
[    2.147975] GICv3: CPU27: using allocated LPI pending table @0x000000088=
0ab0000
[    2.148032] CPU27: Booted secondary processor 0x0000001b00 [0x431f0af1]
[    2.148138] Bringup CPU27 0
[    2.148142] Bringup CPU28 left 228
[    2.230081] Detected PIPT I-cache on CPU28
[    2.230159] GICv3: CPU28: found redistributor 1c00 region 0:0x0000000401=
e00000
[    2.230168] GICv3: CPU28: using allocated LPI pending table @0x000000088=
0ac0000
[    2.230224] CPU28: Booted secondary processor 0x0000001c00 [0x431f0af1]
[    2.230343] Bringup CPU28 0
[    2.230347] Bringup CPU29 left 227
[    2.311933] Detected PIPT I-cache on CPU29
[    2.312012] GICv3: CPU29: found redistributor 1d00 region 0:0x0000000401=
e80000
[    2.312021] GICv3: CPU29: using allocated LPI pending table @0x000000088=
0ad0000
[    2.312077] CPU29: Booted secondary processor 0x0000001d00 [0x431f0af1]
[    2.312183] Bringup CPU29 0
[    2.312187] Bringup CPU30 left 226
[    2.392181] Detected PIPT I-cache on CPU30
[    2.392263] GICv3: CPU30: found redistributor 1e00 region 0:0x0000000401=
f00000
[    2.392272] GICv3: CPU30: using allocated LPI pending table @0x000000088=
0ae0000
[    2.392328] CPU30: Booted secondary processor 0x0000001e00 [0x431f0af1]
[    2.392435] Bringup CPU30 0
[    2.392439] Bringup CPU31 left 225
[    2.466927] Detected PIPT I-cache on CPU31
[    2.467010] GICv3: CPU31: found redistributor 1f00 region 0:0x0000000401=
f80000
[    2.467020] GICv3: CPU31: using allocated LPI pending table @0x000000088=
0af0000
[    2.467076] CPU31: Booted secondary processor 0x0000001f00 [0x431f0af1]
[    2.467184] Bringup CPU31 0
[    2.467188] Bringup CPU32 left 224
[    2.535705] Detected PIPT I-cache on CPU32
[    2.535734] GICv3: CPU32: found redistributor 1 region 0:0x0000000401020=
000
[    2.535743] GICv3: CPU32: using allocated LPI pending table @0x000000088=
0b00000
[    2.535798] CPU32: Booted secondary processor 0x0000000001 [0x431f0af1]
[    2.535910] Bringup CPU32 0
[    2.535914] Bringup CPU33 left 223
[    2.604057] Detected PIPT I-cache on CPU33
[    2.604084] GICv3: CPU33: found redistributor 101 region 0:0x00000004010=
a0000
[    2.604092] GICv3: CPU33: using allocated LPI pending table @0x000000088=
0b10000
[    2.604145] CPU33: Booted secondary processor 0x0000000101 [0x431f0af1]
[    2.604235] Bringup CPU33 0
[    2.604237] Bringup CPU34 left 222
[    2.672660] Detected PIPT I-cache on CPU34
[    2.672691] GICv3: CPU34: found redistributor 201 region 0:0x00000004011=
20000
[    2.672699] GICv3: CPU34: using allocated LPI pending table @0x000000088=
0b20000
[    2.672753] CPU34: Booted secondary processor 0x0000000201 [0x431f0af1]
[    2.672843] Bringup CPU34 0
[    2.672846] Bringup CPU35 left 221
[    2.740986] Detected PIPT I-cache on CPU35
[    2.741018] GICv3: CPU35: found redistributor 301 region 0:0x00000004011=
a0000
[    2.741027] GICv3: CPU35: using allocated LPI pending table @0x000000088=
0b30000
[    2.741080] CPU35: Booted secondary processor 0x0000000301 [0x431f0af1]
[    2.741169] Bringup CPU35 0
[    2.741172] Bringup CPU36 left 220
[    2.809469] Detected PIPT I-cache on CPU36
[    2.809503] GICv3: CPU36: found redistributor 401 region 0:0x00000004012=
20000
[    2.809511] GICv3: CPU36: using allocated LPI pending table @0x000000088=
0b40000
[    2.809564] CPU36: Booted secondary processor 0x0000000401 [0x431f0af1]
[    2.809654] Bringup CPU36 0
[    2.809657] Bringup CPU37 left 219
[    2.878071] Detected PIPT I-cache on CPU37
[    2.878108] GICv3: CPU37: found redistributor 501 region 0:0x00000004012=
a0000
[    2.878116] GICv3: CPU37: using allocated LPI pending table @0x000000088=
0b50000
[    2.878169] CPU37: Booted secondary processor 0x0000000501 [0x431f0af1]
[    2.878259] Bringup CPU37 0
[    2.878262] Bringup CPU38 left 218
[    2.946487] Detected PIPT I-cache on CPU38
[    2.946525] GICv3: CPU38: found redistributor 601 region 0:0x00000004013=
20000
[    2.946533] GICv3: CPU38: using allocated LPI pending table @0x000000088=
0b60000
[    2.946587] CPU38: Booted secondary processor 0x0000000601 [0x431f0af1]
[    2.946677] Bringup CPU38 0
[    2.946680] Bringup CPU39 left 217
[    3.014963] Detected PIPT I-cache on CPU39
[    3.015003] GICv3: CPU39: found redistributor 701 region 0:0x00000004013=
a0000
[    3.015012] GICv3: CPU39: using allocated LPI pending table @0x000000088=
0b70000
[    3.015064] CPU39: Booted secondary processor 0x0000000701 [0x431f0af1]
[    3.015158] Bringup CPU39 0
[    3.015161] Bringup CPU40 left 216
[    3.083400] Detected PIPT I-cache on CPU40
[    3.083443] GICv3: CPU40: found redistributor 801 region 0:0x00000004014=
20000
[    3.083451] GICv3: CPU40: using allocated LPI pending table @0x000000088=
0b80000
[    3.083504] CPU40: Booted secondary processor 0x0000000801 [0x431f0af1]
[    3.083598] Bringup CPU40 0
[    3.083601] Bringup CPU41 left 215
[    3.152018] Detected PIPT I-cache on CPU41
[    3.152063] GICv3: CPU41: found redistributor 901 region 0:0x00000004014=
a0000
[    3.152071] GICv3: CPU41: using allocated LPI pending table @0x000000088=
0b90000
[    3.152123] CPU41: Booted secondary processor 0x0000000901 [0x431f0af1]
[    3.152211] Bringup CPU41 0
[    3.152214] Bringup CPU42 left 214
[    3.220435] Detected PIPT I-cache on CPU42
[    3.220481] GICv3: CPU42: found redistributor a01 region 0:0x00000004015=
20000
[    3.220489] GICv3: CPU42: using allocated LPI pending table @0x000000088=
0ba0000
[    3.220542] CPU42: Booted secondary processor 0x0000000a01 [0x431f0af1]
[    3.220634] Bringup CPU42 0
[    3.220637] Bringup CPU43 left 213
[    3.288786] Detected PIPT I-cache on CPU43
[    3.288833] GICv3: CPU43: found redistributor b01 region 0:0x00000004015=
a0000
[    3.288842] GICv3: CPU43: using allocated LPI pending table @0x000000088=
0bb0000
[    3.288895] CPU43: Booted secondary processor 0x0000000b01 [0x431f0af1]
[    3.288985] Bringup CPU43 0
[    3.288988] Bringup CPU44 left 212
[    3.357271] Detected PIPT I-cache on CPU44
[    3.357321] GICv3: CPU44: found redistributor c01 region 0:0x00000004016=
20000
[    3.357329] GICv3: CPU44: using allocated LPI pending table @0x000000088=
0bc0000
[    3.357382] CPU44: Booted secondary processor 0x0000000c01 [0x431f0af1]
[    3.357475] Bringup CPU44 0
[    3.357478] Bringup CPU45 left 211
[    3.426136] Detected PIPT I-cache on CPU45
[    3.426188] GICv3: CPU45: found redistributor d01 region 0:0x00000004016=
a0000
[    3.426196] GICv3: CPU45: using allocated LPI pending table @0x000000088=
0bd0000
[    3.426249] CPU45: Booted secondary processor 0x0000000d01 [0x431f0af1]
[    3.426342] Bringup CPU45 0
[    3.426345] Bringup CPU46 left 210
[    3.494971] Detected PIPT I-cache on CPU46
[    3.495026] GICv3: CPU46: found redistributor e01 region 0:0x00000004017=
20000
[    3.495034] GICv3: CPU46: using allocated LPI pending table @0x000000088=
0be0000
[    3.495087] CPU46: Booted secondary processor 0x0000000e01 [0x431f0af1]
[    3.495178] Bringup CPU46 0
[    3.495181] Bringup CPU47 left 209
[    3.563244] Detected PIPT I-cache on CPU47
[    3.563300] GICv3: CPU47: found redistributor f01 region 0:0x00000004017=
a0000
[    3.563308] GICv3: CPU47: using allocated LPI pending table @0x000000088=
0bf0000
[    3.563362] CPU47: Booted secondary processor 0x0000000f01 [0x431f0af1]
[    3.563453] Bringup CPU47 0
[    3.563455] Bringup CPU48 left 208
[    3.631916] Detected PIPT I-cache on CPU48
[    3.631975] GICv3: CPU48: found redistributor 1001 region 0:0x0000000401=
820000
[    3.631984] GICv3: CPU48: using allocated LPI pending table @0x000000088=
0c00000
[    3.632036] CPU48: Booted secondary processor 0x0000001001 [0x431f0af1]
[    3.632129] Bringup CPU48 0
[    3.632132] Bringup CPU49 left 207
[    3.700602] Detected PIPT I-cache on CPU49
[    3.700664] GICv3: CPU49: found redistributor 1101 region 0:0x0000000401=
8a0000
[    3.700672] GICv3: CPU49: using allocated LPI pending table @0x000000088=
0c10000
[    3.700725] CPU49: Booted secondary processor 0x0000001101 [0x431f0af1]
[    3.700817] Bringup CPU49 0
[    3.700820] Bringup CPU50 left 206
[    3.769387] Detected PIPT I-cache on CPU50
[    3.769450] GICv3: CPU50: found redistributor 1201 region 0:0x0000000401=
920000
[    3.769458] GICv3: CPU50: using allocated LPI pending table @0x000000088=
0c20000
[    3.769512] CPU50: Booted secondary processor 0x0000001201 [0x431f0af1]
[    3.769605] Bringup CPU50 0
[    3.769607] Bringup CPU51 left 205
[    3.838160] Detected PIPT I-cache on CPU51
[    3.838225] GICv3: CPU51: found redistributor 1301 region 0:0x0000000401=
9a0000
[    3.838233] GICv3: CPU51: using allocated LPI pending table @0x000000088=
0c30000
[    3.838286] CPU51: Booted secondary processor 0x0000001301 [0x431f0af1]
[    3.838379] Bringup CPU51 0
[    3.838381] Bringup CPU52 left 204
[    3.906682] Detected PIPT I-cache on CPU52
[    3.906749] GICv3: CPU52: found redistributor 1401 region 0:0x0000000401=
a20000
[    3.906757] GICv3: CPU52: using allocated LPI pending table @0x000000088=
0c40000
[    3.906810] CPU52: Booted secondary processor 0x0000001401 [0x431f0af1]
[    3.906905] Bringup CPU52 0
[    3.906907] Bringup CPU53 left 203
[    3.975408] Detected PIPT I-cache on CPU53
[    3.975477] GICv3: CPU53: found redistributor 1501 region 0:0x0000000401=
aa0000
[    3.975485] GICv3: CPU53: using allocated LPI pending table @0x000000088=
0c50000
[    3.975538] CPU53: Booted secondary processor 0x0000001501 [0x431f0af1]
[    3.975631] Bringup CPU53 0
[    3.975633] Bringup CPU54 left 202
[    4.044084] Detected PIPT I-cache on CPU54
[    4.044154] GICv3: CPU54: found redistributor 1601 region 0:0x0000000401=
b20000
[    4.044162] GICv3: CPU54: using allocated LPI pending table @0x000000088=
0c60000
[    4.044216] CPU54: Booted secondary processor 0x0000001601 [0x431f0af1]
[    4.044309] Bringup CPU54 0
[    4.044312] Bringup CPU55 left 201
[    4.112725] Detected PIPT I-cache on CPU55
[    4.112797] GICv3: CPU55: found redistributor 1701 region 0:0x0000000401=
ba0000
[    4.112805] GICv3: CPU55: using allocated LPI pending table @0x000000088=
0c70000
[    4.112858] CPU55: Booted secondary processor 0x0000001701 [0x431f0af1]
[    4.112952] Bringup CPU55 0
[    4.112954] Bringup CPU56 left 200
[    4.181726] Detected PIPT I-cache on CPU56
[    4.181801] GICv3: CPU56: found redistributor 1801 region 0:0x0000000401=
c20000
[    4.181809] GICv3: CPU56: using allocated LPI pending table @0x000000088=
0c80000
[    4.181863] CPU56: Booted secondary processor 0x0000001801 [0x431f0af1]
[    4.181956] Bringup CPU56 0
[    4.181959] Bringup CPU57 left 199
[    4.250209] Detected PIPT I-cache on CPU57
[    4.250285] GICv3: CPU57: found redistributor 1901 region 0:0x0000000401=
ca0000
[    4.250293] GICv3: CPU57: using allocated LPI pending table @0x000000088=
0c90000
[    4.250347] CPU57: Booted secondary processor 0x0000001901 [0x431f0af1]
[    4.250441] Bringup CPU57 0
[    4.250443] Bringup CPU58 left 198
[    4.319062] Detected PIPT I-cache on CPU58
[    4.319141] GICv3: CPU58: found redistributor 1a01 region 0:0x0000000401=
d20000
[    4.319149] GICv3: CPU58: using allocated LPI pending table @0x000000088=
0ca0000
[    4.319203] CPU58: Booted secondary processor 0x0000001a01 [0x431f0af1]
[    4.319298] Bringup CPU58 0
[    4.319300] Bringup CPU59 left 197
[    4.387907] Detected PIPT I-cache on CPU59
[    4.387988] GICv3: CPU59: found redistributor 1b01 region 0:0x0000000401=
da0000
[    4.387996] GICv3: CPU59: using allocated LPI pending table @0x000000088=
0cb0000
[    4.388050] CPU59: Booted secondary processor 0x0000001b01 [0x431f0af1]
[    4.388143] Bringup CPU59 0
[    4.388146] Bringup CPU60 left 196
[    4.456533] Detected PIPT I-cache on CPU60
[    4.456615] GICv3: CPU60: found redistributor 1c01 region 0:0x0000000401=
e20000
[    4.456624] GICv3: CPU60: using allocated LPI pending table @0x000000088=
0cc0000
[    4.456679] CPU60: Booted secondary processor 0x0000001c01 [0x431f0af1]
[    4.456792] Bringup CPU60 0
[    4.456795] Bringup CPU61 left 195
[    4.525028] Detected PIPT I-cache on CPU61
[    4.525113] GICv3: CPU61: found redistributor 1d01 region 0:0x0000000401=
ea0000
[    4.525121] GICv3: CPU61: using allocated LPI pending table @0x000000088=
0cd0000
[    4.525174] CPU61: Booted secondary processor 0x0000001d01 [0x431f0af1]
[    4.525269] Bringup CPU61 0
[    4.525272] Bringup CPU62 left 194
[    4.593720] Detected PIPT I-cache on CPU62
[    4.593808] GICv3: CPU62: found redistributor 1e01 region 0:0x0000000401=
f20000
[    4.593816] GICv3: CPU62: using allocated LPI pending table @0x000000088=
0ce0000
[    4.593868] CPU62: Booted secondary processor 0x0000001e01 [0x431f0af1]
[    4.593962] Bringup CPU62 0
[    4.593965] Bringup CPU63 left 193
[    4.662153] Detected PIPT I-cache on CPU63
[    4.662241] GICv3: CPU63: found redistributor 1f01 region 0:0x0000000401=
fa0000
[    4.662249] GICv3: CPU63: using allocated LPI pending table @0x000000088=
0cf0000
[    4.662301] CPU63: Booted secondary processor 0x0000001f01 [0x431f0af1]
[    4.662399] Bringup CPU63 0
[    4.662402] Bringup CPU64 left 192
[    4.731197] Detected PIPT I-cache on CPU64
[    4.731234] GICv3: CPU64: found redistributor 2 region 0:0x0000000401040=
000
[    4.731243] GICv3: CPU64: using allocated LPI pending table @0x000000088=
0d00000
[    4.731296] CPU64: Booted secondary processor 0x0000000002 [0x431f0af1]
[    4.731396] Bringup CPU64 0
[    4.731399] Bringup CPU65 left 191
[    4.799636] Detected PIPT I-cache on CPU65
[    4.799671] GICv3: CPU65: found redistributor 102 region 0:0x00000004010=
c0000
[    4.799679] GICv3: CPU65: using allocated LPI pending table @0x000000088=
0d10000
[    4.799731] CPU65: Booted secondary processor 0x0000000102 [0x431f0af1]
[    4.799822] Bringup CPU65 0
[    4.799825] Bringup CPU66 left 190
[    4.868445] Detected PIPT I-cache on CPU66
[    4.868486] GICv3: CPU66: found redistributor 202 region 0:0x00000004011=
40000
[    4.868494] GICv3: CPU66: using allocated LPI pending table @0x000000088=
0d20000
[    4.868546] CPU66: Booted secondary processor 0x0000000202 [0x431f0af1]
[    4.868638] Bringup CPU66 0
[    4.868640] Bringup CPU67 left 189
[    4.937078] Detected PIPT I-cache on CPU67
[    4.937120] GICv3: CPU67: found redistributor 302 region 0:0x00000004011=
c0000
[    4.937128] GICv3: CPU67: using allocated LPI pending table @0x000000088=
0d30000
[    4.937180] CPU67: Booted secondary processor 0x0000000302 [0x431f0af1]
[    4.937276] Bringup CPU67 0
[    4.937278] Bringup CPU68 left 188
[    5.005580] Detected PIPT I-cache on CPU68
[    5.005623] GICv3: CPU68: found redistributor 402 region 0:0x00000004012=
40000
[    5.005631] GICv3: CPU68: using allocated LPI pending table @0x000000088=
0d40000
[    5.005683] CPU68: Booted secondary processor 0x0000000402 [0x431f0af1]
[    5.005776] Bringup CPU68 0
[    5.005779] Bringup CPU69 left 187
[    5.074306] Detected PIPT I-cache on CPU69
[    5.074352] GICv3: CPU69: found redistributor 502 region 0:0x00000004012=
c0000
[    5.074360] GICv3: CPU69: using allocated LPI pending table @0x000000088=
0d50000
[    5.074412] CPU69: Booted secondary processor 0x0000000502 [0x431f0af1]
[    5.074506] Bringup CPU69 0
[    5.074508] Bringup CPU70 left 186
[    5.142762] Detected PIPT I-cache on CPU70
[    5.142810] GICv3: CPU70: found redistributor 602 region 0:0x00000004013=
40000
[    5.142818] GICv3: CPU70: using allocated LPI pending table @0x000000088=
0d60000
[    5.142870] CPU70: Booted secondary processor 0x0000000602 [0x431f0af1]
[    5.142964] Bringup CPU70 0
[    5.142967] Bringup CPU71 left 185
[    5.211351] Detected PIPT I-cache on CPU71
[    5.211400] GICv3: CPU71: found redistributor 702 region 0:0x00000004013=
c0000
[    5.211408] GICv3: CPU71: using allocated LPI pending table @0x000000088=
0d70000
[    5.211460] CPU71: Booted secondary processor 0x0000000702 [0x431f0af1]
[    5.211552] Bringup CPU71 0
[    5.211555] Bringup CPU72 left 184
[    5.279995] Detected PIPT I-cache on CPU72
[    5.280048] GICv3: CPU72: found redistributor 802 region 0:0x00000004014=
40000
[    5.280056] GICv3: CPU72: using allocated LPI pending table @0x000000088=
0d80000
[    5.280109] CPU72: Booted secondary processor 0x0000000802 [0x431f0af1]
[    5.280201] Bringup CPU72 0
[    5.280204] Bringup CPU73 left 183
[    5.348712] Detected PIPT I-cache on CPU73
[    5.348766] GICv3: CPU73: found redistributor 902 region 0:0x00000004014=
c0000
[    5.348774] GICv3: CPU73: using allocated LPI pending table @0x000000088=
0d90000
[    5.348826] CPU73: Booted secondary processor 0x0000000902 [0x431f0af1]
[    5.348920] Bringup CPU73 0
[    5.348923] Bringup CPU74 left 182
[    5.417266] Detected PIPT I-cache on CPU74
[    5.417321] GICv3: CPU74: found redistributor a02 region 0:0x00000004015=
40000
[    5.417329] GICv3: CPU74: using allocated LPI pending table @0x000000088=
0da0000
[    5.417381] CPU74: Booted secondary processor 0x0000000a02 [0x431f0af1]
[    5.417477] Bringup CPU74 0
[    5.417480] Bringup CPU75 left 181
[    5.485736] Detected PIPT I-cache on CPU75
[    5.485793] GICv3: CPU75: found redistributor b02 region 0:0x00000004015=
c0000
[    5.485801] GICv3: CPU75: using allocated LPI pending table @0x000000088=
0db0000
[    5.485854] CPU75: Booted secondary processor 0x0000000b02 [0x431f0af1]
[    5.485972] Bringup CPU75 0
[    5.485975] Bringup CPU76 left 180
[    5.554355] Detected PIPT I-cache on CPU76
[    5.554414] GICv3: CPU76: found redistributor c02 region 0:0x00000004016=
40000
[    5.554422] GICv3: CPU76: using allocated LPI pending table @0x000000088=
0dc0000
[    5.554475] CPU76: Booted secondary processor 0x0000000c02 [0x431f0af1]
[    5.554569] Bringup CPU76 0
[    5.554572] Bringup CPU77 left 179
[    5.623035] Detected PIPT I-cache on CPU77
[    5.623097] GICv3: CPU77: found redistributor d02 region 0:0x00000004016=
c0000
[    5.623105] GICv3: CPU77: using allocated LPI pending table @0x000000088=
0dd0000
[    5.623157] CPU77: Booted secondary processor 0x0000000d02 [0x431f0af1]
[    5.623249] Bringup CPU77 0
[    5.623252] Bringup CPU78 left 178
[    5.691609] Detected PIPT I-cache on CPU78
[    5.691674] GICv3: CPU78: found redistributor e02 region 0:0x00000004017=
40000
[    5.691683] GICv3: CPU78: using allocated LPI pending table @0x000000088=
0de0000
[    5.691735] CPU78: Booted secondary processor 0x0000000e02 [0x431f0af1]
[    5.691829] Bringup CPU78 0
[    5.691832] Bringup CPU79 left 177
[    5.760010] Detected PIPT I-cache on CPU79
[    5.760075] GICv3: CPU79: found redistributor f02 region 0:0x00000004017=
c0000
[    5.760083] GICv3: CPU79: using allocated LPI pending table @0x000000088=
0df0000
[    5.760136] CPU79: Booted secondary processor 0x0000000f02 [0x431f0af1]
[    5.760230] Bringup CPU79 0
[    5.760232] Bringup CPU80 left 176
[    5.828861] Detected PIPT I-cache on CPU80
[    5.828929] GICv3: CPU80: found redistributor 1002 region 0:0x0000000401=
840000
[    5.828938] GICv3: CPU80: using allocated LPI pending table @0x000000088=
0e00000
[    5.828991] CPU80: Booted secondary processor 0x0000001002 [0x431f0af1]
[    5.829090] Bringup CPU80 0
[    5.829093] Bringup CPU81 left 175
[    5.897816] Detected PIPT I-cache on CPU81
[    5.897886] GICv3: CPU81: found redistributor 1102 region 0:0x0000000401=
8c0000
[    5.897894] GICv3: CPU81: using allocated LPI pending table @0x000000088=
0e10000
[    5.897946] CPU81: Booted secondary processor 0x0000001102 [0x431f0af1]
[    5.898043] Bringup CPU81 0
[    5.898046] Bringup CPU82 left 174
[    5.966694] Detected PIPT I-cache on CPU82
[    5.966767] GICv3: CPU82: found redistributor 1202 region 0:0x0000000401=
940000
[    5.966776] GICv3: CPU82: using allocated LPI pending table @0x000000088=
0e20000
[    5.966828] CPU82: Booted secondary processor 0x0000001202 [0x431f0af1]
[    5.966925] Bringup CPU82 0
[    5.966927] Bringup CPU83 left 173
[    6.035887] Detected PIPT I-cache on CPU83
[    6.035962] GICv3: CPU83: found redistributor 1302 region 0:0x0000000401=
9c0000
[    6.035971] GICv3: CPU83: using allocated LPI pending table @0x000000088=
0e30000
[    6.036023] CPU83: Booted secondary processor 0x0000001302 [0x431f0af1]
[    6.036118] Bringup CPU83 0
[    6.036121] Bringup CPU84 left 172
[    6.104513] Detected PIPT I-cache on CPU84
[    6.104588] GICv3: CPU84: found redistributor 1402 region 0:0x0000000401=
a40000
[    6.104597] GICv3: CPU84: using allocated LPI pending table @0x000000088=
0e40000
[    6.104650] CPU84: Booted secondary processor 0x0000001402 [0x431f0af1]
[    6.104745] Bringup CPU84 0
[    6.104747] Bringup CPU85 left 171
[    6.173344] Detected PIPT I-cache on CPU85
[    6.173421] GICv3: CPU85: found redistributor 1502 region 0:0x0000000401=
ac0000
[    6.173430] GICv3: CPU85: using allocated LPI pending table @0x000000088=
0e50000
[    6.173483] CPU85: Booted secondary processor 0x0000001502 [0x431f0af1]
[    6.173579] Bringup CPU85 0
[    6.173582] Bringup CPU86 left 170
[    6.242129] Detected PIPT I-cache on CPU86
[    6.242208] GICv3: CPU86: found redistributor 1602 region 0:0x0000000401=
b40000
[    6.242217] GICv3: CPU86: using allocated LPI pending table @0x000000088=
0e60000
[    6.242270] CPU86: Booted secondary processor 0x0000001602 [0x431f0af1]
[    6.242366] Bringup CPU86 0
[    6.242369] Bringup CPU87 left 169
[    6.310865] Detected PIPT I-cache on CPU87
[    6.310946] GICv3: CPU87: found redistributor 1702 region 0:0x0000000401=
bc0000
[    6.310955] GICv3: CPU87: using allocated LPI pending table @0x000000088=
0e70000
[    6.311007] CPU87: Booted secondary processor 0x0000001702 [0x431f0af1]
[    6.311104] Bringup CPU87 0
[    6.311107] Bringup CPU88 left 168
[    6.379680] Detected PIPT I-cache on CPU88
[    6.379765] GICv3: CPU88: found redistributor 1802 region 0:0x0000000401=
c40000
[    6.379774] GICv3: CPU88: using allocated LPI pending table @0x000000088=
0e80000
[    6.379827] CPU88: Booted secondary processor 0x0000001802 [0x431f0af1]
[    6.379924] Bringup CPU88 0
[    6.379927] Bringup CPU89 left 167
[    6.448290] Detected PIPT I-cache on CPU89
[    6.448376] GICv3: CPU89: found redistributor 1902 region 0:0x0000000401=
cc0000
[    6.448385] GICv3: CPU89: using allocated LPI pending table @0x000000088=
0e90000
[    6.448438] CPU89: Booted secondary processor 0x0000001902 [0x431f0af1]
[    6.448536] Bringup CPU89 0
[    6.448538] Bringup CPU90 left 166
[    6.517179] Detected PIPT I-cache on CPU90
[    6.517268] GICv3: CPU90: found redistributor 1a02 region 0:0x0000000401=
d40000
[    6.517277] GICv3: CPU90: using allocated LPI pending table @0x000000088=
0ea0000
[    6.517330] CPU90: Booted secondary processor 0x0000001a02 [0x431f0af1]
[    6.517426] Bringup CPU90 0
[    6.517429] Bringup CPU91 left 165
[    6.585792] Detected PIPT I-cache on CPU91
[    6.585881] GICv3: CPU91: found redistributor 1b02 region 0:0x0000000401=
dc0000
[    6.585890] GICv3: CPU91: using allocated LPI pending table @0x000000088=
0eb0000
[    6.585944] CPU91: Booted secondary processor 0x0000001b02 [0x431f0af1]
[    6.586065] Bringup CPU91 0
[    6.586069] Bringup CPU92 left 164
[    6.654569] Detected PIPT I-cache on CPU92
[    6.654660] GICv3: CPU92: found redistributor 1c02 region 0:0x0000000401=
e40000
[    6.654669] GICv3: CPU92: using allocated LPI pending table @0x000000088=
0ec0000
[    6.654722] CPU92: Booted secondary processor 0x0000001c02 [0x431f0af1]
[    6.654821] Bringup CPU92 0
[    6.654824] Bringup CPU93 left 163
[    6.723164] Detected PIPT I-cache on CPU93
[    6.723258] GICv3: CPU93: found redistributor 1d02 region 0:0x0000000401=
ec0000
[    6.723267] GICv3: CPU93: using allocated LPI pending table @0x000000088=
0ed0000
[    6.723320] CPU93: Booted secondary processor 0x0000001d02 [0x431f0af1]
[    6.723415] Bringup CPU93 0
[    6.723418] Bringup CPU94 left 162
[    6.791967] Detected PIPT I-cache on CPU94
[    6.792065] GICv3: CPU94: found redistributor 1e02 region 0:0x0000000401=
f40000
[    6.792074] GICv3: CPU94: using allocated LPI pending table @0x000000088=
0ee0000
[    6.792127] CPU94: Booted secondary processor 0x0000001e02 [0x431f0af1]
[    6.792226] Bringup CPU94 0
[    6.792229] Bringup CPU95 left 161
[    6.860520] Detected PIPT I-cache on CPU95
[    6.860618] GICv3: CPU95: found redistributor 1f02 region 0:0x0000000401=
fc0000
[    6.860627] GICv3: CPU95: using allocated LPI pending table @0x000000088=
0ef0000
[    6.860681] CPU95: Booted secondary processor 0x0000001f02 [0x431f0af1]
[    6.860777] Bringup CPU95 0
[    6.860780] Bringup CPU96 left 160
[    6.929652] Detected PIPT I-cache on CPU96
[    6.929700] GICv3: CPU96: found redistributor 3 region 0:0x0000000401060=
000
[    6.929710] GICv3: CPU96: using allocated LPI pending table @0x000000088=
0f00000
[    6.929763] CPU96: Booted secondary processor 0x0000000003 [0x431f0af1]
[    6.929866] Bringup CPU96 0
[    6.929869] Bringup CPU97 left 159
[    6.998236] Detected PIPT I-cache on CPU97
[    6.998279] GICv3: CPU97: found redistributor 103 region 0:0x00000004010=
e0000
[    6.998287] GICv3: CPU97: using allocated LPI pending table @0x000000088=
0f10000
[    6.998339] CPU97: Booted secondary processor 0x0000000103 [0x431f0af1]
[    6.998434] Bringup CPU97 0
[    6.998437] Bringup CPU98 left 158
[    7.066986] Detected PIPT I-cache on CPU98
[    7.067036] GICv3: CPU98: found redistributor 203 region 0:0x00000004011=
60000
[    7.067045] GICv3: CPU98: using allocated LPI pending table @0x000000088=
0f20000
[    7.067097] CPU98: Booted secondary processor 0x0000000203 [0x431f0af1]
[    7.067194] Bringup CPU98 0
[    7.067197] Bringup CPU99 left 157
[    7.135657] Detected PIPT I-cache on CPU99
[    7.135709] GICv3: CPU99: found redistributor 303 region 0:0x00000004011=
e0000
[    7.135717] GICv3: CPU99: using allocated LPI pending table @0x000000088=
0f30000
[    7.135770] CPU99: Booted secondary processor 0x0000000303 [0x431f0af1]
[    7.135870] Bringup CPU99 0
[    7.135872] Bringup CPU100 left 156
[    7.204283] Detected PIPT I-cache on CPU100
[    7.204337] GICv3: CPU100: found redistributor 403 region 0:0x0000000401=
260000
[    7.204346] GICv3: CPU100: using allocated LPI pending table @0x00000008=
80f40000
[    7.204399] CPU100: Booted secondary processor 0x0000000403 [0x431f0af1]
[    7.204496] Bringup CPU100 0
[    7.204499] Bringup CPU101 left 155
[    7.273135] Detected PIPT I-cache on CPU101
[    7.273191] GICv3: CPU101: found redistributor 503 region 0:0x0000000401=
2e0000
[    7.273200] GICv3: CPU101: using allocated LPI pending table @0x00000008=
80f50000
[    7.273252] CPU101: Booted secondary processor 0x0000000503 [0x431f0af1]
[    7.273354] Bringup CPU101 0
[    7.273357] Bringup CPU102 left 154
[    7.341720] Detected PIPT I-cache on CPU102
[    7.341777] GICv3: CPU102: found redistributor 603 region 0:0x0000000401=
360000
[    7.341786] GICv3: CPU102: using allocated LPI pending table @0x00000008=
80f60000
[    7.341837] CPU102: Booted secondary processor 0x0000000603 [0x431f0af1]
[    7.341937] Bringup CPU102 0
[    7.341940] Bringup CPU103 left 153
[    7.410435] Detected PIPT I-cache on CPU103
[    7.410495] GICv3: CPU103: found redistributor 703 region 0:0x0000000401=
3e0000
[    7.410503] GICv3: CPU103: using allocated LPI pending table @0x00000008=
80f70000
[    7.410556] CPU103: Booted secondary processor 0x0000000703 [0x431f0af1]
[    7.410653] Bringup CPU103 0
[    7.410655] Bringup CPU104 left 152
[    7.479258] Detected PIPT I-cache on CPU104
[    7.479319] GICv3: CPU104: found redistributor 803 region 0:0x0000000401=
460000
[    7.479328] GICv3: CPU104: using allocated LPI pending table @0x00000008=
80f80000
[    7.479381] CPU104: Booted secondary processor 0x0000000803 [0x431f0af1]
[    7.479479] Bringup CPU104 0
[    7.479482] Bringup CPU105 left 151
[    7.548112] Detected PIPT I-cache on CPU105
[    7.548174] GICv3: CPU105: found redistributor 903 region 0:0x0000000401=
4e0000
[    7.548184] GICv3: CPU105: using allocated LPI pending table @0x00000008=
80f90000
[    7.548236] CPU105: Booted secondary processor 0x0000000903 [0x431f0af1]
[    7.548331] Bringup CPU105 0
[    7.548334] Bringup CPU106 left 150
[    7.616781] Detected PIPT I-cache on CPU106
[    7.616848] GICv3: CPU106: found redistributor a03 region 0:0x0000000401=
560000
[    7.616858] GICv3: CPU106: using allocated LPI pending table @0x00000008=
80fa0000
[    7.616910] CPU106: Booted secondary processor 0x0000000a03 [0x431f0af1]
[    7.617006] Bringup CPU106 0
[    7.617009] Bringup CPU107 left 149
[    7.685372] Detected PIPT I-cache on CPU107
[    7.685439] GICv3: CPU107: found redistributor b03 region 0:0x0000000401=
5e0000
[    7.685449] GICv3: CPU107: using allocated LPI pending table @0x00000008=
80fb0000
[    7.685501] CPU107: Booted secondary processor 0x0000000b03 [0x431f0af1]
[    7.685626] Bringup CPU107 0
[    7.685629] Bringup CPU108 left 148
[    7.754320] Detected PIPT I-cache on CPU108
[    7.754389] GICv3: CPU108: found redistributor c03 region 0:0x0000000401=
660000
[    7.754398] GICv3: CPU108: using allocated LPI pending table @0x00000008=
80fc0000
[    7.754451] CPU108: Booted secondary processor 0x0000000c03 [0x431f0af1]
[    7.754548] Bringup CPU108 0
[    7.754551] Bringup CPU109 left 147
[    7.823128] Detected PIPT I-cache on CPU109
[    7.823199] GICv3: CPU109: found redistributor d03 region 0:0x0000000401=
6e0000
[    7.823208] GICv3: CPU109: using allocated LPI pending table @0x00000008=
80fd0000
[    7.823260] CPU109: Booted secondary processor 0x0000000d03 [0x431f0af1]
[    7.823359] Bringup CPU109 0
[    7.823362] Bringup CPU110 left 146
[    7.891829] Detected PIPT I-cache on CPU110
[    7.891904] GICv3: CPU110: found redistributor e03 region 0:0x0000000401=
760000
[    7.891913] GICv3: CPU110: using allocated LPI pending table @0x00000008=
80fe0000
[    7.891965] CPU110: Booted secondary processor 0x0000000e03 [0x431f0af1]
[    7.892064] Bringup CPU110 0
[    7.892067] Bringup CPU111 left 145
[    7.960367] Detected PIPT I-cache on CPU111
[    7.960442] GICv3: CPU111: found redistributor f03 region 0:0x0000000401=
7e0000
[    7.960451] GICv3: CPU111: using allocated LPI pending table @0x00000008=
80ff0000
[    7.960503] CPU111: Booted secondary processor 0x0000000f03 [0x431f0af1]
[    7.960600] Bringup CPU111 0
[    7.960603] Bringup CPU112 left 144
[    8.029232] Detected PIPT I-cache on CPU112
[    8.029310] GICv3: CPU112: found redistributor 1003 region 0:0x000000040=
1860000
[    8.029319] GICv3: CPU112: using allocated LPI pending table @0x00000008=
81000000
[    8.029370] CPU112: Booted secondary processor 0x0000001003 [0x431f0af1]
[    8.029471] Bringup CPU112 0
[    8.029474] Bringup CPU113 left 143
[    8.098113] Detected PIPT I-cache on CPU113
[    8.098193] GICv3: CPU113: found redistributor 1103 region 0:0x000000040=
18e0000
[    8.098203] GICv3: CPU113: using allocated LPI pending table @0x00000008=
81010000
[    8.098255] CPU113: Booted secondary processor 0x0000001103 [0x431f0af1]
[    8.098353] Bringup CPU113 0
[    8.098356] Bringup CPU114 left 142
[    8.167090] Detected PIPT I-cache on CPU114
[    8.167172] GICv3: CPU114: found redistributor 1203 region 0:0x000000040=
1960000
[    8.167181] GICv3: CPU114: using allocated LPI pending table @0x00000008=
81020000
[    8.167234] CPU114: Booted secondary processor 0x0000001203 [0x431f0af1]
[    8.167333] Bringup CPU114 0
[    8.167336] Bringup CPU115 left 141
[    8.236006] Detected PIPT I-cache on CPU115
[    8.236090] GICv3: CPU115: found redistributor 1303 region 0:0x000000040=
19e0000
[    8.236099] GICv3: CPU115: using allocated LPI pending table @0x00000008=
81030000
[    8.236152] CPU115: Booted secondary processor 0x0000001303 [0x431f0af1]
[    8.236252] Bringup CPU115 0
[    8.236255] Bringup CPU116 left 140
[    8.304797] Detected PIPT I-cache on CPU116
[    8.304883] GICv3: CPU116: found redistributor 1403 region 0:0x000000040=
1a60000
[    8.304892] GICv3: CPU116: using allocated LPI pending table @0x00000008=
81040000
[    8.304944] CPU116: Booted secondary processor 0x0000001403 [0x431f0af1]
[    8.305045] Bringup CPU116 0
[    8.305048] Bringup CPU117 left 139
[    8.373728] Detected PIPT I-cache on CPU117
[    8.373816] GICv3: CPU117: found redistributor 1503 region 0:0x000000040=
1ae0000
[    8.373826] GICv3: CPU117: using allocated LPI pending table @0x00000008=
81050000
[    8.373879] CPU117: Booted secondary processor 0x0000001503 [0x431f0af1]
[    8.373982] Bringup CPU117 0
[    8.373985] Bringup CPU118 left 138
[    8.442617] Detected PIPT I-cache on CPU118
[    8.442707] GICv3: CPU118: found redistributor 1603 region 0:0x000000040=
1b60000
[    8.442716] GICv3: CPU118: using allocated LPI pending table @0x00000008=
81060000
[    8.442768] CPU118: Booted secondary processor 0x0000001603 [0x431f0af1]
[    8.442868] Bringup CPU118 0
[    8.442871] Bringup CPU119 left 137
[    8.511459] Detected PIPT I-cache on CPU119
[    8.511550] GICv3: CPU119: found redistributor 1703 region 0:0x000000040=
1be0000
[    8.511560] GICv3: CPU119: using allocated LPI pending table @0x00000008=
81070000
[    8.511612] CPU119: Booted secondary processor 0x0000001703 [0x431f0af1]
[    8.511712] Bringup CPU119 0
[    8.511715] Bringup CPU120 left 136
[    8.580428] Detected PIPT I-cache on CPU120
[    8.580521] GICv3: CPU120: found redistributor 1803 region 0:0x000000040=
1c60000
[    8.580531] GICv3: CPU120: using allocated LPI pending table @0x00000008=
81080000
[    8.580583] CPU120: Booted secondary processor 0x0000001803 [0x431f0af1]
[    8.580682] Bringup CPU120 0
[    8.580685] Bringup CPU121 left 135
[    8.649122] Detected PIPT I-cache on CPU121
[    8.649218] GICv3: CPU121: found redistributor 1903 region 0:0x000000040=
1ce0000
[    8.649227] GICv3: CPU121: using allocated LPI pending table @0x00000008=
81090000
[    8.649279] CPU121: Booted secondary processor 0x0000001903 [0x431f0af1]
[    8.649379] Bringup CPU121 0
[    8.649382] Bringup CPU122 left 134
[    8.718460] Detected PIPT I-cache on CPU122
[    8.718558] GICv3: CPU122: found redistributor 1a03 region 0:0x000000040=
1d60000
[    8.718567] GICv3: CPU122: using allocated LPI pending table @0x00000008=
810a0000
[    8.718620] CPU122: Booted secondary processor 0x0000001a03 [0x431f0af1]
[    8.718751] Bringup CPU122 0
[    8.718754] Bringup CPU123 left 133
[    8.787419] Detected PIPT I-cache on CPU123
[    8.787519] GICv3: CPU123: found redistributor 1b03 region 0:0x000000040=
1de0000
[    8.787528] GICv3: CPU123: using allocated LPI pending table @0x00000008=
810b0000
[    8.787580] CPU123: Booted secondary processor 0x0000001b03 [0x431f0af1]
[    8.787683] Bringup CPU123 0
[    8.787686] Bringup CPU124 left 132
[    8.856255] Detected PIPT I-cache on CPU124
[    8.856357] GICv3: CPU124: found redistributor 1c03 region 0:0x000000040=
1e60000
[    8.856366] GICv3: CPU124: using allocated LPI pending table @0x00000008=
810c0000
[    8.856419] CPU124: Booted secondary processor 0x0000001c03 [0x431f0af1]
[    8.856518] Bringup CPU124 0
[    8.856522] Bringup CPU125 left 131
[    8.924931] Detected PIPT I-cache on CPU125
[    8.925034] GICv3: CPU125: found redistributor 1d03 region 0:0x000000040=
1ee0000
[    8.925044] GICv3: CPU125: using allocated LPI pending table @0x00000008=
810d0000
[    8.925095] CPU125: Booted secondary processor 0x0000001d03 [0x431f0af1]
[    8.925196] Bringup CPU125 0
[    8.925199] Bringup CPU126 left 130
[    8.993823] Detected PIPT I-cache on CPU126
[    8.993931] GICv3: CPU126: found redistributor 1e03 region 0:0x000000040=
1f60000
[    8.993941] GICv3: CPU126: using allocated LPI pending table @0x00000008=
810e0000
[    8.993993] CPU126: Booted secondary processor 0x0000001e03 [0x431f0af1]
[    8.994095] Bringup CPU126 0
[    8.994098] Bringup CPU127 left 129
[    9.062463] Detected PIPT I-cache on CPU127
[    9.062570] GICv3: CPU127: found redistributor 1f03 region 0:0x000000040=
1fe0000
[    9.062579] GICv3: CPU127: using allocated LPI pending table @0x00000008=
810f0000
[    9.062631] CPU127: Booted secondary processor 0x0000001f03 [0x431f0af1]
[    9.062734] Bringup CPU127 0
[    9.062737] Bringup CPU128 left 128
[    9.220384] Detected PIPT I-cache on CPU128
[    9.220561] GICv3: CPU128: found redistributor 10000 region 1:0x00000004=
41000000
[    9.220580] GICv3: CPU128: using allocated LPI pending table @0x00000008=
81100000
[    9.220666] CPU128: Booted secondary processor 0x0000010000 [0x431f0af1]
[    9.221068] Bringup CPU128 0
[    9.221072] Bringup CPU129 left 127
[    9.387854] Detected PIPT I-cache on CPU129
[    9.387987] GICv3: CPU129: found redistributor 10100 region 1:0x00000004=
41080000
[    9.387998] GICv3: CPU129: using allocated LPI pending table @0x00000008=
81110000
[    9.388068] CPU129: Booted secondary processor 0x0000010100 [0x431f0af1]
[    9.388215] Bringup CPU129 0
[    9.388219] Bringup CPU130 left 126
[    9.545912] Detected PIPT I-cache on CPU130
[    9.546046] GICv3: CPU130: found redistributor 10200 region 1:0x00000004=
41100000
[    9.546057] GICv3: CPU130: using allocated LPI pending table @0x00000008=
81120000
[    9.546126] CPU130: Booted secondary processor 0x0000010200 [0x431f0af1]
[    9.546275] Bringup CPU130 0
[    9.546279] Bringup CPU131 left 125
[    9.711527] Detected PIPT I-cache on CPU131
[    9.711666] GICv3: CPU131: found redistributor 10300 region 1:0x00000004=
41180000
[    9.711678] GICv3: CPU131: using allocated LPI pending table @0x00000008=
81130000
[    9.711750] CPU131: Booted secondary processor 0x0000010300 [0x431f0af1]
[    9.711898] Bringup CPU131 0
[    9.711901] Bringup CPU132 left 124
[    9.879364] Detected PIPT I-cache on CPU132
[    9.879505] GICv3: CPU132: found redistributor 10400 region 1:0x00000004=
41200000
[    9.879517] GICv3: CPU132: using allocated LPI pending table @0x00000008=
81140000
[    9.879589] CPU132: Booted secondary processor 0x0000010400 [0x431f0af1]
[    9.879805] Bringup CPU132 0
[    9.879809] Bringup CPU133 left 123
[   10.048128] Detected PIPT I-cache on CPU133
[   10.048269] GICv3: CPU133: found redistributor 10500 region 1:0x00000004=
41280000
[   10.048281] GICv3: CPU133: using allocated LPI pending table @0x00000008=
81150000
[   10.048350] CPU133: Booted secondary processor 0x0000010500 [0x431f0af1]
[   10.048498] Bringup CPU133 0
[   10.048502] Bringup CPU134 left 122
[   10.214683] Detected PIPT I-cache on CPU134
[   10.214828] GICv3: CPU134: found redistributor 10600 region 1:0x00000004=
41300000
[   10.214840] GICv3: CPU134: using allocated LPI pending table @0x00000008=
81160000
[   10.214910] CPU134: Booted secondary processor 0x0000010600 [0x431f0af1]
[   10.215055] Bringup CPU134 0
[   10.215059] Bringup CPU135 left 121
[   10.372067] Detected PIPT I-cache on CPU135
[   10.372213] GICv3: CPU135: found redistributor 10700 region 1:0x00000004=
41380000
[   10.372225] GICv3: CPU135: using allocated LPI pending table @0x00000008=
81170000
[   10.372295] CPU135: Booted secondary processor 0x0000010700 [0x431f0af1]
[   10.372444] Bringup CPU135 0
[   10.372448] Bringup CPU136 left 120
[   10.539095] Detected PIPT I-cache on CPU136
[   10.539244] GICv3: CPU136: found redistributor 10800 region 1:0x00000004=
41400000
[   10.539256] GICv3: CPU136: using allocated LPI pending table @0x00000008=
81180000
[   10.539325] CPU136: Booted secondary processor 0x0000010800 [0x431f0af1]
[   10.539471] Bringup CPU136 0
[   10.539474] Bringup CPU137 left 119
[   10.705053] Detected PIPT I-cache on CPU137
[   10.705204] GICv3: CPU137: found redistributor 10900 region 1:0x00000004=
41480000
[   10.705216] GICv3: CPU137: using allocated LPI pending table @0x00000008=
81190000
[   10.705285] CPU137: Booted secondary processor 0x0000010900 [0x431f0af1]
[   10.705430] Bringup CPU137 0
[   10.705434] Bringup CPU138 left 118
[   10.871710] Detected PIPT I-cache on CPU138
[   10.871863] GICv3: CPU138: found redistributor 10a00 region 1:0x00000004=
41500000
[   10.871875] GICv3: CPU138: using allocated LPI pending table @0x00000008=
811a0000
[   10.871944] CPU138: Booted secondary processor 0x0000010a00 [0x431f0af1]
[   10.872094] Bringup CPU138 0
[   10.872097] Bringup CPU139 left 117
[   11.037668] Detected PIPT I-cache on CPU139
[   11.037823] GICv3: CPU139: found redistributor 10b00 region 1:0x00000004=
41580000
[   11.037835] GICv3: CPU139: using allocated LPI pending table @0x00000008=
811b0000
[   11.037906] CPU139: Booted secondary processor 0x0000010b00 [0x431f0af1]
[   11.038125] Bringup CPU139 0
[   11.038129] Bringup CPU140 left 116
[   11.203709] Detected PIPT I-cache on CPU140
[   11.203866] GICv3: CPU140: found redistributor 10c00 region 1:0x00000004=
41600000
[   11.203878] GICv3: CPU140: using allocated LPI pending table @0x00000008=
811c0000
[   11.203948] CPU140: Booted secondary processor 0x0000010c00 [0x431f0af1]
[   11.204101] Bringup CPU140 0
[   11.204105] Bringup CPU141 left 115
[   11.370278] Detected PIPT I-cache on CPU141
[   11.370434] GICv3: CPU141: found redistributor 10d00 region 1:0x00000004=
41680000
[   11.370446] GICv3: CPU141: using allocated LPI pending table @0x00000008=
811d0000
[   11.370517] CPU141: Booted secondary processor 0x0000010d00 [0x431f0af1]
[   11.370669] Bringup CPU141 0
[   11.370672] Bringup CPU142 left 114
[   11.534969] Detected PIPT I-cache on CPU142
[   11.535132] GICv3: CPU142: found redistributor 10e00 region 1:0x00000004=
41700000
[   11.535144] GICv3: CPU142: using allocated LPI pending table @0x00000008=
811e0000
[   11.535213] CPU142: Booted secondary processor 0x0000010e00 [0x431f0af1]
[   11.535359] Bringup CPU142 0
[   11.535363] Bringup CPU143 left 113
[   11.701078] Detected PIPT I-cache on CPU143
[   11.701242] GICv3: CPU143: found redistributor 10f00 region 1:0x00000004=
41780000
[   11.701254] GICv3: CPU143: using allocated LPI pending table @0x00000008=
811f0000
[   11.701323] CPU143: Booted secondary processor 0x0000010f00 [0x431f0af1]
[   11.701468] Bringup CPU143 0
[   11.701472] Bringup CPU144 left 112
[   11.869090] Detected PIPT I-cache on CPU144
[   11.869258] GICv3: CPU144: found redistributor 11000 region 1:0x00000004=
41800000
[   11.869271] GICv3: CPU144: using allocated LPI pending table @0x00000008=
81200000
[   11.869341] CPU144: Booted secondary processor 0x0000011000 [0x431f0af1]
[   11.869491] Bringup CPU144 0
[   11.869495] Bringup CPU145 left 111
[   12.034171] Detected PIPT I-cache on CPU145
[   12.034340] GICv3: CPU145: found redistributor 11100 region 1:0x00000004=
41880000
[   12.034353] GICv3: CPU145: using allocated LPI pending table @0x00000008=
81210000
[   12.034423] CPU145: Booted secondary processor 0x0000011100 [0x431f0af1]
[   12.034650] Bringup CPU145 0
[   12.034654] Bringup CPU146 left 110
[   12.200891] Detected PIPT I-cache on CPU146
[   12.201062] GICv3: CPU146: found redistributor 11200 region 1:0x00000004=
41900000
[   12.201075] GICv3: CPU146: using allocated LPI pending table @0x00000008=
81220000
[   12.201144] CPU146: Booted secondary processor 0x0000011200 [0x431f0af1]
[   12.201300] Bringup CPU146 0
[   12.201304] Bringup CPU147 left 109
[   12.366599] Detected PIPT I-cache on CPU147
[   12.366771] GICv3: CPU147: found redistributor 11300 region 1:0x00000004=
41980000
[   12.366784] GICv3: CPU147: using allocated LPI pending table @0x00000008=
81230000
[   12.366854] CPU147: Booted secondary processor 0x0000011300 [0x431f0af1]
[   12.367007] Bringup CPU147 0
[   12.367011] Bringup CPU148 left 108
[   12.532735] Detected PIPT I-cache on CPU148
[   12.532911] GICv3: CPU148: found redistributor 11400 region 1:0x00000004=
41a00000
[   12.532924] GICv3: CPU148: using allocated LPI pending table @0x00000008=
81240000
[   12.532994] CPU148: Booted secondary processor 0x0000011400 [0x431f0af1]
[   12.533147] Bringup CPU148 0
[   12.533151] Bringup CPU149 left 107
[   12.699101] Detected PIPT I-cache on CPU149
[   12.699279] GICv3: CPU149: found redistributor 11500 region 1:0x00000004=
41a80000
[   12.699292] GICv3: CPU149: using allocated LPI pending table @0x00000008=
81250000
[   12.699363] CPU149: Booted secondary processor 0x0000011500 [0x431f0af1]
[   12.699518] Bringup CPU149 0
[   12.699522] Bringup CPU150 left 106
[   12.864456] Detected PIPT I-cache on CPU150
[   12.864634] GICv3: CPU150: found redistributor 11600 region 1:0x00000004=
41b00000
[   12.864647] GICv3: CPU150: using allocated LPI pending table @0x00000008=
81260000
[   12.864717] CPU150: Booted secondary processor 0x0000011600 [0x431f0af1]
[   12.864871] Bringup CPU150 0
[   12.864874] Bringup CPU151 left 105
[   13.032476] Detected PIPT I-cache on CPU151
[   13.032656] GICv3: CPU151: found redistributor 11700 region 1:0x00000004=
41b80000
[   13.032669] GICv3: CPU151: using allocated LPI pending table @0x00000008=
81270000
[   13.032739] CPU151: Booted secondary processor 0x0000011700 [0x431f0af1]
[   13.032893] Bringup CPU151 0
[   13.032897] Bringup CPU152 left 104
[   13.200736] Detected PIPT I-cache on CPU152
[   13.200918] GICv3: CPU152: found redistributor 11800 region 1:0x00000004=
41c00000
[   13.200931] GICv3: CPU152: using allocated LPI pending table @0x00000008=
81280000
[   13.201003] CPU152: Booted secondary processor 0x0000011800 [0x431f0af1]
[   13.201234] Bringup CPU152 0
[   13.201238] Bringup CPU153 left 103
[   13.369144] Detected PIPT I-cache on CPU153
[   13.369326] GICv3: CPU153: found redistributor 11900 region 1:0x00000004=
41c80000
[   13.369338] GICv3: CPU153: using allocated LPI pending table @0x00000008=
81290000
[   13.369410] CPU153: Booted secondary processor 0x0000011900 [0x431f0af1]
[   13.369566] Bringup CPU153 0
[   13.369570] Bringup CPU154 left 102
[   13.537130] Detected PIPT I-cache on CPU154
[   13.537316] GICv3: CPU154: found redistributor 11a00 region 1:0x00000004=
41d00000
[   13.537328] GICv3: CPU154: using allocated LPI pending table @0x00000008=
812a0000
[   13.537398] CPU154: Booted secondary processor 0x0000011a00 [0x431f0af1]
[   13.537551] Bringup CPU154 0
[   13.537555] Bringup CPU155 left 101
[   13.704667] Detected PIPT I-cache on CPU155
[   13.704852] GICv3: CPU155: found redistributor 11b00 region 1:0x00000004=
41d80000
[   13.704865] GICv3: CPU155: using allocated LPI pending table @0x00000008=
812b0000
[   13.704935] CPU155: Booted secondary processor 0x0000011b00 [0x431f0af1]
[   13.705088] Bringup CPU155 0
[   13.705091] Bringup CPU156 left 100
[   13.873414] Detected PIPT I-cache on CPU156
[   13.873602] GICv3: CPU156: found redistributor 11c00 region 1:0x00000004=
41e00000
[   13.873615] GICv3: CPU156: using allocated LPI pending table @0x00000008=
812c0000
[   13.873685] CPU156: Booted secondary processor 0x0000011c00 [0x431f0af1]
[   13.873841] Bringup CPU156 0
[   13.873845] Bringup CPU157 left 99
[   14.041030] Detected PIPT I-cache on CPU157
[   14.041223] GICv3: CPU157: found redistributor 11d00 region 1:0x00000004=
41e80000
[   14.041235] GICv3: CPU157: using allocated LPI pending table @0x00000008=
812d0000
[   14.041306] CPU157: Booted secondary processor 0x0000011d00 [0x431f0af1]
[   14.041458] Bringup CPU157 0
[   14.041462] Bringup CPU158 left 98
[   14.209238] Detected PIPT I-cache on CPU158
[   14.209434] GICv3: CPU158: found redistributor 11e00 region 1:0x00000004=
41f00000
[   14.209446] GICv3: CPU158: using allocated LPI pending table @0x00000008=
812e0000
[   14.209516] CPU158: Booted secondary processor 0x0000011e00 [0x431f0af1]
[   14.209751] Bringup CPU158 0
[   14.209755] Bringup CPU159 left 97
[   14.375193] Detected PIPT I-cache on CPU159
[   14.375393] GICv3: CPU159: found redistributor 11f00 region 1:0x00000004=
41f80000
[   14.375405] GICv3: CPU159: using allocated LPI pending table @0x00000008=
812f0000
[   14.375475] CPU159: Booted secondary processor 0x0000011f00 [0x431f0af1]
[   14.375633] Bringup CPU159 0
[   14.375637] Bringup CPU160 left 96
[   14.530664] Detected PIPT I-cache on CPU160
[   14.530800] GICv3: CPU160: found redistributor 10001 region 1:0x00000004=
41020000
[   14.530812] GICv3: CPU160: using allocated LPI pending table @0x00000008=
81300000
[   14.530880] CPU160: Booted secondary processor 0x0000010001 [0x431f0af1]
[   14.531019] Bringup CPU160 0
[   14.531022] Bringup CPU161 left 95
[   14.686047] Detected PIPT I-cache on CPU161
[   14.686189] GICv3: CPU161: found redistributor 10101 region 1:0x00000004=
410a0000
[   14.686200] GICv3: CPU161: using allocated LPI pending table @0x00000008=
81310000
[   14.686269] CPU161: Booted secondary processor 0x0000010101 [0x431f0af1]
[   14.686405] Bringup CPU161 0
[   14.686409] Bringup CPU162 left 94
[   14.841025] Detected PIPT I-cache on CPU162
[   14.841168] GICv3: CPU162: found redistributor 10201 region 1:0x00000004=
41120000
[   14.841179] GICv3: CPU162: using allocated LPI pending table @0x00000008=
81320000
[   14.841247] CPU162: Booted secondary processor 0x0000010201 [0x431f0af1]
[   14.841380] Bringup CPU162 0
[   14.841384] Bringup CPU163 left 93
[   14.996501] Detected PIPT I-cache on CPU163
[   14.996648] GICv3: CPU163: found redistributor 10301 region 1:0x00000004=
411a0000
[   14.996660] GICv3: CPU163: using allocated LPI pending table @0x00000008=
81330000
[   14.996726] CPU163: Booted secondary processor 0x0000010301 [0x431f0af1]
[   14.996868] Bringup CPU163 0
[   14.996871] Bringup CPU164 left 92
[   15.151407] Detected PIPT I-cache on CPU164
[   15.151552] GICv3: CPU164: found redistributor 10401 region 1:0x00000004=
41220000
[   15.151564] GICv3: CPU164: using allocated LPI pending table @0x00000008=
81340000
[   15.151633] CPU164: Booted secondary processor 0x0000010401 [0x431f0af1]
[   15.151776] Bringup CPU164 0
[   15.151780] Bringup CPU165 left 91
[   15.306915] Detected PIPT I-cache on CPU165
[   15.307063] GICv3: CPU165: found redistributor 10501 region 1:0x00000004=
412a0000
[   15.307075] GICv3: CPU165: using allocated LPI pending table @0x00000008=
81350000
[   15.307141] CPU165: Booted secondary processor 0x0000010501 [0x431f0af1]
[   15.307364] Bringup CPU165 0
[   15.307368] Bringup CPU166 left 90
[   15.461950] Detected PIPT I-cache on CPU166
[   15.462101] GICv3: CPU166: found redistributor 10601 region 1:0x00000004=
41320000
[   15.462113] GICv3: CPU166: using allocated LPI pending table @0x00000008=
81360000
[   15.462180] CPU166: Booted secondary processor 0x0000010601 [0x431f0af1]
[   15.462325] Bringup CPU166 0
[   15.462328] Bringup CPU167 left 89
[   15.616738] Detected PIPT I-cache on CPU167
[   15.616891] GICv3: CPU167: found redistributor 10701 region 1:0x00000004=
413a0000
[   15.616903] GICv3: CPU167: using allocated LPI pending table @0x00000008=
81370000
[   15.616971] CPU167: Booted secondary processor 0x0000010701 [0x431f0af1]
[   15.617107] Bringup CPU167 0
[   15.617111] Bringup CPU168 left 88
[   15.771979] Detected PIPT I-cache on CPU168
[   15.772133] GICv3: CPU168: found redistributor 10801 region 1:0x00000004=
41420000
[   15.772145] GICv3: CPU168: using allocated LPI pending table @0x00000008=
81380000
[   15.772215] CPU168: Booted secondary processor 0x0000010801 [0x431f0af1]
[   15.772355] Bringup CPU168 0
[   15.772359] Bringup CPU169 left 87
[   15.927422] Detected PIPT I-cache on CPU169
[   15.927578] GICv3: CPU169: found redistributor 10901 region 1:0x00000004=
414a0000
[   15.927590] GICv3: CPU169: using allocated LPI pending table @0x00000008=
81390000
[   15.927659] CPU169: Booted secondary processor 0x0000010901 [0x431f0af1]
[   15.927796] Bringup CPU169 0
[   15.927799] Bringup CPU170 left 86
[   16.082419] Detected PIPT I-cache on CPU170
[   16.082581] GICv3: CPU170: found redistributor 10a01 region 1:0x00000004=
41520000
[   16.082592] GICv3: CPU170: using allocated LPI pending table @0x00000008=
813a0000
[   16.082660] CPU170: Booted secondary processor 0x0000010a01 [0x431f0af1]
[   16.082800] Bringup CPU170 0
[   16.082803] Bringup CPU171 left 85
[   16.238203] Detected PIPT I-cache on CPU171
[   16.238364] GICv3: CPU171: found redistributor 10b01 region 1:0x00000004=
415a0000
[   16.238376] GICv3: CPU171: using allocated LPI pending table @0x00000008=
813b0000
[   16.238445] CPU171: Booted secondary processor 0x0000010b01 [0x431f0af1]
[   16.238585] Bringup CPU171 0
[   16.238589] Bringup CPU172 left 84
[   16.393091] Detected PIPT I-cache on CPU172
[   16.393253] GICv3: CPU172: found redistributor 10c01 region 1:0x00000004=
41620000
[   16.393265] GICv3: CPU172: using allocated LPI pending table @0x00000008=
813c0000
[   16.393334] CPU172: Booted secondary processor 0x0000010c01 [0x431f0af1]
[   16.393560] Bringup CPU172 0
[   16.393564] Bringup CPU173 left 83
[   16.548527] Detected PIPT I-cache on CPU173
[   16.548690] GICv3: CPU173: found redistributor 10d01 region 1:0x00000004=
416a0000
[   16.548702] GICv3: CPU173: using allocated LPI pending table @0x00000008=
813d0000
[   16.548769] CPU173: Booted secondary processor 0x0000010d01 [0x431f0af1]
[   16.548917] Bringup CPU173 0
[   16.548920] Bringup CPU174 left 82
[   16.703287] Detected PIPT I-cache on CPU174
[   16.703458] GICv3: CPU174: found redistributor 10e01 region 1:0x00000004=
41720000
[   16.703470] GICv3: CPU174: using allocated LPI pending table @0x00000008=
813e0000
[   16.703537] CPU174: Booted secondary processor 0x0000010e01 [0x431f0af1]
[   16.703675] Bringup CPU174 0
[   16.703678] Bringup CPU175 left 81
[   16.858143] Detected PIPT I-cache on CPU175
[   16.858311] GICv3: CPU175: found redistributor 10f01 region 1:0x00000004=
417a0000
[   16.858323] GICv3: CPU175: using allocated LPI pending table @0x00000008=
813f0000
[   16.858391] CPU175: Booted secondary processor 0x0000010f01 [0x431f0af1]
[   16.858533] Bringup CPU175 0
[   16.858536] Bringup CPU176 left 80
[   17.013712] Detected PIPT I-cache on CPU176
[   17.013881] GICv3: CPU176: found redistributor 11001 region 1:0x00000004=
41820000
[   17.013893] GICv3: CPU176: using allocated LPI pending table @0x00000008=
81400000
[   17.013960] CPU176: Booted secondary processor 0x0000011001 [0x431f0af1]
[   17.014098] Bringup CPU176 0
[   17.014101] Bringup CPU177 left 79
[   17.169073] Detected PIPT I-cache on CPU177
[   17.169243] GICv3: CPU177: found redistributor 11101 region 1:0x00000004=
418a0000
[   17.169255] GICv3: CPU177: using allocated LPI pending table @0x00000008=
81410000
[   17.169323] CPU177: Booted secondary processor 0x0000011101 [0x431f0af1]
[   17.169459] Bringup CPU177 0
[   17.169463] Bringup CPU178 left 78
[   17.324558] Detected PIPT I-cache on CPU178
[   17.324730] GICv3: CPU178: found redistributor 11201 region 1:0x00000004=
41920000
[   17.324742] GICv3: CPU178: using allocated LPI pending table @0x00000008=
81420000
[   17.324809] CPU178: Booted secondary processor 0x0000011201 [0x431f0af1]
[   17.325040] Bringup CPU178 0
[   17.325043] Bringup CPU179 left 77
[   17.479665] Detected PIPT I-cache on CPU179
[   17.479840] GICv3: CPU179: found redistributor 11301 region 1:0x00000004=
419a0000
[   17.479852] GICv3: CPU179: using allocated LPI pending table @0x00000008=
81430000
[   17.479923] CPU179: Booted secondary processor 0x0000011301 [0x431f0af1]
[   17.480070] Bringup CPU179 0
[   17.480074] Bringup CPU180 left 76
[   17.634812] Detected PIPT I-cache on CPU180
[   17.634993] GICv3: CPU180: found redistributor 11401 region 1:0x00000004=
41a20000
[   17.635005] GICv3: CPU180: using allocated LPI pending table @0x00000008=
81440000
[   17.635073] CPU180: Booted secondary processor 0x0000011401 [0x431f0af1]
[   17.635216] Bringup CPU180 0
[   17.635219] Bringup CPU181 left 75
[   17.790362] Detected PIPT I-cache on CPU181
[   17.790547] GICv3: CPU181: found redistributor 11501 region 1:0x00000004=
41aa0000
[   17.790559] GICv3: CPU181: using allocated LPI pending table @0x00000008=
81450000
[   17.790627] CPU181: Booted secondary processor 0x0000011501 [0x431f0af1]
[   17.790770] Bringup CPU181 0
[   17.790774] Bringup CPU182 left 74
[   17.945435] Detected PIPT I-cache on CPU182
[   17.945616] GICv3: CPU182: found redistributor 11601 region 1:0x00000004=
41b20000
[   17.945628] GICv3: CPU182: using allocated LPI pending table @0x00000008=
81460000
[   17.945695] CPU182: Booted secondary processor 0x0000011601 [0x431f0af1]
[   17.945839] Bringup CPU182 0
[   17.945842] Bringup CPU183 left 73
[   18.100344] Detected PIPT I-cache on CPU183
[   18.100525] GICv3: CPU183: found redistributor 11701 region 1:0x00000004=
41ba0000
[   18.100537] GICv3: CPU183: using allocated LPI pending table @0x00000008=
81470000
[   18.100606] CPU183: Booted secondary processor 0x0000011701 [0x431f0af1]
[   18.100751] Bringup CPU183 0
[   18.100755] Bringup CPU184 left 72
[   18.255485] Detected PIPT I-cache on CPU184
[   18.255675] GICv3: CPU184: found redistributor 11801 region 1:0x00000004=
41c20000
[   18.255688] GICv3: CPU184: using allocated LPI pending table @0x00000008=
81480000
[   18.255755] CPU184: Booted secondary processor 0x0000011801 [0x431f0af1]
[   18.255896] Bringup CPU184 0
[   18.255899] Bringup CPU185 left 71
[   18.410979] Detected PIPT I-cache on CPU185
[   18.411166] GICv3: CPU185: found redistributor 11901 region 1:0x00000004=
41ca0000
[   18.411178] GICv3: CPU185: using allocated LPI pending table @0x00000008=
81490000
[   18.411246] CPU185: Booted secondary processor 0x0000011901 [0x431f0af1]
[   18.411485] Bringup CPU185 0
[   18.411489] Bringup CPU186 left 70
[   18.566521] Detected PIPT I-cache on CPU186
[   18.566712] GICv3: CPU186: found redistributor 11a01 region 1:0x00000004=
41d20000
[   18.566724] GICv3: CPU186: using allocated LPI pending table @0x00000008=
814a0000
[   18.566791] CPU186: Booted secondary processor 0x0000011a01 [0x431f0af1]
[   18.566944] Bringup CPU186 0
[   18.566947] Bringup CPU187 left 69
[   18.721510] Detected PIPT I-cache on CPU187
[   18.721706] GICv3: CPU187: found redistributor 11b01 region 1:0x00000004=
41da0000
[   18.721718] GICv3: CPU187: using allocated LPI pending table @0x00000008=
814b0000
[   18.721787] CPU187: Booted secondary processor 0x0000011b01 [0x431f0af1]
[   18.721931] Bringup CPU187 0
[   18.721934] Bringup CPU188 left 68
[   18.877191] Detected PIPT I-cache on CPU188
[   18.877386] GICv3: CPU188: found redistributor 11c01 region 1:0x00000004=
41e20000
[   18.877399] GICv3: CPU188: using allocated LPI pending table @0x00000008=
814c0000
[   18.877467] CPU188: Booted secondary processor 0x0000011c01 [0x431f0af1]
[   18.877612] Bringup CPU188 0
[   18.877616] Bringup CPU189 left 67
[   19.032656] Detected PIPT I-cache on CPU189
[   19.032852] GICv3: CPU189: found redistributor 11d01 region 1:0x00000004=
41ea0000
[   19.032863] GICv3: CPU189: using allocated LPI pending table @0x00000008=
814d0000
[   19.032931] CPU189: Booted secondary processor 0x0000011d01 [0x431f0af1]
[   19.033071] Bringup CPU189 0
[   19.033074] Bringup CPU190 left 66
[   19.188112] Detected PIPT I-cache on CPU190
[   19.188314] GICv3: CPU190: found redistributor 11e01 region 1:0x00000004=
41f20000
[   19.188326] GICv3: CPU190: using allocated LPI pending table @0x00000008=
814e0000
[   19.188394] CPU190: Booted secondary processor 0x0000011e01 [0x431f0af1]
[   19.188532] Bringup CPU190 0
[   19.188536] Bringup CPU191 left 65
[   19.343549] Detected PIPT I-cache on CPU191
[   19.343747] GICv3: CPU191: found redistributor 11f01 region 1:0x00000004=
41fa0000
[   19.343759] GICv3: CPU191: using allocated LPI pending table @0x00000008=
814f0000
[   19.343826] CPU191: Booted secondary processor 0x0000011f01 [0x431f0af1]
[   19.344062] Bringup CPU191 0
[   19.344066] Bringup CPU192 left 64
[   19.499181] Detected PIPT I-cache on CPU192
[   19.499333] GICv3: CPU192: found redistributor 10002 region 1:0x00000004=
41040000
[   19.499344] GICv3: CPU192: using allocated LPI pending table @0x00000008=
81500000
[   19.499410] CPU192: Booted secondary processor 0x0000010002 [0x431f0af1]
[   19.499555] Bringup CPU192 0
[   19.499559] Bringup CPU193 left 63
[   19.654687] Detected PIPT I-cache on CPU193
[   19.654833] GICv3: CPU193: found redistributor 10102 region 1:0x00000004=
410c0000
[   19.654845] GICv3: CPU193: using allocated LPI pending table @0x00000008=
81510000
[   19.654914] CPU193: Booted secondary processor 0x0000010102 [0x431f0af1]
[   19.655055] Bringup CPU193 0
[   19.655058] Bringup CPU194 left 62
[   19.809738] Detected PIPT I-cache on CPU194
[   19.809888] GICv3: CPU194: found redistributor 10202 region 1:0x00000004=
41140000
[   19.809899] GICv3: CPU194: using allocated LPI pending table @0x00000008=
81520000
[   19.809966] CPU194: Booted secondary processor 0x0000010202 [0x431f0af1]
[   19.810110] Bringup CPU194 0
[   19.810114] Bringup CPU195 left 61
[   19.964932] Detected PIPT I-cache on CPU195
[   19.965086] GICv3: CPU195: found redistributor 10302 region 1:0x00000004=
411c0000
[   19.965097] GICv3: CPU195: using allocated LPI pending table @0x00000008=
81530000
[   19.965164] CPU195: Booted secondary processor 0x0000010302 [0x431f0af1]
[   19.965304] Bringup CPU195 0
[   19.965307] Bringup CPU196 left 60
[   20.119941] Detected PIPT I-cache on CPU196
[   20.120094] GICv3: CPU196: found redistributor 10402 region 1:0x00000004=
41240000
[   20.120106] GICv3: CPU196: using allocated LPI pending table @0x00000008=
81540000
[   20.120174] CPU196: Booted secondary processor 0x0000010402 [0x431f0af1]
[   20.120315] Bringup CPU196 0
[   20.120319] Bringup CPU197 left 59
[   20.275680] Detected PIPT I-cache on CPU197
[   20.275841] GICv3: CPU197: found redistributor 10502 region 1:0x00000004=
412c0000
[   20.275852] GICv3: CPU197: using allocated LPI pending table @0x00000008=
81550000
[   20.275919] CPU197: Booted secondary processor 0x0000010502 [0x431f0af1]
[   20.276064] Bringup CPU197 0
[   20.276068] Bringup CPU198 left 58
[   20.430754] Detected PIPT I-cache on CPU198
[   20.430913] GICv3: CPU198: found redistributor 10602 region 1:0x00000004=
41340000
[   20.430924] GICv3: CPU198: using allocated LPI pending table @0x00000008=
81560000
[   20.430992] CPU198: Booted secondary processor 0x0000010602 [0x431f0af1]
[   20.431230] Bringup CPU198 0
[   20.431234] Bringup CPU199 left 57
[   20.585910] Detected PIPT I-cache on CPU199
[   20.586072] GICv3: CPU199: found redistributor 10702 region 1:0x00000004=
413c0000
[   20.586085] GICv3: CPU199: using allocated LPI pending table @0x00000008=
81570000
[   20.586150] CPU199: Booted secondary processor 0x0000010702 [0x431f0af1]
[   20.586298] Bringup CPU199 0
[   20.586301] Bringup CPU200 left 56
[   20.741300] Detected PIPT I-cache on CPU200
[   20.741469] GICv3: CPU200: found redistributor 10802 region 1:0x00000004=
41440000
[   20.741481] GICv3: CPU200: using allocated LPI pending table @0x00000008=
81580000
[   20.741548] CPU200: Booted secondary processor 0x0000010802 [0x431f0af1]
[   20.741690] Bringup CPU200 0
[   20.741694] Bringup CPU201 left 55
[   20.896632] Detected PIPT I-cache on CPU201
[   20.896796] GICv3: CPU201: found redistributor 10902 region 1:0x00000004=
414c0000
[   20.896808] GICv3: CPU201: using allocated LPI pending table @0x00000008=
81590000
[   20.896874] CPU201: Booted secondary processor 0x0000010902 [0x431f0af1]
[   20.897016] Bringup CPU201 0
[   20.897020] Bringup CPU202 left 54
[   21.051752] Detected PIPT I-cache on CPU202
[   21.051918] GICv3: CPU202: found redistributor 10a02 region 1:0x00000004=
41540000
[   21.051930] GICv3: CPU202: using allocated LPI pending table @0x00000008=
815a0000
[   21.051998] CPU202: Booted secondary processor 0x0000010a02 [0x431f0af1]
[   21.052138] Bringup CPU202 0
[   21.052142] Bringup CPU203 left 53
[   21.207990] Detected PIPT I-cache on CPU203
[   21.208156] GICv3: CPU203: found redistributor 10b02 region 1:0x00000004=
415c0000
[   21.208168] GICv3: CPU203: using allocated LPI pending table @0x00000008=
815b0000
[   21.208235] CPU203: Booted secondary processor 0x0000010b02 [0x431f0af1]
[   21.208377] Bringup CPU203 0
[   21.208380] Bringup CPU204 left 52
[   21.363111] Detected PIPT I-cache on CPU204
[   21.363279] GICv3: CPU204: found redistributor 10c02 region 1:0x00000004=
41640000
[   21.363292] GICv3: CPU204: using allocated LPI pending table @0x00000008=
815c0000
[   21.363359] CPU204: Booted secondary processor 0x0000010c02 [0x431f0af1]
[   21.363598] Bringup CPU204 0
[   21.363601] Bringup CPU205 left 51
[   21.518927] Detected PIPT I-cache on CPU205
[   21.519098] GICv3: CPU205: found redistributor 10d02 region 1:0x00000004=
416c0000
[   21.519110] GICv3: CPU205: using allocated LPI pending table @0x00000008=
815d0000
[   21.519177] CPU205: Booted secondary processor 0x0000010d02 [0x431f0af1]
[   21.519326] Bringup CPU205 0
[   21.519329] Bringup CPU206 left 50
[   21.673907] Detected PIPT I-cache on CPU206
[   21.674079] GICv3: CPU206: found redistributor 10e02 region 1:0x00000004=
41740000
[   21.674091] GICv3: CPU206: using allocated LPI pending table @0x00000008=
815e0000
[   21.674158] CPU206: Booted secondary processor 0x0000010e02 [0x431f0af1]
[   21.674299] Bringup CPU206 0
[   21.674302] Bringup CPU207 left 49
[   21.828905] Detected PIPT I-cache on CPU207
[   21.829083] GICv3: CPU207: found redistributor 10f02 region 1:0x00000004=
417c0000
[   21.829095] GICv3: CPU207: using allocated LPI pending table @0x00000008=
815f0000
[   21.829162] CPU207: Booted secondary processor 0x0000010f02 [0x431f0af1]
[   21.829303] Bringup CPU207 0
[   21.829307] Bringup CPU208 left 48
[   21.984625] Detected PIPT I-cache on CPU208
[   21.984804] GICv3: CPU208: found redistributor 11002 region 1:0x00000004=
41840000
[   21.984817] GICv3: CPU208: using allocated LPI pending table @0x00000008=
81600000
[   21.984883] CPU208: Booted secondary processor 0x0000011002 [0x431f0af1]
[   21.985027] Bringup CPU208 0
[   21.985030] Bringup CPU209 left 47
[   22.140149] Detected PIPT I-cache on CPU209
[   22.140328] GICv3: CPU209: found redistributor 11102 region 1:0x00000004=
418c0000
[   22.140340] GICv3: CPU209: using allocated LPI pending table @0x00000008=
81610000
[   22.140407] CPU209: Booted secondary processor 0x0000011102 [0x431f0af1]
[   22.140551] Bringup CPU209 0
[   22.140554] Bringup CPU210 left 46
[   22.295766] Detected PIPT I-cache on CPU210
[   22.295948] GICv3: CPU210: found redistributor 11202 region 1:0x00000004=
41940000
[   22.295960] GICv3: CPU210: using allocated LPI pending table @0x00000008=
81620000
[   22.296028] CPU210: Booted secondary processor 0x0000011202 [0x431f0af1]
[   22.296176] Bringup CPU210 0
[   22.296180] Bringup CPU211 left 45
[   22.450955] Detected PIPT I-cache on CPU211
[   22.451137] GICv3: CPU211: found redistributor 11302 region 1:0x00000004=
419c0000
[   22.451150] GICv3: CPU211: using allocated LPI pending table @0x00000008=
81630000
[   22.451216] CPU211: Booted secondary processor 0x0000011302 [0x431f0af1]
[   22.451467] Bringup CPU211 0
[   22.451471] Bringup CPU212 left 44
[   22.606322] Detected PIPT I-cache on CPU212
[   22.606507] GICv3: CPU212: found redistributor 11402 region 1:0x00000004=
41a40000
[   22.606519] GICv3: CPU212: using allocated LPI pending table @0x00000008=
81640000
[   22.606587] CPU212: Booted secondary processor 0x0000011402 [0x431f0af1]
[   22.606742] Bringup CPU212 0
[   22.606746] Bringup CPU213 left 43
[   22.762153] Detected PIPT I-cache on CPU213
[   22.762342] GICv3: CPU213: found redistributor 11502 region 1:0x00000004=
41ac0000
[   22.762354] GICv3: CPU213: using allocated LPI pending table @0x00000008=
81650000
[   22.762422] CPU213: Booted secondary processor 0x0000011502 [0x431f0af1]
[   22.762565] Bringup CPU213 0
[   22.762569] Bringup CPU214 left 42
[   22.917237] Detected PIPT I-cache on CPU214
[   22.917427] GICv3: CPU214: found redistributor 11602 region 1:0x00000004=
41b40000
[   22.917439] GICv3: CPU214: using allocated LPI pending table @0x00000008=
81660000
[   22.917506] CPU214: Booted secondary processor 0x0000011602 [0x431f0af1]
[   22.917647] Bringup CPU214 0
[   22.917651] Bringup CPU215 left 41
[   23.072267] Detected PIPT I-cache on CPU215
[   23.072458] GICv3: CPU215: found redistributor 11702 region 1:0x00000004=
41bc0000
[   23.072470] GICv3: CPU215: using allocated LPI pending table @0x00000008=
81670000
[   23.072537] CPU215: Booted secondary processor 0x0000011702 [0x431f0af1]
[   23.072678] Bringup CPU215 0
[   23.072682] Bringup CPU216 left 40
[   23.227546] Detected PIPT I-cache on CPU216
[   23.227739] GICv3: CPU216: found redistributor 11802 region 1:0x00000004=
41c40000
[   23.227752] GICv3: CPU216: using allocated LPI pending table @0x00000008=
81680000
[   23.227818] CPU216: Booted secondary processor 0x0000011802 [0x431f0af1]
[   23.227963] Bringup CPU216 0
[   23.227966] Bringup CPU217 left 39
[   23.383191] Detected PIPT I-cache on CPU217
[   23.383384] GICv3: CPU217: found redistributor 11902 region 1:0x00000004=
41cc0000
[   23.383396] GICv3: CPU217: using allocated LPI pending table @0x00000008=
81690000
[   23.383464] CPU217: Booted secondary processor 0x0000011902 [0x431f0af1]
[   23.383608] Bringup CPU217 0
[   23.383612] Bringup CPU218 left 38
[   23.538788] Detected PIPT I-cache on CPU218
[   23.538985] GICv3: CPU218: found redistributor 11a02 region 1:0x00000004=
41d40000
[   23.538997] GICv3: CPU218: using allocated LPI pending table @0x00000008=
816a0000
[   23.539066] CPU218: Booted secondary processor 0x0000011a02 [0x431f0af1]
[   23.539317] Bringup CPU218 0
[   23.539321] Bringup CPU219 left 37
[   23.694100] Detected PIPT I-cache on CPU219
[   23.694299] GICv3: CPU219: found redistributor 11b02 region 1:0x00000004=
41dc0000
[   23.694312] GICv3: CPU219: using allocated LPI pending table @0x00000008=
816b0000
[   23.694380] CPU219: Booted secondary processor 0x0000011b02 [0x431f0af1]
[   23.694532] Bringup CPU219 0
[   23.694536] Bringup CPU220 left 36
[   23.850295] Detected PIPT I-cache on CPU220
[   23.850496] GICv3: CPU220: found redistributor 11c02 region 1:0x00000004=
41e40000
[   23.850509] GICv3: CPU220: using allocated LPI pending table @0x00000008=
816c0000
[   23.850576] CPU220: Booted secondary processor 0x0000011c02 [0x431f0af1]
[   23.850723] Bringup CPU220 0
[   23.850727] Bringup CPU221 left 35
[   24.005688] Detected PIPT I-cache on CPU221
[   24.005888] GICv3: CPU221: found redistributor 11d02 region 1:0x00000004=
41ec0000
[   24.005901] GICv3: CPU221: using allocated LPI pending table @0x00000008=
816d0000
[   24.005968] CPU221: Booted secondary processor 0x0000011d02 [0x431f0af1]
[   24.006112] Bringup CPU221 0
[   24.006115] Bringup CPU222 left 34
[   24.161241] Detected PIPT I-cache on CPU222
[   24.161448] GICv3: CPU222: found redistributor 11e02 region 1:0x00000004=
41f40000
[   24.161461] GICv3: CPU222: using allocated LPI pending table @0x00000008=
816e0000
[   24.161529] CPU222: Booted secondary processor 0x0000011e02 [0x431f0af1]
[   24.161672] Bringup CPU222 0
[   24.161675] Bringup CPU223 left 33
[   24.316729] Detected PIPT I-cache on CPU223
[   24.316935] GICv3: CPU223: found redistributor 11f02 region 1:0x00000004=
41fc0000
[   24.316948] GICv3: CPU223: using allocated LPI pending table @0x00000008=
816f0000
[   24.317015] CPU223: Booted secondary processor 0x0000011f02 [0x431f0af1]
[   24.317163] Bringup CPU223 0
[   24.317167] Bringup CPU224 left 32
[   24.472373] Detected PIPT I-cache on CPU224
[   24.472527] GICv3: CPU224: found redistributor 10003 region 1:0x00000004=
41060000
[   24.472540] GICv3: CPU224: using allocated LPI pending table @0x00000008=
81700000
[   24.472606] CPU224: Booted secondary processor 0x0000010003 [0x431f0af1]
[   24.472865] Bringup CPU224 0
[   24.472869] Bringup CPU225 left 31
[   24.628094] Detected PIPT I-cache on CPU225
[   24.628251] GICv3: CPU225: found redistributor 10103 region 1:0x00000004=
410e0000
[   24.628263] GICv3: CPU225: using allocated LPI pending table @0x00000008=
81710000
[   24.628331] CPU225: Booted secondary processor 0x0000010103 [0x431f0af1]
[   24.628485] Bringup CPU225 0
[   24.628489] Bringup CPU226 left 30
[   24.783218] Detected PIPT I-cache on CPU226
[   24.783376] GICv3: CPU226: found redistributor 10203 region 1:0x00000004=
41160000
[   24.783389] GICv3: CPU226: using allocated LPI pending table @0x00000008=
81720000
[   24.783455] CPU226: Booted secondary processor 0x0000010203 [0x431f0af1]
[   24.783602] Bringup CPU226 0
[   24.783606] Bringup CPU227 left 29
[   24.938519] Detected PIPT I-cache on CPU227
[   24.938679] GICv3: CPU227: found redistributor 10303 region 1:0x00000004=
411e0000
[   24.938692] GICv3: CPU227: using allocated LPI pending table @0x00000008=
81730000
[   24.938758] CPU227: Booted secondary processor 0x0000010303 [0x431f0af1]
[   24.938902] Bringup CPU227 0
[   24.938906] Bringup CPU228 left 28
[   25.093622] Detected PIPT I-cache on CPU228
[   25.093789] GICv3: CPU228: found redistributor 10403 region 1:0x00000004=
41260000
[   25.093802] GICv3: CPU228: using allocated LPI pending table @0x00000008=
81740000
[   25.093868] CPU228: Booted secondary processor 0x0000010403 [0x431f0af1]
[   25.094015] Bringup CPU228 0
[   25.094019] Bringup CPU229 left 27
[   25.249382] Detected PIPT I-cache on CPU229
[   25.249548] GICv3: CPU229: found redistributor 10503 region 1:0x00000004=
412e0000
[   25.249560] GICv3: CPU229: using allocated LPI pending table @0x00000008=
81750000
[   25.249629] CPU229: Booted secondary processor 0x0000010503 [0x431f0af1]
[   25.249772] Bringup CPU229 0
[   25.249776] Bringup CPU230 left 26
[   25.404562] Detected PIPT I-cache on CPU230
[   25.404728] GICv3: CPU230: found redistributor 10603 region 1:0x00000004=
41360000
[   25.404741] GICv3: CPU230: using allocated LPI pending table @0x00000008=
81760000
[   25.404808] CPU230: Booted secondary processor 0x0000010603 [0x431f0af1]
[   25.404951] Bringup CPU230 0
[   25.404955] Bringup CPU231 left 25
[   25.559585] Detected PIPT I-cache on CPU231
[   25.559755] GICv3: CPU231: found redistributor 10703 region 1:0x00000004=
413e0000
[   25.559768] GICv3: CPU231: using allocated LPI pending table @0x00000008=
81770000
[   25.559837] CPU231: Booted secondary processor 0x0000010703 [0x431f0af1]
[   25.560097] Bringup CPU231 0
[   25.560101] Bringup CPU232 left 24
[   25.715151] Detected PIPT I-cache on CPU232
[   25.715321] GICv3: CPU232: found redistributor 10803 region 1:0x00000004=
41460000
[   25.715334] GICv3: CPU232: using allocated LPI pending table @0x00000008=
81780000
[   25.715404] CPU232: Booted secondary processor 0x0000010803 [0x431f0af1]
[   25.715556] Bringup CPU232 0
[   25.715560] Bringup CPU233 left 23
[   25.870587] Detected PIPT I-cache on CPU233
[   25.870759] GICv3: CPU233: found redistributor 10903 region 1:0x00000004=
414e0000
[   25.870771] GICv3: CPU233: using allocated LPI pending table @0x00000008=
81790000
[   25.870839] CPU233: Booted secondary processor 0x0000010903 [0x431f0af1]
[   25.870978] Bringup CPU233 0
[   25.870982] Bringup CPU234 left 22
[   26.026220] Detected PIPT I-cache on CPU234
[   26.026396] GICv3: CPU234: found redistributor 10a03 region 1:0x00000004=
41560000
[   26.026409] GICv3: CPU234: using allocated LPI pending table @0x00000008=
817a0000
[   26.026475] CPU234: Booted secondary processor 0x0000010a03 [0x431f0af1]
[   26.026623] Bringup CPU234 0
[   26.026627] Bringup CPU235 left 21
[   26.182382] Detected PIPT I-cache on CPU235
[   26.182559] GICv3: CPU235: found redistributor 10b03 region 1:0x00000004=
415e0000
[   26.182572] GICv3: CPU235: using allocated LPI pending table @0x00000008=
817b0000
[   26.182639] CPU235: Booted secondary processor 0x0000010b03 [0x431f0af1]
[   26.182782] Bringup CPU235 0
[   26.182785] Bringup CPU236 left 20
[   26.337520] Detected PIPT I-cache on CPU236
[   26.337697] GICv3: CPU236: found redistributor 10c03 region 1:0x00000004=
41660000
[   26.337711] GICv3: CPU236: using allocated LPI pending table @0x00000008=
817c0000
[   26.337777] CPU236: Booted secondary processor 0x0000010c03 [0x431f0af1]
[   26.337925] Bringup CPU236 0
[   26.337929] Bringup CPU237 left 19
[   26.493156] Detected PIPT I-cache on CPU237
[   26.493336] GICv3: CPU237: found redistributor 10d03 region 1:0x00000004=
416e0000
[   26.493349] GICv3: CPU237: using allocated LPI pending table @0x00000008=
817d0000
[   26.493418] CPU237: Booted secondary processor 0x0000010d03 [0x431f0af1]
[   26.493688] Bringup CPU237 0
[   26.493691] Bringup CPU238 left 18
[   26.648336] Detected PIPT I-cache on CPU238
[   26.648520] GICv3: CPU238: found redistributor 10e03 region 1:0x00000004=
41760000
[   26.648533] GICv3: CPU238: using allocated LPI pending table @0x00000008=
817e0000
[   26.648601] CPU238: Booted secondary processor 0x0000010e03 [0x431f0af1]
[   26.648757] Bringup CPU238 0
[   26.648761] Bringup CPU239 left 17
[   26.803436] Detected PIPT I-cache on CPU239
[   26.803620] GICv3: CPU239: found redistributor 10f03 region 1:0x00000004=
417e0000
[   26.803633] GICv3: CPU239: using allocated LPI pending table @0x00000008=
817f0000
[   26.803700] CPU239: Booted secondary processor 0x0000010f03 [0x431f0af1]
[   26.803842] Bringup CPU239 0
[   26.803845] Bringup CPU240 left 16
[   26.959245] Detected PIPT I-cache on CPU240
[   26.959431] GICv3: CPU240: found redistributor 11003 region 1:0x00000004=
41860000
[   26.959445] GICv3: CPU240: using allocated LPI pending table @0x00000008=
81800000
[   26.959513] CPU240: Booted secondary processor 0x0000011003 [0x431f0af1]
[   26.959656] Bringup CPU240 0
[   26.959660] Bringup CPU241 left 15
[   27.114861] Detected PIPT I-cache on CPU241
[   27.115049] GICv3: CPU241: found redistributor 11103 region 1:0x00000004=
418e0000
[   27.115061] GICv3: CPU241: using allocated LPI pending table @0x00000008=
81810000
[   27.115127] CPU241: Booted secondary processor 0x0000011103 [0x431f0af1]
[   27.115278] Bringup CPU241 0
[   27.115281] Bringup CPU242 left 14
[   27.270560] Detected PIPT I-cache on CPU242
[   27.270753] GICv3: CPU242: found redistributor 11203 region 1:0x00000004=
41960000
[   27.270767] GICv3: CPU242: using allocated LPI pending table @0x00000008=
81820000
[   27.270834] CPU242: Booted secondary processor 0x0000011203 [0x431f0af1]
[   27.270980] Bringup CPU242 0
[   27.270983] Bringup CPU243 left 13
[   27.426107] Detected PIPT I-cache on CPU243
[   27.426299] GICv3: CPU243: found redistributor 11303 region 1:0x00000004=
419e0000
[   27.426312] GICv3: CPU243: using allocated LPI pending table @0x00000008=
81830000
[   27.426380] CPU243: Booted secondary processor 0x0000011303 [0x431f0af1]
[   27.426525] Bringup CPU243 0
[   27.426529] Bringup CPU244 left 12
[   27.581504] Detected PIPT I-cache on CPU244
[   27.581699] GICv3: CPU244: found redistributor 11403 region 1:0x00000004=
41a60000
[   27.581713] GICv3: CPU244: using allocated LPI pending table @0x00000008=
81840000
[   27.581781] CPU244: Booted secondary processor 0x0000011403 [0x431f0af1]
[   27.582055] Bringup CPU244 0
[   27.582059] Bringup CPU245 left 11
[   27.737400] Detected PIPT I-cache on CPU245
[   27.737596] GICv3: CPU245: found redistributor 11503 region 1:0x00000004=
41ae0000
[   27.737608] GICv3: CPU245: using allocated LPI pending table @0x00000008=
81850000
[   27.737676] CPU245: Booted secondary processor 0x0000011503 [0x431f0af1]
[   27.737830] Bringup CPU245 0
[   27.737833] Bringup CPU246 left 10
[   27.892579] Detected PIPT I-cache on CPU246
[   27.892778] GICv3: CPU246: found redistributor 11603 region 1:0x00000004=
41b60000
[   27.892791] GICv3: CPU246: using allocated LPI pending table @0x00000008=
81860000
[   27.892857] CPU246: Booted secondary processor 0x0000011603 [0x431f0af1]
[   27.893004] Bringup CPU246 0
[   27.893008] Bringup CPU247 left 9
[   28.047725] Detected PIPT I-cache on CPU247
[   28.047925] GICv3: CPU247: found redistributor 11703 region 1:0x00000004=
41be0000
[   28.047938] GICv3: CPU247: using allocated LPI pending table @0x00000008=
81870000
[   28.048008] CPU247: Booted secondary processor 0x0000011703 [0x431f0af1]
[   28.048159] Bringup CPU247 0
[   28.048163] Bringup CPU248 left 8
[   28.203549] Detected PIPT I-cache on CPU248
[   28.203752] GICv3: CPU248: found redistributor 11803 region 1:0x00000004=
41c60000
[   28.203765] GICv3: CPU248: using allocated LPI pending table @0x00000008=
81880000
[   28.203831] CPU248: Booted secondary processor 0x0000011803 [0x431f0af1]
[   28.203976] Bringup CPU248 0
[   28.203980] Bringup CPU249 left 7
[   28.359259] Detected PIPT I-cache on CPU249
[   28.359465] GICv3: CPU249: found redistributor 11903 region 1:0x00000004=
41ce0000
[   28.359478] GICv3: CPU249: using allocated LPI pending table @0x00000008=
81890000
[   28.359546] CPU249: Booted secondary processor 0x0000011903 [0x431f0af1]
[   28.359696] Bringup CPU249 0
[   28.359699] Bringup CPU250 left 6
[   28.514990] Detected PIPT I-cache on CPU250
[   28.515196] GICv3: CPU250: found redistributor 11a03 region 1:0x00000004=
41d60000
[   28.515209] GICv3: CPU250: using allocated LPI pending table @0x00000008=
818a0000
[   28.515278] CPU250: Booted secondary processor 0x0000011a03 [0x431f0af1]
[   28.515427] Bringup CPU250 0
[   28.515431] Bringup CPU251 left 5
[   28.670202] Detected PIPT I-cache on CPU251
[   28.670410] GICv3: CPU251: found redistributor 11b03 region 1:0x00000004=
41de0000
[   28.670424] GICv3: CPU251: using allocated LPI pending table @0x00000008=
818b0000
[   28.670490] CPU251: Booted secondary processor 0x0000011b03 [0x431f0af1]
[   28.670764] Bringup CPU251 0
[   28.670767] Bringup CPU252 left 4
[   28.826271] Detected PIPT I-cache on CPU252
[   28.826482] GICv3: CPU252: found redistributor 11c03 region 1:0x00000004=
41e60000
[   28.826495] GICv3: CPU252: using allocated LPI pending table @0x00000008=
818c0000
[   28.826564] CPU252: Booted secondary processor 0x0000011c03 [0x431f0af1]
[   28.826721] Bringup CPU252 0
[   28.826725] Bringup CPU253 left 3
[   28.981779] Detected PIPT I-cache on CPU253
[   28.981990] GICv3: CPU253: found redistributor 11d03 region 1:0x00000004=
41ee0000
[   28.982003] GICv3: CPU253: using allocated LPI pending table @0x00000008=
818d0000
[   28.982071] CPU253: Booted secondary processor 0x0000011d03 [0x431f0af1]
[   28.982224] Bringup CPU253 0
[   28.982227] Bringup CPU254 left 2
[   29.137440] Detected PIPT I-cache on CPU254
[   29.137658] GICv3: CPU254: found redistributor 11e03 region 1:0x00000004=
41f60000
[   29.137671] GICv3: CPU254: using allocated LPI pending table @0x00000008=
818e0000
[   29.137737] CPU254: Booted secondary processor 0x0000011e03 [0x431f0af1]
[   29.137895] Bringup CPU254 0
[   29.137899] Bringup CPU255 left 1
[   29.137901] smp: Brought up 2 nodes, 255 CPUs
[   29.137904] SMP: Total of 255 processors activated.

--lnLTz5q6oum7yiEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRr7E4ACgkQJNaLcl1U
h9BNvgf/ftrexCGa7QYVeyqWe115HCddY0kTkMyPmo914XpHBkMRqLQepkpMpR/d
e07ZTuXjHbYtICJ+/1W2zHRqa2r4KmguwWOFCZtWgTLE+Zeb2bNOc29LjTUU9c1X
G1l3ZQfCCfvXKFHJosNVg3dQUOacMoQ/TrC5evE3/XffcXrJKdyzdsfJal5E2OV0
HHPzR/yZa+LInZADOxwJiJiYF1xNOg4dwNorMhtTRCfjCnA1W4mGuw7RkHX5i0zp
ugP5GXE/ktORobIt8tTTKqaoYzr/dh6OXBw3EhyJgzGuQwmAZmsiMViaYw0fEzaQ
EEVPXFaSEp4e3/DgE5KOT5fl4RwI4w==
=Iiz6
-----END PGP SIGNATURE-----

--lnLTz5q6oum7yiEn--
