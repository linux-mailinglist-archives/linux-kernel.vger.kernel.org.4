Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8733B686023
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBAHAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjBAG7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:59:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390855CFE8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675234782; x=1706770782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/3p7HeM0hhgpZRbd3LCZIxYBSXzFP2Xcg9iHE5sWoEg=;
  b=M+s0XbLmzHsz3Y6GJGVd7Z1ZqVStjXVcaYi7bCwWdpIyHftsmCh9GUN9
   ygbimnLtXrX8iMmaLI0GS5TyoSnT4NcuTSr8o/O3hjqnOWNrrSf+lFkFO
   br6OUG7e3bNJTLNQd08rMmm1kJJaQa4ghdtkadycLYwm9B0Mdiw/Ue7j3
   6e/H9vdy8dLWrMoJvitTsAOwiGLalM9S916qK/QyvFiVQLK3BvVazzILv
   /lWKOVDKqnJUajspSSIUl1aNIQtkJZeNbzF9zmUDeUa42UIOma4+6rudF
   +7NFwZ6LiRrVu5+ehFXtb9Ko+0vnAG3wOZbZVsfjUMavaEkcjFesH+8pF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="328076658"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="328076658"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 22:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="697119123"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="697119123"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2023 22:59:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 22:59:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 22:59:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 22:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCUL3w81rkpDulBGkf6uBIRBGAAACSjn4MX9y5kMRoL5nf6aQBtm1kadZQqGFEtbFKXfOpO5gMlcbhlRPd2LHE3nmDYU9TsYOIL/M8yJEdG7Olue1gf2BkxbEGiwnOfHM96LRm3UZ04U6gxP+VZbl7ePyYjY/jj6K6MpyfGjP/a5POMC8lLJmJyECjVhpQTNLuHgKPVKzny0FSRzfut4/tFvTlbbmCxdad9z2uF/AwLw2j4nz5fEHvyy+EH5fTsaS98Z/Gkz/Z3/xZPPAs3ggZRdg0+6rq3kX6194bgOmWtoV6wQEfU6mInPcx5eJrGnS8Oo0yw2KIm0Rhj9fnHOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3p7HeM0hhgpZRbd3LCZIxYBSXzFP2Xcg9iHE5sWoEg=;
 b=MhqLGauR/+QStq2h0Fgr3tJU64Kutykk3tc7Ge40QkW2RpVDkV8eVpOCpt8Gf7+mr/iaUYcwzJjWkecsTmR/yemxpDdS2A9ZZeKezVj0drvbxb1b5T9Uf/Fm44Vktww92v2KqaJ+Mgsmlx8Pdv4R6wPMGbohqc5oU/AGW8qcyCcB3aZHNP8BL769exfKYhat98CBV+8KXYnJij8mXDfjN6WOzQ8xawVi39dWOi7inRDikyBUJRzP07eANJme4PyKAstBwiC5GQ/nPuVyvdypcKpw30kXxZn3TJDhlvd60D5NPUmd7nrZg9OFOY3j254ceXNPcps+PHn+hqEu+PSuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:59:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 06:59:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Topic: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Index: AQHZM14dxdHVToGJbUKK/xSgiTyXrK61IE4ggAAUtQCAAY21gIACqcMQgAA/WQCAAAFJgA==
Date:   Wed, 1 Feb 2023 06:59:21 +0000
Message-ID: <BN9PR11MB52766EAE924EB5DC320FC1488CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia> <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
 <BN9PR11MB52769883FEE25F0BA731220B8CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
 <df494d34-d804-e743-023f-d1effc881628@linux.intel.com>
