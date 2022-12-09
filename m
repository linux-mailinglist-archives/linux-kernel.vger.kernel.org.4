Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277C8648324
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLIN7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLIN7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:59:07 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A276169
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:59:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670594320; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ejEAKYc3SIBqBvbmxKBqnKtbnSqMWIWn8HjL2Yfb4SEbPadQ9pdSXFSYYyUHcByLfhrQ8pw9NfpPa3CUV7w6KSrLMuuo3JNvfaPET1T4i+q0eWWe7y0Ubd+d4A36SBNTykO5ZUwyvjOTNmXKzIhYdlEgh29uCiM1Q6H71bNmjXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670594320; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=hKxW9ckD3XBG4g32XqU8YYkBakkblZNf6aXK+WdLrpU=; 
        b=joLeyzYzNHWBmK+20ESe+GioNawVbTqLTYogi0KxGpuTSYSNmqoBpuc6TG9DWbOIzpNpVOxbdPE3xFM0cwccI7Vzosgvb+ayjQhQ5S/d8WB1UGKrHhZl2zszZscbsAvZDwCq8nURxgIvT5ii7+cYTnvmAOKD4fc9NQNAv6oUHFo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670594320;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=hKxW9ckD3XBG4g32XqU8YYkBakkblZNf6aXK+WdLrpU=;
        b=Jp91xG+VlBJd6PPe8my33ZD/JxVVnv57A3JBcB9t5QaxzU+fLDZVMRlGCJ6v9YnU
        aCa1upNQnquvxAoq07CLU1DxN5lwbK/zp2G+Ow7cYeXI4aGbK4vTErrxjw3/ZPT4RAi
        r2dDJQKMDekKKxlG2+fOhM9I/TWgdFzUabBD/hL8=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670594317278802.461204905764; Fri, 9 Dec 2022 05:58:37 -0800 (PST)
Message-ID: <da22d7e178bcdac873d838b4f85558b40551eaed.camel@icenowy.me>
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Vineet Gupta <vineetg@rivosinc.com>
Cc:     stillson@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, Andrew Waterman <andrew@sifive.com>,
        Darius Rad <darius@bluespec.com>, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, fweimer@redhat.com, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
