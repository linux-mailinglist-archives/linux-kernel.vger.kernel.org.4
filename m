Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324FB659435
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 03:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiL3CcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 21:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3CcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:32:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF25F97
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 18:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672367539; x=1703903539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DPwqtS/BcBaHmof0ZVZIro6xC/KCTorvy9xzJLmJA+M=;
  b=OJg8MgfRG/I9caloudcuZHe9qcCMiZJwRg3hy26Cn2ncqaVhCo+eFMw9
   ilaER2p/Ab6YeCd45Q25PhUXZb8iOvv/Lfn/D4UHWZLyiRHhgbWWcasD3
   7q/3c4bVkKsD3pJrByPkxqSKIX3TmGl+m+zgfDxatk+BAloFStJDA730d
   7KnL/haY+XKriNGyPgE9iIb2g6atPFsUnNZggQ9BZAw3eTdMKRvwO9lcV
   ffK591Qi6VuucQfFOjP4izvWzvuQFb3aV8C3zP1tHhC0qA09HwgPpN7Nl
   uTHavPmmKiXbzrtY0FFbzAW3wdahUQE88pxjkl9TEUtxYjSQ1ObsKc4kS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="322384460"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="322384460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 18:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="717071604"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="717071604"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2022 18:32:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 18:32:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 29 Dec 2022 18:32:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 29 Dec 2022 18:32:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDQEWG5ik/VR6Ow49J0aOZO5gHUzt3SJkuWZozey/ZECzwQWkiNTuDnl9pnD20w+bfMkcNBYiY8ZUl7pXRskljH3AvJyTXQdu9aa70vlaDrrt6aTvqHWJ2+XAiKzbjPmiMKscM1PUnudaSFA1JbB48eMv6cndaokfFIKQqqkW9VSsNTIDPX/OPx7pR385PSxkNuh1Ts/DUsroyjKLrgaQUOAjugY6oOy6maWrdv9EMrGOKDC5V3CI+zHJKRIpo+Xl1seWeZlgIgg3DqdwYq4S/2ICG5VPWKh7ZIXx9ScuzhHXY+mvM/B5QspOmqJ57FnS6NrBohHLNQKeBRVUONnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPwqtS/BcBaHmof0ZVZIro6xC/KCTorvy9xzJLmJA+M=;
 b=FlJjNt90L2EC/v9oUofl54f8rY1XPgS9aPAFzF1hZrX6dOW+PcPygVS3U4kR5RzTrPBbtolDD73fSByXf7Y3DG6kVGzNraoH6PXkojxeQRnnmwW6WiOkrdZD6Pd0/vMdii7uqGVRASQNRMDxDORzOIuvkTndKIO6n1fCxm9JLzVqR84bxmEHqWcH4to0f1cQ1FVwuhDJRRKZXVf1I5/iFX5hHfxqYxSPQFZR/rIYn7yMbD37tXyx4zPl2bgYHA8K2vhW9Wg8O/1+07r8a8683cw4tPAq23ilRku4ZDQifwW9GK38t8fW36lDlsr8NuM7UGJgtETFbobiB3eHY4COEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CO1PR11MB4851.namprd11.prod.outlook.com (2603:10b6:303:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 02:32:14 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::a95:5288:9215:a267]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::a95:5288:9215:a267%3]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 02:32:14 +0000
Date:   Fri, 30 Dec 2022 10:33:02 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <heng.su@intel.com>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <jmaloy@redhat.com>, <kuba@kernel.org>
Subject: Update bisect info and new repro code for "[syzbot] WARNING in
 _copy_from_iter"
