Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F884680765
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjA3I2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjA3I2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:28:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E217168;
        Mon, 30 Jan 2023 00:28:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A90E8B80E96;
        Mon, 30 Jan 2023 08:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6E5C433D2;
        Mon, 30 Jan 2023 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675067325;
        bh=+Qc5ERoxkViTOJP1PhBR9/YiJBKaMpOHNM3Pyw2S5iI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N2wJL628kFRu4tpUBgbZ/5IRgUynsdv92p3MlIvY5f12WCwVgCRV08lS1SQIsIwxg
         smfQ3envQ8RnF7KGZfsLglQQiGzEGkMs8PDk45MvYGb8beLHOPkDpWn7g1lEI8DC1W
         qpO716get8JbmTMvoYBDxXzqN25cvk+aQ+wt85FSK+x72EZDki1eJVAvZP1rl3zJ+S
         c1ppqA37CfJ8nrtMY4t9F713MTc3lgALdq/IIKbnUc0RYLKK206gH84Ghsy9OLYasm
         Z4n+EAptHgYC/nC4sbsSjNjdHvkorhQR1u7M9x/rwAuJE/7dwWZ+pOzXOTpdqkApVX
         tSTP0vXBt3H0Q==
Received: by mail-oi1-f181.google.com with SMTP id p133so9409013oig.8;
        Mon, 30 Jan 2023 00:28:45 -0800 (PST)
X-Gm-Message-State: AFqh2kqOJ2ST7DFHlr4NjRwClwSO2g2mlCAQJ2tyr77wATDOBn56Ar1C
        4hmyx7LnEPMblUukVyP0TaED1JUTOfrK7YSEKz8=
X-Google-Smtp-Source: AMrXdXs0xdVRH/AoG9wL2sm5YeiG71Mvotav2YLon4ToK2kgBH+KmafsjB19Xr1XOqfVX4zlOjGy8zHgDK9H9ZD1xag=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr2970147oib.287.1675067324498; Mon, 30
 Jan 2023 00:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20230130021902.4088173-1-masahiroy@kernel.org> <Y9dMYSCCTo/S6DYz@bergen.fjasle.eu>
In-Reply-To: <Y9dMYSCCTo/S6DYz@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 Jan 2023 17:28:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQZy3N3W2iYBKOv9GQxfzxerPmhat9-RboUTx6p2ho-w@mail.gmail.com>
Message-ID: <CAK7LNAQQZy3N3W2iYBKOv9GQxfzxerPmhat9-RboUTx6p2ho-w@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore *.mbx
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 1:50 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Mon 30 Jan 2023 11:19:02 GMT, Masahiro Yamada wrote:
> > The 'b4' command creates a *.mbx file. Ignore it.
>
> b4 also creates *.cover file.  Can you add that, too?

Sure, will do.

Thanks.


>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> Thanks,
> Nicolas
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  .gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index 22984d22d29e..4dc02ef62202 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -33,6 +33,7 @@
> >  *.lz4
> >  *.lzma
> >  *.lzo
> > +*.mbx
> >  *.mod
> >  *.mod.c
> >  *.o
> > --
> > 2.34.1
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
