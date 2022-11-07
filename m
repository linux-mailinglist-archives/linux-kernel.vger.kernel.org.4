Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E9D61EB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiKGGfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiKGGfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:35:42 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03FC60EC;
        Sun,  6 Nov 2022 22:35:40 -0800 (PST)
X-UUID: 5a4eb6bcb3414fdca6cb7b74bc4128db-20221107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0cskPyBVZ55FrmqzZzmo3/Bp32wkYy0Tkm+NrrO3qDY=;
        b=RYMjt4maw6Qwjtcw2dA9YoIPfVzuDi0XM+8CUAXjuEiwHIISueuqgPjPW2EdKRWekyPUtBCT7HVUiTqqZeFtZ/mjJYYViL1frIkFsCgujpnfi1KF14q6Wk3otrBmhaZVCu5+ps74u+/mIl8FimvF6YJsMyUebPuQMJTSueGMw00=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:145a784e-6cf3-40f8-83f0-9fc96c05beac,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:c9b2a2eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5a4eb6bcb3414fdca6cb7b74bc4128db-20221107
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 703013369; Mon, 07 Nov 2022 14:35:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 7 Nov 2022 14:35:33 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 7 Nov 2022 14:35:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flSxl8ddwOJHAkmv9zvuS59kbfhW03lda4wqYmnrNhm++We2EGIuWJ8VJaKVQgLt+D6rnhQaGGk7ZbFSqCg8d2Swt/biyDDZijPk8yL6ARaxpbZLxIfhoeUd/BZhmFSJz6cnqBmSCdl3pn7OaJglc8bGrm7K6f8y2/o4fPBio5/u4bThOo2ORI32IRieWqE8nuiicNyIkMI1DxUrBAr50U5h+54IUHs1Xq02e9d5Ye2jXdK5L2/5nDT4QI9VLfe20iRJ0ymylWvOcR3A1H32TkikloST+mvugS2C4STIPYNl/urXem2GuhkpPjuhhVCX0ggFpa/+hFkoEfIHSf0e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cskPyBVZ55FrmqzZzmo3/Bp32wkYy0Tkm+NrrO3qDY=;
 b=TIlJgOxyVxuS7zFEDMbVI6XCV/0JBH+REQdxRjgSA7VTdRx3hdUrTY0EzVsMWmEq31fhkBRmP/ymxS7TgSonBeLLFZuCGk307fJCngoUYByCSocpb50LpTf+fTriM3FhdxSFo+YsReTzjknUYflX5BE+slYGfY0toM1gpP5xJ7kzgYIfu+pvrj/crfHpcQhcTHNYz/E5jzTu6ktFC/N8ROH+dxjIaY513539UKOgWvy55MpPvyyVI+V/VCqR5/QZuq/xEoScAxqB2sleK5Opa32kZDfblJme3qK4XlxJVr94aYG1oEFEH0lKP4I30O+E8NjF/UGis/o9SVT2NNhSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cskPyBVZ55FrmqzZzmo3/Bp32wkYy0Tkm+NrrO3qDY=;
 b=kPW6vwMzKG9fqKOba719rRKBLKbEY7Kca5ZxosnHmi2HbNreFLulctbC2xEj2ZTNl22xpxClG57TNjk8UxsgFSDmK1Bp3HILQvhwuzF2bx2kLKCyjW7fjfBlOlBWdTNhj/yystRVQx5+TmATpalUu5VaXhVFOe4x4yyrOjXP3N0=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SG2PR03MB6295.apcprd03.prod.outlook.com (2603:1096:4:176::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 06:35:30 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::80f0:f72d:8b24:b2e5]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::80f0:f72d:8b24:b2e5%8]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 06:35:30 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v3 10/10] media: platform: mtk-mdp3: decompose
 hardware-related information in shared memory
Thread-Topic: [PATCH v3 10/10] media: platform: mtk-mdp3: decompose
 hardware-related information in shared memory
Thread-Index: AQHY71Br10g3paVoaUOWHpFy1WOo6K4s+AuAgAYPlgA=
Date:   Mon, 7 Nov 2022 06:35:30 +0000
Message-ID: <f7a6fedfb67723054ed2892bc37c2c05b9f74661.camel@mediatek.com>
References: <20221103064842.12042-1-moudy.ho@mediatek.com>
         <20221103064842.12042-11-moudy.ho@mediatek.com>
         <bb439583-9963-b705-9239-b8cedc71b5db@collabora.com>
