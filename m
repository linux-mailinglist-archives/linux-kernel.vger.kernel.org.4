Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD76FC95A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjEIOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjEIOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:44:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC2BE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:44:17 -0700 (PDT)
X-UUID: f3bb6298ee7711edb20a276fd37b9834-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KF3j2xrXntVUmtjKBLJjztlesP1mMNdYHDrTqFsIe6o=;
        b=gkUxrKdZeBNG2uFQ968aPSNNA9E90ZKNKhNmUji2bhe36CwYmTb661WVYxTyJPC6/1SgoLEWme9Q7VPxgrjTKz3HQ+9PZNCyLivNvqR1oMdSd2Qvv+S/XO0Bk++pGA83GFANyXQ9nDSGu18eVDLjEWhcQA8vonnY7prmNai4OZw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:658906c8-8cde-4877-a330-67c3386985d5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:50ea9c3a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: f3bb6298ee7711edb20a276fd37b9834-20230509
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 143145972; Tue, 09 May 2023 22:44:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 22:44:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 22:44:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0gq4ePfbN/828XXf3luyQws3S6Sbr256ljxjoIhyllIF4X6LrJvQef+HEHegwOIhEmWEDEP2s6JtI8kyL3LV5SMWzPcrIeqQBn75H3Ie1gmhH0YSEAMZmnbaOg0ZENsTG92JX0AvjnsmjYLIRnW9fHnBGjjtIYL5zra4pvE0Vt1UBYWmOiW097j4ZxKjPDwwCDc5Vgg+dzaWaCEXcKiuCsjJSPh4N05YUkYqFpde1QRm6yKMjE0Ow2WOYHX9X1GpnZ5Ar2RNm7iX9+PtPDa8VuIr8THk587JoXDITHI+gzBPPXG6q23wyNBaJZHqIzjJQiH+dLNpzGr1faoKGT4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF3j2xrXntVUmtjKBLJjztlesP1mMNdYHDrTqFsIe6o=;
 b=baErJxOqIRa+3xUEmL54woQqz9GGYeANqJO9GSkXbc7wQ7SQzNuxmH2IazkQCGVtNBQkypAWA7XAMY2N5yN5F0Twb8VePKh6Y51CxCj1p4N8w2BRwGyAeO1oFReA7cCiryQ8wQfAnSqQsUPS1gkQ0ubvgL1JAgRgh51vt8RJlV7hE37lsdhoydT24KDX17tTlePJZnlAQHKNIwy7QvMrPlVG6DCItqDXfUFlmYI/9/lngVQfCufp/v0NeY2CEMZOsu33bCjyOl2ZxEQWQcDt5qdqcW+Lf8DDCPgd0K4WwHx7GDUW51OU6SKK7No1ft8AAOZLpn+IcVz9ZRFSdXu0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF3j2xrXntVUmtjKBLJjztlesP1mMNdYHDrTqFsIe6o=;
 b=I6P5VAdfOSqw3hMK9ERGy6FX7z5zlgTwxuo6fZH9elhctjBrZ56cfQo894gvQfNo13ss0Mufq19oMaNLrJj0g4koisZAm0nz41Pwy/nQbDinLQKqOTt80cfCI1ohr3GYoUMuuvrZnCPaZlozdmdzf5TOafW/NPmRLmy8zYD5kRg=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by TYZPR03MB5995.apcprd03.prod.outlook.com (2603:1096:400:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:44:04 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::66d9:2bd0:26ba:d9bb]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::66d9:2bd0:26ba:d9bb%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 14:44:04 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 10/11] drm/mediatek: gamma: Make sure relay mode is
 disabled
Thread-Topic: [PATCH v3 10/11] drm/mediatek: gamma: Make sure relay mode is
 disabled
Thread-Index: AQHZgBeT9St9ZWnipkSMJKJHF+PzWa9SCTaA
Date:   Tue, 9 May 2023 14:44:04 +0000
Message-ID: <951c4ada65183a7e91dc6ffb431f5e360557c40a.camel@mediatek.com>
References: <20230506123549.101727-1-angelogioacchino.delregno@collabora.com>
         <20230506123549.101727-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230506123549.101727-11-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|TYZPR03MB5995:EE_
