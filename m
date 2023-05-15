Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B050703239
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbjEOQGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242532AbjEOQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:06:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B61213E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:06:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so36604455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684166789; x=1686758789;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lWOCuNPc2Qhm23nE7fOQTHAU+RRC9bg5RSfsC5uCndw=;
        b=CAUxT2wohMzyPhNhiBK32M6vlIx8hjwrVFS/n+Ot/KTQtHRMY3fI6QG2sJREE1OTod
         q0kxQyT51lSIWKyeNrkRGWvXmM6VYcnE/shvjL4QQ4S/Ff4WEwb01lHxi3kURR4jje9q
         yv2/BxYGfvDvqMI2RPSrnPcYwtM7HmfKOr/IYEnmvKwFcPM2CuyqyquUQzVkKRjTpaKS
         4pHa2UrqLiNvuuDBv5dY0qoYXayT+6jQV7Kf56962q/E1fkquwmzEZ0fxvYAJ9PXlxKG
         h9ALmY7IRxNx1ck0lxQ0q1sJua1B/292RKS3TRum9Xg4Ad2WPIGs06g30e6Xa33ZqHKf
         xnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166789; x=1686758789;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWOCuNPc2Qhm23nE7fOQTHAU+RRC9bg5RSfsC5uCndw=;
        b=A1w44mcmOp0XKUX5ab2+YU+eV3lsCdCVmqJwSdHWkI4hIX59TRp5cfXdAtKF1Ic0MF
         f9ZCD7Jk0QX+He4Jg89Sy7peCxT+RPIpUaoXzYE/uqnLqFd07lCtD2CjgGg9CBtE0xgE
         vdrCgLBPkH10CSGfI07W4l8KGgv7YCa2V1+y9OdMwSSRpPcUz6IFIzxQjBtZdylLxbvt
         w4/QJRBggb6g1HwvgCXdfVPMGSOB+l4eo+BaubKVZu4N1csyhEO8PX9UjURLPU6oNIMA
         2m5szSBXlQrDicZk9PcvnQgWZCMe0VlNuHkpHk8iSSwPMN94tNKohggGZ70zVjLibSmc
         utmA==
X-Gm-Message-State: AC+VfDyZrsiHmTTfaGosSJH9UFGMZ13LoNkhzcHBOg299HNJB5e/sLpU
        GhVbptwUs86yjqs/P6GolQfdIg==
X-Google-Smtp-Source: ACHHUZ5y+S1cl668Cm09EQ1NgXHqr+j/kjOw7Ds31xnaNEbo1aQsxXOF8pRWNpL+J37Gpkvap2Ec/A==
X-Received: by 2002:a05:600c:4444:b0:3f3:284d:8cec with SMTP id v4-20020a05600c444400b003f3284d8cecmr24800387wmn.2.1684166789290;
        Mon, 15 May 2023 09:06:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ee7:a396:6195:bb56? ([2a01:e0a:982:cbb0:ee7:a396:6195:bb56])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm25497766wml.18.2023.05.15.09.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:06:28 -0700 (PDT)
Message-ID: <9fa0662e-8854-05f9-da7f-ec8e08d2badf@linaro.org>
Date:   Mon, 15 May 2023 18:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 01/13] dt-bindings: clk: g12a-clkc: export VCLK2_SEL
 and add CTS_ENCL clock ids
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
 <5cb38be4-a27f-dc1a-cbb9-c195505a9e7c@linaro.org>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <5cb38be4-a27f-dc1a-cbb9-c195505a9e7c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 20:28, Krzysztof Kozlowski wrote:
> On 12/05/2023 15:11, Neil Armstrong wrote:
>> Expose VCLK2_SEL clock id and add new ids for the CTS_ENCL and CTS_ENCL_SEL
>> clocks on G12A compatible SoCs.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/clk/meson/g12a.h              | 1 -
>>   include/dt-bindings/clock/g12a-clkc.h | 3 +++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Bindings must be a separate patch from the driver changes. If this
> causes bisectability issues, this means entire solution breaks ABI and
> is not appropriate anyway...

This is basically how we handled CLK IDs on Amlogic clk bindings for the
last years, the amount of changes is very low and rather exceptional
compared to early development stage.

Neil

> 
> Best regards,
> Krzysztof
> 

