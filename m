Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7867C668588
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbjALVfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbjALVez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:34:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F01036;
        Thu, 12 Jan 2023 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673558728; x=1705094728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qz5TXfXEoH/uIktEOHVeJATMe7vg8YUBB7egMgjQ6CU=;
  b=EQeAKKmARz1KODmY85d3H9dOf4VZyTCyjxB0aCLmBRIiDsbDDnnbwr3t
   4zpckcgJ7gTMTtzTsVjPg3AJUmYJ0KgjDrSBUyQHq8U0fIVW9Kmwvt4g5
   FB8GNEeJJigwO6od1H25xu9tbcyD9/74q0Vw1o/Hgtj1NR9dmk3kMHWIW
   39VeDEWaSGJFfHmtaKZM6xduWip3K+UzmtHCuo0V6dVb1D9+SO2UUkX0t
   ygF9za5AAV6bjVpnj6nqypKyldgtHH3OBvxhvdnPcRruUx2Tf1Xy+s+7c
   eX2Yc19L8Fg408XrZ89fbZqewMo0WMTjsKPnyhpHHQqh7eSoJUCwgadXZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388327532"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="388327532"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 13:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746693286"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="746693286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2023 13:25:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 13:25:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 13:25:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 13:25:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik4MYOkbV1RtlLZNTp4DEU03oXOU6CLWpw2i8JZxPC5YsJrMUTJqYx8caUjz4gXmgNq9JW3phIjAN/MeNuUGVvjkQLB7sVntF26cDBbNuULSX43/Zp7/vtlvVZc8BLdDaTsHf6MyGHtNnoDbaEejVReZTEUTHlf1ZYA4TWiFbWR25B8hYcHN2SFdQec0SXDKhAX/lz8u39uH8EuxADUPGjv+4UO3Ovsq5KqtrM/1NuLGv48nZ8I8PVm/oG4ueLhJMDzwx7OmCAXTKf5FawEV5Qdo9I+YaDN0YPXFeiTual+2O9evzBCI7pYusoIazq659JhVxSMGF4NL0NCi/+x2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz5TXfXEoH/uIktEOHVeJATMe7vg8YUBB7egMgjQ6CU=;
 b=jLwbuOKM0wBR5y5lDi1rzLIDPv4h7xodYh3gwpP7OoXp8zV9Q/JPOpf9U7J+5Ij6sYOCcX+F9lQZwpd93d10i/qyxM1K7FRY+09ZKZf247PUbBjwaujYhalj9PuBoEj4uGB0MBXe2VYp/s/UcQpdUNX6SN+luamzz3VgqFOozT3Z8C1PikjRerhAAmusZsPk0+DTkuRba1qnaep+L9oNP1zK1zj2C1fK7TVNZNdd+w6wyximIqz3g/aM8qku1WKtbNrIfht+/27EZrhZsQxRn6JEctu+gDr80N2nW6L45Tsy3CN2pJGjIDt/sB2xXvfan2Wg2u60pUwtI8HmPpaZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4583.namprd11.prod.outlook.com (2603:10b6:208:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 21:25:18 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 21:25:18 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Topic: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Index: AQHZJTksM0Lkm+QZIUqyvtSWxlR3AK6Zrh4AgAADCICAASUoAIAAU6cAgAAGWACAAB37gA==
Date:   Thu, 12 Jan 2023 21:25:18 +0000
Message-ID: <62cdd3cf51593e35aac181878dbfc1f750c0c0c2.camel@intel.com>
References: <20230110211839.19572-1-rick.p.edgecombe@intel.com>
         <CAJZ5v0jnp3jLdD1wN1NjMfxrt+gYZ+im_quHdgsOrWve0XQaWg@mail.gmail.com>
         <cd2a9ccec0d88821fb0c7580f7ae934f2de71ddf.camel@intel.com>
         <CAJZ5v0hffKjor=kzr71esaw7M2BV5vCTEY7pg67-iWXZ98sQBw@mail.gmail.com>
         <0c7760bf5976cb64c952df5601eae14fd33fbe2e.camel@intel.com>
         <CAJZ5v0hmuWRtMkfsbPkiK5J=S5XvO1U2tzrL+dpPBGwbLJz=5A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hmuWRtMkfsbPkiK5J=S5XvO1U2tzrL+dpPBGwbLJz=5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4583:EE_
x-ms-office365-filtering-correlation-id: 8cb11b0e-cee9-465b-f0b6-08daf4e380eb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOWWY6UMKrOxOdMrc0Mp+Zg7rm6+HPn5ZEjO9LgmlC/DDOeqCqIubqg0kwEvRCMnpZ0F9QCqczNWjcrnlE4ozdkBxbWweDw4FBlfgF/llsDor771WQN0+fs+PwUT6v0ARmIzsY8tMQKgsoCDX6YevlQdw7RFTyraTVSirX7Rqd5JhOqo0ZuOmByxmrzT1QPDPE+JDOFcpkD5YwvtnDph3omdawTGQ8bCWuh8DY7Dfw5V7WLO/qU9gs2p7sz6BUzlPWHROXasETOYBB4JvnKKHYgHdxw3QaAVsWSxD+OUYM+50yh2NPP9cc/MN+gnDmXE4y1xJ68WYOYCOO0xeQE3IF3+LBMbIR4kz7aixZd5JxgKbGztbHLYsdwPLXwImcTpv+GKyMzY9BF7NLHM84gKR1HT8mvJb/JNaZOihmn2n+EhsXMJA5ZRMnYPNow0VqxYR+PjkPzr5ezPSCWh+9x7rnxYhQeDgik/2Tihxn8X9cRz+xmfC841WYNsPJXf1QRLS10s4uKqGZJ72ki115ez9CuvjcMDnVljSSklAUIwN2nH65sqBeYJFL6cnj/wHP/rNA8sAsmP/NEdXpOL5qImSmPowVg22seK0m042YCoweeV6XjKFKhTXHRth1GZ8UGJVRQSt7CWPUkgT31skQ2g9QkG40ef65B/EfNBuNJoLV5HC8cmhUzxBkGRhiRK01kilPTtXF9a1AbuEZ4AMd9mS4+9Q1wnbvFGG2sxMW6BTx4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(82960400001)(478600001)(38070700005)(6486002)(41300700001)(6512007)(38100700002)(71200400001)(86362001)(316002)(54906003)(2616005)(91956017)(26005)(66556008)(66946007)(186003)(76116006)(66476007)(4326008)(36756003)(5660300002)(7416002)(6506007)(2906002)(4744005)(66446008)(64756008)(8676002)(6916009)(8936002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnRUeURVSTBMM0luQ3MxNUJXZWVkb0lEbitUakw0cXUza2hWTkcwajZwOGpk?=
 =?utf-8?B?WHA4ZDRKMm1PaVRDUlNGV2xzRnpVSmwzSVhIRVNCckkwNHNHQjJ4UWtqS2Fo?=
 =?utf-8?B?UGdwZlhPOFJtT01wcERFU2dxMkI3Z0wycEFpVGdtdTJJN1VVajJLSWJyVEZP?=
 =?utf-8?B?c1l0cWZSSmRjcW84ZzNDejhmZDNuMHBDOERCWU5kdDZPYjhHK3FicUduUmIv?=
 =?utf-8?B?UDVVc0RjTUJYZ24yTVFDY3NXajBRSHFKckRJZU9RZVFOU2tyejVtSE53RVlQ?=
 =?utf-8?B?UEpsd3Z6eVRha2hHbzdmQjQ1YU5QVitURXhYdnUzK3p4Q0xWb1ZQM3YwRGJx?=
 =?utf-8?B?SVVKaTI5TTUwbzl0Ni8va1k1RVFvNkpnN2ZjeE1CT2VWS0xIb29oR0ptc25o?=
 =?utf-8?B?NVBGT0ZrQjdrd01qNTFyalhXK2F5WGxqWnMxMnFVZU4rTkQrUExhb2NacmZI?=
 =?utf-8?B?R092TEFRWXhoOEJEcHRtd0szRmQwbHQ3QlJ3RnV5Y1k2blA1MSszTWN2YmJS?=
 =?utf-8?B?ZWttZ0JOVXpGSnQwNiszaHFScmFydE9zaGF0TDVUOUd1SEh2Vnh1UTY3Q1FR?=
 =?utf-8?B?V0F6RVdQbE0zV1pOZU5WM0plUmNvTHMvUjVNb1VlUmp4RmNQcHoyQUZJYWta?=
 =?utf-8?B?ODRnVzdqNUhEQVR6UEx3NUp5elZvZEUwUERZOUJxZE5ya0RWSHAvNkJJb0pu?=
 =?utf-8?B?QjltcFRpRURFTG1UdHRRTWt2bFFESlN1YlpzTDU5aUtLeGIvRHRCQU0rY1dC?=
 =?utf-8?B?bUpJTHBmVjhsOGJkVU52czdlbDNvUWtpZXJjcHlqdE9CUDgxdm4wZ3hMUnVR?=
 =?utf-8?B?MCtmeDg2eEZTVjhNcXpIOWhyOGkzMDd0cStzV2I4QWZHekZ3UmxXUGJsVTF3?=
 =?utf-8?B?Q0tIVEZhYVU2dVl1WC9CbXZiTHVGNGRqcUVtRGU1dTVzcnN1YnlWYXBEc0lB?=
 =?utf-8?B?b0sydnhyblhsUXozalFuZ2dxTktUNXFIdUJ6YnN6RnhLTitZK1poM3dJc21K?=
 =?utf-8?B?Nm5jVTE3TlBoaWMybTJhM1ZUeEVmdkkrOWVTTkQva1NOWG1NK0ZPNHd5TStH?=
 =?utf-8?B?SDJaWUkrckYxTVRINVZzUE1ybWxpSEtUdlRyTnpLYUIzY2daRDN2eUlUY2tB?=
 =?utf-8?B?c3EzbDhKejF3ZVpaeVFtMkpGdzUzVy9LMFNsS1FhNFIzZlMwL1dvMzlIVTYx?=
 =?utf-8?B?OElReDBnWDhmazhlMTd4WmdzbXN4M2EzQVR2T1FjdXpUTEFKODIzNXUwQ1dl?=
 =?utf-8?B?Sk9uR0JRQ2QvT015QnVXaUZpS3pKY0Y1Z0w5b25sYS84enNiSHljV3NuZ2d0?=
 =?utf-8?B?cVEydU1oaHhCU0x1dmlTUWhOMktUNTV3S0NmcitEWXNncjlWYURHbnVYTjNN?=
 =?utf-8?B?eks0UjBoUG91bWtTOTI3bG5FeUMyQVF0aHlCcWZwRWlZSEpSMVoyT1ZpU1FE?=
 =?utf-8?B?Zy9uMFlUdXYvYUxSeXEraVVvaFczd05sa1VlSy80dUxRa2krRldlVE4reit5?=
 =?utf-8?B?VnlwMy94VWdGTFhkUEh2d1cwZTRMNHJGMzhjc013aVJYZEEwMzRzNjI4WXJq?=
 =?utf-8?B?eUpCUmtCZUZGOUNYZjEzN2Rscmp5NTk1cGpWbTc3UmFoRi9YN29QbUpIL0cz?=
 =?utf-8?B?bDRWK01lV05PbEJZL2l2a3VneDNEOU4rYzQ2T09LUGo1TisxMTVlejQwQ3NF?=
 =?utf-8?B?ODZ2WG9kTlhNclVNUW0wQUdyVGd0QmpqTzN1RXowaEFsQkhEODcyUERYdVBM?=
 =?utf-8?B?ZmFJaUEzb1BzZ0xWak9tdzRpTlN5Y2VqeVRJaXhValdWaE0vNVE5TDd3Umpw?=
 =?utf-8?B?akpkblB2dmJ6K09ocUtKRUhPOUI1QktlU3VqSTlCa3pERzU1NU1WejNvVGZY?=
 =?utf-8?B?Ujh6TUovTVVBSkNHUlp6dHBvdlMzSno0T21pdTZIV0Fzb1pEWWdOd1BGN1BD?=
 =?utf-8?B?bU5sNFpXMnB0UFZZb2JoZjlwd2M3K1ZuZ3FwWVlSZTgraHZJKzZiTHNIUGs0?=
 =?utf-8?B?Z1BLdnd5bWFSUzdubDVXZHdqOHZIYmJlU1JoWURvR25iRklUTmY2b0NwTTFv?=
 =?utf-8?B?b2IxNVp1SStKWjhZM1hnMDRZdWRTQkRxRXc4dWJLaWFtejN2VXBTOE1QcGtz?=
 =?utf-8?B?MHVoODNOU0xLdjdJTEptTXhMaXJSaW13SXg5cnprb1FDL0drbzBRQmJ6a2Mv?=
 =?utf-8?Q?SAKTWnE/VZygYtHl41wnyvY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D25FCA2D13D1F84DBCC33717737303D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb11b0e-cee9-465b-f0b6-08daf4e380eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 21:25:18.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khuSycfwqgapR1fTm19j1lFKErmwA+C1e9Ttse3Yjvl2otghyrJx/gdYF3nrOdN/I9pgCHNdPXriz+VyGtmepOMdrGdmJ4KYO3BC0IXGyDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4583
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTEyIGF0IDIwOjM3ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gPiBTbyBJIHNlZSB0aGUgaWRlYSwgYnV0IEknbSBub3Qgc3VyZSBpdCBlbmRzIHVwIGJl
dHRlci4gQ2FuIHdlIGxlYXZlDQo+ID4gdGhpcyBvbmU/DQo+IA0KPiBJIGZpcnN0IG5lZWQgdG8g
YmUgY29udmluY2VkIHRoYXQgaXQgaXMgaW5kZWVkIGJldHRlci4NCg0KSSdsbCBnaXZlIGl0IGEg
dHJ5LiBBbmQgZ29vZCBwb2ludCBhYm91dCBub3QgbmVlZGluZyB0byByZXByb2R1Y2UgdGhlDQpm
dW5jdGlvbmFsaXR5IGluIHRoZSBkZWZhdWx0IGhpYmVybmF0ZV9tYXBfcGFnZSgpLiBJJ20gc2Vl
IHRoYXQgeDg2DQpkb2Vzbid0IG5lZWQgdGhlIG90aGVyIG9wdGlvbnMuDQo=
