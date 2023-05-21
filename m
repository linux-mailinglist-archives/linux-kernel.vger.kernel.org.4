Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015370ABF7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 04:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjEUCH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjEUCHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 22:07:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A51A1;
        Sat, 20 May 2023 19:06:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9B0B23200312;
        Sat, 20 May 2023 22:06:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 20 May 2023 22:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684634809; x=1684721209; bh=+zMtkZSHtPQagLGrrkdkLMVhLxx0zNy3rsJ
        4w9hvcuM=; b=Ayy6qnw39wnrhL/4oNup9u3xy+B2OlHXYj7c5za7xz/ZbDYIlYY
        1O9B1Qas/7hrvddfSEAflONPU8ebEgJ4J+1UwP2h8xnma7nDygJU31i3E76FRNTu
        eDv+ngqJRw8Lgf0hbp3e9sCnPI9NRrq8O57DLzDKaTClDuLMnJ8YW4VDLqxpvQC6
        QnDciBWrWvf08gxqDgMcJ81SS9v4crT9I7eRUxljeEEXYw4sfHiZphFNV3IlZVTD
        h6Ur39KuA0Fbei1Kt3O1b6U3WKQw8DiBQhVVv22GS+T9o5XLVwcS0F5uGVW64Wqi
        0LHKIhgG3G7ji6hrDJ6LArwIyGypQdOk+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684634809; x=1684721209; bh=+zMtkZSHtPQagLGrrkdkLMVhLxx0zNy3rsJ
        4w9hvcuM=; b=JAE+673+Crs/LCIvAt4YZOMvV9wHJkUXzcB46Aa9wVPKEuKcbsE
        G/b17oJUBvOrbm/AKvVuf4/BS87JmoSRaGdP6cHqG/eV4HXtfqgzCKc7/zQc1Ec0
        Ot7v5VTKtoqlIGFaLgVRTN8KZL95lQeIRn/Qto48qgC88+vMo6AnwdXfOKVklfu9
        szKoSUNvAlEI2YWL1ki5+3Q6Qped1PYG9xK1C+CcSOkMZXHT3LuZ5HiqxVKW+tAO
        4BoUcK5jD7OFmmM/PFxWttz/wj5M6sAJCw9dJj3stwZswlqJlhlbcj7+w05iw4eG
        I1ksWGdEX4OpK/SmsUH+OyYFhX+4RYqrPlw==
X-ME-Sender: <xms:uHxpZN4P0AjbAuNuiZgYLud4uV40MBGsdSEMBKWixEd6QmMzcYkdhQ>
    <xme:uHxpZK5Rdht5mkzi2hdEKlTv_G7nirR3L-RGsFk-I3h4l64BQJKxgtFFV5Q6o5DKt
    EZTnmms0Fsq4jQyC80>
X-ME-Received: <xmr:uHxpZEdziyYE0l_Gtejr1DRypfjfRd3it9ESI-rSnwwYoAiEqbB8qATN7ct6BPKX9OmJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeikedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvefhkeelveetheeifeekveegueffjeetudelteelieehffdu
    vddtleevtdduledtnecuffhomhgrihhnpehsthgrthhushdrfhhrnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:uHxpZGJLSc_5OBgBgXtcDaBPi7wjHZIP77ahtpeZayJW6gj1cWioog>
    <xmx:uHxpZBLpitJTF8IqTPmn70fmZD4of637PHXch6GNiChUlgTf2g2s7A>
    <xmx:uHxpZPwECmxKrXnasOFxIU_X294GiR9uvJ2ji6fMFycsqduYti6s4Q>
    <xmx:uXxpZIVGDwWAX9R9cKTo_nxo-rq67_LS7j6vyCzvHRlMzMnm55zBlA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 May 2023 22:06:47 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] MIPS: Fix MIPS_O32_FP64_SUPPORT for 64bit CPUs before R2
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <alpine.DEB.2.21.2305192352100.27887@angie.orcam.me.uk>
Date:   Sun, 21 May 2023 03:06:36 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B6F47AF-BA16-49FA-A959-7D3F064993DA@flygoat.com>
References: <20230519163023.70542-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305192033550.50034@angie.orcam.me.uk>
 <C1676532-0051-43D7-82D8-1E5697407C70@flygoat.com>
 <alpine.DEB.2.21.2305192352100.27887@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8820=E6=97=A5 21:32=EF=BC=8CMaciej W. Rozycki =
