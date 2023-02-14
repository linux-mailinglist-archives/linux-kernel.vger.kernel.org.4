Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A0696837
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjBNPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjBNPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:37:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3E5FC6;
        Tue, 14 Feb 2023 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b7LTeIXXRhjHNZKLwP2eUBOvy8A+bNKHoN43DEwbShs=; b=ZJ60tcltd9tUxPXvvq0xlFyIL6
        54nH3MAS0etSF71Vg31JUcBLXpBh0L+qyMjnH0cxJZnhy+fNVHyAzg6tUysiafwkXr6EGN1bBLvH8
        EYt+sO5hnoq5doF2AgnlkNiLoWPL6qsbM1FtrRNneXwa9ml2PbJyjXR/IJ2cuIvmKzCrsRHcWDyHW
        pNejNvINpl6m6Rt/Z/UQdUP58lzgNnEq801+MLxXOmpukMds0dFq1ldemt3EOaEF2sESv/EOD4B5P
        2whxU1KzDZJfq7oBespZomiCoXfkBFdsr7hb1C+wZ5VkYomLpJgiFCa2lMYkziYJc7yEVbHqvKP/D
        ysJjZYXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRxLi-009fnp-0h;
        Tue, 14 Feb 2023 15:36:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A87A4302E5D;
        Tue, 14 Feb 2023 12:22:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC38A20B4E943; Tue, 14 Feb 2023 12:22:17 +0100 (CET)
Date:   Tue, 14 Feb 2023 12:22:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Xen Devel <xen-devel@lists.xenproject.org>,
        Per Bilse <per.bilse@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the xen-tip tree
Message-ID: <Y+tu6Xqqb6cdiDAA@hirez.programming.kicks-ass.net>
References: <20230214124700.22f0a62e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9N+tlQnp6RT7SrtH"
Content-Disposition: inline
In-Reply-To: <20230214124700.22f0a62e@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9N+tlQnp6RT7SrtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2023 at 12:47:00PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commits are also in the tip tree as different commits
> (but the same patches):
>=20
>   415dab3c1796 ("drivers/xen/hypervisor: Expose Xen SIF flags to userspac=
e")
>   336f560a8917 ("x86/xen: don't let xen_pv_play_dead() return")
>   f697cb00afa9 ("x86/xen: mark xen_pv_play_dead() as __noreturn")
>=20
> These are commits
>=20
>   859761e770f8 ("drivers/xen/hypervisor: Expose Xen SIF flags to userspac=
e")
>   076cbf5d2163 ("x86/xen: don't let xen_pv_play_dead() return")
>   1aff0d2658e5 ("x86/xen: mark xen_pv_play_dead() as __noreturn")
>=20
> in the tip tree.

This was intentional (dependencies) and the plan is to only offer the
tip branch for merge after the Xen tree goes in.

--9N+tlQnp6RT7SrtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmPrbuMACgkQdkfhpEvA
5Lq1xQ//X0sV6gQk3sHy5WQPnx4D4OcH0oiOyu9ytASjCEVL/wxNlB3TOAW9TV1e
eWTTdx3NoTI8A2i3u8SEYzlGN6+p/jCJdIlfwyeRTpJ5l6f0U+xKN2LYc7yn7h34
faixh10wtlG//RzdJjVsOMkORjKiZuV7BYSViVNu9Trc5AhcpP53wevx5wk7VN9E
wTM7wJM6r3/g3SGM7f5ZNB4rr0SnZGoNNcO9dEeBOPK5PR5iGSQJtPMSS/2lKk5i
KQimr0N7jR6aRPzsN0+zAECnE0WW71N/4UCUZ5tGJIMZreCBhZTyXC+D+tTerxkM
C53RaFq6zRx+wQVN7waVHLuboKKO5vaGYrt8gy9sVkaoo6sdtz94QuHldG6FCg4b
3APdN43UCd0vB2WX4yEmnAsgOY4AqkebEAcFyCEME+nEpA2zr/tjCXG7JfKqQNG8
Ujy84aM2mKs4fVmaPhunXCv9IxHLcyTriVsnmcYi+gn68913NsFVqHiAr4/Lf9dO
QfCyAqWEcxxfoqiy8ebOumivjXNn8Mz5lSWD/oEJTI11rtzleRJLwrt7W9JE6gI3
HRZK1/x7Mc8kbQIvACqx4paxa0B/8+/67xruENgjv7EbUxjIoX7uYeIixfol7OMf
eKgsJ25N7IvxWnSDUtXeHI5BvyKHX/4B/aVacyyDJHva4R5dHQA=
=YOXl
-----END PGP SIGNATURE-----

--9N+tlQnp6RT7SrtH--
