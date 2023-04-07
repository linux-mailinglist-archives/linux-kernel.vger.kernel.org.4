Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2516DA92B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjDGHAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDGHAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D664C7DBF;
        Fri,  7 Apr 2023 00:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AB7F64EAC;
        Fri,  7 Apr 2023 07:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E739C433D2;
        Fri,  7 Apr 2023 07:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680850820;
        bh=VFA8ITCiqTNajarcKMl+01NeMpRZsva1SwCw5XzW27Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QV9D4GKa0dbJi7sF+WFAxm1nuEYBdZprzvmMfSGvkWzX3/d/xMJYcR2v9kbconuZH
         n0YzZXhJbYsCDgrwVlpoFyLiCI9h6uM42QsfxYOLRq+9lc6Vyj2wMu6Hljt+o18pIe
         6ShS0Gj+XIjdLywM8E32XFl+/7MIPzHJB89JKoR1vMuMBKHPIFqVY6JqrQYEmjMYj8
         0qL1hHEx+i9fP+krOJsQe8waMjxtE2tXausFIZkGOqhMuQT9r7ZlNthPMDkbvhGeSt
         37KKydxY28DCbOG2SLMvz+zwKt08NFJsDBuwz9E+qy0GD7BriY6JD+RK2/3TQklyFp
         K36iLTnnWEKyQ==
Message-ID: <8206b5b2-20bf-1264-7dd8-08f14abd0729@kernel.org>
Date:   Fri, 7 Apr 2023 09:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
 <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 21:55, Konrad Dybcio wrote:
> 
> 
> On 6.04.2023 19:45, Krzysztof Kozlowski wrote:
>> On 05/04/2023 15:49, Konrad Dybcio wrote:
>>>
>>>
>>> On 5.04.2023 15:47, Rob Herring wrote:
>>>> On Wed, Apr 05, 2023 at 07:22:40AM -0500, Rob Herring wrote:
>>>>>
>>>>> On Wed, 05 Apr 2023 12:48:34 +0200, Konrad Dybcio wrote:
>>>>>> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
>>>>>> use 'reg' to point to the MPM's slice of Message RAM without cutting into
>>>>>> an already-defined RPM MSG RAM node used for GLINK and SMEM.
>>>>>>
>>>>>> Document passing the register space as a slice of SRAM through the
>>>>>> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>>>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml   | 12 +++++++++---
>>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>
>>>>>
>>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>>
>>>>> yamllint warnings/errors:
>>>>>
>>>>> dtschema/dtc warnings/errors:
>>>>> Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dts:22.35-38.11: Warning (node_name_vs_property_name): /example-0/interrupt-controller: node name and property name conflict
>>>>
>>>> Looks like this is colliding with the example template which has to 
>>>> craft an interrupt provider for 'interrupts' properties. Either adding a 
>>>> parent node or using interrupts-extended instead should work-around it.
>>> Check the devicetree-org issue linked in the cover letter, please!
>>>
>>> I suppose wrapping it in a parent node could work as a temporary
>>> measure, but since it belongs outside /soc, I'd have to make up
>>> a bogus simple-bus, I think.
>>
>> I don't think your issue in dtschema is accurate. As Rob suggested, you
>> need wrapping node.
> I don't really know what kind.. I can add something like:
> 
> rpm {
> 	compatible = "qcom,rpm", "simple-mfd";
> 
> 	mpm: interrupt-controller {
> 	...
> };
> 
> And then only introduce a very simple YAML for "qcom,rpm"
> describing what it is and documenting the compatible.
> 
> Or I can push it under rpm-requests{}.

It does not matter really what kind of wrapper. Can be:

sram {
    interrupt-controller {

Best regards,
Krzysztof

