Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA969CF91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjBTOlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjBTOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:41:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781713D4E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676904059; x=1708440059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T8YgpE8YE1ztbm+q3CV/OHJPdqsXm2bB7AfFvBzwBF0=;
  b=WpjwwzMImYF+MDz/OSw1jRwReoSgLDHa8Ynq+GIDv3VE40mudWAqvpSy
   BdIo45esh28GegIkdiKJbXaAJH3wYa1BaMnV2WpMQh4FcwpDHlH1rW17u
   bjsSHFG03gSRvE0GHrFUqQxe9IndkEB7JvFsQ1mBhK+bnRt5mSZWqeXNU
   8kgLF8A1tzTcv6GEz7wnmDQXQRPZotLWSh5f8TTvnH97kE7pLvOpAKlGu
   Qzk/En50FfjadpcujEuIzW6ivQe2iGnlc1tvqf9QkfWxv6zHAkNAOp+uY
   j81SgK6O8H9hEV5Shk8kE/GkgHjwlEr2rltjF6odpLc7KK+/Y3sjRryo0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="330128415"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="330128415"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 06:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="648847617"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="648847617"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2023 06:40:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 06:40:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 06:40:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 06:40:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNJpcet/+RBGiZ2GX0yrrztpBUqE7SGy2SaEr5Hns/BRS0FL5F3SOueIZC+Jvh/gpxz8x1SXeRXKtDVvlg42ozpGw/RRdj7aZUrXA0fB0GM4ciJ2wE7//gGRuyXmIolZHuYXMsjAe7amjYZ/MoFf7PBoUw5F3IhTohAz6J8w3L5hw3nILRMcTf/LZDl4tDiBmXpH2l/eJ18MoE4jnT9F/3+iqlpmRioonP3BHsCRJwDdIgOVDtyCQFgQmQuxDYvUWf25Rryxwkd07gbp+13CiIBLun1uZyftIM4t1V/TD5ED9B7Pw24QiMCdMyyV9liTuppIq9Teor3P3Te+JSjEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8YgpE8YE1ztbm+q3CV/OHJPdqsXm2bB7AfFvBzwBF0=;
 b=FI4HIAQx0zikRGuLJi+1GPmEfnOR4w7uY/T6N1bX/K54Zs0VxjwgOYk/nQFqMrVP9eARU+pSrl/LZ4zAiafqN2irR7UODgX1muHsubgNiP0jX6Dpcft066lceDmGr7y0CW3G8feey/b3aTf3uKRR6LbDFVBWTbv+fWmualQcc7f66K3v0D2LDl7spg8vEqgmXH7p0FRuHWQIbU16d9d+2WgaSEbc7bcPyBmFdYQIly5wNhJ4AABsTl3pR4YpWbM8fzc4eMvIseIg6C3r2YfrZZucqFAqYoHE4vTZIq2XsdiD2dNy3OD7Tlhw5jc+/ikDw2/85HvVc89j+z0jcE/ESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 14:40:56 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 14:40:56 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Topic: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Index: AQHZRNuCmUZrj67G7kGhK77N+UN9Nq7XpKWAgABETwA=
