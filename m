Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDDF70D26F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjEWDeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEWDeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:34:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F9790;
        Mon, 22 May 2023 20:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684812845; x=1716348845;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=x82di8gmr2Pd4l3CZW7TG4mwkaGxEaOKNi/FVvBrksc=;
  b=mIj7Y2MU5pes3pKD4QeT6Rg7hTt11OXFuc0yOKQj7XVLyxGnx6XlbvGU
   jr08N1a/RxAYrw3hYoSHSp8vJMOPXN/pPhjQ0RnKkVCvOCc+WTL5pQbrU
   JmVytZLnzDA6v/6KZEpIDo7jvMd46hs3ZcI25eCDc6s+uw31pAF1dseW2
   +0mHBBAOix52o6iaJ0pzXNtCBtRECpJwMKYkeZ8gq+rOduCf7AbAFdMex
   xitd7WjWIdQhDRLlfQNq9VhNpk+nVK63G7T4jvLXnVSqlbVGDxm0zhsez
   bz0ne3vDCLj6QMa8jEArsHp0cWoWOs+fto7n7gwTJa8PMpMXwJMvRX5y0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="333479131"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="333479131"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 20:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773636219"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="773636219"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 20:34:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 20:34:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 20:34:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 20:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtp45ZDprY0hN8fkhcVWgAXsPIX73XS0lG2i531Y5fnWonmpH43CbC/E4ygeUTVU/4o2g5U0Cg1WukKCiIRYKqa1zR0gejFXJcZa5Q246pUfcXvJAOfGxgUSzV5dIr1GKTRsKw8ywxoF9rkutSO65GCUIeIfpp+I04fw+mvkTh/2S8AGT/UhZ+oxgrghXeBlo7DpcG9v+3ZsetvhoaYV20f8N7Qjnb+/sOahp/AYwpMuyLvxN69AaijPkb81p+XXvpz6m7NoKdLcX8eJX7J7W0L3izO2/HnWF5APvqK9vUi2vsLQK3uB98NBGWg1wQ/8k4JemdnnXH2kKcNtO9G/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6SLgJNwLT012xl7Jcv0RLHgameU+tmVA0COJrYID04=;
 b=k/1AcNu/hKd4KLoYZv3wVDP0erpsCfYT5/i9i6ZdUF10heJpE4Cn6w/pfg/96kt8YboYewr9gfMKwU7MlErVmQL3+cLAcFVTIxP874xSi6YtX2NwRrlGXPVULsO2YsqYm4PhXvv7MdI2CT9Kww+GCSONNJVEqNbYe1C0GsyJVfQU/OYBrdt3LxUcxYtMc2/Y0F7V0g8lu4jXdZ5u46b93NC2wjxf2esZkZkDs3qffBN7D3JL1KVGN/lWvvHknaC0Ka+rH8Q2LiZWmcIZOYFkxVnm5emrdMKsG/r6OvXnMz0FNS4xaLh4dJvDW3EB7Xh94xmDE8MI/0QfxRIpvHFEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 03:34:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 03:34:02 +0000
