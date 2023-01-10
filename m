Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC22E664088
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbjAJMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbjAJMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:32:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08703F11E;
        Tue, 10 Jan 2023 04:32:40 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5A5C6602D72;
        Tue, 10 Jan 2023 12:32:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673353959;
        bh=fN5gyt8JffTBLNEv/AsicLPn3AAzjD6PZaav/xa60RI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iOHUaegnR5bxW/PEQuwLF6b9sdSAJyCLscMJPjH0O6fXNmed8eX9eXHNgk+y9IU0k
         nSMkZSnuVtFY+kaDDYdn7zjmspq1ktsw9gamaf4B3TueM2F8/p2LqM14Gb33kjUHWS
         RQl14Kyho7fRaqqEVCZQ8HcJkj9dMrJy9QZKOWfLd0IkHG/lxE15SYTHzPXKHdKMAX
         nG0OhASg7J3Yx8BppJnnelRGSBLaK8ACc2nAlUSvBgllScLq88T5J5ZIhjRs1F3cZi
         J+dxjV9RFxXcDGltlOkZ2kO/tbY6zA7/PkT/hlZ7HAFjRskOygKbvaaY2q7fLxZgA7
         JGG6L68MKplkw==
Message-ID: <8bc4330b-0cfe-222b-7b8a-35fd15a30a52@collabora.com>
Date:   Tue, 10 Jan 2023 13:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 09/23] clk: mediatek: mt8173: Remove
 mtk_clk_enable_critical()
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-10-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Hk8kguJ=joLXF3OrRXxGvuFAJFKYoK+y7q+wqDBS-wtQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Hk8kguJ=joLXF3OrRXxGvuFAJFKYoK+y7q+wqDBS-wtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/12/22 05:58, Chen-Yu Tsai ha scritto:
> On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> The entire point of mtk_clk_enable_critical() is to raise the refcount
>> of some clocks so that they won't be turned off during runtime, but
>> this is the same as what the CLK_IS_CRITICAL flag does.
>>
>> Set CLK_IS_CRITICAL on all of the critical clocks and remove the
>> aforementioned function as a cleanup.
>>
>> No functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 
> Looks good to me,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> However, if you move this patch before the previous one ...
> 
>> ---
>>   drivers/clk/mediatek/clk-mt8173.c | 41 ++++++++++++-------------------
>>   1 file changed, 16 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
>> index 70cdc0719658..02231f8ba6d9 100644
>> --- a/drivers/clk/mediatek/clk-mt8173.c
>> +++ b/drivers/clk/mediatek/clk-mt8173.c

>> @@ -846,23 +852,8 @@ static const struct mtk_clk_rst_desc clk_rst_desc[] = {
>>          }
>>   };
>>
>> -static struct clk_hw_onecell_data *mt8173_top_clk_data;
>> -static struct clk_hw_onecell_data *mt8173_pll_clk_data;
> 
> You wouldn't have to touch these lines twice?
> 

That's true, but please,  I prefer not to, as the patches are ordered for
eas(y/ier) bisectability in case anything happens.

Cheers,
Angelo

