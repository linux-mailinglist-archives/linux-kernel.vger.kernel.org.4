Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776A96BC6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCPHNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:13:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D65ABB1F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:13:16 -0700 (PDT)
X-UUID: e3eeef2ac3c911edbd2e61cc88cc8f98-20230316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YUFA0NiEIaiwFfZZvevtgRN0Ss4v0oInkZom7yMWKRM=;
        b=LTC+h17LP5JNWdlvzxXhzk4QBbr2RsO5xW1kOUUSmVzPqtPmQV4Gn7rUn/PzGmpEM8N5pJW/othAdclM0sxefdB6dRKSGGTuEmlrKd7MbakQzvi3YwSCj+prL/cfHdiIMWFIPa/gD8rZPxnBlagpyoO0DNKHZa/hXsAl4+QehlQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:4b438e5a-5c58-4647-9207-899b46946884,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:06326db3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: e3eeef2ac3c911edbd2e61cc88cc8f98-20230316
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1772940619; Thu, 16 Mar 2023 15:12:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 16 Mar 2023 15:12:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 16 Mar 2023 15:12:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9K/3+Mw2+mwqHGiWCEzEvgRO1XICZouc3vtT7ImBE2eYix72T/o6Iggfikto+wrxP+Lrqea2Spu+Jgy26oGQbFT3DtrTBkp2T4/QRn8bRx7diNZBFzMx6gxtsrBYOsnzbQ2imTDe30vHTB7tIw1GwOvlYojHPf/Xz5nLlIu9Dm2NsL3FPKAJgd9HBnP5TYmF7A3IsIyLjhGy0v0jd2FHc+29diJz6k+tZZDHtXaI7UHnX6f91qP8IB4dq3AcUG83oWqIajdkaVz+NFeUkylEgUnyOwOR7lfHInQtBI7tdVpIFdaiovTP5u3XqK0edQy5w0n4a1/a5pA2QREDgXxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUFA0NiEIaiwFfZZvevtgRN0Ss4v0oInkZom7yMWKRM=;
 b=caFHjLaNPpbRPK5yaaADfi9QkLSiu5bpRa9cxim+DAAT1pEzf7V0MDcJto7qTEuf9lhxdZr/hAC3eERMvVVLVXaNEYi18ZQ5cjeVkLBcDL69EEJCsqE0uwK3wl6HFf4BrI7KYbxv5D8I6eBM/Zp5lC7e7qKl2krimcFt3EAtepBIRnhzT02SAFnU0xXDTnhbjbq3vw0jKCG0LLfartL3njZt5EB7N2u20PwFOS1STegZNVP3z+7B1RXswBNZhCNDzKE9K+p2Kg8KXqdt4FtL5Gxe8Yg2lkmVDFqT8SlrbhlMdSHcbQzMw0wOMbk1XiFGlx5IYvlELyrybf2Xd9NKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUFA0NiEIaiwFfZZvevtgRN0Ss4v0oInkZom7yMWKRM=;
 b=dw99hyMej4MeOq0dsZ0FQqC5Lzn3W5mzNGQtSGJeLbAeWOkohWNsdzn8XGTLUyFo2nG4RJCBL/em+luFbZpfNwkcm45a2acgPvyE4O75sq4AcuSxWw+ppmWzXr9QEle2dYtWWinUQm6wwWtAf0W993OHrl3M3Nh9H8JsVM6WjIw=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SI2PR03MB5420.apcprd03.prod.outlook.com (2603:1096:4:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 07:12:17 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::308:f1a4:95ed:f546]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::308:f1a4:95ed:f546%7]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 07:12:16 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>
