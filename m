Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171BA6CFDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC3IGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjC3IF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:05:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47031986
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:05:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q16so23432073lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680163556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiRopAYWrlOAC1Vw+B3xdKoDxUuDD/+lpWfHOMaxovk=;
        b=IHGd1OQ/isgJp0gMoS4OP3W3ehG1gUai099okoPJL3aG8Apa/RcutH6oMEguYBjKxT
         yRk/9ce5tuUxyLo0RWtqZ5rf0wdBXL3IwlZbZI3JvmdF515gWCAXwoFePp/T+vHwlcuz
         MnrlUyHnKT/98f9QASxS+UJYvqjtxs/2Xir/zvzBncLm18ZFuuFQV9P0VvGxY3ZENQlt
         ZkVHoAPRsECsqI6Djfpi4tkuG30/utQuYRx/g/wufi6Tb+z2SxFiRlBc13dFrK1/jlEc
         gfpI5aS6UWz6+33AxltnL7IAxamnCMzi+smVQ7R1tHqpMczfYXY1ED7yMdKTpQWSVhi4
         eHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiRopAYWrlOAC1Vw+B3xdKoDxUuDD/+lpWfHOMaxovk=;
        b=oBuL7xB5hzqsSrG5ywyerk24/lAo+dNfo9TAHe36a7qoblDebJmCXR/owiLP3Re3D/
         Vy5P7TiAJQ+gRUOsV50L79Oi8EldDuG1SlhUszDjY4Id4H64PjxNUFQBr/SOUKIarZxp
         QYYh5yBuxgormdiga9W9qaWFLUOriccDh5vc71zmtdwHCnzWaeDNGJVB1YAvnzBK0Jgm
         tQDbWFqCU02K6ekL8UX+AZfICN+qw+ObvIGAPk6R5q0MAbLOVCDcC1Soy5vHi0hxbJOU
         o+DWhqj/pnMQN18h21YWiE1H3X1m0RNMDGHO39nDObiCXKc3M67ldY7phAY1d7myYdZc
         TEOw==
X-Gm-Message-State: AAQBX9enDYWJRpmYG4Pb9vYdLo5ypJoVY0hh+dCNaidJH+/i4bYILfWf
        /8M5if8ZvgKafa52j5jxMWlnSA==
X-Google-Smtp-Source: AKy350axLrl0hGO1L+AxecGYvf8f5noF8YPxt8umUlmjOpIagxRyfwQwgr/xfamvUSLkswyD1J7owA==
X-Received: by 2002:a05:6512:910:b0:4e8:5df6:8ff9 with SMTP id e16-20020a056512091000b004e85df68ff9mr6879378lft.18.1680163556101;
        Thu, 30 Mar 2023 01:05:56 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25590000000b004eb0c12df21sm2095078lfg.128.2023.03.30.01.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:05:55 -0700 (PDT)
Message-ID: <9a300a4d-484c-45e9-dd97-bee6c4b2e285@linaro.org>
Date:   Thu, 30 Mar 2023 10:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307112835.81886-6-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 12:28, Okan Sahin wrote:
> MFD driver for MAX77541/MAX77540 to enable its sub
> devices.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> The MAX77541 is a multi-function devices. It includes
> buck converter and ADC.
> 
> The MAX77540 is a high-efficiency buck converter
> with two 3A switching phases.
> 
> They have same regmap except for ADC part of MAX77541.
> 


> +static int max77541_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	struct device *dev = &client->dev;
> +	struct max77541 *max77541;
> +
> +	max77541 = devm_kzalloc(dev, sizeof(*max77541), GFP_KERNEL);
> +	if (!max77541)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, max77541);
> +	max77541->i2c = client;
> +
> +	max77541->chip  = device_get_match_data(dev);
> +	if (!max77541->chip)
> +		max77541->chip  = (struct chip_info *)id->driver_data;

You have odd indentation/coding style before '='. Use Linux coding style.

Best regards,
Krzysztof

