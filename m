Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710C7700B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbjELP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbjELP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:27:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A77E2D64
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:27:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965fc25f009so1557012366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683905256; x=1686497256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0ut4B+E0h3ijgKitKEhlhSfAINQTp1vAT8c6mNpva4=;
        b=cZuCKD/vsU6tZh1/XVNGy0WAzBPs2z5Kp0Yqlo7tUpsH9p6YFSGZaEKZgBfuHL2n0X
         79Q5Dyhq7QRNDw9ak/D9IPjYaEDDlQKx0HWgjNN6w7pONk9ija4JI5TgDfG19x2korv4
         v8gs4GoxxJpMzSBon1uie9LeGj5An60PugmB06wq8oy/Z2yPMxA+rxvjoE5QPeySjiuU
         Cxj6mPf9mInKPY/xTI6nmf6HXdW6B15iy4yPOLCIsMxfkQwcGNk10GvHni0v+ZhrhuXU
         yHWaBLynVhpWvYFvQqzWgZfXDrvMT0KvYZCeiLUu5kmwCXdmdJX3RPs9yGAQ61xMM7PG
         OIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905256; x=1686497256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0ut4B+E0h3ijgKitKEhlhSfAINQTp1vAT8c6mNpva4=;
        b=EbXJFEpq51QNTSFwSI3ySkpBElxuLZOdeJZuWSSNNKIcfwkvtbmqsd0mJMw+6+7UtI
         1nkFQMWWL7HQ+5vervZUryLERLrN1otf0nJNebVNWCyrFtnbe/4qp41INhApPoLOjuJM
         fArcTwGfvOZRlZm4W+jp4suxmMLXcLX70zJEfWHozF5O7eZav0hIxSorl6GJPwo6aiAA
         kxO9ZfX7hQgd0kqxLLuhrolKJ1qg8I+R80T4samqyF06QYhPhjSEWVCqIKbfCIJRorEw
         0sws6qjtWVQoEtVXHsJC+YBdv3SNDC803Vibhkx4aTlxwBIx1ljsqhTgHB2D6igfeYhE
         87nw==
X-Gm-Message-State: AC+VfDyIWQcWB3CXINO7C6k9M9PmNz+6kQJPSLFBpeYyeyfSQqVqWikj
        y0EEoaPWf4WoumzLLcvK1JGCZA==
X-Google-Smtp-Source: ACHHUZ52+8WNQ0S8g9+pFes5+4q4Z5a4cjowDKRjpT0CodUm+0DDZKCTAGcXZhW1RTL6VyFOzjiP+Q==
X-Received: by 2002:a17:907:7f14:b0:94f:9acc:65c9 with SMTP id qf20-20020a1709077f1400b0094f9acc65c9mr22694649ejc.66.1683905255980;
        Fri, 12 May 2023 08:27:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id ty20-20020a170907c71400b0096621340285sm5515134ejc.198.2023.05.12.08.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:27:35 -0700 (PDT)
Message-ID: <80f5acfe-a32c-48cc-590a-ee02d2b494aa@linaro.org>
Date:   Fri, 12 May 2023 17:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:28, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> The IRQ chip provides IRQ functionality both to other parts of the
> cs42l43 device and to external devices that wish to use its IRQs.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +static struct platform_driver cs42l43_irq_driver = {
> +	.driver = {
> +		.name	= "cs42l43-irq",
> +	},
> +
> +	.probe		= cs42l43_irq_probe,
> +	.remove		= cs42l43_irq_remove,
> +};
> +module_platform_driver(cs42l43_irq_driver);
> +
> +MODULE_DESCRIPTION("CS42L43 IRQ Driver");
> +MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:cs42l43-irq");

You miss the ID table. Don't add aliases for missing ID entries. They do
not scale and it is not their purpose.

> diff --git a/include/linux/irqchip/cs42l43.h b/include/linux/irqchip/cs42l43.h
> new file mode 100644
> index 0000000000000..99ce0dbc96a77
> --- /dev/null
> +++ b/include/linux/irqchip/cs42l43.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * CS42L43 IRQ driver external data
> + *
> + * Copyright (C) 2022-2023 Cirrus Logic, Inc. and
> + *                         Cirrus Logic International Semiconductor Ltd.
> + */
> +
> +#ifndef CS42L43_IRQ_EXT_H
> +#define CS42L43_IRQ_EXT_H
> +
> +enum cs42l43_irq_numbers {
> +	CS42L43_PLL_LOST_LOCK,
> +	CS42L43_PLL_READY,
> +

Are these really used by other subsystems? Your IRQ handling should be
anyway next to the driver.

Best regards,
Krzysztof

