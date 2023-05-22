Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF12F70B50B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEVGaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEVGaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:30:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB00A9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684737020; x=1716273020;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eTq7Co69BtvKIihAMgbmGUZbvbh0v4LD67TP02JB1cI=;
  b=ATlZoE4eVN3Rc5DtpfB9M2ZYBBOA1saQ952P3e6+6CcC2KJKDlPNtGFM
   GgENuhkx/rmE5SfFtLtpwIAEUaka75OFmhsp8Ox94RvSpvtQOpIlGGnts
   WF3Jq2phJLtZpGUtlk2birn1n8yBqZCmNV2P/ewQH+xRTbQ20090982Dw
   8nHLfbftwgFnNKerS9OS+CmUMDmayWKBWi6rj0lN7WEpr8zx8oFVp3Do/
   FHlts5DV0468ePoChjiepimYmZnPokT0SFrEcjdqdrJ8mUZKi6LSN/JB+
   CqJ0IE4rte3qHCAEpd8GraF586FZS4xSIVDbT81ElvbF9xVTdDr93LmOV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="342289990"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="342289990"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 23:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="1033496175"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="1033496175"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 21 May 2023 23:30:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 23:30:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 21 May 2023 23:30:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 21 May 2023 23:30:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEIa5ZblGyQbGbXM30xtWL7OcdbHHdjq3BE4eLFub50MYzAatzmJLoiWlXFjwK2qCzydeHKyf5D0/kf2nH9zF9N3DxPHUI4IPWD4AQusLljM1BcR8pNGxd06eMyFNScfAod2BHn2nV7MbaA2oSbfcGUW8Z1lSt88ck8emaYk3RrMUXQ0MpCNDYTDR54TrSu0tgtU8lQyomNH/T+aaOwvrB29asEZmUxCFtPHzK2EjAxtW1Oyfv8YY792xpbq2/EIA0U4LBtIPW/2jUOb6n8nTVIYWWKVndGeN1AOWhILEViHZTjy4cfPCuQuguuXl8LZ/yRWhscRZo//IiS4pVlivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbhDvs1Phm2wye+/xdy3BY7eubX8ZhKInuRCgkfvWNA=;
 b=PtremOdXfTx0HhmKPvSkUd5JFpanxNyuyhjY4xJY5lA5ZEBloboqgx00UQSwYgj+uxb76mD27Q6flt1Pasyh16QWIcs0tMGZGbS7NZfPhqbLg8LJEmta4fCm4KhROefJrY4+/RyQqL8Jjj/TwXmVhUfOm+IMa9+6/d1lJ98/kpHx29KAaLavdYqwDfuQ/OQI2vO8EbaAaOqL6xVfVlqqIvqVXAiTviGkN9ykZQg6nJdrGFN4t2pyXnVnkkTLjfE5vxweL19UhSKoSJZR8hJTMOAjNMR6TdzCB80tNcJoqtzT3P9jyfS9Z2lJLSJepSokfzuC3G3P5mr9kOPncIWQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 06:29:59 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6411.027; Mon, 22 May 2023
 06:29:59 +0000
Date:   Mon, 22 May 2023 14:29:31 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <guodong.xu@linaro.org>,
        <hesham.almatary@huawei.com>, <john.garry@huawei.com>,
        <shenyang39@huawei.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>, <tim.c.chen@intel.com>
