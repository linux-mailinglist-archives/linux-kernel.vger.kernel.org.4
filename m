Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF65FC49A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJLL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:59:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0F79FFC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk7sK8LXabEbLjTa1Q53HJmL0azqUk3RKzJnt7MFiPPvWdSrs9mzyPFiPQJRC/lomb6Zue0mnG0e4vg6UyPpk7TvZ4yXn03bSlYYrTxA3NSLVt5SagAN+oVFYJUz1MAE2hYvY3yTvQ/TggPL+K4BvU+UKcTObMWPfqY9ZBmfC/fLZ2EWWW2Dwsgkky1i/CLJTZMeakBq+vRgSN6Z/FmSJeeC7EmffYu45hfnXBzZS89w6QrLh3Bqd5Vu2ptOHcweOH7LWIAGSDwCDQ/MIrsGpy4eBjRakKg9lCAhnR7Y+70ttIIRDE+SV1+FEwfk/XaDj21H1doJflpXTELywy+rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G48fTjXdyPdOnWL9V/nefqBhLB3GwnyAKt9ll0u/7bc=;
 b=cUSswmIgyZzUy1MY7fO0gQ+tZ1fPiF2zFXlTZgb1EZTcnDcaxAcjRh6CA+O62CTeKK0J1QXy2DK78tO/cp+765TJ0R5NEYcJxsO5dxL1qmU/2TSSQOAHPHNNPLMVe0L5oRrMU032kxKyUpCrYKN0nGZCOfHj5CYpeZgrcPWV4LQzL0MALlCtqm5+UYVFcaY9rvhjBoce8hrHsZe5YJbRCaOOiptfVIt7VuXTDpwE6UuP9Lxk5t8AgzcyhZGbWKBsB2LjtOnNOCWKmlIDzp/mfZ6vFfCwUbw8RZ2hjGqmRxQXIym4c4X4nqWtMVzuR4yreYU4W7sVNGlpJcfKHkrYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G48fTjXdyPdOnWL9V/nefqBhLB3GwnyAKt9ll0u/7bc=;
 b=SDzPTU/1EMtaeyKFkT0naRjgT4Y4oxOYnIOp0e7egjM8yTe7UV5o3KJ1l4tcAr6qOLYDtQ7gA15N1nZjLVR7ohWUdt8tAD4anXCMdsBbacwRSkeBPH05ykSQDHZxQZItgmrPyVU5k4ovRp/C8tOvHCIoO1D/6JEn9dZ5QQBnJ7uPwQRod3vDocND5aiXrrr6rcwNCqdTorw42JO24gjpD4Bp2roNT0SKWHDVwehjQYaf53RYLED+Eql5NcAjDbqxVg77XyVXcCyP3ys/wIU4HFhJJVuFQL+VvCCgCGm6OA6Vm3RPLVlXOaOSHfgtlb6/mr0peVa1ReyEJKXOQi24wA==
