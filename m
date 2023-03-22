Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6674A6C4005
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCVBt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCVBt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:49:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F639DBF2;
        Tue, 21 Mar 2023 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679449795; x=1710985795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+5keYJnWA+g7tOPlNJ6+6bJsUh7oUTcKtahk4bRq9g4=;
  b=b9qFtx1BkmcpUpDS5XoLr+4gDwl5ZEo0LqjFBCSUgEEwIz9mDCW0R04J
   80WFKeRBa0dLrGm8HG4b7kgetR/Nu6KZ9CEsalXAWJpCazB38Uqbf7np0
   b8Ps711UBBjNLDLyYJMAR0DkCwNBwcn4ydQyYAXSpElbQSa1jETgxZqWc
   sipewmcXwMFjbURdQaZ39llUWK/g5NSjDcc5Y7zwoARzoQePA/Ntb2YMu
   /tZ8QoIXBBOe4Z3puqdkR5hjq11MprFPGUcji4QcW0um5lVx9jQGC/lFU
   ZpaRPTomw96n1Y2YuB2LbDcqV9jhjfvGjJjiS1km7fwW6WA7O91SpOMuK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="318748328"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="318748328"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 18:49:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746116880"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="746116880"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2023 18:49:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 18:49:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 18:49:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 18:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWfoOMcgn124mt+F47/dPKTClOd2zRmRcMXNKJkPACCo11mYG9OT2ydHOoium3MM3SU2UI4SFYT7EOuC7ViZ/x488vJ8WR3RbiIgGDhOeXEdUNSFFZuY1gK6oMGKFNFf34rKJVSKtwT7NU98iMR9hS7aGeGskPFD7m1o+JV+gZ0OTRhXPZ1ysAE1Qm+kYrChHyUn/TIA/DFXeqXnnJd7ygHMqEi+V7MgzjGEJBu2ODm/szKzekIjX4RgcEaha/lCKVyMbhHCQfRIHNnCFTfC42Ka9Pj0BQewwKaWJnSHBv8mfxhFRts94xSD2jtE/9XCRGAW/KzLBcZrwpU1wXJiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5keYJnWA+g7tOPlNJ6+6bJsUh7oUTcKtahk4bRq9g4=;
 b=nKLBLPjm4Iy49+5jLh/fXtTuyP5FLkmrJbLatuAZ2173ujwOJn2xalMynbKBODi5pDSLzo3DzdZOWpl3vjGgQm2MYL+km3ctPQwCkAHDuEaEGlrXL66VtaKKkn7cWqc7mau62/PaInt1BoAktzbbvgGsIh60psWT3laCjGe37jPos6Ii8EwMgmVGrudmdWjFyVz/j8MjJLhADFjipu+qEp8tuFK0PRUM7piYPSiJ4/HB6FmDsb5A22ERD9G3QhCtebeFhxFGRHpMjjtHk4QaQsVhbfK0Q/k55NYPuL3/ZjunpEhvIQZdnSTg5GV3yehjUe3Iv6omQUAEi+fEgAOjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17)
 by DM4PR11MB6453.namprd11.prod.outlook.com (2603:10b6:8:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 22 Mar
 2023 01:49:50 +0000
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53]) by SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:49:50 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cgEn1/2PZAki4vZrvu1Ahi68FQZQwgAAWuoCAAKr2EA==
Date:   Wed, 22 Mar 2023 01:49:50 +0000
Message-ID: <SJ1PR11MB61795652651F41A8F94B1E9D89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
In-Reply-To: <ZBnKKZsSpI8aAk9W@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6179:EE_|DM4PR11MB6453:EE_
x-ms-office365-filtering-correlation-id: fc2c6a3e-2248-4c7f-8230-08db2a77b982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSplDWxpi/sh/2KL7vdwCi2oxjAYuJXVHFKpnN5bf82eTxdglJo9DycvuYByo6FLtyuN8mcp80EpfkAKQsIlVuHwBRvF0LmDkmDb3HC+QUyoXexN3zO+ORPRXZVxLLGvBSFF0n8vXuQedh1HdBMT+YQby1PsruyDHG/DPe5QtHkzX91gIDVvFxJFdo2MMDewYejwZa6zQwhqsaKM3p/O6Z1FfhcKE5eadWsBoHHzy+bYOITx+FWe1+/UtXffa6sdwyWSrtoR/NyN2LPJGo9lc79ybBMz2GTCmfBzqwvjxhd+EAE8hdeIQagUXrh0LbDEiAqQQcB93QRKSf3DxZ/kR1jDdSS/V22BUId9/uTZ+mP6tWyJfaSSIVz88ZbLrxOoqr0k7nvuqymwYJpboTZyTtW8Pa7Yu7j02talmHRwa1ycBRW4V26FDxx0VLS1PPBAjd/IaSANwSWS2x/SwuBHL2QhxMDf5RW3YHdJ1N6+tWzh9EPc/2UURPJo7NowpOF9jpmpdIheiAcoCAM4AlK2BGTXOVQc84UOw0jyAxK0RA4qColRyZGI6etYn8Dxwh+tvSPJX2aTncdb3UgWDmu3CnNqZdfkgDWic7eJkn02bHPQnklqf5FzGJmLxVziDcShTVcx5cON/6EgW4f4USq2zycX2QOLHTB2Wq0KnQqIfWFC0yM6V+018DvJidQbWWwgbtqvqfjfqMsqvcGg3bxfYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(2906002)(5660300002)(8936002)(122000001)(66556008)(4326008)(66476007)(66946007)(7416002)(26005)(186003)(52536014)(9686003)(54906003)(7696005)(6916009)(8676002)(41300700001)(64756008)(6506007)(76116006)(478600001)(86362001)(71200400001)(55016003)(38070700005)(66446008)(316002)(33656002)(82960400001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JlhXNsLfTUuVqYwGGC1RWsHMQo5L3juZveuv02uaamj9vzPQ3FGNiGQeS3Tk?=
 =?us-ascii?Q?94d/Q1nNPhVFpZSAB89NWQSrUbOXBWItPTsm5s0yW38WIXqZ3crn32v5mwJz?=
 =?us-ascii?Q?MSME3FAVVBvSRxxtqTX0eOJalSUum3XGw/JQAmPcEVWIfG+hYUQ6MYaCa39K?=
 =?us-ascii?Q?fmiqOMP/fjtmqWmTV7Hgzi+8cZLlzxxN576gpiFhutsZOvwT3LkIqNvz8x8z?=
 =?us-ascii?Q?Ged2hqGXJ+990wRUPQWbY+k0TZyCeJFshWwEq7c2q6tztdERtL6f2tV6Gkkt?=
 =?us-ascii?Q?8Adgn1cxnPqQeS+1NeGD8WQSBCtJEP7zGZ/tyoHedzeLSc5oLr3ifI+vrwzo?=
 =?us-ascii?Q?Eqo7ran0NzU/OakFFC0xINX7Bv26w1AzQg7VqFif2sKnYcL2ldXQVa2Jqp0Q?=
 =?us-ascii?Q?VAPFsUVfTRYFdXrJwZJSquHOKDdtXpEjCOBqaL3ub2XpipUbvLi5iaNFCYOl?=
 =?us-ascii?Q?WYdN3yErCrCiKn0d3IS4UqiEfafA/cAqj1P5RFVartNAydzp2I+dkOq1iEb1?=
 =?us-ascii?Q?AtYmTz446JqfCvK45biSaaW6fcK+17oAKh5tlMOOlkLbvxHJyErbNZaEXvkf?=
 =?us-ascii?Q?U6Qpt4mIZxHmL2qnh4RoYIEZ5XzoOCqRt9zv13SFOgp38GK9DLITGv6PtoOB?=
 =?us-ascii?Q?Uen+tSM/O6qEKDwb8u6GhaM4BuQe1sIqaEKTXT1ZJUzy9TvclAxXO+VfhI86?=
 =?us-ascii?Q?+mSBSLn6j7QW5Ry4HvXSUcKtvleq8jpLchApqcq/NWzRbGVMfrzOXLYcpVEp?=
 =?us-ascii?Q?E95/wdoERydmdnrrZdWgLJ0gAVJoq/AHkmJTe7y3NuHeQztNaogFurcVc0qC?=
 =?us-ascii?Q?39mzva44YnU+wwcQXT9IXu0XkBnDJHJNo1IyGSqaCt46HKvZ1mQBXTkn4WAo?=
 =?us-ascii?Q?EweuDkJDUdqRvLrSeaJo0YEwpEbqdAY4k0t+yZMf+qYikxd3JMVRQ+XHr15J?=
 =?us-ascii?Q?2PnwDqADMxo+oUpvyfMVBXCF7friKVvsnq8O2/Bsbgyi8ZKcnyH2b8lSsXUV?=
 =?us-ascii?Q?viY/gbp7Z2XDhQjD2y+hdufSeEuNfZeMr5VkTzsQgwjnCcLcmVWC9DYTQrpJ?=
 =?us-ascii?Q?dKSuY6qUjwQetPZSS77WNEQPTa725SdsZ3nUFUhqr1MQ3CB3TA4nyLMoGPPS?=
 =?us-ascii?Q?lp4IGuT44vbrLZVoTKxhDqaN3j4n28CtSWDpiQ5PB8Gm7T02YYOzV6DgpwAy?=
 =?us-ascii?Q?FwWldDFDqKF4oaC2A6aP7E6HD840ffxEavRt+bzugFJcIDzLNgbtEdnpd/VR?=
 =?us-ascii?Q?M10lOObJxwAeXwxN/JPr2CCtAb6XNqXzfm5Mbsjz/H1dKKZDqnhLKHg+pxVz?=
 =?us-ascii?Q?wzwDo9tes3KL7vI7kRFUZZuWVn1Fo3tumFk8uo+cRLaqCe2H2PcecnWcFgC8?=
 =?us-ascii?Q?95e8Eq5TQnPz2bbhUIw2kb7iDMqq5GE/MMMCOiIByXc2cMxHFn6zChFvzQbk?=
 =?us-ascii?Q?bc85h2gpcTX6ebv1iitwybgW/J2Tz9dfDXouQKgajI0VFjQgRGOzckQx23Yx?=
 =?us-ascii?Q?dCZOr8WVEuj7zEf9Wiki10ZLNNJYGa/mAReKTea5x4Uj24BEkPoo9PRUkzsI?=
 =?us-ascii?Q?iiVNVoIyqm1mVApKsZBhq6fWuWREmnj1fnArQReO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2c6a3e-2248-4c7f-8230-08db2a77b982
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:49:50.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oq920xBUdJE/eXS08YglFTdxJb1AaADIeZNNO9Sq8m2QX2n/nnqJevDKcbHriYAif1N/SgRkFd71iKYFL1o1Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6453
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rezki,

> From: Uladzislau Rezki <urezki@gmail.com>
> Sent: Tuesday, March 21, 2023 11:16 PM
> [...]
> >
> >
> > If possible, may I know the steps, commands, and related parameters to
> produce the results above?
> > Thank you!
> >
> Build the kernel with CONFIG_RCU_TRACE configuration. Update your
> "set_event"
> file with appropriate traces:
>=20
> <snip>
> XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end
> rcu:rcu_invoke_callback > set_event
>=20
> XQ-DQ54:/sys/kernel/tracing # cat set_event rcu:rcu_batch_start
> rcu:rcu_invoke_callback rcu:rcu_batch_end XQ-DQ54:/sys/kernel/tracing #
> <snip>
>=20
> Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 =
>
> tracing_on; sleep 10; echo 0 > tracing_on Next problem is how to parse it=
. Of

Thanks for the detailed steps to collect the related testing results.

> course you will not be able to parse megabytes of traces. For that purpos=
e i
> use a special C trace parser.
> If you need an example please let me know i can show here.
>

Yes, your example parser should save me from a huge amount of traces. ;-)
Thanks so much for your sharing.

- Qiuxu

> --
> Uladzislau Rezki
