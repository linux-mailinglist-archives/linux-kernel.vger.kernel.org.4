Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD36BC19A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjCOXkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjCOXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:40:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40054AB0A8;
        Wed, 15 Mar 2023 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678923510; x=1710459510;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C1wKYpkaDdF1mYZtgUG69Y5PugwCaviTlCdsGIxJwlc=;
  b=P7RN2qijJBqVxtyG9FcCJDBXLPBECCVM20Xv2sanp5+tIOdC7+lJVinp
   toUIFIjW7MCqhuGfUU5GCSS9MxxLTBEY+KAYXrlG8fLcNb60dliSqSZrj
   NINSCheeNh9NhssiLMLoZV0fcNK3oj9EmPWNBKWnLYmfdXJT9UUuZLntv
   IpAkcndlwl/Bk2k8TMfYrjlOEvOjPTjNMQsQr4RnKkQezzxE7xH0LmQ51
   ZRx64zB73VzgRI5/uSrIf0mFBgrp4Vnzkl6uQjKUTzpxu2iWWjQhODALj
   GGU0vG9mBx4QQ0KvbKCHtmg/w2tsjORJ7+Q4j7JWibCHVS+BRYZA0Mmza
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="335329036"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="335329036"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="768695924"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768695924"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Mar 2023 16:35:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 16:35:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 16:35:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 16:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqvi3HFJQh9ND1H4apFXnNwyE8VSmWL1Ixa7tVBDL0KQaPZsQ3sjdel3dAah6Xvtw6M9aHfaHd9f1XFaY0nytlBwsbw6sDCkVDww+/wR/AsyAFAMRXvN6XGGtp2lbDMS1pej3+P9l3wBI6IngZ3TPDpaLZLY061LKPNbns/oNoiKGwxt+UgH3NeGl1OIp+TXhPbO3af0KqB2Spm4VGdTEy34cUWBB2R8uLIIXjy36QTBrTbaqvDb7P3NOGpaitazsIWVV4X031xpXWlkPcU7e3UGhwo7oYJGf/rzvr02++Sl0mQaOM0t84KrM0DjguNqc6Az5jOeKgtizoVuEYLoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZN1TkCXsINQeWTF8HpJbJiRlhAUdPLPLGHValLAeNk=;
 b=HTQNiN7tL+APYRGEtaxlqbn+hltcqnO/YvaFr9vXJxkXf2OIhdvlTiwbrAKOhO52hWFx4S5Xa7lnyI9qrusS1+UFKtVv+rGkf1C5rgDNkNzLWq0fvkVuu2xtoQkUlc+R/fozZ6rrR8FkUOdNRen19FVmBVsTGcxE5EVFSDDP4FVKdkQ45TnDbzAaZjImvfLmOSlzaTWooDY2cnz4e5KZZl/2tpg4TOMy6szizkRSeqFoj0yQFIn86JkdRHJ/h/wGHYNWOQaz83QI1Uguy53TETPGFUchaIwvxvyKmUxzq4i8Z8+cAHFD1iFo427RGm4QnM18HfUBwdLcL9NyJf8sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4668.namprd11.prod.outlook.com (2603:10b6:303:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 23:35:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 23:35:26 +0000
Date:   Wed, 15 Mar 2023 16:35:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH v2] async_tx: fix kernel-doc notation warnings
Message-ID: <6412563addf9f_269929487@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230314024734.9066-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230314024734.9066-1-rdunlap@infradead.org>
X-ClientProxiedBy: BY5PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:180::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: 71145559-7295-4abb-c091-08db25adf40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRj/Q9cWsORAzRsayMuIPdionnz4Bj+g7ctlwWuVELyduivxdhdx4am4MkG4FlJv77G1dBL8btGrCh2eu41/vOw4DZrydPmEIChI2967cKQn103WPYIdr7aujl4nAJ2Zio9pB14P//IFOX7JOcozN6O/2eexdgR3Xd3pT3BWA6guLQrD/34SE+ua2dJL03LWZHKD3NoegiANc8kOKJ6nLHqCUg/oSX4NIHkzb/XmbJzFO2AH7W6IyiNl3pNgCRxMooGgfbWM3RZ1VPjoZuiNyYUnx+goqz1+7FnsQOysr+bJE17ngQyXjyxhy0W+Pr9V209yQtgr7KsCpEZCed0/Udgp6jff2u3ahifLfuyf+Oj+GZ0CvAJLhE+RLIQj4Q+dbq+Y7BEP8x+0YIE1OQh6wrUZECGOItDWOlA5f3m5UfhHCwFvVcrD0Lb80z5SL+dteu8Cu674fMrDlTvDUz44M0I6Lua0Ytznex1ct/H7N+OFbOIr3AyyjqixCh5J9p12f9hgYROFitekBLsU9yLrWpi46gKu+qNDsu6EAwZJhMvp57Sp6GAPHas0Q+pOTWr5ChXBWsUf7uCi0xZJ+vazzcmeYmllIT2FRuKclHkiWZFRASCgqFoA095BcaxJ1aykEPH1H/7OA2EWwyNMvPGaJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(2906002)(5660300002)(8936002)(41300700001)(38100700002)(86362001)(82960400001)(66946007)(478600001)(6486002)(66556008)(66476007)(6666004)(8676002)(26005)(4326008)(54906003)(83380400001)(316002)(186003)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GxNCAs+VfaiZ7vSJtFjrQzGuuef2/FZ/TMVf7WDaRUwQBQgdO8UqEKskKph?=
 =?us-ascii?Q?HTByahzBRaAHZXkE6iApdiItys/6s/ZKYSAq9cQeRmtk9m7hD+AcomJbGUuq?=
 =?us-ascii?Q?uIJRuC0N8DYYnSpNpTOgXldSivfdYTPLoaH+nz8wfLoKFpSyoeimNlFGys7s?=
 =?us-ascii?Q?3lrJxaMPJj/a0GAmha7M9r5lAJP3TG3SxILhshKzMmK8OkbePm0Qhx/T/B2P?=
 =?us-ascii?Q?jxN/7a7DUXcHwXnQujOo4vh0OA5b1IoEy+R3a3ExQCIHjoFFCmIX4byODITk?=
 =?us-ascii?Q?hLIWlAH88nUwACp29l4e+2o9HQJlrjxIzoXUkBatZGlqLMCLqhqunM/juWQH?=
 =?us-ascii?Q?V8tPr0gQ8mg4SCVuFLCI4OYDPni+A/Ab+4OCH4pvz3xpys8Qp09VjIPNwrUl?=
 =?us-ascii?Q?y4J+2Tv/ziYQ32Wz7O4zx6SvTqo+haNrX+s3TeIUwxGGTuZgkI29X6RnmwB2?=
 =?us-ascii?Q?ciMjEuIfucbV+SB3ZhBcdcosA6dmFBqom0BI7vi/mZu02qWSk4c0pFlGhh8j?=
 =?us-ascii?Q?ZfU0o5nWs1d0yY/37e40pkAKsZhUkD85Eia7Gosp9LVTnX7WYnt3XnVhJf0G?=
 =?us-ascii?Q?hHpF53n9TGiSZ7E1/YL/b3bf2q6qGxUbkZKp9eyGoQDaT/ivyg9UxgkjLPpi?=
 =?us-ascii?Q?q7/KPxrP4fmMtJ9c0GNoaGR1WzPAupSS14YS0VBABQRdqTTYXPF19SX9+YMO?=
 =?us-ascii?Q?4krqRbw8BfOgo0Yt+Ofy0Kcby91WeJmy0knANx4SqKnlkevVuzuzzcbRGWP9?=
 =?us-ascii?Q?wW0r9cqNMIYTdXKT+cyO5jZaF42ZOgvwebTI913Wh2gRgRX/J1bBYZvyiSX8?=
 =?us-ascii?Q?gYz0jgFUAd/7gZ5z+g06p5zY0UwqfqRJCkdbZV05no8ksX36aqpWh4DU33HK?=
 =?us-ascii?Q?5PUu7qfXDFSCHdGMEkz0KhasT8cv3/iL5pjlNT6GVDxsDm8IvEOZfLIieneK?=
 =?us-ascii?Q?LaMsIvAi87/77C+N/XB7o6fi6XgeBOuMMeMBZm/wWNFSa4WByoAr/I4EOGsy?=
 =?us-ascii?Q?uobiULtgue3jIkTq6gqxlAlzhQ9yDUTs/spIGSh51WJ56t+4idKDuRPtzbIF?=
 =?us-ascii?Q?r2FWpaLF6IGK+VSI2iW96OVrGGS7WNdmHxubmWN4UTSuO8dRMFXe7MnNolCz?=
 =?us-ascii?Q?fYSJP3dk3EjheBlU6wJRbEALAaavJPBj3Pgkun2dF8qKDlXNo0aoGVMpzn0p?=
 =?us-ascii?Q?1Gma9/nLm4Xcxm/hVkOWw+4WW0LaIKa4lU7E9QXXntXYTvcFGJWCtyobUU9/?=
 =?us-ascii?Q?OPXQ9nkEwWRvLTg0pAXwi/7yhXXcv3/oylCCuqjKIKjfGnEJVy1+MBBD/Ysh?=
 =?us-ascii?Q?RZw/vFg14aKuRlThC6zD08joU5kj70qYJpDLcp3keLvdqJSv07vFu3trH+7Y?=
 =?us-ascii?Q?/JjwacRtarUBWKrSWp0gFotf6Mr0CnWCW3FR/6YIOvJ6BHRXu9LClGgLsVZ7?=
 =?us-ascii?Q?Y6ot47aJKkiQTFQYPLlcKGgQqvVVgvoXgr+6T7bKI+W15Sj67ivSW3AtOcyO?=
 =?us-ascii?Q?7JY+8blzlPZYkJhK71EIArHQggYAn0WaWrIxIejvev3kofLP1IoDUZ7AEdrX?=
 =?us-ascii?Q?FRu/CdMZpC4BMvVbgw93N4tYDRPG0/yL/2C5egm0JCgc/ZpWuYdhy0F0iDqf?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71145559-7295-4abb-c091-08db25adf40a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 23:35:25.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igyuDtleOjmYaDb0/28Bb1bYNsfcvDkWuvaQSZHpVLYM+QqCcBSsaWu67Kv9UAmhdokZrh0X5OTdSkcs6gdJR0g4PZQEkSpvxYCG3l1Phas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668
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

Randy Dunlap wrote:
> Fix kernel-doc warnings by adding "struct" keyword or "enum" keyword.
> Also fix 2 function parameter descriptions.
> Change some functions and structs from kernel-doc /** notation
> to regular /* comment notation.
> 
> async_pq.c:18: warning: cannot understand function prototype: 'struct page *pq_scribble_page; '
> async_pq.c:18: error: Cannot parse struct or union!
> async_pq.c:40: warning: No description found for return value of 'do_async_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'blocks' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'offsets' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'disks' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'len' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'submit' not described in 'do_sync_gen_syndrome'
> 
> async_tx.c:136: warning: cannot understand function prototype: 'enum submit_disposition '
> async_tx.c:264: warning: Function parameter or member 'tx' not described in 'async_tx_quiesce'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
> v2: fix more warnings

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Herbert, can you pick this up?
