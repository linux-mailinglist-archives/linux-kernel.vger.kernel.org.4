Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA96BFEE2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 02:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCSBtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 21:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCSBtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 21:49:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF301A49F;
        Sat, 18 Mar 2023 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679190585; x=1710726585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0VvNBJ1AjOHTg/B/2F7mjmM0+5mrosyNSRUUhR7Zu6w=;
  b=QUt6oSnzfNuFyu7jQ3FXhG6tPPVQorfp1Lq8UiRRfPW5RjTOJ+/VQZxb
   gEjxZnATHju/MAXNVCZCHRBMPN3QoW+HOTzM/s1WiB7DXpFOxkzphvOXo
   Su9+0N539yhTSLzrrlngMYmsYVvayIs5XxPPeAwmn8i8h59GVnR3jAlWk
   dLBs/nsMR+OdM90sm4iHrsaJyr6xktyZV2SMh4HNekYEaFHw0JqWEk10w
   iiB28pQKHQdb+llcw8/ffvJsO7Jc2lIiJ7hxxG8Ce8kP2Wv/8UZqdakEg
   cnZgaU+IUEqsIVvQvJrbe5HBwB+G6D8w89hf3Nykw7EZbaIpcyvSIAe0Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="366183218"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="366183218"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 18:49:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749685475"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749685475"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2023 18:49:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 18:49:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 18 Mar 2023 18:49:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 18 Mar 2023 18:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPnJ718CBzR/6DpfqYR7ER7x0tjNrNrQ4zrF73W0KWKMHPQ5DgbXmLk2DDHkpmHyA4DbkfYmNrtwB9CS6iqI7/nbnS8GQ/nRkfGIHs4Se66c04QP35MeB2skeERr9FxFxq8Dd6cNmo8k0uI6IC88k7LgAOTv3vIcgV3vy2c2Wm1tbVsYaTEGs39y2A3Q0RbXp9e87GlOTewz//q6dj4Qjifh+rY6mLLpn1rInY6Adox+8lCCn6JnbbcoOQNhL9MMGYOTYcgFpykf/bnSG6r6YWT+xTj2gXpW9uTUy57eT2mKqpVmNg0my76BZ89ar2+K21lci2uoI7cF/ANH2DpCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VvNBJ1AjOHTg/B/2F7mjmM0+5mrosyNSRUUhR7Zu6w=;
 b=gHtHW7ev+Sk+G38kj2HsfGPSHcB3i0jnHlObQKcD6UT9vGTI0VGAY2lTxheztD2OdGnNg/YRBVGDZ+Ee8pP2LkG4Qla3hAFefB8x52DC9DFXAtwrs+rZGJsgWAVWPosVQLYRIZYWJB4MfUWMDh5MIya+xvsRr50xXoFrdjB/AsU3FDZ8eckwv9C+c1b5rdeH734XbD9JB+aV5shALSIuMxoEdbvOOCmkOexZtQeaeCewVX7kNgfUcFsMo/NBoRdrbPpaQeMOvd+NvWlRfu6xLJEUQf21WtNNqTcIio/UT3J1sA2WVm/Vpu76lIFvmq9sAR1FRr7K65ghDjWoEjmvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL1PR11MB5333.namprd11.prod.outlook.com (2603:10b6:208:309::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 01:49:41 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%4]) with mapi id 15.20.6178.036; Sun, 19 Mar 2023
 01:49:40 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH] rcu: Fix incorrect trace string in rcu_boost_kthread()
Thread-Topic: [PATCH] rcu: Fix incorrect trace string in rcu_boost_kthread()
Thread-Index: AQHZWZxelxWKlvyHXEi/VJq/8bUqDa8BUbwAgAAD4AA=
Date:   Sun, 19 Mar 2023 01:49:40 +0000
Message-ID: <PH0PR11MB588073647EBD66AE77F15E3DDA839@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230318132435.3671003-1-qiang1.zhang@intel.com>
 <CAEXW_YQ2xGuy4ebPjyVAp4SJQUo=Wr8uAw9BnUsjgvozzhuUeg@mail.gmail.com>
