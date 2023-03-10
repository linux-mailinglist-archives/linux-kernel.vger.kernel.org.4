Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAE6B4639
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjCJOlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjCJOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:41:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA2121B76
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:41:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u9so21396473edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678459270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqYv2XkGPgl0a2AO9qEe8f7e2MICAOyButbuAgV0Ul8=;
        b=gOo3/PUn35doFmSBbLfYFi7qJ/u9ordNAWkv3ONn4e5XvC09EsV2vmVphLF2LA/j3t
         lUNi8EtBqpOZ2KhgPPd4LkiXRT4eMQu10wxLTjnHO5eQwUlbbTs4I179UNEMOOhRvMam
         Fh8tUiCT/tbyyfmmbGEIEZZthHXWJKArdVddpiLo60FY2qt4qCbOTb8ekVYg/Jtewc/n
         Ym+Cg3OszElxXmj2/4BM98xn8CnVv0wv5UriHaAJj9+JroJVBf4ffbOPRu94o/bH1iW3
         oeK0ecDTBzIvC8p2QZ60mzEGbx+ygo3UrqvgHnbauOwcKAzQxNu9e0PovuX3DJlcJqpA
         G+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqYv2XkGPgl0a2AO9qEe8f7e2MICAOyButbuAgV0Ul8=;
        b=6S89zIlSUUxzBbfZ99VocTQYSxYpTlq9VHVr8Ozs3TsCmpilk8kMFL0H1Ps6yIk/yi
         rAQuJmYLMVBXyTFybdfjJNC6uyveISv2BnlMWMS3jZjQwhEapnaGfjX472O4JmmVN2+i
         G3d7ifvZ59oX80wCPtMD92vErTKFohm97gt0h8n2C0BUTuOGS3xtxKcshDqKJa+fy5N1
         Jwretgvdq47fVekhE7MPA23dMv3uphoNeFz6hKp5lRTXMU1AtBT5v5UP6Hdy5gpMNJrk
         yquQnuwKJmZ5Qv5zEBWFFhO0pLjvOGy92qtq/JU2I7PJgghSBP10hDc1Gu12CnuhTsCw
         Ax7Q==
X-Gm-Message-State: AO0yUKWtqSnJROPezkrgSsm2CoRj/knfs+xhjlHJ+/hqUiQiSt0y/xxa
        t+hC2AvsFpCs+Uus4h6LKGyang==
X-Google-Smtp-Source: AK7set9xruyIODFDOTiuiX6ARk5Y8VnFAMTlrJYf5zYV864mCmu/WzgbxSoeGxCnpo1IeVQ4pxi9lA==
X-Received: by 2002:a17:906:b04e:b0:89e:8c3d:bb87 with SMTP id bj14-20020a170906b04e00b0089e8c3dbb87mr28174111ejb.71.1678459270062;
        Fri, 10 Mar 2023 06:41:10 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:45c4:46be:ec71:4a51? ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id s9-20020a1709064d8900b008dd76b67ae6sm1035527eju.175.2023.03.10.06.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:41:09 -0800 (PST)
Message-ID: <611fe922-1937-d37d-a2ce-cc0a13aed9e0@linaro.org>
Date:   Fri, 10 Mar 2023 15:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/6] soc: samsung: pm_domains: Add Exynos850 support
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20230308230935eucas1p1e919f4d4b020e3386ce0eac8b4c8d299@eucas1p1.samsung.com>
 <20230308230931.27261-1-semen.protsenko@linaro.org>
 <d1175c3e-301d-1cbc-607c-e94051780806@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d1175c3e-301d-1cbc-607c-e94051780806@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 11:12, Marek Szyprowski wrote:
> Hi Sam,
> 
> On 09.03.2023 00:09, Sam Protsenko wrote:
>> Power Domains in Exynos850 are not really different from other Exynos
>> platforms. Enabling Exynos850 support in the PD driver is really just a
>> matter of adding:
>>
>>      static const struct exynos_pm_domain_config exynos850_cfg = {
>>          .local_pwr_cfg = 0x1,
>>      };
>>
>> to the driver. But in the face of recent developments, e.g. this patch:
>>
>>      arm64: dts: exynos: move MIPI phy to PMU node in Exynos5433
>>
>> it looked logical to rework the PD driver a bit to support its nesting
>> under the PMU node, while adding Exynos850 support to it. Initially I
>> only wanted to add syscon regmap support via some dedicated property,
>> but pulling PD nodes under the PMU syscon looks like more correct way.
> 
> Frankly speaking if you are changing this, you can go even further. 
> Simply make PMU node a PM domain provider and specify the power domain 
> as a phandle parameter. This is how it should have been done from the 
> beginning, but for some unknown reasons wasn't. There is really no need 
> to have a separate node for each power domain. This will also move 
> implementation details to the PMU / power domain drivers and it will 
> make it much easier to extend/modify it in the future. IMHO same applies 
> for PHY nodes.

I agree. The "samsung,pd-index" property is not a correct approach.
Either you use address space or not. If not, then this should be part of
power domain provider, which is also matching most of other SoC
architectures.


Best regards,
Krzysztof

