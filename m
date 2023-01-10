Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5E663779
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAJCqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAJCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:46:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679412BD0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 18:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673318770; x=1704854770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eCx5nZSGT/MzUH4UQ/JcZqvWNbf1Xl44+i02hLqtqKU=;
  b=YZWfKYTP2t8yP6xall49OM80u66Ja12YVM2QKA8w2AzXnO3dm6WMX1f4
   GrIcvCj51uYnWZC9wK8A2BvCQut1EM3eU61wp/2QYPdqiFYrdUi1N7mbc
   03nmCcgjDxiLKms4UUnCyT1eVrGKuXftillgRgiSmqaEMUr9Uci30yQmi
   AQ5Lzc+25FE+R4ei1jx2uNiYH7NfCZFYJWgza+M0hhX5ewIAf9A4nxQQE
   qMsWid43rjD8wkYxx5HHyVrf12MdVwS89prwESJem4Pk2JqeVDGS1wTz5
   DGLjMdr2FXO6Hitb2Hdx1KaIU23sNiHzHm+wpViCkqR+VkqaLivDZGX5b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="387495811"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="387495811"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 18:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745607686"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="745607686"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2023 18:46:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 18:46:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 18:46:08 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 18:46:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD/v05fnKUfEq7bWWH5YpBv51BDTyhyQbBa1AxXDG79GT4XdM5knOQ9RpsRX7yjLfgTvJRMKKOoREWg9/CFwpmtLMrfBq9QJbdoA1xAtQLKNo6fTRmht5tLMLbnWi91QTM/ENcmJpLzZxWK709XToiAP2OgosKTReGccpssEZvMfodmPvihgXy6lBf7jWXv5VImsQDSwjzi02u5QZ1hrob/xOPo0SMAc7FxXq0BR8xhKt2UH6b4JqNYUf9N+BA4gmp45Up9FBA5cgznF0XhCkw2Ps4mXqP2xV+X7+WqoigYYf+vECWVX0AHuZDlGnMDaGOiKB5a2O306XhQ6URiv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzsjHKk37tIfLK2+/vate7jLyiMr6FOb/m6V+wAuZVY=;
 b=HLnI+DWUB/PtuoFQd5owNDZFnl8kLb+i0JFFrW+jLhJIN8fQP7GWVsPPJ3s4pIYwhup9TOBIxQ6848zTLG4zLG5/sCm51DTitgvo0YkX90LoPJK4z6i7cE6K/NMIvurBV5zh7um5Gggrbp2mke+dL3ZKd0z8uDxNt0YHuhOauiZHPBD0rDnbO/iRqeVbfAcEqeL+cg7TC6BMfiQRk1USymQpU1BXME66Bfu7mc+RhdeHPqWRVrvMayTkVNdsV5eqOIvzPA22bjOuX48GRYJaGrYRBZq4i66BEAJFnPxIvTl1W0pNadeSm5hUO8oc6OVm6FfVmsyHlYkZt6OBNs/Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 02:46:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 02:46:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] iommu/vt-d: SVM implementation cleanup
