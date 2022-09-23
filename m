Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590465E7654
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiIWI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiIWI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:58:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9A12CC93
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:58:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 641636602240;
        Fri, 23 Sep 2022 09:58:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663923487;
        bh=HJCmthvkr+gqFl+ypmaWbwlJdZFD1jQ1jtfY4oRGN0U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CdH81/NfnL068geDlhZWlsl4y4X/E43jS7Jq3ESt/Hp+uVCeKoTTf8ONycYJN56+K
         MCVX0xU7hJShi/kC1gg2SGiKxvmNgZU263jaJeD+wRosEbI8+F8EYuITRTTfTMRY0g
         GW+c7sZhLEu6Kt+7xoLjQjBzMzfQDNXh4gXsrV/4MotsW7xRd16bjMbDpJmSN7pTtO
         se8TxBHRmIBdnRR6DFnD5XIru6EeLHjR0j9keUmut9Qy7JtCuQ9BxcsH0BMTb2tqJl
         seo7OViAmjqlzxNZZQA/tUsnz+Rn4GdMMILlr9zLZcQpuHojnmL4RxzCWXLC6bzBFB
         JZoJ547+F/rQA==
Message-ID: <983bd526-ce7d-0c7e-d93a-66755db3a33f@collabora.com>
Date:   Fri, 23 Sep 2022 10:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/6] ASoC: mediatek: mt8186-da7219: Add headset widgets
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
 <20220922235951.252532-4-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220922235951.252532-4-nfraprado@collabora.com>
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
> Note that differently from others (mt8192, mt8195 and mt8186-rt5682),
> the widget here is named "Headphones" (with an 's'), since "Headphone
> Switch" was already registered by da7219.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


