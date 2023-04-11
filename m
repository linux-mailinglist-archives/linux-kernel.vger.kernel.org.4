Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4F6DD2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDKG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDKG0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:26:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA9B273D;
        Mon, 10 Apr 2023 23:25:56 -0700 (PDT)
X-UUID: b4a6ab6ed83111eda9a90f0bb45854f4-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FriMa5Rt6s794p0SVZiPsmdq/29JCvPiV6rfHGxvge4=;
        b=eLuBjac1T0eeNjP0lskRThzb4A3YvtLZ/K6uebHMjzxw8SNluaAtw2GVmUup/4JD+0PrK83gS+JcNhJEJRD5qPsolwISKuxhLpCDe2I1eAVxZ+zMLH45qODiVUZgJzMECr+JLPmnWS8sdTukizEA1QRi4RvpdjsphmqfvICqsfk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:6f0317fe-3d11-4151-b3da-7fd95cc9b240,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.22,REQID:6f0317fe-3d11-4151-b3da-7fd95cc9b240,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:120426c,CLOUDID:44e78dea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230411142553VCX46PUU,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b4a6ab6ed83111eda9a90f0bb45854f4-20230411
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 671321894; Tue, 11 Apr 2023 14:25:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 14:25:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 14:25:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blDb3c2Ayu8NCpTjt8d+BJrwZhTy9Kz/ZsDnFYo0LingJDTZuFadOcTNkc02woipev1WER6V/HbMNK4ATjIcM0uK5DgeoC7ITHsVpI2f7KIEeNTej6A4lrsw6chbTrQmk2pf+njbfALey47b8XzynODiE3ah3I/5tjJs6Uv2AGHFOxHanMhBYQ1Db7otuclarNo8usyvsUQZCdsUOcWswD42cCvsz06TTmrCMexKeGHq7NZ2UxkxMKqYJpmsYmvJ+yP7ClSD1pmlbuMw0Ad0hiVBNN+xA3/yqZxJ4mhUEoLSj2MQXi/RJDNN0fSVcBaMWWp4h1OZRydza/BczutmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FriMa5Rt6s794p0SVZiPsmdq/29JCvPiV6rfHGxvge4=;
 b=UsdNuhpiZjkcqY6TtzrKDVSgC53UTz3z5pD9nmvOIE8q6O9KjccuQMVEcDjlRbY5qWNeeYdwZdPbGK05Rr5Q1EX6ce2ewDv2LKMSdjFxrng+RyrzdiyZi6Pvh1/Id1l7FwHGivqi8REat3ehYEVvrBSULLODQoSjSNxCj9eNDx1kr/iaLZYLT7UnDBhTRkmcqOmA9kMqtbode7w7/lrqmDbXt37hGbswOCK5+GH+HUCShT1BujZrYT/N9GM0aTrnYCeijgd6g8wF7JpIdh+1URcqdaRSAEDaIBNufeVyppoZv/4DKlybmJklO23+ODNalwH27jc0/CXP+bqClQYplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FriMa5Rt6s794p0SVZiPsmdq/29JCvPiV6rfHGxvge4=;
 b=g9LsIMTg3qIjB+rlu71UMjzv1PD+EI8T4oo6ABxarE0Rg5SKA7UZ+X3WLBaYQO3t5oRr5NAratUhjHhqZdQhbKoHps7JAwvV5rimGTCXFUxkJyu0NmGPey5bwOy1ygKEU0gpqAMrevr7M277Hi4rryV3888oTWTVh9auE6cXj8E=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5312.apcprd03.prod.outlook.com (2603:1096:405:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 06:25:48 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 06:25:47 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2, 0/2] fix coverity issues in encoder driver
