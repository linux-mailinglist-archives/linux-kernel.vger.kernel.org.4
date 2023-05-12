Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C6700C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbjELP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbjELP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:58:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21F44A9;
        Fri, 12 May 2023 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683907107; x=1715443107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SgHQyNRmvpQEdSt9auDO4X8Gcllrx3nhVzU3PCG8wPU=;
  b=KsVVaZc+95Q2GcCEksiHMbTN3womVcbguVLiwliQg5dRbmv5fNTje4xu
   5vmmkOLoWRCFxQ0gXh/MSd+HRA8qEqSR+1AEDEg29dSZ78ipgp5o+w1Ej
   r0fWj6tHtVjr0XUCMptnRfqIAgFrEv10QZKIMFTolzNpvgjrfbHfjhNuH
   bIZc3x28/+df1yYBB3r1crcFonkqlnOaemGl0HMl8HyWxE866Efbqs0K2
   QWRkba+Wslw8+RQleSCGcDlfVbz9IKDyA5tigOiLJRpipKKcQsyYZ1mDK
   dKY8LCfechQGth4qvF6WmpT+Bu9ImIjroE2UdV8EQvAJX2Slw+978hhRa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="331183277"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="331183277"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="812127361"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="812127361"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2023 08:58:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 08:58:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 08:58:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 08:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7+MEitbYyFn0TzwSe2L7zKoId+Op2/qJa1uy8EmznUShPA45FlpVb0W2On+mtytSI5Pki1XszogQh6AObsxg7z+RDngWV2VF9bqUve2B8tvczF27oU05xEkcI8Zik+HvTymPyye1NSaIOTHgOqjyjkQpMmOkzDFd0cV/FVNC/CAJ9Ax1y+thSOJCh95XPas92fY0GTIJWdkKaw1buop4KUaKALJquZfzyd1TzGdkkkbiJyuQDVDCkbM3y2gSYq3zRbEgKpE+WUcqVbMbtTOJfZwznaK/dci9uPH+N4+wHeSTuX5g10HpEdfba6VzPSmSvA6n5UDjyZqMx7cGBja0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRK8YeQ7OXO5tfKnA4F4PlSunnWL8ssKgDvYYTNF5kA=;
 b=GImWTp6+X2QhpCGs9Uvc3x7IkaJbuXvfref8WYmJqB7ir9p9o6Xcj4MVBsvICP+NsnItdbzs+D4Xizc+RWtRz0fz3q0CKeScFBicMJir8pqTNkOzo6Grxlgk6Hw/j/Jsfjo0D/JXlBJBKiYSHyA5haUXDeIith7GfKH7C5G66ujQBoO/wIsULe3+KDj9cYW8d+15hFEj9glTQxl04jtOva0+JRjrK3XCGD7/zxMNgN8Ag93rPrWFIXL4SUxa6JKcQdEJWJjeRraVZmEnuZ5nbL/nxq31qVz908zig7hGbPkFYUr1nJvsV9ouYUqGlYJJml0ok0H6NF6vwfvSnGOWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7077.namprd11.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 15:58:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 15:58:16 +0000
