Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9768F640AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiLBQbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiLBQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:31:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D398385;
        Fri,  2 Dec 2022 08:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bvf/EIptm/lgOEjc1CKorxaRxJfR/hb8g6kZgqW4VQ82J/+G60HJHRl1et4nL1sDkQ/29PqO1eaOVR5SUDsKJ7/urJRyGeaHkhx7AxLKBB26yFyjDwDWn3O8oqTwpX72cKN2VH/j5nOkalS2GzkptuHEHowEldE51f4MJ0CJrFz0aQi1OEmwzK323+ANKOfffOxy+ZmiTkCFYPhXOuA+al0ZG3Eq8hWnDmj8NZL76xRRZiUp2Txyvza3kmb7ZvoePjqg9mqjsXUgHbPz8Uz/7X9cqs7I2yMEz4u/xdulDq4k0N5c+HUtLswxxD8ATGb5I382aCMIPOIQXUs4ocV2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q+TSxkBjfSTUQpoFCFtXpfh1hP7OnKv6jBKiIInTgw=;
 b=ZOwFcdea/ZGgq9yt3ViA6BDk4AaJso82UBFUw29Do8l5g4CyK34ahyMplHNv+OKkvMJTL8byxqHfsniejh+BU76f3ennD2TWkalwZroLEho3cHk28VQNoE+jsTt6yL7HRG9vovFBjmHiIlnjLaF9mWrKvZiL670TvqVdjcJeGSGNlEMg51Fz0kDY1sQ0b6cQrgqRMyuYqwCO1WYWJuzt6OtaiEkR1Cb/RFHrcizXwBgRMzZ++vCdbjhEFHi/GES1oVnDGjTHjVSyg4fSlLSWAd0qXHoKfHOvdETJdJ/LxHMdSc52m2MHXSYL0xN00dIVnPZwdzhDVJX//95dZ/paRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q+TSxkBjfSTUQpoFCFtXpfh1hP7OnKv6jBKiIInTgw=;
 b=qLdRLqd5EiHDNgS4JTzDoKwv7mbasOCHDQuHE+gk17U+h1pK2GzSrT0HZfrSCeUieuwfVhoW3y56NJMRDGJY69zF8uuf4h/gPRAx1TUXkWHKic/FP/Kdx1CoTEhbHTzd80E7ib0Z5MNSG91soG3+Y/gwxhHli5a2jJqw0GY5v4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 16:30:48 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%4]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 16:30:47 +0000
