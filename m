Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00216FD77E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjEJGyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjEJGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:54:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D430F9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:54:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230510065441euoutp0261dd18ef6200d2d1f5c27b6228330882~dtcI5U6KI1413814138euoutp02a
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:54:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230510065441euoutp0261dd18ef6200d2d1f5c27b6228330882~dtcI5U6KI1413814138euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683701681;
        bh=xKdPwawbbqU4sJJ4YM4Rx2nLckvXs1dXFCnw2RaOun4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=glALu9YAMpr873wDjck7FCcGCx9Y0mQAKnpHwVec9t8bqxS/LumhsP6MF5ucMgjs0
         FlMFGHcY2iKj5caxG9mpObK00LUTGqy8CBXafdtV3s5vCaRKPnRjqneStRqraM+ojw
         gtwOXxaDAJV1pY2erProfxHY1ccNMicUxlY9y530=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230510065441eucas1p2da73c8b85506ae018a1a5a085faee1e8~dtcItfGUM0474904749eucas1p2J;
        Wed, 10 May 2023 06:54:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.CF.37758.1BF3B546; Wed, 10
        May 2023 07:54:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230510065440eucas1p1aeeae7688990edbe3b530e13db3975f3~dtcITbAUq2670126701eucas1p1B;
        Wed, 10 May 2023 06:54:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230510065440eusmtrp2c8375a5007c457f469a108ebf24d6e46~dtcISKRj92634526345eusmtrp2V;
        Wed, 10 May 2023 06:54:40 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-5e-645b3fb14d4a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.A2.14344.0BF3B546; Wed, 10
        May 2023 07:54:40 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230510065440eusmtip2d0be5715dc39e8537537f82147fe4ba8~dtcHpRIeh1278912789eusmtip2J;
        Wed, 10 May 2023 06:54:40 +0000 (GMT)
Message-ID: <7883a9d4-76d0-d259-095b-babae63ffc77@samsung.com>
Date:   Wed, 10 May 2023 08:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.10.1
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
In-Reply-To: <0ef75bd7-e7e6-a806-2c3f-35c7312c391d@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7ob7aNTDC5947F4MG8bm8XiH8+Z
        LKY+fMJmcXm/tsWOhiOsFntfb2W3uHloBaPFpsfXWC0u75rDZjHj/D4mi8aPN9kduD2uL/nE
        7LFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Mp7f7mQoOS1c0L9vK
        1sB4XayLkZNDQsBE4si0N+xdjFwcQgIrGCVuzW1kA0kICXxhlPg10xQi8ZlRYv3fPkaYjpMX
        H7FBJJYzSnye28AK4XxklHjcOgfI4eDgFbCTeLTVCqSBRUBVYkHzRVYQm1dAUOLkzCcsILao
        QKrEqs0XmUFsYQEviT+7m5hAbGYBcYlbT+YzgcwUETjFKPFp4UaoxDtGiY4lUiA2m4ChRNfb
        LrBTOQXsJVZvWQxVIy/RvHU2M8Sl/zkkbs+PgbBdJNbMOgP1gbDEq+Nb2CFsGYn/OyGWSQi0
        M0os+H0fypnAKNHw/BZUh7XEnXO/2EA+YxbQlFi/Sx8i7ChxcdJzJpCwhACfxI23ghA38ElM
        2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAspWGYheX8Wkm9mIexdwMiyilE8tbQ4Nz21
        2DgvtVyvODG3uDQvXS85P3cTIzBhnf53/OsOxhWvPuodYmTiYDzEKMHBrCTC6x0alSLEm5JY
        WZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qBSeHUbOZXs7WZdpev
        WC/08WD26hdXDnZ9mLVDcgqHhW7wUf1dJh0Pz9kvyFuobxrX9+3Kf05mrrz7LCqG05Le5B74
        l/3D+39Bq3P35Eu9HW7fPtu1eLP6TbsrdV1m1bdQ2w1mIjoxuTzFMS38b61t1xpUWe75fSHz
        755d7yafyproEZ3Ydrrg/I3WmUXzt8TsiZU4mBsi8lTsdfaPD9KT9/kZtFYGW6R9+HP18WXG
        289mushNyjmbZ1QRnfFYmXV92cRfBzd+UNlcvYArMa3z9sJv8wROyL88YXtHPL2+Um7pWZlv
        Unau21q8f6WFXhIV3x8pct2lK/fJLA2vnLv1cmFz5mh+TtxpfeBchtn0S0osxRmJhlrMRcWJ
        ALKqYSTHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7ob7KNTDB4+0bF4MG8bm8XiH8+Z
        LKY+fMJmcXm/tsWOhiOsFntfb2W3uHloBaPFpsfXWC0u75rDZjHj/D4mi8aPN9kduD2uL/nE
        7LFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2Mp7f7mQoOS1c0L9vK1sB4XayLkZNDQsBE4uTFR2xd
        jFwcQgJLGSVu/VrOCpGQkTg5rQHKFpb4c60Lqug9o8SDWR+AHA4OXgE7iUdbrUBqWARUJRY0
        XwSr5xUQlDg58wkLiC0qkCpxcukNMFtYwEviz+4mJhCbWUBc4taT+UwgM0UEzjBKfP0/kR3E
        YRZ4B3TFumVsIFVCAhuZJDYdSQax2QQMJbredoHFOQXsJVZvWQw1yUyia2sXI4QtL9G8dTbz
        BEahWUgOmYVk4SwkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGKXbjv3csoNx
        5auPeocYmTgYDzFKcDArifB6h0alCPGmJFZWpRblxxeV5qQWH2I0BYbGRGYp0eR8YJrIK4k3
        NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg0p++av3zdaaKDfyxu5/d
        L838GC1ad5Hl8rxJDHpGU4J19X8onl4k279ZyOpM9D7Gfuds7lOND2wkvaJa7n2N1jYSWLGn
        3Cmya97RjVktXOHpbubWO5PkznYeDhAIM9u3cOHu2CutEvzuDgwMxtnq0x/P+7TgDP+b9Z9n
        hsVxa9qHzktP0Al0K9P3W5USwyPTy7B6msAUUbe+iFdLN++50ndflmtBJ2/CIs/OHyE+xbk7
        XlhZdFWbH/8fp7Q/8M6d/xo/Iu3deBnv93KuOBLLmOrF9aBS6O+L2y/EA64v/aYbUhF6qVAu
        a2Nix0LHiVEGVUHzbOqU9L33iHlW2D0+13/8ZpN6hf6LkDtFwkosxRmJhlrMRcWJAI8YRMpb
        AwAA
