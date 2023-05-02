Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231D26F3B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjEBARJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjEBARH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:17:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3AA3A86
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 17:17:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4efefbd2c5eso3812170e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 17:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682986624; x=1685578624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU7dF3apKAzTMOXKncqRNK1GXeNANPoUeBncqcRUVHo=;
        b=mdKURyH6HQo/pfn4Q1Te3gyJ+qAlcaiNaOsEa36+9zRBjFMhLmGKkiqNxDKHC8Q32a
         bbYMPylauv1XesZNtJ5UG2PSsXZ8w8Of3iAF1w15rRqtk3bOtKOhYG0vXKrB07CzqOYy
         eBCHRq1Cy5eyLvQ70yuFqGzPM2lEmWt8dH+BNy3msb+WTx1I91IlOMMoFgEMubViK1dz
         zyjWtVTNZ71vrYmTG0xDrvP55A1X1CxMhyMpOXFQLpAH79MGC6emZhvomwJorVJZ5Rmo
         qbpgjbfVGkB8GT+4b1lPGVIGaagb4NsSGfrMNLEjWxEiu3DlP8Nxf6bkV6g+BRyjeU74
         dSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682986624; x=1685578624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OU7dF3apKAzTMOXKncqRNK1GXeNANPoUeBncqcRUVHo=;
        b=HfJ1UiGsrh8+Fzmijqx5X7Rz50FLoGDg7ewm6IFRQAkjpqcbx5cjm4wDC9GoDMfZ2D
         7jQ8AVPHswAqtat/ZJApwkGqaQxz73jF1f4+H5eEEWWHFrU7qG7GH+8paPrlhRGHMx3o
         5gxeE/XAXH66cj5ffYA264C3IFqe5uLKgjXUx4VuOTG8V5qv4HuJ1oIAiAvtm76AgwTq
         gTKGosYzK6cMXWJWh3DeeRy+IXiBd4COLr/EzLWdQHjeAcsXLYcopvhVQuFwmKv1F6ZC
         JYYebPNqpicllE7mBAK8PUw2V6/3sYTP4GnPwS1Gub6di0yXvevFiXP8uSy8vz8WOE+G
         EBFg==
X-Gm-Message-State: AC+VfDwHC13Yugga6DIJgJ9sT69KAhJC6Pq4vMgmxwppCmeAfguhpF2z
        GZsQ5k4PkzfQNEIQtrK7wL4lsA==
X-Google-Smtp-Source: ACHHUZ6GqVdzKs8IrpnXt7KY+uXWsHZyayfyeH6RXXJ/lfzcq5t7i3oRRhU0NqvTvtGhdrGit4u8NA==
X-Received: by 2002:ac2:4438:0:b0:4b3:d6e1:26bb with SMTP id w24-20020ac24438000000b004b3d6e126bbmr4123250lfl.29.1682986624134;
        Mon, 01 May 2023 17:17:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u21-20020ac248b5000000b004eed7649d33sm4973400lfg.35.2023.05.01.17.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 17:17:03 -0700 (PDT)
Message-ID: <5b36ac86-4aaa-7a6f-a132-95fa62320acb@linaro.org>
Date:   Tue, 2 May 2023 03:17:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 3/4] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
 <20230501192432.1220727-4-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230501192432.1220727-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 22:24, Bhupesh Sharma wrote:
> Add USB superspeed qmp phy node to dtsi.
> 
> Make sure that the various board dts files (which include sm4250.dtsi file)
> continue to work as intended.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
>   arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++++++++--
>   .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
>   3 files changed, 33 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

