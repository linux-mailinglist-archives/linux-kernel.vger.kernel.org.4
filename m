Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041B967EEC0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjA0Trr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjA0Tr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:47:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D488F07;
        Fri, 27 Jan 2023 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674848695; x=1706384695;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MRJRSLbRuYFxy7qAy3oiz9WuMsP8wPFQOsfysRdNXHA=;
  b=RvbXsTku5kZEc+d/8uHOGpHMNbIsPN1YsJP2eHQhQi89tXELj4nCvMuB
   a9+lcrrKpccdFwvpMTKSnuF4WRX17soBt6/NlDUdwCfNCDYQ1A/cZK2yL
   diQZUO7KEbF/lFjjuPKdI3M+w0UxHImf5HaGy7OOCNLxDHRyHEBGWvwYh
   RspBBCs+mbI5yruHtvoqTf1LpzAfbJLHHkfF36QF6GhcU1LJK+KbmnuLZ
   RGZfLBiljtZ+vhPbuOPlzZlvlM7s2K0BRTdT64jAPFV/Pz1ah9WXB1R40
   cNfrtHJ5D3+HrLa+VeL5yfdSmynvITGg55Wi0HBgtwbWdXUhvCqcSD4BL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="354476137"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="354476137"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:43:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="908776236"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="908776236"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2023 11:43:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:43:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 11:43:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 11:43:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLo6PeTgnqjtuVAP18JnZiRvtR0kksG+1aA30C+dCU4Y96ruBwGTQhvqX3bqYRYzmsWpJYkGOqYP8xa2eTtSfsNLSIIXG8I9GmuMQvAYuB9RWpI6JI6+g4FQkEg8f0IchNDsBvRJ3NIiuBRZEx43tQc/8bXTSdN0Z2Dy00W/E6uJFiQ85Cm+NIyaBRkk4ka0gWFGWlWavCUhnFrBUU/L7W7m9GNrufTRmX0ZMaTeFFaXcMGEtRF6o5IyKYFItLWXM1s2OiObJMUw56TEGn24sSmOcDC85PeZmeJ+U9t2KUbp3QIOnA6HBZibMXuukRfH4Xv2YGuXbcN0aT8LfEhSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny+24VjjvcOOIiabUXX2wSUqD1CbR3GwQ32WXUFgVIQ=;
 b=IMr0yIGExZKvu91j24D7O7UELsGuZZ3x/TO0olDTuAidWDB7Uha+Kqw6BXEqCcRlknSXayo7ET9vh/i23h/scL9x3EAJ8YVw55zW+3fPosPYvV/V5V+Sfq8iEIQfZpnIkydKCGvdbOxyfybzA2hvuZM3GephcuCY6+jZylijVIwowFq17nTSh/fIxI7mvXEXUqq4/HjyoCE3NFKu+/0Prt1EPwjntTKIHM9vuMt+A72Riz7ROxSkUIT1/TM+qlNf/fbtmnAT0ovhc6vYzl3ORzB/YosmCGstRGpYkK4D77/LeKbfDhujLE4WhVLXooZFV0uwFcxA0sLNZ1ZN1urZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 19:43:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 19:43:02 +0000
