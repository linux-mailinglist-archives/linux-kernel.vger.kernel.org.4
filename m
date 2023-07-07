Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFAD74B8B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGGVir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGGVin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:38:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FC1FD9;
        Fri,  7 Jul 2023 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688765922; x=1720301922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dYoH9mCwePEI8pdcvyxl63Ziw1h0kHsklv1ETxU/BvI=;
  b=j89x94w3VHXtjHYugzQ+z6S4x8hiRx8LwunFonLA7/i9fq+27YIEL00z
   b8i5VXuhgm8n7k4oykda1UZqUA9/yr8md8J/Yu30a1ELvBPr3EerHdr5B
   LNPaMq/MGnfQJPR/PNBRRHaepvcPJVT4ioP28dU85NWDW/ttrr0MU5F8r
   tSL615P6eX0pIGleKDESP9axDIUpn9kjb3OlNvYXU7TQowsO8jGq2IqNv
   VwcDjJqDEjnqVamfC2FOrJmfRTedQ+YOynFxZlMUX43+nsVJsuM8IwIf4
   cu9jEb/poi1byxIJqFjat4mrQiz/4LK4PKkwJg7IsHvySZpTmFGrwdaUE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353836144"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353836144"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="966759547"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="966759547"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2023 14:38:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:38:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:38:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrW6r8D4TPfEerxb9fNZwFwWSSUEHq1XdBCVvrccmKCpetIM7YTAErj9xGvf89BTIr/4MPwL7rHxtuzTPsRPaVESxiXdgxnfGyYVrEbgPxAZpbjjhYBDH8KBuvTzn2Cyb/sjzHeDKyLkm4P26+JlJfKGpNOuLb89lKTmFuIYoM7CWM3T+JvThEDmgMd0Md4Eba447q+i7IuhAfB5PyOT4nlhycU5ydy70vGXHm34ggqy3Yt6qfCYi9GK4dYa0NXu/1EPZZYdxLHh6KkoonaNVcxgJdUpS/k2j0Gy60rLE/jBAaNoYvgT88F9IPuEiFGyQNOrvMZM0Ic3HYJRweBztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GKD658n8UkOB35qioBk++3usm2wRlrycEYmW4lbf7c=;
 b=cvQ+JCEaCALVTNbiYpiBds4NpYid6PryN7GQwvZfwxxYNCMzjfhBi4lMyLp4VRE0gmiF+kCM6NGP+g0GLezFR+tQ1nkxNO4cy4asVMxgo2Q2dSUUMl/oR3NOnl7bMyWxbrhCKWCIL0cMXph0ghh2ewXeuX22YXvI5wc8qVOhnlyJV61L3TTTYbpG9PJsEErtROpxLK3k4zocA1N0JcbDVjxrag9nHLSMBHW4kBdVxDSEsBcnLwQNyeveXvBshttlCwKYTDeC2NIT6oVC8IGFwhnCcpO9MK1blle5EEsgKvN1ptZuhLWiOHJXsZx1aHVZ9tjqwO2DNC+U6C5Byh2MvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 21:38:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:38:36 +0000
