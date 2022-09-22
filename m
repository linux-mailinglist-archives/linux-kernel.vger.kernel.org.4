Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D165E6B92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiIVTNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiIVTNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:13:37 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB44106A1D;
        Thu, 22 Sep 2022 12:13:36 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id i15so7547060qvp.5;
        Thu, 22 Sep 2022 12:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4SC2lpclsApuwnvv9v4FOQnC9TCXLCDA7rskDl0X8oQ=;
        b=4RXJGxrGX5X5Z80FXXfTB9gbmLokUMJvd8alC6/0XfWmICYTcqzEKqUhKDU63HG+uc
         Xh2SNIkoJDLmcbNgk+4paD5pP5Q16JQXUUBPx6p03cX2lUeF0a3/E1BpDibkazvDP1vT
         ZnzF/yMnJ85+qSUUzOxu6gaXQgGrNtHTjORwAwsORxSQP1Sjl9IZ2+MIRmZ1YfpeKIkd
         DRt36MPeav1kDaWMU1Gv5kP/L4gZ6dDc+20UPpv1CPjnrLLAZkUlFTrQunSXT/nLVjFP
         Cvsyu1mqTMnAOA21hJLTc8TgyIvG5leDjHQbVhEuIGdnLMxPNDxQvc9AbeL9zEAVDS4Y
         rlLA==
X-Gm-Message-State: ACrzQf0d4SNx2D0P7U9URV7OxsIALOqiYcNhvvgO/5/HYQ8C2WAQ1yLO
        vjrMeM6ySsLllCmKQx4pqN5GdhVVYIEyYg==
X-Google-Smtp-Source: AMsMyM548HrAEqlLjyib+W1FVYo4U5HB+ZBnj1F3h2wYRCNU6LhpBN1knHIT6DJTM9syde57c2gJnQ==
X-Received: by 2002:a0c:f445:0:b0:4a6:9f4a:9a66 with SMTP id h5-20020a0cf445000000b004a69f4a9a66mr4001052qvm.65.1663874015231;
        Thu, 22 Sep 2022 12:13:35 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id o2-20020ae9f502000000b006b640efe6dasm4041930qkg.132.2022.09.22.12.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 12:13:33 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3452214cec6so109751637b3.1;
        Thu, 22 Sep 2022 12:13:33 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:344:fca5:9b44 with SMTP id
 g9-20020a0ddd09000000b00344fca59b44mr4793428ywe.358.1663874013318; Thu, 22
 Sep 2022 12:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yys4CRNnKP3LXyAO@pendragon.ideasonboard.com> <CA+V-a8uiT9rV=T6LmFovRwULf3SO=JKdqr1yacAqN8gJmv9VPw@mail.gmail.com>
 <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com> <CAMuHMdXKz56jxw56fXa7CMh_y4MVYiUT25dqRntJw6481s1FWw@mail.gmail.com>
 <CA+V-a8sW=a6auFH-1WqwK+o2MZGCQk+MAO4+cWKm1M+YrQE+CA@mail.gmail.com>
In-Reply-To: <CA+V-a8sW=a6auFH-1WqwK+o2MZGCQk+MAO4+cWKm1M+YrQE+CA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Sep 2022 21:13:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU9LpSQ9-M49JC+wKk9=fsvX=cxTZwSQxU=CKcCRRU0Sg@mail.gmail.com>
Message-ID: <CAMuHMdU9LpSQ9-M49JC+wKk9=fsvX=cxTZwSQxU=CKcCRRU0Sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Sep 22, 2022 at 3:27 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Sep 22, 2022 at 1:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Sep 22, 2022 at 2:34 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Thu, Sep 22, 2022 at 01:08:33PM +0100, Lad, Prabhakar wrote:
> > > > > > * Switched to manually turn ON/OFF the clocks instead of pm_runtime so that
> > > > > >   the mipi/dhpy initialization happens as per the HW manual
> > > > >
> > > > > That doesn't look right. The driver doesn't use runtime PM anymore, so
> > > > > power domains may not be handled properly. What was the problem with
> > > > > clock handling using runtime PM ?
> > > > >
> > > > If we use the runtime PM all the clocks will be turned ON when we call
> > > > pm_runtime_resume_and_get() which I dont want to. As per the "Starting
> > > > reception for MIPI CSI-2 Input" section 35.3.1 for example we first
> > > > need to turn ON all the clocks and later further down the line we need
> > > > to just turn OFF VCLK -> Enable Link -> turn ON VCLK. Due to such
> > > > cases I have switched to individual clock handling.
> > >
> > > If that is the case, then you should control just that clock directly,
> > > outside runtime PM callbacks.
> > >
> > > Runtime PM may be needed e.g. for resuming a parent device.
> >
> > Exactly.
> > So probably you should not consider R9A07G044_CRU_VCLK a PM clock,
> > i.e. you need changes to rzg2l_cpg_is_pm_clk() to exclude it.
> >
> Thanks for the pointer. In that case we will have to consider
> R9A07G044_CRU_VCLK and R9A07G044_CRU_SYSCLK as not PM clocks.
>
> Does the below sound good?
> - DEF_NO_PM() macro
> - bool is_pm_clk in struct rzg2l_mod_clk.
>
> I still have to implement it, just wanted your opinion beforehand.

LGTM. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
