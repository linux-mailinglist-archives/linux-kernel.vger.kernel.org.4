Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8DA6D913B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjDFIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjDFIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:10:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DD8E68
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:10:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so147387729edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680768613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5spE+TO8kzFj6ll3TOgzdsKC4/Ei7C5JM7vz+W4Xh/s=;
        b=hz0lyPmKOXvbz5t+WsVLjNqis1JK48pnGFKDIvbRm+UGRLharEnMhG/+MEl0ITLkN+
         nMg747sXm51hIc1MCJsmw/UutqbqFrh22uBJCZscPd+Zg+ImdtoMcBJd6S0/i5o+KDBr
         EnMfMv7QCOJHMzDviYU2LL67OgwaORKkBT8zYQEkNpArSm4CUm8QY5eOY22guFnPp0a0
         x1/+MCdEzgY3k8OdhlArb3u4oTE95bsrU3S7tMhD0/KnMJILGy0KGiV6M5nASE30T8UW
         /e5rkEzf6g4GLQdo+uu7YQaASTAd5GbyufAV2Yhc3qJg5ZuHswzW91OhzfvuNzEbdHGr
         e9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5spE+TO8kzFj6ll3TOgzdsKC4/Ei7C5JM7vz+W4Xh/s=;
        b=MsV2dhjA6XHUKXF67fosEUqHmmzOUkXrgz7edFsxOkpzyTn5Keh8LUK9ULc3mZhKrX
         38HQRV/XtxIvn4PJxtXtl98qvVDFVitOS+urBvfO3wCtAQ0PpGlvT1QULkX0DAxFmUSK
         8y3CPTfyhamLtmXldBUp1S1uA3Qiaoh7JRZJM7dbINhqM1ZvALHFfvKlnrJVIIvXVYFJ
         Pk+dwY26+VzCIXDjySTfLXyXwbyajJgUzLaZYoUK3jrHcaUAfqIrPtjAxlRMnomI8AEl
         DLeBoSIq9tpg4Lkcs2cRwQ9r/LbEVGZb6lRxXaYoN9kvMmFjnr/Z89bEo79Ffpun8boS
         km4Q==
X-Gm-Message-State: AAQBX9dyygmnVVqosXwyCX72fLB5NnrTLv5mDYSyDvTq8on5aMaPMkkZ
        YFLVOlG2w62w9BtrytCgMKdTBw==
X-Google-Smtp-Source: AKy350YLZNQIcWIGT3+gVG7/gzwOQQVvDPf7V80JTtlDOvzqFIJ3bIHUh5JpErkXaGQQsPhjJlU50A==
X-Received: by 2002:a17:906:5e53:b0:946:bd15:b13f with SMTP id b19-20020a1709065e5300b00946bd15b13fmr4972980eju.44.1680768613340;
        Thu, 06 Apr 2023 01:10:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906319800b008e9c79ff14csm476308ejy.96.2023.04.06.01.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:10:12 -0700 (PDT)
Message-ID: <cc92f734-0c8d-2870-6cda-d768579c29b8@linaro.org>
Date:   Thu, 6 Apr 2023 10:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: iommu: Convert QCOM IOMMU to YAML
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-topic-qciommu-v1-1-03f17717a447@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-topic-qciommu-v1-1-03f17717a447@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 03:31, Konrad Dybcio wrote:
> Convert the Qualcomm IOMMU bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

