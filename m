Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72EE61F631
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiKGOgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiKGOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:36:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0443192;
        Mon,  7 Nov 2022 06:36:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BEACB811E9;
        Mon,  7 Nov 2022 14:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858FBC433B5;
        Mon,  7 Nov 2022 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667831790;
        bh=m9xqrpdjytPm9RXLg7Gj85tY2WF2XYvRdNUJgi2UJi0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e+kCiuyYrd5fkBBNHVr4CtpTwmImmiM1Pf9Vf35Asqk4sT8SrfCowuYnYbF6VWMEa
         X3NwkrvbmVMboJXCq7SYAEJvWBXqZL7uoG1RbbqMLa77lXmHWLQoiutFIACiCHPqjP
         KM4JtmDfUJx6/h5Eq6SS2mbjiO+pk8wiGyrAO+TS2x6wvOUUxHL3mtFEfQbsbVrIup
         /Fonw2/Q1iQSuOLJqBwHfkcbIG0HF6CoOuXyIsbyBO+vctICzsVo+0G1b5IC0HYTa1
         pnyEzQZxhCp8uQKv7jCjDpgFsseRM9w+SQq3jQFFDJZu6MIHpB3kbmBn/zthu348EA
         a2BBrvUnyMD1w==
Message-ID: <7d2c43b7-1507-7c30-27f7-3081c6ec77ba@kernel.org>
Date:   Mon, 7 Nov 2022 16:36:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] dt-bindings: interconnect: Remove required reg
 field
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190520.4004264-1-quic_molvera@quicinc.com>
 <20221026190520.4004264-2-quic_molvera@quicinc.com>
 <a214f513-fe28-2096-c2b0-2107e97f3ce2@linaro.org>
 <64d0e5ef-fd36-6f25-2c39-00e8e1346af7@quicinc.com>
 <1a7fd1fd-4f0d-bec3-ddd5-7c6a99a2ab01@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <1a7fd1fd-4f0d-bec3-ddd5-7c6a99a2ab01@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2.11.22 23:11, Krzysztof Kozlowski wrote:
> On 31/10/2022 19:29, Melody Olvera wrote:
>>
>>
>> On 10/27/2022 8:29 AM, Krzysztof Kozlowski wrote:
>>> On 26/10/2022 15:05, Melody Olvera wrote:
>>>> Many of the *-virt compatible devices do not have a reg field
>>>> so remove it as required from the bindings.
>>> and some virt have it... This should be probably separate binding or if
>>> the list is small - allOf:if:then.
>> I attempted this; however I'm still seeing failures in dtb_check. I've added this
>> to the binding; does this look correct?
>>   allOf:
>>     - $ref: qcom,rpmh-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,qdu1000-clk-virt
>> +              - qcom,qdu1000-mc-virt
>> +
>> +    then:
>> +      required:
>> +        - compatible
> 
> No, because we talk about reg, not compatible. You should not require
> reg instead for some compatibles... but then the schema is getting
> complicated.
> 
> It's difficult to give you recommendation because I do not know what are
> all these "virt" interconnects. Why some have unit address, why some do not?

My understanding is that the "reg" property is required for the NoCs that have
registers for controlling the QoS settings for the ports from Linux side.
Other NoCs might be controlled by some remote processor and direct access from
Linux may not be possible, so they do not have unit address and are outside of
the soc DT node.
Do we need to strictly define when exactly the "reg" property is required,
can't we just mark it as optional?

Thanks,
Georgi
