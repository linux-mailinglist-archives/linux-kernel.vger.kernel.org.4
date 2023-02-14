Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA06969D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjBNQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjBNQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:38:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF1776BE;
        Tue, 14 Feb 2023 08:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676392696; x=1707928696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=81Npe6Mb6ZiBTLL9AMy+oHt6hN257bdeA8mwMU1m4yA=;
  b=d55hZn+h4Zr8KcvarW/51fBt6PUOX9tDGEq4AwAuS/kaiJrMS8r6ZYRe
   UiO78R23p6PyoJKxu6m18Ju9fQQNN9LbFC9Cw1H+9S7tRnvDpi/5NaNh9
   68BmONVU0RBsRhnVHU9m8CYxk2TbPApdyGSHhLQQHzdREQv7kVlOfWbgs
   dOAv6UVPs0XLyn9qGF1DWAvR8M+gRwerZcGMvGQc/Hiv3TR9FmeyVOBhM
   pQVxTJ46YgdlcISS0+USKha7+yuAA+1bCQbue27Yqd3sooDF8I3JGtQAd
   zmF7spWu9wKaSRYrNtgXh8lM8de1wp+HqGJL0/U5QfgKknfJ1hvkkqaMZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358617091"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="358617091"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:38:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998136107"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="998136107"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2023 08:38:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:38:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:38:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 08:38:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaNI6w4tdYx11nj3KFOc2pIbVwD6KAWIaEPFgZM+J5jwyyZYFFlEvcQ6SCpBjo7QZ6fZY+Ayc42MYfQQSl/8En32E8EsF/YEaLd8ptj9tmdxNKGpx2a9o8DuqwrWD9WDUAJZ7r2ExWf4l7WnxMKxxcToPqyet5JhvcKBqHxjfvsVM0ysX0LLkke5rv8KcXtEFJPnQ7H5MMswliTCsVvGOzym35IxJB3KHYjKvauAj+UPyc2ocbqrhIbfRqXulq6DRgPSzAvUzxDUyG+nlGEuC6j/6RZIe+tyQDJ1H/aSKbkp9Rr+esKcgFSf4LZYKtiFDgiApo77PRaBHI1atotKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1+bmkVJTAIA47IskANvo4pLCwbggzcBalt24QTKWVo=;
 b=BL4X8U3BYzDa2K2bZw+ZPjLo8Wg2pEUta3URlZOrN3LLYfzgeh2pQQNorZgAJTTbwYH8SpP6K9jJrW8QChiVFsIOc0/DcDXJ3g9F6jFQlyQnoV9Ah8NXmTBJfl7z7n5xKkc0Z1RVVqczB6FYlOLtgScEzPRfnqo8GnglBPjwbAl3uQ1EW+JwCfdKtz+6W+nIgNkA0gjo3IUzGDkm0E+1fCPfBogixpEtJXZLbNQaCvzmY9rtj5CnpOp2aWBeCJI0ASeRoONAuUUvU4LvvdFJqD/gew4IS3sPbGGv/XxORFi5fKK009oUfgebaUx6hazxndOKKAuvqAGV06biveZTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 16:38:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 16:38:09 +0000
