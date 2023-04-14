Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2676E1D16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNHZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNHZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:25:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1424EEA;
        Fri, 14 Apr 2023 00:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBcnzpWZBr5RWeBR4qf//L0aNJRKbVm5cR30LKt6pHcI1sa8+ebKEfwmhOn2P2j4U2fZiJQPKJsnqKcJTqbGzxSSnaHjNEPnjNMleeG/sBx27Ms8d9p6NITZ9MH/AFTQ9z9jeO65+H6dBXGABpP2U+6+Kb7im+IEIcmcxaQkPf0HRV3VwHcVM25Q4NaD/kAtJN5Hgual2DMwZpnaC7hVltu86q9MIsJOmY1VzT9wQXJiFJqMi6oALIa1zDwyFq/MD9hWdH9ylW/XWl7mUrmM0PaqR1WeJwZGZxfiVKAj6eIWzKFjxSazeJvCgmJfDbde6Sz6mHrRY5W4w2Hrg3SGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkF5Y/J+uElEtLNt70Tb0A6Z9BLxdGG6D1k/OEbgE4M=;
 b=BxF2406qZ9Zukbo50svee8Q4Y0HfrsbfXta8nIB2NdqMraGa3hB8YdxmshHZSB5XJpodviKFuD4SUpQ46WnKfcDbSNl4VUi/icATCZh8zEVtTPsuLm7y51oeJZvw6qCYaaQA+SVM3NLFxgiJ/naE2m27CVLxDzXLBTznB/QsiW3dWCEFpRvq8giqtMZsfC4EaqnhcoYHSjJ6M39UvUtwHPY2ZEokSPnoyItC7hkvAB8bQyj3b4YLCCJ5Kfa9Nc4KUiaFjwQlAfWl6XJ+zpqT7oHaCLfwTHzdloEhD4V0Jl64UQ5ubox3UOPg+SpRgeD6uWhVfY6R/3o449B7uOEBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkF5Y/J+uElEtLNt70Tb0A6Z9BLxdGG6D1k/OEbgE4M=;
 b=D2nQjweXTUSGWNVmPbSgdj2fIFQB0juBrto9OQpObwFUhHvObTgbUMKyhCs5Xr2nD1DnfeVMAcFP73PSkHtLRPkRkSK+bj3wemZlE8JyTpDJD8EO52wUM3Lfg93IgJLnOTGQcmLa7pPPs0mbI+Cq/yd0sgSzoMHTLTy0cUpLi3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 07:25:26 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::c70e:6be:19fe:36bf]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::c70e:6be:19fe:36bf%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 07:25:26 +0000
Message-ID: <3c4b9025-2667-ca8c-7427-502068b8168e@amd.com>
Date:   Fri, 14 Apr 2023 12:55:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: Tree for Apr 13
Content-Language: en-US
From:   Ayush Jain <ayush.jain3@amd.com>
To:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        axboe@kernel.dk, Santosh.Shukla@amd.com, Kalpana.Shetty@amd.com,
        Narasimhan V <Narasimhan.V@amd.com>, sfr@canb.auug.org.au
References: <20230413182542.1133335-1-broonie@kernel.org>
 <0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com>
In-Reply-To: <0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 68596fbf-38eb-45ba-03d5-08db3cb96aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+YQ6fZzVU6DE6dykY/u51SmB2TGj0DslmzrpWdRkIJtx0GvwFKMxomrigzRWqHKpae6h82JxRV+NL7Sz7E8QfrF3LdvhTGlpYK/s7at1SnR0PnSc3bQZ5KACi/QruT6p3XHns3Hy1Y4hahwNxhtxQhn/PGfPH+Mo7EQ5Mr0qcHe8U1UZTf95HCzYDd/+Xrswov1ci/Qs6AWn0wItfXYQrfkc9VA8Vg/aLVK8ugPtMYgry1UdGxkcSVfnZHmfEM97LNtL552TJrlJG1rBKTMkxbXGWjVpAGIKN6Bimtjl7ZK2fexHBU8+oLon0bOURwHipFw5vE3R2N8MYvY7cyGyXXzciMtsGBZtlfHn5XrL00oxcXjKeVBWn3wruH6QYuRhHl2ChFTMD2NrbF/TFmsF2ujEjDNOU7twJQsU5sFkS6P9g9CT9Ipbabv/RPUXKbyYo/2KOW/6FVEfR9zuIiEypZe9+QCI1SK08YYWf/4+fLOOW3jPWQSvOBWevz5Bl9pF3QHApVoUaAD51wFkEU4iqywPPGDdnBC/pu8vO+rHQA/651+p12nVcBaXTv7x3v3pxRqE2SFNi7rLr5bAkOCLBnqbrGaZYjifLDAK1545HNNJ2ItQMmevocX1cJq+AUZN+v7m3p4lHOA8gTAVgcfvdc+4G6dHUxhYlhKILpVOE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(53546011)(26005)(31686004)(6512007)(6506007)(54906003)(186003)(83380400001)(2616005)(966005)(6486002)(6666004)(5660300002)(41300700001)(316002)(8676002)(8936002)(86362001)(38100700002)(478600001)(31696002)(4326008)(66946007)(36756003)(66476007)(66556008)(6916009)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGVxZmEvT3grMjRlQUx5SmxjQ2Raa0VhdWU3Q2pCYzM3ZVBSSnFZcG5FU0E0?=
 =?utf-8?B?NkFkWTNMaDB4ZHhGdGhzQkpMQkJjZ2txUnZhMy8xNnZHOUM1SitGR0lYSGsr?=
 =?utf-8?B?b2IrY2ExMm9RQjIyOW1FU25zNVZaektSZ3ZCSGVSUTRDNDFKUkswMUdZakpo?=
 =?utf-8?B?cEVTRUNuZ0JXckJXaHNYNmUxT0p6eSsxRnRsWEVBdEFvZTdTOXgyUitic3VS?=
 =?utf-8?B?aFNPeGlYY0pad3hBWlV2R3JZc05aM1VLZS9Ba3JNeUdweXlzRXY0N2N1WEgx?=
 =?utf-8?B?RGZLRVpON2lDNnBtOE4vNUh0WXdvN255VmorSmZlRzh6QkYzRk9zUVhKdWhu?=
 =?utf-8?B?VVpmTnJqTW5YZ3ljMXcvZVhWR3ZJd29leDJxQzRScWdFZFU0S0lYakZJT1I1?=
 =?utf-8?B?WEpFQTRlNzkyNzZNZ3Btc0xXVWN1bWZkU3Zhejh6ckFCU1VkR1AyazZHS3h3?=
 =?utf-8?B?RXZmTTRWOXJiSkFDL0J6YXczelpqWUZjelVtSUdIRGVoN1BBdWlBT2g3VHht?=
 =?utf-8?B?YlkycXJDUno0dkd3dFNHNFNYeE90ZHloVnYrT1g1bEhFejZKNm8rSnhOenlW?=
 =?utf-8?B?V2sxRGV4ZnA0VXUwMFFRQnJkR1E0dTdJQ1F2QUV4cElwTlAraW5xa2RieVdw?=
 =?utf-8?B?Z3pWcU5oSStxYnByT0MvMExWTVlmZlErYk1IOTJrcU5BVE1CRExpa3ZJYUdG?=
 =?utf-8?B?bGlNRXN2UXE3MnEvTit0UWZGS3NqejUzaUF3WjFUcFFNOVJvNTM4UkE4eUlV?=
 =?utf-8?B?T0psaHluK1krOHlqSXJNbGlTY1ZyNUw4d2ErNUJYWXdGL3l5cThXNGpFWmRB?=
 =?utf-8?B?b0xpTzNZbmxtTWN4bjVLWVF5Qzk5L1dRT0lzRnlLSHp4MXdIcnEvY2JoK2or?=
 =?utf-8?B?c3huQ1prczdPNFlwbGc5amZoTFZGSFRiWDZpeSs4VUhhRXBOMzBNNjU3TjhT?=
 =?utf-8?B?S1BCNHNMdHllWitZS2NWQWp0a1dmN1gvQ0xMbU5RNGVxZnNVZitCU202NmJn?=
 =?utf-8?B?eHRVOFJRTWZFc05uNHBER0JUR25CVmMzWm80enFQZkJINmtMeStNa1h0WjVF?=
 =?utf-8?B?LzBzU2E2VHNyUi9UdkJ4U3BLS2FCR1hSL2psbzdOSDNHejV2WjFSTW5FTWN3?=
 =?utf-8?B?REZUbi9Gako3eTJjNmlObk5vMjdsYktVWnFVSEFNUjlmS05BeEsyVVY3ZDFV?=
 =?utf-8?B?MVdaNUdKSWduQ1c3K0tPRnduQ21vS0kyUWVORW55L2duYnRYQWtEQlgwdDRx?=
 =?utf-8?B?VTROTDFLam0rSnMrMldvLzBnQTBiVGRRK29JczBqNVk0a3U5NEVEZEpZc2pj?=
 =?utf-8?B?bHhFTU1zY2ZKM0pZUExEUVBZbnF1QWFDWXdoeXdSK0psa1ZMaEVETVpXTHJB?=
 =?utf-8?B?elROWW12OHhCSjV1UDdPbktva2R5S3VCNGZNVG5rb0ZWWCt1R1R5cUZtTG1B?=
 =?utf-8?B?ZWFLZFhtQW9iZE1CSmVJNXR1RHpGNEFXVGhGU2FUekh3Nk9LcTgrMDFObVB2?=
 =?utf-8?B?MGtYRExwTlFGcVhzM3NySTdzYzErbUIzQ29Yb2JQekNUaHZLdHFDaExNQlVM?=
 =?utf-8?B?RzM5MXpkaUtzb3FrbTFvSU05bWdrczJsa1ErSkhuc3BOSWpjQ1FjWXkvQTBR?=
 =?utf-8?B?NHVUc0ZiUkg5Nm5mSGc4bys2eFJrL1M0UWVFbit3bG42R043RnhhdC9pd0d5?=
 =?utf-8?B?RFlBREpQREp5M3kweVUvc1k1bXlDYTJoTmMwOEk4NHlEOWVrTnlOdVYyTUZo?=
 =?utf-8?B?RTRRWDFEK1B3MjQrTjNwN2JnYkZETXR0MzZJSHd6bzVMV3F0Y3pCVzRranpq?=
 =?utf-8?B?REd6UEY4b0RvMEk4MDJtUGNIWDVIckZscXJPWC9zQWxLQWJBd3JaUHlZTVZV?=
 =?utf-8?B?VFFCTHRRMkJSSVRMVGh0YkZQYnQ2enZ4MnE4c3c0QW5hUW5wZmthWmRZb1hV?=
 =?utf-8?B?b1BjeW5ZdWhVL3VjWDlRWVd0WWcya044WERwL2pvT2lwM1Roemo0YURWM1ln?=
 =?utf-8?B?MlhGdHFPbHVJZmVMYnpNN24wUS9kYVMrUG1DT2M2dkVsa2k4Q1pMMzNGc0x0?=
 =?utf-8?B?MHpCbGttRmIyc1NDU0tIb1JGK3hBUlpLd1lLT0NSd2pIUUI2L1djRWh4dHR6?=
 =?utf-8?Q?ODnhpA/F9cDNhciEI8rqUtT8s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68596fbf-38eb-45ba-03d5-08db3cb96aa8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 07:25:26.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9Y1w7ivmWKjAGqzQPg522aJgAN9VI89Lk3N+RNsHA1PgA/TaoV+bZyzFuUxXgL4yuq4RZ6hojQACYdHO7MTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 4/14/2023 10:41 AM, Jain, Ayush wrote:
