Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919C6CD53C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjC2Ivh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjC2IvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:51:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13DE46AB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680079858; x=1711615858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p27OYVSM5NKOHb78h8DiZOaCb223/7MxcdJGNmNOyUc=;
  b=Qs93cW2eGYMYB4rPfDQzQA6fjBma8ntq5CbZuQzFcBYl4MmdBgB2k5/Q
   cGvC7lpN48Va2WHNwyVnuqMQQ8kfxGI8XN6xDYTCSwA/49IDAXq7vNy4U
   mvUq8RAD5TDDYA7040mdltDG0m52xq+7cRpPcWIzd0KwheEIKelTWBrhP
   NNKuXDXNR2x0iyF8f0+VNtyuE1oX2yUNC1CIDrGxPEd15K06lvC/c/3IM
   Q3PaZPw1NNsuH9Sv3g3LFw3ZlIDTppMuKJCBkWmrmnkxjj4VqF6GRq99b
   QWozPgUqm/c3tW5wkLL/WvPE8AplSxolO3xdljdmPceAA8HKJ304uV4Yv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343238324"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343238324"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 01:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="808117452"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="808117452"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2023 01:50:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 01:50:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 01:50:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 01:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhFeIkN/J02sNsR06dr1ahzrSN3z+mNkVSjm24rEqYdvmgQXmoN9FKTqOgAM2k5PYh++7ID/Z8sfsaq0RCCBco2Y+32Cdj4fB7JOjNONbrbffE52LyZW0j8BjUbuKZMazwHg63kRI7uDgPEFdLWrrhQ0SXYVDG5oL/HjEOonG/Sa/9QDNoBBiOnYkN/MbYdpneolt1v3Ev0Tr8hQc6dMi7l3wRVBY8qT1Oih5qH43ciRHWl5mTQ4mws3UsINKET7cwgpjFc0iVMqBUWRHpUbDQS/qsrqy01oN778kgomE47HchbHmHVCTTAFCJul4kaSRArfFo+VX8tK2gAbja+VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p27OYVSM5NKOHb78h8DiZOaCb223/7MxcdJGNmNOyUc=;
 b=b4C8Y55TMBvValpvMp+iqvSmGndBBIhb2vooryApqNE1jyN2KTXAh9JNpninWelz2vCZyEUMASoyRVY0Qz7DSdM5X1fvoR5wRlfeBIQqQJIAAvTEnaQmKz3SC1dwO1v+0qliJKkFJtYctwg6kOllPOdaGa73BwYDVrvZCfO6y6NBALiKOb8QeExImC3GaGVzfcJMoEWauFHv0pPWWsij5H+vDfV//WOYhSYD4CSkvCeHpneFBcOdsdwBaYEmWtfLWqqipMBD3R+coo5/1vHeFESqR/rSlBEMwtu3L4dHX1z1IDC5XkeIvC6qf2gwDaHDJXT8yIdEyC7ZruQvNa/8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 08:50:47 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7%2]) with mapi id 15.20.6222.030; Wed, 29 Mar 2023
 08:50:47 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "Kang, Shan" <shan.kang@intel.com>
Subject: RE: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Topic: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Index: AQHZU/pnrQNA4Qs8TE+zA+Udtp/Txa74104AgAAkKCCAGIjwgA==
Date:   Wed, 29 Mar 2023 08:50:47 +0000
Message-ID: <SA1PR11MB6734735DD3637E302DC155FFA8899@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230311084824.2340-1-xin3.li@intel.com>
 <5e84fd48-459d-8850-d26f-860c6d34a9ad@intel.com>
 <SA1PR11MB6734CF1607F263CB8389F5F2A8B99@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734CF1607F263CB8389F5F2A8B99@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA1PR11MB7174:EE_
