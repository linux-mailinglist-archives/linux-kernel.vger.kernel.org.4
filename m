Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC04637647
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKXKYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiKXKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:23:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C688B14A2D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:23:12 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18D596602B19;
        Thu, 24 Nov 2022 10:23:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669285391;
        bh=ep0/8WFmmF1DLAjStgRC+286Uemc17K0xldJybIShBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=awkyrvSeqIxToj4LbnERqzihnB06rBYL1VQ8mappgQrBM8rxkeA7GHzEVFAoTZ44g
         YaYyRFSzIJ1E6UsjmG5dKkPujzeDcPfNqMcU/gsIlCReMvv9nsANFPvM4+MiwnkY3H
         nX8PUc55Kmw2f+BdY78sCZag5dQPJWLOOY0Xu3ZTtUK+nnjnHmOl2uVre+ek9sBBIF
         9o3/SgLy5Qk9mUrg5Uv8RDfclM7ABCfpAxFWRY3MbRUANNVYsXm5/4F6/6v0erU23D
         I3Er7mbzYdneoDgn12Rp1whvWCCG86C3pjqi9XhlaUcGeXAwPktI6txYKno1sQzb+M
         SAAMrTM8s07Hg==
Message-ID: <38ac71ce-b38a-4fb1-ba21-aa5c91283bd9@collabora.com>
Date:   Thu, 24 Nov 2022 11:23:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] ASoC: mediatek: mt8186: Correct I2S shared clocks
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        nfraprado@collabora.com
Cc:     chunxu.li@mediatek.com, ajye_huang@compal.corp-partner.google.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221124023050.4470-1-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221124023050.4470-1-jiaxin.yu@mediatek.com>
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

Il 24/11/22 03:30, Jiaxin Yu ha scritto:
> In mt8186 platform, I2S2 should be the main I2S port that provide
> the clock, on the contrary I2S3 should be the second I2S port that
> use this clock.
> 
> Fixes: 9986bdaee477 ("ASoC: mediatek: mt8186: Configure shared clocks")
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Sorry, had both versions open and I've sent the R-b tag to the wrong one.
I meant to send that only to v2.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

