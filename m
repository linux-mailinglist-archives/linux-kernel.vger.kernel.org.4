Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06B5622358
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKIFKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKIFKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:10:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6018E27;
        Tue,  8 Nov 2022 21:10:44 -0800 (PST)
X-UUID: 156b2aeba5824d73a7b753cf896d300a-20221109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mw/6ibmRjjmYjWUeT8zl8xHO6ai4APNcSXmMLB4aCY4=;
        b=oeDDhctYr/Xn368DcKR2Ycvpk4Xq7Rss/gckTGCIzuYQQuwbPMPKJCGxaQ+axXXgvoWLoj6D+O71K/6UnsviLH6wxh53V+hKFparcuETQXLFwGK5a9luzYufvPHQthatpLFFDyECUhnzPSBD/6aTvvBpbUo00Z7iw8aUjPi2a6M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a4d92e83-4b9d-4529-a12c-9089f14a1c35,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:e08c0791-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 156b2aeba5824d73a7b753cf896d300a-20221109
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1272921625; Wed, 09 Nov 2022 13:10:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 9 Nov 2022 13:10:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 9 Nov 2022 13:10:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4qZ+BZGOoJYTv9sZ7kiCsWWw45M7+89xeQzFZdw5PPn1RiJvCokFSm+Rny9ghCYuvFLZXo6JxlNjLtfoLv01p7OXVhbD4pJuMEzyimKMGVZYd8AwkZk2tYa95EgfnDn5+MDHbBCfNEFxJnpDkr1mZn2oU0sSx1dyMxSHcfTLyyhOv4S6MHvfNrm3cQ4WnTZ6p3vA953Ad7jzfUtsJ5a8//m0C5yXkMxmfm7SVzd6go6YdGtxyqdXvtnbI6EvMLCzuxML+T8RRd/p+sIP0+TbYUp3PcYCZOLnReobvjalPtHzUQ1BLU8fXcB3mhrFqf9073YiQ8xihiX7vZxik+ooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw/6ibmRjjmYjWUeT8zl8xHO6ai4APNcSXmMLB4aCY4=;
 b=G+KqSM3IIl7Z0wyoe97feVRJ8fEmvKj2JBDAqnNBSHnwoN/H4c9iIV/n1ZRxIDn/anzwQtwopyWspkl9/9ObBEjIp42PN0QJ1jnBwTkAhw9SNF6/2UW42rxDXPr9fcyPLUjLpNPqDVuxTv8ePyohxCjKlDh/DNrIt0imZosB/xIG68axK68jDnJurMMkfFvXvFtRFu4ti1pFMkWPSJKxd9n02btL11kkdOX292mkmUxsAnW7NIxnIi6SJn8m0Ty7Bo8JVCYq1nxwsTq7E61aABQgtcPCnK5n4KS0cMl03stvCVgNV/FeDP4pOLdmoowEgrc5lMY6CiNDz7ORT5WqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw/6ibmRjjmYjWUeT8zl8xHO6ai4APNcSXmMLB4aCY4=;
 b=ZpSj6K2p1OkhouwlutLWwN92e62o2jEdkYhG97mG01IyTiAf3IyotXmoRwiEULUa3eoWYLxHh+0RiF9Sk8jiKtlundiVP2dXerOnWDcPGgZz0bc++/zdR/9/yIp5inMPGUKCGnIsELX/ow6NMZLX6dc8ZnOoTVWGvfoN6bg15/M=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by TY0PR03MB6243.apcprd03.prod.outlook.com (2603:1096:400:137::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 05:10:38 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::a3:bcad:7a9b:4104]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::a3:bcad:7a9b:4104%6]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 05:10:38 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v28 01/11] dt-bindings: arm: mediatek: mmsys: add vdosys1
 compatible for MT8195
Thread-Topic: [PATCH v28 01/11] dt-bindings: arm: mediatek: mmsys: add vdosys1
 compatible for MT8195
