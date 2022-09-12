Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734D5B5DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiILP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:58:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24D23BEF;
        Mon, 12 Sep 2022 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662998299; x=1694534299;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=DnbrxVot6Hr6tiKZSEs5u+kyo+WVcCtXRz9MzyvG8Qc=;
  b=ZedJPiaAyQMug0Li1bJLM518DYDIzWD+aV020XEtWE+XZ5K5YRkEyUT1
   Kr/9JiXu4Tlqx7jcdfAnjOpKb1fkQz+OEkxsB82+L5hiiNktJ4ZwRSohu
   82rJT/8zpVarolPxcmcbrL2NkSG32aLy3U7Rp7tZMLn0RP8zTFPtz1u0F
   jnWdv2zdOIgRL17BVBb/5lnPIN0W39016p4K037CBDfteiHbyI6qry3LQ
   RaA6tPCEvChh1hVeu5pLpnQ7lZMjHLvNaGf7kBi2j0it6ji3Hxlew+9AF
   oaYEYCBD9vvNEBxNo32bTfXj/xZuKUzNyLjBX/5yVIYsDrxxeSMGWEefj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="297902512"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="297902512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 08:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="649304317"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2022 08:58:16 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 08:58:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 08:58:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 08:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkWU1QHE3Hut8fGa9LNc1APX73dfRo6kVcVYOjT9bRUEXbYsViXX8JmJQAkPVqUuvLQbedn5N/eKzEm0HZOAbetykIVUz2k2CT7bPUMTF/rquMoMzoJ1k1dUX2cSemXtBCdmuE17YCTBPhom62TLzb6Era2NvS8aalxeGtP7TQ7fe3c2K+iDAn++OnQoduuDV5e5qeRy3cHFkHlwvNYFgNLka/ULSTF2SoGduT3juFuONgBN3vzNvr8xkU0Mmq1aGm6lzBg6A9a7gKtqGewodOYJP54hlKbaknDG/0dRMiD2ZYUPDPzFh0frnRe98HacxngAnEtMKNgv4bJPc+MFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnbrxVot6Hr6tiKZSEs5u+kyo+WVcCtXRz9MzyvG8Qc=;
 b=fqEROYuPBuo3FKB0sPyfYM/dHIaXGxEZpaj71mh2O6f3upcWH+Ox6O0CLCyIXP/g2eXNGlMnYFIziYy7nNToHpTVxZePi/6yLGrdfNBFVS3MwKGz5v4NstzkYBpXaXNjNblmPrZ4Cs1LeT4pBK+rvAt3mbJ8fg4ozmEG08dwhoIXD7MDJWxNof2xg/NCwz6qYypv5GAH2b4URflf7a3eioyGqL/AWQVgFl5BWXa4oPyLNVY7pbf4QJ8asL6i/nqFZoI89kV+nt5pCXSbCTinH1idvY5PPeZd7uXwtiP89cG2q2Nd6Towzzbw90VUU63DVaiOF5xr6k73um/ngp1QcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 15:58:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::9d5:53e5:d76:8d2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::9d5:53e5:d76:8d2%11]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:58:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm/page_table_check: Check writable zero page in page
 table check
Thread-Topic: [PATCH 1/3] mm/page_table_check: Check writable zero page in
 page table check
Thread-Index: AQHYxcU3/0Y4sv/pzEWmDvYrc3g3ha3b9WKA
Date:   Mon, 12 Sep 2022 15:58:14 +0000
Message-ID: <8e83a99a22b19f0189ea68c99d20eb4b0a18dd59.camel@intel.com>
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
         <20220911095923.3614387-2-pasha.tatashin@soleen.com>
