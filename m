Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784EC63967E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKZObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKZOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:30:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820DD1CB36
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:30:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s8so10882325lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOp9VeEnzv5VAO/OaCmDsm8rDMNVnUqD5Q2WOV4X6To=;
        b=J9veXx5lGUVMqWV12L613oXsILLAQ+wdd9j0hxVGO49OzpZdRB5bzLw/nxtcS8z87e
         re99fj8r/ZKReZvZX5iAxs7yR6/s8zsnZU5pPJE+nWXLwcQJcd+fBQYLtqmUayn/5j5T
         ZkSop/96qSZ/eiG/l9O4wG0d+BO2v85G6zRYu86MJVpFf6d72MBrgfsho9hKX2H3RfdJ
         NklZGbzahZi8znKT+oqgqHJhUcsT72isQGFmNnB34J/BSSK91TrYePmcU5fztIfia8oV
         GUsnly+WeWsZjpNgN7rNNmnWzSzdW+x9ty4IueNPFj6GN0t8rBbHWZmuyENj9bI6uOwG
         /b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOp9VeEnzv5VAO/OaCmDsm8rDMNVnUqD5Q2WOV4X6To=;
        b=08WauGLjh63eqBz5I+49PlvVGfnrA4Rivz+3ARMM6Z7GoB7e0xZsR3j2+VlU4bBzYE
         AzwxuIJ6fEmH03Y8vfi2UxGj1plQtecgFaH4ecjlr31D3tIu1i1ne5F7aKYFRjXGi6bY
         Egqd6pDnRjn2YjZKzDd2dVfcCCbt+FaGvC23HVtCq4CmR/3FRyOxuzZzNONvbJa14zfB
         eAxOBTNPe0o+XxzbLMbvDWEmm+AdcUCfJUoq/zd0/WqHDHTrp4mix08qNOOy9catd2aK
         hNVfSBZVLokOYhn0e8/GqKM/6Uzf4BdtwLpPpJ1vMFZN0FDZC7e5cW8jcGPN6oNyvXxH
         Qi3Q==
X-Gm-Message-State: ANoB5pl344KUTiMMtk8GNp4MYTwBRiXcZhM3fC232hVbpqeYqC+TDgbI
        S0wSP7OKBCwnDg2J2gnmfUbktA==
X-Google-Smtp-Source: AA0mqf75yMUiNVRsRqbq4zu5xWBS2wPOH+4izo3ghaVHNNA3rV1zExal1ikJKmniGK3OZXYq/r03dQ==
X-Received: by 2002:a19:5049:0:b0:4b4:661a:1ce1 with SMTP id z9-20020a195049000000b004b4661a1ce1mr13137363lfj.136.1669473054898;
        Sat, 26 Nov 2022 06:30:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p5-20020ac24ec5000000b00494603953b6sm935295lfr.6.2022.11.26.06.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 06:30:54 -0800 (PST)
Message-ID: <30744357-33cb-96c1-bbe9-f544cde04980@linaro.org>
Date:   Sat, 26 Nov 2022 15:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 4/5] dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-*
 compatible strings
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, rogerq@kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, vigneshr@ti.com, tjoseph@cadence.com,
        sergio.paracuellos@gmail.com, pthombar@cadence.com,
        linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221124081221.1206167-1-mranostay@ti.com>
 <20221124081221.1206167-5-mranostay@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124081221.1206167-5-mranostay@ti.com>
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

On 24/11/2022 09:12, Matt Ranostay wrote:
> Add definition for j784s4-pci-ep + j784s4-pci-host devices along with
> schema checks for num-lanes.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

