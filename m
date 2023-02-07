Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0A68D1F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBGJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBGJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:00:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009441114B;
        Tue,  7 Feb 2023 01:00:54 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 742F06602069;
        Tue,  7 Feb 2023 09:00:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675760453;
        bh=WvgWU1RplRANWwDHuHVFhaXm5JMdBnOhCCSkJUkA7/0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y9wFeMsRf0Uijdt13gEKrRdIsogpwyOr7GxRd1TMTzUnNFGIvEQ2DadeCBVJOzviR
         H3fSD/qK8Bw8nSqrV8k3cVV6q/y5JtKpjAtBq9JoIFpkHzmywsKbU8WZ5g27Gl/7b6
         xomKQC25TrsN5Fh8XXj+Z4b8M24+fZIsV6UzxUeoSmhod4QRArXXa2C4DpujqLYHq8
         pV+2Zrtjyxte4m1ZD99wxOCHqQv511ENv93evVuo5UmeZgJr4jSPgaE2+di6ONH5PY
         H95RO1gcKBLOMyViSkVCqSlQL4tZXTVov5vNcRWHN4dZRmDZULNvFVy4bdl8saafB7
         ZalAlPRQoJrmw==
Message-ID: <35a6bd38-58ed-d960-6f64-eb7f87986256@collabora.com>
Date:   Tue, 7 Feb 2023 10:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 07/45] clk: mediatek: mt2712: Add error handling to
 clk_mt2712_apmixed_probe()
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-8-angelogioacchino.delregno@collabora.com>
 <CAGXv+5HVNSFyBncAepAhghHsjRdY=XyzsRY0Htm1KcRE7U9dfg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HVNSFyBncAepAhghHsjRdY=XyzsRY0Htm1KcRE7U9dfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/02/23 07:16, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> This function was completely missing error handling: add it.
>>
> 
> Fixes tag?

Noted for v2, thanks!

> 
> Code looks OK. So once the tag is added,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt2712.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>

