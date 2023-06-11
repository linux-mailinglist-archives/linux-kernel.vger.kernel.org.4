Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E672B21C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFKNiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 09:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:38:14 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCFBB8;
        Sun, 11 Jun 2023 06:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jN8t7/7kV5Aj/JizONmPLMvuqQ9So/5lTE/FZI5WBOUgUD2E4C8OvmiB3bm/6UNcgiJSNDd+NiK/Tmz8f4oenNrUdXYroqn43cPhVqb9UZb4qnJxyyKjiwcLIqcY0g0vYDsLvh3I7DfQxGzYZptws2tvCEUDRMsYBe807kaJmW1r10p9NZCD0xoleCWyyoapZiyCem2Gma/Yi5F4tj/RfMbSkxryJrXk+yY3e9zfH8XopOupkvJtsqLgDKOVo5sAOxoNyrEKJbCqQEzQWNmTj3n0k9RnKX6Sv1OdxNTfM2nC8TylVK6z/Nul4UlfT/W/CBNsSqdpn7f3J8fw9HrQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfvqGS3cdY7Scl7lDwT/lmts5FMWe0DbOFU/+7PHq2I=;
 b=cIjdifKhz/xg/gHZzpKWRiwm2RNFVrXceYD2tuUzrSetxvuQF/fRT/6v8+uGkCcNwaXV2rHPS5VjXvcYz2obndAz5YHuIy9px40qBnUTrz7c1XCQm2zD1szLq3fHKh2jufYyoYv+ZLuWW9dTCgBGE3ZhwVH9JmAPcOaj6KXIunXRxJr0PjExU67fUVfPuPo1ytVZ4if3MRec1UJsCKRZz/51bzm3yfPGUcl4ScvEYYOb1lUNva9pWNcSVlocp5WpfLK8VFAsEk+0b82VUhZHiE6WOqIeIr6bF4+aGjERj672edYro9etEAjSvIVP8yStDkT4ZZFiNWT1P/Hfl4KIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfvqGS3cdY7Scl7lDwT/lmts5FMWe0DbOFU/+7PHq2I=;
 b=wSE4w4Ge3t+l9dXEzPllAM4QzNI0E+ydn8sO7mHqxTCMLtsZV5jC4WJVSkJYy6kyp+e57Dr5LSTs1mH3oGpwNEOI3Gq/LYziMmOdXx4/+pCpjWA+3yDeKYVpkmWKEcJF3zPtKLtMATLojAiRz5ojjlz5oSOcZPfJAtrJMf64CI2+erThy+3x3qmqNFwXW5+IiEVEmO/Aa9dd7NFMwh6IXs5C2rAnFHtjxXP74O9ZyQt9XPLqzxnGT8/TBoIfpdLrt+bvv+NV76ukpjz6rNbjo75cCaHyPIVoTEwSlfK+hzJlUKDacrON+5Lzeri/MF8Ni2u8bTcaYt2m8KT7qT64Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Sun, 11 Jun
 2023 13:38:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Sun, 11 Jun 2023
 13:38:10 +0000
