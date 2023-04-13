Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E010B6E0E60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDMNSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDMNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:18:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F52D44;
        Thu, 13 Apr 2023 06:17:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F5626603218;
        Thu, 13 Apr 2023 14:17:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681391864;
        bh=AKdwCtT8AfTALdA/zT12K56nin3cggmWrGxfMSOgZfU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YJVtAcCK0erupdx7mB0Yi+0evnU4PRAj7tacSem0um7VfGlqlvhRaRAD4yWjHmsQ4
         f3sgHre/YRWFk2c5CxLvY7rqKMU4k0d8WON0H25AUVd3quopPamB7MniHkDSkAYbAu
         IwglaX143kKSBm3a/T4fgG+eybIGrSXbMNkpjWVCDD7z3JxGF0Mw6AgSRvvdpad1DQ
         1CXmFCfGfURTcyCokZKs4jk9z7CsjLB2i+G9KbMfrLZHFnRM0mnATSTRoD+N4pjoE1
         oqBkCfpKQeTYKDUXvyEevV2FDXqDWmdrpGAheRQBijSKpb4UQjQU2w0a0l+eDyWQK7
         AL7Vw7RWcPEuQ==
Message-ID: <b59fd0d6-b08e-9c80-a2f0-6b6084038353@collabora.com>
Date:   Thu, 13 Apr 2023 15:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/7] ASoC: mediatek: mt8188: remove supply AUDIO_HIRES
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
 <20230413104713.7174-2-trevor.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230413104713.7174-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 12:47, Trevor Wu ha scritto:
> AUDIO_HIRES is not required in MT8188. Because top_audio_h is disabled
> when hires clock is not used, set_parent is a redundant operation.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

