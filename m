Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF96413E1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiLCDDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiLCDDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:03:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD82EF12;
        Fri,  2 Dec 2022 19:03:01 -0800 (PST)
X-UUID: 521b5642f27841f3a4ab7f21fe60329c-20221203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=z48wUZLPOdzVfXD3tiEpK1ghASVNcoebT95d4T+AUYM=;
        b=Z9cgARPbOXgBAsa1U11poWhkXjZtqoPFuFFbrxbtjzMiLkr+mEaDsHB0g6vy4lvAwdqbGhNouCnwp2tmL+jEgpP6qJ2r9EV6jszOAhuXK6Zepkqe/LkpobnqK8BtgzHKSTxe82/lY0vvt+K624zguFXEaFpM7qjJu8XRXk1HlgI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b19f1e8d-b136-45ce-a971-f236daed4c68,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:18
X-CID-INFO: VERSION:1.1.14,REQID:b19f1e8d-b136-45ce-a971-f236daed4c68,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:18
X-CID-META: VersionHash:dcaaed0,CLOUDID:e20f6e6c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:221202075737X5Z4J86O,BulkQuantity:14,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 521b5642f27841f3a4ab7f21fe60329c-20221203
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 77354820; Sat, 03 Dec 2022 11:02:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Dec 2022 11:02:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 3 Dec 2022 11:02:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjEK63seNsh7/aO9WTENVHJM9KMI//yZhTXjBHenA8+sGLtakeTEXYp5qShZYgUcHNiRd/WxnsjqFxbsnWIA4Nlh8RrmM1bDtXmOjPOulYSFGX0mx3fOBlXSdT2DshIsmKFIcco67aGOYl/a1Gx+mP+ibDVjNbBZeKv4A31vX/zIofR9+3pEF+cdigkDNqQVXAMCadckG7cZkf6reB8Bc1TZhLH7qZIkHEqPdPzojGCmzKc2w1tpyeRQv4HTl48t8gYxusZ8XzwxpaAF10UJjlABufJBvIOQoJLvZcth5RETrKSZ1TrhHEQb9o24D22wxjjq3Cfg5/Atypr8XrG3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z48wUZLPOdzVfXD3tiEpK1ghASVNcoebT95d4T+AUYM=;
 b=NBrGm7HYuwZbqhUaM8Bfoxu6mzYNDLua6tPa/Y1xO5acGWv1XW8uX8/YBPkiTJ90SHj1orcX0d7/oeV1eNUy7llY4fRpO5N4jLZUHX/sNr1YWG+3/Bf5ij5v2J6s6dxyARTak//OCLpYBXBWkqigS+LT0EK9LD3IPUd0aVyQACxK4Xlv1gn5SeULztUfMim123lql7JWhgq8dbOBxOl7GnG9Y3KUshS5srYnn86zVVHjxi4WJ1hL9XstJWicJPW/D05UE87Y4SWtfDBnLx24sySYcxYss5Lj7XxuR33dNVwbQUCcgWZn3QJyS0dITtLkKukx4gAd3BNJ4QP5QlCoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z48wUZLPOdzVfXD3tiEpK1ghASVNcoebT95d4T+AUYM=;
 b=GtIl/RTBcNxDLylxGgp6BuIkVJTeM7wqP6WcurFTQ7IWl3Y94oRbJvA0y6rO+dg9g1LvhOMZH+T3t5DA/ZP2sr5pUykfV8BJmVr6Mus8wLUgquJoUMouaN4wngGg4ISTBKgrOJfW1Ijbk5lmth92xDoojkeB8/SjB+K580A1Iz0=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5278.apcprd03.prod.outlook.com (2603:1096:400:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sat, 3 Dec
 2022 03:02:53 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5857.023; Sat, 3 Dec 2022
 03:02:53 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Thread-Topic: [PATCH v3,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Thread-Index: AQHZBX7AG4VJDLspXEqxzm/PVw0CBK5ZtlmAgADDhACAAQKcAA==
Date:   Sat, 3 Dec 2022 03:02:52 +0000
Message-ID: <90c13f6240ff372d4f54087d787355182dcca616.camel@mediatek.com>
References: <20221201121525.30777-1-yunfei.dong@mediatek.com>
         <20221201235729.GA1718283-robh@kernel.org>
         <f98a2f4a-737c-fef5-551b-04a92d255d0e@collabora.com>
In-Reply-To: <f98a2f4a-737c-fef5-551b-04a92d255d0e@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5278:EE_
x-ms-office365-filtering-correlation-id: f65a6e0d-4441-4ed5-6683-08dad4dade8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uYqEfrgEi+pV6yX75CENfIBjVp7bKvxBAFwvoACEBTmQjUzanHv3fEUWPBfActXC86hKW7bZT7uvNgyzV1RCb7BVMDfYP0tzeI4PqExkYULApYDJSc8tJIavWnIipbfZ4r95vJIqAtlPQWqMhD2lGATG6WMHi5Dkwpem+pLPPKJec4WDFlUvTJc2Rmd+dGVnhlK8rvCQNVH3MSmWgep28J3aiBdEec99NWIkcyYTLT25eKe8DvsKI7akaNEtNo2gEuqMkg/Fg0cleEp/WYTlz3Z/nc1kVYo7UTEioJ6nHvDABSImc5NZq4HXoDo+rrmxfwoPopzudnC7ILYtlgwHDoNXdIDofhx1Nx4zoFl3pJ2uo6LdhHxPEpntQMiq7QIzxYQXKonAlai/5c9L54nsNnLihrBWaQVsFqnDrOFIlQI0FHD+7NEEdoc8HPrFi/2Q9ZJeNMAZn5mCUjj9n7nqeqePAS2jv9b3udl+GB0G6AIKcJ6Lb8AI1X2mTLaHiDYp3nJFajw0Rkgvr3mnkt4ljY7ZK5A9Osw2CdWEQOxWkhzXVg+/CpiVW5SsNBuMNrMm1r0TdxX4hUNclJLr78YPIT4n5/VfX3lqfsUMu/kkxA1lAnxL4oh1urKX1nf11gKU8EkRMwM9/BlLCNbWEWnNhv1R0Sj0kSw7foiu6pSaO2Hz0is8AsswKLjChfFWOaSW5sdE3dJwvvAwjUi0g4UrfgOuuaphaGPeMlfGGpCkyXIUOIbMZdDv0hhYaX1QXaL+mg3Lr7oZlN1on2vxolvlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(6486002)(85182001)(36756003)(86362001)(38070700005)(6916009)(316002)(54906003)(8676002)(66476007)(41300700001)(5660300002)(71200400001)(7416002)(91956017)(4326008)(66946007)(64756008)(8936002)(76116006)(2906002)(66556008)(38100700002)(26005)(478600001)(83380400001)(122000001)(6512007)(66446008)(186003)(6506007)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkpSTzBmK0ZwUmtxTXdJMU5SNG9OUi9Wd3BLd0xxUjF3ajRYdXk1YlF0eVYy?=
 =?utf-8?B?aERpdlRQOHN2VGlHbmcwYVRqeXNVUjJJSjRIa1BMcDM0c1UyV0J5TWtYZ1k3?=
 =?utf-8?B?dnZ6UUhsYlpVQlJHT2RjNVhCVDhCVi82Smo1eFFZa2UxU003MCtZY20wN09q?=
 =?utf-8?B?SEgwREhqRDFwSW1oREdlSWJVa2FNNEZ2WGVRWVpkcW9IbHB5ZnBtdU9VNmJE?=
 =?utf-8?B?eC9VanpEYzhXUzMyNlBudWQwK2NTeTg2L0NEVDMwNnFKMU42cjFQdmlkMUVY?=
 =?utf-8?B?Um04RkpFUUxScXVVRmZzbGl4U3ZtQUFWYjh0eSt3OXppR3k3T1RDNWQ0dE0v?=
 =?utf-8?B?QzNjbTB6Tm5GazN5MXZhWncvT2NlaHhWMDFpaEc4b25rZnl4VTM5bTc2b0ow?=
 =?utf-8?B?YTdCbldTTUFLUmZCd0IrcmJYK3FxQ3JUOFNsV3NtY2RNWWxDQXJ4K0FsdzQ3?=
 =?utf-8?B?YVZITEd4OTh3YzBJY09tZHRjbStXOThsd1k0SHZtak8vY2xrNUpHNmRDUG9a?=
 =?utf-8?B?SFJoNUtKdW9QVEtnOU9tYndOWDh3dGRhSnNKWERhVXBTejZrTC9LMEJiVUow?=
 =?utf-8?B?U3dFU0lyblFHelRxV3l0ZWtjYXVKRFdBV3h0ajg5ajVXK3dTWVFnTXZ6eUc0?=
 =?utf-8?B?Q1psUTVGbmx6cnpCWW95YUhJUHd6L0phc1ZxRUtsa2lmQndkdlF1U1RmQytT?=
 =?utf-8?B?a3lpQkRDc0NvTUZFcmU3dnNhODZxczg3Tm52QXc0U09XNjh3THBjU2tpalJk?=
 =?utf-8?B?b3plQ0hxd2puRE5ERWgzWlhpa203ODdNclFBMTVEUUIyWU9OWGZUMVd6VzVE?=
 =?utf-8?B?QTJ5K0cvMytGM090Nlk4NDF1RUxEUU4rNE1FZTQxTTR3bDBzWUs3bUlIaHpP?=
 =?utf-8?B?VmpGS3RxRWxOZnJzVEllQU5jb0gvUTJKMUFQaDJoNzZjNGhReGl6Y0QyVXk2?=
 =?utf-8?B?dWRsTXpPRE5RbkRVY2lkby9vZHkveHg2TzdFTXlDMkg5cW8wcWx0RFhtZVdm?=
 =?utf-8?B?YnNmdDQxT3lXWFlnVTZHWmhzaEw3VDM5elhDNDNOcVRzbTlMNnlKY1ExVDdI?=
 =?utf-8?B?NWlUTURGNGVQbklZRVR3d1FUYTBJbmhlZHovaittdEJGMnVkbHZPdHZSWkpD?=
 =?utf-8?B?VU1kU1RYc2MyN2FjS3lLRXdNc1ZBdFp2cVNyWGQ0TEVSbmduN3F2WXpoaHAx?=
 =?utf-8?B?MG0xVzh1TEpHbGZ4aUtIb0xPUkgwL2NrYkZ6UTE3OTJ2UzhYQmdJcXE4Rnoz?=
 =?utf-8?B?S25pa2hhcVhNdUxkR0xONHgrdkVyNG9yRHMzZkUwaER3WlM1Y3RKdFp6YlEr?=
 =?utf-8?B?ak9tNGNzK2FxWXFDaWphWTVMZEI5dTN4Y0tSdlZ2NTA0QTJTNDlBVENnUUpo?=
 =?utf-8?B?UFArMXh5dzhKQS84cFJQQTFLcldLcEV1VzQ5ZFFSUG9lMzBmREZzclMrQ3dw?=
 =?utf-8?B?Tm5UK3UzMVZ0QWlpMmFkeFVEUVdBQmJZL3E1b2FsNlQvdmtEdjR4VWt5VGxa?=
 =?utf-8?B?OE4zUjhsL3FyYm9nd1I0cTRPQ2oyb2NBcVQrSXNqY0tYRWtuSjRUbkxUWFVi?=
 =?utf-8?B?NjIvcGpSVkpUQlNkSnBjK1FoMjlCd2lLZTVyNkFrOXZkQXVpMVpraG9Od3Na?=
 =?utf-8?B?dkltTndSejNpOWthNmdyYngxMEdKODExOThtekNpQUd2N2FqTWZpN0dwYnA4?=
 =?utf-8?B?N2ZINlBDZ3hRRU5SU1E3elhHV2hCNmd1WS9HeldGcHQ4aGtlNW5BK3hYUjlS?=
 =?utf-8?B?dEMxSW1rS1A3dUlDMGsyOGxKQWdpclAxdHNYRVlIQVlGRGdnVmZiSU45TEhY?=
 =?utf-8?B?NzRQMGdOVXJpVjNpbVpubkRsbjhlMk9Ea0NXY1p5dklvcktnZE10WmV3b3gy?=
 =?utf-8?B?Um16NU0xalU1NzlQUDl3Qys4VW9pWGtWNi8yYWRPVFhuVkRqSlVhMytsbWM4?=
 =?utf-8?B?UTluM3dBSkJpOGZ0YS8zcjBEYzRRUEFNbXpteE1ZMmJoNWdhdEk1Z3lyOFdH?=
 =?utf-8?B?WFF4WU45ZHBCUFdxa1ZzUE9LVXBmN3E5Unh1ZkVzSzVMWnZZSkhMR0tMcnFY?=
 =?utf-8?B?UU05QXM5SG9kdEJvaWQ5YTU3cmhaNWs5c2s1aUdqME5pM2FiUVd4M3hhdjdt?=
 =?utf-8?B?NU1sTXorVGN5UnhpOVlGa3RtWHFkQmVaUW9DVkZqVkhocS9WTG5BUklXVzRE?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C67D04ED2F2EC84FB304D858B429C1E8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65a6e0d-4441-4ed5-6683-08dad4dade8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 03:02:52.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8ImT+Ale5mih16KQWnYB7zyzEsv+FwcIK2b7+d+CkcfwDRN6Zk2brCewdaKJLmWxpwqVgODl5zm7NNsW9VZptL/+AXQ9S24OHWskzWIcIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5278
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCg0KSSBhbHJlYWR5IHNl
bnQgcGF0Y2ggdjQgYmVmb3JlIHlvdXIgc3VnZ2VzdGlvbi4gTG9va3MgdGhlIHNvbHV0aW9uIGlz
DQp0aGUgc2FtZS4NCg0KQ291bGQgeW91IHBsZWFzZSBoZWxwIHRvIHJldmlldyBwYXRjaCB2NCBh
Z2FpbiB3aGVuIHlvdSBhcmUgZnJlZT8NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5m
ZWkgRG9uZw0KDQpPbiBGcmksIDIwMjItMTItMDIgYXQgMTI6MzcgKzAxMDAsIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwMi8xMi8yMiAwMDo1NywgUm9iIEhlcnJpbmcg
aGEgc2NyaXR0bzoNCj4gPiBPbiBUaHUsIERlYyAwMSwgMjAyMiBhdCAwODoxNToyMlBNICswODAw
LCBZdW5mZWkgRG9uZyB3cm90ZToNCj4gPiA+IEZyb206IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9u
Z0BtZWRpYXRlay5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gPiA+IA0KPiA+ID4gbXQ4MTk1
IGFuZCBtdDgxOTIgaGF2ZSBkaWZmZXJlbnQgY2xvY2sgbnVtYmVycywgY2FuJ3Qgd3JpdGUNCj4g
PiA+ICdjbG9ja3MnIGFuZA0KPiA+ID4gJ2Nsb2NrLW5hbWVzJyB3aXRoIGNvbnN0IHZhbHVlLg0K
PiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVk
aWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBSZWZlcmVuY2Ugc2VyaWVzOg0KPiA+ID4gWzFd
OiB2NSBvZiB0aGlzIHNlcmllcyBpcyBwcmVzZW5kIGJ5IEFsbGVuLUtIIENoZW5nLg0KPiA+ID4g
ICAgICAgbWVzc2FnZS1pZDogDQo+ID4gPiAyMDIyMTEyODE0MzgzMi4yNTU4NC00LWFsbGVuLWto
LmNoZW5nQG1lZGlhdGVrLmNvbQ0KPiA+ID4gLS0tDQo+ID4gPiAgIC4uLi9iaW5kaW5ncy9tZWRp
YS9tZWRpYXRlayx2Y29kZWMtc3ViZGV2LWRlY29kZXIueWFtbCAgIHwgOQ0KPiA+ID4gKysrLS0t
LS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy1zdWJkZXYtDQo+ID4gPiBkZWNv
ZGVyLnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlh
L21lZGlhdGVrLHZjb2RlYy1zdWJkZXYtDQo+ID4gPiBkZWNvZGVyLnlhbWwNCj4gPiA+IGluZGV4
IDdjNWI0YTkxYzU5Yi4uMDk3ODFlZjAyMTkzIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy0NCj4gPiA+IHN1
YmRldi1kZWNvZGVyLnlhbWwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtDQo+ID4gPiBzdWJkZXYtZGVjb2Rlci55YW1s
DQo+ID4gPiBAQCAtMTEwLDE1ICsxMTAsMTIgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gPiAg
ICAgICAgICAgICBSZWZlciB0byBiaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS55YW1sLg0K
PiA+ID4gICANCj4gPiA+ICAgICAgICAgY2xvY2tzOg0KPiA+ID4gKyAgICAgICAgbWluSXRlbXM6
IDENCj4gPiA+ICAgICAgICAgICBtYXhJdGVtczogNQ0KPiA+ID4gICANCj4gPiA+ICAgICAgICAg
Y2xvY2stbmFtZXM6DQo+ID4gPiAtICAgICAgICBpdGVtczoNCj4gPiA+IC0gICAgICAgICAgLSBj
b25zdDogc2VsDQo+ID4gPiAtICAgICAgICAgIC0gY29uc3Q6IHNvYy12ZGVjDQo+ID4gPiAtICAg
ICAgICAgIC0gY29uc3Q6IHNvYy1sYXQNCj4gPiA+IC0gICAgICAgICAgLSBjb25zdDogdmRlYw0K
PiA+ID4gLSAgICAgICAgICAtIGNvbnN0OiB0b3ANCj4gPiA+ICsgICAgICAgIG1pbkl0ZW1zOiAx
DQo+ID4gPiArICAgICAgICBtYXhJdGVtczogNQ0KPiA+IA0KPiA+IE5hbWVzIG5lZWQgdG8gYmUg
ZGVmaW5lZC4gVGhpcyBpcyBhIHN0ZXAgYmFja3dhcmRzLg0KPiA+IA0KPiANCj4gSSB3YXMgdGhp
bmtpbmcgdGhlIHNhbWUgYnV0IHdhbnRlZCB0byB3YWl0IGZvciBzb21lb25lIGVsc2UncyBvcGlu
aW9uDQo+IGJlZm9yZS4NCj4gDQo+IFl1bmZlaSwgdGhpcyB3b3VsZCBiZS4uLg0KPiANCj4gLSBp
ZjoNCj4gICAgICBwcm9wZXJ0aWVzOg0KPiAgICAgICAgY29tcGF0aWJsZToNCj4gICAgICAgICAg
Li4uLiBtdDgxOTINCj4gICAgdGhlbjoNCj4gICAgICAgY2xvY2stbmFtZXM6DQo+ICAgICAgICAg
IC4uLi4gd2hhdGV2ZXIgd2UgaGF2ZQ0KPiANCj4gLSBpZjoNCj4gICAgIHByb3BlcnRpZXMuLi4g
YmxhaCBtdDgxOTUNCj4gICAgdGhlbjoNCj4gICAgICBjbG9jay1uYW1lczoNCj4gICAgICAgICAg
Li4uLi4gbmV3IG9uZXMNCj4gDQo+IC4uLnlvdSBzaG91bGQga25vdyBhbHJlYWR5LCBidXQgSSdt
IGp1c3QgdHJ5aW5nIHRvIHNwZWVkIHVwIHRoaW5ncw0KPiBoZXJlLg0KPiANCj4gQ2hlZXJzLA0K
PiBBbmdlbG8NCj4gDQo+ID4gUm9iDQo+ID4gDQo+ID4gPiAgIA0KPiA+ID4gICAgICAgICBhc3Np
Z25lZC1jbG9ja3M6DQo+ID4gPiAgICAgICAgICAgbWF4SXRlbXM6IDENCj4gPiA+IC0tIA0KPiA+
ID4gMi4xOC4wDQo+ID4gPiANCj4gPiA+IA0KPiANCj4gDQo=
