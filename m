Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB73633E44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiKVN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiKVN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:59:29 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B543F663D3;
        Tue, 22 Nov 2022 05:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNvajJ25ljzOt2yLRbjMjgrAtE0SRLj5B7D6aZg/bSHjDVcP2CtNcEycshQchQtPBb95fwoS/ICvDFmmrPYnsEI2MpS7bK0zBkoQKEeqP3SXXNRrXJC7wzgTnuYXSnTZXizTlPzCZvNSHy9WEtqqZN3dHgZ5UVVwacVunr1RDG+a0Q9pxzzQ+bzw3h31vM1F8cfMly3k+Ia4kObGjYKMl4JLGZWvJus8VVPTH/JA9KCF4E3KE73sD02BbZ4UvwoHn5i2dZ1fzwzzOe74rtcFOkGzz1cIPy006WrJIPsDfnoaZDPNVgMrKt7AXW+OAEz4uEqKXAkQYuQr4fVlqQ4g6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDHUYX7/oB/73BfSqAvKJYtMYLndoiviZ8fPoaT5uvs=;
 b=g6f4BAHVJjDLUIXH6KKxQVkS9oNV0NTnCQetoV/aB50Rx2SmKGPmsYafcUgxUgU9tM3WvCFwMp2cCSNbFaLQKaQI0r5yeuHAjYTovp+odzrpMTvi102d7Zfw/gZhvc+OVlTjM2TLLV7AXkiwTZ27V+moSgXLnhjMokujGYm8nrd3VQkQ1dCLWylPpkQr9VQBu4cjKxgZDK0hTMJQUdr+unQzo0Xn5GdvZKrRYYVIJFMrskRgU6hca6vs3RPdLHLG0jh0JB6gigDx2sZBN7y+A7M61Hm5pRJv4EZ3Q/2ZnEsEyJYT7EH91iVsXniU+/TuNgQVo0CqlAkyhi7qbOYK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDHUYX7/oB/73BfSqAvKJYtMYLndoiviZ8fPoaT5uvs=;
 b=AzDBRuJXcNdWW1e6th1UNBF9Tnz5kpf6mlksacHI9N+G/4S7DaVg+YiHYqlGMaoBQuFhUV4xRsVCK149ZwjtDGfVZ7rEhAHByMIeUvSC8Azch2EMUWwzWwGH6IQ+WbZT1B4ErSm655P46m9TNsjviUA8V2FObHs2mybtgR7sioiiJCJHkumZkBhOtmELi3CjenZpu+jvgFOtUaiWF7cqU680HV25RYWvfKiHCfprZVlNm67SGxXFD2L5RioJmXwiRjDPuoNjNcPGQmSBBe+DAlHj1I0M8FtbzL6ROFDNIDsHMh79JOuQD+wO+uojA/uIK6o9JzWdsMYPw4RtmlIFTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DU2PR04MB8744.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 13:59:20 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5834.011; Tue, 22 Nov 2022
 13:59:20 +0000
