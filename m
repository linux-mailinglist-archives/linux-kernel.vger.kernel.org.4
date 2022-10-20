Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96C605724
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJTGIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJTGIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:08:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D91B2BBA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:08:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x13so12195525qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/RG1YBqePLHwSbzu3AJsQIoB61hk/GXZV1mOupc8Gyo=;
        b=RtPHpXEsb4v2QI31P+EyeZd3bAC/JgU/h4qX7QnK3qPc6YJTnnNnXnL8ZTTjkmSl3c
         SkpS9NcPggugkrtCiFYiKNzYfFF+7PEht/xidMPrJuE3/AAnBOi+XhUZrvYwrcyeBlUO
         hrtIEu697rFuICn0W5YMtlul/o9mW1Vzcjihd776oWmI3KuEMpkpTL11DJIo0nCtiQiz
         1x6X3/8vAYv5dbl2eSaU/gsU/O47AgXOKWk3u6CIJhQAhhtHgVhXtQ8otJhxFhV/KTAq
         6IKBAHfPzLwE8F1c8jSGg9Kzh2hYa9V6sjcUu72IUARu+DyVlbulmc0zE9+Z7SMjniON
         TB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RG1YBqePLHwSbzu3AJsQIoB61hk/GXZV1mOupc8Gyo=;
        b=mGAN1sl02cy2fg8uFRYrYng9H5VJLdZ8zsbycS8uWVbjb9q8r7HJhsZaucYqubYMdg
         jiEwwdUI6P7WUoxX0gP7zSTV7NPi1DM/6NcZWxhAa2vJkji4HWA94OeCMWmzSQZoXiQD
         7kvmM6ITOnLexWQkXfsLL95gILib0nmxg2fOJD9UqrbSq56t8d/vzyeOkwWhkhT6xJka
         PUFB+vhgJ1S9CsCXT6KwQCcsB3Kmy5kpIXa7C9N1o5a/k04YYCu+eqa4yrvHv0M8/To8
         03TfjJlkFMvU8GkV2TXpyBvZc+yU1/XplI/bnetxrD311byZCUmYVD2+cIOM4OTv7gG3
         NC+w==
X-Gm-Message-State: ACrzQf0FXkK0tFsAe3+Bbv4bTiuWbwftLvB1+lnKhJYgHKXS2gTAy0xv
        ZSERBC13ID9SV3IExXoCWIPapT8tkPrmXstdJWnHNAk0qqSrmaSBlEM=
X-Google-Smtp-Source: AMsMyM5Yi9+CPGGouicLvcag7d3/xnhOdwjxMwQJ5udvnJzALJg/b2pIwTc1hUsyMAxG1cSIlCgRoKNHfaVPnBpR2CU=
X-Received: by 2002:a05:620a:22c3:b0:6ec:53bb:d296 with SMTP id
 o3-20020a05620a22c300b006ec53bbd296mr8095266qki.158.1666246110878; Wed, 19
 Oct 2022 23:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <Y06yiBaluz6X0C4G@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <c3c211c1c99cd19f86fb801576c55b2ae2216c6f.camel@perches.com>
In-Reply-To: <c3c211c1c99cd19f86fb801576c55b2ae2216c6f.camel@perches.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 20 Oct 2022 07:08:18 +0100
Message-ID: <CAHJEyKXnSdgzGVaFX6ayU3DusETOLZRcpKJJ9ZO_76ofbBTacA@mail.gmail.com>
Subject: Re: [PATCH] staging: rts5208: Replace instances of udelay by usleep_range
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
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

On Thu, Oct 20, 2022 at 5:40 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2022-10-18 at 14:04 +0000, Tanjuate Brunostar wrote:
> > Replace the use of udelay by usleep_range as suggested by checkpatch:
> >
> > CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> > +               udelay(30);
> []
> > diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> []
> > @@ -3235,7 +3235,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
> >                       return STATUS_FAIL;
> >               }
> >
> > -             udelay(30);
> > +             usleep_range(30, 30);
>
> >This isn't useful.  Please read the Documentation/timers.

Yes I read the documentation and realized the changes were not necessary
