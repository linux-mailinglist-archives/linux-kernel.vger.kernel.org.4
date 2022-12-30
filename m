Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEA659BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiL3TX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiL3TXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:23:53 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82791C109;
        Fri, 30 Dec 2022 11:23:52 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id pe2so10737978qkn.1;
        Fri, 30 Dec 2022 11:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D84WOL4GXwiTJJrpeQ62xovhe59CcQCnUedXOg/LW00=;
        b=EuHJC6PQvaT3bny/WLU7UySyxKy95WJVrh6K52HROLylITYzIzx8pU2j83UreqPVEc
         PqDU7/HtRPUwJDIfShHAI30gshq21vjYX8Ya4wYqfv29tAtZrHnWIoc+6ySZCllxu5Px
         BuCJHLe/JkpcjSkgVJ5e4qYjRZjsuavGN+oFEyYa5BCL5RjUJdCG+j2ZMZMapUQjuTef
         x3h73DVJucewKBWWkKey5PHchnWCX10wy3YUL4YpA1E2v+3D0ElkSFl/6rO5JX9pAX7d
         AmPx+cgpvQEifQ0yph+liQ0/LxcX9GXjMgQlP8u5dCcivLlWgL/Kb3cNTmhzTt2sMzyA
         BQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D84WOL4GXwiTJJrpeQ62xovhe59CcQCnUedXOg/LW00=;
        b=iOcamezx6w+qDAsFoAsG0JsaudwINpRu0M3LVRZfd8mPif1eOqUtJC4516QsyCkYBs
         sY3NNFAVCLns98tJeU4fYByIuq93hnp0Ie4BetYXUd7BV2+X+5bUMkB1Up+SIYLMsgBg
         zkx7DRJ8HyHZjGXSuzWbV0js+FPuMYsM509yjAvvHW+MclD0K7x47E+XXONmsesgGKrB
         e/9+OmyDDpGz3T8/BQg2CjR/gAvXfc7a3AmljOmgIl9S6nnqqRyR6seUzCvImsmJn/r0
         sHqmTfmjtiiqITZrv+JgK1m8fh84oL4ZEjklKsJtPLeDmwjTZdscp572v9EbV/YKxmpk
         1R7w==
X-Gm-Message-State: AFqh2kqVirx77ry0MPMXOx//FcRYfh7x3nTnrcB07wSQbHy/IyyK3jok
        oxeyUATsLNELRQFnOc3PzFZiI757tmM0xkSIyUA=
X-Google-Smtp-Source: AMrXdXsFvWJtbCWpXfh/Kc6BBBK6TYIxePUMGUDDiNyUVAnHli5E78muOTSd4Ltgq1cgxiR/M2U9BV1e5ti0TJ9NNjE=
X-Received: by 2002:a37:a96:0:b0:6ff:3ebb:500 with SMTP id 144-20020a370a96000000b006ff3ebb0500mr1836335qkk.320.1672428231949;
 Fri, 30 Dec 2022 11:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
 <20221229125957.45923-2-andriy.shevchenko@linux.intel.com> <CAJZ5v0j3Dv5DJh4oN+i2qXi=zU8PhGeMsUY2v-mZU5tKJWmsxg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j3Dv5DJh4oN+i2qXi=zU8PhGeMsUY2v-mZU5tKJWmsxg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Dec 2022 21:23:15 +0200
Message-ID: <CAHp75Vdca1bMJeJwrOK5fOp8+TnJYwus3z6PyYyvhg+LDgyufg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
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

On Fri, Dec 30, 2022 at 8:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Dec 29, 2022 at 1:59 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There are a few drivers and might be more in the future that
> > open code the functionality of proposed DEFINE_NOIRQ_DEV_PM_OPS()
> > helper. From now on they may switch to the new helper and save
> > a few lines of code.

...

> > +#define DEFINE_NOIRQ_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> > +const struct dev_pm_ops name = { \
> > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> > +}
>
> There is NOIRQ_SYSTEM_SLEEP_PM_OPS(), so why is the above needed in addition?

It defines the constant object of struct dev_pm_ops type with this
included and as the commit message says, allows to save a few lines of
code in each of the drivers that uses NOIRQ_SYSTEM_SLEEP_PM_OPS()
currently. The examples on how to convert are provided in the patches
2 and 3.

-- 
With Best Regards,
Andy Shevchenko
