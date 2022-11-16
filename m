Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869962B553
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiKPIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiKPIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:34:44 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386EEF29;
        Wed, 16 Nov 2022 00:34:43 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id mi9so11453889qvb.8;
        Wed, 16 Nov 2022 00:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJK9b4B7NWAtgof3K5gbwAvDcs0xP62iIN8fCNsFCJk=;
        b=8RxxdvuBGtbhM2CGKbUq5wQQcC40IGXjF6b3nzQpm9ooy0hXhxNtOA+DvrvefL6ijf
         Vc8E/xx5kHuQAom2y98UPbi0G3YngvJGY3k8Nl8LUj+bbfNzeXKVmas/vmUamcV8Enhw
         jL2DHaUfFA9iZJUyFQr8eZodESmDgeRLtjTmE/rMpL179Kt5fPV0GNM5TOMtJFISW/Wc
         LmiB5vO4T0FTGSc1qIGovyOa+8qSfKYscncs1F3ui8Q+GLZoy1vHArJYAFvaC7IGeVeA
         zPpJzo90148YFaHJSpBKmsOrcyFXleYTWY6ijrE/bdAiO7mar6OQd5xtQ5kXiFxNDaZE
         UBzA==
X-Gm-Message-State: ANoB5pl0cuK7e/OnMF3aGzYiBf4uPXpncKJbLg70W+lpKGsqiAFC+1rz
        ITn8jjye+/kFnZZ+yjiTFC4l9vxHjXx/eQ==
X-Google-Smtp-Source: AA0mqf5aSw1ewdDDHXoaTchUWFQNPxoquCEmartcZ11rgaNikOEntsuHw/7C/GsDditnMKitGI2Yhw==
X-Received: by 2002:a0c:9042:0:b0:4bb:e74a:f63b with SMTP id o60-20020a0c9042000000b004bbe74af63bmr20387656qvo.15.1668587682148;
        Wed, 16 Nov 2022 00:34:42 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a444800b006fb7f94a65bsm4985318qkp.44.2022.11.16.00.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:34:41 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 136so4485957ybn.1;
        Wed, 16 Nov 2022 00:34:41 -0800 (PST)
X-Received: by 2002:a25:cb4a:0:b0:6dd:b521:a8f2 with SMTP id
 b71-20020a25cb4a000000b006ddb521a8f2mr19813619ybg.380.1668587681340; Wed, 16
 Nov 2022 00:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
 <20221115192625.9410-2-alexander.helms.jy@renesas.com> <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
In-Reply-To: <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Nov 2022 09:34:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-tziOhCLi-_s_MjPcHr4OW9=xA9xDVgf+fUya1R6TzA@mail.gmail.com>
Message-ID: <CAMuHMdX-tziOhCLi-_s_MjPcHr4OW9=xA9xDVgf+fUya1R6TzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dtbindings: clock: Add bindings for Renesas PhiClock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alex Helms <alexander.helms.jy@renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Nov 16, 2022 at 9:20 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 15/11/2022 20:26, Alex Helms wrote:
> > Add dt bindings for the Renesas PhiClock clock generator.
> >
>
> Subject: drop second, redundant "bindings"
>
> > Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> > ---
> >  .../bindings/clock/renesas,phiclock.yaml      | 81 +++++++++++++++++++
> >  MAINTAINERS                                   |  5 ++
> >  2 files changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
> > new file mode 100644
> > index 000000000..2b36534d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
>
> Filename based on compatible.

Looks like there are more of them, so I guess the family name is fine?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