In-Reply-To: <bb439583-9963-b705-9239-b8cedc71b5db@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SG2PR03MB6295:EE_
x-ms-office365-filtering-correlation-id: b9eecd15-55a4-4aab-e94e-08dac08a442b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANxBOvouqfsH8UexdqkVmARuRuBara2tVoo2bi6h7Pxst426ff38xXsxGZM5w1EC0o1EFSYH4f54wcMaxqylE5ztXEXHI1j48/MZaKPby9tSxfQ87V5GC/VOYZtUWPTBtTK9RoPZnOXl6i2FdL7At6faYgN4TQJy8Dxej11gWOhlRPQI5JcbGFu5aSRhYr78VNOZa36o9ZWi9YK0iT9o149Pji0Kuj/GEqQwh1GPGTFWLKLnQovevRrzFbV1nQ3WTP3tCKBEp5aqV+lYRiWL/D3zHWocZIBvu2/GedlZplTmC8zk2ZC7Eq/13NHQibNIwfLYuKPpsYL495mn6riPEuQ0yZDfe6hPs5IDLYo0UIMoidV+kJCUJ8uHA1rPM0gsZiCDZcyL+6uCTASjAHuub156dNSrxzCNx0Av9LT7JKg4oOilojwJ+5QS5WhCdbQPUJSnPw34XjOHV3/QchJyIrWXk+eWhCFVwVqALAogt0BwYGD4LHeEaOBSRZt4EiWsn9nsR62mfmCC2YF+LCODOL+jffPPcN0TKRfPf5YsFjU7VHW3ObBRMUroHNeMPN1YJsy/asGOylULETV0AfE7SVLj8LYAts8aMFpexsTPh72UGrhhQ0caASX6MO/zzAyQwyGdnShgVy7LpqoAHF8LHoXkDD9Ebx2B4ytK/NGLJPJmw6A6Jb4BiWt3ffFXMqoFDwLwvFZsxP4L/X/gmCXKNqAiAy5sXVZJ4uklXalkxbKr59fPefTsi9Wz4yQukCC4PrxwGBNz1MycD75kIQ/cuWIyo7wpIK78rLkXYORG3V0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(6506007)(2616005)(107886003)(186003)(6512007)(26005)(122000001)(83380400001)(2906002)(110136005)(316002)(54906003)(478600001)(71200400001)(6486002)(5660300002)(38100700002)(41300700001)(8936002)(4326008)(76116006)(8676002)(66476007)(66556008)(66946007)(66446008)(64756008)(85182001)(36756003)(38070700005)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnJlRkxYcHl1aE1vVDZnZFdiY0NUMTIvdWhZNUFIODFiN3orL010c1F1OUI4?=
 =?utf-8?B?MXpVRzMwV1lncDVuVWFBR1pCVU0vUXhOaU9SeVlpTTkvNEh2ZGtWZ2ZqT1Nl?=
 =?utf-8?B?bmhkOXVvZ1IxRk50T3dGUDU1S2xDL2txeFNhalIzRUd5V2FPYno0WDJISTh3?=
 =?utf-8?B?WUtIcXFYM3d1S0hDMjk1V0cwekd2T01EZjJHbDVmSVIwWUZSMGNQSlJ6QmtX?=
 =?utf-8?B?TE5UR212cVd4YnB4bng3NytSS1RsK09SZFZaODd1YVpXUHlLME8rS1Z2OHFB?=
 =?utf-8?B?a1NTYno1YWdGbkxuNnY4NGJOclcyRWNxOUxaeFpQQldBS2xGM0g5aTZDQUY3?=
 =?utf-8?B?bXA5ZkJKV2d6bTdVd0Y3RnJ2bWd5STRtUkV0bkk1OHNvSTMweEM0aE9seTJa?=
 =?utf-8?B?MjNadlBGVTdHWnhmTERyZURFekFNOHVKT3lnb2J2T1BzWUROdW44ZGNCUmZX?=
 =?utf-8?B?RmZnVzMxbUozOGNvUjZ4M3hKWm1ubW1mM2xMeEorOHJ0dDdTVW5IQ3p3YkRW?=
 =?utf-8?B?ZU5ZRlBBT0toYXBoOUhNeVhJS0FudVR0cmJHTUY2a2oza1Z1TkUwbXpyUGlv?=
 =?utf-8?B?eGhnVUliZ085L095aklGM00yMStJK3NxZEhmNkpEaUk4Q2tUMHN3YXlPUWNC?=
 =?utf-8?B?TWErZmVkOTBweFJJV3lqUWJMNUhGSGQzamZFeWhCakFBL1c0SFdmZ2NTTENT?=
 =?utf-8?B?M0pzakZRSXorSjM4NTQ2cEp0ajhGMUZGMXhPS1FQL0NwcXkyckVHQ0kxangv?=
 =?utf-8?B?eTFsYS9ITllwSVl1Q1JVNEFPdlFWR09pN3dRQzIzeGhNMzRLK0lDMXBmN3Iv?=
 =?utf-8?B?dEkrYXZMWk1tNVJxQzFPRTdIbDZvN253N242YjhuUkpkUnMwdEVydVRXWlhh?=
 =?utf-8?B?MGxRbERjNllFMHdhYzR5Znc2U3dTWGN1YTdHWVZDV3A0dTVreEZWcC9ZWDhi?=
 =?utf-8?B?OGlqa2FualU0L3hyV3dLbFdlR1JpaW5HL3dhRHc2d2VYb3hUYVdaNEQ3T21w?=
 =?utf-8?B?ay9PRDBnbHlKVG5YYlZBRk5GbDhCckpudU1XK0piS3YwWEF4eFp6OTRiU3R0?=
 =?utf-8?B?UTRiOVhlV2lTbXNYUkhZMUhTeGdla09MeW1IYlV6R2FVVm9LWUVPUkRvWlpH?=
 =?utf-8?B?bWFPcEZ2KzI3b3VyRCtnVDg5T3MrenFCbHRUYUY5QW52TTExRWJLY04wZ05i?=
 =?utf-8?B?UGF5NmJlMVJMbkEwUGZDeE1BWjFzSUYwK3hVbVlFU2xVN1dMSEhLUmpQTWNM?=
 =?utf-8?B?emhlQkpualNCVWEvay9IMGc5WmxxWkJHREVId0REWFNSanZQbDV2aFYzYVpF?=
 =?utf-8?B?c2c2RW44bFRZajBlTHRZUU0vNERmT1liR0tFbFpWYzNOUFlGdnozc2RtT3RF?=
 =?utf-8?B?cVFkNVVKTGNCT2l0OW8zWU1rZndKRVZBUkRlbTlHK2hVYS9BQi9VYkM3MXNV?=
 =?utf-8?B?T3hjU3dQZXpYa2UzcnFvV2VUaE8zNXdUU3ArK0V2eDJsWWszUkFRSmQva1Ur?=
 =?utf-8?B?V2ZoUHVWOHRjeW5MRjFjY09lYUlWY0cwaGMrMkxJNXU3VjRpMCtTTUJNTGN5?=
 =?utf-8?B?SUFjUkZQRUFRYkg5YkE3ZmF2bWpsd0JCUDZZYStRYlZVMFdaelhWK21FOUYy?=
 =?utf-8?B?bUFQeXNadkYyR3FzL2QvOVJHODFaWVpaQVhmSDNSOTR3NmV6SkRCb3JDQVJk?=
 =?utf-8?B?eU9lWGhKVWduNWR1WFVFdisyTlZ0SXpGZmt5T2Rwb3hOeUtqSW9uUExqdmk4?=
 =?utf-8?B?cVVKemhUV3hWaGhEYWxGNVd2N1RqRmd5eXpzbXhJZ25LOFYyWXZMcGluV3JC?=
 =?utf-8?B?QXJ0TXc3NTV4UzhQQ3VrU3E3ODE2R1hZd1RrZ1UzR0dOMHVsTnVSTzQzczJI?=
 =?utf-8?B?cGpEMFh4UFJVUmJTVkQvdnJiVXNFVkhYYmZVR0lRZ0ZzRWE0aTRmQ1laeUNy?=
 =?utf-8?B?Q2Z6RTdlUG01QytFTGZUdHNRRU9odkVNbHpwTWM5dmpIZW5BVk9VTERBWGVo?=
 =?utf-8?B?Q3ZrUXd0dlFmdzRHVnhHNFY0MldwR01GTnh5K0xIMjZyL0pqN3JkS2RsZUJ3?=
 =?utf-8?B?TzdHbFJ0QVlZRWVMWHBncFhGNmcybmlzVm9raE53K2o2a0ZGVjRNN0FGTUJK?=
 =?utf-8?B?LzhFQVc1TTJNVVN0RnJpMlpVV1RQRGMzTXhKSlhNVTlUVzc2Q0MzNmdVZG5Y?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88B0EE9CEAEF5D4C803B31266ECC1964@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eecd15-55a4-4aab-e94e-08dac08a442b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 06:35:30.7625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SBdDPzS8zwX1YBzLq837NCOZMTL/Ep9i4/xFMC5jf5qGUYbshEHS+IwKKHpXi3lQJn8n6ynJl+A0Kwz01zsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6295
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

