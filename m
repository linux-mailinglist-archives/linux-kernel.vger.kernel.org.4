Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403E96E3DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDQDS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjDQDSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:18:17 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2147.outbound.protection.outlook.com [40.92.63.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A8D2D45
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkGsG6xE9ZpBTtyeXHrtFBJUln7LCiVDYGStA4c6m5kT1/pBeHNFOKU83Wv9a6qLfoYPIW6/Y6inKzeywex6hwDasI9IgmO1p6/WDn2p1HlRB4O8b5S2gHrLzoocRtNuM1HAEzXAfkFHZybNgPw479RQHl3CFWC6/9a5faVFNP5KeNWPPdxSepvzu/5TSBsMVXnp/nYrsDt8SQN3IY7YVpns5qwhM9g5W85Wsag/59I/wb9QZcDxyumwY7udEJocrzTKgZit5z9a4chTQlhnRSqi6xLzqDQGuoj/QNUJDy2tdqVJWkL1cZFQBIu68YDmfwG68YKJu3y8/9LOOXJHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtU52+8Ml/NVyMLJsENihOiydLt0lB9Ijr20IdgNyKk=;
 b=HA6Wj/+pWGMM16NtIV3CsykFj4TkOzVbGyLe0p4oQvgIkjh3zgCtsnys0+qexyJuIhPgH6posuYwtip5w8RZ4l68fdcXLbT0nlwNf44nJkz8+sisRKuFRlBweo+6ybTquujdqZ6g/e8WX8PH2RIpevtrPHxYquhXP/m4sF105VaAgHdljM0mXFuZWDz7MMd3lSSx1b2K2tn+MShJt5PfQCcMXX386U/6BM+aqHCkGHPsbcO8UpQaw0z0lOD1LUfczWRrzAXvcw8hICuHoZQfJNYYVYpmhHWyOIg8A5fQCmuGhW0BcIIS2P1pb3/jxhkAgo5gI7F/5aV5wg14HfDb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtU52+8Ml/NVyMLJsENihOiydLt0lB9Ijr20IdgNyKk=;
 b=Wcpm9m9Kyb7RqDS8+UuGfZwRNIY8QIZ+bD5mxZmhNn/+IBVS0lzyGGaCvb9+kH7HznRDi86B0UAuAbCOUmeew+8XTEeqHiCNdAL1zGY7bQrL7OYXiMpn8Zx/vqHbu23jwp3ofraURC4r/lvmp5avFZ3j8uQRVr4bkQ0VfHpWxnxDJfpemOTB7yOWjVxCp9vJazFQbqMJ1b1mr243R+CfBvhUPsPWGzO4Ltun5qTK6CxMwxqJfA6xbbXfG1cKyab0LU2zzra4NBamBdwsNvdZsGfITi0OntZpeXAEynP7aUL7YVVG4NSwPeJ76hc18TGxSg0lENwi+8TidvhOHXVT5w==
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b5::14)
 by ME4P282MB0790.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.19; Mon, 17 Apr
 2023 03:18:02 +0000
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::af21:6d94:5bd2:d541]) by SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::af21:6d94:5bd2:d541%4]) with mapi id 15.20.6319.017; Mon, 17 Apr 2023
 03:18:02 +0000
