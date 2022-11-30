Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE9C63D152
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiK3JBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiK3JBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:01:03 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C145EC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:01:02 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c140so20688412ybf.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbVbgsH3XRTQv4786z5ER1yQeEoNdKbadkVm9l1r2WM=;
        b=jpfGnLgK/1cG6bBQcrKLMuOQiKzdWPOvTlsnIw4uqyLKQB3Y35J6A+P9dz0cdrlcqL
         HZhqFeQZeMvQvtxffy0pO4SFOOtTnfGiHz1pI4HXacAFsoCyixjxNkZeTRAkvwOWNt8H
         0oFPHx+yka4PGucML2TC7WFhenIczYDCYPuKrGShpC2xUii2XIkDcdTbN6tX7QI7hU6d
         Z3jHz5Ke9gOYxM1shAuaNoHaGfnqgBrSo0Lc/qVPlibA/20nT3U+BgiwxJlNmeAO0Y1x
         fZyiy16VZspf44UMuMkocJp6vfI/JNBdV1uvZzKxBJXgccR5LLuX1gMY3az9/Lp36mzj
         jdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbVbgsH3XRTQv4786z5ER1yQeEoNdKbadkVm9l1r2WM=;
        b=PgTVr4QxkYH+EUhZEp458EiArt8azdIW1CgSqRXgeOHwOPcLdUMj2EqCNzWP4ke7Id
         yP0BT1Q4LnNWRlAEg47gWQwmpM2fx5mEARzE7aq2mbwteTTYxLHby97M74Vp+H6x0K1e
         epQ+J5g9gAqc6CrHKel3t1ZSaI6px4l+UGS/tdTJ1WlM1RAUdlMq0naOOr7y12cCW5ul
         KvyQXxlOXX67TAKGljAV6mlKVZE3Wpmk9uEtM9vkzBq8u6ZJB271je/WoEBwWN9GHOsJ
         IG5i4Cg0xUAeyj8h2TYu4jtORsCJr10T17mOdKY8nCu9PinW2kjIvUeedCJRVm5AMCdc
         M4qg==
X-Gm-Message-State: ANoB5pmkbvj/5zsWi5Zj0dx6K91aSMdIGVcAqOLB0ku8Sa5kGVVRlJJx
        9VrvORRMqpZ7gKsVen8fJhHT2MA/YIXzRGp+/CjnnVYQJjaTGw==
X-Google-Smtp-Source: AA0mqf5nvJFCwC+Bm8UuGEcbvyqnBNs8xlBIAHq6KVDu3vmowiOFuVe2nCDzI5eQr+k/J/6u/NaNpmdNaQvvxoaXX/I=
X-Received: by 2002:a25:a241:0:b0:6ee:e865:c2e2 with SMTP id
 b59-20020a25a241000000b006eee865c2e2mr36593660ybi.206.1669798861231; Wed, 30
 Nov 2022 01:01:01 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
 <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com> <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com> <BYAPR11MB3240CE6547117D138B1A112DE1129@BYAPR11MB3240.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3240CE6547117D138B1A112DE1129@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Nov 2022 10:00:49 +0100
Message-ID: <CACRpkdbOPbqot+Yf6i_EayPrRn2S+ZTA1FzZ-0OkjXjR5UZvqw@mail.gmail.com>
Subject: Re: Intel timed i/o driver in HTE
To:     "N, Pandith" <pandith.n@intel.com>, Johan Hovold <johan@kernel.org>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "timestamp@lists.linux.dev" <timestamp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 7:10 PM N, Pandith <pandith.n@intel.com> wrote:

> Intel  timed i/o is mainly intended for couple of functionalities.
> 1. Input event capture with timestamping

I understand this part, and it is handled by the HTE subsystem.

> 2. Generate single shot or periodic pulse train
(...)
> c. Most importantly, precise time synchronization between devices/sub-systems
> Ex : Share precise time from a GPS receiver to the network or
>        Synchronize processor clock with external signal.

So I think this is the actual use case of the output mode. The
pulse train output by HTE is to share precise time to GPS receivers.

So what about putting that part into drivers/gnss?
GNSS Global Navigation Satellite Subsystem like GPS etc

If this is the only usecase, that is where it should go, along
with the serial or whatever transport driver is used with the
GPS. I don't think this is a generic functionality (such as
GPIO) at all, but rather a very application-specific use case
which will only be used for GPS time synchronization.

If the timed output has other use cases - and I mean HAVE
other use cases, not COULD HAVE other use cases - then
we can discuss generalizations. There is no point of designing
upfront abstractions that never get used.

Yours,
Linus Walleij
