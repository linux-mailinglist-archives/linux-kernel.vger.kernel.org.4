Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3F56EF38A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbjDZLnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:43:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199404C04;
        Wed, 26 Apr 2023 04:43:30 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E77D660324E;
        Wed, 26 Apr 2023 12:43:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682509407;
        bh=LHVBsT9EmHiYRsufhxP3C7/xLomL6Pg/ovhoh+Syk1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fs4E+VJTXcXu0HIh3Az2PWq4QVtLzeQiYlCCf5uMvRydDn/IOEb9gXaq+SJMNWucM
         dQ/+vmjEfzlCUXG9ZhQLKhoOe/gnZ+b4RbHRuMzSQqdMX7uI4XCJnnvVpD+1Kfll0P
         JB/4fLORJx1VzJGtWVb9LMFxlXyJeuBfbdNfEf4GgD6WpKxIhVnkt/2gvFFBUVnyEy
         d+2aUJzV4l6KgkQT0I2EqNk1tabB/S8i2JXQ3MZ/WxwzMKCYlJTwl9h7OhT98m+FLO
         gRwPs9QANyW7PoxrW83MG+HUa4leBbV6vQXSp7gDtSEkwJq6FaCDBI/vGXgC32v1AH
         Sv49JFXKHirSQ==
Message-ID: <c6a12ebc-99f1-855d-e366-e5a4833dc562@collabora.com>
Date:   Wed, 26 Apr 2023 13:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 0/9] Add gamma lut support for mt8195
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/09/22 03:29, Jason-JH.Lin ha scritto:
> Since the gamma_set_common() function for previous SoC,
> such as  mt8173 and mt8183, is designed for 9bit-to-10bit
> conversion.
> mt8195 is using 10bit-to-12bit conversion, which is
> not compatible with the previous function.
> 
> Thus, need to update the function to fit the need of mt8195.

Hello,
can you please respin and fix this series on the latest linux-next?

Besides, please test it carefully: as far as I can see, GNOME Night Light
(or others) are not working on MT8195 (color temperature/ccorr).
As for gamma itself, that's not working either; you can test it with a tool
that will create a color profile by applying a new VCGT table, please look
at [1] if you need tools.

We can confirm that color correction works on at least MT8192 (colord), so
it's MT8195 at fault.

[1]: https://github.com/zb3/gnome-gamma-tool

Regards,
Angelo

> ---
> Change in RESEND v3:
> Fix build warning
>>> drivers/gpu/drm/mediatek/mtk_disp_gamma.c:59:14: warning: no previous prototype for 'mtk_gamma_get_size' [-Wmissing-prototypes]
> 
> Change in v3:
> 1. separate 1 dt-binding patch to 2 patches, 1 is for modifying
>     multiple items list to one and 1 is for moving mt8195 compatible.
> 2. redefine variables to reduce memory usage.
> 3. delete unused symbols.
> 4. separate 1 drm/mediatek patch to 6 patches.
> 5. rebase on tag 'next-20220909'
> 
> Jason-JH.Lin (5):
>    drm/mediatek: Adjust mtk_drm_gamma_set_common parameters
>    drm/mediatek: Add gamma support different lut_size for other SoC
>    drm/mediatek: Add gamma support different lut_bits for other SoC
>    drm/mediatek: Add gamma support different bank_size for other SoC
>    drm/mediatek: Add clear RELAY_MODE bit to set gamma
> 
> zheng-yan.chen (4):
>    dt-bindings: mediatek: modify item formatting for gamma
>    dt-bindings: mediatek: Add gamma compatible for mt8195
>    drm/mediatek: Add gamma lut support for mt8195
>    arm64: dts: Modify gamma compatible for mt8195
> 
>   .../display/mediatek/mediatek,gamma.yaml      |   8 +-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |   2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_aal.c       |   2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   3 +-
>   drivers/gpu/drm/mediatek/mtk_disp_gamma.c     | 115 ++++++++++++++----
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |   4 +-
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.h       |   1 -
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   9 ++
>   8 files changed, 109 insertions(+), 35 deletions(-)
> 


