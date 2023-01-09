Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55B9661E27
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 06:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjAIFEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 00:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjAIFEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:04:50 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56060A448
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 21:04:49 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30954NiY054709;
        Sun, 8 Jan 2023 23:04:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673240663;
        bh=s1W2ZfWslUfpwbe+XtN7DnIFblspWS94tqfwh5Rdr/o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Pnhssb2G991ClaVPTT5bC7Fd+UDHFtALYig+YJlVpsEGAkqfDJiS2EtFA7StLhTBh
         MspmY6M9OeTHnAuvmz7CLdp0pj1SRcaYa8N0qDbNjxouT7WaheYnVLOghZ0YpKyknJ
         3Ug8k6UNY3Br65wn5IxaW/GPOjeWvax7EyO7CkyA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30954MR7082181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Jan 2023 23:04:22 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 8
 Jan 2023 23:04:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 8 Jan 2023 23:04:22 -0600
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30954J2U094991;
        Sun, 8 Jan 2023 23:04:19 -0600
Message-ID: <dd6c7345-4635-dc26-dd25-153c87b4b336@ti.com>
Date:   Mon, 9 Jan 2023 10:34:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: add support for mx77l51250f
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>
References: <20230107214345.2524851-1-tomas.winkler@intel.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230107214345.2524851-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tomas,

On 08/01/23 03:13, Tomas Winkler wrote:
> Add support for mx77l51250f spi-nor chips.
> 
> SPI NOR sysfs:
> 
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
> mx77l51250f
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
> c2751a
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
> macronix
> $ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 53464450060103ff00060110300000ffc2000104100100ff030001020001
> 00ff84000102c00000ffffffffffffffffffe520f3ffffffff1f44eb086b
> 083b04bbeeffffffffff00ffffff00ff0c200f5210d800ff8341bd0082a7
> 04db4403373830b030b0f7a9d55c009e29fff050f985ffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffff7f0ff0ff215cdcffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffff3c9b96f0c5a4c2ffffffffffffff
> ffff003600279df9c064fecfffffffffffff
> 
> $ md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 36fb8e3e6f82c45bfabea45ec73c08a8
> /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 
> Note: The test_qspi.sh wasn not run as this device in intel setup is used
>        for BIOS and platform firmware storage.
Thanks for doing the testing but one small suggestion, move this below 
the "---" lines before sending the patch email.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
For the code and idea itself, pending the changes I have advised below.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> V2:
> 1. This chip supports SFDP, parse it instead of the manual configuration.

This sounds good! Do the other flashes in macronix_nor_parts support
this? Maybe they can be updated in some later patches as well if they do
support SFDP Parsing.

> 2. Add required output of sysfs attributes
Yes, but I am not sure in this is the way to do it in the commit body
itself.
When Tudor asked you for those test logs, I think he meant for you to
paste it in the cover letter, or below here not in the patch email. Not 
in the commit body.
Refer 
https://lore.kernel.org/all/cover.1661915569.git.Takahiro.Kuwano@infineon.com/
where Takahiro has provided the tested details for ID, SFDP, Test logs.
> 
>   drivers/mtd/spi-nor/macronix.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 6853ec9ae65d..6c3b4192a8ae 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -100,6 +100,8 @@ static const struct flash_info macronix_nor_parts[] = {
>   	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>   		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>   		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
> +	{ "mx77l51250f", INFO(0xc2751a, 0, 64 * 1024, 4096)
> +		PARSE_SFDP },
>   };
>   
>   static void macronix_nor_default_init(struct spi_nor *nor)

-- 
Thanks and Regards,
Dhruva Gole
