Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03606063D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJTPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJTPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:09:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DF6417
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666278549; x=1697814549;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dbdQvZorOt5TmIgdRcGUw8JP1BoOMireWWHmN7dcSqE=;
  b=KSh6OgiMOilc9VI4lNRTKkYQmus0mhPOj7oJ/5TQqTYu4R2X43LQsOX8
   2TCSBPCd0bR9GfBkKKnsW40OzPk25uxi0V0SFIoQxC4qx2GJvVDk/zqmT
   PfarOgM3ftDtH4JJCtA+otfUntMKf1pnZTurnhmdjOuofa8clv1Kfi5Nc
   0bAcO0zen6pGHRN1O15EnKQAWMnMkNz5GxloQGCuVXxCqaLLFZu6Z1tv3
   S8t3ecSds6EIG5EqKKBP6lnwpOIXEEkzvmGq01BnpuKV/+l6OA48dklU2
   TfK7cjNIzRSuz9hh519dF/qGTE6uGfCLq+8LurGd0f1KwIP+TZt0nL2Fv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305472512"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="305472512"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:05:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="698712692"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="698712692"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2022 08:05:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 08:05:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 08:05:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 08:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjFwibxgizPGq6Q6Z1KtCMLiIWtpsKLntyj/2WpXEZmjeTC7QdnwgGD8+KeZXGJuuTdinglPn6bpkjbB8zLP87znejcD29qosI+TKjOzSEol8cR5C72OyCOqScY3e0j3ywlIOK5B40QgqjJtb0IzJTF6GXdNrZLMV4kUY1nnrUsF3OKHyt7l6yBtQJ3vtRQEhe/C1mS4ZnZ1/QW0Pyco9b7REngV/01jUxEiVoftr2VOhzwhDLlYvVmiK4TFPmebORpRBb+ETlZ1UIExoVmvttRQx0Ab33xv6AVILvPaphOeX2yrWxf04CkL7UiuVxJmXXdihAcyy/i/R613o11FQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS3MEmF2uhTXsUQXarQMWvFXyytm5ns2OBoII/E4YqU=;
 b=Ylo9hoNSSa6jiTo0RjfGL5OShn1LONxFOcaRFz2ipxmwSMhLrB3Uti/8VMemcyh4mbrOvd6Yi71GZL6DnS+vArhATMmkzk4cgTxwrh61cjHKbgHvtSxbD6DUlqWYHeugd1fHTi4VcbmID6DZiJZNYQR9tlSqg9V+R0A3zfhUz7hejd9CRBBc4+Rk7nKmCsGlrQoLeY9lpQ2XOlCozQ2b2XOMcLqG5pNSVwbV/GcH4oi9jza/WHRoZen/xWEdyf+Hua4P3sZ/a8KgLBV0fhoCBM+ssAOnBXDgT0xbZDExzl7b6OqPRobCs5jYTIrEDdj9t+42Et2/mJg6VyWBFZBLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:04:59 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 15:04:59 +0000
