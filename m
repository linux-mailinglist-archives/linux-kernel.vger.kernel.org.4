Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBDA72464B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjFFOhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjFFOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:36:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F3D10CA;
        Tue,  6 Jun 2023 07:36:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75e4497597cso235658885a.2;
        Tue, 06 Jun 2023 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686062210; x=1688654210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pHfhgJpmyYHKAj9H1AH6OpEbFEZgptlDbr8iBk/Wos=;
        b=j/8Muj0Jskxwh51gbdolgS/TzJHxJvOle6Tp5pRV7vUCGcGOIMNG6xLwme6+/jK9ex
         +D2dg8WZI5bHLjrBk0p2Jceg5hQ9toCaLE5PywYI8al7dIqlzc1+70PorZp2XMA6tEMZ
         6aO3yX+uID2xVnGZjkjeSS7BUKPeiRR9eUYBsdw3/U/Af2xSFj4byHVp8WeMChKubBSV
         rjdKQpWNWtQpVe0OvWugf7VkrKPG5texNqHMHsSW8523EaXTM5Nec+Y/6OR3sVDVwNyp
         sFdGQQ/4kPkqsT/E5jOxa4RSkcHYuaHH/u1R35heqljtviIc7+nrC+Z7ZYGlExGBT1r0
         EHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062210; x=1688654210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pHfhgJpmyYHKAj9H1AH6OpEbFEZgptlDbr8iBk/Wos=;
        b=LuHymNYuyFxaRDLSVfB9BVfrXcPYcKhEKXYwZKjadtqzqR1QPQmaE78GZtQAAotEzo
         +VOPVJ0EdOGzrQAbChaLeKN05uOc0P+AjRhmQJwNXsvaen/jZ16IBKNnAKxybazGOj7A
         R0T9R4w8NLonQ0253qJcaI8SXaMfzpmBV86KC1kOMRweZce1p4pZewwaAzl4fOQHiRDc
         BSzXdhptagwe8x/3MuE2pxdPUIaTTjpY8PGXcXWSxHZvCVay4eim57rSdiqwNmmmKHON
         8fRd6pnfGFYr+di2Ke+SK59WjGwTnJOKehIp8EbNFpx8Gi+79IS/3g/AjnujhgC/UxRU
         V0jw==
X-Gm-Message-State: AC+VfDwjPlfmw9ONM29nyMKgfVaMLwQQskSJEfTA8nWj3sROSA9hERwZ
        93Xfy5wc3DxqF9duUUrrHK2yGbOUm1gipH+Z/dk=
X-Google-Smtp-Source: ACHHUZ5hPolR27BbcFXkbeEHThpkvtUWrhy6uOFaajbFQCLbRF+UBSxD82ZTDoQp4Mw84aLjYdUGp8gv+mBI32zJvGg=
X-Received: by 2002:a05:6214:1c8e:b0:56a:d94d:6deb with SMTP id
 ib14-20020a0562141c8e00b0056ad94d6debmr2510370qvb.25.1686062210042; Tue, 06
 Jun 2023 07:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
 <20230511-tps65219-add-gpio-support-v4-1-b5d6a764d722@baylibre.com>
 <ZHXZBCwk6tTu8gjY@surfacebook> <e487f966-aafb-7d21-935d-b1d0ac7c21ac@baylibre.com>
In-Reply-To: <e487f966-aafb-7d21-935d-b1d0ac7c21ac@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Jun 2023 17:36:14 +0300
Message-ID: <CAHp75Vfu0V_nqy-0tdOM31onZn-P+mGDXJO5CnC4GkuVqYvvdQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 3:45=E2=80=AFPM jerome Neanne <jneanne@baylibre.com>=
 wrote:
> On 30/05/2023 13:07, andy.shevchenko@gmail.com wrote:
> > Tue, May 30, 2023 at 09:59:59AM +0200, Jerome Neanne kirjoitti:

...

> >> Datasheet describes specific usage for non standard GPIO.
> >> Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
> >
> > Can you convert this to be a Datasheet tag? Currently even Link is *not=
* a tag
> > because there must be no blank lines in the tag block.
> >
> >> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> >> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> >> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> >
> I misinterpreted this comment. I looked at wrong examples but I think I
> understand now that the right usage is to have all the tags grouped
> together into one block which is delimited by blank lines before and
> after the whole block.

(Note, there is no "after", tag block is the last in the commit message)

> I'll then do this and put all the Datasheet/Link into the tag block.
> Stop putting Links inside the commit message right after I refer to it.
> https://www.kernel.org/doc/html/latest/process/5.Posting.html#patch-forma=
tting-and-changelogs

--=20
With Best Regards,
Andy Shevchenko