T24gVGh1LCAyMDIyLTExLTAzIGF0IDExOjAyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDMvMTEvMjIgMDc6NDgsIE1vdWR5IEhvIGhhIHNjcml0dG86DQo+
ID4gVGhlIGNvbW11bmljYXRpb24gYmV0d2VlbiB0aGUgTURQMyBrZXJuZWwgZHJpdmVyIGFuZCBT
Q1AgaXMgdG8NCj4gPiBwYXNzIGEgc2hhcmVkIG1lbW9yeSB0aHJvdWdoIHRoZSBjb29wZXJhdGlv
biBvZiAibXRrLW1kcDMtdnB1LmMiDQo+ID4gYW5kDQo+ID4gcmVtb3RlcHJvYyBkcml2ZXIuDQo+
ID4gVGhlIGRhdGEgc3RydWN0dXJlIG9mIHRoaXMgc2hhcmVkIG1lbW9yeSBpcyBkZWZpbmVkIGlu
ICJtdGstaW1nLQ0KPiA+IGlwaS5oIiwNCj4gPiBhcyBzaG93biBiZWxvdzoNCj4gPiANCj4gPiB2
cHUtPndvcmtfYWRkciAtPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rDQo+ID4gICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgfCBUbyBTQ1AgOiBJbnB1dCBm
cmFtZSBwYXJhbWV0ZXJzICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICB8ICAgICAg
ICAgIChzdHJ1Y3QgaW1nX2lwaV9mcmFtZXBhcmFtKSAgICB8DQo+ID4gICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAg
ICB2cHUtPnBvb2wgLT4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Kw0KPiA+ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAgICAgIHwgRnJvbSBTQ1AgOiBPdXRwdXQg
Y29tcG9uZW50IGNvbmZpZyBwb29sIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgIChzdHJ1Y3QgaW1nX2NvbmZpZykgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICpzdHJ1Y3QgaW1nX2NvbmZnIDEgICAgICAgICAgIHwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgIHYgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgKnN0cnVjdCBpbWdfY29uZmlnIE4gICAgICAgICAgfA0KPiA+ICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgKE4gPSBNRFBfQ09ORklHX1BPT0xfU0laRSkgICB8DQo+
ID4gICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSsNCj4gPiANCj4gPiBPbmUgb3V0cHV0IGNvbXBvbmVudCBjb25maWd1cmF0aW9uIGNv
bnRhaW5zIHRoZSBjb21wb25lbnRzDQo+ID4gY3VycmVudGx5IHVzZWQgYnkgdGhlIHBpcGVsaW5l
LCBhbmQgaGFzIHRoZSByZWdpc3RlciBzZXR0aW5ncw0KPiA+IHRoYXQgZWFjaCBjb21wb25lbnQg
bmVlZHMgdG8gc2V0Lg0KPiA+IA0KPiA+IFNpbmNlIHRoZSBxdWFudGl0eSwgdHlwZSBhbmQgZnVu
Y3Rpb24gb2YgY29tcG9uZW50cyBvbiBlYWNoIGNoaXANCj4gPiB3aWxsIHZhcnksIHRoZSBlZmZl
Y3QgaXMgdGhhdCB0aGUgc2l6ZSBvZiB0aGUgInN0cnVjdCBpbWdfY29uZmlnIg0KPiA+IGFuZCBp
dHMgc3Vic3RydWN0dXJlcyB3aWxsIGJlIGRpZmZlcmVudCBvbiBlYWNoIGNoaXAuDQo+ID4gSW4g
YWRkaXRpb24sIGFsbCBjaGlwcyB3aWxsIGhhdmUgdG8gdXBkYXRlIHRoZWlyIFNDUCBmaXJtd2Fy
ZSBmb3INCj4gPiBldmVyeSBjaGFuZ2UgaWYgdGhlIG91dHB1dCBjb21wb25lbnQgY29uZmlnIHN0
cnVjdHVyZSBpcyBkZWZpbmVkDQo+ID4gYW5kIHNoYXJlZCBieSBhIGNvbW1vbiBoZWFkZXIuDQo+
ID4gDQo+ID4gVGhlcmVmb3JlLCBhbGwgZnVuY3Rpb25zIHRoYXQgb3BlcmF0ZSBvbiAic3RydWN0
IGltZ19jb25maWciIGFuZA0KPiA+IGl0cyBzdWJzdHJ1Y3R1cmVzIG11c3QgYmUgc2VwYXJhdGVk
IGJ5IGNoaXBzIGFuZCBzbyBhcmUgdGhlDQo+ID4gcmVsZXZhbnQgZGVmaW5hdGlvbnMuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogTW91ZHkgSG8gPG1vdWR5LmhvQG1lZGlhdGVrLmNvbT4NCj4g
DQo+IEhpIE1vdWR5LA0KPiB0aGFua3MgZm9yIHRoaXMgbXVjaCBuZWVkZWQgcmV3b3JrIG9mIHRo
ZSBJTUctSVBJIHBhcmFtZXRlciBwYXNzaW5nDQo+IGFyY2hpdGVjdHVyZSENCj4gDQo+IEkgY2Fu
IGZvciBzdXJlIGdvIGZvciBhIHJldmlldyBvZiB0aGUgY29kZSB0aGF0IHlvdSd2ZSBjdXJyZW50
bHkNCj4gcHVzaGVkLCBidXQgSQ0KPiB3b3VsZCBwcmVmZXIgdGhhdCB5b3UgYWxzbyBwdXNoIHN1
cHBvcnQgZm9yIE1UODE5MiBhbmQvb3IgTVQ4MTk1DQo+IChyZXF1aXJpbmcgdGhlDQo+IGRpZmZl
cmVudCBJUEkgc3RydWN0dXJlcyBhbmQgYWxpZ25tZW50KSwgYXMgcHJldmlvdXNseSBkaXNjdXNz
ZWQuDQo+IA0KPiBUaGF0IHdpbGwgbWFrZSB1cyBhYmxlIHRvIGFjdHVhbGx5IHBlcmZvcm0gdmFs
aWRhdGlvbiBhbmQgd2lsbCBtYWtlDQo+IHVzIGFibGUgdG8NCj4gZ2l2ZSB5b3UgYSBiZXR0ZXIg
Y29kZSByZXZpZXcuDQo+IA0KPiBTaW5jZSB0aGlzIHNlcmllcyBpcyBkZWZpbml0ZWx5IGJpZyAo
aGVuY2UsIGEgYml0IGRpZmZpY3VsdCB0bw0KPiByZXZpZXcsIGJ1dCB0aGF0J3MNCj4gZmluZSwg
YXMgdGhlcmUgYXJlIG5vIGFsdGVybmF0aXZlcyEpLCB5b3UgY2FuIHB1c2ggc3VwcG9ydCBmb3Ig
dGhlDQo+IG5ldyBjaGlwKHMpIGluDQo+IGEgc2VwYXJhdGUgc2VyaWVzLCBkZXBlbmRlbnQgb24g
dGhpcyBvbmUsIHNvIHRoYXQgd2UgYWxzbyB3b24ndCBibG9jaw0KPiB0aGlzIHJld29yaw0KPiBm
b3IgU29DLXNwZWNpZmljIGltcGxlbWVudGF0aW9uIGNvZGUgcmV2aWV3cy4NCj4gDQo+IE1hbnkg
dGhhbmtzIGFnYWluIQ0KPiANCj4gUC5TLjogVGhlcmUncyBhIHR5cG8gaW4gdGhpcyBjb21taXQg
bWVzc2FnZSBgKnN0cnVjdCBpbWdfY29uZmdgIDotKQ0KPiANCj4gQ2hlZXJzLA0KPiBBbmdlbG8N
Cg0KSGkgQW5nZWxvLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgcGF0aWVuY2UgaW4g
dGhpcyBtYXR0ZXIuDQpBcyB5b3Ugc2FpZCwgdGhlIGZpcnN0IDgxOTUgc2V0dGluZ3MgcmVsYXRl
ZCB0byB0aGlzIHNlcmllcyB3aWxsIGJlDQpjb21wbGV0ZWQgYW5kIHJlbGVhc2VkIGFzIHNvb24g
YXMgcG9zc2libGUgZm9yIHJldmlldy4NCkFsc28sIHRoZSB0eXBvIHlvdSBwb2ludGVkIG91dCh0
aGFua3MgYSBsb3QpIHdpbGwgYmUgY29ycmVjdGVkIGluIHRoZQ0KbmV4dCByZWxlYXNlLg0KDQpT
aW5jZXJlbHksDQpNb3VkeSBIbw0K
