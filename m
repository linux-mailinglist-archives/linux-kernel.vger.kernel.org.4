Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5860729D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJUIld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiJUIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:41:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B6224CC8B;
        Fri, 21 Oct 2022 01:41:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 714336600362;
        Fri, 21 Oct 2022 09:41:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666341683;
        bh=WANU7m9hgqToTw/RP9cHBA0LoJL6y7ZdfH4haHnLtdQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BkFQu0ngUOp5evXfQqcRE2qZIAuLB3yU7igIYTzhEqQ2bVP8Ykj6FEQkq06dmt6B1
         iKzlznsYz3XOhWYnoyyC0+isM+UwVAZAC3SROnR8rr8MpSYbZlG9SQmmjcqMd7t2Te
         /FjMpQbhC2vqO3ea7+HUEMJ8KRAKC0Eics5KXzr5OAL24mTUb1Jqh0Y6uENB1AACwW
         6CNkdBRm/dGzQQzuIDYy44m71NFiMXqm5jfNOGwV3GBQOxdDZmnaw855IksiHE4xzh
         d0FLvcI1CZDKsvw8mb2CxgROoarw+N2VinCFV+3WzQp7QtdqwpmzPxta68E8KAAihK
         Bz2m9pP6AgB7A==
Message-ID: <1de8f6f4-a023-8214-c584-3f7436c98f42@collabora.com>
Date:   Fri, 21 Oct 2022 10:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 05/12] ASoC: mediatek: mt8188: support etdm in platform
 driver
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
 <20221021082719.18325-6-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221021082719.18325-6-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/10/22 10:27, Trevor Wu ha scritto:
> Add mt8188 etdm dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


