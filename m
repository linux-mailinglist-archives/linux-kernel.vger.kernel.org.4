Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B16B28F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCIPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCIPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:40:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB6E2776
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678376410; x=1709912410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YE7xNqJeZDDWxjTEUDtXgSFYVgyOF+SbAmVqFHl1LrA=;
  b=AWvCDiK89RxIn3/bE96aoDs3Hj5yBpnfV7j+7KaNTyjgtZPJJUdS6dy2
   gukvMnQ6fBgimFspq2YRQcbNy9TeQu77qHuM5PBcead+Bg/ZzQajHlf2d
   /C7RDAOZPjt2W6ZvBVsqUTPAoU5efS40SIh3RH2eLq87Wyb3FDbpYnR6h
   gfnjg2EMjb3FQ02YlaVx67bLleHa5zJUS5qIHV866d5mclw3B22XpXv/B
   +5u9nEeR5lg8q2LChY43wSZHbpFcxTv5mpIHnsSS3slvlKkUosNcdVE08
   p8UIqthTR2tdpbt2hMiLpeqYPRkgrm3qnk0wJCSh1PzV2MsQ90TekT2gG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338832743"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="338832743"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 07:34:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="820638770"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="820638770"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2023 07:34:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 07:34:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 07:34:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 07:34:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIuLsqRiKq/g3FyB6CSBrhT1Txb7gj4NNwuDZVvKo5N6SJIgcXMIwTG723pLUn3sw5kpVY9+n0idBQIAjZxmejf28mVuJO8P/wt5l0nsfb24z64wUlZQ8q6RhviL2olKLYMR7Ji+VKOZxwqrgNeC6yEeVNhF3vzzbmMHqsVXUdI0k5jD8e9QhJZemuMTQclDWbZqNfVh8mqRGMJfPQsQ210QZS9GDwZVHVvEEXOCEdalEAnVUILy1uI4V9icOeqLqdCEpNyNVqg9QjHbzMAtFtlAWQ+iQxNmlu5tnS8Acc+kEcs3bEN81Zlh0d6ouZeImyVxAe/NpwsVO3cWXdWxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE7xNqJeZDDWxjTEUDtXgSFYVgyOF+SbAmVqFHl1LrA=;
 b=J3Y+KsOWQ6S4nLOB45RuRsx/0Bflyi5M0U/Tq0ruewoLJrk1aDvh01VEc6KCHtSSov4pgDZAd/JdWxFvHJYeiUqTDwCholIxs2PWGSSLR3vzKNlGyOxV6TKlea6csOS+aM4TeB3RCPDcQAPNsy4tehs7QnYXMvsJs3Posb/R/Ee0VYCCToenAapbb0xSj2gFRK2QjP94UoZ0pjajaPm8yGC+F9AksmyHPLZKK86imOTUOupXar2i7Bxtn4+TJ0zI2VI0XRkWHrKkVjt5Pcy9lguz23gOiUmhtzKK/S81X57vG1mediePeYJ80B93g2Qn752IVU2K+i8UcA+lbJWCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.31; Thu, 9 Mar
 2023 15:34:27 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:34:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Thread-Topic: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and
 unmapped_alloc()
Thread-Index: AQHZUaIuxKgpIsIIt0SQaVbqG0tFBK7xsX4AgADVLgCAAA9QAA==
Date:   Thu, 9 Mar 2023 15:34:25 +0000
Message-ID: <8943835861763052c6a6e4d8cb774f6366b99092.camel@intel.com>
References: <20230308094106.227365-1-rppt@kernel.org>
         <20230308094106.227365-2-rppt@kernel.org>
         <47b5156d814b88ec894f38d245d0a09061112f85.camel@intel.com>
         <ZAnvqKtZdaD7FsdT@kernel.org>
