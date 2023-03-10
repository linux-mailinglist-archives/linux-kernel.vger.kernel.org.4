Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE26B5491
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjCJWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjCJWgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:36:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35F123DDD;
        Fri, 10 Mar 2023 14:36:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nn12so6673887pjb.5;
        Fri, 10 Mar 2023 14:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678487776;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdktugCeDYX7Xr0TGxaeM93AvHbyY1/wFRGjyxUuajs=;
        b=M1ZMRujq71QwNYOMXmSJfUAnJ1DSMCIGcvzxhEOotk682w9u9GEHysFIMuExQ7ZRAA
         +/D7VhQJAQM9USbfZQmmO9kgulOmmwjifP2lqS1qe/UgjP+H5pUWcJ4p+zq/k3eX26M5
         nE6IuGepTTXbHdzhNu/8PpHzHnRMxu7hsx4bql1bRc1kXMp/5jOGKGL2AzkIjr2YlnEn
         7XBIhyBxAuu/IVU0elGOSz0lLVKyr/Y3ohuxBqc9k9zJQTJFJM1crBoz3e52T5Hembkg
         2yS4GGCW3Isgcqyyp1vp3e1re3Bor6nDZam2Jv2enrKjHXS+wZfFMcjCnSfzOoMS+XNs
         YLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487776;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdktugCeDYX7Xr0TGxaeM93AvHbyY1/wFRGjyxUuajs=;
        b=cSB788KpbBEr8H9JUcv9bKlqs0kpnm0YrfBGf4ZrRq8k8/wFpbULBrkKOF2SxqssN0
         7wO1QtDeVXrxhUiqefWGIhc1NewFiCBV9P9pSKGzSmg/ri6b0CuCXPYVcts5qEUI50Nn
         49y6GRSMIbDc150IcC+1yz6Obi+K7NzZ5X716n0YQZm67lya5sjvN4W4vqEIanu7GHn8
         o71ojF8ibq+QmqKsoxBt2TWMylwHkxlhgRm22CDgi4fCgb28fKqPlEqWxeI1UcbB2wYf
         74Xsw846pzcSPfuvkTAE9BlY60CycX74LzqK42P+QRpbYh6g8Il+or30CuPTPm8TykKN
         JP0A==
X-Gm-Message-State: AO0yUKU0zLklR40lSjPu/Q3qlK9NzJWtYxjn+n8lsFX56vZYlXOpS2E9
        tstGPkxkwfw5VUd7//Z5+so=
X-Google-Smtp-Source: AK7set9K8J5zoNaziqXtI5ePAA7X83vRqfUPykoAs++3T/PClevhmaBdF8gk1RK17qwYtdSNKjM8Pg==
X-Received: by 2002:a17:90b:4f49:b0:234:190d:e655 with SMTP id pj9-20020a17090b4f4900b00234190de655mr28911929pjb.44.1678487776377;
        Fri, 10 Mar 2023 14:36:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y15-20020a17090a390f00b002339195a47bsm365387pjb.53.2023.03.10.14.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 14:36:15 -0800 (PST)
Message-ID: <35216994-c834-73aa-a702-d4d75bb87897@gmail.com>
Date:   Fri, 10 Mar 2023 14:36:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 13/16] spi: bcm-qspi: Mark OF related data as maybe unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
 <20230310222857.315629-13-krzysztof.kozlowski@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230310222857.315629-13-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 14:28, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>    drivers/spi/spi-bcm-qspi.c:1460:34: error: ‘bcm_qspi_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

