Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A587569F48E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBVMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjBVMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:30:00 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F32C24107;
        Wed, 22 Feb 2023 04:29:41 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id cf8so8117709ybb.11;
        Wed, 22 Feb 2023 04:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W+y6jYXWsto0YHDByl1yTKE6KOcfbkoNMI/hyUMcuvE=;
        b=hKd+3ILDn5umqyh3E+tUNyNXuU97ZBYVgCxEd/hL1bp5/i2R3ww9Rl8ETcvWq5EbFQ
         mK2kWKdUQuvJRUWY+yXWw2bLA6wXVt9MFu9phfUyLwMkeS4+yEYc1RmbvGW7ak1NP52Q
         7MBkM1ID9GctLiXC7H2LgyctX5pbCL/TtdOcXRnH28w7eann/7Q4JlAV23qjhSktMwaj
         WXTJoPzyxobebTg+4uz2JmAcTh/mAxuP2rG9bYCDPYeqb7GDMPVDUyCxayt9qre2UEnq
         vQHngphFvWmPJhaltMZcormFomcFpx7qEF5QeKrqWyJezP7L3zD5z5ofbLM6LUsvo36P
         BG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+y6jYXWsto0YHDByl1yTKE6KOcfbkoNMI/hyUMcuvE=;
        b=LhBWDmZmQfR2S8+43fZt2lKjHLVZyt/68j7+ZlHNXn5ZcNSwy0L9eYaSVROgWgE2Ef
         PpyrcOcOmhvSp4R2qtXgyfkbTpxxNfsJ2fRCdf6Wxirweqm+cVRuGd1KOSpjXRVW5JCj
         l884t4JiT/ukQvkiraL7FYqsMorkI+YkmnhLq3TffV4mVL0/TG7frmHhHr0D8WbiV0cF
         5EGHnGbpxE3feYffra5bpHuR1r1zG3EhLtpZ/mTe0SgqOFbIqVEg9ah3e0W8Ptq2qZIL
         CwP40NkgG/qKy00/asOqR5aWZDf/ce1IZ1s/7UAe6jFVDw/VN85+RqN04U+iD6UfB1ta
         MGnA==
X-Gm-Message-State: AO0yUKU2L618ow5nlxP8ikwnpZtntL7NhUYW8Wr49pHiyzNE38oraBf2
        i7mOG9tQekD+TpmwAgjJ6m2kyovCDAu31TBqN1s=
X-Google-Smtp-Source: AK7set/qV8h6RC3N11l2G4jmnq+35W3WK18sceJQ4Nu3CSuN3W9Z9TOL4G5XhbVHDmm4uIHggKG0+UTrgzqh0kzdV84=
X-Received: by 2002:a5b:c82:0:b0:8e3:28a8:bb5c with SMTP id
 i2-20020a5b0c82000000b008e328a8bb5cmr648282ybq.154.1677068980827; Wed, 22 Feb
 2023 04:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux> <87h6vfnh0f.ffs@tglx>
 <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net> <87edqioo1e.ffs@tglx>
 <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com>
 <87o7pmmtre.ffs@tglx> <Y/WDz013yBIfQPDq@boqun-archlinux> <03e9af69-3fea-032d-6dc3-ac0ea8e57471@asahilina.net>
In-Reply-To: <03e9af69-3fea-032d-6dc3-ac0ea8e57471@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 22 Feb 2023 13:29:29 +0100
Message-ID: <CANiq72kyULg=rPzK3QDqCJny3zjrOKzrH=v2PCTY_pUae-ODgw@mail.gmail.com>
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
To:     Asahi Lina <lina@asahilina.net>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
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

On Wed, Feb 22, 2023 at 5:46 AM Asahi Lina <lina@asahilina.net> wrote:
>
> For the actual Instant type, I was thinking it makes sense to just
> internally represent it as a newtype of Duration as well. Then all the
> math becomes trivial based on Duration operations, and when we replace
> Duration with a new u64 type it'll all work out the same. Fundamentally
> that means Instant types are internally stored as the Duration between
> the epoch (e.g. system boot) subject to the way that clock ticks, which
> I think is a reasonable internal representation?

Yeah, I think that is the way to go -- that is also how C++ represents
time points as well (including libstdc++, libc++ and STL from a quick
look), as well as Abseil too.

Cheers,
Miguel
