Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C76727D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjARTFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjARTFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:05:08 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FDA1817B;
        Wed, 18 Jan 2023 11:05:07 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 123so6183674ybv.6;
        Wed, 18 Jan 2023 11:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOwQfemle8oAtk5HhkSGbIU5cG/VOJmaf2KabL9UxvM=;
        b=tzZtQC62c/NQYpKqjH8ROG+ZSczyrZ2tgxvzZhDOMRSksjEPHt1bMsye+1HPtuE8bE
         cHZQTzSASIWkVEU5mlTteD3WROHaIBNiGmt1lrDr1f3GRjQtuewNgwutDcXAVPsrvEWy
         ysErxmzkTZFIab3EFShg92KmULDTdWyx23j9XAcqC1VKVXTon+0V1S6VASDaWc2JKyBk
         OTKXXIcnz++y84KvljGwM7AiD8efZy/Rl4mKJa1xqVVC7UPdYZUHox1bPzELoCI7u2iD
         RmFPAyKALHHC9+d1Re0JCj7aEWL2iGUQCVPNpzIrDSqU2FmC/NtoQg+XrlF3rsRcrXit
         nc1Q==
X-Gm-Message-State: AFqh2koTLQUpRDwq9TdVyLHtQr4KZBoZ0rLLp3U3xclv4JM6rBnqug1q
        iYxbiMXC+oXaaQE4/RVRbiTuYLCvEljononXDmA=
X-Google-Smtp-Source: AMrXdXvMuIWb6NC4K83Ew19Qx4qYqKSwcTR/3Lptq3i5u7ielAzaMifOqVNIyWImdnTGoALqSE6MiQ==
X-Received: by 2002:a25:f50a:0:b0:763:cf87:ea68 with SMTP id a10-20020a25f50a000000b00763cf87ea68mr2839228ybe.33.1674068706313;
        Wed, 18 Jan 2023 11:05:06 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id y3-20020ab077c3000000b005de5a2cca24sm3366079uar.8.2023.01.18.11.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:05:05 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id u3so8841074uae.0;
        Wed, 18 Jan 2023 11:05:05 -0800 (PST)
X-Received: by 2002:a25:d88c:0:b0:77a:b5f3:d0ac with SMTP id
 p134-20020a25d88c000000b0077ab5f3d0acmr846222ybg.202.1674068694405; Wed, 18
 Jan 2023 11:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org> <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jan 2023 20:04:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZOsrBwJrST=49v6JFqCyq_gT0kfA-QS7TS4oigZtM-w@mail.gmail.com>
Message-ID: <CAMuHMdWZOsrBwJrST=49v6JFqCyq_gT0kfA-QS7TS4oigZtM-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: dt-bindings: cleanup examples - indentation,
 lowercase hex
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, Han Xu <han.xu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?B?4oCaZWNraQ==?= <rafal@milecki.pl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Bert Vermeulen <bert@biot.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anson Huang <Anson.Huang@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
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

On Wed, Jan 18, 2023 at 6:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Cleanup examples:
>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>  - drop redundant blank lines,
>  - use lowercase hex.
>
> No functional impact except adjusting to preferred coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
