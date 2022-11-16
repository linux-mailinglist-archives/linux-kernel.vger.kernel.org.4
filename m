Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B4F62B1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiKPDxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKPDx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:53:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E230B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668570804; x=1700106804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xw9G67FIRNo/t+i70sEUYRkh8S4zWW7qVRs4yPoCvrk=;
  b=ntmS18BPi3SlwEeRd8noA2QJKdcIN/5hz/mquf+aWjedbqBGC4WJQ9A3
   NapXilSRyajfW2AIEiZp6rt3FRH3Gwc7xIoYHP3A/iMzkWk7jJtPQ6dil
   +A+pHEdJ5Jhtmr1uwOiXbuwc94p2dNGgKY/6ymtl8zMnogjxlLrKlCWBk
   5ZRes39ATOvvZHDXS5kqWNBl8IWd1JLb5gIlaZw8pwbDGlF6K2oa8WIdE
   NdRRr61UW+j6A4oI5RHd4Z4JOA3aL44MIHIU92WRwTdc7yxhipKRyhLci
   khUoW98QiphK1Uqovn7ha9BJHtn3pgxQv/iZe+L2bFTIAVHwDEdzq0Ddo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311147334"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="311147334"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 19:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968265282"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968265282"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2022 19:53:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:53:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 19:53:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 19:53:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDZqtIXFng/8nfC9yLfYkei81DFgH5VpnglKtLQFa8cm1MW/cQqxf5AiUrFdaVD35mB8zYTEg8vjP5Vc5DuuGxjtA9WhW0P4tJd/XTNxNQ/AGCphVs6iSKcGhxdBbKsdDmT84pV8q2BTF0+nyDFZmoOGW2sLg3Zs2tZCErG5zShSuYbQNw4qmz5bZ6PjyD//l/dQ+dcYgV6Qw1zps1/0cY3amL1bo4XNWRrfxM4pHmp9zO93thC7O0oviPGAcnQ7mABW+yqOsjiR1L5RfBCkLGFD4fBv/NWeeOIljgiHDser0t5PyOFlGNrpj+IWEtXCmnSVyTCmgb4XNx0WeLVKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw9G67FIRNo/t+i70sEUYRkh8S4zWW7qVRs4yPoCvrk=;
 b=G95XcP2lf9T6lahEoSXVLIvl0lwMvFKD7Ak4BLtQxQUyMJDsJTRcM7pX9ziKCybXqxU09Qect9eZsxLI7LGoBEXdX+q/vZ5nQTjzNjlcgu1NapOsQ/7sq+3HLekoXmNkbMRQKAXDkJrntNLvieHl0tJaoFZBSn5cN1jccYqySGfXZFPGCLRlEk0P1oVtS2Z5AKwCp245kWpPHmU45aozZhdDNfguDPF0haBgXFDVmXT+H4W9YUOqDeKyZA9vkiy1bXPbuilZ5WSGpKYdGkDnq47v9L36iHHDNGEhmi/0WuiQ2oT/y3SzjUquc9f58X6ITMfDVT2ACfGnZB/kAZa2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 03:53:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 03:53:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/7] iommu/vt-d: Rename domain_add_dev_info()
