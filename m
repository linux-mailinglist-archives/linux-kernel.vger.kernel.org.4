Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C15F719F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiJFXRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiJFXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:17:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B485CAE51;
        Thu,  6 Oct 2022 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665098269; x=1696634269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qh+BIREdPjwB4pdSJ1JIt5PnaRlyIZMvNj7GrQg0fO0=;
  b=da7lUH1B+aBwJUhjgx4RS+Q1pRM4Ltn1SOIlPuvraQqT/PI5HRWsJug9
   hEwncgrSOC3LLipVC5YR2R4OKUlV0DJ3ShaSmpi530uidLTaX6mpIdBXI
   /SFXF1EvrCrY0oBHBIQyoDR5YambJ/fUppLpCqzW1E4hdm09VbRFR3xu2
   BO/T1K71TfbxFd1OD+AnlHsU6oxwBtr+Q/Q7p7Rgwh86cXuOtiQhZ3DOt
   Hk4ztnXkzY4eZHJjNmWn/bfimsEYJGjAhhpAa12ZNl6ye5b7537nsdEND
   U1Nn/JmTB2KqzssF+XUvfgXxK1Muh0nFT8AyBYorfGwNfKIff7slfoxbq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="389892204"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="389892204"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 16:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="576020476"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="576020476"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2022 16:17:47 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 16:17:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 16:17:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 16:17:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boF3PM95OLwwFznLhQG34eMX8T4vFO3Dtt8N6saQwHQU+iVd6LJWQ6j++HIh7PfzKRfc6Ifhgn5bWFMe6jWxf+/x/bcaNByaafsIZah+N3oeklabB/JphFOy1sHzIiDDD9rdgMA3HbTbsPxhfsa5q5iUAJeFDQmoumVqdgyHc+d2gyEe4LUyURzqfd2zQQyGXChR37aE/ur/3nrKt2SarrJqf54+KhiUnyK40unv9MZynJAqgWDMbX9yoJwKflmnuN96qlgUAmD94eSoAUhWEvLDDfT6dJ2GqnRM7wQY9Rjg3pGpRP96JYuQinIf1iv6RDwfOt9XSIKobv7Q/VOMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/HyKqVRnbrrXTLGDyD8WmIU1OsAOf0OfLKAEbuAKC4=;
 b=bJLv5xqR+uMdFNhYpTQ5ikF2QudU5cEEMWQabtNzxYM6y0x1wThyTwNe9VuPHYXDmOusDFm+kzj8LbLbbchIPlSm/awbraqUcYfzYtYAZEBbIJNUP3FnWlBneMDlb+zCQ6xxVnwU8eRLw4yEDHdPkVBkR0hiD9m2qvYC87XUJE7Mxrv5bVCd0jvqJGWIj7otrd6Qwqbvosxmg7bK6usNVHB4WmZbwAf2UmigeM5rgN2T5BXva7M1kA4OIOr+q4c0MI10T8vCJ/YuPFjPSH73GVUoDqcNBTliRkj1QEAnvekT57I3tKaDyTV1YGUQ1HFhW9Gk0+XOJUw7e1/g+qs+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 23:17:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%6]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 23:17:44 +0000
