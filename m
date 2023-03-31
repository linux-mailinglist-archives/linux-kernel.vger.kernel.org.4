Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD746D1975
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCaIJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCaIJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:09:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07A09023
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680250194; x=1711786194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V0dvb7mQAmTFl8Qv96OUkBTGQFs7/Qt1ana0d9LKim0=;
  b=FAfN9xpl2NRoVfi7uWFsQvAINnJprhJ1Nf9s6B9DUfJZ074+U4Rg535N
   9LkeoefpUD3okm2X9A7M8G6jDA5zw5SwUR5U4QmJzq86Wln1IXgeRKsql
   VLy9jW0K55ZebudeJFFyR4diHOHYDdJh62DkKrQLQLvwFb+0FdGslijIC
   qRIsiY09hMvJyzFS/J7uZQraH7yq/nTAgUvyi64PWnhcNXGZTBNMzlO8P
   L78IB089/WFquxHAIZn4lHRSNexQHpkUWU19x6pLYjED+8y9sezwn8xoN
   CuHUTdOIVDGWiTgIopZGXMbijEL2VBYVtKpY+Cr7RyaUOh/pO1Oz650M1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="321047336"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321047336"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 01:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715374757"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715374757"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2023 01:09:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 01:09:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 01:09:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 01:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU4eOQJqgqWCSXM5EhIFbsBjvwHTdtw/VQw+94Qb5YSfQkI1yqJMzBzybqYYO+5j1of7dkp4h5XUwZvVb/LxjeSE3icYb9qUNkatTJMnWyfVLcTMiNvvadL2UYPqeFfoXWeTXC37Mr8NtC3iU9MCUlQ+dcBYmbivTEEI5TwKNEzeq8OKZLQjARkIxsbiInPdto1pZ/NIHZ+0NHgE7DrsjJtoUcj+j1TFCe4M9lQTvetdxFSIuC2QC3xUuWPMwKvpocYUDpgvk+Qn+eGvZpAjkt6XmZ4u3f17Qm96gzMfW1Ow97S+ta8h9NuDjmrkTwbDu69vujYo7jwFCiYbunco5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0dvb7mQAmTFl8Qv96OUkBTGQFs7/Qt1ana0d9LKim0=;
 b=iVTx0IR7R3o0mNLEuTUPBuDG4ttDq/V9JYpby4KDZ0exgNep5auoMoDuNT0EVwSj2oQfJXYAtr/9miHMm8SPmwN8yWhgODXkojGMEVCySQZ9roYsNNqc3w30MV9tq6yasDrN0nH1kDDYwkjRw0GPjOxXYQqWSCBnNm3NGFIxficQ1vU9ujDdbKuGj/+p8fbYOwpyfID7SbWrlwoWEXk63Ud7FNE7WfGeKxYT8OKcPSXjJqhs3B0GMfUE0L8ifLv2vdnMe4zluHKq4B53rJU2ZBcZFVNbUHKbiZ9O5TdJCPmnErOj4uttIKBBF9do47WEzoOXYPq18RfL/vBmdd0izA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 08:09:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 08:09:51 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Topic: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACAANbagIAAyRsAgAqMnjCABPKxgIAANdgAgAAeawCAAPG3IIAAOI6AgAR7m+CAAGybAIAFfrUggACkCoCABGqbEA==
Date:   Fri, 31 Mar 2023 08:09:51 +0000
Message-ID: <BN9PR11MB5276ACC9D9B0E8158D581D708C8F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com> <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <BN9PR11MB527663094F21D3DCF8A3038C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB23WJu2BEH0yC/y@nvidia.com>
 <BN9PR11MB52760914939B62A61E5309858C889@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZCLc+5/exFTZJMRi@nvidia.com>