Date:   Mon, 20 Feb 2023 14:40:55 +0000
Message-ID: <86feeb182cea8f6a6f850dfc4495daf01ee51558.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <Y/NNKdAtSZv631Z2@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/NNKdAtSZv631Z2@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB8124:EE_
x-ms-office365-filtering-correlation-id: 1722d9ad-53cc-4a43-7171-08db1350797e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nb4xdWrnSYNnRjWaOvotM14A2m9KJwkbVKkhDn1bpo8ac59vbp4kF3z6EIjeTzD2yjbuDr6oABPyWUuVzKOJVNozuAk03Wo+VXf84VlKKzaSsC/s1I/YCz4NDregF7wpZDRGiD2Ezm2FdWr/DsaKj+S7u2QfGMcHE0FwKTFTeXzVpKVX5aUawUVnkZNaleezwb5e2CJufoWFk/y6ORN7OUc8kXNXHNjr0yw2t7tUM1reT800+RYdVtzBR5KTdmfgs0R0eFz+Y1xvSUxXewtWx5b3O7Yd0rDe8Z6zJSbYB/SDDFlTtanl/HYv8oCyhdSer244esdJ8J/CenmzuhuG2zfDQEanbtc4iZZdQwfxeXBqOP5JyP4RlbRyvqcSazX8grxVBaMiw3C0dO1ifGjGj0JyYRBmr4iJY7SCyUY4kIG615jqb0rzRZG8UkKH+KefF6i8KS818poWt363MtyfRmZy032tdB+ypkrQvxb4B3mS3YSf1wXpB2HRRAOrJClwGEtNWwgGUIEcRx9YNo0yQy51mwQHjPqJdGkiWbcheZnJ30jmKBe8WMfDuHDn98oFhpqdKMKllciZfu6JsxfomS7q7XrYVZdMPSfacPmPLgEwSJ5xMENneXcUTJfKXd+a3b38OWXfNNdoq4dp+jLcPejaADFTzVLVxIbYcF3xgGuvd0GsASIfIg8AEFPcxyI/F56+Ak23JTi+yfnDF+hVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(346002)(136003)(39850400004)(451199018)(5660300002)(478600001)(86362001)(54906003)(316002)(26005)(186003)(66446008)(8676002)(6916009)(2906002)(8936002)(4326008)(76116006)(66476007)(83380400001)(91956017)(66946007)(66556008)(64756008)(71200400001)(38070700005)(6486002)(6506007)(6512007)(36756003)(38100700002)(82960400001)(2616005)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGM1Wld2T3VCK3JoUFlHTzJONUhqWjVjUWpmUnkvcm1FdFU5am5tcGF3ZDYx?=
 =?utf-8?B?MzZvTmVHM01ScWVyTjVwZk9Td1NHS2NnK0xOZjVuWHZxT2VJYktJTXk0VUFC?=
 =?utf-8?B?T2RBdzhUOHhweFJRTUVmSWExeU4wT2t2Wng2cWNMSmNQRTBBSnBselY3V0dJ?=
 =?utf-8?B?ZGRYaENpWmVPeHpnRFdzL1NVWVY4cjdaV3VjVlg0TWdPeXVVcG1nY3dzSnY1?=
 =?utf-8?B?Nkk2cUc4ZktRWHNMcUdEd2ExYzc4UDBBdG9obnY3bzFJZXRxRW83WmJaNlRN?=
 =?utf-8?B?ZVdJNWhwaDEwajdobFFYSmJNUEhNcFpDVUl6WG91L2VZaGhMM0dNVE1mQkRV?=
 =?utf-8?B?eWRpS2lPdEN3TU1hY2cxSUJsU091eDU2UEYzVGxwQmc2TlJMN1JRV09RZGpq?=
 =?utf-8?B?NVlhdlduSDM1UllMV1VuWDRDZGRtN0pieHRRc1cvU2xlZlp6Zkdxb0IzMElK?=
 =?utf-8?B?ZFptVHNpK3JzenhuUFNZT041Vms0TkpjL2FnK2xsUnEvNW5FT1p5OXNWd1RL?=
 =?utf-8?B?KzhrWEpjM3pqTWtWRGRwN0hCWWIyd2dpMDBlajVzYjFnd0hIbTE2cXZZL3Fu?=
 =?utf-8?B?MWRTQktITWlJUFBaMGVwck4xYW9uc1hnaTdwV0ZBWko2dGh6bkNuYlFVcmxV?=
 =?utf-8?B?KzZ2RkdqYTBVK3lBcnhJVmJnV1hGZlZvSUlGN2pTKzVOWnhsanZpSVNNNHFZ?=
 =?utf-8?B?M2xaVm1CUEx2U3NkQlBVb3NwYXFuZ1d0YzEyMDJYMzBWakRhMUp3K0pwSVV6?=
 =?utf-8?B?cFI2YSt5Rk9lMWE3TnJqRTE3NENlbFVNODVqeStGY2ppSTQvWGgvZnBHNjBN?=
 =?utf-8?B?b2Zackk5TVMwWk9rN0gxbVZMQjNCOVFaVy9ON0pVUDZBbUtvdmpqY0tjUVFJ?=
 =?utf-8?B?QW00cTRmK0ZYc0FwVG9KdVZjNXlFbnhpZ0FUanVkMWp5bTc2QVhPRXA1SHpG?=
 =?utf-8?B?SldUYXNBQXJvVlV1RTdZdVQzTGRoSGgvY2tZVytuS1BPYzZPYTg4dVVqeEx4?=
 =?utf-8?B?ZnJCZnhCSkI1Q0UzRVBZS1NGS3MzY3l2bjJ6RENMaVFUWXJmSktqc1N4aFNC?=
 =?utf-8?B?alI3OGFJOVZaeWI5TEVIMFZPOFJIbE1XdzNCTCt4L0pLUWM3cDl5NVRlcU9y?=
 =?utf-8?B?NWNLZGtCWnZLcEdBOGp4WVBFZit6b1AvSXg0eVNaUjRmQjBBR1p5ZDkyNjlW?=
 =?utf-8?B?Tk4yVDFUL081eEtadTFSMzZNQkdzSjBvSDQxakI0Rmo1V0E4eENmZHpzejJV?=
 =?utf-8?B?akRNVjJnRWNaNmJrSkwzWW1mMnRvTjVtaGlWRXkwK3NuM010dE0vYXRZNGFZ?=
 =?utf-8?B?ak1jOHAvSytkeUxuY3I3RExhaTA4ZGszcldSdUE5NjdOTHBkaUl1dVFsZ2NQ?=
 =?utf-8?B?K2kwWlliRVI3ZEtlMkpMejhDRm41eUxSaXlRWmlrbkhMa0dHWEVKQ2s1Rkp4?=
 =?utf-8?B?SFRmOEpSYVg0WW80T1pOZkIxcHhYc3NoQlprc0VTa2NMNGlwYUJkMHRjc252?=
 =?utf-8?B?cG1EL2J4VHJRK0lsY0FHeUE5QUxvd004S3MwU250ZG9Nc0ROWWlPMWlLMXow?=
 =?utf-8?B?bmNDeHpMbDJMcndobjVtVVhTTHVrYUZZOVdxQlozZnloQkhZWjJZSW9CdFJW?=
 =?utf-8?B?QnlRQ09UN2x3SVZiTFRGcVdpSVU0TG9VaHY4aDQ3NGw0ZUtjNldmZlZ6T2lH?=
 =?utf-8?B?NkRTS21XaFZxeHR0bVQ2QWlLbmxUZ2ZxRFdpNXhkcmhURlFFN3c3TCtlUUQy?=
 =?utf-8?B?S3pjbUg5UW9SeWQ1VmY5ZVhiaEtOUXFVSVU1ZVc5SUR0TGsxbURrV3lMa0Vv?=
 =?utf-8?B?eHJNZWcyZDlYTFZpWVRDejBZeHdnZnJlNG9zZFNIQVFMZFY3ejN4VFVWTkJX?=
 =?utf-8?B?Qkt6cEtLbm1iSG9Bc2xkQ29lMzRRR0FOU09DOUdzaEhCWkJ5V3U3M3lSRHVv?=
 =?utf-8?B?b3daQzhPT3ZPa1lXVUUxamxIYmV2OUdaTHJabTZBMlU2Tk1lMmdGVWlMUklp?=
 =?utf-8?B?SGFibnFycHRFYWZNYnFRaDVMRlQ3Mk5YdXJlMHB1ZmNlNStMQjZuOWx0MFFs?=
 =?utf-8?B?azJGK0owb08xMzU2eVJrb29aSWx4R3dOK2Qrd01FZW5kc1hybFBIcjBQeUxi?=
 =?utf-8?Q?5apH1FFIFEeurCG4oDhq7B5jQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4098C7A2C7C4F944AC8169A685D1C6E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1722d9ad-53cc-4a43-7171-08db1350797e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 14:40:55.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLdJFr/vAPGp4PM5g6M0l7Wu6KLtvtcgIzwjJ5xLF/N5MjCr6nYCfzi2MptfHEXwLfWb146fNFdyCLSX30H74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDExOjM2ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gTW9uLCBGZWIgMjAsIDIwMjMgYXQgMTE6Mjg6NTVBTSArMDgwMCwgWmhhbmcgUnVpIHdy
