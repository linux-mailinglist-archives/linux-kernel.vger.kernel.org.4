Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD863EC74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLAJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiLAJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:28:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427AB49B51
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:28:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p8so1546895lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jahb+tEShKBR+Ktu0BgJXy8O1SopxAlMcngu6tulhfo=;
        b=wzeuJx6xKm1tNX0R828wgisRm6UYpQssq1gEpjild2BMpZ3jiJEGbZBEyphN32yvVV
         TzR7uzCkl9HBZ5aazB219DCIvHAA3tDilXZHK5QSEnTM1J5GjbxWBHjsU7b8RG3qWgVh
         UuQuyHmJOfwhZTnSm4HJDKTS1uqYIB3z3xDZUcPR3qyTs3/oKBCapWI3kjvAlEpuM/Nb
         TsORs1tXAqJGAaAAuTnb7I8BESvchycQt+GQl8F+jRPvqdX+sBUfX1f/MHStul1Td2kB
         Ne8u+FRMrGYkvUZOMxYIIQ8hyn1GEyeRzpmRLIGs82XQAjSqkMXfrxd7nMtVBVDP0bps
         Uj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jahb+tEShKBR+Ktu0BgJXy8O1SopxAlMcngu6tulhfo=;
        b=Nu11R5kbawTqKIBl85I2NhS57TA5FD4f2O4SwR91H/cqHKltnbCYDFvxSbcxsvDvXV
         46bg7Jv/o3RXMFWDrg7gcGDCRTQWgCiZ15RDdheRK8zNGCdb+f/oGvk3Gb4I8RO+i1v/
         7N8/Xr784VmSpcOuutnpjYM6rFzlzTxGKo/pmWJQ5i6n+z3VnkmqWscH8E/zcDAvPnlk
         3UPp7XnrQRwAb3jOy78VaLPoGg+zf7bMUBjUjGln06hQOXN9IDDmGy5nECyQMQxLNsMC
         ZFtlMqgwa34nwKVnYiyoD+V9MrVakwpJIXG+0VwC2cqA5VtdQzZ5gRPtT5ZLzN589Z0d
         dbxA==
X-Gm-Message-State: ANoB5pn63nf5OlkBS5p9+cWuJ3QDsgVVeNIwoySJE5m6qT2QDZP5A1uj
        39t6FXkBKohv6Jp2DL+qdt+xgw==
X-Google-Smtp-Source: AA0mqf4GR2jAPIP63PrEu23oXP2Y1onMJ5uqoMQq16hLdEJ8d7BaYPyYOXgoM7GjnlGgp9qM6QC+XQ==
X-Received: by 2002:ac2:4e0e:0:b0:4b1:7c15:e920 with SMTP id e14-20020ac24e0e000000b004b17c15e920mr25286530lfr.453.1669886924183;
        Thu, 01 Dec 2022 01:28:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o6-20020ac25e26000000b00492e3a8366esm589861lfg.9.2022.12.01.01.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 01:28:41 -0800 (PST)
Message-ID: <6028b265-bc8a-3a06-b17c-56aa772a4782@linaro.org>
Date:   Thu, 1 Dec 2022 10:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/6] crypto: starfive - Add StarFive crypto engine support
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
 <20221130055214.2416888-2-jiajie.ho@starfivetech.com>
 <aafb1c32-bc00-2db2-edbd-aa4771f33ac7@linaro.org>
 <60ad0da0116044d3a1fe575e9904e22c@EXMBX068.cuchost.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <60ad0da0116044d3a1fe575e9904e22c@EXMBX068.cuchost.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 07:52, JiaJie Ho wrote:

>>> +
>>> +static inline u32 starfive_sec_read(struct starfive_sec_dev *sdev,
>>> +u32 offset) {
>>> +	return __raw_readl(sdev->io_base + offset);
>>
>> I don't think these read/write wrappers help anyhow...
>>
> 
> These wrappers are used by the crypto primitives in this patch series.
> I'll move these to subsequent patches when they are first used.
> 
> Thank you for spending time reviewing and providing helpful comments
> for this driver.
> 

Just drop the wrappers. I said they do not help and your answer "are
used" does not explain anything. If you insist on keeping them, please
explain what are the benefits except more code and more
indirections/layers making it more difficult to read?

Best regards,
Krzysztof

