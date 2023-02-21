Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021FD69DA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjBUGWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUGWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:22:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D023C57;
        Mon, 20 Feb 2023 22:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676960562; x=1708496562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m5wLGVw5z0fSG1TKUxxM8Jw/3fiM8iQ5f77Wbu60H4k=;
  b=HZQ+ZnLXmn4p1r6gPrPf4u29sM9GlLwoDkFBZAGQrwwYvKPe7JYxacom
   Qto3f6wZaIT/26lNJ6RNatducA8SYL39Ho3dLDJHe0lRmlP5F9MmVeScA
   4ferhkFe3r7AUC9czcpu2x6H7zmjZEGlmgSkmfLfik0D2xBRy5WsU7Cm7
   LxcGAb370cOs5p5WTfCuFd6GmKKixmnNWxB2trK1dwtXYmILgGbm39tFc
   JprTdJu6BMlQS4TZ171QsZ25z9nxJpWaE5sbD1Rt9ntAG5yp4oSaUGozV
   Jfgg718s9M3hRCek5ynLG4EXwMaNU0zmK7TA3iFzZnfTH+cBdjRD7OQ57
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312185632"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="312185632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 22:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="621382745"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="621382745"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2023 22:22:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 22:22:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 22:22:41 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 22:22:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dybJkCYjI6kdajzP8wufcUTMk+lyWw64KarcIWiGghUPokm6Kh7+RpRlONpOVnIU7AwjXhl4wFRshSPPoVr1XYvHIiC0y4buPWsBcvHvz0HccJTsWyjDLPN+z7x2ndvbcTMx5uywxGQNi0F/qCmi/qVm6nioDkgj2uxo7+uIcJlQ2BckesE/9a6SH8eOpNZ6z4CSArFgE5Xh6ZH73ojeUP1bEG+dLfdYd1hR4zkb2Q7itRl4kD5fa7yVbwCG2sJtiueR37vWVXmXm7S4dW79B+QxQBLz1euyZ0KxcA6cFv9kX0A+UkTphayK/Ymh+zt0dSL7kL/ItiZ5zxfSEJpBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5wLGVw5z0fSG1TKUxxM8Jw/3fiM8iQ5f77Wbu60H4k=;
 b=D8VlQcwpIXMpFQf35k61Tq4/2nUADdqiaYC7uaBuiCMYRDNeREsFwNd8dgzwZJNzPIYk6aCgJ/N168Y8bzJF1V5nJxtU7QlPxjEojGIFevLFXzNB/5q/r9DXy2jWZiek00Y18AMDiPIIBR2Ao6iUxBPa3qHYaJD8NqiraaBh9zJJ6rIx7HNZS+aiFpZl6UiV2r2Wy+HMOJB0j5LY1ZTAdW5npECkCUBVBtWfoWYP9rUwR3Hu+S0ikRG3fpx848axXjQQBcY6ULSHmC00BATHSOKa/Ox08IMQx+d+TfbgKyTzHZbw3IMnMbJ0o8k5nkrkJQIDeTaRAA8fMcTHs39o7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 06:22:38 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Tue, 21 Feb 2023
 06:22:38 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas, Sujith" <sujith.thomas@intel.com>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH RFC] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Thread-Topic: [PATCH RFC] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Thread-Index: AQHZRUfUQd8JkpNbU0G4xbaL+Gycn67Y7zcA
