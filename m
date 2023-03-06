Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796366ABC1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjCFKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCFKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:25:13 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65422DFD;
        Mon,  6 Mar 2023 02:25:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFJve3Qxg7AidXrWr1sk+EqKUXlB9dO1rBQ2FJcJNGpqtCNcEhrK5uA3xY1vFk2PY3XwYVjaKDssRwRrXFySinYPwdq7bZexRuO1Nk/2cMmT9Ec+B/p8W1UKb92nPTCfaGwrjHN+3O9W+U8ncyNAi/BjxI2eE06e974WAfHoZKaHctW6joiStyWjUzbQDfHOkn/yNHPkahzKdqYAlURkghLsTLpSGSUEyxhVuC8iIAnS/cPXoT6ABXVq2jpxsC/6ESgi2TakBUdg6noIxzuoxab9FY1g1EVMuTe4KSEkUfVx+d9ZN0rS41iGBxjQCvNGBAmhl261S+3ZVRDwnD/+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFRNE7NLfm/e5rLnaiaNvZK3ARu4R7QTYA5AMwkyC7A=;
 b=lotDnpiuPJYUkX2ic1UTfeidQi2IycyQLhjz0B/AiM70kT1048SVGTpZsddNMC6EztdDv7JCfEIhej8sjLsb18xTaJGb6sQtJ67bq58Mh5RCXmTPFp1BrFYs7gLnCmONHoBlzqErYx5vjcTNtDrII6xwuh5BBvLMs19L+bMAgl6Q+znzl1PjnDCSO+tZ8nLp2I9xl6rxNQ49o/Sn5qsIBc8DuMqppnx4qFJjorQFyMXYAU3Lecc/BSvtVj8gXm2YTtJ9biN0hQWyfzWXqlJx7oRXvAwSa7KdTr5g4xTJ1bw4Adm7cvS0+PjeizmIqMVMfefqQUr6ja+JNxKgYxFzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFRNE7NLfm/e5rLnaiaNvZK3ARu4R7QTYA5AMwkyC7A=;
 b=TXDX/J2iZPHw5yVjBpDtnm6QLMlsjlYBWoz+l5rsiecy/ELxXoKdzlFd6UyIM4mBlLjKUZEOKuaaj+Kueq5vHcx3IInyVT0Au8/g45nB7hsKS1vtu/9oBn5gdHCUKprFEy3X1WFO0jvqEL6I7VvX0QNI10bfgTpBRjeDuDd2lJK4e4RODcKMvEf413qaFRdMXS1fug8s+/YwgxHuxodBcjrHfrtXg7Jc5ufuykfanUr1YqtuIzht0RaVLsUtykQdSKMQeGscRUjOM7xLn0d5ml/L/jpzWItz3Uni6whABKzJh5/itLQf4p1hYS8c1OCx/mkUVSg9eKZEz8ZezuM1Bg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB3328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.15; Mon, 6 Mar
 2023 10:25:06 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec7c:461d:e331:1a85]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec7c:461d:e331:1a85%5]) with mapi id 15.20.6178.013; Mon, 6 Mar 2023
 10:25:06 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix race on RX DMA shutdown
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: fix race on RX DMA shutdown
Thread-Index: AQHZUAoU2vEWAiAiIU2w2trXS1P26q7tgA+AgAAJaoA=
Date:   Mon, 6 Mar 2023 10:25:06 +0000
Message-ID: <5db61239e2d59a781ea94e1dddce72f2fbba2e46.camel@siemens.com>
References: <20230306090011.80725-1-alexander.sverdlin@siemens.com>
         <cd278972-77c5-2118-0a47-327aa7406ec1@kernel.org>
