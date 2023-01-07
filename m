Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92A8660AF9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjAGAj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjAGAjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:39:09 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41540C35;
        Fri,  6 Jan 2023 16:38:54 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4a2f8ad29d5so43156497b3.8;
        Fri, 06 Jan 2023 16:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3T5+vkdDUBoeLGN/6qIPSZEz0UxeEHwFDr5I00a5ELc=;
        b=aRA37KV9nFjN80IZjR663QXLZuI+r54he1H6y2Mu8NKpT63jSS3MZcU8XAEy7eT587
         87ybQHZqKxtAsgvqw6TQqVxhGvXrfwLuCUfTnbYZFQJeK15eozN01Q2sBvWV5VPxllgS
         BTKsX7j54UA5VF4ehhVlpiOKG/PHIoTcWGnVwIZTZvcSRFh2JeBhzASh9gaAA0Oo7SQh
         tOfAWpnFxiPTHNtqTGvIyN0LZDHBhvMO2dzy9Z9XyiKij8lWcgZgHVnM3T9xYASLUFQ2
         bnBEZEtSnyHgjW8IwlFtV1FX8jzF4slWiBWQgYaFrGWZQwwgf85VRKMbJRyjPWnbtKJV
         ddKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T5+vkdDUBoeLGN/6qIPSZEz0UxeEHwFDr5I00a5ELc=;
        b=46iXFSajqsUMQKuYQ7XkDNr5nG7NGp082wu7QjsR5DVwoAGWoL+ufX00mEmDVEm+jb
         L6uaatxCgik0/7oMMBqyiiLS6KrnVu2pgeR6mAsrIjrm8tSgyeejQJ6TUDdJvCT8qCRl
         vyo8Qxt0cW4FCJKc4LxdhxP32zYAdujG/K/KwDVBAWoiJby566Ll/6CAE7tHKSMmIsHH
         w1jjLwECuchMMhG6hoszffaD/mjMkXVVSPJjMqunmcb+JfA08/FIp4viU3HoSsZjtHY+
         WuTCJOgrmYyobz1Z+BCtVeCSQX/jG/+4Q0Q3tdDjmNb3t5nfihkYBB/QHaIv86znrr3x
         Clnw==
X-Gm-Message-State: AFqh2krE1yDTz+AT7oWpA9MqnvQNOvSfioodpuzhyOI+5x9Vv55VCfpC
        M5nHnx5i/2fI40DP4Iy4a8E/YGaqOCVOKXPARg8=
X-Google-Smtp-Source: AMrXdXsF14XmZpGxMy3fsCklF8Jh5dIPj40AvU6xzV9wFEG4ll4hbwxoKY+yyltn3NzQlGawQIzPwKkR9l+z5TLDUsk=
X-Received: by 2002:a81:de43:0:b0:45c:d900:f30c with SMTP id
 o3-20020a81de43000000b0045cd900f30cmr7999094ywl.256.1673051933795; Fri, 06
 Jan 2023 16:38:53 -0800 (PST)
MIME-Version: 1.0
References: <202212272003.rgQDX8DQ-lkp@intel.com> <Y6r4mXz5NS0+HVXo@zn.tnic>
 <CANiq72kc60aPcx5LwFhOGL4AXOhZsZj32iOg75K5ZxLaaRaYkg@mail.gmail.com> <Y7i1h3lCMKfxB532@zn.tnic>
In-Reply-To: <Y7i1h3lCMKfxB532@zn.tnic>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 01:38:42 +0100
Message-ID: <CANiq72khMLU6tF8vGD9fs7mLNAAQu8wJ2n1SLM3th2QMMfGPPA@mail.gmail.com>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yujie Liu <yujie.liu@intel.com>
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

On Sat, Jan 7, 2023 at 12:58 AM Borislav Petkov <bp@alien8.de> wrote:
>
> I figured as much.

Sorry, I didn't mean otherwise, I should have quoted the next paragraph.

You are of course right that the instructions are not complete, I just
meant to add a bit of context, i.e. that Rust got enabled due to the
config, but as far as I understand, it shouldn't be getting enabled in
the other ones for the moment.

> No need - I ran it by hand just to show that I don't have a rust compiler
> installed.

My point was that the script expects some variables set by `Makefile`,
similar to `$CC` etc., so that output does not imply you have (or not)
a suitable Rust toolchain installed (i.e. it will currently also fail
if you have it installed).

> Bottom line is: if I get a build report involving a rust compiler, there better
> be in the reproduction instructions a hint how to install one so that I can
> reproduce. Alternatively, I can always simply ignore it.

Cc'ing Yujie for the robot instructions. Once I reported something
missing in the instructions (unrelated to Rust) and they were happy to
get the report, so I assume they will want to improve it here too.

Meanwhile (of course it is not the same as proper reproduction
instructions since the LKP team may do something different), the
documentation on how to set it up for a normal developer is at:
https://www.kernel.org/doc/html/latest/rust/quick-start.html, in case
it helps (if you are up for it... :)

> And while we're reporting bugs: the error message from the compiler itself could
> use some "humanization" - I have zero clue what it is trying to tell me.

What would you want to see? We can ask the relevant Rust team to see
if they can improve it.

In general, note that you can ask `rustc` to further explain an error
giving it the code with `--explain`. The compiler suggests this
itself, but sadly the robot cut it out :(

    For more information about this error, try `rustc --explain E0588`

In this case, it gives:

    A type with `packed` representation hint has a field with `align`
    representation hint.

    Erroneous code example:

    ```
    #[repr(align(16))]
    struct Aligned(i32);

    #[repr(packed)] // error!
    struct Packed(Aligned);
    ```

    Just like you cannot have both `align` and `packed` representation
hints on a
    same type, a `packed` type cannot contain another type with the `align`
    representation hint. However, you can do the opposite:

    ```
    #[repr(packed)]
    struct Packed(i32);

    #[repr(align(16))] // ok!
    struct Aligned(Packed);
    ```

You can also see it rendered in
https://doc.rust-lang.org/error_codes/E0588.html, which is also useful
if you don't have the toolchain around. Another option if you don't
remember the URL is going to Compiler Explorer, e.g.
https://godbolt.org/z/Ec17xnGsT.

Yujie: perhaps the robot could avoid dropping that line? Or even
better, you could automatically add a URL like above and/or run the
compiler with `--explain` and add it directly to the output (with a
size limit I guess)? That could probably be very helpful for kernel
developers that receive a Rust report.

Cheers,
Miguel
