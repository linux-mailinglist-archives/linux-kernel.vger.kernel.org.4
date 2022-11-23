Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7313B6369D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiKWTXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKWTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:23:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F167F7819C;
        Wed, 23 Nov 2022 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669231430; x=1700767430;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sx8YtBflpJqHxht+zbSr4BVUjKTsGAYlQ5L1i9pwJQQ=;
  b=LTCQVC+1aK65EyLll74YPoQEHQz8BBhxN57X/Yqqjk/05gL+o+S6jucJ
   CtkKtRnHJ2ACWTx/hDX4HfKLRpGOwjg+vmCwN34rXu3d/a84zEd6lHrld
   Tpo2haXRGv0V7s5LAjn7ryN0GXDF9dOZCeScOUI6hZxWx3eNG3B7Ecaek
   xPALOnZsxWdjhD4mcKIiDXkrPso/X6s+y/OO98mLrZmhLp2LH8pIET1AM
   6/9MGU6FV0vM1cxixlTDN6X8C/tAUXfO6DACQ1MBHmCGrR9vuR4NXNrYN
   Pwsiqb4cRrEPzCIL4DbxmOsRYJolQa6yHkbk0axUe4WaiQVDyVsHmRFl4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315296030"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="315296030"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 11:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="674831278"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="674831278"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 23 Nov 2022 11:23:49 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 11:23:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 11:23:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 11:23:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtm23dCRI/IgRnn9c7FIcFOabOhBn5dFASjJmEt+Y+R4tSFpbapPYEgq5QMXdVbYcbWKTMyQCQF7jUk419ktSAEa85cic7VNg3/kNmkaC4g8IG408X9Q6K3F0Orb5q/YY9oCxryhYSLvBO6a9aXBmpXNhickRcU46CbE+INsM6UgVKY+sL12IZv/IChYTreVBKLYQYCOx5qzUw7cUI8DxNf9+vnCwG1XMhWW7LVxnkPZBVttc0bIBSrkyMWR9wQOcPNCEgGFtpjDLgVG/a7JfPdlSda4BcAYL5HvQByTgWYgv3MajxXXMsnqABPL3GQbD77jx9meGtSq+xCCvssw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dHNYdRBUWWz9Zt4vOv2geNY+yth0Cl4v8v8N63fv10=;
 b=kG1sFol1GcEFMqDXv6ElPMN8Czj0oXRsD0X3JTpBNiOpx42/XZUEHWgR25u20Sj63lfGxR8WB9n40al775PqOIRy3k8K5gWkamR3971wxmwLHLuyKxSaYPeodMAFV8wVs6q3BWpMZ4gfprU199AamSIYZqA1vBcFc+lGitvHRgcGxl7ePFGPuum6lMa4E8C4TXL4LbPPpcxvRbVmcRMujNxyruJqSCZo8BEhafocAjoZxtOcJOLxL7VHOBppQXsjObWf8gOgXvIm+U+HY1NCEOyXA0FXOz+w6MEuBtPliXgKhZu4uN1UQK7DIqc+nUu/TFjdWbUVEkXuaSjdqBz4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6825.namprd11.prod.outlook.com
 (2603:10b6:806:2a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 19:23:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 19:23:41 +0000
Date:   Wed, 23 Nov 2022 11:23:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Won Chung <wonchung@google.com>, <linux-block@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 4/5] driver core: make struct device_type.devnode() take
 a const *
