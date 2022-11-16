Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D362BC28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiKPLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiKPLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:37:48 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104947306
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668597956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K221gEoMzobqpptgWsO6owDiPt65nAKnwPy6K7I6qUQ=;
        b=NpNxx4UJhExWVdZmlBL233XK45Oa2wBO0m00sMfY5vRJCT9I4fNt7TAt4gXsEg5lCXBp2X
        J2jxY9bQqYs+dy0KML3e2/Az86iZb9HilV3RxSOVRHDV8Jgwr8pMYEAuwxz+rO3/jrAPPp
        G0CF8+Xfi5ERhgcMn0gZvXMSZQOto3zYHKbs8i0p2aVXufkGMJoLf+ADUkED+qYupEz483
        ZzoNXV7+qRrGAW2X5YIuL7qYxmrR1xSWCds5YI3HReJ8leXiBiB/izngVCEIB9iEj7eaWL
        4xqdUibVysWPIuzU87I96BXhzLuOhBo2zpoxDOCocL6YPMAQ3DgxfbykmBg9qA==
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-wmWAk1irNluNuaYv5nszbg-2; Wed, 16 Nov 2022 06:25:54 -0500
X-MC-Unique: wmWAk1irNluNuaYv5nszbg-2
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by BLAPR19MB4276.namprd19.prod.outlook.com (2603:10b6:208:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 16 Nov
 2022 11:25:47 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 11:25:47 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>,
        "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
        "sodaville@linutronix.de" <sodaville@linutronix.de>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v2 1/2] x86/of: Add support for boot time interrupt
 delivery mode configuration
Thread-Topic: [PATCH v2 1/2] x86/of: Add support for boot time interrupt
 delivery mode configuration
Thread-Index: AQHY+aYwfQQe9+ocpUuq5OloShaUDK5BXPEAgAAMG4A=
Date:   Wed, 16 Nov 2022 11:25:47 +0000
Message-ID: <7efa66ec-8aa7-d44f-fae3-ee4f82d8f157@maxlinear.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
 <9114810c7af7fbaf9d0b2823752afcef865bdda0.1668589253.git.rtanwar@maxlinear.com>
 <Y3S+lLzcmytKHLRq@smile.fi.intel.com>
