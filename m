Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE00D74468C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 06:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGAEis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 00:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAEip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 00:38:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C83C3E;
        Fri, 30 Jun 2023 21:38:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-544c0d768b9so1792689a12.0;
        Fri, 30 Jun 2023 21:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688186324; x=1690778324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNAi6/RMpq3RiWZM7tv0/P67tBwO+iD+twEn3xkK7GE=;
        b=dMzcC8jsy47Ylx+zor+dcIQzqy5IXfjXP4lBPsAvSu7a6aOxNBTD5rNURTMJE8r0k7
         QdUtm5zxcVw3C6wG9XivWlltPaI6coEMFW+UYOgKEKDO2ANd1fzVfwynovZIBBwZfSx0
         OFIUyuEgIYc/yXv9zVjfRuRfU2vKHgyHo+R2WAtxbaM+dlQTqUVLKDWTruvdImZ+zZwE
         auk8NWDYInabEjh9mpQfskX4UDlZba2dRQxv3+okNpO41uAJlkD7pcgjNkVZRrgqHUPs
         GIdahouF6QgkJrRR2fVN5N/RoHPg81dzkPq8fMFgRlltAyiuuURwR0RRzL7CYC0hzfbs
         JMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688186324; x=1690778324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNAi6/RMpq3RiWZM7tv0/P67tBwO+iD+twEn3xkK7GE=;
        b=aGsUQ9CH5tGLAHqJtX5wbrObV0Zmmyzz+saUkM1I7YOZYPKJN3aqUcfssBCfjns/of
         m3FmmuDvbfUR9Rtgp4IehSPOoQJoU8Umzm+etLHqRR1rP8jZkuMrGxT6zQ+2LedqoGhH
         HDh1Uc2CnjRWeq/9SMQCM1qb499zniT6LxN9PeC/k0AjgiSr/Isx7h8j+pkrtg9WL+XB
         GP4vFiuWwzhjwUpiy+UtIBmUvUyI7CqpaDtqaTdaR8CA1DOaueAs8O1VSvTW3NGKb/Fi
         jwv3aasCNJnqgw73JI19s4TDGfs740RAy5N/8f8aXIF1y+oLo8BSS6CZfbU3D9/xWXyl
         MvNA==
X-Gm-Message-State: ABy/qLbnVFCJvmoZuhszMSeYxUExQRoOfPT7CD06YSlyEUQIDYu4vmPw
        jFV8S7IWcQZTyLivmmUIz3QhuwIQ9I7j/PsncWwui5FNCVE=
X-Google-Smtp-Source: APBJJlFxL0Dg99FQpk62DOhXltehvdG7OT88Mi6xmb41/g3Txvhct96oe8BpMcXWpQ/4iPN1KfyRmAJQzaobZ2JwysI=
X-Received: by 2002:a17:90a:305:b0:25b:be3a:e6ae with SMTP id
 5-20020a17090a030500b0025bbe3ae6aemr3880768pje.18.1688186324331; Fri, 30 Jun
 2023 21:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230629160351.2996541-1-masahiroy@kernel.org>
 <20230629160351.2996541-2-masahiroy@kernel.org> <CAJFTR8Txd-6-=5RSoHhgg1a6mr4rEAUv2Ta1F5OLsC3NC4U-Sw@mail.gmail.com>
 <e98fdf36-92bb-2655-41dc-6e31eb128f37@infradead.org>
In-Reply-To: <e98fdf36-92bb-2655-41dc-6e31eb128f37@infradead.org>
From:   Jesse T <mr.bossman075@gmail.com>
Date:   Sat, 1 Jul 2023 00:38:33 -0400
Message-ID: <CAJFTR8QgYykuEq_AkODEWPUYXncKgRBHOncxT=ypZTQODkyarw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kconfig: menuconfig: remove jump_key::index
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Jul 1, 2023 at 12:23=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi Jesse,
>
> On 6/30/23 21:08, Jesse T wrote:
> > On Thu, Jun 29, 2023 at 12:03=E2=80=AFPM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> >>
> >> You do not need to remember the index of each jump key because you can
> >> count it up after a key is pressed.
> >>
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> ---
>
> >
> > One slight off-topic question.
> > The names of the menu-based config programs have names similar to their
> > corresponding file gconfig ('gconf'), xconfig ('qconf'), menuconfig ('m=
conf'),
> > and nconfig ('nconf'). The only exceptions to this one-letter naming ar=
e mconfig
> > is not memuconfig and qconfig isn't xconfig. Would it be possible to
> > add an alias
> > to fix this?
> >
> > Side-side note config isn't in the docs.
>
> I'm not following what you mean here.
> Are you referring to 'make config'?

Typo sorry, `make gconfig`
It's not listed at the top Documentation/kbuild/kconfig.rst and only briefl=
y
mentioned at the bottom.

>
> So: what documentation is missing and where would it be found?
>
> thanks.
> --
> ~Randy
