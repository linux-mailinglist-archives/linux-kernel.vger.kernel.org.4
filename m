Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0C5F3B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 03:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJDBwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 21:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 21:52:00 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5E2AC76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 18:51:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 791B53200708;
        Mon,  3 Oct 2022 21:51:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Oct 2022 21:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664848317; x=
        1664934717; bh=GeaBgt1FdrtLxvNF0Ehd+VorrUGsrwKbCOiCcyr1fnI=; b=i
        0xOhOpFy/C3v6ETYKs3JYt1YJsiWqYeZtp2zjFUFvvOPw1OhuiIsq6CAHvA5ip6t
        ld77BfcyuG272NGznXylqJj6t4J6Xl4MQp07gmY2Oqv6Ri6PGr8xHdSVjeFIQdRg
        pf9jAJck8QbzPIOhO2TLaSTZLHfZxSP6l3qCdRtAqu5QYxI8Zi6xGrhlM4W9GQTS
        EBTrsiPNuYCbVpvewdNFP7LjledZsk4AR4yCw00I9r7nv9o6nuFP8IJQM06TtTkU
        uJq2HsJu6SFiWm2rCLKblhxoawqjQ5GWQe6DdN77MCud3KGZyul3y1Nlnc5LEpJ+
        4nWIJjMUvdXIUZ6Xl2Umg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664848317; x=1664934717; bh=GeaBgt1FdrtLxvNF0Ehd+VorrUGs
        rwKbCOiCcyr1fnI=; b=uIu2KMV41dDGLynaUJMGVZAtKH7f5eVvWTlH/slxhFZ7
        e8NO/qozbebm1PdzPKt+AT1+zKcLzh9KvTVBEHq3M08xGPP9mKgk4I7SSe1GIcxB
        KN81mKacs6gqnDg1ovSBVK9vtth3th60GvDlBQ2jJb+dGvymsTw9AcDI5iLXL2gE
        SHz/wUzNluiFcnn9aCdceQ0jvuSTsnkzXik+1rhX6ETFWiw8dYq/arb44KSterH4
        rHSaUJ3HvuBiV44/BqLPCuzSfnTWdxe4l/fIFi5ntOI2wQep4jYDi+VydvTkqpSa
        F5sq2PtFdCsR7vxNQnxECmVh+cg7b2+cuKXN+tE7JA==
X-ME-Sender: <xms:vJE7Y42ne24GtELM2wV0-3ZhZuWMmMHDsRZHWOkCdhAoY3b5tJtj_A>
    <xme:vJE7YzEhIScTtRFRHKPrpiBIq1_7IQt7O71YLhyECHgk0ohfwcJ6wC8e5k-49U_PT
    BFa8_n9jaRHNK8>
X-ME-Received: <xmr:vJE7Yw6AeXtjat4vPWchAAI5g8to4RXN0s7Z6tneW4c8xDtz8bhHfmIIRubj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeitddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepuedthefhtddvffefjeejvdehvdej
    ieehffehkeekheegleeuleevleduteehteetnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    vghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:vJE7Yx2GkzEckhDH4-K9cvq-7RBjeS5P00MdPBoPGGyFVrSYVaz4Og>
    <xmx:vJE7Y7HsTauqqEpoKh3BvbRogDJCCvCin8EKJVdwZWY2m7IDiuakow>
    <xmx:vJE7Y69p5yT00JEJDiP4FV3iO_vm6vHNQ_Kt2wL0ZjdryxvR9pBrlg>
    <xmx:vZE7Y_hRX0WjuJ-OIwsqKcLOIAUgkQYg215tG5fL3LH33IrMwo0QVQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Oct 2022 21:51:55 -0400 (EDT)
Date:   Mon, 3 Oct 2022 21:51:11 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 1/2] xen/gntdev: Prevent leaking grants
Message-ID: <YzuRuD/t4/rZAkGG@itl-email>
References: <20221002222006.2077-1-m.v.b@runbox.com>
 <20221002222006.2077-2-m.v.b@runbox.com>
 <YzotDube4gTn7r9b@itl-email>
 <41d15ac1-7977-db49-f8e9-df642616c745@runbox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyzhu7rkdfkdzg5W"
Content-Disposition: inline
In-Reply-To: <41d15ac1-7977-db49-f8e9-df642616c745@runbox.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cyzhu7rkdfkdzg5W
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Oct 2022 21:51:11 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: "M. Vefa Bicakci" <m.v.b@runbox.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 1/2] xen/gntdev: Prevent leaking grants

