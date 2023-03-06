Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4E6AC8A5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCFQsB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 11:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCFQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:47:37 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C75211F1;
        Mon,  6 Mar 2023 08:47:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s12so11188440qtq.11;
        Mon, 06 Mar 2023 08:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678121109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvViXneQW0Y0NLgAFFQaV/kY8HJotQKpErXAhKId1Yg=;
        b=gtIyHwFHGRKNHMB9aPCa4szwpRkGGLSEbcz+tN0uXgnrp87hPAniTRG72ZPZm9waU2
         ctRK0+z0kwlN5xBYmaWgYTnnnRiSUnn5fnak1iCizfUQYF7H1oDFlRyRmzSGC4wSnIv+
         Ib5VGLGzcOq34CIAsEY4V0QSntYko4LTs8P5OR4xaSFNqofvxuprspi2ROZIyDDuSB5c
         NevY/XkhsetoSOp7hWFe/9Aoc0i4IqsG0NomFkVXaMeQxlE8UeoL/o1q+TOo/tB6Oxkw
         kHCMpj3Xymq1/GD0h3tPhBJWkvi0tw0VoEN5ovbCN4NKl3rTzAJGRqEzKkIZU+KSZKpF
         fKjw==
X-Gm-Message-State: AO0yUKVnrkN8A7H0g0wsJ0FtwXEeLLZMmLy/HXQkmL7KFuI1LK4Jvkru
        mPTW7cumUUp0zL8KgrkTcr+ilDyZz/J0yw==
X-Google-Smtp-Source: AK7set8a7d6K2pBd8zdb2FExPiIjZFF6sq89g9Mhl3mhcmpUfZgdEgjMKNgrqQe0csF0/3ITZyaNVg==
X-Received: by 2002:a05:622a:206:b0:3b9:17d7:66f4 with SMTP id b6-20020a05622a020600b003b917d766f4mr19711213qtx.11.1678121108736;
        Mon, 06 Mar 2023 08:45:08 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id p188-20020a3742c5000000b006fed58fc1a3sm7778914qka.119.2023.03.06.08.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 08:45:08 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-53916ab0c6bso194643897b3.7;
        Mon, 06 Mar 2023 08:45:08 -0800 (PST)
X-Received: by 2002:a81:af4b:0:b0:533:91d2:9d94 with SMTP id
 x11-20020a81af4b000000b0053391d29d94mr7137846ywj.5.1678121107857; Mon, 06 Mar
 2023 08:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230216175347.99778-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230216175347.99778-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 17:44:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWh-nt7gMbfLOCNx79BrThAF+DqU6fKrQaqE+OHqcHQ6g@mail.gmail.com>
Message-ID: <CAMuHMdWh-nt7gMbfLOCNx79BrThAF+DqU6fKrQaqE+OHqcHQ6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 6:54 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add CSI and CRU nodes r9a07g044 (RZ/G2L) SoC DTSI.
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
