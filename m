Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC772C5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjFLN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjFLN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:27:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7368170D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686576448; x=1718112448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GwHxffw1hEs0NmamZRBXpOKOnWTSVST/GTzUBhdAgZU=;
  b=hs9Mdo8MHcmQl3xJ1I9gKH+7JVE4YCDEdDV+qk2z21mozncyA3VV3fJy
   QCaMeXCu38qBYvlEFs9mJvqMLJ4DfugQkSPJizrrscxPjM3EFXljKT1jC
   QjeX9+6Q+Z0yBDr4G6Sey1WFwV/kGLjgptc8qd6fsPVGxMbL5Bj6B7Q8d
   ATorc6hCSrHzat4J8MPXAzsQs3AP7r2gp0c6R9ZLplZjlcAh/IPZ6U853
   TgFgew5z4EVKvumvihpN9IG9li5LEwYIqnsu0puN9Vs8KBTI0yxe0nvEA
   c02nn0XtbNDHkEpR75291ekdRsml1EAjmlv+cEQRnj0dGTUgKLshP6qr9
   A==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="asc'?scan'208";a="218022908"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2023 06:27:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 12 Jun 2023 06:27:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 12 Jun 2023 06:27:16 -0700
Date:   Mon, 12 Jun 2023 14:26:51 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <conor@kernel.org>,
        <daire.mcnamara@microchip.com>
Subject: Re: Potential issue with (or misunderstanding of) of_irq_get()
Message-ID: <20230612-corny-march-372b42c8b9d9@wendy>
References: <20230519-unkempt-cartel-48efb4d8f0b4@wendy>
 <87wn11oo5o.wl-maz@kernel.org>
 <20230522-niece-vanish-a1ee36494ef0@wendy>
 <20230608-corset-jackal-2e3ec4b6d509@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NvSZZqN0HjDY8r3h"
Content-Disposition: inline
In-Reply-To: <20230608-corset-jackal-2e3ec4b6d509@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NvSZZqN0HjDY8r3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 02:29:47PM +0100, Conor Dooley wrote:
> On Mon, May 22, 2023 at 12:56:30PM +0100, Conor Dooley wrote:
> > On Sun, May 21, 2023 at 01:38:11PM +0100, Marc Zyngier wrote:

> Sounds like it may be the latter... The hierarchical stuff for the
> direct interrupts is working well, so progress at least. I seem to
> have gotten stuck with the non-direct/muxxed interrupts though.
>=20
> My alloc() now looks like, for the direct interrupts:
> static int mpfs_irq_mux_alloc(struct irq_domain *d, unsigned int virq,
> 				     unsigned int nr_irqs, void *arg)
> {
> 	struct mpfs_irq_mux *priv =3D d->host_data;
> 	struct irq_fwspec *fwspec =3D arg;
> 	struct irq_fwspec parent_fwspec;
> 	int ret;
>=20
> 	pr_info("attempting to allocate\n");
> 	ret =3D mpfs_irq_mux_is_direct_get_mapping(priv, fwspec);
> 	if (ret =3D=3D -EINVAL) {
> 		irq_domain_disconnect_hierarchy(d, virq);

A weekend & sufficient caffeine later and I've realised that this
should probably be disconnecting the parent...
Modulo WIP bodging, things seem to be working. Touch wood it doesn't
collapse in a heap when the bodges are cleaned up.


> 	}
>=20
> 	parent_fwspec.fwnode =3D d->parent->fwnode;
> 	parent_fwspec.param[0] =3D priv->parent_irqs[ret];
> 	parent_fwspec.param_count =3D 1;
>=20
> 	ret =3D irq_domain_alloc_irqs_parent(d, virq, 1, &parent_fwspec);
> 	if (ret)
> 		return ret;
>=20
> 	irq_domain_set_hwirq_and_chip(d, virq, fwspec->param[0],
> 				      &mpfs_irq_mux_irq_chip, priv);
>=20
> 	return 0;
> }

--NvSZZqN0HjDY8r3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIcdGwAKCRB4tDGHoIJi
0vwMAP49UjcSLjiIONbZdC/bng0ajLm6ZfMc6bEz+ubCh2SnjQEA/izBU9tzDM2l
y+9Wel8XbdlcRVEpP6VI8nKIQpf+GQw=
=ynGs
-----END PGP SIGNATURE-----

--NvSZZqN0HjDY8r3h--
