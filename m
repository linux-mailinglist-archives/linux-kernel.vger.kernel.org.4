Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D43711F30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjEZFUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEZFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:20:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FBB194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:20:24 -0700 (PDT)
X-UUID: 01220a26fb8511ed9cb5633481061a41-20230526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0rd7GLNkAcRjEUQyAsub61uwSr5RlTn6N/UO2qoob78=;
        b=d5HoJIfB5Dcu/J4+gvW8bWeAV4fl6vJbo8gEfUQJ5dO48STVq9q6DQprFnN4NGTbehUeBMRI6TwhqTOGBH6VmeKJTn19tlqG/8IcadO0m1T/qY51CmVGKA22q2ycdrU2pZ40E7FvGzGqPtpfRfs12+sQnX0XZdgVY4E7kgRUJe0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:c95d89d5-5395-4d9e-8f60-a66efd165daa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:df889d3c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 01220a26fb8511ed9cb5633481061a41-20230526
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1449598703; Fri, 26 May 2023 13:20:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 13:20:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 13:20:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tuk5xskh5dsBvbp37i1i4xsT45be1bLK2d6JlqG1vf45G4GvZFJqC0lpIB3eany50l5JUP9oHkMZ51s+O4Y16q5s/ALAcCoS+s+rzeNED7ftM59Ql4at4Sn/oKKIcVkPuQ/leZcfBswG/rKLqDhPWgAZwsuWhkGqOrSOtWRTWFozs8ULjUd27pA9TXZn4Xh1C3oTwA8V6dJfe3dOghFQHbDuiTuajg2JtL+7m0omyieXvBnlLUisU8c9d67jkKK/AchM96FLpujlyDeV6BMaJ9VDg4ni0E/63KMWIeBSNUDcB6wKHfTQT236Ul2yglJgX9lhCFuoDoV+eK2NP1f+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rd7GLNkAcRjEUQyAsub61uwSr5RlTn6N/UO2qoob78=;
 b=B0GDPtr2BtbiNGcxb2NdIcM668CtupDjQUBqPz1QwX5Cy+blJh97yGeHMXst2hcVoih9PezR8RioWaRUH3dhddfuQ+1jJCTMXAhJMfUs78LtWhpGLJQ4hfaQaf++/ocSopdJbuaGy7OBsAuwEa/igXEo9bs6BMgmaqMMrQb5Mkx92mzcH/fwk6keLHCo+hZAWESOXk5rZ3uB9s3FF4dtFQVii1fx1I7/y8QUtoeuqoUKnSrEhbd2nf4vbKFPi5IcAARKQCgPCJG7J0g+06rDmVDgTocanyjB1uQa3tNw7vtlg/RGtCPVkUFpv3LmD0j/vp12O6RrLQdb+2X6HVp4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rd7GLNkAcRjEUQyAsub61uwSr5RlTn6N/UO2qoob78=;
 b=qFNmFYpBV+Uo3cnwnlsw5jL0wCnEFF7MRzETXunOpzIYFy8BrLou6a7suaqstCUe3R39kMVL+seA0gtiSVlAdGydxnX3XdU8nZH4UifCqIgrfBjypFmlTpBnKtllSpxHm/kNwzWZXmouN9Kwry1tBkw4h4jWcKLQ/ViAXJvryI4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6342.apcprd03.prod.outlook.com (2603:1096:4:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 05:20:15 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58%7]) with mapi id 15.20.6411.030; Fri, 26 May 2023
 05:20:15 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 03/11] drm/mediatek: gamma: Support SoC specific LUT
 size
Thread-Topic: [PATCH v4 03/11] drm/mediatek: gamma: Support SoC specific LUT
 size
Thread-Index: AQHZiXaRbnriShkVekiqtVxaDa8Vf69sEJMA
Date:   Fri, 26 May 2023 05:20:14 +0000
Message-ID: <135f8b6829585632f81d9c4da9a3b6211a8e0bfa.camel@mediatek.com>
References: <20230518104857.124265-1-angelogioacchino.delregno@collabora.com>
         <20230518104857.124265-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230518104857.124265-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6342:EE_
