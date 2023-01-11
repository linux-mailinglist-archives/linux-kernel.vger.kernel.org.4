Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959B2665D46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjAKOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjAKOGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:06:03 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122481868F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:06:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYMefet5K1vRUiGOFOMKwVFKaDkJ4+Rm+UMzkofo3KUBA9ghMWs88/pMGC6ZR9OICtRNZlvPVs9Kp3wrPwgmdTEeTKC68Y7Nlh38AeA70DutcOeIT/m24hp/ft9xN1T7Yn03Bss0HRrzFxeJ1se0XlyrlW99I9JabXynTAxsh6MNWP8w2nzIF+jko8cUmRTh11nq7MdOipDnvQKHNcskORxEBaeoaPjFawWz43CLtfarlgPBkqKSiN7NboNzHT+afmTmPey0ALmJQJueBCLFsJpz8mITQKwOT2m6XS/t5ePioZuxD/xwRfDNX2ROM3NWIyh8v/eY3d0l/5bw+xAq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3UtqeVL92WzzGR6C46DSCZs6jchiRzzc2SbM4bAX50=;
 b=F/QERlLTl4ki9MZGpKndzDTOaGbBc6wPwvCdyljzHh9NECvX9g5siFn/ZagZchkgB2RevROP2KhFDN9j2h4VJny3PAJbSjJduPcW5edvjuVYwT3EUiYndu8fXJMkIcUlSodPFYzYVVJGpt+fyI+ikx1zG+0NhZnkthEA2swv22ZPtdcF6SsJRbGw6szjpt+bjz0AGG7lBh06aryE8nXmgyKTlk/OV3BY+i3OM5Q4z7Zdo6y/k6BtpID9vAk+AxjR9jlFuyse50h0Q9RzBxQmvoPyijpRGie4/+6nvWtXFih7OM6gDc1puKTNFLUV3t+RUWHNw6USmHwQp18hFGb5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3UtqeVL92WzzGR6C46DSCZs6jchiRzzc2SbM4bAX50=;
 b=EZXVjXkj5QPd7pBH/BQTKUHsbpgOuMmULfro6HY9ChIFbDxoI4AmoVK1+Bq1mz3Cb94QscY3LCw+uBxM1zS1vXSQJsjgBmaXfmdglityA8nxZvkvrqhbIAZCcuK2i8+2JInY4S7xdMMaXfdGnRE0zeBsXQPuQ+wKtmrkDYK4H8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 14:05:57 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 14:05:57 +0000
