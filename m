Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7038269C8D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBTKog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBTKof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:44:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794828689
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:44:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b12so2835972edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAr9XKr2ows0ZL4lWEGiuUXi4Y81IFXVXwxMIX5eq8A=;
        b=fnNTy2X7U8y7zMHj3DYo1PryRXOURd89hFD5uJ/Ggth6z/KwfDvYFiLZYsMlm3DN6i
         H2XPOhHfMFMIbDTvPRiclRvEAagO8eQP/zKSz4n8W+v622f67KQgiG0VuDabQnPR8XE1
         DlWni/m4VJw33Ph4yaupo9+wY/RCdJyQFxg95z2Wza5X0AfPJB4nhxl5+U5MOAECJtqP
         9jHEQQ4WVeaTEdcobqWQ3eqkiOD5/ftfv9IYNwXCJv0jDWDVcqLToVV6By7mpv2KYxu8
         CMS20gUqO1iC/53OXx2Y2qJ5X+JKs4UtdNtWXugUfqbVXo5DTGjBZC+DFZlxODup9e+X
         +4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAr9XKr2ows0ZL4lWEGiuUXi4Y81IFXVXwxMIX5eq8A=;
        b=wxWikEOXFZsRe/IvFk2WAfv3oyL71TfWdRre98yxufBAgmZj8Y2aH+JZLmFDgPGP/8
         7YTUi/PUstEhEPX81igPlqVKmoLGIK7BSBCRiGSPmV9wANEXG+BsArric54m4xaqdlZq
         AlFAJ7Sv4IAMELtsCqCMybF9j6MMUcurxl+27hHPPJrLmPzFvkNKTatpeu4gNFgxbFZi
         W4S6aR5f3NWDTLmzrQ+BeikwzlEAxb2RWpgddsY0yRInlE3p7Ox4eJFjzSNIaC1MC0CC
         n1XCCvqJJC1JyQCAiWlDtnhCow02isBPEQrBBzJ2embYPhcnf94p/57A+1rFPgyWZjaV
         HwfA==
X-Gm-Message-State: AO0yUKWXT1y9tGsPt5QOFE8xR96J/2OB6hkKSjJgp2bv0tINiqI6Hw85
        BFdNcD4bdVeVge7t289fbUezCA==
X-Google-Smtp-Source: AK7set8TR+cAzF/JDkXW72w5dUn26frqdxo8bQYFTgM6H9WQ5kSiovRMhPpgNXwj63DdPlZX5wdONw==
X-Received: by 2002:a05:6402:10d9:b0:4ac:bd35:d05b with SMTP id p25-20020a05640210d900b004acbd35d05bmr180522edu.27.1676889872004;
        Mon, 20 Feb 2023 02:44:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u15-20020a50950f000000b004ad61135698sm1911398eda.13.2023.02.20.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:44:31 -0800 (PST)
Message-ID: <7dfdb0fb-3a8b-0584-e8b1-6d2200f18097@linaro.org>
Date:   Mon, 20 Feb 2023 11:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/2] i2c: aspeed: support ast2600 i2cv2 new register
 mode driver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-3-ryan_chen@aspeedtech.com>
 <63986fb1-f8d4-f348-bae9-72e08369213b@linaro.org>
In-Reply-To: <63986fb1-f8d4-f348-bae9-72e08369213b@linaro.org>
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

On 20/02/2023 09:43, Krzysztof Kozlowski wrote:
> On 20/02/2023 07:17, Ryan Chen wrote:

(...)

>> +	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &i2c_bus->bus_frequency);
>> +	if (ret < 0) {
>> +		dev_warn(&pdev->dev, "Could not read bus-frequency property\n");
>> +		i2c_bus->bus_frequency = 100000;
>> +	}
>> +
>> +	/* Initialize the I2C adapter */
>> +	i2c_bus->adap.owner = THIS_MODULE;
>> +	i2c_bus->adap.algo = &i2c_ast2600_algorithm;
>> +	i2c_bus->adap.retries = 0;
>> +	i2c_bus->adap.dev.parent = i2c_bus->dev;
>> +	i2c_bus->adap.dev.of_node = pdev->dev.of_node;
>> +	i2c_bus->adap.algo_data = i2c_bus;
>> +	strscpy(i2c_bus->adap.name, pdev->name, sizeof(i2c_bus->adap.name));
>> +	i2c_set_adapdata(&i2c_bus->adap, i2c_bus);
>> +
>> +	ast2600_i2c_init(i2c_bus);
>> +
>> +	ret = devm_request_irq(&pdev->dev, i2c_bus->irq, ast2600_i2c_bus_irq, 0,
>> +			       dev_name(&pdev->dev), i2c_bus);
>> +	if (ret < 0)
>> +		goto unmap;
>> +
>> +	if (of_property_read_bool(pdev->dev.of_node, "smbus-alert")) {
> 
> There is no such property. Don't add undocumented properties to your code.

Actually such property exists, so this one is fine.

Best regards,
Krzysztof