Date:   Fri, 12 May 2023 08:58:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
Message-ID: <645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3>
 <20230510171445.00004cea@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230510171445.00004cea@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: cb571821-555b-4c17-4a18-08db5301b297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvNs6AD1bMw0H19twV1bBCC+UI0YtedvQ+qbd6pdNRgWMDlXYUdIOuzn9bmaoZb3XxfUk/9Yt6O3E8c8Zh1aPvp1y9WLuwrzcZnj/8mNdUDRfF+vaO+GgI36Efvpm/6FL7TuS+27s6M+hJqgwHV+bmPHqAlxheuW9JGCnRUKUfxIwks5XNnPTEPzY5KHz2L04mqMQs44DDaGbwQ6bWpnPa5l9TRxX/vcTrYkwWkm7Yr4TcqoN8zwWcyYpywhYRbVAEW/fOf3McWjwIWnbfJG3gV6XaXPM5UHngUe3HY6+g7vu144/F+lCrsFdnKpafgZHZGWvEBSonElC5Zjps0jUgFey7arhePAAFVr1Q1lQJeEDzSauxohPDcR24mpXKS3JCtLoy3ogmXUFgQBnfqbADjGVWfYvjdLLOQaS3E+c0xQSkdWRvzdtcYxIn4kAs+blNV4Ck4XSrHKr5yAkpfgPT8fhc8Zwc81WS9sJkY49eChct7fJs7Vhao6O/ceGP1X2u6s7FJFu/hgEnuVn1ziIzNESUMK6/lHrcqB2oeWY3GEdCC7seqhf25ZyH+p8VY2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(86362001)(110136005)(316002)(66946007)(66556008)(6636002)(66476007)(4326008)(478600001)(6486002)(41300700001)(8936002)(8676002)(5660300002)(2906002)(82960400001)(38100700002)(186003)(26005)(9686003)(6512007)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xM6cMpLJmwhsologDXZsRiD8yQS1QufMlFx4DROa4t/loG99qx9pZ57nNoA5?=
 =?us-ascii?Q?Vtz90uLSOmv1wrWKqT+k+LLnvOqwmbdfHhWBck8ZoO46Aj2n6PnM3iorAoU9?=
 =?us-ascii?Q?GItqJiw3YuUPAqlIQAw8DYlh3/YLmmIlCtt/tT6Cuyd8FaNo6on4123bPbv+?=
 =?us-ascii?Q?vhERPxIr1XRGfHspOygriTOt6Gmgd6uJIgKDiAEXa6cxzn+O2RpqXekAk8k8?=
 =?us-ascii?Q?dPM06orGPMOLjkyQpku0XCBRanp8eFTqSEMkFZT4IXbr6dVRN5s1VWChRAlO?=
 =?us-ascii?Q?rVAOL2ynWO6Y45BhyrS3lIT5Kl9diJ4Fu7zRKFTXJDeUKi6lACOw80N+0c7h?=
 =?us-ascii?Q?R4jiy+QNxBCONLMmqxy2zdc69fQL281VR/JG8gX4j/ji8Pc68UyK32ssBC8b?=
 =?us-ascii?Q?xYrRYKlCV1cZG3jNjH30BjYceleTlXfUML3pwkQv6B5g+3BZWMYpY/6Ybuat?=
 =?us-ascii?Q?qsyBgpB7FcKUtOPfda2DxeEuugDl1o+gKTbZ05U6UwmE/RbSnYfD08znRyxn?=
 =?us-ascii?Q?gCXvpHbAf3t48jp7ixq9UFdPIQ7fqTd60o8tLEtfFvuT2CIgMwPnPKuJ0zC2?=
 =?us-ascii?Q?/CUb1D0uZ6GpTaap/v+XLOpDyhOMnkhfMHdjzdrQZzSHzvCNze6mz6DCMXku?=
 =?us-ascii?Q?xIbUlGctqvZ1VtI7z9m0rOV+Smq14iSUJd/X0J/KrM701/FkyRU/BqHSWN5l?=
 =?us-ascii?Q?v4Gv89eWvw0BmCGPlILHihJhTV8KK8JPWyWSg3EUCKqsByYdinSo0IReHaMe?=
 =?us-ascii?Q?X5V5pIydpkKs4m1eGw9K1/nktTC46NUCMT4DvFY4mP+baB5mmIGc928Mumf8?=
 =?us-ascii?Q?rIYv5Y2/CHgsSo9SXDBNRPIGW7ukOyAva1YhQPPhT26CaWWB/0V0RczRqPOz?=
 =?us-ascii?Q?rHULjRpWZ5Z/prJqTQr2dkqSJ1sizMPUGmA66BpGY6eqhdQTuIYl+2VHuXSZ?=
 =?us-ascii?Q?zLMr+t8hI5NaNcDHfPIUlnqoiMnb39q0j0rhLRiLqGH8bSka13urJowhTfxo?=
 =?us-ascii?Q?jjJ9rs8ToWVSGb1I4q80Pnbteyilphl7kg3eZ0Vuh1GQmyxuLNNirC1nFFdA?=
 =?us-ascii?Q?nmhJRrBZqIpQHe/Ul+cITONNrQqY10ZszIOXFFeggPeKJSvw71rOyW6yoqyH?=
 =?us-ascii?Q?4W+RyPjo1AHHt5vLiGzyIhFTAhnEaZmoKSLTzsRymF+yWxEYhYLi6TNQQ801?=
 =?us-ascii?Q?/0v9L4J19/01YmD9tmAUwu/M4rAcWfcJioqTc4ooM7/2BXIG5BKnqLJ2FPCn?=
 =?us-ascii?Q?LbkKdoDbSY3pbIFYqbqHJSFRqRbT3FyrQB6F/dBWI6UPisrrxNXCc5ggg+mK?=
 =?us-ascii?Q?7FAyjqvRWDSbQTvEiCEfuMD+NQ+v9Qsca+Jt6F8PvqiAxOzdfKR4QLU9YYFM?=
 =?us-ascii?Q?Dgaa2w9cLbbQr/se3jrHMOkxBpc61sT48NYsQYPmSw79Yaqugg1RV0SxFo8i?=
 =?us-ascii?Q?CA5GVkjTPn8Gfb7+QkuerQrhQBxXM3iIY6RkZBCy3mXFmbeymJazDyMMfvE0?=
 =?us-ascii?Q?ibxiU9eKpL405qWFcPMceQ9llhNoW6ZFKXCwvtz7loj5xAz22fD3v14ZsN4R?=
 =?us-ascii?Q?Gvc7mhEWGeLZy4OI21ATw+jAQ1T/hGpvfhvFb64lblgIsAsboe5T6S3bdPRt?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb571821-555b-4c17-4a18-08db5301b297
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:58:16.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jCEDuDehJiWSO6Y+ZHTMOJMkthils37/Oo8RpIUM35LgwhTMp9YPG/XF9YZ3mplRt7Jigusj8uH9fK4ab9TwHWnzRDOdWulSyRWvZsktoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7077
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

Jonathan Cameron wrote:
> On Fri, 05 May 2023 14:34:46 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Dan Williams suggested changing the struct 'node_hmem_attrs' to
> > 'access_coordinates' [1]. The struct is a container of r/w-latency and
> > r/w-bandwidth numbers. Moving forward, this container will also be used by
> > CXL to store the performance characteristics of each link hop in
> > the PCIE/CXL topology. So, where node_hmem_attrs is just the access
> > parameters of a memory-node, access_coordinates applies more broadly
> > to hardware topology characteristics.
> 
> Not that it hugely matters, but why the term "coordinates"?
> Looks like Dan used that term, but I've not come across it being applied
> in this circumstances and it isn't a case of being immediately obvious
> to me what it means.
> 
> If it is just another vague entry in kernel word soup then I don't really
> mind the term, but nice to give some reasoning in patch description.

The inspiration here was past discussions that have been had about
potential API changes for userspace contending with multiple memory
types. The observation was that seemed like an exercise in having the
application identify "where" it falls on a spectrum of bandwidth and
latency needs.

So it's a tuple of read/write-latency and read/write-bandwidth.
"Coordinates" is not a perfect fit. Sometimes it is just conveying
values in isolation not a "location" relative to other performance
points, but in the end this data is used to identify the performance
operation point of a given memory-node.
