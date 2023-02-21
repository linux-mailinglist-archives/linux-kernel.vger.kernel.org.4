Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3974269DD04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjBUJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjBUJix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:38:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E83C2310D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:38:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ck15so15781451edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg66CfuIDc2OuZeNGh2hxzTF5J8r4gXE6jaKHzpsbgg=;
        b=gVx+ZHoIXuiJ/yI2bXys1rL+uYqIOaaIUHYeTCTu7m71j44xfaTvLCpq1fyezMcpS1
         lgHwx8NT+9indbUT49McRzIfAihmwCAs+BlooJpTZVgQcdtMbY9KspGejM7H1hp5clmq
         J5urJVP2Mq7gYvTrjcHEXVkpobU5VnrObyPobeUADBLtILpXXDHar5MPQJ5suleG2/i5
         It+dKDy8wa+y+WdTLoqvh18pp1nwrWePnXJ1HVL9m7qKeI/AuyZwU1MHkPCbr9jUq8pq
         BUEvvah+s6Ta+cRLWU6hxjw7BcfQpewQlldzgPnVj/2T6h/fSvNC5NXfVj4SAXS/EwZY
         6OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg66CfuIDc2OuZeNGh2hxzTF5J8r4gXE6jaKHzpsbgg=;
        b=UAV63W/dfDQNXgh7Jg92EYFDQ9H9PG5PLoVjcWXtCSv7srjWDBfqIiftvk7b1pMspR
         FD4iVy1upSIhsoy5Yl8VrfUjPomXbDYfi2vUWd2DpB1KTtJqOkdhRK+wZTYtrxJXi6Tc
         kxkr3i8QuhnvDCGZ3F7jNTfBSItljWh7TxyeEPHjXzb+ERav5Rlg9/owPtaY3AMhGmjK
         o6njy6cIj/19nxwXa9skJ0FAbFy5X8gZxEC08YRtjPzsRWQpSndHRQz7Y6aZJwv113yN
         VbQR2uema2oH+U/A0uf1XHAlsptZMZfxFLgEj1mQPKz+6B6AYUk8D+H+48IXLdz4eevd
         xKDg==
X-Gm-Message-State: AO0yUKVdVJqLXh9+V65lPJSKvUvq2OHyACbSAsQ/jX+9a4Ui5gHQLQ3L
        2VdrR5FCLrP+wyDnGrhJvjHmBQ==
X-Google-Smtp-Source: AK7set+x/ydQXHH54gXhy2ZLyR0nq67hV8gpFBFqoGpKV2tPN4Rzk9wZ1WZxtVH6w044XbkXuXEMnw==
X-Received: by 2002:a05:6402:1108:b0:4ab:d0e0:a64 with SMTP id u8-20020a056402110800b004abd0e00a64mr3155003edv.19.1676972330839;
        Tue, 21 Feb 2023 01:38:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y6-20020a50ce06000000b004acc6c67089sm2485412edi.75.2023.02.21.01.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 01:38:50 -0800 (PST)
Message-ID: <1f0b18b1-0fe4-a7e9-4d72-3938471ead42@linaro.org>
Date:   Tue, 21 Feb 2023 10:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
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
 <54ef0dee-30dc-3ba9-d2f7-8270204b5505@linaro.org>
 <TYZPR06MB5274195CB92C4604280A776EF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <abec828b-9b34-fc5a-cd36-8be6f20dfd25@linaro.org>
 <TYZPR06MB52743FC4ED5ED152446106ABF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYZPR06MB52743FC4ED5ED152446106ABF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
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

On 21/02/2023 02:12, Ryan Chen wrote:
>> Yes. New compatible and new syscon phandle (constrained to specific
>> compatibles in allOf:if:then:) to the old binding.
> Thank your guidance.
> The following is my sample modify, if my understand is correct, I will update in patch1 thread discussion.
> I need add in original aspeed,i2c.yaml not aspeed,i2cv2.yaml
> allOf:
>   - $ref: /schemas/i2c/i2c-controller.yaml#
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: aspeed,ast2600-i2cv2
> 
>     then:
>       required:
>         - aspeed,gr

else:
  properties:
    aspeed,gr: false

Best regards,
Krzysztof

