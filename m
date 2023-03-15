Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB96BBD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjCOTa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCOTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:30:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA279FBCB;
        Wed, 15 Mar 2023 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678908587; x=1710444587;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VlH+uWlFkB8UQH+ViGiO3PakfKFurW2c/soxyTFWXl0=;
  b=QEUgn0c6B5DeHfgSSCPIKCA8EUw/JUJQ2rjrRdLpbiq+pMtw+mSvgeJp
   ha5R/W9UmSW1tUY6z5ge8+JScHb19K0YvnDv7z1NoXKcBK2RQbjEfr+9n
   /4qh0Asm1QBhzqGV2gHzP1r6pvMm4bWp9+UKGwtzijLLG7FolzldItKVO
   tFmcftTrgT/cZ8FWlQwWVcz5OgjeCP8btwUEgHBmcS9zMJV95Us0iglYY
   7TbzNyN++e2fpA2nmF+q/VsC9XOCG4UzkiF5mKkc6+Aa+IljZl0zwbtmr
   P0ACdHvnQCxKAl+mgs+0u4hkOxo5jMw6L5yPX5MKq9FjTpsdANEla76QM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339342756"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="339342756"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 12:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="709789866"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="709789866"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2023 12:29:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 12:29:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 12:29:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 12:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn9cEySWmRbrvy3vcf02Te7m59cb0RNyjd5Lkaidua2QfqtbDrfh8D+IAzjCM/SjSW2IpPYwtx70NtHcq/Baw33yCsRMEzzL07bEvfwQAbUdqaqF7b9PLH5IlydsksKtL3IEQeqP4qKcSm8XFrxqgzOfIMMjAoV7CIQdYcr9U3run4U/x1QxIpIDJpi5+WRcxL8VhnMQQ1md60adATs8mGKvrKK02hHIh6jIjih4v9LuFsNIyS7Hqkt7VACYh65NYQw6JeHYNUMEUYNN7YgL7v2M8/uuzA3vyYoF0TidXXHu7PlhMRS/Shuk1GdWhVgHMJj2bwZaxOJFldbt8yQjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd4W/ajDcKQjdxyTtTwZ6kSLScDT3emHAyxVk43MZBQ=;
 b=Z2s/byO36bzGJu1JjPHZynYe6kGIUkKG2vPVtrpPj/l8CUVZ5fqwVLWuFzZn9TWHLGzhzm2iB4h4Ah16z51954/olw10EbPon7mNH4XeFKuigxmiIutDOQn/nmug0QhcJ6IEy1S9BidUykMDi46rxAnYF5YJMAwYvjSDoxbO0H0gVO40KwfSEvL9jWxtQK9RcBW9NGlT+OF0pGv7G4BwHyoxl+hr71/pQgXmlet66RC3k9yA3i4+DJKWMhBfKflAV97qE+zSZbGlQ4RhFDgWFVR5b6Sq3lXv4KYD2unCaZBRE/V653BqqIya0jCXrHiTLluCafzIlaordVN/miJBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3771.namprd11.prod.outlook.com (2603:10b6:5:13f::15)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 19:29:40 +0000
