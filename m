Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E401C6F0678
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbjD0NPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbjD0NO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:14:56 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193C230C5;
        Thu, 27 Apr 2023 06:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZw881v9/xiLzNzBw/7PZuRmTK5PsSOod8hcop7bowmH3Zhc2N696fHtSJedf+rNNJnWd3KpNl3WO1eqRItomxADo5iSquiEkDtNC7u/SZVJ02LK98BhYIZsP1B3mz4TbvWoKs8NLO2BxT+jclE/dg2OSzJlrK8VFMRNv98FbXyFbSalj9PajTZb21ivXgjs/A4ycqVi0WFLB9+5MNHP+YW7gnIKznN6EwtHbksD96R9PBKfuZxCK6bC1uVDeNgrxyHxDmUP6zLf5iqJTEAHaabx5fcsuwJzKv1JdfMQswUZvWBm6Y51bKlFPghrajuTi9SXKb7dbdj14e7USQpifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkKGo0LyeBuj4vrGsnB28TQxykkBNhi7SfGGl9o8HkM=;
 b=RKWELU0lBYYSZ5OBDdVFucpqpJEEqxncVxLQIpqMoBbQ5a0kle87f1KpBYhRQjTE27NSCOtD9R8ejIstMLsyhnORzJYWAXmpAX8jrtyAEidKH+d9aXNYfd0npR5jf6UYKQD2Lu6nJyOLf1b2vDoy4QKfY6ulkTY75QcTXt1jg1C24lXOHwkRvMXTF4e6wGk/dPdvWGhwlgejErgi40RDEDWFbquewX8TMwA6iNJGdDLi4dxxE/sOqYfPAtmszDcfLwQdGRcaIX2pSShwEgXT4+Pux5Rn/L/Zcm9I+op9qnBcfDUXrgC6GOBrUnuqwcxCCGFrFqdzUtdMXoyCEE+I5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkKGo0LyeBuj4vrGsnB28TQxykkBNhi7SfGGl9o8HkM=;
 b=zuyusLjhuHrXHObNam7GszKbUKAV+hu8VYKJ3ibHDMLK2+mEJDagu4SYHTbwJL2ABn2RpC7dwxGzhYTeDQPVyFB/h6hqQpbmF+w1JSsr6/ozJ9MZk9UGwRNgCgMvVpYCJGuVox3rp2plIxJIWmpCexp1KgCWQJNTqQK5G9yioDYwrvStLUOVx4Ylporxg8y3glnFbuy7b8VUif1Ug5Fzlase1IftBdJrO9jrxjq50Tw9ZFDTz9cAVRjuREW06PaxTBNSPpBt2TWbYTvD0IuFbvkMSP1w5P04f9wDJx9i4fjAq5zlfQYuQuvNOUPfXtQWSmTj9CIuJwi6koIvt/9yQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 13:14:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 13:14:52 +0000
