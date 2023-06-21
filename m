Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA18738AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjFUQTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjFUQTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:19:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3C10C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0FPhg+ljLBhIjzYKO3Gb2JMFoPdS1DV42eDc0hQxDuk4AvF3THbALd0nq1YZJzomd4CUepKIWQaDsX4v3k090Rjnl0CcwsvTH+tyGetzMscgWTI8GLXjwt1oWODi4K2gTlQWvpYV4fxRhnLgBN/ZLYce1UejHZnCtnBI5PnrNl6SCY7AZY4DWv+wxlP3qP44hRR8B6xMrZ+y6/iCHhe0XMZ18GRYV7qojSHM2IbsKxdSb5h+7SlBZ8OTpISZt3OwvO3dYQRiZ4jURVoBf4wRNJ27ZWr1LJ1Ap+Ahqzyq0vAciXJwSyiImOvuYNrfcMX/69T1Yln6kaq/9MvgplHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyHOotW2k+RetLr/7XKmT8djA2IpycQardQnR1yOj8I=;
 b=P11kTIfN+bwpVZnOFjfoU0tALHtqXWVCKMnTWJatS2ZB5zAWCKAIQICmP4YRwRQvNC2NvWAdWG2PByQBmuc9gGv6wWh0tslncL3Hab/AHsXAG0A92UPVBfx7Ws2ApvkzidtQ43OZ/PYfQFeMWeGAUNgh3aBv7S3ueWWYBsFYSyM2Y3cpSL4axzEU4JJK6T/3FBgJDbHwSupyj5GHFAD2WECzwuacODV3HiJgHMKRY7dD6ZZAXiL5mEnUr6daZj1JZ8Myde+C90OPDr7ykbJugkhMFuppIdB/Zac/oHaaXRpAQ4rWlHNuRj5pzo7nvM+0n3T8DccWdZAudcSj9e81tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyHOotW2k+RetLr/7XKmT8djA2IpycQardQnR1yOj8I=;
 b=Ta4q/Va5ePyonXsCZEkKYZkZwMQeLgbvyxcMi3ReiHoziFxKwBHehBFsZnWlQxku3B6tM0KPk/qIeugOJti8xmVPkWxj7z0dZnLZvfIIkB+qL0Uv5JE2Llj/rXCw/0o2M+b4blDkRKMAB9VAhWBaIA7fuLf/Gksa1i1ez45cv4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by DU2PR04MB8966.eurprd04.prod.outlook.com (2603:10a6:10:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:18:53 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::1f2:6f48:8741:cc32]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::1f2:6f48:8741:cc32%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 16:18:53 +0000
