Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374936A64DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCABeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCABeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:34:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372AA10253;
        Tue, 28 Feb 2023 17:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677634457; x=1709170457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D55nCYrx5/yPQlFD487777Wzpf7OR1m0GQXVeMlS36g=;
  b=X+vQPOA1idxeTWURJ2umFCSup7dL2rN04NmyB2IhF+w1KO9E6ZGeOvA9
   KLHCbqJhLGcXSRQgGhDgITP9ciX8WVAEkZMMe5ykvzYSLZLKyTugUjplY
   sg8AlDob/Du0oY6entTVPTyF5W1DGOEftmOeR0iIvblvSg9EsL0YLT+gW
   FIdnW9SWb1JcCdgUY4wvOmrOR+NgiVIESJaZMJAMqHc56rpXZEBLLmKGE
   6BsNy1vEa1EvJ2pxhLpaMSiSII7guq0/JJdpDnD/UpnorOYR4X9ZRX67x
   blDcGEK16jPi7/fE2P/+dxCafiQJeqxRkg47YLlT11byHa9TilOobRoi7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="331775312"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="331775312"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 17:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738428804"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="738428804"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2023 17:34:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 17:34:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 17:34:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 17:34:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQqvjQsvaJEBuLqQXfF1i5izppBnV68SnE21n3W2RpzP+iQGymK1uDdcBqobBAP4yigCApGqcfiaGky63ZZvYut1dJj+DM3I0GezVnBoi7fhSD4bk3spqPJ0Xbxxqt9fxc95a4fjrOn+TFrbfPi0XLKuHHpg0iY+gi5IOsLcuunmhg9aiI61B6izAI9fAxdptmNxQAQ+Y+bzdsnytRlvvHdZHQriADjdng+UaNQkk3H7O0IL1IUNQKI7B7cJwfm5vm0up4/FvgFROqzodEkorbsht3zpjAyeu10vcTNyHnQCwZPiaMDzWlqNtDHm15kdRUWqBQC5lHtRHB3nIPX+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D55nCYrx5/yPQlFD487777Wzpf7OR1m0GQXVeMlS36g=;
 b=ebVLedWiKYiceBbMzF4wY05INopIq7fWgRzShC2nON5Z520KB+apZM1CgDkcaPcQ9WR9MMwaJNelVXcDebCCUpJMMV9se4Z/52CRoHNati8Q34syj61IHCVVTXjMfi3VWIdAt4d3/c8pLQhLr+FuQL3MPyG74Zx5l8vqeGdRf+AHSyxoDP0wYrn3TcoCQuLC8e6/S/Y2mabt2On7x8yLtRd9u6FVKLOQyXE8YGJ4MU0KOwnuRGAIXEAztifUCD84W4uiYx4VtGSgW8hdfn6dUAb7W8P7SFhk4bxHdGe+UAdIbenWes7D095dCSr50VbJq7ulSdSrY4OvDqY28LcsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 01:34:12 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%8]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 01:34:11 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Thread-Topic: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Thread-Index: AQHZSMoUan4Z/tmfYUGikm7Xfdsdaq7iacDQgABhpQCAASAOAIAAhGqAgAC4ZhA=
Date:   Wed, 1 Mar 2023 01:34:11 +0000
Message-ID: <IA1PR11MB61714E80960104FB04E3167989AD9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org>
 <IA1PR11MB617118DAE8D72E2419558D6689AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <CAEXW_YQwu4ccqWLTfFSwcJQOH6fbhe4SiHHa4XPUCvefiBZi9g@mail.gmail.com>
