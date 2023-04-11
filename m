Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A336DD565
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjDKI1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjDKI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:27:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041684EC3;
        Tue, 11 Apr 2023 01:26:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B9EC66031E3;
        Tue, 11 Apr 2023 09:26:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201572;
        bh=r3zfi38g9XOFbxPCsU6s5EHHY+Cy6cYn92dcZBVVo54=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rd86UrR4/FjxK+t4HmQbwZ2soqvldGu85uXmi4jMAMhfdjl5kyZzUEhV+tJ5E2Yi+
         zX08gPDPkw18x6K+ZO1X8YoAaT13c8nlzu8kB2ynKYU7eIqHrQB6FBEOYUaGCPnW1k
         9C/7sWNNSlx2ILjFp5jOuIin9nPrNBWmx6m4Egl/DHlZdbPm7e+4f7FbcJy128zpTl
         fdT1XzZYtjB6BErihCjxN+ReW7uBCwKejCIHPGvGcHP84oJOUhA0TVCqj0HDEqa4pm
         2exNtBSqHpET+9eFiqhODR4gWKBy6CKLLEJujX+6DWTQEVXeVQ6zQkyHXOdndXYBKJ
         Wxdb4RIKVQLmA==
Message-ID: <130305a6-54bb-2928-a447-c0e410c97a2d@collabora.com>
Date:   Tue, 11 Apr 2023 10:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/7] arm64: dts: mediatek: add camsys support for
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
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
 <20230207-iommu-support-v3-2-97e19ad4e85d@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207-iommu-support-v3-2-97e19ad4e85d@baylibre.com>
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
> Camera System (CamSys) incorporates an enhanced feature based image
> signal processor to connect a variety of image sensor components. This
> processor consists of timing generated unit (TG), lens/sensor
> compensation unit and image process unit.
> 
> For more detail, ask Mediatek for the MT8365 AIoT application processor
> functional specification.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


