Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EFB725676
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbjFGHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbjFGHws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:52:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216731BE1;
        Wed,  7 Jun 2023 00:51:56 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E0B816606EE3;
        Wed,  7 Jun 2023 08:51:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686124314;
        bh=OL6a+74rgSLOjh1XTzq5rghrVaLQdAGMurMRtvvZFIU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X4Qhgr4m+UfwkPMV3xKQu/gKzqxUfdzwBkmsISXJgmv6w3xKsErUXNmRmZwxX4Pre
         gv83wNM6Uve+omoUtSSSuoMI6YrxF2wjrM85x5QbW77NAEkFePNaMnMnNwc0Pq9BJD
         QFYFd+xFLDH7yo0VVMF7lHhVpQujBEsD3LHe3wL248Lpd8KT68Th2hvGgDeu3hzn6i
         mRECp3ztJt2yC+RvC6lMawGKiSG1Ot2X2BrR8FwICZLd9++jmkLsKNdW6vhhM37U89
         cvyRr5iYMcOQZidNbq6AXLBKysaQPIxpF0R0HdBwze9goSCMqAOkZ5pJDNRYpJcSKc
         kAMTr0gFlNSyA==
Message-ID: <72b71e37-f9e7-b182-824c-163d920723b8@collabora.com>
Date:   Wed, 7 Jun 2023 09:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits
 for VDOSYS1
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Fei Shao <fshao@google.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
 <20230607061121.6732-3-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607061121.6732-3-shawn.sung@mediatek.com>
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

Il 07/06/23 08:11, Hsiao Chien Sung ha scritto:
> Add reset control bits for  MT8188 VDOSYS1.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   include/dt-bindings/reset/mt8188-resets.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
> index 377cdfda82a9..439a9a25ca19 100644
> --- a/include/dt-bindings/reset/mt8188-resets.h
> +++ b/include/dt-bindings/reset/mt8188-resets.h
> @@ -33,4 +33,16 @@
> 
>   #define MT8188_TOPRGU_SW_RST_NUM               24
> 
> +/* VDOSYS1 */
> +#define MT8188_VDO1_RST_MERGE0_DL_ASYNC         9

Sorry, I've just noticed that there's no index 0 in previous definitions: this
is wrong, it must start from 0 and must be sequential.


