Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D887F652761
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiLTTwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiLTTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:52:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B61A396;
        Tue, 20 Dec 2022 11:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671565921; x=1703101921;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tRaI2IHaSQBuY8nH/fMFoPHSJPROhhOrv1gaZ3+ciK8=;
  b=GmKrBaOvRjKdMxRp5duMG5DZPlOCPBvViV/g0gpco0m27iccrIypdq0W
   4LFuhu8Z3gOb/LhmddC1BvQRodcGCnAYSbIOFjT9SSvj/WYnaogIYLh/U
   pQjJAWPkb0z+TQb7VRBrvb26EKE2ZO12Mb3R+/a9j30hUDvUgJktOhLLQ
   HHlV8yLKN8EffaLHquma6y1tbv/LVxxFOKBJjDTnsePIh2/ycHsUPw5We
   GkTBHjmutrlX1aAQnqclUtVSgOSVUzmmlK7Twq+lhUO4IigBJDvSTaL9j
   SH2VWJkfQTuuFuSjtL/f49hNAQCi96VJFS9fiIzFxelgZ4CtMz7kPYuym
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="384050634"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="384050634"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 11:51:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="628856126"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="628856126"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2022 11:51:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 11:51:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 11:51:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 11:51:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPlcO2vaoVi2/chw4qaMASv8+u1ksVQNxUKQu2e1ODqj8KPX3aeSOp3g9J2ZMQeq84d4MOdttRn/GFYCRVhBTtW4T2jIzS48Hg4IRYC6Qqy7Pvu3Ztp0XzCsKOaeqMRHO5v4bsp6se1VuFsyTSP3I9Jz2Le0RiCjK+y+ssH/v6BeKWsi9k5YgQh8ACrIq4t0kZjKaVMAWA4qN5sURxHG1C0nlInwwMGU0u3TzdPPsMrnA5ss5/vcEpSrNjC29PawJqW+ITysveA4eHL9/E7r5o2on/c9aevC2RfWqCbDm4fMTXjDzdO6hObU9nrHBnYGbWDXobDhxjL8CocLOquUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic5RW2PMjS8g8/DfuOhW81jcA+VF1cZQO5BsULHQCDU=;
 b=VGPFYH3wnMKDS3MyY9Q52pHE1i5wY8GsdkfdXHfDp5wfY+vO4SsVErsrf39yd4wUCSJuUczK9LnUZkTTlYvlOBceWKt2C27ZULTmRAiSzFxxwPQdj/eXLNr/dxI/wha0ScNh5Kif7lslHJQW4eLgcI/Gcf6TopHomU42jeqgpiRfX5ko/JK0GLBWG7ZN89HyxuJnfDE2jKu1QvwLFIfG/dRa3MsX0++fQxebnhItm9USiTbvTruwGj+jH8OmwTS9YcmvKb+Im+dhTTSJ2OyMstZRz8S5k4l0Q7TYIdzS938gVkaEusiLhZUTkqdCiVDv/LepJ2NlP+6CQ0DuOI3z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR1101MB2121.namprd11.prod.outlook.com (2603:10b6:4:50::19)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Tue, 20 Dec 2022 19:51:45 +0000
Received: from DM5PR1101MB2121.namprd11.prod.outlook.com
 ([fe80::1583:8ae8:221e:fe00]) by DM5PR1101MB2121.namprd11.prod.outlook.com
 ([fe80::1583:8ae8:221e:fe00%11]) with mapi id 15.20.5924.016; Tue, 20 Dec
 2022 19:51:45 +0000
