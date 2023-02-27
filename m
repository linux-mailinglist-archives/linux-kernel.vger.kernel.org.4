Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B115B6A3DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjB0JFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjB0JFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:05:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C2A2BEE4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:56:07 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A540B660230B;
        Mon, 27 Feb 2023 08:55:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677488110;
        bh=EjaYFBwDB7oJOzKkOcfvbq7aToe4HGyjAniTzS7dVhw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MLMz2grNB9y1t4yGJYtvRD75Nt9J+f/ogs/R8ktXmFAbKH13/v/9tYE9QwO3c9NEM
         aOygyoizpYQ9/bN64fSRvRKdUGnZoRBptA+ERmd232Y7fIOlR2SsEyHNx5SKD/nCEd
         R/JqAN+kB2FnvWH5KFllP037SfHBTbsSIopX8nDg5xm2ol8v5c+K+Fw7MPjlkh3V8M
         rPRrL89E7Ai8fSbgm3fy8UIKE2i1ti1TyroxwZz0/jQlWO+rpYEyN0FX3in5R5bHc3
         gcJpzTo1tCn/fEsAC4oWi/cV89pMUYdtjQ25bf0SiZ4/k53jgCz57fE2FQbdQc9wor
         3Cwmt+bga2vMw==
Message-ID: <d85c5a95-046c-905d-048c-dfe5da7e5f0d@collabora.com>
Date:   Mon, 27 Feb 2023 09:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] ASoC: mt8183: Remove spammy logging from I2S DAI
 driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
 <20230224-asoc-mt8183-quick-fixes-v1-1-041f29419ed5@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230224-asoc-mt8183-quick-fixes-v1-1-041f29419ed5@kernel.org>
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

Il 26/02/23 13:49, Mark Brown ha scritto:
> There is a lot of dev_info() logging in normal operation in the I2S DAI
> driver, remove it to avoid spamming the console.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


