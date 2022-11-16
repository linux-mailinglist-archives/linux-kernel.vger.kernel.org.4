Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F98662C908
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKPTgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiKPTgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:36:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A79DCC;
        Wed, 16 Nov 2022 11:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668627405; x=1700163405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cQekCu7JEcsS1xsbq+sD7b6sDOX7NTeEWLgkeKGISvU=;
  b=C/ljhoxkb86OnDzaRGryRSO1d/KNymriBHvtCaF3xQguXDTnkNux3qxZ
   tc90Eo5b93KsflkTHHD+mMYkMXabZXdJ28pgS4ynfzf0opzHDuPw1b5BP
   tf2nUdcwzyTJdz1CGCBvCdQcvFovWuK5J3XhO1env5GrNEhv8tV1S+ABN
   sYFBfpOUag8vUWc1kTV8XB7e2F06Av8kXzj92VSNlcT9/HjxQy2X3YZ3N
   2YoybOZBv6pCXM4fG/b9ySx8uQOZsCbbFW/xhuiCv45fI58II8Y/PkdOB
   +d3x372samO6cwXGyB45i8vrzhNnm5vtVQrENd4A+nhhDkbld8pSCza3S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="311347294"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="311347294"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 11:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="708294410"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="708294410"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 11:36:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:36:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 11:36:44 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 11:36:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYRsYyfMoGsLlLhjTUtBXQ3l/odf+sggzd2OEkhVGWqfkBaQrV7PZkzp1Oj9X/7nBOTkW9HF8JgSWnXPrn9jBunXrFa57fYmUUBQ7fOutvc+qHBMTunPz+6UKZFpvjeLjLK92cBv3QtqUPxHYAs2bpPOsOja0RJoeQY9l9ZVA2G9Ll/jtHdsKiV8JhHEGEU38O8ABGh8D6ByWHPlJB1N7DprUcMAcDfX8uZUdBrC8NXjLEiYsKl+tqwZJMF60sgWYVFiaigdBuIU4P7UR9bddK7PZ1WFkW6Zhv5ieI4eieSFr8F4IX+hSTUlqtrP67uj9p0PQUQOUfe0MnjItpT7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5TAEvIL1CBHzxxU0psCame5cpo5j5TeITNbrgLoTSk=;
 b=UDm9Jm8wZV8Bba2CAQue91jElQkvN5GmO33mV4BPVcph3m7tsdrVYRC3AU4RdbQ7zxU5BhB6LqXfGFKCCPxjnKtzCemXkd5j5dke9c9La4LOFbpRaPknuKD4w485kner2TlafP1gmgttc/Y9TGR5rggOMwxmHc1FSYVBKrwVIwzrBcApkVE52OLRfOI/Z5/cRDieFaOW6mxuLywCYuOhSB4J4QKfXFdPo7pqTynJj229nYyhjMuhvNiedf9IugQ3w6jTwNeE0s645vk1aXm+TEfzqAaGX+E0Ae6QrvutSB6VCucYzcU131xTnX2xB3OaWSlGKNBsTvKPx/SwgxElXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5130.namprd11.prod.outlook.com
 (2603:10b6:806:11d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:36:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 19:36:39 +0000
Date:   Wed, 16 Nov 2022 11:36:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v3 6/9] cxl/pci: Do not ignore PCI config read errors in
 match_add_dports()
