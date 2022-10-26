Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7744A60D9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiJZD20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiJZD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:26:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524575FFD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666754807; x=1698290807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vmmPrwnJBzGOxvvX++ifM4aqNtS0aBoqeyFfQ7j5//g=;
  b=ivi/pd8Aruanoxx7jC7GaWV7Lw39DKowJrae1lzsvt51GbrPPaWwGit8
   LCvsGn21r+95hqc7Ocigdq408whXQPrA8CPe+W8uhTU0kMM3aWCfGO+r/
   yH6uGwy5XNc3Tql56LA+W7yMjj197r9QpJWA1NLETSyzS9Bd6yiqWb1PW
   u2Vv0tcHiE4OhdCIuPpAAu30p9nAhCk25Qe6O3nCg1EajA1JMvlNf975W
   C7cB/rG6OHXJdyxZjpm4J660qKgBRh9vi6996DGQ/RUKa6ttV1hi+rVAe
   CXNPG6WIfAfvQZPjHMg1ZJ1jcI54HqBhui2XNta5+TcfanErRmMe1gfBL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="291154109"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="291154109"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 20:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="695205099"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="695205099"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2022 20:26:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 20:26:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 20:26:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 20:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0h4uijf1DMEFF5hcawmBsKZJ/O4OIJkUQ9DHyAPnSOLfatxNjU1IJawtEdnIFLPFNNnsxbol96L4llhqvl9bE3e+x0VN19yhbl4Ic9wCFpjzOD8N3SkDYZsl6H6OFaC64LahzK1ylIyekh+F85sQaiUzHriMW2xPY0Tdj7mwAzc18WAU8f/dDsrTmjW142lpmGE0KapXnOPblJoxecE2t8MGGZaulOccgkVNSX0MnluEi1qnHps+pptBwP8xLwAn4pzuDdaEK8lBTEDsxoanbQ5QBV9mgKmhT9ZYnW1dF7xPTdSZA+DAjpGX7sv4rQFJ6KmbxdGZvEopUXHN2JoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0or8ZgNpwfglMCmRn77Ul/ILo6i4sf1hADv3SI4UjE=;
 b=eUS+nmk0pOrzJzz3KCaX1Lk8GkllUaNQR5mKgwN+lH7XvubWi4+hbgwLwtZBM6W/qRSijS998KG6uwC5/q+hJeBqOJNzSLAQSAtuLjjXsboCmYoFzWxoI0EtZ/jEDG54e6q0vVxBgadlk8ptKFHbX2SgnwaZGop/o7zeaq2nOhiPzjrZB4/3JTvzO4rfkJ9uqk7+X07s62LVE+wj/Dx4A3cRxXJA6N3/sBy0rKIKJbFMMyfs5hxyA9ddmcIRDHAakhtE3/91JfHlh+Py8hGXJ/rdhg42XJsPsNOy009AF8GEXeHzHviWMexLBnS8snj4RrpG6zQrJJFWCMciaWjQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 03:26:43 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::187e:61a5:7c59:e765]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::187e:61a5:7c59:e765%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 03:26:42 +0000
