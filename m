Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8B64EAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiLPLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:48:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36C2BB3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671191332; x=1702727332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5OTK8jrM8NaPePqZMhRbpAvffKJaOJMvLZ2CdKYdS9A=;
  b=K59mFcKO7c3//P1uVP5gwcMC+FXPtttmnJOj7jHgqJ7d8QJl1gmmrznc
   7FKv680Ee59VGCiTwjUvoXdtv32NUZFZGeFBsWsQEoP1D+3lMh+ZXhxti
   UhaU1bwl4K0CCmejcXI+JDZ8AZR3Wo0ZfrzVYJvgluOFqgDbraFFoBFqb
   KVx/ZyRM7uHxEsGP1saeBOt+o4N8vIjQOxS3REsQ2xefKQqb2l1iA6i9t
   QRLdWNQ2ZvuusCZ4xuoYArapyMj75OAniuLVimyHOQnsC7eA0ELlJNowl
   bJHOPIBGYdtLisAiUq/ABAVEFblt2Pt+32+Ct02Fou/3l2slNzdncXmOz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="381173602"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="381173602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 03:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="978586488"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="978586488"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2022 03:48:51 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 03:48:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 03:48:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 03:48:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZbN4eVWfV3fq88d6Nm0djNdX8mO4OEGw2AiiKOXK9Mv9BlX+U9B+rZvQoF/7SO7XUHu2kpsFDH5eBB1tcFtVwANctGaKCRXKp3tIBicPqftGxVHHarAPUAxNE+IV8OtVeQeXeDNz/bq7VBSWzNS+e4eKrukGi9oztqu6K5lJEHMrBy20au/z1VItNW5+L2vjBacBMArFq3uY4BzkvVt4R7HbXN6YuxANk5W7tlB4ydSxUV59nklPm5fwqxtevOK3n3kC8N7CSsSlUIXauN/YLG+IPqi3lHGmcwLJpaJ6tPeT1/+q3AAOgGFuCw7efFinxaQxS8Z7j1HKQ1L+BppiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i1laz3ABh9JJ3zNrPdytL21aN74V/bV1TQQAzS7Lys=;
 b=K0EIogUarh8E9S06mFebTSqFZPJKYl0etBY/9Vc4fwaTB4WadWuGvIOhClUp6v91lr16EGtDMwV2i+vEvW69tmEYTkm8AfECmavUONj/zaUuGOt03RglHr997MohGAkLk9GNteQ6IS4e6zYDyy2IVN3UJt7ID8hSjBHkLpC2MAz7+Bxk29/ERelU4/OU4Lqf6s5KSAo2pHdnxaNwCUTYjC7Rg3LGs/0eXyx3BAMDi5y8CFYP9OhHjW1ovvlwGwdGjbjDH2E9yKPciofIYo7OXrxI8Hz0feSlUVItELqVJLJ71YKPXlcA7iGsgsGgrxGRPdcndHHZve77PjPEp7ftuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB7131.namprd11.prod.outlook.com (2603:10b6:806:2b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.21; Fri, 16 Dec
 2022 11:48:48 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::560c:a32b:4c4b:8bba]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::560c:a32b:4c4b:8bba%6]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 11:48:48 +0000