In-Reply-To: <20220911095923.3614387-2-pasha.tatashin@soleen.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB5087:EE_
x-ms-office365-filtering-correlation-id: 1ea45a7d-4965-4a7f-4df8-08da94d799dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAIfPKhBbaHTcKEPG1Q5vK6P+ie4i5dHVCnsyfEDYXNaLeTyruWWBJ2un29uvg99mSnLRr5LO9QfL98fc8WhYy6nH0P7LuIAvJ/phBKTtHGAU0g6oVtS9WhpLZIZZq75Vp2Akd/YIxQieXyGe8R/NElZynutOQgI6bjqKUeJ4F7WxGqYBLmCKNps2LWtQpeR31UNHQ8FIEfO2SpaFQGb5XZtZg4fEUKeYqnJrlCD1pM4q8vmJ3vd+WZtOLaLkMIvaBeHrYQ7Ynl7KOMDR77wok5nWuqDoVwMYCOGW1TivVE45loQwy/YAo0clH8bwwLuihHRLrf1LitVIjC17OsORTbgN8OygVMstAGvGfV8r7Zdxs3wZxzOW7QvhogsswCQF1Tio1jwfFaAFij2xjfeef0+L2CeqP6qAof7z64OJvZv7z9Jj3OWQsmO45bfn+bfECB5ePme9wFERCZYm2O2vI7LErxkF9Q12aCHpudoM5nCsNhGokcJIrKphQXJcnjTmBt07AM2AFTqMF+fHekMYc46y9qiu72WTy07TPJ1JMWrpJnlw16ZMyQsBwBKchK1xuPElrtowXn14a35UQvB+CYHe8Gsi7MCzTCo6XOvbNpCI6ulrXomJ0lW3AR5w6IDV+GX7im/MhVHYcDxU+nt8NlvPFGZNkd5d+JZQSAUfGG6Dj8rEs0XRY1eG3Ax9nnGfvvW1ceSCLPsIRcI1tHE3sqD5U7N/Rcsi2S1qYbWvRTxQ33/rEsjIpV+APpp82n0Mzfz2LWHwg4ukH6oDbMoNk/hUspfulkAqGPmlGG6Txo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(4744005)(38100700002)(26005)(36756003)(6512007)(41300700001)(83380400001)(2906002)(8936002)(2616005)(186003)(6506007)(5660300002)(38070700005)(86362001)(66556008)(66946007)(66476007)(8676002)(66446008)(64756008)(91956017)(6486002)(76116006)(122000001)(82960400001)(316002)(478600001)(71200400001)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXBuMkMxU3RaQW9yWWhxOTEyNGFVSmJ4Wm9nbW1EV2VaejFiS1VTdlg3dklX?=
 =?utf-8?B?WmFGV2NUYWxHVUo1ZW5ENVdRTEI4Uit0cXBmN0hBQ0gxendvcFY4YjZzcm9t?=
 =?utf-8?B?VnJWVjN6OWVkdVJqV2hEelorTGhYTUgrYWtaeFI1U2wrcERMZVgvb2MwVVMv?=
 =?utf-8?B?UEpmT2JyV0ZtUWVIVUo1K3RGZmVpQkRmYmFqeEcxcjIxK3V4eW41UEpib0FF?=
 =?utf-8?B?TGhXWU5aSjAvU2pSU1liWEEzTzdGc1c2QUR2QndIVHRTR2Q2RGpUZFZCS2Qx?=
 =?utf-8?B?bzJHRlBMMlk1VnViZmw5VlJ4bVZ3L2szWWRzSnJ2Mk9qcXF6ckpvN1UrN3ln?=
 =?utf-8?B?ekZ0bDlCaEIyeTFHelAyS1JKMENwc0VxOGJyVmk2VFQ4ZUtwTG1kY0pLQ2pi?=
 =?utf-8?B?UDc2N1Rmcjc4TGw0YlJTRVZQa291MVBUaFhnNTd6RGdqSXI4Mk5lM09Qa2hG?=
 =?utf-8?B?cVhyN0NLMmlscmpRZzZmVVBJYStrNEV2Y0xsU2QwRlEwVXlqTGNsOHdNVHM4?=
 =?utf-8?B?b2tKNmFNV0RNM2x3b1kzMDRmMnFHMHF0NU1CaDNnekNCRWFxV0hQQ1FPZ1pq?=
 =?utf-8?B?TFM5QUEyWHZrNXFXak1YWXZ1RVgrbFFuOERYSFNrR3pNT1JMVFdzbkU2OWpy?=
 =?utf-8?B?NFdnTU1MdExzc2RLaC94MU9Sdys5OWJrNTFJcGxRVHlwaWJKbXJ1RFBiSUd6?=
 =?utf-8?B?eXVsTUozVE5uelZPV1BZY2JHWURGME5IUVNBUE1LbndoT20vUGw0N01oc1hL?=
 =?utf-8?B?UlZLUlpsdHUyNDdrU05WOUpvTW95c0hTWGxieW5Bc0lGWTZaK0tXQ3F1YUVs?=
 =?utf-8?B?Nk9hSC9nVkFrWUdlNzg3dEJyRE0xallWdnhldGFWK3FmT0dMbkFXMjBjK0Zl?=
 =?utf-8?B?R3pjRGF0YndpNFpOUXRKdGZxcVVQSHEySGpLMWFXTEZPWWE4UWhFYy96dDRn?=
 =?utf-8?B?S1gxbGwwYTJUM1ZleDZBTEZVZXFyYWUvVDFOU2hHUHRSRjY5cm1TdkEzdEpq?=
 =?utf-8?B?VzF2WDZkWlMxM2xtQVkvclZQUC9GbHVBMFBuZGZEMkdxaGNITFR5SzZLY0Y2?=
 =?utf-8?B?bHBlSkEvMlR0UEdHVWUxTEpWRSt4V2tYZnVkS0RVRjErOENiL29qUXU1OHVG?=
 =?utf-8?B?Vy9FOTVVVnZTWGF1TWsyUDQreHZocXUrclZzdkZtWDVYekEvb3V2MnZUSGtE?=
 =?utf-8?B?N21yZjllU0VpVmpOVjdZa0xYWll0QkZacC9UU2FRQXYvR29PV2dDaElJejBp?=
 =?utf-8?B?RFJwUUxCL2UyV0NVNjNnbDZ2OWh0dGt4N0FWdlBONEJ5SkZ4RDdPekYxcXlo?=
 =?utf-8?B?cyt6TFU4ZUM1cVY5UEtlc1ppWWc3ZjlIdDNvMzZQU014U3pwQUtFTVRJR2Q3?=
 =?utf-8?B?amg1VEovQjNLSzNDWk85UE5zVFlHSXRGcmtPN2UrRXZVMDEyZzNmRkwzeTY1?=
 =?utf-8?B?YjM4dzlRcmdINWJlK05EUnBuS3RtK1ljM2lmNUVjNUtlVzBIbWQ3WkVQVkEr?=
 =?utf-8?B?SlVvWkwrdzBuUEh3dVBib0MwS2wvQzhldTJ6bDRwYzNqbjBKMjluMm5ra3JP?=
 =?utf-8?B?NUFNYUtOS0pRVW5QRTVZTUczZUoxbCtqMnhyU3N3bjRDQXB6RlFOSW5CaTFh?=
 =?utf-8?B?a0o5QUJqaDZiRzJPWEQ3K2thRXlLWlFnVFBGaS83bDZaK1lpVTJWaHl2L3lG?=
 =?utf-8?B?QXRNbnJ2eDBIazNLcVJYS1Z6R2dOSHd6djFXNUV0YkkwbkpzNklYeCt4aEpk?=
 =?utf-8?B?bkNGbWJ0SkVBbFowR3ZyZTI2b2JwY2NVb0RaQkxGdHQzOXM1SDhycnhKMmZC?=
 =?utf-8?B?MnR1ckVwNTJIZDlGKytWMTdnbjVCVCtSK2JpdlFKWTFWbTVQNFRTQkZSMjJm?=
 =?utf-8?B?STdkQ1dQRlQvaFRKbkRUT1FCWDdtSW91czBEMVVzY2RuT01HWlZsS3NQYzdj?=
 =?utf-8?B?RlU1a3ZzSmhqelhqQVYxRE95eDBCRTJvRTBNZVJXWW55M3Q1dmUyV3pJVkJu?=
 =?utf-8?B?TVg2MHJvQ3B3WmNrbHRWM2U1YVJSbExrTldIY2o3QUxDdVd1UFZjYWVnOU9r?=
 =?utf-8?B?cFZYTnJLSmo2MFZQMWRpaHBzMStaQklSeGZiS0FKZkdHTlczY1BvQUNOSVVE?=
 =?utf-8?B?M0lxY2JsSlVxWXZQYS9oZ2Mrd1dOcWNGaXpWZmJlUE1wUEptVC9zeUR1Z1ZW?=
 =?utf-8?Q?os6g+DkHSe7w7UMNCo1bZ1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1EEC12E90FEC34C9CBF316A0A78AF2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea45a7d-4965-4a7f-4df8-08da94d799dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 15:58:14.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8LZ2f/wHv+G0Ogr/05IjPu6k6m2TJ+YfJviwjCLwFwdqu1QbDPfhLZQ7pe+4P0JEN2yG/qupP625AvPFH5SH1R+Dd4pdB7GzSY6wE7ZfcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTA5LTExIGF0IDA5OjU5ICswMDAwLCBQYXNoYSBUYXRhc2hpbiB3cm90ZToN
