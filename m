Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F465DD37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbjADTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjADTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:55:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455817881;
        Wed,  4 Jan 2023 11:55:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IglDCBu6jMGPJQBdU8DTnJmKG3LaIFmsW7QPoQmQ+C9+2Co1AlDo3lhbmOOb/mgsd8Pc/BK3n4of1fYSAxWFWQ258swmApsIFDJbY/zKrmwcuZmbMIl9lO0g+92E8BMEIG2xYexoFJ7ygnY72/TILiToJMcX7zS8qvmbG8bBHRZu7wBfy//oPEnUL6m+dgDSnrvgIdCt2eddnFBVP/r0FJyfIoniQoyK/qi66AwpGmBNAfN5UzbIGBD6711iXC5hc2KgidbD/AgOosEftXQqfDq0vkRujevU/lxSLpbSWsQquV4pS4aUtgMGsvfpVaeLSmIXAv0ZoYpQ+N6lUBCHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sdd6sX4YmhrKe+4gBAZ19/+3dqYlV28Sx2Llv5nzplA=;
 b=RcD4aJ+Df912LOoymUctIGHxQhYbyOkmD8o6onanNKUTJvPw6BxWJjNp0l6EgE1gPJFc7QWKeeplOe9y1X6ZSrGVQXMXe2l+jmHmOofuGnCQmrkpGK6hvD2+bx4hJQ/oUpi5wSXlhdSIKi6M93fKiY+GB3LmftjcWdib4ihUqlBK0DXf/nkvcaTanYVSGb4kRql3okTdzzDprGET8W/CPEGx7+1C0Sih8Ht1a8HyzCG/HvfF/Xeefw/+5Xiymdxpdti/xZpXmCCFSSpL9MrDqGSzXhb7RpnwnZVfQHTbK+TRG4A2zTD5HRgYXY1pxQdNjGpjiMCenywnAvvG79youw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sdd6sX4YmhrKe+4gBAZ19/+3dqYlV28Sx2Llv5nzplA=;
 b=dqBVMzCuTrOCw4qO2d/k1fKqxia/aEA21JT3NU1cODvG2vY0vvv+BHBhxj4A+0fRFwd4ZQ/EmkYj6f2c16tFGKtVTyD/bLrbXUxWblDYA0h+1y/w0E7obnd628X87reW3NjaqvwY+08LQ+XWq3kuFhrrocE5MRLn1Ubb43NV9xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 19:55:00 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 19:55:00 +0000
