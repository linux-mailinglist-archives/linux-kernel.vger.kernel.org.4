Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4251768F43D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjBHRT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBHRTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:19:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEDE1BCA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675876766; x=1707412766;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kLlkf3n94GohKwO4iNNXQQ/A7d9k60318LAJh/tpNyE=;
  b=C/3pyw/lTVDkwBNUETJSWlHh9blw24KUwEanfW+89iiVuMRt824SH2Sh
   gclgUy2dMiUu+aMmJlf4lANtNI8A3US/xPn5CZSYgb2NnLfb6yOeu1C/V
   jQZ7bgNm6uhTKibiJquqVilZpC8gttjJWlXh3CHgR5WNCJpSwSfsV2CRe
   YNOSZE6r58bpjOy899MIOYO2geAimCUz2b1ylPwUeTpvLQmQRAad+Yk7D
   OlzBCSNzg9DQbk+EfbuDFOKdvHGRvestoeY1IeT/JsKZ3t8p4LX3L6lSM
   OdJ3BwxKcCDduiqVCgsq49KU8JSbDuaRId7scfAhOp38LrskO/bsDc51p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313499437"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313499437"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 09:17:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669262075"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669262075"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 09:17:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 09:17:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 09:17:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 09:17:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpQB5FUo+hTYZ0QnVHrEY5hN+iIFypY5NmJpuQl6lanbrIm6Ho9xEJMe02bHE0CfhO9neVG7CfAmAB2qymrDZUSbogSj5Q20v/v/Ep7cLSiQqmDmsA7/nuoRKdhMO5/8JBR2aE7dBfa89x8fZbCQ/2RT52O/KgDFvra0YFGT/Nas2+0ESaW6wooE7z2ALDLlgf8OiszLy2aox4lqM5hmK1d85l1VM8hsaQQxuOC3p5DV+x00j2CmBCqsulzboDBipBwRdD4vCM0po08KENHfddHcElM+hWONrSZkbFuusu5Ni7QV7L8HTxrzeDAV+qZmPDoEHnvHPuWsY3tBXuojlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wo+3hP92bAvBv+K4yYet6AIJrRRcKu0LhtJfAcCbKU=;
 b=gp5klHXt7GPgrhDING7kTZuqOaypEWSWJ3ubC+Sa2qTePvgGfqyKjFh5mKn+Socdh0zJTEnFQVdzNULhd0wPiTczX4gm2NT8iRNw9bw5t37kGzhWzpsP/wToLDJ1IEqk42fSqfA7U1DS86LSR3audcHEsf9d6H8tndBod4tVAYk42W194zS3zDCzLQO0zllowznkFrYpAzObdJhIPgokv/+EwBkNA3nxQdwTSeLszLvoRTkfWIv7L2ZKP1x1smWeZqd3I8aMdOYO98lryyeOpmOFNyxOe3Om2PfE5h8KVPLJw2XXXmfCkwOjeyKwi7OLFRVoEz4LVsg8zc5zzqKIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CO6PR11MB5570.namprd11.prod.outlook.com (2603:10b6:303:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 17:17:29 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::3bd5:710c:ebab:6158]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::3bd5:710c:ebab:6158%9]) with mapi id 15.20.6064.031; Wed, 8 Feb 2023
 17:17:29 +0000
