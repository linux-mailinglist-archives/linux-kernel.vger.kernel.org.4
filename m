Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE26D97D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbjDFNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbjDFNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:18:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B870903A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:17:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAB11FD76;
        Thu,  6 Apr 2023 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680787078;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfC7CMPXeeRMiPKxLyM3C13TOXBtHVBske2Zh3FAELY=;
        b=jz4wQSjNwiTLPukTzWuoOY3ua0xRuJciJdXDRsbi9kNotTXtegJTpyHUDpAW9erXwGzNSk
        L66Rjygnz+Y0LaU/6wU43bNPjQHz2TW/EaraJ+U93a4phnG5AJO1if1ZP/6bUr2Ty5mYxa
        ryQmHMtNROJKsQ4cbTv4G7wkrnRp8Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680787078;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfC7CMPXeeRMiPKxLyM3C13TOXBtHVBske2Zh3FAELY=;
        b=GJxuSPA7soPWU8u482+5aSlrmq9WnEviWybvmmcG3PJJ+HGT5looaU/dsNoaWo+bPAErlP
        tTEGOP+6eIo8UzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37D64133E5;
        Thu,  6 Apr 2023 13:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vmNhCoXGLmTWBQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 06 Apr 2023 13:17:57 +0000
Date:   Thu, 6 Apr 2023 15:17:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-2?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
Message-ID: <20230406131755.GA1608262@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
 <20230406124812.GA1589248@pevik>
 <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Apr 6, 2023, at 14:48, Petr Vorel wrote:
> >> On Thu, Apr 6, 2023, at 12:56, Petr Vorel wrote:

> >> Ah, I see. This must be the padding code then, not the time64
> >> conversion:

> >> +int recvmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen, unsigned int flags, struct timespec *timeout)
> >> +{
> >> +#if LONG_MAX > INT_MAX
> >> +       struct mmsghdr *mh = msgvec;
> >> +       unsigned int i;
> >> +       for (i = vlen; i; i--, mh++)
> >> +               mh->msg_hdr.__pad1 = mh->msg_hdr.__pad2 = 0;
> >> +#endif

> > I suppose this is a suggestion for fix in LTP. I'd expect is should go into
> > testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h into static inline int
> > sys_recvmmsg(...)

> > But that at least on glibc 64bit compilation does not see __pad1 member:

> > ../sendmmsg/sendmmsg_var.h: In function ‘sys_recvmmsg’:
> > ../sendmmsg/sendmmsg_var.h:47:28: error: ‘struct msghdr’ has no member 
> > named ‘__pad1’
> >    47 |                 mh->msg_hdr.__pad1 = mh->msg_hdr.__pad2 = 0;
> >       |                            ^

> Sorry, I should have been clearer, the snippet I cited is
> from the musl sources, and the __pad access is what causes the
> segfault. The fix is to catch the fault on ltp, same as for the
> time64 conversions.

Thanks! I've just searched in musl as well, because it didn't make sense to me
it'd be a code for LTP.

"to catch the fault on ltp" I wonder if it's not actually musl bug.

Kind regards,
Petr


>       Arnd
