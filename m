Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455C074C4AA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 16:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGIOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGIOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 10:09:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FB97
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 07:09:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 927B01F388;
        Sun,  9 Jul 2023 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688911780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZVuBrUjNGZgSOciEPCq8iGsrYPzIcyxEO22KvmLoP4=;
        b=OY/iiCXA6utQdS6/0GVopYRpIkhbEGV1S25uClmfFieKejp8IYjn/YC0CyK3RbgCy+14sq
        IwBY4n8Lbf+NPe/onb0Bu3Lfp1Iesjn1hL54VVjV7NiSBx7lqCjLobWBWm+UdB3nPqsRXQ
        VIlzZVoJ81gxB1kqd8+/u7Y09R277uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688911780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZVuBrUjNGZgSOciEPCq8iGsrYPzIcyxEO22KvmLoP4=;
        b=WQodrsOkD+42L/jh341FYzZ2D5fO+q42zD2DweBtN3XI16fioUPPEUWRKmgZp60CIQOO4R
        zo/SESIg4D23aMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BC3F13A63;
        Sun,  9 Jul 2023 14:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rsdPC6S/qmRaeAAAMHmgww
        (envelope-from <mkubecek@suse.cz>); Sun, 09 Jul 2023 14:09:40 +0000
Date:   Sun, 9 Jul 2023 17:09:29 +0300
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230709140929.5sdcvyqquotkn752@carpenter>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <fb93d107-c834-1849-2b14-1dd33c4f9955@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gccrtxyvc72qxztt"
Content-Disposition: inline
In-Reply-To: <fb93d107-c834-1849-2b14-1dd33c4f9955@leemhuis.info>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gccrtxyvc72qxztt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 08, 2023 at 03:40:50PM +0200, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 28.06.23 13:58, Michal Kubecek wrote:
> >=20
> > this morning, mainline kernel builds started to fail on my desktop like
> > this:
> >=20
> >   mike@lion:~/work/git/kernel-upstream> mkdir /srv/ram/kobj
> >   mike@lion:~/work/git/kernel-upstream> make -j24 CC=3Dgcc-13 O=3D/srv/=
ram/kobj defconfig >/dev/null
> >   mike@lion:~/work/git/kernel-upstream> make -j24 CC=3Dgcc-13 O=3D/srv/=
ram/kobj all >/dev/null
> >   net/ipv4/netfilter/iptable_nat.o: warning: objtool: mmap fail reloc
> >   net/netfilter/xt_mark.o: warning: objtool: mmap fail reloc
> >   net/netfilter/xt_nat.o: warning: objtool: mmap fail reloc
> >   net/netfilter/xt_LOG.o: warning: objtool: mmap fail reloc
> >   net/netfilter/xt_MASQUERADE.o: warning: objtool: mmap fail reloc
> >   net/netfilter/nf_log_syslog.o: warning: objtool: mmap fail reloc
> >   net/netfilter/xt_addrtype.o: warning: objtool: mmap fail reloc
> >   fs/efivarfs/efivarfs.o: warning: objtool: mmap fail reloc
> >   drivers/thermal/intel/x86_pkg_temp_thermal.o: warning: objtool: mmap =
fail reloc
> >   vmlinux.o: warning: objtool: mmap fail reloc
> >   incomplete ORC unwind tables in file: vmlinux
> >   Failed to sort kernel tables
> >   make[2]: *** [/home/mike/work/git/kernel-upstream/scripts/Makefile.vm=
linux:35: vmlinux] Error 1
> >   make[2]: *** Deleting file 'vmlinux'
> >   make[1]: *** [/home/mike/work/git/kernel-upstream/Makefile:1256: vmli=
nux] Error 2
> >   make: *** [Makefile:226: __sub-make] Error 2
> >=20
> > I bisected the failure to commit
> >=20
> >   eb0481bbc4ce ("objtool: Fix reloc_hash size")
> >=20
> > I also tried gcc11 and building on a normal filesystem (rather than
> > tmpfs) but the result is still the same. Different configurations (e.g.
> > allmodconfig) only show more modules with "mmap fail reloc". The machine
> > has 64 GB of RAM and both ulimit -m and ulimit -v show "unlimited".
> > Anything idea what else I should try?
>=20
> Michal, thx for the report. Please correct me if I'm wrong: this as of
> now is unfixed, as your patch to fix is afaics wasn't merged yet (at
> least I can't see it even in next, but I might be missing something).

Yes, the fix has not been merged yet and current master (commit
1c7873e33645) still shows the issue.

Michal

> Hence adding it to the regression tracking now that the end of the merge
> window is near:
>=20
> #regzbot ^introduced eb0481bbc4ce
> #regzbot title objtool: build failure
> #regzbot monitor:
> https://lore.kernel.org/all/20230629102051.42E8360467@lion.mk-sys.cz/
> #regzbot fix: objtool: initialize all of struct elf
> #regzbot ignore-activity

--gccrtxyvc72qxztt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmSqv5AACgkQ538sG/LR
dpUKbwf/QvZBPsu5CwJH4ZxFcs3dtHV+F36lQJ8bqvB7DjbDOezjGhdrj/DI0tq3
4Kx+rHz9emnrsGB8vl5OiBCceD7T55a4s7MA7fbaL2X2yU9dVbFhJydEK2FgX1el
QBtvluzF3P6rQLYQyO6OmhznUHP6+HeDOHR6u+l82WY1pMRy+V3BIYtu9dr9dyyD
lAy2lVPExc3U0HZp6/uVXlX/+8aMQCn1Zm3dQ1cUxfpZrEHbak+pHMUfASezu4hU
vnI/PjuOBRtPLNlAPiQib2bSySxtrw1I+REnqKbu7dqihxaFoB8DtTyJjwWmT5E5
dec/9y8al0u/ENPb7rK2HNBWE0zBXw==
=iWOZ
-----END PGP SIGNATURE-----

--gccrtxyvc72qxztt--
