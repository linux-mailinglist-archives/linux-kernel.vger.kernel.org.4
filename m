Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F41D7001B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbjELHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbjELHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:45:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19A6A67;
        Fri, 12 May 2023 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683877502; x=1715413502;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yAtJHME6UqF5oVap7Q0ko32bPiZClj8znwgfGa1IWyU=;
  b=agivekqvUHCsX6P1o5jbOL6R2ORuN3ZNTMD0cXP5goE67/Pm6jqFCzvy
   0ZyaCJg1xW9CxO78alEI6UaRdlCo38EG6HhTR9j7zQKaky9jG0nsXloOE
   1uIJS70rINNqSM6Q0QodGM2a264cIQECIxej4g0r9WPGA7YisQK++1QEB
   WqinS0ly8JZz2CChLGF1Ipl1rEtKKIvLp2VVd86+7CvXH/aSXdKno1UQV
   bvfQSceDhR/DHt/YblnIkRLvCQ2IQma+YEZ8BBlprRrMOkR9g3QFlFRaF
   XpTZj3+f3fxT97ZtXN3m1k3bmzY9xgOIuKSsohokI/HpqZNdGhbFhi69X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="352975856"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="352975856"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 00:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="946524074"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="946524074"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2023 00:44:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 00:44:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 00:44:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 00:44:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Raamv38zVQvxuHyk2rwpbrRgFl/zy0+9OWVwQpQ5s423tgDJnznxAHSY3qqe5bvm7MtTUZMgBQCsawVGWR2er3eYU2M0/5OKYVSqknkm7lF21gX8gsEVc8sbFh4hvEFhXA5Ka8lqA3J8C2fEyHlN0IiHbp7rZjlnNyUNJYJhoy575eRrxzPdPeEoZVLpuMpkmd2ZmI1j+Il7SfDKuAqK5VxcUCaBM6uNgM4O38OqY8gxHoe1Xr635UNfAB6uXznOTe7+01N/sQMV6DxBEJEHhN9E3XHkM9KsZJnPlFhZaEapc9bC8q6ZGn3l1JkwJ6WMnr7rGe0w6nsHzzG/ICpBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/9m9CK0pd5lmyol+HbEAb+m3DXUraNIexCuxxvjLAo=;
 b=XWXCoButbLXOaS7tVU4ls7VhlkhnoqPioTZnfc0jql+rcHU3g/4UuhA2gq0Ynx92f0JkbwlvgYXN6DX1xLz2TJ2bZ0PYMMgBODmx4ntQtntTpgEz0dCWBzyG4qx8cv1W0xa0tR74XXw2yOeBzq0QbOERWw8AxHNW+hb/KcGAXLEcmefhwDyUQrWAw/DiZh1n6pF7JH3oBw0789TTMQ5ek1CI9UZSh0wJXhReBRzIdLU25wXG2uDswmNAWCY/41QOcvJ6zx7adxrMEjsa4D/KF/vMjh8IG5g5xyxPM7Vfwz5NNep36IRzg83aNSvcMlL2hCccXwUM3V51LSSmxS+WDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 07:44:40 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:44:40 +0000
Date:   Fri, 12 May 2023 15:44:29 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Dave Chinner <dchinner@redhat.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [xfs]  2edf06a50f:  fsmark.files_per_sec -5.7%
 regression
Message-ID: <ZF3uXe+cjAsfCLic@xsang-OptiPlex-9020>
References: <202305090905.aff4e0e6-oliver.sang@intel.com>
 <20230509065433.GT3223426@dread.disaster.area>
 <20230509071053.GE2651828@dread.disaster.area>
Content-Type: multipart/mixed; boundary="Y/n9fmMnsBtlOYVH"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509071053.GE2651828@dread.disaster.area>
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b17578e-81f4-4f9a-562c-08db52bcbd74
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IP/AErQ/5gaXC2cxgsTKdZndD5sovtyDYZ8QgihiSSBkMylusFcXh8GmTbAM/xVVry2dXsm+s61NYQ8EXZsfWygEH1liBhi7OZDdEY7u57it0nFxVyDGxMAj9ladbxge6WES158Ff5tIX6ANBj+mKdc2798ksxroMuwYre5TxxIZ+kyJXcvUmjS5DWRVKZryfRkH2mzG5ICFqETtBOPjNvZNYPpAZ9zIlI7ickcUy2Z5KbmjTGWUh3oCh03l45pZJz9FcQAqjC0BqHESjrTE9DiD61zjnuSektSsVBf6FKR7x21H7phVc3QlltoldzUuyCvpya+VLalPqGq9TG5ete7HmL0ahkCQDLCjnku7mJcYwn08J9BW/zMV/+Wbl44uiP97Xh4rBa5NYgPlV2//E2DcVt9V1RXJFVgL8C8NafzQDO/okc7fFCQmLQA3O0XuoBMtNJQ6ScQpmpHWwPWcqvRf5iQSPx6y184K5FU69TlEqHFS/e9ioCrnN9x6YxkuKaiB9fmZ0Nc5CJb7skgQUrDI4g730ML71R12S1nHcABKhro3KVKptb5InbMmBWDm5u+jk7799i0n29iLyRm8NMcUpFkUn9VHgbD71Of0Nmc0NDRVJvWX8mJMh68IZ3l+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(66476007)(41300700001)(316002)(6506007)(4326008)(82960400001)(6916009)(66946007)(38100700002)(107886003)(83380400001)(8936002)(19627235002)(54906003)(26005)(6512007)(9686003)(5660300002)(86362001)(33716001)(8676002)(66556008)(235185007)(66574015)(6666004)(44832011)(966005)(478600001)(2906002)(30864003)(44144004)(186003)(6486002)(2700100001)(67856001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GsMyyHBX4BdS4PP5xpAjDPKA9AlCIPlutk9q2AnAOnO5PwF7YcQi/x9/3y?=
 =?iso-8859-1?Q?TbyVLIOOJi1+/wekpmPS0JC7q4BojAL2wiDUoZJiLtaIXz/DQYt782E3e/?=
 =?iso-8859-1?Q?1+Ib59hnmOElqYfQ4zkmagutDuqGl6NMBJGMrrNrr93evflpJ7cSC93Stt?=
 =?iso-8859-1?Q?bgWgMWk364lYEqi2rPMa+Ya5L9NIIhQXFVAeUZHj5nzZIUFth12xs4vtNF?=
 =?iso-8859-1?Q?GO0j5i43YVl97oaEtVgMclBYTgzzEdAI5LEJwyxWIyY59stfh4lx7ZLUpM?=
 =?iso-8859-1?Q?NCUBc8DlDtNcmOaXOVun7r8pF12ToBN8E8WsIu5Ltcg0P6pjKwHLP8dekG?=
 =?iso-8859-1?Q?ssgB+cJe1Law2CG4yO46xMaLHRQ+iCnZdmODNHj0ca7okk4aCapJr5/nxJ?=
 =?iso-8859-1?Q?30L0VisQtPwZUxl8w6b6SwORbBDw684me48mldAp37ZVkTYZs6/WKLflTe?=
 =?iso-8859-1?Q?/hGyz7hQxRz9VNek6tFNA5xXxT71tf1ElutELILB4lkEE2VRJbamFgPi1t?=
 =?iso-8859-1?Q?y8nrHJfi+5JvLgcfwS6iAhL6zw4JqC5eoDIYQ/MXpckRsS09IxR+n4zMgT?=
 =?iso-8859-1?Q?kSJtXWiui9P0EMPA7swD40V7u2pE5hI62cMWw2Pd8EX+3V3bkZllvXGwfK?=
 =?iso-8859-1?Q?LVAn9lZPqjBydd4IVX7qxEgMaa0BD+YA7D7E7CoQBWZRkZX9HesLlzC4GZ?=
 =?iso-8859-1?Q?rCMeOLMm20gx/MSG/V+Er76lvvcF21INaVC+JJEyvCaHPe9h3xnpivcJHX?=
 =?iso-8859-1?Q?41hzRDOeWNM1H69FEObAsvpqavnhhAY+R5tFuDr6qDOdm+vJ778I1fNerE?=
 =?iso-8859-1?Q?3RIuzgyuYfErhzpBFqmGLVwX969X03XOPeORs+P58L7iQHVpYpHZzaF2pT?=
 =?iso-8859-1?Q?nKP42rhZl/daxxV3CDAmK8TiVB5sfe4rOuwoLnBQnuUq1qRTY20+SU/tGm?=
 =?iso-8859-1?Q?HY6XurCM1Q3zPI8U9rf/il31zBzRYyND4W/mVP0t6mXQj10Ys9MdNmGLas?=
 =?iso-8859-1?Q?40fR1VlaWNaxCbwlT4yq9QoG3htQm2WlqZ9LE69jl9Iloa0hkeA8nsy3dv?=
 =?iso-8859-1?Q?4DoL3ZvLQ1gC9+MgLkG5ZV0uOU5S5Ok6kQcxrYaeDQCuhlO7R6+fQo0010?=
 =?iso-8859-1?Q?X4A3AEEnkNQLbuR+DcAH83E8AI2Vuir9xajzRBs0TagsIoDHEHR9KKyKZ6?=
 =?iso-8859-1?Q?zMfp9GwlrKF0W3vYoAP5TADKDPe8FKq0heC18TkoUrkwwPbA4v2WufcRwX?=
 =?iso-8859-1?Q?cTmQTI7hZIX8kFFky97817ILZS/5mZYIEnlP2uIPsxahgmLP3oUaSL1shR?=
 =?iso-8859-1?Q?ugBG5+bnYDC4dVYpNJfilr0JG5WSRs5s6obBWCgoC4JkCWxe8VRzMTm1lv?=
 =?iso-8859-1?Q?vc0eFVqEGJpfPlhGwTxgnvseqNFvqXD1qEwzlh9epz6b9Rn/4ccKDMwBiA?=
 =?iso-8859-1?Q?ycYqDtZw19ufuKM1j8uqUQiXZwiymjGU1KTn/UAo156pPORUDpv9nhKbco?=
 =?iso-8859-1?Q?gmVE1FfQ03ZglrLRhf3ZGX/wnZPfC/BVCQTfMJwmqowJXsfyi36Mo/fAKS?=
 =?iso-8859-1?Q?dNzUR7VQQzvoe1eRGNTgtNHcqT9gQG5F49xp+91JFb0ZiM8Ov0XsRNzEhH?=
 =?iso-8859-1?Q?4FWEjEvrsqAWe6lRFapkeumPxOSgPIcW2SM4nRmF/bvDfWXmiQYGUCAQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b17578e-81f4-4f9a-562c-08db52bcbd74
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 07:44:39.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZW20TVVY1Q2vCCHw9YpVBmDA2Z8x5M86YAlbtHFH6/yPL/pTDRFQx8ngkcUTBhlTrJK/C7iBaRjWAulABEHFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Y/n9fmMnsBtlOYVH
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hi, Dave Chinner,

