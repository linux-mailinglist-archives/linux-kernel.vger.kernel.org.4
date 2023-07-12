Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4835E74FEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjGLFfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGLFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:34:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E71712
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:34:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-993d1f899d7so659637466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689140096; x=1691732096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzJbnI9xDPktX2PXM2vmFGHodNGh1pHwZKlhR5E7tY8=;
        b=D+ciM8CzGJruO0NevH+0m/2WlZVARC7yZe+30xiAI07MJevCs5AYYvaKN4oqSK9iSv
         kAeuL7tV3jswlEA+DP3L5qRlRpgL4k6K15CcnUZaIyMOM0tnXvBfyfbQd2zKk9klpKGU
         sKv6ZWwXS/UM0wVaU4JN9302AM5wyZJk59zWFDh6fe/5Xxtvguquftn4eDWqmjRs2cN4
         woY95YCRLU7W5nkdOleKvYIWG/qSA1NWC8Jx9E+Od0PVOmG9izcoYU93Pl+G2KV9nIMf
         W3sYFSD0UoQwU9inQ3opeZb0GwMuuecJ1ZhirvtwLGX5ufejF1hj0hbpN2TtUSQ2dG5k
         LY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140096; x=1691732096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzJbnI9xDPktX2PXM2vmFGHodNGh1pHwZKlhR5E7tY8=;
        b=UXPjYUwXznfN9CW3EtHbVH+DshJfvZ8abQEuxo0VqvVDDX3Lr/vm0eJs9SR3XYbL6V
         Ka+J8Le5PAugad0z4f7GI0kOfLIIlpWamti8qC5qet9IHYaGsAO2jC4d9PHHt6xcOoyd
         PqMZ11i+sCjsWXk+75u+e63zDXxy7bP6piekoVkkZGBRXWk/5aHnGzcNdNZwzgBohWYy
         w1yyKbR8+OVuPl31XFKwXuP4kQumbgPA19ey/1xClyi6U0lFX35+So6PppwsQ3RSYgGE
         eHQuXfvy6O9gzT+ZDnbpRtCTKCcUHguKhu8gVwVG2GOq6VRzXrT2aEhlH7Sip50U3drB
         ijbg==
X-Gm-Message-State: ABy/qLZUzfusq419/q3ikgafPrPxMObVpjObxxlja45+lS+h1I/qJ7k/
        ZyFVUvl4PMLF8ADhXOkcbUg9Cw==
X-Google-Smtp-Source: APBJJlH1KLJ6R946VEt7ThL/DnXhPEDSh8WytqCiKirxOQ/jpWOssUPPgI4BskjuamxGT4fAc/YO/g==
X-Received: by 2002:a17:906:b04c:b0:98d:5ae2:f1c with SMTP id bj12-20020a170906b04c00b0098d5ae20f1cmr15383503ejb.34.1689140095525;
        Tue, 11 Jul 2023 22:34:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id cx18-20020a170906c81200b00992e14af9c3sm2039633ejb.143.2023.07.11.22.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:34:54 -0700 (PDT)
Message-ID: <c2ae813b-c6d3-0137-b3bd-2938345ff186@linaro.org>
Date:   Wed, 12 Jul 2023 07:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/9] dt-bindings: mfd: Add bindings for SAM9X75 LCD
 controller
Content-Language: en-US
To:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, sam@ravnborg.org,
        bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
References: <20230712024017.218921-1-manikandan.m@microchip.com>
 <20230712024017.218921-2-manikandan.m@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712024017.218921-2-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 04:40, Manikandan Muralidharan wrote:
> Add new compatible string for the XLCD controller on sam9x75 variant
> of the SAM9X7 SoC family.
> The XLCD controller in sam9x75 variant supports interfacing with
> LVDS and MIPI-DSI and parallel port RGB.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

