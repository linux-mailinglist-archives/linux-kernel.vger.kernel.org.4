Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3570B627117
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiKMRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 12:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMRBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 12:01:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8AA227;
        Sun, 13 Nov 2022 09:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668358905; x=1699894905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HDTqFbM0KvsS4VQwYzc6u5uvsjujBT/YzStMGdE+xqs=;
  b=WGxkLXmhtpR36Q5bxKQHCaiQ24Doo36uL4VO8ijIgQXxEfMykRO9WOP3
   owjgTv+11TDhk35CscqTdx4sRRbH2DNaGIYor7xz4qCcXcPZeLtsv3Wop
   bbJKOiI/q+WYWvKyJcHI6b2OgOZB833Ey2Fxb88buytE3iz0KZ9cxM0OK
   g4232CbSGn8ZkUUiKUw/NbRzQZ4I7+Ht+lrFQTl4Z1vH4nuKWE4vAW9qD
   ZM8L9TOufnWIixfL3A7fL7oW6vD4GoVxJIJMQ9Ta2NYPv3J0IkCSVZiec
   7wwZ9RZkBGD6HENqjjRQbPFsjnbZE1dpyCxzCpLzTsaXXsWh+LFV/9X3m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="311831610"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="311831610"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 09:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="589084791"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="589084791"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 13 Nov 2022 09:01:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 09:01:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 09:01:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 09:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7uezjQnv25/LuqioXO34faQ4fyiv3c1vkrJi6hpOmJCdqIZj1d2cszZf9lMOvWU+WNO5li5f31i2ElfH3vduAOKCFDuQEyrGJosDG017JWtUWVQUA7W01cW0LBe4onwFSvUqEI/TK9obuDVu/3YI9nEiW5UYh/AuBEyMdLDY/tVxNyl/qEqnpFzKrr4yl1Bhrm92vPtyc23xttjYijxaNFkrCEerRmj+f3HInXkrs6QR84G0RX8w0hPv0Da6pg8JSq2DetZLVIWtljQibxZbqaCmtKgknmiyxqv7p3Ip32iiB137SBdXsnnLjzEuV1L6FQEElfSKRxwcq26lJHDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFjiHTuGJQNTgPNOTCWKImQLKptAlmknwObW4pO2wUU=;
 b=KutHUY9R4r29kBgf0ccjAYAik3KvJWZE+iMiUWWFXzsJR9G7+xlBWxQBnyXNDXhZYg8P3y1kug0ajv83VpTZtNmW9RFYohLNkotODf5BO+2mpyrbTHR63fS3/E3RKur0neoZr+UQfuVMh+iZMlNlrZQelsFxueQTXLM7GVBv/0j4iDfCtOzUcmDdfcFGbm9/Fp5lw8VCnj2TG6Le71pfZrYg+gRLBlJ5+4U0Ybe+66Mt9xYUQoWUuNSWT21u1ecHDpM7lH8VGj66FEaMQaUkXu3H3lMJ+kCk07TuqdjJ4aqEWZfddg6tqQm6oH5tdlv696QJxb5BkN2Z0sPEAflbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 17:01:40 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5813.013; Sun, 13 Nov 2022
 17:01:39 +0000
