Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC5697ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjBOLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:33:51 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EAD37F3C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:33:31 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-530b85f118cso35659387b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj2P9NKMVMnSiHo+/0bBvpkftuasnb/1Zqo6PRSg2Ho=;
        b=Pnlw//355ECERe7jIkjr3lHZBlm0m9Lhv8tU6WeRcN0T5pd+UG/2iWx2EfOa5A5zIJ
         PMnrvXFWglBupXfsTQubNlyxZp9L+LJjWxeWivhlbszw6svjJ8RWJHk/oJhgYvpFHr3r
         wtA+WLYf7dmQFcZewM95I/3r31NZJVHbWxJ0YlA2kRGmlSSD7Bvd18cX9JjnKKxJOrbR
         bNkNWb0YQvExTa1Hd1P+Kd7KxXyDsi3KoOJJTn6CZI5DUbPqv1bRmyl2ufR9CCacKglI
         06dF+PiynCvuHSIyAaS5YDy+L1/TmSwucSfZBy8+Wut4WN6927QeiB7flskHjIWk1Qd6
         HYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj2P9NKMVMnSiHo+/0bBvpkftuasnb/1Zqo6PRSg2Ho=;
        b=BH5JLN8k+Ym2Bu5dQ35sdfkUs2dSWGEjEreAgpwnSPDtzILRUvi/LCa8/yY4pJhhAF
         33mRDVvkIFSkDp7CmI/V/AVCSR/vr2QMHt+y4e4KqLmCGe47g2ZLnuc05AFBw5veEp5Z
         +gDgc1ZvFX8Q0k1KEVqqXlnkB/iT0Rk457ihmH/I/63HfYWhHQ7yS9eL89/lCzQMb0O1
         Ej//YNDfM7N5L+c8ZZ9pIdp5X/AqtbDqgiiCWmX1SetP5XxSAB9Fbgo9c4IoB37CC/bF
         CmuDxcxTqHfzQ0IRQJBpgrwzcCE/msdeXr1Q6cElWYpu7mLx8kaSOdlSAQg/TbJvFZBf
         uRYQ==
X-Gm-Message-State: AO0yUKVkC0o9gKYtiuoUuB6VF0MtN3d4C/ncftypkE92Cg7R/gRy2fEY
        W16CnDc/mPir016d9jZZ7YxkEolJXurWt0S6DzVKseG88ChkSQ==
X-Google-Smtp-Source: AK7set8OrXoKmaG52cIMHBiL3yt57kB2vJE3raatZO5Eei7L5TPvJKqKP/95rUSCn/1I1rOgvvYVEhX/2JAqjGZWR4k=
X-Received: by 2002:a0d:e4c2:0:b0:527:af4a:6a12 with SMTP id
 n185-20020a0de4c2000000b00527af4a6a12mr248826ywe.297.1676460806859; Wed, 15
 Feb 2023 03:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20230214073638.571417-1-alexander.stein@ew.tq-group.com>
 <CACRpkdaV3Jv8=ynw5HUH8x7VGuCjFAiULbt-tRMZAU3T+Wo1Ug@mail.gmail.com> <86wn4jxjph.wl-maz@kernel.org>
In-Reply-To: <86wn4jxjph.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Feb 2023 12:33:15 +0100
Message-ID: <CACRpkdbSN-FzKB4FT7YX6h5U+rojO4OcmYJMJw3khdOqTeDmoQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: vf610: make irq_chip immutable
To:     Marc Zyngier <maz@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:16 PM Marc Zyngier <maz@kernel.org> wrote:

> > We fixed quite a few of these now, Marc do you have an idea about
> > how much we have left until we can make immutable the default?
>
> I haven't tracked that, and making it the default would probably mean
> getting rid of the code that patches the irqchip structures. I'd say
> that once -rc1 is out, we replace the polite nag with something
> nastier (WARN_ON() of some sort), and push that into -next.
>
> Leave the warning in place for a couple of releases (until the next
> LTS), and then drop the patching code. The not-so-nice part is that
> that drivers that haven't been fixed will break silently. The good
> side is that these drivers will not have been touched over 2 LTS
> releases, and are thus most likely abandonware.

Hmmm I will take a round and fix some more that are simple and
obvious, I know some that are definitely used but just sees low attention
from users.

Yours,
Linus Walleij
