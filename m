Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F46A3C11
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjB0INQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjB0INO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:13:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D66CA34
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:13:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bv17so5219833wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0s3QlMH99J9txGN6IDDba9E7YuAuLZPQ1XK9+3yrepI=;
        b=Lwri2+SAGcjuAQG337kAuh7T/1Xy5lNNdYXVC9+tcUxGnIExP8iqrdONHBEdIBeupu
         Ci3Peomsl8WtHpiVOVOcN9pnFZ9yyD0zrsFq/GtKClsvzzar/2rs8EJxveaak+NQ+87w
         u4jg7L8wZUqdkZ9oNQrXu3UT6YoOzBM+dB9utsj51cegG65wUMrVVwIziJA7MaIsIrbm
         mX163nFAvv9J3EA0yXsyeobn7XW1ZRJp2FXgeH6biX0nFjM2NB2H4kFPKzFVfHMCbshC
         /y6bAF73ZXuNkXVBMwQlNbdVXecKT7olWMHBFDL4oZN3zxus0KRVQ/AWTWZOFiKoZ1lk
         C3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s3QlMH99J9txGN6IDDba9E7YuAuLZPQ1XK9+3yrepI=;
        b=oKv9xWTNidHumqilxNC4kfnrOE0NtiqPhv+xXVO+/93Oind/G8wnDVsqQXGhUDLEWb
         jQizWjc5bqYXHxuN/zBwfSgD4hHQ8hUtehaSUKp9kXQOxg/sbtIUtfk0/o6MXn8BSjMh
         UXYUh9Zq2eyMemwjCIbhXncRcTz2fIoUc+3IN6/P9IyDSeG3v6Zl+m9QrKP7BXTPsoUr
         ATbxvXNW6yTFovlsqHo9GCYvUUn3jT05n7laGG5igYrKm2J+iTYRYDGXJag2tqSngEWx
         yq42Ofli5FXdLA4P9Fq2bF9s+eHxKELrCLvygG4HDV9AN+gcLJBHBlJ4C+m3BkCHn7EW
         G6Zw==
X-Gm-Message-State: AO0yUKXQBQ1wECD7qySuRQuylcTilwmsxsm08fa5clQhd5ljI7D3r9zO
        QXeFrHRQ/kOwEWj88CX7JQsJUA==
X-Google-Smtp-Source: AK7set8zBqwByG8fmTxhMr+Ahl7JF9nL1tWM7uLVLQ+mkwTwXNLSS9DlEmBnIYzHkI02+nuuh9q1Pg==
X-Received: by 2002:adf:f484:0:b0:2c7:fc61:12d4 with SMTP id l4-20020adff484000000b002c7fc6112d4mr7595144wro.47.1677485590923;
        Mon, 27 Feb 2023 00:13:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6395106wrv.10.2023.02.27.00.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:13:10 -0800 (PST)
Message-ID: <75b4da68-232c-7376-7806-8d475876dc59@linaro.org>
Date:   Mon, 27 Feb 2023 09:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/6] dt-bindings: arm-smmu: Use qcom,smmu compatible
 for MMU500 adreno SMMUs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 12:16, Konrad Dybcio wrote:
> qcom,smmu-500 was introduced to prevent people from adding new
> compatibles for what seems to roughly be the same hardware. Use it for
> qcom,adreno-smmu-compatible targets as well.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Add this patch, omitted previously (big oops)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

