Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B39749DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGFNbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGFNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:31:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B321BC9;
        Thu,  6 Jul 2023 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688650284; x=1720186284;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ztGqUcDxuLYu7k7UNykISfWzKsWlHlcOY57f6hilDAc=;
  b=Uban8rjZ+KbYHVQZpIMIGb/8tOfvxw9LmAOuLTJChQnCeGYsDKU+IDGI
   9hM8TYbbPolBeBwvPOFSGkzjBVP0KKl0QafCreoxy/abYEePjOR+onsGb
   dUNOqWqY/2zLoczuLSLYL9KHSgy60l5NNT5LPzYq0bDMc+d6TXidQQBtO
   KzbseVKeenKKbHXUnPnaUd4wspo5ybmGprI7xpL+4+idGs+wVgoRmrN6V
   dRWai9fY5whfIhEUngBLt2xPPv02n9yhZKhZZTr06Nm/N019VCvevBGFH
   v0QX6JvO2n1epNCK1GWlIPWd4lnrhC4RgNx3iewn+lD+1baz32y10s5KV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="353439169"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="353439169"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 06:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="719578449"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719578449"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 06:25:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 06:25:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 06:25:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 06:25:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgWlO9u9mjtwzQyitTsMbOnsRwn7Xm+FAtBXcr8aooYjFrHVhrfl73Py6fL4fzgFrs49p/hagmwVhm3W6yW7vSr18a9YLZA2B5ngDgAvuWig2VifeGdjiv0dAH9iyWZp5lR/NXSYMMeu6kWLkeydj25v4u74nbspch4gtfsPe9sIpx48ZnjsFbfcvr1pSayMvA01VRDrbz0+MwfCVAhaE2jIXOwjGdk97h2pIrd7Qw2G1nft7YULkenQKUJ1tWra4Z79mw7EJ+TddFRm/94bAD02ouQJ1wBDMry7AMcOhw0HVHSvTmDoUKBPcOnq+brMSCFl2XGNMUNnBBpBEFbL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSgHCNWJKLSV/Pq3Wm/nXipZAYB/+mC8BMz5UaVhnD8=;
 b=Zjy6GdUA3gHu+bIPQ64mMbaerj5G8dwI/fDpIDSe3D1qD6CeYN8RKtj2GEaKcyglr9lo70OJblJI1XiAvTOdD5Zz8QSnEd2ak70gVNGgklhv8Hyt0Q/SZXMbaH8vQZpTB5CTZyBuZW1HS2dgiTR1KYe7FI5yLKKwyYbeYYTgqT0x08sKyJ5PAcyq/EJjW5dkfF0m1/kIYyR1TM5xDj4X9lA3VYj0SfaL7Ba6+/8empa2uqHKjJR0XK5uRdeTGG8bKZYUvpCJMZVeTi3LrCTXHSIgZ8FyB26JV9mI99scetymm99a2XqWWK9FPWohpktLXT7H0oA9dT+LRJAZDwN8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 13:25:11 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 13:25:11 +0000
