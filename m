Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8D5B8241
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiINHvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiINHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:50:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1504D4F2;
        Wed, 14 Sep 2022 00:50:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4854F6601FA3;
        Wed, 14 Sep 2022 08:50:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663141856;
        bh=3T5SQxFBMEjJX4Qw5hQM8ZcMUKcEzM5CjnkjKW21j1k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KD3U750oIjMKg9fBPcRbFzf7p+36wQepJ1r1OWtgGKs7JBmzld9PjcxuqQkCnrb5a
         AwIs/cqC8asIgDqQpY+ttmil8ezq9ILrqeHIK4EbQx3ma/j79RiEeOnTvFVH5bMLsy
         Ynq/Mz7u0kgxs4wkPfJvynscwgriq6+/S+TKvDirmDijs44pTFYoH7XjQOJ3Ei2oNf
         Pt11U8AitSW/5+sT/u4vsZEwlWLRBP51tLVnW2DoBvmm67ohcstrj8N0IuAJbrjiQC
         hgK9rSyR/JIashKS0rlCYlx15atnXH5Yh9HVlQzReXe2jLtKuW7D7PKg6Z7sddm8mg
         UteiBVAUyEkgQ==
Message-ID: <2de048b8-00fd-cdce-9ac9-e234c88db9f0@collabora.com>
Date:   Wed, 14 Sep 2022 09:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 6/7] phy: phy-mtk-tphy: set utmi 0 register in init()
 ops
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
 <20220914060746.10004-6-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220914060746.10004-6-chunfeng.yun@mediatek.com>
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
> No need repeat to clear utmi 0 register in ->power_on() and
> ->power_off(), just do it in ->init()
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


