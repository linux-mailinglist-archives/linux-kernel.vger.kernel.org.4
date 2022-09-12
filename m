Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9140D5B6307
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiILVtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiILVtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:49:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B084D262;
        Mon, 12 Sep 2022 14:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAVk7eZsMvoMTcG1Zx3OcQeVABztaGQPWpgq/I7Zv0oeOq6Dl6QYw971ZiiEUpUwP2Nh7f6ngIF4ymJp7GIqBVszl5D3Be1V/KguZJYGLvx71FkjkeJuLluXnw6NVH7ulQmcqKAXYJnmRhALPB8zh5wESUqVV7IIe6cvjtxC+6zrQVPYTFMYZd9YFizypvWhn9j4twTi7FQTUngUOuDekhv6cUATcBYsh8X0SrLJUpw1bUvaLrZvhn2xdZFaF5YYT/f0WxiEX+wohX13rySCEQFNOCSKJfMP+Vc4ah19Cqg4TKmGNJPGCBOLmkwFWBv1JhEQaSolRvqpJE4DGqXIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg5Dto3hm31svV6Cseejvrjd+Q61nxrJVgvBENklXKM=;
 b=GcXmOQtJYgdot/C9mRKwuqokYfPvFr5d/TU6JcR4TqkAIUUOmvB9Z5Kn5R19rOi7SaT6NtX8u8jRuTv3h33KOjbMEkErLwm62k0sQo05LABrAjJp2l0aZ0/q/ylsf0UnCrWHC0ms/yMdpgfRQ+2CBIb4C2S4bAw/p+UwfoDpPZAQWl4uzBtq+nMXmesI+LE1NHnPRAynKsLfVp4wvp987uL0qmSYBI6uKPi/PQGzWmYYVjPUqzgJSdGpE4HXEAdUzkBFYe/5U+ICi2JOpje2EsigXhd9cVVUTLt2Hp9BjxuSpo49U8YXCjyC2psWofnQJM5+vx9zEfgwmtYitNWcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg5Dto3hm31svV6Cseejvrjd+Q61nxrJVgvBENklXKM=;
 b=GgnomSHmhnVoZba08p1jzWET4LJeXh42qvyGBmahLWtUwUrua2xuR6nulI4w2FsdP64e5gbdBUw9w5DbXkLty9e6MOqg4Qb/O/rdXdvsbAukgsxBM+hOikAJKIOTCU73WU0jK8hS+wBZnZhjMiFTbAsVVRDLUvTBWX8z5g4QW44=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by DB8PR04MB6922.eurprd04.prod.outlook.com (2603:10a6:10:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 21:49:15 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7d0b:b02:69b9:a3b4]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7d0b:b02:69b9:a3b4%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 21:49:15 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Thread-Topic: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Thread-Index: AQHYsneOky2+HjmY4EWzmWjEy+MxQq3bhxCAgADwraA=
Date:   Mon, 12 Sep 2022 21:49:15 +0000
Message-ID: <AM0PR04MB62897008C9AC1B2456B1F5FC8F449@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20220817202538.21493-1-leoyang.li@nxp.com>
 <20220817202538.21493-2-leoyang.li@nxp.com>
 <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
