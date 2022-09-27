Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801035ED05C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiI0Wme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiI0Wma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:42:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652BF8C2C;
        Tue, 27 Sep 2022 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664318549; x=1695854549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rtmhTVGAK77hG5ctDDyl0mqcDB40CbUxYD9i/JKwtBM=;
  b=oBCKMZkOK7Agus/+ji2vW8bKer4k5kGFLqT3XSXAPC5Z1nXsdfZMX7Ml
   yau+Dq4Uo2dC7DiEUgovetaxvf8WncbjiiE9BPIvlzaa6p5mIvnXVrCuM
   7g/i7FJMNcOfr84WzWBebfSi45jEABr7Qs7Lv9SUzDcXnSAWEML8ylJ2H
   wD4vBS5BlcLKrXYTohXcxqzBtAYpXA1pRdlhW89D9HmFGMEYq+qlUXabF
   G9It4zTJKeaA5p5cd9sK2LKFqC1QLKwTKzTRQIkEISnFF8gbqhreMDzsh
   f9N62e+lDeNcxxlxeSNkde5+SW+df9EleTPkEH9jh6u9Tghq1PKC7agzq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302359232"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="302359232"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="623923602"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="623923602"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2022 15:42:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 15:42:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 15:42:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 15:42:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJydHxBm/WDqy37CGih+6QF47YvPt6RABayzGSqi4w98l0FYa6LX5kbU0wQ5shMA0wsGGniI3sbGjcyFg1rTfH4+uDNNyjkYOub+KQPTF808MCt/XM0D9LAbu/M5q6mlb8jDO/nRFAw151mN6nf6tGRNrbOOlMb9TIE1x59uRldl9KqUb3YahGoAXyLJs8uhWn4FLOS9SFAXE7nn5mYewnOpir7Xbskhim+wwafJYoeI+wqhJRH5NAa+4qr5910yS1OPirThzNPHjCe7WGNZCTQhTcmr/ge/YEeRPPOsy5ujwMrkXFx6i9w2Wse4VZ18TflUw+htMfami01+0fDGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtmhTVGAK77hG5ctDDyl0mqcDB40CbUxYD9i/JKwtBM=;
 b=cEMxdpuD5ATd3xaX15Plj43I+P9z69GZ1FMxPB3R8LyVTow9fvZQDOAZWHDhTUS7s76Eip0Xdtrcpt1OaAC+5LWgdgv66FbJgM6FuDKfbeDposqSJ/Ngc10npIx2WJTavJfpdgPPxnLoOoQl5qp9JeeQwE9hDC1kHXrxwX8ysD5Irib+wSMowsEi5mpjvB2H4KsEE9AyPHIeGJTkrojGWlNIRG2bTalQmRXxGavsWFGz0K2uThXH2TPLDJ/Yf0KVJYtwIFdHmswjTUAAMSXsXOasacI5EhxxSTTd0Os0MC4hPD77ujnIOYxaZezy+91T3SR2XmwO3eteh+HM22IyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 22:42:17 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 22:42:17 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH v5 08/12] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes event configuration
