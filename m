Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825006C7671
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCXEFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:05:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837216327
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 21:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679630749; x=1711166749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YCvk7+C1uAgIRskKfKSfE/1qRnz+A4J15JjmcaP5CLQ=;
  b=BEGx4ZFzc+UpFjVHM+ywsvtOsLL16Oz09iqoOdHbUbEQFDTLCLEy9RdG
   YRDVp4AQWeB4bjTZgJXPi3XrH8QUqk7VtMKxcZ7dXtpOLm5eBff2BuTiC
   ylglzYYvXyx/T77AIkU+DgRm3HbuDaMywfYsXcnu77Jm6I+4NjQgRNqf5
   F6cMxsQIwtOWD7ae59StPgyn5flQtHJA97m4KBa8ZGYaT+SvXhYXOXjfm
   bSIAmwgtQl+9s3xH+GTZy5Z5ZOBMZCqHKP7xtDkp6dV38YSkTiTnzHsj1
   IJF70Bfy56CYF1ZAQIpvk5bsH1gV/sTVgEJcdsp4QEq2rW5U4Y/qhQQWp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337198408"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="337198408"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 21:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632688712"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="632688712"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 21:05:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 21:05:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 21:05:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 21:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmyXl+uWw5XkKy95R7WSyuIdPEiY/QGAP8CD+WGUF/ZoCDTqc/tWl6HK7DKxo4vM246v0suiO+SUZhltgnjO/md9WGU6E4q1e4qggS9bHIf6tSatoQZAuJff9dNW63bYPS6Omp2hn5wgUKFR2QASvNc0+RWlhmZ/AVRJ2ngTtCZW9zeASfcDNhKJPBxEgAK9w+Ni0pvHgv2VeC21oNWP5vlF/5t//BFo5SK3dFg6qHsetGVd0K54ndYrdaNOHcfobZnyyuF26DrX4rAYpefmPUq2N8tRVAlOUI/IuyaoRXGacEPRgHn/TlSTALx3KTPA0+VGneGT1ZNx5xsvxVWXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw1UF0GeKL49737+BbvvkehHyUn1QAYXeaN3AHEaRBw=;
 b=CpGYBB3Cg+7YdhgUJahZY9R0jrTyiEoXPlOgc54S30zcGVaMsU+R7wParg2MT0L5SU/oE7xJ2XMuIR8jdlElu7/rNedf2l4HNgZufK8w0QaG6D+lEVhjMvBNuzhDwEsmj19z5bR7TfVKTUtUhOkyhZ37mR3tImqQT/wv2n3tzV4E5XdBoFJf9E20tP0b6qCyU8yMXu0gXGv4nZnA4LUnEj4lz++mDcRTb0gmk3h5kRLZZWQgFklaTR1Goqiu/FpU1xpCkqVZrAr4DJI5ue8iJTVOxhEhobUO1PArAnC7PyLQN6eXDhC1MXoW2UoeKcy7N4EF1dhv9SxV8/EIiJgAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 04:05:46 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 04:05:46 +0000
