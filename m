Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB2625A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiKKMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiKKMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:10:26 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F5BF79
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:10:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u11so4315662ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unHednunizHpJ9XYvBpXmDyswFth3w2fStIquZQtGM4=;
        b=fb+8Ulj+zRyO2Cvtl9I917QMAzXK32UPWTI5QSYGEpij5ABswFP7924qVwk32FEIYF
         0/e+X5RZG5epyZNjbV9MT2Gp57yhg76jua/2c47Sq5+4NH7E9KGGWDHILvKXb4ex9P2B
         dkz9GN2D07iOZXz2VDrE8ntzXDDx6gMwNZlBY3cE4Z3aYH4leKe12MAUbUA8CQylfp8X
         fEnUb0Cem51PcMFOv6TskUu+ItjXNacrxFedqM2YbqXaL7/vc5VH9qYQ9co1aQI29gZy
         v4Dsly1HCRoZVqqpbjp7CkRDtc37FplstdOgv/SPSKQCQYYNIR5zI9WA8r3fwBommQyj
         rN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unHednunizHpJ9XYvBpXmDyswFth3w2fStIquZQtGM4=;
        b=SDA9orpO+mazpdy9O18NSHSOkUuUDr+QBACfjyCxTS4Mret02+jwBiwdAnvxV96v4C
         HaRKcPnIBuPGmd9C/x27DXF60bjIRQkeLvm8zMXsrPfPCp7nzhygT+x91OV85E+pHDYJ
         HCHUtx/oM2drMUWe0QVzOBkLodEkU4pKWVOMmxzhlX+eYtIuTamY2hg12XHYv+y4Xx4x
         zn6WDmIj3lUzDYT9d+ZkixPIyWQZMnI/8+zdjJu+x1lpgG08AM5oVGiUyu8QRzd4q5fw
         TAZfs1xqht/OO/A0ShSufuzrd9dm8/0K5Og42e6UcB3m29Qoo8ovwrgisy6yA/GpXBBN
         PKMg==
X-Gm-Message-State: ANoB5pnE3Mrqsn1+qkNdaBFfjGStV98ram/taYjQ3+BslzP0uU2aX///
        GN2rvSWBwf4aqd2xUBfYC4LU8A==
X-Google-Smtp-Source: AA0mqf59BDk8ngoeEGvwxhB9aPi4roFQAKaW4lD9URgYoXD01XXj0+ZbYjZzySAkxgKwcFSTWvjzlw==
X-Received: by 2002:a2e:b602:0:b0:277:8df:88a7 with SMTP id r2-20020a2eb602000000b0027708df88a7mr599088ljn.139.1668168623320;
        Fri, 11 Nov 2022 04:10:23 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512315100b004aa95889063sm301404lfi.43.2022.11.11.04.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 04:10:22 -0800 (PST)
Message-ID: <78602d4c-913a-04b3-dbca-40f672c78a53@linaro.org>
Date:   Fri, 11 Nov 2022 13:10:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/10] ASoC: dt-bindings: Rework Qualcomm APR/GPR Sound
 nodes for SM8450
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 12:35, Krzysztof Kozlowski wrote:
> Adding sound support for Qualcomm SM8450 SoC (and later for SC8280XP) brought
> some changes to APR/GPR services bindings.  These bindings are part of
> qcom,apr.yaml:
> 
>   apr-or-gpr-device-node <- qcom,apr.yaml
>     apr-gpr-service@[0-9] <- qcom,apr.yaml
>       service-specific-components <- /schemas/sound/qcom,q6*.yaml
> 
> The schema for services (apr-gpr-service@[0-9]) already grows considerably and
> is still quite not specific.  It allows several incorrect combinations, like
> adding a clock-controller to a APM device.  Restricting it would complicate the
> schema even more.  Bringing new support for sound on Qualcomm SM8450 and
> SC8280XP SoC would grow it as well.
> 
> Refactor the bindings before extending them for Qualcomm SM8450 SoC.
> 

I forgot to mention that DTS in progress is available here:
https://github.com/krzk/linux/blob/wip/sm8450/arch/arm64/boot/dts/qcom/sm8450-hdk.dts#L459
https://github.com/krzk/linux/blob/wip/sm8450/arch/arm64/boot/dts/qcom/sm8450.dtsi#L2345

Best regards,
Krzysztof

