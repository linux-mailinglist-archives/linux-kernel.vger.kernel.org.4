Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2885F5E667B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiIVPIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiIVPIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:08:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D0E118B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:08:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b6so11334252ljr.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=W3vQjpL7ZnOEsk11xcAIlC0+5dqOSVrvKlDZwfBKfy0=;
        b=Sy4HPnU+8WeIlCPD1a3QGFYQ+B961P/HPkm5OwWMBlt94OoZG5FSmVTwp22I5HlS4b
         ctDSD5lE9UqypAqzV3Ye2vSeu/qR6hFaWgosV5Cvs6BZR4QSNF+sJMcfgBXL6Nc+HhUH
         rjv0UT7ps7zRElHe2o3+Bt/qJUaoHrxv9ned93Zmkiim4eW/IF7PQivZnpyU/X6TYm3x
         Oh1ifevg6nyKn8raMVC7CsTkJZhlHoyE8tiA7A/rKM9prCbIBmaGyy05vsnNlvWs23sN
         RuehK72x1PFy9EBkbKt+jYGu3oEHCjUeV+8nGz51JPSTnJQEPgfSdVXwlxvTp6W9g1s4
         odrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W3vQjpL7ZnOEsk11xcAIlC0+5dqOSVrvKlDZwfBKfy0=;
        b=8ChYuD7V92v1lS7bPl0HCYe26n853vy1EdqZ/9y8R/UXzngz8zeuxN24izReobYhR2
         PVipTIOiedFyWb9KoqL24TiSwYALf6e1xGKUtjS2chZhRDNi9dfJ14Syqk37wt/MDUg+
         F7ha6YsR0r8UBkvQgmQikvQzBDPLoptu2QQeJpCwHBErVjWAl66OZSwOvwwRoGpkcbIn
         GfhSiWn+Q4gf9UAKOTR5d/sdtX8lKp3rc9r68xm2BIxlyy75hLYiwx33ndQ3sgcJIjSm
         JB34TTKDTCaqD43c9AqWljLuY8baEmtDHwciQNCkYsx0NBQpQpvW4/Rsji3jYNhXyMq/
         A8hw==
X-Gm-Message-State: ACrzQf0FzP8mkSNGEJXiN+pMXYG1vUKDdiXPh6ZdJCn7jQeZ2udj/+wF
        kip3azU0OjiPflYp/DT7uTQDOA==
X-Google-Smtp-Source: AMsMyM4ZLEtwzvNmvLE0cJjaCdT/ninGxqDvzBTCYY81SoYE7F/67rI94RH0F1rBn1/sklyiISA3JQ==
X-Received: by 2002:a2e:a228:0:b0:26c:5aa5:bdc5 with SMTP id i8-20020a2ea228000000b0026c5aa5bdc5mr1202937ljm.418.1663859316068;
        Thu, 22 Sep 2022 08:08:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0026c42f67eb8sm963196ljc.7.2022.09.22.08.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:08:35 -0700 (PDT)
Message-ID: <21cc4e52-d0d9-8f07-fa74-ea62bb01432a@linaro.org>
Date:   Thu, 22 Sep 2022 17:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 2/2] hwrng: npcm: Add NPCM8XX support
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, olivia@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220922142216.17581-1-tmaimon77@gmail.com>
 <20220922142216.17581-3-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922142216.17581-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 16:22, Tomer Maimon wrote:
>  static int npcm_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> @@ -102,6 +103,11 @@ static int npcm_rng_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "nuvoton,npcm750-rng"))
> +		priv->clkp = NPCM_RNG_CLK_SET_25MHZ;
> +	if (of_device_is_compatible(pdev->dev.of_node, "nuvoton,npcm845-rng"))
> +		priv->clkp = NPCM_RNG_CLK_SET_62_5MHZ;

No, don't sprinkle compatibles here and there. Driver data is for this.



Best regards,
Krzysztof

