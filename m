Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF93665BE3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbjACKev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjACKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:34:20 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691963A3;
        Tue,  3 Jan 2023 02:34:19 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-482363a1232so275902617b3.3;
        Tue, 03 Jan 2023 02:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t19P5UcE/4UM/S5+JXHqpyjxdneSdlsyt/VQt2DY6Ks=;
        b=kQ/nO1vj6eMp0O4pkHcByioEj5/lTYxW2bAauM1KB6IJb986v/qFlVQW5ttLGJaECs
         cK9sBcbmKqtegswKo8ULP9ImNTSbqMszxwrXUe2NOqDbFTBrjitbcuxzxYCeO6eYURg7
         TtsHbHL087ADMze9QggOw/u6rrINuTpCUlyAjDgksmNVDi2XPx7wPk1JBZa8UUeXkmdF
         rIJCXeIl6UadhI2ev98B2XuN6HtuVUlTPxUNhEZ2nIpKPg9B7SLxa2HVVwSwiQee4SNr
         J37i97dwcOBOP14sRS6pzkuhdXIRKxS5DHqe2A0/aHRcvJDV3UvDGyNrPWjdvyjYRbJL
         5q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t19P5UcE/4UM/S5+JXHqpyjxdneSdlsyt/VQt2DY6Ks=;
        b=XbYZIf2Zyr76v0IpVGBdxJmg73zor9CYJNDD1X6wBTAsj4EafpEIVAEO5AVBWSgRCk
         4hI0OT8mCoVSKCGwrFdzR36NSIO9hToDgJcyrt5uePpfSwevGH5v2BZsb5ZPvoax2NOy
         p012VweUFJ2pcKnwN3ci5gb37gR5TGhh/N+nm+CWlcTL+bx9tEgfsTdWixem4SkD/fed
         mXNj59EtUQ8M3AFn6YwFpLNZOheAKUbjrS2blmNWLCT+FxxhpTWabNYkOt5dhiZ7jGEK
         tPbida0mMzpY+Kmynyck1tMrfKHvkOG+imtx7xZiIFBlrsEeDwHgodUnpdcTiJTIQrnB
         zsBQ==
X-Gm-Message-State: AFqh2kp+NDj53DwbWXlYJwxU6RccYWQv+c9qZk+JT97dL7Vz51tlthkD
        2LCYM69vPqOOx9veEyQYe3ymabrxng48r+yV500=
X-Google-Smtp-Source: AMrXdXu2Bdi9N02+3VSRATUKReRZKvtq/GJY0qI5z0wZN/Sm4iqFZ8LhA6JAdHyuQ90ML7KraQFrsu4ezT4dC+J31SQ=
X-Received: by 2002:a05:690c:f86:b0:4ab:352b:6461 with SMTP id
 df6-20020a05690c0f8600b004ab352b6461mr405001ywb.309.1672742058278; Tue, 03
 Jan 2023 02:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <170665b6-161a-6dd0-6ceb-199277c0ce2f@linaro.org> <CAMuHMdV0D8kh3xhKpWOUjTa9MzC3jEDJ5evKAJD6hV1w+pMBZw@mail.gmail.com>
In-Reply-To: <CAMuHMdV0D8kh3xhKpWOUjTa9MzC3jEDJ5evKAJD6hV1w+pMBZw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 3 Jan 2023 10:33:51 +0000
Message-ID: <CA+V-a8sewZTzj6GQt0pHifdNik0v3mmrUYU2W5z_gMztqb78aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: interrupt-controller: irqc-rzg2l:
 Drop RZG2L_NMI macro
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Geert,

On Tue, Jan 3, 2023 at 8:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, Dec 29, 2022 at 9:46 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 21/12/2022 01:02, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > NMI interrupt is not an external interrupt as compared to IRQ0-7 and
> > > TINT0-31 on RZ/G2L SoC, so there is no need for RZG2L_NMI macro.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v1 -> v2
> >
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Given
> https://lore.kernel.org/all/CA+V-a8vb-PfzMWX=ndF8nsyYVbkfYBkAQZ-UoS9zpQPndL871Q@mail.gmail.com
> I think this patch is planned to be dropped, too?
>
Yes that's correct (and I have dropped in the v3).

Cheers,
Prabhakar
