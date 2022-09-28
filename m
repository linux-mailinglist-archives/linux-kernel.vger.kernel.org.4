Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE65EDDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiI1Nfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI1Nfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:35:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D48E0FE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:35:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA8946601FFC;
        Wed, 28 Sep 2022 14:35:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664372144;
        bh=AooCL7bWhJCQhuXaZSxdLDCqtYCwkPYUXtio0wi7j2c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T0UESf2jxccqO5gCHojUz8JLNXNr4uwDlsw8x7KxA6eWoTgAqLrqpT2wysFMd1jVz
         wWwu70DVqAkQ/6kasBvedRR+lYDyKZm4J/DjBOjwMOl+Og8pLJG7a0WH0DgdsjP224
         O+IlHCmWGzbI4hzU79Zd7vdB97a1XOa2Qekuf+pm5FtenJvU0LjK+gql+tXk4kCcxz
         j0zc5AKjnva2TFVrXHkpVVtb373HEDC0HvANMrypxw2TClrmEQjWE+lkFBC+LK0JeT
         VLv2NFPP2021rYbPpvdICyix6pS8D+zUawIx3pBmoyFX9A6s3k+PiTHb8961+4HVX+
         eKVJqc2n8SIZw==
Message-ID: <6ae64f49-5ab9-0b37-ae2c-5519c21a5d73@collabora.com>
Date:   Wed, 28 Sep 2022 15:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/2] phy: mediatek: tphy: add debugfs files
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20220928093041.31481-1-chunfeng.yun@mediatek.com>
 <20220928093041.31481-2-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928093041.31481-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 11:30, Chunfeng Yun ha scritto:
> These debugfs files are mainly used to make eye diagram test easier,
> especially helpful to do HQA test for a new IC without efuse enabled.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Even though this won't be interesting for the vast majority of the people
out there (the users!), it's still nice to have it for IC testing performed
directly on upstream, as that opens new possibilities for you and ODMs/OEMs,
so I agree on getting that code upstreamed.

For that reason, I think that the best approach for this one would be to
enclose it in a configuration option like CONFIG_PHY_MTK_TPHY_DEBUGFS or
CONFIG_PHY_MTK_TPHY_DEBUG, so that this very low level debugging code
doesn't end up in end-user builds, as that may, in some cases, be even
dangerous.

Regards,
Angelo