Message-ID: <3f50021f-2dbf-4e5e-d85f-bf41a02b6b6a@suse.com>
Date:   Tue, 22 Nov 2022 14:59:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
References: <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
 <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
 <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
 <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f02c376-925c-449c-1bca-08dacc91c0a3
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UwsC9OKDOuXJPfMpRI9q04YLAWqwWqUCww+i3ztUo09eXJ0v0RfD8wixo6XYrJDPacrszSDS8lR0GB1saGdx6m/WYEMqLfr5ixkSqQNtXrhE9ez+E7MsUbMhvDdTxoWdGzScvMZNN/Y/behhoBLkyKVZPbtWhCAgWcZF3JHOOdblHpWioNJxBZmCMe79gkB4A2utZ29pXjZHB2G2+2pErRxAvtn+qVsN7nDDa7cX9yi7XH+KsIwFCfTfFaj4ROYzk/5WfbeL+op/8Ra3JKNqu5JvlNPGKzVaq6rrzof/AsLaD5YoI3kq6hygMONyMqpcofFltcHv5n10QotczbxwDeMPEUe8t5uZW+xbFrXe+iDnKHOLitemNt4sXOza8TE5eTxFg4Gw/guMC8ohynxHoWNZlnoFcvVajTs3qomtXyy74p4yQy6YHzybbHPwhdZfWBNAuIODTwSSmChQ0GPKzzhsccluIHpXr8QO7eJEnbJlfjXBKyZ890lBCmlzgn8JzcpYAP9pW6kaoI6f/JvkQTWwfv1VwE6D8d8v6F3hLI2t+5LA9Ga2HIE5Ue1LsxVupG4icZeBgMnbyuVsHnKss+Ak+L8FxUf+pXs143I8qKXiSDbSn43pc6Xi1KKbfrjCqsaYtkyU64V0B/UlabHboRZXYMnMV0GFtodQPmJDKZONoiWht0AHtx8EUWEh/zJcBWYQw+moj/A6gaIEt6lsZMgXiCwZmqpOsugnQa4A6Acovd30mTv8x8tBj/CDiKy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(6486002)(6506007)(966005)(6512007)(53546011)(55236004)(26005)(186003)(36756003)(2906002)(478600001)(2616005)(38100700002)(31696002)(86362001)(31686004)(8936002)(41300700001)(66556008)(66946007)(66476007)(44832011)(8676002)(5660300002)(4326008)(54906003)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dFNklkcDJ0YWg0RjNoazJGVytNWFdKcXNhL0lWdWZZTHBPNkJTOWd0RXc3?=
 =?utf-8?B?RThEQjR0SkVrRmdJazljZ2hsd0FFZERlY0pvVmZKeFBWRmMzOFZuNGpuaFBs?=
 =?utf-8?B?MHRYK0NSOVRCQ21acXRmYlZpVGpXTDBpRzNuL21DSE9JSmM5Yng0d3F0NnA1?=
 =?utf-8?B?ZG81aUNrT1RZcTloblNZdWhmNXVzM0N6ZGt1Zmg1ZkZqOWZWclJLME5lTW5m?=
 =?utf-8?B?VndxWFc1c1J6Tis4SENyT3F0WnFUKzBmU1hvTzUvalB6OTk1aUtLN3NOR2Zs?=
 =?utf-8?B?KzIwQUdYV3FYb2p1RThkRllwdG1pM085cHpIc3NSV0JCVVZ6SmJzeElKVGlK?=
 =?utf-8?B?eGNidjBoMHpvWENXSTk0YlROekFsNXNkd0Y5ZkxlTlVsY25XZ1U3Q004aG5o?=
 =?utf-8?B?S3lWc2ladHArM3lGblF2ZC8wb1JsdUtrRGNDRGdXM1kwOWNqeFlSK2pIRUE5?=
 =?utf-8?B?cnAyWEgrU3VaSElMNXk2dUJxS1I2Zm1xamo1UUFsdi9oeXdCZjlmWmgwVCtv?=
 =?utf-8?B?Wm5jRkhiMUFyYWpINE5pT1hrVmZ5OXdBc2ZXZkxDNk5FMGtMOElFbWExSVhO?=
 =?utf-8?B?d2dIRUtzUmgwdmVtUnBsSkdkOHVTbllXRWtvUDUwcTh5UitRV0Zld1Urd3hm?=
 =?utf-8?B?aUJQeGdTMDdXMnZCYityTHJEMDArcUkwOFc3Z0c3S3JlWUxOZVZicVBDZmgx?=
 =?utf-8?B?RXE1ekxiMHQyT1duNDZDbmJ4VjR2aTMwU05IbEpWdVVvdnh0SVpxUDlJSity?=
 =?utf-8?B?bThKcjQ5TWNPcjVQeVBTcDBjbGtCaUZ2VUVIUHVYd0pLT0IvYy94VkxBcHpz?=
 =?utf-8?B?WHFzNUJBNHNVc0ZzTGQ1Tm94YTArSE11WDJWVGpoTzBFMGx3cG9xbStDeWJy?=
 =?utf-8?B?ZzBPZDN1UEd1UVlNYS9BdlA4bjJGbDlCbU5icTMxOWtwSEhSMWt3VEpFUnV4?=
 =?utf-8?B?amdkTnhid05aUGRiaHl5UUNadFlIRUtWd0wyZ2Q1cFZYOVR4RDUvdmZkTXU0?=
 =?utf-8?B?a0RUZXZYcmc3WW12SFBtdlAyUmMya1ZUR0NiMmp4bFliRVYrbmVrZlRwSGE0?=
 =?utf-8?B?WjFOa1RXZlB6dG1tQ3NqWGJBV0EyUWpOc3FreHo0dks3WUwwMVBJaTRaYjgz?=
 =?utf-8?B?Z1F0aytZclI2M2pGUzV0WHdqRHIwT2R4a1h2YmIyNHRVdnVLMVRVMEFteUpN?=
 =?utf-8?B?NUQ3M25ZYlllQ3dwcE9tM0JGL1IvWnBJeW1iWHA2SG82R012YjgwSVhpOFpv?=
 =?utf-8?B?SFNlMTdnZWhJcUlMM25yMDdzWDRrY0F4Q3loQnF2cHFRYWVlaFByREVWb1Fm?=
 =?utf-8?B?VzJSeFpCYjJTSUQxY0VUVTlyREgrdG1kTytuS3NwMXM2bFVCVUVkbWFJVk1p?=
 =?utf-8?B?OEZrakw0NmlkajhjMlo4VkxEVnh5UGhNUUJENXZlWVZobElzc2R4ZTVueXI2?=
 =?utf-8?B?djd6bVdaTStQTytLZ0RuNEhvQ2l3a1FKSHBxbTBrTlJrdUhxbXRnUjFobFkr?=
 =?utf-8?B?dE8zeVZKZlZTWkpFNi9pM1BSV1B3Ykx4ZW00UWhQMDQ0NHkrUDI1TDh1allO?=
 =?utf-8?B?dS9IVDlPZW8vczdNZjRaRkxNTUlGRUZmRCtSSHJrWHJWUmlwdzBNR2J3UFpk?=
 =?utf-8?B?dXpQb1lzUm56eTJlbGYwTWkremZDbnJzbDhodXhoMkV5eHByNVBkQzcxMDRr?=
 =?utf-8?B?TzQwZCt2eGNjd3grM2g1OFd2UmkrYm8rK3V0YjNQYlZXY3FtWkRyZE16bCtx?=
 =?utf-8?B?OE5FdHVlMW1pMU1YdHdFSlJnd2JyaEg4eHcvdmpNdHR5T2FWMk1ha3J1WnhW?=
 =?utf-8?B?WlFjOTF0YmlIWDVSek9IVTRXL1Y1MVBidVBFZ1BFVmlHMVVYR0pEQ2NqV1Rr?=
 =?utf-8?B?OFR4cWw0ayttbjNoenA0WW5nakRFcGNnRjlTN2VQTGlTcW9sbkVaVW9zTU4w?=
 =?utf-8?B?T2h3YmRCWEZJMXRpS3Axb0thd1I0Y2FlVEF6QjNZZTc1K3ROSllPSkd3Q0lr?=
 =?utf-8?B?eno0YXNpVnVVbGdBK3Y5TU1KcCtsQktYNEZuL0x3djNkSWkvVTZUdWcyU2Fu?=
 =?utf-8?B?ODI2THA2bkcxY2I5bHk3eEtnbWYzeGx0YXQzZFc0QWVSNjExekQzNFNYYTBF?=
 =?utf-8?Q?liLar6QBml2YbFTOHbKCT5jFI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f02c376-925c-449c-1bca-08dacc91c0a3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 13:59:20.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uu6WxfxgiK7feBzWwRTuy0y2SUX9d+NFqAKFPqQANoe7t+xPyjf1IrI+AC7VN2ItQgJeLxkm9/jNBQtE+lh+RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 20:03, Luis Chamberlain wrote:
> To be clear I don't care about the patch mentioned in the above URL, I care
> about this:
> 
> https://lkml.kernel.org/r/d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com
> [...]
> 
> Petr, you had mentioned in the commit log for your second patch in this
> thread that your change fixes a regression. What I asked for was for a
> patch that fixes that regression alone first so we can send to stable.
> So what issue is that alternative patch fixing?

This alternative patch fixes the discussed regression with failing inserts of
acpi_cpufreq and pcc_cpufreq delaying boot. As mentioned, the situation can in
the worst case prevent udev from loading drivers for other devices and might
cause timeouts of services waiting on them and subsequently a failed boot.

The patch attempts a different solution for the problem that 6e6de3dee51a was
trying to solve. Rather than waiting for the unloading to complete, it returns
a different error code (-EBUSY) for modules in the GOING state. This should
avoid the error situation that was described in 6e6de3dee51a (user space
attempting to load a dependent module because the -EEXIST error code would
suggest to user space that the first module had been loaded successfully),
while avoiding the delay issue too.

Petr
