Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1E620F12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiKHL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiKHL2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:28:24 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302F2648;
        Tue,  8 Nov 2022 03:28:23 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id w4so8494067qts.0;
        Tue, 08 Nov 2022 03:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/iLxBgq1OWYwUohyGziSUBmXgb5XCQFFSkMcqIuixE=;
        b=MCPP4K4fwwLA7KkNTqWkGcfCWHOPoghnTHtq+ArI117qjy4eTYuiHQuHOJtbyUb1jb
         ELVPuZ/S17OAiUkS5PWfIj7kFIsGQqEkqZp5nLZ24117XP2RAX4Yb2duZcQDCGLhknSa
         ZUmbK87iF9lWHTOvDutkZ0VcIGrrckYUp5E44BKbAwtYdjnOWVpMIPan2nrV3axK+CyH
         oX5yyExxy7eYSY4dGsneilzu4ZvAauRJGqBMfXA/kVRZNuMYfrL4VAnUTnjb76anE2Z6
         /t0RrQm66+oLF2uAhMsh+atIGHBSAa+E3+VJf0zGjKtFTPN1Vz0juEsmmT5MQzmNmsE9
         Yi+g==
X-Gm-Message-State: ACrzQf29ZClDE52PC1IoRe+8LxbEv6lID6Rm47i2u3FxoTvlCeg+7mAk
        Z41SO2UGXOgpznsB3r68wu0UmL6RaHjptg==
X-Google-Smtp-Source: AMsMyM5DP5/XWz4w8rlLbXWZFO68uDqjkD/P5XsdeqcGhX07o8+okX5cC5BCxrjr6s0Z0g3H6kHvxQ==
X-Received: by 2002:ac8:1e90:0:b0:3a5:6891:3488 with SMTP id c16-20020ac81e90000000b003a568913488mr15978538qtm.49.1667906902659;
        Tue, 08 Nov 2022 03:28:22 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id q12-20020ac8734c000000b0039cba52974fsm7929269qtp.94.2022.11.08.03.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:28:22 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id o70so16989925yba.7;
        Tue, 08 Nov 2022 03:28:22 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr35266161ybs.380.1667906901975; Tue, 08
 Nov 2022 03:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221107172953.63218-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221107172953.63218-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 12:28:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZyiRz0Qe2OgCZLeQe4L+ty7MR2AHQVVeC0upaM3X8OQ@mail.gmail.com>
Message-ID: <CAMuHMdWZyiRz0Qe2OgCZLeQe4L+ty7MR2AHQVVeC0upaM3X8OQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g054: Drop #address-cells from
 pinctrl node
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 6:30 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This fixes the below dtbs_check warning:
>
> arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
>     [[2]] is not of type 'object'
>     From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
>
> Drop #address-cells property from pinctrl node as it has no child nodes in it.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.
If you don't mind, I'll squash both patches into a single commit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
