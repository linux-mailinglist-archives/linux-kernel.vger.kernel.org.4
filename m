Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8606ACAC9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCFRi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCFRi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:38:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278DA66D28;
        Mon,  6 Mar 2023 09:38:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA866102A;
        Mon,  6 Mar 2023 16:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EC0C433EF;
        Mon,  6 Mar 2023 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678118944;
        bh=+uB7D1gwrBQ8/0Era4Cxa/LZ06zO3DpKV4QfZb0Dfug=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bbJqmerTmVbHwb+bJzKgtxIiT+sVvc/Zs7PuTNgBt9hsoaa9uM1MKDPSa5FPt7Wva
         YoZ6q1ThDQ764DoX6GExQ8WxY39xTy1yk2qHe9Of6HC/KyrVjOp0PpMjSNrENXfOay
         5kx4n69Jv4NdDEENm77Jy205wOT4RS0GD20pHAqTOHqYdOQRzsira9uoDTS78+X9gv
         8P3dI2elnyk3j5FOeTEoRYmdzTLvkNaF2K/IvhL2Y3zxuNNjHqQP/LWEEVgZiFLPkH
         0szMqP4+dD9YHGgG4STS3XZt/cLakker2p5Q5sevSOeceKIzSKz6VhmyygACvoCqEm
         aF4NHHE5OnTKg==
Message-ID: <6247adab-2004-5159-69ca-9e1dd30f4c38@kernel.org>
Date:   Mon, 6 Mar 2023 17:09:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Content-Language: en-US
To:     Marius.Cristea@microchip.com, jic23@kernel.org
Cc:     devicetree@vger.kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220123232.413029-1-marius.cristea@microchip.com>
 <20230220123232.413029-2-marius.cristea@microchip.com>
 <c38afa67-d24f-0390-f18a-81bee15b7eca@kernel.org>
 <20230225171723.15e822ec@jic23-huawei>
 <2f1a14522a7a8d46e3b037a285af4c3dd9b17cbc.camel@microchip.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2f1a14522a7a8d46e3b037a285af4c3dd9b17cbc.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 14:53, Marius.Cristea@microchip.com wrote:
> 
> Hi Jonathan,
> 
>    Thank you so much! I'm happy to contribute to IIO.
> 
> I will remove some section because I agree with the propose solution.
> For the rest I will comment below..
> 
> 
> 
> On Sat, 2023-02-25 at 17:17 +0000, Jonathan Cameron wrote:
>>>> +
>>>> +  microchip,samp-rate:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: Sampling rate for all device's channels.
>>>
>>> What are the units? rate is usually in hz, which should be
>>> expressed in
>>> unit suffix (property name)]
>>
>> It's unusual for sampling rate to be a property of the hardware and
>> hence
>> suitable for DT binding. Normally we make this a userspace control
>> instead.
>> If there is a reason for doing it from DT, that wants to be mentioned
>> here.
>>
> 
> Here I could change it into the datarate (as in
> iio/adc/ti,ads1015.yaml). The units are samples per second. My
> intention was to be alingned with the datasheet.
> 
> My intention was to let the user configure the sample rate as soon as
> posile during the startup (the PAC device's own power consumtion will
> increase with the sampling rate - default the chip will start with the
> maximum samples per second).

Then maybe the default should be just lowest rate and user will adjust
it further? Since this is user-space knob, why this should be even
configurable per board?


Best regards,
Krzysztof

