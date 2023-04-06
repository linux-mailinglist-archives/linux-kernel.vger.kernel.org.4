Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F126D8BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjDFAhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjDFAhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:37:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F140E0;
        Wed,  5 Apr 2023 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680741423; x=1712277423;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iJV0eSv6PlCdNJNRKk6hf40edBOQxfoHIZsAU37h/QA=;
  b=bXt3nvrxOz1GDj1kW4aCcH6n/+d4m4UbwkiCh72tGRUiT3L/EEC0Q5qF
   5aV+gY88J/wJNiBG7lkuwxIRegHVPT6EnbdfF7E4zo2A/blql/UDhvF1x
   x1MJxwuiuaAGTFpVOz3G6enqym2QeMxDlWPZmlrZgp5LVmYzWBpEChqAz
   1Fe009SKh+vsfzj8hNoDJ+I4IauQVfjRNIotEWC/wwbGWlsA/HnD2QSus
   rsJyljeEJM9hVuQi7WxKNSq+0lPRxWva9R6ktl4374pkEVx6YgadTpCKK
   ObWcB1Cc5aC4/klkz4exSEO9lltGfIkL7b44iMx3IKb1Qf5dT3lyHD+Wg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370437625"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="370437625"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 17:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="680476264"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="680476264"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2023 17:37:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 17:37:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 17:37:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 17:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYwurWBoLhszfAcq7lpmxo2AXyrMvUwxkGv4t3Anu4SlfpmqIyO/1r6QGr5ah69rp89Wt5IKJPsjY3Nyp+XQrhFJXPWfLbZl0bG21y/OOdtlasYb2EdTkicpVyKq2ZmwNxJHsOPCMBoE6TvT6t2a3RFJ6cVkNXijP5478hkFugQtJrURoNnsrgVylZ/G7n7sMEEq0k04cnNgl8G8m/5Y7WRbfx8CWbgImaFCKTetH6aHKRDHsoyTgJcgug7ZI94GGh3g0c/uAumpZ/ZC/JU6GAeu/+HsKzZsdx0MOudBS7GtiwdeCc6Bsw9gTUnQExDvi3oX2CqzmnKhveOr0iz0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1CsiF6yvKF6RxLCRWjhRORlTOzdqVvfR8Bw1cum1FE=;
 b=X3rTw94BmyGjQ3KxJ6iYdVdW+Auus9tG5BkVV8rLy+3HQ/bNJZVrLxtosNevrJLsRxy8rSgs0NjyXpNc1kGiXq8rXEnB/rNKIfV7KaqSOPuySof4rwpqZEOYzGlQNhN4W+BQ5uULTX85VVmVVJhcaruEHazbXmNBnuBVyIe//lYuOAmAWApM3bsGRSNukcOJRR6lVf5dbLD+ehu3iQKYBdgF/doAKpex9pRg3fKGapiaPkRSLMfLkK3380s1KQjnXgaXKritjSQrgobTjCYdUEMJsuNsLTPF9Cu831jjS5LnRXRjry6ig0Edb+eTlfqCJ7BuEcrZPEYQOHkyc83cgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5466.namprd11.prod.outlook.com (2603:10b6:408:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 00:37:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 00:37:00 +0000
Date:   Wed, 5 Apr 2023 17:36:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH 23/32] ACPICA: struct acpi_nfit_interleave: Replace
 1-element array with flexible array
