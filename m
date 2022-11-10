Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B312D624BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKJUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiKJUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1314D5DB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668111532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgL5/7r9Wym/g+B0pjsz3dgQTgEurnPH1LtAMA+rvcc=;
        b=fA+MyxA8PFS7ZZaOIOfiYcH/TLQYP0xN3ikgNtyiM2Q2TNotYU9VDtBhcT3NCgpMfRGhhG
        VTmRtMMwYIKm6jcCoH63OWDUWcRXew8QG5OvAcNeEvePDstEFIQhxPfpJAPaTntt8RJXCx
        kiyYZKvXwv3LitqB4eok+A1eJdOps8g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-x0G0q06wN6qNKRWnBYHEWQ-1; Thu, 10 Nov 2022 15:18:41 -0500
X-MC-Unique: x0G0q06wN6qNKRWnBYHEWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 013238582B9;
        Thu, 10 Nov 2022 20:18:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 768171121330;
        Thu, 10 Nov 2022 20:18:39 +0000 (UTC)
Date:   Thu, 10 Nov 2022 15:18:38 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     jasowang@redhat.com, mst@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        pbonzini@redhat.com
Subject: Re: [PATCH] virtio_blk: use UINT_MAX instead of -1U
Message-ID: <Y21cnhr1q6e6oNhp@fedora>
References: <20221110030124.1986-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EAV7xN6Mtl16GRtO"
Content-Disposition: inline
In-Reply-To: <20221110030124.1986-1-angus.chen@jaguarmicro.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EAV7xN6Mtl16GRtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 11:01:23AM +0800, Angus Chen wrote:
> We use UINT_MAX to limit max_discard_sectors in virtblk_probe,
> we can use UINT_MAX to limit max_hw_sectors for consistencies.
>=20
> No functional change intended.
>=20
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EAV7xN6Mtl16GRtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNtXJ4ACgkQnKSrs4Gr
c8hFTgf/VUUpU5e4Be8XmTk5FyYOu+JeRz6prpVZEnfw7rKvvZc4O2NVtavIYV/7
LbYA3WCbconInnqACqX1fCZ300zS0cWIYx9qFWTCcekj5eTJx2iM//3PWz605Lld
kA/B4A8Y9uJphud/8BLpVb58J8QGHPbLL5iSY9Ql/8jivezW8hniEQZVYoGjqECJ
84BZ1KIZ7ZdTGucZq7a3f1qLrafA5f5uTRQ9qk9dEwPJlBSSZauu+k1ehQQYdNv4
thqgGOkGl7Kygq2sGDAGP0DOTQ9f6jIACqZlaYPEPBLvXy4r4440QQt1e8gib3EN
qUqPkkgeCxv108rW7NWZKdwYsvYtsQ==
=L5h/
-----END PGP SIGNATURE-----

--EAV7xN6Mtl16GRtO--

