Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670DA666768
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjALAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjALAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:07:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC19CCD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673482047; x=1705018047;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kAnzxgDwEcUO1Wp7pzccU6uVmbIywDpmSHNqclJrtPc=;
  b=miE+qHY+4hSMVh0nfD6IR5Tbisxn1DEv+TC8+rZ7D4NR6Z5lQaY16pjT
   SwURoaCQ6LIsFgBf3YlmAtl9RPxfZpUwUyTeTlD2GUR0k0Vq0mDA8DW7v
   XYm69W129A97PCYtFvHj6MifDOF/e5JBu/Kjb6JzwCpR9fRGTSxIywiMl
   E4UzWHREYsNaB1qNczbw2adrOCBe/luhYuNsfE5papB3CzLX4A1S2eAj0
   JC0qDSrdh5fHh8JvMTVt9AImSnACKeHRTy3uGJ1h8RrnL6H0Lr5bUumIB
   WSfjY5KOZghhUEBtF4T0GIQRzXTkng3M5BTXO3t7eB+oJ78wW0YKlNc7D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303266471"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303266471"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800012134"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="800012134"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2023 16:06:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 16:06:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 16:06:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 16:06:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEv5Yc00lBilB0KgebiPsfSi5o8ygiB1QW2DDooLtx+RqsH3tU+uwz/tj+jJjXVFkYtERlwve9+WlSKerhv3WcdJDyBcy/wyTW6Ifl5H14nzsJzpUgbv3GEwejXDWZKZWx1jyr3WMxBF8W7+Kvn30L+P6lX8mCv+elo+FTNL0AKL3aosCC90pMXRPVjs1FAIrtc/NqMhoAGJeqZr5tEIAL/sHamKHovInh2Adp3qqZ1bELROq4rrXYn8CjuPwdxiTwo8pC0uXvo3IDgEdEjijuRCiwuVgCYgN/+w+lQqk1+4fUELkxghZCb64othKNcW6ggOqUi4K/+thySXhnHj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAnzxgDwEcUO1Wp7pzccU6uVmbIywDpmSHNqclJrtPc=;
 b=gZlgVHL4XffoNwx7w6faWN8UHx6cJwbg7+kJ7gGa+1fsjJuGVFrb+GaQkh1cJA7xg8IP7uO+4DefIYiLX4za8xP6lbbsYX5BIOMRRRftzZRjC0D8jVCY7PRKDl09qhXY6FseWnsXw7mkQvCP28gfj72mj5KDg2Ur86Kk9zXpeo7vKRr2F09CR2g+z80u3PyYvG0VtPDFhG/S7r6h4UVIaE5M5Mh2+ngIWsIyh5i2Xj7iC3ih2n8/kvvsJIOTbfPGOjV5HdBEQcFiMXRrSsVmAWf/RsoRSRkSVlqLXw40q+R2yvG/Y3fiwMOpW/+FtZZ1MhybeopuHx6slcDZB1TTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 00:06:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 00:06:31 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chen, Yian" <yian.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Lai, Paul C" <paul.c.lai@intel.com>
Subject: RE: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Thread-Topic: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Thread-Index: AQHZJLgvKYw/rhaLRk67SJ1asWIqKa6YFsIAgABC0ACAAYSFAIAACtfQ
Date:   Thu, 12 Jan 2023 00:06:31 +0000
Message-ID: <SJ1PR11MB6083A0E582C1A01AA6788099FCFD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-2-yian.chen@intel.com>
 <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
 <feab0dd1-2030-e31c-cbbf-9857c46d0c1c@intel.com>
 <fcde9247-55cb-b402-987b-66f24dc76271@intel.com>