Message-ID: <Y65N3pgLMsxZ99lo@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CO1PR11MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5834b9-093f-46b1-8468-08daea0e100e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF5mz3UGq+DuPRT3SlvC9vNN4qLOEvJESEB7ZVIKhGO4i+YuX7yjpEM1p2RLj9TdnfdI/BndpOcCXpm+RdVP2443JfizBJgu1AY3b848ZEGQOrcTuIb57tbnFDUNXnThWjAkkjlnqMRD/Y/cjHp3NCcrNop+iEizlY+io1E4E0IzH/DfzC8zWrlTO/TJrRBCeFohVsh39ZM63iB0Hd0lTaxQCA1ZRwhE5ZQALCks5nQWxlNIwzVingF02VsMFBL9ibIh/RyOAVoQnB9sPP9E4OUsE+D84qRblWR9XmDm9c+ETZcu4uLq5GdLyMzpIHAzXxPClSzKGreG9hkfg/6fNqRIaWQlEn7eraGhV5o8PWBvNaUehDFWjdaCCnlU5XIP4+dhAL4FSOsWy5ZDKaJA2IkESXWqxBhSdajFdpJRPsC8iGaANHbvq/FKvnOJfPybd/H3drRjGRB6Ly1LbK41yC0QbkEWT4rgkwMqIkcl7QE8kdzzufbkuweO87la35Mpqn6WOU3ewU8/ucKtbrsXPxrBs3iVvDDKkuF1qk4Wpdumn+8ClQSKRH7nvPhNiy21iUrXY9t6Q+sErQvT99G5jcriIkd0y3K3z/XT17j67nlTxOV974kVp9B5kf+zAcCDYBa/OvENal+dSJp8LfzpJIVbWY63kqCNCaH/y+FS23ntkiV4iyIW3RIsKJT2j2Ro2nflF38Ebko+LKdTnlMrBoKY4JikFH5S9oWzZpy6E3+P+8IQcRuCESiPnBnrPN/G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(26005)(5660300002)(6512007)(4744005)(41300700001)(66476007)(66556008)(8676002)(66946007)(186003)(8936002)(44832011)(4326008)(2906002)(6916009)(478600001)(966005)(6486002)(316002)(86362001)(6666004)(6506007)(82960400001)(38100700002)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZ7FNuKFj1UVMOPwuLM4AcjpPrmj/fhRVApG0Fz/zx8qmsqbz87mexOYb4V2?=
 =?us-ascii?Q?EOVZS2rBbTSusS5MKyh5sHDHSrw9R0o1rjYpnLhgE8BQqb60wvs8NFHMaXGV?=
 =?us-ascii?Q?mM9x7sZR3DQYx7/o0oXAwG7eRhs289WDMtcZ/ZhfULp5XtAyGtxrhw2GPpHF?=
 =?us-ascii?Q?hS3Kr7yHU7kHMUqioUUi0tpEtp4nb7bZ18GpK8CNaxH8lqrt9GcHXWOcEdcN?=
 =?us-ascii?Q?jZSJhpLbbNWJUi60RbFyD6lTLrcxgGMlmpZ65FvhGRRx2ThXA1ow7OpLahbW?=
 =?us-ascii?Q?Hv2/XpHLbgdC+wkSknneeiqLoQQuWZMn50WiCqq7bd6631/yJxUvrIh//WVq?=
 =?us-ascii?Q?cYM72jF60x5+jTAGtwtvOn38WbTW6rPY6HAU7x4r+UpqAv0SLUFKruOpg2vS?=
 =?us-ascii?Q?V4hewQ12ozFUiY2ak56GWM6l8YkLaosuJ1QIIt4NlzCi1j74j1aOYooGc82I?=
 =?us-ascii?Q?zYdLNntNWX9ZYDwUO2rUwALw1BGOQsozUqb2oQfZbX53FuIkFKMGfuidU0ZK?=
 =?us-ascii?Q?VreHNbzIxEKVik7Pc3Mmfh/NW8TN2EXJ6NQLTmR/3NckfXhaaf2nWpnilNCJ?=
 =?us-ascii?Q?SVyy5etvtXbB/6vCumHspdzUwJKWBe+2kn7ny+iLOaFmNEE8evOSkLNeslEb?=
 =?us-ascii?Q?pXw/wdEhzbH6bUcuIzr0AA3udjIVncyxknCBv0cM9fbDWXE64Pp2d43yxAQL?=
 =?us-ascii?Q?rx+U7ArkmZASS8gWPS/yhvJL5/pU7OknKMMr9QAgfEHiEgUC8CUvXB4j0C0q?=
 =?us-ascii?Q?v5AbQgDPk5++QT8bl9khYlBYDIJ80ZFAZuE7VVULqTVSQu+CXqgFk5uF0kHz?=
 =?us-ascii?Q?KPjUkRa8s0Xqwh/bjWd2zsXKp33Q/nQ87qjgKvO40hvJejq8v9wWikwrqgXx?=
 =?us-ascii?Q?gkgKWmFE4+5jtrz7G6z7KWHvK2G8LxyVctOsbzq1vNeepubfX1e91LyiSL3d?=
 =?us-ascii?Q?uVOdWhlDGTZTJKKjlArdJTEjoW9IdxNV+hP0jBWv/e/C2eHPwyoKSsoNrJ0O?=
 =?us-ascii?Q?W0e+bpo8IwbvoUoGw0nrF6k/YzA7Hii2eAKFbuYthwRs0rIhNPiWCGnJbaSA?=
 =?us-ascii?Q?XJiRhW2QCQB/RxV97EYVs3bQ6MQ3h05oo13chffRh1F59R16D57fK1V+w00L?=
 =?us-ascii?Q?nsUg8A6BBPeBTJfecUdjTUivpN50IY4xOce0sG5sJkkNGMp2GV6oq3Mu6zjr?=
 =?us-ascii?Q?AnhwuEJTVKJRHVHO76fdsP3vI/jUuNesKoCyFcdnO0B3pIweAi8D/TLlAjeH?=
 =?us-ascii?Q?+S49Hm3uXEdqtZncLD1wnuuLCvFEgoEmstIsLWhkQ8qxRR5yVNONBYoAzWRf?=
 =?us-ascii?Q?iUsx125y23k2B6Lpt8uWAUKtaN0PLk6ACuLl6YC1cvebA8HFUDkYL4wf5Q4J?=
 =?us-ascii?Q?NGi3YdbwlGbAoJV3UcXzbp+F3DXVm3C8tbg1UX+67zZYshCS66NRqxmiPIro?=
 =?us-ascii?Q?zipaevbvf5/Ob389e07NAuIThLt4KbdWpIMDTXt03OpiZVMyfYK1me1PPVdN?=
 =?us-ascii?Q?z2TdoBOaCx9ykqBPhB6MGH/3SMPyO9MurPsT8saMizCs6j57oHaABEJ5Mi4r?=
 =?us-ascii?Q?mPvYbjZ112577jvS07gQm63dDYyVx3owH4ZZdm9kkkjZ/dy4MYBvkoSHcf3r?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5834b9-093f-46b1-8468-08daea0e100e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 02:32:14.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uh5fHKaYsWrQZPbX4F6YKvqa6sOsLBxtTViHKC8qg33hb035rxHeMOVWCxC19jdhbRiGF+rwcKN4BXqtUXuFgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4851
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

Hi Viro,

Related email link:
https://lore.kernel.org/lkml/Y5WlLoCBcHbfKBD5@ZenIV/

syzbot link:
https://syzkaller.appspot.com/bug?id=4694bd1c1c0019f067af5b6e14e8ef02431b6b34


I reproduced on TGL-H with v6.2-rc1 kernel.

All reproduced code bisect info are in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221228_010310__copy_from_iter

I hope it's helpful.

Thanks!
BR.
