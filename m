Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131186E20BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDNK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:28:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D559E6;
        Fri, 14 Apr 2023 03:28:39 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 914816603222;
        Fri, 14 Apr 2023 11:28:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681468118;
        bh=O6UuvcllmyzTDSJc0UaOYAOQKjJ0Wjevnx+e8DkBSeM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K7R8qjegIdkwqF/7w5tJJg9sYdFwlpygfiAAU98C2JMgVK6z54cj3NGBb+Dh+a7Dj
         bhVZ5Ysb9z1WPSdWUKinHqi0zB15C4bAajyFYITfw2htlrg+PD5kZT8oTybHYXR3ZW
         vLP+6gasJtW94RFPOjLSrRk2nbaHoQxj1BdXWRJ1MI3FI+Piy78/Vbx1UxxGHXqGWj
         9oc021CUl1y9zyStzyjMhgp27PeAsj1CUsjOv2fDk8Uhchmw4gWvRCI8CBKqgzCxm6
         I0585IrwHpupbTWjRSNelofMwMGEKVD1G1VDSQJhc5FC16uoar+hXprJwZdT5nHWtl
         I6OnS2YrUviZA==
Message-ID: <5e085030-39a6-5aec-3c66-bb647b9e8da3@collabora.com>
Date:   Fri, 14 Apr 2023 12:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 22/27] arm64: dts: mediatek: mt6795: Copyright header
 additions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-23-angelogioacchino.delregno@collabora.com>
 <6fc26e38-ac45-b4a3-32f0-2bae686371db@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6fc26e38-ac45-b4a3-32f0-2bae686371db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/23 10:46, Krzysztof Kozlowski ha scritto:
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>> I have added more than 800 lines to this devicetree: adding myself to
>> the copyright header.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> index 29ca9a7bf0b3..a4c950b65006 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> @@ -2,6 +2,9 @@
>>   /*
>>    * Copyright (c) 2015 MediaTek Inc.
>>    * Author: Mars.C <mars.cheng@mediatek.com>
>> + *
>> + * Copyright (C) 2023 Collabora Ltd.
>> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Copyright is a result of significant changes, thus it is a part of
> commit(s) making these changes. Adding copyrights in separate commits
> looks like you are spreading them unjustified. Squash it.
> 

Ok, I'll squash it in one of the commits of this series.

Regards,
Angelo
