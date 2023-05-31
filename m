Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBBD717330
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjEaBdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEaBc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:32:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F810E;
        Tue, 30 May 2023 18:32:52 -0700 (PDT)
X-UUID: 0c4edbe6ff5311edb20a276fd37b9834-20230531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3mfEoABA16LmLbfgXhrVUgGch5NAB557pgw6BJw1ubg=;
        b=eoQgPR4v3zkZJqWZ87nLd8+HFKgzwdNsSDgflgeo53xPR0ZxCOlJlYDn56lBuwcjSIK3ozp6wXUayuMcEokgPdPUkuYoptpIeiXWphQse9F6MXGOzehJnzY2VO0fUVddHa4EiZMwWiVg3gZorh1dbSzbrZFAEi023DICZ0XV8/w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:3297b575-0c4a-49c0-87cd-f25672be54ea,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:b97a826d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 0c4edbe6ff5311edb20a276fd37b9834-20230531
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 919976856; Wed, 31 May 2023 09:32:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 09:32:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 09:32:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INHqq0b1DXmDLLGuOF0NyxXVm7oMwxvOtV3wmSLmA8boqXsVDlcRkhZigvWJRrvIu5CPUB6UaPUeR1cB2k+Zyont720bzl+qOoqeidVy8s34axZuSF/+4ynu+HVpx2rDxF99sxoK+O3KFE9M25pTHQYYv4wQpTM9IGn6vuzC7DLk0wrrR/5owGuKFHVZpj489rbdqmcv7NmauUM7RVGFHjTflnBP/213KBHMrAHaI4QUzuzX2Hu/3GB8+NVOaj35D49kDXjIuNaY+9q8udl/RF+utPF4SwxoWRpfU1HOOed5lq9749WqIHsCkM/59pjZ2Fz/WHGszrGGEfQCOi8GYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mfEoABA16LmLbfgXhrVUgGch5NAB557pgw6BJw1ubg=;
 b=N93VM84QQ12M6GjT/himx7TetKIplrxiMB4POzT8du9pYDYtkQGhJfNBL74blvsgTpTr5ASvUTRR24InQONZHBfX7q5EFqLVCTvurxQ3JB1sJ4m46pZgKVxRTxU0qng5DMD8bPbuBhZCO+V6HuQLkXP1YnT7rIsO5Q6I7Ku6r3hSHZwCEAUMrPeeVy44oxfo0pLB3o4wnnHmYR1T9C/0nXO0oLfkOvkZp0DLGIVprVB1x1VwJh2t1C/BABC9zqMfL2yc6BtAtRr1kb/3YMbiR3SR+iYLWUWK+fueH/aGN8Hiqqdgp6/RC8k6khmRKzysLlWcKyvVx+NRhpR8foB2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mfEoABA16LmLbfgXhrVUgGch5NAB557pgw6BJw1ubg=;
 b=CtSTi8ckKaK+dj6S3Dlz3mO3lbqvLvGMxjgbmKUeDGCqWsnQOs5xxQWT3oZgGzFo/WyueIUF7B5E1Nmr7dnWxkGFh4MIb6b6lHRHFdVPPSnjpBx98zUtW3tc28ZDbZCgV7Hwm5NChVuN6mC28WQVXPP91NZyPD4eJ8rHO0dBZnY=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 KL1PR03MB7309.apcprd03.prod.outlook.com (2603:1096:820:cd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Wed, 31 May 2023 01:32:42 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d274:3164:e829:3131]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d274:3164:e829:3131%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 01:32:42 +0000
From:   =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] nvme: complete directly for hctx with only one ctx
 mapping
Thread-Topic: [PATCH v1 1/1] nvme: complete directly for hctx with only one
 ctx mapping
