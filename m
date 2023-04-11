Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76C6DD566
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjDKI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDKI11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:27:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421DB30DF;
        Tue, 11 Apr 2023 01:26:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A64666031E2;
        Tue, 11 Apr 2023 09:26:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201580;
        bh=1EJIU+CRPpP1xKF3/p64yjfQTt6nYIObhWzz1RZ4Ikg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q2FF9hYg51YGmo61pOtWIJZZWjfwKpZVisempjxWqN40K87NBkF2URkZ+Jxc4VGXh
         HXs8j+F2PUHvTDAju5jbaYTmHZbqHwMqGCFxS3gmzrebv8dz5bhlOyeCCNfhdBZBeF
         dqQSJlxtdkhehdbJbPVhtrutqpxZUaZZ5bBQwL5rswyZFgM11IujBKStdoOadFQuMp
         Q8bwTfOAiZY/DuDKn0BThodOXzG/Q3F7pxU6KvrDFwt5/hQLsOXRyIcQXiOy0I3xbP
         z7YutKD+ppmiEgMJqeh7vtS0g8VnyGUhFd4eiDXQnkoIkvgAnf1ibaHe5/KCXx7V2x
         4qa/d+Kecy8dw==
Message-ID: <449ba03e-4187-e3ae-06ee-a51810533d9e@collabora.com>
Date:   Tue, 11 Apr 2023 10:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 3/7] arm64: dts: mediatek: add apu support for mt8365
 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
 <20230207-iommu-support-v3-3-97e19ad4e85d@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207-iommu-support-v3-3-97e19ad4e85d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/23 11:34, Alexandre Mergnat ha scritto:
> AI Processor Unit System (APUSYS) is a highly efficient computing unit
> system which is most suitable for AI/CV algorithms. It includes one
> programmable AI processor (Cadence VP6) for both AI and CV algorithms,
> and an eDMA engine for data movement between external DRAM and VP6
> internal memory.
> 
> For more detail, ask Mediatek for the MT8365 AIoT application processor
> functional specification.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


