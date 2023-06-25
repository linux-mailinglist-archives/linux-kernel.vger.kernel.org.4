Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFE73D34E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFYTfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:35:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B88E19F;
        Sun, 25 Jun 2023 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687721713; x=1719257713;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/EDXoCxtGMazBa8DiqrB7sUQAz0hnw1VS+TnBrKTISY=;
  b=RDDQeKg4eFh1ztCcF/d0x824uJkjLdYjvLSozaGZ8QhyYVsQkVDfgwDk
   ALG7rxWt5RmTUirrx+uDf5taIQvY+HVOkektSI018RUJkfScMz0KsF7/s
   9cLfvNo4PCEqL8RtGM6XcBLwq+qkT9rxykpPGa1OX4IKp5diuTs42k2/M
   br5YAXv/utRKK48CFWLLVH4BkXevajPNdUK0AZhCL8z8vsxLKQM5AIVpd
   mR0bDILb1Eq2zPvtKgHfCOjiuIMGhkhaJcHuDc9NfwlWLzc3CS8wqZujM
   9C1WPY8sm8dy67WW0Ud3z7xVvWNZ37nsuzBI73YzyEsGYapPo+gBfLbXM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="363660543"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="363660543"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 12:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="805783213"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="805783213"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2023 12:35:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 12:35:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 25 Jun 2023 12:35:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 12:35:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo2N6ZZI1byn5dKBiDZ3iQGEdxs/G5ULmNLHesuUQWxmojClGzAyuQurvDX0o2X5UBAHJ2HE4AgizWjamNxUVe/9b20LFw7s4sFEp5QVsEA+LT2OAzn9Lx9GdULNdTTTYRSuUk5WtUliJSv/Uikndu7bOtSG0pr/V6V8TRqyRH8FdaORfshlazaSKq8Zpz8+uTBs5UuErbhLSflBmJP0Bg4N3ALZcN84gHuonXD8YJvwg3Asbym0YQ/kGIJX0/NaLD5ZnqHC/5PSqP468FTX05XbLiL3hmPqxJy9vO2Q7tQSK3niW+sLqztsLeSi8PQNNmB15ZZwcRRTWji9KeE4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEf6wzC/OlifYpUYfWPkIHXXYqvy0Qbi2I8VTzP+g4A=;
 b=RmoX5HwaTyAYDcd6xtUY+LcxuV7lqUE5yVHooRjtZ2ysuTE58wtGvTULfU2RBS0vhUBVats1V2cB7IVI/XH/LrHLhPMgqMBDR/eq4WdBkwmtuYeQllHmiTG0agZVXRd/knNZpFzMBgx9qiNOo/jujdwqorKoGFWOeHnUtSmaYegiUdjjpA/kfDQbhogRZMkpod6ZViBzYCqEdlZ0zD5JcsLLCeanhDkNMAZLSrGUbTe/hLUajgqeDdmiY97L+7aki4qOIVkjgXSnkxy2BGHql9gaYCxem7yM77OyqtbGuwssi6aBuOYzDKNG82UTCgUBmTKIPZkbQehXih395jbGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 19:35:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 19:35:02 +0000
Date:   Sun, 25 Jun 2023 12:34:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v7 01/27] cxl/acpi: Probe RCRB later during RCH
 downstream port creation