Subject: Re: [RESEND PATCH v7 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
Message-ID: <ZGsLy83wPIpamy6x@chenyu5-mobl1>
References: <20220915073423.25535-1-yangyicong@huawei.com>
 <20220915073423.25535-3-yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220915073423.25535-3-yangyicong@huawei.com>
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5150d473-8c8a-4dc6-d661-08db5a8df753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4hPghoogzxN43j6Azop/XH9B4CYT//ZK2nEB2IJfrVaCRzA1S9B3P4gvjeiCUGw2WrtrPld3ZW4vJ9Yf9NFu47bfE/M8kyNU3JqXNk4q2TUhkoyDpnGxHU/n1T9zupNl/waObF8+QEeVPAABoD1lKMp5gPV7XLcPACjkmgnDKAUkVG+2JTYh+5GHJxs4g+sOxBR0jTIrCuZ/xAUNjM/dJtpV5sKezJ1l8J3/T8yYlsO69BP7WAX8PErtjHHwTKnYr9SBSDoUS+qATC+2hktFfGZVuzmWQnFSDeXEMwaHjOCxIrrUM2Hv4CWGVV1g7e4BHRSZnNDAlPLQGHZ1q+lafE/O9Hvpabs5VYhY0fajhhyDFvQyrs0c8e2lhbY9wlpOIDVOsYQAXMsC0TDvAC6Psih+FUPDrlbIA4aG2ELVXRqfOVt6F6MbUKwyq4DQPP2yCwz7KtOO44DVT8g2Vb9louLBrO7grse2EPvTyhxybRb7k2CBsfTkbVjJ4r/F8HNeNI/Vq7SWu0FmOCVwOx3ozIoD+bhjV2YSaipsLH2Wgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(8676002)(8936002)(7416002)(5660300002)(83380400001)(9686003)(53546011)(186003)(6512007)(6506007)(26005)(33716001)(86362001)(82960400001)(38100700002)(41300700001)(6666004)(478600001)(6486002)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRMqtd5FSImwFd11MHf1HSyoFFhyBU/I2naH88Pg3EX3aIoKuqNhukrm/JtO?=
 =?us-ascii?Q?pDUGwpgf4uZgO4R4vLjJmPWh4ztQQgFVdC6t4SnrS8mTYPdEwIEFFinQal7d?=
 =?us-ascii?Q?JpwjzQBFFGwE34vCMzi7/w7G7Jqxj+GUkvtYtwqI5qm/TEzf4bGwkQIOjaZY?=
 =?us-ascii?Q?jIO6mdO/sXnDEDZtONpEO2PdMRqfNFliNPlHXsfeZ590rxQzxAqUvqUfvHw/?=
 =?us-ascii?Q?d+uY5A4yvlXauDRkw8pWayV5bOXe9HzpyF29FKQPteJJkHca1rcyW69wjyrV?=
 =?us-ascii?Q?6HWOKvPWGuEuywSpBXcqOoD+/vkI84aMufxu/vS9GHna1e9bBTHwPqP5uyRJ?=
 =?us-ascii?Q?1aKLxvtdoFmb7B3W+VkN6u33uL0X9x8zm72ESN+3G8A/VV0vpFdT7jmDCa5d?=
 =?us-ascii?Q?Uz7RTZYPourq9Irpu6xjIaavPgo2d0BEUr4TAn+CCT1q2AdGKz69QuU/Ja9F?=
 =?us-ascii?Q?ezuxcb3jINCdOXmFAX0DLgVLuatauppktdF9fQwDAOuHAMJpQnVaTEAqtzaJ?=
 =?us-ascii?Q?hj5yOFPG41nKYIJ3nTlX24Dyp9Z6MgWgHQrKiCLc31YIFN4wb/kwSdeZ0XoN?=
 =?us-ascii?Q?NPWwappYOUWxucuKI/JM6+eZqI/HIoPGIdh0S9QEMnMxZCRP5ov3tKGZo6Hf?=
 =?us-ascii?Q?WXnHFUHvmVNapaSWCXNpbLS66GP4MHxUPykYAV40OhZtfDwTk7mH3qzdfoUs?=
 =?us-ascii?Q?PqmYYavZA9EoAX3nrBc8uX6GihG9OwfXmGqgdcvJX5/QnPG/MIRdYDqEo4s0?=
 =?us-ascii?Q?KnN0u3cN7OLzm5lbIArijUQ71H+kwiGomsrFSpPEod6Rf5s5IDCb/u9OR5Mm?=
 =?us-ascii?Q?HTl0eKBNxfTQYCP8Vtvrnshj7WBcH6tjdp+3N2QzRxAEJHRGJMhC4lQHo4FL?=
 =?us-ascii?Q?IaFuUFwRxby01zr1Twu5B1JyUcEeQIFOrtWFQE+wOwzxpvXYxxv7RXQHcwsC?=
 =?us-ascii?Q?KWpo2WeecrrA41UmIt9s6jaxq6MLL3PzkD7OCB4yryWEsYZYCxADkxqJnJtv?=
 =?us-ascii?Q?DRMVgwPeOQ1jHQCKzGVsSCseJlomo3J9sx3l5p/empzpxkv9wZn1xD8GM88r?=
 =?us-ascii?Q?lu1KSdsVrjoo4/aomXlZmsUaU2TxlvIYKJ9n5JTe9+WxA/YWiTDyRhXG2Uba?=
 =?us-ascii?Q?nvXYP6YLqkWtaJqftXmNksReEoboTbspj5rdwSZmOqDIkPmTw2hGo0rilb1F?=
 =?us-ascii?Q?BIOPEWOB+8TRSgKb5F6QiuMRJ6RwCQIv7YQ0K/BU25GrgSizmi7OM0RydGjU?=
 =?us-ascii?Q?h2OzQF8TAy6psW5Cm/Hqo/WA8EETsgcieO52YFJl9oIjDsUcCN1VNzPBrmbr?=
 =?us-ascii?Q?swopdil2+BG/nZHxabQIuoaEFRQMf87Ik/WRivch3ju8HoogQTdLXesUvUZB?=
 =?us-ascii?Q?4/BcyBH6iE+5tUofhSFqio0/oR9IDgg9DpxKtSPNNoDkGSTW1jQpQJD8heYe?=
 =?us-ascii?Q?7oDqdSjdAIMAvpVzA0OtftN34K6CCy6R1q3jtj9p+HvlUA1/aT9kEXILFsrk?=
 =?us-ascii?Q?/M+kTe4Ku08KD4NIhqBxBeJqK05fhe6LgQjkhEKBAgGkBukM2VH4F9BWbjcH?=
 =?us-ascii?Q?+JsxUNC99ZX3MYgv4CWbasRpn/zeASG4rndCUP22?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5150d473-8c8a-4dc6-d661-08db5a8df753
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 06:29:59.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaD95NCIEo1xvxncvocTXaMvIomOn9bLUQaurQOPbDmWrJ90QXwSDM6kEncj2FXN59SwC7zgCC828ti0bfiIhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
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

Hi Yicong,
On 2022-09-15 at 15:34:23 +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> have lower latency when synchronizing and accessing shared resources like
> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> target CPU before scanning the whole LLC to gain lower latency.
> 
> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> 
> With this patch, We noticed enhancement on tbench within one numa or cross
> two numa.
> 
> On numa 0:
>                              6.0-rc1                patched
> Hmean     1        351.20 (   0.00%)      396.45 *  12.88%*
> Hmean     2        700.43 (   0.00%)      793.76 *  13.32%*
> Hmean     4       1404.42 (   0.00%)     1583.62 *  12.76%*
> Hmean     8       2833.31 (   0.00%)     3147.85 *  11.10%*
> Hmean     16      5501.90 (   0.00%)     6089.89 *  10.69%*
> Hmean     32     10428.59 (   0.00%)    10619.63 *   1.83%*
> Hmean     64      8223.39 (   0.00%)     8306.93 *   1.02%*
> Hmean     128     7042.88 (   0.00%)     7068.03 *   0.36%*
> 
> On numa 0-1:
>                              6.0-rc1                patched
> Hmean     1        363.06 (   0.00%)      397.13 *   9.38%*
> Hmean     2        721.68 (   0.00%)      789.84 *   9.44%*
> Hmean     4       1435.15 (   0.00%)     1566.01 *   9.12%*
> Hmean     8       2776.17 (   0.00%)     3007.05 *   8.32%*
> Hmean     16      5471.71 (   0.00%)     6103.91 *  11.55%*
> Hmean     32     10164.98 (   0.00%)    11531.81 *  13.45%*
> Hmean     64     17143.28 (   0.00%)    20078.68 *  17.12%*
> Hmean     128    14552.70 (   0.00%)    15156.41 *   4.15%*
> Hmean     256    12827.37 (   0.00%)    13326.86 *   3.89%*
> 
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
> in the code has not been tested but it supposed to work.
>
May I know if this is the latest version to support cluster based wakeup?

I did a double check on Jacobsville(24 CPUs, 1 socket) with this patch applied.
Overall there are obvious improvements for netperf/tbench in throughput:

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	6-threads	 1.00 (  0.59)	 +6.63 (  0.71)
TCP_RR          	12-threads	 1.00 (  0.25)	 +5.90 (  0.16)
TCP_RR          	18-threads	 1.00 (  0.39)	 +9.49 (  0.49)
TCP_RR          	24-threads	 1.00 (  0.95)	 +2.61 (  0.94)
TCP_RR          	30-threads	 1.00 (  5.01)	 +2.37 (  3.82)
TCP_RR          	36-threads	 1.00 (  3.73)	 +2.02 (  2.97)
TCP_RR          	42-threads	 1.00 (  3.88)	 +1.99 (  3.96)
TCP_RR          	48-threads	 1.00 (  1.39)	 +1.74 (  1.50)
UDP_RR          	6-threads	 1.00 (  1.31)	 +5.04 (  1.70)
UDP_RR          	12-threads	 1.00 (  0.30)	 +8.18 (  0.20)
UDP_RR          	18-threads	 1.00 (  0.37)	+10.94 (  0.59)
UDP_RR          	24-threads	 1.00 (  0.84)	 +1.12 (  0.99)
UDP_RR          	30-threads	 1.00 (  4.70)	 +1.61 (  6.54)
UDP_RR          	36-threads	 1.00 ( 10.53)	 +1.71 (  2.67)
UDP_RR          	42-threads	 1.00 (  2.52)	 +0.63 (  3.60)
UDP_RR          	48-threads	 1.00 (  1.61)	 +0.12 (  1.27)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	6-threads	 1.00 (  0.60)	 +2.94 (  0.23)
loopback        	12-threads	 1.00 (  0.11)	 +4.27 (  0.23)
loopback        	18-threads	 1.00 (  0.12)	+13.45 (  0.14)
loopback        	24-threads	 1.00 (  0.13)	 +0.69 (  0.24)
loopback        	30-threads	 1.00 (  0.34)	 +0.42 (  0.15)
loopback        	36-threads	 1.00 (  0.29)	 +0.58 (  0.07)
loopback        	42-threads	 1.00 (  0.06)	 +0.38 (  0.45)
loopback        	48-threads	 1.00 (  0.04)	 +0.15 (  0.68)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  4.56)	 +3.23 (  0.00)
normal          	2-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	4-mthreads	 1.00 ( 11.00)	 -8.82 ( 16.66)
normal          	8-mthreads	 1.00 (  7.10)	 -4.49 (  3.26)

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  0.62)	 +4.71 (  0.96)
process-pipe    	2-groups	 1.00 (  0.84)	 +3.56 (  2.35)
process-pipe    	4-groups	 1.00 (  1.56)	 +6.74 (  0.74)
process-pipe    	8-groups	 1.00 ( 14.27)	 +0.85 (  8.34)
process-sockets 	1-groups	 1.00 (  0.36)	 -8.05 (  1.54)
process-sockets 	2-groups	 1.00 (  3.19)	 +1.77 (  2.39)
process-sockets 	4-groups	 1.00 (  1.86)	-29.10 (  2.63)
process-sockets 	8-groups	 1.00 (  1.77)	 -2.94 (  1.55)
threads-pipe    	1-groups	 1.00 (  0.74)	 +6.62 (  0.94)
threads-pipe    	2-groups	 1.00 (  1.28)	 +7.50 (  0.93)
threads-pipe    	4-groups	 1.00 (  0.80)	 +8.72 (  4.54)
threads-pipe    	8-groups	 1.00 (  8.77)	 +6.49 (  7.49)
threads-sockets 	1-groups	 1.00 (  0.43)	 -4.35 (  0.27)
threads-sockets 	2-groups	 1.00 (  0.35)	 -5.60 (  1.86)
threads-sockets 	4-groups	 1.00 (  0.61)	-26.87 (  2.35)
threads-sockets 	8-groups	 1.00 (  0.81)	 -6.60 (  0.62)