Cj4gRnJvbTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiAN
Cj4gVGhlIHplcm8gcGFnZSBzaG91bGQgcmVtYWluIGFsbCB6ZXJvLCBzbyB0aGF0IGl0IGNhbiBi
ZSBtYXBwZWQgYXMNCj4gcmVhZC1vbmx5IGZvciByZWFkIGZhdWx0cyBvZiBtZW1vcnkgdGhhdCBz
aG91bGQgYmUgemVyb2VkLiBJZiBpdCBpcw0KPiBldmVyDQo+IG1hcHBlZCB3cml0YWJsZSB0byB1
c2Vyc3BhY2UsIGl0IGNvdWxkIGJlY29tZSBub24temVybyBhbmQgc28gb3RoZXINCj4gYXBwcw0K
PiB3b3VsZCB1bmV4cGVjdGVkbHkgZ2V0IG5vbi16ZXJvIGRhdGEuIFNvIHRoZSB6ZXJvIHBhZ2Ug
c2hvdWxkIG5ldmVyDQo+IGJlDQo+IG1hcHBlZCB3cml0YWJsZSB0byB1c2Vyc3BhY2UuIENoZWNr
IGZvciB0aGlzIGNvbmRpdGlvbiBpbg0KPiBwYWdlX3RhYmxlX2NoZWNrX3NldCgpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBQYXNoYSBUYXRhc2hpbiA8cGFzaGEudGF0YXNoaW5Ac29sZWVu
LmNvbT4NCj4gLS0tDQo+ICBtbS9wYWdlX3RhYmxlX2NoZWNrLmMgfCAyICsrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KVGhhbmtzLiBTaG91bGQgd2UgcHV0IHRoaXMg
YXQgdGhlIGVuZCwgaW4gb3JkZXIgdG8gbm90IGFkZCBhbnkgbW9yZQ0KQlVHX09OKCkncyB0byB0
aGUga2VybmVsPyBPciBJIGNhbiBqdXN0IHNlbmQgYSBmb2xsb3cgdXAgYW5kIGFkZCB0aGUNCmRv
Y3MgeW91IGFza2VkIGZvci4NCg==
