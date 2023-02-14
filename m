Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D49695AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBNHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNHt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:49:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE61BAFE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:49:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o15so11365320wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BZXiTCaWioPvbzbBAn0oxPR1rxdWEb2vlLnjqL27XI=;
        b=z7VCsH7jRGtqAalXsHjnqDbnJOwUgIqohKEWtJYdaBpvEM8ZcOz18wY4L9+9f0BJ2c
         5W8msteK1ebdaW3JZF9n4zQS2XEAZI6/oaEfzgkTNjgp7q/cbQFU4xcEL1UkCFxNW/mJ
         08beHsOZ+M2W+4l5WgvjEhtFgc+tpy3keeQCRDZd0BKtAv1tb8WWUIajjjzblZD5W0g1
         DFcLfVhdhcILkd191aO8VMnkTK1WG+qromM1jOYmCp2ZypIBWdVxkoJYsCuAeNwoSHCW
         oFR3gEXws74PSwnlakA/rnYrzB+xrVkyRXlv1zjEhSn2NjnA6HrQmvmJy8gOMYtTFBUT
         gcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BZXiTCaWioPvbzbBAn0oxPR1rxdWEb2vlLnjqL27XI=;
        b=itJ+JcNkbSa1G/1rIBFti4PEZEiPMRg1aa5MZUsB4HLBJ9rzklUGjzXVAbl3uNoJwM
         xZfu79kDuXc7L4uj0x3XR2Ps2Bip8ETXkLPM2WyCbbeuia7danvqktfry3079tfgBG3b
         sxiiUkcd2jEPu6vfRO1SiZ8MS4/wkklKxsX8nq8/JbQEn4aAocXd+DXOoGpVjuRkQZyL
         ED3HtE+tXmtPEbMDWKjDnszEh11GlUF03qi2CIyon2J7AUzLQwBwkhjDzXRfet7nTLOf
         RoxAtpzBasag2xTjcjBZNwLbeCnmRCBSL7Eo8sMlvULnD5IuEvmraTANcxLt7IXGR7+k
         q3QQ==
X-Gm-Message-State: AO0yUKUIpIaNrebvY9GffNiJt753CuYJmPnc3a8KJZctN1UUcQwa2SfJ
        4SWD3QaSKIPPG80NxOe5JJMk+A==
X-Google-Smtp-Source: AK7set+/dHZHc/900rumb6+GH5YIHrWHNb+LKx6xsaclyywsxaqdMh//Qe83ReJXXScxKeONvq95dA==
X-Received: by 2002:adf:e40f:0:b0:2c5:4c1f:3c9 with SMTP id g15-20020adfe40f000000b002c54c1f03c9mr1102927wrm.49.1676360965977;
        Mon, 13 Feb 2023 23:49:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b002be5bdbe40csm12330171wrt.27.2023.02.13.23.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:49:25 -0800 (PST)
Message-ID: <80d16935-dad6-8087-c1b2-1d5b1c3f738e@linaro.org>
Date:   Tue, 14 Feb 2023 08:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 2/4] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-3-changhuang.liang@starfivetech.com>
 <3fc07187-f5a0-86d1-a0fd-ba18a2baf555@linaro.org>
 <f33f3ce0-ca0f-b24e-eab6-4fb9a6ae6d4a@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f33f3ce0-ca0f-b24e-eab6-4fb9a6ae6d4a@starfivetech.com>
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

On 14/02/2023 04:07, Changhuang Liang wrote:
> 
> OK, will drop quotes
> 
>>> +    items:
>>> +      items:
>>> +        - description: phandle of AON SYSCON
>>> +        - description: register offset
>>> +    description: The register of dphy rx driver can be configured
>>> +      by AON SYSCON in this property.
>>
>> Can be? So does not have to? But you made it a required property....
>>
> 
> Maybe I described it wrong.
> I will change to:
> 	description: The power of dphy rx can be configured by AON SYSCON
> 	  in this property.
> It is like AON SYSCON is the power switch of the dphy rx, it is necessary to
> configure the AON SYSCON register, so I made it a required property.

Then do not use "can be". Can is optional: I can jump but I don't have
to. :)

Best regards,
Krzysztof

