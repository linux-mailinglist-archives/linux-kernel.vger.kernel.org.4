Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93BD7323A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbjFOX3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjFOX3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:29:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A6F2977
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686871728; x=1718407728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5UeX54Q0mzXPL1DXfKKUmJSVYSs+ce7tF2zX7ef/jrQ=;
  b=T7kZwIdU6+pfcDc6Ty7P8JoTyuuZcOCHJDDNl9lEw0eIaY/Rw7f4UEqQ
   ugfR52LMIN7ejIaRgQn3RQoyvO0VS1MIi4IUU2ikEVlOgkTWs+W68b1ro
   zvwbq9GUpXlEi1ONEYEbNYciW1GLZmb6DBxXUFxWxFm7rFchtGbSdIzk/
   /Cb7bqCh1rx4IRWOP6MU8qNqG0kSEv5+PggSUcX5XgKaZabjQxiVrJVe4
   A80koKHxkaQPzw7+X15ZVCb/aeBFK5IH68FwDzf5WpYUfcUzJmM0n6zTf
   29s5vQ3BDho+5ICf1k26akzd/tlCzJkwVKAv45n/XNi3T8RUyi7RwF3nt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357939627"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="357939627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 16:28:48 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745873225"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745873225"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 16:28:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 16:28:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 16:28:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 16:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZa6q3KtXgPsPWw11mKlCNxEYfP1EKtArW8s1LgtSOuxCol97gmn3qzxqFhHMJ2OudAjX5DLOZyorKbjgA1/iXaqV3YZWlfHSsYY3mcF40KiUiJkBSoOZLCZKVAAu8FVUCDFos1WHOJ0H93SdqGpAnKnFS0+3nf9fB8/7+JJo5Uh37wA3tD3psJRGy6ZPv10eDXLTMyr3SwpJMgErys2zjLVQ+xL2ax6CIDgT1TqsJXuWeUY4gYWm4AGPmSCtXzBHkoUHXFOYVOgvOS8gFg6RZ/RnoL23pZ5QMuzVfy9dgcP6nbnZ1DItZ738stUHJtn64Rdp+xpmVwcrn33mcY8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHUqoMGKdS8WaOHrkogJ219Aj1RLmgJS8pI3gCZBkjo=;
 b=jmqqI0oKrGCzLjvl/1aCoD3As7EBsi58x4O0Rwp8UmEbGfHGaGnNPO6NR6kKQPHAHOzD/3jW5mrWswBdOsU7FLG78tBB3+E7m1rXzRG3AnvyC1vsGqUjfGsMJy23qld2UFjNs92rT7qOIknvcKJA2yHjbE/pqnOPMoem3tdLHIBrirArTVOWK51lflgqeGWncrt2cx4KPHVIZeWmNBUAwpX4Vaj5szsXd7fbelpdTsTz6JDOANRc080TGKtDG8heSWU/fCMMvSnSBfnnKdUg8es+EZyJ3r8SqjOYt2j6Rd6vhFCWwIB17xLTRzwPAHvGhAE4i+LatQVEdVPAW37f6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 23:28:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 23:28:43 +0000
