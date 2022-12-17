Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AC64F727
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLQCpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiLQCow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:44:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24467020E;
        Fri, 16 Dec 2022 18:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671245091; x=1702781091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pn9KRdM41gHq5Yx1tyI8RAyUBn2yaSilzmFv6TXzjWc=;
  b=DhqQMYMm7Ny315PDD+oCxykHvd6Vsi/WRmtHg7che6436JLO0hCgNedj
   TEQ3bdRv2UjudOohoq6rmv+EN4DKTR+jQpOHLtvWq6U2EmQgrlh95MdJe
   vHLxir00T998SIVKAeVriYjfu7t8x4c6SFoF1HhCa3Z66di8lCV/R6/WD
   BHO5NIiaYHGleH0OVdJeyW0181X1N/C0TBOy9GsMH90/cZc0ITwTBEpV9
   mE13kQJxAs9CeIDS2/eWnpPEoTsggQKHFDiSupkXGBgu28gCVQD5iRB0R
   EQ03PzcCuy8f1BfYncLdeLzSe0unk8I0yfCTK3M2cU+Kp8A+TgriOoGPF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320272646"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="320272646"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 18:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="652133956"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="652133956"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2022 18:44:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 18:44:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 18:44:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 18:44:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzwkW33pleE3AS7HxGeru0rP49uHt/BrKhRSDV5WztKknXFwSVPb3pt8WbEFaZ6Nf5ZET4m2b46Mu+06S+9L/jgANCfCs2x/tYcfH/B2R6dOY6650iXFP6vR2Z9cvtY697Vqlp1AKAW6+lr9nrW0wavo4jlGfLLoNz5a/tKszq6zc9zrvOyCe2B5sVWFZJE42+0tLDBqAMTF7YA9ZnGog6s5rdZDz+kgznXfp/ajeG8fA2X+wvwF0ggCChVvQFdILCavLhir6kqx0E4xla0afo7TyoGvh8vU8Jj2zcoUW4afnizem+ovqr+LVvU/gGvawYNYwxKLaqerZ2uY3lrUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGntxEzIvt1n5W0MStyri4Iv+z7H3+GTfQhbCEnIG8o=;
 b=TpetGV1MroBOSYnifThZwlxGx2nSb2mP50yhAcP9MNDJ8e7ysN8nTmGlCKCItoyOmay4d9H2AlF7c3AIaoHiOScP1xgpinsIdOqwi/pLUYWa9wbiY0oJ5vX8WDnFyR8SqJRRMM9rTPR16hvvMqwfAcfSSeXbarFon8vKyylCVYj+DlWF5C9yLinLiw0mWQ+/rRkobw32OHgd6+ETbwXDrpIru2VcCQ5hyj7/gmDfYpAf4CQZ/jmKKi307wnpiYWkoMKYoXrajFG6ZIFgdE9K3x5CQBhjaebeG4p2vys6m2o1tBh5U2nPizov+Z4oueUi3PbanBuGYCEsoQRX+kBxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA1PR11MB6712.namprd11.prod.outlook.com (2603:10b6:806:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 17 Dec
 2022 02:44:47 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 02:44:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Thread-Topic: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Thread-Index: AQHZEDjb4JuHblX+NUKrHh1V8qzf2q5xRmGAgAAGjvCAABO7YA==
Date:   Sat, 17 Dec 2022 02:44:47 +0000
Message-ID: <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA1PR11MB6712:EE_
x-ms-office365-filtering-correlation-id: 29d752ab-142f-4832-c0a3-08dadfd8a965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yBfZ+h5oYo8O6/QoI1nvvg5FNBbHc4Kl35F+Bwp3PqilSLmdBwVj6jb3qCH2NsWyAiUEFC5lJDMP/KZhGvda8jljpkJvb6gWjHAqbssbmQ7jX2dhf+9Lg2elic8i9NjsZHD92+Md0Y8m6kdzCm7o3SaA+0BnbuS2aPdk3gb0U0O5Bko9r2/ZhnToZRV9PhSiTlHnV/NWQjVR67xR01AroxgrJmmNSvx2DNOT+hLUDmyJsgNLWpUtweDBZLMdE4Hj4jrWqGA9++fn9i79aSjhjzqktbQwnxBGdjTpyZuuQK5AuJEGjgatkPlgoQAvSgVYj7dCFllraOSbXWs5PN0VKUG43sVK4DvVB/kTuhz4Yl/1Rn3S1rXNz/TP+qUguVHJYTb3WnGkDMZ4mOwGWJTA8KKhLJeqtP9IAG6A9nvY19s+/xXH67efKVGPv7tWsahw3cJhE6DA/I0jo0UOifFYjPYgFZkYy79/YtMiFdQa5DNnFR4AMwM19BKgulAszmEofoEZ/L+mveaUzohSovRCxHxuYyNqOC7CQabxNEKOG0W9v8QAfthmaoJ+kENPSEKd6PIXLDY5LCPByrpn2jhxzMfKoM9OOz2SmbcPxJZU9O8OcVHsJy5rOk5B4ocuhum04rOJtUMEP2qsvaRCgktD82d6a1G/pHB6nSwcj2Ki4TyaKnL+vsOc9KQdiMdYn7auEVSa9aYVKax5Ld3SRUcPvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(8936002)(54906003)(316002)(38100700002)(71200400001)(33656002)(122000001)(478600001)(82960400001)(38070700005)(110136005)(186003)(9686003)(2940100002)(26005)(7696005)(66476007)(55016003)(6506007)(66946007)(86362001)(66446008)(64756008)(5660300002)(76116006)(52536014)(2906002)(83380400001)(4326008)(8676002)(66556008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NU7GLO6/vV17CXey5EulFDfJi3bOGR3avmtUMbp+hbp5UzSrY249A92CgIr/?=
 =?us-ascii?Q?8HJbz2Wn+dhnP5zanwO1+C/IOP/G5HlK6vzFWRZZ0qiY8rqxNlXHMJmOVA48?=
 =?us-ascii?Q?DahbQrt2QkyVOlrC/rfVhn1LFPmAyULzwF0BNA0g+dn6i/alEbec8Y6W1/lW?=
 =?us-ascii?Q?c4gCjkcLJYzhaPFHtXFiqen4l/KOinHrNIBjJwDyn8vWjDtkHDm4Qdbnb6Un?=
 =?us-ascii?Q?TaDleNd8nUqjerFnXB8swTKqpswLjWd69SUck/XZ78H/jwqqTOupuCXUodQD?=
 =?us-ascii?Q?ZoCVnMQ/gOHn9Ht2CLcVwx7F22sRJL72VRIY4Fs4BvHYlomrnnbmpdAEePzL?=
 =?us-ascii?Q?+hqaQCGn3a0hAdLypzRI39rOmJ0P6YC8Eadn7dR7zbN28wcvenNzyX6XITLI?=
 =?us-ascii?Q?nV6ZmdvnyZ/t13ALxdvRWrRlO5Qcswv9twa5MAMEY6AFa4ySY1fuCGmf9CAR?=
 =?us-ascii?Q?C78AFuvLs/TvDJsQpis9ki2NPSKSsD9GQkGsGJCEvjn4qKqAhKwOcXapfFjK?=
 =?us-ascii?Q?WltVHBiU+IxrUZJbgBPGpOtSN98xLZ5Oeqv5kcDmxZ33rKj+c8zqmYCtxA2G?=
 =?us-ascii?Q?SUlg27q6p5V9fG0I9S2WXUIG2rL5kodnBdx/3xi6HWNfLa42poAe4Rsi0yAk?=
 =?us-ascii?Q?92ovylYdyBZP3wWtH+weEBUoEzlLurAd34XuAeRMdJ5Jras6c3G9ewlvuMuX?=
 =?us-ascii?Q?GMWd3mkSoRtCiqZktUHjamLAg3q05kPOtobvUi0Mhv9UtDuqok1PDb6xY6ad?=
 =?us-ascii?Q?iegq7zP5yvBj3IJMDCUHaEqnB3tXt9722+qojuTuVME+ELBiQigWuzfPjxrH?=
 =?us-ascii?Q?1yW8KI4XHNvfshFG9c9Vegc5BpPsizS57xtF67miNC941MYakJifK7l4gaKS?=
 =?us-ascii?Q?IJijYMPO1fes2ugbEc4vORElGH0AaUcVi6i8c0DcuIimF4pf/kxG9MOo6g5U?=
 =?us-ascii?Q?xNac/opxohc3Frqp4tdS7S/xYYnvVLf6Xy5bXDF7+6VRY4rrxPL/IuT6aw0V?=
 =?us-ascii?Q?NKtVCJ1rglGD8PpAjQFVJnIXmjL3noUufh3bwA0orbPQaYAkYvuvAazik3PG?=
 =?us-ascii?Q?vXG0eOpCBLWCoqH0gDdamvnvcjyF0lb2HiGNCl9fImMmG9NsT6dBBXUu/4oE?=
 =?us-ascii?Q?URY5XZaxOjpKyfhVAvLaRR5QKWphVEewAEw+WdK8B4kBNRTme+p+gIO5bmCN?=
 =?us-ascii?Q?U2txg2ImqrLkA3bzO0KmQNbz4N4CJKJED3rO+iERTxPJmOOYcpEOXKxSIIqW?=
 =?us-ascii?Q?E3tiWTti49PWtc2p1+tezdB3ZkjYgJrpShZeCde9WfKKF5IZndoAZxx4aRRF?=
 =?us-ascii?Q?dm2qe2U2g3RoZskVIFdpAP9NwC2tNQNGRpyqLlhq/S+0Kh4fDU/5D3IUIfX1?=
 =?us-ascii?Q?DCW3RPS6QsuDYCLkVOw74LpQkNgGo/JVfZURTO7fxNFsistEfEW0hySVwb9T?=
 =?us-ascii?Q?bhmcV6D+eaqLJ1dYvqVqi4gDjwZW8bSIMnDX7hlIPkeDMlsABzrrw9mKIlfI?=
 =?us-ascii?Q?LfzaJeyoSy6o1Qp+/3uQpwE4Gx5wS5wz/RuKNXckcEjqL37Pq8SekxLshQHY?=
 =?us-ascii?Q?9phwfw4KUwrL8Tq8i8muKZnfj78vyJm3Se8WA5H8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d752ab-142f-4832-c0a3-08dadfd8a965
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 02:44:47.3981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCU2h44+KZsDD/+Isu/maDcfQLebL7mqVi8VGSXpDhBTL7Pm/BcATWVxRkvZgQLvguGP1DjxCiIDK6V9Irmutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
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


On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> synchronize_rcu_*() will implies a grace period and return directly,
> so there is no sleep action due to waiting for a grace period to end,
> but this might_sleep() check is the opposite. therefore, this commit
> puts might_sleep() check in the correct palce.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Queued for testing and review, thank you!
>
>I was under the impression that might_sleep() did some lockdep-based
>checking, but I am unable to find it.  If there really is such checking,
>that would be a potential argument for leaving this code as it is.
>
>
>__might_sleep
>   __might_resched(file, line, 0)
>      rcu_sleep_check()
>
>Does it refer to this rcu_sleep_check() ?
>
>If so, when in the RCU_SCHEDULER_INACTIVE state,  the debug_lockdep_rcu_en=
abled() is always
>return false, so the RCU_LOCKDEP_WARN() also does not produce an actual wa=
rning.
>

and when the system_state =3D=3D SYSTEM_BOOTING, we just did  rcu_sleep_che=
ck()  and then  return.

Thanks
Zqiang

>Thanks
>Zqiang
>

>But in the meantime, full speed ahead!  ;-)
>
>						Thanx, Paul
>
> ---
>  kernel/rcu/tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ee8a6a711719..65f3dd2fd3ae 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3379,9 +3379,10 @@ void __init kfree_rcu_scheduler_running(void)
>   */
>  static int rcu_blocking_is_gp(void)
>  {
> -	if (rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE)
> +	if (rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE) {
> +		might_sleep();
>  		return false;
> -	might_sleep();  /* Check for RCU read-side critical section. */
> +	}
>  	return true;
>  }
> =20
> --=20
> 2.25.1
>=20
