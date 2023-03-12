Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B406B6891
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCLRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCLRDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:03:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84E231FD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:03:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn21so9563899edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678640609;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sb23CZmLMpQIKautcfOtvCOr/nEk73NUljHh8CGjn+8=;
        b=vojrjS4nvWtK4Bwi52nMdMjmrkLHtZzOnVt5bQ8mjdaCgdTbH/54VnLn1/031Uxj9f
         lBtKmykmp0ZF1DG2YuNi/RSdi1CO+W7RWWYNcoECvBo0mMLGlkbvwQv+nXUQ6TIuFqdw
         +9ES/hlmMdauDGNP/sjHBPL3IktSZM4/X177HWYxI5IQ0SPky78q+RTQmN+QlDMrqq8v
         7Y04/ZxoSa7iDUJA7qmo8t4S8jyjzZOxmxgI4zW2Ph4kmc3t8mmxQ1XMPw23jYl/oJHH
         FQIAtxxzNmVvsYnt8kZfI1zcBbGRJbuALegL31VBFe6Mm4AMmySuprASR0Y1iimCuMAb
         Sztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640609;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb23CZmLMpQIKautcfOtvCOr/nEk73NUljHh8CGjn+8=;
        b=i8IMDApXzAHpRMKZZy4zsHwM4Kw49lX9LhUh1DH9vKfx76d8U7PRAIT9gONQUAAEcy
         rAtxuuRFCI7Dza3SQUbm839eIKhuHTvU9J/x6iZdVjtAO2q1uJ43wTKgIvON+K2P7GHV
         Huxb15x0VICUbJwGRLPBwB86LXlQ9JPhR6kV9pEUXWvyQRf2iZPxHyz/iBqG52NHz8ET
         vuw7UuE/VCBT1c7TsUAU6GGMikRiCRPaGj541gNSyKuai9jwAaY2V0ZvUgtNjysUErqu
         2UOT1UaBGvUZ1MgX89dk+Mjev1rcTamfGzcSiJxMUDThcmcgY/16Ufl5yRWekRgYY6yo
         McHQ==
X-Gm-Message-State: AO0yUKXrjFSnEbLRVEWPZDi0wRwCzH+72Ay13NmEOa5lObnhuuNyfnc9
        Dwems/ic9Y8LPswPV20a8VXtEA==
X-Google-Smtp-Source: AK7set/+EAadHkg/X++PpHf3W9hnABrYPPySwyx5evVFobSq+Tn7ulCFd434kt/CZ6saMByfp7Dp1Q==
X-Received: by 2002:a17:907:320b:b0:91d:9745:407a with SMTP id xg11-20020a170907320b00b0091d9745407amr8604167ejb.14.1678640609455;
        Sun, 12 Mar 2023 10:03:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709063e5000b0092435626c0asm1308055eji.29.2023.03.12.10.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:03:29 -0700 (PDT)
Message-ID: <77e484df-711e-abe7-cb4f-b6db6f3c228a@linaro.org>
Date:   Sun, 12 Mar 2023 18:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/7] media: dt-bindings: Convert Samsung SoC Camera to
 DT schema
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
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

On 16/02/2023 15:21, Krzysztof Kozlowski wrote:
> Hi,
> 
> The patchset depends on:
> https://lore.kernel.org/all/20230207205834.673163-1-krzysztof.kozlowski@linaro.org/
> 
> Changes since v2
> ================
> 1. Move size-cells next to address-cells.
> 2. Drop dead/debug code.
> 3. Add Rb tags.

Mauro,
Any comments here? Can you pick the set up?

Best regards,
Krzysztof

