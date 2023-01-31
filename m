Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D36837D9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAaUrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjAaUrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:47:24 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD05894B;
        Tue, 31 Jan 2023 12:47:10 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-501c3a414acso219737257b3.7;
        Tue, 31 Jan 2023 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9l/9MAVJWA+dZEdm+svYF2/nvT5KD362r+lfb36Gso=;
        b=Nqp3I4uOLLf7OR349FVCL9q4L2KfkyNDWuK6fM1t2wwrShOseWX6lQMElF/JIFEcYg
         btGU3YnisYatiRl5djnQe/+w4WAzm6eqgBe/YHLafZYxO/j5rjoO0Gon5MBe1px1+2ur
         +jr7XkpGL6SKmun/AQCBBf435wWyU9fvBOhQOouCnE04cHc4pMsMsvvkA+5zZdt9bP2A
         Xe2erOJc1DP0oiM9g1h/vAoJyFvEF4/Cd9svNDUb+qH3jOIVYA7m29ypHi6/EBaDuv09
         Z9pl2EiK64KZuDCB5acWGssKxHIxU3/QmaBNydNPgfHfaWEwde9yEEkUOWCGX6vCOM2t
         oR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9l/9MAVJWA+dZEdm+svYF2/nvT5KD362r+lfb36Gso=;
        b=WbaPeMnG+4qqbeJmyyKBPwubyFziWG36Nu3rY7v38uBkljPwng26ypnX/8HjG9kF1m
         ohHTI7O2wr4V8hzfkYNKGbvZKFhR7UBOFEdAkEOXMUqq8Fb0Ka1v4/G33/q0gufFn8yt
         jcNqR15PoYflRkL+fLgko0Q+z1K2NKcYqjeHnQ/SZ4rmS4VpGntpF055XP//8Wx9TpFd
         +K7A4xVQBx8sBXUZWXg7YSshciXKcZHqSUFQ7QbhkXsy8SnMGtkMk6k62vihGu6QUvWD
         GyQx1XfnDbrUKyrjus83OcojfB1GRasQuqT74bJok5xDve61c5qtzCfdOjBegg7MfUkI
         Cr+w==
X-Gm-Message-State: AFqh2kq7RBmnXTJu4vdiaLpNxaT33L+k+Own6lE/SlLxlUR4aH012zag
        MWVxJBoUXASRefGeEfSkA6aErFY/3/Eieho1gd8=
X-Google-Smtp-Source: AMrXdXuWh6hLVtSCj5DoHXrF0MnxwIuKMrvqn4ZOfQAgQjDtKVKxwOGPaABVIDhMdOIX2NkzyawvT/TQUJqjUjufAiE=
X-Received: by 2002:a81:bb54:0:b0:506:c44:ca69 with SMTP id
 a20-20020a81bb54000000b005060c44ca69mr3410557ywl.67.1675198029268; Tue, 31
 Jan 2023 12:47:09 -0800 (PST)
MIME-Version: 1.0
References: <Y9kwpw18SVx9GZC4@kroah.com> <20230131160728.400481-1-yakoyoku@gmail.com>
 <Y9lI5iXD2RrdK43a@kroah.com>
In-Reply-To: <Y9lI5iXD2RrdK43a@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 31 Jan 2023 21:46:58 +0100
Message-ID: <CANiq72=5vcBcOwcX5dadp45G+dvRRwpy1KrEXpEANbOW4gPPew@mail.gmail.com>
Subject: Re: [PATCH] rust: add this_module macro
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
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

On Tue, Jan 31, 2023 at 5:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Right now the rust framework is just that, a framework.  Perhaps we
> should not be adding anything else to it until there is a real user of
> it?  Otherwise this will keep coming up again and again.
>
> Treat this like any other kernel feature/addition, you can't add apis
> until you submit a user for it at the same time.  That's one way we have
> been able to evolve and maintain the kernel source tree for so long.
> Without an api user, we have no way to know how it's being used or if
> it's even being used at all.

Agreed. For this patch, it came independently, so I cannot speak about
its users. For other patch series we have sent, the users are
out-of-tree, but they want to come in-tree as soon as possible. We are
coordinating with them to prioritize the submission of the things they
will depend on.

Since the goal is to submit things piece by piece so that they can be
properly reviewed, what we have been doing to ameliorate things is to
provide enough details, examples and documentation for each function,
type, etc. so that it is hopefully clear how they will be used. If
there are some cases where it may not be clear, we can also link to
the upcoming users.

Cheers,
Miguel