Date:   Thu, 6 Oct 2022 16:17:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Yz9iEwCZDa4F5pii@iweiny-desk3>
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <3694452.kQq0lBPeGt@mypc>
 <d64e6e9f-27b9-9bbb-aaf8-fca1681eada5@intel.com>
 <8124835.T7Z3S40VBb@mypc>
 <3dfccc80-e089-4915-d57e-96d26b237182@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3dfccc80-e089-4915-d57e-96d26b237182@intel.com>
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6d642b-fae9-410c-209f-08daa7f0f95b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Um+luB2ZQQfRCNKpYk8RzZ2dKgiQP0CdrahKWf+yYJab/z5aZMlB69CzG077zOpDZQ7qR2vrCy1O2SCOX7aFCeBmp6D5sFscVsSAyh0KZn1sw3bebIZJP+eLxSmx3K9d313BpcdJ+aEdeAKz6SOd9P2z/mOe4KF8zfP+lg93am/R6OkUJ29a/USiGgiZG8NJc2Fb8dWK8NX6c2TJO6rt6+MhZLDEpmx9gJ99PT7Vy7hL4fmLyw71OReNNfYAtUXwE0Ej7ymvt+5zE0Mx65sovt7pLAprt4JB46AtAVQEH7srk/xBF9QSKVLMGje5n886X2kUZiQ1tBi3TPUFsRnzMeL8gNNt+YwCu8kkjvZelQOPaD8mO372ZRl6aeEE1ExuUmc/yWQTFiCel4xB2Oadfhn/IyvPTHA1kpZeAecA2IOKLqxxb9oi9sOAhFFZ/izSEPb1RsfWPfc6Uy5ZMYpX9FC6ghF4y4avM5R4S2dH7fKZl2U85+WMbQ9avLYCxjvUBJCEy/UBAkxuQeMRUA2R2fpNdX/PkW5dWa+rNVx+mG1hGreGa5zC0dDVnHoNbQAIbshKPquhmqACT6NMvo7WYzozi5PV9dHKT/BuStvnRTwdi8MB8wGn0gHOpom4Dr1WvknMrDrzPcNpSOIiez05110XSJx/KyV6TzNLonXlIrd7JpHHSEj+2Kgq0814bOl/yTgrufPG955w07oojR5J3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(54906003)(6636002)(316002)(86362001)(8936002)(6862004)(7416002)(5660300002)(2906002)(66556008)(66946007)(44832011)(66476007)(41300700001)(4326008)(8676002)(186003)(53546011)(33716001)(6506007)(6512007)(6666004)(478600001)(9686003)(6486002)(82960400001)(38100700002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m3F0YT10b0zy92/dcgBQMvo328vyp5GJff2M8yADvQVKRQhe2QEQoyvFxtwu?=
 =?us-ascii?Q?FA9iBJXWlcRw594bV57vTVdb8PodLs5Pr6V/jwBHxCMT0XGtAVO8OyASE900?=
 =?us-ascii?Q?I5/X4CgG6RhTIazQV6hUp/ZHMEbTxDbNqkERFEwFggvxmSAwXQ6m/rCJVcCu?=
 =?us-ascii?Q?VwDXSQm6yxAATb5qFKbnwAYLtvwBvVW1ApDTRV6Xx6VMkbIf6EP1n2wIWy6w?=
 =?us-ascii?Q?wJDqnEWWkT5ch80De/TEXERQAJsw7icN9rmN62AZPgi8CnpAegPSY/KEIPZP?=
 =?us-ascii?Q?8VTfaQ7Zjdn4nNXhUH+rcngGsVs8aydAdcDIEHrJRmcW8d0XffA/x7bDVCze?=
 =?us-ascii?Q?GY5HZRl0tHE+OtkuZpTkyC+j2ugz5sLvlyvIo3M9rbf233SeMD7WMUcrO5mn?=
 =?us-ascii?Q?duOgla5QF7ZgLKmtWzDL8lGSEWcuoej2ghr/ph10724A7uoLwH+od8AgSx5r?=
 =?us-ascii?Q?3TxHc2o2CX4HqO1LTK4MOJjgjZjspJ/2yIycfgOXTL5peQ3vvwshF6rkxj+f?=
 =?us-ascii?Q?63CB9/qypWONFwqlqOUQs7ilG3gVxar6h37lkT8G3jOQ9JNhKkkeNhy1WU6f?=
 =?us-ascii?Q?MFtBeylCAunkUXeEa0B88ucpi0DsHL2rrHZKsNd6a3zVFxUaDa8I7VwVD8Ot?=
 =?us-ascii?Q?0ts1qNyWk0juKTc2L4oKy8CRNg8iEm0PgCg7gej6ROGxKahhqf1sm/g6SvL+?=
 =?us-ascii?Q?7syKWoW6keuKstDO/kq/L0L0c6JEm40Mb5rrq31nJgBXtA7dF4Te01mbNjQ1?=
 =?us-ascii?Q?lPxKnZhcad7cEIJnWX1MTHCIbD6aIPL8fesDYwKDGKEjlQAJp7+P8mUMKXQW?=
 =?us-ascii?Q?0+4fbPwbGCMBg5jBQZhy8u9ZDcX5plD0OXCJyKTCuU0PYYLLGqabPua3HS0M?=
 =?us-ascii?Q?OEhIsQ8d6N4E3fWiX5gM/nIU4ts+kN/IsPekuaJWFdl7h2YSv4gw377rrL5V?=
 =?us-ascii?Q?BCly6d/Ltz+O1qlFaKeLM8MX/hoOVKbVWqrf6X3xKdCqU8rEB+IyHSfnpl8N?=
 =?us-ascii?Q?Oiyh8R4CvQJLohRKc+TJsEH2CcXPppa7yB2D+0Z1QP2yCpwp/9gUsv8fgFy/?=
 =?us-ascii?Q?WBijxU/owoTQvkjXSspqUoQsEzHld6zOOeSPRNB/GaZsmuFelQRh+3P/S79f?=
 =?us-ascii?Q?tLqKUcPP4168sg2MKZdqi6PDVXRg+LpM5bkBDnlLIdLsS4e96CwkhkTkNUSj?=
 =?us-ascii?Q?WQZBs1wF9QbST8XcIv88L3RX8toPEvf1YS+JdFiGP2wnDyAfy0JRU8PWt0YW?=
 =?us-ascii?Q?1UDhCn1MqK73dSVBk3Yx7AXfnVsw0IHeMKxQX5FR5pdbaXjP9y9j2LRhMfVK?=
 =?us-ascii?Q?W/FTFPgyHALBXjEbjlz7x+38coqCYzpg5z3TQHmIpuo5A6ZMHkk3q2bSD/l+?=
 =?us-ascii?Q?MWJfOiaLtx+vdYXQx5GoPQhkGblIiqM5LyCAfTWWUA532pom+XvLkiqe+5oh?=
 =?us-ascii?Q?vmXG2R8luSIwfnAFYUZMffI7KqJAl4STusg2SNssUHZR/AK3ZhelAOsEPLP1?=
 =?us-ascii?Q?EuntFlUvB8gkycObaUv9dhPK3V8DGWlJCXIgpzkQDiaJA9mfF+ftfhqphcX8?=
 =?us-ascii?Q?gueshDuzb/gsveWuYrD7lnYDX9HRVwUB3pnry3Oi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6d642b-fae9-410c-209f-08daa7f0f95b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 23:17:44.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D9FgN1ZfPU/P6TZH7NckwbanfYOI7xACdCVZrVm1tfO9rQiG0dsVOyRD/7kTOPLuyzC83bKYwu+YJf9OkAFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:29:35PM -0700, Hansen, Dave wrote:
> On 10/6/22 15:02, Fabio M. De Francesco wrote:
> > On Thursday, October 6, 2022 10:45:56 PM CEST Dave Hansen wrote:
> > Am I still missing anything fundamental?
> 
> Yes. :)
> 
> kmap() users can sleep.  That means the number of them that you need to
> keep around is unbounded.  kmap_atomic()'s fundamentally can't sleep so
> you need fewer of them.  That means that when you kunmap_atomic() you
> can use a simple, fast, CPU-local TLB flushing operation.  kunmap()
> eventually requires a big fat global TLB flush.
> 
> So, you're right.  On lowmem-only systems, kmap() *can* be cheaper than
> kmap_atomic().  But, on highmem systems there's no contest:
> kmap_atomic() is king.
> 
> That's why kmap_atomic() is and should be the default.

But in the last few years optimizing lowmem systems has been the default.  Few
care about the performance of highmem systems.

Given that we don't want to ever use kmap() nor kmap_atomic() going forward I
think this discussion is purely academic.

Ira
