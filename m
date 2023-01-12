Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E292666893
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjALBvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjALBvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:51:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD641D7A;
        Wed, 11 Jan 2023 17:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673488278; x=1705024278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f9AF/chgCijaY+2VnGTetW0iMZqrSQu+6SRP2hpnuKc=;
  b=beHL4goNWi/Wpbhbs2wCsHiICq9dZhtJviGUkn7l+RhCp8BovcQEif9l
   o9k5E/owVyNgPskOYgkcQg9t3ZHfcIQHiLpwLualzgsn7KBc5CZTZDEYc
   l0xoWfSeQW/BdPwjtjAiOZYkZ34lK1aoJv5fSCDLRZe3VizIjIchG7C7/
   VH5/cqjct5fvqQKD3aXz27d2TGLQC37lbDEaptIA/VEoF7qcCPvsxCzN8
   mdI43BR3G7sjeFwPuXJkJxw/w6m47XA/nKk+NZJKJZIdqDlsJZ5OVv132
   o/k0HPzBrZSZkUSKBtPQo+u7KcPl5FAfxkUTQ1a0Xue6m2/GZVVikIaXX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311409159"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="311409159"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 17:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657612124"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="657612124"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2023 17:51:17 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 17:51:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 17:51:17 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 17:51:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsfOgExkaieNBob/fSC0fCAtX5JbEOK9lg2ZNkDJfgrP7w0WY1FhBfqpHqZmU1EhczetN3PzaS+GtNlXSsA2empTQCwEhG/SLTn7emx7mPX0POki9vJXfKn4wx+IMEO4qrizLCNhn5wxzQi2EEcn2qIlTdEg9+olBvoFVCU5WslFqTucTsstdHJGBWuqWxIO608aTULdo/2Jf9lKILTBi0dpLP1Qcfb3pdjgPxTN9M0X2oBwzGT2+DDnYSt4lqzKQ1FjS9DwdWIl6ZI/EGqaYrhZEfHwdQTNPMpwLLdTQV4EJr/U0Q4yU8/0neLQei7ZFlNhPP7Yg9RVj1sG4ptDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXktvU6rdoLqumixu/jIJIYtCpCM3QWgSqz7c3eCjA8=;
 b=JAkwTvGwIwENFjg+5UiCDIA32EFgyFphIOA2remijkpVx3kqcJpwz8JjnKqy9oM39xHx+PSgrGKylDLxkdf4A0ARvZ4o9jc/360/1WO1lBImVnSvvbq7abaalehnHO9GTJagMFWIbCEjaFEnbctp3ikz2MvAOG8PFSPHvkLebTG2aLhwFUxTkqcpJQsoWvzbAoAPl0/pF8oAHQkIQCq2ETdeZ8kSqOaKGbpfR1tGKrpjI5BUvv1jXr1v48Wuiy3QmnXSPacX7YXb9R0nwbmu0+pMhL8tBdYZRZLuukILPhjNhvehKyW88Pcj9LTd32rqJudm0sGqGCzcX5JhfskL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 12 Jan
 2023 01:51:15 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 01:51:15 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix the start_poll_synchronize_rcu_expedited() be
 invoked very early
Thread-Topic: [PATCH] rcu: Fix the start_poll_synchronize_rcu_expedited() be
 invoked very early
Thread-Index: AQHZJb5UWQa/x1vzsU2YPlwsTIa6Ya6ZTB2AgAC1hwA=
Date:   Thu, 12 Jan 2023 01:51:15 +0000
Message-ID: <PH0PR11MB588065795A247B479F692401DAFD9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230111131453.1626214-1-qiang1.zhang@intel.com>
 <Y77MS0+8Hjoxaog+@lothringen>