Date:   Mon, 22 May 2023 20:33:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Message-ID: <646c34278f161_33fb3294ce@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
 <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
 <ZGblx0pCpJPvCS7M@aschofie-mobl2>
 <2bf4a3a8f34e71aa2b2be2b88fe22f58004eb699.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bf4a3a8f34e71aa2b2be2b88fe22f58004eb699.camel@intel.com>
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c2b2ef-8ea7-4111-dc80-08db5b3e8d2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfeUjBhdI5kTNhWNu3f+ZlaN52YAmB5XP6btTmkd82eIB8K6UZ1+IdbeTxkgwJJfntDWHFlSzS932uCVK7yCiB8gQWFFon8i+4NkCQSjUrm9IqHLdozdwghl0aX7E2VEPK4vlRVEoRRZCfpTFSXfVNLd0nF23MXDADCMI2R/bPvOUgceAnUf2PUTj4i32wJb9TtG+HnOLIAP78hw5FejlFn+Zk7iabagLswxF/YjZ0L9vKxS2B2uTOiyhmtjGRjuxgnJaF4HU5nBsIgYgz9kiAO+WCYcpLxSgSkhgDMjM31O6uBLrf3hH6KIw1d8c6swwIqs+A1nzJuI+2qQRMj9aPWJJDukNvPm1rrK8/JdWiF5txoURaqEza1uuvtSksGueReaPAQutnJFKzhu+zeIJxS9+6suX3UnOCrX8IT0gSfyzS1H65yrLXHns/BhGtHRi5fZAF0xhe0hbOpQKqhFNLZ9FwtnskjIygynIvc5741RSft8GuNQvOiAW3YxCs0ccUmjcLsyUGSCY55G3IzU8VFCe9g4Gv2HKMs7m5yagEhBTvf9cm9AsGUcVe6Cnl5o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(54906003)(41300700001)(6486002)(110136005)(316002)(66946007)(66556008)(66476007)(4326008)(6636002)(6666004)(8676002)(8936002)(5660300002)(478600001)(86362001)(66899021)(107886003)(38100700002)(82960400001)(6506007)(9686003)(6512007)(186003)(26005)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ymDGL/qOrFRP+ljQZhUtgguFxRUxMzBap8bRxf8OmWPgLM1L2guOoYH1nz?=
 =?iso-8859-1?Q?U0gVlQ9QMK/k7YjQsxcUzQMPnD2FUWYDnLojVLK9tWPBjABSggoWmJ3Z29?=
 =?iso-8859-1?Q?sAPMFCKT68lvWBdWIFi8/iGtwmhlSyQkGM5s2j7cfOTnWdruG9Sbd2xymK?=
 =?iso-8859-1?Q?2IbnYgTn+KKK9UiLhm9bv8y9LdPZrwpi1crnRa9J760YA9W9ISWQo+p5TY?=
 =?iso-8859-1?Q?Yc31RiC9G6Lvbe/RH6oJGtfezE276Og3cptt7JQl8WQhX/UqdQYi5Eq+vQ?=
 =?iso-8859-1?Q?zEiR8oNv13sRUBPjFP5J834Zamwz/F46pf+45La44WyFCfSCFBLMdQ0tYS?=
 =?iso-8859-1?Q?w4Oef5B/y5TlyGUE5EQtsBlcgQDNHB2kaBARW+EWl3uPiWgGNgHK+/4xVM?=
 =?iso-8859-1?Q?NfLYXn7rIlvAwi4T1I1NtEOoQju6IR/cLxwGGCK9ijZrOLp9a6IqIoWmUn?=
 =?iso-8859-1?Q?hc/GFL5ubIcKtibJH7JxUScHpt1mKCJNAShCEv6QYVgJGTFGJhXCQdjF4v?=
 =?iso-8859-1?Q?erJqKl9a87ewFsQugPbhz0+jSsbDfaISwunzjIAdj1KEJMmGnkkCv/OhmM?=
 =?iso-8859-1?Q?sixWtsWBuaoJ1qaZ/9q9VUxq9zOqt+RelQU1ZPlXMXtPEvsh9n6zeFx+mN?=
 =?iso-8859-1?Q?RmmXyvHorVYmafRwUtGcVThnJSBkbp7emVqYjDquBafb/0DTBfXIJo+oo0?=
 =?iso-8859-1?Q?AK/AxtdkfFJ2KISoXT4VPj2pETHZAmc72/89ejRcmYglbh5fctxzhvU0yY?=
 =?iso-8859-1?Q?HTl4/mORovi/fdzTlRjYs2XECJY1Z6Ql875Hlg3QJJG16JN6pwrtOv1aQr?=
 =?iso-8859-1?Q?YAMExnIyDJd0kk847LCnFKqonDYguEn7S6MacegxFU0tqBwq6hLBjEtI1m?=
 =?iso-8859-1?Q?2nJugsulS+srR49kFYQaJxSwCOOVmr9JXjyIzbgU5XW95sd704bBpnWVrQ?=
 =?iso-8859-1?Q?nmSR5X0bvDuqu1ts9ru+WrlkdniQgb9XVybOuO0wlvH/3TmlGi66Id58CF?=
 =?iso-8859-1?Q?DpdM5ydH2+WK/ecDIeG/Wt5o0+kh9pbhWgcYNk+fw7TiMF5VLmMRljzd6/?=
 =?iso-8859-1?Q?fbo8aZGPR6XNNBAVKrOCPTnUlvw//ZZ/R2Ioxh21/apESyEnxV2TABqkw5?=
 =?iso-8859-1?Q?VsuxTgKDC+0NC1bM3aqopIRDlQxgMzge5cdYyP2Dp8/CyGq36zHj09i/D1?=
 =?iso-8859-1?Q?hvcaF6RKngzABgdwG2Hfs4i+LkIjEAQU+JQQwYzDQXR4z6VgKmHGORGASU?=
 =?iso-8859-1?Q?AS9D3migpT4xY6vU5Hw9IyOZ7qoD3liKemjOpBM2V0jVwVIjHY5pZL+9V2?=
 =?iso-8859-1?Q?A7l7AZh+VYZw36x/bOTQHtaNFOHRAXXKKCfOmrHi+rOHWntBZQ/jhNhvzj?=
 =?iso-8859-1?Q?SmnST5TXwFij3LTX8nkn00jTtR6ux4nvxSbIv8YzDmhexJ1yUY+/BcDxmv?=
 =?iso-8859-1?Q?mGk0hjPDS6PDv56MuwVelAT8CT2Zo/h6WNNXybu8ceXD9GG2c9Co5jU6Ha?=
 =?iso-8859-1?Q?2gyT2FWqQ4tXRQ4cTg3zXAxF8bczGoGMOyoupMEAX9B34RODv9RWZt0/t1?=
 =?iso-8859-1?Q?Vst589MebU0XBuv3Fmh9VGMe69dD8S/nyjnTImwfvufgLY1cO3Fqp4UACG?=
 =?iso-8859-1?Q?/hOfouDCtMGBC0D+V7UACoozHQ+/lxaC64JheOpwKOZYNTSUORlkWZTg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c2b2ef-8ea7-4111-dc80-08db5b3e8d2c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 03:34:02.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQWv27N6kHZHDDNbM8OqGBkyiwgBHDHw9OVJlVcFhzevR/kzNhXUXrD+P7DJ4t1h+09PTSYu3wIQybK4WFy1X0CS4Tl4nXy1mv6bc25iw5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verma, Vishal L wrote:
> On Thu, 2023-05-18 at 19:58 -0700, Alison Schofield wrote:
> > > 
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 8c3302fc7738..0ecee5b558f4 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > 
> > snip
> > 
> > > + * Get Firmware Info
> > > + * CXL rev 3.0 section 8.2.9.3.1; Table 8-56
> > > + */
> > > +struct cxl_mbox_get_fw_info {
> > > +       u8 num_slots;
> > > +       u8 slot_info;
> > > +       u8 activation_cap;
> > > +       u8 reserved[13];
> > > +       char slot_1_revision[0x10];
> > > +       char slot_2_revision[0x10];
> > > +       char slot_3_revision[0x10];
> > > +       char slot_4_revision[0x10];
> > 
> > The practice here is to use decimals [16]
> 
> I looked around, and see cxl_identify, cxl_event_mem_module, and
> cxl_event_dram all have a few hex ones thrown in each. So I looked to
> the spec to see if there was any consistency there, and unfortunately
> it isn't either. The spec does say 'Length in bytes' 16 for these fw
> revision fields though, so I think it makes sense changing these to
> decimal..

I had asked for decimal in the event and poison bits, but yes, we are not
consistent. Those ones stand out because even the spec has them as
decimal. Not a deal breaker either way.
