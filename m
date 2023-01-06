Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A1265FA54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjAFDbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjAFDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:31:24 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C5625DE;
        Thu,  5 Jan 2023 19:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmqzLN2Q9eF8CfenVVpq+w2lNrc649JyrLd8Wvtk5tnugAJS9wkCnxUx9wJmDLA5AIRzyJQOcFX+euK4j+2I5Q+mKKAnv4qJnuUErz+zpYfsHrSBJ7VfiLeANLWWQrGzzrgZyek8tFqgYugh+5i/UuoKRQFsI2uccIulZJkPGOoIB3Ii+U6I9Fp4NqE2IuBTBMjoBG1/Ij0hk5+6RmEdjUC0vln2syYoZ9l8SDNnx0X7egX1q7JVIheoITUzpo7QxYzXLRblxwmGn6s6p99rMnFaz+bpG3xgD4NtK7tlDIxbqNMZ0Tmompoi5HL4BsanvqFASo741TWo2D+qs6MDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAX1f9RG4AZz+iEPdDBzk9gxTzqDnKePLSjHabjfMK0=;
 b=fxW5T7AWK7MM1q9sBNIIx9KR86tUBcAWSedlwS8jq0rZBJpcD/WR5yKu/aMO/esPSwGctL5ORW6OQbHWaRhlPAhnQ/IANMpwCR8XJhd9eGb2zl4u+56FniHKGfAJQEC8m90Db4adhp9V3vXkMvar9v6mrHxafBpK9WrP7r0nATF/zoC7GvjcVJUPVaWDfAz33KpJlwFeWJEa3XsQ5Zjr1QUxSM2L7v+XWGJGOMgZ6YR0V196zBTSb0LM9JuNBavYNJKb2QrZkrd3/LSFUZPEYxuPGZ+clrIgx32BXXGtBv58Etsds9qL1I9HLfseU/4gtnQU5Q5yO4nCvhx4NO88mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAX1f9RG4AZz+iEPdDBzk9gxTzqDnKePLSjHabjfMK0=;
 b=dZPpKN96J+Kyg4vL5mM/9IIuE7JK/7yMHrIUzeZWObCZu5PT2U2FjxLfzUAB8cjWAeksgbcUMMCks4HjF8EWoyPnBn2exKDGkOyyz7+32zmgH+wa4I0DT86BVga+TfcY6WzKn7sXM/ebpeidPv2bOn26iticTZlEKQ2YCk0Dr95AREypFV3R7WCTshnTqtCAA0mOpQYwpSFpP3VAsdp/74O41XdG1gkZsJEvGFvDeurudTLJg95LzbolKu7kBdDP7+a9KKEWbbKSv2msys+LwZrRh5DxgW9tMdVFwrGtB55FW/0mUMTPBvGfyipsTmMFTnOrFQAUCxQvlGKgruXDKA==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 KL1PR0601MB4340.apcprd06.prod.outlook.com (2603:1096:820:65::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:31:16 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::b56:707c:e7a1:2e90]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::b56:707c:e7a1:2e90%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:31:15 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Thread-Topic: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Thread-Index: AQHY/wMOXeMHCeVuUE6+Ya/NPsQ1eK5MLAIAgAAAwoCAGSzTAP//7ZCAgCw/loA=
Date:   Fri, 6 Jan 2023 03:31:15 +0000
Message-ID: <24DD1FEB-95F3-47BE-BE61-8B0E6FBDE20F@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
 <A5EA19E5-21D8-4954-9636-9B28AC8D946A@aspeedtech.com>
 <41500a04-b004-0e2c-20a1-3a3092b90e6d@linaro.org>
