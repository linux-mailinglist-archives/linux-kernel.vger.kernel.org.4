Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23B85ED947
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiI1JjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiI1Jik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:38:40 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150087.outbound.protection.outlook.com [40.107.15.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608B6C13F;
        Wed, 28 Sep 2022 02:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuB5U8QTffNs+lRmpE1ea8MMDA42/40VfrJrieVLepBH1hbkARcZYCueMe1gykVVqjh0c63BD1AkJPgUOVVry9jZyraLV50um0db1FZwnR83zS7Q+K2Jla1PciRmg8l5zqo3uCxjbUrXp8xHnL8iYKvkspNJKQOmKpkBDAXHqHcMu1VMKz6rKE04aFVcpbw/lZMQ5mJ745bXkOPGLO6XSUyAUl149T8YHa+cbnsBuG5OWdy0K+ZcdyIxJJnSDi/2JpOK/ZOHA9cJkRQJHxTQyOH1Q6ZrR9QOwVuFHGDg77M5gUpPgt5xkdGY+1LxNM2jeRNOjCTUIVVSoI+i43wX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QocvPFBYWkF0e9M4ZZRsDP1t0m5zSi+CC2uirqWU8Xw=;
 b=TY6PBL0neGq1h8nRNGdV0FDWphYFHAUWr0xnkFNNiqD6INOC+FzyWIYRYh0GUcU+JlZe/fwuXEwtcCywRZUUi+lJOzELAEQDM/yXdg28AnYsunRPporZsoe9sjk5FQKavVTmQVURfvsazM7pH+YyH194f19ij+h5b1H9GwefG8yzJCPOrZfgAl30+FAjc6rajJP0let7azW99lzkUWJMUfIJyLT0QTWwDZoF6A9G8sK6CyM3LFNLKu/nrPbqZA1TPhWA/Y+t9NpBDcNjuyuKnL1CpED9Cj1xaEEhTfEzAhGIDoZ97iKWwsIwCrPzYJRkaI04HPJqO2esejp4jAnbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QocvPFBYWkF0e9M4ZZRsDP1t0m5zSi+CC2uirqWU8Xw=;
 b=SMdZLlGtdBInMQ74lgOad7YwRA3pQrDIKCWjEVhJ6d+x+cH3FvEcuOb96Zd4jmTR22EHuzNx1KyD/BPx0NafnGOS7kDXvTwPd9qpCVBZssRhC5u7ULn5TbR0KgE9nXyN/EU8lWfx8obJguvsIL9ENXOjo2Dm6sToaGy6f48rOxw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 09:37:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 09:37:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 02/11] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
Thread-Topic: [PATCH v3 02/11] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
Thread-Index: AQHY0h1DR0PLZqSNjUmEz7QjtYBTv630bBYAgAAmFICAAANt8A==
Date:   Wed, 28 Sep 2022 09:37:25 +0000
Message-ID: <DU0PR04MB9417859FA797126FE9BFDB4488549@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
         <20220927025606.26673-3-tinghan.shen@mediatek.com>
         <08abade9-f6f5-77cf-b83d-739b0b81543a@oss.nxp.com>
 <d16002714baf1eccb9b0ef5a2ae60e9b25194701.camel@mediatek.com>
