Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A76D575D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 05:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjDDD7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 23:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDD7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 23:59:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9107E43;
        Mon,  3 Apr 2023 20:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680580772; x=1712116772;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fy6z/DukkyXReLjPJSx1vko21LUDCe0eax/vdDsY9vg=;
  b=MDYh3zgUS8xTHwW0/JKyhHtY/ZIC3O5K826115Ix903F794nzLKYV+Um
   YtGbsMz2WThoxnEKwKexnl7GpZHCJyMSltKxUClVQKS4oM7yZaYrAd0Sh
   QvVfhWrrmZVPc/Nz7la1xlNgxAvZz2dM4icCPe5bToaF1RzEubsr/qu1L
   /v4DVx6qayAQmKp8X7W7/t0pqcB/zuMOpDNhtJ+bZKokVuXdQxHm3k1Rz
   Ns+bMKUyBwRXP3k7h5UMdfhhAbFG2JXXPC23MfDLdcDWOKzb6JlOqZBVU
   X8p2YZaprx0IlDbwEHRNSq+v3DptZG47CqbMqIOKhGR4myLjc/QmcEsLN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404842620"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="404842620"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 20:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="755504049"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="755504049"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2023 20:59:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 20:59:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 20:59:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 20:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQytSO7FRvjGdnZfK9Z2AjJsEd6SaGsj+B12L1KqwB/0WIBaBFHo862eCjyrHyJfOsXXcpWtUbM7mEkU2aNp/LBiMsRalXyZuBwYoqtHgGiwjflInn7wBaJsxkmkCMbOyxmShlBaQHWNivyxDljiHo1XaPA9SK7P+94p/THj/G/W7KR82GydvxtbDh4c2PYVqaLXiSyfyz3HuazKO/gs5jpkaWf2wWpNEHUxv6n5+yIOrdxWeSaLz0rfUKoUqYcXIEpSO+ijaDo7eVsK0G8GXrodI3XAf4MEMaEDXaReQV6T5aB3/235cHmfOLFKHztTOVVc0WcxXIAjMNac2v5f9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNuWbck13WxaIppx6xZCD0Sc1ElyPnm+M3m88E3RKvs=;
 b=E917aaporOkT5V7WxYq4oj/tfIAXdua7qbcROkE4YSRMSq3fWYjIu2aVmqvfepWobA1NHSsPrJtEljNkRcWT2hXI0q1IETw8r/RakBONlsshOtZXmBgn9JsJM1lTdThlvUX0OHpbdxGoph2Gi5ajMOoegEhFLDopyPMK6sJe7t/XAlOdUXe8spSvFJKSzfRd6Cll5K3He6Nx7s6xfsuhK7knYVPEUsmRjKlIf1nhKaiSLHZljqnPEu0wmOs6F/w/kf9DonfRUcRUQwQVm78Uz/8ZmPip+5NUtaBAqoI+XT6U4JKq9yPBrdUmS9E7GnSC4OGIs6RTPMv5JVCxcJBr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 03:59:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 03:59:24 +0000
Date:   Mon, 3 Apr 2023 20:59:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH v4 1/5] cxl: Add function to count regblocks of a given
 type
