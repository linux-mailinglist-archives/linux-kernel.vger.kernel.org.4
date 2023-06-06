Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A272348B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjFFBdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFFBdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:33:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474D8F;
        Mon,  5 Jun 2023 18:33:42 -0700 (PDT)
X-UUID: 27d5fcbc040a11eeb20a276fd37b9834-20230606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+D6/H4rLOKfQSuFRxLN/u0Z+9UAYJMMD3vGkL9nqvkI=;
        b=ddSUvbyesv+qH3YnNHlqqmWEFl9/r+BUcL5N1HcZJrG0HhuVqMq670dQBHa6G8wFaNNWS6NG/i3Yg7A4QYhya5CXfWb8iGdAAuUemFxYNUl8PjTlhpVvF/TPKSkO+flmks4XKI6fNZktD8PdKZqGinxmR1q1taPqGSKo5LA0CqE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:b5440c81-3d1e-4dcd-8355-97c2141421d3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.25,REQID:b5440c81-3d1e-4dcd-8355-97c2141421d3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:d5b0ae3,CLOUDID:cda4aa3d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230605212233LMPA4YL0,BulkQuantity:25,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 27d5fcbc040a11eeb20a276fd37b9834-20230606
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 644183639; Tue, 06 Jun 2023 09:33:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 09:33:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 09:33:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1qRNuuFrDNWAEKSGZ4nt4kvLsxuOYWW/3cziuFgdG/M9j6tqH5tUfe1VqbZXTRHGHIkXWHhNxvJhGR5oreUppr9JtbelPsXhzG1kWr0lIZpnEqYd9kcFkxCfzfoAH5Gbn7/S7vjFYCg047oI3gZHhudkzuNHbea4kCFP03rGE96qVA5Ms6cm46t0Fr44EzFCo8xvKKKQw0NBQGole2NnXAeLIUuWOhtMkZ5rooxCLfdnYZ7TgmeSrqjjMwK/egdDl6XA4XKLpMWMrhTKZm/c+v6cFar2v3Vr+m5lO+hN3lDhJQkIl7bYC6c4fPMhqUJ8Sv0xGE7TC14gFlGMZNaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D6/H4rLOKfQSuFRxLN/u0Z+9UAYJMMD3vGkL9nqvkI=;
 b=g7S/MsYp8SrNlTChi2MRvRMKd6+tPeEFJ3hYsdHG4uJ/d8Qnr9GoNj8kABoKbAc1nL6Drph5noLTu2+ulakskqQLqz7mlBBwwkQdi4BEftNVlUgeMQ+8bcMZxwd3fIQEkIHGSzA//A4lhQlYFqyw7QCgoZOp+p5/nZ+tk3DvAe9Ae8/wRu/MtRDhZcQyOdon0PcqEzew+alxUW9x8YINqt7fmAz0Hxr3xM6EF0bg/yP/RrW+HjcJ4D6HejWX7usLhJnJsJyjW2oL6nn9BhL/pNa3PpfQtxexfzKzPclU0n+gsRQPAr97YC+OBcFgYvpAJJTAYPF9M0w4DUh080H9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D6/H4rLOKfQSuFRxLN/u0Z+9UAYJMMD3vGkL9nqvkI=;
 b=chP9eR4G4wf1qBFItTkmb9rKCTKl+vQ/v3JasSDSSOjcfBo4+zzL+EP/aFDnEOyGk0intUJMXdMpy6hGmhhk1n8wkVFoYVzqyJzuGO6kOcaZYU6cH5xOPVa//slMh7IDNmJ+9NhKcpFRsKlejyytzcecchCHZ+f3Oh7LRhlOZ5Q=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by SEYPR03MB7296.apcprd03.prod.outlook.com (2603:1096:101:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 01:33:32 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 01:33:32 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZl6dRPPunsFP83kqJ9kXlEUngRq98ON6AgADFoIA=