In-Reply-To: <CAEXW_YQ2xGuy4ebPjyVAp4SJQUo=Wr8uAw9BnUsjgvozzhuUeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL1PR11MB5333:EE_
x-ms-office365-filtering-correlation-id: 8c182ba1-e13b-4f69-a278-08db281c3474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sI2+bcPns+oh5btJh4fWaXhxLu+L73VXZ0izl/RHzqw4Nqdixyv09FUGjZhaDuww29RYmsG5ouSvkVgHaRA082inLLX+K1qLQ4tZM36RYYAsDJFDeiVxQfaGFCu3/aQ7GmC6pdet1FHx4iNKSBGmef9H4+YEENScFS4PTFQ3/tRmZxb+JEgMTKhGPKSkEW6no6K44fh7PaA1o0w2l2q7XC7C8qtB2WGwJkejhYgpSjt2QjxxK/n7JHIDSNuvYd3S9Qb0Ueo2RmYV2I0anblFmEhCdH5FxM8VV8GyuIjDHFbm709YoedusyE+OLKlsmTaN+T7Ey/zwF6gjLngQymljokuU30G44MSuFh9nFSJZEEngZmDBsm85ACpiECRLz4V71mEjAvmusyzUMho9f9Gjy/at/d9NivbmFANUSEeP0y6r3xwRDvqdP2ik8rwJt828EK0AZC0E0Bpw68ZohZ3GSUQJFwOSgEfmnHSckkMI1csKZPeVOHmsotdwONpToLpJZu6w6ki1vEWCnE/vZqgQkQVc4KC2VmDU5nj5BdPdM0+f3P5g2CVXyAllck7/otLqDzI+7y8/r8nJak2xJAHRG3Zxlbz0w+yroHA74i0atRleBDQJ+m9xORvVla2pFEYLsGHHifph930aoMcLJzwkIql7FohSpAiCA+OIhE+cPt1k7MAzyuZ41ux9yA9+AbdADSostXwzI2e1JjH9fNfhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(8936002)(5660300002)(52536014)(41300700001)(55016003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(82960400001)(2906002)(4326008)(83380400001)(478600001)(71200400001)(7696005)(186003)(26005)(6506007)(9686003)(54906003)(316002)(8676002)(66446008)(76116006)(66946007)(64756008)(66476007)(6916009)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rnh2MjBrazdha2E5L2E4cHpNSE1sTTBDYVY1VmNQTTR4WXFDRmVsQTlENEt6?=
 =?utf-8?B?NHIrREFXSlJGakJvczJpQjhSc0s0S09FYmViL0V5MVJsdlRMM3VVaU9IMm1n?=
 =?utf-8?B?YlNUQWc0THNCaVFXZ1dQVEdXa0NDWWtYR0FkSUNYOW9sQWt2QzhjRklIbVNk?=
 =?utf-8?B?S0l1bFhvTmVvdGlXUk5qYXV3RnZUbWgyTnkwd21HRGZaNU8vOSt2d1NmeVRq?=
 =?utf-8?B?bW8rMFdoZjJlS09tbEE4WnlZMnBUWVV4UWEreXNTVTlnWjBLUnZiOE5rZXZx?=
 =?utf-8?B?QUE2cTYrWHZCRkJZeW1LMGxpRkxBZXAyWHRXdk1YeUYvSWlPSGVCdWRHOG91?=
 =?utf-8?B?dnhXTXJxM1c5NkVHM1NNd2JXQmZNLzl0QTF6REQ2c2tlUXZNZ3NSd01UR1k3?=
 =?utf-8?B?WTJycStHUGpNSlRyV3JaR0V6cWxpV09DYkM4Nm9pK0dUZUZNZU1rbXBvVW51?=
 =?utf-8?B?Y3JVd29saVZGaXQ3TGFRQ2wvTTdMbWpTL0xlcmt0UjVIb3JoSWZVZkp2Ukl5?=
 =?utf-8?B?NjZ5bDgyS2lDUVNaOWtvcnA5d05ZbkYrRHlMdUYreTRFSit3d1YzSHUzRlhT?=
 =?utf-8?B?NG1OT1h3MTFMSEd3UmRRTW5Yc004bFB0QzhKZ3hlbFF0TW8wNm5iRFhtZUxw?=
 =?utf-8?B?R01CckJzR25nUGV6L3A4NEVIbjZjaVpTVDFKUDNSUkdJWVlCVUZabXgybVFM?=
 =?utf-8?B?QzkzQ3lLVURIei9xbUpxRGVpUEdiVjFkRmhScXRBMSsrenlnQXFzTDZTYjlr?=
 =?utf-8?B?MVNyL3U2YUluVDRTMzFwN2pSNlMwVEZsdG9PeXhGR0VWTWtJMUo0V1AxdUFT?=
 =?utf-8?B?VUlHS3RnN0swQmFOL28rS1dzTFVyR2R1SHEyVUpEQkp5ZlptQklYRmFDbHlP?=
 =?utf-8?B?SmIraGRwYi8wMUdFenowMmxtcXJ3ekswVHJTSjVveUpPMHpZRjRhcmJOV3JV?=
 =?utf-8?B?UHRBN2l0a1NuY1RJaERqYWhpR3laQlplc3F0Yk90TUdxeHY2YUFpemR6WU0z?=
 =?utf-8?B?d0VkY0IrVXkyemxSM2JPNzJKNFRXS0hZYzFINkdaZmk1Ni9jTGsvSVB6cDVT?=
 =?utf-8?B?QUZwcThEU3RWaEFnSDFvY2dGN21hZGM5Q0Y1RG8ycGplN2NsTGpNMExnOVds?=
 =?utf-8?B?RGxCcDN4Yk1yNStveHRWTzV6Y2pVMlNWZ3VJOElmVkczRmV2UE1TTEJ4VktC?=
 =?utf-8?B?U21NNEM2Ni9FVURiYU95TDd2cngwU1ZOSkFQN1BTdCs2em1yaGQ2YUx0S05T?=
 =?utf-8?B?aDBOQk9aMUxKMjJKN1dXOWRucW9wTG16RVJ1UkwvemluN3pJQVlrMzNabTlQ?=
 =?utf-8?B?VXk0cGpDWWh6ZXZUdWZELzd3OXE5WnFCNUtBQlpHL1A3NkRycHNudEhQZXN3?=
 =?utf-8?B?S2E1aVZRcEJCK25Vb0xuaEFSRVozUnVXaVRtNzFaWUJzUmgwMzVwVGV5WW51?=
 =?utf-8?B?VVpYeUdVSSsyTVNYaXhxY1d3dlNCN3lzalVzNFVhNzFHSWZWQlAvekMrdk5q?=
 =?utf-8?B?eWw1UnVmT3RnSG1WQU5jVHkxRVJNeUpBMjNwVkxGUjMxRE0wbFUzVmZqejJX?=
 =?utf-8?B?WGJXZ1ZJa0R4T2o5WGNOREUxWUpMTG4rWXFUL0NocGZhQWYzdTI4YVJORG9H?=
 =?utf-8?B?WE9pTlgrMG9RbjkzM1V3YTdBSmEyckw3QmpQWnZIM2RJcmpMOGNWNEpZeThQ?=
 =?utf-8?B?TDV1OFlDUUVtdlNBY3lDTG9PZ29tTVd2cEpHMDRIU01GZEtxR1NiaTVFNm5E?=
 =?utf-8?B?a0lCdjE2VktyRmhWb1VIRytpZEtkU1daZzdLZXBWRnA2N1plSENvUk5jOEJC?=
 =?utf-8?B?Nk5zRmJmbnQ5US9DYkhFVC95UEQ3aG1xNDJ0elFrYmtGd3YwcUJWeXFpSHJk?=
 =?utf-8?B?NG5GNWNCNjM4NTc4eC9TS3JSRlFJaG9SZmlaSEd0TU4vOC9ZUWd1d3gvVDBh?=
 =?utf-8?B?Ym1jVFpmNlQ0VEtndS94NjVkM3hKUkFaQ3hmTkZSS1JaemQ0RVF5eHFMT1V5?=
 =?utf-8?B?VjBScmJGYkYvUEVkb0UrbjAwSnVZM1E2a2RWek5OZjEvUjJNSW45dGFjOXA0?=
 =?utf-8?B?QXVVaXRXVFhBMUFKbjl2bVppVjJnSE1oRFkxOVJoQ2IzVllMMWNtdkw0T1ZO?=
 =?utf-8?Q?7Z9amGzZEOdnMHi+Zgx/hKEBR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c182ba1-e13b-4f69-a278-08db281c3474
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2023 01:49:40.6998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpnlpcrOIuUma9i0KxqtCBPgG4bHhkWDPptkLOJHBw6FDMd8uROIuglEemTBJfk+a+Rgu420a5TzREjIEAc8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5333
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

DQo+DQo+IEN1cnJlbnRseSwgdGhlIHRyYWNlIHN0cmluZyBpbmZvcm1hdGlvbiBiZWZvcmUgYW5k
IGFmdGVyIHJjdV93YWl0KCkNCj4gYW5kIHNjaGVkdWxlX3RpbWVvdXRfaWRsZSgpIGFyZSByZXZl
cnNlZCwgdGhpcyBjb21taXQgdGhlcmVmb3JlDQo+IHN3aXRjaGVzIHRoZXNlIHN0cmluZ3MgaW4g
b3JkZXIgdG8gY29ycmVjdGx5IHRyYWNlLg0KPg0KPkkgc3VnZ2VzdCBwcm92aWRlIG1vcmUgZGV0
YWlscyBvZiBob3cgdGhpcyBhZmZlY3RzIHlvdXIgdHJhY2luZy4gT25lDQo+Y29tbWl0IHRvIGRy
YXcgaW5zcGlyYXRpb24gZnJvbSBjb3VsZCBiZToNCj4NCj5mN2Y3YmFjOWNiMWMgKCJyY3U6IEhh
dmUgdGhlIFJDVSB0cmFjZXBvaW50cyB1c2UgdGhlIHRyYWNlcG9pbnRfc3RyaW5nDQo+aW5mcmFz
dHJ1Y3R1cmUiKQ0KPg0KPldoaWNoIGFsc28gbW9kaWZpZXMgdGhlIHNhbWUgY29kZS4NCj4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiAtLS0N
Cj4gIGtlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCB8IDggKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmggYi9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmgNCj4gaW5k
ZXggN2IwZmU3NDFhMDg4Li43YjYyMmI1MTk2YTggMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3Uv
dHJlZV9wbHVnaW4uaA0KPiArKysgYi9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmgNCj4gQEAgLTEx
MTQsMTAgKzExMTQsMTAgQEAgc3RhdGljIGludCByY3VfYm9vc3Rfa3RocmVhZCh2b2lkICphcmcp
DQo+ICAgICAgICAgdHJhY2VfcmN1X3V0aWxpemF0aW9uKFRQUygiU3RhcnQgYm9vc3Qga3RocmVh
ZEBpbml0IikpOw0KPiAgICAgICAgIGZvciAoOzspIHsNCj4gICAgICAgICAgICAgICAgIFdSSVRF
X09OQ0Uocm5wLT5ib29zdF9rdGhyZWFkX3N0YXR1cywgUkNVX0tUSFJFQURfV0FJVElORyk7DQo+
IC0gICAgICAgICAgICAgICB0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJFbmQgYm9vc3Qga3Ro
cmVhZEByY3Vfd2FpdCIpKTsNCj4gKyAgICAgICAgICAgICAgIHRyYWNlX3JjdV91dGlsaXphdGlv
bihUUFMoIlN0YXJ0IGJvb3N0IGt0aHJlYWRAcmN1X3dhaXQiKSk7DQoNCkRvZXNuJ3QgdGhhdCBs
b29rIHdlaXJkIGJlY2F1c2Ugbm93IHlvdSB3aWxsIGhhdmUgMiAiU3RhcnQgYm9vc3QNCmt0aHJl
YWRAIiBtZXNzYWdlcyBpbiBzdWNjZXNzaW9uIChvbmUgb2YgdGhlbSBjb21pbmcgYmVmb3JlIHRo
ZSBmb3INCmxvb3ApID8NCg0KPiAgICAgICAgICAgICAgICAgcmN1X3dhaXQoUkVBRF9PTkNFKHJu
cC0+Ym9vc3RfdGFza3MpIHx8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBSRUFEX09OQ0Uo
cm5wLT5leHBfdGFza3MpKTsNCj4gLSAgICAgICAgICAgICAgIHRyYWNlX3JjdV91dGlsaXphdGlv
bihUUFMoIlN0YXJ0IGJvb3N0IGt0aHJlYWRAcmN1X3dhaXQiKSk7DQo+ICsgICAgICAgICAgICAg
ICB0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJFbmQgYm9vc3Qga3RocmVhZEByY3Vfd2FpdCIp
KTsNCj4gICAgICAgICAgICAgICAgIFdSSVRFX09OQ0Uocm5wLT5ib29zdF9rdGhyZWFkX3N0YXR1
cywgUkNVX0tUSFJFQURfUlVOTklORyk7DQo+ICAgICAgICAgICAgICAgICBtb3JlMmJvb3N0ID0g
cmN1X2Jvb3N0KHJucCk7DQo+DQo+QWxzbywgaXQgaXMgd2VpcmQgaGVyZSB0aGF0IHlvdSBhcmUg
Y2FsbGluZyByY3VfYm9vc3QoKSByaWdodCBhZnRlcg0KPnByaW50aW5nICJFbmQgYm9vc3Qga3Ro
cmVhZCIuDQo+DQoNCkhpIEpvZWwNCg0KU2hvdWxkbid0IHRoYXQgYmUgdGhlIG5vcm1hbCBsb2dp
Yz8gT3IgSSBtaXN1bmRlcnN0b29kPw0KDQp0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJTdGFy
dCBib29zdCBrdGhyZWFkQHJjdV93YWl0IikpOyAvL3N0YXJ0IHdhaXQNCnJjdV93YWl0KCk7DQp0
cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJFbmQgYm9vc3Qga3RocmVhZEByY3Vfd2FpdCIpKTsg
Ly8gZW5kIHdhaXQNCg0KVGhhbmtzDQpacWlhbmcNCg0KDQo+dGhhbmtzLA0KPg0KPi0gSm9lbA0K
Pg0KPg0KPg0KPiAgICAgICAgICAgICAgICAgaWYgKG1vcmUyYm9vc3QpDQo+IEBAIC0xMTI2LDkg
KzExMjYsOSBAQCBzdGF0aWMgaW50IHJjdV9ib29zdF9rdGhyZWFkKHZvaWQgKmFyZykNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgc3BpbmNudCA9IDA7DQo+ICAgICAgICAgICAgICAgICBpZiAo
c3BpbmNudCA+IDEwKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIFdSSVRFX09OQ0Uocm5w
LT5ib29zdF9rdGhyZWFkX3N0YXR1cywgUkNVX0tUSFJFQURfWUlFTERJTkcpOw0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICB0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJFbmQgYm9vc3Qga3Ro
cmVhZEByY3VfeWllbGQiKSk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNjaGVkdWxlX3Rp
bWVvdXRfaWRsZSgyKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdHJhY2VfcmN1X3V0aWxp
emF0aW9uKFRQUygiU3RhcnQgYm9vc3Qga3RocmVhZEByY3VfeWllbGQiKSk7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHNjaGVkdWxlX3RpbWVvdXRfaWRsZSgyKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgdHJhY2VfcmN1X3V0aWxpemF0aW9uKFRQUygiRW5kIGJvb3N0IGt0aHJlYWRA
cmN1X3lpZWxkIikpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzcGluY250ID0gMDsNCj4g
ICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICB9DQo+IC0tDQo+IDIuMjUuMQ0KPg0K
