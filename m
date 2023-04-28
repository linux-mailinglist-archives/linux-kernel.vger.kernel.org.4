Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2316F12E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbjD1HzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345876AbjD1Hy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:54:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F23584
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682668452; x=1714204452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OlsA+AX7WyRohAddj2ZGazyt0PvfVc7tI53YweesSB0=;
  b=iq9LyqSpiKXkczyQRjF6+wb4ZUDId3Kir6tL/gMj9wYEJcbfJjCq8EPE
   2iMI8+S8Fkk4byK++u4LzqYRW+EQv8uUHx7y29isQ9TAzeDAUbo6Kvcz2
   3Agtvu6JEEp5axau28wqSfn95GMefrfRPQK2WRKn/9luLnG7BarwGahIg
   rQtLI+5G35eACODMida6C36GEyDMGReBzaPjcbfAlvK6W60y9QPaD8DgN
   QN6sDopqQxxEqdwzqcq6/zBYF5eytSnkLXLsr2gfiVktpqi5LMhbYfrQK
   FI2ZMC68KmTnRFfnkxki/FeKlv7tPkrccef+lOwp+xzxwuZIma1oV9Svh
   g==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677567600"; 
   d="asc'?scan'208";a="149397349"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Apr 2023 00:54:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Apr 2023 00:54:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Apr 2023 00:54:07 -0700
Date:   Fri, 28 Apr 2023 08:53:49 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
        <paul.walmsley@sifive.com>, <kito.cheng@sifive.com>,
        <jrtc27@jrtc27.com>, <matthias.bgg@gmail.com>,
        <heinrich.schuchardt@canonical.com>, <greentime.hu@sifive.com>,
        <nick.knight@sifive.com>, <christoph.muellner@vrull.eu>,
        <philipp.tomsich@vrull.eu>, <richard.henderson@linaro.org>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] RISC-V: add support for vendor-extensions via
 AT_BASE_PLATFORM and xthead
Message-ID: <20230428-survey-uniquely-99bdc105ce3b@wendy>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-5-heiko.stuebner@vrull.eu>
 <20230426-spirits-ludicrous-a5d8275686e6@wendy>
 <5016896.Mh6RI2rZIc@diego>
 <20230427-maybe-skier-51e7cf09795c@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y5bW1V7trXX+9VZK"
Content-Disposition: inline
In-Reply-To: <20230427-maybe-skier-51e7cf09795c@spud>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--y5bW1V7trXX+9VZK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 07:28:49PM +0100, Conor Dooley wrote:
> Hey Heiko,
>=20
> On Thu, Apr 27, 2023 at 07:15:58PM +0200, Heiko St=C3=BCbner wrote:
> > Am Mittwoch, 26. April 2023, 14:29:16 CEST schrieb Conor Dooley:
> > > On Mon, Apr 24, 2023 at 09:49:11PM +0200, Heiko Stuebner wrote:
> > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> > > I'm not entirely sure if this patch is meant to be a demo, but I don't
> > > like the idea of using these registers to determine what extensions a=
re
> > > reported.
> >=20
> > It took me a while to grasp the above, but I think you mean determining
> > extensions based on mvendor etc, right?
>=20
> Yes, sorry. Apologies if that was not clear. I suppose the SBI
> implementation could (as ours does!) could report something different to
> the registers themselves, so using that word is probably not a good idea
> anyway.
>=20
> > > riscv,isa in a devicetree (for as much as I might dislike it at this
> > > point in time), or the ACPI equivalent, should be the mechanism for
> > > enabling/disabling these kinds of things.
> >=20
> > > Otherwise, we are just going to end up causing problems for ourselves
> > > with various lists of this that and the other extension for different
> > > combinations of hardware.
> > > The open source c906 has the same archid/impid too right? Assuming th=
is is
> > > a serious proposal, how would you intend dealing with modified versio=
ns
> > > of those cores?
> > >=20
> > > I am pretty sure that you intended this to be a demo though, particul=
arly
> > > given the wording of the below quote from your cover,
> >=20
> > yeah, this one was more following a train of thought. Thinking about the
> > issues, this was more of an addon thought, as I wasn't really sure which
> > way to go.
> >=20
> > So you're right, vendor isa-extensions should also come from the ISA
> > string from firmware, similar to the base extensions. Not based on the
> > mvendor-id and friends.
>=20
> :)
>=20
> > > > Things to still consider:
> > > > -------------------------
> > > > Right now both hwprobe and this approach will only pass through
> > > > extensions the kernel actually knows about itself. This should not
> > > > necessarily be needed (but could be an optional feature for e.g. vi=
rtualization).
> > >=20
> > > What do you mean by virtualisation here? It's the job of the hypervis=
or
> > > etc to make sure that what it passes to its guest contains only what =
it
> > > wants the guest to see, right?
> > > IIUC, that's another point against doing what this patch does.
> >=20
> > I guess I'm still seeing Zbb and friends - with just computational
> > instructions as always good to have. But I guess you're right that the
> > hypervisor should be able to control itself which extensions.
>=20
> Yah, there may not be any obvious downsides to something like Zbb, but I
> think that taking control away from the hypervisors etc isn't a good
> idea.
> Having a simple policy of blocking things that are known to misbehave
> would require less maint. than a list of things that are okay to pass
> through, but both are probably cans-of-worms.
> I think we need to think carefully about what policy is chosen here.
> Allowlist will be slower, but at least we'll not tell userspace
> something that is not usable. Blocklist will be easier to manage, but
> can only be reactive.
>=20
> > > > Most extensions don=E2=80=99t introduce new user-mode state that th=
e kernel needs to
> > > > manage (e.g. new registers). Extension that do introduce new user-m=
ode state
> > > > are usually disabled by default and have to be enabled by S mode or=
 M mode
