Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AB68D26E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjBGJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBGJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:17:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365AE1EFCD;
        Tue,  7 Feb 2023 01:17:26 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BE7E660206D;
        Tue,  7 Feb 2023 09:17:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675761445;
        bh=fR1g1ujgV6D1c5SgIcM5pGcpg92t2HBOBAeCLPYXs3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QoIgYO5e0cwEvRMZ4ck8Era0JPahNcNQ41bqiSq5v23FCCn9o6Y4QoB+YFrU+RkCp
         v9gFNO0l/zgI0OidYuqL4Dh127V7x02tDjHwugHzWKs1qYlOf6vaFyOo4YCtU6pD8q
         sbkU7K3+l6m0syAwlgJb37QH9bPM5ifjLMpM7/17zRIe6mlZTdSig9tQXJ8OaQbIsu
         6/WRck22M5s888PTF5OMHMLkllLJWgi4VCdifcIPpNqbyhcT5481fnZ85uvWCdnuaC
         FehMtkylODtpcIgK3jC9xqmhcsagirrl8MRBb4GnZsq9sksF/iwIuIxh+JytAi0ENf
         OZ3YpI90Wl/dQ==
Message-ID: <e6af03d9-196a-4c3a-a1a8-3da4d2b90b59@collabora.com>
Date:   Tue, 7 Feb 2023 10:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 13/45] clk: mediatek: mt8167: Compress GATE_TOPx macros
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
 <20230206152928.918562-14-angelogioacchino.delregno@collabora.com>
 <CAGXv+5E8FoVN7HoOpawMhhsKab7qs2F5NcRrpTf5TQiti7XUVA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5E8FoVN7HoOpawMhhsKab7qs2F5NcRrpTf5TQiti7XUVA@mail.gmail.com>
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

Il 07/02/23 08:30, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Use the GATE_MTK macro to compress the GATE_TOP{0..5} macros.
>> No functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt8167.c | 88 +++++++++----------------------
>>   1 file changed, 24 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
>> index 91669ebafaf9..97a443fdfc77 100644
>> --- a/drivers/clk/mediatek/clk-mt8167.c
>> +++ b/drivers/clk/mediatek/clk-mt8167.c
>> @@ -736,77 +736,37 @@ static const struct mtk_gate_regs top5_cg_regs = {
>>          .sta_ofs = 0x44,
>>   };
>>
>> -#define GATE_TOP0(_id, _name, _parent, _shift) {       \
>> -               .id = _id,                              \
>> -               .name = _name,                          \
>> -               .parent_name = _parent,                 \
>> -               .regs = &top0_cg_regs,                  \
>> -               .shift = _shift,                        \
>> -               .ops = &mtk_clk_gate_ops_setclr,        \
>> -       }
>> +#define GATE_TOP0(_id, _name, _parent, _shift)                 \
>> +       GATE_MTK(_id, _name, _parent, &top0_cg_regs,            \
>> +                _shift, &mtk_clk_gate_ops_setclr)
> 
> Nit: 100 characters should be enough to fit the whole GATE_MTK part in one
> line.
> 

Wanted to stay below 90, but there's effectively no real reason to do that,
so let's go to 100 cols!

> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>


Cheers,
Angelo
