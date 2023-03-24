Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24D6C7B86
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCXJfZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCXJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:35:08 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2A12CD2;
        Fri, 24 Mar 2023 02:35:05 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5418d54d77bso22546097b3.12;
        Fri, 24 Mar 2023 02:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miXbgzLmIT8TbuaHosYV2bM+7farboHCB6roIPdYqKY=;
        b=tWRfBuAGQ4FZXEOppKNgU//wOH04r3m2a3h/CMm8nPdRamd/5ZhmaGTw4Z4ywnuPAm
         em+zcDLfm4pHnTxdQVOMbqIPnK/v5/U4IbvLgMDW9N3qIDcJ/n+pMs8J9L+Ew8h/Z4f1
         h9PzNr5d0SOh5nUVa3EhzNVHtzC3W3giE59rjhtF6o6N0R7tpHl/kEPFLYy4FnlObkTr
         aPaM/5RcoVhg4CF0IcAk/RKgX+GZZ5pIob74uRfUrq6DlLZ3bMwahrQADg9UG2Xd+Eli
         GYM3kAYn9l6IhBWD19qSEs0A1xF5noRdRM8unK/Z2PNanbDUonUlc94OABQ9+wQ1QTzV
         r+Qg==
X-Gm-Message-State: AAQBX9d60xJevG6WfU78WbPtGOXIrlt7n1i4Mx+6yciBxiAk7N15cMGC
        BAcAEXC2a8nw2IACTyZ3lohQWJMgM+fpbw==
X-Google-Smtp-Source: AKy350Y1F/blRqW6RxndPKHPONwSbG6jp6vKMUAcEFQVPZE+cmaK6QXZ0Ea8Fa5Qog/lPWUF9KzhMw==
X-Received: by 2002:a0d:d9ca:0:b0:545:60c5:ad88 with SMTP id b193-20020a0dd9ca000000b0054560c5ad88mr1501572ywe.43.1679650504477;
        Fri, 24 Mar 2023 02:35:04 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id o63-20020a257342000000b00b7767ca7466sm345705ybc.3.2023.03.24.02.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:35:03 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p204so1368928ybc.12;
        Fri, 24 Mar 2023 02:35:02 -0700 (PDT)
X-Received: by 2002:a05:6902:10c3:b0:b75:9519:dbcd with SMTP id
 w3-20020a05690210c300b00b759519dbcdmr979907ybu.12.1679650502403; Fri, 24 Mar
 2023 02:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230323185112.13855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230323185112.13855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Mar 2023 10:34:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVKRS1N5s-cvxrgSj9ev-Hh+gxfa-Hp2+z1zt+r7fEUWg@mail.gmail.com>
Message-ID: <CAMuHMdVKRS1N5s-cvxrgSj9ev-Hh+gxfa-Hp2+z1zt+r7fEUWg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Thu, Mar 23, 2023 at 7:56 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-ostm" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>
> No driver changes are required as generic compatible string
> "renesas,ostm" will be used as a fallback on RZ/Five SoC.

While this paragraph is true, it doesn't really matter, as you're not
adding a new SoC-specific compatible value.

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> @@ -23,7 +23,7 @@ properties:
>        - enum:
>            - renesas,r7s72100-ostm  # RZ/A1H
>            - renesas,r7s9210-ostm   # RZ/A2M
> -          - renesas,r9a07g043-ostm # RZ/G2UL
> +          - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
>            - renesas,r9a07g044-ostm # RZ/G2{L,LC}
>            - renesas,r9a07g054-ostm # RZ/V2L
>        - const: renesas,ostm        # Generic

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
