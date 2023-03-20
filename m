Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FDA6C1F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCTSPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjCTSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:14:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FED1F5E4;
        Mon, 20 Mar 2023 11:08:19 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id ay22so2805213qtb.2;
        Mon, 20 Mar 2023 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTfm42DRLF/pqyQQSDFQRYTghzUDIMmwNt3uFt+5ZVo=;
        b=BDEvdS3CLR83im0McPFo89WtIVScQY2XOoudmTKAtD+7y6l2VP8PolUya8K44BjpOC
         UNhptTv7tYmCF7587hlCu8wMCjxh3UlzW5YI7dIYr2IqaThnuB5vjuElL/8yFG/TbL1u
         g+bxDQ3cpl37yZ4mJXvqzSkaXlAJmhxktqwjnGEv5/8GcgybHyB88Xjcdb6LcJid2CMG
         Tgr/6vkH+C3QbX1Vx02hmuMBA2JuYYZbfQ3PwVMq/VHZ7xqc1ObultPvPHLmrgbQ7utT
         1YhGEzJpkmML5NEYRh0oX96np+sJT36GRFFdEr3HeaujoCmlj4II5jXEKyIK/wCmGChO
         FKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTfm42DRLF/pqyQQSDFQRYTghzUDIMmwNt3uFt+5ZVo=;
        b=8KjoxOtsqVa6DPz/LZ9QAWL2qumQJmfoE+KGbcs3OA6n06DFsrcnldi5r9njH2Zx/s
         EaMJKC2TMcCbkHZ3DfW4NuvgEjn+g24Y/PAb64B6p1/Tij6ZF+TexKD7eJTP/9q5KDrj
         8nPh3lqsFg5B80ZP1TtD+M/rZQ6Ye7zqDl+1d8jWAmL9LV9NAPmFxY7bAG8gSB+B8FwH
         9573JuirBimgTQuJRhVAK4xWyrXCd3C37D3ukHYDjOmrtE+9pj8GG+IvhY6O49Ow8hfM
         tRau5nZUxKYwFQ19TpOsmd50xD1Wn+8ZjKP6mdJo4J9QOABw3FGisAXHLSSl1Oi9hnzz
         UnBw==
X-Gm-Message-State: AO0yUKV9m76o5dPZTVteKqmH4NcMNGZpJashL3MgrkLkEJwmi7ptxG+h
        ntajfayFmS303mR8ZY1rgx4=
X-Google-Smtp-Source: AK7set+ZUF3yUcqPxvT5JrSdC2gQaXGTs/LVLEDznrAr6g4pl8nC/T/ix9WBdEtY73cm15/2Ejntww==
X-Received: by 2002:a05:622a:144b:b0:3b6:3a12:2bf9 with SMTP id v11-20020a05622a144b00b003b63a122bf9mr278501qtx.2.1679335698248;
        Mon, 20 Mar 2023 11:08:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v26-20020ac8729a000000b003e2e919bcf7sm1297578qto.78.2023.03.20.11.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:08:17 -0700 (PDT)
Message-ID: <bbea4d6e-4435-7337-adf8-325c2f534bba@gmail.com>
Date:   Mon, 20 Mar 2023 11:08:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: watchdog: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230317233643.3969019-1-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230317233643.3969019-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 16:36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml   | 2 +-
>   Documentation/devicetree/bindings/watchdog/apple,wdt.yaml       | 2 +-
>   Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml     | 2 +-
>   .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml         | 2 +-
>   .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml          | 2 +-

Acked-by: Florian Fainelli <f.fainelli@gmail.com> #brcm,bcm7038-wdt.yaml
-- 
Florian

