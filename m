Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C391470B874
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjEVJGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjEVJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:05:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF44FE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:05:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-309438004a6so3521598f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684746341; x=1687338341;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=axoW3FpSjS6ZdEPcY+HsNe61u2mtrDh5mhZbIxumcWE=;
        b=Aa5M+EKHb5j+UJQn3aj9tK3Alpc/AIqPMGexoe5BK/lhljSgMfIgHMRCJmFIIlHvhG
         6UcwiFu6WHyQiVeMVyMd2HffRIw++HbWroTBu+AatTVdZaTwLOPv3CRSt/my/n9nq9yj
         FjH6HWRSdD5/GkplLizB+LjLhwAOXffdrEYIo7XNoTr/iPHyPa0N4+1OiStHss5YoLKj
         u9p4qNgDFm1GxM7F3mEwzD8NB69gx9dVtkxTLb4KX+ueFZrT38wf8p1hH2gtqARdVkNw
         Gz4eaPmoGAbukv9EqR31rFsCcFEWEHQqH6wekxJQNXbMYgt7wYVX/0VvBsEInVaUvvEt
         ZYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684746341; x=1687338341;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axoW3FpSjS6ZdEPcY+HsNe61u2mtrDh5mhZbIxumcWE=;
        b=YDtxH/O+TfnjZhihCXCWbiJct3iV2KWwlTX//YcKravqzXx1Gk4herLZ3+14liXkve
         GSb/1qPWGLeTUPG1IBkzufz4ifE2QKPbVIjowvRC+hK8DhB+69zGoMM2lwpU37XNaxUf
         X4VPwUtSHIDu+bcBkNLkF0KNsMek3vqMGnyN87dx9aPCGZKZUYZID+UG10t21kB0/Y4u
         7II9R1bjTj4IFu4fnDOtj37xVGpCIItz7Jl1OBD0H4Tj+dwriYyi780Om+gSmGjmoCox
         bIC6pLoNubO3zV4bpmRaN1jF2rrnbOjUqscLU9r7iAp9IFOsfXIpoZloRXkVE0K2DssR
         vvsg==
X-Gm-Message-State: AC+VfDy/3xpGxeSE4mGpFlZuNJbyYDy2BQRSd1rJ8NPRpUinESjJZMBx
        mFOBhmzKgtQUzXlUwmaBIn6rkQ==
X-Google-Smtp-Source: ACHHUZ7UsuzR+CzfhVbTqtR5TnpcQ0AzmPHrl2RfFgGOiVn3yRs3swvssuJeQF9Ixb2dS0cImOvshQ==
X-Received: by 2002:a5d:570d:0:b0:307:93ec:b323 with SMTP id a13-20020a5d570d000000b0030793ecb323mr6462958wrv.69.1684746340844;
        Mon, 22 May 2023 02:05:40 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c028f00b003f435652aaesm7665993wmk.11.2023.05.22.02.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 02:05:40 -0700 (PDT)
Message-ID: <0d436948-b0b7-0727-0852-51f64aefa43f@linaro.org>
Date:   Mon, 22 May 2023 11:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Visionox R66451
 AMOLED DSI panel bindings
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230516-b4-r66451-panel-driver-v1-0-4210bcbb1649@quicinc.com>
 <20230516-b4-r66451-panel-driver-v1-1-4210bcbb1649@quicinc.com>
 <dzekdzubv6y5evn4j62hnntjdexcdi5ar2wj6hcm3dffx5jei4@h32wgmfalzvl>
Organization: Linaro Developer Services
In-Reply-To: <dzekdzubv6y5evn4j62hnntjdexcdi5ar2wj6hcm3dffx5jei4@h32wgmfalzvl>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 21/05/2023 12:30, Marijn Suijten wrote:
> On 2023-05-16 13:20:30, Jessica Zhang wrote:
>> Document the 1080x2340 Visionox R66451 AMOLED DSI panel bindings
>>
>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> ---
>>   .../bindings/display/panel/visionox,r66451.yaml    | 59 ++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
>> new file mode 100644
>> index 000000000000..6ba323683921
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/visionox,r66451.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Visionox R66451 AMOLED DSI Panel
>> +
>> +maintainers:
>> +  - Jessica Zhang <quic_jesszhan@quicinc.com>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: visionox,r66451
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI virtual channel
>> +
>> +  vddio-supply: true
>> +  vdd-supply: true
>> +  port: true
>> +  reset-gpios: true
> 
> Normally for cmd-mode panels there is also a `disp-te` pin which is
> optionally registered in dsi_host.c as GPIOD_IN, but on **ALL** my Sony
> phones this breaks vsync (as in: mdp5 stops receiving the interrupt, but
> we can see disp-te in /proc/interrupts then).

Describing it as a gpio is wrong, it should be described as a pinctrl state instead.

Neil

> 
> - Marijn
> 
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vddio-supply
>> +  - vdd-supply
>> +  - reset-gpios
>> +  - port
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    dsi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        panel@0 {
>> +            compatible = "visionox,r66451";
>> +            reg = <0>;
>> +            vddio-supply = <&vreg_l12c_1p8>;
>> +            vdd-supply = <&vreg_l13c_3p0>;
>> +
>> +            reset-gpios = <&tlmm 24 GPIO_ACTIVE_LOW>;
>> +
>> +            port {
>> +                panel0_in: endpoint {
>> +                    remote-endpoint = <&dsi0_out>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
>>
>> -- 
>> 2.40.1
>>

