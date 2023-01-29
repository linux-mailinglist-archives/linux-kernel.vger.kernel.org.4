Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0383867FC0B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjA2BMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjA2BL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:11:57 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9C422784;
        Sat, 28 Jan 2023 17:11:52 -0800 (PST)
X-UUID: e6ee4f309f7111eda06fc9ecc4dadd91-20230129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/ASAMHQY/lD893pG4ZRtfBX9gSKJABA5HXTF9zvh7sM=;
        b=L2EL9EStOh3u/YygCTBaAtv0++LDi+7nBs9pw4WGKY9XCAEJqFhb3ikqTRO+aBdCqMRyFxI1qEgtA87K06kqjD9iMsCBPHVLV5cPOY1lF42XvnoEAcQmkR5y2TTyolYlkIHxjFB81RDErUH3jql4go1WUxhsC834W+0RWwXQscs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:13a0a2d2-fbc7-4d3c-9905-6ca806d2607d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:2f14caf6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: e6ee4f309f7111eda06fc9ecc4dadd91-20230129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1893816610; Sun, 29 Jan 2023 09:11:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 29 Jan 2023 09:11:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 29 Jan 2023 09:11:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENRq9rt4rzOx3/K5iDpQCicipKJPmcCTy3pcxuhCYcjKlgaiWRMg48QpXphz1adKHRPApNNLjgza+daBzAke3bd2N+/Sh2iS672rjkio8Fh7WMWAcftFiaur/F74x7Tw19YEowHhpQblmoy5raP2ehDX844TbvmehZr/y2Nuy/nYjUzzddhIq5OJA1P3WFdTzZQ1+VLvSe2jrIAu7hYfA+WQCvk52klFvY5VnPGw6noEA1v2tzDZjU8NxEtT/2iv33CcSHfNAdnl6A6NueDC7veJ78bcMahNer2OA/xprzx+hhnIqAfIDJYitCgJotxl4BVfZiFKn/WqzUMP7RekoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ASAMHQY/lD893pG4ZRtfBX9gSKJABA5HXTF9zvh7sM=;
 b=NI1f0/F/rTTgJCYWCN6OCsL5X78I6k/G6A3zVaFewRuL8w8hiH1Geobm9jupNxc01CTE/yYXdVS3nI4jKU+m3EcZ8eRCLVeVlqDhPWvrOgUekR25GzDUUKqsAjX+6MGIfdP4oLO1+PhhkJT5Lu7GJWDhkXgy2X+YFs+wvbMmZH4UrAPiPRQ1W6nYhz2npIyIvEvDnU1DTbAMT0JfTyEUbKKSZsOWkDw+P5FPHJA4KGooWWFB1SvpnUJdi5Jn9NdQUsX+LRr5YodMLAzqUt+YCp3yOvUdXkZGXYKBr5Fr56hSRBAledOYG7vIoMP0EryvV51x0nQ1/30fzWVNKByMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ASAMHQY/lD893pG4ZRtfBX9gSKJABA5HXTF9zvh7sM=;
 b=cs9YhPXU4gvEr3nTq97dziDi7aovmxsYeE1aSVqQxbxoISrrvTxDvJ58QATGZG0KNK3rxE+2H2kngJtj0v5GEEHRSDN0TIcFhZ9ddNij/Uyc8oyEFOaj2rkdFfFBMnvREf86mj3KOhsq0omhAmurbMyvW3O/bTYhUy/zeqCOTkE=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by SI2PR03MB5676.apcprd03.prod.outlook.com (2603:1096:4:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.31; Sun, 29 Jan
 2023 01:11:42 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd%9]) with mapi id 15.20.6043.033; Sun, 29 Jan 2023
 01:11:41 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
