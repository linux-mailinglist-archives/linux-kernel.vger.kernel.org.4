Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA326C7A72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjCXIzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCXIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:55:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C2226874
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679648137; x=1711184137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lJRj6opZ6oTeuUfNO74i00SzsX6ixIINbvHSRvFxdDM=;
  b=Z1Ng8FdSrcsCtQZh7T4yOemopJfglTpPGtNvMlmWbrxFAEblLK37uZOG
   4G9W2p44EkaFZgSqQ45Vi0ji3wcuTR94BaZKz0R2SypKcj0qpUNVEI1Wb
   375c2pphDSp0hMzkHgxMn0sKS5xaMfYWHTizv2XZb6UR4DWIRHLsM7mNS
   XfYDKDCZB7F33KdRqiU8TIu+JTHPpjQ6CuifCz/x0G0yKO7NGwZwVChV8
   rg9XW7dJrm3b3AXWNuTMCYdiHWErMwBSKN/Rx1HE/qVYK6Og9IIsx4ekk
   xMK4IA35kKHBpncgA5e30j5B+bbZObm1HgjaK+m9+RCfSipmgxpYpX4WX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338452060"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="338452060"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 01:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="1012180713"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="1012180713"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2023 01:55:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 01:55:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 01:55:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 01:55:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxNE8ZyOe9dNd0bY5pQqMtaw5htkgxI/rEmm71F0zjwjqL2ekGiAwohjngKyNmC72UxI21FIzV7TH1mP0akq1wXPEAQ2a3qsApc3b87BsBBEZr5ZptXfbDr3NUVHt1PaugV2ZE3FC50lgbIpt6VVAt3KagAJbdLMhh3UsHnXSjGNgLxLSnGCdzPMFzwMiI7tvfsOx+qFQs67j/S0wPH5EjfJaXbKG5JyV2uPDu3FF0HepIQJvhHmeLcMhr19c5I/J9NVk/dE01QLhah/dRfTifthC8gcxU9o9nA5Ah1pXTrlF92diPXGFG8ts11g/Yhe/XspWVzopHk5IN51Ig3egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJRj6opZ6oTeuUfNO74i00SzsX6ixIINbvHSRvFxdDM=;
 b=YOd1QW8+w8yJHnm5ssyfRl0FlwA0tP+jhs4aRYQmKeysMQhJBIvin4kRAbH6wfGi1bcKXpvdCn6qafFW5mZLSasjPiQ0xxo9n61kRsP+fumadjDhvmZcJKPitvXz7tBGATRl+arxWkJvjxLBhOiXbe1WTFydSbIRYUKqpT7ci/M+VKOOdq0iQiSQv5agMfL8BVG86nwNUVdCRGQ8WYX9NiDijfxENMxZvv+LM6lzRzwiQ5CSoHwfJfzZcZ77GsIfvq83lsoVA5HC1UjgwJh5WgXz5LV73hvBXqfmXyDAD0PC3Uc3NS74BxSYltMmvm2CINSPUfpbKRR4Nt4K2A1Gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 08:55:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 08:55:29 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
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
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgADahYCAAOtfAIABOh+AgAMs8gCAA9tDgIAA+ruAgABngICABQB3gIAAw4kAgAAmDYCAAAlxgIAACVkAgAAZrICAACybAIAAGG2AgAIHzQCAA2ICgA==
Date:   Fri, 24 Mar 2023 08:55:29 +0000
Message-ID: <BN9PR11MB5276135F28A099AB33A97E0E8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia> <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com> <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
 <ZBiDcYwxL7eV1EmQ@nvidia.com> <ZBiLSJvtY5UKDJ5l@Asurada-Nvidia>
 <ZBig0fN3l7LsUlQg@nvidia.com> <ZBjGPI29BE/puciv@Asurada-Nvidia>
 <ZBjauQlH3TYbZQ7P@nvidia.com> <ZBqOxNuHWPuhNy5b@Asurada-Nvidia>
