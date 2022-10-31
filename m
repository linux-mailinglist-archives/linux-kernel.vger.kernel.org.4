Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DB613851
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiJaNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiJaNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:45:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D210545;
        Mon, 31 Oct 2022 06:45:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E7516602253;
        Mon, 31 Oct 2022 13:45:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667223920;
        bh=FqG5Q9Uq9BODSoedqBA3YlNqZjPSGiArJ7cELbg3dBI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q+BkQP4mwRLmQ1tdn6vLsPc96vlTiWTXoDR3oAn+hPGADvHLXKQ7xIQwCBGSxh+i5
         0oppqtccMWm7GDIxLgq7STRH4DjocOKPdoEfhHcT3xHgmavC5P32fQDA7ySsgifCjH
         HXk4HD8GMr50Ag3OuwcDC2rsJSS/lUjAaCUfY1wl1LpPOhimRmtLeuWk2lgixQarS/
         UakTBK0eWkW+7XKlxjcnNcsm5MDDx3isM2maXebCimfBXi6fcbCaA69IcuFw3VE8vY
         jR4BjhHz2AdIfevEvrFNoSjhIhIbqzr8H3fCHns4DPaUALb93eYIion+xmK9vbfKxa
         SEEVtIi8/pt7A==
Message-ID: <5329430d-fd58-0872-50d3-b0558f6868df@collabora.com>
Date:   Mon, 31 Oct 2022 14:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3] dma-buf: cma_heap: Remove duplicated 'by' in comment
Content-Language: en-US
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     yj.chiang@mediatek.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221028065533.23856-1-mark-pk.tsai@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028065533.23856-1-mark-pk.tsai@mediatek.com>
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

Il 28/10/22 08:55, Mark-PK Tsai ha scritto:
> Remove duplicated 'by' from comment in cma_heap_allocate().
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Reviewed-By: Mukesh Ojha <quic_mojha@quicinc.com>
> Acked-by: John Stultz <jstultz@google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

