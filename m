Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B2A6CBCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjC1KnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjC1KnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:43:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C1C49F6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:43:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er13so6733497edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680000190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgOiq+AtOeciCdmH4CfKTQkHujujZJqW/oCAjnkxQJQ=;
        b=z2fbJCUs40UgcqDVbQGQh4kmhI6WeRhHxPmP8pKs0i8yh52/eine8xe/tM/6QfvHbP
         QJ84tlX3SNKaesXQdNLzBBkJHTcBgYG7l2PiH0gk90E2Chf5Q8oxKOxEQZzjceExb8vV
         IFVjPu6VDsTPVaDViZGIefeYhR1c4k5DYYYwxvCTyMrdGYlVYsbct9l4o4yRFTLvE6pt
         vlLybW/hJd+JVIsi5Xs53rx0D2PkCx0duxyHUGoPHLLWQol/hyhwBr1dgVwtULDJqQw7
         732Bg4O/RimTRXeC9m48hFh3Q2utdgpE4jfJ1dLpIrMKbGJz/F2vu4hnYh454T3cAXpQ
         ckeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680000190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgOiq+AtOeciCdmH4CfKTQkHujujZJqW/oCAjnkxQJQ=;
        b=LmaBJ3nk4Pz63wdIrbIYmxxgFpBJx3MIIGnGcw8RErfICwRq2k27xJf/Iu04YxuTWA
         MyLnnglE7NLdDE3vv2K5KQGG+qvV3MZNyhf1AsgdfGjz8UbKuISogSKB8To38Bc/In5L
         7S/PkFv4YoA0FhIxsqhlD4Tn7WTdxuLopxe2nzG5sKWpl5LhmlDiQViFJnyjB3bZHq5L
         3CDGxNMLHAgCoqj6OBlATQ+AKT35uDtJQGqrHrexJSt0ykFgVDGheEvpnVhNrc6As+Qg
         dkduQ5EF95HeqUqLpN3oX8DLrP44uOu4wHqQp2A80Tnt0ZaGOjgspalfjilz6OANfq5K
         qsjQ==
X-Gm-Message-State: AAQBX9dd30gO1cvRkztlgMHFIhfzWdxJM/T/Jqft283GXk5dgJLstvzn
        2dszTNzVK1RCOdcZhqbuZvlZDQ==
X-Google-Smtp-Source: AKy350Zfnrc8ZewffEwh0R/rtujIhidB2cKU4fpAUyOT7kpfXTOeG5IhvfNxPAEsI9UYX+OUDcVZNQ==
X-Received: by 2002:a17:906:3f8e:b0:939:ad91:adf5 with SMTP id b14-20020a1709063f8e00b00939ad91adf5mr17014758ejj.25.1680000189965;
        Tue, 28 Mar 2023 03:43:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id lj24-20020a170906f9d800b00932ba722482sm14366953ejb.149.2023.03.28.03.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:43:09 -0700 (PDT)
Message-ID: <aec9e01b-c358-0982-3090-ef980d4a5623@linaro.org>
Date:   Tue, 28 Mar 2023 12:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Content-Language: en-US
To:     Jun Li <jun.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
References: <20230323065824.3857573-1-peng.fan@oss.nxp.com>
 <5675373c-af4f-906f-9906-7853a85f8ed6@linaro.org>
 <PA4PR04MB96405A3B0B5158561D9E068F89889@PA4PR04MB9640.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PA4PR04MB96405A3B0B5158561D9E068F89889@PA4PR04MB9640.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 11:24, Jun Li wrote:
