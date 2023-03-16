Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D306BDA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCPUbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:31:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE11DDF3C;
        Thu, 16 Mar 2023 13:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3bt4RHQBu7t/g8vUGp/XVZHiwxvcixY7CW+liIemaQjt97JkM0xYxdcTeBFfv+Ezg9zOz+EpBI32EbX/nocxyVT1ITMJCxwkrZd3WO0g1IvX2GgnAsgNx1WsxLMjhVefuIMFM/ymFziJ6aPNN5ie83mo5ZJ6HN7KZyJTugWv4nk7Lk35J3VzCKOX0aJA9nMfXqL/Wj/eDhsVW/5lddsGlkVQ0axK83z2ZeKhZvp/MS3meMpaWvFnz9qmUOMN4Lbb/sMga7TJirHpbVcnogVOW3wIYGuzcHD/AxqrwKDV+H3o0D4C+jq8K7dXUCJxWoeSbAdyQiCAV5WnEE8JzcEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USi7s3JC2ev1NBhicyzA00/seGtIC1hltUuqo8Bvw8I=;
 b=Ngt7hJBvyvaqMbYnvOd5mF8mk649ElgoKAuRi9gpCALQkJUjAi3iQOyJ89Pg66juQyGXOKsMtIfxo3XU3wxviaMBuQMwPGI5RHiy74MkoU7OITmZwkuXeYVmELX5cyEQmR8w8x3DEhFMqqZaclcv1Uj/HF5g6Eht3dawE3awaENniePO4dPxn5j9INbYXhsj5ssAwdf9TdYx5r7O+bYYqKRVFVtzlDKmyslFvpgDYIQLsxXK11hSCKXCSoJII8nB8EOVRHfESwu5OIIpf5cDH5E+u0yW949qPgaFxwH2NOp8YkRExdHZ45GMiT6ZL0bYJ+9rr0Udj+vitRSnuGBwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USi7s3JC2ev1NBhicyzA00/seGtIC1hltUuqo8Bvw8I=;
 b=LPrO3N2YD44S+P91GGvs4ZukYdgcdampJnSGkKyD35vj1VA7FzrgDRiArOpNUecgKBjInHYIIX0mjwtKgNNM/uFRRYfpB/HI5vVkw/gh86hlnNQkHPqjPD8bcPGUXKLwq9Bvi6TVRqppweaWkbydtbPQQ4k60nKLFooLdNVXMgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 20:31:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%9]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 20:31:29 +0000
