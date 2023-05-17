Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6553B70720A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjEQT0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEQT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:26:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8AA279
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:25:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso1481477e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684351538; x=1686943538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ITJQ6BvmC/gprSSWzEVWg1Y3AF8tHDZkXSoXVabNDY=;
        b=BwI8NeIlYwTsmyAaTI9Z+PZIeJ/DkTmPHMHvfQlzEDIMMz0f0PDW8otXD8sMIBtMlA
         E7b3XWB/mlN9eN8GVd7I8Mjqf08OT6D26sABVWTbGMI61jIl4xc1y2h9Hh/WPfwIDqG0
         Mp/pj9+m34Yl/O+fbQ3Rj4mTnaa8Flo5KgEUo28+hvJfRVmdsxjhaFOHGkotVPB8TeHg
         IPao9GVsUKlJf+IwgXoqF/38HsfyJYik8h4Nna5oAvmlrDgmWZqHePw4tz0dASe/Q2yo
         80SXHRwZHIyc0AXkCty33fhXy/xP2fTohzUbyRuEbh8jPTc865XSSY3hL3BlbQ6P1suK
         d46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351538; x=1686943538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ITJQ6BvmC/gprSSWzEVWg1Y3AF8tHDZkXSoXVabNDY=;
        b=bjmFZru9GxZxPohnJ5MsDI4jWXxzRC5eYBipCfUyIeo97Tt517JjLqGLXXdt6S9oGP
         3YtdxJDy9YLe5SW4sf6T5x8XjmTMmPwvYD+3UyyNPG4w3MiF1QOFFjyPdTOHo/24A6R1
         XPp38b0pZdFm+gPYPyluRYVDEYfxTqPb1zcGwg9eAS/SRDaJJC5CJX515eCFzzS5z0rl
         IkuiI35jn+ejo1JSFM1II3icekQl/NVKudxdcC9gtrbALT8RJ+iAcdDzF6xEJBFwt1XM
         KwIOCUoCPPipVo5yDYWQJ5sbg23SYTxSv4x0gCB230dUMG6r2RBJC2hfvN/9t5uetHu/
         F/Aw==
X-Gm-Message-State: AC+VfDzDB9BgraY7+IZ9hq65n+STmh2+9g5WTXUEJjXrwrDcph9D7jEm
        EL1TnSwwOzSBxDEMEWOy1v+zRg==
X-Google-Smtp-Source: ACHHUZ586XXdEcjn73/2Fn9e9ezVjMQlszHOct+frgJ//20J4gI30kuXVnRja4ZT5a+0l72TiASFlQ==
X-Received: by 2002:ac2:5a09:0:b0:4ef:f64b:65a9 with SMTP id q9-20020ac25a09000000b004eff64b65a9mr627508lfn.36.1684351538556;
        Wed, 17 May 2023 12:25:38 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2454b000000b004edc7f6ee44sm3456891lfm.234.2023.05.17.12.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:25:38 -0700 (PDT)
Message-ID: <c28494ec-1eb3-239e-46d8-fe84c2f28e77@linaro.org>
Date:   Wed, 17 May 2023 21:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] of: reserved_mem: Provide more control about
 allocation behavior
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 12:12, Stephan Gerhold wrote:
> Provide more control about the allocation behavior for dynamically 
> allocated reserved memory by adding a "alloc-bottom-up" and 
> "alloc-top-down" option and by making the allocation order 
> deterministic.
> 
> The motivation for this patch series are the many different reserved 
> firmware regions on Qualcomm platforms. Currently it is often necessary 
> to duplicate them into each board DT, because minor differences for 
> some of the firmware regions (e.g. the firmware size) requires shifting
> the base address of all following firmware regions as well.
> 
> I propose describing the actual requirements (size, alignment, 
> alloc-ranges) instead and allocating the reserved regions at runtime. 
> This allows defining only the actual device-specific part in the board 
> DT and having everything else shared in the SoC.dtsi.
> 
> The series starts with two minor additions to the of_reserved_mem code. 
> The last two patches are examples that are meant to show the motivation
> more clearly for the MSM8916 SoC. PATCH 4/5 shows the current (static) 
> approach, then PATCH 5/5 switches to the dynamic allocation based on
> the first 3 patches.
> 
> If the first 3 patches are accepted I would send the full MSM8916 DT
> changes in a separate series.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Sounds great!

Konrad
> Stephan Gerhold (5):
>       dt-bindings: reserved-memory: Add alloc-{bottom-up,top-down}
>       of: reserved_mem: Implement alloc-{bottom-up,top-down}
>       of: reserved_mem: Use stable allocation order
>       [RFC] arm64: dts: qcom: msm8916: Enable modem on two phones
>       [RFC] arm64: dts: qcom: msm8916: Reserve firmware memory dynamically
> 
>  .../bindings/reserved-memory/reserved-memory.yaml  | 39 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 13 +++++++
>  .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 31 ++++++++++++++--
>  .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 21 +++++++++++
>  arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 29 ++++++++-------
>  arch/arm64/boot/dts/qcom/msm8916.dtsi              | 42 ++++++++++++++++------
>  drivers/of/of_reserved_mem.c                       | 14 +++++++-
>  7 files changed, 163 insertions(+), 26 deletions(-)
> ---
> base-commit: 715abedee4cd660ad390659aefa7482f05275bbd
> change-id: 20230510-dt-resv-bottom-up-68d71ff6628f
> 
> Best regards,
