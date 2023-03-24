Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2225F6C7BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCXJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjCXJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:41:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9F35A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:41:47 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 61-20020a9d02c3000000b0069fe8de3139so618453otl.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1679650907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=imCEf0eiVAunrGXQwrvLTIleJK4ABXMofTeDXcpOer8=;
        b=WVtoubhZVec70O+sKvrrUVZ53e0xSOeSbKlPVLHjSkoE5cvRGK+00/bcMND2F3wezI
         abaeGFZsddvAu0JiPGAKThDqiXcZnUVRO6NrcRyj2tvWesQIciutXd0F69L558LycT+H
         7aqZRC2OW3sR7XxRyjE5Z4DyBsuGtLiHjav5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imCEf0eiVAunrGXQwrvLTIleJK4ABXMofTeDXcpOer8=;
        b=Wx2igezYydcwV2Sp63m4lHWZ7tqr8yBpl6O63SNj/VzV6RjvgWWxtRYm2pSwY1xXTG
         gR9SxLAhjY0/odVDQBbGIBZHUzBJjlle+Q4rhfqz1G3r0HWDIBxJQsCppFg6KodYy353
         NLj7iUSbrCYKIafrHmkVRXy53nz9iSkJUwlWqCAJb44xBfkI2U+LbQM5/dI9TTp8+avt
         DH7h+XKXnz1in2oyVmoK1hC79cNdvNG370frnzgmWuNmM/Lk4V80Xr2hJIuDjfVYUcn2
         w/cFnZMAUNcYWC8hbhrV061yb5tqh5Juor4s4EGWsBTHLk/HT4ATQan4vDGuZlhD+sQI
         PILQ==
X-Gm-Message-State: AO0yUKWaausoPE7rP88WLDhKwszU3cdKIiXyFV0+T2nUFw+ATY5UPv16
        jMrigi8G3DI1turQqGuiQhR1v7MYGdbRL5LxAxnlug==
X-Google-Smtp-Source: AK7set/mxAIsCSniMOJjqyg3fNkhUOhEt8h7I32a0B1lxBVVCccdwJ6tfHO02wgf60ABVSkL9rmZvnsaXRDaZz14DZQ=
X-Received: by 2002:a05:6830:2009:b0:69f:b:e44e with SMTP id
 e9-20020a056830200900b0069f000be44emr822364otp.6.1679650907153; Fri, 24 Mar
 2023 02:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X>
In-Reply-To: <20230320180501.GA598084@dev-arch.thelio-3990X>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 24 Mar 2023 10:41:36 +0100
Message-ID: <CAKMK7uEvAQ53iSdVesR1+vFm0X03dqZU_sRkuMv0FVvg_pCF4g@mail.gmail.com>
Subject: Re: Linux 6.3-rc3
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 at 19:05, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sun, Mar 19, 2023 at 01:50:21PM -0700, Linus Torvalds wrote:
> > So rc3 is fairly big, but that's not hugely usual: it's when a lot of
> > the fixes tick up as it takes a while before people find and start
> > reporting issues.
>
> ...
>
> > Please test and report any issues you find,
>
> On the clang front, I am still seeing the following warning turned error
> for arm64 allmodconfig at least:
>
>   drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
>           if (syncpt_irq < 0)
>               ^~~~~~~~~~
>   drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'syncpt_irq' to silence this warning
>           int syncpt_irq;
>                         ^
>                          = 0
>   1 error generated.
>
> There is an obvious fix that has been available on the mailing list for
> some time:
>
> https://lore.kernel.org/20230127221418.2522612-1-arnd@kernel.org/
>
> It appears there was some sort of process snafu, since the fix never got
> applied to the drm tree before the main pull for 6.3 and I have not been
> able to get anyone to apply it to a tree targeting -rc releases.
>
> https://lore.kernel.org/Y%2FeULFO4jbivQ679@dev-arch.thelio-3990X/
> https://lore.kernel.org/67f9fe7f-392a-9acd-1a4d-0a43da634367@nvidia.com/
>
> If that does not come to you through other means before -rc4, could you
> just apply it directly so that I can stop applying it to our CI? :)

I'll include it in the next drm-fixes pull.
-Daniel

>
> Cheers,
> Nathan



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