In-Reply-To: <Y77MS0+8Hjoxaog+@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB6789:EE_
x-ms-office365-filtering-correlation-id: 5185fb64-9470-4d14-4d8b-08daf43f7d75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+xaWS0uhlaDq/HJGZJ1rZ2veTKAKSYor3jvoAiHLBAdK9bujIjlZSkt62yQ+DcdpnmUrz94JknZSCvGKfzCu/BjWwEhyoMeoNZrmMi+wIWyXLuRsjNc1HFAZNDnDlgxUOpJ/mzMrBgzoHZX5BS2SFyGhwRhVWgo4BLBLJn8E3KStzf+2lH+gvPG3bg9Hl1od7yXFO//NhpgS3bvL5bUntlvC1dqXWTO/YS+I+EENie7IXi16F3FDNfRIPxMPrtO6OvcLJq1wTTIiBD+MYqmkHH+pwAAyJguMIa3Cb0PsCsGARxiBN9dgZFumu/2istSuKUWPH4bj7YSq57FJFNIV7GK6yJvKaQt5wImypcn8+1eg0nu6lNHus0e+uqD0wbh4b4lhJ2VoIbkMSfHrHuI5CK1R4f6SGMbD/BEHi//+vMgnAcJtuJEsVDiN/T1p9JzDWJg83RIv7BcwjahIJyNwzxdCKvTyr+pE9VM/hWn2coBY8X4cQ/CJoLA7r3Ayas2iyddXUlGZGEbokmKuZLRyIFt5y5wwuShYnyRYxv+h0yGxzfqiKONi2A+276cmqYzd+I/KK8tl4tALCMHvAFrnd0xb7LoNealJGxMFzlCuPD90D0IU4S9WnIqto/LSYJCgbOWPWRLLRt66lqzWZJIJZsKsAaE2kgfpCBxZZqZJGaVKlvAlQOEk78cGOTHKOfE4kvPD6JRxqTr6MTcxtUE/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(38100700002)(26005)(186003)(83380400001)(9686003)(55016003)(86362001)(33656002)(122000001)(82960400001)(38070700005)(2906002)(64756008)(66946007)(54906003)(110136005)(52536014)(4326008)(5660300002)(41300700001)(8936002)(8676002)(76116006)(316002)(66446008)(66556008)(66476007)(478600001)(71200400001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VDe42j2QM/6tQE/3K/hKzR+R1KBsrhT9QdorvK30rU9RYV5goHg5nfnpi1Xn?=
 =?us-ascii?Q?PIVZZlR7Xvtsff5hoRh8mrXUX1yW8Iepv8cIlMOe03yDYAFwgkD/AruyP3Ii?=
 =?us-ascii?Q?CkTcudaSM8iT1YZ51Dq/+edoo/Vr0TTPjFdoZ4GL648tq/oaZexUOMpvjS8k?=
 =?us-ascii?Q?ZwhHXewKVSIiyLw6LknPCB2rc4E8Jjq0h/KYVgge1oAlWOPCYjaYk1+ve20z?=
 =?us-ascii?Q?z3KYygw/RnTNWxtNXRD+m9c6kWOMRWED25DFmJfMzHIn9wvIiUr47r8FnKWP?=
 =?us-ascii?Q?kLonF00wUhLuvk0/qzNgrTH0ZrudBxdMglCCsg+UuYPMZ/McPonQxdtbpVbr?=
 =?us-ascii?Q?Wl6KmEvFKObXBliq9fEHxpQDKRz3Bt9I3xhl7qbem09LkAkJdSMCeV+cAI1u?=
 =?us-ascii?Q?AVAG1+ouKITT46ALbf4MdOTji0wDeru+EZWVTff0mf7OdEcRcvXLMiFjk7t4?=
 =?us-ascii?Q?3DecZYrf0S4nS5YQc7b/mHzmEcVILFOf7Q5o6q1H2l6hmSuLHizMVwOobZ5E?=
 =?us-ascii?Q?chiY2gVMsZ3FhZdTxgvMBzLjE2mJvQ4XRKP+FXR/IkN+M6jsKAXagRwwFw5o?=
 =?us-ascii?Q?Ty5vPzbSTNWtJN7uWLu06+Nib6DdbfVRGk/QD5/WFO7MNdOcYDOlFUzNDaTs?=
 =?us-ascii?Q?jxlD3fwZnNZPqBkeMrHzJjSwZar/mK3iCxKJQXgtL86UNZiEQa9il2eXUG7I?=
 =?us-ascii?Q?ZFyGxVXMwzzbhEsnU6MKPitXuTQqptS7ihhAqIDvEdkr32ZM3kktORQmSidc?=
 =?us-ascii?Q?JVTdNxIK4ngMedbvWnD9Sb/EGkz7Fby3uVCcMRvXkNgb8l1c6Z7DDTPSgWzp?=
 =?us-ascii?Q?kOgFYOUMMcOzlLS7hFK69lLyGWlw/iAA34ApRsXxBRRmh2N80wFfcfaY2hN5?=
 =?us-ascii?Q?KaN5xXlcSsRubG4Uv4Dh/rGbc01wWk6cNQsuPbimn6ZEruGJEJmt0WmJaJ8G?=
 =?us-ascii?Q?DSRs8w0cifuYVj+eG7ggy7O+/RrC5xfdfEQi5BPlfguSfDhWjZZxLONNM+2I?=
 =?us-ascii?Q?GqJ6Umu78/BbohfhnVMSbrSW6BC+cx9AeQaXZJBe5bzlaMjuDvYCbnHlj43X?=
 =?us-ascii?Q?QIHctXdmPO/ZZDVWZgojOFFcPxl/PnWkcgKqlkIl7xrqjumZ/v/v0Qpnupgk?=
 =?us-ascii?Q?wVG7UIvAlA2qmm8pfrYG4G5fEkhser7AS2UjCcFGj6nEc+vXYqMloylHt+Wr?=
 =?us-ascii?Q?jSyonDHHIF0KhfCJQ8TyzdsycA/kDpDhlrlLLr9YIQP9vC+CM0T96+vSGE0G?=
 =?us-ascii?Q?zTZMjkujr+t0kg39pCBIHRMYzl8R3aIKmg5vhuLiFA+gpz2FjUCf4Ug59Yos?=
 =?us-ascii?Q?l8WvkLXtWAP5WW01CCjJaVWKmBzNC2R3a6zkeALtwzYew8U8chxWhy0ItRNQ?=
 =?us-ascii?Q?lE5qShWeSmM0/N+a3UOwNTeVHBTGq8oRbdtZUgIfnmoh0lFDyPcW8ajXesHN?=
 =?us-ascii?Q?YVcA9HFA9SwiQTpMYgcIDTLZ/KKfOuxdWwKN/BfhHYdX9tTsM3aRmGCFnUqg?=
 =?us-ascii?Q?kovQSkGZI9ensNsRUZDdif0VdYIEYRDVRjNpDaUk4kdBUXN7zAdvu14wagVl?=
 =?us-ascii?Q?Hciv0vq/Pn+wJtNeDJxwvl6e3jmjuuvRxQ9U+pjd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5185fb64-9470-4d14-4d8b-08daf43f7d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 01:51:15.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H34mJkTP3uHwlMe8pBz/q1afA6mwAYM00XqAaeM0eag2NqkX36Uv+OJzVOMxLUb7WHqsyER4XsIvi/uPjqmlsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6789
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

