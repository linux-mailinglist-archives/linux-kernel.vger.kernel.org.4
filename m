Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1958626B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 20:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiKLT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 14:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiKLT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 14:59:04 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C7E0D1;
        Sat, 12 Nov 2022 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668283143; x=1699819143;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o1qZnNhLpRAEAjYU8QJvRERTi9VuPwQg7sSgARDS9iI=;
  b=lwmeblvhC/AaX6yMbIO1d141OQzkD6wYVfD612tzT2LLUFSOA8tKctnN
   gVV77Zc8bscH4vyqKWE5tin7Gk0RWatfMY8n5bJ/28cIEEEc2DwAwqYlD
   90jceSOyiog/7IXGbzcGbiskyerD4jUJihn4SV8DksBOQFGPef7mpwabw
   vfVyJ770fnlmwC7bqItWR2ZMBIByKL7pEugcox2EiexWWZ94DiR8F7Yzm
   yTL6shA5vL3YXr82/J/3IYh1iIQomPfSRn8GMkp90ng5eXCoROcUi8q96
   we3/ElYzo+i+l5Atv3qGEjaA3lO+8YsZuRgUkyDgoOvpub//0d7vlhHG8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="373880209"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="373880209"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 11:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="812757185"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="812757185"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2022 11:59:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 11:59:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 12 Nov 2022 11:59:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 12 Nov 2022 11:59:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNDyVr+YEZ1YTQzbL8kdN8E1yDa0tO9ZdNJ7flF7jH7NF01o/Ggq+s79M9oKW2Bw6p41M+QONX2WAcmOU9wCWsrdKxW5SBeBIUI5+76Qv6bDosZUqiJeyTbQWxMN+Q34/+vh3hvAYew0uuhEvKNxGr+OBjtUXxTBcGsbwywwDeY2FsHCrCztI4RK9ujLSKYXj8Ib7wJgHfLyYLrNjN0OQWr5cUeJ4T3HG9M2Ebve8fylpQjGfnbIjppdzv4Wqkl3SZXYUf2jDjmUiQJ4NoKdIsxpLEZKnYbxY0czWJWiNJ4VF3XJapthe3APC6ulDuYs8tACvmMMpinVe3gTJqgKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L67m0FCkId0TvGJTfCu00/VUK6iBi/2sGTVHkWwrovg=;
 b=a06ZZPYaohngwmy/zRKw8GPzBN3VPqEcYTBEoRP1KXekLhCoCeRglpWT6f3Yg7cNnHiE5JDz7cCQ7sP7f55GHklKmkGFE+yJU9CkQD9bolRYAQZSXbqYT6SGY0ZTKYvKJLpql3U74QNlukFPUN41NQlBnLYfpPRSngW7xmYUt7s1ew0kx6lKyntphTsKJ9Cv+7tVF3K098qWM4UPjmEYEcivmQrudeeWgGJNJ255yoWHQoMp8/XFWlkhctpYXJ1/tpEnLDGtvbxmUVvDr7dAcQ2xEIQTWkNJIkJAkWybMTD1W6u/r76BWdqHQCKUFv/JzXFFzzy0d3XluCLBH1pX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sat, 12 Nov
 2022 19:58:58 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5813.013; Sat, 12 Nov 2022
 19:58:58 +0000
