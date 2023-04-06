Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB16DA617
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbjDFXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDFXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:11:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE375277;
        Thu,  6 Apr 2023 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680822700; x=1712358700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8z/gIIt6HSCmGI3VtcO435J2YZp+6+Ul1CuGKsMKOYg=;
  b=MZHbG6NYVOezDoSCmxHs3LTtDNIUhXq+bigyY3bd+ZgXTscPmkw/z7CJ
   ECC8QB2eE7M2sAs/CK1N904yPp2eI1tznukpZIPQVcmPsxVWa5BhkewDQ
   ncFzO/LdVMMuTrbKB+36l4cHvePrrJclacd8juh0sH3wYkvW7kmQx5Jrx
   gLR2cMJw9Wz4QBaJ9yNH9h/aPkERkNl1qy9BeoodHs//EbwwF1hK8Xp7r
   vl9h5FfewYYpL4usI2riJz2AWQEnNN5/yZTHucAwdPVxS4WgQwPPZFfWC
   5H4FRWN0AWjg69euG9J+laIAVxGScYZmLJ/n/Q9nIe89ceaLK3ttIEANu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="429154177"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="429154177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 16:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="830957485"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="830957485"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2023 16:11:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 16:11:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 16:11:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 16:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOsaivEsTUrBTa8DMRPckA+NwE1V8WEGwIQnsIyjqTxSsFpH8H966tHpvsSZbgj2sSaB1D32u7kDYNsB/7OdOKadjB+imiuFwvZmplRTpAYif5qCcHzVdRiRMpaIYafJKHoLiS/xUsc+LbtOUoh+A0LPsRu3ZPK3RRHIwUBKVs3m/Rdgq4spig1l6Xcmaf3DjWpB2zowG5tY0dBHfCTp8qZ7tTqyT2nl8NvEKvVIqPhT6soMGBod9NAokbj3RhzX+pHl8eIE+jqfvFMbhZ2JowMX+YfNjnJrYywFB8Ku7tvwKyveTc/WdzuF3/ap05cB+2T8FJCfEEPDAuzst6iSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRJ1anfBQloL+kAP8zO+JMITuKif096iMvVUcmhsGl0=;
 b=nlFRuD4bRNqBeAQM4U+paAoCVlaj9n8Hk+e4QVMj7OdJ1Jo5HhCzxwVzwn7C2BxIHce+rq0B7AA50wlQhrUvchzyFVCbbYTSf3JRP3cgDofTKOEEo3jKAoW05IUx39exbweVzMdnZyYl2yMvl0KvyBzHabpdo4KIwXNcuT7yL5hoeEXWQxOHDotZW7wKi8d3YED7yuj1U2qHyq/mXoyAQKnbVtts8OGJ3D8KZq/BdUaxiq4blXpc7zXAMqKmyUfIprCRx32aNSZHE0MXPcFoOB7A7opOXmif2HP2hYUhRwVSoL+5vkuA8mJsczf0Ysj4h+ULlCF4Sls4z53KsWaSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 23:11:37 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%5]) with mapi id 15.20.6254.029; Thu, 6 Apr 2023
 23:11:37 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaBxqLyldFWH+MUeQ1f1h2hb9AK8dsuCAgADdb4CAAFfuMA==
