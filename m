Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9769F028
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBVI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjBVI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:28:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DF4265A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:28:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o4so6883141wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLFMV5iAE6vR4P2SIlhoSPSGtCrLcwNMxI3aYuG3Z2Y=;
        b=jHB+t+H4R7ui2sqZfxcO/KdAQ7pJ82WQR8pB9ODA4zULtHVq0+ITHtkxoS7GU+f1km
         jFe3neGlT1ObrD+Jrffq1iW4olA3ag0Vda03HemP0F2VZe2rvLtW7hlnFE11iOghrvLU
         73cH1v5Tio1/FY5T81MOHsLwhZ75Aaqzzn3aAn8m05P4tIxKsRGUsr+MEnfTo+O20O3S
         nKpNL6JuFaGdVIGJNcF+8ncfqeLKV+Frtle+g4tjgpMKcdW/T9Nqm2BbQSj+P3HVDC8n
         mjkkLdvgagZft7fWxpVWQoczB6yUsuEzYGydL7aAXn9Gava76R8Sa1ySoFLjmwC9ihJy
         /DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLFMV5iAE6vR4P2SIlhoSPSGtCrLcwNMxI3aYuG3Z2Y=;
        b=A34KI9me/ud89SZukPu0auqbXWMkqQZZKrqbLYbwpePjc2hZ7Hx8R+KFRlEUcm3Ejs
         xTRrpvGFbG0B4+stgmb8BL6QLUuXeyc1j5VP8dOYJBlbX0yuc8Gleru2j+ZBL+nGhXhM
         wdtfKHwJO2TyL37sPAqo/ZsvD3PJgLrwzxzAD+IxI4gpiByIBIVtwuQtT2sz4xPXY44Q
         KQx316+sjy3WQ0PLXQBZ8/l0A1pgaCqFUSp98P3tgZQ4GphgsUJ9MyyorlZISoJfKzOX
         H4XmRa0v9DAUC8W2+28Iyz2RLrQb6Y7OkhTm92blQXEu08tdDeLT+dStchKF2NpsvFUI
         jRRg==
X-Gm-Message-State: AO0yUKVTGlWvIZ3BBtViJBmVcus63QrmOYoIvDFox3ufGiAS0WPSATTy
        V7qQHwTjAe4/iS1ae1pbUpV5aA==
X-Google-Smtp-Source: AK7set+jDApicTjSI5qypPYbTiOAoFcQmVCJyWdI/f/zCeNCFE0XoE6sPmq0GGUIRSinRQMbWsxscQ==
X-Received: by 2002:a5d:45cb:0:b0:2c5:4f04:c50d with SMTP id b11-20020a5d45cb000000b002c54f04c50dmr6530784wrs.48.1677054509270;
        Wed, 22 Feb 2023 00:28:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a8-20020adfed08000000b002c55cdb1de5sm6382130wro.116.2023.02.22.00.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:28:28 -0800 (PST)
Message-ID: <77480142-a2c0-f6da-af0e-d3f01f72ac53@linaro.org>
Date:   Wed, 22 Feb 2023 09:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/2] i2c: aspeed: support ast2600 i2cv2 new register
 mode driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-3-ryan_chen@aspeedtech.com>
 <63986fb1-f8d4-f348-bae9-72e08369213b@linaro.org>
 <SEZPR06MB5269B032022D3D7286E59D36F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEZPR06MB5269B032022D3D7286E59D36F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 04:36, Ryan Chen wrote:

>>> +
>>> +	return 0;
>>> +
>>> +free_irq:
>>> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
>>
>> Why?
>>
>>> +unmap:
>>> +	devm_iounmap(&pdev->dev, i2c_bus->reg_base);
>>
>> Why?
>>
>>> +free_mem:
>>> +	devm_kfree(&pdev->dev, i2c_bus);
>>
>> Why?
>>
> 
> Sorry, those are probe following, if any error, will goto this label.
> To release mem/unmap/free_irq. Is this unnecessary? 

Releasing managed resources is usualyl unnecessary. Therefore I am
asking why do you think it is necessary here?

> I saw many driver submit is remove all probe fail goto label, is just return ERR.
> Do you mean I direct go for this way?

Why would you do it differently?

> 
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int ast2600_i2c_remove(struct platform_device *pdev) {
>>> +	struct ast2600_i2c_bus *i2c_bus = platform_get_drvdata(pdev);
>>> +
>>> +	/* Disable everything. */
>>> +	writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
>>> +	writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
>>> +
>>> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
>>> +
>>> +	i2c_del_adapter(&i2c_bus->adap);
>>
>> Wrong order of cleanup. It should be reversed to the probe, unless you have
>> some reason, but then please explain.
> 
> Sorry, this in remove function, it should do i2c_del_adapter(&i2c_bus->adap) in the end.
> Why this should revered to probe?

Because it's logical, you do the same with error paths of probe, it it
usually the only way to make sure some of the resources are not used by
some other piece (e.g. interrupt handler is called while i2c adapter is
unregistered).


Best regards,
Krzysztof