Date:   Sat, 12 Nov 2022 11:58:51 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thiago Macieira <thiago.macieira@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <athenas.jimenez.gonzalez@intel.com>,
        <sohil.mehta@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y2/6+wavSF53WgZN@a4bf019067fa.jf.intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <208647816.nNe6ejF2h0@tjmaciei-mobl5>
 <Y2/x/vdtE0ciuOhE@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2/x/vdtE0ciuOhE@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5e94d6-dc14-4db6-dba4-08dac4e8550a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjIwIBl6CqCVbU40WaIRoNPHU212m160wZdyPmkQREJ8v8dLAJKsfPZZYQ9GA4A1k94WH2sIr7yffoRmkKVd3CTXfQOsqjHySJJ0AJKGk+9XCBNZRYkB974h4dFXtjge3D6lg/5BMsarbIQDST46niW+4NWOQmuzi1R6IH/CfWY1xUM7KV3p9R8Bwtk7il9kUm8n91m2VqomzMCC3R2NmGNVF+g1fE22J5Q5bi0h59fRHBH/u9zp7MmxoYXFVNe3hbtyzKi2l344wLVK6DbBn1JwM44RZwwD+GfimXYYHYENJ9jvu+Yi3t7ytl7+5KYqyiKY92+V7KmhouTRZSo4gbkCVqc1/Y3ZBrx18lg4cNFnEGA4OtZByHyVPibK9aIIksTQbduVdRIx+HDQqtdupmbTmiBKBqzVeHW86R/j4/lAPbyxa0sl2D9qCZqZHNR7/LPVajJw/DPtljemsQtP3jz/cfl6xQPxxJHJt6EmEaEse8FtoePmDM+F0f5XqLn6tgC3GALh/mXmQ9VnVLK0qmmMcc8uFw3OhniBMa6US9tJAowLAZE4hZbOKNHWno1RZmVJt5qaZDzAOr2Wdh1cTmlRdEBJkQbBV9m5N6D7k7SGz2xsBvqT8R+cfLs28c9dkuiGACmAgPRZIww3tbEciKMj859e5jDqYOpmZqbAvWfQJJk4xSfSiW9NYhVcsozb+LM6LJ8iqPi76tAP/jw4lwV71dmLz2eQc0AFyMFg9aU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(478600001)(6486002)(66476007)(66946007)(8676002)(316002)(4326008)(966005)(54906003)(66556008)(6916009)(45080400002)(83380400001)(82960400001)(38100700002)(6506007)(6512007)(26005)(6666004)(186003)(86362001)(7416002)(8936002)(44832011)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xp1p8VKRJ5Cwojo3xC6tUXlGyEgt1aY7Jzi8hjC2o3GVck7u2+oFh+Jr8kpj?=
 =?us-ascii?Q?PLBXDtwIolu5D0ptFVJTD9gJv+0Z4LT25DqdErpxofrIH48OcCIlSYxzdUOu?=
 =?us-ascii?Q?Akjr6Vs/y9Sd+o/PERq9Oj96O0JMlhGQ/lOX0NuP7lnXk0WIrT/16a27ITp8?=
 =?us-ascii?Q?sMwqxwUHpdDLAM/3ZeKCP2nihQ01TSeaIgZvWJV2qT15oqpfP9oRZFhXaQMs?=
 =?us-ascii?Q?667IRukBN3Xcf08advZPFiiLy3kyMnyZ5k2w+ZzEJCx8agFiTH4Cy/r8zepe?=
 =?us-ascii?Q?Gbty7H6GKG8Q55tsPyM3Nurl9n+Yl5KNJJDwCagnTqyszSX0g3pQK3pZvog3?=
 =?us-ascii?Q?PdV1WnumAJpvHfPpmN9bAbLKlfQQ5Kcqr1yCVowTWDFpVpCIXHgv27gz5Uy5?=
 =?us-ascii?Q?r/G4KsPbkDwgM3+7tHw6Aot95D0wIFHEa2FgOiutMbt0++6+GCOeyc3EdiVt?=
 =?us-ascii?Q?zPdkI4dPBAn8sWVT9oNPSQUtdK2ZJ0TcUc2Af5xO+xdxXdXSv3G/BSfVbtH+?=
 =?us-ascii?Q?T0C5W93o/X0SAcqQOyJG3zPEeVjvIsbbJnbVqYlmPcbxE6sceBApKmq0MmZa?=
 =?us-ascii?Q?kCG1YA65QrlSHOUd5q5yZZ9s0cLZnh5gl/hdJGlxtDZBvRzjYCh/HbUynhGR?=
 =?us-ascii?Q?Ukq1nqy4vKw4qbgZpH4TFcGFn6xeuY5PvD9ynn69n0VAOqQij/gsJIfYPGzq?=
 =?us-ascii?Q?57/4HAIaS1HOD9FoY08X6l2GAsnfeWhlFipSqvnZk86ffquDSx1gGY1sCfwQ?=
 =?us-ascii?Q?XQxjSZtLhTiaZOthn2ve907NnPgAo9IWpG4Oc7yusyp1cKqVlfDjnRyMcAF7?=
 =?us-ascii?Q?IUmVbUsVz8NY6JNU4qYUz8MRHpuheV58jECflCb2QMUKaguO2GA7I77d1u0W?=
 =?us-ascii?Q?ewbZKLMeWpVAx2ALLrl97AZGe5fk24+bDVzLAGPv6q7v8nMtCtbKgHM5N8nB?=
 =?us-ascii?Q?2XS+M7scv0HJtNtzEXL/aFiJrRnyygKB01AiSl0m6TR4c600T6rInyCpPItj?=
 =?us-ascii?Q?yyVUvB/JPDpXOfL5/VEWgG3JSXoUIq7zyQ07Mxb8OQOljxC1Hn6QSQbUUEKA?=
 =?us-ascii?Q?eF1vmYSLOsGBn7vZ+C8w15p9pA1zsltDDedHTGeNosuL+eVE3LyfOQxKK/aW?=
 =?us-ascii?Q?12IurBKlc6Q48o7p17JqC1/snbed7Kv56Ebgw+ymgca5YLiA2iLWqS00fHqE?=
 =?us-ascii?Q?LP/Zk8cRUnuozb7U0O7MBFDamMe1HK/RNe/Sf22Y51gYPjpBVKxupZMQVoIC?=
 =?us-ascii?Q?oy7E8oQf+lcV6d+c4GFjv9ApYUoG/n+nER/aUa3cXsSWmd0VFzIMzDhoJzPF?=
 =?us-ascii?Q?6PCwwmCDz6FbY/kjmOJCVU+N0/plI3JBpDA05smj2QLewBsXgtbHu5MBYz5d?=
 =?us-ascii?Q?UpNno/x79Lx6TfpMWeM1Pj8SnDioo75uFL9nzUofTgKn/wN0e/yOT5/xfzmk?=
 =?us-ascii?Q?3HUVXa0gfJYy7HBx2Kq03AZhvyWLq7Cy6r8kwGxTcYqvOdwn5jKzSkkQQBxL?=
 =?us-ascii?Q?+AwJmiy70tBZSGjGfueKORp8GBl1F85I9fCa9pog1QqPklMlg/h5B3+KKvsd?=
 =?us-ascii?Q?VsskhlK5UNx+hBGkrr83ltl2X/uSEzTDVTb1UGrQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5e94d6-dc14-4db6-dba4-08dac4e8550a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 19:58:57.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lUIlOZv2ZY7aBqn1bsD9KmAq0fFzY9yMKjejsmVNaz9C63ZTNEGZS8U0YbnjWcndJPzLEtwWrvxx57DaBQuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 08:20:30PM +0100, Borislav Petkov wrote:
