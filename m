Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58F62B1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiKPDxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKPDxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:53:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A506CD4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668570800; x=1700106800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zSphwdZvFdN28XQNk14AbVAmcKCeXrTFS+eAzK0TOak=;
  b=J5OMgeZ9K/0Ov+H2e5mIFkHh0lh4aof+QeAAgOnzjKV32xelGk/ECWOH
   qg8HmcVvsOKwQmyoKFYuhSUr7poom3QYC9xFCzEuyzsptHPQs65etcEAj
   45pbwH4O392wHHLM/Ck8QSWWJVWWXxxXzafGHxfZIUBDG2Ip+8gsvuJ8k
   l4Ej5hl47zO86nx9AAeR26WfSIH1c8hsHztJALCXuhWGIoVIzrseUd8Pe
   SFMgtXR0fGIb85HbTxIZnju89qGn/WcYBPLQ+oIU6qAcv0PXO/oE2aSNq
   6aqZp3PAlgNgSGoYGhlRhKUZLkhSs8j9I7YiXCBRhLOtZzEyJm0n6uGIX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398728897"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398728897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 19:53:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672243082"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="672243082"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2022 19:53:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:53:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 19:53:08 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 19:53:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc0pCf1jvL8NjANshrwDqv9pABR+gS/d1yswCNnUkkEnumCeNRR0rEUWE0if+Qv7tZ6ymJ//Q75CIA2mjstMQ9CFGNffZTl7gBJ7tXh/sNq5nHRDXsNvZFB7axNd7JImLb6sotrYyxkKNKm533tL6zqyBORiFXr6woxQqp69bS/QOMnVCTZEpZOAdXkyEdSytmm6iWkuqSF1khE1qoHFdrp8TCeCcNq6QvStRkmcTYm5TC9qTX9fHBv4SKCZOkUAzKddvVcTEN4bIwXYl6qGm2Maj5ohxMHy2MZjFiuKkB2Ahd+0O22iKSPcVUg9sdsfpwat/KbadPgxlIu1U57dKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekKAHQFDtTTfAyXFPKBFDBZhfS+ZoN1cZd5EKNgssoU=;
 b=Qqf9ve6imDzLNlAGtOFPhpkMv3O/QRIi1USL8bD/gyeJ8LFvg+/htvKDiFJc32FAZpQEFVRhEDtNCx5vVbu+sNTqQ0/b2mh8w/rEyHjBiLTUjXzuCn7F3UsSq8uxsIANf5OrEZ7BDRUMRyl/2HYQKzbOsWCsX1Ot0aOCCU00VV/FVrpjm6kIOsEXFI0LcqpCW6/LKkgG92YBYKivqu0i2RXTC3IHAK3022b+GqzPCD8kuskWVCCnccz9PlGO/vf1P8TXMWg9oONVu0Ab5GpQssEYxUwn2l0lu5F9P65IfOAXt6WwFruIQKwvrZO1CmAadc/4w3etL4ZG8TtF6+I49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 03:53:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 03:53:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Thread-Topic: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Thread-Index: AQHY98siMKR1/esT2UmXGuRo20ktuq5A7buQ
