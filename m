Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9520B6196B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKDM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKDM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:58:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2992E683
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:58:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so5353389wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwyHad34mlqqMFn53iMCM8+Gqhzyvbyy9wGcSB66m8s=;
        b=neP1+M2g3j63Zk6HSrC43BrOUyCjmbe3/+IvveBVBi7gFujI/d+PxhgurHM3X/AWLP
         on484xeONjUN3C9AolgI+T10FS8j8TopMXBAWO14HZuYKvgO+eycy2CHuIVgGsjBsj7g
         2kurz8SrJM1ePJrlnrfcMAM7ZH5JyzdEaaw8uCXdV5U9EjrNc/yUX4lYJXYRLBMhNI8P
         FvWZYCEUmwfcwmQUGEJI8WrkGqvfdKiqJ1OUHYs4EhJQOzi0INPeOvoLxoO8Lgg/yLNQ
         8O8srjXkSmkuXFCQ59OJG1nXKFKtfI1xxMqqwlm+ryU15Z7qxmhTysmN8vSxZh0lNuQB
         jAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwyHad34mlqqMFn53iMCM8+Gqhzyvbyy9wGcSB66m8s=;
        b=x+FoPsohV/Pq2yNRzM10Vc9WEHzJW0c3AXKoYJVefJ8v3FqEpQ/lQNYrNvMhtC1VqM
         9sy9knbErSyvrrI3k4GCNrK20rafdvcnL/YDvWPQbf6FZfOTYUWqzttyADGxPx5Bmrny
         h2UDU25dkuDH+hd9IXeyYwDIz1pyh/KN68cDlhZ40FOTh1UO7uXH9fmTyc8x9Fhp1YlS
         f0ssD/Yil1N/4Fy/mbIh4639N/l6/W0a2IT/OrFpnZmmwfjn87y+EUDp5ktunZin+bb2
         HMQRc1dVbFqvmeVf0/2RH5uPCecyi9EdaKqiXf5eYPE19RRIweNun7z89OoXZBhCy3ZV
         JTHg==
X-Gm-Message-State: ACrzQf0vB/Mys+di5vLdDnnydyRUpS9rOGmvonW70gAcbd9L/5wHBIqE
        8ePgqg/t8+hXYazTphn4Apg8Tw==
X-Google-Smtp-Source: AMsMyM4PSqJTDG/ErJjBhO/AmAS5cO82QRykgTTHga1nzb8GnNE2KHwmgXPc7rwm6thvlMQoPRjSCA==
X-Received: by 2002:a05:600c:1819:b0:3cf:63fe:944a with SMTP id n25-20020a05600c181900b003cf63fe944amr23041803wmp.17.1667566697875;
        Fri, 04 Nov 2022 05:58:17 -0700 (PDT)
Received: from [10.101.1.4] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c1d8a00b003c6bd91caa5sm2941833wms.17.2022.11.04.05.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 05:58:17 -0700 (PDT)
Message-ID: <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
Date:   Fri, 4 Nov 2022 13:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, tony@atomide.com, vigneshr@ti.com,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com,
        afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-5-jneanne@baylibre.com> <Y1+q2Usm9ecicXqp@google.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <Y1+q2Usm9ecicXqp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/2022 12:00, Lee Jones wrote:
>> diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
>> new file mode 100644
>> index 000000000000..2c1cf92e92ac
>> --- /dev/null
>> +++ b/include/linux/mfd/tps65219.h

>> +/**
>> + * struct tps65219 - tps65219 sub-driver chip access routines
>> + *
>> + * Device data may be used to access the TPS65219 chip
>> + *
>> + * @dev MFD device
>> + * @regmap Regmap for accessing the device registers
>> + * @irq_data Regmap irq data used for the irq chip
>> + * @nb notifier block for the restart handler
>> + */
> 
> This header needs work.
I'm not sure to get your point here. Just something like below to match 
format or do you expect more:

/**
  * struct tps65219 - tps65219 sub-driver chip access routines
  *
  * Device data may be used to access the TPS65219 chip
  *
  * @dev: MFD device
  * @regmap: Regmap for accessing the device registers
  * @irq_data: Regmap irq data used for the irq chip
  * @nb: notifier block for the restart handler
  */

> 
> Can you try an compile with W=1 please.
This raise one warning on mfd:
drivers/mfd/tps65219.c:28:12: warning: ‘tps65219_soft_shutdown’ defined 
but not used [-Wunused-function]
    28 | static int tps65219_soft_shutdown(struct tps65219 *tps)
       |            ^~~~~~~~~~~~~~~~~~~~~~
soft_shutdown has been validated and is used in TI baseline even if not 
hooked in upstream version further to this review:
https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/

It was a TI requirement to implement it...
Let me know if you want me to remove this function or if we can keep it 
like this.

