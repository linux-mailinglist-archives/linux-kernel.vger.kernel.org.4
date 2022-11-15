Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF9628FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiKOCAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKOCAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:00:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33EBDE;
        Mon, 14 Nov 2022 18:00:32 -0800 (PST)
X-UUID: 9da6df1e12ac408a9120f92ffc495ba6-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=25VZR2T1NYlkji+wVaNxxX3BzTMB1CeoXejJo7Jnybw=;
        b=hts2Pe1APLJtXp8rImaMiseE7bfXfx3Ud6DtGrVl3v5dIHSDQNljTBI8fRGFbcNTH0OE8JcPdBNBxdK95MZzdVC7wpLFhjjZV6MP2TzjvPuXc1vBWBjZH9L6xttjI7W2F82Yzh0GBtrJYIPJLNDFgjFJ0Q2qsrLiH+lf/AO1Kwg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:90cc5e06-56db-42af-a9cb-6519edaebd96,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:63c58373-e2f1-446d-b75e-e1f2a8186d19,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9da6df1e12ac408a9120f92ffc495ba6-20221115
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 632735384; Tue, 15 Nov 2022 10:00:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 15 Nov 2022 10:00:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 15 Nov 2022 10:00:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlaQSJNDl8RKOBa80hIMSD3uJfoxtkTgrBTN3D6Uwq8/mJccBcqnaLH5SvdzlUkzTA/huZT3VZK1khJTGF92i0jTqpAukpvR3foCBi2iZcTLHiqeQqim3Xv7K+b5MonTCLPsodNS7CYdGNAYr7nqFKOYAipbxd76oOMFZeD5fZLZpSJWqf0fTPgpIotC7ujPyyn/Y1g/C7OlT6Z+W7b0+ETOYglw/LbTe/iC5On3KIapdEOQ44ZI0hXSlEJ8d5+JLELllkLg3W3pllaC+j72FBiE9vIIaelnhBV25niaMDRizz/Y2RsMvbxo6Z7mbhTJUit1XVgXII9QLf5Z/8L30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25VZR2T1NYlkji+wVaNxxX3BzTMB1CeoXejJo7Jnybw=;
 b=gUvld07UQ+nkj6ukBXQwTDbznwFMaMI9Fb3laigj82UsZcrIqYdnyRG9H/b/Qlb3kdr4wuuOFAyvBkwHlONQKMabAHXY8smQIZSOLWQwPMKkQh8osE9rbAEvjOyFDLIgCKQHLx+rRTOoKyva/S/DujLp+G648EKbbJd4W8T6SOQJuAYzG50qBip1dSGhzxFdfMbQcCknP8uUjkx1DbJTm0/oZglF8t8/ApisRyYCY4UMzwlORqm7tDmEJdpLb7YmMWitMdIB+2Mto8QjSV6n7F0/ycz5QDI9I9z9f4z30wMsyL2sbkTKdaW5WZhEHlFCEDOSxWV7eDbJyyvfsUHZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25VZR2T1NYlkji+wVaNxxX3BzTMB1CeoXejJo7Jnybw=;
 b=M1ZXJKuPn9tR1hqF1SJnsSn+1b/+1nVgn4XezKSWYYo8t5c9ei+/efmbBGO/bzXbyy3C/vEz/wJ5PAU+ZA7gfPQBpH9IBDA/sAjtICSP4b9tYETlHr3kaSUAUbTZJh8Cqe2xCuUOizKhNZCd10FehPh0+qS+rWp85AkY+3B33+o=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SG2PR03MB6429.apcprd03.prod.outlook.com (2603:1096:4:1c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 02:00:24 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:00:24 +0000
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
CC:     =?utf-8?B?WGlhb3lvbmcgTHUgKOWNouWwj+WLhyk=?= 
        <Xiaoyong.Lu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?R2VvcmdlIFN1biAo5a2Z5p6XKQ==?= <George.Sun@mediatek.com>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: fix h264 cavlc bitstream fail
Thread-Topic: [PATCH v2] media: mediatek: vcodec: fix h264 cavlc bitstream
 fail
Thread-Index: AQHY4uayXmm78Htl6U2l3cOFODO/Xa4+bRWAgAD5JoA=
Date:   Tue, 15 Nov 2022 02:00:24 +0000
Message-ID: <2d7212e96ca2b80934cc5b53300f46e0454085a3.camel@mediatek.com>
References: <20221018114122.26785-1-yunfei.dong@mediatek.com>
         <f301a43a-5d55-1607-b8d3-5cd057977397@collabora.com>
In-Reply-To: <f301a43a-5d55-1607-b8d3-5cd057977397@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SG2PR03MB6429:EE_
x-ms-office365-filtering-correlation-id: f159f0d5-a4b9-46fd-f053-08dac6ad2910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNc3RXZXFDRihBBUcBuaj39nbwKV3PvDZ7XRkHhqK4LRvTRUFKd9nPZeda+9mDaWo056S5HXdLan2RzMRkhcRusmiKRbeyW9EV6hUhsjy0UqoAgr+3Szg2E4i969XEVulNmhZYgQoqgiSPrX20ZqAsLS/sSY72G429kN5tw+lycTm5HGFR+le2hn3/ltt+FuT3Q+TfGgjDszSB2625BfxZ4jx20wiuY/eLldHduqrvq5lZef3V0PFoj1a0jHyZar1MDVBusv1a8B3z4YTtNy6yiD/oNMxahdi2lfVJUjwuC3O4pStk1Oe+96q4w2fI+xXURWTTM0wlCnj9gWWfoP901vv4xdsJCcy2BvB4ax5L20IBk5pbGBYhaLhwW+P1EHKCNDLjs4D/457JvX8FkdnkxOiHm0ze7fLGW4MnlG1E8rWQy3OrOJ5UK4CZvpCW/ag3YHzh+wE6xsDf4CD41VmHl7z2LCahx7hZSTxWdiSMx6byHlf/tfs8Dhuh0hy8LF0R9mgsiHEISxYRCkidUfCK+rmQQqJ6HbgqMi2Blatslne4IVgFX4DvpqKdViyCtmLTAVIJXkZXHWYrAPq3uT9lGhZrAjGYtLKgCUFy/OwZOyassUTen4vjVSKhIIx4T5PlYroa0gKVyKJmL6Agm8SshcKAlafO1Vh/JID6klZ+rn1UaPio7uNvU8ImhdSIUVFzkg62aEREgpoSNdJbJ9xcBUL4MqXMIuvNQ3cQxsxDNsXagfKHzbDyqbkisaNs0LyZu48KDLb1BblXNlKXwAPGsiGS2zWsmVLQ/EVZ0jwNg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(122000001)(316002)(2906002)(86362001)(4001150100001)(38100700002)(85182001)(41300700001)(36756003)(7416002)(8936002)(186003)(5660300002)(2616005)(26005)(6512007)(76116006)(4326008)(66946007)(91956017)(83380400001)(8676002)(66476007)(64756008)(66556008)(66446008)(71200400001)(6486002)(478600001)(54906003)(110136005)(6506007)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFptN2JTWmZCS3RROSsvSjFGaFZRWms5UERPWm9nblNxU01zM1I4M3RiNHJ0?=
 =?utf-8?B?eW9lMGI1d0czNm5vcGZ1TXFIZ3JqZk9xOEdHcTFnNmVUcUpNYXpEYTZzazZk?=
 =?utf-8?B?Mzh5UHhkc2JpREdZcVpCeWoyMlJONFIyM3QyN1RRaW9DdHZZOVo3dUFBblN3?=
 =?utf-8?B?Z0J0Z3J6WU0xenQrTmNDVUhVTEd5STU4OUMxMnRWaFpNQUtYZnlzUEViSU01?=
 =?utf-8?B?UEdoSUtIRkV6SUxkT284WjVzemtWMGR2WitsYlIrcVhMYnp5RmcxT2pKb3lU?=
 =?utf-8?B?MjEvZjM2Lzl5dGRLdDJoVktnS2hUNVE1YnJKSjhpMHFYZEpVY1pJdTU2eXBY?=
 =?utf-8?B?WHVwTzNvTlZQZ3VJSnZJUmZwdVhqcTRsRWNJVmk3K0kwcFhpQ3pITisvcWxl?=
 =?utf-8?B?VU1vSHRTRThvSFBhcXpUam5XMEF6dmhKUjNqcGsvYUpWbEJkWG1YV3V1SVVW?=
 =?utf-8?B?eWVvYkQ4Wks4RFNXMFVnbG9Yc0FTVVBMWTMwaWsrTjE4ZEhIQXdqaVpmYTVx?=
 =?utf-8?B?dlpmVkkvQmJPNzBRQVBJQnA4TXdUenVPd2FMdUgzaFZsMjR0Y3pFN09ZT1ow?=
 =?utf-8?B?MjFEUE8vQnNPbHFkM2d4dTN6RGtJWmN4bUxMdURyQWRnZHVwV2FadVBVeFJy?=
 =?utf-8?B?bDBMSmNRNGlpNGJhUUx3c005YzdCZEU1Q2pJSGdvUXNwem1LU2sySnk0UnVz?=
 =?utf-8?B?NTdqUWQ4YlRNMDFZUTIxbC9lNzN1VmtjMVdwbEFiOHhQL1RRV1MrTkRESzRF?=
 =?utf-8?B?WFp3NnBaM1ZreEZGWXlLbmh0d25VeDRubFJNbUtDdmJtQkZaeC9wZHQyc0ZX?=
 =?utf-8?B?SGwzZm1DeW5DRXZqVzkrMUQ5VFVrZXppNVVaeERsT2k3MzZueFNQcWpYMWJG?=
 =?utf-8?B?MnBaYU1YY1NTcUYzUHlXejlrYjE4UGFhZW9lZ3lJSVJvWHQ2MmtHeEg5L0Fu?=
 =?utf-8?B?T2t5a2dpUEZGZUxBTG5ETzE2NWE4NHBzcDFkcVdoVGFiMTh2NXBabVFnM1Z1?=
 =?utf-8?B?b1R0NmZocUhrWkM0NzdGTWNiWnMxcjJZemlFQkxEcjNiYnkvaUhERnlDWUxn?=
 =?utf-8?B?VE1tR1ZlL1laRlVkK3hxc2t6cXh5VDhVZUxZK2tvRkZTS2RMTkZFeDJDZTc3?=
 =?utf-8?B?OUpTY2h1aHlEZFpUdjFWbURoeHZRdUJVVitTOFBFdEJjT0xOblQwdGk1ekF4?=
 =?utf-8?B?bWw0UXRSMDdHRDJtZ3ptbmYwcjlqWTBSYXo2VmkwMkEzZFc1bmtrTXFTTldC?=
 =?utf-8?B?R2lNSGgxSHBSMkFYb2VLVkVoSWVuMEgyNU1OYTdLV0VlSzlFWlpTUlhjMlBN?=
 =?utf-8?B?c3VYbCtKcmdwL3BmUVhPN0NnS0svM3haVDlibzRDVG9OTUU2V0tRYmhDSnl4?=
 =?utf-8?B?SDlGVk1McHc2RmVtdWUvMXRYSTk1STdpKyt2WTViYmczb2ZIL3luYW9TWUxm?=
 =?utf-8?B?SVRjeGxLSnZWbnIrbmlaMlVtTDNBNk5uYjZNdlBzb2hmTjc0Rk1MYWpkTlVH?=
 =?utf-8?B?MUNwdHF0c3Jsc3hlT0JVWGdkVDMzR3I0UmlBYVZxNWlRNmsxTklCdVRsOUF2?=
 =?utf-8?B?ajNLaEZyV2pKY1MxczEyN1dqcG50L2V6THJEVUxzc2puNE82cE1MU1V3dUJs?=
 =?utf-8?B?bm93NHk1UHExSFJFTmN1eW8yejEzWXZFdnF6ZXhiWEF2R0hzM2Zrcm03d1JP?=
 =?utf-8?B?WXl0WXZ4M0ZsSHNFL1JYL0x3QWJieXB6UExIeEZCZHhWdEtuVlBUOFludnJ0?=
 =?utf-8?B?Vyt5TWEvQk15UHIyejVrd290UXVYR2pmL3luei9XYlg3OFg0TEdTZm1Nd1J5?=
 =?utf-8?B?SWU0bWlpV1RiUUNmSmwveCt5aDVPQ25pYU43bXhYTmEzQXVVem92R3h0Z2FT?=
 =?utf-8?B?aDRPNC9PdXpuNWdzRjdlRmNIRi9PT0ZNOWw1Qi9CYXlRbVpNamdmVFAwbUNN?=
 =?utf-8?B?WWNKSldwa09pbFYveWtLdk1tNFc4Y29XckpxelMvcGJ2QVJUUnNhSTYxZ1RS?=
 =?utf-8?B?VzZyRFdkV0d0NDlpMUM0TWpXWHoxSTRjaW03d29aaU44KzB2NW9TVjFaSWNT?=
 =?utf-8?B?LzVXVFJxaEpReEJ1bk40aU00RWFxaXhxdlkyR2lBNklCWEcwMno2a01mVFpC?=
 =?utf-8?B?SytJbVQzT2h4NFpCbG5WVTF4aEQxQ0YrSkdRM2d6bTJyT1R3RExLaXNwZlVq?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <141FF673EB2948488C2E06FF9C2E3DC2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f159f0d5-a4b9-46fd-f053-08dac6ad2910
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 02:00:24.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfspVW7k8y0bad3ajlRin9isD026JbK1TeGxSwoQ1+8H8JthSBcBT06l21ycIUGNdNCRtG6Iz60RWv/VerIhPstcXEbTprxobHJ9v1wTcyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6429
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

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIGRldGFpbCBzdWdnZXN0aW9u
Lg0KT24gTW9uLCAyMDIyLTExLTE0IGF0IDEyOjA4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERl
bCBSZWdubyB3cm90ZToNCj4gSWwgMTgvMTAvMjIgMTM6NDEsIFl1bmZlaSBEb25nIGhhIHNjcml0
dG86DQo+ID4gU29tZSBjYXZsYyBiaXN0cmVhbSB3aWxsIGRlY29kZSBmYWlsIHdoZW4gdGhlIGZy
YW1lIHNpemUgaXMgc21hbGwNCj4gPiB0aGFuDQo+IA0KPiBzL3NtYWxsL3NtYWxsZXIvZw0KDQpX
aWxsIGZpeCBpbiBuZXh0IHBhdGNoLg0KPiANCj4gPiAyMCBieXRlcy4gTmVlZCB0byBhZGQgcGVu
ZGluZyBkYXRhIGF0IHRoZSBlbmQgb2YgdGhlIGJpdHN0cmVhbS4NCj4gPiANCj4gPiBGb3IgdGhl
IG1pbmltdW0gc2l6ZSBvZiBtYXBwZWQgbWVtb3J5IGlzIDI1NiBieXRlcygxNngxNiksIGFkZGlu
Zw0KPiA+IGZvdXIgYnl0ZXMgZGF0YQ0KPiA+IHdvbid0IGxlYWQgdG8gYWNjZXNzIHVua25vd24g
dmlydHVhbCBtZW1vcnkuDQo+ID4gDQo+ID4gRml4ZXM6IDU5ZmJhOWVlZDVhNyAoIm1lZGlhOiBt
ZWRpYXRlazogdmNvZGVjOiBzdXBwb3J0IHN0YXRlbGVzcw0KPiA+IEguMjY0IGRlY29kaW5nIGZv
ciBtdDgxOTIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0Bt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gY29tcGFyZWQgd2l0aCB2MToNCj4gPiAtIGFkZCBk
ZXRhaWwgY29tbWVudHMgZm9yIGZ1bmN0aW9uOiB2ZGVjX2gyNjRfaW5zZXJ0X3N0YXJ0Y29kZS4N
Cj4gPiAtIHJlLXdyaXRlIGNvbW1pdCBtZXNzYWdlLg0KPiA+IC0tLQ0KPiA+ICAgLi4uL3Zjb2Rl
Yy92ZGVjL3ZkZWNfaDI2NF9yZXFfbXVsdGlfaWYuYyAgICAgIHwgMzINCj4gPiArKysrKysrKysr
KysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNfaDI2NF9yZXFfbXVsdGlfaQ0KPiA+IGYuYw0K
PiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX2gy
NjRfcmVxX211bHRpX2kNCj4gPiBmLmMNCj4gPiBpbmRleCA0Y2M5MjcwMDY5MmIuLjE4ZTA0ODc1
NWQxMSAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL3ZkZWMvdmRlY19oMjY0X3JlcV9tdWx0aV9pDQo+ID4gZi5jDQo+ID4gKysrDQo+
ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNfaDI2
NF9yZXFfbXVsdGlfaQ0KPiA+IGYuYw0KPiA+IEBAIC01MzksNiArNTM5LDI5IEBAIHN0YXRpYyBp
bnQgdmRlY19oMjY0X3NsaWNlX2NvcmVfZGVjb2RlKHN0cnVjdA0KPiA+IHZkZWNfbGF0X2J1ZiAq
bGF0X2J1ZikNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICtzdGF0aWMg
dm9pZCB2ZGVjX2gyNjRfaW5zZXJ0X3N0YXJ0Y29kZShzdHJ1Y3QgbXRrX3Zjb2RlY19kZXYNCj4g
PiAqdmNvZGVjX2RldiwgdW5zaWduZWQgY2hhciAqYnVmLA0KPiA+ICsJCQkJICAgICAgIHNpemVf
dCAqYnNfc2l6ZSwgc3RydWN0DQo+ID4gbXRrX2gyNjRfcHBzX3BhcmFtICpwcHMpDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZ2Y29kZWNfZGV2LT5wbGF0X2Rldi0+ZGV2Ow0K
PiA+ICsNCj4gPiArCS8qIE5lZWQgdG8gYWRkIHBlbmRpbmcgZGF0YSBhdCB0aGUgZW5kIG9mIGJp
dHN0cmVhbSB3aGVuIGJzX3N6DQo+ID4gaXMgc21hbGwgdGhhbg0KPiA+ICsJICogMjAgYnl0ZXMg
Zm9yIGNhdmxjIGJpdHN0cmVhbSwgb3IgbGF0IHdpbGwgZGVjb2RlIGZhaWwuIFRoaXMNCj4gPiBw
ZW5kaW5nIGRhdGEgaXMNCj4gPiArCSAqIHVzZWZ1bCBmb3IgbXQ4MTkyIGFuZCBtdDgxOTUgcGxh
dGZvcm0uDQo+IA0KPiBXaGF0IGlzIHRoZSByZWFzb24gd2h5IG90aGVyIFNvQ3MgZG9uJ3QgbmVl
ZCB0aGlzPw0KPiANCkZvciB0aGUgaGFyZHdhcmUgbm90IGFkZCB0aGlzIGZlYXR1cmUsIGFuZCB3
aWxsIGFkZCBpbiB0aGUgZnV0dXJlIFNvYy4NCj4gPiArCSAqDQo+ID4gKwkgKiBjYXZsYyBiaXRz
dHJlYW0gd2hlbiBlbnRyb3B5X2NvZGluZ19tb2RlX2ZsYWcgaXMgZmFsc2UuDQo+ID4gKwkgKi8N
Cj4gPiArCWlmIChwcHMtPmVudHJvcHlfY29kaW5nX21vZGVfZmxhZyB8fCAqYnNfc2l6ZSA+IDIw
IHx8DQo+ID4gKwkgICAgIShvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJt
ZWRpYXRlayxtdDgxOTItDQo+ID4gdmNvZGVjLWRlYyIpIHx8DQo+ID4gKwkgICAgb2ZfZGV2aWNl
X2lzX2NvbXBhdGlibGUoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssbXQ4MTk1LQ0KPiA+IHZjb2Rl
Yy1kZWMiKSkpDQo+IA0KPiBJJ20gbm90IGNvbWZvcnRhYmxlIHNlZWluZyBvZl9kZXZpY2VfaXNf
Y29tcGF0aWJsZS4uLiB0aGlzIGxpc3Qgd2lsbA0KPiBncm93IHdoZW5ldmVyDQo+IGEgbmV3IFNv
QyBuZWVkaW5nIHRoaXMgYXBwZWFycy4NCj4gUGxlYXNlIHRoaW5rIGFib3V0IGEgZ29vZCBuYW1l
IGZvciBhIGZsYWcvcXVpcmssIG9yIGEgYm9vbCwgaW4gdGhlDQo+IHBsYXRmb3JtIGRhdGENCj4g
Zm9yIHRoZXNlIHR3byBTb0NzIGFuZCB1c2UgaXQuDQo+IA0KRm9yIHRoaXMgZmVhdHVyZSBvbmx5
IG5lZWQgdG8gYWRkIGluIHRoZXNlIHR3byBTb2NzLCBhbmQgd29uJ3QgZ3Jvdw0KYW55bW9yZS4g
U28ganVzdCB3YW50IHRvIHVzZSBjb21wYXRpYmxlIHRvIHNlcGFyYXRlLCBub3QgYWRkIG9uZSBm
bGFncy4NCg0KU28geW91IHRoaW5rIHRoYXQgdXNpbmcgb25lIGZsYWcgdG8gc2VwYXJhdGUgbXVj
aCBiZXR0ZXI/DQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQoNCj4gUmVnYXJkcywNCj4g
QW5nZWxvDQo+IA0KPiANCg==
