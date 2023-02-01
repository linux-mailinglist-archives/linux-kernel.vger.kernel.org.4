Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC442686B60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBAQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjBAQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:16:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12EAB3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675268152; x=1706804152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5JoDQi5pOvmtjzB9SLlB+XhJSTJU5esuEMcWodReKY=;
  b=dtGVf808WFBwGv1v+eR6GUoVdN7+1r04KI5JhIUJ9YrRDCEvsJ8yk9SM
   En5/ppMMb1YVBsjMD3kK5HVJnP5Ng1kwqPOq4p2ECFJ0mOh7DFl//jisg
   5zpnZfIZ21EP0I2Xeg4ehlYGruEB8djXa+GcEN8yRdf/ofrDUgd6504Ar
   6+8Wwwq62MeWzRvFDW8pM+AzOaGVGImu85BaFNCYfwanGQ6QIXBVCI0OS
   IE+xdkO2tdzsiwZuM6PbIs3IWgTlJ2EgdiKoNz0F/DYZnzqV4whfv4EJ0
   EsYGcK7S3UzwqxKPvRLORdPf1ajznT++sknCJXwmNOtCcjRxP81T71TlT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="390576709"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="390576709"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 08:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="838838533"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="838838533"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2023 08:15:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 08:15:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 08:15:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 08:15:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSjz9P1I45kEg1T2OLvDYCYsE6haFyBkWsS13S4I9mczA2N9ucLmpDMiAyxS1IIEhnAWAbmrAvnfN1MGF4IOhNA6u0sZpladPlxX0ArGiLqps1rlz5ypduOW0ieBRuzOjNOrdrxUSfecavxv95ftQogESMByuI61mGzjyyFhjGz+9FSy+ofOj7b3p5p+mrMHb8P62kzzxQqpXX3VGgwFcy3OsRgXhb7g/Ir440Hug/fnVrplSS3G+cOTV/6lc119flS0SdOzzx0wcDMZHAaGDYxngM4f3AFYKc0Rzsn+ZTWPV2H7XBuVo63++7O4KDD1Jf1DPIWI1plchqRdqFYs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5JoDQi5pOvmtjzB9SLlB+XhJSTJU5esuEMcWodReKY=;
 b=GomW3w12Ep44tFaPk6+C8AJtpna8dyXZEYvu0f70oyRaUxIgVv37z0vtkmTaA08aVreVInIx0bIu1KznCHLItJXV8Cn0dSLZLzipjTGco1Nfgx3wpiJTjyFKjWZb/n3pETwBIqWkncyA+99eXxOPmfh1RAkKX+LOLtcVg/ulpITCtSxJwKZvE2UEaITFpDK8QVaFtObsvxXlwmWMIHEoG3pgCvg3OLHrsbpJ8yv0qaK49uwg/YjWD+CfxsOqSPgYRM0kIQvLsYbgNAbta0XJOHVyxWpUB+O2NUtOHhiEyDmDE76wCF26HEGnp5fBeMe1MvZKTcfnKSXugUcaDUeqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 16:15:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 16:15:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Stefan Talpalaru" <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: RE: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Thread-Topic: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Thread-Index: AQHZNPN2NI5TxkYoK0abVR9vY8eccK64vecAgAALhpCAADU7AIAAAMCggAAHHQCAABhvwIAA74UAgAA27lA=
Date:   Wed, 1 Feb 2023 16:15:47 +0000
Message-ID: <SJ1PR11MB60832B131FF4FA87E21C62CFFCD19@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com> <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9l8yGVvVHBLKAoh@zn.tnic>
 <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9mDYMASXCFaFkNU@zn.tnic>
 <SJ1PR11MB608384F3B075E0D2F25683D3FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9pgzGr4MccwEJAl@zn.tnic>
