Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9982269ED0D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBVCtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjBVCtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:49:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AECF3A96;
        Tue, 21 Feb 2023 18:49:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PM0x50P1qz4x82;
        Wed, 22 Feb 2023 13:49:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677034170;
        bh=UK8G0wommme/BILYGrNKWfZ4d8MuBmFN7MTmUXWDXQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sJkFa/Dhy3mqX0qHxVe43tkiog78CLh6G3oJQuW0LWq7lIhebOm9hQ8RaTaerG6Hw
         lFrneZuQ8eZCYjcYXWWlmFu3+GftyU6hq0muJc8X+Pz2CmftWBw6iCW5f4Mbsb4Rev
         c/bk05xI5/SfgLVNWhPLLOJ7jOnCoEbJATDMKGodv5z9wbeyKw6YlHxxg5lrgLtgKR
         TPELJH1d35tRsLf0m73AXH0bHazTSFgHxTttew0hwvt9XAgpDhI4rCNZ9hMTIKeuMv
         t+Aa3Lg8d5ASjtmhDSM0ile8NkhStkbz5QfJnMd1aH6pKqRw7BAfYzqnwNkuCFzDtz
         6vd/xrX7foEhQ==
Date:   Wed, 22 Feb 2023 13:49:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@cjr.nz>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs
 tree
Message-ID: <20230222134927.459b036b@canb.auug.org.au>
In-Reply-To: <2885897.1676990364@warthog.procyon.org.uk>
References: <20230221184225.0e734f0e@canb.auug.org.au>
        <20230221174401.7198357d@canb.auug.org.au>
        <20230220152933.1ab8fa4a@canb.auug.org.au>
        <Y/N8hVWeR3AjssUC@casper.infradead.org>
        <20230220190157.3b43b9a7@canb.auug.org.au>
        <Y/Pe2xHklSr1hDtz@casper.infradead.org>
        <2351091.1676963957@warthog.procyon.org.uk>
        <2885897.1676990364@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/riq4UNgYaO+uFLytpMU=g/q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/riq4UNgYaO+uFLytpMU=g/q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 21 Feb 2023 14:39:24 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > Andrew has already asked for it to be merged, so its up to Linus.
> >=20
> > You could fetch it yourself and do a trial merge and send me your
> > resolution ..
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-20=
23-02-20-13-37
>=20
> Okay, did that.  See attached.  Also here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Diov-cifs-mm
>=20
> David
> ---
> commit 71ad4f67439e60fe04bbf7aed8870e6f83a5d15e
> Author: David Howells <dhowells@redhat.com>
> Date:   Tue Feb 21 13:23:05 2023 +0000
>=20
>     cifs: Handle transition to filemap_get_folios_tag()

OK, so in the merge of mm-stable, I used the cifs version of
fs/cifs/file.c with this patch applied.  The merge resolution for that
file looks like this:

