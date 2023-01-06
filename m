Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466AE65F864
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjAFA5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbjAFA5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:57:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418153C0C0;
        Thu,  5 Jan 2023 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672966635; x=1704502635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SJbNO9o7zAKVnIVu4UmLjWU7zY+cyt9OQwmY0MCnCxo=;
  b=oHYBRnchT1ZltU+M7l6/+xdxHEacJsYapDaFswNkvyHIe3IU6kCo7x7S
   vAGvPR5iJ0a6uihhDLeL62e3kpzL8//9nAcL6MmFauenWN2+nAoaa4juC
   1h7CP9hBdZjTiQhpEmmeKnH/hzWdCDPKpgnXxwVJThwWAuiGsfYXXTBl5
   YeyFBFFQ7xbyoLovQVyr9AS1LX31W5hYPbyYulO79sIPl3BSlCXB9L4Tf
   Wvre9JjSY6pFl0F4xLVdSFigfbRRscWI7D8TwDvYOo/2NmRgpEJdcSqTY
   TbXK9qmV9Y+UHtnv17CS7siJCo6m6bJip8irPPcoA7eHEwUiwkH4XDiDo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="386814784"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="386814784"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 16:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="724271130"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="724271130"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2023 16:57:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 16:57:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 16:57:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 16:57:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHMXXijeDstVIK4kwaCuUzR7ozpAhg3qBltNZX94Iapx3KG6XguwIRKD2VikYb7NFe4AoKMO2tzKQODq6DfXVn6qFd42lBKWjulxR4F4LuvElYwqvn62p1IfSWlM90GoJCoBSkKECsvQ5qLhWl4ROL4hvzXELXPYBtITuXdxd42nybolF4wiNs4jxXHbsLVL2rLa/lT1JerVuEGk20VGV8lldhrVK0+eh+lK/A3+e2ccxCrNVNYvltiHHNmH0MF9i4S9iK5J8/C4MTRfTAt/AN21eXCfkKWz7Sm8mErVrWitz4dYnZqkr9aOj/BlCFl+7MqwAjDbZk/Fen9jqrW5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJbNO9o7zAKVnIVu4UmLjWU7zY+cyt9OQwmY0MCnCxo=;
 b=Ok2qVBmlZlRPCY0iQ6FDrutiTTMm42cOKYXlYT3kWZAwZxas0WD7EYRyYtDXq22KUF0ECQpNJ3sJ5dOuggZiC1ZRZCaFSCDvTY46CNcvbNhGNcMyXDuEJMb8kfvQFIFpX3M8tsUwdJGeT9kfjF6DMxjjnCBqrF38jCa+00dOJepnwaIccAk0klQruNJocv20sh1+p3xpB6ukP8SnJCmIosL3sB5ZIEPZehAR4ig1uh1TPOFbQuWfBAV2M6laM7OKOVuLQZBB46isTufBJASfIJsTt17L7TyyWWN0PoqDL4IQFA+g9MP2foFSYK/8Q8NoEVzFdO8BKWnB1LdMldqHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 00:57:10 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 00:57:10 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "kvijayab@amd.com" <kvijayab@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "leo.duran@amd.com" <leo.duran@amd.com>,
        "bpetkov@amd.com" <bpetkov@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
Thread-Topic: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
Thread-Index: AQHZILvrWJ1PbDvlWEGhjI+YxWN4066QD52AgACCggA=
Date:   Fri, 6 Jan 2023 00:57:09 +0000
Message-ID: <caffc8e729a4f8240f9d9cd025bbc9f05ca19217.camel@intel.com>
References: <20230105041059.39366-1-kvijayab@amd.com>
         <CAJZ5v0g1Mu8ip68one_gsAR3xmyua+6m1uJqb3n92xxYWeR+FA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g1Mu8ip68one_gsAR3xmyua+6m1uJqb3n92xxYWeR+FA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5595:EE_