Thread-Topic: [PATCH 0/4] iommu/vt-d: SVM implementation cleanup
Thread-Index: AQHZI83IzQnuOZ+2+EKpKdSeMVYw2q6W82UQ
Date:   Tue, 10 Jan 2023 02:46:06 +0000
Message-ID: <BN9PR11MB527629B7A7CEB2DC8AF1BB3E8CFF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230109014955.147068-1-baolu.lu@linux.intel.com>
In-Reply-To: <20230109014955.147068-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB8016:EE_
x-ms-office365-filtering-correlation-id: e28d8345-ce04-444c-12b4-08daf2b4d257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qAgI73mkNyRziMuyO15BQDj/FMpAd97H19XTnj6beo2JdCUu0dfLtqSPMWTsFO7MEYut2Rq42yvSAUrRu/uMHmuCAZg0j6TO6hCPG3meE1tX9bwD2aCpX2+rcHCMHA4csXiiDy6pMf44orVESEjye1PB+cVsMcjT5e7HYGxnyllJufbc5eNn7KHouyh9XeF5C0RLDacoA+tlXHRmQ1yB+gybJeyL+IwlJsUI11gd8FSpL3jgA0bpUFBatOP04NrWeeQ06Dke241370qOKxeq3JtjT+L9fR+abNppqG4VSDpnCk3mq3evPr1QCFMNXbj1cGeFKXssDgBE8HUty4fkWxuhezRPh3hxjEnLhyDR9yJBAFYZIzk9CZ8iLl+Bq/SeAR9nWnprkrfsL5wcbN94d8UpHNCJLGXXQtpP0W2/4sD1cKbrDnGCumKKUWuGHccvVeqpWq1WtY2K7CWtRLY4W9dpVMBa4HNGOJAJRG5YcgnB9gh9t+RpkivBMTqaSijGueFKM/G11wyJR3ISPsPox9YWOfyHIxAlQk2CP4U+Ntwau6SF1CygzhQ3we282qnnyVaJbDCWXWUI9YsJY6ydBrkSCyyf1RkkVHfCcXiYShjs8SSINaIJHGMyDlFeMPOvV06L4zW1LjrnEsVjAb4lgI0CGFBNE/k41egfvrSpnEnHBciNriT91lhjL1qK1G4/qAFQi6MyLpQOSPjl95okw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(33656002)(4744005)(5660300002)(71200400001)(316002)(26005)(9686003)(7696005)(186003)(478600001)(41300700001)(110136005)(54906003)(76116006)(64756008)(66946007)(66476007)(4326008)(66446008)(66556008)(8676002)(52536014)(8936002)(38070700005)(86362001)(55016003)(6506007)(122000001)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nlvKXfoeW9uR5sShzC2bmzozXLnLP4FkkLc/MB6F9h6pjJiPHpqA3+8PKZb1?=
 =?us-ascii?Q?hI/OAEfRfGk82Z8Pqtzc/7EEgrVZWBQOlyJ/nKyo4wdFORrUNQSgNC+q5uIm?=
 =?us-ascii?Q?u23tXxqvGGwGFAN81DloTsPy0KBGEkmwsvzGyc6vBpFrn8MUyl28rLQ0HfrJ?=
 =?us-ascii?Q?RHz/0uqbE+fMWdlXkEHx9Dt/i30W/Dpwuj/4Z3Eo3kRsa+7ZCaUA2VDTuSfX?=
 =?us-ascii?Q?XW4a2pRh/32Cud4oI+CW0ec7qAyR2VdnpMwJ/jHSI+Bcdpq73yMhc1VgqzCc?=
 =?us-ascii?Q?8UK0v1nivkfk7ZrD5xyy5vCKJeIbx41n/UIptNr3orxnyZV5kbxKZeWPaPk+?=
 =?us-ascii?Q?lQTBpxZgd5qIW9Fwf0U1uyV+FnWmrYA/3nv+H2Jo8i4WMhN0+FecWsWI9p/X?=
 =?us-ascii?Q?zaCcClTP1BAOe9gAtIaYVvV7gTbahWu3A550uYl2mpFNDqYH177pO/j9+n7P?=
 =?us-ascii?Q?93FcBTdXXvZ0VBZbQC0NPCxgZQy7+AkwjK/NiAly0lwEfOSzFFsv7BE35ffp?=
 =?us-ascii?Q?Box+/Fcj9NIE+Dy1OLuiDj7JaozY3iQc0Jv/E2xF4Y4xKx1myh4nSU+UX37H?=
 =?us-ascii?Q?gWjheEkdWbTpe6mFVIlmPRuLa4dOoiWJV294JN6GCo+mjfefnHmXCgglndP7?=
 =?us-ascii?Q?67bSccNyalyMs68KNO7IaG5X2y6jfhpcWAESEUJL0nV21DmU/U6uQqMy58Sx?=
 =?us-ascii?Q?OTSVdpg21bt4m8ccfWIkSy1pGqcYuQHpRLSa7doR5oFdGvFUBqX1B32aRgjn?=
 =?us-ascii?Q?Jy1AgEz/6+EJzjHMtbRTAYGJmeXTUdbGfE8BD9sdYgT4V42TynAu2at5cQL/?=
 =?us-ascii?Q?lfhnK0lGLuh5KrmiPFJplF13jbJdMTCc/NBMPtzEymjWOwC0CHq9OwBPfIRd?=
 =?us-ascii?Q?xm3Td9BML727NPj2cPNVcOcOBuQCQMrjwwmid1sj6tOkmREoDvmQmczdaLzy?=
 =?us-ascii?Q?uegcp2v++C76SgnApSPaI1m4S1YB2YFA/xARcR0kEwThU6wvpQh9l9RMShwi?=
 =?us-ascii?Q?4f7d1znN206FeUycv7fZtdj48M057nwSyg/DdoK57FdE2rOt0KetPsrS5Bj1?=
 =?us-ascii?Q?Tnzbg3H5w1ueFqYKzKKLsOxTReiYe/gt+X/mEkmCr8oJYUupB1kR/lRCSlNw?=
 =?us-ascii?Q?XZKluq/w0Co0AfrwHMn1vhqOzm9g2KD85EMvx1PpeWhVIisHxBPDftcHevdx?=
 =?us-ascii?Q?A7I5cq7gpiWZNsIET97GOUpXf0e0WeEbJGDxY6o2wZi0vh1d2vu/mIwRjx3O?=
 =?us-ascii?Q?Dirh8bbN++lDONpDNPER4snE/DibyglJ5dXkBJkQG5+eF3BAXqpOeeXGfNjy?=
 =?us-ascii?Q?vi3io8Gzifigea6g4moOjLOhQns+gDnsT5Bq85KUpleLo1NPIpKYAGWJzt+M?=
 =?us-ascii?Q?OvYf9SC8mnhyCOyxH0yRNbxyzJrqu8Ld3cWp8mpKPUW85Gpkd7PjmvI501/6?=
 =?us-ascii?Q?Ar8ICJ4AFKMZbEFJv1IG2KrYealAGVurN1pcu/xDV+QNgrZaiPuTcCLxqxzi?=
 =?us-ascii?Q?RAJzDQ594eIHJV8Gct9YjhSNMNgKEhaQYtjOXCd8U8ZYesb1D6V0nD64nPp5?=
 =?us-ascii?Q?lr2Ii3fkfawIsH9RQsssrht0oyNykl6Ekp6KiJRD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28d8345-ce04-444c-12b4-08daf2b4d257
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 02:46:06.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFKJ+UrOCGtJyTtzSc4u3D93xfc2kS5e4gxFIXwAD9ta8p8kFtll+P8EHIbIHPYk4AJzQQwQhvEAYdPP76otSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, January 9, 2023 9:50 AM
>=20
> This is a cleanup series after the merge of commit be51b1d6bbff
> ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()"). It removes
> the unused/duplicate data and code.
>=20
> Lu Baolu (4):
>   iommu/vt-d: Remove include/linux/intel-svm.h
>   iommu/vt-d: Remove unused fields in svm structures
>   iommu/vt-d: Remove users from intel_svm_dev
>   iommu/vt-d: Remove sva from intel_svm_dev
>=20

For the series:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