Date:   Tue, 14 Feb 2023 08:38:07 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Price <gregory.price@memverge.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dax: clx: add CXL_REGION dependency
Message-ID: <63ebb8efaceb0_32d61294ef@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230214103054.1082908-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230214103054.1082908-1-arnd@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e2438-617f-4451-fc94-08db0ea9db56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6h4j+R4Z6m0JJ5KdvDexppgs7wcrgSA4h5wynrS0/UUkqSDmNnhV7Wm9duvAK36Mw8ZuGBI91aaYl9qmE7JekzdtFMX0ShLCxJT/j/yYclnvN8hLe8IyZLLn1NgBphMTXaeLoQXskW73bpC0p7u20FsOVnK8uPNKYFN8oVLsKoqNCgiV3C/6PaQGlyI2Zjlb8zsCpnhCjT55oUxaWGg8Gv5WVqTyCtnZx0QWWB56ZEvZKuB3102CcvfH9sAgt+XmxR+G7Pns7ze1W1H4I+2iEE6PpYo76iAIGwBrkPmLOWfMr3RzqgKV2SDB7bFGJjmkkvmJ9EFOrEVd0E06/RQyjaDleqpn0aUbvFJIqF7t3v6R5klD3y+oc9uMCsLdpJdS5gaIngzRfmobSklcvH/78zy+1n7/CcMnECO3EeYB9fIT06HAb2Qflr/aWHJPFwPaOa/gQkbFU8SY6SHNVXhxWtrOnqveAE30FbEqqpmatHkVJ4suKAlrw4rTs4ILpaEd6xccElNz4WmylzHfwa/jthyY9rPu+dG+zOewdk3TNXKQH2OQNQp4trK4sJB0Unu/Z8ZG0du27a6Wrea1hXcpgMA4A3AqY6WNTWomBwP/9hdZ1Y/NteVieu/MdFv+EfXdaTsDgc8cPeCKMy1XgOQrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(6512007)(26005)(186003)(9686003)(6506007)(38100700002)(82960400001)(86362001)(2906002)(478600001)(6486002)(4744005)(66556008)(66946007)(66476007)(8936002)(54906003)(110136005)(5660300002)(4326008)(8676002)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xn7GKGqDQgTtEaKREAmA0NkOzNcav1vHFXkXg+cjT11qcXHmdGl0CHv0uBZf?=
 =?us-ascii?Q?XxNCwojkDV99EQVHmQAs7k4Am/7Baf5h3s5w0dMpUdDCy3NUyG7vcSaTNSzu?=
 =?us-ascii?Q?iuSuXUd0cbR8i+lU27fbIPLaND7hXNtX3xXSax48qzYVFkus2wHNDtDCAqZn?=
 =?us-ascii?Q?STP3ISeSg4RSiTZKn080BnySJYgYt1YHMZEUEJDutG8as+iMyh4I0/sqpXqm?=
 =?us-ascii?Q?lwriB0Kp5Zgbp1VIR1s2QPsxAa3401NVqLX6juc9VFpxRJo+9NV8GQZ6Xnzg?=
 =?us-ascii?Q?0rxBZecuB1R9vWxUvjV9H0Tfc0EZ40zryXrXOVJ/P5YV4Mzg/2BDwdiSFUt/?=
 =?us-ascii?Q?kakD1a78OwC/plg3scbMuK/76yflOSGAJ49EgG1zyxASZE4CS6fIMendODyu?=
 =?us-ascii?Q?uKMzbiOtHw/+DG/N2o9TzASUgQuSe/llbYn6bpRi41M4+tRo5HdJ8KUSArK1?=
 =?us-ascii?Q?GRa+DduFFz+D7VVML3Oqk/kpZcZlxA+cIyLv9jF07/YdhlwZ7L/ulkKOJycg?=
 =?us-ascii?Q?zWXkiSatUHpMFeiG6yRCNnXBoZSyD5JG+Bw/OoUWKxEkInCIqQ1XmSQH30qx?=
 =?us-ascii?Q?4QQY34VUkFzJ5X73h9W2mxKqSsF1iE0298UkMyxNI8lfWZNbwdVDZ4k2x2xf?=
 =?us-ascii?Q?9g0WqHznmRIRDQi7tMobGUjoP0Y4AEAgXrBOGJENMiVNErqjMJP5qmqPkPgs?=
 =?us-ascii?Q?hHe0W69HGMmbrVJoPgtvtzOkJMFv4FdtD+xc/Dy8RS0FkPJzmT6j0/MLY5Eu?=
 =?us-ascii?Q?Feu1s0BC19Ha7kbyF+qqinU2F6meLRwYcNtGSnWc0wb7Vd+10A7UYngkgbS0?=
 =?us-ascii?Q?JCdOvz8NNejc7lzTv9hQs+BUTZpYq4DVEOlKVjpns3uW2RBqjh3LZn6aJ6xA?=
 =?us-ascii?Q?SzHdUMd19biCuubm+zg2njdk4Fv0CVnE5+lz7JF5VpwEvJnhBwxq7QNoxFqF?=
 =?us-ascii?Q?ghxo8ZxRGI9D+qPWHH277s7ZxzM7dLsQqO5pUjuOJQAXFRZMq2gd0GOJszRz?=
 =?us-ascii?Q?8FV7rFUjgwg9/AJbcu/dmH4X9dFcsuGEJ/2NxzaLsmSQzNId3oHaxcNigChe?=
 =?us-ascii?Q?8FTPzxSINgr8nnhFuu9mF0en5dlBWuHfgdLJOBlv7Clp32n6YFHgo4ClW0kG?=
 =?us-ascii?Q?WedCTiNbEGlWp6n37Csa9BmEJ2dBypp0Z4ZG+eisXrlMdZM7g623AUTRhqPl?=
 =?us-ascii?Q?5dvXQItcw3bpAXk0FTfdDEcYdfNDZ0CFcgRLB3pOBAj/OkOCmC+DD9yZHnYT?=
 =?us-ascii?Q?KzM951dkajERVgSX5DHefSKIB0kYs4yZPzmcPqmOlOV8rIAqTMA5QSTM18ai?=
 =?us-ascii?Q?WxdtBRsqTVvAygkmZUiDgrqMQt1RJVZHTzAbviOeSu+U3DH7EBqmmMD81LjB?=
 =?us-ascii?Q?IjtnJ7kLR3nvi9jWs13fOq8w+lhaKf9H7q0LVCfhcySERq3czFLu94Wha8N4?=
 =?us-ascii?Q?J4E5MHodPtTbSpb1I/mOK+BxHIG+kDMaj7hE52wXJjh55b9Y2gzS6GoCnRjW?=
 =?us-ascii?Q?fsGY8pe/4dEaiEeXEy24COORke59PXHXNWjnsM6J5PjOq9rtfuukiaFOCvZE?=
 =?us-ascii?Q?m+Lkzd26Ej71rj6HxrSNLtvmgeSamgB1WDh8suzIkG/n1zk5i3KjQcidboQJ?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e2438-617f-4451-fc94-08db0ea9db56
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:38:09.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0c/rAhdJFKEaqV3q/fjFmZiY3aAehEBv9Y+RYxobFo2MHJvVqfEF34nQwDdZXCsJ6dnIDwXlKxtE9NRQl5sytVlSaXi78yO/0g74sptSDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
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

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is already a dependency on CXL_REGION, which depends on CXL_BUS,
> but since CXL_REGION is a 'bool' symbol, it's possible to configure
> DAX as built-in even though CXL itself is a loadable module:
> 
> x86_64-linux-ld: drivers/dax/cxl.o: in function `cxl_dax_region_probe':
> cxl.c:(.text+0xb): undefined reference to `to_cxl_dax_region'
> x86_64-linux-ld: drivers/dax/cxl.o: in function `cxl_dax_region_driver_init':
> cxl.c:(.init.text+0x10): undefined reference to `__cxl_driver_register'
> x86_64-linux-ld: drivers/dax/cxl.o: in function `cxl_dax_region_driver_exit':
> cxl.c:(.exit.text+0x9): undefined reference to `cxl_driver_unregister'
> 
> Prevent this with another depndency on the tristate symbol.
> 
> Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good, thanks Arnd.
