Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2740360F8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiJ0NOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiJ0NOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:14:22 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A664AD5E;
        Thu, 27 Oct 2022 06:14:21 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id b25so808191qkk.7;
        Thu, 27 Oct 2022 06:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7yrQv4nD+SX3WfQBwYkM1Zs5RwSPJZfuMM6N6ixuFk=;
        b=CPqkRzERv8rhDp6QHqjK2t9YY7O9UQaoyO3VeQbxYCBdjQQRiGTpg9hgmHSL28B+JK
         erTbzBivVpaJu1CZSRWIhD/yB4pHyhi8N4Ikfv/KeWSia/WhsWV2gXH6Kl7z88Ymzga7
         GTQi9wkinZdx2ot8vt2yqAr7q7+fY+FmMsaq7/Ys1kVqYjlik3sB1JwKT+CXLcDFf/mf
         NZVAeZfi80bbGqtRm5NQQFIB23Z/0ISg7L8opYDsAQUp5hqPrg3GXM7gizXDYZk19d7S
         f+EPpPbqYj3HOVLbwkH7DhMJuEEQ2ZXEDuI5FA2Eb3utb8RltEuCbhGc7o/nQUFKBEuK
         60Ow==
X-Gm-Message-State: ACrzQf37p7nAzYD5ELk44/JYhRDE5GndAZM2DbWsN/3J0IqrN6hn7kDL
        M2CdebUJjF7F7gJg33VcApTZVQpo1uHkvg==
X-Google-Smtp-Source: AMsMyM6tKZwvLfc7CIH+UhU5iN73K7pVTQeoGJPI6/bjtyPkxPsCwiUiqF/buwMkhV3CY7eY2221IQ==
X-Received: by 2002:a05:620a:2456:b0:6ee:e24f:74f7 with SMTP id h22-20020a05620a245600b006eee24f74f7mr34604285qkn.9.1666876460759;
        Thu, 27 Oct 2022 06:14:20 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id h17-20020ac87451000000b00398313f286dsm860827qtr.40.2022.10.27.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:14:19 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id i127so1878502ybc.11;
        Thu, 27 Oct 2022 06:14:19 -0700 (PDT)
X-Received: by 2002:a5b:52:0:b0:6cb:7584:1b20 with SMTP id e18-20020a5b0052000000b006cb75841b20mr11996441ybp.380.1666876458981;
 Thu, 27 Oct 2022 06:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221026130658.45601-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221026130658.45601-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Oct 2022 15:14:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXMvkboWKmNMmb53MjEtmeDgLoeDVOhJ8_Jxrm4M-grgw@mail.gmail.com>
Message-ID: <CAMuHMdXMvkboWKmNMmb53MjEtmeDgLoeDVOhJ8_Jxrm4M-grgw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] arm64: dts: renesas: aistarvision-mipi-adapter-2.1:
 Drop clock-names property
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Oct 26, 2022 at 3:07 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Now that the driver has been updated to drop fetching the clk reference by
> name we no longer need the clock-names property in the ov5645 sensor node.
>
> This is in preparation for removal for clock-names property from the DT
> binding.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3
> * New patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
