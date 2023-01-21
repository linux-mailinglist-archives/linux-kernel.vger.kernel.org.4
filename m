Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626C867680A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjAUSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAUSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:31:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6641DB90
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:31:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso7933840wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwoDBvRhZ51HVwRruPaZJDCI07MDbJL4OZ/OSacJub4=;
        b=DXZKAycNcbv1iXdoy5RHgDDWZYz4w+4tSZhy7uzlZ9WRKzJP0NHHQJfd+DVK6/tnoH
         r0LTdWDEOFwGr8v5G0MY8ojjJ4DNAlLLqpbItFA0EFgwFJcEisGZ+af3rxoFmuCZIUy3
         nX8GimRZPlWnpgUn/oFN7WktFnkdjfLqP4bWRObvDi/5Mj3sochYa7CCTEIjGWrZykPY
         5eUcrPhUqIPQag//q7hEEA7V7NR/4nLP4zSA87Hd7j0GRbZxRbI7v8M8X64YSyad29En
         O0cAi0zkhFgAu3eqbW5Fsxiirur0CXaQB1EGjsZnxMPQqNtW1i0Qs6cPKlj3pP9GeBfr
         tVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwoDBvRhZ51HVwRruPaZJDCI07MDbJL4OZ/OSacJub4=;
        b=fQhkL/AwLVfleS/PW9NNYmrmdeKjkr8xWuUamsCIJItJuyvRIuIWMXvpgKXEosmV8a
         mdzPr0WCTJ6zn+wMJYP0dC1tkPGNjrOBBFtHRemU/03BNexk2TrAqocvVp1iRJB/QTHH
         XvuRtARlphAfAIbROVxmPhu2hYXgvsuEi5fx1Pkd25J1ABIswVa2nk2MXmYSvVQ6Aq2c
         2KL1/KExIJuydYVBIBVAYddgzeBm41dJcDJ1xwpoZClffEGdK044tGkzZjsMbqup1z8L
         T+TrRIQJ88J0iGrpo6r+IpFDhCb4bI7jMojdjLRD4GYUqB9xHvEFnYhoCgEY2yNSOmYc
         SFgw==
X-Gm-Message-State: AFqh2krOt1OuVUlOaXPY9cJzlUJjc/mWxjNXWjZK97RF15+bKX40WhW+
        XmGq8mkuZWkzwAWBBAI7KzzhYA==
X-Google-Smtp-Source: AMrXdXtzA0VhWJr5PaMDSwqlmcQOuGEVhWjqw2Lcr/7uvjQ2leyTYFBOPlCVPt9XkFdATbe08+PT5Q==
X-Received: by 2002:a05:600c:5386:b0:3da:f670:a199 with SMTP id hg6-20020a05600c538600b003daf670a199mr18285088wmb.36.1674325889305;
        Sat, 21 Jan 2023 10:31:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003daf6e3bc2fsm16026540wmq.1.2023.01.21.10.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 10:31:28 -0800 (PST)
Message-ID: <45b9b378-6619-c47a-b5ea-6b6b7edca785@linaro.org>
Date:   Sat, 21 Jan 2023 19:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/5] dt-bindings: iio: correct node names in examples
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121171709.5eb75e94@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 18:17, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 19:44:11 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Do not use underscores and unneeded suffixes (e.g. i2c0) in node name in
>> examples.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
>> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
>> index 6c5ad426a016..12f75ddc4a70 100644
>> --- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
>> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
>> @@ -42,7 +42,7 @@ examples:
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>  
>> -        heart_mon@0 {
>> +        heart-rate@0 {
> 
> These are both heart-rate and pulse oximeters so measure more than just
> the rate (oxygen saturation in the blood). Reality is they actually
> measure light absorption over time, but you can calculate an estimate
> of both rate and oxygen saturation from that.
> 
> I don't really mind simplifying that to heart-rate, but wanted to
> call this out for possible discussion.

They could be heart-mon. The fix is mostly around the underscore. I
don't have any arguments for changing it to heart-rate, thus we can go
with whatever you prefer.

Best regards,
Krzysztof