diff --cc fs/cifs/file.c
index 0e602173ac76,162fab5a4583..000000000000
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@@ -2850,154 -2853,29 +2850,161 @@@ err_xid
  	return rc;
  }
 =20
 -static int
 -cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
 +/*
 + * write a region of pages back to the server
 + */
 +static int cifs_writepages_region(struct address_space *mapping,
 +				  struct writeback_control *wbc,
 +				  loff_t start, loff_t end, loff_t *_next)
  {
 -	int rc;
 -	unsigned int xid;
++	struct folio_batch fbatch;
 +	struct folio *folio;
- 	struct page *head_page;
++	unsigned int i;
 +	ssize_t ret;
 +	int n, skips =3D 0;
 =20
 -	xid =3D get_xid();
 -/* BB add check for wbc flags */
 -	get_page(page);
 -	if (!PageUptodate(page))
 -		cifs_dbg(FYI, "ppw - page not up to date\n");
++	folio_batch_init(&fbatch);
+=20
 -	/*
 -	 * Set the "writeback" flag, and clear "dirty" in the radix tree.
 -	 *
 -	 * A writepage() implementation always needs to do either this,
 -	 * or re-dirty the page with "redirty_page_for_writepage()" in
 -	 * the case of a failure.
 -	 *
 -	 * Just unlocking the page will cause the radix tree tag-bits
 -	 * to fail to update with the state of the page correctly.
 -	 */
 -	set_page_writeback(page);
 +	do {
 +		pgoff_t index =3D start / PAGE_SIZE;
 +
- 		n =3D find_get_pages_range_tag(mapping, &index, end / PAGE_SIZE,
- 					     PAGECACHE_TAG_DIRTY, 1, &head_page);
++		n =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
++					   PAGECACHE_TAG_DIRTY, &fbatch);
 +		if (!n)
 +			break;
 +
- 		folio =3D page_folio(head_page);
- 		start =3D folio_pos(folio); /* May regress with THPs */
++		for (i =3D 0; i < n; i++) {
++			folio =3D fbatch.folios[i];
++			start =3D folio_pos(folio); /* May regress with THPs */
 +
- 		/* At this point we hold neither the i_pages lock nor the
- 		 * page lock: the page may be truncated or invalidated
- 		 * (changing page->mapping to NULL), or even swizzled
- 		 * back from swapper_space to tmpfs file mapping
- 		 */
- 		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
- 			ret =3D folio_lock_killable(folio);
- 			if (ret < 0) {
- 				folio_put(folio);
- 				return ret;
- 			}
- 		} else {
- 			if (!folio_trylock(folio)) {
- 				folio_put(folio);
- 				return 0;
++			/* At this point we hold neither the i_pages lock nor the
++			 * page lock: the page may be truncated or invalidated
++			 * (changing page->mapping to NULL), or even swizzled
++			 * back from swapper_space to tmpfs file mapping
++			 */
++			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
++				ret =3D folio_lock_killable(folio);
++				if (ret < 0) {
++					folio_batch_release(&fbatch);
++					return ret;
++				}
++			} else {
++				if (!folio_trylock(folio))
++					continue;
 +			}
- 		}
 +
- 		if (folio_mapping(folio) !=3D mapping ||
- 		    !folio_test_dirty(folio)) {
- 			start +=3D folio_size(folio);
- 			folio_unlock(folio);
- 			folio_put(folio);
- 			continue;
- 		}
++			if (folio->mapping !=3D mapping ||
++			    !folio_test_dirty(folio)) {
++				start +=3D folio_size(folio);
++				folio_unlock(folio);
++				continue;
++			}
 +
- 		if (folio_test_writeback(folio) ||
- 		    folio_test_fscache(folio)) {
- 			folio_unlock(folio);
- 			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
- 				folio_wait_writeback(folio);
++			if (folio_test_writeback(folio) ||
++			    folio_test_fscache(folio)) {
++				folio_unlock(folio);
++				if (wbc->sync_mode !=3D WB_SYNC_NONE) {
++					folio_wait_writeback(folio);
 +#ifdef CONFIG_CIFS_FSCACHE
- 				folio_wait_fscache(folio);
++					folio_wait_fscache(folio);
 +#endif
- 			} else {
- 				start +=3D folio_size(folio);
- 			}
- 			folio_put(folio);
- 			if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
- 				if (skips >=3D 5 || need_resched())
- 					break;
- 				skips++;
++				} else {
++					start +=3D folio_size(folio);
++				}
++				if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
++					if (skips >=3D 5 || need_resched()) {
++						*_next =3D start;
++						return 0;
++					}
++					skips++;
++				}
++				continue;
 +			}
- 			continue;
- 		}
 +
- 		if (!folio_clear_dirty_for_io(folio))
- 			/* We hold the page lock - it should've been dirty. */
- 			WARN_ON(1);
++			if (!folio_clear_dirty_for_io(folio))
++				/* We hold the page lock - it should've been dirty. */
++				WARN_ON(1);
 +
