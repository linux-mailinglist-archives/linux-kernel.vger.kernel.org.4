Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB46A66C077
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAPN7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjAPN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:57:49 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C972195A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:56:35 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id q125so17332544vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjN8CVhZObDPaSBf0c7cy+cZ0hKPnAPq8A620naKKZg=;
        b=YRQCE3tux2Ndi3YV94WG1FxQoNK0Bs6geZFQ1Dv2FmvBblbWV7S6ppu4hc5Os0O+PX
         LGHujExzAkan5j/1pekcU+gIsgw+KSfMcthEC2l3mGwu675qtW+wXievSlBboGe8+2xJ
         uTPPySlsKSHQfEcXXhwIyiqOZHQvPLkTSPpzP/nFhf6prDTZpfbA/e51SJeLLy83Rul6
         x03yR/IB2KEJP8XCdsMB5spVfI0JhJbnzParxsOre4Ezs34MRwvn769VX1fWxEg/JMIB
         jps6V8uFmBv0HJ4SnCwI5xu41C1tfcNCbpYxFB4U+yEpFRRe0OK3Bcq7wa6fHCaf1ceW
         JTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjN8CVhZObDPaSBf0c7cy+cZ0hKPnAPq8A620naKKZg=;
        b=43SPv5gtWd3aIi04ofbqQqrL6/wq/Hn3BLqvDZV/Jpr5ViH1gkk7bvcPTA4T/i/BQ0
         GrdvZ/2YKN4wyxJZGTeDmAP4itd8exdHskBeHwn9QVWluX2hnGPhfDJshKaLQ6NkJWnF
         4FZwEcG8Kz7SQXs9FRIjXhe7CGzQGlTJhP+RGkLWihfrhGva81grT0HnBvXl2qPKn2eI
         GEGe8vM/z/7kAqfNB7cOOZ7+d7oj8TwnlVSW/AK+StmAv8igSOHxbL7Fn1ksC4211bqG
         JuF7I8Ao+J//UHgSLd7BYoSarmz5ebQ1/NaN1Uf8PeDYgW/1TkIpZc2Olsh66rF+tpiy
         Wfqg==
X-Gm-Message-State: AFqh2krNeR3arJDSDD1io6TFYvFo/jptlO9XT/RhqB8p+JtiR+Xak85c
        jigsD8pdgGk7aClm2drK0GFYAQM/6Qmy8XbgsSNv3g==
X-Google-Smtp-Source: AMrXdXs+HUmvx8auM1W65HBnw1/zlTGaQifSZJOf0nZxy2gBciN4SKDeQA5+P8NlR17+c14Ks/VxI5V2vxfAu4e392w=
X-Received: by 2002:a67:f899:0:b0:3d3:d90c:5ef2 with SMTP id
 h25-20020a67f899000000b003d3d90c5ef2mr537386vso.17.1673877394705; Mon, 16 Jan
 2023 05:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
 <20230113182619.16800-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdkgWBb5XTSMEEUQQGCO_3x1a3KK0KbvW4GmAQX1XGbxg@mail.gmail.com> <Y8U8bZ9+dOwmDgsb@smile.fi.intel.com>
In-Reply-To: <Y8U8bZ9+dOwmDgsb@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 14:56:23 +0100
Message-ID: <CAMRc=Md65GUZ0XXd_35gzS8SJQAHXG9neE4ZCxZXBr0q2nOc-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: wcd934x: Use proper headers and drop OF_GPIO dependency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 1:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jan 16, 2023 at 10:03:47AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Jan 13, 2023 at 7:25 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > +#include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > > -#include <linux/gpio/driver.h>
> > > +#include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/slab.h>
> > > -#include <linux/of_device.h>
> > > +
> > > +#include <linux/gpio/driver.h>
> >
> > Any reason for having it separately here?
>
> Yes. The idea is to emphasize the relationship between the driver and
> the subsystem it's written for.
>
> P.S. Thanks for applying the rest of my contribution.
>

We almost never do it and I prefer all linux/ headers to be grouped
together. I like separate sections for asm/ and local includes but
this is overkill IMO.

Bart
