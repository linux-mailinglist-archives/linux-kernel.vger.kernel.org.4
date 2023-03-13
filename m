Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931226B8568
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCMWzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCMWzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:55:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177895A6F7;
        Mon, 13 Mar 2023 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678748101; x=1710284101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I/t1AKl4ZnIklSif3j25X1t+n0zEW+J0/h9kGdS8HSw=;
  b=e7zAyGKNmuaomdi/Ef4/NvURwzGz2CPZtdKLgn0PpsiDZ3QFb7mlWOe6
   /XeD21zzCsb1dPzE33T70xxwzmnjo4CdORAoSgnVxE/kwP7msGBjlbAYh
   iAfI6We9fv31G+37cbbcWA+4+qIzhSmBRkB4fhgNxjoRHAj8aBo6zJTTN
   mgU9BMz4S/GGw3d/V+Eb77LppnwhMqAGJbwFSs1dznQHB4bwPHyt7M/jL
   Lk/L1W87EL1u3t+tGpPDG7dc3nVK2dXRPGyr1axYcVVjLI/STfAjWJtO+
   ZY3n/zomdQMBlQEPsh8dQYj4rLsbp7auYvXVbcjd7AzV4mcjHsVt6lBLF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364937914"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="364937914"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802626878"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="802626878"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 15:53:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:53:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 15:53:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 15:53:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj3hJbQWjHwXBbb+4V0ZMpsxKsRil4ikHNqx/rsA+eJ/iPpJ7v/C8WA0KpuWI7OHblk3Ib9xbgmDgzwqBUkIsrJNdJfxIVR+IEGBixYc4pQZdyD59y5yjuYQXV2O8EYckYSrB9SZAGE+MDnAdRhtQVPcJnHhL8S0DQrjE9KYhno32yumnUhSaOnSMLSBvtyZ3XYLpTIUPFEH3TCrWih9WInTj8O5bplnp1eveysynTamoEUB3liMVsfp9F7PPJ/hSlg5T/vsGKDL3G5zo4+5TZ5I8RRtC3AI4RZsUHlW3tc7xfUmTPxSJgTn1bEOyTApmr2x4npT3ni7+9sfGZ+IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aMakk/XgXkpG0eFkusH3VtzNOSY8JijXjL0eaoWvSI=;
 b=A3UHenr+Gg8FJawguUZhWcStojAG1lcUC3CYHinjjum0VwsMmmVS72vrJGKXSDKLH4Q2BIAdAbpXWb5hdlOsAdGeOQdeuzOenuIOrxLu2hcgvfJxDegj1/o/yQBDHDi8vvBO95/2h8akzJP852Nce6zZU4F0RXu9UJfupK2xqg4w+hMgDHE0NgrBsFf+hlXdLhGTzvHCTx8gaBJ5ykkxf0VzHJR4xG0ixQh+oIoUTKiQfpr1rkDFOEXbKU0C743fcxLdozIcjyKCd7tzZDtvStmKy7miCYkNPE6OTetf/+Ump9qbT9WtddkG9G1h8WkhRLovwzJNqAvAcTrN5cJIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25; Mon, 13 Mar
 2023 22:53:52 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:53:52 +0000
