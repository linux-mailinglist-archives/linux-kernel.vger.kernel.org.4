Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478396A00EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjBWB4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjBWB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:56:10 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B71149B8;
        Wed, 22 Feb 2023 17:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ2iIQF5FTP643xLSoLLCcJtKUsBcB3pNKb4JqGjP+FCrrFxQnxf5wQCnV1fIyplIhfTE5G0zeGUqsaB4lNLEjpJMCNX/vcPbNFOi/5/MfOTqHOQ+80k+dkE16VVfSOBdCz8M94H3USmbnjMIkqQpshxZgmJaxeqJqpEV87zokzSdNI3itcag12WW7AsmcDcF167vC+O97irMQpmBRI1OPAtlcSAMtY8FlUyKN+T3sJ4obdXbVBzhUwrNeN51r4vzqtapsw9Ni51KgaesH9zkR7IXX1lPZxeJk6j1s2jlNApC95BI4ZknlmAWm5uwB9z6KkHsvE/+ASOoDSbFowIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G2z1qMNW6/oMKSZNM10RVthx0Vxi11oYJwp4k4v5qA=;
 b=jjQUbxuZ0CgJ/TfR6b79o6E6J5cXY9pzHsY06lQkivVmDilF3ezdgvOidgvTlPS+OWWiRyq+DEnI3TXVUqyMnDAdV2i6KK2wfOC9nV3jJjN1Rf9Op/5tpqRSh5hEXq5lVHkbliGDR2foJvwZsaD8GmhMxksFSLx5smSpl++/MHMbI4Eh0ZQ3oQ/jznfAQuNio4dXb3oZSyALcUX+IguE0tjF7JmpbwgT/uMYf7MirNe2DRLjgAEiYEwVMLYUlXftRB9T1fYx5yCjsFLqQNZv85Nz2re7DPmeVuQPk7t5FT2y2+mDXpQmgYbM7d0ir08/b34WqDuE9sIMiGTBEpEXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G2z1qMNW6/oMKSZNM10RVthx0Vxi11oYJwp4k4v5qA=;
 b=vO6zgQVDczryKtJIYL2F7FObtm/i65bvet8aZfjaWsr7IQdBym0E+PhWeLyWoNyXm0BMGrrSLqurW5lyGqb2Owoo4Z20Ee9yOYOIbPeJWwi/8J0kxln/hRHpIGswJx01P/cAfVoUr/cCd2aLcTDkVa+Ff42dPD2A0X27sTu3krLKYe4g0mDQHSS+JTGWyOeu3ATxGokXbfUdbQ77cIWroZahiP5KtDi6xdWuxupab2YtFVBV5Ov2qyjVx2bn5osU8XZt+Wcj5ub6RbhljDkJO8D5V9tBqMg8hB4Mebv6f8F/3d9gTmt6K2FnHqIfFfhNyYBpauC0cmiyfY0zuTCncA==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by PUZPR06MB5476.apcprd06.prod.outlook.com (2603:1096:301:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 23 Feb
 2023 01:56:01 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::b113:70f9:7dc9:543f]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::b113:70f9:7dc9:543f%5]) with mapi id 15.20.6134.017; Thu, 23 Feb 2023
 01:56:00 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] crypto: aspeed: Add ACRY RSA driver
Thread-Topic: [PATCH v5 1/4] crypto: aspeed: Add ACRY RSA driver
Thread-Index: AQHZH9y551Wz9Wl3hka+spzxo8WWOa7bV7gAgAC4bQA=
Date:   Thu, 23 Feb 2023 01:56:00 +0000
Message-ID: <TY2PR06MB3213D7FEB7D3FF472419419E80AB9@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20230104013436.203427-1-neal_liu@aspeedtech.com>
 <20230104013436.203427-2-neal_liu@aspeedtech.com>
 <CAMuHMdVS_JF0+5CyNM6ivxqRLKkMte9=Xw5E-fc-OTHibwc5vw@mail.gmail.com>
