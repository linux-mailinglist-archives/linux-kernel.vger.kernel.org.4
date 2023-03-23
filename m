Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760206C621E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCWIli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjCWIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:41:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A0137B58
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:40:09 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e71so23936216ybc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679560808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVdvufZV56apmT3wmD9ncMcsijkg1/WCzRLjEqhYbYk=;
        b=jt0T1kyTzkSVHHCl6C3RepTUHJHJMJwp3E7PBrhT2/xYa5EtksiTTG/c8wwIzIU4Z/
         SP6qSrUD+NxMXZX1bTG8PCQpgfuHP59u0Np8wiu0KUJPXSqAJzXQDAgAhdBdm4ERqTZu
         W1iU/UXMn4o+x12ZfA1TbzzlGle1mhqc6+pCFoTYeSycXLH0chaeh9w1eBTkD2vOP8sA
         vAdlNnAtJbu1a1BYoccU9GKqHc2Cvh+aARoS6g2QyjguTZ3KI+BylBNheh9Xg9t4NtTd
         2k3OHgvwLC4ljAJqFRZ+gv0eOvpjcGObjDM/uBGal3iyuErBjVTwBqdgO9KbDxL+mVt4
         VMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVdvufZV56apmT3wmD9ncMcsijkg1/WCzRLjEqhYbYk=;
        b=O9XdgAd5mIjdzVKmKupGmcyIrGFXt4RTnTLLjLiGfkyoXA9TTXh2MIJcxWB+67xNar
         ZSGWMQCyr3eiewSSvI/I7qE5rPdAAocqC7RkJzB+988JTqUjKe/8nDnkbL6GYTrM/szy
         kbRopj6p5mI/vcHl0zGt/ldC5bBeKXFNXYHjBWTJpNIyWhGmWjdFxlb3nePNZxOc78KX
         pNBSfEpeebDUvbJ0BkIZ3ePSJ3oSkK01+aBSly18oeHq9vSbBy8Nl16S/e1LO6CMuSPg
         1KY0ygJ0j38P3N5I0GjkVX2wLmu9aMHXer3Hnu/nwovDQBd7o43aPa8zv6+jDgdlOBw2
         U0aQ==
X-Gm-Message-State: AAQBX9fA5hRwrE/UUb5fYfHZWg75TsfENo0O5hWGoc5320moifaLBj+v
        m/l+OoIzrE72pSrpOGXH8b3y5cmgWWwpZjGZfujBUw==
X-Google-Smtp-Source: AKy350aSyoiWihVzfFCCUghPO+0y8OTXazqo59ZooJtguYITdbyYyykALVgXcFtgTaOhhPAE83rDbJuRGMjWP7pJT3I=
X-Received: by 2002:a25:8712:0:b0:b26:47f3:6cb with SMTP id
 a18-20020a258712000000b00b2647f306cbmr1346675ybl.4.1679560808264; Thu, 23 Mar
 2023 01:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230317233623.3968172-1-robh@kernel.org>
In-Reply-To: <20230317233623.3968172-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2023 09:39:57 +0100
Message-ID: <CACRpkdYq4jE7Qn1w8iPeGz7vxj_CeZ+H48B0TVYmeF4Tt=kHgA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Drop unneeded quotes
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 12:36=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Should I queue this patch by the way, or do you need it to go into some
DT-related tree?

Yours,
Linus Walleij