In-Reply-To: <Y9pgzGr4MccwEJAl@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB7615:EE_
x-ms-office365-filtering-correlation-id: e18afe80-0974-45dc-0072-08db046f93e3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ur6+dA/HTaPLaaaLYNPV9886Nneq9rqFeM/nAK0mqrFWuPrAqKFDj/XA1HPmqICoGIVg5gM4LjmuEu4apMEy5KK6kDsmC/GXBZO20J62he6x261TvooUYKhexy5LHO5Gdm/f5jexKQC3GM0q7w4X3OryBUKSVOO708GuiLcPdcT6iXDK25Fc7d+Bg6YrPOqGKdGpAHKDnfD9u/qj8ht57gGFlXob30jIzV3nKFzLH6MGqfJx8icjRZOus6x3lGZGW+3SAV0Iu7ZdICCXLx9em20sc0oXbcbkPhpjOVNi+uyKgZRCLedMCkgZ9XryE4wWdp+wCs8k7GGN99Fc3FIfRpzQRPoxNXERMr0vT0Ffv4r5uXdFF9KUhs07f5RADCJ86dovu0A0U2gwcnKmA3aixu9yGA2cYjS2ju6lOKzxaaMWFFNJULF899WFVbEPaEeVKtZY6++fWqrXnLWZPtpX08osOtm/4gxz9Xenrbg38tX5Kyw0DgYLZ3feEX9LdUvDMbwgH/Y9Gf83A7cU2NSaZM3kWIoNu/ES8UzrezAuOupVJdEYXH4fDN2meNCeVxexy7r0HtHBxsnNIOWVFznpyzxND+s0kb6FPvanCrkXrke4w6jfBozs5br5hDcH0YYsh5Olm/IqauN1GiTp+EFx+QGCIEc0Jpu094SDvBTUV9VQBE8NBJXxW5ZbHqRyCgnDalXHoQgp0Ybfxv34P2KqZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199018)(4326008)(41300700001)(55016003)(83380400001)(86362001)(38100700002)(38070700005)(82960400001)(122000001)(316002)(66446008)(66946007)(6916009)(8676002)(64756008)(66556008)(66476007)(7696005)(33656002)(76116006)(26005)(186003)(9686003)(71200400001)(54906003)(478600001)(6506007)(4744005)(2906002)(52536014)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVphdjMzVm8yYWk3M2FTclc1MkNrVUk1T1ZINHQ0ZTlUUHNaQTBwSWZQWnRq?=
 =?utf-8?B?U2Q5SW1NTk1nK3c3NmQyTmhxaU04cktzKzc0WHNiUGJJaWVQWWM5K0hvQW5S?=
 =?utf-8?B?TDlVN0YrY2hoK3NrejJnZjIxc2R5ZXpvUTVOS0R0UEo1MWZJeW5kbUNBaHB6?=
 =?utf-8?B?M0VJUm9zNmpYZksxaDFBTkw0azF6NG05N29tQU9oZzNMU1kyUUZwdW9NTHJD?=
 =?utf-8?B?RzgxMHBqUHF5QXBBcE02eldwd1BYSGQwY1IrQVFGTDNMYmVjcFhPUkJWVHEr?=
 =?utf-8?B?U3Z0Q0RFdEdPbnR1aCtMVEZQSS9RT2NCL2NNYjBhcnJTaGdYU2FmNUpob24x?=
 =?utf-8?B?YzZRK1RWSFlpWWxOQlpGRmZZVVpWMEJKUTYvNGk2K2hkaWhHRHdqUUdQSmYw?=
 =?utf-8?B?RXlvS05ndktsRmpGTjBFQWM2RE1tQmVUNkNldHoxTXF6cm5hMGJCRWlWUVdE?=
 =?utf-8?B?Nk16VVNmRFZjMlZDZXJUWVhIbzFybVlDVmJjb2V3Y1FPZ1FlbE9JNkwrTlpC?=
 =?utf-8?B?NmY3cnNuSjRqd0FZOTQrbU1IOU1Qc3JJUjlWZnNnSVgwRTNrYjBxTXJXK3NC?=
 =?utf-8?B?UmxSd2d4Uk1EV2pMcXFWYmhxLzl3Sk9VUWhLclNGMUdqZnczanNZTHY0UnMx?=
 =?utf-8?B?dU9NUEp1WlE3eHFDRWpWRU1tck1JQVBPMVdLQWpTVGpLOHZqN01TZUxiTjlI?=
 =?utf-8?B?QSt0dnUyS3VhVFpNSUNwTFFMamxpQUxSSmpBTDRPa0tqTXVVMmlvdjhLdnZT?=
 =?utf-8?B?dE9YN2NhVUVpMFdzTDNMMDE2WVRuUlZCeXFObE1vTHVmdGtHd05DeXVpY21T?=
 =?utf-8?B?dzJtaldzWCsyZy92RmkzVXFCQVQ5QzNYeUJDcktqQitYSjVZZW5hdmJHS1Nu?=
 =?utf-8?B?dVJTUy9Ed3h5dGU1ZUtBeGcyY3RJL05YOWJzUUlzRG1nUFRRR0FEcWFaNHMw?=
 =?utf-8?B?eGRMWU4zQzhZemJJM3ZURTlrQ0toeHNhMENXTEpUMldubXhib0VCQ3R5b3Ja?=
 =?utf-8?B?cTNTUVlIbXJIQlFrb0o5ZldkNjhrcXdIN3c5Q1hacHc5SDJBbUN0NzNWOS9v?=
 =?utf-8?B?b1hQSkpvbTd3ZUxkdW9YZnk2aWNXc3hsSFpXbHRVdWNOckxjcVhhNndubG5N?=
 =?utf-8?B?cjVhdmRmYmtnWVRNS1JjY0QvRnFYNzZDZHpaMWhoYU9QWXZJMjZTYkV3RnI5?=
 =?utf-8?B?VnZUNXh3TjRqdnRDRUpGOFZld1dWVzhGamIyWS9TZGQ0d1FjdzFRRGIrWWJN?=
 =?utf-8?B?b2tvMXhRZ3lzSHlpRGhHVVR5SWJZWnFVaFFDZE5CRlMzZFFPQVBIekF1cGEy?=
 =?utf-8?B?dmU4OENWK3VmTGsyM29Kd1FoRWtMOUs4ZkVFK1Y4Z3czcnNySHliM3FXRGdJ?=
 =?utf-8?B?WXp3RFk3cUdBWVVNQkdJUThlVS81QzhCK0Rxc1NNWWRZY2NyZU5sK1VOSDhp?=
 =?utf-8?B?N3V1bEp6VmpKWHE1RE9LL1ZIOXp2RTFSWnIzTlBPKzhHUHVOeFZPdUxYOG9Q?=
 =?utf-8?B?MEREM1FvVm44dzRuVW9WaHlsbFJnRG1sclh1WG1sR3FYUSs0OVhSdTBseXRD?=
 =?utf-8?B?VzJmSmtPa0VtZHZlYmcvbUVlZExIQnlDUEtMWFJjWm40TWkydk5mbytFcDF1?=
 =?utf-8?B?ejBZVnhFL3VoRVdUZ2FUNnRGM2RXYWdzSlRrYXhOWkZFRjdsRHJoc3VkZEtx?=
 =?utf-8?B?YWVyeUhKcE41aFdNd09EWWZXcWxDc0RxYXR6TkRaaERsTHhtNFR3SXJ1Nzdr?=
 =?utf-8?B?QVpkVnJ3NkdTUjVTaENiOERjWTNSYlhDamdCdTBtdExDaEFldU1JUGdrUEJx?=
 =?utf-8?B?N1Yrc3dsQkVycWtBZGd2Szg1d3lnaHlyMkRWdi9kMHBsZHpoUXQ2QTROeTRH?=
 =?utf-8?B?T28wZzdDa1JIOU1YTHh3OEVWTmwya29ad1YwbFBGaENLUHpMajJBeW4zQW16?=
 =?utf-8?B?NWdybzRabWFVazdkaHVEN2pkU3dHU0VLa2NsL2NiRWE1SXRBRnl3azJTdnIr?=
 =?utf-8?B?Q1E4akUwRklUMzZVdUtYbVl3RFVNV1BpNlFlbUh2ZkhLMk1OUjNJd3FaSTM0?=
 =?utf-8?B?NU00Y1dHbzVZYmhBOFF2VzM3cjhNbDh3YUNwQ213MHlXNE5uM1NISS85UVJp?=
 =?utf-8?Q?THbRN7Q/YnTOzVmexQkv8m+xz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18afe80-0974-45dc-0072-08db046f93e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 16:15:47.1753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhjtB2ljt8BA6W7himfTKn6Vtt8DGuJYIeEYkfwB3PUPMbVS48AMnnqBkQ4mHSHwnoHR4JpkgIn5UhvpiRkddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTbyBmaXJzdCBvZiBhbGwsIEknbSB3b25kZXJpbmcgd2hldGhlciB0aGUgc2NlbmFyaW8geW91
