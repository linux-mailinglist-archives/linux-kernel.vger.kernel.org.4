Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE737693A40
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBLVSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 16:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBLVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:18:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838E36A6F;
        Sun, 12 Feb 2023 13:18:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33so1442865wms.0;
        Sun, 12 Feb 2023 13:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bCNC+kjLeuaKiEa4IfuZK/Auwv+i4/NF1pjacff3UCU=;
        b=VDYbEn+euptIZIA+LVXAQoED9I9hxskJSYQuIVeqQaTapwl1tH0vqZUI6+26MlbQFY
         bT/GLe4/AWcLg9JB9q3bRY6GdoBRKyFtj2DJwHwBZs9SZRUWv6Jyj7i3Ygw4fGXl8em+
         ZfDGMZlzF7RIx4suaQaoBfPiHYG/qae7m7lC7xKpQcr0P+OLZk5B6ZUtpKYiagl/Vhfx
         NgxZ7kUPs4d41afkQRcBt7Hz8iFwegAb1wQvMQ25kW3uFx0KDPTJ7kRWYpLcD6lDB2nR
         2L9148fea/rKKztEaoLKJ0ZROUr2P1Y5o48ffzehNrrKGY21oqGHtwa72w2OLCZ/596R
         ewdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCNC+kjLeuaKiEa4IfuZK/Auwv+i4/NF1pjacff3UCU=;
        b=D1mGdMzLKQgCPRNqHLcJttdcDV7rtd/m3RZIz9BNJR0VxSRvrKORTKstzi+YGveB55
         G2qnbJE+gyHP5HJIM7idC6gbSaZ0Jx8ROIrgTxZMQ1SJSggBp8/BbIUZmBvBhgpH/tdt
         eLjmoISKfemFGkzZ3HQS+ZBwy4GdxgNmp1GTd9UpPtCMkIRghKIzuKMEhgh37rzD6mlN
         GQsn2gaWJtmupXR1gAXkZhrpt7o26soYLC0sey+opSaiXh5CpXQfXC04IOCN/iivQGlB
         SU8B/9iKhq7tIHsDQUXZbDxAGAflcImkR0pjgiQk0TsQGNRqZJqFo6MX4oESIZ2qJIeV
         EIQg==
X-Gm-Message-State: AO0yUKVSMG4OrrBHc88gHMBg2Nsu0g3Yock8XQ7ykRMr3UYKkoOzTUwj
        wQug4dUCLCR0YocYZjC3jgRDK9GUbo4=
X-Google-Smtp-Source: AK7set/RvkVCGBNqwxusyUoAIjlDjkY9A7gVJnWZuHcwYttb5VRY8h9imM9nwbZTq9BcGhe6uQv5Rw==
X-Received: by 2002:a05:600c:4d03:b0:3e0:1a9:b1d7 with SMTP id u3-20020a05600c4d0300b003e001a9b1d7mr17316897wmp.19.1676236685962;
        Sun, 12 Feb 2023 13:18:05 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm11397124wmb.27.2023.02.12.13.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 13:18:05 -0800 (PST)
Message-ID: <d56662b2-538c-7252-9052-8afbf325f843@gmail.com>
Date:   Sun, 12 Feb 2023 22:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     linux-man <linux-man@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        groff <groff@gnu.org>, Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Sam James <sam@gentoo.org>,
        Marcos Fouces <marcos@debian.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: man-pages-6.03 released
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3C00FMO4kN2vayOr6piv3GJ0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3C00FMO4kN2vayOr6piv3GJ0
Content-Type: multipart/mixed; boundary="------------c0uBvVR0NO0L3Y4iuX71H6dP";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: linux-man <linux-man@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>, groff <groff@gnu.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Sam James <sam@gentoo.org>, Marcos Fouces <marcos@debian.org>
Message-ID: <d56662b2-538c-7252-9052-8afbf325f843@gmail.com>
Subject: man-pages-6.03 released

--------------c0uBvVR0NO0L3Y4iuX71H6dP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gidday!

I'm proud to announce:

	man-pages-6.03 - manual pages for GNU/Linux

The release tarball is already available at <kernel.org>.

Tarball download:
	<https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
Git repository:
	<https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>
PDF book:
	<https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/book/>

The most notable changes in this release are:

-  We now have a hyperlinked PDF book of the Linux man-pages (see link ab=
ove).

