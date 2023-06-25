Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7620873D2B4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjFYRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFYRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:38:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E306718E;
        Sun, 25 Jun 2023 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687714714; x=1719250714;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8wqNio7l5nChw3+XmGgw5Tf0aA8Lk7l4ZWl6+NK556A=;
  b=ewWQjqcDxRN+sA9JWKulkrP6PlDSmFYZIfAzmBWEwm2IqLwhDu7TlbSn
   2+wH3214WILGlUnLoGbmuCOc6AqV4FakCScWjzaRCWDvaK9MaIU9uHIgU
   RERScENTXlfCXXbQ5bFkFIFmGjbrW0gs8xCCDhioHHQXWaQiktYxNynfr
   zXzQ45Euo/90OPYnQsf9p9yOPcQOi+GzvPHR/z/x0oqr/Ia2boRv5tRI8
   YbgHHqDPkeuVUE8FpAjSr8+3bXAwil9v2ksecZh7qBvhvbQYewsf6zB9R
   XXih4aHzYFsAtEpiCVKEC7eDTjUnXJ3i1QYYBzYgRhnFmtCZKZmDFpOZl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="364544431"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="364544431"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 10:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="1046235648"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="1046235648"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2023 10:38:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 10:38:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 10:38:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 10:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lToq6ODoLR51CuHaMAJht9lf5buLGKRA1FVPV/H3Lyf8baNWRwh9C0JCnGHKJ8UU761GC1BIgLAt/kG/VEMU4enmFbz7bW+dpkv0+F1PpQ0K6yNULvnvnJLLFEu2h0A7dx4nWuSDBatHzEVQmwNT7x+FoRipxlb1PIBVTDZj6QMiGIknIFHXILaoVwOWaacCbfZWbL2OXwDwKf8dMRpJ1bXIewk0bpH+ss5C5LrR2GG8DkiUPkehxTexamPptTTNoedOLE8YXLwI1GOUMFHBEIA4MxigO/6jmhwYoBp2Jpz5x6hCTRpcrbhmjFaeMbSK9pwQLXHLo+newxt5fw6Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQvIXrlDiKalhTRmHwp2jhwAifBOKEHqLrf+RkWrpLc=;
 b=OIVFcU5SpWnedPVgYIVu1u5Dg+b0egVQyV8O+11/ieels6ri5MZu+g+IrsLy50au2pYl8k10GRhnMFWfL+BZ5ZQl50M1y+ITQGprF5/z+/mIUKXWsHX0JqXqOhQ8IIEHQc2ENniBA4/lRJyFEAAVYISwwv9plpgex8Er3IYqYc+4Gja8zwMgdv8W2e7V08aAOI/yi9Uwkywa9KBiJBsiM4xTDFylc0Fr57Cn105XSKZd/693k3m6Ndt1RrpmbNETMUgYr56+reJ0IuakmOBJy1cJ331bXvvZVny6htwvfzosbTn/sfKYBZ4NNN2aDUlc5nAqArj2UUrqQHFYJ6fDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 17:38:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 17:38:31 +0000
Date:   Sun, 25 Jun 2023 10:38:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v7 16/27] cxl/pci: Store the endpoint's Component
 Register mappings in struct cxl_dev_state