Date:   Mon, 13 Mar 2023 15:53:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <640fa97c89fe5_22c07f29419@iweiny-mobl.notmuch>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <c245435e48d87af3994380cf2b6da0a6763de4bf.1678468593.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c245435e48d87af3994380cf2b6da0a6763de4bf.1678468593.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: c65c5ebd-68cd-4e99-abe8-08db2415d0f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1J9/zeCst5Ar5pBXcCoAVOqg4xv4h4FeAVhKTSUKZh334qlvMbjlYwukWWmIygCL/ubYTbhl7ScjjdTdYbnIaeuinUzf7NvxG8CwarRq6KmPP3r6aJkbLrSqMdohjzGjgIFOAMU1k4UmJ8dcl76f5xOJ9pg6yhMCS3/n6hzwlSPIenOZfUzzTdS2EOJAMdrPw4iZw85eVHna4LCcBR/EhRu7cFU6twR4MHHeoIqD1hixtFlreRQAN+Kqfaq3pWXm99C6Qx+xzwnoeNHE0wkYiRhJoPBQ1rgjOnmop74Wa3+I6fQBbGr3FSx0bxBymc8CPR4lS4/VlKvgMrpSbDfFGg+EAdc9n48LPi70DQ6B0F/eeiw+52toyejAcWH34MK9pA9RI6ntfOaj9MJLp06/pVB3lz3bp8O6mVPZXsQKG3Hcjlc/KxothTA0Hc1Na+yHw2MSRBWMI0oAO4xl5a6Kf9Li6BpsuZf5pzibF/5VLpq8PUfU8paSxkHpzDu321FO1f5Rj1SyTidOn5YgljEaJzpzlTdk3AvlrPsG36MOGj4dBEfmK85eMRIPrYPKIh7vXlf+W6Hawz1V6s1hnFTy9V0nQnM82XNkNvR7WV/ImNbO6Q4fYgxAVTHeSP9pUYRh5cihYPIaGyEjj887a8+Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(6666004)(82960400001)(83380400001)(110136005)(38100700002)(316002)(478600001)(54906003)(8936002)(186003)(6512007)(8676002)(4744005)(6506007)(9686003)(26005)(5660300002)(4326008)(66946007)(66476007)(66556008)(86362001)(41300700001)(44832011)(6486002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikNoVOGI9dfhOy3N87Nq9XZI1ebTMlcvd6dzBeePZs3WQuWPDYK4ZQOLtQ2r?=
 =?us-ascii?Q?o9eAUHrtkLSvLuxD8n86/JX5CSFns2eRCTNo+UuXCXUJ9XMMJVkTrE4Fm1C6?=
 =?us-ascii?Q?CpHQxaSq4udcU0Ze8puLYKvrKZ2Kj8IjRrLw4MAnEte1/7MyVtCOHmj9X0Cd?=
 =?us-ascii?Q?iI1CMhdb7Rk9okSqtATYZT/1+8YTxgGNeqZgrufWktGFuq+NlHhalhVdl/pR?=
 =?us-ascii?Q?qcf1LVsfLkwoc2tEty+2P/iUfOxxXg0spOSB2QNRM/gNGB/znUmdWCk4tQrh?=
 =?us-ascii?Q?n7Dj0wIdJD3S39qEBe+uAwZWWHcbyvsb+baByJNKQGjpI9kv++GRIpBrdDQR?=
 =?us-ascii?Q?FM6w7EMrCUFFCscGTxOoSCqMznPjg1WR9cW09krSRc2wJXlm3XZHpfWBxNg5?=
 =?us-ascii?Q?QfrY2x2XWU6nIfN6iVmST9MR8SVRgaUrkBr59wBFkYOOtcOCyyNI7wIFYw7l?=
 =?us-ascii?Q?54Ie+waw9C5MyFBrDwfZQWp4+Bf47dXHEN7hn8d1mBFIPqWDMi9AQygryEzU?=
 =?us-ascii?Q?Cv+6W2UbSv6JJma+XmJCnkYqWtqafKajKN+Qp6vLD2uisxdEQjez7IJ8yz2n?=
 =?us-ascii?Q?i9ui3UAvs2jLGygqSCmonDk+7yTBSFEBkECHKOjd5QqbG7cGUR3HxsG/ocyr?=
 =?us-ascii?Q?yOt0Ua7TUT65nrBjAigQR9w9mBRabPlH8g/2XyiTRyVsDPeM7ak+OmqUWy+U?=
 =?us-ascii?Q?2ub9eC7KBWvdvwtWfO+gW9NRcF703fd0m6JqYuj/qDRxsYAoCd8uBITKXrTt?=
 =?us-ascii?Q?LdLyn1KHB7XN7ac2pnKzVUAfqH3cMSm1SJSA6udXe9QQ+C/emJ1irVrlySoQ?=
 =?us-ascii?Q?OjndQfBQtebK5rpBaACwAmZB3Brpc/GbxCdF7lbEdrytm5JAqfzsWUWtvQ9+?=
 =?us-ascii?Q?X3XfDcZsMfXKTFMDMIIKRUOYKkrAfG8erD3IJZFnA+Wz+h75O5gEwiylAF0A?=
 =?us-ascii?Q?Y9ehqPxXRKLbvb2HdZzlhYo6VvVeaZL8VKBqceVdgGmu+38/LqTLQA44LdAc?=
 =?us-ascii?Q?1FQT87v3EzwNQwj+8r4IMroSOOcvlBQ8QMyQduFiHqWvj2mOeBDbiUSU117X?=
 =?us-ascii?Q?+abvT87PSr0w+/wH+VR/KT4yhqBHSB2920LLZhJIspKopis/+4RRSufkqeNy?=
 =?us-ascii?Q?nrW6PsCJ+9e+2Hc73lBH+fdBPOEwdD7eFsl/PplMucUiY24Cb2PA22e6/OFd?=
 =?us-ascii?Q?LiS8l2GFvpbaGH824v+OFzUFe1V1cM4Z5MDPdDMjxBOMmBvOycrZtUjjSngn?=
 =?us-ascii?Q?nfsb7nT3RgZjnUzK7iwBRlim+sbiCu0NWBXsifnY7B36flOJ0PXjRXa+lMxH?=
 =?us-ascii?Q?SO75mb+js6cNPT9HTaqyNDGZOuz9QuDXBaknIyQN/5hScEdSENFk1cNEh/JI?=
 =?us-ascii?Q?/SF0g/zmb+cnXCwCwk93bn71jCWPy1bub5XNdfP9VP3RRHQGLKp9pYywg4YR?=
 =?us-ascii?Q?ey+nEp1s0NM12Uf7HSyCD8+R2XEJmFVWtJx+VBM6C4Rrbew3nUROr2mXNIfR?=
 =?us-ascii?Q?6dJ3xiTyvUnvb8cU83R+TadhCcWI68bKz0SpASxD8CHRuvvQpeKp+L2yffci?=
 =?us-ascii?Q?ydRuqYQoYYt3zyArihwABuCuEDArFigc3XbdSRot?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c65c5ebd-68cd-4e99-abe8-08db2415d0f7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:53:52.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIfOOt5ZRoAWBaAy3rPmbC7HfrG8GKeN91kJysdmquhtaDWjYQ7rIMLOw1y9GxkDLjGBv6TngYxGcfis1j6rDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5478
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a boolean 'true' is written to this attribute the memdev driver
> retrieves the poison list from the device. The list consists of
> addresses that are poisoned, or would result in poison if accessed,
> and the source of the poison. This attribute is only visible for
> devices supporting the capability. The retrieved errors are logged
> as kernel trace events with the label 'cxl_poison'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
