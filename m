Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9944170769B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEQXxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQXxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:53:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9985F3AA2;
        Wed, 17 May 2023 16:53:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2534fe570cdso166055a91.1;
        Wed, 17 May 2023 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684367589; x=1686959589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFNnEl1Mb99jruBcTHfV1S3/pkrkMKc2kkp110Tpr7c=;
        b=T0gf1IOLOXivyANAsfEmays2O/XHuvFbHcDaacJYEy1ZF3mJo20OEItx8h+59qFNQ8
         M1HiJfsx6547PXzcLi0ESh7LPg+z6tlivkFNAF7ZT3XuFxceMFRmNjdhI2P6jxSUz8/c
         FLzl3xfML2indj9y3qMLSjgZHRHWM5RTwcWrzLlqLsTBqoR0J+VKfqlcvoRNwFxGdWC6
         VVn/yHRLarTbfj1u/PvqiYwkD/li+c09Hab4caI9w+dc8Ifk97P7pf4eG2n4p3KNsDaq
         shhMyHgeVfVEeOf9A7EqsFDyS6a3bJyayMYOPt8GhlJnZPiLAAv04E5Hb8HPvYCDcN4u
         KtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367589; x=1686959589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFNnEl1Mb99jruBcTHfV1S3/pkrkMKc2kkp110Tpr7c=;
        b=TcCkuMc2feSoWwGMoe3tNoqpedfbn+v6+9z7RjtZxuvqe5yE86HM9/MUnqKefqKele
         JZCLn9p+hOKw2sjFqaJpR1Lv9ZZwdSdJlHuNwgHdJEVuYoiiWJWQGP8iIlKekrjXgoKv
         nq64NaWOfqiN+ScTY0nb/2JyxA+iZKgymL81arQwplJPXBOFQ/rArFYC3EzvnW7IvwPS
         YN/IC+VPebjoVihy+IVY1f5RS1rUMuXI3m6oGN8w7m7WjXhAEKLDLQa66dp/wVxScAYh
         l+M47+EAXMBtGEq/CtfwdnLvdPhadzw34E3buWIPsjA4LEB99JV98ONsAvQBfJCHdBhd
         OJSA==
X-Gm-Message-State: AC+VfDzH5cNcHJDqEoLjfXiXK/ML3neFsz3fdnQpiT1PrzVltOP7/vYg
        L00MhBfNzh9WPs7WBphLyPSJIMYxV6LdJyrwm98=
X-Google-Smtp-Source: ACHHUZ4hC5yGSd9bo1VjZSAXf4vDiXhxWnURjt8phDifpJk3ivPA50CitCtkvVdd/vQxS2iGeLDwLwxeXeHV3sZQzQg=
X-Received: by 2002:a17:90b:1802:b0:252:b342:a84a with SMTP id
 lw2-20020a17090b180200b00252b342a84amr5232800pjb.0.1684367588970; Wed, 17 May
 2023 16:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230517223007.178432-1-boerge.struempfel@gmail.com>
 <CAOMZO5CqMMCCOsAB3YgJUUampE=iZru57d=qoX13-GkSaaC5gg@mail.gmail.com> <CAEktqcuMrqiwDfGM=SAoHiKPY-hupS+jipt=6Tasr1q8VUvRQQ@mail.gmail.com>
In-Reply-To: <CAEktqcuMrqiwDfGM=SAoHiKPY-hupS+jipt=6Tasr1q8VUvRQQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 May 2023 20:52:56 -0300
Message-ID: <CAOMZO5CJwwKmDYRxnny2JOrwucGn=q7+9xKqk_NSvZ_wyNSHEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
To:     =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 8:20=E2=80=AFPM B=C3=B6rge Str=C3=BCmpfel
<boerge.struempfel@gmail.com> wrote:

> My bad. Thanks for letting me know. Just to clarify: I put the
> changelog directly below
> the first ---? And do I then put another --- between the changelog and
> the following
> include/uapi/linux/spi/spi.h | 3 ++- line?  or is there just a
> new-line seperating them.

It should look like this:

Commit log line 1
Commit log line 2
...
Commit log line n

Signed-off-by: Your name <your@email.com>
---
Changes since v3:
- Bla bla bla

> And if you don't mind my trivial questions, am I supposed to write a
> cover letter for
> the patch-stack? I seem to find contradictory answers to this question on=
line.

Yes, for a patch series having a cover letter is helpful.

> > Should tools/spi/spidev_test.c be changed to include this new
> > mosi-idle-low option?
>
> Until now I actually wasn't aware of this tool. However on first
> glance, it seems
> reasonable to add this mode bit. I can certainly add this mode bit to
> the spidev_test
> if desired.

Yes, that would be great.

> While looking through the code, I noticed, that the latest two
> additions to the spi->mode
> (SPI_3WIRE_HIZ and SPI_RX_CPHA_FLIP) are also missing from this tool. Is =
this
> by design, or should they then be included as well?

Looks like these two are missing and would be good to get them included as =
well.
