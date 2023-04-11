Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B086DD37D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDKGyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjDKGyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:54:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731D30E0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j17so8094267ejs.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681196035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPII2+7UcEqicluRqHsNqDQVwcTL5rcH00gYMa5rTCc=;
        b=nRiErdd+Bpp90CF+yP//jHteWDqjnYMwpw/g+EQ1g6NVjh00v568TXH/gi3vpExcvB
         htdeVyNS7UU4Wwi/nS2iynIkSWg8J/ixJvkcd8Lu+1aQypjFtojHsSoqJlpwsIPSjw2B
         RvKirWYEP6deBZPpiBxBgI3VTSJ+1QFF+FXCzt5qb6VDCmPmlka48S1M8J6OjkdttPmu
         NTyM2KOoGybd9gwUcytos/XmlRxseBSaygq2AjWeHG4X20V+7WGhKf2QBTxdth41sNE7
         qgsDo1p9yECnyebOlvoQubjN1ahAMskCSIaJkMKN0156H9DjMVCeP9zAnmWAVs4Fo6/3
         vu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPII2+7UcEqicluRqHsNqDQVwcTL5rcH00gYMa5rTCc=;
        b=fkUBrzPnSuksVUhDfEWkfV7wCsv0JwuwEy2nf2WRFPl2bv7RJXpBzeOYertuuG/+hW
         xmkFeO8eMyL3TXI/KAsAjRkCC5JtIcAGbtxyMRJcLF/PC8JkY/2UAiMTFLKBWKEncYab
         jDvg8TBIOlUP4STkaET17xLIdBHlB6CMZ11NgwXOSQ7I5Ch8an90IqQczL/aaZfL4QOc
         k5mZOvxn5sZkXdMqcHRy+splu51G960k+m95A0+PWkPlTsXve18DZGf+Q1KsxSJx7n8r
         0NzyQsG9j2+CiXBtA60UUizHHRLBAfDRHgTL+mSF0Wf+YpplJ2OVqgmeOZBXDA8VE7ZS
         cHMQ==
X-Gm-Message-State: AAQBX9dWn9rlwcPPQuhtZ/QXzxSkn8vx3mMU1shWLOO6lz+qDUaaEknF
        TlJzv+C/2LzNan8mUjqhJQQvvw==
X-Google-Smtp-Source: AKy350bXP0CmXLGmI+Yl125Df9uD7iGcOyKtLb5Q644W9e+w6r4y4frohYTK896anzu/XGtJ+KT31g==
X-Received: by 2002:a17:907:3ea3:b0:94a:62d3:ce1e with SMTP id hs35-20020a1709073ea300b0094a62d3ce1emr8538936ejc.40.1681196034752;
        Mon, 10 Apr 2023 23:53:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id xd4-20020a170907078400b0094a941ad8f0sm1577541ejb.193.2023.04.10.23.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:53:53 -0700 (PDT)
Message-ID: <55a82f21-2cfe-cc75-58b3-c1bb96835582@linaro.org>
Date:   Tue, 11 Apr 2023 08:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/5] dt-bindings: hwmon: intel: add hardware monitor
 bindings for SoCFPGA
