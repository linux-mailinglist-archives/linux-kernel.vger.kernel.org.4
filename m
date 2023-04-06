Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB96D8DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjDFCuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjDFCuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:50:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164593C7;
        Wed,  5 Apr 2023 19:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680749383; x=1712285383;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TEP0UTp7xAixIVD+kFsxpJaRg02rCVOV+ZOicBaZX7g=;
  b=oC1P0b2FhQjByIRokjCqU7SVeclJOGoRoayPQkhKaQf8AOphkFBX8zgE
   0hV6sKd8cHpPTVsuI275ybdZrD1t1fMspo4sxO7rHO5YXoufPbgMeNBoO
   kNtIXCZ1itrKc9QdjayoPHH22SRv7KO+u3UUwV0RPmd+ucZqdzoo+egOL
   tnpJDcKlctvN+9w1Px8DyaxYwjuQMkF1sS9yY6im0yCHd+yahp2ABlDTw
   FQdx20hLRMZ8IkoI+181zKZ/cmrnxUYxsDXTzTCpaUOsQU1YBKqp/z6EV
   /+LmbydpW6MEMv+twcYkNN2gekIKBLo218GE8NEhh0pHsyOSqVOEGeh3b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="331232721"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="331232721"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 19:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="637108387"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="637108387"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2023 19:49:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 19:49:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 19:49:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 19:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEd7tnBij/PaudOZbwiTIaHIbWtAYZHiMyS6CUbT3Okck77759O8u2k0iSc0WV4CAP8v5orPu7C+M4YHmwtZVOevHcCyMg6QSiAZOehwcfvgrdo3Oqog5j9LZ958P76b4kYGtFTCJPetyufu7ghYIdl0/bfQeswN4H/OsThfqt5JK/igPG1RB9CJwDtk4Q5czmsgzXNwSmjYk2CUmc5Sc0/skiNfahMFeZrMDvVNUVV8tKPFh27qhElYk8dmpAcQblkSPwVtIVvB4K3vcjA1q6+oz8nBonEgp8zaN0QNbjNRADbgG43qoMgWG3a+buuypW8gHD1Qtdhm2wieLIVAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3apUANPUUkjJotFCngm0Cm5AquRpysdHme19uEqhFE=;
 b=Dg31uy8M8VaWzIyV7fGefYf8/qsQ4WU1PWTLZNeYWA3R1IcZ5kz4Kann5CYvl11JNsv1HdPosrPSiLjVV9CcDdUvU6ZNly/lhQI/O6+n0gPBi3MmFZtyzsW5LCRjbZaf4DX4SPfDZE8qyg0uOQwRYSiy2DslEXTh+IvS2hZi3QaQwez0rFzUCQsg56eAjI1uU7UESN1NFYUDJtRxoN2a8m++oSmgMWFaOqH5SmqRHpEgVVkmlnxTba1q9f4GUW4JeuVe8zHRzfBPTjLfOdAS9gE9jp0To0QMi/GGboaQ2BvCmjeCfnlkcmeX/iZc9tL2TU10utdEI0V+DwBqMld/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS0PR11MB8183.namprd11.prod.outlook.com (2603:10b6:8:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Thu, 6 Apr
 2023 02:49:34 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 02:49:34 +0000
Date:   Thu, 6 Apr 2023 10:49:22 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yifan Li <yifan2.li@intel.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Message-ID: <ZC4zMv1SCiUMbcqs@chenyu5-mobl1>
References: <20230401165540.322665-1-yu.c.chen@intel.com>
 <CAJZ5v0j704JoCPTrDO1jTHwP1+8NVdLk7hym5036uFcfo7YHXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j704JoCPTrDO1jTHwP1+8NVdLk7hym5036uFcfo7YHXQ@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS0PR11MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cc490e-417d-4b86-b84d-08db36498d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhgZmTGS5dEK3jMcdfFERxmPkIEIeG6E9SjNj+nVy5LI7Vkprz22/9gBMav5DVCiqFJ4aslO1Wvxu8NflXSThPXFTKMyKM/yT5SfQ28f5tjzDsyTAqf+g4lrUPGviBEmkeTuvzkUteoVxpjtViyOfQ+m2ZrebKtjv2JMiWWh29XNMQe86oPeQTQwQEvD37313bNvzXdrwuyOT/xbzjthBVUDtDpr3As3z9tHqHQi7KlxVUDUwr01GO7JeUiPh1EHQ2u+tID/ZyAXZibOnYhCcVwP0pbUDfxftuw8MjJWQK3kPVcMgrMIJWZqnNh2qkgHX7exHeO8ZA7GE86fB/U0aSU6JJvwkudKsTCt2adFBZi5qBmg+oEGgDJGBmjbni1p/+EWGcheYbZoWDyl/8e6JFrB83gq8aa+5XncqZoYyBaIR2HzpUUVaTfFKrpVJ86GDgvUV18ZDSnDY7V1HBfQgSSFU4uBHHo1QL6G5yIbG353sCoaMDbgv9r4sTTyUhdXOaMt9gf0tg/MxCQ6MesgKx0uVuyKDhWT01h9EZvlccw6xD7wZVSITaTxKwEErKeJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(33716001)(82960400001)(38100700002)(86362001)(6666004)(6486002)(66556008)(5660300002)(2906002)(6506007)(26005)(6512007)(53546011)(186003)(9686003)(4326008)(8676002)(6916009)(66946007)(66476007)(478600001)(316002)(54906003)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFZanNHT2pNSmxrRGcvS21OZEpwU2tNWjNacFNxcExkTnhrTUxGbGJ4K2lz?=
 =?utf-8?B?Zlo4cDFqNVMyK25PRzF4TmFpQTIrdW5GTjBTaFNJdGFwd0swWnhGc3ZFcTNy?=
 =?utf-8?B?NGNDeW9TU1JCMmxOKzhwdDNlUy85OVJqSFBYNll4TkxFTUo1T3VwbTdzQ1c3?=
 =?utf-8?B?R1ZOT1h6WGRTd0xMR0NVaU5EdEZzQWY0UHJucFg2WWorbk1URjRLaDArQUhR?=
 =?utf-8?B?dWxJTU1vWUM4RjZzVmVMQm5vem8xTFJhVzBlQVZPVW9RcTU0V1YyNS9iOVFo?=
 =?utf-8?B?eVFEdHd6WnpEWHFYTEpoWU9Ma1NhaDBpcFNYdWFtb2g0R1JmZmpkK2cyOVl5?=
 =?utf-8?B?Vi9JcC9JN2lwQzBzNVBZUGovbEZtVG5CYXR2U0M0WVFyeWladzN4UjU2RzRz?=
 =?utf-8?B?bVR4TFJWZ2FWZVhvcUNtRk95RG5BZUtWK2xoRFRTVnlGU3pXVEwwM1doYjBZ?=
 =?utf-8?B?ODJaeDBlSTFhZEtodjVuNVIxTGFMS3F3dXhHY1JsY29KZ0RFSnFJQ1VXcnpG?=
 =?utf-8?B?ekR3VjhPOFN1OXlPNTF3eVJpT056WUZPT2p4b0JqVG4zMXhKaWE3alJwUlZM?=
 =?utf-8?B?dVN1SUcyN0w1TEdxQ0VtRGhBbGZEUUtJSnAvV3hiSC9YRFRKa0ZmazdsUnAv?=
 =?utf-8?B?NVVValN6TGQ3azNKQWVTMWZiV2NyMExhamgxR3FlQ200emYrT3lsNGJmc3RC?=
 =?utf-8?B?NXNXTmpVRm9wQWhVNFU2bVBiZTJjVlNGL2xKdGMwV00xTjRYN1NJOURtYk5s?=
 =?utf-8?B?K3g1ZDkzUmtxMnNoYXZLS2RJNURsVlJuSTNLcEFuZitZKzN3S2FFN1ZETThh?=
 =?utf-8?B?YmRDVnJ3T29jU0ZPSVFIVGRqZ3pRWWhpZlVNWUx3UHQ2aTcvZWltdlh5eWtV?=
 =?utf-8?B?WlJmQnU2WDdHWE84TytJcTlHTFRvNGxCQkJCSWdQVGI0THNISHVtTUlhSlZo?=
 =?utf-8?B?V3FHdGNkSWoxUFRpOERaUmxOclZBM29YckNRNU9Dbm40UmtkcXpaeFBEZE4w?=
 =?utf-8?B?QlY1NHAveHppRGZTSE04OC9KQ3c1QkFxdzc1YjBXMTFkR01tVTBoU1dTaWZ6?=
 =?utf-8?B?VTZhaTlZYitFRk9mWEkrc0ErN29MRm5yRTl0cm1jMjhpWTV0c0tZSWlaaUhU?=
 =?utf-8?B?aTJZMnRaQUFod3ZRaWNXRWpKcWI5eGVtaGJxc1ZCT3ZVTWVzTERxRnRDbG1p?=
 =?utf-8?B?UUV5eWRrNnNPOGtISzZMa2VCeTFSYmtucWlFZDM5V3h1OHFYVmlZYlVCNjBu?=
 =?utf-8?B?Z1dWNThyeTJwWFVVSHhXVWFVREticDlZZTA5WjdwMWxWWDBBQVAwRkViNzZq?=
 =?utf-8?B?RGRKUThFZWxnNlZ2bDJRK2J4VXhBRkp0SkZzL3orNXZyb1RmWERQekF0UTVC?=
 =?utf-8?B?MzFNUHRoQkllMi8yUzN1aGlmalNTMlIySWdQMDFDbG1rdDRlUlo5dEY1RjRY?=
 =?utf-8?B?cWk1Uk0zV1J2YlZRUmNyMjA2bHMxQjZxblVmYU5sMWZNbGw3YTJkTjM1YUhQ?=
 =?utf-8?B?STdVZXJXWWo1Qkh2MnlFWHhrU2tKTCtGOUlQMmpGTE5CYUR3WnlBSHhrZi9X?=
 =?utf-8?B?MTZ6cVpKcGdFeThSRkpMNDVJNFd1OFpzM0oydzdTeVIrT1VOeHRpcTFXdTJO?=
 =?utf-8?B?elRCMnlaQWgyanQvbzM1WUhqOGdkNDBtdEJWdGZSbmJxTFgvWlFEb0NpWVdl?=
 =?utf-8?B?d0V4VGxCK3JsSTR4aGRSZEpRY2hoRksrSEViSlBwNlRBMks3NGs0QWliSEpY?=
 =?utf-8?B?Y2dRa0RnMGtKdXowb2VaV1R1b1VaR1A4SEZlKy9LRE5uRmhteGpQdlZzY0hh?=
 =?utf-8?B?MmlEUVQ0L1ljdkk4Z2szcy8zbnp5cWlQL0xnQzBYSTdvM1pZQkpMc282T0xz?=
 =?utf-8?B?em5JeHlHQjM1cEQxa0VselVMREt0MGFSaXpMR2Rxd1JOWXZRNnI5Q01Ra2tk?=
 =?utf-8?B?OVQ4Rm1iUHMzSmQyNWgrZE1EOHJkYkdpU3dtQWFzazlIajhDcnNJMjE4ai9j?=
 =?utf-8?B?RVBTYWJUMVpEbGNjTVRrQzFEUTd1N0I0WG01a1E2SVA2MlNPSG91cE5vNTVZ?=
 =?utf-8?B?M3owSE16RHdtMHRuT1p6UThhY1paNyt5SFEwR2p3bUxnVUErUmdkREVuNU05?=
 =?utf-8?Q?TTnFbSPt8EPDAOBsfbWecVndu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cc490e-417d-4b86-b84d-08db36498d96
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 02:49:34.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYFR3RwqVBQPFU8HApfP8aKkYwYoMbBZpg+mpCYcE5L1wG/XCZxBTtrQL76TShrqghRk2V5zmnj212edV0cPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,
On 2023-04-05 at 20:37:32 +0200, Rafael J. Wysocki wrote:
> On Sat, Apr 1, 2023 at 10:59 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > The system refused to do a test_resume because it found that the
> > swap device has already been taken by someone else. Specificly,
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
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/power/hibernate.c | 18 +++++++++++-------
> >  kernel/power/power.h     |  2 +-
> >  kernel/power/swap.c      | 10 +++++++---
> >  3 files changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 793c55a2becb..f50456e72f0a 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -683,22 +683,26 @@ static void power_down(void)
> >                 cpu_relax();
> >  }
> >
> > -static int load_image_and_restore(void)
> > +static int load_image_and_restore(bool safe)
> 
> It is not very clear why the argument is called "safe".
> 
> Either this needs to be explained in a comment, or I would just call
> it "exclusive" and rework the checks accordingly.
> 
OK, I can change it to "exclusive". Pavan proposed to add a global
variable snapshot_testing to indicate that the system is in test_resume mode,
and we can check this flag to decide whether to open the block device
exclusively or not. Then we don't have to add parameter for load_image_and_restore()
nor swsusp_check(). Could you please give advice whether this is applicable?
If yes I can change the code accordingly, otherwise I can change the "safe"
to "exclusive" and add some comments.

thanks,
Chenyu