Date:   Tue, 21 Feb 2023 06:22:38 +0000
Message-ID: <27488f102c917ce1f6d24d30f801b1e1745674e1.camel@intel.com>
References: <20230220162419.1276952-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230220162419.1276952-1-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MN6PR11MB8195:EE_
x-ms-office365-filtering-correlation-id: ce565239-cab7-4dfd-31cf-08db13d407aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vwa3TGB+YWQP9zc2tGObApzDutbGx/W5CIbSYc0MDjXBJKGXDrYXqq9RsLVy6IcQLUJy6Xq57FWY/TYT0cxG+X8D/OgxIl1or0q12EO5CnHFZl/Yvb/Dxsch5eu2qwi8bPEKxVdQlCiseYngUonLU0E9/3/G9hki00lTwXpZzDxm5T7Z0r7Y1gXJGk+D5QJ6FrAohjoq7T4cmswe8UCItTQJTMehiI/EW5NU7VEBtakVu3lih/JRwByu70rf0piJyDo9YEJOiktBi8OQ1k6HJI2Ct71Su+bkty9ACKLAh0OpUEDTZmYNi6hPDYXpPifP8p3sQqRVCiQOpdCSi5zcX7VOO5xhCVMLZQQ0Pa2fkm2FDzn9UPH8psZQNuaKmvnYIDVvHGtGQfNLpJfo/HbKciOAbK5o2Y5lPP3eljP4AIy6MRpd6UvQQ9ztjlxrRMqNytXRMiFiiS9F44c1YUp3Bf4E9i8UsJp93wH4fa4t7DulzZixvQl2NmDg3ae/yj6BAZ0CkcITKSlO1syhVaervhtKFtGj9PDZximObpkzORvHOFCX1BoxnG9eyg4HMRzL4eBIr1SPJ0sLzALmzFiL2xDPth/5yl++G1hoiaEPSf8VDdhBuI25jnvRzLjTUGJsxe32gmlceEMvvkotjdRK6ffvPbuPrJS31AUI6de8K1r8eydmGEo/4eMkLVzn/bPBFmAlKi9aoEyFq5n3jfvDQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(2906002)(8936002)(5660300002)(83380400001)(6512007)(26005)(2616005)(71200400001)(6506007)(36756003)(66476007)(66946007)(64756008)(38100700002)(82960400001)(122000001)(186003)(6486002)(86362001)(38070700005)(66446008)(110136005)(478600001)(41300700001)(8676002)(76116006)(66556008)(91956017)(4326008)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YldaOU1QemRseWhCQWRPZXN4QzFmbzI2Q1F6YS9hTkNEWDhqOUdPSHZwSFJW?=
 =?utf-8?B?ZTVPc3NKdkx4NUpLK3dlTjNvdkY2aEZYQ2lIMGJ2cFg5MDVyb0pqN3grbTFj?=
 =?utf-8?B?OENwSEkyY0FwS3lXUGw5MUNTM1JPKzlMN1VYVDNSMHV0MXZ0N2h4dDBrV2tP?=
 =?utf-8?B?MnQ4ZE9TQTRYdXBNMUd2TGJqVUxWWCs3OXFvbHFiMTlDWWRvVkprSC9vTjNr?=
 =?utf-8?B?MTRUQklVM2tnN004MENlUHkyN3JuVnU2NzRycGtkeDBxeHk2d00wVTZMblEx?=
 =?utf-8?B?SDN0dkRjZ3VuZGducmZJTzhMTDYzdEIxa2tuZlBuUXpxTU4rbUZJeVNGZE1B?=
 =?utf-8?B?ZnBpN1RlTWdGL2s5U0VKTWV3cms5Z2VLdW5QSVVLRkFIcUtKcVptOFhab0pS?=
 =?utf-8?B?bmlkY29KR2ZCdHVrdENQVGp4VlFWWVpQbWlEdm8wbXdHbnFldXpRcmpyKzlU?=
 =?utf-8?B?UG5sQUJjeW9CWlhxYjMxWE11SEZqS3h1NUlJSVhRbzA4dkNNRzVmaDh4R2tR?=
 =?utf-8?B?Q2dGbXJLOW1mSU5UQ1dOaEwvdzBWS0h6bjhLS1FIL3Z0RzVZL2lPVUttKzY4?=
 =?utf-8?B?RUluMnNZWkxGODE0cFl4ZVF2U1Jrc3U2TjliNzhRSWp4MFFrckx4cUdmMTA5?=
 =?utf-8?B?Y29jdmtxdHVSYmtRUS9JN2J6cENxcWVSR1BjeUhkVnM0SS9VMjRjNm8zSDBv?=
 =?utf-8?B?UEZlNDc4alpsejFxNzBRZmpBSUJ3YkhhRGxIYUNQK2RUbzAyS3lQMk0xL0k5?=
 =?utf-8?B?YTJ4TTBWQ1BNZGxBd05wOFJiYmMxdWtIQTZGVTQrM0VDZUVCeXZHOE1vSThB?=
 =?utf-8?B?SGtoNmxLT1JLQ2RXZlFkZ0h3MWI4SERXdGpvSmRhclFIejAyTGpEY2VOZmc2?=
 =?utf-8?B?QTNPbVhQSjNpdHlLUmJsN1Rsa0txczNsOHM3SmVFc2tnLzJLZXozazZkSVAv?=
 =?utf-8?B?YkhVQ2tUdVZHN09TMjJHRW5DalNlOGhlb0JqdE9pcFpjTGtOdW8rekJ3MzBF?=
 =?utf-8?B?aWQrWVlNRnBLTC9kaDdVcTg5Z1lwbDlBWndmaFJDUm1DdGduSXFLNnphcDdU?=
 =?utf-8?B?eUlzeVZ6TTlwNWNVemMxVUtBZWRuLzZHSzdHTDV1R3NPNnJpTjJ6dURUVmUw?=
 =?utf-8?B?U3YyRGhFUndORGRPakJPUnFGSkIyczNsZXU5VUszVHNUR2dIWEVMNklHYUxR?=
 =?utf-8?B?UFJWeElBNVpMc3Bpc21YWXNGbWVVTW10RExtUEQ1UTlyazYvUW1rWXN0YTQ0?=
 =?utf-8?B?czFrUHg3SzFXZGZrczFVSThwejBibTJLMENKQTRiWmhSc2YzeE8vWmpJTWpZ?=
 =?utf-8?B?S05wUENPWTJJV3Bid2dScFVuZkh6dkNwc0RMTkNOZjliVjIwZEFuVEFDTFBa?=
 =?utf-8?B?OGZwRWI2ay9CVlJWNEs1VWhtK09vVHU2dnAxZU81Nmc5UGxKRmVZNzVlbmk3?=
 =?utf-8?B?djduTlJNS2wyRWFDWmd6eHdNWHBCWC80RVpBeWltcHRSQnYvaTBsamhSb3hP?=
 =?utf-8?B?dHFhNXVtSnFIdXJveXNranRTdFB3R3YxRWt0ZmNyR2lWRDhDWDlkRDhEYTU0?=
 =?utf-8?B?T00rTWlIZGU3MFlRUlFIQ3psWE0wSUEvUUZrTDFzMGtzajJXNDBHYnR0SkRs?=
 =?utf-8?B?QjZyZjdOZzhpNlh5QjNFMXd5QnFvWTJnR29SWEY1aVZEbnhNcGhXU3UyUmhT?=
 =?utf-8?B?TVpZUVp0OXBWYjk2aHBEYy9SeGxPdXlLclc0ZVRmQ2x0QVphUjhIVmI0UUt2?=
 =?utf-8?B?YnNGTTVpNVh1QWRLQlZrUzNkNUdMSDZNcjZlZjc2aVdEcXJCT3RaY3pRUmoz?=
 =?utf-8?B?ZFFTb2lJYTh6dTFCekd3L3JXNlpLVjFQTmcrVm1aR1FucEhiTGJwVEJWMTBQ?=
 =?utf-8?B?NEl3akZpNVpjR2VDK25JdnNzakMvaDJ4ZjZ4d0FuSHl0SU1ScENiTktpUTcx?=
 =?utf-8?B?ZWxPeWxqZHd3RGt3NXlDS3JHKzN0QWMyd1dSSk5zMlZFdEVBYklDa3Qwbldl?=
 =?utf-8?B?U1ZZNnBwRnRldkE4MWI3eGkrYi90ZnE1bXQ3TnFiekZWeEszSnY2NHVZdkw4?=
 =?utf-8?B?VDJMY1NDSE80RU5ZanByclhLbXh4VE1EMlRjdUVEYS9GMlFCeHBxWHY5RHM5?=
 =?utf-8?Q?cRQuaMOqvIyFChM7zTPK0OwBO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5221C74E006AB408BD7C8CFAA165FB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce565239-cab7-4dfd-31cf-08db13d407aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 06:22:38.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JamNDcLrLJ9pEY7/m455Udn990WFzAdfARyh29oL2KbyA1dDmaEGLPsPCg6o3T5fXFCBfmRjGIUY+ibIc12qww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDE3OjI0ICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gVGhlIGRyaXZlciBob29rcyB0aGUgdGhlcm1hbCBmcmFtZXdvcmsgc3lzZnMgdG8gYWRkIHNv
