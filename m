Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638146BD0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCPNSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCPNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:18:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D880C97CD;
        Thu, 16 Mar 2023 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678972648; x=1710508648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=of0d28FFgh9Xl3ElqQ66LN17pyuEdYTvhM0MuipawD0=;
  b=mCIXoOw+blIYHyQAHhGWSPA3ljEIzAiYJQ10bLY0bqxAO2reHCqlARZf
   sSUvQB2oqsdcDm+31MV/K7uKX3gAcCWLK+q5tx0R1kdZjaI+9hyaAIoVV
   0ODm9AFUUppq45Z2a0T+IHTZtPnOKOkVbCvrKTgazB7dcGaeDtix/XBKp
   U2JnkrT15njl/IdEIMgkL2fbFV4qrn3L3k+IavVgTe/wKK//y5ZIww3Iz
   XcKWztiwVeviM32P+fQxyaxAR4YdSJLPIIJsQKs6bEJV3X2Er/grPFtcJ
   YxYDO1TxKGPYD8viFoDX2MnwGbOdzntZKnSpUo/eJDzVRYv0YT+jeW8AZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="318376590"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="318376590"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 06:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="679890781"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="679890781"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2023 06:17:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 06:17:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 06:17:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 06:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP8t9K7RgF1o6NHGWfXEyblCrcqQU3QYz/LHrALUPhjH2HQw52EPvoaU1Nv2kT0lW46JBO4xk5ENlj01vuMNKgtnBVsb1xz3YQ317E3tU9rrgQJMDhQTWf8d8BZAOBAOOxW1Hn3AaEZgLZIlZn8LQcfyufyU9SdJ4Al9WkcfHhHS3nvVtVgS+af9MfR1X7toboWVa9dsmoSOyQshMTjqbLetHPERC1g1+0EMnQona4I7kKssFF9IJs/8/AOluFlX4lZ5gMdlwIhdttJ1qWj4ytD2/Qj+Ig9vROKexqAOPef5izYdCOaohhCHUfKPSbxPqENv+PvceTvIrvS2pnEE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of0d28FFgh9Xl3ElqQ66LN17pyuEdYTvhM0MuipawD0=;
 b=M6knRCst2X0RMJdmKeSdDf0YZZ+P3ODqyMh90iyLjIp1E5aHEGELFeIbPIfh/i4WnR0toEKAbm577UoJj3bS0SIKwAFOJD+cfJmCOzShC5uIByfPeEsD+w844qbEP0FUNOslR5PiysS3Df895wzYm1uC/I8UVYVAakyjqayn2P/YdSm7TRRpozaWL1vlx7GyOvPJK4LYo3pszthzTYkcSfQqhvnF0j5bod2sJAvfU6hmNZaqW8fFJDyY82IyDz/9kuyXvXciZPTNwcNz4FtP03Xo+j8lB+ZRPP0XAmAXWyogtm+PqnravdLB8RlgqfR+lV9DPVLbKD/iPN7SGngxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 13:17:11 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 13:17:10 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after
 unloading rcuscale
Thread-Topic: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Index: AQHZVYJ6y9lPL1nBiUy5prGqw8pyma765zaAgADmYLCAABeigIAALuYAgAFQWLA=
Date:   Thu, 16 Mar 2023 13:17:10 +0000
Message-ID: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230313080403.89290-1-qiuxu.zhuo@intel.com>
 <d930f2a8-4b75-4109-a303-e2fc04443693@paulmck-laptop>
 <IA1PR11MB6171EA9F4437346FECB73F3189BF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <CAEXW_YRatZhejsW-o1PXK3V8QxOcc-krvRdjwaDudFSfUotAKw@mail.gmail.com>
 <87b5fd9c-b34e-4105-8bbb-7902f17356cf@paulmck-laptop>