Subject: Re: [PATCH v8] phy: mediatek: tphy: add debugfs files
Thread-Topic: [PATCH v8] phy: mediatek: tphy: add debugfs files
Thread-Index: AQHZPS3cBmb6PozoBUixhjUvGQR2AK7ITwmAgAQ/AAA=
Date:   Thu, 16 Mar 2023 07:12:16 +0000
Message-ID: <4e5d86502cc6b2278d7079dfca688af63bbcb523.camel@mediatek.com>
References: <20230210085827.7970-1-chunfeng.yun@mediatek.com>
         <Y+ZjPYDEbC9iblsj@matsya>
In-Reply-To: <Y+ZjPYDEbC9iblsj@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SI2PR03MB5420:EE_
x-ms-office365-filtering-correlation-id: c3811875-befd-4691-876a-08db25edc658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lOocy9d7WPpSv/xazDIsEgntdAKKgjMcOaTlEaa8NLglxQY3nWGf0UINyp8GLxioFnO/jrJaKgqicEc9s7IzgFqlCaWQXF1L3ZUxJIvtv0w7l1++DzDdYiKe7bRBXJvI9os0J/RdaIKJfkV32CMZBCFlhAGX5mhRNIpcnzyfEWDcslXYaJsA7DCJeceD495L3mudVsm5IiXKtsfy9X7zG5Gl6rhxnQr2U6HZ1aYN31M/h5ThAAUs9qPfZiRJWOGGk1MNz/tiSkzixUxGYqM0ilQhhyAmceVp7HDErFX1Q83olQJSueN4A6OvtR6wlp952GK3e9imxrBhEYsgowjKHenyoUuOfC/Y9uXRZCp2Wq/6UUb/XqGrE4cB8wP/bFm+GHO4sfw3oRI9bLb30fTvCe7eHcB1wt2w1ND3MC2Ck6044oOuCFGIYPChKsqGx0sfLCd2NVonSii/+QOu2m1aNytdiMKulBIFmmEtcV1rW72HBZjAXpTiiD1Z/k2P9iag7kV5c19FrUILwBcWk6QSqvFNZgGYWYaAWhHlZiJ+Lyr72YLxgCq8wnUg/nwlVns61Ks/mIPXv/wieKV13SZW7VKJTC7zAo788JVz1GfVuUCANKph64xO19ePmTlsRJk7n8jdna6CmjBI3kqNACa5olgGnbMeXq+Pw6fc8S9tTv72ZqhJw8LYy75AEhtkyzYvnRf3g4+9NXv5MlkYmgqB2p/DraiRJhcT97pMzNFKRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(8936002)(5660300002)(41300700001)(2906002)(38100700002)(86362001)(38070700005)(36756003)(122000001)(4326008)(66446008)(76116006)(66946007)(107886003)(6486002)(71200400001)(91956017)(66476007)(8676002)(64756008)(85182001)(6916009)(316002)(2616005)(54906003)(83380400001)(478600001)(66556008)(6512007)(6506007)(26005)(186003)(53546011)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1cwUTBYVGlIUktndHZpNysvVXN1NVFPbm5VNVdWQWRTRXkvQ0dmMkpiQ1dX?=
 =?utf-8?B?dDBVaENDYXdFU2dDZzhyQXN5MkFFc1BNSG1YaFdmRmdzSzJyY055OXZsRmFJ?=
 =?utf-8?B?cGlZMWZhd1kvR0c1L0RzTHNGVEYzeFRyR0FET0pLTC9rN3hyVGNUaE5Wd1Q2?=
 =?utf-8?B?clZKa1NObjJUeE50cTZ4NUJZc1NmM3R4N2Fmc3lJTUprbFM5ZDBnVGR0MXVa?=
 =?utf-8?B?YWhwWlFTbHlTTGU3WWlLd2FxMzN6S1VNclhoV0llTEJhSTBaZWpTTWxXY3FR?=
 =?utf-8?B?cWlmODVIQTFVRDd1N2theVp6RnFXYXd4d2RJbWU1cHRoMGg3alVhbUJkY3NN?=
 =?utf-8?B?dEhZN0pYNldoYk5NM2VJRm5xeWZjK1UweFlPaS9oeHQ1N3NiYkhZUzBFZytU?=
 =?utf-8?B?TlVnckJvdHdnanZkdktya1NEYTJNcFFnUzZ2TkZRb1RxSEZrNmJIZ1lHMlhy?=
 =?utf-8?B?ZU9pNDJwTGovMmM3NkV4anQ1dnpFc2M2NkpXcG1rTmJXRXVHUlRlZ3hlWjdW?=
 =?utf-8?B?K1Jhc0N4a0o1QWpMdVhwRlRsS0Y2K1JHUzh4amRvK3J0Z3pJd0owNXcrT3RS?=
 =?utf-8?B?ZVZEeDFiSWhDWGp1UWpGMlc0d05vRXpvMFdqU3pudXZzWWhCaWFOQjdPRDJo?=
 =?utf-8?B?Y2pzK01vQkl4a25yWHFkWlpvTGhoQ0crNmkrTXUwbWhscDdrUU9oZHZNdk0x?=
 =?utf-8?B?VVlLYi96cCtXOEMzMVhPNW1xeFFHMG1RM21zVXhLekdmWGRXdThHakFkLzM0?=
 =?utf-8?B?dzdqcXpHRnhMbE13dnJqT3VYYysvbVpZdzBnVXZienFaNUJaS3Q1eGo1MjdK?=
 =?utf-8?B?ODFUWmRqWkd6K3UzMFN3VVB4RGpITWxoWXlTZUt6cmFETjl6dTNKUWJJZXVD?=
 =?utf-8?B?ejcxVWZOOCtYZGJ6Y1JlNmFJY3RKdW5teWhJQk5DRERTY2Mra0xoVzdtY2w2?=
 =?utf-8?B?dGlQQ3VlTGErd3pVQVlqKzdOem54UGkzSWdMNjVRcGp6dHNkU1EwS3A2azZi?=
 =?utf-8?B?OWR6bW93dmZDUEYrMFpJVEtaaXJneFIvcnRxNHFQSHg0V1VkQ056RzFCQjRO?=
 =?utf-8?B?SGM5NmRTZ2NleFRYTHFsQ09SQ1RWS3pvQlMrd2VwTTh0VTRHaTdKdkRqVStH?=
 =?utf-8?B?ZlJMTDlSSWE5dndrNkJSOHFpOUI1eGMvZTNGVENyWmQ4WVo3SnV3aW5HRUgr?=
 =?utf-8?B?cytsYUlOaTBqODNpOUlKZFoyVmRrQ01zWFp6Y1NCL2ZDZDlQMmJEbyt4SUtx?=
 =?utf-8?B?SnR0a3lvZStFMFg4L0Z2WHpja1V0ZWNkWWxiUFMwNG9DMHR3Q0xBOC9ERWpo?=
 =?utf-8?B?alhYcmZDenJYNWVVOFBua296dkx0K1k3YlU3K3lWUmhmZmxOUFpWMUdDRnpJ?=
 =?utf-8?B?Vmx2RFFEd2V4dEtCNk9WbUlBTEYrUktmN0pQMVh1SkpnYXJxczZ3WCtCelFa?=
 =?utf-8?B?US9qa0l6Y3dLNEpxSDR5V0lvNitGZVZrM1pLOXhSYmpFT2RpOWQxUGUwbkhR?=
 =?utf-8?B?NFlRb0cxa2pobmxaRlhRVEZGOEZ5SVNwYWc2S052Q0JLWCtRcEQ0NWRva29B?=
 =?utf-8?B?VHZoaERjMW5GaDZUVHlUSlVyWG85K0ZXcmZ5bzdHR1E5d1kvTVVDZHo0UjdQ?=
 =?utf-8?B?Si9jb3NTWHlCZko4Sy9hVzl4VE0rSGI3eGdDL3cvSFBwVWNMTTkxWDNBQVAw?=
 =?utf-8?B?NHVDQzZLTlc5RFhhdG9xSE5rczBhVllrVzh4RFdZdHZFQnlvUW9taUc1QTBT?=
 =?utf-8?B?b1hCQjVPaDVwU0wydURSNWkvRmhoK1hUOE1pWncrYXBrR0xwb042WmdGa2pW?=
 =?utf-8?B?My9XZXJBTVF4VTFETHdXVHdpRlhOTEFZTkUxeHJVcE5DaS9EUzJTR1E0eXdz?=
 =?utf-8?B?c2xveWxCQjlNc3BXQjY3T1V3bEhTUWFxMFVBSG90QmtFYTZBTndYQjA5Sk15?=
 =?utf-8?B?SHpycEFOVUVoOE1DTTBvUmFwbW4wMHFRYk44aXRYZDVXdWdvSDZLN0JQYXhz?=
 =?utf-8?B?SXRKbjFMaDc2L3RxazV0enFQTXZZYUQ1OGlqa1BMWmtJZm84a0NmYkw3Q0d3?=
 =?utf-8?B?SDVOSXRkTnVFRjZuclN6VWZBZXd4MDczOW5RTC9oQzMxQnFaTW1tOVhhYjlR?=
 =?utf-8?B?bWl4NHNzV3FVS2Vobm02T3ZNSTdsYWpaYXRDZmEvZWZqWjFocU8xM1d6VDVG?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBAD14F675BABD4DB1F54A0FB100EBFF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3811875-befd-4691-876a-08db25edc658
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:12:16.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8aUQmmeBlcJE78v0cG9VUAOCUhf2bSjwluyPJTUYTIR+Npo+qsyMda8vn3qyMjCsj771GvmFxpzPsBrC4VaNYtuUIZMxDy9qlkOaph4QYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5420
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDIxOjAxICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAxMC0wMi0yMywgMTY6NTgsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBUaGVzZSBkZWJ1Z2Zz
IGZpbGVzIGFyZSBtYWlubHkgdXNlZCB0byBtYWtlIGV5ZSBkaWFncmFtIHRlc3QNCj4gPiBlYXNp
ZXIsDQo+ID4gZXNwZWNpYWxseSBoZWxwZnVsIHRvIGRvIEhRQSB0ZXN0IGZvciBhIG5ldyBJQyB3
aXRob3V0IGVmdXNlDQo+ID4gZW5hYmxlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjg6IGFi
YW5kb24gcGF0Y2ggdG8gY3JlYXRlIHBoeSBkZWJ1ZyByb290IGZpbGUNCj4gPiAgICAgL3N5cy9r
ZXJuZWwvZGVidWcvcGh5LyBzdWdnZXN0ZWQgYnkgVmlub2QNCj4gDQo+IFNvcnJ5IHRoYXQgd2Fz
IG5vdCBteSBzdWdnZXN0aW9uDQpTb3JyeSwgSSBtaXN1bmRlcnN0b29kIHlvdSBtZWFucw0KPiAN
Cj4gPiANCj4gPiB2Nn52Nzogbm8gY2hhbmdlcw0KPiA+IA0KPiA+IHY1OiB1c2luZyBjb21tb24g
ZGVidWdmcyBjb25maWcgQ09ORklHX0RFQlVHX0ZTDQo+ID4gDQo+ID4gdjQ6IGZpeCBidWlsZCB3
YXJuaW5nIG9mIHNvbWV0aW1lcyB1bmluaXRpYWxpemVkIHZhcmlhYmxlDQo+ID4gDQo+ID4gdjM6
IGZpeCB0eXBvIG9mICJkZWJ1Z2ZzIiBzdWdnZXN0ZWQgYnkgQW5nZWxvR2lvYWNjaGlubw0KPiA+
IA0KPiA+IHYyOiBhZGQgQ09ORklHX1BIWV9NVEtfVFBIWV9ERUJVR0ZTIHN1Z2dlc3RlZCBieSBB
bmdlbG9HaW9hY2NoaW5vDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1t
dGstdHBoeS5jIHwgNDA1DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNDA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCj4gPiBi
L2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4gaW5kZXggZTkwNmE4Mjc5
MWJkLi42NWE5NWMzNzI2YmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvbWVkaWF0ZWsv
cGh5LW10ay10cGh5LmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRw
aHkuYw0KPiA+IEBAIC03LDYgKzcsNyBAQA0KPiA+ICANCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3BoeS9waHkuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvZGVidWdmcy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nv
bi5oPg0KPiA+IEBAIC0yNjQsNiArMjY1LDggQEANCj4gPiAgDQo+ID4gICNkZWZpbmUgVFBIWV9D
TEtTX0NOVAkyDQo+ID4gIA0KPiA+ICsjZGVmaW5lIFVTRVJfQlVGX0xFTihjb3VudCkgbWluX3Qo
c2l6ZV90LCA4LCAoY291bnQpKQ0KPiA+ICsNCj4gPiAgZW51bSBtdGtfcGh5X3ZlcnNpb24gew0K
PiA+ICAJTVRLX1BIWV9WMSA9IDEsDQo+ID4gIAlNVEtfUEhZX1YyLA0KPiA+IEBAIC0zMTAsNiAr
MzEzLDcgQEAgc3RydWN0IG10a19waHlfaW5zdGFuY2Ugew0KPiA+ICAJc3RydWN0IGNsa19idWxr
X2RhdGEgY2xrc1tUUEhZX0NMS1NfQ05UXTsNCj4gPiAgCXUzMiBpbmRleDsNCj4gPiAgCXUzMiB0
eXBlOw0KPiA+ICsJc3RydWN0IGRlbnRyeSAqZGJnZnM7DQo+ID4gIAlzdHJ1Y3QgcmVnbWFwICp0
eXBlX3N3Ow0KPiA+ICAJdTMyIHR5cGVfc3dfcmVnOw0KPiA+ICAJdTMyIHR5cGVfc3dfaW5kZXg7
DQo+ID4gQEAgLTMzMiwxMCArMzM2LDM5MSBAQCBzdHJ1Y3QgbXRrX3RwaHkgew0KPiA+ICAJY29u
c3Qgc3RydWN0IG10a19waHlfcGRhdGEgKnBkYXRhOw0KPiA+ICAJc3RydWN0IG10a19waHlfaW5z
dGFuY2UgKipwaHlzOw0KPiA+ICAJaW50IG5waHlzOw0KPiA+ICsJc3RydWN0IGRlbnRyeSAqZGJn
ZnNfcm9vdDsNCj4gPiAgCWludCBzcmNfcmVmX2NsazsgLyogTUhaLCByZWZlcmVuY2UgY2xvY2sg
Zm9yIHNsZXcgcmF0ZQ0KPiA+IGNhbGlicmF0ZSAqLw0KPiA+ICAJaW50IHNyY19jb2VmOyAvKiBj
b2VmZmljaWVudCBmb3Igc2xldyByYXRlIGNhbGlicmF0ZSAqLw0KPiA+ICB9Ow0KPiANCj4gSSBh
c2tlZCB0aGUgc3RydWN0IGRlbnRyeSAqZGVidWdmcyBiZSBwYXJ0IG9mIHN0cnVjdCBwaHkuIERl
YnVnZnMNCj4gd291bGQNCj4gYmUgY3JlYXRlZCBieSBjb3JlIGJ1dCByYXRoZXIgdGhhbiBleHBv
cnRlZCwgaXQgc2hvdWxkIGJlIHBvcHVsYXRlZA0KPiBpbg0KPiBwaHkgYW5kIHlvdSBjYW4gdXNl
IGl0IGhlcmUgaW4gdGhlIGRyaXZlcg0KPiANCj4gPiAgDQpPaywgSSdsbCBkbyB0aGUgZm9sbG93
aW5nIHN0ZXBzOg0KDQowLiBwdXQgYSBzdHJ1Y3QgZGVudHJ5ICpkZWJ1Z2ZzIGluIHN0cnVjdCBw
aHk7DQoxLiBkZWZpbmUgYSBzdGF0aWMgc3RydWN0IGRlbnRyeSAqcGh5X2RlYnVnZnNfcm9vdCBp
biBwaHktY29yZS5jLCB0aGVuDQogICBjcmVhdGUgYSByb290IGRpcmVjdG9yeSAoL3N5cy9rZXJu
ZWwvZGVidWcvcGh5LykgZm9yIHBoeSBzdWJzeXN0ZW0gDQppbiBwaHlfY29yZV9pbml0KCk7DQoy
LiBjcmVhdGUgZGlyZWN0b3J5IGZvciBlYWNoIHBoeSB1bmRlciB0aGUgcm9vdCBkaXJlY3RvcnkN
Cigvc3lzL2tlcm5lbC9kZWJ1Zy9waHkvKTsNCiAgIHRoaXMgc3RlcCBoYXMgdHdvIHdheXM6DQog
ICBBOiBjcmVhdGUgdGhlIGRpcmVjdG9yeSBAZGVidWdmcyBvZiBzdHJ1Y3QgcGh5IGluIHBoeV9j
cmVhdGUoKSBieQ0KZGVmYXVsdDsNCiAgIEI6IHByb3ZpZGUgc29tZSBhcGkgZm9yIHVzZXIgdG8g
Y3JlYXRlL2Rlc3RvcnkgdGhlIGRpcmVjdG9yeQ0KQGRlYnVnZnMgb3Igb3RoZXJzIHdoZW4gbmVl
ZDsNCjMuIGFkZCBwcml2YXRlIGRlYnVnZnMgZmlsZXMgaW4gQGRlYnVnZnMgb2Ygc3RydWN0IHBo
eTsNCg0KRm9yIHRoZSBjYXNlIGluIHRwaHkgZHJpdmVyLCBpdCBwcm92aWRlcyBzb21lIHN0cnVj
dCBwaHksIHRoZSBkcml2ZXINCm1heSB3YW50IHRvIGNyZWF0ZSBkZWJ1Z2ZzIGZpbGVzIHdoaWNo
IG5vdCBiZWxvbmdzIHRvIGFueSBzdHJ1Y3QgcGh5IGluDQp0aGUgcm9vdCBkaXJlY3RvcnkgKC9z
eXMva2VybmVsL2RlYnVnL3BoeS8pLCB0aGVuIG5lZWQgcHJvdmlkZSBhIGFwaS4NCg0KICAgRG8g
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPw0KICAgV2hpY2ggd2F5IGRvIHlvdSBwcmVmZXIgdG8g
dXNlIGluIHN0ZXAgMj8NCg0KICAgVGhhbmtzIGEgbG90Ow0KDQo+IDxza2lwPg0KPiA+ICsNCj4g
PiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX3RwaHlfZHJpdmVyID0gew0KPiA+
ICAJLnByb2JlCQk9IG10a190cGh5X3Byb2JlLA0KPiA+ICsJLnJlbW92ZQkJPSBtdGtfdHBoeV9y
ZW1vdmUsDQo+ID4gIAkuZHJpdmVyCQk9IHsNCj4gPiAgCQkubmFtZQk9ICJtdGstdHBoeSIsDQo+
ID4gIAkJLm9mX21hdGNoX3RhYmxlID0gbXRrX3RwaHlfaWRfdGFibGUsDQo+ID4gLS0gDQo+ID4g
Mi4xOC4wDQo+IA0KPiANCg==
