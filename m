Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B0656102
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiLZIE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiLZIE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:04:27 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2991169
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:04:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so24778463ejm.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yazwz3rKKYGoJc4/RODm75wP9Gxei4CxcZJhPtgB2nU=;
        b=sb54ryAb0Hf0aPxdFNo8YpoaTMFT502S2XGeBjd2Sigr8svWlWphRv9Am88uS1YC84
         VBmD2ZRW5dJJGme+gWPT0CcB8E0asGj4r6MQuHPbTs5SIHeulJJO8Iapwfb/MCYrV7Ce
         KO2OiHTy609NVFYnElAKXeqQk3SAisqz67Rx/NcsYPcG4ZD2+hvbjeYyU4iXb7crG4ma
         veYjG8x81T/msyszjh0TbmtPUEpTHOqTAjli+M0AyPJbujyLOcvEkZuyLyzVMA20PeTz
         X49jhSjPjPl8orqeVLZ+mTDCfuG6GAMaQ+mA5vUxsW0/GpQoMEd5LuGjGWXfg44Mwec5
         NWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yazwz3rKKYGoJc4/RODm75wP9Gxei4CxcZJhPtgB2nU=;
        b=GZLmwqvPphEAN+SahwJVdkLgkzzV8JxsT/YyKwUd0/aqn+GhTnM2JCNz95zL7lYZ1s
         VNwK4FuwPWUztqGDzF1+lLuxqsTAh2otx94y0xKeZ5D+3Je/1SKUSDfo3iC0qwRcWgk+
         PHJ2HGfNzKMw6wP1ns+D9HFC7onW7sJGqGLpoiShBhzQW3mDLumyBdqsTETYh5o0nSAf
         XabeUMC9dYqCsKxyahYH6Rj24W3hQz4PzXsejnbCmwNiu9tFweDXh1yUTL94AIzwyIqX
         cI7kkULmFEDTmLFtmiE8lvHthmvGA0t7ohw4QAVNCmYD/BD+mlwmv3MNDjALAlPAcwlI
         HKiA==
X-Gm-Message-State: AFqh2kqgiXYRnRY+EAYlkO4pmLwpUWpvALdTfxrlBSTSzLFn8MgKEzTO
        ypKnZM7qWW7cGn5jI34HiCeadQ==
X-Google-Smtp-Source: AMrXdXv8kRfN77ZyulKPLZjmzBBNeuxEGjUqmksPVYsTHWFZi5eW5K5zrDa3zK6FazbCFrQvtrKthw==
X-Received: by 2002:a17:906:bcd5:b0:7c0:a49a:1 with SMTP id lw21-20020a170906bcd500b007c0a49a0001mr14797222ejb.71.1672041862411;
        Mon, 26 Dec 2022 00:04:22 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id mj26-20020a170906af9a00b0073d71792c8dsm4549388ejb.180.2022.12.26.00.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 00:04:22 -0800 (PST)
Message-ID: <9927a8c3-40cf-2c69-46c6-f660ff2422b1@linaro.org>
Date:   Mon, 26 Dec 2022 10:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] mtd: spi-nor: Add support for IS25LX256 operating
 in 1S-8S-8S octal read mode
Content-Language: en-US
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-4-nathan.morrison@timesys.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20221202135539.271936-4-nathan.morrison@timesys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nathan,

The series is starting to look good, but I'll need another version,
please.

On 02.12.2022 15:55, Nathan Barrett-Morrison wrote:
> This adds the IS25LX256 chip into the ISSI flash_info parts table

Describe your changes in imperative mood, e.g. "Add support for
S25LX256" instead of "This adds ..."

It may worth to re-read
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
once in a while.

> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>   drivers/mtd/spi-nor/issi.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index 89a66a19d754..362bc3603d8f 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -29,6 +29,35 @@ static const struct spi_nor_fixups is25lp256_fixups = {
>   	.post_bfpt = is25lp256_post_bfpt_fixups,
>   };
>   
> +static int
> +is25lx256_post_bfpt_fixups(struct spi_nor *nor,
> +			   const struct sfdp_parameter_header *bfpt_header,
> +			   const struct sfdp_bfpt *bfpt)
> +{
> +	/*
> +	 * IS25LX256 supports both 1S-1S-8S and 1S-8S-8S.
> +	 * However, the BFPT does not contain any information denoting this
> +	 * functionality, so the proper fast read opcodes are never setup.
> +	 * We're correcting this issue via the fixup below.  Page program
> +	 * commands are detected and setup properly via the 4BAIT lookup.
> +	 */
> +	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;

add a reference to params, the build fails here.

> +	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
> +				  0, 8, SPINOR_OP_READ_1_1_8,
> +				  SNOR_PROTO_1_1_8);
> +
> +	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_8_8;
> +	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_8_8],
> +				  0, 16, SPINOR_OP_READ_1_8_8,
> +				  SNOR_PROTO_1_8_8);
> +
> +	return 0;
> +}
> +
> +static const struct spi_nor_fixups is25lx256_fixups = {
> +	.post_bfpt = is25lx256_post_bfpt_fixups,
> +};
> +
>   static void pm25lv_nor_late_init(struct spi_nor *nor)
>   {
>   	struct spi_nor_erase_map *map = &nor->params->erase_map;
> @@ -74,6 +103,9 @@ static const struct flash_info issi_nor_parts[] = {
>   		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>   		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>   		.fixups = &is25lp256_fixups },
> +	{ "is25lx256", INFO(0x9d5a19, 0, 0, 0)
> +		PARSE_SFDP
> +		.fixups = &is25lx256_fixups },

For every new flash addition or update, we ask contributors to do some
little tests. Would you please run the commands from below and send us
the output?

# dd if=/dev/urandom of=./qspi_test bs=1M count=6
6+0 records in
6+0 records out

# mtd_debug write /dev/mtd4 0 6291456 qspi_test
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash

# mtd_debug erase /dev/mtd4 0 6291456
Erased 6291456 bytes from address 0x00000000 in flash

# mtd_debug read /dev/mtd4 0 6291456 qspi_read
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read

# hexdump qspi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*

0600000

# mtd_debug write /dev/mtd4 0 6291456 qspi_test
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash

# mtd_debug read /dev/mtd4 0 6291456 qspi_read
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read

# sha1sum qspi_test qspi_read
57f8d4fee65622104e24276e865f662844f12242  qspi_test
57f8d4fee65622104e24276e865f662844f12242  qspi_read

# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
is25wp256

# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
9d7019

# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
issi

# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060101ff00060110300000ff9d05010380000002ffffffffffff
ffffffffffffffffffffffffffffffffffffe520f9ffffffff0f44eb086b
083b80bbfeffffffffff00ffffff44eb0c200f5210d800ff234ac90082d8
11cecccd68467a757a75f7aed55c4a422cfff030faa9ffffffffffffffff
ffffffffffffffff501950169ff9c0648fefffff

# md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
ba14818b9ec42713f24d94d66bb90ba0  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
