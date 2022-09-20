Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BED5BEC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiITRcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiITRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:32:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347FE10DD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663695128; x=1695231128;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CNe0zLPUTJsCJWN96FBGTbYG/Ons39koOBgxVoihJKQ=;
  b=Hu0TV1LfLd91ianCcp3d21QViMTACSWDjZNML6gqGjyWARtU/WOdeTb6
   R3cspQEWcg1KWK06pbFOw2XiIl2OmazAOSvyElTA6ktOfRLqhT9ASIRfR
   WI7CjSglqOnubdNOe3LgI2S6zl8Tm9WZm0qXz0q6in0v2UUk14UNQCR2U
   UB6xVjC1Ao1yub3y7uk81FWGtnKHNOeGUPyhN1CannFWEzHqXcKT2leLs
   9yiWMossWFoo0NilsAw0wNNi2icUWaQ6yAzU56Aya2P15/qvVutk7owFP
   0EUBaYgAt05Cu5Dn+3pHgpfg186pDWxcb+10wdozSP9XO0fDa8DaeXvHW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299754177"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="299754177"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 10:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="722836063"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2022 10:32:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 10:32:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 10:32:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 10:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOYq5S9pOjpQLjx7bRvZv8dmSb7VQnsYKvzaXWpryBEQgZKhTD74hTTCfH+afoQ192L9wSJ29zcM9muL5PFaALkKqpHeZe2nSzKNveHc0C1maudKBe8vrjAko1dembMjZxHH6uW1Y4rB8wa+4O8KRFXB6IQSwL5vO66pxV1pXdzWDT3SLATGl188Cg0Gx8+10OzjOT78Fh8J8wPDyVzFz4gasoBLOnFlg0k8opLbNPKb6a3K2sgTTpeRAsJCwkvF4bQPfT+DtufHkhAqiHXYj7mC8P1EblrgCvz6WkglyXyrVMOnTprSj3cv5EI5fe5miv/germqWct9aKz68heppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRSh9uQOoaca315p0XbB6qgiCSCc7+qY23auUobv4fY=;
 b=UVyhS27d6s83ZC/GcroxPGn3o80YXt5W+vgAIiIAWJPs9snZJBkS2mEnjMoOoc4kY0ga4lzwKiCDgIqLpe7NgWJnF4JanvePGjpd8w5aYEhaMQxVkhlNWIbKEN6P1WpQP2PaFCxw7k9QHY+Z/nHdgMh/ILUr4sZ6B3i72kphQdItJJmXAAwTl9giiuxG5Q5w+3KUsUX4cE+HMrdtpa0qpWmB47x9T4BVaaKbs2JmQxAUoTmBgO37iW6I5lIS+G2RJTdQ/mC0fQ401jcdNyVIkz0Uf6ynunXuLipeDmsnuIo3dg3Ew+pwU4kz15yYPWbFynHIno8WHuFZHDgAEnnfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW3PR11MB4522.namprd11.prod.outlook.com
 (2603:10b6:303:2d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 17:32:05 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 17:32:05 +0000
Date:   Tue, 20 Sep 2022 10:32:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bo Liu <liubo03@inspur.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: RE: [PATCH] nvdimm: Call ida_simple_remove() when failed
Message-ID: <6329f91293668_2a6ded2948c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220810060737.5087-1-liubo03@inspur.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220810060737.5087-1-liubo03@inspur.com>
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: ce21c39f-f377-4140-5ba1-08da9b2e0902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVZeSs9O4CXBNanpbQVMjjVE5YkQRbFg9WN6x0MMcpm1R1mv653rN3f2fKnBpZPg21G0dDc71hwO8Lei9znPyEGqbDy18Uo8Onf4+vcmvEc1FvVz+PrfP2/q6dkfXr+FXfjD/LHnyqrmL6nIOUzyABKhew/9SOhBDPS6lbg17okIGv0Q2nYZ72pH9DtxKYZejT2QBt0PXl3fvnWQwUH9klUDctZYJ/Vp4Bo8Yhl5RJOO1Ian8vUQn5X8BaW6PGT8Vni8SMN6V/gGOkkKRdH5bXtmsOZk3h5AUj/mPwMQMaCqklvgWjaJ5sF2OVvPSEknXHJjrTdPDWF08f/ZKjfDFVbXh9MXCYg/+2rGIja4/5Xqt+FlCs/Usl8hrVvMitR652ZRjooTUzYmLpzn6StT5KhA6CBwXloID+MlFjdLCCcAI/lxuGlP6BhDM6+qw8YblU7xIKxfMP6xqAYv+bDJAHfiN7pR1z10lxpalvQ8gpRRV71o1w0U5lMP9PRaqL6RQrB3dqRo/9fKHBYWvFp/5Jhl17O+3g8A7GGsEKMsRUhUsGJbwESaxiGDYv98yhlOo6DenowKEr5KMAYi87zIO1pVa7Shn7zgTKsM7aNboCVhU/0kiW44zqy/9lqruybA+4h8P376PAcjUVVICBJqAql1XrBvbL+ZWXMQ1Ubk2kNbz2Cb7rlwhczyOjjCf7MutgNllavxFlromAn/xD8Udg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(66946007)(38100700002)(186003)(66556008)(66476007)(2906002)(82960400001)(41300700001)(316002)(8936002)(6666004)(86362001)(6636002)(4326008)(6486002)(6506007)(6512007)(8676002)(26005)(9686003)(478600001)(5660300002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCo284mpX0lCG8gby5m7dWbt/McuWnAekGRiWEGCFE426tVTtuLRrTNymKWG?=
 =?us-ascii?Q?c95iJMiYspR1jdnSdjIRa3dYmSwtn6Hti3FDwTwdHPS5kku5rvpvSNO5TFUh?=
 =?us-ascii?Q?AbYVAVhJ/jTGqfeNWLI0e2SwtRrz+XmKV7ciFFjd4ASphDnGcr4o2zLvogWC?=
 =?us-ascii?Q?lFItm8tojcpEzfbv1BYbGHjxFiS6yrDSyeVJ8J6TC302YAi48wzFMj0bWMhl?=
 =?us-ascii?Q?GpQyAk7OXX3ozKzhFTD+LgkVDeEcfTQtEWxM51KLQ+ixr3q2UBYYv4UBYwPn?=
 =?us-ascii?Q?/TJE2tHH/akBmsi//i4EjJkNJSTeywhIpwDmzy170B680RXbJwJDfQtYLEvZ?=
 =?us-ascii?Q?k5tURgCI1rhdDdu9SegI1uY3PXlGATQxAia0tqjnwML/S9rIvSN9tXQhTBWI?=
 =?us-ascii?Q?Bl6rCbB8IFN5YrM2Gz49WG6X7EhwM1LQeM1fdxYo+Y9xmgP1xcQl6H6OgzKi?=
 =?us-ascii?Q?ACOGX3Ij1z3EqMk/ssOxj+olutDDjqwap/oLjyB6GxMbMayuxRkq1Mg13nB2?=
 =?us-ascii?Q?8IE2Is4G78BON5S1ksfVZw8/5p1qMRIKP7hwPVT/wcsn4TEBJcqOJQcRILeu?=
 =?us-ascii?Q?8cEOQO9atEldmSVnAKn2pUYBQEdOegG7QlTiBdMfkkd+m6hd9hBGfiEcIayo?=
 =?us-ascii?Q?c+rDyNF4DSAKUsd57lPbvcd3nzwqHAqLrLYJWvxmVjFIRtZHXgOPCtXDYOta?=
 =?us-ascii?Q?2UBuyMFpEDvGqx/WHecccxi4OdR4yk2ZlXWLk+MQ/MLZlgD8pnuyPdMQmR0/?=
 =?us-ascii?Q?ZcDK0r8kpcyDERf5pv658ilNgiV7iTAheGeNTIfA7YTXC8hqmFWGEb5z/MkR?=
 =?us-ascii?Q?r4NubkH5fIwHfPpvbKQ28XznZJN4rxrD3DbqLKy2/4LaQA8Ndc4ahjV1nR1F?=
 =?us-ascii?Q?2fxMZx88Dc+XkVpAKOms7OyaCLzDXYMWKvaGIKEICU8icVljy1KrG91qxhML?=
 =?us-ascii?Q?81DQe98Hh+0FUZkWj5JA+gSH+qBjv0dCQnoH3XneW01i613YU8g09CyElJvh?=
 =?us-ascii?Q?myqdLcyj9wLpvES9Qu2mjKga1o8ABp29cE42sTDgxmzfJWBov2OL43dAKpB1?=
 =?us-ascii?Q?NVcRtRd6hbp3YqzNRxArBK6/3v//MKneF7O511evEnLy9DjLN+Mru+Deu8hL?=
 =?us-ascii?Q?JwnK0inXjxMZ0hCUn5YGvmkU9xqr8O3gwhjnMaf4Zs0wBK5GDZpmRBMtdjwR?=
 =?us-ascii?Q?6FU2wxWVobzLtItkDel0y1ZyqEqxU22kvXJaYcdvvsNo99x8rJ9WzoJh8eNL?=
 =?us-ascii?Q?COuVyoONCEVpJg93felP7sEzSqRSww5fthKpUoeYQBpME0WMGhI6cXBZPicc?=
 =?us-ascii?Q?KW0l5McTy/cl7JyF7yBNo106OCtDHIWOCxNCdWw/Ej/HaPGMXBU3/i84e2dl?=
 =?us-ascii?Q?IiIlrA9xHea+rXvYSwL4x8j5ka63V0MpMRGqqqhZoLz3xyeuD9q8voj/6WO0?=
 =?us-ascii?Q?mFy6rmifw2s1QVKIeBgkqhssuLQnrLZfkynrv2tB+oFjwGy+jCvjxDqevBn8?=
 =?us-ascii?Q?j/BciRy9p0NBm9lZHdgjhDVA3BecvoX2EnBz85BSUD1u1yL71z5IxW0VVx+8?=
 =?us-ascii?Q?Pmp71NbXWHudEeJdAP3WvTM/HEfcNvm4m0zZ6Xfkk0xG7xtU4/L++B3CeGVK?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce21c39f-f377-4140-5ba1-08da9b2e0902
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 17:32:05.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlFl8GpV6VUfctjD2Aaqn8uotA6Yy1qXZiG7bhWVrAm33FM12Rxs3lTXU46VIXaPBxNnt7FrYzC8l7k4AEod4wHjRSg8gGsctUTmA35Upxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bo Liu wrote:
> In function nvdimm_bus_register(), when code execution fails, we should
> call ida_simple_remove() to free ida.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/nvdimm/bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index b38d0355b0ac..3415dc62632b 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -371,6 +371,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
>  	return nvdimm_bus;
>   err:
>  	put_device(&nvdimm_bus->dev);
> +	ida_simple_remove(&nd_ida, nvdimm_bus->id);

No, this is a double-free. The put_device() will trigger
nvdimm_bus_release().