Message-ID: <649896e15db5a_1dff294b2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622205523.85375-2-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b576e2f-9468-4d3e-b9bf-08db75b344fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iubsOSH9hJH+FY9Awr2g+JJeSco1DMhs9adSQua9w0mAfijPUVVsONeHSWYQxdYvczAAuzuo1Oc+wIzDB727n0vTePrblQJWga8ATtWWGZJ4x9hkkalTN++YfluKywycYCPTF5b3s47iQyzeq1+E3HXuorquu88XHV1R4l8LCmWkfffgP72MHpV4q/npb10uj1L6tD8Tsmxs9a+81eAKGRxUJI0vm2CCHR2yhBvBM0sofA8PEiHUCVNoQg6ju65Qlq0HX5hjK/OkdfHeLzQhucmsusqkaWCDfBJSyUTANL7zXct9bScvY8si3STyKSHobAVdLfwcqtgl2EVphoSKDAN369tIEGmIsbp0q38+SNnQi6o9/ywdJHEhq8vLPdHH0WMt0WiMj5PBodOrrzmqlHZpP5fdfZcGohbO78NFy7YvdjPD5+JGD+eGhiTra/2dumxiHbjikO4+ZC5k/Ep8AhklbmOama9vKHMC70nT3WMqZFR8H9dvcVIO3hU9X3DanbD22JwODgmHndoFl8nHDPngWh5MREFvSobQ2dFu30SX/m/hhg1xfNMzvfUI+9g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(26005)(5660300002)(86362001)(8936002)(8676002)(41300700001)(66476007)(316002)(66556008)(4326008)(38100700002)(82960400001)(66946007)(6506007)(9686003)(6512007)(2906002)(6486002)(186003)(6666004)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3jV34szxilmP8W1uUuO+I8xzpRPuPqj6vsFF5h9IttUSHha8qUn4bi6jPkQ1?=
 =?us-ascii?Q?tQSGyW9HTzNntJ4Udk+pO8ZLSY9MwD4R6ifEjZxFzA5iCZ12ZeEWGxGmlsHS?=
 =?us-ascii?Q?EmDCzNcPQZotqWaEMcT0v6OpsMKS7NlBXnLnnHhmeusmBt1FtF+BMHwj8Kst?=
 =?us-ascii?Q?k5p1z3NHavijrKSQ/u7SNrAkE1Pg5apbQ6xXZv8upC/F6spZomZE1l36TxWa?=
 =?us-ascii?Q?vHz5YB0EywKrmhFBFpv9H0C0HjHf3a08MadaCzTs+vANu8A9xNtnLR9aarRV?=
 =?us-ascii?Q?gbhXHoo0++8QuYcwpS6mHyj3sw2hBzAgtOqz+hUSzdiLyoUG7ykJ1ZkGsdki?=
 =?us-ascii?Q?Gh9J00TDqFKJhIokChXG0g0H9ifolYBj0HWumXmmCYKZDnUZHWB48+NmsnK8?=
 =?us-ascii?Q?soUXwP755dD6mHUSyxoV03twwSY/8Zq++TBGwR4ElPj0ATjWN6Et0S4yjvor?=
 =?us-ascii?Q?1PLXRCg3dMts9h5+WcSRdsD6V2wDsOVGdgHUNNoWbcJQY7aDwhT7SmbKUn/u?=
 =?us-ascii?Q?Xu4sWlJZTTp/tNqR9TO7A9WApPj5EYRrCiNo+F8KcrhlfjyARKUJhRIpCu7Y?=
 =?us-ascii?Q?+kp+2CURnv7lzbJ9WqAOI45+WB5naNo8XIhiudZDVVow6JyDsDiupFcupAKK?=
 =?us-ascii?Q?VQR1mRa5u328q/di0lnPHuQlc5uGSvbjRuo8+yTHx5J6mQLcNqY1r2jlIXzz?=
 =?us-ascii?Q?RFypNPBsBN4tKbE3+JzjtjEk7U+ssVWCRxyJf/pJCAReVHnKq21EcPPDza2p?=
 =?us-ascii?Q?n0dBowSz0FPxlA7FEr4FfRR/F8YM8vlmrFpEgF6Bq0Ikv4+5qUMTDfKnjsML?=
 =?us-ascii?Q?YFF3bY8kka468L6vbIO7YlCXNneu2yhGOAU+t8ahZIP0n5brVzkw5rLnZZqP?=
 =?us-ascii?Q?q0UBH0qaEILtmt3OJjajXDwL4UNt18Iyclj2Alr7coM8u0INgQed4c5w2BbJ?=
 =?us-ascii?Q?KZvdCuHM0c+mtpSMOukVRQfPJChZHl5b81R5CrLQKHGarVp0Y5u9I41obJ+X?=
 =?us-ascii?Q?cj2M73RgRqbBIl+3aVVijRF1PHRUUFTXYC2yLk0+xwq4l0FJpbhlSWn0YUJz?=
 =?us-ascii?Q?Qm3eIB7Hv4WNr3jOVR+umLfTjzEWhDn1ThRDUuM9yk2OyLGI8pnop+NsVm0u?=
 =?us-ascii?Q?FcDd3wg6k1Z4WStnxTLQfoiNBsqAneBZXvzqOfnW0F8b9n7f7xN/2xPEIBZO?=
 =?us-ascii?Q?xV/AwbxWao8khN02lAD/EbmJrgy5UEAfcxeJUMHSX+0fMCopASRTGUdXbdbH?=
 =?us-ascii?Q?vf8uUDMRXqYmAsDp+VOe5RqtKhtjxHp56ASUuWDvsiuJsVfpc65udr1+rh/L?=
 =?us-ascii?Q?EgCHyhHFtf7t3l3J2mf1sD1nlWxjdSWzmOrjyveCOibNKNS/l7VjYyH91nnz?=
 =?us-ascii?Q?N1Qe/UANwOvXNoUjUIRK8eX19hZ8wiWi2U5Hepk1K8vLIskOClU1WV5gi6K3?=
 =?us-ascii?Q?d37C27vCu4btwweTzznt5GNp6nt2/+gNTAJNMwTYBsRqWXvcY618lwAm6CqH?=
 =?us-ascii?Q?BCBfRMY/fvLk0tNocZbj58/oRykGwRu6sQWfT1Nw8ps8glX9aEVxgoMYrLJP?=
 =?us-ascii?Q?BQVD7WrmqHk3v9yG9NWs+0+YgJilYrYyVTkPwKn+OksFz6zxRnZ7lyOBLnvu?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b576e2f-9468-4d3e-b9bf-08db75b344fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 19:35:02.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHcLibsJ0HfPkQu6xYc54DbciIHSNZO2MUKjECakA+9s5T/YkSzZNl9zRPpaxy9Ul97ST09AJr5c5NEJMmL4BEL4xm/owGNdDTKtMNk6n3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> The RCRB is extracted already during ACPI CEDT table parsing while the
> data of this is needed not earlier than dport creation. This
> implementation comes with drawbacks: During ACPI table scan there is
> already MMIO access including mapping and unmapping, but only ACPI
> data should be collected here. The collected data must be transferred
> through a couple of interfaces until it is finally consumed when
> creating the dport. This causes complex data structures and function
> interfaces. Additionally, RCRB parsing will be extended to also
> extract AER data, it would be much easier do this at a later point
> during port and dport creation when the data structures are available
> to hold that data.
> 
> To simplify all that, probe the RCRB at a later point during RCH
> downstream port creation. Change ACPI table parser to only extract the
> base address of either the component registers or the RCRB. Parse and
> extract the RCRB in devm_cxl_add_rch_dport().
> 
> This is in preparation to centralize all RCRB scanning.

This patch by itself causes cxl_test build bisection breakage:

depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
depmod: ERROR: Cycle detected: encrypted_keys
depmod: ERROR: Found 2 modules in dependency cycles!
make: *** [Makefile:1956: modules_install] Error 1

...so I will just squash it with the next patch and add a
co-developed-by.
