Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B356DD575
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDKI3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjDKI2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:28:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C0422A;
        Tue, 11 Apr 2023 01:28:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C4E2D66031E2;
        Tue, 11 Apr 2023 09:28:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201700;
        bh=zR5A2y0u1pon3797Cdyl90Wk9kLNd3D+9zTfEkqtCoo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GWjt4Vu09C8UQp7IpbPt2j2WrG7FzI/rvSbJo57LQJwS644ZOPOSl/C9kANZpJuPU
         ZdC/yhUepN4nEL+ZY2JDENJc7VVIc571vsiQQX0rZyr9o/d/gt5xRH1nURnYt++W4p
         rPv3JTnv3NXbocfpRqMschY6o+GvuyohuV9/KUUR/23YFsLy+UQB/YA0HACcMoE5X2
         cg8owKl9K7flK/I0sOi1odVOg0nraS1ImtVvZ9F4xUYzHQG0ZToDYVAaPYzbo2jfdD
         zQTkEzxP18pYYySxE/PoGxCxAHSm+Hq4GpZzxxh2+iUQXFiMDUrdPxslM1IsCKHm4H
         BEu2FZgzJdvow==
Message-ID: <ef108434-1956-d488-c6f6-535d66ba6603@collabora.com>
Date:   Tue, 11 Apr 2023 10:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] memory: mtk-smi: mt8365: Add SMI Support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
 <20230407-smi-driver-v2-1-8da6683cdb5c@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230407-smi-driver-v2-1-8da6683cdb5c@baylibre.com>
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

Il 07/04/23 11:13, Alexandre Mergnat ha scritto:
> Add MT8365 SMI common support.
> 
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


