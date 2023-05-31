Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556C7185A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjEaPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjEaPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:06:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60A10F6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:05:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 134E321904;
        Wed, 31 May 2023 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685545548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UVltXgwItraV4FGz/uii8cqWK65XtkelAgQIafLv8C4=;
        b=K/IKmt2rCWwSHKdy7rqG+x1QcCKSGfgu3XKP8+pbZnkI8TPql4dumptHxrSxrPFbM361lQ
        FrdC9u3ozOdtpC5ZlitCmICkbK7UZQhRKzYRE6aEorw//ck3iq9LEWphXypYlHGNlyE6Fa
        Qnj53T9DM4Cf2JLe3VvA3b8cLUKMgaQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB43613488;
        Wed, 31 May 2023 15:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MHHQNEtid2TMPQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 31 May 2023 15:05:47 +0000
Date:   Wed, 31 May 2023 17:05:46 +0200
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
Message-ID: <ldxj7p22ze4ccoe4bmojhlabflw34t6jwyh24fklvessdyyial@w3fw6wwo7icp>
References: <299fbb80-e3ab-3b7c-3491-e85cac107930@intel.com>
 <CAPAsAGyG2_sUfb7aPSPuMatMraDbPCFKxhv2kSDkrV1XxQ8_bw@mail.gmail.com>
 <20230313094127.3cqsnmngbdegbe6o@blackpad>
 <CAPAsAGzYSi_mCy64rFH=o+m8eT-A9ffttsFO9Wx94=nsj+Q8Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ycvjxkeevdduqu4"
Content-Disposition: inline
In-Reply-To: <CAPAsAGzYSi_mCy64rFH=o+m8eT-A9ffttsFO9Wx94=nsj+Q8Jg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ycvjxkeevdduqu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2023 at 02:40:33PM +0100, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> Yes, with the vaddr_end = KASAN_SHADOW_START  it should work,
>  kaslr_memory_enabled() can be removed in favor of just the kaslr_enabled()

Thanks. FWIW, I've found the cautionary comment at vaddr_end from the
commit 1dddd2512511 ("x86/kaslr: Fix the vaddr_end mess"), so I'm not
removing kaslr_enabled_enabled() now.

Michal

--4ycvjxkeevdduqu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZHdiSAAKCRAkDQmsBEOq
uVkZAQC9Jm2mWgPAUPqqgO0NNrvFotzE3yEA2+E+A790k74cFAEA3oDkSBjN98F6
5BBgyox4635j0nByjmoVA5lwtCBxhwE=
=FH1X
-----END PGP SIGNATURE-----

--4ycvjxkeevdduqu4--
