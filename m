Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA5636575
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiKWQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbiKWQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:10:08 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A0C657C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:10:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvw+SEHt1pb9Mxe0WBMfT7yboKwQ+6iEBkHufLfG1caGfmxIFqCkcjWoyl7Y4/Ainf5fRqnt9Hhh8ryebNa+Vh8BHBVmZJvLrgAbDqKD6+HgPCEQhJy5c5UwgYo7pBpCwVI638s+H1EAuFIQObGLI6QG5o4Pqndy/yonxT2LZX31+O97mafuvXnxvhguXlzlyyNLRgv1+zoOhRz98s69CCnK+N5hk2JdJUPGGsHJaZy3YrT298qA5x7JmYKNQSbOJbbz7KEeP8NPsEIfBTQci004Mdm/sJq+4ei8qKMmpUDRvSf9CLtEMEOCiE9t2t3vAE1ZyAqlgKWRce3UiYaegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbkLy78ZNVEc7Jvk/RxWCcd8Hp92Zd7jSjybVRu44KM=;
 b=MlgZJwjS0X/s6By9z8QAPiwszcWlcsiJoOgjLZ/iMLoz/AF1IP/0V5DpCLJ7MTWdDhbExaHV/lY179vqrxboZVg8R+XjUBcKwC5VhgNECADMw+FnOBY/wn8gdGmrRSWN0nrORBS4jvhBfD4+vBzZriSootJk5GkWQX4cZJxeg87Dp8j91JKNxMrqKM9dU/Fg1nHTcAJPu/QA0gl+0aFJiTVWhR4jTHhabvl2roOuPU2q7X+0BlTMk8S6z612F3n0dmoeaBh4jMmKDVe89xZY8JEPiQ3y9DApmkP21orgb9vxpZZPMz1//VsU7NbN1+mOO9TvBaIPzVSCCoRPQh2L3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbkLy78ZNVEc7Jvk/RxWCcd8Hp92Zd7jSjybVRu44KM=;
 b=nQ7ELCFSDu/sJga9bS4i1VPhIQ+L6yGeb2pyz6KYlVknZo0MyMl4WOnSlbQeLOlZ3xVAhfO9LGV3vkdFdwVZAknRKjhv2qFiDNu/98CX4rawPJGg63sluSXELNl9NeHSSdz2loBps3vTEUKYLkyA7mzdbR+hn7iTCrqnc/olBaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 PSAPR02MB5125.apcprd02.prod.outlook.com (2603:1096:301:8d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.11; Wed, 23 Nov 2022 16:09:58 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::2954:8e56:dcd1:452c]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::2954:8e56:dcd1:452c%3]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 16:09:58 +0000
Message-ID: <55fe7a0d-9bee-1f1b-25ad-a71088b94b7b@oppo.com>
Date:   Thu, 24 Nov 2022 00:09:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] f2fs: fix to enable compress for newly created file if
 extension matches
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <f508dea8-5dc3-e29e-0d8b-4d64735817ac@kernel.org>
 <20221115160155.1037163-1-shengyong@oppo.com> <Y3WKmvpz61K9pwqO@google.com>
 <cc76bc01-b1c8-e52d-02f0-daaae81306f1@kernel.org>