Message-ID: <642ba099c2a4_29cc294ef@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
 <20230330164556.31533-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330164556.31533-2-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: c824169f-5e49-4b4f-41db-08db34c0fa24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJQNiFAdvoX+PSSgCL+UkUFhv+e6PTJlILKgYetYkVd0yLRRNxqrMtzDuNaPiLBDnFO3XaFS4Ca9kapJQdDOP6RgUnZOQa6aU4F4+0VxGU85FBAWwJW7ATcFy7PK9TRiYKjkzkdCAtRZ/S7bV33QG27AksJeZ+UBKMhpdzQTWaij9JfHJOnuqWAtcSgS9AqWt8h+nQVTuB0gkjDrqRJirjE/yRn+mz7gO+AFyyuoNIeWtE8S4j3haqSFe4NXcbgAcZNPoErGSPcafH/Aim4xMmxjcsLK6OsgEh5FppDfuMxjtHGFLbe9j8KThq5gRLyQZzA4KjwCbpbZ8oiM0+TRlboUMtMk8n9+iPuyAjEdlsqBwpRSORYNr+9RgFuRZBH9r2xkr0c6nWyqDbNUa91nPaKODd/O/xx3IPnDZeOhYT+XPJEmdoTcEof9YHl+vJeCG4NuP3ebH+ZJYdlZtofaVmuN7bz6wGkw6e5ae4RE/UpIOjbtgql/Qb264GjUkSibaojvb2eCo/1HkiaHDwTHDSzA5aciOyr8bbkLEirCg5/xRSIRT+q5HU7HBFvMFAZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(4744005)(38100700002)(5660300002)(7416002)(83380400001)(54906003)(110136005)(6506007)(316002)(6486002)(186003)(478600001)(6666004)(86362001)(26005)(6512007)(82960400001)(9686003)(4326008)(8676002)(41300700001)(66946007)(8936002)(66476007)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZX1XJazNGOSFpzUKE5Xe0vKswmMS5BnT5RNnunmAQKgFz1gdtx/wxw93gC99?=
 =?us-ascii?Q?fBMvcgAvJ0xRgHKzwgzb8/+ssw4Rlco7qmw3EWsVkgwZGUjRw724qTLHcRwE?=
 =?us-ascii?Q?UTMKUz6zLMyj/UIosjNVFfK7pdPT849L73inbzFXdxDueRriUf6TAEpi4/ps?=
 =?us-ascii?Q?sUFWS0GNTuX9aiokjtcMNJR52kX9ZCccCDGe4meMYwUaVH11OM2cNwPgm5D8?=
 =?us-ascii?Q?13K9Uf8tL6JZEPkaWlAJgUfuHEhyXZDzc5kLxS7Zw2/NVGVb/tkFLEaElBuH?=
 =?us-ascii?Q?rm1Zk9KUp/WYi24oyeJn9ofkrSS3R00eG4AfWNiWi1JHRo244VK4tnvsGBRL?=
 =?us-ascii?Q?QzIbxHb7uIYgL/RdEAGdVKuAv9GkEk8yYbsvfG9r8h4H1mCKJG0OU6E2HYWQ?=
 =?us-ascii?Q?yOt8mXkM+6x3RNFZEUgc32okaFkwmv1T7FoGiqMwNemrRZmEOEz/2j8TlpcB?=
 =?us-ascii?Q?3Y2dA9w46Wre6jrGvicfjGFd68cDJxj7eRIY6a17fmm7gn1FrrifRyjeWq1Y?=
 =?us-ascii?Q?h+ndQnpUm/GMkkCVKlvj4hcq29nKoD0EgGG4mOu2ek84YtNAJdvv46YvbS1q?=
 =?us-ascii?Q?TOtzGx3yIUGHW7xwrV1xJHMabTvSKpzCNAqOdvW0ANL29+yMFbZy226Hzuf5?=
 =?us-ascii?Q?venMhGnQgtYQjLHpbfQ46TyBGJz05IsytV8vEt+djl5sH+LXoNNaIoyhRBlb?=
 =?us-ascii?Q?HyieJSP4VCoeHrtQRZqdtYlIgcANxFmQ64OxVeh0G2FNVX0VJQn+WQKKJFrS?=
 =?us-ascii?Q?ducMwMgMnFp4uzsfbxVC1J2H1kPgR6gAmh+Ju9zbd22TwQbkprjkr5VYuIJM?=
 =?us-ascii?Q?YHx8+KBnVtirJscHTaTTYZANFW6Q6QePvTh9OTrpNpi8Exir5ur6hlq8wo8K?=
 =?us-ascii?Q?nkfxBKxtCJ3FmZAZiWz8qFDXQ8qXQH/Wq5Lr5PDgTpGRb4GD0dSg3orfxi6e?=
 =?us-ascii?Q?GgKH35MvFNYti/P3zcwtlrjao9+hLhLBpP++zlHslLppqBbrz42pialXcHM9?=
 =?us-ascii?Q?LwYTd8XeUFptflLOunE39fHvDH+R80RG2ro1jNA0t3rM9ObbFcl/nMML27iZ?=
 =?us-ascii?Q?p67ImxKeECKtcZhQjGyUa7nti8uGQqyRJSreB8Mpd3/Rc47Lutb2TC1QrJRq?=
 =?us-ascii?Q?QRHSYdzmUBNIvJqoMy3ScfNWClOEz/xvr1XkCV3mVjWmnydoNRDpVnEs2cjl?=
 =?us-ascii?Q?qvUSn1VMkYbf9Xz0sSdDVRV88jK9QIKrQgVd9MSYDHV72ahu8KAYVBAeJT4a?=
 =?us-ascii?Q?K+Dggs4qdMPhZNwZQtxD4v1hhwaXXg61gm+4OUIx/cZJBwaBcXQIdPYoQ/e2?=
 =?us-ascii?Q?PgsmuSzoFZityw+I4Rfci4zOU3DZUIsyAnXbxRDtbbOLTVvc05znm9+Fus7t?=
 =?us-ascii?Q?OI1shajkK9gqq1DSxm+Yj4DBnJ56AvhXSWPmU1SkTfUpHsnx9zGLopCHATRc?=
 =?us-ascii?Q?bLKeH7HQQDkpr/POqiiQshCPQdNTwRSxZOT0DuMReGqdTFaGjH2xMsTkpAmW?=
 =?us-ascii?Q?SbvZUBRTx7dVOSScl/PkNGq5T42czp80XSqgc8BYBbvsm9LJNflgABXqDQ1o?=
 =?us-ascii?Q?NhMaeMsnIaWRMetxmqpwP97Mw9ZEJCWRbpuJKKOTZJ/XSukQ+mu43jC8KF0D?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c824169f-5e49-4b4f-41db-08db34c0fa24
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 03:59:24.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5/NEAD/MZsiVVbas2Tr3Cb4G0iLCukhiSFEmlFwx7d8QVKh2XHY+wuTvENNXshxXAxcKWeyNLHRgCvaUPgFobHbARsLKbRoT90ljfZwfwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> Until the recently release CXL 3.0 specification, there
> was only ever one instance of any given register block pointed
> to by the Register Block Locator DVSEC. Now, the specification allows
> for multiple CXL PMU instances, each with their own register block.
> 
> To enable this add an index parameter to cxl_find_regblock()
> and use that to implement cxl_count_regblock().
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If PMUs are the only consumer of multi-instance register blocks and all
other callers remain oblivious perhaps leave cxl_find_regblock() alone
and have it call a new cxl_find_regblock_instance() internally?

Otherwise, looks good to me.
