Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6933970E712
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjEWVEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEWVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:04:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3DABB;
        Tue, 23 May 2023 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684875838; x=1716411838;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i5+kzgGdLU+3Bk1efBeq5yg+L7l5Ln9zfKv7sCPvwVg=;
  b=aWpGQABIfuauGtS9Abm8X5wplRWnSEvq+avF8tHdPGGgPYHFD1RJW9i1
   b1mcjSD26cjhsC59QHuF1KblwzAFMyEYFi/MMHgvJU3YalFdk1bo99qD4
   DGYloA7kZu3MJdz55VI+G9G3G5W9Eejv7HTAu8aIftD5Z2g2M6LL2wfIQ
   RqdZ9pxUHfruedMyc0km5SoucjY3jEu9W/wp6IQxsS9X3zGu1lMI84Tor
   XkNGVC9AYn8I+ptWZ5a5vOwRV69iPsrjdMCrB7KqYmILNXvmox8ajv6Xq
   dSQJ+6sjz8pVWLucbLm6UEQkEmbRRnHWbJdOIi43yUA12ZpubwUF8cwGH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="337946002"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="337946002"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 14:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="737026755"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="737026755"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2023 14:03:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 14:03:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 14:03:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 14:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpf423ugSgUF2gkcvXejsHaydHcmMfNdSdkUZb1ugDzOnMBe31+P9bFxiyIYqtjhmFzqyfLsNbUxy03A5EaquCMjy8pp6RK/eyxn/ejUte5Fc9HHHw0yP7f52OgE4FjtOgIrs/Ifr8vbwjW7GcyhlUjUZD282MWR4c8OChCW9eS9LZat8I3EG2Nqmpg/nRI5oxsnPeXTi+f79QPC0VGBtSzflt51VdwPKbE3jArJTxKKK4Av069dVDZXEZL7RuiLanaPu1DCunuiQQAGosZhFfAeOV6kU3XZineBN/J4QZf14nlXYKGzMLGNfG/wTd/ZDemFvpYtYeAGRkSpycvChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olp00kifdGRHn0Xrig6GtRwM2Cn1bJN8uqSUFytpS+M=;
 b=jb9gNlkmbZzcXLFUlD1YlX+Q0SES4Ya1iL9MDkXS4osvLubzbBGYdtU1EsydizRDJRBt6pL9doBj5yTcKhNXYGsIiyfi2M6a6UpdLceQtucON84bvyJ3OEzsRtfJMEAt5NgvXv10OYJGMsC1HJQHWJtsdUahAQ2F4RfVNiCjT8l9YCTypjgbvxjC8TbDD/1J7KpJD59JIDpgNU6mAGZM5BIqGkgk1GW23mTE3nm+qOh1XlJ9wgs3eMsG6c7xYVg/4vdER9lX8+jV1xrCuK1q4xajBd8OiZJ6r8cM29y50vq42RlC40u5hjK+7mXuNOcSX8RaS+78wQPa57tQ0AaGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 21:03:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 21:03:56 +0000
