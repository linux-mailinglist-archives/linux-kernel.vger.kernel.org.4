Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB95E7657
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiIWI6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiIWI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:58:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF4912C6BD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:58:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 05B17660223B;
        Fri, 23 Sep 2022 09:58:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663923496;
        bh=TtjCeYOKDFThjw+4dvKD2IYNwoiHybT6ddMpEd9VHdE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O74axDIWWHuxdFAV+18mWU5cgcKNGxmjpgM/CgsKtwAObBN/wV0cYBMzAEI369zv6
         q5ADViaqzPXApn8bP2RUEMEjpTTFEHjTStXgxWdciXUqeQd5Lu5eOX92TkD8TJ5JKQ
         L/iNYYK/PYvFFzp9GDYIiRZSRLGWzBfxlIRAOBdR2oXrm+dhxxFc8BCSZI4BJyzvE8
         m6bZ8zu2lfizlkrTpA74weDDW+bYyCjnRXalbuM5Q29pRMMdN1xp+SVRO9weaEtvLR
         U61NcolypqZzUfkg0EkjeKMv24pPw3gx6YeMMz3GgxLDnyY/3UhneImx1x72qQNAM4
         0XW0jUfiSW62g==
Message-ID: <2e65843f-75b5-2e66-f7a0-96ac8925a1f5@collabora.com>
Date:   Fri, 23 Sep 2022 10:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/6] ASoC: mediatek: mt8195: Expose individual headset
 jack pins
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220922235951.252532-1-nfraprado@collabora.com>
 <20220922235951.252532-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220922235951.252532-3-nfraprado@collabora.com>
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

Il 23/09/22 01:59, Nícolas F. R. A. Prado ha scritto:
> The rt5682 codec is able to distinguish between two event types:
> headphone insertion/removal and headset microphone insertion/removal.
> However, currently, the mt8195 ASoC driver exposes a single kcontrol
> for the headset jack, so userspace isn't able to differentiate between
> the two events.
> 
> Add a definition for the headset jack pins, so that a separate jack
> kcontrol is created for each one, allowing userspace to track and handle
> them individually.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Nit: for the title... ASoC: mediatek: mt8195-mt6359: ....

Apart from that,


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[On MT8195 Cherry Tomato Chromebook]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


