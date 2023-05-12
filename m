Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1667700381
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjELJUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbjELJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:20:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826E10A3B
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:20:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so14360029a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683883226; x=1686475226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WI1u2xkb9PqtJQUWjL66JWNoMo4VYDMfmdWYrQ5IOWQ=;
        b=WtPgo570zS6ebbv9Yc/nBC0ha79anvKxdZiQrKzJeBz+UFBiRf7ElS5gA53d/G5uWu
         JlAWsvJCmsJtdfB3/pXDS6KXWI2yro2GTJ5PSMp1OEtWJpTXA3OBfoQz74ZGMiKXJDWo
         UWv4hYTtuWaWO8+vR2eVANOz+31H0QUFknQhVgAjhmM/zcsvo3MMyGa2r2MnuZGDztuF
         fDAV3jnSvQWl5B8BDCSL305v+fgAIGu0Gc8Ty4y+Il56s6mkl1t7HkSCe5zO33aY5uR2
         qNT1rOomfTaCap5bFEwDwO/bhrlcSWAPjrEC3PR3ZqN6UZ7N/K7ut17oFh9MjyGl3VDj
         7Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883226; x=1686475226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WI1u2xkb9PqtJQUWjL66JWNoMo4VYDMfmdWYrQ5IOWQ=;
        b=a36C/HvuYU86GZLXog9rALFItcq9pzf0Q1+7UeOVgXcUIB+Zih5YoWl8TfVmxc4bRL
         RUAmzgTIUfb5h52g4Zh+wRqBmdiBO/FMLA0QeMl4opgJ+HATjnm9PAUG6d70BIkEfMEZ
         E0xgynL5/dxxPdCM7bvpG+nJYh2tl5ghIPAMD19QPPFzVcdgwYER7gtHFD2lZoTk9aX5
         gWz/uM4izmpaVSvAP0D/T1a+zSPENCCU9oVqQsojSUexSUi/xPnGeXNua1CUjft+9sDv
         8xAvmsu4EQpdiDTbWB8tdOxMY71bKk+azyNbmF5yJFvH1djj3j2FqitZopAFoXGrizCa
         cBzQ==
X-Gm-Message-State: AC+VfDyQYgmlP1hHCkWxTKIq/9u4TktXc8pwc1QGRJxwZ5D7FYvmzvuw
        8WMDFaDaz9xfOikp9HJ1+sfC/Q==
X-Google-Smtp-Source: ACHHUZ6Xn7wGH3fCpc9H/DFbINSt68g9jFaNkYHKCcHId0qutYH8EdMIv50O5lupVnLDPa+bQ+gnHA==
X-Received: by 2002:a17:907:3d86:b0:967:5c5f:e45c with SMTP id he6-20020a1709073d8600b009675c5fe45cmr16258136ejc.0.1683883226503;
        Fri, 12 May 2023 02:20:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709065e0c00b0094f410225c7sm5059247eju.169.2023.05.12.02.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 02:20:26 -0700 (PDT)
Message-ID: <7496f2a8-db87-ffec-8ea8-2f9ff7511a75@linaro.org>
Date:   Fri, 12 May 2023 11:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] clk: qcom: gcc-ipq9574: Enable crypto clocks
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_poovendh@quicinc.com
References: <20230512090134.9811-1-quic_anusha@quicinc.com>
 <20230512090134.9811-2-quic_anusha@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512090134.9811-2-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 11:01, Anusha Rao wrote:
> Enable the clocks required for crypto operation.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq9574.c               | 72 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,ipq9574-gcc.h |  4 ++
>  include/dt-bindings/reset/qcom,ipq9574-gcc.h |  2 +-

Bindings are always separate patches.

Best regards,
Krzysztof

