Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE96D78A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjDEJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbjDEJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:42:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5935259
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:41:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so139580156edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680687713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GjPZEs8t5YeiwXNylHqVxhWNUDxoz5iAqxoJIu/8Q0=;
        b=yLqz41niCnA/4M7/IrxcpnX+Rzo4R6MbgmPCqwq2kgPg/nr+Y/R4zhnDHiboyEfeHZ
         sgsAvPj4xkfkVHxUQ/U/64JQKOaevc52GhQnSgzkueU/7uAgfWHsItJaAtvGlGEgbue6
         aZdgY7oKNN8kRfDtsIE/r6thnnk71KDvsVKxmdmM23LdB5nUHJaKh3lRf8h7jBgudKmS
         O8SaYoHpbZ25XDySw1N0lu4UgF9GS9ntyjnJhSKurB0EznnNBmRB267YvyBmuAhpazrO
         CnVSvdOpFVZAZ6Rse1DqDZctMuGFLwb1DBbIDUNky4dLha8Z/Qf/o5ctMJcn+pQQGjVa
         9mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680687713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GjPZEs8t5YeiwXNylHqVxhWNUDxoz5iAqxoJIu/8Q0=;
        b=h7AnmIdB1iQG9U0F/1s7XHqiJG0zxoLGcUh8R+ymIMwHl10BXAJYHORjSr0chzKzYV
         1jqCLja8J5UiDQD292zDNyhcl/1B2X2oNReaM+Z6cV/ZHuFeNxZoSNbN0kWcCEIgHGJK
         lQ4sEdrSLdRMprL61SUfjHtFmJwoWrByJ1opeF5Gc4+gkfintqqcZbgf4PpB0M55MuAD
         Ly6iqqQ2OkqVK526qOxrsSseT/7TfKFJLLflfmHZwzIxamrNhWVKzaAp6WADC1hSgdA3
         sxkvrG7HEHpSidJKymz+BizLcBQyW4+gpPnVp+PQwAzoP4s6gLd4khjR63IAZnaynCmZ
         Q8jQ==
X-Gm-Message-State: AAQBX9eYVm7gf3xRcAriZ3TyhqrtbQGp4LMI68FAvSbfzmcHWvyefJwc
        esiH6t5yIKAQ/9pgHLCWnpMerQ==
X-Google-Smtp-Source: AKy350Z+GWU8X5Rfpn9ZSONreiFN8UZk88nM4GBu2VN6MfCfdsudG3SA9Oy22EAYtXBrPqLsB6sqfQ==
X-Received: by 2002:a17:906:a854:b0:8a6:e075:e364 with SMTP id dx20-20020a170906a85400b008a6e075e364mr2221475ejb.26.1680687713687;
        Wed, 05 Apr 2023 02:41:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id tc27-20020a1709078d1b00b009231714b3d4sm7142175ejc.151.2023.04.05.02.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:41:53 -0700 (PDT)
Message-ID: <1403741d-ef51-a9c5-821f-358c8f470dab@linaro.org>
Date:   Wed, 5 Apr 2023 11:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: qcom,qmp-usb: Fix phy subnode
 for SM6115 & QCM2290 USB3 PHY
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org
References: <20230401154725.1059563-1-bhupesh.sharma@linaro.org>
 <20230401154725.1059563-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401154725.1059563-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 17:47, Bhupesh Sharma wrote:
> The USB3 SS (QMP) PHY found on Qualcomm SM6115 & QCM2290 SoCs is
> similar to sm8150 QMP PHY in the sense that the phy subnode supports
> 6 regs, namely TX lane 1, RX lane 1, PCS, TX lane 2, RX lane 2 and
> PCS_MISC.
> 
> Update the dt-bindings document to reflect the same.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bhupesh,

Can you use scripts/get_maintainers.pl to get the Cc addresses instead
of writing them manually or inventing?

Best regards,
Krzysztof

