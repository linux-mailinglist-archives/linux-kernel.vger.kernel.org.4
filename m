Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9136B8D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCNIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCNIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:30:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426105AB7D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:30:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E06206603089;
        Tue, 14 Mar 2023 08:30:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678782620;
        bh=7O502ynukGGELoy5eu2smTVAZg2WvwENXfr+mfABoa4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bgpZlO8/yAK9Qd9L/27Jk63Ds6t31aAvwlnTD71nc3k/kJLkmhOY3yzU5BjKcNo5W
         KxEpxBnf9wLDAWdPE2gbsIeEZWuN6ubgCgWVHQbATElIpA7Vz0Qx62wREsoekrmbRz
         2Yp4vK8AQ+jXsSXvLj2Xc7vhIZ93sC1+Q6fQdFRv2w9Ro1ZOQFjwu16dPa91+ewWow
         fE0+ophxfOYrV+4QYg9dqUrIXsY02OUkWrFMDT2vQcAcNygHA37mD8cKGspj7nXJwM
         oh5UdE6yDUiJcjKQ9W/PbELp3qFIA56/SKOyPFQdGWmTfHY9R3KP2VEkn645bt2FRv
         Bt10L7gE24aKA==
Message-ID: <61425c0f-a486-1503-042b-9327f414684d@collabora.com>
Date:   Tue, 14 Mar 2023 09:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ASoC: mt8192: Move spammy messages to debug level
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230313212908.2282961-1-nfraprado@collabora.com>
 <20230313212908.2282961-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230313212908.2282961-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/03/23 22:29, Nícolas F. R. A. Prado ha scritto:
> There are many log messages throughout the mt8192 sound drivers that
> print to the info level and are triggered very frequently. Move these
> messages to the debug level to avoid spamming the console.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


