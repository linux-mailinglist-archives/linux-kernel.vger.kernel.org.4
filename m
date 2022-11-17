Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1662D4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiKQILq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 03:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiKQILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:11:42 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568996DCD9;
        Thu, 17 Nov 2022 00:11:41 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id fz10so642245qtb.3;
        Thu, 17 Nov 2022 00:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4parOYjCXkKKOyavCWPd/uYGoV22cew15gslyG1Z/c=;
        b=5eCOgi2abKtfLuMwvPV606QIHTeTJX2py7wq2fmWG4JBQDNrSdANA4wB5s08gzAHtl
         2EV7xk9089HWuTJ0AUicAjrbs9wxZg2MVzdFtzIqp6jOaMMr1kDsJqYUPuvFlQ4CsRfh
         iD0YoceeA96/gyypEIm0C/mpmC+Bc9NWr37KIBOflBzl2phS+7HOE3xYv4DS+5xleUJ6
         0Prgx1aS80QymWbrOlyPusdGiZaE2unTOq8rrrpmXMwTrvElzUov23jCc25wAcGuNOt4
         /FCmLdildRu/6cYRB05EXo4bgbTMhi7TB5Ho1f2/4jQjJJ5V8FN5WHihIuAk4Itzn/RS
         kHow==
X-Gm-Message-State: ANoB5pnpj8p6NOwRRjuIVVxhCK0Oh9ivindLxW3bwXu/O0Xu54yDPg48
        dxq0qGXWBjyyU1tFz+cu6lvSrTkWetTbVg==
X-Google-Smtp-Source: AA0mqf4wCrUtPzuGuZWUPNtG4wpG6d8tOl+GlBTTJCiKZVrNR5N3g4sKmJuTL+gDZF1sGlAllFicMg==
X-Received: by 2002:ac8:734d:0:b0:3a5:2784:f462 with SMTP id q13-20020ac8734d000000b003a52784f462mr1232098qtp.590.1668672700173;
        Thu, 17 Nov 2022 00:11:40 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y10-20020a05622a120a00b0039cc64bcb53sm40443qtx.27.2022.11.17.00.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:11:39 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-39115d17f3dso5509847b3.1;
        Thu, 17 Nov 2022 00:11:39 -0800 (PST)
X-Received: by 2002:a05:690c:b01:b0:370:202b:f085 with SMTP id
 cj1-20020a05690c0b0100b00370202bf085mr969602ywb.502.1668672699377; Thu, 17
 Nov 2022 00:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
 <20221115192625.9410-2-alexander.helms.jy@renesas.com> <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
 <9231404a-85b2-9a9f-f040-f97615bf8ec0@renesas.com> <6dc67c30-d9c3-5906-a2bc-263ac83df051@linaro.org>
In-Reply-To: <6dc67c30-d9c3-5906-a2bc-263ac83df051@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 09:11:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVoCVz7zyWvAbCydSGQ6RnRxH2kBFDyu-M-Fn8h_XicLQ@mail.gmail.com>
Message-ID: <CAMuHMdVoCVz7zyWvAbCydSGQ6RnRxH2kBFDyu-M-Fn8h_XicLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dtbindings: clock: Add bindings for Renesas PhiClock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alex Helms <alexander.helms.jy@renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 8:39 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 16/11/2022 21:11, Alex Helms wrote:
> >>> +  clocks:
> >>> +    const: 1
> >>> +
> >>> +  compatible:
> >>> +    enum:
> >>> +      - renesas,9fgv1006
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  renesas,ss-amount-percent:
> >>> +    description: Spread spectrum absolute amount as hundredths of a percent, e.g. 150 is 1.50%.
> >>
> >> What? If this is percent then it cannot be hundreds of percent. Percent
> >> is percent. Use appropriate units.
> >> https://jpn01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fproperty-units.yaml&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C9c13a32848f3434e217108dac7ab69f6%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041836281252737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=6MULpJhPyyjWSo1SvPCrz6KidE1VEtiiNYk1O5wS1vI%3D&amp;reserved=0
> >>
> >
> > Values like 0.5% or 2.5% must be representable which is why this
> > property is an integer of hundredths of percent. How else would you
> > represent a non-integer percent?
>
> With an appropriate unit.

Krzysztof really means the property should be named e.g.
"renesas,ss-amount-centipercent" instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
