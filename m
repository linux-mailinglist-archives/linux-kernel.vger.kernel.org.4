Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3BF69C496
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBTDvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTDvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:51:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB80C15E;
        Sun, 19 Feb 2023 19:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676865059; x=1708401059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GVBl4vQtKb4Joq9iJ3gPPhLYnocSDd0OwimzQAfFxSg=;
  b=dFtbyUHUGT9zIOBjWVsj5zZ1YOtRXM1MyNRiOXKcYt6q2fi1S0zf5K+t
   EKh58wpWdr/3KulyjMeMPRG1PLlR/9TY2b7/PfewOnjogHwIV9Vo8Vi09
   df7/TLCVUjaq7pJu4kmRHJGcVBHUiSv6EZ0YsKR4yqQCwGl0W5bobshTd
   3CXeizT5LP517EXfQ5x3ncrfbzQvRKmiFx0AkiTdYXdmMcwPiRVJS2EQs
   sT+M2PYBSnGn4b5EtAlIBmvGk3XaQKv+2tkEXvxg5vpI+vVlTBY/pOKmE
   JJAFaTD+QEvTU2IDg7sAWhf0LByqvD4Dvh78RrnEE4QkYedBeb6qHzdor
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="333676876"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="333676876"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 19:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="739909724"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="739909724"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2023 19:50:58 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 19:50:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 19 Feb 2023 19:50:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 19 Feb 2023 19:50:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP2jy7WZKeWF68NkchJBFvtH/jnzK6b+Dx8XxOQ3qrZpisXMwEgDnbHTwNu6w+yhxNX1oKaitv9AH3Ue4WSotkhizdpnPyQnLs2IuntS6JWNat/El+vXGDjGsG8aispvVgoqY2RIoNAYNBxmcx8PetDYu2NlQhMdGMAlzumnZDRxMh+NpxGLcpj104X/vf+yvkbZlifHE2bUp3u90XN8dg2l6cooPWf/n04Cx/pGbmhMSEI4jutG5nvIa/YtgeDrk/FVV+rMwkQCiIQTvgonQZwQJpXX83brTqdEMqYbvTR611BDA3bU4+RfpxvmzDNEZVh3XtaEL3KZxuz3XCUkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVBl4vQtKb4Joq9iJ3gPPhLYnocSDd0OwimzQAfFxSg=;
 b=FgugnjvDAw0xwUq99HnkydlHjF+EVcJas9m3zXXTQKfdpG/bJ1TBKW+EYWl06vxhaD1y9PKE/7zLKYisQJV0cybGPHviUY8tR8aUVvsnqJWSnCbOQEBBJ6O08BQPKfQ13DZaLpkfREJRTc/Gr1WUMC4h4i709pSqaJyHVyh5jL06JPurLgYL6yJjDR6oz1woCah6eWpSEVPolGnZPibIg1S6z70itzUWxnV94jwke8UKTXghAAeU8LqYIIESiv8bnD2X0CJl6oTib7XVr8bjsFkh4TII1iPrGXq4paNLShweu8w1Uo9BDUoVilfNYoDHGl94rDc0edRiHtyVCmmFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 03:50:55 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 03:50:55 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Topic: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Index: AQHZP1Hum/btr+ww/kiynrKipZgIc67OndeAgAEcQoCAAAvHAIAC4+MggABa/gCABDg8QA==
Date:   Mon, 20 Feb 2023 03:50:55 +0000
Message-ID: <DM6PR11MB4316A36ACA077501B92C1D0E8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
 <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
