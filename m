Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2216735762
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjFSMxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjFSMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:53:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA21718
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:53:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F85F21870;
        Mon, 19 Jun 2023 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687179195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TWxie6xDnsp1m4eMpouDH4sytcFkAlnBkBDPnEaF0No=;
        b=m2bVWXlQZgk6+wOdr7GV8Sc7ePwkqtTVf5DFMDJKS5z2oZEeVpWvmTs1GEWsadVh3SEgki
        Gh+GBKVYadAbvSk1nCNKzgmS3t0bzEzMMDhX3RF0vx4OeuiYoKXEeICpGddoEjThLI7pH9
        FkYDg/CY9+qg4nE6Mhjg1RgnDnGymic=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BFC6139C2;
        Mon, 19 Jun 2023 12:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T2MIBrtPkGTjewAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 19 Jun 2023 12:53:15 +0000
Date:   Mon, 19 Jun 2023 14:53:13 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Adam Majer <amajer@suse.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm: Sync percpu mm RSS counters before querying
Message-ID: <b4zbdp4wq35nvq34njzdscqj72nk6e5vmy63n4csakcxnonpc5@kqvtacyg6n4i>
References: <20230616180718.17725-1-mkoutny@suse.com>
 <20230616123144.bd2a8120dab25736c5c37297@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="26gv2xzmhvqwhdqa"
Content-Disposition: inline
In-Reply-To: <20230616123144.bd2a8120dab25736c5c37297@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--26gv2xzmhvqwhdqa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 12:31:44PM -0700, Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> On Fri, 16 Jun 2023 20:07:18 +0200 Michal Koutn=FD <mkoutny@suse.com> wro=
te:
>=20
> > An issue was observed with stats collected in struct rusage on ppc64le
> > with 64kB pages. The percpu counters use batching with
> > 	percpu_counter_batch =3D max(32, nr*2) # in PAGE_SIZE
> > i.e. with larger pages but similar RSS consumption (bytes), there'll be
> > less flushes and error more noticeable.
>=20
> A fully detailed description of the issue would be helpful.  Obviously
> "inaccuracy", but how bad?

Any reader of get_mm_counter() could see the inaccuracy given by the
formula.
In this particular case it is detected by a testsuite of time(1) utility
that feeds from rusage:

> FAIL: tests/time-max-rss
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> time(1) failed to detect 5MB allcoation.
>   mem-baseline(kb): 0
>   mem-5MB(kb):      4096
>   delta(kb):        4096
> FAIL tests/time-max-rss.sh (exit status: 1)

(i.e. 1MB missing)

> Far too large to be inlined!  For six callsites it adds 1kb of text.

Ah, thanks, I can change that.

> Why even modify the counter?  Can't <whatever this issue is> be
> addressed by using percpu_counter_sum() in an appropriate place?

I considered modifying get_mm_counter(), however, I decided not to put
the per-cpu summing there as it'd incur the impact to many more places
than sync_mm_rss().

> For unknown reasons percpu_counter_set() uses for_each_possible_cpu().=20
> Probably just a mistake - percpu_counters are hotplug-aware and
> for_each_online_cpu should suffice.

Yeah, that could be cleaned up in another patch (cf mask in
__percpu_counter_sum).

> I'm really not liking percpu_counter_set().  It's only safe in
> situations where the caller knows that no other CPU can be modifying
> the counter.  I wonder if all the callers know that.

I admit I only considered the do_exit() path (and even that isn't
granted in a multithreaded process) -- so I don't like
percpu_counter_set() in this current form neither.
I will need to review effects of parallel updates more.

Thanks,
Michal

--26gv2xzmhvqwhdqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZJBPtwAKCRAGvrMr/1gc
jg7VAPwIjhi8mrzDBAOTstul/NetJ03zstiAaJYdid1vFqMbLgEAqmxlGTO1lvUR
ys7xfUBwhMhNzEfzR/eXT5WpuiwVLw0=
=J8jf
-----END PGP SIGNATURE-----

--26gv2xzmhvqwhdqa--