Message-ID: <29d75663-4013-7e04-f345-c9bbd4b95410@intel.com>
Date:   Thu, 6 Jul 2023 15:25:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <artem.bityutskiy@linux.intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com>
 <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
 <CAJZ5v0gWuU1JPbzYpDZ6YQ4YNydyELQ9tXKcJgmLwe_=fZ521A@mail.gmail.com>
 <e94c0d23-4873-5c34-be24-c2208d03043f@intel.com>
 <CAJZ5v0h3mNFa4P+5o=LtUvTW4VnJs=4SJxvjoYMKCeir4tXfpQ@mail.gmail.com>
 <ba919f97-894f-8fd3-fdda-1f170c2a6fe6@intel.com>
 <62790f91-db75-fb8c-dec0-7354e299c89b@intel.com>
 <CAJZ5v0iO06oYfsFcv71H7ZshPgwEqYH+wxHrWTp=iOZ3bBOsQg@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0iO06oYfsFcv71H7ZshPgwEqYH+wxHrWTp=iOZ3bBOsQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 809654ad-c4a8-47e4-cc33-08db7e246ce4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MppqWZwZKoqP+2FV5iHq5un/ZQzdJ2k2V3cwl570CZHuPD0ffZw93RYCMeNF1S3ZvOX0zRUN++8qdX14a3+8TnvU9rSCfOrjpakzbk25wlFpG9xOIBzE919oOUJHyOirhzpOqtIFUJ5PpUdSZNIS611IRk9c/HjA1OyyfyUwFZoHwzlCRP/yr92pBWI4T5xtgtimJKvnC7YzdQ8UnctXa+oLk2nBlR6MWDJYxz+EAqacpJ6q8JfzfwQ1G3MbXauJAAH1mX5YoEZkjOXjCz0PHssRWnljZlaoIxF3FHetKd1OeaZzLamo72ohVfPqDcOD/yCTCGR8+G90Vr/ria0acAgfw6AVlbOzTJULWP0UE68r7NcC1HgkffkClYIAdr4WAXtX9MTTvRR71EaV6+wC2zOx2pqGPEa9NoZNcX/Z+2ZHukMvV8VztXgDn7TOoZClR2pHVDNGxX2AXyw18AKeih01tQLQTn60BIjFOIasQQSsbiNADhJDGgBhfW1p4haSa1wkNrwgHMSbHpIiewPFfCDod1OfbUAVm4bgy6hfiIziChIAox095rCLPlOs7ZMke3WbfL5kGLrMBXicaNUx7lJrNHrUS/D0TpE7yESea5vus6EacJD5+Q+N478ZYz3ZRE4f7suPI8mZxD0lt4aNkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(31686004)(7416002)(316002)(66946007)(4326008)(66476007)(36756003)(2906002)(66556008)(6916009)(8676002)(8936002)(5660300002)(478600001)(83380400001)(41300700001)(31696002)(86362001)(6512007)(6666004)(6486002)(186003)(26005)(53546011)(38100700002)(6506007)(82960400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9sTnlHRmNDazREamcvejQwWEoxS1YxRkJ6c1cwR3d5SzE1bUhGMHIwQmdM?=
 =?utf-8?B?cUkxUGV6ZzFKVFFzakVjTUdGdTlCWitDRk9ZNG1LblpXM2xSeDhEcjlYQW5l?=
 =?utf-8?B?Zi84SGx3NUFVSWNJRjlZWmtocVZwRHUyS0FJbmw0Zm0zWUt6akkvVU1BM1lQ?=
 =?utf-8?B?OHNHRnU1ZTlLa2JjQTN6UkdtRUVkTXJBY09XcFlwMW0vbnZ6aVFkTjlJV0Zr?=
 =?utf-8?B?ODI1ODg1cnN1SzdzRi9yall4UjZRWm1mTkNVWnp1TUF4L1VnZ1h1YUl4Vmhp?=
 =?utf-8?B?ZHNHbVJZbDdmeHFlVjJMY1dJbnI3cDF6NldHdTVadEFncGtUSC81Wkc3YWRC?=
 =?utf-8?B?dUJ1cW5pbmd0akROZ1VsbTNwQ2s2Q0dCZ3BhWmsvR1RxdzNkTC9PY3IzSmtX?=
 =?utf-8?B?NVNqaGQ2MWVBY3ZqTFNveDVKVjRLa1F4a3BtQXJISW9UY29TRlI4R3dEa2Nq?=
 =?utf-8?B?QjUzaURIM2lsemlmSzZ2Wmo4NENBR2Y2WHhzRjFsRUhua3R3bHAvRW5hL0Z6?=
 =?utf-8?B?MUZEbjVXWW5jTnNpRXdjZ3hYQ1diL2xkY0NCNCtISTZqbTR2SVBDVE9nV2xJ?=
 =?utf-8?B?cHN3UWVZaTQ2dGlGMytjNGtNejJ6ZzlWZDZWWS9NYkM5dkRSK2IzaHFuUDF5?=
 =?utf-8?B?VDk2Wm5EaGRVTHFDZUFTbjB5ZWxMYVEwQ0grb2hjWTBmR0JnUEV6OG1oNktv?=
 =?utf-8?B?c25FdE5rdjdyVTlBQWpMRjNTZ1o0RmNSR0JnVS9URnRxbVVFbzZhVXVMbDZk?=
 =?utf-8?B?NEdiODZ1cFRSL0t6bUxxUlA5ZlhmSFRXQmNZcW1wanRKNkd2WTd0dEcrZndC?=
 =?utf-8?B?RkJvd0Rwc1cvazhFR2pkWVhFbWZVUVlhQkxIQ08xbmk1MlJmWnpYQUd3L1pm?=
 =?utf-8?B?aFlZOENPV3lsb2x2aW0yQSszTWpOMlBVWUhLZkVpbzZVQVJwUmhvWWswSGsv?=
 =?utf-8?B?K2tFMFFUeFpITzZTZktlVFJlQ3ZjcTdMTGI3NmtiYWFGaWJDZ3JOUVczc3cv?=
 =?utf-8?B?K0JyRm5qczNlYjVzZEdidW1DTWtHNWkrQWZjem9palNWNzd4QVlGb0llTWds?=
 =?utf-8?B?TG1UQ3VxU0RPaExyZEdNM3BPZVpwSnZ1UXFTZ0lDYjZkdFNSMWVINjhhUVdG?=
 =?utf-8?B?T1l0dTVRMk9XcUJoeEY3NG5iSmZ6dk9vZkVwZDdNcGVITWdCN0p0Rk1IUmQy?=
 =?utf-8?B?bDV2d2MwTkFNdHBGb0RRTTE1YjBxVzVMZHRZaHprQmlxQk11NW1VaUxzVVZ6?=
 =?utf-8?B?ZE5wRTNpSHRUL2JZZTczT2RmQjFVdFNvZ2s4dWFLWThoY1hlWGgwaEpSbmZX?=
 =?utf-8?B?STUxQXoyUFJuMnZBTTZXL3NnWGhMQ1pQNkxNOWJhdXF6dGRLcndpZ3lxUldL?=
 =?utf-8?B?TEY3N3JkQS9EYzU4ZzBncnFpOWRJQkFtVEdVYWVDcVIvQjVxdC9OK1YwM3U1?=
 =?utf-8?B?UWpvNnNPNUZqNzBKZ2ZRMzNUMTE4d0duaThLMDhtZVNibUtsVGx6cU9VUlll?=
 =?utf-8?B?SFpoOFFmNFltVHpVVWZTR3NkSUtVb2VLTzc0RWlGOWhlRHZpRWF6QjZQM2Jt?=
 =?utf-8?B?SndRbEx2UUZwcms3MzdmUWp5MW9tWVFtODhBYTE2R05tWUpXUDl3bzkyVlF6?=
 =?utf-8?B?UjZVcm1RQkdrL3ppc0lmYWNhcWdNVzJjMncwYWdJNEhXUkovUGJ2QXpnWmtJ?=
 =?utf-8?B?bUd1b0NmUzcrblJOM29jS1ZRYVVLYUkvYXd3dmxIL0lOeXNpTnJLYTRJTmYr?=
 =?utf-8?B?Z2dOWkRxY1dWSXFLNzkwRFNFOVZGUlBPTTlRNUNiNUVjNnhTMXl3VjBhK2d0?=
 =?utf-8?B?YmU2cjhZSW1aSXA4TVBxYmxyNmFSamJCdmJGbUVITnhFdHI1ODNlZnk0UVRy?=
 =?utf-8?B?QitlOXBPYW1HTGhIOWprT2tjMTZWU2dseGtpdURVUlhWVVp6ZmJEVmFwdDlG?=
 =?utf-8?B?OWJ0cUpzNnkvNGNiQmRDN1pteFpMRjhaT09sVUZUenpBS29EbUt5YTA3dUxy?=
 =?utf-8?B?VktIK1h0UjNDdEcvZ2xpdWEzeXRsTkN2VjJTQlBjZGdRRFYyelFqYll1UHhU?=
 =?utf-8?B?NE5GUTBoN2lXV0plWW9Lc0VnRUZwNkM0dUtPVzZXTFpxbXEyTzF5MzBQSzdD?=
 =?utf-8?B?R0NNVHlLd0ZWcmJxSHdVY2pDOC9obHp4TlMzRWVCenFYdU4zcENLbU4wN0xL?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 809654ad-c4a8-47e4-cc33-08db7e246ce4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:25:11.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCY7lueCJ88Fuc7wmb1djTqF5I3tNZDwX1Dg3ixxXd7tWYtlz23lbQ6Vkum2iDSmylzRKQ4Hq1ybQ1wP18le41Odra7cs70pwVpqalni8xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2023 5:22 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 3, 2023 at 11:52 AM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
>>
>>
>> On 6/30/2023 11:23 AM, Wilczynski, Michal wrote:
>>> On 6/30/2023 11:10 AM, Rafael J. Wysocki wrote:
>>>> On Fri, Jun 30, 2023 at 11:02 AM Wilczynski, Michal
>>>> <michal.wilczynski@intel.com> wrote:
>>>>> On 6/29/2023 3:15 PM, Rafael J. Wysocki wrote:
>>>>>> On Thu, Jun 29, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>> I would just say "Introduce acpi_processor_osc()" in the subject and
>>>>>>> then explain its role in the changelog.
>>>>>>>
>>>>>>> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
>>>>>>> <michal.wilczynski@intel.com> wrote:
>>>>>>>> Currently in ACPI code _OSC method is already used for workaround
>>>>>>>> introduced in commit a21211672c9a ("ACPI / processor: Request native
>>>>>>>> thermal interrupt handling via _OSC"). Create new function, similar to
>>>>>>>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
>>>>>>>> acpi_processor_osc(). Make this function fulfill the purpose previously
>>>>>>>> fulfilled by the workaround plus convey OSPM processor capabilities
>>>>>>>> with it by setting correct processor capability bits.
>>>>>>>>
>>>>>>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>>>> ---
>>>>>>>>  arch/x86/include/asm/acpi.h   |  3 +++
>>>>>>>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
>>>>>>>>  include/acpi/pdc_intel.h      |  1 +
>>>>>>>>  3 files changed, 46 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
>>>>>>>> index 6a498d1781e7..6c25ce2dad18 100644
>>>>>>>> --- a/arch/x86/include/asm/acpi.h
>>>>>>>> +++ b/arch/x86/include/asm/acpi.h
>>>>>>>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>>>>>>>>         if (cpu_has(c, X86_FEATURE_ACPI))
>>>>>>>>                 *cap |= ACPI_PDC_T_FFH;
>>>>>>>>
>>>>>>>> +       if (cpu_has(c, X86_FEATURE_HWP))
>>>>>>>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
>>>>>>>> +
>>>>>>>>         /*
>>>>>>>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
>>>>>>>>          */
>>>>>>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>>>>>>>> index 8c5d0295a042..0de0b05b6f53 100644
>>>>>>>> --- a/drivers/acpi/acpi_processor.c
>>>>>>>> +++ b/drivers/acpi/acpi_processor.c
>>>>>>>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
>>>>>>>>         dmi_check_system(processor_idle_dmi_table);
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +/* vendor specific UUID indicating an Intel platform */
>>>>>>>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>>>>>>>  static bool acpi_hwp_native_thermal_lvt_set;
>>>>>>>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
>>>>>>>> +                                            void *context, void **rv)
>>>>>>>> +{
>>>>>>>> +       u32 capbuf[2] = {};
>>>>>>>> +       acpi_status status;
>>>>>>>> +       struct acpi_osc_context osc_context = {
>>>>>>>> +               .uuid_str = sb_uuid_str,
>>>>>>>> +               .rev = 1,
>>>>>>>> +               .cap.length = 8,
>>>>>>>> +               .cap.pointer = capbuf,
>>>>>>>> +       };
>>>>>>>> +
>>>>>>>> +       if (processor_physically_present(handle) == false)
>>>>>>> if (!processor_physically_present(handle))
>>>>>>>
>>>>>>>> +               return AE_OK;
>>>>>>>> +
>>>>>>>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
>>>>>>>> +
>>>>>>>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
>>>>>>>> +               capbuf[OSC_SUPPORT_DWORD] &=
>>>>>>>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>>>>>>>> +
>>>>>>>> +       status = acpi_run_osc(handle, &osc_context);
>>>>>>>> +       if (ACPI_FAILURE(status))
>>>>>>>> +               return status;
>>>>>>>> +
>>>>>>>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
>>>>>>>> +               u32 *capbuf_ret = osc_context.ret.pointer;
>>>>>>>> +
>>>>>>>> +               if (!acpi_hwp_native_thermal_lvt_set &&
>>>>>>>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
>>>>>>> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
>>>>>>> questionable.
>>>>>>>
>>>>>>> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
>>>>>>> calling acpi_run_osc().
>>>>>> So you moved setting it to arch_acpi_set_proc_cap_bits(), but then it
>>>>>> should also be checked by the arch code.  That is, add an arch
>>>>>> function to check if a given bit is set in the returned capabilities
>>>>>> buffer (passed as an argument).
>>>>> Hmm, maybe that's true, but the only reason we check that is so we can print
>>>>> a debug message
>>>> No, it is not the only reason.  The more important part is to set
>>>> acpi_hwp_native_thermal_lvt_set if it is still unset at that point.
>>> Yeah, that too. Okay I'll modify the code
>>>
>>>>>  - that's pretty much a leftover after a workaround. Introducing
>>>>> more arch code to accommodate this seemed wasteful, since in my understanding
>>>>> all workarounds are meant to be removed at some point, even if it takes a long time
>>>>> to do so.
>>>> Not really, until the systems needing them are in use.
>>> Yeah I suspect it might take a very long time, and I guess it's very hard to definitely
>>> say that some piece of hardware is not used by **anyone**
>>>
>>>>>> Also it can be argued that ACPI_PDC_C_C2C3_FFH and ACPI_PDC_C_C1_FFH
>>>>>> should be set by the arch code too.
>>>>> That makes sense, but technically is also a workaround, since we're basically
>>>>> checking for some specific DMI's and then we disable mwait for them.
>>>> But boot_option_idle_override is set by the arch code, isn't it?
>>>>
>>>> So the arch code may as well do the quirk in accordance with it.
>>> I think so, I'll modify the code to move setting those bits to the arch part
>> I looked into that, and I'm still not sure whether setting those constants in arch
>> specific code is a good idea. Basically OSC and PDC are supported on two architectures
>> ia64 and x86, so that would introduce unnecessary code duplication, as this mechanic
>> is present regardless of an architecture, and in this particular case boot_option_idle_override
>> is set by acpi_processor.c function set_no_mwait().
> Which is x86-specific AFAICS.
>
>> One could argue theoretically that system defined in processor_dmi_table[] is an x86 so there
>> is no need to add any logic to ia64,
> Good observation!
>
>> but to me this is confusing.
> Why is it so?
>
>> If we have a workaround in the acpi_processor, maybe entire workaround should stay there
>> instead of dragging innocent arch code into it.
> And maybe it would be better to move it to arch code as a whole.

OK, so I thought this through...

There are actually three things here:

- first introduced by this commit
  a21211672c9a ("ACPI / processor: Request native thermal interrupt handling via _OSC").
  It enabled bit 12 in capabilities buffer meaning enabling Collaborative Processor Performance
  Control interrupts to be handled by the OSPM instead of the firmware. I guess it's not really a workaround
  per se, but it was introduced in the context of the workaround. Frankly I can't see a reason why it should
  stay in it's current state i.e executed only once and acknowledged, while all other proc capabilites aren't really
  acknowledged. It should be treated exactly as other capabilities without any special treatment.

  So to fix that I would propose to remove this altogether:

 if (!acpi_hwp_native_thermal_lvt_set &&
     capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {

 Plus remove acpi_hwp_native_thermal_lvt altogether and the print acknowledging sucessful
 set. And leave the setting of this bit in arch_acpi_set_proc_cap_bits().

 This makes most sense to me. I could imagine that the author of this commit wanted to see whether
 workaround worked or not and have some trace in logs but I don't think it's necessary anymore.

 

- second commit da5e09a1b3e5 ("ACPI : Create "idle=nomwait" bootparam"). It introduced this line in
 acpi_processor_set_pdc(): buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);. I think it was
 incorrectly put in the wrong file from the start. It should be set in arch code, preferably in
 arch_acpi_set_proc_cap_bits(). This achieves better coherency, as it's an actual arch specific thing and we
 have setting of all capabilities bits in one place.


- third commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board"), it is an actual
  workaround. I think like you suggested offline it should belong in drivers/acpi/x86 directory. We
  can use utils.c file in that directory as it already contain some other workarounds.
  

Please let me know whether you object to any of this,

Michał