In-Reply-To: <41500a04-b004-0e2c-20a1-3a3092b90e6d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.68.22121100
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|KL1PR0601MB4340:EE_
x-ms-office365-filtering-correlation-id: 005076d3-fe05-4f53-c420-08daef9677b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQIfF7Rcnf8yM6S/+LKdSkzsBNJXwURIoKLlGuZXGhyzdmBthvtQdX1TGuTm9TXlvg1n2Xet+IdRhKnDsvtBUqUDUeDOwHbkD2lM4w7AMPxClckbKaaldbfvaq8pqHimkxtNTdk1rT3MeTrtg/9Ver2xsRPRW4iJlt/9Ope8bAmBO3VYee6skv2mmBaSQ3UyLWVILwiyzawbvuqYHht5VSONuo+0VEe1j4b+ouPc1PW5cgTmC6LyTL/gHOlZzPAwHWUHbO0qlTDN1z/l8HCT7v0AxqXbLnJCeVOQprl+gT3HuzFqBWQ3rjP3/IP/TuAMljyNeizOY0zT7NDGyfdArGchklPqwCZbkRt8i19JgAjpzmKIRLE3ByMzD7TG+vq8WwjVXxEU4wKiS/t+UcV/qeADfQ1wRPC2Iv8x1oeIb4c+mqhevDWEuxgah/zVlIIzYbCJSzbSreJcpM7G2p+n3sQZdZjru2ytD8FuziubCwCAfDXqMixTAl5VpXEVCIBEBzQIAZ6B3GfKKD1NcU0MFRObtKYBnutHS51XVBE8q7sgWRwP99JcX2a9aDA/ld7d5t8DLQ3gYoeNdsvESUZmgVD08HJ+kG6LtY2Vv2eSKjTdW2gDwljf9cMGy+xqUDKZbxrRIqxLnH14nyPslW0vMjqSHJzzRknt54/mdkX2MxCeOgYvBDlCNk6B/etan4F7fjTIeqGbm0is6+GQeRNYJy4xlYNQ0KZQDx1/RUUWcuk8oLPQ4QdkpIZKzRgIb/wH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39850400004)(396003)(451199015)(186003)(6506007)(6512007)(33656002)(36756003)(38070700005)(86362001)(921005)(122000001)(53546011)(2616005)(38100700002)(26005)(8676002)(8936002)(7416002)(41300700001)(5660300002)(2906002)(76116006)(6486002)(71200400001)(478600001)(316002)(66446008)(66476007)(110136005)(91956017)(66556008)(64756008)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm9PdW5EMDlUNDlsNVNuc1BaZjZWM0JFWFRPcFpFK2NQNG9LSFVaR21Pc1My?=
 =?utf-8?B?TzRQUFgyUHhRQkVEMm1GQUhodzlWRWxJZzhPMmpuVUhtY3lCOFNMSHpsRnJP?=
 =?utf-8?B?QVBCTkdjTWx6WkRyTG5FNzJlQ0VhZTZ5VGplZnp0K1c0Q1VPd1lYU3d5UkZw?=
 =?utf-8?B?anUvNUZJZ1pBakU4cWM1R0VHaVBwWUIvU3hKdTZlMWtDTkFpL1hjUUdFTDA2?=
 =?utf-8?B?TW5BTXdiK1NJbVczZ3F4THFwZUVHa2ljcEJBYm5KOEphbHpUZVR0enlPb1Rq?=
 =?utf-8?B?aG1Xd3h3a1dRK0RlclNLMGNhYkh0dUpKazZlRmVaQzdOZStWR3RaR3BhdXN4?=
 =?utf-8?B?QzV0TkdvbjRIcGU0cVJxNXk5V1o4Qis3NWNVeGJSNGpjVEhlSWkyRFI5WFJU?=
 =?utf-8?B?ZVJ2THgwQ2hRVndMRzJjTExFdVY2VkF5bnkvN25aVWpWeFdVTWp5akxKYlpl?=
 =?utf-8?B?YjlpbFFLaVdqZ2JRNm0yOVlra1AzTm9WSzRzaEM4ajQ1ZGZJeUVBb3AvbGRv?=
 =?utf-8?B?MzQrbGRNUjNycGVjRmNvZmJmZHlrUldtWXRqdHVCK0hnNys3TGNJSUxkdHgy?=
 =?utf-8?B?dEtRYlNRWWdacDlCRzFRcXhRdjNyUGNRYWRiQmk3N21jNTNKRjVDbjFuYWdW?=
 =?utf-8?B?UTFTZmlGNU12RzlYdzhhSFFCeUtVWmdaZkFwRHR1YXJjamRLdS9rdWoxTnUz?=
 =?utf-8?B?OUdiRi9wa3M1bFpPUTFwZUZGZXRZQlFBVjEyYWpZdTd4K0JpWjd0bWZUVHF5?=
 =?utf-8?B?dGZaeHp3WVRuQlFKeVY3RFF6Qk93T2dtQjZBaW53NU94WmFwb250bkNuNUNT?=
 =?utf-8?B?ZzA0SmhmREhCWWNueHdqUDhVYmpKdmtvc2p2UTZDTXlTcFlLU2N0WlIvNXdt?=
 =?utf-8?B?WkNLUVZQN2NpMmViaXNwY1B5MmsyREQrbEZ4Rjc4ellWbDFWRlR6enE4R1VJ?=
 =?utf-8?B?bWtsRFZ1MFdjKzNETHZMSXYxZzFITUx0bllGd3lBVWw3Qmtsdmh6MmdyQzR0?=
 =?utf-8?B?Z3RvazBrN1UrOHpEbmE4Qkw0VDhkZkhrcTU2eXI3Q1o2TE5JM3NFbzI4a1R6?=
 =?utf-8?B?Mm5BSndUVDhZclo0MWRIRm9Xd3RiTi9YNGpWRmRDL0J0M3ZjNU1BUkJEWk44?=
 =?utf-8?B?UmVOVzUwU2ZGT0NFcFVrMHRUdm55Tzl2alFQc0paYnl1QUlpQXFUNU9jY3My?=
 =?utf-8?B?V1plMUpWSUZ2eTRQdFUrYTJWUVRMRVUzaWlaeXRFaE9TMkJtRndmMUlhdzlD?=
 =?utf-8?B?VllmRTBNSDdETzMrNzR3TjNuMnlXU0hna2ttQUpZcER1ckZmMFV0aVZzYkxZ?=
 =?utf-8?B?bnRTbDZWZnV2cjZyQmFBcFlXQlI5RUZzdVI5cVdNSzA5MkRqWFVDaGFJb2tq?=
 =?utf-8?B?WkRGSW9JQTNNMFFHQlJRelhXbUlvMDdmNGNjMU9MQ2doRkJmRHMwc3NySnRo?=
 =?utf-8?B?OTcxa01HOW1BcFhEaDBja2JUVzljN3pwajhaajh2VW9zK2x2d1JaUHdjMlhE?=
 =?utf-8?B?TEkrT0drYnhsOXNBSlh6TFVzTjlqT2pUN2hqbDRGYTJTQ0IvaVZ2NTJHb1hk?=
 =?utf-8?B?dGtZTEs3SWNNM0VUZ01laStYalVkYnNJd2hxeWgyc0ptZnI2akJHYS8yRFRY?=
 =?utf-8?B?VGJVRytFcUgxaFY4VGtuaTM1OGhIOXJsUXlXYk1sdVJNNS9scmpFbDMyL0pN?=
 =?utf-8?B?c0czUUVlVGZUck9NMXhOVXNrR0NBWkUvM0lLM0NHSlRlZHRHZ2lyQ0l5NzJC?=
 =?utf-8?B?QjZqMnFkcmFFZzYrcCtJV0FOWThKaFhlQjQyT3ErRlJHWm5pR3ZENzYwQ3dB?=
 =?utf-8?B?bGFySkZzYjRiL0ZYenZFTXYrU0lQSlh3N1ZOSXdlYk1WQUc3eDNSTGdaMTRr?=
 =?utf-8?B?d2gvcFFKODRlZWk0NTJoZTJPQU5EL3lCckMwdFNVT3NXOHA0VzRpQ3dmcnJ1?=
 =?utf-8?B?ZTFUWmMzaUxiSHRXR29xMnp5N3BRRUpleGE1T3RnNVBwWVdpcmNRb2h0a3NW?=
 =?utf-8?B?bk1nSGpaY0p5SEtwZXpkWmF3c2x3SCs0dWQ2UXhMRkV0RjN1S21NVU9hL2Nl?=
 =?utf-8?B?STkraEJIV3dTbnZHT0I2YjdlYTY2YnJRTks2M3I0Q1lXNUdIbm5UTU9rRTJz?=
 =?utf-8?B?SDlBSEJFL0ZsN1RpRC9uSWxGcUtRMG5SaEQxb2REVDRCQVBxSVdlVUxGaTZL?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <058BFD069D058044B6E58AD33D7DF67B@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005076d3-fe05-4f53-c420-08daef9677b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 03:31:15.8396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0DeTS61od8zMYYLlUePMDO0JeKCVvKQiiwTBigwbJ/0+heJLZqsuSQ5sfXMS/rZv3Ntkqo95DZAGCdcFtUeIQ6CauTb4OByWdLVYMHhGHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMi85LCAzOjQ4IFBNLCAiS3J6eXN6dG9mIEtvemxvd3NraSIgPGtyenlzenRvZi5r
