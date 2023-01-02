Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6E65B326
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjABOFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjABOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:05:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5762657E;
        Mon,  2 Jan 2023 06:05:19 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72804660036F;
        Mon,  2 Jan 2023 14:05:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672668318;
        bh=X4yzkoY/J58wbsbcidQBQ/ToqZx7DQCXL6b+4gouwQg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GdsB5uPwvhcqfqPEARN9lbwD/+nCbzVUAFNvezE5Tp3jXe0q3JF62m8Tohgq3M0Pj
         27XU44FrUFrdSnb6/xawdFcwpzEDAFqTFTMv3vs6Tv173DiTwW5NwOWReXFWg1s4oQ
         jMVDG+GUbCjj/f6JE3HxeGbMYZmyuXfAXSJZHyw/R1OZvVF+tZbI/fQhAzBSxoC1+7
         FGwZChkjZmKtQ5GCpngZJMhi8JsmIHW7WzA8Wypjcqm+0rbu8P4Vn5akxPBeVdex5r
         sduH3UDxD1/565L2zyLklxu7taoWdxUPQ11a4kAnw2vq+x2R5UpVKBGfOINIvcM6mD
         pT+jKUE8xig1A==
Message-ID: <bb488cb9-d86e-e054-9129-986dac216b66@collabora.com>
Date:   Mon, 2 Jan 2023 15:05:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 07/13] ASoC: mediatek: mt8188: support audio clock
 control
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
 <20221230055443.16024-8-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221230055443.16024-8-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/12/22 06:54, Trevor Wu ha scritto:
> Add audio clock wrapper and audio tuner control.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