In-Reply-To: <fcde9247-55cb-b402-987b-66f24dc76271@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5001:EE_
x-ms-office365-filtering-correlation-id: fdbe0ff9-cd73-43e8-c4ed-08daf430dc48
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMeO9PM/WgFoyX8JokWUvjZxzsPMUGMrp/gOo/Al+XIQBNjKNbb1DB7ziui586gz9tXhJyVy2mNwCNc00EOUr2wEAxKJq618MvfzJcTbBJ3cFRyJEMsPgVnZR+feMMN9wYhtxo3aalIWHmeGCPIF4RI1MAniU4jM/kYEcvbAVbmDeJx6oqCZWGixpGXciT6f5wMcavJWz9kRFZhxgSNfZf1vOLPeg8bOPIhc1Kpf4z3qtzrtYQgwYKRWM7R8vUGF5XFiSTqL4/9kRONHNLQyw+mKHdfhVK+BUER9umqO4MJGOECfcY/iF1mm8Dtdr7gNtryNkWDso/O+dIb/14pZ8nbQpILUSbAyi9tze/Foy5G0SvkZhpSVhbWm5wAB8AaprIxkYDFx/xkWIefSPAyeDM1lavRl0Vg5Whz9S2ZR2zPuk/z72E3ae8mCIhnu/XOIcykEANq6hcC74jjODSU7O+qzYkmOzb1CT4Y+TXpOSPGrtrOewPvc8HD+83gMDbilws4HQEMfgp3cs5JJT7+0wkxfjvwGpx6pM/10OXyLyiTabZEu4WsJGfugk4qwYtke2CIk1fJKLSV0Q6wzr7oXRjZeOwKJ4c3Sa+pQ1yBNobyT4+UsCb/7hV2nWNBM9/u6F8WL/x/n8eFkbYTx30NlERCy/2tOgbR1sDZx2Vre/Oq5Dw7AOnHNCWhFYO3XFrSId40z1tNixJwa0OBMl7y5RK1wiDl6LbQkY6oQU81vdJSjl5TJv0GPsnMIBcqnDaim
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(86362001)(7696005)(38100700002)(71200400001)(38070700005)(478600001)(921005)(966005)(186003)(26005)(6506007)(55016003)(33656002)(9686003)(41300700001)(66556008)(66476007)(66946007)(64756008)(66446008)(8936002)(5660300002)(8676002)(4744005)(76116006)(83380400001)(52536014)(6636002)(110136005)(316002)(82960400001)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGhrU0lTR2YzSFZDVFZ3MDBJczdNNW9JQkNvQXBMMVJFTDhkL2Qydy9HWXJn?=
 =?utf-8?B?NkxyL3RITHBCOFBPWld5Y2J2cFBmenVjTFpzNmhOcVBUOVhXMXdVY2ZOSWJi?=
 =?utf-8?B?bTM4WDhIVlpOcTNQdWg0b2NaUmFYYmRRaXlYMnh5b3FMNGpkR3BvK05lUGhT?=
 =?utf-8?B?ZnBIT2hjUkFMZFhqL05HcUc1RzdDcWFLZnlhaFRKV1QxdXg1bTRwcHg0YVNr?=
 =?utf-8?B?Q0NPN2N6ZU02UG9iUU5xUlpkajR4czBCSGMrcDFBZFpuRmllSzRCMjZLSmYv?=
 =?utf-8?B?cVVzS0h6WFllMXBTellrUWo5NVdzRUNlb2EwMjhLd2NoN1UwREVod0JhTlhI?=
 =?utf-8?B?QzFjWGlEcmV3UDRNbXJqY3h4bjRlVHZ6bjRhUkticURRUExGZG9wQmpIMEx1?=
 =?utf-8?B?QWl1UG43Q0FkODBXQlpoVzVPdjlTL09RYXlTd2dtS09KdjE3ZGFxelIyYmFN?=
 =?utf-8?B?TDhuWWsxQ2ZGd0dBazhING1oZkV5SjdXWm5wUzNGME9ybk5VWmRXQ1dieUJh?=
 =?utf-8?B?WUpNRjdKVGorS2V4RmpzbjcyQm5pSjhjMmE3UGh5T3ErcUd1UTcyNmtzSTNm?=
 =?utf-8?B?MkV2cUxQMVNMTTBHSkR4UlJpSmQ5UmZrS0VzT1BpVlpPUHM3R0FUVlI1SlIr?=
 =?utf-8?B?cm5WM1FrMWNuWm9NYWpGWHRmNVJ3dnFiSTVYVys2YmxhT2VyeUlZckFBR2Zo?=
 =?utf-8?B?WGszZ1EvWVA1NGpGdHNzU3Vyc3VFR3BmVnF5eGVIdWZveUoxOXYySVYwM1hS?=
 =?utf-8?B?cjVyeE8ySjNKeTVJV3gvMklUUVg2d2I0U3BHdGNGVGRkWnl4by9EejFOb25U?=
 =?utf-8?B?MjJLTmNmdEM1VWs3Z1VwY3AvM2lRUVJCQk8yOHlwdmlHTjBLZVZLREpYR2dn?=
 =?utf-8?B?NGsvcnV3VXFxeGg0b2xoVG9RK2drK2JXWFlNT2RmWUFydkpMQUlNWlRzSVkv?=
 =?utf-8?B?clk3R1pablFaeStZQW4xTlB2WGxYUit6OU9tWmZ5WTdEN2NDZTkyQmptUGJN?=
 =?utf-8?B?MlNmaU9XNG1FdUIxa3Q1a3VYSVJPbmFINWFhT1dDSlFxcG1TU25XVTl3ZWRS?=
 =?utf-8?B?bXdkcXlQWlhVQlI1N3JuT3dzTVZNNm9pS2dmRmV2V2tyYzRHeGQ0YW1VNFk2?=
 =?utf-8?B?MjlEUDQreUVCV2p6ZjcyZnp5bk42VUxIejJySGdNTXBFTG5yNWFyWnQ0Ukg5?=
 =?utf-8?B?YUh0ZGV4RjZKZlJiSDZUTU9yUVVqUzJVUitMc0NYc3pIK3hmeHNKVERnYUhK?=
 =?utf-8?B?S2h3MEZTQUVKUlp1OHhWcnBSM1kyZzRpd1lEU0dBeXpUMzJ1UFMxakpLREcv?=
 =?utf-8?B?NHIzL08yTTZyN1YzQlJJeGoxdG5hWGFFSzd3TVo0ckIyaUphK0F2N2swZlhV?=
 =?utf-8?B?ZERTTFBIRTFVOEhwT3lOV3F5bFNCdU5vUE5NdkZZa2ovYitUZTJOZllRcmtW?=
 =?utf-8?B?TFhuL0dZaG51bFB4MWJkQmp6dWlhdjZMTjM0RVpxOERwMTJIWjZCNUFBdHBV?=
 =?utf-8?B?UVVyUjlFOTZkNHZMbnBJdjBLT01HSmdndDE0VXJidFMwUkwxbEpQOE1nY050?=
 =?utf-8?B?dXBPcm9qekxMQmlZUUZIRGN1ZDVuZEFpb2xza2NlSy8wZUk5bFdlbVpzNUhz?=
 =?utf-8?B?ZGhIZ2ZrTkVBWFRPaGpySHFPaUtNVDkrWEt3UytMN0F6dWpSWkhRNVJLNU1C?=
 =?utf-8?B?YklSQWVDK2dpRmZZUEZoZzM0VjZIOWc3bW9PTzg1V0xJRUg2S0lrdnVHdU9Z?=
 =?utf-8?B?Z1JzMUFWWUF0OG41TGpGVmw3WTRSVTdxcTZ3REhzdVMzd1RrTm9JdVZuWko1?=
 =?utf-8?B?bWlOYlpqL2V4bGxhV0k2ZGwxSmdwOFJaWDVpVTRKZUwzdmJtbU5sblJkOTV3?=
 =?utf-8?B?b0E3bEt1Y3NtVFAvTVJ1RUhXOURreGxjd0tyMGxNNWRGcGsrR2NnQ0c1NVRr?=
 =?utf-8?B?ZTlRMk5CVmhYR1hFMFR1clp3bnZDdmY5UVFBOXk2b1FKbVBjTmUxK0srcHpC?=
 =?utf-8?B?aWFRU3hXd09URlFhTkJvaGNhdGtWSkRsV25ZTC9LbjVQYUJWL2ptUnU5WlRn?=
 =?utf-8?B?SjNib1VXdFdJYW1BUFEySG9YTVhQK1laVUx0VXd1cS80MTR6QUNmYkI2ei82?=
 =?utf-8?Q?khrqQ2DeUjDJCk3nDZUoDscZ6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe0ff9-cd73-43e8-c4ed-08daf430dc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 00:06:31.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuBykumNLMT7gq8D9ajhLFF6k2qLnxieo9KlIzrWAT2PdT8ShtmgDWPG9MId9zijjE69EW32EVh9uaIIUA07NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUgTEFTUyBkZXRhaWxzIGhhdmUgYmVlbiBwdWJsaXNoZWQgaW4gQ2hhcHRlciAxMSBpbg0K
PiBodHRwczovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwvZ2V0Q29udGVudC82NzEzNjgNCg0KSW50
ZWwgaXMgdGVycmlibGUgYWJvdXQgbWFpbnRhaW5pbmcgd2ViIFVSTHMgbGlrZSB0aGlzLiBCZXR0
ZXIgdG8NCmdpdmUgdGhpcyByZWZlcmVuY2UgYXM6DQoNCiAgVGhlIERlY2VtYmVyIDIwMjIgZWRp
dGlvbiBvZiB0aGUgSW50ZWwgQXJjaGl0ZWN0dXJlDQogIEluc3RydWN0aW9uIFNldCBFeHRlbnNp
b25zIGFuZCBGdXR1cmUgRmVhdHVyZXMgUHJvZ3JhbW1pbmcNCiAgUmVmZXJlbmNlIG1hbnVhbC4N
Cg0KTWF5YmUgYWxzbyBzdGlsbCBnaXZlIHRoZSBVUkwgaW4gYSByZXBseSBsaWtlIHRoaXMsIGJ1
dCBhdm9pZCB1c2luZw0KSXQgaW4gYSBjb21taXQgbWVzc2FnZSB0aGF0IHdpbGwgYmUgcHJlc2Vy
dmVkIGZvcmV2ZXIuDQoNCi1Ub255DQoNCg==
