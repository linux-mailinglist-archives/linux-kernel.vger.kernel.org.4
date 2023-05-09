Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D341B6FBFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjEIHCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjEIHB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:01:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536244AA
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:01:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a34a14a54so1085234366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683615714; x=1686207714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2w+LP/BRimWvUmgXG0xrDg/judJm/+0nDB3mUAJsUI=;
        b=MvefHzvpAqEnEaQ9tj7yvyO9mSaklYcsaJVhcdfmwerpqOXZGZHkoiB5sVqbtK3wRn
         0R1XJHBTju6ZTDV2AMPxGf0lo/vTxtGpO9ar+sLtyW8HGNOvthJUXABk4T/9yCIEJ8I2
         mCrMb5eqFIW646l9rI+w7rXWJdUVHFwGmGuzcKo4WB23N5dcHYlm2Z4wvVCe0dpJ+5pP
         Mmt8kkln0y+saKvccqb7Hy9LK0G1OXlca8R2T42PVTVJZRLYw+s/j7Er/U7u/EkRMKqt
         38S1ee3Qg+sA7YdyEt3YkMrMDOtHyCtu5FKmCUVX1wf/ilwQn9743fY8XoyrxVM+DvUd
         lYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683615714; x=1686207714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2w+LP/BRimWvUmgXG0xrDg/judJm/+0nDB3mUAJsUI=;
        b=TkwRzzz/hY88FqAGzTPEKVkqGsLcW6D9YQHgnXobERAIrFDUBh+nXjKgv23esh+8CQ
         L9Gfo4MmnVH1TM5W70TjeFs6ImKkeZCAHxA+RElwRl4okdvgn2utAG6APIf2uG1qbmmA
         Eto65LaIT9DdHabn0PTJ+sDYZZu2B3SuMvT+ZP0QqRxhqAdXopcIvL9q/pFmII4SalFc
         iXJcfBFw1HKEh5mrU8gTOmEVIxD+BHAnWm85nkccwLr2Y4e0evW7I5THEobWC6fGxmzU
         cyRZV91u22d7JQs1K7eVJM7GQEL2NIziOF8P/MB3b8Mb02g18GPkgl6JaZV8Qz5JC2yL
         CiOA==
X-Gm-Message-State: AC+VfDztlqZ+rZX2p8o+QKCULBdaYKp9UG9aBOSsKrQwGdgWtdcYicKq
        ReXzLn0dQjVgNL7iHK3EyNtCsA==
X-Google-Smtp-Source: ACHHUZ7qT4ANrAYC+8Pg+GWEMetM+W+DZBfrxnyC+VDPz4oQniQfLn/8Z99noTaeTtOEFp1BdUW/1A==
X-Received: by 2002:a17:907:9686:b0:966:65ee:beb7 with SMTP id hd6-20020a170907968600b0096665eebeb7mr5865612ejc.71.1683615714198;
        Tue, 09 May 2023 00:01:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id gt20-20020a170906f21400b0094f7744d135sm937560ejb.78.2023.05.09.00.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 00:01:53 -0700 (PDT)
Message-ID: <bccecef7-76d2-6d53-b3e3-20cea9957ae6@linaro.org>
Date:   Tue, 9 May 2023 09:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 5/6] dt-bindings: hwmon: intel: add hardware monitor
 bindings for SoCFPGA
Content-Language: en-US
To:     dinh.nguyen@linux.intel.com, linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
 <20230508212852.8413-5-dinh.nguyen@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508212852.8413-5-dinh.nguyen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 23:28, dinh.nguyen@linux.intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> 
> Document the hardware monitoring bindings for SoCFPGA 64-bit platforms.
> 
> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> ---
> v2: Add intel,socfpga-agilex-hwmon, intel,socfpga-n5x-hwmon and
>     intel,socfpga-stratix10-hwmon
>     Add patternProperties
> ---
>  .../bindings/hwmon/intel,socfpga-hwmon.yaml   | 258 ++++++++++++++++++

Bindings are before they are used in driver.

>  1 file changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> new file mode 100644
> index 000000000000..e634311a0e81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> @@ -0,0 +1,258 @@
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
> +      - intel,socfpga-agilex-hwmon
> +      - intel,socfpga-n5x-hwmon
> +      - intel,socfpga-stratix10-hwmon
> +      - intel,socfpga-hwmon

The last one is too gerneric. Anyway your driver suggests all of them
are compatible.

> +
> +patternProperties:
> +  "^(voltage)|input@([2-7])$":

That's not what your DTS is saying. Are you sure you tested it?

> +    type: object
> +    description: Specifies the possible mappings of the voltage sensors on the
> +      SoCFPGA analog to digital converter of the Secure Device Manager(SDM).

additionalProperties: false

> +
> +    properties:
> +      reg:
> +        description:
> +          The bit mask of 0x1 represents channel 1. The supported
> +          page and channel is dependent on the SoCFPGA variant.
> +          Page number greater than 0 is only supported on the
> +          temperature sensors.
> +        items:
> +          minimum: 0
> +          maximum: 1

voltage does not have reg. also, the minimum/maximum does not fit your
2-7 at all. Entire part should be probably just maxItems, but anyway I
don't really understand what you want to express here. Especially that
it does not match your DTS.

> +
> +      label:
> +        description: A descriptive name for this channel, i.e "0.8V VCC" or "1.8V VCCIO_SDM".
> +
> +  "^(temperature)|input@([10001-40002])$":
> +    type: object
> +    description: Specifies the possible mappings of the temperature sensors on
> +      the SoCFPGA analog to digital converter of the Secure Device Manager(SDM).

additionalProperties: false

> +
> +    properties:
> +      reg:
> +        description:
> +          The sensor mapping address is denoted by the lower 16-bits being
> +          the channel mask location that defines the channel number.
> +          The upper 16-bits denotes the page number.
> +        items:
> +          minimum: 0
> +          maximum: 1

Same problems, does not make any sense. 40002 is higher than 1.

> +
> +      label:
> +        description: A descriptive name for this channel, i.e "Main Die SDM" or
> +          "Main Die corner bottom left 1".
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false


Best regards,
Krzysztof