Thread-Index: AQHY8nnSLtwxCfJOd0GsnKYuxbwDRK41TzuAgAC/BoA=
Date:   Wed, 9 Nov 2022 05:10:38 +0000
Message-ID: <f6d7eaa0b7e2a3ed6567692616ebc1304500806c.camel@mediatek.com>
References: <20221107072243.15748-1-nancy.lin@mediatek.com>
         <20221107072243.15748-2-nancy.lin@mediatek.com>
         <c6297a1c-e282-4a18-f16c-fa2df08b440a@gmail.com>
In-Reply-To: <c6297a1c-e282-4a18-f16c-fa2df08b440a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|TY0PR03MB6243:EE_
x-ms-office365-filtering-correlation-id: dbdb951e-888c-4a6c-3611-08dac210bddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7fCxCY8k8g/y9d0q04LLPM8AKmudMMzQwsRQBWeIh+nlhoY7jD2fUteucAQeGSuu40/nuQ/VWxhlwUKqHNP+Ulb6cFcM4Z6swAifsa0dyoxVlRd+qnxCCTYcc/jWz66Q/cIZhqn4bJIFtoYD1ZqOjnRHkZNZtbhsd2cJq+ryvvXhw2vYzgjz6iICoLx46Z8j1h/0VxboixwOrNV3at3ej2TjDxLNqkOzhRiPlpACYTFghwZShRpuGgjdJ9JXztw/B1b+0QvA7AlYH7LBvmZgwiAhKmO8yEgFVc5j81BIWA0dq3T9InBMTY/3APdH3K4sNx61eajYzHKlhWkxHJuUS8X+v5FBjgh5U++eYI0oMWGGIt1bfyaGtvLUsw2802Bnl894mcvd+W6kyEbOJ7/PlWaG+H8ZpTEhBo5t9NJOat3xTvptLynbVHV+c47++vyYmqhhziUKeLZRHBp60E7Hb/O7bvsV13tfkBf09fg+SBuxjE6P30RTOUMd0G6vSrikXDSI3PlTp7ONzzPrBCH+cTS7GqwfiYfR8XaXMEzZN0TmwBJZYZqiS1tU+MoU1yyBSo7IX0lolBsWuIDU/I9N9yvvw2jVJDVM0kC1kNaS2UWxyy0gbk1bQ1LTWjN3h3QZJ2xiAoOBdU73qz5V0kgdryM9o3JMB7kzUkFVEyEDK/ctPtkrz2Amrz9UlirELK/+T253LSBSCb39hVpL7aqtCj/xl1kagKtu6ANWgcmqC3x2X+0mltD3u4wLfZ5jkyCw5v/bSidgRykhLExQKjKgwjOdgEoKs8peaji/u82NdduT8O/Rytcyf2iIUWbQTn8o8qx/FlXWf7N9bU9z8V0yMi4jNCGWC/C838W3iBHiIUFYgSTzQqilSo66SOVH2Q/FdlXI2e6iXUS0eDVv+aeL4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(83380400001)(38100700002)(6512007)(7416002)(41300700001)(38070700005)(36756003)(85182001)(66946007)(8676002)(76116006)(66476007)(66556008)(4326008)(66446008)(64756008)(6506007)(186003)(2616005)(8936002)(5660300002)(53546011)(966005)(6486002)(26005)(71200400001)(91956017)(478600001)(86362001)(316002)(54906003)(122000001)(110136005)(2906002)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGNDQzJaWkJIanU2S0JUVUJEb1dmWTgvanNNbDdUUnVpZkZsdld5YkJENGlu?=
 =?utf-8?B?U0tpL2diaDRnZmNxZk5kQ1I3OGREaC9TY2NOZjhlbGh4dEhtY01qZlFUYkFl?=
 =?utf-8?B?ZHVGQXN4Vzl0UkZ0c0dHcUFldFJYNHllZTVGUEN4SzNwRTVmSU00bEU5cmxH?=
 =?utf-8?B?QnlkLzVQYTU2TXVoanlXNUZxR1BJWjE4Ulc0MG0vb2ZvV3g4OVI2NjRLemJ5?=
 =?utf-8?B?ejRrTzdGUnFEQVJUWmtla2xBdEx5S3c0UWl1dmFQZHlGZk10N3VXdUtXWHBG?=
 =?utf-8?B?WER0SkRlaVQ1SXEwUjV6TklLRUgxNjdrdm5TVjhYeHljMDQ4S0JTazhFU3pj?=
 =?utf-8?B?M0Qrd2NUdjZ2dnVLOHltNXlZOUNlSUNkMFdkRzl0RjJnRGNzYTJDNVdIZE0x?=
 =?utf-8?B?NW8xcGZKdCtOQ1BKY0J5ZXJ3V2lHVGxpSDZFWCtjSlBxU2RYZE9HT2ROWTVK?=
 =?utf-8?B?emh6TzVVK1JGT1c4UW0rNUJyMDZOdEpKRkhVYi8ralZlcjV5WGhxVXd0ZDFB?=
 =?utf-8?B?M3BNWUtteHYrYkZqTmNUV0VxZWU4THZ3SVdwRysveFBweGRxL1ZQTmZvVXhs?=
 =?utf-8?B?L1cyVkcyRlMvTUMwV1NVd1hlbjd2VmZmNXBINTNlS3RLQzJoaGJqZVd0cW41?=
 =?utf-8?B?ck5pdEFqZWFTSnN4WnR6NmM5OTZqaXk0R050UlE1ZnlPR1MxVHJITHJDek1E?=
 =?utf-8?B?U1FvZGtxS3F3a2p2VzcrdWRkVldDdWtGTjVLTTNDVkxldkM4RktQZFRaT0tS?=
 =?utf-8?B?VWZDa3RGcTFUR1dzSHdXaDlyQWgxZGhLU2ZnVW52bmluNUFGOG5yZEJNNzBx?=
 =?utf-8?B?UTk4dHRJK0FlOXRBVjhRRGFZeVVTdXFvdzlPQW9XN3FrMDkvTWw0R1NhVnly?=
 =?utf-8?B?SEdiQ1lIUXNBVU9NNXJKNG1PenlxY0JoMmFyVzlJMnJWS1B1bkNOVGVxSldJ?=
 =?utf-8?B?SGNqajJXcHZlU3c0WGYySG5VLzlOellCK25UNVg2eDAzMHZDakhXVE1OZVZp?=
 =?utf-8?B?cFdJMjVUYXdSL2t2UUMva0VlUksxZ2dyTTZUc0hMeFNtMFV2WFVSbXRPOWNn?=
 =?utf-8?B?MXRJUmtsYnVnelVvdkJWZ0t2OFdHb2xaMXB4Wk1QRXAwR0d5SjluaTlVL3Z3?=
 =?utf-8?B?UXBNZko2MG0xOXdpTHZCblB4dFRzeUw5MnJyaDJ3MzNQRXBuVnh6VEZaeGFZ?=
 =?utf-8?B?TEZBTEJYTnpZQWd5RDk2aVFRL3JMbXBuTXZTWHMrTG1TZHJnMG15REMyWi9Z?=
 =?utf-8?B?bWNabVdFSjQ4ek4rQVNqd0VSSWYzbDZGR1QvNTdEK3hDQTBBcE5KdkFhVnlQ?=
 =?utf-8?B?bm9DMHBhQWhjMkZXdmkxMkdZSjI4VUdrTzZxZWF0SGZvTnpqT0NXemVvWUlI?=
 =?utf-8?B?Yk9uLy9id3hTaThkUGVTczJ3WVd1NnFabjR6NzZJbVlCR1BLZ200QVpQb0gz?=
 =?utf-8?B?UlFiZnVXdlFtRVZxR3FVZEhnd25ZWXdaNDFJaDZaR1lHTUowTmlXZ3piRmcx?=
 =?utf-8?B?eHY5TEhGRmVEU2FXSlRVSnNhK1FKVE0xbTdWSHcrSDVPWUdUdFpTTnkxVXJG?=
 =?utf-8?B?MEx6OXBvRWVQSzd0aWFWN0NaSUdqeXJXZi9WOGlHTDY4ZnRLeEptdGh1RTdM?=
 =?utf-8?B?ajV4UzZwUjVlZXR5aWZOaWJsbm1GekRSSlpBQmloNDJ2aHYveXVZZmVSRnVI?=
 =?utf-8?B?VHIyeDJpMXFRRXlrblUrYmxxV1lyd2lWUDJLemovVDFmS1BjaU5MUlBReEdz?=
 =?utf-8?B?Tk5MZjRHWFNOcTEyTC82Z1lOZ0RGLzBOVG5qc0RtUmc3MUF3MUNaYzNOS3Ri?=
 =?utf-8?B?Q215b1krRkk4UzJwWWw0bEp3RHBKc1NISDZsNjJlSVBpQXFvLzBnZk5yQVlN?=
 =?utf-8?B?dThHYVpKOXF6SmZUM0g1OGFiY1UvZVZlZWlMdy9jOGR1eFRnRS92UUJIM0oz?=
 =?utf-8?B?UzR4NWpMOURkQU1VUUJoQjlCNXZpWUEzbEpnUFFOaDY2MWJ5R2JmVWhNd0RW?=
 =?utf-8?B?dEJpZlBJU1VxRFVYY3RIZ09HYisxRnNMNWhISm1GUUZqbEhUOUd2WDVTZklU?=
 =?utf-8?B?dmRXWm9GVXNGc3FYNUZBS0pxQjRoSjJQRVNCVjFkeDNEaFprU29mWTg2Y1Fa?=
 =?utf-8?B?am9idU4rRTVkTFdYamR0dmNJT2xmZXlYUjNUNWR2ZDJpWDRVTFJRcERnNEcz?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6902A412E9A2D041AF02D0BBCF6E5C50@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdb951e-888c-4a6c-3611-08dac210bddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 05:10:38.6781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oqtn+dgxYpWW0FYG3TVCQjQ8HHvgvsy6AxSCyvFuwtdMeCvgYx33syFUE8QkqgykudWUcGD0iEowRNPJi8AurRJYB0bgzMCBQIq+rhU+kh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDE4OjQ2ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMDcvMTEvMjAyMiAwODoyMiwgTmFuY3kuTGluIHdyb3RlOg0KPiA+IEFkZCB2
