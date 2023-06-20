Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C338736198
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFTCnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFTCnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:43:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA510C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 19:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F++ibHFleDW5bV6Ij9lrUIxPbajWYzk7ePCNFjjlr4bIQOSe9y++/1guFa+XG2JESu3t675Tos4C0d3fy94TJ/pT3UO+o51f6+13DuHy6O3tMxfQIZ9/sPnMaYwZ8lIxag6jOPHlNGPVIiD5Xm5CU/7Rh8SB81i7MN2SRU2ZfOOJ3U4lkKrN7D+ziSp1muok3T7y/XpXJ+CuwEQ4hjiEw8sKzIQs7cUytM2RG/o7UybkCbQuP2YurdnSdiI81eqH9jTFvavG/MmbFLxLlzVCeA9C4+ogxhJ3SYglMu/idGhAisVJcrV7o91JbqzJohHbfLSUoVxCZQj6ORb6EpBEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpVY2bCv38IJ/JQIOCgVXORDts9fIMbcLpQg9PARO7c=;
 b=PYBB9VfmN+q0eUEf0CY1B5Y0dTwEuXVRmp5i8Hw+RpSaFQgU6CgeoWsqMi9v1F6PCHFGcKoy2Kk4jWCkHJJZk6qNMN9LbI9/eMXsUrdRGd6XKi3+7jdAnam/oUj9aN2Fb+rNWK6wa+RUYC4w0NtzxEQ+PveEYrU8pNePaEc7zOBPaFpNA4yb6YlgieEQVYWpZ+e74cLwAmViGubMsOrXH6JX9ZrBEWo1ZzPX8JEVt0kKiZ5wkqOLIOw9xmMGxdwsgbc+z3Jxm/ljEBpSt/OC9apdIA8Pafr6gdzDevdiPcdQzyVY0QeVM9RsDKiEybnPAdOyqHTF5gmggNyTw4+b8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpVY2bCv38IJ/JQIOCgVXORDts9fIMbcLpQg9PARO7c=;
 b=FFv5CSrWcDGfKdEciluMPeC0oRa9YnQe4LkCJkYcddabcCZMdCeerFZ+DBSygB4QkFJi9pAmmwK9+hVidC/844J6RLMZDhBquP6MGqiYBcxJ7WtmTOHMtawMrK6sFBHBlNp9d89tYtQW2zEsFpNQzXqLNX0YSPDktCGMz+estyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
 by KL1PR02MB4499.apcprd02.prod.outlook.com (2603:1096:820:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 02:42:58 +0000
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb]) by TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb%4]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 02:42:58 +0000
Message-ID: <6c527e97-c4a6-dc58-13fb-516f77e5e068@oppo.com>
Date:   Tue, 20 Jun 2023 10:42:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev][PATCH] f2fs: not allowed to set file both cold and hot
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613085250.3648491-1-heyunlei@oppo.com>
 <b8523d41-246b-b11e-f6e3-423e32cc597a@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?5L2V5LqR6JW+KFl1bmxlaSBoZSk=?= <heyunlei@oppo.com>