Message-ID: <f94a3126-41ba-2263-eac3-ac877042c9ea@amd.com>
Date:   Wed, 4 Jan 2023 13:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com> <87wn64fq7d.fsf@meer.lwn.net>
 <CANiq72mC+WzOxhZVtEvnsFYzuBPkd51=TYXK01ztcTZ-CAcUiw@mail.gmail.com>
 <87h6x7cfiy.fsf@meer.lwn.net>
 <CANiq72n3qnWwDjp0E1xY1m15qhMHz8_AXcL9hstVM8Xwfi=pbw@mail.gmail.com>
 <874jt6cpw0.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <874jt6cpw0.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: fcea56b4-f59b-4d7c-711a-08daee8d903b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3vg3TabNOUvzfIIvziu/jKQBYYIog1VLVv3NHWm8BnOn4Mn7++SNMYMLYUgTOjytCsKDMHSQKxBne/b/W3QUfIIaB3MVuDZldLWRkZHIQMvLhI1aiGN/0YhSg2Np3Jsa3UVCoQOIosgtrlTNrTqhTJRwEO2HucDAda+uh52lTwPkaSZ2niCmT6JBxLtm4FQCtJPR/oJLSzMKIMTqm1IVz5yQJtuCFwfZS9isVZM/2/TZsC15X6defuuwSN9V/RPBCLXs/H1efJsZxzYV8FWKGk2NtVDFvO3SWSOAzA6gYnRKP5qNCwQ0zvcIlIII/wBI2reeaYdw15MZC7MS8rBoa6zOKx3D05UWHnwKxh3w3rZGTygEZ5fudfrUYbKsplgmcTBds5ylmfupioDH1/vWiHF7BKge0co99nrLl4C8PbE9D9ivFN2iL/eMiPCoQno78hjEwt9OrzPPA4Prrm8mAZOYZV11VlaAyI4kUQwbDp/Pupe/ArCPLoeW62Ah7Il0EdQvxvsXh+q8nhBT2XERNSYmKH01LVeX6RHx/46LGP5Fvu/vZPsuVHo7QWFORpWcZXscBy5hygY9lLktvpNVox1tJOEWNTzqR9XIHlo+dlPzFoKLDWy+PiNutZ4+Iu9sh5Gdddjb9yGKk6JE6j5wzuDBeMD/PrOp9R+0+pD4fayJZTfr0WCOEyGLebm/kHJVozRYB9M5ZGbNhq3du45Gan9XKaF11ll6xvLbedFEzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(31686004)(36756003)(31696002)(4326008)(66946007)(41300700001)(66556008)(66476007)(110136005)(8676002)(38100700002)(6486002)(186003)(53546011)(6512007)(478600001)(86362001)(26005)(2906002)(8936002)(2616005)(316002)(6506007)(5660300002)(83380400001)(4744005)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BtcUZJRUcvNGdIQjdjV3ZvTDVSUUozVlpOaUJvb3lncjBOc3lRbjRMaFQ3?=
 =?utf-8?B?UjBYMG1pMmxabTVuZ1pUVnNWRUNGSXNYUktvMDZ0R2dheWpVRm03Vk5MOWpK?=
 =?utf-8?B?VTJxb0ZpVHVTcllZMHRYYk81a3U3cGN4anltSGpKeWFLWVlhR3BpL0tyQWp3?=
 =?utf-8?B?OGVmWHEzdnlaeldGQVpnaVBkSXc5eENjeWxkVW05MndHNThiYVBRbEp2d0hO?=
 =?utf-8?B?ckoyUElQdmlDT3JsbHl2TDNPMHNlNHNyaTBIc0F2V21QUTFXQmRyYWdMYlk1?=
 =?utf-8?B?TEJMTGRDVndoV2p5bHViSGgrdE9FSnA1V2RMcGU5c2dwcU5CaFZqSHhqTVQy?=
 =?utf-8?B?bWs0TXFKdU4xcmYyb3NYNmc0cExaQTE1dGV5UFk1Q2tyUGMrc0t0eHd6TWhI?=
 =?utf-8?B?V1R3dEUrUFRTSE1EaFFBVkRGUnJIMldKZ0FBUnR2WjNvUlpER0VRN0paUVVB?=
 =?utf-8?B?Ui9kaUxNRk82eHpJQlpUc3B4YWdCcDhyQjFVeTB0QjlSVE90S05kZHVwY3dq?=
 =?utf-8?B?MzJyL3Z6U0tOYkg0dklYejRVNkV5N2JNQmc5RjMrRmpPbFA1NUM5YjlJNmVo?=
 =?utf-8?B?VXFVQmJjNmkxemIrcjhlRWdjaFZIWnJiQ0d6MUx5b0YvZ3pkM0F0NGt3Q3Jl?=
 =?utf-8?B?OGc4UlFCNVl3S0k0M3JZUm1OeXlwbENBY3RGN0o3VjltZFBDNndRckJJQ0lR?=
 =?utf-8?B?YnB4ZTlDaUhUaG5KWXlpN2tRTTBQRklPMnppemE4KzF1Qy91OW5pYkp0WjZE?=
 =?utf-8?B?MUswa3VjbmFPMVVoY1VEajB1c0Y3TTJuU0ZlUG1GV1lvRDF1QWw5SkRWZWZT?=
 =?utf-8?B?U2JMUEIrVlZzdFUyN283T3B4N0VjWWs5VzNrenVPelVnOFlXTXNWQjFrcmd5?=
 =?utf-8?B?ZG90NDJTRHNwMWdkQ0EwUHF2YTNMZWpjNHVOK2oyd3o1dGFmNmwwMS9nK2VI?=
 =?utf-8?B?ZUVvd3VaenRNNCsvR2VUeTZta1IwWUcyTXFmcDUxeGtCUlVYZStoQ1N6bXlj?=
 =?utf-8?B?cHpUWm92eVNxc0pYMDJsZE42QlVmeDRSWE9QMThFUjlxSWtaSUZ5ZHBvd2RR?=
 =?utf-8?B?eDY2cFo5REQvb1RMM2pzU1daUm9WRWlnN210bzBLRmczbDlsSUh5cEtmWFNL?=
 =?utf-8?B?NnFJb0dPTDd2ZjNRTzJ6VzFra0hZZER0OE1XenZEaHdoU00zZHZBNmxiY0RW?=
 =?utf-8?B?Y1VBeDlFN0lKYzd1UndsRGNqV1lmdllsL3laNDZwT052enJEU1RLVjRUNElq?=
 =?utf-8?B?bEwxbjdLemFZYWc4SDdXZWx6U0xjdmdZMVBrbGMydGFHKzlLcEJYbjJGUFM4?=
 =?utf-8?B?MHpIbm85Zmp6RE1VaTVubE4yalJVVG1tQ0JESWM4SE1KYU1taDNKb3NCalZi?=
 =?utf-8?B?YlJ2TUVkQmNxUmZBTGJjTFVicmpoWk1hTDJDK1hXTXRTdzRnZ0pqV2F3R2xh?=
 =?utf-8?B?aXMxaHloakxMbzFqVXRJczM0WmdFRHYrUkZsMnBYa29SWmhEWGhvS0FGcjc1?=
 =?utf-8?B?RmR1NWhLWG41RmZIdE9iT1BMM1F2bFVVc0c1N096WUpFWlIyYnJlQkpjYjhr?=
 =?utf-8?B?RHFvVUoySzdmRGxYV2ZHc2x0V3RZTjF6R2dWS0I2cnlzNHRiUktXMEZ0S0J5?=
 =?utf-8?B?NGNpVjlVc05rVy95WDE4cGNnYjkvRXpZdndzdjROUWdwSkNYQkQ5ZWJBN1B4?=
 =?utf-8?B?UEVka1lFa2Z1N2Q0bXo1SllncUptYzBRZG1YMjQ1RGhZNWd1TW42TU9zT2V0?=
 =?utf-8?B?QUx4eC93enhvYjZxTVd2ZGFpcXUvbXBDanZzMVI1NTVsdmZXdWM1eEJZUzEy?=
 =?utf-8?B?SjFvOUNzT0EyMTAzS2JzdGZRMStQVll0UHhYT3ZoT1p4QjZOVkVCeUF6Z1BQ?=
 =?utf-8?B?OW9rT2VickMzR0R3a0FPY2luZFpnYzBjeDdscXZpYnl0Nk03WGhIZGpjODBh?=
 =?utf-8?B?b0ZaVldDVUs1T09SMTE0ejdDdHVzbEc1aDBkOWNiVHhGR1NObmd0U2lZN25j?=
 =?utf-8?B?L2ZaWXRNR1JYRGJhRmRyelp1MnlnWlRHQ3MrdmFJYmdzS0VFandmQjJsRUY1?=
 =?utf-8?B?WnZzYTF4Z0dPTm4yQUpVWk51TkFjYWo2cGp0U1A4SDhsTTNRb1dXb3Z6dDBN?=
 =?utf-8?Q?kG4y6dLiTcgE8G7bsKtnIVVUF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcea56b4-f59b-4d7c-711a-08daee8d903b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 19:55:00.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZVsQFAe6pjuxfVkLFS2exwfBqDD0HwuIqU1mH59ZLrxdrflpcnv0SJCiGIn32SYkGU2HdCH5DML4f6p3fzaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 08:53, Jonathan Corbet wrote:

> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
>
>> I think I understand now what you meant by "fail more gracefully". I
>> thought you meant fail with a better/proper message given versioning
>> information or similar, but you primarily meant avoid breaking the
>> entire docs build if the Rust part fails, right?
> Both would be nice, but not breaking the docs build would be at the top
> of my list.


There's a bunch of simple workarounds we can use to keep going even if
rustdoc fails, if that is agreeable. I'd test but maybe something like:

ifeq ($(CONFIG_RUST),y)
     $(Q)$(MAKE) rustdoc || true
endif

or:

ifeq ($(CONFIG_RUST),y)
     $(Q)$(MAKE) -k rustdoc
endif

or:

ifeq ($(CONFIG_RUST),y)
     -$(Q)$(MAKE) -k rustdoc
endif

> Thanks,
>
> jon


Thanks,

Carlos

