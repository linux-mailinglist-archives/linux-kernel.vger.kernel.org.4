Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DF65AE8E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjABJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjABJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:09:08 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C563D8A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:09:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Td/xzKuZxURMyWDgYdT3r3yP/Qwy2IBAifR2bqllXEgan52QJLXPWXNHSs4n5zkZzNgcXVJYpsPitarpNJcAfxV+0kPCxuNc8VYo0XxW9QmnIIfBo1ix7mQMwFFM2kXW9G5ZbU+kPLi6Htk55SLbxbC7+n3IpmXjzBEzKoPqJojlW26wSPnEONcMpqiNPiu29LHQojPqAwaxzSfL/GZ9MsmKlm8br/W8vZIafqBOuZ2ykpuEBZrIbIZmq7ReS9ls/hlZkqx/DuWqq+gxLWJM/1FfocQhrxopHfBhpPsS/6SsJoxenvPNqjMDt7X3oIkh+bbt31XW2q8LsIONX8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbylX+XHhd6SHcb5CjIqlAdk+kHMr1oxE/EtNSNK2kU=;
 b=eH9YrxabXOSzrYQDQEvWV75EhOwqYZpSU42CT8CX6LD+sxx3OlejPRnUmnGulrHz0BXsLClAs/citmzmPtXmfeGIDhR1qNW20iqUP6esW629PnKH0dLgulVM4Ijz1i3EF843QampOkEK526wyLjxFK1iJUs1YZQ4UKKw6fXv8Iaopa+OoLiIGrCAjFVdE4u134efbvGC/fd0u2XX7ssjgwsTLyvWEyu2m96rKEKwNGvZop1m5AX2+hdAWZg3G1zzgRiO+Z4MrQBKb9bT7Q69jekexZ60p627idZmFkud7044Ag2QOGcZVSjMYBWG89y6toEmOToGRuSpMie3bNh2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbylX+XHhd6SHcb5CjIqlAdk+kHMr1oxE/EtNSNK2kU=;
 b=Rt+7eJXhVlBmDt4rViwLzDke3aLKpa2LmiUMRUazKyWpb2jsGYA//SBopah87BGiwcEBTdp5sVSraiO5u2NwQp+sXFpU2PfRHp7cCdlXd2pAWvZRoObsBhCZG40bDeNY9gpiLJO4PALDsBmDEoWJt/4HZGo7xszek1MFA7hsqkQGmJHAndU7H/rRcg7D5a5kz8DxCyQBH0xKK/UFukK/FR3g3ZZabHN5yiCxvFhZp8ws13/kLwH9fXuxaPSq/VqT1RksWPu05bxjOeAbjW1IEAxkTc+EHHaWuPFMBuV1q9UkkU11lSxovndaKN+y4nZ4YeQVEx1tEPVEAdt/O4xYCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3740.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 09:09:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 09:09:03 +0000
