Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993767D224
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjAZQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjAZQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:52:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DABE390
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674751962; x=1706287962;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RM9k0TWH3bLi7b8KVmgM8VSyvIXjvoSVF75E0MNfVqM=;
  b=MV4XgcOSh/dqkhHr3FyDtZUq+u3ExM/Xg7YWQVPF5398axvXXON37zuX
   s8QWcZCkL7yz4GgemagQZuVsMO12Cs0+sIqv838kEdUgz/0rY9QU1YjoP
   zmBPR+C+XY/GfDdRzhOUdD0Ihe9DRXlydJLH31Efuuh3LkM5X3Tq9UeeX
   wSpYaMWRqtyxOhTw5ha800RY37lEJYpqszUHrzsXoFag/cB5vUaXAKJya
   mYMdjUff8VbWBD3UGfsMvjZaVglXwvCsCcesG0H7xog88pbIv5FJfysra
   niFdAjY+NoAHDIJbcvzhsRyVLr4HlhMEH0I5xX79w5omsT/C1EIsy280O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="328132352"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="328132352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="662936322"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="662936322"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2023 08:52:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 08:52:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 08:52:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 08:52:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKG88634T4f6/cSecdcDKO1l2pqYDNqIh2hHy+zSDgFXlvxkrGwR794hze6gVXkq/22yrJOvvIUkXeQ8P2zPnBJHsHnCv6LZP4dBU0Ij6FhvYAd3RhMUglI5rxOZOSI+GZ2ZE9+y9f2sFsXVwrJiOU9ybmJ0CaBUIJogiOJKPFUMXbUi1Xn/j6yXBBnf7RyKOlicziLVrUlAde5CWvaiFvWpuwXXkpf/2Py/eHLJvcYCEkvQnqHyda2EYdWHSsbeULDLzrXy67R8J/EXjOEdIlcpcwKMdLPNuk5rHKJICw/DfTa6gUIBCq2NbMTLMujKTauOQYiXl5qbBw/tlxxxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sa6QwMr1oc/3RHa/BIw2DWYJBv1jqxZIrwmMKWb/kFY=;
 b=oNbPULubwNIldoNGUzhmoGQ7IWmSzCT3Qp7r1cI/ic6+wFD5YWArAVJS5tSlHLZXu28isqddtzeXic1y5tf4BoptT8Nefhr9nK48G3nQ+1L/9GVstSZZpo9aqzethhZbtDc1oGv2sFWENkfNBkdjpBv4XRu+b3SimxoQFfD7sLxGKEUKEVoetpjOWRlCccTaTYr7mV5wg8FNjTPvG1EfTzBv/78pO8r4H3RiVr1rNtKhMctNXQNutxDVc9r7PU5Tewy/B/EoIrOetY5XzCF2Ausy7PJjNw6ecUzdxCpCzyGUfqrcak6qIkHXV4dKiRvRBz5PnubxV0KWLsGoOBY2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 16:52:36 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%4]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 16:52:36 +0000
Date:   Thu, 26 Jan 2023 08:52:30 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Part 2 v2[cleanup] 0/4] Some additional cleanups in microcode
Message-ID: <Y9KvzvEq5E9OYClZ@a4bf019067fa.jf.intel.com>
References: <87y1pygiyf.ffs@tglx>
 <20230121213512.251578-1-ashok.raj@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230121213512.251578-1-ashok.raj@intel.com>
