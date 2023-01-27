Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33DB67DA92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjA0AR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjA0ARU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:17:20 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5682874A78;
        Thu, 26 Jan 2023 16:16:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0BhkuMUWAk3fZK8pj0t13LQH7rjDjLOJzMj0rWjv3t6vzcz6dhiBlY80DK5vaw4H1VA/ChYNoLXG+JpGx9tvfrFQTINp6sNwpFaQ0q3/1N8kH6KcXZHhSBf/qpPpxJVyQz4SsHIxAqqg+NhDxMjlaol0vsFwW04qNkuCwUQ/kuit4NS5hJ/PDXHdDF0SPsmkvEfP9qD+jdErqf+YLGYcmnDGi5V841V7rUeH1ZIjGR8ScRoLJdmfTPTKP9RuJCYqbLY22KtAksNrYOwvhiSBFd3jo2xuOFF0vOsFL0o7G3dG6aipqs8jBvgiCYMpIC1lBOwsOIVFuwKuIFeIGO2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5ThpTNq3GMqlz3LoIv7+18eDQFVE5BN2QXD8j/BQjw=;
 b=R9VX6F/HTkbyBmbH8W4FBTb0cMYI4qgAEOvePUIeTRihro+MHPM6g5yo5VninhIMWqQaOJcTVcYk1BoQBQlHZiltO8q2LbImw8kD0g/Qs/wyBmD2CcqQQqwZBLZDkK0dCc6IBfBJFk/HCjTdSpG73zTK2VGkcpxsChnJWRcRvsZTp69H91B1PJ65tTE7imH03jrXtJmcX7BS2mAc92PyA/h71y1+UcFLxV7LyGHbDmfzeHynxQdfaJxvQY4SdZr6i8tVx3cGb4pholhf45GtK+CH84vU5rajuFgU5x1PipE+pvH4j3s/xaRXIz2y/fpwnfLINZUSHf4vsfC6fwJ0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5ThpTNq3GMqlz3LoIv7+18eDQFVE5BN2QXD8j/BQjw=;
 b=NH2+7Zfe7KIT4w9e9qdNG94MI3VdhBRUfJjngFP225rnh5GOgMLSm9Mn5vDWFcd87dEC3bORuJquqg+0X77QCeQYid9uN0uNwTrBBIK2NpjbxlfEOPMKF3nm/5wHUrvxN/v97Sy0hxVLTDy8pt26iGfnw+5bnG3ivFhDWMkNjSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AS4PR04MB9410.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 00:16:22 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 00:16:21 +0000
