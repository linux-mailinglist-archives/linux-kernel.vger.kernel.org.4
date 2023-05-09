Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0B6FC769
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjEINDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjEINDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:03:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0417C49E8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:03:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230509130327euoutp020aa689f0f1e038e4e9f0df1434eed704~de00svxvb2223122231euoutp02n
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:03:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230509130327euoutp020aa689f0f1e038e4e9f0df1434eed704~de00svxvb2223122231euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683637407;
        bh=0aPeVHWjwRpazng4CKjKQ5YUeVHJETkq4DPH4Uf9CFE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=JwKxPxjgFRD4m3+OkTH3gPunNUsTpFeGFHhz8tleZaPNNz0b5xZdeh1nW7JhUuZum
         HOe34jpnfjwOfhEjthsf4SEoS/JSHENb7VtUg65ibtTmyE9HC5kJSB+Xk/zTVQGvXb
         1XNvNAqyyOdUbnq0GUALtxKNIZQliskEUGfCTtcw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230509130326eucas1p25f3b7bf27014db0f71b60ef2705b4859~de00dfYfM2774427744eucas1p2L;
        Tue,  9 May 2023 13:03:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5C.01.42423.E944A546; Tue,  9
        May 2023 14:03:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230509130326eucas1p2716d44a034ccc533eefa86b5c5cea5a7~de00F-Zoa1847118471eucas1p2o;
        Tue,  9 May 2023 13:03:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230509130326eusmtrp2fbd0bcb35d293175f53bdeeee0921881~de00FIvWV1612816128eusmtrp2W;
        Tue,  9 May 2023 13:03:26 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-81-645a449ee009
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.00.14344.E944A546; Tue,  9
        May 2023 14:03:26 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230509130325eusmtip1d3da91c2b2aa70af391d9357e55e8d95~de0zdf4Sn0632206322eusmtip1Q;
        Tue,  9 May 2023 13:03:25 +0000 (GMT)
Message-ID: <d8fa2d7b-6604-1fad-6b0b-19d7e551a1d2@samsung.com>
Date:   Tue, 9 May 2023 15:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] spi: s3c64xx: support interrupt based pio mode
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230502062813.112434-4-jaewon02.kim@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87rzXKJSDJqv61s8mLeNzWLxj+dM
        FlMfPmGzuLxf22JHwxFWi72vt7Jb3Dy0gtFi0+NrrBaXd81hs5hxfh+TRePHm+wO3B7Xl3xi
        9ti0qpPN4861PWwem5fUe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGlEu1Bff4Ki4s2Mva
        wNjF08XIySEhYCIx93wDWxcjF4eQwApGiYu/5kE5Xxgl/t7+yAThfGaUWPiygwmm5cbvXawQ
        ieWMEnf2z2KEcD4ySqyfu4cZpIpXwE7izKOvYB0sAioS/z/eZ4GIC0qcnPkEzBYVSJVomv2G
        HcQWFvCS+LO7CayeWUBc4taT+WCrRQROMUp8WrgRKvGOUaJjiRSIzSZgKNH1tosNxOYUsJc4
        0feXHaJGXqJ562xmiFObOSXO9YlA2C4Se0/0s0PYwhKvjm+BsmUk/u+EWCYh0M4oseD3fShn
        AqNEw/NbjBBV1hJ3zv0C2sYBtEFTYv0ufYiwo8TFSc+ZQMISAnwSN94KQtzAJzFp23RmiDCv
        REebEES1msSs4+vg1h68cIl5AqPSLKRgmYXk/VlIvpmFsHcBI8sqRvHU0uLc9NRiw7zUcr3i
        xNzi0rx0veT83E2MwJR1+t/xTzsY5776qHeIkYmD8RCjBAezkgjvqoSwFCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1Mcw/G/bbfekminecxf7TyoSML
        m/cXHtRY7/W7sCXkS5LL+qvVESkXW7cVX2gvYpn2ve168fozy1Q95c/tuydbKvTiB4fa/sub
        LJ7xVi5VPybOlHbIomjzwuDsS6qbfjfXHHJ1Un/T8e3IFfklbC8r7785/f3/smkJ7aYNJhUv
        Vt3ym3V1B6+Sy8Q7ap13TkzhFO2cFWJnWzCVa/267zM0XrEFx6d569z73XleLcrpprzjDI8i
        /eONN97vYyptf9ytGvq06kmdyKc//+3cEnwcFY5M/v50440tXqbTfxYsVOxK/Kh2uiercXLM
        9tNT9SXre2cHma8vYN0r/2dprqad5Rffk0cip5bmHq9zvJ16SomlOCPRUIu5qDgRALxDZwXI
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7rzXKJSDP5+F7R4MG8bm8XiH8+Z
        LKY+fMJmcXm/tsWOhiOsFntfb2W3uHloBaPFpsfXWC0u75rDZjHj/D4mi8aPN9kduD2uL/nE
        7LFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2MKZdqC+7xVVxYsJe1gbGLp4uRk0NCwETixu9drCC2
        kMBSRontO3kh4jISJ6c1sELYwhJ/rnWxdTFyAdW8Z5T4//k5G0iCV8BO4syjr0wgNouAisT/
        j/dZIOKCEidnPgGzRQVSJW7s+QNWLyzgJfFndxNYPbOAuMStJ/OZQIaKCJxhlPj6fyI7iMMs
        8I5R4ta6ZVDrjjNKzNzfwA7SwiZgKNH1tgtsFKeAvcSJvr/sEKPMJLq2djFC2PISzVtnM09g
        FJqF5JJZSDbOQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFRuu3Yzy07GFe+
        +qh3iJGJg/EQowQHs5II76qEsBQh3pTEyqrUovz4otKc1OJDjKbA4JjILCWanA9ME3kl8YZm
        BqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUye7IfSqpgC/rc13EqKP+P/
        KMjf+M7rGUKB3xiXVr0JniMttODUuknyQse25n4Ocelckf9BUZ/hZP7zdXHC6/9vXJ26aObE
        W/JPmi4trlSc+WSp8Q/5nQ//6wR0WAe3nbWOWfPvkN67PIXpcjydrwvqvRSe2KUUqOz6xWK4
        XZD7y4KlCZ4N5y9PvNtVY7s38uyk+Xsf6LaFFxi/mzZrx9/Ed+8L8o/5OifXMNh7dT/0smY5
        tansj9y3TgZDS0kdZ/6SSB6JK/+CX7qurJ1b9NuZs9FFwdp64sWQOXvMMtedUzKJqPfe4vfx
        lKpiT3tvBU/6NkOXJfVZERNEJiytj3lV9HHx6cdPjtfFrLJl3qLEUpyRaKjFXFScCABmTg9/
        WwMAAA==
