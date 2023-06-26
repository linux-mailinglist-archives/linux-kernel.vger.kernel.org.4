Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A784973DE51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFZL6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFZL6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:58:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41867E43
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687780712; x=1719316712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OHmaQDP2tBc+n+UFGY4N6QIM2APmcj6zAupGOwE+4Ik=;
  b=IbKdhgl7mLn1IkPxaJ8VLHejhQz/RVdrYDS+scul3OyRj5XFB2xMc2v5
   T93OuxFlZi8gM0aWwkrVCbCnXWwat1WPBzJFShoult+/h2r1egSU7zy2N
   uobt+c/Cq9Zq12OW975xYgNXHmuR8lhdvpXT4/dXLki8Do8F/cOkSAlgD
   Q1YOqsQRhXV0SYKQ02mY6Ia/rByGCuzCK7aqbJP6KAX55RaL1UgMU/x7s
   HPIMjQTrCoWGfAmWT7YLfDBYsN4bHtwSwJt9LBmidzvvn813ynn66lWnP
   hMRFtv3Lm74rBRXQNAroc2cbgKgN9EMTUjosbPLi60dij7RE2udHjGMeh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="427242214"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="427242214"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 04:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="829201637"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="829201637"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2023 04:58:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 04:58:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 04:58:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 04:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezCEvURzE0pcjTX3WTvuYULcA7+BGIKcwk3U7oe63WI35HdIX6upHse1CS1vOBCqI6MPIkfpU3HUFoM6wtBHwG9VrV4NiEMJKUIJCZVgSpe8F+GYyGTkPmch+8FPIdjVDaZSM4AoHTrwdIEwayMUT66bSIcAfW9fiCc7n3qJ7g9ZgcP4iQP7cS/UC+c/B7ovP0eoFljRXNocOnfqWry8EeiAP89hLI8WK5aDq2gHUEHk/Yy8LNVO2da0zFQwzqRBZQJjiND/reBsnUSMoAl1lu10VdqIMgDtCde6LX/5/D8tZhMo8Hb6ASajtZM8m8kSlCUtQwjlzHPy+br7T+zDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZl/PfSbxQXBuNx6X0BjRAeuNLuXr6CeDNkzZquxfB0=;
 b=iAQCbNOuhrfyLxjuCXA6Wism9ToLK3yLJacC2zy+FFmw4llQ0pqADR00xM7BcpGQLqGQeAD+CgClT83/XwZLn+PeJbgJu3lYouozGxZXEP7+IbmuCBAYN6fnktvk2TxUSMVVk4NQE67Qq+C91HHJhK3xCcmlSA6vP/DkkfqbW0lq2WzCQpZNwpMkdmgT0n+ASbvvDiDEs8W+tgvQOqMo43j9gw6C9UnQhEWcx44pCW7EJufxPn3rjv5NxbeSLOO5pgyUPPVRcTVC1xDEBDWUlXI94k9XFAhX0wAWljBWzuHEN5o7NwMMmuDJe/BbeKzVZoA43oLqigVZMO29iZjEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 11:58:28 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 11:58:28 +0000
