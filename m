Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC46A04CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjBWJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjBWJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:30:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA99497F3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:30:20 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l1so9831617wry.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0kLlLse1yCPirtczOxDDSZCB4FvjR8XNywaHVA1Pwc=;
        b=lMHPibg4j6ViwZO7s1if82oMsBgiB7vqazlQIS1tfdR9RQrBT1m0seEs/RCbIyfZZZ
         PWYtlrYfMA6KchT3hWoJ6cmquNh5+QhbMJsceooqMtNg5jlUpJ/luHMMuaaVNLgh39IH
         GQkS1/0TKzwqSRiIhhOxjaJ4XzzAtyw8aphaf9deuRneTXx8CltoXykkv3GWzLkBm6yC
         LD7C26+jLXut1NYs/dsLkPEXduSYBcaa9GbuT++7gnsNg5v/d5JmKs+v0iRsNgBGIPqv
         +yzHgSW4ViARcueEfbdcHL+7PCR1/d24kSSaBt0PSKQoKpfDQefWavUeNcocAHwQfHWv
         eyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0kLlLse1yCPirtczOxDDSZCB4FvjR8XNywaHVA1Pwc=;
        b=P7fZhgtIk332u0aysm6MNjl6iNY0QKj/SZV7ssWsS50pHyMdTCKZ0tCCX39JesnOAu
         mMSv4P753OT1BxF7lMwfUxAnMu2bSAFkW9GJJxerNqlVCh08NqiYXi4QzkRIguZ8oZAW
         Jy064TWICAa8MS4kqW+8gZli/Cx6CMoGafGD1Fiudi+tKSCm3gHf7NkJCOYesMYUhSdq
         NDOuPei6xrs0lPjkdRxp48Avje7SXizyKQutoFbj0Gd1+XQr9XDAWcAqD2DG7Bjiml2L
         EgHvZjx0DTOEhqYiPeon12TgUdP8zo5IzV+frJEDMkF9X4s1QBtJ72M33DGzBwcGJyiY
         9DSw==
X-Gm-Message-State: AO0yUKU8CoMN3Q51SQ2RLf0oV07XYYM6mzdhGejkpUExlu2ySa/oeUXs
        vqF+n0NB3fLQvqSsBbO8R4o5jw==
X-Google-Smtp-Source: AK7set9B+Xcb2LYUhA48rJUnYS1VfW+x62mSdAdcBqpeb45rwwLhIrShsfPRFXkhx9V3FdnlgPQ8Fg==
X-Received: by 2002:a05:6000:1182:b0:2c5:52fe:4622 with SMTP id g2-20020a056000118200b002c552fe4622mr11053258wrx.55.1677144619357;
        Thu, 23 Feb 2023 01:30:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002c55efa9cbesm9749951wru.39.2023.02.23.01.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:30:16 -0800 (PST)
Message-ID: <b99ed483-ab56-f5a3-d2f2-c0451de271cc@linaro.org>
Date:   Thu, 23 Feb 2023 10:30:13 +0100
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
 <77480142-a2c0-f6da-af0e-d3f01f72ac53@linaro.org>
 <SEZPR06MB526909B8D4313CA5F33074C5F2AB9@SEZPR06MB5269.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEZPR06MB526909B8D4313CA5F33074C5F2AB9@SEZPR06MB5269.apcprd06.prod.outlook.com>
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

On 23/02/2023 01:58, Ryan Chen wrote:
> Hello Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, February 22, 2023 4:28 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> openbmc@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 2/2] i2c: aspeed: support ast2600 i2cv2 new register
>> mode driver
>>
>> On 22/02/2023 04:36, Ryan Chen wrote:
>>
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +free_irq:
>>>>> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
>>>>
>>>> Why?
>>>>
>>>>> +unmap:
>>>>> +	devm_iounmap(&pdev->dev, i2c_bus->reg_base);
>>>>
>>>> Why?
>>>>
>>>>> +free_mem:
>>>>> +	devm_kfree(&pdev->dev, i2c_bus);
>>>>
>>>> Why?
>>>>
>>>
>>> Sorry, those are probe following, if any error, will goto this label.
>>> To release mem/unmap/free_irq. Is this unnecessary?
>>
>> Releasing managed resources is usualyl unnecessary. Therefore I am asking
>> why do you think it is necessary here?
>>
>>> I saw many driver submit is remove all probe fail goto label, is just return
>> ERR.
>>> Do you mean I direct go for this way?
>>
>> Why would you do it differently?
> 
> Thanks, I will remove those labels, and modify to dev_err_probe in previous probe return.
> 
>>>
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int ast2600_i2c_remove(struct platform_device *pdev) {
>>>>> +	struct ast2600_i2c_bus *i2c_bus = platform_get_drvdata(pdev);
>>>>> +
>>>>> +	/* Disable everything. */
>>>>> +	writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
>>>>> +	writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
>>>>> +
>>>>> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
>>>>> +
>>>>> +	i2c_del_adapter(&i2c_bus->adap);
>>>>
>>>> Wrong order of cleanup. It should be reversed to the probe, unless
>>>> you have some reason, but then please explain.
>>>
>>> Sorry, this in remove function, it should do i2c_del_adapter(&i2c_bus->adap)
>> in the end.
>>> Why this should revered to probe?
>>
>> Because it's logical, you do the same with error paths of probe, it it usually the
>> only way to make sure some of the resources are not used by some other piece
>> (e.g. interrupt handler is called while i2c adapter is unregistered).
> 
> Sorry, I can't catch your point.
> Do you mean remove devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
> Keep i2c_del_adapter(&i2c_bus->adap) here, because interrupt is called while i2c adapter is unregistered ?

Again, maybe clearer, actions should be in reversed order comparing to
the probe actions. Why would you remove pieces of code from here if I
asked to do them in different order?

Best regards,
Krzysztof

