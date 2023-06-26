Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154773E3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFZPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFZPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:52:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571CA8;
        Mon, 26 Jun 2023 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687794728; x=1719330728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hLzMD4q85nirXzQD5+odj3pXrkL5deKAyhMvLutUICQ=;
  b=hNzaBGj6V6pQqphi95279YHQ9dzP0FAc/XJeRnfAOw3yQIF4HLxxGtrO
   nLVrtZwc+aNuSo0K9lpnFexBd0+5bskEPARwh0Fd3B2vC+smo1WF2+FIS
   77o1hM/7Nd/XPC1FLLdtputieNIcihsr2wgPOGBplxylbQhiaiO3k8XKY
   T/Cz1ESUzkvLlkweDUJxIPMnmmxvM3KgYKON8FiQQ3PfhggSaFbmtr75+
   3ytmnrNWq8ljlW4IJ540VSUycCJSQze5xLeD0B9UJ+WHZAELQEquw0/DZ
   97up6WYIEO2a7qcn4H8DVF92LI5g0p9AMOa4FErjt4teiMzmRzm76yL4H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="363851433"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="363851433"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 08:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="829273339"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="829273339"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2023 08:52:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 08:52:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 08:52:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 08:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU5J+zzCsswaggZeRdF4KqY7JfIKPptbw0cMJ203txK5rZtRvjPatp+W2oXGaUzxZZrEuDQlcbnoZhczEMDGexvvudm53zvGJGbcIHBstDF5QHdAHVkfml6zR2qQZHxAKzMdAi72310SSgcMhx0FnJs5nZM9sqc45hi/U5Q0fsFPKMnJeQ5u9Q9HFZqQ6lMtZ2BZeSYiLA984aC8bNXiDgfS7LvWFvJVZr5c5oJtgJKOIsPfrWHwbs82CgLGnjs7/TGSsfO+k0PwahPtez2Ov6UD2x/XupUIqkHRzIejN6B7ouWyLge06IPpeoaOAi/9JomrzXu1Ek8DOEHm2hz8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLzMD4q85nirXzQD5+odj3pXrkL5deKAyhMvLutUICQ=;
 b=Ph6XEpBNvCUlC/FCB8YcTchlv4I4sYQ+Svub1YIE/pn/JCN3IZp/xBp2MD3eS2svlXxOAaILI2LP6a/U3PoONAYJFi6z673ephwskD14eTQJuL38JEQbtEnOn4sWz8TPuJE3IC1ri54HesVZhqxHYzg7/piS0EhSKkCnxE2H3IWBYR892yVU9hlMlnIOGlwZu5A3BXpj48juIu8nCAYL16CrU5G8nFuDY0dI5T3kQnxNuLoAST55HA2bctANxyoeFutUOMKLbyIFjIPdJycrTC6qRoFWFO9FTyouhBifxiHWmgZOroEzAF6jW1DbpgrkKQFeJ/1hDf9NV89SF7uUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Mon, 26 Jun
 2023 15:52:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 15:52:03 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Topic: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Index: AQHZpGd48oRuL5v3EUiLea9/WFe4Sq+dD/cAgAAxwVA=
Date:   Mon, 26 Jun 2023 15:52:03 +0000
Message-ID: <SJ1PR11MB608334F6555F9CEF3F740DE8FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-8-tony.luck@intel.com>
 <CALPaoCi+A5TxoReh=HRMsRKYDWb4eQ-NOB75Lj9674L6aV0T=Q@mail.gmail.com>