In-Reply-To: <CAMuHMdVS_JF0+5CyNM6ivxqRLKkMte9=Xw5E-fc-OTHibwc5vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3213:EE_|PUZPR06MB5476:EE_
x-ms-office365-filtering-correlation-id: 480720c8-e070-4016-1764-08db15411cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gtzo6IiCRrSZKaTKgZMk9YJo0Ed8qZ9DrpcRcxDNDDXMbDPqGFYhQ7KAsOsDnnrMQYUyggRmKugPRkUHNjVW5J7dLRyzgD68AZ2CN+hMc0IoB4+S8gzGRrGLpEqY+wLMsosoETO9JMSO1ABXPXizkXgwOIdejv+C4piPLxVIf8Ldi7kp1dly/g/xZWdSP/xMQbbhPW89nRcZm/Q0sgDF0Ym+ytMl5P5ULgWhTdD/9GTxPtKNL1YCSQWCFmpbgOSW5pgRmAyDwfUS+wt8snj9ZPTyQgcM1cputcFU0OGCiYCQ8U5pYb2PpkewMYK1IFGQ7lSminkiimdH/wWhZ9kOoCDRvMZINdcOmLdTFubz90QqS2Ys7MiLpUbygKsBwc3wOwvMRB8rOEan0QOYlJ+jMugWMvIPsjiDRA/2phSuPlS5DNWpbFgvdwva1YH8SDoj5nFz/pimrUOLM/TqOBB+SXF53HxRh9t3Kzosq/mHG7r9mJL8s1ShGqs4hv31KBu2+T8KTZns25ds6/sDVoGXG17lOqWT7p27jxvqJkQIiYG0l6e4W5xqnFy4EMdWy1jCf7kLi/4UOKyvXG9Y0GxD7AOJwIHblwnO25f9gdL289RnBLrHAL/5PCR9VcwbSDq+g+PJ6WhyG+rLwwaN8gWKpKoGzpBYbNdQeSaWXigdQlcogRupHkOwSD++0zGNY37stKOyM7P+PcQrHjm8a5znbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39850400004)(376002)(136003)(346002)(451199018)(316002)(64756008)(66946007)(4326008)(66476007)(8676002)(66556008)(66446008)(6916009)(2906002)(76116006)(41300700001)(478600001)(54906003)(8936002)(7696005)(52536014)(7416002)(5660300002)(71200400001)(6506007)(53546011)(26005)(186003)(9686003)(33656002)(55016003)(86362001)(38070700005)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWljRm5GY0lYdTdRLy9PSWRpQTZ2eWk5eGxFaGFJTFZaNVZ4Z25Ed1BHY1Yy?=
 =?utf-8?B?NVNWdVNKdHR4Q043YTJHRVo4eVRCSHNHZlhQdzNXQmNQSjhRaDhJSksrOWI0?=
 =?utf-8?B?T1grNnhDTUZDc3B6Y2VRbmg5SndDaDJ4RkoyZjBGeFdyd1NSZm1EVFB3SG5i?=
 =?utf-8?B?eUhHeWIyTzVIVzZ3VlpWai95bVU0eTNWVUF3V0JtOFFsVTByY1VUcDhWN1g1?=
 =?utf-8?B?QmIrT2s1dFU1S0RoUDlTL1ZTZTZ5Z3pyVlhQcFIrR3FXUGhseWhidXpmU1k4?=
 =?utf-8?B?TVkvTmFPb21RVmtuRVEwMnMyN2lteERTZnQzRWh5cGNzcHRxOStwRXZ4d3dE?=
 =?utf-8?B?QTlNYVd1MFlWdXVwRzBYK1NkYmc0TjNiT0ZtZXhEcDlVZHQ1bHlNT0dLK0k5?=
 =?utf-8?B?ZWdHcStneUZBRllqZzQwanVRWDN4U2s5YlNFR3VLMTIwR0tLczhuZHBTcDYr?=
 =?utf-8?B?ODM0OHM1SGhUcEsxV0NOemFySjN4SWpPYXlxZURJS0M1bDZkNTZ6ajVhN09m?=
 =?utf-8?B?NjVYTHJWS2xqWExBaUlJbDhhSEJNbjBEeXJwZ3VnNlI1RlhtbXZ4RmlHRmhp?=
 =?utf-8?B?UnB1WW1OUjZyOGRLMFZNekZEMmRLaEtrWjdSc0ZUcDJHZ1BqQmFOZ2g3b2JD?=
 =?utf-8?B?RFA0L0h0bEYxZE5vdDEvdnMzOHB0UUJHSGYvckplUG1xVG96UDJ3K0ttbisv?=
 =?utf-8?B?cTBYY0tUQnBCalB3dm9sVU5aT2JQbjlXM0wxQ0pWNlBXcnpYcEd5RHhFNE5S?=
 =?utf-8?B?b3d3RW4rNCtzQW10ckE0RWQyUm0zOHRFQmoySXJmbzZQSGpydUZXamNXWEll?=
 =?utf-8?B?M09NZndyRWN3MjNLTC9vQ0FTbURhUEZmQnpnVFhuSDJ5bDRJUjExTEtYQ0JS?=
 =?utf-8?B?M29FWEEvRytMNFlGVzBjeXF0ajBSOFpYdzJoWm43empxamhrb0tsYndkT1Av?=
 =?utf-8?B?TllYS21qUmc3eUNNd3lZZ21ta2wrUDVyM0pUcTNZT25UVTNmTUQyemttVEVO?=
 =?utf-8?B?YzhDa0lKYzI3emVrYVBHRmxWYXg5Rjk5L0dVZ3VZaDVqaTJkem5GNjhHa1dZ?=
 =?utf-8?B?Z0NMZS9ER1I5cVdHYmpxcHZrVXBpc0c4SFRMejYwYWZoMm9MQ05SdDdNYm5W?=
 =?utf-8?B?R3JmODFhdytvaURSS0dyMno2N2NTYWthZkVNTW5lZWk1OVVPZTZtK2xpVnNx?=
 =?utf-8?B?S3BGUGdsa0VnWFBCOFYzZ1F3b2x3eHZQOG9uOXk1QzBpeVJDZG1SVG82ZWxL?=
 =?utf-8?B?ZHN2R1NXT0luU25aMzZNdnVLTEViNFdHWWR2Y0dHVVVyTk1PTFY4SUptWUtV?=
 =?utf-8?B?QTA1MFo5SkZkZUpqYnVIZzBPZjRnbkhKOW9DWWRtUlBlM3FlYWU5TVZqalZx?=
 =?utf-8?B?aEdyOXh2VFd5TTl0d1lXcUd0SFg4YWV1K2JYb2RscjgrWjhGbmUrNXh4b1ZS?=
 =?utf-8?B?Yk9oTkxHa2dVdi9kR1JuSkRTVWwxM25OQ01DYzRTNGdyL21TT2lWRGtiTkFw?=
 =?utf-8?B?R3o4MGtQRzRnMFFTL2VtK0pPZWRoKzRCRUhpV0ZhaVphY0NuVFdOenBnVXNy?=
 =?utf-8?B?VG80aEFRNVhveXFNN2xxclIvd1R1T2hHWHdIRWFBSUttTmlEUVc3bndVRGlX?=
 =?utf-8?B?cmhnNVdBTHh5MjFtU040TktTM0FpMTcyZmNvZS9QaEV0dmx1QjJFZHdrS0ZP?=
 =?utf-8?B?NkVPbjA2bHFJc1FrRU9GdmR6SUxxS1NyWmszTGhSVUl4YkdmNUJNcFlJNW5H?=
 =?utf-8?B?cnd1M2tvYUxPWGltZTRRVFFyUFQzdy9Ya2RFdlV0WjJnRGNlNmVLVkZqSzM5?=
 =?utf-8?B?MjlvS1QzWFMwUVBpaU5Fc2xBLzVvOE1CZE9qWUpoWEtIUXV0WVFOeDAzV2lV?=
 =?utf-8?B?aTVUSmdqa1B5bHFqOFBUdHFadVVjbldMRExjeU5wdVJoT09jRFlUU2xHUElR?=
 =?utf-8?B?M2N5T0p3emdVTmNlTHVlZlBSbExEdWgrSTkybDVpMjVmYjY3cTIyWVdnMVNF?=
 =?utf-8?B?VnVTYTA5K3hMWURFRUx6UDgwc0JRbFhEblErRGovYzVBM2RYbnFubE5aNyty?=
 =?utf-8?B?VmNLdTFVVFpISXNqT2dtWHRHZEhaSEJ1OGQvNUI2VXpmWGVkOTczbFZzbFVW?=
 =?utf-8?Q?WYFbNcAr06/Ex2mgQzTvcBxp2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480720c8-e070-4016-1764-08db15411cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 01:56:00.3438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkfzM4Ks23KdAhDRQ29vWWWHw8kjRt2jsRqTRSF76DF44Fr9gFB6vTt87LTtZ8DuD7yZZ6TAvtnV+P09civ9UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBOZWFsLA0KPiANCj4gT24gV2VkLCBKYW4gNCwgMjAyMyBhdCAyOjM3IEFNIE5lYWwgTGl1
IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNvbT4gd3JvdGU6DQo+ID4gQUNSWSBFbmdpbmUgaXMgZGVz
aWduZWQgdG8gYWNjZWxlcmF0ZSB0aGUgdGhyb3VnaHB1dCBvZiBFQ0RTQS9SU0ENCj4gPiBzaWdu
YXR1cmUgYW5kIHZlcmlmaWNhdGlvbi4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWltcyB0byBhZGQg
QUNSWSBSU0EgZW5naW5lIGRyaXZlciBmb3IgaGFyZHdhcmUNCj4gPiBhY2NlbGVyYXRpb24uDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8bmVhbF9saXVAYXNwZWVkdGVjaC5jb20+
DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gsIHdoaWNoIGlzIG5vdyBjb21taXQgMmYxY2Y0
ZTUwYzk1NmY4OCAoImNyeXB0bzoNCj4gYXNwZWVkIC0gQWRkIEFDUlkgUlNBIGRyaXZlciIpLg0K
PiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9jcnlwdG8vYXNwZWVkL2Fz
cGVlZC1hY3J5LmMNCj4gDQo+ID4gK3N0YXRpYyBpbnQgYXNwZWVkX2FjcnlfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsgICAgICAgc3RydWN0IGFzcGVlZF9hY3J5
X2RldiAqYWNyeV9kZXY7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+
ZGV2Ow0KPiA+ICsgICAgICAgc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gKyAgICAgICBpbnQg
cmM7DQo+ID4gKw0KPiA+ICsgICAgICAgYWNyeV9kZXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXpl
b2Yoc3RydWN0IGFzcGVlZF9hY3J5X2RldiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIGlmICghYWNyeV9kZXYpDQo+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICAgIGFjcnlfZGV2
LT5kZXYgPSBkZXY7DQo+ID4gKw0KPiA+ICsgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgYWNyeV9kZXYpOw0KPiA+ICsNCj4gPiArICAgICAgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNv
dXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gKyAgICAgICBhY3J5X2Rldi0+cmVn
cyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQo+ID4gKyAgICAgICBpZiAoSVNf
RVJSKGFjcnlfZGV2LT5yZWdzKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
YWNyeV9kZXYtPnJlZ3MpOw0KPiA+ICsNCj4gPiArICAgICAgIHJlcyA9IHBsYXRmb3JtX2dldF9y
ZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMSk7DQo+ID4gKyAgICAgICBhY3J5X2Rldi0+
YWNyeV9zcmFtID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiArICAgICAg
IGlmIChJU19FUlIoYWNyeV9kZXYtPmFjcnlfc3JhbSkpDQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiBQVFJfRVJSKGFjcnlfZGV2LT5hY3J5X3NyYW0pOw0KPiA+ICsNCj4gPiArICAgICAgIC8q
IEdldCBpcnEgbnVtYmVyIGFuZCByZWdpc3RlciBpdCAqLw0KPiA+ICsgICAgICAgYWNyeV9kZXYt
PmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ID4gKyAgICAgICBpZiAoYWNyeV9k
ZXYtPmlycSA8IDApDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5YSU87DQo+ID4gKw0K
PiA+ICsgICAgICAgcmMgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgYWNyeV9kZXYtPmlycSwgYXNw
ZWVkX2FjcnlfaXJxLCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9u
YW1lKGRldiksIGFjcnlfZGV2KTsNCj4gPiArICAgICAgIGlmIChyYykgew0KPiA+ICsgICAgICAg
ICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZXF1ZXN0IGlycS5cbiIpOw0KPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gcmM7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAg
ICAgYWNyeV9kZXYtPmNsayA9IGRldm1fY2xrX2dldF9lbmFibGVkKGRldiwgTlVMTCk7DQo+ID4g
KyAgICAgICBpZiAoSVNfRVJSKGFjcnlfZGV2LT5jbGspKSB7DQo+ID4gKyAgICAgICAgICAgICAg
IGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBhY3J5IGNsa1xuIik7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiBQVFJfRVJSKGFjcnlfZGV2LT5jbGspOw0KPiA+ICsgICAgICAgfQ0KPiA+
ICsNCj4gPiArICAgICAgIGFjcnlfZGV2LT5haGJjID0NCj4gc3lzY29uX3JlZ21hcF9sb29rdXBf
YnlfcGhhbmRsZShkZXYtPm9mX25vZGUsDQo+ID4gKw0KPiAiYXNwZWVkLGFoYmMiKTsNCj4gPiAr
ICAgICAgIGlmIChJU19FUlIoYWNyeV9kZXYtPmFoYmMpKSB7DQo+ID4gKyAgICAgICAgICAgICAg
IGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBBSEJDIHJlZ21hcFxuIik7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAg
ICAgIC8qIEluaXRpYWxpemUgY3J5cHRvIGhhcmR3YXJlIGVuZ2luZSBzdHJ1Y3R1cmUgZm9yIFJT
QSAqLw0KPiA+ICsgICAgICAgYWNyeV9kZXYtPmNyeXB0X2VuZ2luZV9yc2EgPSBjcnlwdG9fZW5n
aW5lX2FsbG9jX2luaXQoZGV2LCB0cnVlKTsNCj4gPiArICAgICAgIGlmICghYWNyeV9kZXYtPmNy
eXB0X2VuZ2luZV9yc2EpIHsNCj4gPiArICAgICAgICAgICAgICAgcmMgPSAtRU5PTUVNOw0KPiA+
ICsgICAgICAgICAgICAgICBnb3RvIGNsa19leGl0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4g
PiArICAgICAgIHJjID0gY3J5cHRvX2VuZ2luZV9zdGFydChhY3J5X2Rldi0+Y3J5cHRfZW5naW5l
X3JzYSk7DQo+ID4gKyAgICAgICBpZiAocmMpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJy
X2VuZ2luZV9yc2Ffc3RhcnQ7DQo+ID4gKw0KPiA+ICsgICAgICAgdGFza2xldF9pbml0KCZhY3J5
X2Rldi0+ZG9uZV90YXNrLCBhc3BlZWRfYWNyeV9kb25lX3Rhc2ssDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgKHVuc2lnbmVkIGxvbmcpYWNyeV9kZXYpOw0KPiA+ICsNCj4gPiArICAgICAgIC8q
IFNldCBEYXRhIE1lbW9yeSB0byBBSEIoQ1BVKSBBY2Nlc3MgTW9kZSAqLw0KPiA+ICsgICAgICAg
YXN0X2Fjcnlfd3JpdGUoYWNyeV9kZXYsIEFDUllfQ01EX0RNRU1fQUhCLA0KPiA+ICsgQVNQRUVE
X0FDUllfRE1BX0NNRCk7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogSW5pdGlhbGl6ZSBBQ1JZIFNS
QU0gaW5kZXggKi8NCj4gPiArICAgICAgIGFzcGVlZF9hY3J5X3NyYW1fbWFwcGluZyhhY3J5X2Rl
dik7DQo+ID4gKw0KPiA+ICsgICAgICAgYWNyeV9kZXYtPmJ1Zl9hZGRyID0gZG1hbV9hbGxvY19j
b2hlcmVudChkZXYsDQo+IEFTUEVFRF9BQ1JZX0JVRkZfU0laRSwNCj4gPiArDQo+ICZhY3J5X2Rl
di0+YnVmX2RtYV9hZGRyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIG1lbXplcm9fZXhwbGljaXQo
YWNyeV9kZXYtPmJ1Zl9hZGRyLA0KPiBBU1BFRURfQUNSWV9CVUZGX1NJWkUpOw0KPiANCj4gV2hl
biBjb21waWxlLXRlc3Rpbmcgd2l0aCBDT05GSUdfSEFTX0RNQT1uOg0KPiANCj4gICAgIGVycm9y
OiBhcmd1bWVudCAxIG51bGwgd2hlcmUgbm9uLW51bGwgZXhwZWN0ZWQgWy1XZXJyb3I9bm9ubnVs
bF0NCj4gDQo+IFRoZSBjYWxsIHRvIGRtYW1fYWxsb2NfY29oZXJlbnQoKSBsYWNrcyBlcnJvciBo
YW5kbGluZywgYXMgdGhlIHJldHVybmVkDQo+IGFkZHJlc3MgbWF5IGJlIE5VTEwuDQoNClRoYW5r
cyBmb3IgeW91ciByZW1pbmRpbmcuIEknbGwgYWRkIGVycm9yIGhhbmRsaW5nIGZvciB0aGlzLg0K
DQo+IE1vcmVvdmVyLCBpcyBpdCBzYWZlIHRvIGFsbG9jYXRlIHRoaXMgYnVmZmVyIG9ubHkgYWZ0
ZXIgdGhlIGNhbGwgdG8NCj4gY3J5cHRvX2VuZ2luZV9zdGFydCgpPyBJLmUuIGNvdWxkIGFjcnlf
ZGV2LT5idWZfYWRkciBiZSBhY2Nlc3NlZCBiZWZvcmUsDQo+IGNhdXNpbmcgYSBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2U/DQo+IElzIHRoZXJlIGFueSBvdGhlciBpbml0aWFsaXphdGlvbiB0aGF0
IHNob3VsZCBiZSBkb25lIGVhcmxpZXI/DQoNClRoaXMgZG9lcyBub3Qgc2VlbSB0byBiZSBhbnkg
cHJvYmxlbSBzaW5jZSBhY3J5X2Rldi0+YnVmX2FkZHIgb25seSBiZSBhY2Nlc3NlZCB3aGVuIEhX
IGhhcyB0YXNrIHRvIGRvLg0KQW5kIHRoZSBIVyBoYXMgdGFzayB0byBkbyBvbmx5IGFmdGVyIHRo
ZSBhbGdvcml0aG0gYmUgcmVnaXN0ZXJlZCwgd2hpY2ggaXMgYWZ0ZXIgYWNyeV9kZXYtPmJ1Zl9h
ZGRyIGluaXRpYWxpemF0aW9uLg0KDQo+ID4gKw0KPiA+ICsgICAgICAgYXNwZWVkX2FjcnlfcmVn
aXN0ZXIoYWNyeV9kZXYpOw0KPiA+ICsNCj4gPiArICAgICAgIGRldl9pbmZvKGRldiwgIkFzcGVl
ZCBBQ1JZIEFjY2VsZXJhdG9yIHN1Y2Nlc3NmdWxseQ0KPiA+ICsgcmVnaXN0ZXJlZFxuIik7DQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtlcnJfZW5naW5lX3JzYV9z
dGFydDoNCj4gPiArICAgICAgIGNyeXB0b19lbmdpbmVfZXhpdChhY3J5X2Rldi0+Y3J5cHRfZW5n
aW5lX3JzYSk7DQo+ID4gK2Nsa19leGl0Og0KPiA+ICsgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKGFjcnlfZGV2LT5jbGspOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByYzsNCj4gPiAr
fQ0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBv
ZiBMaW51eCBiZXlvbmQgaWEzMiAtLQ0KPiBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNl
bGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVz
dCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
