Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C461E1A3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKFKcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiKFKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:32:10 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7941657D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:32:09 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so13074973lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 02:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKYJOkirmCecq9ezHzpl0WQVkwqT4CQCl37ykbl0Zzc=;
        b=hsyMaz80e4MLIWes0KileGeBWI8raCMyY0pY0CIvH9kSmZV4hodx5vJaCCgICypc3Y
         uDaDBJwyMmo6EJfePQTYDJXwazXVPlQNrMeM7QC96cXuZbpWLi+guNoNYQOkcIrV2ax4
         Jn23oGy2g3Dxf+TY/6IG2lCe/ieBBUhL9gI97eDPBO+jx3Fd4JyDI/GMdZaf9fgXdO4U
         JUvij1CaheKxShzQFBCq9wTWQQqfvf3rDx9HcJX1y5yHCUW1anM6E3MX71R79/c+tt6F
         Pt3ZGRWaJNaSGYXYeAb2Em/Sq/J2ole9jXmhlIIt8SVBTezWCAbAARNAOm0GQOEE9EjF
         2izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKYJOkirmCecq9ezHzpl0WQVkwqT4CQCl37ykbl0Zzc=;
        b=N31cDAE9fLigeBbPAZH4xgvDTWR4TbjNYYpCoJfipm0eeTwSXltKfIapXGkfe2Z7r0
         95woWDfyxEGJoWyHb5IV2ZOhcNGr2/Qrs01OuDgfNVeGgcYKWVW0+KF0nRnWogJo2Noz
         g5TWArrLJib6NEhTEOeXfT3xM006EswbrbQZ3xItMBDSAVJgs6TNUMLrrGcchy5acwtP
         QEWE/Z96a0/HmD0LWCHzywvLl4c/PEjOW5Fkggo+wgnGwqzLqFuc/t8sGUX6Y12PJoQW
         Cn6oyv31o93vWDM5Scu9fz/g7hkUUqCoUghCBub6ASrG9Mfo4GHqdBKEovOq9THC31Og
         W5KQ==
X-Gm-Message-State: ACrzQf0txpANbbrQhOrA0VFpXlTEoTKnYuaNzSbqy8wsDmincuAsclPg
        q2rCjMMuVxbB43didCqBUOQe5A==
X-Google-Smtp-Source: AMsMyM62YKz6Gaslh7qeGOV096YtXnoCOEfNwT2yIiYZoZ7xUHy+2qkLcd96zaeHQgQbQynT0YRbPQ==
X-Received: by 2002:a05:6512:3d0b:b0:4a2:6d15:91ff with SMTP id d11-20020a0565123d0b00b004a26d1591ffmr16224777lfv.575.1667730728289;
        Sun, 06 Nov 2022 02:32:08 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b00498f23c249dsm644046lfr.74.2022.11.06.02.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 02:32:07 -0800 (PST)
Message-ID: <ac684379-d3a1-be60-1b46-71561e668c23@linaro.org>
Date:   Sun, 6 Nov 2022 11:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: thermal: cooling-devices: Add missing cache
 related properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104162450.1982114-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104162450.1982114-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 17:24, Rob Herring wrote:
> The examples' cache nodes are incomplete as 'cache-unified' and
> 'cache-level' are required cache properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

