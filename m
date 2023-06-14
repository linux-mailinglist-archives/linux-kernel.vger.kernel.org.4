Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34772F7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbjFNIWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbjFNIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305019A7;
        Wed, 14 Jun 2023 01:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0486263960;
        Wed, 14 Jun 2023 08:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22C5C433C0;
        Wed, 14 Jun 2023 08:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686730969;
        bh=ds0InahBENDkLdQRNqole1hIItw6ZE64nLpD0bN75NU=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=eqjB+1fK8Dj1m8eAaoTnhqm7ZoEqmJViiXfHP+AoFHFvWjCzzw1IdlKjNrY9jEPmB
         XaPblsq1Jcv/yXTIlzL8Ldwh1JLNy8xPNPcAz+clV+AEC3acGc6aCbDQJAvDa7GI/r
         8VBY2ifKyB8dK0rUzJbJbB7W4zkLdekl7rhju5Fn4yTJyMZ97Y/H26dYBbD0LQhhfv
         B1EUDdoGokBbkk953RIBq9NrKklY37pIzGlV0JfFX3vfEA8Xh1o0gSVaG27Lv/GWc/
         M98pGOg8Kz6andBGwbKb+vI3M0zkh3dcxoJXEr0VcZTUmwJxbv4efU2+vI4gBEGsqc
         ZlPUs5IYR8SIQ==
Message-ID: <ea7b94b6-37fc-1352-9849-66a49dd1b39f@kernel.org>
Date:   Wed, 14 Jun 2023 10:22:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/7] ASoC: dt-bindings: mediatek,mt79xx-wm8960: add
 mt79xx-wm8960 document
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
 <20230612105250.15441-7-maso.huang@mediatek.com>
 <7bf1395a-eba8-fe27-a359-9c50af7add2a@kernel.org>
 <c87eadd9fc8d0ef9dc4582493e540f0b311e06eb.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <c87eadd9fc8d0ef9dc4582493e540f0b311e06eb.camel@mediatek.com>
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

On 14/06/2023 09:40, Maso Huang (黃加竹) wrote:
>>> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
>>> ---
>>>  .../sound/mediatek,mt79xx-wm8960.yaml         | 53
>> +++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>  create mode 100644
>> Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml 
>> b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml
>>> new file mode 100644
>>> index 000000000000..26b38bb629da
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-
>> wm8960.yaml
>>> @@ -0,0 +1,53 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>> http://devicetree.org/schemas/sound/mediatek,mt79xx-wm8960.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek MT79xx ASOC sound card with WM8960 codec
>>
>> What is a MT79xx ASOC? Is it some specific SoC name? What does "A"
>> stands for in SoC? XX also looks odd, I thought Mediatek uses only
>> numbers.
>>
> 
> I'll use mt7986 instead of mt79xx in v2 patch.
> And ASoC means ALSA SoC.

ALSA is Linux stuff, so does not belong to bindings. I have no clue what
is "ALSA SoC" (as SoC means System on Chip).

Please describe real hardware not Linux or your configuration or some SW.


Best regards,
Krzysztof

