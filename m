Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18636B7BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCMP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCMP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:28:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF176144;
        Mon, 13 Mar 2023 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZlzeuB99z2QMf0zZvwBf9fww0nyXfSCVEUQLazLS4c=;
 b=nPWQ6vDZkYJOrUTZ7ehsnXyGDUQJFnYFhkkUZzTILX5hIt9fdGBzwW+GON1Wqe+ht3ZAeqFaD3sECSA0oACdXYEbZeiHrJLocP84rTPhXnbAy2ni0CS6GCrUefMvWOAJDBJydDx7PHtjds0804plPg9xP/S+Zbc+Wp5LF0MVUizsZUmAXgql+YLLSp9HFMlowh4dzgLafURpYh8083DjsPS+txOB0B8/0FnRcmD7Z9o/odVjwGg0P/BUFV3g6hUlqXSUD6EMgenHz8cMtlR+zKU4EfVokDoo5AvwTfaj3vU7aFBzoLLuGUHjnEibsDDIatzHxwTerJJn7wRu46YH+w==
Received: from AM5PR0601CA0030.eurprd06.prod.outlook.com
 (2603:10a6:203:68::16) by AS8PR03MB7604.eurprd03.prod.outlook.com
 (2603:10a6:20b:34f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 15:28:43 +0000
Received: from AM6EUR05FT064.eop-eur05.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::9b) by AM5PR0601CA0030.outlook.office365.com
 (2603:10a6:203:68::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22 via Frontend
 Transport; Mon, 13 Mar 2023 15:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.83) by
 AM6EUR05FT064.mail.protection.outlook.com (10.233.241.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Mon, 13 Mar 2023 15:28:43 +0000
Received: from outmta (unknown [192.168.82.140])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 063022008026E;
        Mon, 13 Mar 2023 15:28:43 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (unknown [104.47.2.51])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 2FE7620080075;
        Mon, 13 Mar 2023 15:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk6SZewqqNMDJWXHHpBvq43XKDp6DSlnxd5PPa0DhMXsRVzX+UGgV+vI/5AGe+M8PGLUeQsQfQ0FckYnYfBE6pBd/hVSGGhi/uAueTYxjA2P66jSgk7sMiBAZ3zilU4LRNYOEzGD2dUzU1lbeu06A1v6bfc9Ughd+mqWFAR+vwvGtnIxDf8isqTLAbk0W9W0QvNRgSjXyBb/Z17avCuGdXJkdwI9UBZ+V3MEwv+SyhUvwIPi6MIdMhK9bvcHUdR+MpalX1+s/NvlFrzmvTjeRfnEMqSLdsMm0EHGSZaqt7T5jKItnTFJwPqTjZzHCIRaQyLUd5riki0EOZCDoTQ2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZlzeuB99z2QMf0zZvwBf9fww0nyXfSCVEUQLazLS4c=;
 b=nKae3vkg3xLo/uKc66950UEpNwDaAAuPoJ7sSFG5s/ygwzckaa78WVkqCGI/RYrx16LpQgaMaglPxSq0kUHUaHszszbc7UhmyPmULI71hOTtSpwoHLh9HSUgwhXPxo/dWwBvT5zPKXs8sDgwNq2d3Qmue3ucD42YnvTVQw67A9cd7C8au5vBBHSN4OHHF1IT7NQQYwTL5gev8XCS4kC7ZV/4cldl4y4hg4d3EvH6uPdIPBUU5OCu7x60jQYgx/EOUFXaOYsCPZsbLMVsfR9q+uqbWwGUGhq2IeLFv59ZSVvdreM5r5YMvMypwVu30YwG5U8yTBBWaZ5lVeYJLse+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZlzeuB99z2QMf0zZvwBf9fww0nyXfSCVEUQLazLS4c=;
 b=nPWQ6vDZkYJOrUTZ7ehsnXyGDUQJFnYFhkkUZzTILX5hIt9fdGBzwW+GON1Wqe+ht3ZAeqFaD3sECSA0oACdXYEbZeiHrJLocP84rTPhXnbAy2ni0CS6GCrUefMvWOAJDBJydDx7PHtjds0804plPg9xP/S+Zbc+Wp5LF0MVUizsZUmAXgql+YLLSp9HFMlowh4dzgLafURpYh8083DjsPS+txOB0B8/0FnRcmD7Z9o/odVjwGg0P/BUFV3g6hUlqXSUD6EMgenHz8cMtlR+zKU4EfVokDoo5AvwTfaj3vU7aFBzoLLuGUHjnEibsDDIatzHxwTerJJn7wRu46YH+w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB7179.eurprd03.prod.outlook.com (2603:10a6:10:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 15:28:34 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 15:28:34 +0000
Message-ID: <e029e39b-196d-ee4b-318d-6dc950b2b26c@seco.com>
Date:   Mon, 13 Mar 2023 11:28:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4] rtc: abx80x: Add nvmem support
Content-Language: en-US
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221222214532.1873718-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20221222214532.1873718-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:208:e8::38) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB7179:EE_|AM6EUR05FT064:EE_|AS8PR03MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d1117b-5a1e-406b-de27-08db23d7a126
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: geQsltJG+JJ/b3ewYXTsX72yQiUTwpSyFQDApXXQ/2+dMaxEjccLh1RqqTFLDk5QgV1alMeaHZ86l2Y9aeyDh0JG9yue/5W8C5e8GT44yUEMqgNJMLFoXi10zdSN5ZUOEHZVzUsIH8CYhTLC2mIKj9BNO/MtZwZPJhpMXSh3UQUWJvKSDKkBj4oGC7djoez6TjeURyOMQR/vCV2wBUB6RaHt/UjtWGBoH3P2Dh6iHJZjfME0SC0xqP8x7+BzitUHQHONqXEAcMWyzTeiNmuo82hFndAqSShyLTD6cpQYiGAqOp43lDkF/pO8eY05OoVTNKqxVq3sr7bjPwD18icpuMbfDDZnN5N1nufsran5CqNkUYIuv/Mlc0wQ3X3zOvfwveEDs+4J4XtTa2rXuqSsmJZH9IeHAw0u8mZkMlaYjUsmNjdQsTpR3NuuPGMgvuvoei7OrRbO688KkoY+r84uh2NHuxqDrje+rBH4S4fC4ersLZgDBwatRofMnFVyii+XDt+PbjqZMuML7Rrwx8zNepuZg4Eo8Fndcpon/b/H6qYZj+TrqXZYwpmUp4Ut+EE9PobI03dzRLf3KKZaon8IJ4wAzGArzdEQSwqBA23/wXwQiQu2INso1bKscyGeKs82ndRPe1obcCk4B2dPMiVAgwB8RjvUCk3i5EfSdvhe0Aj2W8iI9m2NrPACb79JULqeoqM5ZW2S8wBKrMy8akYlHi39gNZ/TQLX1mBU5O8XEZtwnY5sODVtSO693+W5u66NGDmOSxUDW/CKSXLdB0Bmvw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39850400004)(366004)(346002)(451199018)(86362001)(36756003)(31696002)(38100700002)(38350700002)(44832011)(5660300002)(52116002)(6486002)(110136005)(8936002)(316002)(66946007)(478600001)(41300700001)(4326008)(83380400001)(8676002)(66556008)(66476007)(6506007)(6512007)(6666004)(53546011)(26005)(186003)(2616005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7179
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT064.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f790a46e-a31c-4d5c-cb74-08db23d79be7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNm0QcbC3o4adgSzA5QXZx1yb3dZS/DuUoO9pWiefHA+FlHuxGS/jid8yt3vz5oBTRpUHX9Deq7IQOzBCiVu4GRIC67N0IXZsf+FYpKGol0SJrJ4yh7KrsXvWNu62XSRNe7VPTeZdDW2PEPWhcxP6LdrLVhVaK//lu1Qa3GlHjNFspCLfcFNI9+PUSmIANHFIYcqy009Ed2ajlILgrcfneoiuqO8BFXfbW5onP/zInMxuLEReFPc2Jbca8TnyPkP8zpq8fkZQLtp/wrk/fzKcqlBmqhyQo2s2Zux2NTfwAsNbTQspHsdVycWp3/Ww2/UvCzFJDyaxzyjqVlTrq+pDmOpvoRg8+JbhRFey9/LnqffvFOiNppP+79WPAKJGRdZdlK21wTiBLIuV3W86WfZEGAsstR7ZZZlj5MZkZ81Sj63Iid6g6Q9zHYWrXN+YxoeqbhFbIL+r+fnPPfpmIVFHCXXiXgLQXfoW5mMKFEboyPk/halWskgQ2P8XH864CZIPD4pUNtM9vKo58i/rYxs7ltzYi5I0pG2HFf6taHCLipc5MBTRB6AIyDapxmuEKtJGU0Y4wDp3Xkwy3DABoB/yvjKJbNfe8a1tCmesYJRpoR0lOe1x3HWxT3W1foKnVdNW+FOPPXwPLVSz7MuYsAy5c/amCE96ZCSpz/O7XeZSHWmnBLJc0ZW7NmeoU37U1Q1UeZnPgPPvAs0Jbj9sDE5jJhNRF0kIED4WVn+Aky8NR5VcxQd5W0l8jUjusg0ei4Q7rrTBz82U/jPCap3s38Vdg==
X-Forefront-Antispam-Report: CIP:20.160.56.83;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230025)(136003)(39850400004)(396003)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(31686004)(36756003)(8936002)(5660300002)(44832011)(2906002)(7596003)(36860700001)(82740400003)(7636003)(31696002)(356005)(86362001)(41300700001)(34020700004)(70206006)(70586007)(8676002)(478600001)(6486002)(6666004)(40480700001)(4326008)(82310400005)(40460700003)(110136005)(47076005)(2616005)(336012)(316002)(83380400001)(186003)(6506007)(26005)(6512007)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 15:28:43.1208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d1117b-5a1e-406b-de27-08db23d7a126
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.83];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT064.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/22 16:45, Sean Anderson wrote:
> This adds support for the 256-byte internal RAM. There are two windows
> which can be used to access this RAM: 64 bytes at 0x40 (the "standard"
> address space) and 128 bytes at 0x80 (the "alternate" address space). We
> use the standard address space because it is also accessible over SPI
> (if such a port is ever done). We are limited to 32-byte reads for SMBus
> compatibility, so there's no advantage to using the alternate address
> space.
> 
> There are some reserved bits in the EXTRAM register, and the datasheet
> doesn't say what to do with them. I've opted to skip a read/modify/write
> and just write the whole thing. If this driver is ever converted to
> regmap, this would be a good place to use regmap_update_bits.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> Changes in v4:
> - Remove unused variable
> 
> Changes in v3:
> - Use devm_rtc_nvmem_register
> - Remove ifdefs
> 
> Changes in v2:
> - Fix building on non-arm platforms
> 
>  drivers/rtc/rtc-abx80x.c | 77 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 9b0138d07232..74ff820f5481 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/bcd.h>
> +#include <linux/bitfield.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -87,6 +88,16 @@
>  #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
>  #define ABX8XX_TRICKLE_SCHOTTKY_DIODE	0x4
>  
> +#define ABX8XX_REG_EXTRAM	0x3f
> +#define ABX8XX_EXTRAM_XADS	GENMASK(1, 0)
> +
> +#define ABX8XX_SRAM_BASE	0x40
> +#define ABX8XX_SRAM_WIN_SIZE	0x40
> +#define ABX8XX_RAM_SIZE		256
> +
> +#define NVMEM_ADDR_LOWER	GENMASK(5, 0)
> +#define NVMEM_ADDR_UPPER	GENMASK(7, 6)
> +
>  static u8 trickle_resistors[] = {0, 3, 6, 11};
>  
>  enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
> @@ -673,6 +684,68 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
>  }
>  #endif
>  
> +static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
> +			     void *val, size_t bytes, bool write)
> +{
> +	int ret;
> +
> +	while (bytes) {
> +		u8 extram, reg, len, lower, upper;
> +
> +		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
> +		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
> +		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
> +		reg = ABX8XX_SRAM_BASE + lower;
> +		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
> +		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
> +
> +		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
> +						extram);
> +		if (ret)
> +			return ret;
> +
> +		if (write)
> +			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
> +							     len, val);
> +		else
> +			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
> +							    len, val);
> +		if (ret)
> +			return ret;
> +
> +		offset += len;
> +		val += len;
> +		bytes -= len;
> +	}
> +
> +	return 0;
> +}
> +
> +static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
> +}
> +
> +static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
> +}
> +
> +static int abx80x_setup_nvmem(struct abx80x_priv *priv)
> +{
> +	struct nvmem_config config = {
> +		.type = NVMEM_TYPE_BATTERY_BACKED,
> +		.reg_read = abx80x_nvmem_read,
> +		.reg_write = abx80x_nvmem_write,
> +		.size = ABX8XX_RAM_SIZE,
> +		.priv = priv,
> +	};
> +
> +	return devm_rtc_nvmem_register(priv->rtc, &config);
> +}
> +
>  static int abx80x_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -824,6 +897,10 @@ static int abx80x_probe(struct i2c_client *client,
>  			return err;
>  	}
>  
> +	err = abx80x_setup_nvmem(priv);
> +	if (err)
> +		return err;
> +
>  	if (client->irq > 0) {
>  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
>  		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,

ping?
