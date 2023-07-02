Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2594745302
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGBWvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGBWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:51:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D771B9;
        Sun,  2 Jul 2023 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688338290;
        bh=WSJme8ZWta8Gi20WTLMeQeOFtIcN8v/y7McLFtsWzYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dgWYxM11/oWrjZ4AFJppjxCoHDO3+mSlQpArX9oSI+an8Zn0E9ihZ0Kb0x3pjwqIi
         3TvFsYgWdDkppe+a+bjU7jzEPEZN7rJkk9teBqByyBWqHh1YyQrXpsvljKnGmUXwmv
         k5ziFrsLS60hGWAZnf1/ranW8xWDIGFMb0c41jD0Uj4diTkcvnEDkRNh11xLwT+3hK
         dOW6DCQDuvhVesX1cD2ZladHPPCWyt/zF+IxxEctCHdMEyqC7ZlgQmUcMa00y3OAKN
         9WRVXDkrysN+0/E31m5g83rSZOgZtQBAwguyk1MYOosHgWZuaqn1RuUznMrhOs4IK6
         3HfWHQCFU49lQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvPS24zCqz4wZw;
        Mon,  3 Jul 2023 08:51:30 +1000 (AEST)
Date:   Mon, 3 Jul 2023 08:51:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] of: fix htmldocs build warnings
Message-ID: <20230703085128.3d8cbf0e@canb.auug.org.au>
In-Reply-To: <c5db0099-a7fd-8f1c-16ad-8388d3cf6a05@infradead.org>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
        <20230310113258.463f836c@canb.auug.org.au>
        <20230322180032.1badd132@canb.auug.org.au>
        <c5db0099-a7fd-8f1c-16ad-8388d3cf6a05@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i4G9G7rZmlV77xksRQz4Qfn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i4G9G7rZmlV77xksRQz4Qfn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, 22 Mar 2023 11:50:53 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 3/22/23 00:00, Stephen Rothwell wrote:
> > Fix these htmldoc build warnings:
> >=20
> > include/linux/of.h:115: warning: cannot understand function prototype: =
'const struct kobj_type of_node_ktype; '
> > include/linux/of.h:118: warning: Excess function parameter 'phandle_nam=
e' description in 'of_node_init'
> >=20
> > Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node c=
reation functions")
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au> =20
>=20
>=20
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> Thanks.
>=20
> > ---
> >  include/linux/of.h | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > Replaces "[PATCH] of: fix htmldocs build warning" and additionally
> > fixes the new warning about phandle that Randy reported.
> >=20
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 9b7a99499ef3..d55dab9ad728 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -100,10 +100,12 @@ struct of_reconfig_data {
> >  	struct property		*old_prop;
> >  };
> > =20
> > +extern const struct kobj_type of_node_ktype;
> > +extern const struct fwnode_operations of_fwnode_ops;
> > +
> >  /**
> >   * of_node_init - initialize a devicetree node
> >   * @node: Pointer to device node that has been created by kzalloc()
> > - * @phandle_name: Name of property holding a phandle value
> >   *
> >   * On return the device_node refcount is set to one.  Use of_node_put()
> >   * on @node when done to free the memory allocated for it.  If the node
> > @@ -111,9 +113,6 @@ struct of_reconfig_data {
> >   * whether to free the memory will be done by node->release(), which is
> >   * of_node_release().
> >   */
> > -/* initialize a node */
> > -extern const struct kobj_type of_node_ktype;
> > -extern const struct fwnode_operations of_fwnode_ops;
> >  static inline void of_node_init(struct device_node *node)
> >  {
> >  #if defined(CONFIG_OF_KOBJ) =20

I am still getting the above warnings :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/i4G9G7rZmlV77xksRQz4Qfn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSh/3AACgkQAVBC80lX
0GwIpwf/aA4H4y8LTmzjdHcwtCNvdjPt77alVANDyuqLgIE6PsFWnhWsYfFxeuLL
WsbRtG75xhzwLUF629Ltmsjqm9V+cxwSrzSZ5009PLPMqMsie619wCf1dcAzopL+
UkyKbxD9VaSo5G8jHltvu+HrVh4BHuQfwrFSETkDkKTS20y/Gsd34X0bh8TFeXak
2ZmMAn2W4t0/UpJqKTDy1syZeJ7b/yvVEQ2nHhhzsMsEucOGPTZ8xerS5JaxAu5N
OwAj9UAJWSGjdHcQyZlPc9weIOH3YMPAULzW3XYBLaBM+lElC/RpzMO8uAac6MED
ziGAHPNi5FRxYdmJDPadjMS627AZtg==
=0ORD
-----END PGP SIGNATURE-----

--Sig_/i4G9G7rZmlV77xksRQz4Qfn--
