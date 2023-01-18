Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D467205A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjARO56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjARO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:57:35 -0500
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 06:53:25 PST
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A993CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:53:25 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-qx5KjuwZMT2TR-fk15EFtQ-3; Wed, 18 Jan 2023 15:52:05 +0100
X-MC-Unique: qx5KjuwZMT2TR-fk15EFtQ-3
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::14)
 by ZRAP278MB0063.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 14:51:58 +0000
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f9e:5ebd:d37b:b0cb]) by ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f9e:5ebd:d37b:b0cb%6]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 14:51:58 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "reinhold.mueller@emtrion.com" <reinhold.mueller@emtrion.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm-verdin: Add yavia carrier board
Thread-Topic: [PATCH 2/3] arm64: dts: imx8mm-verdin: Add yavia carrier board
Thread-Index: AQHZK0rlf/xVXti07U6rrNeHwKVA166kQBcAgAACJoA=
Date:   Wed, 18 Jan 2023 14:51:57 +0000
Message-ID: <342f1633d0400087c5188cbe17823df9b450d526.camel@toradex.com>
References: <20230118144042.7705-1-dev@pschenker.ch>
         <20230118144042.7705-3-dev@pschenker.ch>
         <c55d26a9-21dc-4c64-38fa-446975df16cd@denx.de>
