Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3195EEA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiI1XQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiI1XP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:15:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52928F5B3;
        Wed, 28 Sep 2022 16:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuPmErypt1z2PmdjeZpl7m9fN1N03KLkUcyjSRclC1W/gmKb7YZiM0yDztegxOE6R7yhgGqUDrayRCqENN+XUjpRk/u9WT4zMmH9O5MsfnRoFFjPR1DYq/Gvl+0YybzClQakAwzn0mF2dHUopmUTUG5TVK4giiybUQf3UESY41MtSt6bHBhNqVCer59LM5E902xv2SbSVjW2uRnDIG95aYEiRV3HKRoG9U0wnkoWMTCY7kBJLQG+ncpzGaEhoBzyntqL+Y+gblunz7ucTz2DXPSp7WffD9d231p3EbV4T45Y2YnXaHf7gkbPflApFDzOjaWhXy3ksLj2CODKcGAIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlP3REJmPQNwLzIrHsbZmvr3ut0sDsdBm45or6WPW7w=;
 b=FDkZR44NLrf3tKorkLGJ+V3rf20zUESM1rLOU25nR1ja5Z8dfjLE2DcEIfs3CtbyhVy2LriADkyfVAlnqeVRWaB/cy9JbheKk4LsoFRiZhbEPsVoAXsWPK4RaOBAE7lN+3wEhUFltAb6FXkawpm6EZ6Rstkip8m8g4LvpXlNyHSIhvYxA0cjiTsY94dAb/qsRBdOf6a1KTDVkOBPrPZfyh47CdX2S8cK2FmSqpsyOi8p1YQF3pT+d46kJTvaEplF5Tqn12zx9+9uE34QTcJiiFteZONZsQZVJls3DT+vJbwJuMSSgb/xpVi6Ty1l8KhwU+jPHy03Xh/OaxzholTdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlP3REJmPQNwLzIrHsbZmvr3ut0sDsdBm45or6WPW7w=;
 b=ajvxVivFZ/5AbbYydUhogibwd+aJmenn/xNJFhfQ1+wFY1LH7T+CkScDAEqNdf1XYD0QLBvQiXQBA0wMSScbkEFqHQaOoi+VsuUEFFNzVYxlY7H//E3dv/Gqsm9gmYkp0Xy64ThLWppSp5B+WKxxNAODOdKKjI83oBAiWfgP1xM=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by DU2PR04MB9145.eurprd04.prod.outlook.com (2603:10a6:10:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Wed, 28 Sep
 2022 23:15:51 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::91b5:8116:4735:b8a6]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::91b5:8116:4735:b8a6%6]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 23:15:51 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global to
 the SoC
Thread-Topic: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global to
 the SoC
Thread-Index: AQHYyVu7ZWZ+5HaopEeXyly5/MaOXK3tO1AAgAABOrCAAAWXAIAIGIkQ
Date:   Wed, 28 Sep 2022 23:15:50 +0000
Message-ID: <AM0PR04MB62892A07019165E14802DDCD8F549@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20220915233432.31660-1-leoyang.li@nxp.com>
 <20220915233432.31660-6-leoyang.li@nxp.com>
 <e27d295b-abbf-716c-5e0d-97dd63ce07df@seco.com>
 <AM0PR04MB6289919428F12CD125357D4F8F519@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <1db9ffaa-3c93-9e09-8966-73aba061f52e@seco.com>