In-Reply-To: <d16002714baf1eccb9b0ef5a2ae60e9b25194701.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB7103:EE_
x-ms-office365-filtering-correlation-id: a3044853-f32f-4fdb-1eb4-08daa1350d2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZcvymyQ8Um5FHhL74YEuopRyw9wFSyXQwP6kMxdagcJqTIRv8QiQF3wWmgiog3DIr/B5vP1DMhv84OwmrtgXG1in6MXkP7CdhzFspobxgir8oaDmJRSD546vvh6VRVEC7PV6szZ1jXs3uN7B7g3gjEemMgBPvuXs0BWAtqevgS1mot7+lV4L5F81smD6ds9ayIz1J2fSPl+mclPgXNtETDh+ozhiiQ5bfXMmHoYN6kpyWBkzHTpZILtTWk4mhFWs4rNxlDR8iDyOSBAEgOexBL5C/9dzq3JpGMhfyTD7gBlfXz82CSrNnXuT6h1WX2CNwEyJBDyOA2x/2YTiEkgjbcnpzFdKCvfnjhErEG9HI/9p7dL2FoGIGe3Q5kbMKerYfY/1oaPv8KQ1Pu6d03DnVuG28mv70ZLlRWpiZtNzHHaI7Sln3oY2dI4ipKBeZqY6Lal/hNNM40cauUYon9CDlGJVuh4Hncs4Pkh7n4vNkndDxC62ly4U1/YQUi5tJez5tJhela52ZX4fZcOxbzZP7SLunOAHt/0MsCIkAWvXShctv22ILAbKAusVp4j9Hzo6vtp1IYJ50ckb2HXKGbO6nq9TBfURyG7TUJ7svvKrsnaEEY8Vk27QSyGJ9Hn9motL+ja7T5LEMaxbl3c4ZZFqsv3TpT7J1GVlPE13XbFPkFHAoUZj2AKpI7JG951I/nxsvaC6zstgPrrSsjat+meo1cN4/uoTyPB2ebxsTplpq2/IfJ11+YuSAU4lCFjmUcAQd6F7K9biNI3jivpyf11T53WsxI14sUTybYqJyCk6MTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(71200400001)(83380400001)(186003)(6506007)(33656002)(41300700001)(122000001)(26005)(2906002)(8936002)(38100700002)(316002)(44832011)(9686003)(7416002)(66556008)(478600001)(66476007)(8676002)(4326008)(52536014)(55016003)(53546011)(76116006)(66946007)(7696005)(5660300002)(110136005)(64756008)(66446008)(921005)(54906003)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGZzaHhKZkVVd2dKTUJuNnc4Mmg1bFRzK0wwR2hkb3EvOXVkRzB1YWhSS3o0?=
 =?utf-8?B?QUFVWVE3MCtwRFg1WjI1RnlTcllyTkNOZStDRDhIRjBUWm03U0RKcDRVMUpL?=
 =?utf-8?B?c0QrRXg2RmdYcVhIM2I4TmxlcjhLN3QzVldtUzJSQnI4YmtmanJ2VHRvNW5x?=
 =?utf-8?B?dGRCb210QWV4V3hob3I3TkVQcTREaStEYmUydEJvRmhiN2lqa3drVVkzekM4?=
 =?utf-8?B?VFRjUzVPWGF3YnBVenhHOUovYUlWSGlhSWpJSkt0NFNPakNKc05JRDdrQy92?=
 =?utf-8?B?akppYkRPc0owSEQwcm44ZlpWSDdTVlpmdGczQ3BoYnhNa0VrajhuVnNFdkFC?=
 =?utf-8?B?ZjIza3VJWTQ2UjUvRjdrQkRJNFp3SHMweUJuK3hMTEs3T0pNM3RUQWdUT1RM?=
 =?utf-8?B?SW5qTmh3cHIraWFaR2R4OWd2WmdlMm9GdC9EK1VTbGJYV3duTXpYZGdQOCt2?=
 =?utf-8?B?cGRjZTVFdFY1K0pzOWU4eWxGWGZJUGNCSmU2UzMrME5JSnhaakJUQkRYWUIz?=
 =?utf-8?B?QXZ2eVlIRjRSYjFjaXYxcmJtTXgrd0J0R0d2WDVuaHRRMGk4TDlTOHgrQXQv?=
 =?utf-8?B?ZTJjL3pVUG9SeUFJSlZIcDh1cy9EeE9uQXBYK2hqOTJCN2h1d2pOaWJvNnRB?=
 =?utf-8?B?ZVh6VlMxblBTTVBMRDd3QVRGZm0zcmgvTkg2dWF1UlhaeEpCWHh6QkxIYzd3?=
 =?utf-8?B?VmhOaFltS0I3eDhPVjd6WGxKT2p2YldRZmlJWCtPZ283NjRkWGQ0TFJOaEVz?=
 =?utf-8?B?NHZCZlBFRyt5cFMza2h0MDB0a2lOcUdRNFp3RGQ4T1cvY1dQMktBNy9CNHRM?=
 =?utf-8?B?M3A5TXZ5K1RoM0FGN2RkR2VoS2tlRkt1QW5LbFB6YUdYa0VaNmgzcVBCNG14?=
 =?utf-8?B?MXRQVTZIUW1QcG0wU1BWcmJXWlZaSkJRbXlnVFV1NEpWa0ZrdkNqK3dJY1pq?=
 =?utf-8?B?cWZwYytFTWVsUlhZSHNsZnpMNnNnZWREQUdlTkIzWEFKdWhrTXJpVzlkVDZQ?=
 =?utf-8?B?c3ZYdkhHMXBFNTdTYzNnaXVsMmxnYVRycUtGbHh0ekNZYW1KRm5OL2hURjEr?=
 =?utf-8?B?RmdVaW0vVjBsTXVRMHJLUWliMVRIZjlkR2xsYnEyTnMyTTMyQUV3SEtKZFdh?=
 =?utf-8?B?WDZoY3hJaVJoa2E2bzZzcTF1bzIxTkVROXdXWVMwR0hHaU4xSXRGbGcweDlL?=
 =?utf-8?B?SERKblJRNVE2Znh3STZoTWpUdXZRWFNwWnFrdDh5SGVURXMwRjNESmxKcVpr?=
 =?utf-8?B?UTF3bnBsQVd0ZSt4aWlCMExmT3owN1BScXlTRWtKcHM3UklyQjdkajBVQTJo?=
 =?utf-8?B?QlhZRmthVHQ0UDVIbENPVjRNZXM1U0grQ3kyRFBTMFEvOVdUR0NSU3h6NTJ1?=
 =?utf-8?B?NUJDV2dqcEhjOE9xUHRHUEJkMnUrRFZuZ2FCVzlCZEpVL2tOU2hVVjFHV082?=
 =?utf-8?B?akdQR0dvenJvZ1NSNU84M1FLRzhJdDJWdWsxTjU0bzhpMysxTUxHV2VXTUI1?=
 =?utf-8?B?Z0FGTmVCSzU0NENnZFZ5ODNkaUxjYzBCYXN1dE5FTG1jVWprUjFKd3hUZVp2?=
 =?utf-8?B?MkdqSmYzTzV5VTJLQ05Id09DdW9NZTJRZ0tpUjg5S3NJM2FjNUFzRDZiNkVl?=
 =?utf-8?B?ZS9xVHdmWjFmL1BzTTFxbFJIazBsSSs4OVpUZGpoRGlHYUpvUjVZMFppNUpB?=
 =?utf-8?B?QlV2RzFOYXFDYTl0NUpDVGNrbHNlSUFyd3hMZDlaVjVnWEYyR3kzZ3VLZWZt?=
 =?utf-8?B?akU4UGdUQzNoRXVhV0VEQVd4R0Y3Vk1Ea2QrUmw0VVcvM2QrZFhwTFRWTk42?=
 =?utf-8?B?QjFRKzh2QUp5QWJiM0FGVG9vSlpJV3U4Mkd5cnpVVUZzQmVMNy9qSTJmZ0Fo?=
 =?utf-8?B?VUlUZVF6TEZxR2dteGpQL0RsbGpIWWhCSlErUUpCbEpSYVFlVDNlMTBqQmlR?=
 =?utf-8?B?MDh0MmxDR2ZTN2MyY2w2N0dpMnJNcWpoNGhoeGJhdGYzS1NvY3RHbG1VcUhm?=
 =?utf-8?B?c3A3Y3pJUWE2bmRnQ1V2Z01Felg5UWVvMklIaGZ1WlJUQkhJY3ZwZDh5LzB4?=
 =?utf-8?B?ZWFBVzN2QkFsdHQ3U2pPTTB3cno2Q2ppL1RmN2EvTEYweTM1blVWZnk1OEpj?=
 =?utf-8?Q?UPfo0AG5fH+2MQ0V8VtQXlR+A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3044853-f32f-4fdb-1eb4-08daa1350d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 09:37:25.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os8pwLcXLR0eBLF/LP9ITUjmJdJmjwpC+HGeCmpbbCXeHB+HlJwQCJbXhGpBIlyEqXouUzOpBU+kH6fM7dpBNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAyLzExXSBkdC1iaW5kaW5nczogcmVtb3RlcHJvYzog
