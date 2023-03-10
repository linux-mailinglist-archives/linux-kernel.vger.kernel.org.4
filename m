Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA296B4656
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjCJOmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjCJOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:42:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060D411F62A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:41:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o12so21317093edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678459315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfLyxnaSR94pRL9TKD2BzlkjQb2HIbbl30lK64GdSjI=;
        b=RCbQUF5DKIQdWfTbUqY2lMMufmjE+7vG3iOjfwJyL1RSjQh33i5E/qnC73DCjNEGDw
         6VB6yQ0/8vFiYejGUeChkhs6ypP1oOmVu99uZVGcGaqtJ99ok+YJXvpJ+lBWwkksDPBi
         m/rVcIcE78rueSGRqQn2OSePh4OWNL1p2k7IhsYVNKbanSQBPHOCyjU8MBOA4f0+DRTI
         RAD/Ejkf3K6HrVdJuWoiGxBTuZbA63YVV/dB7slKo+SnvYqSoHJkNy7VJqnS20WiDksF
         WVySvpW1EUdhB51ooU+NmGFETvCz13w270wcLOkpit9zjo9oEs4VOoKJb3TL61uwO1xU
         VyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfLyxnaSR94pRL9TKD2BzlkjQb2HIbbl30lK64GdSjI=;
        b=7Y05A21YAfMhEFSh5Nfrk50HrGBMWY9Ht9T8wXNipd/ZixaOuATcRpf+ckVAr3blNS
         jgQJaw62XOZXV4MkvUFXe8Uf68wKCmWtdgVQ1HdPBBiNg9JH/4sKVaDmGOjmluWm1QY/
         RqpdSH7YsMGSBmuRoRHumoq0vRkdfHBVAVwX4Ktg4kiandUVGmmUV8RCfyYOqistwhj1
         omt8I9/5xfc2uqfDn0NYzt6k8qW0cbdv/+L/wduA780AT+KrcRMlBvc0p6GGCrUEf6Ht
         bwD+glKMdEc1VLTyFdEf9SBzPO6U+Qe9KmXtei05IQTUZoPP8tZcu1bctUDFTdYyY4Ce
         +g0A==
X-Gm-Message-State: AO0yUKXCWiiB1KlPelbnBiZPu6xDlwmGidZ0Xt+fks/nB7QfPihhBFPP
        w3EWD1/+EC7T11yTVdhxYFXFpg==
X-Google-Smtp-Source: AK7set8Wf3zmf0nbesz2jk8FT2yV747LT6wim8lRGLN6pWxH1L7cptJwa2HjW0pAV2OI/Ul/jQmWgQ==
X-Received: by 2002:a17:907:d308:b0:8b1:3a1c:3174 with SMTP id vg8-20020a170907d30800b008b13a1c3174mr26770048ejc.77.1678459315216;
        Fri, 10 Mar 2023 06:41:55 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:45c4:46be:ec71:4a51? ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id z11-20020a509e0b000000b004aee4e2a56esm127121ede.0.2023.03.10.06.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:41:54 -0800 (PST)
Message-ID: <f3d94e68-5f5b-c385-2190-5be10f25198b@linaro.org>
Date:   Fri, 10 Mar 2023 15:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] dt-bindings: power: pd-samsung: Allow pd nodes to be
 children of PMU
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308230931.27261-1-semen.protsenko@linaro.org>
 <20230308230931.27261-3-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308230931.27261-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 00:09, Sam Protsenko wrote:
> Introduce a new "samsung,pd-index" property to choose a specific power
> domain. This way it would be possible to avoid specifying any addresses
> in power domain nodes, relying solely on syscon regmap from the parent
> node (which should be a PMU system controller). Therefore the "reg"
> property is deprecated now, as it's more logical to describe power
> domains as children of PMU node, because PD registers reside in the PMU
> area.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../devicetree/bindings/power/pd-samsung.yaml         | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> index a353a705292c..73178b1a56ea 100644
> --- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
> +++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> @@ -25,6 +25,10 @@ properties:
>  
>    reg:
>      maxItems: 1
> +    deprecated: true
> +    description:
> +      Physical base address and length of Power Domains area (if not a child of
> +      PMU).
>  
>    clocks:
>      deprecated: true
> @@ -45,10 +49,15 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  samsung,pd-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Power domain index (if a child of PMU). Valid values are defined in::
> +        "include/dt-bindings/power/samsung,exynos850-power.h" - for Exynos850

DT nodes should not have any IDs, except what is in 'reg'. Thus please
go with Marek's proposal of merging power domains into PMU driver and
using proper xlate.

Best regards,
Krzysztof

