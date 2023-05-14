Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601AF701CAE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjENJkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjENJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:40:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FDE2107
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:40:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so21604290a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684057228; x=1686649228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUW5Igqs7LC8kFWD+gx7NXGPi2rebIGLbHvwwwSiejg=;
        b=qXXhvc16BjYtVI3RbWOmC2jcpEyJzngGFk7rTOlKurSjGDFWBpYgdEvBtpF7PbvqPk
         LcF8bPTz/Z2ubuDmYhgV4xpBsUpjue1LmwZElZ5UBB3Ko/KlU8ajA0UnrVTl7a6MrT/R
         8ZFK0CXEPdUAYwSd9NrcTMyzrHZRaCaEjkk/f8HcdW4jOnbwkRi+iFozOOjGzTn/WjNP
         EMVB013lxv2F6V1fzPbMtP4n/+dw/vhcALq2AUFAFTngW/dtGKYKjRISLzCtnwDsoa0L
         rNozicmyV8IeEo9P2/2j3Gntpa75d5DBBMc1QToOBDpLjhFPh5WWT9e59MeOz8xE+zL4
         1FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684057228; x=1686649228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUW5Igqs7LC8kFWD+gx7NXGPi2rebIGLbHvwwwSiejg=;
        b=Ptt+5yLP3JQRrZ3bgP/0h9ULisNruSFJBYedI8x2RLLfdBhqJGbPn4f0UzEaBtLmxV
         hWXD+6X4a82Ycyq8ou/KqtQHB31SQvxJM7wVaL6C88Ig/HapiRsch/zv95uYLkCgGpST
         /9wSg5rc5D8sPMKLPIhIy6aJUScYfJC8iD6w0+pnoABr4uDXvf8hL1DOsxwTdii6hJIG
         v8f1Kd8BSvpQdrmuigY/eoM4+m+tVmgAwT0j92PqyToUenx70Ts7fhwHShIK+Y08aEnF
         b9SwBKKjMX8WzyhKj6f1sZTxck7qA616HUiAFB/8LY7Q7OWcVDZnttohPis3qJWi4fHx
         BFuA==
X-Gm-Message-State: AC+VfDxepXa4M3PWow9Dol5FumvpLtu0sDFu/mboPIs+qJcscinbCHit
        apBV2ItzBiNdfsCTo4KX8F6f5w==
X-Google-Smtp-Source: ACHHUZ5tvbL4jEsqJPpeimvea31dJCAToYMyDZrxSAb7ema2CejXD77WW74NrQEAUWZyA9z90xWIjA==
X-Received: by 2002:a17:907:1b29:b0:94f:2d5f:6949 with SMTP id mp41-20020a1709071b2900b0094f2d5f6949mr32171616ejc.42.1684057227954;
        Sun, 14 May 2023 02:40:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:715f:ddce:f2ba:123b? ([2a02:810d:15c0:828:715f:ddce:f2ba:123b])
        by smtp.gmail.com with ESMTPSA id w10-20020a170907270a00b00965e9a23f2bsm7882998ejk.134.2023.05.14.02.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 02:40:27 -0700 (PDT)
Message-ID: <e61d2168-9114-6f95-2607-a553d1046caa@linaro.org>
Date:   Sun, 14 May 2023 11:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] dt-bindings: remoteproc: st,stm32-rproc: Rework
 reset declarations
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
 <20230512093926.661509-2-arnaud.pouliquen@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512093926.661509-2-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 11:39, Arnaud Pouliquen wrote:
> With the introduction of the SCMI (System Control and Management
> Interface), it is now possible to use the SCMI to handle the
> hold boot instead of a dedicated SMC call.
> 
> As consequence two configurations are possible:
> - without SCMI server on OP-TEE:
>   use the Linux rcc reset service and use syscon for the MCU hold boot
> - With SCMI server on OP-TEE:
>   use the SCMI reset service for both the MCU reset and the MCU hold boot.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