In-Reply-To: <ZCLc+5/exFTZJMRi@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6962:EE_
x-ms-office365-filtering-correlation-id: dcc3aec3-e535-446a-b53a-08db31bf4da5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9RURB5R+YeyL6gjTUcwlOp/NbjPAX7UuMtsWkIl2WHWnHEtm0eWllolOdv4WPo7+Xf3SBFEwRG/5IuUpkNgfQTKDwMBkBqJ6UmryLgKWYGxJjycPvVcmKFCT/8XGfFipyX6vyrSSJkXC15C18D4JV8l1NY1b2iQ+waSnmNfeflx7hcvktyZYOr20aca5bFrGJdPi8H5JbcNmlmn3rjHo++CuqimDMluZ0LJ8dnETTR+PL+1V8EGL7L11rzhCzkrUQaRbWmR68gcI83m4ye2B+KUbcPlUW18BW1ksh0bRQN2tmtBfrGIRJ60v5FoydhLnquuj64KkTeubbgTBdgbiv0slNgcZ1YyEXPYJb+kc2mg9C4PqcyKh/6Il2TFas62UGQzzwrdWtxX3jFqOxwqXwo090otLSmgWNCdC7Ax1VFuQk4fQWzxIbyLv1AF18nQ6UzremlT6vNc2CcS9MVhAse2iRERhxVzvXSR67j5T1dzqXbLb/v7Z9cj81E9jboUfVyxxIos0zdLYzBndqdNUWcN4YGvojG9fPd2c30CU9A8Z5WdllTaq1IOKQVTPxhTbeAYMGhK/UiYVp9bmmrr9mDK8O+L1lXNfLk12pd0QGAspDiBjP0A9Q+Rf3QaBhBne
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(55016003)(64756008)(316002)(66476007)(76116006)(66556008)(66946007)(54906003)(8676002)(38100700002)(5660300002)(52536014)(186003)(6916009)(7416002)(41300700001)(8936002)(4326008)(122000001)(82960400001)(66446008)(9686003)(6506007)(83380400001)(478600001)(7696005)(26005)(71200400001)(2906002)(86362001)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D2z0qeveD6r4QzFD8EiGoyly6qml/ul/vng0jzjaFzc5a4ZfFaG7uXOGFo9G?=
 =?us-ascii?Q?s2x/pgt1FB+yNAjjqHYzwjzNFvfC8vb8AE7/hhvz66SJbPDipQa+JDk2I8OV?=
 =?us-ascii?Q?Nn3t2rr0AxVtb5iEZokILTYL6IGF6CNhEfTIWebUVNDsZJq9l/xQq3uwSQQq?=
 =?us-ascii?Q?DtjoVEQr4sPgMOzOEyJDpBcCqBczC2/7Y8NlD20ynePPrVfK2XqnV8EZGGP3?=
 =?us-ascii?Q?B7DvJR83fPDhGQo4ic+ILm0oo2iOs5H3IiHBIakP99NB5e7fNo0WBFwsb1Ak?=
 =?us-ascii?Q?w9JxiGqMeJgAJvSt5f5NgIvNZoC0iPqu/pnJtORYtyp7cxhXdoSb3n+JcEtt?=
 =?us-ascii?Q?BUg9N9/gfB2V9kndsFBAwxKIeTl9tEZrg3A46c+mvsAnYmhOjwzIOf551KYP?=
 =?us-ascii?Q?bEGc1blXBfKRwtw01POBMccU3Q/XROcN2g6nLVfT6y7uf+tjPuYFNeEy7xIw?=
 =?us-ascii?Q?rd+7KBGSYL1LUpKLu5ZMAS3wRTEglf5ty2vfr0AECowSxwG3wWCq3w0vTMCU?=
 =?us-ascii?Q?1JjWtF7T1VuU8XfTAAajsbn8vm6/Jomn+bPYwe5qsgPyyxadK2Z7ys5HuZrb?=
 =?us-ascii?Q?6EXsaXMz/qtzE+sTPK3oH1OUcRoW8OrGrC1rDxxyu7vWyZVw26jNglFCi2SL?=
 =?us-ascii?Q?862Y7oUS5KqGj1D41VvUIRXZ22EWah05pqRpGR5rAZrV5WQLCusj65/DmJzE?=
 =?us-ascii?Q?oPeW9Dra1XsfwMCvhzTBsltUTFR4NbGueLrSKsmIuw5zScCZ4QNSCumvoF2Q?=
 =?us-ascii?Q?3DSeWH/+ktUW0X0XSgf3pv0hyfFVu1nTthOhrSmpH2TfiQiIDwaNLCIQ9pfz?=
 =?us-ascii?Q?n4hkk9/wEyVHVlAqx4oVxxLO797T/NIjg4kUypCWacJkk/pRWP3aP75DFn1f?=
 =?us-ascii?Q?UzxviAjTqVTlE4GUhx/75OeSdieSukMxJ1iVvueum6GA6kMNxJ9IVmX1Egoj?=
 =?us-ascii?Q?6hKKMW/L43+NX1UorFN2VOp5gJtcLhuGyRTKVMsDqhsrJBzp7g0hkHzUu+39?=
 =?us-ascii?Q?hVQ0f16efWIvBj5eNWfUhNt2IM6CyhNNs+ZgdCFDTpkf1mCw3q08sbFERuHh?=
 =?us-ascii?Q?Kp0kiRnUnG+rWK0tfc4Pjg8faIleG4sYaRX5hbtYH0U/RXu/yigQTFLlysPH?=
 =?us-ascii?Q?/QfQcJi03wFOcXV9xvzJnLFrh4rlDN5Whti5NwZsvff/KRtnVLHUeWE8ckVj?=
 =?us-ascii?Q?q5KToyDZwI/GYzlCJNwJDJI39SgKo09NrC2wcokxmW0qxanRAIRHuKPDZvOc?=
 =?us-ascii?Q?wTscr5XyKEjmYlyyidLnASZ/NoadoIY5Oa0mkPK2ygWbBnkD9tTRuoMYQqaz?=
 =?us-ascii?Q?KSJdzX2r6BqG468IneWuNH4WQrIjDhExjOXeYe1YStjKALk0dnzKtwzAFhOJ?=
 =?us-ascii?Q?en1b6Ju0NsJ/GpObyFigGhgybFHETWweZ11Zxd2RJ1SB1nGSEGP6QZUDxiYN?=
 =?us-ascii?Q?HkXHekAgY6kyY3hTSTUe1MZxgxmbActOfYZRnDNYzUxWK/7RScpf1FI0jrK+?=
 =?us-ascii?Q?n0j15g9zEWqHqw2yOJdd06Fv6FTPu270RopMzw5gM8Z/5eCjXK3ezlDoSe0c?=
 =?us-ascii?Q?f5NA/oODxMlQJQswvi6S/u1aqD25DX65sfOvizOf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc3aec3-e535-446a-b53a-08db31bf4da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 08:09:51.4029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +G+3jEzEmGKIkJx3U7cCnaB19X155FOvKJUEt3Pge++hqECK9sCMYlDfd/y4p0kJhZNR4XGIcI5bnZSmmB9g3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 28, 2023 8:27 PM
