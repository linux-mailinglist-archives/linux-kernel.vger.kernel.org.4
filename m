Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477966E7489
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDSH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDSH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:59:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E74C35
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:59:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so27226926a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681891177; x=1684483177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QDSFk1bWw84sERed1okCfC1U1gkUcGVMuz8bB1DTOE=;
        b=ri1qD4pNuoEqenaRtPy+mtzIvFSYEmqdGT3CQkTzBC+gBrKe4RlYKWhxTp5/3qG9d/
         GwkE8L0UiXu4pVqIooATkKl0p4ep81U1F3kjG9dUV+JHdAQie/aVD4bRTuDwuHtU2MLS
         URJvHGEq9iRNjHwuBMf/NmKmEPOSsV8CB9D2cD9vtt3WLeYixPnJuaVocjC88OmoD7xD
         HRFINRe+6Npzvs3kwSBhGQD9XhrmBkhgIVAFxp0a8xLidE3e527hijgaJtRFzbkqwb91
         P4j3p1jWm4RSjNKB/YrMP8L4oprGyHeMhj/zaZcjoZxe3JiMYv0hGWwRjDRh4szra11/
         4ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681891177; x=1684483177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QDSFk1bWw84sERed1okCfC1U1gkUcGVMuz8bB1DTOE=;
        b=FJk39shdytP4EPpDPetVoto2d6YWkxalkJwwJAc8BkvOGRsYE7Ocpy2qzSQYDEcC74
         cYV3GgNjys6LgNAHbfq5MUQLJYCDjbcV40CkpEGP5UrCCwUxdimRt8NmeXZ0BfNNiDu8
         t9GcCe4KG+lCsPWzOjn7XZJCD4ETuEV1AFkpodzL/toS0h6/HCRGVMpDK2UKvcv6saml
         mXzzFeqLXHlzewV68GS/OD8cBHmPCI00fIEikgI+HrgRlg2iwVvwlvOgNJNUB/H9ychF
         hg/FfaGg6eHy1cahhoKfzt8GraT/qhLkpDeHg9CH11tSL/Z4Wickfpl8UzxfNa8QXxsC
         85Wg==
X-Gm-Message-State: AAQBX9cZIci8wiUdUC6v+uUj74+fPUmRg05i/fsiYLZWi1tIPWifk6aW
        Q0whQ9vDc/XapNpG+VS9LE29RA==
X-Google-Smtp-Source: AKy350bCvHDzh0UHjTTOlBryMDQj0HoSj2qsUlEWGW1bmvg2ZgvGWYCNVj2CW35qxXc8yZEbof1nxQ==
X-Received: by 2002:a05:6402:2694:b0:506:b94f:3d8f with SMTP id w20-20020a056402269400b00506b94f3d8fmr1950820edd.5.1681891177517;
        Wed, 19 Apr 2023 00:59:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7c6ca000000b00506a5606343sm3736335eds.14.2023.04.19.00.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:59:37 -0700 (PDT)
Message-ID: <c49881dc-f283-6981-3e03-02fb02b5ce54@linaro.org>
Date:   Wed, 19 Apr 2023 09:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/4] Improves polling mode of s3c64xx driver
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <CGME20230419062755epcas2p4c3c7c1e0d58e964f6e884f75ae120d91@epcas2p4.samsung.com>
 <20230419060639.38853-1-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419060639.38853-1-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 08:06, Jaewon Kim wrote:
> 1.
> s3cx64xx driver was supporting polling mode using quirk for SOC without DMA.
> However, in order to use PIO mode as an optional rather than a quirk, when DMA
> is not described, spi operates with pio mode rather than probe fail.
> 
> 2.
> Fixed the problem of high CPU usage in PIO mode.
> 
> 3. 
> If the transfer data size is larger than 32-bit, IRQ base PIO mode used.
> 

What changed in the patches? You need to provide changelog.

Best regards,
Krzysztof

