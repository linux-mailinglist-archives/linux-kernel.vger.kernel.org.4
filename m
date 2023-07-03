Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97948745C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGCMaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:30:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343DE109;
        Mon,  3 Jul 2023 05:30:11 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 55DCA6606F62;
        Mon,  3 Jul 2023 13:30:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688387409;
        bh=10ULvzLVa3uPh6pWKGK9iBRw5HZ3uis1iLD8mOYhqfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J5fThttroPprXqRHHKBLtoaDz50gaGczy9Po19sSzCmkUgjfbnoJtSmqWQ91atMLn
         hbOMMYb1dA04xd3lL+5fPpFEyJ56r38hCVBntW89RuqMKWG8pes7Tzt6ecbDvH7i6L
         vJuGuwiV3kAJ3vHwEoUeqBVJy4SAo8rUjf4MmR3OCmbF6fODUY22ZqTJKjwIDG33JS
         hvluBaHKUorn2TK2lcjZbd2tR013Z5JllRopxhxwhs2T2BI1lc74BlILmtgKAWZQ1b
         dK7If3bPNBXDwqAfbEIJZGag3IQ0NuPhr8Apt6UfxtmFNcyuy12rCStcLU0Su/hq3Y
         L0z16RWX5C+Nw==
Message-ID: <2dd412f0-86cb-3ae0-305d-0e8192b9128a@collabora.com>
Date:   Mon, 3 Jul 2023 14:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Julien Stephan <jstephan@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-3-jstephan@baylibre.com>
 <CAAOTY_-qu2RWr496wXxc1Cp14eZfzKt4QgEH8fJns2LOjpwi8Q@mail.gmail.com>
 <CAAOTY_9SFRMb7d3c62SVDnZY00hRAZ=9wBi9QCcv1UKuc8iBtQ@mail.gmail.com>
 <20230703121853.GA16531@pendragon.ideasonboard.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230703121853.GA16531@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/07/23 14:18, Laurent Pinchart ha scritto:
> On Sun, Jul 02, 2023 at 05:20:25PM +0800, Chun-Kuang Hu wrote:
>> Chun-Kuang Hu <chunkuang.hu@kernel.org> 於 2023年7月2日 週日 上午7:35寫道：
>>> Julien Stephan <jstephan@baylibre.com> 於 2023年6月30日 週五 下午6:05寫道：
>>>>
>>>> From: Louis Kuo <louis.kuo@mediatek.com>
>>>>
>>>> This will add the mediatek ISP3.0 seninf (sensor interface) driver found
>>>> on several Mediatek SoCs such as the mt8365.
>>>>
>>>> Then seninf module has 4 physical CSI-2 inputs. Depending on the soc they
>>>> may not be all connected.
>>>>
>>>> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
>>>> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
>>>> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>>>>
>>>
>>> [snip]
>>>
>>>> +
>>>> +static const struct mtk_seninf_conf seninf_8365_conf = {
>>>> +       .model = "mtk-camsys-3.0",
>>>> +       .nb_inputs = 4,
>>>> +       .nb_muxes = 6,
>>>> +       .nb_outputs = 4,
>>>> +};
>>>> +
>>>> +static const struct of_device_id mtk_seninf_of_match[] = {
>>>> +       {
>>>> +               .compatible = "mediatek,mt8365-seninf",
>>>> +               .data = &seninf_8365_conf,
>>>
>>> Now only support one SoC, so it's necessary to select the SoC data and
>>> you could directly place the data in the code. After support other
>>
>> Typo.
>>
>> Now only support one SoC, so it's not necessary to select the SoC data
>> and you could directly place the data in the code.
> 
> I think Julien has visibility on other SoCs that could use the same
> driver, and has designed the mtk_seninf_conf structure accordingly. I'll
> let Julien confirm (or tell I'm wrong).
> 

You're not wrong.

Cheers,
Angelo

>>> SoC, so we could know what should be placed in struct mtg_seninf_conf
>>> (Now we have no any information).
>>>
>>>> +       },
>>>> +       {
>>>> +       },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, mtk_seninf_of_match);
> 


