Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C615F6E62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiJFTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiJFTrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:47:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423DE31B4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:47:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g27so4276087edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1uzEnlZtD+6hqfypn+8J5Jc8UVTzuQqtF2T+saJjYgk=;
        b=W/WIeLZVoqHzSPloQmG/8gIwmIWPtLYMEPqI+N867cl2F0+QobYYhnhs9gy+hquIxI
         tddirIsl90y24/tYkSxc3erhsttghyqPc+ytuYPgEYppcOt8hRBWOlafS0C4TwNE6TFU
         /9PfipOWtSQFvQqWrRia5VFMWzMJ0pz8HgfkDsEzUvLasx2ChVibdmpFbWAIGfEhikw4
         81cuh32o3N33OZborE7gCGmCiOVXLEX9J1jfbeXjVvTdvvdqem8w4tbwFcNSu03sqjTc
         J85UVSO/vfKdLN93yldoHuiWwqgke5IijrPltme1Ql80j+34rsHLWETnxBm/oGs9MGdK
         lffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uzEnlZtD+6hqfypn+8J5Jc8UVTzuQqtF2T+saJjYgk=;
        b=Iaiy+slVwNtU84HH6C6pJZ45jyqDk1toiwuk8qKQxrCKy/v5aROfE76eq0udVCK4hr
         zqq9bH9LLlnGyRGWx1JAfxGjit9xaiA/unfA7YDxcxk/+wxiZz20oM44gFz104z1iK/e
         ZpdRnn6JOZp40ct/uPc81VSRy5s5UL9LUxOQSjkI5ir8kp8ryFxmI8PpcQZjjEE0FTAQ
         rYdzt042vtTba2mnwRikTCwueUbA/dgZK+SUM04C+nZ/ih4rpse8h1TVFWz0AYm09clf
         KiKITKZK0FKP8IKjtruJIViVk1Pq13u0RyeWXfJ7Em0HrxuMUEr8Kl/LSTqc3uMGmR59
         EKFA==
X-Gm-Message-State: ACrzQf1uJZEckS8RIlbNOIdZLVxqp5arIGceMpixC/juV/8NrdavNbMx
        l8eAS9Up0x0PbDZN4W1H0QokvHxQOzUD/o1HOrmqQ4ZIPfk=
X-Google-Smtp-Source: AMsMyM42EiNpsT3u91YuvX66+3U2Z9siPjm7ovtCCAHQ54/I3zXEmnT+YRoEkr7VYd7Mjz39nM4eIyYJ81Beu5Iosgc=
X-Received: by 2002:a05:6402:378c:b0:458:8053:6c5f with SMTP id
 et12-20020a056402378c00b0045880536c5fmr1353884edb.9.1665085668527; Thu, 06
 Oct 2022 12:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <Yz0koHybNXGTFfDr@debian> <Yz1ew+EdD94TjQYK@sirena.org.uk>
 <CACRpkda-dquOCUChDMwFgGy7kUNFE05H+Bebb2bB5=UQGgwyCA@mail.gmail.com> <CAHk-=wjOwH87ftq1jUgk0md-6FaRyXVNMniGpoiAuCEAG6ZvyA@mail.gmail.com>
In-Reply-To: <CAHk-=wjOwH87ftq1jUgk0md-6FaRyXVNMniGpoiAuCEAG6ZvyA@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 6 Oct 2022 20:47:12 +0100
Message-ID: <CADVatmP=rFSh6+pxHNTRnQXa9NvbkgO7M-6DOJ0Evis2hf2GRQ@mail.gmail.com>
Subject: Re: mainline build failure due to 81c0386c1376 ("regmap: mmio:
 Support accelerared noinc operations")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 8:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 5, 2022 at 1:04 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > There were some further issues with the fix (alpha is really hairy)
> > but Arnd stepped in and fixed those too, it should all be fixed up when
> > the arch tree gets pulled.
>
> That is now pulled and pushed out.
>
> Sudip, can you confirm that the alpha build is ok now?

Yes, alpha builds with gcc-12 now.
For gcc-11, I had to revert 5d8c3e836fc2 ("drm/amd/display: fix
array-bounds error in dc_stream_remove_writeback()") and it built fine
after that.


-- 
Regards
Sudip
