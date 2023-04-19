Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315816E7C97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjDSO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjDSO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:27:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C9646A9;
        Wed, 19 Apr 2023 07:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB10lBS/h+OrHumKsV//aOD5ylsGvZPLRjeskycHQXhqV/bwj9Aer4ULnbUXNArX88/iTajMtTVRXD0kmH/E+RpLs/HbXJsSGv8oIfd0zhb1Yc6V78qJVx6m+dyB/gx85mQD3b3gTdnx0d3//YSJ25Zk0BKfs+A59tvLQMUzZACL/wdpj1DSik2LIzn3bO5IuvldYdHIEcovmbAGYRxIrv4YxI4vnAEaWClR8kmky4RMf7gmr9d2B2hVlyEKirAKCthEvtsIgorowaacINKE4bHVoiNjf8Ti/1T03pr1RQnt57KwcvedvJ3i3747BM/i6sKtNZy+BVOt/7Z08h7P+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR0hWVrHisqbyn0FmFmHVtMlH2dLz3ZgY9984sw82Us=;
 b=lpRiUruy1bNhItRHU+Fkb0flWgqQ2FBDDZiwmFBRtxTAQo5R7w8OLcT2Gvog7fLNQ2T8diaySnRWs6vJZutiu6+TnVGrxld+Ire0ZvPUwG0ncyU+qFIWaIKxtRdwWmahdXGwmM3q/qI6w+HI9F/tjByB4tQ3eq5p3MX5ZU0SJJK+Jw+0q5EzXhM1AifNg1uoU7MYtzRgjV9B8xFinBo71KSz0HVeiVrfzd8kHqDb3YDdhOcyg9U6sAytrXGtuNxN5kVL/sG0Ib9LHfgTW2XepGTVQ6BRf6BGn6B+qIl8v2YhgiuWzQ+zBPjxwXvguEOvBMv9m2BzvO8cCrFH9sIl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR0hWVrHisqbyn0FmFmHVtMlH2dLz3ZgY9984sw82Us=;
 b=Qx82X9vV7Kyg0t0voYfetkMRAcovRRfWIU7/HnybhlfsUnGQgQX/QfcG7+HZgQeIZml7sZ0D+9LI4CG0hal+EusV8LMO+pn8V3GVmmb66I5DULV9CkHoS7UdBz9wPvkYsgrPw605JX0DiOaAEQpd90w/Wctn7eXOEwXOdxgXr0g=
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12)
 by AM7PR04MB6983.eurprd04.prod.outlook.com (2603:10a6:20b:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 14:27:12 +0000
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6]) by DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 14:27:12 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Rohit Fule <rohit.fule@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Enable flow control before
 checking boot signature
Thread-Topic: [PATCH v1] Bluetooth: btnxpuart: Enable flow control before
 checking boot signature
Thread-Index: AQHZcssH+3vm5mi720ClsPUSFsajiA==
Date:   Wed, 19 Apr 2023 14:27:12 +0000
Message-ID: <DU2PR04MB8600144320EEBF932E93D647E7629@DU2PR04MB8600.eurprd04.prod.outlook.com>
References: <20230419090346.1671130-1-neeraj.sanjaykale@nxp.com>
 <8453180c-a223-1576-4016-b9a350ee6698@molgen.mpg.de>
