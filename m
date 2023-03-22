Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0C6C44D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCVIXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCVIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:23:41 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70212046
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:23:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p204so8941962ybc.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679473419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhB69lc2RWiQiZSxOvh148UYp1CQHuODILDXxnDzxz0=;
        b=QLwRHf5LpUSIO2BBFEW51iQz6jq8BJ4rcixOJxwVndvItMN3gc5W/PSKVpL7BvC3Tt
         QuQKIluahU5X3t/ex7rXw39tXEf+XAOqPf4PmJSp44wZk3AThCItPObde3aDQTm6UncA
         yLxXJeFyTU16dXNniLIgTlPbXPRzUy2rJIslr2NpVIjv4EgIikWELdMyuO6FlTSd6AAy
         LM2eK0yjviEg6vGf592FzS+dayMZ9ZhSL7UDHzn5/b1Ch/H6XBIIgnSbQ5sDRqF/sALi
         acMbYSjInUiV1etNk1V8gLnAfC/nBTJ27HYB2rfm1G5lFD05rzgguEF332nhYrbFKH35
         3+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhB69lc2RWiQiZSxOvh148UYp1CQHuODILDXxnDzxz0=;
        b=NDETTvSv7pBULuADxphIDMqDyVepdGjAq2/gryTOYiiNAqguD8BrnWvISNEL7qeLwf
         EdxevO5XaUGi6lYz9R63ERz2OfAWHeUg7RmW1cdDaNDREL1lvBjEQcBA549h6pXmu65Q
         lQZlWLV7KoFzRHBZ5JO2Omi1s7i+79IiC7f0oNBopah68LX34O8f08cTpshSduK6Hik5
         XwBuA7PQQKwEE4Q5as6JvQQxW6+Nn+DxqEkSPWlKRqYXu2N7mm+YxJLHwKQJtdogiLAT
         G2a0ey+mQiClnYh1yl1xzk31DiS1Z0KPM5DR5IWNpMRNmzAPaA7XbKwJf7U2cft7/eVh
         CFmQ==
X-Gm-Message-State: AAQBX9d0Q4oi3ItXCNyXlBECwN05m25euMYQy1MjAoVLdx/UpK2XuwG7
        Fil/A7HL9MbQ0d0x38kb8kc6T0R65ta+tDGn1E8=
X-Google-Smtp-Source: AKy350ZYJ5Fev7z4JnEd0Cxr/fOPeXbh4d4PeQwJtfNWTaep23e0cWhXUoWFUFVy7y6ZzLExSerS4gaXUTzwuUhqwhI=
X-Received: by 2002:a05:6902:708:b0:b6c:2224:8a77 with SMTP id
 k8-20020a056902070800b00b6c22248a77mr3553837ybt.1.1679473419636; Wed, 22 Mar
 2023 01:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <83c9306a-dbfe-819a-16d8-6242437b2810@roeck-us.net>
In-Reply-To: <83c9306a-dbfe-819a-16d8-6242437b2810@roeck-us.net>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Wed, 22 Mar 2023 09:23:28 +0100
Message-ID: <CABDcavbOXRSh_cjV54CqmwgeJGeDP-rUkerZL5Lj73ax67Q9LQ@mail.gmail.com>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 16 mar 2023 a las 14:40, Guenter Roeck (<linux@roeck-us.net>) escri=
bi=C3=B3:
>
> On 3/16/23 03:29, Guillermo Rodriguez Garcia wrote:
> > Hi all,
> >
> > We have several embedded systems where pass console=3D or console=3Dnul=
l
> > in production to disable the console.
> >
> > Later we check for this in user space: in our inittab we check if fd0
> > is "associated with a terminal" (test -t 0); if so, we are in
> > development mode and we open a debug shell; otherwise (console
> > disabled) we just start the application.
> >
> > Recently [1] this behaviour has changed and now if we pass console=3D o=
r
> > console=3Dnull, the new ttynull driver is used. This breaks the check w=
e
> > were doing (test -t 0 always true now).
> >
> > Is there a way to get the previous behaviour? If not, is there an easy
> > way for userspace to detect whether the console device is a "real" tty
> > or ttynull (other than trying to parse the kernel boot args, which
> > would be a bit fragile).
> >
> > Thank you,
> >
> > (If possible, please CC me in any replies)
> >
> >   [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
> >
>
> Let me know if/when you find a solution. In ChromeOS we have to carry
> reverts of commit 48021f981308 ("printk: handle blank console arguments
> passed in.") and commit 3cffa06aeef7 ("printk/console: Allow to disable
> console output by using console=3D"" or console=3Dnull") to handle the
> same problem (the above mentioned commit didn't work and had odd side
> effects).

The kernel seems to specifically check for "" (empty string) or "null"
and in this case uses the ttynull driver. But apparently we can use
any other invalid string (e.g "invalid") to get the previous behaviour
(no console).

I am still checking if this has other side effects.

Best regards,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
