Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0752670FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjARBYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjARBYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:24:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE8546B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674005049; x=1705541049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yEcyq5uGr2AmsFnZSr98ZrF7BAQV2O7pqqT1PqZUKio=;
  b=YhX0bNAwoPJIZ3+jvxyXZCaiBY6y7T+I61dTA31NYs0P25Jdw9MnYI4T
   skKMpf0MTQ17NDpwlJx1/9B9AcWpFL/vz8zcqSpO0qvxeG7ZMDUbxyC33
   M09W3cnJng57soPNyKZjxmgXo81hkjcBjIS0LNQzBuAs1Enp3wTBkEql2
   vnzNHHcaB89TSP/+/+u0zxbFvaSv6Ch+g2A47IZMrOU6ZmpCw2cU/NWFV
   l5QngR6Jxe4QzaV8x2pES/6krC8HJcZurRGl4x2xZFihuF3+QVDVkmVg2
   QVaSTI1ZvTbCFTVdTjDJMYJ9nnVpkuovjozACwHCsZp8O5oiAk/OoaBvK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="308436154"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308436154"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 17:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="637067337"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="637067337"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2023 17:24:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 17:24:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 17:24:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 17:24:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpF3HsQrnyU1citdvtd/7iFgf+tprfqQ2jYLY6RyDOUi3tBRa3HvUvn5swTO4BZ4CcAEd+8az2sQeov/mmVZ6x7/uWxGC887rIxpX2zj1k/ClGdxky4PN+x/1vzAIi5IccWl0f62Z99lcDrp01J2FEEEKXDoRVjqZnjCupuCnyijN7LxM8QMyzU3hyPq65N4c9pavXOZpa3hOpU9pKfjCO5tndhzE/NBQ1X5CEXtSR5fjzJoMoxIFN7cJxvZnMz+Jkm27GaUp8wpptGobsTYG/vF6IwXbR+gy22xJbPmcLtjXnHAipb5CHXN5QRrqSzzI49YA0wBb5FuhcokWo2sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHAvWNNsQYBT6I0AHeveOQAaLH6uhzCqKQ1SKFtyAug=;
 b=QG4QTHPpZkXDPq8y+nqEcCR4McjPKr8HJm4ykCz1hIRYImnHs0yF0hR7YqQ8KCVC0HBoW7dck9+CRa1izJcQf+Fuim2hh7USXgpZBHOeHXG63gAbpPiIi0+CXU5ctbf5Pyr7mGwPx0tRbBWjZ7ej8NkJ+/7iZG5EMrBjlZRwPdc0RNKiQLMY6G4mSGDsA7TivMaF3DSANrDVLCLCCxNEjKZJucW6ln1A43UicLEhS8rs8bZ/mTpVb9w1HY0oboLHUlGrnwhKY86xWw82jycDA8a/o+5F1GwWUm6PGTm76vS72cfMEyR2cu4p2NXwHPOZdGxFF6DCrcZm1G3u3Uu+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 01:24:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 01:24:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Kalle Valo <kvalo@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        "Marc Zyngier" <maz@kernel.org>, Omri Barazi <obarazi@nvidia.com>
Subject: RE: [PATCH rc v2] genirq/msi: Free the fwnode created by
 msi_create_device_irq_domain()
Thread-Topic: [PATCH rc v2] genirq/msi: Free the fwnode created by
 msi_create_device_irq_domain()
