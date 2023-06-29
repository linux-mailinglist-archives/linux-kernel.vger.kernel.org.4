Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C32742BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjF2SOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF2SOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A902D4E;
        Thu, 29 Jun 2023 11:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B015D615D5;
        Thu, 29 Jun 2023 18:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347CC433CD;
        Thu, 29 Jun 2023 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688062455;
        bh=3PDKXMLxLcgXC70r133hN7RdCNUmqJodDnupnZq7mAs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hk0ao3TDP1eQ2pET5oUwrUBXT94bg+SpyBgCgDYawy3ASHMNfCoO1bsQGSZlmOpLx
         GCu6sTHSRovvxVLQKSGkoffIwUKrKJdlq/YcLJvhQ01Zpxo6tan8UaafOW1XH7hGfS
         /3wjA9iTDcnsiNfWvGDYgfnMly8Z4y9lZjoO31KOATQoux9ZWkG+IhzB52wIEBe6Lm
         B9tFTchDpwCGGi09lnU5W81+0/bL0bJSrxEyF/PchomKSq5zDc+qe8nhBK/4i3jfCJ
         0eeIuM3wdG7S3yAf3m748p+ozt8Clj0W2DOwP7NE762mWNwLbZNDl/ukZQV7EwDT4g
         YH+Bu5vnCmRXg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so16224801fa.3;
        Thu, 29 Jun 2023 11:14:15 -0700 (PDT)
X-Gm-Message-State: ABy/qLYEMes0R6Pn5/kdlEakt+00TB49vLOhOgYAjxXCf5m9pdZCb50S
        ej3ch4OTy/iDdHSDF0QbbXiYyW/AAIwy5fGqKg==
X-Google-Smtp-Source: APBJJlE4ui316dFMl3ElCBvXxk/YYiisZmiFISRRdzXKneRDs1qNwcYfUDMslUMs5s7zBrhrIiZTLIKFwyyAqo6EsyM=
X-Received: by 2002:a2e:8e8a:0:b0:2b4:5cad:f246 with SMTP id
 z10-20020a2e8e8a000000b002b45cadf246mr422351ljk.7.1688062453050; Thu, 29 Jun
 2023 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZJry8QTka8m6ag/j@fedora> <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com> <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com> <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
 <20230629155134.GB2110266@google.com> <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
 <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com> <998ef8d8-594e-45e3-9aa3-ec9061cf7f11@sirena.org.uk>
In-Reply-To: <998ef8d8-594e-45e3-9aa3-ec9061cf7f11@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Jun 2023 12:14:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1X-oZHerE9qhcPZ=mFsm7rJa3KxWGBqV3znHHfr6vaQ@mail.gmail.com>
Message-ID: <CAL_JsqK1X-oZHerE9qhcPZ=mFsm7rJa3KxWGBqV3znHHfr6vaQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC Support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
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

On Thu, Jun 29, 2023 at 11:59=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Jun 29, 2023 at 11:48:34AM -0600, Rob Herring wrote:
> > On Thu, Jun 29, 2023 at 10:00=E2=80=AFAM Mark Brown <broonie@kernel.org=
> wrote:
>
> > > That says it's a bit unusual to use a separate branch with a PR, it
> > > doesn't say anything about it being the end of the world to pick up
> > > parts of a series that are ready without picking up the whole lot,
> > > especially when we're getting to the merge window.
>
> > There's some risk the core part could change affecting the sub
> > components after you pick it up, or that the author just abandons
> > getting the core part upstream and we're left with a dead driver.
>
> Right, I'm suggesting applying the core part without waiting for every
> single leaf driver to be lined up rather than the other way around -
> that way the core part is stable and the leaf drivers only have issues
> with changes in their subsystems that they'll have anyway even with
> waiting.  Leaf drivers can be added on top as they're ready and if
> something misses a release then it can go through the subsystem, and if
> people do end up wandering off then you've still got whatever did get
> merged in case someone else wants to pick things up.

I misunderstood. I thought you wanted to apply things to get them out
of your queue. That doesn't work when the leaf drivers depend on the
core, so what do we do there? A branch or Lee takes everything? That's
almost always the case with the bindings as the core binding
references the child node bindings. My preference there would be that
Lee picks up all the bindings with the core driver.

Rob