ZG9zeXMxIG1tc3lzIGNvbXBhdGlibGUgZm9yIE1UODE5NSBwbGF0Zm9ybS4NCj4gPiANCj4gPiBG
b3IgTVQ4MTk1LCBWRE9TWVMwIGFuZCBWRE9TWVMxIGFyZSAyIGRpc3BsYXkgSFcgcGlwZWxpbmVz
IGJpbmRpbmcNCj4gPiB0bw0KPiA+IDIgZGlmZmVyZW50IHBvd2VyIGRvbWFpbnMsIGRpZmZlcmVu
dCBjbG9jayBkcml2ZXJzIGFuZCBkaWZmZXJlbnQNCj4gPiBtZWRpYXRlay1kcm0gZHJpdmVycy4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIDxuZnJhcHJhZG9A
Y29sbGFib3JhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55YW1sICAgICAgfCA0DQo+ID4gKysrLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
bWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtDQo+ID4gbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55YW0NCj4gPiBs
DQo+ID4gaW5kZXggMDcxMWYxODM0ZmJkLi5hYWFiZTIxOTYxODUgMTAwNjQ0DQo+ID4gLS0tDQo+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlh
dGVrLG1tc3lzLnlhbQ0KPiA+IGwNCj4gPiArKysNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtDQo+ID4gbA0KPiA+
IEBAIC00OCw3ICs0OCw5IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgLSBjb25zdDog
c3lzY29uDQo+ID4gICANCj4gPiAgICAgICAgIC0gaXRlbXM6DQo+ID4gLSAgICAgICAgICAtIGNv
bnN0OiBtZWRpYXRlayxtdDgxOTUtdmRvc3lzMA0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+
ICsgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXZkb3N5czANCj4gPiArICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODE5NS12ZG9zeXMxDQo+ID4gICAgICAgICAgICAgLSBjb25zdDog
bWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQo+ID4gICAgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+
ID4gICANCj4gDQo+IEkgdGhpbmsgd2UgaGFkIHRoYXQgc2V2ZXJhbCB0aW1lcyBhbHJlYWR5Og0K
PiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC82YmJlOTUyNy1hZTQ4LTMwZTAtZmI0NS01
MTkyMjNhNzQ0ZDdAbGluYXJvLm9yZy8NCj4gDQo+IFdlIHdpbGwgc29tZXRoaW5nIGxpa2UgdGhp
cywgYnV0IHBsZWFzZSBjaGVjayB0aGF0IHRoaXMgZG9lcyBub3QgZ2l2ZQ0KPiBhbnkgDQo+IGVy
cm9ycy93YXJuaW5nczoNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlhbWwgDQo+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5
cy55YW1sDQo+IGluZGV4IGViNDUxYmVjMjNkM2QuLjhlOWM0ZjRkN2MzODkgMTAwNjQ0DQo+IC0t
LQ0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVk
aWF0ZWssbW1zeXMueWFtbA0KPiArKysNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlhbWwNCj4gQEAgLTMyLDEzICszMiwy
MiBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODMtbW1z
eXMNCj4gICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg2LW1tc3lzDQo+ICAgICAgICAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1tbXN5cw0KPiAtICAgICAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE5NS1tbXN5cw0KPiAgICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgzNjUtbW1z
eXMNCj4gICAgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ICAgICAgICAgLSBpdGVtczoNCj4g
ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ3NjIzLW1tc3lzDQo+ICAgICAgICAgICAg
IC0gY29uc3Q6IG1lZGlhdGVrLG10MjcwMS1tbXN5cw0KPiAgICAgICAgICAgICAtIGNvbnN0OiBz
eXNjb24NCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWss
bXQ4MTk1LXZkb3N5czANCj4gKyAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gKyAgICAgIC0g
aXRlbXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LXZkb3N5czENCj4g
KyAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAg
ICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQo+ICsgICAgICAgICAgLSBjb25zdDog
c3lzY29uDQo+ICsgICAgICBkZXByZWNhdGVkOiB0cnVlDQo+IA0KPiAgICAgcmVnOg0KPiAgICAg
ICBtYXhJdGVtczogMQ0KDQpIaSBNYXR0aGlhcywNCg0KQXMgdGhlIHZkb3N5czAgcHJldmlvdXMg
cmV2aWV3ZWQgcGF0Y2g6DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1tZWRpYXRlay9wYXRjaC8yMDIyMDkyNzE1MjcwNC4xMjAxOC0yLWphc29uLWpoLmxpbkBt
ZWRpYXRlay5jb20vDQpTaG91bGQgSSBtb2RpZnkgdGhlIHZkb3N5czAgaXRlbXMgZm9ybWF0IGxp
a2UgeW91ciBleGFtcGxlPw0KDQpPciBzaG91bGQgdmRvc3lzMSBhZGQgaXRlbXMgZm9ybWF0IGxp
a2UgdmRvc3lzMCdzIHByZXZpb3VzIHBhdGNoPw0KICAgIC0gaXRlbXM6DQogICAgICAgIC0gY29u
c3Q6IG1lZGlhdGVrLG10ODE5NS12ZG9zeXMxDQogICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10
ODE5NS1tbXN5cw0KICAgICAgICAtIGNvbnN0OiBzeXNjb24NCg0KUmVnYXJkcywNCkphc29uLUpI
Lkxpbg0KDQoNCg==
