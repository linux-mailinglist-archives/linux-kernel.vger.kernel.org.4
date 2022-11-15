Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29A629FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKORFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiKOREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:04:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4C626ACD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668531885; x=1700067885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0sWPB6huMOB0bqgwKrsc3sRb9VOGl+xDRW4SS5VtDjI=;
  b=YBslNpziYW/mtHqa+GWH2/4HPPioyjJhHj9frYtOc3RE/wDSvqkOllmP
   8kyebE/baS0pj6rfYeyE7EPns9xK8i561+P/1D/64PLmfplluPjfCwydl
   P16ArUrl5F5tSxL6Bwb94C65v/ouhhTIipzmxi23TLsuiQD3tSo3rdFkd
   X9Qouk24XptX07GHgcr4qAuOarO2/1v9SHk2y0Dm3Yc+ShY8Q8Iy9n8AT
   njpagtFWHF2JN8iFh+fyHDYsNmgg3t3W/VKBJ4apXMfdAvT1c/163kAGF
   WFYauVZgMWiZIYSHnUb/kJfYjestYXL0UF6Tf08puPpjSZ+Qbgpy4fxw2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374441121"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="374441121"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:04:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="763983080"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="763983080"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2022 09:04:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:04:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 09:04:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 09:04:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnrZ3vITCF9c19GJYHr2HWvKeBG+OvCwT0mW7ieQr/RNGCTKM3BgmNaOVWf0oZftgE5oXIBIGIe2krC8fwqdRNhGPTRW57q/JUeSpFUMItdG3/u/fXAF0OUYQmffI12PFQK+2OopZoQutN6B+iDvy6ffV+vc+9CA+tU4WcjHR/smsm2HAB5Vyt1LA8nlczUYDsr9G+G2hMupczKjDOLg2/XfFNZ8jxIg8DWu5J/+y2L1t3b/0ThGD5KjnoRlQKME+08Rv3sikx7rNUVp+YwBL5R+PnWkb3xDMabT8ucy+VIu1lz6UF07bDIidwjH4f8a3QdVSgX5eXIc04MQJlyZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sWPB6huMOB0bqgwKrsc3sRb9VOGl+xDRW4SS5VtDjI=;
 b=gTaXlj3mq6fC6xbm4+TdqNBD4FrJRiHCKDvWvtDTcL0T+TGzEphqxdfiVw2A95+oIB+O530bpXZuXzM4jMLL//uvlMI/abU6bBhbe6KMQyOddXC5RYw8fd7JO7za4plveRkD401APi/jZbSpCoyhuy9cNuMizt4DFWfIYf/Bdo4I8yltZ8FnRoI3AMSpnYwkDFAdlvmCz5SAnvmEAx9Hu4ntq14dLN4c0jBVFlr1Rxd4axE2jQVyoA20FOQXml+IOiOE8utAjrcxdbuSRbGfhrztgdTBS8QX3hgywd1xBLaQws7fzodK7Czp25RbU2oJU60kT5nK4Iek/qCr00wosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB5539.namprd11.prod.outlook.com (2603:10b6:610:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 17:04:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 17:04:40 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: CET shadow stack app compatibility
Thread-Topic: CET shadow stack app compatibility
Thread-Index: AQHY+H8FF0IkDR4atkCzeBv5Re4FS64/vJSAgAB7H4A=
Date:   Tue, 15 Nov 2022 17:04:40 +0000
Message-ID: <883ed1a3f4de8d508c4bc2f504ae4a5c8db19a20.camel@intel.com>
References: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
         <Y3NfX0zXDIZztwKL@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3NfX0zXDIZztwKL@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH0PR11MB5539:EE_