Thread-Topic: [PATCH v3 5/7] iommu/vt-d: Rename domain_add_dev_info()
Thread-Index: AQHY98sl1pe4vKNmT0CCuz7auMaee65A7k0Q
Date:   Wed, 16 Nov 2022 03:53:22 +0000
Message-ID: <BN9PR11MB5276AF86E7BE7A3B88094BA98C079@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-6-baolu.lu@linux.intel.com>
In-Reply-To: <20221114014049.3959-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: fa559b38-3238-466e-00cd-08dac7861b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z3Oaubgl9v+nqNPoAZ8FwKwn82aus5ipBlhU+RD1ymuFA1kIuCEmMSf3n9uGHH/W1MxYFlJYfdZUdtpOhdewwDvolS2Dnl7oEwtfpZtC5UlGpkKAijkq183ReJh87xs7zWq2xGn4q9dSRcrDcTuBlXzZY0F9z4CgqV2lYS84zniviFQfsUNX8deq+wYrsmgx/MM//cnOttobe/b4ceEaJj0hrfiL+S0JfYPLmWcTg2XYveuO9yxA1Px6Ynw7ujSNbNwW77sE4wAydY7bFBRR2VlXUVXAr6b5j5u+xeokcAk3KXiito743o6Jg3NE8dMobzhcTRSMCgasHBgeURnwNJDw5ozmEDz/eyLs7iL5tdHHxcFHh+8yPec+z8rimlVO8l91RajLPqNjAybYrEiRcOxfVSXMwD+mAVk1O7OxCQnLNnrsFj6ka4L4i1jQ1DNslAZiNNdX3PtEJWrCPO5AvJHARG/LV21MGnlexPrTfS3pin39MbBxsUWzytRSonJodzqFGH8ClrXobCA5vy8Y6qG8qXyUcRYd9AD0cX12O7NUnpchbiU6MxMozX09VMaNeqcUTTx/oswXaEkIGYeur4PgaI/c+g0y1cyb/tfsMuaCezNcwTlAQcSzhp4CF4eTKQlCcEaPCSXBOfN7Z9Z8gDwyAemTa55fIDzerD0RKRC8CCqKBCR3Zt2Ik3BprRxaze/NblI+JJ66OqqYCq+7I2rQ0ChREe5y1g+BppCbz68KP1j2VsfZ0GElcqniPWHCajmtyXecYb3PRioJdLdMvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(2906002)(5660300002)(71200400001)(41300700001)(110136005)(8676002)(66946007)(66476007)(66556008)(66446008)(76116006)(64756008)(316002)(4326008)(558084003)(54906003)(86362001)(186003)(26005)(9686003)(6506007)(478600001)(52536014)(8936002)(7696005)(122000001)(33656002)(55016003)(38070700005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TGnQxuvlct+8Brq14qPAV95LnRI5AQny+o7Lm2PSIGKo4Y9pYGqPFGoHxC4G?=
 =?us-ascii?Q?LBX4MD2MLqsJh0E4It8Kp3K2ecfJKHZA+uVXn8mITpv5VLf1cZO3VswavrvK?=
 =?us-ascii?Q?/CdGB26BUYD3ybVfhPBQOTOIPYie78ds5LgOHNdPHNLjiSDsO/QPDDdj9Npf?=
 =?us-ascii?Q?fMyLm7n6W9+DoBEjFADqqD8UjTE9Bbz6NisKFbeiVA4hB6U4R64HhqEZVzKf?=
 =?us-ascii?Q?RsRbOACzQ/Nt5Ztk4YGzQQlfioP6BN7044p8+loC9B3g2z3ZcD5KQIr3pHLV?=
 =?us-ascii?Q?y94ZycEsTK7hEy7+YVy1sS1mHl5ZAtBbR4Wn8e9C6cTUGXMtZm2ydii/PMQn?=
 =?us-ascii?Q?c7azTAXRg9bYluyPQvfoisHcN3n2IO//zlB0hni6C55g9UkQlRTQpa6g/UV1?=
 =?us-ascii?Q?2UT03gSDY1FYdtE0M59RAiN7CCFBALqY5ixuu9TRV+SLrlv5oYev0ByGq3DS?=
 =?us-ascii?Q?gKQr9QKygjWVEABa2X129fRS+RPB7GlYKBeOXEebRgDIXN3QeEPOWBW/Hf63?=
 =?us-ascii?Q?u8r+YlgHUac4Daax63zdxWVjS9/vL7KG8vqFKw7fKMzfn56MVjLnU/glVNun?=
 =?us-ascii?Q?3vSrwETfSmxubANqPhErn4Flud+awNpWcaZtpvfBonzAz1agmz97po+g5CaK?=
 =?us-ascii?Q?S2gW/oBnA7A2N/5cJFIwFb7Comc18129f+zpr0ZM6g1RSuAYvI9SMQu7gbbJ?=
 =?us-ascii?Q?clpLeYz+uHEY9SEw8zXCTg/0nvOWxg7PmNBkJnjV3TvO4pkCdDuinr6b52RR?=
 =?us-ascii?Q?bJ1D9mW4yK80jm1EAv6TFNnm7YbFy9WKk+K1fT+ZR8KRbW1pMKtJSuMZa8nN?=
 =?us-ascii?Q?BTgDXCWxK0r9H064WQ6QWvmztYKbZJHHT0D3FtogOG/EMEO3Y16SPFHcDOPz?=
 =?us-ascii?Q?wmrZn/GAiivfkZg8tDhPUVxuV6jHQIvKlMNK2qV0uXSJHI1TsydsduGZG2s8?=
 =?us-ascii?Q?7wPapYPOV6T4e2Y1XpBmLL7gRnK3jvfkOrnrhZLTTqC8UzoN4ByfgvbDKzOG?=
 =?us-ascii?Q?HnP/J1Da6qfrCvT+PNEAs7nErrFbs1d3Yw+p2Cazh0gK/g3RebYCcAKSxIBA?=
 =?us-ascii?Q?FWXtLQ09BoW5WxzSwQ4h9cDpYF+XGfiyAe35xGVvPYe1wA62ePKEkY0x2kt6?=
 =?us-ascii?Q?RVvYvbVn7aDSiqizwQ1w5hkaT/GFXSzYf4envwVtbb1hsE5ftLsRwKceq6zV?=
 =?us-ascii?Q?/AWL0aZKXs0cDglMTfDpNbqJ6F7WCj0n/vvkuYwjKy51FWx/PE9yn+AoG4Bo?=
 =?us-ascii?Q?LiO5w5Jd1RMCs5/x71eIxNI4S6sRB6mSsbgFefC7Tcip+Nedpa5UpQ0BYLz7?=
 =?us-ascii?Q?PwRYO3gyg8DpxSuADorBAq6WVR4lgEbFy6q3mVSeB3e0QpO9Hk44t9mn9d01?=
 =?us-ascii?Q?pfBNqUW/X3v0Clz7ch3NIQRvWEFfXgoEhYfpGU7gEF9XSumfOKGnP9ycCPVB?=
 =?us-ascii?Q?Zpj+mqK+uL+05S422KDqhCE1jUFb/LmSimEKd6KdNsJCgfHL8vm81thB1Tdh?=
 =?us-ascii?Q?v4ps6kZfG/I00sIWXGvzPikXiS107OXVseJE3ebrPkm2PnQdV+P/DIuce083?=
 =?us-ascii?Q?VgIyLel3MaW3DxpTVbMghtmccyo09o6ExBX5V5Lx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa559b38-3238-466e-00cd-08dac7861b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:53:22.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mK/Z/TpLUsR98GCmiwnT3xBvLtoVJcbIcY0devrXwAOptjg7ibATEefGjR8JMG5YJoiJLFrQTt4UgJ8LdxWRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
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
> Sent: Monday, November 14, 2022 9:41 AM
>=20
> dmar_domain_attach_device() is more meaningful according to what this
> helper does.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
