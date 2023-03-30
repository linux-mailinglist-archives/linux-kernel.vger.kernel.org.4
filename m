Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481B16D071F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjC3NnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjC3NnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:43:12 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B238A5B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:42:41 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230330134238epoutp022efe9fd328d67c136058d5171e47aa9c~RNjn8DRgT0041500415epoutp02u
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:42:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230330134238epoutp022efe9fd328d67c136058d5171e47aa9c~RNjn8DRgT0041500415epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680183758;
        bh=eD+0Qn+GvCxGYmQvUmHZQydqS3ceCfgdPGxWqbGb4gw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Ctv4WLTExQ4vI52TxieKPq8G8WIsT/RKY+fum7zEd7ULHUEPNQjQ0qhvItVk/5FxI
         0/IAmkHq8anEb5ileR4eQMSPFjLwKu1AldKYTGH1PiRL9xVK2Q3bCLUaAw15MqEiK8
         kxqprf6RwE7RjHTBLvx4NA98FQJoDHuvskTuXxV4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230330134237epcas2p1f1da3edb62b02bdb7e7eef3beb252e30~RNjnAXBXS1252412524epcas2p1w;
        Thu, 30 Mar 2023 13:42:37 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PnPk5277wz4x9Pt; Thu, 30 Mar
        2023 13:42:37 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.42.61927.DC195246; Thu, 30 Mar 2023 22:42:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230330134236epcas2p14bcd5ccdc712997b40c1f6f22eba9a2e~RNjmHdUpT1252412524epcas2p1u;
        Thu, 30 Mar 2023 13:42:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230330134236epsmtrp25aa160fdd60985f29e4beedc4457aef3~RNjmGycmu0536105361epsmtrp2C;
        Thu, 30 Mar 2023 13:42:36 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-31-642591cd4309
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.34.18071.CC195246; Thu, 30 Mar 2023 22:42:36 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230330134236epsmtip239ba987a654f4e1b0b9741367db454d0~RNjl6D71U1920919209epsmtip2h;
        Thu, 30 Mar 2023 13:42:36 +0000 (GMT)