bWUgZHJpdmVyDQo+IHNwZWNpZmljIGluZm9ybWF0aW9uLiBBIGRlYmF0YWJsZSBhcHByb2FjaCBh
cyB0aGF0IG1heSBiZWxvbmcgdGhlDQo+IGRldmljZSBzeXNmcyBkaXJlY3RvcnksIG5vdCB0aGUg
dGhlcm1hbCB6b25lIGRpcmVjdG9yeS4NCj4gDQo+IEFzIHRoZSBkcml2ZXIgaXMgYWNjZXNzaW5n
IHRoZSB0aGVybWFsIGludGVybmFscywgd2Ugc2hvdWxkIHByb3ZpZGUNCj4gYXQNCj4gbGVhc3Qg
YW4gQVBJIHRvIHRoZSB0aGVybWFsIGZyYW1ld29yayB0byBhZGQgYW4gYXR0cmlidXRlIHRvIHRo
ZQ0KPiBleGlzdGluZyBzeXNmcyB0aGVybWFsIHpvbmUgZW50cnkuDQo+IA0KPiBCZWZvcmUgZG9p
bmcgdGhhdCBhbmQgZ2l2ZW4gdGhlIGFnZSBvZiB0aGUgZHJpdmVyICgyMDA4KSBtYXkgYmUgaXQg
aXMNCj4gd29ydGggdG8gZG91YmxlIGNoZWNrIGlmIHRoZXNlIGF0dHJpYnV0ZXMgYXJlIHJlYWxs
eSBuZWVkZWQuIFNvIG15DQo+IGZpcnN0IHByb3Bvc2FsIGlzIHRvIHJlbW92ZSB0aGVtIGlmIHRo
YXQgZG9lcyBub3QgaHVydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBMZXpjYW5vIDxk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KDQpJIGRvbid0IGhhdmUgYW55IGRldmljZSB0aGF0
IHVzZXMgdGhpcyBkcml2ZXIuDQpMZXQncyBzZWUgd2hhdCBTdWppdGggc2F5cy4NCg0KdGhhbmtz
LA0KcnVpDQo+IC0tLQ0KPiAgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX21lbmxvdy5jIHwg
MTkzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
OTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2ludGVs
L2ludGVsX21lbmxvdy5jDQo+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX21lbmxvdy5j
DQo+IGluZGV4IDVhNmFkMDU1MjMxMS4uNWE5NzM4YTkzMDgzIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfbWVubG93LmMNCj4gKysrIGIvZHJpdmVycy90aGVybWFs
L2ludGVsL2ludGVsX21lbmxvdy5jDQo+IEBAIC0yMzAsMTc0ICsyMzAsOCBAQCBzdHJ1Y3QgaW50
ZWxfbWVubG93X2F0dHJpYnV0ZSB7DQo+ICBzdGF0aWMgTElTVF9IRUFEKGludGVsX21lbmxvd19h
dHRyX2xpc3QpOw0KPiAgc3RhdGljIERFRklORV9NVVRFWChpbnRlbF9tZW5sb3dfYXR0cl9sb2Nr
KTsNCj4gIA0KPiAtLyoNCj4gLSAqIHNlbnNvcl9nZXRfYXV4dHJpcCAtIGdldCB0aGUgY3VycmVu
dCBhdXh0cmlwIHZhbHVlIGZyb20gc2Vuc29yDQo+IC0gKiBAaGFuZGxlOiBPYmplY3QgaGFuZGxl
DQo+IC0gKiBAaW5kZXggOiBHRVRfQVVYMS9HRVRfQVVYMA0KPiAtICogQHZhbHVlIDogVGhlIGFk
ZHJlc3Mgd2lsbCBiZSBmaWxsIGJ5IHRoZSB2YWx1ZQ0KPiAtICovDQo+IC1zdGF0aWMgaW50IHNl
bnNvcl9nZXRfYXV4dHJpcChhY3BpX2hhbmRsZSBoYW5kbGUsIGludCBpbmRleCwNCj4gLQkJCQkJ
CQl1bnNpZ25lZCBsb25nDQo+IGxvbmcgKnZhbHVlKQ0KPiAtew0KPiAtCWFjcGlfc3RhdHVzIHN0
YXR1czsNCj4gLQ0KPiAtCWlmICgoaW5kZXggIT0gMCAmJiBpbmRleCAhPSAxKSB8fCAhdmFsdWUp
DQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiAtDQo+IC0Jc3RhdHVzID0gYWNwaV9ldmFsdWF0ZV9p
bnRlZ2VyKGhhbmRsZSwgaW5kZXggPyBHRVRfQVVYMSA6DQo+IEdFVF9BVVgwLA0KPiAtCQkJCSAg
ICAgICBOVUxMLCB2YWx1ZSk7DQo+IC0JaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKQ0KPiAtCQly
ZXR1cm4gLUVJTzsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAtfQ0KPiAtDQo+IC0vKg0KPiAtICog
c2Vuc29yX3NldF9hdXh0cmlwIC0gc2V0IHRoZSBuZXcgYXV4dHJpcCB2YWx1ZSB0byBzZW5zb3IN
Cj4gLSAqIEBoYW5kbGU6IE9iamVjdCBoYW5kbGUNCj4gLSAqIEBpbmRleCA6IEdFVF9BVVgxL0dF
VF9BVVgwDQo+IC0gKiBAdmFsdWUgOiBUaGUgdmFsdWUgd2lsbCBiZSBzZXQNCj4gLSAqLw0KPiAt
c3RhdGljIGludCBzZW5zb3Jfc2V0X2F1eHRyaXAoYWNwaV9oYW5kbGUgaGFuZGxlLCBpbnQgaW5k
ZXgsIGludA0KPiB2YWx1ZSkNCj4gLXsNCj4gLQlhY3BpX3N0YXR1cyBzdGF0dXM7DQo+IC0JdW5p
b24gYWNwaV9vYmplY3QgYXJnID0gew0KPiAtCQlBQ1BJX1RZUEVfSU5URUdFUg0KPiAtCX07DQo+
IC0Jc3RydWN0IGFjcGlfb2JqZWN0X2xpc3QgYXJncyA9IHsNCj4gLQkJMSwgJmFyZw0KPiAtCX07
DQo+IC0JdW5zaWduZWQgbG9uZyBsb25nIHRlbXA7DQo+IC0NCj4gLQlpZiAoaW5kZXggIT0gMCAm
JiBpbmRleCAhPSAxKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQ0KPiAtCXN0YXR1cyA9IGFj
cGlfZXZhbHVhdGVfaW50ZWdlcihoYW5kbGUsIGluZGV4ID8gR0VUX0FVWDAgOg0KPiBHRVRfQVVY
MSwNCj4gLQkJCQkgICAgICAgTlVMTCwgJnRlbXApOw0KPiAtCWlmIChBQ1BJX0ZBSUxVUkUoc3Rh
dHVzKSkNCj4gLQkJcmV0dXJuIC1FSU87DQo+IC0JaWYgKChpbmRleCAmJiB2YWx1ZSA8IHRlbXAp
IHx8ICghaW5kZXggJiYgdmFsdWUgPiB0ZW1wKSkNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0N
Cj4gLQlhcmcuaW50ZWdlci52YWx1ZSA9IHZhbHVlOw0KPiAtCXN0YXR1cyA9IGFjcGlfZXZhbHVh
dGVfaW50ZWdlcihoYW5kbGUsIGluZGV4ID8gU0VUX0FVWDEgOg0KPiBTRVRfQVVYMCwNCj4gLQkJ
CQkgICAgICAgJmFyZ3MsICZ0ZW1wKTsNCj4gLQlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpDQo+
IC0JCXJldHVybiAtRUlPOw0KPiAtDQo+IC0JLyogZG8gd2UgbmVlZCB0byBjaGVjayB0aGUgcmV0
dXJuIHZhbHVlIG9mIFNBWDAvU0FYMSA/ICovDQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4g
LQ0KPiAtI2RlZmluZSB0b19pbnRlbF9tZW5sb3dfYXR0cihfYXR0cikJXA0KPiAtCWNvbnRhaW5l
cl9vZihfYXR0ciwgc3RydWN0IGludGVsX21lbmxvd19hdHRyaWJ1dGUsIGF0dHIpDQo+IC0NCj4g
LXN0YXRpYyBzc2l6ZV90IGF1eF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUNCj4gKmRldl9hdHRyLA0KPiAtCQkJY2hhciAqYnVmLCBpbnQgaWR4KQ0KPiAt
ew0KPiAtCXN0cnVjdCBpbnRlbF9tZW5sb3dfYXR0cmlidXRlICphdHRyID0NCj4gdG9faW50ZWxf
bWVubG93X2F0dHIoZGV2X2F0dHIpOw0KPiAtCXVuc2lnbmVkIGxvbmcgbG9uZyB2YWx1ZTsNCj4g
LQlpbnQgcmVzdWx0Ow0KPiAtDQo+IC0JcmVzdWx0ID0gc2Vuc29yX2dldF9hdXh0cmlwKGF0dHIt
PmhhbmRsZSwgaWR4LCAmdmFsdWUpOw0KPiAtCWlmIChyZXN1bHQpDQo+IC0JCXJldHVybiByZXN1
bHQ7DQo+IC0NCj4gLQlyZXR1cm4gc3ByaW50ZihidWYsICIlbHUiLCBkZWNpX2tlbHZpbl90b19j
ZWxzaXVzKHZhbHVlKSk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBzc2l6ZV90IGF1eDBfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+IC0JCQkgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmRldl9h
dHRyLCBjaGFyICpidWYpDQo+IC17DQo+IC0JcmV0dXJuIGF1eF9zaG93KGRldiwgZGV2X2F0dHIs
IGJ1ZiwgMCk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBzc2l6ZV90IGF1eDFfc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+IC0JCQkgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmRldl9hdHRyLCBj
aGFyICpidWYpDQo+IC17DQo+IC0JcmV0dXJuIGF1eF9zaG93KGRldiwgZGV2X2F0dHIsIGJ1Ziwg
MSk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBzc2l6ZV90IGF1eF9zdG9yZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlDQo+ICpkZXZfYXR0ciwNCj4gLQkJCSBjb25z
dCBjaGFyICpidWYsIHNpemVfdCBjb3VudCwgaW50IGlkeCkNCj4gLXsNCj4gLQlzdHJ1Y3QgaW50
ZWxfbWVubG93X2F0dHJpYnV0ZSAqYXR0ciA9DQo+IHRvX2ludGVsX21lbmxvd19hdHRyKGRldl9h
dHRyKTsNCj4gLQlpbnQgdmFsdWU7DQo+IC0JaW50IHJlc3VsdDsNCj4gLQ0KPiAtCS8qU2FuaXR5
IGNoZWNrOyBzaG91bGQgYmUgYSBwb3NpdGl2ZSBpbnRlZ2VyICovDQo+IC0JaWYgKCFzc2NhbmYo
YnVmLCAiJWQiLCAmdmFsdWUpKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQ0KPiAtCWlmICh2
YWx1ZSA8IDApDQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiAtDQo+IC0JcmVzdWx0ID0gc2Vuc29y
X3NldF9hdXh0cmlwKGF0dHItPmhhbmRsZSwgaWR4LA0KPiAtCQkJCSAgICBjZWxzaXVzX3RvX2Rl
Y2lfa2VsdmluKHZhbHVlKSk7DQo+IC0JcmV0dXJuIHJlc3VsdCA/IHJlc3VsdCA6IGNvdW50Ow0K
PiAtfQ0KPiAtDQo+IC1zdGF0aWMgc3NpemVfdCBhdXgwX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gLQkJCSAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmRldl9hdHRyLA0KPiAtCQkJICBj
b25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkNCj4gLXsNCj4gLQlyZXR1cm4gYXV4X3N0b3Jl
KGRldiwgZGV2X2F0dHIsIGJ1ZiwgY291bnQsIDApOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgc3Np
emVfdCBhdXgxX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gLQkJCSAgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmRldl9hdHRyLA0KPiAtCQkJICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBj
b3VudCkNCj4gLXsNCj4gLQlyZXR1cm4gYXV4X3N0b3JlKGRldiwgZGV2X2F0dHIsIGJ1ZiwgY291
bnQsIDEpOw0KPiAtfQ0KPiAtDQo+ICAvKiBCSU9TIGNhbiBlbmFibGUvZGlzYWJsZSB0aGUgdGhl
cm1hbCB1c2VyIGFwcGxpY2F0aW9uIGluIGRhYm5leQ0KPiBwbGF0Zm9ybSAqLw0KPiAgI2RlZmlu
ZSBCSU9TX0VOQUJMRUQgIlxcX1RaLkdTVFMiDQo+IC1zdGF0aWMgc3NpemVfdCBiaW9zX2VuYWJs
ZWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IC0JCQkJIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLCBjaGFyDQo+ICpidWYpDQo+IC17DQo+IC0JYWNwaV9zdGF0dXMgc3RhdHVzOw0K
PiAtCXVuc2lnbmVkIGxvbmcgbG9uZyBiaW9zX2VuYWJsZWQ7DQo+IC0NCj4gLQlzdGF0dXMgPSBh
Y3BpX2V2YWx1YXRlX2ludGVnZXIoTlVMTCwgQklPU19FTkFCTEVELCBOVUxMLA0KPiAmYmlvc19l
bmFibGVkKTsNCj4gLQlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpDQo+IC0JCXJldHVybiAtRU5P
REVWOw0KPiAtDQo+IC0JcmV0dXJuIHNwcmludGYoYnVmLCAiJXNcbiIsIGJpb3NfZW5hYmxlZCA/
ICJlbmFibGVkIiA6DQo+ICJkaXNhYmxlZCIpOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgaW50IGlu
dGVsX21lbmxvd19hZGRfb25lX2F0dHJpYnV0ZShjaGFyICpuYW1lLCB1bW9kZV90IG1vZGUsDQo+
IHZvaWQgKnNob3csDQo+IC0JCQkJCSAgdm9pZCAqc3RvcmUsIHN0cnVjdCBkZXZpY2UNCj4gKmRl
diwNCj4gLQkJCQkJICBhY3BpX2hhbmRsZSBoYW5kbGUpDQo+IC17DQo+IC0Jc3RydWN0IGludGVs
X21lbmxvd19hdHRyaWJ1dGUgKmF0dHI7DQo+IC0JaW50IHJlc3VsdDsNCj4gLQ0KPiAtCWF0dHIg
PSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaW50ZWxfbWVubG93X2F0dHJpYnV0ZSksDQo+IEdGUF9L
RVJORUwpOw0KPiAtCWlmICghYXR0cikNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+IC0NCj4gLQlz
eXNmc19hdHRyX2luaXQoJmF0dHItPmF0dHIuYXR0cik7IC8qIFRoYXQgaXMgY29uc2lzdGVudCBu
YW1pbmcNCj4gOkQgKi8NCj4gLQlhdHRyLT5hdHRyLmF0dHIubmFtZSA9IG5hbWU7DQo+IC0JYXR0
ci0+YXR0ci5hdHRyLm1vZGUgPSBtb2RlOw0KPiAtCWF0dHItPmF0dHIuc2hvdyA9IHNob3c7DQo+
IC0JYXR0ci0+YXR0ci5zdG9yZSA9IHN0b3JlOw0KPiAtCWF0dHItPmRldmljZSA9IGRldjsNCj4g
LQlhdHRyLT5oYW5kbGUgPSBoYW5kbGU7DQo+IC0NCj4gLQlyZXN1bHQgPSBkZXZpY2VfY3JlYXRl
X2ZpbGUoZGV2LCAmYXR0ci0+YXR0cik7DQo+IC0JaWYgKHJlc3VsdCkgew0KPiAtCQlrZnJlZShh
dHRyKTsNCj4gLQkJcmV0dXJuIHJlc3VsdDsNCj4gLQl9DQo+IC0NCj4gLQltdXRleF9sb2NrKCZp
bnRlbF9tZW5sb3dfYXR0cl9sb2NrKTsNCj4gLQlsaXN0X2FkZF90YWlsKCZhdHRyLT5ub2RlLCAm
aW50ZWxfbWVubG93X2F0dHJfbGlzdCk7DQo+IC0JbXV0ZXhfdW5sb2NrKCZpbnRlbF9tZW5sb3df
YXR0cl9sb2NrKTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAtfQ0KPiAgDQo+ICBzdGF0aWMgYWNw
aV9zdGF0dXMgaW50ZWxfbWVubG93X3JlZ2lzdGVyX3NlbnNvcihhY3BpX2hhbmRsZSBoYW5kbGUs
DQo+IHUzMiBsdmwsDQo+ICAJCQkJCQl2b2lkICpjb250ZXh0LCB2b2lkDQo+ICoqcnYpDQo+IEBA
IC00MjAsMTIgKzI1NCw2IEBAIHN0YXRpYyBhY3BpX3N0YXR1cw0KPiBpbnRlbF9tZW5sb3dfcmVn
aXN0ZXJfc2Vuc29yKGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyIGx2bCwNCj4gIAlpZiAoQUNQSV9G
QUlMVVJFKHN0YXR1cykpDQo+ICAJCXJldHVybiAoc3RhdHVzID09IEFFX05PVF9GT1VORCkgPyBB
RV9PSyA6IHN0YXR1czsNCj4gIA0KPiAtCXJlc3VsdCA9IGludGVsX21lbmxvd19hZGRfb25lX2F0
dHJpYnV0ZSgiYXV4MCIsIDA2NDQsDQo+IC0JCQkJCQlhdXgwX3Nob3csIGF1eDBfc3RvcmUsDQo+
IC0JCQkJCQkmdGhlcm1hbC0+ZGV2aWNlLA0KPiBoYW5kbGUpOw0KPiAtCWlmIChyZXN1bHQpDQo+
IC0JCXJldHVybiBBRV9FUlJPUjsNCj4gLQ0KPiAgCXN0YXR1cyA9IGFjcGlfZ2V0X2hhbmRsZSho
YW5kbGUsIEdFVF9BVVgxLCAmZHVtbXkpOw0KPiAgCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkN
Cj4gIAkJZ290byBhdXgxX25vdF9mb3VuZDsNCj4gQEAgLTQzNCwyNyArMjYyLDYgQEAgc3RhdGlj
IGFjcGlfc3RhdHVzDQo+IGludGVsX21lbmxvd19yZWdpc3Rlcl9zZW5zb3IoYWNwaV9oYW5kbGUg
aGFuZGxlLCB1MzIgbHZsLA0KPiAgCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkNCj4gIAkJZ290
byBhdXgxX25vdF9mb3VuZDsNCj4gIA0KPiAtCXJlc3VsdCA9IGludGVsX21lbmxvd19hZGRfb25l
X2F0dHJpYnV0ZSgiYXV4MSIsIDA2NDQsDQo+IC0JCQkJCQlhdXgxX3Nob3csIGF1eDFfc3RvcmUs
DQo+IC0JCQkJCQkmdGhlcm1hbC0+ZGV2aWNlLA0KPiBoYW5kbGUpOw0KPiAtCWlmIChyZXN1bHQp
IHsNCj4gLQkJaW50ZWxfbWVubG93X3VucmVnaXN0ZXJfc2Vuc29yKCk7DQo+IC0JCXJldHVybiBB
RV9FUlJPUjsNCj4gLQl9DQo+IC0NCj4gLQkvKg0KPiAtCSAqIGNyZWF0ZSB0aGUgImRhYm5leV9l
bmFibGVkIiBhdHRyaWJ1dGUgd2hpY2ggbWVhbnMgdGhlIHVzZXINCj4gYXBwDQo+IC0JICogc2hv
dWxkIGJlIGxvYWRlZCBvciBub3QNCj4gLQkgKi8NCj4gLQ0KPiAtCXJlc3VsdCA9IGludGVsX21l
bmxvd19hZGRfb25lX2F0dHJpYnV0ZSgiYmlvc19lbmFibGVkIiwgMDQ0NCwNCj4gLQkJCQkJCWJp
b3NfZW5hYmxlZF9zaG93LA0KPiBOVUxMLA0KPiAtCQkJCQkJJnRoZXJtYWwtPmRldmljZSwNCj4g
aGFuZGxlKTsNCj4gLQlpZiAocmVzdWx0KSB7DQo+IC0JCWludGVsX21lbmxvd191bnJlZ2lzdGVy
X3NlbnNvcigpOw0KPiAtCQlyZXR1cm4gQUVfRVJST1I7DQo+IC0JfQ0KPiAtDQo+ICAJcmV0dXJu
IEFFX09LOw0KPiAgDQo+ICAgYXV4MV9ub3RfZm91bmQ6DQo=