Thread-Index: AQHZkqA7C2fPkjryy0KrxZht1ncDgq9zF+OAgACCcgA=
Date:   Wed, 31 May 2023 01:32:42 +0000
Message-ID: <f14b7a6d463c0e569e310e480e67e773a7679d2e.camel@mediatek.com>
References: <20230530024120.17196-1-powen.kao@mediatek.com>
         <ZHY2TUrKVBj2xGE2@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZHY2TUrKVBj2xGE2@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|KL1PR03MB7309:EE_
x-ms-office365-filtering-correlation-id: ddb1729d-9538-481c-4ebb-08db6176edc6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PNbqWtoQ4gzZ3PZFg+ezQ1xwlzQ4N2prsElvIWeEaiZx1jXLEFwAQapd9BDdGl2KZRsxzqTYfgEfoUQtZAwvl4PXbhRo6jJWAR5Z1JSfK/AnSsL6Gpgcj/S7R/div65xl9u4kfpTzPSo19DXYdCql62A0dzDCVtfH4EGZGCB0CSxLNv4X9paYtRNnWHIVcfirMcOygW+VUnp7Kr+vBROaXc3AdIsdlQcNvNhgQ1umwOjHrHLUydf8hMy7LXU1k7Cl6xlW4M0XC7WUxIzasj8Oocx2sRb8EAVizwdCtwETDA9kcpYX9OXaAKAD48m38vXZfqr/xY6R+2xDbn/KHOeWIHpVCt0ykh/cgqKpHtUmyZFi107S8VLMBVSNpC1PyyrJOhM2yDH0lCoenpBFq0t/Ma1QopkRXsykpr+ncBb3Pr4eI4Xu/cFjlUJU+Wh7yGM43qXhp2TBVCSZ9/YJgg9wAaFB9AKT/dJGgBzJ6iT5mvMNDEMJ/bgEanR4rShyyfZBaTxJvyyDEH2g3ACUvbPVzDc7HcN1F9mrhlzZ5mcRLiBhTUzc00bf2ZOIFR4cIAVDMNc+Nki5vBxLc5Q6/HjkjFgkP0s+ARB4Jnj+j1n+tqqlcZ89uZQxUeDJViV4N94
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(122000001)(4326008)(6636002)(76116006)(2616005)(66946007)(91956017)(64756008)(66556008)(66476007)(66446008)(7416002)(186003)(8936002)(8676002)(71200400001)(38100700002)(54906003)(36756003)(41300700001)(85182001)(26005)(6512007)(38070700005)(6506007)(478600001)(2906002)(110136005)(83380400001)(5660300002)(316002)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0gvWGFnZ0RJdEVmTG5zVHcrUWs0ZTVwYnBPR0l3RGZWTGp1N3pwV21sNjd5?=
 =?utf-8?B?T0tIWHVDb2Zqa2xLV1UzVE1Xby9sYUpGVG8vTTJFS3NWS21FOXo5OUtqMWho?=
 =?utf-8?B?OXFyRXRRLzFhWWxDS1ZnS1RvSUZIdk9nK0tEZWtLSXMyUlkwNDBLcUhtallj?=
 =?utf-8?B?T0JMc3hLR1VvN2ord0ROY2RZdkcyenVpN2hKQW1PSEJ1bEQ4Slc0OGtLY2tV?=
 =?utf-8?B?blUveTN0TEhSZzJDNWN1SXVtOTFLU1Q0aWJQVFRuTjd3Q0wwRTRWUzQ0RVFG?=
 =?utf-8?B?d0lJWS9wRm5Cbm1JUmh3LzZrTHhqLzU4RGVSUHVlWnQ4WHg3NnhqMHRJSW8v?=
 =?utf-8?B?K1hTRkFKQXBsazBnVlNmOVNSdk5ucmN5R3hJQ0doSXh0REd2cytQellEZXRU?=
 =?utf-8?B?Rnd1MTZMQVlPdVJ0N2ErbzAzZUV5S0NHZEs2c0NVckhUaEwvRjdOZ1ZuekdI?=
 =?utf-8?B?Sk5WOGdvOXFaYUMxcVJyY3lXKy9yOUdYREwyS3QxK1FmcUU2dUlRb3FQMThz?=
 =?utf-8?B?bGNjbzdmMjlHZDlwOW9rR2FmcFFGNnBiUmpTQzBWRkpsdUJHdGNLa0NGWis0?=
 =?utf-8?B?UTgwWmdhOTZudXlNS0VOM2M5Y3RoMXQzMDQwRmxQZVdrbkpPNFM3UFNHWjk4?=
 =?utf-8?B?MnZ2QWQ3ZTdaSFF5M0hDUCtIRnNiZ0I2T1dOdi85N2dUNEJXekVhNllhL2E3?=
 =?utf-8?B?R05xNUVBMnp3c2UvdDlnck9vY0E4OTArWkZLbk5GamFvUGxKc0FhZ2doS2ll?=
 =?utf-8?B?WGcvcktjcXlsSkM5YklSYmRVT2hna2VmYll6VVNET1VKTnJlMmFPSFdoRDRq?=
 =?utf-8?B?OXh1RkFGMElnaUFuTHZYakZiOWJ4ZnE3VHU5QjJkaVZDMzJsNlNJdXpqUjdw?=
 =?utf-8?B?QjRlUzMxR1NNMnl2VVF2UUNGa3hQRE4xZktXaHBaSGlLYkhjTHExRi8wTit2?=
 =?utf-8?B?TnR3SlFCNG1wNkQyUnB0SnEvcjhzaHYwR09aRHU4ZjZDM1FzV01rODg5VWRO?=
 =?utf-8?B?RHlBQjBJVEl2QWpkRUJrbTZuTXEyQlVuRzdEeW9HeTBWWjlBVmMrMFJuaGtn?=
 =?utf-8?B?NHVLK2FzbXlHQmJpS2FmbzBGdW5jRmxZaURCQm5kVzcvTTNFbFdPNlBmbGl4?=
 =?utf-8?B?aGVic1VxeUY5NXE4aXcwdmRrR0hRU3NNemx3L1AxOGJQek5rK0RSLy85WVlw?=
 =?utf-8?B?YWhjMWxDVDB2dlp2VTZ5U2hkV0hsMkwyUFM3RjlkWWdqNkFrZjM3Uk15RlVk?=
 =?utf-8?B?clpaOVcvc3dSalpMS1ZuNDhMQlJoRVhISStXMDdmWmtGTmllR29FYWlZV1p5?=
 =?utf-8?B?cit1eElMYjU1TmxqYjBURHlwTEFVWEd4UkdacWpOTHIxTkxiQ1pyYTdyY1pm?=
 =?utf-8?B?ME8zeGNQaVR0TWVXa2drTmlXYVZDdkdvRXFzRjBRb2JsaFBzRGVuM0pzWGky?=
 =?utf-8?B?TDVWZTMvSElkNkNCRGpNOEtEMzdNNWMxdmNhOVpWM1FXRXhYS1Q3Q2U1SGRj?=
 =?utf-8?B?VkxvVnovLy84RlZETjJKd0tiYVQzb2hWL2NDYU91ZXJwcGYyZG00NUVQaGpr?=
 =?utf-8?B?VnFFL21mWHVIQU44OHV4UTJpbnhCOThySkpFcVZBTnJMajFXMEs5ZmV2dHZC?=
 =?utf-8?B?dWduUjFrNlJhQjBmY1ZCNWxFNkJFUGlRWFpWSk94VHFZOGR6dk5YMVJPVGpN?=
 =?utf-8?B?RWlONVB4czEvZ1FyaVkvN1U0TlNGUHNkekw4cUhNL3dQNTlrYUY4cHVDRE9X?=
 =?utf-8?B?MTJlc0U2dHg2WmJhNXdWRk4zb2xhTjRDc0oyeDRUSENzQTdZVEp6K2Y3NzNi?=
 =?utf-8?B?QUk5WHhLbDBSWkthVzN5ZzBrSEswV3I2bjJ1cXJLajI4MkdwOEZwVTFPZFNV?=
 =?utf-8?B?em5vbHZ1ZExZZzBzeFpxdFpoY0NobFY5NmdZb0V5M1dqdVdYVmsvSXR4RFVy?=
 =?utf-8?B?NGREVUNmOHlKSWpIa0x0NUxVTTFzOWVsRnVmcENVekNVQ3pmS1ZrcWtndVU2?=
 =?utf-8?B?M3hmNjIrclg3QnFKbmhobEw3bStMRGhCVFNtUkw5aXY0Zk1mRDZndWFmcUxH?=
 =?utf-8?B?b2JzeUVtS0U2YTVhY3Mxalh4QkFzd0NMQTNqVEpJUU0weUJGM0JkTGFrMmpN?=
 =?utf-8?B?VHUxL0haMjZwbHVwUnloaTN2eWo2a0txbVlGR2k5OVpLcC9zNThTMkttQXpO?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31E85EC92DBC34448E1A1C1FBE387400@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb1729d-9538-481c-4ebb-08db6176edc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 01:32:42.5861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiftbxjHB2vr3awssgxNAPKL5jQ6dLUjg3jMcVxHKnY7GJMnJANJyBeMfMARfR+Olfca635fjUxlygON+Twevg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTMwIGF0IDExOjQ1IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBUdWUsIE1heSAzMCwgMjAyMyBhdCAxMDo0MToxOUFNICswODAwLCBQ
