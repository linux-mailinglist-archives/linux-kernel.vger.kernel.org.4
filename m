Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09AA67BAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjAYTfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjAYTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:35:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03E4997B;
        Wed, 25 Jan 2023 11:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674675312; x=1706211312;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DjSzYoCvw3gY3t++SjA9T2OGq3u9N+cfLwvPA+C7/CU=;
  b=mlFrn6T4tgqOXbiQx6Uy7tQXAXAH6dQHHFZHea3nFXNArSYtreg7PZHT
   u8+/D8+LnWiRQOkNSPdJbvg3VrS5kLUAPyXrHiINgppKSO5bbyjxfLxbQ
   zooeQBixwuuYB7o8aESA0KtCtlQygXQMvsvN8+MZjRjWYN8insnhwN6Bu
   1t3p0d4CRyFOUn1DcIbn6G0VTnT0lm4TGVivWY4BsGozXtYDcPukDMIGy
   cF/GloxdzyQWKA+5k/jro3oAvhwVCrO7AeTiFEduWZtJxoRncS7LQjuDR
   AShzMRd8vyQxW/vaL/HQdNPi2lVgmWAKC2bc9EwGEi/zwvX8AOSbJCQY/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="307000387"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="307000387"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 11:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="836443809"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="836443809"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2023 11:35:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 11:35:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 11:35:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 11:35:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR9/Idu1mB2f0sTE9CmRVOcSzr7RcMTPdMS/AxLQUqv9gqIzWa6UnhBpZCUnwyPlkIrP6AilnDoYhucH8NaEbPrB2OMUlHjZpxI9YyczREdgybfOAgu6uYIW0gZIS7NJJUhn2chInpXk5y9+s3mye483XkqTW25H1vty6k1oZbjGXA9sfGQHiAghC1NqugmM4KaRgZyMVFjcCC5A1KIPEFqCk1BFqwcqJfKbUze6jTswyJlTNQNohXath79VZ6XUqbO6ov4wIEnl+Q0+U+aLj2zwfuXFymhukrlOuA6sPCpEUIbKMrWlz5H/1nsMNQqWtMGxNFR5IujvavE3a0aX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClwnrKSzGOFrip7OVOrxLgvGQlizhNV3FcjgSFPsKpc=;
 b=SH0Sex6owmrLDO2NqbmTj35tDNs3BvRyKEdz03Z0EK7yCO+rks92wKIs7P/OjhuqvqY6ED4YaDMHmCHmY4/eldPvrIEqSGmf1TWJVQGc/xBLLrhs/vmQRxaTvzioILrouqSQT1q3UvTXRvyoeyzS3Z+C4P8bbZldw+J68/qH14jvWDOYPMZB2HjjWvKX4+Ac1PmhkY9MP4jpnEhQklC+KxZ9Mg2wsYX5w9gvCw5u/P6vxFDSYx5GDHpvUM+ZvhJB1u4ys0iPwtEnBc1MmUsEreWyPoGpdEVYfXJKOhOOjHwOmMDTS2KVyXmlz5NpP23yPoUur/pYcruiYOHve8sfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8213.namprd11.prod.outlook.com (2603:10b6:610:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 19:34:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 19:34:57 +0000
Date:   Wed, 25 Jan 2023 11:34:55 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
CC:     <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: RE: [PATCH] ACPI: NFIT: fix a potential deadlock during NFIT teardown
Message-ID: <63d1845f8f86f_3a36e529441@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230112-acpi_nfit_lockdep-v1-1-660be4dd10be@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230112-acpi_nfit_lockdep-v1-1-660be4dd10be@intel.com>
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1cb3a9-16c5-4f05-6347-08daff0b3dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXXXYFdfpKUMPLdRWbkkLj/gAAwWHlRgqy/tJlQopza2p4XcVQ30nIJz3Y68RbGfKEKNSA6BOPbjbgteRxBU4/be1qmO3VL6fpsCP3hJLj8g+wwTHrMapT08ZmTCQ94KOyKlrAZT/Tsrg3lOn7UJfbQtEt7p3vZBZBd2JYDGOVjNxsbdYmtZVArbUOB+HF04lwCRGk1N+b6uJDfcNSy49lOI0adz5kveZvRM6lsfoo5dK+7dcKU/xjcrHa9o5bAWyOkrxs/ywjYxHRufLSllhwUHXBX94jwdiY/fWwu9fBUbJVNZi9c7oZ0iWv9zQ9fvVFgaRvvwfO9CJzm7GIqzKZEbUzSfX0F/nAcaQwq9fRtOnq7QKH84rNZy6UyEp1e0TqnX3IqBo5pVvMX3PpBEd7bGHRwUIi3JK6E92/BWeloBL8VdcQ/3KSZu3QtbygtaZ8TB25zC3Trr/mfzzEDUvlAD34uTSxu0u9AJToBgWlTdad5MnoAJ+na/Bdmu5V/IrW4X48I5DjgEHbN0D7naGhDtmB+dJQz0Cf8HHQlEjUYh2MZP0BXuojJNkMDemYbkowCfQD6kN4za1VhKeVyWEZcD1iE6vyJakCwj29FayT1AkCMGx2jN7slh9vKG8ysTsrFYCmeS3X5/4sJqK8SGtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(66556008)(110136005)(38100700002)(82960400001)(2906002)(6506007)(6512007)(9686003)(5660300002)(41300700001)(83380400001)(8936002)(186003)(107886003)(26005)(478600001)(66946007)(6486002)(8676002)(316002)(66476007)(86362001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48gi1aFPFC5Yrfqu+XfwEZU1pnUbi+bDRmm0Xl5AJ2ozwKbk8tTo8zj5uA3o?=
 =?us-ascii?Q?3N4orGjU8UQlde4BSJcr+4aIW9oz4cefPlaK3oiktI9YEUnI6ZzRwccls2wo?=
 =?us-ascii?Q?wjD7utXUblGRiP/ZomhPFlvFnt9AScFot/ydPp+Oc8kDDnr6yzc5APhLl4ou?=
 =?us-ascii?Q?81DBz+2/cPp0g6GamlHfTPC4/lKnAIPd3Rbrp0XCSk1aJifPMLOkztlRzi0t?=
 =?us-ascii?Q?1PULSeW3wYOWT5xRiHnlMEtQXsR7p8l4cmG26N1D3a7XVnjzIunjO2wL9AAq?=
 =?us-ascii?Q?h5ovR7ULHa/1wMMuRXt93jO1icFMFa3ZQSDZbQwxCccpklV/P14G4Mm6fCUm?=
 =?us-ascii?Q?NM94lGmE9DBb0tm34p/QEtNNBe1UrGVhV94palTOJUfL43ts/1Mq6tCwPHl2?=
 =?us-ascii?Q?yGcmUEhljxO10eF0pLS77sfqn1HoMQUMbNMDf4llYiEnMkEahx+rdqh7qIcT?=
 =?us-ascii?Q?s0Ziz2wiBs/AA1VUxoUaq4V0H510MH3cb0fwliw24jKQMSFKJf+cVzGAZ+Dl?=
 =?us-ascii?Q?0dtnWDdb+nfUab1OmM7Ser0qSLDAuzW3yow23IzJ8tNAlQv+VRIFH56Oypd5?=
 =?us-ascii?Q?Qbio+2zhiNuHpO//pk1VkPjUtvX6O2DReOU1T8VmPp+Ea3ejyKpajSJuBXO5?=
 =?us-ascii?Q?UVhQ4ZIMNXWkDvQAgMN00xuq6Th3+y8hcB6Ry6rCxPhENsrJPgM5qIt+3b6E?=
 =?us-ascii?Q?sG9zDPqsuUipBuatZI/HKAlmwPCWYv7XCHN0qe8KR0ysf0wqae1nVYAXppMF?=
 =?us-ascii?Q?5yOdSMXS9rgt/ErfO+awQo/6keEG3iQKRrH/vhzVhX1IJnV6a0mYir4F3F3+?=
 =?us-ascii?Q?PmRbRAypn+JikayaZBkHhukHnoNBrKwHwtOZC9dfu6E+0fUM0lfR19PqxBsg?=
 =?us-ascii?Q?tmMHkP3+nbpPdfkPOWARMHeOQmq+FCEo98yniJ12hZxwzXDGaYQrFwn5OGOC?=
 =?us-ascii?Q?PUiDqJeyLeIm+91M4hanzsbMFANGxPeHoscjh3pY03F2B2RX+gBZvanf0T3J?=
 =?us-ascii?Q?sOW2A+v3LDqaNwr1U2FZZ49fTi73+o0hV1IGdQdtjUCUfd02W5aQID/YRAet?=
 =?us-ascii?Q?StDx7EGHl4qQCn/2ytK/o01PVmdAAHUhIMpxnzrdojNRJegra+56M5N8U2JF?=
 =?us-ascii?Q?58W+GDZ6rgAjaip7kKyZMJFDkfYR7pSjGAGNihFwv+Mh4CxcZoQTdQt2Wu5R?=
 =?us-ascii?Q?fC37BiromWWGgGGweRGSpxeKuJd2Ho3lK/g7OQ4oaI9ZukgLUCUvE/oZjwDX?=
 =?us-ascii?Q?/rINjQXjjzQfrzOdYxMJG125GXFDV1iji4VXFDonS+k5fahd6CWX5uHy0yoX?=
 =?us-ascii?Q?1MjIS+lilp8a6FzP/ajApz+ylmxyjPNQtO0ZCBb0BQURh/l4G2mxd+QZYPCV?=
 =?us-ascii?Q?lSKzpFtOYNHhS4wJ6tWJmOXODSCZzUKrm8ybOIR9EG7aGRoUCjMl0VuYFgkp?=
 =?us-ascii?Q?aYPaaNFMTcdvnjw8sn03yFeH1Exy2PIRnkx6F1ff+klv/An/3JH424t8nH6g?=
 =?us-ascii?Q?uU1FPr6OguNnRcxQAAassiFtfexdqT3PEJHbK3gyKT9fHAWC4rStldQRzlHb?=
 =?us-ascii?Q?5zhbJiBRayIDpQL1eOWoHRqghgJv8HgOyN029aTqU1lE5/954fx6pGI1DFao?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1cb3a9-16c5-4f05-6347-08daff0b3dd2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 19:34:57.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKKUtX/r3u8s3eecXe+li68f7+7uQZaLEY9L9hO1DuE+FUykBUjvcHNZC1wL7alZjhfKVd0zQ6ll18l0ogwI4wZBwks85t0iYt/fyVBfvvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma wrote:
> Lockdep reports that acpi_nfit_shutdown() may deadlock against an
> opportune acpi_nfit_scrub(). acpi_nfit_scrub () is run from inside a
> 'work' and therefore has already acquired workqueue-internal locks. It
> also acquiires acpi_desc->init_mutex. acpi_nfit_shutdown() first
> acquires init_mutex, and was subsequently attempting to cancel any
> pending workqueue items. This reversed locking order causes a potential
> deadlock:
> 
>     ======================================================
>     WARNING: possible circular locking dependency detected
>     6.2.0-rc3 #116 Tainted: G           O     N
>     ------------------------------------------------------
>     libndctl/1958 is trying to acquire lock:
>     ffff888129b461c0 ((work_completion)(&(&acpi_desc->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0x43/0x450
> 
>     but task is already holding lock:
>     ffff888129b460e8 (&acpi_desc->init_mutex){+.+.}-{3:3}, at: acpi_nfit_shutdown+0x87/0xd0 [nfit]
> 
>     which lock already depends on the new lock.
> 
>     ...
> 
>     Possible unsafe locking scenario:
> 
>           CPU0                    CPU1
>           ----                    ----
>      lock(&acpi_desc->init_mutex);
>                                   lock((work_completion)(&(&acpi_desc->dwork)->work));
>                                   lock(&acpi_desc->init_mutex);
>      lock((work_completion)(&(&acpi_desc->dwork)->work));
> 
>     *** DEADLOCK ***
> 
> Since the workqueue manipulation is protected by its own internal locking,
> the cancellation of pending work doesn't need to be done under
> acpi_desc->init_mutex. Move cancel_delayed_work_sync() outside the
> init_mutex to fix the deadlock. Any work that starts after
> acpi_nfit_shutdown() drops the lock will see ARS_CANCEL, and the
> cancel_delayed_work_sync() will safely flush it out.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index f1cc5ec6a3b6..4e48d6db05eb 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3297,8 +3297,8 @@ void acpi_nfit_shutdown(void *data)
>  
>  	mutex_lock(&acpi_desc->init_mutex);
>  	set_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
> -	cancel_delayed_work_sync(&acpi_desc->dwork);
>  	mutex_unlock(&acpi_desc->init_mutex);
> +	cancel_delayed_work_sync(&acpi_desc->dwork);

Looks good, applied.
