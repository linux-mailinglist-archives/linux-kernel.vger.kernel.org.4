Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C66AB877
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCFIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCFIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:37:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C571DB8A;
        Mon,  6 Mar 2023 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678091829; x=1709627829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OlP4Q3/zyp6vSpmj/YI6RKMA8zRATv6h418LKoOQ+3s=;
  b=e8F/zG3rhIT5ZaBX+nT/w8BieFUzmrooz2/em4yAnVHLGXqNfRQrvlSn
   OAiQozsBlY8+7fbsMr2jhAeanopbsRp91WNXPNU7X+1J1tfqrpmLtl3Ue
   onz2uaKIOFaR1cWWLTrgTaaiqYiBT/0xogHd01SqL/ZqoFrNjeHaqjcuu
   1cvDayYF23w63jKY2MknldnavqHmjZx/Aqb6CEocwrzk9WAk0EraoItay
   zyWBaWJ53/M37RCTY8E34hmwvJveEuxJE9SnTeM2e4q9xXW6mSPMv1o50
   sV0F83Vn0B37OXEaTAM7dbMQjQ9lI8KT9rNUHMdbF+DfEm5QlKqPNQDXk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="323810595"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="323810595"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 00:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="626080278"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="626080278"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2023 00:37:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 00:37:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 00:37:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 00:37:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE1gOMhGkHL1OhtXnaXaLhQBOMzTd8UJ6xVM6db47WixiN971vR9gIv4x9lKBlxDI3A7zKjAVH350XObtHYWkAyng+iYqg26AnWeybb92vjpBYhzZSDvwp8QkYovwgOL0WASKZqud+yiVQEgdT/AlQS8L1aDq+sDkaR5cCPTkrPBakXZdtKryEgrPC5ySZUO39XPpRKIFHFlGTTWf7NoAx/bp+/HPUc3230wpqgRf6yZuzfvITEUC6Q5ib3+OO7OxvekI1hFmoe9bo0GHRbEf7FlaIRbuu0Aell+CEcN7C3eKDLiEgMovnFU4xDq4cWauaFJHSPWSuaQKV25HOKkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlP4Q3/zyp6vSpmj/YI6RKMA8zRATv6h418LKoOQ+3s=;
 b=U7tAOA25YJ/Wp52buEqFw/POiCUTHopXf4WcBhH65OWSOb4eGVRYIhmbtZyKlmtBDZPEgG2/+RfIMBZcu4UQQcwDZrBMum/F2506rPScfAqcnPP/TTJ8VH1iKc5LHmyTuhPSKIl+LwjfY2UlgV9OdDURl6hQWsD3TZ9uFrQYUpnUDorei0aaZr5vzE7t6UOMNJineNMJXLkWqhdPQC8SVGyAq4ZxpeStvPGQ94cWvSv/tv2afmgRnUEp1dyS5TRB4sk7PCvUMiWgmUCKhNkZEt3zltvDUr8ATlNiLE36vruI/W+LvVLwDt57Lc5C1dbfTPe0LTm+dSMxfwK8bI3Yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 08:37:06 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%8]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 08:37:06 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Topic: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Index: AQHZThiYp3MlrzfqvEWnd0vYLxlOHa7sEfeAgAA5DQCAASM78A==
Date:   Mon, 6 Mar 2023 08:37:06 +0000
Message-ID: <IA1PR11MB6171ECDDD6E8E6BCC27934EB89B69@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <ZAR/VdMNBwdrWA/5@pc636>
 <E5E8224E-B5C4-4796-8ACA-F2E26BEA1374@joelfernandes.org>
