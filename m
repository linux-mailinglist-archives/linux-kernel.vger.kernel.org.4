Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2F74E940
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGKIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:40:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C64C0;
        Tue, 11 Jul 2023 01:40:11 -0700 (PDT)
X-UUID: 8998e9961fc611eeb20a276fd37b9834-20230711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dIBnsBJF3bR37J76SNCFTGhF6oZN6CrCvyEXmfYS4PI=;
        b=Mhpz5n2Fjnl0/em5jMaKXVVLLQ4D42H41lUWuRaoY1LnE1lpy25LWW0kltadimvlMa5KZD0ZL0PcilZbgwtkpF0C1Nrns+a9USpjz3e7ozKx6dq1+4kJSE++dMN1t6hEJuF4SOmwwolfAhORs6LxFdwwocJCfRGBIM+dtcqkDfs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:110a22b6-0cb1-4157-9b8c-1011c28f836e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:d2361a0e-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8998e9961fc611eeb20a276fd37b9834-20230711
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 139292264; Tue, 11 Jul 2023 16:40:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jul 2023 16:40:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jul 2023 16:40:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5ANuTuVUumhqnFCDQoY7KVf8MpBa2x2TQLo6qxSLyiXpEuNgiTlzlPe+638HSGgp06lO1dgRz+k129B2+hv+oWf3a8AvzsM1XrRBXd7YLx+oWu72FTNOSJ1O/xL+S8qSONYtCC7N8hKPObmSsmGuAxojnlMWRNQG1Y/GrVf4KQN7XWXl8XrFKaOeZDjzywuSS2Qdxx67MolJezEzzDB/y4WokUhCLoobhExMWl6tk3iKLzd5vJ+e9T2xWG8FHCiyGx4bASs4LfsokEfBjvH16O4hWAr1u1t+lPvUE7coNz5whXgIvJdxqynZkw4CIJWiQQ0AqUx5rIVB/NV/dna9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIBnsBJF3bR37J76SNCFTGhF6oZN6CrCvyEXmfYS4PI=;
 b=U2A7cfqawSAmc/MqX21evtcTJtJgJf3et2C/6e29C/Pz4YDBNVnGxQRpprzrHzzDHSn3a06+/f0GL+ZZHO0tx6s/MMnkWjtqN16wo/t82z5kJ6YZfffzwry+0x6hGQb9GNJHaC+ZdIJxNJgedpFKRyCCtCmTnu5RWFiuvc5NdU9Z4WH45KO8MNurtbSVuPr3tM6jdNvQT2iRd2H8i2kd/+NbNdpLJDf5GDGso0XAQgM30MfRfJuuCaSvlNu1A+dFjIWU60mpOlsAevzDeTLusJFU9WMmhVzXZ8acJPojciGkI6pFx9yKo0PijRQtJplh0lYlBBR4r09xYYB88c4A9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIBnsBJF3bR37J76SNCFTGhF6oZN6CrCvyEXmfYS4PI=;
 b=pYhPMXihs24TgIzJAqhVLAFQ3C2YPRZy0myE0MqidyAMF50fe5lAb4IHEmE27AAsMzl4Ta/pXgY2qobUHvn2mqfPtaKibvFH92lYcVZyKdfSzwdTQd53kgYU4P/lcbeqKfNomBv0D2IQJlHDSki5lCHTnjslNRJ4co1e95gbKZc=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by JH0PR03MB8024.apcprd03.prod.outlook.com (2603:1096:990:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 08:40:03 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::fdc9:3156:45ef:a4ed]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::fdc9:3156:45ef:a4ed%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:40:03 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "yhao016@ucr.edu" <yhao016@ucr.edu>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Thread-Topic: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Thread-Index: AQHZrs8UvTbDMJF+YUeLRsTWjG5vnK+qsAqAgAeCw4CAAhYngA==
Date:   Tue, 11 Jul 2023 08:40:03 +0000
Message-ID: <70f9504d7ed0199671760c01320be7ce17003102.camel@mediatek.com>
References: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
         <20230705080625.02b2bac5@bootlin.com>
         <CA+UBctBqtSvyBWf9ZwKbecTrh9_6sCDm_TyU-ncb+6h5y19K5g@mail.gmail.com>
