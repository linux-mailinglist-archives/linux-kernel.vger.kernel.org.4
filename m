Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF6771FA3F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjFBGk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjFBGkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:40:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2117.outbound.protection.outlook.com [40.107.22.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B6D132;
        Thu,  1 Jun 2023 23:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5oDBD/zMcDy7Mw/30YJcdAAHkIc76HbV47V0yhFjlGwYRXFLk+CQyx3r5EWF7HdNQC+1fEG1JfMtfT9bmCE7UrQbMNz01G7RDjT1R5X6CiL0xz4jBLnr00Lw4fIghHPaJOQeEsOs8x3BEdjhEGqT6/P+Li2cg9cQfT3mOuekBaNIviY+aCZ0pY2OJeuCnvMgrUhNdtor3RDQB9mliHZnTH2S/QuPv3aMYTcmJqn9FgVzmshkAAk7nCqMfKywG40b68sSNYfHEIZQFZbBE5m0pcLhj93ANPmedYwXNERVI7pe28uLQR1lD4/fLDONOKcZboJ0wWCIRmOfmdhTec6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43Ht7LQ5Ql/kS+7LVyOcD8EtP6Cc4VqdEghPCoc+hQw=;
 b=SjkgTjaORtUtfT9e5YsA6IcCS1Y7ETwzO+Ur2o1eMcMa9MZtRm7PXJpQvHZNBsJhA20NJSaWReHM3StvonOuHNGaQWbSlZXEGwAa7TtBBLqAXBzqkIgMrttoxIT8nimGAUgjZzX9BKgZm6UntRQki8sdz5DK8b2QbXIVvfDpMzWg7eFiWdYy87LYqh+bVJjD9xeMznx11jbuKlRNrZcCCjjOFQgOn+i/cR5nPUZjlLwOwveiL9AjHNPFmKWKrg6xjd7Z7f1cs7IHGJJYEMaxsolKJEafQnx4dndoyEpLwp8HBfpchdTDvk/n3q3JCp4Iz6IBXQYgYbt5fk6JZ9JdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Ht7LQ5Ql/kS+7LVyOcD8EtP6Cc4VqdEghPCoc+hQw=;
 b=mMEOcMNAwLUDQsR8gAJDS9sYfJDdGv2cfTNUroJkoj+HjBWX+RPFJCDVkdZICRM/uI/VF74C7FTsa9e1Z35Uq8nPodxjuSMaqJeGO3sjigmJdq+RANqS1FdBng//1emi0T/lOruEvtXAVlrsAPfoDglwItCmrwb+smIgWTxCK/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PRAPR02MB7930.eurprd02.prod.outlook.com (2603:10a6:102:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 06:40:48 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841%4]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 06:40:48 +0000
Message-ID: <b347d69c-b0c0-fb1d-d774-7ce5319b63e3@axentia.se>
Date:   Fri, 2 Jun 2023 08:40:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: duplicate patches in the mux tree
Content-Language: sv-SE
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230602133148.1fc0b305@canb.auug.org.au>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230602133148.1fc0b305@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::26) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PRAPR02MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7a94a4-0d9d-4b03-333b-08db63344c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPrTxmiz/qMpj+0j59f2JbYXl92OcmNbYZEIUrSsb6ad9hIsY4mpDuLgNQwOsAbxrzvJft0Ou+IdKqYoUEQwAQCAc0CPudJ6no1wQvEywwsD9hFlBVb8vhIhF4bECHmklFoQK1v8RO11LZPhnlaVqvjY+7cDYvGo5DObUCKC1ayu27VqGRjFOK4hNz58++TbHxGhidCdkDYdow+Kq6t7lB4T3KXbzSKU4PvUizwyZ9wVpCm3PKNZxs7xnZDym9W28sJhpOe2Vqvq9DzT+0HpRaojj101DJYq3+tO4LIb+8ZnBAOH+2hVkdLQXBKIbySaYCd30+NYujZ6KBSzEozWCJ2zxZdm0zwRMI6BewdANlRLwvgoyiWNLvW3tQ/arpZ5ROgtFAvGUrajYWTtDGu5vo81ZkNPAh36NzStZX5+YrskuVWJkMrZNz5bhO/C8qyHq6OJEnmqClnhMhq6xum4DpOpcg/gqBnpRE65AyPXZLXVullYaM8KhdY+3sgwLF4x3V2dNt47m+mx5OGHxa13OLlrnoAy3j96uQ1giYa58VhWdRyyiE1UGCGMMn4Z0hJE1QwQb1G/XaEss952fPLQV/c3qiCEF5NN5pf5zEaMbqmrxJPwq1PdnGq5Di5VZwKiuLiOM/ClcUSYpOQDC42/ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39840400004)(366004)(451199021)(478600001)(41300700001)(6486002)(86362001)(31696002)(66946007)(316002)(4326008)(66556008)(36756003)(6666004)(66476007)(5660300002)(186003)(2906002)(31686004)(6512007)(26005)(6506007)(54906003)(8676002)(8936002)(2616005)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVlMaU81WmJhSE1nZDRLTlc3ODl6d05QUjIxdHN5a1BLWXlCR2V6bkoyUzZy?=
 =?utf-8?B?RmJqaFNuMlFEU2g0VWNaTUpkZmd5Q0wyVmtVYUxtdjJWMUJDaUduTk8xVk1Y?=
 =?utf-8?B?MEJEc2t2dDhMV1h6Skg4N0txWGtxOWtkaktYQWsybWNpdXZxaFRJbCtLbnhk?=
 =?utf-8?B?MDd3ZDFxV3VqaDBBamFkUzc2a3ZRZUpjRVcxdFRRSkcxVXVhYytlcHpjbWZr?=
 =?utf-8?B?dkZKTklYM1pjZDdxaUtMMEJlMDYzdVB6Z01pRndjVEExeW5Ed0FiTTJrVlVx?=
 =?utf-8?B?L2tlaTdYSFozb0NhVmJOZGhheENxa2VzNkJiR2FRTE1TVGZubENIODR3dW1G?=
 =?utf-8?B?QmhsOXhiaEpyQVVaWWNLOWc2Sm5hN1l0RkE1QXlOYXRNZEY5aUNwN3NmbW1R?=
 =?utf-8?B?YUNCcDB2WW1wT0FsWUsrVVZic2p3bC9VUlo2d2NpTmhUenVxUmJWNm5OdDJq?=
 =?utf-8?B?VGlITmdxMU40cGdzQnpGZVk3aW02Zk82UDEySFJUVTFXVXFTM1RIMEtLbGpT?=
 =?utf-8?B?b3VLa3pnWWQrUE5zTEVYU3JpWGdFMS9OU2F0SWVmbkxQYmdXZFl0MENzMFNt?=
 =?utf-8?B?ZkNEeUxtakN0clk2cm5Wd21Gc2oyanpVcDZwL2tKeEJaZmdURGpTWUJwanV2?=
 =?utf-8?B?R2Y4S1dXTFFIbzlYbVc1OFYvRlZXUVBrWWVONVo2SlIzWElQSVIya3IvWDZF?=
 =?utf-8?B?RzdDSHBhZmR3M1V5MW9maE4vamVrSmVHQWVaNXNCdVJZVXRNQnRwOW9EZi9J?=
 =?utf-8?B?YWRKbktibTdpRXk3NEU4YytQb1ViRFV4T3FxMDV4cnRpSGJ4Qjl3WXlYZ0l0?=
 =?utf-8?B?Ull1SWdwVnF1ZWJsVlFZQzJ2Zi9Sak9wRWc4akx5V0x0cE1tSWI1b3VQS1Nx?=
 =?utf-8?B?T1pGTzAwaE1tOFlna0xESnB6WXFXWURZd21NYzZQZTRWTFU0VUhMT2dYN3pm?=
 =?utf-8?B?VXkyaVlxR1ZPMGZqbVJiU2xqQVQ3TmJrSyttOWhnUWo5bDg3UkNlNDZmcGFw?=
 =?utf-8?B?WTBMNzRBWWsvcFZWZnJ3Tmc4RWNNTlF3S3ZQbk9haUdueE16YmxraFRhTjh3?=
 =?utf-8?B?SHFUZjhaSjIxRkNVOWZoVjAwRzNqSzZYUFVDQ084U0lWU2ZRVEQ5c29VRWQz?=
 =?utf-8?B?aUdPa1N3OStLVmg1ZTQzL21qajdySTlacERzSCtaUnBxOGRweWZwaEVRY0Zi?=
 =?utf-8?B?bWZxVzMzVHd1Znkzd254cWtjK2pqY2tLTkdmQmJLNitCRTVIOUcrcjNsVm5a?=
 =?utf-8?B?WFBQRjFWcC8yUXBaM1NBNUN0MGJoY0pCRk1iWFFIelZtK2hzc0tLd1BlelQw?=
 =?utf-8?B?czRlUmJnRVBtYzk0UEJ0L1hLR0N0bUk5UW10aDg1UW1wZzZZQlE3REV4RXRn?=
 =?utf-8?B?ODUvY1h0UzBhOHJrZEJiK0NtTEdqSWJpdWlicWwrSHF5TFNDb3VRMkZFMk00?=
 =?utf-8?B?VVB3NHlLSmZLNVppT0FuM3Bsc0JaQlRhN3d4SzdiWlJNUzkvTUtVSmFSWUtI?=
 =?utf-8?B?ei9vdVlTVldDc0JQdU93Z1ZXZmxGeE05NTRVcm0vbmYvUlZZNnEwSUsxak9i?=
 =?utf-8?B?YXRhYldkb1RaNmhWRXN2ZGw0YWQ4d3JKcHcxL0c5aVpNdEFYdEtVbS9laVN6?=
 =?utf-8?B?dnNycFZjYnpvdEIzbVNPbXYzaWxMa0JLUTVDTlV2VmNKd1FkLzQ1NDAwOVBE?=
 =?utf-8?B?ckkyNTBabFIyS08yVUVSdEZPTjRxV3pjUlRoYVBFRDlWdXZVSFNCNWRaQTl4?=
 =?utf-8?B?a1E4YTUrYkVoVGZaaGRrMGVpRHJONW9iR3RSNzlQZjR6Vm5qdWl6cERMTUZy?=
 =?utf-8?B?MElhNmRmTTIwWnpSc21RNFpSWDJlVVVxMThBSlRFMG8wY3dDaGcyRzM1bW5i?=
 =?utf-8?B?SGNqWk1rOXZZUnc0cVh0MTBrdFNwWGd6SHpZV3M1QVJaRkZ5S3RiYkUvRW4x?=
 =?utf-8?B?QjdaZHZPcGFSTDhsNktObFJMQXdPZEM0Wlk0azl6WWc3dlBSKzVuTXV1VGEr?=
 =?utf-8?B?Z3FnUTFsb1kreStmYXNjeWs1YUFIb2I0WUdvektra1RKbGp5ZmN1Q0pXYllm?=
 =?utf-8?B?UTdoYkxqZy9tYzg4YnJJRGVKbDVGNHRKNlprMit1THhtKzhtR0s4R2YxaUxY?=
 =?utf-8?Q?PoKmUkjAeMe3BHbIhlGSL/kYx?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7a94a4-0d9d-4b03-333b-08db63344c87
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 06:40:47.8497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gmy3lDNCllM6TPgiCjSyuPhauqJHBmdMjTVUnpM3T6I82MpT0cn5OM99UVZPSTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7930
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-06-02 at 05:31, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the char-misc tree as different
> commits (but the same patches):
> 
>   213700a8b96f ("dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC")
>   76ac787cd671 ("mux: mmio: drop obsolete dependency on COMPILE_TEST")
> 
> These are commits
> 
>   8258d997b874 ("dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC")
>   5ccf40288ca0 ("mux: mmio: drop obsolete dependency on COMPILE_TEST")
> 
> in the char-misc tree.

I didn't think this was an issue, so I have now removed them from the
mux for-next branch.

Going forward, I will try to time the removal from the mux for-next branch
when I hear from Greg that the patches have hit char-misc/for-next.

The reason for all this is that the patch-stream for mux is just a trickle,
so Greg is not pulling my tree, and I instead send patches. I still want to
see how patches fare in -next before I pass them on, so this is probably
going to happen again from time to time.

Cheers,
Peter
