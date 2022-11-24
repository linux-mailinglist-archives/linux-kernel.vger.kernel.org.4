Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29E5636FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKXBnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKXBnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:43:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A76CA00;
        Wed, 23 Nov 2022 17:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669254226; x=1700790226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kVTFf4K32bZkZ98R78S8jOmMuQwJGN9p89bCpIDBiuA=;
  b=LGeD1tGDb8ox5aiIEX3hN8zegqYGl2gu9JTfWVlBapz0LwrWOg6EELk2
   uSFaYxRXBg91knky1jveP9G4LgH05IZWAaH5eoU93xz9+H95tilSqD+jx
   NAX/h99obuzRu0TK4a4JU4ZsAfLommoQfahRJggzlzindK8lQxaDJ2MCo
   KnNn6kq2gqPhqk0lFWysmnpkPDm1rRmem9eQomEW/Wbwj7TPuHYsuGY8w
   SKa3VhWnIoIxrMCILrDpxoFNQoWv+1iTK4Aq0QxdReOMJ/axge+t0+/W7
   Gs/DIO8Rc/jwOR4iHJ40g1kAzGv2oosPRBCRUfkjT3y3jZE+XfqA3abT7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="301756037"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="301756037"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 17:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="784449107"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="784449107"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 17:43:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:43:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 17:43:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 17:43:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaXOVk003RjcbOayaBgNXxQ/9nUVwah+GO3SCJGAW/8VaBBtGAe3BEqxCaCCVQhuRX+KGaC4mgogUca08PeJaj6HxaRZwPu0+AHli9naAG5wHwId4RRNZwfK5gMhqB5nUGqxWiPyAtkXFSbS5VZC9hWi6+FC/HLEgbRp3qLehEJcYgvdMhGAzsJIA+A8tSEAwt97TAYmW6k+IxPpnZuudi5r8DPQvQmwjX1JpVE+pLKIPENCD8ZqtyNhCrb3mQ9eIQmksh3iP8ld4C9ubQCTJN8A3BGkK3nrIa23spcJ7CPP9KIbNYpiTmkRszt691MYchJ+1/iKGQvdwXqIMFafXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrDbMIUDzixH0MdBsiJfosCZYLYMOh2LMjmknrTIIfA=;
 b=AvXxbm31TjIyN+9q/X49eIUy/poYMI5vqbYVgVtZTyBIwewwijhASOYppsmDmuZMrMKIwcRsiA8wwOHuEf2+DwJIcrRg1/TlBf7ZTMpBoZ7fuI382/SfJ/UeG7Z0lSqhVonHrTCcoQBJg/8Sh1SMiu2A5Z5+I0kDW0SQtAxOqR9Ia/qrNQzsEZ9eF3Ezol3ZZB6M4UH9q9BrdAPjjvlOi4K7HMeDeKOo2QzhNjCEZDvTBCLor9JZ8uIpUGr84Ajb0LDlBSmPbJbnVu/ql+VQNc4+xj8P35W996diAOpTuz9P1u5GlCcBaa21dT4Zt/ozd612Misgb9zYV+Yzew7Zxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Thu, 24 Nov
 2022 01:43:42 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%6]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 01:43:42 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Topic: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Index: AQHY+nXe3fxP1SzD7UGw8RnvZujcXK5DKoyAgADb12CAB8DjcIABIMEAgABp9yA=
Date:   Thu, 24 Nov 2022 01:43:42 +0000
Message-ID: <PH0PR11MB58809D9378BF040EB2AA2DE6DA0F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221117112050.3942407-1-qiang1.zhang@intel.com>
 <20221117142025.GE839309@lothringen>
 <PH0PR11MB58807CB6626A08CADD822409DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880F073FEFFDD11B1AA0642DA0C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221123190456.GE4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221123190456.GE4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7417:EE_
