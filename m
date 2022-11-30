Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E763D4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiK3Llk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiK3Lle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:41:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287D3E0B2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:41:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so26443223lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6U4jWl0YX+0wZ2tHeX0Zdfl9CbnGOHdgFH3EJM7rvE=;
        b=VlImjinigFrpzpISnF2fFZhGjZfORwYmBSPGrKG8Iyq/GYCNHiT2/pDsj0vSKJSp6V
         yaFqXu3OfHPcv+gZw/obLuDGfRKhPBBPLs+XgaXaGhnmZassT2SrD/r8eaf0ulEYDyFA
         i04RjqnIiC69WjEjBxFITm9BFRpzERhzv8LTST+S5KAoOP2hPnqV6SBhNUySDKykgeUQ
         KywrvWOqeCm2oAME74l+9r0HFgB1e1WH2k9k4L2d3iT/uEO9mfbxbj9MV+f2C4xs+i/m
         MLv4qw8tNCxSJ/8YQXmwnmiN8luAmHVQZkvoWcCOVINe6BOL1Ti5p1JVXLQw0j6szXKz
         K/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6U4jWl0YX+0wZ2tHeX0Zdfl9CbnGOHdgFH3EJM7rvE=;
        b=tpxOEeGhgGrnFIQTt81bC/vWiBi0DV4xjlIT4qh6SSqHvfbyvK4dwwWxC2RzcQSHol
         io/pf5P/woMojXSF69ksloLTuphcG7roFaCf+FHmvyxjI4oJF2VhOa80N1McyCA8z10A
         e2hzDtvt04qbLHfXR1SLxpDvLT2YX3cdcOc7Np+MTpIKlDCeqkag0q11lsOA0Hrux/DJ
         xHZ5fWA87h1+pbhJlkw01SOHnA2PcEKPSe9Vr/2ngFhyIylVhIKQhHCwlILSUv7bGEpM
         OhkqOe8UtKZ77L0odKm+0GL/1SQyAkID5s1jX0ijPgmU3PWINC3KTEfdgx6jBiF+6gpY
         hZzQ==
X-Gm-Message-State: ANoB5pldA//UgilmENN2Tyg42Bql9xQVIC2bVM8zpR350pd6gQLouuGt
        AlIAorx49/s1z8PyIrP3Y9e+QA==
X-Google-Smtp-Source: AA0mqf6vI7368+n4pMvnxi95VA1iyP5io7fGxgExwiA82zCaQaCmxm8ukx9e+6+7K5FUfEXl2FApkg==
X-Received: by 2002:a05:6512:47c:b0:48a:e80f:4b3a with SMTP id x28-20020a056512047c00b0048ae80f4b3amr15533040lfd.575.1669808482638;
        Wed, 30 Nov 2022 03:41:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be11-20020a05651c170b00b002799b5aa42esm111713ljb.55.2022.11.30.03.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:41:22 -0800 (PST)
Message-ID: <5d3ff57a-cb51-5dbf-7d38-7cc40aeea59c@linaro.org>
Date:   Wed, 30 Nov 2022 12:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] dt-bindings: interconnect: Add SM6115 DT bindings
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        djakov@kernel.org, konrad.dybcio@linaro.org, a39.skl@gmail.com,
        andersson@kernel.org
References: <20221130103841.2266464-1-bhupesh.sharma@linaro.org>
 <20221130103841.2266464-3-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130103841.2266464-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 11:38, Bhupesh Sharma wrote:
> The Qualcomm SM6115 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Add the support for the same.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---

Thank you for your patch. There is something to discuss/improve.

We could create common properties for these bindings, but it's fine now.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +    snoc: interconnect@1880000 {
> +        compatible = "qcom,sm6115-snoc";
> +        reg = <0x01880000 0x60200>;
> +        #interconnect-cells = <1>;
> +        clock-names = "bus", "bus_a";
> +        clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +
> +        clk_virt: interconnect-clk {
> +            compatible = "qcom,sm6115-clk-virt";
> +            #interconnect-cells = <1>;
> +            clock-names = "bus", "bus_a";
> +            clocks = <&rpmcc RPM_SMD_QUP_CLK>,
> +                     <&rpmcc RPM_SMD_QUP_A_CLK>;
> +        };
> +
> +        mmnrt_virt: interconnect-mmnrt {
> +            compatible = "qcom,sm6115-mmnrt-virt";
> +            #interconnect-cells = <1>;
> +            clock-names = "bus", "bus_a";
> +            clocks = <&rpmcc RPM_SMD_MMNRT_CLK>,
> +                     <&rpmcc RPM_SMD_MMNRT_A_CLK>;
> +        };
> +
> +        mmrt_virt: interconnect-mmrt {
> +            compatible = "qcom,sm6115-mmrt-virt";
> +            #interconnect-cells = <1>;
> +            clock-names = "bus", "bus_a";
> +            clocks = <&rpmcc RPM_SMD_MMRT_CLK>,
> +                     <&rpmcc RPM_SMD_MMRT_A_CLK>;
> +        };

Drop last two nodes - they are the same as first.

> +    };
> +
> +    cnoc: interconnect@1900000 {
> +        compatible = "qcom,sm6115-cnoc";
> +        reg = <0x01900000 0x8200>;
> +        #interconnect-cells = <1>;
> +        clock-names = "bus", "bus_a";
> +        clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> +                 <&rpmcc RPM_SMD_CNOC_A_CLK>;
> +    };
> +
> +    bimc: interconnect@4480000 {
> +        compatible = "qcom,sm6115-bimc";
> +        reg = <0x04480000 0x80000>;
> +        #interconnect-cells = <1>;
> +        clock-names = "bus", "bus_a";
> +        clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +                 <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +    };

Drop these two as well, they do not bring anything new here.

> diff --git a/include/dt-bindings/interconnect/qcom,sm6115.h b/include/dt-bindings/interconnect/qcom,sm6115.h
> new file mode 100644
> index 000000000000..2997106a661e
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm6115.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Qualcomm SM6115 interconnect IDs
> + *
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited

Best regards,
Krzysztof

