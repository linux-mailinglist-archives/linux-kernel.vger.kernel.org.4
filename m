Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD49E607DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJURwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJURwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:52:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D628B1A2;
        Fri, 21 Oct 2022 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666374764; x=1697910764;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SioGyfPUxqpE17cSeJ4oxgHS50PCdL9O6wfH9NpvMZQ=;
  b=ba0ROVkGNdjXYuvfRApC7Jjc126qHeiU/ISOv67KIYCgCwBzuKSPkZGT
   3TakvldRMhxLxLm5ZJeLSeVQtb3yAP2uZ+iyAcocYSpoa35oVFEof18O6
   sE1Ac6zLjevC+UIo8WEw2FmEurlSYVHl3CHfkptG9oHVGM1jBj/H1hrzh
   xEvqZsvitiupBtBA/58V8HK6gc51a0v2jF+b9/kyi0VSaB8rpflaKtS4l
   3eu+BU2iB9ZMiBttcItjK7MnIrC9qzBTKLm0YdEvsNFgJEm5EwkoRLRyX
   t2Euf4gNKpxes6vwRfvNhdnWHB5hMbr9ivAL5andviLAD2HHJgVGvcDOY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308162101"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="308162101"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="699445392"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="699445392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 10:52:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:52:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 10:52:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 10:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea2Ec+7Akr9N6U0iqp+en0IuwCUuJTH38xG/DatBiWICl8idd7rXHeGjlDYUb829TpMMsKV5PL+gn0dkGabOiqqYr6B23XSpRasyRyWrkpq1cjLKHdEwryuzKfVp/6fBRa039RuLAca8CpHU4SW5bPbtYb87Li4DFsAQAum7xY+Yn9pyzcYgezxHCpaXeBVoG7chY4qxOngeS7jrt2bos+4uku6MBUhBa3pPwKPZZfLsR+3a0bW9c9qpdUuSFCbz5G93iRBJSuxECTwN+AupeHaHmK7XBuz6bh7Hve/FbhnHRF0/jsqGdkgvAu9RZjiEG1w0V2VgXhwhospseM0JaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp8GZxWWbclDHTZTLvd8YsR9gWTtj1NOZHrJaBqmIOg=;
 b=Ci8ONZtguH1PHlGMc7EZsau58vbuORM/4fvFDYomx/zG1hz07ekATF7cJRPNs70IaTP9SBsqBQFCYoMSjHAPz09PDzIVnj1SI0c+eZ+znrNplOb5DR5gVwhVZt4BPVR3mHpZbIGne7SNcRdfOg2fY/Dp18AC/DR2b43SnTxvEpe5/Cf2HXEwH3yRlNFCXilzoGUoBLcha+wK0CaInA/Pyh/179JkKsRjOqXWNSRerazhs7INt8Erbwomu+4SY1g+2aCzXzeRe+fn4JEFP9V0WIFVUPtXRMGQ5PiHDjYnSZi+oKpXPK2rEL5PZYbwWYM0d/9/A7Uzyx1lLq6YKOwy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7019.namprd11.prod.outlook.com
 (2603:10b6:806:2ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 17:52:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 17:52:40 +0000
Date:   Fri, 21 Oct 2022 10:52:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Adam Manzanares <a.manzanares@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adam Manzanares" <a.manzanares@samsung.com>
Subject: RE: [PATCH v2] cxl: Replace HDM decoder granularity magic numbers
Message-ID: <6352dc6510092_4da3294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20220829220315uscas1p125d01bdd52a7aa6fd07c26bef7ead825@uscas1p1.samsung.com>
 <20220829220249.243888-1-a.manzanares@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220829220249.243888-1-a.manzanares@samsung.com>
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3591de5a-f7dc-4ab7-598d-08dab38d0c47
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2w/VcSprRx6wkDgdQ3FB+TD5PhKiIP2ABdBy1PiGAGWMQatnqoJP2CORnnrFmdDbSBLW3SWeNB7nwfhhtbCJFq1Bb/NKtEysInSIAF8I1pM6gSBaT9fIRNpyX0pwBmeiunrUAWK7T6C5TDwoXtdBedMf7X+zMiA5iJGBiADqXgfMLyqFtxYpnrK3sGS+rFGm8UCfbBwRRfDM1JyXOilKC7LPu/XHp+7RRYCERs/q+4p3xoT3bNk1IxR0wRmznaF3b5ab6G9oRqXLkta70dxpz+wXmigDWfNw8RWk+qWh53P8WtUrBOQn/s1xqK17O6v3le7oVleZ8lrxx56I2++MPdb/s1DhFPEftzY+GcSs7hCIsdMyXLkOBpAvzwpgZSL/XfSBSjZ+rktCWLZLC4p0a+rFf5rkYBTolKLn1pXq1ITo2qYWvZSeV3y5B/bAyp08N1Ego9csVXZctWf99I2wMbIpnya/K9xrrqrLBp+PhiqvE16G33pp+0BZj8jwJAHreNPlqiMI26jTWzbxjU2qx1mHUy6XFFHSGY0bQF2e4/lvfWdbwq9hg1nukj9qFJielwGl1KAMq/fxwHdrnsXIDkun6sv8bZ2+YhuiP4h5gYEjKxjPTiPzcA4RhSdYVirtWqZcqY2UfKXvIrOS97k6n4LCwiBmI7pXEXoEHJoYNFTb9qE2P0ToAzEvbd3+kfNL337fSvDXQzIrgj0fUE8OIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199015)(26005)(54906003)(110136005)(82960400001)(38100700002)(2906002)(316002)(186003)(66899015)(6486002)(83380400001)(478600001)(86362001)(6506007)(4744005)(5660300002)(9686003)(41300700001)(6512007)(8936002)(66556008)(6666004)(4326008)(66476007)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LxQVeAdt7DhtkwieaXQIAdsHwGaH0pZRyQhBZzEjfbCDDXRJ7h7NiJEPTwHx?=
 =?us-ascii?Q?s+HdTOE9ImuRbkFgW9FCrHTsD+2708cBgfVaScge7hmVR4X5H013CSWi6Gs+?=
 =?us-ascii?Q?VzxgGHCRyfugkymIy07IemPmONcK8UdJXFiV+4+YqARQ1zQfIyF4eZSPi54X?=
 =?us-ascii?Q?zgEIL30k+6RbiBnxq8CQmr7xJ5tXsTDlhtTtNpELqpG8E8uVfVtyPHEsy71L?=
 =?us-ascii?Q?fccxDjMAwQbAiraZqB5nCnYPeVw5qkcLKDE/CHfrk8ahrAe19iPD2C5ZtfMv?=
 =?us-ascii?Q?nn2YVz5ITYWXT8IgWD7lj0Ti4n3se2xNE6OT9Ia/7x93AAwYbTZFdTCxg99m?=
 =?us-ascii?Q?HSfpBvZymrzzo96XvwQ5WgWXwlb+yO5Wnpei9THgTnLQNCt3SD33Pzqwy9ti?=
 =?us-ascii?Q?yHWJyWfwAwOnSpnHpRhM+Iw1Mr6ElzYlRR/x6nQTyybmBUCyVos4XU2pE8Fu?=
 =?us-ascii?Q?2/yELHi41brKB+UVGKH4jQM6E6cZi0krKX6avm78rE5HvopgMQMszb1U5c/1?=
 =?us-ascii?Q?Ycn2YQyHvSHrAgo554wCXm9fphgCQAlVrBz2jXkIsrW85iqHKDxZT0soax+i?=
 =?us-ascii?Q?hD3Pi/8fnl/sPBcOtMxBRBfMFGB1mbxjFc395SCWgAEF9ql4URDaW4+YIwAz?=
 =?us-ascii?Q?fNQ1yesKJD05JlMVPXfJtgdAUKhohD5xiHLHF4olBL9nTowLh4Aik4Ykk1sS?=
 =?us-ascii?Q?7S/+XGSfgWQqnSjLWV9+av2uZGcFrNBGAbRuRIfy1YGqvw5ZdOM8x9x30roi?=
 =?us-ascii?Q?23Bo52u7hufCERuHB0wI6XvRCP5X5EAzVBcsAUGaH50YWjY4c1GzFhDnonM1?=
 =?us-ascii?Q?5io0FvTsYJXOK03L4ZOPBrSmPAPY1Y23x5g/mrpQ2ElJovixNSiyaElMgdtT?=
 =?us-ascii?Q?sYqjv4RDcjv6RMa/MaLrstL9tnq3fDse4mLaDXLOc1fQDBFbxEiJKxhEHlZa?=
 =?us-ascii?Q?uKxq4p/uWNgLZc2i/8RrhFgACvTnAfVvKxNKaLibQXpD9twnr4wj0oeNc1ZC?=
 =?us-ascii?Q?U1DMuTr64AMmTsfDi6VaUj0yDtJuRXFpcoR5GFxsNBYH/3I4hlDOGYCDhcrp?=
 =?us-ascii?Q?6VlxeMr0lsc79HeoI4CipVDkP0oP9hL7k45CMQk91HrHCOpWEzWtTp/PV7n0?=
 =?us-ascii?Q?hxDk3/hetYCZ/s1Tx9XJu5KuLyBAoqwnn8T1m4r8uMT1+TNmkzIt+XVMrQh4?=
 =?us-ascii?Q?RcocOMRlRrHhPoZncMK2KiHllEB7hv6Tuyt4JWBLj7I77xanq9hk58Bcr9QQ?=
 =?us-ascii?Q?Qd/UzweqTZK7jIUm2ZU15abx4YZII36WYn9ju17K5zHwtsvas/QHKP4vbwr0?=
 =?us-ascii?Q?a0lH4dMWEs1SqWv5YM/19AMD5sZh2JmGiCSZyd49Vxmg0EqsdhTKmc++IJ/u?=
 =?us-ascii?Q?uB5TA2d3OPfwldk3fH2+Jdnn6ne5Wxi4dJf+RyZhGc6eq68PTbbNsbHG6XuQ?=
 =?us-ascii?Q?GZMogaqfwHkgggNaQUiJVLVEX+vQTZi76u1hgt/YjbCCerdj76x3bSNAw52v?=
 =?us-ascii?Q?IEuMmZW7tT9TFkpRgAbyiGu1gKUDV2GDdFOpzPBqz0mU0IYMDvMh8AGmF1KW?=
 =?us-ascii?Q?0ke08t7Gehno/4+tJbNYOzvKVsLkxOhAnbaCo8Ccl87l95y9VfKfjdUp3c5M?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3591de5a-f7dc-4ab7-598d-08dab38d0c47
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 17:52:40.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f41sJuX8ZFU4LPSGiwvVwCcM6ejftE+yebDcSkz2cgNhjV+XSsEa1AIJ/rP1JRNkA0KCCwV1BMF2Y6VGPJe4oF9B15Po5epYm1gK9g76yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Manzanares wrote:
> When reviewing the CFMWS parsing code that deals with the HDM decoders,
> I noticed a couple of magic numbers. This commit replaces these magic numbers
> with constants defined by the CXL 3.0 specification.
> 
> v2:
>  - Change references to CXL 3.0 specification (David)
>  - CXL_DECODER_MAX_GRANULARITY_ORDER -> CXL_DECODER_MAX_ENCODED_IG (Dan)
> 
> Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>

Applied for 6.2.
