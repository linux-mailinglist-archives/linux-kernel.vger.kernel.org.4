Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289EF5F99F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiJJH3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiJJH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:28:35 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2116.outbound.protection.outlook.com [40.107.247.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2E869191
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MChIMj7BydwAgwpuHWSi9HAD33JK9bH9XAhDH434Mip66UzAit35rdJuRN53scH8bwVLZZc1b8ouQNvVE+c622C9ylDzbF5W6XonjC4yTEhkMIekQHuEqi1nAvCEd0X73BOwrP6FjnB1DlR3VarceURunEruzjnYSmSNAHIEfbG3z66vq/3gVhhhDIwTmdwEMT5Ul5G7EbZbzVBWABNvbWxG2NYkwlpcTF0NmFMHRhflcp+BX8IdUs1bmZosDVSIvZ8UiYJHcivAyf8s25xeiA3Ztyf4+pWWUc1WN5tJtAS8+nd0TZTuF8TMmpUD61HM+8w11lKSG01GDOJDVygGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85Dzdbme92W43sYnN/QAXbP6kOBFh3v9khOnr90OsAs=;
 b=fVn9yKHqdqtPDVC36IJfHqV8GEImTfXnRmxXbW/bYsDqHzJyNdcUwssGhAux1zw2hefk1YNDSxdhZyfhN7BLkptDDcP17SJnu4pNGCY84OPjfnEWmT8yzrHyEhAs718Xqt9Fp49zYcbhH5CNY+sbvMB3OBun34SqxI5FNzmOGfAwsJgrW192ZCoHzrsXSuqkjsGWLgbsyD4o6J/aJ4Ftox9LLY6ycc+4O8KYKJh+lN6PoTvASE0Q5bgiA9S38zF1ml/a/J8w9UyjBiwCiLpm/ril0zROhbOJxPsUtX5Jk1ikjL200/ouy4r9/6dnO5XuRsUTuMbj2ztJN2LcC6nUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85Dzdbme92W43sYnN/QAXbP6kOBFh3v9khOnr90OsAs=;
 b=Bx+HfHXek5+dRg53+vFqzBGWJ4gmKNnUDBsUMUJJXceOXNWNCk5Z3JDEh6LYE3JvShPO95SvGPYfWrLMr3ROMNM7etb2YylSxUrPMvbtnuo0zBwTyu3uWM3GupGmfSxw5fXWk+Br92qsdYFK1bo5qjeCljDQgIC86ds+VZFAFNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6686.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 10 Oct
 2022 07:13:41 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fd4:b93c:2d9:2542]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fd4:b93c:2d9:2542%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 07:13:41 +0000
Message-ID: <142333ae-2e47-11a0-22b8-139c6feaca9e@kontron.de>
Date:   Mon, 10 Oct 2022 09:13:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] mtd: spinand: winbond: add Winbond W25N02KV flash
 support