<macro@orcam.me.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 19 May 2023, Jiaxun Yang wrote:
>=20
>>> I guess one can do it and still run FPXX software, but I fail to see =
what=20
>>> gain it provides.  For FP32 it breaks things as accesses to =
odd-numbered=20
>>> FPRs will no longer get at the high part of a double value and for =
FP64=20
>>> there are no MTHC1/MFHC1 instructions required to access the high =
part.
>>=20
>> Actually software may access the high part by SDC1/LDC1.
>=20
> I'm aware of that, but you'd need a new psABI variation really to =
handle=20
> such an arrangement.  None of the existing FP32, FP64, FPXX handles =
it.
>=20
>>> What problem are you trying to solve?  And how did you verify this =
patch?
>>=20
>> Was trying to deal a proprietary JIT software who want to enable FR1 =
via prctl
>> on Loongson-2F with 32 bit kernel.
>=20
> There may be a better way: rather than avoiding MTHC1/MFHC1, handle =
them=20
> in the FPU emulator where unavailable in FR=3D1 mode while leaving the =
rest=20
> to hardware.  That would make regular FR64 software work.
>=20
> I'd expect such a JIT to have other issues with pre-R2 hardware =
though,=20
> with missing machine instructions.  I had a similar situation a few =
years=20
> ago with FireFox's JIT making assumptions above the MIPS ISA level the=20=

> piece of software was itself compiled for and opted for just disabling =
the=20
> JIT, as fixing FireFox and rebuilding it would be more effort than it =
was=20
> worth in my view.
>=20
> This might be the best way for you to move forward too, and I'm all =
but=20
> enthusiastic about adding a workaround in the kernel for a broken =
piece of=20
> proprietary user software.  Sorry.

Thanks for all those information. I was just entertaining by poking =
around some
old software blobs from Loongson so I=E2=80=99d give up upstreaming =
those changes.

My limited test works fine with this patch though.

- Jiaxun

>=20
> Also I seem to remember there was a pitfall with running 32-bit =
software=20
> on pre-R2 hardware in the FR=3D1 mode, but maybe I'm making up things =
here. =20
> It's been so long since I last looked into this.
>=20
> In any case you do need to verify this somehow, like by running the =
math=20
> part of the glibc testsuite with o32 in the FR=3D1 mode on pre-R2 =
hardware. =20
> Running the GDB test suite to make sure ptrace(2) works fine with the =
new=20
> FPU configuration would make sense too.
>=20
>>> Currently all FPUs we support implement double and we require that, =
so no=20
>>> need to make this piece conditional (I would use IS_ENABLED =
otherwise, so=20
>>> as not to clutter the source with #ifdef), but `c->fpu_id' is also =
exposed=20
>>> to the user via ptrace(2), so this has to reflect hardware and not =
give a=20
>>> synthesized value.
>>=20
>> Alas, I thought R2030 class FPU does not have double? Since MIPS-IV =
spec
>> says SDC1 is introduced in MIPS II.
>=20
> There's no SDC1/LDC1, but the usual MIPS I FP machine instructions (of=20=

> which there are fewer than in MIPS II, e.g. there's no SQRT.fmt or =
direct=20
> conversions) do support the double format/encoding.  It's just that =
double=20
> FP data has to be transferred piecemeal; other supported operations =
will=20
> execute just fine.  Otherwise the existence of the odd-numbered FPRs =
would=20
> make no sense in the first place.
>=20
> Plain single floating-point units are extremely rare, e.g. the R4650 =
has=20
> one (it does support CP0.Status.FR though, for 32 singles), and we do =
not=20
> support them (e.g. the R4650 has a simple base-bounds MMU only, no =
TLB). =20
> Another one is the R5900, but its FPU is not an IEEE 754 device even.
>=20
>  Maciej

