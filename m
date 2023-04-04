Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F235F6D65BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjDDOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjDDOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:51:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D064481
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680619876; x=1712155876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e+uKZ+pEt1hAxV1c+IeZ/bAZmljj5Q2Z6kW029C3z5g=;
  b=aBUMjYL3gdaPQep++1iKhdMKRjIjIcXAhKmbpyZhDDG+NwS5CgFg1s0q
   HBwE0kStQ0ar0A6NdBM2PfpBYOGgpTDXStcHLe+k4Yse3raeDzBf1Mblk
   bPaqGEdS8QBl+dguqjH80Z+iOHKWnXfmDCe/kCfXJi+vo+yFis8LrI4gh
   hOulIJpOIiu4ViWx/brc/pV1JnLNkxPYOTf+VOuFmK8JWplX9wL/JmIQt
   Z/VKHYoO3I1khVFsVpd3BYBZd1GGhW0aXaEqweM96lTtpPTGT1r5qc94S
   kROBqhUkfq8n23ecw/Vz4p9JXXInJwZUpQ+CcyKiax7wEl6PeDUFAhvid
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="321862652"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="321862652"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 07:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="716663118"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="716663118"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 04 Apr 2023 07:51:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 07:51:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 07:51:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 07:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKVdnpdD0i6j21bsYlM5M3qzmU8UwoAOaiiCK4k5pWbWfQCsjE+w/b9Hz//FYSpT4nSdok4XOVQfTSViEliMxJjca6TyeP+xkgHKl88j1Wy3olmL4F581LRyo91A1EgcBFmBdA5MEQccYsZnKCYfZeuffbuyIEZR/ri6XJ5qnMzyU9B1EzjY2jEfMRDwvnqfIVRsrY/PEsAZA0OnYRi9B8x/GgIUxiU+86a322dZ/S3EfOYRhYWn/p/XVQ2QJKGGjMi/qZlnPvo6Pni2DAabPzdYsAj+65VVm2+Q5ArvB9XjmaTspZQ5gVeOSQfveXkf8a7WDhf363/XHZxYhz28mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b4DrsTPbnj5AQhWDGT0JaNAWXXle+PHCPcE9NrPSbw=;
 b=dzntOgQ6jIY1rVgq5PVJX52nJ6JxQt9JabwPuS/AJhcmzGBgg4I3Hh6o4lqLSAgXUcCnrSTrFnG/dHW0frDoBedehtU8KLc0JZx2OAtnPv1a2FZqfZXyF+NXnP17L7GJDBD9Ud0aKLV0eXMwB/yNrX2jBJ/q471+vi8ML/lXtnt7qfulfqNaJy/hGccgiXQu4PCEpNJBnIC4x9Ugdx+CL80dgsuXe8Mkwe/AKbrHMCNXvv+qpa53yzlvwcJW0X7LhvUGswX6GTjzeIOKlYSlR3Omjv4/YKDVTCRxocjwBk5h/W6VZGL4YsWsbpBn2KmLkGeFz1G5cyVsgSfpl0OT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH8PR11MB6902.namprd11.prod.outlook.com (2603:10b6:510:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 14:51:08 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::93fd:14c:bf9f:6d03]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::93fd:14c:bf9f:6d03%7]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 14:51:07 +0000
Date:   Tue, 4 Apr 2023 22:50:57 +0800
From:   Philip Li <philip.li@intel.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     Joseph Qi <joseph.qi@linux.alibaba.com>, <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <oe-kbuild@lists.linux.dev>,
        "Heming Zhao via Ocfs2-devel" <ocfs2-devel@oss.oracle.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error
 code 'status'
