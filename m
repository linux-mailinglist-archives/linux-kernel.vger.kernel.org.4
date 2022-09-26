Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9812C5E97A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiIZBRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIZBRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:17:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673C26131
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:17:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a80so5214116pfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=jCMlCnRb53qyNDTkeO8cUd076gHJP5m5hHzCiydkSPo=;
        b=IGj/PHNuJefjEhF0x+FQVWS8VTdnvq8aeXcnsOhi4lLpYBfAoSzMF0edRjY94cdRMz
         Rmf5WF3NKTgQAXKi7I5y2imrjsEhkhm9DwrNy+LT0Uy+DgwSzbZW8NdxDSiIUdinaN/Z
         vik93l1HW9bvICh0MRKrsS9yC9OklV0O0qMkIm7Eig1xMjNN6Eo2jg/AF3sMfHhmh1vc
         YxXnLRV81VFaCXp5ojNPZZJGJ5wm7sZthZvLakYOVTDXGRzz85bVgI1KO4X/8+vw1ux4
         OD/rcDbr6FPY7YWa52k6u2Ph/HBaJCuMU9RL4RivBiMp/UoKmvjfu9gym6Gk+5IcQ/bu
         c9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jCMlCnRb53qyNDTkeO8cUd076gHJP5m5hHzCiydkSPo=;
        b=fc2gJK/mPwGDkXyeJpd4sqp54iu30s7TuQzTzxOQbaC3U9/8sTzD1VslxM56QEDeq3
         rYjzVBkVvidiz9xKk+Qn/MRU9o2UbaYmlq5SEePlqhUnrpoHdGLzmoxCjPr4SpF6cFXf
         EX4bvYU8dR4EORUooZ7kTeXT6VuwIv8Bnv3nfLVO5q34fac8G1Ii75AR4mmsCQ7lo6bG
         Mn0d1eS0VwUGch2EKoxIAyQQEe7N4RDCb/Xv/drywZm/fXA/0EKVBf54Wpnyr71VOa75
         XuxaxnASDD7l2Jq5k+1kfJ7lsTU59BRgiBdvoydU2Nyi8ZX+r+yUgeyc041V8qmTOfJn
         1ETQ==
X-Gm-Message-State: ACrzQf09muBrII4zgmvSaQIXaojvyuTjIOB+JI3ymk3cgg4Dbe892jl8
        n+ECUN9abCdzKlTL4FGF3wkw2F3SCzWTjg==
X-Google-Smtp-Source: AMsMyM4zeA5Gt/0yDcFLWB5gt0/gpFeuhmnzYg6dk7SWQUkS0IcrqIY2Hi1mtja7vCrzXnrY0YhRfw==
X-Received: by 2002:a63:a14:0:b0:439:e41a:6646 with SMTP id 20-20020a630a14000000b00439e41a6646mr17952756pgk.513.1664155027051;
        Sun, 25 Sep 2022 18:17:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a625f04000000b00550724f8ea0sm10574089pfb.128.2022.09.25.18.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 18:17:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 18:17:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc7
Message-ID: <20220926011704.GA617511@roeck-us.net>
References: <CAHk-=wjc_CDPy5WbN=e_FtPrd0Yn2Wp4JcdRByeyDoM9azK1mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc_CDPy5WbN=e_FtPrd0Yn2Wp4JcdRByeyDoM9azK1mA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 02:14:40PM -0700, Linus Torvalds wrote:
> So I was thinking rc7 might end up larger than usual due to travel
> hitting rc6, but it doesn't really seem to have happened.
> 
> Yeah, maybe it's marginally bigger than the historical average for
> this time of the release cycle, but it definitely isn't some outlier,
> and it looks fairly normal. Which is all good, and makes me think that
> the final release will happen right on schedule next weekend, unless
> something unexpected happens. Knock wood.
> 
> Incidentally, rc7 is also (I think) the first time we have a clean
> 'make allmodconfig' build with no warnings from clang, since the
> patches for frame size problems in the amd display code got merged.
> The stack frame size is still pretty big (and the code isn't exactly
> pretty), but now it's below the level we warn about.
> 
> So that's nice to see.
> 
> Anyway, full shortlog below - a lot of it is GPU and network drivers,
> but there's various random other fixes in there too.
> 
> Let's give this one (hopefully) final week of testing, but it all
> looks pretty good.
> 

Testing looks good as well.

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 490 pass: 490 fail: 0

No more unexpected warnings in boot logs either.

Guenter
