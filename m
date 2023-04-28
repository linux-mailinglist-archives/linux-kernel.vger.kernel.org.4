Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD2D6F1A70
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjD1OZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjD1OZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:25:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59C2719
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682691954; x=1714227954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnNojlXbMDN9N2lkFqtg0abQH7uELFRlQ/gsQlbk+ZM=;
  b=KdV34ofTffWC8R+BPpjREnDf11PB06xxQM6NaQNNAIXNo81HYL2cqtxL
   4Fl0uzBTc/u2eUF8Vj923My79ya+AJS8SZRj660iLmmlGsMEahDkyaCGy
   bYg2Wa0NAT6DnFI3JouYs18LbSet+CBnKY1Re0mw5mrZoolO3BLriDoV2
   Ro9pyOCeLo0ZvgdWJVjzBAc4bCQiIcSBB6MRnorvqRF097UEhMYDU/O1Q
   ULnYwt/W6GzAFK5LyeEiwLOWM6Nn/enomz4DeK8uWlJu/zShTPcvRLO72
   KNORII4DvvQMhI2ieGnmhvKmo+1hxTnIKJyrzfN6mDJS4alkGWKL9VPYP
   w==;
X-IronPort-AV: E=Sophos;i="5.99,234,1677567600"; 
   d="asc'?scan'208";a="212792438"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Apr 2023 07:25:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Apr 2023 07:25:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Apr 2023 07:25:49 -0700
Date:   Fri, 28 Apr 2023 15:25:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
        <paul.walmsley@sifive.com>, <kito.cheng@sifive.com>,
        <jrtc27@jrtc27.com>, <matthias.bgg@gmail.com>,
        <heinrich.schuchardt@canonical.com>, <greentime.hu@sifive.com>,
        <nick.knight@sifive.com>, <christoph.muellner@vrull.eu>,
        <philipp.tomsich@vrull.eu>, <richard.henderson@linaro.org>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] RISC-V: add support for vendor-extensions via
 AT_BASE_PLATFORM and xthead
Message-ID: <20230428-versus-shady-d20735a19d41@wendy>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-5-heiko.stuebner@vrull.eu>
 <20230426-spirits-ludicrous-a5d8275686e6@wendy>
 <5016896.Mh6RI2rZIc@diego>
 <20230427-maybe-skier-51e7cf09795c@spud>
 <d6lqggv2bbtmv7exalcqqwgbntibdxotsswataxqxhx6kmf4rg@5kgb3axdwgst>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3LKaALfH552SyaYA"
Content-Disposition: inline
In-Reply-To: <d6lqggv2bbtmv7exalcqqwgbntibdxotsswataxqxhx6kmf4rg@5kgb3axdwgst>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3LKaALfH552SyaYA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 12:28:24PM +0200, Andrew Jones wrote:
> On Thu, Apr 27, 2023 at 07:28:49PM +0100, Conor Dooley wrote:
> > On Thu, Apr 27, 2023 at 07:15:58PM +0200, Heiko St=FCbner wrote:
> > > Am Mittwoch, 26. April 2023, 14:29:16 CEST schrieb Conor Dooley:
> > > > On Mon, Apr 24, 2023 at 09:49:11PM +0200, Heiko Stuebner wrote:
> > > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ...
> > > > What do you mean by virtualisation here? It's the job of the hyperv=
isor
> > > > etc to make sure that what it passes to its guest contains only wha=
t it
> > > > wants the guest to see, right?
> > > > IIUC, that's another point against doing what this patch does.
> > >=20
> > > I guess I'm still seeing Zbb and friends - with just computational
> > > instructions as always good to have. But I guess you're right that the
> > > hypervisor should be able to control itself which extensions.
> >=20
> > Yah, there may not be any obvious downsides to something like Zbb, but I
> > think that taking control away from the hypervisors etc isn't a good
> > idea.
>=20
> If there's any chance that a VM will need to migrate from a host with,
> e.g. Zbb, to one without it, then the VM will need Zbb disabled from the
> start.

(Almost) Everything is obvious to someone :)

> > Having a simple policy of blocking things that are known to misbehave
> > would require less maint. than a list of things that are okay to pass
> > through, but both are probably cans-of-worms.
> > I think we need to think carefully about what policy is chosen here.
> > Allowlist will be slower, but at least we'll not tell userspace
> > something that is not usable. Blocklist will be easier to manage, but
> > can only be reactive.
>=20
> I have experience [trying] to maintain deny-lists for CPU features,
> both for x86 Xen guests and Arm KVM guests. I don't recommend it. To
> do it right, you need to be proactive, tracking upcoming CPU features
> to add the ones that can't be supported by virt or aren't ready to
> be supported by virt to the deny-list before somebody trips over them.
> In practice, usually somebody trips over it first, causing fires which
> have to be put out. If an allow-list is used, then, when a new feature
> is missed, no fires are started. The worst that can happen is somebody
> expected the feature and didn't see it, so they complain, at which
> point you add it.

Right. Blocking-unless-known is what I suggested when canvassed for an
opinion last week but the complaint was that the kernel having to
maintain a list would be a significant speed-bump for people.
With a lighter-weight method of forwarding to userspace extensions that
the kernel doesn't need to care about (no integration with
=2E._has_extension[un]likely() etc) hopefully the roadblock would be a
speedbump instead.

I think I would rather speed-bumps & complaints about things being slow,
than having to fight fires.

> > Also, in a world where we do do some sort of passing, should we only
> > forward the vendor extensions, or should we forward the standard ones
> > too?
>=20
> I guess we need to forward anything userspace can and should use.

That, combined with what we have now, would mean that userspace would
get told both what the kernel supports and additional other things that
the kernel may not support, but userspace can use without that support
being present.

I think that is a reasonable thing to do, although it'd muddy the waters
a bit with what the output in /proc/cpuinfo means. (I'm kinda taking the
particular bit of the series in isolation, as if /proc/cpuinfo is the
only place in which this information will be exposed.)

> > What about supervisor mode only stuff?
>=20
> That's not something userspace can use. If we want to expose which
> supervisor mode features the CPU has to userspace, for information
> purposes, then I think proc or sysfs would be sufficient for that.

Yeah, as above I'm kinda looking at it from a really naive "only
/proc/cpuinfo exists" point of view for the sake of simplicity.
Depending on implementation, reporting supervisor-only stuff that the
kernel supports may make life easier & there's probably some value to
someone in passing that information to userspace too.

> The downside of using an allow-list for what extensions get exposed
> to userspace is that even extensions the kernel can't/won't use
> will need a kernel patch before userspace can use them. But, as
> I stated above, that downside (people complaining a feature they
> expect is missing), is, IMO, better than the alternative of exposing
> things that shouldn't be.

Yeah, I would be in that camp too, but gotta suggest the various options
for the sake of stirring discussion :)

Thanks,
Conor.

--3LKaALfH552SyaYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEvXWwAKCRB4tDGHoIJi
0qNHAP0c8lqCdLl8JRxRiLWW8lTRO9Rv12Dv/9leiqgd0GXaMAEAqh7oqM481ghG
Ki+qZ6DT424RfarScyqP9XK5lkaEbgc=
=LTNI
-----END PGP SIGNATURE-----

--3LKaALfH552SyaYA--
