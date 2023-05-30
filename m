Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD9715A06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjE3J0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjE3J0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:26:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50F118
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:24:59 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DEE066059A8;
        Tue, 30 May 2023 10:24:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685438664;
        bh=UxXpx3aCfdtvsZ7o/sxTS7TMZU8J1MoTtG1QqqDdXQo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lRx5ZsdzzjoqMAlmwmL59/ih5u1B5vJrqmwj2EkfEfk7AESduFUHr5PZBk4ELoQy0
         M4wDaPFfP2IJX79OQ5hn/HHtz3YB/czhA2YsNpuHswYxQOeE9OVDnQ06sFLTLHzZxy
         3F8sC5SCftMnd3TEsZBzBCgEoj3by6Jkc2HH0CIFUsPwKL6mA0fmqBZogWk674oZsm
         gMncP6FO7llvCrTwnqn46tZMExUQwfcd0fwGcdpaJPpVdL5WdkLv9sJtkqhm8aARvk
         Wv8gn4m/sUcZoYF6qdyJvL451lm7NPGtpPezHoRr9hSI/6OtuaZ1G+QuOywY8/p0dZ
         i+//3DFuoQ2ZA==
Message-ID: <550e2571-97b9-48ec-db2e-63e553b05d1b@collabora.com>
Date:   Tue, 30 May 2023 11:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] phy: mediatek: hdmi: mt8195: fix prediv bad upper limit
 test
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230529-hdmi_phy_fix-v1-1-bf65f53af533@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230529-hdmi_phy_fix-v1-1-bf65f53af533@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/23 10:43, Guillaume Ranquet ha scritto:
> The pll prediv calculus searchs for the smallest prediv that gets
> the ns_hdmipll_ck in the range of 5 GHz to 12 GHz.
> 
> A typo in the upper bound test was testing for 5Ghz to 1Ghz
> 
> Fixes: 45810d486bb44 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


