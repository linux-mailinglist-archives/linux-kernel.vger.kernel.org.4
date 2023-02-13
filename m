Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D658695026
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBMTA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjBMTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:00:21 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BE05B8D;
        Mon, 13 Feb 2023 10:59:55 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id n10so7373861ejc.4;
        Mon, 13 Feb 2023 10:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8q51kK6EcMWY45OADx0YlrUAHXXNckmxq84G+AMDoo=;
        b=I/4NsOWCc8x67ptEEuUxp7fSdh+XsKdLD1XwPcF+GLH0I3T2o7l1lxDRD1qk1QKjv3
         bRlSzJobJmfdHFfp101rDy+EfpRww0wmaUuFge6TRQF6uDf/+Q2tj86w4kURDGxllPCw
         XAYSUefJ3x/53iN86Ny8Y7dYd2nhfPvWpEhNgzquKh/DixNOw8qZWCJf1wQ4shF/xJzD
         R/+qoayhL6dWsFR2Zwo9Otx9TnOE0qa+iHHbD3M/XwAZE0EkLK/Yxgkas2YJPZprqxUX
         biJrhje8DSu/tfn8XvZw1JyEAwbvta/ZI1rfIQNYX1/PQzkA0b/Tv1SLRagtEytwLuK0
         bnRw==
X-Gm-Message-State: AO0yUKXDFL1P29P/WuntopZZ7rYEtuiXFShsz6lglp4T+VEQsoPaD6uJ
        HZT31RfOc28FOH3oCbEteuteiO0gW4C3k+2HYLjABs/j
X-Google-Smtp-Source: AK7set/XqnK1+BZIJW75M4vIKfORxIqDUeumVJlSYEssuFY13C3BbT0IgoVIcP5Oz4V35FSTeb4LLvTCwUWrN+l9aq0=
X-Received: by 2002:a17:906:4e19:b0:8b1:28e5:a1bc with SMTP id
 z25-20020a1709064e1900b008b128e5a1bcmr182776eju.5.1676314777309; Mon, 13 Feb
 2023 10:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20230213132812.38646-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jkMez3_7rRqgyvbB9ik55fRxsU6yoLBZ-gVP7djwntmA@mail.gmail.com> <Y+qHpa0GsIilc59A@smile.fi.intel.com>
In-Reply-To: <Y+qHpa0GsIilc59A@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 19:59:26 +0100
Message-ID: <CAJZ5v0jbaemJqNi5bqZXTi2mr0hcfaL+UsJVQt6n4BQjL6ubmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties:
 Clarify Explicit and Implicit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 7:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 13, 2023 at 07:39:10PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 13, 2023 at 2:27 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
>
> ...
>
> > >  That said, for our above example the both GPIOs, since the bias setting
> > >  is explicit and _DSD is present, will be treated as active with a high
> >
> > Applied as 6.3 material, thanks!
>
> Can you withdraw it for now, please? It has some formatting issues.
> I will fix and send a new version instead.

Sure.