Date:   Wed, 26 Oct 2022 11:32:27 +0800
From:   Fei Li <fei1.li@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dave.hansen@intel.com>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <Yu1.Wang@intel.com>, <conghui.chen@intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [PATCH] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Message-ID: <Y1iqS3FuCjPE8icm@louislifei-OptiPlex-7090>
References: <20221025084147.4118463-1-fei1.li@intel.com>
 <Y1fjMnX9UOVo2+K5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1fjMnX9UOVo2+K5@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To SJ1PR11MB6153.namprd11.prod.outlook.com
 (2603:10b6:a03:488::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6153:EE_|SA2PR11MB4826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8726656f-205c-49ee-bcdb-08dab701e707
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5eZUbJNsLseqwZrHNIer9WWpxKiIq9LJjQeW3sTAZXU7KwKjg8gdhXbWnFypmdakpy+Jf5BPcEDaSk+tPlDlT6IZFA0ocSklqS2N7yJyy2hDA/87G3eo+7LmEqXHevB5ufu8QzQL91erBuvHaQT/b/w7ks2+lIWeHSy5N4oCrxZvNjdLuwHslaGBjvTLodOp8JEYKOfLDaUwvwX9/RAQmtwZ51PWRcvnXMNN9Mwlcd7F7qGmx7bwsFHVzC8j+45CoD7opF4FWgZKuxWTot0/NxBiyt2xi95r/PgH6n0fsq/V0MQyn/fHMjkF7HMdLLuwtLsvBh772iXNI2D9o+W5iO5WqNTGZ2AxrQsFLQ65dGplnZiRG0EmGUYgtiD1J1tILDfq40KPXxWRc5VI9B4ipjwxjR3HZsGEoOQLeIFqwuYotoG27Zy+OVf+QL6q8uMv5GP/uNkHMoCW5eXctGVThX1eRgqJz8XUaVVoYlkzgoY7w2t3iqvnAoLteZc0IgbpI2WANueG0POTC3l6mt/LEh3AT1xSGtO1oaNyWoz4Px2KbPEiFfGAFkCIdyZze8iFgpFFU2cHV6ZqaKptI0YzhJQbsUckg0qW5fPetzQvHNjnuOqLrXvTYkx6wlHpkikMll7rD7B0UsfyCd4oVZR8l/veVOfAahcbtKN3zrVgD8JCCVUgiHtDNa83g7KVJoBNf1Wc24osUTCOMmCwktEdEl44NN319XoA824yQXEpcGfKom2P6N/Ru2E/vDPGNdO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(9686003)(66899015)(6486002)(6916009)(4744005)(5660300002)(8936002)(66946007)(66476007)(38100700002)(66556008)(6666004)(86362001)(8676002)(26005)(186003)(6512007)(82960400001)(478600001)(316002)(33716001)(4326008)(41300700001)(2906002)(53546011)(6506007)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+3G0LzlEklvmsFXIVO4soVLNu54sRHKWdltkrSsrcLimQnp6Vg0TfbNqBce?=
 =?us-ascii?Q?40Pq+s9/krUexIbYnlUIao0cs9Cr9t8MCPGhB5aRdbZ7r9cdj8j4jkYOdiuU?=
 =?us-ascii?Q?NQD4f9wXroRf6ihxdTWHlrn/Hcsu53q8N0WBLSTqhA438Mn8k5+mhTXCqZCB?=
 =?us-ascii?Q?urKUyF4k7e1C4I2svK8h8tHuTnU0R6klTXyT9PXto7tA7qlXbCTb8zHbF43g?=
 =?us-ascii?Q?qwIw0SplvmnYJ/yz1DTumTILijUeWEcl/z9GdnpdKm5FMolppghV88H7q/Sp?=
 =?us-ascii?Q?+MFyqFymlfeOlFB9c5CG16oDs2w+zxSmoyCw1oGJ/mpn9sqqWKFzd3+3cDAs?=
 =?us-ascii?Q?IwazR3QzyQBAnxkctRLsw8Sval1/JekgZo7RT2NuWK6O9ds+Yi0indjaA/T6?=
 =?us-ascii?Q?O78+jkdeSDir7R779wTkKwTmJsVfqe04EX9NnxhYspWEFJB41IAApAqF5SyM?=
 =?us-ascii?Q?g3vzR6jOf+k4xclKN8T92Ah7/7ciZJs5DHDLBPVWCi5pVzA9sHhSv/KmDMLg?=
 =?us-ascii?Q?Zq3k7Moh2JKtQDq/vBhhz4iXCrLeHgece5QuPUMaYnd4Qf2HLSO9G65F/cqc?=
 =?us-ascii?Q?f5SRdzd2IVkeTV76wVl5Yt8TR/8ZHI53GzDgVAdk0taWgbNp6WboxrjvuSvw?=
 =?us-ascii?Q?6X9ExHIalZ/frdF8kCrOpVEWYp//XTGxF6YBZx8MQ32sL5qwaWyJrnP4d4if?=
 =?us-ascii?Q?IXNmHtySIbqSkVvsxFFu8sJDvpgsI1SFCBcXRq03ko4NLE3UQ4wss04t51S1?=
 =?us-ascii?Q?MfDolHZXKoHBcAKnONXBvDtU413i+C+2NkH/otzf1R4yRIkQLN0wFfkqhzBA?=
 =?us-ascii?Q?CMgYlx6pGzk1zrIgY2cNeE5oagSirTrVVyQpQQtjW6dooqyMiNiVYUd7vYfI?=
 =?us-ascii?Q?x3tqUlATYU3OD/IQBFBKNQnFkZ5xO68+6KEhEAz+tPDVbYzszCNk9ZHgHE8W?=
 =?us-ascii?Q?WqGGgcCTCFNwrDJBX8QcZU5bkGtzfvydNPmJ6z+otNlhinyLnppQR7sSLTtt?=
 =?us-ascii?Q?OuEFvckggVlxzbBAPva1V4kz9Lt4ROUKZZKo0IQ8LlfQjt+o2TVNzPJ38W3k?=
 =?us-ascii?Q?FKmERJsObgh/LW3zAVG+RD8ffRNnX5bYOhsT7i65eIRMGvc1CdRqBvCjgEKW?=
 =?us-ascii?Q?AyLLDqYlxUFZYET8WuLESWvBhWapMWbBqKuyoWDiyYF/7xbO6cUiJJoHOf2E?=
 =?us-ascii?Q?cf297O1KEPL5kHfEEbHa/qqWruRP3LMDyLBKp2OK2NygiGyquzhyZz8yQKiZ?=
 =?us-ascii?Q?d6YSGBvbnCaaHIIytC6ba/Z9VWXO56OrF9wdc+U73h6o76jD6Lba3c99HQAR?=
 =?us-ascii?Q?6Ead8cmaxHNn1zf9wq5PkRXDsRq5vPIzmSbM/LRslRliLgfJ6ja70DRC9/Cl?=
 =?us-ascii?Q?y5s0aQ8KqVH9QRaTY0hFYC04GE5+dQopUb5W6CDW4q9m3gaNIn6WrmvFOJBI?=
 =?us-ascii?Q?wyp1mdqxvSSDAFxchAkmNpzCtRDwt652nlAMK9ofoDCuWC6pUtIXY2ndGcDC?=
 =?us-ascii?Q?1sL/TTgsgHWZTgfnpybTZ2Rq3j6OhERJ+oFfqYUphitAhd9llzllQUzSyBxe?=
 =?us-ascii?Q?WNHQADOqRwUiwn/+xLtSD8a7U9ImlswcnZMBabrz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8726656f-205c-49ee-bcdb-08dab701e707
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 03:26:42.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Cuf7ulnSnQOKKUEDhOEBbg5ED7XQann+7Q77XMXApwKm+QPabsudXdyfat2NqWByxav7FG7QqKVS0yhIe3fiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-25 at 15:22:58 +0200, Peter Zijlstra wrote:
> On Tue, Oct 25, 2022 at 04:41:47PM +0800, Fei Li wrote:
> > Avoiding recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
> > This patch also removes `inline` for acrn_get_tsc_khz() since
> > it doesn't make sense.
> 
Hi Peter

Thanks for your comments.

> Can we have a few words on how this is supposed to work at all?

If the TSC frequency is known from the acrn_get_tsc_khz(),
the TSC frequency does not need to be recalibrated.

We can avoid recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
> 
> Supposedly the HV is providing host rate through this ACRN CPUID leaf?
ACRN would provide the calibrated TSC frequency, not just the
host rate through this CPUID leaf.

> How does it deal with systems where TSC isn't known stable?
> 
