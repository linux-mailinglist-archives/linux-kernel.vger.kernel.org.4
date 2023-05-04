Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB86F6B10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjEDMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjEDMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:19:29 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F03C7284
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:19:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b996127ec71so605988276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683202759; x=1685794759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0BBMlMuhsvJslxHkgJj2+Y0Hn+bMZWGZK5WjuDPBsY=;
        b=NoQYyZqeA0SQwvIUS/9QOhNCXe85mGDlgPllqMWdTSrOww2ZBuZngjthCLUbhK0oJm
         Hp8bHn1LXGN64/gTkUlpO8uDaYkogEqxHtM7fqv56QpK/VGGAQRy85JzZfmbqlxRxxEg
         IdGlOoHL7Cii8vQzBKWuN4+zd1D8N94pNkMLiQO8SNrbWxRC33xFB/rS7glTBbGwirsb
         /ngEPISLdr9F9ekv4Pepmnb6MVqO8RDf/oQqR/WckKjzcHYl1B9QGeGr8hqZ4gNSemmi
         DLjxNbXCvojvhrrToKr7hSu7CUGHKj9D7U5p/KJH9akJqVjMmrrIb9Q/PxldPtMDWKy/
         Jd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202759; x=1685794759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0BBMlMuhsvJslxHkgJj2+Y0Hn+bMZWGZK5WjuDPBsY=;
        b=QhEwSbAPHlpJoYLanvkAT0/bHIkfC0GoA8fWnRPaY+UsKVcsV7eJt9c/ME1Ap0vnZ6
         0jpMlt+2v3Xu8ltTVcF6r6l8TWE/QEiWCA+dUktQUd5ZUnglMeOUX0PMQTHyBBAZ9kh1
         QY+z5IMIM7s65uYTLg64wWX4M8cwj5rnnk4SeuxatfMBl47NaPhYLTBayONA95VNTFpT
         IBrCcrVbQAjcddvwWXYui0xcsDPFEmrwrXYQ4yCYiKunjKru3wFBHhyhpUiS1AiPAatf
         JOTcl9uH6DXDiTu/DCqLDpifzDuEnIBqQRiQ2H2pc3b/9Jhio3C/Eks2rZKxojDQ5Uh1
         AkQw==
X-Gm-Message-State: AC+VfDxpwoJcz2ZuvOLlfz5picZtKKZPItmaD6i/LpbxLCTrODyGBbuI
        BkMzdhV7Elfbf9QwTH/Tu9q8aLRUv1tmuy5QkGTs8A==
X-Google-Smtp-Source: ACHHUZ4VDWXMROP3mCAF7rpou7Htz0bEHKaHrjuuvqvEA4WmfiqDVqgTJPJuYa7V9/7tWfvgdnV+3a0+eHkbXthOZrI=
X-Received: by 2002:a25:502:0:b0:b9e:45e1:20e0 with SMTP id
 2-20020a250502000000b00b9e45e120e0mr11815579ybf.48.1683202759261; Thu, 04 May
 2023 05:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org>
 <20230430-omap2-pdata-quirks-v1-1-e015f3a3ea46@linaro.org> <CAMRc=MczGKVFo+iWe_Pnvi3-hCK0fhmmkjp-h92RHONEHFAP_g@mail.gmail.com>
In-Reply-To: <CAMRc=MczGKVFo+iWe_Pnvi3-hCK0fhmmkjp-h92RHONEHFAP_g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 May 2023 14:19:08 +0200
Message-ID: <CACRpkdbYR+kobi3-xx7FgQG5aZb37JJageP+JWMss=D+KZUkFw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM/gpio: Push OMAP2 quirk down into TWL4030 driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Lee Jones <lee@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 3:02=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> On Mon, May 1, 2023 at 11:05=E2=80=AFAM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> >
> > The TWL4030 GPIO driver has a custom platform data .set_up()
> > callback to call back into the platform and do misc stuff such
> > as hog and export a GPIO for WLAN PWR on a specific OMAP3 board.
> >
> > Avoid all the kludgery in the platform data and the boardfile
> > and just put the quirks right into the driver. Make it
> > conditional on OMAP3.
> >
> > I think the exported GPIO is used by some kind of userspace
> > so ordinary DTS hogs will probably not work.
> >
>
> While I haven't tested it (nor can I) so don't take my word for it, it
> looks to me as if regular DTS hogs *should* work. If anything, the way
> this quirk is implemented in your patch moves the export past the chip
> registration, while ordinary hogs would be applied when the chip is
> first added.
>
> Am I missing something?

DTS hogs cannot do gpiod_export(), that's the problem. I think the OMAP2
(Nokia phones?) need those exported GPIOs.

Yours,
Linus Walleij
