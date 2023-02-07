Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED968D12F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjBGIDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjBGIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:03:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DBE2A9B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:03:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so12681001wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 00:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E78KEV2zw6cCKo7DmceWG9u52MGGfuKullTFi2kTXL4=;
        b=GQtmllZam0BKdbeDa6yOOj+xt/Rj07oSilktliqDqWk5mqyVP9nkmc0VojdUyuXTKb
         Gec4NWri0CXH+PNixZpoc59CWEqO2/3cs2cEELZZqF/kwo+oOdxbKgVGTL/gtOlx6NQn
         7KgaVL3x6LpWAclBqu5P/dsvYJHnLkmR2y2Q+Hz4CU+eba2HUR3aNgxmquB19gg0PfNh
         ZhfPpzfCjZfcN4Pj+Y9KTRuvxFG9pcotOwfvwA5z5Bo1gDBSxkKKoNIwTGcQd09VmVZr
         YIx2fRmc9Hr5rkBR0UwINwUqjE12X0MZc1EWyaL0nEaIt4igiBUrezV48g+a4UBPR28+
         yPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E78KEV2zw6cCKo7DmceWG9u52MGGfuKullTFi2kTXL4=;
        b=cKwVOLMzfP1eLpmP8oYNymSlvNzQnmAQARxUcukiQOvXplP05/Gx7Kk0yzcUeSvU6H
         65DbkugxHLzAIEA7iozYWDlZ3ai1Kky4X1BywFcudDKALnpXMMMfaf1cA/gsz+D/Nd1J
         oZn3irxUYYqNRRyfiD/6NfUlpsXWJrswWaU4ntHCyRlXKfLjIqBWao0krLMgHIlWmsvu
         MJQZHXE/glBpu010KTWpn1H52KbYcOdd6xxM3OEk7KpWbMRraypJ7ffE9K191d3JN7gz
         94naPgUrezXq3N9IrgMtMCVEHHjix1D8yB7pu9rewWxOIwGpnqN//VscT7qxu/3/sMe0
         8Kbw==
X-Gm-Message-State: AO0yUKUlZU8QydODrbgtp8XdLtrNwVR9BVI2m94m713fKlNhkElM2bpt
        dNYTQ+pcLK6kDEXoU9RTcsAFWg==
X-Google-Smtp-Source: AK7set/TvsYNzGbcUYiEGGIuyDm19cY1a9rOK243MMxy3KzH6y+IJJE/hY+yk12ycDNPKM+x2Ovdgw==
X-Received: by 2002:a5d:67c7:0:b0:2bf:dfa2:976f with SMTP id n7-20020a5d67c7000000b002bfdfa2976fmr1809497wrw.39.1675757025283;
        Tue, 07 Feb 2023 00:03:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v1-20020adf8b41000000b002be505ab59asm10932664wra.97.2023.02.07.00.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 00:03:44 -0800 (PST)
Message-ID: <453d52a6-5c27-6f77-8133-e3238b87eac5@linaro.org>
Date:   Tue, 7 Feb 2023 09:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 02/15] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207065826.285013-1-william.zhang@broadcom.com>
 <20230207065826.285013-3-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207065826.285013-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 07:58, William Zhang wrote:
> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
> controller. Add new compatible strings to differentiate the old and new
> controller while keeping MIPS based chip with the old compatible. Update
> property requirements for these two revisions of the controller.  Also
> add myself and Kursad as the maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---
> 
> Changes in v3:
> - Remove the blank line after maintainers tag
> - Drop the minItems for brcm,bcmbca-hsspi-v1.0 binding requirement
> - Replace the old example with the more recent and complex example
> - Drop the generic compatible string brcm,bcmbca-hsspi
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