In-Reply-To: <cd278972-77c5-2118-0a47-327aa7406ec1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB3328:EE_
x-ms-office365-filtering-correlation-id: 9a72577a-e3dd-44be-6ce4-08db1e2d0e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhPzwUd40mIaIJpMVhOJusqBWopnTGURLr/7el1dMTgZiFZuT3dStpjHleYPj3sWsPrKNOxkWvvfmAPhg3XOnTJYQvKCbIjK9Nye1gOjBpiIC6Utiqi0l/M1mnT33vGqHfzjwcMeFG7K6bNnMCwTYU08z4cs0x7k47JaogE7fm4gu+LYcjlQjoktZNSN+onwZJhN0hIMO1BT2/ZH1HZ/AIcCUWTJC6soYQoLhWhAjDUMkYsRrjlJQj3urXpt8pZiBKu2tXhRBlj/jc7WD/ZsZ6XzySfZvgHg2f9JNB8R7LmGKX5u7TOPIMO2E7dRyYokQRTHSJwxBUJrP6s9WmJBrTnY82Ib2RsKjm5Ien44A3QuaRfVGgi+5tp05cg1hoNZgde76dgQ9HN9oJ6MYaBwBT522dMoPmBJLfzfSe6xkkreTksIJAU6NIm+XWlNA775zzvrbmgMRRNy0My/a7B34BiBpKPGNx76EQDGb0vUHumGcHkzslnDuBvM6imcPYEB9lbrHn3Zrdw2nw6TPe2HKuzmp1Fo8NGb39PHmJFmQpY4K7jC6ITW1g457x3IPNXW6TpgL4BeTERzt5wwvxat5OIjQUqu4dTCSoqfvIe/oYeYYYLLp08vQ5z026UIUqK2M3/T5/YjjmEOqIzUQcx/BPI0YkiNVj8gkLpQd9zoqJ2enPH5q2AoW9WQwJtAGCyV7cpzlpWY78U0/B9E5W3ufEzUJ1NIek7gEI0jC9phSGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(110136005)(54906003)(36756003)(6486002)(316002)(83380400001)(15974865002)(86362001)(64756008)(186003)(2906002)(76116006)(5660300002)(66476007)(8936002)(66556008)(66946007)(8676002)(41300700001)(4326008)(478600001)(6512007)(26005)(6506007)(66446008)(2616005)(71200400001)(122000001)(91956017)(82960400001)(38100700002)(38070700005)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2VRb1E2VU1rWXh6Wk5lcVhNUnNhOWVEYVowaGJQVHNHaDRPR2FvcGtRTlhj?=
 =?utf-8?B?WmJxV0JrVWZFQ0p5bDQzWEgzbmZpWkZWOWxjcnZIZVRiOWRDTnM2cHIrOWU2?=
 =?utf-8?B?OHVQdERNOVJCNGxuL2lGV2tpMEJMNk1JaDZtZDVIcjdXTjJ4d05qZXFiMXY5?=
 =?utf-8?B?TnFzejllOTNlem1NSkFKeEJQcFh6Y0t2WVA2Z2VsbGdsclcrWTQ4TTRPZTYy?=
 =?utf-8?B?SzVacWRERVFUcXpheEMzQlE1WGJ6WlZRRkd1a01Fa1JwTDBjeGV2WUxWdWpU?=
 =?utf-8?B?Z0ZlS3UvaWYwUHUrZkVOSUJCQ1hpTEI4aE1hajc0V21jQUs1NmFIcXpZNUJO?=
 =?utf-8?B?YmZMS0oyK2lPK0Y1UGhKOVkxMHAvdzloeHkyN0cyNWxCcXlMc1llejV5UFhT?=
 =?utf-8?B?bXhid0Jpc2xrNVcxd3JMY29mT2JMQW50NTcwZHhUSjV3dm84Z3FWTEtheGpW?=
 =?utf-8?B?eEpUKytsSnd6RG4wckpsdzk1VkdIVDN6YWJVd3NMMUxzL3o0RzFGQmJvdGNi?=
 =?utf-8?B?Vks3MVFpdHEreDBTMDA3bDBKMkQ5ZnVrSTk1OVNidHdZamVoMFF6SFo5YXh2?=
 =?utf-8?B?Y0Q4M3NuR3E1VzlsT003dVJYVEV6RFNNVjdiNEd5NFVCZjJqNzFLN3VGS0xk?=
 =?utf-8?B?cFljWTU0V1FjVDB2OHpLcERXOXNSQmpWMFQ1SHNFdThMZ0FFakZNaktBSXBU?=
 =?utf-8?B?YWg0UkRlSWZHbDMxL21VbHZWdUhEdkhRbGVyYitZZDZwSHpHamJpZ1JMZXR1?=
 =?utf-8?B?TnU4ek5FVHZTN3BycFJ0WWw2SU1qeGR2ZWhrTmg5UStvQU0xNGVsdjg1L2kw?=
 =?utf-8?B?d09aeHZiandZdkQ0TkNBOFAvcll5SEdlZEl1Z2kzL3BIVUE1V2w3Vjd3T2pC?=
 =?utf-8?B?M253Vndtd0pSbGMyWTlhdHVuQ2ZuOEJ2TSsxV3BqclgxU1lDV1h2dEJ0bTg0?=
 =?utf-8?B?VUJ4MC9acXlIS0VnWHpHM1o0Q0VJck9RL3JzT0NGVk92NXh2QTQ5dDQxa1Fm?=
 =?utf-8?B?TXNVcUswT045WTNzd05yTlYxZGJGcTJ1czE5Ym15QlUvVmhZNmFIaHZ5U0V0?=
 =?utf-8?B?Wlg4ZGJvMFBydEFMVENQT3ozS2UzL3RoUGlCWHREM2dmT24zV3NRY3dNT2Qx?=
 =?utf-8?B?T3NvSUJhTUNuQjNxdXlLeDhpM2dtcWw5MktyWFUzWVdZSmlNTkNnVW5UQTFB?=
 =?utf-8?B?SEV6OUhJM2JlU3FSdU1rVnk2VVB2Nk5NNE91UlhydmFuTFFUQnRHM0E2WDhM?=
 =?utf-8?B?cGk3eE1IRjc0ajlTR2RkTCtWbzYzeDRKUkx4ZU15NXdEK0V4Mys0WGRMTnpY?=
 =?utf-8?B?M0Y1cU5CemN6WnQvSVI3STJVYnNLTVhML0lpdjl4cVlMYStOTGwxZVovS0dZ?=
 =?utf-8?B?aHl5M3A1RDVOQm1SQ2owRDhmUUpyWUlnY0ZveStvQlQ5a2NITDgwYURPcnpX?=
 =?utf-8?B?bTlLV2Y3VmpsVzY4SXdlR3NUUXoySVRmcVd1T0ZvZEVuaEY3cWMraDhKZGtW?=
 =?utf-8?B?RlkyZ0psRlR2NmtyQzNvcUlzeGFCT1RWZ05QMUJkUHVpZEorcWRuM0xvSzNt?=
 =?utf-8?B?Q0Jxa1huRkY0bUU3endCYlZVVG1iUnExQXpoY2dEWlY5VFlkUzZjWDhUQkls?=
 =?utf-8?B?ajZkSUQzaVJYK2NVNllEQXp3K3NUNXE2VVJ2bkhiTDZETzA0ZUhRUlI4bVVN?=
 =?utf-8?B?SHRWbGhTRW1hZzZLc2lUNEhRSGNseHh5a3BPNFZxUTQrL294MEw2ZDFuV1NO?=
 =?utf-8?B?cDFSRytra0h0NUt1eVN0YWQ2NGhxK3VBWDMzWXNrdUFLV2hHZHMreUZNVVVQ?=
 =?utf-8?B?VjFTdGRVQ1BhT1NrR1psTmNwMVRKOXhRK0x6MWoxWmFwNlp6TDN4Q09meFpU?=
 =?utf-8?B?SUZKWXlYTHpTSk5UaGM0YlVsT3FXbWZJTTRvOFl1MlU5ZHVRcGlZZG1iUEVa?=
 =?utf-8?B?NWc2dWtJem5wTCs1d3VVUWUxUnBZWXFRb21Gc3A2ajVEU29BTzIrZEdnZmJR?=
 =?utf-8?B?b3VZeS8wczBwTkRBb1JWMm05dmg3dEg5c2ZlRlkvOENPRGZqUFFpNHBMSWVw?=
 =?utf-8?B?OFd2SlQyS0JmNEwwWUdsVnFBMFoxU2FMR2RGWTRMYURVT2t4bG1nUUF6aXhk?=
 =?utf-8?B?Z2dqVWw3SHlYV3haTVJacmd2eXFqcHdJcjFOZWo1cWRQMmhMYmdLMnBlUkJO?=
 =?utf-8?Q?jW3uFqaMNe9+tSWX5GiQ6vE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43726793A17A684E99F05369403D6AE6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a72577a-e3dd-44be-6ce4-08db1e2d0e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 10:25:06.6019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxHG4hv7w1qCN4YcDEI1/Plrycq67w8q2OhmwkxYIafk5nj9Rn2JfyvY+hF5dDZPXIT/Y9SWFVjpY50r0N0a09JwP37AzuvIFxHnjYszqrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmlyaSwNCg0KT24gTW9uLCAyMDIzLTAzLTA2IGF0IDEwOjQzICswMTAwLCBKaXJpIFNs