Received: from DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::fedb:2295:43aa:6a3e]) by DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::fedb:2295:43aa:6a3e%6]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 19:29:40 +0000
Message-ID: <363aa89e-de06-6fc4-e396-d8cc311017b9@intel.com>
Date:   Wed, 15 Mar 2023 12:29:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/8] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-5-jithu.joseph@intel.com>
 <7f82f241-39ee-15e0-1ae7-e98e50730c95@redhat.com>
 <275d2f04-782f-2c9d-187a-7a510bf34f41@redhat.com>
 <SJ1PR11MB60831C996C2EC462262948CDFCB99@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <SJ1PR11MB60831C996C2EC462262948CDFCB99@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To DM6PR11MB3771.namprd11.prod.outlook.com
 (2603:10b6:5:13f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3771:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d5c939-e5fc-4509-c1c2-08db258b9eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Puxi8VCMVq0h3qYFGkFmY8PtQuIzCrTdoRO6PZxma5dAHFX87U335xrfDLr2SzVrm+hxYRHcDSe9d0+GO+W0a1pGMdN0w7STiXL1yOztYkLw84kDNqwM3P1FOzGvZy6PUBQeKKoprpeoWnjPjwL/UetdVc/XtBqdNzxdR8bKxjHcU78zIXXl5cuHKx4CaWTwwI5tRVeybEySIQkKtH+ZQXEFmGfNuSIWRzlXxMVn8L9sW2/tw8J6DlnvFN0StO3N/6W1so66Z9AM9bX1f2UV3nWGltGJjvoQO7hJ51B/4yftLfisBCM0AXeUtzm0mlQEwlwJjmJZOJjQ1AhMsh84FuQr9aGRDEVn8YSYEvcEEbWlpEGmAdGYXUFhf3BH+zno+IcSonlgRdnK5ixQ6x+HjOYv15HJ4j8fLcEnUsFFacP2MMo7VM/h9cT7gpF5RrqIqeS46aUiR+Jef50KSvNfq9Co7CTR/1yertoFj3IzHTDbIpGXZJVhiClgKP5MG5Xt3lApwP+9WeVNscQraiUMUxFP+i+OwZ9JDAjmhxlkGk58gCujjqD+UhUOtzCEAVYcY/L35xLXAHB0edEbIU4vRT9ebeMLR2Kg/6O4qfGvm8XoPD5+Jq7M3LyPk2cSpXIfe5niu/dLVche4fXnBDvoZg8ER4LHChkQ/E7RKR68KGD2Ynn9GDjVwRyJ7Ei5iqj/i1NV1QJvLivYuDFtVgR0HRrcpZO+qJqj5pkViuhWeU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(31696002)(86362001)(38100700002)(36756003)(82960400001)(8936002)(2906002)(7416002)(5660300002)(478600001)(4326008)(8676002)(66946007)(6506007)(6512007)(53546011)(2616005)(26005)(316002)(186003)(83380400001)(110136005)(54906003)(66476007)(66556008)(6486002)(6666004)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDkwQytsbjgyM0tNaU4rc1VRWkhHVUc2VW8yKytJeHZWSFVkVDhpazU4Vk5H?=
 =?utf-8?B?WjdJeExWQ0FjeUd1WEZ3NFhkcnNRbWZ6WStURG1ESUtHV0MveDViYlBvMTVJ?=
 =?utf-8?B?S3Rydjltc2JDMHEyMUhudlhEZE5iem1TWi9CYmVITjBDMVJKRnNWZXVOaXNa?=
 =?utf-8?B?SDhONUx0OGsxQ1lGdWl5allCSEJkdHg2RXIrL0hKL3NvNWlyRk5mY2FvTzNM?=
 =?utf-8?B?c3pFZFUyYzNQeTRpQ0lJdUlScStLb2Nqc3lXVEdRWFlZS0tpdTBkY0hHbWRi?=
 =?utf-8?B?TzRUYkFzYWJhekFVaVpkc29kdjdnZm9ScGthNDd2UEJqai82YmFsdHVBOGY3?=
 =?utf-8?B?YXlnVUkvei9KVjRJbmV5allSUmVSeDREelJJWEdqWXhvdFdJOE9ONnh0VW1i?=
 =?utf-8?B?SmdYelB0dlJGY0xoMUVyNERMTDVnak9BckFubUNWUmF1Ujh6eW5jbm5TVTlR?=
 =?utf-8?B?NUNKMjJhUDd6R3YyRzRMWjZvaFczdjZRcjl2emxjR3d3cUF4cG00OFVxU1pT?=
 =?utf-8?B?c1hKVU9Tdm14elRxaWhwbXIxZEQvVEZJMEhlczhnV0JMTGQvN2JqT2xUS21o?=
 =?utf-8?B?TS9QSmF0eWNRRTNoblFOODJORkxYd2ZXT3RJWisrdHRaSXJ1N1VwenRQQklM?=
 =?utf-8?B?TWo2dkF3cEZoNmhwMWI0OWpRUUx4Q3F4aUdRNTNtVmxVbDlPeld3SE9ySGwx?=
 =?utf-8?B?ZTZxOEtZUk5PaXNDcVRkblZxTXUxRFdXaVBqcUpRREI0WEFqOVdhSWVQSEFY?=
 =?utf-8?B?TjFXcVBGTVE5YUtTY3JiMWpKWThWaUdURmNaVjJQaE9mcFZvcWRlN0tYY0po?=
 =?utf-8?B?K2FQZzZFYUxIYWlMbkJ4cUdZNVp3UmZzaUNtMlhDQUdvUTRQNXZlbzZxSVNj?=
 =?utf-8?B?NjFJVjFDSXltVUVkVmswdVdzUXdiL2ZDUTIwRHhiMWNqSGdwd2hsUlNIVW9G?=
 =?utf-8?B?RXphOUR1TWx6YXQ2VTF1eGljb1AranBtUXBqTjl6Z1BOSFR4a1UrVTNvcHJR?=
 =?utf-8?B?L2Y0amZueWh1V3puaGxLY1dsbFlOZGdlY25xRk5OZmQxazNJOG9wRFU4RWV3?=
 =?utf-8?B?aWdDQnlQOHhJMzZ6L2l2Q3RlWGJJUHE0bURMblJramVzbkZvRVJVL054SEJk?=
 =?utf-8?B?N3UraDFqcHduSm8rQWZqMzF1Vit4dlZ3WEJkSFdJbDRoMjFOOHBIUGt0MDBD?=
 =?utf-8?B?OGxaRk5yUzZoQmtPRldXUjh4VGYzenRjZHZJc3FRbWVNT0RuSnU0ZDdQUXJP?=
 =?utf-8?B?RGU4OXM3alBKajlmUGRRa01DVzBPSlJuVUIrK0g2ZTltUW1meEhtSGJ1a29v?=
 =?utf-8?B?QmFiZDBTcFh5cklNRU4rWEc4OGZuSzhXN2Rubkc3a2xMdFNYdTNHOHFSbzJj?=
 =?utf-8?B?MGpIL3hoYXpCaTlDMVVGZzNlVGNiN0lPWnVGQ0taRjJ4UXpMS1lvM3YxbVdB?=
 =?utf-8?B?YUpjTFZOWkxCT0J3NjZOdDR3Sm0xNzExd24rUlpOZTdTWHBKRENMdXdIUzNP?=
 =?utf-8?B?UlRCYzhGMkZyakl6dUZBQXEwbTlFdWVvZGpqR1BudlBhZG9GdkFjT25FdWpU?=
 =?utf-8?B?MG9tSzBxSEpXcXdlTC9BNmdHb3lFa3VkbjJSTmFLdG1tYzgrbVg1UkNXNWZm?=
 =?utf-8?B?RFpxYkM2QWJheTdRMGJnZk4yemtMemZwTWxYTW5HWGFsWURjUHB6bzZsaUkr?=
 =?utf-8?B?YWhvY0NkVWFjRjM2WUJxSktYRjhEbDc1WTFad3daUkxpUi9NY1IzTWVEZEcr?=
 =?utf-8?B?VUY3Zk5vSHRhWXAyK29YL1JEL2lWN0FkTytuTmx0TEhEL2JjcVpJVmtxcksr?=
 =?utf-8?B?WVBVOTFtWkJxTXpha3JtaFNDdHRmcHVKeUpvdjVxOFlHYVgvbkc2N3g1L3h2?=
 =?utf-8?B?NXEva1AyblkvQkVjdGhPdXk3WUpmRjRwdnZ1Wmdzd0lxZ2Z2TGxJeFlTaThV?=
 =?utf-8?B?M2lqTjhWeTl3VUVEK2MwdVg5VXlUM2dNK0FDSzVjQzhTVzJ4Q0ptd0lDWFFn?=
 =?utf-8?B?ZVBnM216ZGxsU1puTExCRFlnQkVxaDJ0c2phSGZmSGt4Sm8wZU9mdUFhV0Vl?=
 =?utf-8?B?SkJLbDN4dUpteFJFbDVqSGZXK0ljcm01cng4aFhnT1JGRUZ5RmpaY2hQTmVq?=
 =?utf-8?B?Y3RZbmo5RXN0SnZQMEhUUXl5RVVXYUU3ZVlZQjBaUjZvVFJNUnlQUWJIcWpj?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d5c939-e5fc-4509-c1c2-08db258b9eaf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 19:29:39.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hF8sye2k9jKyauSAsZPH10nAdDt3G+vXMWhvYkfTJWeT91WwkB2rfdm/vcYTLUuRWM+okXDOmmsq7qvmlVsDYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2023 10:21 AM, Luck, Tony wrote:

> 
> 
> I'm not sure this is better than splitting the tests into different directories.
> 

To provide a bit more context to Tony's response - 
There are similarities between tests (one of the test inputs is cpu number , which is 
common among different tests , so are the test outputs described via status / details attributes)
and some differences too (distinct to each test are the test patterns, some tests needs to
load test patterns appropriate for that test type and some does not)

Current approach of keeping each test's attributes in its own directory (intel_ifs_n)
allows the driver to account for the differences naturally, for e.g load test file
suited for a specific test. (I.e if the load is issued from intel_ifs_<n> , the driver
will load test patterns from /lib/firmware/intel/ifs/ifs_<n>/ff-mm-ss-xx.<type_n>).
If load is not applicable for a test type , test directory doesn’t show load and image_version attributes). 

As Tony mentioned, similar effect might be achieved using distinct load / run (and image_version)
files for each test type, but the current approach of organizing files per test feels a little
bit more intuitive. 

Grouping attributes per test was the original design intent , when the first test was introduced,
as indicated by the existing ABI doc (Documentation/ABI/testing/sysfs-platform-intel-ifs),
wherein attributes are described under /sys/devices/virtual/misc/intel_ifs_<N>/ …

Hans, Shall I revise the series incorporating the rest of your comments ?

Jithu
