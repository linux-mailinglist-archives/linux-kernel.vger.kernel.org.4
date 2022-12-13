Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD564B379
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiLMKpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiLMKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:45:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3A15F90;
        Tue, 13 Dec 2022 02:45:33 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C89A66602C36;
        Tue, 13 Dec 2022 10:45:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670928332;
        bh=/rl+V9fireMwj8qHsGjB1b0MfONrsBSzed9ZXGPlM+E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d6X6NjbDCn6AAVp0FxhLHfmMSY3qwt8Hyjul3yIv7YbvdykLxjuHbGaX9doJxRLfr
         3U74JAza/5lOCzhNl3Xy0S82zm1FC1ew9Giplpmu2uUU4dBOTTAZuEJWmMVfIVG2XO
         fEfkGK/wyqpOOi7XbFPDDNS+moia44o1w8JNRlh6rBy7Cyh1ZYNkguYczWDABN+sAf
         G9LbH0OiyGrt5ZQxDjbBaASq639Qn73tPfJL+pzgkTsYHRf/IonE7jM+rENfsI7jGS
         X4bVSVdTNDUNl6iZTDkOzZhPinrz5Y5T+tarhnb5Ea/amjPRwYMM1vL93y97Bd0/JK
         32c/eP6O5bKIQ==
Message-ID: <6ffe412f-2921-160e-068f-cf567e9a0738@collabora.com>
Date:   Tue, 13 Dec 2022 11:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 01/12] ASoC: mediatek: common: add SMC ops and SMC CMD
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
 <20221208033148.21866-2-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221208033148.21866-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/12/22 04:31, Trevor Wu ha scritto:
> SMC call is required to communicate with ATF for some secure operations,
> so we add SMC ops IDs and SMC CMD ID to common header.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


