Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40E730EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjFOFo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFOFoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:44:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1F2702;
        Wed, 14 Jun 2023 22:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnyvU2/9+eTYg27LIlPgFwbCcZ8167aOOop1nDqnsqotRFAi5ln+q+tnwxFXir27MD7VF5JKQ769pQqrqRSCECxWx9Ze3F+0QB8tEb19Eu0cP2B1pQuaZmFlfwNTSkx1wEviwrFfJxwDS4yPPF98J/KUzAvTOru1bzPb6MlFcKZ3MQt7/KqDVpe1MyeJnIqUjas190/T6dFnr7oGRyafTFVWbIXCRgmf6R/Z1ABZHxvvQjiSceADLdFp5+UXPqGCQPovKoStPubP6wlT1mhUG4JCJ35N5R523xG5q9Ov21ImJfNSUc8YgZbreO8mEpysFVMwO3imksqAM33KHnjJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWsAQw2kkMmMzCmWV6xGqljn+M8hJu0EnfOsISF82U0=;
 b=Yz0hvo5ktVnRcZODU25LURcfDE5NTVtehUdIFhrIDzSQXxVjPKuWTiEhLoHfrr/XDX8xj+azkJnbubzJ/LyrD0X92ftVW3W1geVuyKJFx10aPqhCiN/MAev9Kp1noK0oqXejmvO+KMdI56TyFKMaDnZmi4bAJE2PdY8NTsZKqySw8bzEBPQ8C5BNxmZ+Fmqw2GZ0Id+6My6BzVvk7mbN/WLg0zgOiutbwY2rpPPyPYVGKI7p2oIAepOtH67SX4NjBxuwOiwqtDkMuLOf6MewYft7NFpKxpQCUW4XctyN0Nz6pJFjK5EVSZTAlUml46QAtQbz05buUDd86JjGzMwWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWsAQw2kkMmMzCmWV6xGqljn+M8hJu0EnfOsISF82U0=;
 b=zeCtx8CGOQYELREX2KCaVAZg4cbL57ig6uugBT8dTG6weCPtgUd5dgHZWZldQjJ4q4nwD/dwOqtCMJzCJ0hwnp3i7/Eqci6Mqq7cnYOHqPEZmO/XCGaUj31sC+DyCcaeqK0M6C8ZJeCUFlrjck/s6rrz8jLOiYj8oQCQx7NMuvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 05:44:13 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed%4]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 05:44:12 +0000
Message-ID: <fc7b82a6-a74a-7675-7cfd-4dd9ac10543b@amd.com>
Date:   Thu, 15 Jun 2023 11:14:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Kernel null pointer dereference on stopping raid device
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "V, Narasimhan" <Narasimhan.V@amd.com>,
        "Shetty, Kalpana" <Kalpana.Shetty@amd.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>
References: <e78344ad-8d57-91d8-0bfb-724c740c7c72@amd.com>
 <3c4911c4-d3d7-a93e-5f14-e97384ae4f21@amd.com>
 <ZIlqvsZ6nMv2OT2u@infradead.org>
 <IA1PR12MB61375A452083D65B5FB815DBBA5AA@IA1PR12MB6137.namprd12.prod.outlook.com>
 <ZInIMLlMby2aNNr1@infradead.org>