In-Reply-To: <87b5fd9c-b34e-4105-8bbb-7902f17356cf@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH0PR11MB4805:EE_
x-ms-office365-filtering-correlation-id: 80cbcf90-413f-423c-b55f-08db2620c00f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGWp8y86uMc1aI8uSNGy908GOJmvgtv9yZgshKFxzaKb6SeEOKJi0yM/o6IeE+qVOPxmFMer51itEtLCv921D2cbkh3NaMzMB7UxMf6ZyHV2RS/O4LRD4hre7LhKduTgayviTZJ88h9/V0VawXzvFpo49rpVB+U73sEKa/QSyDlgB77/6cflx8rSFQ988gQsjm5VhI4gucTTf9VRKqz80VuPIUlgCA57dtnaCQO5Uik5jlNEMTY4v0rTYeBXIQHgL88hgZ8Y5lBjOYeOT1VbOmgk523A1FafDmm9SNi1+9w0cUMJi7RpnvrpsdC2CsBquc5lsjAW7JOfQZMo88e+d4oWn2+4R7MceDepCLV6KtTgtJNEbt6j8IuxHFrlriwfwD12F0El8GWTuWTGPxYh0q2Wx9iy48vZFGf1ufMnMQNc1LKAT1dLiOlLPhDEgXWKspXBK9+qlcT5Mi7/aBP2Apqq0OuOJ6WlDiw6JBAOW/z/jPEzxxqnLtW+BM1zp/ZK1ndTmZoshdUPLlH1qL18AbsKpJsLPeTXNsZPuwlcq/7DhkUkavIEcP6wD8Vw1gsMGJVebfezDcT5176hTzwqcsDB0zLkUNCCKOwCnnILwXvQz3oJh7OblmTWdvPdE7h2a63loPr0ZU+a2HzX2IV0s/OR85vzdE1LmsXJDW2LqJyCHov9MTSBMlWAREJ82naoe3jO7YssYX9/DMmLhkOUyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199018)(33656002)(52536014)(41300700001)(5660300002)(7416002)(8936002)(2906002)(38100700002)(86362001)(38070700005)(82960400001)(122000001)(7696005)(71200400001)(76116006)(64756008)(66556008)(66446008)(66476007)(8676002)(66946007)(478600001)(110136005)(4326008)(55016003)(316002)(54906003)(83380400001)(186003)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG5vV1RuS1gyakp3bklpcFg4dGNDQzRtdklLNU85bVRFSmpvVGNsVjdaMHdW?=
 =?utf-8?B?Ni9xcC9vZHcrSTJzSkhwYzlodXBXQXhEL21tWW1GWCt4M2J3NmdGMzBrUjR1?=
 =?utf-8?B?cFoxSENxYzZPS3g3ZjFJaDdTaFJmWGRnRnVyREdCRFVVNFlDMW5EUnpKYVJm?=
 =?utf-8?B?MUNmSWlrUDF5d3ZJaERhVDlIazZoUmdkdkp5L2NYWVZ4RmQ3cjVvaTM4eGtZ?=
 =?utf-8?B?czYreDU3aEdKcGpLSW45b0w5M2NiSThiWkg2NE84R2kraXBwTTZ0ZjA4ZUVU?=
 =?utf-8?B?YzJEblBvbklLZjk3c3hHdzhKZGF1dCtVdmRsRFVSN3BrRjE2ZHRMZ1lRaGU5?=
 =?utf-8?B?NkFIbWppaWZYaXdub3V6dWRqRHllY2hFQmtqN0V5NHU4YXhMYllkSVpoSzJM?=
 =?utf-8?B?UTZTVitqT0pkZlN5K1VpalR2MUVUcnNNcTdsdjIyMGNyS0tkZHBPb2dGQUVT?=
 =?utf-8?B?a3RlRjNmdWF1QWI1REwwSXltb3hPRGY0bkF6Y00wQXNpY2FRektCU0hMSnhF?=
 =?utf-8?B?YTJwQXBURWVnWmhJMkQ1VHpOekJtUG9iVGFvTy9qNHVkM3h6ZGhBMkU5dFpQ?=
 =?utf-8?B?MnFVSE43dzVtY2ViRVZ6cjFBbmxrNmVrMldzWk5rSjVkYk5uQWNpdi9jUEZm?=
 =?utf-8?B?c011S25sYitBY1haaGhad3hyQXgwc1VSdlFwTGlreFRqYUZIYi9QNW9RVFZr?=
 =?utf-8?B?V2xDSFVzanVFYXErL1F3akI3RlZQZ3BBdWFzSzd2dW9Qdy9iekVlZFI0N2tN?=
 =?utf-8?B?T0FnaGFyeEhXVkQxSGpkeFpHU1djVVJRK3p1U2JGRGs1dGJ6Ykg5U0IzRFIx?=
 =?utf-8?B?M3crNnZKbGpnU2JkakZOUlBDb1BKNFBPR1VSVUsxYmQraVJpdzh5TnlzZ2pR?=
 =?utf-8?B?YXo4T1NKU0hXVEw4aVR0NW1DeHhzcUU2Y0dRQVZoU0ZSd2JHcHA0c1ZhMkdi?=
 =?utf-8?B?RWQzcXFkN1ExNjFVNStBUkF1V1JUdUdQQ0wwWnlnYk1QcEZ6b09WYTYxWTQx?=
 =?utf-8?B?bkJ3cHNLc1BuY0JuQTl1c3M3NTh6SjdGWmxCZVVzQitqQ1F3S0c0cnZJenJ3?=
 =?utf-8?B?S2JmM0FNSFJZb0hvbDJIT1hNZU5YUlcvN1JsSTBiSjZtTC9TYW1TTHhxZkhZ?=
 =?utf-8?B?WnUrakVKYVZZVnk4M0IxODZ2NEV5V0Z6VXRGcmVzYVVBWHQ0d0srTnUwRUZ2?=
 =?utf-8?B?WHZIYkVtdzJaRTJaQjhJSHNNMzdLVWdlMTR4ait4ZmpvTTJPQ1dBdVcwR2Iv?=
 =?utf-8?B?WEFUTXkyUTgyamZYQkNPN2ZmdlB2VlVnanIxcDJVYjdiSE1uaDhjUG1lZE5E?=
 =?utf-8?B?akZ3OXNVZ2FVNkYxcURxWkdGY2hZZVIwSkRMN21YMXVMTG1UVXhhM3g5eS9J?=
 =?utf-8?B?Tmg0c1Z6L1NrVkxVQVB5SDdUa3crK00wQjFvZERsSDJxNWVHVkpRb3VsYzJr?=
 =?utf-8?B?VEFUNmxlTElnVnorMlduTnUvY0ljbitkODZyTWtFOEI2aGRIMndyOVpBUFlv?=
 =?utf-8?B?TGZiV3g4WGs4OFlPR2VvNHJRekoySDhCNnJobE5iVWVXUDBDaDVKYjFJclk1?=
 =?utf-8?B?NjRnaTRsYXZPbm0xalRXb2JTVy9mZFVZRjdwSFZud3Y4NjllWmZnSmNIOGJl?=
 =?utf-8?B?OUQrVnBvcDl4Z2Y3cDIrZTlwR2dncEtvdVZmYXdqSlBlOGtrMVpZZktoRUI4?=
 =?utf-8?B?dENBQi9BZjNDaWJoa3ZTUWcvNVhaU3FvemRtMDlJSUp0RHJZQUE5bjdBZjI0?=
 =?utf-8?B?dEFBNzdsdTc0U3ZUOEVzWTVHUDhhZjVGdkd2WXIyL0d1Sjg3M1ZEd1p2L1pk?=
 =?utf-8?B?K0lKc2hRNXhVK3ZWUnFvQ2FlMWtSZ1RoMzd2NFB0ckxxZVpMNURpYURZSGJo?=
 =?utf-8?B?VUswS1lNbUxJbjk5S214L1hXSVJSRUFsWU84THVhRGgyY2JOVGpyMnh6dlZQ?=
 =?utf-8?B?bXhoUUdRdHBnUjFzNDZJd1c4aTNXT29LNC9COG5adDBmdlhpdTJkZEE1bUdz?=
 =?utf-8?B?U0RkQ1N0S0t6N1V6ZlljdDQ3SnMzYXZ1UzJJVmdFeDhicFM1Zm14QytJc0JG?=
 =?utf-8?B?MWtQQ00zYTJLVUg3YlZYMVB6bGRwOFFwZlcwRFpZZ2RmZkc1VUhRMEFITFlW?=
 =?utf-8?Q?DCvr68vwvvGyf3psHEK3jPORd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cbcf90-413f-423c-b55f-08db2620c00f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 13:17:10.5964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oj2Lg5SD3WC9d+7o5QQ+APdWfFocoM3VRY+tkc70VTwKa4JFciJECwwkXOtNNxtlv3cuobyc5KH2dxM/ANQL1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IFsuLi5dDQo+
