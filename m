Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA30619343
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:17:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BCA308
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:17:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6B3F6602970;
        Fri,  4 Nov 2022 09:17:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667553425;
        bh=eB0KGbIiuhaa7Ejg+arm+EfX+jhy5PN6L0x3ItdjVX8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ik4RwhotjdGG94mOAf1bd9wepjsXZAdCqLaKbH0gUHcM1TgMlGjDE1LWaKNHlG5n2
         Y9hpU2uAu5rMyCmqfnFlZSZbA9fc3ZdKtfDi/3S1ryvkyB726Ls/rlp9pVUGvygtAJ
         B7GMkoPpOUAeMX3vXfefUh7s/K+clCNICX6B+i1FBrsMw7jEFiWOdGUucuBVI/5YYI
         q4uQ/GZuclpYAEpiUgZlPpuetMvgcFqeoQGlhq2ntQyA5Y5GwTnLfSzozGCkuDHULP
         5CVHed79j/GvDUq81c5j24LYQekL71Z7a0iwmPE/VBPqRjEdgdMHODzhq9qKFHnDuR
         dNt/sox/a1/rA==
Message-ID: <e739b1e0-7c07-0604-25bd-dfc711599608@collabora.com>
Date:   Fri, 4 Nov 2022 10:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RESEND PATCH v3] soc: mediatek: Introduce
 mediatek-regulator-coupler driver
Content-Language: en-US
To:     matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com,
        dmitry.osipenko@collabora.com
References: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
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

Il 06/10/22 13:58, AngeloGioacchino Del Regno ha scritto:
> This driver currently deals with GPU-SRAM regulator coupling, ensuring
> that the SRAM voltage is always between a specific range of distance to
> the GPU voltage, depending on the SoC, necessary in order to achieve
> system stability across the full range of supported GPU frequencies.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
> 
> This driver was successfully tested for more than 3 months.
> GPU DVFS works correctly with no stability issues.
> 

Hey Matthias,

gentle ping for this one...

Cheers,
Angelo