Message-ID: <0e50e878-3944-c57c-1dbf-10d260f05afc@intel.com>
Date:   Mon, 26 Jun 2023 13:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_372
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>
References: <202306250533.CBxzOSEh-lkp@intel.com>
 <ZJlNMwzlt2MGTvBp@smile.fi.intel.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZJlNMwzlt2MGTvBp@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::17)
 To DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: fd02b80f-8097-4271-cd7d-08db763ca6ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecFqcMmUTqTimAtRBtXfEgoLMgXuEkfRGuKPHGu75QvUaz+K31g4G3BDRK/qlDQAAhiT/tX5iI6v0ddKly2qkaszgI/bo7ixnBfAqqV16BA0xy1dYE83b8PM0RociTVxQvBSvDvRzi1A2g8V1C/T+NhJKZoTHZUu3hST1/UzSXbJcXR0KN9t1Or8XSRsnBjjnbNV2dHl3nexAuyYhPdFOGfhOCzgnqSHJQbXOHIqH5NHjmJdooHl0K5+tz9eY0WfeZ0JdbKbbbASr0WMFR7hnbDB3gqlgdvHSJAsy9B2Ag+7BpgCUQNlNTGb16yO0kaXRSEIdTegpYUD40+eZW5LGiv0RHJL0lELZ4ZeZZdPKirTfN4qQW2gJenBgX5SRbrGhN3cI2BxmgALB3MG9B+73nmRp0k8B+o5HIUAiRsI6DLlfDe/qBvh8uWOqk5XdRTJI2mCajl9k6i0tBZrNCHz9M9oMujcgp+A7fQKZwYPh93jNyfLMnv3hlT/V3D9RS+inD0iuWWxAB6aUeqR9JNxAB9M91gMw8p87Ql/k7ACRJfMHAWzfea27isjLv3wpvb3N0pq9c5eganQiyQH8I/CT7lyH96D+IRMXEOQKIyG5CvnRCCVOPN9/MyLK57Blzgc9P9YXD0lHg0kpFRJ4zjxiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(478600001)(6666004)(6486002)(54906003)(2616005)(83380400001)(26005)(186003)(6506007)(2906002)(4744005)(5660300002)(36756003)(38100700002)(4326008)(66946007)(82960400001)(316002)(31696002)(86362001)(8936002)(8676002)(41300700001)(6916009)(66556008)(66476007)(31686004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3k3LzFxZjg1UWZJUXNqQUh1UXVJTGJrLzZNbEtWLzlqZzJwNUxxTnA3bVRq?=
 =?utf-8?B?amJ5bnhVTDdKbnkyeXdKQVlTRmQzcFY3TGVrcFRLcEJCMlplSzFVejE3em1B?=
 =?utf-8?B?b21TMVpBNHd5alloRituV0R1MzZLMk5LQThPa2xycEp5aXRLcHl4RWcvbGNR?=
 =?utf-8?B?bXo0WFFwcDcwS3BpV3FlVkd6T0prZ0hvQ0tFUU5aaDZUU25Edk52UnVTOHg4?=
 =?utf-8?B?OEtNTllEZDJibEdZTVRVZFE5VHFhWEZDTzBCMy9rdW02YWhXOVNzdDYrRVl6?=
 =?utf-8?B?OXI1dXl0K0dHdGp3RzBQWXlqK2ZHdmZPMjkzbXkyUm5ySzNuTlZsazdhbG1a?=
 =?utf-8?B?Y3pwT1ExWWlCdW5jRXMrUE9XakFvSWY5WEk2TU1RM0Qxbi9RZUZQdzY0cWdn?=
 =?utf-8?B?N1pIZ05TcTNqRXpkK0dsSFcvYU5IdjdGTnc4d1UyL0ZrWkdoYWl2bEZFZG9Z?=
 =?utf-8?B?TVpCUDNKczZmaVg2aytaZ1pvVzN5VkVwNHpUWGtWWjNvRTJIZTdNVjF4cEZE?=
 =?utf-8?B?N3BNNnBkUjl3RDUyNmtDUDVvZWFpYk5Qdyt0ajBjUlN6RlUyUlIvQmxSSjZG?=
 =?utf-8?B?ZmhDNy80MWxKaGRzMWR5blRzRDduYUpCQW50ZVVaeXBYRDJKcUtqaC80M0Fv?=
 =?utf-8?B?MlpKMU12dzFydmI2MFZPcXk0U1NlY0xMeEhKbmZWWk80dldyaXd6dEY3NFdC?=
 =?utf-8?B?WFJDOS9jbjNTQk40aHpEUXh5eEtOcjA5djNmQ0tOUlNKNXdRRUJOcnkvWDZn?=
 =?utf-8?B?UDZGQXdBWHc2Zng5VVRMQldIK1psY0h2V0JBblpHeHlxOC9vRi94bUlDQno0?=
 =?utf-8?B?SXQzNkU4ajJ1QlFvMzBLakhEWllEdWNJZmFscjVwcjhiMEltSmhiazlKQnNB?=
 =?utf-8?B?TzM0bXFsdkYyVjJIYWQ5K0NsRmpaYy9iOTJFaUk0YjFSamNuZmsxUjBSN2g2?=
 =?utf-8?B?SkdTL3VXVTl2bUpYQ00zbUNhb29YWHpQRzFNWHkwY01XZmhFalh3TW1Ba0tM?=
 =?utf-8?B?MHd6K1g4OUQ3eDZ5QTZEQlZtWFltcFczVXdldE9GY29GSEhqNDVvTUpKMzh3?=
 =?utf-8?B?SEI0TmJZWW1TNlptRVZZOHVWMjJqMW9sc3EwTDdnNUIrRzFCbk1hd282VFY2?=
 =?utf-8?B?ZHpIaTl0MWRzbFVPYjd3K1hUL0hDZHpIeldmTW56UVJMSjFRYVRwLy9FSWY5?=
 =?utf-8?B?SXQ3cWM5dG1lYnJDd1lObjVFNkdFSmMrQ1JtYTczK3RadU80QkVBYTFCa1J0?=
 =?utf-8?B?bEMvaUFUYUNPU28rTFBLVGMvbHBVM1FBREUyY2wybCtvQ3Y1bGN0eE5DOEsy?=
 =?utf-8?B?ckIwTlFGWC9VTE5TRGxMdXBDMzBXRC9lYnYyZDlaL0hZVTFLQTdGU0tSWWdz?=
 =?utf-8?B?RG13Slh3OWp6TGxMR0hQZFhoSFk0U2tZWnF2TnhGZ292SnJxV2pnR1lib05O?=
 =?utf-8?B?ejZsRkFMc1JPOUtENmFEdHhyYW9VSVlRbXlDK29IK3hoUUhBL1JPdWdFNEpZ?=
 =?utf-8?B?RktITy9hZkpPN1p5MXYrZi80TUUwRnowODh6bUxEUTVlUkxPckgvMHhKMnNm?=
 =?utf-8?B?aXhJUWFVbUZ0dnVNelRiS09BLzBKNmxRNWRDL3BBeUJhRStiTi8wckFFdWVK?=
 =?utf-8?B?bzNUM29CRWhUaDBFUW9BaFNVY3ljcUh2Y1RWZnkrODdSNUNJMmJZUW1DdGlT?=
 =?utf-8?B?MkswTm9hVU10YVJsOFhiRHFyVS9oYmRySlFUVXF1WW0wS211SjVia3UvOHJu?=
 =?utf-8?B?UytDS1RsMDJKNTRnRGZYZFBmTWlxcmFkVVc3M1JWUXFneGFHUTFSV3ozaTFu?=
 =?utf-8?B?bGpGVnkzc1FncTNKWDFxeUQ1aFBWVzM3azgyTVpVdGV3T3RKcG9Xdll0YmEy?=
 =?utf-8?B?eDR3ZkQ4V3FXZmVoTi94b25INGFjd1RlNXNCSTZEWTVpbHdaN09CQ1VDRk5C?=
 =?utf-8?B?MGJ1TzVFcmVFUmZubEsvVUtuUC90dExod3ZmRGV6Z0ZKbVNGRHpKWmFSejZu?=
 =?utf-8?B?NUJJWnUwVi9DSHpoalk1Q0J2bmdaMUsyZXM5RnRrdE5BYS91OE4zUm5reHpn?=
 =?utf-8?B?V29aV1VrVGJWNVQ4ZHZ3VjN6cUtLRmxqeElxUDRVc21SUXdmZFNoNHJtNXdI?=
 =?utf-8?B?b2t2NFE2eURUREkzMTB1Sk0xa1NFQnJSTUZHMmNKQllVMytVeU00c0llWjdv?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd02b80f-8097-4271-cd7d-08db763ca6ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 11:58:27.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/e+H8EpM0azXhJidFYe8qVVkRwDwWNUF/p1PIij6USZ0Tqknl/TPMnQ2BuaW63DFwJKntlw96MJNRSgfFsAiMsk4blNKp7EllH9KzmYanM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 26 Jun 2023 11:32:51 +0300

> On Sun, Jun 25, 2023 at 05:12:36AM +0800, kernel test robot wrote:
>> Hi Alexander,
>>
>> FYI, the error/warning still remains.
> 
> Alexander, do you have anything to present to fix this? Or is your plan to send
> something after v6.5-rc1?

Hi,
I was waiting for an email from Nick (or some further update of the
GitHub issue page) to clarify whether the compiler should be fixed or I
should work around this in the code. If the latter, I could send a fix
this week, so that it could even hit the bitmap pull request.

Thanks,
Olek