> On Sat, Nov 12, 2022 at 10:21:35AM -0800, Thiago Macieira wrote:
> > Not exactly. That's what this file is there for. It allows the algorithm to 
> > read the current batch file, add 1, then echo back. If the load succeeds, the 
> > the batch exists; if not, then the algorithm should simply go back to 0.
> 
> This sounds to me like there's a special order in which those batches
> should be executed?

There is no special sequence required. Idea is that user would like to run all
tests, so simply going through them works. User has no idea what the test
content is for each file, unless there is a case where they like to repeat
a specific batch on one core, they can simply skip and do one specific
batch, they don't need to go through in sequence.

> 
> I thought they're simply collections of test sequences which can be run
> in any order...
> 
> > First, there's the question of the ability to see into /lib/firmware. I'm not a 
> > kernel dev but I'm told that request_firmware() only operates on the root 
> > container's filesystem view. We're expecting that the application may get 
> > deployed as a container (with full privileges so it can write to /sys, sure), 
> > so it won't be able to see the host system's /lib to know what files are 
> > available. It could "guess" at the file names, based on the current processor's 
> > family/model/stepping and a natural number, but that's sub-optimal.
> 
> It is not about seeing - you simply give it the filename -
> request_firmware* does the "seeing". Either the file's there or it
> isn't.

Link to Tony's last post before changing the file formats to accomodate
Greg's feedback.

https://lore.kernel.org/lkml/SJ1PR11MB6083263E8EEBF106B6B61B24FC969@SJ1PR11MB6083.namprd11.prod.outlook.com/

Cheers,
Ashok
