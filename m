Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BD749A35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGFLE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjGFLEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DF173F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E40F61903
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E937C433C7;
        Thu,  6 Jul 2023 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688641471;
        bh=o9EBjyL6qlN2F2RbKrS+KQRO1MOG4ipV4sFHPPlGi0k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jRkGXzasg3lS8kHZ2+SdnCHWU028uZ2B/vPxkjSGlsVaidtb62aN/yEzDjFYCufMM
         v5BRRB5MLHW4JQmrnZlEnrQYBkYh9Ypil+3xoYxmsBg/wwHw0C/LxqcG6W8KAcsJ1/
         F9M4cJi5cYDGTR6XZL1YPEPhA6g+GNqYHk+R9nTDtFQWPCsjKOMgKA2bAQ3VICRvyt
         E5Yhxi2DLcR7ZfiKS0r1fpBzEojdkWpIGh0CcvVE42g5dQFLBh86kwPVybD/QPlUaV
         IoNeBtq4jngvKHMdRttbxhIPYabTfzBwY5BSbl0xZwdB8WPlePLSwW05ezEP4KTFMK
         jv1we4S+EBCbQ==
Message-ID: <51090bca-0fe2-7cb5-e5a6-7ce9d41bf506@kernel.org>
Date:   Thu, 6 Jul 2023 13:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     Alina Yu <alina_yu@richtek.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
References: <cover.1688569987.git.alina_yu@richtek.com>
 <341af3996c430549243365bb8204d33a15a482be.1688569987.git.alina_yu@richtek.com>
 <d3308334-aa91-f265-2469-8a6fbc727798@kernel.org>
 <20230706103040.GA32138@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230706103040.GA32138@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 12:30, Alina Yu wrote:
>>> +
>>> +      regulator-state-(mem):
>>
>> That's not a pattern.
>>
> 
> Should I revise that like this ?
> 
> patternProperties:
>   "^regulator-state-mem$":

It's still not a pattern, but a regular property, so keep it in properties.

I don't even understand what you want to say with this. You put it
outside of any regulator. I don't think this was tested at all. :(

> 
> 
>>> +        type: object
>>> +        additionalProperties: true
>>
>> Why?
> 
> Does "additionalProperties: true" mean I need to define my own property ?

No.

> If yes, I misunderstood additionalProperties as properties like "regulator-on-in-suspend" or "regulator-mode".

Please open recent regulator bindings and use them as example.

> 
>>
>>> +        properties:
>>> +          regulator-on-in-suspend: false
>>> +          regulator-mode: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - regulators
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      rtq2208@10 {
>>
>> Node names should be generic. See also explanation and list of examples
>> in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
> 
> I'll modify the node name to 
> 
> regulator@10


If this is PMIC, then "pmic" as name.

Best regards,
Krzysztof

