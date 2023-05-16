Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E590D705B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjEPXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEPXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:34:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED343524C;
        Tue, 16 May 2023 16:34:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6439e53ed82so10662b3a.1;
        Tue, 16 May 2023 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684280053; x=1686872053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c91TtAMamdr84bU21XJdh1WC/pxB8oOMbvU4oHXaydM=;
        b=CsB5WNulUh5bzvi0quKPWNNbWSo1UWxF3poeDTxUlUjdL+Ko4PKkQV1bMJG/rh25tC
         CpPt1VXITQPipJOrVP/bYkz1mo/sg3G01pmCGYMOU7xdEN+hd1gfEfXA3e35x+S/cW+U
         ez2ZUIqxbS70N2Qb+7i4KHrMq2PAJnjIa4ABZFpMATBa3wu7uwZ5Q1SxI+HxiH2pZvMp
         PVkJr6zPf2MzrOXbFKP1oP+51mDavvl27eKHlzL21HoSOA0IEHEqzhOSpY1Dfmh6AxZ6
         h1VWeqcrMYKpLcUCIrJ6FEXPIzBE1FUl5JImpEQqKiRzzwyMTeaYNfgiDVXA4lWmp7zG
         XVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684280053; x=1686872053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c91TtAMamdr84bU21XJdh1WC/pxB8oOMbvU4oHXaydM=;
        b=k92usEauSNovtOpkSkSQaoDXB7T2+64Ar/y2FZ3sSgTExO2ggekfmCRAbxKi78cWH0
         c8r5xyK6JcAssUmQTC8SOzNDb5c0hdfHjDVAxxoNTA6QCXwJXbOzVE6PmvTL7XhRiWXj
         bQtest06EvMW8dBlKYKxeSMCsY7BIHOmy3bGZnO8calOLi7Wyryg/PVX5KCUO6QtmFoD
         ivs8h1VHa+pXKrpjMrfz68jbLBUo90sLeAjmX11JA4OYZsgFWj8xWQBRJDB4T3/JWr9T
         Bjym9HLD9Qx0/fIuqWHcRo+yV5SP5ZswLpzCsZhts07mYiZ+FptBruflzxqgwCICQWI6
         SdQw==
X-Gm-Message-State: AC+VfDxXwJSwNwY0iUcXMIpfCDM2piZU7BTd9qB8U9d/Muv3hO/huaZI
        Ezl1IDkNuBkoOD6ddnC1K6/ZzsTwXMS3c6CYRNE=
X-Google-Smtp-Source: ACHHUZ5WSwyrzAxg9EJ7HhskT52wzTzQYu+10MKFEdqPNaA9RBbV826kiajHBS9KyC4sYy3yDoMly6VkZvAQJbz4f1w=
X-Received: by 2002:a05:6a00:3406:b0:63b:5257:6837 with SMTP id
 cn6-20020a056a00340600b0063b52576837mr739273pfb.1.1684280053288; Tue, 16 May
 2023 16:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230516153109.514251-1-arnd@kernel.org> <20230516153109.514251-6-arnd@kernel.org>
In-Reply-To: <20230516153109.514251-6-arnd@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 16 May 2023 20:34:01 -0300
Message-ID: <CAOMZO5B0stW2X6YqPTTKDpCOAzPDvm=4HT8jfBAgbTy11gnKgg@mail.gmail.com>
Subject: Re: [PATCH 05/13] ARM: imx: remove unused mx25_revision()
To:     Arnd Bergmann <arnd@kernel.org>, Martin Kaiser <martin@kaiser.cx>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, May 16, 2023 at 12:32=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function has no prototype and no callers:
>
> arm/mach-imx/cpu-imx25.c:43:5: error: no previous prototype for 'mx25_rev=
ision' [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Martin Kaiser sent a patch adding a user for this function:

https://lore.kernel.org/linux-arm-kernel/20220815190748.102664-2-martin@kai=
ser.cx/

It would be better to apply Martin's patch instead of removing mx25_revisio=
n().

Thanks
