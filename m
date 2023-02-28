Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138216A528A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjB1FFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 00:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjB1FFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 00:05:02 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C4126D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:05:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c18so5575427wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rUgYeuyp4a42zgvscb8Ayf+i4666OzYHVPuCh3+igs=;
        b=WKyQgStiyUSSLrOIZVBXxsvgUnH5p+qmORAJ0JkgpNJisWFdZRhsc0ATyM3Xs38HWm
         pmkpvP+OXPOb87WoqAmlU0zx3lO+44k90VTwLqgUKo9tQNXFAg5KJTwI32zIt1l0VtvP
         y9l+p9bZD+MjUfQQjJGe3XgyG+nJu+mIsw+Vt7JI1L+BtSiiAGj2qUpr+P9z6L5ky6co
         oHaEFh/9Bg99yUMxP5FpaypCv6WGNVQHLNYMPPQJmCKXr9MZg4hi0mh8Zw7wjuUQARKd
         5IkZWuEdeKUIdOwSLTXII1L7l92u/7jWhfjOirSWi4P6kNWkdHidFVBd7iDHftPeARmo
         mmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rUgYeuyp4a42zgvscb8Ayf+i4666OzYHVPuCh3+igs=;
        b=6FnNuLRb1ZZ/zt/gSypqqf6YwffmKqm5Apf+2KGpojWrXcVe4BjCyvnYdVSOYdKYdV
         VfLglBqtau4StBiigkHlqT6OzEEOE5C5kT80LURwHe3QUL7s9ua2rso/zahVVf2FM7Q0
         48ZX2BQNxhqYy5x4WrrpFsfGZK5/0hKC4DXppGecYK+xah50ZBxTAyvHNTM/0Lxb69sZ
         rlDr/qBeYTajWGoaZrk70S19z57+s6+q+TKyYRrz9VXkODXwnrcaeFGQSkUXPoMVNzj/
         2PK1xMHifxuBNfItwuniHMJsUjO6jGo+pcjICNIQ1ZWrtNOFZ76tuSrrCPLh18hFofJM
         u8Vg==
X-Gm-Message-State: AO0yUKU5KzH385jlbkgK5aalNncJy8/OiikBKMPKz1EzcUhAqDFP7aob
        CPdcspD1agq7F1Gol23lV/vLw6SL6mnxjEjL
X-Google-Smtp-Source: AK7set/3CqhMiz3nslm7Dq0Ps2HgrKYEBhz1XT+MvxtIEesgrxicJ4Ac6LP6iwP8C3YGBw504146ig==
X-Received: by 2002:a05:600c:3595:b0:3ea:c101:72b with SMTP id p21-20020a05600c359500b003eac101072bmr947095wmq.17.1677560699034;
        Mon, 27 Feb 2023 21:04:59 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id v14-20020adfedce000000b002c7b229b1basm8715953wro.15.2023.02.27.21.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 21:04:58 -0800 (PST)
Date:   Tue, 28 Feb 2023 06:04:57 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230228050457.zfbflfawctaccepv@orel>
References: <20230224090010.nmy6latszfkdqcft@orel>
 <9cfd485d1e0d46cdb1323bb6ea330f6e@EXMBX066.cuchost.com>
 <20230224095526.ctctpzw3p3csf6qj@orel>
 <24a6dbe6aa2043c7812bf7e258786e13@EXMBX066.cuchost.com>
 <20230224120715.wgqnqmkadsbqusus@orel>
 <180fda36f9974809b436c52e4b3eda58@EXMBX066.cuchost.com>
 <20230227075942.rgl4hqnwttwvoroe@orel>
 <178ca008701147828d2e62402ff4f78a@EXMBX066.cuchost.com>
 <20230227114435.eow57ax5zhysz3kv@orel>
 <a6c319dd867f4f1d97e9d950b9e7c636@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c319dd867f4f1d97e9d950b9e7c636@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 01:32:53AM +0000, JeeHeng Sia wrote:
> > > > > 	load image;
> > > > > loop:	Create pbe chain, return error if failed;
> > > >
> > > > This loop pseudocode is incomplete. It's
> > > >
> > > > loop:
> > > >         if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
> > > > 	   return page_address(page);
> > > > 	Create pbe chain, return error if failed;
> > > > 	...
> > > >
> > > > which I pointed out explicitly in my last reply. Also, as I asked in my
> > > > last reply (and have been asking four times now, albeit less explicitly
> > > > the first two times), how do we know at least one PBE will be linked?
> > > 1 PBE correspond to 1 page, you shouldn't expect only 1 page is saved.
> > 
> > I know PBEs correspond to pages. *Why* should I not expect only one page
> > is saved? Or, more importantly, why should I expect more than zero pages
> > are saved?
> > 
> > Convincing answers might be because we *always* put the restore code in
> > pages which get added to the PBE list or that the original page tables
> > *always* get put in pages which get added to the PBE list. It's not very
> > convincing to simply *assume* that at least one random page will always
> > meet the PBE list criteria.
> > 
> > > Hibernation core will do the calculation. If the PBEs (restore_pblist) linked successfully, the hibernated image will be restore else
> > normal boot will take place.
> > > > Or, even more specifically this time, where is the proof that for each
> > > > hibernation resume, there exists some page such that
> > > > !swsusp_page_is_forbidden(page) or !swsusp_page_is_free(page) is true?
> > > forbidden_pages and free_pages are not contributed to the restore_pblist (as you already aware from the code). Infact, the
> > forbidden_pages and free_pages are not save into the disk.
> > 
> > Exactly, so those pages are *not* going to contribute to the greater than
> > zero pages. What I've been asking for, from the beginning, is to know
> > which page(s) are known to *always* contribute to the list. Or, IOW, how
> > do you know the PBE list isn't empty, a.k.a restore_pblist isn't NULL?
> Well, this is keep going around in a circle, thought the answer is in the hibernation code. restore_pblist get the pointer from the PBE, and the PBE already checked for validity.

It keeps going around in circles because you keep avoiding my question by
pointing out trivial linked list code. I'm not worried about the linked
list code being correct. My concern is that you're using a linked list
with an assumption that it is not empty. My question has been all along,
how do you know it's not empty?

I'll change the way I ask this time. Please take a look at your PBE list
and let me know if there are PBEs on it that must be there on each
hibernation resume, e.g. the resume code page is there or whatever.

> Can I suggest you to submit a patch to the hibernation core?

Why? What's wrong with it?

Thanks,
drew
