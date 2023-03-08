Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22F6AFDD2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCHEVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCHEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:21:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A481A42C8;
        Tue,  7 Mar 2023 20:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678249242; x=1709785242;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cB5nMrWXsU2hMzX9s8Q3VLPmuLHP2Jr/M+1OR8jtkqw=;
  b=bDNQhd78f8u98DpeX/jwozsjyzf7WV1Rp3xEJQ5sUpR00nj5hz9wTYkd
   QexkmTDDOcHikHud1j17Bqmj3XcwYJBoMVcIzn+BYrXndz1Ivsouy3wqg
   aBsyFYdccmNNeI+anv49zRTR8hFJy139ReN++SuafaSHnVuhOqXU2Enij
   xrvAxEQh0b6LupYSX/IY1jLzL+6EM1jTXGHMF6S0386OKRgvJlqoxtB7h
   nxAlAMoedW+GNS0RBj5FDocHS8z7hqP0EgfZN8PSNkMs0FJ0OfWzqUZhv
   RrDoIGfDO+xy07+8KIOo76mx33RV99/2PtMJdH2zLv5CTK7Gf25z9Qmu7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422322643"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="422322643"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 20:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="707040373"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="707040373"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2023 20:20:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 20:20:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 20:20:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 20:20:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGgo/U3S4Td9H1Owt1b7Kbb13GS3VFQP7tilZvHzTdB390J0Qq6jzp3vIInUZCD1uM5Ak3GAyd10LVLVu9Wmi1xY6S7byfjVTRsT+fGepD+1hq5zhzqO6NKbPW5G93Yj3SKQ9yQhRAXxQXGL1CyNMCDJxkOVI1liYd0MElf1Sjf1FHSci24X7lCIP27T6+oz0loZWEgGpIyLNAU3JH3rriUQVhgJ6GJTih5agBWys0R0gRn3uBWQaghRRzta6mJAsjISWyyYaNmYSLqACZr/3hHLJBHWLcbJT3TW5+E2LM9SdriJTdUIAd/U1Dhvum0cIzsVee0ks2QgZmbYh4c98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZlxwDZ07Q30GVwrQkXi30vOYc2eHPnefbw17s6Fiyk=;
 b=coOjjdk54uRZZrDnyg0IsZ8CPDhh5k+FPUSntOkAjDYZmRsm6Brz8WIR73/D9bYvBsjOeFppf8J6snibZ2f5+MwfzdvCxjNy+QpPfZSqqIlLdXF7HGVZV+XrLSVTigFjxltLyM7icU7NOIV29OMPk3/dz0Q+sDpyHaC8Xl+9GxX0x2RasE9xSa9tIVRBwRnbVMHNdw/ANFUmg5KSkyBKvvtt2S8vZLe5ES4nQCzL9rP5KjZoDfZNhyd2slrI8azYXLemsquoEsNSVeOumRc8sXtBAyjKxn83RjjtfxIGAA0uAQYHafJS0afjM0QoqKj2ViRxQfvdO19YGaoFt/iWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7003.namprd11.prod.outlook.com (2603:10b6:510:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 04:20:38 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%4]) with mapi id 15.20.6156.023; Wed, 8 Mar 2023
 04:20:38 +0000
Date:   Wed, 8 Mar 2023 12:20:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Subject: Re: [PATCH] ACPI: tools: pfrut: Check if the input of level and type
 is in the right numeric range