X-ClientProxiedBy: MW2PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:302:1::28) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CO1PR11MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: 47db9837-d8a2-4530-8844-08daffbdba0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbS3dQ2NRgJo7waLkvjBI7pCxZCNa2yd/BqgImmbAJFJdt3qntX3/qIRibpXKGq43iwwi4Onx7vGxHbwNDAYmM2twiYeMOnopZMwVVHPKlwfDyKBgqZmxtSv24bq9SVRCZy+kYL3h3YrPYfZ7PRLIEIbCcwZY3C52HWsbLq9s0ckfCxCBlBq0SlRBPxA185Dly5mwvO1+Q79H+p+Q0O4ZdMQ8bXh9zDFEsUy6eqvLcRBrurZkt10GHzQLW0cIV3/o1BbEEBU7qgELb8S0UBJ+8CmuHQYtuVqxsVDef1BN9vZKC3YdWL3MJ1zcG8+B5aXlVnu4pZWTGhpq0xsRCtd/fdaBJF2xGF1AApQZFfUtyd6AQdtG4JAL8bvHvwFACf5E1Yb2Jw+KIQCsyx7k8Vrl9IUVf9BcuccTF9XDU3Fz97DX4C1ZCYolr4bXM1SSgIObihjrjRZ3Ffdr/9Rvrxwh/1GN0Ai7LX49n9+hgfRdWFW8+c+eZpurTRFC1OP2NAZQE8O3x5G/TYOb0OnVW17QgIWq1ytMhGrWEidsSRCpyS39YYu3K5PMZPfEF0w3i0OEmoGLSNud6XM4iL3l85iS+NzQ5XqYAvKDt7EmODMXR191idCtKk1M1sfETaUN3/zGZ+e+YByWBbYYfv4SjrJsHevuCf7kzE8qEVyh+aO4R0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199018)(6486002)(478600001)(186003)(26005)(6512007)(966005)(83380400001)(107886003)(6666004)(110136005)(54906003)(316002)(41300700001)(8676002)(38100700002)(82960400001)(6506007)(86362001)(5660300002)(4744005)(7416002)(44832011)(8936002)(4326008)(66946007)(66476007)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sKFuiuGmjfJwLu0l13Zy3GXI8bVL4TgliNk25iXqB/NjNK+JJr4o4qghCBy?=
 =?us-ascii?Q?jzwENfKZZvb7K2vn/12eU0WT4xlQCAG7v7/8OKBjMWfCbiHhdZ7B7Dz3wn6g?=
 =?us-ascii?Q?7tjBsZaXGXTY7J6TODxmQFH1vWOshnWPIl6rDIQR7EvOcPQSfDGjeYAtuMQ5?=
 =?us-ascii?Q?cCMsBKairYeAttdarCfxhvLINAXD9YKs5/M5Ko6ysLYNySdvdObEXnXisVmc?=
 =?us-ascii?Q?a/1/0AC1vnWhT+SevDVkbkfTRLRvfNS9SiwEyHJUt/swUbBq1GAHww+23kcF?=
 =?us-ascii?Q?NGwVMpcbJzuCTCW8mYJ/xTZpj6Dn/s/dFT3wUwTlf9u10uUT3lYUJgkQ1nN8?=
 =?us-ascii?Q?QGdjFAxNz/+WYPYy0jk52A+tsfKJX3aMLMumDW04DQXGJdB2tQdhJaCFsK64?=
 =?us-ascii?Q?gQaIVr890PhTF2E+jFS5taYoqrrPfmeECTmfbc6frgLCDINYuosCSDhjeCKV?=
 =?us-ascii?Q?pbp0Flg2T6IyQHawHYyZRDrRlPYmQi6BXttBofCFZKlRflIO7bfD6lu+LMiz?=
 =?us-ascii?Q?pYro2FYmHQmF7Jr1Tpxgw0JGWcUdIUTniIFvW/cDl4MOCXJw7nWtcgI4tFfM?=
 =?us-ascii?Q?yEUI1oEUSljpDFn4qD/5OquDvtsC/ltHVFalTd2J3YUF0WPPlMOOg0zm7PiX?=
 =?us-ascii?Q?VRRfL7RgtT/7ueDfM6MfirtSF+kUfUkDhc09n59XtOD3qSyUNhru5A/cxhzD?=
 =?us-ascii?Q?RD/C9BC0xSvn0apTTLDhXTKFF5GHGs3jVyjZQEWdExdn4/bbOXAQO4bx3Wuz?=
 =?us-ascii?Q?eGPt+SnkP4GuLEa6jxalIYx62ar3ORJHsZN0cOeGixiSSgBNRNxuYMyFd2Ug?=
 =?us-ascii?Q?ea/7A4MMfRXfvrL3d6tQxI0IZ/oEzJDaGTmwR0CFN6U/Tj573Oerr9jDB/D5?=
 =?us-ascii?Q?wxryu03YhrpiTIxGB4SxRXSK34+uGiVZxy/rDvTZwl4vbgM4Ibl58gCDZblH?=
 =?us-ascii?Q?Er1oud01kGhbK/ZiWFoRdFIF6PjvZy19j4dFwbpO29r+FtkyF3E5BAls+dAi?=
 =?us-ascii?Q?BY7/5mtv3bB3d12DJ2Iu/TR1htm7wwkBaSlDEZB+VXjyI32OCsZV8kD2bQ06?=
 =?us-ascii?Q?qSr/gLQEsugUHXPev5HK6lW3AA8juINB1yj/MqQvg1PghPJzuN0L87ZbPuOe?=
 =?us-ascii?Q?Rms5qwGpQ9DGCUEKUD5z/1XHGex0YGSm1WLlETSOjLWXaewPs7Dmu0ceIbO0?=
 =?us-ascii?Q?YmgkdoPlftR1tgCq8bbIANiRNJ28PGtQsbKH/rd4VnPlOSiZuHExorKHXNx7?=
 =?us-ascii?Q?GYXp6U59/NMJWl7eyiicPvYfMNJYENygM6JredErVhiljVKB3Jc5ZOXAfd1C?=
 =?us-ascii?Q?i5vZ6HQqKGwe5H98IHlCoqZO7eu3uFUGEgIAtQQzbW1X56XZPymjZnid7AsM?=
 =?us-ascii?Q?IG6kpk/pKgqY2MTtrNFwOFDh2DS6xPrGHnd+bPZTmMqjtEJxwTpLQZ0sjmzj?=
 =?us-ascii?Q?EZkiHfTCaJhfIReuxshtZyYBAjXGcrMtX14ju78c96oyoANuSIubCpYkxV8Q?=
 =?us-ascii?Q?IJiO0vLKkw/SnhvCyrTdpuk2GqBNTKRl2gQ8NjQyjD++EHIyXsxQb2fyY0rq?=
 =?us-ascii?Q?9ywNt+dH+wlbgpMUNGvd1HlyDNJ9XupQOjfr5HF+ev4OAxBedBq9g3M0HgOk?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47db9837-d8a2-4530-8844-08daffbdba0f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 16:52:36.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UN4dVAL/6uTVrl39UJ9V3+TGFfyayhzLwLcG80oIT1u2hEGYBSkyZY+2YOBSLKX7zV4lQnay9Pfs/7xB9EWEug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Jan 21, 2023 at 01:35:08PM -0800, Ashok Raj wrote:
> Hi Thomas and Boris,
> 
> This mini series is in response to Thomas's feedback here[1].
> 
> I hope this addresses all/most of your concerns you raised in this thread.
> 
> Sorry if I missed any, drop more hints and I'll fix them up.
> 
> Patch3 needs an AMD change as well. I wasn't confident looking at the
> source that was returning the patchid vs reading fromt he real MSR. I'll
> check with Boris to confirm before I submit this again.
> 
> [1] https://lore.kernel.org/lkml/87y1pygiyf.ffs@tglx/

I can send you a new series with these cleanups. If you think I left
anything out please let me know.

Boris: Do you have any feedback on this Part2 of the path series? I can
wrap those as well with these that address Thomas's feedback if possible.

Thanks,
Ashok