Date:   Tue, 6 Jun 2023 01:33:31 +0000
Message-ID: <e88977a984d8ebf8eab8947d6a9308c7f2f3a533.camel@mediatek.com>
References: <20230605121442.23622-1-wenbin.mei@mediatek.com>
         <0e7cc4cf-68da-207d-03b5-f9bd065f7940@baylibre.com>
In-Reply-To: <0e7cc4cf-68da-207d-03b5-f9bd065f7940@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|SEYPR03MB7296:EE_
x-ms-office365-filtering-correlation-id: e73535a3-635d-4f84-fe96-08db662e09b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7ngBowE+ZzUgVZl3bzckjlk1o21L1NYa7dHVTMOP6G/00cyXeBlCeUyWHLB355Zmv++g2H9LKHaSLXg/kiZ7cnI3Uyip0730xAv7VjjTqD4vNEvJCx5jBbZAA6F7LDOcEylLl9IUJgyD3gW4xtjg4YvKLvZRDtE3NUeAAAlomnavHpz2VFIjhkqXM02YKSEC8QvZAukEituPf/OqMio1fbGKN/Zk/0l9PCvDnnOVnGeCA5lje1U9QCAEkZBrdC40G28NeZJ4xdungKfDcDRvvqqIxCN8sh6jPbz7xxmPEW5rxJWgP2Vyri26Ez+wMAYb8sLg/6YeOoGFhj49rvj2yMZHLsL561lQxHldHeoXlS007hyxr18aKM9+/i8SwJ/H9aBc2BDFXLNPZw2F1qPh1+7bmgO4Krj7klZwF+UETz4kThw+eb7lIOkE/ZbgJtxYZLBlHVHziE8MCcuHZA5j6vfEkG1JrpggJL5RgnGIyv33ZQjXr2wKIn2VH2XTcec8Jc/+evzIIjvpfypnvSpFxmLAYiyr4lCCYxfkqE4w+RQozAfB4rceq4bJsn00qCBpsSteab/qne4rZNLKOuT60FULd3RZYE3aXY+lo8JySD4xWBiJ5TE0ZQO6IMPqz5A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(8676002)(8936002)(5660300002)(2906002)(4744005)(316002)(7416002)(76116006)(66446008)(66556008)(64756008)(66476007)(66946007)(4326008)(41300700001)(110136005)(91956017)(6486002)(54906003)(71200400001)(6506007)(53546011)(6512007)(26005)(186003)(36756003)(2616005)(478600001)(83380400001)(122000001)(38100700002)(85182001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmloNE1OaDlUU2FYQXlGL0xoc3RlTUZySTBuZC9vNVh1UDFacXIxYUd6Wis4?=
 =?utf-8?B?SUFIYjBub25QMHNnUVQzRzNTRzBacFdKeGhuV0NlcmV4eTdvUGJhQ3dEOXhx?=
 =?utf-8?B?eDRHWHBCVis2TFNzYW9kdTMwOGY1WGdyMjhhRVBjcVdCSVNrRGE3UmViNkht?=
 =?utf-8?B?K2NUc25QWG50MlZWNjlxU3NRRDZHeTIrRmo5K0FVYk5MOTk2WEV1K29QSHYz?=
 =?utf-8?B?SnJtVGFKcnVWNk1nSSt0LzNQTlFrOVpnNGhJUUt0OGlZWFRqTW1RUFlZVXpW?=
 =?utf-8?B?ZWZKNk1uWUQ1Z2dGdG0yWU9YOE52K2dxejhsRHIveXdncE95WlBKQ0JxZUFF?=
 =?utf-8?B?eDZMZnRzQ1I0emtRaDIzUHlUZnRLZ1lFUTVCSzhjVldvNkpzWlk2WHZtYWxw?=
 =?utf-8?B?RTVIRG9QcFZVT0lLQkZJOUZWSHdXZlVSSE5aa0lPK01rRjM1emk3NkxxZjBi?=
 =?utf-8?B?WURDOGtoWkNaZFdtRmZQQU9lWHNJWDFnZlAyRzgxaThMbTNPak9VR2c1Ly9L?=
 =?utf-8?B?M2l2d05VMDN4cm00aHp0WFRuMlhDc0dUR2Q5TE5xd254WHdlNjVXNlJZZjBj?=
 =?utf-8?B?eEcxZHo1MWtLYTVqYloxYVpoY2ZVOExkaXRab0R1bzZZUWdsWEpZbWhzL0pD?=
 =?utf-8?B?NDVJNXh4WDEwSlVaMEUxbHozdXkwOTcrZGVKNXp2TisvMDVkSnd6ZU9wOVpY?=
 =?utf-8?B?b090VVh3Y2JzTU5tUEpYbE05MGRhR2psVzRyNzI5TERVcEpUeE1QcmhTNTJO?=
 =?utf-8?B?dTdPSnU1NkpYREpRT0p5NUNBbmg4Q2EvVmE5eUJCcFZyWVBsMCtlVXI3NkJC?=
 =?utf-8?B?ZmpzL005QlRXNDNFeFZIaEp2RTRraS9pSmtldmhueHpuUzZjMUtNWVhEdEFY?=
 =?utf-8?B?MFRHSEc4RmN0WG9LTXdUTUVNUjFxRlRPYXlra2ZleU1RL3lUZU1YSjFsQkM1?=
 =?utf-8?B?OVIxRjhQdis4V2l2SWtvN3ZCNkkyZ3d6WVBWRFV1anNOa0UramZnaFdDcURD?=
 =?utf-8?B?aDJYVmVFdFBRQkJpVmhzV0YyWmd6b0JpYU0vNE1RV2JaT2paWDNWYzU3eXFy?=
 =?utf-8?B?bjM4bUtKRzlrZVdndjQ0emdJWnhhU0ZoZ3RzNjNWaktpVG9zY3pZYUVIVVM0?=
 =?utf-8?B?QmMzK1ZrdGkxVjRad0NrbFlmT2Y4WHYrSEQ2NVhFOHV5L2NkTTMyRWNoU0xL?=
 =?utf-8?B?Ykg2KzhXSXU1UzBjZW9XTDZxZHNkZ3c0TzNRMnFnZitNQlowRDRkdnRGdDBR?=
 =?utf-8?B?U09PZ1lSTE9Hd2FkWGFBcGxOSmdmeDVORTc2NzRURXNUVTByUnIxZ1VRa1hH?=
 =?utf-8?B?SnJBbSt1UGVZK21Gd2JCdlVWd21iK25seFlRRVlCcUxHa0tRZFQzWFRoYlBN?=
 =?utf-8?B?eWk2RlNQMUlMTjBlUktJTTl0TzFwa1pUYVJ2cmlUU1Y3NWtWR0FIQU9VOWdU?=
 =?utf-8?B?cGJ1cUJLcTZISWovb3JHNjJqN1FsbkpqZCtoREEzSHNLbU43Q2IyV1JNMEtw?=
 =?utf-8?B?RXA4TUJRd2FuTkdWdnBqVktOc3daQ2tpb20zendnOFZMNll2R3loWGEvM3B6?=
 =?utf-8?B?NzY3b05aU1NaLy9NK2V6V1FkRXduMVdSeFIwSlZ2ZDlFcnNjTkpQUzVpd3pI?=
 =?utf-8?B?S1dmL1JsaG5USFN0eWdMaWdpRnlxL05kbGduSTF0WXJqZW1raTZGSmZwSUZy?=
 =?utf-8?B?Tm5RMW84SWFFRDRNQnNIY0RWa2RDdXM3VE5NZnpCa2ZlS0RrUE56bjI3b210?=
 =?utf-8?B?TXg0RE52d2xXaFRDVnRNWlk1QVhPbU45bnBXdk1oWTN4aVUvNkZKREd4ais2?=
 =?utf-8?B?allZRFhMMFMzMFNnemlVc1dFR3doWE1ZNHorMlpHZ21OMHV4LzJnNHhDdk45?=
 =?utf-8?B?cStkUzFjSml1RmZVeVlKczZaSTVGOVF3T1BvQ3JJZHFpTkRuYWptbUxHTC80?=
 =?utf-8?B?YTlTaWE2ckxmYitMdHIwdXEvc212QXhTdHZGblRreHBsMFFZQU9YQVVSTWlM?=
 =?utf-8?B?RmVFUmhXVzFMN3o5YWY3dkdMZHZHVUpBbDc2ckxISWpNek1sTVhpWHRZdDZ2?=
 =?utf-8?B?Q0VMd1RTNi84MFQ3WWdQeHBPeExVVXZkdEx6VHl5L21Td2tRNFZjUzJtYXFE?=
 =?utf-8?B?SVZGVWlDOUNpTFdYSVNNQ0ZaT3J2Mm8zZWJpSjVoY1ZyTGRFV3pzREs3R3Ni?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56526C5811BB7844BB74C91C28DC1481@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73535a3-635d-4f84-fe96-08db662e09b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 01:33:31.9967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgZ+HMSU2xSBmWpYMNEyN+qhveLN02xFbs5ev7ZbFjOd3YQSgTA80KD+Ug5wJQmLuj9eaDr9JZ8/TrgeeVg3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDE1OjQ2ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICBPbiAwNS8wNi8yMDIzIDE0OjE0LCBXZW5iaW4gTWVpIHdyb3Rl
Og0KPiA+IENRSENJX1NTQzEgaW5kaWNhdGVzIHRvIENRRSB0aGUgcG9sbGluZyBwZXJpb2QgdG8g
dXNlIHdoZW4gdXNpbmcNCj4gcGVyaW9kaWMNCj4gPiBTRU5EX1FVRVVFX1NUQVRVUyhDTUQxMykg
cG9sbGluZy4NCj4gPiBTaW5jZSBNU0RDIENRRSB1c2VzIG1zZGNfaGNsayBhcyBJVENGVkFMLCBz
byBkcml2ZXIgc2hvdWxkIHVzZSBoY2xrDQo+ID4gZnJlcXVlbmN5IHRvIGdldCB0aGUgYWN0dWFs
IHRpbWUuDQo+ID4gVGhlIGRlZmF1bHQgdmFsdWUgMHgxMDAwIHRoYXQgY29ycmVzcG9uZHMgdG8g
MTUwdXMgZm9yIE1lZGlhVGVrDQo+IFNvQ3MsIGxldCdzDQo+ID4gZGVjcmVhc2UgaXQgdG8gMHg0
MCB0aGF0IGNvcnJlc3BvbmRzIHRvIDIuMzV1cywgd2hpY2ggY2FuIGltcHJvdmUNCj4gdGhlDQo+
ID4gcGVyZm9ybWFuY2Ugb2Ygc29tZSBlTU1DIGRldmljZXMuDQo+IA0KPiBIaSwNCj4gDQo+IC0g
Q2FuIHlvdSBhZGQgdGhlIHZlcnNpb24gY2hhbmdlIGxvZyBhbmQgdGhlIGxpbmsgdG8gdGhlIHBy
ZXZpb3VzDQo+IHBhdGNoIHZlcnNpb24gKGF0IGxlYXN0KSBwbGVhc2UgPw0KPiANCj4gLSBPbiB3
aGljaCBib2FyZChzKSBkaWQgeW91IHRlc3QgdGhpcyBwYXRjaCBwbGVhc2UgPw0KPiANClRoYW5r
cyBmb3IgeW91ciByZW1pbmRlci4NCkkgd2lsbCBhZGQgdGhlIHZlcnNpb24gY2hhbmdlIGxvZyBh
bmQgdGhlIGxpbmsuDQoNCldlIHRlc3QgdGhpcyBwYXRjaCBvbiBvdXIgZGVtbyBib2FyZC4NCg0K
QmVnYXJkcywNCldlbmJpbg0KPiAtLSANCj4gUmVnYXJkcywNCj4gQWxleGFuZHJlDQo+IA0K