x-ms-office365-filtering-correlation-id: c0d82681-5650-4c42-eeb6-08daef80f0b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IOYXcXlLOvIJ/3YzXX8F/F2QV9r7dNlZffnl7uSEZ5LZKS5ku4h3Xw4WbGDkYDrpGyM/nCNZ23RGCArPJmrLm5sxyQ4ZEtbTT3CRpvAzXhlJEFS0QeFVez3nLSELuQVo5TbJMyvjHXSc0ou6R7GTjDYVwVCjTty7p4yRbSIwC5ZzAZ7jMMk8wBoA2obNa3VCffV1nw0kvrhrthTWztmmN1IuSnAcFd/Iiu4oXjx8Vy9IdPFAMoNtgPtdv8vkGfsMJXIz7cR2Ey3mDf5TKngFRb1HY7AtOdmQkprDEwLLS4g0fbX1UIsr9B1IJ2NitifhCy29+GeQFHYeSI6kXLuArEI0o98Ad7KkYb7ElL3LQ2IvPErpQAHtwXBp5Q1tu5lUza4Pxm2TmbXX8Pz//Q8wcQG5xEXAKToto9LrnaNX1xJi8Nf7Z4AsyG51OXrvo/KjaRQIK1qi4NJI5qjmKXcsC+675boK/GzHosliAnEygERg43d5wInxSpUYXU/NcPkc4APqAikZo+Jo49ZYIR/aUJYtuwIIyD//GEa+1BybIn3LHKNeB68+Oe1liQm9c89zTwMkEipgELJoHNt2cnORPz9CYLfENLNAVgtDUr0IdReXIH5cUfGoO4z2+lBxdy3JUVzAKMQ8AGwNMZrzuvzt9LYT+pr4xL8XM2Hbhs9Xw+lS7reNMzfjGS1yN+cLJjt/YH6c1qOncTo4uxVOHCRXTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(6512007)(6486002)(71200400001)(26005)(186003)(6506007)(7416002)(8936002)(122000001)(83380400001)(478600001)(54906003)(4326008)(2616005)(316002)(66446008)(66476007)(76116006)(66556008)(64756008)(36756003)(91956017)(66946007)(8676002)(38070700005)(41300700001)(82960400001)(38100700002)(53546011)(5660300002)(2906002)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzcvbEdmby8zakF1WjM5STVRTHRXZjdvQU1WUWNxMndvM2tMeGhucFV5OGVt?=
 =?utf-8?B?VFhPY2ZhUGJiT290TEdYeW1rcG92K0ZReklDTXBtdUNGM2d0UllwdVgzVkdn?=
 =?utf-8?B?WWFlZ2FyQzNsUkRaT1JhVVowZUo5T3BqVXRIcmo2STVOdkxRWnQ0NmlNT3RG?=
 =?utf-8?B?NGFEa2FZR1Q2SW9Pcm5EdWdrbDRMaHBwTWJNSlg1NkVtbVJndGRaOERXRk94?=
 =?utf-8?B?dUx5QjM0MHU3UGxZRXhlWVp2WnN2eEZjRkJHSzVGT1VKeW5kVXJ5Z2tMM3JB?=
 =?utf-8?B?QlB1bEsxTHFVcm5sTGlKQW9naHZPOWRzemVOdUUweHVVN0llaTlQazRsUGpq?=
 =?utf-8?B?amJRQjRTTWNJL0ZockJpWW1vekx1ckpuUkpTU3Z3aVFHbkVGeVpHZkZqTE5H?=
 =?utf-8?B?c3RiNWZYS0J5ZHNSN3JQZFpiM1dZSVJEWXpjU1Q1TUdrN1hUaEduSXRpeHF4?=
 =?utf-8?B?bkZaSldEVHdZc0VQdTZaaTIrYU9UNXB1eTZua2xtQTNBeG1CZGFWM0VUN0pm?=
 =?utf-8?B?WnNYbTJwaEV6dHpiakl0TEp0NFNZVTJHMEpUWnFHbVhTRzZTNTdXMnVHZ3NH?=
 =?utf-8?B?d1YrQm84ZTRVc0srRThOTEl3ai9jem9qZEdIYWFmLzRnS2xEWHJIK3FVM0xL?=
 =?utf-8?B?YVZKekN1RWhiREttYUgwbU8wSlpzLzdWcmVtM3dCYnhqcW53OXh6M21ZcUl2?=
 =?utf-8?B?UmU1a1VpeWRZd1FPQnpNU2JkeWlrcXlKL0lXL1hoL0RLNnMyNDV2Qkl6ZFl3?=
 =?utf-8?B?N29oejFWdy8rdU5TcFhIVHZiOE9NRHJrSWsyRDZaeXdhTVlhbmhKcy90TC9V?=
 =?utf-8?B?Z3o1SkFGcUJLUUlhSGRxb3hZeUs2bzFFeFJyU2ZKOWJPTDgzOFBBUFA0YzF2?=
 =?utf-8?B?dC9nUHhBSnRkaXVmSGZJZ1R4bHc2Z2d0UlFJOWlVNThZdkp1bkRvcG95Q256?=
 =?utf-8?B?UzhTVnp0amxrWGUwQ3Jld1cxTm1xU0pvUDVhKzhZVzRwM1NsUE1FSUlGdEY4?=
 =?utf-8?B?aEgrZmVxYWtXSGwxTVkxYkdYZzNmMXNwN2QxZ2xEWHlRU3F0Ly9HOTIrQ2o3?=
 =?utf-8?B?Rkw1WElJOE11ak4vR2szekVGODdPenJXMzkwR1A2WG1mcUprNXBxM2dTZm55?=
 =?utf-8?B?ekVoTC8yVXJnNElOc2FOcnZ4YkQxQzFIOE50aHBBNU00ODBZOTVsVVhsZmRC?=
 =?utf-8?B?VHhoYXMxdGp5L1lNeHA3V29jTmp4SlBlODBPVk9rNHFPNk14aWtZNGhqVlVL?=
 =?utf-8?B?QWx0RllDdHNURFZHUkNvWkxRSzBjeEFEL3RKaGg1QmxLeE94eVVGZmFyWG43?=
 =?utf-8?B?b2laZlhBd2R0a3VyRW8rREkrOGdSNWZNNCtFN1NDUlcyalhwcG5DYzZJM012?=
 =?utf-8?B?QWRUcS9meWRSRElCRzFnS0syZ3VTeU1XOW1UWXVZMC9jdE90MzE0TFJtSXpk?=
 =?utf-8?B?ZmJtb095OTlZUm15QlNUbWZhdUlmL1JRRks0bTk2dmFRT3ZoSGxvY1VPYkdr?=
 =?utf-8?B?Y1JXYzQxbzgvYnV4UDlNUjhiYTZFWE1hZTFQMkJBdytZVWRYTERPNnNQYit1?=
 =?utf-8?B?NUsyUWlYYldJZ3lFbm9aN2ZteEtKZm93UThSbml4ZXd2VDNqY3V2eEZINWI4?=
 =?utf-8?B?aGtvcmZPTmFDWC9nOGdEVmtpZVN6U2NVWnluZ05OZlVrQUx2Q3hxTkNyY082?=
 =?utf-8?B?NktMWVIvaHZwb3g0eFRhczR1WXN0WDNqV0FNekkzM3hkZVllOXNJbTgzam1F?=
 =?utf-8?B?YUhlSGxPUEF6WjVqd0Q1MXBITWVkNExYa0o3K081WmRibEt5MHgrOXViWlNp?=
 =?utf-8?B?bUdTWG1ZN3pDTDJ0dzdmMFR3eTE3QWNqWlg1UzlKL0RlSWcreGdTdlc5V1c1?=
 =?utf-8?B?QVA3WFJoM3R6eE0xZ3RneUowMVgwcnBVSjhiUzA1NE13d1NVaEtiNTlScmFp?=
 =?utf-8?B?NEJzaEZ2ejdOQnhERkZGTlZMVDk4TEpnbHBQNG1OUTNwV0ZtOElPbG5KZmlj?=
 =?utf-8?B?MkJkSVJ5allyOEpKbHZQVmY4OVMzT1NWNXUweUg0L3BVRGl0QittOWlxNE10?=
 =?utf-8?B?V3R3eGF6MUE4VGRpeGJ1bDM4WHNGSk83MStwRjZ5aWlkRGoyakQ0WlhtMmtw?=
 =?utf-8?Q?nTlFfoqvkw2LHsba376n2sIst?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A833448855029249BA4AF54216D899DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d82681-5650-4c42-eeb6-08daef80f0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 00:57:09.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rmZ75pUY0rgosZa4zLm5ncUWnzERny44BY1NpoFsS8jCod9dSRJO42dBqrVotI+TT0kKp1s2AvuYwahxglyEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTA1IGF0IDE4OjA5ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBKYW4gNSwgMjAyMyBhdCA1OjExIEFNIEtpc2hvbiBWaWpheSBBYnJhaGFt
