Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD5700D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjELQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjELQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:30:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E6900E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683909054; x=1715445054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mHdciVTtWgzpe9Hh5XKR9paSZU9nTIfOkAvtqgDUoYk=;
  b=CiL2FfCekgog3tNRfQabuZyH7jW8JA2BGdoXoEVgUCty+AH391UlSQr6
   aVQNFBK/rkc4H8FaPmlevwo5oEbjC2hat/yFTrU21rnjcceYnpAM2SeNS
   WfKMA10EORXrA2sfkyorrvVYpFPFKkLUKYUz55AhSa8h4KUSVV+Ze4+gD
   Umyhexj/rGtMAIw/6MEr0d3I3fFSx0Yt9p8tLIpYPeLT5F9klg6F1imTG
   n7P/OlmmxqTGWDaP2+RnUAHoTHMuaX3ygHE+XpF+lWbQMyrq30R71JbW9
   2C4B46/kOHFSWoHOXitPNjYGyPW8uZGisBL7xuLqN2MEWkWpr5LvJ3U3i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="330445632"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="330445632"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="694287361"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694287361"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2023 09:29:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 09:29:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 09:29:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 09:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W94HBxPREO2mz7+UHDpknzjKCtfZm+ZSoLGel2aNY+t5fYOCzObqax22J1DiINALMUwlOyQjEnR6dp3BnMHvEw8LWnqyzjr2ecyuYOvNjgvvqO0lL4MF0KCZ0SrBLOs56GyrDiYsiI4Vov+kfBWvxMVwnxDT+HzCLvcmeK40i+y45F49147heEz7nAVDOPq5Dnn7EOjBC47shyhc4YL1aAe+vjk3/zA9bh4eqURL3Jg60qI7PtNtuhaulRNkGk/84kqgRyUrpAZXmgwiriV+1zsENS+BY2CnYgxExAs5Wi+C6OngfgmoQR3jGFegYym/Sk4rVZsnmcca4IFol3W2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEgQVeX56SyEmbcE18l6IGk6MIboAJzPS0ke2I+qt2U=;
 b=K4pTQLYlFzfWJimjHUTY0LCrp4LYNhtJiLIIxNS3t1I+1GiiOxygc2IEl8SZt0DhGWLBKj4Hn6ymkkVn/16rfogyHrKqdvFvr31jB+ewUjjyjjnHMURpTnUTn0X1aMGLarGa/Fkp3BQxgrKm1GuvOJTxbEA59L89yn92IzWvh7bGwDNnmsdNynVay8eG2dWaehE5CrtosxmwGDsyhDwFXqSPxhgV82yM7POepW9uOSUjpUskr4yvYKuYXTPF764XH4l/K89Cq8UDJww3GTUjIUU9JFRifnJ+1SBU578+wPRvHhfBpvfZCIeorZKzfyQgL3YF9qxne0qaxmAbnuK+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 16:29:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 16:29:26 +0000