x-ms-office365-filtering-correlation-id: 31d2438b-d67f-41bd-1c38-08db3032b0d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krvT6pne5FeiQKyNQvlkfZ4pxripCF8yaaUTNQuFXpV5ZLt9k1eF/n9Y75Mkn1Ifod9zpUsUXIeD4gc2azetKBDTRMUQiQDQvekf1t2eGjHreI/go3piU435lDcx3Q7hjyq0oTPx5xYnlDVM68fkMMx6cU3JFSuHPqS9qfoiBf5dN0n/DeJsdDDp+sbZ1ExM0Q/M7rtviOpodBpzpLk3PFPQ50Jts5ZPXRMPL7OOVKhg1rFRNPV/Py+5W150dxekw/N/41zymU6WLQjWaWVlQGmolFr6wp1OsHg8figmJTlT9/I3C7zoc3L6RKzo1q2Y4jc6LQbnPwJWXsc4s0rm7JGBq10bSH2zBzstoR58mJ52U2sLoa2RdsyAXqGUGjG2fB15cl4CLNMCluvWDARShFVVYezStoWMAr7LmpwmKV9Z7MUW31dw1hijFLCKr6OHVSN1s0jOHjE5QkfpZSmN+bjG/ui22gegHmoPQdDkisc4wsXOFt8YADSvx03PXkVbq0waG2F0Dof/xEk3fkjPF8e4ziaQlU3r1UN8M4jkVIWO+eFaC6Ek5xXhi3YKZed5wCtITaJNvy8wRG/DBPGO8na2MnkTJrzzuCcr56SSDNcdOsoxfsYWb7Z/elyZGZ3s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(86362001)(83380400001)(71200400001)(26005)(2906002)(6506007)(316002)(33656002)(4326008)(54906003)(7696005)(478600001)(110136005)(9686003)(66556008)(38070700005)(64756008)(5660300002)(8676002)(186003)(38100700002)(66476007)(66446008)(55016003)(8936002)(76116006)(52536014)(122000001)(66946007)(41300700001)(82960400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjVqZGs2eXJqc1RxTEx1NjVPV3hOODk2MW1oRTFPVE9HQmJhaDhLRGViN0J3?=
 =?utf-8?B?N0Y0VE5RNTd1SUJOSjRpSWwyVDN6Zis4YmNCYUc4UW5ZdnJyTld0OUs2MnBJ?=
 =?utf-8?B?akVMdmxoUTdGdk1hMU56cDRMYnAwTndwMHJGK3RkWVRvUlVicGVJL1ViQVgy?=
 =?utf-8?B?d0x0ZEJhU0FzR29iUWZDMXdDKzluTS9wOXA2MUZyK0JzaWlHbTV4Z2VCL3NR?=
 =?utf-8?B?eXVmSktYQnVEeWdsdHkvZlpWNmQrQTJCMHE3dDE0dFg3cWRZSjRvU3UyVVlD?=
 =?utf-8?B?cUJrQS9KYTZiWXF1UVcvSmp0dUVCYzhPT0FXQkJCU0cyaWZkRWhWdEhSQkRh?=
 =?utf-8?B?SGIrYk9haUV6M1pEMURQaVBid0RYeWFmMU1kYWJjbnpEcUh2UldONVpKUUhp?=
 =?utf-8?B?dGxMUkdPZ1hocHVzM1Q4bHJmTkpFaGZPc2szUHoxa2pyWEYvbTlZOFhZRHUr?=
 =?utf-8?B?WXIwLzAydU9MU1VseVFPV3Z3OTJmZFVtM1BJUWpxeDBLK2xFY3VacHhEcFdC?=
 =?utf-8?B?VFZRSFdrSEZEK3VnRm9rRWIvTSs4eTZtWjNhNVRFQnBsSFdBUURLdVVDcXdv?=
 =?utf-8?B?cDNLVjU3Z0ZxdXAvbHRtTFdVMktnYlRwN3RwUEJlamszZThUVjkvbU9OWmlF?=
 =?utf-8?B?aWhEbUZYNi9xUkt3dzNkQnFyUVpyWWNoVENER2drWHFpY3pic2NJd3dYTjYw?=
 =?utf-8?B?NitqNFFkcTlJcVRQVFo0L0NDMDgwdnpNd2pNOGJZRmJ1R0p2MWNVRmU0N2NF?=
 =?utf-8?B?ODlBNG9ROGw4akRKQjB5VlpQNEo5SG8xa3p0R1FzSXczR1FKVzdvbG1LZi9h?=
 =?utf-8?B?OXJlbzQvbDFTTXd6T2xZWXZnRVo5aHVla3Fnc2lEcmVxUktnVDU1RjFLdzUx?=
 =?utf-8?B?RlErS2JLSlJ0eld6dTNrMWptakF5M0V2aEsyalNrY2VTeXNnWSsyMWFUNjRl?=
 =?utf-8?B?QkRjMXBxYTc0VG5XR0V2amlCdWNUeTh3eGpoVmpxRmVobE5lTTQ5L1FMc04w?=
 =?utf-8?B?QTBiWVBFWVl5UHFTN2drbC9qcDdGdFpYNnhUem5FYkNHZThWeXFETHNveE44?=
 =?utf-8?B?NXJPUTZtOHh1RjQ3ZHVMU0I1MmJOYTZUSGlzQnZVeS9tZkFCVjdydXBia2RG?=
 =?utf-8?B?VWlRcnhXQmJzUWsySlhOZlZsUWVUVjZrRHRoak5yaTBYM0p6dGVHam1VeCs1?=
 =?utf-8?B?Tzluc1hIclVpeGRjOHhldFJhZWgwa0hJUHlOOFJHUVQxU0JzK24zM1lrSFkv?=
 =?utf-8?B?TUJ4cGN0RXV2aVRtMHRJUnpJejRobW1Ja1Y1RFFnYS8wMVZGTHpGUXpZbTBv?=
 =?utf-8?B?ZmMyUjVLYTZ2WWdsd1Q2K3V1QWJjQXFUZWY1N2loQ2luOFBzQUJyRkgwY0xw?=
 =?utf-8?B?alFvaUxrQVhsK2ZMOGVISkYyY0ExQmZJR1RTN09HKzZ0MGh6V2x5WW1vYzl4?=
 =?utf-8?B?UXBXYTd3WjlDNzBnazFteS9FdEVHMmlyWkdyemlFeUlUVG5lemsybEcwNk9z?=
 =?utf-8?B?ajZwRzBRZU04VUltN1JMNUdZZmxXeTlOaUx1Tlg0djF1RWdkY2xZWWZRQXU4?=
 =?utf-8?B?UUtPS1hoL0hEaFFYaHR5RW1SL0pVOENMVXZQZzNFTUdBQ09XU3BieWVzcFo1?=
 =?utf-8?B?T3hhNnlpR2JIVHNnckNSUVd1SUtDUVg5YlNCTlM5eWtEN08rU2JPSmJUalcw?=
 =?utf-8?B?Vjk3UThtSzR3QWcvM2tYVnloR01wU1NteUdCMHFtMk5YVG8zNk9JZ0dJTGY0?=
 =?utf-8?B?T1dWSGVKT1FobVZVQVN2U0lseGlNblhuaG1VamkxMHd1WHl1WVNVajJHcit4?=
 =?utf-8?B?ay9Za2w3V2p3Ymw4ZWtRUEMyVGFBU21YTkJqS0dFT0VlbkFOT1ZaSVI5Z3dB?=
 =?utf-8?B?Ym1IUDFXVWoyQ3owMkY0UVI5eHV0VTdtMVF1cEVHb1cxdkkycS82YXFEVFl6?=
 =?utf-8?B?ZjFBYml3R1V3MDVhR3dadUh3RzNlVHdKclJUZjREUmdXN0dTbXZodmVhekhp?=
 =?utf-8?B?Rk96aHAzL1VaNU9BQnlpSmxyakxLRGV3NzFzQmtKQk1LUmdsb0hmRTVqTVBs?=
 =?utf-8?B?cVZNeXErVXk0eTB6N1p4Z01yR1RGY3dFc2lDTjkvSjIwSlVINVVUTG9Pb2tQ?=
 =?utf-8?Q?7x08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d2438b-d67f-41bd-1c38-08db3032b0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 08:50:47.5704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilYSn8P02KI9GAJWNuB6T4Prk/C1zEf8JYLjcCjpwMcQYxZZ1AGJ/fmywnlxCYRyRBuu65AKZs3z1ZkF5waXGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGksIFhpbjMgPHhpbjMu
bGlAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDEzLCAyMDIzIDEwOjQzIEFNDQo+
IFRvOiBIYW5zZW4sIERhdmUgPGRhdmUuaGFuc2VuQGludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IHg4NkBrZXJuZWwub3JnDQo+IENjOiB0Z2x4QGxpbnV0cm9uaXgu
ZGU7IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsNCj4gZGF2ZS5oYW5zZW5AbGludXgu
aW50ZWwuY29tOyBocGFAenl0b3IuY29tOyBiaWdlYXN5QGxpbnV0cm9uaXguZGU7IExpdSwgWXVq
aWUNCj4gPHl1amllLmxpdUBpbnRlbC5jb20+OyBLYW5nLCBTaGFuIDxzaGFuLmthbmdAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDEvMV0geDg2L3Zkc286IHVzZSB0aGUgcmlnaHQg
R0RUX0VOVFJZX0NQVU5PREUgZm9yIDMyLWJpdA0KPiBnZXRjcHUoKSBvbiA2NC1iaXQga2VybmVs
DQo+IA0KPiA+ID4gKyNpZm5kZWYgQlVJTERfVkRTTzMyXzY0DQo+ID4gPiAgI2RlZmluZSBHRFRf
RU5UUllfQ1BVTk9ERQkJMjgNCj4gPiA+ICsjZWxzZQ0KPiA+ID4gKyNkZWZpbmUgR0RUX0VOVFJZ
X0NQVU5PREUJCTE1DQo+ID4gPiArI2VuZGlmDQo+ID4NCj4gPiBJc24ndCB0aGlzIGtpbmRhIGEg
aGFjaz8NCj4gPg0KPiA+IEZpcnN0LCBpdCBtZWFucyB0aGF0IHdlJ2xsIG5vdyBoYXZlIHR3byBk
dXBsaWNhdGUgdmVyc2lvbnMgb2YgdGhpczoNCj4gPg0KPiA+IAkjZGVmaW5lIEdEVF9FTlRSWV9D
UFVOT0RFCQkxNQ0KPiA+DQo+ID4gaW4gdGhlIHNhbWUgZmlsZS4NCj4gPg0KPiA+IFNlY29uZCwg
aWYgYW55IG90aGVyIHVzZXJzIG9mIGZha2VfMzJiaXRfYnVpbGQuaCBmb3IgdGhlIFZEU08gc2hv
dyB1cCwgdGhleSdsbA0KPiA+IG5lZWQgYSBzaW1pbGFyICNpZmRlZi4NCj4gPg0KPiA+IEkgdGhp
bmsgSSdkIG11Y2ggcmF0aGVyIGlmIHdlIGRlZmluZSBhbGwgb2YgdGhlIEdEVF9FTlRSWV8qIG1h
Y3JvcyBpbg0KPiA+ICpvbmUqIHBsYWNlLCB0aGVuIG1ha2UgdGhhdCAqb25lKiBwbGFjZSBkZXBl
bmQgb24gQlVJTERfVkRTTzMyXzY0Lg0KPiANCj4gU291bmRzIGEgYmV0dGVyIHdheSwgbGV0IG1l
IHRyeS4NCj4gDQo+ID4gQWxzbywgYWJvdXQgdGhlICpzaWxlbnQqIGZhaWx1cmUuLi4gIERvIHdl
IG5vdCBoYXZlIGEgc2VsZnRlc3QgZm9yIHRoaXMgc29tZXdoZXJlPw0KPiANCj4gV2hlbiBsc2wg
aXMgdXNlZCwgd2Ugc2hvdWxkIGNoZWNrIFpGIHdoaWNoIGluZGljYXRlcyB3aGV0aGVyIHRoZSBz
ZWdtZW50IGxpbWl0DQo+IGlzIGxvYWRlZCBzdWNjZXNzZnVsbHkuICBTZWVtcyB3ZSBuZWVkIHRv
IHJlZmFjdG9yIHZkc29fcmVhZF9jcHVub2RlKCkgYSBiaXQuDQoNCkhpIERhdmUsDQoNCkhvdyBh
Ym91dCB0aGUgZm9sbG93aW5nIHBhdGNoIHRvIGFkZHJlc3MgdGhlIHNpbGVudCBmYWlsdXJlPw0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc2VnbWVudC5oIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vc2VnbWVudC5oDQppbmRleCA3OTRmNjk2MjU3ODAuLmQ3NWNlNGFmZmY1YiAx
MDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NlZ21lbnQuaA0KKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vc2VnbWVudC5oDQpAQCAtMjU0LDcgKzI1NCwxMCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgdmRzb19yZWFkX2NwdW5vZGUodW5zaWduZWQgKmNwdSwgdW5zaWduZWQgKm5vZGUp
DQogICAgICAgICAqDQogICAgICAgICAqIElmIFJEUElEIGlzIGF2YWlsYWJsZSwgdXNlIGl0Lg0K
ICAgICAgICAgKi8NCi0gICAgICAgYWx0ZXJuYXRpdmVfaW8gKCJsc2wgJVtzZWddLCVbcF0iLA0K
KyAgICAgICBhbHRlcm5hdGl2ZV9pbyAoImxzbCAlW3NlZ10sJVtwXVxuIg0KKyAgICAgICAgICAg
ICAgICAgICAgICAgImp6IDFmXG4iDQorICAgICAgICAgICAgICAgICAgICAgICAibW92ICQtMSwl
W3BdXG4iDQorICAgICAgICAgICAgICAgICAgICAgICAiMToiLA0KICAgICAgICAgICAgICAgICAg
ICAgICAgIi5ieXRlIDB4ZjMsMHgwZiwweGM3LDB4ZjgiLCAvKiBSRFBJRCAlZWF4L3JheCAqLw0K
ICAgICAgICAgICAgICAgICAgICAgICAgWDg2X0ZFQVRVUkVfUkRQSUQsDQogICAgICAgICAgICAg
ICAgICAgICAgICBbcF0gIj1hIiAocCksIFtzZWddICJyIiAoX19DUFVOT0RFX1NFRykpOw0KDQoN
CkFuZCB0aGUgdGVzdCB0aGVuIHJlcG9ydHMgQ1BVIGlkIDQwOTUgKG5vdCBhIGJpZyBlbm91Z2gg
IyksIHdoaWNoIGNhbiBiZQ0KdXNlZCB0byBpbmRpY2F0ZSBhIGZhaWx1cmUgb2YgdGhlIGxzbCBp
bnN0cnVjdGlvbjoNCg0Kfi9zZWxmdGVzdHMkIHN1ZG8gLi9ydW5fa3NlbGZ0ZXN0LnNoIC10IHg4
Njp0ZXN0X3ZzeXNjYWxsXzMyDQpUQVAgdmVyc2lvbiAxMw0KMS4uMQ0KIyBzZWxmdGVzdHM6IHg4
NjogdGVzdF92c3lzY2FsbF8zMg0KIyBbUlVOXSB0ZXN0IGdldHRpbWVvZmRheSgpDQojICAgICAg
IHZEU08gdGltZSBvZmZzZXRzOiAwLjAwMDAyOCAwLjAwMDAwMA0KIyBbT0tdICB2RFNPIGdldHRp
bWVvZmRheSgpJ3MgdGltZXZhbCB3YXMgb2theQ0KIyBbUlVOXSB0ZXN0IHRpbWUoKQ0KIyBbT0td
ICB2RFNPIHRpbWUoKSBpcyBva2F5DQojIFtSVU5dIGdldGNwdSgpIG9uIENQVSAwDQojIFtGQUlM
XSAgICAgICAgdkRTTyByZXBvcnRlZCBDUFUgNDA5NSBidXQgc2hvdWxkIGJlIDANCiMgW0ZBSUxd
ICAgICAgICB2RFNPIHJlcG9ydGVkIG5vZGUgNjU1MzUgYnV0IHNob3VsZCBiZSAwDQojIFtSVU5d
IGdldGNwdSgpIG9uIENQVSAxDQojIFtGQUlMXSAgICAgICAgdkRTTyByZXBvcnRlZCBDUFUgNDA5
NSBidXQgc2hvdWxkIGJlIDENCiMgW0ZBSUxdICAgICAgICB2RFNPIHJlcG9ydGVkIG5vZGUgNjU1
MzUgYnV0IHNob3VsZCBiZSAwDQpub3Qgb2sgMSBzZWxmdGVzdHM6IHg4NjogdGVzdF92c3lzY2Fs
bF8zMiAjIGV4aXQ9MQ0KDQpUaGFua3MhDQogIFhpbg0K
