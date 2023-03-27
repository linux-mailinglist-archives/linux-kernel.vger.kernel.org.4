Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072EF6CA132
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjC0KWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjC0KW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:22:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B13618C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:22:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o20so5476121ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679912541;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oR46Zi0I7Lypt/q9oljjXXwkox+XBwZiyhnyKzMDFHo=;
        b=kC4EVVGcxJLmZroGM3ZWQKwuVEmbLbdRYITkjUDd7ZTw7Pb0DBLD9SKKnHxeUG71fE
         4W1x4loB0JX8nv6jzOOYVz6tEZXKdyvZ27WI2F/XAR/lXicgxptku3xpw/yTY+w5swtI
         1ZNpyM+3GegQY8ACt82jrXnGIQVIlnKHOW1s4DCe1j/07dwXX8AJAuiiyd8bW7talPDx
         usOePNBe38/PCC7soqS+yEaqhpqPBQmjcu2B4FhivpZxsxr59d6Hqegdl+PB+9x4Ks0w
         Geu3Vu/AFsglU6hf23MY67zkBibQz0jc99Qn8+doOzamWmcyZ5gAYWISCBkiUS6Pt+LD
         HeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912541;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oR46Zi0I7Lypt/q9oljjXXwkox+XBwZiyhnyKzMDFHo=;
        b=j99ZM67WKEJg+3Ss0VKf7+1DhZpvwfCZlfJk1Vpr3NaTOP9XdjNhY2WyDgs7LcgQSM
         ocksNW+WrmwfXTQtHfTTP+KadDBpqZKAveAohvsD8GQXgIdORtPMhMfTZRplLlfNnZcA
         5OzUW/pqUFP3m5T321BEcP5/91Q7yVMmR5QpzKqx753OOci0zP84Ig671a8GJlykAGDa
         SesPfNp6MW3okvw1rWKmGWyx5ZjT8ZSzBBGO4Yl+tctq1Rnjm/un+tpZDfvaLEJFCyrL
         Z3KkDC+i8IVEpWsblsWAS2w0mPKNSTk3pkeHs/nG+iaVaRmXfL0DdtJsenv3OIvSaqS0
         fdTQ==
X-Gm-Message-State: AAQBX9dcUE5fSPc8P1t4aFDLmYK3YO6+Yh4ogbWYkTRAJEXatpKV2A29
        MK+UWmEpCGt4SWHyYgMOs9yYOPaG7UJwapx2AspVc0fW
X-Google-Smtp-Source: AKy350blePytZMYW9wxha/NfmuXTTY3El1Mj6rPlob57Z2i7jFwTw+yPHp/YztpVi97Es8aokbK+Mg==
X-Received: by 2002:a2e:9f0a:0:b0:29a:3a61:bbd4 with SMTP id u10-20020a2e9f0a000000b0029a3a61bbd4mr3390567ljk.48.1679912541323;
        Mon, 27 Mar 2023 03:22:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f20-20020a2e6a14000000b002a12f54df41sm2066948ljc.38.2023.03.27.03.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:22:21 -0700 (PDT)
Message-ID: <ff903f95-7425-b3ad-b22f-802b00c4c9aa@linaro.org>
Date:   Mon, 27 Mar 2023 13:22:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sdm845-oneplus: drop invalid
 panel properties
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
 <20230326155753.92007-9-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230326155753.92007-9-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 18:57, Krzysztof Kozlowski wrote:
> Panel does not have children with unit-addresses thus address/size-cells
> are not valid:
> 
>    panel@0: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

