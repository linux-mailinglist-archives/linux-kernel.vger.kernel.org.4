Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808D6DEC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDLHQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:16:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001A330EB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:16:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id xi5so26378531ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681283765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYluzBqeGlhNCgYN/vs2TBjqaPrfmZeDGPID9roW1cQ=;
        b=fvrcfx6ep1D++SFCxg6x5vVGSwG5/VmBcg5cv1f3WhstBDhlfZAbdCY4UC3VRAkNxJ
         CN3t5AyuRSs2dr30TFruEmrY15oGiCdBhG0Oy634+piytmCO4gZWoho20Hlbk3ZhDUyK
         VwkoPhAVjSUrJN+ho/0KxX0Uvp35SLwTiLV44b9M560wqWxFkIXTMjYEdZjPahEmL067
         kYkbmAnbPbVC/3R7yWmCrctcqF89n+SFFVULneVvySsJQZ+biNXatJoFapZ+ElrbmN+8
         +XOAV0NadAa1Sy8Au8yv74/KoQBlaFGvtIwQ0lxLxdpyIblb2e2UbgoHYWwZAESEhffp
         +ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681283765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYluzBqeGlhNCgYN/vs2TBjqaPrfmZeDGPID9roW1cQ=;
        b=gKSQejeDP5Jg/ZQlPkuVEYnwfSIV9kIUCZqGzAh/odapb64s5FiWULij7kvKQPD+sB
         AFhM+aRVDkiHhmGmOKWizm+j4M/n2qdDXi8MHnRIxVznwJaTAVViT509FCR7BtiHB0Yn
         Yz9R1rb5bbLBPsoSuK8xBU3X7TBiAAKkxYB8liLTySLm8kQj2rZMdquWb3wr9MdOaIN3
         wRUp40vyjvjnhiFHPJiu5OfWhff57dB5wBhth3ZHMtSyobUmfrbqrpV1ur4RapA1/TOJ
         lMBLq/2TGHr2GdKqBPp3kiCeLKElxsU7FSuVqFNZl2YlLdK7QxbQ4Uz9PARuviKbExKE
         igVA==
X-Gm-Message-State: AAQBX9cZFCvxDpkW0sLTtE1oWgPn47Ih6LnIb+BuIwH+RRBT7wztMNyH
        WU82LOfSLB8EymMcvI++3utwjg==
X-Google-Smtp-Source: AKy350YvNgklkhK0fZIoRDJJP7VAp46SzPBgygdA633mj6ZPtpz6ZPya476IZVB8S7WnIn6JShG1LQ==
X-Received: by 2002:a17:906:768b:b0:94a:54ad:b36b with SMTP id o11-20020a170906768b00b0094a54adb36bmr1127452ejm.77.1681283765470;
        Wed, 12 Apr 2023 00:16:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id hs8-20020a1709073e8800b0094e1272bd12sm1630723ejc.159.2023.04.12.00.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:16:05 -0700 (PDT)
Message-ID: <4b630254-2de0-979b-8d44-6b7d1dcd3d28@linaro.org>
Date:   Wed, 12 Apr 2023 09:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 6/7] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230411125910.401075-1-brgl@bgdev.pl>
 <20230411125910.401075-7-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411125910.401075-7-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 14:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The GPU SMMU will require the clocks property to be set so put the
> relevant compatible into the adreno if-then block.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

