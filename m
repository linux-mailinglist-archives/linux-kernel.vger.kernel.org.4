Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93085671851
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjARJ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjARJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:57:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D16294C9F;
        Wed, 18 Jan 2023 01:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elQ0blM+NNBiu3nRZVy60X6/KNkjZ3tqRhZavQq1ASxZg7lNDl8XD/XTi9L7Leu9MuQE/iVtDh9BkH4ajkFIEsLAG/uTpSEXi7ceBwQ4wl6JejDqDpFBMYx7l3Rk0p7pwjwxm32NA5cCuzXK8z2/XvxFYPrH6+vvAHzKAD1HCbSjrg/F3W4Jan9j/DwlbIjwkJ/fjvoGx1X4eDkt/iuMcSdJr2HIjOro/1S37F742Oj++QfbIm58bNH6mQOS4Kr6NeYJJPuiKMgHzpiksUKxTHauDtsNJIZ9xr5ez6qOlPE+rDKLgHfrShKgJs76OS/PD1NEHX8mIwXChqUueBVn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkH12Vx4Kqg/56Vm3fbAVyAf7QB2hCNN1kH6c1Af0ag=;
 b=TVWZe+jQyU3IzlDArlVYWlp84IoijqQPWKtuEmIpmdyIXVzI4ckb51QcGMU81/EUAey/jvTDvPQavIuyeRXFSvugoCehAIueTYwD59K3ydc8PT9IoSWh1Rt5zWEc8Q80d95rMStCgS3V6r3sYet74vnuT740pSBfYlcnu6E2c2M0a84uwuZaxS6sDxpSDpNi6lgDEqfwbRxnUwbK3l7QN4VjzcVY7MXPcCeWbgVOWa7UV4d6snQuL3XoT6T9NOdqEfab6EOJMLTcMaVeHCGPHIe7+64suscMhoy7jV5y8QfBjhkSYYpcRiweba5TiA9VmDMq2dNfteTL8T5kg0/1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkH12Vx4Kqg/56Vm3fbAVyAf7QB2hCNN1kH6c1Af0ag=;
 b=G1Z0rH4dU2XZruMxPSHMdirLI6kkh6pQ8yz3Q0zqRtE1dHb4PGldA3bUTx/uaKgx0lFUY/80DpY4ADScmJ2sTN2w5Ui10jIrcHO+VW81WLTGQtufvUBYrO25Dt4iOqqpFxYSOcraHxNGDiJFMPYG7Gt/RVYI7tf5QYOL3+5THl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 09:06:53 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 09:06:52 +0000
Message-ID: <94fc297c-2cef-4c37-a623-3996c8dbc48f@amd.com>
Date:   Wed, 18 Jan 2023 14:36:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] HID: amd_sfh: Add support for tablet-mode-switch
 sensor