Message-ID: <642e142a34d9f_21a82942d@dwillia2-xfh.jf.intel.com.notmuch>
References: <4845957.31r3eYUQgx@kreacher>
 <2652195.BddDVKsqQX@kreacher>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2652195.BddDVKsqQX@kreacher>
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: 9713fc16-3a7e-4c69-e4e8-08db363708b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 491iypAf3FWiIDWyRC7lID0fH2TcOmZ68uhdVsIt+iVp9c7CfI3hH4xEBcLXG36hCV722Y9Sctob16u7I/Uc2fR6t/2//eYpofokldJ1eW86t9ERZcdQF61DSTlr38kigBWg02bvMp49Ab2ADpnPG/v8knjkYB0sZNrXmHN3kptWInUuGhEWNgvnrBq7MuZK7DeFgB3mKjyQf5F5JboOKRnBGJg3je9jfGfRKfUOutCXIa3wJw1ZcIBpLPdx8B3dXmkGV0YKQJOMwOtVYnIZ0MjJu58Oy6soO8U3x29yfIQ0IxeaMMMfeXCfEyCV/ehUBLZt4S+3Tgj45sjRNLMlEcmmu7bhRqiHp/RxVqioDfw5vddwm46YFwTV/rzN52NaraetRpyNgvzNgmm+0hftDPGXmliL3m3P/SDYOXpD/b57dguKKhSSenAhDmyIqCvkYaXp/VURdoOOXIkQKQBRJqdNBNlymGfhQl5DdyoHJpsvDGamTrZaTPRo0dKObHrnh/MfYXBagzhyfPC57PnR45Y/f5DKHEpein9dEJqNh9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(86362001)(2906002)(966005)(6486002)(107886003)(6506007)(26005)(6512007)(9686003)(186003)(66476007)(66556008)(66946007)(8676002)(4326008)(478600001)(38100700002)(41300700001)(82960400001)(54906003)(316002)(5660300002)(110136005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pn0QnNJzsuxGoCmKVEDciBC6WdJZm5kdR6M3eF+FJlqKcb7cqiVCabs7FI6K?=
 =?us-ascii?Q?V2JtGplCe3ftvdcIvE/09kR8G9usxsYO5MwU9L7gA7OPNRGGEV6/bQtLSUnl?=
 =?us-ascii?Q?PBCw30CFQ9J/n4P6cMlJpYCi9RzqBjj0o8/iBm5p096MnsgOCYl5oMhVMRoZ?=
 =?us-ascii?Q?YqYjL1jBsWMC3fHDvC+OMOjaGYW27mU0RmztPF0CY+VKzalQuEnP+rMwhRpP?=
 =?us-ascii?Q?GHQeM9lJLMsrMD7/OtT4c+241SojRZ4y3bVfiUcXBuj5/GCuaNPXjJHRKxGP?=
 =?us-ascii?Q?RmBgXX2A8TpAjluA2pPXJ/DaiYv3wxHP4JpVq1qY6bbIUhDNIyDTr/hz4KKF?=
 =?us-ascii?Q?TIHmIVHviQId1Q92zqbES7YW/8uQ37dwNvUSbr3ejUueRY1EupqjkEWEJrGu?=
 =?us-ascii?Q?cMABwRrXOsZXJO3jJ5u5csaeCuEaBsoDYuC2Zd9KkTNWkibQx9faVbC1p1Ea?=
 =?us-ascii?Q?b1mfAftwKNeQy7gXy7ko/xfggDbgmgwIkkhudrdjYDUFnYD1FkEDu+1hWO3w?=
 =?us-ascii?Q?6GyuWZwecs8JVwC93+CvhaRXv1lw+pguEuFlZZq3dqtSI9sjv9VwfFPLMbFP?=
 =?us-ascii?Q?kyfVPUYqILlB0Ro+pfebTcPQqyXdAdPzLwPftPxa2hwaNSIcV9vLuvRojyDw?=
 =?us-ascii?Q?vyO8E/iBN7LJBJ8CRkI3ip3YKbrTMYpWUdIauSwxsmkTm6/Lrj7j75NfgML1?=
 =?us-ascii?Q?t2PHQgocsWc010HU4xYV/Vsq3xnyp2AuZn5ubl5g7nz9lj9e0btuPiHJT8Pe?=
 =?us-ascii?Q?/wcz/fE10gZ59CDCYNOcB4YePw5v0AzhnGXgkMJC2vXf2P11sEOjjunlNZGU?=
 =?us-ascii?Q?E1x/xqMeTwBRvw1wlT/kqkwqicPW8q+z/kD2lvK7xU7d/9SOquvaoQkp2tR6?=
 =?us-ascii?Q?edTtEiaKPjFvP30d28m2f+oNB7WErYQVfG0+S3CJnA+8t42mzJgrcYRJizIA?=
 =?us-ascii?Q?TZAt9RnA3N2ah1c6u7K1Jmu4Zg0+zLT2yqTlYNV9IwxE1h3WUUOPwDUC1az7?=
 =?us-ascii?Q?cbky6Yknh99Eu046GROr+bTgvNjZOd/HS95LsBEo3+8Jf/5OsT6mGKiBHlI2?=
 =?us-ascii?Q?Wwx9/FGtdOUHJBFxCgSW6S9xayj9geVYVE8/qkFddfBKnoirZNt8OGuxsrmX?=
 =?us-ascii?Q?FbjsNiafIK3SpJLyw+eUKXmuyIs+dFDI/mZfnKhzh6IC3pmI5YVczyIZdXoc?=
 =?us-ascii?Q?Sx2oG1zwpsgvs2/eMrFk3qDJXQilcmPWFSHbL6wOBJMJGufyBARTpTpxcC40?=
 =?us-ascii?Q?O+/muRjjxapJXpU7sZQxGnm5hJxVa2bxhc1iaxTGlJ+5BxImb0R+KhRdO9GI?=
 =?us-ascii?Q?VVUdO39nJSZ+Y6qF91KQF8FW9305QXCsWgNAn+iPAwj+cDvD22eM58Z9RF3B?=
 =?us-ascii?Q?Ql66DSUWcsPvYLo2r34nIVUupE5mBZHZK8Q6/WoOMwnB8KiB4tVyXCNGzpK6?=
 =?us-ascii?Q?GTthwU9Ir8hq9Isht7lNJnT9+ccENgV8+YodbR0ONuVvvktuyshuqaktLpUm?=
 =?us-ascii?Q?VAUE3OHoqHj+NtDsftdMtBl2If+N7bgqg6Jlf9fVcHuQ5+dZjX9mbz0Lir36?=
 =?us-ascii?Q?vjB/d5ZNKpydKX2ShVnMx7FqtLermw/7KgekdUn1KA3TojM6B4BB5jh1LDqY?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9713fc16-3a7e-4c69-e4e8-08db363708b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 00:37:00.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fL2S9c8alRhJsACUkVeW8SPGaV6SkyRhP2YkW3ksZOZq3icoo1+ZTv7NxO/FdbvFmAN1IxwyLS49y/kGy1lKHVDKqWBtDzoQOs2et2eCp3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5466
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> From: Kees Cook <kees@outflux.net>
> 
> ACPICA commit e66decc6fca36b59194b0947d87d6a9bec078bc3
> 
> Similar to "Replace one-element array with flexible-array", replace the
> 1-element array with a proper flexible array member as defined by C99.
> 
> This allows the code to operate without tripping compile-time and run-
> time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
> and/or -fstrict-flex-arrays=3).
> 
> Unlike struct acpi_nfit_flush_address and struct acpi_nfit_smbios, which
> had their sizeof() uses adjusted in code, struct acpi_nfit_interleave did
> not. This appears to have been a bug. After this change, there is a binary
> difference in acpi_dm_dump_nfit() since the size of the structure now has
> the correct size, as the prior result was including the trailing U32:
> 
> -       mov    $0x14,%ebp
> +       mov    $0x10,%ebp
> 
> Link: https://github.com/acpica/acpica/commit/e66decc6
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
