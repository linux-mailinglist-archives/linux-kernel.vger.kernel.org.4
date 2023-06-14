Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6CC72F4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbjFNGgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbjFNGft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E01FE8;
        Tue, 13 Jun 2023 23:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02FE261A17;
        Wed, 14 Jun 2023 06:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95741C433C0;
        Wed, 14 Jun 2023 06:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686724496;
        bh=u5PKSpPmNVmi2EPSJSrzJB16SUgI6GfaClALRkeVqq0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=rHhsIlojYnPPn7FESMmYDbDhLHV3oLskENEUwFsoKGAc8eS2NTb4i0DxSU+zKRarY
         xiw1/cHuwvDXvAdWnYvmBFV+OOxaha57M1NH1/bEO5zsLeN2WdMsPWFjgyiaS9cTRL
         IBJXrjevWGQQFelietXH4JGHnjcMF2JJc+bdIC6ia6vRgfClri+68ItfUt4bBpCNpU
         gTyM3R83v2Y2AcOmUztBQt+dgMtkfxI568C27/qhAjrG0Jl+HIQWkTrOulkpbFS2gI
         3DDhYMxSS+Vzm5qobXZ326T8c4DzdGnHsQEdBNhpCH7lpNCTHpRsQu1bwJUNPNgDyT
         ZB0c65R7XH8Cw==
Message-ID: <d6289232-6276-a2d3-c059-1edcef6a1b6f@kernel.org>
Date:   Wed, 14 Jun 2023 08:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe
 document
Content-Language: en-US
To:     =?UTF-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
 <20230612105250.15441-8-maso.huang@mediatek.com>
 <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
 <14913cbb87981eed6f8b72f9e659ed3e25958320.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <14913cbb87981eed6f8b72f9e659ed3e25958320.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 05:17, Maso Huang (黃加竹) wrote:
> On Tue, 2023-06-13 at 10:51 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  
>> On 12/06/2023 12:52, Maso Hunag wrote:
>>> From: Maso Huang <maso.huang@mediatek.com>
>>>
>>> Add mt79xx audio afe document.
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary
>> people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you
>> base
>> your patches on recent Linux kernel.
>>
> 
> Hi Krzysztif, 
> 
> Thanks for your review. And sorry for missing some necessary
> maintainers.
> What's your suggestion, resend these patches again with them, or add
> them back in v2 patch?


You need to fix the patch anyway, so use get_maintainers.pl in v2. I
don't understand why you Cc here many unrelated people but not the
actual maintainers which get_maintainers.pl asks you to Cc!

> 
>>>
>>> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
>>> ---
>>>  .../bindings/sound/mediatek,mt79xx-afe.yaml   | 102
>> ++++++++++++++++++
>>>  1 file changed, 102 insertions(+)
>>>  create mode 100644
>> Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml
>> b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml
>>> new file mode 100644
>>> index 000000000000..11ef1cfdf49b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-
>> afe.yaml
>>> @@ -0,0 +1,102 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/mediatek,mt79xx-afe.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek AFE PCM controller for MT79xx
>>
>> 79XX sounds weird. Are you sure you are not using wildcards (which
>> are
>> not allowed)?
>>
> 
> We would like to use mt79xx for mt7986/mt7981/mt7988 series.
> Or is it better to just use mt7986 for this series?

You cannot use wildcard. Get some internal review of your patches prior
to submission to mailing list.

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst

> 
>>> +
>>> +maintainers:
>>> +  - Maso Huang <maso.huang@mediatek.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: mediatek,mt79xx-afe
>>> +      - items:
>>> +          - enum:
>>> +              - mediatek,mt7981-afe
>>> +              - mediatek,mt7986-afe
>>> +              - mediatek,mt7988-afe
>>> +          - const: mediatek,mt79xx-afe
>>
>> I already saw AFE, why it cannot be part of existing bindings?

Can you answer this?

>>
>> This list is odd. 79xx, 7981? So it is wildcard?
>>
> 
> Yes, it is wildcard for mt7986/mt7981/mt7988 series.
> Is it better to just use mt7986 for this series? 

No wildcards.


Best regards,
Krzysztof

