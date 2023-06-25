Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C673CE94
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 07:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFYFrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 01:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 01:47:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6D3E64;
        Sat, 24 Jun 2023 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687672052; x=1719208052;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4EabK3oPBPP9H+3u2140TDNiJ44AgXmoxREqpVX33ao=;
  b=YY34RbMqnkNqDAEu7Fv2bGAEupvieAClFRE7cEClA751uZ8h9qZvLvE5
   /owsjCMpjj1hnxzB8f4m47K/AqLJBA5iYz2U/MnHZgqDeNtlCIWVzE4Gj
   sKhqTmMhJl4qXWbTQY6vS8LSXzEisxScnkdHbSMpb2tX0LProj8rD5fI7
   V0PJJTycIWu6fj8XO979vp9EacwqeEg4t+R6825Z36HUkB1x+0rf67zi1
   i7dfNULhbfNhTM7fCt4tGKG23tP0A2CPNrlUJdn70sbpsHPfiPzkK04EP
   RjfSeenNHfYgNGFhD1LQRNC44JyPkCizwQ4JnCigtb8KjEZhGf4rVC3cG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="361065695"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="361065695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 22:47:31 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="750536811"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="750536811"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2023 22:47:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 24 Jun 2023 22:47:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 24 Jun 2023 22:47:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 24 Jun 2023 22:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihx+0YJYIKp5HLgZhaOOiqVjjYLByDfeEJevDghsbkm6ph4xOd/oK9uzw+DxcMNFxYJPzOKtn28HX4HnGvMKuMOgknM7vF/3gRk/OAu7ZyX2W/ZH/oRa/MVe6IQMoBMSWdinUyt3IPDL18epc5HD0C/SQ++AcYarebfMoXa1p3v0/IM/D6cTtoFLlmWqnl6gerfwLOiVUDEv+xVwj4dGO3xM7aUqxPUNVSF4wJI4Aj3jpM32ud25WIJsJmJZ2ikGlO23YbWWlDCfGVlESjUOASX1fEoCbZJVHh8WUdI3X+9duDXkSG5AXPrOUVw5grdfpcKXKg8O8W9eHA9tSOyHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZX0hgRY2BRGtutsqdACE6lnZ3VT7HSgcEP/sjSuVMA=;
 b=N3p1SEkdgdcNGAKMqyJVxxAAib4uPMbvxDc9xiwd6vKIorZU7ydXnDLGV23DFmnSor8elO752NUD+LTwi7O4kfJfxPv04Dwd36qLhV9Le2g99ZvU8np7HhX98TKH069DCKBfKCqMIc0gQe1xmd62xcd+yUggoDnHaxjfIG/Oj/egQtknPrBZmoLaWdN3lPC9P56k4LaxeO7TSa6bIk4yDRmpDQF5QmGchXXVJEEgeupffL/ePnuSoV/+90H2brc7QUiBe3dk67nyJOWjGvqp1WdtG1rJ2yXR28z67P01cQ7Bo/TN/WcS0AnR87SXEuIXeckbaevDj4oMqRCmXg5w9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 05:47:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 05:47:21 +0000