> > > > (e.g. FS[1:0] for the +floating-point extension). So there should n=
ot be a
> > > > reason to filter any extensions that are unknown.
> > >=20
> > > I think in general this can be safely assumed, but I don't think it is
> > > unreasonable to expect someone may make, for example, XConorGigaVector
> > > that gets turned on by the same bits as regular old vector but has so=
me
> > > extra registers.
> > > Not saying that I think that that is a good idea, but it is a distinct
> > > possibility that this will happen, and I don't think forwarding it to
> > > userspace is a good idea.
> >=20
> > The thead-vector (0.7.1) would probably fit this description. Though in
> > that case, userspace definitly needs to know about it, to use it :-) .
> >=20
> > But of course this should only be forwarded when relevant support
> > is available in the kernel.
>=20
> Right. IIRC, the plan for that is to add `v` to riscv,isa & alternatives
> will do the rest as opposed to doing an `_xtheadvector` type thing.
>=20
> Assuming the latter for a moment, we'd have to blacklist `_xheadvector`
> for kernels compiled without vector support even if the relevant support
> is added to the kernel. Similarly, we'd have to blacklist it for kernels
> with vector support, but without the erratum enabled.
>=20
> I think the plan was the former though, so you'd have to block passing
> `v` to userspace if vector is enabled and the erratum is not supported.
> Should ERRATA_THEAD_VECTOR be mandatory then for RISCV_ISA_VECTOR &&
> ERRATA_THEAD kernels?

> What am I missing?

I think what I missed is that for riscv,isa containing `_xtheadvector`
but a kernel without support for vector then we'd hit Andy's
trap-on-first-use and that's one of the cases that don't need to be
considered here.

> Also, in a world where we do do some sort of passing, should we only
> forward the vendor extensions, or should we forward the standard ones
> too?
> What about supervisor mode only stuff? There's a bunch of questions to
> consider here, even if for some of them the answer may be obvious.
>=20
> As I said, not really bothered about hwprobe, aux vector etc, but this
> side of things is particularly interesting to me.
>=20
> Cheers,
> Conor.



--y5bW1V7trXX+9VZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEt7gQAKCRB4tDGHoIJi
0gvTAP9v25hf36KUdcSWM6VwpCVXzeAKy7CvWw66jh3chdPECgD7B109eUCb+KO/
1DXwoW8m6oj1K0zu8rMpdQzxW0WcPgs=
=4qRX
-----END PGP SIGNATURE-----

--y5bW1V7trXX+9VZK--
