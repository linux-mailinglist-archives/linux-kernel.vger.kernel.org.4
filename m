Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F226567C999
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjAZLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbjAZLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:18:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21289013
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:18:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id z5so1410752wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqdjA3+9Qt11hSZoRLBAVvtnUOg90LKLkfkURZqojVc=;
        b=bmia+l1T8qeG6L9k0m4kQUz0Ep/IY4J7ax4evRMageigmFN69g9Y8uq3e/dgb8K0wV
         duq5xED/VvbXaHYnpNWf0MSqKk2LfLxGG9j1/UMPnxq1iE/BfU+YXnSif+kz3pPfceup
         hMpGeXfMv8dJqIAGLlAenz3CA60wWt+jwdn3let/kfBkuf0WlJGJzkHVM5ksbrN1FXR7
         QtNmytC7WiL87rQnzrRbSULMaXnv7kTS4/I+Y9V9XbMb0LKGeHjUN4XJ5tJe0hI8/BV2
         iQs66vjTfZ9oFjvwFNMGjrKmeR+lFoomrCDgJv4/VERUghK6YZmamv1KIdzhJ3l5ZAdB
         jUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqdjA3+9Qt11hSZoRLBAVvtnUOg90LKLkfkURZqojVc=;
        b=botFQXBuXuUI2oGRR+SvQXU1+dZS+2FWTviE8nz1swzXgJQQzX70WOOZF1trBp7Xu/
         BXyw27RQX3PMNDYjYIM7E/7Mwt1llRfT1LZ2FhOCTS5QunBH0HYw5sJjtxP7fZF5Z2KR
         ppLUroB2OFKmnC686YxwW3SL4Y/WSG4zYnYfTsASa5RVCsyCId2NJ+pyZ9EsHALxRdRc
         wLQF5C1RMqsJkwR/yY3ns6IMQZOUw2mJMu+b0MeEahYtue7geh8L56iHwfd9ZG3cjd/Z
         z1QxLENbN+XJPVSzXiFsBwLFtaLCCX2TExICKBs2pvB8Xo9AR1A26WWiPdUXVIBd60/j
         UuFA==
X-Gm-Message-State: AFqh2kpole9NlRafAptdAH+G+UC48IpPlSDmkGocJmfaNur1nU82s84W
        K2sWkkhhlcPg5q50a0aZSPfv6w==
X-Google-Smtp-Source: AMrXdXtXwwsVoDPpG4FBWmaSo/IllaxkAIiivnsODY1DCtiKwSb4Jyo7v20kIZn0Ymcluujwf0ocbQ==
X-Received: by 2002:a05:6000:16ce:b0:2bd:d9cc:920a with SMTP id h14-20020a05600016ce00b002bdd9cc920amr37171755wrf.45.1674731879174;
        Thu, 26 Jan 2023 03:17:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b002be53aa2260sm1106381wrs.117.2023.01.26.03.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 03:17:58 -0800 (PST)
Message-ID: <102e76fd-50bc-9403-b03f-f96a3d3869bd@linaro.org>
Date:   Thu, 26 Jan 2023 12:17:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230123193422.15972-1-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123193422.15972-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:34, Christian Marangi wrote:
> The qcom-cpufreq-nvmem driver supports 2 kind of devices:
> - pre-cpr that doesn't have power-domains and base everything on nvmem
>   cells and multiple named microvolt bindings
> - cpr-based that require power-domain in the cpu nodes and use various
>   source to decide the correct voltage and freq
> 
> When the schema was introduced, it was wrongly set to always require these
> binding but this is not the case for pre-cpr devices.
> 
> Make the power-domain optional and set them required only for qcs404
> based devices.
> 
> While at it also make more clear what the opp-table supports by adding
> ref to the opp-v2-kryo-cpu and opp-v2-qcom-level schema.
> 
> Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> 
> Changes v2:
> - Reword commit description
> - Fix condition order
> - Add allOf
> 
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 81 +++++++++++++------
>  1 file changed, 56 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> index 9c086eac6ca7..6f5e7904181f 100644
> --- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> @@ -17,6 +17,9 @@ description: |
>    on the CPU OPP in use. The CPUFreq driver sets the CPR power domain level
>    according to the required OPPs defined in the CPU OPP tables.
>  
> +  For old implementation efuses are parsed to select the correct opp table and
> +  voltage and CPR is not supported/used.
> +
>  select:
>    properties:
>      compatible:
> @@ -33,37 +36,65 @@ select:
>    required:
>      - compatible
>  
> -properties:
> -  cpus:
> -    type: object
> -
> -    patternProperties:
> -      '^cpu@[0-9a-f]+$':
> -        type: object
> -
> -        properties:
> -          power-domains:
> -            maxItems: 1
> -
> -          power-domain-names:
> -            items:
> -              - const: cpr
> -
> -        required:
> -          - power-domains
> -          - power-domain-names
> -
>  patternProperties:
>    '^opp-table(-[a-z0-9]+)?$':
> -    if:
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              const: operating-points-v2-kryo-cpu
> +        then:
> +          $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
> +
> +      - if:
> +          properties:
> +            compatible:
> +              const: operating-points-v2-qcom-level
> +        then:
> +          $ref: /schemas/opp/opp-v2-qcom-level.yaml#

This entire part looks independent, please split it into separate patch
with its own explanation. What I still miss here - why do you remove
"required-opps" from required properties. It's not clear to me at all.


Best regards,
Krzysztof

