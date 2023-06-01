Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668D171EFD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFAQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFAQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:56:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372F7E55
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:55:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-969f90d71d4so150081566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685638556; x=1688230556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9PhABrR6fbuT1S1oyIuPZW5VFgQbeU/P+IYi+AHHxM=;
        b=ffZXKYwLf5T1O2JvWMZdIWhRi7SWjAPrvhw6AL6FlT1bG2FLKbU8LX68ph7e3LO04U
         dU0rRDYbrveOU6ArfGhxfOLABRs2IHbfoby2DxZgAs86Y9xgm2Bz6MkxmTFh0uZotOlr
         CpBbV70cVmqyHYXRn5dfEu06K1RrnQc0B65w8dp4o3x3hVSHqwXMddY+I6OdXIITVbLh
         wagj+12DMz6Zvies9MQnbslGC4lzfDHT+hrH1o/RcDSO3+dpYJN1XPzXdQRATYrdVfpI
         TSximRQqSXxMHjLDol5p1/cvuNwXunbRaV7yApHcxtcA54c1/WoUiTSehetLPYX13zRc
         GHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638556; x=1688230556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9PhABrR6fbuT1S1oyIuPZW5VFgQbeU/P+IYi+AHHxM=;
        b=JUF6QR+JK5evGmB4YuLOsygmzF0/A5dvXGkIqzxZ135wMDZvl/T8yjaNYXaKvysJV1
         gRmzvVtIlYjA421qxaXhaPGmeOUF6oLtPV8P2+GWF9yF+LNCzY1wnvq9l6Gc/ujIY3F6
         dAgZTxC6Muiv3cnulDlsZawDXvLndACrGB0TC4L/rHgnk8w5BM/8VEpFGP2e0TPoHzD/
         0lbCQ4TG4rV+GPM6E7UEOmw4/LTh8fBxFJEp7JcQef8FE8sqtlOpUWu5LkSGTL2yasQE
         vb5j80TPdDiqnO+QThDfF5bRPRRknhGySkyqrk7b4y362Jv7yHB+hO9Vxaol27V3g5AJ
         zlLw==
X-Gm-Message-State: AC+VfDzj5G0VZGtjMCRqtC8XriQCZ7pjVpq6KsqN50IQKt8mGMDJcztO
        Ser2grUkWSJFBtKoSxm1gCTv7A==
X-Google-Smtp-Source: ACHHUZ6ygqoysrjPFxzcfm1Ac5L9I1KaJ4mwEF6HXcgsykWw+pw5MRf0NYhA4AB2O0EcNhhoiAnYUQ==
X-Received: by 2002:a17:907:86a4:b0:973:e4c2:2bcd with SMTP id qa36-20020a17090786a400b00973e4c22bcdmr8555945ejc.18.1685638556663;
        Thu, 01 Jun 2023 09:55:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00973fac6065esm6693089ejf.223.2023.06.01.09.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:55:56 -0700 (PDT)
Message-ID: <3589e3fc-2add-52d7-68bd-2b41a9cba4af@linaro.org>
Date:   Thu, 1 Jun 2023 18:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6375 GPU SMMU
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
 <20230531-topic-sm6375_gpusmmu-v1-1-860943894c71@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-topic-sm6375_gpusmmu-v1-1-860943894c71@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 17:04, Konrad Dybcio wrote:
> SM6375 has a "Qualcomm SMMU V2" implementation for its GPU SMMU. It
> does not however qualify for the qcom,adreno-smmu compatible, as it can
> not do split pagetables. It consumes a single clock and a single genpd.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

