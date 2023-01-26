Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC567C61D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjAZImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjAZImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:42:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1945FC6;
        Thu, 26 Jan 2023 00:42:06 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71FB86602D35;
        Thu, 26 Jan 2023 08:42:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674722524;
        bh=OfAPBok58TgU/BxsU4JJcG3QhWdeaE/H5dGq/rET2eg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cIhElz/Zhd0YyetKRKGQehx+Rpn4FpYtDupY/Q3iQ5mlCug8Gp5/FMBvHJGZAeuC6
         YgUTaKz6xI4GwKahM9Qds8vb8/YfciGj1ODgGqThbKxT5QOEC3YGlOhEuipeqIc2Jm
         A98cZD4zuOVkfBt611XcgCClEfQoSzrx37tLyQQkx4e/zdST0AMMaxphPrpOuqO3qR
         0BSzG7Y/DAhholiJSIZzkTGpnj/nUo2SUftJuxGU5bjOOMfwePaxSXtq28NtfBQrCs
         JMTjqbqLxzETvIOknl0hB+Fx2PYP7kijAMwAtNSJwAltmrlUQU6ZXQ3BIBYFVMVXvr
         6EbcvjV8crCBw==
Message-ID: <1684cd8a-5766-0bcb-3301-ce517d39c370@collabora.com>
Date:   Thu, 26 Jan 2023 09:42:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 0/6] MediaTek Frequency Hopping: MT6795/8173/92/95
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, edward-jw.yang@mediatek.com,
        johnson.wang@mediatek.com, wenst@chromium.org,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, jose.exposito89@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
 <5036f36916e12429d6f853049a2e5836.sboyd@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <5036f36916e12429d6f853049a2e5836.sboyd@kernel.org>
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

Il 26/01/23 03:07, Stephen Boyd ha scritto:
> Quoting AngeloGioacchino Del Regno (2022-12-22 07:51:41)
>> This series adds support for Frequency Hopping (FHCTL) on more MediaTek
>> SoCs, specifically, MT6795, MT8173, MT8192 and MT8195.
>>
>> In order to support older platforms like MT6795 and MT8173 it was
>> necessary to add a new register layout that is ever-so-slightly
>> different from the one that was previously introduced for MT8186.
>>
>> Since the new layout refers to older SoCs, the one valid for MT8186
>> and newer SoCs was renamed to be a "v2" layout, while the new one
>> for older chips gets the "v1" name.
>>
>> Note: These commits won't change any behavior unless FHCTL gets
>>        explicitly enabled and configured in devicetrees.
> 
> Can you resend this? It conflicts with your latest cleanup series.

Right. Sorry about forgetting to update this one - will rebase and
resend today.

Thanks!
Angelo
