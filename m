Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467EE695CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBNIUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjBNIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:20:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6C20D05
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:20:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g6-20020a05600c310600b003e1f6dff952so417313wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izobyQ1NMEnMgYx3aG67EjKArFST7vbQadFNv+PRN14=;
        b=e623hJjY0nq55QmrV3FmDZhsTaGnlYGpkb5a/NlwJ8OVeVyBRVHfzEO5WsEXYr6jr9
         ji4WqXKAi7P0AnvbP5em/LPa4F/QCJdN4EuqHs4fkjSQ0FOqq/hkt/kO2u0PCEyG9FYp
         Ud35cWzurwv5A+ZP6zmC+JZR4q7tfgJe8wsa4q3S9Ena2pyVSIaCpWpNfNz52Ls8YrLM
         zz+CWpkLTzimvlytrUxGojyrZVRUbw/TXPzt42Omb0yJWrvMMtp4KQrvlWeGFEoeAwMz
         yWkIsPgarmN0fOM2MRznlGBvDDh/dE4ogTXXT/rvLUHwliWOQbH88SVI1IZI5zg/4YVN
         UD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izobyQ1NMEnMgYx3aG67EjKArFST7vbQadFNv+PRN14=;
        b=D9uArpCX4+NZGWna5HJ138TscAPAsxPEPVWWK/w79oi1P2Y9PmuY2xHtA5wW9uNQ4R
         8BUg0j1KmneK5UbS8P6Kl8gjrj9ZrpnIJ4zFNgaYrJtFx/MfEFBV9oY2MqTDmdIe33vx
         JpTLMMwxRKVeyr/FL36LKz2byWhDtcjH8xAB7BmQnexLAdVKzc1ounba2WNVfylsoXF7
         PdXlSSv4oxLPQ/IF4jwvvBEf1MgAH606Il5eD0QenDicPrtKVAqE2wXFDuiE6hcsclaS
         /pYYK2kOVWfTIiUZmW54sPw3gXVtX+RqUX3SUELyRQuDC5OGouykPE3lG2KJUHeASGYv
         K3jg==
X-Gm-Message-State: AO0yUKVxeJHMVgZgX7cWiQTMg4Z72FBVK8n6CWtHEJvEFNUa2EK51jDC
        hqFsWiHnn8RsQ/YB0XmQoo8O0LrR1nvhGmak
X-Google-Smtp-Source: AK7set/BYiTFnAIR6oywWOJ6lKyzhUlLWXUgWHgo5JkvWZIniPygAfmd/X9e8qtSTAsEYVTIj7ymVQ==
X-Received: by 2002:a05:600c:3319:b0:3dc:5b79:2dbb with SMTP id q25-20020a05600c331900b003dc5b792dbbmr1409975wmp.25.1676362848324;
        Tue, 14 Feb 2023 00:20:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c170a00b003df241f52e8sm15364898wmn.42.2023.02.14.00.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:20:47 -0800 (PST)
Message-ID: <8a3d2e67-359b-2d7c-6f98-42d716b870c9@linaro.org>
Date:   Tue, 14 Feb 2023 09:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: spi: spi-st-ssc: convert to DT schema
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230213192349.17101-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213192349.17101-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 20:23, Alain Volmat wrote:
> Convert spi-st-ssc.txt into st,ssc-spi.yaml for the
> ST Microelectronics SSC SPI driver.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