x-ms-office365-filtering-correlation-id: 47271975-3aa4-4804-7cd7-08dacdbd519b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdttBss3dxR+w/xUkugWfYYwopt6EKe1bhjndvQuHgRccNn91TD7KfM/aK3V1lTr3gY3NdqH4M33NKFepDOit6n6LKQOZofT43Jhf/8G4KxYC4TjTZ1R8xFJscMY6KcH3xKq4CB7rkFJe+1YXwUm2uz7u6Z7DAS4z7tTj5fPVaofblATopE9bPjrGrEpSV/HT1BPPvL7hRmbdQC9Ez9xQQXHUZFiOXespQnnxcogXNVoP2xI2E6Exgo8tXcuSa9FvG62yKNpkPPJITAaAV1gy795g9W7QxGtEyEzyYmQjRZouHqSZYV1MQnGASO64ftRzgiA5XgLHSaEWaYvj3XnusZkOLGKjeMIUK7tbdl84tKJmkl9FBqqxRcWcQSzaWwpU3OQsEwbVBKSIVbGXbuuUry9iT64DjQwpcH2sifHtElYVG/h0lspBR1sFTvFQ/udejRogoIWPs8eemvmxkLo32RrG1WxDkMvhjJRjhE5TKukcdrTsoO8VmOGjRdNeX3cQLK5N+YvCyDM5VtuWodvAqZ44/SkH9qzHa/YV/FEwlKiYBiYqv4SoCi0DQdz3iz3giMiU91lSaOxwdg6vmbNEoLv4F/y0mtLX27p69eg1sSd7V7D8nq9gPebndjgHRxCYVfoulQvjQZukDwVwJPRBTWWfMvkIXpdI3YA1gPDkNBzXW9xIDBA0HLgvtxju55OHXwp/l3vLom9//ZtKduiVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(33656002)(86362001)(5660300002)(76116006)(186003)(2906002)(26005)(82960400001)(83380400001)(9686003)(122000001)(38100700002)(55016003)(38070700005)(66476007)(71200400001)(7696005)(66946007)(66556008)(6916009)(52536014)(8936002)(8676002)(316002)(41300700001)(4326008)(64756008)(478600001)(54906003)(6506007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tR8cWPx7nxpnRoLZnzF/hxzLW5fGt2Z/ztsUcnnrR2bqNeIT2yjQutgn9FUe?=
 =?us-ascii?Q?OtlEraVaNWt3ar8IpyfTSfh8lxIwKj0zlLRjeyoz4eoUi3Gx4teLNDsEKsbc?=
 =?us-ascii?Q?YDuHSTyZUECPiujL4jWsZCPP6PuoU0iOHQ0mef6LREeFLsjv5iq+6nE1A09W?=
 =?us-ascii?Q?hF3zE2Z3Ruv2Y1LRtPLIW+5kyL/JlQR6U0/aQigtvp2tkgMDb55m/Xtzr3AM?=
 =?us-ascii?Q?Bbyt1V0NrGepgxcQ2OfeZtoB8i88SUrHgdKNr8HERlzb455DZEx9kCiJi05k?=
 =?us-ascii?Q?f4nmPWTKDjOrDZy081GjMN7zBTH8IGrjNJegZJpYDxv8Sgx2SEkULeK0A+N8?=
 =?us-ascii?Q?9+KZGrnVkino8dovnHcYgWOQp1ONvWR9aGKSFqlWD+tsxmoXJDfvQHojbHif?=
 =?us-ascii?Q?/cv0v21p61Vez5k10TJQ4hR69FX9kkRggU/YNRvbDKzTlmAm52hDLKAmOhBd?=
 =?us-ascii?Q?WToKLsSQffmm3kwaD8Zyyh2Q/0mTDs2AMgcIm6iHbiP2kdpRqJ+8kdfmnmew?=
 =?us-ascii?Q?21XwHVxXdVWJ2qDdpOD0yhBancTH1sj3v0XSce0XRw9oNGad7Db5QVWqXq/6?=
 =?us-ascii?Q?MrlzrRv4iIP8Np5czG2e77mcQ97cBbvHn2QcEWNT/xZEHYNf8u3+J3rRQXgr?=
 =?us-ascii?Q?R3+yfzWHqJTCiaa5EVU7ZeHDGSbXBGjSyqMfcXxYql1zNUERziW2rAaARADZ?=
 =?us-ascii?Q?2v0wGcVS4q9p8qYHq1TMlnoWOn2fI7M16S9Jis/TSVJcPOizjC2CWr9npVA5?=
 =?us-ascii?Q?uK7A/fh7NuVvrwPSN9Rjdeb+JjWN+IAc4K5JJzngO8D6x4UhjV+7Ni1dJ+Nv?=
 =?us-ascii?Q?CBrfmYHNM5yK9Iyxf8B8ellNuZ5eBXngMomX/KXsahtcZNDE62NzJ7qGaClK?=
 =?us-ascii?Q?H6saXm8Q480IUMQKZMS1SK330q/eMrk24MfuW5RRU3C4JoMNj6JNaf7ULBQ7?=
 =?us-ascii?Q?/DJcU4+kaSILLy/jMYoHRDCaQTv8tm3LY4+ulbGXhzZ/XG340SCY2EN8zpmX?=
 =?us-ascii?Q?UNZcBrWmlMnzBN5Vo7BRPi1M+HsrRpXkTGcZv2Vo4EL/qtfP8rF03saXiOY8?=
 =?us-ascii?Q?2Vyn2y8SdNCpGxeW3mnpeRCpxYuw4V6TGKt/W4xnu4HJ2b2rchXat5vraHdP?=
 =?us-ascii?Q?+gnd949qUX81hbpkyHeR8Stv7H8261i5lBEZwPJQtBzDRoiKBqg0XtBk7Big?=
 =?us-ascii?Q?zOEs7txIq41+umDvfv1UQnOSIUhyIzrXE64iDEiIfO+yuUFk6lAbmAIv/0CI?=
 =?us-ascii?Q?bf3ujNUVrG5+CeifttUtOkhhoNQ/7qqjq5hFZ7PFSpDFxvB1lPpqr7BUNB7v?=
 =?us-ascii?Q?dWInU/lQsG6Vto64x/2s3bFBikE42Cgt2AkrBFp9i8eY7jN4fJGtYvJXggXn?=
 =?us-ascii?Q?3OX20l/ZTfPTi4xD0MfKrp50O4WzILFIOY4xr2B7wJC2XBBefH70aChV5wPD?=
 =?us-ascii?Q?yLOasrecfrge28kMdKTmQrpckp7u7XDG89PrY6a28fcpIkp9fK2DumLnW7s0?=
 =?us-ascii?Q?ZVXYdUJ97eckf6qgADU4/PIWql+QSqpATaWRPTh143VqhP0F5Dau403BBf7J?=
 =?us-ascii?Q?9vJLZkMQf1s9xZ5dIzrMDtURoD87xnn9AsL3P75x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47271975-3aa4-4804-7cd7-08dacdbd519b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 01:43:42.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YjJMchhghvRCySqZt5gzu87DC0AdTBMQfkQLGTX00ZmfBczyh1cD1hvDFfaXxAScmQRfTwjLDAHXzrdFfg43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
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