In-Reply-To: <8453180c-a223-1576-4016-b9a350ee6698@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8600:EE_|AM7PR04MB6983:EE_
x-ms-office365-filtering-correlation-id: 72ecec31-8868-4a19-92e0-08db40e22a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zW8WRza7MNcBCXLiIqwvkZIxDYPCJLC5vqJ4D+JEFi0UTeQ70HKv2tTl1vrZj0BIbKSEmQdbjr4loVkZ9jQJom7lww3kWsvK7PQHYFfw8iNKFpVrj2suj27OXCHcSEBLyjFayFDzvKWZFbbKU/kLTodW/PEyEurJGjHYrd3ZP1sKNlnUG7uqXuWlMCTBVPZIJLhhzQdA0qCWUmeSYrwREmoUkH1xTinY2gRJECgeI8BoANPl9fwRY+oSbVsPX+p46GvZ4v+dL4GuYda1GDmzjOyR/moT7xwCzh2rLSa+vdwZaZmcxk3lGmGlHeBDgtY4j0XCR6vjyKEBcm/wWIz2ME3d3l9GU7xcJUD/PjAO8ZUIItM/MM05ScOhBf7i3KqM1/6+O2Aj0cSUWibSAheez96TVneqNauRMb4CYSZZURPZez3Ar0VZZAbEUgPrgwZ4jjNFw0ROS3c3aituLeZCqD+nMtN0TX7lrudWxZN4hXhSK53q4uPiWwR+6awiPjnv6lm6BxsegiKpn0jEJ1EINGI0iW5XtIVeudAElpN51TuvqxRJa1+nLSY/7qPSnLiYc9qkk4U1kdTq32MBtU7T2nuQVlJl1AUcaKIpJgy8eIEd+joctEy0q2co8qQuhnx3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(4326008)(52536014)(5660300002)(66556008)(41300700001)(54906003)(66946007)(64756008)(2906002)(8936002)(76116006)(66446008)(8676002)(66476007)(316002)(6916009)(71200400001)(478600001)(7696005)(6506007)(9686003)(26005)(186003)(55236004)(4744005)(83380400001)(122000001)(38100700002)(33656002)(55016003)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNLdVVPTFh1U3RpczFhb2ttUzl3TVFrTE9DZTJlclY4aWpSTWRWWkVhNnp6?=
 =?utf-8?B?YzNtVlptNE1QakNKZi8rSTFUeThzTnR1eFB6WVhKSmhyeHVCcldsODlWSGlJ?=
 =?utf-8?B?NjRqaE5RbWV1VmZLeUtCZFZkR3VPVzJ4Rms4czF6WHJCenI1UTFxa3RnY1Fm?=
 =?utf-8?B?R3JrOGN0WE9yUUlNL0Z6NitWWGVPbnBVaGNrWGJrbDRBTndSVUdteXpDVm9Z?=
 =?utf-8?B?NjFkeDVyOHdvdTFnbE9kVVhJek56NTJDUjh1UWpxMkVOd3p0MmJ6WUN6RUg1?=
 =?utf-8?B?b3BRT01IbDFVbDdkV240b0k4R1ZkbzdnMzFMMm9oL3dYQzdaWkxhM1p3M29X?=
 =?utf-8?B?U2w1eWRnSWZidS9rbDVVZDl5NUtWRVQzUkJseWkreHNzYXRRSjZOUEtzdENr?=
 =?utf-8?B?UWJKWDRJUWo4N0dSTkxXdEhOZi93TWE4YXBMazR6WEg0NFZ5OXF5NEU5VzRT?=
 =?utf-8?B?enFUQklZdUtxbVhvSnlDd3RZa0tSMThHRG9NQ2x4S1J1UEF4SHhXaVVKTDRD?=
 =?utf-8?B?c1RxanFOdmtTT2FNOTRnaDFVL2lwV1FxVk0wT1k0TTBkcHRQUG9ZWEFsRCtm?=
 =?utf-8?B?QUpnOWgxOUlkV3lTNFozSktKaXJzdjg0cUNmUi94UkFtWDdQa2p1dDZ2cnZq?=
 =?utf-8?B?OGlwbmRQOWY3OEZ3MmdFbjBVeHhvbmduV0FXWmR1ZzR4YUdDMm1ZNXpTcUxC?=
 =?utf-8?B?NkRub2ZRNDE4ZGpLZUM0bnYzV2syRmRTRmw4U2lBMU4vNldCbWowSWJ6UEtS?=
 =?utf-8?B?S1NoSXJWdk5hWXo0cWlUOU55L2ViejF1cExGSWFnNVJDNFhwNTV1UXBINHh0?=
 =?utf-8?B?bXJNcGRnekFKcVljU25TQkNXRGRVd1BOSWZVeFBWZ2toSW1QVlM1TCs3NjdT?=
 =?utf-8?B?ci9FQTdXaDlDai9vYktxUTgvbzBOa20zZTFjZHp6OWFHR2VNUWhJZi9keEVY?=
 =?utf-8?B?aXNMM0N6NFhuRVh6OTQ0MzMvSkF1dlk3cXlOZEtaM09meE5nbm93eWlQVDZZ?=
 =?utf-8?B?bGxKWVZubFVnM3lUWG5kcTN5azRGNlBFVFRsOFpodElSRnI2RmJsSVQ5eTU3?=
 =?utf-8?B?c1lEU2JYVGlFVnBuZ2NHVldEUjg5eGdPeFN3U1ppeXMzNy85YVE4dS9KSnc3?=
 =?utf-8?B?ZE9SRmtOdk40dFhjK3B4aHZPWXBtWTVtVit0QTJ4RG5GZi9PbnlwNVZQS2JV?=
 =?utf-8?B?cU91UFBWT1QyQkRRT3NMcitFbXZDa281bnRKWndTOTJRM2prZUNIN2w5YU10?=
 =?utf-8?B?YTZUYnl1aVoxTVZXMGxkaVRsL0hyVU5FbG5CWVIvQ3NLYlM4Z3IzWjZGQXlS?=
 =?utf-8?B?QWRCbnJLYVR6MndnQWN5LzUxdTBvQktVQzdXbHdMclZHbGJ5dWVWelRrSkg1?=
 =?utf-8?B?QlhyV3UvQ3ZzSDdPalVIQ3BlWHdSTmI1d0tDOCt2WnlpZTBPMVl5VER2Rjli?=
 =?utf-8?B?KzBzTXpPazZWZUxCMDNaTmtHcHlKaUxyeDZEZ0F3R2Q5OWo3eGhSdWxvbGlr?=
 =?utf-8?B?dmFIVlhRNVNEMmpPeUlhN1FDSnJoYzlKamQ4WUFlazNVQS9wN1BsMmh1djNj?=
 =?utf-8?B?c2FLR0dYYTJUKzFtc2RqcTNDRHlOK29Mb0t2NmJOYXIzNnVtQnlzRURKSklC?=
 =?utf-8?B?dGhwSVlDMTdtUlJRZkZJTG43V2ZtR21qV2ZSKzBITExLVjd2WTczYVQ3YlNO?=
 =?utf-8?B?RGFRTmRkOVg1Q0liQjFQeStMKzZQNThwWksweGhCS0JiUkhyanlhczdMT2Ni?=
 =?utf-8?B?VEI5dHo2VzUrNnV4UTJWcFVIdjlwVW9kTlVtNGZkeDR5WkMzZGI1SEtYcXpI?=
 =?utf-8?B?TVhjUFRUTFBMQkVKTU1PZUZtK3dJL3RhL2FRKzlBWkZEOEtrUkozZUt5eUo3?=
 =?utf-8?B?YmRJSU1hS1BIckVnTkJyYlpXa1BrVHhWYmxmSVNCQmF2UGU0SlIzUktBVHcw?=
 =?utf-8?B?S00vdk0xMUhFeUZqYnVNN3BGME8zb2Jsb1BnSWlBWDNQT3NJL0hLRCtyM1RV?=
 =?utf-8?B?dE1PWUZTUTQ1d0psL2s3SGtXZFNzT2NkNUM5WlRON3BSZzc2bjQxdjZtRkM4?=
 =?utf-8?B?MkVhR200V2xGQWdLano3ZXN4WE5STVFBeW40WkxjY1ZHbjJ3dkNJZzFtc0Vx?=
 =?utf-8?Q?nnxRVJShbqENC0te7dq/o3cv+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ecec31-8868-4a19-92e0-08db40e22a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 14:27:12.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70QfC0p6z6dWGBE+CJmDaMKLlpcORa6Ym8d3NUkuvQ1BqUO+M4JYOiLGAv+YwTiJr6GLolvgCUCweRIAoxsCzRwz6EVGvznw8NCXsy5E6Ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6983
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCg0KPiA+ICAg
c3RhdGljIGludCBueHBfY2hlY2tfYm9vdF9zaWduKHN0cnVjdCBidG54cHVhcnRfZGV2ICpueHBk
ZXYpDQo+ID4gICB7DQo+ID4gICAgICAgc2VyZGV2X2RldmljZV9zZXRfYmF1ZHJhdGUobnhwZGV2
LT5zZXJkZXYsDQo+IEhDSV9OWFBfUFJJX0JBVURSQVRFKTsNCj4gPiAtICAgICBzZXJkZXZfZGV2
aWNlX3NldF9mbG93X2NvbnRyb2wobnhwZGV2LT5zZXJkZXYsIDApOw0KPiA+ICsgICAgIHNlcmRl
dl9kZXZpY2Vfc2V0X2Zsb3dfY29udHJvbChueHBkZXYtPnNlcmRldiwgMSk7DQo+IA0KPiBJdCB3
YXMgZXhwbGljaXRseSBkaXNhYmxlZCBiZWZvcmUuIElzIGl0IG9uIGJ5IGRlZmF1bHQ/DQpGbG93
IGNvbnRyb2wgaXMgZGlzYWJsZWQgYnkgZGVmYXVsdCwgYW5kIHRoaXMgaXMgdGhlIGZpcnN0IGlu
c3RhbmNlIGhlcmUsIHdoZXJlIGl0IGlzIGVuYWJsZWQuDQoNCj4gDQo+IEFsc28sIGlzIHRoZXJl
IG5vdyBhIHJlZHVuZGFudCBsaW5lIGxhdGVyIGluIHRoZSBmbG93IGVuYWJsaW5nIGZsb3cgY29u
dHJvbCwgb3INCj4gd2FzIGl0IG5ldmVyIGVuYWJsZWQ/DQpZZXMuIFJlbW92ZWQgdGhlIHJlZHVu
ZGFudCBsaW5lIGFzIHdlIGFyZSBub3cgZW5hYmxpbmcgZmxvdyBjb250cm9sIGluIG54cF9jaGVj
a19ib290X3NpZ24oKS4NCg0KPiANCj4gT3RoZXIgcGxhY2UgaW4gdGhlIHNvdXJjZSBjb2RlIHNl
ZW0gdG8gdXNlIGB0cnVlYCBvciBgZmFsc2VgIGluc3RlYWQgb2YgMS8wLg0KQ2hhbmdlZCBhbGwg
aW5zdGFuY2VzIG9mIDAvMSB0byBmYWxzZS90cnVlIGluIHYyIHBhdGNoLg0KDQpUaGFua3MsDQpO
ZWVyYWoNCg==