X-CMS-MailID: 20230510065440eucas1p1aeeae7688990edbe3b530e13db3975f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
        <CGME20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f@epcas2p3.samsung.com>
        <20230502062813.112434-4-jaewon02.kim@samsung.com>
        <d8fa2d7b-6604-1fad-6b0b-19d7e551a1d2@samsung.com>
        <0ef75bd7-e7e6-a806-2c3f-35c7312c391d@samsung.com>
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


On 10.05.2023 06:05, Jaewon Kim wrote:
> Hello Marek
>
>
> On 23. 5. 9. 22:03, Marek Szyprowski wrote:
>> On 02.05.2023 08:28, Jaewon Kim wrote:
>>> Support interrupt based pio mode to optimize cpu usage.
>>> When transmitting data size is larget than 32 bytes, operates with
>>> interrupt based pio mode.
>>>
>>> By using the FIFORDY INT, an interrupt can be triggered when
>>> the desired size of data has been received. Using this, we can support
>>> interrupt based pio mode.
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> This patch landed recently in linux-next as commit 1ee806718d5e ("spi:
>> s3c64xx: support interrupt based pio mode"). Unfortunately it breaks
>> ethernet chip operation on Exynos3250 based Artik5 Development board. I
>> see the flood of the following messages:
>>
>> [   36.097739] ax88796c spi0.0: I/O Error: rx-1 tx-0 rx-f tx-p len-496
>> dma-1 res-(-5)
>> [   36.100877] ax88796c spi0.0: RX residue: 248
>> [   36.101383] ax88796c spi0.0: SPI transfer failed: -5
>> [   36.101939] spi_master spi0: failed to transfer one message from queue
>> [   36.102439] ax88796c spi0.0: axspi_read_rxq() failed: ret = -5
>> [   36.107830] s3c64xx-spi 13920000.spi: Failed to get RX DMA channel
>> [   36.148875] ax88796c spi0.0: I/O Error: rx-0 tx-1 rx-p tx-f len-4
>> dma-0 res-(-5)
>> [   36.149517] ax88796c spi0.0: SPI transfer failed: -5
>> [   36.150053] spi_master spi0: failed to transfer one message from queue
>> [   36.150562] ax88796c spi0.0: axspi_read_reg() failed: ret = -5
>> [   36.152175] s3c64xx-spi 13920000.spi: Failed to get RX DMA channel
>> [   36.191651] ax88796c spi0.0: I/O Error: rx-0 tx-1 rx-p tx-f len-4
>> dma-0 res-(-5)
>> [   36.192268] ax88796c spi0.0: SPI transfer failed: -5
>>
>> ...
>>
>> I didn't analyze the details, but imho it looks like some kind of
>> mishandling of the corner case or switching between PIO and DMA mode. I
>> will check the details later.
>>
>>
>> Best regards
>
> Thanks for testing the various cases.
>
> The problem occurred when DMA mode and IRQ mode were enabled at the same
> time.
>
>
> In the above case, BUS_WIDTH register invaded.
>
> Because, target length 496 were written to RX_RDY_LVL, but it exceeded
> 6-bits.
>
> Could you test with below code??? If the problem is solved, I will send
> a fix patch as soon as possible.

Thanks for quick response. Indeed, the proposed patch fixed the issue!

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> -----------------------------
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 238db29fc93b..a72e11e965c3 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -782,7 +782,7 @@ static int s3c64xx_spi_transfer_one(struct
> spi_master *master,
>
>           do {
>                   /* transfer size is greater than 32, change to IRQ mode */
> -               if (xfer->len > S3C64XX_SPI_POLLING_SIZE)
> +               if (!use_dma && (xfer->len > S3C64XX_SPI_POLLING_SIZE))

Parentheses around 'xfer->len > S3C64XX_SPI_POLLING_SIZE' are not needed.

>                           use_irq = true;
>
>                   if (use_irq) {
>
> -----------------------------
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

