Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D19734587
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFRIjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFRIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:39:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA312F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 01:39:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-987accb4349so189559866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687077545; x=1689669545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UyA3hve3xqw+sdsT5ZWCGTlCEA9xRySCIjO+MMCiLQ=;
        b=gd6GWLW5N1St5Q4nYQfmRG9DQhWzeHHQldClzZTYzcuA4Cde5T0PZfHFRmhB+id7yQ
         9RL79p/I5SxHRGJqElqmEr0NuYPweTTopI7bU0ECo2Gn14e5lYJzUqdMrXK4BNarUwea
         3Mh3HlTogsKEIXhwIJJkEXiOzJP0WXCJc8uzyYZMCNtL47COxdHD1nbNTmvVfs7bxgQt
         +69vCKkeCTS7/2yaBn3QX5cYVfXPexWlTOilqc8Cmf8Tt3y9HqM7g9OYRLOwLBMBanAw
         OG7OFQEGwKos1m8HCp55hXkSu1PFzsSl2VeKL+qylKMsH48lcCRLiRZNCP5A0vY/zKRN
         AV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687077545; x=1689669545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UyA3hve3xqw+sdsT5ZWCGTlCEA9xRySCIjO+MMCiLQ=;
        b=eg5jOxalN7tUKJhX7r34NzM/ibE3/Mra3XRU0PXFxq6krhRADKN9Ivyi6ktAmBRPuj
         zm+/iAYZOTJiyRJ1qhu25/KnE0LFmrlo2sLjoOvxVlH2w4bhyjJ5uUIFgWy6MN/GDhcC
         SNddmKj0U47GL0XOUuxnzESovhbMAckfU08VutMN3USePNzHryC5hura+NC2CDXE9FhD
         IMzQtLhOgAm0KFXf70wWw7JNxEKSdrfx5NTimwbksm018Wq5T2tTT/RE4Zm8zGhYmz+G
         U4B/mnvLwxmgsL8yqcLwwvsy5eB7nqlQ7T2LcFPdAFqIEShSnwRTiXpMh14DMK1nTYRo
         kpVQ==
X-Gm-Message-State: AC+VfDwVbCIaeb7sAc4uZ258MbadVi1LLGRdN7CsFjVIDlNLV2aOISbN
        37pficAvOvQNZXjogQE61Gd+vQ==
X-Google-Smtp-Source: ACHHUZ6IBsZP/mUu94tjlGbEtnaYcAMXUk02/bHR4PWeAdpbSzxJIHffQyZbJ/q1chW8yOrQbwGChQ==
X-Received: by 2002:a17:907:7dab:b0:94e:8559:b5c5 with SMTP id oz43-20020a1709077dab00b0094e8559b5c5mr6878580ejc.64.1687077545201;
        Sun, 18 Jun 2023 01:39:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906354e00b009888b71c368sm293900eja.152.2023.06.18.01.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 01:39:04 -0700 (PDT)
Message-ID: <27b85110-9eb8-84dc-17a9-908e312e2e22@linaro.org>
Date:   Sun, 18 Jun 2023 10:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 02/11] dt-bindings: dma: Increase iommu maxItems for
 BAM DMA
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-3-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230526192210.3146896-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 21:22, Bhupesh Sharma wrote:
> Since SM8450 BAM DMA engine supports five iommu entries,
> increase the maxItems in the iommu property section, without
> which 'dtbs_check' reports the following error:
> 
>   arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb:
>     dma-controller@1dc4000: iommus: is too long

Also, please drop error message, because it is not true. The files do
not have such device node, so you cannot have such warning.

Please rewrite the commit msg to explain that certain devices, e.g.
sm8250, use more iommus.

Best regards,
Krzysztof