b3RlOg0KPiANCj4gPiBTb2x1dGlvbiBmb3IgZml4IHNtcF9udW1fc2libGluZw0KPiA+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gDQo+ID4gUGF0Y2ggMS8xIGVuc3VyZXMg
dGhhdCBzbXBfbnVtX3NpYmxpbmdzIHJlcHJlc2VudHMgdGhlIHN5c3RlbS13aWRlDQo+ID4gbWF4
aW11bQ0KPiA+IG51bWJlciBvZiBzaWJsaW5ncyBieSBhbHdheXMgaW5jcmVhc2luZyBpdHMgdmFs
dWUuIE5ldmVyIGFsbG93IGl0DQo+ID4gdG8NCj4gPiBkZWNyZWFzZS4NCj4gPiANCj4gPiBJdCBp
cyBzdWZmaWNpZW50IHRvIG1ha2UgdGhlIHByb2JsZW0gZ28gYXdheS4NCj4gPiANCj4gPiBIb3dl
dmVyLCB0aGVyZSBpcyBhIHBvbnRlbmlhbCBwcm9ibGVtIGxlZnQuIFRoYXQgaXMsIHdoZW4gYm9v
dCBDUFUNCj4gPiBpcyBhbg0KPiA+IEVjb3JlIENQVSwgc21wX251bV9zaWJsaW5nIGlzIHNldCB0
byAxIGR1cmluZyBCU1AgcHJvYmUsIGtlcm5lbA0KPiA+IGRpc2FibGVzDQo+ID4gU01UIHN1cHBv
cnQgYnkgc2V0dGluZyBjcHVfc210X2NvbnRyb2wgdG8gQ1BVX1NNVF9OT1RfU1VQUE9SVEVEIGlu
DQo+ID4gc3RhcnRfa2VybmVsKCktPmNoZWNrX2J1Z3MoKS0+Y3B1X3NtdF9jaGVja190b3BvbG9n
eSgpLg0KPiA+IFNvIGZhciwgd2UgZG9uJ3QgaGF2ZSBzdWNoIHBsYXRmb3Jtcy4NCj4gDQo+IFRo
aXMgaXMgdGhlIG11Y2ggcmVjdXJyaW5nIHByb2JsZW0gb2YgDQoNCg0KPiB0aGUgYm9vdCBDUFUg
bm90IGhhdmluZyBhY2Nlc3MgdG8NCj4gdGhlIHN5c3RlbSB0b3BvbG9neS4NCj4gDQpFeGFjdGx5
IQ0KDQoNCj4gSW5zdGVhZCBvZiBmaXhpbmcgdGhhdCwgSW50ZWwgc2VlbXMgdG8gd29yayBhdCBt
YWtpbmcgaXQgd29yc2UuIEF0DQo+IHNvbWUNCj4gcG9pbnQsIHdlJ3JlIGp1c3QgZ29pbmcgdG8g
aGF2ZSB0byBnaXZlIHVwIGFuZCBtb3ZlIHRvIERUIG9yDQo+IHNvbWV0aGluZw0KPiA6Lw0KPiAN
Cj4gUGxlYXNlIGNvbW11bmljYXRlIChhZ2FpbiksIHRoYXQgb25seSBrbm93aW5nIHRoZSB0b3Bv
bG9neS9zZXR1cCBvZg0KPiB0aGUNCj4gc3lzdGVtIG9uY2UgYWxsIHRoZSBDUFVzIGFyZSBvbmxp
bmUgaXMgY3JhcC4gT25jZSB5b3Ugc3RhcnQgYnJpbmdpbmcNCj4gdXANCj4gQVBzIHNvbWUgdGhp
bmdzIGFyZSBmaXhlZCAtLSBpZiB3ZSBndWVzc2VkIHdyb25nLCB3ZSdyZSBob3NlZC4NCj4gDQo+
IFNwZWNpZmljIGV4YW1wbGVzIG9mIHRoaXMgdGhhdCB3ZSd2ZSByYW4gaW50byBpbiB0aGUgcGFz
dCBhcmU6DQo+IA0KPiAgLSBkb2VzIHRoZSBtYWNoaW5lIGhhdmUgU01UDQo+ICAtIGlzIHRoZSBt
YWNoaW5lIEh5YnJpZA0KPiAgICAoYW5kIGlmIHNvLCBob3cgbWFueSBkaWZmZXJlbnQgY29yZSB0
eXBlcyB3aWxsIGJlIGhhdmUpDQo+IA0KDQpJdCBpcyAiZ29vZCIgZm9yIG1lIHRvIGtub3cgdGhp
cyBpcyBub3QgdGhlIGZpcnN0IHRpbWUgd2UgcnVuIGludG8gc3VjaA0KaXNzdWVzLiBMZXNzIGVm
Zm9ydCBmb3IgbWUgdG8gc2VsbCB0aGUgcHJvYmxlbS4NCkkgd2lsbCBicmluZyB5b3VyIHN1Z2dl
c3Rpb25zIGJhY2sgYW5kIHNlZSBpZiB3ZSBjYW4gaW1wcm92ZSB0aGlzDQppbnN0ZWFkIG9mIGNv
bXBsaWNhdGluZyBzb2Z0d2FyZS4NCg0KdGhhbmtzLA0KcnVpDQo=
