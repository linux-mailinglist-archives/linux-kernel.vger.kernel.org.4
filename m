Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09EE67D9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAZXpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjAZXpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:45:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BDA13503;
        Thu, 26 Jan 2023 15:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674776716; x=1706312716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=20FZ45RCGSkx0la0pBn3B2gZJG2pKzmAvIt4Fth+tXw=;
  b=LxfF6KLVapSp3rp2UpupJkJsXdTtabU3rmapy6iOI05zFxZ1li48qkbz
   p5TXRkmNu9Hk4Yb8AqPbh5n0UReetba6DmbPHPG+PgHnDcDS4MWpDyQMP
   VeQfQVsNcf14VtiMfJZ4haW7EM3QCJaBnMkv2HAC/EdMWfgfSQX0QY/9M
   gQwZgSDwCpfub+hKtVBPfbyL+Lb3vjNV+STdeTudvfdNY7H0c1A7tuROp
   mmjdaVA79WAdqUK0sR0/XfWRZ0afZHJw/KFmQBMyutGqUlr262uzqL7UC
   SY+w5GYznZ5EHWVnhpiT18B5rSW3YoRcIJywDbs/DZyG1sZAtEWo/MUsN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="310611329"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="310611329"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:45:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="640511125"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="640511125"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2023 15:45:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:45:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 15:45:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 15:45:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoMhn4G/b5+IsJgOEyULu351LXBzEPL3cRRRZlFBPhLTne6AvashKB7eSukQNG6GUyZeMChBuKmCzSMo14WGUog+GbKFiILZDBT1MdpvYrnzm49/Y+ZB+E9fRlmmw7ion6GUEEZClXLHscqYtS6ydpC8pSRfD9LGQ2gBcYWMJDTQoyweHsrRNbg8wLUw6KpKn/lWVTNzL//m3drG6EHLYoLMhuIrlpfBsSzZ77/+LcIbqeKalxAhu9EcLYfVKxBnGQqR+1m1MfCOsO38VPLhFMB/c5PfhSc3Oj7PoLj9uf9lipCbMBYP6f62fRfjf/ifxgnmeiCYzCTho3rXheYR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpcR/HXtW1WJmOlE9BdrHgOprQ77+JBp6LGQGiWgWuQ=;
 b=HRtvk7T0ZS1TXOi65PjvsUNyAF4OfSqwTgpPULw0SDYJnLEpdyJqWAywkW3A9/uXYRtWKqvMhuZj4KEy60iCI1HXgqUD7YJbSqUA1gaao51yKKRODSPcCiLdjCBd1Dlw8I25K3jBpDQXXCvqLLiujYBHuHpH+RxJGW4m9IwPDLHh5gIDVt6Do87gEH9OVJoaZsw9CWHjrSrX6ro1oafbGBYA9qBZr0hspDp0bnB1hcMvUWmTEDRLmhH5sU3Vm/E5b+Xg6IeovOW4p+FirtxOfpMO8BVQm+IURBhNeAWDRrlYZapZS6ScU/hR2EP6qWST6grqFDJ9QZhJ+yi6vOZRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 23:45:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 23:45:12 +0000
Date:   Thu, 26 Jan 2023 15:45:09 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Add debug messages for supported mailbox
 commands
Message-ID: <63d310851dc19_ea222294b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230119130450.107519-1-rrichter@amd.com>
 <Y84dleBbsQhE0Dic@aschofie-mobl2>
 <Y85+dwjO9JjtFtGa@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y85+dwjO9JjtFtGa@rric.localdomain>
