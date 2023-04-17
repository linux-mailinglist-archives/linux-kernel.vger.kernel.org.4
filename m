Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB66E4359
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDQJNG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDQJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:13:02 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7CD1716;
        Mon, 17 Apr 2023 02:13:02 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 39-20020a9d04aa000000b006a1370e214aso10094212otm.11;
        Mon, 17 Apr 2023 02:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681722781; x=1684314781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugn0tF7BDKzSh48Bi2FzY0cxR1IhIvrfHVPHfcTin10=;
        b=ht0WAZnbes0KV1kgJjWFROYp5tG4UtNEI5jEYID8Erzkru9bgDDws4+rQ77NSm9lUQ
         ih4xwA+YRAjoNXpecetsM0qvTlQtbdywUxYvbiEEWZGa9uz3ILlLF89vSgOxLWwv5FPI
         7Wqhu9ozgKmZf8Xgy7Nuvgfq+HFjhRzJ2gebEOmqid8ZzR5ZFCbuo+syQFSldcPVeYUu
         C5xEuB9AFb9pEc0k+WPaVCiViRq0wh27BY9WcSAEh7OV0weub2ZQraNvXf6raTeMW+Sh
         RyLhaAVFBw43zkd7GRkVcpxF+PWonzw74skSRdZ+pzIPYVf0/gOF9I4XRVjnixA064Me
         v3jw==
X-Gm-Message-State: AAQBX9eS0T3gjcZdP0DxxrVidL1Wp1huMB7N/q2VvojmV5c518wy6+9I
        qjXwjo09MmzG3mHmKT0uTrP+FMLvLEDsxA==
X-Google-Smtp-Source: AKy350a62JT2HBM5TzaQiZcCf1BDJqGmCH7LoEyzCOHSiT4Bu2Sqzh6ww8oJy8T7+tCWxHK+CsTG5w==
X-Received: by 2002:a9d:6f8b:0:b0:69c:f63b:7f01 with SMTP id h11-20020a9d6f8b000000b0069cf63b7f01mr6613730otq.26.1681722781312;
        Mon, 17 Apr 2023 02:13:01 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a9d6418000000b006a44338c8efsm1354626otl.44.2023.04.17.02.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 02:13:01 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-187fee8c5e7so214765fac.3;
        Mon, 17 Apr 2023 02:13:01 -0700 (PDT)
X-Received: by 2002:a25:d057:0:b0:b8f:5c64:cc2e with SMTP id
 h84-20020a25d057000000b00b8f5c64cc2emr6890649ybg.12.1681722760298; Mon, 17
 Apr 2023 02:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org> <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 11:12:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=H_ypo82C4G8e_ytS9R6GNwnvVD_0L2GzPQdyaUHhdw@mail.gmail.com>
Message-ID: <CAMuHMdX=H_ypo82C4G8e_ytS9R6GNwnvVD_0L2GzPQdyaUHhdw@mail.gmail.com>
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
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 11:58 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Minor cleanup without functional impact:
> 1. Indent DTS examples to preferred four-spaces (more readable for DTS),
> 2. Drop unneeded quotes,
> 3. Add/drop blank lines to make the code readable.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../bindings/watchdog/renesas,wdt.yaml        | 14 ++++----

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
