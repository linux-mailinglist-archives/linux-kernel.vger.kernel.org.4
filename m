Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878F6139B0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiJaPLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJaPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:11:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DC10542;
        Mon, 31 Oct 2022 08:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F2CDB8159D;
        Mon, 31 Oct 2022 15:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E3C433D6;
        Mon, 31 Oct 2022 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667229060;
        bh=h6r/+2mAC4/njaA4+atvfxEJX7+EwKTjdDsDGq1YOf4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W3d/9ka5yozHPyemoWjKEnlFiRYHDNrGpKWaKr2rkkTLc0xWdpulhTYdw1a+vlWwh
         FTIWGJ+Ujf+EExRuQbtqIuhU71PoYHyF4HWr0ZCi5T6VhIOR51RY2LWrVBAXPyObnL
         Ncm2bXQ/gAKA64q4rAj90Z4yqcgkWKwJuTEgj88+IKS4qUsFKGLY0MqQLLrFvga/Vs
         wZYonZtC/Lo86Jy/ysWbyHEUCZUYFrb/n2BF/dnoZiwSfJL4L73HFPIgzOBdCwj+GK
         DspQWgxQNfRO4QojWNdee9Ffas9FVq3qe2+Seuekx6URIKJnmJGIglXSLG72nQ8Yxp
         V1JrczX/+uInA==
Message-ID: <f639fb74-ac76-b48f-a4fa-cfa9534f9c82@kernel.org>
Date:   Mon, 31 Oct 2022 10:10:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv6 1/6] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
To:     Rob Herring <robh@kernel.org>
Cc:     jh80.chung@samsung.com, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221026141631.696863-1-dinguyen@kernel.org>
 <20221026205022.GA1291041-robh@kernel.org>
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20221026205022.GA1291041-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/22 15:50, Rob Herring wrote:
> On Wed, Oct 26, 2022 at 09:16:26AM -0500, Dinh Nguyen wrote:
>> Document the optional "altr,sysmgr-syscon" binding that is used to
>> access the System Manager register that controls the SDMMC clock
>> phase.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v6: make "altr,sysmgr-syscon" optional
>> v5: document reg shift
>> v4: add else statement
>> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>>      "altr,socfpga-dw-mshc"
>> v2: document "altr,sysmgr-syscon" in the MMC section
>> ---
>>   .../bindings/mmc/synopsys-dw-mshc.yaml        | 23 ++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> index ae6d6fca79e2..0e2024eb9018 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>>   title: Synopsys Designware Mobile Storage Host Controller Binding
>>   
>> -allOf:
>> -  - $ref: "synopsys-dw-mshc-common.yaml#"
>> -
>>   maintainers:
>>     - Ulf Hansson <ulf.hansson@linaro.org>
>>   
>> @@ -38,6 +35,26 @@ properties:
>>         - const: biu
>>         - const: ciu
>>   
>> +allOf:
>> +  - $ref: synopsys-dw-mshc-common.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: altr,socfpga-dw-mshc
>> +    then:
>> +      properties:
>> +        altr,sysmgr-syscon:
>> +          $ref: /schemas/types.yaml#/definitions/phandle-array
>> +          items:
>> +            - description: phandle to the sysmgr node
>> +            - description: register offset that controls the SDMMC clock phase
>> +            - description: register shift for the smplsel(drive in) setting
> 
> This goes in the top-level. Use if/then schema to add constraints, not
> define properties.
> 
>> +    else:
> 
> Then you'll need to negate the if:  if: { not: { properties: ... }}
> 

Thanks Rob, is this what you mean?

   altr,sysmgr-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: phandle to the sysmgr node
           - description: register offset that controls the SDMMC clock 
phase
           - description: register shift for the smplsel(drive in) setting
     description:
       Contains the phandle to System Manager block that contains
       the SDMMC clock-phase control register. The first value is the 
pointer
       to the sysmgr, the 2nd value is the register offset for the SDMMC
       clock phase register, and the 3rd value is the bit shift for the
       smplsel(drive in) setting.

allOf:
   - $ref: "synopsys-dw-mshc-common.yaml#"

   - if:
       properties:
         compatible:
           contains:
             const: altr,socfpga-dw-mshc
     then:
       not:				<----- add the 'not' here?
         required:
           - altr,sysmgr-syscon
     else:
       properties:
         altr,sysmgr-syscon: false