IEkgPA0KPiBrdmlqYXlhYkBhbWQuY29tPiB3cm90ZToNCj4gPiBTZWN0aW9uIDUuMi4xMi4xMiBQ
cm9jZXNzb3IgTG9jYWwgeDJBUElDIFN0cnVjdHVyZSBpbiB0aGUgQUNQSSB2Ni41DQo+ID4gc3Bl
YyBtYW5kYXRlcyB0aGF0IGJvdGggImVuYWJsZWQiIGFuZCAib25saW5lIGNhcGFibGUiIExvY2Fs
IEFQSUMNCj4gPiBGbGFncw0KPiA+IHNob3VsZCBiZSB1c2VkIHRvIGRldGVybWluZSBpZiB0aGUg
cHJvY2Vzc29yIGlzIHVzYWJsZSBvciBub3QuDQo+ID4gDQo+ID4gSG93ZXZlciwgTGludXggZG9l
c24ndCB1c2UgdGhlICJvbmxpbmUgY2FwYWJsZSIgZmxhZyBmb3IgeDJBUElDIHRvDQo+ID4gZGV0
ZXJtaW5lIGlmIHRoZSBwcm9jZXNzb3IgaXMgdXNhYmxlLiBBcyBhIHJlc3VsdCwNCj4gPiBjcHVf
cG9zc2libGVfbWFzayBoYXMNCj4gPiBpbmNvcnJlY3QgdmFsdWUgYW5kIHJlc3VsdHMgaW4gbW9y
ZSBtZW1vcnkgZ2V0dGluZyBhbGxvY2F0ZWQgZm9yDQo+ID4gcGVyX2NwdQ0KPiA+IHZhcmlhYmxl
cyB0aGFuIGl0IGlzIGdvaW5nIHRvIGJlIHVzZWQuDQo+ID4gDQo+ID4gTWFrZSBzdXJlIExpbnV4
IHBhcnNlcyBib3RoICJlbmFibGVkIiBhbmQgIm9ubGluZSBjYXBhYmxlIiBmbGFncw0KPiA+IGZv
cg0KPiA+IHgyQVBJQyB0byBjb3JyZWN0bHkgZGV0ZXJtaW5lIGlmIHRoZSBwcm9jZXNzb3IgaXMg
dXNhYmxlLg0KPiA+IA0KPiA+IEZpeGVzOiBhYTA2ZTIwZjFiZTYgKCJ4ODYvQUNQSTogRG9uJ3Qg
YWRkIENQVXMgdGhhdCBhcmUgbm90IG9ubGluZQ0KPiA+IGNhcGFibGUiKQ0KPiA+IFJldmlld2Vk
LWJ5OiBCb3Jpc2xhdiBQZXRrb3YgKEFNRCkgPGJwQGFsaWVuOC5kZT4NCj4gPiBSZXBvcnRlZC1i
eTogTGVvIER1cmFuIDxsZW8uZHVyYW5AYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaXNo
b24gVmlqYXkgQWJyYWhhbSBJIDxrdmlqYXlhYkBhbWQuY29tPg0KPiANCj4gQWNrZWQtYnk6IFJh
ZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gDQoNClJldmll
d2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCnRoYW5rcywNCnJ1aQ0K
PiA+IC0tLQ0KPiA+IENoYW5nZXMgZnJvbSB2MToNCj4gPiAxKSBDaGFuZ2VkIHRoZSBBQ1BJIHNw
ZWMgdmVyc2lvbiB0byA2LjUgaW4gdGhlIGNvbW1pdCBsb2cNCj4gPiAyKSBDaGFuZ2VkIHRoZSBG
aXhlcyB0YWcgdG8gcG9pbnQgdG8gY29tbWl0IGFhMDZlMjBmMWJlNg0KPiA+IDMpIEFkZGVkICJS
ZXBvcnRlZC1ieTogTGVvIER1cmFuIDxsZW8uZHVyYW5AYW1kLmNvbT4iDQo+ID4gIGFyY2gveDg2
L2tlcm5lbC9hY3BpL2Jvb3QuYyB8IDE5ICsrKysrKysrKysrKysrKystLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYw0KPiA+IGIvYXJjaC94ODYva2Vy
bmVsL2FjcGkvYm9vdC5jDQo+ID4gaW5kZXggOTA3Y2M5OGIxOTM4Li41MThiZGE1MDA2OGMgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jDQo+ID4gKysrIGIvYXJj
aC94ODYva2VybmVsL2FjcGkvYm9vdC5jDQo+ID4gQEAgLTE4OCw2ICsxODgsMTcgQEAgc3RhdGlj
IGludCBhY3BpX3JlZ2lzdGVyX2xhcGljKGludCBpZCwgdTMyDQo+ID4gYWNwaWlkLCB1OCBlbmFi
bGVkKQ0KPiA+ICAgICAgICAgcmV0dXJuIGNwdTsNCj4gPiAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMg
Ym9vbCBfX2luaXQgYWNwaV9pc19wcm9jZXNzb3JfdXNhYmxlKHUzMiBsYXBpY19mbGFncykNCj4g
PiArew0KPiA+ICsgICAgICAgaWYgKGxhcGljX2ZsYWdzICYgQUNQSV9NQURUX0VOQUJMRUQpDQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChh
Y3BpX3N1cHBvcnRfb25saW5lX2NhcGFibGUgJiYgKGxhcGljX2ZsYWdzICYNCj4gPiBBQ1BJX01B
RFRfT05MSU5FX0NBUEFCTEUpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4g
PiArDQo+ID4gKyAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRp
YyBpbnQgX19pbml0DQo+ID4gIGFjcGlfcGFyc2VfeDJhcGljKHVuaW9uIGFjcGlfc3VidGFibGVf
aGVhZGVycyAqaGVhZGVyLCBjb25zdA0KPiA+IHVuc2lnbmVkIGxvbmcgZW5kKQ0KPiA+ICB7DQo+
ID4gQEAgLTIxMiw2ICsyMjMsMTAgQEAgYWNwaV9wYXJzZV94MmFwaWModW5pb24gYWNwaV9zdWJ0
YWJsZV9oZWFkZXJzDQo+ID4gKmhlYWRlciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpDQo+ID4g
ICAgICAgICBpZiAoYXBpY19pZCA9PSAweGZmZmZmZmZmKQ0KPiA+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4gPiANCj4gPiArICAgICAgIC8qIGRvbid0IHJlZ2lzdGVyIHByb2Nlc3NvcnMg
dGhhdCBjYW5ub3QgYmUgb25saW5lZCAqLw0KPiA+ICsgICAgICAgaWYgKCFhY3BpX2lzX3Byb2Nl
c3Nvcl91c2FibGUocHJvY2Vzc29yLT5sYXBpY19mbGFncykpDQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiA+ICsNCj4gPiAgICAgICAgIC8qDQo+ID4gICAgICAgICAgKiBXZSBuZWVk
IHRvIHJlZ2lzdGVyIGRpc2FibGVkIENQVSBhcyB3ZWxsIHRvIHBlcm1pdA0KPiA+ICAgICAgICAg
ICogY291bnRpbmcgZGlzYWJsZWQgQ1BVcy4gVGhpcyBhbGxvd3MgdXMgdG8gc2l6ZQ0KPiA+IEBA
IC0yNTAsOSArMjY1LDcgQEAgYWNwaV9wYXJzZV9sYXBpYyh1bmlvbiBhY3BpX3N1YnRhYmxlX2hl
YWRlcnMgKg0KPiA+IGhlYWRlciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpDQo+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+IA0KPiA+ICAgICAgICAgLyogZG9uJ3QgcmVnaXN0ZXIg
cHJvY2Vzc29ycyB0aGF0IGNhbiBub3QgYmUgb25saW5lZCAqLw0KPiA+IC0gICAgICAgaWYgKGFj
cGlfc3VwcG9ydF9vbmxpbmVfY2FwYWJsZSAmJg0KPiA+IC0gICAgICAgICAgICEocHJvY2Vzc29y
LT5sYXBpY19mbGFncyAmIEFDUElfTUFEVF9FTkFCTEVEKSAmJg0KPiA+IC0gICAgICAgICAgICEo
cHJvY2Vzc29yLT5sYXBpY19mbGFncyAmIEFDUElfTUFEVF9PTkxJTkVfQ0FQQUJMRSkpDQo+ID4g
KyAgICAgICBpZiAoIWFjcGlfaXNfcHJvY2Vzc29yX3VzYWJsZShwcm9jZXNzb3ItPmxhcGljX2Zs
YWdzKSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gDQo+ID4gICAgICAgICAv
Kg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4gDQo=
