Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0F5B3B02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiIIOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiIIOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:47:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3CD6F555
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:47:11 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t14so1320438qkt.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0Meoqct15xRj+ttJhOvrFrl2KTZE/gRtt0ZRxfx4q28=;
        b=FEKMTty2fiz0be6vD787nTJ7bIzyI0vfMpLUEDFL/DJZmfbonrmDWePsJih+Mpa60R
         MXUxDdx4bxlY6rOeD1kJr2pMEkTdgmjW2IdgWFR8jE4eDPkoFl/QtuOFqOoNRZpXFJDr
         h8Swp6fhGK2MYHmzYtQcFvA7NY/Ot6LgoeuRT+igCGnJkxcNSzPrO/Ta3e8Nagha3Y4A
         qAlasYsnSmYt8N0zmnR48pMVbGmxJH0tdvEuJtaOiAdPk05aEnvDPIwP8tRTcQB+LK0g
         XBFy8WpfWrqEaa2DIk+U+lpo7fDtz1j/nX9GD2X89pdjdrcBfuy3iepGHlukzFeWguV1
         gySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0Meoqct15xRj+ttJhOvrFrl2KTZE/gRtt0ZRxfx4q28=;
        b=ziBLKMqQvHr1rONtE0GCOjyhok2va6cdgx7GrNHZAEhgAI8mQXJn4/QJoBVEtuSyXl
         cw8mptstPDx+NWepxT+wTkHGlbMos1gXv7cSgEvK357vw8tuOTntdBInFMX+Zok5KQSU
         xRiBNTaqrW+shJf3+wp+RRKxKGdN2lxmP1yceqLyq0DPUPJGhbtdJKSoMCdGHlqRzD1r
         yeEeo49JrSi482o14jpdZg+QkM4OB821reo4rcGvJxMMNZvqAf9WdxysbSGpNK7y8L66
         Q207qKN4xzofZI29nn507inEkhCOm4KUZ0ubtGcspR3FjgO+1PJFTC+qX1VBvJj8QA3A
         qcpQ==
X-Gm-Message-State: ACgBeo0TG64jSbWiVVhgFtjBE8fxweVUCV2zM1hZvxul/KPpd7xxiu3+
        Iod+2/BCyxA9uJLhJ0+MWl0=
X-Google-Smtp-Source: AA6agR4du/JtavrTVKMuCN/jyc63/La941lNhFdbV+iQ1R3vJub5oL2HYBqAWGJEFVbVKwGFbcwIHw==
X-Received: by 2002:a05:620a:4054:b0:6bb:572:3d45 with SMTP id i20-20020a05620a405400b006bb05723d45mr10256490qko.49.1662734829989;
        Fri, 09 Sep 2022 07:47:09 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:cd61:d28a:9f90:9dc3])
        by smtp.gmail.com with ESMTPSA id d17-20020a05620a241100b006bb2bca5741sm529092qkn.93.2022.09.09.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:47:09 -0700 (PDT)
Date:   Fri, 9 Sep 2022 07:47:10 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] lib/find_bit: optimize find_next_bit() functions
Message-ID: <YxtR7tMhXwGEXmbO@yury-laptop>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
 <20220827175807.4017673-4-yury.norov@gmail.com>
 <xhsmhfsh3b15v.mognet@vschneid.remote.csb>
 <YxjNeqLjGgRPIm+y@yury-laptop>
 <yt9dv8pwspkw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dv8pwspkw.fsf@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:24:31PM +0200, Sven Schnelle wrote:
> Hi Yury,
> 
> Yury Norov <yury.norov@gmail.com> writes:
> 
> > On Wed, Sep 07, 2022 at 05:27:08PM +0100, Valentin Schneider wrote:
> >> On 27/08/22 10:58, Yury Norov wrote:
> >> > +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
> >> > +({										\
> >> > +	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
> >> > +										\
> >> > +	if (unlikely(__start >= sz))						\
> >> > +		goto out;							\
> >> > +										\
> >> > +	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
> >> > +	idx = __start / BITS_PER_LONG;						\
> >> > +										\
> >> > +	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
> >> > +		if (idx > sz / BITS_PER_LONG)					\
> >> 
> >> Does that want to be
> >
> > Yes, I already fixed this.
> >  
> >>                 if (idx + 1 >= sz / BITS_PER_LONG)
> >> 
> >> ?
> 
> Did you push that already? We're still seeing crashes in CI, and the
> 'idx + 1' doesnt seem to be in next-20220908. Adding it makes the
> out-of-bound access go away, but the kernel will crash later in the
> block mq code:

Hi Swen,

I removed the whole series and will resend it with an appropriate fixes
at the weekend. Hopefully it will disappear in next-20220909 or 10.

Thanks,
Yury
