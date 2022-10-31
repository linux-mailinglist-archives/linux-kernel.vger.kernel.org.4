Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823246137AC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiJaNRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJaNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:17:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096C632D;
        Mon, 31 Oct 2022 06:17:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 362D3660036D;
        Mon, 31 Oct 2022 13:17:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667222254;
        bh=ZmPmZv72wbYQvxzOvTCOXp+TPJj41VSYJO29iqOZ//o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KYROdDtJRqd5mFhg8RKdHIF6Fh6pJCaZ0IjRgBZZyvg1agyrVjRmoCYbHYeapj02g
         3/oiCJzKv0+OU3pNDx7JL7HCml7gYzWJX+2fIokgSlg47GQ/nvZZeJ+Blinpp0DCoO
         C3c5VK7AF2H7sHZfR9RYU9OOH5g8gzaCc6XNostRPLqrj+OFc18mIg10MHJ+iWk6lK
         CSD5PruhyEthiTQA1B+WpafUme0VGm/2Y2z200hrF1lfq7z52sjCNBig98NnbHY/Pf
         59+J5tH/g3v9l1B72StI3IJml8vAuJOOoGFaBmYcpJYrMqC0vvAJDGm5rUCB3EfMqM
         18rr2tSW0gg3A==
Message-ID: <bc2e7eec-d78a-dfc5-b7f5-cf5bab001593@collabora.com>
Date:   Mon, 31 Oct 2022 14:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] dt-bindings: mailbox: mediatek,gce-mailbox: add
 mt8188 compatible name
Content-Language: en-US
To:     "Elvis.Wang" <Elvis.Wang@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221029105017.20734-1-Elvis.Wang@mediatek.com>
 <20221029105017.20734-3-Elvis.Wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221029105017.20734-3-Elvis.Wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/10/22 12:50, Elvis.Wang ha scritto:
> From: Elvis Wang <Elvis.Wang@mediatek.com>
> 
> Add mt8188 compatible name.
> 
> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

