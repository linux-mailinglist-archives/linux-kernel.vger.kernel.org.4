Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB768DD40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjBGPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBGPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:46:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436793B0DE;
        Tue,  7 Feb 2023 07:46:10 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D0686602077;
        Tue,  7 Feb 2023 15:46:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675784768;
        bh=tt5lrHlIVInMq27wdZG33n5kYVhMCWLk9XkuAdem+b0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SFSUuLCrMTSOqxVXNcSnMi/bv6tL1Zrzdke2be//6XLQKUihpkqdmp+027ZFDz2sZ
         AtmS/ua3flrVRaKtuN/U8HPiolzhl8xniuQ2gz4NfEhsikXX3TtgQu+F0pV100wDnI
         yPHfIWGiFXNMbvx56QMNdSu+WdwPh78FQgEcQ+URT74uc+3ThHudOGt2zH2LIrp6Mb
         k0Cwglw9oDerHuoldUOsuaFNC5WB7mtTNu8IvcAOlPGAGkSNDKj0D3vm22Xt6UqA0z
         5vT+MmZ7q98eWQr41f9vBZaxi76qATAKa+MmcJOpMs69TmNJflZ5FvDprkt0Qk0pXa
         OSX+K1mSR8Ysg==
Message-ID: <e7257f9a-86c5-74e8-c538-6f6d2ba13274@collabora.com>
Date:   Tue, 7 Feb 2023 15:46:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] Documentation: cs35l41: Shared boost properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-3-lucas.tanure@collabora.com>
 <44faeca1-94c9-4423-d87a-03d80e286812@linaro.org>
Content-Language: en-US
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <44faeca1-94c9-4423-d87a-03d80e286812@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-2023 10:42, Krzysztof Kozlowski wrote:
> On 07/02/2023 11:40, Lucas Tanure wrote:
>> Describe the properties used for shared boost
>> configuration.
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
ack
> 
>>
>> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
>> ---
>>   .../devicetree/bindings/sound/cirrus,cs35l41.yaml     | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> index 18fb471aa891..6f5f01bec6f1 100644
>> --- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> @@ -85,11 +85,20 @@ properties:
>>         boost-cap-microfarad.
>>         External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
>>         enable boost voltage.
>> +      Shared boost allows two amplifiers to share a single boost circuit by
>> +      communicating on the MDSYNC bus. The passive amplifier does not control
>> +      the boost and receives data from the active amplifier. GPIO1 should be
>> +      configured for Sync when shared boost is used. Shared boost is not
>> +      compatible with External boost. Active amplifier requires
>> +      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
>>         0 = Internal Boost
>>         1 = External Boost
>> +      2 = Reserved
> 
> How binding can be reserved? For what and why? Drop. 2 is shared active,
> 3 is shared passive.
2 Is shared boost without VSPK switch, a mode not supported for new 
system designs. But there is laptops using it, so we need to keep 
supporting in the driver.

> 
> Best regards,
> Krzysztof
> 

