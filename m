Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120BE650F70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiLSP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiLSP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:56:24 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74EB88
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:56:23 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id h26so9121606vsr.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp/jDDrui9+5VJNtK3d7ggJcR4YcH0qlGdYeLuREwOY=;
        b=cExqj1N6ke9SAEWp6hyoMjK/wbi9P1LF2RVF2RAcfw6SqFFoZ3Q9c/pUsaZe1XlkDh
         63ANSopPN9UE4om7K8GyHeo9Z+JkWeXV1M0pG7juwsEkepuFajxMvackRcAyVuWeeSgf
         IbRmVxs1sN/WPbhovtHJmsP3IFpQfIgXmRePR30DgseCqk0hkciifzAp+G15c+GYEcWR
         a9MI8FnwNb7wQ12f6SZHflIpkDZwYbuGh5/D72hcnu7QK5j+56N2uPM20W2QzFYrAwy2
         iPJTGrWQ6b6TJzyNw3zn6wSUlCdv3YuWwIcjDEkVV4IXhOYSq5IVM8S97Qb9IuheJeV/
         dFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp/jDDrui9+5VJNtK3d7ggJcR4YcH0qlGdYeLuREwOY=;
        b=FWNO3ptPApf8aM36pbPc/1Be+Wnilafef4uuA2tmujLq2FHu6fgzImOSxNKjp1yksf
         QeQN+kUSZ0odCbO9jILzVvd+iBwdLGTTVc0u9ECn9SJAoGW1UWqOnuqF0Vtfpfo4jGsK
         jdY7id1eY2fp3HnNe8ZAuAB4spRRir0n25ANHsBFgp+/mY46Go0B2DKa7iQmWbOzn6TP
         PcE5Y7jDZPyEgRffbhLYKT/WgcTuT5TdsoYavbJqHPtCgKXiRQhv7Jmf74+riAOcpgy9
         DWxlyZuc/fDlc6dgay2l1l2TooPW1duljj5BQQ1C/ZvsEAZ4uFrpAx1VxVrho8/6nrUC
         EaIw==
X-Gm-Message-State: ANoB5pl+8rX6lPBLa6OHYTdJDLOYYurl0pfELcCSO9oz8Nx/fy2b6NgW
        QnnWZn/icxYt2wMXkTLiapejhhxCD0gHKk0sC2GxYw==
X-Google-Smtp-Source: AA0mqf7kDeOJmjEY7eLa8lKHcdZzwrkGFwHP28WkElG0ZxYbBHQA2QvybQCOSf7aWFoZROXqDSlsIzn/6MvqP0Nhf5A=
X-Received: by 2002:a67:bd14:0:b0:3b2:e40d:1d9b with SMTP id
 y20-20020a67bd14000000b003b2e40d1d9bmr11897913vsq.51.1671465382222; Mon, 19
 Dec 2022 07:56:22 -0800 (PST)
MIME-Version: 1.0
References: <Y5IA2NYE5IaAzNby@kroah.com> <20221216221703.294683-1-allenwebb@google.com>
 <20221216221703.294683-2-allenwebb@google.com> <7394f5cc-35be-0bc8-f92d-bb9e71d3f85c@csgroup.eu>
In-Reply-To: <7394f5cc-35be-0bc8-f92d-bb9e71d3f85c@csgroup.eu>
From:   Allen Webb <allenwebb@google.com>
Date:   Mon, 19 Dec 2022 09:56:11 -0600
Message-ID: <CAJzde07sLeqALQ-rwtdSkx0n3eqOj94TJ0w-BhCwGRJjLDGj0g@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] module.h: MODULE_DEVICE_TABLE for built-in modules
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 4:05 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 16/12/2022 =C3=A0 23:16, Allen Webb a =C3=A9crit :
> > Implement MODULE_DEVICE_TABLE for build-in modules to make it possible
> > to generate a builtin.alias file to complement modules.alias.
> >
> > Signed-off-by: Allen Webb <allenwebb@google.com>
> > ---
> >   include/linux/module.h | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index ec61fb53979a9..49e4019393127 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -243,7 +243,15 @@ extern void cleanup_module(void);
> >   extern typeof(name) __mod_##type##__##name##_device_table           \
> >     __attribute__ ((unused, alias(__stringify(name))))
> >   #else  /* !MODULE */
> > -#define MODULE_DEVICE_TABLE(type, name)
> > +/* The names may not be unique for built-in modules, so include the mo=
dule name
> > + * to guarantee uniqueness.
> > + */
>
> This is network only comment style.

I have fixed this in my local copy and will include it with the next upload=
.

>
> Other parts of kenel have different style, see
> https://docs.kernel.org/process/coding-style.html#commenting
>
> > +#define MODULE_DEVICE_TABLE(type, name)                               =
       \
> > +extern void *CONCATENATE(                                            \
>
> 'extern' keyword is pointless of function prototypes and deprecated.
> Don't add new occurences.


This is a weird case because these symbols are used for post
compilation processing by modpost. If I drop the extern keyword, the
build fails with a bunch of errors of the form:

/mnt/host/source/src/third_party/kernel/upstream/drivers/hid/hid-generic.c:=
79:1:
error: definition
'__mod_hid__hid_table__kmod_hid_generic_device_table' cannot also be
an alias
MODULE_DEVICE_TABLE(hid, hid_table);
^
/mnt/host/source/src/third_party/kernel/upstream/include/linux/module.h:255=
:26:
note: expanded from macro 'MODULE_DEVICE_TABLE'
        __attribute__ ((unused, alias(__stringify(name))))

>
>
> > +     CONCATENATE(__mod_##type##__##name##__,                         \
> > +             __KBUILD_MODNAME),                                      \
> > +     _device_table)                                                  \
> > +     __attribute__ ((unused, alias(__stringify(name))))
> >   #endif
> >
> >   /* Version of form [<epoch>:]<version>[-<extra-version>].
