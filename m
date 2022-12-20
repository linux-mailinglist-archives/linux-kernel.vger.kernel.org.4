Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81E46519B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiLTDlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTDlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:41:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E59260C;
        Mon, 19 Dec 2022 19:40:57 -0800 (PST)
X-UUID: 503be523d78247b5bee0fe18da5a0392-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nUvvc+DrseBrBAfsuZsAn0aSchRrkXYXgjdZu9l5uck=;
        b=pCe62VVb5URwLJ3zLzBpQuVqQZo8FCowkWxzsKj4SdAzSOloiRixIDHt7nNjoCz+QiV2AJBlKP+DuV0w8Cq3xgNR1d3WcO7aOIa876V/p66nCSyYAPIjAAiviM5uMWsp/59gSZJJe37pkelc2skv3DQnTYITOKSj6QSA11B7N8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:bdb46ce4-d336-49bb-8ad3-20e191667f20,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:a60266f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 503be523d78247b5bee0fe18da5a0392-20221220
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 375892555; Tue, 20 Dec 2022 11:40:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Dec 2022 11:40:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 20 Dec 2022 11:40:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSfLq7gbpV1UChOM8fLwtKwSjq7jmThDp3LAx19T+F0txOcizHd6nPIuHiCCQdIuMyzbhVp38OPMKRWS9wHAQXKjvNzbTfR1l8a0QlEu/J4j6eSfmiM0n0/Eu5t8QczecGNF61cHb3MbAYIPiwnrOi+bQKPz8PJazARwNV3KFbSW3i83H6F1XcBKAo7XnZIB/ms91CmKBb470szZASw2iHwiy5dv4q0l2ZQ3uI8Pt5rz2YvoViyLQbysP/hWMPGcy2sWG23MKJ727SG5mCrEsfI6iLr4K1XO75RCJERNzAotsdbKnuFJAHi1XAwbMbY6evKn8HHIb083gS5wEHiCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUvvc+DrseBrBAfsuZsAn0aSchRrkXYXgjdZu9l5uck=;
 b=oBlRwQ+uvv1UpZKohoHojJvcfadXh6077B5w0YOes4Es3TEqlsFAg9CmWQAvme8plQHhO9u8BP4fu9HEHkDDFwQSBgAecuhVIsa7prE1e4kuxnlIVWMWHmIyfa6/bwbqEkIyBzpdKk4E6vyCwLwNMYgRyZG4lWHXdzegVxMXQnB6fnhzLhKSqUSMj5BKbAIy/tJYb48vQEICT0mYfrgdXUuErG0GwUOnnpgHx9hM8GDsi5FC/GOPsEkolNMzqJA/ySI9INWeBaXSaVujQhQ6eE/IvMLfroHD06Aw0CmUXb0lklsQM4CETP/bHz337U5/tSb0EYL/dxdxucXdSluGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUvvc+DrseBrBAfsuZsAn0aSchRrkXYXgjdZu9l5uck=;
 b=CduB8LGZbcCE3YLD4dvZDSQSk3qHXN8PgSUgkkqSoWDuaJOSwvW3jjyve84VHfsKzuljjKPxxVLrPgtGfNn/r6CYfrZ9WPX/bof/6wGkRk3IT26RcQ5wktcObg1SUPIlgKbtr8hl+QwxUVEHdIQLvHIkEhhN4OOGr5a5udVFUMc=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by PSAPR03MB5783.apcprd03.prod.outlook.com (2603:1096:301:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:40:46 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%3]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:40:46 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Thread-Topic: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Thread-Index: AQHZCiFC6wxJGsqypUqp9QXhkHnrwq5wgO6AgATk2oCAALebAIAAGAgA
Date:   Tue, 20 Dec 2022 03:40:45 +0000
Message-ID: <212871d92b8062250c83c9db006c1c628b798280.camel@mediatek.com>
References: <20221207094921.15450-1-moudy.ho@mediatek.com>
         <5692faa0-6d7e-774f-9d6a-a495b44bdb3e@gmail.com>
         <dba479ea-968f-89eb-fc59-8235cbb2783a@gmail.com>
         <abfa4b935938a0b00bcccbc10e1a748f49f3497c.camel@mediatek.com>
