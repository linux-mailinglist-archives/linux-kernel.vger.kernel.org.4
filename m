Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482266956AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBNC2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNC2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:28:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E978A25D;
        Mon, 13 Feb 2023 18:28:14 -0800 (PST)
X-UUID: 3868440cac0f11ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m2lUaAzsoS3UMQhehsgLv2yKw7D171s4I+4qtjDaFx4=;
        b=ckjIC/jvXJypP8UAHT5biy1+E3yOHqYMlbCqDHZXIeGjNLJZDvGUhz53lSzQ65FsLKmMficj6r3t6Bygot1G15Mdx4sFvqPoBzkSTNt8vJiZpqvhhy2Q9gan4vY39cSgzjUds1TZfKsqh2RLZPlsoiXL3wkC4VL20vEJdsZaVHQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:2561b1b9-4007-4b53-908a-6ea0b405cc1c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:c4793057-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 3868440cac0f11ed945fc101203acc17-20230214
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1601149500; Tue, 14 Feb 2023 10:28:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 10:28:07 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Feb 2023 10:28:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7h6tyFRCWRq/zU/RP1yQWrVvmAieHKeI2OKvxocen/vF/njGjyurnBii9dQFZGwlV7L356dYkAC++tlRJKO2gD05At9aIrq9rrM/nL6APtsYQn5CtPP0YkDqY2ZgkGclErqesqsXN0hw6jIb3lt9mEBVM/n3rqR3VKsrEBnuRRha9Q4qlXz1skFJhhzk2XZjthj43XyUIeUxDiKpmPR5OF3m4HOw28M7iHESiBWilIRSo2CgxE3+tblVNNVWecY6nVr0QhlsW3ndX+3vgGdCNeW0JYSpubuWERZ0UA8OGLPY8zmAyAVXu1/Wr+yNK3ApfJDWv9Rzwh4mtYAmGY1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2lUaAzsoS3UMQhehsgLv2yKw7D171s4I+4qtjDaFx4=;
 b=mVKI1bJPdE8VbUqzsG8Sspfh4FHev4uOOpMMZ8sv/M8uDPAi2GBsVjLWUpQqetIKzg40HtJAjPjOpVsA+Opm0ffI7j4TMgF3gRAMzAgw2Xq3l7jiZ3B8kVe+8f9QZeFZBtclL4YC6RBsctbqt7Ise1jRemKaDtGz4+wFdplsH+Cb1BmdxeXSir7kBHGvksgnSwVdzlxzxD9pvisOE28rnLzsGLsdVa/L40PCbsb0NT6DpKBKuZUXgG9b+QhxpqnlUhrym3JtDmao7/gK9looG7kOPXMskfnyOCS+8k6NKWLe8yOKoJahWaJCJ1aaCs+a5MZfbXxgyHcanFQCwgdftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2lUaAzsoS3UMQhehsgLv2yKw7D171s4I+4qtjDaFx4=;
 b=ifn5nSw5jarRngyETRTZYalTfC1GZZzSEAVk3Eg2HPsMwNf/r1dFYGIid4iz1NmlC2C/2Dn/HjD0LMPcrcmRx4/HInp9UZDY11iaO3YBiGyUStcExBJuGlJm7f+mMeeXjA1jLoO+lpWbKlSnloMRqKbQ+ct0bv0lbmzg+mLf1qc=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TY0PR03MB6654.apcprd03.prod.outlook.com (2603:1096:400:210::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 14 Feb
 2023 02:28:05 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 02:28:05 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Topic: [PATCH v2] media: mediatek: vcodec: Force capture queue format
 to MM21
Thread-Index: AQHZPRRh7fZS99I5qEegpearM3gM+67IULWAgAVs3YA=
Date:   Tue, 14 Feb 2023 02:28:04 +0000
Message-ID: <f6148f4c4864d324b52a52cc87b8785d958ceeb5.camel@mediatek.com>
References: <20230210055518.6017-1-yunfei.dong@mediatek.com>
         <e972c2ac1a7a6f0ce258c8056b82bdc87e4d8ceb.camel@ndufresne.ca>
In-Reply-To: <e972c2ac1a7a6f0ce258c8056b82bdc87e4d8ceb.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TY0PR03MB6654:EE_
x-ms-office365-filtering-correlation-id: fc31af4b-1c8e-44a8-3dbb-08db0e331a23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4E8ffxtUqMObtsoG8mUwMIQNOah67MZ61YL7TZFX2w0SpW3Q9p+TsZD1aVXrzpZ5/62q9+SKdHgqmZbEF22sHOH5UjOCT3wDGlFBXI+4fRBqnP0ERYqXvcGnVYWbqSI8obNjVVMMco0gaHBfN/ibOOU0/S1rwW/j796VXFvyZfha9Z+uzu56bK6otU7dTqKqjBwSR19tVkt9vsjuk2UHrR564vQpszGmHVs+wlzDcpAht9+DXeJELfF8Zuqz+DW1KxaHDZlhDn+SZ0Uuq9GT3HtUfTvdd/U6N9KvWXGRBGj9cyUmGIXPNKAcivlfbYRDzcma5UUP2IKL6VsapsMCxv7xkpycChg9Yzc9kVzMjztRKk7FLldd+ekhF5Y8BPdYw9Zsbjhpp5sdfV/gDZnpUz54wvaw4b13pz7pr6xt03t9cGnbSV/h39G53nr7nbbKpcnrA4VRPiFzsq0Mvwyar9h91dhVaepKxoQwtPLCa4z5BD5zs0EI9OALXxkfbWk5d8HL9c4oCozuBB0IMxTTytOc0/20AS/v08e3Ot24TwaBBfCclLIaKK2blweJKO7LcLXxM86vOMMXXvXaKsl/nJZuqFkG3v9eS703sRtuk+Ui574144dwJRj77ZQWN+dfV6+I4xfA+RlZzZixs6z/9gVweTJKJ+q/U2B27fh7vhJotjaE+L52hd5UNZyVNaoCOj6Jqh57wks1zHtR754dl6TfoINeMk3zD7VTyFmDbTDHhw6o14kRmG6xQMnc8EXHFVCjNi3NDwPc/k87X9SNhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199018)(122000001)(38100700002)(316002)(110136005)(86362001)(6486002)(54906003)(66574015)(71200400001)(66556008)(41300700001)(38070700005)(478600001)(2616005)(85182001)(66946007)(8676002)(4326008)(2906002)(76116006)(66446008)(91956017)(64756008)(66476007)(6506007)(8936002)(83380400001)(5660300002)(36756003)(26005)(6512007)(186003)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlJ3ZmFZRjVTSTRIbTkraVF6d3BsazFjcWMzVHczakZsNzJ4SUd2a2JzVmlT?=
 =?utf-8?B?SFVzWVhtQXpIUzluVG15dGFPYlJsSU93MlJnL3JxbU0xQmR5V1dlUmo3bVlU?=
 =?utf-8?B?VE1Dc2tNMktjWjVBWE5hZ05GS0sxdUl6cGVrUjBDdms2U3NDSzA3ZkJaNktS?=
 =?utf-8?B?aUVOUjZTb05Jc2hZWkllSlgrYzRqSmQramhxcnNmRmN1WlNCVTNJQk5BUTI4?=
 =?utf-8?B?V1ozbDdrUlEvY0ZxemdrS0YwVldCYkxXSlp5amluMStTS2hxS0NOQTZhZVJI?=
 =?utf-8?B?dmpBSWVJSFUvazltY2MwQWJyNkhHdC9EdzViWmFVRVNveGVodEtqOGlYRThO?=
 =?utf-8?B?VzdvTFFlWUNZdWZUdTFpV296OXF2Z21DcWd4ckMyNk5TOGNqVjJaZEhKL1V6?=
 =?utf-8?B?T1RQK05SYkhQOVhHanN5N3hMajJ5VmVhSFg5VHl4QjFpUXRrN3gzZTljYnhK?=
 =?utf-8?B?Q2JOSW5GOHJBeS93SmQyQWVyaVlTQkp1M0Vid0ZVWHJUSGc4SkJ2WWlkMi8y?=
 =?utf-8?B?UTJHdDgvSzVMM1RJVXFtT2VnSlJyOWR6UUVUQVVPRzNlTTZIM1JheDJyVDdj?=
 =?utf-8?B?YW9mL2hoSE9COVBDQTF4ek9HT1R3NFpYYlJMejBRUlMyd3VPd0JqK1RKeUJl?=
 =?utf-8?B?dEpETjVJT0Z6aWZIcmpiUElvbk9vdmJlM2todDQ3VDdyb3E2YUpEMHRaeW1L?=
 =?utf-8?B?N1BmZkk2UGRpZzlvYlFkbUhRTHVTY0trZWg1MlJvbytlT3FRRDYyb09sMWdT?=
 =?utf-8?B?VmYwZnJlS3hGcVQrSlZ3NnQ1czVpSkZheVNhVWpnSkhDRnozVjRBRmoxa21T?=
 =?utf-8?B?VnJKNTdNRVBnRklnSDc3d3M2c293ZjJ4MUd0VFJ0ZlRzcTZHamNKd1lnTUNm?=
 =?utf-8?B?OFA1TVBiZ0t1VmJic3RJcGc0S1JIdEgwazFvWGMvL2UvNTRud05POVQrTTl5?=
 =?utf-8?B?amRxUkNpbnNKREhOQTBEUlBVRjFOMVdvZkVlZUFxbG9ydlFtN3dESyt6RHcy?=
 =?utf-8?B?MitkWjN3UjBsZFdDdm4vb0Y4NlZPLzdvbmZSNi9FRGRGNFhZVm9vSGw1dTEz?=
 =?utf-8?B?NmdUM3FIZ1pyWWlWY0R0dWdrSkw1Sm1PSXl2WHp6TW1kMUM4L0NEZ0lKY3p1?=
 =?utf-8?B?cVMyS0wxUGJmNndycGVPQWpySTlYME1ORXRHQldIMHZkMDZCajlHeEg3eHE1?=
 =?utf-8?B?RmxIZHY2YzhVNlowdll4SjJ4bEw3aW9zcjBlM0hwcUk0SWtOUGo2Zmk5aEEw?=
 =?utf-8?B?V1VxZTczSDg0akdyKzRoRXVWR3U0RUs4NFlvSkhCRk9ETEpkd1YvTDJmbUdo?=
 =?utf-8?B?VVpTRmprNWNCdCsxSHptQVQ3dThSdnZYdFhmcVJLRzZVRmlzRmZpZnNlRHBH?=
 =?utf-8?B?NWNXUjFCTDZmMHZkT00xZ1ZCNzd6bzVPcEp0cFJtZy9EYmNrc1RpbkxzZmgw?=
 =?utf-8?B?UHFOZUVFWm5xYTcwRXFFRXp6VzZEUlRUUXZuL2JZaVRWa3dBMXgzMG44MGkz?=
 =?utf-8?B?UXZic3RzNk5hNDFQNERManVFOVJHV0o4OUUxdit0YkcwYjZnTlhjV1BEaVpq?=
 =?utf-8?B?WCtjNzFCMzVVU2RONmd0VXlMeFpWbHhMdlFoZTFnekZjYnRjYVlpSm5uOGY5?=
 =?utf-8?B?dGZqYitUYTEyNndwdDJFRktSU01hS2lqTWl1UTR5UWxFUmVRSDBWMER6cUgr?=
 =?utf-8?B?T2RXbDRPcExlVG5ieFRUanhRMUZQaThpTE03cm1nQ1kzNi9aV1lhN1VLL2Vu?=
 =?utf-8?B?WXUvcTNYTy9KckxOZWZDNEZxVEJabllLRTZxMkFsS3lheTE1Y1JCR2l6NmQv?=
 =?utf-8?B?cUw0akd4UU1QZEFPdE5BU3ZnMUZNUHRldFdCekZielRhaGxqVDhnRTd1eUN0?=
 =?utf-8?B?QWJaUG1rZXVlRGNrNjh1RmM1M2hNU09Ga1daR2JTcXVFdm5CNDR0bjdFcDc0?=
 =?utf-8?B?cW9mYnN1dkZhYTc5U3dZK0VJZ2treEpzOFU1VlEyVWhoSmo2eHlRRTNNWUtt?=
 =?utf-8?B?Q2p5UXZBQzhFeTMxZTJJQWpwOGo4N1FZNUhlcUhGeUJsS1cySmFFbnVHQzRx?=
 =?utf-8?B?dmIxOVJHaitRNWFPeXFUdG0zenpLUUtVWDY3N0p6Z3cyZnFwM3JscVplakJu?=
 =?utf-8?B?b3JpVGVORTBpSTUrclBobVptTk1ZTnpoUEd1bDhhZHFOU0drYjQrUWU0S1Ay?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4A5F6F4613CCB4A9C0744F405556E2C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc31af4b-1c8e-44a8-3dbb-08db0e331a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 02:28:04.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m26CuUAs4kG9LaIyjLR4qTpB0aZSlX1qMgLHcFGT5sDw1J8pwRx/zNKaZilSxjzjdXooywclLlnE4GkVZW764OQD2y9LMBwKKVui0oep8KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6654
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBGcmksIDIwMjMt
MDItMTAgYXQgMTA6MzYgLTA1MDAsIE5pY29sYXMgRHVmcmVzbmUgd3JvdGU6DQo+IExlIHZlbmRy
ZWRpIDEwIGbDqXZyaWVyIDIwMjMgw6AgMTM6NTUgKzA4MDAsIFl1bmZlaSBEb25nIGEgw6ljcml0
IDoNCj4gPiBJbiBvcmRlciB0byBjb252ZXIgdGhlIGZvcm1hdCBvZiBjYXB0dXJlIHF1ZXVlIGZy
b20gbWVkaWF0ZWsgTU0yMQ0KPiA+IHRvDQo+ID4gc3RhbmRhcmQgeXV2NDIwIHdpdGggTGlieXV2
LCBuZWVkIHRvIGZvcmNlIGNhcHR1cmUgcXVldWUgZm9ybWF0IHRvDQo+ID4gTU0yMSBmb3IgTGli
eXV2IGNhbid0IGNvdmVydCBtZWRpYXRlayBNVDIxIGZvcm1hdCBhdCBjdXJyZW50DQo+ID4gcGVy
aW9kLg0KPiANCj4gUGxlYXNlIHJld29yayB0aGlzIHRleHQsIGl0IGlzIGhhcmQgdG8gdW5kZXJz
dGFuZC4NCj4gDQoNCldpbGwgcmUtd3JpdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIG5leHQgdmVy
c2lvbiBhcyBiZWxvdywgY291bGQgeW91DQpwbGVhc2UgaGVscCB0byByZXZpZXcgd2hldGhlciBp
dCdzIHdlbGwgdG8gYmUgdXNlZCA/DQoNCkxpYnl1diBpcyBvbmUgc29mdHdhcmUgbGlicmFyeSB1
c2VkIHRvIGNvdmVydCBmb3JtYXQuIE9ubHkgY292ZXJ0DQptZWRpYXRlayBNTTIxIHRvIHN0YW5k
YXJkIHl1djQyMCBmb3IgTVQyMSBpcyBjb21wcmVzc2VkIG1vZGUgYW5kIE1NMjENCmlzIHVuY29t
cHJlc3NlZCBtb2RlIGF0IGN1cnJlbnQgcGVyaW9kLiBOZWVkIHRvIHNldCBjYXB0dXJlIHF1ZXVl
DQpmb3JtYXQgdG8gTU0yMSBpbiBvcmRlciB0byB1c2UgTGlieXV2Lg0KDQo+ID4gDQo+ID4gRml4
ZXM6IDc1MDFlZGVmNmIxZiAoIm1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBEaWZmZXJlbnQgY29k
ZWMNCj4gPiB1c2luZyBkaWZmZXJlbnQgY2FwdHVyZSBmb3JtYXQiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5vcmc+DQo+ID4gLS0tDQo+ID4g
Y2hhbmdlZCB3aXRoIHYxOg0KPiA+IC0gYWRkIEZpeGVzIHRhZy4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYyB8IDQg
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBpbmRleCA2NDFmNTMzYzQx
N2YuLjRmNWU5YzIwMjE0ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYw0KPiA+IEBAIC00MSw3
ICs0MSw3IEBAIHN0YXRpYyBib29sIG10a192ZGVjX2dldF9jYXBfZm10KHN0cnVjdA0KPiA+IG10
a192Y29kZWNfY3R4ICpjdHgsIGludCBmb3JtYXRfaW5kZXgpDQo+ID4gIAljb25zdCBzdHJ1Y3Qg
bXRrX3ZpZGVvX2ZtdCAqZm10Ow0KPiA+ICAJc3RydWN0IG10a19xX2RhdGEgKnFfZGF0YTsNCj4g
PiAgCWludCBudW1fZnJhbWVfY291bnQgPSAwLCBpOw0KPiA+IC0JYm9vbCByZXQgPSB0cnVlOw0K
PiA+ICsJYm9vbCByZXQgPSBmYWxzZTsNCj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgKmRl
Y19wZGF0YS0+bnVtX2Zvcm1hdHM7IGkrKykgew0KPiA+ICAJCWlmIChkZWNfcGRhdGEtPnZkZWNf
Zm9ybWF0c1tpXS50eXBlICE9IE1US19GTVRfRlJBTUUpDQo+ID4gQEAgLTYzLDcgKzYzLDcgQEAg
c3RhdGljIGJvb2wgbXRrX3ZkZWNfZ2V0X2NhcF9mbXQoc3RydWN0DQo+ID4gbXRrX3Zjb2RlY19j
dHggKmN0eCwgaW50IGZvcm1hdF9pbmRleCkNCj4gPiAgCWNhc2UgVjRMMl9QSVhfRk1UX0gyNjRf
U0xJQ0U6DQo+ID4gIAljYXNlIFY0TDJfUElYX0ZNVF9WUDlfRlJBTUU6DQo+ID4gIAkJaWYgKGZt
dC0+Zm91cmNjID09IFY0TDJfUElYX0ZNVF9NTTIxKQ0KPiA+IC0JCQlyZXQgPSBmYWxzZTsNCj4g
PiArCQkJcmV0ID0gdHJ1ZTsNCj4gDQo+IFRoaXMgbWFrZXMgdGhlIFZQOCBhbmQgdGhlIG90aGVy
IGNhc2VzIGlkZW50aWNhbCwgbGVhdmluZyBhbnl0aGluZw0KPiB0aGF0IHRvdWNoZXMNCj4gTVQy
MSBhcyBkZWFkIGNvZGUuIEknbSBub3Qgc3VyZSwgY2F1c2UgSSBjYW5ub3QgdGVzdCBpdCwgYnV0
IGl0DQo+IHNob3VsZCBpbiB0aGVvcnkNCj4gcmVuZGVyIE1UODE5MiB1bnVzYWJsZSwgdW5sZXNz
IGEgbmV3IGZpcm13YXJlIGhhcyBiZWVuIHN1Ym1pdHRlZCB0bw0KPiBsaW51eC0NCj4gZmlybXdh
cmUgd2l0aCBNTTIxIHN1cHBvcnQgPw0KPiANCg0KSWYgdGhlIGZpcm13YXJlIG9ubHkgc3VwcG9y
dCBNVDIxID0+IHdvbid0IGV4aXN0IGZvciB2cDggbmVlZCB0byB1c2UNCk1NMjEuDQoNCklmIHRo
ZSBmaXJtd2FyZSBvbmx5IHN1cHBvcnQgTU0yMSwgd2lsbCB1c2luZyBNTTIxLg0KSWYgdGhlIGZp
cm13YXJlIHN1cHBvcnQgTVQyMSAmIE1NMjEsIHdpbGwgZm9yY2UgVlA4IHRvIHVzZSBNTTIxLA0K
SDI2NC9WUDkvQVYxIHdpbGwgdXNlIE1UMjEgYmVmb3JlIHRoaXMgY2hhbmdlLiANCg0KV2lsbCBm
b3JjZSBhbGwgZHJpdmVyIHRvIHVzZSBNTTIxIGFmdGVyIGFkZGluZyB0aGlzIGNoYW5nZS4gDQoN
CkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo+ID4gIAkJYnJlYWs7DQo+ID4gIAlkZWZhdWx0
Og0KPiA+ICAJCXJldCA9IHRydWU7DQo+IA0KPiANCg==