On Wed, Nov 23, 2022 at 02:01:50AM +0000, Zhang, Qiang1 wrote:
>=20
> >On Thu, Nov 17, 2022 at 07:20:50PM +0800, Zqiang wrote:
> > Before SRCU_SIZE_WAIT_CALL srcu_size_state is reached, the srcu
> > callback only insert to boot-CPU srcu_data structure's->srcu_cblist
> > and other CPU srcu_data structure's->srcu_cblist is always empty. so
> > before SRCU_SIZE_WAIT_CALL is reached, need to correctly check boot-CPU
> > pend cbs in srcu_might_be_idle().
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/srcutree.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 6af031200580..6d9af9901765 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1098,8 +1098,11 @@ static bool srcu_might_be_idle(struct srcu_struc=
t *ssp)
> >  	unsigned long tlast;
> > =20
> >  	check_init_srcu_struct(ssp);
> > -	/* If the local srcu_data structure has callbacks, not idle.  */
> > -	sdp =3D raw_cpu_ptr(ssp->sda);
> > +	/* If the boot CPU or local srcu_data structure has callbacks, not id=
le.  */
> > +	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
> > +		sdp =3D per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> > +	else
> > +		sdp =3D raw_cpu_ptr(ssp->sda);
> >
>=20
> Hi Paul, =20
>=20
> For the convert_to_big  default configuration(SRCU_SIZING_AUTO), I found =
that the srcu is in
> SRCU_SIZE_SMALL state most of the time in the system, I think this change=
 is meaningful.
