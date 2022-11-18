Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182262FB4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiKRRMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbiKRRMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:12:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2A8F3FD;
        Fri, 18 Nov 2022 09:12:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJz+siBLzN4Mm+gsxZyim1hOCx8hYzlEyxF7psh4HLrzDZCtpN+wKdP62DoLzF77WgaWlH+Q/oiPCmLiPxZBudgJkiDsg+xrKWV4JU4rbVsc6imt/ObZGzkbw5KnSnGXZAMirWutmKFqfRpSWJ0zSHi+4Wk93YuBi0KUVityPEAMrdyxhWKvlGRRwT7zzYIBWzr78w30KTkLLmUGNumegGvz74I92MQXCK9xRPeXTsRQ+/92ui1c4JuJ+yuKaNrXSzr02x8LH8/AaCNMbLACjeJk27vWeCrwGU2n+6NEq3+X4yvWo05s/c+rTgjcT/V+Ui4jf5p3EnNJRh3tzRe0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcnxjMEGOFARYdrov/Hp+cAKpnyPFWXtzATsPwHe79M=;
 b=HsfsPW2dZHpSxh1trqXXrUhivmENfbI6dfB9x7JgjHpJrdP2q8h3uBmh+JD2CQ1o97WsggL5611g7p+lWiSNkaJVf5BRGVw9xwMvKAmQjni05mLrqIC/wX1bVgAaQCz6zvKncSg/rO5sKfSKY1G7wV/mwz4so0Y1lLFcA8jjT1AZvQunkWdRKB0jbIZGMMw0ngIyEOsonhY06sceCn3e++z9LyKeGwvAugvHQgNX10RzXAKbUnAbW4pcdb8w8XFfUBuO89KdWOYekO/lNUlU9q4TTCKCSjiAF854bd0BIzZnnqzFDRYu2V14BPs1PKzQ9sc2JKS4oLHZNWZxxpmyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcnxjMEGOFARYdrov/Hp+cAKpnyPFWXtzATsPwHe79M=;
 b=D2djCadxZ+JbGvp+drpWQjp7VZXLjqjU4PEP4MAjElCFvQBntNHFXMYX7GeEz/s4JqkRSxP5mpT8IBNrKyPJC1DfC3jcrlvCHhPSsYZ9xIolHVmSMjfhqzYMtKO4LmXizpoxM00/3NNNcIKvQ+kcJIIqEYBsX9DeAjhSA0SHP1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 17:12:32 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 17:12:32 +0000
