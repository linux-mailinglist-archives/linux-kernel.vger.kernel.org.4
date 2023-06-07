Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D55727087
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjFGVXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjFGVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:23:38 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB03B1BE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:23:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B87C75FD05;
        Thu,  8 Jun 2023 00:23:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686173013;
        bh=K0aBaIg4zf2P0UykGVbyuQblC6R5Fsbn4jzYeUZ5cVA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=RJPwrIG+MQIcHsO9Nhu/gQ58DIm+894yvtHrU+Q92KU82XOp8UpwOW82+Gqp1XEua
         Z8KtPzwPfPnmtxBi9nGAwp+Th6kTbHl6mLYEJZuM114XwwEztLHnupn20lJuQJFQca
         x8154u7ZjXbRKLeuNfpGhLL6yvGT5U09qhsL65WW1y4pMPw9TEzs/T79r7uuyJFTaj
         EgrEsECVXw2dhLQoJZfEg7ANHLzzBuitbrb7QPTHO5FN/FRZ07nCZhWSOvwG6Iwsbr
         E5lo5yCk5KFo2uHP4y3zMZXlFQTzLw9gTQcpaKaqqFSukPG+Vy2hy2NcGaT/T3J02T
         s60QzUGD8A9QA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  8 Jun 2023 00:23:33 +0300 (MSK)
Message-ID: <9319a8f6-3774-0dc8-2262-8033f8016a50@sberdevices.ru>
Date:   Thu, 8 Jun 2023 00:18:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: remove unneeded bitwise OR with
 zeroes
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230605191508.1826853-1-AVKrasnov@sberdevices.ru>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230605191508.1826853-1-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 16:55:00 #21454472
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Miquel, Liang!

What do You think about this patch?

Thanks, Arseniy

On 05.06.2023 22:15, Arseniy Krasnov wrote:
> Both operations have no effect.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 074e14225c06..50d3110ad321 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -595,12 +595,12 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>  	cmd0 = in ? NAND_CMD_READ0 : NAND_CMD_SEQIN;
>  	nfc->cmdfifo.rw.cmd0 = cs | NFC_CMD_CLE | cmd0;
>  
> -	addrs[0] = cs | NFC_CMD_ALE | 0;
> +	addrs[0] = cs | NFC_CMD_ALE;
>  	if (mtd->writesize <= 512) {
>  		cmd_num--;
>  		row_start = 1;
>  	} else {
> -		addrs[1] = cs | NFC_CMD_ALE | 0;
> +		addrs[1] = cs | NFC_CMD_ALE;
>  		row_start = 2;
>  	}
>  