bWVkaWF0ZWs6IFN1cHBvcnQNCj4gTVQ4MTk1IGR1YWwtY29yZSBTQ1ANCj4gDQo+IE9uIFdlZCwg
MjAyMi0wOS0yOCBhdCAxNTowMSArMDgwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4NCj4gPiBPbiA5
LzI3LzIwMjIgMTA6NTUgQU0sIFRpbmdoYW4gU2hlbiB3cm90ZToNCj4gPiA+IFRoZSBNVDgxOTUg
U0NQIGlzIGEgZHVhbC1jb3JlIFJJU0MtViBNQ1UuIEV4dGVuZCB0aGUgeWFtbCBmaWxlIHRvDQo+
ID4gPiBkZXNjcmliZSB0aGUgMm5kIGNvcmUgYXMgYSBzdWJub2RlIG9mIHRoZSBib290IGNvcmUu
DQo+ID4gPg0KPiA+ID4gVGhlIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgaXMgc2hhcmVkIGJ5IE1U
ODE5NSBTQ1AgY29yZSAwIGFuZCBjb3JlDQo+ID4gPiAxLiBUaGUgY29yZSAxIGNhbiByZXRyaWV2
ZSB0aGUgaW5mb3JtYXRpb24gb2YgY29uZmlndXJhdGlvbg0KPiA+ID4gcmVnaXN0ZXJzIGZyb20g
cGFyZW50IG5vZGUuDQo+ID4NCj4gPiBJIHRoaW5rIHRoZSBjb21taXQgbWVzc2FnZSB3b3VsZCBu
b3QgY29udmluY2UgcGVvcGxlIHlvdSBwdXQgc2NwIDEgYXMNCj4gPiBzdWJub2RlIG9mIHNjcCAw
Lg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBQZW5nLg0KPiA+DQo+IEhpIFBlbmcsDQo+IA0KPiBU
aGFua3MgZm9yIHlvdXIgcmV2aWV3LiBJIHNob3VsZCBnaXZlIHRoZSBtb3N0IHJlYXNvbmFibGUg
ZXhwbGFuYXRpb24gZm9yDQo+IHdoeSBTQ1AgMSBpcyBhIHN1Ym5vZGUuDQo+IA0KPiBBZGRpbmcg
U0NQIDEgYXMgYSBzdWJub2RlIGhlbHBzIHRvIGFzc3VyZSBmaW5pc2ggcHJvYmluZyBTQ1AgMSBi
ZWZvcmUNCj4gc3RhcnRpbmcgU0NQIDAgYnkgdXNpbmcgb2ZfcGxhdGZvcm1fcG9wdWxhdGUuIEl0
J3MgYmVjYXVzZSB0aGF0IEkgd2FudCB0bw0KPiBwcm9iZSBTQ1AgMSBhcyBhIHJlbW90ZXByb2Mg
c3ViZGV2aWNlIG9mIFNDUCAwLg0KPiBzdWNoIHRoYXQgd2hlbiBTQ1AgMCBjcmFzaGVkLCBTQ1Ag
MCBjYW4gcmVib290IFNDUCAxLg0KDQpCaW5kaW5nIGlzIGZvciBkZXNjcmliaW5nIGhhcmR3YXJl
Li4NCg0KUmVnYXJkcywNClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IFRpbmdIYW4NCj4gDQo+
IA0KPiANCj4gDQoNCg==
