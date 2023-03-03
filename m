Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3F6AA4A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjCCWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjCCWjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:39:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0038166DB;
        Fri,  3 Mar 2023 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677883063; x=1709419063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BSwOJPrU3WOV2D7KM77n1HGlWnE5cQZG4X3bZzzRBUU=;
  b=LNDge32RJ+n/zc7hl62/jfFmS85IRsOZ0V2IhbWVyxaLZdXtFh0gyRuD
   V5LuBYL4Be6liSkb86PkT9/7oBrvoUek/qFEa3rYUzDPfRm2+6aOEHtnq
   lRgtqyX5VTxG58PZ6xXZu7bqRMuAdzWN32k4Lp/iXZp9j/hF9KCgxSIR9
   gmhUHpbk29WRgRoavLcLwKfRZTSCnmay2ogxSGDaZxxiQoDjXcUtzwNuC
   XsrhnsVgAle4EgjsKqMQxwnMoMCxcxCEJSk03M8gUgmiBlx6nxYqW1E4k
   ck0IbbdC3PBOwqNgZsp7rFtrzzHtjQu/GVW+2qcCP/bl5idJ5ZP3/SOc4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="333898726"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="333898726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="668807425"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="668807425"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2023 14:36:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 14:36:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 14:36:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 14:36:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFJMGl0QhE+n2fC59B4a+Whoe5lW8lLTF1SfiqP9mKXfKMYVk+/tX9o46ITz/jDB3yMpDxXCdWIp9zTJFST1/Lv9Eu8Ia0XsqM6ZHUpS31UJ1/0Ypg1MElsYuiHdqOBeRMPLQnYpyyt7JIraKBaMAEqVOJv8JVrPaPMXSURKgsY2fwIcifS2PlME2SPNPugwp9fv59YND+lcD5SP9xXCM6PdtoVNV/mlcuOgTTioMJYyvKmuqJWmp7cOZoZHbA/T9VsJS9BY6U4spSCTVV+mAfMPbFec5AzfUeSb3rCCFKqCz8dtKgNxnxmvrHxPxZkAr0iyIBOy2AMn5imq4WR33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKtgoy9bZgWdjwffHisB2qBI2VXEjTJv+V248scZ0po=;
 b=aCSYUGBm2UoCIKGbHyuHT53g7ybdUYL1gEnRtDRj5CLpAeE21NRD1aNxp99aBTkk9fhJmOl3GRcVK4UEfwMFUDfFQws2ZPDpYYEftob7E+utg26af2iDI1to6oORUhzNaB9lQhhFTdoXE+KPfreKZgfY/0HBMmY6Hx5B4nbKwUlkOyWM/uugKAb10evSBo37h0+IHto3/aqn8VgSs6cmdK+JA7vg81KIU94Nqy5rof3SyXk5ZOT53yaP7BgQRxwBdOg6z0oAVg6V7xxp6yiaFzgjE/ebbQIywT6CPPij+S1Ch/1j8yzhpsfmIUJL+fTReo4HSMlrbal6bEUUFXH5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 22:36:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 22:36:27 +0000
