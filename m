Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7445ED70F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiI1ID6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiI1IDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:03:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D911EF61F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:03:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C882C6601EB5;
        Wed, 28 Sep 2022 09:03:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664352232;
        bh=xmhRsEBuw4qlSAtpsUjlW2Ey//cH5wIEWRMs6CYYXJI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h2hZSgQXpBnHIM1+2NV8kbvQ0zxGk+gCNVI7OF89QC+dAYjL69Sd08MYdg7LHj92z
         6I0czhiX3YaxJIgbiKlXFJEl8mtWxgxpkK+rzXftMJCHZFlZkds4+GwUwz6Hh11UvD
         2BXzBrRMp3rC67IHAa8qPt+SM0TOlwg0ip+O+zez59WgHd8eLxj9xkv/03P+0t63zt
         mhJBnm7MrZYMAJJiL00BK9OrLB1QOFdbR2uyFgCE7ZB+n49iuZwSYwPD6i47TJ2/7h
         /IB11GNb25jEfoLQjYTFIVeE270PZRMbyIOo8pQY9Guku9nK9cAhiJM+KYstJaDV0C
         cvu8j+kdyE9DA==
Message-ID: <edfc1e0a-687e-a91e-28ef-f2090d696a06@collabora.com>
Date:   Wed, 28 Sep 2022 10:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH next v2] phy: mediatek: fix build warning of FIELD_PREP()
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        kernel test robot <lkp@intel.com>
References: <20220928070746.5393-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928070746.5393-1-chunfeng.yun@mediatek.com>
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

Il 28/09/22 09:07, Chunfeng Yun ha scritto:
> Change the inline function mtk_phy_update_field() into a macro to
> avoid check warning of FIELD_PREP() with compiler parameter
> -Wtautological-constant-out-of-range-compare
> 
> the warning is caused by mask check:
> "BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \"
> 
> Fixes: 29c07477556e ("phy: mediatek: add a new helper to update bitfield")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


