Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD268780B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjBBI6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBBI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:58:43 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2086.outbound.protection.outlook.com [40.107.215.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8424346D;
        Thu,  2 Feb 2023 00:58:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2TSJh82F0XMey/ooft+dOouK1F0TFZ+06mWSEvqbhaRpScMMjEbSg0ssEfKOLyRP2dvSnvC/pOGWHSF+wNOU1BI0bptv0JOqMMyxyer7p+sod8kCP9f7+PpEV8pv/XHO1sF6ReuMQuw8XTPh77KY8hoCGLahEUiPpVlj3GpU3tyVjyzCi2o7LPVEtLUmGXkdMxknYDkljRFN+lJ2jGOo0LPckjmtVh+dV1/Tu7UOvyGoLVhzYP5hSx+Nz2bKql9iHYdfNt6vgcLjN5fE4kf73OuKUmoUz1nwc0b0UlNVN5H93HxNxXZkD25JAdz6l+QRWm3dNoJF7QeexlmdOo0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8feWURI8nVKmZfibDSPYeMbgn2jowl1WeQutNJx0gjw=;
 b=DgXgEr8SJkNP2W0VmIRta4daJ0LJMzGugjDJvboztLmLGjCJvNfOg3V4m3q5LdH1BHXoqjhXH2fzO2DYeOh6V6qTvfL9OOCx+nEUTuW4Aj2P/PqCzDmUhviKtqckwZrM44DRqnA0WgXDyPPeWbIedpSlOQVUDwTuYn/C0hVO7shJYG4fGzqm3FtKYnZ8n1JkwNgdLlQWT6HTRxqkUNFiojBvBoEyhgHcstICqHiZAT8zdG/IhNrK6AfetM4ZewnjM/juLIRGYIv19B7y7QiaGulBZiRTvylbjL7H5qZCmP0Loajc0p8mD1+Y0CWHTfVhGU3K8aGtlWrvM5O+KjyiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=irondevice.com; dmarc=pass action=none
 header.from=irondevice.com; dkim=pass header.d=irondevice.com; arc=none
Received: from SLXP216MB0077.KORP216.PROD.OUTLOOK.COM (2603:1096:100:7::23) by
 SLXP216MB0078.KORP216.PROD.OUTLOOK.COM (2603:1096:100:11::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.22; Thu, 2 Feb 2023 08:58:03 +0000
Received: from SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
 ([fe80::3d9:7f82:fa73:e727]) by SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
 ([fe80::3d9:7f82:fa73:e727%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 08:58:03 +0000
From:   Ki-Seok Jo <kiseok.jo@irondevice.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Thread-Topic: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303
 binding
Thread-Index: AQHZNj6z/oQKqHubAEaPcBezJAe7N666EYoAgAANx4CAAAs2AIAABPOAgAC2qMCAADu0cIAANtOAgAADxTA=
Date:   Thu, 2 Feb 2023 08:58:03 +0000
Message-ID: <SLXP216MB0077847FB6CF0EF4511E3A628CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
 <Y9pxGUMWyMeXQpZM@sirena.org.uk>
 <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
 <Y9p+p6wt8WugDBuH@sirena.org.uk>
 <SLXP216MB00776F066D70DB2F3F77B09E8CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
 <SLXP216MB0077228B6071F62B183F4D648CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
 <6439a587-0b65-a037-1013-b697e19000a4@linaro.org>
In-Reply-To: <6439a587-0b65-a037-1013-b697e19000a4@linaro.org>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=irondevice.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB0077:EE_|SLXP216MB0078:EE_
x-ms-office365-filtering-correlation-id: 877c22b4-7182-4a6f-2406-08db04fb97f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcytXErx7rjhm6YPlcfiGAAaeZX+DhP7xmdRBgssbUYhodllHIUfxbvxdCD4nZtM3k7RFUT5+jW0/BYbxw3zmGunz6Q49uXWMIyX+alQz9u12UVBckvHWqwi3QhHPE1Npk+wEMjBrQNi6NZYOgw9rRzi4laRzq1HrfnR1Lf9FbsHUDLf7RPZtwAaCU4rNK5FqC06Dcoe4MLRpWHZr9pIa456tx6oX5zE8YgOVwaicBOn/JMI8UtbYSFT+xLlSJRPpnjNHvZoxgQXkBkC7a9adbKNssElKoD3KltqvCOfoOxvRGNcLHXdmX/pe8tC/dd/ZZeJqY3fVjwWT7DvbJqxoCaSdUP+gO0ki8yulapNzfgkaLh1dQzd5XXBDh5pQPd3UFGjhWyNZS15XSvccMTtetWQ8xDAnxoJsfmDo++VSjdFAzhDON7Xpj3KCB8I/2RIxGSrv4JB1S2amGtcVIFaK8/V3kkzD+F4D3oAZKaNdeHoZpD+QuyUFVORe/USt18kwNUZuZflhfBRSdYt5dKuSL6XGjMjFuYhuY7RXMZ3a8JzbVrInIWlyGZJMiLGh4oHcnHKmAbZOpjUya2wphiGis7rTutAq2TE6SJtHkfK+R+dvABllSkWUSyfGDzGl9qLSG8j5tNxBx9GzuNU67VFSo9vuKQQGs2DIdNe/iz/mF3nP6LuZoEXZne23odzHO4x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB0077.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(376002)(366004)(346002)(136003)(396003)(451199018)(38070700005)(86362001)(33656002)(55016003)(66446008)(66476007)(122000001)(76116006)(8936002)(38100700002)(8676002)(66946007)(64756008)(66556008)(110136005)(54906003)(316002)(41300700001)(4326008)(7416002)(2906002)(52536014)(83380400001)(478600001)(5660300002)(9686003)(71200400001)(7696005)(186003)(26005)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHJQa2lXNy9za2pKUVVnRnA4bUxIUk1RbkhYQkJMS1ZObjhSNUUvSnhyZjY1?=
 =?utf-8?B?bi95NGIrUkI1SlJMeWVVOUxjVU5PSmM1eDJMV1RleEVsaFRsUy9SQnBobExh?=
 =?utf-8?B?NTViQVR6Y0xObWZyUCtlWjFhYzZ5WEc1eXNvU01qRUhrQzZhTlZ5M2RPZVZy?=
 =?utf-8?B?bVIvWDJzQW05MUFjeVhjSXRCanJQNWw3aWVuTGlJMHBEWk56M0JPU3FCYTEz?=
 =?utf-8?B?Ky9PQlBhNHBmKy9ZaTA5VDhxTGtZdDNERTdRdUxiTTN2WDhHZDh4aXQ0RUJI?=
 =?utf-8?B?enpDeTAza0pnLzZSbVhaV2ZYeCtFb01ieVZzQ3c0RGhiYnJwYlZUMHBjSjIx?=
 =?utf-8?B?VGgxbitnRTh0dmR3STFzb1lNSmtxT2REaW4xRlpkTHB0NmhlSlUyZ01zZkFk?=
 =?utf-8?B?enJXQUFqbWtjeElKZDNlUERVRVVOcnIzczBJNTQ2Nk5Ib0R0MUl5cnRJMjN5?=
 =?utf-8?B?SjZtT2hvYk5jKzhDV1J1SWRwR1pYWWcvRlNKamE3eTFKdmNINThBN2JsNFdv?=
 =?utf-8?B?VDI1a1psY2gxdG44ZW9jZVBvMXMzbmRZNElpVlBtYnNHM2lmTVA5Um5UVHp4?=
 =?utf-8?B?aVF0MjZjd0VGVzRYckE2dWdBd2xZQ2UxWFJTRUV1Wit3cE9rQnc2STdnVFds?=
 =?utf-8?B?SUkwaGxkekZDY3FPdzlhYUFmQXp5RjFJbkE2VGRNc2twRkFuQXk4cVZoMGVk?=
 =?utf-8?B?SjUycTUwbDFpRXdKRUJZUmY5QlhpR0dMRzE1R0VOMXR5SFZkSHFtTXRsS0Z1?=
 =?utf-8?B?dkY4TVVIWDBYeWprb1ZSMGZMN3pqelBHMjNKZEVVNHlTcDFaaklpekpDS0U1?=
 =?utf-8?B?TnlUTVVuUnQ2TzJOS3lZQ0wvbGJuQmU5KzY1dUxEdVRiUUlSWVBtazR5SFJX?=
 =?utf-8?B?MThaNGxPT3VZUVZyazUxUnpGbU5ZSDQwOWMxZVE0dFB6ZEZEa040Tk9YYXla?=
 =?utf-8?B?b0IxVTN0cUNGUnhEZi9DaWJlTXZqVkRKR2dSQWlOVkFobkF1SjZqWjZkdVpu?=
 =?utf-8?B?alIydm9KL1BUcjR4MFB2NlNzNVFYbTd3TldzekhMa2luZk5DOUh4ajQ0RWo5?=
 =?utf-8?B?bVlpOSszUEhkUS9XT0VqbHgvNEg0Q0NLTHd0NGZScUJ1Z3FlTzAwRk43QkRG?=
 =?utf-8?B?T1NtdzhFeSsxRkgxc05Hb0tiemxzV0huTE0zQUlab2NoVzgrdDVrMmpaN1gw?=
 =?utf-8?B?OVpuWUZ1ODNxZ0VhKzZHb04wRFdXbGlmRkJwRmpySWRpaDkrVm90TUpTVGt3?=
 =?utf-8?B?ZW1nV0Q0cHRMdC9ySGJDVW9SRGpXNzNrc1czU2ZyTnFkaS82dmkyZWVzTHlS?=
 =?utf-8?B?c0luRVpVUmxUL2NDSjdJSXlkUXN3UVhRemhxRWs4QW40cTU2NEhQZmt0UTN1?=
 =?utf-8?B?VnEvdUdhbWN2VzZLTjRzd3JPd1FjWUVQZkw5bjRVNDBrd2doQlg1N1VwNWQ4?=
 =?utf-8?B?dHovQlB3dzdURXpXUzhYQ29MaEJIUnhnWHRYYXNFeExYNDkreHZDV1VqcnBL?=
 =?utf-8?B?c3FDWDh5OHFWRHVRL1dYVEMzb3R5eFZ6cWx2L28wakdibjNBSWFMTVJuQ3VW?=
 =?utf-8?B?eXROMEcreWsxY2tsYTBjRkhvWTFsR3ZFOFZFbVQrRmw2Y21CNUkvY1pxaEg2?=
 =?utf-8?B?QkVGNVQxOXhBUU0xZlJ2bEdCMSs4Rnprd1pxWm1abzhKbmFidGJva3I5VzFq?=
 =?utf-8?B?R2UwSnZYZ3JBMHNXS1VpL0RSaGNrV0p2emp0WVJ2OTVKUnEzUHV3Uy9pVER6?=
 =?utf-8?B?a0lvUjZlc1ptazl2WXRzbzVXaHNKVmk4UDZHZDUvNXpjRHdFelZsSHRERVhz?=
 =?utf-8?B?T2VINjlYRStLVjU1UUZvN1UwZU9tTEpxZDJTZ290VWxZY0cwTDdodS9tWUNC?=
 =?utf-8?B?YWRSZk02bnpUZ3RZdkFtUXZCUzdqMVlrUWdIdW5zc1kwYlJzVExqcGR6bU9C?=
 =?utf-8?B?b1p3b1dZd3RUTXJ6SUhaVzJDRnNGM1g1V1owbDdmMjh0Yzl3SDdsNGV2UGNB?=
 =?utf-8?B?WDdkMTZLa3Bnc3I0WWdZNHp2SThzZlJsL3JFeDBEZlNReWtRTU5rZE84R24z?=
 =?utf-8?B?eVgyeWZaV1lVUExPMWNOKzVOM0t6djUvaXJPSmxPOXlDcVZMMFF3bmp6a0c2?=
 =?utf-8?Q?2T/sW6V+UQVOlYRJp4t9yo3Ke?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: irondevice.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 877c22b4-7182-4a6f-2406-08db04fb97f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 08:58:03.5341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b4849faa-3337-494e-a76a-cb25a3b3d7d1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJbIo53/t/z+fSwyBG0zlCVFkMYI2OKU2SrOohmGz3Kwa0YD18d3Fn43c/L80j+xyzlig4dT/yNeGvwZgxF7wlLerYe+NfMEJl3hiYyV7Mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMDIvMDIvMjAyMyAwNjoyOCwgS2ktU2VvayBKbyB3cm90ZToNCj4gPj4+PiBJIHRy
aWVkLiBJIHN0YXJ0ZWQgd3JpdGluZyBwYXRjaCB0byBmaXggZmV3IHRoaW5ncyBpbiB0aGlzIGJp
bmRpbmcNCj4gPj4+PiBhbmQgdGhlbiBub3RpY2VkIHRoYXQgaXQgaXMgZW50aXJlbHkgZW1wdHkg
YW5kIGRvY3VtZW50cyBub3RoaW5nLg0KPiA+Pj4NCj4gPj4+IEkgcmVhbGx5IGRvbid0IHNlZSBh
biBlbXB0eSBiaW5kaW5nIGFzIGEgbWFqb3IgcHJvYmxlbSBpbiBhbmQgb2YNCj4gPj4+IGl0c2Vs
Ziwgd2UgY2FuIGFsd2F5cyBhZGQgcHJvcGVydGllcyBsYXRlci4gIEFnYWluLCBJIGNhbid0IHRl
bGwNCj4gPj4+IHdoYXQgdGhlIHByb2JsZW1zIHlvdSdyZSBzZWVpbmcgYXJlLg0KPiA+Pj4NCj4g
Pj4+PiBUaGUgdHJvdWJsZSBpcyB0aGF0IHNvb24geW91IHdpbGwgc2VuZCBpdCB0byBMaW51cyBh
bmQgdGhlbiBpdA0KPiA+Pj4+IGJlY29tZXMgdGhlIEFCSSBldmVuIHRob3VnaCBubyBvbmUgZXZl
ciBhcHByb3ZlZCBvciByZXZpZXdlZCB0aGUNCj4gPj4gYWN0dWFsIEFCSS4NCj4gPj4+DQo+ID4+
PiBTbyBzZW5kIGEgcGF0Y2ggdG8gZGVsZXRlIHRoZSBwcm9wZXJ0eSBwYXJzaW5nIGNvZGUgdGhl
biwgbGlrZSBJIHNheQ0KPiA+Pj4gcmVtb3ZpbmcgdGhlIGVudGlyZSBkcml2ZXIgaXMgdmVyeSBt
dWNoIGFuIG92ZXJyYWN0aW9uLiAgVGhlDQo+ID4+PiBwcm9wZXJ0aWVzIGFyZSBhbGwgb3B0aW9u
YWwgaW4gdGhlIGNvZGUuDQo+ID4+DQo+ID4+IE9rLiBJJ20gc29ycnkgZm9yIG5vdCBjaGVja2lu
ZyBjb3JyZWN0bHkuDQo+ID4+IEkgb25seSByZXZpZXdlZCB1c2luZyB0aGUgZnVsbCBzb3VyY2Ug
YnVpbGQgYW5kIGNoZWNrcGF0Y2gucGwuDQo+ID4+IEJ1dCBJIG1pc3NlZCB0aGUgY29uZmlnIHNl
dHRpbmcuLi4NCj4gPj4NCj4gPj4gU28sIGNvdWxkIEkgZ2V0IHRoZSBpbmZvcm1hdGlvbiBob3cg
dG8gdGVzdCB0aGUgYmluZGluZyBmaWxlcz8NCj4gPj4gRnJvbSB3aGF0IEkndmUgY2hlY2tlZCBu
b3csIHVzaW5nIG1ha2UgZHRfYmluZGluZ19jaGVjaywgcmlnaHQ/DQo+ID4+DQo+ID4+IEknbGwg
dHJ5IHRvIHJlYWQgYWdhaW4gbGlrZSBzdWJtaXR0aW5nLXBhdGNoZXMucnN0IGFuZCB3cml0aW5n
LQ0KPiA+PiBiaW5kaW5ncy5yc3QuDQo+ID4+IEFuZCB0aGVuIHJlLXdyaXRlIHRoZSBwYXRjaC4g
SSdtIHNvcnJ5IGFnYWluIGZvciBub3QgY2hlY2tpbmcgcHJvcGVybHkuDQo+ID4+DQo+ID4+DQo+
ID4+IFRoYW5rcyBNYXJrIGFuZCBLcnp5c3p0b2YgdG8gZmVlZGJhY2suDQo+ID4+DQo+ID4+IEJl
c3QgUmVnYXJkcywNCj4gPj4gS2lzZW9rIEpvDQo+ID4NCj4gPiBTbywgd2FzIHRoZSBlbnRpcmUg
dGhpbmcgZHJvcHBlZCwgb3Igd2FzIG9ubHkgdGhlIGJpbmRpbmcgZHJvcHBlZD8NCj4gPiBJZiB0
aGV5IGFyZSBub3QgYWxzbywgY2FuIEkganVzdCBwYXRjaCBpbiB0aGUgY3VycmVudCBzdGF0ZT8N
Cj4gPg0KPiA+IEFuZCBJIHRlc3RlZCB0aGUgcmV3cml0dGVuIGZpbGUgd2l0aCB0aGUgZm9sbG93
aW5nIGNvbW1hbmQuDQo+ID4NCj4gPiAgIG1ha2UgZHRfYmluZGluZ19jaGVjayBEVF9TQ0hFTUFf
RklMRVM9aXJvbmRldmljZSxzbWExMzAzLnlhbWwNCj4gDQo+IFllcy4NCj4gDQo+ID4NCj4gPiBJ
cyB0aGVyZSBhbnl0aGluZyBlbHNlIEkgc2hvdWxkIGRvPw0KPiANCj4gQ29ycmVjdCB0aGUgYmlu
ZGluZzoNCj4gMS4gQWRkIGFsbCBwcm9wZXJ0aWVzIC0ganVzdCBvcGVuIGV4YW1wbGUtc2NoZW1h
IGFuZCB5b3VyIGZpbGUgYW5kDQo+IGRvY3VtZW50IGV2ZXJ5dGhpbmcgMi4gRml4IG5vbi1leGlz
dGluZyByZWZlcmVuY2UgKHRoZXJlIGlzIG5vIHN1Y2ggZmlsZQ0KPiBhcyBuYW1lLXByZWZpeC55
YW1sKSAzLiBpMmNfYnVzIC0+IGkyYw0KDQpGb3J0dW5hdGVseSwgSSBtb2RpZmllZCB0aGUgM3Ro
aWducyB5b3Ugc2FpZCwgYW5kIEkgYWxzbyB0ZXN0ZWQgd2l0aCB0aGUNCmFib3ZlIGNvbW1hbmQg
d2l0aCB0aGUgY29udGVudHMuDQoNClNvLCBJJ2xsIHNlbmQgdGhlIHBhdGNoIGZpbGUgYWdhaW4u
DQpJZiBpdCBoYXMgYW55IG90aGVyIHByb2JsZW1zLCBwbGVhc2UgZ2l2ZSBtZSBmZWVkYmFjay4N
Cg0KVGhhbmsgeW91IQ0KDQo+ID4NCj4gPiBUaGFua3MgdG8geW91ciBoZWxwLCBJIHRoaW5rIEkg
YW0gYmVjb21pbmcgYSBiZXR0ZXIgZGV2ZWxvcGVyLg0KPiA+IEknbGwgdHJ5IGhhcmRlci4gVGhh
bmtzIHNvIG11Y2ghDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gS2lzZW9rIEpvDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpCZXN0IHJlZ2FyZHMsDQpLaXNlb2sgSm8N
Cg0K