- 		ret =3D cifs_write_back_from_locked_folio(mapping, wbc, folio, start, e=
nd);
- 		folio_put(folio);
- 		if (ret < 0)
- 			return ret;
++			ret =3D cifs_write_back_from_locked_folio(mapping, wbc,
++								folio, start, end);
++			if (ret < 0) {
++				folio_batch_release(&fbatch);
++				return ret;
++			}
++
++			start +=3D ret;
++		}
 +
- 		start +=3D ret;
++		folio_batch_release(&fbatch);
 +		cond_resched();
 +	} while (wbc->nr_to_write > 0);
 +
 +	*_next =3D start;
 +	return 0;
 +}
 +
 +/*
 + * Write some of the pending data back to the server
 + */
 +static int cifs_writepages(struct address_space *mapping,
 +			   struct writeback_control *wbc)
 +{
 +	loff_t start, next;
 +	int ret;
 +
 +	/* We have to be careful as we can end up racing with setattr()
 +	 * truncating the pagecache since the caller doesn't take a lock here
 +	 * to prevent it.
 +	 */
 +
 +	if (wbc->range_cyclic) {
 +		start =3D mapping->writeback_index * PAGE_SIZE;
 +		ret =3D cifs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
 +		if (ret =3D=3D 0) {
 +			mapping->writeback_index =3D next / PAGE_SIZE;
 +			if (start > 0 && wbc->nr_to_write > 0) {
 +				ret =3D cifs_writepages_region(mapping, wbc, 0,
 +							     start, &next);
 +				if (ret =3D=3D 0)
 +					mapping->writeback_index =3D
 +						next / PAGE_SIZE;
 +			}
 +		}
 +	} else if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LLONG_MAX)=
 {
 +		ret =3D cifs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
 +		if (wbc->nr_to_write > 0 && ret =3D=3D 0)
 +			mapping->writeback_index =3D next / PAGE_SIZE;
 +	} else {
 +		ret =3D cifs_writepages_region(mapping, wbc,
 +					     wbc->range_start, wbc->range_end, &next);
 +	}
 +
 +	return ret;
 +}
 +
 +static int
 +cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
 +{
 +	int rc;
 +	unsigned int xid;
 +
 +	xid =3D get_xid();
 +/* BB add check for wbc flags */
 +	get_page(page);
 +	if (!PageUptodate(page))
 +		cifs_dbg(FYI, "ppw - page not up to date\n");
 +
 +	/*
 +	 * Set the "writeback" flag, and clear "dirty" in the radix tree.
 +	 *
 +	 * A writepage() implementation always needs to do either this,
 +	 * or re-dirty the page with "redirty_page_for_writepage()" in
 +	 * the case of a failure.
 +	 *
 +	 * Just unlocking the page will cause the radix tree tag-bits
 +	 * to fail to update with the state of the page correctly.
 +	 */
 +	set_page_writeback(page);
  retry_write:
  	rc =3D cifs_partialpagewrite(page, 0, PAGE_SIZE);
  	if (is_retryable_error(rc)) {

Which is much less obvious :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/riq4UNgYaO+uFLytpMU=g/q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP1grcACgkQAVBC80lX
0Gw/Swf9EG39CPZRY223FJIx2LT2ZMefyfEJRSOR5PkVpcqKzyoD+vzrdfSa+z5I
8WU0VwsjaHu9UdAz6MCQfbQLSg3gW5xILUVQsTnTNcn+VN8epwvOL7/jAQs3ul4z
9ksQgxBbhOwT65txIVgls0Z3zqF6u61qErW4zkptEl5VPuHJfRvRzR/8b8DC4/q+
XJwL02LdhEembMTF5R4/Rt+PG4JER7eVAe/4LrvHNVo00H0cGt4lSoWShalyzYi7
JmeHQyJgILoN7roNUEnW52QtyrGTh1gNniLaBtv7ILTQmsYnlsU1LELagqHJ5QGN
B/cZOn1KGx/PR0vILvql0NeuG9jmGA==
=Cu0w
-----END PGP SIGNATURE-----

--Sig_/riq4UNgYaO+uFLytpMU=g/q--
