Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59673820F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjFUKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjFUKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:11:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE451BCB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:11:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-987c932883bso690185566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687342274; x=1689934274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtjhjLVfg04akTkdiibA+NwINqQwIqQCJGUJibyu5wQ=;
        b=dpYS+MO/S9ZRkfjV5PqgIWfu1tcbDUpYNGHMHMvbjfrYG36Mnidl0+WvqsW7Pd8mvD
         rKEmN0UW3yYAe1r/LhNnZRhh4gioL2mxqvTIM4Gab8x5U+Pc6AgYz3xSEAFbUKY9unC2
         K139Ix+LXUNdUsOodmMD16t+qIGRIoyfd86/JKUpVM/khOuflbp4JQUDThhGkWE6/7lE
         3bRpISJy9Z0rn4bEGH8Qs/fxVH9WO8OKd1eMO5pgUM+eYbESiZv/0o2IQSGd1G99NzVW
         afZrWvC/hKUGkRzc225CxQi3HYp/UCoJh8K8C+NKxSF8UBNpxQaoTBewQ9NL/MHoXgcr
         X4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342274; x=1689934274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtjhjLVfg04akTkdiibA+NwINqQwIqQCJGUJibyu5wQ=;
        b=eq9dQhsvYRSgdAEIKmxj3Eb3+S6PRGOq+jnCOyaNh/nHn54P/ZWWIVTOkmb29QLxwf
         rgPXTm6c51R6cUDSeJoMcoDzFPuYmCjBH1/5G/gG38w3RCFaJETSWm7+lGC2Jg6brYUa
         nH9OsjGo/fvb7VXmnbaBEXQnvchiqaG2zpf1XAMLkJ+r9ITH92FCA9Z0qOERmahdBSqW
         J3+2PNGSX2yn3mavyCvZhpNk02e8JfRC5e5oB7srDHYhGuyKrUQ2ubBCT64WPz2b132g
         G9DloreCQ5kPw0Z9NCbu+lbGZDuNAbDOJLpYSlLOhAPxej1/rSIyZ4Zl8ynbxAzuEHv4
         jTKA==
X-Gm-Message-State: AC+VfDyirqS/Xx5YCrBMuuzDFAoR/ciuSnt09zhqHprDLygVaNIDshDU
        TnSCIjI4eyYW/1NEmSfVeApqkg==
X-Google-Smtp-Source: ACHHUZ5pfTVfBtS3MJwsD21zgHNuKFo/GdCgwG7gdMfOGPIee1trYy/f90DoOnO8Q+ogpECi9dZbJA==
X-Received: by 2002:a17:907:969f:b0:947:335f:5a0d with SMTP id hd31-20020a170907969f00b00947335f5a0dmr13607379ejc.62.1687342273999;
        Wed, 21 Jun 2023 03:11:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s9-20020a1709062ec900b009787062d21csm2898560eji.77.2023.06.21.03.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:11:13 -0700 (PDT)
Message-ID: <80cd8bb9-54ad-4c5c-f3ce-c8655cd2ff74@linaro.org>
Date:   Wed, 21 Jun 2023 12:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: clock: ast2600: Add I3C and MAC reset
 definitions
Content-Language: en-US
To:     Dylan Hung <dylan_hung@aspeedtech.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com
References: <20230621094545.707-1-dylan_hung@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621094545.707-1-dylan_hung@aspeedtech.com>
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

On 21/06/2023 11:45, Dylan Hung wrote:
> Add reset definitions of AST2600 I3C and MAC controllers.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index e149eee61588..07377589f8f4 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -90,7 +90,18 @@
>  /* Only list resets here that are not part of a clock gate + reset pair */
>  #define ASPEED_RESET_ADC		55
>  #define ASPEED_RESET_JTAG_MASTER2	54
> -#define ASPEED_RESET_I3C_DMA		39

This will break all the users.

Best regards,
Krzysztof

