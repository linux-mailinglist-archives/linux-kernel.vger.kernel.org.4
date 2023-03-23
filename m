Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B86C5AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCWADU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCWADS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:03:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA659D0;
        Wed, 22 Mar 2023 17:03:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Phlsq5wqCz4x1f;
        Thu, 23 Mar 2023 11:03:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679529792;
        bh=n0enpLCZvWmG6bFWPqo0Rw+xEn9g4YjaOIY3IBc+fqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IoVJc4iuEDVzyLREoNd/34fF2IWuGFiJGjIZm4OgHmHhIqlcgUlGIQFYzqzkOOBKF
         mswFcIsGgJGkihFVwsQc4VGRVmMb23JOychaCD7EBUWd5nTOUkkfQcAoUOIKxhnD9a
         5xHUISRxd81teUly3Gsmxn/+ihFJeqVJfi9MUHYlTG9mdXpu+P+4QneXCeAdqpVF6W
         MpgbE1LKdLcl8tylyvi/zwEdv6IR8FS4o+vu+d8u8/ovNIbDV/zPt3WVVnn37hCove
         9/SdaZPlrmrTMtH+uN+wTnuWSCRNyV4m5VxYkWlZ/gS7rH5jeba1WeWdC8vwq1itv/
         yn8gXeofA/nCw==
Date:   Thu, 23 Mar 2023 11:03:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: linux-next: manual merge of the block tree with the mm tree
Message-ID: <20230323110311.589d2f36@canb.auug.org.au>
In-Reply-To: <20230322162638.d940201434ac3a3a29968979@linux-foundation.org>
References: <20230323100204.0917cecf@canb.auug.org.au>
        <3431084.1679526799@warthog.procyon.org.uk>
        <82ade7f2-017e-af6b-2fb3-eb1a3f570505@kernel.dk>
        <20230322162638.d940201434ac3a3a29968979@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HoWj3b0WqRWOvnqnabq/CMn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HoWj3b0WqRWOvnqnabq/CMn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 Mar 2023 16:26:38 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> fyi, Lorenzo has sent out v7 of this series.  I'll be pushing this in
> an hour or so.  After which I suggest Stephen removes those (now) two
> lines and sends out one of his "build fix" emails which can be the
> basis for Linus's resolution.

I have not picked up v7 (I will get that tomorrow), but I have gone
back in today's tree and changed the merge resolution to be as below.
--=20
Cheers,
Stephen Rothwell

diff --cc lib/iov_iter.c
index 48ca1c5dfc04,fad95e4cf372..389cc8a53097
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@@ -821,60 -532,6 +532,29 @@@ size_t copy_page_from_iter_atomic(struc
  }
  EXPORT_SYMBOL(copy_page_from_iter_atomic);
 =20
 +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset, size_=
t bytes,
 +				struct iov_iter *i)
 +{
 +	char *kaddr =3D kmap_local_page(page);
 +	char *p =3D kaddr + offset;
 +	size_t copied =3D 0;
 +
 +	if (!page_copy_sane(page, offset, bytes) ||
 +	    WARN_ON_ONCE(i->data_source))
 +		goto out;
 +
- 	if (unlikely(iov_iter_is_pipe(i))) {
- 		copied =3D copy_page_to_iter_pipe(page, offset, bytes, i);
- 		goto out;
- 	}
-=20
 +	iterate_and_advance(i, bytes, base, len, off,
 +		copyout(base, p + off, len),
 +		memcpy(base, p + off, len)
 +	)
 +	copied =3D bytes;
 +
 +out:
 +	kunmap_local(kaddr);
 +	return copied;
 +}
 +EXPORT_SYMBOL(copy_page_to_iter_atomic);
 +
- static void pipe_advance(struct iov_iter *i, size_t size)
- {
- 	struct pipe_inode_info *pipe =3D i->pipe;
- 	int off =3D i->last_offset;
-=20
- 	if (!off && !size) {
- 		pipe_discard_from(pipe, i->start_head); // discard everything
- 		return;
- 	}
- 	i->count -=3D size;
- 	while (1) {
- 		struct pipe_buffer *buf =3D pipe_buf(pipe, i->head);
- 		if (off) /* make it relative to the beginning of buffer */
- 			size +=3D abs(off) - buf->offset;
- 		if (size <=3D buf->len) {
- 			buf->len =3D size;
- 			i->last_offset =3D last_offset(buf);
- 			break;
- 		}
- 		size -=3D buf->len;
- 		i->head++;
- 		off =3D 0;
- 	}
- 	pipe_discard_from(pipe, i->head + 1); // discard everything past this one
- }
-=20
  static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
  {
  	const struct bio_vec *bvec, *end;

--Sig_/HoWj3b0WqRWOvnqnabq/CMn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQblz8ACgkQAVBC80lX
0GxdGwgAiYGUkECXwb4cNzsBNLuL3YbK1WrELYq9pC8d3vcuiEeMUTDJgHV5ZBRY
CkLD9FbubwWInFxAvJQevxrh3e/6xWxdoE/znH497qfONyI29l8/dAZ1pYuB8G0h
U2vZ3AhpebHoatzYmlpxoT3zQEAH3oZV/047hk3H3H02lX6i4XN+35vqPZIJ0LId
ogDspWgy8qUJb24UU5X58boaUEdU1SaYIvIS3CGjTYBSPkQOFIDNeX7/pmbPM7Rj
vs1misSRGibYGcQbXnBRH1nM4Nj+6RQROsuu2TEreQ8+57AoJrs701rAyAwH8uDz
/iXScTfackSmZQp0UJCveUoyQUkyEg==
=WaFz
-----END PGP SIGNATURE-----

--Sig_/HoWj3b0WqRWOvnqnabq/CMn--
