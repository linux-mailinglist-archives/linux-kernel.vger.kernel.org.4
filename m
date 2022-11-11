Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF586253C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiKKG0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiKKGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:25:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68C7298A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:23:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f63so3680782pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcfEFKodJTGj4Bli++k9zxJOzTlquSKtEVh+RIQUcj4=;
        b=SQ/b2zol/J8cH13sZZ+6rRQgCPu5o3x0CA4vm/dPuujxVrcxOupWibcqCw3VuuLQkc
         W4HPurF9ug3GD4RD0RY9ny0v2LlQji61BcRfMIOeRL9Zu0HSuXLZPvvpbMlk2raiCq2B
         N9a/RMN/KMaHqXYS8aiUDlv7TT2x5R80qzAUX7m1boPhn1vkVYyZ9eIBnpqEbVpDElNf
         y6RvWPMndwxoNrBv3i6L6UhWspH99SOsNC6D8MUenuxe/E8eYfPZWXqHBRFQbQlBf3r4
         z6Lmgk66pooMXzFrrQ4ITQdc3xFZBJocYSsJLdzmmbVAkc7FJG3K9dRvukZnDPCyDfdV
         Lbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcfEFKodJTGj4Bli++k9zxJOzTlquSKtEVh+RIQUcj4=;
        b=LQ4DXciB1SJtvOqBlZAnH5uhSrz1vnB4dV0Q8owK2FE2RKGe/r5exFqQP6pr4c1se4
         1TA+7FI9Z/+kLvIk76zTh4YIRcei+w3U26DE0egubleWXMGcOwUYnDRkvRAKf9gpbir9
         X48uP5knYoDxYYw64Dat/Ytp+Yn2DWsaTrxNGD4Ag+0FIkejonwvg0MyLFvDZfQEb7FQ
         O5WnSIrEfCSshCjPztUianUvibmRjqsEOT6S2+dZ+m3zlXGmq9uCw+PFyfi67vMtKPTm
         wBSJhqFC5gKa2Hh2HeKtwnLIDbToDq+EWdr5kGC2QmER3egfYH2XcDqklbKXdLxvABPF
         Q1Gw==
X-Gm-Message-State: ANoB5pn6Qfxy8orQ+ylXfar3BnjSDs0PVB+3MaA2PD2hwByJ5G0S9FM1
        WZkpodogyR97ckCvYN5oFQE=
X-Google-Smtp-Source: AA0mqf5Yq9MLny3i+lV4Qt8ueRRDFgvrWjCGcZaug4a3aiDwoC4QqI3EJ1j/Qkin0h2eK0SM7mXorA==
X-Received: by 2002:a63:e404:0:b0:460:5107:739e with SMTP id a4-20020a63e404000000b004605107739emr389805pgi.501.1668147771326;
        Thu, 10 Nov 2022 22:22:51 -0800 (PST)
Received: from [10.10.4.41] (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id a27-20020aa7971b000000b00561d79f1064sm735091pfg.57.2022.11.10.22.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 22:22:50 -0800 (PST)
Message-ID: <768d18df-c4fb-0b58-91d2-918719b07079@gmail.com>
Date:   Fri, 11 Nov 2022 14:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH v4 1/1] mtd: spi-nor: winbond: Add support for
 w25q01jvq
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
References: <20221111060530.2201084-1-potin.lai.pt@gmail.com>
Content-Language: en-US
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <20221111060530.2201084-1-potin.lai.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers,

This commit has been tested and running on OpenBMC for few months.
Please kindly help review and merge it, thank you.

Potin


On 11/11/22 14:05, Potin Lai wrote:
> From: Potin Lai <potin.lai@quantatw.com>
>
> Add support for winbond w25q01jvq chip
>
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> ---
> LINK: [v3] https://lore.kernel.org/all/20220222085148.21594-1-potin.lai@quantatw.com/
> LINK: [v2] https://lore.kernel.org/all/20220222064227.16724-1-potin.lai@quantatw.com/
> LINK: [v1] https://lore.kernel.org/all/20211224104522.24615-1-potin.lai@quantatw.com/
>
> Changes v3 --> v4:
> - fix correct chip name "w25q01jvq"
>
> root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
> ef4021
> root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
> winbond
> root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/partname
> w25q01jvq
> root@bletchley:~# md5sum /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> a7b9dbf76e99a33db99e557b6676588a /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> root@bletchley:~# hexdump -C /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> 00000000  53 46 44 50 06 01 01 ff  00 06 01 10 80 00 00 ff  |SFDP............|
> 00000010  84 00 01 02 d0 00 00 ff  03 00 01 02 f0 00 00 ff  |................|
> 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 00000080  e5 20 fb ff ff ff ff 3f  44 eb 08 6b 08 3b 42 bb  |. .....?D..k.;B.|
> 00000090  fe ff ff ff ff ff 00 00  ff ff 40 eb 0c 20 0f 52  |..........@.. .R|
> 000000a0  10 d8 00 00 36 02 a6 00  82 ea 14 e2 e9 63 76 33  |....6........cv3|
> 000000b0  7a 75 7a 75 f7 a2 d5 5c  19 f7 4d ff e9 70 f9 a5  |zuzu...\..M..p..|
> 000000c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> 000000d0  ff 0a f0 ff 21 ff dc ff                           |....!...|
> 000000d8
>
> Changes v2 --> v3:
> - move spi-nor flash information to comment area
>
> Changes v1 --> v2:
> - rework patch to work with new flags
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index ffaa24055259..e60ad92c0ace 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -139,6 +139,8 @@ static const struct flash_info winbond_nor_parts[] = {
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "w25q01jvq", INFO(0xef4021, 0, 64 * 1024, 2048)
> +		PARSE_SFDP },
>  };
>  
>  /**