In-Reply-To: <CAEXW_YQwu4ccqWLTfFSwcJQOH6fbhe4SiHHa4XPUCvefiBZi9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|CH3PR11MB7371:EE_
x-ms-office365-filtering-correlation-id: ff1b24a1-8461-4f88-d323-08db19f50f64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+sgiNsEfDwA20PxuSJq4CBeRwFBvg9Fneff/e2UPepTtXieMmhZugxpYc4C6UjjkkLsrcjXRwBAqZ9SYQcRrj6adTciItCUerp/gY48kYYJEPmdABldEvdWS3zRkjA+YMY0Tz0/2b7xo+mj+QwEX+YouE7ZhoWnEwcZO+D5+F/krpGzzwXUBQQBLgWh9+KHdw1/lFtj7y/OuUwDM+w+rVkGweybWBT7+pMXKihYDMQORy76EyBw8yLKbPV6Lc8TEvZHjOl/XeK8IY0OITMNlJBX/IUPQg/KbH3HfqdGYItxiOCjRqtEnJGqy5KPg6oHdujJ6Yj/riFUiIMidRDOY0guph7BWjiX1YyMpVGzyy7wKCh65R4t4goqPJlAk5cvM6xbJSfxWGTVNCBuKMl9gqo/kwbUswgY1xrEXel2vrUpOSbrHQuA1phishPtp9TwQc7+7iIqLCDQgcz222MkO925ibbDjPbeb0xGX0U6vQIXNey2dXSCHzXu8JI33tE+f59Bws5d2SVzD7VuM6UE/uQLkusq66ALyTcrwH/Ny56/C8rUf1u5/fErrxQyy154Qmgir7ubV0OJnqVw8cbiZUEkQchB41eUnO1qWNKKxh7OtjmezR1uq9KBbWIF59fwUeAw8Rlq+sBps/4R/nM+zHIIWh6OBsjfm3ob3kPY1ClrqHFw0ibH6DH3wnuv1+W1Fzk2CZNeu6qd5bWiu8c4YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(8936002)(52536014)(5660300002)(66476007)(71200400001)(2906002)(6916009)(4326008)(8676002)(64756008)(66946007)(76116006)(66446008)(66556008)(316002)(54906003)(478600001)(7696005)(41300700001)(186003)(6506007)(26005)(53546011)(9686003)(122000001)(38100700002)(33656002)(86362001)(83380400001)(38070700005)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGdvZkpsSnRqNWY2UWU2NXU0QmNCOGZ6T3NCN3dHVHZ1Rmx3Z3VDZjFQMnJQ?=
 =?utf-8?B?OGpacUgrbFVHb3hDMHp4NjA5MDV4QTdQSVVlUGJsbDNwT2ZCY2x1Q1BIa2Fz?=
 =?utf-8?B?RkZldlFaUHRKM2Jna0lIRTgvTFhjM3c3M29zamVuM0t6OW1KNWhyUURzc3ZU?=
 =?utf-8?B?alJydThtM0dKMWxDRDdmZEJxTE5ZMHlSMEpjQlRXZVQrMStFempzQ29uMGVG?=
 =?utf-8?B?YVNMOGRPMEFxQVVqNlRFQ21VbDA5VW91RFBTdXpiNXpYSWFLYUh4VVZYemZG?=
 =?utf-8?B?enhxZ2F0MGhxZEtYZGRabjZjMDd4NW9jZ3BrWVAwQkNxNmwwMGpyTjFPWWJL?=
 =?utf-8?B?aUllRkxVM1VIZFhKM0hlbE1RSDBoL0R5dTdPbk9rcjBER3NQa2tWL05idW9E?=
 =?utf-8?B?SjJVQlExbDVUeXE4ZVZKd3IrMUlWQjhXZ3hmR1ZReEFtTFhhNkZyRlhuRE14?=
 =?utf-8?B?UEVEblgxbDN0M3Awc1lkNEtXbE9mUEhaTEJ4MFpxekFHb0hBN3FmRE55MWFI?=
 =?utf-8?B?RUdubjA0RUdYMDdNcVJTNCszdFhqYThzRlV6S1RSSHE4eUJuUkNkT0pJTGdj?=
 =?utf-8?B?QUhRa2Zma20rNXEzZ25DUVRTVm03SHdzVEV2NzByUC82VXpidFpuZEc3QUFh?=
 =?utf-8?B?Um9YR255aUxFcTIvVWlHdWVsMXNoV24xbThoMTVUY2hQcTZzZmEwYmJpMGFs?=
 =?utf-8?B?UjlrQ0I3KzBidWx5a3RFRGRFYW8xb1hYREFzTllxandxVnovQmk5eFJTTER5?=
 =?utf-8?B?YW9jcmtPUUQrV2VoSk5BNC84NzFkaFFZSEJXam1RU3FyZUNaT1ZoeU5tdkxx?=
 =?utf-8?B?OGwxOFJ0UGpjWEFqY0FCZ3JZSzkzbnhpcHY2QXpYQU04a1MrTG55UGd2UWVR?=
 =?utf-8?B?Y1UwdFMvZG5nTERWb2pmYW1WY052QVNFOFA2WGl6cjYxOUdNTlVOUkg4Tktm?=
 =?utf-8?B?Y3hiczY0Mm8rTldSY1ljeCtlSEJPRCtvZkZUOG50MUlvQ2greTNIcEZ2c2lu?=
 =?utf-8?B?NGIvYWpvOUtCSFJ6TGE0VlFwb2dUSGhha3QrVDFSUkZ6b2JHWTUrS1hCcHlP?=
 =?utf-8?B?TCsxNk5Eb2RTMWdaby9kQ3NqdTVjbXMyM05ZV0tQVmxFZ0JaK0p4a3RCcDdz?=
 =?utf-8?B?NXg2ek1mb0JDL2lqTXlPWno1cHB6OUgxT3VtMXhPTnZjQWJkZFRXSXV1Lytu?=
 =?utf-8?B?ZVBuVlVUeGYxcEpxdEV4c2VvTVpWSHkzOU80V2ZwK0tQS2pMaGNsMWZ4a2tp?=
 =?utf-8?B?d2pPRkdvWXFjaUQ2dmNxbzArRUJvSlltRzFZSmNMNCt4b0NuZVcrb0gzQmQz?=
 =?utf-8?B?SmFxRHk2WW8xMnJTVFVBK3lpUFM2dEQ0T2RWbmswTkhGbjNPN2F6NU4wK1NL?=
 =?utf-8?B?TXhGWjMrNkVKZ3RMcVdXNUdNbFdLZkd3bjNCUmtuZDc3M01jSXYxTnF1K2Q1?=
 =?utf-8?B?ZEZoR2xBcGhxVWJ5V2hUTXo3K3pJWHVOU2E1SUhaR0ZOQnFhWXNScXd2YTZS?=
 =?utf-8?B?b0xhUmNCTWlDa29mMnB5ZHhrSTdVMlVEWmxUWGN2bWpRbFpXbUwyd1gwYmRC?=
 =?utf-8?B?K1hRV1ptd1MyNHZ4S1hpSStUaWJNT2VwRkVkYlZnWEo0N0h3VTNmbmFjRVBs?=
 =?utf-8?B?ZHhyOG94NG5vM0Q0QnZLcHVqUFEzME45b0YvZGRnSVpxRTIwMkdJVmhZTDBy?=
 =?utf-8?B?UVdzZElWSXF0eEFGcy9ERWdxYTMzWlBUNHU1UDhvUlZIMFhRdGgyMUMyUTgz?=
 =?utf-8?B?dGJiZTdidmY1dUp6amJjMmNOSmYySEhVN2tCV296ZHQrRXZ0d0d5U0tUMU9E?=
 =?utf-8?B?MjB2TTdrOS9vZHNCU0RBcUtWT3REZUVuV0lnZWdENStYVzBkQ1c0UmF2bzlv?=
 =?utf-8?B?ckx3cHVNYUxSU053ZmlqUzZYRDNua2lGMmIwbiswY2J5V2pOZEVwTzBjMldS?=
 =?utf-8?B?NFltNEtLTXFPYWhDQTR1VGUrVkNNaS83Vys1OW04bDZ1aTBycVNqSlY5RU9l?=
 =?utf-8?B?dis0bEpMVzFsa09YWTc5QUVFMWdPelVBUTBMNExHa1R6c1F0OFBwa3liRTVa?=
 =?utf-8?B?RHJXV1FsaVVOWlBKUjdGWjFPa3VmazJjcjQ3ZzI3dWhNcFRlUmlTTVh2dldH?=
 =?utf-8?Q?xAkuhH1j4yFZ6ywQXcb+AEX0d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1b24a1-8461-4f88-d323-08db19f50f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 01:34:11.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RT9CfkvArH/S29cuVgufaG8kGIveW0fF/4oCC6JhLmt4XUly62f+elGukGMjufLYIFnudwgqBeDlpKwsthc3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gU2VudDog
