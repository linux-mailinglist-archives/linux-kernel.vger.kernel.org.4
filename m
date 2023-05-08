Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065246FA316
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjEHJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjEHJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:16:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BBF203FC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:16:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so270931666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683537400; x=1686129400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/T10afqTW6daMTYjhrYC+yDv3aZ7k6tzWV/gJ72nsvg=;
        b=mdRluXxsgs9NgrPR6YCXEZXlM7wuNompAfvEV3zT6FIDODHHPibHG3RZQOdD9OH0fc
         vayPSdJR0Gl76Rg3IpcIViArkQK6w8P1zd3rc7KXtu7b6LW/9ZtlM6lwHPswojJ0Jl56
         gBXmoH5FnrkOaH9LoJJQjXadiNNVfCrrdQJPbXShMBQcQavip4AulrJ7FSSZdq2zepxl
         xNm3D0uRiyBXKenrMDHZy2Aq3B/EuWReX3FJGi9PSDOxjN9GSBIjb7MHpaWAIcr3BA2m
         E5ju47qgGcTArmFlj5pI7i3OQldohn1coZoziDf65E0KskxVvO5Nf092w6MH3sItIUm+
         6xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683537400; x=1686129400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T10afqTW6daMTYjhrYC+yDv3aZ7k6tzWV/gJ72nsvg=;
        b=TbO4vFcE1sBwZvk2eJr/8VeQgdzBMitvEwiQhyOSRxXdsPr8aO1FVzN9/bCUyn9LqB
         hsnFfp3EKXNLTLuE9GKY89/jTC9i/4x3fdBKqskd7bxBzfqOsEdL6UuDC3e0ZQX+GR8p
         XlJLFVxsEXV0Wm58hpphvrxm2O4AyUTCkSxz/SMosVNUkhDJKvGenxrJ9POYKDWE8Q3G
         +/eLzSu2ZFKplqzBkFGFKEZfS1bdq61GKvR4nfTp6M+VKRGRD/5rXOD/Hm2kBOqjl3np
         rnE0lJIYQuBo/itE1EWHWctWOQ0Xz+ssyCuKOR3p/GcFqUibPV0JYNyYlnT78/CrUklN
         o6rg==
X-Gm-Message-State: AC+VfDx7A6ap1YMnHQrWa1p/AWsPUfiFOZhJ9Uv5WSiJLri9Z4fXY+fN
        e4H9g2bkhdhJm3ZU/AFCBDryYQ==
X-Google-Smtp-Source: ACHHUZ7UhEbSqRlodHaeyDCKERtf8Tglu4oLOw6KXMPPRxp7f3mU6Viid9v1zp4McZLtWQ92hmN/CA==
X-Received: by 2002:a17:907:3e83:b0:953:7bb2:28d8 with SMTP id hs3-20020a1709073e8300b009537bb228d8mr8813817ejc.21.1683537400452;
        Mon, 08 May 2023 02:16:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709064f1000b009571293d6acsm4661301eju.59.2023.05.08.02.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:16:40 -0700 (PDT)
Message-ID: <de4c60af-1e7b-1354-ea76-457601b1ec22@linaro.org>
Date:   Mon, 8 May 2023 11:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508085727.GA7252@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508085727.GA7252@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 10:57, Stanislav Jakubek wrote:
> Convert Broadcom Kona family PWM controller bindings to DT schema.

Please mention in the commit log changes to original binding. You added
new compatible.

> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt | 21 --------
>  .../bindings/pwm/brcm,kona-pwm.yaml           | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 21 deletions(-)


Best regards,
Krzysztof