>=20
> On Tue, Mar 28, 2023 at 02:48:31AM +0000, Tian, Kevin wrote:
>=20
> > But emulated vIOMMUs are typically MMIO-based ring structure
> > which requires 1) kvm provides a synchronous ioeventfd for MMIO
> > based head/tail emulation; 2) userspace vIOMMU shares its virtual
> > register page with the kernel which can then update virtual tail/head
> > registers w/o exiting to the userspace; 3) the kernel thread can
> > selectively exit to userspace for cmds which it cannot directly handle.
>=20
> What is needed is for the kvm side to capture the store execute it to
> some backing memory, and also trigger the eventfd.
>=20
> It shouldn't need to be synchronous.

Correct

>=20
> For SMMU the interface is layed out with unique 4k pages per-CMDQ that
> contains the 3 relevant 8 byte values.

VT-d has only one invalidation queue with relevant registers mixed
with other VT-d registers in 4k page. But this should be fine as long
as the new mechanism allows specifying which offsets in mapped
page fall into the fast path.

>=20
> So we could mmap a page from the kernel that has the 3 values. qemu
> would install the page in the kvm memory map and it would
> arrange things so that stores reach the 8 bytes and trigger an
> eventfd.
>=20
> Kernel simply reads the cons index after the eventfd, looks in the
> IOAS to get the queue memory and does the operation async.
>=20
> It is not especially conceptually difficult..
>=20

Looks so, at least in concept.

btw regarding to the initial nesting support on smmu do you want
to follow this unique 4k layout plus native cmdq format or just
the latter (i.e. cmd format is native but head/tail/start is defined
in a sw customized way)?

If the latter I wonder whether it's necessary to generalize it so
the batching format is vendor-agnostic while the specific cmd/
descriptor format is vendor specific.

Thanks
Kevin