x-ms-office365-filtering-correlation-id: 49a7d876-188c-4bf3-b9b7-08db5da8e32c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6XpyC9sBMXgiIsw3zIVzVLI17Xq1xZzNw/NAhyOWyeaGbaTKSgRn8oTWq2eOgZ9pOq9pa+wBdRkpeOmaAqZmEv6VQG/l6Q1UpCW5Cx4+ysxMHBKvuxa0VK7hJ+UzEKQAZR8LoXkHwM+WFE8h1BRfXMhkoJARwfa2fvI30y39hvZeIQK5S0tDmq58RW6S1cUobSrNPqy+xV2OApNIcmZ6b8UnrJr2Rt+TlGCLLBcE90Bc15g5hkurI5gutg+U9aKxc2JjE+OGdEDGtwmF7vfdnOWROH+059ca36oRvxSs5/OkWP6Zsiwturx0PV/AxVN6wt+Nfh7foTVmAcoSHafCDQkSzsHHNuvWoaMGmn/hGHHouDpGNAC8n0yNg0GJXXHdLYsFXx7+hGgngqcIfd1lfePhR1JGLKVdXM2FUs5zJy4Tj7fSE1mo/hTCfvu8324qjnZAjSSlJHndf/LZ1oRc75LSPr1ZAcybGP+Z7omP33FTh3OL/Eh483wH6cEpK50VN47DqU9gIdrWQHJJAeWDOas34TGKx10VuspfL7FqqMBqyQdbe1Cn4mLkXinfqwErcTIizTU6T6CORpgS2gWjP8XTldnF0qmRmZqq37IxmRqJjZ+tuycMEYUAbNMgJYy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(5660300002)(4326008)(8936002)(2906002)(316002)(41300700001)(54906003)(110136005)(8676002)(478600001)(6486002)(71200400001)(186003)(6506007)(26005)(36756003)(83380400001)(85182001)(2616005)(6512007)(122000001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjBZTkdyZFc5ZytsUXNrSCtmK0M3RWxJcGpzaG5uamovQWNlaGlJSGtydDhY?=
 =?utf-8?B?S0VBWHBLbzJxSmxON2luZWNnUW5yUUx3eEc3a2pPL3hZdktLcUxKeUgveGxk?=
 =?utf-8?B?dXFPc3A2NmNFRE9zRlJIN2lKNG1RbGZzMTVpTkFiQXVndW9oeXlodEpETFRx?=
 =?utf-8?B?UnpwVUZZZU5BN3lCUGRvT2t6NVBFUXM1cWJSQVZrTG9DL21uQ29yV2RhTXdv?=
 =?utf-8?B?QWdZZ2hPRkhVRlJSZjBqK3QyWEh1YWRFZGZ5YkZEWmxGUUExSWl0U3hBOWZi?=
 =?utf-8?B?b3dKS2VNOFhMOUJBOC9tb0FENzVWRmpCS0dzQU9GNHgwdFY2WUM2VHpRQ1or?=
 =?utf-8?B?cUdKRDRKcElDTmhrWXJ0TVVIdHIxRkFsMDFKd3BGSjdNRmtKdXBZUWNUaWF0?=
 =?utf-8?B?VjI3czRaVENvNFFnTS90dlJ5MkZrQUVudVB4TkM5d01NYkUvdDRmanhGaG1z?=
 =?utf-8?B?YU1UK3plZzRlTkdPMFJlVEx6ekdRay9MQy9WeUVoeXBWYXFKV0wzY1FlNGd3?=
 =?utf-8?B?NldZTXF6aXpDQVQ2VHRpeU41cHQ1bERHTjZsUFZ3L0tmWldnUHVpeVhSUmV5?=
 =?utf-8?B?VHhWRi9ZNVZSTzltN2VxYkdYdGJqYmorRXlwbm16cE5KWktqY2VQcTk5bjQ5?=
 =?utf-8?B?V0JpUU9PbGNEYloxdFI5bFQrKzYwZzVnY1ZRYU82bkhSQlF0dXhBOUlpOGd1?=
 =?utf-8?B?QUovZnFoZ2t4MkJvckJyMENDQjhZNmpHSzZoMlZRZlFJMXFGczQzK0pRK2dx?=
 =?utf-8?B?VUdDZEVJYVlpUGViL3pGTGVLYnlLRXFndG83RnArRW5tSm5IYXBITjVUVTA2?=
 =?utf-8?B?OVRsYVhaRVhkMGwvVU5RZVVYZ29lSzRNVVpreFJGdlphcU04cEI1Qjd0MEhn?=
 =?utf-8?B?dnNDK2xrL1dmMGtUQ2J5WHVqekU3VWZobEgrSXZ2dUZ1VWpVQlZUNnVtWE14?=
 =?utf-8?B?djVVaXgzcTRnWHdWRXdzbXJScytSelY2UnpRajUybjBGSTN1VnRnZUk0SlVy?=
 =?utf-8?B?OTgxTjZZVjRNajcwODY3U3ZVbXQ3Zm05UCtDcFVVa2VqZXVtUUtwVUZRMGxB?=
 =?utf-8?B?V1dEdy82NmJRZFBqSXROWnJHK0JJK0hEVlpER3NLdit0aWdmLy9Kd1o2Q05S?=
 =?utf-8?B?Q0NwNldqa3Q5RG50MzFCNDZkWm9seHRBSStLQjh1OFVRVDBpSTFRait6Kysr?=
 =?utf-8?B?Slc0UmZ4c3h4aGF1UUhLOGdaT3grR00yR3VnS2ZCUmR6d1Y5Y1BkNGxydTFL?=
 =?utf-8?B?dTNGQmsrUGU4eU5sQTNKRkJaYlFQeGQ0SjZHZE5va3BZeWYxN3VoejNGUno1?=
 =?utf-8?B?MzFFT3JTbGdGcDNKLzFyUVI2R0RvRmdUaUYvTklXQkJZZ2dseHkvOGxiSy85?=
 =?utf-8?B?U3VSaWtnR1d1OUtpSnZORmRtQ3pTRUdXVjFPVW83STBpNWFzdnBhRnVzQXNZ?=
 =?utf-8?B?YkZXNHlJUUlYejNqRXJ2SzNjSm5kZnRUcUxPK3NRM3l0VnlhVWVJVUV5TjZC?=
 =?utf-8?B?RjBtMzRuSlkrOUlHbXdLT2UzbVJMVG5DVHozSENRQ2NWejJtcXRwYlA4TVA3?=
 =?utf-8?B?UktDV2xJZ1ZzUmJpZmt5WEpNYmZoZ1I3ZWdMeVVZR0svSkZnQ0xkUk5Zd3JM?=
 =?utf-8?B?RWFKclM3Yjk4RTlRaTlpNXF3M1pqVzhPYm5OMFVicE84WGxjZitjdGZGb0Ux?=
 =?utf-8?B?L1dCM3d0OTZUckpCdVhKNksyVjBma3h4SDAzbmh2WXZ1Rnk0NnRjV0FDMms1?=
 =?utf-8?B?V2d1QWpmUzhseE5PSmNWRnJjTTE3TDljMVc4L012Rnc2MUhOTHJaTHR1Q1c0?=
 =?utf-8?B?TnBvSnYvV1dlamlyTFY2NEs4ZWtFOWlGWXlZckNJZ0VKZGpaKzllMXRZUWJV?=
 =?utf-8?B?dEE1VGxxRUY3V0c1N1VmcjduN0YvMWxmWi9kNEpQNmF6YnFsWTRoc1JjUGd5?=
 =?utf-8?B?MHh2a3lZcGM3eWxhVFpJMVR2b3Y4dlU4TjdRZHV2bllEOFFHcGFsamMwbVUv?=
 =?utf-8?B?enY5TFN6ZmE2WGMreStWRUFWMGh6Nlc5bE5QVEdvYmszKzJIaWZDcnhSMFp2?=
 =?utf-8?B?VE0xZ1gzREVSZlU2OXo1Ujd6aEJVUkxXcDZjalYzTVVnSzdEd0YyWHVBUTh2?=
 =?utf-8?Q?ia4SJ26/K4vQ1naoqQTC52kdi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3582F40CB3E8643BAC0A0B389402286@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a7d876-188c-4bf3-b9b7-08db5da8e32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 05:20:15.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: df2VrJcnTDdd9vEmH3Pk5urxcKvqXacGSeXpfV/t9fKKiqBn/P3ZGso/H+6gnCn3o66grIJJtaOzIVz7heHH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA1LTE4IGF0IDEyOjQ4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBOZXdlciBTb0NzIHN1
cHBvcnQgYSBiaWdnZXIgR2FtbWEgTFVUIHRhYmxlOiB3aXJlIHVwIGEgY2FsbGJhY2sNCj4gdG8g
cmV0cmlldmUgdGhlIGNvcnJlY3QgTFVUIHNpemUgZm9yIGVhY2ggZGlmZmVyZW50IEdhbW1hIElQ
Lg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1l
ZGlhdGVrLmNvbT4NCj4gW0FuZ2VsbzogUmV3cml0dGVuIGNvbW1pdCBtZXNzYWdlL2Rlc2NyaXB0
aW9uICsgcG9ydGluZ10NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFJldmll
d2VkLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICB8ICAxICsNCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jICAgfCAyNSArKysrKysr
KysrKysrKysrKystDQo+IC0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMgICAgIHwgIDQgKystLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5oICAgICB8ICAxIC0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5oIHwgIDkgKysrKysrKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmgNCj4gaW5kZXggNzUwNDU5MzIzNTNlLi5lNTU0YjE5ZjQ4MzAgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTUzLDYgKzUzLDcgQEAg
dm9pZCBtdGtfZ2FtbWFfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQg
bXRrX2dhbW1hX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVz
aCwNCj4gICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRx
X3BrdCAqY21kcV9wa3QpOw0KPiArdW5zaWduZWQgaW50IG10a19nYW1tYV9nZXRfbHV0X3NpemUo
c3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2dhbW1hX3NldChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZQ0KPiAqc3RhdGUpOw0KPiAgdm9pZCBtdGtfZ2Ft
bWFfc2V0X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgX19pb21lbSAqcmVncywNCj4g
c3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSk7DQo+ICB2b2lkIG10a19nYW1tYV9zdGFydChz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2dhbW1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZ2FtbWEuYw0KPiBpbmRleCBjZTZmMjQ5OWI4OTEuLmQxOTRkOWJjMmUyYiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gQEAgLTI1LDEwICsy
NSwxMiBAQA0KPiAgI2RlZmluZSBESVNQX0dBTU1BX0xVVCAgICAgICAgICAgICAgICAgICAgICAg
ICAweDA3MDANCj4gDQo+ICAjZGVmaW5lIExVVF8xMEJJVF9NQVNLICAgICAgICAgICAgICAgICAg
ICAgICAgIDB4MDNmZg0KPiArI2RlZmluZSBMVVRfU0laRV9ERUZBVUxUICAgICAgICAgICAgICAg
ICAgICAgICA1MTIgLyogZm9yIHNldHRpbmcNCj4gZ2FtbWEgbHV0IGZyb20gQUFMICovDQoNCkkg
d291bGQgbGlrZSB0byBwbGFjZSBBQUwgZGVmaW5pdGlvbiBpbiBBQUwgZHJpdmVyIGFuZCBwYXNz
IGl0IHRvIGdhbW1hDQpkcml2ZXIuDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiAgc3RydWN0IG10
a19kaXNwX2dhbW1hX2RhdGEgew0KPiAgICAgICAgIGJvb2wgaGFzX2RpdGhlcjsNCj4gICAgICAg
ICBib29sIGx1dF9kaWZmOw0KPiArICAgICAgIHUxNiBsdXRfc2l6ZTsNCj4gIH07DQo+IA0KPiAg
LyoNCj4gQEAgLTU1LDYgKzU3LDE3IEBAIHZvaWQgbXRrX2dhbW1hX2Nsa19kaXNhYmxlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZ2FtbWEtPmNs
ayk7DQo+ICB9DQo+IA0KPiArdW5zaWduZWQgaW50IG10a19nYW1tYV9nZXRfbHV0X3NpemUoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBtdGtfZGlzcF9nYW1tYSAq
Z2FtbWEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgbHV0
X3NpemUgPSBMVVRfU0laRV9ERUZBVUxUOw0KPiArDQo+ICsgICAgICAgaWYgKGdhbW1hICYmIGdh
bW1hLT5kYXRhKQ0KPiArICAgICAgICAgICAgICAgbHV0X3NpemUgPSBnYW1tYS0+ZGF0YS0+bHV0
X3NpemU7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gbHV0X3NpemU7DQo+ICt9DQo+ICsNCj4gIHZv
aWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0g
KnJlZ3MsDQo+IHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICB7DQo+ICAgICAgICAg
c3RydWN0IG10a19kaXNwX2dhbW1hICpnYW1tYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiBA
QCAtNjIsNiArNzUsNyBAQCB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdm9pZA0KPiBfX2lvbWVtICpyZWdzLCBzdHJ1Y3QgZHJtX2NydA0KPiAgICAgICAgIHN0
cnVjdCBkcm1fY29sb3JfbHV0ICpsdXQ7DQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICpsdXRfYmFz
ZTsNCj4gICAgICAgICBib29sIGx1dF9kaWZmOw0KPiArICAgICAgIHUxNiBsdXRfc2l6ZTsNCj4g
ICAgICAgICB1MzIgd29yZDsNCj4gICAgICAgICB1MzIgZGlmZlszXSA9IHswfTsNCj4gDQo+IEBA
IC02OSwxNyArODMsMjAgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+IHZvaWQgX19pb21lbSAqcmVncywgc3RydWN0IGRybV9jcnQNCj4gICAgICAgICBp
ZiAoIXN0YXRlLT5nYW1tYV9sdXQpDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAt
ICAgICAgIGlmIChnYW1tYSAmJiBnYW1tYS0+ZGF0YSkNCj4gKyAgICAgICBpZiAoZ2FtbWEgJiYg
Z2FtbWEtPmRhdGEpIHsNCj4gICAgICAgICAgICAgICAgIGx1dF9kaWZmID0gZ2FtbWEtPmRhdGEt
Pmx1dF9kaWZmOw0KPiAtICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIGx1dF9zaXplID0g
Z2FtbWEtPmRhdGEtPmx1dF9zaXplOw0KPiArICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAg
ICAgICBsdXRfZGlmZiA9IGZhbHNlOw0KPiArICAgICAgICAgICAgICAgbHV0X3NpemUgPSBMVVRf
U0laRV9ERUZBVUxUOw0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgcmVnID0gcmVhZGwocmVn
cyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gICAgICAgICByZWcgPSByZWcgfCBHQU1NQV9MVVRfRU47
DQo+ICAgICAgICAgd3JpdGVsKHJlZywgcmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gICAgICAg
ICBsdXRfYmFzZSA9IHJlZ3MgKyBESVNQX0dBTU1BX0xVVDsNCj4gICAgICAgICBsdXQgPSAoc3Ry
dWN0IGRybV9jb2xvcl9sdXQgKilzdGF0ZS0+Z2FtbWFfbHV0LT5kYXRhOw0KPiAtICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBNVEtfTFVUX1NJWkU7IGkrKykgew0KPiArICAgICAgIGZvciAoaSA9IDA7
IGkgPCBsdXRfc2l6ZTsgaSsrKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAoIWx1dF9kaWZmIHx8
IChpICUgMiA9PSAwKSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICB3b3JkID0gKCgobHV0
W2ldLnJlZCA+PiA2KSAmIExVVF8xMEJJVF9NQVNLKQ0KPiA8PCAyMCkgKw0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICgoKGx1dFtpXS5ncmVlbiA+PiA2KSAmDQo+IExVVF8xMEJJ
VF9NQVNLKSA8PCAxMCkgKw0KPiBAQCAtMTk2LDEwICsyMTMsMTIgQEAgc3RhdGljIGludCBtdGtf
ZGlzcF9nYW1tYV9yZW1vdmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX2dhbW1hX2RhdGEgbXQ4MTczX2dhbW1hX2Ry
aXZlcl9kYXRhID0gew0KPiAgICAgICAgIC5oYXNfZGl0aGVyID0gdHJ1ZSwNCj4gKyAgICAgICAu
bHV0X3NpemUgPSA1MTIsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rp
c3BfZ2FtbWFfZGF0YSBtdDgxODNfZ2FtbWFfZHJpdmVyX2RhdGEgPSB7DQo+ICAgICAgICAgLmx1
dF9kaWZmID0gdHJ1ZSwNCj4gKyAgICAgICAubHV0X3NpemUgPSA1MTIsDQo+ICB9Ow0KPiANCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kaXNwX2dhbW1hX2RyaXZlcl9k
dF9tYXRjaFtdID0NCj4gew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+IGluZGV4IGQ0MDE0Mjg0MmY4NS4uMGRmNjJiMDc2ZjQ5IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC05NTgsOCArOTU4LDggQEAgaW50
IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UNCj4gKmRybV9kZXYsDQo+ICAg
ICAgICAgICAgICAgICBtdGtfY3J0Yy0+ZGRwX2NvbXBbaV0gPSBjb21wOw0KPiANCj4gICAgICAg
ICAgICAgICAgIGlmIChjb21wLT5mdW5jcykgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoY29tcC0+ZnVuY3MtPmdhbW1hX3NldCkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBnYW1tYV9sdXRfc2l6ZSA9IE1US19MVVRfU0laRTsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKGNvbXAtPmZ1bmNzLT5nYW1tYV9zZXQgJiYgY29tcC0+ZnVuY3MtDQo+ID5nYW1t
YV9nZXRfbHV0X3NpemUpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2FtbWFf
bHV0X3NpemUgPQ0KPiBtdGtfZGRwX2dhbW1hX2dldF9sdXRfc2l6ZShjb21wKTsNCj4gDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChjb21wLT5mdW5jcy0+Y3RtX3NldCkNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBoYXNfY3RtID0gdHJ1ZTsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaA0KPiBpbmRleCAzZTkwNDY5OTNkMDkuLmIyZTUw
MjkyZTU3ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaA0K
PiBAQCAtMTAsNyArMTAsNiBAQA0KPiAgI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4g
ICNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+IA0KPiAtI2RlZmluZSBNVEtfTFVUX1NJWkUg
ICA1MTINCj4gICNkZWZpbmUgTVRLX01BWF9CUEMgICAgMTANCj4gICNkZWZpbmUgTVRLX01JTl9C
UEMgICAgMw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jDQo+IGluZGV4IGYxMTRkYTRkMzZhOS4uYzc3YWYyZTQwMDBmIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gQEAgLTMyMiw2ICsz
MjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfZHNpID0N
Cj4gew0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX2dhbW1h
ID0gew0KPiAgICAgICAgIC5jbGtfZW5hYmxlID0gbXRrX2dhbW1hX2Nsa19lbmFibGUsDQo+ICAg
ICAgICAgLmNsa19kaXNhYmxlID0gbXRrX2dhbW1hX2Nsa19kaXNhYmxlLA0KPiArICAgICAgIC5n
YW1tYV9nZXRfbHV0X3NpemUgPSBtdGtfZ2FtbWFfZ2V0X2x1dF9zaXplLA0KPiAgICAgICAgIC5n
YW1tYV9zZXQgPSBtdGtfZ2FtbWFfc2V0LA0KPiAgICAgICAgIC5jb25maWcgPSBtdGtfZ2FtbWFf
Y29uZmlnLA0KPiAgICAgICAgIC5zdGFydCA9IG10a19nYW1tYV9zdGFydCwNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+IGluZGV4IGZlYmNhZWVm
MTZhMS4uYzEzNTU5NjBlMTk1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmgNCj4gQEAgLTY3LDYgKzY3LDcgQEAgc3RydWN0IG10a19kZHBfY29t
cF9mdW5jcyB7DQo+ICAgICAgICAgdm9pZCAoKmxheWVyX2NvbmZpZykoc3RydWN0IGRldmljZSAq
ZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0YXRlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0KPiArICAgICAgIHVuc2lnbmVkIGludCAo
KmdhbW1hX2dldF9sdXRfc2l6ZSkoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gICAgICAgICB2b2lk
ICgqZ2FtbWFfc2V0KShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSk7DQo+ICAgICAgICAgdm9pZCAoKmJn
Y2xyX2luX29uKShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBAQCAtMTg2LDYgKzE4NywxNCBAQCBz
dGF0aWMgaW5saW5lIHZvaWQNCj4gbXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhzdHJ1Y3QgbXRr
X2RkcF9jb21wICpjb21wLA0KPiAgICAgICAgICAgICAgICAgY29tcC0+ZnVuY3MtPmxheWVyX2Nv
bmZpZyhjb21wLT5kZXYsIGlkeCwgc3RhdGUsDQo+IGNtZHFfcGt0KTsNCj4gIH0NCj4gDQo+ICtz
dGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBtdGtfZGRwX2dhbW1hX2dldF9sdXRfc2l6ZShzdHJ1
Y3QNCj4gbXRrX2RkcF9jb21wICpjb21wKQ0KPiArew0KPiArICAgICAgIGlmIChjb21wLT5mdW5j
cyAmJiBjb21wLT5mdW5jcy0+Z2FtbWFfZ2V0X2x1dF9zaXplKQ0KPiArICAgICAgICAgICAgICAg
cmV0dXJuIGNvbXAtPmZ1bmNzLT5nYW1tYV9nZXRfbHV0X3NpemUoY29tcC0+ZGV2KTsNCj4gKw0K
PiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgbXRr
X2RkcF9nYW1tYV9zZXQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+
ICB7DQo+IC0tDQo+IDIuNDAuMQ0KPiANCg==