On Tue, May 09, 2023 at 05:10:53PM +1000, Dave Chinner wrote:
> On Tue, May 09, 2023 at 04:54:33PM +1000, Dave Chinner wrote:
> > On Tue, May 09, 2023 at 10:13:19AM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed a -5.7% regression of fsmark.files_per_sec on:
> > > 
> > > 
> > > commit: 2edf06a50f5bbe664283f3c55c480fc013221d70 ("xfs: factor xfs_alloc_vextent_this_ag() for  _iterate_ags()")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > This is just a refactoring patch and doesn't change any logic.
> > Hence I'm sceptical that it actually resulted in a performance
> > regression. Indeed, the profile indicates a significant change of
> > behaviour in the allocator and I can't see how the commit above
> > would cause anything like that.
> > 
> > Was this a result of a bisect? If so, what were the original kernel
> > versions where the regression was detected?
> 
> Oh, CONFIG_XFS_DEBUG=y, which means:
> 
> static int
> xfs_alloc_ag_vextent_lastblock(
>         struct xfs_alloc_arg    *args,
>         struct xfs_alloc_cur    *acur,
>         xfs_agblock_t           *bno,
>         xfs_extlen_t            *len,
>         bool                    *allocated)
> {
>         int                     error;
>         int                     i;
> 
> #ifdef DEBUG
>         /* Randomly don't execute the first algorithm. */
>         if (get_random_u32_below(2))
>                 return 0;
> #endif
> 
> We randomly chose a near block allocation strategy to use to improve
> code coverage, not the optimal one for IO performance. Hence the CPU
> usage and allocation patterns that impact IO performance are simply
> not predictable or reproducable from run to run. So, yeah, trying to
> bisect a minor difference in performance as a result of this
> randomness will not be reliable....

Thanks a lot for guidance!

we plan to disable XFS_DEBUG (as well as XFS_WARN) in our performance tests.
want to consult with you if this is the correct thing to do?
and I guess we should still keep them in functional tests, am I right?

BTW, regarding this case, we tested again with disabling XFS_DEBUG (as well as
XFS_WARN), kconfig is attached, only diff with last time is:
-CONFIG_XFS_DEBUG=y
-CONFIG_XFS_ASSERT_FATAL=y
+# CONFIG_XFS_WARN is not set
+# CONFIG_XFS_DEBUG is not set

but we still observed similar regression:

ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   8176057 ± 15%      +4.7%    8558110        fsmark.app_overhead
     14484            -6.3%      13568        fsmark.files_per_sec

detail comparison as below [1]
not sure if we still enable some unnecessary configs?

[1]
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-11/performance/1SSD/8K/xfs/8/x86_64-2edf06a50f-CONFIG_XFS_DEBUG-CONFIG_XFS_WARN/16d/256fpd/32/debian-11.1-x86_64-20220510.cgz/fsyncBeforeClose/lkp-csl-2sp3/50G/fsmark

ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   8176057 ± 15%      +4.7%    8558110        fsmark.app_overhead
     14484            -6.3%      13568        fsmark.files_per_sec
    482.08            +6.6%     513.68        fsmark.time.elapsed_time
    482.08            +6.6%     513.68        fsmark.time.elapsed_time.max
    164.00            +0.0%     164.00        fsmark.time.file_system_inputs
 1.049e+08            +0.0%  1.049e+08        fsmark.time.file_system_outputs
      4788 ±  7%     +56.0%       7469 ± 33%  fsmark.time.involuntary_context_switches
     53790            +0.5%      54070        fsmark.time.maximum_resident_set_size
    159905           +14.9%     183789 ± 26%  fsmark.time.minor_page_faults
      4096            +0.0%       4096        fsmark.time.page_size
    197.83 ±  9%     +12.0%     221.50        fsmark.time.percent_of_cpu_this_job_got
    902.17 ± 10%     +20.3%       1084        fsmark.time.system_time
     54.12 ± 15%      +3.2%      55.88 ±  2%  fsmark.time.user_time
  32688645           +12.3%   36701748        fsmark.time.voluntary_context_switches
 4.425e+10            +6.1%  4.695e+10        cpuidle..time
 1.325e+08            +8.4%  1.436e+08        cpuidle..usage
     10.00            +0.0%      10.00        dmesg.bootstage:last
    608.05 ± 10%      +1.2%     615.25 ±  2%  dmesg.timestamp:last
    549.28            +5.8%     580.92        uptime.boot
     47988            +5.2%      50465        uptime.idle
     60.12 ±  3%      -0.2%      60.00 ±  3%  boot-time.boot
     33.41            +0.8%      33.68        boot-time.dhcp
      5184 ±  3%      -0.3%       5169 ±  3%  boot-time.idle
      1.01            +0.1%       1.01        boot-time.smp_boot
     91.45            -0.6%      90.87        iostat.cpu.idle
      4.56            +6.9%       4.88        iostat.cpu.iowait
      3.78 ± 12%      +7.3%       4.06        iostat.cpu.system
      0.21 ±  9%      -4.7%       0.20 ±  2%  iostat.cpu.user
     91.43            -0.6       90.84        mpstat.cpu.all.idle%
      4.58            +0.3        4.89        mpstat.cpu.all.iowait%
      1.35 ± 16%      +0.0        1.39        mpstat.cpu.all.irq%
      0.13 ± 14%      +0.0        0.13 ±  2%  mpstat.cpu.all.soft%
      2.31 ±  9%      +0.2        2.54        mpstat.cpu.all.sys%
      0.21 ±  8%      -0.0        0.20 ±  2%  mpstat.cpu.all.usr%
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   8570232 ±  7%     -11.2%    7606395 ± 12%  numa-numastat.node0.local_node
   8614749 ±  7%     -11.3%    7642912 ± 12%  numa-numastat.node0.numa_hit
     44588 ± 80%     -18.5%      36355 ± 74%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
   7709816 ±  7%     +13.7%    8762734 ± 10%  numa-numastat.node1.local_node
   7752272 ±  7%     +13.7%    8813548 ± 10%  numa-numastat.node1.numa_hit
     42460 ± 84%     +19.5%      50730 ± 53%  numa-numastat.node1.other_node
    482.08            +6.6%     513.68        time.elapsed_time
    482.08            +6.6%     513.68        time.elapsed_time.max
    164.00            +0.0%     164.00        time.file_system_inputs
 1.049e+08            +0.0%  1.049e+08        time.file_system_outputs
      4788 ±  7%     +56.0%       7469 ± 33%  time.involuntary_context_switches
     53790            +0.5%      54070        time.maximum_resident_set_size
    159905           +14.9%     183789 ± 26%  time.minor_page_faults
      4096            +0.0%       4096        time.page_size
    197.83 ±  9%     +12.0%     221.50        time.percent_of_cpu_this_job_got
    902.17 ± 10%     +20.3%       1084        time.system_time
     54.12 ± 15%      +3.2%      55.88 ±  2%  time.user_time
  32688645           +12.3%   36701748        time.voluntary_context_switches
     91.17            -1.3%      90.00        vmstat.cpu.id
      2.83 ± 13%      +5.9%       3.00        vmstat.cpu.sy
      0.00          -100.0%       0.00        vmstat.cpu.us
      4.00            +0.0%       4.00        vmstat.cpu.wa
      0.00          -100.0%       0.00        vmstat.io.bi
    225488            -1.2%     222787        vmstat.io.bo
      4.00            +0.0%       4.00        vmstat.memory.buff
  36031366            +0.2%   36093165        vmstat.memory.cache
  88939420            -0.1%   88822523        vmstat.memory.free
      4.00            +4.2%       4.17 ±  8%  vmstat.procs.b
      1.83 ± 20%     +45.5%       2.67 ± 17%  vmstat.procs.r
    178703            +3.1%     184315        vmstat.system.cs
    211078            -0.2%     210736        vmstat.system.in
    100.50 ±  5%      +0.3%     100.83        turbostat.Avg_MHz
      5.54 ± 11%      +0.3        5.82        turbostat.Busy%
      1863 ± 19%      -6.9%       1733        turbostat.Bzy_MHz
  13318557 ±120%     -54.0%    6126899 ±  5%  turbostat.C1
      2.77 ±140%      -1.8        0.96 ± 15%  turbostat.C1%
 1.068e+08 ± 25%     +22.3%  1.306e+08 ±  6%  turbostat.C1E
     73.30 ± 34%     +13.8       87.10 ± 13%  turbostat.C1E%
  11070416 ±117%     -47.9%    5770062 ±183%  turbostat.C6
     19.14 ±122%     -12.4        6.78 ±179%  turbostat.C6%
     93.04 ±  2%      +1.1%      94.09        turbostat.CPU%c1
      1.42 ±152%     -93.8%       0.09 ± 39%  turbostat.CPU%c6
     41.17 ±  2%      +0.0%      41.17        turbostat.CoreTmp
      0.14 ±  5%     +25.9%       0.17        turbostat.IPC
 1.024e+08            +6.3%  1.088e+08        turbostat.IRQ
   1313271 ± 59%     -17.1%    1088098        turbostat.POLL
      0.06 ± 65%      -0.0        0.04        turbostat.POLL%
      0.19 ±141%    -100.0%       0.00        turbostat.Pkg%pc2
      0.00 ±223%    -100.0%       0.00        turbostat.Pkg%pc6
     41.17 ±  2%      +0.0%      41.17        turbostat.PkgTmp
    123.16 ±  8%      -1.8%     120.91        turbostat.PkgWatt
     34.23            -0.9%      33.92        turbostat.RAMWatt
    672.00            +0.0%     672.00        turbostat.SMI
      2394            +0.0%       2394        turbostat.TSC_MHz
     16295 ±  3%      +7.1%      17447 ±  3%  meminfo.Active
     16180 ±  3%      +7.1%      17327 ±  3%  meminfo.Active(anon)
    114.67 ±  9%      +4.7%     120.00 ±  6%  meminfo.Active(file)
    933864 ±  2%      -1.8%     917134        meminfo.AnonHugePages
   1133278            -0.2%    1130832        meminfo.AnonPages
      4.00            +0.0%       4.00        meminfo.Buffers
  29171319            +0.2%   29215684        meminfo.Cached
  65841941            +0.0%   65841942        meminfo.CommitLimit
   2100335            +0.2%    2103946        meminfo.Committed_AS
 6.571e+08            -0.1%  6.568e+08        meminfo.DirectMap1G
   7300096 ±  6%      +4.8%    7649621 ± 11%  meminfo.DirectMap2M
   1126497 ± 15%      +0.0%    1126497 ± 13%  meminfo.DirectMap4k
      1.50 ± 33%    +166.7%       4.00 ± 14%  meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
  27524631            +0.1%   27565040        meminfo.Inactive
   1153255            -0.2%    1150827        meminfo.Inactive(anon)
  26371376            +0.2%   26414211        meminfo.Inactive(file)
   6938222            +0.1%    6947904        meminfo.KReclaimable
     17485            -0.2%      17456        meminfo.KernelStack
     41511 ±  2%      +0.8%      41844 ±  2%  meminfo.Mapped
 1.211e+08            -0.0%   1.21e+08        meminfo.MemAvailable
  88846138            -0.1%   88738313        meminfo.MemFree
 1.317e+08            +0.0%  1.317e+08        meminfo.MemTotal
  42837744            +0.3%   42945572        meminfo.Memused
    854.00           +11.5%     951.83        meminfo.Mlocked
      6653            -0.0%       6651        meminfo.PageTables
     52857            +0.0%      52857        meminfo.Percpu
   6938222            +0.1%    6947904        meminfo.SReclaimable
   3023422            +2.2%    3089285        meminfo.SUnreclaim
     36259 ±  3%      +4.2%      37771 ±  4%  meminfo.Shmem
   9961645            +0.8%   10037190        meminfo.Slab
   2763687            +0.0%    2763698        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    185092            -0.0%     185050        meminfo.VmallocUsed
     48.17 ± 26%     -48.8%      24.67 ± 58%  meminfo.Writeback
  44505996            +0.0%   44512572        meminfo.max_used_kB
      3429 ± 14%     +22.9%       4214 ± 13%  numa-meminfo.node0.Active
      3373 ± 14%     +24.1%       4187 ± 13%  numa-meminfo.node0.Active(anon)
     56.00 ±101%     -52.4%      26.67 ±175%  numa-meminfo.node0.Active(file)
    508198 ± 13%     -12.7%     443664 ± 14%  numa-meminfo.node0.AnonHugePages
    611605 ± 10%     -10.4%     547928 ± 14%  numa-meminfo.node0.AnonPages
   1260772 ± 10%      -8.3%    1156210 ±  8%  numa-meminfo.node0.AnonPages.max
      0.83 ± 44%    +120.0%       1.83 ± 20%  numa-meminfo.node0.Dirty
  16253358 ±  5%      -9.8%   14663400 ± 15%  numa-meminfo.node0.FilePages
  14579504 ±  9%     -11.4%   12910480 ± 12%  numa-meminfo.node0.Inactive
    616360 ± 10%     -10.1%     554067 ± 14%  numa-meminfo.node0.Inactive(anon)
  13963143 ±  9%     -11.5%   12356412 ± 12%  numa-meminfo.node0.Inactive(file)
   3685579 ±  8%     -11.3%    3267717 ± 12%  numa-meminfo.node0.KReclaimable
      8899 ±  5%      +1.0%       8984 ±  4%  numa-meminfo.node0.KernelStack
     28461 ± 32%      +1.7%      28956 ± 36%  numa-meminfo.node0.Mapped
  42160970 ±  3%      +5.6%   44508009 ±  6%  numa-meminfo.node0.MemFree
  65675508            +0.0%   65675508        numa-meminfo.node0.MemTotal
  23514536 ±  6%     -10.0%   21167497 ± 14%  numa-meminfo.node0.MemUsed
    729.83 ± 37%     +11.6%     814.33 ± 36%  numa-meminfo.node0.Mlocked
      3541 ± 16%     -16.2%       2966 ± 21%  numa-meminfo.node0.PageTables
   3685579 ±  8%     -11.3%    3267717 ± 12%  numa-meminfo.node0.SReclaimable
   1611979 ±  9%      -9.2%    1464088 ± 11%  numa-meminfo.node0.SUnreclaim
      8393 ± 22%     +26.7%      10634 ± 31%  numa-meminfo.node0.Shmem
   5297559 ±  8%     -10.7%    4731806 ± 12%  numa-meminfo.node0.Slab
   2281881 ± 40%      +0.6%    2296450 ± 41%  numa-meminfo.node0.Unevictable
     92.67 ± 34%      -9.5%      83.83 ± 26%  numa-meminfo.node0.Writeback
     12887 ±  5%      +0.5%      12945 ±  4%  numa-meminfo.node1.Active
     12829 ±  6%      +0.2%      12852 ±  4%  numa-meminfo.node1.Active(anon)
     58.67 ±100%     +59.1%      93.33 ± 47%  numa-meminfo.node1.Active(file)
    424903 ± 13%     +11.3%     472832 ± 14%  numa-meminfo.node1.AnonHugePages
    520841 ± 12%     +11.8%     582132 ± 13%  numa-meminfo.node1.AnonPages
   1132273 ±  7%      +9.2%    1236266 ±  9%  numa-meminfo.node1.AnonPages.max
      0.17 ±223%   +1100.0%       2.00        numa-meminfo.node1.Dirty
  12911198 ±  7%     +12.6%   14536604 ± 15%  numa-meminfo.node1.FilePages
  12937503 ± 10%     +13.1%   14638386 ± 10%  numa-meminfo.node1.Inactive
    536142 ± 11%     +11.2%     596059 ± 13%  numa-meminfo.node1.Inactive(anon)
  12401360 ± 10%     +13.2%   14042326 ± 10%  numa-meminfo.node1.Inactive(file)
   3250622 ±  9%     +13.1%    3676292 ± 10%  numa-meminfo.node1.KReclaimable
      8580 ±  5%      -1.3%       8469 ±  5%  numa-meminfo.node1.KernelStack
     13202 ± 77%      -1.2%      13041 ± 75%  numa-meminfo.node1.Mapped
  46697463 ±  3%      -5.2%   44253565 ±  6%  numa-meminfo.node1.MemFree
  66008375            +0.0%   66008378        numa-meminfo.node1.MemTotal
  19310910 ±  7%     +12.7%   21754812 ± 13%  numa-meminfo.node1.MemUsed
    125.50 ±223%     +10.1%     138.17 ±223%  numa-meminfo.node1.Mlocked
      3108 ± 19%     +18.5%       3682 ± 18%  numa-meminfo.node1.PageTables
   3250622 ±  9%     +13.1%    3676292 ± 10%  numa-meminfo.node1.SReclaimable
   1410450 ±  9%     +15.1%    1623451 ± 10%  numa-meminfo.node1.SUnreclaim
     27969 ±  2%      -3.7%      26921 ± 13%  numa-meminfo.node1.Shmem
   4661072 ±  9%     +13.7%    5299743 ± 10%  numa-meminfo.node1.Slab
    481806 ±192%      -3.0%     467247 ±202%  numa-meminfo.node1.Unevictable
     86.17 ± 24%     -39.5%      52.17 ± 43%  numa-meminfo.node1.Writeback
    529.00 ± 16%      -0.1%     528.50 ± 14%  proc-vmstat.direct_map_level2_splits
      3.17 ± 11%      +5.3%       3.33 ± 22%  proc-vmstat.direct_map_level3_splits
      4046 ±  3%      +5.9%       4283 ±  2%  proc-vmstat.nr_active_anon
     28.67 ±  9%      +4.7%      30.00 ±  6%  proc-vmstat.nr_active_file
    283271            -0.2%     282606        proc-vmstat.nr_anon_pages
    455.50 ±  2%      -1.9%     447.00        proc-vmstat.nr_anon_transparent_hugepages
  13107200            +0.0%   13107200        proc-vmstat.nr_dirtied
      0.00       +8.3e+101%       0.83 ± 44%  proc-vmstat.nr_dirty
   2860915            -0.1%    2859290        proc-vmstat.nr_dirty_background_threshold
   5728827            -0.1%    5725572        proc-vmstat.nr_dirty_threshold
   7291747            +0.2%    7302802        proc-vmstat.nr_file_pages
  22213523            -0.1%   22186520        proc-vmstat.nr_free_pages
    288270            -0.2%     287611        proc-vmstat.nr_inactive_anon
   6591754            +0.2%    6602477        proc-vmstat.nr_inactive_file
      0.00          -100.0%       0.00        proc-vmstat.nr_isolated_anon
     17483            -0.2%      17456        proc-vmstat.nr_kernel_stack
     10388 ±  2%      +0.8%      10470 ±  2%  proc-vmstat.nr_mapped
    213.17           +11.6%     237.83        proc-vmstat.nr_mlock
      1662            -0.0%       1662        proc-vmstat.nr_page_table_pages
      9071 ±  3%      +3.6%       9398 ±  4%  proc-vmstat.nr_shmem
   1734251            +0.1%    1736707        proc-vmstat.nr_slab_reclaimable
    755741            +2.2%     772205        proc-vmstat.nr_slab_unreclaimable
    690921            +0.0%     690924        proc-vmstat.nr_unevictable
     10.33 ± 38%     -46.8%       5.50 ± 47%  proc-vmstat.nr_writeback
  13107200            +0.0%   13107200        proc-vmstat.nr_written
      4046 ±  3%      +5.9%       4283 ±  2%  proc-vmstat.nr_zone_active_anon
     28.67 ±  9%      +4.7%      30.00 ±  6%  proc-vmstat.nr_zone_active_file
    288270            -0.2%     287611        proc-vmstat.nr_zone_inactive_anon
   6591754            +0.2%    6602477        proc-vmstat.nr_zone_inactive_file
    690921            +0.0%     690924        proc-vmstat.nr_zone_unevictable
     10.17 ± 39%     -47.5%       5.33 ± 53%  proc-vmstat.nr_zone_write_pending
     32506 ± 17%     +17.1%      38050 ± 13%  proc-vmstat.numa_hint_faults
     16094 ± 20%     +13.9%      18324 ± 40%  proc-vmstat.numa_hint_faults_local
  16368461            +0.5%   16457850        proc-vmstat.numa_hit
      5897 ±  6%     +11.0%       6547 ±  2%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  16281479            +0.5%   16370518        proc-vmstat.numa_local
     87048            +0.0%      87085        proc-vmstat.numa_other
    108881 ± 11%     +29.3%     140739 ± 12%  proc-vmstat.numa_pages_migrated
   3215676 ±  6%     +11.5%    3584341 ±  2%  proc-vmstat.numa_pte_updates
    187209 ±  2%      +7.6%     201389 ±  3%  proc-vmstat.pgactivate
  23690780            +0.6%   23832573        proc-vmstat.pgalloc_normal
   1463764            +6.8%    1562761 ±  3%  proc-vmstat.pgfault
  23621244            +0.7%   23785769        proc-vmstat.pgfree
    108881 ± 11%     +29.3%     140739 ± 12%  proc-vmstat.pgmigrate_success
     82.00            +0.0%      82.00        proc-vmstat.pgpgin
 1.094e+08            +5.2%  1.151e+08        proc-vmstat.pgpgout
     61969 ±  3%      +9.1%      67613 ±  4%  proc-vmstat.pgreuse
     74.67 ± 13%     -12.1%      65.67 ±  7%  proc-vmstat.thp_collapse_alloc
      0.17 ±223%      +0.0%       0.17 ±223%  proc-vmstat.thp_deferred_split_page
      6412            -0.7%       6369        proc-vmstat.thp_fault_alloc
    184.67 ± 11%     +32.9%     245.33 ± 12%  proc-vmstat.thp_migration_success
      0.17 ±223%    +100.0%       0.33 ±223%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    364.17            +0.4%     365.50        proc-vmstat.unevictable_pgs_culled
    607.50            +0.1%     607.83        proc-vmstat.unevictable_pgs_mlocked
      3.50 ± 14%      +9.5%       3.83 ± 17%  proc-vmstat.unevictable_pgs_munlocked
      3.50 ± 14%      +9.5%       3.83 ± 17%  proc-vmstat.unevictable_pgs_rescued
   3688704            +6.3%    3920384        proc-vmstat.unevictable_pgs_scanned
    843.17 ± 15%     +24.2%       1047 ± 13%  numa-vmstat.node0.nr_active_anon
     14.00 ±101%     -52.4%       6.67 ±175%  numa-vmstat.node0.nr_active_file
    152905 ± 10%     -10.4%     136947 ± 14%  numa-vmstat.node0.nr_anon_pages
    247.50 ± 13%     -12.8%     215.83 ± 14%  numa-vmstat.node0.nr_anon_transparent_hugepages
   7032437 ±  8%     -13.5%    6085836 ± 14%  numa-vmstat.node0.nr_dirtied
      0.00          -100.0%       0.00        numa-vmstat.node0.nr_dirty
   4062724 ±  5%      -9.8%    3665049 ± 15%  numa-vmstat.node0.nr_file_pages
  10541235 ±  3%      +5.6%   11128287 ±  6%  numa-vmstat.node0.nr_free_pages
    154095 ± 10%     -10.1%     138489 ± 14%  numa-vmstat.node0.nr_inactive_anon
   3490169 ±  9%     -11.5%    3088299 ± 12%  numa-vmstat.node0.nr_inactive_file
      0.17 ±223%    -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
      8900 ±  5%      +0.9%       8984 ±  4%  numa-vmstat.node0.nr_kernel_stack
      7117 ± 32%      +1.8%       7244 ± 36%  numa-vmstat.node0.nr_mapped
    182.17 ± 38%     +11.6%     203.33 ± 37%  numa-vmstat.node0.nr_mlock
    885.00 ± 16%     -16.3%     741.17 ± 21%  numa-vmstat.node0.nr_page_table_pages
      2099 ± 22%     +26.8%       2660 ± 32%  numa-vmstat.node0.nr_shmem
    921217 ±  8%     -11.3%     816697 ± 12%  numa-vmstat.node0.nr_slab_reclaimable
    402922 ±  9%      -9.2%     365912 ± 11%  numa-vmstat.node0.nr_slab_unreclaimable
    570470 ± 40%      +0.6%     574112 ± 41%  numa-vmstat.node0.nr_unevictable
     20.67 ± 30%      +8.9%      22.50 ± 12%  numa-vmstat.node0.nr_writeback
   7032437 ±  8%     -13.5%    6085836 ± 14%  numa-vmstat.node0.nr_written
    843.17 ± 15%     +24.2%       1047 ± 13%  numa-vmstat.node0.nr_zone_active_anon
     14.00 ±101%     -52.4%       6.67 ±175%  numa-vmstat.node0.nr_zone_active_file
    154095 ± 10%     -10.1%     138489 ± 14%  numa-vmstat.node0.nr_zone_inactive_anon
   3490169 ±  9%     -11.5%    3088299 ± 12%  numa-vmstat.node0.nr_zone_inactive_file
    570470 ± 40%      +0.6%     574112 ± 41%  numa-vmstat.node0.nr_zone_unevictable
     20.83 ± 29%      +7.2%      22.33 ± 13%  numa-vmstat.node0.nr_zone_write_pending
   8614901 ±  7%     -11.3%    7642926 ± 12%  numa-vmstat.node0.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
   8570374 ±  7%     -11.2%    7606409 ± 12%  numa-vmstat.node0.numa_local
     44588 ± 80%     -18.5%      36355 ± 74%  numa-vmstat.node0.numa_other
      3209 ±  6%      +0.1%       3214 ±  4%  numa-vmstat.node1.nr_active_anon
     14.67 ±100%     +59.1%      23.33 ± 47%  numa-vmstat.node1.nr_active_file
    130189 ± 12%     +11.8%     145506 ± 13%  numa-vmstat.node1.nr_anon_pages
    207.00 ± 13%     +11.4%     230.50 ± 14%  numa-vmstat.node1.nr_anon_transparent_hugepages
   6074762 ±  9%     +15.6%    7021363 ± 12%  numa-vmstat.node1.nr_dirtied
      0.00          -100.0%       0.00        numa-vmstat.node1.nr_dirty
   3227189 ±  7%     +12.6%    3633215 ± 15%  numa-vmstat.node1.nr_file_pages
  11675460 ±  3%      -5.2%   11064889 ±  6%  numa-vmstat.node1.nr_free_pages
    134022 ± 11%     +11.2%     148997 ± 13%  numa-vmstat.node1.nr_inactive_anon
   3099719 ± 10%     +13.2%    3509635 ± 10%  numa-vmstat.node1.nr_inactive_file
      8583 ±  5%      -1.3%       8469 ±  5%  numa-vmstat.node1.nr_kernel_stack
      3312 ± 76%      -1.2%       3273 ± 74%  numa-vmstat.node1.nr_mapped
     31.33 ±223%     +10.6%      34.67 ±223%  numa-vmstat.node1.nr_mlock
    776.83 ± 19%     +18.4%     919.83 ± 18%  numa-vmstat.node1.nr_page_table_pages
      7002 ±  2%      -3.8%       6740 ± 13%  numa-vmstat.node1.nr_shmem
    812484 ±  9%     +13.1%     918801 ± 10%  numa-vmstat.node1.nr_slab_reclaimable
    352545 ±  9%     +15.1%     405734 ± 10%  numa-vmstat.node1.nr_slab_unreclaimable
    120451 ±192%      -3.0%     116811 ±202%  numa-vmstat.node1.nr_unevictable
     16.67 ± 18%     -29.0%      11.83 ± 57%  numa-vmstat.node1.nr_writeback
   6074762 ±  9%     +15.6%    7021363 ± 12%  numa-vmstat.node1.nr_written
      3209 ±  6%      +0.1%       3214 ±  4%  numa-vmstat.node1.nr_zone_active_anon
     14.67 ±100%     +59.1%      23.33 ± 47%  numa-vmstat.node1.nr_zone_active_file
    134022 ± 11%     +11.2%     148996 ± 13%  numa-vmstat.node1.nr_zone_inactive_anon
   3099719 ± 10%     +13.2%    3509635 ± 10%  numa-vmstat.node1.nr_zone_inactive_file
    120451 ±192%      -3.0%     116811 ±202%  numa-vmstat.node1.nr_zone_unevictable
     16.67 ± 18%     -28.0%      12.00 ± 55%  numa-vmstat.node1.nr_zone_write_pending
   7752385 ±  7%     +13.7%    8813351 ± 10%  numa-vmstat.node1.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
   7709929 ±  7%     +13.7%    8762537 ± 10%  numa-vmstat.node1.numa_local
     42460 ± 84%     +19.5%      50730 ± 53%  numa-vmstat.node1.numa_other
     16.89 ± 23%     -35.2%      10.94        perf-stat.i.MPKI
 8.488e+08           +22.8%  1.043e+09        perf-stat.i.branch-instructions
      1.90 ± 19%      -0.6        1.34        perf-stat.i.branch-miss-rate%
  17055381 ± 16%     -11.0%   15176777        perf-stat.i.branch-misses
     19.79 ± 15%      +2.4       22.16 ±  2%  perf-stat.i.cache-miss-rate%
  12682047 ±  2%      -1.4%   12509329 ±  2%  perf-stat.i.cache-misses
  69981715 ± 21%     -14.9%   59520868 ±  2%  perf-stat.i.cache-references
    179965            +3.1%     185547        perf-stat.i.context-switches
      2.22 ±  4%     -22.7%       1.72        perf-stat.i.cpi
     96009            -0.0%      96001        perf-stat.i.cpu-clock
 9.339e+09 ±  5%      +0.1%   9.35e+09        perf-stat.i.cpu-cycles
    137.66 ±  3%      +5.9%     145.72 ±  5%  perf-stat.i.cpu-migrations
    765.10 ±  3%      +2.2%     781.69 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.12 ± 25%      -0.0        0.08 ±  9%  perf-stat.i.dTLB-load-miss-rate%
   1342146 ± 24%     -13.8%    1156830 ±  9%  perf-stat.i.dTLB-load-misses
 1.179e+09           +32.2%  1.558e+09        perf-stat.i.dTLB-loads
      0.02 ± 27%      -0.0        0.01 ± 10%  perf-stat.i.dTLB-store-miss-rate%
    127241 ± 26%     -10.6%     113722 ± 10%  perf-stat.i.dTLB-store-misses
 6.124e+08           +35.6%  8.305e+08        perf-stat.i.dTLB-stores
     29.20 ±  2%      -1.4       27.83        perf-stat.i.iTLB-load-miss-rate%
   2760483 ±  2%      -0.1%    2757788        perf-stat.i.iTLB-load-misses
   6740620            +6.8%    7196964        perf-stat.i.iTLB-loads
 4.364e+09           +27.3%  5.553e+09        perf-stat.i.instructions
      1675 ±  2%     +24.7%       2089        perf-stat.i.instructions-per-iTLB-miss
      0.46 ±  4%     +27.5%       0.59        perf-stat.i.ipc
      0.14 ± 36%     -27.7%       0.10 ± 44%  perf-stat.i.major-faults
      0.10 ±  5%      +0.1%       0.10        perf-stat.i.metric.GHz
    696.40 ± 30%      +8.7%     757.02        perf-stat.i.metric.K/sec
     27.67           +29.2%      35.75        perf-stat.i.metric.M/sec
      2639            +1.0%       2665 ±  3%  perf-stat.i.minor-faults
     87.04            +0.3       87.35        perf-stat.i.node-load-miss-rate%
   3509882 ±  3%      -0.6%    3487922 ±  3%  perf-stat.i.node-load-misses
    623292 ±  2%      -4.8%     593074 ±  4%  perf-stat.i.node-loads
     73.20            +1.9       75.09        perf-stat.i.node-store-miss-rate%
   1881398 ±  3%      -2.1%    1841853 ±  3%  perf-stat.i.node-store-misses
    703862           -11.7%     621333 ±  4%  perf-stat.i.node-stores
      2640            +1.0%       2665 ±  3%  perf-stat.i.page-faults
     96009            -0.0%      96001        perf-stat.i.task-clock
     16.04 ± 21%     -33.2%      10.72        perf-stat.overall.MPKI
      2.01 ± 16%      -0.6        1.46        perf-stat.overall.branch-miss-rate%
     18.74 ± 15%      +2.3       21.03 ±  2%  perf-stat.overall.cache-miss-rate%
      2.14 ±  4%     -21.3%       1.68        perf-stat.overall.cpi
    736.02 ±  3%      +1.6%     747.51        perf-stat.overall.cycles-between-cache-misses
      0.11 ± 25%      -0.0        0.07 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.02 ± 26%      -0.0        0.01 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
     29.06 ±  2%      -1.4       27.70        perf-stat.overall.iTLB-load-miss-rate%
      1582 ±  2%     +27.3%       2014        perf-stat.overall.instructions-per-iTLB-miss
      0.47 ±  4%     +26.8%       0.59        perf-stat.overall.ipc
     84.90            +0.6       85.45        perf-stat.overall.node-load-miss-rate%
     72.76            +2.0       74.75        perf-stat.overall.node-store-miss-rate%
 8.471e+08           +22.9%  1.041e+09        perf-stat.ps.branch-instructions
  17022588 ± 16%     -11.0%   15150727        perf-stat.ps.branch-misses
  12655694 ±  2%      -1.3%   12487159 ±  2%  perf-stat.ps.cache-misses
  69826950 ± 21%     -14.9%   59408840 ±  2%  perf-stat.ps.cache-references
    179546            +3.1%     185166        perf-stat.ps.context-switches
     95793            +0.0%      95813        perf-stat.ps.cpu-clock
 9.319e+09 ±  5%      +0.1%  9.332e+09        perf-stat.ps.cpu-cycles
    137.38 ±  3%      +5.9%     145.46 ±  5%  perf-stat.ps.cpu-migrations
   1339043 ± 24%     -13.8%    1154794 ±  9%  perf-stat.ps.dTLB-load-misses
 1.176e+09           +32.2%  1.555e+09        perf-stat.ps.dTLB-loads
    126964 ± 26%     -10.6%     113513 ± 10%  perf-stat.ps.dTLB-store-misses
 6.111e+08           +35.6%  8.289e+08        perf-stat.ps.dTLB-stores
   2754174 ±  2%      -0.1%    2752232        perf-stat.ps.iTLB-load-misses
   6725013            +6.8%    7182318        perf-stat.ps.iTLB-loads
 4.355e+09           +27.3%  5.543e+09        perf-stat.ps.instructions
      0.14 ± 36%     -27.7%       0.10 ± 44%  perf-stat.ps.major-faults
      2636            +0.9%       2661 ±  3%  perf-stat.ps.minor-faults
   3502327 ±  3%      -0.6%    3481483 ±  3%  perf-stat.ps.node-load-misses
    622410 ±  2%      -4.8%     592386 ±  4%  perf-stat.ps.node-loads
   1877163 ±  3%      -2.1%    1838328 ±  3%  perf-stat.ps.node-store-misses
    702432           -11.7%     620245 ±  4%  perf-stat.ps.node-stores
      2636            +0.9%       2661 ±  3%  perf-stat.ps.page-faults
     95793            +0.0%      95813        perf-stat.ps.task-clock
 2.102e+12           +35.6%  2.849e+12        perf-stat.total.instructions
    232.25 ± 98%     -54.2%     106.42 ± 81%  sched_debug.cfs_rq:/.MIN_vruntime.avg
     11623 ± 84%     -35.8%       7462 ± 56%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
      1539 ± 87%     -45.2%     843.05 ± 62%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.06 ± 19%      +0.4%       0.06 ±  9%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.08 ±  5%      -2.1%       1.06 ±  8%  sched_debug.cfs_rq:/.h_nr_running.max
      0.23 ±  9%      -0.5%       0.23 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
    147300 ± 69%     -64.7%      51944 ± 93%  sched_debug.cfs_rq:/.load.avg
   9345951 ± 75%     -58.8%    3849138 ±122%  sched_debug.cfs_rq:/.load.max
   1126104 ± 71%     -63.0%     416308 ±114%  sched_debug.cfs_rq:/.load.stddev
     77.40 ± 13%      -3.1%      74.96 ±  9%  sched_debug.cfs_rq:/.load_avg.avg
    875.18 ± 11%      +1.2%     885.81 ± 10%  sched_debug.cfs_rq:/.load_avg.max
    172.61 ± 14%      -5.7%     162.83 ±  8%  sched_debug.cfs_rq:/.load_avg.stddev
    232.25 ± 98%     -54.2%     106.42 ± 81%  sched_debug.cfs_rq:/.max_vruntime.avg
     11623 ± 84%     -35.8%       7462 ± 56%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
      1539 ± 87%     -45.2%     843.05 ± 62%  sched_debug.cfs_rq:/.max_vruntime.stddev
     51805 ± 17%      +1.5%      52590 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
     92816 ± 15%      +9.7%     101859 ± 15%  sched_debug.cfs_rq:/.min_vruntime.max
     30832 ± 26%     -15.8%      25952 ± 12%  sched_debug.cfs_rq:/.min_vruntime.min
     12208 ±  5%     +19.2%      14550 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.06 ± 19%      +0.4%       0.06 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
      1.08 ±  5%      -2.1%       1.06 ±  8%  sched_debug.cfs_rq:/.nr_running.max
      0.23 ±  9%      -0.4%       0.23 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
      8.03 ± 26%     +19.0%       9.56 ± 34%  sched_debug.cfs_rq:/.removed.load_avg.avg
    246.46 ±  5%     -20.2%     196.74 ± 64%  sched_debug.cfs_rq:/.removed.load_avg.max
     40.83 ± 10%      -1.9%      40.04 ± 44%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      3.37 ± 26%     +23.3%       4.16 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    124.54 ±  5%     -21.1%      98.32 ± 61%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     18.37 ± 11%      -0.5%      18.28 ± 41%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      3.37 ± 26%     +23.3%       4.16 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.avg
    124.54 ±  5%     -21.1%      98.32 ± 61%  sched_debug.cfs_rq:/.removed.util_avg.max
     18.37 ± 11%      -0.5%      18.28 ± 41%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     61.22 ±  6%      -3.1%      59.32 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
    705.72 ± 12%      -4.5%     674.01 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
    110.12 ± 17%      -7.3%     102.05 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
     -6685           +57.2%     -10508        sched_debug.cfs_rq:/.spread0.avg
     34326 ± 21%     +12.9%      38762 ± 40%  sched_debug.cfs_rq:/.spread0.max
    -27658           +34.3%     -37151        sched_debug.cfs_rq:/.spread0.min
     12208 ±  5%     +19.2%      14552 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
     60.09 ±  4%      -1.5%      59.18 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    666.17 ±  7%      +0.4%     668.93 ±  9%  sched_debug.cfs_rq:/.util_avg.max
    105.30 ± 12%      -3.5%     101.59 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
      7.34 ± 56%     -20.9%       5.81 ± 14%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    219.47 ± 25%     -14.1%     188.59 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.max
     32.57 ± 36%     -18.6%      26.53 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    777337 ±  3%      -4.5%     742049        sched_debug.cpu.avg_idle.avg
   1059023 ±  3%      -0.5%    1053731        sched_debug.cpu.avg_idle.max
     97795 ± 36%     -17.7%      80512 ± 12%  sched_debug.cpu.avg_idle.min
    252849 ±  7%     +14.2%     288829 ±  5%  sched_debug.cpu.avg_idle.stddev
    286042 ±  4%      +3.5%     296148 ±  4%  sched_debug.cpu.clock.avg
    286045 ±  4%      +3.5%     296152 ±  4%  sched_debug.cpu.clock.max
    286037 ±  4%      +3.5%     296144 ±  4%  sched_debug.cpu.clock.min
      2.32 ±  2%      +2.5%       2.37 ±  3%  sched_debug.cpu.clock.stddev
    282473 ±  4%      +3.5%     292332 ±  4%  sched_debug.cpu.clock_task.avg
    283053 ±  4%      +3.5%     292917 ±  4%  sched_debug.cpu.clock_task.max
    267328 ±  5%      +3.7%     277163 ±  5%  sched_debug.cpu.clock_task.min
      1584            -0.1%       1583        sched_debug.cpu.clock_task.stddev
    340.71 ± 17%     +20.2%     409.64 ± 12%  sched_debug.cpu.curr->pid.avg
     10482 ±  3%      +4.0%      10903 ±  3%  sched_debug.cpu.curr->pid.max
      1690 ± 11%     +10.4%       1866 ±  8%  sched_debug.cpu.curr->pid.stddev
    501554            -0.0%     501333        sched_debug.cpu.max_idle_balance_cost.avg
    537336 ±  2%      -1.0%     531909        sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
      5864 ± 48%     -11.0%       5221 ± 30%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 23%      -9.6%       0.00 ± 21%  sched_debug.cpu.next_balance.stddev
      0.05 ± 14%     +13.1%       0.05 ±  9%  sched_debug.cpu.nr_running.avg
      1.10 ±  7%      -3.8%       1.06 ±  8%  sched_debug.cpu.nr_running.max
      0.20 ± 11%      +5.3%       0.21 ±  6%  sched_debug.cpu.nr_running.stddev
    433539 ±  5%      +7.9%     467704 ±  5%  sched_debug.cpu.nr_switches.avg
    762394 ±  7%     +13.1%     862282 ±  7%  sched_debug.cpu.nr_switches.max
     89087 ± 38%      +8.4%      96553 ± 62%  sched_debug.cpu.nr_switches.min
    172936 ±  9%     +11.6%     192989 ± 11%  sched_debug.cpu.nr_switches.stddev
 2.107e+09 ±  4%      -2.7%  2.051e+09 ±  8%  sched_debug.cpu.nr_uninterruptible.avg
 4.295e+09            +0.0%  4.295e+09        sched_debug.cpu.nr_uninterruptible.max
 2.141e+09            -0.4%  2.134e+09        sched_debug.cpu.nr_uninterruptible.stddev
    286038 ±  4%      +3.5%     296145 ±  4%  sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
    285431 ±  5%      +3.5%     295538 ±  4%  sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
    286733 ±  4%      +3.5%     296839 ±  4%  sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
  58611259            +0.0%   58611259        sched_debug.sysctl_sched.sysctl_sched_features
      0.75            +0.0%       0.75        sched_debug.sysctl_sched.sysctl_sched_idle_min_granularity
     24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
    200518            -0.2%     200215        slabinfo.Acpi-Operand.active_objs
      3585            -0.2%       3578        slabinfo.Acpi-Operand.active_slabs
    200769            -0.2%     200411        slabinfo.Acpi-Operand.num_objs
      3585            -0.2%       3578        slabinfo.Acpi-Operand.num_slabs
      2680 ±  8%      +3.4%       2771 ±  7%  slabinfo.Acpi-Parse.active_objs
     36.17 ±  8%      +4.6%      37.83 ±  7%  slabinfo.Acpi-Parse.active_slabs
      2680 ±  8%      +3.4%       2771 ±  7%  slabinfo.Acpi-Parse.num_objs
     36.17 ±  8%      +4.6%      37.83 ±  7%  slabinfo.Acpi-Parse.num_slabs
      1899 ±  6%      +3.2%       1961 ±  7%  slabinfo.Acpi-State.active_objs
     37.00 ±  6%      +3.2%      38.17 ±  8%  slabinfo.Acpi-State.active_slabs
      1899 ±  6%      +3.2%       1961 ±  7%  slabinfo.Acpi-State.num_objs
     37.00 ±  6%      +3.2%      38.17 ±  8%  slabinfo.Acpi-State.num_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.active_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.num_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.active_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.num_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.active_objs
      6.00            +0.0%       6.00        slabinfo.RAW.active_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.num_objs
      6.00            +0.0%       6.00        slabinfo.RAW.num_slabs
    147.33 ±  8%      -2.9%     143.00 ±  9%  slabinfo.RAWv6.active_objs
      5.67 ±  8%      -2.9%       5.50 ±  9%  slabinfo.RAWv6.active_slabs
    147.33 ±  8%      -2.9%     143.00 ±  9%  slabinfo.RAWv6.num_objs
      5.67 ±  8%      -2.9%       5.50 ±  9%  slabinfo.RAWv6.num_slabs
     53.67 ±  9%      +4.3%      56.00        slabinfo.TCP.active_objs
      3.83 ±  9%      +4.3%       4.00        slabinfo.TCP.active_slabs
     53.67 ±  9%      +4.3%      56.00        slabinfo.TCP.num_objs
      3.83 ±  9%      +4.3%       4.00        slabinfo.TCP.num_slabs
     36.83 ± 13%      +5.9%      39.00        slabinfo.TCPv6.active_objs
      2.83 ± 13%      +5.9%       3.00        slabinfo.TCPv6.active_slabs
     36.83 ± 13%      +5.9%      39.00        slabinfo.TCPv6.num_objs
      2.83 ± 13%      +5.9%       3.00        slabinfo.TCPv6.num_slabs
    112.00 ± 10%      +7.1%     120.00        slabinfo.UDPv6.active_objs
      4.67 ± 10%      +7.1%       5.00        slabinfo.UDPv6.active_slabs
    112.00 ± 10%      +7.1%     120.00        slabinfo.UDPv6.num_objs
      4.67 ± 10%      +7.1%       5.00        slabinfo.UDPv6.num_slabs
      1838 ± 10%      -0.2%       1835 ± 10%  slabinfo.UNIX.active_objs
     60.67 ± 11%      +0.3%      60.83 ± 10%  slabinfo.UNIX.active_slabs
      1838 ± 10%      -0.2%       1835 ± 10%  slabinfo.UNIX.num_objs
     60.67 ± 11%      +0.3%      60.83 ± 10%  slabinfo.UNIX.num_slabs
     17427 ±  2%      -2.4%      17008 ±  2%  slabinfo.anon_vma.active_objs
    450.00 ±  3%      -2.3%     439.50 ±  2%  slabinfo.anon_vma.active_slabs
     17568 ±  3%      -2.4%      17151 ±  2%  slabinfo.anon_vma.num_objs
    450.00 ±  3%      -2.3%     439.50 ±  2%  slabinfo.anon_vma.num_slabs
     21718 ±  2%      -2.2%      21244 ±  2%  slabinfo.anon_vma_chain.active_objs
    344.17 ±  2%      -2.6%     335.17 ±  2%  slabinfo.anon_vma_chain.active_slabs
     22042 ±  2%      -2.5%      21483 ±  2%  slabinfo.anon_vma_chain.num_objs
    344.17 ±  2%      -2.6%     335.17 ±  2%  slabinfo.anon_vma_chain.num_slabs
    213.33 ± 16%     -15.6%     180.00 ± 16%  slabinfo.bdev_cache.active_objs
     10.67 ± 16%     -15.6%       9.00 ± 16%  slabinfo.bdev_cache.active_slabs
    213.33 ± 16%     -15.6%     180.00 ± 16%  slabinfo.bdev_cache.num_objs
     10.67 ± 16%     -15.6%       9.00 ± 16%  slabinfo.bdev_cache.num_slabs
      3323            +0.2%       3330        slabinfo.bfq_io_cq.active_objs
     94.50            +0.2%      94.67        slabinfo.bfq_io_cq.active_slabs
      3323            +0.2%       3330        slabinfo.bfq_io_cq.num_objs
     94.50            +0.2%      94.67        slabinfo.bfq_io_cq.num_slabs
      3684 ±  6%      -5.7%       3473 ±  4%  slabinfo.bio-120.active_objs
    114.83 ±  6%      -6.0%     108.00 ±  4%  slabinfo.bio-120.active_slabs
      3687 ±  6%      -5.8%       3473 ±  4%  slabinfo.bio-120.num_objs
    114.83 ±  6%      -6.0%     108.00 ±  4%  slabinfo.bio-120.num_slabs
      6294 ±  5%      -4.2%       6027 ±  9%  slabinfo.bio-184.active_objs
    155.00 ±  5%      -4.5%     148.00 ±  9%  slabinfo.bio-184.active_slabs
      6519 ±  5%      -4.3%       6241 ±  9%  slabinfo.bio-184.num_objs
    155.00 ±  5%      -4.5%     148.00 ±  9%  slabinfo.bio-184.num_slabs
     32.00            +0.0%      32.00        slabinfo.bio-216.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-216.active_slabs
     32.00            +0.0%      32.00        slabinfo.bio-216.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-216.num_slabs
      3053            +0.4%       3065        slabinfo.bio-248.active_objs
     94.83            +0.9%      95.67        slabinfo.bio-248.active_slabs
      3053            +0.4%       3065        slabinfo.bio-248.num_objs
     94.83            +0.9%      95.67        slabinfo.bio-248.num_slabs
    126.00 ± 19%      -5.6%     119.00 ± 24%  slabinfo.bio-344.active_objs
      3.00 ± 19%      -5.6%       2.83 ± 24%  slabinfo.bio-344.active_slabs
    126.00 ± 19%      -5.6%     119.00 ± 24%  slabinfo.bio-344.num_objs
      3.00 ± 19%      -5.6%       2.83 ± 24%  slabinfo.bio-344.num_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.active_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.active_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.num_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.num_slabs
    125.33 ± 34%     -12.8%     109.33 ± 15%  slabinfo.biovec-128.active_objs
      7.83 ± 34%     -12.8%       6.83 ± 15%  slabinfo.biovec-128.active_slabs
    125.33 ± 34%     -12.8%     109.33 ± 15%  slabinfo.biovec-128.num_objs
      7.83 ± 34%     -12.8%       6.83 ± 15%  slabinfo.biovec-128.num_slabs
    560.00 ± 12%      +1.9%     570.67 ± 14%  slabinfo.biovec-64.active_objs
     17.50 ± 12%      +1.9%      17.83 ± 14%  slabinfo.biovec-64.active_slabs
    560.00 ± 12%      +1.9%     570.67 ± 14%  slabinfo.biovec-64.num_objs
     17.50 ± 12%      +1.9%      17.83 ± 14%  slabinfo.biovec-64.num_slabs
    824.17            +0.6%     829.17        slabinfo.biovec-max.active_objs
    102.50            +1.0%     103.50        slabinfo.biovec-max.active_slabs
    824.17            +0.6%     829.50        slabinfo.biovec-max.num_objs
    102.50            +1.0%     103.50        slabinfo.biovec-max.num_slabs
     88.67 ± 11%      +0.0%      88.67 ± 21%  slabinfo.btrfs_inode.active_objs
      3.17 ± 11%      +0.0%       3.17 ± 21%  slabinfo.btrfs_inode.active_slabs
     88.67 ± 11%      +0.0%      88.67 ± 21%  slabinfo.btrfs_inode.num_objs
      3.17 ± 11%      +0.0%       3.17 ± 21%  slabinfo.btrfs_inode.num_slabs
    364.00 ±  7%      +1.8%     370.50 ±  8%  slabinfo.buffer_head.active_objs
      9.33 ±  7%      +1.8%       9.50 ±  8%  slabinfo.buffer_head.active_slabs
    364.00 ±  7%      +1.8%     370.50 ±  8%  slabinfo.buffer_head.num_objs
      9.33 ±  7%      +1.8%       9.50 ±  8%  slabinfo.buffer_head.num_slabs
      6973 ±  2%      +4.1%       7258 ±  2%  slabinfo.cred_jar.active_objs
    165.33 ±  2%      +4.0%     172.00 ±  2%  slabinfo.cred_jar.active_slabs
      6973 ±  2%      +4.1%       7258 ±  2%  slabinfo.cred_jar.num_objs
    165.33 ±  2%      +4.0%     172.00 ±  2%  slabinfo.cred_jar.num_slabs
    117.00            +0.0%     117.00        slabinfo.dax_cache.active_objs
      3.00            +0.0%       3.00        slabinfo.dax_cache.active_slabs
    117.00            +0.0%     117.00        slabinfo.dax_cache.num_objs
      3.00            +0.0%       3.00        slabinfo.dax_cache.num_slabs
   3253295            +0.4%    3267079        slabinfo.dentry.active_objs
     77485            +0.4%      77814        slabinfo.dentry.active_slabs
   3254391            +0.4%    3268212        slabinfo.dentry.num_objs
     77485            +0.4%      77814        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
    475.83 ±  6%      +9.6%     521.33 ±  7%  slabinfo.dmaengine-unmap-16.active_objs
     11.17 ±  8%      +9.0%      12.17 ±  5%  slabinfo.dmaengine-unmap-16.active_slabs
    475.83 ±  6%      +9.6%     521.33 ±  7%  slabinfo.dmaengine-unmap-16.num_objs
     11.17 ±  8%      +9.0%      12.17 ±  5%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     16343 ±  7%      +4.7%      17106 ±  3%  slabinfo.ep_head.active_objs
     63.33 ±  7%      +5.3%      66.67 ±  3%  slabinfo.ep_head.active_slabs
     16343 ±  7%      +4.7%      17106 ±  3%  slabinfo.ep_head.num_objs
     63.33 ±  7%      +5.3%      66.67 ±  3%  slabinfo.ep_head.num_slabs
      3511            +0.2%       3518        slabinfo.file_lock_cache.active_objs
     94.33            +0.4%      94.67        slabinfo.file_lock_cache.active_slabs
      3511            +0.2%       3518        slabinfo.file_lock_cache.num_objs
     94.33            +0.4%      94.67        slabinfo.file_lock_cache.num_slabs
      4571            -0.1%       4568        slabinfo.files_cache.active_objs
     98.67            +0.2%      98.83        slabinfo.files_cache.active_slabs
      4571            -0.1%       4568        slabinfo.files_cache.num_objs
     98.67            +0.2%      98.83        slabinfo.files_cache.num_slabs
     12549            -0.9%      12434 ±  2%  slabinfo.filp.active_objs
    410.33 ±  2%      -1.2%     405.33 ±  2%  slabinfo.filp.active_slabs
     13141 ±  2%      -1.2%      12985        slabinfo.filp.num_objs
    410.33 ±  2%      -1.2%     405.33 ±  2%  slabinfo.filp.num_slabs
      2733 ±  6%      +3.4%       2827 ± 12%  slabinfo.fsnotify_mark_connector.active_objs
     21.00 ±  5%      +2.4%      21.50 ± 12%  slabinfo.fsnotify_mark_connector.active_slabs
      2733 ±  6%      +3.4%       2827 ± 12%  slabinfo.fsnotify_mark_connector.num_objs
     21.00 ±  5%      +2.4%      21.50 ± 12%  slabinfo.fsnotify_mark_connector.num_slabs
     39667            +0.1%      39699        slabinfo.ftrace_event_field.active_objs
    466.33            +0.1%     466.67        slabinfo.ftrace_event_field.active_slabs
     39667            +0.1%      39699        slabinfo.ftrace_event_field.num_objs
    466.33            +0.1%     466.67        slabinfo.ftrace_event_field.num_slabs
     56.00            +0.0%      56.00        slabinfo.fuse_request.active_objs
      1.00            +0.0%       1.00        slabinfo.fuse_request.active_slabs
     56.00            +0.0%      56.00        slabinfo.fuse_request.num_objs
      1.00            +0.0%       1.00        slabinfo.fuse_request.num_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     98568            +0.1%      98618        slabinfo.inode_cache.active_objs
      1936            +0.0%       1937        slabinfo.inode_cache.active_slabs
     98785            +0.0%      98825        slabinfo.inode_cache.num_objs
      1936            +0.0%       1937        slabinfo.inode_cache.num_slabs
      3780            +0.3%       3793        slabinfo.ip4-frags.active_objs
     93.83            +0.9%      94.67        slabinfo.ip4-frags.active_slabs
      3780            +0.3%       3793        slabinfo.ip4-frags.num_objs
     93.83            +0.9%      94.67        slabinfo.ip4-frags.num_slabs
      4082            +0.6%       4108        slabinfo.ip6-frags.active_objs
     92.50            +0.4%      92.83        slabinfo.ip6-frags.active_slabs
      4082            +0.6%       4108        slabinfo.ip6-frags.num_objs
     92.50            +0.4%      92.83        slabinfo.ip6-frags.num_slabs
    170.33 ± 20%     +21.4%     206.83 ± 13%  slabinfo.ip_fib_alias.active_objs
      2.33 ± 20%     +21.4%       2.83 ± 13%  slabinfo.ip_fib_alias.active_slabs
    170.33 ± 20%     +21.4%     206.83 ± 13%  slabinfo.ip_fib_alias.num_objs
      2.33 ± 20%     +21.4%       2.83 ± 13%  slabinfo.ip_fib_alias.num_slabs
    198.33 ± 20%     +21.4%     240.83 ± 13%  slabinfo.ip_fib_trie.active_objs
      2.33 ± 20%     +21.4%       2.83 ± 13%  slabinfo.ip_fib_trie.active_slabs
    198.33 ± 20%     +21.4%     240.83 ± 13%  slabinfo.ip_fib_trie.num_objs
      2.33 ± 20%     +21.4%       2.83 ± 13%  slabinfo.ip_fib_trie.num_slabs
     85873            -0.2%      85680        slabinfo.kernfs_node_cache.active_objs
      2683            -0.2%       2677        slabinfo.kernfs_node_cache.active_slabs
     85873            -0.2%      85680        slabinfo.kernfs_node_cache.num_objs
      2683            -0.2%       2677        slabinfo.kernfs_node_cache.num_slabs
      2918 ±  3%      -4.1%       2799 ±  4%  slabinfo.khugepaged_mm_slot.active_objs
     80.67 ±  3%      -4.3%      77.17 ±  5%  slabinfo.khugepaged_mm_slot.active_slabs
      2918 ±  3%      -4.1%       2799 ±  4%  slabinfo.khugepaged_mm_slot.num_objs
     80.67 ±  3%      -4.3%      77.17 ±  5%  slabinfo.khugepaged_mm_slot.num_slabs
      5585            +0.3%       5599 ±  3%  slabinfo.kmalloc-128.active_objs
    175.83            +0.3%     176.33 ±  4%  slabinfo.kmalloc-128.active_slabs
      5640            +0.3%       5659 ±  4%  slabinfo.kmalloc-128.num_objs
    175.83            +0.3%     176.33 ±  4%  slabinfo.kmalloc-128.num_slabs
   3383563            +0.1%    3386226        slabinfo.kmalloc-16.active_objs
     13256            +0.1%      13266        slabinfo.kmalloc-16.active_slabs
   3393816            +0.1%    3396273        slabinfo.kmalloc-16.num_objs
     13256            +0.1%      13266        slabinfo.kmalloc-16.num_slabs
      5911            +0.8%       5957        slabinfo.kmalloc-192.active_objs
    139.83            +1.0%     141.17        slabinfo.kmalloc-192.active_slabs
      5911            +0.9%       5965        slabinfo.kmalloc-192.num_objs
    139.83            +1.0%     141.17        slabinfo.kmalloc-192.num_slabs
   2631045            +2.5%    2697164        slabinfo.kmalloc-1k.active_objs
     82405            +2.5%      84463        slabinfo.kmalloc-1k.active_slabs
   2636989            +2.5%    2702854        slabinfo.kmalloc-1k.num_objs
     82405            +2.5%      84463        slabinfo.kmalloc-1k.num_slabs
    119154            -0.7%     118370        slabinfo.kmalloc-256.active_objs
      3784            -0.8%       3753        slabinfo.kmalloc-256.active_slabs
    121109            -0.8%     120139        slabinfo.kmalloc-256.num_objs
      3784            -0.8%       3753        slabinfo.kmalloc-256.num_slabs
      3571            +0.4%       3585        slabinfo.kmalloc-2k.active_objs
    228.00            +0.4%     228.83        slabinfo.kmalloc-2k.active_slabs
      3654            +0.4%       3668        slabinfo.kmalloc-2k.num_objs
    228.00            +0.4%     228.83        slabinfo.kmalloc-2k.num_slabs
    153363            -0.1%     153278        slabinfo.kmalloc-32.active_objs
      1198            -0.1%       1197        slabinfo.kmalloc-32.active_slabs
    153403            -0.1%     153316        slabinfo.kmalloc-32.num_objs
      1198            -0.1%       1197        slabinfo.kmalloc-32.num_slabs
      2109 ±  2%      +7.8%       2273        slabinfo.kmalloc-4k.active_objs
    272.17 ±  2%      +6.9%     290.83        slabinfo.kmalloc-4k.active_slabs
      2179 ±  2%      +6.9%       2329        slabinfo.kmalloc-4k.num_objs
    272.17 ±  2%      +6.9%     290.83        slabinfo.kmalloc-4k.num_slabs
    195873            +0.3%     196460        slabinfo.kmalloc-512.active_objs
      6424            +0.0%       6427        slabinfo.kmalloc-512.active_slabs
    205584            +0.0%     205681        slabinfo.kmalloc-512.num_objs
      6424            +0.0%       6427        slabinfo.kmalloc-512.num_slabs
     53041            +0.4%      53275        slabinfo.kmalloc-64.active_objs
    829.17            +0.5%     833.50        slabinfo.kmalloc-64.active_slabs
     53110            +0.5%      53373        slabinfo.kmalloc-64.num_objs
    829.17            +0.5%     833.50        slabinfo.kmalloc-64.num_slabs
     58032            -1.3%      57252        slabinfo.kmalloc-8.active_objs
    123.17 ±  3%      -3.5%     118.83 ±  2%  slabinfo.kmalloc-8.active_slabs
     63379 ±  2%      -3.6%      61086 ±  2%  slabinfo.kmalloc-8.num_objs
    123.17 ±  3%      -3.5%     118.83 ±  2%  slabinfo.kmalloc-8.num_slabs
      1189            -1.1%       1175        slabinfo.kmalloc-8k.active_objs
    301.50            -1.3%     297.50        slabinfo.kmalloc-8k.active_slabs
      1207            -1.3%       1191        slabinfo.kmalloc-8k.num_objs
    301.50            -1.3%     297.50        slabinfo.kmalloc-8k.num_slabs
     12409 ±  2%      +1.7%      12620 ±  4%  slabinfo.kmalloc-96.active_objs
    314.17 ±  2%      +2.1%     320.83 ±  4%  slabinfo.kmalloc-96.active_slabs
     13219 ±  2%      +2.0%      13488 ±  4%  slabinfo.kmalloc-96.num_objs
    314.17 ±  2%      +2.1%     320.83 ±  4%  slabinfo.kmalloc-96.num_slabs
    794.67 ±  7%      +7.4%     853.33 ±  9%  slabinfo.kmalloc-cg-128.active_objs
     24.83 ±  7%      +7.4%      26.67 ±  9%  slabinfo.kmalloc-cg-128.active_slabs
    794.67 ±  7%      +7.4%     853.33 ±  9%  slabinfo.kmalloc-cg-128.num_objs
     24.83 ±  7%      +7.4%      26.67 ±  9%  slabinfo.kmalloc-cg-128.num_slabs
      4945 ±  7%     -11.9%       4357 ±  9%  slabinfo.kmalloc-cg-16.active_objs
     19.00 ±  6%     -13.2%      16.50 ±  9%  slabinfo.kmalloc-cg-16.active_slabs
      4945 ±  7%     -11.9%       4357 ±  9%  slabinfo.kmalloc-cg-16.num_objs
     19.00 ±  6%     -13.2%      16.50 ±  9%  slabinfo.kmalloc-cg-16.num_slabs
      4345            -0.6%       4319        slabinfo.kmalloc-cg-192.active_objs
    102.83            -0.5%     102.33        slabinfo.kmalloc-cg-192.active_slabs
      4345            -0.6%       4319        slabinfo.kmalloc-cg-192.num_objs
    102.83            -0.5%     102.33        slabinfo.kmalloc-cg-192.num_slabs
      3461 ±  4%      +0.6%       3481 ±  2%  slabinfo.kmalloc-cg-1k.active_objs
    107.50 ±  4%      +1.1%     108.67 ±  3%  slabinfo.kmalloc-cg-1k.active_slabs
      3461 ±  4%      +0.6%       3482 ±  2%  slabinfo.kmalloc-cg-1k.num_objs
    107.50 ±  4%      +1.1%     108.67 ±  3%  slabinfo.kmalloc-cg-1k.num_slabs
    538.67 ±  4%      +2.0%     549.33 ±  5%  slabinfo.kmalloc-cg-256.active_objs
     16.83 ±  4%      +2.0%      17.17 ±  5%  slabinfo.kmalloc-cg-256.active_slabs
    538.67 ±  4%      +2.0%     549.33 ±  5%  slabinfo.kmalloc-cg-256.num_objs
     16.83 ±  4%      +2.0%      17.17 ±  5%  slabinfo.kmalloc-cg-256.num_slabs
    532.50 ±  7%      +5.7%     563.00 ±  5%  slabinfo.kmalloc-cg-2k.active_objs
     32.83 ±  7%      +5.6%      34.67 ±  5%  slabinfo.kmalloc-cg-2k.active_slabs
    532.50 ±  7%      +5.7%     563.00 ±  5%  slabinfo.kmalloc-cg-2k.num_objs
     32.83 ±  7%      +5.6%      34.67 ±  5%  slabinfo.kmalloc-cg-2k.num_slabs
     12462            +0.0%      12468        slabinfo.kmalloc-cg-32.active_objs
     96.83            +0.0%      96.83        slabinfo.kmalloc-cg-32.active_slabs
     12462            +0.0%      12468        slabinfo.kmalloc-cg-32.num_objs
     96.83            +0.0%      96.83        slabinfo.kmalloc-cg-32.num_slabs
      1022            -0.8%       1014        slabinfo.kmalloc-cg-4k.active_objs
    134.83 ±  2%      +1.2%     136.50        slabinfo.kmalloc-cg-4k.active_slabs
      1082            +1.4%       1097        slabinfo.kmalloc-cg-4k.num_objs
    134.83 ±  2%      +1.2%     136.50        slabinfo.kmalloc-cg-4k.num_slabs
      3141            +0.7%       3162        slabinfo.kmalloc-cg-512.active_objs
     98.17            +0.7%      98.83        slabinfo.kmalloc-cg-512.active_slabs
      3141            +0.7%       3162        slabinfo.kmalloc-cg-512.num_objs
     98.17            +0.7%      98.83        slabinfo.kmalloc-cg-512.num_slabs
      1971 ±  8%      -1.2%       1947 ± 10%  slabinfo.kmalloc-cg-64.active_objs
     30.17 ±  7%      -1.7%      29.67 ± 10%  slabinfo.kmalloc-cg-64.active_slabs
      1971 ±  8%      -1.2%       1947 ± 10%  slabinfo.kmalloc-cg-64.num_objs
     30.17 ±  7%      -1.7%      29.67 ± 10%  slabinfo.kmalloc-cg-64.num_slabs
     49749            -0.2%      49664        slabinfo.kmalloc-cg-8.active_objs
     97.17            -0.2%      97.00        slabinfo.kmalloc-cg-8.active_slabs
     49749            -0.2%      49664        slabinfo.kmalloc-cg-8.num_objs
     97.17            -0.2%      97.00        slabinfo.kmalloc-cg-8.num_slabs
     51.67 ±  2%      -1.0%      51.17        slabinfo.kmalloc-cg-8k.active_objs
     12.67 ±  3%      -1.3%      12.50 ±  4%  slabinfo.kmalloc-cg-8k.active_slabs
     51.67 ±  2%      -1.0%      51.17        slabinfo.kmalloc-cg-8k.num_objs
     12.67 ±  3%      -1.3%      12.50 ±  4%  slabinfo.kmalloc-cg-8k.num_slabs
    846.00 ±  5%      +0.8%     853.00 ±  3%  slabinfo.kmalloc-cg-96.active_objs
     19.17 ±  5%      +0.9%      19.33 ±  3%  slabinfo.kmalloc-cg-96.active_slabs
    846.00 ±  5%      +0.8%     853.00 ±  3%  slabinfo.kmalloc-cg-96.num_objs
     19.17 ±  5%      +0.9%      19.33 ±  3%  slabinfo.kmalloc-cg-96.num_slabs
    165.33 ± 17%      +6.5%     176.00 ± 17%  slabinfo.kmalloc-rcl-128.active_objs
      5.17 ± 17%      +6.5%       5.50 ± 17%  slabinfo.kmalloc-rcl-128.active_slabs
    165.33 ± 17%      +6.5%     176.00 ± 17%  slabinfo.kmalloc-rcl-128.num_objs
      5.17 ± 17%      +6.5%       5.50 ± 17%  slabinfo.kmalloc-rcl-128.num_slabs
    154.00 ± 25%      +4.5%     161.00 ± 23%  slabinfo.kmalloc-rcl-192.active_objs
      3.67 ± 25%      +4.5%       3.83 ± 23%  slabinfo.kmalloc-rcl-192.active_slabs
    154.00 ± 25%      +4.5%     161.00 ± 23%  slabinfo.kmalloc-rcl-192.num_objs
      3.67 ± 25%      +4.5%       3.83 ± 23%  slabinfo.kmalloc-rcl-192.num_slabs
   3144877            +0.4%    3158806        slabinfo.kmalloc-rcl-64.active_objs
     49154            +0.4%      49373        slabinfo.kmalloc-rcl-64.active_slabs
   3145909            +0.4%    3159922        slabinfo.kmalloc-rcl-64.num_objs
     49154            +0.4%      49373        slabinfo.kmalloc-rcl-64.num_slabs
      1894 ±  5%      +2.0%       1933 ±  9%  slabinfo.kmalloc-rcl-96.active_objs
     45.00 ±  6%      +1.9%      45.83 ±  9%  slabinfo.kmalloc-rcl-96.active_slabs
      1894 ±  5%      +2.0%       1933 ±  9%  slabinfo.kmalloc-rcl-96.num_objs
     45.00 ±  6%      +1.9%      45.83 ±  9%  slabinfo.kmalloc-rcl-96.num_slabs
    661.33 ±  9%      +7.3%     709.33 ±  4%  slabinfo.kmem_cache.active_objs
     20.67 ±  9%      +7.3%      22.17 ±  4%  slabinfo.kmem_cache.active_slabs
    661.33 ±  9%      +7.3%     709.33 ±  4%  slabinfo.kmem_cache.num_objs
     20.67 ±  9%      +7.3%      22.17 ±  4%  slabinfo.kmem_cache.num_slabs
      1387 ±  8%      +6.9%       1483 ±  4%  slabinfo.kmem_cache_node.active_objs
     22.67 ±  8%      +6.6%      24.17 ±  4%  slabinfo.kmem_cache_node.active_slabs
      1450 ±  8%      +6.6%       1546 ±  4%  slabinfo.kmem_cache_node.num_objs
     22.67 ±  8%      +6.6%      24.17 ±  4%  slabinfo.kmem_cache_node.num_slabs
     18853 ±  2%      -1.6%      18551        slabinfo.lsm_file_cache.active_objs
    113.50 ±  2%      -1.2%     112.17        slabinfo.lsm_file_cache.active_slabs
     19423 ±  2%      -1.4%      19156        slabinfo.lsm_file_cache.num_objs
    113.50 ±  2%      -1.2%     112.17        slabinfo.lsm_file_cache.num_slabs
      7146 ±  3%      -2.6%       6960 ±  2%  slabinfo.maple_node.active_objs
    223.67 ±  3%      -2.5%     218.17 ±  3%  slabinfo.maple_node.active_slabs
      7174 ±  3%      -2.5%       6992 ±  3%  slabinfo.maple_node.num_objs
    223.67 ±  3%      -2.5%     218.17 ±  3%  slabinfo.maple_node.num_slabs
      2759            -0.8%       2738        slabinfo.mm_struct.active_objs
    105.67            -0.8%     104.83        slabinfo.mm_struct.active_slabs
      2760            -0.8%       2738        slabinfo.mm_struct.num_objs
    105.67            -0.8%     104.83        slabinfo.mm_struct.num_slabs
      1241            -4.8%       1181 ± 10%  slabinfo.mnt_cache.active_objs
     24.33            -4.8%      23.17 ± 10%  slabinfo.mnt_cache.active_slabs
      1241            -4.8%       1181 ± 10%  slabinfo.mnt_cache.num_objs
     24.33            -4.8%      23.17 ± 10%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    788.00 ±  4%      -2.4%     769.33        slabinfo.names_cache.active_objs
     98.83 ±  5%      -2.7%      96.17        slabinfo.names_cache.active_slabs
    790.67 ±  5%      -2.7%     769.33        slabinfo.names_cache.num_objs
     98.83 ±  5%      -2.7%      96.17        slabinfo.names_cache.num_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.active_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.active_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.num_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.num_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.active_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.num_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    290.50 ± 16%     +12.4%     326.67 ± 10%  slabinfo.nsproxy.active_objs
      4.50 ± 21%     +14.8%       5.17 ± 13%  slabinfo.nsproxy.active_slabs
    290.50 ± 16%     +12.4%     326.67 ± 10%  slabinfo.nsproxy.num_objs
      4.50 ± 21%     +14.8%       5.17 ± 13%  slabinfo.nsproxy.num_slabs
     12994            -2.0%      12730 ±  2%  slabinfo.numa_policy.active_objs
    223.83 ±  2%      -2.4%     218.50        slabinfo.numa_policy.active_slabs
     13463            -2.4%      13146        slabinfo.numa_policy.num_objs
    223.83 ±  2%      -2.4%     218.50        slabinfo.numa_policy.num_slabs
      9717            +0.2%       9733        slabinfo.pde_opener.active_objs
     94.50            +0.4%      94.83        slabinfo.pde_opener.active_slabs
      9717            +0.2%       9733        slabinfo.pde_opener.num_objs
     94.50            +0.4%      94.83        slabinfo.pde_opener.num_slabs
      3649            -1.6%       3590        slabinfo.perf_event.active_objs
    145.83            -1.6%     143.50        slabinfo.perf_event.active_slabs
      3807            -1.5%       3748        slabinfo.perf_event.num_objs
    145.83            -1.6%     143.50        slabinfo.perf_event.num_slabs
      5038            +1.3%       5104 ±  4%  slabinfo.pid.active_objs
    157.00            +1.6%     159.50 ±  3%  slabinfo.pid.active_slabs
      5038            +1.6%       5116 ±  3%  slabinfo.pid.num_objs
    157.00            +1.6%     159.50 ±  3%  slabinfo.pid.num_slabs
      4234            -1.2%       4184 ±  3%  slabinfo.proc_dir_entry.active_objs
    100.83            -1.2%      99.67 ±  3%  slabinfo.proc_dir_entry.active_slabs
      4235            -1.2%       4186 ±  3%  slabinfo.proc_dir_entry.num_objs
    100.83            -1.2%      99.67 ±  3%  slabinfo.proc_dir_entry.num_slabs
     11561            -0.1%      11547        slabinfo.proc_inode_cache.active_objs
    255.00            -0.4%     254.00        slabinfo.proc_inode_cache.active_slabs
     11753            -0.5%      11699        slabinfo.proc_inode_cache.num_objs
    255.00            -0.4%     254.00        slabinfo.proc_inode_cache.num_slabs
   3393485            +0.2%    3400050        slabinfo.radix_tree_node.active_objs
     61218            +0.1%      61307        slabinfo.radix_tree_node.active_slabs
   3428248            +0.1%    3433270        slabinfo.radix_tree_node.num_objs
     61218            +0.1%      61307        slabinfo.radix_tree_node.num_slabs
    271.33 ±  6%      +2.3%     277.50 ± 10%  slabinfo.request_queue.active_objs
      7.33 ±  6%      +2.3%       7.50 ± 10%  slabinfo.request_queue.active_slabs
    271.33 ±  6%      +2.3%     277.50 ± 10%  slabinfo.request_queue.num_objs
      7.33 ±  6%      +2.3%       7.50 ± 10%  slabinfo.request_queue.num_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    922.67            +0.0%     922.67        slabinfo.scsi_sense_cache.active_objs
     28.83            +0.0%      28.83        slabinfo.scsi_sense_cache.active_slabs
    922.67            +0.0%     922.67        slabinfo.scsi_sense_cache.num_objs
     28.83            +0.0%      28.83        slabinfo.scsi_sense_cache.num_slabs
      3433            -0.2%       3427        slabinfo.seq_file.active_objs
    100.00            -0.2%      99.83        slabinfo.seq_file.active_slabs
      3433            -0.2%       3427        slabinfo.seq_file.num_objs
    100.00            -0.2%      99.83        slabinfo.seq_file.num_slabs
      5128            +0.6%       5161        slabinfo.shmem_inode_cache.active_objs
    121.67            +0.8%     122.67        slabinfo.shmem_inode_cache.active_slabs
      5128            +0.6%       5161        slabinfo.shmem_inode_cache.num_objs
    121.67            +0.8%     122.67        slabinfo.shmem_inode_cache.num_slabs
      2473            +0.1%       2475        slabinfo.sighand_cache.active_objs
    164.17            +0.5%     165.00        slabinfo.sighand_cache.active_slabs
      2473            +0.3%       2481        slabinfo.sighand_cache.num_objs
    164.17            +0.5%     165.00        slabinfo.sighand_cache.num_slabs
      4437 ±  2%      +0.9%       4479 ±  3%  slabinfo.signal_cache.active_objs
    159.33 ±  2%      +1.0%     161.00 ±  3%  slabinfo.signal_cache.active_slabs
      4474 ±  2%      +1.1%       4522 ±  3%  slabinfo.signal_cache.num_objs
    159.33 ±  2%      +1.0%     161.00 ±  3%  slabinfo.signal_cache.num_slabs
      5608            -1.3%       5537 ±  2%  slabinfo.sigqueue.active_objs
    109.17            -1.2%     107.83 ±  2%  slabinfo.sigqueue.active_slabs
      5608            -1.3%       5537 ±  2%  slabinfo.sigqueue.num_objs
    109.17            -1.2%     107.83 ±  2%  slabinfo.sigqueue.num_slabs
    336.00 ± 18%     -14.3%     288.00 ± 15%  slabinfo.skbuff_fclone_cache.active_objs
     10.50 ± 18%     -14.3%       9.00 ± 15%  slabinfo.skbuff_fclone_cache.active_slabs
    336.00 ± 18%     -14.3%     288.00 ± 15%  slabinfo.skbuff_fclone_cache.num_objs
     10.50 ± 18%     -14.3%       9.00 ± 15%  slabinfo.skbuff_fclone_cache.num_slabs
      4341 ±  6%      -0.4%       4325 ±  3%  slabinfo.skbuff_head_cache.active_objs
    137.83 ±  7%      -0.5%     137.17 ±  3%  slabinfo.skbuff_head_cache.active_slabs
      4410 ±  7%      -0.5%       4389 ±  3%  slabinfo.skbuff_head_cache.num_objs
    137.83 ±  7%      -0.5%     137.17 ±  3%  slabinfo.skbuff_head_cache.num_slabs
      3216 ±  5%      -1.6%       3166 ±  7%  slabinfo.sock_inode_cache.active_objs
     82.00 ±  5%      -1.4%      80.83 ±  7%  slabinfo.sock_inode_cache.active_slabs
      3216 ±  5%      -1.6%       3166 ±  7%  slabinfo.sock_inode_cache.num_objs
     82.00 ±  5%      -1.4%      80.83 ±  7%  slabinfo.sock_inode_cache.num_slabs
      1467 ±  4%     -12.3%       1286 ± 11%  slabinfo.task_group.active_objs
     28.00 ±  4%     -11.3%      24.83 ± 12%  slabinfo.task_group.active_slabs
      1467 ±  4%     -12.3%       1286 ± 11%  slabinfo.task_group.num_objs
     28.00 ±  4%     -11.3%      24.83 ± 12%  slabinfo.task_group.num_slabs
      1778            +0.2%       1781        slabinfo.task_struct.active_objs
      1780            +0.2%       1783        slabinfo.task_struct.active_slabs
      1780            +0.2%       1783        slabinfo.task_struct.num_objs
      1780            +0.2%       1783        slabinfo.task_struct.num_slabs
    346.33 ±  5%      -0.1%     346.00 ± 10%  slabinfo.taskstats.active_objs
      8.33 ±  5%      +0.0%       8.33 ± 11%  slabinfo.taskstats.active_slabs
    346.33 ±  5%      -0.1%     346.00 ± 10%  slabinfo.taskstats.num_objs
      8.33 ±  5%      +0.0%       8.33 ± 11%  slabinfo.taskstats.num_slabs
      2875            +0.3%       2882        slabinfo.trace_event_file.active_objs
     62.50            +0.3%      62.67        slabinfo.trace_event_file.active_slabs
      2875            +0.3%       2882        slabinfo.trace_event_file.num_objs
     62.50            +0.3%      62.67        slabinfo.trace_event_file.num_slabs
     60.00            +0.0%      60.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     60.00            +0.0%      60.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     67.83 ± 20%      +9.1%      74.00        slabinfo.uts_namespace.active_objs
      1.83 ± 20%      +9.1%       2.00        slabinfo.uts_namespace.active_slabs
     67.83 ± 20%      +9.1%      74.00        slabinfo.uts_namespace.num_objs
      1.83 ± 20%      +9.1%       2.00        slabinfo.uts_namespace.num_slabs
     21786            -0.1%      21765 ±  2%  slabinfo.vm_area_struct.active_objs
    415.00            -0.4%     413.33 ±  2%  slabinfo.vm_area_struct.active_slabs
     22007            -0.3%      21931 ±  2%  slabinfo.vm_area_struct.num_objs
    415.00            -0.4%     413.33 ±  2%  slabinfo.vm_area_struct.num_slabs
     10943 ±  2%      +0.9%      11043 ±  2%  slabinfo.vmap_area.active_objs
    175.00 ±  2%      +0.7%     176.17 ±  2%  slabinfo.vmap_area.active_slabs
     11226 ±  2%      +0.7%      11303 ±  2%  slabinfo.vmap_area.num_objs
    175.00 ±  2%      +0.7%     176.17 ±  2%  slabinfo.vmap_area.num_slabs
      4134            +0.2%       4144        slabinfo.xfs_bmbt_cur.active_objs
     83.67            +0.8%      84.33        slabinfo.xfs_bmbt_cur.active_slabs
      4134            +0.2%       4144        slabinfo.xfs_bmbt_cur.num_objs
     83.67            +0.8%      84.33        slabinfo.xfs_bmbt_cur.num_slabs
    168642            -0.1%     168439        slabinfo.xfs_buf.active_objs
      4014            -0.1%       4010        slabinfo.xfs_buf.active_slabs
    168643            -0.1%     168440        slabinfo.xfs_buf.num_objs
      4014            -0.1%       4010        slabinfo.xfs_buf.num_slabs
      3105            +0.9%       3134        slabinfo.xfs_da_state.active_objs
     91.00            +0.9%      91.83        slabinfo.xfs_da_state.active_slabs
      3105            +0.9%       3134        slabinfo.xfs_da_state.num_objs
     91.00            +0.9%      91.83        slabinfo.xfs_da_state.num_slabs
   3356447            +0.1%    3359177        slabinfo.xfs_ili.active_objs
     83954            +0.1%      84023        slabinfo.xfs_ili.active_slabs
   3358213            +0.1%    3360952        slabinfo.xfs_ili.num_objs
     83954            +0.1%      84023        slabinfo.xfs_ili.num_slabs
   3356044            +0.1%    3358777        slabinfo.xfs_inode.active_objs
    104920            +0.1%     105005        slabinfo.xfs_inode.active_slabs
   3357459            +0.1%    3360203        slabinfo.xfs_inode.num_objs
    104920            +0.1%     105005        slabinfo.xfs_inode.num_slabs
      2.58 ±188%      -2.1        0.49 ± 49%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
      2.78 ±113%      -1.6        1.14 ± 15%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     14.01 ±  3%      -1.4       12.65 ±  2%  perf-profile.calltrace.cycles-pp.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55.37            -1.1       54.29        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     58.43            -1.0       57.39        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     58.42            -1.0       57.39        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     58.39            -1.0       57.36        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     53.38 ±  2%      -1.0       52.42        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      9.48 ±  4%      -0.7        8.77 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync.do_syscall_64
     58.80            -0.7       58.15        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.44 ± 64%      -0.6        0.78 ± 21%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.22 ±  7%      -0.6        3.57 ±  5%  perf-profile.calltrace.cycles-pp.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync.do_syscall_64
      7.47 ±  4%      -0.6        6.83 ±  3%  perf-profile.calltrace.cycles-pp.open64
      7.42 ±  4%      -0.6        6.78 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      7.40 ±  4%      -0.6        6.76 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      7.42 ±  4%      -0.6        6.79 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      7.39 ±  4%      -0.6        6.76 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      7.32 ±  4%      -0.6        6.70 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.30 ±  4%      -0.6        6.69 ±  3%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      6.98 ±  4%      -0.6        6.38 ±  3%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.59 ±  8%      -0.6        0.00        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.io_schedule
      6.90 ±  4%      -0.6        6.31 ±  3%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.62 ± 27%      -0.6        1.05 ± 25%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      3.30 ±  8%      -0.5        2.77 ±  7%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync
      3.28 ±  8%      -0.5        2.74 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync
      3.25 ±  8%      -0.5        2.72 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq
      7.83 ±  4%      -0.5        7.34 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync
      6.10 ±  4%      -0.5        5.63 ±  3%  perf-profile.calltrace.cycles-pp.xfs_generic_create.lookup_open.open_last_lookups.path_openat.do_filp_open
      7.54 ±  4%      -0.5        7.07 ±  2%  perf-profile.calltrace.cycles-pp.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
     52.87 ±  2%      -0.5       52.41 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      5.98 ±  4%      -0.5        5.52 ±  4%  perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.lookup_open.open_last_lookups.path_openat
      0.61 ±  8%      -0.4        0.17 ±141%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.io_schedule.folio_wait_bit_common
      1.19 ± 33%      -0.4        0.76 ± 24%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      1.17 ± 34%      -0.4        0.74 ± 24%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      0.48 ± 45%      -0.4        0.09 ±223%  perf-profile.calltrace.cycles-pp.xfs_vn_lookup.lookup_open.open_last_lookups.path_openat.do_filp_open
      3.34 ±  9%      -0.4        2.97 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.37 ± 71%      -0.4        0.00        perf-profile.calltrace.cycles-pp.xfs_lookup.xfs_vn_lookup.lookup_open.open_last_lookups.path_openat
      3.25 ±  9%      -0.4        2.88 ±  9%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.45 ± 45%      -0.4        0.08 ±223%  perf-profile.calltrace.cycles-pp.xfs_buf_unlock.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit.xfs_create
      3.33 ±  9%      -0.4        2.96 ±  8%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.34 ±  9%      -0.4        2.98 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      3.36 ±  9%      -0.4        3.00 ±  8%  perf-profile.calltrace.cycles-pp.write
      3.31 ±  9%      -0.4        2.95 ±  8%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.16 ±  9%      -0.4        2.80 ±  9%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      2.97 ± 10%      -0.3        2.63 ±  9%  perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      5.54 ± 10%      -0.3        5.20 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.57 ±  9%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit.xfs_create.xfs_generic_create
      5.78 ±  3%      -0.3        5.48 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork
      5.78 ±  3%      -0.3        5.48 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.47 ± 45%      -0.3        0.17 ±141%  perf-profile.calltrace.cycles-pp.xfs_end_bio.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu.handle_irq_event
      0.57 ± 10%      -0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.schedule_timeout
      0.28 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.queue_work_on.xfs_end_bio.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu
      0.47 ± 82%      -0.3        0.20 ±141%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      5.52 ±  2%      -0.3        5.25 ±  2%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.99 ± 43%      -0.3        0.73 ± 25%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      0.26 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints.intel_idle_irq.cpuidle_enter_state
      0.98 ± 43%      -0.3        0.73 ± 25%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      1.87 ±  6%      -0.3        1.61 ±  3%  perf-profile.calltrace.cycles-pp.__wait_for_common.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
      1.81 ±  7%      -0.3        1.56 ±  4%  perf-profile.calltrace.cycles-pp.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      1.47 ± 18%      -0.2        1.22 ± 15%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      1.34 ± 20%      -0.2        1.10 ± 17%  perf-profile.calltrace.cycles-pp.filemap_dirty_folio.iomap_write_end.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      1.79 ±  7%      -0.2        1.55 ±  4%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now
      1.78 ±  7%      -0.2        1.54 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__wait_for_common.__flush_workqueue
      1.48 ± 18%      -0.2        1.25 ± 17%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
      1.00 ± 64%      -0.2        0.77 ± 11%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      1.47 ± 18%      -0.2        1.25 ± 16%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      1.19 ± 23%      -0.2        0.96 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock.locked_inode_to_wb_and_lock_list.__mark_inode_dirty.filemap_dirty_folio.iomap_write_end
      1.17 ± 24%      -0.2        0.94 ± 19%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.locked_inode_to_wb_and_lock_list.__mark_inode_dirty.filemap_dirty_folio
      1.19 ± 23%      -0.2        0.97 ± 18%  perf-profile.calltrace.cycles-pp.locked_inode_to_wb_and_lock_list.__mark_inode_dirty.filemap_dirty_folio.iomap_write_end.iomap_write_iter
      0.22 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.05 ±  4%      -0.2        1.82 ±  3%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      1.22 ± 22%      -0.2        1.00 ± 18%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.filemap_dirty_folio.iomap_write_end.iomap_write_iter.iomap_file_buffered_write
      1.93 ±  4%      -0.2        1.72 ±  4%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_create.xfs_generic_create.lookup_open
      0.95 ± 63%      -0.2        0.74 ± 12%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.48 ± 46%      -0.2        0.27 ±100%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      0.94 ± 63%      -0.2        0.74 ± 12%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      1.28 ±  5%      -0.2        1.08 ±  3%  perf-profile.calltrace.cycles-pp.__filemap_fdatawait_range.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fsync.do_syscall_64
      0.20 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.xfs_dir_lookup.xfs_lookup.xfs_vn_lookup.lookup_open.open_last_lookups
      1.20 ±  5%      -0.2        1.00 ±  3%  perf-profile.calltrace.cycles-pp.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range.xfs_file_fsync
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__queue_work.queue_work_on.xfs_end_bio.blk_mq_end_request_batch.nvme_irq
      0.36 ± 71%      -0.2        0.17 ±141%  perf-profile.calltrace.cycles-pp.up.xfs_buf_unlock.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit
      0.39 ±110%      -0.2        0.20 ±141%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.__queue_work.queue_work_on.xfs_end_bio.blk_mq_end_request_batch
      1.21 ±  5%      -0.2        1.02 ±  3%  perf-profile.calltrace.cycles-pp.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fsync
      1.13 ±  5%      -0.2        0.94 ±  3%  perf-profile.calltrace.cycles-pp.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range
      1.12 ±  6%      -0.2        0.94 ±  3%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      1.12 ±  6%      -0.2        0.94 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.folio_wait_bit_common.folio_wait_writeback
      0.18 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      0.18 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints.intel_idle_irq
      0.56 ±  8%      -0.2        0.39 ± 70%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      4.63 ±  3%      -0.2        4.46 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.17 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints
      0.17 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      1.38 ± 28%      -0.2        1.22 ± 25%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      4.86 ±  7%      -0.2        4.70 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.58 ± 16%      -0.2        1.42 ± 18%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      1.38 ± 28%      -0.2        1.22 ± 25%  perf-profile.calltrace.cycles-pp.__cmd_record
      1.38 ± 28%      -0.2        1.22 ± 25%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      1.38 ± 28%      -0.2        1.22 ± 25%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      2.26 ±  5%      -0.1        2.12 ±  5%  perf-profile.calltrace.cycles-pp.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      1.10 ± 25%      -0.1        0.95 ± 17%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch
      1.06 ±  8%      -0.1        0.91 ±  6%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync
      1.05 ±  8%      -0.1        0.90 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      1.03 ±  8%      -0.1        0.88 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq
      0.58 ± 10%      -0.1        0.44 ± 45%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.schedule_timeout.__wait_for_common
      4.56 ±  6%      -0.1        4.43 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
      0.96 ± 28%      -0.1        0.83 ± 28%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record.cmd_record
      0.96 ± 28%      -0.1        0.84 ± 27%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record.cmd_record.cmd_sched.run_builtin
      0.96 ± 28%      -0.1        0.84 ± 27%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record.cmd_record.cmd_sched
      0.89 ±  3%      -0.1        0.78 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.__wait_for_common
      1.48 ±  7%      -0.1        1.38 ±  5%  perf-profile.calltrace.cycles-pp.xfs_end_io.process_one_work.worker_thread.kthread.ret_from_fork
      1.47 ±  7%      -0.1        1.37 ±  5%  perf-profile.calltrace.cycles-pp.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread.kthread
      1.19 ±  6%      -0.1        1.09 ±  3%  perf-profile.calltrace.cycles-pp.xlog_ioend_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.81 ±  5%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.85 ±  4%      -0.1        0.75 ±  7%  perf-profile.calltrace.cycles-pp.xfs_dialloc_ag.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open
      0.28 ±147%      -0.1        0.18 ±142%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.xfs_trans_committed_bulk.xlog_cil_committed.xlog_cil_process_committed.xlog_state_do_iclog_callbacks.xlog_state_do_callback
      0.82 ±  5%      -0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork
      0.18 ±141%      -0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.complete.flush_workqueue_prep_pwqs.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      0.82 ±  7%      -0.1        0.73 ±  5%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      1.64 ±  4%      -0.1        1.55 ±  8%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.82 ±  6%      -0.1        0.73 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.95 ±  7%      -0.1        0.86 ±  5%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.84 ±  6%      -0.1        0.75 ±  3%  perf-profile.calltrace.cycles-pp.schedule.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync
      1.10 ±  6%      -0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.xlog_state_do_iclog_callbacks.xlog_state_do_callback.xlog_ioend_work.process_one_work.worker_thread
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.schedule.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.up.xfs_buf_unlock.xfs_buf_item_release.xlog_cil_commit
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.xfs_dir2_node_lookup.xfs_dir_lookup.xfs_lookup.xfs_vn_lookup.lookup_open
      1.11 ±  6%      -0.1        1.02 ±  3%  perf-profile.calltrace.cycles-pp.xlog_state_do_callback.xlog_ioend_work.process_one_work.worker_thread.kthread
      0.26 ±100%      -0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.mem_cgroup_css_rstat_flush.cgroup_rstat_flush_locked.cgroup_rstat_flush_irqsafe.__mem_cgroup_flush_stats.mem_cgroup_wb_stats
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.complete.flush_workqueue_prep_pwqs.__flush_workqueue.xlog_cil_push_now
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      1.24 ±  7%      -0.1        1.16 ±  6%  perf-profile.calltrace.cycles-pp.xfs_ialloc_read_agi.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open
      1.23 ±  7%      -0.1        1.15 ±  6%  perf-profile.calltrace.cycles-pp.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc.xfs_create.xfs_generic_create
      0.82 ±  6%      -0.1        0.74 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync
      1.17 ±  7%      -0.1        1.09 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc
      1.13 ±  7%      -0.1        1.05 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi
      1.16 ±  7%      -0.1        1.08 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi
      0.65 ±  4%      -0.1        0.58 ±  6%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      0.76 ±  9%      -0.1        0.69 ±  6%  perf-profile.calltrace.cycles-pp.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.93 ±  9%      -0.1        0.86 ±  5%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.22 ±  7%      -0.1        1.14 ±  6%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc.xfs_create
      0.94 ±  9%      -0.1        0.86 ±  5%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.28 ±  5%      -0.1        1.20 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.89 ±  9%      -0.1        0.82 ±  5%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.84 ±  9%      -0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt
      0.84 ±  8%      -0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.nvme_irq.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt
      0.75 ±  3%      -0.1        0.68 ±  6%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_create.xfs_generic_create
      0.86 ±  9%      -0.1        0.79 ±  5%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      0.89 ±  9%      -0.1        0.82 ±  5%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      0.74 ±  9%      -0.1        0.67 ±  8%  perf-profile.calltrace.cycles-pp.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      0.80 ± 28%      -0.1        0.74 ±  3%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      3.30 ±  8%      -0.1        3.25 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.99 ±  7%      -0.0        0.95 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      3.26 ±  8%      -0.0        3.22 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.67 ±  8%      -0.0        0.63 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_process_committed.xlog_state_do_iclog_callbacks.xlog_state_do_callback.xlog_ioend_work.process_one_work
      0.67 ±  8%      -0.0        0.63 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_committed.xlog_cil_process_committed.xlog_state_do_iclog_callbacks.xlog_state_do_callback.xlog_ioend_work
      0.65 ±  4%      -0.0        0.61 ±  6%  perf-profile.calltrace.cycles-pp.flush_workqueue_prep_pwqs.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
      0.96 ±  7%      -0.0        0.92 ±  7%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.84 ±  7%      -0.0        0.80 ±  3%  perf-profile.calltrace.cycles-pp.xfs_dir_createname.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      0.50 ± 45%      -0.0        0.46 ± 45%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.71 ±  7%      -0.0        0.67 ±  4%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work
      0.62 ±  5%      -0.0        0.58 ±  3%  perf-profile.calltrace.cycles-pp.xfs_init_new_inode.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      3.66 ±  7%      -0.0        3.62 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      1.67 ±  8%      -0.0        1.64 ±  5%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.77 ±  4%      -0.0        0.74 ±  5%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      0.75 ±  7%      -0.0        0.72 ±  4%  perf-profile.calltrace.cycles-pp.xfs_dir2_node_addname.xfs_dir_createname.xfs_create.xfs_generic_create.lookup_open
      1.74 ± 12%      -0.0        1.71 ± 16%  perf-profile.calltrace.cycles-pp.__libc_start_main
      1.74 ± 12%      -0.0        1.71 ± 16%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
      1.74 ± 12%      -0.0        1.71 ± 16%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      0.73 ±  4%      -0.0        0.70 ±  6%  perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      0.72 ±  7%      -0.0        0.68 ±  4%  perf-profile.calltrace.cycles-pp.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      0.72 ±  4%      -0.0        0.69 ±  6%  perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.iomap_write_iter.iomap_file_buffered_write
      1.69 ± 12%      -0.0        1.66 ± 17%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.cmd_sched.run_builtin.main
      1.69 ± 12%      -0.0        1.66 ± 17%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
      1.69 ± 12%      -0.0        1.66 ± 17%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
      0.71 ±  4%      -0.0        0.68 ±  5%  perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_irqsafe.__mem_cgroup_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.71 ±  4%      -0.0        0.68 ±  5%  perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush_irqsafe.__mem_cgroup_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
      0.64 ±  9%      -0.0        0.62 ±  5%  perf-profile.calltrace.cycles-pp.folio_end_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io
      0.71 ±  4%      -0.0        0.68 ±  6%  perf-profile.calltrace.cycles-pp.__mem_cgroup_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.iomap_write_iter
      0.95 ± 11%      -0.0        0.93 ±  9%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.48 ± 45%      -0.0        0.46 ± 45%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      1.23 ±  9%      -0.0        1.22 ±  6%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.79 ± 10%      +0.0        0.79 ±  4%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.85 ±  8%      +0.0        0.89 ±  6%  perf-profile.calltrace.cycles-pp.xlog_write.xlog_cil_push_work.process_one_work.worker_thread.kthread
      1.22 ±  9%      +0.0        1.26 ±  2%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.15 ±  8%      +0.0        1.20 ±  2%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle.do_idle
      0.52 ± 46%      +0.1        0.57 ± 44%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.cmd_sched.run_builtin
      0.46 ± 45%      +0.1        0.51 ± 45%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.46 ± 45%      +0.1        0.51 ± 45%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      1.11 ±  8%      +0.1        1.16 ±  2%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle
      0.47 ± 45%      +0.1        0.52 ± 45%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn
      0.46 ± 45%      +0.1        0.52 ± 45%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.47 ± 45%      +0.1        0.53 ± 45%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn.perf_mmap__push
      0.51 ± 46%      +0.1        0.56 ± 45%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.cmd_sched
      0.48 ± 45%      +0.1        0.54 ± 45%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.48 ± 45%      +0.1        0.53 ± 45%  perf-profile.calltrace.cycles-pp.__libc_write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      0.46 ± 45%      +0.1        0.52 ± 45%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.48 ± 45%      +0.1        0.54 ± 45%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.47 ± 45%      +0.1        0.52 ± 45%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen
      1.84 ±  8%      +0.1        1.90        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.82 ±  7%      +0.1        1.88        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.memcpy_erms.xlog_write.xlog_cil_push_work.process_one_work.worker_thread
      1.48 ±  7%      +0.1        1.58 ±  5%  perf-profile.calltrace.cycles-pp.xlog_cil_push_work.process_one_work.worker_thread.kthread.ret_from_fork
      1.34 ± 17%      +0.1        1.47 ± 28%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.2        0.17 ±141%  perf-profile.calltrace.cycles-pp.xfs_buf_unlock.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit.xfs_bmapi_convert_delalloc
      0.47 ± 44%      +0.2        0.71 ± 57%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.___down_common
      0.00            +0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit.xfs_bmapi_convert_delalloc.xfs_map_blocks
      0.00            +0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp._raw_spin_lock.xfs_extent_busy_trim.xfs_alloc_compute_aligned.xfs_alloc_cur_check.xfs_alloc_walk_iter
      0.75 ±  6%      +0.4        1.18 ±  4%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_bmapi_convert_delalloc.xfs_map_blocks.iomap_writepage_map
      0.80 ±  6%      +0.4        1.24 ±  4%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_bmapi_convert_delalloc.xfs_map_blocks.iomap_writepage_map.write_cache_pages
      0.00            +0.5        0.49 ±117%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +0.5        0.50 ±116%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.08 ±223%      +0.5        0.61 ± 90%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.08 ±223%      +0.5        0.61 ± 90%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.secondary_startup_64_no_verify
      0.08 ±223%      +0.5        0.61 ± 90%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.08 ±223%      +0.5        0.61 ± 90%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.secondary_startup_64_no_verify
      0.08 ±223%      +0.5        0.61 ± 90%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.secondary_startup_64_no_verify
      0.00            +0.6        0.63 ±  5%  perf-profile.calltrace.cycles-pp.xfs_alloc_get_rec.xfs_alloc_cur_check.xfs_alloc_walk_iter.xfs_alloc_ag_vextent_near.xfs_alloc_ag_vextent
      0.00            +0.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.xfs_extent_busy_trim.xfs_alloc_compute_aligned.xfs_alloc_cur_check.xfs_alloc_walk_iter.xfs_alloc_ag_vextent_near
      1.02 ±  7%      +0.9        1.96 ±  4%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.___down_common.__down.down
      1.02 ±  8%      +0.9        1.96 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.___down_common.__down
      1.02 ±  8%      +0.9        1.97 ±  4%  perf-profile.calltrace.cycles-pp.schedule_timeout.___down_common.__down.down.xfs_buf_lock
      0.00            +1.0        0.96 ±  6%  perf-profile.calltrace.cycles-pp.xfs_alloc_compute_aligned.xfs_alloc_cur_check.xfs_alloc_walk_iter.xfs_alloc_ag_vextent_near.xfs_alloc_ag_vextent
      1.06 ±  7%      +1.0        2.02 ±  4%  perf-profile.calltrace.cycles-pp.__down.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      1.06 ±  7%      +1.0        2.02 ±  4%  perf-profile.calltrace.cycles-pp.___down_common.__down.down.xfs_buf_lock.xfs_buf_find_lock
      1.08 ±  7%      +1.0        2.07 ±  4%  perf-profile.calltrace.cycles-pp.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map
      1.08 ±  7%      +1.0        2.08 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map
      1.10 ±  7%      +1.0        2.10 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map
      0.00            +1.1        1.12 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agf
      0.00            +1.2        1.15 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agf.xfs_alloc_read_agf
      0.00            +1.2        1.16 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agf.xfs_alloc_read_agf.xfs_alloc_fix_freelist
      0.00            +1.2        1.20 ±  4%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agf.xfs_alloc_read_agf.xfs_alloc_fix_freelist.__xfs_alloc_vextent_this_ag
      0.00            +1.2        1.21 ±  4%  perf-profile.calltrace.cycles-pp.xfs_read_agf.xfs_alloc_read_agf.xfs_alloc_fix_freelist.__xfs_alloc_vextent_this_ag.xfs_alloc_vextent_iterate_ags
      0.00            +1.2        1.23 ±  4%  perf-profile.calltrace.cycles-pp.xfs_alloc_read_agf.xfs_alloc_fix_freelist.__xfs_alloc_vextent_this_ag.xfs_alloc_vextent_iterate_ags.xfs_alloc_vextent
      0.00            +1.4        1.42 ±  4%  perf-profile.calltrace.cycles-pp.xfs_alloc_fix_freelist.__xfs_alloc_vextent_this_ag.xfs_alloc_vextent_iterate_ags.xfs_alloc_vextent.xfs_bmap_btalloc
      0.00            +1.4        1.42 ±  4%  perf-profile.calltrace.cycles-pp.__xfs_alloc_vextent_this_ag.xfs_alloc_vextent_iterate_ags.xfs_alloc_vextent.xfs_bmap_btalloc.xfs_bmapi_allocate
     42.77 ±  7%      +1.5       44.26 ±  2%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     42.78 ±  7%      +1.5       44.28 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     19.36 ±  4%      +2.3       21.68 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
     19.34 ±  4%      +2.3       21.67 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     19.49 ±  4%      +2.3       21.82 ±  2%  perf-profile.calltrace.cycles-pp.fsync
     19.33 ±  4%      +2.3       21.66 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     19.31 ±  4%      +2.3       21.64 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
      0.00            +2.4        2.41 ±  3%  perf-profile.calltrace.cycles-pp.xfs_alloc_cur_check.xfs_alloc_walk_iter.xfs_alloc_ag_vextent_near.xfs_alloc_ag_vextent.xfs_alloc_vextent_iterate_ags
      1.17 ±  8%      +2.5        3.66 ±  4%  perf-profile.calltrace.cycles-pp.xfs_alloc_ag_vextent.xfs_alloc_vextent_iterate_ags.xfs_alloc_vextent.xfs_bmap_btalloc.xfs_bmapi_allocate
      1.02 ±  8%      +2.6        3.61 ±  4%  perf-profile.calltrace.cycles-pp.xfs_alloc_ag_vextent_near.xfs_alloc_ag_vextent.xfs_alloc_vextent_iterate_ags.xfs_alloc_vextent.xfs_bmap_btalloc
      0.00            +2.8        2.85 ±  4%  perf-profile.calltrace.cycles-pp.xfs_alloc_walk_iter.xfs_alloc_ag_vextent_near.xfs_alloc_ag_vextent.xfs_alloc_vextent_iterate_ags.xfs_alloc_vextent
      1.77 ±  6%      +3.5        5.29 ±  3%  perf-profile.calltrace.cycles-pp.xfs_bmapi_allocate.xfs_bmapi_convert_delalloc.xfs_map_blocks.iomap_writepage_map.write_cache_pages
      1.70 ±  7%      +3.5        5.23 ±  3%  perf-profile.calltrace.cycles-pp.xfs_bmap_btalloc.xfs_bmapi_allocate.xfs_bmapi_convert_delalloc.xfs_map_blocks.iomap_writepage_map
      1.56 ±  8%      +3.5        5.10 ±  3%  perf-profile.calltrace.cycles-pp.xfs_alloc_vextent.xfs_bmap_btalloc.xfs_bmapi_allocate.xfs_bmapi_convert_delalloc.xfs_map_blocks
      1.55 ±  8%      +3.5        5.09 ±  3%  perf-profile.calltrace.cycles-pp.xfs_alloc_vextent_iterate_ags.xfs_alloc_vextent.xfs_bmap_btalloc.xfs_bmapi_allocate.xfs_bmapi_convert_delalloc
      5.04 ±  4%      +3.7        8.74 ±  3%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.73 ±  5%      +3.9        7.64 ±  3%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fsync.do_syscall_64
      3.72 ±  5%      +3.9        7.64 ±  3%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fsync
      3.67 ±  5%      +3.9        7.59 ±  3%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      3.68 ±  5%      +3.9        7.61 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
      3.33 ±  5%      +4.0        7.29 ±  3%  perf-profile.calltrace.cycles-pp.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      3.34 ±  5%      +4.0        7.29 ±  3%  perf-profile.calltrace.cycles-pp.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      2.74 ±  5%      +4.0        6.70 ±  3%  perf-profile.calltrace.cycles-pp.xfs_bmapi_convert_delalloc.xfs_map_blocks.iomap_writepage_map.write_cache_pages.iomap_writepages
      3.06 ±  5%      +4.0        7.02 ±  3%  perf-profile.calltrace.cycles-pp.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages
      2.77 ±  5%      +4.0        6.74 ±  3%  perf-profile.calltrace.cycles-pp.xfs_map_blocks.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages
      2.82 ±112%      -1.6        1.17 ± 15%  perf-profile.children.cycles-pp.intel_idle_irq
     14.01 ±  3%      -1.4       12.65 ±  2%  perf-profile.children.cycles-pp.xfs_log_force_seq
      7.74 ± 27%      -1.4        6.38 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     58.43            -1.0       57.39        perf-profile.children.cycles-pp.start_secondary
      6.34 ±  7%      -0.9        5.40 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.33 ±  6%      -0.7        4.61 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      9.48 ±  4%      -0.7        8.77 ±  2%  perf-profile.children.cycles-pp.xlog_cil_force_seq
     55.71            -0.7       55.02        perf-profile.children.cycles-pp.cpuidle_idle_call
      4.46 ±  7%      -0.7        3.80 ±  5%  perf-profile.children.cycles-pp.remove_wait_queue
     58.80            -0.7       58.15        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     58.80            -0.7       58.15        perf-profile.children.cycles-pp.cpu_startup_entry
     58.79            -0.7       58.14        perf-profile.children.cycles-pp.do_idle
      4.36 ±  6%      -0.6        3.72 ±  5%  perf-profile.children.cycles-pp.xlog_wait_on_iclog
      7.47 ±  4%      -0.6        6.83 ±  3%  perf-profile.children.cycles-pp.open64
      7.42 ±  4%      -0.6        6.78 ±  3%  perf-profile.children.cycles-pp.__x64_sys_openat
      7.42 ±  4%      -0.6        6.78 ±  3%  perf-profile.children.cycles-pp.do_sys_openat2
      7.34 ±  4%      -0.6        6.71 ±  3%  perf-profile.children.cycles-pp.do_filp_open
      7.33 ±  4%      -0.6        6.71 ±  3%  perf-profile.children.cycles-pp.path_openat
      6.99 ±  4%      -0.6        6.38 ±  3%  perf-profile.children.cycles-pp.open_last_lookups
     53.70 ±  2%      -0.6       53.11        perf-profile.children.cycles-pp.cpuidle_enter
      6.90 ±  4%      -0.6        6.31 ±  3%  perf-profile.children.cycles-pp.lookup_open
     53.67 ±  2%      -0.6       53.09        perf-profile.children.cycles-pp.cpuidle_enter_state
      7.83 ±  4%      -0.5        7.34 ±  2%  perf-profile.children.cycles-pp.xlog_cil_push_now
      6.11 ±  4%      -0.5        5.63 ±  3%  perf-profile.children.cycles-pp.xfs_generic_create
      7.54 ±  4%      -0.5        7.07 ±  2%  perf-profile.children.cycles-pp.__flush_workqueue
      5.98 ±  4%      -0.5        5.52 ±  4%  perf-profile.children.cycles-pp.xfs_create
      5.88 ±  2%      -0.4        5.47 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.36 ±  9%      -0.4        3.00 ±  8%  perf-profile.children.cycles-pp.write
      3.25 ±  9%      -0.4        2.88 ±  9%  perf-profile.children.cycles-pp.xfs_file_buffered_write
      3.16 ±  9%      -0.4        2.81 ±  9%  perf-profile.children.cycles-pp.iomap_file_buffered_write
      2.97 ± 10%      -0.3        2.63 ±  9%  perf-profile.children.cycles-pp.iomap_write_iter
      5.78 ±  3%      -0.3        5.48 ±  2%  perf-profile.children.cycles-pp.kthread
      5.78 ±  3%      -0.3        5.48 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      3.84 ±  8%      -0.3        3.55 ±  6%  perf-profile.children.cycles-pp.ksys_write
      2.34 ± 26%      -0.3        2.05 ±  5%  perf-profile.children.cycles-pp.record__finish_output
      2.34 ± 26%      -0.3        2.05 ±  5%  perf-profile.children.cycles-pp.perf_session__process_events
      2.34 ± 26%      -0.3        2.05 ±  5%  perf-profile.children.cycles-pp.reader__read_event
      3.82 ±  9%      -0.3        3.53 ±  6%  perf-profile.children.cycles-pp.vfs_write
      5.52 ±  2%      -0.3        5.25 ±  2%  perf-profile.children.cycles-pp.worker_thread
      1.89 ±  7%      -0.3        1.64 ±  3%  perf-profile.children.cycles-pp.__wait_for_common
      1.47 ± 18%      -0.2        1.22 ± 15%  perf-profile.children.cycles-pp.iomap_write_end
      1.34 ± 20%      -0.2        1.10 ± 17%  perf-profile.children.cycles-pp.filemap_dirty_folio
      1.20 ± 23%      -0.2        0.97 ± 19%  perf-profile.children.cycles-pp.locked_inode_to_wb_and_lock_list
      1.22 ± 22%      -0.2        1.00 ± 18%  perf-profile.children.cycles-pp.__mark_inode_dirty
      1.34 ± 29%      -0.2        1.12 ±  9%  perf-profile.children.cycles-pp.process_simple
      1.27 ± 29%      -0.2        1.06 ±  9%  perf-profile.children.cycles-pp.ordered_events__queue
     45.78 ±  2%      -0.2       45.57 ±  2%  perf-profile.children.cycles-pp.mwait_idle_with_hints
      1.25 ± 29%      -0.2        1.04 ±  9%  perf-profile.children.cycles-pp.queue_event
      1.28 ±  5%      -0.2        1.08 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      3.08 ± 15%      -0.2        2.88 ±  7%  perf-profile.children.cycles-pp.__cmd_record
      4.05 ±  2%      -0.2        3.86 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.20 ±  5%      -0.2        1.00 ±  3%  perf-profile.children.cycles-pp.folio_wait_bit_common
      1.21 ±  5%      -0.2        1.02 ±  3%  perf-profile.children.cycles-pp.folio_wait_writeback
      4.00 ±  2%      -0.2        3.82 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.13 ±  5%      -0.2        0.94 ±  3%  perf-profile.children.cycles-pp.io_schedule
      4.63 ±  3%      -0.2        4.46 ±  2%  perf-profile.children.cycles-pp.process_one_work
      1.14 ±  2%      -0.2        0.98 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
      2.26 ±  5%      -0.1        2.12 ±  5%  perf-profile.children.cycles-pp.xfs_dialloc
      0.97 ±  2%      -0.1        0.83 ±  5%  perf-profile.children.cycles-pp.__do_softirq
      0.55 ± 66%      -0.1        0.41 ±  7%  perf-profile.children.cycles-pp.poll_idle
      0.70 ±  6%      -0.1        0.57 ±  4%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.61 ± 10%      -0.1        0.48 ±  6%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      4.56 ±  6%      -0.1        4.43 ±  2%  perf-profile.children.cycles-pp.__mutex_lock
      1.68 ± 11%      -0.1        1.56 ±  7%  perf-profile.children.cycles-pp.ktime_get
      1.48 ±  7%      -0.1        1.38 ±  5%  perf-profile.children.cycles-pp.xfs_end_io
      1.47 ±  7%      -0.1        1.37 ±  5%  perf-profile.children.cycles-pp.xfs_end_ioend
      0.85 ±  5%      -0.1        0.75 ±  7%  perf-profile.children.cycles-pp.xfs_dialloc_ag
      1.19 ±  6%      -0.1        1.09 ±  3%  perf-profile.children.cycles-pp.xlog_ioend_work
      0.52 ± 10%      -0.1        0.43 ±  8%  perf-profile.children.cycles-pp.xfs_lookup
      0.52 ± 11%      -0.1        0.42 ±  9%  perf-profile.children.cycles-pp.xfs_dir_lookup
      0.82 ±  7%      -0.1        0.73 ±  5%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.56 ±  9%      -0.1        0.47 ±  7%  perf-profile.children.cycles-pp.xfs_vn_lookup
      2.17 ±  2%      -0.1        2.08 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.42 ± 16%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.xfs_dir2_node_lookup
      1.10 ±  6%      -0.1        1.02 ±  2%  perf-profile.children.cycles-pp.xlog_state_do_iclog_callbacks
      1.11 ±  6%      -0.1        1.02 ±  3%  perf-profile.children.cycles-pp.xlog_state_do_callback
      0.08 ± 21%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_alloc_ag_vextent_size
      1.66 ±  4%      -0.1        1.58 ±  8%  perf-profile.children.cycles-pp.menu_select
      1.67 ±  4%      -0.1        1.59 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      1.24 ±  7%      -0.1        1.16 ±  6%  perf-profile.children.cycles-pp.xfs_ialloc_read_agi
      1.23 ±  7%      -0.1        1.15 ±  6%  perf-profile.children.cycles-pp.xfs_read_agi
      0.99 ±  8%      -0.1        0.90 ±  5%  perf-profile.children.cycles-pp.common_interrupt
      0.94 ±  8%      -0.1        0.86 ±  5%  perf-profile.children.cycles-pp.handle_edge_irq
      1.00 ±  8%      -0.1        0.92 ±  5%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.80 ±  8%      -0.1        0.72 ±  6%  perf-profile.children.cycles-pp.blk_mq_end_request_batch
      0.89 ±  7%      -0.1        0.81 ±  5%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.88 ±  7%      -0.1        0.81 ±  6%  perf-profile.children.cycles-pp.nvme_irq
      0.94 ±  8%      -0.1        0.87 ±  5%  perf-profile.children.cycles-pp.__common_interrupt
      0.91 ±  8%      -0.1        0.83 ±  5%  perf-profile.children.cycles-pp.handle_irq_event
      0.70 ± 10%      -0.1        0.62 ±  7%  perf-profile.children.cycles-pp.load_balance
      0.71 ±  8%      -0.1        0.63 ±  6%  perf-profile.children.cycles-pp.__queue_work
      0.56 ±  8%      -0.1        0.49 ±  3%  perf-profile.children.cycles-pp.xfs_end_bio
      0.60 ± 11%      -0.1        0.53 ±  6%  perf-profile.children.cycles-pp.find_busiest_group
      0.71 ±  8%      -0.1        0.64 ±  6%  perf-profile.children.cycles-pp.queue_work_on
      1.24 ±  3%      -0.1        1.18 ±  4%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.58 ± 11%      -0.1        0.51 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.74 ±  9%      -0.1        0.67 ±  8%  perf-profile.children.cycles-pp.xfs_iomap_write_unwritten
      0.20 ± 12%      -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.xfs_perag_get
      0.88 ± 23%      -0.1        0.82 ±  5%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.77 ± 14%      -0.1        0.71 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.88 ± 23%      -0.1        0.82 ±  5%  perf-profile.children.cycles-pp.perf_session__process_user_event
      1.38 ±  8%      -0.1        1.32 ±  6%  perf-profile.children.cycles-pp.clockevents_program_event
      0.86 ± 23%      -0.1        0.80 ±  5%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.59 ±  8%      -0.1        0.54 ±  5%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.52 ±  5%      -0.1        0.46 ±  4%  perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.58 ± 15%      -0.1        0.52 ±  8%  perf-profile.children.cycles-pp.newidle_balance
      0.34 ± 23%      -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.dso__load
      1.36 ±  4%      -0.1        1.30 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      1.71 ±  4%      -0.1        1.66 ±  3%  perf-profile.children.cycles-pp.__unwind_start
      1.32 ±  4%      -0.1        1.26 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.34 ± 23%      -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.__dso__load_kallsyms
      0.30 ±  5%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.34 ± 23%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.map__load
      0.50 ± 12%      -0.0        0.45 ±  6%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.77 ±  5%      -0.0        0.72 ±  5%  perf-profile.children.cycles-pp.complete
      0.69 ±  7%      -0.0        0.64 ±  6%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.50 ±  4%      -0.0        0.45 ±  5%  perf-profile.children.cycles-pp.iomap_write_begin
      0.37 ±  5%      -0.0        0.32 ±  7%  perf-profile.children.cycles-pp.rebalance_domains
      0.41 ±  8%      -0.0        0.36 ±  5%  perf-profile.children.cycles-pp.xlog_state_clean_iclog
      0.28 ± 22%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.kallsyms__parse
      0.04 ± 45%      -0.0        0.00        perf-profile.children.cycles-pp.__d_lookup
      0.11 ± 69%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.48 ±  5%      -0.0        0.44 ±  5%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.36 ± 11%      -0.0        0.32 ± 10%  perf-profile.children.cycles-pp.xfs_dialloc_ag_update_inobt
      0.22 ± 24%      -0.0        0.18 ± 15%  perf-profile.children.cycles-pp.tick_irq_enter
      0.24 ± 24%      -0.0        0.19 ± 14%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.67 ±  8%      -0.0        0.63 ±  3%  perf-profile.children.cycles-pp.xlog_cil_process_committed
      0.67 ±  8%      -0.0        0.63 ±  3%  perf-profile.children.cycles-pp.xlog_cil_committed
      0.36 ± 22%      -0.0        0.32 ±  4%  perf-profile.children.cycles-pp.thread__find_map
      0.84 ±  7%      -0.0        0.80 ±  3%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.65 ±  4%      -0.0        0.61 ±  6%  perf-profile.children.cycles-pp.flush_workqueue_prep_pwqs
      0.21 ± 18%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.wb_workfn
      0.21 ± 18%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.wb_do_writeback
      0.21 ± 18%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.wb_writeback
      0.98 ±  5%      -0.0        0.94 ±  6%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.17 ± 13%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.xfs_trans_log_buf
      0.06 ± 47%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.xfs_buf_offset
      0.05 ± 82%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_trans_buf_set_type
      0.62 ±  5%      -0.0        0.58 ±  3%  perf-profile.children.cycles-pp.xfs_init_new_inode
      0.59 ±  9%      -0.0        0.55 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.33 ± 14%      -0.0        0.29 ±  5%  perf-profile.children.cycles-pp.iomap_submit_ioend
      0.71 ±  7%      -0.0        0.67 ±  4%  perf-profile.children.cycles-pp.iomap_finish_ioend
      0.41 ± 22%      -0.0        0.38 ±  5%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.22 ±  9%      -0.0        0.19 ± 14%  perf-profile.children.cycles-pp.dput
      0.22 ± 13%      -0.0        0.18 ±  7%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.16 ± 14%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.xfs_trans_dirty_buf
      0.05 ± 45%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.06 ±  8%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.xfs_file_write_checks
      0.48 ± 10%      -0.0        0.45 ±  4%  perf-profile.children.cycles-pp.xfs_trans_committed_bulk
      0.07 ± 15%      -0.0        0.04 ±104%  perf-profile.children.cycles-pp.try_to_unlazy
      0.35 ±  5%      -0.0        0.32 ±  6%  perf-profile.children.cycles-pp.mkdir
      1.74 ± 12%      -0.0        1.71 ± 16%  perf-profile.children.cycles-pp.__libc_start_main
      1.74 ± 12%      -0.0        1.71 ± 16%  perf-profile.children.cycles-pp.main
      1.74 ± 12%      -0.0        1.71 ± 16%  perf-profile.children.cycles-pp.run_builtin
      0.73 ±  4%      -0.0        0.70 ±  6%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.72 ±  7%      -0.0        0.68 ±  4%  perf-profile.children.cycles-pp.iomap_finish_ioends
      0.41 ±  8%      -0.0        0.38 ±  9%  perf-profile.children.cycles-pp.__close
      0.38 ±  8%      -0.0        0.35 ±  8%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.28 ±  7%      -0.0        0.25 ± 13%  perf-profile.children.cycles-pp.xfs_dialloc_ag_finobt_near
      0.16 ± 19%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      0.16 ± 19%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.writeback_sb_inodes
      1.69 ± 12%      -0.0        1.66 ± 17%  perf-profile.children.cycles-pp.cmd_record
      0.75 ±  7%      -0.0        0.72 ±  4%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.72 ±  4%      -0.0        0.69 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      1.69 ± 12%      -0.0        1.66 ± 17%  perf-profile.children.cycles-pp.cmd_sched
      0.67 ±  4%      -0.0        0.64 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.36 ±  9%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.71 ±  4%      -0.0        0.68 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_flush_irqsafe
      0.71 ±  4%      -0.0        0.68 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.32 ±  6%      -0.0        0.29 ±  6%  perf-profile.children.cycles-pp.__x64_sys_mkdir
      0.78 ±  4%      -0.0        0.74 ±  5%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.39 ±  8%      -0.0        0.36 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.23 ± 11%      -0.0        0.20 ± 11%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.22 ± 14%      -0.0        0.19 ±  8%  perf-profile.children.cycles-pp.ksys_read
      0.22 ± 14%      -0.0        0.19 ±  8%  perf-profile.children.cycles-pp.vfs_read
      0.15 ± 20%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.__libc_read
      0.03 ±101%      -0.0        0.00        perf-profile.children.cycles-pp._xfs_buf_ioapply
      0.14 ± 15%      -0.0        0.11 ± 18%  perf-profile.children.cycles-pp.list_lru_add
      0.44 ±  6%      -0.0        0.41 ±  6%  perf-profile.children.cycles-pp.exc_page_fault
      3.66 ±  7%      -0.0        3.63 ±  3%  perf-profile.children.cycles-pp.osq_lock
      0.34 ± 10%      -0.0        0.31 ±  9%  perf-profile.children.cycles-pp.task_work_run
      0.14 ± 16%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.xfs_trans_buf_item_match
      0.14 ± 14%      -0.0        0.12 ± 19%  perf-profile.children.cycles-pp.d_lru_add
      0.13 ±  7%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.note_gp_changes
      0.08 ± 17%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.xlog_state_done_syncing
      0.06 ± 13%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.06 ± 13%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.do_execveat_common
      0.03 ±100%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_mod_freecounter
      0.64 ±  9%      -0.0        0.62 ±  5%  perf-profile.children.cycles-pp.folio_end_writeback
      0.71 ±  4%      -0.0        0.68 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_flush_stats
      0.45 ± 11%      -0.0        0.42 ±  9%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.20 ± 36%      -0.0        0.17 ± 22%  perf-profile.children.cycles-pp.xfsaild_push
      0.20 ± 36%      -0.0        0.17 ± 22%  perf-profile.children.cycles-pp.xfsaild
      0.27 ± 10%      -0.0        0.24 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.24 ± 11%      -0.0        0.21 ±  7%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.23 ±  7%      -0.0        0.20 ± 16%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.33 ±  3%      -0.0        0.30 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.17 ± 25%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.io__get_hex
      0.04 ±101%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.03 ±100%      -0.0        0.00        perf-profile.children.cycles-pp.get_stack_info
      0.04 ± 45%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.submit_bio_wait
      0.04 ± 71%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.32 ± 21%      -0.0        0.30 ± 11%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.48 ±  6%      -0.0        0.45 ±  5%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.13 ±  4%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.kmem_cache_free
      0.12 ± 22%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.proc_reg_read
      0.13 ± 16%      -0.0        0.10 ± 15%  perf-profile.children.cycles-pp.random
      0.02 ± 99%      -0.0        0.00        perf-profile.children.cycles-pp.pick_next_task_idle
      0.15 ± 12%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.__might_resched
      0.13 ± 10%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.xfs_dir3_data_read
      0.51 ±  4%      -0.0        0.48 ±  3%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.19 ± 13%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.iomap_iter
      0.15 ± 10%      -0.0        0.13 ± 11%  perf-profile.children.cycles-pp.xfs_inode_to_log_dinode
      0.06 ± 46%      -0.0        0.03 ±106%  perf-profile.children.cycles-pp.__legitimize_path
      0.06 ± 13%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.d_lookup
      0.08 ± 13%      -0.0        0.06 ± 46%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.08 ± 13%      -0.0        0.06 ± 46%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.08 ± 13%      -0.0        0.06 ± 46%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.08 ± 13%      -0.0        0.06 ± 46%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.07 ± 10%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.36 ±  8%      -0.0        0.33 ±  5%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      0.29 ± 10%      -0.0        0.27 ± 10%  perf-profile.children.cycles-pp.__fput
      0.28 ±  8%      -0.0        0.25 ±  7%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.19 ±  9%      -0.0        0.17 ± 16%  perf-profile.children.cycles-pp.handle_mm_fault
      0.20 ± 19%      -0.0        0.18 ± 23%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.86 ±  5%      -0.0        0.84 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.24 ± 13%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.xfs_iget_cache_miss
      0.18 ±  7%      -0.0        0.16 ± 12%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.14 ± 21%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.seq_read
      0.17 ±  7%      -0.0        0.15 ± 10%  perf-profile.children.cycles-pp.link_path_walk
      0.16 ± 18%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.seq_read_iter
      0.09 ± 18%      -0.0        0.07 ± 20%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.09 ± 18%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.03 ±101%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__xfs_buf_submit
      0.05 ± 47%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.map__process_kallsym_symbol
      0.22 ± 22%      -0.0        0.19 ± 23%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.59 ±  6%      -0.0        0.56 ±  4%  perf-profile.children.cycles-pp.perf_output_copy
      0.35 ±  9%      -0.0        0.33 ± 10%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.26 ± 14%      -0.0        0.24 ±  7%  perf-profile.children.cycles-pp.read_tsc
      0.18 ±  9%      -0.0        0.16 ± 10%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.11 ±  6%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.xfs_btree_update
      0.08 ± 11%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.xfs_inobt_update
      0.06 ± 11%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.terminate_walk
      0.06 ±  7%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xas_find_marked
      0.05 ± 46%      -0.0        0.03 ±103%  perf-profile.children.cycles-pp.xfs_trans_precommit_sort
      0.05 ± 46%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.xlog_state_get_iclog_space
      0.06 ± 13%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.execve
      0.29 ±  7%      -0.0        0.27 ±  8%  perf-profile.children.cycles-pp.filemap_add_folio
      0.25 ±  5%      -0.0        0.23 ±  8%  perf-profile.children.cycles-pp.do_mkdirat
      0.76 ±  5%      -0.0        0.74 ±  3%  perf-profile.children.cycles-pp.__output_copy
      0.35 ± 10%      -0.0        0.33 ±  6%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.16 ± 19%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.xfs_perag_put
      0.19 ±  9%      -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.xfs_trans_alloc_inode
      0.15 ± 12%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.path_parentat
      0.15 ± 10%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.xfs_bmapi_read
      0.15 ± 21%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.folio_alloc
      0.11 ± 17%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.__writeback_single_inode
      0.05 ± 46%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_hole_delay
      0.04 ± 71%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.xfs_dir2_leaf_search_hash
      0.05 ± 46%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.xfs_btree_insrec
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.queue_io
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.move_expired_inodes
      0.10 ± 22%      -0.0        0.08 ± 21%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.10 ± 22%      -0.0        0.08 ± 21%  perf-profile.children.cycles-pp.drm_fbdev_fb_dirty
      0.42 ±  6%      -0.0        0.41 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.23 ±  5%      -0.0        0.21 ±  6%  perf-profile.children.cycles-pp.filename_create
      0.16 ± 11%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.xfs_dabuf_map
      0.30 ±  8%      -0.0        0.28 ±  8%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.26 ±  8%      -0.0        0.25 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.13 ± 37%      -0.0        0.12 ± 20%  perf-profile.children.cycles-pp.xfs_inode_item_push
      0.07 ± 16%      -0.0        0.06 ± 47%  perf-profile.children.cycles-pp.xfs_buf_item_size_segment
      0.04 ± 71%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp._find_next_and_bit
      0.07 ±  9%      -0.0        0.06 ± 48%  perf-profile.children.cycles-pp.charge_memcg
      0.07 ± 17%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xfs_perag_grab
      0.02 ± 99%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.sb_mark_inode_writeback
      0.05 ± 45%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.blkdev_issue_flush
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_trans_get_buf_map
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_btree_log_recs
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.bad_get_user
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.security_file_open
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_alloc_update_counters
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_alloc_log_agf
      0.32 ± 13%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.xfs_iget
      0.32 ± 12%      -0.0        0.30 ±  6%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.15 ± 13%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.xfs_buf_item_unpin
      0.13 ± 14%      -0.0        0.11 ± 20%  perf-profile.children.cycles-pp.setup_file_name
      0.11 ± 12%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.08 ± 10%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_btree_insert
      0.04 ± 73%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.xfs_buf_delwri_submit_buffers
      0.14 ± 14%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.xfs_trans_ail_update_bulk
      0.92 ±  6%      -0.0        0.90 ±  4%  perf-profile.children.cycles-pp.__wake_up_common
      0.37 ±  7%      -0.0        0.36 ±  9%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.25 ±  8%      -0.0        0.24 ±  7%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.10 ± 18%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.trigger_load_balance
      0.06 ± 11%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.kmem_alloc
      0.14 ±  9%      -0.0        0.12 ± 19%  perf-profile.children.cycles-pp.down_read
      0.09 ± 37%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.rmqueue
      0.09 ± 15%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.xfs_bmap_btalloc_select_lengths
      0.08 ± 10%      -0.0        0.06 ± 46%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.19 ± 15%      -0.0        0.17 ± 17%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.28 ± 14%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.36 ±  7%      -0.0        0.35 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.11 ±  8%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.18 ± 22%      -0.0        0.17 ±  9%  perf-profile.children.cycles-pp.__alloc_pages
      0.14 ± 10%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.xfs_trans_alloc_icreate
      0.14 ±  7%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.d_alloc
      0.15 ± 10%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.13 ± 14%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.xfs_imap_to_bp
      0.10 ±  8%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.13 ± 38%      -0.0        0.11 ± 19%  perf-profile.children.cycles-pp.xfs_iflush_cluster
      0.08 ± 24%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.s_show
      0.08 ± 13%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.do_dentry_open
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.irqentry_enter
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.inode_init_always
      0.12 ± 13%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.10 ± 15%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.08 ±  8%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.xfs_btree_del_cursor
      0.08 ± 13%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.commit_tail
      0.08 ± 13%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.16 ± 12%      -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.filename_parentat
      0.11 ± 14%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.do_open
      0.08 ± 20%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.xfs_btree_delete
      0.03 ±102%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp._atomic_dec_and_lock
      0.03 ±102%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.xfs_bmapi_convert_unwritten
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.s_next
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.ct_nmi_enter
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_env__arch
      0.07 ± 10%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.07 ± 18%      -0.0        0.06 ± 47%  perf-profile.children.cycles-pp.rcu_do_batch
      0.06 ± 19%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.walk_component
      0.04 ± 71%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.mod_objcg_state
      0.29 ±  6%      -0.0        0.28 ±  7%  perf-profile.children.cycles-pp.xfs_cil_prepare_item
      0.16 ± 14%      -0.0        0.14 ± 15%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.10 ± 23%      -0.0        0.09 ± 20%  perf-profile.children.cycles-pp.delay_tsc
      0.10 ± 12%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.08 ± 20%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.08 ± 20%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.08 ± 20%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.08 ± 11%      -0.0        0.07 ± 46%  perf-profile.children.cycles-pp.xlog_ticket_alloc
      0.07 ± 10%      -0.0        0.06 ± 25%  perf-profile.children.cycles-pp.strncpy_from_user
      0.27 ±  8%      -0.0        0.26 ±  9%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.18 ± 15%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.xfs_inode_alloc
      0.18 ±  3%      -0.0        0.17 ± 10%  perf-profile.children.cycles-pp.___slab_alloc
      0.16 ± 11%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.12 ± 12%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.blk_mq_get_new_requests
      0.09 ± 15%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.09 ±  5%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.__might_sleep
      0.07 ±  9%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.03 ±100%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_btree_dup_cursor
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.pipe_read
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.map_id_range_down
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.make_kuid
      0.04 ±105%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.machines__deliver_event
      0.04 ± 71%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.menu_reflect
      0.04 ± 71%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.rb_next
      0.11 ± 16%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.memset_erms
      0.08 ± 11%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.clear_page_erms
      0.08 ± 20%      -0.0        0.07 ± 20%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.07 ± 16%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.10 ± 10%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.26 ±  7%      -0.0        0.25 ±  8%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.18 ±  8%      -0.0        0.17 ±  9%  perf-profile.children.cycles-pp.perf_rotate_context
      0.12 ± 10%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.___perf_sw_event
      0.10 ± 16%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.getname_flags
      0.10 ± 10%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.iomap_add_to_ioend
      0.06 ± 21%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.lru_add_fn
      0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.do_read_fault
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__entry_text_start
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_ialloc_inode_init
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.send_call_function_single_ipi
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_event_task_tick
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xlog_prepare_iovec
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.release_pages
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_bmap_longest_free_extent
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__do_sys_newstat
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__d_lookup_rcu
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__count_memcg_events
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp._find_next_bit
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_dir2_data_use_free
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_output_end
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.inode_sb_list_add
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_setup_inode
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_inobt_init_key_from_rec
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.do_anonymous_page
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_inode_item_format_data_fork
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_gp_kthread
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.random@plt
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_alloc_vextent_this_ag
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.apparmor_file_open
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.step_into
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__bio_split_to_limits
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_da_state_alloc
      0.16 ± 11%      -0.0        0.15 ± 12%  perf-profile.children.cycles-pp.__pagevec_release
      0.14 ± 12%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.__list_add_valid
      0.14 ±  7%      -0.0        0.13 ± 11%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.14 ± 14%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.15 ±  9%      -0.0        0.14 ± 11%  perf-profile.children.cycles-pp.__slab_free
      0.13 ± 10%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.xfs_dir2_node_find_freeblk
      0.13 ± 14%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.idle_cpu
      0.11 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.08 ± 16%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.xas_alloc
      0.06 ± 48%      -0.0        0.05 ± 49%  perf-profile.children.cycles-pp.xfs_buf_inode_iodone
      0.08 ± 11%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.error_entry
      0.08 ± 17%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.08 ± 27%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.vsnprintf
      0.08 ± 24%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.seq_printf
      0.06 ± 48%      -0.0        0.05 ± 72%  perf-profile.children.cycles-pp.xfs_buf_item_put
      0.04 ± 44%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.read_counters
      0.06 ±  8%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.mempool_alloc
      0.12 ± 10%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.set_next_entity
      0.92 ±  5%      -0.0        0.92 ±  2%  perf-profile.children.cycles-pp.perf_output_sample
      0.48 ±  7%      -0.0        0.48 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.32 ± 25%      -0.0        0.32 ± 12%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.20 ±  9%      -0.0        0.19 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.23 ±  5%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.xfs_buf_rele
      0.14 ±  5%      -0.0        0.14 ± 13%  perf-profile.children.cycles-pp.xlog_sync
      0.14 ± 28%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.08 ±  9%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.clear_huge_page
      0.07 ± 46%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.xfs_btree_delrec
      0.06 ± 11%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp._IO_default_xsputn
      0.05            -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_delay_real
      0.02 ± 99%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.lookup_fast
      0.10 ± 18%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.08 ± 14%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.check_cpu_stall
      0.07 ± 15%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.07 ±  9%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_release
      0.05 ±  8%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.xfs_fs_inode_init_once
      0.05 ± 47%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.down_write
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__check_object_size
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_alloc_update
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_iunlock
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.27 ±  9%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.30 ± 14%      -0.0        0.29 ± 13%  perf-profile.children.cycles-pp.irq_work_run_list
      0.12 ± 13%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.xas_store
      0.10 ± 13%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.24 ±  6%      -0.0        0.23 ±  9%  perf-profile.children.cycles-pp.xfs_buf_item_pin
      0.42 ± 11%      -0.0        0.41 ±  3%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.32 ±  6%      -0.0        0.32 ± 15%  perf-profile.children.cycles-pp.xlog_force_lsn
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.irq_work_single
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.irq_work_run
      0.29 ±  4%      -0.0        0.28 ±  7%  perf-profile.children.cycles-pp.__kmalloc
      0.17 ± 12%      -0.0        0.16 ± 12%  perf-profile.children.cycles-pp.update_blocked_averages
      0.20 ± 34%      -0.0        0.20 ± 25%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.14 ± 11%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.crc32c
      0.12 ±  7%      -0.0        0.12 ± 16%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.07 ± 48%      -0.0        0.06 ± 21%  perf-profile.children.cycles-pp.xfs_buf_ioend
      0.08 ± 22%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.08 ± 17%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.xfs_bmap_last_offset
      0.09 ±  9%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.08 ±  9%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
      0.02 ± 99%      -0.0        0.02 ±144%  perf-profile.children.cycles-pp.lockref_put_return
      0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.do_fault
      0.03 ±100%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.security_file_alloc
      0.06 ±  9%      -0.0        0.06 ± 47%  perf-profile.children.cycles-pp.xfs_inobt_init_common
      0.04 ± 44%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.cmd_stat
      0.04 ± 44%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.dispatch_events
      0.04 ± 44%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.process_interval
      0.08 ± 19%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.27 ± 16%      -0.0        0.26 ± 13%  perf-profile.children.cycles-pp.wait_for_lsr
      0.58 ± 10%      -0.0        0.58 ±  5%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp._printk
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.vprintk_emit
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.console_unlock
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.console_flush_all
      0.29 ± 15%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.console_emit_next_record
      0.24 ± 11%      -0.0        0.23 ± 13%  perf-profile.children.cycles-pp.task_tick_fair
      0.11 ± 12%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__d_alloc
      0.11 ± 15%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.__xfs_dir3_free_read
      0.07 ± 19%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.xfs_bmap_last_extent
      0.03 ±103%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.03 ±100%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.timerqueue_del
      0.17 ±  9%      -0.0        0.17 ± 14%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.11 ±  4%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.allocate_slab
      0.09 ± 17%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.xas_expand
      0.09 ± 17%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.07 ± 22%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.xlog_grant_push_threshold
      0.08 ± 10%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.08 ± 32%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.read
      0.05 ± 49%      -0.0        0.05 ± 73%  perf-profile.children.cycles-pp.xfs_inobt_init_cursor
      0.28 ± 16%      -0.0        0.27 ± 12%  perf-profile.children.cycles-pp.serial8250_console_write
      0.13 ± 16%      -0.0        0.13 ± 11%  perf-profile.children.cycles-pp.blk_mq_try_issue_directly
      0.11 ± 12%      -0.0        0.11 ± 16%  perf-profile.children.cycles-pp.update_cfs_group
      0.06 ± 58%      -0.0        0.06 ± 23%  perf-profile.children.cycles-pp.xfs_iflush
      0.03 ±102%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.io__get_char
      0.02 ±142%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.xfs_iext_last
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.rq_qos_wait
      0.10 ± 15%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.xas_create
      0.09 ±  7%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.shuffle_freelist
      0.08 ± 20%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.xlog_grant_push_ail
      0.06 ±  7%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.timerqueue_add
      0.07 ±  8%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.random_r
      0.20 ± 10%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.16 ± 16%      -0.0        0.15 ± 15%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.14 ± 17%      -0.0        0.14 ± 16%  perf-profile.children.cycles-pp.mutex_lock
      0.46 ±  9%      -0.0        0.46 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_fixup_trees
      0.38 ± 11%      +0.0        0.38 ±  6%  perf-profile.children.cycles-pp.folio_wake_bit
      0.35 ± 11%      +0.0        0.35 ±  7%  perf-profile.children.cycles-pp.wake_page_function
      0.20 ± 26%      +0.0        0.20 ± 12%  perf-profile.children.cycles-pp.evsel__parse_sample
      0.18 ±  4%      +0.0        0.18 ± 10%  perf-profile.children.cycles-pp.select_task_rq
      0.13 ± 15%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.__blk_mq_try_issue_directly
      0.12 ± 14%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.bsearch
      0.08 ± 20%      +0.0        0.08 ± 15%  perf-profile.children.cycles-pp.xfs_allocbt_init_cursor
      0.09 ± 14%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.08 ± 13%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.08 ± 22%      +0.0        0.08        perf-profile.children.cycles-pp.wake_up_q
      0.04 ± 71%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.cpuacct_charge
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_trans_roll
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.xfs_bmapi_finish
      0.03 ± 70%      +0.0        0.03 ± 70%  perf-profile.children.cycles-pp.xas_load
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irqentry_exit
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.up_read
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.folio_add_lru
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_trans_ijoin
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_iext_insert
      0.09 ± 31%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.11 ± 12%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.xlog_cksum
      0.07 ± 10%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.07 ± 10%      +0.0        0.07 ± 21%  perf-profile.children.cycles-pp.kfree
      0.08 ± 13%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.04 ± 72%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.xfs_inode_item_committed
      0.16 ± 12%      +0.0        0.16 ±  9%  perf-profile.children.cycles-pp.fixup_exception
      0.13 ± 10%      +0.0        0.14 ± 19%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.12 ± 14%      +0.0        0.12 ± 11%  perf-profile.children.cycles-pp.__switch_to
      0.91 ±  8%      +0.0        0.91 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.28 ±  8%      +0.0        0.28 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.17 ± 14%      +0.0        0.17 ±  9%  perf-profile.children.cycles-pp.list_sort
      0.18 ± 12%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
      0.14 ±  7%      +0.0        0.14 ± 16%  perf-profile.children.cycles-pp.rcu_pending
      0.13 ± 12%      +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.search_exception_tables
      0.08 ±  6%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.setup_object
      0.12 ± 45%      +0.0        0.12 ± 31%  perf-profile.children.cycles-pp.fault_in_readable
      0.12 ± 16%      +0.0        0.12 ± 11%  perf-profile.children.cycles-pp.xfs_alloc_read_agfl
      0.10 ± 14%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.12 ± 17%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.nvme_queue_rq
      0.11 ±  8%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.__alloc_file
      0.10 ± 16%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.xfs_trans_brelse
      0.43 ±  7%      +0.0        0.44 ±  2%  perf-profile.children.cycles-pp.stack_access_ok
      0.18 ± 14%      +0.0        0.18 ±  9%  perf-profile.children.cycles-pp.prepare_task_switch
      0.14 ± 11%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.13 ± 13%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.14 ±  5%      +0.0        0.14 ± 22%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.07 ± 25%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.cmp_ex_search
      0.07 ± 28%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.nvme_prep_rq
      0.05 ± 46%      +0.0        0.05 ±  8%  perf-profile.children.cycles-pp.rb_insert_color
      0.06 ± 20%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.02 ±142%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.02 ±142%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.wbt_wait
      0.12 ± 45%      +0.0        0.12 ± 30%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.14 ±  7%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.14 ± 14%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.__switch_to_asm
      0.08 ±  7%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.available_idle_cpu
      0.06 ± 11%      +0.0        0.07 ± 13%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.07 ± 16%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.08 ± 13%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.12 ± 12%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.search_extable
      0.46 ± 10%      +0.0        0.46 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.44 ± 11%      +0.0        0.45 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.16 ± 19%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.13 ± 18%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.core_kernel_text
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.08 ± 11%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.wake_affine
      0.07 ± 47%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.llist_reverse_order
      0.08 ± 24%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.80 ±  9%      +0.0        0.81 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.26 ± 11%      +0.0        0.27 ± 13%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.36 ±  9%      +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.30 ±  5%      +0.0        0.31 ± 11%  perf-profile.children.cycles-pp.xlog_state_release_iclog
      0.16 ± 17%      +0.0        0.17 ± 13%  perf-profile.children.cycles-pp.io_serial_in
      0.11 ±  7%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.alloc_empty_file
      0.04 ± 45%      +0.0        0.05 ± 13%  perf-profile.children.cycles-pp.kvm_guest_state
      0.08 ± 21%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.rwsem_wake
      0.04 ± 72%      +0.0        0.05 ± 47%  perf-profile.children.cycles-pp.inode_permission
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.d_splice_alias
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.inode_init_once
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.memcpy
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.xlog_calc_unit_res
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__strncat_chk
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__mmput
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__up
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.in_gate_area_no_mm
      0.04 ± 71%      +0.0        0.04 ± 47%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.14 ± 14%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.01 ±223%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.get_cpu_device
      0.06 ± 50%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xlog_space_left
      0.02 ±141%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.rb_erase
      0.02 ±141%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.memmove
      0.07 ±  7%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.xfs_btree_ptr_to_daddr
      0.09 ±  4%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.ct_idle_exit
      0.05 ± 47%      +0.0        0.06 ± 17%  perf-profile.children.cycles-pp.xfs_trans_del_item
      0.06 ± 47%      +0.0        0.07 ± 18%  perf-profile.children.cycles-pp.shmem_write_end
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__ctype_b_loc
      0.21 ± 25%      +0.0        0.22 ± 14%  perf-profile.children.cycles-pp.finish_task_switch
      0.12 ± 23%      +0.0        0.13 ± 26%  perf-profile.children.cycles-pp.perf_poll
      0.25 ±  8%      +0.0        0.26 ±  9%  perf-profile.children.cycles-pp.xlog_write_get_more_iclog_space
      0.03 ±100%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.nvme_poll_cq
      0.03 ±101%      +0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xfs_dir2_isblock
      0.02 ±142%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.nvme_map_data
      0.42 ± 10%      +0.0        0.43 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.02 ± 99%      +0.0        0.04 ± 75%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      0.28 ± 11%      +0.0        0.30 ±  8%  perf-profile.children.cycles-pp.xlog_write_partial
      0.17 ± 25%      +0.0        0.18 ± 21%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.17 ± 25%      +0.0        0.18 ± 21%  perf-profile.children.cycles-pp.do_sys_poll
      0.39 ±  9%      +0.0        0.41 ±  5%  perf-profile.children.cycles-pp.xfs_dir2_node_addname_int
      0.16 ± 11%      +0.0        0.18 ± 16%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.13 ± 21%      +0.0        0.14 ± 15%  perf-profile.children.cycles-pp.shmem_write_begin
      0.13 ± 21%      +0.0        0.15 ± 16%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.14 ± 24%      +0.0        0.15 ± 23%  perf-profile.children.cycles-pp.do_poll
      0.04 ± 73%      +0.0        0.06 ± 19%  perf-profile.children.cycles-pp.xfs_allocbt_init_common
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.pwq_dec_nr_in_flight
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.perf_misc_flags
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.security_file_free
      0.02 ±142%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.xfs_iext_get_extent
      0.02 ±142%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.sched_setaffinity
      0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.d_instantiate
      0.17 ± 25%      +0.0        0.18 ± 22%  perf-profile.children.cycles-pp.__poll
      0.16 ± 13%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.xlog_cil_set_ctx_write_state
      0.12 ± 23%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.xfs_lookup_get_search_key
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.xfs_dir3_leaf_find_entry
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.__folio_alloc
      0.04 ± 71%      +0.0        0.06 ± 54%  perf-profile.children.cycles-pp.xfs_dir2_leafn_add
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.11 ± 12%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.11 ± 12%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.llist_add_batch
      0.16 ± 10%      +0.0        0.19 ±  5%  perf-profile.children.cycles-pp.xlog_cil_write_commit_record
      1.38 ±  2%      +0.0        1.41 ±  3%  perf-profile.children.cycles-pp.memcpy_erms
      0.23 ±  5%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.38 ± 17%      +0.0        0.40 ±  8%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.02 ±142%      +0.0        0.05 ± 45%  perf-profile.children.cycles-pp.get_callchain_entry
      0.39 ± 16%      +0.0        0.42 ±  9%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.26 ± 10%      +0.0        0.29 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_lookup_eq
      0.38 ± 16%      +0.0        0.41 ±  9%  perf-profile.children.cycles-pp.copyin
      0.00            +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.03 ±100%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.rcu_is_watching
      0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.89 ±  9%      +0.0        0.93 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.16 ± 11%      +0.0        0.20 ± 10%  perf-profile.children.cycles-pp.xfs_bmapi_write
      0.09 ± 14%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.xfs_ialloc_ag_alloc
      0.02 ±223%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_allocbt_init_key_from_rec
      0.92 ±  8%      +0.0        0.97 ±  4%  perf-profile.children.cycles-pp.perf_callchain_user
      0.42 ±  8%      +0.1        0.47 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_cur_finish
      1.88 ±  7%      +0.1        1.94        perf-profile.children.cycles-pp.schedule_idle
      1.02 ±  7%      +0.1        1.07 ±  5%  perf-profile.children.cycles-pp.xlog_write
      0.04 ± 73%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.xfs_dir2_node_add_datablk
      0.00            +0.1        0.06 ± 51%  perf-profile.children.cycles-pp.xfs_alloc_fix_len
      0.03 ±100%      +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.xfs_dir2_grow_inode
      0.03 ±100%      +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.xfs_da_grow_inode_int
      0.50 ± 26%      +0.1        0.56 ± 19%  perf-profile.children.cycles-pp.generic_perform_write
      0.55 ± 26%      +0.1        0.62 ± 20%  perf-profile.children.cycles-pp.perf_mmap__push
      0.56 ± 26%      +0.1        0.63 ± 19%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.52 ± 26%      +0.1        0.59 ± 19%  perf-profile.children.cycles-pp.__libc_write
      0.50 ± 26%      +0.1        0.57 ± 19%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.50 ± 26%      +0.1        0.57 ± 19%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.52 ± 26%      +0.1        0.59 ± 19%  perf-profile.children.cycles-pp.record__pushfn
      0.52 ± 26%      +0.1        0.59 ± 19%  perf-profile.children.cycles-pp.writen
      0.35 ± 17%      +0.1        0.43 ± 18%  perf-profile.children.cycles-pp.mod_find
      3.20 ±  4%      +0.1        3.29 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.33 ± 12%      +0.1        0.42 ± 17%  perf-profile.children.cycles-pp.is_module_text_address
      3.14 ±  4%      +0.1        3.23 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.xfs_btree_readahead
      1.48 ±  7%      +0.1        1.59 ±  5%  perf-profile.children.cycles-pp.xlog_cil_push_work
      3.13 ±  5%      +0.1        3.24 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.01 ±223%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.xfs_btree_rec_offset
      0.43 ± 16%      +0.1        0.54 ± 14%  perf-profile.children.cycles-pp.__module_address
      2.99 ±  9%      +0.1        3.11 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.65 ± 10%      +0.1        0.78 ± 10%  perf-profile.children.cycles-pp.kernel_text_address
      0.74 ±  8%      +0.1        0.88 ±  9%  perf-profile.children.cycles-pp.__kernel_text_address
      2.90 ±  5%      +0.1        3.04 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.81 ±  8%      +0.2        0.96 ±  8%  perf-profile.children.cycles-pp.unwind_get_return_address
      2.15 ±  6%      +0.2        2.31 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      3.07 ±  3%      +0.2        3.23 ±  3%  perf-profile.children.cycles-pp.xlog_cil_commit
      3.29 ±  2%      +0.2        3.45 ±  3%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.00            +0.2        0.21 ± 18%  perf-profile.children.cycles-pp.xfs_alloc_compute_diff
      2.84 ±  4%      +0.2        3.08        perf-profile.children.cycles-pp.try_to_wake_up
      1.60 ±  6%      +0.2        1.85 ±  3%  perf-profile.children.cycles-pp.__orc_find
      6.40 ±  5%      +0.3        6.66 ±  3%  perf-profile.children.cycles-pp.schedule
      0.00            +0.3        0.26 ±  6%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      3.32 ±  5%      +0.3        3.60 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      1.28 ±  9%      +0.3        1.58 ±  6%  perf-profile.children.cycles-pp.orc_find
      0.02 ±141%      +0.3        0.32 ± 11%  perf-profile.children.cycles-pp.xfs_btree_increment
      8.22 ±  5%      +0.3        8.55 ±  2%  perf-profile.children.cycles-pp.__schedule
      0.63 ± 11%      +0.4        0.99 ±  7%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.62 ± 10%      +0.4        0.98 ±  7%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.59 ±  6%      +0.4        0.96 ±  6%  perf-profile.children.cycles-pp.up
      4.12 ±  5%      +0.4        4.49 ±  2%  perf-profile.children.cycles-pp.unwind_next_frame
      0.38 ± 26%      +0.4        0.76 ± 53%  perf-profile.children.cycles-pp.start_kernel
      0.38 ± 26%      +0.4        0.76 ± 53%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.38 ± 26%      +0.4        0.76 ± 53%  perf-profile.children.cycles-pp.rest_init
      5.35 ±  5%      +0.5        5.89 ±  3%  perf-profile.children.cycles-pp.perf_callchain_kernel
      6.42 ±  5%      +0.6        7.00 ±  3%  perf-profile.children.cycles-pp.perf_callchain
      8.17 ±  5%      +0.6        8.76 ±  2%  perf-profile.children.cycles-pp.perf_tp_event
      6.40 ±  5%      +0.6        6.99 ±  3%  perf-profile.children.cycles-pp.get_perf_callchain
      0.08 ± 21%      +0.6        0.67 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_get_rec
      6.76 ±  5%      +0.6        7.36 ±  3%  perf-profile.children.cycles-pp.perf_prepare_sample
      7.88 ±  5%      +0.6        8.48 ±  2%  perf-profile.children.cycles-pp.perf_event_output_forward
      7.93 ±  5%      +0.6        8.53 ±  2%  perf-profile.children.cycles-pp.__perf_event_overflow
      2.89 ±  6%      +0.7        3.58 ±  3%  perf-profile.children.cycles-pp.schedule_timeout
      0.08 ± 14%      +0.7        0.80 ±  9%  perf-profile.children.cycles-pp.xfs_extent_busy_trim
      2.75 ±  6%      +0.8        3.56 ±  4%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      2.14 ±  6%      +0.8        2.99 ±  4%  perf-profile.children.cycles-pp.xfs_buf_get_map
      2.15 ±  6%      +0.8        3.00 ±  4%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.10 ± 11%      +0.9        1.00 ±  6%  perf-profile.children.cycles-pp.xfs_alloc_compute_aligned
      1.72 ±  7%      +0.9        2.66 ±  4%  perf-profile.children.cycles-pp.xfs_buf_lookup
      1.10 ±  7%      +1.0        2.06 ±  4%  perf-profile.children.cycles-pp.___down_common
      1.10 ±  7%      +1.0        2.06 ±  4%  perf-profile.children.cycles-pp.__down
      1.32 ±  7%      +1.0        2.28 ±  3%  perf-profile.children.cycles-pp.xfs_buf_find_lock
      1.19 ±  7%      +1.0        2.18 ±  4%  perf-profile.children.cycles-pp.down
      1.24 ±  7%      +1.0        2.23 ±  4%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.19 ±  9%      +1.1        1.25 ±  4%  perf-profile.children.cycles-pp.xfs_read_agf
      0.20 ± 10%      +1.1        1.26 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_read_agf
      0.38 ± 11%      +1.1        1.46 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_fix_freelist
     31.98 ±  4%      +1.3       33.30 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     31.95 ±  4%      +1.3       33.28 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     42.99 ±  7%      +1.4       44.41 ±  2%  perf-profile.children.cycles-pp.intel_idle
      0.00            +1.5        1.46 ±  4%  perf-profile.children.cycles-pp.__xfs_alloc_vextent_this_ag
      0.29 ± 14%      +2.3        2.54 ±  3%  perf-profile.children.cycles-pp.xfs_alloc_cur_check
     19.33 ±  4%      +2.3       21.66 ±  2%  perf-profile.children.cycles-pp.__x64_sys_fsync
     19.31 ±  4%      +2.3       21.64 ±  2%  perf-profile.children.cycles-pp.xfs_file_fsync
     19.49 ±  4%      +2.3       21.82 ±  2%  perf-profile.children.cycles-pp.fsync
      1.21 ±  8%      +2.6        3.78 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent
      0.35 ± 11%      +2.6        2.96 ±  3%  perf-profile.children.cycles-pp.xfs_alloc_walk_iter
      1.05 ±  8%      +2.7        3.73 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent_near
      1.81 ±  6%      +3.6        5.38 ±  3%  perf-profile.children.cycles-pp.xfs_bmapi_allocate
      1.73 ±  7%      +3.6        5.31 ±  3%  perf-profile.children.cycles-pp.xfs_bmap_btalloc
      1.58 ±  8%      +3.6        5.18 ±  3%  perf-profile.children.cycles-pp.xfs_alloc_vextent_iterate_ags
      1.60 ±  8%      +3.7        5.27 ±  3%  perf-profile.children.cycles-pp.xfs_alloc_vextent
      5.04 ±  4%      +3.7        8.75 ±  3%  perf-profile.children.cycles-pp.file_write_and_wait_range
      3.75 ±  5%      +3.9        7.65 ±  3%  perf-profile.children.cycles-pp.xfs_vm_writepages
      3.79 ±  5%      +3.9        7.69 ±  3%  perf-profile.children.cycles-pp.do_writepages
      3.72 ±  5%      +3.9        7.64 ±  3%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      3.73 ±  5%      +3.9        7.64 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      3.37 ±  5%      +3.9        7.32 ±  3%  perf-profile.children.cycles-pp.iomap_writepages
      3.37 ±  5%      +3.9        7.31 ±  3%  perf-profile.children.cycles-pp.write_cache_pages
      2.74 ±  5%      +4.0        6.70 ±  3%  perf-profile.children.cycles-pp.xfs_bmapi_convert_delalloc
      3.06 ±  5%      +4.0        7.02 ±  3%  perf-profile.children.cycles-pp.iomap_writepage_map
      2.77 ±  5%      +4.0        6.74 ±  3%  perf-profile.children.cycles-pp.xfs_map_blocks
      6.32 ±  7%      -0.9        5.38 ±  7%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.23 ± 29%      -0.2        1.02 ±  9%  perf-profile.self.cycles-pp.queue_event
      0.51 ± 67%      -0.1        0.37 ±  7%  perf-profile.self.cycles-pp.poll_idle
      1.45 ± 13%      -0.1        1.36 ±  8%  perf-profile.self.cycles-pp.ktime_get
      0.81 ±  8%      -0.1        0.72 ±  5%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.89 ±  5%      -0.1        0.82 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ± 11%      -0.1        0.11 ± 19%  perf-profile.self.cycles-pp.xfs_perag_get
      3.61 ±  6%      -0.1        3.54 ±  3%  perf-profile.self.cycles-pp.osq_lock
      0.38 ± 12%      -0.0        0.34 ±  7%  perf-profile.self.cycles-pp.xfs_buf_lookup
      0.94 ±  9%      -0.0        0.90 ± 10%  perf-profile.self.cycles-pp.menu_select
      0.05 ± 46%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.xfs_buf_offset
      0.38 ± 10%      -0.0        0.34 ±  7%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.16 ± 13%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.xfs_trans_dirty_buf
      0.15 ± 12%      -0.0        0.12 ± 16%  perf-profile.self.cycles-pp.__might_resched
      0.04 ± 75%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_da3_node_lookup_int
      0.12 ± 18%      -0.0        0.09 ± 15%  perf-profile.self.cycles-pp.xfs_buf_item_format_segment
      0.14 ± 17%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.xfs_trans_buf_item_match
      0.03 ±102%      -0.0        0.00        perf-profile.self.cycles-pp.__ordered_events__flush
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.__d_lookup
      0.06 ±  6%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.xas_find_marked
      0.74 ± 18%      -0.0        0.72 ±  4%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.02 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.link_path_walk
      0.02 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.schedule
      0.03 ±101%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.04 ± 71%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp._find_next_and_bit
      0.14 ±  6%      -0.0        0.12 ± 13%  perf-profile.self.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.05 ± 49%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.06 ± 19%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.xfs_perag_grab
      0.13 ± 15%      -0.0        0.11 ± 21%  perf-profile.self.cycles-pp.setup_file_name
      0.12 ± 21%      -0.0        0.10 ± 16%  perf-profile.self.cycles-pp.random
      0.03 ±102%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_trans_buf_set_type
      0.04 ± 71%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.rebalance_domains
      0.08 ± 10%      -0.0        0.06 ± 45%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.25 ±  3%      -0.0        0.23 ±  7%  perf-profile.self.cycles-pp.__output_copy
      0.20 ± 22%      -0.0        0.18 ± 23%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.11 ±  9%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.kmem_cache_free
      0.14 ± 10%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.cgroup_rstat_flush_locked
      0.12 ± 12%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.do_idle
      0.04 ± 71%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.xfs_dir2_leaf_search_hash
      0.06 ± 11%      -0.0        0.05 ± 50%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.06 ± 11%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.xfs_bmapi_read
      0.05 ± 45%      -0.0        0.03 ±101%  perf-profile.self.cycles-pp.xfs_trans_precommit_sort
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp._atomic_dec_and_lock
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.02 ±142%      -0.0        0.00        perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.02 ±142%      -0.0        0.00        perf-profile.self.cycles-pp.submit_bio_noacct
      0.25 ± 12%      -0.0        0.23 ±  7%  perf-profile.self.cycles-pp.read_tsc
      0.18 ± 12%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.perf_tp_event
      0.04 ± 47%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.finish_task_switch
      0.02 ± 99%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.02 ± 99%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.04 ± 45%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.kvm_guest_state
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.xfs_iext_last
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.xlog_cil_force_seq
      0.32 ± 12%      -0.0        0.30 ±  6%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.16 ± 14%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.11 ± 16%      -0.0        0.09 ± 18%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.09 ± 17%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.trigger_load_balance
      0.25 ±  7%      -0.0        0.23 ±  7%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.15 ± 15%      -0.0        0.14 ± 16%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.12 ± 15%      -0.0        0.10 ± 13%  perf-profile.self.cycles-pp.___perf_sw_event
      0.11 ± 16%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.memset_erms
      0.09 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.06 ± 16%      -0.0        0.05 ± 47%  perf-profile.self.cycles-pp.dequeue_entity
      0.06 ± 47%      -0.0        0.04 ± 72%  perf-profile.self.cycles-pp.__do_softirq
      0.06 ± 46%      -0.0        0.04 ± 47%  perf-profile.self.cycles-pp.note_gp_changes
      0.35 ±  7%      -0.0        0.34 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.kallsyms__parse
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_env__arch
      0.04 ± 71%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.xfs_trans_read_buf_map
      0.15 ± 11%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.10 ± 23%      -0.0        0.09 ± 20%  perf-profile.self.cycles-pp.delay_tsc
      0.10 ± 19%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.xfs_trans_ail_update_bulk
      0.13 ± 12%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.__list_add_valid
      0.07 ± 19%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.__flush_workqueue
      0.14 ± 10%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.08 ± 14%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.03 ±100%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.scheduler_tick
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__cond_resched
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.ct_nmi_enter
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.xfs_buf_item_size_segment
      0.10 ± 20%      -0.0        0.09 ± 27%  perf-profile.self.cycles-pp.reader__read_event
      0.09 ± 16%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.06 ± 11%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.10 ± 21%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.xfs_trans_committed_bulk
      0.10 ± 10%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.11 ±  8%      -0.0        0.10 ± 20%  perf-profile.self.cycles-pp.down_read
      0.10 ± 15%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.tick_irq_enter
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.send_call_function_single_ipi
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.cpuacct_charge
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.io__get_char
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.bsearch
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.down_write
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__d_lookup_rcu
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp._find_next_bit
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.list_lru_add
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.inode_permission
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_output_copy
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.timerqueue_add
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rq_qos_wait
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.xfs_inobt_init_key_from_rec
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.flush_workqueue_prep_pwqs
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__alloc_pages
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.xfs_allocbt_init_common
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.apparmor_file_open
      0.18 ± 41%      -0.0        0.17 ± 28%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.14 ±  6%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.xfs_perag_put
      0.08 ± 13%      -0.0        0.07 ± 15%  perf-profile.self.cycles-pp.clear_page_erms
      0.07 ± 15%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.03 ± 70%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.rb_next
      0.12 ±  4%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.iomap_write_end
      0.23 ±  8%      -0.0        0.22 ±  7%  perf-profile.self.cycles-pp._xfs_trans_bjoin
      0.15 ± 10%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__slab_free
      0.12 ± 13%      -0.0        0.12 ± 13%  perf-profile.self.cycles-pp.idle_cpu
      0.08 ± 14%      -0.0        0.07 ± 18%  perf-profile.self.cycles-pp.update_curr
      0.08 ± 14%      -0.0        0.07 ± 23%  perf-profile.self.cycles-pp.check_cpu_stall
      0.08 ± 16%      -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.08 ± 11%      -0.0        0.08 ± 18%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.04 ± 72%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.xfs_buf_lock
      0.06 ±  7%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp._IO_default_xsputn
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.03 ±103%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.xfs_iflush_cluster
      0.12 ±  8%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.12 ± 17%      -0.0        0.11 ± 14%  perf-profile.self.cycles-pp.mutex_lock
      0.12 ± 29%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.evlist__parse_sample
      0.07 ± 18%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.02 ± 99%      -0.0        0.02 ±144%  perf-profile.self.cycles-pp.lockref_put_return
      0.06 ±  6%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.__mutex_lock
      0.12 ± 13%      -0.0        0.11 ± 14%  perf-profile.self.cycles-pp.xfs_btree_lookup
      0.10 ±  8%      -0.0        0.10 ± 18%  perf-profile.self.cycles-pp.update_process_times
      0.45 ±  8%      -0.0        0.45 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.11 ± 10%      -0.0        0.11 ± 13%  perf-profile.self.cycles-pp.update_rq_clock
      0.06 ± 17%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.xfs_buf_item_unpin
      0.08 ± 12%      -0.0        0.07 ± 18%  perf-profile.self.cycles-pp.error_entry
      0.07 ± 15%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.03 ±102%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.perf_rotate_context
      0.23 ±  8%      -0.0        0.23 ±  9%  perf-profile.self.cycles-pp.xfs_buf_item_pin
      0.08            -0.0        0.08 ± 19%  perf-profile.self.cycles-pp.__might_sleep
      0.05 ± 46%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.xfs_buf_find_lock
      0.05 ± 45%      -0.0        0.04 ± 47%  perf-profile.self.cycles-pp.___slab_alloc
      0.17 ±  9%      -0.0        0.17 ± 14%  perf-profile.self.cycles-pp.xlog_cil_push_work
      0.11 ± 17%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.enqueue_entity
      0.12 ± 22%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.xfs_buf_item_init
      0.12 ± 10%      -0.0        0.12 ± 16%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.11 ± 13%      -0.0        0.11 ± 18%  perf-profile.self.cycles-pp.update_cfs_group
      0.08 ±  8%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.07 ±  9%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.xlog_cil_commit
      0.05 ± 47%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.03 ±100%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.12 ± 14%      -0.0        0.11 ± 12%  perf-profile.self.cycles-pp.__switch_to
      0.20 ±  6%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.07 ± 18%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.xfs_trans_log_inode
      0.07 ± 15%      +0.0        0.07 ± 15%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.07 ±  7%      +0.0        0.07 ± 22%  perf-profile.self.cycles-pp.kfree
      0.06 ± 18%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.06 ± 17%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.newidle_balance
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.xfs_iext_get_extent
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xlog_prepare_iovec
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.inode_init_once
      0.08 ± 20%      +0.0        0.08 ± 27%  perf-profile.self.cycles-pp.xfs_buf_get_map
      0.08 ± 13%      +0.0        0.08 ± 17%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.25 ±  8%      +0.0        0.25 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ±  8%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__unwind_start
      0.10 ± 12%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.08 ± 28%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.core_kernel_text
      0.08 ± 29%      +0.0        0.08 ± 16%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.07 ± 25%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.cmp_ex_search
      0.03 ±100%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.xfs_inode_to_log_dinode
      0.02 ±141%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.memmove
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_buf_read_map
      0.06 ±  6%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.06 ±  9%      +0.0        0.06 ± 17%  perf-profile.self.cycles-pp.random_r
      0.04 ± 45%      +0.0        0.04 ± 45%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.20 ± 26%      +0.0        0.20 ± 12%  perf-profile.self.cycles-pp.evsel__parse_sample
      0.07 ± 45%      +0.0        0.07 ± 45%  perf-profile.self.cycles-pp.fault_in_readable
      0.13 ±  9%      +0.0        0.13 ± 19%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.08 ± 11%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.get_perf_callchain
      0.04 ± 45%      +0.0        0.05 ± 49%  perf-profile.self.cycles-pp.xfs_trans_del_item
      0.11 ± 11%      +0.0        0.11 ± 20%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.07 ± 17%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.__kernel_text_address
      0.22 ±  8%      +0.0        0.23 ±  6%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.46 ± 10%      +0.0        0.46 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.06 ± 50%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.xlog_space_left
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.41 ±  8%      +0.0        0.42 ±  3%  perf-profile.self.cycles-pp.stack_access_ok
      0.14 ± 10%      +0.0        0.15 ± 10%  perf-profile.self.cycles-pp.perf_output_sample
      0.08 ± 19%      +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.list_sort
      0.08 ±  7%      +0.0        0.08 ± 16%  perf-profile.self.cycles-pp.available_idle_cpu
      0.13 ±  5%      +0.0        0.14 ± 22%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.07 ± 13%      +0.0        0.08 ± 16%  perf-profile.self.cycles-pp.xlog_force_lsn
      0.07 ± 17%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.07 ± 47%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.llist_reverse_order
      0.04 ± 72%      +0.0        0.05 ± 45%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.05 ± 46%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.xlog_write
      0.13 ± 15%      +0.0        0.14 ± 13%  perf-profile.self.cycles-pp.__switch_to_asm
      0.26 ± 11%      +0.0        0.27 ± 13%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.09 ± 12%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.16 ± 17%      +0.0        0.17 ± 13%  perf-profile.self.cycles-pp.io_serial_in
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.do_writepages
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xlog_calc_unit_res
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.up_read
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_btree_lookup_get_block
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_lookup_get_search_key
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_buf_item_format
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.02 ±142%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.load_balance
      0.02 ±141%      +0.0        0.02 ± 99%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.09 ± 10%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.08 ± 24%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.06 ± 13%      +0.0        0.07 ± 16%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.01 ±223%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.get_cpu_device
      0.04 ± 72%      +0.0        0.06 ± 47%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.06 ±  7%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.xfs_btree_ptr_to_daddr
      0.04 ± 71%      +0.0        0.05 ± 46%  perf-profile.self.cycles-pp.shmem_write_end
      0.04 ± 72%      +0.0        0.05 ±  8%  perf-profile.self.cycles-pp.rb_insert_color
      0.02 ±142%      +0.0        0.03 ± 70%  perf-profile.self.cycles-pp.xfs_buf_rele
      0.05 ± 46%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.prepare_task_switch
      0.07 ±  8%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.04 ± 73%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.rcu_pending
      0.01 ±223%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.rb_erase
      0.17 ± 12%      +0.0        0.19 ±  8%  perf-profile.self.cycles-pp.__schedule
      0.02 ±141%      +0.0        0.04 ± 73%  perf-profile.self.cycles-pp.nvme_poll_cq
      0.47 ±  4%      +0.0        0.49        perf-profile.self.cycles-pp.orc_find
      0.11 ± 12%      +0.0        0.13 ± 11%  perf-profile.self.cycles-pp.llist_add_batch
      0.06 ± 11%      +0.0        0.09 ± 15%  perf-profile.self.cycles-pp.is_module_text_address
      0.12 ±  7%      +0.0        0.15 ± 12%  perf-profile.self.cycles-pp.kernel_text_address
      0.07 ±  7%      +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.28 ±  9%      +0.0        0.31 ± 11%  perf-profile.self.cycles-pp.perf_callchain_kernel
      1.36 ±  2%      +0.0        1.39 ±  3%  perf-profile.self.cycles-pp.memcpy_erms
      0.46 ± 11%      +0.0        0.48 ±  6%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.37 ± 16%      +0.0        0.40 ±  9%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.02 ±141%      +0.0        0.04 ± 45%  perf-profile.self.cycles-pp.get_callchain_entry
      0.02 ±142%      +0.0        0.05 ± 45%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.02 ±141%      +0.0        0.05 ± 47%  perf-profile.self.cycles-pp.rcu_is_watching
      0.00            +0.0        0.04 ± 73%  perf-profile.self.cycles-pp.xfs_alloc_fix_len
      0.08 ± 25%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.__module_address
      1.38 ±  4%      +0.0        1.42 ±  4%  perf-profile.self.cycles-pp.unwind_next_frame
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.xfs_allocbt_init_key_from_rec
      0.03 ±100%      +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.try_to_wake_up
     45.23 ±  2%      +0.1       45.30 ±  2%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      0.34 ± 18%      +0.1        0.42 ± 18%  perf-profile.self.cycles-pp.mod_find
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.xfs_btree_readahead
      0.00            +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.xfs_btree_rec_offset
      0.00            +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.xfs_alloc_walk_iter
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.xfs_alloc_compute_aligned
      0.00            +0.2        0.17 ± 10%  perf-profile.self.cycles-pp.xfs_btree_get_rec
      0.00            +0.2        0.20 ± 18%  perf-profile.self.cycles-pp.xfs_alloc_compute_diff
      0.00            +0.2        0.23 ± 11%  perf-profile.self.cycles-pp.xfs_btree_increment
      1.60 ±  6%      +0.2        1.84 ±  3%  perf-profile.self.cycles-pp.__orc_find
      0.00            +0.3        0.26 ± 25%  perf-profile.self.cycles-pp.xfs_extent_busy_trim
      0.04 ± 75%      +0.4        0.41 ±  7%  perf-profile.self.cycles-pp.xfs_alloc_get_rec
      1.08 ±  3%      +0.4        1.48 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.08 ± 17%      +0.5        0.62 ±  8%  perf-profile.self.cycles-pp.xfs_alloc_cur_check


> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

--Y/n9fmMnsBtlOYVH
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename*0="config-6.2.0-rc6-00029-g2edf06a50f5b-CONFIG_XFS_DEBUG-CONFIG_";
	filename*1="XFS_WARN"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--Y/n9fmMnsBtlOYVH--
