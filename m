Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C451874343B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjF3F3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjF3F3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:29:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D42D69
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:29:33 -0700 (PDT)
X-UUID: 146da200170711ee9cb5633481061a41-20230630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WYHFtYDeLXH9ub3ftbhAmsC4RPynNeiW6F8pNj6p0N0=;
        b=tBM/hlaNabCtu6/dJNLEokZ3KLHmJMEIEhANjIkx65dEP0x4c3RPoHcAMWIe1Rqb3XxKwbtOxe0gl6D4xQhokAHVj8vFmZ1UOnBQ6iyMORixst2+Ah2NBJofPsSTjGMg75HaFBzAw9cKTSKD9RSKwuBuFt/6SEvB/sTeCzQrtKE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:e1ed5d54-971a-42ae-b005-fb5972738208,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:7a4177da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 146da200170711ee9cb5633481061a41-20230630
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 259812993; Fri, 30 Jun 2023 13:29:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Jun 2023 13:29:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Jun 2023 13:29:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8X+DKqaQG3IZyNptn36y9JqVJPG3Shh7XSXBGhNojC2OSQhuxw9Vur+wLh4d2xmsuHX1P4o3Br5yBY8a/gNYHUKlPJQV36MEuCY2gvr3vhc6DdBGo/jt8iVlBDO3JANqRIWFqEG7K4gNZYbMqDUBcsRlPYbuhkLufKlHuRpz6E/b5cwFhLHR1dRq6fD8BjmdF288suLm/0TM6mK+uBxvHt10EGj3YLWu6QfLfDxgAD9rxyitFOqLvY1SA8cicf/WbzomZgIu0bnv2T152RP1UG03dOOCMKkgZ/3Nuk+r0ZGnsewkyrmg4Bm1d1L7veIiEKx8BUh4znZQohigtrsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYHFtYDeLXH9ub3ftbhAmsC4RPynNeiW6F8pNj6p0N0=;
 b=flVNgBxwznUKwOjnOXFkVMGthw1ZTPdPJmERQ8SxNraLjXHdO9qztYsJr7dzZvuvRR/55b5MqQjuiIsfuvOg+BGdRYj/i04aBlssebhdjXgHCoCGOLNzYXdtpNENoRnhOxQJ/j498CXdxW9a9sGb44YF0rMAQKNwo/vZ+1NBjdWxE7F44jueLtUEM5iWddpVlB78Rkd3k4nmxCzolMFo053UeIiqLSKGTRurcVF6nRTQ9mN7RkCOaH5T57kshEJCYoi/zwFIqc6ZHTLYQlZFMwYvmeeeHIf/t78K8Ec3WyOjPBof8IaeYeARnbpJNBMXelQGj0meT90gQpUR9MThmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYHFtYDeLXH9ub3ftbhAmsC4RPynNeiW6F8pNj6p0N0=;
 b=p6W/U/PQSKVFoMEub7zR9TayYH1iPbEdY9Gg7gI4b9ky4pDs9CvgOhLgBzfEkYP9pGDEJ1Mpwhf/BqyBGDKSFmFZCivvVyhhXdBSXlGbT1eIK98a8s3ziffargNTNIMumpMmndkFlexWkVyeScLhSF64RfQf05Umi2m8PtDf71g=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5775.apcprd03.prod.outlook.com (2603:1096:400:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 05:29:24 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::f5fe:ada:20da:5200]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::f5fe:ada:20da:5200%7]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 05:29:23 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: add constraints for PCM
Thread-Topic: [PATCH] ASoC: mediatek: mt8188: add constraints for PCM
Thread-Index: AQHZql+a6p+yEgGYRky6qKsurqdc2a+h4bMAgADxNYA=
Date:   Fri, 30 Jun 2023 05:29:23 +0000
Message-ID: <0e8b5ca298a01b16da0419928a30af6371e923ca.camel@mediatek.com>
References: <20230629075910.21982-1-trevor.wu@mediatek.com>
         <5995e77b-ea8e-4e88-8ca2-f716df9c9579@sirena.org.uk>