In-Reply-To: <E5E8224E-B5C4-4796-8ACA-F2E26BEA1374@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH8PR11MB6853:EE_
x-ms-office365-filtering-correlation-id: ce8706ea-b4f9-48d0-c88c-08db1e1df7c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8ijthVdhaYDR2RJvUtq3qSw8+1CWURw0VqvgNkHee33vDkQwOzZLTnonRgZPkztIrP3nFFZeP0u9UUw/qb4CKGyDPdfr6N/FwE1eNcXpFo6USFBpXd//Ldz0MAXyAJxstNvZMU9VTDaQ6MLZB6yjpLHgwyA+ZR9BvZBqzzD4jfN8aBYEc08U1bdsms0BHFmMOMGTpAjVMWbNg3zLZlrdQ/TYs5Ex5wbb3gIiH9Lpi2bWvgqjbXhcAJqSOEln1y6FoBhVGWoUT0A9NhlFj7c6YgbMYm79Y7cEHfQRNShR8rzq7J/mK0OmU+OE3/qrvBYERXGaKD4hVCzcm35cs/HmtipM6R6OvWi/K7zlxkOutKm5KqAYBBrvtn5iBuIEF4YoXZOyouEdb3pKDbxUosD5+K0Me8F3BrfMkhNQ6CJRMXvPrWmm1P/zmL4y+uE2x7YFW9ZzfcIAt8FOPlGjm68mldetT5TU7RzSB6w8Ig/vgl8ZlzGXidqdcr3kHqraBGmhn8BWneVpuHL+zSRQHmXBS0LAU8z+MBrtkA7DPgRnlW4jOhUHlyyBAAVsEKOEi55lg/2eXjXcwMrSbp9RdhpC1zFNP6WiVoiGSAaJ3Pkbo3YSTYgZQcuu3kWpMQ7qu9zjnCpuJgxIGpMtFysC62oYVizBOJP3QcEX9WwCqsJ8md9xTtl54IbJo9iigEuxqxXNCzsPJtj+MvIuUOitCX81Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199018)(52536014)(8936002)(5660300002)(66476007)(76116006)(8676002)(66446008)(66556008)(66946007)(64756008)(4326008)(4744005)(41300700001)(33656002)(316002)(55016003)(26005)(186003)(110136005)(71200400001)(7696005)(54906003)(86362001)(478600001)(82960400001)(38070700005)(9686003)(6506007)(122000001)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckNhYmR6WlRJRU5vM3FPcVVGTmxNWmM4bDZjVk5oa0gyY2tMdTh1VDdVWmFZ?=
 =?utf-8?B?bTdwajJFVk1zY2RsKzNVakNaUS9iam1NSDlsUWlqSmhHTDRGdkliaFJnaUdr?=
 =?utf-8?B?QmFOWlJIWitKbFdBWU1GVGFwQjVYZ0p6ZHdRWUJReXJkRmxJalNEK1hIbURh?=
 =?utf-8?B?dEhwYVJzL0NDM3VBK2Y3L2pyN05tSno4RDBRZDVURW8zMC9GUlRKelZHVExs?=
 =?utf-8?B?STNia0tpbXRWZ0dRb2xXU0xPVEpsRTZmclNrRkV4TTlJSkV0Mi9Vc1NxSE9Q?=
 =?utf-8?B?UVl3UVRGbHpoclNxbmIxelgrcWJVUUNBZERyaHlqMHZyS1JhaHNNc29aRW5l?=
 =?utf-8?B?OVRJTmxvVWdNZkJvYnhOQytNRjZoS0RsNjBXZ0thRG16SUh3RGE5ZjNTeFdi?=
 =?utf-8?B?L2ErU3J2VFNDaDY3V0xueFUxQWdPNlkwNDcxTUNCU3N4YTVHZDYyZWNEcXNy?=
 =?utf-8?B?WU4ybXVMMEQvcXpPSjZzVXR4YTRIM080ZEpoMEp6U0gxMVZHSmV6SXlEYjls?=
 =?utf-8?B?Sk01V2ZweGh6blFkYjV0YzVMc0VOdW41azFTNi8ySjR1R3NUQzVpdmNBYTUy?=
 =?utf-8?B?UHMvbnlFUUtWOWJ4bmhxR2NqRWptUVlxdDRIUlZaK2lZVHRsUTF5ZFZwWGVu?=
 =?utf-8?B?Mnp2OUxvd2JOS3VPU3l6MGN1SXVZSWFBMytBNjRmYnVMWEduSG5aM2hDWEgy?=
 =?utf-8?B?Sk9jM0wxSVJ0L0pkN0FRM2RaMXZka2xNQWRUTTVOOEQvM1dVblNWbW42UkV6?=
 =?utf-8?B?bXJzOHhpeHFnVjZIZE9rakRCU0RnTXcwQW5iUS9yZEkxUDFvKzVMWFNNeWo2?=
 =?utf-8?B?N0lhV0tsUzBLSDc1c3pTL2JzMitESXp3NGxkbG1rTmhWM1pHYms0WUdOanJy?=
 =?utf-8?B?M29FRXdNRFBibTNYdU1wMnNHMUllUm93RzhmVTlJVGlzNVI1SFRnU2RwOWFN?=
 =?utf-8?B?QTNxeERLV3N5dWNyZ2FtMjBXK2pjQllnUlhNM2VzNkx6MnBCYlRSYjRiTG9o?=
 =?utf-8?B?djhYSTF3WUNRWmVKSUNHVEZxaVlxRnFkMzY1a29wZmlZSnV3ZjlXRFRQaDBt?=
 =?utf-8?B?NjdYRHpkOFM0eFVsY0JuY3RpaFBOMTBmNzRoc1pXWmVUVVdyNGM2bkFST29W?=
 =?utf-8?B?cVdXL3hrS2sybG9wRDdNZ29JZzFPYlBnNXVMUzM5UXhiRFJvUnphaUdjck9H?=
 =?utf-8?B?RHp1S2pYOStodnhsdGpGV25TZ3JHQnkxSGNtYVN3Zk9aeWFIVjhacXJRakM5?=
 =?utf-8?B?UTY0NHVQamM1eC9tUmVaUWk1QlVJeE5mT3lsYzRnWGp5NzBiQmFHMlFoS0k4?=
 =?utf-8?B?VlVQazlUMGkwMEZUVUlHb3dTbkhibnZyZldmSFVmc0d3RkJaVkxQMzJkWkZn?=
 =?utf-8?B?VjJjTUY2cnZKYjBNNjR3SEpjMm50S0tQWkdQWjJHd2p3QU9sREJtQWRlenFt?=
 =?utf-8?B?UkRRc1UrK0k2eUd4blJ6TEpUNDgxK3B3YUFacjlIZTAvNXk1U2xtSklwQW9V?=
 =?utf-8?B?a2w2eXR2TEVUVHVNMlE4WEh1NitqYkRGM3NuL1IyYjRJeFcrNXY1Y3dGL0tp?=
 =?utf-8?B?THUyTDZad25JU292NlBNdEJndExzTHNUM0NVL1FWSnVRTFl0Y3Nhc3RzZlBP?=
 =?utf-8?B?bHBTWm96MnBjWUhwZFVzM1lCTXN4KytsYXFKVng3eSt0dXRLMFNla1U2MHRZ?=
 =?utf-8?B?NTA5cjZOS2xOYUJGU0IrZ0wxSmMzVUFGYi9pWmIxUEMzbUdlcDhrL0RheDRt?=
 =?utf-8?B?MHA1U2dWUG1QR2ZvdzBKY1NqTGxjR0VxTTVGY1lrQW1OWHprOXVvZ1RkVDJC?=
 =?utf-8?B?bCs2Z1JsSHB0bnQyclNGMHVxOEwvbFhNcVYvamlIM0pOOFF3V1QwU1VOekNZ?=
 =?utf-8?B?RHN4dzR5Qm5NKzFFSm9JVEFoZDA0bGhsdjRmdWRWZVNzSnFsMkptL2g1YTBD?=
 =?utf-8?B?ai95eFA5TXlmNXdOenk2bkNyYWQ4Y0s1clBLRE9qcnNvMHJsU1FlS0ZLdGhW?=
 =?utf-8?B?Yjg2M29yWmpRTGx6a2oxSEFadGFab2lZYk04YXpyV2Z3cC9vZVZXdkhORlRR?=
 =?utf-8?B?SDBYTG12ZkpKQ0g2TGVmQks4VmRtdndvNlJ4SFJnQVBLK2lpWVlDTFN4Qzky?=
 =?utf-8?Q?rtJCihw1r4DnU0qnOU2z0AJyc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8706ea-b4f9-48d0-c88c-08db1e1df7c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 08:37:06.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6gbvmab8dH8EGf214AbEgU1T6ZlrvVXm907a+YKjqADunN5W7G6adXolh9fA7ImzDNcxyNz/Pzjw/NYBfAOpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
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

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gWy4uLl0N
Cj4gPiAtLS0gYS9rZXJuZWwvcmN1L3VwZGF0ZS5jDQo+ID4gKysrIGIva2VybmVsL3JjdS91cGRh
dGUuYw0KPiA+IEBAIC0yODksNyArMjg5LDcgQEAgdm9pZCByY3VfZW5kX2lua2VybmVsX2Jvb3Qo
dm9pZCkNCj4gPg0KPiA+ICAgICAgICAgICAgICAgIGlmIChib290X21zIDwgcmN1X2Jvb3RfZW5k
X2RlbGF5KSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dv
cmsoJnJjdV9ib290X2VuZF93b3JrLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByY3VfYm9vdF9lbmRfZGVsYXkgLSBib290X21zKTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMocmN1X2Jvb3RfZW5kX2RlbGF5
IC0NCj4gPiArIGJvb3RfbXMpKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIG11dGV4X3Vu
bG9jaygmcmN1X2Jvb3RfZW5kX2xvY2spOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiA+ICAgICAgICAgICAgICAgIH0NCj4gPiB1cmV6a2lAcGM2Mzg6fi9kYXRhL3JhaWQw
L2NvZGluZy9saW51eC1yY3UuZ2l0JA0KPiA+IDxzbmlwPg0KPiA+DQo+ID4gSSB0aGluayB5b3Ug
bmVlZCB0byBhcHBseSBhYm92ZSBwYXRjaC4gSSBhbSBub3Qgc3VyZSBtYXliZSBQYXVsIGhhcw0K
PiA+IGFscmVhZHkgbWVudGlvbmVkIGFib3V0IGl0LiBCdXQganVzdCBpbiBjYXNlLg0KPiANCj4g
QWgsIHRoZSByZWFzb24gbXkgdGVzdGluZyBkaWQgbm90IGNhdGNoIGl0IGlzIGJlY2F1c2UgZm9y
IEhaPTEwMDAsIG1zZWNzIGFuZA0KPiBqaWZmaWVzIGFyZSB0aGUgc2FtZS4NCg0KICAgU28gd2Fz
IG15IHN5c3RlbSA6LSkNCiAgIA0KICAgICAgIENPTkZJR19IWl8xMDAwPXkNCiAgICAgICBDT05G
SUdfSFo9MTAwMA0KDQotUWl1eHUNCg0KPiBHcmVhdCBleWVzIGFuZCB0aGFuayB5b3UgVmxhZCwg
SeKAmWxsIG1ha2UgdGhlIGZpeCBhbmQgcmVwb3N0IGl0Lg0KPiANCj4gIC0gSm9lbA0KPiANCj4g
Pg0KPiA+IC0tDQo+ID4gVWxhZHppc2xhdSBSZXpraQ0K
