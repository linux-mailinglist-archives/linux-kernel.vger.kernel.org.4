Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF7609AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJXHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJXHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:07:34 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094A4BA5B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:07:32 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-igKNezPpPDytJ-EgZcKtHw-2; Mon, 24 Oct 2022 09:07:29 +0200
X-MC-Unique: igKNezPpPDytJ-EgZcKtHw-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0826.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:49::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Mon, 24 Oct 2022 07:07:26 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa%4]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 07:07:26 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Topic: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Index: AQHY52JVtEC2K5cmwkW+75mG5zL4k64dH8MA
Date:   Mon, 24 Oct 2022 07:07:26 +0000
Message-ID: <e111222f3c3157ad6c81022fa66e6cbc9072f9af.camel@toradex.com>
References: <20221024153720.5e387e34@canb.auug.org.au>
In-Reply-To: <20221024153720.5e387e34@canb.auug.org.au>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0826:EE_
x-ms-office365-filtering-correlation-id: e8ed388c-6366-4a52-971f-08dab58e6852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: uG+2r6OVLXLiYXOGMrdBVCLnXUC/2e99cFv2XIDPqufUJ5Lf11iJoxaTypMeUd+rCd52I32CwhJioHYtfhgdtVBu/WbQoGCqUiOJ/MAloY4m0ifeHq5S6mw/HPH/5AL9WHCWhEd4TNuWsQL6e8jXpoiH9dOsw0fBV71O2SvrMpCOvEL5RgmngcD0ymXkjoZ4lvHszbXFDHHmBjlGxTpK3+0VmIqgB4+MzV1LpqGlTF+87sngXjTXvFe0X1GEmXaH6vys6snGEpX/S2knnNs2+JZfEsrg98cZPXu/JDfz5bGjA2QJRYjChqCKh1IjUPKfQsjLEWyekkuBrih3gYYAB2Prd8L7cMMptoDhWMQYaPxtI7PR6pcew+IU0JzOnh9EX6tZm67zuMkeCso/qrKYaGFidG4ez6qH2LT1f5y63eZLXG9e3j7I20xBqczQ6iBTn+p7dg2vzX9bCuHEmoZ9/zJxVYRE3DQ6ZUYfpsiYKyXgodRTUE6JR8s+Kz+aBXGTmER0SBuYa8LL9b0eR4EEOT0Hg2W0EitseJ4Yw5zbsLoH22RwUG5TcDKv4uNFAMDKXJauU3aMRvUfRJEpLGjtI7ptVHbxKDh1eXuZEGkK9uxOCa8pE4gT4sym4W6TMyEMN/AByIE72NA3EFGJt2LBpM1e9oYOrmU1nYYIQkWzjLo7JTXGXf9LTL5zKVSW4uXaYzfJ4GdqbZ8ar3cPz/X/YtlKbi1zx17a9p1xItfVKCmb3VJXckpwfmTgXkCGe9hbhMA4WJSWqFbMd9BsoLI6uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39840400004)(376002)(366004)(396003)(136003)(451199015)(36756003)(86362001)(38100700002)(38070700005)(122000001)(2906002)(4001150100001)(44832011)(4744005)(6506007)(6512007)(186003)(6486002)(2616005)(478600001)(4326008)(8676002)(110136005)(54906003)(316002)(66556008)(66446008)(64756008)(66476007)(5660300002)(41300700001)(76116006)(71200400001)(8936002)(66946007);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUFTZkhjNllLRWlmWktGdG5FaUx1L1RFbkV5UUhORjFQRzlTdzRiREFNbkxh?=
 =?utf-8?B?MHF4Nnk0bkJZWlZ1Zzg4MTFIS0luRFl0STgvOUUwR1EyTnRVYVFzM2o1eXZx?=
 =?utf-8?B?RjZYdEtvK3JRNGNwdDhWTnpqTEpDSjNOT2swcng0T2FvNHk1K1FrWWNST1ZU?=
 =?utf-8?B?WXFGUTE2cVhQZHJFL0czeDMveml6K0IwMU9zYUhGUWVuR3I5alIvUmkzaUZE?=
 =?utf-8?B?QnMxdkN0UFl3MEduUUZoZHdrVld2akx1SzA3L29LT3YvWStFNk9PSk84UkNO?=
 =?utf-8?B?a3VuanhGOStaU2Y3amVJKzBmRlRqL1VRL1c4UXFxUFFMRlN1dzZyKy9heXcv?=
 =?utf-8?B?YmlyczNaRWxWZmV6QnJHTDVqOUJpdHQ4Ujg1MTRyWUZzbko1WnpSMUh4aUFV?=
 =?utf-8?B?azRLS3ZsanNrV0dzbkIxNWFtRmZJdis0YWVWclNsb3dKMkRiMk0raDROQ1dZ?=
 =?utf-8?B?eEZ3ZHVmc1ExU0RDeWtMMXFiV2h1Z0JaNFNINGQ0QTNIY0ZKUXVCMkpaSUNS?=
 =?utf-8?B?b2F4QWx3c3dtWGVvS3JjMFdhWGpzWjRoSk9TTjFKUXpvdjFicXQ4TjYzWE9W?=
 =?utf-8?B?TkY5NDhnN2I5Y3VFVUloSEtVS1h5eS9zL3RYSWNWUzlMVXlHL1JRRStDampD?=
 =?utf-8?B?Yi80Yy9KZTZUaTVjcnRVbTZjSmNlSHZnTVUvN0txd1lWaUpHd2VRQ3hsQXlq?=
 =?utf-8?B?elhJQzk5UG5SaHpkY2hUOVNMaVh6QVhyc2NjS043OHBpTnQwcGI0RnNvdHI0?=
 =?utf-8?B?RTFlZXBENGRrb05ZY091cnB4VW1kQlVQejB2RFZGdWo0ai9EaTFBYUNCL0VN?=
 =?utf-8?B?LzdqWVJySmVVaFBwQ1Y3QWYrN2RxdkJQbENzSVVQWWJwUmFJMnVxcXgxOTVO?=
 =?utf-8?B?UkQ1TWJMM0hKMUd5THdWZitkV0RveklVY3hqQnprbUdiUVJuK21ES3owR2Vy?=
 =?utf-8?B?NitPV2UwOERPOVg0d1NDVjliR2lZWGFiRG5QRDN3NHVFVW8rMXVuczR4WmFK?=
 =?utf-8?B?MTh1dVQyOHNab05SaE5oMnlYaWJwREZjT1VqVVFobGc3SlNkbm5VTXk1TGhJ?=
 =?utf-8?B?SlNBak9QZW9QOXdYTnNXS1VIVGFoNys4dGNjR3dPcWlkV2RJRmNMNC9rR202?=
 =?utf-8?B?YWo4MXprVWNOV3VXWXRLMW1ZU1h1aXR3bjJvMGNTLzRDb0ZsUk5EM28yREd5?=
 =?utf-8?B?SGh4S3UrdWZNZDhUaXp3NVh6S09RNVk4cncvVXRZRHpheTZ1b2hvZ2lWN1Vt?=
 =?utf-8?B?blU2amwwSU1BUkxtdEJzZndXRzQxU1NFK0tkZFBlTk9qZVp6T01NVVNlellY?=
 =?utf-8?B?dm9UWmM0eEx0Sklaclg3WWdBNk1ocjkvZ29Sa2lrMXdZejgxV1Z2UkIvbjdv?=
 =?utf-8?B?dk5PZUZXbVJCWkhuM3dJVDJRSjg3N01mSkV1dHdhL0xiVStOV2ZyZDNxSnkz?=
 =?utf-8?B?RXpHSmJaZUo2a0lNcjlCS1J5WHpkTTMzMUZFMXliV25aVk5FalZZRHdzL2t4?=
 =?utf-8?B?SmhUNDNjYytlOHQzZVZ6UkJKNVc0a09KaGZYS1o4Y2NuUERIeUhHd2Q3cnR4?=
 =?utf-8?B?cWJQaTlpS2R3Z0JDUGhaemRlUUpqTDRuMHB3QnlsNmZCTnlkbmhYZGl6U0dq?=
 =?utf-8?B?UkFlbjJNeEZMZWNTQ2RQTW1OK0k5KzBxZUtMSFFDWklzK1h4dFhHVnlvZ0th?=
 =?utf-8?B?UlcrZzB2UjdHWEJORVNEaG1PSCt5QStGbm84VmlsQkdwSVFIckFVUTdmWGMv?=
 =?utf-8?B?c0M2WGVCS0tYVEt3WEQ1cW9zdk9rajlEeHlxajU2Y1F3WmNHZXE1cnFXN0Ft?=
 =?utf-8?B?QWo5bCttSEJGdzhVbEVGS3pibkZoQ3YycFYwYmE5anNCT2VMdWxIVDZYZmJL?=
 =?utf-8?B?Vlp6SXZ2YjcyT2V2SjFibldYSXJnOERHN0dJZ2cyVFV1bVdOenVVdU9tc0Rs?=
 =?utf-8?B?ektJRVJrMnVYeGo4ZytsNUNsVUhHQnI0Tmk1MjdpczFqaWg1RlJmamlWb0NH?=
 =?utf-8?B?cmx5c1dJeUNMMllON3BkWTd0TXVLM1VnUTNaWk52MXVpTkRkVncvRzloRXBE?=
 =?utf-8?B?RnlPSVVLbUY1dlA5Qjh2c2ZNWDdqNThRTUs0WXFSWDZoZjFkOEI5cnpGMmlr?=
 =?utf-8?B?UTNWS3BLdm9QZERpUkRmbU1Ja2RuTWl4dWJNU1lwaHJVUFlJckxXaTRROURl?=
 =?utf-8?Q?kZq5s38Rpwf4syzn6pZgsb13awgEotVY8goDWCBXoJdJ?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ed388c-6366-4a52-971f-08dab58e6852
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 07:07:26.6104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmAmODvi7H88XYgJc6tjkS8zU/KYA9QiXReiF4T0m2Ay4Haxch9R5c/dOBbHhYfFTdxcJhbuwgPa8ztRtMFCI5UGnpbL8ZYW96pcNg0oCWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0826
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <B870153DFD6FE0419F6B4F983750A0C4@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbg0KDQpPbiBNb24sIDIwMjItMTAtMjQgYXQgMTU6MzcgKzExMDAsIFN0ZXBoZW4g
Um90aHdlbGwgd3JvdGU6DQo+IEhpIGFsbCwNCj4gDQo+IEluIGNvbW1pdA0KPiANCj4gwqAgYzk1
NDU3NTRlOWE3ICgiYXJtNjQ6IGR0czogdmVyZGluLWlteDhtcDogZml4IGN0cmxfc2xlZXBfbW9j
aSIpDQo+IA0KPiBGaXhlcyB0YWcNCj4gDQo+IMKgIEZpeGVzOiAxZDhkZjljNzRiZmYgKCJhcm02
NDogZHRzOiBmcmVlc2NhbGU6IGFkZCBpbml0aWFsIHN1cHBvcnQgZm9yIHZlcmRpbiBpbXg4bSBw
bHVzIikNCg0KT2ggc2hvb3QsIEkgZ3Vlc3MgTWF4IHJlZmVyZW5jZWQgdGhlIGNvbW1pdCBmcm9t
IG91ciBkb3duc3RyZWFtIGJyYW5jaCBhbmQgd2hpbGUgSSBjaGVja2VkIHRoZSBjb21taXQgdG8g
ZXhpc3QNCm9uIG15IGVuZCBJIG1pc3NlZCBpdCBiZWluZyBhIGRvd25zdHJlYW0gb25lOg0KDQri
rKJbemltQHRvb2xib3ggbGludXgtdG9yYWRleC1pbXguZ2l0XSQgZ2l0IGJyYW5jaCAtLWNvbnRh
aW5zIDFkOGRmOWM3NGJmZjVkMzZkNzU1MzI0YmUxZTY5NWFiZjljZGVjYTgNCiAgdG9yYWRleF81
LjE1LTIuMC54LWlteA0KDQo+IGhhcyB0aGVzZSBwcm9ibGVtKHMpOg0KPiANCj4gwqAgLSBUYXJn
ZXQgU0hBMSBkb2VzIG5vdCBleGlzdA0KPiANCj4gTWF5YmUgeW91IG1lYW50DQo+IA0KPiBGaXhl
czogYTM5ZWQyM2JkZjZlICgiYXJtNjQ6IGR0czogZnJlZXNjYWxlOiBhZGQgaW5pdGlhbCBzdXBw
b3J0IGZvciB2ZXJkaW4gaW14OG0gcGx1cyIpDQoNClllcywgSW5kZWVkLCB0aGF0IG11c3QgYmUg
dGhlIGNvcnJlY3Qgb25lOg0KDQrirKJbemltQHRvb2xib3ggbGludXgtbmV4dC5naXRdJCBnaXQg
YnJhbmNoIC0tY29udGFpbnMgYTM5ZWQyM2JkZjZlYzdlYjBmMDkzYjZlZjAzOTFlMWYzZDE1MmY3
MQ0KICB2NS4xOQ0KICB2Ni4wDQoNClNvcnJ5IGFib3V0IHRoYXQhDQoNCkBTaGF3bjogQ2FuIHlv
dSBmaXggdGhpcyB1cCBvciBkbyBJIG5lZWQgdG8gcmUtc2VuZCBhbnl0aGluZz8NCg0KVGhhbmtz
IQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

