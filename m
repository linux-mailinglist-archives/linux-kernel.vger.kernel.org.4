Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17F6DE698
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDKVjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:39:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0235260;
        Tue, 11 Apr 2023 14:39:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A4781FDCF;
        Tue, 11 Apr 2023 21:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681249188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S82+xdE9OcmjrTBCsFkGp/8e3ifilP41Xw0NqCH/dlo=;
        b=B9g1vj/sdRS1obYJIMmBH9jRI2ARZSjfpM2i/Em32p1zmjq9DRoB8rm60j6EZLbklyNoJK
        1xffjtLPrYkzwh6JWwhfmIpzq8focrBVTMgddbEVhVaABdTr/NnwRe0kkOsZre4QpNary8
        mmo2wq7vJliuQiQgzzv81ulCd83resg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681249188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S82+xdE9OcmjrTBCsFkGp/8e3ifilP41Xw0NqCH/dlo=;
        b=98SsGC7lE/9SYfUzGB6VtVCDdFuhjg4KacawgM63zAFnIkl05Z98tEyp3MG+BO4tUh1PhR
        8CUXnDT/5FrVB4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C6D513638;
        Tue, 11 Apr 2023 21:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yG0ICqTTNWSmLAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 11 Apr 2023 21:39:48 +0000
Date:   Tue, 11 Apr 2023 23:39:46 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Subject: Re: [PATCH RESEND] uapi/linux/const.h: Prefer ISO-friendly __typeof__
Message-ID: <20230411213946.GA1803920@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230411092747.3759032-1-kevin.brodsky@arm.com>
 <20230411210537.GA1800481@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411210537.GA1800481@pevik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Kevin,

> > typeof is (still) a GNU extension, which means that it cannot be
> > used when building ISO C (e.g. -std=c99). It should therefore be
> > avoided in uapi headers in favour of the ISO-friendly __typeof__.

> IMHO UAPI are built with -std=c90 -Wall -Werror=implicit-function-declaration
> (see usr/include/Makefile).
> But one or the other, you're right both require __typeof__.

> "If you are writing a header file that must work when included in ISO C
> programs, write __typeof__ instead of typeof."
> https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Typeof.html

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>

IMHO problem was introduced when -std=c90 was added (back then the code was in
include/uapi/linux/kernel.h).

Fixes: d6fc9fcbaa65 ("kbuild: compile-test exported headers to ensure they are self-contained")

Kind regards,
Petr

> Kind regards,
> Petr

> > Unfortunately this issue could not be detected by
> > CONFIG_UAPI_HEADER_TEST=y as the __ALIGN_KERNEL() macro is not
> > expanded in any uapi header.

> > Reported-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
> > Tested-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
> > Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> > ---
> >  include/uapi/linux/const.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> > index af2a44c08683..a429381e7ca5 100644
> > --- a/include/uapi/linux/const.h
> > +++ b/include/uapi/linux/const.h
> > @@ -28,7 +28,7 @@
> >  #define _BITUL(x)	(_UL(1) << (x))
> >  #define _BITULL(x)	(_ULL(1) << (x))

> > -#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> > +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
> >  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))

> >  #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
