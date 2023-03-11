Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADAF6B5F35
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCKRiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCKRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:38:03 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEFBCB051
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t15so7801423wrz.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ep5ybAjvx6CM77r0o4h5O656hCAdkDTtggDwcVoMHKs=;
        b=HuBDGqYI/z559xBfEtjFrr+Y/Ck4nO2EVTrNgGt5NQadEbUquCA6x3hE/pzGALqeYC
         qWaQeVpvlnpmE70sGsN90mbjbOFVyvYZdZoBFoGi8/7gq44b3jrJc3DNeVY6iijx39Ia
         rRZpHPd4BrK3eKO7U5oR3WyFYyPa30JRiV5CkT5cwyK4Hb+hfnKs0Wl2sXIArD9DzEpR
         ItJT/eWYjeC+AwGtUQyDSxP3Ac7lNZzlKydOnYW++uYhY+V7+uhIa83rvMx82tqM/5tR
         NQI1GNqc8fD9B+kvK3d+iX1TdnoXI3lN2slHLPSIACZb3ie1EpICHGsMoMkKCpO52yFk
         j78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep5ybAjvx6CM77r0o4h5O656hCAdkDTtggDwcVoMHKs=;
        b=wTpI0VM6yjdkwK4G+aUUpMCRuG9H7+/hjfd2Mv50vd4/qayAWLNhqu57oVUQilnq5B
         rN19vCRcQcy0R3+fxJKPqxpQnMbygCw92h3u+nZXdJ6dDlJmlq7y8bGSvYo7jRJkWZMe
         4tLAZqxcN8bjTxXkWcCd+ff0pU8EhNNq1HKLl9iq1mXT2Rs4DJfWrnVXlVw/v+u9k54p
         XBT04pgH4JdmM7BMSQUnxVJ9eAAHoBLO+jrvzCkHKKT/Btkmc4lCxsnUfy676LoIuVfy
         8BW08IlmhF4V1KDbhcgCybMaUXkelpgRWSnIm2J/x9McYXS1ZTc4Wdb2Al6r7j+5OtwC
         g6Mg==
X-Gm-Message-State: AO0yUKWCOwfkMq8F1b2lGlKldxbUvWYwI63s4yIawsKpbNQBiv5P/moo
        ci/ZqENNjeIecie/HcMaNCTj1A==
X-Google-Smtp-Source: AK7set/drsfLqA5hVER8mNLq/cgavOOniOo6RTxR3/S7L3IquIsp0xpw9SSZtKwYBBscKVkVrPFcqA==
X-Received: by 2002:adf:f4cf:0:b0:2ce:9e0a:10ae with SMTP id h15-20020adff4cf000000b002ce9e0a10aemr2292889wrp.53.1678556208709;
        Sat, 11 Mar 2023 09:36:48 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j28-20020a5d6e5c000000b002c551f7d452sm2802738wrz.98.2023.03.11.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:48 -0800 (PST)
Date:   Sat, 11 Mar 2023 17:36:46 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ajay Garg <ajaygargnsit@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport-request@lists.sourceforge.net
Subject: Re: How to resolve "nptl-signals.h : no such file or directory"
Message-ID: <20230311173646.GA4559@aspen.lan>
References: <CAHP4M8UEnLeTbrR1fZOJ2KkRAHLJLewjT2xg78AzzoXPYcz-hA@mail.gmail.com>
 <b6530d49-074d-ee68-ed87-57c9d60d4847@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6530d49-074d-ee68-ed87-57c9d60d4847@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 08:52:53AM -0800, Randy Dunlap wrote:
> +add some kernel gdb people + list

This looks like a userspace backtrace to me, so rather off-topic for
LKML but since I've read it already...


> On 3/11/23 08:00, Ajay Garg wrote:
> > Hi All.
> >
> > (Sorry had to write to this list, as the subscription to
> > gdb@sourcewave.org seemingly went successful, but never got the
>
> Is that  @sourceware.org ?
>
> > confirmation email. Even sending emails get bounced).
> >
> >
> > I have been trying to analyze a core, but unable to receive the
> > complete backtrace due to following error :
> >
> > #######################################
> > #0  0x0088ad6c in __libc_signal_restore_set (set=0xf48f2a78) at
> > ../sysdeps/unix/sysv/linux/nptl-signals.h:79
> > 79 ../sysdeps/unix/sysv/linux/nptl-signals.h: No such file or directory.
> > #######################################

This is not why you are getting an incomplete backtrace!


> > Following is the (incomplete) backtrace :
> >
> > #######################################
> > [Current thread is 1 (LWP 7491)]
> > (gdb) bt
> > #0  0x0088ad6c in __libc_signal_restore_set (set=0xf48f2a78) at
> > ../sysdeps/unix/sysv/linux/nptl-signals.h:79
> > #1  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:48
> > #2  0x0088cb78 in __GI_abort () at abort.c:89

Frames 0-2 tell use your program called abort() (e.g. you got a core
dump because whatever you were running *asked* for a core dump to be
made)..

> > #3  <frame with modified names> 0x049b3a54 in func_1 (ffp=<optimized
> > out>, base_name=<optimized out>, max_size=<optimized out>,
> > file_type=<optimized out>)  at a/b/c/d/e:58

Not sure if this is good or bad but...

> > #4  0x00000270 in ?? ()

... based on the address here I'd say that this stack from is for a
function provided by your application... and you forgot to compile the
application with debug information!


Daniel.
