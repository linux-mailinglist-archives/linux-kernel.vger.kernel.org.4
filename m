Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787DA671069
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjARBsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjARBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:48:29 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1640BF5;
        Tue, 17 Jan 2023 17:48:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny91GDU6K/SETDNxffNEE0HY9njDPv65ayOIUx1NDahHIUr+FZAMCbSZWiGV4oAW6gye5CUlkwZyJPK7Bo2xC8YoG6CtPZ4XRk2f6feSq584DbY8f+fQ7mbZlejRP3qUZ536kLekSfPv7m4TuaK7CGsp6utj2U6P7p7mIJc8qqWACbJXVJBUYbDZkL1dB4zxDfrbq+aWLCVfFJfI8UFhPr7b2e6JIaYpvjLP6CqoyAH+fRyNBF9dJXvJF612YL3J+iRigXWWUKf1Qdms6q3nK/Icex+V7L98HxUUYCcBph7Zxil0r3oGdNsJusOLGPavT7juG6HJX2JDRuB2Vntawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GHDZ5APjQCq8RKYkK6sIHSvTGCVX4qR1wiH3ssX67M=;
 b=EfSHCzA6ugO9niL2ybY90p6cWE2KO8H0R3IrX9FEIUHbmIzVltzkaT36C8rL4GHJfDdeqyvzJ2JIMHyFTNC4kNPd+SE0O2BLt5KbvjNcdLdq069yw2DLJj5TkaBQmXrEYcvqznWZaBu8WQmxpgRFCyiRbJ3yu07iwNfgVisPx/0aIx0EFbgCh6qhk90la7bgeSqK/+W/QWZHNOeOLUp0viPvEYYlxEdN1c8FAGXdNyxgqqHQepJwfLnmCaWhx1RGtAQm+LjwL/SsAzkvTHdsPTq1YcchserG4iVa4+IgaRQK29lzWPXiQg2kl9JHn5UEEF9ntvGVOVsFOLeEWn3r0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GHDZ5APjQCq8RKYkK6sIHSvTGCVX4qR1wiH3ssX67M=;
 b=rtIGTVpeOmg+nXJ1my2fP9/jSYAPcUsHjUdFYty2pDHVUv0sTNASqkIQXST9SAEdH1eor/S7ItyX1xbN+j4Oev8s7NdsKaOm2e+xeVog4eqk9BAlo7r7EP0a37MtdHVQZdM5nPkR8sFjcbxpX1uv1wWnn77UxGtGoA1I7PkmuoWM3rcYIvW0mNkZ6pgKdiJwZFgu/GNDr1vVSULlmUf+futELXs2NBBAxzBXUnRnafOP73TPG4t0IyQU8n4IwffWMq5H+tTCeXINLWJvGjyYgBjIKwEXUmanjjY3+VuuurWe2H+Qol5x3+aLRxtNr5nhssX8FyLQ9MrObW2ThbYgDQ==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SI2PR06MB4581.apcprd06.prod.outlook.com (2603:1096:4:141::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 18 Jan 2023 01:48:20 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::b56:707c:e7a1:2e90]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::b56:707c:e7a1:2e90%3]) with mapi id 15.20.6002.010; Wed, 18 Jan 2023
 01:48:20 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
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
Subject: Re: [v4 0/5] Support pwm/tach driver for aspeed ast26xx
Thread-Topic: [v4 0/5] Support pwm/tach driver for aspeed ast26xx
Thread-Index: AQHY/wMMG5E8YIXyWkafMTNbA8kidK6jfL0AgADJOwA=
Date:   Wed, 18 Jan 2023 01:48:20 +0000
Message-ID: <C2AA4099-CD24-4D28-8A91-F1D7EF1BC564@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20230117214806.ptnnhgxmlvyzjdzp@pengutronix.de>
In-Reply-To: <20230117214806.ptnnhgxmlvyzjdzp@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.69.23010700
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SI2PR06MB4581:EE_
x-ms-office365-filtering-correlation-id: a93cf478-9773-4a2a-e4be-08daf8f613c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kX9UVq89w0iwLj+DYdsMW4W7tfA+UrILcSO2suVggNxhzx1PvE5MfNug42INS9MzIn8/qVQdI69qa8e+EvcE4HPyqngX0ATs6Gr7GYCW3qjJC7WxGdlVxtarzhRLU87e3/Rb1f3R9Qhd4nXbpr8iT3gx9jcyDq6RaeIhuir4PRBlhAAaMQSe8mIZVGgh781bSXnAsqrqBonlJ7IIZ35uzMmqouXdrKOnYn9kdXtruzSe+ET3L10zosQlSi/VrMqWN1xEqSMYhb1aVlJrpFsUbfO4W87XYRoOm/KKZc3mZkC+RCfVhhcbPVX/NLw8MFReEW2RbfRflCbfSqEJYYr6CgYxqU31wFgIXi8VcPuWsUeybWwhJzR7XYhFzHAUwZZyikLYAUotviVicDNkazmffPA1+lm4M+SMQfeBV9jZYXMXwbu2wKFyYZN9ySLcMDDTJJr//AY3oA3HMtK2TZvYvdPdWMd//qpXSnK0W2wkdvJOlVVWzr3UhiSzDml6aMBhNyELj/h7qjjuuqJA0Hh2jiCMIV7RMR4+KJb3WJfPTYMLLnIJvpK2vNEVF2f/mQck8vbHTcpL/GoMdqPYUYagz6sjMXHMieiJu1eR6PWvG+in1Ll7rAvKZsoLI76c60OVisTbrZ6I9dD4GOtrSIfX4UQYKkeLlc8VRautde8IAD15SAuM/OxzcA+Xo27vKTT3QgmINGxkrwx8SQCK/sX04TFDgngYdKmQtB+WKRT41o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39850400004)(376002)(346002)(136003)(366004)(451199015)(38100700002)(83380400001)(122000001)(33656002)(66446008)(86362001)(38070700005)(5660300002)(4744005)(4326008)(66556008)(7416002)(66946007)(76116006)(8936002)(6916009)(8676002)(2906002)(66476007)(64756008)(91956017)(41300700001)(186003)(6506007)(6512007)(26005)(53546011)(2616005)(66574015)(478600001)(6486002)(54906003)(71200400001)(316002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1BFeUkwL0Q5dm9EZXFBWjJuY1ZxYUU0enlyY2o2Z3R1Rjc4WCthSUVKMEtJ?=
 =?utf-8?B?VDEvY2xZSk1laHZ0Vko2b2VoWCt1S0hBUUYzcUdCTjRyOEpFU25EMUExMDdt?=
 =?utf-8?B?V1JYM1dpcnF5T3hKcWtGYjE0THhRcFROZWtTSFZHQ1dZd1huSkg2eit3bUtR?=
 =?utf-8?B?OFo1ZjhDekU3cUVkTGpMNjhMMS9hZThWb3IxbUdXNHlDN3Q1ckNCMlJxalhm?=
 =?utf-8?B?LzIrcXhTZmxVand2bmZObUNyYk1peitOVG5qRmYrbURIZWoxUmhDQ0g0anNK?=
 =?utf-8?B?eTd0NDhVNzdXZ3RtQkRGNDJlVTFIZm1UL0dsKzJUbzFkUGhVZ2RzYlpaMEFi?=
 =?utf-8?B?WDF4bllQWHZ0bGJOd25oMVhmYjM5OGQvSVpFcm9ZV2hIcVZTS1U0MC92TW45?=
 =?utf-8?B?SHV3UEx6aXQ4QkFLYm45NUdJRjJ5ZWpvZkR6OWhVWDZaWlFicTdnUVhEWHp0?=
 =?utf-8?B?bmozekJKTDNrL0FHQTZldHNvVEQ2VDRoVExISHVPczNPNjM5VzZzS0xWMk5Y?=
 =?utf-8?B?bUFVeUVpMEhvT3p0Y2doY0FiT3RXbFNpL0hkVTQrajUxUFkxaU5vZE5JQVlu?=
 =?utf-8?B?NEpKWHJFMjBlZ1BDL2JPa2VNcm9wMlFjZ2EyWm5obDQrQ08zam9HcGNXNTR2?=
 =?utf-8?B?YnRvQ1FJR25QdjFSVjVCeWNpODdYcXpLQkdjWTd3QUdIS3k5S2NZQ1pQcGJH?=
 =?utf-8?B?eXlBMkxCZy9vUFVpcExCczNyL3ZCa00zZUdXQ1prUnpPRjRrOUNRV0N1TnNB?=
 =?utf-8?B?VWVJaUVPSVlGOTBXSjY1MmxuRTJqZ1gzTDIreThxZUNlZ0JDL25wck1md1Rm?=
 =?utf-8?B?dlJqMGxBb2dvRk1DUWJ0M1RDQ3JyWWJtenFJazRoWm92OGlaSjZocDlzQ0JL?=
 =?utf-8?B?eXFsQVFxeXFhRHVid3BGcVEvUVRWWnZ1RXJ1alpIb2lIWWFtU01mNVphWXpO?=
 =?utf-8?B?Ym1uM3hCbVU0VHk2MnNyb3dQcm5CclhuaG5OUk0xRk1jQ3RES3BlZjViNUJT?=
 =?utf-8?B?M0Y4TVE4bXVPakRLTEdvVnhTaHVDeDBqTU9SZWR2cGhaTFRxbk5LRDJNSTFu?=
 =?utf-8?B?QmdsUVR1WjVSR3VYWE1pVitLa2RhdG9ZVXl4bldWbHFwN1pjYzdxODUyYWxa?=
 =?utf-8?B?d2lUbmsvdG5OU21YT1pHMEUrZjdHdGRjM0IyY2FQbjkvZGJzWVJESm42ZW8x?=
 =?utf-8?B?NFdyUVYrM2MxazlCaHB2ODFQMHJEYXZhalRHQktnY2VOamQyQmtnM1ZwYkdw?=
 =?utf-8?B?MlgwYi9GRVpGa2M5M1dReERGQUEvZ1pqQVp2bGIwemNpN2VHd3Rza1FodmVM?=
 =?utf-8?B?QW5tRCtnVHdiMWFjQXc5cFJuWEpZU2lkcmU3N3NMczBJT3Y1Z0djNEVPMXJU?=
 =?utf-8?B?MjlkRmdSRXBUbmdScTF1b2M4TXVSSUdlSGpIRlhmc0FETVVDeDJieXhuWUZo?=
 =?utf-8?B?TytoaEZSa0xiVTFEMmRyMUJFSThHYjhiWUNRU3hGekZnWW5Xekxpc3hFdXBV?=
 =?utf-8?B?ajVzL29BdHVkaXZza1ZYSnJ4TDJLcXVSZmZSQjE4a3owVzlSTGpFTW9NWTd3?=
 =?utf-8?B?NzI4cU5kdnIwc1NDcS9ickp3VStXTGh1dSs3NS9ZTW1pUTlhQjJ5eUFTbGt5?=
 =?utf-8?B?enYrc2VweW9kSFNuM0I0dk4rZW1hdThUSDRrTVp6TVdqa05OaVBDWDRiVXF5?=
 =?utf-8?B?UDZKNHI2VEU3bS93QkZLYldvcGpobmEwSUZjeVgyTFZCTVFidVdyeVdXZTNi?=
 =?utf-8?B?bk1JSWVVOGtEYTU1U0FKS3JBS1JrMUg0djZ4KzRJSjd6ODhuOGNrQ3ozR0FK?=
 =?utf-8?B?dXMwU2t5YzdaWWdtRDhnbkY5NCtSaHJNbnVMenZGMy8yL290YU0rdXVLWHcy?=
 =?utf-8?B?cVVxc21PR2pZZzBROEdzSmVSN2YwcWNHYzhrSW1Ob1hhUy9BMWE3R3BWYnJ4?=
 =?utf-8?B?bVpHUndCRlJUVER0RlNITEFKOTl5eHgvMS9pK0hIYWhrWGFIK2xtaXYvbUpt?=
 =?utf-8?B?MWhMVVZsc25OSnR6S3pYOGFRY2h4dmJnelpINmRMY3B5L1dPUGwzeUsydllt?=
 =?utf-8?B?VEZYbnB5VGxOUUpMRDN6ZVBpSFFzejAyL3A4L0tnRWFDeEJvVGpRekd4MGxI?=
 =?utf-8?B?SVBRQjF6WC9OU3ptTXhQa01MMUdtTEp3TWpGQ2ZYSEpwZVlTdjJEVUVnMXJQ?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEA228E10DFF7C499D5088309820E1B4@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93cf478-9773-4a2a-e4be-08daf8f613c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 01:48:20.3438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gH9EpOBdmaQJPPwoFaqQ0Sq4PGlh8Gu7LJfFulfg6vZ7agM/IfoGVz+G87+OLZumcSPpFqpxw7XnWDyIkXUWuYPiWVXCdnC4Ovn6kNHwUiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQogIE9uIDIwMjMvMS8xOCwgNTo0OCBBTSwgIlV3ZSBLbGVpbmUtS8O2bmlnIiA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlIDxtYWlsdG86dS5rbGVpbmUta29lbmlnQHBl
