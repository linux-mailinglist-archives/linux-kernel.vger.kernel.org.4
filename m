Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1026CC20C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjC1O22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjC1O21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:28:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEEE61AF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:28:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k17so15252621ybm.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680013705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNC4U2pxIqw7OfhmEWv4yVLXtgeYnb8fzcDWECWbK5U=;
        b=e9nOGlYe55ZGkGujdZS/lndA9CplzKkHCawpR0sMsfis72wuB33MDJS52AsbeRcxmF
         8pw84rI/Bt5ZfUOqcmw3ZSaPGBBf3YBWKrF4FoSibVlViabbvDJagFmNi7xms0Jee8AE
         LjRA65l2Qn33umlVU2Wkscdx6I0EyUvKdN5Ot5xMxwXWfXwfggb+EW6ZYPiCXlFSnoZe
         brEPEqGrvrFtVTb73gG/zAU+YVxsSm9xWpyIMvIuXMEl7G/7bVEWC2+2SrBcSBCXG0rT
         xjAFlJFcrX4eUcxZREx3elUxqQutuQoDe7MYh7LCIQmYOdqXLBfxm2DzDGqXREf27k0C
         cHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNC4U2pxIqw7OfhmEWv4yVLXtgeYnb8fzcDWECWbK5U=;
        b=KgZLsuLVHcUa0agq69qFUnF0VA+HecShgkEP0c6nRfWa3IFTwNh4S83To8Hiz/FWyF
         mTv+7BAmhK+6SS9OWUs9hQXrN7gvpNf9NAVn3x8dk/5qJ79CSfqSNZXj0nhrykBI6MMT
         djHjB1hft3la6gbEDv9J/3cVyOWMXxVaos9Md+1enT4zEsYRTtdfGXRJ/6bz2Th51rBP
         AFmWWzzsdGcC0fTtT+SyeplBoqpFen1fBoFC0C/mTQYB058FW23Z5WgAEIrlBJ4CgVYS
         pxdLcDiGNTsvTu4iKBBApLtfUYobg0PGCqPMBYEp0UAkducm0yRPOeEPRjTc4tFjkZTI
         UgNA==
X-Gm-Message-State: AAQBX9ewlIL3U+ZQO5C5OXAg6gAf9zxs0UDT66DSUPyPAmqgASJY5Xc3
        Eid1xaGFOOtX6r5iFj9Hlh+uFW25rmtQaXODJ3LCcXCQmuCDNQ==
X-Google-Smtp-Source: AKy350Zwn8ANrGTAWtdBWtqKWGyBIlkvisE3ufoDT2x2/2BvAiiKHlEk0RL7cbzvvSymfdZb/jJXcBn+NeN+n8FKNls=
X-Received: by 2002:a05:6902:1501:b0:b6d:80ab:8bb6 with SMTP id
 q1-20020a056902150100b00b6d80ab8bb6mr10240285ybu.1.1680013705070; Tue, 28 Mar
 2023 07:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <ZCI+7Wg5OclSlE8c@bombadil.infradead.org> <ZCJGjuOYR6nGXiAw@codewreck.org>
 <ZCJxOgV92yPc3zu1@bombadil.infradead.org>
In-Reply-To: <ZCJxOgV92yPc3zu1@bombadil.infradead.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Tue, 28 Mar 2023 09:28:14 -0500
Message-ID: <CAFkjPTmM_hTstagB8sx6jEpz0fzh3AXfYT06FAoOjSF7bPTV-A@mail.gmail.com>
Subject: Re: 9p regression linux-next next-20230327
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, I'm still mucking about - but I actually have a threadripper and
an Asahi-M1 here that I'm dedicating to regression testing but haven't
quite finished setting it up.  If you look in
https://github.com/v9fs/test you can see the simple tests I'm running
(dbench, fsx, postmark basically) with different configs specified by
fstabs -- I'm using cpu in my automation (the docker container which
it is supposed to run in is in https://github.com/v9fs/docker).  I
started playing with github actions, but quickly realized it was going
to be an nightmare to manage the .github/workflow embedded in linux
trees so am rethinking that strategy.

But, in order to move past the simple virtio tests and incorporate the
network servers, I'm going to probably rework the performance
framework I have in https://github.com/v9fs/notebook to be able to
cover all the different configs and options in the tests and then have
some shortcuts for smoke test, short tests, and long regression tests.
Then I can look at broadening the test programs and also look at
automating nightly regressions (including performance tracking)
against linux-next and mainline.

It has taken me longer than I would have liked, but I'm getting closer
-- and i have to look at kdevops as well!

        -eric

On Mon, Mar 27, 2023 at 11:46=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Tue, Mar 28, 2023 at 10:44:46AM +0900, asmadeus@codewreck.org wrote:
> > I'm going to rant a bit here, but my main problem with testing is that
> > there are plenty of tools, but I have very little compute available for
> > this (just a small machine at home that's getting close to 10 years
> > old...), as this is really a free time activity which isn't getting any
> > funding.
> > [read: happy to spend a bit more time on 9p if it's getting paid :P]
>
> I think we can likely help with at least hardware access to help test 9p =
well.
> If you're interested let me know!
>
>   Luis
