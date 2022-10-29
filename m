Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CA61220E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ2Jzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJ2Jzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:55:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B11211ED
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:55:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k2so18381508ejr.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKJUE5PpesUMlPthy/7jtsxIpyrFHszU8MX24w0iOqw=;
        b=UQUhwGNdq0X8tJkc80e+VXF2JiCAC+hljscaym6YZHYmKkRd7s9WNAbNwOoPs0zioL
         O912aEajqb0ElP99hptUFINYDjMPr7FQXdrGyGvxF97EcNXhYdIpBSOx9RWlOKWLyEMh
         D1GvA4/vu5hsPUm9ShFJNryw/uXTMqmd8sk2VXa+5O/NcO4x9KAYI2kAb1+bEkkUlV8l
         FIq+f+gFegl9QkDaXqAGA5h0VNGlp8QP9Iy1tE9wVDIG8vXP9RjJ6A6pEAbEhKMKkhaE
         iGraO2WkGExIfAlN4IR765FRX7dBKGEecEWxPzaiBeWypG/ofEZQZPZfocSkOPu7cpnX
         gBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKJUE5PpesUMlPthy/7jtsxIpyrFHszU8MX24w0iOqw=;
        b=dmELbiwUiZ14VQWfBrihrGB3cF/TdAQKjqHsXSqlvkm3V4dcWW3mqx74iuqj2YkL8v
         d6yJqfIF6DS7f4BLTkWG9iP5f1/0RFyDvBHCluT3xDcujDxzkHBicz/eRHdWy9IHHpH3
         cA5uC9pbZm9ccW/ZuYqIjx7YP51K7eMINMNBx6OZ05+PbtREgDqaTY0ykFGeSNk+zViG
         Vsh6ruc38/3NIJ3zFE+5Rh5hO7/3zEOa4bDhbjHvPE79IwUKNLQGJod70trQlT61slJy
         +AV4nvA3S8qcLxSAbIT6OjicCg5a17fHAsvrfxHi2QQXArwHFMce2du10L0zDxBeK+aD
         xrCA==
X-Gm-Message-State: ACrzQf3icX2FAHdkWWlc94Y8Y0mszuZ6TF8WCO5UWDS4FU2Gm1n/YVgM
        YYzxS2M/hvNb94t6IPkEHg==
X-Google-Smtp-Source: AMsMyM6qCEaPdFHqeroWiQEeNlkBCBqah9XQTY+YvggxH2hfZfacTg5kPBDQd3ig8gZYoPEBfjaLQg==
X-Received: by 2002:a17:907:6d88:b0:7ad:b5f1:8ffc with SMTP id sb8-20020a1709076d8800b007adb5f18ffcmr1008984ejc.727.1667037331560;
        Sat, 29 Oct 2022 02:55:31 -0700 (PDT)
Received: from p183 ([46.53.250.206])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b00783f32d7eaesm473968ejy.164.2022.10.29.02.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:55:31 -0700 (PDT)
Date:   Sat, 29 Oct 2022 12:55:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] selftests/x86: add "ffff8" -- kernel memory scanner
Message-ID: <Y1z4kZVRmX33GJ0F@p183>
References: <Y1wunXB2iv0QHr22@p183>
 <84E9CFF2-760D-4A5D-9B19-11CA804E1FE8@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84E9CFF2-760D-4A5D-9B19-11CA804E1FE8@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 03:14:31PM -0700, H. Peter Anvin wrote:
> On October 28, 2022 12:33:49 PM PDT, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >During Meltdown drama Microsoft managed to screw up pagetables and give
> >full kernel memory access to userspace:
> >
> >	https://blog.frizk.net/2018/03/total-meltdown.html
> >
> >We don't want _any_ of that.
> >
> >This utility named ffff8 tries to read upper half of virtual address space
> >and report access that went through (excluding vsyscall page if present).
> >
> >It works by doing access and rewriting RDI in the SIGSEGV handler.
> >
> >I've tested it with kernel patch which installs rogue page and it was found.
> >
> >	$ ./a.out -h
> >	usage: ./a.out [-f] [-r] [-n N] [-s S]
> >	        -f: sequential scan
> >	        -r: random scan (default)
> >	        -n: use N threads (default: $(nproc))
> >	        -s: lowest address shift (default: 47)
> >	        -t: time to run (default: 256 seconds)
> >
> >Intended usages are:
> >
> >	$ ./a.out -f		# full scan on all cores
> >or
> >	$ ./a.out -r -t ...	# time limited random scan for QA test
> >
> >Features include:
> >* multithreading
> >* auto spreads over CPUs given by taskset
> >* full sequential scan / random scan
> >* auto split work for full scan
> >* smaller than 47-bit scanning (for benchmarking)
> >* time limit
> >
> >Note 1:
> >HT appears to make scanning slower. If this is the case use taskset(1)
> >to exclude HT siblings.
> >
> >Note 2:
> >Full 47-bit window scan takes a long time. My 16c/32t potato can do it
> >in ~8 hours. Benchmark with smaller shifts first.
> 
> Good initiative!

Thanks!

> Only complaint I have is the name and the limit to LA48. LA57 (5-level
> page tables) have the same potential issue.

Yes. It would take only half a year to scan 57-bit space if my system
had one. :-)

> You may want to consider doing a breadth-first sweep scanning
> by decreasing powers of 2 as that will more quickly catch errors caused
> by problems in the upper levels of the page table hierarchy.

It can scan from top to bottom so that fixmap space is easily covered.