Date:   Wed, 8 Feb 2023 12:17:23 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Subject: Re: [Intel-gfx] [char-misc-next v3 0/2] mei: gsc proxy component
Message-ID: <Y+PZI/mfxwSNmy8R@intel.com>
References: <20230208142358.1401618-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208142358.1401618-1-tomas.winkler@intel.com>
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|CO6PR11MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0ee576-6732-48aa-409e-08db09f85b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHxXv8j+I8e1RpV2TWrQ6xvDlGRwyVHXyzpF0qc3cuCqBredUOD3usJndU5H86E+UhuBtJ6RmvQKQjTWycW2tFxgXRerLdEoLAQjEraZSBvbNEKQwpz61BSi3LbusWPRK6esyijC/EJBlD6drF//PhVI3lqS+gLZ7k6u0nP3otxBMF60F268xB6acwIZGLjOFvkVc/7bB2ocEXw/mEwT8y8QhCatftAnrdvqEq8AwjrT2yz5VqMA9Rh5xOKx+pHtz8q/laZzLe1u8+lUXRqQH1G6XJ5+51VZio229LYcH816/2/qbx3IrJtZ+K4vhi27PW0xxUpeqhickLzU0JUDN1jbGpP16aOUQBistRcHX5rIsg0RKCNbzHotdglDTIrMIMGh8NCj88BUsP9fv9hFQDf/EHlGS5XqLL2sFGsB7dprJsE0XuB/XXx/3Djnbm64K2WEDMaN6h4MWQAj5boJYf1Qh0XSd+P2NYahFzs/yKBTxwsvmR/ATaO3ykItZ4qvuuac3+dmOebD9Jp72fmlr1UsZ7sGS+Uay522Pq2zRV9zEnXyFvO9/RxOAeaWgZFqr5655LCokAwCZR4nMP9D/Z/xgeN3erujhaA0r9hcTE6ZeFu7umU6/M1WiB+6z+DGQ/VfUXYxIRPzY6SKsMMpzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(66556008)(66946007)(8676002)(66476007)(41300700001)(2906002)(4326008)(8936002)(316002)(36756003)(83380400001)(110136005)(6486002)(5660300002)(6636002)(54906003)(44832011)(6512007)(186003)(26005)(478600001)(6506007)(86362001)(2616005)(107886003)(6666004)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3o9vH8WRZK4SIJanXdYLxvLkQm2lDGFgo9FZZgt0PdeLCcus2Mun2AwGDPoB?=
 =?us-ascii?Q?wGSlwV3n4GhfWydbhuI3arpe3H5NRyY4nzR8u1V3T/xOfb5dW+4HyWk04LN1?=
 =?us-ascii?Q?RItGoCFHU1ZxL9ci235FB/0NgP6rPe32TpPY3cjqUNEsHcgVgd7rjBB/Eu9m?=
 =?us-ascii?Q?qhWpSkkDSwMkEfGvWNfgElJtzBZOkhQMjvaJIuHcvhz9cOEEn+I/MXoBZ6Tm?=
 =?us-ascii?Q?+VtA/Kg9yHBfyR+rXD/iVL+npNRsomPrZQPFtZPw0las+AFqF60oaB7Z4RTC?=
 =?us-ascii?Q?MWCR2yxo8zofTF9aCwT/n/MLfpm1Nua17GNHypyrR6w3Rsc7z1vqcEDeeK8S?=
 =?us-ascii?Q?eMtnrGhP0z6x3q+P35TWRiDprmb5rLkMoPj6O5TgCQFrgiyIVt39VTgv7VQU?=
 =?us-ascii?Q?W1/LaXTVwADZAZwbs6IOrr5TM1hmUElj7k2Z9MTjRTIKQxEpWbQjJePbDaSd?=
 =?us-ascii?Q?lk0FhdNhCQry/t8T1BXowKnwQ5MfPEFUy54n2vzCCwoSF/qWEG6hH+YVEReX?=
 =?us-ascii?Q?qtoq/pb7UZRXUrIwXdjs3vOJNPJhLdSYzz4txUUycuPH8A/PR724eoCc8+Td?=
 =?us-ascii?Q?YQLTx08QsZCdQuL7posOm/6F5DBtlZS3ZGSVOmZfIzGGL79w+DfmgW7eM4se?=
 =?us-ascii?Q?RTeWeVpx7rEcJDXxkrJsJVQLTWWj5RXHLzQne0BBz6h+U1BEdvbv5NEEoM0T?=
 =?us-ascii?Q?hvrnzN0I8O6RdrvFZT6WNqxrNNCmh915w0h6FHb6D49lqXj47oGHLQuDHiTD?=
 =?us-ascii?Q?Ap5Bwto4SiPfBl63/3Kg6ElWrHluy26mkCl6xZzCyKmuQC+9Ll/7aorcfEYN?=
 =?us-ascii?Q?zG5fblzu+NijcSwarGu5BAJ7xl8pS5MLWPMQHq/tI62qtNCejABz6WxKaci6?=
 =?us-ascii?Q?Z8GvX5q7RehwpfEGWTKaP/i45KhOW1NQKVQmTydRYWGn+8GhVbcQiYshfgl+?=
 =?us-ascii?Q?8QnhV8MfDaXibKoFzO6CB4WNuGRy1a9BBo/6ZhSA5CJS0QkjgnPhn1nJjQt4?=
 =?us-ascii?Q?owxM0TZAaj8tXSVyuYBIoLfJhiNIs2l0ZHd/kXs/RRCqIte+6aj8bYTGbske?=
 =?us-ascii?Q?dn1e6b4irFNgFheF+sGGEkH1dTNpvIILqGwTZtYTpim2ZNPtJ1hoRKpOK+4h?=
 =?us-ascii?Q?orDr4wTbknartGnaO1JdqTugW+2p1kStT5j+Ocm9n3mOLBhHgZy4SHb2pHbl?=
 =?us-ascii?Q?u+/ybo05qNRfLRXlrdX09LhDkDjL627i79rm/qJ3lp/KuKfuMQV3VFVbmN5g?=
 =?us-ascii?Q?3sL6b3lOlWlZR9S0zpWFCLeVbIPTRIIKfztp3nt2a+H4+X5kaywQ1Uam5E2k?=
 =?us-ascii?Q?4Chzg55JT4q1ObASYlMNeaKniqWgiSNnVDSNy0is4GhvGnKzOrvwjhlu0sTB?=
 =?us-ascii?Q?dgqyj7HTNJYKPEkskZyxkWACdIGA8xP1mendDrm7xupd+r+vh4kg1RiAUO7a?=
 =?us-ascii?Q?chT7a5/RopznBvBrZBGrRJrY9A8vYhLTWGzPxJ8Q/5Rr57W9Go9oDKS5Nq8Q?=
 =?us-ascii?Q?GAnLphDz5SkeJAAtgWG9PKsYMGSAODHtpRn9FNlDNtFFlaMO+qV+GoHHEiwh?=
 =?us-ascii?Q?kYESwkPm5vQqy3tt62ahda3OIyldxSF9NFcxS6+89W96G3i1e6oU8cwd06q5?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0ee576-6732-48aa-409e-08db09f85b18
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 17:17:29.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NZt4zKZ/z72ZU2Q6xWNIQ1M9sR4zJAbyT5UL64pW0QkBDn/mD/uWOBxA/IiQdtt/Fgsy+APGsw5jqr20JLplg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:23:56PM +0200, Tomas Winkler wrote:
> GSC Proxy component is used for communication between the
> Intel graphics driver and MEI driver.
> 
> Daniele, please ack so that drm part can be merged via Greg's tree.