In-Reply-To: <c55d26a9-21dc-4c64-38fa-446975df16cd@denx.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0377:EE_|ZRAP278MB0063:EE_
x-ms-office365-filtering-correlation-id: 102d2398-2dcc-41ce-43ff-08daf9638c7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: v/fbHf74Vp3iwnHweNxo1QsCUhc+E1YFHl3sHVwH6koFiXrlh16R9Pdqp53JgaZeAqEEV/mVO/SZobX3xiJM8j4LtJQMjLYbTdtcSYMBaQJl9mtNRmZdm765qtoxznc7OCah+MYIhSYG9U9aEYndOt729s5BDQY7zasCRm8J8z346YbqUI6C+uIfSUEQ1/2Y0b7Ocba6cXbLUE/ax8gAVjj5yZeRVHal8ZI6cCRqAIflB15z4earLZikqpns1pP/UlnJLh1aX0Cqo44VJtjWkQq4H08B2iNCUkqC2jvqPeM1JeV5xFKYF34DwxnyJiqiuqC+rN2Yef1oRATM/wNzO/NFqXqu/SeMPH1GesoGVAsCCYZ16Q36AeGZGt2vDHrUr/AdWCNMRiPfx1db5xwk1/zIFvOQE96D3leFe6op3gvMjdL6ASUAKYJseZvEUP60SvqImKxfpQVbMMdHcGUktbGgJODntPMmty15uoANjohfHdEG87BiS9oNb5R9XqgPJzCkDUJ9bzFDlyukr3zfbdqnCY+ZvXvts3zwVUtQIawe+Es2UM7S6dI7NSRstKw9SB4UcigGg5FMvckxInclgCi1dONEI7DPd9qRfG+TwkrHnIb0kBcpYCrGl+q7K+f3e5NqJCV+4ssyJYmHxD5mSqVvYFsl9my+79QdPc0oyrbj3asVPyYbYmUIAjYNpOzULoT9zpSjV7kjo9aFOGClGBvvMZhp9TEw8prF35viYb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39850400004)(366004)(396003)(346002)(451199015)(38070700005)(86362001)(66476007)(44832011)(66946007)(4744005)(66556008)(7416002)(2906002)(5660300002)(8936002)(122000001)(38100700002)(316002)(76116006)(54906003)(71200400001)(110136005)(53546011)(6506007)(6486002)(478600001)(36756003)(8676002)(66446008)(64756008)(4326008)(41300700001)(186003)(6512007)(26005)(2616005)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm05eFA0cW9MOEVQb2w2SXU3dDd2dTREK1hhZTZJMWRyL3ZJcW1IQXN0d2p4?=
 =?utf-8?B?bzhEYURWVDJCWUQwRUh1dTF4bUVmcDFQVEQ3YXJJalVYNlNzVDBSZDMyR1Q3?=
 =?utf-8?B?dHhEM0s3amRFOUgwdlhXVUVWd2RlV1ZXRHQ4RjlvTE5GZG5EM3NEMXJiYWlo?=
 =?utf-8?B?OTREWDVHR1BqY29PNjBCbUgwZnRDRmxKZmxkZTMzdDBDNmgwVEVRTEpTUmNF?=
 =?utf-8?B?dlplUTJPNGdDMng3WXlaWXVlaklrcTFtTXMrSzZCYXc4b3hpMnNNaG5yNVA5?=
 =?utf-8?B?N3ZzK0RUUHhiUTdDRTYzVGNBSytvWXdPazBPSnVUc1RtUXFocGRjUUZyY2Q4?=
 =?utf-8?B?ak9wakRxL09WdTByeno0U1VSNnNwUnloT3JlUHF1SWlEMloxUDZDenhRSDJm?=
 =?utf-8?B?NDdDd2Y4NCszQXJiWlRiREd0N2FKUXpzTFZBQnIyMitGYXVoNnJrY1J2eG1h?=
 =?utf-8?B?eEYyVXQybzBMaEdWa1cvRlpoU0tZeVUxdVc3WDRiMm1wRUd1clUyeHJURTh6?=
 =?utf-8?B?WmpHUlp4ZGtSZ3hvK2NvVkozOXpJOEJwa3JBOThBTFFSQVhYZlc3QURla09q?=
 =?utf-8?B?c05IdWpmMXROR00wU3R5cHJnQVdQcmxKcjBPY2I4UVdmeDE0eHh2R25sZ0hs?=
 =?utf-8?B?eFdVN21HeEErUWZWZkRFKysvME1DSWd2Z3FHTUo4akFid1Q4WDFFWDg1N2RH?=
 =?utf-8?B?L3pFWHh6V2lHdkpvQW80a1BRYjd6UGFQOGhmN0VwaGd1aGlnMDlHNTZrbWJU?=
 =?utf-8?B?aFpKMy92bXJPL09pZWRsSmFnYW5Rc3FQUDlRZ2RqWVNLTU9EeGh3c0J1Uits?=
 =?utf-8?B?MzVUYTR3Ungyd0UrVFhwL3dwdUFjdERnTWl3V1pEU2M2V3czTk9WQnBOejh6?=
 =?utf-8?B?b0R5b2pCN3ppTVQvd3dOSHNkWkRJbmc1Z3VhanBlWWI5eW1CUmVFNGIyZlNC?=
 =?utf-8?B?NHI0OEYvNHlUOUUwR25idWsva1I4bjVlOUE5VDlneTk0VU5PbWVJemUrTkND?=
 =?utf-8?B?S0NDYXNjcEFSOWVKdWRwbEZJVUJzaElab0cwOUZlak9KSkl1ZURDa2c0MTd6?=
 =?utf-8?B?dFczUlBpOGZyb2RGWkd6MVpTK3JBeWM1by96Uy8rdC9hUWFKdU9uMDlqM0RP?=
 =?utf-8?B?aTRQT0VhTEJGZ25BbXVya1VYWVBiTFdwSzE5d1hURStTU2VULzIzZWdjMlVR?=
 =?utf-8?B?OU92N0xWU1NsT3pnNmVQZHVBRWE0Vy8vN1hHcjVxSDQ0akNzQk0xMGtYcVRw?=
 =?utf-8?B?RGdUZDQ2WFdPbkdBeDc4QWhEQStUeDRMYnRab1d4bGFaNnlrUGZFUXF0UTdH?=
 =?utf-8?B?czJXNFVlbmNId05tQS9TcWxkNHQ1RkxWUEdnOTAvM1kzVE0rOCs5amNwV3Z6?=
 =?utf-8?B?a3hMcFQxZU1VRWUrT2d4Y1dUVGxqMDBMRU50RDVicEZNSHBCTitPcDFTVDk1?=
 =?utf-8?B?VEZvOFN3OW1QdVFGWTNFaXhYUGVobjZVSDViclN2dzZLeGpKV1Awa0ZtN211?=
 =?utf-8?B?ZTBITFRLQ2hxZkJlcVRwK29TWFR2YVBsYW0vakRHRHc3Nkk1YUlsZ0hmNU9V?=
 =?utf-8?B?SlRtbnY4L0YwREJWV2NweUo0ajFqUlBVYkxwVFVmQjN6ampvRVBIT1gxWjRi?=
 =?utf-8?B?ejVLLzFzYlZOQW9tT290UEQ3VEU2NnIyTTNKaGNyM3VqdXRnZUV5dWgwUUdX?=
 =?utf-8?B?eUNaQnc2eFUvNGpyZ3NBNS9aOW5uQjVYTDZWbFdHUVFMZVFzcHNvekp5UmdY?=
 =?utf-8?B?YzdBRGR0MUlaUk1DNnU2dEptQU4zNlpma0NPMFhsZW9CazllU1RENFlJakhU?=
 =?utf-8?B?dGRsTWV0ZUNOSGR6SUFsK2Q3bWtxdDBuODhyVU5wc1B2MTIxWDIvSm0xaEZl?=
 =?utf-8?B?ODl4ZndJSXovcEF1SlFIelJMMmtDVU9SSFVaSXIrTWl4RFVIbFRXais1K1Fs?=
 =?utf-8?B?WnN4cThsbHZwOHNndCtjV0tqemxKS3daRXNGbUI4bUlPb0VOSWMyN3k2aDJP?=
 =?utf-8?B?YlFpNWdxN0ozUU9xWWdudXVhN2wxdWQ1V0t4Q3JvZnh6RklEYWhPZmZWQ3dr?=
 =?utf-8?B?MDR5eG5yYnRpMjZaeXlQcFQ3UFFVN1ZXL3VHaExuZ2ZmKzFGZUJEalpPM0Y4?=
 =?utf-8?B?ajhHRndzdlhIc0dZci9zRGl4VEVaMHpOUDd5eFZ4R0NobTlnRUtiRG5wRTRj?=
 =?utf-8?Q?sHX1HA8Qq3D1BHJjS1F1LJw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 102d2398-2dcc-41ce-43ff-08daf9638c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:51:58.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tnx4MmVM+gWqBgx9G1CkO/xaBNOTbFAb8i6+BTFojLAwUzZRESFzeEMbme0gVZ9uJtOHQsfYGC7Sox6VWBAWCVtc5UgOu5Tw9IXmXIuylu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0063
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <1B98B448B60B404F9DE5D831DCC5DAA4@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE1OjQ0ICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiBP
biAxLzE4LzIzIDE1OjQwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90ZToKPiAKPiBbLi4uXQo+IAo+
ID4gK8KgwqDCoMKgwqDCoMKgbGVkcyB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY29tcGF0aWJsZSA9ICJncGlvLWxlZHMiOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJsX2xlZHNfeWF2aWE+Owo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFNPRElNTSA1MiAqLwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlZC0xIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGFiZWwgPSAiTEQxX1JFRCI7Cj4gCj4g
SSB0aGluayBsYWJlbCBpcyBkZXByZWNhdGVkIGluIAo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9sZWRzL2NvbW1vbi55YW1sIGluIGZhdm9yIG9mIAo+IGZ1bmN0aW9uL2Z1bmN0
aW9uLWVudW1lcmF0b3IvY29sb3IgYmluZGluZ3MuCgpUaGFuayB5b3UhIEkgZGlkIG92ZXJsb29r
IHRoYXQgb25lLiBXaWxsIGxpbmV1cCBhIHYyIGFuZCBzZW5kIGl0IG5leHQKd2Vlay4KClBoaWxp
cHBlCgo+IAo+IFsuLi5dCj4gCgo=

