Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0C686568
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBAL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBAL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:28:08 -0500
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA81F126D7;
        Wed,  1 Feb 2023 03:28:04 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 311BROBc001850; Wed, 1 Feb 2023 20:27:25 +0900
X-Iguazu-Qid: 2wGrN434gxPpoaPG9S
X-Iguazu-QSIG: v=2; s=0; t=1675250844; q=2wGrN434gxPpoaPG9S; m=L27NDwSHbIYnC7dSUS/MHjSddYKu9I949nlizvHPHAQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1113) id 311BRLtO011893
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Feb 2023 20:27:21 +0900
X-SA-MID: 50148682
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvoS2a58/9iq8HCnAc41TE3/qFd+QGHREc+x36/1hzQLP1AiijSke804r9FHZNvdq30Yatk/LDMXEJgS5KjB1mhitGUv95ND12fmg0d0RcwrSnMZWTz/L2cQvB4ZMIjFwZ0eIteOVdjR1Ms4t5rRySczFNCLPy9g7bL8b9zTNaAIO14VqyUzGhEm84BMM91b37Jd4Z+AoUW8qzOQY6RwXR0YODlwUmSIjrj4fYK+W9Q863R276gkDzqNMA0HhBkBkm8hvnEo1pGchG/UPjpl71dKs+ZsTCJgEvPsTtkW+wfs1vK2Os3yt8/bxBjU7aQyfNjLBJArIwHsyrSsNH1NSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEjaXMVqzDdOSdX/huJoS4jTaCtqoXudYPtztsnAN7s=;
 b=OLStnz1KxLBLCgItTiUw7RjgKrrj64k6EMoq4UGpUd5uSoUU3dryax5PS2CmrJAwBgS+KmuXAxRJexX1BGQ4jXLqk+dsSjBwdOrAkNpoEtImOq8DUzxdeijDZ/mpDB/tl1w8jdkc7sNi8W/lBeMU4H/MVE6wJRzdNyAw4Igbrj3Ef/j8EiRJCemupay+2crcCQX4pQD1IjypWpB5sNPBuWaHQNJqANZusVfDbaeAlYiRO5GXYErDxiXveUBrj6M+sEGVV7H3JSgxG6bZodXZyvU5hDJ54lWp9l059trR7B9ve66J2SF9BWfeaOwfZCdnBb2gMRoGDNVh/CtwGRFSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <laurent.pinchart@ideasonboard.com>
CC:     <sakari.ailus@iki.fi>, <hverkuil@xs4all.nl>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rafael.j.wysocki@intel.com>,
        <broonie@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Topic: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Index: AQHZJWP0bZ/zoVA7GUOz/bXYKEan6q6jPmEAgBY4AbCAAIGuAIAAGeqw
Date:   Wed, 1 Feb 2023 11:22:14 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201A43FFF4572CA8295B1E192D19@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-3-yuji2.ishikawa@toshiba.co.jp>
 <Y8cjqoztUTIL61dP@valkosipuli.retiisi.eu>
 <TYAPR01MB62010040B750701D253C47CB92D19@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <Y9oz5MDMmopBq5h9@pendragon.ideasonboard.com>
