Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0A68F3D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjBHQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBHQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:56:56 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFFF12F04;
        Wed,  8 Feb 2023 08:56:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x4so22815697ybp.1;
        Wed, 08 Feb 2023 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3RsTC8wA7aA203fEs8YGYE1gcXr2SqCPvGHvV/mk+4=;
        b=VJx0sbg4tnhzxNskHhf93WphpLy7cF2rduHWc3bDL+e7QhEdE4U8OKkQQ4DjkKkrOI
         pWnA6vHTyH79fHmpEyT6zW8Nm8E9L51QAuh2GNFkFv/sf6oPW51ml6ka1NmpfEKn7v1u
         GTqMHGhN7lS55K4lV+/wRHuUbQwYxdOiupyID+qaSG+sqdB1xoJUpkvdUQS3FqJ5w45d
         v4a1wLujwvZcIucQf2bYtKUQ57EONfiGvD3A63GSX7JDeHMxhPqrXRcLcVFzvRIlBFYC
         KWECu+o1+VimTPoyTE/4anpW4LL4i+4DE/8PolJ13w3Q1IDSjpzOoQl/qiQaH0tKRL0j
         T0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3RsTC8wA7aA203fEs8YGYE1gcXr2SqCPvGHvV/mk+4=;
        b=ffV2hXHw7JSEQi0qOwXZp8QAQHEiAdn8excpf4FHDa72bYXF5wr/CNxC0fUpcaEABl
         755oU5XZmNiT/u9933DRA5eSe+mAmNJfHDoYHEyjLvG5LIeZ84K6wFywiYYwrVfpLCw4
         CAL6ovmTcdu/NUcl4ZtZ77GltvUhB/nV2sWp3rKw2AzCXTwivQTW+V0OBMT+JK6zNRYY
         0H3tw+9/5xyVFDijkZzEI6ah85bcomSb4YWnITH+1ZuZaHIvqnCFBrlQjPYI2FxBoMO8
         RbtWTY5U8xTjlRQOZvahDH0Lme+Wf1OxjTEcp6mR2OoCrekwkbeJldOikBhL2SqIwnrB
         DoPA==
X-Gm-Message-State: AO0yUKUGl6C9E27YKUn/O0f5uL90LfrhbCec1yY9Y98wzDw2B8qQlz7E
        /iBUAz6Qke+dBaNpMNPIzJ2QEEn96x5g76f0PPs=
X-Google-Smtp-Source: AK7set/CS0rLEgoI24tNaOxYIsN1DcHS42vruUdQrwhIuvOqGaKW3Qs6KlmxaR2U4A3tMmWwIqQv3hR9MntcXGGy5pk=
X-Received: by 2002:a5b:cc4:0:b0:890:2df2:c31e with SMTP id
 e4-20020a5b0cc4000000b008902df2c31emr864307ybr.489.1675875414574; Wed, 08 Feb
 2023 08:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-3-boqun.feng@gmail.com> <CANiq72kyrz4efU5=MexgGNth1XxkU1z-GP6xVa7WxApB+PMdFQ@mail.gmail.com>
 <Y+PO9SXyQaWgbQlK@boqun-archlinux>
In-Reply-To: <Y+PO9SXyQaWgbQlK@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 8 Feb 2023 17:56:43 +0100
Message-ID: <CANiq72kghG4i35Jt2cY0-2CJkzKe-jEfSyU2pJFFqKgfkV7CZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sample: rust: print: Add sampe code for Arc printing
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        Finn Behrens <fin@nyantec.com>
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

On Wed, Feb 8, 2023 at 5:34 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hmm.. I'm OK with this change, but it's not a typo ;-)

By typo I meant the "sampe", not the other changes -- sorry, I should
have been more clear.

> 1)      capitalize the first letter after subsystem tags in the title
>         since that's kinda the rule for a few subsystems I usually work
>         on, I don't have my own preference, just something I'm used to
>         ;-)

Yeah, I don't mind one way or the other (in fact, personally I prefer
uppercase slightly because it is a bit easier to "scan" visually to
see where it starts after the prefixes). The lowercase one is just the
one we have used so far for Rust (which I picked looking at what Linus
et al. usually do).

> 2)      avoid using "`" in the title to save space because title space
>         is precious.

I see, makes sense, thanks!

Cheers,
Miguel
