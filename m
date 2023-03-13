Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D0A6B72D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCMJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCMJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:41:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630C19111
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:41:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FFCA1FD86;
        Mon, 13 Mar 2023 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678700489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taPYVRLjiV8XDl67HXIGpVQRzMdlFoR13+oyuxu7LjQ=;
        b=bvJaOYw9VQrb7Agfv9U1br8G4lD04VRMnxTZAQyckxabwsruhkuUO4XmhOheFPLUozF9sR
        MqUn+uFpvAL9RZu7q/WmHbD0IXWyd6ZwY722tci4qtJqJTDIMIJ1hPP49hIDmCuvbLNtEU
        U0TNxRAiyF+7AJGrCpMOKVTDtUiVx/I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3548A13517;
        Mon, 13 Mar 2023 09:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /pqoC8nvDmTFJQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 13 Mar 2023 09:41:29 +0000
Date:   Mon, 13 Mar 2023 10:41:27 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@google.com>
Subject: Re: KASLR vs. KASAN on x86
Message-ID: <20230313094127.3cqsnmngbdegbe6o@blackpad>
References: <299fbb80-e3ab-3b7c-3491-e85cac107930@intel.com>
 <CAPAsAGyG2_sUfb7aPSPuMatMraDbPCFKxhv2kSDkrV1XxQ8_bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wptupshxqazattjd"
Content-Disposition: inline
In-Reply-To: <CAPAsAGyG2_sUfb7aPSPuMatMraDbPCFKxhv2kSDkrV1XxQ8_bw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wptupshxqazattjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 08, 2023 at 06:24:05PM +0100, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> So the vmemmap_base and probably some part of vmalloc could easily end
> up in KASAN shadow.

Would it help to (conditionally) reduce vaddr_end to the beginning of
KASAN shadow memory?
(I'm not that familiar with KASAN, so IOW, would KASAN handle
randomized: linear mapping (__PAGE_OFFSET), vmalloc (VMALLOC_START) and
vmemmap (VMEMMAP_START) in that smaller range.)

Thanks,
Michal

--wptupshxqazattjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZA7vxQAKCRAkDQmsBEOq
uW2lAQCeUCKhA8GYQAuXZu5XL/lsP5d2pNCA006hwmRC9KpGBAEAqFyQ693lk1ii
t3tc9mNSO+lVUFd9KFGdT0D8NP7zDgg=
=nAh2
-----END PGP SIGNATURE-----

--wptupshxqazattjd--
