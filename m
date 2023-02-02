Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF206878E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjBBJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBBJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:33:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2AB2ED63
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:33:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a2so818320wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZRRcs/XgyQ/lB8jyBhr4ijAcGvBbqK6iTjBnN5tzBo=;
        b=zF6Hd/0MHCM72whVsxMy36TLfuHH+dVwl7tpMxD2GVkTWc4xEBJCQXu4MtcCN0BJf3
         EJlG9pZ44GuGIkUc300Q+XJ+SM5yATxGEI7RHNvg1NRDE+YvugfmRwihXqoPKglSQ8Nb
         Y5un0/KCPWlBRiV+elljuNWvXfeUAByQRwIil9EMHo5pCJ5DXqtz3ff+h6FeYEzYlERa
         SI/rqVA0+6X+4JO+kFNH6D1TKG0YSs8UH5Z0hjrKgqXcihwWIgcBcmXDoyTMS1MSAYsC
         QDQn0QOizZu80Dxaqz8SqSr0KJxlEpyql2M/NhLwthCwkOEU1DZBbU5IyrfRJXSSL8u3
         8jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZRRcs/XgyQ/lB8jyBhr4ijAcGvBbqK6iTjBnN5tzBo=;
        b=urX8sQWiXcAQLWvd4sECMJRZkJ5MZ9sqeNey48AooRK8Ir9XItdNEtXbaul5Eu/rlg
         YxdD4S0B3ngBM3sewy55HtHrYq9+PoJAMW2fb+A5tF2eAem4kr18/SWdvOOD2Te+iaWS
         SQR4d3lzaXgWmRjpA1sQrFgb/WbAyUH7uW+W+d9nJDof8r0fPzJT+eEwam9q7Fv9tkLY
         uFG+/d9PeLurUeABep2CrumgplLA/SEUomyN4mmvjLcKQIuuET2eymrtp6pC8omQvvk4
         zNqFmD8lqRzVQsznODKIAkY4il2xtMLZWNPRA6j+70I8FmQ7NLlSAc2NbAkQzm2Q4a9H
         UWeQ==
X-Gm-Message-State: AO0yUKXOYfxOS3kyVO6wdvjhXHPo7AZyTMJZ+hUSZtCUVZNun9PIgbSn
        o1YhzMuw790m7xJ92ycqZBfoGw==
X-Google-Smtp-Source: AK7set/ylZEizs/1BVpvDGKf9pWVDclDYopXyXn5t99Hsk5zRJfPo8VwT6sgNGECtHxqxfwZmWKDrA==
X-Received: by 2002:a5d:4810:0:b0:2bf:c09a:c60e with SMTP id l16-20020a5d4810000000b002bfc09ac60emr5449034wrq.2.1675330395635;
        Thu, 02 Feb 2023 01:33:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p8-20020adff208000000b002423edd7e50sm19592610wro.32.2023.02.02.01.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:33:15 -0800 (PST)
Message-ID: <5239ea2f-284a-dcf5-6dd4-be3b13b319e6@linaro.org>
Date:   Thu, 2 Feb 2023 10:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/3] i2c: aspeed: support ast2600 i2c new register mode
 driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>, Jeremy Kerr <jk@ozlabs.org>,
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
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-4-ryan_chen@aspeedtech.com>
 <30c7cbbf57abbdfb5f974d6ee17b2218d124c7e8.camel@ozlabs.org>
 <SEZPR06MB526941A3DDB25529F0671112F2D69@SEZPR06MB5269.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEZPR06MB526941A3DDB25529F0671112F2D69@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 10:16, Ryan Chen wrote:
>>>> +static struct platform_driver ast2600_i2c_global_driver = {
>>> +       .probe  = ast2600_i2c_global_probe,
>>> +       .driver = {
>>> +               .name = KBUILD_MODNAME,
>>> +               .of_match_table = ast2600_i2c_global_of_match,
>>> +       },
>>> +};
>>> +
>>> +static int __init ast2600_i2c_global_init(void) {
>>> +       return platform_driver_register(&ast2600_i2c_global_driver);
>>> +}
>>> +device_initcall(ast2600_i2c_global_init);
>>
>> Maybe module_platform_driver() instead?
> 
> Due to i2c global is top of all i2c bus like the scu, it make sure the driver is before the i2c bus driver probe.
> It is needed use device_initcal function.

No, we do not do such ordering. device links and proper resource sharing
handle the order. This must be module_platform_driver() (assuming we do
not drop entire submission).



Best regards,
Krzysztof

