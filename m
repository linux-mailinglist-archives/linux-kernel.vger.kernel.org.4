Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418EC6E4744
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDQMMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDQMMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:12:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531158A7C;
        Mon, 17 Apr 2023 05:12:13 -0700 (PDT)
X-UUID: 05d4d858dd1911eda9a90f0bb45854f4-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XUN/tN5HPff6Tig/8uyKAz+n2TcqFfKU0YFkwV/qGKQ=;
        b=P4PlQM4uqqzGA1As1qL2oNg4cZ52BhYXaK2weDQBmwcCJYmb+jNwXQOOP8NnJN4aCsCw/fnF2ICDE6LOfRqN6UacDl57EKAH2KGylU44iCjtKWTSp07WcN4ZjYBTUD9pKIrFDnImc/VgDLDnGxuHoCdnyTxYXW48RgxYAsVNcwE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:951b7fd9-c60f-4770-9a36-9296b569e2b7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:a5559aa1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 05d4d858dd1911eda9a90f0bb45854f4-20230417
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1606747247; Mon, 17 Apr 2023 20:11:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 20:11:45 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 20:11:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5fpRYor9FLJOXzyhLMpQBQ/t/+MLV8YCAgRbcf8tss+HJPqgeg4B5JwT0NYtA0chMVLLJDIe938GEOhL80yjhF0LdNeMI/I4ughlwBaFPC7Q5LMCt57OJRnYRXrzqB9TVP0z94LIWBxYhmnrcN+mqihDyhfWX04+hSkTw/fIzbDD8rdQynQF7E8VqisYRqzxORvGMonjGog0nQrgvbu+7uSX+Ya0UmIyMAi2QcQq2sCkAIMf53N8cklvfY1gvhNq73iZUirO1MtytZiOif3nxm9cxUNHD1Mx940TpCpRjc2JZWVZ+ma4gVO3KS3sbre0N3bTNIyyABzCWZkxAmJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUN/tN5HPff6Tig/8uyKAz+n2TcqFfKU0YFkwV/qGKQ=;
 b=Zs8ObX+5/W7ZoDitRU1Q5cgqT0mh2BPi3hFz3/zbIKp182Q9zPUZGZeu7UoSYi8dZAQEM9bN1KBj1EKaZuZ2qBVHZOCaktAG/SDgETVmUDq0UwqfUk7PgZO0wC6RW1WYIg53jsHTXCvmGvWPj79s2TWAnb5DZWjypD2h5kcx32/zZ6FALqKp1s4OsvA2LjN1aTy+AuKWw5GE+noDDVqUbICTHsd5DcYvrOdLY1MFsZ//mg7gHQNSQ+/GWIx6YPXLuVwNagDAZDdkUf8ZMK+TZWTuT8MDtVPTMiBBq2L6GE+Gt0psrM/A097kJobVEtfGZhLRSUsnDA1MiTYePNbtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUN/tN5HPff6Tig/8uyKAz+n2TcqFfKU0YFkwV/qGKQ=;
 b=KYluF3Jm5A0igohtC0F53wgY4VEI0FkW/no5nMbFuI3ZZz9765aRh2rltCtkGIWbMiK8waN5mdiPTtug6EJ3taWUwP5ES4HMZtrIHTeH8hln9EECqS3iikviFrkpxFoEim9/k/bNNdBWG/larvD3MC+pNsL5aN2IwwSbra5hsNE=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYUPR03MB7231.apcprd03.prod.outlook.com (2603:1096:400:357::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 12:11:42 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 12:11:42 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
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
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 4/6] media: mediatek: vcodec: add one empty lat buffer as
 the last one to decode
Thread-Topic: [PATCH 4/6] media: mediatek: vcodec: add one empty lat buffer as
 the last one to decode
Thread-Index: AQHZcPBP525Lfr1IN0WhAkyJRUZUvq8vPh0AgAAri4A=
Date:   Mon, 17 Apr 2023 12:11:42 +0000
Message-ID: <44c7b781bcaba28880440fe454accffafd7f70b8.camel@mediatek.com>
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
         <20230417054816.17097-5-yunfei.dong@mediatek.com>
         <4b58c2a9-0861-e79a-c740-954cdc193599@collabora.com>