Date:   Fri, 27 Jan 2023 11:42:59 -0800
From:   Dan Williams <dan.j.williams@intel.com>
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
Subject: RE: [PATCH v5 3/5] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <63d429435984f_3a36e5294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <fc1a2f51834888c2ea585efb0b4fa41cd251e52d.1674070170.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc1a2f51834888c2ea585efb0b4fa41cd251e52d.1674070170.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 067f666a-cda4-45a2-11e9-08db009eb3b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgpTL1AXnMRfefchbKyuPcJMNFjM0wUUmH23YJkQu4nGQGTs7eBjFVxcI9zzZUDzYpAmoG5mbon85zKk4TvyDIYGhEDqDGVpjrRvOUZ9wwckPUSmlnfgX0fE65oAoOHM+5U1deF2D/E8v1FXOyFT8sdfJGZnhJm+cPE7c1XK5xxQViHOybTi0Xq14sUayrdllSsOCGLAz/e6dTH46XijLpm5IBjv/6IDDg98I1EH8VG0TtTVe4am4XVyuCXnWdk8/IUePeXlF5EB18oFFSdAMsanLj2nAKoaprt84Gorhli47+m0pltK91OLtbw+Vm3YULWwMz9T+mWCgEnSiVvugXKeZY/6S0ljOwa11LDkhA7r+3lVM3tmTQN+wk8rmZRO8jrBnngb6RnTBQImmAMVN/LUg3KYR9ujNV/e46LB7YQeQhb7w4np9rxqK7nooR2HIsrPnfZxqqx8OyS4BroqTB730G18wlvP5qfKRyS9AF35liJ2TqAYX7sAENwpQVUN9iVk5REEGeXVHQq4Rp22TktxAzr1Q6nQMk/cqx7xiFXsoJ1Ubw+if7uZU2+Vh0DpfJNNJlxaCwProEjMKc9LNVEkiAsPTiuXBA5VjG5Qsgd1JnUrgll8EeZHjAZTcAqEg+OSkm8JK/pO45cFqPbvlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199018)(2906002)(41300700001)(5660300002)(8936002)(6506007)(6666004)(478600001)(9686003)(6512007)(8676002)(26005)(186003)(6486002)(83380400001)(86362001)(82960400001)(4326008)(316002)(66556008)(66476007)(54906003)(38100700002)(110136005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?si24MDeHnirVKICnjU3YXyjY7u43u3rnskTrs+seZjVC+86fzTrpeCB9eECj?=
 =?us-ascii?Q?qpf/liat2NGS2AFgt0v9EMBVflx2nk2sQpsdBtv4Q8BVGeb4UoWiSS2ULQkf?=
 =?us-ascii?Q?x3vptiZY5rcPGRigEQgQsLeMsYuOM9xGATPtTnzBLJpLq6W7DcHbCts6tQAI?=
 =?us-ascii?Q?u8MJeDq8xM2kCZjGL1taalGKr0zV7IMyM0jDmDNbE598cb2uao1HsqeUlFgc?=
 =?us-ascii?Q?giqQIBwk2x+QWhQQwX9J8SdU//0gjFhOPww1c2rRYpU3is/JJ+Ccx7oRzzJU?=
 =?us-ascii?Q?Av/zrtakcJDPV5uDTQCvbh+nUUylWWk54DLdkIM653uMGbhsq5nhgr3PubqJ?=
 =?us-ascii?Q?SxPBhy3yVq6hAxEbinvwlc2a4JIoOzkU2EjSPGiLaGjh1mfgxNx6x81PifKV?=
 =?us-ascii?Q?v2lKNWsz4cnXCcDe3qcuyjDxi2Khgl+EY+zhytvy3ORC6VNZ+bhpQaciIAa2?=
 =?us-ascii?Q?kJALnqMgH0JFVzz54vEPKPA+xArDDFybzcNI7BlBDhmsm4qe+akEpcZU0rgg?=
 =?us-ascii?Q?b6mgRxo3kJxXF8mM02id+D7H4SeT4Wm1NFc2MLnmNHa38Ohw5pPoVqliDGgi?=
 =?us-ascii?Q?o5+FWiPArAFX96d7DMexk7wFBOY6Z+niqyTeWIKUeco1uderb3mImH/wxjgy?=
 =?us-ascii?Q?v5GH0+e/ph8KJ4fzy0peaB9Ep8BbzDMV/adw7zd+L7to0vgHp4IFAWMbqYpY?=
 =?us-ascii?Q?4L0CSUkTdv/KxZ2fGH9pKn63TO+t1fGIhU/7f+hjSiUDXFiirEaJyq1XFBYW?=
 =?us-ascii?Q?DMT2X56jBQMb7+HUB34clUq62cfKD9RDLq13yPIYtf3FOTEfQwGX/5fk+NRV?=
 =?us-ascii?Q?AE77c5aTz+USkXEBzrqeOFzVxvGiuYjzfCPR6Ln8xKsN0ssLwj7n+ZH0WFh9?=
 =?us-ascii?Q?RxkrGLkfMNls3lR2kfj9tWETv3ytD8VBERRlKepzkg7Q7zw+u6Hl6p0nOYUo?=
 =?us-ascii?Q?aTLVfvjPWI1gJU6Sm1eCzIZKZu0wIkYAmpSxy/GHl+cAkRQCSFhITZd0PLIY?=
 =?us-ascii?Q?SDcbgWfnXMgOexvEjmLU0GXGEfHkYDKJpHySgxJOAjpt4/0AtEH5BrK1Bg9G?=
 =?us-ascii?Q?e+gcOa+e9oDD4ue9zecVYG68P8KI284eL3EZgN9T2u9W7yacawUDuvl6puMy?=
 =?us-ascii?Q?AKZiskyWVEk/Aq6Z0cucFxmoA7XvRvxymuXo91enlMlf0PCi8ApZgAkXPoOj?=
 =?us-ascii?Q?OHdn4DI/EtYSJ0YTSiOqVrPg0jTBtdncKX2U/Op6eQ8SnmhgkFTvQrrkgKeB?=
 =?us-ascii?Q?9ZJUe+oYAxoFBGKvjxVwSmjORRXqejSOwYvwziRDjbhaILKFT2piF+1cSk8L?=
 =?us-ascii?Q?pxcEr8vNDqZnBqkqWEcl9dx+PIfMCqZUHsHCEBUPesX8To5FyLtImeeaomfU?=
 =?us-ascii?Q?5c7TywYHcbCZvC0ZVKr9n6mAASCpXc3vUHpQ8JcmNqpHvU+TJWmz9V0BHV68?=
 =?us-ascii?Q?9OXbr4Pd6rnXicC9ILVHT5v3QT01AzpRrsURST2JyEAZeJroGH6JDNkQE7en?=
 =?us-ascii?Q?yHmFbv8J/E8Tv+9QGIOL41+S/WibwJwvYWBH1QgQ73W2l/aJ+VFKoBweTE93?=
 =?us-ascii?Q?1Egp1AHhHFt7neldB8UXvF2tS7v7b9WwvKvxyUusvXDzETnzCCwin1VgWnd3?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 067f666a-cda4-45a2-11e9-08db009eb3b3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 19:43:02.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lknj1h5txwjx1kZuoAU1mGjRlaDdNTwPcV6hXyKcfDkei96hQD6yXXPoHf7IZ6nJ7ohftqrtPJjgnOjL6/Bsf+RDwVFgMzlvJ/PDONejNJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
>  drivers/cxl/core/memdev.c               | 45 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  2 +-
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8494ef27e8d2..df40ed09ea67 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -388,3 +388,17 @@ Description:
>  		1), and checks that the hardware accepts the commit request.
>  		Reading this value indicates whether the region is committed or
>  		not.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> +Date:		November, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a boolean 'true' is written to this attribute the
> +		memdev driver retrieves the poison list from the device. The
> +		list consists of addresses that are poisoned, or would result
> +		in poison if accessed, and the source of the poison. This
> +		attribute is only visible for devices supporting the
> +		capability. The retrieved errors are logged as kernel
> +		trace events with the label 'cxl_poison'.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a74a93310d26..e0af7e9c9989 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,49 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t trigger_poison_list_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 offset, length;
> +	bool tmp;
> +	int rc;
> +
> +	if (kstrtobool(buf, &tmp))
> +		return -EINVAL;

Wait, where's the check for "if (tmp)"? Otherwise I can do "echo N >
trigger_poison_list" and it will still run. Should probably
s/tmp/trigger/.

> +
> +	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> +	if (resource_size(&cxlds->pmem_res)) {
> +		offset = cxlds->pmem_res.start;
> +		length = resource_size(&cxlds->pmem_res);
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);

Ah now I see why the region information is not provided in the memdev
triggers. I think while the scan needs to be done on partition boundary
basis, like you have here, I think the region lookup needs to happen on
a per-record basis.

However, that's a significant architectural change, so I am going to
think out loud about the implications.

A site operator wants to know "is FRU (field-replaceable-unit) X bad,
and if so what's the damage?". In that report I expect they want to know
if poison impacts media that is allocated to a region (an imminent
danger) or is in free space (a problem for a later date). If the memdev
trigger does all the region lookup per record it provides that
information. Further if the memdev trigger reliably provides region
information it allows the region trigger ABI to be deleted. The region
trigger can be replaced in userspace with logic that does:

   set tracepoint filter to look for region_id == $region
   for endpoint decoder in $region
       trigger associated memdev

...so I do think the arch change is worth it, but I am willing to hear
counter arguments.
