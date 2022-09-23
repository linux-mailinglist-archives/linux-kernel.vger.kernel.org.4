Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43035E7655
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiIWI6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiIWI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:58:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B4112CC91
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:58:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13063660223C;
        Fri, 23 Sep 2022 09:58:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663923485;
        bh=wQmu1prepFsDvoMxrwrAtiqg7HEwyKsBpugOrawZEkQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K6wTIJ1bY5gfv5Kpet4pzsWBrE1rM/8GzteW+6esTf+m1sm8opaXfNjL+9lFAv0L3
         RQdOXSqvhx3+Wt+7Vc59beI20KyZGhUwK08vhqspehoRm5V+WGqd/sdPn1/kdmTur4
         jSwY0pTEA+UKqc0BqPGhqd7hersgBQNaKzNDfRG5HF9G/WVVo+yl2kgFyyFfXmCz2k
         0OCkBIfYw3Zg4WD9MRiij1LMGJfbHXuRZw5p5nu3k4ovSQ4GIDLsQwRwEl0dxjLZ3f
         xQod9S8J43hFfiV3CIn72IWRypxJxwRuya9DeQphAfc988UliaNSqMqos05ZNx7Boh
         +cN7aPf9UoOeg==
Message-ID: <00ac0110-5369-87ec-36dd-d5f07f0b6d7c@collabora.com>
Date:   Fri, 23 Sep 2022 10:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 5/6] ASoC: mediatek: mt8186-rt5682: Add headset widgets
 with switches
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        "chunxu.li" <chunxu.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220922235951.252532-1-nfraprado@collabora.com>
 <20220922235951.252532-6-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220922235951.252532-6-nfraprado@collabora.com>
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
> Add DAPM widgets for headphones and headset microphone, with matching
> switches, to allow toggling these paths based on the jack connection
> status.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