In-Reply-To: <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|DB8PR04MB6922:EE_
x-ms-office365-filtering-correlation-id: 8143aa84-3e25-44fa-95bd-08da9508a32b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svRnpmxyDoe3n6RGA/T2bY5KqGAPaXx4SrUELaTpLNTLDFUsubnJ8v2xidaHFbakVtqxnicaMY4vNP1hT9YS3ACap1Z8/q7IhAutECdC4q8daDwYfxS5PhfT9b9u7OhknLl1ttuSnV/BO8MDopdkybgcPzZnlBk9gVlKZgFudvpQi4NkH70tQ6iiTUc4iGRfDOFMte9s3PJRoxS3wW8YFeeM+OsubrDiYQbku/KO6nNqjS3NIR6jdJaSKuKp6CEzun8Iaec37ZMlFbLCsEIGnhixejngTEndcesq4FGnPj+wb1z1jKxLQB1DIhbN0JQrSvWZmtRfZXpxlQH2n4apQmarWyO+YHM19q2vZ4LEch2fxKYBJgwSOeI9+RSGj925dwNznCQUnoVs4stFYFCBC5C4KvA4voDHfWlQNzdQxye3WufSFLqo9iIaZUZuUGTFU3fz17JDJkUkvbp7XlV7CmCeCaJ5K8UehFjjgnLnBPg8klbjmJYeT2W15IcLJk2hG62JtDtuRlZhk/tbLWfXGbw5CvSj7IG4Egpt9tivJCsF/ygEMRYV18ZiKTUz+tpNyZQ+SRH/ZrBKJrZoUTl4VtITzhs4aNu5O3Gzq4DiE81eKEG0tATAbQxB9AeCFweU/OwoqB94K5q61pLRUENOmrop6nmFSC3pEESKGI+88RunVPRMDTG2Pcar68bo2iNR7hC5q0kTtrwkktv9L2JnvjYYxxfc2uoPHtGZEDG3oMrw3l81U0j//vd1OMde1kWSkbHBlsJFhaduYALSkoRZMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(41300700001)(5660300002)(54906003)(71200400001)(8676002)(38100700002)(66946007)(4326008)(186003)(122000001)(86362001)(64756008)(66556008)(66446008)(6916009)(76116006)(2906002)(8936002)(9686003)(15650500001)(55016003)(316002)(66476007)(478600001)(52536014)(33656002)(7696005)(55236004)(26005)(53546011)(6506007)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnZOM3BDOHM3SWpRRE1WbXlQWFhtUTVjT2YxVFpvRzhybEpMaUgrWUVHQWU2?=
 =?utf-8?B?V2VZKzlXU3RJYW5VVDJrT1d0YksvcllGVjA2UVhPNjlBK3l1S0RqZisyVjkv?=
 =?utf-8?B?WXcwcU5ST0hiUzhJaXFpdHNKZkhPN2l5NTA4dnZOb3pQa3JPRm9oR3FWek5J?=
 =?utf-8?B?TU5JQ1Y3cEdTZTMvS081MHNYVDNFVFNtL2ZDQUVkVjJVQk9BSWtWU2tzNmlD?=
 =?utf-8?B?QU1iWmtvM1JzSUVOMG9idjVqK2ZnTUZkZWJZNUNLZkVrcmFBTEZ6MVlGSXVB?=
 =?utf-8?B?TE9na0oyc1hoZWIwMXZ0Nk42cDN6ZTN0YWxnTlJOVzAwNzU5OElYVU9KZVRH?=
 =?utf-8?B?ZmNSekxCS2V6SWp1STBNM01nQWFucnViNVhYYjl4aHp5OWIwVWx4UzFCYmN6?=
 =?utf-8?B?Q1ZMaTd1UXE0dHhFdXMwQzB1OC9rWHlrVkZteWJmR1hVVFNSWFFheVAxNHlY?=
 =?utf-8?B?eXZyR3hDMHNjbVJCRVBFeisrUXdOdk54cFV6bEdOQlpGbWp1L1U3dEV0bitj?=
 =?utf-8?B?UHlGK1djdFZEcERTbGs2SU0rYzkvelBtTGF0ZWk3R3lhU2NiVGlSREdOVHFI?=
 =?utf-8?B?YnBLT3BYanJTZk5JSTVnODNJWG1NaG43Nm1meC8ybmxnZjdIaU82YjR2RllY?=
 =?utf-8?B?SS9PcFYrM0Fjb2pOcW9tM1lJVEwyU25rbVlZTmtjekdtZ3JOSFZCTHd4MEY5?=
 =?utf-8?B?TUxjYm9LV3pNK0ZkYUFvL3VRNHB2SEs1Z3cxa0NQelFNVTZHdk5GVkZ0SnFE?=
 =?utf-8?B?aFBTSFlMa2wwL1M2R0ZacVY4bm43VzladFdSNFB1SkNGamt4MFFyME9URUhw?=
 =?utf-8?B?TDlrMG1TVDQrRE1jaW1BTndQNDFwVHBCYlZIeEM4QzBpd1p4NktVRjY1cGli?=
 =?utf-8?B?bGtybXExVFlwK2VoNlpDdDlVbElBSFZZZXhSaWpIM2VDUENud051MU9Lelg0?=
 =?utf-8?B?czM0THNrRk1BWW5yWHh5VjBhOVdYaC85RXovWEQ0LzJEWStwTkowTHhVdEdn?=
 =?utf-8?B?NGJoZDFjQlgwM2pQMVE1SDF6eVE3blFGL2pOeHd5ZFAxd0dPV0g4cmV1eTJC?=
 =?utf-8?B?Q3pscFBER3R0bzVVbmpxTXVvdnBVL09NVFdlcUVPWW5ZTVBId2tXRXZsSk1Z?=
 =?utf-8?B?ZU5YRDV6Q0ppWEtGNGhVc0d4NDkxeHRTZnZFUStOYUNVQUNzb3ZnUXZMOWpT?=
 =?utf-8?B?dnpwTFcrVDRVNEVCaDg0OXgzK3F0Mm5ueTVWSDRyV2VFYVU2WlpGVS9zbVFN?=
 =?utf-8?B?ZFBEQ1B4eTVKQkpXcmFmWDVkbVNDdDZzaUR2UWdWeVZHSm1LU0JsajNFOVBB?=
 =?utf-8?B?WlBjMUdQUVBwZHdOZk91b0lKa3lNS1Byd2M0NXhYMHJsOCtzRmZGUmJjaVp3?=
 =?utf-8?B?U3diNzA4QWR2N1R4N2dGeFJWWDBSNWVRNGZrOGNsd1ZTMXQ4TFBHbEMvUDgr?=
 =?utf-8?B?Z0ZkYjdwME5PaDMxRXQxTTdMMEsxVU05VHkvWlZCR01mUENkU1NkVW5JNUYr?=
 =?utf-8?B?NTZoZE5aWUJpY1hVeUJETTJSQ2NPQjMrRG5rUnUraW9RanZBcTIzK3ZLL1BK?=
 =?utf-8?B?anROajRLTlN4YVhlQTE2YUJISmNGYjMxczNyZnZaWTdVMTFRL29YWHlnOEt0?=
 =?utf-8?B?UTFBY2l5MG5DTEhmNGNIQXBVNlpWdk5JM2ZMNXV0aUl2UWU4UXVyeEczQmhG?=
 =?utf-8?B?WjlpZzFFZklFTDVMY3Q2RW5IK0ZYcjd0SXYxcWtIbjZPdkZMTVhJZWZNYWkr?=
 =?utf-8?B?Z3l5QUpxaElRbnp5RmpMaWd3MFFrVDRHTWU3YWRqeXZnKzc1U0JWdW0ranpQ?=
 =?utf-8?B?RldlYzN4WWJBNS8vY2xpL2FSQjQ0VHFvTWZ0ZUN2SndnS1BhMUJYR2cyaXpS?=
 =?utf-8?B?cXBHNGZ1WStUVDJUMmxGRE1tTFRjR1UxSDNyaUp3VnMvS2RDQmNwNk1kMUkx?=
 =?utf-8?B?WFA0bnc3bzRHZGtrcnJmNi9CK3BWNk1RQ0NDbGhSYjFEUGVHeTdGRytDUy93?=
 =?utf-8?B?NzZ0K2RkdTZiUndta1RUV0NwVkdWenlzYkYzVTVLdldtb0VlUEp2MUN5M05x?=
 =?utf-8?B?WmpGN05DSGdZVVBQV2ZEWjRsODJ5dUN1eXBlNm5rTTNpOXFpNWdUSktjOVcx?=
 =?utf-8?Q?h1mDrCCWJQ9GeH5oAfxt1DGYk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8143aa84-3e25-44fa-95bd-08da9508a32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 21:49:15.5853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 418WtXtoBmmSwFIULlWS6nVL254WWCSIZkBL9MfuLHaJB1sLggiz3zPazGNGZyj6z/fTu5rQMVI9bLjd7pgHRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xvZiBKb2hhbnNzb24g
