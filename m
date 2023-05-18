Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73C7087B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjERSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjERSSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:18:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826FA0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:18:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 467EA5C0189;
        Thu, 18 May 2023 14:18:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 May 2023 14:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684433925; x=1684520325; bh=8axqpDZcBJUL6/RSlQEGx3UykZkeYDfsoFq
        sKS4DlH8=; b=LTDJ72ZJBNU4Q+wdQtTMHbKI7Rf7xCwPmPlFPa/OWtk6KR2yIsb
        wUx4TgI9fwxNTiD9tCkEW9fGhx6uFOOexL8CANKKVptANJ3uJC8nIcLpDQnNeuJ5
        9tieBz0pNDhKd4uSNPNux7XAJUkWci2MO18bTW3KhOKheIthnn54/C2EIz2B7n0p
        ArsV7dtXoA+8i7LqZVw5QBTuof9aSMA381lGLdwimEdPy6/4q2hSQupv4lFLphcq
        Xz1nGSd9blAmwB1xoafB3KUXW/7h0gRdkot2+/Ph2RsVSc6V0quQymU13VP2wcXw
        AuAa+ike1zV5TPGd9EvSg2UdVQTk5IVi74g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684433925; x=1684520325; bh=8axqpDZcBJUL6
        /RSlQEGx3UykZkeYDfsoFqsKS4DlH8=; b=ahTrDDMNHMprtR6j7zsInmHT0unIR
        qAyeVpbtq7fyzs/HsksHaOtng51EzIdD1Y4DmO8WoPBkTWZ5M3rG0m/mcJ6JDmPw
        Ecy4AFX/C+Uewwq8xxSQ0sk7Is2WYhYYslyESxZijdWH/cei3IxLH5Fq8X6pTphq
        SxFdOZPf2JQXVzxxMxEilNQPw4mbB+ZrezIiDlKcdSqxv2j25fEZnzUl0MJ8yfLX
        4IBsMTnU58G/IcA7jgPp15uxmuqzn8dHYvRHo01VfoDYtRBqchFq9RUOtpPcUI9N
        ZflIOipXAScjPuYZeecwD2XoSt2p9rjtUfsNR+ACw3XeX8tFtlst0182g==
X-ME-Sender: <xms:BGxmZEHwrxvzj2rUdyQFtkeClxzfILEtdDb-xaRPscDsugNfa_gRhg>
    <xme:BGxmZNXNpf0AMvINhbKCxiq-tUTzBaefoJnHwWVNaDikDkZjQkGPm_8uhSk2JyFpn
    4sOIN4kpu3nRQ>
X-ME-Received: <xmr:BGxmZOJZQmSuEVRCprIH4kzePADrtGYRp1bSQUHUENFrUWHdOe2cZ4QgvTtelEMwRsTpyFOh_IZf-gSqvSecmq8Ebl-rrYiRAFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghr
    vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
    hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefg
    udelteefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgv
    khesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:BGxmZGG9PGqozfwHtPqImZp0h9jq6zXETkRQMUn2ych4Vg8Ht-Fv7g>
    <xmx:BGxmZKWMsb0cJjwvkTZF5RgdlJXSFKEsQNnO8v9cj_4G3rifEk9oVA>
    <xmx:BGxmZJO894ds2AjAhhHmsTz7sH_UR233C-BOjr4cInJFMiOoHG__fw>
    <xmx:BWxmZDVQItjPzKlagxJxlOPA1P5hwMRsW1KjHLFzxth6sl8DCB60tA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 14:18:42 -0400 (EDT)
Date:   Thu, 18 May 2023 20:18:39 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when xen-pcifront
 is enabling
Message-ID: <ZGZr/xgbUmVqpOpN@mail-itl>
References: <20230518134253.909623-1-hch@lst.de>
 <20230518134253.909623-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CsM+DO8kg05XbydD"
Content-Disposition: inline
In-Reply-To: <20230518134253.909623-3-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CsM+DO8kg05XbydD
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 May 2023 20:18:39 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when xen-pcifront
 is enabling

On Thu, May 18, 2023 at 03:42:51PM +0200, Christoph Hellwig wrote:
> Remove the dangerous late initialization of xen-swiotlb in
> pci_xen_swiotlb_init_late and instead just always initialize
> xen-swiotlb in the boot code if CONFIG_XEN_PCIDEV_FRONTEND is enabled.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Doesn't it mean all the PV guests will basically waste 64MB of RAM
by default each if they don't really have PCI devices?

