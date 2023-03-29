Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B46CDAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjC2NhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjC2NhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:37:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280F49F6;
        Wed, 29 Mar 2023 06:36:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A670A6602EDC;
        Wed, 29 Mar 2023 14:36:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680097015;
        bh=7jiQMzP/m4JjnZTPfL9dVb5A2MzU0R1L41dhstba18Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GJYK0UQHD/W+L5SDD9MwzFt3Sk2VfSK+EjnxPoPNamuN6uVTXYzBWu0QBHXIEynLz
         x9pwb2M+xndTou3CWo5Ws38dGrtNvebwB5z1CL9j4bQQBPSclk2TfFYmopuGWUf8iv
         XSyB2PN/iNF1+owr1crOwymzwTrqVFKuxA8rzO26PUw7A7e8IVD0Dd/ZU+nwxs8CtU
         qVKXq/aLwn3WuRnQCGsJV7D6VPOKoPdSoDRZXVDA9g/s03C50vVPGkHNN0d26sPwSH
         l4NSP1mffGJJA2+niazxJqrDJowbf5OXIEgw24ALWWbfv4Qf/o806BCuz5Fb1N4pqu
         CSseY2kVUv48w==
Message-ID: <223cd4b9-839c-afef-f84b-5ca6753f2631@collabora.com>
Date:   Wed, 29 Mar 2023 15:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND 4/6] arm64: dts: mediatek: add smi support for
 mt8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
 <20230207-iommu-support-v1-4-4a902f9aa412@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207-iommu-support-v1-4-4a902f9aa412@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/23 11:52, Alexandre Mergnat ha scritto:
> Smart Multimedia Interface (SMI) local arbiter does the arbitration for
> memory requests from multi-media engines. Add SMI in the MT8365 DTS will allow
> to add local ARBiter (LARB), use by IOMMU.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