PG9sb2ZAbGl4b20ubmV0Pg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMiwgMjAyMiAyOjA1
IEFNDQo+IFRvOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIGFybTY0OiBkdHM6IGx4MjE2MGE6IHVwZGF0ZSBQQ0ll
IG5vZGVzIHRvIG1hdGNoDQo+IHJldjIgc2lsaWNvbg0KPiANCj4gSGksDQo+IA0KPiBPbiBXZWQs
IEF1ZyAxNywgMjAyMiBhdCAxOjI2IFBNIExpIFlhbmcgPGxlb3lhbmcubGlAbnhwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGUgb3JpZ2luYWwgZHRzIHdhcyBjcmVhdGVkIGJhc2VkIG9uIHRoZSBu
b24tcHJvZHVjdGlvbiByZXYxIHNpbGljb24NCj4gPiB3aGljaCB3YXMgb25seSB1c2VkIGZvciBl
dmFsdWF0aW9uLiAgVXBkYXRlIHRoZSBQQ0llIG5vZGVzIHRvIGFsaWduDQo+ID4gd2l0aCB0aGUg
ZGlmZmVyZW50IGNvbnRyb2xsZXIgdXNlZCBpbiBwcm9kdWN0aW9uIHJldjIgc2lsaWNvbi4NCj4g
DQo+IEhvdyBjYW4gSSBjb25maXJtIHdoYXQgdmVyc2lvbiBvZiBzaWxpY29uIEkgaGF2ZSBvbiBh
IHN5c3RlbT8NCj4gDQo+IE15IG5vbi1ldmFsdWF0aW9uIGNvbW1lcmNpYWxseSBwdXJjaGFzZWQg
c3lzdGVtIChIb25leUNvbWIgTFgySykgaGFzOg0KPiANCj4gIyBjYXQgL3N5cy9idXMvc29jL2Rl
dmljZXMvc29jMC9yZXZpc2lvbg0KPiAxLjANCj4gDQo+IEFuZCBJIHdpbGwgYmUgcmVhbGx5IGdy
dW1weSBpZiB0aGlzIHN5c3RlbSBzdG9wcyB3b3JraW5nLiBJdCdzIHdoYXQgSSB1c2UgdG8gZG8N
Cj4gYWxsIG15IG1haW50YWluZXIgd29yaywgZXZlbiBpZiB0aGF0J3MgYmVlbiBmYWlybHkgZG9y
bWFudCB0aGlzIHllYXIuDQo+IA0KPiBJdCdzIG92ZXJhbGwgc2V0dGluZyBvZmYgcmVkIGZsYWdz
IHRvIHVwZGF0ZSBhbiBpbi1wbGFjZSBkZXZpY2V0cmVlIHRvIGEgIm5ldw0KPiByZXZpc2lvbiIg
b2Ygc2lsaWNvbiBpbnN0ZWFkIG9mIGFkZGluZyBhIG5ldyBEVCBmb3Igc2FpZCByZXZpc2lvbi4g
MjE2MEEgaGFzDQo+IGJlZW4gb24gdGhlIG1hcmtldCBmb3Igc2V2ZXJhbCB5ZWFycywgc28gaXQg
anVzdCBzZWVtcyBvZGQgdG8gYWxsIG9mIHRoZQ0KPiBzdWRkZW4gcmV0cm9hY3RpdmVseSBtYWtl
IHRoaW5ncyBub24tYmFja3dhcmRzLWNvbXBhdGlibGUuDQoNClNvbWUgbW9yZSBiYWNrZ3JvdW5k
IGluZm9ybWF0aW9uLiAgVGhlIFJldjEgc2lsaWNvbiB3YXMgb25seSBzaGlwcGVkIGZvciBhIHZl
cnkgc2hvcnQgcGVyaW9kIG9mIHRpbWUoZm9yIGV2YWx1YXRpb24gcHVycG9zZSBvbmx5IGZyb20g
d2hhdCBJIGhlYXJkKSBiZWZvcmUgdGhlIHJldjIgd2FzIG91dCB0byBmaXggc29tZSBjcml0aWNh
bCBoYXJkd2FyZSBpc3N1ZXMuICBBbmQgd2UgaGF2ZSByZWNvbW1lbmRlZCBhbGwgY3VzdG9tZXJz
IHRvIHN3aXRjaCB0byBSZXYyIHRvIGF2b2lkIHBvdGVudGlhbCBpc3N1ZXMgaW4gUmV2MS4gIFRo
aXMgbm9uLWJhY2t3YXJkcy1jb21wYXRpYmxlIGNoYW5nZSBpcyB0byBhdm9pZCB0aGUgcG90ZW50
aWFsIGNvbmZ1c2lvbiBiZXR3ZWVuIHJldjEgYW5kIHJldjIgb24gYXNzdW1wdGlvbiB0aGF0IHRo
ZXJlIGlzIG5vIHJlbWFpbmluZyB1c2VycyBvZiBSZXYxIG5vdywgd2hpY2ggc2VlbXMgdG8gYmUg
bm90IHRoZSBjYXNlIGFjY29yZGluZyB0byB5b3VyIHJlc3BvbnNlLg0KDQpSZWdhcmRzLA0KTGVv
DQo=