Message-ID: <19641ab0-ab6a-9af7-8c64-34030e187848@siemens.com>
Date:   Thu, 27 Apr 2023 15:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <87pm7qxrg6.ffs@tglx>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87pm7qxrg6.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 8434fe55-bc6f-4114-c3ff-08db47216311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4koE9VXe8+FCi/uADpugeqNHQ3pcvEy0W+T4bdLtDWP0+3Co2dgv8cCWlBWGYUJMbk8S8Bd5MyLu+FFTSCmgrQsrtlHIdTCMm3jA7xscrfMvFokxuJmCPN7Gx6zOJx4dUfSYDdAEvBqtO2DMEtjNlGbssikeFvcQKF0LheZuTKaL2sspR92NYIo1pdu8C/zYUjgNOZqspJwql+4ZDLIIkrvzUo2LA7cMEBHKkR3PVko5ZSEU7HTLJT0v3oqjLLvw/ntE9WZXbLS4utU+v2K74wT5zoJ7Ve9LLwv5Ok2mE3eWNUqOIw+dK5Kfoo/KKCrQdsk+Tf/nhE6mu/H9K9grlUMr7I+D85ihrco6U/QsPkmyjZe1As/vbgs3N6J1RRPr89yzcs4cOTID5hyM6hEflKvjO5oI1TZzGPhXZEfMuB5orGiElGA3+3knuVw/yYJRXeRe0oWOcSSOOAAmXriOMtXxWfo7o1MtsIhzfa59UwBYJsOkrtPdOhTgXGeSiVo8LhVqltJy1ovqK5GgxDk7A1oIxX6dYcj1gH52G2L5ODfvmD59orZ6GmaqqAAoNC8rafhgzqIP+2aF9dBbT1XYRitzk10MvEJWUfQ740bxB41IK6UIaVbHYtV/Y+mclm1SctWI3XwP7uISeT+PNk73Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(6506007)(26005)(186003)(6512007)(8676002)(53546011)(6486002)(6666004)(8936002)(110136005)(86362001)(4326008)(316002)(82960400001)(5660300002)(31696002)(44832011)(38100700002)(66476007)(66556008)(66946007)(83380400001)(2616005)(2906002)(36756003)(478600001)(54906003)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjB1MmJiYVkxbHlNQXAzTUU4SGpNdWJmTlRVZ2hwb3lLQ2pFRGp1ZFVvVSt5?=
 =?utf-8?B?a3NPdHNoTDNQcExIRjRzYXFPeFgrdlZwaEZscEJPaDk3REtHZjlBa2lSVnhO?=
 =?utf-8?B?Skhwa0Q5disrVHBBRnRBZ201dEV6RElIQk1uZFRrQ1d3RU9qb1QzQm9CNTM5?=
 =?utf-8?B?dzBiZDBpejMyZlJWa2o2VHBNU1pPUFgxOWF3dWhmZ2hzeG1QdnBjbHBLVi9X?=
 =?utf-8?B?VmJBcVdaWkl6Vnd5dEYrM29uM09TZEwzTWozL25qdmdvMGhUMnJDZkVWenNB?=
 =?utf-8?B?cWwyaHJYbEdDS1lrVW1qTEhZY0E1Zk1LaU5IM29GbVlvWWN0UHFPZVJ2SlZJ?=
 =?utf-8?B?UWNhWTd4d2szM2ViTXJqOThnY1BRbHBJamxacnBpUkN1ZG9YbmcvbngxSmgw?=
 =?utf-8?B?Q28rdmZUMHFmUmRhNzR0MExNN3FRd04zNWw5MlZDNHN6YTFvcFNkT3A4dUlp?=
 =?utf-8?B?bUhsVUdpTVNlRFpVQWR3TGNBNUZRd1Z5SHNQMEs3ek41eVdwMnRCaFFhc2lu?=
 =?utf-8?B?ZnYyKzZGUGx6WDdvQk9BSFFhSS9NcGhQQVd4K3VoRTdrRll6b2M2bCs1eEFU?=
 =?utf-8?B?UU8vTjhXdW9uMVZCNy9ETkIzekhzbWhIaTVxaW53ZkM1Qy9DUWNOeUJKRW93?=
 =?utf-8?B?M1JzVG5lWEh4VW11MXlHZWxZL0tBRzF5UUViUzliUGdwWDZVQjhwNWwzYjNY?=
 =?utf-8?B?Q0FFZUtDRGNsNVpjOGI5Y29hRFB1bG5FbTExV1ZHMUhONURTNWxJdGNJdVdo?=
 =?utf-8?B?QXl1S3dNUVdudWRiTTR5UjlUMnBMTkczajFJS1J1M21qMTdDdS9VVTc0R2s3?=
 =?utf-8?B?NTB6bXJyNFVNREhiRUptTG1rNk5jOEMzb1FTbG9VMEZONmNrMkRUbm9qMFp4?=
 =?utf-8?B?Vy9rUmRSQkpBeW5UMkovb0lvVGUxZDZLWUt3dmxBd285dWRGSzV6Tk51QmVr?=
 =?utf-8?B?aWFuRUpaT2VSMHVpY1Q0U1V4aWJVUnhpb1ZQaWlQMVAwSFlqVFJlTzZXSitR?=
 =?utf-8?B?RUFVNzVnRFoxWHh0b2J5Z2hWTWo1TytHMkVDV3ZMU1BGWFM0eGhzSWhTU0ly?=
 =?utf-8?B?VWxjTUg4MjRuQ1ppaElGczl1ei90cWFCcUVTdmdUTTRXQXZGUi8va2pkQ2Nh?=
 =?utf-8?B?SkVxNFpRa09iNVMvT3VJS0VtaUhFN1VZeUZCVUUxQm0rNGZER2FPRWFneGlB?=
 =?utf-8?B?d1pGK0I5aTlvVnFzTmd6dDlEbXVkYWowQlJXamxCRFJtaGdUaXhZb0dOcXVG?=
 =?utf-8?B?czRxeE9pWXQwbk9uM3ZlUkl4R3lNelJwaGFPZkE3Tm9yVUhTM21DZW9ENHR3?=
 =?utf-8?B?SXZ6ZGg4YmZyc2lJUGlIZW1teGtJRzF4enBaek1FaHNwUGJhbWRFWStEZVc3?=
 =?utf-8?B?NzdNWDdoL0liSFdFZGRFcjByU0F2MnlxdUpYQWZDU0M5QlJVNUFnZEU2VHlX?=
 =?utf-8?B?UEttRm8wSURobUh2WG91amtnbTk1dDhoUjNRYzBsT0JGaHdFa0tsd1I0MTNt?=
 =?utf-8?B?cURJMFdlMy83dUVLL1BWanFyeWJXNzZUZzdiQVpNM1RWeHZzU2NPYklXYnk1?=
 =?utf-8?B?K1QrZDJLU2hQVkZyVGM0Y3JTTE9ualQ2WVIrem9CbzYyTFFoZGdNamU0cDhi?=
 =?utf-8?B?K2xYNTVMcFJVdFZwTzI5RDhteDdmeFp0WGZFQjh4b3JiUVJQTHpyQ1V0LzJr?=
 =?utf-8?B?RkZzYWQ4Z1BnU09zT21RTUNSeXhiOU0zOEc3T2w0S3k1aGJ1dXlDdnBRY0dj?=
 =?utf-8?B?bUNMRGd0d1ZWbGRNWWNJMUZjZ1FZRTE4YTFsbGZOZEE5TDBkWlMwejFnSXNM?=
 =?utf-8?B?VU0vbWo4QUtlemFHWjdEWGdTOHkwVXlJNy9yKzBUL3lkOHhzUDJ3bXl0TFQ2?=
 =?utf-8?B?MktGWktwNjFSV3BWNzNhSmU1cUk2ZThRWm9VZTY5dW5YSDVDQko1dVRtdE9C?=
 =?utf-8?B?eWE0QUVJb0xxeG05aWY4OHZCL3AwSE5TTW9YdzFlT2VCMHhSbytOZk1pRTZl?=
 =?utf-8?B?UXFUdFlNSWhiWGp6b0cyTkJjam5UYmljc0h5K3djK056MEtud3VmNytRVnU0?=
 =?utf-8?B?SDZjN0V6Wis1QlM1cG83Z2lQRFk5ZXZSL3cwcG9vR2d4MUNLQ296NXVrby8w?=
 =?utf-8?Q?4gC3sQmpez/qwQ+kDMhJTT/jE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8434fe55-bc6f-4114-c3ff-08db47216311
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 13:14:52.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhmQWfdJp0MApBBIF/p+KV59qcRMo/ULxVlLt3uJkFKSLGxh/LhkJz1FqH4+/n958gle4h8xdEFLhmn7CS073A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6228
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.23 23:29, Thomas Gleixner wrote:
> On Wed, Apr 26 2023 at 12:03, Zdenek Bouska wrote:
>> following patch is my current approach for fixing this issue. I introduced
>> big_cpu_relax(), which uses Will's implementation [1] on ARM64 without
>> LSE atomics and original cpu_relax() on any other CPU.
> 
> Why is this interrupt handling specific? Just because it's the place
> where you observed it?
> 
> That's a general issue for any code which uses atomics for forward
> progress. LL/SC simply does not guarantee that.
> 
> So if that helps, then this needs to be addressed globaly and not with
> some crude hack in the interrupt handling code.

My impression is that the retry loop of irq_finalize_oneshot is
particularly susceptible to that issue due to the high acquire/relax
pressure and inter-dependency between holder and waiter it generates -
which does not mean it cannot occur in other places.

Are we aware of other concrete case where it bites? Even with just
"normal" contented spin_lock usage?

> 
>> Anyone has a better idea how to solve this issue properly?
> 
> Use hardware with LSE atomics :)

That would generate tons of waste of current electronic devices without
it - not very fashionable anymore. ;)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

