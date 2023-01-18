Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A16C672025
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjAROuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjAROuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:50:03 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B523A9F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:42:40 -0800 (PST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2108.outbound.protection.outlook.com [104.47.22.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-qVRdP_D8M6ek7Tx06ctdTg-1; Wed, 18 Jan 2023 15:42:38 +0100
X-MC-Unique: qVRdP_D8M6ek7Tx06ctdTg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0102.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:23::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 18 Jan 2023 14:42:36 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 14:42:36 +0000
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
Subject: Re: [PATCH v4 16/17] arm64: dts: freescale: apalis-imx8: fix
 reserved-memory node names
Thread-Topic: [PATCH v4 16/17] arm64: dts: freescale: apalis-imx8: fix
 reserved-memory node names
Thread-Index: AQHZKw5yH9xn+DGG2UG2ziZCJz4LSq6kNM6AgAAJiYCAAABUgIAAAWyA
Date:   Wed, 18 Jan 2023 14:42:36 +0000
Message-ID: <66cb1441d016551255e0ee2447c1886cb3bf76c9.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-17-marcel@ziswiler.com>
         <b5a60852-f8f5-f3c4-fb75-bb5f00823c82@linaro.org>
         <1d4dc13ce1ffae4885bceb439d5d259f3567e6c4.camel@toradex.com>
         <83939b6b-0188-9cb7-c4fc-624f13437a48@linaro.org>
In-Reply-To: <83939b6b-0188-9cb7-c4fc-624f13437a48@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0102:EE_
x-ms-office365-filtering-correlation-id: 5a4c391c-8bff-4665-9f1a-08daf9623dd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: adM/cn0Ek45y6owOzYa9UlEzwCQT8E6OccNsprAeMAg6Fog6LCY5vxplYienKthGaWi6wxjLocPOmr+bFngdphPYVNkfbaMBWDGqcE2Ny/zGft4gIMLIoPcLe1tI+hlh18DSubtTDPHjGBM0wBukA6HqQjNJM8TtSRGEwXvJto92br1pOplP5Xb8DaC5W1LQEMXGUHyXvnmYvW0qRwYbDFGPonY8+N8c2SFjfLfeYhWnzGTjKPz7YnVX6iJVAjB/w6+dhblnetH5tnwZOhDT1cm+Jm0MoBcUX0MjvmQXhQechM1l/sT/m2K2VWnCjOJlsZxFlDHT43Y+gYOqtyZ4oW9738aP1K62rw6UsEwiY1BDpySewfyJp4DsvlCAMAUXmNYjKEHbCvDT8lVrnXfvImzLKFUIQ6LO4hsxfPQhSIv/q2T5RAPh3TWqySvkC9ktK2nP1srMqsCikcXXkRHnE2o9kDzKNpbIWn2mSa7aEOg942aHjH9dKxOEokAd6oMM3hYbxFUqs8wv7Joaqw+4T18tyf66G7Pdg2GV/J8T352j7T+kl+YjIv9TfWDx1+o5mCTVMcC7O9Rfu8lngH1qY85Mv6Fvj1YwNuAyK8i6i8u8y58d5E5C4IVzxWxsw5+eG1JOhQFnw6+TcwD8HiCfvqrJM8obGp+4vKCZ1CyAlOxGtlOf7ILh86pCd/W6j49CaonfjkwIgvvT2KIXG4KINQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(451199015)(26005)(6486002)(38100700002)(76116006)(478600001)(71200400001)(316002)(110136005)(6512007)(41300700001)(4326008)(8676002)(83380400001)(66476007)(66556008)(66946007)(66446008)(64756008)(6506007)(186003)(2906002)(44832011)(54906003)(2616005)(5660300002)(8936002)(7416002)(53546011)(38070700005)(122000001)(36756003)(86362001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnhGbVJYVm9jZDRyVkZWN0NrWE1EKzJicDVySC9yYVhQZEVhclFXdktPcnN1?=
 =?utf-8?B?aXhYbERmUXpld04vSU5iTXlRT3JJb0J4QjVmcE9TV1JzNDhqVVdpL0R0QkFu?=
 =?utf-8?B?OGpneUN4bUJaV2VLV3FHTE4zUUNvOU5wS1hnam9tRlN2ZDNaUW9kTzAweUVm?=
 =?utf-8?B?enIwbmdYc2JvTHMzZExHV0liS0hEOEtNYXNOTDdFZkp5UDByL2xtYWg1Z3Rw?=
 =?utf-8?B?cDA0QzIvelVWaWk0Z2FTL3RzM05BYU9DSFk5WTA0dGRpWEZlMW4xQlBHbFJD?=
 =?utf-8?B?M1JnZ21DekZyRFJncEFMVWVIMkZVMUFqVWUvYzVmNHZjSkRVSlFvcVVNTGV3?=
 =?utf-8?B?TjlsV0p4T0RPYWp6TnVMWTRZa2VSNHpvMmVSdFNnaDNORDNlS3hYcEVqQmh0?=
 =?utf-8?B?b0VGbUExLzNNY2ZySk5PeCs4MC9vODlMTURQcEtwa3hkN2NlVEJ1Yk9TRklR?=
 =?utf-8?B?dms1Z0d6T0QxS0svOGVSOEJQakg4aWxzUVdMaU9aYVhXTmVrSnU1VFhRNmFE?=
 =?utf-8?B?eDFkckx6dEJQaE9wUUNqMFQ1eTI3Nzh4RllvNHR6YUFMaHdQOHk3eThKTElH?=
 =?utf-8?B?NVJxZ0V3RkMwd2djTWJqME1CZ1FlaFJ2am4vWERXREZtOWExcFRiODJocWlK?=
 =?utf-8?B?dXJPSjFEUE9OQXZaUDJMZkNEcjRWS2JURUtlNEx4SDEzbStlSG5CWGZHNVR0?=
 =?utf-8?B?ODA0R2xiUDJMMjRqS1JGT1BTOVJEZG1USGd4WXcza1ZZN09zcmNwNkg4MDc2?=
 =?utf-8?B?QW5TNWRwYWdNTU5vMVVRRjQvWWVjb2VGM2d5eUZXN1JzUWNyS29IOGZHWVBs?=
 =?utf-8?B?d0dWaHpHNTZLT2lmSjBIZ2VwbSs0OUdQamh5NEZsazEwRnpuQzlMVlRBMU9E?=
 =?utf-8?B?cjRQM0JaUlhobk1kQmRLYWp0NXltelhJSTlNUC8wZGVoL3NqZU5YcW5RaFdQ?=
 =?utf-8?B?NkpCTWFoV3pEbjNKUXFvaFpqSitsc3ZPaW45dmNJTUtPcllOUlAzM1ZHTE1l?=
 =?utf-8?B?ZFJlUFJtN0pncUd5amQwVlMzcnl2L3hIU3B2a3NQcDlzQ0g3U3ZXOUFjTG5t?=
 =?utf-8?B?aGUvQUgyZVNtOXRNc1FoYmRhZExhL1dGRGxaOHA5SGJqYVNzUmwwdGhQMjYx?=
 =?utf-8?B?UUFRV0hxb2RtSFlWTVg3YzFnMXhteHFTZ3U2RVluZGVSVG9QTC9KdnNWbWNL?=
 =?utf-8?B?SldEZ3YxckFzR3lqanExdm4vVmdpRzkrQ1BQLzd3ZnAwODFJZnhBMkVJTEtD?=
 =?utf-8?B?Uk5zaWRNNUQ0UzJWRi9YczBhUThOWG1aUmRqUjM2UDVHTXM4UDNTZzZSLy9w?=
 =?utf-8?B?NDY5QkpOOWhDdnRrZ0pLSXhjeU5HMk8zYjJhdWJ1NlJrZHBxZUw1OXgyOE12?=
 =?utf-8?B?cVlCbE41NmVreEFMK011aFdFRVdrK1Q2andhaGhoYkExdzhwa1F2YldPSlNl?=
 =?utf-8?B?b2FuMk1PZU1Idk03djhlcTVGdzZNSjZXTW0rOUZ3YXpRclZJVElTSlNSUnlu?=
 =?utf-8?B?NUpaeVZsV05ZWjJBVDdMMjJsQnFBU2RtNGF6ZkdSdXU2Yk5tQS9KaFZaTW5m?=
 =?utf-8?B?QnNYc3B5NlEyUnZIZEVld014QzV6R1JSZnFNVlpOS1NhYjkrVEJVb2RqSnhv?=
 =?utf-8?B?bkVQWUhPSnF1ZTMvcGNzVXBIODJpYWVWVzBoajNINGdZQlAxWlJ2c1g5aHhE?=
 =?utf-8?B?ZTVwSHhmTDJjcjdWRzdKTUZSbEd4NHhQZ29BbWlRMkw2SzRZaFNVZnhGMEd4?=
 =?utf-8?B?RGw4WjE4a2Yxb3JId0NLTEk5bU5aSFhOaW1XKzFpa1Nob0h0TDQrKzFXckpo?=
 =?utf-8?B?RmdpdW1PQmhvN2ZUTnBGcXdmTGh3b01zL2RyandHZkpnWHJjRHcwVHNwcjZD?=
 =?utf-8?B?aGsyOHUyeHErNjE4ZDJkVDVVS2RSbGxqRUNUaktFRy9TelRoUG9xd0h1R0Rm?=
 =?utf-8?B?bHJTMWFoaDB6cFRVeEUwcUs3RFNWeHhPM1FKa1ZLME5OMlUzUlVxRC9NcW9I?=
 =?utf-8?B?ditKWVZQV24vUHMrSzFRaTRac2E3dUdmYmdiS0lzY05FbFpNQ2dxeW0rSXg2?=
 =?utf-8?B?RWFJS2JIT21pZnhmeithTFdGWlJrYWNlbUtlaXlGMHByblBxNkNWTm5pTXF6?=
 =?utf-8?B?VEllMFNKTFFnZFQ1aUNiN2QyQXdsbUdPY25CSFU4endBL0VvMHk4VjlKeFFB?=
 =?utf-8?Q?YgsQJHE4hP0VO3cnLilXnjI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4c391c-8bff-4665-9f1a-08daf9623dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:42:36.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCPtnJXd9FqJl6IN49wo54uBfooppTOMqgxFpKTc7IT8gfMfTLTvv/mjUhXc0PgbStsyC6v5lNdbC6UW60vUrENFtrHq3DE3vMu4TSegfeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0102
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <EAC4D8FC58107B4493B2EB2F29BC5F9B@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE1OjM3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxOC8wMS8yMDIzIDE1OjM2LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE1OjAyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiA+ID4gT24gMTgvMDEvMjAyMyAwODoyNiwgTWFyY2VsIFppc3dpbGVyIHdyb3RlOg0K
PiA+ID4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNv
bT4NCj4gPiA+ID4gDQo+ID4gPiA+IEZpeCByZXNlcnZlZC1tZW1vcnkgbm9kZSBuYW1lcyB1c2lu
ZyBkYXNoZXMgcmF0aGVyIHRoYW4gdW5kZXJzY29yZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4N
Cj4gPiA+ID4gDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiANCj4gPiA+ID4gQ2hhbmdlcyBpbiB2NDoN
Cj4gPiA+ID4gLSBOZXcgcGF0Y2ggZml4aW5nIHJlc2VydmVkLW1lbW9yeSBub2RlIG5hbWVzLg0K
PiA+ID4gPiANCj4gPiA+ID4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFw
YWxpcy12MS4xLmR0c2kgfCAxMiArKysrKystLS0tLS0NCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtYXBhbGlzLXYxLjEu
ZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtDQo+ID4gPiA+IGFwYWxp
cy12MS4xLmR0c2kNCj4gPiA+ID4gaW5kZXggNzBjMDBiOTJjYjA1Li42MjE3ZTBhNDhmOTYgMTAw
NjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtYXBh
bGlzLXYxLjEuZHRzaQ0KPiA+ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4LWFwYWxpcy12MS4xLmR0c2kNCj4gPiA+ID4gQEAgLTEzMywxNyArMTMzLDE3IEBAIHJl
c2VydmVkLW1lbW9yeSB7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
I3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmFuZ2VzOw0KPiA+ID4gPiDCoA0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGVjb2Rlcl9ib290OiBkZWNvZGVyX2Jvb3RAODQwMDAwMDAgew0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVjb2Rlcl9ib290OiBkZWNvZGVyLWJvb3RAODQw
MDAwMDAgew0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIHJpZGljdWxvdXMuIFlvdSBqdXN0IGFkZGVk
IGl0ISBJZiB3ZSBjb25zaWRlciBvcmlnaW5hbCBjb2RlIGFzDQo+ID4gPiB3cm9uZywgdGhlbiB5
b3UgaW50ZW50aW9uYWxseSBhZGRlZCB3cm9uZyBjb2RlIGp1c3QgdG8gZml4IGl0Lg0KPiA+ID4g
DQo+ID4gPiBObywgdGhhdCdzIG5vdCB0aGUgd2F5IGhvdyBpdCBzaG91bGQgYmUgZGV2ZWxvcGVk
Lg0KPiA+IA0KPiA+IFNoYXduIGFza2VkIG1lIHRvIGVhc2UgdGhlIHJldmlldyBwcm9jZXNzIHdo
aWNoIGlzIGV4YWN0bHkgd2hhdCBJIGRpZC4NCj4gDQo+IEFueSByZWFzb24gd2h5IGI0IGRpZmYg
Y2Fubm90IGJlIHVzZWQ/IElmIHlvdXIgcGF0Y2hzZXQgZmFpbHMgYjQNCj4gYXV0by1kZXRlY3Rp
b24gb2YgdmVyc2lvbiwgdGhpcyBzaG91bGQgYmUgZml4ZWQgaW5zdGVhZCBvZiBmYWtlIHNwbGl0
Lg0KDQpTb3JyeSwgSSBkaWQgbm90IGtub3cgYW55dGhpbmcgYWJvdXQgdGhpcyBiNCBkaWZmIHN0
dWZmIGFuZCB3aWxsIGF2b2lkIHN1Y2ggc3BsaXR0aW5nIGluIHRoZSBmdXR1cmUuIFRoYW5rcyEN
Cg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

