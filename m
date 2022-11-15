Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67984629434
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiKOJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiKOJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:21:55 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F2F5A;
        Tue, 15 Nov 2022 01:21:51 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l2so8353630qtq.11;
        Tue, 15 Nov 2022 01:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xXL/hOs12FtYk0AbtyBPhJfzSMYRFKjKvVy0h+Tw7Hc=;
        b=hku9bPre7z/rmX8trtw0laMTMJsXJZzJ5kv0wzQ63Nu4YaiyH61mtYfscjoC8J7KsT
         RmrxDzo1vKeAWi+c5jHBnUZkPtvtr8YuPQJxcXkquJOUb7vzMIsCaHjd3bC0Qcw+AgWA
         /hh1NYhyxqPdo1Am+rkxQEZbuZQ/CbNHil9h457brT9+X2GSHeusMUTtdW59BFLzFpxP
         5/Sl3x7YR+hWttbd1DI70S18O+s4rWkoOvopbocnJL/BtUdio9qY9eDVvd766lSWo376
         nXCrTbiPBIOU82PyNw41a2/iwcao2dXQ9n4BYHTFC8hr7PFtNIJJlXG0WG5i3GVfjOh6
         Ydgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXL/hOs12FtYk0AbtyBPhJfzSMYRFKjKvVy0h+Tw7Hc=;
        b=SGSsvSDzkaDq5K8G5y1YdB3hFZ49UjvPdGK1E7cBBQtGwIf/iuDxe0QodssHsSVOD/
         FaP9zWX85MYwxyU68DDGQYOx86UFRSZuF8Pi7RJHPet6qOmWcOYeNp8gdT03jGKO6xJC
         k3lZh7Purb9PTI4h1VqbCUB2uGll4sOxjvWthmYzemhOFjHf3ZZYTrXkjs7I2/ftiH/N
         HqKnDCGhoyEN2Rc1ZKqBcYm7ECkFeXNUg2SvgP9/Cjia8LZsF4mHOx4s8qnaMU5xP4Z3
         o+0Q28wPWpkbDr1/UfdDsSB5ylz7/eEbPQjfwuXWwqp3AY2tMUaeuwWLZp2pbVV0bwSG
         q9Tw==
X-Gm-Message-State: ANoB5pnKJntfmIBAq8b3+80oKkRknmtLLuIDwn5PsyOpPiVOJl+f5oUW
        oHbWMQqOVoNoZvIM5qAUx+7SAYA9N0vh8WfSS/E=
X-Google-Smtp-Source: AA0mqf4YJ2cL4QTriG7mNPmQbW//LTaVCPgXBbNW8Dtht0N40RPHWO3lkf6xjgCAVTJycjjexUtxYPLi7cCVtzeyES0=
X-Received: by 2002:ac8:1414:0:b0:3a5:3cb2:d849 with SMTP id
 k20-20020ac81414000000b003a53cb2d849mr15998551qtj.504.1668504110388; Tue, 15
 Nov 2022 01:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20221108092840.14945-1-JJLIU0@nuvoton.com> <20221108092840.14945-4-JJLIU0@nuvoton.com>
 <CACRpkdb+Bkwa8yCKGtRcsJ6KnJh+RUuz_gOrQV63pcYQLaHCaw@mail.gmail.com>
 <CAKUZ0+GCf_Zv=VhnY5Z=yYAfR1=_ha98BVVxRGVy8ui6so_Yrg@mail.gmail.com>
 <CACRpkdYW0P8gqtGdiRX_frP32WF2W=NVg1JTu1fVMBXxEL0-WA@mail.gmail.com>
 <CAKUZ0+Hy5suFg9VZ8-+cH7kGc5KLqUnf9hjnT+iaw+a1HF8x0A@mail.gmail.com> <CACRpkdYbS_syVwgc=YndkV-DpEF0K8NpH6WzP=g0AFpN+OTN8A@mail.gmail.com>
In-Reply-To: <CACRpkdYbS_syVwgc=YndkV-DpEF0K8NpH6WzP=g0AFpN+OTN8A@mail.gmail.com>
From:   Jim Liu <jim.t90615@gmail.com>
Date:   Tue, 15 Nov 2022 17:21:39 +0800
Message-ID: <CAKUZ0+FD=x8s+vqUpYwsuRUw-yTHQjtTFzWDwW=d4k8X1x1LoQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Krzysztof

Thanks for your understanding and your suggestion.
I will follow your suggestion to modify the yaml file.
-> nuvoton,input-ngpios = <...>
-> nuvoton,output-ngpios = <...>

And I don't think the node name needs to use gpio.
because it's not a general gpio, so I reference aspeed dts and use sgpio.
Could I use the sgpio node name or could you provide some suggestions?


If you have any questions or are confused please let me know.
Your comments are most welcome.

Best regards,
Jim
On Mon, Nov 14, 2022 at 6:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Nov 14, 2022 at 9:38 AM Jim Liu <jim.t90615@gmail.com> wrote:
>
> > Our sgpio module has 64 pins output and 64 pins input.
> > Soc have 8 reg to control 64 output pins
> > and  8 reg to control 64 input pins.
> > so the pin is only for gpi or gpo.
> >
> > The common property ngpio can be out or in.
> > so i need to create d_out and d_in to control it.
> > customers can set the number of output or input pins to use.
> > the driver will open the ports to use.
> > ex: if  i set d_out=9   and d_in=20
> > driver will open two output ports and three input ports.
> >
> > Another method  is the driver default opens all ports , in this
> > situation the driver doesn't need d_out and d_in.
>
> Finally I get it!
>
> Some of the above should go into the binding document so that
> others understand it too.
>
> Have you considered splitting this into 2 instances with 2 DT nodes:
> one with up to 64 output-only pins and one with up to 64 input-only pins?
> That means more nodes in the DT and more compatibles. If all
> the registers are in the same place maybe this is not a good
> idea.
>
> If you feel you need to keep the two properties, create something custom
> for your hardware because this is not generally useful, e.g.
>
> nuvoton,input-ngpios = <...>
> nuvoton,output-ngpios = <...>
>
> By this nomenclature it also becomes more evident what is going on.
>
> Yours,
> Linus Walleij
