Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1E638545
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKYId4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYIdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:33:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA972D77C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:33:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so5853890lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEtS/Sqsho/UBDb0sfFOo6Xpo0qY16Hbh7nDItyhTCk=;
        b=Sa8WmGKPniqzw3pm0pIIqkM73/LIU5QZcBbwuIWpIVvRPQqzx2p7mw2KXyz34bjAlo
         CnWb3CjQXA2JF/co8/erj9LXv5i0bpAo0AsroJ0br2iyteN1rHuWNlTkUZ8CmFrG9EO7
         XgxMkrNRjYSUGkoO4WY9ELeHQBwd89v10cj4+zv3mElg5YPGxqWMFDj1Q+E8eHf0DvEz
         6nXgeJ8N6TeEETxgfQhH37sjKXXeKEKGNcFvxRozklmU3vv+fBDbgXw514193Q3+Rkdy
         ti0kdsff1PeItPPMWGNR+3PgEQekKihAOqA3IUCG4loEi0CRzJs4zjrjgoB78ANnPato
         9ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEtS/Sqsho/UBDb0sfFOo6Xpo0qY16Hbh7nDItyhTCk=;
        b=muTlzNCdLa0u9AIPzBkysr+0A3rghDPNqfkJRNBHpQh6RGjCLltExOr/QqzJd8JCaI
         6op5fVZUacmhEdRuSz626soj7DAxQNX8Pv3nIjvlOp97QvvqRANltiazq9LUvPn4axhZ
         j3po1owS5e3ehbcxHoUUP5d/gvrnByhx5AOA0h54RyYR5CdlZvrVl7twe5+bl/WJj1Fv
         i5bbDtugvTxQqgUyO+G8MiLB5GjXeA5EeG8VvO5VjQluW2MJQ+ZUw8vV/G5YIsxY/e6f
         lrrtQ/WD2OvAJYRiVT3x80JmEfO+lt6p2RCsxTGdcCEaDiSm39THImihmQgc2HBG+YMS
         kiZw==
X-Gm-Message-State: ANoB5plFs1ToMtK6vLThCbEggcGr5zHVPZG/2GmmWOcxB1GvDr0mefa9
        CLQRc1fjJ0ggqZXHfa8XSmPz5w==
X-Google-Smtp-Source: AA0mqf6ShoBjJxNOXbS2X8k/JgWHpzM/h7gYJX7L/Po6kgXUCUVXOx9d24EHCwF7+iIpQm5bdX2yug==
X-Received: by 2002:ac2:47fc:0:b0:4a2:2f31:12bf with SMTP id b28-20020ac247fc000000b004a22f3112bfmr12980909lfp.550.1669365231593;
        Fri, 25 Nov 2022 00:33:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f5-20020a2eb5a5000000b0026dfbdfc1ddsm288598ljn.11.2022.11.25.00.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:33:51 -0800 (PST)
Message-ID: <1d27dcff-cbad-c9ff-3143-e74531968af4@linaro.org>
Date:   Fri, 25 Nov 2022 09:33:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-2-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124191400.287918-2-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 20:13, Jonathan Neuschäfer wrote:
> The Flash Interface Unit (FIU) is the SPI flash controller in the
> Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
> (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
> accessed by software-defined SPI transfers.
> 
> The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

