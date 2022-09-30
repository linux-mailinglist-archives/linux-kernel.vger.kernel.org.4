Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0E5F0674
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiI3IbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiI3IbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:31:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA43AE7C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:31:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02D0066022BC;
        Fri, 30 Sep 2022 09:31:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664526672;
        bh=hyzAPdeSGpzLQiqFjtdw3u+LQdIwNgVeLAnrDszyXUc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bx7NwB7o+zEJHuy1oiC7fF5w0uTmDeG0jn/Yas48CisfPf2O/6C7qapFGW5BSsTjt
         ioRN5aq3EDcFInODuNhuPH//Q93ymyHk5mUBTLT+8L7eBNi75DI+nqj91m8LN7vpNL
         fIiwyaeOux/MdfGk+wn08ABf5jhxChB7KzHRveSC9wj2oEGHVLH1NX2zDkKrBXK8kf
         ZSg6F+tYYsMPWZUf2ySce0a6b87Vib5eurcHzZjCtIyMjuaQZdU1NQFa1F0CJp4T6J
         hEI85V/S4JoH0mtBvph0f0Lv75K2/rZCKcDsZB0JorJwm5ASr/VZtvvK8EIwTs74NB
         aRf2Slw9bcoBg==
Message-ID: <2d378b26-2e08-72ee-a032-20aec436b6f4@collabora.com>
Date:   Fri, 30 Sep 2022 10:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ASoC: mediatek: mt8192-mt6359: Set the driver name for
 the card
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220929205453.1144142-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220929205453.1144142-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/09/22 22:54, Nícolas F. R. A. Prado ha scritto:
> The ASoC core automatically populates the driver name field in the card
> from the card name if left unset. However, since the driver name can be
> at most 16 characters long, wrapping will happen if the card name is
> longer, which is the case for the mt8192-mt6359 driver.
> 
> Explicitly set the driver name for the card in order to avoid said
> wrapping and have a readable driver name exposed to userspace.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


