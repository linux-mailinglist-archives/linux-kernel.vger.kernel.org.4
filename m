Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7271467C80C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjAZKME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjAZKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:12:03 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F0D6469D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:12:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso2923176wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYSo4b7v2dALfP1Df0eTeEVWxTUa2STQKMUnBqUDxn0=;
        b=GZjhimnVyB8ABE25BcNMCX4K5cvXKLFX9/7XFJXFmWd0fVzA8xbb5SnF69GHo5Awid
         U9qfGKNBvE4SqnHKTPF27R4czDFMMTXCeqwW4N7sH4xLI9peB+PdCUBa7LZLRELMINXL
         e+xsGgQ0uDDYcRJeAum85RbP3xOGsbhTkzHTBcZ8VgFTKNwTcSc709iXSV015GHGXHEc
         OWoIe3NL33QRhugZfSPeLEEFA0E+Uv4rBSvBPGr+uS/5e0ONz5N4Ro53OXq0yg4BvRE2
         c/7uKs5wAfg49l35rSQhE6iLlcb41yIY4l3G9YZyq0mYbOefdgyrnAzsf57CDvy2WwJI
         ptHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYSo4b7v2dALfP1Df0eTeEVWxTUa2STQKMUnBqUDxn0=;
        b=TCWzTxa4qbmPUVDtu7XnklxQMRHSdwaCbuIScYfXTPHIBPCXHyBHXoQjiG62vnvzIl
         3GTosvUKfNBfWMCyaEiWJtGP8JHvIEpFfpEmKiHoXsg3b53UrP/k2KrYgrvlf4yuu7DU
         KZWMifPa6disKhcfHYNbLuHoNjoJrpF/kr7XhYSjihKrGdKiF9FU+DYa//1juQfERhjj
         S4e2YcWupfqKgNqKDLXJ+qV+Jle6zPICR9k4Mtq++vqZk12PDpzHIAAf51vdUJIq8GZV
         4cS8eGgiQkwsTG01aBdVdqj0PxLjRj3JCq3VygnpTRDK/Ow+KEzUIclRM9+FbwTSdxqn
         Ha4Q==
X-Gm-Message-State: AFqh2koWffyAUsk+Vc6SOK3YlB14KLvJMXJNFAut9hTqIPuPN7kOccql
        NdXjhVcjVDMtJHSChoV58QWW8w==
X-Google-Smtp-Source: AMrXdXty5S+Obsy12gIkRVUQj7xI2d6znJpHk4KEQhPT0VTsyAZdZkekrWjfOSCKqzoz5U1956k6kQ==
X-Received: by 2002:a05:600c:358b:b0:3db:2e6e:7826 with SMTP id p11-20020a05600c358b00b003db2e6e7826mr23745686wmq.5.1674727920165;
        Thu, 26 Jan 2023 02:12:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003d99469ece1sm4387611wmb.24.2023.01.26.02.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:11:59 -0800 (PST)
Message-ID: <6a682d68-4fcb-c2c2-3190-2b60d0a636da@linaro.org>
Date:   Thu, 26 Jan 2023 11:11:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] ARM: dts: arm: align UART node name with bindings
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123151533.369533-1-krzysztof.kozlowski@linaro.org>
 <CACRpkdajaDLB6VPTrT93Q8y=k8nvkXUGcipTpA1xwzc6kE_v9A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdajaDLB6VPTrT93Q8y=k8nvkXUGcipTpA1xwzc6kE_v9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 11:02, Linus Walleij wrote:
> On Mon, Jan 23, 2023 at 4:15 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Bindings expect UART/serial node names to be "serial".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Whoa! This traces back to things like
> commit 3ba7222ac992d24d09ccd0b55940b54849eef752
> "arm/versatile: Add device tree support"
> Grant Likely june 2011 :D
> 
> Nice that we put things in order finally.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Do you have a way to queue this to the SoC tree for v6.3?

Yes, I can grab it and send it with few other cleanups. So far my
cleanup-pulls were not rejected.

But if any other or respective SoC maintainer can pick it up, this would
be preferred (less conflicts, less work for me...).

Best regards,
Krzysztof