>=20
> Thoughts ?

>You are right that this change might make srcu_might_be_idle() return a
>more accurate value in the common case.  As things are now, some other
>CPU might just now have added a callback, but might not yet have started
>that new grace period.  In that case, we might expedite an SRCU grace
>period when we would not have otherwise done so.  However, this change
>would also increase contention on the get_boot_cpu_id() CPU's srcu_data
>structure's ->lock.
>
>So the result of that inaccurate return value is that the first two SRCU
>grace periods in a burst might be expedited instead of only the first one,
>and even then only if we hit a very narrow race window.
>
>Besides, this same thing can happen if two CPUs do synchronize_srcu()
>at the same time after a long-enough pause between grace periods.
>Both see no callbacks, so both ask for an expedited grace period.
>So again, the first two grace periods are expedited.
>
>As a result, I am having a very hard time justifying the increased
>lock contention.

Thanks reply,  I have another question, Is this srcu_data structure's->lock=
 necessary?
the rcu_segcblist_pend_cbs() only check *tails[RCU_DONE_TAIL] is empty.
or can use rcu_segcblist_get_seglen(RCU_WAIT_TAIL + RCU_NEXT_READY_TAIL + R=
CU_NEXT_TAIL)=20
instead of  rcu_segcblist_pend_cbs() to avoid locking? (although this is al=
so inaccurate)

Thanks
Zqiang

>
>Am I missing something here?
>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
>=20
> >While at it if someone is interested in documenting/commenting on the me=
aning of
> >all these SRCU_SIZE_* things, it would be much appreciated!
> >
> >In the initial stage(SRCU_SIZE_SMALL), there is no srcu_node structures,=
 only initialized
> >per-CPU srcu_data structures, at this time, we only use boot-cpu srcu_da=
ta structures's ->srcu_cblist
> >to store srcu callbacks. =20
> >if the contention of srcu_struct and srcu_data structure's->lock become =
busy,
> >transition to SRCU_SIZE_ALLOC.  allocated memory for srcu_node structure=
 at end of the SRCU
> >grace period.  =20
> >if allocated success,  transition to SRCU_SIZE_WAIT_BARRIER,  in this st=
ate, invoke
> >srcu_barrier() will iterate over all possible CPUs, but we still only us=
e boot-CPU srcu_cblist to store callbacks.
> >the task calling call_srcu() may have access to a new srcu_node structur=
e or may not,=20
> >because call_srcu() is protected by SRCU, we may not transition to SRCU_=
SIZE_WAIT_CALL quickly,
> >need to wait in this state for a SRCU grace period to end.
> >After transition to SRCU_SIZE_WAIT_CALL, we enqueue srcu callbacks to ow=
n srcu_data structures's ->srcu_cblist.
> >
> >Does my description make my commit more detailed?
> >
> >Thanks
> >Zqiang
> >
> >
>=20
>=20
> >
> >Thanks.
> >
> >  	spin_lock_irqsave_rcu_node(sdp, flags);
> >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> >  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> > --=20
> > 2.25.1
> >=20