Message-ID: <9d18b9fa-4b22-6d12-bbf5-7ffe9eb52165@amd.com>
Date:   Fri, 18 Nov 2022 11:12:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
Content-Language: en-US
To:     corbet@lwn.net, lukas.bulwahn@gmail.com
Cc:     Dhaval.Giani@amd.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bilbao@vt.edu, ojeda@kernel.org,
        jm@goyeneche.es
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20221118170942.2588412-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 46106d86-9883-4c28-db9f-08dac98814af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXb8PJ986OD4N/D51/MeYVMW7yxfPE0C8efvHzZqUgzLAqGp+SUPMUIPmzpZ9SIELPkirCC0FZcR8ZioONpeLWWsY+dDqc3mNplpMg63QOgBhYpSKFyrRynTilk28tTgFT0qg0Ia4HrG6eXmuuiKiW/yRFvcLXdXqL4JDeHo15xsgZS5zCl4NFtcQg2OfcQJGDJFrxs9//0Ewo/eDp5DI8k7x/9u7rIqDUxuDiA7+hGreQkLIDtjDQDKW9TCqu9ADNM4I7mvZq1u0H3Kx/L5HOHQxpJ81erhQ9BuvY5ymjs3247eTQhtgcCyt0/AXal+iZExjxVLz4GyDPD9XT1Fm1yclZUFMUdy67m1YGFVxd6x9f9QDsn1e7Wfq22dH61xrMpNA79r/O3v2CXiziITqWgN3O/ZAI9VBeEqXtJ0ayJ/Qzy9oM9qICfS2H4+9Cxj/LOEcwCyAdGxQcbbvvSp0ffAb7O8t18I31yo2UrBW/g28qwJNWciVo8UJ3Yd4H+jpyehlrsIjxhnyNHsBP0C6inhUL+Y0CwCEwn+ujQFygJyXhhWUznbDpXvSw6v2DXge/pTQTBvWxMVZdGQ6/8zyG3c2aGB4MCFRkbaaxRF9MekKHySetAAXikgJwxr+vePvYH65wBKJ0lgeSoYgRj4JKTDWbZi4saqZeisjWv9B2HPOMLyFmz8GJD3aR04GqP42zgEOSuH7DKldOIzOFgnGweeCRpQZF1fzshwFeDqximYPL4bFxeUPKPvOxvRUaaE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(36756003)(31686004)(66946007)(2906002)(4326008)(8936002)(86362001)(31696002)(83380400001)(316002)(8676002)(186003)(2616005)(966005)(6486002)(478600001)(5660300002)(66556008)(26005)(66476007)(41300700001)(44832011)(6506007)(6512007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RxdzNaN1dmd2l0cmphRDQzTkFKUDV6Y0xWV2NJaGhtTk5YUmp2QjNSZEFQ?=
 =?utf-8?B?OWRkemZaKzBSeTh3L3NRb3hkTTFyQTFoVjJaRmVVWVZpdlJCOVY5bnBCZkpv?=
 =?utf-8?B?UEtLUWNYSDVIS1EyOEtVQ0VRRHd5VW5tNVVvalBrczJTUlVpejl1SmJXWWJQ?=
 =?utf-8?B?dHIrSlZZbUFYUVlsV2RWUnRucXgyZmtmSnF6VzZWTEtQZERtbmV4OUhka3E1?=
 =?utf-8?B?b3VUZk52cUtTQ1FORU9zRk1nSFZiSC9LaFRFRW92QmdQSDZOT3hISnBUWkRB?=
 =?utf-8?B?OThYUHJ4b2N3RUdIMVc3eTBwdEYxb3hGZnRYblkwdHhjcm05SktqUTJaWjJB?=
 =?utf-8?B?cm1nb051KzdhMkRVTFR2N0pqcVZ0ZlY2VWNpdERydDZ3emNNdHNscUYxRk1v?=
 =?utf-8?B?MS9TS1NkYzZyd1VuYlF2cXhpU0dTdGswYjExV0RzYldiTjFjblRVN1llbDBY?=
 =?utf-8?B?b3ZLcHpMTCs3eVNGQTdqaTZxUWwwT3ROanJGTGNtMFVORmlEbXVUSGJlbnBU?=
 =?utf-8?B?bzFUQ09malc0aFh4UjZjMnZ6VTdZSVo0T2pHMDhMbC9ZUDUxbFVBZ1NVVnVm?=
 =?utf-8?B?UXNlOUVjdU9tb2FWeVZwa0VWcU05dlBManlETEFoUTFmK3dnMkFwWTh0aCtq?=
 =?utf-8?B?QWYzd2NEcFhZMURlYWFwaTIwQVpKTE83ZEhNekZYRjJCSStZYW9nUmNnZWEw?=
 =?utf-8?B?MnFBOU9aVDk3NEk2anZRRTAwaFYzYU1jenZvcXRFUVY1VitOZXprVFh3STEv?=
 =?utf-8?B?R2RTdk91d2dENm14NDdGN2RUdVp3eHRVMy9XbS8xdDFQYlB4RVhLT0hHMnd2?=
 =?utf-8?B?VEdNaEg5ZlZxM3h3cHJCSDFPYndJTTlaQU9aMnFEaXZYMUMwbGJMRGNhWmZt?=
 =?utf-8?B?REhScGF6TDZBcDJmc1J3MkhWZG5lQnByTUZKZkdSaTBpTDlmbktDVFRETUdF?=
 =?utf-8?B?dWl3SzZiUkJmdWptZytrRkx1RzA5dlVtUzZhQlRFSmNRbGZWakJBaXllOUxH?=
 =?utf-8?B?QTVIT25aWm9VQk02bWJIV3lEb1h2WnhVREJDSnZHL0piZkNKdDFnWFkrcGNJ?=
 =?utf-8?B?SjRRQ3BLWTZkTFBGckV6YTY0TnlOSTd0SHFxOG53SFFaZjdITDcrQVJRVEEy?=
 =?utf-8?B?b1JYcWRTNUFiNUdCcndNMzQ2SlYwQnlCY2N2NUlzam92QzloWGlubjZNVXBV?=
 =?utf-8?B?TUVIaENmQW9DQUxVMnFaRnJvN2FxQ2cwN3RvNHRBb25kSndSRmFYOGxoMDla?=
 =?utf-8?B?QUl4b3k3WTNJSWxlTjVLM01sd1V3bEI5SjlYd1hJMTZxdyt5VFltVDNwV0Vt?=
 =?utf-8?B?bkpQNGZYN0FtYUNwVVdkWUs4eTEvM0tNTUVUMklpNlRKRVQ0c24rdm0rWnVF?=
 =?utf-8?B?UTVNM0ovYm9ORUpVOS9iOGxKanArbE9kYnlaZnNzd3FwMnhPQUo3OXNjbUEz?=
 =?utf-8?B?L21keEJoN0JibDZObDh3N0NKOXZMWTQzZ0R5WVR0QXpQMC94MTZBUW9nSFda?=
 =?utf-8?B?RzRWS0tkMEY0L2Z3R01zUFlSWFY1YUlrdENHTzlpKzBUWFhqRWU3bFhjcHA4?=
 =?utf-8?B?NFlrenNzL3JNcUU2ZUVYOUNOMzFGd1Qza3U0ck1VTDRSS1kvZkVQNGd1dGt0?=
 =?utf-8?B?ekQyNHpsMmczL1ZXRVZFaHU2YzQyalFqYVpJbHJ3aStYa0lGTE53WDdSNmJ0?=
 =?utf-8?B?MGxlU2lFN3F0NG8vZWJxOWgwZS84VlFRUk12NllZNjJiTERNWjA4endKNUdD?=
 =?utf-8?B?YkRNaEwxRGh2TWthZitiL0pnSXhJakN3Y1RZOEI2MFVQNDd1a3JFMjFLVWs2?=
 =?utf-8?B?ZmJKTDhTQldWSEFrS3JxVjI1NDJTcUh1SVFmQjkzZ2lYOXc4dmVHeDNuYjJZ?=
 =?utf-8?B?b2dMcW9wWmw2LzFDdkZJRnNRSGhWU2t6eWxqK0gza21XN3pUYk9DamZPbG9n?=
 =?utf-8?B?VS9nMFR3L05HZGthQUVycnA1UktMZ2FKN0dhUklzaWdDWmUzY0FvOGE2c0FG?=
 =?utf-8?B?cWl3elh2TUpxZVRhSnVDbzNycnh3ZlVKNEhjSXN3S1VVYkMyWTVFTHdzVm4v?=
 =?utf-8?B?UTl3b3pSTVRZcXJ2UDFVQm9UcGRtWlNXckVzMlFIejZJekhZdkRPTy9NRHhT?=
 =?utf-8?Q?7AWIVMCbe0Ip2SeJbQKNyvjt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46106d86-9883-4c28-db9f-08dac98814af
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:12:32.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqSLsN+YIWHtiT+p0IKJvP2kvu2ELB+H6gdcJfve95RRoKns2CqWUXXet/050h9PpLp1p1gnH/th/eh2Zrkclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 11:09, Carlos Bilbao wrote:

