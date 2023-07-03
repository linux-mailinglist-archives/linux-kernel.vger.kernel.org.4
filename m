Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26687462A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGCSoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGCSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:44:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF6E64
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:44:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso6027890a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409839; x=1691001839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m9Utfsc+e4Fl3U1ReGSVY6Biqx3UykghzW/7goN7uWU=;
        b=HBCY3DlQPdCmZfgKNc5AHZk10NYBoVVpOVjmHI6ZGwl+JPR6HFZq6S0QfnvZf2dlwj
         MQnAC0obseiHG7P9O2QZBbv1wr5MYTTruPi5fo9xwcVLIN6uNbcIEQs9XCps9fk9mNwv
         /0g98e31nyJN1R3nr2JQuqNmKDXQc0ar0ZbFMgwy+BLEW57eH2RibarRXZv29DbnKFXH
         w67RTWSYyCvsw1tk3aUl6RWdHFYJj7RhfPJ6x6iITVtcEUXE+8GDR3kpQhaF6ny761mH
         qFaRGded7eFYxKtoNsP92ErOA0mfHFuqQPquXfHaa5zPAANPTt47NzsbEPL5q1VJCa8e
         Cltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409839; x=1691001839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9Utfsc+e4Fl3U1ReGSVY6Biqx3UykghzW/7goN7uWU=;
        b=iPiiUnBspVOeDiOsuTjupMpulLI7XImIjxf8F7prm+WPgj+3/PaC3N6WSuAdVscmJY
         3hlgRJFE5GAx2YdO8GExYL1FvPdgQdpNrrUw1eQHELN2Vl246gWx7xPzJnvU8FjZ3n/N
         mHLFEUM+xlDoJXY6tC1SBhEp4yaWSsgI1N36Cq8mBf4HviMPP2IA9kTm+o9eir6DB9Vb
         svpWYOKjdxRFQFquch5Zw9fwghznE6i/1bMO7TyhjftZ8DOBzK9Ja9e7HQRSLnAbSkWM
         cRu+QUj3uB6xnqyLjR0DvSNeeWEOGxUzG31XhbO4SjmGxWl79CEXj5W9fIFBlALjN+E9
         Mqww==
X-Gm-Message-State: ABy/qLYu6yrSFp7Z969GVhTS824OSrhSAb/SgRYf7FiYvdkK0E0JXut7
        wFmeEVUiT6xCaaG3449hBct8P4zUoZZTXMEGdOQ=
X-Google-Smtp-Source: APBJJlEjVoVeQdS32zS0OjiYPbb1jrzy+188U16jjeCMgWaIN/RzVze2cfJdEPB8jTBom3Vxa7PueWfeSx7J9tZKTpQ=
X-Received: by 2002:a05:6402:43ce:b0:514:9929:1b01 with SMTP id
 p14-20020a05640243ce00b0051499291b01mr8414047edc.8.1688409838855; Mon, 03 Jul
 2023 11:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-7-4d3734e62ada@skidata.com> <030a99f7-98f3-a24d-612c-d460859fc276@gmail.com>
 <08d6fc5d-30bc-4a55-a495-2a73b5800f79@sirena.org.uk>
In-Reply-To: <08d6fc5d-30bc-4a55-a495-2a73b5800f79@sirena.org.uk>
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 3 Jul 2023 20:43:47 +0200
Message-ID: <CAJpcXm6sPgW+z93sObv8rNjFxPsd4uzhHNNQaGmUR07kB0-BRg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 07/13] regulator: find active protections during initialization
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti & Mark,

thank you for the feedback!

On Mon, 26 Jun 2023 at 18:49, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 26, 2023 at 04:56:21PM +0300, Matti Vaittinen wrote:
> > On 6/20/23 23:03, Benjamin Bara wrote:
> > > Warning can be fixed by enabling (or disabling) monitoring in the DT,
> > > e.g.:
> > > regulator-uv-protection-microvolt = <1>;
> > > or
> > > regulator-ov-error-microvolt = <0>;
> > >
> > > Constraints regarding the monitoring of a regulator can usually be found
> > > in the docu.
>
> > I am not entirely sure if this is the right thing to do. Should we expect
> > the hardware state to be what is described in DT at Linux boot-up - or,
> > should we silently accept the fact that for example boot can alter things.
>
> > From the 'code pov' I have no complaints though. I just can't say if warning
> > is the right idea. I'll leave this for bigger brains to decide :)
>
> Yes, this isn't really the idiom we normally adopt - the default thing
> is to just leave the hardware untouched, that should not usually be
> regarded as a problem.

Thanks for clarifying. I will now activate the constraint instead of erroring
out. This guarantees that the workaround will still be applied, so basically
similar to the current bd718x7 implementation. I would still keep the message as
a warn, or should I drop it too? My idea is to let the user know that there is
some kind of monitoring going on but the device-tree is not aware of it.
