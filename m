Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A55652B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiLUCRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLUCRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:17:14 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1161CB31;
        Tue, 20 Dec 2022 18:17:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAgv8AV4bRxBdaK5SHb+cPzewWX5rz7hSu68gl+/vqrffgtJwLdpi0oXixHi1ghEuHrP+zAjXaP9NEqGTJjhr0q9hb8odHwwptRw23Z1n23KVMOL32tzfOuR8AolASymeJ0ViRPuH6gHd+WN7XeSmec6Xc9eBANsbhzADmfdZbp6OBk3EAu6kxkl+IjNYrYXAEcICJxsJLUEynjxof47wuOIZu0sypDaa6YM8rLyo3Xk/8AzBN/m4RqmyOwcL9G5miYgZymesmwkhAfR9PKgPm1P3LiTVcPHWhdyvW8SIlLVB2EqnSbae3W5Ouc3C/geBiQ7NXcXLMUSbyc1W2HthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH8168PHUGojpS/h+UASVWc8FLiwSuS9dbHgJ2eizd4=;
 b=PE4zd33A9U/MgOO5DZN46LOm1WhEjRRJsGWst9kAg1IRUim8l5iis13Ttow4WO4JZ9CGALRtT+l0OyNKuuqRJmvEwDP7m47K5Tx2cc0FtX1QyzmqmrCrYhskkZ3p8RPmrqESaG5Npmjb8GjxFXP4TghL3PK1Z/GrpbjpGjbis5zJMKZPURmK63//9coHxVTd2Wea89H+1+9mQn8QVMubRyUjNwNFT8uKgG8uknhEkILXqS24QarQis//A5X+cNMQIKSSinj7S4HK7C+xNj+KXH2cTXhAh1yB6Nc8piPEGg8TCCMk+uI3k0+fkGk3nACkr4frLyKe8XD6bFz7DxSavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH8168PHUGojpS/h+UASVWc8FLiwSuS9dbHgJ2eizd4=;
 b=laoUsczprxjEZEuRTvGEBvlAb2/BeZ/SAAazZXUoA0ZPQdnam8hB8nkzWUAAImSZJQILcdQHajT76PUOeFnmkL/HwvmsLCndLN+UMfCKQZkMhR8t54B7wT3msyUgvYjYWz6dn4egjTMXFL5Uv0qsIBtzsnzv5HO2B3StECK1B7dLajmKShpXHsMvBLqvJZlxoHrPE01NYe7iv8ey5LJdHpIli6U8jyfRFtHuEz2Qf1PiJ+Egy/K+Ytgi3k6JbjK94zbotCtf919Zueck1k2UYeypJY6afjyqIlgXtPFP9/SoZIdNm7BPgrNUWdNSnD8zi+HQkTPDdhLQEX9V4U/HZQ==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by SEYPR06MB6035.apcprd06.prod.outlook.com (2603:1096:101:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 02:17:04 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::abee:6367:ef03:e60b]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::abee:6367:ef03:e60b%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 02:17:04 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Lei Yu <yulei.sh@bytedance.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Topic: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Index: AQHY543fG2IRDKPpjUCvaIBADhhwbq4jYB2AgAASRYCAABWy4IAABOeAgAADxYCAABTTAIBTTWgAgAEBPsA=
Date:   Wed, 21 Dec 2022 02:17:03 +0000
Message-ID: <TY2PR06MB321303972156248AB08CAB2480EB9@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1ueEYJk2epT/g4J@kroah.com>
 <HK0PR06MB32024F58191E17DC5ABC99F380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1uyssu84kl1INSR@kroah.com>
 <CAGm54UGmp=kTKGLhEfENF4SqkvRt_GcpuGH_g5PjtQiBkwtOsA@mail.gmail.com>
