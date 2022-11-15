Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D999629962
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiKOMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiKOMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:55:37 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FE2C7;
        Tue, 15 Nov 2022 04:55:36 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id l2so8599706qtq.11;
        Tue, 15 Nov 2022 04:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nWTUZBps9Z4pbhdUToWGjZ9Vj80wF5upKxd2gOYqwA=;
        b=m9/fEZ+aE2x4qFzmtPl9rd7ar8LSR752TgbBIsFDVOqNv+jtUF85vrdVx2AaIoNeMz
         bG7vn116ehVNDWhPh/HfTrEEcCmUVQUhMWLt24I0CvZ7ASM6ErnZs/s4acsjb8wcnv+H
         +xb8WUFJXElK+blg4BmCxAvQ9/McmTUH99x/gBeK9FQOq2s211nBWGium4WxEofvQukm
         f4xSs2OaPNxjoS1/cpa/B6kf3V6NOcCg05idrclX6WXTW1Bte/JnV+FIWewn2PkDzL1q
         2VKDB0eXol7NmZJfuLIs1uY+nczlUs9icBxATd0mwpQ7A3WVz4z4DfU0OhwnDmrdeHMg
         s3tQ==
X-Gm-Message-State: ANoB5pm1NtMN+DkFPG1En6OuXCzIbVqHrUFSNelG+lZI1uRkzedOoM+A
        d7t0IUReFme/nMp1CDTGTAUCY5WmmtnP7w==
X-Google-Smtp-Source: AA0mqf6v+6umNkgxSkGl9iGFvbVu+vDwLgCbqBtaSI0Tz70TDq7ufQQOamEga6FOf8Vb3fI0uCjePA==
X-Received: by 2002:ac8:444b:0:b0:3a5:7d:3657 with SMTP id m11-20020ac8444b000000b003a5007d3657mr16314259qtn.500.1668516935837;
        Tue, 15 Nov 2022 04:55:35 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84b47000000b0039953dcc480sm7115805qts.88.2022.11.15.04.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 04:55:35 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-382f0906929so44610747b3.10;
        Tue, 15 Nov 2022 04:55:34 -0800 (PST)
X-Received: by 2002:a81:a085:0:b0:37e:6806:a5f9 with SMTP id
 x127-20020a81a085000000b0037e6806a5f9mr12150361ywg.47.1668516934534; Tue, 15
 Nov 2022 04:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20221115124128.1183144-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221115124128.1183144-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 13:55:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVexCsodZcsdb6xYULvJkGbYMLV99EfgFPSAHOp2XKFsg@mail.gmail.com>
Message-ID: <CAMuHMdVexCsodZcsdb6xYULvJkGbYMLV99EfgFPSAHOp2XKFsg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Nov 15, 2022 at 1:51 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The ADC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-adc" compatible string will be used on the RZ/Five
> SoC so to make this clear, update the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rzg2l-adc" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
