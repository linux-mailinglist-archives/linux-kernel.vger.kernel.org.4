Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8763761A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKXKTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiKXKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:19:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB9C052A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:19:36 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 839F96602B10;
        Thu, 24 Nov 2022 10:19:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669285175;
        bh=fYzwZG+btrhJNj7qcJzSFCW1tTOHZHac4nQx+C+xmJo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ladVD4h/ARN4kZRmjQ270HjSLleSxaquqisDU36RMD2TrzBG1av3lgH5/NwutbCJA
         KHeCMghCW5GrjkB6eQBL5u3gtoZi9xedOyOKf2X+rOfWxlOeD9ygiVlqhXOz4BmbDB
         DrkMiMk3NyJKBZ6oLeDTFnSWMQ+2jeha9SOBdkzA896osv1To3KlBR1YF6EyLAGu39
         Wy9zbsWKJMqKEpsN2Zw6VGlrN/pGNaT4WcSBzQvTnooeqJ8DwR5duWPsJB9F+M2GZu
         D0H8FL4CeeTrWTw3IrIwveshAusTNB/Cbviv9bnABR3+nUJaj0cJDQAljsiho6ArW2
         fBYF99C9wwrLQ==
Message-ID: <dad82c29-71f7-dfb2-a682-5aeedb1a2518@collabora.com>
Date:   Thu, 24 Nov 2022 11:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Correct I2S shared clocks
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        nfraprado@collabora.com
Cc:     chunxu.li@mediatek.com, ajye_huang@compal.corp-partner.google.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221123161130.543-1-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221123161130.543-1-jiaxin.yu@mediatek.com>
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

Il 23/11/22 17:11, Jiaxin Yu ha scritto:
> In mt8186 platform, I2S2 should be the main I2S port that will provide the
> clock, on the contrary I2S3 should be the second I2S port that will use
> this clock.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


