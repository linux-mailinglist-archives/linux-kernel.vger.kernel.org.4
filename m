Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59E86DE8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDLBRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDLBRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:17:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7A3A82;
        Tue, 11 Apr 2023 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681262258; x=1712798258;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=euAxeLrYsdxmdjhsbV6D6WE+80jaIPSbL/mptpL6V14=;
  b=Nt5VoJezLrlBIBaZy0Mxqgj1ahqv7jo9rfuKyP+Vd0Z7XIw/HCQ1pt0Z
   L0oFduo+0oCOf49BTHiK7cC6RsHq7Z8pxgvwunWG54VIFas9BTzr8bwkJ
   HsxUYsqI+/w1tr1RY9K0WX5DbqQWPm3xnEOL/CWzBBraVX3wjhW2JwOlM
   PdfCVq3mCxPtD8Ne+NKW1MkgK+TDaxHtR9o/rBFHdyOpHrRkWHElmYAMP
   bqqu7uCSq06CFy8EGjuu1mLd9IY4w6fgVjts7bfcZQemeUs3Yw/TDVAoi
   rHxhXTiYwqo9pwluq/uWE8Fk4Nx+O0wvTU76UmrAVtUSvwOgE07Cxq11F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="324134625"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="324134625"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="1018568543"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018568543"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2023 18:17:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:17:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 18:17:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 11 Apr 2023 18:17:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YroTxdutmTtK45ysxEAI43INNrwoyEHV3oQlVb85CaraD6pcQwAQkcXUZi5rqtwIoos8usJSHhTJaOexHOk3eoEvidwh6cPJmH/inaoR8W/UjIabOCacni5RETUZbp+2K+AYFsoJRnVydRi8P+Bs+zuRL6iIF6muhcOVhMPJam2yVIdRth7H0jsIKSv+dPBEf2Ah25GDHUrzBAcEbPbu9r5sKgeF1rxu3xs1ZntJplZZ+Gxgi142OFXb5+NftJ6N22AM5IxIA4OvochvLLuBYQwu0HFdbsu0mjSURFTwn6T7ALQ+XmA1FXfocvG7VFICUFy6dnrVjwrmSAbxWrf03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXm7W5tqYlsHEz+ME0L1lYCc6AuRGIVDuUTZMVhg3AA=;
 b=OUXEsDMpgsjLO1S6jL1pI1BTg3rkJjXrWig5MKBNSegYGTUweUWpcSJHBbYygeL9KzHV81RcFG3bGx41E3UToEgF7QUD/SWLdeGQlCdLCsZnxEa6k/lz7/WwTVOZK5TpogjqzjxzQlNnntR/M3g2Y/dSkK4OoyOK4s9kvgcyTV7sSr91YWe0zrkch93qvd4rlNfeN+w/3BPjyXLBPaM072CR1yHF1k4PbmJ4QRHwEHuzQzmWd+LpJANdsJ3IjLl3UNXWmnz1Cq5pJwS3mzE8GM889kgiC8QUbgeS8mETj8fC0Npe+1jtZTAb/od3Q9BRs0x4Q+ZI0/m/S9wIXD3AEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by PH7PR11MB6835.namprd11.prod.outlook.com (2603:10b6:510:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 01:17:36 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:17:36 +0000
Date:   Wed, 12 Apr 2023 09:17:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        "Pavankumar Kondeti" <quic_pkondeti@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yifan Li <yifan2.li@intel.com>
Subject: Re: [PATCH v2 2/2] PM: hibernate: Do not get block device
 exclusively in test_resume mode
Message-ID: <ZDYGpBRENQ6NDo0G@chenyu5-mobl1>
References: <cover.1681186310.git.yu.c.chen@intel.com>
 <8f917ae09c7a09d1841824908107d6c79a6cd090.1681186310.git.yu.c.chen@intel.com>
 <CAJZ5v0gGbREHrwSg48JfZX9tgNUr0GeYyejGfd80VjR8Wd9Ffw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gGbREHrwSg48JfZX9tgNUr0GeYyejGfd80VjR8Wd9Ffw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6211:EE_|PH7PR11MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 791458e1-a7ec-4c21-4f42-08db3af3b2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyaWglU9/fBLSUyVL07bH7dZolmoGsr1Cepbhf5dpMtEcC90yo2d4FPZf/okD+4wu+n0KiIAPOPzLEVCBzU9QaUnvcjBQ1NCxOHWI9ph425mJwstzr+zaXi7w/f3ev2td+Q83S87WFPx8XDEjSpQ0a9q8BQHj00FPcIbEU6nXacNDJhtVitoAUjrG4Sr/2GMhq/RXSFDeXWf8rRAopuBUSa9LmQ919gjH4kQkmAiJcEKK8M3end8a/+rkQEemrTDVQP0yu3LOySbhUAfr9QfbHU8iY71yOJah0OhGhSoc0Yd7j0MvdGrwISTs6iVJjwVYUWlSEj3xc8FHycWObq1KNaAqATnSbzEAFfGdkzDrWDd0iij9k+8s6DoVpqh+4rNOPpJ9XemqtXM4nYRCzf+a006HdAhwSmjX/eYyBPK148QXXfo1gK7YyROW8lJEpZy0d3iqoKJJTycUfOPQbcJ4/lUefRzbVmgEBP7t2J6OJ0rEX6yIg673hj6IxsFYhkb1f89omZX0bzEwnfbo4cOebk9iXPiq1Alm8a0K6TDfK67E7IM6/hdSk3/ll+7bqUK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(33716001)(2906002)(86362001)(9686003)(6486002)(6666004)(107886003)(53546011)(186003)(83380400001)(6512007)(6506007)(26005)(478600001)(66556008)(6916009)(4326008)(66476007)(66946007)(38100700002)(316002)(41300700001)(8676002)(8936002)(82960400001)(54906003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hkYWNYVEZHUUZ1VHMxakw4aUVXVVErelN2aUFmVmtkMVV3THdUV1ZVTFhJ?=
 =?utf-8?B?WVBOZ2VRNFpsdCtKOEF2ZE4vUzFoMGpJc2NKbGxNOTlsTEdZaSsrSGFCSytp?=
 =?utf-8?B?a3c2alkrNXE0QXR0bEdIQXpIdmt2aDBBMFFJUHVtQlJ3clZiSE1jZjBEQzc3?=
 =?utf-8?B?NTU3WkNvUXJKS3UyUzFSWEhyS1lyRk9EZXBTNkFaR2kvdU8xaXNoTkVjTUQ5?=
 =?utf-8?B?QWdENEdkSmcwaGtWNUIvdlB1cjRrR0dNd3RaaXFaQTI1cjNlZUhoMzc3ZEZG?=
 =?utf-8?B?WSsrMU0wc0dMVGloTjdtTVRWbEVQZVExcWROUWtlUHp6cWxMd1NVZHJrVE0w?=
 =?utf-8?B?Y1h5Tkg0WXRJNHdPRjBvR245TGZnQk9JRjd6ODVNTUhSd1ZjeTNST3M0SEdy?=
 =?utf-8?B?SmNEYlk4Q25xZlo1S1d4cmJEbDdNRUlZeGd0QkFvZjRRTkFlNjI0eDQzVERF?=
 =?utf-8?B?ODZsT0RVeTJkbFl5bUtPMlg4RTRzMVZWVElGU1hGaDRzelVZdVBDSGZidndk?=
 =?utf-8?B?eGZUOGhMUmNBMnhROEd4eVpha3IrbC9kNjZjbThXV3doOGM3YlVzblRia25u?=
 =?utf-8?B?NjFDdzdCK0daWnY5eDBSZDYyYmVZdVA3ZzNwUXltUGtISTNOYjdNMWpyR1hL?=
 =?utf-8?B?ZWp2aENZMkZVb0oreFhvcVpnMERld2ZoMXZ3ZHhaK3lNdUcwOFQxejA5UmFN?=
 =?utf-8?B?dmVqTTZlbkNINEYwSFZEV2lVT3V4RVAvUkFiVjlSWEhUZFZGWVZVN2lpUi9v?=
 =?utf-8?B?TGhMUDNRTXcrcTl2VWRUcHkvRWFYWDRKSWZBUmJxRjlNQmQzSHZ1UlROWGZn?=
 =?utf-8?B?d1hjSjJEQ3NpVEdvWmpIKzg3WnNEek4rZkM2cUtIN2cvQ0hQNklzVktuaHRZ?=
 =?utf-8?B?VWZ5Uk1WN1YyQ3N0K0Uxbi9uWUliS3lndzEwRStBWi90d0pCdG5raXdXOEpl?=
 =?utf-8?B?cC9TOTg0YS9hVHFqZkJwc1Byd0ZFcjJKTmtTT3hOTWR6WkxoL1J4eDAycEMr?=
 =?utf-8?B?dm5MdSs2ZDVuNEJtTnErcFlUYjQ4bzQxYVU1MGI0OTk5Rit5Yk1ESjNXNjdN?=
 =?utf-8?B?aEtuZ3g5aCtHMnpEdnFrd0pBV2ZtUVZNR29KT3orZDVpWTVtOWN1b1FDVTJF?=
 =?utf-8?B?ZXhTOXFOMUZMV1Q2b1czaFI5MmZkSnJnZngwOHY2QkpoRUZ4azhPcFFERUVH?=
 =?utf-8?B?MUFqTlJjQzRZV2ZUK25xaDVsS01qVys5TkJ6ZTI1RmREdGVTNXkvY1FkVFFi?=
 =?utf-8?B?QVRKMHZlbEFLMVMrWUhhS3NscjNrRXk2SERYQlQxdHd3Z0F6cU9SMzlsTDlx?=
 =?utf-8?B?S0ZFWUVia3ZsdE1XRnEvUzBSbThBUS9EVG42M2pmUEdyaE95a000Um5vN21r?=
 =?utf-8?B?V0VlVExBTkprdnpIWW4wT2xMUEp0bWM0MGE3SVViclFZODNyV1hjcnY0WjlJ?=
 =?utf-8?B?SDdkMFFLTUhMZFpGd0ZqbENldVBpSVNaRS9CaU9oU1pyaks0cld0UHlPUDBU?=
 =?utf-8?B?Q0t2M3c1V2R0eHNkL05CNkx6c2tTVlRZTElOV1BRUlNXcUV0azR4YkxqZ2RW?=
 =?utf-8?B?OFVHVVBBeE5Gc2JZbG1VeU9RaW1pL3FrSkhyZm9sZWVxS0pHbEVzOG5QNjlu?=
 =?utf-8?B?M3RRdFYrVEJMVlg4RVhlcTgyWGZwRm1GTUJsTFRFSFQ4YnJEMThhY1NnZGtC?=
 =?utf-8?B?ZElwbm43ZmNSbjJmbGpqQlI1MUJraURSODZ5WDNJRnRFMGZ6eWNlTnVMZGJm?=
 =?utf-8?B?RzFURmR4aFNzL3BQWWRpZEFNL3VHaEZlSnNETzVCL0dSb2VibStlVWJMb29G?=
 =?utf-8?B?RCtobWZuVDhmK2l0WklGc2NpNnBVS3RxbjY5QTNKUy93SjJWZ3JZUTNORHlr?=
 =?utf-8?B?Z3pvVmRCbTBGUVFRRkp5Nk9CVDFzSWpjL2NFN1VSZng4MHI0Nys4VU9DQ0ph?=
 =?utf-8?B?eE9FdllJZ0p6OFUveEErMXhPVE8vdkZrY1Z3eWZhdWhmUVZmSGkvZnN6MmlN?=
 =?utf-8?B?MS9TOHZvWUNHNXVxZE5vV3pnWmZmeC8yWlc4OHFZZ0JRR0xyMkl6SWpUWXUr?=
 =?utf-8?B?U3M5eEFyci96blFsbFV4NDdHUEFCeEs0SUV1OEVFVUVhbGRtNmxxV3lJeDZS?=
 =?utf-8?Q?NH3y0efjrhX7GqS/ElVcaynC3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 791458e1-a7ec-4c21-4f42-08db3af3b2d1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:17:35.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmkY4diKT3qJH+RfcegLeQ7OwREVoKUwucFa0lVxcUUmNRmJ2VeQ6aBydXFSl0a1NsLNCQD9bep3fcpactolWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6835
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 at 18:21:36 +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 11, 2023 at 6:23 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > The system refused to do a test_resume because it found that the
> > swap device has already been taken by someone else. Specificly,
> 
> "Specifically" I suppose.
>
Yes, will fix it. 
> > the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> > do this check.
> >
> > Steps to reproduce:
> >  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
> >        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
> >  mkswap /swapfile
> >  swapon /swapfile
> >  swap-offset /swapfile
> >  echo 34816 > /sys/power/resume_offset
> >  echo test_resume > /sys/power/disk
> >  echo disk > /sys/power/state
> >
> >  PM: Using 3 thread(s) for compression
> >  PM: Compressing and saving image data (293150 pages)...
> >  PM: Image saving progress:   0%
> >  PM: Image saving progress:  10%
> >  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >  ata1.00: configured for UDMA/100
> >  ata2: SATA link down (SStatus 0 SControl 300)
> >  ata5: SATA link down (SStatus 0 SControl 300)
> >  ata6: SATA link down (SStatus 0 SControl 300)
> >  ata3: SATA link down (SStatus 0 SControl 300)
> >  ata4: SATA link down (SStatus 0 SControl 300)
> >  PM: Image saving progress:  20%
> >  PM: Image saving progress:  30%
> >  PM: Image saving progress:  40%
> >  PM: Image saving progress:  50%
> >  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
> >  PM: Image saving progress:  60%
> >  PM: Image saving progress:  70%
> >  PM: Image saving progress:  80%
> >  PM: Image saving progress:  90%
> >  PM: Image saving done
> >  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
> >  PM: S|
> >  PM: hibernation: Basic memory bitmaps freed
> >  PM: Image not found (code -16)
> >
> > This is because when using the swapfile as the hibernation storage,
> > the block device where the swapfile is located has already been mounted
> > by the OS distribution(usually been mounted as the rootfs). This is not
> 
> "usually mounted"
> 
OK, will fix it. 
> > an issue for normal hibernation, because software_resume()->swsusp_check()
> > happens before the block device(rootfs) mount. But it is a problem for the
> > test_resume mode. Because when test_resume happens, the block device has
> > been mounted already.
> >
> > Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> > problem because in test_resume stage, the processes have already been
> > frozen, and the race condition described in
> > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > is unlikely to happen.
> >
> > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > Reported-by: Yifan Li <yifan2.li@intel.com>
> > Suggested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/power/hibernate.c | 5 +++--
> >  kernel/power/swap.c      | 5 +++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index aa551b093c3f..defc2257b052 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -688,18 +688,19 @@ static int load_image_and_restore(void)
> >  {
> >         int error;
> >         unsigned int flags;
> > +       fmode_t mode = snapshot_test ? FMODE_READ : (FMODE_READ | FMODE_EXCL);
> 
> fmode_t mode = FMODE_READ;
> 
> if (snapshot_test)
>         mode |= FMODE_EXCL;
> 
> pretty please, and analogously below.
>
OK, will fix it in next version.

thanks,
Chenyu