VHVlc2RheSwgRmVicnVhcnkgMjgsIDIwMjMgMTA6MjcgUE0NCj4gVG86IFpodW8sIFFpdXh1IDxx
aXV4dS56aHVvQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+Ow0KPiBMYWkgSmlhbmdz
aGFuIDxqaWFuZ3NoYW5sYWlAZ21haWwuY29tPjsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsg
UGF1bCBFLg0KPiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPjsgcmN1QHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyB2Ml0gcmN1OiBBZGQgYSBtaW5pbXVtIHRp
bWUgZm9yIG1hcmtpbmcgYm9vdCBhcw0KPiBjb21wbGV0ZWQNCj4gDQo+IE9uIFR1ZSwgRmViIDI4
LCAyMDIzIGF0IDE6NDDigK9BTSBaaHVvLCBRaXV4dSA8cWl1eHUuemh1b0BpbnRlbC5jb20+IHdy
b3RlOg0KPiA+DQo+IFsuLi5dDQo+ID4gTXkgdGVzdGluZyBzaG93ZWQgdGhlIHBvc2l0aXZlIHJl
c3VsdCB0aGF0IHRoZSBPUyBib290IHRpbWUgd2FzDQo+ID4gcmVkdWNlZCBieSB+NC42JSBvbiBt
eSBzaWRlIGFmdGVyIGFwcGx5aW5nIEpvZWzigJlzIHBhdGNoLg0KPiANCj4gV293LCB0aGlzIGlz
IGdyZWF0ISBJIGFtIGd1ZXNzaW5nIHlvdSBoYXZlIENPTkZJR19SQ1VfTEFaWSBkaXNhYmxlZCwN
Cj4gd2hlbiB5b3UgdGVzdGVkLiBJZiBzbywgdGhhdCBpcyBncmVhdCBuZXdzIHRoYXQgZXhwZWRp
dGluZyBSQ1UgZm9yIGEgYml0IGxvbmdlcg0KPiBpbXByb3ZlcyBib290IHRpbWUhIFBsZWFzZSBj
b25maXJtIHRoYXQgeW91ciBjb25maWcgaGFkIExBWlkgZGlzYWJsZWQuDQo+IA0KDQpJIGNvbmZp
cm0gdGhhdCBDT05GSUdfUkNVX0xBWlkga2VybmVsIGNvbmZpZ3VyYXRpb24gd2FzIGRpc2FibGVk
IGluIG15IHRlc3RpbmcuDQpBbGwgdGhlIGtlcm5lbCBjb25maWd1cmF0aW9ucyBmb3IgUkNVIHVz
ZWQgaW4gbXkgdGVzdGluZyBhcmUgYXMgYmVsb3c6DQoNCiAgICAgIw0KICAgICAjIFJDVSBTdWJz
eXN0ZW0NCiAgICAgIw0KICAgICBDT05GSUdfVFJFRV9SQ1U9eQ0KICAgICBDT05GSUdfUFJFRU1Q
VF9SQ1U9eQ0KICAgICBDT05GSUdfUkNVX0VYUEVSVD15DQogICAgIENPTkZJR19TUkNVPXkNCiAg
ICAgQ09ORklHX1RSRUVfU1JDVT15DQogICAgIENPTkZJR19UQVNLU19SQ1VfR0VORVJJQz15DQog
ICAgICMgQ09ORklHX0ZPUkNFX1RBU0tTX1JDVSBpcyBub3Qgc2V0DQogICAgIENPTkZJR19UQVNL
U19SQ1U9eQ0KICAgICAjIENPTkZJR19GT1JDRV9UQVNLU19SVURFX1JDVSBpcyBub3Qgc2V0DQog
ICAgICMgQ09ORklHX0ZPUkNFX1RBU0tTX1RSQUNFX1JDVSBpcyBub3Qgc2V0DQogICAgIENPTkZJ
R19UQVNLU19UUkFDRV9SQ1U9eQ0KICAgICBDT05GSUdfUkNVX1NUQUxMX0NPTU1PTj15DQogICAg
IENPTkZJR19SQ1VfTkVFRF9TRUdDQkxJU1Q9eQ0KICAgICBDT05GSUdfUkNVX0ZBTk9VVD0zMg0K
ICAgICBDT05GSUdfUkNVX0ZBTk9VVF9MRUFGPTE2DQogICAgICMgQ09ORklHX1JDVV9CT09TVCBp
cyBub3Qgc2V0DQogICAgIENPTkZJR19SQ1VfQk9PVF9FTkRfREVMQVk9MjAwMDANCiAgICAgQ09O
RklHX1JDVV9OT0NCX0NQVT15DQogICAgICMgQ09ORklHX1JDVV9OT0NCX0NQVV9ERUZBVUxUX0FM
TCBpcyBub3Qgc2V0DQogICAgICMgQ09ORklHX1RBU0tTX1RSQUNFX1JDVV9SRUFEX01CIGlzIG5v
dCBzZXQNCiAgICAgIyBDT05GSUdfUkNVX0xBWlkgaXMgbm90IHNldA0KICAgICAjIGVuZCBvZiBS
Q1UgU3Vic3lzdGVtDQoNCi1RaXV4dQ0K
