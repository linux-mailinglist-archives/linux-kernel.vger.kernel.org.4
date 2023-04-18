Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC06E5FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjDRLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjDRLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:22:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FB9ECC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681816923; x=1713352923;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=201e7hhX1oWfSHi0HSy9oSSd64ZX/E5JwAnUcxz3ZAM=;
  b=fl9LF1wp2SOlkmW4sWxctZZtMNUXKPoiEegX2dtsglkDfbwoIa/aHk0C
   FYdoN66oKn8BIspymTXvUp2c/5Bh/CDzSdfkN0JaP5de0xO/814NUWctV
   ritMUIdzWiiFJRx3FiWa7mL+/JlaZamKlyuW3cVHJl6uifij7ctPXaNZn
   /qrlGjPd7Z+Y4n6mSXn+a27JQ3rn1Y+apos67FHlpPfppdJrIxJ4M1Fk/
   sOb0vQry3dC+49fncgmQ9t2NR1XQXtIDcIsUUNq0iJ4k2Jv74ngaxnXZq
   Ry9dyXAmYu62yvrhiZMggLnetOjG0CzPGUUm3pP0bxveXW/rGCj0ogfWI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="343895772"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="343895772"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684545117"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="684545117"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 18 Apr 2023 04:22:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 04:22:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 04:22:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 04:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV6rRl6d5AL9nPBlc2LCvqcmTH41I8zTIDGO7SO6+LBZz/IGBkp4gdqD1K8XB3oRdfRC/NTUDnNHP7vYvybLUD8qiMtQbEaLflzZ7RakC37ls+j0TXTfIBP8Rq3NLkl9BJMN9VfFey/fJr9Wtcy7y3ZNCvaV5fN/k28MeScHqBrK1nFAgnAEs/mA+YlBWBgUUQZULEIeA+hVIInP2ivTTJsqFAnTfT5PjucDCdTJ84W0y7fzC0zTx5GagyMVzis7JPS1gQFJlmlY+HahgnA6/9KcJIAu62zlIrcPHUEJ3TaQFaHi6kj34KXcV099uVbaNyRgXxjLisOOT916ygkHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=201e7hhX1oWfSHi0HSy9oSSd64ZX/E5JwAnUcxz3ZAM=;
 b=W0zwu7n7eEh+kqC2nYNN7QhS5Xtci8u7ILoHgJfl/w7h+RlLPPLk9bDwW4Nj1tuGIzfWNoioWMS/WLkSzy9dIFFe0mBM6+7TOAFK7RRABtYkYBnED6e5YHB+4rzlJhWUwzmNk22orGbyy0eKIT2DfhqNWctNBE0SHnGniVyn+mpqexTNzjLtVOyUoAKgYpXxLkN365X3NeDAyuoF9iMxqKefLrWyviABWvu3ePDm9dij6sB0rpTBBOFvbAIGlqhh6u3ls0KpeodOyCbTFyl13H+G+wgORmjPTP/lZS6/3KRCF/6dlgQ6VmwjNaYxzYcf0UUvTNVHGZ6UEfPRVrJ37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:22:00 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 11:21:59 +0000