In-Reply-To: <Y9oz5MDMmopBq5h9@pendragon.ideasonboard.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OS7PR01MB11583:EE_
x-ms-office365-filtering-correlation-id: c04a88ff-0a0a-4bd4-fe26-08db044691e7
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DaRzcky8mjzpZro92Xe9Ux5iyQbJaU5NFIBpL9I2iiOLGQaAHuWrNd51H70tR5uf6tjT/2i4fioxHG3Fa+PitWJ6/RAuERIrTl8pp2/21FdDdgYJns4eJmZp82caHWC0EApsXoiZLO7xD9bCiMyuH6bRXQA6IZv+rqzB+4vzDAc6mjBODqLrVZht2bxsv3B3CNnVYczrt3+2OiHbVhtm2oiGEq0DO7K8XtLHw1NnbCv8X4NfagUUqF/w/Z2L8NgPedjRPRG60naZ2Po5TmgUfDId+NwZ5NfVET1qGw/I3saGZ7cfqlwrr7AYmVDujlPDuL1pALmsPPIF8vKj7s5CYvJkKSXHIBlYPJxUMNrpXEVgNMphCJoY+0Y7PNda/x1/Pl4iq6/IyAiiPW0S+2j81strG5eqGr0eFrnRllsJ1k4jOr0jUp28ACV9v7mCXAFUXUk1Tn/SaYBBkKBqwELylqikaWEzPL9ro2s+jO6CcjynTD6po6xUc11tTv/EB+CFtl5SU+cuTqKa6fZoOTs2rgnidvp3KDGKnwXX83zHBP0DZA2QozrMfIAiEDKu6FQ6t6SKluXsXNG5K3v9joFM41WXIqWLl0NiVW6Rn7GU+h67xC1738aNapyxK9TaZVnh1LkmPRJhKjWOJImvR5ZwXwLAMqt1psmhp541zS+KOoDPy96mSNBpxjmHnXL8FOXxgDG8/U1XYBAjKaA8Nh66Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199018)(33656002)(5660300002)(316002)(54906003)(83380400001)(478600001)(53546011)(41300700001)(7696005)(7416002)(186003)(26005)(9686003)(6506007)(71200400001)(38070700005)(76116006)(6916009)(86362001)(52536014)(55016003)(38100700002)(66946007)(8936002)(8676002)(122000001)(64756008)(66446008)(66476007)(66556008)(4326008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTdEOW5hN1pzWkpmanFIZXRzQ0Q5cWpCcUwvcGFpd1RMbk1JbjBac2hsY0Fk?=
 =?utf-8?B?aHhuTkw4WVNBMHczVHVtMFAvQjhaQUFmWW01dGVVdExJMm1Hem5ocHZnYmho?=
 =?utf-8?B?Y2duRTg2dldXTkcxVHc0Y20wTE5HaWV4UmRKbnJTZnFSakJPQWhMcW5kQWN3?=
 =?utf-8?B?a2tKTWd0N3Rma1lzZDMvd0w5b2QvRy8yQk5LZ1N6M3J1OGNZQU9oalhXVkVW?=
 =?utf-8?B?bUtpcTlXa3N5MnA4TUQyWk1XUmN6aG1ONitWSG9kNnFTeGZBL3FHOGR2eTJa?=
 =?utf-8?B?SXY2MFU4SEpDRVQ3RlhJWUhuYmhMUzNPUEdiVmxVQUpSditGV1BuaVBtSGg1?=
 =?utf-8?B?TDVMVC9TM09jdmZ0dVZST0NuRjlWQ1VCYjJJNXR1UlNxR29CMkdOUnFISk03?=
 =?utf-8?B?alFjUEJlZGhKMnlWMEpNd3lVNXVTWFlKanFSM3BpTnl0SzBwYy9YdG4vbHk4?=
 =?utf-8?B?M3NnaHJWeVJHYlhPNXNESDBORnBURDRVYmY4WUVzT3prc2VMWStiWTNMTmxH?=
 =?utf-8?B?QU9IRUNiOGFmT1oxN2o4NXlKckZJSUN5ZGFyU3hJMTRoZ0dTZkoxY1MxOFZt?=
 =?utf-8?B?RjhGalAxYkRoODh1dWhvdDJBT2lOVnllNmxWL0NzSnY5eU1FTTNwVHRaNW5W?=
 =?utf-8?B?bTNQNXY4c25rQ2hpcWFYTlVidDUxWTZWL0tXMldqbHlFMmtjQVNrS3ExV0Vn?=
 =?utf-8?B?d1FCTTZucnVnREU4c1ovRW9HWUhTa0YxZ1ZuR3FHUktlMVpJd3dzREd4Nllx?=
 =?utf-8?B?VFZ1WG0wejdmSVNmZENrblN0TDdnT09wdTZ5UlZxVTZXS21zTU04VS9kcGJI?=
 =?utf-8?B?ZUxnRzljclEyd3VralFJb0lNV0dSUEhKZy8wSHBTVEtBVzF3SnVPaEw1b3ZY?=
 =?utf-8?B?NTJvMmZRSkViTWtkcm5rTDJKemdQQXc1QjJmRThXT2w1SFVqYXpkOUZacGNx?=
 =?utf-8?B?U1BhQUZYWDJKcEJKMFpBZ3dsUmJzb1FJVHFvNnFrSlZVb1ExMEpuZExvZUxy?=
 =?utf-8?B?RS8zQTN5RE5CTWFiVVBMbjRHTWx2RWJKSnhkVzJESzIvZUJuOUxNRDgvdk9o?=
 =?utf-8?B?NTRSa1Z2dUpaaDFZTlRvQ1U2cVlMU1RzQUJWSDVwVXZWMDNsZUlLNUNaK2tP?=
 =?utf-8?B?MXhNNytrZGU2WWRqL29pTGJiZENaeDd5NkpLcUpvYmREbi9jZXlxVTBJdGR2?=
 =?utf-8?B?L2d3YTQ4b2hybXdoR0hpWlpvaVRrNWRXTXZLZTV2UWhSRXk0MWtnMmllNHlv?=
 =?utf-8?B?WjJHc2tvS00yRnpFVm0zVjA0bmRVV1pScENhcm9TZHNLbUtDNWJlOFZWaEcv?=
 =?utf-8?B?U3NMNzhrYkZ2M0pWSEpjN0xYOVhtMno0ZTcvemoxN1JFMmNYNDJUb25YZVA5?=
 =?utf-8?B?VllqRGg4RE1EcHV2UUQ2L2JsRjg1by9yMFdvZEViS0JpL0xnclIwZHh6aEpw?=
 =?utf-8?B?ZlF5aXVHVDZJNGp6bE5GMi9MSStBSC91aDFxc3RpaHkzSjhPZ1MvSUx2ZEo5?=
 =?utf-8?B?QlptOG81bStLdWN4N0dydUZJM3hmaDlONVVkVXFLUUNrUyswNmpzWmZ1NE1l?=
 =?utf-8?B?VmJYTjI2YWVxOXUyS1RUVVE2Zzh2aWF4Y0t4aDR1YmRxMVlhTHYvRmtXWXFH?=
 =?utf-8?B?WlUraGxGN3ZhSTFZa3oyQjR4OFArNG1tUzFXZGx2djU2TzRpeXA3cDBvWlVB?=
 =?utf-8?B?RUhKZUJGL251SGV2aUdHaW5FN2lpVWtwNlFpNGxxSTY3V21GZFJkYytSZTho?=
 =?utf-8?B?bFFEbHVqYTFNQ2ZpOG9WTklHQjZMbXNTeVdYVUVTb3JEb29qc2NkNXJ2N3Fa?=
 =?utf-8?B?akNCTTZranBuQ2JhL2VVNDBwMUZnaHFkZ2JUUTdhQjV0eXliZWtnREpwakZH?=
 =?utf-8?B?THYwdzJBcGZYcURkNXRNamF4K1kraHZubElXU2Rqb2IzaUozWjk5TTlCVUxn?=
 =?utf-8?B?K1ZBNkoxRGxrcGlnSlF6aFBNaStWNEozUU5yMUpOcXh1UUMvakdHSGpmSVFi?=
 =?utf-8?B?Tngza01QUms0WkRKZThxTDRKWU5XZXpLTXNpYllrVlRoczNuRk9OcXYwZnMr?=
 =?utf-8?B?WkMrQ2gzL0N4R1pjRFVNV3RFaGxtUEgrQVlzUnd4amMzT0pRVDRaNklPaXhC?=
 =?utf-8?B?em9wNVdyZEdnRThxMXFXejhVQStMQ1BIYnhoVDFIWFM3TlhZRm8yNU5HNUd3?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04a88ff-0a0a-4bd4-fe26-08db044691e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 11:22:14.5022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoyBK2u8FNdQz6BzsEzklKu2OXlq4BHCz8BfRnidjqvHGNlEGaiIL2PVzSh72/4amgPmkiNFz6cNbyNxxGlzPuP7PXNwgIlWsKDWteBKwpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11583
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGF1cmVudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBM
YXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMSwgMjAyMyA2OjQyIFBNDQo+IFRvOiBpc2hpa2F3YSB5
dWppKOefs+W3nSDmgqDlj7gg4peL77yy77yk77yj4pah77yh77yp77y077yj4peL77yl77yh6ZaL
KQ0KPiA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD4NCj4gQ2M6IHNha2FyaS5haWx1c0Bp
a2kuZmk7IGh2ZXJrdWlsQHhzNGFsbC5ubDsgbWNoZWhhYkBrZXJuZWwub3JnOyBpd2FtYXRzdQ0K
PiBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwu
Y29tOyBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY1IDIvNl0gbWVkaWE6IHBsYXRmb3JtOiB2aXNjb250aTogQWRkIFRvc2hpYmEgVmlz
Y29udGkNCj4gVmlkZW8gSW5wdXQgSW50ZXJmYWNlIGRyaXZlcg0KPiANCj4gSGVsbG8gSXNoaWth
d2Etc2FuLA0KPiANCj4gT24gV2VkLCBGZWIgMDEsIDIwMjMgYXQgMDI6MDI6NDNBTSArMDAwMCwg
eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcCB3cm90ZToNCj4gPiBIZWxsbyBTYWthcmksDQo+
ID4NCj4gPiBTb3JyeSBmb3Igc2VuZGluZyB0aGUgcmVwbHkgYWdhaW4uDQo+ID4gTXkgbWFpbCBh
Z2VudCBwb3N0ZWQgdGhlIHByZXZpb3VzIG9uZSB3aXRoIEhUTUwgZm9ybWF0Lg0KPiA+DQo+ID4g
VGhhbmsgeW91IGZvciByZXZpZXdpbmcgYW5kIHlvdXIgY29tbWVudHMuDQo+ID4NCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTYWthcmkgQWlsdXMgc2FrYXJp
LmFpbHVzQGlraS5maQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDE4LCAyMDIzIDc6
NDAgQU0NCj4gPiA+IFRvOiBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDlj7gg4peL77yy77yk77yj
4pah77yh77yp77y077yj4peL77yl77yh6ZaLKQ0KPiA+ID4geXVqaTIuaXNoaWthd2FAdG9zaGli
YS5jby5qcA0KPiA+ID4gQ2M6IEhhbnMgVmVya3VpbCBodmVya3VpbEB4czRhbGwubmw7IExhdXJl
bnQgUGluY2hhcnQNCj4gPiA+IGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbTsgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+ID4gPiBtY2hlaGFiQGtlcm5lbC5vcmc7IGl3YW1hdHN1IG5v
YnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA+ID4gbm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA7IFJvYiBIZXJyaW5nIHJvYmgrZHRAa2VybmVs
Lm9yZzsNCj4gPiA+IEtyenlzenRvZiBLb3psb3dza2kga3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOyBSYWZhZWwgSiAuDQo+ID4gPiBXeXNvY2tpIHJhZmFlbC5qLnd5c29ja2lAaW50
ZWwuY29tOyBNYXJrIEJyb3duIGJyb29uaWVAa2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LW1lZGlh
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi82XSBtZWRpYTogcGxhdGZvcm06
IHZpc2NvbnRpOiBBZGQgVG9zaGliYQ0KPiA+ID4gVmlzY29udGkgVmlkZW8gSW5wdXQgSW50ZXJm
YWNlIGRyaXZlcg0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS92aXNjb250aS9od2RfdmlpZl9yZWcuaA0KPiA+ID4gPiBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vdmlzY29udGkvaHdkX3ZpaWZfcmVnLmgNCj4gPiA+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAuLmI3ZjQzYzVmZTk1DQo+
ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS92aXNjb250aS9od2RfdmlpZl9yZWcuaA0KPiA+ID4gPiBAQCAtMCwwICsxLDI4MDIgQEANCj4g
PiA+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIEJTRC0yLUNsYXVz
ZSAqLw0KPiA+ID4gPiArLyogVG9zaGliYSBWaXNjb250aSBWaWRlbyBDYXB0dXJlIFN1cHBvcnQN
Cj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiAoQykgQ29weXJpZ2h0IDIwMjIgVE9TSElCQSBDT1JQ
T1JBVElPTg0KPiA+ID4gPiArICogKEMpIENvcHlyaWdodCAyMDIyIFRvc2hpYmEgRWxlY3Ryb25p
YyBEZXZpY2VzICYgU3RvcmFnZQ0KPiA+ID4gPiArQ29ycG9yYXRpb24gICovDQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyNpZm5kZWYgSFdEX1ZJSUZfUkVHX0gNCj4gPiA+ID4gKyNkZWZpbmUgSFdEX1ZJ
SUZfUkVHX0gNCj4gPiA+ID4gKw0KPiA+ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBzdHJ1Y3QgaHdk
X3ZpaWZfY3NpMmhvc3RfcmVnIC0gUmVnaXN0ZXJzIGZvciBWSUlGIENTSTJIT1NUDQo+ID4gPiA+
ICtjb250cm9sICAqLyBzdHJ1Y3QgaHdkX3ZpaWZfY3NpMmhvc3RfcmVnIHsNCj4gPiA+ID4gKyAg
ICB1MzIgUkVTRVJWRURfQV8xOw0KPiA+ID4gPiArICAgIHUzMiBDU0kyUlhfTkxBTkVTOw0KPiA+
ID4gPiArICAgIHUzMiBDU0kyUlhfUkVTRVROOw0KPiA+ID4gPiArICAgIHUzMiBDU0kyUlhfSU5U
X1NUX01BSU47DQo+ID4gPiA+ICsgICAgdTMyIENTSTJSWF9EQVRBX0lEU18xOw0KPiA+ID4gPiAr
ICAgIHUzMiBDU0kyUlhfREFUQV9JRFNfMjsNCj4gPiA+ID4gKyAgICB1MzIgUkVTRVJWRURfQl8x
WzEwXTsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX1BIWV9TSFVURE9XTlo7DQo+ID4gPiA+ICsg
ICAgdTMyIENTSTJSWF9QSFlfUlNUWjsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX1BIWV9SWDsN
Cj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX1BIWV9TVE9QU1RBVEU7DQo+ID4gPiA+ICsgICAgdTMy
IENTSTJSWF9QSFlfVEVTVENUUkwwOw0KPiA+ID4gPiArICAgIHUzMiBDU0kyUlhfUEhZX1RFU1RD
VFJMMTsNCj4gPiA+ID4gKyAgICB1MzIgUkVTRVJWRURfQl8yWzM0XTsNCj4gPiA+ID4gKyAgICB1
MzIgQ1NJMlJYX0lOVF9TVF9QSFlfRkFUQUw7DQo+ID4gPiA+ICsgICAgdTMyIENTSTJSWF9JTlRf
TVNLX1BIWV9GQVRBTDsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX0lOVF9GT1JDRV9QSFlfRkFU
QUw7DQo+ID4gPiA+ICsgICAgdTMyIFJFU0VSVkVEX0JfM1sxXTsNCj4gPiA+ID4gKyAgICB1MzIg
Q1NJMlJYX0lOVF9TVF9QS1RfRkFUQUw7DQo+ID4gPiA+ICsgICAgdTMyIENTSTJSWF9JTlRfTVNL
X1BLVF9GQVRBTDsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX0lOVF9GT1JDRV9QS1RfRkFUQUw7
DQo+ID4gPiA+ICsgICAgdTMyIFJFU0VSVkVEX0JfNFsxXTsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJ
MlJYX0lOVF9TVF9GUkFNRV9GQVRBTDsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX0lOVF9NU0tf
RlJBTUVfRkFUQUw7DQo+ID4gPiA+ICsgICAgdTMyIENTSTJSWF9JTlRfRk9SQ0VfRlJBTUVfRkFU
QUw7DQo+ID4gPiA+ICsgICAgdTMyIFJFU0VSVkVEX0JfNVsxXTsNCj4gPiA+ID4gKyAgICB1MzIg
Q1NJMlJYX0lOVF9TVF9QSFk7DQo+ID4gPiA+ICsgICAgdTMyIENTSTJSWF9JTlRfTVNLX1BIWTsN
Cj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX0lOVF9GT1JDRV9QSFk7DQo+ID4gPiA+ICsgICAgdTMy
IFJFU0VSVkVEX0JfNlsxXTsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJMlJYX0lOVF9TVF9QS1Q7DQo+
ID4gPiA+ICsgICAgdTMyIENTSTJSWF9JTlRfTVNLX1BLVDsNCj4gPiA+ID4gKyAgICB1MzIgQ1NJ
MlJYX0lOVF9GT1JDRV9QS1Q7DQo+ID4gPiA+ICsgICAgdTMyIFJFU0VSVkVEX0JfN1sxXTsNCj4g
PiA+ID4gKyAgICB1MzIgQ1NJMlJYX0lOVF9TVF9MSU5FOw0KPiA+ID4gPiArICAgIHUzMiBDU0ky
UlhfSU5UX01TS19MSU5FOw0KPiA+ID4gPiArICAgIHUzMiBDU0kyUlhfSU5UX0ZPUkNFX0xJTkU7
DQo+ID4gPiA+ICsgICAgdTMyIFJFU0VSVkVEX0JfOFsxMTNdOw0KPiA+ID4gPiArICAgIHUzMiBS
RVNFUlZFRF9BXzI7DQo+ID4gPiA+ICsgICAgdTMyIFJFU0VSVkVEX0FfMzsNCj4gPiA+ID4gKyAg
ICB1MzIgUkVTRVJWRURfQV80Ow0KPiA+ID4gPiArICAgIHUzMiBSRVNFUlZFRF9BXzU7DQo+ID4g
PiA+ICsgICAgdTMyIFJFU0VSVkVEX0FfNjsNCj4gPiA+ID4gKyAgICB1MzIgUkVTRVJWRURfQl85
WzU4XTsNCj4gPiA+ID4gKyAgICB1MzIgUkVTRVJWRURfQV83Ow0KPiA+ID4NCj4gPiA+IFRoZXNl
IHNob3VsZCBiZSBsb3dlciBjYXNlLCB0aGV5J3JlIHN0cnVjdCBtZW1iZXJzLg0KPiA+ID4NCj4g
PiA+IFRoaXMgd2F5IG9mIGRlZmluaW5nIGEgaGFyZHdhcmUgcmVnaXN0ZXIgaW50ZXJmYWNlIGlz
IGhpZ2hseQ0KPiA+ID4gdW5jb252ZW50aW9uYWwuIEknbSBub3Qgc2F5aW5nIG5vIHRvIGl0LCBu
b3Qgbm93IGF0IGxlYXN0LCBidXQNCj4gPiA+IHNvbWV0aGluZyBzaG91bGQgYmUgZG9uZSB0byBt
YWtlIHRoaXMgbW9yZSByb2J1c3QgYWdhaW5zdCBhY2NpZGVudGFsDQo+ID4gPiBjaGFuZ2VzOiBh
ZGRpbmcgYSBmaWVsZCBpbiB0aGUgbWlkZGxlIGNoYW5nZXMgdGhlIGFkZHJlc3Mgb2YNCj4gPiA+
IGFueXRoaW5nIHRoYXQgY29tZXMgYWZ0ZXIgaXQsIGFuZCBpdCdzIHJlYWxseSBkaWZmaWN1bHQg
dG8gc2F5IGZyb20NCj4gPiA+IHRoZSBjb2RlIGFsb25lIHRoYXQgdGhlIGFkZHJlc3Mgb2YgYSBn
aXZlbiByZWdpc3RlciBpcyB3aGF0IGl0J3MgaW50ZW5kZWQgdG8gYmUuDQo+IE1heWJlIHBhaG9s
ZSB3b3VsZCBzdGlsbCBoZWxwPw0KPiA+ID4gQnV0IHNvbWUgZG9jdW1lbnRhdGlvbiB3b3VsZCBi
ZSBuZWVkZWQgaW4gdGhhdCBjYXNlLg0KPiA+ID4NCj4gPiA+IEkgd29uZGVyIHdoYXQgb3RoZXJz
IHRoaW5rLg0KPiA+DQo+ID4gSSB1bmRlcnN0YW5kIHRoZSByaXNrLg0KPiA+IEknbGwgcmVtb3Zl
IHRoZXNlIHN0cnVjdC1zdHlsZSBkZWZpbml0aW9uIGFuZCBpbnRyb2R1Y2UgbWFjcm8gc3R5bGUg
ZGVmaW5pdGlvbi4NCj4gPiBJJ3ZlIGhlc2l0YXRlZCB0aGlzIG1pZ3JhdGlvbiBzaW1wbHkgYmVj
YXVzZSBpdCBzZWVtZWQgZGlmZmljdWx0IHRvDQo+ID4gY29tcGxldGUgd2l0aG91dCBhbnkgZGVm
ZWN0cyBlc3BlY2lhbGx5IG9uIGNhbGN1bGF0aW5nIHRoZSBvZmZzZXQgb2YgZWFjaA0KPiBtZW1i
ZXIuDQo+ID4gSSB0cnkgZmluZCBhIHNlcmllcyBvZiBvcGVyYXRpb25zIHRoYXQgd2lsbCBjb21w
bGV0ZSB0aGUgbWlncmF0aW9uIHNhZmVseS4NCj4gDQo+IEkgYWdyZWUgd2l0aCB5b3UgYWJvdXQg
dGhlIG1pZ3JhdGlvbiByaXNrLiBNYXliZSBhIHNjcmlwdCB0aGF0IHBhcnNlcyB0aGUgaGVhZGVy
DQo+IGZpbGUgYW5kIGdlbmVyYXRlcyBtYWNyb3Mgd291bGQgdGFrZSBsZXNzIHRpbWUgdG8gaW1w
bGVtZW50IHRoYW4gZG9pbmcgaXQNCj4gbWFudWFsbHksIGFuZCB3b3VsZCBiZSBzYWZlciA/DQoN
ClRoYW5rIHlvdSBmb3IgdGhlIGFkdmljZS4NCkknbSBhbHNvIHRoaW5raW5nIGFib3V0IGdlbmVy
YXRpbmcgbWFjcm8gZGVmaW5pdGlvbnMgZnJvbSBoZWFkZXJzLg0KVGhlIHBhaG9sZSB0b29sIG1p
Z2h0IGhlbHAgbWUgY2hlY2tpbmcgaWYgdGhlIGdlbmVyYXRlZCBtYWNyb3MgYXJlIGNvcnJlY3Qu
DQoNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IA0KPiBM
YXVyZW50IFBpbmNoYXJ0DQoNClJlZ2FyZHMsDQpZdWppIElzaGlrYXdhDQo=