In-Reply-To: <ZAnvqKtZdaD7FsdT@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB6189:EE_
x-ms-office365-filtering-correlation-id: 90022e41-18d6-4ae8-5bd0-08db20b3c3ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFHrIEvlidSoUGTGykTxgRb+57MYRNffG51hBlzqhMjv3kvnlxzo4CbijVU/WcVpspo3e+ToqSKhYm2INmVvDognN87DLxcCCjGUHeID9FBF1BdRxvPfH3/en70W1UpD85P3/SbHZEsCyFGg4lN/VZUr6v9m6Oae+PQdiXUvBL3JmYMFHlz85BZbaPHQ0QpCXRlxOBrI1DQf49xvyl6bYzZA2vEeB6+zVK+nckDflOAP+ztsSd3wHg43KtuAkLxZRQR/in1NNGlmBlIA/nEImQpuwFd7bUE4cM6vi50Y9dSAfQ5H50QB0TEripK3mX5ZFSXewwZzxM8b5B7bwWgJSSbbXxsTlLVi0i1psz+axEXGTeiqqRBRS49Fh+GJ4KE4ziFIjVUciCPe59CivyfBsKhXPVTr27FydPweSaClAedq5+wL/EwCTm4gnqX5jpeLhZn6WLb2FsU1G/ObKbbjEmhYg85phP3IwoD+xz6xY2Tt5bMCwrvB8qinhTjSrhNVBraf/T8srqJZqQinEIKYhyb6B2SWmSpdVF12p4l0bWD44u9SJubaEqG/ifMU+duLUUNcq8gc333EpfkCHosFdqG2Uh2DVPzx9oBvUzKiRyWnPFpjQbMbR94TNhVhAxrvya8+hlTotJSM/RzYgrrSaWfc5yvlA/IozSJWlY5ClHeTObnjlu/z09LVjfObFd84W+9FgHVLJ9qNvbGTbDwgYNWaALqmuQf+dALzBX82JFw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(54906003)(36756003)(6506007)(26005)(38100700002)(38070700005)(86362001)(82960400001)(122000001)(6512007)(186003)(83380400001)(2616005)(5660300002)(7416002)(478600001)(316002)(71200400001)(6486002)(41300700001)(6916009)(8936002)(4326008)(66446008)(66556008)(2906002)(8676002)(66476007)(64756008)(91956017)(66946007)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXN6VkZhSGJXeWFGMnE4bGttZWhHK3RLbjQrdVNla2twWkFVUzI0aVFPc2NE?=
 =?utf-8?B?Zjk4WEhFczkyS2JNLyt3TUlXMWV0SFI5ZHBmUXpEUVp5YVJrc2xTb0RqMzhq?=
 =?utf-8?B?cUpkREVTYndueVo0bnNNTzBKbUxhdEJIbjh6T1c5ZmhybWpPckJuMUo0cGtu?=
 =?utf-8?B?dW1Eem9ZRTlCd0lYdWVJeTNGcCtIaU81YnNieEsxQ2lTb2laNEplY2JRS3Bi?=
 =?utf-8?B?NVZYdGhjTHAvNmY1ZG9iRU5XdGM0SVY2M0xZNHNRQ1pwTUVYR2IvblQyUVJO?=
 =?utf-8?B?eTJKR2tHS1RSM3J4OG8wTUw4b0xoRnNkV25VQzc0MHZXYW15QzZXaW9ER2dh?=
 =?utf-8?B?eDBzUlRicUl2S2k2TXlhMGo1TVZtOFAwTmhXc0U2amIxaEovQkt2blhObm9u?=
 =?utf-8?B?c3JneDNOcEk5QjNaaUJJSCs3d2VvNHBVUDBERlhMV2FDNFhtSDVMM2RUMzBM?=
 =?utf-8?B?dnI3aVZmeEhMVjhKKzJWWDBBU094eDRkTytIM1lKRVJZcmNKM2Y0d0ZQbW1O?=
 =?utf-8?B?OHVRdDU4cTRsRDBqMzVBVjVlTUdGQnBRSDAya0hiNHRvTGltRm9WQnVSekNZ?=
 =?utf-8?B?UE43ZU1Ma0p0UzZNZm94UmlpTCt3SHRONjhjbU5kMGJJaTdxejlvaGNLdzRK?=
 =?utf-8?B?dzhoUFJKMGlNU01nTWtaUTdyZk1nVllVNEJsdDdybHRKNmwwRjQ0cWVwTXVG?=
 =?utf-8?B?bitSWHZibXNuRDJoaDRnOXk3aEszZk84NEFFTHBubEVXRUxXdURoU1FjVGVW?=
 =?utf-8?B?UytsTXRGQUc2Q1NmMFBvUlBiay9yMFZRU2RlUEdtQ2UrSklpSlV4OXpudjUv?=
 =?utf-8?B?dDM4YnpleDBKV1ZJQTMyckJrSmtUWnRaaWhvbDJaYUNKbDJBWm9ZNjBiQkhZ?=
 =?utf-8?B?UnZFTGFDZWw3V3pZQlVwd09nWkdCdGZzUVE4cHV0czN4eDVyajYvb09LQ1Bl?=
 =?utf-8?B?UDJYL25BL1dUUHhZb3A4K0lFYWRXYkYrYmh2aHQ3STE0elZRa1o1bFNiYVRy?=
 =?utf-8?B?ckszZEYwTCtuZkQwUVpFUXlVNlJCTVNOYlZzUml2djZ2Q1ZpdGh0M0tZeXlH?=
 =?utf-8?B?YXpyQ29Pd2RPR1oxd3RBVWJSeWI5RU1BQlRuU25sZTdoNjZ4OWEveThFYkY0?=
 =?utf-8?B?V1NuTC9LS240WVpmRHhKY3FPa0ljYlQ2MnFiV1NWcWN5dVRXeGw2cm4vV2VC?=
 =?utf-8?B?cWZSaDNOeHI0a2ZyZ09MT29UbElMZjhsaXFaTFpmMm9Zb09WUFRvcHB5d0Jr?=
 =?utf-8?B?d1FWV0hCSC9FMGFid0g2anNxOVlOZmJtRE9KUkhvK3FmZlUwb1JHWmFIckF2?=
 =?utf-8?B?VnhnVldtSEZEeVlMcGpYWXgzRVNyeHpFRC9ZOU1iOU1rb2lnaWw0c2lRbGxm?=
 =?utf-8?B?WkdLc2M5aTRIMjhzREx3VnVzUWNFZ2ZKRUhMUXRtMGZDUFg2Q21PeGdySzRN?=
 =?utf-8?B?VEh5bWlNaTBVeGl5a2Z0K3pNYll1YmptRGNGQXVjZC9JKzdBUGo0SUdwN1Vl?=
 =?utf-8?B?L2pSU2hodjdUdzBhVWJLRzhzYjZmWHRmQ3FMUkJEOGZmS2hMcUZxVlFsRlhN?=
 =?utf-8?B?eG5ycGFtRGRUbmFuRXNuUVhjYy83SVBkSzdISGFxc1NZTWx5Rjd0Yy9oZ2dn?=
 =?utf-8?B?ZlBqNmsrSDVZdjl0S1RnVnpwd0NYN3h2dDB6OUdTVXpJaUxsRSt6WWVkSGE3?=
 =?utf-8?B?SHRQbzJoZktJaEc3TW5zd0g2MUV6VWg5dlloVDRlMnhNMkt4ZWE5NWw4MlV5?=
 =?utf-8?B?UzdBNTBhVWM1TFNVL1dOWFRSemRSZ3I3MzRtaktFeWxwWUtPeUtiVTBuQlpj?=
 =?utf-8?B?NW9rOG0vWG1QWE8rb0FjeXJaZ2I5UWtKM3JsQU93U3k4RURnMU9pVDRaOWVm?=
 =?utf-8?B?cnhadFJ1eXk4a2RoYmk4NE11TzI5R3A1MnZwTjV1Tzgrc0JpMUdiK0JTRVZP?=
 =?utf-8?B?bmVFa09PSlVTU3dlbzFHdnhtbTVOSWRidkJJd3lOdld0Wmd3TUFNTVQybEt4?=
 =?utf-8?B?bUROb0tCb1lyRk5JQTFDb3N6cVB2MHRqNGZtQTJ0QkM5eXNrL2N2VjVldEl5?=
 =?utf-8?B?T3BnSlJsV3pPMnZ6VGZST2RPV21vL0J3TEU4Z3BJME5JMEpKby9qQVdWMzZa?=
 =?utf-8?B?MnczV0pxb1VpOWlhZldja2U4ZmlBclFOWlp4L2pWVStVSUU2VVMydHorZkF1?=
 =?utf-8?Q?00S3RFjXBCipeLiWEoH0AW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14D601D08B947949B48D35BFFFA6806D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90022e41-18d6-4ae8-5bd0-08db20b3c3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 15:34:25.6988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqjxeFgJ1aMbn7YVxqQiG0Ho++epRMsRdHCfye7l70lJCP7K6ZZFfDKhAqsgtnj6ytV7Dd8v00k8ekb/pdh3xGZl2Um+ISspQfhmgL3cyoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDE2OjM5ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUaHUsIE1hciAwOSwgMjAyMyBhdCAwMTo1NjozN0FNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjMtMDMtMDggYXQgMTE6NDEgKzAyMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGlubGluZSB2b2lkIF9fZnJl