Message-ID: <0d6fc9fb-b875-e3fa-fe89-c40dab63fa91@amd.com>
Date:   Fri, 2 Dec 2022 10:30:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <CANiq72nMY5f85tJJFg7AFsh4YRrKObhurhT8TVawYqoZU+J-Fg@mail.gmail.com>
 <15942593-5ec7-77a6-8637-61ca495d7528@amd.com>
 <CANiq72kkkbhYn44Mxn=55SLNHgqoAyiEadOAkprNpQOMaNAHUg@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72kkkbhYn44Mxn=55SLNHgqoAyiEadOAkprNpQOMaNAHUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:236::9) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0d4c83-6033-40f5-a455-08dad4829158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRpJC1FZ/mLon3Sp2ZrUUsZ4fxeh57cUHY52J9kj/N1UHaGhbMZlnaHFa1qPnh1D5GsiqHydhLkMude2LZNrg5DD/nCO0r2get9GPiH/valXacRsjWpAg4vtry/7M5SkZM0tIqG/0o6xiaPxKcEwUMRTxIjfaSH6thumJRzAAYocA8HjQWY237YCKOBfmVCPWwR9XoPaXko7wcHgGKhYZ7nXKn7/f+p2Rj8kY0/Ms8WLlxV4O9Kj5BYEau56zPFzM76QsfyU8OoM+R/BBS+UrBtUhigb9beumTV/ipPB2ER+wPqyrc+0RzzTfLXdiljRIJRZDY20IkfW0dFhDfU43DeoVbaZ+xTRyGiPDJdbGaHLbt82V+jruMqO3Rp3htFuGj0aspZd3qHeWRqW/eKGvWPxwPnzZzRFwvrtIRO2JrdR0axXF7kqZXWeNGLcKngQrgmCxMhw5JvB9A89evCdyNaN+CjjvBQjllio9H+N13hWqyw7cI5G6I1sNEiVL87XzkGtRmgk36UQ/UHrwHl0W+zCKrxL9NdPJR+34ovUv3uL3XX+/khylAvFbR1UFPg9CvscmLk8UyQqd/hLYaKyPP/0NxBMw4dIRluX0AUOsNntqqx7oCUUF1KO2oEGcFtjPW7ZY1Fgt4q0QsRA158EwR6/kEdAqhjzclyE3Hz5PjBjQ3pq3N7ImgdC9wHB7TTPdKexJRkW5yQEgPpv5RhDnEQaAQxeS2EKrZ3Y+wYi+5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(5660300002)(31686004)(66946007)(66556008)(8676002)(4326008)(66476007)(44832011)(41300700001)(2906002)(38100700002)(316002)(6916009)(2616005)(31696002)(186003)(36756003)(6506007)(83380400001)(53546011)(6512007)(26005)(6486002)(478600001)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFkY1ptaFpHcDBPbEl2RHFNM3BCQnIwenJHSUFiVXBYdVhRWlJralhyNnor?=
 =?utf-8?B?YVp6NmpST0pWdG1ZOHpmZmZCUk04bDYvc3UzRkp3b3VNME1yVDF2QmJ0R3JR?=
 =?utf-8?B?V3RFRVl0dVlTbWZ2Nk51NFF4Wmh2WHR1OElaZFhJTWNCOVEvOGpqbnI3ODZL?=
 =?utf-8?B?VEd6d2dGTkVxdEJ2MXFVNmEzdXpLZUd2OEhJbVBENzgxSGxrdXYrNmJBWWdN?=
 =?utf-8?B?ckwzNlJ0WlUvbzVjaGhRSzJvRHN5VG52YkRudERyT0xId1IxWTJTZjR6WFpP?=
 =?utf-8?B?RWZmRjlodCtpT0ZmM0ZCbWhxWFVlSHRyT21rR2dqL1VMcEwzOWJVd2ZoQita?=
 =?utf-8?B?dEVRK2NUcGFNS2txNDRoVWJ5eGh2MkQ5aEZqb0o4d3A4ZWVvTDdwT21lNlZT?=
 =?utf-8?B?UDNMNGplNGNUKzZYZ0k3am1RSUlTbEVEYk9aaUZhamZIS1hHTHRuaHVpeSta?=
 =?utf-8?B?THZ3OWcwNTdaaW04Y2p3TGRURnprN01BZGFMYXdHY3pBLyt4WkJDNHpBTlZM?=
 =?utf-8?B?aG05Y3BLMi85RGlqWXhmWmlJOEpkcXR4dzJ6TWNwUm81cHJEQm1zSzdzNzYw?=
 =?utf-8?B?M3N3RTlhcXVPdmZWOWNVcUtOcDJEN2hiKzZFMFZhMytTaE1vc0NTZWhLY25l?=
 =?utf-8?B?d1dvWjVDbkZQLzNmbjZCMFNzenZyQ0FnTWp6RC9SQkVFMXZuUFp3LzBhS2pa?=
 =?utf-8?B?dFpkcWcxNnV0aHJVSmF3Tk1BRUROL1JiT2wzUHpFNW5pb3NhYVpRTzV0aEZS?=
 =?utf-8?B?bVpUTXMrRHUzQlBGbU1ZcE9MTG9BWUJaVkxXWWF5Y0kxNkQ2VkxNOFljTWhp?=
 =?utf-8?B?aHIrUGIzc3VVQVFHNUlJbjVpRUxQN1cvYmNwbXpTdHozZ0lrSERoclFOVUxD?=
 =?utf-8?B?NFJqL24vd05MaEtsVXJ6dnMzRjM3bjlJaGpjTlJwRWF0UlZKeUtOT0xqOWN1?=
 =?utf-8?B?OVgxTjFFTjBkNlMzSHBlb1lCd3FsbVd0cHF2OWM2bXh5ODY0TU9WWlFQRnhH?=
 =?utf-8?B?cU5BeDA0dU9PWElNTlE1UjJOMy9LNk1oZFRXU0xycW5pd0VMU1NPODV0T0V0?=
 =?utf-8?B?OHFTUC93Q1JnbmVZa3Y3WXBycFhzZTVVb0orakZFcWRvbWhNQlhEQ3REYzVR?=
 =?utf-8?B?L0xhRlc4UHRrMkd2YXZtdnVvY1ZUYUx3U1VOUy81NVRLTTlwS2JKRDlOZ2RH?=
 =?utf-8?B?YjdTOXdzSFlRQzVaenY2blp1RVVxaXRkSS9ydWt4MEVJKzJJMDdueTJGdGp0?=
 =?utf-8?B?aXRQN05tSDF5V3FNREdwTktOOTFDU09lV1d0TFpXNXR6aTl0bXFoSnE4STFE?=
 =?utf-8?B?QUZCM1AwWUNPRWRQWHFPU3N2SjBnZ0dUUXNWVUNoYzBVcklETGs5K3R0Mmsv?=
 =?utf-8?B?WU03RWFML2Q5bXNIMW9aVWZYZXQ0b2ozb2JxbU1SL0ZmcGRTUmVBeU1Wano1?=
 =?utf-8?B?V2dKRXc0MHgrRy9xQWhBaCtabHIwbTRjU1dvR2I3cFhpaUxVVTF1MmN1TUhR?=
 =?utf-8?B?TWlITG44ejZYZjRrRTdXWTllZmVLZWhLc1ljTHRId2EzbWhSRUNOcTJsaEE2?=
 =?utf-8?B?RmpSa2tyNTRKSk5TMTZ1Uk1VODAvZFl5ZjFwZGVWZTQ2SFZ0T1VsSVQxcGFT?=
 =?utf-8?B?VFJnUzBtNlBFRGVITjhIK3NHZGMwT3JNck0yOVZEeGVkeE5XN2Q3RmdOWjVT?=
 =?utf-8?B?MTZkUVltTjNTNDk5UlJYSW8zSHl6N1dOalQ3UXFkYVhDZVJBOHBiVUZYeTBR?=
 =?utf-8?B?OTlUK211ZCt2T01GM3hJemxVOWJaZ1JVRkRjWFArVTgvWk9WUmRtWldsVFBJ?=
 =?utf-8?B?cndMT1NrS0R4Yis0T2p3T2VTZVIxVXlSb3M3ZythQnlpVy9tS1dScld3N2l3?=
 =?utf-8?B?Vm9pUFovdm1zNEN6Q1gyYjdOUmllK1V5V2wwb2M5bGREK3BXSEhQeC83UFds?=
 =?utf-8?B?aTdZTGNzZ2JpNklEM0hPZjdhYUd6L3djaHlVbEdBbHZmYWhMMjVPeVJUaWIv?=
 =?utf-8?B?eG1VT3JSVnNidkNrM0xwSEl2NnJab1dtcVNuVjRhTjJ5RG5jZE5SYWZDWlJN?=
 =?utf-8?B?VmkwNFUzbEhtS2RQZklhaUpIUy9vMzAyNmZBN2kvbE5lZVpzNENlMzN0N3Bl?=
 =?utf-8?Q?KqQtYfZH6Lg5Y8fNDO10D8g2T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0d4c83-6033-40f5-a455-08dad4829158
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 16:30:47.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKfrAT848zXWHAJLTEeWKcy6VxkFQLVRtN0Jq2HMPafT4+0JbsQYYgVJ+GtRSdhD89WKCophtoXzft0gEo/59g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 10:27, Miguel Ojeda wrote:

> On Thu, Dec 1, 2022 at 9:40 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>> I don't understand config sync. Perhaps that, e.g. Documentation/Makefile
>> checks for broken docs, for CONFIG_WARN_MISSING_DOCUMENTS, but we don't
>> do that for rust/Makefile? I'm not sure, but it does sound orthogonal, yes.
> Config sync is what needs to happen to make a bunch of files in
> `include/` up to date with respect to the `.config`. It runs
> automatically for some targets, but not always. For instance, the
> `*docs` targets do not trigger it. So if you enable e.g.
> `CONFIG_WARN_MISSING_DOCUMENTS`, and immediately afterwards run
> `htmldocs`, it will not take it into account.
>
> But don't worry about it: that part of my comment was directed at
> others (e.g. Jon, Akira...) that may know the historical context or
> the reason behind it -- no need to fix it here. I mentioned it here
> since it affects `CONFIG_RUST` if we use it there (in the same way as
> the other `CONFIG_*` used there).


Ah, that makes sense. I appreciate the clarification!


>
> Cheers,
> Miguel


Thanks,
Carlos