Message-ID: <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
Date:   Sun, 11 Jun 2023 15:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage via
 RTC_VL_BACKUP_LOW
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
 <20230610083135e40dd2f6@mail.local>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230610083135e40dd2f6@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 26eae13e-4e60-47d2-1e67-08db6a811850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK+Ek5VsZBT+DLmd7DCMfFIfqvEWHwd7qXuI8oZTgJ9GDWLsvM+VEKKuHw8ZCE+bN69rY7TrMod/yfQ/A12vyQi6xcfrt+0dSfFqvqku/Rs/sATzlO/z+WTIQAf8/2pt4GhF8imhZEDodtqcpXh/O2ANXtQ18orpkM05AAkHyDLnQDZTJ0ANDtPkqtD6Awr0ne9pqqKVCcAHd4R9zrzqbWTtGx4bPq3xOFGZ361gvVOkfw0aoG6hfbR7CSUFvRMcT5ryRQKZ+wsCxtyP/TLG6dDQOVtmJ/IZWDnvxurU2asbzm0cd+dNesvEXjEtoIP5MshuI4duW1ws1QoTXRbQK9KzvN4dzEQ0cK04QZrYpbypkjtcss8yEVyhUHNZfYpBATE5BbS0Fu/SV6twtqjppS4HsgIr3hUtMu5FudAcOHulUE7mjrHThmQoUfIDXlNwO9EMMQJbrs6StjQF3wfdBw7Tsr5myC6Y0y/H2EGSAGepT3niM3VJs0ezXlw42uU6oQbEKCBK2DnuIieQONj2w3wETA1c5XHcWqNnQBKU7V2bR2TyztHLbzPZnhlyCQAiIkkuCq2+TspQca+lxYBPHmoR60ceyriLqAk6XEY8hIlaKSHUWb24sbUtRbNfQ6ISHWdtYyb/gdTKA3lQg2WKGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(8936002)(44832011)(8676002)(5660300002)(31686004)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(26005)(53546011)(6512007)(6506007)(36756003)(83380400001)(186003)(82960400001)(2616005)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHY3VE4xS3ZSbWQza2VxK3N4L3IyUDloS2NXd3FPVlZjNlVwdTVJWDRvUjll?=
 =?utf-8?B?VzI3T08xS0prN0dSMmg0cGphSjdsTW1SdjBaOHZuTCtaNmM2aDMza1J5RGgw?=
 =?utf-8?B?QmNzdDdPNHFwc2JidC9qMlJITzlwOVJCd1FMVEE3WHFiK1FhSEtDc3IrYzBk?=
 =?utf-8?B?eENyaEFOeFh1NWszRWVuQXhWY1graWw3U09SQ1Z5UG8xTHJ3SEpEVFA3YWlP?=
 =?utf-8?B?Q1FsZVRFTTg4UFYzQURXaTVzcGNkbXZ6ZkRLZG1zaSt6SkVKWUM4RWdJTXh1?=
 =?utf-8?B?aDBJeWN4RHNtdEYveFJneG11aTI4TXgrY0dic204akU1OFh1N29XQUlKb3VO?=
 =?utf-8?B?akwzQlExRjgwSzErTnh0VVR6MWRYb0xyQnpJYVdnMnB1ZVVsYzg0ZFF5bGY4?=
 =?utf-8?B?bGQ2OGI4aGhLb3hldTJSSEs4T0xRbjNKZjFtTzVGaklBazlBVW5HcWNrUU5Y?=
 =?utf-8?B?L2JSc215QzNDMGEydjM3T1RwU2xabHhVUU9rQlVzQUJiL2svVzBGNGN2emV5?=
 =?utf-8?B?ckpzVUY2dWZ6MCs5MWZUZjZ5U1ZvUk83ekZleTM3K2cvTCs3dHJkRkFoV1Rx?=
 =?utf-8?B?aEdhZzR6d0tsdXZwTlVNeGlRb1plQ2Vjc25wdjg1cnZSSTF5ZTBUdkJrNy9n?=
 =?utf-8?B?Q0d4eHM1R0N4STYxa1BEKzB4d1IzSkRyV2hUcEV1bkxrZGhIaGp1elAyNTlU?=
 =?utf-8?B?NStFUXlvVG9yd1N1QjhXSDJqZ0JtM1F3cXJDMFVPYXNlYklwT2ZOdEJHVkJK?=
 =?utf-8?B?ZjhwR0hVY2p4Qm9uem1XWFJoOWFxUmZZK1NTUXhqKzVUNm5TQmY5VWU1cFFo?=
 =?utf-8?B?MDg1N3RFWG9DWXcyOWEzcDY1anZ0RHNONEl2dlIvNHQ1STBkdGQ0Zy9CZFJC?=
 =?utf-8?B?MFoweTd3U1g4c2NrQjhacGwvM3JnZ0tMcmdSVGFocnhjNTc0dUhZR1R4b1NL?=
 =?utf-8?B?OGxISm1Xb1lkRk1td3Zmb2RFY2Z3MStuL2FUOWJqaEFjZmZnVXMrSXFlN3U1?=
 =?utf-8?B?V1FwdkROcWFRR0hJUFJRTjRtc3dPdTJkUHFWOWxDZWJ5TlNhY0VFODQ0RHFi?=
 =?utf-8?B?c1pUTlpTTk9HaE1QemhQQ1d2N3RGZ3ZhZU1UMURMejRSWUtIVHRXVksycFg3?=
 =?utf-8?B?U2JyQTZDQmZuUWR4aVRZTldHRkFkQ2dYWjRQYlh2YVNTbUpyMVZ6QS9GYzhp?=
 =?utf-8?B?dVcyNjJuR0VuaDN1ZFl2TUh3U0xMT3BuTis3R1VGL29ZS2EzYWpVUmlCM3Av?=
 =?utf-8?B?Q3RpM3FBbUlwZ2Y3cUVtOHNyM1FqS2FLMFYrN252R0d4eFE4K05BaTJ5MDVX?=
 =?utf-8?B?Mk1Pc0RwajkyUDM4Wm5YSXM0ZHVYenZKZytGRkYrRkUwUzRLQUtuQ1BZaCtp?=
 =?utf-8?B?YVBheG11SjNvMWJGWFVRajExam5OZlhLQUo4eFZKVzJka1NQdWdDT1drTzRR?=
 =?utf-8?B?VjdMbzczU3RtaEJxbGtqNnVkUDJtZ0pZempUWEFja1hFbFJvQVM1SDZ3Zkhx?=
 =?utf-8?B?bzZNN2JhQW5oV0NJZytOc0lGWGt4RXlGYk1JUTNNQWwwWjUvOXVINjBGcVhH?=
 =?utf-8?B?bFNOaDhKOThZZ2NiOGw3TU5NOG0wZStVa05NTWZnQm5HY1JERlphVmRpOExr?=
 =?utf-8?B?K09ZaitodG5pbGEwOERpc2YybnRyVFRIME9ESkxuQTIrV2xzaklvOFpoaDUz?=
 =?utf-8?B?ZG9YbThiQjhIdCs3Q2tuZ3VQNWVNb0E2YWQrMWNrOG80VmdtZk5HWE5CU1Y5?=
 =?utf-8?B?VmxjU2xEUC85T2dNU2JOMGZtejQ1QXVKVDd4WUYyMDkvcUY4MzFsYnJkakNt?=
 =?utf-8?B?RHBIckZyV1NYY1lqTzF0ZXJjZ1R2czZmMkxzSEMvUkdDUXdmbG9QbW5LU2Zs?=
 =?utf-8?B?d2RlaUlYQUx6U2NCblAwM3VEZ0hIVGZqNThmYjBZekNEYjRLU2N3VDlqNGpu?=
 =?utf-8?B?UkRFb0pvM1FWQWtBQ2NiTVI3ZGFBdFUwUEF1RllFN1MzTmNRMmFUamFIKzNs?=
 =?utf-8?B?S2J0dXdzbjljZzlnaDJqMEdkSEEvMnhhSTJFa0V0TTFEd3lONXdzaWZpQ0FM?=
 =?utf-8?B?aFM0c0h3VlE3MFV1Tlk2R2VPc0tocHhaOXBudGhMSUM4bFdXbUMxanRUVEp6?=
 =?utf-8?Q?1CzPsEBKRqvTwT8Lz2+ZwXI8y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26eae13e-4e60-47d2-1e67-08db6a811850
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 13:38:09.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9/cmUrhMfWOhBbGh1DKq2/ThEZcwJFJ6YLr1BKbr718t6E4ejTMFkBrNfnAiN0xkdkethtU88Ox507zSBRELw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7048
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.06.23 10:31, Alexandre Belloni wrote:
> Hello Jan,
> 
> On 09/06/2023 23:04:12+0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The VL bit in the seconds register remains set only until seconds are
>> written under main power. As this often happens during boot-up after
>> picking up a network time, make sure to preserve the low battery state
>> across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.
>>
>> To permit userspace clearing this state during runtime, also implement
>> RTC_VL_CLR that works against the cached state.
>>
>> This is emulating RTCs which have a battery voltage check that works
>> under main power as well.
>>
> 
> Emulating doesn't work well and I deliberately chose to not implement
> it. For example, in your scenario, if you boot twice without using
> VL_READ, you anyway have lost the information. This makes emulating
> unreliabl. The fix you need is in userspace where you have to ensure you
> read the status before setting the time.

Then let's make sure the bit is also set in the hardware register. Then
also the reboot issue (which is practically a minor one) is solved. The
current situation is far from optimal.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

