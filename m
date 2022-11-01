Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CA61516A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKASTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiKASTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:19:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC19C26D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:19:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 187so18338699ybe.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4TnCmLeSoENzoZRIjU5Wiq8PjPF0LUus2GJeeWfkVJY=;
        b=kvsow79txoZ0AdG1HJRvn4Z/Ru0en7xmqh5/Z9ynWsbL85Bl+EmyaBtNLeJSTJVDyf
         1IFLauuxyk8D4SDyELaQ3yskIcmRG17UCLS8ITHq49UgFNuTecrIilfplhlEoOVfXyMy
         F9vkVjhOGea0W2H2eG1S8jC7fiDH+9pzJrX8VdAD4pzLwMMkRAIZOgQmWqcpDjhBLeil
         cwmFRb+WTQKTcqFApbj8ccRmrS+si3ss0jz6jYMuMgrQaokAzLMSOTBV9f6NqccfE2gc
         q+SilIUpPX7UHn6c0QtEtKp0QaPkXxyGVzqFuukeJH27UClOM/QqvqemJW/+9dtHhRB/
         tY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TnCmLeSoENzoZRIjU5Wiq8PjPF0LUus2GJeeWfkVJY=;
        b=X0pwR6+S3F542teO+5P+5oAXR9jdP1WHUuiX9wu7k6GbKMpXIyEAz4KZZzUI3VLwfF
         vMWV/ItbCe0cD3EynkJR+qKNzl79qGwAYvsNf6Su2IX/tji2A0y+sz8WwfD7iY0oZNHl
         rlaeX95N8gyO9XYpRN2xFCbgxeqg/JKsMYRHpBQ7fdC+wmj1o6div3pb9UoLwqtvM2Qb
         AlsfOHOdt4GyasmA8sPwub/x6jAID/QtibCve0X8Y2VTtHbe2wyiokwQVFTQ0pjQ88V8
         99wsEvKTZ73ts3Ei5jUuOo9nucvBRtSafMipBMKXJFusPyjKv3jI7iEPxUk19GuaEBAd
         DyGA==
X-Gm-Message-State: ACrzQf226Fgr+yUYGBHw3Xw46qvIGxWXAR/bFoTLTjptcntJPdXNA3J8
        TE7towUUGgUchL7uqqaFnZO0oVEmLQMybT++WkqaViX84XO8zYxB
X-Google-Smtp-Source: AMsMyM5swjKbEzL5izsma0aorLlPbQjH/f8MmwmlzJlIFiA7inMcl7zmQRiRlplGQGkSjgqOWLp6u9q6NlX5ToXdWBs=
X-Received: by 2002:a05:6902:1022:b0:6ca:6d5b:94f with SMTP id
 x2-20020a056902102200b006ca6d5b094fmr19352152ybt.328.1667326769909; Tue, 01
 Nov 2022 11:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net> <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
 <29d07648-29a9-432a-a666-f9c9e55c32f6@app.fastmail.com>
In-Reply-To: <29d07648-29a9-432a-a666-f9c9e55c32f6@app.fastmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 1 Nov 2022 19:19:18 +0100
Message-ID: <CANiq72nfpdhPgEgWbz2T7C3GOk94mPbcqfvXTp3Lp=qRvtON9g@mail.gmail.com>
Subject: Re: Linux 6.1-rc3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
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

On Tue, Nov 1, 2022 at 6:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Linker-generated symbols are usually the cause, but those tend to
> be fixed with the extra pass, and Guenter said that doing an extra
> pass does not avoid the issue here.

I have been trying to reproduce the issue on my side, trying to match
Guenter's environment, but so far I have not been successful, even
when running the toolchain binaries he sent me (thanks a lot!).

What I could reproduce easily, though, was one from the kernel test
robot, powerpc as well, in 5.15.y [1] It requires 4 passes (i.e.
KALLSYMS_EXTRA_PASS is not enough), but it is not an oscillating one.

[1] https://lore.kernel.org/lkml/202209241418.35P6OMjS-lkp@intel.com/

> What I've done in the past to debug this was to change
> scripts/link-vmlinux.sh to use a larger number of steps,
> mainly to see if it eventually converges, grows indefinitely
> or oscillates.

Does that mean you saw the oscillating one in the past? Guenter thinks
it is a new issue, since he never saw the oscillating case.

If you did see it, then it may be the case that the kallsyms changes
make some edge case more likely -- at least this is what Boqun and I
originally thought.

Cheers,
Miguel
