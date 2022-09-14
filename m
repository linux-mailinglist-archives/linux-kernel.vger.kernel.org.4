Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF22C5B8247
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiINHvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiINHvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:51:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C6372EDE;
        Wed, 14 Sep 2022 00:51:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D1D3660201C;
        Wed, 14 Sep 2022 08:51:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663141863;
        bh=BZ3bTim8z4XcxaNDPjTy0uVbUWkSCmK5PftKdZOvCpg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G0SHx2R9GZNuQvlDGwSq4QsrEeyoydvoRrJGnvMNiWtxZpoYnOpPzJzBZZLeMlkyl
         Ad1C8lwEeWsymjNn/lwdH/yQviqQZbAKUmygxW7Y/+chmXRfD69deHmUjciIzkWOpM
         4hP3/f34STMmFAE/HRDe9K8J8w5/VCy1TO+86BEJRUZSLSkjjtuV5uFdjX/b3L1ozK
         wIh7svgYcU6f8neoCGko9i4+x26xay22NDQB8+o01j600at+5jflR0hiZJzB12N3sL
         esvDWUfSmR0687VR7lH7Z1NwLbfGM+iTBbJcW62H5KWJ/t8T68tyzMrrwgywUTB5UF
         dic9YkzDb3E7Q==
Message-ID: <b8f71935-bde0-ed2d-049e-cb64f8f0da6a@collabora.com>
Date:   Wed, 14 Sep 2022 09:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 5/7] phy: phy-mtk-tphy: disable gpio mode for all usb2
 phys
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220914060746.10004-1-chunfeng.yun@mediatek.com>
 <20220914060746.10004-5-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220914060746.10004-5-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/09/22 08:07, Chunfeng Yun ha scritto:
> Disable DP/DM's GPIO mode for all usb2 phy, not only for the first
> usb2 phy which usually supports dual-role mode.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