X-ClientProxiedBy: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: fffba1ec-34d0-4982-145a-08dafff75d6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esDweB95sUPOKeOWDo/6nTWyfYaszVStNV2+M4T6FUHo61oVFp1n2Vt2SAZ1ksJZ10IDnRKXdcRYWam1hzdTRcolF/tHbGw2ff+aMXY6yvW4JxjTf84l5wM1WXaJnyaEOnLf4wmLw5KfhFHTDM0NUbxJrrplWT9kmjj5Cl+AFwTv9AdbtTqQww0bhUmMKkZwaUimMbUPmUUiVA+/ghCYXcpZ21437qKmZWu+QR4chQmXMy2lAC1/D0MldsF9SwhgYNireUtWZCtxwMmvUvlY3NSKWQtayi8uxlz6Fxzte3foMzveajPY5Wkg5FzZBAC25E2Lh/fd2wXelAVNhQbQu180cVqJpj7+71NhgZ2pP6n/tBt3pDc3XBV0lta8Qc3ocuVtAGTWSiMfdhr03KiL4B9oCenGAxhm2ev76JVjzXT/Wsicp4m6ezQVe1qi5wtXnZCswz5Fci79oKl71BYWqto1LMwTno1ztbxxOk3cva0y1Y1xVcKOtZ2pP2ONk3rcK7L8r5pyDZ6wPeuaOxVfJ4lHjWhpdmQwXZODDbm+cDvjUCQEDAldXqLYXUnuJ/KjqIDtSSw0KKlDUNde6K2vmX6FZVmF6meVI2Bvi1H5SSIeJBWSVfKfW7PoJyE9MN9OASyF8tnZHB6PldJ4FMtTyBJI4TAiec4w5H8C5gp6dj7SoMbC/DJvrdqQs4GAge7c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199018)(316002)(54906003)(38100700002)(6636002)(41300700001)(15650500001)(8676002)(66476007)(66556008)(5660300002)(86362001)(8936002)(4326008)(66946007)(2906002)(82960400001)(6506007)(53546011)(110136005)(9686003)(26005)(6512007)(478600001)(186003)(966005)(6486002)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTc+PGXLtCTk6yrmzvJVDJ5tXurHie/NW2Z/ZVNHvKghNntvCs82U2Erk8/R?=
 =?us-ascii?Q?URl0aZ7YKIlGTrjJRVpLznJ1uQwCs6ot/hUSOEn2CX6WA2Wzn/4e7eL85d2H?=
 =?us-ascii?Q?9KM0ff74KJl5e/B66G5Oonw5am6VCB64T/HV/Zn8QHVRyvdldGP4+Fn+4zDG?=
 =?us-ascii?Q?/+TwzQ+yrR4D7/wwMnx2RfjOOaHEMd/IHASTqU956bsUyIBDk8N1DbpaufWy?=
 =?us-ascii?Q?YaNzc8xITLdxshbAyl3APq9rHnok4ehIUkLFGIzPCHGNbMuMIroszSvGLupM?=
 =?us-ascii?Q?Co8cHEgWpOzaX+TKwS2e4hfOtQ+EU7KS/NFi2IORhw7FlriB1jTz4Sq/aHc/?=
 =?us-ascii?Q?QOgxOjxMdmCKluJUp7eA5O7XThoet0B1A35XOPrJ5vjXkVlZrkOmnukdDYAx?=
 =?us-ascii?Q?8rWyS4nrOZ69HJ4VLDKqA1Bt2KCh5qn8ogPDo/Wglk5vlWiKvhDma55Ta/7C?=
 =?us-ascii?Q?Cnfpm9YbOF3Mr03whmfcsrqe/18UQ/RUSQMVTt4PJLzE9Cuz6AKji+y7il89?=
 =?us-ascii?Q?7lhDtq8Ezx31XbMLdvyL6RQ1wZQ0w5rwHpgzaQOgxwnPcV+iOShy20e36C4z?=
 =?us-ascii?Q?zNO7EFKsnpgUmrak7VPZJUAshBHFJ5UPf/Cg6O/rwM8qqXKbxJS91VV4w+KM?=
 =?us-ascii?Q?f3qu8N3zSHah+Mi4mW1be5RRiLbIdg4P9l7o5ixj7/K7CaWekLwOJR6vPrRs?=
 =?us-ascii?Q?WOMbiaM/7ouOt779FYxyJ4UkDfVRJoY08drMeQFFB+TMGHoX1jIq5TryRRCw?=
 =?us-ascii?Q?aK/EoMQ4xmngsK+yd27SipsXXyksTvdez6CzKPikLkWFJsjEcP1ErY8J/7dD?=
 =?us-ascii?Q?6476/O4JLYrQ1gvtBtOBz7RTeCTV1wGSSn0Kxn87/yMUQII7mjf4QkjmL+CN?=
 =?us-ascii?Q?2T7Ln7BEgM+O4mK6wlNl1P6xAnjrBPw9AnSxKtIiPylAwMmKXKQ3d+4dDDt/?=
 =?us-ascii?Q?oTHsOcvP8LqOubAL0p48liKUFQ7S4hKGkYg+RqSkYCgDE2hME6aQ/QneyIFV?=
 =?us-ascii?Q?Vb9PMl3L3r9JhgCoryuHM2d7U5zqCqD3fclCvJTMPItoYW6HAi6jWbVGViSg?=
 =?us-ascii?Q?hlnAet1yF8/E1W51NIsuHNVCUptmrxl979UNx2NDE2VPcmlIozrDzWedCTS6?=
 =?us-ascii?Q?SB/EXxdW5CYstygzRaTzNN9nnoFTsgprGcirFzBDTg/mUAe0AViBf47Y/TlV?=
 =?us-ascii?Q?NhTrZsM3mznUpDyeLNfuZ5eHWenMEzxhZpaOkq2fHpi59WIw6DiGYdfULMGO?=
 =?us-ascii?Q?oOfdqX7+EbtA6Au0Ds8l4u4yiMGMWgPRK4cGEDVHqW7wRDwdUROb1g5cmpKt?=
 =?us-ascii?Q?0GKGsR6vAaeK/EUjhl//ZoQiqVoCl4xX2W9WZ8gKby3/JjDdsjUGLWjr7vu1?=
 =?us-ascii?Q?psI+ZORBxaZEcWNNFtgG3l55/x6oCkPQzRYERAsl/B5MRwll9lw1bZ76WJ2u?=
 =?us-ascii?Q?nFLiSL4RnAhxpyyHxC5BXc/EMVZm+kqdRsIarUqZ//OJ3NOfMW/57too3i/A?=
 =?us-ascii?Q?9DLH+cfIS3nC4Gb7K7jfk6oT5abY7xS4d70CRrzHRgO9LSqRJ/nZvj9JjCLz?=
 =?us-ascii?Q?Gx2XygWc1bbgxMqPbOsb5OvPl7YRYXZsYPcVLcnIRg81Vy+qBXiVOTULSEvE?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fffba1ec-34d0-4982-145a-08dafff75d6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 23:45:11.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJKQUOb5edIVMXv8hxPxy/IZFNO+tLjJ/X7bMzAo5rf/osIsmSXHKjOrcfhSJW7qbKnF5T/es+9HBw8Lg8EArPKDSTGiXt0FdJeBGVn0U34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Hi Alison,
> 
> On 22.01.23 21:39:33, Alison Schofield wrote:
> > On Thu, Jan 19, 2023 at 02:04:50PM +0100, Robert Richter wrote:
> > > Only unsupported mailbox commands are reported in debug messages. A
> > > list of supported commands is useful too. Change debug messages to
> > > also report the opcodes of supported commands.
> > 
> > Hi Robert,
> > I wonder if you can get this info another way. When I try this 
> > loading cxl_test today, I get 99 new messages. Is this going to
> > create too much noise with debug kernels?
> 
> There are 26 commands supported by the driver, so I assume there are
> at least 4 cards in your system? To me the number of messages looks ok
> for a debug kernel. And, most kernels have dyndbg enabled allowing to
> enable only messages of interest? Esp. if card initialization fails
> there is no way to get this information from userland. The list of
> unsupported commands is of less use than the one for supported. That
> is the intention for the change.

The debug message looks ok to me, I will just note that there has been
consideration for exporting the enabled commands list via
CXL_MEM_QUERY_COMMANDS [1]. I wouldn't be opposed to someone enabling that
as well, just need to be clear with userspace that not all kernels will
populate that status.

[1]: http://lore.kernel.org/r/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch
