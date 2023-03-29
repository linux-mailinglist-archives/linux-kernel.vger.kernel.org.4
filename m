Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE36CDAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjC2Nh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjC2NhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:37:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB615527E;
        Wed, 29 Mar 2023 06:37:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AFBD6602EDC;
        Wed, 29 Mar 2023 14:37:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680097029;
        bh=jw6n+X+JHIaas8VBWE1sZxdqpL6FC797U9ot+cYY+c8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kusL0qH2YilLjFOM2MOtUxR0rkYp6n1cS8Yc9B3IOosrc9qh4oXLQZP8zfcibVcQI
         6kgfffMPIyhpJ0VSZMPr9ACbmE17HrjqlFcWetJDQ7zI2SycAYbNYux03qaMOiQ4h2
         9ebJjsTjGlMPLnfSrW1BMKEO3EyU/2lisGOh9I7cl576tCoJPXVm+O4+km3Q/k/6rI
         ojgmlbk+GkiRLfExXUsaRVh+qgdfoEMzZZiJif7EBADJytjQMEZG5KY7Z8ra0VUyTa
         qy0wqTGZIStsY6A6/jlS4VHW60U1yDwpImBRYDR0xLWbkOYjpyeoFVkUaErXop6AU5
         6kxGImSRVmWGA==
Message-ID: <54441f6a-cdb7-eb49-bca6-59aa9e828160@collabora.com>
Date:   Wed, 29 Mar 2023 15:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND 5/6] arm64: dts: mediatek: add larb support for
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
 <20230207-iommu-support-v1-5-4a902f9aa412@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207-iommu-support-v1-5-4a902f9aa412@baylibre.com>
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
> Local arbiter (LARB) is a component of Smart Multimedia Interface (SMI),
> used to help the memory management (IOMMU).
> This patch add 4 LARBs and 2 clocks for the larb1 and larb3 support.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

