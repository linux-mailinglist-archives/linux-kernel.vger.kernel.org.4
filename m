Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B37E6A1CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBXNJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjBXNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:09:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15E13506;
        Fri, 24 Feb 2023 05:09:45 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F3AFB6602FB6;
        Fri, 24 Feb 2023 13:09:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677244184;
        bh=eNRVBTrYla/JuAHqdu3DfZ00wg57f7iLgICRaNb9Zh0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QtxSPp6n7A2HoEqRKa/hKmrhjzgs7KgoDfuIwGGbuWri+axuqr+i1FYKXHNeBy2gl
         FO9/Oeb7LOyBn2GQkGfbtutzbjbuMlW3FeZ0VqzjOtrPoX2LNuT8Zuc7HQYOZKzRFo
         9rVeinBG3lZ7VLJGtFVBboXPSge2Gkr0n6l7ZeQ+rKlNDogi399JN34fAUlkM6zjNB
         OumQLNy899WgRda8wehFeyZViqMNxLVtA/36YznDKneBjvxLF6TTWwmUmukNOIwrP/
         zPbaMxHPgD76B3a7ancx1R9yhwnw72SENmz/53qEXjRcASRmozUfxW5sFleN4/B4mX
         pREtAMGa8ia/A==
Message-ID: <9e12c33a-998e-7042-27b7-320be99940ea@collabora.com>
Date:   Fri, 24 Feb 2023 14:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/11] dt-bindings: gpu: mali-bifrost: Split out
 MediaTek power-domains variation
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
 <20230223133440.80941-3-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FK8BjSgwS5276FJj4zG_3STMbQwQWdyn3LjOvQ=108RQ@mail.gmail.com>
 <CAGXv+5Gv19nijoW5i8=Ouh4H24X3pknM3ZBSo9Tgv8XkLt+XbQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gv19nijoW5i8=Ouh4H24X3pknM3ZBSo9Tgv8XkLt+XbQ@mail.gmail.com>
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

Il 24/02/23 11:09, Chen-Yu Tsai ha scritto:
> On Fri, Feb 24, 2023 at 6:08 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> In preparation for adding new bindings for new MediaTek SoCs, split out
>>> the power-domain-names and power-domainsvariation from the `else` in
> 
>                                              ^ missing space
> 
> Once fixed,

I think you even mentioned that already, ugh. Will fix.

> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
>>> the current mediatek,mt8183-mali conditional.
>>>
>>> The sram-supply part is left in place to be disallowed for anything
>>> that is not compatible with "mediatek,mt8183-mali" as this regulator
>>> is MediaTek-specific and it is, and will ever be, used only for this
>>> specific string due to the addition of the mediatek-regulator-coupler
>>> driver.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