Message-ID: <a4bcddad-e56f-cedc-891a-916e86d9a02c@intel.com>
Date:   Fri, 16 Dec 2022 19:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
Content-Language: en-US
To:     Rik van Riel <riel@surriel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yang Shi" <shy828301@gmail.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <202210181535.7144dd15-yujie.liu@intel.com>
 <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
 <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
 <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
 <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
 <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
 <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbe0489-eb03-41b5-dde3-08dadf5b7e1a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxz2CoomXyU2/APoG5+P3NHMwRK4/P+FcQIxva8SDoSlfGtHpcA2ycJuWBzlylvg8qJvAWeoANeedhTdiZzkCDW2aVBech9O32Uvwvue+YE9vDjoQBBnPOG2xbdrxzXdV4HO/SvvMFtQqtuXNPAni6DGPB3bSVTqm9hfAbJtNC+ES8JeKyWoaTK/Pq+da9/hl7YN+lWVryLe9kuafZgEX5hzysNayaFwmuNZyV9JV3D+1IPN5/DcXpcq18Ig0mtDiY07Y0oYS8aHLyLQNNOqRr9dIQMoAiZNk2FyYqoKq4WZh0ZjmJkKWhIyJAzVrIamm1AwC8ouIfx1leUv/m9XyglHwCkeaWK82yRtYFvd8l+oQ8iejz9l6LHPxW/ojQErbo+/mEi6OzIuOLuRfMua/rtNx8yzVZ/h5sb5ApQFfyj/ZJybrEL9t4JoDbBVlIYPp3PcLMKWd7/xKdsrghUePoisLf4CP2HiDh+U3IFxSldO8LfRdFiwlbVFvFneP9DSQI6m5/OUW33iGAjq4yLYV0yEBU90uNt3XnyeXgnueTP6gDYMQ3dcc2inyOetPMOh2jXbUID/vi15JBgYQNp50M/GpTLlLNIFyTCi2ew2ZalkjCUkCTCckIJ58gML/SbmClcF0+XzH7mrQDmdEd5Oc7CDDJFkNBAzhiIG6slH/U/HxxEiO0CVPCh/jRnxWjeYnqWxTBeMyYlAH+pARHHZgoRJLZSEM/0OCb8Lxfaym83ky+4shGViOro1zI0KRsn+bhGmIg+UkZgpkr7HnbTp/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(31686004)(2906002)(26005)(66476007)(86362001)(66556008)(5660300002)(4326008)(41300700001)(36756003)(4001150100001)(31696002)(7416002)(8936002)(966005)(6486002)(38100700002)(82960400001)(66899015)(478600001)(66946007)(83380400001)(53546011)(6666004)(6506007)(6512007)(2616005)(54906003)(186003)(6636002)(110136005)(316002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tsMCs2c2F1K29qa2FLUWRPemlVL1lwMXA0ZTlXd0V6YXVGRTcybUtIQmk2?=
 =?utf-8?B?bzJjRlpPQTFQOVZPeWl5Ukt2dVFySjJpSU10MUM1RUhqdnppbjREczMrRWJk?=
 =?utf-8?B?Yk5TMk52cENTU3NJcVYwZEN3QVZGSXpzZERRbm5HOXpSd21KNk9TVjkvZ3JS?=
 =?utf-8?B?VEJoQmc2U1ltSlpOaGRYbXVlN2IzUlluMlFNRk1yMDRoVXlVUG51RnliRXpa?=
 =?utf-8?B?RmptdHZyTUpxOXV2TVF3VGN4VjFEOHpaUDMvS00ra0E0NXVBT25XOGhINlcz?=
 =?utf-8?B?NTZ5UmFuN0tsKzNlRDhlTDY3YmVDMVZRY0t0QVNubmhpMElScWlPcHN1a3Fo?=
 =?utf-8?B?andyUHZZTTdobjkzaFlRc05VcE9tTUZHTjhpMDJrZUpVZHZ3K0c3bjMrNGpB?=
 =?utf-8?B?Z3dzMFR2SVFYZWo3b0dGVDRlM1JUVW9NbDNkb050czMwMXp0eTlTS2IwRkJD?=
 =?utf-8?B?dFpRUC95VGRVSkl1UitmbTdBbk4zeFN5N3NPSjQ5SHcyNEVSa0dFSHRWV3Bk?=
 =?utf-8?B?NnNlS1dRZC9qWUg4YkZsUFpibmVXbU5uTVFYV2x4dEZkVC9zd3czeUdCZlo1?=
 =?utf-8?B?MGFJUjdLQWp4ZXJ1ZnJpV2RlblU5Y3psMzZibTg0ZmdLbUNFdnV5NUxMU1Ur?=
 =?utf-8?B?aDFkeGhmY0NVYW1JelV1VXc3ZjMwb2UyWXFQMXlXdE8vcHZHNEorL0RSL0lK?=
 =?utf-8?B?TUNmdlA5THAzOEl2ellpN3ltcDdMVy8wZzVtQ1l4ZWJTVWMrVy9HU3RWcmMr?=
 =?utf-8?B?eEVwRFpNMzduNjNnazg4QkRtNndyT1hORDJpNDNNdFNURGZXdHg2NFJlOVdV?=
 =?utf-8?B?elBQRlUrZHh0R1F4OGNDcExLVDlvNVd0Z3FxdE4xWHVmcGhtY1RLR0c3ajlo?=
 =?utf-8?B?QldrSFZsQkNobkkvN3M3WEpRVUJ0RkxPWldPbkNGelVzV2hXbStQVkdKNXgv?=
 =?utf-8?B?cnBIUU44UlN3RXZWL1RqNlNraWtLSlFsdDUyWlZNVTRHSkFxTEo4cXVxY0pu?=
 =?utf-8?B?ZTYzbzVOMy80aE4wWksrSHAxM3dnNXY0UVNDVWFETmRkUXowcENva0x5dFBs?=
 =?utf-8?B?NFFpUVphS2V6QWNKcG8wN2IySCtMcUJRbkJwN0NXeWhSa2FJK0Y3WTR5WlNy?=
 =?utf-8?B?TDFSZE4wSWVMdVBzczc3K0R4c3MxVTZvb1BNYVFBSUpYakEwNWtYWEFQU0Nz?=
 =?utf-8?B?bDMzZk01ZitCaEtkcXBVbDBtMlJGcktBOVZPRDdFZUh0c0hKUzNyT3ZpUWZv?=
 =?utf-8?B?aHY2TXBSNXEveFRhWFFYa3N3Y0RSYzduSlU2Q1VFdkFpN1F2aXlGdERyTEJl?=
 =?utf-8?B?azR0MjFmZ1JFSFY4bU5OWGtkdEFTUU05WmZGNElicnV1dlVxWGNDV0lIMm1w?=
 =?utf-8?B?VXdaUUFTSEVPVGN4WmptaG1LeWE1YUhibUtxblgwOVdzSC81bGNkSzAvTVZ5?=
 =?utf-8?B?MVVzWHc2K0hndDd6dG5GSXVoS0grdXMrdlFOYnJFMmxmN1pJZ0FsY29GMU1K?=
 =?utf-8?B?TzRTVFNpaGZZc2oxcldRN0w5c2ZmbjhOZFZVeFp1V3I2OUUvTGVvTFY4YXYx?=
 =?utf-8?B?R0hmNWxOMmYveEt4WnRQQmFLWThrOWVZMmJ2SnZrUy9ZSVlqejFkZXcxQlpP?=
 =?utf-8?B?eTVOT3BXOW5zeEpKS3NtOW5QTnZNZGhNUXk1Vm0waURyWkQ5MlhkNVNrdGl4?=
 =?utf-8?B?OU9WckYybkFGVGVKZzdBaDZwMkVjMlZzTlNKSkF2NjUzekNzUjNZT0VpMjZO?=
 =?utf-8?B?bmJ2Sm0xemxwZ0RmMm5JSzJrOFFSdDY5WnF6SE9SV0t6RDdXazh3b0xXRUgy?=
 =?utf-8?B?ckN5YjRHbE9XTDBVT256K0RLdnpVRHZVWXNWWFQ3a053cFB6aHM5SEJEM0Ru?=
 =?utf-8?B?cW4xcUVYaFMwYXdWVWtXM0hUVkZ6Q1QvSVIvWUp0NnI2c2NWcUdYV2FLUG50?=
 =?utf-8?B?dGN3Vm5NaDhJQ1J0Z3BWZGpacC9RSGRNRlNsbWRLcnhPcFFLZE5BN3poeUhT?=
 =?utf-8?B?Ymd4SmpJUG4yZjdFUGt5MFFybzZTSHJqUzBlcnRwTTF2bC94QXptTG83MjhU?=
 =?utf-8?B?Uk80V0w5TWlYenVKZlNRQjR5aXd1bzBXMXNSekg4T0NPTjhWMGdRMDJGWlBR?=
 =?utf-8?Q?0JPKHnWFv1YC/Rq6Z2RUeB7Nv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbe0489-eb03-41b5-dde3-08dadf5b7e1a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 11:48:48.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHIwlMk5Qb3M+wypKQa1uW4sQwHlCmzTXGycvnYunqA5UxXpUSHe6zyDE7yfM7/jMx/+QsMvWOujSGDIj5PRKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/2022 4:29 AM, Rik van Riel wrote:
> On Thu, 2022-12-01 at 19:33 +0100, Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker.
>>
>> On 28.11.22 07:40, Nathan Chancellor wrote:
>>> Hi Rik,
>>
>> I wonder what we should do about below performance regression. Is
>> reverting the culprit now and reapplying it later together with a fix
>> a
>> viable option? Or was anything done/is anybody doing something
>> already
>> to address the problem and I just missed it?
> 
> The changeset in question speeds up kernel compiles with
> GCC, as well as the runtime speed of other programs, due
> to being able to use THPs more. However, it slows down kernel
> compiles with clang, due to ... something clang does.
> 
> I have not figured out what that something is yet.
> 
> I don't know if I have the wrong version of clang here,
> but I have not seen any smoking gun at all when tracing
> clang system calls. I see predominantly small mmap and
> unmap calls, and nothing that even triggers 2MB alignment.

There are some findings in my side. I not very sure that it's root
case and like to share here to call more eyes on it.
1. The regression is not related to clang. It's related with
   ld.lld.
   In my env, command
      make LD=ld.lld -skj96 allmodconfig all
   could reproduce the regression. But command
      make CC=clang -skj96 allmodconfig all
   can't reproduce the regression.

2. It looks like ld.lld calls madvise(MADV_DONTNEED) many times to
   free memory. But the parameters "len" is not friendly to THP.

trace-bpfcc with do_madvise gave:
531607  531732  ld.lld          do_madvise.part.0 start: 0x7feca9000000, len: 0x7fb000, behavior: 0x4
531607  531793  ld.lld          do_madvise.part.0 start: 0x7fec86a00000, len: 0x7fb000, behavior: 0x4
531607  531767  ld.lld          do_madvise.part.0 start: 0x7fec95000000, len: 0x7fb000, behavior: 0x4
531607  531703  ld.lld          do_madvise.part.0 start: 0x7fecb3000000, len: 0x7fb000, behavior: 0x4
531607  531757  ld.lld          do_madvise.part.0 start: 0x7fec9b400000, len: 0x7fb000, behavior: 0x4
531607  531701  ld.lld          do_madvise.part.0 start: 0x7fecb4400000, len: 0x7fb000, behavior: 0x4
531607  531795  ld.lld          do_madvise.part.0 start: 0x7fec85600000, len: 0x7fb000, behavior: 0x4
531607  531792  ld.lld          do_madvise.part.0 start: 0x7fec87400000, len: 0x7fb000, behavior: 0x4
531607  531695  ld.lld          do_madvise.part.0 start: 0x7fecbca00000, len: 0x7fb000, behavior: 0x4
531607  531760  ld.lld          do_madvise.part.0 start: 0x7fec99600000, len: 0x7fb000, behavior: 0x4
531607  531706  ld.lld          do_madvise.part.0 start: 0x7fecb1200000, len: 0x7fb000, behavior: 0x4
531607  531769  ld.lld          do_madvise.part.0 start: 0x7fec94600000, len: 0x7fb000, behavior: 0x4
531607  531699  ld.lld          do_madvise.part.0 start: 0x7fecb5800000, len: 0x7fb000, behavior: 0x4
531607  531738  ld.lld          do_madvise.part.0 start: 0x7feca5e00000, len: 0x7fb000, behavior: 0x4

3. I captured the perf data for 50s when kernel build with ld.lld
   was ongoing and got:

    24.20%     0.27%  cc1              [kernel.kallsyms]           [k] asm_exc_page_fault
           9.52%
                asm_exc_page_fault
                exc_page_fault
                do_user_addr_fault
                handle_mm_fault
                __handle_mm_fault
                do_huge_pmd_anonymous_page
                vma_alloc_folio
                __folio_alloc
                __alloc_pages
                get_page_from_freelist
                clear_page_erms

    14.85%     0.00%  ld.lld           [kernel.kallsyms]           [k] entry_SYSCALL_64_after_hwframe
           11.52%
                entry_SYSCALL_64_after_hwframe
                do_syscall_64
                __x64_sys_madvise
                do_madvise.part.0
                zap_page_range
                unmap_single_vma
                unmap_page_range
                page_remove_rmap
                deferred_split_huge_page
                __lock_text_start
                native_queued_spin_lock_slowpath

  My understanding is that the deferred_split_huge_page() here is kind of
  matching len: 0x7fb000 in do_madvise() call. The end is not PMD size 
  aligned and trigger lock contention on deferred_split_queue.

With GNU ld, there is no any madvise(MADV_DONTNEED) called.


Regards
Yin, Fengwei

> 
>>
>> Yang Shi, Andrew, what's your option on this? I ask you directly,
>> because it looks like Rik hasn't posted anything to lists archived on
>> lore during the last few weeks. :-/
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
>> hat)
>>
>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>> reports and sometimes miss something important when writing mails
>> like
>> this. If that's the case here, don't hesitate to tell me in a public
>> reply, it's in everyone's interest to set the public record straight.
>>
>>> On Thu, Oct 20, 2022 at 10:16:20AM -0700, Nathan Chancellor wrote:
>>>> On Thu, Oct 20, 2022 at 11:28:16AM -0400, Rik van Riel wrote:
>>>>> On Thu, 2022-10-20 at 13:07 +0800, Huang, Ying wrote:
>>>>>> Nathan Chancellor <nathan@kernel.org> writes:
>>>>>>>
>>>>>>> For what it's worth, I just bisected a massive and visible
>>>>>>> performance
>>>>>>> regression on my Threadripper 3990X workstation to commit
>>>>>>> f35b5d7d676e
>>>>>>> ("mm: align larger anonymous mappings on THP boundaries"),
>>>>>>> which
>>>>>>> seems
>>>>>>> directly related to this report/analysis. I initially
>>>>>>> noticed this
>>>>>>> because my full set of kernel builds against mainline went
>>>>>>> from 2
>>>>>>> hours
>>>>>>> and 20 minutes or so to over 3 hours. Zeroing in on x86_64
>>>>>>> allmodconfig,
>>>>>>> which I used for the bisect:
>>>>>>>
>>>>>>> @ 7b5a0b664ebe ("mm/page_ext: remove unused variable in
>>>>>>> offline_page_ext"):
>>>>>>>
>>>>>>> Benchmark 1: make -skj128 LLVM=1 allmodconfig all
>>>>>>>   Time (mean ± σ):     318.172 s ±  0.730 s    [User:
>>>>>>> 31750.902 s,
>>>>>>> System: 4564.246 s]
>>>>>>>   Range (min … max):   317.332 s … 318.662 s    3 runs
>>>>>>>
>>>>>>> @ f35b5d7d676e ("mm: align larger anonymous mappings on THP
>>>>>>> boundaries"):
>>>>>>>
>>>>>>> Benchmark 1: make -skj128 LLVM=1 allmodconfig all
>>>>>>>   Time (mean ± σ):     406.688 s ±  0.676 s    [User:
>>>>>>> 31819.526 s,
>>>>> System: 16327.022 s]
>>>>>>>   Range (min … max):   405.954 s … 407.284 s    3 run
>>>>>>
>>>>>> Have you tried to build with gcc?  Want to check whether is
>>>>>> this
>>>>>> clang
>>>>>> specific issue or not.
>>>>>
>>>>> This may indeed be something LLVM specific. In previous tests,
>>>>> GCC has generally seen a benefit from increased THP usage.
>>>>> Many other applications also benefit from getting more THPs.
>>>>
>>>> Indeed, GCC builds actually appear to be slightly faster on my
>>>> system now,
>>>> apologies for not trying that before reporting :/
>>>>
>>>> 7b5a0b664ebe:
>>>>
>>>> Benchmark 1: make -skj128 allmodconfig all
>>>>   Time (mean ± σ):     355.294 s ±  0.931 s    [User: 33620.469
>>>> s, System: 6390.064 s]
>>>>   Range (min … max):   354.571 s … 356.344 s    3 runs
>>>>
>>>> f35b5d7d676e:
>>>>
>>>> Benchmark 1: make -skj128 allmodconfig all
>>>>   Time (mean ± σ):     347.400 s ±  2.029 s    [User: 34389.724
>>>> s, System: 4603.175 s]
>>>>   Range (min … max):   345.815 s … 349.686 s    3 runs
>>>>
>>>>> LLVM showing 10% system time before this change, and a whopping
>>>>> 30% system time after that change, suggests that LLVM is
>>>>> behaving
>>>>> quite differently from GCC in some ways.
>>>>
>>>> The above tests were done with GCC 12.2.0 from Arch Linux. The
>>>> previous LLVM
>>>> tests were done with a self-compiled version of LLVM from the
>>>> main branch
>>>> (16.0.0), optimized with BOLT [1]. To eliminate that as a source
>>>> of issues, I
>>>> used my distribution's version of clang (14.0.6) and saw similar
>>>> results as
>>>> before:
>>>>
>>>> 7b5a0b664ebe:
>>>>
>>>> Benchmark 1: make -skj128 LLVM=/usr/bin/ allmodconfig all
>>>>   Time (mean ± σ):     462.517 s ±  1.214 s    [User: 48544.240
>>>> s, System: 5586.212 s]
>>>>   Range (min … max):   461.115 s … 463.245 s    3 runs
>>>>
>>>> f35b5d7d676e:
>>>>
>>>> Benchmark 1: make -skj128 LLVM=/usr/bin/ allmodconfig all
>>>>   Time (mean ± σ):     547.927 s ±  0.862 s    [User: 47913.709
>>>> s, System: 17682.514 s]
>>>>   Range (min … max):   547.429 s … 548.922 s    3 runs
>>>>
>>>>> If we can figure out what these differences are, maybe we can
>>>>> just fine tune the code to avoid this issue.
>>>>>
>>>>> I'll try to play around with LLVM compilation a little bit next
>>>>> week, to see if I can figure out what might be going on. I
>>>>> wonder
>>>>> if LLVM is doing lots of mremap calls or something...
>>>>
>>>> If there is any further information I can provide or patches I
>>>> can test,
>>>> I am more than happy to do so.
>>>>
>>>> [1]:
>>>> https://github.com/llvm/llvm-project/tree/96552e73900176d65ee6650facae8d669d6f9498/bolt
>>>
>>> Was there ever a follow up to this report that I missed? I just
>>> noticed that I am still reverting f35b5d7d676e in my mainline
>>> kernel.
>>>
>>> Cheers,
>>> Nathan
>>>
>>
>> #regzbot ignore-activity
>>
> 
