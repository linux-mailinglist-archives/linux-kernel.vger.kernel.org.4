Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E61723DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjFFJfe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbjFFJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:34:51 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1A6170C;
        Tue,  6 Jun 2023 02:34:46 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bacf685150cso7397792276.3;
        Tue, 06 Jun 2023 02:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044085; x=1688636085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JdV/d7SCfU8eJkEBOkqIv7Lgaup3KtW7wGYKu2r4OA=;
        b=RUB24bPTAgWlxng+NFeR/LlPcM+Vug+3cq69g/n0n2s8AqAKpX0kSQYtd/r/mPQuyf
         6/rUV/czaxeqsHoYbiT0zClELX5poGv39EJMcGcLs0YbFO7qBGxkZflKKsFRI1HXEUcb
         0SnDygzaFmPNO+ocQxB4ti2vheki9ndXWzqrUhnzsmvEZippGFZI38kzY5OZ+3sqWFt4
         M9qvzmQ4Ufga2mIZTodqw9SnzviZ4/yF208cCW6OrGyjTCb+kxeerZr4psJf7OOZM7Tg
         VWzT0hktMKOfIg3oIEcexxkB2KIQRDDB+c1hebC+zr2WQkBkGeGvXSc7mtUnj5Jg4Rwj
         aJRA==
X-Gm-Message-State: AC+VfDyJ9H1C/SFgKurYI1kxjBdoZh+4j8R5DfHYaIGem1ZC9MmEhnqd
        5HtGTrsfjMIpDhCb9nw6KIYV7VpByjZPDg==
X-Google-Smtp-Source: ACHHUZ5pV7njFg2DpQ9Z4mjkvWo1dKr6k5fM/rdIXE3aC+73B3OZ/2gp4DWeMnitXKFk9K01LCf/yg==
X-Received: by 2002:a25:fc3:0:b0:bac:7aba:ae4d with SMTP id 186-20020a250fc3000000b00bac7abaae4dmr1243954ybp.28.1686044085056;
        Tue, 06 Jun 2023 02:34:45 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id v12-20020a25fc0c000000b00bb0ae4221b8sm3134146ybd.43.2023.06.06.02.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:34:44 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-565eb83efe4so74827467b3.0;
        Tue, 06 Jun 2023 02:34:43 -0700 (PDT)
X-Received: by 2002:a81:61d6:0:b0:561:3fb7:1333 with SMTP id
 v205-20020a8161d6000000b005613fb71333mr1868251ywb.43.1686044083648; Tue, 06
 Jun 2023 02:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230522105257.562cb1ec@canb.auug.org.au> <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
 <20230523103637.20175fbc@canb.auug.org.au> <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
 <CAMuHMdU5pBh8bk21Xrzk0Ocs7cAF+QTLn60uKOHa1z=TB6Lcuw@mail.gmail.com> <ZH786WIea+k3S/jW@gondor.apana.org.au>
In-Reply-To: <ZH786WIea+k3S/jW@gondor.apana.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Jun 2023 11:34:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVo3zPrR9DXW3Pgs3WC1xH_HuwuOqVzjBf6bvDUoMDhXg@mail.gmail.com>
Message-ID: <CAMuHMdVo3zPrR9DXW3Pgs3WC1xH_HuwuOqVzjBf6bvDUoMDhXg@mail.gmail.com>
Subject: Re: [PATCH] crypto: starfive - Depend on AMBA_PL08X instead of
 selecting it
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, Jun 6, 2023 at 11:31 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Jun 06, 2023 at 11:12:05AM +0200, Geert Uytterhoeven wrote:
> >
> > > ---8<---
> > > A platform option like AMBA should never be selected by a driver.
> > > Use a dependency instead.
> >
> > FTR:
> >
> > arch/arm/mach-s3c/Kconfig.s3c64xx=config S3C64XX_PL080
> > arch/arm/mach-s3c/Kconfig.s3c64xx-      def_bool DMADEVICES
> > arch/arm/mach-s3c/Kconfig.s3c64xx:      select AMBA_PL08X
>
> Well that isn't a driver I think so it might be OK?

Thanks, please ignore ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
