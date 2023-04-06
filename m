Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC036D974C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDFMsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbjDFMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:48:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C368511C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:48:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73ED21F895;
        Thu,  6 Apr 2023 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680785294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C5gkwQ1NumD7u6UGVet6+3BAdJ6qwcljpnsMyFFlyE=;
        b=zFfqBs79etl2Qew8xWUBpcjC2YS5HzeKEFhoTzDEQH5kMmk2GU6+LPw0Eq31I1eW90hc0y
        aEfQn7ClQNJjUW8oL1NXz8/iU+ZQA2CSJqNQIGleAfTC3NThSCgieTVUFa1FnQTjHb0ep2
        S4XuviF68XyNDON0ax6khKM05AAm+II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680785294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C5gkwQ1NumD7u6UGVet6+3BAdJ6qwcljpnsMyFFlyE=;
        b=wnaEcb4fdgIUGmurtLSE0lUWHOr+VemWMxldkBQXiEYlfRcjgxScXFYI/OWp1z44Osrn/g
        HVe7ilsTwNwMzeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25723133E5;
        Thu,  6 Apr 2023 12:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6CsDCI6/LmTPcwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 06 Apr 2023 12:48:14 +0000
Date:   Thu, 6 Apr 2023 14:48:12 +0200
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
Message-ID: <20230406124812.GA1589248@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> On Thu, Apr 6, 2023, at 12:56, Petr Vorel wrote:
> >> On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:

> >> > mq_timedreceive01
> >> > mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR (4)
> >> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> >> I think this is the same problem as fstatfs02, where ltp passes
> >> an invalid pointer and expects EFAULT, but musl touches the data
> >> first in order to do the time64 conversion. Needs the same fix.

> > FYI mq_timedreceive01 is broken on 32bit systems with glibc
> > (in current LTP master):


> > EINTR (4)
> > tst_test.c:1618: TBROK: Test killed by SIGSEGV!

> Right, I see this has the same time64 logic as musl now.

> >> > recvmmsg01.c:92: TPASS: recvmmsg() overflow in nanoseconds in timeout
> >> > : EINVAL (22)
> >> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> >> Same time64 conversion issue as above.

> > Besides the same problem with shm permissions on musl I see SIGSEGV also on
> > 64bit musl on current LTP master.

> Ah, I see. This must be the padding code then, not the time64
> conversion:

> +int recvmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen, unsigned int flags, struct timespec *timeout)
> +{
> +#if LONG_MAX > INT_MAX
> +       struct mmsghdr *mh = msgvec;
> +       unsigned int i;
> +       for (i = vlen; i; i--, mh++)
> +               mh->msg_hdr.__pad1 = mh->msg_hdr.__pad2 = 0;
> +#endif

I suppose this is a suggestion for fix in LTP. I'd expect is should go into
testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h into static inline int
sys_recvmmsg(...)

But that at least on glibc 64bit compilation does not see __pad1 member:

../sendmmsg/sendmmsg_var.h: In function ‘sys_recvmmsg’:
../sendmmsg/sendmmsg_var.h:47:28: error: ‘struct msghdr’ has no member named ‘__pad1’
   47 |                 mh->msg_hdr.__pad1 = mh->msg_hdr.__pad2 = 0;
      |                            ^

Kind regards,
Petr

>        Arnd
