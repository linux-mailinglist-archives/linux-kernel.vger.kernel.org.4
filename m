Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CA6E3170
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDOMtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:49:18 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C5744BA;
        Sat, 15 Apr 2023 05:49:17 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id u13-20020a4ac38d000000b005426b196223so410725oop.8;
        Sat, 15 Apr 2023 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681562957; x=1684154957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqQ3SiHws9LUFOFeaTF92+MKSqS3DlyruqkxUBl1iVE=;
        b=sAInW4jdFWd18P0SfBBU1170JUXE7LLFld6YAm6j4OxSekPTZLOY5WVbySpiaUlsDL
         cpJMSyT+1ai6GPaZ+GaWtYkHgOJajm9XTRgsMpGNHdNJpFSdVJ8eIclf7bq9/lqZwTjy
         bYCndd0i63bDCsn6dTfSGaZPEXeKUTgVW8kEdsGMEbT0z3VpD/9H/GWrqqlAGE4Lefvt
         8vN3ZbLwGvCs+1TSnnJ1en9utPQWCqfFfzI10I/VkrMacWt/iSTGLzvHIyVo4jDYeh3D
         +Ov80e54jVnDI/UWw16z7QxZWBr9RpuXpXEUdPm8cjZeoDBTgzQd8mvnIFazu15hpi/D
         Heqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681562957; x=1684154957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqQ3SiHws9LUFOFeaTF92+MKSqS3DlyruqkxUBl1iVE=;
        b=ccoeXEI4b7ewJeMjgqXsh8232CkvgJsicaaSrI//J547pAIvcTUajnFxrRUe7BKp9D
         GZICmkB6RdvIfZ3HKXdoGNmjd0uSGETmx5Ob4uqei1cQOcrTv+xXxvza5fWEDiJNQ0iE
         CClVZrrPCD5088cyF6mq/N3RQ6bjFHwROIV/nIyb2Q58Yac0lK/aRlDeKDh/COk57hN1
         Y4Tn6n0AhDdLx2Pe+94kO/PU293+hLykropyOOCCxtJ1cjhha5V3NbhrcV8xreOuYmmy
         2R+w5jLAEBNcBTj87IAjX7Nwdtu779IpKe0Xil8nAmF7KKBKs2LMyZNr8dkak6k9s1dn
         /yKg==
X-Gm-Message-State: AAQBX9dnPFd1ZtLG2U4+oB246OXO3P/8DFgPefGHUs2uEeiznHwhg4CF
        Neqtyt5GAk+RpOCnKAeYH6K9jk/JOOA+ADBPLAA=
X-Google-Smtp-Source: AKy350aw1sitUTkN1aRNjH+bN0r38acxG6oBYdh1kAmyzRFvhhgzUT2uye2u9KKaOPwVKPk8KV+BJZuBzcqgjqA4HF4=
X-Received: by 2002:a4a:d50d:0:b0:53b:7a81:fe64 with SMTP id
 m13-20020a4ad50d000000b0053b7a81fe64mr2496510oos.0.1681562956798; Sat, 15 Apr
 2023 05:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org> <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 15 Apr 2023 14:49:04 +0200
Message-ID: <CAMhs-H8e_e29=DVU0vc42gp0EiB_zkQLcNw_rH5Om21Xbm=Fpg@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: watchdog: indentation, quotes and
 white-space cleanup
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sander Vanheule <sander@svanheule.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Fu Wei <fu.wei@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Justin Chen <justinpopo6@gmail.com>,
        =?UTF-8?B?4oCaZWNraQ==?= <rafal@milecki.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 11:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Minor cleanup without functional impact:
> 1. Indent DTS examples to preferred four-spaces (more readable for DTS),
> 2. Drop unneeded quotes,
> 3. Add/drop blank lines to make the code readable.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../watchdog/mediatek,mt7621-wdt.yaml         |  6 ++--

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
