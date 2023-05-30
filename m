Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7C871547F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjE3E2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE3E16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:27:58 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD722E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:27:56 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-786e09ce8c4so2562378241.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685420876; x=1688012876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqPVTZY234jNlhHdNUZhbVwVkIfQLzs6+jJImbbW0oc=;
        b=NwpcHc2RmO2WPCC0eQjuFi/66TqHOMBF90dFGk8KME5hgDEAShnNndIxvGh1KFsThj
         rEs6XjukaaCpMqHlR0Cqq968Lbqyem9GdWBD0JZd+9XWWiNgkhPOUBddPR/3ckKcM8R1
         m264uUvey9cObyxwIRDt7A3U1Z1drEEtxpCBFDgLvJH6hsPmVA3xDIdRbJY5Rk2m7hRs
         UPLwmfoCBKp9wbS09GSH+Fgr9V5xzK6H88kiA7BpF71fP9ZSH9lvjfjnx0bVb5mdbK0Y
         muhZVWTx7GLPSPdhhnh/AEzd3jPPNQfRHgo56rlOQjzraYQLgoE6fc9xFyO6oFXSnkHU
         Q4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685420876; x=1688012876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqPVTZY234jNlhHdNUZhbVwVkIfQLzs6+jJImbbW0oc=;
        b=V5ZJrO/bkBoX+eO/r3wozcDjj9iuU6CdH7wx8g5o8gSy5HL0LejmtRJ4hJquo+GvTp
         x9tQeN/ZTxa9F1k+I6mC4QsazUltc7gSA/xeyJNmREOZt9n36m+yDw0xoPLXKL+zkckJ
         hy8N7ns7uMB3jBBLwYM82pfcUyNvw+lNOZswCjU6YoxdJQ+QZZm2+ghLNW2JW/tXnqUE
         fkL4QsS30EKk1vWoB4COBimHdJxLuPNSecnuAZ/LeonIzMJth7uCNHTxT7D+zwIwtZxK
         /26emy+1oh0WlS3u12+wRMC7YHi9fLSG7woDpc9KSnGgqoUqc9ZMc4NoWzKLKtmBlJ7z
         92Ng==
X-Gm-Message-State: AC+VfDxPNpy1r+wIj7xiLyyIJQEmJxrnl3Q1D88Uyoxj0B/UtS8/WSOJ
        RKJn9BFfjfl6tqsSUdHtFjkxtvHD/Wmemfux+93kXM1gQvc=
X-Google-Smtp-Source: ACHHUZ4KkkRptZkq/eP35CVOt0nvNyWgVAcP4B+q8u5qhIf5M/N8OpCzfiebzbKqp4aMRyyJhaKjBuaFv8L5sCE/YYg=
X-Received: by 2002:a05:6102:3707:b0:434:5810:32a6 with SMTP id
 s7-20020a056102370700b00434581032a6mr3979292vst.8.1685420875918; Mon, 29 May
 2023 21:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230529143333.19278-1-franziska.naepelt@gmail.com> <873fc37f5fc9ed04698c99feafca156699b2b1ee.camel@gmail.com>
In-Reply-To: <873fc37f5fc9ed04698c99feafca156699b2b1ee.camel@gmail.com>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Tue, 30 May 2023 06:27:44 +0200
Message-ID: <CAAUT3iM9tTJPkvSjxOWSPYyxDp94trnjb2KuiTSzQGGwts5Svw@mail.gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: Fix whitespace issues
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, hsweeten@visionengravers.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Am Mo., 29. Mai 2023 um 17:19 Uhr schrieb Alexander Sverdlin
<alexander.sverdlin@gmail.com>:
>
> Hello Franziska,
>
> On Mon, 2023-05-29 at 16:33 +0200, Franziska Naepelt wrote:
> > This removes the following checkpatch issues:
> > - ERROR: code indent should use tabs where possible
> > - WARNING: please, no spaces at the start of a line
> >
> > Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
>
> thanks for the patch!
> However the file is going away at some point anyway:
> https://lore.kernel.org/lkml/20230424123522.18302-40-nikita.shubin@maquefel.me/

Thanks for the heads up - I'm sorry I missed that.

>
> > ---
> >  arch/arm/mach-ep93xx/timer-ep93xx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
> > index dd4b164d1831..5bfabbdde463 100644
> > --- a/arch/arm/mach-ep93xx/timer-ep93xx.c
> > +++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
> > @@ -82,8 +82,8 @@ static int ep93xx_clkevt_set_next_event(unsigned long next,
> >         /* Set next event */
> >         writel(next, EP93XX_TIMER3_LOAD);
> >         writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
> > -              EP93XX_TIMER3_CONTROL);
> > -        return 0;
> > +                  EP93XX_TIMER3_CONTROL);
> > +       return 0;
> >  }
> >
>
> --
> Alexander Sverdlin.
>

Franziska