Message-ID: <6ff1fe2f-7840-288e-ecda-f3aa0fbe1ead@nxp.com>
Date:   Wed, 21 Jun 2023 19:17:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] bus: fsl-mc: Use common ranges functions
Content-Language: en-CA
To:     Rob Herring <robh@kernel.org>, Stuart Yoder <stuyoder@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20230609183215.1766735-1-robh@kernel.org>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20230609183215.1766735-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0017.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::22) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3405:EE_|DU2PR04MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ecfe7b-7348-4a9c-f34d-08db72733418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5q8i+mngGkTouk6mV7oQqu7wmXIDQK4QqSHK0zl0FI5Sx3QKAsba2iYGVtjove0msMwrIWJsZEBhr7ngh88RoR3JovBTsEibcUqVY4MWM0gXvZvs6aDD1aP4BigKvc28TxryqM3rQvanWy/QyL8u7RH5vgH+zrniYnxZvLKe8sbLerHiN6+nvo0LcG9v+qfHO18IOZTRTvOnhPmzv/NnKKrbTWvP+rfFukZojsebzxCb8wvl0p8YMmWubU7uwTux3N2ncZIbbwkC56CxOiB8KUI6Izaazz8oFwQEpUg0u+3WsywGZgXpUdC4TSQND/qYyD/Mvqb3LoXraz45qP+e/VZxPIfolPsF7+BZr3MqNkjsP3sfYgl/P68KxlkmN/VjPC+MNTp5heGGXNbm9uYYc3I4p/h8jZoBmEknJKMrsy7EajMaV3u9mhSCgF45QtC9M5Sa+b2WVqTcDE8uf8NPZN9UgmJ1+sweIlVTEak4Z4hM008k6jtn5EVrk+up+t8eo15CxVjCHpVYudODPD1C2NFase2cXqDJn5XoahjmyLSuO8qc/YyalDxwHSJ3/YpikRK1sP02N9NFlE2GUS6TxxgZng5JkXGbhkSITfV9n5htCPsQUzQryqHSJF5d6dYAgMPy6/mVMYRE1pREumZ8/dXbRTskdC9Bg5RNcB3br4biuQdpyGghSV3KIwcpTLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(6486002)(38350700002)(38100700002)(52116002)(83380400001)(186003)(55236004)(53546011)(6512007)(6506007)(2616005)(36756003)(316002)(4326008)(66476007)(66556008)(66946007)(2906002)(8936002)(8676002)(26005)(31686004)(44832011)(86362001)(5660300002)(31696002)(41300700001)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q24veXQ5SFYraTVYaUc0L09ZdmVrWGJaS21KQk4xcHJLMEwwNTRyMStJMHlq?=
 =?utf-8?B?R0grdmgzK3M1T0pLNlowc2ZQY1hyRzRESnZGL25WSm1zeDhGZkpRVUNLOXNR?=
 =?utf-8?B?d2FTYmZoNVg3Y0F0U2hsNjE1aHVnSVNuMTAvd21OQWhYMThKY093TUxSYkFp?=
 =?utf-8?B?OHZ2NW5tVGhxdVROekNDUE1RQXhMU0szK2t5YkZEMWRjN2FNZ3hYU1N1U3Ro?=
 =?utf-8?B?RXVvdU4zQUVTQ2t3dEwySFJYKyt4M3Y3cGdOZWIxUnBLUnVKUFBkUm9MeFpy?=
 =?utf-8?B?cDdSYU1XYnQrVTRuM0RGQUg3OU40bEpTQjYzRXVsdElWMmRZZVFyWHBleEdO?=
 =?utf-8?B?Ym9XTDRNVlRWd2xuaDVqTUNQT0cwV3BEWnRvSlgzeVhvUVpoVHVVY3pyenlL?=
 =?utf-8?B?MFJYV0w3WHM5VTlVd1VnbzBPcGxCLzA5NUxUbUQyMUxtdUZXaTdkcURNRHBU?=
 =?utf-8?B?SElPMFA5QVI4NmM4bE1jbGNZUWdHeXlZQW44eTdkc2VxYi9XWXRlSDdZWGpm?=
 =?utf-8?B?dG5VOGRGaXBFMGlDSGRiWTlmVm45dnNScC9vbkhZYzNDc2J1WEpERS8xcStH?=
 =?utf-8?B?SjRZMjdwMGVmNGtxUHlkWHkvV2R4V0hZVnRFQytJRGtrZzVHTDRxcTU3cVVK?=
 =?utf-8?B?UmdPUWtkeWZtMGx2WWVTQUFqZERORldzeDI5QnVKR2l5cVNmd1pKYVVCc015?=
 =?utf-8?B?dHUwVWh0eGxwcG54K1ZLRWRPWkxyVlRIYVhvdHh6cUdrNGQ3TWF2NElPZmgv?=
 =?utf-8?B?V3hjQVpGUUhvcWNENVJXYkIrMG90MzlDK3FtdWEvbzV3alF0ZlhocnlCbVdT?=
 =?utf-8?B?THhlc2pqcnNCcURrVGw3S2pvQUdUTWNFVFJIcEc4TS9LeXBDbXd6NnRvMndK?=
 =?utf-8?B?WFJZTnRNdGo5TmdGTlZUbUhlUzlUSGdpMERXWUJxRXpTaWk5c1hNWThCMDNB?=
 =?utf-8?B?UU9sNStjWDZYYWdJZm1aMkIyUEJYVEgwT2Q5RmF4WCtHdjFOdHdvRncxaVZ2?=
 =?utf-8?B?VUVZa1E1S2VKZlg0eGdNblhHUVU0Mk1LZXpmRGt0d21NdzJyb1lHTVdpc2t0?=
 =?utf-8?B?K3FTZ3pjdVFoWmNYR0Faa1hWZkRDbmJ3QlVjVU8xdEFkMkNoaWRKTFhYQXdS?=
 =?utf-8?B?NmlFYW0yTTNLT3JmY04vdThYbzJsQmdPcERyMEcxZnUxdXYzQmo4T2hiSTd5?=
 =?utf-8?B?NGJRVU4yczZFa3lLR2ZvbHorcnUrOXdNdldOWmJHMlE3a2N6ZEhmN3BzTSs1?=
 =?utf-8?B?U0RrWkEwV2hWZTRCVUZDbEoyUUZ6N1FqS3ZGRFp2Uk1WSzV5WU9yTTFnL09S?=
 =?utf-8?B?c1QwVVVWQ216ODFFT3BMeHJqanBrMEo4Ri9oUzJmL1NrZ3d1YjJ2cXpQRURC?=
 =?utf-8?B?QlNtZEtYSEJ2Qlp1ajFkMWhVU2xUMW9nQXFMVVVVVlhLTE9pQkF4U2VpM1VT?=
 =?utf-8?B?NHZLMzBnUjZiUHVnWUNLMFIzUWFkaGorSFg3eEpKZVdPVGg2WngzQzNEN1N3?=
 =?utf-8?B?MVkyc2d0Lzh2MnVMRVA0c1JMRXJPeWt1UFNOS1plTVNvOW55WXU4Z2JwRG9o?=
 =?utf-8?B?RmJvN05wWmloRjhKMlBQdXlrYU5qV2t5TGExMXFkSTllb3lDcnc3VFR1Qkho?=
 =?utf-8?B?MW5qS3JDaEk3VlpmUE41ais0MytyUXpscXJnNlhTYThaL0tRcWF3U3VpNUtk?=
 =?utf-8?B?NzBRdE1vSHQ3cHlMdGpxanRLMDRIdDRYcXNKUTUzejVsd1plTkdhN082RFNa?=
 =?utf-8?B?K1gyenNMYklrS2xGVFRDNTZVcG1rWUJMWGFsdnN0TUpWSHk3RGJiSC9VVzJV?=
 =?utf-8?B?VS9tY3MzbE53c1VRc0FmRnZ2K3NxNGhvZCtWcnE3aTBPa2FKV3pXNXJkc0xV?=
 =?utf-8?B?YmJkMEVJUm9zb3ZHRG5oVzBzSXZzbnRsSTZHM2NoMkNWWStBcUtraEYydStI?=
 =?utf-8?B?QXFycy8wemRaVHpkSnJZUmYzTk4rNGdLT0lIL0U5cVE2QjI5YnhacjVGNlZJ?=
 =?utf-8?B?ekRlcGNZY2xHOFRqSFZ4SEJQMVRvQzg3L0Zic20rWVZWc1cxSi9JSFNZSk5L?=
 =?utf-8?B?TFdTNkZPZ1VySG1YR1V2MC9KTExmKzBPZWZYTXp4Qm8ydzJTYjNxN0NNbFpp?=
 =?utf-8?B?ZzB2bFE2YTRiRFo5cE5MQTcxY3NPMXZWcGxSaXZWNklHWmVraG13cVVGeVMz?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ecfe7b-7348-4a9c-f34d-08db72733418
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:18:52.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWCxXk0sozXE3MpWoNjv72sV+Sva6wqLkOjvGaNqx6GXn1qezlIMhMLOqhShaxI9a02znPPSIcLKrMR8MkAc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8966
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2023 9:32 PM, Rob Herring wrote:
> Since commit 3d5089c4263d ("of/address: Add support for 3 address cell
> bus"), the DT address functions can handle translating buses with 3
> address cells. Replace the custom code with the for_each_of_range()
> iterator.
> 
> The original code had fallbacks to get "#address-cells"/"#size-cells"
> from the bus parent node if they are missing. This is non-standard
> behavior, and AFAICT the upstream .dts files never relied on that.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks, Rob!

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 90 +++++----------------------------
>   1 file changed, 13 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 653e2d4c116f..5062d73b13e2 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -999,75 +999,18 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
>   }
>   EXPORT_SYMBOL_GPL(fsl_mc_get_endpoint);
>   
> -static int parse_mc_ranges(struct device *dev,
> -			   int *paddr_cells,
> -			   int *mc_addr_cells,
> -			   int *mc_size_cells,
> -			   const __be32 **ranges_start)
> -{
> -	const __be32 *prop;
> -	int range_tuple_cell_count;
> -	int ranges_len;
> -	int tuple_len;
> -	struct device_node *mc_node = dev->of_node;
> -
> -	*ranges_start = of_get_property(mc_node, "ranges", &ranges_len);
> -	if (!(*ranges_start) || !ranges_len) {
> -		dev_warn(dev,
> -			 "missing or empty ranges property for device tree node '%pOFn'\n",
> -			 mc_node);
> -		return 0;
> -	}
> -
> -	*paddr_cells = of_n_addr_cells(mc_node);
> -
> -	prop = of_get_property(mc_node, "#address-cells", NULL);
> -	if (prop)
> -		*mc_addr_cells = be32_to_cpup(prop);
> -	else
> -		*mc_addr_cells = *paddr_cells;
> -
> -	prop = of_get_property(mc_node, "#size-cells", NULL);
> -	if (prop)
> -		*mc_size_cells = be32_to_cpup(prop);
> -	else
> -		*mc_size_cells = of_n_size_cells(mc_node);
> -
> -	range_tuple_cell_count = *paddr_cells + *mc_addr_cells +
> -				 *mc_size_cells;
> -
> -	tuple_len = range_tuple_cell_count * sizeof(__be32);
> -	if (ranges_len % tuple_len != 0) {
> -		dev_err(dev, "malformed ranges property '%pOFn'\n", mc_node);
> -		return -EINVAL;
> -	}
> -
> -	return ranges_len / tuple_len;
> -}
> -
>   static int get_mc_addr_translation_ranges(struct device *dev,
>   					  struct fsl_mc_addr_translation_range
>   						**ranges,
>   					  u8 *num_ranges)
>   {
> -	int ret;
> -	int paddr_cells;
> -	int mc_addr_cells;
> -	int mc_size_cells;
> -	int i;
> -	const __be32 *ranges_start;
> -	const __be32 *cell;
> -
> -	ret = parse_mc_ranges(dev,
> -			      &paddr_cells,
> -			      &mc_addr_cells,
> -			      &mc_size_cells,
> -			      &ranges_start);
> -	if (ret < 0)
> -		return ret;
> +	struct fsl_mc_addr_translation_range *r;
> +	struct of_range_parser parser;
> +	struct of_range range;
>   
> -	*num_ranges = ret;
> -	if (!ret) {
> +	of_range_parser_init(&parser, dev->of_node);
> +	*num_ranges = of_range_count(&parser);
> +	if (!*num_ranges) {
>   		/*
>   		 * Missing or empty ranges property ("ranges;") for the
>   		 * 'fsl,qoriq-mc' node. In this case, identity mapping
> @@ -1083,20 +1026,13 @@ static int get_mc_addr_translation_ranges(struct device *dev,
>   	if (!(*ranges))
>   		return -ENOMEM;
>   
> -	cell = ranges_start;
> -	for (i = 0; i < *num_ranges; ++i) {
> -		struct fsl_mc_addr_translation_range *range = &(*ranges)[i];
> -
> -		range->mc_region_type = of_read_number(cell, 1);
> -		range->start_mc_offset = of_read_number(cell + 1,
> -							mc_addr_cells - 1);
> -		cell += mc_addr_cells;
> -		range->start_phys_addr = of_read_number(cell, paddr_cells);
> -		cell += paddr_cells;
> -		range->end_mc_offset = range->start_mc_offset +
> -				     of_read_number(cell, mc_size_cells);
> -
> -		cell += mc_size_cells;
> +	r = *ranges;
> +	for_each_of_range(&parser, &range) {
> +		r->mc_region_type = range.flags;
> +		r->start_mc_offset = range.bus_addr;
> +		r->end_mc_offset = range.bus_addr + range.size;
> +		r->start_phys_addr = range.cpu_addr;
> +		r++;
>   	}
>   
>   	return 0;
