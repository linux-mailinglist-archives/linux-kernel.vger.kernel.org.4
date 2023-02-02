Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3B6874CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBBE6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBBE6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:58:42 -0500
Received: from mo-csw.securemx.jp (mo-csw1116-1.securemx.jp [210.130.202.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D62E0;
        Wed,  1 Feb 2023 20:58:39 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 3124w37X029856; Thu, 2 Feb 2023 13:58:03 +0900
X-Iguazu-Qid: 2wGr5g72QtIVMwEQML
X-Iguazu-QSIG: v=2; s=0; t=1675313883; q=2wGr5g72QtIVMwEQML; m=7vGuE+KtQrFEyDkPt+Dbn5giNvRoewg9YLzKhhlYVeo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 3124w16M002732
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 2 Feb 2023 13:58:02 +0900
X-SA-MID: 54232357
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuUwuD4OJ20dGaeHhTpT169Kfl3AoaMLZsG2dMH54v+b/lOWygsVGdB9jOkTdWSqheA6KPmaW44tHZLU8i+EhBmVcflNo2YXeRhk4EzyHbHiZUgMxsSpjbXmJdqn4x7RWAg8vmBhwtygM1BI2u/P6BiehLu+24IbomJqcnFXDCr9WONi4bCC6WXZhTvByKdRymx2Pty/2LjOaKwu7p0zxxdDGY7znjExqSRhTzRHqIlke7wEYUbuEGBMm8QrZbiigQCWBKY/emRhb7ouUVplFhPTWTS2T+1//5vkA0uDNDYvSnnVd00sWr7+1pJ+thhRevOkCt3m8ooHz2QhQ1L+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c/kw2weqXx2ZHT/T+YYPH7iv690oGIeo1MHZHZ22A0=;
 b=KcNI5WRPLOLGFXRNRMsZSeIhhZjmVAlcn6QaNeE4XYmBjABiBqijUudsu0hyjMqJM0i3i61Y/ieVEH6GEZyjLeTpDZjPm6ofpb1wuWOnL+cGG2gjdKn14JJBDNK80dUINGVEI5OzgvIoCqpzSoTzK4x8aTzLwt/jlZRAoo3jy5+J0KU1C81ozK9QzoKGRTt4HYmZeETFG8OkffQPiQessFX0oQFbDxA7gGRr0VQ2QaMjwpQPjsQfpGEh2XL3WlNeSSp2WVrIeGsNFwcfkufXZL01Cv+YeSPcliSRqYk2MT+xcHBgKXWQ+U8co1yLfKBxDx5cEznczl4YPpxZEuENmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <laurent.pinchart@ideasonboard.com>
CC:     <hverkuil@xs4all.nl>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rafael.j.wysocki@intel.com>,
        <broonie@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver user interace
Thread-Topic: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver user interace
Thread-Index: AQHZJWPtmelSVsjZq0uVz/vT5NgNQq6iiBUAgADeugCAC5bFoIACRwKAgAnxA5A=
Date:   Thu, 2 Feb 2023 04:52:56 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201A88B85E74C3EA3481BD092D69@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-4-yuji2.ishikawa@toshiba.co.jp>
 <2b412539-2236-b41f-c777-bc9e9cf99d66@xs4all.nl>
 <Y8dFlFkVJS/6+Ib1@pendragon.ideasonboard.com>
 <TYAPR01MB620161823BA912502CEF0A5992CE9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <Y9LnWfZb+v17+h+X@pendragon.ideasonboard.com>
In-Reply-To: <Y9LnWfZb+v17+h+X@pendragon.ideasonboard.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYAPR01MB5595:EE_
x-ms-office365-filtering-correlation-id: 98d055e5-6232-41a4-3f74-08db04d959c5
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkkOiFOGPM/EyQgjnW7ypylDYxhS3UqgHBF0I2GxXgo/MDr8mf+1KEQSAnU0tFSwwZ4DCTzr8NqbNKZy1vea5k9LEH/9Wva0cFETzU6WFDuiO33bMwEYiIvo0khV6g2k4niKoPOwCH+pnUfzYhfQg0PxbBqpMJYuoCawsO3X+P6SELQz7B0+1zIAir1VkS2WakF272sMcUY5/K70axgv5l9AGol/ZMiT9r2OJAEtCQjtYuOYpwdiZle4OCVFEpYnVIf0UzQb7z9ctxeD8DEAg1TFqTSAEp8d2NlKefSBCJcYuDYOaq9BT72HTt8H1/Tg8jxQ1iwjFj2tDcpVJ0f2Ht0OLTIFuw8qZZZJk9DYzoN/b/1os+wwkm/jnZcl5xQ+apgEGQvI/FIpjBc7RuNLt1InmJiotmLsOfprM0kjdaxrcSCia+aBTyKh/l13Ys5ynYpzNzeRJQs9GD5ImzJBoQx4NlnMmdnmLpYNsl6atnNPgQedwzQqs+VN6ylgw+D8gK8Xz71lxhgG94w9ArYG1igkVy9uQOqKAyCOvfq+zHvNGa2dH6ojqifG+ElYB5vvsW8896rdqiFJiyqsBxDZQ8RAVNeXJim7JLEPXYNZ+J3hrE2Zf/F8h3eVEg6+0Ib+YzLZxmyfnhWx3cRoJgYibinYddZwqD8FVWI7W/XCIaKm93L2ba4v7bqvjWWKcA+GsbhvzdfsKTwNN4lodE2FnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199018)(186003)(9686003)(26005)(55236004)(6506007)(53546011)(4326008)(5660300002)(83380400001)(71200400001)(6916009)(54906003)(66556008)(66476007)(8676002)(7416002)(64756008)(66446008)(86362001)(66946007)(76116006)(41300700001)(316002)(2906002)(55016003)(8936002)(478600001)(38070700005)(122000001)(33656002)(38100700002)(52536014)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K016RlBONnJYdTRXdm93VVA1Z0FoZ0J2K200K2YwTXdJUmllWjFMOTNJVHNQ?=
 =?utf-8?B?U05UeGlmdkFya1ErYWpjdm1vQzFRL0hhZkpkTjMvVGtEaEJmTzZaSXR2QzAr?=
 =?utf-8?B?TUxtdnZ0UHpGNWEvWlFyK2dUbG5EQktpdHIzaHJEaisyRUxoYlV6L0ZUaUJU?=
 =?utf-8?B?ZVNNalVwUGlzVmdCUnVHOUoyZ3JiTE5CYmQ2TTJBQkNIdUU0RFJFKyt0QUJR?=
 =?utf-8?B?cTFUL0tuOU80VkpURWRsaUxYN1NmQ2JzMTRNT3RTTGJabGJ5b09kck1aUWNX?=
 =?utf-8?B?SElFZjBmZUZwSWpINUNkeVZBYmRVcnR4WUlYRTkrQUhvNW9TTk9OMmN3WWVz?=
 =?utf-8?B?YVZ4RjRxZDFwTGw2Ti9nTWVuT0VCSU1pRHZBYWpTcUQ3TWVZa1dRVTFsVkky?=
 =?utf-8?B?MjM2SXdPOVorem8zdHZKOGhPYlUvRzJzOVpHU3ZPaC9adGFrY0RNMkNJSHdM?=
 =?utf-8?B?VktNSEdJOUxjeUp1eU5vSFRVNTlDeXN4SE9qeElqUVhGaHNmSDZkb240OEkz?=
 =?utf-8?B?cnVTTTFuRStLZ0cxZU9PZEtRQXNuMU5ZWTd2QVlpOWZDQWtRcVU2WFIrOWNm?=
 =?utf-8?B?dVV4NjZLdVNTQmFVM2s0L1Job1pKcUI4OE52UVNaVnlnbmdUYytsY1BZK08x?=
 =?utf-8?B?cmN5SWZmRVo3UituUmY0OFN5UlV3Z1lrc1hXSlhTR2dJbi9jMGN1MExZVWRY?=
 =?utf-8?B?L2I2bER6czZMM2JObWc3L1FKa3ZJTXVGcnlOb0VRNWdpYXZnb2ZkV3JZVmdq?=
 =?utf-8?B?V3l5RmxwcXloK3hkblJ2VUFpdUpuaFNNdWRjeVRlVHNmRE45RUt1bzhyWHJT?=
 =?utf-8?B?Y3JDVUdKc3ByWlRaZFNRV2RFTUZEMXBTWmpmYWxVdllTUHJuRTl0OG5jVExL?=
 =?utf-8?B?ckg3R3ZKa0ZIMDhyWmU0azh4cGxJT1U0ODVEa3JlenRrWC9KNGlpMGRhUHJJ?=
 =?utf-8?B?Yzc2bG9wUU9jWFl1cEw4aEV0RUt3Y0NIUTROVmpXUmEzcFcyaEFtODdmMU1E?=
 =?utf-8?B?OWF1TzRBY1hyc3dBNENGejQyUk8xSXQrTklValVvRmNrSEhTQXJQMzFBY0xV?=
 =?utf-8?B?QmI0UGdiREVxeURTYUROT2N0TXJibWxGMGZGWktsbzVRV2d3K2RtNVBKYUgx?=
 =?utf-8?B?WldONXY0aTFOeTQvR0xFZ2lCUmhGbk5rSU9NU0V5dzN1ZG5GWDdzWkNCSGM3?=
 =?utf-8?B?dEt3OXhKWTMxWktCenFVaHdHU05QaVFsK0lMV1NpWXQ1WWZzOTFWOVAvNHBy?=
 =?utf-8?B?aVVqZ1RmNnRuRzVxNCtabktXeWJjaFFIYmx1OWJFdTdFY3UxaFpmM3d1UGdn?=
 =?utf-8?B?bkVmdml3SGlrZlFiUzgwV2kzZ1Q2MUdwZGFUWGJ5QWxVYWJqNHhrRVRTNjhp?=
 =?utf-8?B?ejZZUjdVSkcxS0l0UHAwcERnUFUwOE93WGRNMEZXZ29YaWJyZ1E0WHlqK0Iz?=
 =?utf-8?B?N2c3bTN1bXovM1BHZXFwczNhc0VTMWEvMVZ1Y29LQ1RwNU5XYVlnSlRBRE9H?=
 =?utf-8?B?aGtMZE5vdGVteXdhbHJHcEUyeFJNOTFUcyt6cS9pTzZrV2N6d0VXQzlaUkNt?=
 =?utf-8?B?UFJIaVhzTmVEelJhTVZVZlRWRVZaVGhFZGw5a0svMmhPeGcrSW9PT3lSOGhz?=
 =?utf-8?B?c1lva1FINkNBK1Z0SWdKYlptaTRIMHRpQS9JTWJxMlNaOHZJaStWU1U0S2VU?=
 =?utf-8?B?UWF4Ri9peVRWN0JpM3FNalpHSVVJMElqNFhLY2NwWTdvc09vcGZJNFd3Q0Ez?=
 =?utf-8?B?aUpmWnF5TVRjK2JQbm9kdUpjQm1XeGxZRFE0RTVkcWdWQklpODdaYUQzdzA0?=
 =?utf-8?B?RTNpYStqa0dDMzhxSE1DNWtibGtjc3VlMS80bEk4L3YvWHB6Q003ZUl1b3pk?=
 =?utf-8?B?QzBQdVZORVk0S21wZFFVUDI0R0RCVGN5cDJPaDZZbityK3dUY0ZNRWRMUEdl?=
 =?utf-8?B?blFmZ1VaNCtxWjFxVEo3MnRLUitqUElBYU5ScmhETlVnTmlEeE5QNGJML3g3?=
 =?utf-8?B?eDE3QlBsRFlEajBXWHdKemcwM1EvK2Q0WXRKY2gzSGx4WlM0VFZVSS9yVWdY?=
 =?utf-8?B?cE1HWGZXZXU4R2JyOENUUEszVVhhR1kzMzJDVVRCMTNzSjh4YjBkUVRFcVBl?=
 =?utf-8?B?NEVCMm1QV01CUXF3TThZMkNsRUUrWjNKQS9IaE1sQXRkUTFwOWlDNU5IbnlG?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d055e5-6232-41a4-3f74-08db04d959c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 04:52:56.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvRXBTCzA+9D2fJ2ZXhuNRZ9pLujxN7UIMM4ZvODI745qGeSxeYx1LExNEwFTS/w90/PVAr+Rw5P3u2akxKNd0OGt0ZpwsHbl2DtJFLaRzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5595
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGF1cmVudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBM
YXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgSmFudWFyeSAyNywgMjAyMyA1OjQ5IEFNDQo+IFRvOiBpc2hpa2F3YSB5dWpp
KOefs+W3nSDmgqDlj7gg4peL77yy77yk77yj4pah77yh77yp77y077yj4peL77yl77yh6ZaLKQ0K
PiA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD4NCj4gQ2M6IGh2ZXJrdWlsQHhzNGFsbC5u
bDsgbWNoZWhhYkBrZXJuZWwub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKW
oQ0KPiDvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5j
by5qcD47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnOyByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3Jn
OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAzLzZdIG1lZGlhOiBw
bGF0Zm9ybTogdmlzY29udGk6IEFkZCBUb3NoaWJhIFZpc2NvbnRpDQo+IFZpZGVvIElucHV0IElu
dGVyZmFjZSBkcml2ZXIgdXNlciBpbnRlcmFjZQ0KPiANCj4gSGVsbG8gSXNoaWthd2Etc2FuLA0K
PiANCj4gT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgMTA6MjA6MjdBTSArMDAwMCwgeXVqaTIuaXNo
aWthd2FAdG9zaGliYS5jby5qcCB3cm90ZToNCj4gPiBPbiBXZWRuZXNkYXksIEphbnVhcnkgMTgs
IDIwMjMgMTA6MDQgQU0sIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEph
biAxNywgMjAyMyBhdCAxMjo0NzoxMFBNICswMTAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+ID4g
PiA+IE9uIDExLzAxLzIwMjMgMDM6MjQsIFl1amkgSXNoaWthd2Egd3JvdGU6DQo+ID4gPiA+ID4g
QWRkIHN1cHBvcnQgdG8gVmlkZW8gSW5wdXQgSW50ZXJmYWNlIG9uIFRvc2hpYmEgVmlzY29udGkg
QVJNIFNvQ3MuDQo+ID4gPiA+ID4gVGhlIGludGVyZmFjZSBkZXZpY2UgaW5jbHVkZXMgQ1NJMiBS
ZWNlaXZlciwgZnJhbWUgZ3JhYmJlciwNCj4gPiA+ID4gPiB2aWRlbyBETUFDIGFuZCBpbWFnZSBz
aWduYWwgcHJvY2Vzc29yLg0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggcHJvdmlkZXMgdGhlIHVzZXIg
aW50ZXJmYWNlIGxheWVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQSBkcml2ZXIgaW5zdGFuY2Ug
cHJvdmlkZXMgdGhyZWUgL2Rldi92aWRlb1ggZGV2aWNlIGZpbGVzOyBvbmUNCj4gPiA+ID4gPiBm
b3IgUkdCIGltYWdlIGNhcHR1cmUsIGFub3RoZXIgb25lIGZvciBvcHRpb25hbCBSR0IgY2FwdHVy
ZSB3aXRoDQo+ID4gPiA+ID4gZGlmZmVyZW50IHBhcmFtZXRlcnMgYW5kIHRoZSBsYXN0IG9uZSBm
b3IgUkFXIGNhcHR1cmUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaHJvdWdoIHRoZSBkZXZpY2Ug
ZmlsZXMsIHRoZSBkcml2ZXIgcHJvdmlkZXMgc3RyZWFtaW5nIChETUEtQlVGKQ0KPiBpbnRlcmZh
Y2UuDQo+ID4gPiA+ID4gQSB1c2VybGFuZCBhcHBsaWNhdGlvbiBzaG91bGQgZmVlZCBETUEtQlVG
IGluc3RhbmNlcyBmb3IgY2FwdHVyZQ0KPiBidWZmZXJzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
VGhlIGRyaXZlciBpcyBiYXNlZCBvbiBtZWRpYSBjb250cm9sbGVyIGZyYW1ld29yay4NCj4gPiA+
ID4gPiBJdHMgb3BlcmF0aW9ucyBhcmUgcm91Z2hseSBtYXBwZWQgdG8gdHdvIHN1YmRyaXZlcnM7
IG9uZSBmb3IgSVNQDQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gQ1NJMiByZWNlaXZlciAoeWll
bGRzIDEgaW5zdGFuY2UpLCB0aGUgb3RoZXIgZm9yIGNhcHR1cmUgKHlpZWxkcw0KPiA+ID4gPiA+
IDMgaW5zdGFuY2VzIGZvciBlYWNoIGNhcHR1cmUgbW9kZSkuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBZdWppIElzaGlrYXdhIDx5dWppMi5pc2hpa2F3YUB0b3NoaWJhLmNv
LmpwPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IENoYW5nZWxvZyB2MjoNCj4gPiA+ID4gPiAt
IFJlc2VuZCB2MSBiZWNhdXNlIGEgcGF0Y2ggZXhjZWVkcyBzaXplIGxpbWl0Lg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gQ2hhbmdlbG9nIHYzOg0KPiA+ID4gPiA+IC0gQWRhcHRlZCB0byBtZWRpYSBj
b250cm9sIGZyYW1ld29yaw0KPiA+ID4gPiA+IC0gSW50cm9kdWNlZCBJU1Agc3ViZGV2aWNlLCBj
YXB0dXJlIGRldmljZQ0KPiA+ID4gPiA+IC0gUmVtb3ZlIHByaXZhdGUgSU9DVExzIGFuZCBhZGQg
dmVuZG9yIHNwZWNpZmljIFY0TDIgY29udHJvbHMNCj4gPiA+ID4gPiAtIENoYW5nZSBmdW5jdGlv
biBuYW1lIGF2b2lkaW5nIGNhbWVsY2FzZSBhbmQgdXBwZXJjYXNlIGxldHRlcnMNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IENoYW5nZWxvZyB2NDoNCj4gPiA+ID4gPiAtIFNwbGl0IHBhdGNoZXMgYmVj
YXVzZSB0aGUgdjMgcGF0Y2ggZXhjZWVkcyBzaXplIGxpbWl0DQo+ID4gPiA+ID4gLSBTdG9wIHVz
aW5nIElEIG51bWJlciB0byBpZGVudGlmeSBkcml2ZXIgaW5zdGFuY2U6DQo+ID4gPiA+ID4gICAt
IFVzZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQgc3RydWN0dXJlIHRvIGhvbGQgSFcgc3BlY2lmaWMg
Y29udGV4dCwNCj4gPiA+ID4gPiAgICAgaW5zdGVhZCBvZiBzdGF0aWMgb25lLg0KPiA+ID4gPiA+
ICAgLSBDYWxsIEhXIGxheWVyIGZ1bmN0aW9ucyB3aXRoIHRoZSBjb250ZXh0IHN0cnVjdHVyZSBp
bnN0ZWFkDQo+ID4gPiA+ID4gb2YgSUQgbnVtYmVyDQo+ID4gPiA+ID4gLSBVc2UgcG1fcnVudGlt
ZSB0byB0cmlnZ2VyIGluaXRpYWxpemF0aW9uIG9mIEhXDQo+ID4gPiA+ID4gICBhbG9uZyB3aXRo
IG9wZW4vY2xvc2Ugb2YgZGV2aWNlIGZpbGVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2hhbmdl
bG9nIHY1Og0KPiA+ID4gPiA+IC0gRml4IGNvZGluZyBzdHlsZSBwcm9ibGVtcyBpbiB2aWlmLmMN
Cj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS92aXNjb250
aS9NYWtlZmlsZSAgICAgIHwgICAgMSArDQo+ID4gPiA+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vdmlzY29udGkvdmlpZi5jICAgICAgICB8ICA1NDUgKysrKysrKysNCj4gPiA+ID4gPiAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS92aXNjb250aS92aWlmLmggICAgICAgIHwgIDIwMyArKysNCj4g
PiA+ID4gPiAgLi4uL21lZGlhL3BsYXRmb3JtL3Zpc2NvbnRpL3ZpaWZfY2FwdHVyZS5jICAgIHwg
MTIwMQ0KPiArKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL3Zpc2NvbnRpL3ZpaWZfaXNwLmMgICAgfCAgODQ2DQo+ICsrKysrKysrKysrKw0KPiA+ID4g
PiA+ICA1IGZpbGVzIGNoYW5nZWQsIDI3OTYgaW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+ID4gPiA+ID4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS92aXNjb250aS92aWlmLmMNCj4g
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vdmlzY29u
dGkvdmlpZi5oDQo+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiA+IGRyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vdmlzY29udGkvdmlpZl9jYXB0dXJlLmMNCj4gPiA+ID4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vdmlzY29udGkvdmlpZl9pc3Au
Yw0KPiA+ID4NCj4gPiA+IFtzbmlwXQ0KPiA+ID4NCj4gPiA+ID4gPiArc3RhdGljIGludCB2aWlm
X3NfZWRpZChzdHJ1Y3QgZmlsZSAqZmlsZSwgdm9pZCAqZmgsIHN0cnVjdA0KPiA+ID4gPiA+ICt2
NGwyX2VkaWQgKmVkaWQpIHsNCj4gPiA+ID4gPiArCXN0cnVjdCB2aWlmX2RldmljZSAqdmlpZl9k
ZXYgPQ0KPiB2aWRlb19kcnZkYXRhX3RvX2NhcGRldihmaWxlKS0+dmlpZl9kZXY7DQo+ID4gPiA+
ID4gKwlzdHJ1Y3QgdmlpZl9zdWJkZXYgKnZpaWZfc2QgPSB2aWlmX2Rldi0+c2Q7DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICsJcmV0dXJuIHY0bDJfc3ViZGV2X2NhbGwodmlpZl9zZC0+djRsMl9z
ZCwgcGFkLCBzZXRfZWRpZCwNCj4gPiA+ID4gPiArZWRpZCk7IH0NCj4gPiA+ID4NCj4gPiA+ID4g
SGFzIHRoaXMgZHJpdmVyIGJlZW4gdGVzdGVkIHdpdGggYW4gSERNSSByZWNlaXZlcj8gSWYgbm90
LCB0aGVuIEkNCj4gPiA+ID4gd291bGQgcmVjb21tZW5kIGRyb3BwaW5nIHN1cHBvcnQgZm9yIGl0
IHVudGlsIHlvdSBhY3R1YWxseSBjYW4NCj4gPiA+ID4gdGVzdCB3aXRoIHN1Y2ggaGFyZHdhcmUu
DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBEVl9USU1JTkdTIEFQSSBpcyBmb3IgSERNSS9EVkkvRGlz
cGxheVBvcnQgZXRjLiBpbnRlcmZhY2VzLA0KPiA+ID4gPiBpdCdzIG5vdCBtZWFudCBmb3IgQ1NJ
IGFuZCBzaW1pbGFyIGludGVyZmFjZXMuDQo+ID4gPg0KPiA+ID4gTW9yZSB0aGFuIHRoYXQsIGZv
ciBNQy1iYXNlZCBkcml2ZXJzLCB0aGUgdmlkZW8gbm9kZSBzaG91bGQgKm5ldmVyKg0KPiA+ID4g
Zm9yd2FyZCBpb2N0bHMgdG8gYSBjb25uZWN0ZWQgc3ViZGV2LiBUaGUgKm9ubHkqIHZhbGlkIGNh
bGxzIHRvDQo+ID4gPiB2NGwyX3N1YmRldl9jYWxsKCkgaW4gdGhpcyBmaWxlIGFyZQ0KPiA+ID4N
Cj4gPiA+IC0gdG8gdmlkZW8uc19zdHJlYW0oKSBpbiB0aGUgc3RhcnQgYW5kIHN0b3Agc3RyZWFt
aW5nIGhhbmRsZXINCj4gPiA+DQo+ID4gPiAtIHRvIHBhZC5nX2ZtdCgpIHdoZW4gc3RhcnRpbmcg
c3RyZWFtaW5nIHRvIHZhbGlkYXRlIHRoYXQgdGhlIGNvbm5lY3RlZA0KPiA+ID4gICBzdWJkZXYg
b3V0cHV0cyBhIGZvcm1hdCBjb21wYXRpYmxlIHdpdGggdGhlIGZvcm1hdCBzZXQgb24gdGhlIHZp
ZGVvDQo+ID4gPiAgIGNhcHR1cmUgZGV2aWNlDQo+ID4gPg0KPiA+ID4gVGhhdCdzIGl0LCBub3Ro
aW5nIGVsc2UsIGFsbCBvdGhlciBjYWxscyB0byB2NGwyX3N1YmRldl9jYWxsKCkgbXVzdA0KPiA+
ID4gYmUgZHJvcHBlZCBmcm9tIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgdmlkZW9fZGV2aWNl
Lg0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuIEkgdW5kZXJzdGFuZCB0aGUg
cmVzdHJpY3Rpb24uDQo+ID4gSSdsbCByZW1vdmUgZm9sbG93aW5nIGZ1bmN0aW9ucyBjb3JyZXNw
b25kaW5nIHRvIGlvY3Rscy4NCj4gPg0KPiA+ICogdmlpZl9lbnVtX2lucHV0DQo+ID4gKiB2aWlm
X2dfc2VsZWN0aW9uDQo+ID4gKiB2aWlmX3Nfc2VsZWN0aW9uDQo+ID4gKiB2aWlmX2R2X3RpbWlu
Z3NfY2FwDQo+ID4gKiB2aWlmX2VudW1fZHZfdGltaW5ncw0KPiA+ICogdmlpZl9nX2R2X3RpbWlu
Z3MNCj4gPiAqIHZpaWZfc19kdl90aW1pbmdzDQo+ID4gKiB2aWlmX3F1ZXJ5X2R2X3RpbWluZ3MN
Cj4gPiAqIHZpaWZfZ19lZGlkDQo+ID4gKiB2aWlmX3NfZWRpZA0KPiA+ICogdmlpZl9nX3Bhcm0N
Cj4gPiAqIHZpaWZfc19wYXJtDQo+ID4gKiB2aWlmX2VudW1fZnJhbWVzaXplcw0KPiANCj4gVGhp
cyBvbmUgc2hvdWxkIHN0YXksIGl0IHNob3VsZCByZXBvcnQgdGhlIG1pbmltdW0gYW5kIG1heGlt
dW0gc2l6ZXMNCj4gc3VwcG9ydGVkIGJ5IHRoZSB2aWRlbyBub2RlcywgcmVnYXJkbGVzcyBvZiB0
aGUgY29uZmlndXJhdGlvbiBvZiB0aGUgY29ubmVjdGVkDQo+IHN1YmRldi4NCg0KSSdsbCBrZWVw
IGl0Lg0KDQo+ID4gKiB2aWlmX2VudW1fZnJhbWVpbnRlcnZhbHMNCj4gPg0KPiA+IEkgY2FuIGNh
bGwgc3ViZGV2aWNlcyBkaXJlY3RseSBpZiBJIG5lZWQuIElzIGl0IGEgY29ycmVjdCB1bmRlcnN0
YW5kaW5nPw0KPiANCj4gd2hhdCBkbyB5b3UgbWVhbiBleGFjdGx5IGJ5IGNhbGxpbmcgc3ViZGV2
aWNlcyBkaXJlY3RseSA/DQoNCkkgbWVhbnQgdXNlcmxhbmQgY2FuIGNvbmZpZ3VyZSBzdWJkZXZp
Y2VzIHdpdGggL2Rldi92NGwtc3ViZGV2Lg0KDQo+ID4gQXMgZm9yIHZpaWZfdHJ5X2ZtdF92aWRf
Y2FwIGFuZCB2aWlmX3NfZm10X3ZpZF9jYXAsIEknbGwgcmVtb3ZlDQo+ID4gcGFkLmdfZm10KCkg
Y2FsbCB3aGljaCBpcyBmb3IgY2hlY2tpbmcgcGl4ZWwgZm9ybWF0Lg0KPiA+IFRoZSBjaGVjayB3
aWxsIGJlIG1vdmVkIHRvIHZpaWZfY2FwdHVyZV9saW5rX3ZhbGlkYXRlKCkgdmFsaWRhdGlvbg0K
PiA+IHJvdXRpbmUgdHJpZ2dlcmVkIGJ5IGEgc3RhcnQgc3RyZWFtaW5nIGV2ZW50Lg0KPiA+DQo+
ID4gPiBbc25pcF0NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IA0KPiBMYXVyZW50IFBpbmNoYXJ0
DQoNClJlZ2FyZHMsDQoNCll1amkgSXNoaWthd2ENCg==

