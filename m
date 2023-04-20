Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0E6E9A70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDTRRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjDTRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:17:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52FE67;
        Thu, 20 Apr 2023 10:17:00 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n193so2645755ybf.12;
        Thu, 20 Apr 2023 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682011019; x=1684603019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR3MrYbDMYps02FpM6CgXLeP0ow7vP9dNqGf0sKZVkU=;
        b=feAhS6Gn5OV5Nz56PvCNsQQbwHKpP2XUJx+Rxk3BWh2G0DJ8XgpcrpkMYqNtu2PlxG
         Ymcju82iy+Ky3oowVt6Dl5q7FfQinxh53sBwmmWDmuaiZ19/HY9hBEySYF/fWeAsVCk1
         EGEwfyfTG/+QXWyaq5pjQsqEZszr4a4D6vces80Bgj02hvwL1RGiLaJpwswAQO2lzym3
         gJOaK96xyucW0NKY5tFxOvX9YoUQJRZGHqdlQo6AyCyFaHeyCDMrx7uIkIdm9ffC9OhA
         nl+P+DestXdIoa40lCbxAwcBW61PIpAu7bnP1blZU9hqih5lTYKIcu3teBJTP8FmgHUo
         cprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011019; x=1684603019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR3MrYbDMYps02FpM6CgXLeP0ow7vP9dNqGf0sKZVkU=;
        b=UL9AAI2lAksCTPTbYyyvqond/72ROj4XYh481DvyweqqcSIpc4tJViGGjywYACLpXW
         f3FMCLwmmc8YFwWTtwNyvyVXUhV8jyojrmLRHTcrsOb0HnbiOct+Y4VLxk90vmWDNj8m
         QHAP7wZd/B6TgnnaiHLXFyv2SbDXV25w936FV8jQJhUKSIIhqH7DICTgoVhh0UD5ImmX
         hPW35Rjh/oU5toShvm8GJmj2pvytuyxPmHl07+uLtPNO9YbR6iQ3cikvYG+lw4kw9AR0
         R6G84iNlXjJ6JnpEXay9/c4KcmufADXfyzB/HPT90Nd53qddybl1gdyV5rCS09fOwFj5
         OCCA==
X-Gm-Message-State: AAQBX9cynSo3gUgiu4R0BIpL+Y21h76myEwDuiJUrPpkVReTI2F9vCkD
        qxR5r9DERP5eNc6Bc1nJUGW0I8jouhktdS6QkuQ=
X-Google-Smtp-Source: AKy350b+9jyLFlcvFZTFwaDafV4O6IuCCJNUZWmUt4dda8BcGy2rSeuJ9k+2jdOPTM1SqvEljb+qQWNrtFbjMzzfWxA=
X-Received: by 2002:a25:183:0:b0:b8f:545f:aa0a with SMTP id
 125-20020a250183000000b00b8f545faa0amr1973346ybb.31.1682011019151; Thu, 20
 Apr 2023 10:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_CB1A298D31FD221496FF657CD7EF406E6605@qq.com>
 <87sfcuu0fm.fsf@meer.lwn.net> <87o7nitvd4.fsf@meer.lwn.net>
In-Reply-To: <87o7nitvd4.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Apr 2023 19:16:48 +0200
Message-ID: <CANiq72k7gVJ1gjN-qbkUM_hh=1QEb8ezKb8FnaD9hnF2kka8Ng@mail.gmail.com>
Subject: Re: [PATCH] Documentation/process/changes: Escape --options to fix
 Sphinx output
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Zipeng Zhang <zhangzipeng0@foxmail.com>, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, masahiroy@kernel.org,
        codeagain@codeagain.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 5:40=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> We have long disabled the "html_use_smartypants" option to prevent Sphinx
> from mangling "--" sequences (among others).  Unfortunately, Sphinx chang=
ed
> that option to "smartquotes" in the 1.6.6 release, and seemingly didn't s=
ee
> fit to warn about the use of the obsolete option, resulting in the
> aforementioned mangling returning.  Disable this behavior again and hope
> that the option name stays stable for a while.

I think it was deprecated in v1.6, and removed in v1.7. There seems to
be code for printing a deprecation warning during v1.6, though.

> +# If true, Docutils "smart quotes will be used to convert quotes and das=
hes

Missing quote in "smart quotes"? Or maybe Saxon genitive?

Other than that, sounds good to me!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