Date:   Wed, 16 Nov 2022 03:53:06 +0000
Message-ID: <BN9PR11MB527668E6C7666CAA5F0804428C079@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-5-baolu.lu@linux.intel.com>
In-Reply-To: <20221114014049.3959-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: 34ecfff0-44d0-47b8-75ad-08dac78611de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IFSUy+HDawVEaKxX/9NBOWbp2JFnKEEIKD/ut6AEfAfj5aZkEQpDYLdsp7v1AjGHL2AN/uhjuQ6cKsr/JifBGEOemenABy/22N65OsfxceIlDCFlnoedt8wEUx3/UqAvXc+hSqSnhI1M4GidQLpPzTwqxBmJNo//giFAGhkeWzIDYk8NG06QsBMOyRokq7ZLeCVVB7asSatPmuee0z5Mn1lT4xPJYTwkPhH1ln13KjrumuVrznXrPnngMcI6ykQiSj2Pnmbg3l6lNxjPhMljWpduXDU+JTkX1lAO+zyjs16ok0amrj3GI2+ifKNF/qpWsvnY46vBZ8386lnpVMUxJDS8fAiFJYWGscFFzjl8Z4oPa25kvCehDiZ7ADNgcmyVEKab2i1Gh81AhQeL/3zNzREYvdAStuqDVLTVF2WPZiDtcL+cw0Rfdgr7wzqPGpK7z9wlKSrHXDIgOy2LIDKtD1HlX7T5Sqvi96aK39BTBbv1SW43NdYtcx7W7AQChJSzJagO/k2msGa0Ml0GMXwrAspQsEqcKBUpQAJqwqewjh+3p83ifuUpMcc6PCCpbgP/rdTKqKSOKN31n/UKnCoBRTJROkzZ4ZGDatXycqQ1m0ESqW/vtV2oIoDO+jbRiUSz0K/n0LcCVIP3wRg3bsMSdR/J+vgRE5Zij2CC89K/s3Kxb44BgRwEAraoMWn5/7KGT0RkcRACYP+R/vvNmijt87WJimIjhkoVc+CHcafKjbx494CI45KQurrNXuYFD4FPPgymW6mWcHhjh1CGwJ1zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(4744005)(2906002)(5660300002)(71200400001)(41300700001)(110136005)(8676002)(66946007)(66476007)(66556008)(66446008)(76116006)(64756008)(316002)(4326008)(54906003)(86362001)(83380400001)(186003)(26005)(9686003)(6506007)(478600001)(52536014)(8936002)(7696005)(122000001)(33656002)(55016003)(38070700005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dXPWkE53SGgzmmFGlY30fKuOHpkRMSo0tDcxgyVo7YClIChoC9H8vA+eNSJx?=
 =?us-ascii?Q?8j7r4y1aPTRs0xmNkTA66dg4MjIc9b2ZRf/8Y9ozyqk0o9V6BCJCsTvLIM4k?=
 =?us-ascii?Q?9OQuSw3ACJzpBt7YPbLaA+EA3iWTE8deVsSRxoPiTqCV+4ztf58Mjrrbsfje?=
 =?us-ascii?Q?lx2Niv1tqR3PC+qIb9J3e6gQ7wyjUfmbnPE2UqlCQW7RqMMaNrNUVFp3pDsL?=
 =?us-ascii?Q?E6K+VmK3UANqznZISSLSCt5smQqYGFSuFl9qm63iH5cyalgLUhsXrGh/IMPH?=
 =?us-ascii?Q?8KTazrIsstjQHSe8ozr+pxr6DPjUBljd3Ir4rdmDzPa8ZROo+vG+id0GooiV?=
 =?us-ascii?Q?tzNWn402fHuiEq3JgfgaTFnayc2OHMAIAbN6b/BMSgZZj66fFLznNjQEWuM4?=
 =?us-ascii?Q?eQxQF+3CsQnKhQzr7AMDf3Q+7GA+pkwsmUNViW10pVZxC7b3959F9RnoiA07?=
 =?us-ascii?Q?6Jl95avl1M/s+hvtb93ldvFis7GOJQ7+M4F6zV56Ew0uv540NDQJ/cEfmlhX?=
 =?us-ascii?Q?G6PSFNWxJGAXHmVNFXcU9GcS3KynB0vKWimocE7qKxt29+MEnaa8PCI7l+Hf?=
 =?us-ascii?Q?95W02iNUagCP7rAb2HB2N8T6ib8aYBlpK1kJ8PCzhYRSZE0c9F3rsGzPTXq0?=
 =?us-ascii?Q?fSlzkSmRZX60sVNwMmj4f0Mp96QI8Iq8qtHHmMgxSLC3QwR/GYoj6/5OjoLK?=
 =?us-ascii?Q?4JgmkXv2hArvyU+uh4+EK9FXJHbHscbzfk4URxZZUy2SC+d5yMG0ctRMUuaH?=
 =?us-ascii?Q?7P+KsB8wSJK8t6FQKOuBfXwSOS8B1v8pB2z3GViPrPoFkpfSk23l3B9s3bSC?=
 =?us-ascii?Q?n2jI+L10jcCDCGG7qxyF4sy1SWSGzmsJf0Te0/H1Sb/uoaJy9LUcdMsVFf2i?=
 =?us-ascii?Q?diQKGWPJrCKZNNEKhJyjYn3Y8ES2a0vnToKmDswE+oDGzYZr/KkwshpgiP4N?=
 =?us-ascii?Q?LPFl4u0vkngj/tjZ6VQwICXZEu6ZpL8NTxO8EFpT0Tjf397CMs8F0hKm9tVv?=
 =?us-ascii?Q?uJhbG624FqWJr3CH1gPD9xhwKbvsn0JSdU3BF8J82kNziGCHeoWtmhc8gTam?=
 =?us-ascii?Q?iLqEvXXhDn6xASkFABdmCxWmR7kXbdLlLoL/TWEmRwu/7elmgSAasWgckr+u?=
 =?us-ascii?Q?IsOtPzYuNefksLp9C1Ga145HXeK6bB4zMtztULyHkeFUgmQSLb6jhpgZ75am?=
 =?us-ascii?Q?K/IG0rFDc4TD2xhl7qHPpW7NRah0lqhzadP9uN69awgFoY2oLwyvM/9cNbKo?=
 =?us-ascii?Q?z4BmbzfaBUX6FrULJtqru7O1/k2ymV7ZUxDwP5YdbcMJjSD/uSqgmbOsJ/Po?=
 =?us-ascii?Q?h+I3a7WT+HM2wneKzov0N3GMt02YT8ExxFPC1LCTOm5DzqRsHGI7S0CqNJJF?=
 =?us-ascii?Q?kseekU45N63b16oVusEoaA+GmrNQeCFuNMa7y9YLjL+xVXV38cQEOwQ4mtyS?=
 =?us-ascii?Q?dhocR1nO7VSjhg/leP5jUiDjMsJQHi403d3G6pGhzEnESM3e5MrB65RYmUgM?=
 =?us-ascii?Q?ISKZtE5OldbstG39musAxj4sd72RqPZsnmHxiCIAyM2kEXLjR/2ickDx9trW?=
 =?us-ascii?Q?IlKA7AABf7H28qwD+Bz2Vp5nK/8UijPhV4i831h5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ecfff0-44d0-47b8-75ad-08dac78611de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:53:06.5370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Seb2tgrOfS5e4noy0hEY9QJ3rH/L4jHoJQSqLih36h/XKsD5zfyOBSwkdnA1VMBPuufVCt7bvEEBQ8h/AeB2aA==
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
> @@ -4562,7 +4538,10 @@ static void intel_iommu_release_device(struct
> device *dev)
>  {
>  	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
>=20
> -	dmar_remove_one_dev_info(dev);
> +	iommu_disable_pci_caps(info);
> +	domain_context_clear(info);
> +	device_block_translation(dev);

clear context after blocking translation.

with that,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
