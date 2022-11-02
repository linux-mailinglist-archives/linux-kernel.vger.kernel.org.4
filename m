Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15A5616991
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKBQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiKBQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:44:46 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDCA5FBC;
        Wed,  2 Nov 2022 09:41:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b9so10793050ljr.5;
        Wed, 02 Nov 2022 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmabQ6QIrPhC6gHbbbnIOeOPPxHLqb9/uiOG+55mjHA=;
        b=EHXyQjGjv+nNN+CsohFOura4RO576Rjv0DVdD2nvgit2YYAI9ZuXI30zP8hsJMsetM
         P+KFkGBH7LdzTUn16idjtEATjLbO3ah88mFwF2yeRSmI7Vx877Ixlp/UxXB7vFNmNitw
         I90PzzpQF+JADtng9we9CUcvh8PI4eJtVMAhUGliOPARXfEkpGysY/UXKJtH4YPkVBlR
         Xu9KTK4FVR+J8Ok9hqSyUBCI+8stYzJ/OrjiZddwXFYHcW1Qk+1wlFUQiXpmM2e73TUu
         4MRFv/91gaXZxTds9QUXWoUVFPrhvWfR4O77n99gO0tPKUjDuWCYAZkW6/8T6vf1FtGO
         /RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmabQ6QIrPhC6gHbbbnIOeOPPxHLqb9/uiOG+55mjHA=;
        b=uychgPNBSxIaSY6UNZmM2ygvBfyN0v5TiZcnSq89ChZ8Ez1zt2ttsrupAJVHWGHNQT
         jN3jKH8AnyTyDCE2GcOHQk0aEh4OUvXTTv0D7ig9fm8tg1nicToroEX3vgtBFkrqFoDV
         lMh9zeMkK+piHLlGCKYkv3j2NLo/SpjktcTYMZmbbENrzA97s3FPl/whH4BotsA5bBzR
         eZ5FqPNhPJHZHXK77ChrY7YaMXUZpUGNENidiVX5xuw7Q1BsDUxFAxxRd4VA/zGs8phd
         KGDjNvtfJXjknVPrxV/JGCQfRtAC6U7DACYFTmiZIyzhy+svuKOoYEOFrtmN7lD/iK6j
         S6IQ==
X-Gm-Message-State: ACrzQf2uBaVjJPfh35GXrRQ39fY3+9ABwEHqdNe1i/NJUWFgNSUsSkYe
        ze8bdqoTEh3ig+YOJ3GysoO//XDepw9z6NfGc9c=
X-Google-Smtp-Source: AMsMyM50B4ChTwri3pNUdk19+lDukowim5+VjCFJbaPQpHVCNpnBCROgFwgMd33+grSqlAzw939nkrL9s+SZ1N04mtw=
X-Received: by 2002:a05:651c:12c2:b0:26c:13b9:a694 with SMTP id
 2-20020a05651c12c200b0026c13b9a694mr10190419lje.79.1667407266631; Wed, 02 Nov
 2022 09:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221102141513.49289-1-fnkl.kernel@gmail.com> <20221102141513.49289-3-fnkl.kernel@gmail.com>
 <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTT1ptFymwDdOe=OXYzKfOPHdQbAfpx_9LBYn+C9NFhddg@mail.gmail.com>
 <OS0PR01MB592217539BCA46FD8F523C2386399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTQLJZsDSOtcQqV8e_j0XKfjNm+dVjeo7ocMjcYOPLAPvA@mail.gmail.com> <OS0PR01MB5922EC4F1AF0D8501D7CB1BF86399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922EC4F1AF0D8501D7CB1BF86399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Wed, 2 Nov 2022 19:40:55 +0300
Message-ID: <CAMT+MTT+Z=K7BNq=KWGxaT=x9BOfdDecsZ6E7eGhjN5OHRjy=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pwm: Add Apple PWM controller
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 at 19:29, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Then enable the clk whenever pwm is enabled
> And disable the clk whenever pwm is disabled.
I can do that, but I do not see the point in doing that. This clock is
active whenever the system is turned on, all this will result in is
some unnecessary clock refcount increments/decrements.
