Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60656020AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJRB4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJRB4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:56:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFD72B73
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:56:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j21so7845728qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwnKiJHjgGODb7JZ57x/PI3J93dO3KCDNTmDBrZdsDc=;
        b=xflSfO3croZNnEFDdG7BOLArdMlmy+EU22He2ItcgDKF+cPzrW4GyqHfDn+EHI9zAN
         FtdDBSXhjYQV8JJmZVlWlPrOYWCBFm2F35En38JSnLi4GEB8FR+HJsn5CH/fJSe8tLiZ
         rZPdTlOaunKSdBCHtJ/Wh3FxNLQn/RGKWEW5siTVp7xYRUpfj53c/RPUrc+YwaZYUf3P
         ZBvApA9Gxu9brukx62hgnNia1ucmgNCdB4WTZzZh3dfaZAmEqgorXE3an33GUpbFl8Rj
         ePveOh+GWzORHhtyXYCDVUFTvM/kI6mFSBttrncVbBGF8Jpv72/iuyjSg8RV+tstvJvV
         lFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwnKiJHjgGODb7JZ57x/PI3J93dO3KCDNTmDBrZdsDc=;
        b=PCJJS04jKlaeTQYVi9xTWnuoopElVCtWDaMyJX1MQUKjona7DfU2Px0wH3MK/KAhrh
         9mYikjGqleCiV0KyPRk+ILsS4BlRY8gmHBstgW7jA6ICkzNeYW1Le/iN4K52+QLYlLcS
         RydT5i16d7uU/ymCATdwe6P/bCtfsAmZqNjtxfz7a87vzwsqsDSOXwyl68hi6RDugcU1
         CSMidVLdwSk261Nuv7/w2XQ6lm0Jka62Q30K0bwc/t6wnuXB/jN+NuQ5rwg8CMPgx6t4
         4C8kZX/ZT71s4dTBOa37zncTNzefU7x90vB99uSW/sYmPPZ1zPHil7s+uxxQAM3bxvja
         5ziQ==
X-Gm-Message-State: ACrzQf01WJA+hHaACypiRZ4vbM/lfW3EmWtsRk7yrY7ghsCVET5r0cbO
        DysL923YQasHvPMXFW1Vg9yMrg==
X-Google-Smtp-Source: AMsMyM5ocMIfY0aC8/+qBtf+hP1sxMYMg/Y2wsOOlblki8BnnPjo0vYAfLgMcatAAS2jP/FXcwSJYA==
X-Received: by 2002:a05:620a:1982:b0:6ee:c63f:f983 with SMTP id bm2-20020a05620a198200b006eec63ff983mr373977qkb.382.1666058184215;
        Mon, 17 Oct 2022 18:56:24 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s15-20020a05622a178f00b0035d432f5ba3sm1053661qtk.17.2022.10.17.18.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:56:23 -0700 (PDT)
Message-ID: <7ada410d-8d13-b29a-869c-3f5d032528bf@linaro.org>
Date:   Mon, 17 Oct 2022 21:56:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] dt-bindings: nvmem: add new stm32mp13 compatible for
 stm32-romem
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid>
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

On 14/10/2022 11:23, Patrick Delaunay wrote:
> Add a new compatible for stm32mp13 support.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> index 448a2678dc62..16f4cad2fa55 100644
> --- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> @@ -22,6 +22,7 @@ properties:
>    compatible:
>      enum:
>        - st,stm32f4-otp
> +      - st,stm32mp13-bsec
>        - st,stm32mp15-bsec

According to usage in DTS (separate patch for some reason), the devices
are compatible, so please describe them like that.

Best regards,
Krzysztof