In-Reply-To: <ZBqOxNuHWPuhNy5b@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6507:EE_
x-ms-office365-filtering-correlation-id: f3ae06c5-40ca-4f66-6bef-08db2c4584fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIHgzd5ziPg8HGj3vLP14uBrTwPu+OeHHJsBeKtnE8AnON9/Q8kmtcTwJ9SclDRE68PVwOch7oxuvduvTsjphXuiDBLitTT4MFsF9SJFtOdW9IvPqoEXGZu2hpsxtOdv79JtSU2w99Q9zULdX3lBPdL4d4hp0kaCZDnh9vVC7dWQdQJXtj+po2tWUNSsmStX54d3Yf85NZulZgiYhT2LFG2K2/B67CYA/c5yUTP8oB7ezCxPEVY46nSNm0desFbNbc4YOOuH/y9LFiMruKMpAWUcQw58DkH4aej8lJYXLmo4qw8I/fOW91zme8uy2hJlQhvCO/sV1v2FlXMFDH3RutUbvDXdO7VmhNCkH2gVq46/4uH00a8iCw/FyzBYlY6yNnkF5vd/UizIc+wR5lxaigBOKGQLNgXtKKPRQHtBGobmHJ9Q7yas01lAQo7z94JeLLbaPbgXZpA8q60bBb43RLKuy0WA6z7peOMLpcTk4KGBnxWOZMzNl4QQ5Qxu2rZHIM3mkVgV4hNUONZ2twl8TZc3gCJtD7tio+2SD2X1/NUIcp++d3qDTK+yVWreRsX+fMgskJDo5ncU5UAEVIZM6a+6dbMUvymN8lcxc8ODyKL/54riwMX1L3/MqEMHYkY2mG+h+5E8kLHPy4jCm1rVwTZRCiarp3Tgatrixc+faB2oWvyGSK1WKTkJWPw5mYlrRd3hhk/pGINO9XxlNK6Oxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199018)(9686003)(33656002)(38100700002)(76116006)(82960400001)(122000001)(2906002)(6506007)(26005)(186003)(8936002)(41300700001)(5660300002)(4744005)(86362001)(52536014)(7416002)(38070700005)(66476007)(7696005)(110136005)(71200400001)(8676002)(66946007)(64756008)(66556008)(478600001)(66446008)(316002)(54906003)(4326008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTk0ZjBEMlNEbGg5NXdLWlE0SzFTdWNpbVNDemIzNmZrc0d6MGVINk1RcmFr?=
 =?utf-8?B?eDNTMmJKYWxUaDJXUHRCcEFnTTU1U1ZBZjNvNFVZeU1WRFdCQTVuNUgzcnN6?=
 =?utf-8?B?dUdKWjNLNXNYakZLS1F1aHlGMnZEaTJCSXlXUFpicEorTkhWazl1NFJnMS9N?=
 =?utf-8?B?eWtoTFppeEhoMXVRbThkb05IeFQ5b21QWk93VjA0dWZ4dHV1Y0pYdEpDdHMx?=
 =?utf-8?B?TExPZ2NYR1FGam02WjNKSEpmNVllaGdIZ0FtODdyMHk3Z3hRWWJJYjEzeHZX?=
 =?utf-8?B?K1B6RlF0ZGxmbFFCdXJSTDdCSVc1ZFRqaEFCWlduSHBzbEVyTzdNa2tMaDI1?=
 =?utf-8?B?by8zZFMxNWdBeW5ZNlp4WFdldzkvSE96b3J3Rm5NUXJUMXk1OWdHL0h5VUZB?=
 =?utf-8?B?SlBkTnYxT2JIYTZGTC9RT2d6TkgxYWhweTBQa1J2S3VIN0xCM3dpZFlrTTRZ?=
 =?utf-8?B?WEdld0NScXJnd1cyL2dFK1ZmQmwxK0Z3OFZqTEZWYSt1VCtLQ3ZyY3pSV0Fn?=
 =?utf-8?B?UUttSmhSSGJSZ05oNzc2Vzk4ZnJRNitmZFFacjU3Y0xqK3hRMzlRaTNOS0pV?=
 =?utf-8?B?VElZYXh0NUpuMEM0ZnQvNk5ZYS9jNjUzZmJtY1hLU2dwVStRaURlQnJMZXEr?=
 =?utf-8?B?WmhWNUVYTDVqTWpxMWM5OFYyMzk1VHRMZlNyMm1POFhEWUNHTVVURU5tQ24w?=
 =?utf-8?B?aFJTT0ZxSnh2YnVzMDdLTjBvRFd4OFpDbFBjbTBQZ2NmTG91SmVHNXZ3Rm1G?=
 =?utf-8?B?YTJLOTYwNVFsTTJJSTZOak0wN3F5M1dqZ0t3Qkx5WkJRa0QrcTlaK05td0Zj?=
 =?utf-8?B?RWtpcmowN05Da2NLc0p2M3hHVGwvN0MwT0tRMk45R01ORlJLNkx6WE5PazB4?=
 =?utf-8?B?TTE5NnpBWkJhOFRQVnVVTzhvQ2ZkczIxWFBqNmhkVTgydWF3cDkwbVVuV1lQ?=
 =?utf-8?B?ZmI2Wjg4R05rcEpYeUUxTVV1YlJncGNRYUJpMjNxcVZLSGM0RmhUUmx2N1J2?=
 =?utf-8?B?blRyN041OFV6UjdoWkRzcnI3bnZxWlJoT3RpOTV2UCtYZzhtZVgyWWVSNlBx?=
 =?utf-8?B?cHViN2pOSVo3c2xJUWN2dlpVKzlhVXM1bGpkbVVlVVVmaE5zMTZzOGYxUldR?=
 =?utf-8?B?RVJSbllXWU1zM0c0UlFPWG1hd3ZsOUVxT1p0UDR4YnMyRHhsQmQwZmZZMnV5?=
 =?utf-8?B?RjVWN2lMaE55S0ZuaHJGMEdJbldTbGJnbmdGNm0yMXR6ZTFRSWwzckYxVzVp?=
 =?utf-8?B?NlNsK1d0NlNxTjFCL0RLQnpEamtNdExmODMzeDRIZFNiU1VMUVZXZzBMUEhx?=
 =?utf-8?B?dVljZ1gyTlduN1U3K3Z4MkRuSzNRa2xZZU8rZFhQS0VkdEtoL0ExeGVxZVFU?=
 =?utf-8?B?VTZ3cWxxZUZ3SmprcUV0ZWlwSjZCM0ZOOStLQkdyYWhmcHRuNmZKTCtUdG5N?=
 =?utf-8?B?blNTSUg3UzlKYVNUcWduL0szTkpDajFyM1QvWnl2Y3NuRHZGejdDTkhWcUJQ?=
 =?utf-8?B?Tm9aK1l5OUhXZC9CeFhsUVRmZC9FbExZeWNGTHZVUzA1c3lsWnlTbUVTM0Z3?=
 =?utf-8?B?T3ZONnU4MTJ6d1FnV3Rod3lGVmFMMW5tcU5oVVJTU3NZakYxU0RDZThndVZG?=
 =?utf-8?B?Nkc1bzJUSDN1cFdzWDUxRVVzSEJ3UU9Ob0I5dERBM0Y2dDI3c09CTDk1Qmpl?=
 =?utf-8?B?VXB5ZmFKODBsNGtic3dJMUpiSDFuaGhBSGxoQlp3V1U5OWxTWWZYTFJWZFZV?=
 =?utf-8?B?MnVneGdPb3F2VXFSZGcxdGhhZTdraGx2Y0FrSnIvYjNGNW5JZ05LVUFVNjZj?=
 =?utf-8?B?KytHd1VlNGs2Y2E4ZlNacEMxeUZ1bU9ZMmdjVnpiNXJlSWtMOTR0T2t0M1Nl?=
 =?utf-8?B?RHUvRUQrakxGQ0J3VG1FVUdLSHBrWHNzS2RXUkZMV09US0tzdGdDb3dlQ3py?=
 =?utf-8?B?THZWNkdqSWVLUEhwcVVhM0VOQXR5MHljTGxhd2YvOFRxbGR3ajVSZm5XQWww?=
 =?utf-8?B?ZGRLMUNSSmZkeXJJVVB0STdabzZxL3Z6SVd4SkFNRXM5eFpKWjlJbGtFL044?=
 =?utf-8?B?LzhjbjdEOVRteExRQjlocW5qZVRYRzFwcFpQaEJGaDUza0Z1aG5JWjlXbmk0?=
 =?utf-8?Q?WhfScU7Qr+zQIpGMODBzl8W20?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ae06c5-40ca-4f66-6bef-08db2c4584fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 08:55:29.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mlvxt5YkTWYeHvyYeFtdTBL5E5Fo0bBKYYfmaXE76b7gTAqtFFPavjl3t8DUdSoh53FmP68o1rAiHHq72BVzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWFyY2ggMjIsIDIwMjMgMToxNSBQTQ0KPiANCj4gPg0KPiA+IFNvbWV0aGluZyBoYXMg
dG8gZ2VuZXJhdGUgQ01EX0FUQ19JTlYuDQo+ID4NCj4gPiBIb3cgZG8geW91IHBsYW4gdG8gZ2Vu
ZXJhdGUgdGhpcyBmcm9tIHRoZSBoeXBlcnZpc29yIGJhc2VkIG9uIEFTSUQNCj4gPiBpbnZhbGlk
YXRpb25zPw0KPiA+DQo+ID4gVGhlIGh5cGVydmlzb3IgZG9lc24ndCBrbm93IHdoYXQgQVNJRHMg
YXJlIGNvbm5lY3RlZCB0byB3aGF0IFNJRHMgdG8NCj4gPiBnZW5lcmF0ZSB0aGUgQVRDPw0KPiA+
DQo+ID4gSW50ZWwgaXMgZGlmZmVyZW50LCB0aGV5IGtub3cgd2hhdCBkZXZpY2VzIHRoZSB2RElE
IGlzIGNvbm5lY3RlZCB0bywNCj4gPiBzbyB3aGVuIHRoZXkgZ2V0IGEgdkRJRCBpbnZhbGlkYXRp
b24gdGhleSBjYW4gZWxhYm9yYXRlIGl0IGludG8gYSBBVEMNCj4gPiBpbnZhbGlkYXRpb24uIEFS
TSBkb2Vzbid0IGhhdmUgdGhhdCBpbmZvcm1hdGlvbi4NCj4gDQo+IEkgc2VlLiBQZXJoYXBzIHZT
TU1VIHN0aWxsIG5lZWRzIHRvIGZvcndhcmQgQ01EX0FUQ19JTlYuIEFuZCwNCg0KQWggdGhhdCdz
IHF1aXRlIGEgZGlmZmVyZW50IHN0b3J5LiDwn5iKDQo=