And there is regression from hackbench in socket mode, especially in
4 groups case.

In 4 groups case, the fd descriptors of each hackbench group is 3, so there
are 3 x 4 x 2 = 24 tasks in the system, which is the same number
as the online CPUs.

I added schedstats trace and found that it was due to target CPU(becauase the
idle CPU scan in select_idle_sibling() failed) is chosen more offen than
the previous CPU with this patch applied. And with this patch applied, when
there are 4 groups of hackbench, some CPUs are around 80% utilization, while
without the patch applied, every CPU is nearly 100% utilized. This suggested
that, task migration is unnecessary in this case, just to put the wakee on its
previous CPU is optimal and could mitigate race condition. I did an experiment
to keep the cpus_share_cache() as it is when checking prev cpu and recent_used_cpu,
the regression was gone(comment below).
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 10 ++++++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4e5b171b1171..e6505b0764c0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6444,6 +6444,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&sched_cluster_active)) {
> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> +
> +		if (sdc) {
> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> +				if (!cpumask_test_cpu(cpu, cpus))
> +					continue;
> +
> +				if (has_idle_core) {
> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +					if ((unsigned int)i < nr_cpumask_bits)
> +						return i;
> +				} else {
> +					if (--nr <= 0)
> +						return -1;
> +					idle_cpu = __select_idle_cpu(cpu, p);
> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +						return idle_cpu;
> +				}
> +			}
> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> +		}
> +	}
> +
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -6451,7 +6475,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  				return i;
>  
>  		} else {
> -			if (!--nr)
> +			if (--nr <= 0)
This change seems to not be needed because if the cluster scan has run out of nr budget,
it will return -1 there, and there's no need to check nr here. But yes, with this
change the code is more readable.
>  				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> @@ -6550,7 +6574,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	/*
>  	 * If the previous CPU is cache affine and idle, don't be stupid:
>  	 */
> -	if (prev != target && cpus_share_cache(prev, target) &&
> +	if (prev != target && cpus_share_lowest_cache(prev, target) &&
This change impacts hackbench in socket mode a bit. It seems that for hackbench even
putting the wakee on its previous CPU in the same LLC is better than putting it on
current cluster. But it seems to be hackbench specific.

thanks,
Chenyu
