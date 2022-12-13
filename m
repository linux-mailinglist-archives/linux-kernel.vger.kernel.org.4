Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC464B395
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiLMKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiLMKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:51:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4CF3E;
        Tue, 13 Dec 2022 02:51:25 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24C536602AB2;
        Tue, 13 Dec 2022 10:51:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670928683;
        bh=CPtGI1Gm3EBQgjAgidWD2nOZuLxuahaQPZx80t2p9Aw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FnrvvckKqFm5f5w5WSHzXga8eY2j1Zlh+4OwBbS2cgSCLJZItOxhwN6OTwKpdOuUM
         6dfWe2dg+1EtWVaY94pImHhAp3wxFnp69+M7DmeeRY3Vw/KJoC6Rq8rBOJXr/gdFY3
         njevkjoaQIVXuCnREJvnm6lYKgA/p4UsgCFp549Wj1YkyS+XQ2KLYUsqR1/jFBmyJ8
         /n1RMpwIPFB2qjrsY1ZwOeWR8l5VgJqdUXx55E9N159VDIwfpsUdmx3fx0Z3uNtsp9
         biJlY4u1kt/MNr8u6vqslcs/7U3R7mQTWBX6GgIEZLPU1dIv3cEGfWTHMfzEG/IY4L
         dA5rg/9pfxfQg==
Message-ID: <2383be6d-8ddd-f12f-5083-cf837f9f9478@collabora.com>
Date:   Tue, 13 Dec 2022 11:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 07/12] ASoC: mediatek: mt8188: support audio clock
 control
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
 <20221208033148.21866-8-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221208033148.21866-8-trevor.wu@mediatek.com>
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
> Add audio clock wrapper and audio tuner control.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