Date:   Fri, 12 May 2023 09:29:23 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        <intel-xe@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
Message-ID: <5wfbihhliddinlvsh23dejbuffiz45ecs3wb37qcwyqd3hjfcm@wyhqnobiiu22>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZF4fi5B7PPlgZBOI@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZF4fi5B7PPlgZBOI@smile.fi.intel.com>
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 400a301f-eb12-429c-c2d9-08db53060d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mbaJnhkUC82DSjxKk52VUJZaHGdTWHuiqm80pe3qN5OE91t4LGsL7myTHJDpZY7X5WxR8vrqfR2a6bxiOAbl8Rd//S7GVQ6HwJGyDX+VQEqPx63CtIuxEhZPrEwO+pjaAKKuTsUJeoPPYsWzRPI59dnysjC7TCBud6fFP5gCREMglPzSAAQ8CrAPDx31CG4qY2xNTHU+bOfuDiwSWLAW4XxjdR+1cJq76qnSdRl/enNLHzpJDDMrmqwJ5HUfZK3rqc1+sNCsEQyRcih+gyvE90s3Ol4kO5+3JOFFlARKlOJRpblU7BCpbRZQbhFc8CEofBRCoVKSqErfl5A8HV8UA9BuIbT14NPNujfYmtlseczhO2zNOdOKz/m3SItdmHd9Uo0v3rZzDRFrtjuKC7ck3Mn3BqoBVYQo8uaYRcbuR1vEyd3wgqvuP0mdnsL9atWDbUwiJAyzjYfsFVkIUdber7vjf4fY3qwimdCTnkYbc+57xtpBFs3QeFrHuuJnM5H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(8936002)(6916009)(478600001)(54906003)(7416002)(5660300002)(8676002)(33716001)(2906002)(86362001)(66476007)(4326008)(66556008)(82960400001)(66946007)(316002)(41300700001)(38100700002)(6666004)(186003)(6486002)(6512007)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PY4OxDbnXz9cf65N0jqle6g/iZzEeN/9PBiyho2JpeQ5er/EG1AyTHL3G0M3?=
 =?us-ascii?Q?BkR4Tyo7Gz3PYZsEZlbXfV8Y+jfCwKD2ZnZYGXAgEPfEPgQWfvBVi9+XKI+w?=
 =?us-ascii?Q?8Z7XbFuUKYgscWmQf7PrO/1Im5txOMN21OmMy50gRc+fgO6zTrDUXNiBbjLf?=
 =?us-ascii?Q?GC6v44/nH49fh8dxfbqfzWvvZB6x707N0WtBEkMZXsMqkIzXAo6S6nAZLCKo?=
 =?us-ascii?Q?XcNH//DST/+HrfWIus989z6t3oefPC0Me8KGn6WKFUoRtVitdMMTO5KPrYjq?=
 =?us-ascii?Q?KItHZcygzPyxqXx5X9YE3zDDCDkA+Ih/AIPitMdZQWuA+L8jUaODRb1Oenoq?=
 =?us-ascii?Q?YIcAeTzZWNje2ezg15XFz0BhiugHbpDg6PF04PdW9RyI8FCFBnUOrBHeWcnS?=
 =?us-ascii?Q?kEI3WE2BrAWEMMI8098VzYQbiV7DNlMKhYIla25kd6Dr+b9GnMholdoabXkf?=
 =?us-ascii?Q?luvolmYmIkS00PN3enPwbPoEQAra5oGysnIlL1rXFmrYzI5iErVDfIs6oQje?=
 =?us-ascii?Q?NcoCt7yGXu/YhnzxsmWML8h5Eh/VOt3eTzYHv5kAKVhNhLSvpGZFsPLrC3Vf?=
 =?us-ascii?Q?nQ5LFAh5QHMQx6KtRZn1HMJeTmMJ9jgt6jUoKjP7A9oHRzxESTtCGCA6G1TC?=
 =?us-ascii?Q?jcjQsXqzbIi8c3SmJsMJwVzJWOzdEbxCtZKA/MVWhKTHI0hJKpWuSQ99MRWG?=
 =?us-ascii?Q?4qbTJyMDG3oqku1IFULHXoV3FRlQRKER4tLmb0kEtqd/oK72QDJjCTuVgj1/?=
 =?us-ascii?Q?tZFSCirZatcEeY32d0c6tErzDyMkRxJERjubo+PQL+GC24gluvrIQuR+AWVz?=
 =?us-ascii?Q?7/ETMdgYVMWF1Y1OCC+L1yUyPqO94umQHL21iFo3caSib+fSSiASudBdPnD8?=
 =?us-ascii?Q?Fp4JLhJXn7UjRk7NkWYia4kQoPiuduJTbOHjAwkKVT2QeSMmTll3WZI08Gwo?=
 =?us-ascii?Q?NSTNTA3H85B4HWe6tZ1dW2+7IaufxyYrxsomwDnjsBG9MUrwCPf0VVlp9mPP?=
 =?us-ascii?Q?05VFzaFBynaMHlFpKDPvl4Vhq8ykOn+r7/YqcrjhlLHrTZ6kHCFF+MCjQ6D0?=
 =?us-ascii?Q?2Ou6bGeCWHm/pHZVJ25d4p7XOQnHgxoTBS80P5PJPlo4eDnwnCHzJCfbb/gM?=
 =?us-ascii?Q?3CrnggEi0BGq1obD+7HHPitqzov3cENf7sLPpRzmPW9QLceZpJdJ35XUIAVj?=
 =?us-ascii?Q?/XktKj7oKFiU4goj39BSXJfc2JevvUfoABYFjGkHP4YIrJYIQna0lpRNlzmr?=
 =?us-ascii?Q?hqc4m4jj+0dLv5C1FcakfCHdbWXuWp/wIxR1uNZswKe5E0K49hepTE+oLguA?=
 =?us-ascii?Q?R0zdrYpXV0NchDn/B/ivbIISKXmQejr7Omyw2YfN4LsSa8lzEoV209WfZ/OR?=
 =?us-ascii?Q?d/KlDwXwTJ8/Ah7CY/t7R36yWM63EX+wjPFNyxJX5b3tdyKtRW0REMhF0m2R?=
 =?us-ascii?Q?vttEW4KcFgUg3MaFxv4eSsIBIbOfbNZPiR1C4QWBAVaJwre4Ziz7MaV9e+R3?=
 =?us-ascii?Q?EOdhEsgw5PmBx/5zS5M0KiMBl9OPQomIgdp/mYUnc0/3Wik5Uvv+n30/mVib?=
 =?us-ascii?Q?GFTNIOzQIruZIxGuiFI92R502Tl4u35XkUYoKASotfPJgKbSan4olZsx/zvj?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 400a301f-eb12-429c-c2d9-08db53060d60
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:29:26.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6c38i+HvNUW/mdconMRBbgwT/BWZAjDuirGwmll5lw7HnVCDGTp0KFzpBNMSoMTEByS0Skgl2dONzaP/5l57rLQ7isTAcH6Ih1ceF2d+PPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:14:19PM +0300, Andy Shevchenko wrote:
>On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
>> Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
>> masks for fixed-width types and also the corresponding BIT_U32(),
>> BIT_U16() and BIT_U8().
>
>Why?