Message-ID: <637e733838b5f_12cdff29466@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
 <20221123122523.1332370-4-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221123122523.1332370-4-gregkh@linuxfoundation.org>
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b21d04-acc5-419f-78e5-08dacd8839d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWKQFYMwJ5htuwszjkOEj2WKyd1ejsOkdb4gtn3/F9FTOvbVO/WtG6lWaw2lL565Xbu5bye9oUvVm78Bl52N4vnIxOsab8gAT5p77x/BsiX9b35qrkhr0VIQzxxjU1v0Pma8xOOjsOjV2VUjmgKR+Rhlle9uaxZ2bF6g4TWQ9MKcEvUEHsr7q5gz1k+UuKHxFaN3wq1M0KWVkI9ABlyBE9sNUNOIJ32LbNTpWAiHjLx6kNb4GagZgPM38WlM1p5eRH0tdpkibX58YvnImIdmtDHENFAgQNoDGzI/wL3lRWGsdQuRVdlWZzAhCGh5sl/fgn2nmbRwDnImIQf8MBGetJgz0exN3uwSBkCtlEg9fk5i6ZHJxrXfxp0FTezGBu8F84USwF0dWB/cIPjcfH+LTjm1YVEfH26TtiWnTUkventW6Me9UIM2Oual+OeVKaEV1H+fYX8pzmXqzYcD/GTKmt3rEix3IKq8YfXQ3hWuW+aUXk27v6Lct7+G94TWwrbSxcvolvg1+oBzRHnicVnK21pVxOMSWJ+CqJVhrFeK/NfodCm2rYaSkUWMTzW+/Y1jfuI/qP9FezhsuczOJZwNuodXfidw4XQeA3dcfSI7SmTCxsFOQPNTnAv/BS+wq+1JpnfRuulk1pkRoYLg/DXByA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(4326008)(8676002)(66476007)(41300700001)(5660300002)(8936002)(66946007)(478600001)(6486002)(316002)(83380400001)(38100700002)(66556008)(86362001)(26005)(82960400001)(6506007)(6666004)(9686003)(6512007)(186003)(54906003)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prQzOnHJzwAe5tBwvvR1tLGDRr8KsFUTTA8YO6tAawe/UXsdBdyHsCR+L2ON?=
 =?us-ascii?Q?hmTOcfO24F6f0nzOddbK5k/uNkhe/0/fcoP8CHZg2NLDt3CzWGh5n2Yp8Plu?=
 =?us-ascii?Q?kJm9MrIZCDkhbde7NdnsCaWel8+fN7Nbybc7UQEaKgHBX65ZSXLPY2ZBdXJz?=
 =?us-ascii?Q?s4M1hLWVjgU2WZi5eFo0jndOiwhHrfq4tHBeY/lCm1k4olQizzr7RtZ5ZlZh?=
 =?us-ascii?Q?RmZvVhNIrK3cLWFtRoPy1xIGaKbstNzYNdqZLOE+fQyLnz5YOJ6kaPkwch4L?=
 =?us-ascii?Q?Q/7E8YHDYQBKs3AWAR9vqCQQXdakaQKIt1pu+rmWjmxsN9dTNoVjnc5u0Nq4?=
 =?us-ascii?Q?4nTS8Nb+w3wY+axKoepS+28scz1vgq5Hb5DJKJAdayX/w+hrmlx/abZoYY4l?=
 =?us-ascii?Q?bo45FVQyNJa9XcxtKsfoz4XUU8egIFGCB1DaVHHUep65TFhXmENW7Vyfk+6Q?=
 =?us-ascii?Q?20dIRVu++4L3KFQ5SRMyH18E9/Vybfz3+sxweVApB73r5kwLPMke+g+dLhVO?=
 =?us-ascii?Q?3AMmlwBRp5Bt2c4uv4lisqyvr0K+ajOV4sLahDpFgPOADo3Vf6UUOFz+TiaO?=
 =?us-ascii?Q?rg4Kawk5RQmGQMK3Knk6hvfbPvLGY84dOwZJSkc//oXSrdX0iimaLC6ycPU3?=
 =?us-ascii?Q?GCRMGMGE+csrd20sFMrHC2IZNfDimZ+KKZQgNcmLcMz6ZW2ULI+S66IVy3zj?=
 =?us-ascii?Q?zGVgLhKjjyz0l8PszXSq9PpC3BLRY18krxH1xWzqKTG3IsBrx3DjRVEUYTa1?=
 =?us-ascii?Q?6AUAKhgzP90IxTBK9qEfOg0YJozRzLfZE4bR39tqTc7xQ1WLB/VDOKTFJhMB?=
 =?us-ascii?Q?n2iEoZJJ31SsKoXU6vQgJJzFbbBFDRjJmiVu0KeHRnu2hLQW0OnYOniIBUdZ?=
 =?us-ascii?Q?3dicNpOFoPCL7GPR/OrDQXqWLZkFGqLg55fFfLJsc6HU7nYhPw7U2q8AEcAa?=
 =?us-ascii?Q?ELSSDdXd9rGpzq6ocmKGAzv6n25K2xmZOru1Iiw/hiLTjUGv3M27DJFiwdjJ?=
 =?us-ascii?Q?BvqzaB5/SK0wrqB00TKsrNUliD2PlJNsutBSpoLesOOkQl2nXq8Dc+YYzPc7?=
 =?us-ascii?Q?UwlE1vZoPUKTQzhi8U1FokHlXnebDOZTCpWqdqtH7McqK28OLW51ddLXvKBY?=
 =?us-ascii?Q?zfmawqq8+26qSUTJJJVUNxQoacCgo88hHQB/IvMmr5KQlBVLosaqGJlflg9F?=
 =?us-ascii?Q?tPrF7w/zi0+TpQphVHD2Z9USxDvte8GO0Eq/tnKbix6xdRNq/WiB+uFn8wS9?=
 =?us-ascii?Q?aDmYsAAYu5sVJFdC4N0WOTxX0EacXAOhJsBHX5vY7y14U6jrEPGrhy+XTMJ/?=
 =?us-ascii?Q?X616HK0TexGE3yyt7SnajT97dxKF7WI7I0FHIdp7CXcBDsXdcgi90WTVLjR6?=
 =?us-ascii?Q?g38cRslysS4SFt4BAQAOyXuipENHty7DhWROnKpww8abAGNSNQvDpNpKU1DB?=
 =?us-ascii?Q?5/OtPRdR9G6Rar7aTcp+vh+Dn2h1I+LZvgwU8Kmic5y7NcxmxxBIE5xIz/0J?=
 =?us-ascii?Q?4vekGDDC66muXYbDXzi+w40zTRjRi1KEva6nacaBrqON8byQYDOC3R68AIEK?=
 =?us-ascii?Q?Ip4X31rNjyCmyTjfa+k80ePhFuyiQFGKFGyGag17vCKx/Cs5toDo8ujbYWYX?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b21d04-acc5-419f-78e5-08dacd8839d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 19:23:41.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d4Rb3gRAt+EF7IIe5+HPWTaOYwgx58FF7BVf1E9HkM/8W+b+RYYY7iGGrzbEjxEfMaUQnOhqfpd7R+79qrnLEWe3JwasVxsMD9e/W4BIlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
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

Greg Kroah-Hartman wrote:
> The devnode() callback in struct device_type should not be modifying the
> device that is passed into it, so mark it as a const * and propagate the
> function signature changes out into all relevant subsystems that use
> this callback.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jeremy Kerr <jk@ozlabs.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Alistar Popple <alistair@popple.id.au>
> Cc: Eddie James <eajames@linux.ibm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jilin Yuan <yuanjilin@cdjrlc.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Won Chung <wonchung@google.com>
> Cc: linux-block@vger.kernel.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsi@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[..]
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 20ce488a7754..6ae8d0bdc61b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -27,7 +27,7 @@ static void cxl_memdev_release(struct device *dev)
>  	kfree(cxlmd);
>  }
>  
> -static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
> +static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
>  				kgid_t *gid)
>  {
>  	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));

For the CXL bit:

Acked-by: Dan Williams <dan.j.williams@intel.com>
