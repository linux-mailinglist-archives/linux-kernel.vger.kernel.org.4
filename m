Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130A3623E06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiKJIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiKJIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:53:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23152CC95
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:53:18 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 514AC6602A12;
        Thu, 10 Nov 2022 08:53:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668070397;
        bh=5XPe+JGe2J+d1XKb/rbXAO7A2B4y4l4DV6r8nwezCQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S5xOpLaEW4IHN/Xf7XhsV2J+hbrvBg7ndUSN0PZnSGPDUvFOZ8eb2jDspR9m5mQRX
         uavSM8Gf1E1f6AH2AH3tWgUzcNt5mNnIhKkGXti8OadFGYpphRGnfN5P7ZzbxcKWiQ
         a1oJMSkTkh7IVu9Q9ggU0hNy5YYujohx4umDqVVS3+9sunCsDA+9QMF4kl3qfgcV7Z
         sb+3xRU7V9AI5nnRT7TWyNeOWnYdZjsXPJgiDMdr+HCUbAnF4tRNMiKH9Y8MxaOXe9
         pjDIKOMGsdmXCKDEE4+lH4JTKFVDBRfOCAJ6xu0II6U+S5zZzbwO20LpSzAOUteI1W
         1AbF8hSWTGEvQ==
Message-ID: <4a8aa69e-4c0c-2ca4-7d94-48219f90f6fa@collabora.com>
Date:   Thu, 10 Nov 2022 09:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] arm64: defconfig: Enable missing configs for
 mt8183-jacuzzi-juniper
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221109195012.1231059-1-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221109195012.1231059-1-nfraprado@collabora.com>
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

Il 09/11/22 20:50, Nícolas F. R. A. Prado ha scritto:
> Enable missing configs in the arm64 defconfig to get all devices probing
> on the mt8183-kukui-jacuzzi-juniper machine.
> 
> The devices enabled are: ATH10K SDIO wireless adapter, Elan touchscreen,
> cr50 TPM, MediaTek SPI controller, JPEG video decoder, ANX7625 DSI/DPI
> to DP bridge (used for the internal display), MT8183 sound cards, SCP
> co-processor, MediaTek Global Command Engine (controlled by CMDQ
> driver), MediaTek Smart Voltage Scaling (SVS) engine, CCI frequency
> and voltage scaling, AUXADC thermal sensors.
> 
> All symbols are enabled as modules with the exception of SPI, which is
> enabled as builtin since on some platforms like mt8195-cherry, the
> ChromeOS Embedded Controller is connected through SPI and it is
> responsible for the regulators powering the MMC controller used for the
> SD card, and thus SPI support is required for booting.
> 
> By enabling the support for all of this machine's devices on the
> defconfig we make it effortless to test the relevant hardware both by
> developers as well as CI systems like KernelCI.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


