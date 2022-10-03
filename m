Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582115F2760
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 02:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJCAaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 20:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJCAaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 20:30:14 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB416587
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 17:30:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BE0F5C008F;
        Sun,  2 Oct 2022 20:30:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 02 Oct 2022 20:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664757009; x=
        1664843409; bh=Z/3fPXqHkxLvccFTzKhxM1kh18KV+Cenh/41gK+IhpI=; b=Z
        D8Bzycy09HpE3xYgQHiXzBpdfoAkfCDQ+wi+zjfd0qMnmRVlePBdgEs4juDyk6r/
        8+HiA7UyK+5Qn+AiASg1h/j6BKiI7y7d4NErZun+JzIpZ48v1Xkuu7x2tj1oorUy
        BS0Dv8rGDGVw2vLg4g8ce3ARBVPKMUxu96jv/9PsfqWIr9nI4nzXRMCw1jcSoevH
        66APp/CqX69/mYVCqd6r/kHWruklj1I+lv0nv1ta2eNdOvnhJlLLabJhNI4bRCWc
        2FIYFeI7jVTNWZ/nDu5UrAuaildnmWAdEZhnVKFTho4Nf7Yhv4h0SS8M7Ab4RSv7
        GCgDfhaaqaXQgMa09b0qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664757009; x=1664843409; bh=Z/3fPXqHkxLvccFTzKhxM1kh18KV
        +Cenh/41gK+IhpI=; b=ofS7b3luTnNUN4AtFqv/WuMerBjFOSn+5LV07RbucO6N
        9jTuICkd4uI2L0rNzIFnZCU0Z/gt4nFhwAuSpY98bxrNNBNBuzN0cDM0oD6gtEKz
        58cXj2dXqdE0oTXIOfKGaFPlk4A46ub8AZ6eg7bFlrE8ou39K4xMf4pTjpEu9aVQ
        WOG0uXRtNLOqBXNJYx2hTbkeC3AOQj9Vm5Yruz/iVFHb/tYHKcStJK8JupVx7slI
        X3XbmIQpvYMAmIEAfB986AAPuSUi8bEhtG1I4ygvTMK49Op4tjdr99GGBD0aoM6b
        WO4Xd62Wc4tiwmEf1YWOApQjjvTZm8/8O/MBFtn15g==
X-ME-Sender: <xms:EC06Yz4DAcCHX55brUwmYYxlVKAjvCYmb9QdzflE-DNplnRtkgS59g>
    <xme:EC06Y44xdrLfndOTyPAF316HMAka63DvQqdiFODrLcutDJXm7vwFVvDVG4vExvBTq
    EXMOIoEKXFtuEM>
X-ME-Received: <xmr:EC06Y6cFIfelQNBkcDfDzAQjV73Ohrv7IuDMQLZSJqL9R14NLGbvya0QQmQi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeuvdekffffieduhedtkeevkedu
    fedvkeeiheffvdegueetteehgfefieetudfgnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    vghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:ES06Y0Le-jDevxbMM0UpqOpoSFAaSQP-MS4wzoT-6j1tGSY9Igri5A>
    <xmx:ES06Y3Kym5tvLCZEPgu0jxXjA_bZBk-7XQH2gGsd2DEu46ob--Y5kQ>
    <xmx:ES06Y9wCnAFFko8ap7rfovubX3hkPhVm8y6_8JV2PDMT-93iXZaujQ>
    <xmx:ES06Y0E0dL4Ka8lmAbd3h8fuMD5pYvjo09ggeEy6oHhz7W4LO4m3Pw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Oct 2022 20:30:08 -0400 (EDT)
Date:   Sun, 2 Oct 2022 20:29:59 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 1/2] xen/gntdev: Prevent leaking grants
Message-ID: <YzotDube4gTn7r9b@itl-email>
References: <20221002222006.2077-1-m.v.b@runbox.com>
 <20221002222006.2077-2-m.v.b@runbox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3VIftLCTfH9xeQV"
Content-Disposition: inline
In-Reply-To: <20221002222006.2077-2-m.v.b@runbox.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3VIftLCTfH9xeQV
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 2 Oct 2022 20:29:59 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: "M. Vefa Bicakci" <m.v.b@runbox.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 1/2] xen/gntdev: Prevent leaking grants

