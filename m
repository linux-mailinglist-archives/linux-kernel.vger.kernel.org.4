Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076845B9F91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIOQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIOQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:21:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C649DB6B;
        Thu, 15 Sep 2022 09:21:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80E2C6601BB1;
        Thu, 15 Sep 2022 17:21:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663258905;
        bh=Z5N5FX44YimNiJSczF5hZWEdAZshfEyrSoqz/isyZe4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nUC5r/nansvPFsy1DZP/Nw1dA1VwK9kbcBlqQ3NqLgg2/R7O7P+qYinPhF6rc9yZJ
         16lHboarvLcD3ASLmvrbPzHXZOxYYnPm86yxMmwjjrK6yntlGWmoWuHlGfbLf4H6Wu
         ZisTbEy68c2EuCZzScMC10ZLbjUTWITJpUMhaLLLgH3ZYkLzL6Rvx8BFQtPx6OH+2/
         LIEYID9wpXcIg3T/uIYu0unmscu23G6YdVUFKJM98UEkrcU6HnBPoALbf1jREGMBYU
         vKmkNV8PyWYb23tsGqPBFm0wd2qIajM1OFWDcD4gkJWMg0I7UdLc1IeArSHGFXJ0bG
         s+fkZM0WJW/mQ==
Message-ID: <9af70465-6923-d625-fe08-7cd66d3775c8@collabora.com>
Date:   Thu, 15 Sep 2022 18:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] dt-bindings: mailbox: Convert mtk-gce to DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220915101716.70225-1-angelogioacchino.delregno@collabora.com>
 <04187280-3c35-c9ac-fc70-b5066108ac0c@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <04187280-3c35-c9ac-fc70-b5066108ac0c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 17:30, Krzysztof Kozlowski ha scritto:
> On 15/09/2022 11:17, AngeloGioacchino Del Regno wrote:
>> Convert the mtk-gce mailbox binding to DT schema format.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../mailbox/mediatek,gce-mailbox.yaml         | 104 ++++++++++++++++++
>>   .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 --------------
>>   2 files changed, 104 insertions(+), 82 deletions(-)
> 
> How is this related to:
> https://lore.kernel.org/all/66591c84-ee8d-7152-f0c5-5e4a07f632fb@linaro.org/
> ?
> 
> Changelog? Previous review tag?
> 

I completely forgot that I had already sent something similar in the past,
so that was done from scratch :\
I always keep note of what I send, what's accepted, what's not (etc) but,
for some reason, that older series wasn't present in my notes.

In any case, the older series wasn't just a dt schema conversion, but also
changed how we got clocks from the driver, while this one is only a
conversion and nothing else.

Regards,
Angelo

> 
> Best regards,
> Krzysztof