ZV9vbmVfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQNCj4gPiA+IGludA0KPiA+ID4g
b3JkZXIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgY2Fj
aGVfcmVmaWxsKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBwZm4gPSBw
YWdlX3RvX3BmbihwYWdlKTsNCj4gPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBidWRkeV9wZm47
DQo+ID4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgY29tYmluZWRfcGZuOw0KPiA+ID4gKyAgICAg
ICBzdHJ1Y3QgcGFnZSAqYnVkZHk7DQo+ID4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7
DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZmcmVlX2FyZWEtPmxv
Y2ssIGZsYWdzKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgaWYgKGNhY2hlX3JlZmlsbCkgew0K
PiA+ID4gKyAgICAgICAgICAgICAgIHNldF9wYWdlYmxvY2tfdW5tYXBwZWQocGFnZSk7DQo+ID4g
PiArICAgICAgICAgICAgICAgZnJlZV9hcmVhW29yZGVyXS5ucl9jYWNoZWQrKzsNCj4gPiA+ICsg
ICAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICB3aGlsZSAob3JkZXIgPCBNQVhfT1JERVIg
LSAxKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgYnVkZHkgPSBmaW5kX3VubWFwcGVkX2J1ZGR5
X3BhZ2VfcGZuKHBhZ2UsIHBmbiwNCj4gPiA+IG9yZGVyLA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYnVkZHlfcGZuKTsNCj4gPiA+
ICsgICAgICAgICAgICAgICBpZiAoIWJ1ZGR5KQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgICAgZGVsX3BhZ2VfZnJvbV9m
cmVlX2xpc3QoYnVkZHksIG9yZGVyKTsNCj4gPiA+ICsgICAgICAgICAgICAgICBjb21iaW5lZF9w
Zm4gPSBidWRkeV9wZm4gJiBwZm47DQo+ID4gPiArICAgICAgICAgICAgICAgcGFnZSA9IHBhZ2Ug
KyAoY29tYmluZWRfcGZuIC0gcGZuKTsNCj4gPiA+ICsgICAgICAgICAgICAgICBwZm4gPSBjb21i
aW5lZF9wZm47DQo+ID4gPiArICAgICAgICAgICAgICAgb3JkZXIrKzsNCj4gPiA+ICsgICAgICAg
fQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBzZXRfdW5tYXBwZWRfb3JkZXIocGFnZSwgb3JkZXIp
Ow0KPiA+ID4gKyAgICAgICBhZGRfdG9fZnJlZV9saXN0KHBhZ2UsIG9yZGVyKTsNCj4gPiA+ICsg
ICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZnJlZV9hcmVhLT5sb2NrLCBmbGFncyk7DQo+
ID4gPiArfQ0KPiA+ID4gKw0KPiA+IA0KPiA+IFRoZSBwYWdlIGhhcyB0byBiZSB6ZXJvZWQgYmVm
b3JlIGl0IGdvZXMgYmFjayBvbiB0aGUgbGlzdCwgcmlnaHQ/IEkNCj4gPiBkaWRuJ3Qgc2VlIGl0
Lg0KPiANCj4gWW91IGFyZSByaWdodCwgSSBtaXNzZWQgaXQuDQoNClRoZSB0ZXh0X3Bva2UoKSBm
YW1pbHkgaXMgcHJvYmFibHkgdGhlIHdheSBvbiB4ODYsIGJ1dCBJIGRvbid0IHRoaW5rDQp0aGVy
ZSBpcyBhIGNyb3NzLWFyY2ggd2F5IHRoYXQgZG9lc24ndCBpbnZvbHZlIGtlcm5lbCBzaG9vdGRv
d25zLi4uDQo=