Message-ID: <63753bc4649dd_12cdff29498@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-7-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-7-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: 78058c20-a124-44aa-ab42-08dac809e168
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eu1NA3O2yKfWaCYuByYQwRk3onojDwYs+aPMQtQSdvR6FDBemC1yJoQJuE9skMUNEY5+C8o1iiulTXpN+BLpCr33kEnhjaYhXJFgmo9yqBmyS/TkbLrWgvrjhztB/Ze8DRzqAqKWTCWUIBG1XTx21CQKrdp1TcjHf6CuTBHJUBi8Uhnj16LoPo19hojzaELEZm+UHjKQ5ImWdgW11er3MX20/3+xIsQsctCUaEVBa96IfLGmH3vSwDUJNIys4Cp31R/JsVU4qBobSg1UQnxUyVTcv8WjVbYPSX356xGasfqHFnEZ83LbJPN/eDZUIu/6k/ss5QR6u4xcePzaGIEh0QMIzvsPvLH8D/TFBhaWK+yDCks8v1KWRW/zbpgJKWJ/2Kaev0399JOTV+hFxm9uo8qBI1BSJkeFm2yETxYxloI4yBtsBx/M9mS4lLWO664Wz66yByLtYNPGsqTRH5/HpKbBGJYMcytM14NOezN8ehKgMi7hR63iv7zHPZPc3MSekxlUQabiIMIOtddKNm1GMP4BesSzvqT9a/MJMrOKN/tzxMXpLlR8LMSuF/YyU5p5bh34rPh0sI9jA34w83huZ+cLVKcCSIeoNX6Nk9xT1mqnARflfW/WNvZtgZnzO1d/VTrFgjviama7PX2x8/hQShR399iS1CNS/WGLH7FhTW+Dr5GP+rXarWKfqElxqGNSu4KVdkVEdqIR1JFp+sjUdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(38100700002)(82960400001)(2906002)(41300700001)(186003)(86362001)(83380400001)(8676002)(66556008)(66946007)(66476007)(316002)(4326008)(54906003)(6486002)(9686003)(6512007)(26005)(110136005)(5660300002)(8936002)(478600001)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GqoBNs96paad4xVVlsEQV92b+4MK4Kut5HH/+n7WDfmQ1qRz5K5cMrN58bdr?=
 =?us-ascii?Q?/C2bvEulp4GNWhWZP6lhFqtfJ8z0YC2ODXyl02wGjlCAt3SZKbHosKRJS6ps?=
 =?us-ascii?Q?xgsxHsvZcRxYfQ54xvMnXdrabGkYC9DbU0EpN2LpOkwEOcIvloWn0Of4pl1E?=
 =?us-ascii?Q?ge688ICdzT9lgykZui62Ww8LDG9RExTO/gT/UY4mYC7vAxVuij3lzPf9UmPQ?=
 =?us-ascii?Q?mRtwWzbGwfDUj8Kimg4ndRO26peRHCmoZEqZp2qQZgriuCKjig6pXqpWFLxV?=
 =?us-ascii?Q?YZV1OA369MFgXbZkGN5FLnJ3usp0IBhDvvnKQcw9OEmpRVnvFA4FhqD1+YHi?=
 =?us-ascii?Q?NydtZNiwiV3QmOq3OYr2tBm3HX/UJjDO+DBvIj3yYt7VDNJoA+Wm7uRrpmSZ?=
 =?us-ascii?Q?BwOPLcR2/ee1lbvcYD0yWNDUQQK4ylyUAvuZJLSZ3t/+UrrZmrymdqjiLnf8?=
 =?us-ascii?Q?2UKl8Jn6PiXjYutoZJv4AwbcSRTGMO1hgtRoDhd/3HVgU8YSuzmkcrphunFh?=
 =?us-ascii?Q?VBoizkdwdgIcwYpyipmlV2IyQ+mdAE6n8FAZ/sG/HYnrdD9h1tTKlQ9cQzol?=
 =?us-ascii?Q?sLAsgUangLXBYy/TjV0BuBULRSqfTeYyEpU5q0nKxRJDtf+1BFxdB4IykjYY?=
 =?us-ascii?Q?+30ReLaFnjzwzvSn7cPlbV1pU9dufxphcRgdXnUgJENlOv0oxQC8BP5HASbm?=
 =?us-ascii?Q?2qDFbK8ExL+9wnNKWkaRJtgOefofPvlYsZPWvWzR7e6rnILF9OHZeI3IBmUF?=
 =?us-ascii?Q?zusrVwZ6D886GmyG3JGRxr+QJKa5oLOBglHpTNfmFlVFWFpGtOi3D5mVtWCn?=
 =?us-ascii?Q?Xu7aSfjFLzHBBFktY3VJbrvhCPUH10qOM+iZE6n/4k5EuOV49hp6GSXDibx6?=
 =?us-ascii?Q?UHSnfw0528qJdwTd2vZ6/EB318oiI2sKahKQZnf5NmliNbzfWM60AVG7mCCA?=
 =?us-ascii?Q?mSODVX8RHd97HRf82G6YwoBPuOJf1o/1aYpIyLcDCmxNwZEvXMCujnVuZi6Y?=
 =?us-ascii?Q?ySHnLeo5qUXJgbfN1US3ZBM+JYSVzU3htjJOYuCmyzQ8ha82biQoTDp3u5Ac?=
 =?us-ascii?Q?GBlFpHheTMSJQodSb4g6o38wDejCQNM43h0JOrrekgKEB9/R0j7dmpy9n42d?=
 =?us-ascii?Q?Xy+rH5+kq24PPJ9UTOEHuxrou9KK0UtGoZVR3iZIrc834H2MRK1CHb4u/tlM?=
 =?us-ascii?Q?92aUi1PvOMg0npc6OKKvyIHcR52lW2IScTtPpdHgtMirybwGeuPezaAo44Q0?=
 =?us-ascii?Q?7CwjPH7IMwbriDHaRP2jaETqxGKfdMQCpqbo1ZXHndt7puDYrQTriYHA19CF?=
 =?us-ascii?Q?vAaGD4Ew+LeF594ulYexj/EaAoclwiHh0OSqfdmyBJ9VjDCeD9M90ssePTv0?=
 =?us-ascii?Q?uxMfX1ZlKxWqczm7LzXvfD94qDk2lAlpBwEj7sCti2l5jL5a1i2qfKv4THP8?=
 =?us-ascii?Q?8saY1tinOZmiSIx4CkJi0qIP6hjiwf09XpTF3Vkw/eWwsMMy4JpqJVBeYtI4?=
 =?us-ascii?Q?LagVzLML5rRHHZBsqzoKzMpbsYS3fiXiK4jjaVu2V2sC+/XwenSC7NlkNGp2?=
 =?us-ascii?Q?ARfQi3T201uQcDAX8uRAwBG1TAY1qp06LLBAo1V27yaf8XH0vaJENywtRxB0?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78058c20-a124-44aa-ab42-08dac809e168
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:36:38.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9pPZsCpQi+ecYk5O2hxOgN3vC7wq/F+GWiO128RkxT5ot9pabrRMEaCHwAW73PXIMi5nRSn1ukBtEUnXGBGuk7POOpX2fCUQu1PT5ViDcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
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
> The link capabilities of a PCI device are read when enumerating its
> dports. This is done by reading the PCI config space. If that fails
> port enumeration ignores that error. However, reading the PCI config
> space should reliably work.
> 
> To reduce some complexity to the code flow when factoring out parts of
> the code in match_add_dports() for later reuse, change this to throw
> an error.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0dbbe8d39b07..8271b8abde7a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -47,7 +47,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)

match_add_dports() never comes into play in the RCH topology case. There
are no switch ports to handle and CXL host-bridges are only ever dports
in the RCH case.

I will post the cxl_test enabling for an RCH topology so we can compare
notes there.