In-Reply-To: <abfa4b935938a0b00bcccbc10e1a748f49f3497c.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|PSAPR03MB5783:EE_
x-ms-office365-filtering-correlation-id: 1163afb3-a9ba-459f-54dc-08dae23bfaa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dnZ/XHPdBaHoTCBuKnz+uwz62Wsrr6HwqbydrKiUV/U4ibr8+J7EUInY9prsnbsLGKZutmxNN3SPUzPGJOHHIwUKht8iwH7CCuZ1c7mVECjyQj70YEh7uSfBFTmVI7/TcBofRHnC99sYlwS5r7ld5vLuUICsv82afAB0HwQUi+/ZrAuctGop3wm4s6Z2RhqdaCefaa0cKMXVlypOR497lVW2TZCwRYIwAFM+oEPehAr95KyxuSQY5ENn1VKvLtIQJOFBUassfBMPouOtnKWom++FZyh4mPGy/QbpX1fl04clAfG9951zrvQZksYTaxmi/XTdttVh2xkr79hcbkeer0PWsJhL3+OXDFvGLYioFLtOeuvHT7maSBPqVSxYTr6kgcndj4388lUmgnhKdqohcAB76+p435N60JjBhvZdmJyDt1FCDtq5nrnx7XsoAdrnauOR3cX/oNqosXq7JZdiUi/hwobEG8Y6IsBrW4t5zllgFHx5FOKuhws4H7uSjmQ2Y1uesNqZudUKIE5o3Jqob3kccpZI+oAiksv1D2TZ4BminyvLF6yD7aNafPvoldac809pCkpNyhLj37pHkWMV+uwztMunWdWSqORc1FUerwVSBujwZeaEPBfwkYfejjNgYXtUlEaIHCp6uZ97OqhHIGuhyn4CeLPjaEpD8+JIEHTU8i1Wg/8mCxNp+FP8gGHOoeETb6BiXcsLGFkcrlgIXDGD27dtOi6Ap2dOp92yW9IPjhSAyiD05eCg0AO3fj5vytLTRTVuS3RHQs8wnq+mGofpZRlwdbA8NWpWXNbZ980=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(38070700005)(85182001)(36756003)(83380400001)(316002)(53546011)(86362001)(110136005)(71200400001)(478600001)(6486002)(966005)(54906003)(107886003)(4001150100001)(2906002)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(91956017)(8676002)(4326008)(5660300002)(8936002)(41300700001)(122000001)(186003)(38100700002)(2616005)(26005)(6512007)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjYwektMSHlyeXZzUm9DZ1JWK2Y1K1hDUlhlMjhEWEJIcWZ5ZjdRV2RjQ0d5?=
 =?utf-8?B?QTNKMzMrK0lKWFE0RU9FMUtFa3YxSXFySFlXYmhPWVFWVGw0UHE0a0lOdTVh?=
 =?utf-8?B?N1ZWTXZuOUpIVUNsK3BTTGlSNmxpeVBEYzhmRXhTSDg1cnlOTFFYOHBTU2Uv?=
 =?utf-8?B?cWdBTFowRWhERmM4OWgrVk9mbEtHZ3BpNDhWeDcvVk5Uczd6bzkxNEM1bDlq?=
 =?utf-8?B?L3Brdnk0TTl0d1RKREFNeU1zbVpXait0RU80ZktMdGowT2xVQjZac2l3REls?=
 =?utf-8?B?SEZKMFVaRHVFMEg2SXJ2NjRaRUVYeTNJbEtoekFNenFvcXlLcXRoRnprb0lV?=
 =?utf-8?B?N0VLeWVaVFFNL0E2NjJqNjJBcThKM0MvVVlSKzF2WStMN25uQmtFRzhlejUz?=
 =?utf-8?B?dWtQUGkrTU1ZaE82QmxzS01PYWhPSHN2MWg4YWtySkxsOWh0cHdxN2RGSlkx?=
 =?utf-8?B?cW5uYmw3Vkl1RFIyUEp6djhBSWV6dDM3WWdsNnlzbEYxYStwN2xnQkN1VkQ2?=
 =?utf-8?B?STNXdk1nbnhRa1FzcjdIWVlQMmRUa01LZFkyMUpPdmZOY1Jrc0FPUHVqUlVV?=
 =?utf-8?B?VUpsODFIMGI4S3JreGRyWE94dmFXVGdMQW9VZ2xTVklRTUJuMm5SdDBSTHN3?=
 =?utf-8?B?NVRmUEU3VzYvOWdrSjZJVmhwcFVSUW1XRkhteVF0dWlDdFlrK3RWNTQ5STdY?=
 =?utf-8?B?K3lVRnpsTDE2WGFJbHpzZzN2UGJJYkNyUi9GRFpIZTVrb0hBWFhRdFFHSFc2?=
 =?utf-8?B?SlBZcVFBODNPOEF2NXo0VXlYME1McVFiL2NyajdkS29RMGFCZGsyeFR1Mkpy?=
 =?utf-8?B?bzdFWHFjaGkxbTFGYlp6NGZMR3l4V3lhK1B2bjlVU2prRWRWSEdkc3VWTGFU?=
 =?utf-8?B?WXJaZUtoV0xoU2YwZ2ZjcEVLb3N4WW1KRFdVV1ZnOU5wZHhVSEpNK04yVERu?=
 =?utf-8?B?R29mcmx2MGZUQzhzRlZTVHdQVFh6WVhBZGxuMVlTOHBBeXFoaVN6RkpKNHBp?=
 =?utf-8?B?SUhoaDJ3VzQ3TmdTcEpkUkVrTlg5OXVjK01EUlZleFk3ZEdXS3RQdlA5Snpo?=
 =?utf-8?B?UDd2djI5RXNJNGc4OEZFanI5dFpUSy9BemIwV0V5VkVkaWkyOW9rdE5IenFw?=
 =?utf-8?B?YVlHZGRJWkV1dEtGYnJwWWpRUHA4NkdxdkpRTEtqaS9CZmhVRVoyQ2tyQlIx?=
 =?utf-8?B?MHNEeFJLVEJXL21ONEtzdEFOVE4wMUp1WnNtWnlzQVcxVkJmMnpFVHBsd0Zs?=
 =?utf-8?B?Tk9raXZzRVVBZTVwUEtvNUtyTFRjZHZkbXU1ZjhlREVBMjJQWFJ1NkhqRGV0?=
 =?utf-8?B?bzZNVWttUjExd2hYT3Mya2hSbG9MRUczemsvWUJvMWRNU1VyTkxFd0ZqdG1s?=
 =?utf-8?B?Rm5nemhEbkxEekVJSDl5VStsNHQrVEhzbVB5MjFGdFpuRndWT2lQWFZVaDMv?=
 =?utf-8?B?UXFmZTJraWlkbXNackk3c1VyOWhOcHRDVVlZV1FFVndOUDltQTNEN2J0bTB0?=
 =?utf-8?B?eTZqZ2UzVlhXM0NxcWkyRHIwNWplemJqM2VZVWdabkd6cTZJckNyWFhFbHox?=
 =?utf-8?B?UWRBckd1Y05Hck4vZGU1RysweWRqYU5LZWc1YThLVXUxQ0dlZStUNGQvbWFl?=
 =?utf-8?B?SVBRbHl0VEJIMENIU2s3TUlzOXA4R1Z6UUFET3dITkltZjA3ZDFEMWY4TFcv?=
 =?utf-8?B?cUJJTnoxQzBXNFB1NDBFNmhSY2FDSFRoSlJlSStpYUVoUGpEWGdDeXplSCtl?=
 =?utf-8?B?SnpMbXdzWXJFWHI0NFp2L1pMR3FLc01ac2UwUCtxU25Da1dCKzltLy9PSk92?=
 =?utf-8?B?R0dVcERqTlI4R2JvYldCdWxJbnl5aUY3dTdvdFVGOVV2ZVhIa08xOC9QZUhV?=
 =?utf-8?B?eVRsWjV1ajdJOVppYzAyeGR5Tk9oYlVWSXJuT01SeVpjMjJwdkVQNXNSSlR1?=
 =?utf-8?B?RVlXTk5zOU52SDFaQXhUMUdWcmJoNVJzRG1nc0hSby9kM1Qxdkt1VVBRUUpV?=
 =?utf-8?B?QTluRGhXWG1pSndxNis1TXRXYnNDQTJLUmY5bWpqYzVmSDgvMitZYVpmNkgw?=
 =?utf-8?B?RFFTMktTTEV2eWMxcEZsQ2kyejJQdXNQN0lDRVJOTTBZL1pvL1c4VGFEc1ZM?=
 =?utf-8?B?QUJpRXFGcTY4emJ1VXZROU4xWWZJQ1paN2EzS3R5VmlaYkt0WUxiQUpYaFVq?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D525381BE13C144B9A7761F61542076@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1163afb3-a9ba-459f-54dc-08dae23bfaa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 03:40:46.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwdm7sK5PcFoWSZNgqTAmH6IrM00qDKmJMUk+7vR1RSXPJWztXDWVLpmdhJ0uc1C6lmYLhTyG4qVhQy/0wi9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5783
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

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDEwOjE0ICswODAwLCBtb3VkeSBobyB3cm90ZToNCj4gT24g
TW9uLCAyMDIyLTEyLTE5IGF0IDE2OjE3ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0K
PiA+IA0KPiA+IE9uIDE2LzEyLzIwMjIgMTM6MzMsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+
ID4gPiANCj4gPiA+IFdob2xlIHNlcmllcyBhcHBsaWVkLCB0aGFua3MhDQo+ID4gPiANCj4gPiAN
Cj4gPiBBbmQgbm93LCB3aG9sZSBzZXJpZXMgcmV2ZXJ0ZWQsIHBsZWFzZSBzZWUgY29tbWVudCBp
biAxLzguDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBNYXR0aGlhcw0KPiA+IA0KPiANCj4gSGkg
TWF0dGhpYXMsDQo+IA0KPiBNYXkgSSBzZW5kIGEgbmV3IHNlcmllcyB3aXRob3V0IGEgZmFsbGJh
Y2sgY29tcGF0aWJsZSBsaWtlIHRoZSBtdDgxODgNCj4gVkRPU1lTIGRvZXM/DQo+IA0KPiANCmh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8y
MDIyMTIwNjAyMDA0Ni4xMTMzMy0zLW5hdGhhbi5sdUBtZWRpYXRlay5jb20vDQo+IA0KPiBSZWdh
cmRzLA0KPiBNb3VkeQ0KDQpIaSBNYXR0aGlhcywNCg0KU29ycnkgZm9yIHRoZSBpbmFjY3VyYXRl
IGluZm9ybWF0aW9uLCB0aGUgd2FybmluZyBtZW50aW9uZWQgaW4gWzEvOF0gaXMNCmJlY2F1c2Ug
dnBwc3lzIDAvMSBoYXMgYWxyZWFkeSBiZWVuIGRlZmluZWQgaW4gIm1lZGlhdGVrLG10ODE5NS0N
CmNsb2NrLnlhbWwiIGFzIGZvbGxvd3M6DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIxMDkxNDAyMTYzMy4yNjM3Ny0yLWNodW4t
amllLmNoZW5AbWVkaWF0ZWsuY29tLw0KDQpJcyBpdCBwb3NzaWJsZSB0byBmaXggaXQgYnkganVz
dCByZW1vdmluZyBbMS84XSwgb3Igc2hvdWxkIEkgc2VuZCBhIG5ldw0Kc2VyaWVzPw0KDQpSZWdh
cmRzLA0KTW91ZHkNCg0KPiA+ID4gT24gMDcvMTIvMjAyMiAxMDo0OSwgTW91ZHkgSG8gd3JvdGU6
DQo+ID4gPiA+IEZyb206IG10azE4NzQyIDxtb3VkeS5ob0BtZWRpYXRlay5jb20+DQo+ID4gPiA+
IA0KPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+ID4gPiAtIFJlYmFzZSBvbiBsaW51eC1u
ZXh0DQo+ID4gPiA+IA0KPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+ID4gPiAtIERlcGVu
ZCBvbiA6DQo+ID4gPiA+ICAgIFsxXSANCj4gPiA+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVr
L2xpc3QvP3Nlcmllcz02ODEwOTdfXzshIUNUUk5LQTl3TWcwQVJidyFnaVpWeThUaUZOeWxnV0tP
akk3NWZTbWxlTjZVbGNrUHVpWHpGZjVqYmRWZ0ZiSGRJeEczZDNKdmtxcDdFa2E3M0kyVG1hdGFE
X2Q1UWp6Qm5rNi1zWVkkDQo+ID4gPiA+ICANCj4gPiA+ID4gIA0KPiA+ID4gPiAtIFNwbGl0IGR0
cyBzZXR0aW5ncyBpbnRvIHR3byBwYXRjaGVzIGJhc2VkIG9uIGJlbG9uZ2luZyB0bw0KPiA+ID4g
PiBNTVNZUw0KPiA+ID4gPiBvciBNVVRFWC4NCj4gPiA+ID4gDQo+ID4gPiA+IENoYW5nZXMgc2lu
Y2UgdjE6DQo+ID4gPiA+IC0gRGVwZW5kIG9uIDoNCj4gPiA+ID4gICAgWzFdIA0KPiA+ID4gPiAN
Cmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTY4MTA5N19fOyEhQ1RSTktBOXdN
ZzBBUmJ3IWdpWlZ5OFRpRk55bGdXS09qSTc1ZlNtbGVONlVsY2tQdWlYekZmNWpiZFZnRmJIZEl4
RzNkM0p2a3FwN0VrYTczSTJUbWF0YURfZDVRanpCbms2LXNZWSQNCj4gPiA+ID4gIA0KPiA+ID4g
PiAgDQo+ID4gPiA+IC0gQWRkIGNvbXBhdGlibGUgbmFtZXMgdG8gVlBQU1lTMCBhbmQgVlBQU1lT
MSBpbiBNTVNZUyBiaW5kaW5nDQo+ID4gPiA+IGZpbGUuDQo+ID4gPiA+IC0gRml4IFZQUFNZUydz
IE1NU1lTIGFuZCBNVVRFWCBkdHMgdG8gcGFzcyB0aGUgZHRzYl9jaGVjay4NCj4gPiA+ID4gLSBS
ZW5hbWUgbXRrX21tc3lzX21lcmdlX2NvbmZpZygpIGFuZA0KPiA+ID4gPiBtdGtfbW1zeXNfcnN6
X2RjbV9jb25maWcoKQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiAgICBtdGtfbW1zeXNfdnBwX3Jzel9t
ZXJnZV9jb25maWcoKSBhbmQNCj4gPiA+ID4gbXRrX21tc3lzX3ZwcF9yc3pfZGNtX2NvbmZpZygp
Lg0KPiA+ID4gPiAtIENsZWFuIHVwIG10a19tbXN5c192cHBfcnN6X2RjbV9jb25maWcoKS4NCj4g
PiA+ID4gLSBBZGQgYSBjb21tZW50IHRvIG10a19tdXRleF93cml0ZV9tb2QoKSBhbmQgY2xlYW4g
aXQgdXAgZm9yDQo+ID4gPiA+IHVzZQ0KPiA+ID4gPiBpbiBtb3JlDQo+ID4gPiA+ICAgIHRoYW4g
MzIgbW9kcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEhpLA0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBz
ZXJpZXMgYWRkIHN1cHBvcnQgZm9yIE1UODE5NSdzIHR3byBWUFBTWVMoVmlkZW8gUHJvY2Vzc29y
DQo+ID4gPiA+IFBpcGUgU3Vic3lzdGVtKSwNCj4gPiA+ID4gdW5kZXIgd2hpY2ggdGhlcmUgd2ls
bCBiZSBjb3JyZXNwb25kaW5nIE1NU1lTIGFuZCBNVVRFWA0KPiA+ID4gPiBzZXR0aW5ncw0KPiA+
ID4gPiB0aGF0DQo+ID4gPiA+IG5lZWQgdG8gYmUgY29uZmlndXJlZC4NCj4gPiA+ID4gDQo+ID4g
PiA+IE1vdWR5IEhvICgyKToNCj4gPiA+ID4gICAgZHQtYmluZGluZ3M6IGFybTogbWVkaWF0ZWs6
IG1tc3lzOiBBZGQgc3VwcG9ydCBmb3IgTVQ4MTk1DQo+ID4gPiA+IFZQUFNZUw0KPiA+ID4gPiAg
ICBhcm02NDogZHRzOiBtZWRpYXRlazogbXQ4MTk1OiBhZGQgTVVURVggY29uZmlndXJhdGlvbiBm
b3INCj4gPiA+ID4gVlBQU1lTDQo+ID4gPiA+IA0KPiA+ID4gPiBSb3ktQ1cuWWVoICg2KToNCj4g
PiA+ID4gICAgZHQtYmluZGluZ3M6IHNvYzogbWVkaWF0ZWs6IEFkZCBzdXBwb3J0IGZvciBNVDgx
OTUgVlBQU1lTDQo+ID4gPiA+ICAgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBtdDgxOTU6IGFkZCBN
TVNZUyBjb25maWd1cmF0aW9uIGZvcg0KPiA+ID4gPiBWUFBTWVMNCj4gPiA+ID4gICAgc29jOiBt
ZWRpYXRlazogbW1zeXM6IGFkZCBzdXBwb3J0IGZvciBNVDgxOTUgVlBQU1lTDQo+ID4gPiA+ICAg
IHNvYzogbWVkaWF0ZWs6IG1tc3lzOiBhZGQgY29uZmlnIGFwaSBmb3IgUlNaIHN3aXRjaGluZyBh
bmQNCj4gPiA+ID4gRENNDQo+ID4gPiA+ICAgIHNvYzogbWVkaWF0ZWs6IG11dGV4OiBBZGQgbXRr
X211dGV4X3NldF9tb2Qgc3VwcG9ydCB0byBzZXQNCj4gPiA+ID4gTU9EMQ0KPiA+ID4gPiAgICBz
b2M6IG1lZGlhdGVrOiBtdXRleDogc3VwcG9ydCBNVDgxOTUgVlBQU1lTDQo+ID4gPiA+IA0KPiA+
ID4gPiAgIC4uLi9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtbCB8ICAg
NSArLQ0KPiA+ID4gPiAgIC4uLi9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWssbXV0ZXgu
eWFtbCB8ICAgMSArDQo+ID4gPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
OTUuZHRzaSAgICAgIHwgIDI4ICsrKy0NCj4gPiA+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dDgxOTUtbW1zeXMuaCAgICAgICAgICAgfCAgMTMgKysNCj4gPiA+ID4gICBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstbW1zeXMuYyAgICAgICAgICAgICAgfCAgNjQgKysrKysrKysrDQo+ID4gPiA+
ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmggICAgICAgICAgICAgIHwgICAxICsN
Cj4gPiA+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbXV0ZXguYyAgICAgICAgICAgICAg
fCAxMzUNCj4gPiA+ID4gKysrKysrKysrKysrKysrKystDQo+ID4gPiA+ICAgaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmggICAgICAgIHwgICA0ICsNCj4gPiA+ID4gICBpbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbXV0ZXguaCAgICAgICAgfCAgMzUgKysrKysNCj4g
PiA+ID4gICA5IGZpbGVzIGNoYW5nZWQsIDI3NCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMo
LSkNCj4gPiA+ID4gDQo=