Thread-Topic: [PATCH v5 08/12] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes event configuration
Thread-Index: AQHY0q99Qwf2P0shm0arw/qnRk0Cb63z3WaA
Date:   Tue, 27 Sep 2022 22:42:17 +0000
Message-ID: <IA1PR11MB609736EB0036405567A851649B559@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431038771.373387.9706240777220251603.stgit@bmoger-ubuntu>
In-Reply-To: <166431038771.373387.9706240777220251603.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|DM4PR11MB5277:EE_
x-ms-office365-filtering-correlation-id: 751feae4-90e8-4e18-c344-08daa0d9880f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xc+/qh6z0LeMDd0gz+XdpF5fJ+n7w1OYIRUZRJ77jEBMxVuoBoWV0kOrSUbgEnHqll7om8aFTlwSHGIqN9eOCritlmX35POS1SDJOuZYK/nz7lfpeHzPDalV+mO1GRGAmX0X6vFYndNfqxNUNFD8sWUQvKsf4BYgkDLYiMIG4f7VP9A+pj/NbqToe1mgJ6RtHJxDaaULFsiw8Zb9nMra3PlYM9psxve/FUqHr4G+zBqumf6q5IVbEhTdRC4DA7sf0cw5H6FTVVOKK17FAfwmJtyXKduxUfDHBN8G/phMJcQORb1DTU4CB0NwT4jTyDZzMI2+wQKwKEm9Vx2TFc3G1/E7hxF5NTMo+hKHz5ryTYhuznZSkzn6ywnZf69AL1/azs7VqKinXgLMLYvhfLTdDog+1liV21j9JmvLcRPHwIeYieHF6AaFDVFvhmbbtR9/K+KAOz7zz12RLbDZIVzsf9tnAnKoOkoXGVY5TiJGas1M4jONTArJFlPzNt1D+MGNKr6gmB4WLXuyz07ER0xSi8mFI0M69xaiXkejNZyQgjgCrG34WKD2ia2iLuP0UUK2BB76y6DqazMjdCTunKESZrwlAYNsIIAHNXjyeDAuhAgo9RiuiQ2dGEZgu/WAyhz055zt3/GGWtKm1RSWxuQ4MbBbNF8I3cB8Mq5qmvJqRPZt3oSZ2i4c17eC9cJdYHPXXt6GD63/btlPLeDQW5wsDPcQv9HUddxUrwxtf7PR6UmAXTqry25RjYKZID0RfozyAPRTGKGzVUDa/GjfUBYcvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(9686003)(26005)(6506007)(76116006)(55016003)(122000001)(38100700002)(2906002)(82960400001)(71200400001)(5660300002)(7416002)(4744005)(86362001)(478600001)(33656002)(38070700005)(186003)(41300700001)(64756008)(66476007)(66946007)(66446008)(8936002)(316002)(54906003)(66556008)(4326008)(52536014)(8676002)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFdvM2c5Q3dYVHk1dWhLV0MxbjJHNDVHR3NxSHpTNUdJNHRDa3NZUkw5aTdp?=
 =?utf-8?B?ZXd1VVBmQ3M2USt0eUZobzkvVGtrQkxzeWZSOGRHbTBUamVnTytQdzhVYVpu?=
 =?utf-8?B?NHE3dzlxR1djTmoxT3ZwNWVhdzYybTdFUjgwblRoUVRRUUFMS3B5aXZJVlp2?=
 =?utf-8?B?L0RORWxFZU9VZVBoNG1VaVo0cnFra2RYa2dPN2tnMFVOZlJmaUV5dzA1YWxS?=
 =?utf-8?B?RS9IS3dZWkFXelk4S0dxVkE3RGE3eEY0alFwYm05OVBrQjRTWFJJZGc2QVlI?=
 =?utf-8?B?bGVOV3hVNGdjSXlaTEora00zTHowNHI5MXFldzhnc2dVS09sYTJqb1NSZkRS?=
 =?utf-8?B?MFAraUEwVGVhTjcxS3pxWk5SMmhqdGNXQ2lIR0E2OW11K1FvNC9zN3pEcVQz?=
 =?utf-8?B?ZmlxSm53OHBvR0dPT2ljRDBISjNnK1h0bUptRVorMDhJTmZSNENSMGZ6QTJo?=
 =?utf-8?B?QjQyc0UwcmJzdlpLU3dNSDc4N0ZYVWpJZWk4ckZ4dW1ma2pkdFpsZWxCbWQy?=
 =?utf-8?B?N3hvalY2ZWhmMU05WmlNT1IyZ3lTT1g2VUhQaGFuUGRob1lEcHUyT0IxbGFy?=
 =?utf-8?B?MkF1dmdXRS9CMXlKOUNSamNkdUdqcHJrVmhhZG5xVFlqb1o1UWI0MUNNcW5S?=
 =?utf-8?B?S3hhVS9pUFh5TEE3dDVmMU9Zam1QUUhYR3hlSHUyd0FoYW01ZklLNmp2eEpF?=
 =?utf-8?B?Sy9JM1JPcmhoVjI0c0thdHpkTVg3TDN0WDlFTkFNdnRmOVV1NnMzT1ZXMVk4?=
 =?utf-8?B?OXNpb3lDME53aDJPRkI3L3RUOCtSZjloKzJ4bXFCWkgwamZvZ1R6TjUzTzk2?=
 =?utf-8?B?dENRWUdrZHRPc1QwVk9YWVFmYTlJeWIxSU9ONkR2OCs3TTlrS1BMdHFSdFk0?=
 =?utf-8?B?ZFY0UmlOT3dXSEdQVW5FQVlDeGJrQ0V6YUVpMnAyRmpXNEtSZ0RGQnhKZ29Y?=
 =?utf-8?B?ZjhBb0RidGRHUzY2UXJnTEd4ektEaWVMb1ROdjhwU0E1WE5WSlM4aTlZSWZa?=
 =?utf-8?B?R0h5UThiQTNrRXNOYXF2bVBmN3FGcUJTOTFuWFhmczZHU2tWekdtOHpUa0gz?=
 =?utf-8?B?Sk9hZGpCRW0xdFJnQzJTZVRtOFZtUExRSjBGOXlCejB2QWRQbFhlY2ovK2Z4?=
 =?utf-8?B?MGp0SkU1Qnl3OW5CdHlaS1pQOU5tbFREbnNDWUQ0ZnNtT1I2UVpjMVM4RUk5?=
 =?utf-8?B?emFoVko5U3ZNTUhYdWRDcVVYM2NSWXlzREF0MVBlVTVBMlpFN2lQSjhWaVk1?=
 =?utf-8?B?cVJISHVZeTlLUmg5Vk5Md1F4NVB5aVFrQXJSZ1Y4L2pJZGpMbFl3OTZBZDZN?=
 =?utf-8?B?d1hwNTE1Z2tFMXVSeGdSZzhxZzBZNXg1WFpNaTdYVnlENmRsOEdUelQrOWVP?=
 =?utf-8?B?cDlRU292YWprZnB1L1lkeEJKOXhGU29JNWlzZkVuUXBnSUdhN25BVzJLRXdO?=
 =?utf-8?B?N1l5dTVnb1NHQTZWYzhWSE8vbXBUQ2V4Y0wvUDFLRlRsMVl5MzJGU1pQMjFx?=
 =?utf-8?B?MmROWEkrak1CSkEvSG16ZHNLQ1pKK2diMnFwK25jbGVJSFkyRmY3ZkZVZi9x?=
 =?utf-8?B?b2JBM3dmdlJWSFVhQ3ZlNFhwUVJjekw1RGJrRG5yVEVsdUNRZ1U5MllCYzRG?=
 =?utf-8?B?U3BjZ3hzZEpoSG55RFBOVmh6OHlHcGVXMnFvR25iNjRZWHhBRGxBeDB3ZlBW?=
 =?utf-8?B?ajc1bDlmWVdDckx3VDVkOU16dXNib08zcERwMUNLblIwZkRXUkFLVFdjYUdD?=
 =?utf-8?B?NFhvK0E1dmNHZlk2OGo4eEcrS3VNY0VrajZETmlGb1dBOURBME1NUDc4NDc5?=
 =?utf-8?B?TWNNQm1VUy8xeWRHbU03M3dJc0NNK1h2Q2J5TE4wdzE4NjNqeUhhd3NRbEVS?=
 =?utf-8?B?bEphUXgvVGNqVkNkOUNGUnVCNjVwQ05xNkJKS3lhOVMzNCtiOVJQTkR1UlJ2?=
 =?utf-8?B?M2h1QUF2NGlEdUo3N2FGb28rSGR0K3FEN2lxT2l4bGtndG9yczBEb29MbVdl?=
 =?utf-8?B?U0R3WTRSc2pJK2xLMElBY242UzlCdkIwTlp1KzVML1diZlFUeThOR241STJk?=
 =?utf-8?B?RmduMlViOUtocWtQbXZ3UUFjRmlUcWZOc2RVZEZlWVdTNjAzT1lucHhGc1do?=
 =?utf-8?Q?+izLviPnkj1u9nDCeQmiHvvQh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751feae4-90e8-4e18-c344-08daa0d9880f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 22:42:17.5084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AIBbOw8WBf39LDTvA29fk5GLA71o9zuYHwjMj7fLqubN4ZNeSLXpMmPMP4YdXF76SvuoABAOwpaxmYbdzJTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gQnkgZGVmYXVsdCwgdGhlIG1ibV9sb2NhbF9ieXRlcyBjb25maWd1cmF0
