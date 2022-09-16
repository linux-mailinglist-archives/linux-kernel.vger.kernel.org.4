Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA65BADDF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiIPNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIPNNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:13:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93329323E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:12:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so31458965edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hOaONVosDHKGcKcdd79IN/qOAa8ODfx3cQY74s6WQyo=;
        b=SU8nSZjp1VUobJqjGTpgJWn8xDpxg4WLlqHITE2oPUcXGUQCW2nmJXG2M1vDbfSiCe
         WZIS8pZTDnswXKVPxZSJfDtDySgNI6HVHKG5FxRJTJi2C9UE8K95MOSgEU66OsTBThYK
         t5FGkoPDYgYwZQ8ipe9IVumeWzSSnIoVLDoMKGXrSkWfyb7r4OkEdvq6u9vzrCyunVee
         ZZkDHLECPFY+cexVdh9otrCL0YQxfuOWGPi0vUJ6RT19aLWxVTbpPpRlxYOUhFURRTAU
         NUXvMqtchDqA638TTyluS9ya5BDcsXg8c/eeVo1TGHocmm2oejGupIGzEpluFA7bd7if
         8Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hOaONVosDHKGcKcdd79IN/qOAa8ODfx3cQY74s6WQyo=;
        b=dOXStGcviZ9GHIE46q7UVmldCviwldwjdYqURT9/prTvrO7Yc/y0fKGzJRuDrI57X6
         42gEwb635vgqq1cgjfyjwKsVyllTkjfUp4BcREsRguThJDZfhwNoiz13PTi7FgXXD+qE
         z1yc2pgqdPVsECMV6zGkA2F9X905rSdLzemFLDvnoLjWZU8DyY0os0p+UpndLWKOBdkS
         nFH87nmHaEqgCkRAj2+jCGxd9kfs5xY75f9Kxbcs21UxRaZW21daTtrWYiM8X8VRpJgP
         Z1/B5wR3QVrWKAAwAVcyhazThq0IcsMx8VAdBwb8bI7fZoLcLT1X+eBlmF7G4f2kTivy
         qB8Q==
X-Gm-Message-State: ACrzQf0d8j6GQjDNrxIc0SqdTELpBfqGbklxzcpO5ii0QS+YWLONDThM
        r1/ESI0K2fFbso0EIlgSl4BOswqDOT9qVIX7fm2BIQ==
X-Google-Smtp-Source: AMsMyM7jvz/MCPoNJ+YdiuZGmryTSHtIUn4Ti0WQr1gKjxtorbmEISu95NSdN5RA0PBGHZL1EpgY3sJqP/q/CY4WZ/M=
X-Received: by 2002:a05:6402:190f:b0:452:d6ba:a150 with SMTP id
 e15-20020a056402190f00b00452d6baa150mr3957922edz.126.1663333959316; Fri, 16
 Sep 2022 06:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151145.73253-1-brgl@bgdev.pl> <CACRpkdZaSL_pkmrVGOT-y7+3i4y6f6Cjgehycq2FKLwPxrbFvw@mail.gmail.com>
 <CAMRc=Me+srb_rwwaUxx1a=8+Wqm5sc2APzfCoFG3+QxRK5kEKA@mail.gmail.com>
In-Reply-To: <CAMRc=Me+srb_rwwaUxx1a=8+Wqm5sc2APzfCoFG3+QxRK5kEKA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Sep 2022 15:12:28 +0200
Message-ID: <CACRpkdZwsLM64m7xHgNg=FPqTYaou9=KpN2rckyp6sKiJokU7A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 9:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Of course we were not the first ones to think about it...

:D

> I'll read through it later. Was there any particular reason why this
> never made its way into the kernel?

Inability to drive through a DT binding that was acceptable for the
DT binding maintainers.

A good idea to get it passed I think would be to ask Rob (with some
examples) how he thinks it should look and finalize the bindings
before coding.

Yours,
Linus Walleij
