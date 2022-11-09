Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABC622CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKINvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKINun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:50:43 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB22C106
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:50:41 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a15so25841774ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 05:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFZg5Lk0YUDHQefo64cd18AIqjQKEsxBGKbtInmBwT4=;
        b=CQp544BNM4KqeIyk4UcQJ/HVanH5nN3a/Udqm1aMCWKw5E1PfhQxJdrHExLSGWH+AE
         XwZraC8hYZ0c/xoPCXATEL/0esYUHjdfvHGfSQiPWZfBZti+ClBzCfj/h0XHSuHBdC5Y
         eV1TSIWeAURYFdtjrCIzqN8VfcZjb/DyfJSbb0Vx1DDfi3KVKEzDXXuWvv+V7YhMHhu5
         UVrP13S4HgOvicqkO8ZRXDhGw+90Ixa1C8qwZbCr8pqg3RenDfgejqg1O178CvxeXrBR
         CdgsydtQW9jKbA4n7GTRYX8qGCsCFImX8ZJBMFlM1Lql+t9fN4i60nTMqfl25LU8URQQ
         XNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFZg5Lk0YUDHQefo64cd18AIqjQKEsxBGKbtInmBwT4=;
        b=2MhL0j72yr9x8OR1iYPtJQ4B2XcCM66lNvZCYLNnbI07iEnFlevzMcUgPEfxI80XLP
         mk8QmF69pmws+4k2gznZ3nVRkrQc/X5r6+MYbFGreJhasd7DI0nkBsvvMB2c3f62Tt76
         Dd3l/FH9CUrphAN99kAwEsozmfloczHgzJKqh0/2LdWhk4uuqnzEhbp989FMng50LkC2
         DyoCsZ81NLbes6h9ZFSxOJQuuElLApULhhXzi/df/GcnEzeMxxAcOTsdP3E0eL1RjVwf
         bNldR/wYUvTd/TXOcmDVdDlJUtdwlvxNpPw1KE0HfORxSPGBmIyW+9B3F3vQWhAnLc7b
         PgPA==
X-Gm-Message-State: ACrzQf2+2VHCp2GCkkSuOZ9ddOMTmE8eqi7RfyWWhbEABI+fWSzEwRJj
        Q4AZ6t7fTvqZ/JdAHd73NfDFdA==
X-Google-Smtp-Source: AMsMyM6pqepF0MaRpJkl0gk5rhLC0+DZ4vWqAKGf71C706I0FaUBy55Tsir8RAQCIDCtqQm1P5ZHWg==
X-Received: by 2002:a2e:b529:0:b0:26c:6dce:ce59 with SMTP id z9-20020a2eb529000000b0026c6dcece59mr8208846ljm.130.1668001840272;
        Wed, 09 Nov 2022 05:50:40 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id v26-20020ac258fa000000b00498f871f33fsm2233540lfo.86.2022.11.09.05.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 05:50:39 -0800 (PST)
Message-ID: <dfbb5a16-04f8-ab50-d54b-f92117d0eb0e@linaro.org>
Date:   Wed, 9 Nov 2022 14:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221109110846.45789-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109110846.45789-1-konrad.dybcio@linaro.org>
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

On 09/11/2022 12:08, Konrad Dybcio wrote:
> PMR735a also appears to be bundled with some SMD RPM SoCs.
> Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