x-ms-office365-filtering-correlation-id: 3ffc50f5-8b7b-467e-5f54-08dac72b7bee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRO9V+fkM+2knL99OCDYTKJeuENM3tqXcqbMFm/zC4lL2ir7p7DWD3H/G9SW7Qe/gLMH4V2+lMYy2HWetJA/0l+WE1rs/EWijOouN/g598VvO5/m75JzR7kDkvW9wqnzMH3+u2k6BteN4bHyQkEKw09ZIKzUd8gEVVqroXGZvW4eokw4sNfHJs008GwI2WT8ni3zsniJc9NMwujmsCRGoHnLnt88Rz1LNhw8TcwXgOODzFijcHRfc8scwpAFXIFfPbqvHCIqUD7hjohwoZSE7m5hWpcCuCf7ZxtRKcYcd7cMuscsA+ErkI0necmiZFEaFgdQu8pX3tfKLl+3E0SJHZ+iu4um2GXZkYgwJlV1SfCvl4IXaDzQcQwPGVCY4GSaLdLjn5SsngoZSulTHes1yxXhVGV0W7W4qVYaTUOFfr3GW260ZzYjec4hwnrdJgY5Uz7wzC4GJXT0C3Km9wZsolPmzG1z/F6kFL23ZSOtkO2oiyazPiFhLDz2HAa2V07PxXEwK4xREYJMpNq9lyF4ZDFvkAu6UBBe3VLU0JShHp+HxxRJW9oVHQTu7VLjfHyvzweSa4VVUZr5GTjDOKIZHv2xooO1t8t2H6jzvIa52lUzsjfJfuomORok9ms6A5V9H70NLg4XlabOIZpLj1GrHetGS9yTwsAnD3sDiLjdhb6H5t61CJzlzIXCephaQFbGtcat06rm3Gik/K+aWL6I3z/T/BcMRRZYQECT8vrvGttXlknJHtnYQAOTq23rPS5uFWVU0L6+R/jZrdR/cjR8bCtfchPc6viLqhO/zdVkcaQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(66899015)(36756003)(38100700002)(122000001)(4001150100001)(2906002)(41300700001)(82960400001)(38070700005)(86362001)(8676002)(4326008)(64756008)(316002)(66946007)(76116006)(66446008)(66476007)(66556008)(91956017)(2616005)(186003)(6512007)(26005)(71200400001)(6486002)(54906003)(6916009)(5660300002)(8936002)(478600001)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzRzRlByeXFkbmFrZWRHeTdGNHZGMVpkWHRNWk5CUjJ1eERsRFcvT1VtR3RS?=
 =?utf-8?B?blNZT1h5VUxoNkJYZjd0bUZDWDhYWUJrT25QOVY2bHcyQ1N5QTM4WFdOd1Vy?=
 =?utf-8?B?ZkErMUVPT1JhbG9ZUzNOK3RRWlNWeFBZK1VqVXhsRzljcktUZkY4SzcwTGNq?=
 =?utf-8?B?TWVRc0wzbmNqM3BWTEgyQTdSMmN4d2xYc1UzUHpKYWt4U2NwWXJZSkVvNVIy?=
 =?utf-8?B?WDh5ZGVUTGY0RjRrMFZ2V3l5ZXovQTQzNGtDa2VOcVJGY3pRSlZLN1pwNGUx?=
 =?utf-8?B?THdyTllqOVMzTHkxODRNSkR2ZGhZYlduV2NWVVMzRVlvb2JPZXhYYzJ1N09i?=
 =?utf-8?B?MDJpelNPcWdraTd3MnNjcm5ianJ2OWpYT2dic2NJM3ZydS96Qi9hZGJMd0x4?=
 =?utf-8?B?MUt4cnhjcW5NOU1LSGFvZm9CV1Iyb1F4ZUVmd21VYW1sWExBRDg1TXIvMU9F?=
 =?utf-8?B?ZTlsbUN6cEVOS3JUZlJsamhBZ2hKRjZxbTJPaUdmOW1BWURYSE5tb2FCRUxW?=
 =?utf-8?B?U2o3dTgrNzNuNmJDTFBNSVN6WDVLUjZZcmhOOW1CSlI1S3BkOEd0azhDMy9H?=
 =?utf-8?B?MEFpZTlkTlc0SHVLTlNOMThyTm01RS9BTVNJdXVnamJ1Y0IxVlNybGdpVms3?=
 =?utf-8?B?NTJqNC9STlVtc3JFSk9NYVlWN0hDbTdMa3B3SXMzekNxREFZRS8vMmJLMTRv?=
 =?utf-8?B?ek1RQ24yTnMvQ0JkdkNSbkFWbjMxYkxjRmRtWTdxTEpvdWh2VTIyTjJGYVpy?=
 =?utf-8?B?c0UzQ25tbkl5anl3RFNUOXBySUwrNm9RSkg0Rmt0bTlDQUVMcnRNb0psZjNJ?=
 =?utf-8?B?bmpLdTAybUVUckRpbzR2Y1hpeVpwZXFpWmgzM29Wd0p5WHBQVVpWRFloTWxm?=
 =?utf-8?B?cnNaYnBxNHNwTHFTQzJZOGUzVmNsbStCY3ZwbkY1UFNYTnlPaTRsN2NHRktt?=
 =?utf-8?B?ODhqM0pzM1hWVm1RVU9NeHNDS3Y0S2lpb1orWW40dmJIS1ZKbXZHRlZXRTUw?=
 =?utf-8?B?UzNqcGpRdWd5c05Td1ZPUlRWa2s5ZmlMWVh3ZEw3cU8zWEdFMjM5NUhtZTJy?=
 =?utf-8?B?dEVMRGRrcDg5aTRrZVZNeXNpQ1U1U3NzNHNiVjcxSnZCNFgraGxTOHVUTkR6?=
 =?utf-8?B?eFlsazl2ckZDZkpteDJLSWZKNHFEaVNXM2tQTEtBNW9lNy85RWNWWk1WWDZV?=
 =?utf-8?B?UWFUQkZnRWx5bVp1MENGenhzWFF0cXprd3hub2pxVXhKOXg0d3dORkJmcks2?=
 =?utf-8?B?dWJFU2dKNHRrWGNDVFFFaVNvQnZvWDJLc2hrRmM4QzhKNmxvKzhDOW5NT1I4?=
 =?utf-8?B?UkZUUVZmNUp0VnprY21QVVlOeFluRUl6L2ZQQUZMeXdzYTlPdzQvV1dmZzgr?=
 =?utf-8?B?eEYxS1BFaDd0ODYvdFRPcVRqS2FTNlFqS1VHeWZPTWZjc3NuRUhKS0xBc2NH?=
 =?utf-8?B?NjBFZzVJdExUVXcwSFVxM0tVaEJHeEFKc2Z0RkQ1YjF1ZE5CWEg0TERnKzU0?=
 =?utf-8?B?bjBrbE83L1V4SWdtdExMWVB3bHhNcXh0Q3VIM1dLakhHVjFrWG1HUU9xT0x2?=
 =?utf-8?B?SmRMZ04zREJ1a2JOMkhPY1FJSHRYK2w3cU9qTll0RmZXc2xWYUs2N1o2cEEw?=
 =?utf-8?B?UHJOcStodGVGWU9sNlBRV0YzMDd2Wm1VeE9Xb2NoeWl0REE5SDNKSzJteG1C?=
 =?utf-8?B?cjIwUkpXaS9lWUpMcmJOcHZzYUFNeUszYVhESlRMUk80Y3ZYcjFSMXlmQXE1?=
 =?utf-8?B?K01MWXlKZXFyZEoxMkRzQTJmQjVMMUw5b2pkZTd3ZnFtaXlzWEZucm92YmpX?=
 =?utf-8?B?SEJkUUxjZGcyeGlxL21OL2RjTndhbHhOZzBZWmJOMlRBTy8zdWpkNysxZ2U1?=
 =?utf-8?B?c3prUzFJNHpwL2tOUm4yVWU2Q3NXWWF0dnRTbkJSbHduZHQ4bHZTZ2Qva08y?=
 =?utf-8?B?QUIrMU5BQnlMK3h4WGNZdEJjNGdwMS8wbk11REcxcjBhNUhHcG5VU1lRMjNL?=
 =?utf-8?B?Sy8rcGtQK1A1ODg2QnZtTFJ0azBRMTFkY3hDakwzYytucGNMSVFwaDdNWW9m?=
 =?utf-8?B?c3dZbUFEcVFrK05zbitjWFpSTzFCZkxpM0JXSDJNTjVlemZ1b3NuSFFvb1ZQ?=
 =?utf-8?B?eFNjdHFJTTVLWVZJRkpTQjFqR3FqdWtHYWRDNS9taWR6Z2FDWmpyQW5lUHJr?=
 =?utf-8?Q?EHaxjdtphZgvyH7qlobVEmw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE15B8016B909B44B15B11793784688D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffc50f5-8b7b-467e-5f54-08dac72b7bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 17:04:40.2774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6C8ygOom10N89HQ5fcuv1TBtUCRwuYV9KsbQZOWJehgqkRNqxLS7fFNRTn6nzWri4KQcU0w9HRvjs3YIdUCIXW3V/W1Hu11b6O2tP2jgIYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5539
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEwOjQzICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gQ0VUIGlzIHR3byB0aGluZ3MsIGlkZWFsbHkgd2UncmUgZnVsbHkgZXJhZGljYXRlIHRoZSB0
ZXJtIENFVCwgbmV2ZXINCj4gYWdhaW4gbWVudGlvbiBDRVQsIGV2ZXIuIFdob2V2ZXIgYXQgSW50
ZWwgZGVjaWRlZCB0byBwdXNoIHRoYXQgdGVybQ0KPiBoYXMNCj4gY3JlYXRlZCBzbyBtdWNoIGNv
bmZ1c2lvbiBpdCdzIG5vdCBmdW5ueSA6Lw0KPiANCj4gVGhlIGZlYXR1cmUgYXQgaGFuZCBoZXJl
IGlzIGJhY2t3YXJkIGVkZ2UgY29udHJvbCBmbG93IC0tIG9yIHNoYWRvdw0KPiBzdGFja3MgKHRo
ZSBtZWFucyB0byBpbXBsZW1lbnQgdGhpcykuIEJlIGV4cGxpY2l0IGFib3V0IHRoaXMsIGRvDQo+
ICpOT1QqDQo+IHVzZSBDRVQgZXZlciBhZ2Fpbi4NCj4gDQo+IFRoZSBvdGhlciB0aGluZyBDRVQg
aGFzIGlzIGZvcndhcmQgZWRnZSBjb250cm9sIGZsb3cgLS0gb3IgaW5kaXJlY3QNCj4gYnJhbmNo
IHRyYWNraW5nLCB0aGlzIGlzIGEgY29tcGxldGVseSBkaWZmZXJlbnQgYW5kIGluZGVwZW5kZW50
DQo+IGZlYXR1cmUNCj4gYW5kIG5vdCBhZHZlcnRpc2VkIG9yIGltcGxlbWVudGVkIGhlcmUuDQo+
IA0KPiBUaGVzZSB0aGluZ3MgYXJlIG9idmlvdXNseSByZWxhdGVkLCBidXQgc2luY2UgdGhleSdy
ZSB0d28gaW5kZXBlbmRlbnQNCj4gZmVhdHVyZXMgdGhlcmUncyB0aGUgZW5kbGVzcyBjb25mdXNp
b24gYXMgdG8gd2hpY2ggaXMgYWN0dWFsbHkgbWVhbnQuDQo+IA0KPiAoZ28gKHJlKXdhdGNoIHRo
ZSBsYXN0IHBsdW1iZXJzIGNvbmYgdGFsa3Mgb24gdGhlIHN1YmplY3QgLS0gdGhlcmUncw0KPiBh
bHdheXMgc29tZW9uZSB3aG8gZ2V0cyBpcyB3cm9uZykNCj4gDQo+IFRoZSBvbmx5IHRoaW5ncyB0
aGF0IHNob3VsZCBoYXZlIENFVCBpbiB0aGVpciBuYW1lIGFyZSB0aGUgQ1I0IGJpdA0KPiBhbmQN
Cj4gdGhlIHR3byBNU1JzLCBub3RoaW5nIG1vcmUuDQoNClRoZSBvbmx5IG90aGVyIHBsYWNlIGlu
IHRoZSBrZXJuZWwgd2hlcmUgaXQgaGFzIHRvIGJlIHRoYXQgd2F5IGlzIHRoZQ0KImNvbnRyb2wg
cHJvdGVjdGlvbiIgZmF1bHQgaGFuZGxlci4NCg0KSSBhZ3JlZSBpdCdzIGNvbmZ1c2luZywgYnV0
IHdoZW4geW91IHRhbGsgYWJvdXQgInNoYWRvdyBzdGFja3MiLCBhIGxvdA0Kb2YgcGVvcGxlIGRv
bid0IGNvbm5lY3QgaXQgdG8gdGhlIEhXIGZlYXR1cmUuIFdoZXJlIGFzIHRoZXkgaGF2ZSBoZWFy
ZA0Kb2YgQ0VULiBTbyBmb3IgY29udGV4dHMgbGlrZSB0aGlzLCBJIHRob3VnaHQgaXQgd2FzIHVz
ZWZ1bCB0byBqb2cNCm1lbW9yaWVzLiBJIGNvdWxkIHB1dCBtb3JlIGRpc3RhbmNlIGJldHdlZW4g
aXQuLi4gIng4NiBzaGFkb3cgc3RhY2tzDQooeW91IG1heSBoYXZlIGhlYXJkIG9mIENFVCkiLg0K
DQo+IA0KPiBFTEYgYml0cyBzaG91bGQgbm90LCBtdXN0IG5vdCwgYmUgY2FsbGVkIENFVC4gQVBJ
LCBub3QgQ0VULCBDb21waWxlcg0KPiBmZWF0dXJlcywgYWxzbyBub3QgQ0VULg0KDQpTbyB0aGUg
YXJjaF9wcmN0bCgpcyBjYW4ndCBiZSBzaGFyZWQgYmV0d2VlbiBzaGFkb3cgc3RhY2sgYW5kIElC
VD8gVGhleQ0KZG9uJ3QgaGF2ZSB0byBiZSwgYnV0IHRoaXMgaXMgYSBuZXcgdGhpbmcgYWZ0ZXIg
YSBmYWlyIGFtb3VudCBvZg0KZWFybGllciBkaXNjdXNzaW9uLg0KDQo+IA0KPiAoYW5kIEkga25v
dyBpdCdzIHRvbyBsYXRlIHRvIGVyYWRpY2F0ZSBzb21lIG9mIGl0LCBidXQgcGxlYXNlLCBhdA0K
PiBsZWFzdA0KPiBtYWtlIHN1cmUgdGhlIGtlcm5lbCBkb2Vzbid0IHByb3BhZ2F0ZSB0aGlzIG5v
bnNlbnNlKS4NCg0KDQo=