Content-Language: en-US
From:   Sheng Yong <shengyong@oppo.com>
In-Reply-To: <cc76bc01-b1c8-e52d-02f0-daaae81306f1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|PSAPR02MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: df15ded1-9f0f-4569-c6d7-08dacd6d2a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlpDfo5O6u6mynifBdGb3ABBlQxLPQ0A4nxY7w1JBrH5l8+oKve/r65bG2kdxIeOppeuiLisKJBTZ5t1kmU2nez/FeubxGADQaTUBt1R7KP+NcZQNYP0C8yTsNyDUOj6c5GvfzWTHqOq2pQn3ZPIFSsRRGMwTlyHscRrPFsjwz+f4plFmxPZtxmnBi2ERiZACih21rNrhqdukZmgB6mU1UaJk9jvH3mkS41l1PylvCrqYegWM8x0asmJDyGkfqBWXHurTiB7N7Vlk8+Unb+w4jURVxFTcy575vYbY8/mgiCY6TggOr1s7gUNRq4tVl3xu1tv+iqoPm+LPVXkIF35Trrr/hoGgilWEH+T0XVHDsczzjvGAqYk+y4Ts9cr4nmvRQaeU/CGEy/1r46V2zCjD5PvR04dCx9Qhh0NyuFGFcsmEXt7xgT3Ez6Eujy4val8GsnH66ev9dA8N60abs8zsnUPMe+rhxo4IzjLZeNDQqbQyfb6SQxUjNRyf9wWUSUGdjK5TYxdbRGgMqsFshOX67ipj4eLnD3wJdkV5rHE8clEtI01hFcoB1hT4s27t9CuY0MiAceKGJdfCiehlkKYw3jEK8A7FGNw/X5LvhNdm215rTaNEJ2cL63ar6cM7ACz8YpV7x+BCsg4VjMJMk1JIgIs3bgiMfVAXt0QQk2xVbSdB3qrts/RORBtR/Qy4tBGJiMSeuPjTgNs4fmVUhtauEiFGQ5Bhz7xgAS6pUvDiL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(38100700002)(31696002)(86362001)(6506007)(186003)(2616005)(110136005)(26005)(6666004)(478600001)(66946007)(6512007)(6486002)(2906002)(8936002)(53546011)(66556008)(66476007)(316002)(41300700001)(8676002)(83380400001)(5660300002)(4326008)(30864003)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxIQkdENzY5bXJLVWxxOVJTT0p2L0tvRFZqUUxyMkJkTWE4L2NPRVdocEh6?=
 =?utf-8?B?c1JXOWkrdWJIZDRPUE9KcjVhblNnZTFaYU1XK2lqWWtkb2JwS3ZzZDkwTmZn?=
 =?utf-8?B?K2NpTitTbnAyUm5FSkt3OUJhUSt3R3puK1FVUEFDeHdKZlRVeVVtV2UvTHV5?=
 =?utf-8?B?SWNtMjhtOGRtV2NqaDdEVGZ6QW9INUdNY0dwUXV4eHB3NzRSSUxUdDRrbjli?=
 =?utf-8?B?bURoYXA5SDRyOE80eXdoajFEdG15TDFBOUxIUGk1dis2dUpTOUN4WTcweVFv?=
 =?utf-8?B?NVRLekYvMVV5Sk9MTnlTWE42RnpnOWRkZ2hnR1plU0h0ek1LM3hNTzNReGtj?=
 =?utf-8?B?SUVON21KeEdFd3d4M0VjL0lpRG11UDNxaFFqY3NqZy8ram5kQnVERUFGbmJV?=
 =?utf-8?B?Z29PMjFRNTYveTF5aFF4WFVRMmdobVpXbllBeHlVbHorL0lvY29OS0JFNUNP?=
 =?utf-8?B?WUZ2SnRGVzdHZjF5Tmo2V0pxcG5JL0xrYXZYNWpFSSt5dGlCWEZmdnZjMmV2?=
 =?utf-8?B?RUtrbTJsZnRXR2VXVUsvaWZJMUQyRUNhWEJUN1Y2Nlc3dWRHVnBOVkI3dEhm?=
 =?utf-8?B?anNnWDZzbTU4a0RKakJDK2tURytXZEdRQk9CTnVCTGcvYjZuZ0IyNHdIKzU5?=
 =?utf-8?B?V0t0VUhjWk1QVXJwYng5czhtYmEzOTVHMDhPem1Vb3pXYk9tYi8yeVJhQ21M?=
 =?utf-8?B?aExkSmZSSzVVeUFLUDM3SE5Ka1QwVGFGMytaUVlKbzZ4MkVLVXBXOVFxWEpw?=
 =?utf-8?B?bWRwZ1VpbXgvK1JOQi9UTFBYSTU4Nk5ibXlJTkFmczFvQjlGdGNsRUtLQTZt?=
 =?utf-8?B?QlpFV1lITkMwL1RDU2FhU1o1VmVhWEVCUVp6cWZJSlNGeUNNNlprZU5SZEhQ?=
 =?utf-8?B?SFkvcWFNT1VjcndqOThsYUhmNzk1dHBXRER0cUYyMDJHd0prWlpiZzJwT0dL?=
 =?utf-8?B?am51Nld0dkw3U25oSUdtQjZxTTJDL3ByOTZoWHRWUEJaWGE0RXFrRWE5K3F4?=
 =?utf-8?B?K3dGUmNKS1NmNWlGekpubXZDQmNwKzlzR3V5L0d1V1dnblduZzIxbHFZZVRJ?=
 =?utf-8?B?VmVGYitVcGhha3E2Y2YzdFp2N29WUFdFMDRHUzQ3blZHUkFzc3BkNGlqS1Nn?=
 =?utf-8?B?bVJHUVZXM1Z4U0MyRjZvczJhemw1bHlkYW5aMEw1TytEQ0gzNkhHUlU2M1ds?=
 =?utf-8?B?Rzc3UG96cmhRbmsraDJJVEVNdm9UMWowTjVNWnA3dzBZWlJYQWJXTHBESUZy?=
 =?utf-8?B?WGdQdCtCODZEdFNZMk1PeDhDMy80RHJ2d21KeDIvQWx6dFlCdEsvSDlQMS9l?=
 =?utf-8?B?K3IzSnM4UHhFVXlEd1EydGhDT1c3ckFtN3BSWEs0N2FsY2J5QTM0NXJFdDY1?=
 =?utf-8?B?YzFWTldDakdLK0VyL1NoaFo0aTl1ekpaUmFCNXJXR2hpYnhzalZjbnRyaXZY?=
 =?utf-8?B?SFZKd1o4Y2trdEJyTEJoWDNRUGdhaGh1MXZZaTgzQWxHb3JkYzBxNURJRWtn?=
 =?utf-8?B?bmtDbHpqOFQ4bENDakQweXFEUUtDQWNxWG40K1ZnUVUyVGxESTQwYURxUnM2?=
 =?utf-8?B?eXl0Y2M3alRtTFdaeVE3WVFQOUFEdWhYclVncHVYQ2ZBQVd1ZGlXT2ljdEU3?=
 =?utf-8?B?ang4YjN6bjhHWEtNbWVHZ3RocGIwaVliYjZmeHI2L0Y1K0lOWHhWUitJMUVF?=
 =?utf-8?B?VmgzWUJOU3hGWjNHQjg4TjYzM08zY2ZzM0wxVjROVTNYSmV1a0pkUGNsaUlN?=
 =?utf-8?B?Z1lYQU5NaTUwWm1tUmZGMjJrTmkzdTBmYlZzV1YzbnFMUlF0ZUhtVzhMMXAy?=
 =?utf-8?B?YndGSVNNTDl5WkZqbXV0YVd3R0hWSFpwVGNWU2IyYnVIcnhVd2ZPTng5TmN6?=
 =?utf-8?B?ZVhUV3R3VlNXVWtsM21ha0x4V3BrRXl2MjBuWllzNW5UWWkzaUNsZVNRWENr?=
 =?utf-8?B?UDQ3QWFwelRmS3FTajNVTnRLZEVvai8yUU5YTjRQU1RzZ3pUTWlJL1JZQWFW?=
 =?utf-8?B?c0FzTVVNYlhSNXViMFRWVGZPYStaY1NVVTFnb21iVGtlR3NIRXdXRmtYdGM1?=
 =?utf-8?B?Y0U5YXVIb2tyVkRLWmQ3S2RyTU9GTnN1dFVUdm5oMTg1bHlmWVA2OGdDNWZL?=
 =?utf-8?Q?DJjB86PdxFvIa4gt2c9PgBV4p?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df15ded1-9f0f-4569-c6d7-08dacd6d2a30
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:09:57.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drr7TsJxfaHRwpyDzSGYcvWrAA5W/Kimsw7ZMb7cc+bMVpE2JmsAkMJ+/Jjl2m08q40O9/5c3Mg8YfD9mLnpyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB5125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/23 22:54, Chao Yu wrote:
> On 2022/11/17 9:12, Jaegeuk Kim wrote:
>> If compress_extension is set, and a newly created file matches the
>> extension, the file could be marked as compression file. However,
>> if inline_data is also enabled, there is no chance to check its
>> extension since f2fs_should_compress() always returns false.
>>
>> This patch moves set_compress_inode(), which do extension check, in
>> f2fs_should_compress() to check extensions before setting inline
>> data flag.
>>
>> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
>> Signed-off-by: Sheng Yong <shengyong@oppo.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h  |   2 +-
>>   fs/f2fs/namei.c | 325 +++++++++++++++++++++++-------------------------
>>   2 files changed, 160 insertions(+), 167 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index b89b5d755ce0..dedac413bf64 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -2980,7 +2980,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>>   /* Flags that should be inherited by new inodes from their parent. */
>>   #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
>>                  F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
>> -               F2FS_CASEFOLD_FL | F2FS_COMPR_FL | F2FS_NOCOMP_FL)
>> +               F2FS_CASEFOLD_FL)
>>   /* Flags that are appropriate for regular files (all but dir-specific ones). */
>>   #define F2FS_REG_FLMASK        (~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index e104409c3a0e..c25009bb72f2 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -22,8 +22,158 @@
>>   #include "acl.h"
>>   #include <trace/events/f2fs.h>
>> +static inline int is_extension_exist(const unsigned char *s, const char *sub,
>> +                        bool tmp_ext)
>> +{
>> +    size_t slen = strlen(s);
>> +    size_t sublen = strlen(sub);
>> +    int i;
>> +
>> +    if (sublen == 1 && *sub == '*')
>> +        return 1;
>> +
>> +    /*
>> +     * filename format of multimedia file should be defined as:
>> +     * "filename + '.' + extension + (optional: '.' + temp extension)".
>> +     */
>> +    if (slen < sublen + 2)
>> +        return 0;
>> +
>> +    if (!tmp_ext) {
>> +        /* file has no temp extension */
>> +        if (s[slen - sublen - 1] != '.')
>> +            return 0;
>> +        return !strncasecmp(s + slen - sublen, sub, sublen);
>> +    }
>> +
>> +    for (i = 1; i < slen - sublen; i++) {
>> +        if (s[i] != '.')
>> +            continue;
>> +        if (!strncasecmp(s + i + 1, sub, sublen))
>> +            return 1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
>> +                            bool hot, bool set)
>> +{
>> +    __u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
>> +    int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
>> +    int hot_count = sbi->raw_super->hot_ext_count;
>> +    int total_count = cold_count + hot_count;
>> +    int start, count;
>> +    int i;
>> +
>> +    if (set) {
>> +        if (total_count == F2FS_MAX_EXTENSION)
>> +            return -EINVAL;
>> +    } else {
>> +        if (!hot && !cold_count)
>> +            return -EINVAL;
>> +        if (hot && !hot_count)
>> +            return -EINVAL;
>> +    }
>> +
>> +    if (hot) {
>> +        start = cold_count;
>> +        count = total_count;
>> +    } else {
>> +        start = 0;
>> +        count = cold_count;
>> +    }
>> +
>> +    for (i = start; i < count; i++) {
>> +        if (strcmp(name, extlist[i]))
>> +            continue;
>> +
>> +        if (set)
>> +            return -EINVAL;
>> +
>> +        memcpy(extlist[i], extlist[i + 1],
>> +                F2FS_EXTENSION_LEN * (total_count - i - 1));
>> +        memset(extlist[total_count - 1], 0, F2FS_EXTENSION_LEN);
>> +        if (hot)
>> +            sbi->raw_super->hot_ext_count = hot_count - 1;
>> +        else
>> +            sbi->raw_super->extension_count =
>> +                        cpu_to_le32(cold_count - 1);
>> +        return 0;
>> +    }
>> +
>> +    if (!set)
>> +        return -EINVAL;
>> +
>> +    if (hot) {
>> +        memcpy(extlist[count], name, strlen(name));
>> +        sbi->raw_super->hot_ext_count = hot_count + 1;
>> +    } else {
>> +        char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
>> +
>> +        memcpy(buf, &extlist[cold_count],
>> +                F2FS_EXTENSION_LEN * hot_count);
>> +        memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
>> +        memcpy(extlist[cold_count], name, strlen(name));
>> +        memcpy(&extlist[cold_count + 1], buf,
>> +                F2FS_EXTENSION_LEN * hot_count);
>> +        sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
>> +                struct inode *inode, const unsigned char *name)
>> +{
>> +    __u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
>> +    unsigned char (*noext)[F2FS_EXTENSION_LEN] =
>> +                        F2FS_OPTION(sbi).noextensions;
>> +    unsigned char (*ext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).extensions;
>> +    unsigned char ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
>> +    unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
>> +    int i, cold_count, hot_count;
>> +
>> +    /* Caller should give the name of regular file or directory. */
>> +    if (!f2fs_sb_has_compression(sbi) || !name)
>> +        return;
>> +
>> +    if (S_ISDIR(inode->i_mode))
>> +        goto inherit_comp;
> 
> Documentation/filesystems/f2fs.rst
> 
> - Priority in between FS_COMPR_FL, FS_NOCOMP_FS, extensions:
> 
>    * compress_extension=so; nocompress_extension=zip; chattr +c dir; touch
>      dir/foo.so; touch dir/bar.zip; touch dir/baz.txt; then foo.so and baz.txt
>      should be compresse, bar.zip should be non-compressed. chattr +c dir/bar.zip
>      can enable compress on bar.zip.
> 
> It looks nocompress_extension has higher priority than flag inheriting?

Hi, Chao,

Yes, nocompress_extension has higher priority for regular files. The following code
checks ext[] and noext[] before setting compression flag. While for directories, we
skip checking ext and noext. So the above `if (S_ISDIR(inode)) goto inherit_comp`
does not break the rule.

thanks,
shengyong
> 
>> +
>> +    /* Don't compress hot files. */
>> +    f2fs_down_read(&sbi->sb_lock);
>> +    cold_count = le32_to_cpu(sbi->raw_super->extension_count);
>> +    hot_count = sbi->raw_super->hot_ext_count;
>> +    for (i = cold_count; i < cold_count + hot_count; i++)
>> +        if (is_extension_exist(name, extlist[i], false))
>> +            break;
>> +    f2fs_up_read(&sbi->sb_lock);
>> +    if (i < (cold_count + hot_count))
>> +        return;
>> +
>> +    /* Don't compress unallowed extension. */
>> +    for (i = 0; i < noext_cnt; i++)
>> +        if (is_extension_exist(name, noext[i], false))
>> +            return;
>> +
>> +    /* Compress wanting extension. */
>> +    for (i = 0; i < ext_cnt; i++) {
>> +        if (is_extension_exist(name, ext[i], false)) {
>> +            set_compress_context(inode);
>> +            return;
>> +        }
>> +    }
>> +inherit_comp:
>> +    /* Inherit the {no-}compression flag in directory */
>> +    if (F2FS_I(dir)->i_flags & F2FS_NOCOMP_FL)
>> +        F2FS_I(inode)->i_flags |= F2FS_NOCOMP_FL;
> 
> f2fs_mark_inode_dirty_sync(, true)?
> 
>> +    else if (F2FS_I(dir)->i_flags & F2FS_COMPR_FL)
>> +        set_compress_context(inode);
>> +}
>> +
>>   static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>> -                        struct inode *dir, umode_t mode)
>> +                        struct inode *dir, umode_t mode,
>> +                        const char *name)
>>   {
>>       struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>>       nid_t ino;
>> @@ -114,12 +264,8 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>>       if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL)
>>           set_inode_flag(inode, FI_PROJ_INHERIT);
>> -    if (f2fs_sb_has_compression(sbi)) {
>> -        /* Inherit the compression flag in directory */
>> -        if ((F2FS_I(dir)->i_flags & F2FS_COMPR_FL) &&
>> -                    f2fs_may_compress(inode))
>> -            set_compress_context(inode);
>> -    }
>> +    /* Check compression first. */
>> +    set_compress_new_inode(sbi, dir, inode, name);
>>       /* Should enable inline_data after compression set */
>>       if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>> @@ -153,40 +299,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>>       return ERR_PTR(err);
>>   }
>> -static inline int is_extension_exist(const unsigned char *s, const char *sub,
>> -                        bool tmp_ext)
>> -{
>> -    size_t slen = strlen(s);
>> -    size_t sublen = strlen(sub);
>> -    int i;
>> -
>> -    if (sublen == 1 && *sub == '*')
>> -        return 1;
>> -
>> -    /*
>> -     * filename format of multimedia file should be defined as:
>> -     * "filename + '.' + extension + (optional: '.' + temp extension)".
>> -     */
>> -    if (slen < sublen + 2)
>> -        return 0;
>> -
>> -    if (!tmp_ext) {
>> -        /* file has no temp extension */
>> -        if (s[slen - sublen - 1] != '.')
>> -            return 0;
>> -        return !strncasecmp(s + slen - sublen, sub, sublen);
>> -    }
>> -
>> -    for (i = 1; i < slen - sublen; i++) {
>> -        if (s[i] != '.')
>> -            continue;
>> -        if (!strncasecmp(s + i + 1, sub, sublen))
>> -            return 1;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   /*
>>    * Set file's temperature for hot/cold data separation
>>    */
>> @@ -217,124 +329,6 @@ static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *
>>           file_set_hot(inode);
>>   }
>> -int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
>> -                            bool hot, bool set)
>> -{
>> -    __u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
>> -    int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
>> -    int hot_count = sbi->raw_super->hot_ext_count;
>> -    int total_count = cold_count + hot_count;
>> -    int start, count;
>> -    int i;
>> -
>> -    if (set) {
>> -        if (total_count == F2FS_MAX_EXTENSION)
>> -            return -EINVAL;
>> -    } else {
>> -        if (!hot && !cold_count)
>> -            return -EINVAL;
>> -        if (hot && !hot_count)
>> -            return -EINVAL;
>> -    }
>> -
>> -    if (hot) {
>> -        start = cold_count;
>> -        count = total_count;
>> -    } else {
>> -        start = 0;
>> -        count = cold_count;
>> -    }
>> -
>> -    for (i = start; i < count; i++) {
>> -        if (strcmp(name, extlist[i]))
>> -            continue;
>> -
>> -        if (set)
>> -            return -EINVAL;
>> -
>> -        memcpy(extlist[i], extlist[i + 1],
>> -                F2FS_EXTENSION_LEN * (total_count - i - 1));
>> -        memset(extlist[total_count - 1], 0, F2FS_EXTENSION_LEN);
>> -        if (hot)
>> -            sbi->raw_super->hot_ext_count = hot_count - 1;
>> -        else
>> -            sbi->raw_super->extension_count =
>> -                        cpu_to_le32(cold_count - 1);
>> -        return 0;
>> -    }
>> -
>> -    if (!set)
>> -        return -EINVAL;
>> -
>> -    if (hot) {
>> -        memcpy(extlist[count], name, strlen(name));
>> -        sbi->raw_super->hot_ext_count = hot_count + 1;
>> -    } else {
>> -        char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
>> -
>> -        memcpy(buf, &extlist[cold_count],
>> -                F2FS_EXTENSION_LEN * hot_count);
>> -        memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
>> -        memcpy(extlist[cold_count], name, strlen(name));
>> -        memcpy(&extlist[cold_count + 1], buf,
>> -                F2FS_EXTENSION_LEN * hot_count);
>> -        sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
>> -    }
>> -    return 0;
>> -}
>> -
>> -static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
>> -                        const unsigned char *name)
>> -{
>> -    __u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
>> -    unsigned char (*noext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).noextensions;
>> -    unsigned char (*ext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).extensions;
>> -    unsigned char ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
>> -    unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
>> -    int i, cold_count, hot_count;
>> -
>> -    if (!f2fs_sb_has_compression(sbi) ||
>> -            F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
>> -            !f2fs_may_compress(inode) ||
>> -            (!ext_cnt && !noext_cnt))
>> -        return;
>> -
>> -    f2fs_down_read(&sbi->sb_lock);
>> -
>> -    cold_count = le32_to_cpu(sbi->raw_super->extension_count);
>> -    hot_count = sbi->raw_super->hot_ext_count;
>> -
>> -    for (i = cold_count; i < cold_count + hot_count; i++) {
>> -        if (is_extension_exist(name, extlist[i], false)) {
>> -            f2fs_up_read(&sbi->sb_lock);
>> -            return;
>> -        }
>> -    }
>> -
>> -    f2fs_up_read(&sbi->sb_lock);
>> -
>> -    for (i = 0; i < noext_cnt; i++) {
>> -        if (is_extension_exist(name, noext[i], false)) {
>> -            f2fs_disable_compressed_file(inode);
>> -            return;
>> -        }
>> -    }
>> -
>> -    if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
>> -        return;
>> -
>> -    for (i = 0; i < ext_cnt; i++) {
>> -        if (!is_extension_exist(name, ext[i], false))
>> -            continue;
>> -
>> -        /* Do not use inline_data with compression */
>> -        stat_dec_inline_inode(inode);
>> -        clear_inode_flag(inode, FI_INLINE_DATA);
>> -        set_compress_context(inode);
>> -        return;
>> -    }
>> -}
>> -
>>   static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
>>                  struct dentry *dentry, umode_t mode, bool excl)
>>   {
>> @@ -352,15 +346,13 @@ static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
>>       if (err)
>>           return err;
>> -    inode = f2fs_new_inode(mnt_userns, dir, mode);
>> +    inode = f2fs_new_inode(mnt_userns, dir, mode, dentry->d_name.name);
>>       if (IS_ERR(inode))
>>           return PTR_ERR(inode);
>>       if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
>>           set_file_temperature(sbi, inode, dentry->d_name.name);
>> -    set_compress_inode(sbi, inode, dentry->d_name.name);
>> -
>>       inode->i_op = &f2fs_file_inode_operations;
>>       inode->i_fop = &f2fs_file_operations;
>>       inode->i_mapping->a_ops = &f2fs_dblock_aops;
>> @@ -689,7 +681,7 @@ static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>       if (err)
>>           return err;
>> -    inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO);
>> +    inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO, NULL);
>>       if (IS_ERR(inode))
>>           return PTR_ERR(inode);
>> @@ -760,7 +752,8 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>       if (err)
>>           return err;
>> -    inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode);
>> +    inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode,
>> +                        dentry->d_name.name);
> 
> Why we need to pass directory's name to set_compress_new_inode()?
> 
> Could we just check S_IFDIR in child inode?
> 
> Thanks,
> 
>>       if (IS_ERR(inode))
>>           return PTR_ERR(inode);
>> @@ -817,7 +810,7 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>>       if (err)
>>           return err;
>> -    inode = f2fs_new_inode(mnt_userns, dir, mode);
>> +    inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>>       if (IS_ERR(inode))
>>           return PTR_ERR(inode);
>> @@ -856,7 +849,7 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
>>       if (err)
>>           return err;
>> -    inode = f2fs_new_inode(mnt_userns, dir, mode);
>> +    inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>>       if (IS_ERR(inode))
>>           return PTR_ERR(inode);