Date:   Sun, 13 Nov 2022 09:01:32 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y3Ei7Nc+1wGOF6fk@a4bf019067fa.jf.intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic>
 <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com>
 <Y3EUPKWDefnkeObR@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3EUPKWDefnkeObR@zn.tnic>
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: caa78c14-80a9-4b98-b453-08dac598ba7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDIkGhEpewUxMHWv4Tf2VyGtSdVfjWmmQmkOmyGwrgl35BX1+KBLZB6ZnQcUx/tq6j6PcRD1NoV/0xfsIqx0t43vYYWRuZZ5PNrNQ6PdboiR0a/BUwHNzkfl4mAc1DuHUFN68imIBkpBLZdsOi+ldkVQj+GKayz3r79aDPvPnRKD5sqHlssCFRlAcrH5l926accfkJYuI00rs7ays32+ZZXvyfqy3cXGyzQCSBme9mONGGGMx9bli6j4H3JaQsQvLauJe7DU1vkEdnkFloKxcb44O7YD5BJ1oluhZpIcBn5yIHpNNodJn5EH6dJq/2PxDFQQkdaWkleXQShwVt377Li2/Y/VCvVIikGRUh3uRQkk0Np2prywesb4zXVZgz8DRnMw8JIfOrJ/7g3QsAl3AnLMeDpPn5usXxmOqyk2JVhvY0TQ+PtQMpn/t0U88+qpdRDzdFoB35yoECnuA3O+4sygl6GAEmPmdRayHmLlbjSAt1WStUfgVKxG62wIi1eqemHhnYzlYYvCDzOS6sGNXtcX8TQZIAIiPR+0fMzX7aiR4j1+innh8MonaMDvXUKUyBCc6JAHqS8GXEx7ZR0aHyKk9TMDkmZV4n9f76+iOrGHGwD77LPklIP4YJa2h3CAtCfxcfNEQY62nFpHCTJzBRRpFuWotIgC1qmRa0YAlsVjYFHeoF4DfEPaFQKmFyqJAhHSpXpgXoGWNJaRIF9xQ8aXfKPGr0yxMw8tJEXRiwP5kUMCN1b5U3vYt6CHjWj1F3isW8pfdG8Gu92X/k6ahg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(2906002)(66946007)(66556008)(66476007)(6512007)(8676002)(4326008)(26005)(316002)(6506007)(7416002)(186003)(5660300002)(44832011)(41300700001)(8936002)(82960400001)(86362001)(38100700002)(83380400001)(6666004)(478600001)(6486002)(54906003)(6916009)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SsljLLKUREKBlIhMpITRly6yfPkQZoFhp0PXOJSJkj99ZBelINZgdX66YcSk?=
 =?us-ascii?Q?H6up1H6cAc+HGEP66q76nCkieqrZZ7mU4hjseXUcAwE6AoKhed/LwF0PK4g1?=
 =?us-ascii?Q?83t3wWBK8+0ZRDhe0oOoOMPif2dEcNk/Eg0Ytx3fe4lMsjMa6t74WUcsktGZ?=
 =?us-ascii?Q?9y8vBuDJ7YBi6hWhJVKV/B+qdFvX/+aq3bRbZmPXv1S2xCm2FYNDGDRc9Nsj?=
 =?us-ascii?Q?Kj+GpRmm2KXCgEWJq3oDO5OBejibrF7bzhVM1gpmpL84wBpxVyUV6SCaX/7T?=
 =?us-ascii?Q?Rr1slAl9R/B2NhWiH4ypLuB6jAanpc+qSIUFpJ9EMk0AtuHIW+HKDuLacXkm?=
 =?us-ascii?Q?RBe0re5iYtJjApdhBOco3YhIJVL9evDdPllj3hXspv1x8M/ffjrjW/GGaRhi?=
 =?us-ascii?Q?ybmlvn3+rRX7Jxa23NXImGvoopdka3vytgFXBmTLMgAU1rUz5Ck9Zokk6+1L?=
 =?us-ascii?Q?QTUgcacv7QOjYQshTQPyjB57KRFQc1uDz5JWaZXd3DxzJiSJXY5Zia7ZtFlB?=
 =?us-ascii?Q?htrI8iiGmyZDDpacsanysw3rq11IVSv48mqUZvGXU6+ez166y7Wg7gh2Qivy?=
 =?us-ascii?Q?Nj+fMyfDPegN1pBCgHreYMckY7/B3x9lFsXHwi5vk+AiMMkTLBHVPEbaNQ06?=
 =?us-ascii?Q?7Q3iX2HZbyfhbejA0tlmPyiS0VmAnVphGCQehKtkJrQN+YGmt/tCuCBS9OY7?=
 =?us-ascii?Q?BZvHT5mqhW2lBQ7pps7WY9dHGqkKNGHUW+Xwy2hYlU0zd/eCEKNamGvz4K4J?=
 =?us-ascii?Q?GTFiHBWO/D9yQpb4GIngT91wfFmGzNHLK0fhvLdLRlvmKMGe6IIBFF8VEdKO?=
 =?us-ascii?Q?8qrUSK41B5GZuWmT+rFxaPO98K34MuEWCVk1oeV6KGplIkRVmA808AM3RRel?=
 =?us-ascii?Q?HVL8TJ/RxUmAgVLwnQU6wigqNqbcUBoLOhEPAPmlyJmgR1wpoED3uHZGmgMU?=
 =?us-ascii?Q?P2EC7JcFNghhLcL5dWRn1F1Y923zCM7qtmIXr3qycxxhPlNcPh5sCjso15JY?=
 =?us-ascii?Q?tDbeOTBgIw/bJJw01NctaprpXqri7o5gR6yGj8xRsAi3dD3RNfyxnEq0ytbY?=
 =?us-ascii?Q?AvQ9J87eikOcxjoq88i2h9s9z7ax7Py59GmPEjxhi0hBxKhVtBSxT0un07UC?=
 =?us-ascii?Q?i7kndNcNj6KSUH+/1/20IuYzoS18kdIBSQyQ9q/PRYou8Fl0vHA/dHTM8WDD?=
 =?us-ascii?Q?KbQNAxmyG+UhLoN9UaCD40DnH9Yh7IV6igi0GoYb0Fpk9HYqkw5ODui0Dx0h?=
 =?us-ascii?Q?1xZd1CxBYozxB/7Z7+QqnyhwtzLIhBmNwJWL5GqaRHlwLVG6isdayj26kRes?=
 =?us-ascii?Q?DfVXuXSgPY3ctcGEIIHV3unGz+sFLwtqwSBIQR5hrEEkLuQdk0Ft9ueMiIhR?=
 =?us-ascii?Q?sOw7N4a4cqHBKKcoRI0yNN5QQX8aWa1kVKRpoMP4X5tHTq1X6IJIG5LmCMIO?=
 =?us-ascii?Q?evxw4TM/LyRmofKc1bDntcq69YaX4wPLhc2oWUf88Bcca5k8j9NEK+XWinLH?=
 =?us-ascii?Q?S2t0eEaRpwfADg0At2BwbSrmQPUlnBsfQNaX+3zlW1U+6srT2oxpOLC290od?=
 =?us-ascii?Q?CoF58t7w86i6R5/MDkq8TtLIRbHTjfOvkH24C0YT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caa78c14-80a9-4b98-b453-08dac598ba7b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 17:01:39.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ+4MU1MPA4gqA12NvrnPgz0YWhhapwp3YBcvX2Bb/L1MvuniUoWylt2Ll/OH2FK7QPBpImxvFlgXay2rHhC6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 04:58:52PM +0100, Borislav Petkov wrote:
