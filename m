Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE45675FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjATWF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:05:24 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B017F9B5;
        Fri, 20 Jan 2023 14:05:22 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c3so6978549ljh.1;
        Fri, 20 Jan 2023 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47bQYYvwoc4QnN6fF+m3+7Uy31DycYW7WL3pijAuHrc=;
        b=KvPPeMjcYz60GhdROsv9YwE8uv6xdcPv1k4AoX89i567SWpqXcTQSLDK/flblBKQaK
         cfAwGOzXB55ObBgNsuBR/aS/ZWS73BbHA/j30YrvThOJ8sklQ4vSCuYCTT8/aQzKd7x0
         ED9B0EpAuuFXHRhyTAE2rYJAIefWE3cRMQT+JXdOSX+nqVPxt1tECmSugDkFBGKmqaIe
         6MDATr+REE+laIkFeEGl7Baxej1BF+lzV1ySkQv7XTAq7tOHtm6EgBpTeWGjnRwbXi4k
         o/CUW40k/L54EJCQepVRJ5CWNNQh0cJ5hbe2XRT19mSa+4VgezmJ8OO8kHFU25o+EiBV
         +VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47bQYYvwoc4QnN6fF+m3+7Uy31DycYW7WL3pijAuHrc=;
        b=N0Ykw/edLx5XhO4z7ybUxbsYTceVnvDZfMmXO2WXkUOvEecGNbjZweXJj582jeLJES
         O9HS6PQZga260YU/Z0hyPgpOJxqPkrLTWut98aa2qntTaY6VgM45V7CjQPjGquv0zXvX
         lIIq6DzBDkh33KRDbiaS50zk5p4nF7/M+nBv+ZOVtB3uJoQs7f1V7KHS+6eihPu56RiZ
         ZCqnkKFk7inLszYpHN1F+sywxvfKP/xgpiQQQONZP2GnAXTsUAfD1b6Cx8x/KEKMH6lp
         Wq5Zvnp6bFu2Xim1O2AZcuwXMCdLcim2Rt5nwqsjPIwoZAmTzTyMjYJp1O0HiM8xmT2c
         KPcg==
X-Gm-Message-State: AFqh2kr/GenebU2r3XvS7xGAf9ZepkcSgs2fdPBLycz8Uq53UauYtWNv
        ZSqMInNY68jO/FR1B2Zi4LPUKUkHxegic1fRNSU=
X-Google-Smtp-Source: AMrXdXsEvy2zUx8pBtqvlaMNQXcMQiU5wj9qFfZWFmAJ8mJ3iDwd2PNDfGEnDLQioMNqbk8VGMyCnxB99EQkJx6YjZ8=
X-Received: by 2002:a2e:b752:0:b0:28b:77fd:d92b with SMTP id
 k18-20020a2eb752000000b0028b77fdd92bmr1424117ljo.86.1674252320747; Fri, 20
 Jan 2023 14:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri, 20 Jan 2023 23:05:09 +0100
Message-ID: <CANk7y0jpC4Hz5cEzdO2WQkRbqNfBKKgKXTrL142D5Ldr_dhBjA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: iio: drop unneeded quotes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Robert Yang <decatf@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Alexandru Lazar <alazar@startmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        Phil Reid <preid@electromag.com.au>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:44 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/accel/memsensing,msa311.yaml  | 5 ++---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
>  .../devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml    | 2 +-
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++--
>  .../devicetree/bindings/iio/adc/ingenic,adc.yaml          | 4 ++--
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml    | 4 ++--
>  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml    | 2 +-
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml   | 2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml         | 8 ++++----
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml         | 2 +-
>  Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml | 2 +-
>  .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml         | 4 ++--
>  .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml         | 4 ++--
>  .../devicetree/bindings/iio/dac/st,stm32-dac.yaml         | 4 ++--
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 2 +-
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml    | 6 +++---

For ti,tmp117.yaml
Reviewed-by: Puranjay Mohan <puranjay12@gmail.com>