aW9uIGlzIHNldCB0byAweDE1IHRvIGNvdW50IGFsbCB0aGUNCj4gbG9jYWwgZXZlbnQgdHlwZXMu
IFRoZSBldmVudCBjb25maWd1cmF0aW9uIHNldHRpbmdzIGFyZSBkb21haW4gc3BlY2lmaWMuDQo+
IENoYW5naW5nIHRoZSBjb25maWd1cmF0aW9uIG9uIG9uZSBDUFUgaW4gYSBkb21haW4gd291bGQg
YWZmZWN0IHRoZSB3aG9sZQ0KPiBkb21haW4uDQo+IA0KPiBGb3IgZXhhbXBsZToNCj4gICAgICRj
YXQgL3N5cy9mcy9yZXNjdHJsL2luZm8vTDNfTU9OL21ibV9sb2NhbF9jb25maWcNCj4gICAgIDA6
MHgxNTsxOjB4MTU7MjoweDE1OzM6MHgxNQ0KDQpTY2hlbWF0YSBoYXMgZm9ybWF0OiAiaWQwPXZh
bDA7aWQxPXZhbDE7Li4uIi4gTWF5YmUgaXQncyBiZXR0ZXIgdG8gdXNlDQpzaW1pbGFyIGZvcm1h
dCBoZXJlOiAwPTB4MTU7MT0weDE1OzI9MHgxNTszPTB4MTU/IFNvIHdlIGNhbiBoYXZlIHVuaWZv
cm0gZm9ybWF0cyBhY3Jvc3MNCnJlc2N0cmwuDQoNClRoYW5rcy4NCg0KLUZlbmdodWENCg==
