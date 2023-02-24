Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62F6A1C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBXND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjBXNDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:03:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B31ABC8;
        Fri, 24 Feb 2023 05:03:10 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1BD2C6602FB6;
        Fri, 24 Feb 2023 13:03:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677243789;
        bh=nF7vnKnk57AVWXiNF4H8GktvnOQkVo77OMsiyD+o5dU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IF0YTRxd8cT2I7MlYUZkOHXZZnGe0AOe8qgo1ZmAlRT7zi2T0ki5Dj2aBwylXBu7R
         0Tkhz0tTirQNA8+X1zSRMavYt7tn8d7sjZL7HzIVszNX0t4p3KjgXZqzt54wVD8QIU
         GDHw52Jkfe6x+Of/er5oiB/u/ZBNudXydmoBheW7LlKimJXxdXCxxUwei8BQv0SAj6
         OmyqK7dDGMMUgazjsb/XEKPXoD0k5i+Ne1bOnCZnR0QF6ZBPYUENRSvVK9ZFxs/1r6
         LlmDZMykS2EvFscbpVxKT95fVv3xtX3SYqTUMR1ADPD0oAlCyKihR8L32U4fHQusKK
         HxLRF5UpChEWA==
Message-ID: <a14eee4a-9659-62b5-6767-0d14bc1712eb@collabora.com>
Date:   Fri, 24 Feb 2023 14:03:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 04/16] arm64: dts: mt8183-pumpkin: Couple VGPU and
 VSRAM_GPU regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
 <20230223134345.82625-5-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Eh62NFNW1T7PYiQe+9KD8qX2WB7M3rwrYD=ca872y3WQ@mail.gmail.com>
 <CAGXv+5Ehm0yb+52m+DL8s99KqBqx7skPZ2xfMFMYVJ23CDsfHQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Ehm0yb+52m+DL8s99KqBqx7skPZ2xfMFMYVJ23CDsfHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/02/23 10:53, Chen-Yu Tsai ha scritto:
> On Fri, Feb 24, 2023 at 5:51 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Add coupling for these regulators, as they have a strict voltage output
>>> relation to satisfy in order to ensure GPU stable operation.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Actually, maybe you should override the constraints here as well.

I'll add a commit to override the constraints on v3, thanks for making me notice!

Regards,
Angelo
