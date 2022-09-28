Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887395EDB64
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiI1LJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiI1LIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:08:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F45A144
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:06:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 10so19827793lfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MjGw3ED/TETSi7nUoWUn1OatGY683JgODwtrOsTO7oE=;
        b=kiMV++3umq8EfNZvf0P8iZ7HoVCBZdQcN6/qODNwLJ+b2LmGSJcL+yz/g+VRr8DoHt
         M2gjV8AvtogvuYYqe6w59HouiKnIzQMf4oZTC0vz7dqbeoU06pWqDa4yJbW53oWkPgl9
         nfj4nh7XKVTzQXwoTKqTq68SxMizAGk2os8jXnhJgpQQECfAYDmXdjJdkviUXDk13js7
         yWiJFpq6+Z3ZI49f3GxSN0xYWK9Uc+8xxyQ5OIjzuP8BlMocuCJGibbf58oEBSFBRgCu
         ZagYoDqx8Ux+rtCrkD3ca9X4Ku1CudQ2CrApqAit9TNCYnkmi+5NzXgOFvAwh3JrpEBn
         ChYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MjGw3ED/TETSi7nUoWUn1OatGY683JgODwtrOsTO7oE=;
        b=DOkLx5P+3OC6AKOrtqHc9/U7+VYf5md8DCcNQqv0yuOo/tL/glLYmdOeKtpEjc8DD7
         wuApBwX/rpTEES6UYio1UEUQDaw+2DaaRfU8nz9QgT1XyV/P6+CaR3KU9CYNXCN6IbHX
         +E48T+YxQu6816vtl7oYhmO7g7B/0a7u+gVT00WBk/hMOUCwYRhXki2cFZIcLwPzhwQd
         Fw0i/LzfuBi9PhIx60HMVJYtuDdcNZio4Lrhbuxv3zh5uNojlbEtlVMxvf1mebbjvrV7
         DBtL8X5BnKXJwSBSMqGMRJl0Gf62SvFQF0WbAuUOkvNf1fR5Wiot5ldgYzUdqNK1Fbk6
         DHZQ==
X-Gm-Message-State: ACrzQf1UKP2VopIFyFhYOTe4i5k9PMjwjodspvUsQVu0s7H1XbxR4gQV
        23C7nALk9myIDKcKxXhii8Y77w==
X-Google-Smtp-Source: AMsMyM51CVLNFGE9FoGftyRc73rmycB450sbiyZ+NLDJ2mmk7hNmJeDHw5Q1c5JJoS0Pk9nC1BJAhg==
X-Received: by 2002:a05:6512:402:b0:49e:e07:5e7e with SMTP id u2-20020a056512040200b0049e0e075e7emr13444379lfk.530.1664363209933;
        Wed, 28 Sep 2022 04:06:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l30-20020a2e571e000000b0026ac7cd51afsm404614ljb.57.2022.09.28.04.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:06:49 -0700 (PDT)
Message-ID: <f51c63eb-150d-b38e-de9f-afde461e5059@linaro.org>
Date:   Wed, 28 Sep 2022 13:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: arm64: dts: qcom: msm8916-samsung-j5: Use common init device tree
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220928110049.96047-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928110049.96047-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 13:01, Lin, Meng-Bo wrote:
> The smartphones below are using the MSM8916 SoC,
> which are released in 2015-2016:
> 
> Samsung Galaxy J5 2015 (SM-J500*)
> Samsung Galaxy J5 2016 (SM-J510*)
> Samsung Galaxy J3 2016
> - SM-J3109/SM-J320Y/SM-J320YZ
> - SM-J320N0/SM-J320ZN
> - SM-J320P/SM-J320R4/SM-J320V/SM-S320VL
> 
> Add a common device tree for with initial support for:
> 
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART (on USB connector via the SM5703 MUIC)
> - WCNSS (WiFi/BT)
> - Regulators
> 
> The three devices (some varints of J3, all other variants of J5 released
> in 2015 and J5X released in 2016) are very similar, with some differences
> in display and GPIO pins. The common parts are shared in
> msm8916-samsung-j5-common.dtsi to reduce duplication.
> 
This is not a correct patch. Use `git format-patch` to create proper
patches - with subject, diff etc.

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst

Best regards,
Krzysztof