Subject: Re: [V4] media: mtk-jpeg: Fixes jpeghw multi-core judgement
Thread-Topic: [V4] media: mtk-jpeg: Fixes jpeghw multi-core judgement
Thread-Index: AQHZHyWHfp0ZNkqxfUKpjian+v//Pq6yL9AAgAKPLIA=
Date:   Sun, 29 Jan 2023 01:11:41 +0000
Message-ID: <8a91e5e6108741a7d6fc022178c6f5f94f6c30db.camel@mediatek.com>
References: <20230103034213.18573-1-irui.wang@mediatek.com>
         <47840969-364e-e5a2-d78b-967542a78eb6@xs4all.nl>
In-Reply-To: <47840969-364e-e5a2-d78b-967542a78eb6@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|SI2PR03MB5676:EE_
x-ms-office365-filtering-correlation-id: 9c2014c1-a6ca-49cc-39c2-08db0195c78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMZm/8row3RnMN1AQtfUF0aewLpis0s3aXUaorWflNJtpWUomPsDGKCzPK0a0vXSEhl8X4OmIW9LftRHB2ocSQ+VnmuzVhw1w4E55Wq3fk/C0z0euf3uJF3tzQIYWnK0D7tQHlJ3IOILQil+zFtdLAU2bcO8mN9PiAfBsugI//2CpvN/X2lqfj28b6Wh0fuotqPc+YkdC0+KyvM4v5SpqBuNBQwbGWnQrWFJgk7tGC9r4QlWh9tBg0sE+sKqlTcCbMPdM3Hsr0iAGl6VZ13blfIEsn2qS0cXQwVuxdzrlpR9emppTuTywd1G+AxTBAGvqZpYTdyE4CcoWKwWtmn5cbhIY03ls30D/PL5wftKy1KgnX0vMT7aR9nvkDZAbuhhuytHqcYThk7iIswk2vav2i+ea9277PMmSMBvMVfSNaS+E5fwqplUiZHXtDV/Lxg/P+wFqN3D9RQEZ2cIc7dKQPYsdqjanGFh0smZnWBDC1Xyxz6fIVe+vvNp2IqwHgX0ob4lCcYkLE/U40ue4xJLogoyCLTgP0vRtAjSnDeaqcP8zaVK5zvswgWXaG3mwrtfbCeu68rhYEtJ9Yw9cz+GCJ6Fi5Ck0HxRKxtESMWyAKBqznrEMEJocqjrlfxm19K2ViMF7i8gNBzB0RnEbMdsLmRGTjeh9Klo0GhfOPBHNznCnNFzUi0RKikdacW82BIh4DZxD/XyixfoJJSDLoYM5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(8936002)(41300700001)(86362001)(2616005)(83380400001)(38100700002)(122000001)(38070700005)(316002)(8676002)(85182001)(110136005)(54906003)(36756003)(4326008)(66476007)(66446008)(64756008)(66556008)(76116006)(66946007)(6506007)(53546011)(107886003)(91956017)(6512007)(26005)(186003)(71200400001)(6486002)(478600001)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blFZTkhNVmNoT3pRaEJiQ2xHQWJkSHZxVnZsK2puaXlFOHJVYXE2RzUxeDd6?=
 =?utf-8?B?OEdWR3R6aTdtYVE4Q2RaYVo2REFhdDZoV1NnYjVxVERKVmpOWHVqR2tWelVM?=
 =?utf-8?B?QVVXZmluVm0zU3RlUDc5ckVyQktKYjR6c21TeWViRzROT2lYQm9ZQnRsTUkv?=
 =?utf-8?B?OVZQV2VqSlhRUkNZbFdsWTRwREpEZjFWRWdWUUEzZFl4MDNVTzZFNVZXbi93?=
 =?utf-8?B?TDFMZ1ZSKzRidmZzYnoyZmw5UTJyMUJyWW9uNWhUTFNnUHhMNUZUcG5kOURV?=
 =?utf-8?B?d1hCRWRFK1ppdkhQdzFlSmhFMHhIbU41UWN4NjRMOUcrYjRiV1FBdHJHdG8r?=
 =?utf-8?B?dkVrZ1htTys4ZnZackpoNXF0K3VkakZSOWRvNC8zTFFKRC9acDV5QnVNbk9C?=
 =?utf-8?B?UHFqU2xpbzRIb2ZIUlFtRjdNYUNVaWlEWU1sanpOZEhPVkFKYndpeGJQVVdN?=
 =?utf-8?B?eTlQcWROalMvbFVibStnZzFyTG1GM0QreXhwVk1xYnowUnptcU5wL0JWcW00?=
 =?utf-8?B?aWthYW55RXJIclFjT1FHT1dLdFJGNUx0M1FTUUxTaEpnZFVVa21zMlBpYXVW?=
 =?utf-8?B?cmo0VGI0b0dNNUhzblFEQjlWTFBGV29lcFpHS29SdlBrSFdBck0yZWdkZGF2?=
 =?utf-8?B?aTlyR0tBU1VqY3Y5SGtmbUxSdFlFaTFBK1ZDK1Vmdk1IVDYzRkFPYjNtRzJn?=
 =?utf-8?B?cnVmY21iQlVjZFExenYyMUYxeDcvVFB0RHVoN0dNeFFnV1RVaDl3RXpLWUE0?=
 =?utf-8?B?Zm5oTjFXSE1KdFJCOFN0VjJDV1BCQUNoL0tqY0UrRzJJaDdrZGQvSFRHSHRk?=
 =?utf-8?B?NmdzTm1QZzFrNTRNTGQrMmlYYzFQZnl0ZHd5OWdIY3A4dEZkRFFJN1crUkli?=
 =?utf-8?B?RUJIZFg5SmlQdzhBWGhUV3c4azFuRGxlcTROUVh2aTZwVGF4bG5LMi9WYUNK?=
 =?utf-8?B?T1I5U2hrZVdYMU9OREdHRmUxQ2ZaclNIL20yUTJsVWwzaFJNY1BpQnN4YXRh?=
 =?utf-8?B?bGFOUm91cjJuLzhaNEJYMFlUbHEvYWlxL1gwK2U3TGV2cWlIdjhPMVpBZm01?=
 =?utf-8?B?SC9abEU0OFRJWkM1VFZMZTB2Y3BMNkU4THcvelgyM0hXMSszWnVkQk1TQThP?=
 =?utf-8?B?K3lIRmNMY3VmVjIxeHlkUjNSUUo2K3hqcGhzeUZNRlJkbnhBdVJGTDFFdmNz?=
 =?utf-8?B?QmlsYld1a1JCamVhMXV2S3c2aC9nRzdKOGRVL2NWRk0rbDhweXBCa1laRm9v?=
 =?utf-8?B?M2g5MWZiSVoxZlV2aG9tRlRSU2FBcHgyL05mcTFlQ2hFTjNZTnpGQWd3VnJi?=
 =?utf-8?B?dWVKcnhJV1R5VDJlYkh3Q0xVdmtXRVVVcDhySElKdWw5OXRaaEhvdE9oVllB?=
 =?utf-8?B?SUhRYkQ3Rm5rTEpxYWIwSHlIN0J6dENMRWNsMDNaWnBqUlRpU1daL1ExSGNx?=
 =?utf-8?B?NjVDUC9yeEZGbW5sbC92QlVDZEJjd29KUkp2NkJrTVU5bThJc25MSENGZmMw?=
 =?utf-8?B?OXdkdWcxdERDTXVNWUhUd2k3THdGT3ZmcWlraWFud0dHemdac1B6VDNreDdP?=
 =?utf-8?B?R1NzNHlWeTJpeHhvd2tqUFRQOGFkMER4N29NK1paeE5qZXFNTGQ4Tll3OHJX?=
 =?utf-8?B?SC9wM2JSNEUyRk9RcXVidVlVK3lRSDRJWWVMTk1oWlN0MVRBQm92aE8yYU40?=
 =?utf-8?B?SzFDenZWaWVmNnRrc3d4U2lSenk5c2dwS09OMmwxTVpvMVNTN1drRHN2MVFh?=
 =?utf-8?B?MytEYXF4OGxlNmZEY29ZYVJ4ZkRaSDVoUUY4ZHEvNHRrWEc0TlN5eEhKZzdE?=
 =?utf-8?B?T01tT24rdmRtcUh5NitqdFB0ZEMxYXBBMk1UUmQrQ1FBRXRQT0xXRkp2a29J?=
 =?utf-8?B?WnFqczYyTzhmVE5sNjRkaExlYWFZN3hKUHpQYy91cnEwekw4WjhSbjJiOStL?=
 =?utf-8?B?M0t1b3VUTDNPcHUrOTJIak1ocFpVNGtlMWowMS94bG5DUlc4c1kvMmM5WlI0?=
 =?utf-8?B?VjNXNzhiSmhVVWJHVk1kS3FPS2I1ZXBEOFlTTkd6eU9jcFBUL3hFcGJVaU12?=
 =?utf-8?B?MnBUQmlUQjRXeGl6SWlPcjNGQW9yQStIQjNoeTlab1BjZ2FPSUVTSE9SNE40?=
 =?utf-8?B?Y0RPMzkzNk1FaVVlS0NTMVlENlorUTBUdWhVZXVtRWkrZGRsOW1lb05NWENJ?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75894E9AAB70AF4887315A8393F85962@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2014c1-a6ca-49cc-39c2-08db0195c78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 01:11:41.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5vIQt7YPidAtKtjuadJAcHbxIYbjbELvL32/oVqk1wDMcIpwUZW/Xl7MGLRQ1iC6peRi9Sz+9UAGdLicl/jCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTI3IGF0IDExOjA2ICswMTAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+
