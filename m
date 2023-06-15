Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BCC731FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbjFOSJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbjFOSJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:09:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DB2978;
        Thu, 15 Jun 2023 11:08:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6040223f8f.0;
        Thu, 15 Jun 2023 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686852538; x=1689444538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3eNHuBwA4/Xh/5OxuPE103hqMngMlGAmXZaUXgFWmU=;
        b=D471ChgwfJ68SiQheJFmqdRP4BL4u0/AlkXDuax25+AZY6PpFAaRAIWHaJjrwEfrB3
         2hCnUHfGnI2p7hxvztIbONYI/fIoWU8Yu1FZsipMF5nHCkH7Kn89cAHfiFLtJdJQ0AlE
         6Xsoi53Vwlp6AyPQVa6lzRMl6wltWtT001eTCmDIpBLAwFQvJ1A9hFkH5A8l5AGUDF8t
         YFUKz9fkDssqgklQoC87ngdNu6tS710/6QZIJQE5VuI1DAqU7T/utVtNvFVd+IwqoHJ7
         D9n7DjwzX217NPHOyegakfFrh7VGaaCkdJz7YPDQzkB7cP8iPUDf+xPXtD3vVBG8Ogr3
         NBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852538; x=1689444538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3eNHuBwA4/Xh/5OxuPE103hqMngMlGAmXZaUXgFWmU=;
        b=GSZI/J6CCoQt8OxoTMNtwGdQwuGJQ91/UdDLqw7ZaFUq01DatXX9do2ClEOd4YmqPj
         Z+uC3sBqNt0e+Ksjb5ahoYWY74TpXO680AOkFvlMJD/IEhH4veIZ9jI9Aodty83PzSyq
         XLdMEDDYobNjYhL5iOKipuW4Oi/RPuV387mO1Z812HVFrx1MR0WYMBDl7DLpV0blQ6sh
         fpI8f90UWsELHvTCvNbJmOEfQaB3JtjSUWVdtr6YEzIoWQhPfKOHhj6aFTNVuQBOKO0x
         KsSHJaZM07Sqgf0hRF+2HwcRw7lZgCB+0jSjchELqOYx2gdZro5mS00nFCya8se8m2uu
         RHdw==
X-Gm-Message-State: AC+VfDyuf+XwW18xn41uGz1AlvtWL1bEfGu1KnYusQrBJyCCQooPRQef
        Ui44smn8NSmh0Ka7E7EUHRPoEjwVBvhcpEJUD7Q=
X-Google-Smtp-Source: ACHHUZ7N5KmIyc/eNAUi8a4eUiuM2tRF9hBjkAYMCMidtVpcyL1HJSRK4q7vY72yTHMitNHQhDFj052a9fSViMgTBYw=
X-Received: by 2002:adf:f1d0:0:b0:30e:3ccf:d4b1 with SMTP id
 z16-20020adff1d0000000b0030e3ccfd4b1mr11349449wro.4.1686852537627; Thu, 15
 Jun 2023 11:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230613004125.3539934-1-azeemshaikh38@gmail.com>
 <202306131227.26F90584F7@keescook> <CADmuW3WeRG-_WsFVCogRzRNXoqtVr+gA84ryqDZ2URUu3wh6Tg@mail.gmail.com>
 <20230614171330.GA1146@sol.localdomain>
In-Reply-To: <20230614171330.GA1146@sol.localdomain>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 15 Jun 2023 14:08:46 -0400
Message-ID: <CADmuW3UyFY8cnf=S9hVMsYrqOyYAn5hCQ258uVpaz9J-6qaw6g@mail.gmail.com>
Subject: Re: [PATCH] tracing/boot: Replace strlcpy with strscpy
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 1:13=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Wed, Jun 14, 2023 at 10:01:57AM -0400, Azeem Shaikh wrote:
> > On Tue, Jun 13, 2023 at 3:27=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > >
> > > On Tue, Jun 13, 2023 at 12:41:25AM +0000, Azeem Shaikh wrote:
> > > > strlcpy() reads the entire source buffer first.
> > > > This read may exceed the destination size limit.
> > > > This is both inefficient and can lead to linear read
> > > > overflows if a source string is not NUL-terminated [1].
> > > > In an effort to remove strlcpy() completely [2], replace
> > > > strlcpy() here with strscpy().
> > > >
> > > > Direct replacement is safe here since return value of -E2BIG
> > > > is used to check for truncation instead of sizeof(dest).
> > >
> > > This looks technically correct, but I wonder if "< 0" is a better tes=
t?
> >
> > Agreed. "< 0" might more generically represent -errno. Happy to send
> > over a v2 if you prefer that instead of sticking with this patch.
>
> Please go with "< 0", since it's easier to read and less error-prone.  (I=
t would
> be easy to mistype -E2BIG as -EFBIG, or E2BIG, for example...)
>

Thanks, sent out a v2 with this change.