Message-ID: <1b4f0367-a919-cd8a-17e1-a38998575e58@samsung.com>
Date:   Thu, 30 Mar 2023 22:40:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH] spi: s3c64xx: add no_cs description
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20230306014239.80570-1-jaewon02.kim@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmue7ZiaopBnun8Fg8mLeNzWLxj+dM
        FlMfPmGz2Pt6K7vFpsfXWC0u75rDZjHj/D4mi8aPN9kdODyuL/nE7LFpVSebx51re9g8Ni+p
        9+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5
        qSVWhgYGRqZAhQnZGc8nfWUr2MpR8XhXXgPjO7YuRk4OCQETif0t+5i7GLk4hAR2MEqc+v2d
        DcL5xChxfUsfE4TzjVHi0ZpzLDAtU1edYAWxhQT2MkpseckCUfSaUWLx+e1A7RwcvAJ2Er07
        qkBqWARUJV7fXwC2jldAUOLkzCdgc0QFoiT6bm8CmyMsYCGxbd8bMJtZQFzi1pP5TCC2iICy
        xNXve8HmMwu0MUl8uf+fGSTBJqAt8X39YrAGTqBdn5eeYINolpfY/nYO2D8SAnM5JD783w51
        tYvEtUc/WSFsYYlXx7ewQ9hSEp/f7YUGRrZE+/Q/UDUVEhc3zIaKG0vMetbOCPIYs4CmxPpd
        +iCmBNBxR26xQKzlk+g4/JcdIswr0dEmBNGoJnF/6jmoITISk46sZIKwPSRO/e9im8CoOAsp
        VGYh+X4WkmdmIexdwMiyilEstaA4Nz212KjAEB7Vyfm5mxjBCVXLdQfj5Lcf9A4xMnEwHmKU
        4GBWEuEtNFZNEeJNSaysSi3Kjy8qzUktPsRoCoybicxSosn5wJSeVxJvaGJpYGJmZmhuZGpg
        riTOK217MllIID2xJDU7NbUgtQimj4mDU6qBKSFb6c+BrWc8L8+XsVh5085MKeu/ccaybLtX
        vzoifcVKX8tPbErLlgnUk3pSYL1jTsqyzfw8L6JiTtrtfKdvznHqSXmnllqNdpnvQp/VEe5v
        RXIPPX7rUrS7IW+x+SNxwymrZ3yWft9d7zXtxjLj9+m2qucu5m68tKTyuq9W19ebUVFGVw9J
        rRXa0ptmfumvkfiD+Gm16hLLZ8X6/p3lHvIo8FU8yyShbG8tm1/zdB2CxSXfF1W8t9UQb7PV
        nP8va5HY3ycy2rJMhes3rtPoPnRguu0N5vaNWkv+7Xgxf4fbiZJFE/y15Nf4hl3aLq4VxWLz
        o+eQ6pavuZcs1udENOyZa1OsFTCrx/Y7Z5iEEktxRqKhFnNRcSIAwvru+DEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXvfMRNUUg8XH1SwezNvGZrH4x3Mm
        i6kPn7BZ7H29ld1i0+NrrBaXd81hs5hxfh+TRePHm+wOHB7Xl3xi9ti0qpPN4861PWwem5fU
        e/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfG80lf2Qq2clQ83pXXwPiOrYuRk0NCwERi6qoT
        rF2MXBxCArsZJU7O/csKkZCRWP6sD6pIWOJ+yxGoopeMEo8vLwRKcHDwCthJ9O6oAqlhEVCV
        eH1/AVg9r4CgxMmZT1hAbFGBKInPB1rYQWxhAQuJbfvegM1nFhCXuPVkPhOILSKgLHH1+14W
        kPnMAm1MEuc/LmCGWDaRUeLcFxCHk4NNQFvi+/rFYN2cQIs/Lz3BBjHJTKJraxcjhC0vsf3t
        HOYJjEKzkBwyC8nCWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIziS
        tDR3MG5f9UHvECMTB+MhRgkOZiUR3kJj1RQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYL
        CaQnlqRmp6YWpBbBZJk4OKUamJrlA18Lqt2/557sLPf64CHdgF8HXPalVe0qTZq1RbXq0NfV
        zB4XPnz9sn8TR7qZt2HPxNTc0v0lUxySF27ZlxHSlrpt1p7pJ054qyoqvtVaZq+9dxnPxf13
        GDPWff9hXif4ft2e41ejJ9psq3X++eyX0ey/nDEynxReBj1Jf3hvwX/j4JX5O6QaHixM9PYN
        9y2/5DFx8QOda9oPzhYkmC57vysvg/u1db75Q7a8Bet4vDx9WNmXmS18cFv79myNaweCTqiU
        iVrUbjDNkdk6feme1KqDS1L8hBnajd4U2+5nfta0KM5P3TSub42X/2f9T7NX7VFqLythuPP3
        WmeW3qOtl7+ssDgT8OjvyjMLJ/ErsRRnJBpqMRcVJwIA/cU0XBMDAAA=
X-CMS-MailID: 20230330134236epcas2p14bcd5ccdc712997b40c1f6f22eba9a2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a
References: <CGME20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a@epcas2p3.samsung.com>
        <20230306014239.80570-1-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark


Could you apply this patch?

I missed you in the mail recipient.


https://lkml.org/lkml/2023/3/6/34

https://lkml.org/lkml/2023/3/6/232


On 23. 3. 6. 10:42, Jaewon Kim wrote:
> This patch adds missing variable no_cs descriptions.
>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>   include/linux/platform_data/spi-s3c64xx.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
> index 5df1ace6d2c9..3101152ce449 100644
> --- a/include/linux/platform_data/spi-s3c64xx.h
> +++ b/include/linux/platform_data/spi-s3c64xx.h
> @@ -29,6 +29,7 @@ struct s3c64xx_spi_csinfo {
>    * struct s3c64xx_spi_info - SPI Controller defining structure
>    * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
>    * @num_cs: Number of CS this controller emulates.
> + * @no_cs: Used when CS line is not connected.
>    * @cfg_gpio: Configure pins for this SPI controller.
>    */
>   struct s3c64xx_spi_info {


Thanks

