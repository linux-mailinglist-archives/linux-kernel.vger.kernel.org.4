Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C0374E360
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGKBTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGKBTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:19:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE819AA;
        Mon, 10 Jul 2023 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689038230;
        bh=r7uxpV11jSeaVAgCvED5AOMsk39lPtkrYKKKN2qj+sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qo/Sk9UVTtUHtbn95isa8UXMOGAn2rgMaTlT0B1Od1S/VbKlFKaMcySkc4By/8KKd
         AvzrIFcgwntIslAmfI6+DyyhY36qjgYDRvOCC7giGQ2+rBkb4nPDHTiM7rbYfuM7Dy
         KQzz8nI77qvayxTu+Sx+uLorNvXP9z5PJKc6m/+8NRxy8tUO8SO4PUVuz+lRPt4f34
         vRc5GqnFYRZKLGw0+qwSi0GUAwc2f58QQNJNy4pH9zwyJo6shdGfxbBj+rv5Z3z8Mn
         v4ibkb3Wzp4W42pgFgV+IqZrO2ruaNqeOJt4VidSRBYHCPK4rWS01mMFRBz41EWvVP
         uzwMYBz4JdGrQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0NJP1mZrz4wyF;
        Tue, 11 Jul 2023 11:17:09 +1000 (AEST)
Date:   Tue, 11 Jul 2023 11:17:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the
 drm-misc-fixes tree
Message-ID: <20230711111707.05d2c8b2@canb.auug.org.au>
In-Reply-To: <20230627115432.6179f0ea@canb.auug.org.au>
References: <20230627115432.6179f0ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tT8FL3fDMyck2qEDkk/.e/a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tT8FL3fDMyck2qEDkk/.e/a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 27 Jun 2023 11:54:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the drm tree got a conflict in:
>=20
>   include/drm/gpu_scheduler.h
>=20
> between commit:
>=20
>   db8b4968a8d0 ("drm/sched: Call drm_sched_fence_set_parent() from drm_sc=
hed_fence_scheduled()")
>=20
> from the drm-misc-fixes tree and commit:
>=20
>   539f9ee4b52a ("drm/scheduler: properly forward fence errors")
>=20
> from the drm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc include/drm/gpu_scheduler.h
> index b29e347b10a9,e95b4837e5a3..000000000000
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@@ -581,16 -581,18 +581,17 @@@ void drm_sched_entity_push_job(struct d
>   void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
>   				   enum drm_sched_priority priority);
>   bool drm_sched_entity_is_ready(struct drm_sched_entity *entity);
> + int drm_sched_entity_error(struct drm_sched_entity *entity);
>  =20
>  -void drm_sched_fence_set_parent(struct drm_sched_fence *s_fence,
>  -				struct dma_fence *fence);
>   struct drm_sched_fence *drm_sched_fence_alloc(
>   	struct drm_sched_entity *s_entity, void *owner);
>   void drm_sched_fence_init(struct drm_sched_fence *fence,
>   			  struct drm_sched_entity *entity);
>   void drm_sched_fence_free(struct drm_sched_fence *fence);
>  =20
>  -void drm_sched_fence_scheduled(struct drm_sched_fence *fence);
>  +void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
>  +			       struct dma_fence *parent);
> - void drm_sched_fence_finished(struct drm_sched_fence *fence);
> + void drm_sched_fence_finished(struct drm_sched_fence *fence, int result=
);
>  =20
>   unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched=
);
>   void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,

This is now a conflict between the drm-misc-fixes tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/tT8FL3fDMyck2qEDkk/.e/a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsrZMACgkQAVBC80lX
0GxRkQf/UPcZ8xn0EtVhBVzVXfoMc/wQYaQHwDbf3VARrURbheu3OSQ9kIbgaqvV
c717MNShUqkfN/44Ctqrhd37h1nNQguNz6R+fcuhVBbCdAnlgKqNo1p6QkrC1W3n
gGMlFohwDBvRnBw+yqqdXuhQP6HiBTShoRgHFH2G2xBFkbKhLjYxUB+eOJyocBSJ
xwkuy/tf620xa8Wv9FXrcYHx9mpOjjrl1Gcjx0mF/KRQL+6NP7o8unYsXJ24lA4o
nhldhr6wk37VowB9VBgROkGRlvh5//ptJ7cEHNLDUU58mK5H+R/DNqmv2zvmYo0c
rr+FkKgNH1lQUPcufbdCstcEjkqITw==
=MRSk
-----END PGP SIGNATURE-----

--Sig_/tT8FL3fDMyck2qEDkk/.e/a--