> Hello Broonie,
> 
> When Running fio-test on latest linux-next tree, I noticed that test hung indefinitely, Going back I see that this problem exists since
> next-20230316 release, After bisecting I landed on the following merge commit by Jens.
> 
> Commit   097d3ca138f9 ("Merge branch 'for-6.4/splice' into for-next")
> 
> Running perf I see following trace and call-stack for fio:
> 
>   Overhead  Command  Shared Object     Symbol
>     25.08%  fio      [kernel.vmlinux]  [k] copy_user_generic_string
>        copy_user_generic_string
>        __do_splice
>        __x64_sys_splice
>        do_syscall_64
>        entry_SYSCALL_64_after_hwframe
>        splice
>        0x1c44be0
>    ...
> 
> On a good kernel I see the following perf trace:
> 
>    Overhead  Command  Shared Object     Symbol
>      49.93%  fio      fio               [.] fio_crc32
>       7.23%  fio      fio               [.] clock_thread_fn
>       2.10%  fio      [kernel.vmlinux]  [k] clear_page_rep
>       1.55%  fio      fio               [.] __fill_random_buf
>       1.35%  fio      [kernel.vmlinux]  [k] loop_queue_rq
>       1.05%  fio      [kernel.vmlinux]  [k] copy_user_generic_string
>       ...
> 
> I see some splice changes being added as the part of merge
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.4/splice
> 
> I observe this problem on 3 EPYC system(Zen1,3,4), with the following disk architecture
> 
> Zen1: nvme0n1   931.5G Samsung SSD 970 EVO Plus 1TB
> Zen4: nvme0n1   232.9G Samsung SSD 960 EVO 250GB
> 
> I am running fio as follows:
> 
>     $fio fio-simple.job --filename=/dev/test_vg/test_lv
> 
> where test_lv is mounted as follows:
> 
> NAME                           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
> loop0                            7:0    0  12.2G  0 loop
> └─md127                          9:127  0  12.2G  0 raid0
>     └─test_vg-test_lv            253:3    0   5.5G  0 lvm
> 
> You can find fio-simple.job at
> https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/io/disk/fiotest.py.data/fio-simple.job
> 
> Fio Version: fio-3.34-25-g07ed
> 
Also adding to these observations

