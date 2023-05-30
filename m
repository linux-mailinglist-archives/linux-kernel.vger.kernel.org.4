Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFC5715650
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjE3HNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjE3HNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:13:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA06A7;
        Tue, 30 May 2023 00:13:00 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC49A66059A8;
        Tue, 30 May 2023 08:12:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685430779;
        bh=FbpwufshqCYmNrpgiCFM4ItKYbmX+m5YBtViqULXOjE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VOKg+P6tVPHrrKQ0M/uf+I1xV1pegKrpKuwLHG5M0HBi+Pm64B+cGXL8DUXlkHvOR
         GhrCP/MhPAZ6YeebuMDGhauYBfsxo3xEBkcBBsqFMcyLcH8hj8hFZu6WAlLiakNB8J
         0Nw6SRWMLBe9Uy58PHGmgqpVJcg2XnjwiScXu6pDiXrR1llIWuRj2h7AC0BWXHiCv7
         s1YS/pXBUwaTkSfXvpeMpyo88tK8j8yh9pynh2Vx/jZOdjuj0IMdneiWkL+HCSFE7M
         GR4OF+rTQSd7qBm0uWgsmI9O13w5/I8EmyRTUUvvqlbJKisQq766z1N653hWyLp4Vo
         LEeyBf5s/JnaA==
Message-ID: <d39b0e77-e013-fe7e-9523-9bdbaacb5853@collabora.com>
Date:   Tue, 30 May 2023 09:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: kukui: Add scp
 firmware-name
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230220093343.3447381-1-hsinyi@chromium.org>
 <CAGXv+5E4_k1jKTnninYkuT6Tf=skB00AowHpM+hc8j_VFM-RfQ@mail.gmail.com>
 <CAJMQK-hnK69iVJhqW_8UtKHHLQ3608Cb74Jk_b+xHH0BBu4yVw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJMQK-hnK69iVJhqW_8UtKHHLQ3608Cb74Jk_b+xHH0BBu4yVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/23 07:12, Hsin-Yi Wang ha scritto:
> On Tue, Feb 21, 2023 at 11:25 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> On Mon, Feb 20, 2023 at 5:34 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>>
>>> The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/scp.img
>>>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> hi Matthias,
> 
> Kindly ping on the patch, thanks!

Agreed. Matthias, please pick this one.

Hsin-Yi, can you also please send a version of this patch for stable?

Thanks,
Angelo
