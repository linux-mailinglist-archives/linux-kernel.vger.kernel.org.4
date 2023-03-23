Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A96C654B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCWKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCWKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:38:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD238661;
        Thu, 23 Mar 2023 03:36:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7961B6600880;
        Thu, 23 Mar 2023 10:36:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679567795;
        bh=jIgvWhgm+9PSBUraP9OHdAeWySoS60VL5lcO1FVaiPE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZgAFdYU6N/IMlq31x3w8mwWPvHi+WpJRNzhP7yxXN0vyJ62hCLzwJKfrKgaGBlsw1
         AuxjcEYNFgW8RxvPYBvVikeb1WB/iUWR4cz0Uf84/qfnpLjzMS0cU1FL9OEVX9Sn9g
         cAR3jceK+HJUkOu240zcRAHFWFbSJQ+WDpcO43Nd/5lbqbnRW65o/IN2ckfYYaZaG2
         HYmpkAfydxohZatq9HdVqQwKsKo7yKsOZ8CjA4Rq7HmXryG4Pi8iqzImACS9t6Vb3W
         W9OEPEh1NVpxd3ohFqamstu2DKfX7KxmIrY8abPHOhM9WB2aQzTXYUgx4g/StTcCKf
         yNemXg1Cq7gWw==
Message-ID: <e90dcc00-7685-befd-2a93-aed4ea8b1b2a@collabora.com>
Date:   Thu, 23 Mar 2023 11:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <b4fc6bd8-e300-0f40-4216-8b99589c21cc@gmail.com>
 <895abaa2-5fd3-9928-4e53-86ce160fbad8@collabora.com>
 <CAGXv+5EPVhH-O+ZdoLeW4OZVcEtS824oracmu3jHTa8k-tEU0A@mail.gmail.com>
 <e5302c3e-f985-b020-5f8c-fba876768eaf@gmail.com>
 <CAGXv+5FR5unBbdp0MDZY1TtSMoTtxzi2F4tO=3qZsh=3b3Ru9w@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FR5unBbdp0MDZY1TtSMoTtxzi2F4tO=3qZsh=3b3Ru9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 10:27, Chen-Yu Tsai ha scritto:
> On Thu, Mar 2, 2023 at 7:28 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>> On 02/03/2023 11:11, Chen-Yu Tsai wrote:
>>> On Thu, Mar 2, 2023 at 6:10 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 02/03/23 10:36, Matthias Brugger ha scritto:
>>>>> Series looks good but from my understanding has a dependency on:
>>>>> [PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support
>>>>> (https://lore.kernel.org/linux-mediatek/20230228102610.707605-1-angelogioacchino.delregno@collabora.com/)
>>>>>
>>>>> Did I get that right?
>>>>>
>>>>
>>>> Yes you got it right - without the mentioned series, this one will do nothing
>>>> at all (and will also fail binding checks, as the bindings are introduced in
>>>> that other series).
>>>
>>> Please also let me test them on MT8183 and MT8186 before merging them.
>>>
>>
>> Of course, I'll wait for your tested-by tags then.
>> Thanks for testing!
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> on MT8183, MT8186, MT8192 and MT8195 Chromebooks.
> 

Hello Matthias,

The Panfrost driver patches were just queued to drm-misc-next [1], can you please
pick this fully reviewed and fully tested series, so that we get them both to land
at the same time?

[1]: https://patchwork.kernel.org/comment/25265910/

Many thanks!
Angelo