to create the masks/values for device registers that are
of a certain width, preventing mistakes like:

	#define REG1		0x10
	#define REG1_ENABLE	BIT(17)
	#define REG1_FOO	GENMASK(16, 15);

	register_write(REG1_ENABLE, REG1);


... if REG1 is a 16bit register for example. There were mistakes in the
past in the i915 source leading to the creation of the REG_* variants on
top of normal GENMASK/BIT (see last patch and commit 09b434d4f6d2
("drm/i915: introduce REG_BIT() and REG_GENMASK() to define register
contents")

We are preparing another driver (xe), still to be merged but already
open (https://gitlab.freedesktop.org/drm/xe/kernel), that has
similar requirements.


>
>> All of those depend on a new "U" suffix added to the integer constant.
>> Due to naming clashes it's better to call the macro U32. Since C doesn't
>> have a proper suffix for short and char types, the U16 and U18 variants
>> just use U32 with one additional check in the BIT_* macros to make
>> sure the compiler gives an error when the those types overflow.
>> The BIT_U16() and BIT_U8() need the help of GENMASK_INPUT_CHECK(),
>> as otherwise they would allow an invalid bit to be passed. Hence
>> implement them in include/linux/bits.h rather than together with
>> the other BIT* variants.
>
>So, we have _Generic() in case you still wish to implement this.

humn... how would a _Generic() help here? The input is 1 or 2 integer
literals (h and l) so the compiler can check it is correct at build
time.  See example above.

Lucas De Marchi
