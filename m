Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0803366E5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjAQS3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjAQS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:28:03 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C24521D7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673978393; x=1705514393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f1I996+5ex/uAOguC+3bD8e/O3Vsp3W+f3BcGANchW0=;
  b=PhBCSBHGjgQhTNnViFt+lqGH/VrJeOpaXKVwTr1AQMMjWC59HGb+RpsF
   rl44XjkkL9IXrLKfOXNZvBQfiWq/jVgj7hnR+0aZQJZ0KKO7wsEy4LoHn
   EikrO8M9SJSCdIKtCrCQaufWlk1nI4YZaKjnhLoHdOv3kyXDvgqk6w6XN
   l4EX8I0dGLgNpGp76CmAbB/diu3rlYhwwTQRA7Ye3Vq6rJ801jz0la2aZ
   EVJ9NeE8DRO0QRkCJZwB8EhlQLEKVflwuSVZ8G6FSXocFjjw+fEoJtlV/
   dL98izFS/Zmy6RThtrZCvt1pVneMudhoN54lfHys8xmIwUOQeWX+AxQ6x
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="387114264"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="387114264"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 09:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659464774"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="659464774"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2023 09:59:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 09:59:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 09:59:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 09:59:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDOHjunPHtDMkAMX0q0eTqjPU/E5/+FPM4jlrqMkLqjz+7qD4VIhir363rkjXcGMHjt68JNVyw+0dmoX471Bfyje7Wo+i9UK+4wRcIpQ6+Ar911GVESbuWHdqyRN0kmAm49qyj18q6ZsZE6LMQcLZtp1aAeCYzH62Y5IEZ8PeiHDBBakNQPBZfdUaCvnlsmzTlNAujpPlTPmuaaLYFB8SnKwETNv34zML9K9v1N2kfxzTxxYnxrIK+B7HnIzE9mvSDaeL/5c6FEYr+2J2fgEYqkGQy0vv3+7c0mpaJOGLClGV70Sk3lzccBm6P3sBAv4A5vQwMzfUz8I/QkQHas7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPb2sEZy1VJodgh4kRu+l6CiKO9wreX5uXg8WfuFe8k=;
 b=SQxy74WkMLGExs1YjUuk0q8Yoi0BRuobfxN6ubaAZos3Wsa8UoMba0JlNK6VOc4dMWpRxF5IM7TXrA26zczaf61fIQ+9c4GWclAOU/DJAXsgtzCj4T+cSQQZ8xz6LrdLslcTxKkTH/i4CQopGjzYnlePci7SC+19BSfpQIztO+YFabm0VfveVTeu2yNdbPCXBPWZfjq+AgkHVtsKZL1y0Tw28WjIOYyHROidFWSi+Qz5ibwecG0CpDVQE+TsXlQn4Z/rBDVTUTFoBCNlif04ew5+B4fvfJhXK5EJPrgCl6v7nPAfyurTXfEieeTC1XjKCUa3TihT7X7Wu5h8krEgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 17:59:48 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:59:48 +0000
