Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF565CA48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjACXWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjACXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:22:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DAF2601;
        Tue,  3 Jan 2023 15:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672788159; x=1704324159;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jKbn4M2b99bs6UFxjjOtnca9HrwyfSuOsP0yVvtpHUI=;
  b=MYSAZK4LwZnV/05DegbvkUkJNq7E77vxq4dlHO+30xKJOHpLJVaSHBRo
   i17KF3Z3oQ9uisjGZvlLUrHhOuP01x8+Bj1YcNLPbmUPNYPU27XnqfYRM
   cp3lCnXfGD8sc10p49OMCzJBUq5/Bc527lvqKbHh6fMqKk9zfZ8upM1mM
   tJ4Zj27jW9C2IB5EYgdFPSs9c/bvbwATvIDlew6ksOnEVn8dUogipsc1e
   xZIXpOZR2FPJCwwI69LJBUXL5ThYEK7KzJd64N57KcbP6+wUEMaQ1DkF9
   +wsC2CD77fs9s/gsTl7pOsfV11ysiEfcqqc6CfbTflw15UHnJR5Q39aW3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302155955"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302155955"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 15:22:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="723435288"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="723435288"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2023 15:22:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 15:22:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 15:22:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 15:22:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFiqVsDIIgo3RzGLgM5EeqPO/i+xAkN3Ycsw0tDdWRGUf1BW+Ow9V2QOA+kkNMfcEh21qwTIi2/kEvIsolq5X1tYjngnU7bQaC1Graw20NrXLlYWtL2IPVxx+7Ray4j8aT6GXJY6EBj5MEmUJDy4yBhRHXzguzcIDTQnkYt+YnOxYvTDrIrXPCAshGzb1AwHaf1/hVrdvB4wGZ86PxRJMY1f1v6IGoUtj6xZvJhFlX4JJLLJ+riNc8jwycjUPcw0ETPJXbJvwsq+leRAP9cPiL/YKovwEuV8LV+S6oprCFwKDXg0BXzOTnvq+vcRmGms9y6/K8rD6B8elkeUUB8UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKbn4M2b99bs6UFxjjOtnca9HrwyfSuOsP0yVvtpHUI=;
 b=lKOLjyO8H8AwzsiRSQy1MWlnSdnb4sGZsNljG0rv0oKW1KoGlly9GBkxO7wpsERe7773qWXX1Whgyi7lT4q8uNinHxHu6MRcCH0gGtdBDODAW9eJJ9oUuJB023bPn19M/XwKt0gm54bVZgDKWJfVcK1ho6+7k1mg9uRSSTjm20W25aeDuMzlQbFiKBQtW28T4tpySjwD09Tq/aMsZdNBXpZYYFdQbUcq81Bjnsc7Xq64Z6S4jN9QYBXsPcnLYJrc8cCBGG7JahsEL/bpCGVxl2amSYgFRzeaSB9/CuWSvbeHJBHgWrM/ymSKDX6q1DmrTyg0lpl9/d8+SEnUyfg6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6345.namprd11.prod.outlook.com
 (2603:10b6:208:38b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 23:22:37 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 23:22:37 +0000
Date:   Tue, 3 Jan 2023 15:22:33 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/pci: Show opcode in debug messages when sending a
 command
Message-ID: <63b4b8b9c2adc_5178e294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230103210151.1126873-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230103210151.1126873-1-rrichter@amd.com>
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: a1556482-0b21-4be8-0f18-08daede1667c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHAlXx+1hozTh1o7jtPaPZ6wJ6FDurF1XE1PlepFxCjcl/SZQI7RCxKZcBYG4WWioNIEo1Jv2jka2AOdm3jL9ynqHquLEdBnbrfX9/VXjqMke2GKx6kw6al/CTeiRPEK/UmZ8eVaQT1DT99jppWYFOZony+29tIMJf5vk68vzb1/KMuc5grQ9h/uKeZT0Y90k1MwfPJuwHmJJXfLn/VCaDc38m5CTiugAV/9MDgDsnGVqHrloYfPauISDIDEW9E1XZfKSx7i+8c/Kw134NP+Y/4Uhj22yhJrNrjfm1IzsA90SckGDQkF2IWjyHR01UV/vnCWNOQ/zAsTA2sZ4SzYz0LEZHT40FQ1+RoWgiQhr3icsnIvCkH4vi8ML3T1IztGkY0HytlH38SRVJV2MFQMPP3/EKYj5a9q41a9eGFkYpXik9X8ZlNP9F+UUzp3otXjUUOdIMi7pjT2D0UMPVamlFbQnLhg5QIlGNvGYR/+sJR8ouRcFKB7XvveJZmItXwPd1Rf3e34wn4SYBNyntuoMgIzlcQ7peC9A4iGIw/bBhm5e36VtvqajxM1AVlWdOdMO3dOOVnFQyeU52vzUF+5+ejm5LMMmbfgmdql7p9wOyqmIyOI8vWDh+4PlbHiQL0w1SJzjb29cY4O2abVWneE+zezqvoeVNe+KJ5yVp9uqGGZGcV4CZDt1ulLoxcRqk0U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(558084003)(8936002)(2906002)(38100700002)(15650500001)(5660300002)(41300700001)(83380400001)(86362001)(110136005)(66946007)(6486002)(82960400001)(6506007)(6666004)(8676002)(66556008)(316002)(4326008)(66476007)(186003)(6512007)(26005)(478600001)(9686003)(22166009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KuTslN7zA36QZGCNgq4aNFOBYOWKainftTzOMqy3hBQ7tD9uMF0tFooTqZ4?=
 =?us-ascii?Q?PppPLmW53E0X/dfSA1zgd8y6Gr4H8jrJ8rJCKI+92beapXGeZ/Ci1dbVHIYh?=
 =?us-ascii?Q?OOtafHSnRvQr1Rd0sQRz4YIeS62JEuMDuYwVeWl3Bleb9aaqkN/kbappp+aB?=
 =?us-ascii?Q?XjdzrbXNqCSxNL3DuGBZ9yTkwFtTDTPqd7AOxASQ0XG1Cm3OqtaPDe2COChd?=
 =?us-ascii?Q?Fu2S9IXYYP5dXS/hqOJElKBVzUh8/brrGQQDbv9V9k4fM5oVgtWwjklrAKVE?=
 =?us-ascii?Q?O23ZxcpTuWPAkpjh9XOuUDIA2g1m5cLQ2RdqCDiZwTHl4turCmzleS85LCg3?=
 =?us-ascii?Q?IS20ZFEG/Wo2zvof0WVa68IkslwxAKdK8X3nV0FI+ZPGk1OIKGClV4y3Gm31?=
 =?us-ascii?Q?nRCYzJwRZ+2bE1GIGQdlypymceEVBLD3Hfr7YGN8sgDJgSXUUeXT9VWpz+0F?=
 =?us-ascii?Q?zqLZiFXUa5a7p4G6OoWqpEB+KN0VHCbEPhEQI4IKaxkf5eWeXa2caM3rDhNl?=
 =?us-ascii?Q?vC+o1YtWxkc+nEU0hRSP8NJ2gyaD+lrTX8xrfF+/yCQhnTuX+5OVBbCRxjoI?=
 =?us-ascii?Q?V68Mp3vuYCitqaA7aaixHJr7HiSOmSKAe0HkplIx2GnhJ5NzcXZ+WtT+Sq6H?=
 =?us-ascii?Q?FrIpC0IdAGXCoufuWB40cU3hU5KQPlCwLFyqfzurdDgSYmxV1DckFIvml9cj?=
 =?us-ascii?Q?y7pGUd0CxWbT/qLDJElXJl9nef0ZhzJ3ABY6L2LgnyVkx1+dPDgSsWJDY1HM?=
 =?us-ascii?Q?d1drpF0gUiKTfbvG6bdQRGLe1sS2x02uyQOF4O9uYEi3gN4BH5b5oQQjoZMh?=
 =?us-ascii?Q?w40pDQDo+xBSyQWrWhg5DWJ05NcogWakX5dxVDe2rzujZjPKL5Nnah9OlCBu?=
 =?us-ascii?Q?HK9w3hGHWbrr5Ko+HZUOasFB5IBN0/uUILv1Ks0tip2p5z0gRrVcjWNcQ3QB?=
 =?us-ascii?Q?VbPq02Rg3fcUZShHdcFkuop2hjfeq9g+1oZKeCIgblFJV31h4pDa7uzG44PH?=
 =?us-ascii?Q?VRAhBdHBy1thEwv9Dxi+Lcc1lmTSbj0h/ilhGHTLrCxsqi3Z0zA1gcuNrr31?=
 =?us-ascii?Q?YYRdK6L+zSmZkZ4rO2sh63Wdh7GFfGWrZxpqDy/sxipIxF+gIyzYvbPePLNn?=
 =?us-ascii?Q?xbD80gC9p57uERHePaSDEkGWVg88g+mFoX26FjFvi/wkUK4kY7lGPfLbqbNP?=
 =?us-ascii?Q?YegSoXxFrPSBoGNz+WtLbRXNIKV2mZK8nTAuaH/SVx1w/F3Ig+NaU/jTvRn8?=
 =?us-ascii?Q?oKoKhX6Rofy+GFea0hYXi7qeKPB33bscLpRMAgJweB/aJI7sbTNStBvm9TtG?=
 =?us-ascii?Q?lcJ1q6GV7obO+SB+JPoyP3nq12++aT06CBzYlaAd5ohRNtXdJGvuoG4OlqYm?=
 =?us-ascii?Q?/m3GUbib3eK81lyj3mE5Kg8IZKvqNuaEPq8kUitZ99oB4ueWwaXZn2nuAK/u?=
 =?us-ascii?Q?DcNEdzLyZTJUjr+CaXbA1bTlCc7hPMNKhDNKNzdVl2UBa99+UYG3bToynIRg?=
 =?us-ascii?Q?croBTJWWlCfUXZ1XJZnektJ9gz1QOGJ2SFP/RIzn90fiwV+5OFohkyVDiP76?=
 =?us-ascii?Q?WbYNr+j2Z++TdsvAAGva+d8i8C6JcBAH5Hc7eQkCKuFMkDeMpIxGpb6ylzy4?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1556482-0b21-4be8-0f18-08daede1667c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 23:22:37.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zhghsla/H2gA57t0Y52R8DC+iLnZILD3SmMstvLYTeAt8ZENN6Mtc1RBJC0TozxYmgUGgbMPRS6hg70WplLd+x+X0tXegBmgToMKuo0mod0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> For debugging it is very helpful to see which commands are sent. Add
> it to the debug message.

Looks good to me, applied for v6.3.