From:   Ayush Jain <ayush.jain3@amd.com>
In-Reply-To: <ZInIMLlMby2aNNr1@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::6) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 951d9444-1f05-4369-ef2f-08db6d638c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNJoLkbDvHANY1GG/5tRQrlEQMmJ9cjfvmNMhfy2xujp8zegSlQeAt7U3uyF9LlYf0gT1gUK0wiLaiizr44wa9HZWc3i1QfXGjpfj9QI8/hYo8Bu0eFwhylLj0QMMJQHz0/0O9sxtIiJEbU+iag0Z8Ox1yKyIPQgBe8vWzdeiR2g7ua8IkQfbyEH55M1u36zivtaDq5IlC/mZfxXg3RefJXWsL2u17NIVwDraOSdhEhoXEntREY37s4+mU2rlz9BxPgBdmZS9zAEaUd6i/nf+j6nonupO7STOPgrkb0Df/xJjKJlSY14CTeCfZACx7f+dZo5DLk8Iy1bZ44k65gewSJR5Dd0w0EIXcFjD8XQfQz1q5/O1pceoaKPxS5ufKB/9KSintwHGjsF1B8mBzWv0jbohFMjJ1EhOqErQyOLybxH3IcaT+2qlzlpsthIP2UYYpY76yCMDqrt7dp5Mi+IYHczwvMNyys+SVoE+eYk6vNgL2CIF+Oh2ixdXMCxjogAq2bZEbappSjU4tyilr+fDLu6dWW5gqMZg9YVm4TXwr/ZAZY4av6QaeZw2I1gO2iHc7jX5Hh8viRx7dGPvUehYu4gv+FwYu7b2fpKh6ipalgprHmJ02trw+cXvNrwVR9ROSbJQZ/+6VJuIma/DfOSJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(6916009)(66476007)(31686004)(66556008)(4326008)(66946007)(36756003)(316002)(5660300002)(2906002)(8676002)(8936002)(41300700001)(6486002)(54906003)(86362001)(31696002)(38100700002)(478600001)(6506007)(6512007)(26005)(6666004)(186003)(53546011)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVo2eWdXRzBUK0lUM2FjbnpqbWdWQ0RPZjVxNUdqdVd6K01uRzRLMnZSd1Br?=
 =?utf-8?B?L0Yxd29KbEQ5TkZBclJzRlZPa0lrdGsyWWJLb002ZjU4d1RDOUxCWDNubkQx?=
 =?utf-8?B?c2JWeXlKVmtCVFpjMkdBVEFwQkwwTXRnM2Z4VmhxR3NJWlJ1OXhUWThrTkJw?=
 =?utf-8?B?TWV5RjF4TVRnd2pGRzZTMnI0TDA5ODZRYkcrVXR3UVlwSE9NdmREOWZKbFR3?=
 =?utf-8?B?VVNLREZOdVdpZ200eThucTEvKzFrcTYwM0Jib2I3S0tmdnFrQkliZVZvL2pG?=
 =?utf-8?B?M3ZXVDh2T3hjTzdjb2JkTVR3RUFXMEFDQ25KTVlhWG9vMTlzSi9ERlRhRTVN?=
 =?utf-8?B?ZDN4R3h1RzkyUDIvUVhOaFhtWFNxVFNPdS9uelBZbGFsWGwwYm4yejVWM1pX?=
 =?utf-8?B?bFZyNGR1aXdjeXVuWkUrL0VSbnEzaHRxY2E5RnJPYVFqSW5PRCtxNUo5cnBo?=
 =?utf-8?B?OXdZNnFCMUpwNVdjNHA5clhpckxQTUJiYXZCRGk4VFVRc0xJOHYwNDFRTUNG?=
 =?utf-8?B?S2FkS1ZJYjV2bFBvdTBoMkVvUWNRRG0xUkdJRHdPeWRTUDFGVThDMUZXbUYw?=
 =?utf-8?B?a1ovMmpwZk8zVnNDdytqRUJHM20zaTZheU8xWlhXdXRDK3hNU25Fb0ZmRmF4?=
 =?utf-8?B?aW5HR1Z0VVdQbU0zZndNOEM3LzhiU3JDbHAvZDFoNHAzNDFTTStuVmZHc05a?=
 =?utf-8?B?bk5TRXhqVzVHbFFwbi9mWk0vaEpPaXI3bWhxanQyU28xVjlmclNKdCswRlJN?=
 =?utf-8?B?RWtSeG9nM2lKRTBZZzg5dEJNMUQ1ZmlCejhDdnJuMmNGQTJySnd2cTQxNFJJ?=
 =?utf-8?B?VHZVcU5sWDZQdndYZ1g5M2NkbHdBTGpGcmRGSXVhUmdiQ1pxSXhOZHk2UkNI?=
 =?utf-8?B?THFXMkxXbXh1OGR5VGc5VTZKWWtPNkYzWDV6bTgvQm9yNmpVSE1TMTJoUnNi?=
 =?utf-8?B?NEhVd1lNd0grd0xOQnJtNGQ2ckxvU3dWSjZOdHZ0WnYzTTIxamZBa2d5MGww?=
 =?utf-8?B?ME5IQmVLb1Qxc1owdVk3ZHVOQXp0aEdYdEJGalBWa0NlRFJwdXFHdSsydy9o?=
 =?utf-8?B?aFFuckIzQTFjOVBOL2Mwd3BIRGpKcDUxWHgxVDBqc2pKbE5xaWk5RnRsSG9C?=
 =?utf-8?B?ZXhxWkJIZEZETGF0SEIyY2hnYkE5UXhzUzUzNXZzUHR4RlYwK0NSdzd5N1c2?=
 =?utf-8?B?cHEvT2JLMFBwbHVhU2FtQWVISVNYZ3djd1pnWmJmaDBWd0NHeUJsQTlHZnZ2?=
 =?utf-8?B?TUg5Y2p2alZsbUFJbEg5QjRQK3RYRmJLT0VoNzhRaXljdWs2VTUyTmYxREhj?=
 =?utf-8?B?WlNlanV2R0tuckxFN1h5aE1qdTR5VElTeThaYy9SdjBzYWFxcnNLaDNHS2oz?=
 =?utf-8?B?T0hqUDRuVU9TV2tVQlMzSGtlbVBwNy9aZTZzOVRiY3o3VzJBanRSVXVNYlBT?=
 =?utf-8?B?TlJjS3hheXEzSXFRWk5GeklySE0wZDZ6dGRjRUdxZmdVb2x3ZEwwU091OE1G?=
 =?utf-8?B?Z3lYQ3gzZndvVlhXaG5Va1lkR0xwc1RBeWFzei9uTW5INU1BamdFY1dKLzBk?=
 =?utf-8?B?TkQvbWFadEI4OGZOVVdWWUhCTGt2TVpJTXNqVVZMTWhWbnZteE1rbWYwZ0NT?=
 =?utf-8?B?SVd1a0cvMnRiaVh3U29WUG5pMzNieHI5dHZmM3NaQjViRDNHRHZpdVVZL0hK?=
 =?utf-8?B?TVFIQys2aS9mYWhienp1NEEzUmd0VnRvNWRvZWd6TzBPRjBCWGVkWWhJWUNV?=
 =?utf-8?B?OW9Ub0J4Q2xuL1ppZ1VzMmovVUlOMkRRNXBOY3IrMXBEZk93NllubGxmaS9M?=
 =?utf-8?B?TmxFVmRvcjczRFlqaUtuZmVxbnJXMnZBSnFKZnhXVVA5MjVDd05JUDl2SElp?=
 =?utf-8?B?TmdNSjNWTVJYWjEwT21IR0lEdjFIdlczOEN2RDFjNVRtTTVnbnE1QjdINkho?=
 =?utf-8?B?bm5IVlJkakk1NVRxb3BNMjRiY0NJK0ZTeHFLY1BQYm9wUUJ0Z2lKWGJ3eTR6?=
 =?utf-8?B?OHVlTHBIM3lNY3JjdDl3VFNTNDlZcGF2K28xT3pDdlJwRTlLNWJvc3ZIY0xD?=
 =?utf-8?B?K2VFanAyd0RVM3JLbUI0VGtPQUdZcGp2VUd5OThBNXpyZ0oySE5Zd29KMCtV?=
 =?utf-8?Q?XBakabTCsPPWtvugTikSTg9lY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951d9444-1f05-4369-ef2f-08db6d638c1d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 05:44:12.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuwIq1CjQIMvvEpjNiGrEo3imTn84HeH28WylbT5Rhmd2iR4FpA+4E+34U2l5C+zI0L3e3E10W8MKxG/pCKHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/2023 7:31 PM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2023 at 09:54:07AM +0000, Jain, Ayush wrote:
>> Patch applied cleanly on next-20230614 and resolved the issue.
>>
>> Reported-by: Ayush Jain <ayush.jain3@amd.com>
>> Tested-by: Ayush Jain <ayush.jain3@amd.com>
> 
> That was just a quick hack to verify the problem.  I think this is
> the proper fix, can you try it as well?
> 

Sure, this works on my machine.

Tested-by: Ayush Jain <ayush.jain3@amd.com>

> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index ca0de7ddd9434d..da523e80a4e990 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2467,10 +2467,12 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
>   
>   static void md_kick_rdev_from_array(struct md_rdev *rdev)
>   {
> -	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
> +	struct mddev *mddev = rdev->mddev;
> +
> +	bd_unlink_disk_holder(rdev->bdev, mddev->gendisk);
>   	list_del_rcu(&rdev->same_set);
>   	pr_debug("md: unbind<%pg>\n", rdev->bdev);
> -	mddev_destroy_serial_pool(rdev->mddev, rdev, false);
> +	mddev_destroy_serial_pool(mddev, rdev, false);
>   	rdev->mddev = NULL;
>   	sysfs_remove_link(&rdev->kobj, "block");
>   	sysfs_put(rdev->sysfs_state);
> @@ -2488,7 +2490,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
>   	INIT_WORK(&rdev->del_work, rdev_delayed_delete);
>   	kobject_get(&rdev->kobj);
>   	queue_work(md_rdev_misc_wq, &rdev->del_work);
> -	export_rdev(rdev, rdev->mddev);
> +	export_rdev(rdev, mddev);
>   }
>   
>   static void export_array(struct mddev *mddev)

Thanks & Regards,
Ayush Jain