> On Sun, Nov 13, 2022 at 07:15:03AM -0800, Ashok Raj wrote:
> > Do you expect the /lib/firmware/intel/ifs_0/ to contain *ONLY* files for
> > this platform? For microcode we have everything in the public release
> > included here.
> 
> Same as microcode, as I said further down in my mail:
> 
> "And, ofcourse it would check the format of that string against family,
-----------------^^ It is user space or the kernel driver?

> model, stepping and sequence number (btw this way you drop your
> limitation of 256 for the sequence number which you don't really need
> either)."
> 
> > In the above proposal, you can *ONLY* put files for this platform
> > unlike simply copying everything released and let the kernel pick the
> > right one since it does the ff-mm-ss-*.scan lookup. Only the batch
> > number is supplied from user space.
> 
> No, see above. You check the filename against the current f/m/s. Just
> like microcode.

If it's Ok to ask a question. "You" above is the kernel?

Microcode has no such functionality today right? User space 
never inputs a filename, only performs echo 1 > reload.

If a file name composed by the kernel exists, then it checks the header
validity before proceeding.

Apologize if I misunderstood you.

> 
> > Even in the current implementation, user doesn't need to know f/m/s.
> > That's something the driver selects automatically, just like what
> > microcode does for reload.
> 
> Basically what I'm saying all this time.
> 
> > Isn't it simple now? No need to check if user supplied the right f/m/s
> > since its not a user input, kernel composes that automatically.
> 
> Let's see
> 
> * try echoing a magic number into some sysfs file
> 
> vs
> 
> * simply try *all* files in a directory
> 
> Latter is even simpler because you don't have to explain anything about
> sequence numbers - the user doesn't need to know.

Ok, so can you take through how that is going to work.. 

for i in *
do
	echo $i > batch
done

If some of the files are for a different fms, kernel will check the format
and ignores the input.

So some of the files will work, some will fail, and user space doesn't
care? 

Please pardon if I misunderstood you.

> Ashok, you prove for the nth time that you don't really read my emails.
> Sorry, try again.

I absolutely read your emails Boris. But when I have a misunderstanding its
an iterative process. 

Asking a question or responding to your email doesn't mean I'm willfully
ignoring, or have a ill/malice intend. 

You are reviewing the code and I'm simply discussing what each person
means. I hope its OK to have a dialog.

Cheers,
Ashok
