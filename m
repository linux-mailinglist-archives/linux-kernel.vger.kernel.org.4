Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B56F0C44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244565AbjD0TFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbjD0TFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:05:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A33468F;
        Thu, 27 Apr 2023 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622331; x=1714158331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1cLN38dVwNOQX6DO1LlWeJSqreu7tTNbsZhKhgHiMwY=;
  b=Kmwy64WQe/AkwjamcO2ldLDmE5BralBn1eVB85Rx5d1I/jRSzp4foOoT
   xoCCZ9KkvtMjberlRGzIDyFtPh/ljidvFdbaNaf/aRP2u7BeBIBuWbJKp
   B0cCLx6J8FUgQXKYKdGTlVXrUCMIYl6gtIVYorhpiffLan0yaNHpXqIbr
   +MLU5OuTZeSechPHZABVEDQ+lwUrJNJEjld4tCPKWTkuQ9puep501ovvn
   nOp+FFZjQnT9gfxz69mjjraZuxve2cPchH9qmWPnmuHO7RCKccJbDdAI5
   4pKN94b6yMOEWedeG8ztxSQ3p/1qZXZ0zBqWBUyb0l3yq1Vnf6PU75IE7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="349529038"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="349529038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="763956570"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="763956570"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2023 12:05:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:05:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 12:05:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 12:05:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtCAStz6/2aSlEtTRY7v44BNPJRYCst7q6CtPR+4iQmfsb/x2LvXL0rxPbuHlIrYlNzmfkOhwwFyOWPO+J1c7dK2OH+oblcmOxTVYcMf7MyVIEzYwP4BUbGx2/URZkAI9ivlyrHeJRUdouA3F9bsoiHhGCKAS2EHBLcW9YV79MIT091Qqfy1Pdps0damBgUVSEpBLlwmVjIx3szT6kAFGmsjfo+mJ5OrrnGmqvpZZW3+qaeyJytrz+iuzqU3/e/NPT/nXN4sOKF75Qu4sXdHJjz5KNxin+kbyI9b7tNVQkxzxab5iJ0QXiS98tHGY5rCg/xhu9hTiL1w2sKK+bkNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bytaroO4xm9enO8c7aYBgmmD5OKpJncI+2eS0drQC4=;
 b=YpzhvztdnUmTkkzU5PzIIwJF48mBPCx0cn/hq/yV+SDGwxyAaRQSIqPydhjghw1uoWb89prvxJ3501y1NzKo0GIl6cwZf7nnCjVbkQqW/okFAB0GdeQIPO9rqlGGUyfInJ636341/jKWfekqTBnVYNcIcsLpSH9XGiS3uQsePnF69mz2uqLVg3AdkIQrbBX+JHjrd02hQbLNScdW09j8ZXhddoDEkNlZBkRNA+Df6PvOwz0qqoX6KCm8QnYKnljU1vQLVWIlSjZn/7rsiLiKaFyWzY4PAW5U4Puue6Xh1VD7csV1xWbEM8IA2luQjIE1SqnDQr+Hl8UaFJHpKh2efQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 19:05:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 19:05:27 +0000