In-Reply-To: <5995e77b-ea8e-4e88-8ca2-f716df9c9579@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5775:EE_
x-ms-office365-filtering-correlation-id: 93e5f5c8-dfcd-4d12-38c8-08db792af6cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2VDhZWh6nRPA4v1XEIhp48PNs+AZLKFMuPW5WLkeWEWEt/rYVFf+g2wrnFCvoEYAJuSWefoTqo7WjfdSpt8OB+7VJrOSIHe/4eq8oNMmRmAWwXYBLkR2eD0Hw00YwMxnTfO/4Fnns0FltLqJ5Aus3va1ZIghv/mH62sgl2H6hc+Qth6AS5GTohnHBhF8VtE2kjxTW1/mgJ4FIH0ai8l0hAl1Ce05xLKKq+RdhQ7RkAkC8W3Olg8D59Gxg6Rd+oEwB/ZD3+aqboqObSLzGV1nYYqgRGIrupYN1oLYcD2m1bpfRJWmdFa7pXGXDBob62v8FBbwEPYhGFIw86yjWCxEn3oVXM34Y3hA6EtojH9wOQhRRfH3gxvvuPUDmx34unDbsbLX8UK6Jw6vG+TeOHeq7qZiAZqx4DbkkLw/1AwmmykBZD8QPU1teLxsDhrwON2Y8RCoRmVvwpEARVT/5vh5+kEB8XAdExVKBj3qGeVV2QFXBRdz6h8T9E0GLlPAY5wUiYDGAsb7nO8KCtvsg5NeRnvqDmIPMlA0YHR8bKasNK4Y+5POm9ElIRHqh7VacALmMOXbTcIM0S1EI13tPB9jjqBeb5pFbevnbFJBBYahnPTFLT2PHkMSaI0BU2esvPXQbeDLxMTVuvYnf6lP9bYoPUUbBnRLOF3D6SB/LM7mQseYs8/qqAjHWXq5jj869Nv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(83380400001)(38070700005)(2616005)(2906002)(85182001)(122000001)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(71200400001)(54906003)(6512007)(41300700001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(91956017)(316002)(6486002)(478600001)(186003)(6506007)(7416002)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3lVd1FIRzNNVlpzSTdVdlUwMXBOSmpCWXVDNXFyOFV4OXByZUhyeitYdGY2?=
 =?utf-8?B?K2doQjVLSS9lR2JaeGYvQmJYeHpJUXQ0VlFaTWd6QTJJMnNQcVZUcWlYckVv?=
 =?utf-8?B?eDdheFhObjhraXQxU2RYeEdaSWtNNmFNRmYyN21ydThjLzZBVFFmeTdJZERO?=
 =?utf-8?B?TjAxK0NkckhFV2lUYkVPYlJVVWhWaDBLVG1qNm9pTTFWZlZzb1BycWl6WklN?=
 =?utf-8?B?djgrMlNta1NqVytjL0E4YWdTbTBRZk5ZSjZqZHRTd05rd3dxVzRXM3BjcXhq?=
 =?utf-8?B?VkdXc096cW5BbDF3RklUZ3IzbTlJT0E1d3FaRVZOVXFDR2x5dDFBaGZ0RUtN?=
 =?utf-8?B?UTJSOEpib2hCdWpvK092Y3NKMEordFAvWHZnUUhMTXB0ZFN1ZkxBTnYzZHY0?=
 =?utf-8?B?VXZ1NWRUUzlLODM0bUg4QkxmZE1FNzllbTh2ZS9Pc01qSHIvSGRxUU5OU0tT?=
 =?utf-8?B?akRJa2dRc3VJTmljY2VJWlpaVUtPbDgrc0txVVc1R0YydThTUXg0REFGdFUr?=
 =?utf-8?B?d2ZZU21LSllpNlNlS0ZpNmxwSnNVOTNiUC9aM0JXalVMYmdiOUhCVU1pZk4z?=
 =?utf-8?B?K0RnQ2NUbFhadldwWmZWUmdTT2Q0VEY0Znd3bFAybmNyOGVuZHR5WUo4aFEv?=
 =?utf-8?B?b0k1QjNGSXhmeE9BV25odmxKNXN4REJBUjFRbGZhdHdjbkNveUlNc3JESXRm?=
 =?utf-8?B?ejlFZ3FpTG1PR2doTDJIeStTSW9QbUpFVm1XUjBwcnlZUWlXU24rK0lOOVZ5?=
 =?utf-8?B?LzFUaUtVUWtSUXQ4MDg2RGIxREJldEVtaDdjbFhNWkNjak16Q0RKWDJkQ0Rx?=
 =?utf-8?B?bE0yblhrYVU2S2lYU0ptYXBwbDB1OEVzV3NUellGYmNWMVlVOFJUTHc5Wncr?=
 =?utf-8?B?RWNyMlZjR0hlOEZrM2swNjh2dnVwbWUydkRNRWpXSjdYdm9RQ1VXcjlRME12?=
 =?utf-8?B?RVNSTHlhK0RockZmYjVxUWRmdVEvYXJOYWdndmtNLy9DZnByd1M3M0UwNjFW?=
 =?utf-8?B?bmkxUzNzQVViMVp1RTZ6MFVSMFduVjVuMVc5L0d6N3RzcFNtdlRoekVqN0U0?=
 =?utf-8?B?QXZSdUhCVit0NVhWNnl2cm1xb0ROaUdBenF2QTlSQkcwaDVpVHM2RmZtTWlX?=
 =?utf-8?B?c2V4VFdIa3VudmhHVHBjaTF3dTRkckpiYzVWUW1JT2p3VGR4Wm16TlVyV0oz?=
 =?utf-8?B?ZEszS21taEZieEtSYWkveUlHN0ZYakR5YXBrSUY0YWttWEFxK2hqaUlNK3dp?=
 =?utf-8?B?SVNnckUrQld5bDdueSt2K2VYMnBZajVlQ1dhaEQ2VmZJcGdJWWtKNmpRSk9Y?=
 =?utf-8?B?RXdKRWtOTWtvQUpoUFplRTBCMklXdUxkeW85dnI4RkJxWW5Nd0JZemN1ek9x?=
 =?utf-8?B?TlZvSG43VnRQTFc4dHdiMXp4elNjYm4ydzZRdFBpcTNOdzN3TkN0QUVYRTYw?=
 =?utf-8?B?ZTgyVHQzeHQxMzdaY0FvTllJMXB1ODlEeTVDUEMzelhWYzY1NzRJSlF2aUdo?=
 =?utf-8?B?Mm5vVzRpcCs2bVBJU1lmR2FJMXpBS0dDcVZtblRhTzc5MmErUEw0WC9vanNs?=
 =?utf-8?B?UXgxejdHNzhxdG1pZC95YnIvUHF3bWIwWnlmL0RGeEJEekNDbWJianZTMWdC?=
 =?utf-8?B?YVdZUTZXVmhnYmUyRHNuOHVkMXFHZnlmUDdnWUlCSms2bkZLNjlCZkFFMEsr?=
 =?utf-8?B?MVZvYWJEZmZsV3VhcytSTW5aYTFLMzFUcE52R3NEc3ppOXQ5SFU1UCtDT3JR?=
 =?utf-8?B?M2FJaDJNUkVYbStGenFNRGVjVWFYZ013clMxdzJId1cyTkkvSkUrampzdU1m?=
 =?utf-8?B?dVRiVGZFNjRUbUlhZVAxK21FaEtXd3EyZVJ4UHlCWlBlaEltUmcyRXErQlJw?=
 =?utf-8?B?WXVZYTR1aWx1UHowUFk2MC9RellENE1zb05KSDk3SklzMytURU5kVkZ5SldM?=
 =?utf-8?B?NktONUlQaEROSnVIWm96NUtzSHNQWW9pNjdrTXhnejJDZ2FtclI2aUdiL0Zp?=
 =?utf-8?B?aElXYVJVM1Q4UWQ4c2xMMGhYTVdBYUhiRExWbkNMM1o4cmN6V05YQWdIcG5p?=
 =?utf-8?B?c2l6WHoyZHpicm5uMTZ0WUdwOU5iVDhxK1IzOUltVWI3ZFhJWFNlYi9wR0k2?=
 =?utf-8?B?dFVtdWNPeEVHbGMvODlMcEdBUEhLSWFuSmd4Y2kxUVpHcDNIclBQcllHNzhI?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2664CB73FD2E5542912BB224B53C11BB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e5f5c8-dfcd-4d12-38c8-08db792af6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 05:29:23.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKTQGYsUB0foxDjZe0yiFdy6PMXtYTVROyrODQnbCafbKpPPpqOwvgtjDQHPG5Jec1tgJ0GmzF2VSyqcHeVeVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5775
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTI5IGF0IDE2OjA2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIEp1biAyOSwgMjAyMyBhdCAwMzo1OToxMFBNICswODAwLCBUcmV2b3IgV3Ugd3JvdGU6
DQo+IA0KPiA+IEZvciBjZXJ0YWluIHByb2plY3RzLCBvbmx5IGEgbGltaXRlZCBudW1iZXIgb2Yg
cGFyYW1ldGVycyBhcmUNCj4gPiBuZWNlc3NhcnkuDQo+ID4gVGhlcmVmb3JlLCBpdCBtYXkgYmUg
YmVuZWZpY2lhbCB0byBhZGQgY29uc3RyYWludHMgdGhhdCByZXN0cmljdA0KPiA+IHRoZQ0KPiA+
IGNhcGFjaXR5IG9mIHRoZSBQQ00uDQo+IA0KPiBUaGlzIGNvbW1pdCBtZXNzYWdlIGlzbid0IGVu
dGlyZWx5IGNsZWFyLiAgVGhlIGVmZmVjdCBvZiB0aGUgY29tbWl0DQo+IGlzDQo+IHRvIHJlc3Ry
aWN0IHRoZSBjb25maWd1cmF0aW9ucyBzdXBwb3J0ZWQgd2hlbiB1c2luZyBhIG5hdTg4MjUgYnV0
DQo+IGl0J3MNCj4gbm90IGNsZWFyIHdoYXQgYSBuYXU4ODI1IGhhcyB0byBkbyB3aXRoIHRoaXMg
b3Igd2h5IHdlJ3JlIGRvaW5nIHRoaXMNCj4gaW4NCj4gZ2VuZXJhbC4gIFdoYXQgZXhhY3RseSBk
byB5b3UgbWVhbiB3aGVuIHNheWluZyB0aGF0ICJvbmx5IGEgbGltaXRlZA0KPiBudW1iZXIgb2Yg
cGFyYW1ldGVycyBhcmUgbmVjZXNzYXJ5IiBhbmQgd2hhdCBtYWtlcyB0aGlzIHRoZSBjYXNlPw0K
DQpIaSBNYXJrLA0KDQpGb3IgaW5zdGFuY2UsIHNvbWUgdXNlcnNwYWNlIGZyYW1ld29ya3Mgb25s
eSBzdXBwb3J0IHNwZWNpZmljIHNhbXBsaW5nDQpyYXRlcyBzdWNoIGFzIDQ4a0h6IG9uIENocm9t
ZWJvb2ssIG1ha2luZyBvdGhlciBwYXJhbWV0ZXJzIHVubmVjZXNzYXJ5Lg0KQnkgcmVzdHJpY3Rp
bmcgdGhlIGNvbmZpZ3VyYXRpb24sIHVuZXhwZWN0ZWQgdXNhZ2UgY2FuIGJlIHByZXZlbnRlZCBh
bmQNCnRoZSBhbHNhX2NvbmZvcm1hbmNlX3Rlc3QgcHJvY2VzcyB3aGljaCBjaGVja3MgYWxsIHBh
cmFtZXRlcnMgcHJvdmlkZWQNCmJ5IGFuIEFMU0EgZHJpdmVyIGNhbiBiZSBzcGVkIHVwLg0KDQpB
bHRob3VnaCBtYWNoaW5lIGRyaXZlcnMgY2FuIGJlIHJldXNlZCBmb3IgbXVsdGlwbGUgcHJvamVj
dHMsIG5vdCBhbGwNCnByb2plY3RzIGhhdmUgdGhlIHNhbWUgY3JpdGVyaW9uLiBUaGVyZWZvcmUs
IEkgd2lsbCBhZGQgdGhlIGNyaXRlcmlvbg0Kb25seSBmb3IgbXQ4MTg4X25hdTg4MjUgd2hpY2gg
aXMgdXNlZCBmb3IgQ2hyb21lYm9vayBib2FyZC4NCklmIHRoZXJlIGFyZSBzaW1pbGFyIGNyaXRl
cmlhIGZvciBvdGhlciBwcm9qZWN0cywgdGhleSBjYW4gYmUgYWRvcHRlZA0KaW4gdGhlIHNhbWUg
d2F5LiBQZXJoYXBzIGEgbmV3IGNvbnN0cmFpbnQsIHN1Y2ggYXMgRFBDTV9GRV9DT05TVFJBSU5U
MSwNCmNvdWxkIGJlIGludHJvZHVjZWQgZm9yIGRpZmZlcmVudCBwYXJhbWV0ZXIgY29tYmluYXRp
b25zLg0KDQpXb3VsZCBpdCBiZSBtb3JlIGJlbmVmaWNpYWwgdG8gZXN0YWJsaXNoIHRoZSBjcml0
ZXJpYSBhcyBhIGdlbmVyYWwgcnVsZQ0KZm9yIHRoaXMgbWFjaGluZSBkcml2ZXIsIHdoaWxlIGxp
bWl0aW5nIHRoZSB1c2Ugb2YgdGhlIG1hY2hpbmUgZHJpdmVyDQpzb2xlbHkgdG8gdGhlIENocm9t
ZWJvb2sgcHJvamVjdD8gT3IgZG8geW91IGp1c3Qgc3VnZ2VzdCB0aGF0IEkgYWRkDQptb3JlIGRl
dGFpbHMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlcz8NCg0KVGhhbmtzLA0KVHJldm9yDQo=
