Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF5628ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiKNUxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiKNUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:53:27 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82925BC2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0lg4bzAwJ+/kc4ZeV+0RWPhhgzJYS5RC8XjgKVMh7iobfkyura9vbktgXrUDU0OAfA4/zMUPefQgEu8HFnsLoj5Wtc/t15orV55cxsHpl/TqQeenEDZp1i3EBN3CovN6/txDtn5TBMlYd3V/cSXZ4akypkSh5riCmF5sfokoTduQn9Ty9LB8vjLquQrIMbWJEsE2n3x4UYENqz20U2IAMLvm0lm7rJZu/B1HI+P7VOCddax+/tsNio9Hn8ZZj93tKIp/RM79URRTlh7+AhEH2v80D7rIgRegxw8yN5+YjGUMyQo6AjkHAJD0LT9YEXfgz6LHG4Oo1LCxkb/yJsctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5RpbLrOzvZtiml75TaTVXu45Ih1tK01IglU1GcoTwc=;
 b=Ck+s3HgaEYqQ/CTO1GTZXtOB7mZ+MsL2ubso3NnLfHDewZFwIDoWupEg14n8lb0NA81pC3m/QZyvSN3xRgecAFSQSkSiWBX76OTdpAmjy5VkZzc0uFaIpkWVaqyM8paZLF8msrZlfPUkoHuAfw5k22ZydSnAehtAL0J6S+6FRq65YJz5VSq18vYZ+0id1P9/2h3lDjL7FirTQysWZN3xTKj+dACGc9l7QW4VQgl02z6KdBiK3t+HrLL15jU1GjIfWkiF60/SYgCLSgnIoaYam/VIDjcBOc1PZPg+7VeL0yGPgq45WQaHJh1LOQOOssu0tiNg0no9U78VJfTA12iMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5RpbLrOzvZtiml75TaTVXu45Ih1tK01IglU1GcoTwc=;
 b=ZdD4HwqzEVGFeafsNDr0K/JmvMOMXQVpUS15ovU1HDBrHnxISjyI72gLlq56BeMVf0ahv2UhJ3RjjMVttmtTxvKQ2MVvQywNaTRHDfGGXagaezwwCSyWjps1p+GbKRrehTyQGwJzkUNctO5OgtjTxdCYrwBaPp/GpeqLIIVG8E8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 20:53:23 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 20:53:23 +0000