J3JlIGNoYXNpbmcgaXMNCj4gc29tZXRoaW5nIGNvbXBsZXRlbHkgaHlwb3RoZXRpY2FsIG9yIHlv
dSdyZSBhY3R1YWxseSB0aGlua2luZyBvZg0KPiBzb21ldGhpbmcgY29uY3JldGUgd2hpY2ggaGFz
IGFjdHVhbGx5IGhhcHBlbmVkIG9yIHRoZXJlJ3MgaGlnaCBwb3RlbnRpYWwNCj4gZm9yIGl0Lg0K
DQpSYXJlLCBidXQgdmVyeSByZWFsLiBGb3Igb25lIG9mIHRoZSBzcGVjdWxhdGl2ZSBzaWRlIGNo
YW5uZWwgbWljcm9jb2RlDQp1cGRhdGVzIHRoZXJlIHdlcmUgc29tZSByZXBvcnRzIGZyb20gbGFy
Z2UgZGF0YSBjZW50ZXJzIHRoYXQgdGhlIGtlcm5lbA0KY2hva2VkIG9uIGEgV1JNU1IoSUEzMl9T
UEVDX0NUUkwpDQoNCj4gSW4gdGhhdCBjYXNlLCB0aGF0IGxhdGUgcGF0Y2hpbmcgc3luYyBhbGdv
cml0aG0gd291bGQgbmVlZCB0byBiZSBtYWRlDQo+IG1vcmUgcm9idXN0IHRvIGhhbmRsZSBjYXNl
cyBsaWtlIHRoYXQuDQoiDQpZdXAuIHdoZW4geW91IGdldCB0aHJvdWdoIHRoZSBjbGVhbnVwcyBh
bmQgdGhlICJtaW5yZXYiIHVwZGF0ZSBBc2hvaw0KaGFzIGEgaGFuZGZ1bCBvZiBmaW5hbFsxXSBw
YXRjaGVzIHRoYXQgYWRkIHJvYnVzdG5lc3MuDQoNCi1Ub255DQoNClsxXSBZZXMsIHRoZXJlIGlz
IGFuIGVuZCBpbiBzaWdodCB0byBhbGwgdGhlc2UgbWljcm9jb2RlIGNoYW5nZXMuDQo=