b3psb3dza2lAbGluYXJvLm9yZyA8bWFpbHRvOmtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4+IHdyb3RlOg0KDQoNCiAgT24gMDkvMTIvMjAyMiAwMTo1NCwgQmlsbHkgVHNhaSB3cm90ZToN
CiAgPiA+ID4gPiBIb3dldmVyIEkgYW0gc3VycHJpc2VkIHRvIHNlZSBzdWNoIGNoYW5nZSwgc28g
SSBoYXZlIG5vIGNsdWUgd2h5IHRoaXMNCiAgPiA+ID4gPiB3YXMgZG9uZS4NCiAgPiA+IA0KICA+
ID4gPiBBY3R1YWxseSBub3cgSSBzZWUgaXQgd2FzIGxpa2UgdGhhdCBpbiBwcmV2aW91cyBwYXRj
aCwgSSBqdXN0IG1pc3NlZCBpdA0KICA+ID4gPiBkdXJpbmcgcHJldmlvdXMgcmV2aWV3LiBBbnl3
YXkgdGhpcyBtdXN0IGJlIGZpeGVkLg0KICA+ID4gDQogID4gPiBJIGhhdmUgdHdvIG1vZHVsZSAo
UFdNIGFuZCBUQUNIKSBidXQgc2hhcmUgd2l0aCB0aGUgc2FtZSBiYXNlIGFkZHJlc3MsDQogID4g
PiBUaGUgUFdNIHdpbGwgdXNlIHRoZSBvZmZzZXQgKE4qMHgxMCkgKyAweDAgYW5kIDB4MDQuDQog
ID4gPiBUaGUgVEFDSCB3aWxsIHVzZSB0aGUgb2Zmc2V0IChOKjB4MTApICsgMHg4IGFuZCAweDBj
Lg0KICA+ID4gVGhlIHJhbmdlIG9mIHRoZSBOIGlzIDB+MTUuDQogID4gPiBDYW4geW91IGdpdmUg
bWUgc29tZSBhZHZpY2UgdG8gZml4IHRoaXMgcHJvYmxlbSB3aXRob3V0IHVzaW5nIHNpbXBsZS1t
ZmQ/DQoNCg0KICA+IFVzZSByZWd1bGFyIGRyaXZlciB3aGljaCBwb3B1bGF0ZXMgY2hpbGRyZW4u
DQoNCkkgdGhpbmsgdGhhdCBteSBzY2VuYXJpbyBtZWV0cyB0aGUgZGVmaW5pdGlvbiBpbiBtZmQu
dHh0OiANCi0gQSByYW5nZSBvZiBtZW1vcnkgcmVnaXN0ZXJzIGNvbnRhaW5pbmcgIm1pc2NlbGxh
bmVvdXMgc3lzdGVtIHJlZ2lzdGVycyIgYWxzbw0KICBrbm93biBhcyBhIHN5c3RlbSBjb250cm9s
bGVyICJzeXNjb24iIG9yIGFueSBvdGhlciBtZW1vcnkgcmFuZ2UgY29udGFpbmluZyBhDQogIG1p
eCBvZiB1bnJlbGF0ZWQgaGFyZHdhcmUgZGV2aWNlcy4NCkNhbiB5b3UgdGVsbCBtZSB0aGUgY29u
c2lkZXJhdGlvbnMgZm9yIG5vdCB1c2luZyBzaW1wbGUtbWZkPw0KDQpUaGFua3MNCg0KQmVzdCBS
ZWdhcmRzLCANCkJpbGx5IFRzYWkNCg0KDQoNCg==
