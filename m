Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8102749E37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjGFNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGFNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:53:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6071FD4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:53:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e29913c35so1117119a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688651599; x=1691243599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPEzdt5vw44+M4gmXEM24Z25S5TAPcKwUGBEpWjsTdQ=;
        b=obxZS7+ft/Fv0S44gKLyvG/X9b9ABfexExDbaUc1GZM641C10i+s75gmHcMVfCnYQD
         uoFz9K9L8AQeBgJxwRfVRgn50qyayMdZnYBE4Dv9TRMawaJiZa5+xkpl1R8qeg+SkbYe
         h2LRJqRrm/7biEmXHVwkJwBAd5o8BOcOyxyQLfav2jnv0HusDJhQQ0yzjgCIeOzcV+7G
         yE8Ws8qO3xfkEtFriIydzCUdetkUojISlNT4SEgodwO+HWfq+e/GExCRFqkeuvZeF8Ul
         /ToeESiBhx7sX7CuAF95sznCmn4LftL1mGAWMjzaySzubIhYSKqu9Ng5lrhsbYCG4ebf
         4JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651599; x=1691243599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPEzdt5vw44+M4gmXEM24Z25S5TAPcKwUGBEpWjsTdQ=;
        b=Zatm0LhTQu0afudUjqItlECoubat4+cFypZarO0mmp6ULexSb8aLyJHiZ2vrM81F0T
         P2tNGfpd2dU7Py0YSoCSLWtK8nXeFHN+6Kqxx74Ph44G1sM2mclTIp83bmRTH8kLw2Q7
         XP4mMSaBM45rip7o0qU2qOcbE/l4yanSOUH6CCHkCIhv5QiudNHxQQalHhRHMYyXZM84
         4WAVwxWTd3vwYjYsD4VWzM6EFTqUdZZFjnKoNgHQON0UvVaKZdubpeyQImR4w35v7cjv
         SdV/h+SbjTkgs5tpLyysnailnFJDpC8NLNupr719qO+jcPN2X98AbJLIDTejnhAOfKk7
         e2Uw==
X-Gm-Message-State: ABy/qLac9Iw2x3enRvucjAQ1g4yBFI+SN75IzU2p5v8GF5frxlYEt2/m
        niZl7KM22e30EcfN1EVSP13wDQ==
X-Google-Smtp-Source: APBJJlFm+y4dHMOcJedxZQfunsZdLlAk8L53nNHkNvTuAWcu/qlnBKiJUAFV8JDXvtqWuEp+4cZq7A==
X-Received: by 2002:a17:906:1013:b0:992:9907:638b with SMTP id 19-20020a170906101300b009929907638bmr1664126ejm.6.1688651599593;
        Thu, 06 Jul 2023 06:53:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906c30600b009934b1eb577sm851191ejz.77.2023.07.06.06.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 06:53:19 -0700 (PDT)
Message-ID: <385b2a3d-2f65-53da-5219-55f530b92d12@linaro.org>
Date:   Thu, 6 Jul 2023 15:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: imx8-clock: Add audio clock
 mux related clock
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1688607078-4183-1-git-send-email-shengjiu.wang@nxp.com>
 <1688607078-4183-3-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688607078-4183-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 03:31, Shengjiu Wang wrote:
> Audio Clock Mux is the IP for i.MX8QXP, i.MX8QM, and
> i.MX8XL platform, Add the clockid for them.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

