Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2786239CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiKJCc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:32:25 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072.outbound.protection.outlook.com [40.107.117.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E941B4AB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:32:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE5L1bgJ6VDsDGKGQ6RF4k4PfDpH6l05HveGh2MUo94HaDqxc2Ugy5TMYact9YoTrwFFmpVYzDdlI9+ZqRoGYnygE/UTLcGmrCcnB6Ez5NacfzsVp72CIhwsPZpENLVwMygOea7pgw//76PgJHNT/E4mbnn7hi3KK2gYySqoIWJUKUqoHjPXKrvAOTCQYfxH4uS+fmKtaU9ARdgw6e4TLRrljsVf4cMt2y1QQB0b03GQ9/T7XlVCLzEhfCwDoo6HpZF4tDXPhKeYv3NlaUZ943LmtdW4cwR9hdd17lcB+QmUtM7hINg7F42nkbj4EpLQtbHmX+akXk/Nhcy4KAbHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUa8qLOqTuBEbSrfq+ZFzyIuKvGuKpept6jinQ3tA8g=;
 b=P0i2ksICQuiMxCELttRsdDIYPLNn0Cg8HP54lJMVZqY0L1sPgKPo0GiQvRjft96ZRhXfQaNM+Ca9Np2WSVX9jqdT6AxWPqbuaYeqMw7HxIcqlj8bq/aicxpvYqKrUSMCzQgiFX5QDhqjP0TMyV1iZnXMNbQb7zWE3VJZmi0x0f5vqs3bLAa11ppw1fLGKw87NgKvR67sg37Xv6VqpYrWeHmy1SmNKLRcyMTDx5KqPAsjZ7lcaOWUJC1O6shox2N8m0ikyZ0z0Zy1kLWpvxSWOW9FBwgCpuRfKGrEJQyUe4fXjSjOfIEgoMTXjg0P6kGModXiV1BRXY0N+NgwXzAhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUa8qLOqTuBEbSrfq+ZFzyIuKvGuKpept6jinQ3tA8g=;
 b=qRvdLbWWN6LYEEzA8zf0EM2/YY+jk23GPgVpTufckPOItZOuAClfSYMb2BRZJC03SIBPcJAYC+e7kwjq8hYN+46wvoyJfQUVag/nVMZ4ssylltJHdQ59PJ/wA1rLq2jxjzMg+BvV3tqL81iye7OGJb+c9RiB9R4beT61maQBTrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 SG2PR02MB4377.apcprd02.prod.outlook.com (2603:1096:0:8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12; Thu, 10 Nov 2022 02:32:17 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::31b6:afe9:43b5:aaca]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::31b6:afe9:43b5:aaca%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 02:32:17 +0000
Message-ID: <80630b6a-a7cf-be84-7f05-7b89a4a95757@oppo.com>
Date:   Thu, 10 Nov 2022 10:32:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] f2fs: fix to enable compress for newly created file if
 extension matches
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221109110148.3674340-1-shengyong@oppo.com>
 <2a474126-ae64-ac31-9ba4-8d6b68f31bd6@kernel.org>
