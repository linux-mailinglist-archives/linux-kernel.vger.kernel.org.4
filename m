Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E896183B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiKCQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKCQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:06:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD59A1C438
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:05:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ud5so6575089ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjX82js1MEeHcR9vNScDckdgVeBb111bo+yliZ0LU2M=;
        b=x7j2H2hfFCfGg8qWiLy9NsZwLf25fTTjJjZvNjK6ZXSLzy4O7aajUYEFp12DO85h85
         R/3C5Nl2I4CyncUfO3qxnpxqRijqRjhmSvPILlqw9MbTEE4K8Tk3x3mZelotOS+D+pcH
         e50u/2dbr0Oq7C+z9LI0TaPpBY/X3n03kr6Tf+Vk3qA2M1FR0TTPWf0oDOXlLhPWXRhN
         C4MRYz5p5F6ZeJa8kz/j3XDoNIUDi81igpMBI4CTQBK+bTJOtmSa5uimBKlortNxF+vc
         B0yyysJlP7EOWdvkn7SLPT/JEeVTj6zIXpvWeEy7RarNBhwTVRTO8cR8XLEZ0eliknEu
         598g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjX82js1MEeHcR9vNScDckdgVeBb111bo+yliZ0LU2M=;
        b=SsWXKjgOmZ+YL6u14nKsS8xtUZB5lMUX9FqJlunZuPGtkrQTPuA4P7TLTFV9Hn+JGp
         K7SM20fAyyfHuVGH+w0uS2Zvk4bFjyGj6N2Qu2Ircc6RM4Fs9XZAJOQWQj+PhrF0rM6P
         gV4mGpog5sj+v8fMkiupNIau9rItCSlEFw8mhj8YnGK2yJc/qV5C2jbsPBIxLlopHZrG
         iAq8hpmK1u5VquqKaiQ5GQmpfJqi3PHc2H6SmGG7VlWs1ifkrXRy7PJupriRhm6OPP4w
         mAbAQy3fV0gmii01blvcgwK+yFbFezYZIDeHuosDaohwRpy8pehjgoomNEXr0McqY4SH
         JJ5Q==
X-Gm-Message-State: ACrzQf3+n3NZVs08RgMsPeahIBAvMKogYFqm9ta+7L7e9nMdYzj3iFDm
        R1d5Snmj44vEgMOT9H3mPal1XlfvLvNRuNv93YqaUA==
X-Google-Smtp-Source: AMsMyM7umtXR9dZZBUzwJwdrFaiBTk5vMewRI+ViOLmUb1K+o7oAnalKkdPpAtcST34+nzychCbvz1OkY69yNaFoMZQ=
X-Received: by 2002:a17:906:dc8f:b0:7a5:8160:1995 with SMTP id
 cs15-20020a170906dc8f00b007a581601995mr30096358ejc.500.1667491541292; Thu, 03
 Nov 2022 09:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221102171012.49150-1-kory.maincent@bootlin.com> <20221102171012.49150-4-kory.maincent@bootlin.com>
In-Reply-To: <20221102171012.49150-4-kory.maincent@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Nov 2022 17:05:30 +0100
Message-ID: <CACRpkda7EFTe0TT4-hs_F3qTCwp25pgOAqhNSFyJgeNQ3=O7UQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm: configs: spear6xx: Enable PL110 display controller
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Cc:     viresh.kumar@linaro.org,
        Vipul Kumar Samar <vipulkumar.samar@st.com>,
        Vipin Kumar <vipin.kumar@st.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        Bhavna Yadav <bhavna.yadav@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 6:10 PM K=C3=B6ry Maincent <kory.maincent@bootlin.co=
m> wrote:

> From: Kory Maincent <kory.maincent@bootlin.com>
>
> Enable the PL110 DRM driver, used by the spear600.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for using the DRM driver!

Yours,
Linus Walleij
