Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521F5EF75D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiI2OUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiI2OU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127744544;
        Thu, 29 Sep 2022 07:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CECC614CC;
        Thu, 29 Sep 2022 14:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9A6C433C1;
        Thu, 29 Sep 2022 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664461226;
        bh=vHV9ImbyC1bX1fA+Ugz63RxnLDORL34uu/WNC/spHOg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AxjqOYxXs+PwXi0Pxsa4LAhY5mTPyg9cbMtd52i2rrYVVHy20+aOst0NUJh5fl3uq
         nsUTZsyojwrI57ufwayF6wyj3Dk3zfgjCe5xmpCqgo5gcnisaL7crsV6o527zbYTas
         TVtCqLFtRFz+jzf95wuhOG25c2BCd/ZS5vGCn+Ar8TQpq3TOAH4J1sM578e5vQ415i
         EfuM1j738QugC4KHR0tZxb0LBZmZ/G8Eg6CoDunQCDeDttgczkkcW20l47TWkj2nXA
         y5tRYQfYlubGR70F7VVXBZdWQ7gfr0sPFmL17bdmdQqyjD7EaVbpp/TP266qZz8b5b
         3rwTsJUeOqfKA==
Message-ID: <20cbd2a2-752e-8537-4cbd-6665ef9afd69@kernel.org>
Date:   Thu, 29 Sep 2022 09:20:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 04:24, Ulf Hansson wrote:
> On Wed, 28 Sept 2022 at 18:54, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>> Document the optional "altr,sysmgr-syscon" binding that is used to
>> access the System Manager register that controls the SDMMC clock
>> phase.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v4: add else statement
>> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>>      "altr,socfpga-dw-mshc"
>> v2: document "altr,sysmgr-syscon" in the MMC section
>> ---
>>   .../bindings/mmc/synopsys-dw-mshc.yaml        | 31 +++++++++++++++++--
>>   1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> index ae6d6fca79e2..b73324273464 100644
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
>> @@ -38,6 +35,34 @@ properties:
>>         - const: biu
>>         - const: ciu
>>
>> +  altr,sysmgr-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to the sysmgr node
>> +          - description: register offset that controls the SDMMC clock phase
>> +    description:
>> +      Contains the phandle to System Manager block that contains
>> +      the SDMMC clock-phase control register. The first value is the pointer
>> +      to the sysmgr and the 2nd value is the register offset for the SDMMC
>> +      clock phase register.
>> +
>> +allOf:
>> +  - $ref: "synopsys-dw-mshc-common.yaml#"
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const:
>> +              - altr,socfpga-dw-mshc
>> +    then:
>> +      required:
>> +        - altr,sysmgr-syscon
>> +    else:
>> +      properties:
>> +        altr,sysmgr-syscon: false
> 
> So this change will not be backwards compatible with existing DTBs. I
> noticed that patch2 updates the DTS files for the arm64 platforms, but
> there seems to be some arm32 platforms too. Isn't this going to be a
> problem?
> 

The arm32 platforms makes the clk-phase adjustment through the clock 
driver. There was a discussion when I originally submitted the support 
for the arm32 platforms, and we landed on going through the clock driver 
instead of using the MMC driver. The updates to the arm32 platforms can 
be done after this patch series.

Dinh