From:   Sheng Yong <shengyong@oppo.com>
In-Reply-To: <2a474126-ae64-ac31-9ba4-8d6b68f31bd6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|SG2PR02MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0166c029-f354-4d35-0226-08dac2c3c8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmefBSNCQe5B/WarykxjhVygVLX3+l4fgm/Myc5D5rMj9QJJssoNhFh6tdKVJn65Rfa8DPZbqwDHKHZIraHYTbRGc+Spoh87z9MPzLAQ8qp0LWuenWtfjPhOdSZYW/9mrC1ZMI15xnSgyE1E92z+Mn0qiBZTYMXwD1x0VxJ4td/qrRVsjMTIJssLulmB6hTZxAHgQX2IPhZBnQ3G9nM/dzirXUJ0wE4joB2YH28I3AhUanG7h82S8vPibx/wsaJFiMtvzkuNA4dgz+2ADhibPa4ReJZBdQ8N2bksyl+xafV32JnOlXfkuEhtJEc5fgcLWgqfkoOPxpl0YMEzuWj+zwSrVmNKpRRsMrVHSu/sfrsgyN339OPFRGqfpup1I5EWu3ob2duhHEzja9cIeWzixJFQ2puNdv6Bo0MQrdbBr8VJnrkTu6Ro/Z0+KTLTXySbaH6smqW9wx/EBonTT1t5TzeyhKw4CxJQsV7dTIAXiMJJJPNwsmMJ4ycSiyqEKJj6OJpumY1Bt1XdFn98tirEF+xNw92yU3oO8SdZyya1LCU0D+nH+N6jQQ7oXXmKLIyIGsQWMKqZyOYe3BkCMv/5KyuPjJUkCUte5HUFrdSlBDr7AN0AVhq8Qhc0yb8lk6IbR0Ii09gA0kUEUCPto4+GUUXk0vA0Yvk6IDAJ4OiXsxuJClRM53sv+/kDVNX7EsFXbPOlzWyvv2D5h8kBaVglUg62RCPDxao+ot0M/aToYy6GXG1+V56wjq0dtKaad+9IC7io/E+qRalXe3Fp1xjj0Oj2HT339HWDmAaMi69tOK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(478600001)(2906002)(186003)(2616005)(66556008)(8676002)(66946007)(4326008)(66476007)(6506007)(53546011)(8936002)(5660300002)(26005)(6512007)(41300700001)(83380400001)(31686004)(38100700002)(31696002)(86362001)(6486002)(6666004)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2U4VEQ1ZzN1TE80TE9nOS9FSU1iMnd1Z3hrcHY3OTg0MTlOdXBVYVFEU1hT?=
 =?utf-8?B?RlNaT2lVRE1nNWp1YzhxbktZK3pwY0IxZE1NVWF5dnNmVGgvZXVTUEhUVUxt?=
 =?utf-8?B?NGFRVDVmc3k0R0lLeDZtK3NaRDFRV3Ftb1VmRHpuOUxBZXplVmcydFl4Y2Fh?=
 =?utf-8?B?SWtic2ErR1lZRjBpcWdVeHEwNmx1L3g0NlpoV3psOGRPOTI1SExhblR4bmhT?=
 =?utf-8?B?b01MSytMWVU3cERQSE8wd0wxd0FJclBmVS80UHdneEtETDFWck1icHhONHFV?=
 =?utf-8?B?L1FUdmY3cGJ4dHVDTCtQWHVJZVRVTXp0TXNXMjVXUXVXQlFtaW1BUmVQOGxu?=
 =?utf-8?B?dnZ0Ni8yUFNWSkU5UkdCaEFCZkt6WVp6Nm50Y1J4UjdFZGs3a3JhaDJWVC8v?=
 =?utf-8?B?QmE1ajQrUzUzSVFiQmx2V1B0WlA3QUJRUTZOcnZ6YXhVN1VGb2dVRXdkSG5C?=
 =?utf-8?B?WVduOHBvQUxQeUQ5QVhDMXNKYTd3RitoY1BwL2VaVkpmcHZaaVVnbWdnY0Mz?=
 =?utf-8?B?Q211TUNReG9LRnhNenBRdlJ6RDZ6MW5Zc3R5QWExTDhQSW5oTkRySWtmaC9w?=
 =?utf-8?B?OTdiemFVblFneTY5aWpjQXc2bWZrK1NhYmJjYWJLOWRscW5wSUNzSVIxdUtr?=
 =?utf-8?B?RXovZlhLNEhRUDl2OEw2TkhjQmo2M3pDQjNMVVdTaFpoV3VIVEJ2cDVpL1Bv?=
 =?utf-8?B?S25sWUxSK2M4bXF6akVtbUppbkljVGF2OCtaNXhmUU5jdW90dGZsakZuQkcr?=
 =?utf-8?B?SFhFMlhFZ2JPZTVkM2dtMk9iRGdWYjdZVm52QVI4M3c4dGIxZ0lVT00vNWVv?=
 =?utf-8?B?RlVNL3owa1VmUlNIdWV6blRmbGgrNmc0cVY1NnpoT2gvNVlQSERUT1lUQTk5?=
 =?utf-8?B?Y2IwOEh1MEFPRk5tZCt2cFhaU25ISWlhcTlNdURsaTNQcGhzT01DQmtTWDR6?=
 =?utf-8?B?c0I0eFFHZzlleUxsdzRpL1BPdmNQL0J4T0oxSms2WElkbk1la2ptMzJGRFFt?=
 =?utf-8?B?TVdEbUlUQ0tuM2oyNFVNaVhubmRsZnZCMXBSMmI0cThac0dIWWxxa1ZUUWdD?=
 =?utf-8?B?MjdLeEdiUXBGKzZHYkZvWVFvb3VCTjRwbThpWXdBZ0hHWmh6eEdaSm9Da3ZJ?=
 =?utf-8?B?WWt0dS93bk1HMzZISXM3d3RHNHMzWTd4ZitNMlBjdkVtdjEvSE5yU0Jndm9S?=
 =?utf-8?B?R2ZBYnpTbkcvWExoK1RsdER0cUNXZmgrSWFHU1IzZFlSQ3FEL2pPcXhjRkdj?=
 =?utf-8?B?YWNLa085bFZkcnNUeFNRdHVGMGVkMDBWby96ZFl3NjAwUitvUml0VDBZaElU?=
 =?utf-8?B?Ry9kdFd2NjlPOGpCMXpjNFoyQ2pWTjBXUEhaVCs0a2VURktCUEwrQjB0YnFk?=
 =?utf-8?B?RmNSRE81V2xvd2t4T0lDdlZvbkxIZ2lLK2dhYktPckNYc1N4cXQwZzJWMXUw?=
 =?utf-8?B?eEMrRXlncUNSRUs4Vk9iZ1BJdkkwODZ3bHN6VkY4eFNMeS9oMzhKNW1YVWdo?=
 =?utf-8?B?bVNHcFlQcEJ3V3QwUUhYZSthUkNCSHJCekFhaGpEOEJvaUxlcjRCaXBtYllO?=
 =?utf-8?B?eU9tN3IrWmxEMWNHY1lCN0FvRlplWmQyUUh2VUtaUDJPcHliZHd5TkdHSi9v?=
 =?utf-8?B?b2VVc1ZjSXAvR09iRlk3R2JUOEVIdXdsdU1PS0JRNHVFS1h0eUw3bDNpbldt?=
 =?utf-8?B?cXdMZHpGc0lFWVlnbFFPU1ozK2krTGlncnJIalV2dTRJWnRuZ2MrNHdJbDVG?=
 =?utf-8?B?c25tVzVmWkQwbGMwTWpGNW1nYkZ1bEhQWDFiNjlHTE8ydGRrWlRHbVlmQ0tR?=
 =?utf-8?B?c0tNY0g5bVRIMDZZRXJ3dXZJR01sU2VwT0prcUpSRWJxdkpDeDhwcVFsR1h2?=
 =?utf-8?B?NGZaZW8zY3RoMGZySmV6ci84azVtaHBWbnNhU0NNakp2b3BDcnVmK2VwMWt0?=
 =?utf-8?B?NmI0WHo0UlBqRFRsYm8vV1lNemp0dGNUa0lNRW80Und5TnBVWTZxQ1dFbzFl?=
 =?utf-8?B?SDhCYThQcWZTTHFjRXkwc29HT1JUa2Vyci9DUnduRW05bHFHMzgxcHB3OTNz?=
 =?utf-8?B?Z2FyYVJ5dmhldklyd1JMUEdud2Zybm1pTzhoR3pKVmRaUlZBNmVMQkw1dllh?=
 =?utf-8?Q?1JIPqW6gViSfXndh83nDimhsS?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0166c029-f354-4d35-0226-08dac2c3c8ea
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 02:32:17.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGoa5VT6t5XQIsXdUgEAPT7XhV6roUbg2O4MyZRtTHL2SsTm8Vyzr87U1QmRpqxnzUuUSlVIJpaVd8d/mRa2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/9 21:57, Chao Yu 写道:
> On 2022/11/9 19:01, Sheng Yong wrote:
>> If compress_extension is set, and a newly created file matches the
>> extension, the file could be marked as compression file. However,
>> if inline_data is also enabled, there is no chance to check its
>> extension since f2fs_should_compress() always returns false.
>>
>> So if a new file is created (its inode has I_NEW flag and must have
>> no pin/atomic/swap flag), instead of calling f2fs_should_compress(),
>> checking its file type is enough here.
>>
>> Signed-off-by: Sheng Yong <shengyong@oppo.com>
>> ---
>>   fs/f2fs/namei.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index e104409c3a0e5..99dbd051ae0ba 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -295,9 +295,14 @@ static void set_compress_inode(struct 
>> f2fs_sb_info *sbi, struct inode *inode,
>>
>>          if (!f2fs_sb_has_compression(sbi) ||
>>                          F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
>> -                       !f2fs_may_compress(inode) ||
>>                          (!ext_cnt && !noext_cnt))
>>                  return;
>> +       if (inode->i_state & I_NEW) {
>> +               if (!S_ISREG(inode->i_mode))
>> +                       return;
>> +       } else if (!f2fs_may_compress(inode)) {
>> +               return;
>> +       }
> 
> How about moving set_compress_inode() into f2fs_new_inode()?

Hi, Chao

I prefer not to move it. Because set_compress_inode() needs 
dentry->d_name as a parameter, but dentry is not passed to 
f2fs_new_inode(). I think that's why it was called outside of 
f2fs_new_inode() in the first place.

thanks,
shengyong

> 
>      if (f2fs_sb_has_compression(sbi)) {
>          /* Inherit the compression flag in directory */
>          if ((F2FS_I(dir)->i_flags & F2FS_COMPR_FL) &&
>                      f2fs_may_compress(inode))
>              set_compress_context(inode);
> 
>          set_compress_inode(sbi, inode, name);
>      }
> 
>      /* Should enable inline_data after compression set */
>      if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>          set_inode_flag(inode, FI_INLINE_DATA);
> 
>>
>>          f2fs_down_read(&sbi->sb_lock);
>>
>> -- 
>> 2.25.1