Thread-Topic: [PATCH v2, 0/2] fix coverity issues in encoder driver
Thread-Index: AQHZbDoPsjUotRwqg0ah2J1AJmIqIq8lpHIA
Date:   Tue, 11 Apr 2023 06:25:47 +0000
Message-ID: <ce38578f6be4a6247ea2370e2e93a9200c02778a.camel@mediatek.com>
References: <20230411055413.539-1-irui.wang@mediatek.com>
In-Reply-To: <20230411055413.539-1-irui.wang@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5312:EE_
x-ms-office365-filtering-correlation-id: 2ec8092c-1c84-4a42-c4ea-08db3a559696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b1ZxIeStzZSJeFAD7OM4wVZBHZDNdRKVYyYDjvs0/k3XduZKstQJgmMZ/18LogjUdgugE6dUUi5/4gWdfkF1plpzCDIrP6J3HJn5ewFBrSPci7V3T5yPHEL7QIqqxFaxmgInoxMeFFNvQA3O7qQ0TDCAnVMPniy1iWWGR4kGiDUX+y+kG1fpOVkGM67GOWEAVAorFxJLYoWYVgEZERGXi11SkpUjJQfnTBWcpaqCdFoTcPuJcKukUm7xoJTO1H8yaMzjnh7SBIQgf2YOhGexuVtrKiCy4d5LuXqY8Wzogou1PwesVgYy5QvFnxaxosQXBL4qr3+WXnE1iYnv2REYFhzINFU3FEsggeNIvi3fqe3uy5q2CDlDTUWO39RYs5HWAfaCzd2KN3nMR083vIa8uBm2O0U5/q5na2gOODQRwy8xJgXTuk0isFTFihmmcCFNAjntguF/DJKTLJ0oCXzh9gZBwMr4/a2ncP1I9vRb84wgGQaLJm8vww2ZYDgQDISG8KJndoUq3wJrgt7FB8eGv67GkhVy3RkIXypjoMRrOFz//d1qmN7rBMVyo6MG6djd7Ryxdody0ooNcTaHQ0fSfFD/AJjgu6CXGyxrqMIn9A6V3/nWeRwB9ViTL6rPHyE/gOlTb3KStpAQYXbu32aLhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(71200400001)(478600001)(6512007)(316002)(110136005)(26005)(6506007)(186003)(54906003)(6486002)(91956017)(2906002)(4744005)(5660300002)(4326008)(66946007)(76116006)(107886003)(66446008)(41300700001)(8676002)(66476007)(64756008)(8936002)(66556008)(38100700002)(38070700005)(122000001)(86362001)(83380400001)(85182001)(36756003)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEVkNDBNV2pOYWFVZVo4Z0loOXNkQzZzcEF1eUJJWVlBa2h3UFR4MDJKcldO?=
 =?utf-8?B?RGdIcThpYktGQU50NGFlRGtUYythNlhPNmZpQS9sYnFJUTdBVUdiZVVmQnNm?=
 =?utf-8?B?NjYzWktxdXVqU0ZGSmViS1B2L1VXOUhsZzJRV0F3V0gzWFpDTXlPV2VjZERw?=
 =?utf-8?B?SVlNWElxeGZuclJpbTFyai9QVWVBY1AzMFgzbGdqekp2dk9pN1FDdERlUG1R?=
 =?utf-8?B?bCtqZ0dVYnV0YTRpWGl6WkkrZWJpd0owL0lhZkd1bVpPL0d1emg2OXhFUlF4?=
 =?utf-8?B?eXA3UzBQdXVsV0FvN0FBaHpVVHovYmFnOHh1MVZhUzg2aXBVOEorQTBRM2xS?=
 =?utf-8?B?K1NMV1kxVEtINXFBMWcxTFRxN2hnaTIvc2t5dFp6RFNhWHBPeDdXaGkvdkxU?=
 =?utf-8?B?OWwzVk15NmZjQ1A0VnhlMjRCK1luZDh2UkJIT2N0eXNZc1IwUFU1SWdTaDhJ?=
 =?utf-8?B?QkxmZCtnZENoMXhkeTdMNFp1VFZPRlpyZjZPdzdtV1ljck5QVmtkUUhiMk9V?=
 =?utf-8?B?NDdpbFEyc2VsNThpOVlHbHFZNE5nMCtBZWZQNzFXTWtwK0VRNXBhbFpta2tm?=
 =?utf-8?B?elpTMG1Mc1YxZWhoUnRaTjRFY1c0b0xFTDFtL3ZRWXpPVDd2dVJhK3NUaVJF?=
 =?utf-8?B?OS9NS1lwYktrRXFHVE4reXVWZzBUZHZjUkVUY250MzJpQTlOY043dWt2dUYv?=
 =?utf-8?B?RDFLQUJGTkY0N1RHakg0SHdBYXUyVStVcExSZnZpajdaNFVxc2ZsUFg1Nzlm?=
 =?utf-8?B?OTFHSisvUlgzVVlzdGNMeXJaV3ZJQ0pLTWRPbWkrSllhdkhaUnM4RkJqZDBn?=
 =?utf-8?B?YjhvK2pGRVdpaWdwZ1VlTFVXV1dEWDhWRC9UQjc3a2FjQWE3UzZzV0RFS1dD?=
 =?utf-8?B?SmVUSmkzNG80d203MWJieU5FWjN1ZFRtU1FENjBlWkdZWHM1UGh5RWpxZTdw?=
 =?utf-8?B?MjRsOG1TZ1VhOE5JS0dmd085bHJubGFSWlFoNHVBaVY4WHljSlJFczBFUVJM?=
 =?utf-8?B?VkJPc05rR3lnNTR5OHlxYWQrVGprcnl2V2lPY3JtYnRWbDdvVVdML2FwaW1G?=
 =?utf-8?B?eU45Q09QdkdhNzNBUTJGS0p2UlA5TDh4aFpGalJ3RklBM2VWVDN5OEJRMC9V?=
 =?utf-8?B?SXhzVytnOU9BRXc1ZDE0bVEzc0lndkx1alBHYXBtdWhCZ29kMlJkakhuZjY0?=
 =?utf-8?B?TFRLWEh2d2s5dlVrU0owSzVxdWM3Q2NXcEdvV3R3WmFkQnlrWlVUUFQ5cWIr?=
 =?utf-8?B?R1lrV0hFQ25rSVQxbE5YNndEZk0yNkRqN09WQjBINnZZWWJiWjFkcGoxMzZm?=
 =?utf-8?B?QmpuRnVBZHd2OSs4WmFiZHZPQjJIWTVhNU9SaHJIYkFDNTRBV2M1Mjl6aGNu?=
 =?utf-8?B?Mlh4MXZDcWpSY2dvTjNsK0ZtRmcvWGMra25mUW9YUmQwVFpQeHYzV2kzSElj?=
 =?utf-8?B?aTFlTEpvSEhxY2tCTlpxM2R5Nm5BUThLdlBQb016MlNMRGNkaHRUSEJWVDJt?=
 =?utf-8?B?bVJaa29oN3gzYkVzOG5kRXM4emxjN2o2TGtmODdocEFDcVVCYUwwZDBtRFQw?=
 =?utf-8?B?cHFlaEtVUjFzVk1SRnkvM3ZPMTVBeXN3aW8zTEFtd3dyNE41RnhGRUpYUU1V?=
 =?utf-8?B?RlYzc0RlVDI2TzRQTHh5eU93QjJCalBZSHB6RUNHR3ptUEVLTDV3VHpvcEpK?=
 =?utf-8?B?N21Id0tLcjArdXF5M1VNbVRqUFJpZ3VFRDUwUXU1SExyTk04OW94SDBKL2ZV?=
 =?utf-8?B?clU2RUJNNlRyZU5jUGxTNDh2NHNIZmRDNGRKQ0tvTmxBRmNYRUM4aVdKZWZi?=
 =?utf-8?B?amxkcVFJWHptSXZoSkk1bEdDTm9GV1dBRThSdUNlT1NRUGRIelZGOWdnY2ZU?=
 =?utf-8?B?b1k3eGt5YVRENTl2cHlUSTVwelBmTHJCSUZEWURrT25JeEdwd1RKMW9JYlFE?=
 =?utf-8?B?clh5eXBZL0pydEs1b2VlWGgzMDdZdUcyT0phU3VScnYxUy9jc1hkUUpNRWVo?=
 =?utf-8?B?K2s5TXZsZ2pFcWkvN0czdEQ5ejVncFdGeWJDVlR1VXhENFpGRC8rVjhvZUFZ?=
 =?utf-8?B?dWR6d0Y2a3dyNlk4RzNielRVNEFrOW1raWE4VkFMbmx0a1ZkeHVIUWdITXJj?=
 =?utf-8?B?MW5MUFFtLzJXd01oaERDc3dvUzBpa1BaS2tZd3RYSjVxR1JZOENYYUcwNVBU?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B9FB35986EE404DBA873693357B5FCB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec8092c-1c84-4a42-c4ea-08db3a559696
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 06:25:47.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+wC4KzwSK5+c7tL8aW/lnGCl6fxi/3DxCeVvb5/Upy6FafYad7Lg+PmsqIwe9Hp32oTKmcFC/SqP+G7st1mbn3jbtKmM4NCUHOmPA/ZQHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5312
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSXJ1aSwNCg0KT24gVHVlLCAyMDIzLTA0LTExIGF0IDEzOjU0ICswODAwLCBJcnVpIFdhbmcg
d3JvdGU6DQo+IHR3byBjb3Zlcml0eSBpc3N1ZXMgaW4gZW5jb2RlciBkcml2ZXIsIHN1Ym1pdCB0
d28gY2hhbmdlcyBmb3IgZml4DQo+IHRoZW0uDQo+IA0KTWF5YmUgYmV0dGVyOg0KDQpTdWJtaXQg
dHdvIGNoYW5nZXMgdG8gZml4IHR3byBraW5kIG9mIGNvdmVyaXR5IGlzc3VlcyBpbiBlbmNvZGVy
DQpkcml2ZXIuDQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo+IGNoYW5nZXMgY29tcGFy
ZWQgd2l0aCB2MToNCj4gLSBzZXBhcmF0ZSBpbnRvIHR3byBjaGFuZ2VzLg0KPiAtLS0NCj4gDQo+
IElydWkgV2FuZyAoMik6DQo+ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IG1ha2Ugc3VyZSBh
cnJheSBpbmRleCBpcyBpbiB2YWxpZCByYW5nZQ0KPiAgIG1lZGlhOiBtZWRpYXRlazogdmNvZGVj
OiBtYWtlIHN1cmUgcG9pbnRlciBpc24ndCBOVUxMIGJlZm9yZSB1c2VkDQo+IA0KPiAgLi4uL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2VuYy5jICAgIHwgIDIgKy0NCj4gIC4u
Li9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19lbmNfZHJ2LmMgICAgICAgICB8IDE2ICsrKysr
KysrKysrKw0KPiAtLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0K