In-Reply-To: <CALPaoCi+A5TxoReh=HRMsRKYDWb4eQ-NOB75Lj9674L6aV0T=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CYYPR11MB8408:EE_
x-ms-office365-filtering-correlation-id: f9d486df-4d1c-43ed-02a9-08db765d4921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFFpH77vidJi6MFnQYCeftyFTRCHMjwlEPKT8OnwYpKk/vXb09P63+BPrLEssjenJJ1U83GABSoqJQVqbPk5iLmItEKfulHuWspAzJ//tvFxZsDd1hhGK3i2hNl2S35i0uPRFl9J36KDtjVPkGSAVxl1wzL1VLNB1PNVLaFyUCXbFuD1le8jaxB1K69qAu7rH5wjkGVxU4eBBenekquQuHcwX1q3ZSw4O7MboLHpZ4XcOINrA1wLdDF5NZnAKYtCqwVB2o5xRfbTzhyBfSu/6uIwfwX3vG7i1YxoZSQ/CJDFy2P9k9KH3qLdxgvwfS6/QteIv8TxYyPHBwJw7V0n32brYmWZtn8x85LuPNOza5qzdDFHBx36YncwR0vRrl2hplimJB/18Fhni1jkd+cud0KMAOh0i9nyMJqOtXnVeH2FDGMyY0p4Tm8Lg7NGWI8EDb8fc/76fdfv4OEwPnn+CylCkrhTGStVoUC2Z+kGXeNowTPLnVdlnwKcRmk06M28svEQx8WE7oB63Wm4AaAhfgaajqh4mR01P4bbXEXOn2E2NiL5z/1+Hn0XVaekBTQVdASqMgkMEEkONlliV7xGfgjGpLuFdjnLagSra8r01TARFYHTtHAqRj0XInVDZubH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(66946007)(71200400001)(66476007)(26005)(64756008)(54906003)(66556008)(66446008)(6916009)(478600001)(4326008)(76116006)(33656002)(186003)(83380400001)(9686003)(86362001)(8936002)(8676002)(4744005)(41300700001)(52536014)(2906002)(7416002)(5660300002)(7696005)(316002)(55016003)(38100700002)(38070700005)(6506007)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q01RbVFKaUVwZlM1bWQyenl5UW84UDY5cmRpM0ZQd3hxbEZGS2FBWWpUZmxC?=
 =?utf-8?B?Rzc5MWJuek5RdUF1RHFETTFzQlQvQmZzNVBsVlVqWm9jemhibEVIdDc2WWgv?=
 =?utf-8?B?NStSQ2lNM0h6YVpxNVdZZitpeG5nVXNXbU1oVHh3M0tMUnF4ajFZTzJneVhn?=
 =?utf-8?B?OG5PaUtNdCtMSnBlNDRsR3llYmdtc210VkFyL1hWQ2pEODR6TFJXVFVhNFFQ?=
 =?utf-8?B?bGhSeWRyRzJVVWRnNDJqb25nVTVoNU5GeC9xMTE2WEM1RkRpNVo5TEwzWkFl?=
 =?utf-8?B?dVpVeENFancwdkRHYjUrT0ZBZFdSK1B6M3RrWHpCNm9RaThQN0NXd3RJOFR2?=
 =?utf-8?B?cCtKMEQ0dy92RCtzWmdDMFAxV1dJbHhEWDZrVkgwckp4eklyemJFc3pWYnZa?=
 =?utf-8?B?c2ZlSXMxZFRteFBmRWVEQi90V0FGWHRsQUV1bm9XTlN4dXFvbGxSQVpXUXFW?=
 =?utf-8?B?Mk0wbXZKTjRLRk9NbUVLTkFuSU01YnZMUy9Rd2JRcm9yNkx4cUxsQnFURE9T?=
 =?utf-8?B?dEJVRGRac3luaFl3Y016dkdmYmllcDY2ZVFHNkZ6MFlxWWVrWThNL2lkUGFj?=
 =?utf-8?B?SE5FcFVYV0RTR3dhTXZNN1Z1SHhRUjJOTkprUDZ3TFJmcUthbXV2RE9KZHQx?=
 =?utf-8?B?K201V3RyakVSVUFzVUtZNk4vL1hWVVQ1cXZCR3EzTDdtNDFTWkJBcTV4ZElq?=
 =?utf-8?B?Ri9tTWtsVmp6MEtkOFhzSC9lbUJwTmhHY1QwVnhXOWVnWlpBbFRFUlZ0Ujd3?=
 =?utf-8?B?UG1vOEMyem9pZU1ueXIxVDlHTklpZWNmZ1hVZjY3bVpaYXpuQ1Ixa0NRbDc5?=
 =?utf-8?B?b1luUGM0M2kvckpSVUtkYTlYWFhTVzNTRWNmR2NaeGFtUFkzZXNUZkVaQWtP?=
 =?utf-8?B?MWxFcWV1TnhOWUJNREg3M2RMcjVuMUpKNFAwQlRidk9NbWNWaElHaElnVUZ4?=
 =?utf-8?B?WGlINFlTSnJZb0ZwZm1oanpPUVV6Y0NoM2RhemVkVktabjBIMm40WHE3d1dH?=
 =?utf-8?B?dmIwYkhvb2kza3pBdEZob1hzaTVXS2c0Q2diaVkxQk5KUEk4d3NQbUtjd1RI?=
 =?utf-8?B?M3NFb3NFdmR1emJJUjhwTjJ6MEZheDdhb0o2SjBVaEIzeTFOanJNdWViUU9Y?=
 =?utf-8?B?QWZURm1EZEhBeDlVY2pGVUZYenczaTduZ1p4akJoQ3ZBMlNNb0UyL2dDdThy?=
 =?utf-8?B?Skc2aENEWE95YlNjSm1nTGdJUktNSjFiZGN4bWNsTWZHWWpIL1NlMHEyMEJP?=
 =?utf-8?B?VlFVUXFTR1UxZEdNOGxPMFh1VVhjNkpjczJkMFk4d3lZTEtxWENXKys3SVlO?=
 =?utf-8?B?QUtUTW9hSU5ucDlaaEVqNGtyZ2JxRzBTWWZZN1k4Q1RmbCttWDhTMHQ4NzNP?=
 =?utf-8?B?QUZuRjV1KzdocHhZdmhZZVFNZVFoZUNqU1VMNDhpZXhZbjVPemw4bXpSc3E5?=
 =?utf-8?B?dEcxdVErazBiYk02a1I4b0xMQk5TeFNBV3JwUU5tQUxyR1MyZENDOEVFM1Z0?=
 =?utf-8?B?V3BRZE1OTHJSK21WQTMwd29keE9QQXJBUzR6b1d5eFNnQlZpOWZEcnNpc3BF?=
 =?utf-8?B?Mm9Ld3laK1BxT1Izelk1WDh5cXphbXlTaEQ5d2drR2ZsSmNqTTVqREFqZ0oy?=
 =?utf-8?B?UUZqaVNKT0xacFZYMTNFYklkRDZnVjYyaU5FaXROQTY3WHFySkphdWNyVGtt?=
 =?utf-8?B?SGhON0gzVi9vQXY4SzNNY0srRWhDRUZ1SEhWTEZwR2Z0MXUxTndFSVRBbEZu?=
 =?utf-8?B?Nkh1RnNNRTdnT1IxLytRWmlWVWsxampkSWRlTEZDMHNCZzZ4S2dvbWVLWitR?=
 =?utf-8?B?UDBKZWREYzFyaE5STWpLcWdGd215Mmgrd21HSUkyTnZCREhUak9KaGJIUGRX?=
 =?utf-8?B?bVliNWlCaGZrNkRXYjNGaVNOQmlWeGs3VCtmVnhpYU5mTmkwNUM0NDhlTTZv?=
 =?utf-8?B?d0NJVU1mUGYrU1dZekRCaW1iTk5sVkUyU1M4OFZHMUVWL3VMeHVmbjI5cFpp?=
 =?utf-8?B?R1dXUDlkRk1FdERqa2x2aDVOZGYxclROdFhSQ3VDTEkxVzFJY2ZmQW5wd2tG?=
 =?utf-8?B?cVBFMVBjS0Z1VUJLL3FySWwyOEhGcmo2WW4rdjQyY1E4YzFqZ0hGMVZBMkFD?=
 =?utf-8?Q?uKhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d486df-4d1c-43ed-02a9-08db765d4921
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 15:52:03.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iug2hdX3JIvYln89C+ZmayYZY1QV05F5R8RoIkerQRxQcZ1h5naianaRr9vrLw3pTcNqo5sOPQV9El0Fb1X6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcmVzY3RybC5oDQo+PiBAQCAtMzUsNiArMzUs
OCBAQCBERUNMQVJFX1NUQVRJQ19LRVlfRkFMU0UocmR0X2VuYWJsZV9rZXkpOw0KPj4gIERFQ0xB
UkVfU1RBVElDX0tFWV9GQUxTRShyZHRfYWxsb2NfZW5hYmxlX2tleSk7DQo+PiAgREVDTEFSRV9T
VEFUSUNfS0VZX0ZBTFNFKHJkdF9tb25fZW5hYmxlX2tleSk7DQo+Pg0KPj4gK0RFQ0xBUkVfUEVS
X0NQVShpbnQsIHJtaWRfb2Zmc2V0KTsNCj4+ICsNCj4NCj4gSSBhc3N1bWVkIHRoYXQgZGVjbGFy
YXRpb25zIGluIHRoaXMgZmlsZSB3ZXJlIHRob3NlIG5lZWRlZCBieQ0KPiBfX3Jlc2N0cmxfc2No
ZWRfaW4oKS4gTm93IHRoYXQgcm1pZF9vZmZzZXQgaXMgdXNlZCB3aGVuIHNldHRpbmcNCj4gUFFS
X0FTU09DLCB3b3VsZCB0aGlzIGdvIHNvbWV3aGVyZSBlbHNlPw0KDQpQUVJfQVNTT0Mgbm8gbG9u
Z2VyIG5lZWRzIHJtaWRfb2Zmc2V0LiBCdXQgUU1fRVZUU0VMIHN0aWxsIGRvZXMuDQoNCkknbGwg
dGFrZSBhIGxvb2sgdG8gc2VlIGlmIGFsbCB0aGUgU05DIGRldGVjdGlvbiBjb2RlIGNhbiBtb3Zl
IGludG8NCm1vbml0b3IuYy4gVGhlbiBybWlkX29mZnNldCBjb3VsZCBiZSBzdGF0aWMgaW4gdGhh
dCBmaWxlLiBCdXQgaWYgdGhhdCBnZXRzDQpjb21wbGljYXRlZCBJIG1heSBsZWF2ZSBpdCBhbG9u
ZSAod2l0aCBybWlkX29mZnNldCBzZXQgaW4gY29yZS5jIGFuZCB1c2VkDQppbiBtb25pdG9yLmMp
Lg0KDQo+IE90aGVyIHRoYW4gdGhpcyBhbmQgZml4aW5nIHRoZSBNU1IgdXBkYXRlLCB0aGUgc2Vy
aWVzIGxvb2tzIGZpbmUgdG8gbWUuDQo+DQo+IFJldmlld2VkLUJ5OiBQZXRlciBOZXdtYW4gPHBl
dGVybmV3bWFuQGdvb2dsZS5jb20+DQoNClBldGVyLA0KDQpUaGFua3MgZm9yIHRlc3RpbmcgYW5k
IHJldmlldy4gRGlkIHlvdSBhbHNvIHRlc3Qgb24gb25lIG9mIHlvdXIgc3lzdGVtcw0Kd2l0aCBh
IG1lbW9yeS1vbmx5IG5vZGU/IEkgcmVjYWxsIHRoYXQgd2FzIGFuIGlzc3VlIHdpdGggbXkgdmVy
eSBmaXJzdA0KcGF0Y2ggc2VyaWVzLg0KDQotVG9ueQ0K