X-CMS-MailID: 20230509130326eucas1p2716d44a034ccc533eefa86b5c5cea5a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
        <CGME20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f@epcas2p3.samsung.com>
        <20230502062813.112434-4-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.2023 08:28, Jaewon Kim wrote:
> Support interrupt based pio mode to optimize cpu usage.
> When transmitting data size is larget than 32 bytes, operates with
> interrupt based pio mode.
>
> By using the FIFORDY INT, an interrupt can be triggered when
> the desired size of data has been received. Using this, we can support
> interrupt based pio mode.
>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>

This patch landed recently in linux-next as commit 1ee806718d5e ("spi: 
s3c64xx: support interrupt based pio mode"). Unfortunately it breaks 
ethernet chip operation on Exynos3250 based Artik5 Development board. I 
see the flood of the following messages:

[   36.097739] ax88796c spi0.0: I/O Error: rx-1 tx-0 rx-f tx-p len-496 
dma-1 res-(-5)
[   36.100877] ax88796c spi0.0: RX residue: 248
[   36.101383] ax88796c spi0.0: SPI transfer failed: -5
[   36.101939] spi_master spi0: failed to transfer one message from queue
[   36.102439] ax88796c spi0.0: axspi_read_rxq() failed: ret = -5
[   36.107830] s3c64xx-spi 13920000.spi: Failed to get RX DMA channel
[   36.148875] ax88796c spi0.0: I/O Error: rx-0 tx-1 rx-p tx-f len-4 
dma-0 res-(-5)
[   36.149517] ax88796c spi0.0: SPI transfer failed: -5
[   36.150053] spi_master spi0: failed to transfer one message from queue
[   36.150562] ax88796c spi0.0: axspi_read_reg() failed: ret = -5
[   36.152175] s3c64xx-spi 13920000.spi: Failed to get RX DMA channel
[   36.191651] ax88796c spi0.0: I/O Error: rx-0 tx-1 rx-p tx-f len-4 
dma-0 res-(-5)
[   36.192268] ax88796c spi0.0: SPI transfer failed: -5

...

I didn't analyze the details, but imho it looks like some kind of 
mishandling of the corner case or switching between PIO and DMA mode. I 
will check the details later.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