YWJ5IHdyb3RlOg0KPiBPbiAwNi4gMDMuIDIzLCAxMDowMCwgQS4gU3ZlcmRsaW4gd3JvdGU6DQo+
ID4gRnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5j
b20+DQo+ID4gDQo+ID4gwqBGcm9tIHRpbWUgdG8gdGltZSBETUEgY29tcGxldGlvbiBjYW4gY29t
ZSBpbiB0aGUgbWlkZGxlIG9mIERNQQ0KPiA+IHNodXRkb3duOg0KPiA+IA0KPiA+IDxwcm9jZXNz
IGN0eD46wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oDxJUlE+Og0KPiA+IGxwdWFydDMyX3NodXRkb3duKCkNCj4gPiDCoMKgIGxwdWFydF9kbWFfc2h1
dGRvd24oKQ0KPiA+IMKgwqDCoMKgIGRlbF90aW1lcl9zeW5jKCkNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGxwdWFydF9kbWFfcnhfY29tcGxldGUoKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbHB1YXJ0X2NvcHlfcnhfdG9fdHR5KCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtb2RfdGltZXIoKQ0KPiA+IMKgwqDCoMKgIGxwdWFydF9kbWFfcnhfZnJlZSgp
DQo+ID4gDQo+ID4gV2hlbiB0aGUgdGltZXIgZmlyZXMgYSBiaXQgbGF0ZXIsIHNwb3J0LT5kbWFf
cnhfZGVzYyBpcyBOVUxMOg0KPiA+IA0KPiA+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MNCj4gPiAwMDAwMDAwMDAwMDAw
MDA0DQo+ID4gcGMgOiBscHVhcnRfY29weV9yeF90b190dHkrMHhjYy8weDViYw0KPiA+IGxyIDog
bHB1YXJ0X3RpbWVyX2Z1bmMrMHgxYy8weDJjDQo+ID4gQ2FsbCB0cmFjZToNCj4gPiDCoCBscHVh
cnRfY29weV9yeF90b190dHkNCj4gPiDCoCBscHVhcnRfdGltZXJfZnVuYw0KPiA+IMKgIGNhbGxf
dGltZXJfZm4NCj4gPiDCoCBfX3J1bl90aW1lcnMucGFydC4wDQo+ID4gwqAgcnVuX3RpbWVyX3Nv
ZnRpcnENCj4gPiDCoCBfX2RvX3NvZnRpcnENCj4gPiDCoCBfX2lycV9leGl0X3JjdQ0KPiA+IMKg
IGlycV9leGl0DQo+ID4gwqAgaGFuZGxlX2RvbWFpbl9pcnENCj4gPiDCoCBnaWNfaGFuZGxlX2ly
cQ0KPiA+IMKgIGNhbGxfb25faXJxX3N0YWNrDQo+ID4gwqAgZG9faW50ZXJydXB0X2hhbmRsZXIN
Cj4gPiDCoCAuLi4NCj4gPiANCj4gPiBUbyBmaXggdGhpcyBmb2xkIGRlbF90aW1lcl9zeW5jKCkg
aW50byBscHVhcnRfZG1hX3J4X2ZyZWUoKSBhZnRlcg0KPiA+IGRtYWVuZ2luZV90ZXJtaW5hdGVf
c3luYygpIHRvIG1ha2Ugc3VyZSB0aW1lciB3aWxsIG5vdCBiZSByZS0NCj4gPiBzdGFydGVkIGlu
DQo+ID4gbHB1YXJ0X2NvcHlfcnhfdG9fdHR5KCkgPD0gbHB1YXJ0X2RtYV9yeF9jb21wbGV0ZSgp
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVy
LnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiANCj4gVGhpcyBzaG91bGQgaGF2ZSBzb21lIEZpeGVz
OiB0YWcsIEkgYmVsaWV2ZS4NCj4gDQoNCnN1cmUsIHlvdSBhcmUgcmlnaHQsIEknbGwgdXNlDQpG
aXhlczogNGE4NTg4YTFjZjg2ICgic2VyaWFsOiBmc2xfbHB1YXJ0OiBkZWxldGUgdGltZXIgb24g
c2h1dGRvd24iKQ0KDQpvbiByZXNwaW4uDQoNCj4gPiAtLS0NCj4gPiDCoCBkcml2ZXJzL3R0eS9z
ZXJpYWwvZnNsX2xwdWFydC5jIHwgMTEgKysrLS0tLS0tLS0NCj4gPiDCoCAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gYi9kcml2ZXJzL3R0eS9zZXJp
YWwvZnNsX2xwdWFydC5jDQo+ID4gaW5kZXggZTk0NWY0MWI5M2Q0My4uNDdjMjY3ZWUyMmUwNCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+IEBAIC0xMzU0LDYgKzEzNTQs
NyBAQCBzdGF0aWMgdm9pZCBscHVhcnRfZG1hX3J4X2ZyZWUoc3RydWN0DQo+ID4gdWFydF9wb3J0
ICpwb3J0KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4gPSBzcG9y
dC0+ZG1hX3J4X2NoYW47DQo+ID4gwqAgDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGRtYWVuZ2luZV90
ZXJtaW5hdGVfc3luYyhjaGFuKTsNCj4gDQo+IE1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZyAo
SSBoYXZlbid0IGxvb2tlZCBpbnRvIHRoZSBjb2RlKSwgYnV0DQo+IHdoYXQgDQo+IGhhcHBlbnMg
aWYgdGhlIHRpbWVyIHRpY2tzIGhlcmU/IFdvbid0IHRoZSBkbWFlbmdpbmUgYmUgcmVzdGFydGVk
DQo+IHRoZXJlPw0KPiANCg0KSXQncyBjeWNsaWMgKHVzZWQgZG1hZW5naW5lX3ByZXBfZG1hX2N5
Y2xpYygpKSwgSSBzZWUgbm8gcmVzdGFydCBpbg0KbHB1YXJ0X2NvcHlfcnhfdG9fdHR5KCksIGJ1
dCBtYXliZSBzb21lb25lIGNvdWxkIGRvdWJsZS1jaGVjay4NCg0KPiA+ICvCoMKgwqDCoMKgwqDC
oGRlbF90aW1lcl9zeW5jKCZzcG9ydC0+bHB1YXJ0X3RpbWVyKTsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgZG1hX3VubWFwX3NnKGNoYW4tPmRldmljZS0+ZGV2LCAmc3BvcnQtPnJ4X3NnbCwgMSwNCj4g
PiBETUFfRlJPTV9ERVZJQ0UpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBrZnJlZShzcG9ydC0+cnhf
cmluZy5idWYpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzcG9ydC0+cnhfcmluZy50YWlsID0gMDsN
Cj4gDQo+IA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1l
bnMuY29tDQo=
