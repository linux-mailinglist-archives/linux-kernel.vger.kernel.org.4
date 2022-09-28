Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432565ED6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiI1H60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiI1H6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:58:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76B4454E;
        Wed, 28 Sep 2022 00:58:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A9136601EB5;
        Wed, 28 Sep 2022 08:58:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664351902;
        bh=e/mPVgGURMWxGYEIW4p02kZFhXBi5nXgg4F5k0bpy54=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TYk/3bPREZ0ETnF9mVPkIiNQOTPa+nZHbNZ9uVIoH3AMlqd4wowy7Cq6bygwyXOEh
         Jffp9pu0jq7qJ4MUQb/0MUQTYYrMcxuFiwio7uXbmueISdOytGiLHcJeKm97yGNQv9
         o5Qp5bgILa/SPkA3eQJRxIBMu+hIrHi8rClVnLbm2fq8CJB7tsCnwnJ5xmgj8ET4DQ
         npVFafytKPtTkcC0C6H3uDcPzpXkFpepY5O58WOI1qQ6aGC6WSvZKbCuU5D63wMtCH
         VJHLUZK+nuOT+S5aTH05Q2HyNxu7MWCMoxAjDYbGrzBaWnSZpBi9QPuiu3RZcaJ759
         iptJdJSKqXaRA==
Message-ID: <68e1c8b0-04cf-acf8-b6b6-97d9eb8a7c4a@collabora.com>
Date:   Wed, 28 Sep 2022 09:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220926105047.19419-1-allen-kh.cheng@mediatek.com>
 <4d1e8600-f73d-8d2b-2e7a-1b75be7624bd@collabora.com>
 <d71334b63427df73d01ff1b9fa4d2dec94ad9c95.camel@mediatek.com>
 <05ed341b-2db3-620f-7a70-dcebfaa66f1a@collabora.com>
 <172e10ee-22fd-ccec-1a5a-7bd0a29dbfc4@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <172e10ee-22fd-ccec-1a5a-7bd0a29dbfc4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 09:04, Krzysztof Kozlowski ha scritto:
> On 27/09/2022 12:17, AngeloGioacchino Del Regno wrote:
>>>>
>>>
>>> Sorry, my bad. I alsways run `make dtbs_check` to confirm dtb with
>>> bindings. I just think we didn't limit node names in mtk-vodec
>>> bindings. I will pay attention next time.
>>>
>>>
>>> Since currently the vcodec lat and core nodes are absent from the mtk
>>> dts, do you think the child node name should be changed to something
>>> more general (ex: video-codec) in mediatek,vcodec-subdev-decoder
>>> bindings?
>>
>> The video codec is mt8192-vcodec-dec, while the other nodes are describing
>> the VPU instances (and/or vpu cores)... I'm not sure.
>>
>> Krzysztof, please, can you give your opinion on that?
>>
> 
> What's the difference between them? I understand parent device is entire
> block of consisting of multiple processing units? If so, video-codec
> actually could fit in both places. But feel free to call it a bit
> different (video-codec-core, video-codec-lat, processing-unit, even
> something less generic). Sometimes it's tricky to find nice name, so I
> wouldn't worry too much in that case. Just not "mt8192-vcodec" :)
> 

The parent device is the entire block consisting of multiple processing units
and has "global" control registers; children are LAT(s) and processing cores.

 From my understanding, the processing cores are physical cores of one big VPU
and, depending on the actual (current gen) SoC, the VPU may have one or two
cores.

Right now, the bindings want vcodec-latX@addr, vcodec-coreX@addr (where X is
a number, like vcodec-core0, vcodec-core1) but, in my opinion, changing that
to video-codec-lat@addr and video-codec-core@addr would be more descriptive.

...Or should we simply leave the bindings as they are and just go with the
abbreviated "vcodec-(hwtype)" names?

Regards,
Angelo