Date:   Tue, 20 Dec 2022 11:51:41 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <63a2124db0877_1bf229440@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
 <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
 <Y6DDPGnwszUAiNh2@bombadil.infradead.org>
 <63a1015e6ec4a_1bf22944c@dwillia2-xfh.jf.intel.com.notmuch>
 <Y6Ehi2ihIgQd/aoR@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y6Ehi2ihIgQd/aoR@bombadil.infradead.org>
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To DM5PR1101MB2121.namprd11.prod.outlook.com
 (2603:10b6:4:50::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2121:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d359cc6-5c09-40ef-6db4-08dae2c39f69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUVSVWI4qdmE3IUcLbylL55dm+qSfv8MTMh15uYAhFu/e9Ys+V/D6MphQckaI8kVwzpUfVDN370Bxj1KAnknV4BiNZ6cvIC+5bsmaKa1wmC1e4ZIWgszW5wN4bmCUTaAtfQ1jNloI5jft2GWm1TaF+ZbVlvzOf6MMIR2+fBdG7rX9KqzZQfvW77MVPgAnnM9d+8hF6piVTdki0+VkNhhxYWSj9GoAsHIkdpCd5/vVxcZBZ7AKGPPP/Miosl1UNtlBk31krwhcPCYTkG+XLBsLWJjjaD600bL37vr3wjXHQ5TrvSYGaAPQkM9dCexK8HUxWzWfkcz7xkfCVMngPvM4ZjKiqsN1svCmFEqoavxjUL/QCbKOl1AkS9ztROjuySzRRQ6nciVXhEVRQMokeiI6taPxtEAYxKZHuYRz/95kspn2tpa/xAvGfLOU0jqFpGfTh6YuxbQyXm0DOIAWO/veO/VG0TXa8M/oEE9upZC/lB2jjIVyHPTZfFLeAJFBWZ9lzUur44r4faxCfnAEkc2E8v+g4ekd0ptctF9qXv4aUg1Y8SvvRNNdeQam40ck2z2xHw6nS9cmAB8BIgz0vpYes7oHbAglhYQo/IJLesv6MvDAJPFMOFzyQfIokwn5ioNXJu5K8dkkA+xNj664AKbCfAY7q6qMxXXaCrb3rmXe7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1101MB2121.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(41300700001)(4326008)(8676002)(2906002)(38100700002)(83380400001)(8936002)(5660300002)(82960400001)(6506007)(6666004)(478600001)(6486002)(966005)(26005)(66556008)(110136005)(66946007)(66476007)(316002)(186003)(86362001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P+Z4KFEY5avuE53nC3uImOeg8u8gllKmzyWuDr2rQrCnWyqa8fO/go4dt2OZ?=
 =?us-ascii?Q?2PSJQeDTMd7HFxRQeHhCDwUs4UUnbtNb85b5NtXYFxEdcEeWFMUR22UcEjif?=
 =?us-ascii?Q?iCccNnI6IsugYjVSfWKIYVFUZ8go9q/3XtR1FFbhKCH5GWyiE1Y5iozjRhiY?=
 =?us-ascii?Q?ZwRnbvzr5DWNQhc4+i10YSZ1GY4EHE/VNNacQgpbHOplksPZ20rECXm5pCYe?=
 =?us-ascii?Q?ScquZW39XpINWuqYu5hko3zq0eMGDZcHL6IKn8fczA0SPdgLr5PU0ASuR3C3?=
 =?us-ascii?Q?DElWeIO4L/D9AV62rkbq6FYp+3TI3teQz8mhxAotqlYWNgD8q9eSdbOyY+ev?=
 =?us-ascii?Q?rDQdl58j/KfZG9UkLIDt+nKGK12ZFPqZ6NfNDwybEA1nhGTGolmRpHzSiBG3?=
 =?us-ascii?Q?D491w5+E6kIszsI2hISFqEUbDwtSjBWFAfCS4gltAw4Uu1o7djoD/ArMVZ8L?=
 =?us-ascii?Q?eK5wCEBaazt6gdggUd+5XPoEULj5Q4gacnoT07KiPXpsNMC8wSnxk7y7ehmC?=
 =?us-ascii?Q?bzrKpd0DHtMvlbXOlk2OjPFyYVTKRw6OXAx1AzN+0xwHGOI9jCO68iSdZcfE?=
 =?us-ascii?Q?71JPhEyh8D9/M9NzBLcve9AGbuKKJ1HFnn4F+3Z6TcdJ/PTCsJ6TdpPJh2dF?=
 =?us-ascii?Q?EbQ5BvIhC8au7dvk7vdLyH9nSDPs4Z40vWXSmNuYdlpNKLkvkcuVuQy0KlQs?=
 =?us-ascii?Q?H1Rt2FtMCO/q+4QNy6U/erVp1fI44Bh8M1/VBcuCr4t8lczZzLnPdEQXo/eS?=
 =?us-ascii?Q?x8PeuPhfp2j+s9V2KCuVeQ3Z+Zeby8d7TwFmlIUHTK1XRP/ftsBAcNa2cpwU?=
 =?us-ascii?Q?sEa6qe4SH7UiHo+4CyC2XpgXJhghiIUN6823aNBbWiiNFZiEQLaXRq0DXZvX?=
 =?us-ascii?Q?LwFbQhdu3RT9N27WZ+M0BULqnOH2EgDLPS91pvL8QrvsXHtJAdODZsGwyC79?=
 =?us-ascii?Q?2VAY6E+DZYxQhyVYh1h24tlGTe/Qy+mEnpxCvPYnMP8Ux2ASZCx7NcRWjM6n?=
 =?us-ascii?Q?1LCS8xqOpZBKzYee9GVUlYK7eASbNVjINgxr8Xs6TihbGHdS/mSE87OTYwk4?=
 =?us-ascii?Q?gRMkYirYVj8+VZQL8hN1VrkVMsta8sJliQdyw7CUOSyVzvANDrvIzsX3/mBg?=
 =?us-ascii?Q?VTIPVirPIvicEZiIkikkGFfjVdRkRhiNxW6QWCXIEUgVTGyKzGOnXNV+npJz?=
 =?us-ascii?Q?d/1mF66sTT8TAPDSUUGsY5iQ0H7UWGHICo93xkcxh68dHsqsrq6rTffd0X8x?=
 =?us-ascii?Q?ubFHafQh1z2BxlljCriTWm78farVD3fCdU2Y1nAdcGaK2MODwPqq4iexmvxh?=
 =?us-ascii?Q?GX4EUL+vz8GGtX0z1/AuaNQGc/RWWPBLPBx3TIP98Dy+oR3IPe0wJpQF73nv?=
 =?us-ascii?Q?BzY8D6RZpR8KvocxhYXfBYd5JnI5F8YPkZZYphkxBJUq65ORcXAM1XdOLwTz?=
 =?us-ascii?Q?6si/7hUBYbGWpWP2qsLLkDgIU2rbKLUwBxnMPvCHUty+2i4vn6aSvyyHPTET?=
 =?us-ascii?Q?KAq0WSqs5etsZAr7FbNy0Kak9qLTAeWIRqaSfM8CzNxagCh1Sdp0r8ungnuv?=
 =?us-ascii?Q?Vlk1CAfYW9lrwmIAyF6eN40pl6DJ+PoOSHnGNyxoRPG30zalP0qSDLsVNaQ/?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d359cc6-5c09-40ef-6db4-08dae2c39f69
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1101MB2121.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 19:51:44.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUCW9bQB1n8dq3uHzJu2E2UoeulcaQ/44UvXLquutI/pVl5Mqd/PcxJ1luJg0RoRRDM8HWMAbT6yZ3MULMrZ4CNlJ/dDHN4LvJWnurUi4ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> On Mon, Dec 19, 2022 at 04:27:10PM -0800, Dan Williams wrote:
> > Luis Chamberlain wrote:
> > > On Fri, Dec 16, 2022 at 08:55:19PM -0800, Dan Williams wrote:
> > > > In other words the suggestion that the current
> > > > organization ultimately leads to bit rot has not been substantiated in
> > > > practice.
> > > 
> > > On top of this patch I just added a custom debug patch to my tree which
> > > enables CXL_BUS and CXL_TEST by default when this is currently allowed
> > > and it got quite a bit of kernel build warnings. Although some of these
> > > are specific to my change, some of them do not seem to be related to
> > > that and likely could benefit from fixing:
> > > 
> > > https://gist.github.com/mcgrof/73dce72939590c6edc9413b0384ae4c2
> > > 
> > > And so although you may not see some build warnings so far, it does not
> > > negate my suggestion that having cxl_test as a proper upstream driver strategy
> > > gets you more build testing / coverage.
> > 
> > If autobuild coverage of test components is the main concern then
> > cxl_test can copy what nfit_test is doing with CONFIG_NVDIMM_TEST_BUILD.
> > No need for disruptive redesign of how this facility is integrated.
> 
> I've itemized a list of gains of having this properly integrated. What
> gains are there of this being an external module other than a few folks
> are used to it and it been done before for other subsystems?

Your crash report is a prime example of why this needs to stay an
external module. Any redefinition of what a symbol does via --wrap= is a
fragile proposition. The fact that crash signatures with cxl_test loaded
have the external module taint flag set is a feature. The --wrap= option
has no business within the main tree because it violates the valid
assumptions of other cxl_test-innocent developers.

The benefit that resonated with me during this discussion was more
compile test coverage for cxl_test components. However, that is achieved
by tools/testing/cxl/ adopting the same compile coverage scheme that
tools/testing/nvdimm/ has with CONFIG_NVDIMM_TEST_BUILD.
