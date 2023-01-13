Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5666A3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjAMT6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjAMT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:58:35 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55CD869F1;
        Fri, 13 Jan 2023 11:58:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so54747140ejc.4;
        Fri, 13 Jan 2023 11:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1Bs/TNdFi0UV3tkxYGOXoG9MLNWFUnNK4EJRg4R6c8=;
        b=gfxiiPHmcgM+/qiJjPmOsjS3s8pAL6hBxe2o+wn7fnfeOjsQ9+vJxAWUjH0NWhALDv
         2oXmyhPGfPK3WAExVSUcaWWEwVsp1mhT97stYeSiqGvVKRc6wLV70hh5ZIq6GnHjzce+
         skk82AHnBw/oUJsfxEritr7qSj+cTRgH1tdTmfuTvbiRFxdmFWw8S2xtylPpfuWcARH1
         EEVuwc+2aIY5MIdT0pZoCXijsE2trs/cQ5mRD6kqyeKhcKkycP9IB9vtlQrDRzEA/1+H
         LQ6F6zuEEwEcWPwSg1Lwp1go94f8vtWkGBPUiG7Avh3ScjRmXz4oBvs7TRTyvYLAa6JV
         F3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1Bs/TNdFi0UV3tkxYGOXoG9MLNWFUnNK4EJRg4R6c8=;
        b=D+CzX7UVWYYTVZCjuTg9uLxIJBmapCIL6cAYwtzoKmAax+hSea7r7tXUjKJKrE+Mvs
         9cbSBQ08GWV42d7PybXc2Nw7vz+23ukg2SNnwXNR3e0ZsfoYIuAgZOR4d6HNBIVSPY/e
         6ZO01AhabEyeESmjZQoAl9HyAO2B18D7fDG42nntb35IY2OWMyTAo5b+/hMxs/BYaIOq
         2/IrWrT06T3DsuB398AmuytTwIdIexlP/iM/aVakIWyqVDDyKDqX7mki2iePg7pvxFJj
         DuU5Czi+eOGcZrZXtF1azhe2qztxa9v/7yYsJBJmO9jxgaD5TUG1/lMkR2IF7/tZjyEE
         VCJg==
X-Gm-Message-State: AFqh2kpTOBZxzaMrpN1qH1rmCQXamWLeYzfbJFcxtLfBc7655HTJfqhy
        aaB6puAZbn3tF4m95nEfNv6fJOGP+Ws=
X-Google-Smtp-Source: AMrXdXvU6CwiH9dKLA45vk/7f2vTSzhztuu9DL8bz5CMA5aKgSeDgE67IjwpGrF77vk4tLriTRrFkg==
X-Received: by 2002:a17:906:b00d:b0:7c1:8ba6:6eb3 with SMTP id v13-20020a170906b00d00b007c18ba66eb3mr73926764ejy.35.1673639912295;
        Fri, 13 Jan 2023 11:58:32 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a170906078600b0084d381d0528sm7661277ejc.180.2023.01.13.11.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 11:58:31 -0800 (PST)
Message-ID: <8eca0d59-8db3-b66e-f219-0a256a9b0c79@gmail.com>
Date:   Fri, 13 Jan 2023 20:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip: convert
 rockchip-dp-phy.txt to yaml
To:     Vinod Koul <vkoul@kernel.org>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        kishon@kernel.org
References: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
 <Y8GeBzNJvhMeh3sn@matsya>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <Y8GeBzNJvhMeh3sn@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 19:08, Vinod Koul wrote:
> On 29-12-22, 10:44, Johan Jonker wrote:
>> Convert rockchip-dp-phy.txt to yaml.
> 
> This series fails to apply, pls rebase

Hi Vinod, Heiko,

This serie and others must be combined in the right order to grf.yaml.
Maybe better that Heiko does that with your ACK.

Johan

===

Apply after:
  dt-bindings: soc: rockchip: grf: add rockchip,lvds.yaml

>>
>> Changed:
>>   rename file name
> 
> This should not be in change log but after the --- line
> 
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Changed V2:
>>   Use the compatible as filename.
>> ---
>>  .../bindings/phy/rockchip,rk3288-dp-phy.yaml  | 41 +++++++++++++++++++
>>  .../bindings/phy/rockchip-dp-phy.txt          | 26 ------------
>>  2 files changed, 41 insertions(+), 26 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
>> new file mode 100644
>> index 000000000..2538235c5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/rockchip,rk3288-dp-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip specific extensions to the Analogix Display Port PHY
>> +
>> +maintainers:
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +properties:
>> +  compatible:
>> +    const: rockchip,rk3288-dp-phy
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: 24m
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - "#phy-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3288-cru.h>
>> +    edp-phy {
>> +      compatible = "rockchip,rk3288-dp-phy";
>> +      clocks = <&cru SCLK_EDP_24M>;
>> +      clock-names = "24m";
>> +      #phy-cells = <0>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>> deleted file mode 100644
>> index e3b4809fb..000000000
>> --- a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>> +++ /dev/null
>> @@ -1,26 +0,0 @@
>> -Rockchip specific extensions to the Analogix Display Port PHY
>> -------------------------------------
>> -
>> -Required properties:
>> -- compatible : should be one of the following supported values:
>> -	 - "rockchip.rk3288-dp-phy"
>> -- clocks: from common clock binding: handle to dp clock.
>> -	of memory mapped region.
>> -- clock-names: from common clock binding:
>> -	Required elements: "24m"
>> -- #phy-cells : from the generic PHY bindings, must be 0;
>> -
>> -Example:
>> -
>> -grf: syscon@ff770000 {
>> -	compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
>> -
>> -...
>> -
>> -	edp_phy: edp-phy {
>> -		compatible = "rockchip,rk3288-dp-phy";
>> -		clocks = <&cru SCLK_EDP_24M>;
>> -		clock-names = "24m";
>> -		#phy-cells = <0>;
>> -	};
>> -};
>> --
>> 2.20.1
> 