Message-ID: <479ea81d-024a-5a7e-f045-4de52e97a599@intel.com>
Date:   Thu, 15 Jun 2023 16:28:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-1-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 904d7e1f-b5b8-403c-f98b-08db6df841e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LM1oMf496eCjk1UOoJnuvDxl8CGL7s/zfp5t662TTIkw1XeMlJeUz1kPLXitp7J6QIboWCjWYw1SF3ioJFpYNmQNgfqkTuEKqm0We5uP1yy1Nj8BGo1CShYYpyxdl5fsw7w3U8yanPBhmaxr1z54E/ds7zi24BteM4cVxjWS51sPydFz3WJ7g7rWf5oZRf/2mbKTWezbAghMfTFURSpqZOlfiYtNlII6sQUEJHjRx6rr8hlqAn3cLGCqlJZ05oU0UTHaR6I1yebG76rC7UMEgWSkf9YfsGUrgkR743yyACwNJElVRP/BW7tdRatb8hmntfd2E0gCIeeQ6M0wj1KmT2542aFh7lHN35hdY0GXjsALevUpqB4guxMGwYzKf+mYiY9mRaI+ux75oQI+biqyUUKBG95fjxAy9UPNerHkXjdaQre4ea9WzyJR4vA3bkHgj/GMcYpNgpPxzldsJgFVtQd04pc4ld6HaLyazLRJKd3RNl3EyZftvKHKWavJ/BuaAiFtVdAdzxC8DaZsIr5B+IKH1wCWrj5BGqF9L7vviAjxb1xvgtCihde/wyJJgVxCkFZxRCoGSffuAnVX6gOmjETbNBgpQujLWeJD+GOOyXQtowLWsbbuWHKyoqdI6mURkr9hQZhPhkQm/MwRE7LmoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(44832011)(66556008)(66946007)(66476007)(6486002)(8936002)(5660300002)(4326008)(83380400001)(316002)(31686004)(82960400001)(7416002)(8676002)(41300700001)(36756003)(6506007)(6512007)(26005)(186003)(2616005)(2906002)(38100700002)(4744005)(53546011)(478600001)(54906003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDR5Kzh5Qk9SZWhJOGJQYnZFMjRlRlZLVitZY3pmWXJPblExQmpIZlB0cU9l?=
 =?utf-8?B?Q05HRFUxVVRyeDNoajN6TTk1ZzNHR3V5eFBxQStlMGxuNHFWZWNCMGZlbTY2?=
 =?utf-8?B?bFE0YVZzSnRnVXdZaU1PQ21KTXlLZm13YmtoSjdDMDYwQW9UQktXS0Q5ekox?=
 =?utf-8?B?RWN5Y3gvNnB4TlJ2MmZWbmQxOHJ4WTJJNE8zdTJPS0RYZHo0b1hDN1VPSFBv?=
 =?utf-8?B?ZXg3K3V0NFdua0JFMmlYMEZHdWpWVllZSHQxUUZpU3ZqRzY4OWJZSm01ZEI0?=
 =?utf-8?B?Ujc4aFBLeDYvR2pQZDhmMUZoWCtrMTJoc3NTd2ZncVRWZ2ZJbFBIVkVYeU9Z?=
 =?utf-8?B?VTYxbGRaTk03VTNlcks2Q2lzdXZ1MFhFWE9FNDI2QlFKM3NndlZQMlgxbWpB?=
 =?utf-8?B?OXorREpYVUhsaXR5K3BIVmNZdVNSS04yV0trdmIyWllDTG03eTMrVzhBT0Qr?=
 =?utf-8?B?MWNtSy9zZnp5RC9LV0RvOHFPc0tuaEx0eWxGYVZveHVURkNqcUVJOHM4TUNk?=
 =?utf-8?B?Q2d0dStYYkwwL1JjZ0NlUXdGQWZZVUdCOENVRzlnREZLdVAvNytnWElWNDg2?=
 =?utf-8?B?RkJCNkh4T0J2NnZRNFZLbUxVVHVMWWc3OFVSL2ZibWJrOElkQ2ZQNHZPRG5X?=
 =?utf-8?B?TjhpMFJjeVo2NUczcXNiTHliaEtkcFdKRm9JSVB0UnJybkRhUGRJZWw5TEZL?=
 =?utf-8?B?QjRSM1FlZi94cUpRd2drTStrYkxzZzg0YVdSQndpbkNvN3d1MysxMEVteSsv?=
 =?utf-8?B?K3JFUFZ4Z2VjVUE2b2tHOUt4VStrc0FISDY2SmQ2Yi9SdG0vTEVJNHFabndC?=
 =?utf-8?B?bStQajNmcENXdlkxTHZwYyt4ZXBlNTVuUXlTSmxEc1Y0aFJLanRBYmVab1pL?=
 =?utf-8?B?SnJGU1dIZjArcXRKOXZ3K2g5dzdoTlpEaWtaZXZjVFpnSEhSL2djRlpiSFpX?=
 =?utf-8?B?QndmUW9VT0JubmxDMTlSZi9Id1FjUWdGa3B0RFpKYWVZcW44SGRsanpGRHVn?=
 =?utf-8?B?bWRMRktrK1FMMzF6dVFhSEdidHNPS21Qd2RkR0FaeUhIdTFub05jWDZVZlhP?=
 =?utf-8?B?M3FoM1pnN2dZMG4vS2s4R2ZGNzdYaDJIZWphN0hpNlhqd3gwUmFPYlBZWlhC?=
 =?utf-8?B?QkVYYTl4YUE3N0pqUVROMng5V2N6cE14dWxkdFllMjMyQWEvc1UxcVBvYzRX?=
 =?utf-8?B?Rm5pd3J2MnplMm0wdE5OMVRPZHBtc2ZCZmhqTjQyMmsrZ0dpRGJRNlVVZ2Rr?=
 =?utf-8?B?czVVZkh0L0U1VTFPVWpneEZ4eTNRcTBDVzZEbzlKS3dYMXhkeWp0ZFN4ZFRO?=
 =?utf-8?B?K09ncldhRnVVQ2hQdzdlcE5BQjdvdE1NdVM1V2xIaTNFMEZkb2ZhaGJCQlU5?=
 =?utf-8?B?ZGZDakxrSXZpYXNCYjBkc3lWOTJXRFBDeWNScjVPOXA2eThGZDM5bW5uMTEr?=
 =?utf-8?B?bnhaL25OY1I2bjRINjVyZFJNTXE2Mm9tSEFiWjF2Rm80OFJMM2o0R3NhV2Q5?=
 =?utf-8?B?ZUdkdTYvNGI3Mis5ekJrb1NvQy9QNVhuWTZOTElMdEFFb1VvbFZsdzQ2cmsx?=
 =?utf-8?B?amhRRldZcm5KVW80alFOOUlTTUgxYWRIVGtybFZKa2dUNnNIV1NvVUhsTGdu?=
 =?utf-8?B?cTdrc1lCWkpKQ3RyYzRkbUFLOXUrY1JZaUVjS3Z0OUlMOUpXUy9Rc3FyaXpu?=
 =?utf-8?B?TUxnSkNTL3JIOUsxdjlWcWlra0MzZE9ZSEdCUndVN3VyNUhmQVFKMkhHN1FE?=
 =?utf-8?B?dFY0d2FueUVVQUFTS3huTlhqSXRPWCs1UDlRQUgvcXFINDc4aGRzYUJIQ2tt?=
 =?utf-8?B?YStpUkJDeVFXUGpOVXY1Vm9KbUxURzVpV25ZZHkrYmxsdlhxcnBzdVdhUEUw?=
 =?utf-8?B?RTNTMU1ZK2Y3cnpaTlhtZDVHVml6bll2MWpmWVZqTTlXVXhrS01pbE9pU21s?=
 =?utf-8?B?bkFBNTNJeHdrTHM1dnRIZVZmUnBQYmh1cnRmL1BEbkN4U29nM2ZrQ1JUT2dL?=
 =?utf-8?B?d0FPYWhUZ2Rzd0hJbWNaL1VaTEliYmt1SXJ2REZva29YSkVlWWNEbVhyVXpG?=
 =?utf-8?B?bkhEVlp0TkV4c0U4WmxwOHJVd0RLcGZKb0hqbElQQ3ZMMGcvSE1pRjVMeHBX?=
 =?utf-8?B?eDRyVU16S0U0TGRxKzJLbksvd2pobEwrNFBkSTNpeXN4QnN2MUt2QytCWTVy?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 904d7e1f-b5b8-403c-f98b-08db6df841e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 23:28:43.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUtC6eLLwU8cO1ylhiPweNr2ACCeYAKWhqui8UmoE/oAb5jGgGRACn6CFMaY4gJRNRAZyHlI/hdu3GizWk+XBbeF1z4oiDJzRZs3L469heg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
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

Hi James,

On 5/25/2023 11:01 AM, James Morse wrote:
> 
> The second part of this series adds a domain_list_lock to protect writes to the
> domain list, and protects the domain list with RCU - or read_cpus_lock().

read_cpus_lock() -> cpus_read_lock()

> 
> Use of RCU is to allow lockless readers of the domain list, today resctrl only has
> one, rdt_bit_usage_show(). But to get MPAMs monitors working, its very likely

This may need an update to reflect changes since initial version (similar to the
relevant patch).

Reinette