bmd1dHJvbml4LmRlPj4gd3JvdGU6DQoNCg0KICA+IEhlbGxvIEJpbGx5LA0KDQoNCiAgPiBJIHdv
bmRlciBpZiB5b3UgYWRkcmVzcyB0aGUgZmVlZGJhY2sgeW91IGdvdCBmb3IgdGhpcyBzZXJpZXMu
IEkgdGhpbmsNCiAgPiB0aGVyZSBhcmUgbm8gYmlnIGlzc3VlcyBsZWZ0LCBhcmUgdGhlcmU/DQoN
ClRoYW5rcyBmb3IgeW91ciBoZWxwLiBZZXMsIHRoZXJlIGlzIG5vIGlzc3VlIHdpdGggdGhlIFBX
TSBkcml2ZXIgYXQgdGhlDQptb21lbnQuIFRoZSByZW1haW5pbmcgdGFzayBvZiB0aGlzIHNlcmll
cyBpcyBkdC1iaW5kaW5nIGFuZCBJIGFtIHdhaXRpbmcNCnRoZSBmZWVkYmFjayBmcm9tIHJldmll
d2VyLg0KDQogID4gVGhlcmUgaXMgb25seSBvbmUgcGF0Y2ggbGVmdCBvcGVuIGluIHRoZSBQV00g
cGF0Y2h3b3JrIChpLmUuIHRoZSBwYXRjaA0KICA+IGltcGxlbWVudGluZyB0aGUgZHJpdmVyIHRo
YXQgYWxyZWFkeSBoYXMgbXkgUmV2aWV3ZWQtYnkgdGFnKS4gSSdsbA0KICA+IGRpc2NhcmQgdGhh
dCBvbmUsIHRvbywgYXMgImNoYW5nZXMgcmVxdWVzdGVkIiBhbmQgaG9wZSB5b3Ugd2lsbCBzZW5k
IGENCiAgPiB2NS4NCg0KSSB3aWxsIHNlbmQgYSB2NSB3aGVuIHRoZSBpc3N1ZSBhYm91dCB0aGUg
ZHQtYmluZGluZyBpcyByZXNsb3ZlZC4NClRoYW5rcyBhZ2FpbiBmb3IgeW91ciBoZWxwIQ0KDQpC
ZXN0IFJlZ2FyZHMsIA0KQmlsbHkgVHNhaQ0KDQo=
