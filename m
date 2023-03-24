Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8826C7FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCXOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654B10EB;
        Fri, 24 Mar 2023 07:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA5862B31;
        Fri, 24 Mar 2023 14:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED42C433A4;
        Fri, 24 Mar 2023 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679668455;
        bh=ozq+vH75mAjNkKi3jfaobvjryF3L2Ni1S1Tn6tmagvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZnhWOCjRHBVl6jMFyTdz2uJBPpSM2kij2cHeCYfnvMal7mOe3nevgli12nKSVyo1+
         rZlC/eiRp+q6eYz1wuvLbURRo4cOa1ihg2sXmqlhxeiwE/5uyDJZb5KiFkbR81W5wr
         Mihu8blBLIIPZzPzXG+mtcNvBqAxymxPA4pqExAf5yA8RL9wTslmj93FUvsxYqap4Q
         U4sDe3114VPd8xkzxxSl3wiRrlADe7/VvdzGpRwnCFQhUCrAMQiONqvicHZNOAzuqU
         qvkUUlLWORUAOjqfuxV3S76W62ttb0Hz0+kSU2MB9UaOHxxmARqzQALHu2NEdEOapF
         9LgGCEDTVE4Ew==
Received: by mail-pl1-f173.google.com with SMTP id ix20so1978358plb.3;
        Fri, 24 Mar 2023 07:34:15 -0700 (PDT)
X-Gm-Message-State: AAQBX9fyxFGJ2Q7V/4XTxyFgsG+S3SoSPtgcDKoRmveKbIlYoNbAyKn/
        oGawmAEbx0daUxX9Zpt4COpTTvA0lLKbTPlqTQ==
X-Google-Smtp-Source: AKy350Y57cQ3/TzcctMtJeBkZVGy3RaGVnEiqyzqBxcgVPo3gFc72P+HHXJ3tIgI+qnw4mjDX3xPaiNQsV4yB10ee/Y=
X-Received: by 2002:a81:b149:0:b0:543:9065:b225 with SMTP id
 p70-20020a81b149000000b005439065b225mr1122523ywh.5.1679668433642; Fri, 24 Mar
 2023 07:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230317233623.3968172-1-robh@kernel.org> <CACRpkdYq4jE7Qn1w8iPeGz7vxj_CeZ+H48B0TVYmeF4Tt=kHgA@mail.gmail.com>
In-Reply-To: <CACRpkdYq4jE7Qn1w8iPeGz7vxj_CeZ+H48B0TVYmeF4Tt=kHgA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Mar 2023 09:33:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+nF_WwZ-EDpUSD2yrxPLZWxaeb=WpTtPnnbpgcXT7qA@mail.gmail.com>
Message-ID: <CAL_JsqL+nF_WwZ-EDpUSD2yrxPLZWxaeb=WpTtPnnbpgcXT7qA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Drop unneeded quotes
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>,
        Wells Lu <wellslutw@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, asahi@lists.linux.dev,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:40=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Sat, Mar 18, 2023 at 12:36=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
>
> > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > checking for this can be enabled in yamllint.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Should I queue this patch by the way, or do you need it to go into some
> DT-related tree?

Stands on its own. You can take it.

Rob
