Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D65FD552
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJMHC3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Oct 2022 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJMHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:02:26 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34C8EC508;
        Thu, 13 Oct 2022 00:02:25 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id a18so604835qko.0;
        Thu, 13 Oct 2022 00:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFBaFZ7wolEO3qxhb8a8NTy+t9VBo3V4xaw2Z47Lf1s=;
        b=L3tOdsVb+L/1POZfeJkWDtRKL7xfWX0F32Axach71uU/s7Ph9sv3U3ykfsFXXWEB//
         uT0NJN9hmGX0W2iY/9oixxt88U53m3dJSgPmCxR2xwpaFlydFHj5qrdHCCjtgUZBxLCs
         5RZl+PmchiPRVGGeLavQwq14+WoGoT4TZVqXoKQE6C9NgF4LtRPIyekQJKPbI7DrqEOF
         Puv2b9IcMTOVbLWWsm9xBFIEKFcN6PRrJPKYsRgOEpFnTWxqs0m5EoDu1cT2c/FUiwgf
         hreMhbbC0SswMTlJtO1zchjRi9PyK2uV+AbpwFkUhbSkXk8c3jvB4lfaV3v7fyeAwKe3
         iuCQ==
X-Gm-Message-State: ACrzQf0jegxhDDq16N9oTiOYHfmgd4ADkHRyuQXOGQoA7zc9OSa81QH0
        SOVsPeo43tPW4Xbp+uy9pHfsoC0F5ly+Yw==
X-Google-Smtp-Source: AMsMyM4VH64S8ACfmdrDYIm9b982nJK440VCmPN4xJRJlHYLOSrhjqqoFK063HKkbKpLwG8BHia/2A==
X-Received: by 2002:a37:be86:0:b0:6cf:b1aa:7476 with SMTP id o128-20020a37be86000000b006cfb1aa7476mr22699840qkf.715.1665644544854;
        Thu, 13 Oct 2022 00:02:24 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id ay11-20020a05620a178b00b006bb78d095c5sm16746965qkb.79.2022.10.13.00.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 00:02:23 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3608b5e634aso9441637b3.6;
        Thu, 13 Oct 2022 00:02:23 -0700 (PDT)
X-Received: by 2002:a81:5a57:0:b0:353:6de6:3263 with SMTP id
 o84-20020a815a57000000b003536de63263mr29669742ywb.358.1665644543462; Thu, 13
 Oct 2022 00:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <c268cb4497cbe79773bb6568f36c37adc6fb5bbe.1665582645.git.geert+renesas@glider.be>
 <Y0cPpJin64ou4ivI@shikoro>
In-Reply-To: <Y0cPpJin64ou4ivI@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Oct 2022 09:02:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqp6J8PZOx57tGpKZKxQBY_bkU7b8Kiqu9DNjmj2vCGg@mail.gmail.com>
Message-ID: <CAMuHMdUqp6J8PZOx57tGpKZKxQBY_bkU7b8Kiqu9DNjmj2vCGg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car V4H support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hai Pham <hai.pham.ud@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Oct 12, 2022 at 9:04 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> On Wed, Oct 12, 2022 at 03:51:46PM +0200, Geert Uytterhoeven wrote:
> > From: Hai Pham <hai.pham.ud@renesas.com>
> >
> > Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> > R-Car V4H SoC.
> >
> > Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks!

> What about moving V3U to the new Gen4 section?

I actually wrote such a patch a while back.
However, I didn't send it after discovering the R-Car V3U Series
User’s Manual Rev. 0.50 does not mention the fourth Strobe Timing
Adjustment bit (STRTIM) in the RPC-IF PHY Control Register (PHYCNT),
which is present on R-Car S4-8 and V4H, but not on R-Car Gen3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
