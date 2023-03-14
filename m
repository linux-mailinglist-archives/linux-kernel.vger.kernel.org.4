Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B226B96A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjCNNoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjCNNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:43:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CC5199FA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:40:46 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B331B6602FE7;
        Tue, 14 Mar 2023 13:40:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678801245;
        bh=SFPwXvcjYlpe+WHZRER6c+pWCXhtFKTjbX1zkF7J7ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URtjOTkW6TkqD7dIl9lJAed9SJ5pALFeq7VnUAo7hHEoDZCN5h8tZVJai+SwcL/30
         QbYGjxpYRH0EvmOVkKhfK44JjvFbZUUOsByrNE5H7OXm5MRzdBA51V57vGiuBoebjG
         puOPfP9F0mMRnV7ALTzcSuvlwkuqwLu1AW2HQWtTgOM9Qe8X5TPWPO/0VS4J5LpHfV
         QX2IAuX2s6UEJdz357jNLiBPDlpKGAwKILc6FWwduDBclFXleme5oLRiscHQRMVynT
         5vrKCG4nNqq+mYN6lQiferPbBCQBlyBPUS9ZHQaOCmp435gp5EvfpZ9NrM4cW4uzpI
         pzDszWupqPZQw==
Date:   Tue, 14 Mar 2023 09:40:36 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: mt8192: Remove function name log messages
Message-ID: <20230314134036.wo6oib55dhzsgv4d@notapiano>
References: <20230313212908.2282961-1-nfraprado@collabora.com>
 <20230313212908.2282961-2-nfraprado@collabora.com>
 <f8d1fb49-c802-5c2f-0c7a-aeea1b25968c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8d1fb49-c802-5c2f-0c7a-aeea1b25968c@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:30:15AM +0100, AngeloGioacchino Del Regno wrote:
> Il 13/03/23 22:29, Nícolas F. R. A. Prado ha scritto:
> > There are some log messages in the mt8192 sound code that print the
> > function name, presumably to aid in tracing. However this can also be
> > achieved by ftrace and without spamming the console, so remove these
> > messages.
> 
> Yeah, I totally agree.
> Did you check the others (8173, 83, 86, 95) as well?

Not yet. I can check later if the patches from Mark didn't already address this
for those other SoCs and send another patch/series if needed.

> 
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Thanks,
Nícolas
