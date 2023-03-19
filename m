Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B406C00BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCSLNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCSLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:13:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486081F90A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:13:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so36460792edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679224384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wAjLoboDx0r/SSuYgDPISEh0CxZ6z8Uv6gqSJKOSJM=;
        b=RfNGvta9sxl9+3QfJDJJ2migp4D2KHyHEgQmNrDQPfmD7S23CJz6o/K4SxyW2klahh
         njQ59U9/Pl3D0bkTIxVHYTre7fEOfm4hA1tb8Zn2Q7jEWjtye4zhKwqODTSnH+RYe96F
         2+mW61CmVQqV7Z1q1TFiSdDY/p2hHD91RC4gGGPHwTV7+0U/79ipNbQ235Ow9FQWLJMb
         5EE13+F1LJ6H+FLRYfVhA3qtOOZxEuQWYJBcatMcYa8tk37v7yrOj3lNXoW5yGQHRpQt
         0bCRDWeQAfn2hEY8B2/A0CbCsn79HLr7/8E5bS54b8geMl75NqkfFxnM/C9MzXNel43Y
         YeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679224384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wAjLoboDx0r/SSuYgDPISEh0CxZ6z8Uv6gqSJKOSJM=;
        b=QR+ZuHxKvzeoAWiEDZjuwGetEnCKPmOg5zvkOspIJwCuekzC7r+uO/g1Dwg+Z7L+dS
         4cT6dwGHb6fQsSqo5RPjlJ/X5tu7lFhfMfkKyM4mtXjPyuINwbeqK3bVkgXCCW9AkOMn
         GsGkrjZygS7pP0QIYjBkSzs/g9Zko9LFO/uefsz9ub/MLvBCSzhlPwCmVTLjkcsJR3TQ
         HnbPhfIM4ex3aZZKnptIb+Nh9muG5TMN9cS2S2HRv0BVvK7VAWhVniwaACGsXfGgsHmF
         +WBaizzSUVVm9vkyZ2OmJbwT+O2qs/V3/SRUBUmphpwCcZ6O5I2SdfbWCHHAOFv8L0Z3
         l+Aw==
X-Gm-Message-State: AO0yUKVxL6NOBBuBIouGSCBePpysaD+xauMO5hk8prl7RL6DBxVwPDtD
        HixfCe8Igo8+R3ITQPCjOmF+rGydbrUVDiqCk28=
X-Google-Smtp-Source: AK7set83XzTarAE7vHkDCKgIKwINs2PXJ81Vw+zmlP0LYsOL4m8Kay50J4Fivdn6jGmHkixiS5t7Qg==
X-Received: by 2002:a17:906:a457:b0:92f:b47c:cefc with SMTP id cb23-20020a170906a45700b0092fb47ccefcmr5627461ejb.24.1679224383756;
        Sun, 19 Mar 2023 04:13:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906b10700b0092f38a6d082sm3128062ejy.209.2023.03.19.04.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:13:03 -0700 (PDT)
Message-ID: <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
Date:   Sun, 19 Mar 2023 12:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
 <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 15:55, Frank Li wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, March 17, 2023 4:09 AM
>> To: Frank Li <frank.li@nxp.com>; shawnguo@kernel.org
>> Cc: devicetree@vger.kernel.org; festevam@gmail.com; imx@lists.linux.dev;
>> kernel@pengutronix.de; krzysztof.kozlowski+dt@linaro.org; linux-arm-
>> kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
>> Subject: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
>> imx8qm cdns3 glue bindings
>>
>> Caution: EXT Email
>>
>> On 16/03/2023 22:27, Frank Li wrote:
>>> NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.
>>>
>>
>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>> prefix is already stating that these are bindings.
>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
>>>  1 file changed, 122 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-
>> cdns3.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-
>> cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-
>> cdns3.yaml
>>> new file mode 100644
>>> index 000000000000..fc24df1e4483
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
>>> @@ -0,0 +1,122 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (c) 2020 NXP
>>> +%YAML 1.2
>>> +---
>>> +$id:
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevice
>> tree.org%2Fschemas%2Fusb%2Ffsl%2Cimx8qm-
>> cdns3.yaml%23&data=05%7C01%7CFrank.Li%40nxp.com%7Cac9af3d617dc4cf
>> 14baf08db26c74b07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
>> 38146409617970248%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> &sdata=EczZhjyMUGnnp7ZGfSvTj4lmOUuGlOtWYIsxxXIlNXw%3D&reserved
>> =0
>>> +$schema:
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevice
>> tree.org%2Fmeta-
>> schemas%2Fcore.yaml%23&data=05%7C01%7CFrank.Li%40nxp.com%7Cac9a
>> f3d617dc4cf14baf08db26c74b07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
>> 0%7C0%7C638146409617970248%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
>> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
>> %7C%7C%7C&sdata=uTNYuDm%2ByhZ56oQET2pX8sHpEqVvsUYtmOBCPXEK
>> v40%3D&reserved=0
>>> +
>>> +title: NXP iMX8QM Soc USB Controller
>>> +
>>> +maintainers:
>>> +  - Frank Li <Frank.Li@nxp.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: fsl,imx8qm-usb3
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Address and length of the register set for iMX USB3
>> Platform Control
>>
>> Drop "Address and length of the"... or actually just maxItems: 1,
>> because the description is a bit obvious.
>>
>>> +
>>> +  "#address-cells":
>>> +    enum: [ 1, 2 ]
>>> +
>>> +  "#size-cells":
>>> +    enum: [ 1, 2 ]
>>> +
>>> +  ranges: true
>>> +
>>> +  clocks:
>>> +    description:
>>> +      A list of phandle and clock-specifier pairs for the clocks
>>> +      listed in clock-names.
>>
>> Drop description.
>>
>>> +    items:
>>> +      - description: Standby clock. Used during ultra low power states.
>>> +      - description: USB bus clock for usb3 controller.
>>> +      - description: AXI clock for AXI interface.
>>> +      - description: ipg clock for register access.
>>> +      - description: Core clock for usb3 controller.
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: usb3_lpm_clk
>>> +      - const: usb3_bus_clk
>>> +      - const: usb3_aclk
>>> +      - const: usb3_ipg_clk
>>> +      - const: usb3_core_pclk
>>> +
>>> +  assigned-clocks:
>>> +    items:
>>> +      - description: Phandle and clock specifier of IMX_SC_PM_CLK_PER.
>>> +      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MISC.
>>> +      - description: Phandle and clock specifoer of
>> IMX_SC_PM_CLK_MST_BUS.
>>> +
>>> +  assigned-clock-rates:
>>> +    items:
>>> +      - description: Must be 125 Mhz.
>>> +      - description: Must be 12 Mhz.
>>> +      - description: Must be 250 Mhz.
>>
>> I would argue that both properties above are not needed. If your
>> hardware requires fixed frequencies, clock provider can fix them, can't it?
> 
> Clock provider don't know fixed value and turn on only used by client.

So maybe fix the clock provider? Or this device driver? Requiring by
binding specific frequencies for every board is a bit redundant.

Best regards,
Krzysztof