On Sun, Oct 02, 2022 at 06:20:05PM -0400, M. Vefa Bicakci wrote:
> Prior to this commit, if a grant mapping operation failed partially,
> some of the entries in the map_ops array would be invalid, whereas all
> of the entries in the kmap_ops array would be valid. This in turn would
> cause the following logic in gntdev_map_grant_pages to become invalid:
>=20
>   for (i =3D 0; i < map->count; i++) {
>     if (map->map_ops[i].status =3D=3D GNTST_okay) {
>       map->unmap_ops[i].handle =3D map->map_ops[i].handle;
>       if (!use_ptemod)
>         alloced++;
>     }
>     if (use_ptemod) {
>       if (map->kmap_ops[i].status =3D=3D GNTST_okay) {
>         if (map->map_ops[i].status =3D=3D GNTST_okay)
>           alloced++;
>         map->kunmap_ops[i].handle =3D map->kmap_ops[i].handle;
>       }
>     }
>   }
>   ...
>   atomic_add(alloced, &map->live_grants);
>=20
> Assume that use_ptemod is true (i.e., the domain mapping the granted
> pages is a paravirtualized domain). In the code excerpt above, note that
> the "alloced" variable is only incremented when both kmap_ops[i].status
> and map_ops[i].status are set to GNTST_okay (i.e., both mapping
> operations are successful).  However, as also noted above, there are
> cases where a grant mapping operation fails partially, breaking the
> assumption of the code excerpt above.
>=20
> The aforementioned causes map->live_grants to be incorrectly set. In
> some cases, all of the map_ops mappings fail, but all of the kmap_ops
> mappings succeed, meaning that live_grants may remain zero. This in turn
> makes it impossible to unmap the successfully grant-mapped pages pointed
> to by kmap_ops, because unmap_grant_pages has the following snippet of
> code at its beginning:
>=20
>   if (atomic_read(&map->live_grants) =3D=3D 0)
>     return; /* Nothing to do */
>=20
> In other cases where only some of the map_ops mappings fail but all
> kmap_ops mappings succeed, live_grants is made positive, but when the
> user requests unmapping the grant-mapped pages, __unmap_grant_pages_done
> will then make map->live_grants negative, because the latter function
> does not check if all of the pages that were requested to be unmapped
> were actually unmapped, and the same function unconditionally subtracts
> "data->count" (i.e., a value that can be greater than map->live_grants)
> from map->live_grants. The side effects of a negative live_grants value
> have not been studied.
>=20
> The net effect of all of this is that grant references are leaked in one
> of the above conditions. In Qubes OS v4.1 (which uses Xen's grant
> mechanism extensively for X11 GUI isolation), this issue manifests
> itself with warning messages like the following to be printed out by the
> Linux kernel in the VM that had granted pages (that contain X11 GUI
> window data) to dom0: "g.e. 0x1234 still pending", especially after the
> user rapidly resizes GUI VM windows (causing some grant-mapping
> operations to partially or completely fail, due to the fact that the VM
> unshares some of the pages as part of the window resizing, making the
> pages impossible to grant-map from dom0).
>=20
> The fix for this issue involves counting all successful map_ops and
> kmap_ops mappings separately, and then adding the sum to live_grants.
> During unmapping, only the number of successfully unmapped grants is
> subtracted from live_grants. The code is also modified to check for
> negative live_grants values after the subtraction and warn the user.
>=20
> Link: https://github.com/QubesOS/qubes-issues/issues/7631
> Fixes: dbe97cff7dd9 ("xen/gntdev: Avoid blocking in unmap_grant_pages()")

Looks like this patch has been pretty buggy, sorry.  This is the second
time there has been a problem with it.  Thanks for the fix.

