Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16A9671FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjAROnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjAROmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:42:38 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F93BDBF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:33:48 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2042.outbound.protection.outlook.com [104.47.22.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-3dBPHOHBP7S63SMvZTn_6g-1; Wed, 18 Jan 2023 15:33:38 +0100
X-MC-Unique: 3dBPHOHBP7S63SMvZTn_6g-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Wed, 18 Jan 2023 14:33:36 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 14:33:36 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 12/17] arm64: dts: freescale: apalis-imx8: analogue
 audio comment
Thread-Topic: [PATCH v4 12/17] arm64: dts: freescale: apalis-imx8: analogue
 audio comment
Thread-Index: AQHZKw5qQJ/g9dTifkSsMy4BjnXU1q6kNBSAgAAJgQA=
Date:   Wed, 18 Jan 2023 14:33:36 +0000
Message-ID: <da7cf752c820e1c2cda5de4865c33d1b1e7247cf.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-13-marcel@ziswiler.com>
         <de1da42c-2fed-4c89-4cbe-be764b2859de@linaro.org>
In-Reply-To: <de1da42c-2fed-4c89-4cbe-be764b2859de@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0144:EE_
x-ms-office365-filtering-correlation-id: 96e81de6-74e0-45d3-a682-08daf960fc17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: XfrSKC/JBOMphzyLT84TbR24tOvmtoyZRI8yRRLutpfEi4v1rsFjk4EsD8WvPq3GMmV3r9J2Ak0njblTEjkue5aqUYTT08ZWHTsZU1ytVDTYa20AzIITeWn4TOsqn9cy8+HFoyRcBdVU/ACaSSRlxqikyWwa6fRWmVFtkAOuKSEGLPAJs7ZhYP27VrrKRQe52CtIv95feU22BJMqAcBG0uP1B1wYf8ueE+lMUwYYux6TWRe/smSXFawF0RHRgD6oJ3rH9Y8wOtKAClgJRrRcxe5zhN7MMwaAk/a2rUICV44G12YxTo17vrb5ACcwOZy0/cgONn2yFrxQS192QrTauCO1h7ykX0GO1DSX/lMOGUP5Tvc3VKJdCNmpM08su/Ph3kECnBECeO0BaNwyCFUeTKGff7+v0aFA18DbIS0tSBwNvmrhBpQmWN3+NHjQIt86e155alr5bsKfSbojRKFEMM2wQ8whs9TAsY93TBSDpZs7o82Q+YeetWYuS550Ka5GaLNxtKW2rUTyzHftszVdAvyVR0qlEZRrV+COdELLouox/AgZcrevz4xUobaHrqnuHq2xNLn75KUJ9nDn33FCFXiTSCvHH6OzrCp6G7u+cFm9b1rBKclTeQQ87hDCiHzty0/+mWmjZ9poxxqCqFkoEeY3bANyu3jAsUGcfWHQa2l2zuwSpMtNPuY/0ODAGj0LSgoBRrk5RhIl4jByVxbwVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(346002)(396003)(376002)(366004)(451199015)(38100700002)(122000001)(5660300002)(86362001)(38070700005)(4744005)(7416002)(76116006)(4326008)(66446008)(8676002)(8936002)(64756008)(44832011)(66556008)(66476007)(66946007)(2616005)(478600001)(26005)(53546011)(186003)(6506007)(6512007)(2906002)(316002)(54906003)(6486002)(110136005)(71200400001)(41300700001)(36756003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Kzk5L3ZITmVSL0ZKNGoxNHp2YUVERlUzeEQ3ODdmbFVqYXVXUlFiR3JNSG5E?=
 =?utf-8?B?ZVM3dnhSc2lkNEEzMjl0akZLbCtkT2RQRHlSWUJqMmVXZUswaWZIQTlLTU1n?=
 =?utf-8?B?NFphNTdOWDRTdUo4T2lhR3Z4RXl2bzlQOFZFQ25hNENCNGVxUzhqbXl0MFA2?=
 =?utf-8?B?Tm00V05VRzBDZkthSytBak1qODhiT0tJUlJrdkhPTHF2RVRFckljWFF5bUxT?=
 =?utf-8?B?ZlppaFoyVGhEUjRvVlBHcFVXalVMWkI3Wk5ZcG1NUjQyV3JOTGhyYXQxNWpj?=
 =?utf-8?B?T1dYR3ZFbG9OMXNRSkFVUHlRZjdIeEhTUzF6NUtCNklEbVFtVDJKenBzb2RW?=
 =?utf-8?B?SUVnUGdzTG85a2NnL1lCQ09KUldaWGxVK21DVWxaTEJBaStnY0FQR3gwNU43?=
 =?utf-8?B?cGxuWEtmbGNIYTVmUVUzamJRUENXVnZYblZwaTNmNElkWEgrZmRnRmpZQkVz?=
 =?utf-8?B?akxrM2FjUldNd0lSeHQrRk9PT01YMndVM0tFOVpvMHhuUFlkRE1DRW9rcHIx?=
 =?utf-8?B?WmhoZG9ESER0MmpBOExhcmQrR2l3eWZDRlZYV1JVTm50L0E0cTFxczhOWm9D?=
 =?utf-8?B?VTEzaGNUdWhQYjFneHl1RERJMHdBeXZ3MzdwaXVYcDg0cGhJZHQwaGcyTllJ?=
 =?utf-8?B?YVJldnNBUEV2TmN6UmR1K3BnYkpyY1dFS1dnaUFxWU56WWFJK3dGb08wTGRY?=
 =?utf-8?B?WlgyUXpUTkFFc28wTm9KdGxaaU00eG5HSWU1eWRLQTVQaGZnMTdMQUY2Yy94?=
 =?utf-8?B?RzJYMVZHRi9aQWJZM2dYeUNTZUpVNVdRc3Ztdi9YY0lyS1F1QXhBNUVWMzVR?=
 =?utf-8?B?dkJJTjhnVTRZYlVja1ZMd0lUbG5PSlZkODJabE5WK3plRHB6dHp3ai9qUVBa?=
 =?utf-8?B?SWVMZHlWT2xNVFRWb3VPdDVyNUYwWTBqNFgyVDZLSklSTVBQZU4vUU9UQzJY?=
 =?utf-8?B?aC9kRTVvSmFtWVQrU0xRbVVFVDZBN1RhUGhQK05namtUanUzUUkvSHNhT0o3?=
 =?utf-8?B?QXF6eE1RaW4yVlUyeU03WG5vRjhSWkhycVQ2SUJqbDJUbDVGZG95M1BvcWhY?=
 =?utf-8?B?azNtbjZOaW16MjE0TDZJdzEyemZyUkJqR3kyVlA4Z1c5NjhZUEQ3MlNZbHg1?=
 =?utf-8?B?SXU5c0M1dnp0RC9pRzZuN0Q3Z3pQK09yV0RCY0h2Sk1vT0hXK2pmZXQ4TXV6?=
 =?utf-8?B?di91QWxKK0s3K2VORWdBb3FmcEdOcVRiU2tYV0c4TXZUOGtKWjFBTDgrWUND?=
 =?utf-8?B?ZHpTNklJb3BVcFEzOWdwL2JtZURuc1ZGRktGNlUrWGowUUM5QUs0YVlBcmZS?=
 =?utf-8?B?VDRsbld2UmVKOXFxYkxCcFEzMjV6RXlra3J1MGJWTHpvMXRnUExIYmRHeXRt?=
 =?utf-8?B?R09YdDVGM3NpTDhLaTgrcmE5QlpvaGtTa241SDZKVStjTkdHUThXS3pSQ3I2?=
 =?utf-8?B?bDBoYlJSblo0SXBpTEEwOUpXTm91Sy9jbHp4V0YwTHJNYnlPMFpmek9DTVZv?=
 =?utf-8?B?UkZSMTI2K2VQZmRkbkJFK2thYTRIc0QyYmJIWmczeW8zSDl5S0lpcU96OWVY?=
 =?utf-8?B?QldMNDV2UDhvR3ZRSWRFVEozb3V5bGg1OGQ4UXZmSEpKaTVZeGFtbngvL3p1?=
 =?utf-8?B?R21MMXJ2ZWJaUzhYbmFsRzVucUlubyt4eEZ5UUt5Y2xKeHIzc0tSNmFCaUhJ?=
 =?utf-8?B?TmNNRDdTRXQ4aHl0elpCR2daNHdOYk1DVE1uQy9Gc29kWUdRRnErN0Fka0sr?=
 =?utf-8?B?Zzl2VnNnVk54cHFweXhkWkVBNGNVK1FLMTJlV3dyd05PZGZCM2xzSURxekJW?=
 =?utf-8?B?NlJjTDJjbS9OSHl5bjlVc0ZkODFUbHIwVjBUNUFIVUUzRlpPN0xYOGk5UVo0?=
 =?utf-8?B?Wk9xOCtKVU5IMGhHaTBnT1ZnNG5md3gvNXpFNEl6ZlFxamVWMWM4VlUzYlh6?=
 =?utf-8?B?ZWFDS3RMc2UrU2RGTWZORVd2bmtlT0JGVk1ZS0VSSGgxMVVBWDMxV1RndXJS?=
 =?utf-8?B?bk5OTk5YU2tJam5GN0tzd2lKaXpZUWNhOG5VSjN0MjJIdTNGM0NFNDQwRFlO?=
 =?utf-8?B?ZHJKeGVaOUhFS1hRc0kvaVZrMml1Y2kxbENqN0hHeWU5SkdDUmpJMUo0bHk3?=
 =?utf-8?B?cGtLMkIrVVMvbkwzR3UyaGpDek84L1l1UVg2TTYvcmpoTXhZREtycnM2djhE?=
 =?utf-8?Q?UpuTJ6363Qe7bBK8TfluH/c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e81de6-74e0-45d3-a682-08daf960fc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:33:36.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qAM+lMbItIfty/vJ7e/Hwfandhe/c+pJeGDui4u3ovYelITGqXW7UUgA0+d47UqE6W4cxqqXYyGFP0BJghcPpuKIYVsn828NAx4Q22kdYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0144
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <1EBBF8CC0F28774CA3DBC0A7A98AC5A7@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE0OjU5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxOC8wMS8yMDIzIDA4OjI2LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gQWRkZWQgYSBjb21tZW50IGFib3V0IEFwYWxpcyBhbmFsb2d1ZSBhdWRpbyBiZWluZyBh
bm90aGVyIHRvZG8uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxt
YXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+IA0KPiBZb3UganVzdCBhZGRlZCB0aGlzIGZp
bGUgaW4gcHJldmlvdXMgcGF0Y2guIFRoaXMgc2hvdWxkIGJlIHNxdWFzaGVkDQo+IGluc3RlYWQg
b2Ygc3BsaXR0aW5nIG9uZSBsb2dpY2FsIGNoYW5nZSAoYWRkaW5nIG5ldyBoYXJkd2FyZSkgaW50
bw0KPiBtdWx0aXBsZSBpbmRlcGVuZGVudCBwYXRjaGVzLg0KDQpSZW1lbWJlciwgSSBleHBsaWNp
dGx5IGRpZCB0aGF0IGZvciByZXZpZXcgcHVycG9zZSBhbmQgZXZlbiBtZW50aW9uZWQgdGhpcyBp
biB0aGUgY292ZXIgbGV0dGVyLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

