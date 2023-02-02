Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022CC687C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBBLmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjBBLms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:42:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903868C43C;
        Thu,  2 Feb 2023 03:42:41 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB65A6602EED;
        Thu,  2 Feb 2023 11:42:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675338160;
        bh=ptjOx1Sz/Aegw0n395roYj59RnSkl74upxkTKsW43E8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TWTzeL/eICovsuOm/RCxqmOM4YRvCVBBN/EB+Y2S9H4gBuFEAahGDEPPOcRdD5UPU
         SH6fEyribjAwVxU7TjhL5sIp68F9ImESvQlLMNKfXXfpnpYnDYcFGUAL/cF32ITEoh
         F7LlhLeN5Z0DLBMP7JXS3r7fXkxGqvPoAvUSO7RDw7DNMeqnFYPBhXRSrLfSqHzV0y
         xglcleEUmkvATKZ6R7J7YcpfdbQjIFBDTtCc/FHBwA34Yz1f/bzMTSFtr7wmQ8tp6K
         CeFe9p1KPzI06H2U5PNHanOt7EV0e6oBBjadluPSZaUT96VLkeihDQP49iVq9mZ2MQ
         ui9xkanezDwmQ==
Message-ID: <4b5bb022-eb5d-2ed1-2123-eb9e502299dc@collabora.com>
Date:   Thu, 2 Feb 2023 12:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix vdosys* compatible
 strings
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, soc@kernel.org
References: <20230202104014.2931517-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230202104014.2931517-1-wenst@chromium.org>
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

Il 02/02/23 11:40, Chen-Yu Tsai ha scritto:
> When vdosys1 was initially added, it was incorrectly assumed to be
> compatible with vdosys0, and thus both had the same mt8195-mmsys
> compatible attached.
> 
> This has since been corrected in commit b237efd47df7 ("dt-bindings:
> arm: mediatek: mmsys: change compatible for MT8195") and commit
> 82219cfbef18 ("dt-bindings: arm: mediatek: mmsys: add vdosys1 compatible
> for MT8195"). The device tree needs to be fixed as well, otherwise
> the vdosys1 block fails to work, and causes its dependent power domain
> controller to not work either.
> 
> Change the compatible string of vdosys1 to "mediatek,mt8195-vdosys1".
> While at it, also add the new "mediatek,mt8195-vdosys0" compatible to
> vdosys0.
> 
> Fixes: 6aa5b46d1755 ("arm64: dts: mt8195: Add vdosys and vppsys clock nodes")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> Since we are at -rc6 and Matthias already sent out pull requests, I've
> CC-ed soc@ so that this may be picked up directly on top of them. This
> should be merged for -next.
> 
> Thanks
> 

