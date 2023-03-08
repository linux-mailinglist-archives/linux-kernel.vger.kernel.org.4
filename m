Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D606B0B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjCHOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCHOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:34:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C357302E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678286042; x=1709822042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J6UT+4U6p6Ko7Vs/oDsY22PQcBVmlx1BtyZSZFXQOko=;
  b=SWY0F7tJ34w5lj7EEGxldlXHuWiTS4Eoktduuzb96+Dt9BCVi/iuWNtU
   7wvvSYUkQEb+yt4GHUD3DdJrJD/iNBmBvYzmdKAtRnDJcB1OUqdOxMOTt
   EJep2rRhqDD4F64c71I9nlOSKCGrZfNNfkws0AQ2YP/IzbXvUmMjgdyxb
   xxs+YFO0aXEJZrCCDCIqeAuGfKyePmkjJB07jqD6dBP5uvpxLfa7S0yzq
   vJFusGphsA00VYH7EwFnu8QxslL5clTqifpRBbcwTTeWks+6d5XSq44YG
   A/EL2R8ZRWODXZ1lhCd/LmxxkElRCV3czhu2yRTNChrTSjLwECV7gm/r8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422434945"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422434945"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 06:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="851108465"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="851108465"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 06:33:59 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 06:33:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 06:33:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 06:33:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTySfqeiUkBd45Wuz2gAHszzor8HGkgODGeUsFE8yRe+Bbt5jmo7NISiDnMNYSDxX5uposC7dobIb4/zqdkcakhDI9IkvaLmiB2FpTRGcZKrM94x5vgmaSkiAJBpR/IsCSCGMTFOy0aRoLImm9sREUDSWrDEHZxKcVNduqSaxUAmiB4ktGADZ37radFgQ1E+BvMMTiR3gKEYs55u0+Sf8X+Mh8tBVNtPtXB1TSonjX7UkDN2uPRxAVKAufY4behhVuvX4xc+Nc3DyrEQ11U/a7rcmwP8C7z0sEkk87+vWs6ClG7GqdjL8jPBE+P5VMvkhUghC7ADSGu3Yb+WRCz+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kay067V+lh/8glzxbpdOM/+9Dk/DyiHdkAy+lpHJjWc=;
 b=gQJZs38A9ZkmL+rERixjWSiwunG4utDARyRDDcElUl01tyGeqRzbxE0e3ZUmKoXPQ8+Wq7wNlSeFQQKNUkuL+Um5NC86whx0MzoEB40gOj4MM/xFess6NJFijR7FDq5FRWQEEe5+vvs7fkchAD3SsS/8WMqq9Hejzs0T+r7BNerDBPpXWt8mBkl7nkz4yOznNP7F2PKqxMPY7Hjj+NBpZO5LJlHcfK15W5s4sltNhk2oT/acSTuR4HDdKnbYNT2mv9mpQCqk6njcnoMvHdW7lTOSWQkFpBH8/61TkEecUcQsOiZwXOeoNyliWV7T8MZa8ABHxi4h+i1azlYnDHkeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 14:33:56 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%4]) with mapi id 15.20.6156.023; Wed, 8 Mar 2023
 14:33:56 +0000