To:     Jiri Kosina <jikos@kernel.org>, Adrian Freund <adrian@freund.io>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Luke D. Jones" <luke@ljones.dev>, Ivan Dovgal <iv.dovg@gmail.com>
References: <20221218214723.14735-1-adrian@freund.io>
 <nycvar.YFH.7.76.2301180948450.1734@cbobk.fhfr.pm>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <nycvar.YFH.7.76.2301180948450.1734@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5f9053-740e-49f1-0342-08daf933570b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eS4GouZGXwy57zlBPoFUAEjKgBdK9igIJ0jVJJrCjD/zl4em4LDwytC4NSHPOREDaV8E4XIupuLms/g0UpLEU16uVNwWbRXi7nceq5/6S+/vWUpGaZjQbhp0kAT0j6fCoBrGfdhG0/2eOFPcu7rrLtU4Dgwq7QTnO2KkyjSuWmWrCAtyQL7jCQaHsEdRXzeW2TXaSGIA5y9KVAbuXi6yHLM5kVS1yG6p7M/2KdHOamGGNPB8rdNohxV3O2Cvho1OMzaDYcwqaemNw5ZBaKQ2wAh0MM24Dgw3fz/ESlb7NceX3w/vWNxfHdemM4qip//I39q5sidPYO+x+tzVZrSdxneyfCED/jR+RTHXm9+LrDI1OXonPISbHgCgXH1umVcxXviUnPpAbDMw5g5uzvzD4djdh7aJ5z6THJt2D58MDu905hVVb27Edl7KosNZP0Ksi/us3n09dMBlNekpt8ust5qWQNe7vJmUcbm+1xeIihAbEYjFKg2ktIKWK3pixoHgvu+fKxAZhj56DHi9I70sgzawq8nLDxCEQ/9MdVmZPocAlwpwDqjnBfaMnKTfbPIODqq9Ye0AHfU/jEsfv74Iccx39D7qzuFHX2FluSosMCzLqvj0qRIpQSFJwgIB5S+8hVCJTDdaoq7th4RGSxVVJ4gYUKZ1PXiHYs/tS9TCnJGB1RrXXu6l+gSkfUcwJVBt4W3QfnwKqXbLvq8P/LchO2Ds2C+eo1SbBcBPql/300A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(31696002)(36756003)(6512007)(6486002)(478600001)(26005)(8936002)(53546011)(186003)(38100700002)(5660300002)(66476007)(2616005)(66556008)(6506007)(54906003)(8676002)(110136005)(41300700001)(4326008)(2906002)(4744005)(316002)(66946007)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXF1bVRGNXNCNkNObVVwU2N5YjdkZU5TaytSOEtObnAyNm5qdmNLTUNQaWt1?=
 =?utf-8?B?TVJuSVRVSGhtcURzTWJBYVY1YWt4M0MyTzNCZWFkZVg5VFMxYXhlR1FnYmtY?=
 =?utf-8?B?ak9lWkFpQVp4SGp0eER3aitqajcvQUxsb2FpWmVPYzJaTkF0MTQycWFJdjJF?=
 =?utf-8?B?Y3g5ekdNZ3V4TzQ1dWtDSitTV3p5OWFGdGw1cWtNS04ybTFERGVxd0txOU9W?=
 =?utf-8?B?M1VvS2FPUlk2VVVJbEFka0MvVTBDcXdUck0yS2MvRnZSdlNHL2QySTZOb0Vq?=
 =?utf-8?B?Z2V6YnRsM1pJV3dlQ2ZFeFgvdWxnV1RpRWRSS2xFdmZLZVUyRThJQjRkdVNq?=
 =?utf-8?B?bnNjNUtwK0o5ekljTnE0KzFPTHlvUVlaNG56RU9KYUFqRS9XRW9RTW1vOVJj?=
 =?utf-8?B?T1VFaVgxdHdHdlFvUnl1SE9oNlpmczRqUmpXV2FpQ3RzM0FmWjkrUER6bDZN?=
 =?utf-8?B?Ykg0SmM5VUI4N2tZd1krY05wWG1VTEdSK3krbXZUUHNWWlRuTmVVQWNCTEgr?=
 =?utf-8?B?dk8xZnc4NWxCSktmNFlNS0FKRXBNU1QySjZlNWVQdGY5NndKcDY3K0h2TGpD?=
 =?utf-8?B?WWpmY08rczJObTFBbkFwVFRrd3VIQ3pyRzAwSDJIVTlkejBaZ1k4Y3B5ZHBy?=
 =?utf-8?B?VUNnby9lNEluTStIRTVZZVM4b00xYkwrNnZzS3FiRDVoNUFMOGlIOFJocSti?=
 =?utf-8?B?bDZPNDdXU0NGbHZjcnZibi8rajJpTmZGSVRrcXhkMWdaQnZKZktmc1dZbUJM?=
 =?utf-8?B?R05ZeDlTVFFqd3loL3Z2S3liaUh2MVRWTExpTzJvY05rMHYrdGRveVZJL0NF?=
 =?utf-8?B?MTRnNlFCV0M5bklDbVFDZ3ZPdEpIcDJyWHAyTkd0WlRsc29zck1aUE54dlZX?=
 =?utf-8?B?MGpHMUZMU1Y1Ym1ZYkRJcGlwN25XclArM3JySzFIdWpGbGFiVjA5enVsWFNX?=
 =?utf-8?B?M0dPbVhMNlZCUjBsYjZLM0tyVUtpRlZHUVkzVmczS2YxVTZCQWNBemFnUWU2?=
 =?utf-8?B?SmxFaU1SdjBybXFoejlIb3Fuem0rQUoydjJkV0YvUSt4UGRQNkJFV2Q0WkxM?=
 =?utf-8?B?MjRVdnFBYmJRYkhKaHNrcmF0T0NRd0ZhcFRlZ0kxUGovOVJXQW92dFU2S0hj?=
 =?utf-8?B?b3k0aXNUWXY3RjdxOThJS0dCcWIvbUwwWXBHZXNGeHI3ZDUyY2tBTUQ2OS9W?=
 =?utf-8?B?YXdhNjd6S1M2aGdSYXpHVWtsVS9ta214N0FNeExidXlaRlhzWndoMkMrR1RQ?=
 =?utf-8?B?ZkZNTDB4SlZUVTBEYm9yYjFMOU1palFHbERUdEt2MnJxYngvWGdNR09jL1k0?=
 =?utf-8?B?V2pnM3JpM0V1d0hyUEtoN25OMTdWTmRJK3BzdXBXZkt5S1dBdk55WVhObVU1?=
 =?utf-8?B?aTBjYzBlMVk0a0RmVVFhVXVMUDkwbHFrTXJnUStVWUVIR0R6Umc0ck5yc25h?=
 =?utf-8?B?TC9RVXFlQzVlV1hOZGI2WUhIOUlPRy9VWFg3djNmU1ptNkhvQk0xb012WkhQ?=
 =?utf-8?B?MmtxYnkvaExENW9KMjc4S2JMTTN2bFRIY1JzTitnQzc1azdWODkrblVMeFBK?=
 =?utf-8?B?TDJjTkRic0xFdkJFM1JPMnVqYzFXZkh1TU04elRjTmVOYzV6R1NnQmg3VVZX?=
 =?utf-8?B?L2NDZy9mckRhSUFCL3dJbllrQzNESmxoM3RNcmdHOFBTRDZqWE5aM092b09o?=
 =?utf-8?B?WjhaRjZtdWpWYjZ2VXluYTdLaGdGZ1d5UVM2cFVLNVlUT2VGMnR6VVNGZjdP?=
 =?utf-8?B?TDhXL0J2bHd0SElwVDFpVEVzWC9rTTFXZDFWR01QVkxxZm1OcEhiVW52andJ?=
 =?utf-8?B?c2c0SkZKUG9iaWVONXdhUWRGKzljZzA3ZEI3ZlBYNGJ2L2ZudnFRTW45Z2lO?=
 =?utf-8?B?YmVpZ2F0S2lvYWNBa2tQcG96UDBKRjY0MTg0NEZHZ0lHaDVTSWlVNndDdDdY?=
 =?utf-8?B?ajhpelV5VTFQeWRMTEhRcmhmTWVzR2NXL0h0MWdUU2c4YTVxcXIxSHFTdkhw?=
 =?utf-8?B?UWVCVEpSVUt6TkdzZDlaRWNjaFdjT0hGQkwyaE8vNmp5RnlsKzNQLzVRTWxS?=
 =?utf-8?B?c0RRd1BSdC9YeHFVcEZuMCtNaTNINzVoTnMzMlIva3JhYXJwYnh3N3VhV3Uv?=
 =?utf-8?Q?uxsxIug2PFyBJ1za1ZFCVcuy7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5f9053-740e-49f1-0342-08daf933570b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 09:06:52.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aiXNEoALEoQJJtI+NqyimaN57J8S/YluyUIpQP79I4r0DCpFIaTWRL5ofOqI/iI4XHFyxvybNfRhc3umVTMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/2023 2:19 PM, Jiri Kosina wrote:
> On Sun, 18 Dec 2022, Adrian Freund wrote:
>
>> This patch adds support for the tablet mode switch sensors on
>> convertible devices where that sensor is managed by AMD SFH, like the
>> Asus Flow X13 and the Lenovo ThinkPad L13 Yoga Gen2 (AMD).
>>
>> Co-developed-by: Ivan Dovgal <iv.dovg@gmail.com>
>> Signed-off-by: Ivan Dovgal <iv.dovg@gmail.com>
>> Co-developed-by: Luke D. Jones <luke@ljones.dev>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> Signed-off-by: Adrian Freund <adrian@freund.io>

Whole patch does not take any input data validation from any sensors

Please specify what are valid values?

Thanks,
--
Basavaraj 



