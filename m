Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7E6C464D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCVJ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCVJ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:27:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E91567B6;
        Wed, 22 Mar 2023 02:27:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 286D566030E5;
        Wed, 22 Mar 2023 09:27:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679477248;
        bh=tm5AC8oAxj/BLJH6P7jdDgG/1QqkIQicoTd5DZz6WME=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MgA/2lFUfyd5k/VBWnuu40eTYWS2U1TrrofgOMA0I9jVpdy3eEamqWcf4tagLMjHR
         EYG/Dt6rR/CXT5QPXB2XGairw7NZ2vJCFTiZN697ZjU9mBhuR+1jIwTZefhoaLWlDK
         IioRzVI4LUF9Xb0aUoln0A4Wfn4KFUNMQOdmen5CL1mdqaxXlr70en5Rgjk8S++LDi
         Q0rUGgJJ5+ebU1NWOdfgRTaiSLobW7Zl4UsgTdJ6LMafovrR9E9Y/VTbCenyiGT6Mh
         rAtqlpa++uhnmOtjEPtFRybdL2w7YOFX7V0OGBtvN5z6PXidEdYSooaBfd+nwFBCUM
         cDXjooq2zQlDw==
Message-ID: <7b9b09fe-1049-26b6-7bec-0051e7304b5b@collabora.com>
Date:   Wed, 22 Mar 2023 10:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] dt-bindings: reset: mt8188: Add reset control for
 DSI0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Sung <shawn.sung@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230322032202.12598-1-shawn.sung@mediatek.com>
 <20230322032202.12598-2-shawn.sung@mediatek.com>
 <83eb4c5c-b4ea-1fee-7212-c88821b90771@linaro.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <83eb4c5c-b4ea-1fee-7212-c88821b90771@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/03/23 09:34, Krzysztof Kozlowski ha scritto:
> On 22/03/2023 04:22, Shawn Sung wrote:
>> Add reset control for DSI0.
>>
>> Signed-off-by: Shawn Sung <shawn.sung@mediatek.com>
>> ---
>>   include/dt-bindings/reset/mt8188-resets.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
>> index 377cdfda82a9..5c9e74130ef0 100644
>> --- a/include/dt-bindings/reset/mt8188-resets.h
>> +++ b/include/dt-bindings/reset/mt8188-resets.h
>> @@ -33,4 +33,7 @@
>>
>>   #define MT8188_TOPRGU_SW_RST_NUM               24
>>
>> +/* VDOSYS0 */
>> +#define MT8188_VDO0_RST_DSI0                   21
> 
> Why this is not 0? IDs start from 0.
> 

Because mtk-mmsys needs to be fixed, bindings IDs are *again* 1:1 with HW bits,
there's no mapping like the one that was "recently" done in clk/mediatek resets.

Since VDO0/1 have got lots of holes in reset bit mapping, it's definitely time
to fix this situation now.....

Shawn, please fix.
For your reference, look at [1] and [2].

[1]: https://lore.kernel.org/all/20220523060056.24396-9-rex-bc.chen@mediatek.com/
[2]: https://lore.kernel.org/all/20220523060056.24396-15-rex-bc.chen@mediatek.com/

Regards,
Angelo


> 

