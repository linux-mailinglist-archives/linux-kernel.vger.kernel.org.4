Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268C67B185
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjAYLgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjAYLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:36:31 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B1258641;
        Wed, 25 Jan 2023 03:35:57 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id j9so15649474qtv.4;
        Wed, 25 Jan 2023 03:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejzSoPv//2BrN2itrhbWUE40xmPh6nFeov3ON6JEzvY=;
        b=6JDdss3iVd48WMF9dc4F1nb10W6J/+qGJvp/cIlU98qmjEOoVkS7oObARt5O0OQWCn
         q9/rxm6j0+wFT5VdOPtLsfdLfUS3UrYX2mwK7JPHLkiCR85ULbdBvbaPdl15CtnBbl1q
         hDntv9P9ddCjPqmeP4kK5Xx444gw7XnS4L8LcPNiESSH9GqMs+OuovQj2WNjM0x6Sk7i
         VvvEFT/6Yu3srPo1TLgIAI4ja+UzVhP2YOR4i/eiwHvM389UX+cUrp3GlB2fC+7NLgE6
         ePA99h4TG492XrymRlUMFKz60eAnlseBGz6kN/P4kRHlTlCZQv45iUVFb7AiHywcdecr
         YaGw==
X-Gm-Message-State: AFqh2kqds6WBz8Hdj05esflQOchnmiCadHP8C/+BQ2sC0iQgvclLqGwa
        jdL2R6s6Ng3XGSKCtbUvUM1CUuf44NE2gA==
X-Google-Smtp-Source: AMrXdXvDVfa/2m88rYrm5zX8Hs1kQ7jaHu3Z7lbf/8wAC4hoHNuPvNhujQCJGln1wAWMYbgC38YpxA==
X-Received: by 2002:ac8:41c8:0:b0:3a5:27f6:4d4e with SMTP id o8-20020ac841c8000000b003a527f64d4emr46264152qtm.65.1674646531612;
        Wed, 25 Jan 2023 03:35:31 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a07ec00b00706b42c0842sm3301650qkk.49.2023.01.25.03.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:35:31 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 123so22585938ybv.6;
        Wed, 25 Jan 2023 03:35:30 -0800 (PST)
X-Received: by 2002:a25:ab30:0:b0:80b:8247:e8b1 with SMTP id
 u45-20020a25ab30000000b0080b8247e8b1mr395854ybi.604.1674646530622; Wed, 25
 Jan 2023 03:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230102221815.273719-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 12:35:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-eB4_cmnTNhj6z55SL+fLhR+2+s+NOBxG0d6h36kSeA@mail.gmail.com>
Message-ID: <CAMuHMdX-eB4_cmnTNhj6z55SL+fLhR+2+s+NOBxG0d6h36kSeA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: renesas: r9a07g043u: Add IRQC node
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 11:18 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add IRQC node to R9A07G043 (RZ/G2UL) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2 -> v3
> * Used "renesas,rzg2l-irqc" instead of "renesas,rzg2ul-irqc"

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