Date:   Sat, 24 Jun 2023 22:47:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v7 25/27] PCI/AER: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Message-ID: <6497d4e5e9cb_2ed729496@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-26-terry.bowman@amd.com>
 <98a0e78c-5b78-136e-f955-0d8680c3c6b0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <98a0e78c-5b78-136e-f955-0d8680c3c6b0@intel.com>
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9d14c4-0c77-4b7c-04ff-08db753fa4b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6nUY1g1XxtVxBso55wr3hGX0KctpnMYcogz4qCNaR+FgvVlphmqmFUIphLAaBFfwwHh7rAQkLQ9Cg3VxZxk1dG6qVOGCTD/Ch/XKlTYgR8JcFEvGrC6WAu8meY1nAQdD3BxDM21W9fxYOn2qe9huH37sYR+6bqVwsA8mkoHpQQAAHDL4Ga+68BYKYNsuhd8eVtKJzVbMmhhou/FoffgGgNZOqfzYKL9iZQL/sJq5ClWOsy7C08YmecxlZ+U5SvD4sh4IEwb4Ijx6B/etBlQU64+Kvp3ryRbjnODGtOTIVOfjwB8L090jGFPbBaOiKJNcKkSJKPwauHIvE54jXphyxM0z7P3Ep0Zgt676WpFBdI17DIQvyVEWLFjjgFADRfR/fI4LnQifBeVOPNuHWdgCvooMft5AzLzoR7KKNIOUQ6hq1Qok4mMeE239xK1QaDLXcngJ6MGfr6Fix7CyJpBQLV6J/5jZp33IBiI21WNBFCSaIPOkmA/LHwuqwu6mG9GXPJe9Q207Ao+jFy9ADbTeRTedSfLzW67BXf6jAMGJZSosGzY9ipny1R33xkEuA6H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(8936002)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(316002)(53546011)(6506007)(9686003)(26005)(186003)(6512007)(478600001)(110136005)(6666004)(6486002)(2906002)(4744005)(5660300002)(82960400001)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9pZ2ZaAgERBr5cvKu5dj0HT+PZ48E65oudBGZNzLszqeaQb7tJoMD+iGuHoG?=
 =?us-ascii?Q?DEYF7A6FfB9ChkPHUjN6QSbkFpgmLpHOXWRyfJCwfKQ4S/4lsjDiwqmqN5jx?=
 =?us-ascii?Q?bysgD+v26GycbJmM6hbcBriuazaeEU7ktRixEhZWPwTfsuQY0898DVYlM1qN?=
 =?us-ascii?Q?qW+ckHPAy4IIhIO1Rc4UgQJFfca1X9S5J+ovYPOK2EODmdBo4P6yfM6s7Mmy?=
 =?us-ascii?Q?59iYwkU1mqYQu+7WE7FDWgrYaANgSaQ8t66IW72srZo885eNRcp4l2eGOc/l?=
 =?us-ascii?Q?sIT241FeSVQhq6YFBD75CqGFbfsl0r3nsS/YUE0jfKI8ocK16cQ46dQ48ktm?=
 =?us-ascii?Q?KOuK7vxYpKTn+YQg66Rv0gBLmkGfTBkRNI8+f3KOhjO0xOx/vveqic6nu3xO?=
 =?us-ascii?Q?opbNWLfUzwr32bC3L862GRQRky09Q1KDHhhIi2CZA/J7He7K2qwdKDv3qS0i?=
 =?us-ascii?Q?IKCwTgcBfOJ64yFogWekkn6izhJL6qluPJnDboT25eh5yr3SFsVyc63KvTP2?=
 =?us-ascii?Q?JNyXbDEtYPAX8LhH8zxddkLf7rH0EjQ0jrItnzOJmgEFqijVznpP3DURYWtQ?=
 =?us-ascii?Q?xe9juPUz1ILWXOkIKYMgjaM6Z/BRn531ok5POw0e44IlpNR48sr3+i8MVsc1?=
 =?us-ascii?Q?HnzCxL+qFIfTwXSM3Cr13pZ6Ip6LRybQ4mSyaAo/Rp/rXS3hbxhc8/ZXamh2?=
 =?us-ascii?Q?V7sVQp5FCvPdjfPJTuW4RRMul9Ng4jLQOVrkH8BnkzJiRbdFcVfUV7n2zUxq?=
 =?us-ascii?Q?q/fg+J8uk49vHRXXSIY1AK9/CCyKhYPeKZS7lXzziaFejHi6TOP1O3JjWGJg?=
 =?us-ascii?Q?wtVwkTDBuLDeiSBIrnucsJwRC0C7fX0oUfhd0WWFQuppbRCjSFHEsMV9CPsQ?=
 =?us-ascii?Q?kYkN6zRApsWjVGNUGj8zMF1/PWyqGs1Zb4NKJe9NaCjjjYBE1A2Kr0RLxgQX?=
 =?us-ascii?Q?cjnFCEDAK4Ta0PfKPY/RU2F7Yb+912gFdHbQ3jXLmvwQfLqEkDE2wcglXvFU?=
 =?us-ascii?Q?WpLXUvcFEOgyTiFmcbsj/+QRug4Nzdg+6ZteVrqtR7Au1ez0myKLjvAXu2Mj?=
 =?us-ascii?Q?8SyxqJ7QUafSGIGzDZ2wZb2upeQ181hr2A1snmbfjpLabEGr7StuknlxvC5+?=
 =?us-ascii?Q?rpHUeibBENLNaBCLw1umzeoPTtUka+XyUoLkw5iVU0pFsz6MHrIPvhY7oO8f?=
 =?us-ascii?Q?t800qXH59D4K5xTrPrlN0U3i0pax/amBInxvOlmLXeF0lb6D9PUmq/GF/KsT?=
 =?us-ascii?Q?fQzW3vo44UFbfzjVSQX7SOXMIGmqUBMjLFJP1R2Emw+5iOcEQgjjFTqcp0NR?=
 =?us-ascii?Q?tXi0tpI0rDM8lW7zDrzeSh/xW69IGdvp9GDNeZG9M8+8jqWFQ9T8Vq8ORv4j?=
 =?us-ascii?Q?D+FofEIILCHTYh/JZNic/oEERV0YBt5TytEvq4M2n1DUrLa6h8kGd/aarCPo?=
 =?us-ascii?Q?dJTS6GWZNlrmJn3mvMDoRYPbIKFPCPQ9EA6bdbFrEfN84jEqWTBxQoMmELMN?=
 =?us-ascii?Q?mIQIeITYRo+a1nzF8rS2ZidwgvvxsmxcTUX7SegD//wK2LU5T6pjP59eKGiB?=
 =?us-ascii?Q?m96xfSpXGtJ6izkXqiKmlb7zyusaZRvHd+uZ452RzoOvTiiAie4Bs+6V0BzU?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9d14c4-0c77-4b7c-04ff-08db753fa4b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 05:47:21.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK/zNl1fZZJcZovvmRUV74CkTs4hMkrgNVbZQ/zvyI6N9gT5ymQbYQqG41m9CtR/67+s7AUQyc8T6A41ROExfMWlvIuwacG6G4ytvmWPgkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 6/22/23 13:55, Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > In Restricted CXL Device (RCD) mode a CXL device is exposed as an
> > RCiEP, but CXL downstream and upstream ports are not enumerated and
> > not visible in the PCIe hierarchy. [1] Protocol and link errors from
> > these non-enumerated ports are signaled as internal AER errors, either
> > Uncorrectable Internal Error (UIE) or Corrected Internal Errors (CIE)
> > via an RCEC.
> > 
> > Restricted CXL host (RCH) downstream port-detected errors have the
> > Requster ID of the RCEC set in the RCEC's AER Error Source ID
> 
> s/Requster/Requester/

Thanks, fixed.