Message-ID: <68ab36c0-5514-667f-1ffe-378206aeafff@amd.com>
Date:   Wed, 11 Jan 2023 19:38:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 08/19] ASoC: amd: ps: add soundwire dma driver dma ops
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     vkoul@kernel.org, alsa-devel@alsa-project.org,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-9-Vijendar.Mukunda@amd.com>
 <Y76z7uYb2/2BUSfl@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <Y76z7uYb2/2BUSfl@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: db4dce54-25c9-4152-f36a-08daf3dcf5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlLM4SI/isESv1kELm7vHxAu0nrnhpG/VYz+tnMa5St/rXQMsUofnTXcSmOWcUvghp2Kb813Bq/EU2+SaX+VkGT+Vl/bhAJwqFM9CeNGMkkkRyJjhq9TmVX90UNnJOaV+z1wWv3mfRGo53KkDXNR7j0ZJxa7k1X/gUcM9L8iSThLdBi9ddfk8F+N5q7wQRvTrjXKkK8POR4tocNZu5744rCTlKkw4eObxR4Kva95O9xi6d7Szm2G8/LCyAfj41/SAjqSfmG+FGZFgDNg7AdWpWQhYD4sOwYl8oiE7aaRIDoCSksA+nCBkzMcSbnMvpOgHlJB+ndsF9gX8fOY/3W7TQks5Z0We67G53cQhJlA7mkHdJL/YJL3GfK5QsvYp+udSykuYtVA9klkEwdR4dzf1SrtIJhfpXF4huTtJJLkrSHI81vH+HSHkV4OXKI1rO/kKpHmUXoR/4W1RTeGVg0fNdFuX17jT3NMU7xlPleoXpmj3HfCeaRD48rvrRDecry7Y3wKerAkU45Kt1XyRHAJ7h/U6JXeBHVV8EZCkkxGm/g3LH2ZzoapKG7tjNwr3SB40lIn1cjtf8crOtXljsudjjSCGTnsAEtFS/ileMOrPWCDNj7yL7BilHAQtHqVcEqSjApZ2VnOf0M8QyrB+PEB+YmmDfPPX+hGembiC9A5Niw34e2pRvNcR5ursJegAZwqKnCpm1EGvpp4Qrh+VgqU/uvspzySBaqFpKiLA/bfhx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(8936002)(2906002)(5660300002)(41300700001)(316002)(4326008)(66556008)(8676002)(6916009)(66476007)(66946007)(54906003)(26005)(6512007)(38100700002)(2616005)(31686004)(86362001)(186003)(31696002)(83380400001)(53546011)(36756003)(6506007)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FWQVI4U3YvMWw0VEFTdncwb0ZjRzdtSnQzcVhtSko1ZG5GOFhvSkpoOEFL?=
 =?utf-8?B?dDBiazBBRlppTjYzZDBxZDFMT2NjQTRXWFRVdEtQcHdNSXM1WDNzYS9rS3Fl?=
 =?utf-8?B?OEdCWmhQYnhlak9zeHFGM2dxODdmdXhNbmxZeDJ6cU5DZ0JUNWh0Vkx3cnJF?=
 =?utf-8?B?VmxHYWZHQkM3YzZIUDdQUXZyZ2srRXR4bm5FWDl2cXRZRmhXdGQ2Rll5Kyth?=
 =?utf-8?B?S2FvV0JHR011aUpxS3dJSEpjcDRDcmlrdGFvVmZyQzFLWmNhNnhITWg5OEhy?=
 =?utf-8?B?RWE0dE5mZ3gxZ1IvTFBKWkcvMmtVZmphdkRQOXpMdnJCYWhnaVNwaWJQc2Iz?=
 =?utf-8?B?OUU1d2lWRzdkRmwzS1V3bXlhUUdwVUxtcld1OXRrNUxVTlkxMEp6MjhuYVpJ?=
 =?utf-8?B?OHV0NXZFdHZtTDhFQ3ZPWkY4Z0dyNnUxTG8wVzg2OEQrY0pqMmZueXk0Z1M0?=
 =?utf-8?B?TGxkVzdHMkxDSGJ5R1hxcmNrS0JqRStsa0xreEhFRHRKWHBDVUhWZGJCazJF?=
 =?utf-8?B?bHQvanB0UWJHNkZXMll0aDRQWHBiMXRCOUJuM1YvT05HY3pIWEV3eXR3c3lE?=
 =?utf-8?B?NmhRUEE1YVFKclRmYUJoajVmZmtjOGswTDU4QjFoYm04czh6VE0yVlhyYitt?=
 =?utf-8?B?eXI1MWRScHltb0U2S1RBQ0xBcTl6OWdlQ3lqYVNMMDRYc3Y3VWQzdENlOUl3?=
 =?utf-8?B?alo3MDFBajd0OTByM213QkdyL2tjOTBNMEN6Z05DdkYzdWZTRlRhTHZrU3Aw?=
 =?utf-8?B?ejRjQ0wwcFplUTNqK21VL3QweHU2VC82N3RKWHU3RFRrTHlpc09HY0NUUTU0?=
 =?utf-8?B?eTJsZXNxNi9hek9zR2dHSk13Mnc0OXZWVG03UU1sbERuNGFxUGt1eDE5TmxQ?=
 =?utf-8?B?ajN5dWZvQkFPaExJODl5OWZFRTFhWGNhWXJtZ1o3ZmZYSFhUNmFTeVNWN0Y0?=
 =?utf-8?B?LzdSaStSQkxodVB4NU1FZmh5QStHdktubFJrZENkUFVXU2pBWDBEOEtKdXJZ?=
 =?utf-8?B?bHdXczc4RzFZK1N6QWVpQnM1MG9Cdk5XL05NS0J2QXBDQUx3bk02bnlHeWRI?=
 =?utf-8?B?NkhEU0g1ZGpMV1FuM2VtQVRwUzdySnRaZS9XTjJIRXNLUFpUUzhqQ2lYUU0x?=
 =?utf-8?B?Mm85UDZLcmlvWUNDS2pVRmFodEVDTHRIQ1B6SmM5c0VkZi9La0xPWlZ5cHJN?=
 =?utf-8?B?RHFKdTd5L0U1NkpWMkxtWDNDaWtJL0dHVS9nOVZ2QldQWWduR1A3U1U4N0M2?=
 =?utf-8?B?d0R5Y05MMjVwVXBqclpHalpvaENkeTRGYjNkd1Y3bGdjRVlUa1F6VWFLZ3hH?=
 =?utf-8?B?SzNIREUxNW1jMy95WXJ0UE12ekNMR1M4Y0d2Zm1zWVNOeHJFUXRMbDFCclJj?=
 =?utf-8?B?TkM5WTdVWlY2ZWFKQ1htTENFeDRnSE9ELzFVek5RZGNscFNlWjRMeDZZdXdH?=
 =?utf-8?B?d0wxNW5IVy9wNGVSTm03bi91QmxJdDZLeE5Ea2haZ3FubThVeXRMblV4MVFO?=
 =?utf-8?B?SllRS3psSGU0NC9pUERhTTNjVjVsYUFkaDlscWxpaldITDlLR2ZhUDdUOVFa?=
 =?utf-8?B?MjBUV05LUU9kVFZRR0Rqc0F1SHpneFgyQTVRVFBPVG5rSzZpRFNIbytzeWZG?=
 =?utf-8?B?dlROUjBwUEtUcUZEb2NCUkNvdGdIcGRoT05jeURGTlJsbzF3ekFiWEk2UGhh?=
 =?utf-8?B?ZnRadDQvQ2lCUFFhSTRGVURWc1RKdTBlTUk5YnozS3VXTCtiTUJ3N1RuNDM1?=
 =?utf-8?B?TWpIenJLeFpaOW5VL1E2Rk5Yd2tFM3YzRHV1aHc4Slkrb3M2cURUTklnMWVR?=
 =?utf-8?B?Q1dxK1RvTlQyZ3VPU0xDSTBCVXp4VHI0OVJ0UzEySmpVbDB2ZmdNWGZQQmQw?=
 =?utf-8?B?cVg1N1ZGWlVnYWczU0J5eDRqdEgvUWhHRGU0dFd5RVRseXJhYWNzZzFnZWpO?=
 =?utf-8?B?Nnc3MDNlNFpFbWlXeUNhUVJ5c1R2dzdOa2tkeVgzUCtDNUNkb0VCa0VzRVFW?=
 =?utf-8?B?eC9NMUpVZHJIZmc4S3Y2am9NeUxWajBKYkxqdkpxaGZ1U2dJQm5sV09hWDlK?=
 =?utf-8?B?eE5obzdkZ2l2cWViRlREMVVBaVNiakJqLytuSjZnb3IwUDlFcmpSTEIzVkdw?=
 =?utf-8?Q?daP7niRbr573GNnK9Va1qrmyZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4dce54-25c9-4152-f36a-08daf3dcf5f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:05:57.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBw3h3atB1YIUbna/At5xgYxNnirH0o5X+Xtp+JzRiZjlkTRGKHC33S5ut6CPJ8i546uwH1Er7FIEjMm0eSLRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 18:34, Mark Brown wrote:
> On Wed, Jan 11, 2023 at 02:32:11PM +0530, Vijendar Mukunda wrote:
>
>> +static int acp63_sdw_dma_start(struct snd_pcm_substream *stream)
>> +{
>> +	struct sdw_stream_instance *sdw_ins;
>> +	struct snd_soc_pcm_runtime *prtd;
>> +	u32 stream_id;
>> +	u32 sdw_dma_reg;
>> +	u32 sdw_dma_en_stat_reg;
>> +	u32 sdw_dma_stat;
>> +	u32 val;
>> +	int timeout = 0;
>> +
>> +	sdw_ins = stream->runtime->private_data;
>> +	prtd = stream->private_data;
>> +	stream_id = sdw_ins->stream_id;
>> +	switch (stream_id) {
>> +	case ACP_SDW_AUDIO_TX:
>> +		sdw_dma_reg = ACP_SW_AUDIO_TX_EN;
>> +		sdw_dma_en_stat_reg = ACP_SW_AUDIO_TX_EN_STATUS;
>> +		break;
> Not super urgent but if you're respinning then it looks like the
> register selection here is the same in _dma_stop() so they could be
> shared.  Indeed it generally feels like it might be nicer to have a
> table of structs listing the registers needed per stream so all these
> switch statements can be more like
>
> 	sdw_dma_reg = stream_registers[sdw_ins->stream_id];
>
> That'd make each function smaller and I'd expect it'd be a bit easier to
> add new streams for new hardware that way.
will fix it in next version.