> Cc: stable@vger.kernel.org
> Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
> ---
>=20
> Changes since v1:
> - To determine which unmap operations were successful, the previous
>   version of this patch set the "unmap_ops[i].status" and
>   "kunmap_ops[i].status" fields to the value "1" prior to passing these
>   data structures to the hypervisor. Instead of doing that, the code now
>   checks whether the "handle" fields in the same data structures were
>   *not* set to "INVALID_GRANT_HANDLE". (Suggested by Juergen Gross.)
> ---
>  drivers/xen/gntdev.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index 84b143eef395..eb0586b9767d 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -367,8 +367,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *m=
ap)
>  	for (i =3D 0; i < map->count; i++) {
>  		if (map->map_ops[i].status =3D=3D GNTST_okay) {
>  			map->unmap_ops[i].handle =3D map->map_ops[i].handle;
> -			if (!use_ptemod)
> -				alloced++;
> +			alloced++;
>  		} else if (!err)
>  			err =3D -EINVAL;
> =20
> @@ -377,8 +376,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *m=
ap)
> =20
>  		if (use_ptemod) {
>  			if (map->kmap_ops[i].status =3D=3D GNTST_okay) {
> -				if (map->map_ops[i].status =3D=3D GNTST_okay)
> -					alloced++;
> +				alloced++;
>  				map->kunmap_ops[i].handle =3D map->kmap_ops[i].handle;
>  			} else if (!err)
>  				err =3D -EINVAL;
> @@ -394,8 +392,14 @@ static void __unmap_grant_pages_done(int result,
>  	unsigned int i;
>  	struct gntdev_grant_map *map =3D data->data;
>  	unsigned int offset =3D data->unmap_ops - map->unmap_ops;
> +	int successful_unmaps =3D 0;
> +	int live_grants;
> =20
>  	for (i =3D 0; i < data->count; i++) {
> +		if (map->unmap_ops[offset + i].status =3D=3D GNTST_okay &&
> +		    map->unmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE)
> +			successful_unmaps++;
> +
>  		WARN_ON(map->unmap_ops[offset + i].status !=3D GNTST_okay &&
>  			map->unmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE);
>  		pr_debug("unmap handle=3D%d st=3D%d\n",
> @@ -403,6 +407,10 @@ static void __unmap_grant_pages_done(int result,
>  			map->unmap_ops[offset+i].status);
>  		map->unmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
>  		if (use_ptemod) {
> +			if (map->kunmap_ops[offset + i].status =3D=3D GNTST_okay &&
> +			    map->kunmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE)
> +				successful_unmaps++;
> +
>  			WARN_ON(map->kunmap_ops[offset + i].status !=3D GNTST_okay &&
>  				map->kunmap_ops[offset + i].handle !=3D INVALID_GRANT_HANDLE);
>  			pr_debug("kunmap handle=3D%u st=3D%d\n",
> @@ -411,11 +419,15 @@ static void __unmap_grant_pages_done(int result,
>  			map->kunmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
>  		}
>  	}
> +
>  	/*
>  	 * Decrease the live-grant counter.  This must happen after the loop to
>  	 * prevent premature reuse of the grants by gnttab_mmap().
>  	 */
> -	atomic_sub(data->count, &map->live_grants);
> +	live_grants =3D atomic_sub_return(successful_unmaps, &map->live_grants);
> +	if (WARN_ON(live_grants < 0))
> +		pr_err("%s: live_grants became negative (%d) after unmapping %d pages!=
\n",
> +		       __func__, live_grants, successful_unmaps);
> =20
>  	/* Release reference taken by __unmap_grant_pages */
>  	gntdev_put_map(NULL, map);
> --=20
> 2.37.3

Is there a possibility that live_grants could overflow, as it is now
set to a value twice as large as what it had been previously?

If not, you can add:

Acked-by: Demi Marie Obenour <demi@invisiblethingslab.com>
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--g3VIftLCTfH9xeQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM6LQ8ACgkQsoi1X/+c
IsE/mxAAjAWZ3FBXk78lfnRfKqcGSGmPfM6Mztzu0e1i3Q1ckY25IIvfM8kKRc/y
LpUo2Ei39YXyJNitexDxjqd2+HfOYOI1Ln2mmiI8IpvjBSgTwOO5XAA8YoSstc8g
IQUXK+wukBYaO+AAmb0JPMhpfKGrDV0tvfyz4G2k7u11pcY8F218pAiSQHtoSrCg
3MCO0g7rZMCwM6CcWiHup5dujAzgUDgr0Zen1JWAicRjeXewHoSCDcPwdTHWExft
ETT/FcI67wjSL9QTiCliZDLBcuJ4/HMs6fNDv8SFB0xM29ebxN08aJFyHzqps/8A
ZOA5n5g6Ltnjda9f7k9Zfx+nLkn2aKaw4qc5YLMqt0XzdVPMZEGiOo8mZvnlMfHK
V/QczwqHXcX4bPw/gjftXFIdXQN7jWOfr2svI5Lp07jD5QVhHQD3/2Asgjh6U9/F
R1j1c6i34SuVothF9kHKtBRGW/L7wY5WrLBOx75uXSYB/aKVgewNA1aVo+098sRN
6/TtuYnwmSAJl3O0iIMYaXME6+CRU63b2XMj/1t1KE9N1nfcNPqqegABhIQbgn0q
kBz9a+DGhjb7xSwN56g4JUpQ2A48ij7/x7aQGkQqbkfUBQsyLZNGS5ALhEmEUaIZ
MOKGzzC8G5IgwyvXa/+mdloMIZkyWUYqQ/lECYAjv3BhTPxTIWQ=
=6a+L
-----END PGP SIGNATURE-----

--g3VIftLCTfH9xeQV--