Date:   Tue, 17 Jan 2023 09:59:44 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8biEJErijXiGeXb@a4bf019067fa.jf.intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <f7ca6ffb-d623-a22e-da5e-d0acdd3ad672@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7ca6ffb-d623-a22e-da5e-d0acdd3ad672@intel.com>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MN2PR11MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 760c7624-a944-4854-a20b-08daf8b49f3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W37SWXOzZ10brLBGZeJ03RC276aYB+SbmRAQZ24XhM0B9PE6iK5clfaeQJU+lU9chq1n+D4BgHP9vP2qb8Ekkafl6TzptU9Z/VqcRpX7MVvnCp57byklXwoeqD5HXDkNasqUaumy+XN6nYHhGeGRCTrc7ipsMn3pcukVnuRheCWv7Lo8+ygf/8xNnoRwnNxaU9CW3vYIhhMJMhVmq26vAJ1ebiEQBm3lOYTCc+2VqsPm/2MvLFj3lvbMZDI7jAb4+X36SDqPFwK0AuhXXS1PUWrFn6YuA7kZG2DjQaP+sIXGg3uVV9ZlldWmcqvafV8oeRYvUoRFYWkPkIZrzCBTJQWFNmnOitT7jMlzt+c+cFkaazGsouQ2m6hRfX8eGRr5nD32BvBY+i6fFVIRbyOb74i4M5pbUMwRsIeeO3m+VJaWKnfFBK4cw0Hrox6VJxSDjIGSzGLacb3MNzFo7KF9KH+nmAt5i5Axoz7uXo7RQ8mMKVq8bTivRdjOJM8dPVGQrQ/h5zOZ79gGywmcl6DjLmYard6o35GaRI6J4SuJ91QsDUfWX/AENvNht1giLg2KQldW48SRRhRpNicqQqJJut264cTrkeAzsm2lJ80Duy27sUapUge5gJ9KnHdQN91YCL4rjz63JR1+cnRNwyHuRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(86362001)(66946007)(8936002)(66556008)(44832011)(8676002)(6862004)(66476007)(2906002)(4326008)(83380400001)(82960400001)(5660300002)(38100700002)(6636002)(316002)(6486002)(54906003)(41300700001)(6666004)(478600001)(6512007)(107886003)(6506007)(53546011)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gio1dGY2xwYykAwZu0Uvdsed05IDNC2MJaSWK3DZi5Li34z0xDSeR11WC51c?=
 =?us-ascii?Q?ybwb+rKwxi8pVOho+hnbwBD1eZEL+fU5zf+x9RWOUpd+IvEyU/Dy94r7Wze6?=
 =?us-ascii?Q?woE1RvIseDVPJow/8Vfe8ZjTmvyLbaG50Vn02fKcrjvwdqrUodvCaPvMV0mh?=
 =?us-ascii?Q?3+BZMa+8MhDsWdRo+Bj6x7K8iHACiRp+tiijL3W5TVH23xJETPlgVGJQ6lN0?=
 =?us-ascii?Q?9O9fsUBkGz22/Z5oM9OLasA3tVVK8MK2cwM33rW8PNtsbyd7E4i+FkxVQliZ?=
 =?us-ascii?Q?PtClvKBGPRU7FjSuOa5rJkkd+lkfjpDa9SLCgqs9/gtkxYldh6QTedpNB3Te?=
 =?us-ascii?Q?N++zTr4IwIgV0SXwaAxzL+eDTbwxlqCUWZPJwEBor9bbLnM9YY3boYatA0nr?=
 =?us-ascii?Q?YOsemrj4O8MD8X1IPaR+63Qrs6mowjx74O8fcQwdGuocxYbQrix5JZIARMue?=
 =?us-ascii?Q?pC9i+4+bfMEZoGrx1hz8YA62U4RlozGZcCNMbyjMpOUYjRLzKzJ2waGl5gML?=
 =?us-ascii?Q?lrRi9Sk6TgUmyw4dCVmtuZqHxacbzKIyxMJveFAB77NI+DX4HKXQJKOD3x85?=
 =?us-ascii?Q?261vESDl+rpeZBEKUkNx0WnN499ENHz7ebdhFV8QLJkc8bvowhHHCxqdsQeO?=
 =?us-ascii?Q?IoPHPizS5KudzQkvMRy5R+3JNqMtpCBArXS4q/Y7M6t/bREmXA5qKqIzQHsL?=
 =?us-ascii?Q?1YxO2noIPdMgiTDTP1AFs5IuvdLtG7T+w6DLevbigrfFqwBEnU7X/1NFQG9t?=
 =?us-ascii?Q?3YELEc9zuJ6tcYhIsAN1ELFyTFILXiuunnBCYa7eMjw0Ap7GeFVa7uuXhlSX?=
 =?us-ascii?Q?dSyT1T50VFhMRdpRq0Ct5L/i7TihGCH7PtAknXHNzY+4SVy7qG7oyjDydWDr?=
 =?us-ascii?Q?xyNZOJXuP7gjgCXTv5Y6JjC2KC54W3T2RyQ6riGKngZyRXjiKJ7IKHxIs6Dw?=
 =?us-ascii?Q?ncLlMawXWMmUdpkDVo4wNVvKLmeY6ptZr3j+9AKmzp9S/P/t0buSSFLdum40?=
 =?us-ascii?Q?YT6hE+V5B5Q/mfeibW8v7EzQLPNAPaCa9aXtaO7EGQ2wan9nw2+1IPJGcDpX?=
 =?us-ascii?Q?CGTk5MR/N06RCepS6MeJ/RFt49JMSW8D0lsBgKggA4tOe3luKA4lhyHZMrQc?=
 =?us-ascii?Q?AC47LZ9xZcc+zesvsunyc55B7NIQ1jAsMxq53x/0Na/6IgHAsRj9Fd/hLbkw?=
 =?us-ascii?Q?3YwVsQ7XKbRfxhrCfAWfYEIg88wkx8UZ0K8tajkNhk2bxOy5y/oNqVNzsJ72?=
 =?us-ascii?Q?U/HFUhXg8U2Mp6MexYxkvKX1O5lEbuv6KrOVgzcwmAdKYffoKzX/QX6koggu?=
 =?us-ascii?Q?9ZZehwq3k5CNXeEv/X71kNwvMEPXelnD6wTuW+v6b4oGw74qi2DC9NV1rZEB?=
 =?us-ascii?Q?4TK42ZZVMDM12Beqt1P7IYMASKvlqUh4/GSUOqx7t1omk+Fh4y8CAft+5ZH3?=
 =?us-ascii?Q?sYCW0eF9reE6R2hVUY/qXgYnnZQrocYadv+WLLgT6QOF38e9CE1Patq1AO26?=
 =?us-ascii?Q?c9MyZTIwoR42RDzOELeRdJ1Pl+ZXH98JVW7vihYqejdztW9bis8e7RJcmCro?=
 =?us-ascii?Q?3z1BFc/Hm1BG1XzznBCK0xGHsqZ3E/LC4rXNmTCT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 760c7624-a944-4854-a20b-08daf8b49f3f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:59:47.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCTiFJNRfC+Vj/3OsRbv5/4PDilJtR/jiK/998dS3qObkkqzZ/ExvnlD0YKpeU1VqvThWXF90vBY3BObramWXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:35:33AM -0800, Dave Hansen wrote:
