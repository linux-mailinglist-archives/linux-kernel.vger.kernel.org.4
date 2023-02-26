Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB496A2D14
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBZCIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZCI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:08:29 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00AF77C;
        Sat, 25 Feb 2023 18:08:28 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i12so2116609ila.5;
        Sat, 25 Feb 2023 18:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qT0gdPeLmhMzH6//xbPyFh4VuSW1FnICCx+6PynbN+w=;
        b=gcaQjyjZIcwBaVHU8T1XmPHxNftLyJYZhGbEM8kxRip5sEja4CO6uvKl5tjEbSTlQ4
         JCAYq8hhHO/91Z81F2oXQhMmGjUshgEVKtEPakOVov6CKwh4Y32KbnUNlkmwH3uhW0iw
         x0jkwLS0yBJ+4Yaz2ZWddaU8h01jvKQnKc9MLG99yhm2tpML0L0Y0Ibme7GfLZpogVJL
         gK0tNnbqNtpokinly5pVaW0u8OXHrpGUHkuOaxmgvGS2YwO/Md4lhCN52f4fWJPa87LZ
         VemgTACIuGhDDhaRMcBPsQAQa40OW2PGfODyhSvITyJ79c03JbKG0F/nQdV3IENNshuJ
         QMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qT0gdPeLmhMzH6//xbPyFh4VuSW1FnICCx+6PynbN+w=;
        b=PB33kOqbx003dU+R8UcmpCdA9r2zQrwEB0WvtDjn90xX3wcRteRax1WD6SeEyGfcCa
         z/knp8ypVDL9uan0jtGNw4j+5B7fANdOyJnX94q37Hkloa73hWkVDCE3Z5SWfF3DYGXq
         oqoIKghh5hQf6KO7dgVihAP9ljDPCmORcuIC1CD2YmXUhCPDk+YbhhatdQshj5F0rF/A
         LrspalG8Jr1XXPq4cvs3pC9OT7A589RkkMBU8fAKcDICk/osBWjwv5soeTUGK0td4Dx5
         Yan3op28r2vwMxPeSD7V0p2i45ZWHq3JCsBiqoR1Elb/1tfE5z65jSvCZRkDfcrdhVVq
         9N+g==
X-Gm-Message-State: AO0yUKXkui+p30t2Ya+Jcug817N/g9hWaMfzntNpxLbw62j21EYaEb4t
        +0KW7AUTipwYNg7kaZLuB5fNR5DHUN9J6AF50PA=
X-Google-Smtp-Source: AK7set/6CtYuIAqkSxf/S21QPq9hni6AedC61H/2KO+wroKQnqY0P4dveyxkgXT6EYzMLOgcTnL0A7CyUb05rehbmho=
X-Received: by 2002:a05:6e02:10cf:b0:315:8de2:2163 with SMTP id
 s15-20020a056e0210cf00b003158de22163mr6301132ilj.5.1677377307457; Sat, 25 Feb
 2023 18:08:27 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk>
 <CAEdQ38EpBMnkP-PNZnwaoO4poFJQO5YSFJeZgiQ-obJmjogBFQ@mail.gmail.com> <alpine.DEB.2.21.2204150100380.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204150100380.9383@angie.orcam.me.uk>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:08:16 -0500
Message-ID: <CAEdQ38GOQxCA53WWzh8FBbsAKe42sARv5n24cWvvi60Q272jwg@mail.gmail.com>
Subject: Re: [PATCH] Alpha: Remove redundant local asm header redirections
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 8:26 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Thu, 14 Apr 2022, Matt Turner wrote:
>
> > Sorry for the delay. I'll apply this. I just haven't had much time for
> > alphas lately.
>
>  No worries, and thanks for chiming in.  I plan to get one of my Alphas
> set up and wired in my remote lab later this year, so I hope to get a bit
> more active with the port.  At least I've got a reasonably recent build of
> the toolchain:
>
> $ alpha-linux-gnu-gcc --version
> alpha-linux-gnu-gcc (GCC) 12.0.1 20220129 (experimental)
> [...]

Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