Thread-Index: AQHZKqg2sgLjLoNnj0W+ZNaDXErwGq6jYa+w
Date:   Wed, 18 Jan 2023 01:24:06 +0000
Message-ID: <BN9PR11MB527661A8F2B8CF80F03CD13C8CC79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-24af6665e2da+c9-msi_leak_jgg@nvidia.com>
In-Reply-To: <0-v2-24af6665e2da+c9-msi_leak_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7334:EE_
x-ms-office365-filtering-correlation-id: 028c99fc-33d4-418e-9d1a-08daf8f2b0ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtaxHYDgsUNKrUbHaH51ycAhoMHav5K764N1cMoWx0NwOTiyM5GbEz62hiF0gnXQ123wmgvryzKpFftje/4HFajYs+16Geu0ppBh7zWwgDERA/vngAkX+F/moBz5hJWh8zJcQwJDtD8ZM8zeLb1RpM3szj8z2V9+olLpBItbBuLxz7J2PDq/GOo7ZpOrPx/iwkZjNFtkazTS6xkvyrx0rtjWGmbsxfl1+WTZVAOOcb9D31101Z6OjXNMck6qwXRYfEk6DYTY5qL+VPX7nBP4LFtbB22jon4bpJXy055ZiRDKiv1spFL/7DM0y5KuF+e9HZlWJiHnfOcoczzsdjCf4UNw9Unzizdmjyj1htPcSWR+twqX/sE7HK8KZKD126WLYaLgT540TwA9ygK4Jpb9EHaleHzdZYwWqVsr+ayl9FsLv8b3gJX7oceqIDK6hIUUdeYKkGy80xjAcbD6JCE3/kEXeEARzUJQoW8lEI0BhzTU3/H/yVxpOw+aUUeHCPMiDki9mMzLai/pIKgRJoO+gCXZ9WcCBR3UkUjlPw9WXVvAZahoaFVSqXpyOMCAD/4688oRNqWoKZVSkhg+Dd/IIXxOeifH9gCFNqe5kQaxEVsI6asGnl0vQdl/fumsgPkZANS0QTpRhUE/EgV3wV0+AAFe2IrU2DeuqOCq3WpPaKkjz7mmm/muaFpmMa5XpEMEuUGE6ATXfvynnaD2KMw3mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(82960400001)(2906002)(38100700002)(122000001)(86362001)(33656002)(55016003)(66556008)(7696005)(316002)(54906003)(110136005)(38070700005)(71200400001)(76116006)(41300700001)(66946007)(66476007)(6506007)(64756008)(4326008)(66446008)(5660300002)(8676002)(8936002)(26005)(478600001)(52536014)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L08rbqiOLRTWlqGV5a6VLMhqnEtac0QkddGQY1UPTz7Qidio+42yo1cstFVb?=
 =?us-ascii?Q?SgixA+3WuuICjeZQTI3+63ZXURZjgTwarVlUgXhqhyc6Brs4IGZi9El3tA2x?=
 =?us-ascii?Q?yDpBsgSXep68tCr6F0Nj7q0pptmhfVfhlQA2j1DOsBkUiPwizAraVcr5oL9s?=
 =?us-ascii?Q?swcDtoqEICsPD9dX3hl77TyRBBlvx0lvmsEwYOjZe7M8+ZlkXG6F8kDif/oP?=
 =?us-ascii?Q?VIBLH+nhInPlFSzv1YBjvDGelnXZ3NR2KmeO4b1Ek86UsN/Niou5S2tSmUO8?=
 =?us-ascii?Q?rNfcwNZHyQ1Abs2xS8jH0xf7/091otyVTqJX5PJqL+9OLbbuLiaSTUUtw+Lv?=
 =?us-ascii?Q?PaGbo6QPHN8OLmRXDyO2JlTVyA9mDf+zM49TEeSeIR0vX1GMb9gJ2IW5pRV1?=
 =?us-ascii?Q?luA+u/hX9Fx3K/pVvQnb/7+ogpk5tA7HLXNnES0eBZg26LFqgw9Rz53AzyJt?=
 =?us-ascii?Q?7z0nFEat0ny94yqrmtkEZgPcN9IR+eHeZWplIjDedqt4XkONNECC7erE3MVI?=
 =?us-ascii?Q?GznSyQK9ic6Q5Qsfkd3htZBy3+JXq0Kv/0FYWOno7lFPFnvuvFFWp+fE12ly?=
 =?us-ascii?Q?IC5ezwciSGUlzQbOM2hqUTeXBZaN0KLnViTa2pTNLB4ivT9H4kgAelVLtOTN?=
 =?us-ascii?Q?k/eP+UXSlAQn6raqlPZ0sQS7wMeEXFVM/jzJwITYElcGmAmQaRGHsvtOgGks?=
 =?us-ascii?Q?tjwxZb+gWJdizSwNACoou6qOK+ZUpy9KCPVb8NS/buhnOYTpJsFmJd6/m3JV?=
 =?us-ascii?Q?j1lG0lawTJr5nbxZpVTB7ndw9LJ3xXiNLvMQcIsEptJtllsRMdoX1JNFYcgr?=
 =?us-ascii?Q?h1RYwsDTZyuP95Wm4lae6vO57wT2/3q7pftvcMk0Yp5OCixwCn9gHGsDYIxH?=
 =?us-ascii?Q?DN1FRXRkW34Swa3/IW1VTqXJrUX9SS9MLUNiF80JUgTPlNbcRQ6cPtVAr5Fe?=
 =?us-ascii?Q?sJsgI9p8jtgj1ZzdiK3OxmwHX2GbR1S76V6potr3QRVA3yVfq7Y4pbpZTag3?=
 =?us-ascii?Q?QqBr3aaJMoYaRYJAYHxToAw4iOyJcadmxKdKw34BNF8SropU7f4tFuwLYcSB?=
 =?us-ascii?Q?qRlwtQwITiWaomhqBi9yG74aKpsPvLXxRHaNPgeS461Yg6YAXOj/ynbqdPLu?=
 =?us-ascii?Q?EVgfa7wnbiAIuJFDiGh1kPSBuowqFgdvARBv72cEgPuyXdmy0WZZ4/ck0FmX?=
 =?us-ascii?Q?UNwHFgIV8E/wOvs3RliLDYzPhcOjv4GMoYyF3y9ZU5G9nMZIjlF8P9k4dLhs?=
 =?us-ascii?Q?bKUXqKvW9SNtJExikpUT0TJtN56Lm0azvxV9UKnMrOlPl7y6nkAQl9QQB38c?=
 =?us-ascii?Q?zQ45LBBA2dGeDJ6r0puMjlXlEjKvrRVbGc9j/XRtsd3zA8j0EMTX3xNB0+sg?=
 =?us-ascii?Q?KGRxpMxczjPzl+/W5vkG2qBMImg4CakXYbVKfdpN6i8iSJopTSobUpi/kpx4?=
 =?us-ascii?Q?NfPXXqLGcI8WjJQaIi31/FEi34JBfPFh0RmPL3AZL+qv8JWjnaWj5gRDZnZF?=
 =?us-ascii?Q?/DncJeeuPBpVNngdYTKPa2bi8tulfQ0iGRpMHRj/IbpA7GmZVMxcz0U8q/Xq?=
 =?us-ascii?Q?mFBr+BTt/2nQ54S8tAd/Vb3apEDAiR5rSeETTNpw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028c99fc-33d4-418e-9d1a-08daf8f2b0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 01:24:06.0326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PjwictO9oPlmtSqZLzKT8x3egy9IbgGJGGbzUpOd6VfXwaHRTWoV8agQy9inIrg08qNnbcFuQyY0NbbKnnlTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, January 18, 2023 3:16 AM
