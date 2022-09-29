Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44E65EF05E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiI2I0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiI2IZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:25:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD3753B0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:25:54 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F236C66022A4;
        Thu, 29 Sep 2022 09:25:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664439953;
        bh=T14ztLUs3rI8WCYFeVow59cGotkbxkhfqFyrn4lich4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dkIMSdX2YSzFIAgYHMUXlbqpO7RE+ykm5Pd5VlsmxdNEkHq5sRgX3fM8OY3P3okmH
         r8FFuF+GnO13BuoSdixsW4DQUVF9b9GS7QM3WPZqeWvp43OK50/VBnRJRyBhtUnaUR
         av/YxpPC56e1DVb5OaMe/4Kx6TYIF9kEk3XdOuVEOXJfOu2PEqOm8ekH45xbVPsDfD
         NhEXMMyRzyLRt8XPE7Zb3eUzOjpPD5zsKrp31ED+ffeDt62vjnz/8d+A9rfZxP6dvj
         mBz37t42S9wdT6DSKltNQcVl1TOUJCTINoKXn8YzgbIAhkTkyuq5qyKRqLhTyaLfEv
         LWxnqh29pdY3Q==
Message-ID: <31b6c672-a11a-9317-49e2-9be910edfefb@collabora.com>
Date:   Thu, 29 Sep 2022 10:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/8] soc: mediatek: mtk-svs: clean up platform probing
To:     matthias.bgg@kernel.org, roger.lu@mediatek.com,
        jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
 <20220928155519.31977-2-matthias.bgg@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928155519.31977-2-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 17:55, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> We only ever call the SoC specific probe function from
> svs_platform_probe. No need to carry that function in a global
> datastructure around.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


