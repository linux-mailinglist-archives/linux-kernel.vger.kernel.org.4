Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6A6FB338
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjEHOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEHOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:48:30 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91165A7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:48:29 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-559e2051d05so66233297b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683557309; x=1686149309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBRDdEMkcJinIhxYo+B9YRkKgZD79DRuOOXoD9mvqrA=;
        b=iD0hSzpClyLDSlsnaJ2NGcfs5E32cBiwzYfcZo6LCcWAHRSKDUETJfz3+7n45JTCwt
         douc/nbRktVg+S9fgzdZd9ScZKiQ+MLW3/muv3NLSJFv+HVZ1RbAevD7TlvCK57ZbvsL
         WbMNsnumNBYCgNcGj9soUX8blE5RPgua8v/9CbQ9T+ZTUmF4CWk5O7uuwGp0/o9HtmFA
         qyXKiledds2jlCCRcHNZCkTa7gVrJPZ0JjWU86yuchOPpVmmabEi+k8tUyz46CCBxqZu
         lkwDO47kj1R1h518ubnwuTvtPDxjClD3JFwmyETVbTvSrq7BD1t2WPJWAC3zXBCHpNJT
         kT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683557309; x=1686149309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBRDdEMkcJinIhxYo+B9YRkKgZD79DRuOOXoD9mvqrA=;
        b=D9wY+gC5hadS1xL0XoNVWCIt0+cx7g18L700/MIoz/jpPVsBh7N6WhfQEa5UoXyqdw
         DPm80bwr4nqvJaxltTwFPtbTqmGuvswj6jnOAzB1NcXaYwbkyUplYgUsL1Ql+21Vs0i1
         wsETeSP+n8oulmldKtNZS+hAKMHgFzu7Mmgci0GXpQhhpDBQVsSHtnaQh6yLLFLTDPVB
         b635qTpf4TZi+FIgUY4SD4I7kKg9wW6U6iTQERfWxFJB6J/REa/DU77/1sM9laEI4CNs
         1gbYNlcekPS48+gS8BoDIHwwRqrghhzz/rOgtXVfSJBTUHywlqPSgL2rHAOWeotmC7st
         2wcQ==
X-Gm-Message-State: AC+VfDy0hLnBBShxs0W4CU+g+YCzPM49YoJr+N6tHJKbCp5fCewzDeqU
        MB87lXC95yNghLHENWfR0rFgIIf7HQsDAcw0ZHPcWg==
X-Google-Smtp-Source: ACHHUZ5YUrkJZ/Z2beY5zA4zYoasGmvc6Wh2Js2To2GzZo6nfjG/1CfaA4enPcYkeZdCT/H+sD/SeZS62t99vhljdDw=
X-Received: by 2002:a05:6902:18c6:b0:b99:5707:4e6f with SMTP id
 ck6-20020a05690218c600b00b9957074e6fmr15005818ybb.32.1683557308817; Mon, 08
 May 2023 07:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org> <20230504-arm-dts-mv-v1-2-2c8e51a2b6c4@kernel.org>
In-Reply-To: <20230504-arm-dts-mv-v1-2-2c8e51a2b6c4@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 16:48:17 +0200
Message-ID: <CACRpkdbfKdR=ru8dCJL0Tincu2-Smsi56vt=C7OW3K9JuQ=47Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: Add .dts files missing from the build
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 5:29=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:

> Comparing .dts files to built .dtb files yielded a few .dts files which
> are never built. Add them to the build.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Wow weird.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