Message-ID: <19e87eb3-7dcf-d38e-474f-52a18b5e3bb1@intel.com>
Date:   Fri, 7 Jul 2023 14:38:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/8] x86/resctrl: Simplify rftype flag definitions
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564606414.527584.9565322327658331140.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564606414.527584.9565322327658331140.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a6c9f9-c0a7-4d38-ea82-08db7f32855b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz+V3QbdyJ55gJnYFdUMigyk8qWNP/dksVBhvy7zOfUylTiH1VTeznJZAF8YhaUgqKpyII+mLrTeXG8HlSgkJTVnss6RegL0ZzjPUM6jhWowgdqPMJYxsgPS9WfNUuedJKn105BZyqYVW7dqxbzLeiMnqa84g45+Oz6ZOQZMvata2B9hkoGedzcj0z0hgSdD4q3vx/70nzMxHDcC+tPDCA1vgc6fSd0w8Jl8nil/S+44ygKUdpztbNhvBkOgElqf9G2oRmN77OicllUggNa6S/DX580ZJJmmPpw//cHd56FeSGCFy6APrFgm9ue33rELycjacsGwgVOZufkkdY88Wf50oyPrMb0etqZFEhH6R9Z161kf5u17qSF/7/OnZi67LHra8hGbvYx7RlI7jfZ0d9CRQsX5hO0xeQ5ae+kDALCrhmLNAeijSKpPMhtutO0CB4PwuFB51J9hcH7ldfDhJsuYS2zC4IEJvD+4fiW2LRiUmTIjgXxCKYHPG90Gig3KotflNKbTtbgPk8Ypkg+2+TicqObyvdgon+LRcrkZj7yRJ70iD+SVOyBP028eNr8K7i2zPLlISojAbV+nkjLlBhzRsK0dmv+GP0BPdyoam+nm3a6Q7cJVk0ui0y5MPt++i5otv9buwMGiwVhHACCMaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(4326008)(6506007)(66556008)(66946007)(82960400001)(66476007)(478600001)(41300700001)(38100700002)(316002)(2616005)(186003)(44832011)(53546011)(26005)(6512007)(6486002)(7406005)(31686004)(5660300002)(2906002)(7416002)(4744005)(31696002)(86362001)(36756003)(8936002)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlXdWNCSW5FWi9EVi9EMWdGWjZPZmw5RWdoN2dCMmFON0dQNk83bC9yQ3RQ?=
 =?utf-8?B?SUluUjY5bDkza0VrOFpTWFBFSnljVmlBYm90RmhSR0NxYncwaUFXd1VFc01C?=
 =?utf-8?B?b2Jvc1dGSHFicDJsWXpRZU1GVkx1cDVhenZDbXNwREFVUWIreUhpZi9OdEw0?=
 =?utf-8?B?aFZPMldNZkYrNml0VDF5TmxYUXM0anRYK1pwSDJVWnVlN2JIYXY4eWJHQXA1?=
 =?utf-8?B?R09XV2krVmNxdW1iMWs5dGR4UHU5bkZyWVVOZ1ErZHB2TXROVW9aQ0pUV1dn?=
 =?utf-8?B?dHFaV3ZiTXc5bGNhYTBpVCtYNUdVdVRTdHIvZjRsbU05b3hhWHdFZU5adHh5?=
 =?utf-8?B?SFloL2VVRG82RWh4RktyWDZmbGJ4SVhVcCtlZGpsT0cxVUVxbHMzMDE3cmtJ?=
 =?utf-8?B?bGFITm9tWXJtTittdDV2TjhGWFErTy92dzdqUUdEbUFMR0tyTU0xYnZ1WDNi?=
 =?utf-8?B?KzdEdXpnNnZXSkQwWnRvZDBGQnJuaXBhcTZMdTNOTjk1R2pyaFhPR0pQV0pR?=
 =?utf-8?B?U0N1TlU3YktGMGZvMXhoRmVXdmpOdFN0ZTUzZDRadWZ0UjN2M3VRbitKRnRu?=
 =?utf-8?B?SWF0N1dBMEl5aDRYcWNvT1hqTkFVNkV2NENQRmVwQjdUeFdlTXNIVlZnWXh0?=
 =?utf-8?B?OUVGVzljbGhXbkptaWRHZ1pNSVk2a0RvRVRUQlZMUXVOcDIvQVc4WlVtNmRH?=
 =?utf-8?B?MmpIQngxRjgxV1VRajI2SWpWVU8zK1RKOE1VQ2ZrOHMxUkExckFtVDczOHBM?=
 =?utf-8?B?aUlKd09HOUl4cks2WTQza1J0eW80TERaMklSUTN4bjhPM3laMkY4TUsxVnpm?=
 =?utf-8?B?WCthaDQ1SGZHWlBTa1Q1czltVW13c0tLS1N2SEJ4OWcySGFrRDJ0Mlp3QUNF?=
 =?utf-8?B?Q1dvT1lacHRCaWdZcmZ1aWU0S05EVG9iSm1PMVRGcDdRb2ZTUmd6b09sRmVI?=
 =?utf-8?B?M3dtRUVYckphN2tHeHdEajY2UTZ1RXhzd2VhdWo5eGxqQnZ3UjJYWUR6cXNP?=
 =?utf-8?B?N2t4YUVPRVhOWmJTeUxROXQ5R3JMekltOUNaM2lFempTdzA0Q3pTNmdITnZj?=
 =?utf-8?B?SjFWZHpWZXFLK2FleDdib3UreTRGQkM1MGVOdGV5SzBVZ1JtaTF3b2Zkd25i?=
 =?utf-8?B?STZneTZmSFc0SkxhVVhtUERQaXpUNlk3K2doVkhqK0o5bHpCVk5QWk9rMnMy?=
 =?utf-8?B?ZjkyZWtCbWRXejE3SVVpZlZ6ZzkreDZjcTgrMjVQODNZaWpLR0JtdHEra0pR?=
 =?utf-8?B?MWEwS1BOY3M4VGlmVDBoSXpZVDlVU29VdDZ5dU9OaHNmNXNlY2dPOVNZMnhI?=
 =?utf-8?B?RFJuVWQveXlOUWxiSENwekF0eEh4M0dGQVcxcExOTHM5dGozWEJ4LzQxQndG?=
 =?utf-8?B?dlBrN09mMDhyeU1EaDU5eVVTMjExUnA2N0lwMmNFcHUwUThGSGRSUGpiTGFl?=
 =?utf-8?B?ZUtYRDc1d0JLUFN3QzVtSGhhUUh1VXgrRW1oTGtnbEhvQVhqeHVnSHo0RWFk?=
 =?utf-8?B?ckVpVXN2ZjJHUHpSZTJqL2FQdXF6V1d5QWtvcVlaZ01OZTdCaGhneEVYemxo?=
 =?utf-8?B?YTc5aWxWemIzeXhSWHJBeU9jSFlRS3JraVlTWDFEd08yNThwMkMrdGdqL0lp?=
 =?utf-8?B?RDdXU2xWK0F4cVpPcERzSGxHR1luUWFvOXhDSlozaUNnVWFNQW5vZU5XWmFj?=
 =?utf-8?B?MHpTbDhJeTJqbEoxUUxpKzk1cjhXYmFYR3p1aE05aTNhR1VITTRIRlJ1NzJh?=
 =?utf-8?B?VTA5aEpOV1JQT1F5dWJSR1FMQkNGVTVTamdlbW1yUDZRYnRaRjB5akxpSG5q?=
 =?utf-8?B?bE82NGloZ3djS2lpaUI2SVB0bzNHR0R1SEJhbjdYakxNRDRkUHh5ZjJLSDYr?=
 =?utf-8?B?OXJBNXlPNk1jODBMbWxvUnAreG1ra2tRbEoyaE1kUlhSejJCaXBQZURmUVBO?=
 =?utf-8?B?OWV1dWRYMmtSOEgwMFVQVzRLRWtPdnRHbE9EMEwwM0srYU45Y3RDNlZVS21x?=
 =?utf-8?B?YllEUGxFN2dac1VaY0thcjJGa0FkYmRWcHd1RUFKdDdQOWpXRnNtdjc0dE43?=
 =?utf-8?B?bDlTaGwvT3JRbGhpQmdkREZick9QdVQvSXFvcWNRVVYwZTljdFpidWNzai9x?=
 =?utf-8?B?NUtWQXJoM3V6RDB5US9URndqTTI4ZTNhaUF4ampGbzNVRmE3RUkyY0tHb2h5?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a6c9f9-c0a7-4d38-ea82-08db7f32855b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:38:36.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tf5+PGWnoQ7L92XOEOiwVf2k4ZUM11ws4wkWUqKOLoLtQebr9peUhR01CVG9dcjdisrBGaQlTZqBFpKYZggKy7NWCaHlWgeO6nNXtZuXR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2023 12:01 PM, Babu Moger wrote:
> The rftype flags are bitmaps used for adding files under resctrl
> filesystem. Some of these bitmaps have one extra level of indirection
> which is not necessary.
> 
> Make them all direct definition to be consistent and easier to read.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
