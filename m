Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF27629DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKOPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiKOPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:34:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25242EE30;
        Tue, 15 Nov 2022 07:34:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E68606602A2D;
        Tue, 15 Nov 2022 15:34:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668526477;
        bh=UsrtOUGmm9yQjbTKRfPm8z8pCEAuKpMkDN99XHev6Wg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jBwVOnmaeqNEw6rRKembroMAaHqQ39JcG2R2PUJ77BocmGy4j1V7sWHDBOGy3b8Q1
         EQzDgQ5zda3rsrxyhsRdzcOe+eJ/KdRexk09gOkMh2rifI0htoA26J2V7U9rgv6NmB
         fNE34JtGUxDr3R6QjoV0kH5WvoD4pHD75yauxdG8SypkfTSPTwXhMOKcPSYPVWRkvY
         LRT9wUn1Vpn1H3cUWwwhL74j0j+GJObQaXzOi3dPpOK4KDbmHi9ojTB3JfuLu3vVbJ
         F2bo5ObrJeqFOpf8qqpRhpck52o9yNZv+ej3lh3kNGUTVhan7rK1LdQmbGluKiHaV0
         9RtdJy+eolNkQ==
Message-ID: <f2260dea-6f05-6ca9-d241-2ba986f4ca45@collabora.com>
Date:   Tue, 15 Nov 2022 16:34:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     marijn.suijten@somainline.org, konrad.dybcio@somainline.org,
        kernel@collabora.com, andersson@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org
References: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
 <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
 <166758411781.2066027.6365889663189109123.robh@kernel.org>
 <160cb3fc-176e-bc0e-1bff-9334478af8ec@collabora.com>
 <342d556a-e710-590c-3c81-fcc60bbaa6e7@linaro.org>
 <3e9deab6-58ca-3a58-5f06-c1e4d181bc94@collabora.com>
 <5c0dfcad-956d-e3cd-fd06-7671b85c4ae7@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <5c0dfcad-956d-e3cd-fd06-7671b85c4ae7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/22 16:16, Krzysztof Kozlowski ha scritto:
> On 15/11/2022 15:44, AngeloGioacchino Del Regno wrote:
> 
>>>>> Please check and re-submit.
>>>>>
>>>>
>>>> I'm unsure about what I should do about this one.
>>>> This is a power-controller, but does *not* need any #power-domain-cells, as it is
>>>> standalone and doesn't require being attached to anything.
>>>
>>> power-domain-cells are for power domain providers, not consumers. The
>>> generic binding expect that nodes called power-controller are exactly
>>> like that.
>>>
>>> Solutions could be:
>>> 1. Rename the node to something else. I cannot deduct the type of the
>>> device based on description. What is "sequence ID" and how is it even
>>> closely related to power control?
>>
>> This uC is mainly controlling DCVS, automagically plays with voltages for
>> each ramp up/down step and from what I understand also decides to shut down
>> or bring up *power* to "certain clocks" before ungating (CPU related, mainly
>> big cluster).
>> This also interacts with LMH - setting the LMH part makes it possible to
>> later use CPR (otherwise CPR errors out internally and won't start, as it
>> requires this controller, SAW and LMH to be set up in order to work).
>>
>> What I've seen is that without it I can't bring up the big cluster at all,
>> not even at minimum frequency, as the HF2PLL (a clock source for that cluster)
>> will not power up.
>> All it takes is to initialize these params and start the controller, then
>> everything goes as it should.
>>
>> If you're wondering why my explanation may not be particularly satisfying,
>> that's because downstream contains practically no information about this
>> one, apart from a bunch of lines of code and because this controller is
>> just a big black box.
>>
>>>
>>> 2. Narrow the node name in power-domain.yaml which would require changes
>>> in multiple DTS and bindings.
>>>
>>> 3. Do not require power-domain-cells for power-controllers, only for
>>> power-domains.
>>>
>>
>> Solutions 2 and 3... well, I don't think that this would be really feasible
>> as I envision this being the one and only driver that will ever require
>> that kind of thing.
>> Also, this programming was later moved to bootloaders and the only SoCs that
>> will ever require this are MSM8956/76, MSM8953 and.. I think MSM8952 as well,
>> but nothing more.
>>
>> Even if I can imagine the answer, I'm still tempted to ask: can we eventually
>> just name it ramp-controller@xxxx or qcom-rc@xxxx or something "special" like
>> that to overcome to this binding issue?
> 
> So maybe "cpu-power-controller"? This should already help for this warning.
> 

Agreed. Thanks for the advice!

Sending a v3 asap!
