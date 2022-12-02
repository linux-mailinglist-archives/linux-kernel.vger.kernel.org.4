Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43366405EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiLBLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiLBLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:37:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4666AD67BA;
        Fri,  2 Dec 2022 03:37:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFE466602BB1;
        Fri,  2 Dec 2022 11:37:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669981039;
        bh=TG1tR14lwEhWzIhO276peoN8Dts5HIQpHk5GGVbesoU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m9xgWo7TF1ceWgfOjWkfOQ+tCmRAMW6BRWWXKe5M10C2WVQ1o2hFOveHiJ3Q2uUMG
         a26sLdI7R66CZAC3wOZZ/P1ABwDkZgfAK/MRwxYmp4ERI6HVt8fsMZ8yswDaCEiNtP
         Vgp660jCKIcF68l2BgxotyRMlg95F7saJUDTMLcz4zAkusyT/Vr7BWZE6NU6Jp01yN
         xk/nh7MdI/oaCH0qmaYa2h4v474e3uvWSGgG6xwpnat8xogQOwmMK+sn4jUaV4pvTw
         grAjg3MyXItqdYnv5rkEXASJB8v/snXspxjcI27E8Q4v5LI/AcVyIyia458o4KdQz8
         pIrCyRGKgOesg==
Message-ID: <f98a2f4a-737c-fef5-551b-04a92d255d0e@collabora.com>
Date:   Fri, 2 Dec 2022 12:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh@kernel.org>
References: <20221201121525.30777-1-yunfei.dong@mediatek.com>
 <20221201235729.GA1718283-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221201235729.GA1718283-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/12/22 00:57, Rob Herring ha scritto:
> On Thu, Dec 01, 2022 at 08:15:22PM +0800, Yunfei Dong wrote:
>> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
>>
>> mt8195 and mt8192 have different clock numbers, can't write 'clocks' and
>> 'clock-names' with const value.
>>
>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>> ---
>> Reference series:
>> [1]: v5 of this series is presend by Allen-KH Cheng.
>>       message-id: 20221128143832.25584-4-allen-kh.cheng@mediatek.com
>> ---
>>   .../bindings/media/mediatek,vcodec-subdev-decoder.yaml   | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
>> index 7c5b4a91c59b..09781ef02193 100644
>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
>> @@ -110,15 +110,12 @@ patternProperties:
>>             Refer to bindings/iommu/mediatek,iommu.yaml.
>>   
>>         clocks:
>> +        minItems: 1
>>           maxItems: 5
>>   
>>         clock-names:
>> -        items:
>> -          - const: sel
>> -          - const: soc-vdec
>> -          - const: soc-lat
>> -          - const: vdec
>> -          - const: top
>> +        minItems: 1
>> +        maxItems: 5
> 
> Names need to be defined. This is a step backwards.
> 

I was thinking the same but wanted to wait for someone else's opinion before.

Yunfei, this would be...

- if:
     properties:
       compatible:
         .... mt8192
   then:
      clock-names:
         .... whatever we have

- if:
    properties... blah mt8195
   then:
     clock-names:
         ..... new ones

...you should know already, but I'm just trying to speed up things here.

Cheers,
Angelo

> Rob
> 
>>   
>>         assigned-clocks:
>>           maxItems: 1
>> -- 
>> 2.18.0
>>
>>


