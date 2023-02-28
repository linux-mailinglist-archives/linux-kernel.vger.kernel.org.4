Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196B16A5268
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjB1Eoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB1Eoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:44:34 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472ECA3D;
        Mon, 27 Feb 2023 20:44:34 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id m25-20020a05683026d900b006941a2838caso98458otu.7;
        Mon, 27 Feb 2023 20:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfmYJ0b4hWHKRlFdtuun1P3pZqVYLgA8CJ0d1ZnpCJc=;
        b=Nun8IwVYUt4tkernIxKDSObpXVAN4e8cBwu2epATj8pUm0q3TzvSaiUCisyzqXQNMN
         FThh0nzWxEO0jWKbZ3/5JbrNu3KtUDFsBDCD4f8P3s8J/3Fu366+5U8vgbGJ5LDBwsCz
         mHnAJ5VTSq5SAjih2cwMsbM7wKGEpzk9ElDHeXBInQ+HI4CtkLRYXxXZBNe2wGpHZRU7
         TQjVNuBHyCNhVmKbnU9fxc+dbORgAmr9sbKusYZR1GNnKB82DYcpZhlIQ3JcJ0qt/s9Q
         4xoqAz5GB62Z2OBLjgFxiVKWh4Uop0LYcPp/cYXcbFSf/Bffxq9nCO5YbxH9NMKzUt0O
         yfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfmYJ0b4hWHKRlFdtuun1P3pZqVYLgA8CJ0d1ZnpCJc=;
        b=gVmT499byRfgRIPhUlOd2RBJz/oZx9KGvbr/Wk7hExGLUmnrdcnkjbWQwKqjns7tll
         BFFNcYrtUkoCfu4YXvP7SPBZHDkNjxKUuPfBtDTgWwl38xlYrYW8PJLGBz7+a9wzWf5/
         pVL7CoTSjFSYywrmBYlshh5pH1pe0uUnbgCpRA7FvYPbPpXAnACEdz9HVDtY7eK1ArVG
         lw1ZwURbl32GO/c7ZowF57s/FnPiMtTTGA4Au6lpaAt8I+RLsLgmQPFbbiJNNNxI0E08
         Zqm0Kl5CLgELI9XdfRQ2Pocki4fEkal8cL6n49lowugdx8gXYJJF7NmCfAqD8Fvb9gaD
         I8kQ==
X-Gm-Message-State: AO0yUKWufwCnJ0M+5mQ9EmTQ6vP80bEE46ua32rW0rIbmgBnhY/QAPeW
        RlQGxjsI17yyRyGCZfs0/hcqYJ62X+bWXMsbzkR6b/gT
X-Google-Smtp-Source: AK7set9408o7HwNQmk1pEZVmQzCN2Uu1vGVHDLMhtP3EEByROmYUfXm5A+HXZsapO/7zHYtBGMcqoPCtllteVJa25wo=
X-Received: by 2002:a05:6830:244b:b0:68b:e3b2:8ca7 with SMTP id
 x11-20020a056830244b00b0068be3b28ca7mr466491otr.6.1677559473326; Mon, 27 Feb
 2023 20:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-3-sergio.paracuellos@gmail.com> <20230214151101.GB742354@roeck-us.net>
 <CAMhs-H915iSR7TpuXdcg8NKLV8Scv9cwW36SZaXNK839kA4ybg@mail.gmail.com>
In-Reply-To: <CAMhs-H915iSR7TpuXdcg8NKLV8Scv9cwW36SZaXNK839kA4ybg@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 28 Feb 2023 05:44:21 +0100
Message-ID: <CAMhs-H_Ce-+MFi5zTMg8v8dSSg5ioaTy+Pw-0QMgK++PVtEViQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
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

On Tue, Feb 14, 2023 at 4:12 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Tue, Feb 14, 2023 at 4:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Tue, Feb 14, 2023 at 11:39:33AM +0100, Sergio Paracuellos wrote:
> > > Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_c=
heck'
> > > is performed the following warning appears:
> > >
> > > wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-=
f])?$'
> > >
> > > Fix this warning up properly renaming the node into 'watchdog'.
> > >
> > > Reviewed-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Note that we can not apply this and the next patch of the series
> > through the watchdog tree since it crosses a maintainer boundary.
>
> I was expecting Thomas to get these two arch/mips patches or get an
> Acked-by from him in order for you to apply them.

Hi Thomas,

I think you have missed this series since you have started to apply
newer stuff in mips-next. Are you ok with taking or Acking patches 2
and 3 of this series?

Thanks,
    Sergio Paracuellos

>
> Thanks,
>     Sergio Paracuellos
>
> >
> > Guenter
> >
> > > ---
> > >  arch/mips/boot/dts/ralink/mt7621.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/d=
ts/ralink/mt7621.dtsi
> > > index 5ca40fd21662..ac818fd721ae 100644
> > > --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> > > +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> > > @@ -70,7 +70,7 @@ sysc: syscon@0 {
> > >                                            "250m", "270m";
> > >               };
> > >
> > > -             wdt: wdt@100 {
> > > +             wdt: watchdog@100 {
> > >                       compatible =3D "mediatek,mt7621-wdt";
> > >                       reg =3D <0x100 0x100>;
> > >               };
> > > --
> > > 2.25.1
> > >