by1XZW4gS2FvIHdyb3RlOg0KPiA+IC0tLQ0KPiA+ICBibG9jay9ibGstbXEuYyAgICAgICAgICAg
fCA4ICsrKy0tLS0tDQo+ID4gIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDQgKysrKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KPiA+IGlu
ZGV4IDE3NDlmNTg5MDYwNi4uYjYwYzc4ZjVhZDQ2IDEwMDY0NA0KPiA+IC0tLSBhL2Jsb2NrL2Js
ay1tcS5jDQo+ID4gKysrIGIvYmxvY2svYmxrLW1xLmMNCj4gPiBAQCAtMTE4MSwxMiArMTE4MSwx
MCBAQCBib29sIGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3JlbW90ZShzdHJ1Y3QNCj4gcmVxdWVz
dCAqcnEpDQo+ID4gIFdSSVRFX09OQ0UocnEtPnN0YXRlLCBNUV9SUV9DT01QTEVURSk7DQo+ID4g
IA0KPiA+ICAvKg0KPiA+IC0gKiBGb3IgcmVxdWVzdCB3aGljaCBoY3R4IGhhcyBvbmx5IG9uZSBj
dHggbWFwcGluZywNCj4gPiAtICogb3IgYSBwb2xsZWQgcmVxdWVzdCwgYWx3YXlzIGNvbXBsZXRl
IGxvY2FsbHksDQo+ID4gLSAqIGl0J3MgcG9pbnRsZXNzIHRvIHJlZGlyZWN0IHRoZSBjb21wbGV0
aW9uLg0KPiA+ICsgKiBGb3IgYSBwb2xsZWQgcmVxdWVzdCwgYWx3YXlzIGNvbXBsZXRlIGxvY2Fs
bHksIGl0J3MgcG9pbnRsZXNzDQo+ID4gKyAqIHRvIHJlZGlyZWN0IHRoZSBjb21wbGV0aW9uLg0K
PiA+ICAgKi8NCj4gPiAtaWYgKHJxLT5tcV9oY3R4LT5ucl9jdHggPT0gMSB8fA0KPiA+IC1ycS0+
Y21kX2ZsYWdzICYgUkVRX1BPTExFRCkNCj4gPiAraWYgKHJxLT5jbWRfZmxhZ3MgJiBSRVFfUE9M
TEVEKQ0KPiA+ICByZXR1cm4gZmFsc2U7DQo+ID4gIA0KPiA+ICBpZiAoYmxrX21xX2NvbXBsZXRl
X25lZWRfaXBpKHJxKSkgew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1l
LmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gPiBpbmRleCA3Y2Y4ZTQ0ZDEzNWUuLmFj
YzliMWNlMDcxZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4g
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gPiBAQCAtNzAyLDYgKzcwMiwxMCBA
QCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gbnZtZV90cnlfY29tcGxldGVfcmVxKHN0cnVjdCByZXF1
ZXN0ICpyZXEsIF9fbGUxNiBzdGF0dXMsDQo+ID4gIG52bWVfc2hvdWxkX2ZhaWwocmVxKTsNCj4g
PiAgaWYgKHVubGlrZWx5KGJsa19zaG91bGRfZmFrZV90aW1lb3V0KHJlcS0+cSkpKQ0KPiA+ICBy
ZXR1cm4gdHJ1ZTsNCj4gPiAraWYgKGxpa2VseShyZXEtPm1xX2hjdHgtPm5yX2N0eCA9PSAxKSkg
ew0KPiA+ICtXUklURV9PTkNFKHJlcS0+c3RhdGUsIE1RX1JRX0NPTVBMRVRFKTsNCj4gPiArcmV0
dXJuIGZhbHNlOw0KPiA+ICt9DQo+IA0KPiBJIGRvbid0IHRoaW5rIHdlIHdhbnQgbG93IGxldmVs
IGRyaXZlcnMgZGlyZWN0bHkgbWVzc2luZyB3aXRoIGJsay1tcQ0KPiByZXF1ZXN0IHN0YXRlLg0K
PiANCj4gSXMgdGhlIGVhcmx5IG5yX2N0eCBjaGVjayBvcHRpbWlzYXRpb24gcmVhbGx5IHdvcnRo
IGl0PyBXb3VsZCB0aGUNCj4gZm9sbG93aW5nIHdvcmsgZm9yIHlvdXIgdXNlIGNhc2U/DQo+IA0K
PiAtLS0NCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMNCj4g
aW5kZXggZjZkYWQwODg2YTJmYS4uYTJkNjViYjEyN2UyOSAxMDA2NDQNCj4gLS0tIGEvYmxvY2sv
YmxrLW1xLmMNCj4gKysrIGIvYmxvY2svYmxrLW1xLmMNCj4gQEAgLTExNzYsNyArMTE3Niw4IEBA
IGJvb2wgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3RfcmVtb3RlKHN0cnVjdA0KPiByZXF1ZXN0ICpy
cSkNCj4gICAgICAgICAgKiBvciBhIHBvbGxlZCByZXF1ZXN0LCBhbHdheXMgY29tcGxldGUgbG9j
YWxseSwNCj4gICAgICAgICAgKiBpdCdzIHBvaW50bGVzcyB0byByZWRpcmVjdCB0aGUgY29tcGxl
dGlvbi4NCj4gICAgICAgICAgKi8NCj4gLSAgICAgICBpZiAocnEtPm1xX2hjdHgtPm5yX2N0eCA9
PSAxIHx8DQo+ICsgICAgICAgaWYgKChycS0+bXFfaGN0eC0+bnJfY3R4ID09IDEgJiYNCj4gKyAg
ICAgICAgICAgIHJxLT5tcV9jdHgtPmNwdSA9PSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpKSB8fA0K
PiAgICAgICAgICAgICAgICAgcnEtPmNtZF9mbGFncyAmIFJFUV9QT0xMRUQpDQo+ICAgICAgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0tDQoNClNvcnJ5LCBJIG1pc3NlZCBmb3IgdGhpcyBw
YXJ0Lg0KSXQgbG9va3MgZ29vZCB0byBtZSBhbmQgSSB3aWxsIHVwZGF0ZSBsYXRlci4NCg==
