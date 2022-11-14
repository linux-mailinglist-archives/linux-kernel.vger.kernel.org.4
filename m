Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6027F627B55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiKNLAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiKNLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:00:38 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE61EAD5;
        Mon, 14 Nov 2022 03:00:36 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE6ooIt022105;
        Mon, 14 Nov 2022 05:00:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=4n144kVtf2dEVsXNdNFwI0imfVA4lO02wEhjfD/KZYA=;
 b=PJyfCAshH0UMyLjuW85E138MsRm3cEOfWi/R0bdoZF9Oz9MpQSjGIBuIPmdA+bm6RDIJ
 JyuboDYhiwZPYvTzNTqk6CD0FgD0geBckCf63XC0PzYjjqlM+B9f72IBgBH61kzhr2cw
 6SjTpZmKyp3PJdtaxjqBSxRCkZSxQTnmKqSWKpIRQXt0/LGsOaAFOf6bXtR2zY9awir4
 DFZRahQj3T8pNAfnfb5pZ4ctas6rjjG0i5i0l5k2b4ZItXRyf8hNxRLV+evYlBTvNrNC
 9fSerACtKuX11DaBX70vmckDSUTjYG+BlaOfkWXn/FAXUViUG4IfGgBPFWF8P0aDyR8K nQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kt9s6t227-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 05:00:12 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Mon, 14 Nov
 2022 05:00:08 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Mon, 14 Nov 2022 05:00:08 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EF411477;
        Mon, 14 Nov 2022 11:00:07 +0000 (UTC)
Message-ID: <8bd6b864-ca58-022d-220d-328121f7e7dd@opensource.cirrus.com>
Date:   Mon, 14 Nov 2022 11:00:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 11/12] dt-bindings: sound: Add Cirrus Logic CS48L31/32/33
 codecs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-12-rf@opensource.cirrus.com>
 <5f012334-1815-2ef6-7dc0-08b4d60f754f@linaro.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <5f012334-1815-2ef6-7dc0-08b4d60f754f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sAdoFkTZXxH-3H9BFHYMclRCPXS6MdO6
X-Proofpoint-ORIG-GUID: sAdoFkTZXxH-3H9BFHYMclRCPXS6MdO6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 08:45, Krzysztof Kozlowski wrote:
> On 09/11/2022 17:53, Richard Fitzgerald wrote:
>> Codecs in this family have multiple digital and analog audio I/O that
>> support a variety of external hardware connections and configurations.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   .../bindings/sound/cirrus,cs48l32.yaml        | 96 +++++++++++++++++++
>>   include/dt-bindings/sound/cs48l32.h           | 25 +++++
>>   2 files changed, 121 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
>>   create mode 100644 include/dt-bindings/sound/cs48l32.h
>>
>> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
>> new file mode 100644
>> index 000000000000..70fb294c6dc1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
>> @@ -0,0 +1,96 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/cirrus,cs48l32.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Cirrus Logic CS48L31/32/33 audio CODECs
>> +
>> +maintainers:
>> +  - patches@opensource.cirrus.com
>> +
>> +description: |
>> +  This describes audio configuration bindings for these codecs.
> 
> Don't start with "This". Instead describe the hardware.
> 
>> +
>> +  See also the core bindings for the parent MFD driver:
>> +
>> +    Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> 
> Same comment as for pinctrl patch.
> 
>> +
>> +  and defines for values used in these bindings:
>> +
>> +    include/dt-bindings/sound/cs48l32.h
>> +
>> +  The properties are all contained in the parent MFD node.
>> +
>> +properties:
> 
> Missing compatible. What's the point to organize bindings like that? The
> schema on its own does nothing - does not match anything.

Do you mean child drivers should not share the MFD node? Or do you mean
that if they share the MFD node all the child driver bindings should be
documented in the MFD schema instead of having a sub-schema for each
class of hardware functionality?

I'm certainly willing to collapse all the bindings into a single MFD
schema yaml. For this driver we followed the same structure that was
accepted for madera (and there was some discussion when we upstreamed
madera about how the bindings should be organized which resulted in
them being changed). We pretty much assumed that the safe bet was to do
the same that was accepted by the maintainer last time around.
