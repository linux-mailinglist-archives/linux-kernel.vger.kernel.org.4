Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD264B432
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiLML1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiLML0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:26:18 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4313EBF;
        Tue, 13 Dec 2022 03:26:07 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y135so17184703yby.12;
        Tue, 13 Dec 2022 03:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yDllMwX9pI964ZhrIw5Xz3fMo331pXeD5e64SDatJdI=;
        b=FC4lPWt9bAiS2U/+gJFOIpDu+nsOuB2f3YHN70FyDyaQvoCcelDReCYvTbrIwk7myw
         RbjrhPVxMi3f+irI2GWnZJbOdMKuGePez7leZfesjYQDE79izSVaIdIC+oeDI+caEh5h
         noQEGZ/LtBv11ATqBohwg2pK96SGU+RHed1b55ik0S4UIsyoPJ8MCRlz7k2M8OcU6el6
         OkwEadrhI1d8QVRDSBDjj/1KlMf3mIOFcOYfe1HY/iO0yjg7oWR5UgBcFMvQ2S3I1L6A
         E6qcjkd7o99M5d+1IwtnfeSUDn+5Yd6kvSwv3cUAtaHc4xNYnn9KKT7fBJKrC63OKKeD
         eu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDllMwX9pI964ZhrIw5Xz3fMo331pXeD5e64SDatJdI=;
        b=7yz/Ihb1gGK89fiZe+7aW3nfkqSFtRa+SdZN+Iur/FeC5bfYOtfTRQQ2JPw60eT/uS
         1v9bdezgBy2YdQUAgheOBgB6jLX89EpaDtk1T9BeJAmKb4AdMVvNXGP2GBDwexb0nxlb
         4t+ZR1cS7CcSQHyofAA8FVUMek3CRDbTKEESeHG2fSVG1ne7Dllwp+SEkXnaOgQ+te9I
         EFO3ZGkvz4Llr85Glx78W/2WIOMnPVas221J2yZEZk4L83HcJwRLy+thFB7OjtxSuwmA
         X2WPQ9rGj9IOolbs1NoLfd5lmgf1onWMlnalkTKEfz5jTIIt7sENbjo8o1LPT9REb8ju
         nLRg==
X-Gm-Message-State: ANoB5pn8N5B2tUKDjKCsZCaaj1q/3uMsQvoGsrsf0Ky0gkU8hHEZAe8H
        tjMZAvciPvxarxO/xQNf+uBRYs3fiGuhv1GOqcw=
X-Google-Smtp-Source: AA0mqf4tQvBLPr8VtV+bOY6Wza7DWHoMNXF8h8+JV/2vysmRny7gFpEVCBb3VsB0sjM8KbCsPGrLDJQOVQlG7FTeiM0=
X-Received: by 2002:a25:ada8:0:b0:6f5:6a39:978d with SMTP id
 z40-20020a25ada8000000b006f56a39978dmr52082891ybi.323.1670930766910; Tue, 13
 Dec 2022 03:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20221211005609.270457-1-ojeda@kernel.org> <CAHk-=wiW=ioE_6N988=fseYLTzaCXaULNzippLMTRTcT=oPa0A@mail.gmail.com>
In-Reply-To: <CAHk-=wiW=ioE_6N988=fseYLTzaCXaULNzippLMTRTcT=oPa0A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 13 Dec 2022 12:25:55 +0100
Message-ID: <CANiq72m8xAHGwEmTULqvfRzXe+dD7bx3_ALVOsU82_H3GDZdiQ@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ojeda@kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 13, 2022 at 2:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Heh. You have an unusual habit of using the back-tick instead of the
> regular single quote character. It's not wrong, just surprising. I
> ended up just replacing it with the regular single quote.

As Nick pointed out, it is indeed Markdown. Rust code uses it e.g. for
function docs, so we use it for commit messages too and so on, which
makes it nice to copy-paste content from one part to the other etc.

When I wrote the tag message, I wondered whether to use the single
quotes, since I knew you keep consistent merge messages, but didn't
know if that included editing quotes. Thus I decided to just give it a
go and see what you edited or not for the next time.

> Maybe I'm biased against it, because I grew up with it being a dead
> key, and while my current keyboard has it very easily accessible, in
> many situations it's actually very inconvenient (ie it ends up being a
> dead key to generate acute grave on many European keyboard layouts).

Yeah, I share that pain in the usual Spanish layout... Until Markdown
started to become popular, I never used that key.

Since it is essentially a "normalized" plain text format (i.e. close
to what one would write anyway), I started using it for my notes at
some point given the growing support in text editors and websites, and
eventually in my emails too.

Cheers,
Miguel