> ---
>  arch/x86/include/asm/xen/swiotlb-xen.h |  6 ------
>  arch/x86/kernel/pci-dma.c              | 25 +++----------------------
>  drivers/pci/xen-pcifront.c             |  6 ------
>  3 files changed, 3 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/xen/swiotlb-xen.h b/arch/x86/include/as=
m/xen/swiotlb-xen.h
> index 77a2d19cc9909e..abde0f44df57dc 100644
> --- a/arch/x86/include/asm/xen/swiotlb-xen.h
> +++ b/arch/x86/include/asm/xen/swiotlb-xen.h
> @@ -2,12 +2,6 @@
>  #ifndef _ASM_X86_SWIOTLB_XEN_H
>  #define _ASM_X86_SWIOTLB_XEN_H
> =20
> -#ifdef CONFIG_SWIOTLB_XEN
> -extern int pci_xen_swiotlb_init_late(void);
> -#else
> -static inline int pci_xen_swiotlb_init_late(void) { return -ENXIO; }
> -#endif
> -
>  int xen_swiotlb_fixup(void *buf, unsigned long nslabs);
>  int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
>  				unsigned int address_bits,
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index f887b08ac5ffe4..c4a7ead9eb674e 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -81,27 +81,6 @@ static void __init pci_xen_swiotlb_init(void)
>  	if (IS_ENABLED(CONFIG_PCI))
>  		pci_request_acs();
>  }
> -
> -int pci_xen_swiotlb_init_late(void)
> -{
> -	if (dma_ops =3D=3D &xen_swiotlb_dma_ops)
> -		return 0;
> -
> -	/* we can work with the default swiotlb */
> -	if (!io_tlb_default_mem.nslabs) {
> -		int rc =3D swiotlb_init_late(swiotlb_size_or_default(),
> -					   GFP_KERNEL, xen_swiotlb_fixup);
> -		if (rc < 0)
> -			return rc;
> -	}
> -
> -	/* XXX: this switches the dma ops under live devices! */
> -	dma_ops =3D &xen_swiotlb_dma_ops;
> -	if (IS_ENABLED(CONFIG_PCI))
> -		pci_request_acs();
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pci_xen_swiotlb_init_late);
>  #else
>  static inline void __init pci_xen_swiotlb_init(void)
>  {
> @@ -111,7 +90,9 @@ static inline void __init pci_xen_swiotlb_init(void)
>  void __init pci_iommu_alloc(void)
>  {
>  	if (xen_pv_domain()) {
> -		if (xen_initial_domain() || x86_swiotlb_enable)
> +		if (xen_initial_domain() ||
> +		    IS_ENABLED(CONFIG_XEN_PCIDEV_FRONTEND) ||
> +		    x86_swiotlb_enable)
>  			pci_xen_swiotlb_init();
>  		return;
>  	}
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index 83c0ab50676dff..11636634ae512f 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -22,7 +22,6 @@
>  #include <linux/bitops.h>
>  #include <linux/time.h>
>  #include <linux/ktime.h>
> -#include <linux/swiotlb.h>
>  #include <xen/platform_pci.h>
> =20
>  #include <asm/xen/swiotlb-xen.h>
> @@ -669,11 +668,6 @@ static int pcifront_connect_and_init_dma(struct pcif=
ront_device *pdev)
> =20
>  	spin_unlock(&pcifront_dev_lock);
> =20
> -	if (!err && !is_swiotlb_active(&pdev->xdev->dev)) {
> -		err =3D pci_xen_swiotlb_init_late();
> -		if (err)
> -			dev_err(&pdev->xdev->dev, "Could not setup SWIOTLB!\n");
> -	}
>  	return err;
>  }
> =20
> --=20
> 2.39.2
>=20
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--CsM+DO8kg05XbydD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmRma/8ACgkQ24/THMrX
1yzT+gf/S1uwHKmjBfQtKqzw50EE/PUeNAO8869wN0cpWYT6WkKJT5BxXOVgbJfW
9mibLfMCcVO0H1cE8+PCxvC9BIv3ldhC7KVtSQks99V24zf0mPiqBiGM2mAI9VRD
SYMwmipIXDSRFERIcBo1XomAt4ytJj/BkqCv+Xy5PgYIqdABz9R4G3HT2q6rN0Lq
M2sLnKWdGwoYdk8hOmlTY5F3/iYdv/Zlel4Ki2s5ZzLUBxCZ1IKErb31wRaRid8p
APcTnrs8RZE8+YBL7nzdr9HudKMlaChsiZsPkIo0v0aI5oFa+OHs6Z5sOXOP0RAB
qmCDKShHiVUc6Lqc1gT6VHLmZdEEig==
=Y97F
-----END PGP SIGNATURE-----

--CsM+DO8kg05XbydD--