In-Reply-To: <b8523d41-246b-b11e-f6e3-423e32cc597a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To TY2PR02MB4479.apcprd02.prod.outlook.com
 (2603:1096:404:800e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR02MB4479:EE_|KL1PR02MB4499:EE_
X-MS-Office365-Filtering-Correlation-Id: c399f8a6-4702-44d0-ebd5-08db71380ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuWtnUym1vxEhu35WVm1R65JoeaFaOxbOaNCvr1oc0WuXnyzbeQ0oWiJ8zIU0GWRpOPajUv4Q100KdTKFzbWXHz7u5cAuTcKh4rsI6CkG5LQN1Efq8EGO7LFZ3s3WstgxFN3IFD2EgHQxK2KwQQV4a9bHJZiQqRHWMEQHu5BOK4LUDqvUuinxxR2tg8HkrdMTQPA8HHGCeNxnMdd204wq2QHeleOn8St1jvb5aRiDYT3lDLY1g+2giSMvg6FU8B4qdnOdahu7/8Cezl03b/GQX15IOr0utujKhMyNHisoDpyTKiLQINAbxsG+UzwZVFxaX6w78/OKTQqJ1BClFfIIvdakr24B/y604WMJboihZ5mU0raS+2ohqedl+Q/imm1stEKlLfytrJlS+1nKX+qN6iQnhOzsgEPoAjPFFwvxSdewvDm8Ytsfoug5fv+ymL/+ioaFvfrW68m9a5o2QQnqDSmpf160vpy4wV7Nu+JaikHvBfCcMtAFU6VDHWN0+ShHMG9aQSNn8/xs+lWNONmfASDTu2qLQQKBV2apHAlLrZ0+2S15NeIlWQf8fSZ5a8umFAnjCGRMoSn+Cn/llQiLNogANJ+UDEN9WImyMMKTBFPzLdTEz22Owc+LSLbxx4qdmSAqjZZpYWMEIjX6XIiRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4479.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(8936002)(66556008)(66946007)(8676002)(186003)(66476007)(5660300002)(6666004)(6486002)(316002)(38100700002)(478600001)(85182001)(41300700001)(36756003)(4326008)(26005)(6506007)(53546011)(6512007)(31686004)(2906002)(31696002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCsvV0IxZWIzWXdjNnhORWkzSGloUW4xVC9sTE56N3daNWtWb0RjL0dkRXo5?=
 =?utf-8?B?eitFL3o1SnJzUy9jVWMzRzlhOWZXL1dOTVJBYTFkc2NRM1VickxKWmVxZXdF?=
 =?utf-8?B?cGc1cjlUMkFtTXU2ejdnc3o4YlRpMHB1TVAzc0drakRqM3krR3pLZWQ1SHF4?=
 =?utf-8?B?amF2SDhEclFkMWI4bi80MlA1S0JLdU5HMGxLdHFEV1RrWjVtZDlwYzc5ZDhS?=
 =?utf-8?B?eWhtNDNlS2tDb1U2cnZhcUNveUZLYlR0am5pOGdJMk5zNEhLRFJ1NXkwNTZY?=
 =?utf-8?B?RnZoNWxBUEpWdHo3NFF6RFZzK0x1N0JudVpKdUFKSytzdWJuak1WdkUvY21q?=
 =?utf-8?B?dmpFNWNtelowQkE1TUJRYkFRS2tXTHp1a3NIVDlOMU5qSlczeHgzWTNBOGFO?=
 =?utf-8?B?VU50bDlWRmU4L2pFSXB3YUM5ZGV2OEZGNUJSMm4xa1lLY3Q3UURMZWYxOVVE?=
 =?utf-8?B?U3RMOFBPd2R1TGNyRnFwS2gzckU2VXZ6VHJPOUl1Vng1UHJvZGpFcXhzVHJw?=
 =?utf-8?B?djBTVEZsWEE4OUgzNElzZUR2QldJdmNKYmVWRklkdVNEK1VEb3lrWHVuc3NV?=
 =?utf-8?B?cGRDb25vNWYvRFVsa1ZVUlpIb25pRjFKQ09DTnI0eTBBcWZqY2tGdFh2U2Z3?=
 =?utf-8?B?WjRjazd3ZlNET0xxUHNydUpISWcxTkRmMTF3U2VpWFh4RXVKWXpLQm9vNWRt?=
 =?utf-8?B?eHhTSThhK0tCQ3RlL3RIRldBWHpTL0JiRlYwcEo0c3JQdmdXK2FObU9paXRv?=
 =?utf-8?B?eUM2UDk4Vnc0NkdQSzlUbU1kN092MGE1VjZHNFdtWmdQTHozRDJ1WnVJTjJk?=
 =?utf-8?B?QUl2UlVaSjdQVGI3dlB0WG5naUVnMS9hcGU5Y2Q4YnFPc2RCMDNwejZ5c2tk?=
 =?utf-8?B?S2pJdmloR0FFRkEweXZoWVpFSjViVlRRanc0dWJOWmRvMktzMmhIT0hkT1kr?=
 =?utf-8?B?VXYzMldRaFhWNXBQUS9nVXpRWHJ0OEdJNnJHWWxkbkpJb3dHOHhWRm1EWnhj?=
 =?utf-8?B?bEZPUzd1Y0Nmaks5N255K0V0R0wxbkJCaE5ya3RKZDROK1JtU3ExdDRQR3Bu?=
 =?utf-8?B?NEl1Zlczb0t2VGVkays1TGUwUHB2SW1qRlZNOExHSTErdmppaDU3MCs5SUo2?=
 =?utf-8?B?Rjh6eWdodUhFWkFCbnFJUjZyb1B0WTZNbXFWOFZnNWx4ZklZUjByaWdPdjRI?=
 =?utf-8?B?ZDlQZ0s3bzl4VmlybHFKY0JrYzdoZlZRSTg0ME14aHFSYXBFWGMvMFBDTnpi?=
 =?utf-8?B?TEpqKzM5dis4S0JHZURpNUpGclA0V2NqbkpSSTA2RTdNS0g1ZStUSTlkb1JS?=
 =?utf-8?B?V0s0WVNIZnJmOS9QWVIwZWdsRHVNQmQ1UjVVWVZJY1Z0VnUyRmp1Ums5ZlZO?=
 =?utf-8?B?TUoxZ21NM2pqWmdOYjMzVWZvZHBad1B0emhGcGJoRFVodjFrcTB0RlpFakZH?=
 =?utf-8?B?aXMySkxiVW1ZcGlxOUdsVnQ3TzFPTUM3M1hRZFd5N0VHa2tmaWkrTy9od01J?=
 =?utf-8?B?bXA0NGxKbXhhTUdjRjI1UnhLTTZWRDh1UXl6VUk3UkdyS0dLS3dwQ3RqSCs2?=
 =?utf-8?B?RmNRbUpjc0dWTnlRd2crMkc0cGZPUmZJSGVJZnkxRzlUWEV4cnRPYmh0Zk5X?=
 =?utf-8?B?NTg0NDJKWElRTlIzbFlwMGF3bFIzV3Jma2VWbGxwK2FTMHk4WEdGZms5aG8z?=
 =?utf-8?B?cnhGSlVaVXk0UWJQUU9kdW00RkIyWXRaQVZiUUI0NDdvUG9VenUvZDlqYzVY?=
 =?utf-8?B?VnVPMnRGeGJmcWhEL3hZdDJKVXBQMzRlYTdUdEFaVS93ajBVTzI3bGdoV2NZ?=
 =?utf-8?B?M3d0Z2k5SkRuVDI4aHBPUGEwcjVuMUZMYkErdEVpR2xIczR0bnJ3a21kS3hJ?=
 =?utf-8?B?ZDZGM015cnBDbGluN2JHK25uWHJxbUptQmErUnpNUm82KzM1eDlicDRJUDhy?=
 =?utf-8?B?bk9ta1FuQ01FbzNMT2dKYXp1cndYbFp2TFFhMVAyT2wvcEsxWEYzZ3gvSGRF?=
 =?utf-8?B?ZFp1UDFXN01qajdjM3VCa3owWG9mWnhOY0lWejNSV3pSZGczNk1maHV5ak9T?=
 =?utf-8?B?MlZFdjFMMHRzajVvcVlhS2h5QjlUWmFjSjlKa1dkNEl1dnd6cU55eXZBSDRE?=
 =?utf-8?Q?p4s6OgjYgPywud4y665zDlqD5?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c399f8a6-4702-44d0-ebd5-08db71380ee8
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4479.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 02:42:58.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzyJiKJZnv005Rp4hSK3WC/1WLENzRVBCc/hjuGECn24FC3jqdRq3TUWCjhvMvmYfDOM3jWMzQ3NUtyZOcMuJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4499
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/20 8:33, Chao Yu wrote:
> On 2023/6/13 16:52, Yunlei He wrote:
>> File set both cold and hot advise bit is confusion, so
>> return EINVAL to avoid this case.
>>
>> Signed-off-by: Yunlei He <heyunlei@oppo.com>
>> ---
>>   fs/f2fs/xattr.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index 213805d3592c..917f3ac9f1a1 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -127,6 +127,9 @@ static int f2fs_xattr_advise_set(const struct 
>> xattr_handler *handler,
>>                  return -EINVAL;
>>
>>          new_advise = new_advise & FADVISE_MODIFIABLE_BITS;
>> +       if ((new_advise & FADVISE_COLD_BIT) && (new_advise & 
>> FADVISE_HOT_BIT))
>> +               return -EINVAL;
>
> Yunlei,
>
> What about the below case:
>
> 1. f2fs_xattr_advise_set(FADVISE_COLD_BIT)
> 2. f2fs_xattr_advise_set(FADVISE_HOT_BIT)

Hi,  Chao,

     I test this case work well with this patch,  case below will return 
-EINVAL:

     f2fs_xattr_advise_set(FADVISE_COLD_BIT | FADVISE_HOT_BIT)

Thanks,

>
> Thanks,
>
>> +
>>          new_advise |= old_advise & ~FADVISE_MODIFIABLE_BITS;
>>
>>          F2FS_I(inode)->i_advise = new_advise;
>> -- 
