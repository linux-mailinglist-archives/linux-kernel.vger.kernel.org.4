Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE0698999
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBPBDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPBDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:03:46 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D222025
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:03:43 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-52eb7a5275aso4363027b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6sbx1hW5VzBmek1B42kG2jNw+TNnTEb8gapatcR73rQ=;
        b=IQdPhHQWN1Mt145dmwZHfSnqOTPplWy+0Uh7hqLuKSPHUyCNzYh9Ei5+6VQdLmwPUl
         W/P38BNiBRxJb1Kc6k5wIR8xvIP3ouuwAc1RfVjEoMBK0+GlSJtvkKJMzaX44waCvn8w
         sG7/gDMZlZmC5As20/72/ZFwMYmR5PY8no8ko6AfUnaso85NG2rC2VkMuvS2MbVKK/rv
         rgbp0vQ4C3b1/cP8Nra/1Wt+ll0E4EiJ/uML2YavzOwBrRIOhAcD882sC+f+WoxVAnBw
         d9OYLVFfkmsD2P+TJomOjLWQpKimJNdfKKaUnCql6eYdNOW93J6THqnQtH2lNJz8Eu5i
         tZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sbx1hW5VzBmek1B42kG2jNw+TNnTEb8gapatcR73rQ=;
        b=6q3Hm6jHxfWAefmgNnaa8vivsrJwm3NLe11+ZkCJkHuA/Ol0jiWZyuY7HU+GsICtm3
         DpJTnbW3NQNjB0/N2nNCIdikE+PET28Y2i2SXB8obLtDpGRhP/Ktk6l7ErQqaDlja9US
         wRCZfAxfV9r6IJ8ZNTuXS1uhUjyq8az7V1ZDDP3gSjRwoR2qWZbliFhNKfR9kaZL3one
         bcz3+jsJ7CYr1S9TALkrHj7AtdCj7Tid/Vku0MuSvJqTRKn1SrP5+bvr0odL+Nv+Klxy
         C/LOs1ezGhZYBjvCm/VJ1BxuLRw2WbNaipRiWGmx8CyA7AflOCsnCvrRting5ClN8bnO
         pNmw==
X-Gm-Message-State: AO0yUKV/6mXbKGniq8v4VrBNp7Ox7I0I90+23rgte7lrrh7fr70OVMhu
        RuH3F17g6HdP6mnYFd/qraIug8EB7iWMfA6Znim2
X-Google-Smtp-Source: AK7set/a3D76VIQ6uqfP8dSDpe3YyTWLZcyOkqHzXDV7Vwy5x0vpX70x8tNd4rZXaulxq3wMQpKOAhQ/ron9T2BhAaQ=
X-Received: by 2002:a0d:d346:0:b0:52e:fb6b:fd61 with SMTP id
 v67-20020a0dd346000000b0052efb6bfd61mr510219ywd.271.1676509422706; Wed, 15
 Feb 2023 17:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20230214105412.5856-1-walter.chang@mediatek.com>
 <20230214105412.5856-5-walter.chang@mediatek.com> <20230214222021.k3tsfwezhnh7tdlx@bogus>
 <996b4e61-8486-d939-7367-1240b3c5c5fa@collabora.com> <20230215131849.mcgz53jf24atialp@bogus>
 <53f0e612-b5cc-262e-df98-add1e8a06573@collabora.com> <20230215144627.ddjc7x365qdnhymi@bogus>
In-Reply-To: <20230215144627.ddjc7x365qdnhymi@bogus>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 15 Feb 2023 17:03:30 -0800
Message-ID: <CANDhNCrWh2=0758eObCKzHmAzqWMsn7EUV9FhEPXUSnCze_Kcw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 6:46 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Feb 15, 2023 at 02:30:51PM +0100, AngeloGioacchino Del Regno wrote:
> >
> > Both. I mean that these platforms do have architected timers, but they are stopped
> > before the bootloader jumps to the kernel, or they are never started at all.
> >
> > Please refer to:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/clocksource/timer-mediatek.c?h=next-20230215&id=327e93cf9a59b0d04eb3a31a7fdbf0f11cf13ecb
> >
> > For a nice explanation.
> >
>
> Thanks for that. Well then I see no point in making these modules if you
> can't have generic Image that boots on all the platform. I now tend to think
> that these are made modules just because GKI demands and it *might* work
> on one or 2 platforms. One we move this as modules, how will be know the
> Image without these timers or with them built as modules will boot or not
> on a given mediatek platform. Sorry, I initially saw some point in making
> these timers as modules but if they are required for boot on some systems
> then I see no point. So if that is the case, NACK for these as it just
> creates more confusion after these are merged as why some Images or
> even why defconfig image(if we push the config change as well) is not
> booting on these platforms.

Indeed, if some hardware does have a hard requirement then the
timer-mediatek driver probably isn't a good candidate for being a
module.

Though I wonder if it would make sense to "virtually" split the driver
in two? Have one config for hardware where it is safe to be modular,
and another for the problematic hardware that forces it to be built
in?
That way we can support the safe approach (ends up built in if both
options are selected), but for GKI devices where the hardware isn't
problematic we can still leave it as a module?

thanks
-john
