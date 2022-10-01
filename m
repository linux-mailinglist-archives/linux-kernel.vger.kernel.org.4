Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4E5F1FDB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJAVkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJAVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 17:39:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9860C21E33
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 14:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 188DDB80880
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 21:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7804FC4347C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 21:39:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RpMoUrQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664660384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zY+sGcDPGGqdRwRg4N2CL9omncKUBw/Iw0uN1+4t/zs=;
        b=RpMoUrQF7GcAy0C+wcD/peVe9QbDv1+ao1xDwOvmXCjXX/kP8sgWcUZPes5g4JfHfI5E7u
        tVNSqnjKpKuNMl2p/wujrjWCaTVPHl4nPG8NETw3G5l7Lck7xd9gHLWndOJWm5fZWkW+b5
        i2Ag0sWfvg8ZW9Cc1U09ss+tn0SqK/8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7fd9479c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 1 Oct 2022 21:39:43 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id t18so1380397vsr.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 14:39:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf0gg7K5/h9v+CPxSR4NoevM+VSUyUU7+HQj5eYiMs6nxuxhQrt6
        18hfURjwHOJybtKJZWXLafN4ff2G9jEGmYUHsUM=
X-Google-Smtp-Source: AMsMyM7sHEmgFmXKz8Kokh8KyneKefio0PsaMbw+IMwTY3xvpkXrTA8q5npjWlKTbqK/B7j7u0cUcS1gPf6f41rfw+Q=
X-Received: by 2002:a67:e401:0:b0:398:89f1:492f with SMTP id
 d1-20020a67e401000000b0039889f1492fmr7013695vsf.21.1664660382798; Sat, 01 Oct
 2022 14:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221001153621.56067-1-postmaster@gusted.xyz>
In-Reply-To: <20221001153621.56067-1-postmaster@gusted.xyz>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 1 Oct 2022 23:39:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9o4uGHByhTDpm4UPBwi7+G4R8K41xe_UivOGpvaeB8F-g@mail.gmail.com>
Message-ID: <CAHmME9o4uGHByhTDpm4UPBwi7+G4R8K41xe_UivOGpvaeB8F-g@mail.gmail.com>
Subject: Re: [PATCH v2] Improve comment of get_random_bytes function
To:     William Zijl <postmaster@gusted.xyz>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 5:36 PM William Zijl <postmaster@gusted.xyz> wrote:
>
> Hi all,
>
> The old comment of this function had a double whitespace and contained
> grammatical errors, such as: `the randomness by this function`, `at
> least once at any point prior`. Replace those sentences with `the
> randomness returned by this function`, `at any point prior to this`
> respectively.

Thanks. As mentioned, "at any point prior" seems fine to me, so I kept
that as-is, but committed the rest, and rewrote the commit message.

https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=d687772e6d2cbffd91fdda64812f79192c1e7ca0

Jason