Message-ID: <96c04537-f1a5-6f10-6b35-55d7607619ce@nxp.com>
Date:   Fri, 27 Jan 2023 02:16:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230125110100.14647-1-iuliana.prodan@oss.nxp.com>
 <20230126224905.GA4020499@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230126224905.GA4020499@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AS4PR04MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f227300-9124-49fa-770f-08dafffbb7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeyRYAxfzYQfMhNFiLP0ZJuL7SX7OvWTZdZlkK1qzkMOYWYS7GeHC+R5OT/66SSeGcFMoP7W5Y3GtqUmRmZwZd5bBgwonabjyE15McHwmhHuQxfaN8p2XeLxGAjg+jYmwum1v5tJ7iAcKCFuU6pZ7pb8WUpyxBvCcetwrdcWCqgvTQeQzGiRuS8lnv4D+Pa6u2RVTWhC1FDqsDVvyEbn/pWKNWN4/Tme0VQTz9rRj0S/2rRNYiTqAc4pb3GQGUZIuwsC1r5MTLgRGlvcJWBiw9gn6yK+CvKeRkk0lkrQIPekbQ9lg6CZ1haYDnMMv9jdjeWyUpdsTqe+bb2G7eHjfR2pXBC1/e7boF6/rdE46RQ2nrw2HmY9hSGhFWGK2JtKJk7ivbmE2QPMQrLYdQii1H5LIoH7Sq60fiOXMdjXU3I/mLJZF6/GJf1wUUOfnck1dEMt5JHn2XKRv5/cWNvUGOa5CzaBAXWLpDKk1sHPos7vwSYJbc705INXKMNP5RUhPmkeXS1EjWmXlQZPUyEhx1+R9A0csXrKmJrBdXn9cR4pkbdFo5hAWPIJi3OnRoGr2+CP2LU+hWYHRqwWWV1w3HzssnqartN028YtsAcdGP0JYmqESdk2Vd6TKYZAaDdpSv5HXGUQL38lFs+2UwYOEiMd3Yl4prFxNuBhaVPoJHfcuJGYYAAgGfuOPR8bKLgjQYjvFeyGCSf5iiYPlvuwTAS2w/q4t33jG9SLDkOOJBZLogvF5r9xzAbqknkUCNYnCLUYhS3LdTR8Lu7Re22GRLptWaOKOezeNt9/dSnce4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(8676002)(6506007)(55236004)(54906003)(186003)(53546011)(6666004)(26005)(966005)(83380400001)(316002)(2616005)(6512007)(110136005)(4326008)(6486002)(66946007)(478600001)(45080400002)(31696002)(38100700002)(36756003)(44832011)(66556008)(41300700001)(5660300002)(66476007)(8936002)(2906002)(30864003)(31686004)(86362001)(66899018)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzY4Mi9lR05rK21ZeUJsMm5HWVcrOXhNUzF0T2p4OFJFaHAwZ1lLTXQ4TXRC?=
 =?utf-8?B?bDNidWFqdWVRd2ZCNGlXYm5KRDc1L3pHVllJZ1YrMUw3elMvM09hY2lZbTFR?=
 =?utf-8?B?UFhBdlBoOXBqR0hHV0ZXL0RPckZPT21sMDVoUytoQzNpK3dwWkNsd3pDUHlD?=
 =?utf-8?B?NWF4aWI2amZyMjZJckRlL2hPKzNKRGh2eW0yUjd6MUFtQldIanRZOSsxdVdz?=
 =?utf-8?B?aUtpVGxsUVNjM3AzWHVNeFRvSGc1ak9aV0RNWjBDYXcrYWwvdnpOVWdGUkFR?=
 =?utf-8?B?MStJdmVWSnZ6S1RnZE5FeWhabWtzUjdPWWhQSFJXSlNtUDZuVFZVRklsQ3cw?=
 =?utf-8?B?RllyTmtReUs5MjM5TVBHb21OZ0ZmbGowaS9UKzc1dW15VGJTeWkxNkoweFdE?=
 =?utf-8?B?QlpEc0pyZVFnMjl6L3JLNEhUZndxS2RvRzl0L3IvSGxWTmZ4T2RlemhmQTZq?=
 =?utf-8?B?K2ZjSFRNYm5EbHlEMklpRVV6ckZ1N0hRVU9VRFUwOEIvcy9BOXFKcEtRbTd2?=
 =?utf-8?B?ektBdFBMSGtqVjh0Y0l5SlIzRExJWlRhK1FKU0hVMDN0S2J3MjlQeVN5YSs3?=
 =?utf-8?B?bkhiNGE0eEh4d2FnV0s5OFl2ZWd5V1JKYndiRkVkYWJPYXd2ejFnb0NFT2Fp?=
 =?utf-8?B?cTA3U0M5T05vSFcwRkxZMy9LLzRkUUJKVTZWb25SdWFzZ00zYjVObkQybFRt?=
 =?utf-8?B?SkZVS016azNmdGl4QlphRUY1eFl3NzlNMXpOV1BpdjJUb2N3ZldjSVFkNFd3?=
 =?utf-8?B?OUozSnVXSkdkN1psaStxaWVsR2tocEt3Q3RKSTJ1NTVScFgvTFU0S2ZUdFhM?=
 =?utf-8?B?b2NsWXN3V3dSWXJvb0RVR3FrbHZtSklTT1FBbnk5cHFuc1RvS0JqZnJpVm1j?=
 =?utf-8?B?d3BkdVFvSU9pRDFSUUZ4czJpTS9tdUozKy9XcC9UcVhhWEQ5RExaMGZ4U3Na?=
 =?utf-8?B?Z3lMUnBRNmNqVEg0Szc4Z0pOalZkMlNGL1AvZ3F4UjBJRXBQVjNXUDBxWG1V?=
 =?utf-8?B?S1lRbDVYNStUSUp0VVlndjZNZ0ozNWhTTkVmSnV5a1BUNk5jejExQVpaZm5F?=
 =?utf-8?B?eW1LeWc4UlRSYkhJWi85RUNKYXJ5NEJIMHJwVDNiS2lKMENZTEhQUDFTWUZP?=
 =?utf-8?B?aExubEFnc0w4bERMb292cUEzNGUwUkFNOHFoOC9hSTJ3c0xnU3orOFVVczgr?=
 =?utf-8?B?Q1ZsNkFVS0k4VG85Q3h6TGh1QU5mRDk5WUxQNldVRUgvbE4xbXFobi93VDNX?=
 =?utf-8?B?N2hrZTNqYmxxSnFDRXJEUVNvYng3WVE3dEFpVHFSTjNzazJvTWgvLzVNeFZs?=
 =?utf-8?B?RGFENDBITmNsTTM3eE1Ia09HUmQwTE5rT2V3SHJUbFR6Yk5ZUVV1cDJ4QXE0?=
 =?utf-8?B?cm1zNWJnaGREMFArZGtYQ3VvMGpjS1lqcThNZW5UQVpYWkxxcE82SEFQKysr?=
 =?utf-8?B?MmZ4amxUQ0ZLcE5nQ20rMmxqUHU2QkFKaW9qeVExWHl2VmVNTEZqZWNGemJJ?=
 =?utf-8?B?RmUwY0tXRzNSdE9Wb1R1dnBBV2pQOWIyTWxJTWltQU1iQnlhM0JCYVloTkpQ?=
 =?utf-8?B?OVpBQnVydEMybU9aRVRxajlkdjVrYUs2YmNycklid2JVZjZoQjF2THp2Lzhn?=
 =?utf-8?B?Y0xrbWxxQ25ZMjZGUHhnempvSUtMOFJjWm9ObjVRZUVRQTJ5ZHFxWlo5ZHFp?=
 =?utf-8?B?aURHaVdJYzZTajZkc3p0dTFKdUIrS01VZ3ZGalJhZEFkbDJJT1Zud1FKbEl0?=
 =?utf-8?B?dittWk9MR3U0QjV1a0NlaTdGTmtCdEFjdWhNdHVJY1kzQlIwSWdSQzZCS3pD?=
 =?utf-8?B?SFY1WmZqeHM0RjBjY0JPbE02ZE1kTHVqbWIwUzJTSXdHeW9zeDAxMWlvQzZT?=
 =?utf-8?B?b2h4SE1rUk10dDNTTGpLQ3pVdGpYeEFNRDQ5c3RnUTFZb1dSc1FPekRzWDV3?=
 =?utf-8?B?b0tXckFhSnMvTzN4T0k4UW1YVGRRRTR2Ti9HOVFnSU4rWElTdFpoVTJOSllU?=
 =?utf-8?B?V0J6MGw4YlBqb01MNk16T2JWNjFUYzF3VUhoNU1vcy9uZmtOTjRWNElJQXAv?=
 =?utf-8?B?aVRRUThMZVZUcVY1c3VZNVNPUGMwN29pck9Wb3p1WDVRalVvb2xGdGJTaVhp?=
 =?utf-8?B?QzJWZDlkWnpNRjVCcDg1YkVRZzlFNk1xbWZLV2JiN3czQ1FucUpONUttRFdI?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f227300-9124-49fa-770f-08dafffbb7fe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 00:16:21.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKlnemy+NmxHNJ9Lr50NYAayHDRDZARjxKwjQ3eRC7hZS1BJcVsYkrRpTUY254l1tnWHYS+z8YN0ryd/Wl6KgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9410
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 1/27/2023 12:49 AM, Mathieu Poirier wrote:
> On Wed, Jan 25, 2023 at 01:01:00PM +0200, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> The IRAM is part of the HiFi DSP.
>> According to hardware specification only 32-bits write are allowed
>> otherwise we get a Kernel panic.
>>
>> Therefore add a custom memory copy function to deal with the
>> above restriction.
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> ---
>>   drivers/remoteproc/imx_dsp_rproc.c | 122 ++++++++++++++++++++++++++++-
>>   1 file changed, 121 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>> index 95da1cbefacf..a9991d085494 100644
>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>> @@ -715,6 +715,126 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
>>   		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
>>   }
>>   
>> +/*
>> + * Custom memory copy implementation for i.MX DSP Cores
>> + *
>> + * The IRAM is part of the HiFi DSP.
>> + * According to hw specs only 32-bits writes are allowed.
>> + */
>> +static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
>> +{
>> +	const u8 *src_byte = src;
>> +	u32 affected_mask;
>> +	u32 tmp;
>> +	int q, r;
>> +
>> +	q = size / 4;
>> +	r = size % 4;
>> +
>> +	/* __iowrite32_copy use 32bit size values so divide by 4 */
>> +	__iowrite32_copy(dest, src, q);
> The current driver for imx_dsp_rproc does not provide a rproc_da_to_va()
> operation, meaning that @is_iomem in rproc_elf_load_segments() can't be true,
> forcing a memcpy() operation to be used.  And yet above an _iowrite32_copy() is
> used...

Yes, with rproc_elf_load_segments() we go through memcpy() because 
io_mem is always false (I already have a patch to get rid of this flag 
from imx_dsp_rproc since is not used), but memcpy() vs 
__iowrite32_copy() is crashing on sizes that are not multiple of 32bit.

That's why I added the __iowrite32_copy() and above this, I'm dividing 
the size by 4.

Also,  in imx_dsp_rproc, we shouldn't use memcpy, it should be 
memcpy_toio because all addresses are ioremap - see 
https://elixir.bootlin.com/linux/v6.2-rc5/source/drivers/remoteproc/imx_dsp_rproc.c#L601

> In the conversation that came out of[1], Daniel Baluta mentions that
> read/writes should be done in multiples of 32/64 bit but here a blanket 32 bit
> enforcement is done.

I've checked deeper the documentation and talked to our hardware team, 
and for NXP's DSPs we have a write restriction of 32bit.

>> +
>> +	if (r) {
>> +		affected_mask = (1 << (8 * r)) - 1;
>> +
>> +		/* first read the 32bit data of dest, then change affected
>> +		 * bytes, and write back to dest.
>> +		 * For unaffected bytes, it should not be changed
>> +		 */
>> +		tmp = ioread32(dest + q * 4);
>> +		tmp &= ~affected_mask;
>> +
>> +		tmp |= *(u32 *)(src_byte + q * 4) & affected_mask;
>> +		iowrite32(tmp, dest + q * 4);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
>> + * @rproc: remote processor which will be booted using these fw segments
>> + * @fw: the ELF firmware image
>> + *
>> + * This function loads the firmware segments to memory, where the remote
>> + * processor expects them.
>> + *
>> + * Return: 0 on success and an appropriate error code otherwise
>> + */
>> +static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	struct device *dev = &rproc->dev;
>> +	const void *ehdr, *phdr;
>> +	int i, ret = 0;
>> +	u16 phnum;
>> +	const u8 *elf_data = fw->data;
>> +	u8 class = fw_elf_get_class(fw);
>> +	u32 elf_phdr_get_size = elf_size_of_phdr(class);
>> +
>> +	ehdr = elf_data;
>> +	phnum = elf_hdr_get_e_phnum(class, ehdr);
>> +	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
>> +
>> +	/* go through the available ELF segments */
>> +	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
>> +		u64 da = elf_phdr_get_p_paddr(class, phdr);
>> +		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
>> +		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
>> +		u64 offset = elf_phdr_get_p_offset(class, phdr);
>> +		u32 type = elf_phdr_get_p_type(class, phdr);
>> +		bool is_iomem = false;
>> +		void *ptr;
>> +
>> +		if (type != PT_LOAD || !memsz)
>> +			continue;
>> +
>> +		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
>> +			type, da, memsz, filesz);
>> +
>> +		if (filesz > memsz) {
>> +			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
>> +				filesz, memsz);
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		if (offset + filesz > fw->size) {
>> +			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
>> +				offset + filesz, fw->size);
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		if (!rproc_u64_fit_in_size_t(memsz)) {
>> +			dev_err(dev, "size (%llx) does not fit in size_t type\n",
>> +				memsz);
>> +			ret = -EOVERFLOW;
>> +			break;
>> +		}
>> +
>> +		/* grab the kernel address for this device address */
>> +		ptr = rproc_da_to_va(rproc, da, memsz, &is_iomem);
>> +		if (!ptr) {
>> +			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
>> +				memsz);
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		/* put the segment where the remote processor expects it */
>> +		if (filesz) {
>> +			ret = imx_dsp_rproc_memcpy(ptr, elf_data + offset, filesz);
>> +			if (ret) {
>> +				dev_err(dev, "memory copy failed for da 0x%llx memsz 0x%llx\n",
>> +					da, memsz);
>> +				break;
>> +			}
>> +		}
> This patchset from last year[1] goes to great length to avoid using a driver
> specific function and now you are trying to bring that back...  So how was it
> working before and why are things broken now?

Until now, it was used in a limited scenario and the firmware was 
correctly built to respect the write restriction - having the IRAM 
sections size a multiple of 4bytes.

Now, I was trying a simple hello_world sample from Zephyr, complied with 
gcc and I crashed the Kernel trying to load it on the hifi4 DSP:

[ 2707.135094] SError Interrupt on CPU0, code 0x00000000bf000002 -- SError
[ 2707.135104] CPU: 0 PID: 665 Comm: sh Tainted: G C         
6.1.0-rc6-04789-gc80e5155d190 #135
[ 2707.135112] Hardware name: Freescale i.MX8QM MEK (DT)
[ 2707.135115] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[ 2707.135123] pc : vprintk_store+0x3c0/0x460
[ 2707.135141] lr : vprintk_store+0x48/0x460
[ 2707.135149] sp : ffff80000b31b8c0
[ 2707.135152] x29: ffff80000b31b8c0 x28: 0000000000000018 x27: 
0000000000000000
[ 2707.135164] x26: 00000000596f8000 x25: ffff000810c15038 x24: 
0000000000000000
[ 2707.135173] x23: ffff8000098dfaf8 x22: 0000000000000000 x21: 
0000000000000000
[ 2707.135181] x20: ffff80000b31ba30 x19: ffff800009abca31 x18: 
ffffffffffffffff
[ 2707.135190] x17: 6620313231783020 x16: 7a736d656d203030 x15: 
ffff80008b31b867
[ 2707.135199] x14: 0000000000000000 x13: ffff800009d22428 x12: 
000000000000083a
[ 2707.135208] x11: 00000000000002be x10: 0000000000000a40 x9 : 
ffff80000b31bb70
[ 2707.135216] x8 : ffff80000b31bb70 x7 : 00000000ffffffc8 x6 : 
ffff80000b31bb30
[ 2707.135224] x5 : ffff00081a098000 x4 : ffff80000b31ba30 x3 : 
ffff8000098dfaf8
[ 2707.135233] x2 : ffff80000990c000 x1 : 0000000000000000 x0 : 
ffff8008eface000
[ 2707.135243] Kernel panic - not syncing: Asynchronous SError Interrupt
[ 2707.135248] CPU: 0 PID: 665 Comm: sh Tainted: G C         
6.1.0-rc6-04789-gc80e5155d190 #135
[ 2707.135254] Hardware name: Freescale i.MX8QM MEK (DT)
[ 2707.135258] Call trace:
[ 2707.135261]  dump_backtrace.part.0+0xdc/0xf0
[ 2707.135275]  show_stack+0x18/0x40
[ 2707.135284]  dump_stack_lvl+0x68/0x84
[ 2707.135295]  dump_stack+0x18/0x34
[ 2707.135302]  panic+0x184/0x344
[ 2707.135311]  nmi_panic+0xac/0xb0
[ 2707.135319]  arm64_serror_panic+0x6c/0x7c
[ 2707.135324]  do_serror+0x58/0x5c
[ 2707.135329]  el1h_64_error_handler+0x30/0x4c
[ 2707.135339]  el1h_64_error+0x64/0x68
[ 2707.135344]  vprintk_store+0x3c0/0x460
[ 2707.135353]  vprintk_emit+0x104/0x294
[ 2707.135360]  vprintk_default+0x38/0x4c
[ 2707.135369]  vprintk+0xc0/0xe4
[ 2707.135376]  _printk+0x5c/0x84
[ 2707.135383]  rproc_elf_load_segments+0x228/0x308
[ 2707.135391]  rproc_start+0x50/0x1c8
[ 2707.135398]  rproc_boot+0x494/0x574
[ 2707.135404]  state_store+0x44/0x110
[ 2707.135413]  dev_attr_store+0x18/0x30
[ 2707.135422]  sysfs_kf_write+0x44/0x54
[ 2707.135433]  kernfs_fop_write_iter+0x118/0x1b0
[ 2707.135441]  vfs_write+0x220/0x2b0
[ 2707.135449]  ksys_write+0x68/0xf4
[ 2707.135455]  __arm64_sys_write+0x1c/0x2c
[ 2707.135461]  invoke_syscall+0x48/0x114
[ 2707.135470]  el0_svc_common.constprop.0+0xd4/0xfc
[ 2707.135477]  do_el0_svc+0x30/0xd0
[ 2707.135484]  el0_svc+0x2c/0x84
[ 2707.135492]  el0t_64_sync_handler+0xbc/0x140
[ 2707.135501]  el0t_64_sync+0x18c/0x190
[ 2707.135510] SMP: stopping secondary CPUs
[ 2707.135520] Kernel Offset: disabled
[ 2707.135522] CPU features: 0x20000,2082c084,0000421b
[ 2707.135527] Memory Limit: none
[ 2707.397688] ---[ end Kernel panic - not syncing: Asynchronous SError 
Interrupt ]---

>   Moreover, function
> rproc_elf_load_segments() deals with situations where the memory slot is bigger
> than the file size[2], which is omitted here.

I'll add this part in v2.

Thanks,

Iulia

> Thanks,
> Mathieu
>
> [1]. https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-arm-kernel%2F20220323064944.1351923-1-peng.fan%40oss.nxp.com%2F&data=05%7C01%7Ciuliana.prodan%40nxp.com%7Cd946b7c87aaf4016c69908daffef8a64%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638103701532520716%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=GNJhJnoiRWfAzvseUsAdwHRtY2w2mA816CKkTL%2F2czw%3D&reserved=0
> [2]. https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.2-rc5%2Fsource%2Fdrivers%2Fremoteproc%2Fremoteproc_elf_loader.c%23L221&data=05%7C01%7Ciuliana.prodan%40nxp.com%7Cd946b7c87aaf4016c69908daffef8a64%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638103701532520716%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=5P5FcuMb6H%2B5S4L2Il4BBAxOOIrr6Er5thNvhADhKdc%3D&reserved=0
>
