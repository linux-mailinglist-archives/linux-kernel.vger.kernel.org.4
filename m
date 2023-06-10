Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161C72A877
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjFJCeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjFJCeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:34:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA03ABA;
        Fri,  9 Jun 2023 19:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686364451; x=1717900451;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MyKq/t+R+9H4OzxvGDmtMYoeAE5pwt+TE/PTh0P0oqs=;
  b=X+DN4cnAbGeENuydQlxyNqGt4gWon+OzLrkCnPmlFGszoa77gw4E3tSq
   A11yVJJraDObJopv3her0PiSdK9GU8odGv1qaAou9KTV48Zn1K38tgT3E
   RlUh+OoXtJnJSe3I8J4UXdNvo13j0l+YMWwPNUCjimxu+Ij6UruL3CiKA
   0jj3HAague0JLLG0sCTpkVO4yK9f2S+gl9hsvbiFqjHtn9fndymXyxY/i
   2Ofd70LzZOOjjHoaKsuZDN4mO+HYTUtOVfK6IXEmLq01Mph4lYolpt7fZ
   omBmXLOruErRXmHz3OAGlCtDxBd4Qq4Niv1WWZGSMe7elZsAoU7D/SoJl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="421316166"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="421316166"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="687960510"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="687960510"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2023 19:34:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:34:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:34:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 19:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdQ2zdHV2pLSNZEJ96mYynlRsoYh9w3t8IAyoJVLtpOOPIE9n66AfoSE+7SfW6ouaTPkH+2exRyOVr/lvGzXnUF/0eJzODR3p/50lySSQ99gElkpLOPeqIhn5Bzodc30pB4knvmd/FeEOLLV+4mCfF4UwD7IOSmH7E/f85rRMjKzHgT9TDzEtxfxb5cgiTE+zRQE3Q2M/nwDpMmxYJn5xeQEhFBRSmZqXN5+BCCzJyoQL5NhpSIFk9R0Hsvm6+euxj6H7mKPT7nN3PNwki+QWAqK9d5fKM5z+9XMDYk1Cq0w6j96ZYVJEfw0lCPo3ZUz+1VNwEvMgv1ZfezkicgCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNIN9ycqzNW1OuC9BqKSNVr8HInILT8j00FT9AdMtZg=;
 b=JLGH3CBvhhhqZyNuHAgpc+MaL/VzFPZZURXivMfuew3ryGNv+jJGXoz+ljtuJlTLdmgW0SUDwbhWs8Wel1B3G9imDfzNC4msI6BeSyheTNratDUughuQXMudIjgyi26ICnXkYENefYo3g4qv3nvZVsMXNQFbiQits9v7nHviUh16gTKIgriw4fHiQVqjn3j/L0KbwczF/uHNAbliP4LR1yx/i8clyx/IiCkogn0s6Gh2XCkJjqZFfDUA8tsCbmpOABASVr1CGvWhpeoeNAWlSd+eJyggn1XVq9pGneiV2LiXovCPIDinN+U50i0FnkkWJebM6C1RK0q+laqxHtHqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 02:34:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 02:34:09 +0000
