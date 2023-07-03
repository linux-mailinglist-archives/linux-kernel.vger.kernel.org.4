Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5745C745716
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGCIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGCIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:14:19 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6B1BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:14:17 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-47e611669e5so13101e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688372056; x=1690964056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11QJYwMbaUBpF9NueY3t6DsMt9/06w7p8RRvTfLIaJc=;
        b=L0Xoku72iyScuyAAlvdURXBApKe96vcZyauApjEXYrGVlSdQ5+Noqx/dJGtVL5x6q/
         jlFR5a9BhO9sA8f3jeglFFz63W5kpnijEXV3GbujV4lA4VrnyUUly7d3Wcix3txlUZKX
         0zTnULX0ieClGA2akWPTDF84ad2rXwBO7fEXhu1OYcHAAKgyVmkRs6hX/zxDaek+K+yy
         +Dq303IKCVITitnmnDhFbe5F+dSDTjXUpTQlniD7u22PH7eeed9b8JO4qs6ZdKwCYj/I
         dMxjHx7kBRx/dGnktAFbMiPelHl/QS1H0Ujo5z344HSwUz0dNoig8gIxg/cBlzWUnRon
         rbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372056; x=1690964056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11QJYwMbaUBpF9NueY3t6DsMt9/06w7p8RRvTfLIaJc=;
        b=F9QhE6iydoxakJhu3IYQgewJIM+sd338uVt5OjhoP7agFi/llivQ1Ae1f2Dr+uq3JM
         1noMkLs6talgHu+H7/MN5LsXMrgD7nnClzUnB4dLkEt7YO3w6lINpbd1NOAiVdIYcNWJ
         8zA5DMSnwyooXGw7+O0E6UbY+dab272N8OUjuo0GlAYGm9a2xItcVEM47wDbk5wiRPGW
         lcCUNVSXQtFofkIQzKtE112gPcNIv5ghCkc+WEMUBMGTJLoHWuWtvG9fwVhM5eqi6n2s
         o3TFSEqysO8l8iMU0L7RHLv9C5lSIIC85t489pTOMwknez5k3wwHKI3tPbZauEv8m1M5
         9SYg==
X-Gm-Message-State: ABy/qLYm13XqK6/Yo84TmT2xBnJUo3SRQrkjSKdxEpyyPHGKZcaPzjpZ
        BdVQtn7NhY/YTgslKXG/8AJiyEc2goCm9llRJoTgBw==
X-Google-Smtp-Source: APBJJlGUXmmzazOU3H2rwPItzzs5yY59Pr2doU3bzs7pqr02Nwa0JTfP80SKVHXrdbTVZhHGNnsVQtkzPqxhjzQX+Tw=
X-Received: by 2002:a1f:c1d0:0:b0:471:5939:f4f2 with SMTP id
 r199-20020a1fc1d0000000b004715939f4f2mr3056599vkf.8.1688372056011; Mon, 03
 Jul 2023 01:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-11-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-11-fb6ab3dea87c@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Jul 2023 10:14:04 +0200
Message-ID: <CAMRc=McTEPt_gb5HX98khmxvQDX-VQQ62uBF=p4dr_QqouL0kQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] dt-bindings: gpio: gpio_oxnas: remove obsolete bindings
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 6:58=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 gpio bindings.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