-  C89 is now considered obsolescent by the man-pages, which means that
   the STANDARDS section will only document C99 and later for ISO C
   versions, with a few exceptions where relevant.

-  Document glibc's <printf.h> in printf.h(3head).

-  Document arc4random(3)

-  New APIs have been added todocumented in perf_event_open(2) and
   prctl(2).

Thank you all for contributing!

Cheers,

Alex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Changes in m=
an-pages-6.03 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


Released: 2023-02-12, Xulilla


Contributors
------------

The following people contributed patches/fixes, reports, notes,
ideas, and discussions that have been incorporated in changes in
this release:

Aaron Peter Bachmann <aaron_ng@inode.at>
Adhemerval Zanella <adhemerval.zanella@linaro.org>
Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Alejandro Colomar <alx@kernel.org>
Alex Colomar <alx.manpages@gmail.com>
Arsen Arsenovi=C4=87 <arsen@aarsen.me>
Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Brian Inglis <Brian.Inglis@Shaw.ca>
Colin Cross <ccross@google.com>
Cristian Rodr=C3=ADguez <crrodriguez@opensuse.org>
Deri James <deri@chuzzlewit.myzen.co.uk>
Elliott Hughes <enh@google.com>
Eric Biggers <ebiggers@kernel.org>
Florian Weimer <fweimer@redhat.com>
"G. Branden Robinson" <g.branden.robinson@gmail.com>
G=C3=BCnther Noack <gnoack3000@gmail.com>
Helge Kreutzmann <debian@helgefjell.de>
Ian Abbott <abbotti@mev.co.uk>
Jakub Wilk <jwilk@jwilk.net>
Jan Engelhardt <jengelh@inai.de>
"Jason A. Donenfeld" <Jason@zx2c4.com>
Jonny Grant <jg@jguk.org>
Joseph Myers <joseph@codesourcery.com>
Kees Cook <keescook@chromium.org>
Lennart Jablonka <humm@ljabl.com>
Mario Blaettermann <mario.blaettermann@gmail.com>
Mark Galeck <markgaleck@gmail.com>
Namhyung Kim <namhyung@kernel.org>
Nick Gregory <nick@nickgregory.me>
Pasha Tatashin <tatashin@google.com>
Paul Eggert <eggert@cs.ucla.edu>
<Radisson97@gmx.de>
Sam James <sam@gentoo.org>
Samanta Navarro <ferivoz@riseup.net>
"Serge E. Hallyn" <serge@hallyn.com>
Stefan Puiu <stefan.puiu@gmail.com>
Suren Baghdasaryan <surenb@google.com>
Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Walter Harms <wharms@bfs.de>
Wilco Dijkstra <Wilco.Dijkstra@arm.com>
Zack Weinberg <zack@owlfolio.org>

Apologies if I missed anyone!


New and rewritten pages
-----------------------

man3/
	arc4random.3
	powerof2.3
	roundup.3

man3head/
	printf.h.3head


Newly documented interfaces in existing pages
---------------------------------------------

perf_event_open.2
	PERF_COUNT_SW_BPF_OUTPUT
	PERF_COUNT_SW_CGROUP_SWITCHES
	PERF_FORMAT_LOST
	PERF_RECORD_MISC_MMAP_BUILD_ID
	PERF_RECORD_MISC_SWITCH_OUT_PREEMPT
	PERF_SAMPLE_CODE_PAGE_SIZE
	PERF_SAMPLE_DATA_PAGE_SIZE
	PERF_SAMPLE_WEIGHT_STRUCT

	struct perf_event_attr::build_id
	struct perf_event_attr::inherit_thread
	struct perf_event_attr::remove_on_exec
	struct perf_event_attr::sigtrap
	struct perf_event_attr::aux_sample_size
	struct perf_event_attr::sig_data

	union perf_sample_weight

	struct read_format::values[]::lost

	struct::weight
	struct::data_page_size
	struct::code_page_size
	struct::size
	struct::data

	struct:: ::build_id_size
	struct:: ::build_id

prctl.2
	PR_SET_VMA
	PR_SET_VMA_ANON_NAME


New and changed links
---------------------

man3/
	arc4random_buf.3			(arc4random(3))
	arc4random_uniform.3			(arc4random(3))
	register_printf_modifier.3		(printf.h(3head))
	register_printf_specifier.3		(printf.h(3head))
	register_printf_type.3			(printf.h(3head))

