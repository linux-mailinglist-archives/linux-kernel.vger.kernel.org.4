Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D008A6E3286
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDOQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDOQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:48:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640864239;
        Sat, 15 Apr 2023 09:48:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so3665183pjl.2;
        Sat, 15 Apr 2023 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681577287; x=1684169287;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c07ixhDHpQnBulkQZ2Nw0JwAr36rnVLPuwgUhNxAuT8=;
        b=VAm7lLW2qbtDmFHkaygXoNVicYRA7IQ6GgoHgPsyCQNfa+OPX88B/mb3fyqCdcZYlB
         Qb6vBWg9yf0V1FZ1UQn8AGxwQkqUXoHNh66IZq4PycRZbyKno5D9WgQs5jpy9jFw2OXy
         ce4dYeMqFtLPPcZeThBJekZ6hAAsuKU1TctgtzHrqbIhKsI2kAQJ4q4Gs3G6ONvGbrWK
         Ne6ZQXeA5MJrTDw9XVhAgoii6otPIhbaurxAW8ahIEkNhLiakjovuK/CPOrgqQXhSbEn
         qRGynIgdugnm3uE6whko3Q6+snSfYAMf2eC7Dp6jXGfBroLZjjfXXrZ1Yl9zLi2CHTyD
         LS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681577287; x=1684169287;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c07ixhDHpQnBulkQZ2Nw0JwAr36rnVLPuwgUhNxAuT8=;
        b=Du79Q7BGy8niinCuEch2u2IXDvZs1gAn2+/snFFhMMXTSLm4expfLI/pcJqcEBpnB2
         zyxMVcraBN2Gu7NtK9LvgnnyX2QxhiOxNOK3vqFyXRx4Ep68k/wEyTQPzSZR5qmPQ9CO
         WZlXLnNvp8SchTlB9fLD04kMwQhlJtpzft/rU0IW3NzamKulYeh846hCZkSICPbifcSi
         0NwABspT+SvcjteBpRNFnC9HHKLaYGrf97FjukcOk/6+8bU5wH8HuzvMdk9LbczbcyOZ
         Pk1AbSQ0hcPw4r0NOuKSB51YXpPCUEVHHjIezzOJPwdAxt1R6Ckcgneoqwk+Bpeyags6
         F+7Q==
X-Gm-Message-State: AAQBX9dWdbGexbGwTxP7yNl9aWR6DFf9JjWWZkf8rvnGYHMwUNAfs7ve
        Be9wY2mOzMWjhs8zTXI+wwg=
X-Google-Smtp-Source: AKy350asRVcaBN4vEj52+Al3i6LdhYun2dQh4zNs0zIu8tfWua87lcM2Lbo7pD9ZdRNAVxvnTiBCow==
X-Received: by 2002:a17:90a:f409:b0:247:900:12db with SMTP id ch9-20020a17090af40900b00247090012dbmr9261041pjb.24.1681577286671;
        Sat, 15 Apr 2023 09:48:06 -0700 (PDT)
Received: from [192.168.86.135] ([136.52.74.64])
        by smtp.gmail.com with ESMTPSA id r11-20020a65498b000000b004e28be19d1csm4492195pgs.32.2023.04.15.09.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 09:48:06 -0700 (PDT)
Message-ID: <f059c09d-b9a4-d86b-e4bb-1aea096263f2@gmail.com>
Date:   Sat, 15 Apr 2023 09:48:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] dt-bindings: watchdog: indentation, quotes and
 white-space cleanup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        Sander Vanheule <sander@svanheule.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Fu Wei <fu.wei@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
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
 <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
From:   Justin Chen <justinpopo6@gmail.com>
In-Reply-To: <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/2023 2:51 AM, Krzysztof Kozlowski wrote:
> Minor cleanup without functional impact:
> 1. Indent DTS examples to preferred four-spaces (more readable for DTS),
> 2. Drop unneeded quotes,
> 3. Add/drop blank lines to make the code readable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/watchdog/brcm,bcm7038-wdt.yaml   |  6 ++--

Acked-by: Justin Chen <justinpopo6@gmail.com>

Justin