> This is a cover letter for just two patches, but I should provide context.
> I was going to translate kernel-docs.rst when I read:
>
> “Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
> email address is defunct now.)“
>
> I figured Juan-Mariano (CCed) may keep a Spanish version of the document,


Juan-Mariano, my apologies, I forgot to put your new email on CC. Best
regards!


> so I searched for his new email. He replied back proposing me to take care
> of the document from now on. I will carry the torch with pleasure! This
> should also make Lukas happy [1].
>
> This cover letter is also a call for anyone interested in adding new, more
> up to date references to kernel-docs.rst. The document has been abandoned
> for a while but its original goal is still important.
>
> By the way, Jon, I read in kernel-docs.rst, regarding LWN.net:
>
> ":Description: The title says it all. There's a fixed kernel section
>    summarizing developers' work, bug fixes, new features and versions
>    produced during the week. Published every Thursday."
>
> but I don't think LWN.net is published every Thursday anymore. Let me know
> if you want a third patch updating this as well.
>
> I also use this chance to send translation to Spanish of the document.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/process/kernel-docs.rst?h=next-20221116&id=f46b4b168cdb3b16ae8c7792c28d0b921db1932b
>
> Carlos Bilbao (2):
>   docs: Update maintainer of kernel-docs.rst
>   docs/sp_SP: Add process kernel-docs translation
>
> ---
>   Documentation/process/kernel-docs.rst         |   4 +-
>   Documentation/translations/sp_SP/index.rst    |   2 +-
>   .../translations/sp_SP/kernel-docs.rst        | 643 ++++++++++++++++++
>   3 files changed, 646 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/translations/sp_SP/kernel-docs.rst
>
