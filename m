Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EA16C2765
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCUBXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUBXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:23:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0932429177;
        Mon, 20 Mar 2023 18:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679361754; x=1710897754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I5PPemM/2rQkzb28aOjFQP2UpWXhRLTEAEH0Z27aOIA=;
  b=kqrg1C6Lkf99sevCsyAXg6+z5YVX6gqEqscSOT7SWRW31fdFDGhFsCSp
   FLv1BgPCM2yrYsCQGsm/ejyA9pet6nbNn3lN3g/3CRM1lqblXvxoHmtn1
   jK1bzMIAHgYPJLlXIClZV06nd2At7x2FiEk5jHJ7dZIuxSQHAv6QZ18xI
   rtarzOZVYLb1iQ7UKxF8SEN4Fws/f76lHsSZeTKgZJSJUZbPk9wMscipe
   eFDth2Mm6bUgUKwikw0NUZP1xRJXdcd62B5vFyaWMCHLJAtHT/8nWU7kb
   QBG1200EhtIALIXCIsG7vVwbZLO3Y5E4XlHHvnZIj4wlASPtZgQyjOVoN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425095049"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="425095049"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 18:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674636521"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="674636521"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2023 18:21:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 18:21:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 18:21:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 18:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3Ya/bxEmxLCaToBb8UN4MAj25ZhB7aD+aJA26QAiFS6qikq3kD8OwmncBtLEa9EOTNRgagp2Rp9NB068i7LjXn/cuu77tK+l9Mun588MXeNsC7y2JuPs5sAgJ8JBX6QpIsoYnU+ZDVZyChUNf36x2L35nVsWGfhrFha+KkeJU2q9lPC71Ijd7C6aCiRVKivxXHMD74g+NA59TB1C24L8/2RMwlyxZHP3pEV4q8IiFxliiGzDV5ZFq8H+3+UdvURqc4PF+SXURNewoOopHIXf0/zvsdkg38edMztK+3d//iwrhjtJ24bA/t6GH29RqqyS6/YnOdyLZi0Nx+Xjw5xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/wIgKCn/gGg9zXDOEoW7ldTfjzk9EOZg92zoApVqlw=;
 b=KPrOrLyM/OJTZ0QloWJ7T/U6qYe/ERpS6mGJXmDSZaQQc/Q5Z/5JYIyqcgOJiO3hsZErtLhGkjU4IhSJ5jZmY0pzN6IMHPiH7NtcUldEFXua5eMghz2bJwAaS3z/54SGEv5GWQxn52c9OT84os5snRaWhjQMxUE0Ra9XAqNqVaEgEvU2ELJaULydpfSqfWomuJmt0lYPQMjpqZtnVi+U0bcKixntGTzJ8U0ooxzAvrzbmfr67WdzkTaJG0qiOfOPdS9MhebsNzUZ1UkJiivnLAOGhQp/3KpBPw6ansFA1VjGj6T2o5dDB15U1DuuIYks+Sn1096s5VYWfvBrRtlfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 01:21:22 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 01:21:22 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH v2 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Topic: [PATCH v2 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Index: AQHZWJRqalKzasBk/UOCCjK5kx2fz68EJ3OAgABMiYA=
Date:   Tue, 21 Mar 2023 01:21:21 +0000
Message-ID: <IA1PR11MB61710BAF452AE6E687D8F3CE89819@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <2bbaa13a-bfcc-45b7-acce-8da59a2a0c32@paulmck-laptop>
 <20230317055006.46365-1-qiuxu.zhuo@intel.com>
 <d93c68a1-5c36-4e48-ab41-c424d903d30d@paulmck-laptop>
In-Reply-To: <d93c68a1-5c36-4e48-ab41-c424d903d30d@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SN7PR11MB6875:EE_
x-ms-office365-filtering-correlation-id: 6554e044-5c5e-48e8-da3a-08db29aa94b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmNSX4waulgED0PKwBomcM4clZ6xfKohQujb72x99yndxoy6yrkG9BvL0++m8l21FHY/EoIulsgkrzBoppLSyyXwJtNLoHoUv1TZK9hvEtGr0+ooK/IYdhaQlyJEfo45oh4/S/S/RIPM8Ib/fF2GJRb4az7ShYocFze2dd/4WzkHH0OXmvkU4dydX6lCIoGiGBtJZlxzJlttZVXCl+5J2mcLJHtSHzmMCzm+Bt7w31XOw9BYaiv2bQb7fgWV2GxT23Lt4VV5Af7djrMcZ8HxhG2lXACPt8+Ym0lla3CqSp+poik/5aySlesHgRPXxK4+hhjVi/sVeA62Vf1qY3C3q9gDB1Hhf0sK2zXjMHVjuMVS0K6FlGf1DpAStiPqYGePx7MpeM3SrQKwQK3KhgiuNh2dWppMNOL7+T/5TSDd6V21W9tjAQSwEbk8xGmtkbZKRFU7ldmpM39YPizcNuScQBkmURTIiQ0jW6qXxgM/P7xS29iOTKw5hFPdTLyAeQ+/lWG5vQjxceUsRDg7OHB/9bKhgsF/Ua3/WNZpCloMT9RJSXz9F7stWSrPASp7Y8APJEkT7e4XTNHBg43ICNWcfwfMTKLof565Xo1zm4z8DHSnCtnPci99KZx+TBpKExCO6YKS0pVmD4fvlxlWDBef9rwvH8dZK0M4DizDfpdIU4zeoFpvejIIRUT8OtTZivS5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(8936002)(41300700001)(5660300002)(7416002)(4744005)(4326008)(52536014)(55016003)(86362001)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(2906002)(6916009)(478600001)(71200400001)(7696005)(186003)(54906003)(6506007)(9686003)(26005)(316002)(8676002)(76116006)(66446008)(64756008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W1HRbP22tCEZ4ev7Ulv/IdYrF7qVSOJxjq5okkJ3DvNFi7bz7bI/JejFwACQ?=
 =?us-ascii?Q?mPPkfGZybQEFBHENEVRqizF/AUivRZHZuRceR3yWu8MYn6k5RTP3DhlvetPK?=
 =?us-ascii?Q?/riu2goc+z/2QT+KFkqOUN21GuDRLpd3pHz9rDAU6alpkOH2hMVJFr+Md9Zm?=
 =?us-ascii?Q?pWV6oiBaipjUIJyFltQY98aLrylTG4T6pTOaTPYZdsRCyLrMZqugZ+s0Gtwu?=
 =?us-ascii?Q?T3baKy9flhdbAeFaH3a9IWLTcqqjd/RUPocWYddGTqlUtKl65N8Cz+Npwstq?=
 =?us-ascii?Q?3ORTNIjqiFGi+Od/vB10+MNS+hL3h+YMDZpMvDEzk00i5QunQPAYfo88SdaN?=
 =?us-ascii?Q?bSqUEFexG7p17jnlWZeiLgVabPD3oDtk7IH2BXwnUZvMsqlsDLYtlNXN0xRq?=
 =?us-ascii?Q?riht7XCmWQ8UYX1jfApKQSveFstTjKMHdv/TzktdL89qNkTtKglHylgW7jwo?=
 =?us-ascii?Q?KpwQYB+D73kjf5ekima9D2awdNIJOUDyH8XLaNv7cprlaOuHbvINSYraKITd?=
 =?us-ascii?Q?oYCKEl8eqtOTVFI4T7TBUt8hc9XTETNrsG0RVjCDQmzT5NfgNQgORZVz6CiT?=
 =?us-ascii?Q?rsSnaMZ4qsYIV0Xdn7/V/BgXfKtRQDrXqL6rrOnNskQQJlxkC5tvGV9MLh8p?=
 =?us-ascii?Q?HQuN1p2DL0gm+RZ7kpSx350zk6BqHUhpPv2yjjbFuVCnYfmkdPvON7agZLYu?=
 =?us-ascii?Q?gN6JQD2nAEPUIPpSDc2rrkvhF/L85GCVmzY4Q9IJnE8oW9P+GQVXtneprS1+?=
 =?us-ascii?Q?OkQsXvwwsjm1zjKcu6sZeo0zvoc39hDjt5GvGMzgqsu/XD2fWBMIF3JW2esG?=
 =?us-ascii?Q?Pg3wKIXvp1HoVB4bW8Vrg6M+XBDJ1wSJybuFuVDYd1DJsJgfhKLFopxHyVFu?=
 =?us-ascii?Q?RkBDzMr4ho460ll60z5dnx+++yVXiv1W83pfbnQunyfP6ZVeIQy0pcGVWtS2?=
 =?us-ascii?Q?wOwf8tGuGagncWBog3IR52HplXNacfXC/DHvuGQpNi6cJAfK/Am5sZUt+Fnc?=
 =?us-ascii?Q?p6x0twOq3ZE9wMxtE4nWv9/Y9bN7NLacxx6m5eMccHpPqwlIHQ31up1RzFcx?=
 =?us-ascii?Q?iwjBzkRl2VWqyZh8Zu9r20mWSNxgYah2VuGRP9EIrJ1EDlYsD/DL9imiwWep?=
 =?us-ascii?Q?kZHLtD97qEYCRQtncC3f/19BftPvmLP9+ZBgzbCHVVF3iitClVGxA7zcX6+O?=
 =?us-ascii?Q?4XHm3ASrx48+tA7mlunKTARdzdSwKc9AnGkCNRNwhRrFehHkgyGm0x5B87yo?=
 =?us-ascii?Q?vT58I0JOmzbm4v7CbVaR8q8CHn1m/mLkF2/qsUhIoyTllfo7qJ/IO5MfGfSp?=
 =?us-ascii?Q?1SEKCogx03/vOJNFYdbkfb6dLmxQuqUWC3PsQ7rsJiCA1nLVQruY33MbM3rC?=
 =?us-ascii?Q?/KBHkTf1W1MLMZhppFDZtt/wKUJ1Cc0ByDq6eX1vY8Q5a1kCC7e3Nebw591Y?=
 =?us-ascii?Q?QMSC09oFPnQz49s5n0ZWEsiEiKwnV8GfjwRF9dlnl4Vz1vaEWk8rIzu/7urD?=
 =?us-ascii?Q?BIri7Pm4Wv2xatbsYB/TPdudeqz2a7xlTkYPjbkjbCG1+FqtyaXyZLH+EKIv?=
 =?us-ascii?Q?qggBT7cxDoD1b3uaBFyTCuhzr+1uOnvoqJGEcRKZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6554e044-5c5e-48e8-da3a-08db29aa94b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 01:21:21.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3a1GQ8SsIdL4o9TKS6VQWVm/sLSgIA7kaFluwfngHRqRY3pNn04vD7LgbUucEdqMoKTSvQ9FNUioZlqb3v92xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
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

> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Tuesday, March 21, 2023 4:41 AM
> [...]
> >
> > Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>=20
> Much better!
>=20
> Except that someone glancing at this patch would be hard pressed to see
> what changed.

Indeed.

> So could you please split this into two patches, the first of which does
> nothing but move code, and the second of which makes the actual change?

OK.=20
Will split this patch into two patches in the v3.

> The commit log for the first patch needs to clearly state that the it is =
code-
> motion-only, with no change in behavior.

OK.
Thanks so much for your suggestions ;-)=20

>=20
> 							Thanx, Paul

