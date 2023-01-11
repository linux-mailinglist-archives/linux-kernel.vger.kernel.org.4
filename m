Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDB665C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjAKNcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbjAKNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:31:06 -0500
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972C37249;
        Wed, 11 Jan 2023 05:26:50 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 30BDQXUh017380; Wed, 11 Jan 2023 22:26:33 +0900
X-Iguazu-Qid: 34tKO57CqxKqeaSyqO
X-Iguazu-QSIG: v=2; s=0; t=1673443593; q=34tKO57CqxKqeaSyqO; m=8upIYenH0d4ANkOqKpG47j3TtnI74/ChwcNWtAqdjmg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1511) id 30BDQVLL008650
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Jan 2023 22:26:31 +0900
X-SA-MID: 52876903
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkzk0Yk+x6m12gGvzYWXB4iFqnECsfAei9gD82elwSF8hL1w7Fvkosd1ZelzmJC2NdWF6FUQFeaGZHDTPm4/TcEbHtHpl88hPG0BMA8S/2umlI53cx+alBMHmIglf207QwQ/GzdNOMnxJQdr9MErhPfIHPWj0tqngbrGfSZiOAoy7d95ti3p4qt+VQ+lE/JooT0yUmvpaNzNws4eCNP+47X10CA1l+rDaENAvMoMQTNck4j4PM1pLJjCu8lj2EOuNihxiMiOUdjKSPPCZdhzPI02w1R1OnulovaPjq0sQkcKP0Fnupe5OrxmMg5eAn+LmVRzFAsY4DAyocZfM6FpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfeYAT4XeTBXy8ZqHa3ahBi/B1cLJG3Y8kuOueSaOBU=;
 b=SkHDO3VcbLaoT8DuZZhiWpwyJuylQPmCuRGbWEsGVxb0kLindZBu5qWOYrbsXVa2bkicRYdZ15cm4t0UvTHp3vBSJAOn255xS3ayeHVAgS3j+ItVji6m87guf1fw+uKORMySwVCq3cp5SNGWbPYj8QbUXHUqO32Un5nQifhOB82b2NhlDbT1mql+nOhqVUFifWzV9McxkLT3NWtC4GMWbaQJNv1dkyWaXf4zukJWhJOYBvgm3VtLLrlbVIZKtpGpT38ssbipsIKnnOLAIYD41d0iJeVCMEJW0T4st5puuc0iwnKrRF2R1rawf6IpAkRMU3o0jn03HyoAOLdh2QWaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzk@kernel.org>, <hverkuil@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHZJJTAFXt/zFsv/k+G9pe5B8zila6YCwmAgAEiAQA=
Date:   Wed, 11 Jan 2023 13:21:23 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62019B464730E0268B58E90492FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
 <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
