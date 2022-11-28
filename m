Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB10263A994
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiK1Ncn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiK1Ncg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:32:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625FA7;
        Mon, 28 Nov 2022 05:32:35 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81351660239A;
        Mon, 28 Nov 2022 13:32:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669642353;
        bh=XJTvBmQ2k1bHpiozbV7N2H6jFS+y6PUBq1kYOY6o0lM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uyz1aEMSnOaVfIlvQMJfkoc/TJsEMrB3D2iKl3BTPPvHl7dO0qF102SUQu+cjS8D5
         rvpveTlJnmbjAfTDjO+p041sP6FuHGiUOVPhVxd83SpSeAFlGRrLW2RyhS79IGJ9eG
         d0uvwyOc67fXuJrHDVxJ0jXsIViPW6p02Z99U9vK9VvykmdqKtIcpSM4mzYxsy0ORJ
         FM1R0N8k2juWY0qUVLfPo8ge37fWffTkU0M79rwFOn2wEcKWYyZ53cEOuJDBGMaySb
         RIE0i09Xn0Y6PdCUEu4KyoUtqcUzt4YWRE02fvHsd6gEsrO+rmA6eqVVpsQN6PZHKy
         fwk6dnwJOdo7g==
Message-ID: <14cba472-87b1-001e-30fa-674e4102130d@collabora.com>
Date:   Mon, 28 Nov 2022 14:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] spi: mediatek: Enable irq when pdata is ready
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221128-spi-mt65xx-v1-0-509266830665@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221128-spi-mt65xx-v1-0-509266830665@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/11/22 12:00, Ricardo Ribalda ha scritto:
> If the device does not come straight from reset, we might receive an IRQ
> before we are ready to handle it.
> 
> Fixes:
> 
> [    0.832328] Unable to handle kernel read from unreadable memory at virtual address 0000000000000010
> [    1.040343] Call trace:
> [    1.040347]  mtk_spi_can_dma+0xc/0x40
> ...
> [    1.262265]  start_kernel+0x338/0x42c
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


