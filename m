Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B89646BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiLHJ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiLHJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:28:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A51DA63
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:28:10 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so1112856lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvonNZ8hzOsUtXfMS5jsK8oAXaTdy0VRFUTiOadKcQc=;
        b=h0SV4jEnf3LUyPMrtB7fSs0oyXBjNYnC+wPkJTrEpAUXeX5sXQrly2h9pmV/BaIy6R
         wtqelKyna1vNSa6KpgOzVcTBveTYzc2S67lbmsqmihry8Rub1uAALhMl94mCc+8wYSRJ
         TGMPDgtWtHtj+W7XZmvrbtxNjfh3A6iZ3Js7OJm47H9nJGn70bbwRnzdForlH+YFf6vZ
         uMGjvfiNmEKFuHLplsEo4aYd310onrCycBoGJB2C0dzRwqMPSWFQOLNyKPxj3A/tnnJa
         bwBNmh/BRjTXp6nA+hctAfSA6i37FFHqmeT1ZdXh+9ukwlTZwr1T+PdKCqQfXNMV9fF1
         uCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvonNZ8hzOsUtXfMS5jsK8oAXaTdy0VRFUTiOadKcQc=;
        b=7w4ER5uRloQE6cNPCmoQpCuX90X9mf0wL/40WI9l0m/cZGULMOqgbmHm1U1BWh7bzX
         fRkuf7V46D3km9Hui7gzfVzqMUkVWpXijmXKMOZouESfbhKIEvyg5MPrbQ122tJLKOzi
         PYvUnwovTj9FEH0LOhupCPP/TfAv/zDLCrDTsSJk52CKH97YXSlzWa1P4zr9115VbewU
         W0hDMFnvRL6vEioBgynlfWaS+SSuyhGi9EC7peyhEpt6HqHNGFL8v8l14oyk8aXJVDGa
         6xml4rj9rASIcnnWHPQR8Dcc8xGd63OkscnUwvAUVbrwo4+3kdU1niJycGKARhxG1hrP
         iXMA==
X-Gm-Message-State: ANoB5pk+BgBQYNtmlI/reWOWTz/nMSPc/dGR6n5Wful+Tp/slZ401SQa
        xcZl2oJ00qk47qw6Rn82uJMtow==
X-Google-Smtp-Source: AA0mqf7TNvjfjrF7HrYj9ZQKhyCHR8PdEUqzTgbholw8jlR+OE7FkmeYXQJ4FF00PhAzDPAROjzt2Q==
X-Received: by 2002:a19:760b:0:b0:4b5:67d8:e3c2 with SMTP id c11-20020a19760b000000b004b567d8e3c2mr6935849lff.166.1670491688911;
        Thu, 08 Dec 2022 01:28:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b24-20020ac25638000000b004b57bbaef87sm532100lff.224.2022.12.08.01.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:28:08 -0800 (PST)
Message-ID: <9c7066e4-fa3f-3dda-b939-04dfdaf73242@linaro.org>
Date:   Thu, 8 Dec 2022 10:28:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/6] crypto: starfive: Add driver for cryptographic engine
Content-Language: en-US
To:     JiaJie Ho <jiajie.ho@starfivetech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <e1e9f1d19982493b89ae63f51e00a3bb@EXMBX068.cuchost.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e1e9f1d19982493b89ae63f51e00a3bb@EXMBX068.cuchost.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 10:09, JiaJie Ho wrote:
>>
>> The driver has been tested with crypto selftest and additional test.
>>
>> This patch series depends on the following patches:
>> https://patchwork.kernel.org/project/linux-
>> riscv/cover/20221118010627.70576-1-hal.feng@starfivetech.com/
>> https://patchwork.kernel.org/project/linux-
>> riscv/cover/20221118011714.70877-1-hal.feng@starfivetech.com/
>>
>> Jia Jie Ho (6):
>>   crypto: starfive - Add StarFive crypto engine support
>>   crypto: starfive - Add hash and HMAC support
>>   crypto: starfive - Add AES skcipher and aead support
>>   crypto: starfive - Add Public Key algo support
>>   dt-bindings: crypto: Add bindings for Starfive crypto driver
>>   riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
>>
> 
> Hi Herbert/David,
> 
> Could you please help to review and provide comments on this patch series?
> Thank you in advance.

You received some comments so the expectation is to send a v2.

Best regards,
Krzysztof

