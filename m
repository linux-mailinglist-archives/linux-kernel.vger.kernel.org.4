Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16132671B88
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjARMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CCC366B6;
        Wed, 18 Jan 2023 03:26:25 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A0606602E0B;
        Wed, 18 Jan 2023 11:26:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674041184;
        bh=TZa+V1LhkWey8bm3oH+yJt3PmzhTZNJXbV1NIoHPsPk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B3i27dX1GwzCbsjzOfbjgmGotgiUhd/C82YhEHJ5UVdLoIUXchaHILZPGpw5/B3O3
         jGK0UuHMlxBZ8xsmANFlvG6tO09cU6jgy3nkK7Ixh0k0WuFM98XhhYho4Ci1OXVzum
         yg5UWOCogBFiEDQPPvnS06umVkwFAIFMK36jCv2dMGQ38fcnjPjojwPmotsH5HPRHb
         vDhkflAPr0mAhxsvUDcDdt3qxKs/ZcYFlXBZ4MsrBq+f49AG/MX3s4jtv59v5GTBs4
         6lnE4FKVPb4U6HxRjZBdEXy7kDWpFzaAhmjCWajz2Vs0D1eIeeamD/aTPgjSYVMb7T
         6jnzckf8SWBpQ==
Message-ID: <d8a19ad0-4db9-2c8b-d9db-63a0831dde52@collabora.com>
Date:   Wed, 18 Jan 2023 12:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] pinctrl: mediatek: Initialize variable pullen and
 pullup to zero
To:     Guodong Liu <Guodong.Liu@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
References: <20230118062036.26258-1-Guodong.Liu@mediatek.com>
 <20230118062036.26258-2-Guodong.Liu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230118062036.26258-2-Guodong.Liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/01/23 07:20, Guodong Liu ha scritto:
> Coverity spotted that pullen and pullup is not initialized to zero in
> mtk_pctrl_show_one_pin. The uninitialized variable pullen is used in
> assignment statement "rsel = pullen;" in mtk_pctrl_show_one_pin, and
> Uninitialized variable pullup is used when calling scnprintf. Fix this
> coverity by initializing pullen and pullup as zero.
> 
> Fixes: 184d8e13f9b1 ("pinctrl: mediatek: Add support for pin configuration
> dump via debugfs.")
> Signed-off-by: Guodong Liu <Guodong.Liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


