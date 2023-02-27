Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E516A3DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0JGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjB0JGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:06:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09DB752
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:56:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3AF786602216;
        Mon, 27 Feb 2023 08:55:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677488108;
        bh=TMi4EMDMJ6BN+G43IUeSNqmzFjjGoOITcOTDgs0VSYM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ljlsB1ra7Ty9HhGq2NFp6Bc47GzvflrpVfEmvUEbWZS95vIELcjJNeKM42l8azOrX
         D8rL642+hjIqgCXm0ypYkIYUzTTmHm3kzLuLM7hfP78KOc6m8aVjOUEpGENff1GHSG
         pihyoJueMobh7WmKB+hgibecmYvgdMvi4vdtvoPDT/GuXCE8V/F6Vgh4HTtGfaWHLK
         LzQwwFpFeMDrkaRshDG9xQwklts5+uhHFbLaqUrXZGnpE1+YkJ1yBWiKA5QyNe+m/2
         PTq+0AXDfJPKRqpn8ieN3TqLurwxa0kLehCa2cJbM2hIRSLQGWq2kHKFG7/u5BSz4B
         pJR211/AOMxpw==
Message-ID: <ece739cc-7d75-8f99-2a43-06ff8490c5b8@collabora.com>
Date:   Mon, 27 Feb 2023 09:55:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ASoC: mt8183: Fix event generation for I2S DAI
 operations
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
 <20230224-asoc-mt8183-quick-fixes-v1-2-041f29419ed5@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230224-asoc-mt8183-quick-fixes-v1-2-041f29419ed5@kernel.org>
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
> ALSA control put() operations should return 0 if the value changed so that
> events can be generated appropriately for userspace but the custom control
> in the MT8183 I2S DAI driver doesn't do that, fix it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