>=20
> msi_create_device_irq_domain creates a fwnode for the new domain, but it
> is never freed. kmemleak reports:
>=20
> unreferenced object 0xffff888120ba9a00 (size 96):
>   comm "systemd-modules", pid 221, jiffies 4294893411 (age 635.732s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
>     00 00 00 00 00 00 00 00 18 9a ba 20 81 88 ff ff  ........... ....
>   backtrace:
>     [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
>     [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
>     [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
>     [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
>     [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
>     [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
>     [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
>     [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
>     [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
>     [<00000000df8efb43>] local_pci_probe+0xd6/0x170
>     [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
>     [<000000002671d86e>] really_probe+0x1cf/0xaa0
>     [<000000002aeba218>] __driver_probe_device+0x18f/0x470
>     [<000000002aec9527>] driver_probe_device+0x49/0x120
>     [<000000005f45a989>] __driver_attach+0x1ff/0x4a0
>     [<0000000000dcaab2>] bus_for_each_dev+0x11e/0x1a0
>=20
> Use the proper free operation for the fwnode so the name is freed during
> error unwind of msi_create_device_irq_domain() and free the fwnode in
> msi_remove_device_irq_domain() if it was automatically allocated.
>=20
> Make irq_domain_free_fwnode() tolerant of NULL.
>=20
> Fixes: 27a6dea3ebaa ("genirq/msi: Provide
> msi_create/free_device_irq_domain()")
> Reported-by: Omri Barazi <obarazi@nvidia.com>
> Tested-by: Kalle Valo <kvalo@kernel.org>
> Tested-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