Date:   Wed, 8 Mar 2023 22:33:36 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <rkagan@amazon.de>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <ZAicwDeZ9/cxU8Eo@chenyu5-mobl1>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230306132418.50389-1-zhangqiao22@huawei.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 216f701d-08a6-485f-f7d0-08db1fe225de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAX/a1DaJ/7+RX7a1I/KquulSC42tXssTFrEwd5EQKWanYfAM/I34oHWtqpkuCWhU892wkcI+6zNyRwixQokmKTgcumuRZCvZhWhGgh/c+vIciQmPpOGvr/r4DBGDjVyYh0iX+JWsJzhPA0onKpZLxa+zgt3FZvnqvYAc4jBH+gL6q952FPoJuHNT7zvQv4BT5TcOvqQeY6RpYqsjLz/JxJWGyqUucnwf0ObhJ1aPydZ2Rkpa65Sc7TTo1CYFrYMTuuza1rooSSyN5LkbaOpQriYDBstAM2//Qm/BVy03B8RKRNT33cOfWquXhBRtI9QpvmNN8sERQl8EzBh/WsKyOZTRzVflh+FxH8d1bOTtFYW20w0x4tjzFKLaiM42/X7TXI3oq5DnVWd1keHgJdWwzI2epORlUV5Su9SnyyOFj9R+D+ld2v+osomZhfkd+i8oXbLkINSwvQkcqSot2eWKBOR0edAldszUCTFl9p6N5zJW0iHAjHf0uLIPN8VV+CKjtbc6tQ4X9egfFpZkJpONUokelD8KvYrKLZsaJZ5cexH29LDJRo3f7AG/8uY+vUKha0UzVJ7joDBwd5wnLFHHDEVcxbhamZtKdJb5H9hMADxkWnG45yHy9orivn4UKabxTh3SXpgaF3ftP7xHkZYyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199018)(9686003)(316002)(38100700002)(86362001)(6512007)(6506007)(82960400001)(53546011)(83380400001)(33716001)(186003)(26005)(5660300002)(8936002)(6486002)(4326008)(478600001)(6666004)(7416002)(41300700001)(66476007)(2906002)(66556008)(66946007)(6916009)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hGiOEIhHN/WixhhgSs29kU6yIH0NEMRWQuXJKrYPiioFrdF9OgsOp1f6SPwl?=
 =?us-ascii?Q?t+XPydSeEW1lNHxo8QvQK9lf4UwEkWMyEZE4BBUgcyMPbX3xifu7ULMeOJ2j?=
 =?us-ascii?Q?XosJPQ99rVApG7Fo5AtmEa/cFSNfEJzrufu6ocxBaIP1NB1ggpsvtSBpHilU?=
 =?us-ascii?Q?ajUe3faZVMAKmeGniWUqOo/9734rA2iLj1GnpWH/SnXVA8W1gnT/Z1kLQLhw?=
 =?us-ascii?Q?YrSFxS953nTyBk0KExRuE9vIfMQdhl55iNs9ISO4rQhC40VIzPeBUl5t4KMK?=
 =?us-ascii?Q?xPTYbmai1i4kN8l3ONJdW5iKdI2wmqxqdp9wt5aDCnSlTRoEqC0IV1G/xRSR?=
 =?us-ascii?Q?bF+Q18HGQad2fCMlQ/IKJbahSQ89EUhQjZHjbu0EwIVDdRK+FBSOCQaPD3Gh?=
 =?us-ascii?Q?wPyoKK89BMTLakTlC8zqry7hAQ7NC3913+RrNAw2utx+vaqbI4EIxtKbn4vy?=
 =?us-ascii?Q?b3hVxi1TEUjq/rAVBTfS6d3x63lCnIse0VIwPcCCzse1KalWBpH91MWvazhc?=
 =?us-ascii?Q?DS8oJDHjLGyLB4VoFRIdKkWIWDYB8Nlm840bePdMdG7w/+auJbyVIOZyzLZ0?=
 =?us-ascii?Q?l59j3voBAzeODDgNu2TnSCOymVpQKs+1Dkc99GThvJSJkLes3NpD7Tiz1o/H?=
 =?us-ascii?Q?SlbaGsug7wjc6QUZc8DhG5nNZR4RWZafKr6hIsqQHrOFBpfX6bRzQbkLLOSD?=
 =?us-ascii?Q?ZZL5HdZ6ecyjO2/ZIpB48/ol2heIed9rS83k8hRib7xVjS2AOefhBOv2tZsr?=
 =?us-ascii?Q?gdOPPFjp4AAhsln3TcsPTJ7L1eYhj9h67R8jmYmpDGlOTUWGmyZ+fWcd54va?=
 =?us-ascii?Q?vjmkEm1wF5Dr8y87+Zhy5VVz/x2if3KhE4CAqKgzUDr9vIH6B/NcfWq7cuBF?=
 =?us-ascii?Q?XNjSGoH1xRFjqC8ZIymMsuvPPhZg1xdrMI7uD+yg6uPmj9az7PsEeTzNtzsb?=
 =?us-ascii?Q?PKC+IjWnN51GEhxZpQPoLesCnzx8RrWhGXH13HN16uAKehUTsfzduLC6T4fR?=
 =?us-ascii?Q?7CjT5b0be7FNEO13apyWFmbB8jzBQrJLjgG3MmC7Vs25H6LIBvSHX3AB4oOd?=
 =?us-ascii?Q?z5Z2fzZs+xTO2fPhznxkDzKwcc2SUKXhodhNVjdrD2GNwyrIEgPOcgjnoTcF?=
 =?us-ascii?Q?OjlpkMUsOECVq3Pmzst3Cn7zi56qbKX89qilIqX+nSomKi7Ys2Ljkl+dH0L7?=
 =?us-ascii?Q?Y83uo25PB8zejd9boIIP5h3w522ZzWYQlqJuiGLSBu/1gWjLJyfoMsif9XGK?=
 =?us-ascii?Q?fAZuThx/bXQvBZyqf1JG3idPeF3Roo/mJroU/fK6CLxYE4POn//rqL/T+4/G?=
 =?us-ascii?Q?YbYRvSaZOu7ARQ3q/HG2Tgwq+fGqgXPlJBvIKOXg8sOW/0O8CEB2pjBwRSbB?=
 =?us-ascii?Q?zJudJ5S7vHoIMa63VtQJsq9DeSP8mQPjzVjxdd6Dl2dF0EDVhGU1XbmTTmIq?=
 =?us-ascii?Q?77TldVr0xZuQ0pAPAxav2Ju98iwjPmvULo2TTYppOCT6jxdc0D1nlJGMquhX?=
 =?us-ascii?Q?7DcTesSROR8y8SbdYGPHTVqTrnv64DCu1sanvc7/VHjBcmdYDq+BvN0i0URh?=
 =?us-ascii?Q?0zMW6cDV2PfBXn2Uqp882T2qTs3Tj7UWNwQ13OMD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f701d-08a6-485f-f7d0-08db1fe225de
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:33:56.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ussmvGuugxj8Bn3UkH4HVJMiL3o6AMEIaim7e/6tg8S4Q0PrS0vlx/bSB/EOPn4aKxFmKYXIj84zMlFSLCjI3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-06 at 21:24:18 +0800, Zhang Qiao wrote:
> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> entity being placed") fix an overflowing bug, but ignore
> a case that se->exec_start is reset after a migration.
> 
> For fixing this case, we reset the vruntime of a long
> sleeping task in migrate_task_rq_fair().
> 
> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
> 
> v1 -> v2:
> - fix some typos and update comments
> - reformat the patch
> 
> ---
>  kernel/sched/fair.c | 76 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a1b1f855b96..74c9918ffe76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4648,11 +4648,45 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  #endif
>  }
>  
> +static inline bool entity_is_long_sleep(struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq;
> +	u64 sleep_time;
> +
> +	if (se->exec_start == 0)
> +		return false;
> +
Just 2 cents, can we add some comments for above to
mention that, because the se is a migrated one, and we
have taken care of its vruntime during migration,
so no need to further massage the vruntime to cfs_rq->min_vruntime.

thanks,
Chenyu