Message-ID: <SY4P282MB351877A70A0333C790FE85A5C09C9@SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM>
Date:   Mon, 17 Apr 2023 11:17:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/4] Add uprobes support for LoongArch
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <1681464781-4428-1-git-send-email-yangtiezhu@loongson.cn>
From:   Hengqi Chen <chenhengqi@outlook.com>
In-Reply-To: <1681464781-4428-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [IlO4hasPRYrlsLRgIj+3H5nERvSpI83+]
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1b5::14)
X-Microsoft-Original-Message-ID: <801da376-3aeb-946d-123a-8d4ac143f5f0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3518:EE_|ME4P282MB0790:EE_
X-MS-Office365-Filtering-Correlation-Id: f4615de7-7d76-4a95-37da-08db3ef25a16
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDCqrliWPM+QYJrKHZQMZVUP9mksbsscXBvdqWI+IiUGLhxhmEY+5ERDntI6aSLpCrmBXmCRDqkAanjyW2fgThMkeNw6Uv368HXVW5UKT605hKmUKscEwbidxKQNbFKAZwsCUndhuWMd6sax64N4KTSu7FS4S2GAUFmg5KmoH9AxAH4Jto4oIbp9XBS4pFo5K51Ep/hxhNsxb2Jw+5E0ICLVBjC3eQALsXusnO2Uq/fGRFhyg5xAzLxFgO3RZY4VddA7EcuLRERrJX5LzzDw81i6kqTMXfexrSJhBSWfvnoM3LtXcBWfLQ2TZgU2Qt7ufYIx48vbepsrc2q+xgKmz10/W2m8ebx27WFBUrLPPE4EY1SrP2la+XKYTwRBgGzmZZ8b/CWnCQCULDcphvATgNac0VGi9szkId01i8mP2X3Vh5OaWzCkiwtYuzWu5AdWrq7e1x4EfzFDredryakSughkcSXuTei8jwAPPk+7JkxZeMI6LnE+74wuNXfpl9cItOozGT1TVYg5yPJVUusPBSYY50TNGppC6KT58NJ6cjZfm86xrUcpr+F7n9r9lyXcRvNxCubguHbFX5+u9YzVIPtNDMQdBJC3jMlr5EO/Y/U9hJswyRLZ5bs0qR6Dh+ep
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZTeTBNbnprQlVCM3VxYjBYYlZwc2dUT0V0U3VTdzNqOTBzR3NUZlpXMFZ0?=
 =?utf-8?B?ZDNKbmdYK0x6TzJOOVdOSkNkTzZQVVh0OFMwV0JqQlV1ZEJZSzl4RDc4UVBQ?=
 =?utf-8?B?QVdLYWZMRURxc3dZdEE5SExnTnM3Y0JqYVJCQWFVZ0NKbm9LWCs2ek9OVHFS?=
 =?utf-8?B?Zi9GNDFPcEVZem1Ic3h6eGFya3VOVzFhUVlIRzY3bUxYT1RDenBkWGY0L0lo?=
 =?utf-8?B?Zkwrc3dEb1pHMG5xTEkrSllHU0I1VTFIOUFSZ2VIYzc2Sk5GWG1SUml2ZGNV?=
 =?utf-8?B?R0hwRTZMZmRTL2VIZ2RhOVprTHM5a1hQMDNoTjE4S1VBQ1k2Yll3WHEybTFt?=
 =?utf-8?B?TERzaDBXbksvREF6RTI3akVxYUVJSE4xVmI1VzhycmM5WTBvcmZiQWlnV2Yy?=
 =?utf-8?B?czV4dU4rUVdLT3YxRDFWd1JXQVUrV3VYWXJtaFpqZmJJdDNnaHlvY21KWWpM?=
 =?utf-8?B?YWNDdHN0Tm8xc3poM0dMak84dkpkWktOTVFsVVM0VUZpZGxoQ1VBYnE1ZDhw?=
 =?utf-8?B?V1E2ZVRJWjl2djE2UGFNTVJuWGdoNW84VXcxZTB5S04rMGFWNmFyc25iYXhZ?=
 =?utf-8?B?aFN3R0ZZZWRvcG5UeFB4alJtTEdwYU1tdmdBOFdERk1UZjFZRUdVSmxqV2dZ?=
 =?utf-8?B?eWxDRXZJQ0ZpMFNQb1NBblgxYkdLWmpPRk5IMFR5ZVhyMTJ5YndMMHI3NHF4?=
 =?utf-8?B?UHZranJWQUFyamNRR0ZITVFRTW5MeEpvMDVLUnY3Yy8vQllRclRURzV5UXZC?=
 =?utf-8?B?eUdLd0pFMUFmWjl5MG9xWlJ2ZTV6bWJlZVlPMlBwajg5SUpEU3hycjFSaVkw?=
 =?utf-8?B?VTZnTjRuemdMeDJWeXhsc3A4c1E1UXMwUzlSN1crZXZ2ek1uQ0tTZUpPcS9H?=
 =?utf-8?B?Y3lsRzFERlFoVEZLanVxNXQwcVJ5Ti92dUFEUkMrRjRHaVJiRDdQQk9kM0l5?=
 =?utf-8?B?c21FZUF6eFp0dGhuUnJmK0lSSFVtOGwxcjc4dnZFZWxtMnlwTjk1cjRHL0dh?=
 =?utf-8?B?TUdhMURjSUNDbE5XZkh1NlZpN0F0bmEwV2R2VE4rSCsxRVRIbzlVZklIclVP?=
 =?utf-8?B?U0xGejFEY20yTkpQVWUzamhuaDJaTVE3bHZMbTFJU1RRenIvYUdiVUNHays4?=
 =?utf-8?B?elVhQisxNTExT0duelEvMnJueUdCVHUvbDhJVGgxTHJBMnAzRVdNYjltVGE3?=
 =?utf-8?B?bUhiZFY4WG1lZlMwV1Z3ZUYzTU90Y2JXc2NwbzBGaGhXcU50ayswMG05MEda?=
 =?utf-8?B?bUhjNkpaWmtNdk9qeGltSVFyTzFDL0M3RGIrMFhMSDY3V2RpMFBiRzA3ZkN5?=
 =?utf-8?B?VTZQN0VGY3dkSjFnZUdwWEJ3bDVORnZ0YzQ5ZmhHZU5EMzA0OGVhQjhrbmdl?=
 =?utf-8?B?eHVtdG5WOTJ3SG5ET2VDRU1LcERSckk4dUkzYmZPNTJUSHE3bVBsT2VQTWVo?=
 =?utf-8?B?cWNsZ3dDNENaVVZwNVNqSlM1a2IvaG00QkN1WFVRY2xqM0VpTFF3aVgzdjZ6?=
 =?utf-8?B?QlRqWHh1YU9wK0czSFQ3RHM2TGN1ZSswQUtTc2hvTmEwbi8wb3hPelVHS2Nj?=
 =?utf-8?B?TVh5RTlva3A2UE81QjQvNVJSNHU1ZGJEZlFQWi8rMmxkdWphS1BuS2Y4Qmg2?=
 =?utf-8?Q?BIyJ33iPsfGWkTyyiJ2kZVlf8QIANlzrkUlBw5AGpgr4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4615de7-7d76-4a95-37da-08db3ef25a16
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 03:18:02.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0790
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu:

