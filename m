Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD764B370
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiLMKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiLMKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:45:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B2635C;
        Tue, 13 Dec 2022 02:45:27 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA77E6602AB2;
        Tue, 13 Dec 2022 10:45:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670928326;
        bh=uplpfhEN6RmyAtuxsuSug50gkJOXSHec1yz8xB64QX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OSPTw/wyqkLD69Ap07pXFqSSC0XEq7gF01g+KFB9E+NXHRWa4YAlsJWuD/xTNM8Z0
         JwOL6FFumMHMmBEL/867Z0F0S4ggG3H3euRxkOc52f3ngcYSHS4uxH+f8XcsiyFMgv
         n86GuWECw39I2xKqSq8qTyalhtMk2VW9lTBe62DR21xnPF2MDg6RAVeoda/wB5Ae/W
         jz/adww5OPm5DKI3//39M+MSbQBXnst5kk59N3Zn8N1/GplaTYF0U9VLdJqZ9G9Nrq
         /BUSMSRMc1hiNKQaO2BglRWZZNL88eZ4PeNejBsZDKUvsfE6lMbXn6JErDRnd/J7ic
         imHFADLcqxEYw==
Message-ID: <ff9ba731-8d17-b98c-5b24-4ff831f6aba0@collabora.com>
Date:   Tue, 13 Dec 2022 11:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 04/12] ASoC: mediatek: mt8188: support adda in platform
 driver
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
 <20221208033148.21866-5-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221208033148.21866-5-trevor.wu@mediatek.com>
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
> Add mt8188 adda dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> I don't add Reviewed-by tag because one new header file is included
> in the patch to resolve compiling issue found by kernel test robot.
> ---
>   sound/soc/mediatek/mt8188/mt8188-dai-adda.c | 632 ++++++++++++++++++++
>   1 file changed, 632 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-adda.c