In-Reply-To: <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYCPR01MB10696:EE_
x-ms-office365-filtering-correlation-id: 6d278b90-b8c5-4ac0-7008-08daf3d6bc46
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgcbfupmQSuBxsf8VT8EIZA/bckVkkhzcvZfDhBSpJNynICrS41t3k4oOaK/YTB7d/zfeXTwKDDkPpsLTYd3gB5Qj6R4HgO1FIzKN92UGYMf5lFXTcvDr5hiIUk85h3VODuF79rQviFJ3TyuwXr+F9TMAIfItPQjYxZo/G1rsNd/FxII74eL+CVi88KHnjeHN5VGwWNJvLSnILgyD3nIZWq7oZH7jY7KqY/d3aw5BN9bGboc+R/gIZ0DY9H1SuHbGj9U6QAhgRVtxQCbn39yTlmDW5sWgDLbUroHY3DKpcfwJcxhOWalvxnajaUyHByKLezT3C4dYJ9Z525CZQn8yJRt52kxiG1/xzuQPYbLGwQxo10PJ50DZiUffTuUyM9nf0Pgb8Wyp+TTi0HWppIZhlN+9ZWzixiDCcVThfQAz5rqFSnOouQG3kU9Mq+teOx9T3N21LVPM5gzGyAT/QAL3xQvTIZlQ8mvddAFgOGs0AiAiT/szAufElG6EEPAAbBC7/jYow9OPGlc2Sedw+poOLuVs6RAUnNXgdS5ievbQHkA8Mb9YGcsC8OfsPgFe44uuC11AMzE2KqueOWpCkKFBDD7CfmkLR0Q73zeNpTcwmu89dFsAidE+IddOMVsoWv+4qg63HbmVvMCkzOosA37GKqdc/RbGr2yKzwem1tlUfAwwdUC9XiBI1jz28VnSS9LIh7Vz/5dE3i9w3xjNYYOJMjswjCrfXRnCKzGVLUE6kg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(8676002)(52536014)(66946007)(41300700001)(2906002)(8936002)(5660300002)(76116006)(66446008)(66476007)(64756008)(316002)(66556008)(7696005)(71200400001)(110136005)(54906003)(6636002)(478600001)(53546011)(966005)(6506007)(33656002)(4326008)(55016003)(9686003)(26005)(186003)(83380400001)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uit0bEh1bXhFVTZsM1dzRFQvNjNicHJNOU45WVR0L0RFSTJybVd4UjdvZ25V?=
 =?utf-8?B?VzU3Mld1c0dJWEY0SUtRdFZqTS9MazZwRmkwRThQeTl5dVN4UFZKUG92ZFJL?=
 =?utf-8?B?eUMzMWxyRFFYNjc0YnNBTzVZSlltNXM5TWl4YWVtd0I2RmVmc1NncnlqQmtF?=
 =?utf-8?B?eDBxaWY2ZXkvVFVRWXVCdVZEWUlEV09wYWtZeWIwdzdTR0JqTTJHWkhLZnBr?=
 =?utf-8?B?aHR2SjRESGlWRHVINDZQN003OVFJNGd4UGJqaE5jUkY0Z3hsSi9nWnl0cDRU?=
 =?utf-8?B?STRyWmM4dVlkVlFMVitZR2hJWTJleDVXQmxhTW5CZGF0Y1ZEWWl2bEMxOS9W?=
 =?utf-8?B?K1JtLzNTS0xILzR3M3BjaThZU2l5TWRFdW01OE11eW82RkR5ODlIRFhPSGEy?=
 =?utf-8?B?Y21TWDdVQVZ4MkltOEVyUDBCcyt1QnBMOEV2eGpDZjRxYlFMdHZrRThrNzZj?=
 =?utf-8?B?bVpVMVZvYU5iSlJzWUxXWG80NkI5aFNsMTJsaTBEeWNJZWZCN25xSXJoN3pJ?=
 =?utf-8?B?M1RDem5raG1vRkhzQUFpWHlKaTgvRmU0SjBYLzEvUVc0ZGdkb29TYXZpN0NC?=
 =?utf-8?B?Vm5VK2RJbWlDeFd1Z3duWlUxVThNczFFaXYva1dKajA5OFJBU1h0dzhBVHBC?=
 =?utf-8?B?Z3JLbUdMa0czVmV5WHVkeDY3NGd5Tm9YWml4N3BMWkk4T0FoVERCc3BGUmNC?=
 =?utf-8?B?d1JDcGkxV2d5dDNmd242dmk0Ym9meGFQdXQ3c1krVzQ1bXdzYVFOS3lKNkI3?=
 =?utf-8?B?ZkNqTW1razk1dGx2TnRHQmlzcWhmdHZKS1ZDQ015U0M3YUpKZ1hNeklSOEcz?=
 =?utf-8?B?VzNKQTEwNlhrMmpMY3VqeUU2dVdZWThGa2NhUy93TGJMRHJmZTN3QmxrK3Az?=
 =?utf-8?B?Y3dMNzlpb1RYeDlMVGJ4NkpSZ1ZEMUlmQVk3WHpCQVJRT0tSQUNvZC9zWUFj?=
 =?utf-8?B?aTllU3pLeStMUzlMUlBWS1lRR3RpZEpaY0Uxb3UxU2R5RitWdWJmWGxicGZ1?=
 =?utf-8?B?M1ZwQmxxOU1jaGtBVkFuSVVoTHRKc2V0a1NFOVp3YWNGaEQzRkZJZnk2R2tQ?=
 =?utf-8?B?Rlg0b1Bwdk1XWUR1OU1FOUVJZVlHdzNSTkpwd3dTU1BtbWN6eUV0RVBpS29a?=
 =?utf-8?B?akVHQWtqSWE2WU5ocTd0ZnNtQUpMaWg5UldISVJ0dTdCNmZGN0U4T241cjc2?=
 =?utf-8?B?Rkxoc3pFMVVnMm1JTkh2UU1nNUtYZ3J3ajQ3SDUwaWt1aGpxa0s3QnlxS2F5?=
 =?utf-8?B?MjMrd1VVZHBpUU5lTXppUnBYRmNxaTVMcW5JbHJkWFpaeWpjQzdBalYzbWJX?=
 =?utf-8?B?cU43QVIvV2k2MC9iZTdjRXdGdWNHMTVSSndBK3p4VHBGNDB3N1JWOEFiNHVK?=
 =?utf-8?B?V2wrU2JJV3h0S0wwM3MrQlBZZEw4eEJvTTdGdmo3WG0rclhBb1BZSWxSVkJU?=
 =?utf-8?B?N3ZPSXR1bldmQkpqaUpTNTVNTXd1VytUK3hVcjlCNE9CSWkvODJ2d0txbzcr?=
 =?utf-8?B?YTRpRjlnYm1jdWhjQjhyNFFDSmdxL3BHcjlybCs2dmw0Qi9IaUtuWE5SNmVZ?=
 =?utf-8?B?dWRsTHJBSzJRT1dKTGdEeGIvL2dzYnBmdEREL3dkWWdMRHYvYWx1ZGUwOEpr?=
 =?utf-8?B?RkZwQmltTTgrcTNwY3hvcDI1WVhSRmhycG5RRHVJaHk0R3FFNC9sdE5yLy9R?=
 =?utf-8?B?V0J0WVBwVHRRY1QzeDN3UlQ3ZkdKMmxNMjIvOGV3U05GU2E5aTVGRzZod0VJ?=
 =?utf-8?B?NUNnRk5ibm5iM2Nsd2FJMU5tcGwybFIzSytYamVHMjJuNklYblE3V1lrTnI2?=
 =?utf-8?B?dmpNVzVwNHN5ajViNlVvT3Ntd0trby9WRi92UUtBNWtmUUJTeWRDdzVxbEQ5?=
 =?utf-8?B?c0dndFBoWldiRGU0Uk5GYmxvOTRDSWtvV0pORHJNWThQMzhxa1A5c0hNWW5U?=
 =?utf-8?B?MHlaRHRORUNLK1NBQXJzTkxnZ0VCcERDdXUxK3BuM2FpaTlMYmhRVGlJK3F0?=
 =?utf-8?B?NnJwczhLMHcyVUM2WjExMkh2WHd4YjBEMkZySXZIRmlIR2QxMW9jdjgxUW1W?=
 =?utf-8?B?dnJtamQ2NVBnRW1tRUN4andLMDNKQ3lrSXlQdmZoV1VoVnJINEVjNmpDQTM2?=
 =?utf-8?B?V3NlSU1aTUd5N3pWZDlWZGRpVG9HRi9JVG14NFd0MTBrWFJiOGRueUxTU1Y1?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d278b90-b8c5-4ac0-7008-08daf3d6bc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 13:21:23.3161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3wJQnh2tTRJmTLFqF/BtXvPDhAeVzw/pTi5tERF3Jiwcopc6VoS8y0XYD9iP0sYGr8NIbJ3gv8p9pN+OIEnqGbc9E86ovlRjPzv2yZ/ABo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10696
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQpTb3JyeSwgSSBtaXNzZWQgeW91ciBjb21tZW50cyBmb2xsb3dp
bmcgdGhlIHRvcGljIG9mIHJlY2lwaWVudHMgbGlzdC4NCg0KQmVsb3cgYXJlIHRoZSByZXN0IG9m
IHRoZSByZXNwb25zZXMNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
SmFudWFyeSAxMSwgMjAyMyA0OjMxIEFNDQo+IFRvOiBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDl
j7gg4peL77yy77yk77yj4pah77yh77yp77y077yj4peL77yl77yh6ZaLKQ0KPiA8eXVqaTIuaXNo
aWthd2FAdG9zaGliYS5jby5qcD47IEhhbnMgVmVya3VpbCA8aHZlcmt1aWxAeHM0YWxsLm5sPjsg
TGF1cmVudA0KPiBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPjsg
TWF1cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBpd2FtYXRzdSBu
b2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4gPG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjQgMS82XSBkdC1iaW5kaW5nczogbWVkaWE6IHBsYXRmb3JtOiB2aXNj
b250aTogQWRkIFRvc2hpYmENCj4gVmlzY29udGkgVmlkZW8gSW5wdXQgSW50ZXJmYWNlIGJpbmRp
bmdzDQo+IA0KPiBPbiAxMC8wMS8yMDIzIDAyOjQxLCBZdWppIElzaGlrYXdhIHdyb3RlOg0KPiA+
IEFkZHMgdGhlIERldmljZSBUcmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiB0aGF0IGFsbG93cyB0
byBkZXNjcmliZSB0aGUNCj4gPiBWaWRlbyBJbnB1dCBJbnRlcmZhY2UgZm91bmQgaW4gVG9zaGli
YSBWaXNjb250aSBTb0NzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXVqaSBJc2hpa2F3YSA8
eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD4NCj4gPiBSZXZpZXdlZC1ieTogTm9idWhpcm8g
SXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiANCj4gUGxlYXNl
IHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2Fy
eSBwZW9wbGUgYW5kIGxpc3RzDQo+IHRvIENDLiAgSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1h
bmQgd2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZlcyB5b3UNCj4gb3V0ZGF0ZWQgZW50
cmllcy4gIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBhdGNoZXMgb24g
cmVjZW50DQo+IExpbnV4IGtlcm5lbC4NCj4gDQo+IFlvdSBtaXNzZWQgZmV3IG9mIHRoZW0sIHNv
IGNsZWFybHkgdGhpcyB3YXMgbm90IHNlbnQgY29ycmVjdGx5Lg0KPiANCj4gDQo+IFN1YmplY3Q6
IGRyb3Agc2Vjb25kL2xhc3QsIHJlZHVuZGFudCAiYmluZGluZ3MiLiBUaGUgImR0LWJpbmRpbmdz
Ig0KPiBwcmVmaXggaXMgYWxyZWFkeSBzdGF0aW5nIHRoYXQgdGhlc2UgYXJlIGJpbmRpbmdzLg0K
PiANCj4gPiAtLS0NCj4gPiBDaGFuZ2Vsb2cgdjI6DQo+ID4gLSBubyBjaGFuZ2UNCj4gPg0KPiA+
IENoYW5nZWxvZyB2MzoNCj4gPiAtIG5vIGNoYW5nZQ0KPiA+DQo+ID4gQ2hhbmdlbG9nIHY0Og0K
PiA+IC0gZml4IHN0eWxlIHByb2JsZW1zIGF0IHRoZSB2MyBwYXRjaA0KPiA+IC0gcmVtb3ZlICJp
bmRleCIgbWVtYmVyDQo+ID4gLSB1cGRhdGUgZXhhbXBsZQ0KPiA+IC0tLQ0KPiA+ICAuLi4vYmlu
ZGluZ3MvbWVkaWEvdG9zaGliYSx2aXNjb250aS12aWlmLnlhbWwgfCA5OA0KPiA+ICsrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKykNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lZGlhL3Rvc2hpYmEsdmlzY29udGktdmlpZi55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvdG9zaGliYSx2aXNj
b250aS12aWlmLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZWRpYS90b3NoaWJhLHZpc2NvbnRpLXZpaWYueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAuLjcxNDQyNzI0ZDFhDQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS90b3NoaWJh
LHZpc2NvbnRpLXZpaWYueWENCj4gPiArKysgbWwNCj4gPiBAQCAtMCwwICsxLDk4IEBADQo+ID4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNl
KSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvbWVkaWEvdG9zaGliYSx2aXNjb250aS12aWlmLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiAr
dGl0bGU6IFRvc2hpYmEgVmlzY29udGk1IFNvQyBWaWRlbyBJbnB1dCBJbnRlcmZhY2UgRGV2aWNl
IFRyZWUNCj4gPiArQmluZGluZ3MNCj4gDQo+IERyb3AgIkRldmljZSBUcmVlIEJpbmRpbmdzIg0K
DQpJJ2xsIGRyb3AgaXQuDQoNCj4gDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAt
IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4g
PiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRvc2hpYmEgVmlzY29udGk1IFNvQyBWaWRl
byBJbnB1dCBJbnRlcmZhY2UgKFZJSUYpDQo+ID4gKyAgcmVjZWl2ZXMgTUlQSSBDU0kyIHZpZGVv
IHN0cmVhbSwNCj4gPiArICBwcm9jZXNzZXMgdGhlIHN0cmVhbSB3aXRoIGVtYmVkZGVkIGltYWdl
IHNpZ25hbCBwcm9jZXNzb3IgKEwxSVNQLA0KPiA+ICtMMklTUCksDQo+ID4gKyAgdGhlbiBzdG9y
ZXMgcGljdHVyZXMgdG8gbWFpbiBtZW1vcnkuDQo+IA0KPiBGaXggd3JhcHBpbmcuDQoNCkknbGwg
Zml4IHRoaXMuDQpJIGRpZG4ndCByZWFsaXplIGEgbmV3IGxpbmUgaGFzIGJlZW4gYWRkZWQgdGhy
b3VnaCBmb3JtYXR0aW5nIGEgcGF0Y2guDQogDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+
ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDogdG9zaGliYSx2aXNjb250aS12aWlmDQo+
IA0KPiBDb21wYXRpYmxlIG11c3QgYmUgc3BlY2lmaWMuIFlvdSBjYWxsZWQgeW91ciBTb0Mgdmlz
Y29udGk1LCBkaWRuJ3QgeW91Pw0KPiANCg0KVGhlIFZpZGVvIElucHV0IEludGVyZmFjZSBoYXJk
d2FyZSBpcyBsaWtlbHkgdG8gYmUgdXNlZCBhdCBmdXR1cmUgU29DcyBvZg0KVmlzY29udGkgQXJj
aGl0ZWN0dXJlLg0KRG9lcyBjb21wYXRpYmxlIGhhdmUgdG8gYmUgc3BlY2lmaWMgdG8gU29DJ3Mg
bW9kZWwgbmFtZSANCnJhdGhlciB0aGFuIGFyY2hpdGVjdHVyZSBuYW1lPw0KDQo+ID4gKw0KPiA+
ICsgIHJlZzoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiByZWdp
c3RlcnMgZm9yIGNhcHR1cmUgY29udHJvbA0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiByZWdp
c3RlcnMgZm9yIENTSTIgcmVjZWl2ZXIgY29udHJvbA0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRz
Og0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFN5bmMgSW50ZXJy
dXB0DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFN0YXR1cyAoRXJyb3IpIEludGVycnVwdA0K
PiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDU0kyIFJlY2VpdmVyIEludGVycnVwdA0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBMMUlTUCBJbnRlcnJ1cHQNCj4gPiArDQo+IA0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClJlZ2FyZHMsDQpZdWppDQo=

