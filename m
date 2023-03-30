Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3A6CFDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjC3IMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC3IMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:12:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5135AD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k37so23522465lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680163897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhpYSRIF9rWVBtvn3W6H9oSHXNiAfE90ltmVrnHj9jQ=;
        b=l9l0autS3VV9jqQdX17cLUVF2VPK2wCXRRz1WruSJCdv+bAHlYFfXmaVuSzkTQr7zu
         lTi9vMsr4VAgeZWro9nrSC6HFJBUURbN1DkjBGYaYhi3BBDI8hco+HKN3cS6X+FdF2NP
         XcKvsT3SsOTSt77efT7P47+bVrAoe6YGsRotVP2WTP3WlnQJZpFiqpTq8CYwn8iXlQBv
         DXJWqnkoGdhaniq6BhDbj+f26BmL4/8rk8gv36v7MHU8fDzzyWX/bzXIzmnw//MQEeM3
         5guIqugbKBUOUQQ4BQ7uw43x5kFsUK2r6LlieUXrHO7UbH7/Lq+H7psiU+/vBLJOEu5R
         Cvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhpYSRIF9rWVBtvn3W6H9oSHXNiAfE90ltmVrnHj9jQ=;
        b=NyWnP0DR3O8zKmC4dFs1BA8IT99nLHZOO9rci97qT8+HoYjfsY9aNVSU/ESeu+t2nA
         ZsbiM48CNE2WgkDQNJnwXj+A1cBDUKcTVfIhbtMvxcFBM6zklIpIebY8QCOrz7VKphYl
         pLOGmiNIqVzxeVIFoyAHFSziRKIGE28TARYSgWOdn9vWNiD+j8fJhyny7aK8yXPXf4QP
         9K4APxqh73fF10wN20OKsxPBJWIZKCh1HCGxbd/2UMUmZhL5N9VNTg/knW+OMwaf6fql
         dl6OYJzE6hXwCJNUzFWbCWDzvNDz3Go2mPU13M9ttlWdYNm7Rbd3IY2sXmaEhY/tx2Ql
         tFrg==
X-Gm-Message-State: AAQBX9cUdNKkHDzrU0ZvGDknECIeevgW1uffzIOneQ+8skBuR6pJavMJ
        A6eo/ceTpJJq0oTNCtPCPoxhOQ==
X-Google-Smtp-Source: AKy350ajTcUwsMnrR1qj+B0GTXwqvGs3ePSceLCFA5i6vYVaG559zCsE9hISwkOMEb9LjIELKS8ncA==
X-Received: by 2002:a19:654e:0:b0:4db:5120:367 with SMTP id c14-20020a19654e000000b004db51200367mr1479611lfj.31.1680163897388;
        Thu, 30 Mar 2023 01:11:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i26-20020ac2523a000000b004b55ddeb7e3sm5788960lfl.309.2023.03.30.01.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:11:37 -0700 (PDT)
Message-ID: <33a0f45a-a6cd-aea9-e261-99d1ca81a9cc@linaro.org>
Date:   Thu, 30 Mar 2023 10:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/9] dt-bindings: dma: Increase iommu maxItems for BAM
 DMA
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
 <20230328092815.292665-3-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328092815.292665-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 11:28, Bhupesh Sharma wrote:
> Since SM8450 BAM DMA engine supports five iommu entries,
> increase the maxItems in the iommu property section, without
> which 'dtbs_check' reports the following error:
> 
>   arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb:
>     dma-controller@1dc4000: iommus: is too long
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

