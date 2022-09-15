Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4505B96AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIOIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIOIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:51:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB58C03C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:51:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v16so40471124ejr.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pVEAPr9uFJXoigY4S3Caia0V9hvOwsnD7u1cGE+06fg=;
        b=lQ3J36OOZC+3AWHtJgFIWkMKS2XenwMASaLdlbMcfGiHgwBZPp4D7FdJA+OItxRkDb
         Js/Q03BFOS1N3FBMZogWUbgVzYhdy0UremJzkm3RxoeVIKUJkg2XthrxPq8oquNl3MdN
         0o8wYJ+w6/u8wZK9GhZeyvUkd3l+PklON2jOefy+wvlfK2xkABNacMpczhCkYQIrJkQD
         labgVa0aoMtnvT62KbzBqwzSu4FkNyOOnVXnqYMYe7vkqZsfz9uysFTEbeZuqmK2EpwO
         L6oBZ6RqC+bpKpYyRS6whdkA0bWnOUfLZ1pP1S4wpmj0HXEW9ogvtmRaXtV5ZUgqFrey
         rKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pVEAPr9uFJXoigY4S3Caia0V9hvOwsnD7u1cGE+06fg=;
        b=D98y2znrr6jNGBGgM82RLGExxL+LHy2OzitWXsc/QocQzXI/SN/eJ/uLYTD0GLBAXT
         GAcSciNUUceUegzAEshDUPYiVwpEicSLLdnbmcIyo+faRhMrlMB9Q9/mvIykCZPA+POR
         uhh3ni8cLfAND8ixpcpaww0t4IybPNpqEkZhgrBimaK0OfLcmEjk0lE03BibfM5JHQMH
         J4LueeSP/FrUy2EU5BN2IDYdOF1P7rCijuXc8sCcf20PmZne4UD1QjskcTo6hK3q77Wb
         ra14+vyCE1Dpny8KwbllXs13WK5jSTuF1CSuFpTjouiaWJmBatu+F4gIWIKZm7RJstxb
         9Jsw==
X-Gm-Message-State: ACrzQf2Zeiy+ydY63piNqY8g8igRk+lJq3Tfv+kdmRxXzPSFgyZ3nJov
        S+O2D2KVA1ktHvZ3seya4OwKqEfekihVyorwFKlUUw==
X-Google-Smtp-Source: AA6agR5IIQ8Zwh5tQ7qnWm4dlNi83Gdb5MN9DKY6CarxNu1pm/YdJDXGPnF2czFgQFPqDbWv3OpyIQ3aYY//Ztdh3zM=
X-Received: by 2002:a17:907:7f19:b0:780:375d:61ec with SMTP id
 qf25-20020a1709077f1900b00780375d61ecmr4696000ejc.203.1663231874698; Thu, 15
 Sep 2022 01:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com> <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com> <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com> <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com> <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com> <YyKMsyI961Mo1EQE@sol>
In-Reply-To: <YyKMsyI961Mo1EQE@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Sep 2022 10:51:02 +0200
Message-ID: <CACRpkdYB6dZf4TBhfXB2Z5E2PJ46ctAM_QKLiW-fykbCopcVGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 4:23 AM Kent Gibson <warthog618@gmail.com> wrote:

> After sleeping on this, I'm even more in disagreement with renaming
> value to state.

OK let's not do that then.

> OTOH, I totally agree with the addition of GPIOD_ACTIVE/INACTIVE to be
> used for the logical cases, and even a script to apply it globally.
> Ideally that script would change both the calls to the logical functions
> to use ACTIVE/INACTIVE, and the physical to HIGH/LOW.

OK we have consensus on this.

> Introducing enums for those, and changing the function signatures to
> use those rather than int makes sense to me too.

Either they can be enum or defined to bool true/false. Not really
sure what is best. But intuitively enum "feels better" for me.

> Though I'm not sure
> why that has to wait until after all users are changed to the new macros.
> Would that generate lint warnings?

I rather want it all to happen at once. One preparatory commit
adding the new types and one sed script to refactor the whole
lot. Not gradual switchover.

The reason is purely administrative: we have too many refactorings
lagging behind, mainly the GPIO descriptors that have been
lagging behind for what is it? 5 years? 10? GPIO irqchips also dragged
out for way too long. We can't keep doing things gradually like
this, it takes too much time and effort.

I don't want any more "in-transition-indefinitely" stuff in the GPIO
subsystem if I can avoid it.

Therefore I would advice to switch it all over at the end of a merge
window and be done with it.

Yours,
Linus Walleij