Content-Language: en-US
To:     dinh.nguyen@linux.intel.com, linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-2-dinh.nguyen@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410153314.27127-2-dinh.nguyen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 17:33, dinh.nguyen@linux.intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> 
> Document the hardware monitoring bindings for SoCFPGA 64-bit platforms.
> 
> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> ---
>  .../bindings/hwmon/intel,socfpga-hwmon.yaml   | 241 ++++++++++++++++++
>  1 file changed, 241 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> new file mode 100644
> index 000000000000..ec9d9eabdc37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> @@ -0,0 +1,241 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/intel,socfpga-hwmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel SoCFPGA Hardware monitor
> +
> +maintainers:
> +  - Dinh Nguyen <dinh.nguyen@linux.intel.com>
> +
> +description: |
> +  The Intel SoCFPGA hardware monitor unit provides on-chip voltage and
> +  temperature sensors. You can use these sensors to monitor external
> +  voltages and on-chip operating conditions such as internal power rails
> +  and on-chip junction temperatures.
> +
> +  The specific sensor configurations vary for each device family and
> +  each device within a family does not offer all potential sensor
> +  options. The information below attempts to illustrate the super set of
> +  possible sensor options that are potentially available within each
> +  device family, but the user should check the documentation for the
> +  specific device they are using to verify which sensor options it
> +  actually provides.
> +
> +  Stratix 10 Device Family
> +
> +    Stratix 10 Voltage Sensors
> +
> +      page 0, channel 2 = 0.8V VCC
> +      page 0, channel 3 = 1.0V VCCIO
> +      page 0, channel 6 = 0.9V VCCERAM
> +
> +    Stratix 10 Temperature Sensors
> +
> +      page 0, channel 0 = main die
> +      page 0, channel 1 = tile bottom left
> +      page 0, channel 2 = tile middle left
> +      page 0, channel 3 = tile top left
> +      page 0, channel 4 = tile bottom right
> +      page 0, channel 5 = tile middle right
> +      page 0, channel 6 = tile top right
> +      page 0, channel 7 = hbm2 bottom
> +      page 0, channel 8 = hbm2 top
> +
> +  Agilex Device Family
> +
> +    Agilex Voltage Sensors
> +
> +      page 0, channel 2 = 0.8V VCC
> +      page 0, channel 3 = 1.8V VCCIO_SDM
> +      page 0, channel 4 = 1.8V VCCPT
> +      page 0, channel 5 = 1.2V VCCRCORE
> +      page 0, channel 6 = 0.9V VCCH
> +      page 0, channel 7 = 0.8V VCCL
> +
> +    Agilex Temperature Sensors
> +
> +      page 0, channel 0 = main die sdm max
> +      page 0, channel 1 = main die sdm 1
> +
> +      page 1, channel 0 = main die corner bottom left max
> +      page 1, channel 1 = main die corner bottom left 1
> +      page 1, channel 2 = main die corner bottom left 2
> +
> +      page 2, channel 0 = main die corner top left max
> +      page 2, channel 1 = main die corner top left 1
> +      page 2, channel 2 = main die corner top left 2
> +
> +      page 3, channel 0 = main die corner bottom right max
> +      page 3, channel 1 = main die corner bottom right 1
> +      page 3, channel 2 = main die corner bottom right 2
> +
> +      page 4, channel 0 = main die corner top right max
> +      page 4, channel 1 = main die corner top right 1
> +      page 4, channel 2 = main die corner top right 2
> +
> +      page 5, channel 0 = tile die bottom left max
> +      page 5, channel 1 = tile die bottom left 1
> +      page 5, channel 6..2 = tile die bottom left 6..2 R-tile only
> +      page 5, channel 5..2 = tile die bottom left 5..2 F-tile only
> +      page 5, channel 4..2 = tile die bottom left 4..2 E-tile only
> +
> +      page 7, channel 0 = tile die top left max
> +      page 7, channel 1 = tile die top left 1
> +      page 7, channel 6..2 = tile die top left 6..2 R-tile only
> +      page 7, channel 5..2 = tile die top left 5..2 F-tile only
> +      page 7, channel 4..2 = tile die top left 4..2 E-tile only
> +
> +      page 8, channel 0 = tile die bottom right max
> +      page 8, channel 1 = tile die bottom right 1
> +      page 8, channel 6..2 = tile die bottom right 6..2 R-tile only
> +      page 8, channel 5..2 = tile die bottom right 5..2 F-tile only
> +      page 8, channel 4..2 = tile die bottom right 4..2 E-tile only
> +
> +      page 10, channel 0 = tile die top right max
> +      page 10, channel 1 = tile die top right 1
> +      page 10, channel 6..2 = tile die top right 6..2 R-tile only
> +      page 10, channel 5..2 = tile die top right 5..2 F-tile only
> +      page 10, channel 4..2 = tile die top right 4..2 E-tile only
> +
> +  N5X Device Family
> +
> +    N5X Voltage Sensors
> +
> +      page 0, channel 2 = 0.8V VDD
> +      page 0, channel 3 = 0.8V VDD_SDM
> +      page 0, channel 4 = 1.8V VCCADC
> +      page 0, channel 5 = 1.8V VCCPD
> +      page 0, channel 6 = 1.8V VCCIO_SDM
> +      page 0, channel 7 = 0.8V VDD_HPS
> +
> +    N5X Temperature Sensors
> +
> +      page 0, channel 0 = main die
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,socfpga-hwmon

You should have SoC specific compatibles, followed by one specific or by
generic.

> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      The sensor mapping address is denoted by the lower 16-bits being
> +      the channel mask location that defines the channel number.
> +      The upper 16-bits denotes the page number.
> +      The bit mask of 0x1 represents channel 1. The supported
> +      page and channel is dependent on the SoCFPGA variant.
> +      Page number greater than 0 is only supported on the
> +      temperature sensors.
> +
> +  temperature:
> +    description:
> +      Specifies the possible mappings of temperature sensors
> +      diodes on the SoCFPGA main die and tile die.

What's this? No ref/type, not constraints?

> +
> +  voltage:
> +    description:
> +      Specifies the possible mappings of the voltage sensors on the
> +      SoCFPGA analog to digital converter of the Secure Device Manager
> +      (SDM).

Same here.

> +
> +  input:
> +    description:
> +      Specifies each sensor.

And here.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    temp_volt {

No underscores in node names.

> +      compatible = "intel,socfpga-hwmon";
> +      voltage {
> +        #address-cells = <1>;
> +        #size-cells = <0>;

So this is object?



Best regards,
Krzysztof

