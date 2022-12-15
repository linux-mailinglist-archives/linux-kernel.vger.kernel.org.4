Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85764D81E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLOI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:58:35 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BDA2DABB;
        Thu, 15 Dec 2022 00:58:34 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id pa22so2354208qkn.9;
        Thu, 15 Dec 2022 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/U5x9gDIB/4HhGGJfOuNSIzuDjkerS4xKeFi7M9ylu0=;
        b=YT10LRYShR+CF/S+V2PLdnOKMpCA1XP88d+VkYPWmW+S0P81sVGPH8rgs4tQPMYcCl
         YEhyJ9kP0bJMRCiAeNA0Vj6B3YgTYcggXd5qh1TCZw9EbTx2ez4STXeREjFi60IJyOAv
         hvPOOo6RF+xVd5KY5RowkNhkBKIgX0RsX5UdUilHtLQDiQkbfjhj/mI12WNHYVS0rdtg
         mUgNm3f4nbGITnE63owk991YhpYdo2z0uV+29DEhFklv4w3+sLAq2Iun9GZ85kI2hs4f
         dec7HkKfzLgQZ3FcX//hZQ36ykpyxRXAvqLDnV4cUIE+u2jmAX23awdX/p3Rl8tAcvo4
         Lc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/U5x9gDIB/4HhGGJfOuNSIzuDjkerS4xKeFi7M9ylu0=;
        b=dd3Jc09MvEnUzSUkHKBnQBe8mUvzygufbW9NkDZM6KRsdpkpKeo5eyAaOiljF18kRG
         bLzit4SS7WfOM/gZF/9eSOpeBJxZ0Xbc5veturCxwn6NmHS2SXi0xkzoYJVWjfdW5MW7
         0tfVJiqTQ2iWlceNblKFQ5hfRraE9dSMZSN9eUmEoQkZQ2ixUyIKyiCylZbyyuUVJX4s
         xd8131ZU9NAqaZog1LAlgigBbz0zsrBm3c4hgqp9fg9oLM8h6mxH725JKKjzA31RjfJn
         jiJLOWIzQnYUBmqrMtEaYUupyLKwe71MC8tY2M70jTU0XWTgPPmRcu/gDBz42h+uaLq3
         nKkg==
X-Gm-Message-State: ANoB5pnU1od3Qox4AWBmmydI9oi8KVUA+VReQHaz+/RmbloMnN5AzlcN
        hkB+Ghtenm3jKOz+mAkIiUYSYixShHcaQGjOmJE=
X-Google-Smtp-Source: AA0mqf7XfM9p3HJSyShtl+YS6ddXslSbaGRLL33UnHdjcKIoqsLsotA4YkR9uCLn2islrYuWNdsQXAwf9dOXxLt8FC4=
X-Received: by 2002:a37:a9d2:0:b0:6ff:c2e:c71c with SMTP id
 s201-20020a37a9d2000000b006ff0c2ec71cmr1837351qke.734.1671094713484; Thu, 15
 Dec 2022 00:58:33 -0800 (PST)
MIME-Version: 1.0
References: <Y5mMWEtHWKOiPVU+@mail.google.com> <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com> <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
 <202212141347.9AD66DEBC8@keescook> <CAHp75VdqUMs1uz8zeyDi6rJKayFt6UMrm0A=-Hp8tQpCUSGujQ@mail.gmail.com>
 <Y5qim07QaqyvAtRX@mail.google.com>
In-Reply-To: <Y5qim07QaqyvAtRX@mail.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Dec 2022 10:57:57 +0200
Message-ID: <CAHp75VcSnRPfmk9gAgz+hb7VYtL5buzDi_1e53u8b8+PrtxAvQ@mail.gmail.com>
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Thu, Dec 15, 2022 at 6:29 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
> On Thu, Dec 15, 2022 at 12:06:46AM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 14, 2022 at 11:49 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, Dec 14, 2022 at 10:39:52PM +0200, Andy Shevchenko wrote:

...

> > > > Yes, and Try to make it work with __packed. As I said, the problem is
> > > > that the code is relying on something which is architecture dependent
> > > > strictly speaking. And hence I disagree with Kees that v2 is okay to
> > > > go.
> > >
> > > I meant that v2 is functionally identical to the existing code.
> >
> > Ah, sorry for misunderstanding.
>
> I agree with using __packed attribute to remove the extra padding (and
> for the reasons you mentioned before). That would reduce the sizeof(RXBUF)
> from 8 to 5 (which is good) but that is still 1 byte "too much".

What I meant with the above is that the code has to work properly with
or without __packed. It's just to show you that this code has flaws if
it relies on the padding.

-- 
With Best Regards,
Andy Shevchenko
