Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12676E3FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDQGUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDQGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:20:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6A3AA8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:20:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u3so9219428ejj.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681712407; x=1684304407;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJzj86LhSJdAtbDEWAVBqUw/9fJfGhViwtTg9bTQuwI=;
        b=UwxNUHi1Q2SgXqIq3683UkBdctv5eKKX4T6cw2UjfsXc5YW6Z3PBE6NlPjLW6oVX8G
         kwN3WLBuMU05G6+iRNYz4AZAV6bHlfUVNFqrywbO0pBt8oD6KYzVcHpeWoGmx1hDTw2Z
         KDBCiGit5JahQBASnL1rzyGRy43I70DwwKGxJ2LI1rlRjLOC+s/4sO1GLMxjvOkb1b/T
         5+39CQS1xToB6e9McpvQoD7TYUklpGa9WnUh/ubH/roqVLknUgjocOXkSxqtFtXXR0PP
         dC31xa56ppER0VHU4Dpk+mo3NIAVMs1Nf0+pr4opnCQ2wUQ7Noh4n4hLAjs8xQFRm2bX
         ct0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681712407; x=1684304407;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJzj86LhSJdAtbDEWAVBqUw/9fJfGhViwtTg9bTQuwI=;
        b=PFHQT1jvoeEEsvswlsxJ3/zmQM/qqcH/J5PUpWrdcTkGDGRyitjSPZUPtdL1orYSTx
         /H0CHfFntlLexUtXjRP+r74FuGwi6EagqegQ/d3cfHOveaBVBC+UEpE/nMZCSQfENAW3
         AV9ejpsIX2WIh7sRnwBswutz/8YuKOS1yR4UBpdUjYAI3j/xecqE6k4zKVtQxgkiAFcX
         HCNYjjIYb02oOc72LNF6YF6LJAjo7H3wcblvkHtwa/AbA9Zi5OD0vdVlRK+riiTRq8ke
         7YKpEueFIF64vyMiJG3NW4QyU4Dk8tvGXo15VT6TxVptfADiliSgZrBqmPqlO3Qqi/qh
         5FPg==
X-Gm-Message-State: AAQBX9f8ZflzKpu86CCY0Zv3greCGQKzh0ZMDxYfqqfsh0X9LzRT+Afh
        WcgJbsk8g3DR81Ngfgt5HdCeOg==
X-Google-Smtp-Source: AKy350b8SXOaVHs71B0PzryL6gYZwUkAWF9/MWVAL9BYOIq7rQp8WPjgG4lUStlvKPn23FMl4BQA3g==
X-Received: by 2002:a17:907:a08d:b0:94f:8f37:d4e with SMTP id hu13-20020a170907a08d00b0094f8f370d4emr707144ejc.65.1681712407414;
        Sun, 16 Apr 2023 23:20:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b0ac:4d3b:966c:b33d? ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709060c0f00b0094ca077c985sm6072788ejf.213.2023.04.16.23.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 23:20:06 -0700 (PDT)
Message-ID: <9edfca01-4191-8eca-32c6-c95f7c7601ae@linaro.org>
Date:   Mon, 17 Apr 2023 08:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6/6] dt-bindings: watchdog: realtek,otto-wdt: simplify
 requiring interrupt-names
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Fu Wei <fu.wei@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Justin Chen <justinpopo6@gmail.com>, ?ecki <rafal@milecki.pl>,
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
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <20230415095112.51257-6-krzysztof.kozlowski@linaro.org>
 <75148300a158ceb0f86043535b089838e1d1bb61.camel@svanheule.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <75148300a158ceb0f86043535b089838e1d1bb61.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 21:00, Sander Vanheule wrote:
> Hi Krzysztof,
> 
> On Sat, 2023-04-15 at 11:51 +0200, Krzysztof Kozlowski wrote:
>> Required properties should be listed in "required:" block.  Since
>> interrupts are already there, the dependency of interrupt-names on the
>> interrupts can be simplified.
> 
> Maybe I'm not reading this right, but isn't the dependency stated in the binding
> "interrupts requires interrupt-names to be present"? resource-names.txt
> describes the reverse dependency ("interrupt-names is only meaningful with an
> associated interrupts").

The interrupts are already required by the binding, so the dependency,
which makes interrupts depending on presence of interrupt-names,
effectively was making the names required.

Best regards,
Krzysztof

