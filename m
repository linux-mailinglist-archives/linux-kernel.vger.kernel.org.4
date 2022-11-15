Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEC1629976
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiKOM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKOM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:57:28 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D112C7;
        Tue, 15 Nov 2022 04:57:28 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id jr19so8601580qtb.7;
        Tue, 15 Nov 2022 04:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHkJPzka4zfXCGTLs0aO8VP7mGUblhi6WGRHIHM6AP4=;
        b=W/TD5vpJBlhgyRRBRlGaO7+ipmFEYCspKfYpckw8N5NDsj9OwXk2u1FyoGLZJmG0AJ
         WfxliHskXp/NcKrz7nIsACXpvnQAlpFD+9PYlh27k3P2TjZRX0rF9F8dssuHZnqgbAS2
         iUmo+CL0pVIClpP9hx6vc7pUi24ls8s/vEOm34qxUF3WSGTOQX+RiNEo+SRH7UwGcikr
         Ah5UHbj1S4sywaBQeiIIZUfNeTXbt3aLixM7fCwDBjg+pX/pk3Xv0KxqGY6KFyazjQsV
         oBSDJxx75KKwbPX4Pwo/z4UewSPJJ+HM7k3jxbJgRZVLjxZd658pK1/Gy6IRNI5i9x0G
         iQAA==
X-Gm-Message-State: ANoB5plFuagK/H2HR8QJrKcZ4qzSKaAxKseLdM4bmRVpPzo1rUJm60Mp
        RCi74wNalOs0jw1NgMRjgr1usafZspSqrA==
X-Google-Smtp-Source: AA0mqf4A5haEB1MLSv4thEtH6i37ACnXrWnkiijgSliXdhTxkskYHGxLehBjjV85ZuFx+JBO9Ep9rg==
X-Received: by 2002:ac8:4753:0:b0:3a5:2967:f8b6 with SMTP id k19-20020ac84753000000b003a52967f8b6mr16763788qtp.86.1668517047205;
        Tue, 15 Nov 2022 04:57:27 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id d27-20020ac84e3b000000b00398313f286dsm7209786qtw.40.2022.11.15.04.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 04:57:26 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id e68so14223584ybh.2;
        Tue, 15 Nov 2022 04:57:26 -0800 (PST)
X-Received: by 2002:a25:18c5:0:b0:6de:6183:c5c3 with SMTP id
 188-20020a2518c5000000b006de6183c5c3mr16677266yby.89.1668517046328; Tue, 15
 Nov 2022 04:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 13:57:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUm77=79oEWCrjVcC9qJLkNPMKYDjdwfOy6Q1C9KFsOHg@mail.gmail.com>
Message-ID: <CAMuHMdUm77=79oEWCrjVcC9qJLkNPMKYDjdwfOy6Q1C9KFsOHg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Tue, Nov 15, 2022 at 1:20 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The TSU block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-tsu" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rzg2l-tsu" will be used as a fallback on RZ/Five SoC.
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