Message-ID: <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-17-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622205523.85375-17-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed337e9-52de-4942-d913-08db75a2fe0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKkccl5KwXqOQB+zxoNwM4RxwSjIKqIAaZg8Y49YmSMojompG5YgoJnLSWv5uB8I2PIZhIg5aTBimuRG4WHAvoxHjHI+wm17J6JrpScOA4mbmrse8a5ZflMM/LoHrqMitTVpZIOvQqJfHnIR7nSId0wNLSlMK4lbyVg60nuT6ZfYz8+JsGfwEtJV68+a0SmtFkYQ2XqTa7lCakgvWt/BP2uNgZW5oZpEfaQ/VpRGt0bxXq5SZuyosOXjXTrrAeSycoib/VxFCsu7hQXA4zbAqGO4zUCAB6UZrKz3rr8piYkm7YVeM1N59EagEo4M8rbzePPGzSHj91G6ecqinueVI5hxycnijs+JNiqJ6HumEKFSpnJZv/JzXJnJof+Z1yLAUGp9eFveXZlic3D3+AMibT/XuP9TMXS1mpp/8CLEvAISBgXroc0nIfEv/MZ3ZObztIMGR0XVvoNlhfOv4ZfQsiZeC0vJryRib4xAdzuByRGpDCuWCMy5QP8sfE3MualMAL0yRREvAfPXswNAaLY4DrNeKAuszXLdjMQATPlDK2IEnIlS268a1HwOvwjh7W6x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(8936002)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(316002)(6506007)(9686003)(26005)(186003)(6512007)(478600001)(6666004)(6486002)(2906002)(5660300002)(82960400001)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w6xWw+aSs3dE+YC8pW4v44OEQ4BdhnxE26C6+hPmKfRpwWiIO/hYkvEOJOqF?=
 =?us-ascii?Q?LoBnzt4DFBhA6hX7T5tR4gZ2A5TZ6dksGVmGRrzpAejfNqRHx0cTHXCPsiEJ?=
 =?us-ascii?Q?nFunIZjjMNzT2FWRrWdxta0JSAqz19zzHOqiHY5M3lbM1TPVqEt9cKM4gbCb?=
 =?us-ascii?Q?Uk+OvAai9i5lLIQWwtP5YykyDJjC8vJOM7xy14Acow5MSXTWUBbzySEkdhoT?=
 =?us-ascii?Q?oEAyLvN8XKcVAWXuHK7VL0IquZz/jSWhvcQqZe6Ijd8lcDz/9JKjCbKFOi39?=
 =?us-ascii?Q?H4XfuAgv/AkK47qAvtsbpHWhun3XhrnXdgjelnPC3Q9nTIUrAZf4NqZ/6KmD?=
 =?us-ascii?Q?H+V5MsKCGWLBjC3J/HqDEzURR2lN9AfMUKpMz+vflcLibK4xkpLhJ/K2V5Eh?=
 =?us-ascii?Q?drJG1YMofDtsP9JaT0KUFTm8H2MOgJV9R2kbDIuI/30V4gQjW328LWEFVJQF?=
 =?us-ascii?Q?Ms2x8U0JUD54OjZvOadY5xwyfhjsFrU4q9yu4gIqPjZnzwlzKmLoKK1N2IjJ?=
 =?us-ascii?Q?7iWU49qswRKFDxExfRNSA4Y/5ORxzTybYgvwL4l8elvN/3NW1ud6jgVrWZLs?=
 =?us-ascii?Q?Lvt1u+ORdqRpJokVpPudwG88JpOFydw54mvoouetgWurgQJtdkz3uv7U2Uyk?=
 =?us-ascii?Q?1IyxfSXG1qS7UokvQncwM+IQwCm2rA+0+HJUOpQGjstm1WdNsLTIFJpACesT?=
 =?us-ascii?Q?gfhxWy6E1kTQB7s8crb6MznvTIXtR6JB11pO2a2bfkZgUyLJ7VAlrw9sFAWr?=
 =?us-ascii?Q?J3BwjUigfUEi5vQ6MN9PkrcSXr80+PJn4Ahgk+lqpKKzIgu59GReGdYdZJa6?=
 =?us-ascii?Q?EDD5ElYjwiaLID9ITQqzImP8oMFJNNieC2LL/OIVZseai5Kz9NiQSgGFt7ff?=
 =?us-ascii?Q?lR0LifmxhHt6NaFBdYanPnGPsc+gYoGRgjO5qkOf74z9fmPMNFXuShg4bPf3?=
 =?us-ascii?Q?xc5BBpPQ78jwo+qHvbKxrd5F4A5f1voVjMw+x3xR8CAN9wu6Vs9DZbz+6Km6?=
 =?us-ascii?Q?bWZB1E2hM3xQi4ffkMDjusyRTLEh3yDmaZ5D7/kYDNiz7xnPWvoJqNn9mehR?=
 =?us-ascii?Q?z2NziSd8kIb5ClPybAOTKqqRPPGe02v2WX58EsHUTuGIQcmhYCQkF5IhZh4j?=
 =?us-ascii?Q?5/z9F3D6KLlY2jHYYTzwP3dQl+x4a7SiLqBs6uvC/FusTMHtgFJqqp8phI+8?=
 =?us-ascii?Q?tAdFKpBLPEo31dAnZQlmJ91ngmXMt5WX1O4MPtrJM0ChVOi8EkjIKYUvTb6h?=
 =?us-ascii?Q?0GElTyu3DkSdh9lsqN7kNk2Z8qJhHaI01bIEGtM6+SF5Z9SgiMdGo8JzDqFi?=
 =?us-ascii?Q?t+21DMDfvG5m0Dy8VQdX72kuiPtDc71HGoNZRikPyBvkhIxkUpCm1tS4uus8?=
 =?us-ascii?Q?nlTH/DQn2dP9Z3Ns552NB95S2O3DFkPR44W/qy422+ScoDPucsB6jxdoCrzw?=
 =?us-ascii?Q?Df529mIvr1UZBP0BUAVcODYcTVVvt2SwYbljuxz4JHcYdvW2eN1I6dqbtc8f?=
 =?us-ascii?Q?YSpuK/qb0xQbt0bpcQBJj8ykN4AaiKdZF7vnB13/wRfBUD4jkvwsjs3uTgrE?=
 =?us-ascii?Q?NFlxpKlRYG+4dwVrYHTJDB3IMcMblmyUCc4gKPJZBHxXSkszwCGGCYKEOUEh?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed337e9-52de-4942-d913-08db75a2fe0c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 17:38:31.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dls/7BYCOsqVlW1VDLOvUI+M/0A0jYrfywOch6iQXCRq1sf5RFlQx3q3xTNJVbyk/Sgfgks6nbIx7eqOIP37rpTjRbPEzyAh23CCUM2dzCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
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

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Same as for ports and dports, also store the endpoint's Component
> Register mappings, use struct cxl_dev_state for that.
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Starting with this patch my QEMU cxl configuration fails to probe the
device:

# cxl list -Miu
{
  "memdev":"mem0",
  "pmem_size":"512.00 MiB (536.87 MB)",
  "serial":"0",
  "host":"0000:35:00.0",
  "state":"disabled"
}

...the next patch changes where the failure occurs, but it still fails
and applying the rest of the patches does not fix the issue either. I
have not had the time to debug it. Please have a look and make sure that
at every step of this patch set the driver is still operational. I.e.
'git bisect' should never find this conversion in a broken state.

For now I will look at proceeding with patch 1-15.

The cxl bits of my QEMU config are:

  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=cxl-window1,size=$cxl_backend_size
  -object memory-backend-file,id=cxl-label1,share=on,mem-path=cxl-label1,size=$cxl_label_size
  -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52
  -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0,port=0
  -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-label1
  -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G
