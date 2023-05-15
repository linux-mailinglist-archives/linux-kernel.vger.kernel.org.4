Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C790702772
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjEOImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjEOImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:42:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7F9CE;
        Mon, 15 May 2023 01:42:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50db7ec8188so11080032a12.2;
        Mon, 15 May 2023 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684140119; x=1686732119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fD0fpSqeYQATHAfxrc40asdZfIrotxKdFwnOOUQo9hA=;
        b=iiP2zX4BRcy2fPNOu0OxN1fusbX6TYkeV1IJiwa4zYhVPths+Vwqo0AvCi+shkIqhf
         qBVd8uDcIbXbtHyMIDx7CjvxhBXlAFhRM3Buj9Jo2Bu15RAhPIsA7JGbhSCFsfaong97
         J+UMD4NAvRqCwayPzWaORcDsxkp/JzwiDJ6/1KXGaD3lsCinNftj/n2jFbdWRwS4dFpJ
         60E8Qk/28/NPiAYp5DELIv7d9S5f04BiqA/be0OGfa0tbC2Ek41dLa4pEQr+5CVyzZUF
         lOSqRNPcZJBdohYPX7H1yf04EpSpc09lrxr9NWq975BMNf+kcHkqGwMrNaryRua16lWc
         xEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684140119; x=1686732119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fD0fpSqeYQATHAfxrc40asdZfIrotxKdFwnOOUQo9hA=;
        b=CXFBKhQv2QYgI6tI+lmUxEG44DxmONgGIlyKKcA8ci3Dq9qJQcNlvL46d+0Gp0l/jR
         wBuKFH8NTGfcMJmqUiRBW3r5tIQiIrVNNo2JJ3huNr9wQ6yN0lzeCNtQYeLpnsbpeArN
         mwFeyyRKx0BWtaqwTcyTAhyOdOah9TTrMbXHyUoxilVziLkVxlgEeGUot14WK77vmEvk
         9/ZXsB6UoRuf/1IgbzM0ZjnZSKg2Te6N3c08Sinqs25Bc1EBI1Q8T65i5gKBif4EHoHR
         X0ioeDk8DjXuzxE3ka/5UjX4R0RTm2nt+EnArNw+0QSHhFUc5PG+lS8XC3JhcFXPx/fc
         kxvQ==
X-Gm-Message-State: AC+VfDwQsQw/KFwFiVqc9GuwLJlrttv5Dhi7FrLNzCK4AxQ3Io0Mw/5f
        KTzJc+dXktniE7jmF0KV/qzxMrSxNjR7Ae/m0c0=
X-Google-Smtp-Source: ACHHUZ7XXPpX3mJ7rJEv+Y0TAqfS548hzthsIYZYYrXMGfy7iGC11VFTocLjvHY8MV96XpSzHEV6vQWxTsrWW541Cdk=
X-Received: by 2002:a05:6402:2d0:b0:50d:91c8:9e16 with SMTP id
 b16-20020a05640202d000b0050d91c89e16mr22573811edx.12.1684140118752; Mon, 15
 May 2023 01:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org> <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 15 May 2023 10:41:45 +0200
Message-ID: <CAFqH_520eLGP8wmD6fYyCvXscsndeGka3moVk3G6VpW3zsEhXQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
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
        Linus Walleij <linus.walleij@linaro.org>,
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
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Missatge de Rob Herring <robh@kernel.org> del dia dv., 5 de maig 2023
a les 5:29:
>
> The arm dts directory has grown to 1553 boards which makes it a bit
> unwieldy to maintain and use. Past attempts stalled out due to plans to
> move .dts files out of the kernel tree. Doing that is no longer planned
> (any time soon at least), so let's go ahead and group .dts files by
> vendors. This move aligns arm with arm64 .dts file structure.
>
> Doing this enables building subsets of dts files by vendor easily
> without changing kernel configs:
>
> make allyesconfig
> make arch/arm/boot/dts/ti/
>
> There's no change to dtbs_install as the flat structure is maintained on
> install.
>
> The naming of vendor directories is roughly in this order of preference:
> - Matching original and current SoC vendor prefix/name (e.g. ti, qcom)
> - Current vendor prefix/name if still actively sold (SoCs which have
>   been aquired) (e.g. nxp/imx)
> - Existing platform name for older platforms not sold/maintained by any
>   company (e.g. gemini, nspire)
>
> The whole move was scripted with the exception of MAINTAINERS.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

For ARM/IGEP boards

Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