Date:   Thu, 20 Oct 2022 08:04:53 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/5] x86/microcode: Simplify init path even more
Message-ID: <Y1FjlfVQupDc7q1r@a4bf019067fa.jf.intel.com>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
 <20221019175426.31025-2-bp@alien8.de>
 <Y1BOkbXsQxCZK3U7@a4bf019067fa.jf.intel.com>
 <Y1BSF8ck0RD9UpLd@zn.tnic>
 <Y1EEObR7keIDJtVJ@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1EEObR7keIDJtVJ@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS0PR11MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: b851a663-2ffd-43bb-dd7d-08dab2ac74d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqEqYENkIzoRry6CxKXh6iABk3XcN0vbBcgWj6uzn7KOVtkj67UGOnkbECZ3Wn1vW6Ey4XGgu9PujpLuF+PG3cWIX2lFf+n1r6JSZGcNmCaDL+LqYBTrLCEXkE4CQQiSZM5dpsuFX2AQiXKcdUZtmY0l7Hsp/zoqvA0hbqzmxbfYjH2nvKoGkzA2AH74TFSPp60HyUJrIYZ8+zKQs57tp5lJQDv1jt0NSyWIgAJymg9a/R1lvkkApHm1T1c3Swv3jUl5RyjFEeQL4Rszmn068wfNmzvOTa8Ut6jqtyiY4FwmpBvmwoJ6QcuWxdQWM9xmRlyI+v9OHJhd3HYDQrPluCKqImhydsU8hNvOI8Jl7lvGoWdQsgioBlP7DW07z1yaAFRI1Fpz9Jp+4p08if0XdIO9jstEFplrRlIH1I/MBO1peXGEVgn8d4ff7NigIT/c+TSLm8UsM+FbUXGFQM57Xb6nRcA8VfZS3e0Z8pBoQHO7fRQ9nTLkolyb+V+aPH4HWxNgfVA+qplBpn2m61+co99riggjKwB3HIZNbqK/taw/LWK9C2sYDPgszrR4d6sURZlP6UIMTKDnCab6BQJt3nEKjVYOHEhF0f+eWJVXtDr/JT7GTnJyhkUHtfkJtXBnw8LvtOgq54eCGRWFVISTLIVAIeX3i6RIFRJFeU5Goa7D0JH6XCM5jjuqjfCMFXTlnAl1oBtWVh5szVpo/oLrNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(44832011)(4326008)(6916009)(8676002)(66556008)(66476007)(86362001)(66946007)(83380400001)(41300700001)(6506007)(26005)(5660300002)(316002)(82960400001)(54906003)(8936002)(107886003)(6666004)(6512007)(38100700002)(6486002)(2906002)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hf53mRt6mGQ/6OPk9DXWwni/s5z36Mc3FVTVBkTbhtwtj5TNoGSZL/77iR/D?=
 =?us-ascii?Q?isdCsG1tlCc6CKHfs6BPd3vi/n1ErtueQiKO75Eilt6ge+qEUbEXQb6V3SiI?=
 =?us-ascii?Q?7b8gfGd+ne9cckw3geR7qJqBrjEgEu9wxHVmGSV+tIDgEbejGfEUyA3Euu1d?=
 =?us-ascii?Q?EPR6kY+2J4dGlJyLUZPnK2jQm69pHfnkOu4km1HIElyKa635I5gJzMPg5GrH?=
 =?us-ascii?Q?RQJUmPI/GjnOIZP1ygjljKmlfmpysp/rkcVZV9+CfArUE2l+3enTJ7WK52Mh?=
 =?us-ascii?Q?tynVN3ZFQ4uWYnqOMgo2FOePIkRc1jMhHi2Glgzqx7aTvAtiYmhmXtVgNkyo?=
 =?us-ascii?Q?5wGFklz5GvqxQJlCBEWJBPQgAOvz0vfjtSYBy3UllLmR60khTnHL1SqcnXM3?=
 =?us-ascii?Q?a2XiddL0NL/rMHXeTZFZqq9XvB0M6RK8EH5EnX25Xpt8qzgOue+9MB4ryfa1?=
 =?us-ascii?Q?WLv/0f4wxw8p/HNnkMsYaOamF8nRGajmYsse227HRghvIQO8EnYp9a55H5HT?=
 =?us-ascii?Q?XvOSGIxmSZB+MkUhAOwE0+paxlQmQR0tZURn530DQFs/sSCI/yXF8wtudrXz?=
 =?us-ascii?Q?uhjKoFH+nQCekaO/Tlm5Dmb0u/q5aFzqmmh7c/8qtcq6hHUrJ2hA6dH+O2kb?=
 =?us-ascii?Q?IFTHkgTPuj2DbFj+h99cvsns1qHPiRAnFIwSNgwOu1UePTkC2lT58z+g1W3I?=
 =?us-ascii?Q?2IeEv8aA1lTODK7dNY6ckxT9RdiaKoG8hvP6h2x2UXm/hsgXhizVPFBsl47r?=
 =?us-ascii?Q?09J9cRUsm5TpfI3fbBsS+6vqbeAS/Z/TfPQdDiVQciqXBzjUvR9N3nl/OJGV?=
 =?us-ascii?Q?ymf6cE4UMb02Tm55APxIP959MkdV272S0UGYV+/vxZhig8WZ729lrjC7hB6A?=
 =?us-ascii?Q?2iAmNZJ0y6PNZFYhg2f0UiqP1hUZCZq6Z1/H7orcapziMBARgjtg2488U0zC?=
 =?us-ascii?Q?G0DC3DQibwy1p+0ZYagnzGywutDbxv/lzQ35eDRw9/ajL8pDA4dy/drPRxt9?=
 =?us-ascii?Q?VAVkGgPK437dqgCpFCtvIk1ZL4wvoIUEuWzerifKXKbejFQKIQq1+BzD5y1P?=
 =?us-ascii?Q?T2sRrYNcI+v5v37HZK1PxQ1sWROMKys6pypX26PKZKRiiJonDaBbUN85yBG6?=
 =?us-ascii?Q?A4d/LMVo5gN5oxJXVtivL0DXlII0BfMVyGvC1b/SMscxz7/6trIEeKNJYoQ8?=
 =?us-ascii?Q?Up0smDIMufvIHi0wOA3B4lBcmHP0tPh2LVceNCbCVGnTzfNICWfC08PDCsbe?=
 =?us-ascii?Q?ze5WyW4PUx1osHi11d9q81oZwuMkQd+e/+4F8mdWKxSJ5pJ9HNolCPAht4D6?=
 =?us-ascii?Q?Fyi3bRuwYYVgbyFbUmStQnJJcfIeGDSMhURUZRu7Um34l4TIGpUroD786AkU?=
 =?us-ascii?Q?GdfJgQ+YfdvA/5rP9GCdTppZgfW6nk2TbuuletVUyMkrt02eXh/GYCXd+TmC?=
 =?us-ascii?Q?7JmZg3jiPEcOOB3tACmbjmMl3OMAXcsiEd3mELpeR+TLPByflngQPmyQdPeq?=
 =?us-ascii?Q?2I7DIRBjHOG5QkH5R2fsG30g8QQRUMlpQS33rJgysQXvnXC9IKxuYU56kcAR?=
 =?us-ascii?Q?NHb9dl+EtFYdWT6fDEn2GGz0WsJZmp4MmSsC1EuK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b851a663-2ffd-43bb-dd7d-08dab2ac74d7
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:04:59.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZHQ0mtErHwqBNVsP4EkJmenUyedqzXTOEnCDywAkXyAXgItBWzmBXdFzUp1D3fDgrRVyunklalUmosU3A27+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:18:01AM +0200, Borislav Petkov wrote:
> On Wed, Oct 19, 2022 at 09:37:59PM +0200, Borislav Petkov wrote:
> > Ah ok, yes, I need to check ->request_microcode_fw's retval.
> 
> On a second thought, no I don't have to: the request routine will try to
> load any new microcode but if it fails, ->apply_microcode later simply
> won't find it in the cache. And that's perfectly fine.
> 
> setup_online_cpu() still needs to run on each CPU unconditionally,
> though, in order to setup the sysfs groups.

That's true, its benign for this step.

I tried rebase everything I have, (i need to drop 2 of my patches after
your 5 patch series is applied on top of 6.1.0-rc1. 

Everything works fine, which is good news.

Except I can't get this new load you added in microcode_init() to work. 
It always gets UCODE_NFOUND.

- BIOS had version X
- Early applied Y > X
- I copied a new version Z > Y. 

But i only see the early loaded version. I haven't looked at it yet, but
will try to look today. 

Cheers,
Ashok