Date:   Tue, 18 Apr 2023 19:21:51 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v8] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230418112151.GA565498@ziqianlu-desk2>
References: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcb0c70-b0d9-4476-b21d-08db3fff2054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFVCBiA0wW+3yKr+LLlcnnnNCcd2lval+dDYxismx39PewVCphCdQq7kPPTQYtYGuEJbiWhwpFxQ+Z9JuF+ZcPiw/67N8ISW5Kr/w8ZegnYknYZqgYV9SLgyu2qxsXxeCmB+4ookFtg+EJcsSP3be5IUFaq2jznRKh/lCRwpZzlbBDzW01fGgBUZJOcTRbYaQuoOrBFSJuAE5L6rvWd7Y6F9XGlot8HlpHo6qpPN0NOtrv02I/osUDclapx9QLl2GOw5aCqXIt91f2l99KWmhE/0nEKqs++R2UZFVhzk3cLz6opb2gnnbVIoPomHM3DK6mI1PsrALkNdY9Go0jhSZ9fveNf+76sBc5zx2SeYs8Eg+5YyqcnWVBA49rN1X+B8ZX1RjuMI3t1WaCzvlZlQ2H5Llq3A59KxYF8lDeyDRk39TVBDfcN/a9Mo85YONQa6gKLTMQzbCFPSnoZQTRizhcYdBbHP2DXECHgvihxGUewrr0XeH+I3bxXt/LIWKABpthZcvJppfIQkoSPKMv16Hk7+Gi+agvbv5VcPUx6UIAvlzkCvGDGbRpIHYqj/tdjL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(44832011)(2906002)(4744005)(5660300002)(8936002)(8676002)(41300700001)(86362001)(33656002)(38100700002)(33716001)(478600001)(26005)(1076003)(6506007)(9686003)(6512007)(54906003)(186003)(6666004)(6486002)(6916009)(4326008)(66476007)(66556008)(66946007)(82960400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WLqGX3epGbDDFPNcPbXi2j+zsOgZEU13Qwtk0CV7aTOygENigsOs8x3fzQW3?=
 =?us-ascii?Q?4X/f9DywdiOk+aRTqGLMhwGKa4k0LQAUPl79sgAOoibrLkDytq7O6Nr+M3Ln?=
 =?us-ascii?Q?Gi6y8xdx0xP1zCRWJDLhr08sDmj5H4zPXbcnfTzNjkuMPK5aBuLz95Yilk11?=
 =?us-ascii?Q?KfUiw2U+vmB+Den7PuG/pR7KzxNn9JLK6OaiCdj3O4/mbPAvvrL3p2glm55m?=
 =?us-ascii?Q?+O1YNbycmPDZR91avHov41oeT2++sDC3TaKaHpG5gLvHtvnTZ3JIMkOmzI/H?=
 =?us-ascii?Q?78fc4uhPA/57P6LXreSEfXgRl0Ve+UD5xZ3GpDQJXSahnuh64e7DzLfxZSRV?=
 =?us-ascii?Q?syiaAVv3cniTgwwl2CkK+4E7WFnG9GVBtG0HjS4fER9qq+H1gaCdPlajfqCv?=
 =?us-ascii?Q?G/tnhhf+WM4mC9//OWsDj7lVYDBiXRQIyhdVzZxTF8gVCHb+OWfpF3azj32S?=
 =?us-ascii?Q?IVUYyWT9jqHT+nfhAP4j3XTR11cGsFajrmCRym5C+cP1X3NcrK5WzysPUgmT?=
 =?us-ascii?Q?2QfVdyBMfG7hKGR5YW+ULfVSnTsXTsgqdHUZJMpBsYMMdWn4EFUNB4jVkwdu?=
 =?us-ascii?Q?miNe4dLEzHxXOFc1fSqJ+pY7u/NSgkJbBv/1NzoSbtuux94IjyNsESwq69Fs?=
 =?us-ascii?Q?Wxr9cGP8isBSQfOUhuWPa+oknygsCnMjAy5M4n5p8ubMu588Vi4Ixo2Tjatt?=
 =?us-ascii?Q?kL4DgF35x21rcfTJh2WNT01otdNfpC6ulTWGyx5MTNYwl3JhxRQVnuJQAHz8?=
 =?us-ascii?Q?aw1PKN7o7XtW1sioD3ueo5EqNeTn/brhydga/ZRtXmqM/xtD4NQc5x3hLDYy?=
 =?us-ascii?Q?sozfPqBx6vD0tUMCwtln0fJiJONJktD41nTLAYa/9uuvu6cVyS4z4mhrUVGQ?=
 =?us-ascii?Q?yfOPaAzpNl89An8cPy+/rp1Ciqk2c+B/raRIN/jwwkK1aHG6EJf64luilICu?=
 =?us-ascii?Q?ErMkUKGF7GYG2JYLPqL6T0tuy3STs3ZBvjYgiR6Yp6fJbPcAhzhnk8NYfqAe?=
 =?us-ascii?Q?/n6nAhA++lJhUJmVfqJN0kE65hLmZntQzHK/TJOBvHTG3PxJClGdBdoatV98?=
 =?us-ascii?Q?DPxUEEKo2fUN5YPYKWG1/cHS8sk234RerbD3jLqUdjyRVbecGYXOX8gliZfj?=
 =?us-ascii?Q?m9aPORRGFQXZqP+RnF+IllnQONUW6he2pJqIS4KCHXdU4FOr0O459HHQpWR6?=
 =?us-ascii?Q?f/z0Lg8gmTScI4v5NEHbYuunnesWJc+N4MT1/SeOGkcF7WZ1oHBJKAeOR7Ah?=
 =?us-ascii?Q?vecexRiMX40odwnCNc6ixos/gtP132iudfbReMP6ctGZxk/E5/dNApq68tIa?=
 =?us-ascii?Q?AxkylGPeUtzMy3nSUD1+xNHedwwsxqVNr7Q4/GkKJOiFq3QBQST5THU0rndO?=
 =?us-ascii?Q?MVs+fpSdDkXcwnn0qHAuXHt9IkpFz/523zc7AAdbq+533w6p5s1ACkktLR/t?=
 =?us-ascii?Q?yMRpT/VC3L7NhbfiRLzg4V1BQO/+NqadGxwOibySFSP4UF4miiwOlKzHZch3?=
 =?us-ascii?Q?gzPkw9O5eL9fRHYZslCkmWOykZlUezwp4PEVSbfk0wzdfsP0f+QuIwTfoVU4?=
 =?us-ascii?Q?ifpK3g+AdyfCu+g9uOnf2CLbGpulN2pFHxjhtzwM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcb0c70-b0d9-4476-b21d-08db3fff2054
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:21:59.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3qXVJsbLgNHBCkQSq2afmaHMyenLPEvzNiKQ0EHkEVS1c+3S0RrdtFWZLfpU4TO3KMIDXbdyTzLD9jWHbazeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:08:31AM -0400, Mathieu Desnoyers wrote:
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.

For postgres_sysbench on SPR:
sched_mm_cid_migrate_to() is in the range of 0.1x% - 0.4x%, mm_cid_get()
is in the range of 0.1x% - 0.3x%. Other cid functions are pretty minor.

For hackbench on SPR:
ched_mm_cid_migrate_to() is about 3%-4%, mm_cid_get() is about 7%-8%,
other cid functions are pretty minor.

Thanks,
Aaron