In-Reply-To: <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|MW3PR11MB4745:EE_
x-ms-office365-filtering-correlation-id: abe12748-5408-4a9d-a0bb-08db12f5ab29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qI89kGGQyPf12+5BaG+WmN4u951mIaG3EQknsRZk95hjatVePb+UYWfGirC/ApMEG82x7VFcVduu8BWbXz4zujLkTNTRAxH2kmMkJ8tf7+Lz81vv8uHYMsxhKSSQwYWz11cKz1NsIMKX2mDJzEHeELx+73dnYRCaEnlxojRW+bktJaj8X91XGT5Ubj8xxOY0ubJwkJyPyQuS1AI/2x+gNHFIoHjIlEGqGm2yaAoMoK9OVniMCxrkZ0M7Jdk2xH6ZKpRooTQjBKULXsCjT01TsX+PRFWzsk5ulTyyGwZJWR+N1jDFNvolCFf4oL3b1DkyusYguJSMvgqCDSk7CbVvyMddQPYVNs0WK7JDoC1bY1XP8+Sn3R+A94LYPwK7mQYFEAlcx3VFSrIs/iWdIwXn/h2fG/TpMHXFkNc2joYZq15U8Dpq37drlNn648ZMBLiNT4wkBZL/EQjTX0nLk4JbglusF0tvQB/Kb9t5qWjD1Wd+ZDtaX6w7xK0tsyc1+L/zbAjXiXGzvCqZkXNgtyHSiT78tJK1ctDxRY6FnCuTAUEJEXPNIMUxm+RzJBh0GjDEGWyylOtuq67R5gaw6deemi570oqmYxUaoCHPCfko089kaqSxHS6Go6k2m/vumJIikU0riQpasLZYfSywws35eH0qvxznzknNwC1m+TrqwDXMgyhAHYtD8RnYS5VlVy8/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(316002)(76116006)(66556008)(54906003)(52536014)(66476007)(83380400001)(66446008)(64756008)(66946007)(8936002)(8676002)(4326008)(41300700001)(6916009)(6506007)(53546011)(66574015)(26005)(186003)(9686003)(71200400001)(7696005)(478600001)(966005)(38070700005)(55016003)(33656002)(86362001)(2906002)(5660300002)(82960400001)(38100700002)(122000001)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlNTNHFlUzBFUFUwbGNJczE3MUord3hwN29XZkJEZ3ZYL2NjZDAwemFSNmp6?=
 =?utf-8?B?S0xwNEY0S3RjRmpxRnFtaGJMRzl6SzkzYVk3WVBaZ1hmcGlxQmFZZWxsd09E?=
 =?utf-8?B?UjRLUkhYbk1LbDljK2Zsb2ZMcURBVThjdkpwR0JrSWViS3hGeWpHVkZmVE5m?=
 =?utf-8?B?dmIvRmxaMFQyNGVKQUJJYUZ6L1gyamsxRnF0OFVtb3dmK2RLNlFOdWYrTnFJ?=
 =?utf-8?B?RFJsZm83blpqc1FDdVF0S0N1c2M5R3Rmd25XdjQvVzJHYXB3NHpoY3RlNEFo?=
 =?utf-8?B?VzhBWGdXYU5rVUEwNnBrd0FHbFJWQlNjNVdzWmRUdnl1TXNycHJlV2JOWER0?=
 =?utf-8?B?WlJMMGFJR0VFSzNoWHlSSWo3YUhMSlRzVGQ3bmNIa0thVy9qbEpOTDdvVW5Z?=
 =?utf-8?B?OVAyRUEzK1lkUUZWZitDdS9JaHZFOFdGQkRnRVdXYU1hOXpoVjgzc3JGWWpy?=
 =?utf-8?B?bDRpYjlEazUwZkhWLzhpUjNUSGhGNzRYREF5b0I4YTRTYitUZEVZWlhvcDBx?=
 =?utf-8?B?S0V1amhXZHk3TUVFaGdIOGhNLzZ6akJYckRHa0c1UCtzYk9VMHhQUHZqTmYv?=
 =?utf-8?B?SjBRbzFWbmI0MzU3R3phL1F3NU1GRk40N0FaUFR5WThxd2U1OXFoMGkrR1lu?=
 =?utf-8?B?TDJyWS9aUWpEUEovY3htK2FhTmVNS2JYa1VxaUhSLzV6ZmMvTUFyRnY2emlv?=
 =?utf-8?B?RXB0blNaTHc5QTNHNjdNUlJEUERNOWkzM3d1Y3NzMExRNDcwY0lWZjBVV1Vs?=
 =?utf-8?B?eDdCTzdtZEF0RVhLeHYzdzVrOXdwL2xOcUxRS05EOHFERGFBQitBRCtZTWg1?=
 =?utf-8?B?aWc4MnIvQ01saERiclVlZ0VkSzF4RU51TEhPbk1NWldWeFIrOXhrbkQwc2FX?=
 =?utf-8?B?a0xMM1AxVE9YdyttbFc3dmRRZDV5czJSQzU5RFRUWVBiOWpETHhnZ29ydS9M?=
 =?utf-8?B?d1llUkJsMjFqaEo2NmpDM3pGQk5Zd3RINitOY3NEN29hbW1xV3o1Z2hSbWo0?=
 =?utf-8?B?czRZc3hHOEJ6S1h5TkNtM2lwRnh5UE1oWEFWWFhZOHJKN0ViZGJMZjRVNlBS?=
 =?utf-8?B?Tk9md1FBZUhmWlRsRkgraDhjUmZLUjV5cFptaTFVYnl0bk4rMEd0UEZkYnFD?=
 =?utf-8?B?UWFoTHhNeHpMRmtjM1p2SXRVb20vM3dqTFAxWHpBekF4OTg3aHYrQm9CUjJj?=
 =?utf-8?B?eDloVnBwakFrejB3TkRSYitjaHVkMzVvNkp1c1FvWVdITkRwSzVyaUxVTDc0?=
 =?utf-8?B?UlgyTnNPRmNqOVBrd2VMVE0rQTQrY3JHZHUrK3dTT1g4aW5QUU1PQUw0SXpM?=
 =?utf-8?B?NllTQTk0MEtPNmFPb0dNYmlOekpINlUxKzFZa2lJUzlwdUxEUUNNWDBHRmJO?=
 =?utf-8?B?dE41bnl6SzlkT1Fvb0J0OEltOUNVbGNBMzdUb1psZ1RsWTEvNXZidGpJMnBo?=
 =?utf-8?B?K241OGVoZ3pzT0ZBU2pQQXhKSnoxWlhRWndEV3czRzViMkpUZFJKUkJMSzBu?=
 =?utf-8?B?cFJ4bGlBL2MrZ1IyUXhkbjJMNktFUW9ZdC9laEl1bTdXTjc2UWVCOFZyeTZs?=
 =?utf-8?B?WjEvK1Rna0pqU3JReGgrMjBsSW0zTkhIUjlVRmRCdmRaUkNjdW5PTDBnRDZ4?=
 =?utf-8?B?RVMwc1N3cHgrYktrWUpacXR5cHZ3bmdHNGZzK0lleGk2RHRCbzg1TVBkVlNu?=
 =?utf-8?B?aWltOTFTOTJJL1g4S1pNYmkxZmJSbGdmOFdPWEx0TkwrSnp1OFd3cno4QzM5?=
 =?utf-8?B?WlNLQ2FVMkE4RENsNGU2WE5vZ1FSMXZkc2VkeXl1RTlHNmxGL0UrdUxPYzQz?=
 =?utf-8?B?UjlzWWp4RmZHRlVyMXFDdlZReWFaTEgyMzBpWTlhOWZVWXpIUDY2VGJCWURC?=
 =?utf-8?B?UXhhaGZUS1Fwb3lmM0tpVFJKdUVpTE9kTXAwbHovdXUxVk9IMTFpdzlxeGxN?=
 =?utf-8?B?NVlrVnpZcFE3VUl5aGlsVGFFc1JNYmkrd0lsUktGWS9BY09lY3lURVQvVUZS?=
 =?utf-8?B?REQxd0gzZ0Y1dnVoU1p1b3BaV3VaSm83VmVHTHkyVStSdDdEWVFuVkF0aEIz?=
 =?utf-8?B?TDZnTi9BNmFvZXh1dEIwbFk3WDQ1SEhEUnNDTVFYZEVIN2lFRDA5ZTFiMjdi?=
 =?utf-8?Q?UMPcPSrgE5oaFQr+Z5O7LSm7j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe12748-5408-4a9d-a0bb-08db12f5ab29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 03:50:55.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxML9fK7ArD1lGqqXA9R1ZuSzsTNSU0yOXRCVu3+XpQr5fcD8O92JS/mtxpJSRZEUS8Swg0MQieGIKxSnfn96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBQaW5jaGFy
dCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDE3LCAyMDIzIDc6MTkgUE0NCj4gDQo+IEhpIFdlbnRvbmcsDQo+IA0KPiBPbiBGcmks
IEZlYiAxNywgMjAyMyBhdCAwNjoxMDoyMkFNICswMDAwLCBXdSwgV2VudG9uZyB3cm90ZToNCj4g
PiBPbiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE1LCAyMDIzIDU6NDYgUE0sIExhdXJlbnQg
UGluY2hhcnQgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEZlYiAxNSwgMjAyMyBhdCAxMDowMzoyOUFN
ICswMTAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPiA+ID4gPiBPbiAyLzE0LzIzIDE3OjA2LCBT
YWthcmkgQWlsdXMgd3JvdGU6DQo+ID4gPiA+ID4gT24gTW9uLCBGZWIgMTMsIDIwMjMgYXQgMTA6
MjM6NDdBTSArMDgwMCwgV2VudG9uZyBXdSB3cm90ZToNCj4gPiA+ID4gPj4gSVZTQyBkaXJlY3Rs
eSBjb25uZWN0cyB0byBjYW1lcmEgc2Vuc29yIG9uIHNvdXJjZSBzaWRlLCBhbmQgb24NCj4gPiA+
ID4gPj4gb3V0cHV0IHNpZGUgaXQgbm90IG9ubHkgY29ubmVjdHMgSVNIIHZpYSBJMkMsIGJ1dCBh
bHNvIGV4cG9zZXMNCj4gPiA+ID4gPj4gTUlQSQ0KPiA+ID4gPiA+PiBDU0ktMiBpbnRlcmZhY2Ug
dG8gb3V0cHV0IGNhbWVyYSBzZW5zb3IgZGF0YS4gSVZTQyBjYW4gdXNlIHRoZQ0KPiA+ID4gPiA+
PiBjYW1lcmEgc2Vuc29yIGRhdGEgdG8gZG8gQUkgYWxnb3JpdGhtLCBhbmQgc2VuZCB0aGUgcmVz
dWx0cyB0byBJU0guDQo+ID4gPiA+ID4+IE9uIHRoZSBvdGhlciBlbmQsIElWU0MgY2FuIHNoYXJl
IGNhbWVyYSBzZW5zb3IgdG8gaG9zdCBieQ0KPiA+ID4gPiA+PiByb3V0aW5nIHRoZSByYXcgY2Ft
ZXJhIHNlbnNvciBkYXRhIHRvIHRoZSBleHBvc2VkIE1JUEkgQ1NJLTINCj4gPiA+ID4gPj4gaW50
ZXJmYWNlLiBCdXQgdGhleSBjYW4gbm90IHdvcmsgYXQgdGhlIHNhbWUgdGltZSwgc28gc29mdHdh
cmUNCj4gPiA+ID4gPj4gQVBJcyBhcmUgZGVmaW5lZCB0byBzeW5jIHRoZSBvd25lcnNoaXAuDQo+
ID4gPiA+ID4+DQo+ID4gPiA+ID4+IFRoaXMgY29tbWl0IGRlZmluZXMgdGhlIGludGVyZmFjZXMg
YmV0d2VlbiBJVlNDIGFuZCBjYW1lcmENCj4gPiA+ID4gPj4gc2Vuc29yIGRyaXZlciBpbiBpbmNs
dWRlL2xpbnV4L2l2c2MuaC4gVGhlIGNhbWVyYSBkcml2ZXINCj4gPiA+ID4gPj4gY29udHJvbHMg
b3duZXJzaGlwIG9mIHRoZSBDU0ktMiBsaW5rIGFuZCBzZW5zb3Igd2l0aCB0aGUNCj4gPiA+ID4g
Pj4gYWNxdWlyZS9yZWxlYXNlIEFQSXMuIFdoZW4gYWNxdWlyaW5nIGNhbWVyYSwgbGFuZSBudW1i
ZXIgYW5kDQo+ID4gPiA+ID4+IGxpbmsgZnJlcSBhcmUgYWxzbyByZXF1aXJlZCBieSBJVlNDIGZy
YW1lIHJvdXRlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBtb3JlIEkgbGVhcm4gYWJvdXQg
dGhpcyBzeXN0ZW0sIHRoZSBtb3JlIEknbSBpbmNsaW5lZCB0bw0KPiA+ID4gPiA+IHRoaW5rIHRo
aXMgZnVuY3Rpb25hbGl0eSBzaG91bGQgYmUgZXhwb3NlZCBhcyBhIFY0TDIgc3ViLWRldmljZS4N
Cj4gPiA+ID4gPiBJVlNDIGRvZXNuJ3QgcmVhbGx5IGRvIGFueXRoaW5nIHRvIHRoZSBkYXRhIChh
cyBsb25nIGFzIGl0DQo+ID4gPiA+ID4gZGlyZWN0cyBpdCB0b3dhcmRzIHRoZSBDU0ktMiByZWNl
aXZlciBpbiB0aGUgU29DKSwgYnV0IGl0IGlzDQo+ID4gPiA+ID4gZGVmaW5pdGVseSBwYXJ0IG9m
IHRoZSBpbWFnZSBwaXBlbGluZS4NCj4gPiA+ID4NCj4gPiA+ID4gWWVzIEkgaGFwcGVuZWQgdG8g
ZGlzY3VzcyB0aGlzIGV4YWN0IHNhbWUgdGhpbmcgd2l0aCBMYXVyZW50IGF0DQo+ID4gPiA+IEZP
U0RFTSBhbmQgd2UgYWxzbyBjYW1lIHRvIHRoZSBjb25jbHVzaW9uIHRoYXQgdGhlIElWU0MgY2hp
cA0KPiA+ID4gPiBzaG91bGQgYmUgbW9kZWxlZCBhcyBhIFY0TDIgc3ViLWRldmljZS4NCj4gPiA+
DQo+ID4gPiBBZ3JlZWQuDQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmV2aWV3IGFu
ZCBjb25jbHVzaW9uLCBJJ20gZnJlc2ggdG8gbWVkaWENCj4gPiBzdWItc3lzdGVtLCBpcyB0aGVy
ZSBhbnkgY29udmVudGlvbiB0aGF0IEkgc2hvdWxkIGZvbGxvdyB0byB1cHN0cmVhbQ0KPiA+IHRo
aXMga2luZCBvZiB2NGwyIHN1Yi1kZXZpY2UgZHJpdmVyIHNvIHRoYXQgbm90IHRvbyBtdWNoIGJh
Y2sgYW5kDQo+ID4gZm9ydGg/DQo+IA0KPiBUaGlzIGlzIGEgdGVudGF0aXZlIHByb3Bvc2FsLCBh
cyBJJ20gbm90IHZlcnkgZmFtaWxpYXIgd2l0aCB0aGUgaGFyZHdhcmUNCj4gYXJjaGl0ZWN0dXJl
Og0KPiANCj4gLSBUaGUgc3ViZGV2IHNob3VsZCBoYXZlIHR3byBwYWRzLCBhIHNpbmsgcGFkIGNv
bm5lY3RlZCB0byB0aGUgY2FtZXJhDQo+ICAgc2Vuc29yLCBhbmQgYSBzb3VyY2UgcGFkIGNvbm5l
Y3RlZCB0byB0aGUgQ1NJLTIgcmVjZWl2ZXIgaW4gdGhlIElQVS4NCj4gDQo+IC0gQXMgZm9yIGFu
eSBuZXcgZHJpdmVyLCB0aGUgc3ViZGV2IGRyaXZlciBzaG91bGQgdXNlIHRoZSBhY3RpdmUgc3Rh
dGUNCj4gICBtYW5hZ2VkIGJ5IHRoZSB2NGwyLXN1YmRldiBjb3JlLiBUaGlzIHJlcXVpcmVzIGNh
bGxpbmcNCj4gICB2NGwyX3N1YmRldl9pbml0X2ZpbmFsaXplKCkgYXQgcHJvYmUgdGltZS4gU2Vl
DQo+ICAgaHR0cHM6Ly9naXQubGludXh0di5vcmcvbWVkaWFfdHJlZS5naXQvY29tbWl0Lz9pZD1h
MjUxNGI5YTYzNGEgZm9yIGFuDQo+ICAgZXhhbXBsZSBvZiBhIHN1YmRldiBkcml2ZXIgY29udmVy
dGVkIHRvIHRoaXMgbWVjaGFuaXNtLg0KPiANCj4gLSBBcyB3ZSdyZSB0YWxraW5nIGFib3V0IENT
SS0yLCB0aGUgc3ViZGV2IGRyaXZlciBzaG91bGQgdXNlIHRoZSBzdHJlYW1zDQo+ICAgQVBJIHRo
YXQgd2FzIHJlY2VudGx5IG1lcmdlZCwgYW5kIGluIHBhcnRpY3VsYXIgc3VwcG9ydCB0aGUNCj4g
ICAuZ2V0X2ZyYW1lX2Rlc2MoKSwgLnNldF9yb3V0aW5nKCksIC5lbmFibGVfc3RyZWFtcygpIGFu
ZA0KPiAgIC5kaXNhYmxlX3N0cmVhbXMoKSBvcGVyYXRpb25zLg0KPiANCj4gLSBJIGRvbid0IHNl
ZSBhIG5lZWQgdG8gc3VwcG9ydCBWNEwyIGNvbnRyb2xzIGluIHRoZSBzdWJkZXYgZHJpdmVyLCBi
dXQNCj4gICBJIG1heSBiZSBtaXNzaW5nIHNvbWV0aGluZy4NCj4gDQo+IC0gVGhlIGRyaXZlciBz
aG91bGQgYmUgdmFsaWRhdGVkIHdpdGggdjRsMi1jb21wbGlhbmNlLCBwYXJ0IG9mDQo+ICAgdjRs
LXV0aWxzLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsLCBidXQgSSBoYXZlIG9uZSBtb3Jl
IHF1ZXN0aW9uLCBkdXJpbmcgcHJvYmUgb2Ygc2Vuc29yKHY0bDItc3VkZXYpIGRyaXZlciwgaXQg
d2lsbCBjb25maWd1cmUgY2FtZXJhIHNlbnNvciBjb25uZWN0ZWQgdG8gSVZTQyB2aWEgSTJDLCBi
dXQgYmVmb3JlIHRoYXQgaXQgc2hvdWxkIGFjcXVpcmUgY2FtZXJhIHNlbnNvcidzIG93bmVyc2hp
cCBmcm9tIElWU0MsIGhvdyB2NGwyIGZyYW1ld29yayBndWFyYW50ZWUgdGhpcz8NCg0KVGhhbmtz
LA0KV2VudG9uZw0KDQo+ID4gPiA+ID4gSSBzdXBwb3NlIHRoZSBpbnRlbmRlZCB1c2UgY2FzZXMg
YXNzdW1lIGEgc2luZ2xlIGluc3RhbmNlIG9mDQo+ID4gPiA+ID4gSVZTQyAoYXMgd2VsbCBhcyBN
RUkpIGJ1dCB0aGVyZSBjYW4sIGFuZCBvZnRlbiBhcmUsIGJlIG11bHRpcGxlDQo+ID4gPiA+ID4g
Y2FtZXJhIHNlbnNvcnMgaW4gdGhlIHN5c3RlbS4gVGhlIGRlY2lzaW9uIHdoZXRoZXIgdG8gcmVx
dWVzdA0KPiA+ID4gPiA+IHBhc3MtdGhyb3VnaCBmcm9tIElWQ1MgY2FuJ3QgYmUgZG9uZSBpbiB0
aGUgY2FtZXJhIHNlbnNvcg0KPiA+ID4gPiA+IGRyaXZlciwgYW5kIHNob3VsZCBub3QgYmUgdmlz
aWJsZSB0byB0aGUgY2FtZXJhIHNlbnNvciBkcml2ZXIuDQo+ID4gPiA+ID4gRXhwb3NpbmcgSVZT
QyBhcyBhIFY0TDIgc3ViLWRldmljZSBtYWtlcyB0aGlzIHRyaXZpYWwgdG8NCj4gPiA+ID4gPiBh
ZGRyZXNzLCBhcyB0aGUgSVZTQyBkcml2ZXIncyBWNEwyIHN1Yi1kZXZpY2UgdmlkZW8gc19zdHJl
YW0oKSBvcGVyYXRpb24NCj4gZ2V0cyBjYWxsZWQgYmVmb3JlIHN0cmVhbWluZyBpcyBzdGFydGVk
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGluZm9ybWF0aW9uIHdoZXRoZXIgSVZTQyBpcyBm
b3VuZCBiZXR3ZWVuIHRoZSBjYW1lcmEgc2Vuc29yDQo+ID4gPiA+ID4gYW5kIHRoZSBob3N0J3Mg
Q1NJLTIgcmVjZWl2ZXIgKElQVSBpbiB0aGlzIGNhc2UpIHNob3VsZCBjb21lDQo+ID4gPiA+ID4g
ZnJvbSBzeXN0ZW0gZmlybXdhcmUgYW5kIGFjY2Vzc2VkIG1vc3QgcHJvYmFibHkgYnkgd2hhdCBp
cw0KPiA+ID4gPiA+IGNhbGxlZCBjaW8yLWJyaWRnZSBhdCB0aGUgbW9tZW50Lg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gVGhlIHByaXZhY3kgc3RhdHVzIGNhbiBiZSBhIFY0TDIgY29udHJvbC4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEFsc28gY2MgSGFucy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+PiBT
aWduZWQtb2ZmLWJ5OiBXZW50b25nIFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4gPiA+ID4g
Pj4gLS0tDQo+ID4gPiA+ID4+ICBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL01ha2VmaWxl
IHwgIDEgKw0KPiA+ID4gPiA+PiAgZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9pdnNjLmMg
ICB8IDg0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+PiAgaW5jbHVk
ZS9saW51eC9pdnNjLmggICAgICAgICAgICAgICAgICB8IDU1ICsrKysrKysrKysrKysrKysrKw0K
PiA+ID4gPiA+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxNDAgaW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+ID4gPiA+ID4+IGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvaXZzYy5j
DQo+IA0KPiBbc25pcF0NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IA0KPiBMYXVyZW50IFBpbmNo
YXJ0DQo=
