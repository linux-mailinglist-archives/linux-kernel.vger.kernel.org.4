Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6346C01AA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCSMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCSMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:36:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7361C7E4;
        Sun, 19 Mar 2023 05:36:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id br6so11748604lfb.11;
        Sun, 19 Mar 2023 05:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679229381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O4w2SUk73WmZLm7j2lW8S2qx2ENWnudONQ20HAfaaI=;
        b=W1wfR31wCn7rm3H//zFjjjN2gE7W3YZN/mUiGEw8UfOADmTr23qdvKaw0S+xAWluN5
         vKOeUk81+H3r/OZl7eRage8cUiiR0DTN8CdYlGRaSz4HWLIovI75z3eQGKFuDK3iC5e1
         EPiEAOMuSCHHDVH5QJNfFcCPQ2AAzd0T6p7BTQFTeFnmKkNr7Yjb4pfYfjW2EgaUfscv
         hXQnVsVngOEvWaqFdmizrhsj85QpPTs8EvjNf6aFqeh4odIOAKtuniExZ7hH4X/nsW8F
         8j6/8y7unLQ4SMILHg80T8s6kXr+7hp0qOUEg3YxI0RsU+kJdXAAp+2/4q0OgukPYwWb
         oxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679229381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9O4w2SUk73WmZLm7j2lW8S2qx2ENWnudONQ20HAfaaI=;
        b=iXKxUjEagZMLXskNpCe8dXC0h9r5JtuOxmcl4PVUBU78NLwYh/RzuUIU+cz7NnWFAC
         dXnvaUMyM4bZD/YQabsHfa16+eXqUJlT8LQlb0pEa5RfjP8VzbJZ6t448ayOKxg24kFQ
         zo+0iT2RdmlKB1kB2aJ2df1Ukm8ZA8+xYQ8QikadFV/AswWVIB4JW0qZhyQX+GsMm13m
         LXawSKIfwsvDEpZoxOa4CyFvPFf+sTLuy8CoaP4RiBCH+At8Vucxz0SJBSzMxVeknRGk
         zqbBeSN/tn9RknMf8nlVySrAcI32ZpSFq+ad8GL8K9hQlBtoKOwnhHYTnqRKz2MOhaoc
         9/VA==
X-Gm-Message-State: AO0yUKWiI0eUEc+GseaWRvC7Q3rUFo/Xf80WCJi1Lgh0zvtvOtYM1HMk
        ro4tCsbGp8MQoHiONG09bpipjlzZw2/7f5Wz5bY=
X-Google-Smtp-Source: AK7set8y7mL7JJVEbiA0Bqd+vcC5IxB3NlW8Fz8bd6MEtKTTXlelQ6tkgOfmgafEY9MLLELAo7STk1RooL6GTqzvdrc=
X-Received: by 2002:ac2:598a:0:b0:4dd:9eb6:444e with SMTP id
 w10-20020ac2598a000000b004dd9eb6444emr2664598lfn.5.1679229381051; Sun, 19 Mar
 2023 05:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-16-ychuang570808@gmail.com> <d56ec914-c2e4-427d-abc4-a290f3467937@app.fastmail.com>
 <652015b6-c2d7-0d97-3a4f-99d26d90f7f7@gmail.com>
In-Reply-To: <652015b6-c2d7-0d97-3a4f-99d26d90f7f7@gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 19 Mar 2023 14:36:09 +0200
Message-ID: <CAP6Zq1i8yw7O5bJ86U-v07PmwD7msAbnY8GWiGmZ2Ri-d1-UPw@mail.gmail.com>
Subject: Re: [PATCH 15/15] MAINTAINERS: Add entry for NUVOTON MA35
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky and Arnd

On Sun, 19 Mar 2023 at 14:01, Jacky Huang <ychuang570808@gmail.com> wrote:
>
> Dear Arnd,
>
>
> Thanks for your advice.
>
>
> On 2023/3/16 =E4=B8=8B=E5=8D=88 10:38, Arnd Bergmann wrote:
> > On Wed, Mar 15, 2023, at 08:29, Jacky Huang wrote:
> >> From: Jacky Huang <ychuang3@nuvoton.com>
> >>
> >> Add entry for Nuvton ma35d1 maintainer and files
> >>
> >> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> >> ---
> >> +F:  Documentation/devicetree/bindings/*/*nuvoton*
> >> +F:  arch/arm64/boot/dts/nuvoton/
> > This clashes with the existing entry for NPCM, so
> > contributors can easily get confused about where
> > to send their dts patches.
> >
> > I don't have a good solution here, but maybe you can
> > discuss this with the npcm maintainers (added to Cc)
> > to see how they would like to handle this.
> >
> > For me, the easiest way would be to have a single
> > maintainer send me all the patches for both ma35d1
> > and npcm, but that may not be practical for you.
>
>
> All I can do so far is, once we receive a patch for npcm,
>
> forward it to the maintainers of npcm, and the npcm side
We can forward ma35 DTS emails to you as well.
>
> does the same.
>
> And I would like to modify it as
>
> +F:     arch/arm64/boot/dts/nuvoton/*ma35*
About modify
F: arch/arm64/boot/dts/nuvoton/
to
F: arch/arm64/boot/dts/nuvoton/*npcm*
We can't guarantee that our customers will use npcm in the dts files name.
>
> >> +F:  drivers/*/*/*ma35d1*
> >> +F:  drivers/*/*ma35d1*
> >> +F:  include/dt-bindings/*/*ma35d1*
> >> +F:  include/linux/mfd/ma35d1-sys.h
> > I would replace these with a single line
> >
> > K:    ma35d1
> >
> > that should have the same effect.
> >
> >       Arnd
>
>
> It's fine. I will use K: instead. Thank you.
>
>
> Best regards,
>
> Jacky Huang
>
>

Thanks,

Tomer