On 2023/4/14 17:32, Tiezhu Yang wrote:
> v2:
>   -- Move the functions to inst.c in patch #1
>   -- Pass around union for insns_not_supported(),
>      insns_need_simulation() and arch_simulate_insn()
> 
> v1:
>   -- Split the RFC patch #2 into two patches
>   -- Use larch_insn_gen_break() to generate break insns
>      for kprobes and uprobes
>   -- Pass around instruction word instead of union for
>      insns_not_supported(), insns_need_simulation() and
>      arch_simulate_insn() to avoid type conversion for callers
>   -- Add a simple test case for uprobes in the commit message
> 
> Tiezhu Yang (4):
>   LoongArch: Move three functions from kprobes.c to inst.c
>   LoongArch: Add larch_insn_gen_break() to generate break insns
>   LoongArch: Use larch_insn_gen_break() for kprobes
>   LoongArch: Add uprobes support
> 
>  arch/loongarch/Kconfig               |   3 +
>  arch/loongarch/include/asm/inst.h    |  16 ++++
>  arch/loongarch/include/asm/kprobes.h |   2 +-
>  arch/loongarch/include/asm/uprobes.h |  36 +++++++++
>  arch/loongarch/kernel/Makefile       |   1 +
>  arch/loongarch/kernel/inst.c         |  48 ++++++++++++
>  arch/loongarch/kernel/kprobes.c      |  75 ++++--------------
>  arch/loongarch/kernel/traps.c        |   9 +--
>  arch/loongarch/kernel/uprobes.c      | 142 +++++++++++++++++++++++++++++++++++
>  9 files changed, 265 insertions(+), 67 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/uprobes.h
>  create mode 100644 arch/loongarch/kernel/uprobes.c
> 

I've test this series and found one corner case:

#include <pthread.h>
#include <stdio.h>
#include <thread>

static pthread_spinlock_t lock;
static int count = 0;
static const int n = 10000;

int main()
{
	int ret;

	ret = pthread_spin_init(&lock, PTHREAD_PROCESS_PRIVATE);
	if (ret)
		return -1;

	auto t1 = std::thread([&](){
		for (auto i = 0; i < n; i++) {
			pthread_spin_lock(&lock);
			count++;
			pthread_spin_unlock(&lock);
		}
	});

	auto t2 = std::thread([&](){
		for (auto i = 0; i < n; i++) {
			pthread_spin_lock(&lock);
			count++;
			pthread_spin_unlock(&lock);
		}
	});

	auto t3 = std::thread([&](){
		for (auto i = 0; i < n; i++) {
			pthread_spin_lock(&lock);
			count++;
			pthread_spin_unlock(&lock);
		}
	});

	t1.join();
	t2.join();
	t3.join();

	pthread_spin_destroy(&lock);

	printf("%d\n", count);
	return 0;
}

When I try to uprobe the pthread_spin_lock calls, the application core dumped.
On X86, this will return -EINVAL instead of crashing the userspace application.
Probably, we should add more opcode to insns_not_supported().

Cheers,
---
Hengqi