ID4gPg0KPiA+ID4gSG93IGFib3V0IHRvIHB1bGwgdGhlIHJjdV9zY2FsZV9jbGVhbnVwKCkgZnVu
Y3Rpb24gYWZ0ZXINCj4ga2ZyZWVfc2NhbGVfY2xlYW51cCgpLg0KPiA+ID4gVGhpcyBncm91cHMg
a2ZyZWVfKiBmdW5jdGlvbnMgYW5kIGdyb3VwcyByY3Vfc2NhbGVfKiBmdW5jdGlvbnMuDQo+ID4g
PiBUaGVuIHRoZSBjb2RlIHdvdWxkIGxvb2sgY2xlYW5lci4NCj4gPiA+IFNvLCBkbyB5b3UgdGhp
bmsgdGhlIGNoYW5nZXMgYmVsb3cgYXJlIGJldHRlcj8NCj4gPg0KPiA+IElNSE8sIEkgZG9uJ3Qg
dGhpbmsgZG9pbmcgc3VjaCBhIGNvZGUgbW92ZSBpcyBiZXR0ZXIuIEp1c3QgYWRkIGEgbmV3DQo+
ID4gaGVhZGVyIGZpbGUgYW5kIGRlY2xhcmUgdGhlIGZ1bmN0aW9uIHRoZXJlLiBCdXQgc2VlIHdo
YXQgUGF1bCBzYXlzDQo+ID4gZmlyc3QuDQo+IA0KPiBUaGlzIHNpdHVhdGlvbiBpcyBsaWtlbHkg
dG8gYmUgYW4gZWFybHkgaGludCB0aGF0IHRoZSBrdmZyZWVfcmN1KCkgdGVzdGluZyBzaG91bGQN
Cj4gYmUgc3BsaXQgb3V0IGZyb20ga2VybmVsL3JjdS9yY3VzY2FsZS5jLg0KDQpBbm90aGVyIGlz
IHRoYXQgaXQncyBhIGJpdCBleHBlbnNpdmUgdG8gY3JlYXRlIGEgbmV3IGhlYWRlciBmaWxlIGp1
c3QgZm9yIA0KZWxpbWluYXRpbmcgYSBmdW5jdGlvbiBkZWNsYXJhdGlvbi4gOy0pDQoNClNvLCBp
ZiBubyBvYmplY3Rpb25zLCBJJ2QgbGlrZSB0byBzZW5kIG91dCB0aGUgdjIgcGF0Y2ggd2l0aCB0
aGUgdXBkYXRlcyBiZWxvdzoNCg0KICAgLSBNb3ZlIHJjdV9zY2FsZV9jbGVhbnVwKCkgYWZ0ZXIg
a2ZyZWVfc2NhbGVfY2xlYW51cCgpIHRvIGVsaW1pbmF0ZSB0aGUNCiAgICAgZGVjbGFyYXRpb24g
b2Yga2ZyZWVfc2NhbGVfY2xlYW51cCgpLiBUaG91Z2ggdGhpcyBtYWtlcyB0aGUgcGF0Y2ggYmln
Z2VyLCANCiAgICAgZ2V0IHRoZSBmaWxlIHJjdXNjYWxlLmMgbXVjaCBjbGVhbmVyLg0KDQogICAt
IFJlbW92ZSB0aGUgdW5uZWNlc3Nhcnkgc3RlcCAibW9kcHJvYmUgdG9ydHVyZSIgZnJvbSB0aGUg
Y29tbWl0IG1lc3NhZ2UuDQoNCiAgIC0gQWRkIHRoZSBkZXNjcmlwdGlvbiBmb3Igd2h5IG1vdmUg
cmN1X3NjYWxlX2NsZWFudXAoKSBhZnRlcg0KICAgICBrZnJlZV9zY2FsZV9jbGVhbnVwKCkgdG8g
dGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpUaGFua3MhDQotUWl1eHUNCg0KPiBbLi4uXQ0K
