Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525566A54D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjB1IwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjB1Ivs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:51:48 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE71C5A9;
        Tue, 28 Feb 2023 00:51:30 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bh20so7365047oib.9;
        Tue, 28 Feb 2023 00:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/c3V+jLIL8AErPhQhVj3MuD4Xgf1yISMny6OChKMbQ=;
        b=jtOVQpSeChwlzwLOYfl9SKar2uvL7piRUtzTpDvci8ElHvwGrZ+RD/IooeWY7iZSQn
         Yxrr7GUwn9R1a8rH4QKKboNySg6dGb+OFNmOfiXtCWwpbSvdr7W4HLbjiJBKai4vC5/H
         gpUICh2ibcKCNjEyjXTn6gIOae7IdyjcrFS08fwPrqmGIqVDz65md00ItPNp2jkYvg0R
         At0wcUOnjGhV6wAa773muT2u6c3B0MjpLjKkd8bxs4P/M9iClhh/1PVibtmsWLrYxwYp
         N7riE9xzmSuYxsX6kMwxgN/NW/QVCsuyJlvvPOiTF6lSzibRKm9Fj6bl0R6l6AyrdZSM
         ayVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/c3V+jLIL8AErPhQhVj3MuD4Xgf1yISMny6OChKMbQ=;
        b=U2cZxQ+jkHMeWhxfzvkbaLljvMXEDjoekP+Zv2z1QYGM90hfpEq9ryRKZS8/eIOsH8
         uq/ZM2MIdzeJ2FLVs3Yj+tAWUTNUTgw+m3aCnn9ciepFpIvTMgBhvUpLCUP5ZS8inxB2
         i9FmNfzbgP78v2clkNhC4htsKf9LLWN2SLcZRpVwASkrclWcouOV8BvtZvwDug81Z0R8
         igzTvaGV8M9WuJODbA50kigRslXiqN6nUaX3ypKrLgQI9U+o7Qxr+kQSF3jGzpuQy1CB
         Jyc6DCXdJXGPzwZvFX54rrF8cernP0NB2nFjGSZF28o+ArCJwttdOQaNiPfpZymuEVQM
         R8ag==
X-Gm-Message-State: AO0yUKWVSqPkDok0X1PoQ6LbIaUhM2uO9xrsk9j7JoZfWv4oYjFbV18R
        Idz7gAWGInno/J7z7qvWQvZuo514pKR31oPQnoE=
X-Google-Smtp-Source: AK7set8KdptM9hhKShfHrowmBSil5eSInpvF2wkbck4H76uhjo1Icx3hsulNEX8wMhpD0tzQB7tsmLFzqfTPRAmpWTY=
X-Received: by 2002:a54:410d:0:b0:383:bae2:3ac9 with SMTP id
 l13-20020a54410d000000b00383bae23ac9mr628247oic.2.1677574289226; Tue, 28 Feb
 2023 00:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-3-sergio.paracuellos@gmail.com> <20230214151101.GB742354@roeck-us.net>
 <CAMhs-H915iSR7TpuXdcg8NKLV8Scv9cwW36SZaXNK839kA4ybg@mail.gmail.com>
 <CAMhs-H_Ce-+MFi5zTMg8v8dSSg5ioaTy+Pw-0QMgK++PVtEViQ@mail.gmail.com> <20230228083920.GA5801@alpha.franken.de>
In-Reply-To: <20230228083920.GA5801@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 28 Feb 2023 09:51:17 +0100
Message-ID: <CAMhs-H8xGjGs0-qvxb5KgQ3YZw=2=scqaY15K3ZRp50jQcncSg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 9:41 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Tue, Feb 28, 2023 at 05:44:21AM +0100, Sergio Paracuellos wrote:
> > On Tue, Feb 14, 2023 at 4:12 PM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > On Tue, Feb 14, 2023 at 4:11 PM Guenter Roeck <linux@roeck-us.net> wr=
ote:
> > > >
> > > > On Tue, Feb 14, 2023 at 11:39:33AM +0100, Sergio Paracuellos wrote:
> > > > > Watchdog nodes must use 'watchdog' for node name. When a 'make dt=
bs_check'
> > > > > is performed the following warning appears:
> > > > >
> > > > > wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0=
-9a-f])?$'
> > > > >
> > > > > Fix this warning up properly renaming the node into 'watchdog'.
> > > > >
> > > > > Reviewed-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > > > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > >
> > > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > > >
> > > > Note that we can not apply this and the next patch of the series
> > > > through the watchdog tree since it crosses a maintainer boundary.
> > >
> > > I was expecting Thomas to get these two arch/mips patches or get an
> > > Acked-by from him in order for you to apply them.
> >
> > Hi Thomas,
> >
> > I think you have missed this series since you have started to apply
> > newer stuff in mips-next. Are you ok with taking or Acking patches 2
> > and 3 of this series?
>
> yes, I sort of missed it. If it's enough to take patch 2/3 I'll do that.
> If it's better to keep the series, I'm also ok with acking them.
> What's the best way forward ?

Both trees work for me. The rest of the patches of this series should
go through the watchdog tree. Guenter, what is better for you?

Thanks,
    Sergio Paracuellos

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]