Date:   Fri, 9 Jun 2023 19:34:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 15/26] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
Message-ID: <6483e11d17b2b_e067a2944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-16-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-16-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: f06d748a-05c8-4da7-88fa-08db695b2b6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7j5A8JKAgS08ZAxIAhQE1qA29FWBYHngXCwlIXUIHYB3x97bm3JjRT1JdwT+vZLqH0WOO4lXYfQE35pWqwkNpu2YE+lTg4WAw96Ptqrr+HKhYsHPrs42M1mSoaCDE/LmxwBD0TcmKKRVjAPXIKFdTDieLXWyJf04/8bx2NvDnw58hoiyQ7W8w64BVQvt4NYI+dfTX0Zw3t5JJaHjR1Gfd2fJ8W5cEBq80RlK1WRbmbv6Wil3rsiAkzTVKq+y7k/wqfIYiXPP464WsXQAh5qccOHkc7sWWkp7DoODTWkax1hViY+ovKkp/edRf/x2Sdu0sQUuaKnkbRCYOel0U2M4li9Qn3DU+VLjB4LRCAyCrzXN0AunOAHpl9IzxkrsQ+pWo/blThGXf/G0ziWyLBFIef5pOoFPfc/pSEmdNv183xAh+3JTfiRmJb3LQl+C9TkAQkwHonNv6CgZ+oeZu8vFpxUaK2Bbn8aO1s0YZXGbFGT0md1xZo6HLxha3i2CDSBtSBGONzMjyHKNywSbMqlLU1HMgrDSezaLs+uFrkVKeaQ7aQ/LU3BXrq8KP34xK3T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(26005)(9686003)(6506007)(6512007)(4326008)(66946007)(66476007)(66556008)(6486002)(6666004)(186003)(316002)(478600001)(4744005)(2906002)(5660300002)(8676002)(8936002)(82960400001)(86362001)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdtaS03mQ2/zXLjimcEmWwDfnPrQZr9BG6ckVId/qcL/vWAPjwboiIhVHIgA?=
 =?us-ascii?Q?oPPjE1XF9BkRvvJiJXpzi1LwOzHmrV4Dw6Zfwak3gIXHCgUhUSZj4op7QP3c?=
 =?us-ascii?Q?PFnU+UZ0ummoSl8YiegCmYhoKUq3FQtCspW+VvmZ2329Ua6amssGM9ylyo20?=
 =?us-ascii?Q?Ju2vpSKj8v6dx6GoVJi+AjL1SCYIjaPx4lBw0POjGHd/KNYnb4EnLPGmovgc?=
 =?us-ascii?Q?B34LHFTeWu20Uj5/8KbxEVmRIhDnqLDkHfl9Jm2fabwbb00PBWI4q/01muOq?=
 =?us-ascii?Q?FDW0z8eZiytlOiQ1MSQ+T6LZHd+rI2Tq4PpM+W9Nbp6wSGBioCgB9Uf+eZYJ?=
 =?us-ascii?Q?RooQ8pvCa38Dbn/oH0CQGXS8ollt9/RD6jpguLtpx/8IK6gz/jVXSMXHG8FD?=
 =?us-ascii?Q?ySFuIv2BaLuywxqcH5ErVL/5DNOvVDTPuG1WiXnkyXx9zhl2SbQqtXeMmAyC?=
 =?us-ascii?Q?0Jqi+e8/zBioTX1Ik4miBDSyDfywlVpbjEOiymub7rm0LjXBi2BNCGCQUHEu?=
 =?us-ascii?Q?qJvbH2gLAiO2ogR4sSYTQknfV9p+mcvSLDTmrkZBSW2bCcebBeKqP6lon5WY?=
 =?us-ascii?Q?HJsdURUHHl/Ja4DQVP6oPa1kYkkPX6MTgC99i+Z708TkNOKGR+aEfJgzQTJD?=
 =?us-ascii?Q?iQIRdN33Wym7g++VWeWkIhhwEO5C8zSTm80L+WhqCYF+5KJ6DwupMNKjGi9O?=
 =?us-ascii?Q?t90UF/29WudPxVH0TlQC5KExHDnz0kFkpWXSDvZVpAIq3o9cO6/jG74uGwEO?=
 =?us-ascii?Q?pss0i92fV1rUWEnD2J4lZ+WKzvYuhXIcSKBDjl9V1xpUwgXvXG6fgA9n5/4/?=
 =?us-ascii?Q?8klXt9JHStMJe916eKqdl4XcBhEzfM69Xg5KMGg/jD1O9DZFyVyDPYvF2qhk?=
 =?us-ascii?Q?YlTbHdMaTpQILHAqYMG276aLqrLPWsdfppBYpK3spZ8t9+qRNcKvFXdu7NGi?=
 =?us-ascii?Q?LVHysFdVg3Du8SBoHPoTSlKfqROZjwcZTF12MzpXLUoO8X4em9N/iU3tQCK1?=
 =?us-ascii?Q?/3AT1V/8usx8BI3dr9jtim4+fltRvebLUQVJUAb8IJfeyT/mxI5H8nLxmKEh?=
 =?us-ascii?Q?B/Rxd1Dbyt3w71uYL4IFxA81o+3GcUuWg4j2CJ3EeMhS/r+edDzMXWf+8OgE?=
 =?us-ascii?Q?mHbcsE0TxZLqQEpUld8jyFHjpBo98n2fAfOAqJs2mOMAXlihFhodrccTwNJ1?=
 =?us-ascii?Q?obVeRzljjot7XlWVChw+EjXSDDNxxN0wKaelQBesp2SLtF6sTTCoZ6CK9d6I?=
 =?us-ascii?Q?wv3FbgQKYyV0yJzGLCfYZM6IGignAsjrhRAO5p1B0upl90GX82FnZdRvDP/t?=
 =?us-ascii?Q?8fHZ8eho+2f0SREb1FZ2gY6/DZTj9uxOh22I+PZ8brvDwSoQZcurPu/PiTut?=
 =?us-ascii?Q?XiehzY7q5bA06evJshvOQurAakhh8cJyAlxeLa04FC12a0IMTxLeCo5QypAT?=
 =?us-ascii?Q?3NlmLOKdnWPcZxldfeFzrzW84NYX+eexlwMZ7xezWRvfrOItULmolHY2NOAE?=
 =?us-ascii?Q?kxIiDPXKzGujZUbNy/AA3TSnptv9uzdyyNrRYc2ssKnLa7V4/ijW/t+WrHbS?=
 =?us-ascii?Q?PMC+d+wbdpaD6si2pjBHzxpDNZZCzc6G56JmCa9yn0tNZ8ad/BbdVVdFKuGh?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f06d748a-05c8-4da7-88fa-08db695b2b6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 02:34:09.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+yL9gtQEicU0wjvDQBa/mBL8FFENpKzLx3S2y7UdlSHxJzBmzMQi94AUVk/Ys97H8ctZ+2rirDQxxEWBKMfJKmJGt+pnKllyl84jOfBWEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
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

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Now, that the Component Register mappings are stored, use them to
> enable and map the HDM decoder capabilities. The Component Registers
> do not need to be probed again for this, remove probing code.
> 
> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> Endpoint's component register mappings are located in the cxlds and
> else in the port's structure. Provide a helper function
> cxl_port_get_comp_map() to locate the mappings depending on the
> component's type.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good.
