Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886135B30E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiIIHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiIIHwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:52:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296A1BEBB;
        Fri,  9 Sep 2022 00:49:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DEFD6601F9B;
        Fri,  9 Sep 2022 08:49:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662709750;
        bh=jMGgQw3flSvEElU0iAiEiuXLD9yc+tyfB4ZbbObfSCs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lqahKRi5D2fcH1XTZOcLLNJxVA8+jnjRiNNWbq05YAqMDCWlMh/37KaueNTxEGT4C
         1EAgD+7qpYuDQ7YzSNU2+gJs8K99DRBEkjmGXVNskV4EY/a1GAG19u7rq5yFGkaFQW
         QCfMGJTHb9HIns0wO91BQuJUSVwb/IRmpE5unXPatduVx02qRwHjaUtWE8102MkblG
         0okIN5+AzfY4R73Rhd09pOpmit01q3JNSP7mYlHwcLD4OVfqg+NbT3iqSVZvajBRqu
         phh6LGYrHF7cAd1OhPp/XAhkSxmfYAwM4TpfOB3owWbBbQmymBUVaMZOtmtFI546Pt
         cQmCEMkaW+F2w==
Message-ID: <5032e29d-dfa0-e071-b3c2-845136443b0e@collabora.com>
Date:   Fri, 9 Sep 2022 09:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] dt-bindings: iommu: mediatek: mt8195: Fix max
 interrupts
Content-Language: en-US
To:     matthias.bgg@kernel.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20220908141529.1478-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908141529.1478-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/22 16:15, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The mt8195-iommu-infra has five banks and one interrupt for each.
> Reflect that in the binding.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


