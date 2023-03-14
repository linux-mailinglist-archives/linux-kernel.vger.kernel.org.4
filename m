Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4F6B8D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCNIaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCNIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:30:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EA3D098
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:30:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B977A6603009;
        Tue, 14 Mar 2023 08:30:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678782618;
        bh=M6qFztm/ezVa+YD0mmVzl87e4sLWZuNavtRGTF6m7HA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C9ii5QaA7D//gMsNxdul/2Cy0QBWxQLwwvNkJ8PMCcb2SQ5cmFO/NULLDBj3/iPeW
         FDBGBYc2Bis7hZQMH1fMYk9XLDtifsC3qM43D44a8dHnoxpq4TRBFhF5wfly2pwgNU
         kQpUA8Uw+3wTYJ7o7Olaas0Qq0G59/wK+IDRcgScmpckQrCNMR2p7WFxV5KnN/yY8e
         wAMfAJpHpLNVkBY39Vbhm+3wMeCqMrsUR/QTKgrkNE3RjXnt4vcHQuYxK3AN+dtdWl
         dsMetpN2zLY+9DmnqapIjSwo38s9t+BQnsnjmQzjQ3kS7YUgBZWuCUNyYt6NAe+UsM
         Uz5fdZ/U77XTQ==
Message-ID: <f8d1fb49-c802-5c2f-0c7a-aeea1b25968c@collabora.com>
Date:   Tue, 14 Mar 2023 09:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] ASoC: mt8192: Remove function name log messages
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
 <20230313212908.2282961-2-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230313212908.2282961-2-nfraprado@collabora.com>
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
> There are some log messages in the mt8192 sound code that print the
> function name, presumably to aid in tracing. However this can also be
> achieved by ftrace and without spamming the console, so remove these
> messages.

Yeah, I totally agree.
Did you check the others (8173, 83, 86, 95) as well?

> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


