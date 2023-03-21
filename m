Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073366C2ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCUGtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCUGtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:49:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990D3BC6D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:48:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so55784049edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679381319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFoe7s9Q5oVaduws1BX9RSp/Mxew6VmyW+6mh+7NIWw=;
        b=Nq14bAe/7qrYwW9E3lwH7ZXnBkDGRSza7nWGbI/11Q9h+J2wI9hEnnLkHMri+Bwsvg
         Icr81XSgnEdcDL73Ef8DtWnQkhZhco1d9KN1htcXJkBOJ3D7Z3B9T1yHH8C0AORiKwWe
         yUBEDaT6tnFr3lZq6HUUBPUq6TWUOvOUHerW43jH41RJkhH3c2fAm8qBpGpNicDe24gQ
         QYT2xkEsWId/ccw0XnimKvo06FaP7fyKVuomNG/qNCLOJVCiVcn40U0JgIADl8wxp2RB
         jBtqO59GSwENrPOL5PHYTbN7as45zOJgpsxg+6r+z4vDQ2jR9nuKiJmWMix3QZ7MOICD
         ivMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679381319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFoe7s9Q5oVaduws1BX9RSp/Mxew6VmyW+6mh+7NIWw=;
        b=l18GioV0ff9DQsSUmHVvX2aKxAs1lG7O7/2BdcpcySgUV7s+K+9K4zDO/gc37CtHko
         wnsRj3HaugVFA0ylt3HNVHA9BNi0XF2rRz5QD8LH2Zu6p+Bt4fMep7bbHVNa4tUg/0Zg
         jEW5d7UDeuYFlLG9mQk03rcjDqet9MpmIm8A2yGNPdxKXYjtNGdrJfxx3D4Ocsaa2sNU
         3+vzTMDyzMbZth2di4hCfjn93KzgLfvc9wEifR/5VCKLXRSjtBjoNEDoLD1idTfZLz+R
         C+h9WWVdWfrX4jwIiV6by+qeF06ph4V1ikl1L18nVfSAsB3629bsCuJTfqOHmpYzStNu
         zKcA==
X-Gm-Message-State: AO0yUKV29t+hbyMbpoB4ffXfBDYkucC+3RkzMMf/zAvKoIydeYoE+iyg
        JqIm6HmtpDayD6m38v0Lx3IlNA==
X-Google-Smtp-Source: AK7set+arCBZj7aBwChVJp1qpaFp3zJGEwSWUXpgXXMCV1rRlFEmQ2IAEjYU/K7IDI/supfKITLtfA==
X-Received: by 2002:a17:907:2ccc:b0:933:499e:62a7 with SMTP id hg12-20020a1709072ccc00b00933499e62a7mr1761803ejc.49.1679381319141;
        Mon, 20 Mar 2023 23:48:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906245b00b008d173604d72sm5438573ejb.174.2023.03.20.23.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:48:38 -0700 (PDT)
Message-ID: <77848bab-e7a7-4df6-17d3-c15e3e206ae8@linaro.org>
Date:   Tue, 21 Mar 2023 07:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: input: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230320234718.2930154-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320234718.2930154-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 00:47, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

