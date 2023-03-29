Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608646CD2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjC2HZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjC2HYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:24:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082833C0F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:24:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bi9so18911130lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680074680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGS6b5YXn10NcJ5QUB50Aod9B0bqHGHbyiKTOZ3Udps=;
        b=X3DWfUaGLZ+qgDV7Ty2iJJ2VSoKD4XrKrqluyWJzr4xuawtqqDJMFcoCuyTx9Q19YY
         n2FkaaO4kjFdjdZCGDhZbE2kueqbR4c7UQnQsyZYajhIfwPTCIhyBTxv5vcPMPqxydU0
         rcVTlDKqFK2YR4OOQf4f1zft7AtS625bU0l8NCogV5GHeHH9VZ5ju31ttXnSyEMs5fcl
         Tm2q92dnKc9ZdF95KALp7db/8SYHbPAP9/tp67bCzmMZHj5HN4B1Mvr+BpeqZ8nMGJ3S
         y3ThvnD+STqrtDhlsybPmMkmXqmK5qkeYCGZRMu4Y+/ku6nRRWsa+vqmM4pkIyKLU8FV
         Gv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGS6b5YXn10NcJ5QUB50Aod9B0bqHGHbyiKTOZ3Udps=;
        b=f0xtck3LoxLDfXncgqkPyEXhC7SjVMAT2vp3yEjZKPSF1JETbUm55yvAenLvXTPZn4
         rH4BQQIbZ73HKiDiTDT5tbaCWIR73o3xGPX+jwR/M/Orm0wkZ43WYO3NjvGiLmaGZFDf
         ab3iLjb5eP/DkuN7CoFAqLirazNpMJljHFtpWuQdekY7FVmtKzOVVu5pWYjA4mcKsCFF
         y5VtuKkDubpg8efxbWWvWD7fG2zP1g5GY+BOgu/lGp2ObSz/wneYe1cXKed98tSXeY6/
         thTRj7NYxnc1dL6NwcGTjVNmXhbSO59ek+VpVe/9LohwlhC3jy0LSIXKIu7XFOeQkuPS
         Il3Q==
X-Gm-Message-State: AAQBX9d5e/SYumMLQmtz7ZX3u646QnexKeNOESCvUueO5jJhiBLcjvZI
        m8/lcVOCS2FKKu+k+RKyk0Ss+g==
X-Google-Smtp-Source: AKy350aF6HDKGWSyijeHG5aujpZZx7FNjGf8c7Gy0NPPvWJoyS5Xi1axkQ9kLVhlUUNEBU4qvhm6nA==
X-Received: by 2002:ac2:5591:0:b0:4ea:e2f8:5edf with SMTP id v17-20020ac25591000000b004eae2f85edfmr5222614lfg.33.1680074679959;
        Wed, 29 Mar 2023 00:24:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s12-20020ac25fec000000b004dda80cabf0sm5371135lfg.172.2023.03.29.00.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:24:39 -0700 (PDT)
Message-ID: <7eebc72a-a657-ca67-2c59-60f8e633b878@linaro.org>
Date:   Wed, 29 Mar 2023 09:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Content-Language: en-US
To:     Jun Li <jun.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
References: <20230323065824.3857573-1-peng.fan@oss.nxp.com>
 <5675373c-af4f-906f-9906-7853a85f8ed6@linaro.org>
 <PA4PR04MB96405A3B0B5158561D9E068F89889@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <aec9e01b-c358-0982-3090-ef980d4a5623@linaro.org>
 <PA4PR04MB9640866667BFFF292F06388589899@PA4PR04MB9640.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PA4PR04MB9640866667BFFF292F06388589899@PA4PR04MB9640.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 09:16, Jun Li wrote:
> 
> Per spec below, TCPCI does need interrupt for alert, but no limit on the number.
> 
> "The TCPC uses I2C to communicate with the TCPM. The TCPC is an I2C slave
> with Alert# signal for requesting attention."
> 
>> no supplies and no additional GPIOs (like reset
>> GPIO)?
> 
> Those are out of scope of spec, I think it can be added as optional.
> 
>>
>> Because this is what this binding is saying.
>>
>>> fully compliance with tcpci spec, if change it to be only specific to
>>> nxp,ptn5110, my understanding is then other chips need duplicate a
>>> binding doc even common tcpci binding and driver is enough for them.
>>
>> Depends. Usually we have common schema used by actual device schemas. If
>> TCPCI-compliant device cannot have additional properties,
> 
> My understanding was TCPCI-compliant device can have additional optional
> properties.

Then I propose to rename it to device-matching name (nxp,ptn5110.yaml).
Except interrupt and connector, there is nothing here which describes
actual standard or common class. These can easily be moved to shared
binding later. I can easily imagine TCPCI devices with a bit different
interface and different properties.

Best regards,
Krzysztof