Date:   Fri, 24 Mar 2023 12:05:29 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <ZB0hiXUaXQ1v7r7O@chenyu5-mobl1>
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230317160810.107988-1-vincent.guittot@linaro.org>
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA1PR11MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c5c484-e6bd-44e2-1a24-08db2c1d0b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1X8B7qM7Nua2EOyYJTFc3oqN/7XU6qtgXXWwKrIhYixeKVww0PdAWlz2WfG7SZkfTohCV53QrYScomleVrqy89IZUb1aiiwEWsdnWPPE8PLjAoo/uz0n0w4tVCkhfQ2SGzns6wcA88nMDH3VAY01awEz5kaYNS6psByKiEA2PO2v4seCsa4hFsTOM6009em7wnVYQrp3Ez/xr6jWms9Csbfez0rtQPqJNQM0TApquDpnfqpxHZLE6R0zZhmpP0BkzuzFLQb80ARfeVEUo5u8f8tOwpmTFQbCXaW4jSfscyoZNcsX3YQVYryuLocoF7P3b+SytVCw14XE8agUroH2vn4eDdXOXPOu/SMwhDzryxXtX7f1e1IKRh3Tb3OluZNYq27AwJmi4NG3RnsLoTN6sJk1wpCnck+53sEiLRg5JjxSIfMDAP6sRu31/Ly+wofZdfTGXPv+tBO7LJDKxgBg6xyywRgvQMtzy3aq7/DA3f/0jOvb/JkkKSajIbXT2W9HsslHNqMGJa7DiFiv//ZFFM5YKnK8VgBq4Q0ehcOl5ziuV8ZGGkHVR4IG/upISssyrI/9pkPJdhK+VHhF2xnSLgh0o511TYDRbPVzyWhp2MkNjUkRMcGD1D4bXWdIVy6O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(86362001)(82960400001)(38100700002)(41300700001)(2906002)(66476007)(7416002)(6916009)(8676002)(5660300002)(4326008)(8936002)(33716001)(66556008)(66946007)(9686003)(6512007)(53546011)(186003)(6506007)(83380400001)(478600001)(316002)(26005)(966005)(107886003)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?znLInJax64c+UVSNcqVXSxawKEOkBHMh7E4pe5oD/q4Q3ApfQ825nTMus5nS?=
 =?us-ascii?Q?oWRKU4yR1Zf+qTJU5AaT7GRQkwf2vRnX1bneXLv7dihJsrBpZoSp9SktTkGd?=
 =?us-ascii?Q?wY227e8F5J5m37BzwXTGFn56ULu1BANQ/nFG8U+PH6USCsHczTDcBGO0j3BW?=
 =?us-ascii?Q?C981OYTO55w03IQMMFYNyFghNTDzV5utmmdRLrJcTmZOQ8+ASRAJ64einGit?=
 =?us-ascii?Q?7mdfRp5ivzxBH+WMQCvFEfa3gpei2jkoikg1mdnOxPmqiO4ELnmFFEmO+HIM?=
 =?us-ascii?Q?oM0g2e8zcf3Ps5RQx8pD0M98TAfPZ7+dAyHe74Ahdkv3a0JPZvdKQ0NxHu/d?=
 =?us-ascii?Q?hnl8sviI0vo9zNcjjdBLp6ywTn1f1rM/w/eFCZSGuPgtUdl8NrMOGxSRiTAa?=
 =?us-ascii?Q?GBr36wFVLTZnOFW6zSvd2idQkFbB4n0RGfWby5Yx0zsZEqySQ6fzzffhZr5Y?=
 =?us-ascii?Q?9OMdbBYbrIDbru+ympfYhRetX1Fr2oIljHNXJjds37AA8afiOxdU3YJB3fiG?=
 =?us-ascii?Q?zinE25Umhmu2eKWXoB6MBZGLSzYhWFvYsn35TKvRDiy94s64VqwM+VB9M/QV?=
 =?us-ascii?Q?KRc2vJEmVR4WsL3FtmZvFIpVl6JwIs8h6/Q2Npp0kfvHQFcbp1s4OA0ENTs0?=
 =?us-ascii?Q?AXp5IGuXEHP7vI/ZgmcYelQAmaH1NcXO0/W7eyOAM3OwM0JestvkvV6CND9U?=
 =?us-ascii?Q?zCW8vM4orW/E/ZDjgWyqcyFnZ+OLUSBz/vc2J0SceIvpYxLoGp5TnwHtYupE?=
 =?us-ascii?Q?OctILurRybJ890gjgdJhNJPhn84GQrLmMNYhSxXtIzYe90b8Mc8hqF/BWum1?=
 =?us-ascii?Q?HeCYKJtQ92Uk0kzh/qwcZNGfsaf9GOBqrL2aDm/w1/lA5SUCPYYUZkUO2QK8?=
 =?us-ascii?Q?UJ9J9MCExe9/SnvdXo0iszI0vblvf6pIsPVddb74e328OTLira/Bo8ExPFDD?=
 =?us-ascii?Q?ZTgNsq+yW9V0EDOzRS4gP4pn8cybG6I6Rzt4P/PxxKV7r9BE5dP9VU+bG42D?=
 =?us-ascii?Q?1Y0u7qvytD6L8n1As6lkFSxHJYzGrQDbIZiW71JTFRy/DRaeNW20yxwlj095?=
 =?us-ascii?Q?aErbFJrJgMRwmKMNgKXIRBKZ0heQwhW5bs/enUAA1vgLNnzYuvoSi8owc6/m?=
 =?us-ascii?Q?i9AJ8r2Pd50IoeM2fPJ8wNVd861snNjnXVzkSOAuksCag8VtALAzEB9gQ2HF?=
 =?us-ascii?Q?gDj5xxm3ef04O0JsVco4GKs+2hEUSfKXuaq16LlYuNYTvLncZnUdI5cSuAeq?=
 =?us-ascii?Q?dLD0bKzTDqpK4Pj3LUH4jyM36nanOYCIhwaHGLkZN2DEpNerdvNX+56iu8T+?=
 =?us-ascii?Q?MYmeWmNB0r+OGtOIJhqK334Fee0QtCxkh5215x1n0aNBQPmv0a8SXl98bmAD?=
 =?us-ascii?Q?kGI747oN0r/niB2a7taj3S5Ax/G5dqcO449Zzlr5bvASQUCVv/ud0Pie0qDH?=
 =?us-ascii?Q?W01Ox33ShjHRVPqvnYEihER4JOEC9ATuJepjHxnJvcLhGu9I73CuuutDs+qX?=
 =?us-ascii?Q?eUAhviYglBglKcQd4i18Nhd1kOG7c4laCguF+4LnvHCjnL/5/aek82c2uJFi?=
 =?us-ascii?Q?vTB39EDQnXwSdPBDBPjlYTFrBuD2sJrUzG6vIH/7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c5c484-e6bd-44e2-1a24-08db2c1d0b68
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 04:05:46.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0YJDfGwQCNd01/8TKDf3qlD4tdZS+qN3QvXeEjPohHy7ZJIFLxA26ywB0+M3WcxRQcwhZeQEV99Dq5vX8ILKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-17 at 17:08:10 +0100, Vincent Guittot wrote:
> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> fixes an overflowing bug, but ignore a case that se->exec_start is reset
> after a migration.
> 
> For fixing this case, we delay the reset of se->exec_start after
> placing the entity which se->exec_start to detect long sleeping task.
> 
> In order to take into account a possible divergence between the clock_task
> of 2 rqs, we increase the threshold to around 104 days.
> 
> 
> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
This patch has been confirmed by 0day to restore the performance which was decreased
by 829c1651e9c4[1], thanks for the fix.

commit:     a2e90611b9f425ad            829c1651e9c4a6f78398d3e6765          a53ce18cacb477dd0513c607f18

hackbench
throughput: 173811           -18.4%     141887                     +1.4%     176324

[1] https://lore.kernel.org/lkml/202303091155.672f546a-yujie.liu@intel.com/

thanks,
Chenyu