Date:   Fri, 09 Dec 2022 21:58:26 +0800
In-Reply-To: <mhng-84ad9495-ef4b-4343-89ee-dfe45ab69ff7@palmer-ri-x1c9>
References: <mhng-84ad9495-ef4b-4343-89ee-dfe45ab69ff7@palmer-ri-x1c9>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-12-08=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 22:27 -0800=EF=BC=
=8CPalmer Dabbelt=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 08 Dec 2022 21:16:06 PST (-0800), Vineet Gupta wrote:
> > Hi Darius, Andrew, Palmer
> >=20
> > On 9/21/22 14:43, Chris Stillson wrote:
> > > diff --git a/arch/riscv/kernel/process.c
> > > b/arch/riscv/kernel/process.c
> > >=20
> > > @@ -134,7 +135,6 @@ void start_thread(struct pt_regs *regs,
> > > unsigned long pc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (WARN_ON(!vstate->datap))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regs->status |=3D SR_VS_INITIAL;
> > >=20
> >=20
> > Perhaps not obvious from the patch, but this is a major user
> > experience
> > change: As in V unit would be turned off for a new task and we will
> > rely
> > on a userspace prctl (also introduced in this patch) to enable V.
>=20
> IMO that's the only viable option: enabling V adds more user-visible=20
> state, which is a uABI break.=C2=A0 I haven't really had time to poke
> through=20
> all the versions here, but I'd have the call look something like
>=20
> =C2=A0=C2=A0=C2=A0 prctl(RISCV_ENABLE_V, min_vlenb, max_vlenb, flags);

Should we make this extra switch more future-proof by not only limiting
it to V, but also other extensions that will introduce extra state,
e.g. P ?

>=20
> where
>=20
> * min_vlenb is the smallest VLENB that userspace can support.=C2=A0
> There's=20
> =C2=A0 alreday an LLVM argument for this, I haven't dug into the generate=
d
> =C2=A0 code but I assume it'll blow up on smaller VLENB systems somehow.
> * max_vlenb is the largest VLENB that userspace can support.
> * flags is just a placeholder for now, with 0 meaning "V as defined
> by=20
> =C2=A0 1.0 for all threads in this proces".=C2=A0 That should give us an =
out if
> =C2=A0 something more complicated happens in the future.
>=20
> That way VLA code can call `prctl(RISCV_ENABLE_V, 128, 8192, 0)` as
> it=20
> supports any V 1.0 implementation, while code with other constraints
> can=20
> avoid having V turned on in an unsupported configuration.
>=20
> I think we can start out with no flags, but there's a few I could see
> being useful already:
>=20
> * Cross process/thread enabling.=C2=A0 I think a reasonable default is=
=20
> =C2=A0 "enable V for all current and future threads in this process", but
> one=20
> =C2=A0 could imagine flags for "just this thread" vs "all current
> threads", a=20
> =C2=A0 default for new threads, and a default for child processes.=C2=A0 =
I
> don't=20
> =C2=A0 think it matters so much what we pick as a default, just that it's=
=20
> =C2=A0 written down.
> * Setting the VLENB bounds vs updating them.=C2=A0 I'm thinking for share=
d
> =C2=A0 libraries, where they'd only want to enable V in the shared librar=
y
> if=20
> =C2=A0 it's already in a supported configuration.=C2=A0 I'm not sure what=
 the=20
> =C2=A0 right rules are here, but again it's best to write that down.
> * Some way to disable V.=C2=A0 Maybe we just say `prctl(RISCV_ENABLE_V, 0=
,
> 0,=20
> =C2=A0 ...)` disables V, or maybe it's a flag?=C2=A0 Again, it should jus=
t be=20
> =C2=A0 written down.
> * What exactly we're enabling -- is it the V extension, or just the V
> =C2=A0 registers?
>=20
> There's a bunch of subtly here, though, so I think we'd at least want
> glibc and gdb support posted before committing to any uABI.=C2=A0 It's=
=20
> probably also worth looking at what the Arm folks did for SVE: I gave
> it=20
> a quick glance and it seems like there's a lot of similarities with
> what=20
> I'm suggesting here, but again a lot of this is pretty subtle stuff
> so=20
> it's hard to tell just at a glance.
>=20
> > I know some of you had different opinion on this in the past [1],
> > so
> > this is to make sure everyone's on same page.
> > And if we agree this is the way to go, how exactly will this be
> > done in
> > userspace.
> >=20
> > glibc dynamic loader will invoke the prctl() ? How will it decide
> > whether to do this (or not) - will it be unconditional or will it
> > use
> > the hwcap - does latter plumbing exist already ? If so is it
> > AT_HWCAP /
> > HWCAP2.
>=20
> That part I haven't sorted out yet, and I don't think it's sufficient
> to=20
> just say "userspace should enable what it can support" because of how
> pervasive V instructions are going to be.
>=20
> I don't think we need HWCAP, as userspace will need to call the
> prctl()=20
> anyway to turn on V and thus can just use the success/failure of that
> to=20
> sort things out.=C2=A0=20
>=20
> Maybe it's sufficient to rely on some sort of sticky prctl() (or
> sysctl=20
> type thing, the differences there would be pretty subtle) and just
> not=20
> worry about it, but having some way of encoding this in the ELF seems
> nice.=C2=A0 That said, we've had a bunch of trouble sorting out the ISA=
=20
> encoding in ELFs so maybe it's just not worth bothering?
>=20
> > Also for static linked executables, where will the prctl be called
> > from ?
>=20
> I guess that's pretty far in the weeds, but we could at least hook
> CRT=20
> to insert the relevant code.=C2=A0 We'd really need to sort out how we're=
=20
> going to encode the V support in binaries, though.
>=20
> > [1]
> > https://sourceware.org/pipermail/libc-alpha/2021-November/132883.html
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