Message-ID: <98eb5bc7-dee4-b36e-a219-17b1e08d85f6@siemens.com>
Date:   Mon, 2 Jan 2023 10:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] scripts/gdb: add lx_current support for riscv
Content-Language: en-US
To:     Deepak Gupta <debug@rivosinc.com>, conor.dooley@microchip.com
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
References: <d65bddf3-c58a-1420-bff9-8333c10edb56@microchip.com>
 <20221115221051.1871569-1-debug@rivosinc.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221115221051.1871569-1-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: 333d95cc-0740-4612-697b-08daeca0feb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4HLxANDuv29hll3lUhh174Jj3pcs4e6zxaCPi2YLoWBl3mCfDZPhghVisfOzQXpOh8nAjLtMicyfZ6ls/g3WYW2N6xE3JB/kl7XHpPcMjEBDj8nnR+F8MAA+0Y5WPaUqqTm9F6JiAuqOAiAR9nlkrvJODOejsOTTE1pwj0ek42cMYug5oWrzs/Lc8LsxU/oBaY2S8EXnLD+nlcoUN9qPeIRrbxX8hgVP7JsS/Ib5Iqg3X7i/JHOoLr5LMhcHLpuo626M2W8pz9iAfHOTkd9T4k6xKOV4K09mJm9e3oW/+pQ2WxMAXFBatwSOAzmgu91rnzwE/z17/moKH6QroUc7vKF9XMZJHV4l/xGaMdbB7m8tfO0FMGLMRjyc8r6cml0OD3SOq4FsT6KzAGXR6K18MGSI6dQpeCE2LKspvZTBbwODNfj23B3I5JDegdjhjXbJ0zFH5ItWIlgT+CuIrO/S7ojFpn4OdfP+A+Wq9yi4ZejUVr0YgQvqPJm6r81Sz/pXbfjINftp9VuFFEbrgi6QAlV6DvMkVmsutkF14cTXDa7e8W/o8VlPrJlotrpUwVXty88McTQJ9GfW7Ebzz5Dhz9AZdevX8hrxO8YzSqVYin8jks+MIcGjyqvo1qo0omUeWdJyTcrnSa7S0MEiM6g0ThJEZpr/tEjJTS/GWMFHnkkDXEE1wvqHmpM+ASHex76SIP0G13USYjEQ2QXDUvthPjL0nV9iyrsIqlFnShk6mDZYA4pwt1Fosm3h9/pympoQefMnGA92UaCDS+f+syhwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(83380400001)(2616005)(31696002)(86362001)(36756003)(38100700002)(82960400001)(66556008)(8676002)(66476007)(8936002)(4326008)(2906002)(44832011)(5660300002)(316002)(66946007)(6512007)(53546011)(6506007)(186003)(31686004)(26005)(41300700001)(6486002)(478600001)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejZOOW9DVTMxb3VQSmJKT05LaXBXcThEZ0hNSUhuT1RIOXBrOXc5MFJhQ3Ir?=
 =?utf-8?B?WnRBKzJqTlBxSGJVL29OZXROZ3dLUXhxeHVPSUJDbzYwS21SN3VOVGlTR1pO?=
 =?utf-8?B?MTg3N2NKZEI0OSt1azIwdWNZaUR1bzU5cmVsWDBUUEVIaW9sbXkvOCtCay9F?=
 =?utf-8?B?d3dqK2JQSGhXczZ1M1RvNlpvdVh3M250ZzVvMFFGdHFjNnkzNlJKSFhkRlVz?=
 =?utf-8?B?eHNBQ3prNnd2cXRLVTRzL0UzUGgraW5PbVBJTlRpdEhLQy9yQU5zVkJmUGhF?=
 =?utf-8?B?OVI3dDlwejdzdW9EdFY1ZlB2UFRWRFVFMkk5OHBZSnlFazhmQnJmOXY5YUxw?=
 =?utf-8?B?N1ZhMm5raFJrRk5sRGd4Q1ZkMDBnTWJiZ21CQXZHdUlIdlVxbWpmTFFXdXdp?=
 =?utf-8?B?TWxPcGlUVUJYZWQyUU5lbWlNNDhNRmVBeXBKZWtiMlJFbHE4d2hhb2FGdExm?=
 =?utf-8?B?dFJJaHowM3JmLy9WVnBOSm9NcGhOTzhoVWR6a1puNjhnSDBZa2VZdWVOaHVC?=
 =?utf-8?B?WUd4cHAwUERaSVp3b0d1NFNKcHgvVExLaDBlT0dIQ2xLcFQ0NjlydTJOazBQ?=
 =?utf-8?B?UDdJUG9RVVZoZ1c0VzdGU1NISXkvOXg5TmhMcFNpa2hLanoyL2kzbzRtR3By?=
 =?utf-8?B?c3EyakZ4ajA4MFVMYjA4bnE1Q0U2eFlIMXRYaE9vWlpaRlU4Ylhha2lLeWla?=
 =?utf-8?B?eFJndTZkVituUDMwZEZOQ1Vkcm1nVS9EUU1Xbm53RGljVkZsWWhDb3NVTFFD?=
 =?utf-8?B?NCsvbW5NSnNmeUMwVXFQMW5xbmFHUVluN3VZdGg0V1J0UE5uVXcxaWNUY3I2?=
 =?utf-8?B?RG1vVkg1aVdMRjY5VW9XdS83VXcyeTZkTzVHR3hZamN3d1BJdGFkK1pULzk5?=
 =?utf-8?B?Y3VSYzRySGErbzlpb2FYSnA0TndDNDNOMzBDWEhrSXd2d2t2bVFmUy9TaUJz?=
 =?utf-8?B?VnpqTW1wTUc5V1FZN3d1NG1pblI4a3N3L1puTFl5d3g2YU5wNlMxNXhDZmdh?=
 =?utf-8?B?RG5CWVpNZjR2RDVSZWpvSjgzWE1OUGtQZ2dWUHVNNlVtdWdKVzFCUkc4OFRN?=
 =?utf-8?B?NThBMHdJUG04MHhqdXJEQUthUTRXclJYTkxLNWs2Z2tLcndKMXIwR1FENXR2?=
 =?utf-8?B?M1FmQWhCaFNTMnZHWUlHdGFsMEVZWjhWVTdrUUNVZEdOenYwNUhDeTZsdnhv?=
 =?utf-8?B?cXh0bW8xWGNTeit3Y2lKUGdaK1BGUnRKdGVwU1pTMGxCdnBhcSt1QVNjY2pq?=
 =?utf-8?B?Yzh1SWxPdmRkM2txUE9KZEZUd0pmeGhKQ3c4NFI4KzE1RVNXaGR5Z2JWV3Nw?=
 =?utf-8?B?cVJDc1pXSmF3N1RlMThCNVdPNndqNWhJNTRqVEJDNEF5Ky92L2dPdmo3c2kw?=
 =?utf-8?B?M2lycU82UU5TLzYzQ1ZENUpJTHZlelNmYTNVanUzRWN0K25PRFFjMTF3WitV?=
 =?utf-8?B?eGcvTjlKMnRlYmFXZjEzSG8vdWxveG12UGc3R3JCaHM4R2JRZ1BhNSt5NEt0?=
 =?utf-8?B?QStMcnZYQ3VpWGM2aW50YWJFNDVBM0dRb0NUS3NVVnBDVXR6VngvMGhNbzds?=
 =?utf-8?B?V1NoZzUyRTA1QkxhSHBoRTNHS3daaFdFMUVDQ2Uxc1NzVG5FcmN1U0I2d0Iv?=
 =?utf-8?B?Tlpqd3E0YkV1VW1jcWVKWVlOV24wTVhBUGJsZnRkL2dvSXMreXU1eUIvZ00r?=
 =?utf-8?B?dS80UEM2L3lKN1hCakcyOHR0K0NFUlJFaTRPWDFHZDZqWS9wUTNzdXBsYSsx?=
 =?utf-8?B?ZnByRXVUYWV4dHBXQndJeG1ZUEFxM1d3emxVOUlMMUxtMnlYRTJGTHcyYVFO?=
 =?utf-8?B?VjE0aldwajZXOTN3NGlDdXBkYTcrelRiMXFycE4veDN6UTFaczVqZmRqaWkw?=
 =?utf-8?B?ZEliT0pEQ3BuTXVtR2VXWVcvUno0ZzBhNUk0SnJ0R0kraVBqeXBtUEZWYk1G?=
 =?utf-8?B?WVhuN0pMNGxoMGJMaEtRenpHMk9lQjdQaXFjQzNtaTlIOUhTdkR0Z01hNG4r?=
 =?utf-8?B?Zm11ZEtFMy9JaVlrREdBeXRkVTQrd0JTZFZMenQxaWM1WlMvdTlyaDhFZUFI?=
 =?utf-8?B?TnRIOHppTVZBQ05pMm1Za3FLbmJ6cjVPSmdaR3JjV0lqcjZUMWpYUEJBbi92?=
 =?utf-8?B?WGp1NTRoME9ORGVGL2ZDWndDL1NZM3J0UXNyaXFJZzhobERyTGcwOWhMTDJu?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333d95cc-0740-4612-697b-08daeca0feb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 09:09:03.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CtdKOoNL5uh3Yai8LZtxUID/XXGzolqWPMi2fnO9985WZ+LFZcDlUOzBSNRcbuSvpO2YiL94kInex1jyGqWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3740
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.22 23:10, Deepak Gupta wrote:
> csr_sscratch CSR holds current task_struct address when hart is in
> user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
> register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
> "tp" with expected user mode value and place current task_struct address
> again in csr_sscratch CSR.
> 
> This patch assumes "tp" is pointing to task_struct. If value in
> csr_sscratch is numerically greater than "tp" then it assumes csr_sscratch
> is correct address of current task_struct. This logic holds when
>    - hart is in user space, "tp" will be less than csr_sscratch.
>    - hart is in kernel space but not in trap handler, "tp" will be more
>      than csr_sscratch (csr_sscratch being equal to 0).
>    - hart is executing trap handler
>        - "tp" is still pointing to user mode but csr_sscratch contains
>           ptr to task_struct. Thus numerically higher.
>        - "tp" is  pointing to task_struct but csr_sscratch now contains
>           either 0 or numerically smaller value (transiently holds
>           user mode tp)
> 
> Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> ---
> Since patch has changed a little bit from v1 and I didn't include
> changelog earlier, here it is.
> 
> v1 --> v2:
>  - added logic to locate task_struct irrespective of priv
>  - made locating task_struct agnostic to bitness(32 vs 64).
>  - added caching of ulong type in scripts/gdb/linux/utils.py
>  - added more descriptive commit message
> 
> v2 --> v3:
>  - amended commit message and source line to fit column width
> 
> v3 --> v4:
>  - amended commit message and remove whitespace in source
>  - added Reviewed-by for reviewers
> 
> v4 --> v5:
>  - changing the order of changelog and sign off/review tags in commit
> ---
> ---
>  scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
>  scripts/gdb/linux/utils.py |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..14c22f82449b 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -173,6 +173,21 @@ def get_current_task(cpu):
>           else:
>               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>                                  "while running in userspace(EL0)")
> +    elif utils.is_target_arch("riscv"):
> +         current_tp = gdb.parse_and_eval("$tp")
> +         scratch_reg = gdb.parse_and_eval("$sscratch")
> +
> +         # by default tp points to current task
> +         current_task = current_tp.cast(task_ptr_type)
> +
> +         # scratch register is set 0 in trap handler after entering kernel.
> +         # When hart is in user mode, scratch register is pointing to task_struct.
> +         # and tp is used by user mode. So when scratch register holds larger value
> +         # (negative address as ulong is larger value) than tp, then use scratch register.
> +         if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
> +             current_task = scratch_reg.cast(task_ptr_type)

Why not if-else for the assignment here?

> +
> +         return current_task.dereference()
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                             "supported with this arch")
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index 1553f68716cc..ddaf3089170d 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -35,12 +35,17 @@ class CachedType:
>  
>  
>  long_type = CachedType("long")
> +ulong_type = CachedType("ulong")
>  atomic_long_type = CachedType("atomic_long_t")
>  
>  def get_long_type():
>      global long_type
>      return long_type.get_type()
>  
> +def get_ulong_type():
> +    global ulong_type
> +    return ulong_type.get_type()
> +
>  def offset_of(typeobj, field):
>      element = gdb.Value(0).cast(typeobj)
>      return int(str(element[field].address).split()[0], 16)

Looks good to me otherwise.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