IEhpIElydWksIEt5cmllLA0KPiANCj4gT24gMDMvMDEvMjAyMyAwNDo0MiwgSXJ1aSBXYW5nIHdy
b3RlOg0KPiA+IEZyb206IGt5cmllIHd1IDxreXJpZS53dUBtZWRpYXRlay5jb20+DQo+ID4gDQo+
ID4gc29tZSBjaGlwcyBoYXZlIG11bHRpLWh3LCBidXQgb3RoZXJzIGhhdmUgb25seSBvbmUsDQo+
ID4gbW9kaWZ5IHRoZSBjb25kaXRpb24gb2YgbXVsdGktaHcganVkZ2VtZW50DQo+ID4gDQo+ID4g
Rml4ZXM6IDkzNGU4YmNjYWM5NSAoIm10ay1qcGVnZW5jOiBzdXBwb3J0IGpwZWdlbmMgbXVsdGkt
aGFyZHdhcmUiKQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IGt5cmllIHd1IDxreXJpZS53dUBt
ZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogaXJ1aSB3YW5nIDxpcnVpLndhbmdAbWVk
aWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5j
IHwgIDQgKysrLQ0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRr
X2pwZWdfY29yZS5oIHwgMTINCj4gPiArKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLmMNCj4g
PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLmMN
Cj4gPiBpbmRleCA5Njk1MTZhOTQwYmEuLjU2YjI3ZWNkNjFlYyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVnL210a19qcGVnX2NvcmUu
Yw0KPiA+IEBAIC0xNjkyLDcgKzE2OTIsNyBAQCBzdGF0aWMgaW50IG10a19qcGVnX3Byb2JlKHN0
cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlpZiAobGlzdF9lbXB0eSgmcGRldi0+ZGV2LmRldnJlc19o
ZWFkKSkgew0KPiA+ICsJaWYgKGpwZWctPnZhcmlhbnQtPmh3X2FyY2gpIHsNCj4gPiAgCQlJTklU
X0RFTEFZRURfV09SSygmanBlZy0+am9iX3RpbWVvdXRfd29yaywNCj4gPiAgCQkJCSAgbXRrX2pw
ZWdfam9iX3RpbWVvdXRfd29yayk7DQo+ID4gIA0KPiA+IEBAIC0xODg1LDYgKzE4ODUsNyBAQCBz
dGF0aWMgc3RydWN0IG10a19qcGVnX3ZhcmlhbnQNCj4gPiBtdGs4MTk1X2pwZWdlbmNfZHJ2ZGF0
YSA9IHsNCj4gPiAgCS5pb2N0bF9vcHMgPSAmbXRrX2pwZWdfZW5jX2lvY3RsX29wcywNCj4gPiAg
CS5vdXRfcV9kZWZhdWx0X2ZvdXJjYyA9IFY0TDJfUElYX0ZNVF9ZVVlWLA0KPiA+ICAJLmNhcF9x
X2RlZmF1bHRfZm91cmNjID0gVjRMMl9QSVhfRk1UX0pQRUcsDQo+ID4gKwkuaHdfYXJjaCA9IE1U
S19KUEVHX0hXX01VTFRJX0NPUkUsDQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19qcGVnX3ZhcmlhbnQgbXRrODE5NV9qcGVnZGVjX2RydmRhdGEgPSB7DQo+ID4g
QEAgLTE4OTYsNiArMTg5Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2pwZWdfdmFyaWFu
dA0KPiA+IG10azgxOTVfanBlZ2RlY19kcnZkYXRhID0gew0KPiA+ICAJLmlvY3RsX29wcyA9ICZt
dGtfanBlZ19kZWNfaW9jdGxfb3BzLA0KPiA+ICAJLm91dF9xX2RlZmF1bHRfZm91cmNjID0gVjRM
Ml9QSVhfRk1UX0pQRUcsDQo+ID4gIAkuY2FwX3FfZGVmYXVsdF9mb3VyY2MgPSBWNEwyX1BJWF9G
TVRfWVVWNDIwTSwNCj4gPiArCS5od19hcmNoID0gTVRLX0pQRUdfSFdfTVVMVElfQ09SRSwNCj4g
PiAgfTsNCj4gDQo+IFNvIHByZXN1bWFibHkgdGhlIG10azgxOTUgaXMgbXVsdGkgY29yZSBhbmQg
dGhlIG90aGVyIHZhcmlhbnRzIGFyZQ0KPiBzaW5nbGUgY29yZSwgYnV0Li4uDQo+IA0KPiA+ICAN
Cj4gPiAgI2lmIGRlZmluZWQoQ09ORklHX09GKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5oDQo+ID4gYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5oDQo+ID4gaW5kZXgg
YjkxMjY0NzZiZThmLi5lYWQ0N2UxMWRkNDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVnL210a19qcGVnX2NvcmUuaA0KPiA+ICsrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLmgNCj4gPiBAQCAt
NDYsNiArNDYsMTYgQEAgZW51bSBtdGtfanBlZ19jdHhfc3RhdGUgew0KPiA+ICAJTVRLX0pQRUdf
U09VUkNFX0NIQU5HRSwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gKy8qKg0KPiA+ICsgKiBlbnVtIG10
a19qcGVnX2h3X2FyY2ggLSBhcmNoIG9mIHRoZSBqcGVnIGh3DQo+ID4gKyAqIEBNVEtfSlBFR19I
V19NVUxUSV9DT1JFOglqcGVnIGh3IGlzIG1sdXRpLWNvcmUNCj4gDQo+IG1sdXRpIC0+IG11bHRp
DQo+IA0KPiA+ICsgKiBATVRLX0pQRUdfSFdfU0lOR0xFX0NPUkU6CWpwZWcgaHcgaXMgc2luZ2xl
IGNvcmUNCj4gPiArICovDQo+ID4gK2VudW0gbXRrX2pwZWdfaHdfYXJjaCB7DQo+ID4gKwlNVEtf
SlBFR19IV19NVUxUSV9DT1JFID0gMCwNCj4gDQo+IC4uLnRoaXMgaGFzIHZhbHVlIDAsIHNvIG11
bHRpIGNvcmUgaXMgdGhlIGRlZmF1bHQuIFRoaXMgbWVhbnMgdGhhdA0KPiBhbGwgdmFyaWFudHMg
YXJlDQo+IHNlZW4gYXMgbXVsdGkgY29yZS4NCkRlYXIgSGFucywNCg0KVGhhbmtzIGZvciB5b3Vy
IHJlbWluZGluZywgSSB3aWxsIGZpeCB0aGlzIHByb2JsZW0uDQoNCj4gDQo+ID4gKwlNVEtfSlBF
R19IV19TSU5HTEVfQ09SRSA9IDEsDQo+ID4gK307DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICog
c3RydWN0IG10a19qcGVnX3ZhcmlhbnQgLSBtdGsganBlZyBkcml2ZXIgdmFyaWFudA0KPiA+ICAg
KiBAY2xrczoJCQljbG9jayBuYW1lcw0KPiA+IEBAIC02MCw2ICs3MCw3IEBAIGVudW0gbXRrX2pw
ZWdfY3R4X3N0YXRlIHsNCj4gPiAgICogQGlvY3RsX29wczoJCQl0aGUgY2FsbGJhY2sgb2YganBl
Zw0KPiA+IHY0bDJfaW9jdGxfb3BzDQo+ID4gICAqIEBvdXRfcV9kZWZhdWx0X2ZvdXJjYzoJb3V0
cHV0IHF1ZXVlIGRlZmF1bHQgZm91cmNjDQo+ID4gICAqIEBjYXBfcV9kZWZhdWx0X2ZvdXJjYzoJ
Y2FwdHVyZSBxdWV1ZSBkZWZhdWx0IGZvdXJjYw0KPiA+ICsgKiBAaHdfYXJjaDogICAgICAgICAg
ICBtYXJrIGpwZWcgaHcgYXJjaA0KPiANCj4gSSB0aGluayB0aGlzIGlzIGEgcG9vcmx5IGNob3Nl
biBuYW1lOiB3b3VsZG4ndCBpdCBiZSBiZXR0ZXINCj4gdG8ganVzdCBtYWtlIHRoaXMgYSAnYm9v
bCBtdWx0aV9jb3JlOyc/DQpUaGFua3MsIEkgd291bGQgY2hhbmdlIHRoZSBjaG9vc2luZy4NCg0K
UmVnYXJkcywNCkt5cmllLg0KPiANCj4gPiAgICovDQo+ID4gIHN0cnVjdCBtdGtfanBlZ192YXJp
YW50IHsNCj4gPiAgCXN0cnVjdCBjbGtfYnVsa19kYXRhICpjbGtzOw0KPiA+IEBAIC03NCw2ICs4
NSw3IEBAIHN0cnVjdCBtdGtfanBlZ192YXJpYW50IHsNCj4gPiAgCWNvbnN0IHN0cnVjdCB2NGwy
X2lvY3RsX29wcyAqaW9jdGxfb3BzOw0KPiA+ICAJdTMyIG91dF9xX2RlZmF1bHRfZm91cmNjOw0K
PiA+ICAJdTMyIGNhcF9xX2RlZmF1bHRfZm91cmNjOw0KPiA+ICsJZW51bSBtdGtfanBlZ19od19h
cmNoIGh3X2FyY2g7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdHJ1Y3QgbXRrX2pwZWdfc3JjX2J1
ZiB7DQo+IA0KPiBJbiBhbnkgY2FzZSwgdGhpcyBwYXRjaCBkb2Vzbid0IGxvb2sgcmlnaHQuDQo+
IA0KPiBSZWdhcmRzLA0KPiANCj4gCUhhbnMNCg==
