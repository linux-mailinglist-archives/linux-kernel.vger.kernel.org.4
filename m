Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B077329A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbjFPIQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjFPIPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:15:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F030EA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:15:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9864d03e838so46722066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686903334; x=1689495334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MReGSBx2uByIi2fo/tJwMA37xAAYbHkch5+QA0BSAc=;
        b=w1+P6WxDkkOtvrHR+bpoYcNqd69PX0LLN5AS/xARvhLia9RhcR+sNpsl8jkJBNCzJ8
         n8CdR55HJ5B/bv/43K1+gpAoSxG+4C+pNQLAxRmkikQvsinyqD2Y5LggdTiSgyhvuUKc
         umWhq3YKvgzMfRG8ptLvPOn2AnRqx84s+6L3HOW2GXZDWhPjIQlUTvbizrXXgC6NYNAS
         q5FGE5AqJQzMsOfnDu8N7nFdiXSbZg1/oR6bza1jW7I2W+Zji5LCGFYqlD3vxnRW8kEh
         igB/6Xctzszxt675mjtm62JPafLCE/qtI9D3B32bR5BCDhhAVynMzE5snZh0RUDlsQpo
         ACww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686903334; x=1689495334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MReGSBx2uByIi2fo/tJwMA37xAAYbHkch5+QA0BSAc=;
        b=Rv+RQXbXgR+s1QP9F3iIuYdayRKYsi+dvbnK4Fxxa0NyIazcFbc9LJw0bZNHXnJBQK
         TbOVYcdzG+Q1nw3VcKzsCaOVs0DK+AwFwb2M2CwXrkMRqBFP49Pq5LlJS2A7HYpahYK1
         jjxoUF/Pljg5UkIF681qDUWwcSxw3+sCAQ8T7GC067cSDtWbyJ7YgWSAwjfjvKg2By7H
         4MmV3p0HS/4weNEzSVao1re1avQ3BLvTQTtPJEWD32DI7yLfeHdj31OOUAbSUYvbuPj1
         QqkblcFfPBzibZT/VJ/LXYc15peLrExt38aIMPQhox+dM1Yuz4mwkHd/d+EjVBhaVqx5
         Goew==
X-Gm-Message-State: AC+VfDxR7dlf1b+53y4AulLav5s05+cxPzzhOY9u5K2sDnKGqJjFpQRa
        dY0nEx4HPj16olIFyAeYN2vGTQ==
X-Google-Smtp-Source: ACHHUZ7K3IUgFGVoNdenbD2CwL3R5l4B/kpNp36xbvmraCQBKM4RYo6seANHgU1Ju9wQH1QYDQbeTw==
X-Received: by 2002:a17:907:7245:b0:982:a454:6d24 with SMTP id ds5-20020a170907724500b00982a4546d24mr1224781ejc.74.1686903333855;
        Fri, 16 Jun 2023 01:15:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r4-20020a170906a20400b00982c0ac984asm1418708ejy.176.2023.06.16.01.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:15:33 -0700 (PDT)
Message-ID: <781c1db2-ecca-901a-4e11-7f7c68cf744d@linaro.org>
Date:   Fri, 16 Jun 2023 10:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
 <20230615040447.3484564-4-chris.packham@alliedtelesis.co.nz>
 <f16e742f-e6f2-9761-e70d-e0e7cadcba4a@linaro.org>
 <1863cd53-9846-def2-ee5f-f4a51160ed8d@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1863cd53-9846-def2-ee5f-f4a51160ed8d@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 23:06, Chris Packham wrote:
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: marvell,armada-8k-nand-controller
>>> +          - const: marvell,armada370-nand-controller
>>> +      - enum:
>>> +          - marvell,armada-8k-nand-controller
>> This is wrong. 8k cannot be both: compatible and not compatible with
>> 370. It's not someone's cat to be in both states at the same time...
> 
> The correct state (IMHO, Miquel correct me if I'm wrong) is `compatible 
> = "marvell,armada-8k-nand-controller";`  as there are some 8K specific 
> requirements that aren't present on the 370 (specifically the 
> system-controller and the 2nd clock). 

Presence of specific requirements does not invalidate compatibility. Two
devices are compatible if the 8k can bind and work with 370 compatible
string, even if this means some lower performance or less features (e.g.
subset of features).

Now whether they are really compatible or not - I don't know. I expect
the answer from you (as plural you).

> The only reason `compatible = 
> "marvell,armada-8k-nand-controller", 
> "marvell,armada370-nand-controller";` is supported is because that is 
> what is in use in the existing dtses.

Fix the DTS, use here the correct combination and, if it is a deviation
from old binding, mention this in commit msg.

Best regards,
Krzysztof

