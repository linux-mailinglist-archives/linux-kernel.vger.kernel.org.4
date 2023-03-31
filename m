Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563C86D2089
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjCaMkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjCaMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:39:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837E20C04
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:37:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5463fa0c2bfso81726377b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680266252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6lKdgk6THqQzNp4VvxVKewKaHaWOnEhQknxk2acjn0=;
        b=ZMrC7RQQSpVfgy/SHMpfC+E2QpLMDaY5/yaDkSHUKYAESGTlYtEL7g/qRUeknQy91P
         zUvgfNL0L6h3FNfh9c8D2HFAFVYOCP9WG625XToYyxYEiXALrCS5KsLDkaIeSbXlXde1
         eg6UEhsSIBdX6MmhPhtTRLpJ9X4gdd+QI1NZNQSGtPnmNcH0Md5Wv/wDx/8mZJzSNT7K
         vAZIJkR9VzoIqc5aO0g4o0xB+IpDOheOKDhB6ttu5EMPirHAV26dyaOz/pB9Dw1cQhWl
         Nw5HjfOlvF3F0OheAjfDdZPbDekSVJ+CefyXJevdAGQrjbRZSi8YsUnd1+evdQw6Mb3h
         4YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6lKdgk6THqQzNp4VvxVKewKaHaWOnEhQknxk2acjn0=;
        b=Tu1P5vOyjh7vk4vh9PiDaAnXJvuaxK9TF7P15L+C0f2kUnoyrmBEEdFpaOD6iVyV+h
         4MfBe7g3dsaQFgQiA2elU4KvA2jTZB7xPn/jcv8g+/vCp5nmudLJNeUuPkNtsJlm4xIV
         MZWDt1bptTa/jZIKibtVB6UMcfSeq5OBd1kGb1oW8jgkM2ifpr2i/apne684r1PePCY4
         Q2/v1BcEX1HnRZdXlv6L+YODw4YCp8PDn2ykcYmShRVq/c4OSYwL86ExDqdsyA5LSiLF
         /nCCOrspsUh8IWTCW3VXaRJT6QoM6R9NT8oXGBGdZw/VuebKqvYtIEuQicKMfbqZHvrT
         0vrg==
X-Gm-Message-State: AAQBX9fyCWEXahW8mm+CBPwlUPO9RCgY2MofOgaljvomZmAFu1RE4TlW
        murw3mtsp7gVZDzcguB9KCzDKdpOWyuWa8kk3SObMg==
X-Google-Smtp-Source: AKy350aQG4pTb9063C5UpGPTZlWu/1jB1S9bOfbEf1bci1cyW8YxugalTaCiIXNAm4RWMBbCrWxYKS+tBxFA+9FzOXI=
X-Received: by 2002:a81:c84a:0:b0:541:753d:32f9 with SMTP id
 k10-20020a81c84a000000b00541753d32f9mr13384037ywl.9.1680266252481; Fri, 31
 Mar 2023 05:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230330200402.2731992-1-robh@kernel.org>
In-Reply-To: <20230330200402.2731992-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Mar 2023 14:37:21 +0200
Message-ID: <CACRpkdYwM5Kw4XB9S5qoqdK-boiYp2iu=LRZ-B-vJb1k9fNnig@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
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
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        - <patches@opensource.cirrus.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Peng Fan <peng.fan@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Drew Fustini <drew@beagleboard.org>,
        Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, asahi@lists.linux.dev,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:05=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Hector Martin <marcan@marcan.st>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de> #rockchip
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Rebase on pinctrl tree

I applied it quickly before something else changes!

Thanks for respinning, and thanks as always for driving these changes.

Yours,
Linus Walleij
