Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EDF6F62CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDCDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:03:24 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2140.outbound.protection.outlook.com [40.92.63.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED411A
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nozNdfSkmjbeBlJFj4grBRRAoBHqPGNGxg7ps4E6G9i7p4fcs+diVYGNTxSHkcQPP1nltdMPIsc5TCrT4EK9dkblLjqOtIEjQ0L0N2X2inJR0sD4jmKMzuSPqcwY63bLBfkoHzVbaIJgy3eooAHl7MYz22FJyacIobSYyHZ6TsnH+5AqNII2FdaVTPoNewlJu8r727APISKCiToDDcvYL1btx1pgRJIVJNGC0qbZBgFQ8arRPFpCiXD70YwTSsZMiH3J+N716lAYgT+kKhdVum7OjuWQVGtioyfGZhz80lVa3vWgQjBhuPoAN2NxMUiuYjKHwVzxkq0cHmxwmyfTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsBsfCoBqZbAmMGmbTDbtQcBPqr+xU4KZuv5yJy3eSY=;
 b=oNbDUUunMeut9YYlZZUEz+HePCWqZg92vaqDgF3MARxM+E0n68TIjExe+kYhIsUeNwipZxz9Zwm0Wc5WDJkgE8HmkNARFOzmV35sSUq8FLNm+0koH2oD/7rQiuq9aWIyDl5ylRgKx07QtTqgTEK7pe/fAziKUyWdwEpe4wIGdMNueN1b8bILyNp+u6vk4zmdyjXNN3Kk5UG14bGIZlO00P7E1AxnolXVoy/x0wXz2s7fvVYIdYMQsqZwn7QhzpCR1z2eMKS1Dch4wJ7Q6Tvi10R4cvQ6IRsScdNcDbYtyfshiy/VquHBoX3482/TIGdEuE4TK0DmSQ2LsXjagpTnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsBsfCoBqZbAmMGmbTDbtQcBPqr+xU4KZuv5yJy3eSY=;
 b=EHZFcFtd+MbXBQESyA5Q3M/E/0K7f+MHpFExFDRavJvLaQivBUO19zfZ+61MPLg6G64HlJYXfrJuWgLZlMtatVplgu1MDDTxK8tIJQb7qp7wqdGWzFc3yDsDeFzZjOHrnQiPOJN1pcfS9/UMfHwJw76volp/sZLOic+c5VBOda0TNlPE97Y2k7MV8hcKMxNrukcFE7HX39TIO6TSzfXhtCZtPSUoKBK9e7eoGcAnSC3m317lbabDvTAaS0O89P9m9dUuqqmM0BGHr2USdQbxc3aZ34Z3AOv+FQ+c31QDmLHFV8TeeFPZmGhDl4DnmSB+1HEDeYxrNeWNwwSCXfR/Sw==
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b5::14)
 by MEAP282MB0680.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:66::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 02:03:16 +0000
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::3bf6:473:1088:d15e]) by SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::3bf6:473:1088:d15e%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 02:03:16 +0000
Message-ID: <SY4P282MB3518B7072E26AE054372D818C06D9@SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM>
Date:   Thu, 4 May 2023 10:03:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/6] Add uprobes support for LoongArch
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <1681898221-27828-1-git-send-email-yangtiezhu@loongson.cn>
From:   Hengqi Chen <chenhengqi@outlook.com>
In-Reply-To: <1681898221-27828-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [SzIMBX+aKuvqYfqLdY5DfVK92x52uKKU]
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1b5::14)
X-Microsoft-Original-Message-ID: <49960395-48a8-cf84-ca72-8c501f553003@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3518:EE_|MEAP282MB0680:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfae86c-4e95-4f5f-b4b9-08db4c43b8b9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRt6QRylKDMtJ1niGQ68Sj7IbfZIZITYYMSAgipuGUuo9vvukm0zwmmAYuNOWypzOxMfJ13GUevcXxPRyiWakYJoWRXu/F2shDEqqLULDngqZWw31Jb1fxfV+otK7xBVMOlzEdXj+rIyszvOXBSp8LFrwNb8x887UbMz0nMOt0QP4u5Jt/Y7VAdez4Hzm4kU5OqjzCYfMdPnqtXg6rvC6k/j9XplnD505DBVBe6PpGBWS+TtVyLWqlsjJu8nOvlDy6/OWGyl6MjEU1DUtTYoCqBx6yHIWmfZ4lE/5j7Iwf8Mxov4vMUdCZNRrtH/E1jYOBQweOS/kmzTBR8eBzqvv6Jn0iJ7LM9dawAI3sEqALZinUGVDMpCa/3bP463kaZfs3Q6ecH2v+JE6KpK9zozdhgR3BHt1+bbsfG88NlcRGFydRBdvXs4nCKW92iKXtqKN3JFUf1l9lPfgrnDghBKc9C/q8TZwmVFHYfqQBeG+rgB8v3dcYRio43G+VGza7w9kRAe057s+17zsdlTVC6aVPBeyy615zWumVNRynWpJvvPdn3zu5aVXGibdDG0GT6lyi9nW88Iuw2VSiI3smvdEvRSgh071c7syPiWsLEal6E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdrSmRBMnBNbE1VTVVvVUVsc3V2U1JWOVFiNndaaGZGYzhwaWdPbEZHeVBo?=
 =?utf-8?B?QkdMRXVUZno3MW5VQ04wclFTQjF6TGxDTjE5cWwrTWliWWhRdDJDdDk4SE5x?=
 =?utf-8?B?SVMvUUhPbzBKUjBlTDNxeFlZNWt4SkxEb2VZTzNZd1RpUWRlbHh0ZEg5YzlC?=
 =?utf-8?B?c2JCOVEzWnZVdUNHQTFOQUFXL0w5ZU40aGI2eEZhVWxEUzVLRldEZkVWajRC?=
 =?utf-8?B?amxoTzMzUXRlVWQzaDl4OVpiZ1FEWFVxa1UveG5MWjRyamtITCtxNGlEY0hl?=
 =?utf-8?B?dXAvaFFDMStIREpMR0NaZlhtblY3M29VeHk3RmhQZ0U2Zm9lS3hRZDRFR3c4?=
 =?utf-8?B?aTZQb2VnOW9SanM1eFdibXVCSVFBWkk5VXNlTDg5QUNmOWJieGdZSVZmV0RF?=
 =?utf-8?B?VnBBQ0xJR2Z2cXpxOHBXUXNQWjk5alluVmZia1hpdmk4MUdPeUY5TzJTSkwx?=
 =?utf-8?B?LzJvb1hJOHlFZlBIelJsTk1WL2IwMUhPNzVlb250MVF1bEdhc1NYS041dlJM?=
 =?utf-8?B?aFh2RjAvTGN0Qm5lVnRCRUlnekhOVDBQdU02MDV3bEh6RjhyQm5sQkIxOHZX?=
 =?utf-8?B?NnlBR1J1RHNlL09MWThXTEc2VHF3akhjMHgrY0VtRUx3d2lXUjFWYW1KaUVY?=
 =?utf-8?B?d0sxc1BIZ1g5aEQ1UlRTblBYR0l3TnlsYy81bmdQREQvUTUxMlNJYWxydFRD?=
 =?utf-8?B?OUtETEx5Q2JkUDBoVDFaSHl6TnA1WkpSTWEyV3ZtdWZoSEVRRXczOXRGSGV5?=
 =?utf-8?B?azRhVkZZa204MG12T1Fab0pMKzJkTnEwQVVCaVp1eFBYN094V2VKWVRhUmJx?=
 =?utf-8?B?UVcwQXkyc2o5Zmk5UEg4UXhrVGhVbmNrRU04ZnRrQWVtZTZISUhSZnZvd28w?=
 =?utf-8?B?alJHUG10cndUQ3ZoMW16MU1scXZTbVhuellqMzQ5L253OWZYeGZlZDRRUVdU?=
 =?utf-8?B?TTdraDAwT2NnVG4xYTJEK0NsTms4djFVTHowMHlzSDVPbnBPZjZkM1BaSzZM?=
 =?utf-8?B?LzNveDY0MTFqMjRZTGVlZU40Skk0TnMrSHNUQ2wvakZQNHpjK1VrRVBzTi9H?=
 =?utf-8?B?dDlxQWcvbnNwSlpTZzJFT0ZnUkgxa01tYVBDcTJlNm1URndndVkvV3dlWVIr?=
 =?utf-8?B?Q3pXY0gwc0U4VDZLRnFtZHIrbzlKUmJiSzRxZkpleCtyS29yZG1vZGFDVndL?=
 =?utf-8?B?bkxpUnI1SUxJTWJFR2lQeXZ2b3B2WDd2ODl5dk1SSGN1dXBvWlgvQ2hhSFAy?=
 =?utf-8?B?MlJhTGJ6c29OTUtBSWlscUE1a3pvYllEejV2N1E2YzhRdVV4T3EwZXRPZVAz?=
 =?utf-8?B?ajlLU2RLamRkSDBIVHZodVZJdDNCc2FBaHZlUXJCTFJvSE82NnNhclVSWWxj?=
 =?utf-8?B?WDVKYnFKNUVoRHdySlRUdGloTFRJeEl4V3B6OUFVOG9RVW1EOXBJOGRrdCsz?=
 =?utf-8?B?T1E5alE1dUtMeFNpRzRiNGJLWS9wTStnWVc4RWpTakpvSzZibnl0Zkt6TE8w?=
 =?utf-8?B?MGpNNXR4dElFM3dYay8reHNGblpyVHNBbDBVbk13WnNMeC9QV0FzS3dtM0Ez?=
 =?utf-8?B?NmhwZ1RjVXU3Z09ITlZQSWJOYnlZNTZvSElremV0WDJ5V3NRZGx0Tm5DT2Z3?=
 =?utf-8?B?VEhuUmVMQzlNTCtuNHdNaytDMXM1d3c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfae86c-4e95-4f5f-b4b9-08db4c43b8b9
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:03:16.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0680
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/19 17:56, Tiezhu Yang wrote:
> v3:
>   -- Check atomic instructions in insns_not_supported()
>   -- Remove five DIE_* definitions in kdebug.h
> 
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
> Tiezhu Yang (6):
>   LoongArch: Move three functions from kprobes.c to inst.c
>   LoongArch: Add larch_insn_gen_break() to generate break insns
>   LoongArch: Use larch_insn_gen_break() for kprobes
>   LoongArch: Add uprobes support
>   LoongArch: Check atomic instructions in insns_not_supported()
>   LoongArch: Remove five DIE_* definitions in kdebug.h
> 
>  arch/loongarch/Kconfig               |   3 +
>  arch/loongarch/include/asm/inst.h    |  42 ++++++++++
>  arch/loongarch/include/asm/kdebug.h  |   5 --
>  arch/loongarch/include/asm/kprobes.h |   2 +-
>  arch/loongarch/include/asm/uprobes.h |  36 +++++++++
>  arch/loongarch/kernel/Makefile       |   1 +
>  arch/loongarch/kernel/inst.c         |  54 +++++++++++++
>  arch/loongarch/kernel/kprobes.c      |  75 ++++--------------
>  arch/loongarch/kernel/traps.c        |   9 +--
>  arch/loongarch/kernel/uprobes.c      | 143 +++++++++++++++++++++++++++++++++++
>  10 files changed, 298 insertions(+), 72 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/uprobes.h
>  create mode 100644 arch/loongarch/kernel/uprobes.c
> 

For the series,

Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
