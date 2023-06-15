Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBFF731ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbjFOOKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFOOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7A171C;
        Thu, 15 Jun 2023 07:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5B86208A;
        Thu, 15 Jun 2023 14:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C07DC433C0;
        Thu, 15 Jun 2023 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686838239;
        bh=8FbUCp9ZN3V8nlIJvTpnnVtxiR20eH47E6H/M2tQXMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ASgQIRayntAdT97tBYFV9Ia7GNoIxKYG1PmGtj1z29/XtQ1cFGks3JP6Gc1QuA8ZW
         jqh4SEPBCCnBi13+uima4zmtEXPLeXG16Pu/BYmnu2fBl8IyvgcNDPxfnp+ZVOsEuj
         PrYR40AjuV571ldWvTe27VbZ0AUPxNU0BLMf4URYRzdbPVyMFWMk4qNtzLTkO70/kw
         cjhJhkEDVx7R0p8s7LA4vsbFFmzq+7rreZV93cVBMBI/TuzCbO1nTm9Dt1y/6aKwII
         REpbMHZiVdLnG7cH12EXCg4fyvBe0frVGsMuNKiP3LoxsUpwsNzcP+92tN2DFM2O9a
         bclXr1gEv3t+g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b3451b3ea9so29594721fa.1;
        Thu, 15 Jun 2023 07:10:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDxr03xU8bwlboPRXgqEjzsU1vnJLPAWJR/9QlvxGR6Bam19n05P
        m813F5mpGNYNunELvT1umMqXTN9HMcwfgP8IHw==
X-Google-Smtp-Source: ACHHUZ5l1G1VXSMGnsvMpM+q5vZFcFP4B+j6zelO+XbNie7OI/xbiGaNMzhkpNcb442P88SlAscXmNvERfy9/U37uAE=
X-Received: by 2002:a2e:9846:0:b0:2b1:ac82:296 with SMTP id
 e6-20020a2e9846000000b002b1ac820296mr9302682ljj.34.1686838237226; Thu, 15 Jun
 2023 07:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230609143609.209373-1-brgl@bgdev.pl> <CAL_JsqK77OW3n0PW6zP3FNdmuQHnDp9=wfX4E3ga-VW0_LRHHA@mail.gmail.com>
 <CAMRc=Mc7bbaDA1g3gn79XJZL6bTPGf9xZsB3=A4oiMUggzb4kA@mail.gmail.com>
In-Reply-To: <CAMRc=Mc7bbaDA1g3gn79XJZL6bTPGf9xZsB3=A4oiMUggzb4kA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 15 Jun 2023 08:10:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAC8oLLyNKMCOcMDjVpuMGK9E3zoYBejwuGGu4p9SDEA@mail.gmail.com>
Message-ID: <CAL_JsqLAC8oLLyNKMCOcMDjVpuMGK9E3zoYBejwuGGu4p9SDEA@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: drop assertions for GPIO hog messages
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 2:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Fri, Jun 9, 2023 at 7:01=E2=80=AFPM Rob Herring <robh+dt@kernel.org> w=
rote:
> >
> > On Fri, Jun 9, 2023 at 8:36=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > These have now been demoted to debug and are normally hidden. Drop th=
e
> > > assertions entirely.
> > >
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/of/unittest.c | 28 ----------------------------
> > >  1 file changed, 28 deletions(-)
> >
> > Why is this a separate patch? Don't I get at least 5 days to
> > review/ack changes in drivers/of/?
> >
>
> Sorry, my bad, I queued the previous one through the GPIO tree after
> it was reviewed here thinking the unittests bits are trivial. I can
> back it out if you insist or you can ack this one and the end effect
> is the same? I will pay attention in the future.

I'd prefer it to be squashed, but either way:

Acked-by: Rob Herring <robh@kernel.org>
