Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD28667949
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjALPar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbjALP2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:28:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DFE532B3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:21:38 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5700F6602D9F;
        Thu, 12 Jan 2023 15:21:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673536897;
        bh=nYdf7XEDa+qL4LGmV6rT1E2A8+/eL3rBkYBDF2jMQ1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IfTVobtSF5KGd2f++ucXST4Cror0G3e7M8sMZDsJGjFV0le8MvqUZJh6i/gfVcAyI
         ylaiIW5AU1D7WdMz396jiLpQt+csLnv+y03QjYiKCiSJuknB056FqxM83SFSlMf6s1
         0yBY6xXAlx8nZ8QF0EyNz/poHGYz8G51OyBTgEh2bC8nlgWinxGzmH3QAb+eaCc8JV
         gFTFxGYEhnIKzakNyZHvuYr/8EO+lzo3e2dSBcjwdUlzLzJR0/h8BzLhWtUzjllU4g
         tMPmAB8HF0ifyC9WB5RBoHWrj+dt4KBWe1N4nlxrT8lPsvnXG4qxDHgXD7qSAG4jJo
         Lm6xp8INi4Auw==
Message-ID: <1158ca1a-5ca8-4bb9-fc08-15d5555d8d94@collabora.com>
Date:   Thu, 12 Jan 2023 16:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: defconfig: Enable missing configs for
 mt8192-asurada
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230112151238.1930126-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230112151238.1930126-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/01/23 16:12, Nícolas F. R. A. Prado ha scritto:
> Enable missing configs in the arm64 defconfig to get all devices probing
> on mt8192-asurada based machines.
> 
> The devices enabled are: MediaTek Bluetooth USB controller, MediaTek
> PCIe Gen3 MAC controller, MT7921E wireless adapter, Elan I2C Trackpad,
> MediaTek SPI NOR flash controller, Mediatek SPMI Controller, ChromeOS EC
> regulators, MT6315 PMIC, MediaTek Video Codec, MT8192 sound cards,
> ChromeOS EC rpmsg communication, all MT8192 clocks.
> 
> Support for DMA Restricted Pool is also enabled since it is used by the
> WiFi card on this platform.

Let's be more specific on this one:

In this specific case, support for DMA Restricted Pool is necessary because
this SoC has no IOMMU context for the PCI-Express RC (nor attached devices,
such as the MT7921E WiFi card)

After which,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...and, a long time ago, and today again:
[For MT8192 Asurada Spherion (Acer Chromebook 514 CB514-2H]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