In-Reply-To: <CA+UBctBqtSvyBWf9ZwKbecTrh9_6sCDm_TyU-ncb+6h5y19K5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|JH0PR03MB8024:EE_
x-ms-office365-filtering-correlation-id: 66b70194-5ea3-4195-f189-08db81ea6c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTb8Inblvj22V4m5Wv2xQ7Cwyoz1e0QRiAb9eN9SpU0LiTwbKIZq4/Z4VUbPLZQDNFd4MwxI/+JICmOJrtwF9krGBgDezjoSgh7mQwE/43vHNQZylOY2fJLgYmsx3HflybCPW6w0vW8XzIja58CG0bHvedcDtjIIJygUGrEQEQD2VsI05yuriqaHTi+UEek2Eq80zYU0wrCAU4xAFdPe/pFWRbdu5CBwh4Mbz3ovi952U4PvtVigGAzRLdZDVeVhKMGAb3QlKuGp0pIptsG/fLv47dL34LabpYgI90ZUDrQ55TMWe2R2neqVMTGRRPlawFPasyT4MKOLwosreUw2YqbUKrqmomD30H5ett7W862zJjL2lBI6qg+/2XeIAPbI4yciuRDw/sxKmJtB2JrUoiQvSM42kIe3qEnpE1aanTz+cu1bLJOYFsN0Aoe50Qx/YFTTBY74OFQKstNCZCU+p7bT3BFheN84DOCJKOpmyBNoaDv2EjoEWP7vr7sDUxrSYIwOUk4xXtmxOBAac4d9/zZL/ti2l7CQLrN2YqOQkhf7ZA7FGslbmDc/P3Hg6elWMtyYzcwQe9W+iCO3S+DTLt75U0O7dvJGNY56RO4KXCqbG7wLb+kcmVStjZnVZUfSR4A2k2KVV0be9HT/zwt0Dv+l+0cYyDn6P1UfrI+HAXrApfMHHWFq8UNO+J6200Lu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(6486002)(478600001)(71200400001)(83380400001)(26005)(2616005)(6506007)(186003)(36756003)(85182001)(6512007)(316002)(2906002)(41300700001)(38100700002)(91956017)(122000001)(66476007)(66446008)(64756008)(66946007)(66556008)(4326008)(76116006)(86362001)(8936002)(8676002)(38070700005)(5660300002)(110136005)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGlxbmJ5WndMVkJxZ3VyQ2tsekoxOFFKVVZwNUZIclgxNHQrWm9xbityR3p3?=
 =?utf-8?B?YXJabVZhSDQ2eTBYR0I1ZjVLRlJ5STBaNGIvRXlhWXgxRGNpYXdJUXJRZlRB?=
 =?utf-8?B?TWppYlBSY3Z6RUMxb0FDYUNjVXZGamxqRVN5VUtWOGQ1OTB0UHR3ZUZkeU5J?=
 =?utf-8?B?RUcvYjVyRDcxK2NDNnFJd0JmU1pFZ0M2NWZaSzdUQWFKK0p4ZmJPUGdmeE9R?=
 =?utf-8?B?cTFuZU5kTHNLRS9EZ3pIZXpPTEVOajNzZzdoUGp1ZXNBVnIwWWU1cUxGellx?=
 =?utf-8?B?RE83S1lqelBqMEhkL09WODBUcnV6TEtBVWY2d1BMRXlVTE9WSDBDMnR0Y0U5?=
 =?utf-8?B?b09mRTg5WGdaeTU0MjRZN004a0kwa3hCc2psQ3UvcjA1VFN2MGtCQ2lvN2NW?=
 =?utf-8?B?N0JKUm9MVXVSZnhIaklrRWQwQlBFdFpKUlA1amtJR3QxcGY0L1A1Zko0Misx?=
 =?utf-8?B?RjA1MnJZVkVsNUlXcDN0a1Q0ayt2a2Z1d1UxTDlURzRGNHF2WDltYk45VWxP?=
 =?utf-8?B?c0tWZm5qRjM0RnFYUDR5M1d4UThiYm81dTBYcmpXRG9GNmlxVFU1Z3JVVXBw?=
 =?utf-8?B?alhvbURicTRmRXNnRVNFNDRzQzc0cFQ5YnJoNEJqdmFxMnIrSWxaVklBd0hQ?=
 =?utf-8?B?WXpqaCtoakFOSHBoTTBndVBjUHVDNWpMVG5UNnRVREdoRERXbk5JbjJrV0Va?=
 =?utf-8?B?Wm1ZNU9tTndGS1pxeGxWSGZycWR1cU9QTFNuSHgwQjQvNllhVUozdjF3RE1M?=
 =?utf-8?B?c0VjamNDcEFneVo2eFovaUhwNEtSVEs4SWQwLy9Md3piSW1TbjRVQTFWTGpi?=
 =?utf-8?B?aWV1cHpWd2tsMVZFcFl5RGw5bkYxUkZFU2FLbWdyV1NUaHJNRGFJTGhwV2FN?=
 =?utf-8?B?MmZjQVNvMHUyTU9XZmNkY21laUhNYVdnT1J3bEdDTEdWaVZVVlJkRXVJMEFQ?=
 =?utf-8?B?d0UvR3VMUk9Qck9NUy82Z2tXRnh5TnRrczFvOGdWNlUxZDgwREpiaUNERFJ3?=
 =?utf-8?B?NlVab1VwZC9YSDlSWGNiektZczJibHFITFFtSkFJeTIranlPRWtkYnZPbHdT?=
 =?utf-8?B?V1A2Z1Y1dDFEYU9McHVDTENrdXkxLy80Q1ZIckdaNFpWVW10VnVnRmZuaE01?=
 =?utf-8?B?dXlrNERIdldwbXdQekdBZE1zSHo0bFByeGJ1V1RQQVdEdGR6OE1uOHZWazF5?=
 =?utf-8?B?Q0tDK3ZSMnlWNERwMWtaWXpYdU9IbzNwNFZVaGdYejFlZnU2bXh0K2FFTFJB?=
 =?utf-8?B?bm51WEM2UlBDdnNyaURKZ2pHZGJQTm9HMUJTVnJTQ1NERzllTUxKT055dDhh?=
 =?utf-8?B?ZG5PNmU5OHFseXc3YjJQTDBsT21rYTFEWFZIWFg4T1V4TkQxcTVvWW1rZ0Uy?=
 =?utf-8?B?dVdNL1p5dlBrZ0xpNmdHNE4vcUJCdmxFTXFGaDdORzV1UXA2OHBLTFNFUzEv?=
 =?utf-8?B?RGorOFk3NnM1SDBrdGpNdzN1MHYwTjZYVXpqdXNhQ3A2bVAyTWhwcVFvS1RO?=
 =?utf-8?B?MGJ0b0RabmNyUjFBdnZBY1BoT0RjZ3ViVDFwV0xmZ2NwVWtNVGNkZVdFaVl4?=
 =?utf-8?B?ZllTWWViM1kxb1hBblJRREdKaGpBclZhVEZoWFlXZElQM3hKeTRtNWFxaGdt?=
 =?utf-8?B?UjRVdzY2dGdQT29ldVoxRE9xZzNBM1ZwTk5xdFM0VFRoaGQ2cW5KeTBOVnhn?=
 =?utf-8?B?ektUVVF1NFJJWEFReDBFTzN4U1RNa2hMYlBWclJqK2g1L3BFcE9pdVhDZXRC?=
 =?utf-8?B?MDVEbWVacWVkSDgzVFp5ZzNyampRZlFyd0JOcnBDdGFPd2NoL3FSNkdLSTJN?=
 =?utf-8?B?WkZQTGN3MGM4VW5IcFZuWlo1bTRmbDlkT0pNTDBhS05ISEVrLzNrNXpUU3p2?=
 =?utf-8?B?NUo4Q2g4ZHhQOEtzUEtXQlVNL1IyLzc1WEZwYjlwZGlpemVIcXo3U3NJdXlt?=
 =?utf-8?B?VmZUUHFndVREbG41VXVuUGo0MExZbVhoVE9WLzZqb0pzNWNxVnlDQ0Zuc3ZT?=
 =?utf-8?B?dmppWjA1ODBRS1VhSnVxZVlLSDlWRWkvVVJMRmJCbFMzMTNZMklNMzNWOXor?=
 =?utf-8?B?czZ5V0E0YXBLTzJNRjl2d0UrSjlkaFB5dXNvNEJCTW1RTkhEUTdNWFkrQzhP?=
 =?utf-8?B?NGFOYnJvMjhyTnNmdXdrMmlpaUZvdjZ6YmFiem1US1psekJyUzRyck9YWk8y?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DD45D165AB5514ABABF2B15B43B724F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b70194-5ea3-4195-f189-08db81ea6c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 08:40:03.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdVytl2MQObOGr/27BcXnVYXyY66SGmF2gznrwQKwBPATMjdCmEsLaexzNkF8DCzw0vbTjMbeUE0DyXlI1tivhX8mqDonYH3OhywkVVGnEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8024
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTA5IGF0IDE3OjQ4IC0wNzAwLCBZdSBIYW8gd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgSGkgSGVydsOpLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEhvdyBh
Ym91dCB0aGlzIHBhdGNoPw0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXRf
ZXAwLmMgfCAxMSArKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdHUzL210
dTNfZ2FkZ2V0X2VwMC5jDQo+IGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldF9lcDAuYw0K
PiBpbmRleCBlNGZkMWJiMTRhNTUuLmFmMjg4NDk0M2MyYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvbXR1My9tdHUzX2dhZGdldF9lcDAuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9tdHUzL210
dTNfZ2FkZ2V0X2VwMC5jDQo+IEBAIC02MDAsNyArNjAwLDcgQEAgc3RhdGljIHZvaWQgZXAwX3R4
X3N0YXRlKHN0cnVjdCBtdHUzICptdHUpDQo+ICAgICAgICAgbXR1M19yZWFkbChtdHUtPm1hY19i
YXNlLCBVM0RfRVAwQ1NSKSk7DQo+ICB9DQo+IA0KPiAtc3RhdGljIHZvaWQgZXAwX3JlYWRfc2V0
dXAoc3RydWN0IG10dTMgKm10dSwgc3RydWN0IHVzYl9jdHJscmVxdWVzdA0KPiAqc2V0dXApDQo+
ICtzdGF0aWMgaW50IGVwMF9yZWFkX3NldHVwKHN0cnVjdCBtdHUzICptdHUsIHN0cnVjdCB1c2Jf
Y3RybHJlcXVlc3QNCj4gKnNldHVwKQ0KPiAgew0KPiAgICAgc3RydWN0IG10dTNfcmVxdWVzdCAq
bXJlcTsNCj4gICAgIHUzMiBjb3VudDsNCj4gQEAgLTYwOCw2ICs2MDgsOCBAQCBzdGF0aWMgdm9p
ZCBlcDBfcmVhZF9zZXR1cChzdHJ1Y3QgbXR1MyAqbXR1LA0KPiBzdHJ1Y3QgdXNiX2N0cmxyZXF1
ZXN0ICpzZXR1cCkNCj4gDQo+ICAgICBjc3IgPSBtdHUzX3JlYWRsKG10dS0+bWFjX2Jhc2UsIFUz
RF9FUDBDU1IpICYgRVAwX1cxQ19CSVRTOw0KPiAgICAgY291bnQgPSBtdHUzX3JlYWRsKG10dS0+
bWFjX2Jhc2UsIFUzRF9SWENPVU5UMCk7DQo+ICsgICBpZiAoY291bnQgPT0gMCkNCj4gKyAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4gDQpXaGljaCBTb0MgZW5jb3VudGVyIHRoaXMgaXNzdWU/DQoN
CmlmIHRoZXJlIGlzIG5vIGRhdGEgaW4gZmlmbywgbm8gaW50ZXJydXB0IHdpbGwgYXJpc2UsIHNv
IGRvbid0IHJlYWQNCnNldHVwIHBhY2tldC4NCg0KDQo+ICAgICBlcDBfcmVhZF9maWZvKG10dS0+
ZXAwLCAodTggKilzZXR1cCwgY291bnQpOw0KPiANCj4gQEAgLTY0Miw3ICs2NDQsOCBAQCBfX2Fj
cXVpcmVzKG10dS0+bG9jaykNCj4gICAgIHN0cnVjdCBtdHUzX3JlcXVlc3QgKm1yZXE7DQo+ICAg
ICBpbnQgaGFuZGxlZCA9IDA7DQo+IA0KPiAtICAgZXAwX3JlYWRfc2V0dXAobXR1LCAmc2V0dXAp
Ow0KPiArICAgaWYgKGVwMF9yZWFkX3NldHVwKG10dSwgJnNldHVwKSkNCj4gKyAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gICAgIHRyYWNlX210dTNfaGFuZGxlX3NldHVwKCZzZXR1cCk7DQo+IA0K
PiAgICAgaWYgKChzZXR1cC5iUmVxdWVzdFR5cGUgJiBVU0JfVFlQRV9NQVNLKSA9PSBVU0JfVFlQ
RV9TVEFOREFSRCkNCj4gQEAgLTc2NCw3ICs3NjcsOSBAQCBpcnFyZXR1cm5fdCBtdHUzX2VwMF9p
c3Ioc3RydWN0IG10dTMgKm10dSkNCj4gICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgfQ0K
PiANCj4gLSAgICAgICBlcDBfaGFuZGxlX3NldHVwKG10dSk7DQo+ICsgICAgICAgaWYgKGVwMF9o
YW5kbGVfc2V0dXAobXR1KSkNCj4gKyAgICAgICAgICAgYnJlYWs7DQo+ICsNCj4gICAgICAgICBy
ZXQgPSBJUlFfSEFORExFRDsNCj4gICAgICAgICBicmVhazsNCj4gICAgIGRlZmF1bHQ6DQo=