On Wed, Jan 11, 2023 at 09:14:53PM +0800, Zqiang wrote:
> Currently, the start_poll_synchronize_rcu_expedited() can be invoked
> very early. before rcu_init(), the rcu_data structure's->mynode is not
> initialized, if invoke start_poll_synchronize_rcu_expedited() before
> rcu_init(), will access to NULL mynode pointer.
>=20
> This commit therefore add exp_seq_poll_rq member to rcu_state structure
> to store snap seq number
>
>Is it even sane to poll that early in the morning? :-)

According to d96c52fe4907c ("rcu: Add polled expedited grace-period primiti=
ves "),
the start_poll_synchronize_rcu_expedited() can be invoked very early, that =
is to say
can be invoked before rcu_init(),  the following code snippet also shows th=
at the=20
start_poll_synchronize_rcu_expedited()  may be called early.

// Kick-start any polled grace periods that started early.
         if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
                 (void)start_poll_synchronize_rcu_expedited();

But before rcu_init(), the rcu_data structure's->mynode is not initialized,
so at least, we set rnp->exp_seq_poll_rq should be in case the rcu_init_inv=
oked()
returns true in start_poll_synchronize_rcu_expedited() .


>
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c     | 3 ++-
>  kernel/rcu/tree.h     | 1 +
>  kernel/rcu/tree_exp.h | 6 ++++--
>  3 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 63545d79da51..34b13d6bd8c4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -92,6 +92,7 @@ static struct rcu_state rcu_state =3D {
>  	.exp_mutex =3D __MUTEX_INITIALIZER(rcu_state.exp_mutex),
>  	.exp_wake_mutex =3D __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
>  	.ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
> +	.exp_seq_poll_rq =3D RCU_GET_STATE_COMPLETED,
>
>I don't know if we really want to fix this, but assuming we do,
>can we rename it to boot_exp_seq_poll_rq? To avoid later confusion.

Will fix in next version.

Thanks
Zqiang

>
>Thanks.