On Mon, Oct 03, 2022 at 09:31:25PM -0400, M. Vefa Bicakci wrote:
> On 2022-10-02 20:29, Demi Marie Obenour wrote:
> > On Sun, Oct 02, 2022 at 06:20:05PM -0400, M. Vefa Bicakci wrote:
> > > Prior to this commit, if a grant mapping operation failed partially,
> > > some of the entries in the map_ops array would be invalid, whereas all
> > > of the entries in the kmap_ops array would be valid. This in turn wou=
ld
> > > cause the following logic in gntdev_map_grant_pages to become invalid:
> > >=20
> > >    for (i =3D 0; i < map->count; i++) {
> > >      if (map->map_ops[i].status =3D=3D GNTST_okay) {
> > >        map->unmap_ops[i].handle =3D map->map_ops[i].handle;
> > >        if (!use_ptemod)
> > >          alloced++;
> > >      }
> > >      if (use_ptemod) {
> > >        if (map->kmap_ops[i].status =3D=3D GNTST_okay) {
> > >          if (map->map_ops[i].status =3D=3D GNTST_okay)
> > >            alloced++;
> > >          map->kunmap_ops[i].handle =3D map->kmap_ops[i].handle;
> > >        }
> > >      }
> > >    }
> > >    ...
> > >    atomic_add(alloced, &map->live_grants);
> > >=20
> > > Assume that use_ptemod is true (i.e., the domain mapping the granted
> > > pages is a paravirtualized domain). In the code excerpt above, note t=
hat
> > > the "alloced" variable is only incremented when both kmap_ops[i].stat=
us
> > > and map_ops[i].status are set to GNTST_okay (i.e., both mapping
> > > operations are successful).  However, as also noted above, there are
> > > cases where a grant mapping operation fails partially, breaking the
> > > assumption of the code excerpt above.
> > >=20
> > > The aforementioned causes map->live_grants to be incorrectly set. In
> > > some cases, all of the map_ops mappings fail, but all of the kmap_ops
> > > mappings succeed, meaning that live_grants may remain zero. This in t=
urn
> > > makes it impossible to unmap the successfully grant-mapped pages poin=
ted
> > > to by kmap_ops, because unmap_grant_pages has the following snippet of
> > > code at its beginning:
> > >=20
> > >    if (atomic_read(&map->live_grants) =3D=3D 0)
> > >      return; /* Nothing to do */
> > >=20
> > > In other cases where only some of the map_ops mappings fail but all
> > > kmap_ops mappings succeed, live_grants is made positive, but when the
> > > user requests unmapping the grant-mapped pages, __unmap_grant_pages_d=
one
> > > will then make map->live_grants negative, because the latter function
> > > does not check if all of the pages that were requested to be unmapped
> > > were actually unmapped, and the same function unconditionally subtrac=
ts
> > > "data->count" (i.e., a value that can be greater than map->live_grant=
s)
> > > from map->live_grants. The side effects of a negative live_grants val=
ue
> > > have not been studied.
> > >=20
> > > The net effect of all of this is that grant references are leaked in =
one
> > > of the above conditions. In Qubes OS v4.1 (which uses Xen's grant
> > > mechanism extensively for X11 GUI isolation), this issue manifests
> > > itself with warning messages like the following to be printed out by =
the
> > > Linux kernel in the VM that had granted pages (that contain X11 GUI
> > > window data) to dom0: "g.e. 0x1234 still pending", especially after t=
he
> > > user rapidly resizes GUI VM windows (causing some grant-mapping
> > > operations to partially or completely fail, due to the fact that the =
VM
> > > unshares some of the pages as part of the window resizing, making the
> > > pages impossible to grant-map from dom0).
> > >=20
> > > The fix for this issue involves counting all successful map_ops and
> > > kmap_ops mappings separately, and then adding the sum to live_grants.
> > > During unmapping, only the number of successfully unmapped grants is
> > > subtracted from live_grants. The code is also modified to check for
> > > negative live_grants values after the subtraction and warn the user.
> > >=20
> > > Link: https://github.com/QubesOS/qubes-issues/issues/7631
> > > Fixes: dbe97cff7dd9 ("xen/gntdev: Avoid blocking in unmap_grant_pages=
()")
> >=20
> > Looks like this patch has been pretty buggy, sorry.  This is the second
> > time there has been a problem with it.  Thanks for the fix.
>=20
> Hi,
>=20
> No problem! :-) Debugging this issue and coming up with a fix was a
> nice challenge for me.

You=E2=80=99re welcome!  I=E2=80=99m glad you were able to do this.

> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
> > > ---
> > >=20
> > > Changes since v1:
> > > - To determine which unmap operations were successful, the previous
> > >    version of this patch set the "unmap_ops[i].status" and
> > >    "kunmap_ops[i].status" fields to the value "1" prior to passing th=
ese
> > >    data structures to the hypervisor. Instead of doing that, the code=
 now
> > >    checks whether the "handle" fields in the same data structures were
> > >    *not* set to "INVALID_GRANT_HANDLE". (Suggested by Juergen Gross.)
> > > ---
> > >   drivers/xen/gntdev.c | 22 +++++++++++++++++-----
> > >   1 file changed, 17 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > > index 84b143eef395..eb0586b9767d 100644
> > > --- a/drivers/xen/gntdev.c
> > > +++ b/drivers/xen/gntdev.c
> > > @@ -367,8 +367,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_ma=
p *map)
> > >   	for (i =3D 0; i < map->count; i++) {
> > >   		if (map->map_ops[i].status =3D=3D GNTST_okay) {
> > >   			map->unmap_ops[i].handle =3D map->map_ops[i].handle;
> > > -			if (!use_ptemod)
> > > -				alloced++;
> > > +			alloced++;
> > >   		} else if (!err)
> > >   			err =3D -EINVAL;
> > > @@ -377,8 +376,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_ma=
p *map)
> > >   		if (use_ptemod) {
> > >   			if (map->kmap_ops[i].status =3D=3D GNTST_okay) {
> > > -				if (map->map_ops[i].status =3D=3D GNTST_okay)
> > > -					alloced++;
> > > +				alloced++;
> > >   				map->kunmap_ops[i].handle =3D map->kmap_ops[i].handle;
> > >   			} else if (!err)
> > >   				err =3D -EINVAL;
> > > @@ -394,8 +392,14 @@ static void __unmap_grant_pages_done(int result,
> > >   	unsigned int i;
> > >   	struct gntdev_grant_map *map =3D data->data;
> > >   	unsigned int offset =3D data->unmap_ops - map->unmap_ops;
> > > +	int successful_unmaps =3D 0;
> > > +	int live_grants;
> > >   	for (i =3D 0; i < data->count; i++) {
> > > +		if (map->unmap_ops[offset + i].status =3D=3D GNTST_okay &&
> > > +		    map->unmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE)
> > > +			successful_unmaps++;
> > > +
> > >   		WARN_ON(map->unmap_ops[offset + i].status !=3D GNTST_okay &&
> > >   			map->unmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE);
> > >   		pr_debug("unmap handle=3D%d st=3D%d\n",
> > > @@ -403,6 +407,10 @@ static void __unmap_grant_pages_done(int result,
> > >   			map->unmap_ops[offset+i].status);
> > >   		map->unmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
> > >   		if (use_ptemod) {
> > > +			if (map->kunmap_ops[offset + i].status =3D=3D GNTST_okay &&
> > > +			    map->kunmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE)
> > > +				successful_unmaps++;
> > > +
> > >   			WARN_ON(map->kunmap_ops[offset + i].status !=3D GNTST_okay &&
> > >   				map->kunmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE);
> > >   			pr_debug("kunmap handle=3D%u st=3D%d\n",
> > > @@ -411,11 +419,15 @@ static void __unmap_grant_pages_done(int result,
> > >   			map->kunmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
> > >   		}
> > >   	}
> > > +
> > >   	/*
> > >   	 * Decrease the live-grant counter.  This must happen after the lo=
op to
> > >   	 * prevent premature reuse of the grants by gnttab_mmap().
> > >   	 */
> > > -	atomic_sub(data->count, &map->live_grants);
> > > +	live_grants =3D atomic_sub_return(successful_unmaps, &map->live_gra=
nts);
> > > +	if (WARN_ON(live_grants < 0))
> > > +		pr_err("%s: live_grants became negative (%d) after unmapping %d pa=
ges!\n",
> > > +		       __func__, live_grants, successful_unmaps);
> > >   	/* Release reference taken by __unmap_grant_pages */
> > >   	gntdev_put_map(NULL, map);
> > > --=20
> > > 2.37.3
> >=20
> > Is there a possibility that live_grants could overflow, as it is now
> > set to a value twice as large as what it had been previously?
>=20
> Good point! My answer in summary: I think that the code could be improved,
> but with reasonable values for the "limit" module parameter, there should
> not be issues.
>=20
> Grant mappings are set up via ioctl calls, and the structure field that
> holds the number of grant references has u32 type:
>=20
> (Quoting from kernel v5.15.71 for convenience)
> include/uapi/xen/gntdev.h
> =3D=3D=3D 8< =3D=3D=3D
> struct ioctl_gntdev_map_grant_ref {
> 	/* IN parameters */
> 	/* The number of grants to be mapped. */
> 	__u32 count;
> =3D=3D=3D >8 =3D=3D=3D
>=20
> However, the number of grant references is further limited in the actual
> ioctl handler function gntdev_ioctl_map_grant_ref(), which calls
> gntdev_test_page_count() to ensure that the number of granted pages
> requested to be mapped does not exceed "limit". "limit" defaults to 64K,
> which should be okay to use with an atomic_t type (i.e., a 32-bit signed
> integer type) like "live_grants", assuming that the system administrator
> does not go overboard and set "limit" to a very large value:
>=20
> drivers/xen/gntdev.c
> =3D=3D=3D 8< =3D=3D=3D
> static unsigned int limit =3D 64*1024;
> module_param(limit, uint, 0644);
> MODULE_PARM_DESC(limit,
> 	"Maximum number of grants that may be mapped by one mapping request");
>=20
> /* trimmed */
>=20
> bool gntdev_test_page_count(unsigned int count)
> {
> 	return !count || count > limit;
> }
>=20
> /* trimmed */
>=20
> static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
> 				       struct ioctl_gntdev_map_grant_ref __user *u)
> {
> 	/* trimmed */
>=20
> 	pr_debug("priv %p, add %d\n", priv, op.count);
> 	if (unlikely(gntdev_test_page_count(op.count)))
> 		return -EINVAL;
>=20
> 	/* trimmed */
> }
> =3D=3D=3D >8 =3D=3D=3D
>=20
> To be fair, the "count" field of the gndev_grant_map structure is a signed
> integer, so very large values of count could overflow live_grants, as
> live_grants needs to accommodate values up to and including 2*count.

Could this be replaced by an unsigned and/or 64-bit integer?
Alternatively, one could use module_param_cb and param_set_uint_minmax
to enforce that the limit is something reasonable.  That said, one needs
almost 8TiB to trigger this problem, so while it ought to be fixed it
isn=E2=80=99t a huge deal.  Certainly should not block getting this merged.

> drivers/xen/gntdev-common.h
> =3D=3D=3D 8< =3D=3D=3D
> struct gntdev_grant_map {
> 	atomic_t in_use;
> 	struct mmu_interval_notifier notifier;
> 	bool notifier_init;
> 	struct list_head next;
> 	int index;
> 	int count;
> 	/* trimmed */
> }
> =3D=3D=3D >8 =3D=3D=3D
>=20
> > If not, you can add:
> >=20
> > Acked-by: Demi Marie Obenour <demi@invisiblethingslab.com>
>=20
> Thank you! I hope that the explanation and rationale above are satisfacto=
ry.
> Please let me know what you think.

They are indeed.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--cyzhu7rkdfkdzg5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM7kbkACgkQsoi1X/+c
IsEGVw//QnqEuYP0GFBlmXL0SIvtd1fK6TGdEUcdBmAuYKt82XvCiL6zfoGrF9Uo
VDY9CQLI9mUx5lWZeRo9sYLjU9cKNW6vzVn9nvsGEddB8LGuTeLSGKknU7T6Q2RM
oYYWyiyWZUFLoqC3iMpUx7TXBs/cpB2Q1K8B7PdHOdwfLhnZniKDIKArHjIQb/2q
UjzbltfulaDEZwKBSCbxfWq0nS5a7tT5p3+5kL4fpAc9mzcgCofZhLBz4UcH4IJl
U91Th2N/UD7dL5rA4FqRbt46VQI/5Ud81q87k7MRXH0eOe5m51LPGdaVTEwHWeUX
omDDj9uzNjrS+CfVyebaQA0L/mYmxw3gP3NkcDMKlGQhSC+6IiXolYXwXta/ppRq
MtTjA2XDbi0BigDLsTUNhuy4h/eQjdve6jm0Frl3K3uNf0GoSTfgGoY0FwP3EPUd
mOjEHM9XLA6VahQc/Hz6lDvUJgLIgCxn/T2GOs4thVVIGRhuwAaQ7hkiLsaiPSp2
rpYaTwb8TwTf9eiBya5aCWEV63nQC8C7aXIKgwtLNxyPxeZ/GcycY0UJRn8mZeEN
6nunp6anKWTqcT5A0v+CPuPbMF5GzxIKx8248PjOckj73C+XAEAYzfImkxfxaMY/
yWV4pS8Ybvvhh49GZFpSnLMDKtdMjXofd3rAbiY4pwkriAoL29U=
=GO41
-----END PGP SIGNATURE-----

--cyzhu7rkdfkdzg5W--
