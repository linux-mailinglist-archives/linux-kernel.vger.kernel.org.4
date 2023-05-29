Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F45714CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjE2P0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjE2P0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DCBC9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685373950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSBcv+NaPNMlCQs57n9r+zaM6oZYLbvvoNzuJOFQqGM=;
        b=CHLLfCvyz53r97LCS6buPc9/PFiCPFE+8UF28lLZgSZQuzlQMGlHPkxGex9z6fKC4INf7p
        6cv5UQHWt2TweBlH7gMr019WT05eI2zi9Xnex2B5GHDuICJ8zCW5vJmpxKWfDs8BjwqMcN
        6zUfjfVAo9PRKcTPz/OhDbRrt+xD9+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-XH7gUsQvNB-qQ486QlxvLg-1; Mon, 29 May 2023 11:25:45 -0400
X-MC-Unique: XH7gUsQvNB-qQ486QlxvLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66225811E78;
        Mon, 29 May 2023 15:25:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A5040CFD45;
        Mon, 29 May 2023 15:25:44 +0000 (UTC)
Date:   Mon, 29 May 2023 11:25:43 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: virtio_scsi: Remove a useless function call
Message-ID: <20230529152543.GA889095@fedora>
References: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e47TU4KlPcthwDds"
Content-Disposition: inline
In-Reply-To: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e47TU4KlPcthwDds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 09:35:08AM +0200, Christophe JAILLET wrote:
> 'inq_result' is known to be NULL. There is no point calling kfree().
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/scsi/virtio_scsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--e47TU4KlPcthwDds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR0w/YACgkQnKSrs4Gr
c8hJeAf/WmB2oYBwLIM+8TSkvLF5FqEfpmrlGGWzY/u8GJU2N9vYRbK3hj8XopAx
/5QW9+w4nhzQiA6OajCWTD2H7ppbl0LyP2dyazgxpbclTy3onUcZ6zAkNVboh35j
8D8cucD4Hr92ZCMyw/39x5V7Gh7N4CDvtHJEMwWE7exufpzKmB+9r+qRV2LlYxNf
JmdCwXDR+0jOxLUFr1yl9WpvHQlU+28ElDdDcJXliAoIRljDsIk2rbWafuxDKzH1
UPkM7/iR0dFFMK97WGs/ibwrwCVCjA/yejo4GTl6K0sUFazHYVJkseq3869jJma2
7ZgTO+y4fyt7XodklSvimt2hWFPkIg==
=m2E9
-----END PGP SIGNATURE-----

--e47TU4KlPcthwDds--