Received: from AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12)
 by AS8PR04MB7976.eurprd04.prod.outlook.com (2603:10a6:20b:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 11:59:40 +0000
Received: from AS1PR04MB9478.eurprd04.prod.outlook.com
 ([fe80::737e:85a3:271b:4f47]) by AS1PR04MB9478.eurprd04.prod.outlook.com
 ([fe80::737e:85a3:271b:4f47%3]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 11:59:40 +0000
From:   Jean Delvare <jdelvare@suse.com>
To:     "erwanaliasr1@gmail.com" <erwanaliasr1@gmail.com>
CC:     "e.velu@criteo.com" <e.velu@criteo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware/dmi: Print product serial number if any
Thread-Topic: [PATCH] firmware/dmi: Print product serial number if any
Thread-Index: AQHY1zPNPZqwof+7w021sBl6vUbV1q4Ktc6A
Date:   Wed, 12 Oct 2022 11:59:40 +0000
Message-ID: <0d7537b3e1ef68440b72f56cc2739aa3efbe52f9.camel@suse.com>
References: <20221003142400.1177057-1-e.velu@criteo.com>
In-Reply-To: <20221003142400.1177057-1-e.velu@criteo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9478:EE_|AS8PR04MB7976:EE_
x-ms-office365-filtering-correlation-id: 38d44e8d-1dfc-4311-ae1b-08daac493e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z3DVX1BwNEb00yjVSrRnbEX7TibLJwudZgsyxI7Rc3EhEFoL7kmW3bK4fUZJfc6NkEYQacVRHSYRSxAo5Zco7g5oaqB/RtDm2w0C+xje249nkXyKX5WNohcsigj7cmTmeDYaw5cp5LdOYBWeSLlYfj1wJT7Y7GyKGFEX+wS2cF8KfU07IuISijBimw4GWfHYlSTUivhH4r6zvBu0YNn7ydldIUsYxrpn2AE/MdV0WXQphOnwxlYkocOmY1nBBRW+Ld2fuBe+b862KY7SRywjLXO/IbtVfjJMgxOgyST4r0slmA4o3viq2Ej0Vjid9lWPHCmqEAxNRM/fxBwbrEw/UzDZmEoGeugtm5lF6Hpxr+reijibPUqLpgaMy7NOPveS0I9ki+Fj8yJTLtmj9hcjQzCSvpW3sX0pxblTWDt4I4KMPVEiJnOrWFZX6NXWcSXC6hg/VtAUHhNC9at3K3o/kTDrnJk4beZwxwxtGJFrcU6NS1zVGGVwfkBI+HJGisGl4r/myvDmX9O0IbgLYLvOyvLAq/iwq4MjjNIuuKvifxY8DjpiiFiEztV6h1yfw7tqBEphF+xHJvbCYfRZC48AdTObZTsW0rXgAAKjUOt56y2zadHRjzRYoS/Sge/dyYuc1Cz0yEZYzXOceF4k00Wfetw/mOqZcQfPv/p+n5plKjvygDYGXW5ay1p7AVRkvH3xXdq2U+E9EUgb0PcfK+771WBi3+HkWF3uwcHtg0N/KVXwjCPDdY+Z2gDQkaBukM46NdeDrBbl5hLncaSu3T2UzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(66899015)(36756003)(38070700005)(2906002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(5660300002)(38100700002)(41300700001)(86362001)(91956017)(66946007)(76116006)(8936002)(122000001)(316002)(54906003)(83380400001)(6916009)(186003)(6506007)(478600001)(6512007)(2616005)(71200400001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enlBeTh4dXNoTXgyeVlTWHVwaTI4T3d0bEhLU3ZLQUhxTEFHKzJ0aURqRXFq?=
 =?utf-8?B?dURPWTZydjZxdHlTR1lycUgydlFIalJKeUs4cVRUQ1VHajFiZksrbzJvNHhH?=
 =?utf-8?B?MU5RZ013RTBxekxSNUtrYzA1Z2xNNFloaGxaZjdPVjdSS2Y0ZEJzQmVNS2NG?=
 =?utf-8?B?VEpldlRBSm5PaXhxZFZZYlpsOCtBVUtzc29kd3NWWWNMSzVTRGlydjFTNjNp?=
 =?utf-8?B?ZmdFUkFuUVRXTVhkbG5hcENBb1ZQUVJOU1ozeUxmaWw3ZVNXNG1KZnZVRzBs?=
 =?utf-8?B?dC9kM0hjSXo1eStUTGhSUUYzbnVEU0tTSEUxTm55SndXYm9iaGRuM3hReGdp?=
 =?utf-8?B?dGJMNWVPVmRjV2RJWDgzWHNvMm1zeE03SVZtd0hNa01sSjJuZlR6TnZxNDc0?=
 =?utf-8?B?blVCSFQySEllWkZZeVBqK0pTWm1CaFJSNEIzeSt6L2h1TE9yOVdmdExkc3FJ?=
 =?utf-8?B?Ni9heE1OeHkvUUtTcVgzVVFaR1VoeVpZK050RmhaN1RkK3FiTkRGUFBHNEZU?=
 =?utf-8?B?VjUwM3hXdVdxdW4zVlRic0RlRXJ0WWxHcXZ6MmNKd3BiNEpqNzFUZVVtbWto?=
 =?utf-8?B?UlhXT2JYTCtFamtHVEhkRlV1VGZxQ1VuazkzaXVLMHVIc1oxQkJ4U3hVdVhI?=
 =?utf-8?B?TGtDb1RQai9WdlVkd3Q3UDFLVkR1ZUY4WHFDbmFhL3dMbXVnQ0hzN3JFQU5l?=
 =?utf-8?B?T3h2YjFlbVFXbVUvcTRlejdlNnpTanRnWHNkalhtUmc0OFpCVGFiQ0N1QlFO?=
 =?utf-8?B?clN2aTAzc0pvNGVZa2VxZWswdkFVMzhZUFRoZGx3OEVkQ1pNVHVYajRXUStS?=
 =?utf-8?B?MkNYakNRS1dDS3JidklsbStLKzlaRDFkcUtkNVBwTXdsbC9KM3IrbDZ1czJk?=
 =?utf-8?B?S29jeHNuVDF4SW5RYjNGRk9MVnBWQ0QzR3FqOXdVd2kxNDUwK3h4d2xkVlVD?=
 =?utf-8?B?UFJzaXY1WnYwN2NnNjhSZGtzY1JGRzR1NE1ocVZKK3RVdHo5ZGNML1NiTS9B?=
 =?utf-8?B?Q0p0UWhQaUQ0cWZleUlUTEVGWldROFZ0UlZRUnhWVDJjeE4zN0dWcGZYRm94?=
 =?utf-8?B?c3FTYUhSdGs2OFcxU1JEcGdsY3p3ak5obE41bDNnMy9pd1pQcHhOc1hGdS81?=
 =?utf-8?B?Mk5vUTJNWkVtRHNlTFAzdWc4aGtLVE1UbmNoL1hxRmZVVzBWNFJJcC9Gb3Jz?=
 =?utf-8?B?WW1MUnRocExIMDloU3Q0WVhmR20wU2t5RDA5bjhlMEtMRFZVOWxTVHV1V3Av?=
 =?utf-8?B?L0xQbE4zakR5VExjNlhUZkJEVmdzRjBLWU13Ync0cFVMU3ExZDRnRVgwMWI0?=
 =?utf-8?B?RThmS1gzWXVGR2xpVjlyY0NsOENQTzJaTEE2djI1TFVwckxZSWYrQWY4eHhJ?=
 =?utf-8?B?bXJ1VTVCdm00UHBJWjh5Vlo5MUhDbG1SczZ6OXdVQXlaSDd0eWNnVzhtenJv?=
 =?utf-8?B?VEdPUEppc1I5K2FzMnJDK0YyQ1REMnV2MXR0aHFFWWUyR0R6bmtGOUVFbGIv?=
 =?utf-8?B?UzVwU0RMZEdnZmkwTHo2cmJYMC9qMUZwTVgrb3JUVkZDM05PSE9XUmJvOFdi?=
 =?utf-8?B?cnlzcEpOOTZNcTZ4UWFJK2ptSzVyVVhNWWFXRG5vVVBpbjNkYWxBN3gwMkk4?=
 =?utf-8?B?K2xuN3BIRmswWGxmUjdQcmRMdzAwNGNtMlc1QUoyUXVqZGN4M3hWdzhxSVVQ?=
 =?utf-8?B?WDVqUm1wQStsZXhNT3FrQUJkZ0wyUkRwbUYyQ054RTVZVzEvL0RRNEtLcllB?=
 =?utf-8?B?emRpdTVHekZZbm1BVTJJSm9RRDhpNUNGMFVHSjRXdm5uL2VHQWRORnJtKzNK?=
 =?utf-8?B?bVdhRTd1VUgxcmdlblV3TWxncFF5NGVnb1pLencwUmlRb0VpVmFxUVZhZE5v?=
 =?utf-8?B?eWhCK0dzVXdoTnJRekNEdXU2dUE3M3VhL2lxSmVsQjJGQnA3Z2xHNlV5aE40?=
 =?utf-8?B?RFRwcHkrT2pycGVrSjVNYWMwTUtwbC9BWDB2NEh4Z2RmcjRySXpRTkZTYTFV?=
 =?utf-8?B?ZGpGSlZpbHVkcmtKRFpWTmlzbDlGNHhmUEtWTE1rZ3BHcWNJWXJqbVBDWG8v?=
 =?utf-8?B?MmVxcTBKcEJ0c2NpSCtsVTJZaktCRG5DKzhJbWt0RHI1SlByQkJFdUtadTVk?=
 =?utf-8?B?WnE4enZMd2dENWxTYkV1enRxaVRWR2NuVEtvaE13Mk9aaDNFc2ZaRXowdDB2?=
 =?utf-8?Q?dhERnny56/7WKoXZnF0+zd+UlvFBczqzyNnbraK1VJeD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C67D749138669498C7CAD7DC7DFD355@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d44e8d-1dfc-4311-ae1b-08daac493e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 11:59:40.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJuJJUmVMzhiDAUvuIQusjbZxpZewGrzMxW2x1+hyjEiqRXPlBQCkyjhaaqPqUION6YOiwn1EFghqZJsgKj2DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXJ3YW4sDQoNCk9uIE1vbiwgMjAyMi0xMC0wMyBhdCAxNjoyNCArMDIwMCwgRXJ3YW4gVmVs
dSB3cm90ZToNCj4gRHVyaW5nIHRoZSBib290IHNlcXVlbmNlLCB0aGUga2VybmVsIHByaW50cyBh
IHN0cmluZyB0byBpZGVudGlmeSB0aGUNCj4gcnVubmluZyBob3N0LiBUaGlzIGlzIHByZXR0eSBo
YW5keSB0byBlc3RpbWF0ZSB0aGUgdW5kZXJseWluZyBoYXJkd2FyZQ0KPiBpbiBjYXNlIG9mIGVh
cmx5IGNyYXNoLg0KPiANCj4gVGhpcyBwYXRjaCBhZGQgdGhlIHByb2R1Y3Qgc2VyaWFsIG51bWJl
ciBpbiB0aGlzIHJlcG9ydGluZyBpZiBhbnkgZ290IGZvdW5kLA0KPiBvciBrZWVwIHRoZSBjdXJy
ZW50IHN0cmluZy4gSW4gYSBsYXJnZSBmbGVldCBvZiBzZXJ2ZXJzLCB0aGlzDQo+IGluZm9ybWF0
aW9uIGNvdWxkIGJlIHVzZWZ1bCB0byBpZGVudGlmeSB0aGUgaG9zdCB0aGF0IGdlbmVyYXRlZCBh
IGdpdmVuIHRyYWNlLg0KPiANCj4gVGVzdCByYW4gd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1hbmQg
OiBxZW11LXN5c3RlbS14ODZfNjQgLWtlcm5lbCBhcmNoL3g4Ni9ib290L2J6SW1hZ2UgLS1lbmFi
bGUta3ZtIC1tIDUxMiAgLXNlcmlhbCBzdGRpbyAgLWFwcGVuZCAnY29uc29sZT10dHlTMCcgLXNt
YmlvcyB0eXBlPTEsc2VyaWFsPVI5MFlUN1dDDQo+IA0KPiBQcmlvciB0aGUgcGF0Y2g6DQo+IFsg
ICAgMC4wMDAwMDBdIERNSTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5Niks
IEJJT1MgMS4xNi4wLTEuZmMzNiAwNC8wMS8yMDE0DQo+IA0KPiBXaXRoIHRoZSBwYXRjaDoNCj4g
WyAgICAwLjAwMDAwMF0gRE1JOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2
KSwgQklPUyAxLjE2LjAtMS5mYzM2IDA0LzAxLzIwMTQsIFNOOiBSOTBZVDdXQw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogRXJ3YW4gVmVsdSA8ZS52ZWx1QGNyaXRlby5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9maXJtd2FyZS9kbWlfc2Nhbi5jIHwgOSArKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKykNCj4gICguLi4pDQoNCkkgc2VlIHRoZSB2YWx1ZSBvZiB0aGlzIGNo
YW5nZS4gSG93ZXZlciBpdCByYWlzZXMgYSBwcml2YWN5IGNvbmNlcm4uIFNvDQpmYXIsIC9zeXMv
ZGV2aWNlcy92aXJ0dWFsL2RtaS9pZC9wcm9kdWN0X3NlcmlhbCBpcyBvbmx5IHJlYWRhYmxlIGJ5
DQpyb290LiBXcml0aW5nIHRoZSBzYW1lIHN0cmluZyB0byB0aGUga2VybmVsIGxvZyB3aGVyZSBl
dmVyeWJvZHkgY2FuDQpyZWFkIGl0IGlzIHRodXMgcXVlc3Rpb25hYmxlLg0KDQpJIGNhbiB0aGlu
ayBvZiAyIHdheXMgdG8gc29sdmUgdGhhdCBwcm9ibGVtOg0KMSogSSdtIG5vdCByZWFsbHkgc3Vy
ZSB3aHkgdGhlIHNlcmlhbCBudW1iZXJzIHN0b3JlZCBpbiB0aGUgRE1JIHRhYmxlDQp3ZXJlIG9y
aWdpbmFsbHkgY29uc2lkZXJlZCBhIHNlY3JldC4gU28gd2UgY291bGQgY2hhbmdlIHRoZXNlIHN5
c2ZzDQphdHRyaWJ1dGVzIHRvIG1vZGUgNjQ0LCBhbmQgdGhlbiBwcmludGluZyB0aGVtIGluIHRo
ZSBrZXJuZWwgbG9nIHdvdWxkDQpvZiBjb3Vyc2UgYmUgT0suDQoyKiBXZSBjb3VsZCBtYWtlIHlv
dXIgY29kZSBkZXBlbmRlbnQgb24NCkNPTkZJR19TRUNVUklUWV9ETUVTR19SRVNUUklDVD15LiBJ
ZiBkbWVzZyBpcyByZXN0cmljdGVkIHRvIHJvb3QgdGhlbg0KaW5jbHVkaW5nIHRoZSBzZXJpYWwg
bnVtYmVyIHRoZXJlIGlzIE9LLCByZWdhcmRsZXNzIG9mIHRoZSBwZXJtaXNzaW9ucw0Kb2YgL3N5
cy9kZXZpY2VzL3ZpcnR1YWwvZG1pL2lkL3Byb2R1Y3Rfc2VyaWFsIC4NCg0KRm9yIHNpbXBsaWNp
dHkgSSdkIGdvIHdpdGggb3B0aW9uIDEsIGJ1dCBpZiBwZW9wbGUgc3Ryb25nbHkgZGlzYWdyZWUN
CndpdGggbWFraW5nIHNlcmlhbCBudW1iZXJzIHdvcmxkLXJlYWRhYmxlLCB3ZSBjYW4gZ28gd2l0
aCBvcHRpb24gMi4NCg0KTm93IGZyb20gYW4gaW1wbGVtZW50YXRpb24gcGVyc3BlY3RpdmUsIHlv
dSBjaG9zZSB0byBnbyB3aXRoDQpETUlfUFJPRFVDVF9TRVJJQUwuIFRoYXQgd2lsbCB3b3JrIGZp
bmUgZm9yIHZlbmRvciBzeXN0ZW1zLCBob3dldmVyIGZvcg0Kc2VsZi1hc3NlbWJsZWQgc3lzdGVt
cywgRE1JX1BST0RVQ1RfU0VSSUFMIGlzIHR5cGljYWxseSB1bnNldCBhbmQNCkRNSV9CT0FSRF9T
RVJJQUwgd291bGQgYmUgbW9yZSByZWxldmFudC4gU28gaXQgbWF5IG1ha2Ugc2Vuc2UgdG8NCmZh
bGxiYWNrIHRvICJCU046IDxETUlfQk9BUkRfU0VSSUFMPiIgaWYgRE1JX1BST0RVQ1RfU0VSSUFM
IGlzIHVuc2V0Lg0KVW5sZXNzIHlvdSB0aGluayBzdWNoIHN5c3RlbXMgYXJlIG91dCBvZiBzY29w
ZSBmb3IgdGhlIGludGVuZGVkIHB1cnBvc2UNCmFueXdheSwgaW4gd2hpY2ggY2FzZSB5b3VyIGNv
ZGUgaXMgT0suDQoNClRoYW5rcywNCi0tIA0KSmVhbiBEZWx2YXJlDQpTVVNFIEwzIFN1cHBvcnQN
Cg==
