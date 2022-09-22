Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD7C5E5D49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIVISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiIVIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:18:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742FCF48B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663834703; x=1695370703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U+J+m9cFliJhGOGQY2rUbsNroTHlJHRggE+8Xq8k+Ds=;
  b=GvMfkU53FdgzhYfwHGFQbCP7EKhmeWXvKP42IfaDcXXU2LST17U3mQxd
   9lROiWfAM8Rt8O6fPMwC1Udo2iVWB1zttg9ZaDJ0o2hBqvBsyyFJ4CEux
   AH6msw7UUZZzK8PI9Iw4M1++QMKRmaoev7Bt4jR8WHFWHOROe9c+G0Id8
   b5FFOq4Kmq8ZXAz5Y9qjUnVF83+rBpYIeMSzZtB3gxQyH6PaV38+PrRtQ
   hd9KOSjtgOAydNedDYQSZMNLazoIaSGXnbq0943lbhVvhqmR9+zcw2V2a
   jVHR+oCYJ6Oy/rLjeYi3/iWPExOZ8BlXfNyx5hI64+Kp+ef9neS2bdyM7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279956673"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="279956673"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="682120847"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2022 01:18:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 01:18:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 01:18:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 01:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXqcV7aku/wqH3mUppgJt0Jyl2al0qx/y64IMVmbvY90/biyCm3gTqFeb3AgMn+KWbhpltyd15Q4tqSQTnN0fy9qHaM0x/QrIDl/aK0NeVF6m8c9+xMmkxwL04mfJ0lcJQKjD1YQZqvAiQQ/MQQR1TafGl418r1c12l4O8kv1/8DQRBF7FzdoHytsOM9X4pNKd6r67FjMzLiBEbncaKOGCdwTGwH3ZfiF6hJEykewHuQqkEWDI6KierSRG875Jpc9J8A4b95BZ38oKUjWrMrGt/U72m5PD1noR7UDFXHktrU83+lOZKssYhIkipaYRYGPCP6YWQAQ3ZDyEgCyb+wPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+J+m9cFliJhGOGQY2rUbsNroTHlJHRggE+8Xq8k+Ds=;
 b=d6OWnisuUVB7KWHOdSvN1KIkO81ZUq59bcgcqlS/rea60hBFzoE6FdpQ4+DTyBzUHgI7PnvBrXLmHJPKRcT57CSk5maapuxUpnNGdBipNaIaomsrJIySncJoyj230qByo7sNH/pVh7bfhFcAoDYuIjmsN5iLUAqXJnZPcDgpTKozkJclTaHV13HEgFNTcaFLlhOiJP3uUFMzUVNM2i7g0Puvu86FI85G+A4cFqjJ2DVCkFLEDgxwnTA/YFYQf06TvsDz07vo5Tc1/Lg8iag3TJ/V2i6+gp5r4Z+lnmso1gEIoVhcOb4LOwjui9ycQFY7ZCRDMgZ8E2KMYasR2zHE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 08:18:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 08:18:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 4/6] iommu: Regulate EINVAL in ->attach_dev callback
 functions
Thread-Topic: [PATCH v4 4/6] iommu: Regulate EINVAL in ->attach_dev callback
 functions