Message-ID: <ZCw5Ucw5CS6nXosr@rli9-mobl>
References: <9e1d6835-34fc-49cd-869e-d99d9b546d17@kili.mountain>
 <4154b815-3be4-53de-1bc0-ca87ecb925a4@linux.alibaba.com>
 <1e7d7076-ddd6-41b3-b824-673986c35477@kili.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e7d7076-ddd6-41b3-b824-673986c35477@kili.mountain>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH8PR11MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: f091dad4-37a5-409e-38ef-08db351c0571
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXthT7+RIEoixSxCW+4rNxoG2dHcX/flV0FNxy77JtK/1AJP8J12l8cdq4iZkq41ElVL8EIWI+KEyIU+8nt5bsTE5Dt1lG5y9u7DG55npVqN1xGaLpIWUj3jAwfctAkYMgLpdZS2raOtzd6NYTGgl3t6WZb68duw8geeQ1OcedS39vrI1TkgBNMbMNH/s8GPGewQwjKwMEm0waKJ3q7NzUuw2iNdVbhAFT5GreK8qZCMGdT7K2qsiEzuTH5pFEq41ni6uENjfzLW+5kWqPannR9BUmimpjkjZXaNTWXct4D/V2WX46eGNwOxFQcc6WsaPzJV1DyHZx+1UV4a070A6EC5yb1efp0MayvO4o/u1lKUFFi/qKiiJVrj6gQalr4EbcaafFiWQ2pBRtDACrrcfOsu1K2QMuztjsCB88/DBqeI79NQt2QYF9QxKRgrOyquR7s/g0bMaxqQJiInY5nScDis/6p4vd1yQUPmC1VR8NLSxh/xFzx/KbccunZ5kArEoi6YHUSY7ryLtHOgLMfuCJ3DHbKzHNk0bhFYvQHr9dYHLgZS8JCKecfQDzg7m/MUoChsfVnWdJen7efbFrZ7iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(6916009)(41300700001)(66476007)(66556008)(66946007)(8676002)(316002)(478600001)(44832011)(4326008)(8936002)(82960400001)(5660300002)(38100700002)(54906003)(6666004)(83380400001)(186003)(6486002)(966005)(6506007)(9686003)(6512007)(53546011)(26005)(86362001)(33716001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KiE1nb9vDyJfbwRmtRWcpFa1Uv5uqkmFDPTWyVJKvVK32qTbPn2RQ5Py1Yl?=
 =?us-ascii?Q?lB/pKwPJaHLhZzO/0ULXxcnHtDY7EXJYB68glNizvI4ydAH7zG/+TzoKF8C6?=
 =?us-ascii?Q?ewDdtp5ZB6OI+vIHHB46S2Te6465OwOM82eJIugIm84PpfF/Ws1rn22vDdE0?=
 =?us-ascii?Q?t2gWX2umeqGLCWjd2nwdGEYUjC/W47THqVmaMNul/UeNR5sSnjUVDgr/N33h?=
 =?us-ascii?Q?ZzVQYy1wnoJSIvqnBv08j2/Gn1UzBJpl46V6TPBU9f8Jr0JyyswweLSaO0hb?=
 =?us-ascii?Q?/3028Cbhkyqc93s7lqYKhu2LF6nvlZTg3bvCWy1cj1Owu6jcfy7EAAAs5wv6?=
 =?us-ascii?Q?1l8VeN6b4GOGjc2thP66LrUyr5UV/KN7zhx5ndIi8gKMVPJy6YjlkHGuBSaq?=
 =?us-ascii?Q?+9gpJBIgYnE2w855f5s34kIdrZmSXyq7BexlbQDrpKu7l+4AOjqX2JzFBf2h?=
 =?us-ascii?Q?T8ZY50G4Rmbox2bN8YsS8maJnx2++oNFn0b5Ms1b7CtiP0LC0MvLa8oCp6WD?=
 =?us-ascii?Q?8o405/cOHxBvXLbiqF8B7KFjVge5O4VLOLJzwH6CeN3gKwaHPcbDW9nqCo3+?=
 =?us-ascii?Q?4AHcKOQ3vqJG7n0pVapKsV3COZhJdNLJ630miEIDI/DmFenXFc8mDxqlhgFM?=
 =?us-ascii?Q?/DiPJ62MmEQGcu7RreiD4iP8+rrr598nVy1a2uXVjacQxsiLAMkyXt30H+nr?=
 =?us-ascii?Q?29SzPLw6TOHtk4vAsFUjU2A1aNAT+HNWA0fgNc/kW8DzevwfW8LTcpG3RdTl?=
 =?us-ascii?Q?cqSmLRguVe3fXOfof3muuPG/CRsSxnHqpzXVDRYb6EwGK92+jhfBJMmbi3vv?=
 =?us-ascii?Q?G3zTMrFlWSZPrbWHMcHXKUrdFHZ23ToWcmcMfJmeyQdYfKC7jen+WxgLWZim?=
 =?us-ascii?Q?v6roLiBVWNU+xcjEZns+HYnUcl/N7v0xKtIreWS7rPKkDiE69hmglVOCZ5ei?=
 =?us-ascii?Q?GeLYBtykfV8MOE1mI2aEBqjJMNxWtF5QvEBQQuLZ//Mr2+UIWrsQ2KXXrkiE?=
 =?us-ascii?Q?6x7IDsmsTQsd4ictjl49ZKu/yUZ1grQqjLqykY8BXB8BS2wSnJjhMuEbuIGI?=
 =?us-ascii?Q?Q0tGhD4umctq4IaC3lG6x8Z6rdPP8FQ++baMHSHTQkH0MjYUGuxmGfCde69d?=
 =?us-ascii?Q?9LB1TNvvUOD3/XHaihd7d58Bg2MCPIq4uXRcHq3WB81dLupVwRHtX+FYfTr2?=
 =?us-ascii?Q?VzzWCZjD7ChqYM9kqMiwe351xRODfhkiatkrF7edAGi2oiz0KdS1wjIZoLtn?=
 =?us-ascii?Q?YlNkc42IAYtLTZrv3cvihAs5kIgagWhEC9Oj/Zcr+rPUSQD/mVa9KL5+SsyJ?=
 =?us-ascii?Q?VleZNeM87ofWUBPIe/uahS13HLNuNCIlBlTpxymmfuRvI05sZj6Cb9HPi5Ml?=
 =?us-ascii?Q?AUOwJajDPCS5RxMHBgHV5HVlMsORQ+b7btvO7eUext3PTSG/rqsztDpNqtXt?=
 =?us-ascii?Q?P7E1RH48LDRdJ1uUEY1Rb4Af6XJjn53+VSTVYMsPGQYoinuhA4/cHkjlWtsB?=
 =?us-ascii?Q?9uomIvUXyR8xK+pvEgJntOe890Xo6UCD0kqNmY0RrJ/LQOVU8QZ0C0GnOW/G?=
 =?us-ascii?Q?wyToSHgtMVQZ9vCMiBAIh/OTaJRo9lwW5oOoOiUH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f091dad4-37a5-409e-38ef-08db351c0571
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:51:07.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPQIEprZ/ry/abEQ8fM15syFZ5vVB8Vw2KWihjnVUgz6FOTGc0qxagDbb3Mi07JvWbk99zJ7oDySPVfnAsXBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 02:20:55PM +0300, Dan Carpenter wrote:
> Sorry, the kbuild bot is not supposed to send duplicate warnings.  I
> don't know why it was sent again...

Sorry about this, we should ignore this commit in the bot. Now it is configured
to avoid the false positive report.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7b50567bdcad8925ca1e075feb7171c12015afd1
> commit: 0737e01de9c411e4db87dcedf4a9789d41b1c5c1 ocfs2: ocfs2_mount_volume does cleanup job before return error
> date:   11 months ago
> :::::: branch date: 15 hours ago
>        ^^^^^^^^^^^^^^^^^^^^^^^^^
> Something happened on Apr 1.
> 
> :::::: commit date: 11 months ago
> config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230401/202304012244.gX4H4rBO-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> 
> regards,
> dan carpenter
> 
> On Mon, Apr 03, 2023 at 07:07:37PM +0800, Joseph Qi wrote:
> > Hi,
> > IIRC, we've discussed this before.
> > Success return is expected in case of 'hard readonly'.
> > So this a false positive report.
> > 
> > Thanks,
> > Joseph
> > 
> > On 4/3/23 2:14 PM, Dan Carpenter wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   7b50567bdcad8925ca1e075feb7171c12015afd1
> > > commit: 0737e01de9c411e4db87dcedf4a9789d41b1c5c1 ocfs2: ocfs2_mount_volume does cleanup job before return error
> > > config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230401/202304012244.gX4H4rBO-lkp@intel.com/config)
> > > compiler: aarch64-linux-gcc (GCC) 12.1.0
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Link: https://lore.kernel.org/r/202304012244.gX4H4rBO-lkp@intel.com/
> > > 
> > > smatch warnings:
> > > fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error code 'status'
> > > 
> > > vim +/status +1809 fs/ocfs2/super.c
> > > 
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1803  static int ocfs2_mount_volume(struct super_block *sb)
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1804  {
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1805  	int status = 0;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1806  	struct ocfs2_super *osb = OCFS2_SB(sb);
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1807  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1808  	if (ocfs2_is_hard_readonly(osb))
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29 @1809  		goto out;
> > > 
> > > Hard to tell if this should be an error path or not...  Canonical
> > > problem with do nothing gotos.
> > > 
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1810  
> > > 5500ab4ed3b8f0 Gang He                     2019-03-05  1811  	mutex_init(&osb->obs_trim_fs_mutex);
> > > 5500ab4ed3b8f0 Gang He                     2019-03-05  1812  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1813  	status = ocfs2_dlm_init(osb);
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1814  	if (status < 0) {
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1815  		mlog_errno(status);
> > > a52370b3b182f7 Gang He                     2018-01-31  1816  		if (status == -EBADR && ocfs2_userspace_stack(osb))
> > > a52370b3b182f7 Gang He                     2018-01-31  1817  			mlog(ML_ERROR, "couldn't mount because cluster name on"
> > > a52370b3b182f7 Gang He                     2018-01-31  1818  			" disk does not match the running cluster name.\n");
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1819  		goto out;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1820  	}
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1821  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1822  	status = ocfs2_super_lock(osb, 1);
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1823  	if (status < 0) {
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1824  		mlog_errno(status);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1825  		goto out_dlm;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1826  	}
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1827  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1828  	/* This will load up the node map and add ourselves to it. */
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1829  	status = ocfs2_find_slot(osb);
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1830  	if (status < 0) {
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1831  		mlog_errno(status);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1832  		goto out_super_lock;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1833  	}
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1834  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1835  	/* load all node-local system inodes */
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1836  	status = ocfs2_init_local_system_inodes(osb);
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1837  	if (status < 0) {
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1838  		mlog_errno(status);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1839  		goto out_super_lock;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1840  	}
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1841  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1842  	status = ocfs2_check_volume(osb);
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1843  	if (status < 0) {
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1844  		mlog_errno(status);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1845  		goto out_system_inodes;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1846  	}
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1847  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1848  	status = ocfs2_truncate_log_init(osb);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1849  	if (status < 0) {
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1850  		mlog_errno(status);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1851  		goto out_system_inodes;
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1852  	}
> > > c271c5c22b0a7c Sunil Mushran               2006-12-05  1853  
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1854  	ocfs2_super_unlock(osb, 1);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1855  	return 0;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1856  
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1857  out_system_inodes:
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1858  	if (osb->local_alloc_state == OCFS2_LA_ENABLED)
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1859  		ocfs2_shutdown_local_alloc(osb);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1860  	ocfs2_release_system_inodes(osb);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1861  	/* before journal shutdown, we should release slot_info */
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1862  	ocfs2_free_slot_info(osb);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1863  	ocfs2_journal_shutdown(osb);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1864  out_super_lock:
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1865  	ocfs2_super_unlock(osb, 1);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1866  out_dlm:
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1867  	ocfs2_dlm_shutdown(osb, 0);
> > > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1868  out:
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1869  	return status;
> > > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1870  }
> > > 
> 
