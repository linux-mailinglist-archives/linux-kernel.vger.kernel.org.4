Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0012A70B722
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjEVH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEVH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:56:02 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D577CE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:55:24 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 1897E13C2DA;
        Mon, 22 May 2023 09:55:21 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1684742122; bh=+ecvThwVNIF+3jNDHwnBtc4nIfmBUPqhUAXqbUCfwlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w6Ocr72GrnkWKmosOG9bJ8iIBfigFQC9bv9xRTioGZ2CSHlV1/RuH3eE+gUvmnvfs
         nupeVvjngA4t2geGD3q69X34CzBWx4qAmKkpMuMnSFHVYByJ5zbwogqgIPUcoeZdqa
         RqNtDRI+JKpfH9XtQLhgST01DHruuB5GwQejM4Ac7KHF3ZawwFK/uucm8u7sEHcsSb
         n5PuaYK1sl0TjJmngp2og1zrSsW9f7hvCWGHGBD5YJUn25qj/Sh4f0J4vGA0wTbHg3
         1jgpWjjEIZaxcs9YzhpV6ZMzjLM+wn23DgInohFErWKjQU2sYMZYfNvHQ7zx6gSJuh
         Mz/r0JnFTJi2w==
Date:   Mon, 22 May 2023 09:54:08 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Marek =?UTF-8?B?TWFyY3p5a293c2tpLUfDs3JlY2tp?= 
        <marmarek@invisiblethingslab.com>
Cc:     Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when
 xen-pcifront is enabling
Message-ID: <20230522095408.02874498@meshulam.tesarici.cz>
In-Reply-To: <ZGdLErBzi9MANL3i@mail-itl>
References: <20230518134253.909623-1-hch@lst.de>
        <20230518134253.909623-3-hch@lst.de>
        <ZGZr/xgbUmVqpOpN@mail-itl>
        <20230519040405.GA10818@lst.de>
        <ZGdLErBzi9MANL3i@mail-itl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4FW=_VIffR_gzuETX7eJ3Lw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4FW=_VIffR_gzuETX7eJ3Lw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 May 2023 12:10:26 +0200
Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com> wrote:

> On Fri, May 19, 2023 at 06:04:05AM +0200, Christoph Hellwig wrote:
> > On Thu, May 18, 2023 at 08:18:39PM +0200, Marek Marczykowski-G=C3=B3rec=
ki wrote: =20
> > > On Thu, May 18, 2023 at 03:42:51PM +0200, Christoph Hellwig wrote: =20
> > > > Remove the dangerous late initialization of xen-swiotlb in
> > > > pci_xen_swiotlb_init_late and instead just always initialize
> > > > xen-swiotlb in the boot code if CONFIG_XEN_PCIDEV_FRONTEND is enabl=
ed.
> > > >=20
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de> =20
> > >=20
> > > Doesn't it mean all the PV guests will basically waste 64MB of RAM
> > > by default each if they don't really have PCI devices? =20
> >=20
> > If CONFIG_XEN_PCIDEV_FRONTEND is enabled, and the kernel's isn't booted
> > with swiotlb=3Dnoforce, yes. =20
>=20
> That's "a bit" unfortunate, since that might be significant part of the
> VM memory, or if you have a lot of VMs, a significant part of the host
> memory - it quickly adds up.

I wonder if dynamic swiotlb allocation might also help with this...

Petr T

--Sig_/4FW=_VIffR_gzuETX7eJ3Lw
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQR36mnYrQDNXFnn8/Pem5ZkryZSgUCZGsfoQAKCRDPem5ZkryZ
SqVBAP0bQzVwflJ+O+7tLcfRm7IETeA07OEHXqZhmGqGL5eX8QD9HjbTN1pnVQK5
45KGLgOriHcE1PpDjMqZrgg7MRy/3gY=
=o6/4
-----END PGP SIGNATURE-----

--Sig_/4FW=_VIffR_gzuETX7eJ3Lw--
