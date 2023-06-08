Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8F727A85
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjFHIx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjFHIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:53:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71EF2729;
        Thu,  8 Jun 2023 01:53:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C8D66606F17;
        Thu,  8 Jun 2023 09:53:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686214431;
        bh=96X6k5oqBvIX1dBppWoB2S5z/C5qU+MMBXm3vBPWtl0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U3ly+JKpH51mwz8/4HmOI/6l6O91KLGeLtbNFx5lDpKMqv7TQ1mITadLrC40Su0BQ
         QeRZtJIOhqTf/qwTJm/cqhT5+Cs1sp0y/uUMpZqu0LsaPGIDH0oVMkYtrTQ0THqqWS
         8/31HkQESvhMEK2XMNloIwjBBUbQzCgQa1fvDLhbn32ipbD0dqkUJM6HsEuAteAkib
         WYfcG5cleEOcK2/o+RH6gjQqsF0Qjo4AfOZPwUgeWGsX/7LccV0RiClCGDyabE/rd2
         VzzDqxDow1OjcBisJ9WaIL7Pvhpi33MgY5E+SdEhBPyilu9EIz8kimWqBEhVTMnaIg
         kYcYMRlXm2qDw==
Message-ID: <38e5ffa2-93bd-ce70-ec00-6d61bad969c7@collabora.com>
Date:   Thu, 8 Jun 2023 10:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/5] clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <20230607205714.510012-5-nfraprado@collabora.com>
 <CAGXv+5EgP+0fTDhdpnYDCVQAWtWqwKp=Xxh-pHc1137wHoywRQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EgP+0fTDhdpnYDCVQAWtWqwKp=Xxh-pHc1137wHoywRQ@mail.gmail.com>
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

Il 08/06/23 09:43, Chen-Yu Tsai ha scritto:
> On Thu, Jun 8, 2023 at 4:57 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> Add the CLK_VDEC_ACTIVE clock to the vdec clock driver. This clock is
>> enabled by the VPU once it starts decoding.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> ---
>>
>> Changes in v2:
>> - Added CLK_IGNORE_UNUSED flag
>>
>>   drivers/clk/mediatek/clk-mt8183-vdec.c | 5 +++++
>>   include/dt-bindings/clock/mt8183-clk.h | 3 ++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
>> index 513b7956cbea..03c4f1acfdb8 100644
>> --- a/drivers/clk/mediatek/clk-mt8183-vdec.c
>> +++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
>> @@ -27,6 +27,10 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
>>          GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,   \
>>                  &mtk_clk_gate_ops_setclr_inv)
>>
>> +#define GATE_VDEC0(_id, _name, _parent, _shift)                \
>> +       GATE_MTK_FLAGS(_id, _name, _parent, &vdec0_cg_regs, _shift,     \
>> +               &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
> 
> I think what you want is a read-only gate clock only used for reading back
> the status. The ops would only have .is_enabled.

Technically, you're right... but I would delay the introduction of a RO GATE_MTK
clock for later, as it's not worth adding that for just one clock driver usage.

We're checking if the same can be applied to other SoCs as well - if it can,
then it would make sense to do that (small, yes), work... the point here is to
enable MT8183 decoders ASAP to enable decoder tests in KernelCI, along with
all of the other MediaTek Chromebooks.

Though, if you think that it is a good idea to add a RO gate right now, I don't
have any strong opinions against that.

Cheers,
Angelo
