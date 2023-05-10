Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74F6FD35B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjEJAwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjEJAwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:52:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042C43C3B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 17:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683679941; x=1715215941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RkqSTv84E37k1yEv3HJwiH2UhL1qB5eRtsr8H/b+/g4=;
  b=BuG1Fc7mEbm7xWVYcH1aq+pPKrzNQSZ7ayHw4d4iguL5aNMvjIbYYsT9
   h0wkrAgV0kIKlpE0IokXiXQvklFAITtSOM4JNtHjJZyfF81Ih2B1bBY7g
   mKDZVBZ6Sjl+hwwkkOxj9RwB5Nz5J2sH3cJjKKsvC5ZqlZbt+hSLPaQd1
   EFYQ4+AwckPyHBmFK7YR07joVSQ0szn5I0wYTPJd7WzfwQavlQUUhFRWb
   hvcGg43OPgDoHt/dAXIuFPtccQg12CB8SOglpR+m4F2sA5a4SlaOdBHSl
   iTKZ820qVhh4shUCiuhqsByLttZFWMa9WRumLOCeuJchhXL9jHgDSaHcc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="329713745"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="329713745"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 17:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="945498706"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="945498706"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 09 May 2023 17:52:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 17:52:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 17:52:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 17:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk7+TsMnA05gO+55+aefl6eMXCw3q7/6U7alc7tWXX4zUsq2yy0GLbmToWwdhECeclLbjKjfAt59dLEdHFkgUHxATh0jHMLD71KOrYJOuZHngTS7YGTDTxZlsn1jj2i7dR7ER8mOx0NSQUdf0W0WfjaBQkgV+Snae/sP/kPcvmqg/wb2Qoy9XiuI8qNbwafPCOsTeHA3mrGRCi/oM1/IB1POqtuxoiNDiUkJykAme7s2RaCenBnrS5WPuVJpPj3rQnvzkfZhWJRF0W5TyaxGm2b9hEO8o6YVt7hUs1LsWRXN/EVzx3tyqzEFCQnKZuCDA73qb5Svl2C+t9djcTHGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkqSTv84E37k1yEv3HJwiH2UhL1qB5eRtsr8H/b+/g4=;
 b=Q7MMy9lGKFi2SLQgsuVs8ztoZneYwGzpxTp5B5s/TjSwRPJTdJLQqumGidFIJmFCa8PubXtxgLKRgx79+6vh+odWvLMeQ0cJqfd9ZETwcJF3i8j/CJm5iOFXntf+vQWr1eL3ntiDZ2mnYc/DH4Cgceua5At0udXTM05XarIxz+wutA/jADabfIZxvbOPRvu/UEiu3Yn7Fcw4nluFsRC3PN6EDpBiSZzuqYPtGSQPvY2kEFWSJEmYVYtme4fNHbn9KxkHFPgeetgtNvqCpn1plaQl6x9VfSuXUwLbT+asJ+ue0Yva/qVL6VFbtgyJKWXZX5liNyA9Ae9JDco+IHAP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5466.namprd11.prod.outlook.com (2603:10b6:408:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 00:52:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 00:52:18 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Topic: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Index: AQHZc9RpUDnrLIcguE2hFRoOJfWMkK9MZ88AgARWAUCAAdZ8gIAABlIAgAAkbYCAAApasA==
Date:   Wed, 10 May 2023 00:52:18 +0000
Message-ID: <SJ1PR11MB608337288A7A7F8CE33516F4FC779@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <237603b3-f553-2ede-5725-239b65626c69@intel.com>
 <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ae3cbde7-1137-1b33-dbb8-ae8892abddc7@intel.com>
In-Reply-To: <ae3cbde7-1137-1b33-dbb8-ae8892abddc7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5466:EE_
x-ms-office365-filtering-correlation-id: 1fd62300-e1de-4230-521f-08db50f0ce0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lztZW0ccnYsRWa+l2OLZ/bGS9F4Zl7EUGLsKQIRAtdfLQfrso33FcdAKK61lptJASrXgdHikX8irkitTK+KqKVvET85pXteOTxYHr5UmeIWezX/fFZw+oNeiqQ+CNJ+R6nTZlu8+3h/o9QjvDOqAzGdaL5p2UGdTmivf+nWZx/E8z33G18cIr7KL3JcRACTIiuNRCFZ/c0DE0cGJ+QVPjOA17HkPWSLREfL49QVAsan3O6gFrwTVaoD+j/LQz2UvQrd6XK1qxp9Oz7JI9TP+12hec15/ZR7qYz1PHfVDmi1AoVntfQrPIKXt7w19Xj4rx+mY8H26tHZWaIghXcfOeMzmclzJHt2aByLuqFwLmB8hLM3qJ0JVL0qHCM4IwilHoG8gQprVdiPhLWLzGhmBonmoHpT0d5TSpExyHeLcXsDYrSSpZuMETkQcmIZZBXI5W1/30Qk+a/mATbBPvxmh0tW3T7cPlC0UnoWZ6IrGn6GTwMY/n8ig+aCsoI2ItzY5CFbHFVXzq16YHYgfyET0bKPxom2fSaF3v5ywbLoqGh9bTefWuM7+EXPQk/S51I0EjcZPw4Gcu2xCwv6ECNZrK8dlVDv9r8006NzcHfhGYvyFWPo9Z3gvFocagvoo4kI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(86362001)(2906002)(83380400001)(186003)(38070700005)(4326008)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(26005)(9686003)(6506007)(4744005)(7416002)(5660300002)(33656002)(7696005)(38100700002)(41300700001)(52536014)(122000001)(55016003)(54906003)(110136005)(71200400001)(316002)(921005)(82960400001)(8936002)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGV3b2xtb0dQdCtNU2JoOWZrMExUNUNoQTZmVkp1ajByM1JORG5sUFFSRG5o?=
 =?utf-8?B?ZTd4M0laNE13UkxDZEdtc1E4NU5OenVuei9wa2pvTFA1QUZyODh1N1R6NnJQ?=
 =?utf-8?B?Ylp5UWRmS1l3Y3hHVGlyWUo4dDc4OEN4eG9FZUpTZU1CZ09nZVNQK0t0VmlH?=
 =?utf-8?B?MGQ3bzVMVUlETFUwaWM3K0o3U0RiQU96Z0dHQTVlaXo1ZUM3V29NKzVtYUhV?=
 =?utf-8?B?cVo4eTNoWGM3clNZcVpjUkhNUzQ4Vzlwdk1VSCtIdlZqcnpZOC9ya3A0Y29i?=
 =?utf-8?B?WVdGQ3RsWXpWcDdiMTNWRzFzSFJBSmtNWmg4eTJxc1k4Mmt5aEFsYUIvNWV1?=
 =?utf-8?B?YXE3dmh2Wk91UFJLUXFBZytxTTdGR1JKRVpMWFZkejU1Z3ozMFh1QXEzN05G?=
 =?utf-8?B?clRxaE16MnFpV3dNNEMzTU9kS2VlWEw0N0pVd2Z4U0lxTENkUW0rZkVNV0hK?=
 =?utf-8?B?WkdjODY4SXNBMzJoZjZ2ellyWEMvTmZWczA4VW01a2trWit1MzhBUTdXdFNP?=
 =?utf-8?B?RDNlakhhclQ5N0E3ZGIrZkdvbTJqVjVzWTUvQXBIMVdENnZkYmtna0xnNzJ4?=
 =?utf-8?B?aWcyUkZrTSs1bTV4czN0bVJXNFR1RlB3Nk1KeU9vazJrbWNobXduYVI0K1dv?=
 =?utf-8?B?b3Z2OVpPcG9WZ0JXRjJUOWMvNzRid050aHE5L2Y0MmdpQmlJc2JUUGJ4dDUr?=
 =?utf-8?B?M3ZLcklBWHk5aGRmRWNYK2RoREw2cHk0WThiOGxaNkRiK05LQ0Z1N0ExOE51?=
 =?utf-8?B?TlZsMFd2QWRGRkZESG1LU0QwV2VTN2xLWDAyQ21CbFRXSUQyWXRGeTVRT2g4?=
 =?utf-8?B?SWFVaU1kbUl3WTUwZ3Z2b2dPOCtVaU4vVjNMSzdJMTBWVWZaVUVFVXAzV1ZK?=
 =?utf-8?B?cnNqMy83TWh1bjJ5K2xvRWR5Y3dURVFFWkRTQ3c3TWtBWUNlem9xaERuLzN2?=
 =?utf-8?B?SGRBT3dHWHB2TTlzRTg1cWF1OHZEM2FpOTNtRkFEY0pHUUNuKzNWcWdVb3JC?=
 =?utf-8?B?RUxyZkNseXNVNEs3aVpKQVI3bDlQaEEwVUxESHNsM2dJQkNHUFhqdjQ0THBB?=
 =?utf-8?B?N0RHblhKTWx4SThHYmRxeVZTR2Y2OUJlbVZCUW5xQS9rV0FBaHRzT1c5RGVx?=
 =?utf-8?B?NDNPc0NWUGdjWndYeTAvcVZ1WkFlTGU4b3BrV0RkODRsTzNuK3A5VldYdHNE?=
 =?utf-8?B?WmpsUG9rVXVzUUQ4V2VxVkN5MVVrUUZHT3Y3dWNxSFc1MGpHam04OXY2ZVdP?=
 =?utf-8?B?bVlvTWZXMkt4bGNnYk5tOHdFWHNyNXQ1MlBXN0NIcUswZlVGUXpIUEFHMFlP?=
 =?utf-8?B?d0xDTXdaV2FxNXZoVTNLTGluTUhCY1RSK2hHMVpDR0FSeGkvb2NnM3liNWph?=
 =?utf-8?B?STFHL29KTlhQMDhoaStFOTlBZWlFQW5qby8wWERYZk1zNEh2WHo3QkFlbktx?=
 =?utf-8?B?WmxTTVB3Y1k1NmVqenZTQWRQV2RtS2VpYWV1amJxR0wyWUQyTEFJcTEvMjFJ?=
 =?utf-8?B?U0E3S2tFZ1FiY1c0dkg5eS9ESENNc0NnK3U5dnVneDcvbU5BVEd2ZVZseDZH?=
 =?utf-8?B?dE9PWDY1emhxall6NytCTFBmR1lGZ0tUK0Foc0lFdHhEYTBPaW1KamdIWHJ2?=
 =?utf-8?B?MWFQTkRlT0N2T0U1RTg5S1kvNkJXRXliVmdSSkpheGh2MDVqRnIvTXo3UVlq?=
 =?utf-8?B?U3A3OFcrWm54eWN6SEx5WUowSkExdkQ4UEVwTzcrQmprL215WjNsY01aWEYx?=
 =?utf-8?B?ZlBOeUU5NUdxSGw4U1VieWdwTVpXMTgwcmxIVk1zZnptajA1Ky9NMzhXWGtv?=
 =?utf-8?B?MWI2QVpHcHhYUllmc0FqTlR5QmF0QWMxU1ZvQU5sMG1MTmwrd1NCb25EeGlQ?=
 =?utf-8?B?ZXVkSEhhRnIvbndQNjFSNDZ6RzBTVUJ6RnU1emJHREFrSlVyVGFGQ21POUQ2?=
 =?utf-8?B?amhBei9qRjBLR2hzakh3VEJoUGtueG5YWEhNQ1g2VVA4dGt6Zms1M1hmcWkz?=
 =?utf-8?B?cVFKLzFwMWJ3NmZMeGl1bEJ4VEFXTU5LZ1h2aWQrcjFhblQ0K3p5bWhVZ3pr?=
 =?utf-8?B?aE85ek1DZm5aRzZ3bDRPTWtGakZmSDNzcFRUZ2x1dUVnWXFDL245QmtnWEF4?=
 =?utf-8?Q?uEtE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd62300-e1de-4230-521f-08db50f0ce0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 00:52:18.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Te7bTF17saXEVTC9g0/ylSTRukcrd6uS67oWKgkq/JaAixZl3DT4uS/DQ6CcHQkfylmhZmTH+sChSeLxCP656w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5466
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJdCBpcyBoYXJkIHRvIHRlbGwgZnJvbSBqdXN0IGEgZGlmZnN0YXQgaG93IHRoaXMgaW1wbGVt
ZW50YXRpb24gaW1wYWN0cw0KPiB0aGUgY29yZS4gQSBzaW1pbGFyIGRpZmZzdGF0IGZvciB0aGUg
ZHJpdmVyIGltcGxlbWVudGF0aW9uIG1heQ0KPiBoZWxwLiAiMTMwMCBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkiIGRvZXMgbm90IHNlZW0gbGlrZSBhIGxvdCBvZiANCj4gY29yZSByZWZh
Y3RvcmluZy4NCg0KSGVyZSdzIHRoZSByZXNjdHJsIGJpdHMgb2YgRmVuZ2h1YSdzIGRpZmZzdGF0
ICh3aXRoIHRoZSBmaWxlbmFtZSBvZiB0aGUgbmV3DQpmZWF0dXJlIGNoYW5nZWQgdG8gYXZvaWQg
Z2l2aW5nIHRvbyBtdWNoIGF3YXkpOg0KDQogYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2Nv
cmUuYyAgICAgICAgfCAgMzkgKysrLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9uZXdm
ZWF0dXJlLmMgIHwgNzgwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9u
aXRvci5jICAgICB8ICAgNCArLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91
cC5jICAgIHwgMzMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKystDQoNCkNoYW5nZXMgdG8g
Y29yZSBmaWxlcyBhcmUgfjM3NSBsaW5lcyAuLi4gYWJvdXQgNTAlIG1vcmUgdGhhbiBJIGFkZGVk
IHRvIGNvcmUgY29kZQ0KdG8gcHJvdmlkZSBhIHJlZ2lzdHJhdGlvbiBob29rIGZvciB0aGlzIGFu
ZCBtYW55IG90aGVyIGRyaXZlcnMuICBNeSBkcml2ZXIgcmVnaXN0cmF0aW9uDQpob29rcyB3aWxs
IGxpa2VseSBpbmZsYXRlIGJ5IHRoYXQgbXVjaCB3aGVuIHRoZSByb3VnaCBlZGdlcyBhcmUgc21v
b3RoZWQuDQoNCi1Ub255DQo=