> On 1/9/23 07:35, Ashok Raj wrote:
> > -static void print_ucode(int old_rev, int new_rev, int date)
> > +static void print_ucode(bool failed, int old_rev, int new_rev, int date)
> ...
> >  	if (rev != mc->hdr.rev)
> > -		return -1;
> > +		retval = -1;
> >  
> >  	uci->cpu_sig.rev = rev;
> >  
> >  	if (early)
> > -		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
> > +		print_ucode(retval, old_rev, mc->hdr.rev, mc->hdr.date);
> >  	else
> > -		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
> > +		print_ucode_info(retval, old_rev, uci->cpu_sig.rev, mc->hdr.date);
> >  
> > -	return 0;
> > +	return retval;
> >  }
> 
> I'm generally not a _huge_ fan of having an 'int' implicitly cast to a
> bool.  The:
> 
> 	print_ucode_info(retval, ...
> 
> Line could be right or wrong based on what the retval is logically.
> This, on the other hand:
> 
> 	bool failed = false;
> 	...
> 	if (rev != mc->hdr.rev) {
> 		retval = -1;
> 		failed = true;
> 	}
> 	...
> 	print_ucode_info(failed, old_rev, uci->cpu_sig.rev, ...
> 
> *Clearly* and unambiguously matches up with:
> 
> 	static void print_ucode(bool failed, int old_rev, ...

Yes, it makes good sense.. I'll fix up next update including the commit log
that you called out. 
