Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A318716183
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjE3NU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjE3NUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:20:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B8B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:20:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so3998379a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685452850; x=1688044850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ea2LdewWSYBlTGL1pC0uVnJLZZioO8cfJgJDEPtNoG8=;
        b=qvydoxNAZHcUiT+Wxla0aaBfxHooTFXK0IF/Trw7A2o/U95eS5pNGk7nya8DU3YaHN
         VqSVNL8jYNpuvaMHVgCheZfgdBYEivZuPcOXK2wo0noNfFepqoA8vw/wYg/dXBRkXiK5
         jbgKSMCokog2ZTK6X5VD4tK1bCoKDOk/JemiAimkGQ92Rqh711M8pa9yyEVMT0g034dW
         iK2w9byBhHkDClsxWReyXeebR0jD2fus3SA/TKkJMPYK5qKVTLxO0H8330wH2m5nL3Ac
         hsN891MLZjnN9/8xa7GMqvdRtdKOcxFyZCz0pEfO8uMWCW4QU2SbvHV5gDvhphB3dzBB
         SU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452850; x=1688044850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea2LdewWSYBlTGL1pC0uVnJLZZioO8cfJgJDEPtNoG8=;
        b=W/WsACJeSdPqU7xmTngxVdnLMKr1lLxzEUUfZVV9FgBqJpzX9j6EjLgnhLUceZNffZ
         s/rsnhWgNJedW6bMJGK9Lb+0sQKFCeN3yR4jmTbnWB/uV02/Cb0O86Xr9MBWICwQreDf
         n+KSuXp+dxckPiy6c0a0DQvIZ4ih4oZZ7h/1a+PO4YkQrrO0BWEgmSsOo3a13NHFX9ua
         SxO4ODl4aOHZOtO3bzkWioan2oM2FV3qosLTRdQ/elnaloLlb7ltsce50XZLIIGH1pHU
         AaLQyl6IBTOGqenU+SvqWk9Ka2nB0iCVGJp3ZkttTRy7utoyW/BZX2aP3GMjwxDQ10Rq
         afQA==
X-Gm-Message-State: AC+VfDx/CZqopz4VV613pxYjm0acY79clXKipYdvW81aWPaSCUK8Rw9f
        ZIFReOBA9UNS4xEfZm3fm3/gnA==
X-Google-Smtp-Source: ACHHUZ5Ec8mS0WQOTPmfsRcm8kG86wAB7r6cdlwRv8fyLj+55BTyGZ0d5j3fIeUVp34EMJ4rhBObtg==
X-Received: by 2002:aa7:ce0c:0:b0:514:9422:37db with SMTP id d12-20020aa7ce0c000000b00514942237dbmr1488683edv.39.1685452850273;
        Tue, 30 May 2023 06:20:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7dd0c000000b005149c3fa632sm2798999edv.13.2023.05.30.06.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:20:49 -0700 (PDT)
Message-ID: <d2a69542-14e3-ea15-0c21-93d0df19fbf8@linaro.org>
Date:   Tue, 30 May 2023 15:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] ARM: Add Samsung Galaxy Express support
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     david@ixit.cz, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230524230459.120681-1-guptarud@gmail.com>
 <20230524230459.120681-5-guptarud@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230524230459.120681-5-guptarud@gmail.com>
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

On 25/05/2023 01:04, Rudraksha Gupta wrote:
> This adds a very basic device tree file for the Samsung Galaxy Express
> SGH-I437. Currently, the following things work: UART, eMMC, SD Card, and
> USB.
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---



> +
> +&usb_hs1_phy {
> +	v3p3-supply = <&pm8921_l3>;
> +	v1p8-supply = <&pm8921_l4>;
> +};
> +
> +&usb1 {
> +	status = "okay";
> +	dr_mode = "otg";
> +};
> +

except what was said - drop stray blank line.

Best regards,
Krzysztof

