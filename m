Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090266ADA7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCGJhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCGJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:37:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51015372C;
        Tue,  7 Mar 2023 01:37:19 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C39C6602FE5;
        Tue,  7 Mar 2023 09:37:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678181838;
        bh=OeykOkW8+/Iy30seH866GojCFZ7qr8owGJJxiI7/Wkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XrR7KDyD6Nraz6gTIYm2cS67mhiONhfQmb3R8S7Te3eUoNyNQTpUpji8Ym0IH84I3
         oJUk4xXckeFwQqexpD5MtXFrYbHugJbiMmVzdIHz3fwZK/sELHsj6YVWBL+kLTr0Tv
         Ij0okU3h/h2/KDsPC6I36GRmCmxHTPl/I8ljysdlbmbwMuuMyHIz0UQIA3ccSTT5xr
         HuLInCtlRJ5bcS3qOtCjnlht6bMAk6PH3jrp1rBvnRJMkd7mDBnSCktuvPoz+p5pNQ
         lBJCxuhyQbYWe8Y8ewbDD47KFZNGsSbrezAeA9olmgr8QGf1q+/1a6cRtZM5PFMuLj
         Kp4N+2YlprhXQ==
Message-ID: <81d9c330-9b8a-0fd6-149e-30c77629650a@collabora.com>
Date:   Tue, 7 Mar 2023 10:37:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
> BTW, Angelo, I see that Panfrost keeps the GPU regulator enabled, but
> the power domains, and thus the SRAM regulator, get powered off when
> the GPU is not in use. There doesn't seem to be any damaging effects,
> but I worry about idle power consumption.
> 
> ChenYu

Yes I've seen that as well... and it's true there will be some unwanted
small power leakage.

Though, I would propose to do things step by step. Right now, as it is, the
platform is fully stable... so let's get this in so that we estabilish a
known working baseline... what I have in mind is, exactly:

1. Get Panfrost+DVFS working on current platforms; then
2. Resolve the GPU binning situation (eFuses -> opp-supported-hw)
3. Improve the power consumption (all GPU regulators off during suspend)

Thanks for all the valuable testing and support!

Cheers,
Angelo