man3const/
	PA_CHAR.3const				(printf.h(3head))
	PA_DOUBLE.3const			(printf.h(3head))
	PA_FLAG_LONG.3const			(printf.h(3head))
	PA_FLAG_LONG_DOUBLE.3const		(printf.h(3head))
	PA_FLAG_LONG_LONG.3const		(printf.h(3head))
	PA_FLAG_PTR.3const			(printf.h(3head))
	PA_FLAG_SHORT.3const			(printf.h(3head))
	PA_FLOAT.3const				(printf.h(3head))
	PA_INT.3const				(printf.h(3head))
	PA_LAST.3const				(printf.h(3head))
	PA_POINTER.3const			(printf.h(3head))
	PA_STRING.3const			(printf.h(3head))
	PA_WCHAR.3const				(printf.h(3head))
	PA_WSTRING.3const			(printf.h(3head))

man3type/
	printf_arginfo_size_function.3type	(printf.h(3head))
	printf_function.3type			(printf.h(3head))
	printf_info.3type			(printf.h(3head))
	printf_va_arg_function.3type		(printf.h(3head))


Global changes
--------------

-  Build system:
   -  Add scripts to produce a book of the Linux man-pages.
   -  Add lint-c-cppcheck to the make(1) targets to run the cppcheck(1)
      linter.

-  TH:
   -  Use correct letter case in page titles.  This started in 6.02, but
      there were still many cases left.

-  SYNOPSIS:
   -  Mark some functions as deprecated.

-  STANDARDS:
   -  Remove most references to ISO C89.  We still document it in
      standards(7), but it's an ancient language version that this
      project
      regards as obsolescent, so in the STANDARDS sections for APIs we
      only take into account C99 and later and POSIX.1-2001 and later
      (with few exceptions where older standards are relevant).

-  ffix:
   -  Change \- to - where appropriate
   -  Improve readability of numbers:
      -  Show BCD magic numbers that are meaningful in hex as hex,
         rather than weird decimal numbers.
      -  Use IEC multipliers.
   -  Format ranges consistently using interval notation: [min, max].

-  srcfix:
   -  Use \[] escapes.


Changes to individual pages
---------------------------

timespec.3type
	Update tv_nsec according to C2x.


The manual pages (and other files in the repository) have been improved
beyond what this changelog covers.  To learn more about changes applied
to individual pages, use git(1).


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------c0uBvVR0NO0L3Y4iuX71H6dP--

--------------3C00FMO4kN2vayOr6piv3GJ0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPpV4wACgkQnowa+77/
2zJXFg//YYMVXtf+i/OLLsaB9USPlZXP8jallfdfcT+v4XokMGcyn3M5jB+i3BHp
Vt6B2zhwN79dqTLfOnCMj+QF38a0XRpzxqfHM7jqXzvn27DSSDruNcGFxVBavMS3
a5wBkuqoKUKf2XuVonU2a9A1FpQQQfYeegTdD3gXx4CmlG36G86i3YmdEyxLvpyi
V0PEdtEtftpezaGdQUaRhNlG2j33ayJ1UrlzSVn7rm0deOqiaXQIGpXNvfScTd/I
VcfQTJJiWAwKi4tAp4uFUnrdpnkS8YzlEz0qNm9o5N9l7QHvKEeD1VN/9yu1mTr8
8KAnIqlo3B/PvbkEyenRPvTnAaN2NKXvWS/xHHkC0ypdyDn7HXpsSIlX6QY3qLre
i5csKcxwpWVBg2t4/Mg9ZbQ/cnxa2Wi47BGg7gzJC4OA/D+HHIttHLFBUkDIu5cB
nNRv738nccRm8oDyMx84ZfCA08A02HJEXgbWxsWKeO9QH2SQMX5gwqbVNr3kNzOE
0js4RFRlvQxcMeLn0yEgeiRrH5HYinYGqJivTT8cmUo3BJEnO+ftUgTEzxCSbMCx
DagvSATJeb9ewNFcn8URkDjUEobCvfVYl0maMk97CJXnHPKHHVHPG6+LaQV5vBQG
DU3a/a3w3Mgj29qMIC+kjet8UcMYZXsZzpWIi46Vu9BXPQ0MO50=
=LOkg
-----END PGP SIGNATURE-----

--------------3C00FMO4kN2vayOr6piv3GJ0--
