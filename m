Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852FD7322BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbjFOW1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbjFOW1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:27:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF49294A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686868012; x=1718404012;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0aiU72JKNPNiAkkg277jo5A0GX/qumX1es2zwyYV9KM=;
  b=WUYvCV4jyqMXihgJXF6p9739J2+xBuq79T98CIlvxozu57JO+qd/PBw7
   RjidM91FSRqlMcIO35zIOTkdUGTiZaWJge6GLVgvypZ3b+WzORw8TmfND
   ZzubjhA2XCYkmR+LR4QFRWXAFlyBgOn7sGbrMpTk1vjd1Qzx4PI7YhLrY
   UNBfAML1JEExIJ9f1F09bZEx0WKSNT+ShoiSskaLkb+GXUAaKhiUueOT0
   i1t5S9MpA6+2S+FaLtiUePl8QVqz0RqNvZc0JsIP8BoZaJJeslGKWBf8o
   jBAQ3QiMFNI6OIy3UF8w/YNMVodc5TSr5PRXm8wwjveDBYFHcdxA23j9c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359058039"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="359058039"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="959376054"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="959376054"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2023 15:26:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:26:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:26:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIIXIN40g8zbcrsdkDgMC1vK+9MYDZRqrWoZEUK74jFWOapYrUrO9ezeR9QlSqi98B0cSesI4Hj2l1BcHMfoWSuZzY+NX9ttC8J+GwIvKr2sEWQXoEzQ9SJooB1VcqzdLv2yHRN3xcgpKzMXlgtidXk4UMw2P9Ko0I+ysdq93SEKQlV/+UzaJ4+15waKbh3wDNNK910jhotkPamXz2gyKiQVuitAy2TIiqo3RsojwBRVJ9U0VE+qG6WcwEFdtBfDU5YxKhw7POYays9km4UweLyW3PEMD5wDJrz+T39LOByYPq/4MzkRjr0DFTnKMyiqGMEJPGJPkIP+W4fmC0oKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNh6cZYAoVkELFEH4bckVpZQ0LQBxPGExaIqk0eu2KQ=;
 b=l/SU0NmKhanq9kJamOwS4k+Bc4Kd4SN7fteuFxIP2wX9y3IQrv+2PU2c5GtTd9TTy61NJwyYhl/2U3lyu+9zj+8iwFPVKLzpqkzqRgNMgkqW7qclHjmyDNv+IypBiHxLq+iBW0HbTn5ZVw2daTByN9a3/ubpwFR89E36X8uJ6RCP3j1Kh6OEZK2y00gahZ0/WboFKHZ61VQvAI6enBKqHuzb6/9rEwjZTa+LHVd2fY/pUlmFmE0PaUgtmTjPDmDRrIlmX9lTg8laxZChmpJAx9ggVyDaZZlEFGnT3XoUY7vTIlxjlbRa1bN1MsYGKYYe07Um29fRopF3hgH3Ncemsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7036.namprd11.prod.outlook.com (2603:10b6:930:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 22:26:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:26:46 +0000
Message-ID: <09751242-365d-bf0a-a031-d636e34e08d0@intel.com>
Date:   Thu, 15 Jun 2023 15:26:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 24/24] x86/resctrl: Separate arch and fs resctrl locks
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
 <20230525180209.19497-25-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-25-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d535230-eb0a-42a2-7c76-08db6def9ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6jBJCBt/7lu1GeSpTIek2bNiUTdKT3YrADWp/sdnBayoZGYtnbi6rmB7WA4f2S17qRSnOmwQin9TDGJjvjrVbwv5z6EanEIV6Gfp9DYaeLF6HWxsuiMk3/N8KOvsg7xACcQ7uNSr2S7FTPzaHL7mni9n3sXQXT5Y276sIFkps3RGnXlOluePs5T+Irnm5+jtrU+gsJB8KhtT3FhbJBPG7pGWaW3+BMzKLetVABWVYedGtuspnC8NEqM4iqQROoQL5oDQAAPWWPbWG1UN2Q5jvmaGYDb9D4pDIf0ZbbW6GYbxmSPuXDo9pZWZViBCx2vTfngtJvWmP33cm0HGSh813byp33G645Xv6G+I5Su0Rp3Kva12fCbUAo5EgCOMT0egTDIWeYwHTCiIcXvwmGV98Yo9raR1dUH9s7Cs4ZqmdSd7Ba8cy9JG1mysroDSINass7iaksImpvYo66yhEnLRzN4nZwx7jIeOoQgiLHfsOGwK8bGHhd9Pv3SPQcEx5r4oj6yhBnlO66USMSe9GFk9OSNQ5Wdfo1pibq00Y2JVbNJNdI7qiwrQyg+bm5v9X53h360AwAkjEmeZZAPOjYAg6UZns0nMo3UAzgMNlHpUE/8g1ktI+IFiA7/1f1PRCQZaq2Xc7MXTDks0+jvsguU/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(44832011)(31696002)(4326008)(2906002)(86362001)(316002)(66476007)(66946007)(66556008)(41300700001)(7416002)(8936002)(31686004)(5660300002)(8676002)(66899021)(54906003)(38100700002)(478600001)(82960400001)(6666004)(6486002)(83380400001)(26005)(6506007)(6512007)(53546011)(186003)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNsYndseTJCRTMyVy9GRlVnenI3ZXE1NSs2R3lrNENQVFlYY3VlV0pPc0I0?=
 =?utf-8?B?cndFcEZ0YjZvTWl2UzFZZndCL0N6dmpLN3V0UUVlT1NIUmpNVVZSUnY5UTIr?=
 =?utf-8?B?UHBiL0lOcVZCcm1FNE1ZTDlzaHVLSnA2VmJNei9NcHgrN1pVRU0yQWlXbjJH?=
 =?utf-8?B?bW8yT2s0cmJ1ZzJQMTVFSE1xWi9mUWZ4VjNKUFRRdm1mSG92SWVNQm81b3VQ?=
 =?utf-8?B?SFNiQjB5MnVwZURBNGw2K3BYVUU4WllxcVYxOUNZbENMbDFLc3ZJUG5UVmxv?=
 =?utf-8?B?bXhWUlRKV3NXMU1yb2ZiZGY4V3ppcUJTWFdTZTRXNDlGOGFZd0lkM24xWlFy?=
 =?utf-8?B?YjNwSnZqYWpxYTFIUmFESzJlRHhwUTQwTnloMjZMVUticzQ2a2xKRXo3aWNU?=
 =?utf-8?B?akFSTWY2THBUMWYrM3p2aHhtckxLVUY1WjlzTFBrTTJJdlA0ZU5ZSXdHcGd0?=
 =?utf-8?B?Z3RrLzBtMUhIandhSlNzd0RsNXBsOUNTSnJJNmVWNURtRGFaUHl0RVJPWnU4?=
 =?utf-8?B?Tk5XYkgvQlFNcUJBa0RWN3UyYzQ1b1VHczVDcStNbXhoS0REM3FRbk9NNDdz?=
 =?utf-8?B?TkhxOTIxRU54cHBnZXhDVzlOUzcxNFNHL01uM3pYWllXczg3TmhZNWh2WkFF?=
 =?utf-8?B?WEpQZ3dTdlZXM3JTUUhDQVlVVmJpbHI2eWJBWi84K0NMZ2RRRFc3ZEJCQ2F5?=
 =?utf-8?B?OTBLTVIvSS9EaUExWHZKd3hqTWdTTHg5c3Q0dFhQYmVDbDNJeU1TS25XbGRV?=
 =?utf-8?B?Z1ZvZVk0TFFpN1JVdGUrQ1F4L2JhK0x6MXI2UHJwSTFzV01zMzMzcGdaV3ly?=
 =?utf-8?B?d3VTaXhNR0FhOGc5eDUvTjVpYmQ4bDRyZ05FUkR1MmVOOHYzZ1pRMG1nQ0I1?=
 =?utf-8?B?T2tnTENUZWVZK1Q4cHp5djJDWThqM1g2NUJHV3plQyszclVWR1hTdVVuWHcy?=
 =?utf-8?B?VlR1RDVDVGo5WEhySkV4b0QwTGpPVFQ1NU5XNldjalhlL3hXWU1XR2ZlbXY3?=
 =?utf-8?B?RTV1Q0Vpd1VoRUUrU0d0RmFCZXdjeFJDQkhoTllrY0QvUjR5WkxpVFFiSkU0?=
 =?utf-8?B?dm9rQ0lUbDgycWRjbmxrd2xySkFGUjYyYzJPc2hBdVhZZWUxNWVXZVdtOGZw?=
 =?utf-8?B?cHJxOEhIK3N2NVAwV1dYenFSY2c2Q1NNUmV6dW9hRDFYb2dySzJDVXpFS3Nt?=
 =?utf-8?B?UFlQS3VxRzg4WkVwYUVWNUsxVEhQTlJFeE5YVzBqeGYrRmY1VWJ5NnZsVG9i?=
 =?utf-8?B?UzFYTWtDTDFFWjZUMmtSWlRlSXJOOWF0TXl0Q2VLR0FVRU56VnVTWkQweG5Z?=
 =?utf-8?B?Z3I1WXV1MlNuU2FDak16dGJhRG1xVFZnRWxWUmpkdmhGMmtlbUJZVjJQbWRV?=
 =?utf-8?B?WERMaXZYdXFUQWk1QVhWWW5ob09BYkpvSFVQMlg0VEp3UDg5dGtZS2hzQ01K?=
 =?utf-8?B?RDhvK3hlRElkN0dvaGRTQ2dnSTg5WEY2VDlqZ2FrL1hTMGZuSmtlMk5qMEZK?=
 =?utf-8?B?WDJrZSt3ZjMrYTlkbjNrLzA3bzZxR01ucTAvTVdjL3VkMmxBZXVlM1cwR1BV?=
 =?utf-8?B?Q0JOSTFwRzJJSlFPcmVLNThpK0Q2bThFQ2VQUU1UZlVVVWNORHZ4VDV2bUhC?=
 =?utf-8?B?S24wK09md2tKcm04dmxiQ2s3NVpHR1BMVE43d0oxRGR1cHhNZnJya3RVSlo4?=
 =?utf-8?B?WHNEUVZkT1dIZUw2RlZSSVpMNUVSY05UbWhBWE9kUVU5a3oyV1JHci9xbTNY?=
 =?utf-8?B?TGwrVHRwZnJEQTRWc3JTWUgwcU1penlOVkJtODNXYUVBRlU5Qk1HOXk0MTg5?=
 =?utf-8?B?SFkzczJJcDR4UmlvOEhib0dIRVp2MVpveWRQb0o2L3FSMXBoZkpqVGZRZU5T?=
 =?utf-8?B?ejRLTk1nQ2FKRG0xcndLalJxYk9iQzgwaDlOYlg5N3plL3BIS3l2U3VyZ3pC?=
 =?utf-8?B?YVo3MmlRcjlySk1ldFNKTHFwY1VPM21nWXlYUFpqM3NzYitiNmIrd1JOakxR?=
 =?utf-8?B?YjdGV0taQ1h2K2J2M0x6M3BCQi9sSlIybXhGOFRyQUVRL1dsYjN1OHBHWWZG?=
 =?utf-8?B?UkV0N3FVNjZVSmszL08vSHp1NkU3U0ttRm1uL1IwbHNOZFlETytwUDJGamhr?=
 =?utf-8?B?MUVqbm1ZeTYybVFraG1IOXZPR3B1OXBra0l1S0Z4UFQyQ0tsQ3VuSm4vWnRr?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d535230-eb0a-42a2-7c76-08db6def9ab1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:26:46.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZdhSB7jymqU1QIA0EglxEdcYHLpE5mwTNEr8JdPsBQDux6mjToxJkTCaDEeIsirkL1k2+VOAOieN8TltNeGwGcc/IrsYLV+O1NhSr+0LtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7036
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

On 5/25/2023 11:02 AM, James Morse wrote:
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
> 
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against cpu hotplug. The cpu hotplug
> code already has a mechanism to do this using cpus_read_lock().
> 
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.
> 
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
> 
> Most of the filesystem code's domain list walkers are currently
> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
> The exceptions are rdt_bit_usage_show() and the mon_config helpers
> which take the lock directly.
> 
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() can

This does not sound right to me. The domain list belongs to resctrl,
the filesystem, having an architecture specific lock protect it does
not seem like the right thing to do. Could this instead be a resctrl
owned lock that is hidden behind helpers for the architecture
code to add domains?

Reinette
