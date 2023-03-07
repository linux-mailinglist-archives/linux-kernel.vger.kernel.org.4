Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1F6AF6EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCGUrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:47:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2855068;
        Tue,  7 Mar 2023 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678222032; x=1709758032;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t5QWckVImj94fX6cxx0vvsVQ0ZQ6I8rQ9TMTOWz6v1Y=;
  b=jkqwFL5Fj/LCgZ/5rGTiuj691CvtoU8TQCVRQ34UHEWTZNB9645iZRiP
   HbSbfPTNTzwmwNLkmuvd3AibcjAUQcD6cWntCgeMuBoiPgHTZwsof4ena
   3Nyp6zLhC6ADkV2DpIIt/xDEAFAm2hRBm+KVswjLjy9IiCKaylttHJtpQ
   7fPZvyIiuMgFy3XBq++/V4d8PHzSoY3ln5N1aQfHL80k3A6nAqHSg0C/F
   pWqpcwrzZ5XJaqjdGsc1irdq6a8F7DgFBV2U95sUlW9i3TJTqOXj0r9g/
   xUdBf7+rm2DEIrEQcHjqrsNyWE3xuvLlOxx11fpOGOKsJEHux5zjzkCqJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333440307"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="333440307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="786832270"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="786832270"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 07 Mar 2023 12:47:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 12:47:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 12:47:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 12:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE0+kVqYSlVWjkI2eNyCUCgHU6mCG1suRZguYQHPsBcDvjEDzKn31OobbD4ROMmDwJc7T4uzBdCIbY85yE5mf7WvTixJC4X00rHt57CcTPe+CSS9u6wXj6XZz9p+fAJwycMliymaZWrcsMfbJfkhOE8VZ4W6Sk7Oq+0LZODHqPQ9amZPqURrwuYpVJNFrCy40tvus9U3oBLBFNo4T07gHCXz2Hzys6WXdxQsjvfw8pzlCzMcjTi8aBl8YCIb5QHySPRKsyuNF0muAFAUoQ1ccRQiGl0qtDkCGG6H+u+H10vTx7CQp4w2hOQkMxmmjH6GZ6hPgIKNRxL6naHptrhfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBLr84O7EC6IiYv62IBNfVrwTuVIREd5RxZ7Q0AIJAU=;
 b=gCEOuQKFpP+x7UXUh9KzJceborjHoOrXBsek9B24DMLeaUuajTNtILrhXaeytNp4vdA4qLoEb0j43VcIXqIIHS4Mre2hf8wduiNN6mYr5mHdPRIYQ4ZHI7eHssoEbcvatx7hb1pioWKn3lSvF6JuEQWMkLwr4Rga3/d3qOLVSIWFH/if09OWxFgaIMGtK+B98ysY2uwSyNnjDUj+EuaXp/qj11k9dBQiHCjued7Lht4uUjM5XXbrRPSWUYrObP2mp7MsFhSNyAZFr2BcdVXEDvQ698ZkUweG3QD+NeaW3oXJUGbqwqJ5EzW1vtwmSQsZsW8fctIoYd1+eaiNOtqy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7324.namprd11.prod.outlook.com (2603:10b6:610:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 20:46:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 20:46:59 +0000
Date:   Tue, 7 Mar 2023 12:46:55 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl/pci: Remove unnecessary aer.h include
Message-ID: <6407a2bf56a99_a37b829417@iweiny-mobl.notmuch>
References: <20230307162443.858052-1-helgaas@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230307162443.858052-1-helgaas@kernel.org>
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a98f048-8315-4a80-f511-08db1f4d187b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrC6Ndzw/p5QNOtLpwrMzjAUdsUDqTQXwNZFcKayOaOaB8GRMrm6z1aMz5YoLu10OJH8OtfD0GExcSlOyapxa4uq8EsG3IVhocw+6Zkcdf0kUXHQXJ6RY6yULrn7RqWShHzd2NEw+ThtNgL2/Wf97qRlRa/eZgaknXLXMO2pWC9dIxgwIWtX4LpkO1O32a9peYDDt3g6ZiQGR8nXjOghSocwhxDA0lKrU2CXJ002NHTrYcdCrLeBc67nlKIFfO0q8cKS5z9xT5nxi1tOgz9YdK+f2B1Z2zZL6eiv/FTunWJqqd4R/pS/VgGGUKwzHOTaRCJVPgdAYARsAD8EQQPR83QVzTn47Y3GCIUn7MJdPI3JcApp0JodzyOyFbadVp5qFfzynuj5IX+/F5rlgQBafXKs0/4QyxMI77LcRC6Fo6CL5YbLfxwZew7Ny3iplJ8LQm03BCD+yBe9Hl6nibkKk+86deyDnnDgjjvjU1Tj88RPZp708RtkGczbAH1HBPQH6TlqWxTFtTbDVlX/O//yEwJL0V+XICkJeBS4jVK6dKMdR/ypGKxy974hZtYkwonMnntPlB2oFdKDXkj7613rO+dyCbN+6S6oCyfCjbkskLbftDaSuXi+hMKXRzGc3vx2PDjIsRQu6c1OfXXiaPbtog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(82960400001)(66556008)(66946007)(38100700002)(66476007)(8676002)(4326008)(316002)(8936002)(110136005)(6636002)(41300700001)(5660300002)(478600001)(86362001)(6666004)(44832011)(83380400001)(4744005)(9686003)(6506007)(6512007)(2906002)(186003)(26005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nSK8YrMvZrm0J+9QsT6JPrudIY3wyagukFbasZefUYNZ0R08s4f5H9Isqpit?=
 =?us-ascii?Q?sgLXsx4TTJeXpEC6iN2towre9q+GKukS4vzWf94OWMcnpF2tQwlkmsrJU6/7?=
 =?us-ascii?Q?Ugsf0zUHvBk7C/YbaF8GoW3rNOhhLuGE3tpW6NS14IKCq5sZZ/2TNvBqlt31?=
 =?us-ascii?Q?CAgbp04LMivXb0aOGeayTj/oZ4ZANrs7KYLYTf6vlrMimw87/m5dMVcxI2Lv?=
 =?us-ascii?Q?ve4EKH30e/2ZY1yBt4xcATaIQb/dmrlSNbMztU9F2zwc966Lj9RGvatxqTIh?=
 =?us-ascii?Q?kDHi81Tw0JbOHztiw6qhP/0/Q1QpZqCG7/ljhxJ983cSVJ30w7Nw8XCRnEwJ?=
 =?us-ascii?Q?zgDZOhVmsO4Ykn39tZRKp94QiCV/yYrm6CiwqDFyIPjRBnYBCBpNhWin1r61?=
 =?us-ascii?Q?2OVfLXIJGSkxJWNmgxd4196D4QGhzry3H0OkQxJ4eec9m41+g9xOEExBoYS8?=
 =?us-ascii?Q?Q7+p/ZMqVbXNOY/wg6Oin5fIqR5g3gXi1mgjKjqIoktduFHP7n3lAppE5LFH?=
 =?us-ascii?Q?vKwYiHbuIMsbk8XUvOFtXNeailr4QuRKIPjsblwmP9Nao0m335+0b2P9+l7I?=
 =?us-ascii?Q?lEIc3rtlNNBZdPnPOVkkgfbR+CnMAUQNbbbPwIpxgNrIT//3mz//HagH1Kg1?=
 =?us-ascii?Q?wReJRQ0K8a5Fl7V6Tllh9wDSTn/Y7FOsegP81Jt0KmdOhbRBuU4WXNDcufJn?=
 =?us-ascii?Q?Ag43rYoyVMiCGXCNStq4BmPinkfhjHjE9qXz55yNe1/eYaxtn8aFcjf/xQH2?=
 =?us-ascii?Q?4ryaGIJCWcat8v8d/W6/yvesjmM0gCQZPIPoI8Nj+35DH8XVL9WoMAHgd/dR?=
 =?us-ascii?Q?w/M1Pf2cePVmPPO40BSDiYF7NYDSbwEMXbBh6zAuWw7cKFVf4xSz8FTLpD59?=
 =?us-ascii?Q?kkJ6KZQRx4ZIwX1zxFRbMKarni+pqa8682W1MlUlc819Yg3u7j8PZ7vNpKr5?=
 =?us-ascii?Q?FKodUN/iIhsin4gc52zGpvYOMLtfUYujmfiWUU46ihSEhF9tYw+ZMGOv5sf5?=
 =?us-ascii?Q?AMswdPVr3FvDC+MOvI4fgiXus25fzQWOPfx8ngQsRxUoechmvKZyXPG1O4x7?=
 =?us-ascii?Q?/zgRYLfTl9ig26C3tgg/bWT4KplHUgAIjviomQdHeSIhThkWjE8WgGlUICHP?=
 =?us-ascii?Q?r64AZ5aWJOIoWfn+g/SnPdLyDPrP6LcArO/QH7srbdalMEGWYrMbv+RQAfJO?=
 =?us-ascii?Q?TIZhHBLUs39s43XJNJ8SgTinavKtuyA3jMN322RD4JcxUwU9yEglHCcbQfPL?=
 =?us-ascii?Q?6IzjAsN5AOSFMPsMdmmhlSxzjhBfV7ZEhEtqIrI7nBZwfTSFTaoyc9SSLQbc?=
 =?us-ascii?Q?yFGNgvxnudX4TWznNQaiQAO2Bbk4xoTmVIXiGqXIAyF+ZTuaxq1WcSI4/rAY?=
 =?us-ascii?Q?7StagYKmQirPHkcqFKjChSPSZ4V6sRHanqEGHi+Ogw+4biADT8RqSrw140ho?=
 =?us-ascii?Q?KEBFRzZPwa+O4As0H8e37ZjT/fiM+XhpCbqgQgGJuHj0UwhamgHQ6g8ZCgEK?=
 =?us-ascii?Q?mNndq/51kOjhQ17pHP4Ery3r8mEtZExOmkKnRFxylUaVnvzXwHdj1crUEmmz?=
 =?us-ascii?Q?0XS1xLWSs7XfK4up8zvlIg6Qs8L9QvPRN7/LCdX3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a98f048-8315-4a80-f511-08db1f4d187b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 20:46:58.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFeMv+yCY4cNv7nvfV0YYjy2Sy5eziXZLHdSQEmd7e0B28HwiXH2YxxGv7RHfhtaqRuxFv/svsLUWxZIVP28LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
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

Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/aer.h> is unused, so remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> ---
>  drivers/cxl/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 60b23624d167..d3bc450717ce 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -9,7 +9,6 @@
>  #include <linux/list.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> -#include <linux/aer.h>
>  #include <linux/io.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> -- 
> 2.25.1
> 


