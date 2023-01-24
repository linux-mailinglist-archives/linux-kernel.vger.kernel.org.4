Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2759A679231
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjAXHk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjAXHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:40:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F13346D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:40:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso10238446wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqgrYYoh+EWOFvzfNiDUZjtAea3Dxak9qwqCg1uYmZs=;
        b=Iw6RmCnB7UYWK7kSGR74JYXm36gVuMD2oo69ktEWRjIlPFJ3uJKXdHINKBsnvNa20K
         a6s62IgiALmtBdqhwlm38anPhhtKphIymExmhaarIuTy5WOIM18iqW5M2vQxqHzOL0Ob
         VAB6f44+e/uitx/Jz2LE91zlKQvD1trBEC6H52BTjjkr5zt9DXFqLogf95s7DRDamiLv
         gqhITmZDiJjRp2ecP1LeQh4bcxQTtGI8kgAgNoKpRi6J+fZglBjyXPY071TJYlGDxZ1S
         RZt2VXIe0bs3W7Tit02TVq/emcJZk9j7wxUZP38Q6Kord2ejBzNtOJgfb7krcUMQvKSX
         XXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqgrYYoh+EWOFvzfNiDUZjtAea3Dxak9qwqCg1uYmZs=;
        b=GDY9jDUYiNqQmzBJh0NHGBg7yrMeX9pS4ojmp4J+OXWnxdxWLdSMAx5jpCUZ8121+4
         cfyfzZQUHNhsx3hzTmK2KeZJ2UdTilF2P8rhZ0HPPs8fgjdThU/Ua3Kf2DaWPiAd+84V
         tHzdG8TEqE0ch9o3wYT/PW8EeoLr/X41ecL4dsvMQz63hopFB2cKJ2xtJetGiHdbL5Ii
         pHMnKTe3N3nsTlYTzr7mbtbzCSgFbt9Mxxba0aSutiHNHCcnsDf4EyKcIM/5ovJogcAU
         nI21uqtaZBxDOvVaCuKV42s9qNzTtufbkZmmQiNaERGTU9Ef4teHyb/pNwdhrndjIcDu
         I8bw==
X-Gm-Message-State: AFqh2kr9cbx3sq4FaPKg1kpPDChy56cVEMVrG7FqVAaeg2guNIzJkgnx
        ZcSU4D4ovoqn8GJCxRv5uBvxjQ==
X-Google-Smtp-Source: AMrXdXvjUqFczdJEB1osktna21bsflhjC5XBWkXYjahNjJYeA03Is1n5wsbfsMieycER48v2a2JOKg==
X-Received: by 2002:a1c:4b09:0:b0:3db:f0a:8726 with SMTP id y9-20020a1c4b09000000b003db0f0a8726mr23769294wma.28.1674546018235;
        Mon, 23 Jan 2023 23:40:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i10-20020a1c3b0a000000b003dc0c5e257esm1480972wma.39.2023.01.23.23.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:40:17 -0800 (PST)
Message-ID: <d6be59b8-b0e1-172d-0d04-f18dca1e1342@linaro.org>
Date:   Tue, 24 Jan 2023 08:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/5] dt-bindings: iio: correct node names in examples
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
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
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
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
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
 <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
 <20230121171709.5eb75e94@jic23-huawei>
 <45b9b378-6619-c47a-b5ea-6b6b7edca785@linaro.org>
 <20230122170105.6a1a9766@jic23-huawei>
 <20230123203341.GA2459877-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123203341.GA2459877-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 21:33, Rob Herring wrote:
until we've documented something. Otherwise,
> we may be just changing things twice. We have the list in the spec, but 
> really I'd like that in schema form. We'd also need to figure out how to 
> use that. There's always going to be odd things which we don't have any 
> defined name.
> 
> For now, I'd just do 's/_/-/'.

I'll send a v2 with fixes.

Best regards,
Krzysztof