-If we create a filesystem on the raw disk -- Test completes with a Pass

-If there is no Filesystem on the raw disk(loop, nvme) -- Test hangs with the provided trace

> 
> Regards
> Ayush Jain
> > On 4/13/2023 11:55 PM, broonie@kernel.org wrote:
>> Hi all,
>>
>> Changes since 20230411:
>>
>> The sh tree gained a conflict with the mm-unstable tree.
>>
>> The erofs tree gained a conflict with the vfs-idmapping tree.
>>
>> The ext4 tree gained multiple conflicts with the mm-stable tree.
>>
>> The net-next tree gained a conflict with the origin tree.
>>
>> The bpf-next tree gained a conflict with the net-net tree.
>>
>> Non-merge commits (relative to Linus' tree): 10382
>>   11028 files changed, 580165 insertions(+), 249563 deletions(-)
>>
>> ----------------------------------------------------------------------------
>>
>> I have created today's linux-next tree at
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
>> are tracking the linux-next tree using git, you should not use "git pull"
>> to do so as that will try to merge the new linux-next release with the
>> old one.  You should use "git fetch" and checkout or reset to the new
>> master.
>>
>> You can see which trees have been included by looking in the Next/Trees
>> file in the source.  There is also the merge.log file in the Next
>> directory.  Between each merge, the tree was built with a ppc64_defconfig
>> for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
>> and a native build of tools/perf. After the final fixups (if any), I do
>> an x86_64 modules_install followed by builds for x86_64 allnoconfig,
>> powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
>> and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
>> defconfig and htmldocs. And finally, a simple boot test of the powerpc
>> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
>>
>> Below is a summary of the state of the merge.
>>
>> I am currently merging 357 trees (counting Linus' and 102 trees of bug
>> fix patches pending for the current merge release).
>>
>> Stats about the size of the tree over time can be seen at
>> http://neuling.org/linux-next-size.html .
>>
>> Status of my local build tests will be at
>> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
>> advice about cross compilers/configs that work, we are always open to add
>> more builds.
>>
>> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
>> Gortmaker for triage and bug fixes.
> 

Regards,
Ayush Jain