In-Reply-To: <df494d34-d804-e743-023f-d1effc881628@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6675:EE_
x-ms-office365-filtering-correlation-id: ea766ae5-2213-4656-d114-08db0421d87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vkne++Q5Ku1BcqPpbIaSwjnXCaxY0WzbmfNiQYX2A/zF/97zhHJfQdhivRkP8WcDV+//Z5P15m2idilwQyD8tgYa4306ikKz4O2gyuYt8iSj9AZhxMmPygZTCFQMwMoJKevRy2YrAmIUtp87PcgAp3R2uBV9Jv91/G9i6mBKckJGxPVl3AM8h0YKZYFr7uwUOg/XxsNmkzPdsHFvHvt/X7bdjtrlN3CrNLti9PKvFlCagfGN44PtdaGP5eiQVSgpU5elmILSTSWSuyaemqY5nWsJ/YN82bK38V+PrH/sNjwBxYVnmfAr1LP/HxSRNLRlBa4myHiqKm65L9OVMLZYsutQqtcFNBDPLMztMYdZfkt8CMpSWc4oBLappjNvVeBLcTBDVclnhFgchx/Nf+pSQbBfxl6Kqxeot2H9zdBmHB9CogSsml7LyR/OEyIhL/2gxMmiWeoq2ecJCD1Qf8gLCGTVYtMj5KR4lNVzST60r7enF7g67kVOyz56HlxgP09hbjK0qo67TrVLiqxd1Jh324ooOoSCuzuoD4OfNGgwlze7emlw6Jc/IioebYvcAufvVVJ5Zw3qXM0Rk1h2rfDI1JingLmM72WwVoClHMI8IIITFnDdulW7/Oq4aVAyHtuG+F0u0gJqKQAeZExzFJMdFm/6jIwYeuUYfNdx84hSEWM0rz/qgKsk3G9UM3OyRviLMDKz3lorn5aIxA/4zzxLAUmuzErkR8UrT0J9t/OotQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(26005)(82960400001)(8676002)(66446008)(66556008)(64756008)(38070700005)(66476007)(54906003)(4326008)(66946007)(110136005)(76116006)(316002)(38100700002)(122000001)(53546011)(6506007)(186003)(7696005)(9686003)(83380400001)(71200400001)(55016003)(966005)(33656002)(478600001)(52536014)(2906002)(41300700001)(5660300002)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JrS2Y2L1N6bnJoYUI4Qi9PV1JDR05HbHcvK2ZFSjZIY0NEMDdzTFIzMGVz?=
 =?utf-8?B?YmpoZm5zRHRIWDB5d0JPTmlWRHB6ZkVTcStkSFVjQjQ0a0lqMXg5eGRxUVR6?=
 =?utf-8?B?enpTZU9rN3NPdlFUWGNZRmpHalNyRDZrQjdHWCtPcmNWekVHTlhTMVEzNXM5?=
 =?utf-8?B?QWFxWjhVNUkzaVZBVnRJQkZ3NWNzQytWMGlzSXlicjMzNTVWcDRLRmxWTXhE?=
 =?utf-8?B?TXBrZFY4Wm9wS2I3V0Q5WmFzSDFrbFJUeTdnMUNuWmR4VDArTVMrMzJ5bFNp?=
 =?utf-8?B?czI3THpKdTNVZk1aQmU0QXRiZHNuSFR1WGdiL3JBYXhpK3loQ1dqakdFbDBC?=
 =?utf-8?B?SHJ5UzN5b2lnUHh5WlVqeTRZVXRrZXphSjNtbEJJZ2FMdHZMZmd1ZXYxMUFH?=
 =?utf-8?B?c2JoUUo1Z0d0Y0FmMjM3YTNEWmpYRVhGZSs3djRkM1g3VHZHYU92SmJNaVBT?=
 =?utf-8?B?NWlGcjhSVkFkbC8yVHkycjVlNWNYNkRBenNxSEQ0OW9KaTVkTnJHUWVvZ2Zx?=
 =?utf-8?B?cHpLeXl6T2Y3RjN2bG51ak0yZEhpNFZFV0JoYm1ucFNtNmJFYjhFOGMxRVpl?=
 =?utf-8?B?b0krV2FiMzRBS3cvbUVQNFFsOVNyUDBXYzNUOXBhbFBKV3o4VVYwdzMvdDFO?=
 =?utf-8?B?RzRBalJ4SStjenVITlVYZU56UEQvd2dPQmptS3NrdkxNT1lvMVpDaXA2MUdV?=
 =?utf-8?B?UGc1c0ZNeUg2Z1lMczg0UjcwUjZwVGt6dmJxYmJPcGVqNFNMeEZtOExQZk1j?=
 =?utf-8?B?Y3hpOXVvb1FORFgxWDF6M1BGQ3o1T2ZaK1VIdkw4L2lQSWV1TE1ONGVsZGpa?=
 =?utf-8?B?ZVRMam56VnVxS0FZNnhUWXJZUDVKUFBTMWdDOThDVHcyUWsvNmxUTlY5VFdm?=
 =?utf-8?B?bTNVNTRyUWhGTkR5ZS8vYXpLZ0RzbHlkS05MdzBpcmJMWlk5S0lVY09HdW5v?=
 =?utf-8?B?cC8rSlFpdWRxcWJKbzZEZ05hMkRHK29XV3lJa2tqZ0Q2emFmSVl4amdDOFNi?=
 =?utf-8?B?bHpvMkZCeGxRTG9kV0srczd4Wk1LUk1LNE84SFZ4TkNCUlpEY3I3dEx2eTl5?=
 =?utf-8?B?dDQ5NCt1V0JDV3F3NWtpY3puMDcyMVBLR2dWV3VxNW8zQnoyWHNFQWdia0lu?=
 =?utf-8?B?Ry82bjhQQ2dFL3UrYjdoMmFyNU8xODVlV01sZVg2RG1PZEhxVE1XRHJZWmVC?=
 =?utf-8?B?SFZlQVduMWp3N3dSd0FyM3FIcll2ckkydS95Z09QN0JiNitGTktQSGZCMWh3?=
 =?utf-8?B?R1FoVkZud0Y3WlRxOExEN2wxRElISkJMaGV2NE9PTzdidVR6Rk1uNXpFaFBm?=
 =?utf-8?B?UHRLY2lHc1haTWFiL1NFVXpyUXZabFVPNmEvektpRXN3cFZpaE0xdDcrbURm?=
 =?utf-8?B?M1U2T2kwQ3JMTWQyTzhSdEFVUURoTXFnWEJoV1hBa0N3VUs4b0dmd2QvU2pu?=
 =?utf-8?B?QkR5dGZucnorQVFDZkxORVBRbktONHdnSEwyVHd5eVQ2L0E4NHorVCt2RU1k?=
 =?utf-8?B?cUV5cDh5SE5IOWFQTkdyWnA5anZoWi9KWGhSVXZvbmN4bDFJWTdiR3czYklL?=
 =?utf-8?B?eUpuNnFDRUFxRTJWb29saVJRZkpwMUN3eEVia0p0V0htVEtHRStvVnYxMUpl?=
 =?utf-8?B?Tm9ORWpvWVVWd0tMODlEWU14V1NjMUJkbHJsdDhhMHg2dkdpaHNkV1VBZU0w?=
 =?utf-8?B?SXA0QXQ4NUp5ZFZ4dmxJNUdCSURNS3QzVVM3eWovaThta2tmMSsvMWdWY21I?=
 =?utf-8?B?NlBkTGZmemVIemZkMEE4OEpCZWd4SmtvMm1PN2ZMUFk5VkExc1VESC9tK01L?=
 =?utf-8?B?M1QvWFNqTlROVW5GakVnU050bEpuWlhrd1VZT0gzQVFpaUVDaVZKeWxaQnQ3?=
 =?utf-8?B?c3Z4YVdocXFlcndMZ0tuMGxvMlNvaHluMkFWMGJZbTFtc2drcGViNjFFZmZZ?=
 =?utf-8?B?NzNvMnpVa2xXRkJCeU9IMDRrVEFHaWtDMjZIaFNYUWx1bkJ6T2hmUVBPMFpY?=
 =?utf-8?B?T3ZyMWJ6N21ydDhMRThqZnptR3BmUmVpKzdpUjJtMzlzRE81OFFQYWlpbDFi?=
 =?utf-8?B?TVNoM01pL1Z6UzFIalhGNmdXbnVuL0srcUd0eUw0Q1VabGpyWnRwZWhRSDBP?=
 =?utf-8?Q?xz7D5rpcpxH4CvpoVZPxr1p1Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea766ae5-2213-4656-d114-08db0421d87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 06:59:21.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cUxfS96KIl2Zk7YyewwqMt4PbAY1UtVrc82Gk1VIbn4bRgZ2HUwukfWCuN3VcDvSUo+mepz0k5sL7vK2HfH5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDEsIDIwMjMgMjo0OSBQTQ0KPiANCj4gT24gMjAyMy8yLzEgMTE6MDcs
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52
aWRpYS5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAzMCwgMjAyMyA2OjIyIFBNDQo+
ID4+DQo+ID4+IE9uIFN1biwgSmFuIDI5LCAyMDIzIGF0IDAyOjM4OjU1QU0gLTA4MDAsIE5pY29s
aW4gQ2hlbiB3cm90ZToNCj4gPj4NCj4gPj4+Pj4gQEAgLTM4NSwxMCArMzcyLDggQEAgdm9pZCBp
b21tdWZkX2RldmljZV9kZXRhY2goc3RydWN0DQo+ID4+Pj4+IGlvbW11ZmRfZGV2aWNlICppZGV2
KQ0KPiA+Pj4+PiAgICAgICAgc3RydWN0IGlvbW11ZmRfaHdfcGFnZXRhYmxlICpod3B0ID0gaWRl
di0+aHdwdDsNCj4gPj4+Pj4NCj4gPj4+Pj4gICAgICAgIG11dGV4X2xvY2soJmh3cHQtPmlvYXMt
Pm11dGV4KTsNCj4gPj4+Pj4gLSAgICAgbXV0ZXhfbG9jaygmaHdwdC0+ZGV2aWNlc19sb2NrKTsN
Cj4gPj4+Pj4gICAgICAgIHJlZmNvdW50X2RlYyhod3B0LT5kZXZpY2VzX3VzZXJzKTsNCj4gPj4+
Pj4gLSAgICAgbGlzdF9kZWwoJmlkZXYtPmRldmljZXNfaXRlbSk7DQo+ID4+Pj4+IC0gICAgIGlm
ICghaW9tbXVmZF9od19wYWdldGFibGVfaGFzX2dyb3VwKGh3cHQsIGlkZXYtPmdyb3VwKSkgew0K
PiA+Pj4+PiArICAgICBpZiAoaW9tbXVmZF9od19wYWdldGFibGVfaGFzX2RldmljZShod3B0LCBp
ZGV2LT5kZXYpKSB7DQo+ID4+Pj4+ICAgICAgICAgICAgICAgIGlmIChyZWZjb3VudF9yZWFkKGh3
cHQtPmRldmljZXNfdXNlcnMpID09IDEpIHsNCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICBpb3B0X3RhYmxlX3JlbW92ZV9kb21haW4oJmh3cHQtPmlvYXMtPmlvcHQsDQo+ID4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3cHQtPmRvbWFp
bik7DQo+ID4+Pj4+IEBAIC0zOTcsNyArMzgyLDYgQEAgdm9pZCBpb21tdWZkX2RldmljZV9kZXRh
Y2goc3RydWN0DQo+ID4+IGlvbW11ZmRfZGV2aWNlDQo+ID4+Pj4+ICppZGV2KQ0KPiA+Pj4+PiAg
ICAgICAgICAgICAgICBpb21tdV9kZXRhY2hfZ3JvdXAoaHdwdC0+ZG9tYWluLCBpZGV2LT5ncm91
cCk7DQo+ID4+Pj4+ICAgICAgICB9DQo+ID4+Pj4NCj4gPj4+PiBlbW1tIGhvdyBkbyB3ZSB0cmFj
ayBsYXN0IGRldmljZSBkZXRhY2ggaW4gYSBncm91cD8gSGVyZSB0aGUgZmlyc3QNCj4gPj4+PiBk
ZXZpY2UgZGV0YWNoIGFscmVhZHkgbGVhZHMgdG8gZ3JvdXAgZGV0YWNoLi4uDQo+ID4+Pg0KPiA+
Pj4gT2ggbm8uIFRoYXQncyBhIGJ1Zy4gVGhhbmtzIGZvciBjYXRjaGluZyBpdC4NCj4gPj4+DQo+
ID4+PiBXZSBuZWVkIGFuIGFkZGl0aW9uYWwgcmVmY291bnQgc29tZXdoZXJlIHRvIHRyYWNrIHRo
ZSBudW1iZXIgb2YNCj4gPj4+IGF0dGFjaGVkIGRldmljZXMgaW4gdGhlIGlvbW11X2dyb3VwLg0K
PiA+Pg0KPiA+PiBXb25kZXJpbmcgaWYgd2UgY2FuIGxldCBpb21tdV9hdHRhY2gvZGV0YWNoX2Rl
dmljZSBoYW5kbGUgdGhpczoNCj4gPj4NCj4gPg0KPiA+IHRoYXQgaXMgdGhlIGRlc2lyZWQgd2F5
IHRvIGZ1bGx5IHJlbW92ZSBncm91cCBhd2FyZW5lc3MgaW4gaW9tbXVmZC4NCj4gPg0KPiA+IGJ1
dCBpaXJjIHRoZXJlIHdlcmUgc29tZSBjb25jZXJucyBvbiBjaGFuZ2luZyB0aGVpciBzZW1hbnRp
Y3MuIEJ1dA0KPiA+IEkgZG9uJ3QgcmVtZW1iZXIgdGhlIGRldGFpbCBub3cuIEphc29uIG1pZ2h0
IGtub3cuIGFsc28gK0Jhb2x1L1JvYmluLg0KPiA+DQo+ID4gb3RoZXJ3aXNlIGFzIGxvbmcgYXMg
dGhlIGdyb3VwIGF0dGFjaC9kZXRhY2ggY29udGludWVzIHRvIGJlIHVzZWQNCj4gPiB0aGVuIGlk
ZW50aWZ5aW5nIGxhc3QgZGV2aWNlIGluIHRoZSBncm91cCBhbHdheXMgbmVlZHMgc29tZSBoYWNr
DQo+ID4gd2l0aGluIGlvbW11ZmQgaXRzZWxmLg0KPiANCj4gSSBoYXZlIHRyaWVkIHRvIHNvbHZl
IHRoaXMgcHJvYmxlbS4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11
LzIwMjIwMTA2MDIyMDUzLjI0MDY3NDgtMS0NCj4gYmFvbHUubHVAbGludXguaW50ZWwuY29tLw0K
PiANCj4gSSBtYXkgbmVlZCB0byByZXZpZXcgdGhlIG9yaWdpbmFsIGRpc2N1c3Npb24gdG8gc2Vl
IGlmIEkgY2FuIHVwZGF0ZSBhDQo+IG5ldyB2ZXJzaW9uLg0KPiANCg0KZW1tIGxvb2tzIHRoZXJl
IGFyZSBxdWl0ZSBzb21lIGRpc2N1c3Npb25zIHRvIGNhdGNoIHVwLg0KDQphbnl3YXkgYXNzdW1p
bmcgdGhpcyB3aWxsIGhhcHBlbiwgTmljb2xpbiBkbyB3ZSBzdGlsbCB3YW50IHRoaXMNCnByZXBh
cmF0b3J5IHNlcmllcyBmb3IgY29taW5nIG5lc3Rpbmcgc3VwcG9ydD8NCg0KaWl1YyB0aGUgbWFp
biBtb3RpdmF0aW9uIHdhcyBvbiB0aGUgY29tcGxleGl0eSBvZiBzMiBhdHRhY2hpbmcNCmJ1dCB3
aXRoIHlvdXIgZGlzY3Vzc2lvbiB3aXRoIEphc29uIGxvb2tzIGl0J3Mgc29sdmFibGUuIFRoZW4g
aWYgdGhpcw0KZ3JvdXAgaGFjayBjYW4gYmUgc2VwYXJhdGVkIGZyb20gdGhlIG5lc3Rpbmcgd29y
ayBpdCBhdm9pZHMNCnVubmVjZXNzYXJ5IGRlcGVuZGVuY3kgaW4tYmV0d2Vlbi4gDQo=
