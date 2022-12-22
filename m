Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8AB6544A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLVPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:54:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148C286F4;
        Thu, 22 Dec 2022 07:54:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E98D6602CD4;
        Thu, 22 Dec 2022 15:54:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671724478;
        bh=qAhG/99ma0oz2fsDZKxatykFyuHEp485BVRnZklODwo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WBvNMLrJs1Tepv7wPgNfxOpPQHWNuLF5o77g3MDtDLkmjglKgBrnf+zXwUxaGUyls
         6zWLBUY0IK0CHLi8muG6wytWp+gy1QtiR3WZgWCfsIenc2GG44a7yVoNH5EPsFxp9O
         jmQAXq9FVX4/t/Wd9mRIB3LG8A7FIeTE4nu6lNXZJXzz83KKohxJpLzPw+FsI4OoMi
         dhr+z6qlnjInxUUzIzPj8pXSuXo6Qr+tbwWdwulbaTJZIJrN+fuVSFTj78Dr5wDhvv
         l/GUuSyDJdHzKUquLXP8W5ne2w51qobXAOpdq5aiflgMpC1F2qZXgb2ipEZy/o58x+
         m5zAtEwM7s4gw==
Message-ID: <372e5ab4-bc2c-1ccd-1f22-7bab635c36d1@collabora.com>
Date:   Thu, 22 Dec 2022 16:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 0/6] MediaTek Frequency Hopping: MT6795/8173/92/95
Content-Language: en-US
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
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

Il 22/12/22 16:51, AngeloGioacchino Del Regno ha scritto:
> This series adds support for Frequency Hopping (FHCTL) on more MediaTek
> SoCs, specifically, MT6795, MT8173, MT8192 and MT8195.
> 
> In order to support older platforms like MT6795 and MT8173 it was
> necessary to add a new register layout that is ever-so-slightly
> different from the one that was previously introduced for MT8186.
> 
> Since the new layout refers to older SoCs, the one valid for MT8186
> and newer SoCs was renamed to be a "v2" layout, while the new one
> for older chips gets the "v1" name.
> 
> Note: These commits won't change any behavior unless FHCTL gets
>        explicitly enabled and configured in devicetrees.
> 

Forgot to write in the cover letter that this series can be applied on top
of [1], but that's a dependency only because that big cleanup moves things
around (hence these commits won't apply if not on top of [1]).


[1]: 
https://lore.kernel.org/lkml/20221222114857.120060-1-angelogioacchino.delregno@collabora.com

Cheers,
Angelo

> AngeloGioacchino Del Regno (6):
>    clk: mediatek: fhctl: Add support for older fhctl register layout
>    dt-bindings: clock: mediatek,mt8186-fhctl: Support MT6795,
>      MT8173/92/95
>    clk: mediatek: mt6795: Add support for frequency hopping through FHCTL
>    clk: mediatek: mt8173: Add support for frequency hopping through FHCTL
>    clk: mediatek: mt8192: Add support for frequency hopping through FHCTL
>    clk: mediatek: mt8195: Add support for frequency hopping through FHCTL
> 
>   .../bindings/clock/mediatek,mt8186-fhctl.yaml |  7 +-
>   drivers/clk/mediatek/clk-fhctl.c              | 26 ++++++-
>   drivers/clk/mediatek/clk-fhctl.h              |  9 ++-
>   drivers/clk/mediatek/clk-mt6795-apmixedsys.c  | 63 ++++++++++++++++-
>   drivers/clk/mediatek/clk-mt8173-apmixedsys.c  | 65 ++++++++++++++++-
>   drivers/clk/mediatek/clk-mt8186-apmixedsys.c  |  2 +
>   drivers/clk/mediatek/clk-mt8192.c             | 67 +++++++++++++++++-
>   drivers/clk/mediatek/clk-mt8195-apmixedsys.c  | 69 ++++++++++++++++++-
>   drivers/clk/mediatek/clk-pllfh.c              | 23 +++++--
>   drivers/clk/mediatek/clk-pllfh.h              |  1 +
>   10 files changed, 311 insertions(+), 21 deletions(-)
> 

