Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172D865275E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiLTTwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiLTTw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130701A38F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671565903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vD/zGthR9y9cp0sBA0D/PFJmbt+XTjArn3I7GDki5rA=;
        b=BrbY4+WgruwoaEnxK7tzAVMLoOpua73RBwq1kt6cL6RtzIoOHqsvTh6avaNwmcfACqiijq
        QPT2pqvvj9LSr4dRd53aSS/6n8OpsrH0VnkEDpwLYEUvMCYVDOj5wCPJRn/cvC+JvqH5zn
        AGg+Yz3t4NXoALS4M+um9dvqApqoIHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-pQZLdXApOFCL6zTarZfEYA-1; Tue, 20 Dec 2022 14:51:39 -0500
X-MC-Unique: pQZLdXApOFCL6zTarZfEYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47F3685C064;
        Tue, 20 Dec 2022 19:51:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABD9B2166B26;
        Tue, 20 Dec 2022 19:51:38 +0000 (UTC)
Date:   Tue, 20 Dec 2022 14:51:37 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: zone append in header type tweak
Message-ID: <Y6ISSd9KO/H7PnzU@fedora>
References: <20221220125154.564265-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W0kG+D50n8NSuIM5"
Content-Disposition: inline
In-Reply-To: <20221220125154.564265-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W0kG+D50n8NSuIM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 07:52:01AM -0500, Michael S. Tsirkin wrote:
> virtio blk returns a 64 bit append_sector in an input buffer,
> in LE format. This field is not tagged as LE correctly, so
> even though the generated code is ok, we get warnings from sparse:
>=20
> drivers/block/virtio_blk.c:332:33: sparse: sparse: cast to restricted __l=
e64
>=20
> Make sparse happy by using the correct type.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--W0kG+D50n8NSuIM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOiEkgACgkQnKSrs4Gr
c8iNRQgAt/Ziu/OblXb2XoKR+f7qPFmOtVHoJhXnIfcjUk86QzcjWhpFOeW4l2T9
WX0xeNUJhbGB7wUgM63B/uGl/d058Y8EV2iws20GQAdc4mNTIwPbJR0rPzCkgzJs
EGo4+XWbtjleadgdBjInSupNjDe8zaH9cTdNpioqrB4N/RRU31tCR8HGnkDF4M16
Fu84ReQmb+B83dJQGL4og+3gfTvRfOGaDwoEJA/opcUblmO0/U/M/+lom/+NqiOw
hAdtpKE42PtZ+pOYxg93Yzg4v44+WsrrRFJqHswOC6DTGO1d/4BQimvrin2+m5yT
989ihIDLHsIAEGnKz+HSp9EHpbUAlA==
=xJHb
-----END PGP SIGNATURE-----

--W0kG+D50n8NSuIM5--