Message-ID: <ZAgNCCUMjP3W35qd@chenyu5-mobl1>
References: <20230307114145.8933-1-yu.c.chen@intel.com>
 <CAJZ5v0h8Z8_zb_seSfsFsgWksG6N41jFcuTycrEicJYJOG1yLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h8Z8_zb_seSfsFsgWksG6N41jFcuTycrEicJYJOG1yLQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: de2ddf9e-0f50-456f-db51-08db1f8c788b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AFFTpPUs5leM65u0zW4/Qz5mnFsFZ4wf73SF5JXNhF+DnIGwt0tNbF8z/fB+OSnC5blZGyeRLDK0KY1icKx7uLsUDvEs9dDdoIA44cofVxufuoo952N1ET9CxtPUN8rmOLq51Cz5H61hrM+Yk/hTk7AIjU63VW6I8E67lLt76ZP5u6/kRzWEb+T+kjfE+UAiIdueP203uoTpcDq4M6Ybv52h8PjKCGpk9E+G9LT5wk+XY7TmYM8dupT+GXuE5CGuQJz5cV+3KqPwB3sdDoCAlN8OEuLPFumNVO1ex2MjrqwDC8DjviTEH9mQMmz89m/mVSmvNkehTe1a10YUzUKnGbs9DFvk4Z2zGPwQeSTy2sQW/6O3t1j60dJHFZnUj4X+iWbZTTwN3YyLVWxNyp8f1tQFrpL5U3qX9BobaS+yoal9/gZ6bNziPaNeAutYYJhO0jP2nbmdgEJs8eawfK7EdcSGj8tOa3bKPd/hLu87XE2+1YM22x6DeVwXLyiNniQNVqmk3fvZb3QPaUtWV1KLYPwJc5EetqXGW/TQPcV6s5kIiEI+IOS+mfD37YLtuJypFxpZ1BVcH60W3gyAEgCq05W9gIPHywWSD/4KCyKOAOw3fgTUpp6iP6aZ7kPyJYE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199018)(4326008)(6916009)(41300700001)(66946007)(8936002)(2906002)(66476007)(38100700002)(8676002)(86362001)(66556008)(82960400001)(5660300002)(6486002)(107886003)(478600001)(6666004)(54906003)(33716001)(316002)(6512007)(83380400001)(6506007)(53546011)(186003)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdEZURMbEFDaStxQ3ptWGR2dmhNeWxUcjVnZTYzMWlhbHdKeW5tQlhjQ2hl?=
 =?utf-8?B?L1JuU3NEa2R1TDdmdTRKbHYzMjJlcThnQlFFNGhTNklidDN2R2JxWVNIeFNS?=
 =?utf-8?B?V2NFNWhaMUc5eVlIeHRFMmt0R09ObEd5V21yV3FBTEcycXJlT1VXUUNKSmhi?=
 =?utf-8?B?WUYyOHA2cUpKYlREUUN3R0lkTlBZTS9nclV6K2htWXdPbDNNM1lpZHI1VFpK?=
 =?utf-8?B?R3RMc1NHbGpQN3JYVjlzMXM2SWVOdEs0V2dVWlAyV3F2MXdEeUtqTWpNeE1x?=
 =?utf-8?B?eHlKSndPR2dMR2ZPRDVFdTlnd0ppV25ZcUkzUUZjNFhNZ2JZVk5XeVBUZU1J?=
 =?utf-8?B?KzFmVWh4cy8wNEtxVFoxbmdKYjU2cmdpWGxqM1IvQjJOZlExU0ptbGlXTU1K?=
 =?utf-8?B?SzZXcGplN1p0WWNscXBMdENTY1Q2WjU0UlhFSHFNN3RyTWV5MHU2a2xrK1NU?=
 =?utf-8?B?OTNiUnp5UHZ2UElyaUowZUc1bTZmTFoveUdGTUhRNjdhZElQcmc5cHZRZUIr?=
 =?utf-8?B?WDl3LzJmaHdZZGJpUHYvb3E3OVNkbWV1N1Juamx1L1N5T0Y0eU05UHFKcnpE?=
 =?utf-8?B?YjltWVovSmVwcDBEdE1RaFVjK1U2RzhiaVBGSEl4elNERk9UMDlSc2g1Wmw1?=
 =?utf-8?B?N1pteS9aenJDUXZxRVlXNHRBZWF5VGwwOHNhSGNBbjlFWE13Z25mTExpS2RJ?=
 =?utf-8?B?bDNCT3JtSTJmZXVQWVBPUHVjSkk0MXBHTVY1OThuemhNdmV1UmpJU2UvM0Q1?=
 =?utf-8?B?M2JEREU2MHMxMEsydWM4aTBtN0Y5U1UrZlRHY1dzeitnRnRJOUZDOEFXbG9h?=
 =?utf-8?B?UGFrZ1RiUko4eWlsdzV0d2VVcitlYVNUNHpYRzJhWDgyMXlrNk9lU2g3a1Vr?=
 =?utf-8?B?OGJUakpEV0JDanY5REpEQVpnZVpZZDVzNWFLMWhJRzNZTHFWSW5SQkhBU05P?=
 =?utf-8?B?cDc3ZCtJOUF5V2paK3dTVHFmZzQ3K1NkWHVUQ1ZVWUozdjYrN2toZm14dkc5?=
 =?utf-8?B?OEFyeUFoZFpjYnN1UDN6QzdPaEpDMk43RFJuVlROUUlEbzIvcExIbHl0dk04?=
 =?utf-8?B?Y1R5U1N6ZXB3b0hPaVlTYks5REtyM0JSaUdBd0U3anhUb1NRczgvakpvTHVl?=
 =?utf-8?B?Ynl6VzFVT3YyVkQ1UEZVR2FnR3N2NTh6OXRjNXcwK1g2UXJzRWFFTFhWMUY3?=
 =?utf-8?B?WjZpOWZ1VFEvb2FOS2w2Vm40c0g2S3psZkdRblBneVg5YkpnRG92bVRwamIv?=
 =?utf-8?B?aEMvMEROZWFrQnRBQi9GRzZNZzF5bXkvRDlkYURobW55ZnpIOWI4T3Vjd1pZ?=
 =?utf-8?B?dGVQV1h1WlovTkx3Z2diWlpaaTVmZitDTzF4QjhIK3pwNlZ0SkhGcS9rLzZk?=
 =?utf-8?B?QXBLR2ZvMGZ3U0JpUHh4TWVkbFVYR2cxejI1elhramNxWXVWd084bkdKQy8v?=
 =?utf-8?B?VTFFUW94aTdwZVhoTlBTZmNEWXU5bkVUZGNwK3pZZWl3c1JHQ2tlMTV2QmRp?=
 =?utf-8?B?OWd2WTN5aXYwdzVkdFhJbHgvV0wrZndadE9GOW9KeTAyVE1kcXViQVhMM2g0?=
 =?utf-8?B?TTh2SXpWRGw2NVAzTEQ4RCthYXdlR0RPdlR1VFdTSkt0MmxPYVZDdWppeUJT?=
 =?utf-8?B?ZVlEVkd2Q1hKc0kweFJRK2dkUW5sdDJldTQ1VCs5UWJyMlBFZWtFN0VLVGVh?=
 =?utf-8?B?Zy9LcmgzbnlXVjhuYi9MQ05rTjh2RHpSdHhtZWdxMUZHZUlIWEV6RHRXWERJ?=
 =?utf-8?B?MjFjaHNoOHZnVmRYWFpxOVUzQngvS2hkSjdNOXBWaXJxWDExdFlWUE5kRFFn?=
 =?utf-8?B?NUZoYWJGL0ZSanNEMUJ1NWVJNiswMlhxU1FWOTdMbzBERFZQa0tyQTJGVUxq?=
 =?utf-8?B?SHg5U3BmUGorRDBGeDk1UlQzdm85ZFd2eit3WHJPWDZseEJkTnZVUlNxV1Iw?=
 =?utf-8?B?cW5tZU5kUmRqWmhNNEhXTEN5MGZOZG9aelJyOUVqU0pBcHJSOEVVL3hTV3dT?=
 =?utf-8?B?OXZmcDcxbnpXRDVLVmlkSDRMWHlJV2pPWGJxQmNGZE9WSmppOHNOQUNiYVdy?=
 =?utf-8?B?MGpkOUlic1MxVkhuSzhVNHZxT2Q3YzhjT2RrYStsYktkdHFBeVhBeU1FOEZH?=
 =?utf-8?Q?WronzscZC1j+tIXu5cxvxIBWM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de2ddf9e-0f50-456f-db51-08db1f8c788b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 04:20:38.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFger9QQLeXgjD4Ffq17306JT/hcZixTKhAQDDRPGh7wezr1hyfotu8AHFQ5qyKIpaFmvQ6oEKm4oxBTFXUN9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7003
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,
thanks for the review,
On 2023-03-07 at 12:38:02 +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 7, 2023 at 4:46 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > The user can provide arbitrary non-numeic value to level and type, which
> > brings unexpected behavior:
> 
> So I guess the expected behavior would be to throw an error?
> 
Yes.
> >  pfrut -h
> > usage: pfrut [OPTIONS]
> > code injection:
> > -l, --load
> > -s, --stage
> > -a, --activate
> > -u, --update [stage and activate]
> > -q, --query
> > -d, --revid
> > update telemetry:
> > -G, --getloginfo
> > -T, --type(0:execution, 1:history)
> > -L, --level(0, 1, 2, 4)
> > -R, --read
> > -D, --revid log
> >
> >  pfrut -T A
> >  pfrut -G
> > log_level:0
> > log_type:0
> > log_revid:2
> > max_data_size:65536
> > chunk1_size:0
> > chunk2_size:1530
> > rollover_cnt:0
> > reset_cnt:17
> >
> > Fix this by restricting the input is in the expected range.
> >
> > Reported-by: Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  tools/power/acpi/tools/pfrut/pfrut.c | 33 ++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
> > index 52aa0351533c..ed672efef83b 100644
> > --- a/tools/power/acpi/tools/pfrut/pfrut.c
> > +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> > @@ -22,6 +22,7 @@
> >  #include <sys/ioctl.h>
> >  #include <sys/mman.h>
> >  #include <uuid/uuid.h>
> > +#include <ctype.h>
> >  #include PFRUT_HEADER
> >
> >  char *capsule_name;
> > @@ -77,6 +78,18 @@ static void help(void)
> >                 progname);
> >  }
> >
> > +static int is_digit_input(char *str)
> > +{
> > +       char *scan;
> > +
> > +       for (scan = str; *scan != '\0'; scan++) {
> > +               if (!isdigit(*scan))
> > +                       return 0;
> > +       }
> > +
> > +       return 1;
> > +}
> > +
> >  char *option_string = "l:sauqd:GT:L:RD:h";
> >  static struct option long_options[] = {
> >         {"load", required_argument, 0, 'l'},
> > @@ -125,11 +138,31 @@ static void parse_options(int argc, char **argv)
> >                         log_getinfo = 1;
> >                         break;
> >                 case 'T':
> > +                       if (!is_digit_input(optarg)) {
> > +                               printf("Please provide numeric value for type (0:execution, 1:history) - Exiting.\n");
> > +                               exit(1);
> > +                       }
> > +
> 
> Wouldn't using strtol() instead of atoi() work?
> 
Yes, strtol() would be simpler:
c = strtol(optarg, &endptr, 0)
if (*endptr)
	exit(1);
I'll change it in next version.

thanks,
Chenyu
