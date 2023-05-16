Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8749070536B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEPQTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEPQTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:19:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729716590
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:19:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so21926181a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684253978; x=1686845978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaNzDytKqYPAZsp26FNZIIhEVNWfazEUuC6HzAcCkS4=;
        b=jNw7hw1nSUEm/6PFuBOaVKBHFSdM/ffRiVjXEcAlIfbsY7CSdW86Crcb6uGQ9fyZQ7
         G/VXHWQywY0YyDySbbEpXoUSl5HS82xu3N7JUbOUKRk367bnXLePnxGxdL3n5cKZb4/4
         VwNN5RDTXiJ9FA5PYuPqIGh1kVC8Q+kZHnOZySaITpmdtpLylEdOCdIWNETv+TQpWiPQ
         FzmQgR9AeGDvwWh5xYX/lOaNPA+NjS/pcdoNERX9pqafoBSsm6fvUdvN4/KWC6VwvvRM
         msgV3pdLbKysAgdHJLTophccoW98cSbnU1a31DwW/xKEd4y48GR5KFSuGcU2Ui3tADfY
         /0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684253978; x=1686845978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaNzDytKqYPAZsp26FNZIIhEVNWfazEUuC6HzAcCkS4=;
        b=Hsf6Yp13fm0JwpO/DZCLz4j5WPYBDM2BkImMHyMakUvdHgMyRWkYzS8jBOEjSoTwaZ
         3Z8oDCGJcu5nTf1PAD7Mn2W61ZAGc3vO3Yxtp52ZjBplmawNbaUgY7xYeemvHIAEtN8D
         4ECqhwZKCTXFp5lcZFJJC4m8zrH18kIt+36JxMio92OhcbQH60r2PNs0ZaZ19TXxVi6X
         /xea1y/f3mdu2+5h7OWbMH8d8rK5Z5JXZmulAxN+SwL9tUETmizaWaThVMI+8NzGRpoT
         42oEfNu0Am94W0Oz8b8OPj3RIBzD5cDZJcCcTUQTUkREUTzggo5vsJ33p5LPVSRAhYYF
         xQ/g==
X-Gm-Message-State: AC+VfDw7i3wSg1ZDT8kWPGgRZ2FKRjroaSL2erdPSBqqF9/w0/RxgSq9
        T9Je0gnICTOYn0nTHYa9IR33jg==
X-Google-Smtp-Source: ACHHUZ6rtkfQxJa6Fjf8N8LU7e5f9iKQrxMltx9B/V9t9fRXZ1GvWlihZx+luY76Zxd/kgcf5sKiKw==
X-Received: by 2002:a17:906:fd88:b0:965:a72a:b2ae with SMTP id xa8-20020a170906fd8800b00965a72ab2aemr31696990ejb.60.1684253977867;
        Tue, 16 May 2023 09:19:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906368a00b0096b275e19cbsm3460090ejc.115.2023.05.16.09.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:19:37 -0700 (PDT)
Message-ID: <7d73a37f-80b7-b623-1b71-fa19bf379713@linaro.org>
Date:   Tue, 16 May 2023 18:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515191909.611241-1-afd@ti.com>
 <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
 <895c84f5-4a3c-fd2c-2b43-1a1996862e15@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <895c84f5-4a3c-fd2c-2b43-1a1996862e15@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 17:18, Andrew Davis wrote:
> On 5/15/23 4:14 PM, Peter Rosin wrote:
>> Hi!
>>
>> 2023-05-15 at 21:19, Andrew Davis wrote:
>>> The DT binding for the reg-mux compatible states it can be used when the
>>> "parent device of mux controller is not syscon device". It also allows
>>> for a reg property. When the parent device is indeed not a syscon device,
>>> nor is it a regmap provider, we should fallback to using that reg
>>> property to identify the address space to use for this mux.
>>
>> We should? Says who?
>>
>> Don't get me wrong, I'm not saying the change is bad or wrong, I would just
>> like to see an example where it matters. Or, at least some rationale for why
>> the code needs to change other than covering some case that looks like it
>> could/should be possible based on the binding. I.e., why is it not better to
>> "close the hole" in the binding instead?
>>
> 
> Sure, so this all stated when I was building a checker to make sure that drivers
> are not mapping overlapping register spaces. I noticed syscon nodes are a source
> of that so I'm trying to look into their usage.
> 
> To start, IHMO there is only one valid use for syscon and that is when more than
> one driver needs to access shared bits in a single register. DT has no way to

It has... what about all existing efuse/nvmem devices?

> describe down to the bit granular level, so one must give that register to
> a "syscon node", then have the device node use a phandle to the syscon node:
> 
> common_reg: syscon@10000 {
> 	compatible = "syscon";
> 	reg = <0x10000 0x4>;
> };
> 
> consumer@1 {
> 	syscon-efuse = <&common_reg 0x1>;
> };
> 
> consumer@2 {
> 	syscon-efuse = <&common_reg 0x2>;
> };
> 
> Something like that, then regmap will take care of synchronizing access.

Syscon is not for this.

> 

...

> 
> Ideally DT nodes all describe their register space in a "reg"
> property and all the "large collection of devices" spaces become
> "simple-bus" nodes. "syscon" nodes can then be limited to only the
> rare case when multiple devices share bits in a single register.
> 
> If Rob and Krzysztof agree I can send a patch with the above
> guidance to the Devicetree Specification repo also.

Agree on what?


Best regards,
Krzysztof