x-ms-office365-filtering-correlation-id: 11d7f63b-8980-4f9e-119a-08db509bd5f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+JcSvbZ91Uazmlvl9ttilwbriuc9bEBjFt4WDvnOTCw6X8WU8Z4TCSQCPcSacf8OHKPautGSvxmB1bV8mCB2z+HUOIxpE84avfhzdee9snh0elYr9puGqj2fCR5lB5RScJ70SxrWQVMGA6eMsTudHFuz/PrwTuYxgmBcisRQeo8pXHeYoskAKMLTy5975MpW/4R9SsjzzfrDfGIlxJ9sXinhbr9Qgzl6fWXQ3kpdgZZwmwDHzys8szfsONz8vK8o5AtuPK99nDykejHDmXIXbfHa10btiioxzd2eZnuLnFQ481QwRItm46WIV6x6jLr6eyq+vPFVWtzyugIXA7itLWKHf36AZ26VgADsaOldQzNKECk507M3I+odtDpfNLrg00sCDBVLxb4dCQLqws5ID6oeNlzRJMnWf1IV8I2uS43ndZhQDKlAtBYSz7RWiWzjj5uRjq7ad4Xb5N4TnwyeuB40xEROAr/P1KzQevdF7e8SMFsBCiA2fvQTWNFOPYxk7JsbLYzaNdi0CjJ5ViKOVp5TsDZaj8uD/kotnXY3zBFYcLfTek2GSNjRWPi84d8D0ZLZatYJyDWFROi+nC05GhUuQ7C7UX8ObJAW9qJF93oKab+bc2DX62DSec8UlZ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(66476007)(4744005)(7416002)(8676002)(8936002)(5660300002)(41300700001)(4326008)(316002)(64756008)(76116006)(91956017)(66556008)(66946007)(83380400001)(85182001)(71200400001)(26005)(186003)(6506007)(6512007)(478600001)(6486002)(2906002)(66446008)(38070700005)(86362001)(38100700002)(36756003)(2616005)(54906003)(110136005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTRBVXZoWXhZYU9OU0Fsa1VxWFpZeUtWSXlmdS94NHAyZEVRZlNNbjE2bGVv?=
 =?utf-8?B?Y0pZYm14OWNjTEJZMmE3QlJoSDh3M3M3VkpFblRDQzdqVEo1RWtNUVBONDFv?=
 =?utf-8?B?UlRBWjhxSkh6Vk5QRXZ5bExKT1JYWThwa0c1d1lyM0hDTjJuN3NoUmJxRy9G?=
 =?utf-8?B?dHdjZTFFWWJqcHp3OGZNVVFmNzhBUHJGMUdiT2c4aTRGSjc5MVowZnJ1UEhh?=
 =?utf-8?B?SkxXaGRMMG45MmFKSlhHUGk4VTM4M09Ma0RVcXJDSDAwcjV6dlNBcHFJbjVC?=
 =?utf-8?B?NVB4OTN6d3M1My9pTFNPUFRycnZkL0RjZFNkbzB5NmY4VGZ2Z1poNkY5bVZK?=
 =?utf-8?B?M05ONDJGT0wwN2hNLzlhQ3J1OXMvbDBpYnJKNlVlRFdGR2U1cHk3c296UUwr?=
 =?utf-8?B?ejdHNWpqWWg4WjdJWVJtVFd4RUozQW9lWkRVYk5JYzBGeUh2dWNSN1IxT2RL?=
 =?utf-8?B?L0t6YWI4VThPVmswQ285ZFhSMXpRMjVYdzMyWjJOSUlnelkwUjZ6eTd2NUQ1?=
 =?utf-8?B?SnpadFFuNW5RVEVYbHNHQ2VTUm9qaXE4U0Rjd3pTV0MvMExleFVIQ1JJM29H?=
 =?utf-8?B?aUlhVVlvd2ptZWNGbWhkVk16TWVVOHJXNDJBR2pxaCt6L0NZeXNNVFExdjlU?=
 =?utf-8?B?ZzhHb0xIVlo1Q2M2bExCWUF2WUFUYWU4MGpIdVgzMzBZaTBSL3FkNDJETmV4?=
 =?utf-8?B?d0FERGJrUUljLzByOXJ4V2E0a0U0eHJISytCWEhkNDZsMkJDQVlpd1JwMGlx?=
 =?utf-8?B?TmIzZUtyRVd1MVFneGFDTlNqWW1wWG93VzJjclRwS0VGQ3BXRU5qdCtEVjBK?=
 =?utf-8?B?T0h3K0RzK0E3MjJRVjNxaSt0TUtHcnpRRkppMk9VT3JaamJCTDlrRG1meStD?=
 =?utf-8?B?RlQrM2J1WWlrK1VqNC9HSzFLcy9YOEJqdkxtVDZXR3B2U1JxUWdDcmNJK1U5?=
 =?utf-8?B?ZGkvcDJDT3haTktGeUpVK1lzMWs2RGtZYnFsRkdCNlMrcHRCOGMyYURoQjZu?=
 =?utf-8?B?c1RJeFBad01jSXc3RnFGUkEyZTBycmpIdllDdFBmOTlPcllQVWp5dFN1eldZ?=
 =?utf-8?B?cUhWb0t5ZGx3UnF3TFdyYUo0UlVVU0VRWDJIR01EcUh3YWZaSXdvbzkza01G?=
 =?utf-8?B?LzNqS1ZSSmdoa20rdlRDQXhHZkQ1ZXMyZnR2ODhpU3hNN3NPMXdlK3hNbnh6?=
 =?utf-8?B?QzZzQWNLaU82YzBnR0xwNDdZeko3T0FXbGdQa1RFWWt4TkUwTit6KzVGUkIv?=
 =?utf-8?B?RkkyZTRjK1JKd2VUUzZNVm12c1QxUFAyUEw3SkNmUmxXckpneDkxTnAzdVk2?=
 =?utf-8?B?YTZUWEQwSWV0Y0pxcUUrZEpNbitlcGRZUzJQeU94K05naEVZdnBVdFljNFdL?=
 =?utf-8?B?bUxaczNraXlOZStManJFM0pkVGwrSVZLN3R2OFJUSEhRdzZqQTYxL2t4NzRS?=
 =?utf-8?B?TEU4bXBhd0pGVHVlbm4wejRDT2JNUUdyK1VyOXlPVUp3L2EwMlFMS09kSi9G?=
 =?utf-8?B?YnczZ05Ba2JRbDFVcW9yT3ptYkFLM0xGaVI0NkRoeUZvYUpVR3VDSTZDNXNk?=
 =?utf-8?B?RHFjZDBZaHgwZjRLbVRGSkNUaVJoYklXVElETDgxK2cwMFd5bm52cExVWUE4?=
 =?utf-8?B?S1I0WHhMOHRQQ0tLVkFQUUVlUURURThOVS9HVklYaStjTWpaY1JYMHNuZ0Fr?=
 =?utf-8?B?aHltWHZLMDJPRi8rZEJWdGdaZkNObjFpU29saElhZ1J1dGtERGROYytaK2Zy?=
 =?utf-8?B?OUovVmp4WGRtS3VqQkhhTGVKNit6cWJxRHBqRXZZMU9pVEZTT3BJOE9wNmNJ?=
 =?utf-8?B?aFR5eGVSTHk4ME8vYnBiUit6MnlyaDNmMXBSbU8yNEM2R1pzdUN0ekt1cjJp?=
 =?utf-8?B?WVJFTXVXNkk3WUFUNG5QQlFFWXlNeWNKQTRiTVZFM1VsRWNWMHlNc2duMmRK?=
 =?utf-8?B?TmUvclFYNHdBMUo0KzBQb0tUbTIrVG1kbW5lY1pQcWdnY0Z3Rk1aRE1nbXRi?=
 =?utf-8?B?NTkrVEZoajZRR3pkMTBxWG4vbzIxT1JOVFB3Sm5DaXJudmthVXhaSmNsdkZL?=
 =?utf-8?B?YWp1bkwrWHRsdmdleXJibDFBY0VsWFlBVFN3TDNxdFNzV3RUTkVQaXM4NEZV?=
 =?utf-8?B?NnRVaUdqQVVxTEFJZjQxTEFGM21EODhRNCtuZGtkeE1WSTlPeGF0UmcrSlRp?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F945DFEF365B04D90C2A365E5C2EDBE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d7f63b-8980-4f9e-119a-08db509bd5f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 14:44:04.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBbTnLGvBF2lHsXh3evy+s6sgEn9VXiukO+zIeC2xQFxdw3wuYZA+NVpIpWC8raWkEAcHk+ZOyySkA5FYPyXItKjU3yOiDLLsV5DpkXoFgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBTYXQsIDIwMjMtMDUtMDYgYXQgMTQ6MzUgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IERpc2FibGUgcmVsYXkg
bW9kZSBhdCB0aGUgZW5kIG9mIExVVCBwcm9ncmFtbWluZyB0byBtYWtlIHN1cmUgdGhhdA0KPiB0
aGUNCj4gcHJvY2Vzc2VkIGltYWdlIGdvZXMgdGhyb3VnaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdu
b0Bjb2xsYWJvcmEuY29tPg0KDQpSZXZpZXdlZC1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5s
aW5AbWVkaWF0ZWsuY29tPg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQo=