Message-ID: <afca8806-da7a-4a7b-30a2-3de2c4faa256@amd.com>
Date:   Mon, 14 Nov 2022 14:53:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 1/4] crypto: ccp - Name -1 return value as
 SEV_RET_NO_FW_CALL
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-2-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221104230040.2346862-2-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:610:cd::16) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL0PR12MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 012d7e16-d138-4395-1989-08dac68244d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOhW4Oq+NWMhyFYx6dJcjz4UQxEqWVpuqSGaXCqCog6nLbYe3lHTCiW0eet+sjun4095OADWkQW/oq7joHKs2IIjvw3RcLTorakEZ+k9rfj8smSxe03xTUKBw0VrUAWcClDK+rOMVfG+vjRu/2m9M9Ba4aJEQ+xm8xKXDCREBfWRvsUNrrZVT1FYjrZx8YsKFiyIaOW1usNYqi/CPvNOX8LIPreC7vjI0/g67v4Bw0Gf6s3L9CAXa7DJiVwKFvM7WJFMXwYrlR3Xg4YQy1KrHM8baL7I2cukUITn4kIXNRX28czkAPSu3Wi6wr1CXxfSdvKfKt4Q6wzpV9oeyqn32RniZ0AulwQ7sAocDH41mWEl3WpLrQ8uzfirInWocjq8Yvb75csA2ifvmo0bccDEUCb0IjsOUHktyvxr94IwMe/u1DshO4fxxGIye+0UcvkqP4rlRUnB7GyIx5QpY/+WJ3MWkNFxHJ2PelHLXs9GjxRXljey7PVtbEOC6au+3lxRZDu353Qp4GjcO8QkFFUiwkAQ1bc2odxCURjEN7YZXbHsw9oFn/0999Rt93EFFADwtX3u6xjTENGZAh8nMjJ0vhuRKPCXOo7pPgNhpnzUj00dYl7qNsoU2llR/mqdWiemfCgnzgjPmpgt3UdpWihRoGTNKJsF38c24EK4hzAuFxyOz8//FqqVTuYlRCb0YRamkcrkAV9A7htR7Nsv4HJbQa8VqcFoblSkn7eYqgPfLn0AzT1ZuK0irdYdYUAdXmQlzcIrLJ/q3NFS4BJrWxZRtABPXIGJ2tRrSsB8++ux8/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(2906002)(8676002)(36756003)(66556008)(66946007)(86362001)(316002)(54906003)(83380400001)(478600001)(6486002)(5660300002)(8936002)(7416002)(38100700002)(41300700001)(6512007)(53546011)(2616005)(186003)(31686004)(26005)(6506007)(4326008)(66476007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pySnhtUVBmRHRIK1ZLWk8xV0VsaFZWeEM2MmQ1Y2NwSXlyUG9obUpsaTRH?=
 =?utf-8?B?T3VUNW9XU0RNUVlrQ3hYdTBxOWFmMHVpZXp3MktLaTJvcHVUMkVWektxSWtr?=
 =?utf-8?B?WVp3dXVKM1FhbWdmWTdjSUFEbnNVWENqbzlYVE12dlZ3QTFiS2VnbS95SURN?=
 =?utf-8?B?WVhJRndmbE5SV1RLZG14V2FxSlkvUkFoYnlsNzNHMUNFcWhEVkdZMVJrMmIr?=
 =?utf-8?B?WEJmZTFtUHBwTUQ2MStOdE9wdGRrOUxwUWE3WmsxQmwxSk9YY2Z5L2JWRG80?=
 =?utf-8?B?dWhvdW5hNUg4VEhsQ1pOZzUrZFhVUXNWTVordnFQQitaMWZJT1FQT2MyMHJw?=
 =?utf-8?B?MlN6VUNKSzk4djlqL2hqQlZJdEYvd2V5Q1dlMnpLeG9KOTVseUFsSmRWMVFD?=
 =?utf-8?B?NlNJT01hWm9KRlRtKzZlSzlobityNS90NmxuRjBYZ2xiV3VVcEVuREJBMU8x?=
 =?utf-8?B?MUNZZVdwVVpTVDYwazFUa0UyMnN0clA1ZjhmS0x5R3BvV25jTHkybEhKQXQx?=
 =?utf-8?B?ZG5FWC9UYjdseEZYYVRRcERsZFNSL0t4RU5OY0xpSFcyaHUwSkhKYkZQRURF?=
 =?utf-8?B?cnJrSjIrUG9zQ2gvMjFKRVRRSnoreHE4b3JkUVRVMGVWWFBKVjF2d3pWQXdv?=
 =?utf-8?B?Sm52NXFvYUVNcmxVdjBCZ2RhQTIzbTlwVGQ5UDZxV0dqYzBZaU5uKzNVbjAz?=
 =?utf-8?B?R0JscnpaV1MrOHJmME5wb1Q5UmVmV3UrVUx2SmVlZHNjME5RS1QxdkxyQisz?=
 =?utf-8?B?eWl6ZEZ0Vm5pTjZyUVFsZ3hZdmhNZUFLc2p0M2F1dCtNME9LRTVvZldKeXVL?=
 =?utf-8?B?UUVKb21OcFFmMkNLZ1BkNzd3SExVQlVPM0d0VmpzcEdHUGVMc1FZdml4R2JC?=
 =?utf-8?B?OTFydUpRaGJEMGcvSzd2b2t1cUdMTi9XR3p5SnFDNVFNQzZwTkZPRDB6Uzdl?=
 =?utf-8?B?Q1k1WGcvWFZkTHZwcHNVdmZiSFFTak14OEhsaXFuS3Jqc29BRUVNZDBtdlpF?=
 =?utf-8?B?dmNscEtmZXRLZkh3S1dUSHQzbWlWakZGUnVWYkQxYktNRGk2ZzJtRlZCVjhJ?=
 =?utf-8?B?QStqTTlFMEdQV1J2WW1ZSkM3Rk1HUzRycktkbW04YWtEQmlqbkxwcHM5K0RZ?=
 =?utf-8?B?cHVmSzEvWXpYM0VTM1Fxc3lBK0EvUEpuT1BRWXlWdnRpa3kxUFVLWDY0OG5K?=
 =?utf-8?B?cVdNc1ZFUkovVGRhbjVqeWQ2Rk56NmY0d2UreDJnd2hvV2VtYjZJZlBURTVF?=
 =?utf-8?B?Vmg5MmZNT1dDZFpBTzFqRmdnazkrSkFURnNrSk1pdFhqczduMFNWWUozNURs?=
 =?utf-8?B?dyt2T0g0RkpvaXNmblFqaFBUUC9OUlVtbUk5SEVPZzNFaXEyZlRSbGpwZjBJ?=
 =?utf-8?B?MkFZRU9NWlhwczlwNGtQa0FPUnhaL25xL1M5ckVQOFZqbXZvN1pRUERUZ3JV?=
 =?utf-8?B?ZDJ4WERLTHBSelc5cEFiSmRXMHE1clFIK2NmZnNPQjN4WjhQeS8rT05KYXdH?=
 =?utf-8?B?dmNpTEhwMGpqQytIK2xCeXdUZjR0K2hMTlB4ZTA2b1ByRFFVUDBhQ0JTY0tp?=
 =?utf-8?B?MkZJUkJ6QXNsaWpGNXJTd1YrS0ppNFRndXk1V0hZRk5DbktEMkNFNlRlUnBk?=
 =?utf-8?B?Z1FtQStVRUtzTGY4YXRlVkdSb1FDaEtjK3V2Wk1PQkZTaVBvdTgzMHBVTjlR?=
 =?utf-8?B?MVZFNko4aDFNeGpFTk1jdFRLVmtCRGxsaUN2VWVzbW5vT2ZrT2JXYWlubFIr?=
 =?utf-8?B?LzVuN3pUbjFncjhkOFArQXY0VUVsNGtGeW5JMU1pN2I5bGkyWDBnVGdtbWVs?=
 =?utf-8?B?SEp5SDYvNnowZHpLQkdKcFdwV2dmbXNWTTEvQmM2cGpsQVJxSE04OEdvY1Vk?=
 =?utf-8?B?RnpIUjRZbE1ZckcxVVU2WDZKVVJDaG4rL21kY1RmRWhKYWFqSXJBeUxkSFI4?=
 =?utf-8?B?blo5ZktlQUJodlczaG9VaFVKbDNZb0xlMGdIOG96eDhtaGhEWDJGUEwyUEwr?=
 =?utf-8?B?UVV1aDRQR0hNWW9aMkYwVmExclFTaUlQMmFqUkdUcCtjN1NqdnN3akdsOVN5?=
 =?utf-8?B?RnlsU2JIajl3U3YxZ3hKWVNBWUgwVHJYek9MSktKZWFUNDRzV2F5clVXaGxX?=
 =?utf-8?Q?RBmV400qgyYtFOP5SwRK5ltxb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012d7e16-d138-4395-1989-08dac68244d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 20:53:23.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2RvwNOhnFq181wQD0ZsnresrMbXLgwR9tp/kxxQMw4wiq5XBtdUp+OW7MPYWmvx6EjzeTZv8lp+bGB9OkF1TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 18:00, Dionna Glaze wrote:
> From: Peter Gonda <pgonda@google.com>
> 
> The PSP can return a "firmware error" code of -1 in circumstances where
> the PSP is not actually called. To make this protocol unambiguous, we
> add a constant naming the return value.
> 
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: John Allen <john.allen@amd.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Looks like you missed my Reviewed-by: from an earlier version, so...

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/sev-dev.c | 2 +-
>   include/uapi/linux/psp-sev.h | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 06fc7156c04f..97eb3544ab36 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -444,7 +444,7 @@ static int __sev_platform_init_locked(int *error)
>   {
>   	struct psp_device *psp = psp_master;
>   	struct sev_device *sev;
> -	int rc = 0, psp_ret = -1;
> +	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
>   	int (*init_function)(int *error);
>   
>   	if (!psp || !psp->sev_data)
> diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
> index 91b4c63d5cbf..1ad7f0a7e328 100644
> --- a/include/uapi/linux/psp-sev.h
> +++ b/include/uapi/linux/psp-sev.h
> @@ -36,6 +36,13 @@ enum {
>    * SEV Firmware status code
>    */
>   typedef enum {
> +	/*
> +	 * This error code is not in the SEV spec but is added to convey that
> +	 * there was an error that prevented the SEV Firmware from being called.
> +	 * This is (u32)-1 since the firmware error code is represented as a
> +	 * 32-bit integer.
> +	 */
> +	SEV_RET_NO_FW_CALL = 0xffffffff,
>   	SEV_RET_SUCCESS = 0,
>   	SEV_RET_INVALID_PLATFORM_STATE,
>   	SEV_RET_INVALID_GUEST_STATE,