Content-Language: en-US
To:     mikhail.kshevetskiy@iopsys.eu, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221007104820.198938-1-mikhail.kshevetskiy@iopsys.eu>
 <20221007104820.198938-2-mikhail.kshevetskiy@iopsys.eu>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221007104820.198938-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0066.eurprd05.prod.outlook.com
 (2603:10a6:200:68::34) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f226ca2-dc9d-498e-f8a6-08daaa8ef5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uAQ7cZBRVlDFDfKzYBfMK1nfk/1R3mkc4m+gowS7/sR47vnMJ1NrffdzcD+E9T9dVtQ/X0HNRn5NfDHZTJhuWgd15NI2ZavAc0ourI8gKaU1NSed4dGsRmwcfJUOKMpQ9WL9e3t0LVAeZBjo8+EScCYSh9+Z5E36A9cPaajTBwY+jCvGDn1YwlgCI0nPfTj9lstwvGbUbFQ7JoDAtEAnXLVWile4Faie13HIwSPgEIp8eBgLPimHgsLqUGr548lq7n3jgzzOgkd9RWe1au6kxZStEo4QGZDta7mjEIODVz8VLYx/i3i2AFo58sze6MAzQ6UonQvG6KzgtzqplI3DuZ09/xZ7TzvTV65OOp38yzpbR8qt5sqZzyExyCyDmaUbN3CJvb46eZSzn40tjG/augXAm39zmrm+NBDzADWGs5amnmUSXcbBcd6cmaM+7BWuWMmcPXAtGw+kHE2hznLWmroN8iZVNesE41ITzfUolW4cTOWT1KwWDAVGivHwunaldMVos3zm/EmfZl5WuRAWBHXPgMb2SPEdXAyLxiBqzCcYpJZfQ5l+L1vf5f55ur1tTLYSXupj6nAPYKrnl1EL3winzXOJ0vJB/zT6q2CYrWzUBgRXGQXGWJF5yO/yYJSLavM3H7wVvHf1s8fWM55l67wuvqR4YyJRVz6wGvyssL2irFl+3wtkA6onqTRqB0mt2KCriTMccy4A3bpjf321qZDkP2xd6htZk+XdP+IraWt7w/kpLDNAziTEwxAorq7lnCf6TKKDW+eWrthQ9XnkqLN0dLuZIBG8cshGxKfTpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(26005)(8676002)(2906002)(86362001)(44832011)(38100700002)(53546011)(54906003)(316002)(31696002)(83380400001)(6506007)(41300700001)(36756003)(5660300002)(2616005)(8936002)(66946007)(66556008)(66476007)(4326008)(6512007)(31686004)(186003)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjYrVjNqOEhKbVFFSkVxU0cwbndhbDBaejNUc1hyVWtDSytoRWFoaDJIcGJj?=
 =?utf-8?B?RUFEUlYyMHdtQ2RSTUJoM0poYmdRdHB4d21BSG5EYVVmRHRVUUxzbHRIN2ZP?=
 =?utf-8?B?Snc2NHJwcmhmN3JzcnlkN0RDOUwrNTlYbWk5Zy9TTlBUd0VsUC9jdHdkSm1H?=
 =?utf-8?B?d0lSV0dtQVBZM1ZabnE4Ty91c3JIVUlxUHJrVXN6UUNkOHVHbU9yRFBRMXl5?=
 =?utf-8?B?cWNVdE9sZ2pYOVZPZGZYU3FGclozKzFqS25aSm1RNmRmdldzOFJYNmxlMkNR?=
 =?utf-8?B?eTZ3QUhpUkhSZzJNZyszZ0RhWTdPNE5nMFV3aXprMXEwYi9ndEFXSWx1ckp3?=
 =?utf-8?B?dVA0YUNaLzZjRTcydVFKbTg3QUtKbnVvWnBxNmFBNVJmcGV3cHVlTXZxY21I?=
 =?utf-8?B?VDVXRDNscGo3OXk1Z2tDSlE5RTFuUUNBQkcrNW5yR3lOM2ptRG9ZRC8vUkV2?=
 =?utf-8?B?aisxRHB3QW9uK04zYzdpTEtPNkM3dHZTNFlET3ZxUlJWT25MckJFRlZ0NWVv?=
 =?utf-8?B?MEg3YzBhTzY3eHp3NUs2S2lxMS9QU0FacllPNGQyUktSUnJYNjNuTnVJTkk1?=
 =?utf-8?B?VkVrSWxJd0dlU1hVL0lJSlAwbURHMlBSdmJCbkZsOGpFdWxoWXNXMFVORWd1?=
 =?utf-8?B?OVdKMkY4Nm5ERlQ4N2ZyNDEwMS8yWjlBUmVwUDlGUDdQaW5QUGU2Wm9ZWm5r?=
 =?utf-8?B?dXo5am9rbXdzb2M2SUtsZi82cEUrbGFwTGJsekdvVGtkcjhlMXg4VitycFhH?=
 =?utf-8?B?ai9ZZTQ4cUZHaG9sS0xqcExOMkVxMElZTHNvVlRiYlR3MnBuTjRRTWxvcEdS?=
 =?utf-8?B?MDlJZzlqRm55UFZDK2p5TWxvYzRkME1LbkdrWDd3VHQvR1VZdXJHR3B0WFh3?=
 =?utf-8?B?azJKWUlXOUpCbkdJbzI3cnhicHB0dmZKT0NCUHNsSzNUVllpMk9sT1Q1d25q?=
 =?utf-8?B?OHlJU3pDOTFZYVNUUlVyTVJFbFViNmtjQjZZOTNyL2lYMlgwR1hqOWlmMTZR?=
 =?utf-8?B?NkltUHVnYndQT1MweUh2b2lYM2UvUWhxL25BZ3NpaExUdmhGSndWN0MzT1Rx?=
 =?utf-8?B?Vm5jalFQemlvMzZBMjBDUVQ3TlErMTR6Q2dxWkx4OE9pYWJscGlaaDVTNS8z?=
 =?utf-8?B?dDdoV0JlV2U3ci82MnNYZ2xzVlR0Y1pQTmk2WnlHUm5Lb1JnbGpxWWExZUh3?=
 =?utf-8?B?RytjdnZjcVhCZHVHSnNJaTIrd0JHUWRpaFF3Q21kcDlxSjN1YkNWWEQ4QTJT?=
 =?utf-8?B?NUdyZ0RnSXpObWF3elFNOFVaRkwrM2llc2VyaGxUaS9MLyt2bHJxZFRYYzNa?=
 =?utf-8?B?VkdzODQ1Q1VmQk0xTGZjbkgrQkY2alJwTytrcHk0c2hmNWVQZGJtUGVqb2ZM?=
 =?utf-8?B?WmhsZDZybEZJZkNxZXUxT3M5MXBGR3JadGgvL1pEN3R6QmhTT2FFdUZmcXAr?=
 =?utf-8?B?dC85SzdnTVNNaUFldEhmbEFrRlJvWWt0b3Z4eHhuSHl2TnlJYSt3MkZlTk1i?=
 =?utf-8?B?WEdXd25JN2k2d3BSaFhLT2s4TnZCVFR5ZWpBZXU2LzVwcnM5azBrTkdlMEVF?=
 =?utf-8?B?WWZvZmMyRXdjbFQ2T1pVYUZUS1Z4dDc5TFFLN2VGWllmUVlYYVp1blF3WXVB?=
 =?utf-8?B?QkVKZkdyVHhmU1d4TUxWaGJFRStnUkptUWM4WUhzYk92T2NISDRxRC9Zb2xZ?=
 =?utf-8?B?dVJsV1hvdFdPQitGeG1BbEI1QXQzeTBwTW5ld2ZnRzJJTlRud0hlVW15MXZN?=
 =?utf-8?B?bzJvOVMzVkZQU3lqbVIxK0NxUG94ZUJrVGdBby9IV3V5VG5hWFZiWXdLSlN0?=
 =?utf-8?B?b1hrdXdYT0tUQTU2aDNMbCt1cDlMdU9FVk5lZVA5eWlYVE5yYjhSZkxsRDRG?=
 =?utf-8?B?Q05Xa0FhRnZiQmR4dCtiREtYbng5VTRycitxaUZJTGNnZTZHZU1CRXVjRVJ5?=
 =?utf-8?B?Z0svRERqMU1MdU9sYWFWVThaSW80SUVSZUNFWk9yNk10dnpIa3F4QXU3SmVz?=
 =?utf-8?B?bUcxTVEyVURiWUxpTFhRNFkyRC9HRWEwYnV6bW03cHJYRUdjaWE1UGYyeTNv?=
 =?utf-8?B?L1FvOFo3Nmo4aEpVbCttZlVrMWhzMlN2bndlSmhRSytSb0NlUi9RcDZPQXl5?=
 =?utf-8?B?dzdhRnBQQmtSN3R0Mnk4REsxLzRBeGNBK0lZWGdVU25pckZuOTh6ajFNd3VY?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f226ca2-dc9d-498e-f8a6-08daaa8ef5ab
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 07:13:41.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOA9wq6gwlki4G/6K/FtKYl+vpp4TNqEZRMYl/OiqQFrrw8YlsVPe/YVSbvViEh9G1p4paWaKgusw4wfvNKCTAuG5k563MOUIu1Q3vF89W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6686
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.22 12:48, mikhail.kshevetskiy@iopsys.eu wrote:
> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Even if the subject line already describes the change, you should
probably add a short sentence here so the body of the commit message
isn't empty.

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/winbond.c | 75 ++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index ed368a55d68f..3ad58cd284d8 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -74,6 +74,72 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> +static int w25n02kv_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset = 64 + (16 * section);
> +	region->length = 13;
> +
> +	return 0;
> +}
> +
> +static int w25n02kv_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset = (16 * section) + 2;
> +	region->length = 14;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
> +	.ecc = w25n02kv_ooblayout_ecc,
> +	.free = w25n02kv_ooblayout_free,
> +};
> +
> +static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
> +				   u8 status)
> +{
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	u8 mbf = 0;
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		/*
> +		 * Let's try to retrieve the real maximum number of bitflips
> +		 * in order to avoid forcing the wear-leveling layer to move
> +		 * data around if it's not necessary.
> +		 */
> +		if (spi_mem_exec_op(spinand->spimem, &op))
> +			return nanddev_get_ecc_conf(nand)->strength;
> +
> +		mbf >>= 4;
> +
> +		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
> +			return nanddev_get_ecc_conf(nand)->strength;
> +
> +		return mbf;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct spinand_info winbond_spinand_table[] = {
>  	SPINAND_INFO("W25M02GV",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
> @@ -94,6 +160,15 @@ static const struct spinand_info winbond_spinand_table[] = {
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
> +	SPINAND_INFO("W25N02KV",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
>  };
>  
>  static int winbond_spinand_init(struct spinand_device *spinand)