In-Reply-To: <4b58c2a9-0861-e79a-c740-954cdc193599@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYUPR03MB7231:EE_
x-ms-office365-filtering-correlation-id: db423bd9-c182-4a30-24d7-08db3f3ce7ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNVjp0klfYHLUC9y7IC5RX3ESF3nLyoBLY1Hm6F8wHqnwzLnUb3tJlqPiIfTYJH4rCDRULO3wLPaVir7524ZIGuVNEymJXEEB/SUWlC0WfmDx1seA66bFxvZmV82KO4BVyGnLUlbcZIBK9oThUv7Pf6rNPE2s1VZNwAetqmsXt/3+zA19PWpJylaKQrQ4tRj9KJbON5PnZB9M2Dwg3amycWlHU+pK4Bq8caUhmJZXyg7bzXKnFmz6BINxmysdPjwmfqZeNqiAkElmU57RWZE43M6LaVheTwc09SmJmIG1SmWOBE8prQIyIQC/fymPXl/FRn8NFC6RVu5y+R/C+OG9ZxsZ+sAxCX9QVzLyy6FCqcnpQ0KKBlttiOEC0ksOcv5GE7PISR94untQOAeXBanZbSuny6Fs32bU+VHlia3zhgkoPdo7w9d4pdNhEQxQrlGT2TOdyScfcRQYCuHLV/uR9g195SMbwub+TCIliBshVTfzEZqgcuHd2XsCBUlIt0JxuU44p8/LjhOxIMnNNrAoJ/4pWsYkQXzbYYtcLaMVElkxphsyYQePJo3fev0bGgW559ioSc5+v4lNK4bRUemD/OrUeBpXeCUaDG+Esc5Mwj/9XIkJuV9DtC73Y0Tn6GMKY9MyDlEcr6gnPeRTbXZmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(478600001)(2616005)(186003)(26005)(38070700005)(110136005)(83380400001)(6486002)(6506007)(6512007)(316002)(71200400001)(54906003)(64756008)(66476007)(66946007)(66446008)(66556008)(4326008)(91956017)(76116006)(122000001)(38100700002)(8936002)(8676002)(5660300002)(7416002)(4744005)(2906002)(41300700001)(86362001)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnlFU0RYS2dtVHg0THZNNGcxRmZPd1BXQ3MwUUNDUWNVWlRxbGtSVnVoVjYv?=
 =?utf-8?B?eVNUN0c3WlhZUVlWblRMMjRmYmtwSzkrR2U0UVM3UHhabDBMMVRXNFl1clcr?=
 =?utf-8?B?eXp0L1lmSG9uRUo3Q1FGemVhRDZmQjMwU1V3VTR6cmhkTG9HMi9JZEx5NzJP?=
 =?utf-8?B?RFM4T013cUxDSHBEZ2hrbkJ5dHNDam53MXRRaGpUV0ZiQTZTVXl5WmROK1hr?=
 =?utf-8?B?cnR0cFJMTU9iek03TmZDSi9NYWRGNU9nYXNHczBxaWJJU3FBeTgyZUt0Zitp?=
 =?utf-8?B?Q1RjNVBJN2g0bUxUZFg4cEcwY2wyQnhHdEdNTTlIc215d0c3dXVXZVFMV3Nl?=
 =?utf-8?B?bk9samdMazFWQUJrclNuSUZIWmwreVhLazZDUEFPbzhlZ21zSUxMWWFTbXdp?=
 =?utf-8?B?aEJKcUZYSE5kUHRKU0gxa2tjWDczTEFIbkZ2RFkrTXdjS1hkV0tUTUhoM05C?=
 =?utf-8?B?MkN3ODdrZVlIOGsrUVNmZVN3Ym9weTBCSUxWaGY1NlNrdEFEdng3ckNrb1NC?=
 =?utf-8?B?ckF5R1hOamZUWndaSHVQS2JTd3lLLzBjbE9KNnlrcDd1Rm14V3IyaVBTOEtn?=
 =?utf-8?B?RDgwVVk2cVIwSnY1cVNzT0tKUDdqSGpWL3Q1VEMyemc0OXlGbXFZRGFOK3Iz?=
 =?utf-8?B?MFlVUzlOSG5Wb1R4VmVFTi9FeUlKOEF4UmEzZzVSTUZvN1FJdHpYT29SWVhH?=
 =?utf-8?B?cVVFTkRpWE9Gc2hwN2NLRk02QVdMMEd1eko0M2lnUlVwRTErTXhJT1VZczk0?=
 =?utf-8?B?SlE4NTdxSy9CblJMQkNxcCt1M1RFemw3SHI1Tm1TTzAwaHFRZjRxaHliQXVL?=
 =?utf-8?B?dGVDcmkrdkNhUU1mSFFSR2x6TzQ4aGx0Um5qVmVVZ29meDNPcENIVHlZSE5R?=
 =?utf-8?B?dFRRSUVYQUFmZzBYNFBabVU0U0NmcUFySFZQejBXcUFJUmtCeUZmVXIxdVdm?=
 =?utf-8?B?MTJDeW9Wb0tNL1pGNHhMeDIzbXc5bkVIaEV6b3hONzQ1S3pIZFlRVGpaeHJH?=
 =?utf-8?B?UHNCUWQrc3d1K3JFK2hrSHZtY2VkNW1TenVKcmZCUGJzYmpVS3NDQjlkNDh4?=
 =?utf-8?B?UWNqU0w3dUdRbEU4Qmp6cld4MHFwZkkxVXllUExKR3YxTm9UZ1FPWFc1R0Fu?=
 =?utf-8?B?VFhQMWZqTkp0TldIQkJtaDVGVnJaQ1VmaDhPaVRzNDB0QXpEUm9haHdBWWtC?=
 =?utf-8?B?Nlp5aWhTWWowQkt2c2ptV3ZLSXpmbUora0EzckxhVTRXaURGMzFBNW8ydGR3?=
 =?utf-8?B?RXpkMERqaWpDMGNlK2FNYjJtV0tkcURaNTRaUlhDTFYzOXNPWTJqSVZEdXNv?=
 =?utf-8?B?OUJsVGZCREp6K2x3bFpFUVJUQnhlZVlRSmh6c0ZkdWM0cWw3NmZpUEdNVVN0?=
 =?utf-8?B?ZGQ5cTZRMHhMeTNIS0lEL0FMMEVjdXBnRTN0cWxsem12VUJZK2Irend5UTJN?=
 =?utf-8?B?ZGZ6OG1QcThWd2FPRXBkL21oVy9TRlJaUnc5bXpFMWpTOHhCNW1sRHVoZHBr?=
 =?utf-8?B?R3VsNnlPTC9iU0hUTWY5SXFRUkw0KzJqa0dyVmxScjFYdFdleDZ2UStUYnBY?=
 =?utf-8?B?Rno2d09GMHZEd1BXWXAvSDFDS0Nxa0p3N3pvVWJEaE1hcllUODBneURVN0ZK?=
 =?utf-8?B?Q1ZzVjJFWkpTUmZvN2t2TXdTaGZCMWczdmQyZHlFNTlXQkNDYmdwVjgycUx3?=
 =?utf-8?B?K25aTzVwTGdwQ2xYcW92dFR5KzVoZ3JKOUJIQkkyUUpoVzBBSXFIcUtKSGJi?=
 =?utf-8?B?MmIyWkorWjBvdUs2NGhmVXFxL05jY1RybThVRzc5Ung3OHBvaUJJeTRsK1hN?=
 =?utf-8?B?cFVZS3VvUEZDN3c5Zktra0d5M3RGYUJ4N2wyTzRjQ0Z4ZU9oazF4Ykl0MnJE?=
 =?utf-8?B?ZkpSeGFiNytKWlVPbSs5YUwzWG55S0RpQktIMlVOWWR3aisyeVlJQzRHOVVk?=
 =?utf-8?B?by9tdzVxQUx1Z3Fsd2Y2MWtDOXNtek05SUZkbFViNG1tYmdEVElGSzRreWFn?=
 =?utf-8?B?ZnVTaktPWklScWtsME9OZ2FTNFNpWEVZcElXOXcyYTNvcWE5RmxrNkJhRkx5?=
 =?utf-8?B?aTIrTGc3VEp5SVNVeVpITVFhU3ovOFJaaVZTNStxZVFZVTc1SGI2bUVVVHBP?=
 =?utf-8?B?R2tvQmZQcmNsQlc1YlRFVzRiZE9RTWdhY01jNW43ZHBBb052UGRIbmduVy9k?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EE47FF8EB459D4E99912200B4A39A77@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db423bd9-c182-4a30-24d7-08db3f3ce7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 12:11:42.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Aj7QAhGcrbNonB7b+5pxWc+2/VhkNJocHsbKO2mBfQeVGUaK2ZGM4CrVGOmiDITCGoP4xzUFbJCcpFx1hJentSC8Uzx2jbpdU6y+9qmG+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7231
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBN
b24sIDIwMjMtMDQtMTcgYXQgMTE6MzUgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IElsIDE3LzA0LzIzIDA3OjQ4LCBZdW5mZWkgRG9uZyBo
YSBzY3JpdHRvOg0KPiA+IEFkZGluZyBvbmUgZW1wdHkgbGF0IGJ1ZmZlciB3aXRoIHRoZSBwYXJh
bWV0ZXIgJ2lzX2VtcHR5X2ZsYWcgPQ0KPiA+IHRydWUnIHVzZWQNCj4gPiB0byBmbHVzaCBjb3Jl
IHdvcmsgcXVldWUgZGVjb2RlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25n
IDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBTaW5jZSBjb21taXQgWzYvNl0gZGVw
ZW5kcyBvbiB0aGlzIG9uZSwgeW91IHNob3VsZCBlaXRoZXIgc3F1YXNoIHRoaXMNCj4gd2l0aCBb
Ni82XQ0KPiBvciBhZGQgdGhlIHNhbWUgRml4ZXMgdGFnIHRvIHRoaXMuDQo+IA0KPiBJIHRoaW5r
IHRoYXQgdGhlIG1vc3Qgc2Vuc2libGUgb3B0aW9uIGlzIHRvIHNxdWFzaCBpdC4NCj4gDQpGaXhl
ZCBpbiBwYXRjaCB2Mi4NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gDQo+IFJlZ2Fy
ZHMsDQo+IEFuZ2Vsbw0K
