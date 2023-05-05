Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754866F7B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEEChm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:37:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E033120B2
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 19:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS75iYpCtSoX0SEBCZQynHqlszA8oQuiHAUlBaVywY7cUHvprVkmN3rIr5Hf45p0J28XVoMEPxbUOcVd/nGHo4HrNiU9RmquDZwd6mUdzml7lcHn0wHC5Q/jGdlhH/9hLGURJiaVWBYJv6X8sTQIcyR2Zh5RxVT2IyzwvUSyX6cIxFp+b2MyXMGZrtcVzboH6D+m0JoC4uRLg/jb4o1V1NWUWozZu8nrGmeaL/oBDqortD3ms8U7zjHqy2SayBEbN8GNwlxqflBwi1Nq8YecQELGR+yg8yKkuDX7SsyZ6qfcPaMcH4C7HAaMapKedsoz2rvYfLEzc4d3rgH1WljrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+bFJjDxCQS1ZWv9fZFWHWPY/Roj1jxRDF5DpAXReAU=;
 b=nbTX03F9wMrsL6uRnLmQUJbZ0y1NmW7XUT3vFszUk2H6vMyJvkC6+52m0um6eq/TJBCLJD51DggymuPMvBp3fN60uGzy1WOtuPnZQe9jg/F29TFiO5MyQWcCXqDQl7BFaILgFpURbnFAZ33wkRs3lb868lHMcz3b3p04RMDVuUA1Al0m6O5e59s0BFZYeyuU66Nf6F9T8ONqcOCiEJ4tIZU5oT3swO0MXYi3GvxXZ6XGFVcZ6AZgKeLsCSnlNlEYN0dOlEepr3r/yYFYd74KwmhhbDFLXgtmHMLrcEzfwUdQkOPDbgaSOYLjc2uBPUc+LxPQFmT3pUaJg32GPEwCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+bFJjDxCQS1ZWv9fZFWHWPY/Roj1jxRDF5DpAXReAU=;
 b=YPg31E7zBZKXPrbgkO6BtYQIrGTOLIdBrQj9f1n9hpfNXlnWrbqZpC8hBhlrKXCe1QAgYPuM0+KypqYJrgLP02MIOvj36L5q0msjo0qSJD7VP5oq/2qKmXYYabPXN2wvqW+7WvbYzttsz0k1ZXPHAQChD3l6iU1CJeTTG9V9Lug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7717.eurprd04.prod.outlook.com (2603:10a6:20b:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 02:37:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 02:37:36 +0000
Message-ID: <9057f298-c060-337b-7792-b69408545f76@oss.nxp.com>
Date:   Fri, 5 May 2023 10:37:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2] tools/virtio: fix build break for aarch64
To:     Peng Fan <peng.fan@nxp.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "mie@igel.co.jp" <mie@igel.co.jp>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
References: <20230323040024.3809108-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94179AD15D133E2D8736A7D988639@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <DU0PR04MB94179AD15D133E2D8736A7D988639@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: a6df91bd-3dd8-4e89-847e-08db4d11af47
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kS4QdmUeujmX9nnqZhe1iS/uBHhBg+dEmEyqlnrik0QpLgl3/u2EfxoaULK4BL9kSJMrMRYmr8dIJ4sh/KbobtibETwAJRsOjcmfxcgCIS+r8OvRhM5n5zoeS/HjwXLLYMMgicREMFLJsWZtLst9scGAUUz4dmHYAuMXRgJoWZ/Kd6ct06FwqMdZSmiBAz8NqDiT/a2KCK8b7Dj6YF1jPlS1hsYDruxeHfT/HGSLQ0+XqjUpWZLoc5Nvd1fty32g2FcZK1ulEWMBXVjCsypcYDc5XlFMfnKsmm3YAeSgh93r8zhDhN21WTgin92ZX1fwF9tFaaB5Np6172PIKsU8eTW1zfsGsdtQcEAhba0zBDeZwV4mIYUIv0PoEs6bgNL1FxJqWiW73EqBBhuxKx+gALHMJPZn+sXJLxzltGnFTtQgrkgl1xqctu35M0Kv1wUBTy+WsDaNXeKbSeiZSNxqOksEoRbn8C8DXFAkN9DI2q3vAqgb45vZ3PchLfJg9DyJTdtG6t3wI0uR9vF8OJJyma3EKmc6vu9+R8XuvGlMdDC4FEPZs+oDNA1xmXXAUlipZdOaltA94/MEwtU1YJJA2Nu8K5XDidW96yis81ZE8f+n6LoonVQtE4QGzvrCXCSCeRofOlxF9nR54LgJoRHWBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(83380400001)(2616005)(186003)(2906002)(38100700002)(31696002)(86362001)(5660300002)(8936002)(8676002)(44832011)(66476007)(66556008)(4326008)(66946007)(41300700001)(6486002)(6666004)(31686004)(478600001)(316002)(110136005)(6506007)(6512007)(53546011)(26005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxOUHRRdSt0T3ZHbjRrbjNldVhFaTlhSktCK2NtUHpNMS9oNDhxcEhzMEhR?=
 =?utf-8?B?djY4d0xORFF2TzE4VGlNYzhrQzdpUnl0bFpoK3pwSVVCb1ZTNFZBN0pqQVRM?=
 =?utf-8?B?dW1KYW1VVWJVZTR2UTJCdThudGNIT3FIMkVoYS9XeUt1SjhjNHFRVExQTW1K?=
 =?utf-8?B?TGhEb1B0UlVPZWQveFFhZjJnMlFGU1dCTU1wQlIrRk4xYlBhOTNoNGp1dHhD?=
 =?utf-8?B?eWNZdkVRL0hja0R4TE9vb2xnRkZMMEMrVEJYZUZQQjAyQ3FRWGJjTHFGbEJt?=
 =?utf-8?B?MWtuOHcxU1l2R1lkVXBuYmlIaXlVZkZaU2VIOFpja0dPOUViRWFDRjRyV0Qw?=
 =?utf-8?B?Qm9wM0FLQlBPa1VURU5zSHFnVWFwdjNKUE5ZaVVSNjRneDN0SGoyYTE3M0tG?=
 =?utf-8?B?UkhZVWZSR3c3RGw4WG9ReWhidzZKYXU3b0FlTGhqeFpRcFNVM1NyKzJxRDY3?=
 =?utf-8?B?b0ZBMDBwRnR3dUdKNkNyYVdKdnhEZEUrNUN5aE9HMlU3d1AvdkRoZW9ldlFy?=
 =?utf-8?B?UWhzRTU3RVY5SWJ2WENDdHhuOXZJL3JxdUpwd3hSeDlIbWE3elgvREhJZWlq?=
 =?utf-8?B?bWpYbkZDRDZrb3NZbU44OFpDQWtzTlhEUDJTazR2b29vVWorMFhKTXlkTW5P?=
 =?utf-8?B?WXMxTTZtUG9qSmxkalYrMXdGb2ZhOEtZQk16T1c1RlpFajBOV0J2cUdCVVVL?=
 =?utf-8?B?Y3lWRGpMRk5ybmZWbjNlRWIwcjV0VjducnlXV2ZQS1FoaU9qaG5UTFJMMHA0?=
 =?utf-8?B?VGxKUjByQ255WTMyaFVQYUtUdjhGRGY0bzNZeXZacUhJV1hIcE5hOCtLVW5k?=
 =?utf-8?B?ZHZwT0lnTDFsTkphaUNweCsxQWlUVkVob095UEZCTDBoY0FEWW9ENWsvcThq?=
 =?utf-8?B?MFFEVTdJaENyZlhyTmlvTVpoYkJPeXVvSDZDbGduMTM4a2hNaWdzbkVyL0d1?=
 =?utf-8?B?STdaZDBTSHkxQU9NY0F1SVhwL0Z2ZW9yYVJCQ0VIa1htQ1RScnd4YkhPeVNK?=
 =?utf-8?B?Yi8zV0xkSExvWExYS2xhL2lDNDgyS3g4Z1JONVN3aDEvRmFLWXF0V0I0aGNr?=
 =?utf-8?B?aFVlUlU2MjlTVVRoQnRyNFQvV0drYXRyM3dyY2diZ3B6MHgyTEJYaklGcXJC?=
 =?utf-8?B?VmJNY2pjSjcxS2lJK2hNTWtNU1ZwZ3UxTDFHengvdFFLejUzb1J5MDlyVWha?=
 =?utf-8?B?UDNpNWNBNm90VmZPd1gvcGVOajF6OE5uak54QnlEMEZGS1d5TzFpMTRybjBn?=
 =?utf-8?B?bTFJZU5jcFd1Y3JDek9MajhxU3dQRXR6OC85Ukp2QXZWb1BkRTdkZHc3SHZD?=
 =?utf-8?B?T1duVjVWTkd6SjFzdFcxRm5xYk0yVjJmZEhXTFpXTWRPNm9sdVZmZWt1QTA3?=
 =?utf-8?B?RW0rRmNJOENrOXJGenVyMzYvUGh5OUZlRlI2K2dUZUpuQVJFTEJFcFRHUTB6?=
 =?utf-8?B?VXVETkpDOHhJV20zSzQwQThFcFdnbjgyWDFZZkMrMFNEYS93QWx1REhDZWhw?=
 =?utf-8?B?U1RIRGtkRjM5S3F0NWtGQ2pJbUxLQ1c4ZVk5VGFqcE5uam9kQzBuUFBNeTE4?=
 =?utf-8?B?b1hhR2l6eTcwaXNtZTd4elc0NU1uWm80MjY2OXhXZjJNYlEwQVh3UWxSOStv?=
 =?utf-8?B?dHJXWkNnTDF3Q24rU05rSThYVmx6aVR2ZlZHMk5hNWdWdEZsVWZjSmVqMTJ1?=
 =?utf-8?B?WUZOOCtmanhUd25xcVY3T0RKUWxwbmRiQ082MUtyVHBCb010N1A1TElRSFNo?=
 =?utf-8?B?YXNuM0l5OWRXUS8vWHZjRzN1YjFwS3UvVCs1K2pWUkdmL3A5eU1vYWJ2Snpj?=
 =?utf-8?B?ODhyczZJZHMrUENqRWNrcnc5WGExNXB3Q1BlT3Jzd09CUG50UDA0dk1RQ3VN?=
 =?utf-8?B?SlNLYWJNVm52L0MxN3N1dVltSTNvV3dCMlhQSWJjaVRnK0owZUN1dnQ3MENZ?=
 =?utf-8?B?VkhoRmovVXltVCtnUHNYRzlWVHBxalUrQnVpQ3M2TFpLNVVFNlRKZm1tNFpi?=
 =?utf-8?B?VWgwdXlFU29PMFlMeDZQVWc5YWVoRmY4czNKOXNKRjNkMlhFbGlsSXYzU0Q1?=
 =?utf-8?B?TStMRXArQmVCejFFRXFFZlROZkpaNWZJbC82NHcxWGg3VGlkN0hrWnpzVVBS?=
 =?utf-8?Q?9v9HR5qtDE8tDIVGhWd3Q12to?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6df91bd-3dd8-4e89-847e-08db4d11af47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 02:37:35.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9dCSF7oDJKPilliDtTbZlh03Lb7AQCuG9Bp7nuwWjGuMjdPuJys4u8HgpeJ85ZRmBHZfqOLgq8ghdCCcdC3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7717
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?

Thanks,
Peng.

On 4/20/2023 11:35 AM, Peng Fan wrote:
>> Subject: [PATCH V2] tools/virtio: fix build break for aarch64
> 
> Ping...
> 
> Thanks,
> Peng.
> 
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> "-mfunction-return=thunk -mindirect-branch-register" are only valid for x86.
>> So introduce compiler operation check to avoid such issues
>>
>> Fixes: 0d0ed4006127 ("tools/virtio: enable to build with retpoline")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> V2:
>>   Use /dev/null as output dest
>>   Move call cc-option to the original CFLAGS
>>
>>   tools/virtio/Makefile | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile index
>> 7b7139d97d74..d128925980e0 100644
>> --- a/tools/virtio/Makefile
>> +++ b/tools/virtio/Makefile
>> @@ -4,7 +4,18 @@ test: virtio_test vringh_test
>>   virtio_test: virtio_ring.o virtio_test.o
>>   vringh_test: vringh_test.o vringh.o virtio_ring.o
>>
>> -CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -
>> I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing
>> -fno-common -MMD -U_FORTIFY_SOURCE -
>> include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-
>> protection=none -mindirect-branch-register
>> +try-run = $(shell set -e;		\
>> +	if ($(1)) >/dev/null 2>&1;	\
>> +	then echo "$(2)";		\
>> +	else echo "$(3)";		\
>> +	fi)
>> +
>> +__cc-option = $(call try-run,\
>> +	$(1) -Werror $(2) -c -x c /dev/null -o /dev/null,$(2),) cc-option =
>> +$(call __cc-option, $(CC),$(1))
>> +
>> +CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I.
>> +-I../include/ -I ../../usr/include/ -Wno-pointer-sign
>> +-fno-strict-overflow -fno-strict-aliasing -fno-common -MMD
>> +-U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h $(call
>> +cc-option,-mfunction-return=thunk) $(call
>> +cc-option,-fcf-protection=none) $(call
>> +cc-option,-mindirect-branch-register)
>> +
>>   CFLAGS += -pthread
>>   LDFLAGS += -pthread
>>   vpath %.c ../../drivers/virtio ../../drivers/vhost
>> --
>> 2.37.1
> 
