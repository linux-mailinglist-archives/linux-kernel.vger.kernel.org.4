Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B528A6166AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiKBP6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKBP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:58:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848FA2B634;
        Wed,  2 Nov 2022 08:58:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x21so24248832ljg.10;
        Wed, 02 Nov 2022 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxrpJJ0/0vnVYdAZjE38mJeVD3TgThnRraSG3AuzU+E=;
        b=MGwWCwMTVi8h/OuAkw2JkJ2WSaW6A4X9ZAQXUnCDCfN7fs+SNrAo9vCsUwRJ9ozebK
         coZQuFNSG4u1WQzIoeQxL8vd0rS/PmXrey49+pBPVSs+iEffvKwz0clU37UIMdAPIBS4
         cYxFn4h35MK/yMwWJG37k++17NxGKbnT8ueDsV/+xOoGWkLB8yfKbpod2skcTJpTBQji
         jFAUakAe40UgEH0hvBeFvvROiJpCp+cXo9eevyPR8Cf0+kf4MEa3ouqNVc1039O4dZPX
         tymeAA4ODop9+tmVb+IqL9gPk4sdPa3DTSytO2GphAGM67YMmO9RpcGQPtdOD8+lB16M
         xYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxrpJJ0/0vnVYdAZjE38mJeVD3TgThnRraSG3AuzU+E=;
        b=aRa+/ygVQMeSU4gq6AcvMmfGXEFw5c/DPeXkqYwrQ+P4o2wWDotPHIM0MCFUbIk4Cr
         hOOHaGY1f46rn47SL+bJ8ByIfgvWcCHhNit1rVjw5RkJwT55f6WQpgjzp+ObzsdRX2HN
         tF6SYg9Hw6RhTp/OobhDxNMXvoNJpIOi6S91F3sZEnKjABt/mEBoRBwIxx5UNc4g9ffH
         cLXIB5fgrR+NZXHBaMJUE29ov3TaNMp/lzrf9Tn8EWehvYZjPnowgFqmOHtBDuoqfNwC
         0IJx1fg2JDSbetVpObDtByqaxPjeNMTCbDoyQHKEI1JUzvt58sE+iBUMur2xMcgyj3iX
         2k6w==
X-Gm-Message-State: ACrzQf0yAM95ediQz9X5BGD18a92NpUgv3ie7DkxVlXUIxjf3Fp6CASv
        0NDX3kxtgTjujW1XvxXxJDBfdcS+AWH8axn5sd8=
X-Google-Smtp-Source: AMsMyM60gGchkEkwbirb8r1GfQPxQal/ndKoAXVepiKC0Yw/FUgLWjK1pSoep9a8s2ddsmH1W+2WWacIUvHNV3W188w=
X-Received: by 2002:a2e:834b:0:b0:26d:e1f8:1453 with SMTP id
 l11-20020a2e834b000000b0026de1f81453mr8946318ljh.65.1667404690835; Wed, 02
 Nov 2022 08:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221102141513.49289-1-fnkl.kernel@gmail.com> <20221102141513.49289-3-fnkl.kernel@gmail.com>
 <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Wed, 2 Nov 2022 18:57:59 +0300
Message-ID: <CAMT+MTT1ptFymwDdOe=OXYzKfOPHdQbAfpx_9LBYn+C9NFhddg@mail.gmail.com>
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

On Wed, 2 Nov 2022 at 18:33, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > +     clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > +     if (IS_ERR(clk))
> > +             return PTR_ERR(clk);
>
> What is your use case?
>
> PWM is configured by bootloader intially??
>
> Or
>
> PWM is configured by Linux not by the bootloader?
>
> Or
>
> Driver needs to support both ??

The PWM device itself is configured by linux, but the clock it uses is
the systemwide 24 MHz clock, and that is configured by platform
firmware.
