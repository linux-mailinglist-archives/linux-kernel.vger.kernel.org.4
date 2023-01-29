Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3E67FDD5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjA2JYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2JYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:24:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7AB22022
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674984282; x=1706520282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KE+atWyxUwxQmlMNnpvvxDKsFc+HCpSWO/iuIXn8po0=;
  b=MLs2LPGyxxc57KsOmesFeN64wpCEIsTnIdZ9bfLxNQ0P5Jaxx4dRAhRD
   PZyBm2nbNkQrTrxQXJkBaLEYsNaA9A/sNeIMnLYAinReF5UnDgxOVQOSe
   ahQow06TRKczEuXBaa6LTG9V8zT2Rt4TBNYvHP/Bu6ojrG6Na4u0w9iGZ
   ahD6RhrO8z8lo0qR/uNG79syQQQhyp8JleKS//u+v+3s8ER8knO07y3E0
   WJ5Eq3LUdSK7Q9u9WCjn+gCViurKz1IYhefwsKzP+op3UKGOrOlOZ/7A0
   rWo8gqzj/KNgqshBg2sZJ60S1Au68PWebXbPbANPwSX6j22tjwwQALqJ8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="329506772"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="329506772"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 01:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="992554114"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="992554114"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jan 2023 01:24:41 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 01:24:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 01:24:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 01:24:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbEY7vgrxcTncFxu5+G/PBu81STEEC24fE8HRzGi1EcyNDiDGAuE0QukXi0JrM2yOX2Ujd2Co5KL9UiCxk55WQIOgV/xF/THBsZqBtqLaSBXD3oNZuNoRRlv1ePa+QVofkdruGFu5bovQg4TWXigulaFvsip7EpjbP52BJYOP9wsKD5HXSmJI4IPpj46RJrrA0I3ys+wk4wNSOMwi9VLl4EwGcAjTuWNfkzoXL4q+YJ8DLJhYuIYiGHFJsizxB9QWYlM3dr6WPcLBLEPmiT2+jsMhXibP1eqVXr/Y7Sr0Rr5CA/r+nxQvzxIqE/ia/9OpsylP2N3mgvvnRzrzKJIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE+atWyxUwxQmlMNnpvvxDKsFc+HCpSWO/iuIXn8po0=;
 b=fRLM/80/ardREORDxHGKsEGVMhDqI3DzY8jc3lU1kW4f5BOGJRh1yBCZV2eeWRokECAAUaoTO6b4KPFRSOKoNXMVjbTWz8goJTe0aUXUTtlNeJKt4UTXoS3IIOf3oUxPdXIjgRjkA7bwJUKeYFKuiT6klhkUfex7kyxHpXZqZH73eyOaphHSl3HLkO9kAgvJTBRO32Erzae6t1KFCK0aa9fLA8/y5mRcBteL2k73wDPRDKPKYSIFeXLoJDPjPwnwejU+xY/hkvRJdUwf3jZoTMMT2tsSokH64oyF/1w74rdlgSfWeLyZnHJS45VXPEC2TQcHRlAJMx5KJMuexXufCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6711.namprd11.prod.outlook.com (2603:10b6:806:25b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Sun, 29 Jan
 2023 09:24:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6043.033; Sun, 29 Jan 2023
 09:24:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Topic: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Index: AQHZM14b9FekTdAxzEqHwY769NtyD661H9jg
Date:   Sun, 29 Jan 2023 09:24:38 +0000
Message-ID: <BN9PR11MB52765A5EBB875ADF56ECB51B8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
In-Reply-To: <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6711:EE_
x-ms-office365-filtering-correlation-id: 65e5d374-a881-4b12-8eee-08db01daa535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYDXlgWwiLC6JiP1MTkk0knLx3qQBC3XLUav//d1omLV0OCkLHNZFqBHnzJiHxFabKfJk/a+8uwap02fncJdlHCxbt50i5LATc0UkFPJqr8fKRFPCw2k5Vw49w2tP++t88hTigBTIfU7n08j+TnddPGRXIHdUA9Ws2yOuYKoopIER2cofPNOWNpiGU6H8u53utUDNWkupe9ZsOH03ed6IVnTkr8xYxvV64bcxWNdxCgYgXfP0TXh6+WZw2V4EQ+s0mtVXHJMZO7FZep5DNeEeg2pzEM3zhZ0UYjypgRJcsfdzke6pZj5tH1xgmlLRMjtGCakuIrooEZfIp8nfgkfgvgIMf6OrHofQz5RqGFmdR8/J15j3ajtQdfS5jyhNflX7TKfKDWeIfOElSS0wzlrcobmYvj4Daz7UvY2YkGbsdlEVEVcqQBXuR/1iEGKjJzp5KnUt7EyOTkSF+302nOvTFe09ScjuZ6avS6MlZldh26KOYuIucKDHG93mXn9IN6WtYbbOoRdZxu3Z5NK4tewJPtGtdrQ4ibKoT99hqglQ/3wCEeEv6544jnAXU2Ug/0KLaU3w7fX4nFg6GRHwQ7tn0z96k1vmvfwTwWlsW6v13sg34TYihlhl0PWRlj1OdFYFDrcPoNigufIwHhaR7yT8A0OzCZI+s2Iat7uOARKOF378yrkrGU9IgCG0GdG8nPnnZC7QaA+RkDvjL7dYMUNAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199018)(26005)(4326008)(8676002)(186003)(76116006)(83380400001)(9686003)(38100700002)(6506007)(41300700001)(8936002)(52536014)(33656002)(82960400001)(316002)(122000001)(64756008)(66446008)(66946007)(66556008)(66476007)(86362001)(5660300002)(38070700005)(110136005)(54906003)(2906002)(478600001)(4744005)(71200400001)(55016003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BLALHLVtgSIWW1FJAA5CDc5XMP9eNtFht+/dZFfijamX5nNeT608XpNFbUEf?=
 =?us-ascii?Q?BxjNLpFPfwZymqcdrYjNqjhFTtCFvi220iAvEuBAFP/l6MNhSwOlu6DOjHeU?=
 =?us-ascii?Q?NSCyroAD0VGAQYw5sTZy3dTFdmC4lcC1rtG17aSclWSxWnlGsMmYMOP86qIp?=
 =?us-ascii?Q?mO5VSFZ8CEiYHQLotJ7PMMH2+he+nVTTsaSuEo1Uqe85H4nr1SPKwUhZdzvY?=
 =?us-ascii?Q?JdqJlEmB9+zWahqzseeMGSEwsrxLBptc17MpGoRfxZ0zI7GyYBvVAbSdaoEC?=
 =?us-ascii?Q?wZ5sUQ+9x2i2XW1BTWk6iPGa1LBbaHSjCgkZLNP1OTwYDPBnJzoWwHJqRqrN?=
 =?us-ascii?Q?7Eje4gvuava/o27D4G9Rc1drTWtR8JVSiskg/aD+Kv8gNH2Waw89JFWWCAGB?=
 =?us-ascii?Q?4pDXqGoJEAlTR2CC8Lr7yguXuC5ih6v3MzkzvYBDfwiCbUT9TYYp/ZczN00i?=
 =?us-ascii?Q?naF1Tmakk4VRagDfGF/bCLj9UbO6aX8+NzrnDFEaBG3HLyMjqRDn5nC1O7Oo?=
 =?us-ascii?Q?QYjDHD5FruMlAHkCgjpIGrepQrdt1+1jRe+s1QXqqeeSPdFXZ7YFWn9KQkbM?=
 =?us-ascii?Q?a4t1hzx1BWgFbZbaZrocI/wVrDObYDETWcPpTz0oqDosZDR3HFwCs9ss5QTR?=
 =?us-ascii?Q?YuIKw9mK47PEC6d2AgTp95z9qjK72GU/wXfCJka8gW7cP8QWoOj6WtFawMu2?=
 =?us-ascii?Q?lMuI5GuO6ZPH1IJfIXZ0rlT2weo0wLDZN1+niBHyeN6qr+bYFHYUsvhj81+w?=
 =?us-ascii?Q?A3bZjc8BfcROEby546P1EP4kIoRz6PDrvMzyHH5WrpQvUijZ/ZcekASEqWek?=
 =?us-ascii?Q?n235yBYaNNUGs9privUeCbVb1VLLytoVJ5FtDUdZOEbkh8Ep1M2tL9ZQA6GR?=
 =?us-ascii?Q?M14knFXjTHuRhVuneMx6Xo5924hxGHPvCXPw4QjA+L64XnxkoYKWOffMdxle?=
 =?us-ascii?Q?glF2Owa4+aI/wFWeT9th4l1MT6g38JyF3uHMav6WeWy4dXDOBHZOn7T2lXPm?=
 =?us-ascii?Q?6SxvXf94WNGSUkzLgglwX9VEQVbwCTEz3Zk0NC7DdnfNVRaPaaLx+2c9y2JT?=
 =?us-ascii?Q?OxjpDtSTQHrg54LcERhqPuE08PXXAU2h/zsEaXeY+LvCFhe02efGyAHKtCKU?=
 =?us-ascii?Q?PJo7J0iTOnVtRnG7Z0rg4b/uXuTyzdMV0Qu3NL1MO+bgC89Cfi/Q6jHCVkP8?=
 =?us-ascii?Q?KaQ/f2FDQqjm+5CCHYLtfHcWSrpbMFlteWRXKcuPJVhmR+6gwMS2/ywO45J5?=
 =?us-ascii?Q?Je1bXSEFFPnZIBH/q3oLefKj96QqKv49lMSLnTHlHg8QBv+gcfGlg2pZ3HCg?=
 =?us-ascii?Q?u8UFtmVKT+dOuhsFe1Kpdf1VqktvyKYDR5+Dbv7TP3TCEvf727vSv7DbArvo?=
 =?us-ascii?Q?u+x8YCNEphcLgTLGODlI93lvwttcFrVnZUAugOjzonpuq+bBhSTlpuqLoBOp?=
 =?us-ascii?Q?xZL7eAVpZC0epbSnK3/Jv08KI4W+UhrjnqOZmzPmerXp4xS23oaVKCpPn60c?=
 =?us-ascii?Q?/kl3el2xwm5MPpXUq/VCP7iMQga/H2TPXdR905o17bppHgMAeWjqyrIagEVK?=
 =?us-ascii?Q?s12FrJ+LrHyTqVttHslCL7XqO5kikFC1fDBhqovO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e5d374-a881-4b12-8eee-08db01daa535
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 09:24:38.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIHBPve6Mld3QWggtagS1CuGeYVmFiyoR9E8ZOxLsNFwCP4W2b6f1nwUWXFSnxxgmHiR+HIsZR9MlmrcIufeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, January 29, 2023 5:18 AM
>=20
> Since the list_del() of hwpt_item is done in iommufd_device_detach(), mov=
e
> its list_add_tail() to a similar place in iommufd_device_do_attach().

It's clearer to say that because list_del() is together with
iopt_table_remove_domain() then it makes sense to have list_add_tail()
together with iopt_table_add_domain().

>=20
> Also move and place the mutex outside the
> iommufd_device_auto_get_domain()
> and iommufd_device_do_attach() calls, to serialize attach/detach routines=
.
> This adds an additional locking protection so that the following patch ca=
n
> safely remove devices_lock.
>=20
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
