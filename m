Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4515FD7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJMKiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJMKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:37:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42117E52D6;
        Thu, 13 Oct 2022 03:37:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29DAbgde081195;
        Thu, 13 Oct 2022 05:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665657462;
        bh=y2LZ3hY/sLVuCGWY1LGBLIkE/53Me85ywUgCqvqqef0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uDWVG6cHjO50e0JjrHWFDFT1CiJsXN+dNISKIQJi65wusB5rIk6fF9LYmfcbqNMCF
         zjsRaV9ZHj4JFIretQWOkLtqBn8jhKlub2fRU+NX4m+Cx6dezI1IJT/3oC3nvRlyRk
         mpkM9ovzNSZMPbG6tuiIriTyl9X0d6az+5pDP+I8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29DAbgfK085806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Oct 2022 05:37:42 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 13
 Oct 2022 05:37:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 13 Oct 2022 05:37:41 -0500
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29DAbbJf126088;
        Thu, 13 Oct 2022 05:37:38 -0500
Message-ID: <93b1644f-ed7c-9ded-978b-9da0d840cd1b@ti.com>
Date:   Thu, 13 Oct 2022 16:07:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/5] dt-bindings: remoteproc: Add PRU
 consumer bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <srk@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221012114429.2341215-1-danishanwar@ti.com>
 <20221012114429.2341215-2-danishanwar@ti.com>
 <78805233-0802-7a7e-f1b1-84c566084833@linaro.org>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <78805233-0802-7a7e-f1b1-84c566084833@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,


On 12/10/22 20:54, Krzysztof Kozlowski wrote:
> On 12/10/2022 07:44, MD Danish Anwar wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> Add a YAML binding document for PRU consumers. The binding includes
> 
> Add a DT schema binding for ...
> 

Sure I'll change it to that.

> Second thing: where is a user of this common binding? How do you apply
> this schema to anything?
> 

This dt binding will be included in 'ti,icssg-prueth.yaml' which is introduced
in the series [1].

in 'ti,icssg-prueth.yaml' file --
allOf:
  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#

The consumer can apply the dt schema 'ti,icssg-prueth.yaml' and this schema
will be applied with that as this schema is included in 'ti,icssg-prueth.yaml'.

>> all the common properties that can be used by different PRU consumer
>> or application nodes and supported by the PRU remoteproc driver.
>> These are used to configure the PRU hardware for specific user
>> applications.
>>
>> The application nodes themselves should define their own bindings.
>>
>> Co-developed-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 132 ++++++++++++++++++
>>  1 file changed, 132 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>> new file mode 100644
>> index 000000000000..16be98b7d600
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>> @@ -0,0 +1,132 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common TI PRU Consumer Binding
>> +
>> +maintainers:
>> +  - Suman Anna <s-anna@ti.com>
>> +
>> +description: |
>> +  A PRU application/consumer/user node typically uses one or more PRU device
>> +  nodes to implement a PRU application/functionality. Each application/client
>> +  node would need a reference to at least a PRU node, and optionally define
>> +  some properties needed for hardware/firmware configuration. The below
>> +  properties are a list of common properties supported by the PRU remoteproc
>> +  infrastructure.
>> +
>> +  The application nodes shall define their own bindings like regular platform
>> +  devices, so below are in addition to each node's bindings.
>> +
>> +properties:
>> +  ti,prus:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: phandles to the PRU, RTU or Tx_PRU nodes used
>> +    minItems: 1
>> +    maxItems: 6
>> +    items:
>> +      maxItems: 1
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    minItems: 1
>> +    maxItems: 6
>> +    description: |
>> +      firmwares for the PRU cores, the default firmware for the core from
>> +      the PRU node will be used if not provided. The firmware names should
>> +      correspond to the PRU cores listed in the 'ti,prus' property
>> +
>> +  ti,pruss-gp-mux-sel:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 6
>> +    items:
>> +      enum: [0, 1, 2, 3, 4]
>> +    description: |
>> +      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
>> +      This selects the internal muxing scheme for the PRU instance. Values
>> +      should correspond to the PRU cores listed in the 'ti,prus' property. The
>> +      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
>> +      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
>> +      same slice in the associative array. If the array size is smaller than
>> +      the size of 'ti,prus' property, the default out-of-reset value (0) for the
>> +      PRU core is used.
>> +
>> +required:
>> +  - ti,prus
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    /* PRU application node full example */
>> +    icssg2_eth: icssg2-eth {
>> +      compatible = "ti,am654-icssg-prueth";
>> +      pinctrl-names = "default";
>> +      pinctrl-0 = <&icssg2_rgmii_pins_default>;
>> +      sram = <&msmc_ram>;
>> +      ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
>> +        <&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
> 
> Fix alignment. In other places as well.
> 

Sure, I'll work on this.

>> +      firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
>> +          "ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
>> +          "ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
>> +          "ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
>> +          "ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
>> +          "ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
>> +
> 
> Best regards,
> Krzysztof
> 

[1] https://lore.kernel.org/all/20220531095108.21757-2-p-mohan@ti.com/

Thanks and Regards,
Danish.