Date:   Fri, 3 Mar 2023 14:36:25 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Message-ID: <640276695c8e8_5b27929473@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
 <20230228224014.1402545-1-fan.ni@samsung.com>
 <64025f6219d2d_71138294e5@dwillia2-xfh.jf.intel.com.notmuch>
 <20230303215446.GA1479551@bgt-140510-bm03>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303215446.GA1479551@bgt-140510-bm03>
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: f64f49ea-8a87-4fb6-582e-08db1c37b9f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsL8la8YFKsGBBiMIdutoV+pPqvn4PExscj2aaeXrrvRuGh9yjx0NGYBB5/NocM4GvE/2K7BKn9o1u0hYMmTmkIRBz9xa8tj4ZPeM2zLyTxJK1NsqEwBZuje5lyXslm9UKkEwmc8Oa/E4XIZYB7G+nTTm7zm8fQDo2ibJ9E6OR8JPArpiGm6oULWhTkyXOFm1c3FGTWven+X4kCmnVIYxIimPZotY6Tha1uMy5RCjbIGhei7DpvzxmKRUUKfOrpqGXVs/RODpnSzJR4RKn07AJZ2UhGpZTlq94L+5mb3Qg2v5c5ZBjwy+5WqncGIKZLroWG64pjLNSRNg0ltuA+r57PpMVaTSZfXsMQaQ1e1rTBe2Si+z3KdILmi6/ISaGv+vQtxV6MSr9qUyi/h9ZLKEP1cIq2FxTICJOVyh8cyffH/jGaDChqv1sfLdZ1xIhUzGu09fl1xFG5rbxMXXAEiDtfQQkDCT20XwsFFB6Dn+mF/3wMVpVaJPMwwgCBO7FxsW+m6ErEnJDgRGN/DKctCgYuf0s+SfTfUWK/8IatycgFjfE81hUyp0bjyasFzGx95WrH83DyjVGZEXHO+LkBPPejC7ocNcUtHjzlm1nRNAIkmGI2t7jJT0qSt1AIWg3TVO9owbsvDSFFE0nwPskO4HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(86362001)(6512007)(6506007)(2906002)(6486002)(9686003)(186003)(26005)(82960400001)(478600001)(5660300002)(110136005)(83380400001)(54906003)(4326008)(8676002)(66476007)(8936002)(66556008)(316002)(66946007)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xE/xh8EhNfKsONdlB0zU7BNgIa473holRyYphmOJfV0twwDYH76lCvlsM7ZS?=
 =?us-ascii?Q?RbHSfGVeOIdPn9/9E1QUMl0h1f9ym01jlVGi07IoL4ogAj6/OtcpgqFGDkVm?=
 =?us-ascii?Q?RWmVRk6OvEtOiuM9ABt7gQL1cLlXllE/j2IsAzccpQ7vc1yBcS3sWuGpUZhx?=
 =?us-ascii?Q?u8wPP0zdTyMk33TfuFirRC6GYRoMmLu7k7AnesqPeC5AGgBDX8+DlBYKmews?=
 =?us-ascii?Q?7w5sDkO/zae7oQPaPtl7pCA6f2ThVFE74q/PGzrJOnHsI1kIVetPBszD7X3p?=
 =?us-ascii?Q?XFPfDdB0NhvIjCd5TaOIVl7vvBHMmzbwDsKi2xnjMQRzolSgBhPGVNjIH+Ov?=
 =?us-ascii?Q?0tyqRamDgBwJY7RRg6BEt6lkpFJD/Ttp5tIWVas1jmlbZZqKT1CU8T7Ei53K?=
 =?us-ascii?Q?XlhueAJKxkXOElH6xbzB6sEC3xut4w1cowytIWCupOc3PvxEFRgGfoV5wKTR?=
 =?us-ascii?Q?U8hTygxM3cMwZ6ejKJd7YI5vVFByXjwS0LksWVxK6Nm2btc7HT/MTP5CS+Bp?=
 =?us-ascii?Q?nzreycycjUnotncJa+8b8OI9hE0u8MVhXvaEErUrS0jXDTsAkSFCvJV1DM72?=
 =?us-ascii?Q?wesZ4RUC9B0t5vsDIvxDcqvOWBqnW+0xsDhQ5Me5OkqbtRM2UMeODRtEadHs?=
 =?us-ascii?Q?Zh4bo0sjF7iuZZSQTQctlEuuonLQ70GzsmxBF+Rb8fEa9uq4d/acwle1SI6k?=
 =?us-ascii?Q?U5CmcxZQIPXB0d4Nw6jxvDT5RSAMFkRB20S4aSX/wV1uhHY8ifyBZxVxYqVs?=
 =?us-ascii?Q?DW4lqPlpyKoPppvkr2hCr/HpFhatc6P7rOpX2/Dr1ywpGWJDiVu7P1FeRiKS?=
 =?us-ascii?Q?mFMAXRoaPr8paMTtqz/lTaaVLKnJSgRVIcvlVN3wI1hsL85xodOvAVyaQWty?=
 =?us-ascii?Q?cIXPC+PeL/G42Fqj5tiXXnxMR1HDAkttQZ+IMpz6/RLKM4zG6ekifmZKSZdE?=
 =?us-ascii?Q?K3MzAe+6kjDFhA6m+Y2ui+eEzULRrA85kone4d1jk9aC5XbFKTm8/40Z5lQw?=
 =?us-ascii?Q?lZnBONxtr4u2grNWauSYw92IwlH3aJya316yORjezymMWNDUFvy++8XTbC7N?=
 =?us-ascii?Q?+RfESW5Zmzs/ZkirBQG4qIrwFvtKNsr4iqXLImnqUiO7h/Og//O0xYrd53K+?=
 =?us-ascii?Q?brC+8XPnYAp6M10+VQ6dHCFjPjaBndk0Qae6KS0N5nvRZxdOHSM4lzwtKcSE?=
 =?us-ascii?Q?/TDKHCoHRUQBpzzvMw16lk3ZzwtXb7lj8euY1fDRG0Orlw4/H+t3j1DEmL2q?=
 =?us-ascii?Q?CKuQ152klcWBv1napYqB6pWz+vgKCA2H1lEzIa2zaza/k0oLUHSMNyV0Mf0I?=
 =?us-ascii?Q?XUfiekk3ER8t1CnsjaiS19mB2TIqduTB92l84Jm30/4idWEzioXRHYdJ4QXs?=
 =?us-ascii?Q?46ghVtx1eKhPBWfmyHceugcqnlSlb8hDi1tvI/w8Yc5pBAZeRmhDqjRvDdCb?=
 =?us-ascii?Q?ukUmWQGZrUYo58NjY2Joqn3FZQRr2gSprjAMuEOxeA8gIqnig8HfvHFVGmEs?=
 =?us-ascii?Q?FFXQegzH7OBgb4Ui+jP56ZFfeKJPQNVsSd1LnRRvGKRYJlDRDrCjhMeFBAh/?=
 =?us-ascii?Q?G5Sr1iemd5GKHjrR0YUp8Gys3CvRsgi92NfYMuLibM/G4WDIRDZUEJoIB3/j?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f64f49ea-8a87-4fb6-582e-08db1c37b9f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 22:36:27.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83RiURCTyxWHjhrFQjBLo7qYomcbtYeWWtlE4ZWv08jKSeMauMXz76cQrSAywvehLrG942wLsjEPwLUiGPGYmerBwzPHLxYECrX+CQZ6Dv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fan Ni wrote:
[..]
> > I think a separate fix for that crash is needed, can you send the
> > backtrace? I.e. I worry that crash can be triggered by other means.
> Hi Dan,
> See backtrace below.

Thanks, I'll take a look. 

[..]
> > > @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> > >  	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> > >  	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> > >  	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> > > +	should_commit = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
> > 
> > This change looks like a good idea in general given the ambiguity of
> > 'committed'. However just combine the two checks into the @committed
> > variable with something like this:
> > 
> > commit_mask = CXL_HDM_DECODER0_CTRL_COMMITTED|CXL_HDM_DECODER0_CTRL_COMMIT;
> > committed = (ctrl & commit_mask) == commit_mask;

Did you also notice this ^^^ request for a fixed up version of the
current patch?