Date:   Thu, 6 Apr 2023 23:11:37 +0000
Message-ID: <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
In-Reply-To: <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB7757:EE_
x-ms-office365-filtering-correlation-id: 5803783b-6c1c-4f79-393c-08db36f445da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WinPavW6rZt6a0ib3jN59z93ot4TvXZLB8XBJtbc4FtATWR8xSZVcw1jYTE/zyu9eASehN5JyGY3bEW8BgoryZ636bL7+n7Mv/DxFNztW+Y4l5WV3NxPb4ji850HB8TrHTnP+VmY0eUjQH7EsSMLWZpoc9WG/owVvx4KKboMkOhhA934ahUxTpzvg10H35xWK/jXFKniEgfKoQobyVuf0qwQcYKBKRvk3OKaMlOzKzt8Lqe57NJmPLacQGNU5DpmSA+ZJ6exWIkU8/Br6Nlaszf+6yDR1tyAtZSLpggvU9O4/RKmp8pup4ySVUV7pxEddDOAM600CGOeBHiT3WvZUyR5/EnQO2ecGiPtLwiWP/Spfn5TGi/zWvrBFILnDsH1o1qap9vsdU5eaFibLlF5tlJ8xPIVrxEkuyYhi/GvSWjSURLSHvGvvKF+NsK3HRZzFxBCaAZ4cEritITdJLkstLkoFm6YS/MzCEQnKSO4m1F083tFOmrQzEP8Di+++ozCr6qiZGFOu25fuUnitsA22/WrvvjVy07sFdo1GmXfaU0oSwYau86nAoui/2wtXTRuI/k8FQMK41AJJwDjwWRAg+5Itu9TPSVgyAIxJSV+S9MI2/wDsQLvt1WUY3LAIFdL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(7696005)(478600001)(71200400001)(86362001)(33656002)(55016003)(83380400001)(122000001)(82960400001)(38100700002)(2906002)(54906003)(9686003)(316002)(110136005)(41300700001)(6506007)(186003)(52536014)(26005)(4326008)(5660300002)(8676002)(38070700005)(8936002)(66946007)(76116006)(66556008)(64756008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8GNqW6lTCu2U9oOybpv2AiG3sYUP0MKYXZY+3tZOOc//ei/Jgy2nFIpgBH4C?=
 =?us-ascii?Q?Z0InlW0ijPb7j1kqEU5Va1WY32a3nvIqXPrYfE0raxZ8p3UF7aVUglA/2w+8?=
 =?us-ascii?Q?Znj0DKwsiC7vSJCVkQ5mtXSirFT2vOmr//KeyO2w507FgNt8Tf+jZPNtiQc7?=
 =?us-ascii?Q?Jk30n4Z6YpTMy39dCiF4myKLHafyhMCfZ1yoMqipBWrUmjpymS6mW4Smli+j?=
 =?us-ascii?Q?KZM30tGaslEngYreLAnwAEFA2L0OkBLMWQCaDnG3HxGDc22u7GbyL1pWg0CU?=
 =?us-ascii?Q?s3qEKnWZwl1bbjD+bM40FW8XBxerxka+enxa87wIdrS4girJyRa9kwLWJHZo?=
 =?us-ascii?Q?G15nV/U3pqZpPFDVmblktFtsBIrU2O2Q/mzbS3NYHEd0S2GI6x7kKQVwB6iX?=
 =?us-ascii?Q?PHTjn9XOKX6pNTuBbLQXLbuQxHuKfHplGJk0XpqNqM9TfUzO7nCCm6WvvZ6q?=
 =?us-ascii?Q?AnRqn/MMb6uRQdPBHJwzQxiGWVkGNRH8jvFZg+XDkE9i8kn8akr3TMre9kx6?=
 =?us-ascii?Q?Em0CBsphO73LyE2RuGG3NPFHwx8kc1yLr1xp+AE/YwhierTjOpr72gPPTvk+?=
 =?us-ascii?Q?OwdbulZi/WQgdV//CtVAmo3ybKCifOdZC4YqHZhlmcCV7nUmY66ZQp6ufGka?=
 =?us-ascii?Q?a/PsQAFal9a6efUYEyadsLLCzfJSpmpHE3e/kZfxEW7dIzbjqdvsrsai0/pk?=
 =?us-ascii?Q?EFiRTCf6AiCCkphJMu6wB6ack9Elt11VhVqcnAUIDhD/KV2hG29XVJw/rTrZ?=
 =?us-ascii?Q?P4cguL2cw5w522sh6/Sb3PVyQzhpdI15YtzJ6WzAFGm0BGfOZB1/GLUvmogc?=
 =?us-ascii?Q?34YqrH8rhmJdoNjt1Iuda/PRq/g3pVRCQledDPpIxnAHskt+zD3onulw/fh+?=
 =?us-ascii?Q?0zLoMtiMEM6mAMHm4UYQ76fvNgHHmcpD+TOIzIpDqArTahU2kx14Ir0pUeZ5?=
 =?us-ascii?Q?5KlVNZr595XAhTz7yk8MrdiImFFoYmQ6Mo6Ss4GOFUNPHdARsuNQdXRHCkr2?=
 =?us-ascii?Q?t8bxw3SdSh40QpqS7Jde0o8tLPYSI1eo/FLbaSwgP4WWhq1lmc7KErAqoTcX?=
 =?us-ascii?Q?YNEBbbrY60NUqp30qwrmkOqEpEM2vlGIkp4siIwG2O5qW5vX7Zad6IWN4I7W?=
 =?us-ascii?Q?f4dP93TNyA2NOn9NmaRA/ascxKJ7u/+dYKBIx2hoZZewPpMTCFFsvuJ73/jx?=
 =?us-ascii?Q?lhbVQzj6UBQKg88kl+wwpYeabZOuHzNIXe5QDQAVu7iujFoxy2HDvFfeHJkG?=
 =?us-ascii?Q?YpqY9DqRfTnOUEX+0GyfTjj4IrUx7XVM5AtdfKZuLeYAyAlX3qONexZgCnSq?=
 =?us-ascii?Q?w3cGlRQPgfFqkqASRTGwfGznIRIRUDv7SMc+lFywLfq365G0iXddxaoG/LAA?=
 =?us-ascii?Q?c34utIkwMcjhXZXy4EZiwWyYgqCH/DOon4RPXklFmNAauxeJnwNTg2GLd/6F?=
 =?us-ascii?Q?67vdZrifsVjD22a5IaIkDegNU8qJuPkv70jZTb+Yss0NroRwoQaEcxktQlm3?=
 =?us-ascii?Q?K5DEAhTtgvn4GKnGgw86s16FTUHtWOCOVFXCbL34zFaQSNatqRNxYuGn8ZfI?=
 =?us-ascii?Q?6OTboOfvz2DUNkGUBcjHbd03RGraFe4yDK5Ru2X2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5803783b-6c1c-4f79-393c-08db36f445da
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 23:11:37.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3V/vv/VYsjjdwIiwDEDSfUXjfCyzRguMMmxn+sXiZihjtSVvmcmITDgk/DKK62xDH6C61QlSUPDDl8YW0ZRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > page cache again in kfree_rcu_monitor(), this commit add a check
> > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > cache growing.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9cc0a7766fd2..f25430ae1936 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2907,6 +2907,8 @@ static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >  	struct kvfree_rcu_bulk_data *bnode)
> >  {
> > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > +		return false;
> >  	// Check the limit.
> >  	if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
> >  		return false;
> > --=20
> > 2.32.0
> >
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>
>Thank you both!
>
>One question, though.  Might it be better to instead modify the "for"
>loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
>of starting at zero?  That way, we still provide a single page under
>low-memory conditions, but provide rcu_min_cached_objs of them if memory
>is plentiful.
>
>Alternatively, if we really don't want to allow any pages at all under
>low-memory conditions, shouldn't the fill_page_cache_func() set nr_pages
>to zero (instead of the current 1) when the krcp->backoff_page_cache_fill
>flag is set? =20

Hi, Paul

If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () retur=
n false,
the allocated single page will also be freed in fill_page_cache_func().

or it would be better not to allocate under memory pressure.

How about like this?

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9cc0a7766fd2..94aedbc3da36 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2907,6 +2907,8 @@ static inline bool
 put_cached_bnode(struct kfree_rcu_cpu *krcp,
        struct kvfree_rcu_bulk_data *bnode)
 {
+       if (atomic_read(&krcp->backoff_page_cache_fill))
+               return false;
        // Check the limit.
        if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
                return false;
@@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_struct *=
work)
        int i;

        nr_pages =3D atomic_read(&krcp->backoff_page_cache_fill) ?
-               1 : rcu_min_cached_objs;
+               0 : rcu_min_cached_objs;

        for (i =3D 0; i < nr_pages; i++) {
                bnode =3D (struct kvfree_rcu_bulk_data *)

Thanks
Zqiang

>This would likely mean also breaking out of that loop if
>krcp->backoff_page_cache_fill was set in the meantime (which happens
>implicitly with Zqiang's patch).
>
>Or am I missing something subtle here?
>
>							Thanx, Paul