In-Reply-To: <Y3S+lLzcmytKHLRq@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|BLAPR19MB4276:EE_
x-ms-office365-filtering-correlation-id: 2c657560-13eb-40d9-88ac-08dac7c54f3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: hb0r9GKpPb/GQKGuxsdWWa69arW8ORVZRZDYTkCzcxrTJkKlE/P1EWwDL6bQXVVygpuE35WXAyI5KFNqTrR4gVn12PPCZmbeL11ns3GBvv9gRKCDsRXs3VBcYu7wfUmvC/S5MwhH1XSHVnYvyJzEzLoguQOv7WxIctxW2g7s3NkpMueto6qVM6qtB3KvNVCJaXJSw1peUFGBLJCgDg8shiSp+MBynFpPpX0Gc592Ad2Bh2pdwjLhpZ6AxjEWwQPPts9LE6sSEKaSiy04A0GLsuwUshpMXlm+/V2qUt2rflZX9DCon1b0rZKBZv6l7F723D+492A/J2V9WvWCyIEbMS1Eb5s0Zi0tH+BEqtv8YqsV2mZfQ0xejQdBdB5xmePz1DVLzKdNPVioq52Dgzq6v6FOYS6aTT7paCFigWfPtPnuBw9lMNBfNi8gx2g1fl3TZG+tdCLREO+FVsyTd4iW4z68/e5P5s/0kg28FHRD/TbxO1PRzsBLMQ8h+e2ttNDdu8fb4/CRTnYbaIzxOOHCJgOXUB0SUJDZKJLpbsDWhDwE3j9xCHNOK0Li8u1LhX2yJZLDYx+9PjAsdGPKqk6DzXnJFpugltp6naLg1xMLeT4+duzKWYtuwEtNXRqr+JhRoeltOiChLtlzUYTuz53A53A+19+gbTsp3IuMbcr1wRduhU+358j7ePVh+aogI8s07/kNNjho9an2uJ7O7q1F0iGhZO9iZXyk+AJiR68HriYCu0S5R/mR5yyvHQy6oreShIvu/0sKUhE49BTnVkxqkM+gq+SO+9NOFPETzGP0FrgX4hTX+FhsYjVq448dCTKppXu2feip2LYdTnHYOsAjCR6qfWbIrYUKZ2tNjzF30RMutqtF9WbM1haKTs2oDiL5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39850400004)(366004)(451199015)(31686004)(122000001)(38100700002)(36756003)(478600001)(6486002)(966005)(71200400001)(38070700005)(83380400001)(76116006)(31696002)(86362001)(7416002)(107886003)(8936002)(53546011)(5660300002)(186003)(2906002)(66556008)(4326008)(66946007)(8676002)(66446008)(66476007)(64756008)(6506007)(91956017)(26005)(2616005)(6512007)(41300700001)(54906003)(316002)(6916009)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW9CYTJJSk9hR0p2cFMyRWJSdytOS1E1UEtQQ2txc0s3N3VITE0zUjBxQ1pn?=
 =?utf-8?B?cWdsQXFOc0NXZEh6bWxTR1pWN1kvNnhXVlR0RjViTU1kZlVaSGtINVRPUGEy?=
 =?utf-8?B?aStmNk5Cd3FpN2krUmtNTkZkRW5xYVVQOG41MlZwRWFDdm5nUkpXMDl4clor?=
 =?utf-8?B?Q054V0JzSlhCYmFLMzJ2dVJsMzNHcHRpN0EvbkkvTUlqNHF0TXd5U0tzeGlo?=
 =?utf-8?B?bXVsQmZFd2JZQk5OSGJvSlBHWWdXaHJOZzdLZ0NrcHRsTlFneXN3bVY5OEF3?=
 =?utf-8?B?UmlkdXNpR2dzdVdUY3kvTnYrd05uU3pEVzlCeUFodVoweVZ3N3BwdkdjTHVB?=
 =?utf-8?B?NUYwUWNTRUVXV2hRZE1NVmdHN0lSWkRjWHRwWjhFeTQyVWlNUjF6WDdBSzZp?=
 =?utf-8?B?eFJTdFZVSG5obUpEK2NMYjN3akVWVC9YM21KRE94UGV2UmwzTXRyYldpakJq?=
 =?utf-8?B?U0tvQXIxeGRYSmVrclZLZ3BWOFd4alVGLzRnM09YSUFNblBrNnB1KzlGSVNG?=
 =?utf-8?B?U0wzSDdIZndPVUc0QVAyUVNudjhJVWluRmRCb2daRit0Wi93aVVBOEtHakJW?=
 =?utf-8?B?Q21VdXNoQlNrMUR2OFc1VnlTaXdWUFMzckxBU0lSbXhzeVRBVitqYXBPRVdD?=
 =?utf-8?B?NWhKcWJzRUVYL0dNRnZWaXhTWVlzcFYyRHJTRlljaVl1UDZMMmVsLzhPZGNt?=
 =?utf-8?B?VG5vcEw2amE1ckowSU4zM1k1YzlTd3V0Z3FRRGllTUpHWk5waVpIZmRUUVpP?=
 =?utf-8?B?RCtSenFpSU9meCs1TEFZODdQenRmbUJER0Z0ZDFvNVBtRk9CWGFsZ2NQYWky?=
 =?utf-8?B?aTkwem9yVFlsR2xkMnVNZ0JkaWdEY1lXTTFtR1hsRjdCcGhwbTNPSHhySTJS?=
 =?utf-8?B?QUc1ZStUazdHM3F2Q3dyV01zUnJxUmdpRmVZUXY0ODY4YXp4SGZWTGg1Qmdj?=
 =?utf-8?B?ZGNtUXBCOTYrUllUS21aYWs0b1F6ZGs5K0EwOU9ockJyc1NNcWpkeXNvaHlO?=
 =?utf-8?B?amcwZ1JjMmhoQXQrdHFBdVYwZVNHMjkxMVZLeUhXZDl6bkNCYWZWaXhxRWpq?=
 =?utf-8?B?SE0wU0V0YlF1aVY2MFY2MmcyeFlzQVZ3SHZkMDlQSnY2TVNieWRsai9oYXZI?=
 =?utf-8?B?cko2NlZja0NsUFUxWjg5ZGpsVnBuSjg2eEM3QXBVeVpIM2trendiYlNQV3RC?=
 =?utf-8?B?UVRxZFFqQkxsbXV4WVJHRDd4SFpqMkcxem02SkVOZDRNUTBrSHgyOE40NGJL?=
 =?utf-8?B?SGN3cjhtZU9nNWtaLzBqRkVkVUNZdnBEMGxEeE4vN0NLR0lvNjlMYzl6aGd3?=
 =?utf-8?B?VXc3QUxwVkFXelp4WWNKMXpLYktNZFczUXNvbFYxaDlUUFpsODVxcXNXQWhm?=
 =?utf-8?B?aXYzdElSeUhwS1JIRWxLbnAvL2F4VmVLYWFFSVZvajhKSVptaGRjSm5aT25Q?=
 =?utf-8?B?cFh3c1BYNWpzNTVvVG5JNVltMFI5bTA2TTRVYWtST0d4bkhPOUdoM0dnMkR1?=
 =?utf-8?B?ajdHbngyWFNQNlBaZG8yZVBzNTdWR2JZcHluN0w2ZCtCaU9xOTNPV2t3b3cv?=
 =?utf-8?B?TmVXVm96WlJETWZNZ3h1aDZxeHEzdG5QVWExQlgwL3RjUXdKUi9iWFZBNzBE?=
 =?utf-8?B?cHFaTXVQa0N1SGwxMVVTSHBiTHdiUlVhK1JaQUpyNE4wblZRT2llb3JHaEpq?=
 =?utf-8?B?YXZ2MHJjTitZUmM1R3lkTHZVNk1IS2pYUTV2V2ZUUGh6cmo4ZWFvQlRjMnRU?=
 =?utf-8?B?Lzh6Z1ovMGo4d2tlVGdKZm5JeGh2TWxTa1JLdVprUkJ4NHZzREVCMEk2QzVD?=
 =?utf-8?B?Zkp1cDJKdjVlVDJOSi93MjRTWjRuczgwZ2dMRjNpa3RKUisyM1YvNkNWRnI2?=
 =?utf-8?B?VEMzclBGaTJLUjZvb0tHaHNsa0VndVovL3ZqNDRXSjVXYW5YQUhLbzV4QW5y?=
 =?utf-8?B?clc1Ny9lWktUeFY1a0NEVTlGOGZ4eGdiL2U4L25hd1dhbFZSYUpDM255eER4?=
 =?utf-8?B?amVjbDFVVERKaXFXUFZHQnBWOXJDUHBZVXNsVm94ZDRyVHp5c3RTZDdyRTFD?=
 =?utf-8?B?VGR3bWZXUTVUeWRDdE51aHFFKzRJbENNY2hOL0FrM3dHWGdKQnVRcnpYcFVV?=
 =?utf-8?B?S2VMZGlaZVR3MnNWMStoZUVqWklnT2tRWTJVd2kwLyt5SEZSSEFTbGdKUzNk?=
 =?utf-8?B?L1E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c657560-13eb-40d9-88ac-08dac7c54f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 11:25:47.8238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKT61vn+Z8LmJDciDhLbdZvnAGAN2puOkPgqyg96GBzOnRpHky/j2fWR4ByF2TgbbG7XU3wqRBlTJtzBQlPH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4276
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <58DADD5C9138444AA8A3D752DBED7525@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMTEvMjAyMiA2OjQyIHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IE9uIFdlZCwgTm92
IDE2LCAyMDIyIGF0IDA2OjI4OjIwUE0gKzA4MDAsIFJhaHVsIFRhbndhciB3cm90ZToNCj4gID4g
UHJlc2VudGx5LCBpbml0L2Jvb3QgdGltZSBpbnRlcnJ1cHQgZGVsaXZlcnkgbW9kZSBpcyBlbnVt
ZXJhdGVkDQo+ICA+IG9ubHkgZm9yIEFDUEkgZW5hYmxlZCBzeXN0ZW1zIGJ5IHBhcnNpbmcgTUFE
VCB0YWJsZSBvciBmb3Igb2xkZXINCj4gID4gc3lzdGVtcyBieSBwYXJzaW5nIE1QIHRhYmxlLiBC
dXQgZm9yIE9GIGJhc2VkIHg4NiBzeXN0ZW1zLCBpdCBpcw0KPiAgPiBhc3N1bWVkICYgaGFyZGNv
ZGVkIHRvIGxlZ2FjeSBQSUMgbW9kZS4gVGhpcyBpcyBhIGJ1ZyBmb3INCj4gID4gcGxhdGZvcm1z
IHdoaWNoIGFyZSBPRiBiYXNlZCBidXQgZG8gbm90IHVzZSA4MjU5IGNvbXBsaWFudCBsZWdhY3kN
Cj4gID4gUElDIGludGVycnVwdCBjb250cm9sbGVyLiBTdWNoIHBsYXRmb3JtcyBjYW4gbm90IGV2
ZW4gYm9vdCBiZWNhdXNlDQo+ICA+IG9mIHRoaXMgYnVnL2hhcmRjb2RpbmcuDQo+ICA+DQo+ICA+
IEZpeCB0aGlzIGJ1ZyBieSBhZGRpbmcgc3VwcG9ydCBmb3IgY29uZmlndXJhdGlvbiBvZiBpbml0
IHRpbWUNCj4gID4gaW50ZXJydXB0IGRlbGl2ZXJ5IG1vZGUgZm9yIHg4NiBPRiBiYXNlZCBzeXN0
ZW1zIGJ5IGludHJvZHVjaW5nIGENCj4gID4gbmV3IG9wdGlvbmFsIGJvb2xlYW4gcHJvcGVydHkg
J2ludGVsLHZpcnR1YWwtd2lyZS1tb2RlJyBmb3INCj4gID4gaW50ZXJydXB0LWNvbnRyb2xsZXIg
bm9kZSBvZiBsb2NhbCBBUElDLiBUaGlzIHByb3BlcnR5IGVtdWxhdGVzDQo+ICA+IElNQ1JQIEJp
dCA3IG9mIE1QIGZlYXR1cmUgaW5mbyBieXRlIDIgb2YgTVAgZmxvYXRpbmcgcG9pbnRlcg0KPiAg
PiBzdHJ1Y3R1cmUgWzFdLg0KPiAgPg0KPiAgPiBEZWZhdWx0cyB0byBsZWdhY3kgUElDIG1vZGUg
aWYgYWJzZW50LiBDb25maWd1cmVzIGl0IHRvIHZpcnR1YWwNCj4gID4gd2lyZSBjb21wYXRpYmls
aXR5IG1vZGUgaWYgcHJlc2VudC4NCj4gDQo+ICA+IFsxXSANCj4gaHR0cHM6Ly93d3cubWFudWFs
c2xpYi5jb20vbWFudWFsLzc3NzMzL0ludGVsLU11bHRpcHJvY2Vzc29yLmh0bWw/cGFnZT00MCNt
YW51YWwgPGh0dHBzOi8vd3d3Lm1hbnVhbHNsaWIuY29tL21hbnVhbC83NzczMy9JbnRlbC1NdWx0
aXByb2Nlc3Nvci5odG1sP3BhZ2U9NDAjbWFudWFsPg0KPiANCj4gTGluazogPw0KDQoNClJlY2hl
Y2tlZC4gTGluayBVUkwgd29ya3MgZm9yIG1lLiBBbSBpIG1pc3NpbmcgYW55IHN0YW5kYXJkIHBy
YWN0aWNlIHRvIA0KYWRkIFVSTCBsaW5rcyBpbiBjb21taXQgbG9nID8NCg0KDQoNCj4gDQo+IC4u
Lg0KPiANCj4gID4gKyBpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKGRuLCAiaW50ZWwsdmlydHVh
bC13aXJlLW1vZGUiKSkgew0KPiANCj4gWW91IG5lZWQgYSBzZXBhcmF0ZSBwYXRjaCB0byBzaG93
IHRoaXMgcHJvcGVydHkgYmVpbmcgYWRkZWQgKHllcywNCj4gSSBoYXZlIGp1c3QgY29tbWVudGVk
IG9uIHlvdXIgcGF0Y2ggMikuDQo+IA0KPiAgPiArIHByaW50ayhLRVJOX05PVElDRSAiVmlydHVh
bCBXaXJlIGNvbXBhdGliaWxpdHkgbW9kZS5cbiIpOw0KPiAgPiArIHBpY19tb2RlID0gMDsNCj4g
ID4gKyB9IGVsc2Ugew0KPiAgPiArIHByaW50ayhLRVJOX05PVElDRSAiSU1DUiBhbmQgUElDIGNv
bXBhdGliaWxpdHkgbW9kZS5cbiIpOw0KPiAgPiArIHBpY19tb2RlID0gMTsNCj4gDQo+IFdoeSBu
b3QgcHJfbm90aWNlKCkgaW4gYm90aCBjYXNlcz8NCg0KUmVzZXQgb2YgdGhlIGZpbGUgdXNlcyBw
cmludGsoS0VSTl94eHggIiIpLiBJbiB2MSwgaSB1c2VkIHByX25vdGljZSgpIA0KYnV0IG9uIHJl
dmlld2luZyBhZ2FpbiBmb3VuZCBpdCB0byBiZSBvZGQgb25lIG91dCBpbiB0aGUgZmlsZS4gU28g
DQpzd2l0Y2hlZCB0byBwcmludGsoS0VSTl94eHggIiIpLiBJIGNhbiByZXZlcnQgYmFjayB0byB1
c2luZyBwcl9ub3RpY2UoKSANCmlmIHlvdSB0aGluayB0aGF0J3MgYSBiZXR0ZXIgZml0LiBUaGFu
a3MuDQoNClJlZ2FyZHMsDQpSYWh1bA0KDQo+IA0KPiAgPiArIH0NCj4gDQo+IC0tIA0KPiBXaXRo
IEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo+IA0KDQo=