Message-ID: <edcb0810-df39-669b-ebf2-5988a71525e9@amd.com>
Date:   Thu, 16 Mar 2023 15:31:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 2/7] x86/resctrl: Remove few unnecessary rftype flags
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778867236.1053859.12920879751317268318.stgit@bmoger-ubuntu>
 <1a45fc82-9339-d086-2e70-27fd91906b8a@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1a45fc82-9339-d086-2e70-27fd91906b8a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:610:e7::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d429eb-f5e9-4fdc-7344-08db265d6c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qzo+i7I16xJcQfXt1v72Buwi2RBhkazRR9RDxgbo4l757ZxbF7rfTCKkFv1Yhp8NjgFq5mdHTb/0oB9LhTB53EpxsJulrcxUQ8v1GqFqDOAzpWbl+KWuOBKbCKFiuwha/Fw72X5MaJtqKlybA1RzAE5UgCI3eo2YzRPQyS5iCZU0hzNurH/+f2GwEBUsT44fPIGCwgXRLn7zadvQ47ske8idtu/rPFf+bU9KB/n2S45+pv9+0dxBqD/MtZqWyEGm5g6D3uuaFuez2+Bl4aSJNeOXhPy1cGJ94Uwx/+H6qcbZ3PYQC/jtnvdDOGHJHr+uFukysO8xEAEWQCQ7WlIGLhzR5Rh3gQ15ll/2fOAzw9fC/SCS/eHScT+VWWU81Rx/WXtPdU6GOosbYtb3h+GOlvEotYDuxPJDJcgJbsdc1+K3fT0WDTXokVgsRi7EXP0BnghpLp2DgDzlWKGHi6dVHkRb+r6lsFb11jZo8IlhWvOTHqolmVCOGpdC7jGlZ42m6o71c67P+gxswkR2sRUeANg8jehiGVDwHLq7vFjJ3N4hS6hBgGd7zKWsirBYB6PvjoFQvXms0UtmgEVxTsAJ0oA8BCoVN3jsDxDGhuo4MYlNjGIrVIEuvGBbGPcVrvZCih6dSJMuSrlhSdwbKRWM+sGjPZz2Ncb7c/1RA6JKcT5XTxSLFjm1K57xIKtOYre9zlK2YBCFJX0Xbxi2j2LNCeFWFAu7hqYEj2jQnYyI4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199018)(478600001)(2616005)(6486002)(83380400001)(6666004)(66946007)(66556008)(66476007)(8676002)(316002)(6512007)(6506007)(186003)(26005)(31686004)(53546011)(4326008)(7406005)(8936002)(5660300002)(41300700001)(7416002)(38100700002)(3450700001)(2906002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi9JS1ByeEM1V01OU3JaK0s4SDdGVkZVSkZ6M1RZZVhXam1MOUNpeHhaL1dW?=
 =?utf-8?B?QXRDYUZNNmtMZzJ1L3N6QkhoSjA5WG9NTUs5UE5UbXh1QUxYdE9EY3lnK01V?=
 =?utf-8?B?bHFVdnVkV2diNzhxU3BnOGhrSGhaUXh3d1JEVEtSZFFWQ29VbklGMStIekhI?=
 =?utf-8?B?S3ZYQmVLVHhLMGZSajRHbkZJeVpTRklNNTQxRGJYY0YySXVBYTVNTU9nT0wx?=
 =?utf-8?B?eWZYVEJsclJOQzZyRzQyd0VjUVJieXd3ZG1uRmNjM05Xc0hzdnYyMkhYb1Ro?=
 =?utf-8?B?MGxGeXNTMXhFUno3SzhabzFJZjFHaUFQVTRSRGFUQkhEY2RWQmxiZUNlS3Ix?=
 =?utf-8?B?SG42NS9Kc2NmTE92V1Z2Rlk2ejBIRm9hWVZCWWlxKzNqczRmNjBXeDNpa0Ji?=
 =?utf-8?B?TVhoanhOcmpQWFhJTWd1UlR0VS83bFlkclpOdmlYYU05TSs1QjNDK0tkV0ha?=
 =?utf-8?B?TFI0TDVOUEVEZnBZWUlWNlBsaWVjN2FkcDRrdzJBWlo3MWpiOUpQTWdoc1Jl?=
 =?utf-8?B?eUpqaUFHQ2ZFS2xMWS9WT3AzSEFNREF2Nm9yVUpyOHBpeWhDSU5aSVpyeXhk?=
 =?utf-8?B?TEMwMTB5ZHB3aW8yUFRSdXhaalhnblRoYVdpWGlIbENGRVg4Y09INnNob1lk?=
 =?utf-8?B?Q3ZkT3I0U2pQeUZ0cjAwVXVuczVVNGdaVEdRZGZnUnI3NTJ5SjhzaVQ3NmVJ?=
 =?utf-8?B?MURML21jRTZnMEtucWZycDk5eFYwd281N0JzNjNhKzBBZitEMTcxMklyV1dB?=
 =?utf-8?B?UE5Nb1VtdHFOaE15bGUvNmx1U21nci91cGZiYmZFb3hsQVpyUFdSaWpqWm1X?=
 =?utf-8?B?WlJYbURLQmZ1NG5qcjZsdEFoRDYvVjY1RzQyblVCcnowVUJjWkUraDRrODV0?=
 =?utf-8?B?TGxkSUYyTzgxSjFOeXVuR1VTT3EzTk1iUGhCT0NscUtMT1A1Q0YyRDB3QStZ?=
 =?utf-8?B?ZEVsRzdCSldKWUE4WEUxRnk5L2NiYWNsYWFEYlhxVjlqRlU5QWtLalhwMzRZ?=
 =?utf-8?B?cm5ESUFwbTR1MmRsLzVQbDNBWGlIc3ZyNXpPWnQ2cE1rUlRmQWw3Z2gvNHFo?=
 =?utf-8?B?NGVDd29IWFl6K2RxS1B1Y3REVnNJYkxjWnZaczVLTmZMVUJLRXpVMmhSOG50?=
 =?utf-8?B?TytTcWtZMElWT1lVRFpibU9aZlNFWmE5blZ6K1dmUDluY0Z0MlMzeE16ZkpI?=
 =?utf-8?B?N1Q5d3cxZStQUWtkeHBBd1BobmdaYUJ3MjJGSEUvejFwa1k5T2xZUzQwTkVU?=
 =?utf-8?B?d24rTG1ISmRtMVZXY01XU0lmZSswQ1Z0QlJjLzhLWm5wV01nQ1g0WGlmbFRT?=
 =?utf-8?B?RmRvWFVaa3VYVEtaeXlYOUVNUUd4WE0zb3RoUWF4M1F6NXQxU1JHVGw4TVg1?=
 =?utf-8?B?aUVRYVovUWRNajVyTytONGhlakozY1RzU01JRFdERkpSN0tDL0tyZTlmWDhZ?=
 =?utf-8?B?aFFKckMrNFVyRDRpYWI1YmloVGNDY0Z0dTBSSGVpOXYreEJnbXNGOTF0QnNz?=
 =?utf-8?B?aHhHYThEZmZWNlpGUVkwVURNSVZiL0tmRDBnQXBwYXB5WmVTVllmVjZTY0FH?=
 =?utf-8?B?RVhuL2dtYnh6TWNxendMb1lmanlwTVV2bjk0bGovTkNJLzlIanFVQzQ2TFB0?=
 =?utf-8?B?ZXNMbUxTbHdMWkwreXl6NGliMjZsdEJKMGxMSmRvanhOUlNDQmp3MjFrVmxH?=
 =?utf-8?B?anFGbldzSGZzSVlRM0xNanJuZjd6dk81SzZOR2QxQVdndE82ODA1dzFGTGdC?=
 =?utf-8?B?SHpNNmE0OHJHd211b1l5Z3VCZXJreGF6c0htbm04VHZMVzlRQ3NnbVBPRVNz?=
 =?utf-8?B?NGpEamtRSE1uSEo3c01UZHBub1NRRndCZDg3RFA4aUZGR0dwSWF1bnJ2SFFj?=
 =?utf-8?B?aUh0M1hnTTFqUCthS0EwWkg2elVBa0ZUUGFTT1FLUGRTbGk0YUhiQjBjdHpl?=
 =?utf-8?B?ZkZGZ2lwRkZjcnp1SUVzdXhxb0VsVlJpR1JjTXlrQlF1V0c0eGdJODc2Rnpu?=
 =?utf-8?B?d2FyS0VmVndiUEhON3EzMlpBVFZQUUlPcno4cUtEY2JWZDFMQzJpaE93VW5m?=
 =?utf-8?B?OUdWZHJPQlhnQVo5K25rTDFva3pWb2JSNUN4WTQ2NTFHTlZCUjl4Vys4eWU0?=
 =?utf-8?Q?SqESlH7bdBeHsopq92aGzKx0K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d429eb-f5e9-4fdc-7344-08db265d6c27
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 20:31:29.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml7TORT26keMReyG1unKT409c4Oh69Q8z2d44HkUL0+U26GQjo3yMOsNxUx8r19R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 3/15/23 13:33, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/2/2023 12:24 PM, Babu Moger wrote:
>> Remove few unnecessary rftype flags and simplify the code. This is done
> 
> Please drop "few" (here and in subject).

Sure.

> 
>> to further cleanup the code eventually.
> 
> Could you please be specific? "further cleanup the code
> eventually" is too vague. I do not understand what is meant
> with the second sentence.

I can just say "Remove unnecessary rftype flags and improve code readability."

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    9 +++------
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   10 +++++++---
>>  2 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 8edecc5763d8..571145d75d29 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -243,12 +243,9 @@ struct rdtgroup {
>>   */
>>  #define RFTYPE_INFO			BIT(0)
>>  #define RFTYPE_BASE			BIT(1)
>> -#define RF_CTRLSHIFT			4
>> -#define RF_MONSHIFT			5
>> -#define RF_TOPSHIFT			6
>> -#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
>> -#define RFTYPE_MON			BIT(RF_MONSHIFT)
>> -#define RFTYPE_TOP			BIT(RF_TOPSHIFT)
>> +#define RFTYPE_CTRL			BIT(4)
>> +#define RFTYPE_MON			BIT(5)
>> +#define RFTYPE_TOP			BIT(6)
>>  #define RFTYPE_RES_CACHE		BIT(8)
>>  #define RFTYPE_RES_MB			BIT(9)
>>  #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 15ea5b550fe9..3c86506e54c1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3163,7 +3163,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  {
>>  	struct rdtgroup *prdtgrp, *rdtgrp;
>>  	struct kernfs_node *kn;
>> -	uint files = 0;
>> +	uint fflags = 0;
> 
> Hoe does changing the variable name from "files" to "fflags" simplify
> the code?

I should have said readability of the code. Its actually fflags we are
passing to rdtgroup_add_files. While changing flags below, I changed the
variable name to fflags.


> 
>>  	int ret;
>>  
>>  	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
>> @@ -3215,8 +3215,12 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  		goto out_destroy;
>>  	}
>>  
>> -	files = RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);
>> -	ret = rdtgroup_add_files(kn, files);
>> +	if (rtype == RDTCTRL_GROUP)
>> +		fflags = RFTYPE_BASE | RFTYPE_CTRL;
>> +	else
>> +		fflags = RFTYPE_BASE | RFTYPE_MON;
>> +
>> +	ret = rdtgroup_add_files(kn, fflags);
>>  	if (ret) {
>>  		rdt_last_cmd_puts("kernfs fill error\n");
>>  		goto out_destroy;
>>
>>
> 
> Reinette

-- 
Thanks
Babu Moger