In-Reply-To: <CAGm54UGmp=kTKGLhEfENF4SqkvRt_GcpuGH_g5PjtQiBkwtOsA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3213:EE_|SEYPR06MB6035:EE_
x-ms-office365-filtering-correlation-id: 84d62f44-25d2-4531-b384-08dae2f97376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubg+1NiWZgG/9S7+ePREfKj2VhkIAOOlRYcLGHHjwMh8jvdBMVQtNhvrv6mfGLW+SbFep3HXUOVp5d9SyPTVsNH8HK4Y2A0aLOIzx/Bk/JEZCKma35/vO2RaEjt5H1tXQS7ZNyVKhgaaaEKKT6LJVcUMiKEk7Oh0NuV+H8acsjVC0btk1vyNGfMOHivjrmCxdTaaLGB8oakc4JDebrL/5bnJdEVkCxLfr5mM/4l3MOSSdry1oVTbSQ7sVxi2oSmo5mw4/OjAH7RPYdYQmJr0d8najt7vMxwNZMRAg6TiryDRa6gZlU7EVIu46HcvaylCmMkBoeVhP5sajicUeRKS0FfIuBhgh8mpHPWPd0hnNk8JgTQRTw20hUJm3+G9v3bmPMShURu7EV9RC/k1B+vD2Hr7Ih9nZh26yOjwAFLx9N8vQKZ/pDq/o8OnYOSTKvmTsQw7LvFHEavpydd7AP2KMfwt2RM/K3TNNbA1IhoilUirE8ryj56kTX2vsYxa3eut8WYI893pDG33SPW5YplBGWYHisRM3mU39e2WUYS//ZZRmnJa0MNpRvxaHYKBJgtJa4hNIe7Bkkiwf9+/DTKaMvoy3O3TyrJv5qMlEZiFWVEh3IkUfNQ7u+ymPGmXESrz05Cm/2hza3xjH2UEXKCOR/0c/iy/MYIruTr0ttMvTbFM6GB73Ew9546ynEwSixLnaGftTGcauaTKCdHN4E8MZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39850400004)(376002)(136003)(346002)(366004)(451199015)(5660300002)(7416002)(33656002)(71200400001)(55016003)(83380400001)(38070700005)(38100700002)(2906002)(122000001)(52536014)(110136005)(41300700001)(8936002)(66556008)(26005)(4326008)(66476007)(66446008)(8676002)(64756008)(66946007)(186003)(86362001)(6506007)(7696005)(76116006)(107886003)(9686003)(316002)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VElzUGR4Rk11TXVwbHZhZHhDc2FQOHkrOW0zSDBkTWR1WVd4VWVTbFI1dXY4?=
 =?utf-8?B?eVRsb3Z1V0h2bGIvQVp6dE02dVZBaFJaSkZXUktKWFVnMG5WNHRCcWtLaVNP?=
 =?utf-8?B?Z0lPb2tLSkRsZDRESkhrdm9GUjFxelcxSHpsb1NKOVVZOU1PcU9QZk9CMkRW?=
 =?utf-8?B?Z0MxVkhrREZ1dDFlZHF0SldkRkJiN20zRzZQclVVTCt5WllTYTZFK3FoVmht?=
 =?utf-8?B?NERJL01ZTWpRNWhwU2dmc1ZHV2tYZThNOXJ4WEF4eW1OSUpzWkZmYWNRa1V1?=
 =?utf-8?B?RGZYRlMyYy9sODZaQmRxQkRrZHpsdmx4RTVOMkNvQVptQXIvSC85ejBGQkVq?=
 =?utf-8?B?cks4VjBDaUw1clVJSUt1UWN0cmIwdUdTYzdPUzJrNjduNUlKYlRhT3Z4Mjd3?=
 =?utf-8?B?bWZrOXEwQnU0emtNZ1EyREQvRTB6U25md0g0TWQwZHhzTFNDZ2dXbVBtd0x4?=
 =?utf-8?B?SGtFYlFoTTdleWkxRjlIZ1JBRjIzVVNRZFdudGNPSHpaMFJibFpqMWRwY2hD?=
 =?utf-8?B?MlNpZXg0RnZxZ2E0TFE1MjZvdXl2ZUpOemdzQmJjRVh6ZTVpdTR3bmdLeEN3?=
 =?utf-8?B?RTdvak9XN2NkV29WK1FlWSt4MEw5K2xCVkgyb0RCcWppVllyUXZqYSt3MjdV?=
 =?utf-8?B?b0ZkZ1ZvbE1GSmF5bEVjclY1R2lxOTFMN3BtVlNqNkZLcDVtcDJoNU1xWW5i?=
 =?utf-8?B?MjdmVHNVcDZuc3BYR0FiYXFLQ1luZEdUNUYra0J1cEwwT0ZGMkwyYUhNMmNL?=
 =?utf-8?B?YWl4cVhvMzVwN3NVc3RmSDhVTFI3SStldGNYNG1pS1FKYlN0T2ZxTGtaeEZz?=
 =?utf-8?B?dWdNTHRXODgzNXgrV0lLY3JmZlpRUFIyQTQ3UkFTamlRSTZLQ0kvbGxaMUNp?=
 =?utf-8?B?NWQyZDV1dE5JRGdQSmE5dFU1RWdKQkxlVXQ1Y0g2RFR2aEN0UFJoaUdydUhr?=
 =?utf-8?B?NkthV0hWUStrcHl3T0tVMXF1Q05kNXpoNUdzT05rK0ttUjVMRjUvL3E4Y3Jr?=
 =?utf-8?B?Mk8wdTd1cHZQV1BaQlUvWTBTVG5hRStIZTQrMnNNS1RKN0dpeENmeGFnSXNL?=
 =?utf-8?B?TS9HY3ZYTTNFbVpwbzNqdTRRMlZNMStybDVIaFlJc2g2NTl1MzdPVWh3REQv?=
 =?utf-8?B?RnMwQ2tiNXVUeE9nRUZmN1g2c2tQYTF4M09yYXJOeTBoQXhTWWp5cm0yVVZh?=
 =?utf-8?B?OGNSbXhPeUxHR0V1ajhFNGFVaDlQMUIrRTVxN3FDSHZ3dkpQUXE3TkdPZnF2?=
 =?utf-8?B?dW1xb2ZxT3VGbXVKeThFcDRuWmJldUd1b3NLcHVPYlpzQTBJNzFUcGFkOVRk?=
 =?utf-8?B?RGUzVit6eG53am9WaTFBWWF0WDFVMktyMHc0NldLQ2o2UWJiSWpGaFF0bGFZ?=
 =?utf-8?B?QkhlVGZYS1hFY0ova1lEcGt5NStnNjFCbGRmc0RTYnlERmN3VVZRZG5HK0Zn?=
 =?utf-8?B?NnhEWHE3cWZQNzY1REhJZmNWU0EvbGZrWTF0d0MraUVIOFM4TmU4NlFGSTBL?=
 =?utf-8?B?dnNKbkFBRU5qdGI1ZExubUZnU2hxelRSQkJqT1ZXWXEydXpaR3cwN3dnY0hy?=
 =?utf-8?B?bThoeFd3R2NRVk5LbUZwNTY2eUY2c3NwQlU3N1AzK01VZ2ViaW9lTGF0Si92?=
 =?utf-8?B?Z1FGL0ZtaDkvb0ZiR0dRVDVrM1k0SEFhc3EyRmhtdXhNL3lEOC9ZbUdSN2hF?=
 =?utf-8?B?eHFGRFY2YTNQOEt4TkZCelE0a216TVp1YXZ0NHJkZUdzc0JvZk5oSGFtNU5Q?=
 =?utf-8?B?WjYyS1ZqSXZDNDlpUmpqcnVzTnpmUXRVRTFmbE9nSVNzN1dWMVJUbGdScmIx?=
 =?utf-8?B?eHRsV2hNWktqOVZ5Tk5ERGxTT0l4Nk5aUkRkMTBmM1BDZDV3ajRLMkpTak5y?=
 =?utf-8?B?WXhFVVU5R085VjJvM29IMFpLS3BlcnpzbGl4WmZ4VStwM3VPcGcxRFZwelJO?=
 =?utf-8?B?ODBWQ0d0VUdRN1pqaVFLOXYydE5BaGVRRkFqU0xGTjlYa0lkblB2ZG03VXVw?=
 =?utf-8?B?VjJlSGF5dzdyMzhIRUZYdmtkbm92bityWHdHcDNXSVV1Qk83WFVQeXBKb1ov?=
 =?utf-8?B?NjBXbnpTcmNERm5WQkllZU1RK2JDWC9mUFU5ZSsxQTUxWHNOMTJhRzREN3JN?=
 =?utf-8?Q?g/y3f2X9aX9R7NInay38ZXX1Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d62f44-25d2-4531-b384-08dae2f97376
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 02:17:03.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Leru823eMT2Wr984unw3JAKwFZPp2/zds1C+zI8eEXoYiI3ZN+INA6Kanzf6Z+fTl/ObsWFQJzP82bGVOo+f5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6035
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IE9uIEZyaSwgT2N0IDI4LCAyMDIyIGF0IDA5OjU1OjU3QU0gKzAwMDAsIE5lYWwgTGl1IHdy
b3RlOg0KPiA+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQo+ID4gPiA+ID4g
PiA+IEkgdHJpZWQgdG8gcmVwcm9kdWNlIGl0IG9uIG15IHNpZGUsIGFuZCBpdCBjYW5ub3QgYmUg
cmVwcm9kdWNlIGl0Lg0KPiA+ID4gPiA+ID4gPiBIZXJlIGFyZSBteSB0ZXN0IHNlcXVlbmNlczoN
Cj4gPiA+ID4gPiA+ID4gMS4gZW11bGF0ZSBvbmUgb2YgdGhlIHZodWIgcG9ydCB0byB1c2IgZXRo
ZXJuZXQgdGhyb3VnaA0KPiA+ID4gPiA+ID4gPiBMaW51eCBnYWRnZXQNCj4gPiA+ID4gPiA+ID4g
KG5jbSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXZSBhcmUgdXNpbmcgcm5kaXMgaW5zdGVh
ZCBvZiBuY20uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAyLiBjb25uZWN0IEJNQyB2aHVi
IHRvIEhvc3QNCj4gPiA+ID4gPiA+ID4gMy4gQk1DICYgSG9zdCBjYW4gcGluZyBlYWNoIG90aGVy
IChib3RoIHVzYiBldGggZGV2IGRlZmF1bHQNCj4gPiA+ID4gPiA+ID4gbXR1IGlzDQo+ID4gPiA+
ID4gPiA+IDE1MDApIDQuIFNldCBCTUMgbXR1IHRvIDEwMDAgKEhvc3QgT1MgY2Fubm90IHNldCB1
c2IgZXRoIGRldg0KPiA+ID4gPiA+ID4gPiBtdHUgdG8gMjAwMCwgaXQncyBtYXhtdHUgaXMgMTUw
MCkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBOb3Qgc3VyZSBpZiBpdCdzIHJlbGF0ZWQsIGJ1
dCBpbiBteSBjYXNlIChVU0Igcm5kaXMsIERlYmlhbiAxMA0KPiA+ID4gPiA+ID4gT1MpIGl0IHNo
b3VsZCBiZSBhYmxlIHRvIHNldCBNVFUgdG8gMjAwMC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFVz
aW5nIHJuZGlzIGlzIGFibGUgdG8gc2V0IE1UVSB0byAyMDAwLCBhbmQgdGhlIGlzc3VlIGNhbiBi
ZQ0KPiByZXByb2R1Y2VkLg0KPiANCj4gVVNCIGVjbSBpcyBhbHNvIHRlc3RlZCBhbmQgaXQgaXMg
cG9zc2libGUgdG8gc2V0IE1UVSB0byAyMDAwLCBhbmQgY291bGQNCj4gcmVwcm9kdWNlIHRoZSBp
c3N1ZS4NCj4gU28gSSB0aGluayB0aGlzIHBhdGNoIGlzIG5lZWRlZCBhbnl3YXkuDQo+IA0KPiBA
TmVhbCBMaXUgQ291bGQgeW91IGtpbmRseSBoZWxwIHRvIHZlcmlmeSB0aGUgVVNCIEVDTSBjYXNl
Pw0KDQpIb3cgdG8gc2V0IE1UVSB0byAyMDAwIG9uIFVTQiBFQ00gY2FzZT8gSSByZW1lbWJlciBs
YXN0IHRpbWUgSSBjYW5ub3Qgc2V0IGJ5IHVzaW5nICJpZmNvbmZpZyAuLi4iDQpSZWdhcmRsZXNz
IEVDTSBvciBSTkRJUywgSSBhZ3JlZSB0aGlzIHBhdGNoIGlzIHN0aWxsIG5lZWRlZC4NCg0KPiA+
ID4gPg0KPiA+ID4gPiBQbGVhc2UgTkVWRVIgdXNlIHJuZGlzIGFueW1vcmUuICBJIG5lZWQgdG8g
Z28ganVzdCBkZWxldGUgdGhhdA0KPiA+ID4gPiBkcml2ZXIgZnJvbSB0aGUgdHJlZS4NCj4gPiA+
ID4NCj4gPiA+ID4gSXQgaXMgaW5zZWN1cmUtYnktZGVzaWduIGFuZCB3aWxsIGNhdXNlIGFueSBz
eXN0ZW0gdGhhdCBydW5zIGl0IHRvDQo+ID4gPiA+IGJlIGluc3RhbnRseSBjb21wcm9taXNlZCBh
bmQgaXQgY2FuIG5vdCBiZSBmaXhlZC4gIE5ldmVyIHRydXN0IGl0Lg0KPiA+ID4gPg0KPiA+ID4g
PiBFdmVuIGZvciBkYXRhIHRocm91Z2hwdXQgdGVzdHMsIEkgd291bGRuJ3QgdHJ1c3QgaXQgYXMg
aXQgZG9lcyBvZGQNCj4gPiA+ID4gdGhpbmdzIHdpdGggcGFja2V0IHNpemVzIGFzIHlvdSBzaG93
IGhlcmUuDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB0aGUgaW5mbywgR3JlZy4NCj4gPiA+IElm
IHJuZGlzIHdpbGwgbm8gbG9uZ2VyIGJlIHN1cHBvcnRlZCwgaG93IHRvIHVzZSB1c2ItZXRoZXJu
ZXQgb24gV2luZG93cw0KPiBPUz8NCj4gPiA+IEZvciBteSB1bmRlcnN0YW5kaW5nLCBuY20vZWNt
IGNhbm5vdCB3b3JrIG9uIFdpbmRvd3MgT1MuDQo+ID4NCj4gPiBybmRpcyBzaG91bGQgT05MWSBi
ZSB0aGVyZSBmb3IgV2luZG93cyBYUCwgd2hpY2ggaXMgbG9uZyBvdXQtb2Ytc3VwcG9ydC4NCj4g
PiBOZXdlciB2ZXJzaW9ucyBvZiB3aW5kb3dzIGhhdmUgbW9yZSBzYW5lIHVzYiBwcm90b2NvbHMg
YnVpbHQgaW50byBpdA0KPiA+IGFuZCB0aGlzIGRyaXZlciBpcyBub3QgbmVlZGVkLg0KPiA+DQo+
ID4gQXMgcHJvb2Ygb2YgdGhpcywgQW5kcm9pZCBkZXZpY2VzIHJlbW92ZWQgdGhpcyBmcm9tIHRo
ZWlyIGtlcm5lbA0KPiA+IGNvbmZpZ3VyYXRpb24gYSBmZXcgeWVhcnMgYWdvIGFuZCBubyBvbmUg
aGFzIGNvbXBsYWluZWQgOikNCj4gPg0KPiA+IHRoYW5rcywNCj4gPg0KPiA+IGdyZWcgay1oDQo=
