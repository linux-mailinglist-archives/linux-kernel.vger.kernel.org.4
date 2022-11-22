Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF5633A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiKVKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiKVKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:48:33 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C838254B38
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669113915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bYvgPaktZ2+OWHK7of7JEGCmQCVOrBp4XADUybKy88=;
        b=RPwzUAtEPFPDsrAgJGzAr1jGQWy86xoagq4fiwSdFqUl5r2fIQqXYZSuyW1Me7Kt/aCA22
        ifhweR8KtljYNJou/IIapQ3MSsE/QoQGoiYbJzKHXNQ2SqpB/KKFPGBVSYQyph/Qsn7QWp
        MpMU06Vx25Z5TT4OLK/Fh9OHxK4Yv9RV/yNVy/aPKzRUOHksuAUdhEv+qD6Mn5tNI3bOoy
        BSVGT4ODNNZ9UT9Rr4qTxkhfnXvCi4PXeBDXL1dSWG3l8g7uKbD6N9EUsvKxr6HzqKi7JP
        oAr5b/i7jII8bdaX4BJdNPo7FRie1toTNUhscfM8HmxUt5bEOjHe83uQMK7bTQ==
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-IFiWutM0NLmM-_FTR0GYHA-1; Tue, 22 Nov 2022 05:45:14 -0500
X-MC-Unique: IFiWutM0NLmM-_FTR0GYHA-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by IA1PR19MB7230.namprd19.prod.outlook.com (2603:10b6:208:42d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 10:45:12 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:45:12 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Thread-Topic: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Thread-Index: AQHY/kRd6x7F/veGJUyUIWlGtgApL65KqhWAgAAIsICAAAcvgIAACH8A
Date:   Tue, 22 Nov 2022 10:45:12 +0000
Message-ID: <fee4cf31-11be-9459-7d7b-ba8729dfb356@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
 <a7a1b539-bd69-0227-ea93-b90f2e3ef2cd@maxlinear.com>
 <Y3yhFWQ7NHMArO74@smile.fi.intel.com>
In-Reply-To: <Y3yhFWQ7NHMArO74@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|IA1PR19MB7230:EE_
x-ms-office365-filtering-correlation-id: bc809769-5c9b-483c-526c-08dacc76a21c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: iUcZ3YiML9BFM0C5+Gzdv1vyj62pXne/BzOM9GQrEbSoqlZpx9Xs7fBKWUzetaDuzjL7DdHlEXD8So9fN3tQQVdi2/f5K6+G3RJXMKQLPrvLD156Nq33A2S8CgPxMZaY5W+gFoQTjM3QGLSHKJEMMWgRQAZMWfF8a54ep1QtOiY0fl076qiQz5HStGPsb9Ts7WapQcGqgfmvMPAn7fOPbYRM9h4YUuun2UUSgtcQzzpM8TamxDJNL1nE+ny/8niEq4bQq10Swg+PG/IW6Dlix+BD0K1QQyqnLEdkkKdzr5pt0ceYoUjHaifjtmjDAyyColDX3+HbrIrdyK5zgR58AaH5J0lIruT4rO22m8oYnAu1TLaBSxl7g22DkcI6h9DzXaWvh6A7ojkoD8e5hm37G62ahm7xNccX2voZjfcgo5SAmGIrv++yDF08exNVRepHy18bw6MX+P/JiLiSvINYoarl6hgiW3vPEDeJuZQLTZJKW0/vJcZpiY0/vSqadvaVGYkSCkDUFx+0n+hrpBdO6tkglpo4hbpZa5+azqJK1lpFr26e21+v1J6xUy9xUdhd65yfCvKJp1hH3FgvjwYiI3UfcoAnL3MTGNmL0K2m4rWbrXPkrmj7r0lweVrXtqpK1Z3OjTGswshevx5UMthU341FIFiW6SUMntxksmTDnONFNOfOXv1i92kaNDfuc8RXASERJNCNDRWJWJYysBjSnB1+FcZNF8DCGkZEHXNMrOYHdw/cv+rEKUOCve14ySJGUf9++j0KZ1gdMwB+jfXoe01fpLbhxUFGFd7LrVXe4PzPHEUS6LEAy2tkPKWPkUW4ckmscsVkuLxQjyvXPtF+ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(396003)(136003)(346002)(376002)(451199015)(2616005)(966005)(83380400001)(2906002)(6486002)(186003)(6916009)(54906003)(26005)(71200400001)(6512007)(316002)(6506007)(478600001)(53546011)(36756003)(38100700002)(107886003)(122000001)(91956017)(38070700005)(8676002)(7416002)(76116006)(66946007)(66446008)(66556008)(64756008)(4326008)(5660300002)(8936002)(66476007)(41300700001)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkVnM3pYejRUL25zOSs2MzB3L210Vk5zZEpIdTV4b05sb2NpT1dhWmJ1LzZl?=
 =?utf-8?B?Y2xwZHZJUXJQMFU3VEVYU1ZVU0YxUlY2blJFSkFvNmgxNFcyUzFPeURIemtD?=
 =?utf-8?B?THZubjFEQUdnYW5ucytGTFBBMjRNQjROVnlZWk5LZUZVZ1BiK1BjLzFadXZi?=
 =?utf-8?B?UkZhQitFSDJ2cnJCeCtwK21LdWlNV1JzaWhOYWFTZUVRRGx5QjZPVHJ5eEJO?=
 =?utf-8?B?eHhiTklwUll0Z0UrVExDMndJZEU5eUlvUWQraE9EWWhkUHlqa0pBK3E4clJS?=
 =?utf-8?B?REdTQWVndXU3UVZLajZQTlpEaXVVTldKTVFXSnh4U2t1MnR0VjVyZVpxOHJX?=
 =?utf-8?B?RW1FTThhRkd5WlBLcmJoNC9nV3RORnBmVHFxT3pnR0w2emg0NGFoamFxZFNC?=
 =?utf-8?B?bjdaK1lQRFduc2EyUjNuMkptSUd2V2RPR3puOFAwTVZRdDlaNXJFMmJNQ2tx?=
 =?utf-8?B?OHFnaUNQRm5LaHFmcTFWd0JaV0Q1Wm0yc01rRGp0RzUrdjlPUEl5a3BEcE9O?=
 =?utf-8?B?WnZKKzFuNTE3K2N1Q3ZOcFlJaVpKT25oWVc4ejhTLy9qREhoYVdNUTJRS1Uz?=
 =?utf-8?B?ckZ5WE5sUnBER1Rxd2Z5QW1rS09ERUFFOVZkVWxuM0MraS9paEpMWTd1VmRZ?=
 =?utf-8?B?dWhTTXpMclZPdjJKbXljcEhlRWQyaUhOUFVaWHRZYzRXNFZ0TnJ5bHJsOUpR?=
 =?utf-8?B?UmNjK0ltc0VHcjlqTTlQN0h4QXNoanQzdWhnRzFqOElqRy9wdDVlMGNQa0xH?=
 =?utf-8?B?UCtIT0xhQUlhRjZZY1F6R29iMXZieDlPeDlvUElEQUlFNytMdTFZWFpPaVdp?=
 =?utf-8?B?RHlLdUhRMkVOd3g0TGx3UXp3SUEreHZYZnZyNU9mWE14RTVKQk9UQU5zckdU?=
 =?utf-8?B?T2RudWRRU3ZpUFE2VGFmcDN3ZjFxNWgxRk9qRlFJRFAyUWFMemY5NFc4azhS?=
 =?utf-8?B?aGdMTTdOTnBmME4wNjNFc0Z2VEQ3MExaUUdFWGFyMWdNbDdLQmNaSVcxd3gx?=
 =?utf-8?B?NFJZZHVmNDk5SzQ0VUdSdUl0azI1ZkFGUXlTYUVlbmpVNk1pYjVzYWdRb2ZM?=
 =?utf-8?B?b0hFUjhOMHRlSGdGWUlSMFVMNGFVWnEwbFBSdEt5ckgxVlBtRVg3TVVhaHBR?=
 =?utf-8?B?a3pTMjQrSmsySXduY0xHM3lDeGhYelV5VHk4V0x5T3lOcXcza2RuM3NuRUpI?=
 =?utf-8?B?Y0FEM2VJcVhaTFFRTklzWnJMNUFYekF2ZEhML1U5Sm5oUFo3OXRrclJNeGNI?=
 =?utf-8?B?T2pYQThIZW42OFNWc0NCOUUyeWhHcFJhY29NY0RKbUh3ZUxianZxREo5YTdY?=
 =?utf-8?B?cmRwYzZFQ1RPTXFFdnBMRmpwbUpjdmRtdXUvRTF5RUw5cEswbEZhZmNTRlA4?=
 =?utf-8?B?empQQ1dyRjNhelYwcEdDZGZZd1kyWjZ5Q3JHUzJSbjhCNUg3ZWcwZGxLdjhu?=
 =?utf-8?B?NzFWZFZaSWNsTkM0U2xxbm40QWhKRmFwSHFPVk1RdkU0ZzJhQlJGREpWMStt?=
 =?utf-8?B?L0FObGtCMTlBVCtCYnFEcnYyZkphRTZJd1VLQzZQVXdQMFg0TEdFRStITzVx?=
 =?utf-8?B?aG9ZUjhFbFVCQ084dWFHUVFsSHJTOC9UWERidk8zVkc4c2ZSWWlNblN6MzlV?=
 =?utf-8?B?WE9EaW5EeW44NkhtU3FwdSt6OXVKYzJYYXdiUnFOWUlUaHBPZXJSdnhScTY5?=
 =?utf-8?B?SGIvMXNFd0hOTmVQdVRISkNKSnV2eW5UaU5ycnlTNGJ6bnIxTzVZbUVzRllM?=
 =?utf-8?B?aGkzZnBEOUR1cWNHbWpsak9wcnNNWEtUQTBTU2xlbTU5eTBTN3JQRmNNNUJk?=
 =?utf-8?B?WStDR21XNTgvQVpyTlRHdmRTTlUraDdkSnhndzlCUUVRN2d4NkxtL1g4U2tH?=
 =?utf-8?B?eU0zQysrN2FYSjdzQ296NHJ4YlovSlhTaWZBWTd5OXRxaTBqQnJHT3BPUk82?=
 =?utf-8?B?MEprQ0lYbnpzOEFCVE9mN2xmY25Bekdla2N4cEs0YXhpNm9ZR01oTFJWd2Qv?=
 =?utf-8?B?eVpsMVBXdnJTb1A4azlmY1N3N0ZObjJWMnJGV1FtYUNYdGUwUXB5V0duNFQx?=
 =?utf-8?B?Q0RyUUR1WDN5ME8yNWk1aUJrQWZEL0w0RTBZQXkwT3M5bVp2cmUrckZsd0k3?=
 =?utf-8?B?UWN3UDJzWjQrWDAyRDl5SENDYmR2OW1MQjkyZHltaGI0YUs4dlFoeGpSdldt?=
 =?utf-8?B?K0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc809769-5c9b-483c-526c-08dacc76a21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 10:45:12.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwfeOlMv6MQjWkOe5QgGeH7VbiaTx2y6CXGCzcUIy06lscRwTpm4KjJWOqdj0pWAWIRMsumEfsCPH8A5TcEyzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7230
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <5F79F171A0398E4AB90DB97E46C4FF27@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMjAyMiA2OjE1IHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IE9uIFR1ZSwgTm92
IDIyLCAyMDIyIGF0IDA5OjQ5OjA0QU0gKzAwMDAsIFJhaHVsIFRhbndhciB3cm90ZToNCj4gID4g
T24gMjIvMTEvMjAyMiA1OjE4IHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ICA+ID4gT24g
VHVlLCBOb3YgMjIsIDIwMjIgYXQgMDM6Mzk6MDZQTSArMDgwMCwgUmFodWwgVGFud2FyIHdyb3Rl
Og0KPiAgPiA+DQo+ICA+ID4+IFJhaHVsIFRhbndhciAoNCk6DQo+ICA+ID4+IHg4Ni9vZjogQ29u
dmVydCBJbnRlbCdzIEFQSUMgYmluZGluZ3MgdG8gWUFNTCBzY2hlbWENCj4gID4gPj4geDg2L29m
OiBJbnRyb2R1Y2UgbmV3IG9wdGlvbmFsIGJvb2wgcHJvcGVydHkgZm9yIGxhcGljDQo+ICA+ID4N
Cj4gID4gPiBZb3UgbmVlZCBwcm9wZXJseSBwcmVmaXggdGhlIGZpcnN0IHR3byBwYXRjaGVzLiBJ
IGd1ZXNzIGl0J3MgDQo+IHNvbWV0aGluZyBsaWtlDQo+ICA+ID4gImR0LWJpbmRpbmdzOiB4ODY6
IGlvYXBpYzoiLg0KPiAgPiA+DQo+ICA+DQo+ICA+IFllcywgaSBqdXN0IGNoZWNrZWQgdGhlIGdp
dCBsb2cgb2YgZGV2aWNldHJlZS5jIGFuZCB1c2VkIHNhbWUgcHJlZml4ZXMNCj4gID4gaGVyZS4g
VGhhbmtzIGZvciBjb3JyZWN0aW5nIGl0LiBJIHdpbGwgdXBkYXRlIGl0Lg0KPiANCj4gTW9yZW92
ZXIgdGhlIENjIGxpc3QgaW4gdGhvc2UgcGF0Y2hlcyBpcyBxdWl0ZSB3cm9uZy4NCj4gDQo+IEkg
cmVjb21tZW5kIHRvIHV0aWxpemUgbXkgInNtYXJ0IiBzY3JpcHQgWzFdIGZvciBzZW5kaW5nIHNl
cmllcy4NCj4gKFlvdSBtYXkgdGFrZSBhbiBpZGVhIGZyb20gaXQgaG93IHRvIHByZXBhcmUgdGhl
IENjIGxpc3QgY2xvc2UgdG8gcHJvcGVyIA0KPiBvbmUpDQo+IA0KPiBbMV06IA0KPiBodHRwczov
L2dpdGh1Yi5jb20vYW5keS1zaGV2L2hvbWUtYmluLXRvb2xzL2Jsb2IvbWFzdGVyL2dlMm1haW50
YWluZXIuc2ggDQo+IDxodHRwczovL2dpdGh1Yi5jb20vYW5keS1zaGV2L2hvbWUtYmluLXRvb2xz
L2Jsb2IvbWFzdGVyL2dlMm1haW50YWluZXIuc2g+DQo+DQoNCkFncmVlIG9uIHRoZSBDYyBsaXN0
IGJlaW5nIHdyb25nLiBUaGFua3MgZm9yIHRoZSBzY3JpcHQuDQoNClF1aXRlIHVzZWZ1bC4gQ291
bGQgbm90IHVuZGVyc3RhbmQgaG93IHRoZSBzY3JpcHQgd29ya3MgZm9yIG11bHRpcGxlIA0KY29t
bWl0cyB3aGVuIHlvdSB0YWtlIGNvdW50ICYgdmVyc2lvbiBhcyBpbnB1dHMuIEFsc28sIHdoZXJl
IGRvZXMgaXQgDQpjcmVhdGUgcGF0Y2hlcyAoZm9ybWF0LXBhdGNoKT8gSXQgc2VlbXMgdG8gZ2V0
IHN1aXRhYmxlIHRvICYgY2MgbGlzdCAmIA0Kc2VuZCBlbWFpbHMgdG8gdGhlbS4gQW5kIHRoZSBp
bnB1dCBpcyBDT01NSVRfSEFTSC4gSG93IGRvIGkgdXNlIGl0IGZvciBhIA0Kc2VyaWVzIHdpdGgg
bXVsdGlwbGUgY29tbWl0cyAmIGRvIGkgaGF2ZSB0byBjcmVhdGUgcGF0Y2hlcyBvbiBteSBvd24/
IA0KVGhhbmtzIGFnYWluLg0KDQpSZWdhcmRzLA0KUmFodWwNCg0KDQo+IC0tIA0KPiBXaXRoIEJl
c3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo+IA0KDQo=