Date:   Tue, 23 May 2023 14:03:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/4] cxl: Handle background commands
Message-ID: <646d2a394342c_33fb3294bf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230523170927.20685-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230523170927.20685-1-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 698c2137-97ae-48ea-50b9-08db5bd13858
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCDNRFeRLKZDI0gHs8gvCECJqF31EH/xRpOWV+CtmdtcaiSoFXxhfvI8f763WeMp1LoJ1esd4asgq1RtIKEXXq512g9O+Owqc2/spRd/GLC/UgbUEPy8NClh968Z6sAEONdeAWb5dv4XzSMakjmEIzq9jsfw4xELr4eSLeOclCkEGCKOdToIq+evPhzGsmJHW3BqOIFl3Dh95dRbEyGLXWvQMV3YDquwpYSEfDtPWwAh1trh/zFbQhV6QONpBuBXDZbfRZ9N+ELa+0qCUM207UyVShEPJYsU7KE3jugBir/xIcg+G7ySotD3kTwya84WMrmM5dyYCT49hK4jI11VJJhOFHtb99m2NDIPvLpuRM9T3kno642SNH9PuuryOXRzH3MuAm6urq4AavHGXFfRInlZM8XeXtMKfhBPuefh1uULhP0wKRjH3zZshEuISOkMgvYRDphnQDzV692sMwhiaZhk/by57+tfyWBPMVjJDMUcFI0EJuA+M1Rbv3q5NtBVuvk5gAvCDWh8wvrciaKvm9lBzI5bxUs/qLYvJbuINVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(186003)(82960400001)(9686003)(26005)(6512007)(6506007)(38100700002)(83380400001)(2906002)(316002)(41300700001)(6486002)(6666004)(478600001)(86362001)(4326008)(66946007)(66476007)(66556008)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5H6v0CkidvWl1La9VRAzMs74qTPROzWjXgE9w/upgVx6fNGn9mtjlvuE1fh6?=
 =?us-ascii?Q?w40TGVOwjNn/DhOOBZDPz0M8QWpWGFCZHt6Y9I4KCYEIBPJERzIhdGU3FZ7w?=
 =?us-ascii?Q?2+7BqGWRHf86eQ9hIGDK6zeA5zqRlckLo0HjCIgsNGq9m3PmT4Nvn3ErHda0?=
 =?us-ascii?Q?JgQwO3u2H32lI9GT7qIrnhE/oCxlhuykhl/Y3EmLOx3gznbTYDdmcEEKK5Oy?=
 =?us-ascii?Q?kPP/iM34BtqJqY7Du7CN5rx1uc1eECIY+OAtmuX3EPqJUeLhvuDehX2u+6aE?=
 =?us-ascii?Q?9/pyqrVaw/T8KN4QgB5f6wiIklhe3Fh7IFpoTBSmdHPR6uqllEjuQ0gOY6ot?=
 =?us-ascii?Q?JUgGnWBZx+fhoCWd/IHeyG3yM0ml5km8wMdj4212F8DAdR09uheVJ/vCQFhr?=
 =?us-ascii?Q?QGli7qNI8UFKNnZPAEGQkO2MWwznbI7igaotgOd9HAcCLFPS/d4UEFBOykJt?=
 =?us-ascii?Q?WmaHVUIeVgOp7PM7FqG070L+7PhkrVyqLJaPmzgxARe3ErQxFNeSyX/gFU8o?=
 =?us-ascii?Q?gQ+GADIwAEGKjTK2NzigICT8BSr++gs79Dj6TwuW1cPHskoQHNsmnJzPT6Tt?=
 =?us-ascii?Q?VJPGjz+rfvv+wH5ZkLHXh2ITPFnrmoPcA+lQygRcb+traOF9EY9F5XdaBDKw?=
 =?us-ascii?Q?oqisVh1Kf5E3c0tPqyRX1JwC8Ik4qgCqZ1m/unlTeNOKy0h66r9K1CWY+ukz?=
 =?us-ascii?Q?Bs6JRIPnraDcKrtFEjdbimBMm6n3alus5saNRNg0t5iI6o4UGYqxf3s5azFn?=
 =?us-ascii?Q?+YrxWD8Q8+8w3lbZ6hCvvH5MpACosp7C5IH/ik00bHJn+YglyZqY0BTMKDvR?=
 =?us-ascii?Q?eMsGO47PxTTZ9p+lq+sRvrXMEwEawKNxJ/rhmgjhW6JdBdGfmEZVGg+dBCSK?=
 =?us-ascii?Q?faFH8yXN4Y9kehpoaCH1hS627+pt2KYRd/ysf2tvFVTPNdMCQBrD+NjkX4pj?=
 =?us-ascii?Q?CBpn/JvV6QF/Vnsr5FQo5DR1CFM110ggs36JZdZ5mHsaZpdop2JtQDDLwq++?=
 =?us-ascii?Q?Dux/UVkQsPCmaweNzb6AdJkXdiiqb/wINTySBaoPTiNFUKslGxwLDL+1mHA8?=
 =?us-ascii?Q?92NWYE1rfl5k1fBDWlYv2CIHaMNl9FGnpL3EMGSGjmh1u4smnaNkWIcvxC6F?=
 =?us-ascii?Q?DE7hsN+asS2NRFGPeJALblx0Xqs3bgrvemAE7C9Rl+bm4i7rbF6l0h1hAsBt?=
 =?us-ascii?Q?t8H55QLmCbSV8d+xZncAInsqXSKuJ9WO3a1yE5eJV2vDRSSWqj/i9uexj7K8?=
 =?us-ascii?Q?7IlTUU45HFEGTClG59RfCTzRjZk9k3gb/ZcWntAZ+E6IP1KWrI2fo/ap+9ly?=
 =?us-ascii?Q?fDVQPFgxPOdrJi4Uvw1MGvoJ4P8Ga3xEEdsVW057+Kx7Uo+UlLVyRra3iCr0?=
 =?us-ascii?Q?EWtT1g/CHYgowKPCDF0obSnZdJKH5gx6OzVb40pCVVvp+iwaZxrbqFQWp7Hk?=
 =?us-ascii?Q?bDu93tSxUEh4NpsolyidcTwMClpoEzaNRIU50zB/gcJKpW+R2V2BgUUY4h0a?=
 =?us-ascii?Q?YfRdUASl7TMc93Ay//L6UNpf8HfoHmBSPKl36z1I3/EdmPYroZQNfxpQRVju?=
 =?us-ascii?Q?K2ym0eE2RgFrTz42f2atQ6tyGXXfy4QS55RzoI3qHE+w10lSfKom5y2cbl+W?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 698c2137-97ae-48ea-50b9-08db5bd13858
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 21:03:55.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6wzF4pqttfXSQW71U7qbs7W+QetWOGF0+Nf3o9bC5ExcuiYYeEWQ/s3g+eGFwoiJUE96b84i13QlKd0Ufrkfa1GbtNOBCV8mS0DtKjeQNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> Hi,
> 
> This is the latest iteration of the synchronous background command handling
> work. Currently there are no users, but it is expected that firmware update
> and scan media be the first two to use it.
> 
> Patches 1-3 are requirements for the actual patch 4.
> 
> Changes from v1/v2 (https://lore.kernel.org/linux-cxl/20230502171841.21317-1-dave@stgolabs.net):
>     o Picked up tags for patches 1 and 2.
>     o Added more context to the changelog in the rcuwait patch 1. (Dan)
>     o Added new patch 3 for common request irq functionality. (Dan)
>     o Misc cleanups in patch 4. (Jonathan)
>     o Don't clobber the ctrl settings. (Dan)
>     o Removed bogus warning in irq handler. (Jonathan, Dan)
>     o Make sleep uninterruptible and clarify in the changelog that
>       timeouts are in fact unexpected.
>     
> Applies against 'fixes' from cxl.git.

Like Linus I want to see the conflicts. Whenever possible base on latest
Linus tag like v6.4-rc3. In this case I will add this to a
for-6.5/cxl-background topic branch based on 'fixes' for now, but once
'fixes' hits v6.4-rc4 I will move the topic baseline just to have it not
be based on a random point in the history.

This also encourages me to be more proactive about getting fixes
upstream so that the next Linus tag can be used for development.
