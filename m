Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2579D5EF662
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiI2NX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiI2NXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:23:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303D1822DF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:23:16 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 3so793937qka.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/LqaYMWd+e8179nhCnWMpRCYJw9EIbTWpFsZd76jedQ=;
        b=hq5kvNzqKKzq7AL+WK6BeB0Tb3Vwv3HuT571a3AFTgOcR13KCW4jZvSstDnxBGV48G
         2imJ1e/DoIxjTv1IE34mGAbLlr0hopJe60BrS/YY6ANrnaIbdDV/Rgm2dC646OtWNzi7
         xVgDO18r62OVs0xzGNv0loZEN2J7QE6qFnvXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/LqaYMWd+e8179nhCnWMpRCYJw9EIbTWpFsZd76jedQ=;
        b=iJXjLrAh0nOsGFi3ISjIaQ2GfyXOZ2/2JS/NvQGFWR6aQCnW6Vw3LwVy9I9Zz7Rbxx
         i1Z1UN3IXaxm/kBs5nb79WLRw3LTLp0Yu2ahk9T48bp44L+CYnqODimxB55TxOvnORJH
         OJgSjRyRLr/KvWJY3GuulT9ka/jK3rG+APDsDcS5tY1Icc8WtXVc9MjzCV1ix/W79j8v
         uarlnITPQHuGO6A5jM0Yegs82RpyfeEk4/mIkGci1qVx5YoQzAeDZzWRmSlO0pMUDYUZ
         2fkOJmXfsBK4owhuo3SeZKziPtSjl+gfhwsthzgyxy9KutvElzjCZJQwotjt0irMB00g
         pY9g==
X-Gm-Message-State: ACrzQf2jEMJYpyVbqy1/kRhUXMJ3t9yV1KfGwe8weBFtGsdLk5p4DvIk
        QceXgqQgc7R78UbTHKnzhzncYN9fxlpeBg==
X-Google-Smtp-Source: AMsMyM5foMFwR0Hx4cCiSgfSNDr9y0WYH1TUU9n5gfp9eWV4TH1N/thdE0/yWIOeEcygQIaoBbk4EA==
X-Received: by 2002:a05:620a:b8d:b0:6ce:1be3:fee7 with SMTP id k13-20020a05620a0b8d00b006ce1be3fee7mr2066217qkh.725.1664457795027;
        Thu, 29 Sep 2022 06:23:15 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id ci19-20020a05622a261300b0035d57445127sm3666371qtb.47.2022.09.29.06.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:23:14 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:23:13 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20220929132313.vkw3w34xulowpebq@meerkat.local>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <YzWVJpqNq4UeeaoH@kroah.com>
 <92c43f2b-c89d-cb9b-a7ce-777171258185@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92c43f2b-c89d-cb9b-a7ce-777171258185@gmx.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:09:35PM +0000, Artem S. Tashkinov wrote:
> Keeping the website up and running requires next to zero human
> time/resources, that's not proper maintenance.

I'm just going to let this one slide -- but so you know, just keeping spam
hidden/deleted on bugzilla.kernel.org takes 5-10 minutes out of my day. Heck,
I even wrote a script for this:
https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/bugzilla-junker.py

> The components/subsystems/developers haven't been updated in over a decade
> which results in a bug tracker which is nearly useless.

Nobody's asked, and it's not the job of IT folks to figure out what these
should be.

> People often file bug reports under "Other/Other" and no one is notified of
> anything.  I don't even want to touch on the fact that the  Bugzilla version
> the website is running is terribly outdated.

It's not. We're running 5.1.1. The latest is 5.1.2 (and it breaks in subtle
ways, which is why we're not running it).

Again. This situation is not a tooling problem. It's a "nobody wants to do
this because it's boring and unglamorous" problem.

-K
