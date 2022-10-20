Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9914605C46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJTK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:29:20 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBA3CBCD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:29:17 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so13213719qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CpepSprjis+5ae/JU6KqavxGncI1IXR7MSlJhihZlRE=;
        b=RnZSspVJPsuLAA1GS5so0ZEPuWaNegeCiOiYlAnru7F5HLyfB2KyuyNxSgrzHw0Vy2
         IapRkkt/DeZ5v7sS8kUpQMYruFQ9HWksNS+r5sSwouZ362WSFqMt4TQX2Ahi1JFVHmMF
         OS5oiuxgt/y3cha57/q6i4myHFcNMCvRVZAsvHtpBBmjogw0mnM5sGmdLK1Zau11xEsS
         /YagS8jckr6BX/8OqUuJHdtvCEVrNdaNyJ1AAKEwJtUo9ObvQuqqBnPoGvMg86q3aflD
         vVeGXjRvjKLvVEMJm4ur3TXIaLjlWNr67kiE9FUBzMQhRllcvUG0EH40M0E+4nrkecTN
         L+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpepSprjis+5ae/JU6KqavxGncI1IXR7MSlJhihZlRE=;
        b=4A8bn47TFdTwKu0i2bQFr4/fkIBAKEmUKUzWKTD2nZoVNnmlism4oyDnrBxz27ukoK
         dYfUI2ENFNfpbOZrwxBtcuoDLUkUmHpv5uOCOeFmYyk9V6vBok9nAYV5Q1pp0/PGFHEj
         tiYUp1SR/VJkPCPwJpMhdTnJn8uDM2vbBVdbOmTGxeSc2tr5r7tV0N23RhutPUQUyImF
         cwjpilUyPFQBf3kEeMePeDo3yTm18VaCl8Ph5LF7/SynKfrljCz5yGkLFNXG/2hVidpA
         TMf3vJwvzYHB/Fg0vpmnQ7TZz8bJLYuMOohf5JQQ1T4pA8QCnnO1GZ8rCZu1o/QTx9vm
         1T9Q==
X-Gm-Message-State: ACrzQf0UbPO7MVHMya+liL3jf6gmT5vN0Xug+u7+Hserr07vBHhDd7Wa
        k4rpMAjZTvxgJYclmoxHVefr0q6ePtUWA3FZvTY=
X-Google-Smtp-Source: AMsMyM7dgYuoQ/uU+La4aRoUZd/n793rZ33XplndYzQTS3OeP5YTOA8AUONCL3HT/MmsOQmAkEcno50JlzK7WUlqT+A=
X-Received: by 2002:a05:6214:d69:b0:4b4:525e:c987 with SMTP id
 9-20020a0562140d6900b004b4525ec987mr10522749qvs.82.1666261756458; Thu, 20 Oct
 2022 03:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <Y1BN6wPMrpxPB3qP@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <20221019223446.GA154747@nam-dell> <CAHJEyKUsZ-V0waEwBEy67g+MNMR29MGJbBx3qCA4axKyPk9RGQ@mail.gmail.com>
 <814aa14-25b-d579-e2d4-5c61ddb749b1@inria.fr>
In-Reply-To: <814aa14-25b-d579-e2d4-5c61ddb749b1@inria.fr>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 20 Oct 2022 11:29:04 +0100
Message-ID: <CAHJEyKVd=d-Lr6RRgMM2MYDHSVzrck4pXH6yys0=7pjarHH9dw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: vt6655: Fix Lines should not end with a '('
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Nam Cao <namcaov@gmail.com>, greg@kroah.com,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:18 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 20 Oct 2022, Tanju Brunostar wrote:
>
> > On Wed, Oct 19, 2022 at 11:35 PM Nam Cao <namcaov@gmail.com> wrote:
> > >
> > > On Wed, Oct 19, 2022 at 07:20:11PM +0000, Tanjuate Brunostar wrote:
> > > > Code style warnings reported by checkpatch.
> > > > Improve the layout of a function header:
> > > > Put the first parameter immediately after the '(' and align the other
> > > > parameters underneath it.
> > > >
> > > > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > > >
> > > > ---
> > > > v2: put static and void on the same line and adjusted the indentation as
> > > > suggested by Greg KH
> > >
> > > I think he meant putting "static" and "void" and also function name on
> > > the same line.
> > >
> > Oh I will do this now. thanks
> >
> > > Additionally, I think your patch introduces new checkpatch problems. Did
> > > you run checkpatch.pl on your patch?
> > >
> > > Best regards,
> > > Nam
> > >
> > Yes I did. the checkpatch says this:
> > Alignment should match open parenthesis
> > #89: FILE: drivers/staging/vt6655/rxtx.c:89:
> > +static void s_vFillRTSHead(struct vnt_private *pDevice,
> > +               unsigned char byPktType,
> >
> > The only way to resolve this would be to add white space which would
> > generate another checkpatch problem. how do i fix this please?
>
> You mean that the ( is not at a point that is a precise multiple of the
> tab size?  You can put as many tabs as possible and then use spaces
> afterwards.
>
> julia
It works. Thank you
