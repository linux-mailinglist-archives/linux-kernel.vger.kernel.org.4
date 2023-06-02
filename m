Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96D720315
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjFBNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjFBNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:19:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B420BE74
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:19:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-97454836448so195667966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711958; x=1688303958;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zBNFld6x+FD3yAk+79YEoPyi/MHsa3BOoLdsyaVmPR8=;
        b=MkPFzKJ1ZteRe5HoTqFkv1oW7AGMHQG8UQ/9I+yFUC8OF38sPc+TJT+HuxeWywaHvK
         6svn/iw/BInzAoScleJskTvDJ05OaL6zEsyMdVo+WMeQ8A4OHIfpsoizYR9DPB+9i+hQ
         HYyUkSeoo/tROlPVW+0+b2ljDaEHZO9FZsY58G3IcdGIdznGEM6dkOmV8RZoMg12LWk4
         dQBMqiGNufdG9NB0obeLQl5l4k178c4GpjD4TCihvpiEU83XKFj23a4m+KHE2BG1hYQS
         XQSf16s9g1s2WUkcWMUHh9lk0YutqEf0S7+x4f8f6Avhb3BDTHEmlPFwa6ist+XLU0XH
         duBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711958; x=1688303958;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBNFld6x+FD3yAk+79YEoPyi/MHsa3BOoLdsyaVmPR8=;
        b=UtFXhPC8VsIQS3FgcXkwPVBoTRYDNrGj5FVSuzIe8DNlzTdLYkM5Xk7Z2fjo0hfvgE
         JPDPeXjcA2ZQVecrlNiwxQAn4hEApKA0k1DbJfxpwIaL+PYcTgHbIe7U60kmO9gK8rF8
         Bq/5FW45qPV1JXIgzYcxrF1jXdz+Xa/Yl9KHx3cMSrMecsnsIPpTYn/BFlSmBOn7F3qI
         pjGJys6RX5vQgntr6N7+ouWfVyZXNI/D6ZPR9GK/sPgsGSNzDo1GwCEyoe6V6ERHcqOe
         PZDYNH8jKgNoJ05N/A63SmRxwk3vqoLtt/2vVAX8Iz/MPMO4oUJ5LrKx8R8BmLwgiQ5e
         Nu/w==
X-Gm-Message-State: AC+VfDzE7aaoYaxnSDvly+zgJGjsCAdIF1g4f8wOq+Y2MrWmSK5iSScR
        k0Ihu3/veWI8+eFTgmURiV0zIA==
X-Google-Smtp-Source: ACHHUZ7zMgpL53XXDN3fliIzzCq2tEI+Abjh93xl4xgpetYD0ZyxlHnaj+VktT5BO058F/xfMpgo3A==
X-Received: by 2002:a17:907:9813:b0:965:6cb9:b768 with SMTP id ji19-20020a170907981300b009656cb9b768mr8974330ejc.31.1685711958189;
        Fri, 02 Jun 2023 06:19:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906851500b00965e9a23f2bsm747873ejx.134.2023.06.02.06.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:19:17 -0700 (PDT)
Message-ID: <92428212-2fe5-a07a-66d1-67b6939c7c9b@linaro.org>
Date:   Fri, 2 Jun 2023 15:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add nvmem-clock
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2167d5ad-7e99-4eb9-a313-030fc7a7d546@emailsignatures365.codetwo.com>
 <20230526143807.10164-1-mike.looijmans@topic.nl>
Content-Language: en-US
In-Reply-To: <20230526143807.10164-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as my previous email probably got lost. If you got it twice,
apologies.


On 26/05/2023 16:38, Mike Looijmans wrote:
> Add bindings for a fixed-rate clock that retrieves its rate from an
> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
> or similar device.
> 
> Component shortages lead to boards being shipped with different clock
> crystals, based on what was available at the time. The clock frequency
> was written to EEPROM at production time. Systems can adapt to a wide
> range of input frequencies using the clock framework, but this required
> us to patch the devicetree at runtime or use some custom driver. This
> provides a more generic solution.

This does not look like real hardware. I mean, the clock does not fetch
its rate from nvmem, right? It's the Linux which does it, so basically
you described here driver, not hardware.

Extend existing fixed-clock bindings to allow reading frequency via
nvmem cells.



Best regards,
Krzysztof