Thread-Index: AQHYzZOBMQXadsI3gkKD/+6LpGlvvK3rHIBg
Date:   Thu, 22 Sep 2022 08:18:21 +0000
Message-ID: <BN9PR11MB52765D684499094F823445DA8C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <6c48822600154314778157ab7f72a7b55f5e2c65.1663744983.git.nicolinc@nvidia.com>
In-Reply-To: <6c48822600154314778157ab7f72a7b55f5e2c65.1663744983.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5989:EE_
x-ms-office365-filtering-correlation-id: aa16b551-7f80-4bf1-b7f0-08da9c730324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKZxEnw1TkkWTiX7VDZVnzpcoZq99fRfKlJwD/Nt+5ecJw9WL4qCZwGRqVJULobBKTMMatjuPTyHknLw1QYULcxMpaEQxeIABktorcepP0srONxIHz/u7aIFpwDnNLFEg90Jdu24tJ84wlWX/4YQtpW8/LaiFcylvFPnSrVFt8sCHKcxlxkC0gDEjeanknC5pb1GLJ6F9OqTwPrkc9f14Er03z8sT9Xyky9L2pLrGi3a2gD/KsOIYL9rvdy/oKCxOOpOwQJrflsjfpThcusg6vC+wKtewwCl+FDdVA48ardSUse0zNoPQ4qlkvTlmmYPEHk8sUU5bNwdzU+jzxDgCQIplo6AmLRoimE2QD9m/dwVfArPSecsh5oOUGsU0Rsxk+BAxI34SlrzuzHUWITLtZ6Z1tDumKrsQlNV55wsQ8j/TxB84XkcCzuvvL27qN77Ms18hbFSjFP5wHm/pXa6nAigW+TFlagbLWS7OIiTgtJpPZalKCAJ3+Qav73us65hPP6o9iHeGn/XX4aY7maSd372FiREs7gr+7Jzaoo3hA4QsscxDsYIBIctTvC9jW6Rt2NXqyGv/Snqa5i2Pes+hcxsZH3yuFU99jZr5BmgixMfI9/iDfommJfkkAYvSd6EfhQTPR5riQVlZLIeDlJLPNwZ6e5UB7FyumhAI89Vzu25DuYNhgrdR0TA0zNLodVd4yBxj7zrJb2T1X45P4Y0mNhbiGxslARYWCFfBstmgUYKMwoHXfINXXwF5tcEx2YYxao8NJl1HXgumRrbVelvYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(8676002)(66476007)(76116006)(66446008)(66556008)(122000001)(82960400001)(4744005)(110136005)(54906003)(55016003)(5660300002)(8936002)(66946007)(64756008)(7416002)(316002)(52536014)(4326008)(33656002)(86362001)(186003)(83380400001)(38070700005)(478600001)(71200400001)(26005)(41300700001)(2906002)(7696005)(6506007)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XDCf/fhMuosmuj0UvKeLmrdEIVmKTFHzW7Z3Qfj2T0Gzb0DNhDW1m8P8sdxQ?=
 =?us-ascii?Q?I12oADJKUwJT6HZo0cQXfFHsiqFFwSIQuG++sJHm6piit/L9f8mY3ow4d33d?=
 =?us-ascii?Q?/s/72d0fA4YcdE3tU6xNQiBXd47hB7D+/2HouxBbpOdicUvHSzCBmjsNcjBo?=
 =?us-ascii?Q?W/J0DN9n+8jHwdhvSFzQHDlmLSi4HGACgHWnQqBFe9XcxLbr3TH2kv00zTWY?=
 =?us-ascii?Q?Of4d+W1f2nxuuA5Zn2ZM0i0nfYoN4z8e1aIUWI6v+gFk2W8KyX7PDzFmMAfg?=
 =?us-ascii?Q?JPyCq0wXzQG3Ws9OJ9emGEuWORXoi6vGrCJ+bn5d0HsEwLQYNafzIfxU9lUp?=
 =?us-ascii?Q?qsgqcuv9x7aHQuUK1kBLDXueoCUUIHUfdYWpQBJF5HtweT37TMW0c488hIA+?=
 =?us-ascii?Q?O0Kfpd0tI0L5FAn5ZeNdIlhKPxjqa/gXL5LiZJicPiTEWD8utZXRO23w8Xxh?=
 =?us-ascii?Q?xa4CESUi2qBjeRUuAlxn7O4oJ3Fh2YPBItnUtZUGfSbe6AS68dS0/0c2diMw?=
 =?us-ascii?Q?qsSsa6zxlAMLCGFJ/ZuDf/6LNqhLuTEg3GxkwpJPDAidqZYdo33E+pU2AUC5?=
 =?us-ascii?Q?lG4X+CHfPGyTcDVwHQEFAHocwe1RbXgcR94rZVq+smhwX4vgO7BHGRqi2CvF?=
 =?us-ascii?Q?uqb7G974V5ZKMHFJcWUMWZfQ1Qs+7z6p+X2rZKkGQHJ67MF0nQxq+ZxDeFPo?=
 =?us-ascii?Q?US/n0Gu/5ZF8yu7Rin8KvGBWKCtUbnL5KjOz9+WbKD61D5R7qzicDe82qtoC?=
 =?us-ascii?Q?/OzJQTfP3o2WnvJHA3qNoHhOTdc2y3TZ+NvJgOKEExi7PBh8okCre4TWaC+3?=
 =?us-ascii?Q?82k6zJR6zYYHxTO1RFrjTGapo7a7/AznQ0oQmEc63JC5fSK5Tm5nscjzrv87?=
 =?us-ascii?Q?T3yJtlHb6OrTo6b2bUTg2KR8TJTzaMjAG8/LC28aA4gA0v4ptD/hD2fJNFJO?=
 =?us-ascii?Q?/NXzFD8pvv+zzuprRs9sA5X4oxHrI1MLJ6K7JSIqdyli0SzXEIb2mo99YYHV?=
 =?us-ascii?Q?RbOZEcjBX96SSQiC3xFZpmZmQ7PXfWEnWnSMiGm8skzyis0iGVW4Bf0+oqT6?=
 =?us-ascii?Q?1dkjYqqSutM83hBI5oB478KbcdEdfeQbIGz5+GYHh95wWML8NR2u2atlONS/?=
 =?us-ascii?Q?PrrvNfIUhwKS8kL9CyV7ehLTJxAMInsFNt0PM1w0nTSwVJ2SWGtz211W5nMx?=
 =?us-ascii?Q?DSt9CExT1gnPHiV0A3zoVnpx5PnxZcJzJbRptf0ugsa6gRzDhi4lbxGGDlf7?=
 =?us-ascii?Q?bQSRbLBq6bzjJz3IPwdoXraPIgF7gaaPf9UghtySyEPE1obWC1KFygT2MZ1h?=
 =?us-ascii?Q?mMELUafjmmfRZ0jAYXunM1rM3wGHe6cqbjnOazzp/IZCDbFHP2BZaR4YHNF/?=
 =?us-ascii?Q?GG4hdrH9sytXsWVmCH2KUeI/s/S5NpLmR5BSVoXmkiupwoj8PInyMppvOa1Z?=
 =?us-ascii?Q?j5UvOrx2HRCdvA/bmJ91+mIf7Aro5fyY1DPllBT/d5pGOXwrZltkVPfughPE?=
 =?us-ascii?Q?MpTGxncUkrS1FAbbQHxjG82s1kbMsBk2RaYWlQEjt62iz0Wtc6MyvTVeBjjQ?=
 =?us-ascii?Q?bYb85Yl3gn/rka5vhVBW4Um9nwPpoWtPL13DZGJp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa16b551-7f80-4bf1-b7f0-08da9c730324
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 08:18:21.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wda7J1NrafHJysJpoPhwOCKN0QfnIigmtPKTR23/3CMuUs6ha6vmOi2bJKkJgdanu1SlDawwUZsW9E5DY047Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 21, 2022 4:23 PM
>=20
> Following the new rules in include/linux/iommu.h kdocs, EINVAL now can be
> used to indicate that domain and device are incompatible by a caller that
> treats it as a soft failure and tries attaching to another domain.
>=20
> On the other hand, there are ->attach_dev callback functions returning it
> for obvious device-specific errors. They will result in some inefficiency
> in the caller handling routine.
>=20
> Update these places to corresponding errnos following the new rules.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
