Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694D673BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjASO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjASO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:26:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DB56EC9;
        Thu, 19 Jan 2023 06:26:18 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CD2166003AE;
        Thu, 19 Jan 2023 14:26:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674138377;
        bh=ZIe5yqaxTy9L2ycOBJ1E+XvV/jSScf3+kST/Lx30c6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Re6RpkzC8eP7wmKOfuy/jmDsBJpgP1RgEMrDw7TrWVFnCURyEN+C3SYg840tuV9Ga
         fVFjoo+lk/FfHue5Nw0JdT/GDvnIKPUdNv1ka8XnV2uHeLeucUZ3YUJSdUlUXH+lyu
         Ux0FvxhuPQERqysMy4AZHebmZIZG3iZ+hlPKBJGScMOFaFeZe9PMGYG5ESvyaoA8ue
         FwD+/b+wO4KFQL8zCAV2ydnooiJDuW4DGSdVWv7o6LDrAuqPAfogaMpPbrwLuArlfr
         M36CVcyw7xXE2Dvu6sOXlMswxpT2beE0fXXXyA9+CFkxNSn8ZMBSFOIGELQL5sSotg
         VxDLKc/7GpIUg==
Message-ID: <d462e9b0-7900-e611-a464-0484cdba4571@collabora.com>
Date:   Thu, 19 Jan 2023 15:26:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: add some compatible strings for
 MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674137304.git.daniel@makrotopia.org>
 <cad4f70cd009ba82e39c623485389c021992762e.1674137304.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <cad4f70cd009ba82e39c623485389c021992762e.1674137304.git.daniel@makrotopia.org>
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

Il 19/01/23 15:11, Daniel Golle ha scritto:
> Add compatible strings for MT7981 to existing binding documenation
> at mediatek,apmixedsys.yaml and mediatek,topckgen.yaml.
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

dt-bindings: clock: Add apmixedsys/topckgen compatibles for MT7981

looks better as a title... :-)

Regards,
Angelo

> ---
>   Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml | 1 +
>   Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml   | 1 +
>   2 files changed, 2 insertions(+)
> 

