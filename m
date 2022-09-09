Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFF35B2FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiIIHfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiIIHey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:34:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E736DD9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:34:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D17B6601FB8;
        Fri,  9 Sep 2022 08:34:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662708882;
        bh=UX+vi+FdnLov80MlTgas9MMxCaC7dGmiE21tUnnYlkw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fYqple5AGtnvz9nIggKzsiVfg9ersxHSb2UJiEBqEb5qk54iOdalXoxti0AnYFaEn
         4Kep4SfSfHJBNMiTKMU4s4P5MlSJiDv8ZfpjqhkZzi7BStCyvYgn3AO+eS4MeuLMsg
         728ykeOuDsnqBUQ9aZGU7YyuK5y3REpr9D8UBdAC6iDJOUwi52DFT+P/xs8iZ+RG+R
         s5HuIKUKt+pMwImBOmy6N3qTv2vDNMeEb2G7iKphDqsr1OtVDoWp7CUSbzzCQBuinJ
         Mi/axLFu2OiOWHqi20ydk27ZSxY43d20x1RRTLZ4SZbuBeyYKtqNiYXKp3oJQtGHDv
         ISI196tY9DUBg==
Message-ID: <3b7f5a3c-c1f2-7bb3-7583-74b244d9fc13@collabora.com>
Date:   Fri, 9 Sep 2022 09:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 02/10] ASoC: mediatek: mt8192-mt6359: Make i2s9 share the
 clock from i2s8
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908161154.648557-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/22 18:11, Nícolas F. R. A. Prado ha scritto:
> Both i2s8 and i2s9 are connected to the rt5682 codec and should share
> the same clock to work in a full-duplex manner. Set the clock sharing
> during the initialization for rt5682.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[For MT8192 Asurada]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