Cc: Daniele, since he was missing on this submission.

He raise concerns on getting this through another tree since he
has a pending series that uses this interface here. The propagation
at this point will take so long.

Could we do the other way around and get Greg's and your, Thomas',
acks to merge this through our drm-intel trees?

> 
> V2:
> 1. Add missing patch from the series
> 2. Use device information instead of driver name
>    to identify the aggregate device.
> V3:
> 1. Drop MAINTAINERS update
> 2. Add gfx mailing list and maintanier
> 
> 
> Alexander Usyskin (2):
>   drm/i915/mtl: Define GSC Proxy component interface
>   mei: gsc_proxy: add gsc proxy driver
> 
>  drivers/misc/mei/Kconfig                   |   2 +-
>  drivers/misc/mei/Makefile                  |   1 +
>  drivers/misc/mei/gsc_proxy/Kconfig         |  14 ++
>  drivers/misc/mei/gsc_proxy/Makefile        |   7 +
>  drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 208 +++++++++++++++++++++
>  include/drm/i915_component.h               |   3 +-
>  include/drm/i915_gsc_proxy_mei_interface.h |  36 ++++
>  7 files changed, 269 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/misc/mei/gsc_proxy/Kconfig
>  create mode 100644 drivers/misc/mei/gsc_proxy/Makefile
>  create mode 100644 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
>  create mode 100644 include/drm/i915_gsc_proxy_mei_interface.h
> 
> -- 
> 2.39.1
> 