Date:   Thu, 27 Apr 2023 12:05:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Raghu H <raghuhack78@gmail.com>, <linux-cxl@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [STYLE v1 1/3] cxl/mbox: remove redundant debug msg
Message-ID: <644ac773f2929_182a92942f@iweiny-mobl.notmuch>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
 <20230419111443.231151-2-raghuhack78@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230419111443.231151-2-raghuhack78@gmail.com>
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bed42f-2bd6-405a-0a8f-08db47525ce5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0pECmtPIlodA9a3nRCun3B2xCUOsVy3FC8KTCdmq/197C/zn/gj4F2d01cbbfz93SojSIR634yR67+h4KzAXl58xUz861IVAf5HhUVKG1ApcGPlgUyyYb5rsUaJiFjySSB2WQrINvx12fbyAkfqez+6ihsX2QM++fdqdVo/K7PPPu2Avhsli9ewc4sK+GnZ7gsohfc+ZBsJVYZEkupQBAqJE53SWTU7e7ADTcagLpbbfjlLxDETUdlMnhi2mKFmodECzOWyY1LUliihibXsIOp6YZYLESsVYoCUsyA/ADeEGRFJvp+00rgCRuTn1AEF7K3ckNtHnwgkJrLXvGcpOZOWFaSeT/6DPpvmN+LlD5rrVaqliVwlRBhQBdmewjMwDJ9LM0yDysV/sE1fHmhz073Ef0eDTN6uUMUSBLvwIb984OIgpssc/xFBzgob5Gj4Bwz8HWbOlxeOTXf3SUZORkXDwfBZtyH21FKXhvfZSgIoiTs0d1ZwnNxplp+vHhIY4uBAMEANqBI2U9UFlWH6WTmRG5ZGIvkkGRgyah85n4eyIRJYs3Gg2oaScevsyhUK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(86362001)(2906002)(4744005)(6486002)(6666004)(83380400001)(186003)(6512007)(9686003)(6506007)(26005)(44832011)(66476007)(4326008)(110136005)(478600001)(6636002)(66556008)(66946007)(82960400001)(38100700002)(41300700001)(8676002)(5660300002)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bpfa9N/PBVVpLoIHtrtNePse6xwUx4oQTzt27no69c04GEXy4yVMYISA8KpN?=
 =?us-ascii?Q?Ij+fAkSeFNM7+cdUtZQ9nR96LEXnU4+NnwKNQAFsAvJ7j8M0FAhlS5GmfPda?=
 =?us-ascii?Q?ZoPj8yj4azm5QxrfIM1YwvpdDbQlvzNsveyZqRmgqV1ROsW4zRN4s9aT/1KX?=
 =?us-ascii?Q?zspvCi6Gx8yiSsruYsqxQ/uqocC1AjWjhMNtTgOlmqTDiHWOr65PWK5OgBRV?=
 =?us-ascii?Q?y+cnCFxoU96wDZkzFPKVfUG4fxBiNVor8OqoD9N3s3pmreUu+3U9SXyPludL?=
 =?us-ascii?Q?4cwcHQKmpNmvj9I/CT2K1mYjbk4IN4hPdz6Ps7ilPK+LbxY/etFeig1yf8jo?=
 =?us-ascii?Q?+doZCu/SfGk+x3Y1BUWNl5bdnNQwgcrd6OoP078FENX3YbUmqVZ3i6I9ukQE?=
 =?us-ascii?Q?0b8Ei0ml1vXE4VwQVnTpO3GZ1FaiHyPiynZV9WmYEKxml25OTUQBjXkdA/oC?=
 =?us-ascii?Q?8fHOcKmloqhNTt/CjA9hAubPr9M7KdgzjuQXCRRyzpVq8v3LkTmuhUl8W0V8?=
 =?us-ascii?Q?RAGOis7QVWustgPyOIYCndjTnf61DA9eNej4WQxELBKxntzLTra0ubo63KM9?=
 =?us-ascii?Q?jX3/6TqIJr7RVh1oedTn7W/KF7eBYKdct/svCOTZ2zpYhvuNt1YiLT2zYAAb?=
 =?us-ascii?Q?dFlox/YZmPz6I3hx3M/50La9K1uSx1K7cgrkLj80x8eckhptN49hg7C3azOK?=
 =?us-ascii?Q?K+00oakx15zDMgvbaAfg8MwJC8KJ+wwc8kybnQUryxBgsazciTiTO2mhRkbY?=
 =?us-ascii?Q?pgPESqMJlxL34SZ+IN5+B0PpbMDtFUgV9O5yaKbGUIJR8gjHwL9L2zM/aB26?=
 =?us-ascii?Q?QOloaR4rDTbQ+uFhHmFKm2s6+9FYYoF2YEhDntn8YSTPx2JFkYy0uEaTWmLT?=
 =?us-ascii?Q?DTZC4zb64tzELVPtfBuW2xmSWdtZOuja7H6zvSFd8Rq+4YN9De5T+djXiW55?=
 =?us-ascii?Q?1onAKvXnCsAFuFpMzI4j4ugo6JUOueOwF231ty85KjAm2cCKrbxwdXWd6gSk?=
 =?us-ascii?Q?pEMyRU4g8QXZVlZzEyqKNiMjIqm++l2qhtUMVopQOa4wbfHcktm/QcSxzq9X?=
 =?us-ascii?Q?We6ITJlqnznGSf8CMceodgCGBCONqnhjfebl9KagIBu9+pYLneNuCMEAyhpf?=
 =?us-ascii?Q?hnJdLbcmdvcGoMRIgYlk2wShgjAuaoxjkvDyrMHHhzLhrcmgW0hn2U85bQXJ?=
 =?us-ascii?Q?FOMufQM1Sg1OC6ij67biYLG6cKFeegZ2FXEM0nQ1r5mfc/Ii4gguOaZWP2Sh?=
 =?us-ascii?Q?dxMNKqq/1zb4QJWO/fvpeYVOBYyX51sZsenPg72RTyqFy7OzpoMOnWIOKkOc?=
 =?us-ascii?Q?fQjtUQj8WdMBtDfLRBDr8Flz5zUskWBtIPFAD1EgjfDW56HiY/cchJqXhl8o?=
 =?us-ascii?Q?JOyY4mLDxrV2xxEvuzg4HOV/SFLtMZVLxksH2HEv7SRYIR8iJCeRkI/9MR7N?=
 =?us-ascii?Q?l4F5hdrJmjUu96Sit6RV6gY7zkG7hNQjwnb8Z/MHPwDikSzakRWANQv0QQQe?=
 =?us-ascii?Q?0gIT/0hlm7BK5xS5vQlq1nb1imda3aqGiPo8/LrZAeSZT9LWE9dkx7zDT0Zq?=
 =?us-ascii?Q?PphbJNaWfYiB9B0/S9Mb7z4ibTcnQusflmFdJq15?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bed42f-2bd6-405a-0a8f-08db47525ce5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:05:27.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grD9LavyMwmoC6BhVe7yS/aQDoJ+ZzY5WwFIAyY/fyou1LZ4MGGZr0mtMXR/JJauJ5jJatFXL1r119QYJmOfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5394
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raghu H wrote:
> A return of errno should be good enough if the memory allocation fails,
> the debug message here is redundatant as per the coding style, removing it.
> 
> Signed-off-by: Raghu H <raghuhack78@gmail.com>

I'm not seeing a lot of value in this error message either.  There are
plenty of other places probe can fail without any errors at all.

I guess:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