In-Reply-To: <1db9ffaa-3c93-9e09-8966-73aba061f52e@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|DU2PR04MB9145:EE_
x-ms-office365-filtering-correlation-id: a077d0da-74a6-4ca6-9ec0-08daa1a7627a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A627wXYwMvkd2qAYyjA8r28JZ0YSRONQSZ+6Uu18k+8Bn3dxWdh+BzY+U4JwW1RSk3TPTgxrwtRMunDenDhxUJt3482SOTjitOYA9to1eAVoQBZcrQzoWw0lrECTvIrx1tZzjkLpniV09CYCGHXOB/cWkZxFWXpZ/rGnkePH+C9Zuc0iqypLrG77aGbU2xSNJZB1mn8BQ8Eus6+zIj+6d30Q3BS8VdbdWpHLAAwGNBIYf+6aV9mROfQLi3ofYzoLgsXUMtBvIpcXI1qTR/zKJLDEpM01fofwt+98mX2pIa5wZm5W0X9/qQsh7Q9M8jU5sU4gtTOOPTh5WvXK+tDa5IpYmA0UTXlc0sdRtNwen6yDVRwwqSb2xu/12uCf/SD6z/mnhg9sbgw3w0ktdDKHBcOwfNkxX52HQmCQB7fNWdnBkwGQZiqwyM5Cl94S/qbHKVVP0NC6lVGCu7D4Hg+rV9fGkBJadmnAN7syzLSTUZ9KBEqa9fyeLIZV5M1T4BsS3whRy+P/giVHuz2qySExZk2m15A49UkJdoU9rBNfDJmtb9QCZqtTAyD0iG1n4BayK5aX6mAANzSrg6nv84hkVhPOf5HjstwMl3TCYkAOqQ52NAbaeiLuqeO1vXdgRuxWC8WvL7VI1x5PiLM8I8Jwb3BAZklRms6emJ6PGIFlJdzhZIhgDDo1QIBxYqRb95ztToP/9qXz2k5K82QBzbANxg6SoU0Ua+7p2t4F1DPHaJAXb/ZczSurzfX1V8Zg59B7WOiqJLEz7GU4ASxZLi2kDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(316002)(54906003)(110136005)(7696005)(86362001)(8936002)(41300700001)(52536014)(33656002)(186003)(5660300002)(8676002)(55236004)(66946007)(66476007)(66556008)(64756008)(4326008)(76116006)(53546011)(66446008)(6506007)(2906002)(83380400001)(26005)(9686003)(55016003)(38070700005)(478600001)(71200400001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXZMSzZ6N0tyNURSaUVSZVIveExXeko3UTFHQWVVMFZWRnowNnFBb0Njbzla?=
 =?utf-8?B?UndGRUVKOWFDNFk3NktWSE9abkhlUEVFOUoxZTBFNlFLSmx1anU4MjBhd3NI?=
 =?utf-8?B?dzFjWllzbk1vRjE3L0w2V2tqdjNwVWJHUHBrQ3o1ZlFFcG05YXBpSHZFOXhL?=
 =?utf-8?B?R1EwZU5YclJnZlJGeDFsUG8xbnZRckowNnU3dC8vN2dPcVY3OWhBcVdoMWxV?=
 =?utf-8?B?RkxsaGlnZXdFMllhRGRsVTBUZDJqcHZVNENZRHBhNm9ISStPK0xyVjRWR2NZ?=
 =?utf-8?B?TmFKb3JZL0tzbTVodGUycThqbmJWQ0hDaUpkd0IrTWNLM1NQU2tmai96Y1Rl?=
 =?utf-8?B?bTUzMmVkZUlaQlAya2dTMGxRL2FFelhFT3hjKzFLbW9USGduMkhFVjl0V3RT?=
 =?utf-8?B?cVVUakU1T215TkhsYjRpblFUQWVIbTFUcTV2S2s2R2xtakhrc2tHTXhLZHJK?=
 =?utf-8?B?YTQ1czJ2L3g2RWQvRWU2NFptcnRhZktXUGd3SFZHcG9oT3F2bllRZnVYaVRL?=
 =?utf-8?B?ZGhxaUI1OTUza3RMRHJ1dzB1UVRRQjJyVmZvWitOV2lzV0k2cHJJcmZKb1Bt?=
 =?utf-8?B?V2RSK2pzU2dwU3hKSlZPRkNhcGpWOE13ejFNMXBDOWMySXpsQ0l2aFlKeDc2?=
 =?utf-8?B?VFRUY3hXdFoyTnRCVjlaL2Y0MlpJUzhidklzZDVlempaYVV4Skh5MGxkYWw2?=
 =?utf-8?B?VUdzaTQ3SjlscTI0VGEya0duNitCUjdwbmVvcS9sY29IbzZWUDBLejd5QTha?=
 =?utf-8?B?SXZWRDQyeFVsUFRoMExlYmtDVGc5Z1lwYXZPN1VIUDZLWWlqWmRHUXZrSnBy?=
 =?utf-8?B?UTJOanloOFpXelpOYlc5RDJIMnd1cFZNNi9rV2hBaWlVd0lTZFFpWTMrZXMv?=
 =?utf-8?B?aXRwdXpIanUrYmtMTU1vOTM2RmR4QlAwVTM2dVhKM3ROdWdPbHJWdkNsNlBT?=
 =?utf-8?B?RTZxcVAydGw1dXg1LzVwTVpHamFiYW54NzF0S1RnWTdtaFR3MDV0MDk2RWFt?=
 =?utf-8?B?cG9NenFxM0J0MVNycGZib0tsNisrcnljcmYzV0Y2ZXQ1VDJTSStyYk1hM1dZ?=
 =?utf-8?B?L1FJK0tsV0dDTzFqcWVtcUJRU1lxNVA0cEdkZEVrY1Y0cG0vK2MyOWs3Q01q?=
 =?utf-8?B?NnB3dWlJWmF1Z3E1ZU9WZGp4blc5N01vUFpoRzJpcUljWmtKRzRmYkhOVXM1?=
 =?utf-8?B?SWxyekxHdVM3U2JoVmFYa3lYMHdIOGppdnBySktpUGRlWi83MS9BVFg3cjls?=
 =?utf-8?B?S2FrR0tRZ0xBMFZBcmM1S2hLRHp3c0ljWitBd00rN2pBazlQRVh0M3kyUXMw?=
 =?utf-8?B?YlVoV0FUdkdHMVJGbnVTeDdqVDNSc2RVeHYvY3EwTnFaeGl1R3RkSzdPaDA2?=
 =?utf-8?B?dHdOUU9SZ2pYU2VMbFkvcDFEL0xZaTM3QmxZbmNOdVljRGRoQkFKMnVZenFK?=
 =?utf-8?B?UVgwREpIY0FCVWRKN3lVN2hCMHhnc1BtM2xqU2tGWVJQZ1FQeGdVQVNneGM4?=
 =?utf-8?B?TDVKVkNvekhJR1o5aHJ1V1ZKc0dzb2tLcGExUk9uTkFYUzJjL1VHMnlkaC9p?=
 =?utf-8?B?L25SOVpQSWRzdFNJc2t2UmhsdDg2S3JXSDErTFE5WjVCWWd1ZFk5VDUyRXla?=
 =?utf-8?B?Q2theFFmQ0Z0OXB3WUlGTzJsK01vQkxFSmRwUHFSRGtCdFZlK1JSVmEwNGVv?=
 =?utf-8?B?WFRRRjE0djI2YldrTWp5cW5aRjJwTkdJS1o4ZmxjT3o3aEtqY0gxVXpKOXR0?=
 =?utf-8?B?L2hXWkhFdXhSeis0eXVGYUY3dXN4YjVSUDc4Z05aN05zMnNjZVZZc2lzYkt6?=
 =?utf-8?B?THM4eDdwTFVYVXpsMS9ER2pScjUvSWhFczB3QVhvK08xZXlHdWhLVzI3T1h0?=
 =?utf-8?B?ZzBjd3cxT1YyV1BEQVpqdkhGNmd1OTBOc0hnUWJRK2dBQ2lwb1RVRUdNNmJM?=
 =?utf-8?B?ZUxSRHllTis1akZvbFk1am5ZMVR0ZDlOZktqRGNRT1ZpU0RzN1NtSWZrdjZG?=
 =?utf-8?B?aGV6MGp2aWZGYnhyajR5dWdPeHJnWVNsYVlKUjVpQzF4UGNhMllhUkc4Zzlo?=
 =?utf-8?B?b0g1L3dXdkNvOTRUeGcwT25pNnNzWUJsY1FQMXEwREpsd1R4bmd4VTl2VVJ1?=
 =?utf-8?Q?YaykjUeCZIg9k78QO6lYK4Xoe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a077d0da-74a6-4ca6-9ec0-08daa1a7627a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 23:15:50.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nYCo528hAObBKmFLSmKSq21l3TeJMFO4yPFb+CjIlzdpmdLH/+rBdVmZcCRuOC0MCflGMr6Fx1UjIdNAaU9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VhbiBBbmRlcnNvbiA8
c2Vhbi5hbmRlcnNvbkBzZWNvLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjMsIDIw
MjIgMTE6MzUgQU0NCj4gVG86IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgc2hhd25ndW9A
a2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHJvYmgrZHRA
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVk
b3JAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzldIGFybTY0OiBkdHM6IGxz
MTA0NmE6IG1ha2UgZG1hLWNvaGVyZW50IGdsb2JhbA0KPiB0byB0aGUgU29DDQo+IA0KPiANCj4g
DQo+IE9uIDkvMjMvMjIgMTI6MjYgUE0sIExlbyBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFNlYW4gQW5kZXJzb24gPHNlYW4u
YW5kZXJzb25Ac2Vjby5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIzLCAyMDIy
IDExOjExIEFNDQo+ID4+IFRvOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBy
b2JoK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExhdXJlbnRpdSBUdWRvciA8bGF1
cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNS85XSBh
cm02NDogZHRzOiBsczEwNDZhOiBtYWtlIGRtYS1jb2hlcmVudA0KPiA+PiBnbG9iYWwgdG8gdGhl
IFNvQw0KPiA+Pg0KPiA+Pg0KPiA+PiBIaSBBbGwsDQo+ID4+DQo+ID4+IE9uIDkvMTUvMjIgNzoz
NCBQTSwgTGkgWWFuZyB3cm90ZToNCj4gPj4gPiBUaGVzZSBTb0NzIGFyZSByZWFsbHkgY29tcGxl
dGVseSBkbWEgY29oZXJlbnQgaW4gdGhlaXIgZW50aXJldHkgc28NCj4gPj4gPiBhZGQgdGhlIGRt
YS1jb2hlcmVudCBwcm9wZXJ0eSBhdCB0aGUgc29jIGxldmVsIGluIHRoZSBkZXZpY2UgdHJlZQ0K
PiA+PiA+IGFuZCBkcm9wIHRoZSBpbnN0YW5jZXMgd2hlcmUgaXQncyBzcGVjaWZpY2FsbHkgYWRk
ZWQgdG8gYSBmZXcgc2VsZWN0DQo+IGRldmljZXMuDQo+ID4+ID4NCj4gPj4gPiBTaWduZWQtb2Zm
LWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiA+PiA+IFNp
Z25lZC1vZmYtYnk6IExpIFlhbmcgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gPj4gPiAtLS0NCj4g
Pj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEuZHRzaSB8IDUg
Ky0tLS0NCj4gPj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiA+PiA+DQo+ID4+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj4gPj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj4gPj4gPiBpbmRleCAyNzAzM2M1NThlM2UuLmU0MDY0
OTlhMjZiNCAxMDA2NDQNCj4gPj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHMxMDQ2YS5kdHNpDQo+ID4+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTA0NmEuZHRzaQ0KPiA+PiA+IEBAIC0yNzMsNiArMjczLDcgQEAgc29jOiBz
b2Mgew0KPiA+PiA+ICAJCSNzaXplLWNlbGxzID0gPDI+Ow0KPiA+PiA+ICAJCXJhbmdlczsNCj4g
Pj4gPiAgCQlkbWEtcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4MCAweDEwMDAwIDB4MDAwMDAwMDA+
Ow0KPiA+PiA+ICsJCWRtYS1jb2hlcmVudDsNCj4gPj4gPg0KPiA+PiA+ICAJCWRkcjogbWVtb3J5
LWNvbnRyb2xsZXJAMTA4MDAwMCB7DQo+ID4+ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLHFvcmlx
LW1lbW9yeS1jb250cm9sbGVyIjsgQEAgLQ0KPiA+PiAzNTUsNyArMzU2LDYgQEANCj4gPj4gPiBj
cnlwdG86IGNyeXB0b0AxNzAwMDAwIHsNCj4gPj4gPiAgCQkJcmFuZ2VzID0gPDB4MCAweDAwIDB4
MTcwMDAwMCAweDEwMDAwMD47DQo+ID4+ID4gIAkJCXJlZyA9IDwweDAwIDB4MTcwMDAwMCAweDAg
MHgxMDAwMDA+Ow0KPiA+PiA+ICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNzUgSVJRX1RZUEVf
TEVWRUxfSElHSD47DQo+ID4+ID4gLQkJCWRtYS1jb2hlcmVudDsNCj4gPj4gPg0KPiA+PiA+ICAJ
CQlzZWNfanIwOiBqckAxMDAwMCB7DQo+ID4+ID4gIAkJCQljb21wYXRpYmxlID0gImZzbCxzZWMt
djUuNC1qb2ItcmluZyIsIEBAIC0NCj4gPj4gNzk0LDcgKzc5NCw2IEBAIHBjaWUxOg0KPiA+PiA+
IHBjaWVAMzQwMDAwMCB7DQo+ID4+ID4gIAkJCSNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KPiA+PiA+
ICAJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPj4gPiAgCQkJZGV2aWNlX3R5cGUgPSAicGNpIjsN
Cj4gPj4gPiAtCQkJZG1hLWNvaGVyZW50Ow0KPiA+PiA+ICAJCQludW0tdmlld3BvcnQgPSA8OD47
DQo+ID4+ID4gIAkJCWJ1cy1yYW5nZSA9IDwweDAgMHhmZj47DQo+ID4+ID4gIAkJCXJhbmdlcyA9
IDwweDgxMDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4NDANCj4gPj4gMHgwMDAxMDAwMCAweDAgMHgw
MDAxMDAwMCAgIC8qIGRvd25zdHJlYW0gSS9PICovDQo+ID4+ID4gQEAgLTgzNCw3ICs4MzMsNiBA
QCBwY2llMjogcGNpZUAzNTAwMDAwIHsNCj4gPj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47
DQo+ID4+ID4gIAkJCSNzaXplLWNlbGxzID0gPDI+Ow0KPiA+PiA+ICAJCQlkZXZpY2VfdHlwZSA9
ICJwY2kiOw0KPiA+PiA+IC0JCQlkbWEtY29oZXJlbnQ7DQo+ID4+ID4gIAkJCW51bS12aWV3cG9y
dCA9IDw4PjsNCj4gPj4gPiAgCQkJYnVzLXJhbmdlID0gPDB4MCAweGZmPjsNCj4gPj4gPiAgCQkJ
cmFuZ2VzID0gPDB4ODEwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMHg0OA0KPiA+PiAweDAwMDEwMDAw
IDB4MCAweDAwMDEwMDAwICAgLyogZG93bnN0cmVhbSBJL08gKi8NCj4gPj4gPiBAQCAtODc0LDcg
Kzg3Miw2IEBAIHBjaWUzOiBwY2llQDM2MDAwMDAgew0KPiA+PiA+ICAJCQkjYWRkcmVzcy1jZWxs
cyA9IDwzPjsNCj4gPj4gPiAgCQkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4+ID4gIAkJCWRldmlj
ZV90eXBlID0gInBjaSI7DQo+ID4+ID4gLQkJCWRtYS1jb2hlcmVudDsNCj4gPj4gPiAgCQkJbnVt
LXZpZXdwb3J0ID0gPDg+Ow0KPiA+PiA+ICAJCQlidXMtcmFuZ2UgPSA8MHgwIDB4ZmY+Ow0KPiA+
PiA+ICAJCQlyYW5nZXMgPSA8MHg4MTAwMDAwMCAweDAgMHgwMDAwMDAwMCAweDUwDQo+ID4+IDB4
MDAwMTAwMDAgMHgwIDB4MDAwMTAwMDAgICAvKiBkb3duc3RyZWFtIEkvTyAqLw0KPiA+PiA+DQo+
ID4+DQo+ID4+IEknZCBsaWtlIHRvIHN1bW1hcml6ZSB0aGUgY29uY2x1c2lvbnMgb2YgWzFdIGJl
bG93LiBUaGlzIHBhdGNoIGJyZWFrcw0KPiA+PiBJMkMwLCB3aGljaCBpcyB0aGUgb25seSB1c2Vy
IG9mIGVETUEgYXQgdGhlIG1vbWVudC4gZURNQSBpcw0KPiA+PiBub25jb2hlcmVudCBiZWNhdXNl
IHNub29waW5nIGlzIG5vdCBlbmFibGVkIGZvciBpdC4gSSBoYXZlIHN1Ym1pdHRlZA0KPiA+PiBh
IHBhdGNoIFsyXSB0byBVLSBCb290IHRvIGVuYWJsZSBzbm9vcGluZyBmb3IgZURNQS4gRm9yIG5v
dywgdGhpcw0KPiA+PiBwYXRjaCBtdXN0IGFkZCBkbWEtIG5vbmNvaGVyZW50IHRvIHRoZSBpMmMw
IG5vZGUuDQo+ID4NCj4gPiBJIGhhdmUgc2VudCBhIFYzIHllc3RlcmRheSB0byBzZXQgZG1hLW5v
bmNvaGVyZW50IG9uIGVkbWEgbm9kZS4gIEJ1dCBhcmUNCj4geW91IHNheWluZyB0aGF0IHRoZSBk
bWEtbm9uY29oZXJlbnQgbmVlZCB0byBiZSBhZGRlZCB0byB0aGUgaTJjIG5vZGUgdG8NCj4gbWFr
ZSBpdCB3b3JrPw0KPiANCj4gSSBiZWxpZXZlIGRtYSBjb2hlcmVuY3kgaXMgYSBwcm9wZXJ0eSBv
ZiB0aGUgY29uc3VtZXIsIG5vdCB0aGUgcHJvdmlkZXIuIFNlZQ0KPiBlLmcuDQo+IHJlYWxseV9w
cm9iZS9wbGF0Zm9ybV9kbWFfY29uZmlndXJlL29mX2RtYV9jb25maWd1cmUvb2ZfZG1hX2lzX2Nv
aGUNCj4gcmVudC4NCg0KWW91IGFyZSBwcm9iYWJseSByaWdodC4gIFRoZSBwcm92aWRlciBkbWEg
ZHJpdmVyIG9ubHkgbWFwcyB0aGUgTU1JTyByZWdpc3RlciB3aGlsZSB0aGUgY29uc3VtZXIgaTJj
IGRyaXZlciBtYXBzIHRoZSBkYXRhIGJ1ZmZlciBpbiBtZW1vcnkgd2hpY2ggbmVlZHMgY29ycmVj
dCBjb2hlcmVuY3kgc2V0dGluZy4NCg0KPiANCj4gPiBGb3IgdGhlIHUtYm9vdCBwYXRjaCwgSSB3
aWxsIGNoZWNrIHdpdGggdGhlIGhhcmR3YXJlIHRlYW0gdG8gc2VlIGlmIGl0IGlzIHNhZmUNCj4g
dG8gc2V0IHRoZSByZXNlcnZlZCBiaXQgZm9yIGVkbWEgc25vb3BpbmcuDQo+IA0KPiBUaGFua3Mu
IEknbSBjdXJpb3VzIGFzIHRvIHdoZXRoZXIgdGhpcyBvbWlzc2lvbiBpcyBpbnRlbnRpb25hbCBv
ciBub3QuDQoNCkkgaGF2ZSBhc2tlZCBhcm91bmQgYnV0IG5vIG9uZSBzZWVtcyB0byBrbm93IHdo
eSBMUzEwNDZhIGlzIGRpZmZlcmVudC4gIFNvIGZyb20geW91ciBleHBlcmltZW50LCBjaGFuZ2lu
ZyB0aGUgcmVzZXJ2ZWQgYml0IGRvZXMgbWFrZSBhIGltcGFjdCBvbiB0aGUgZmluYWwgcmVzdWx0
PyAgQW5kIHNldHRpbmcgaXQgdG9nZXRoZXIgd2l0aCBpMmMgbm9kZXMgaGF2aW5nIGRtYS1jb2hl
cmVudCBlbmFibGVkIG1ha2UgaXQgd29yay4gIFJpZ2h0PyAgSWYgdGhhdCdzIHRoZSBjYXNlLCBw
cm9iYWJseSBpdCBpcyBqdXN0IGEgZG9jdW1lbnRhdGlvbiBpc3N1ZSB0aGF0IHdlIHNob3VsZCBm
aXguDQoNCi0gTGVvDQoNCg==