> Hi Krzysztof,
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, March 27, 2023 3:41 PM
>> To: Peng Fan (OSS) <peng.fan@oss.nxp.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; gregkh@linuxfoundation.org; Jun Li
>> <jun.li@nxp.com>
>> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Peng Fan <peng.fan@nxp.com>
>> Subject: Re: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
>> format
>>
>> On 23/03/2023 07:58, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Convert the binding to DT schema format. The default speed is HS, so
>>> add a dummy port@0 in the example.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V1:
>>>  The default speed is HS, so port@0 is not added for some device tree,
>>> however the usb-c-connector requires port@0. Not sure we should drop
>>> the required port@0 from usb-c-connector schema or add a dummy port@0
>>> for tcpci as what this patch does.
>>
>> imx8mq-librem5-devkit has full port@0 so just use similar approach.
>>
>>>
>>>  .../devicetree/bindings/usb/typec-tcpci.txt   | 49 ------------
>>>  .../devicetree/bindings/usb/typec-tcpci.yaml  | 80
>>> +++++++++++++++++++
>>>  2 files changed, 80 insertions(+), 49 deletions(-)  delete mode
>>> 100644 Documentation/devicetree/bindings/usb/typec-tcpci.txt
>>>  create mode 100644
>>> Documentation/devicetree/bindings/usb/typec-tcpci.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>>> b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>>> deleted file mode 100644
>>> index 2082522b1c32..000000000000
>>> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>>> +++ /dev/null
>>> @@ -1,49 +0,0 @@
>>> -TCPCI(Typec port cotroller interface) binding
>>> ----------------------------------------------
>>> -
>>> -Required properties:
>>> -- compatible:       should be set one of following:
>>> -		    - "nxp,ptn5110" for NXP USB PD TCPC PHY IC ptn5110.
>>> -
>>> -- reg:              the i2c slave address of typec port controller device.
>>> -- interrupt-parent: the phandle to the interrupt controller which provides
>>> -                    the interrupt.
>>> -- interrupts:       interrupt specification for tcpci alert.
>>> -
>>> -Required sub-node:
>>> -- connector: The "usb-c-connector" attached to the tcpci chip, the
>>> bindings
>>> -  of connector node are specified in
>>> -  Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> -
>>> -Example:
>>> -
>>> -ptn5110@50 {
>>> -	compatible = "nxp,ptn5110";
>>> -	reg = <0x50>;
>>> -	interrupt-parent = <&gpio3>;
>>> -	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>>> -
>>> -	usb_con: connector {
>>> -		compatible = "usb-c-connector";
>>> -		label = "USB-C";
>>> -		data-role = "dual";
>>> -		power-role = "dual";
>>> -		try-power-role = "sink";
>>> -		source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
>>> -		sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
>>> -			     PDO_VAR(5000, 12000, 2000)>;
>>> -		op-sink-microwatt = <10000000>;
>>> -
>>> -		ports {
>>> -			#address-cells = <1>;
>>> -			#size-cells = <0>;
>>> -
>>> -			port@1 {
>>> -				reg = <1>;
>>> -				usb_con_ss: endpoint {
>>> -					remote-endpoint = <&usb3_data_ss>;
>>> -				};
>>> -			};
>>> -		};
>>> -	};
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
>>> b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
>>> new file mode 100644
>>> index 000000000000..067d3b032e3d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
>>
>> Is this a binding for PTN5110 or for generic tcpci? Looks like the first,
>> thus name should be rather device specific, so nxp,ptn5110.
>> Specially that there are other tcpci chips in separate bindings.
> 
> This binding doc is target for generic tcpci, ptn5110 is the one


Does this mean that TCPCI requires every device to have exactly one
interrupt (no 0, no 2, exactly 1), no supplies and no additional GPIOs
(like reset GPIO)?

Because this is what this binding is saying.

> fully compliance with tcpci spec, if change it to be only specific
> to nxp,ptn5110, my understanding is then other chips need duplicate
> a binding doc even common tcpci binding and driver is enough for them.

Depends. Usually we have common schema used by actual device schemas. If
TCPCI-compliant device cannot have additional properties, then this one
here looks fine.

One more thing - typec-tcpci is a bit redundant "tc" means typec, so
basicaly you said "typec-typec-pci". This shouold be then just typec-pci
or tcpci.

Best regards,
Krzysztof

