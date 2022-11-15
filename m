Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6C6297D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiKOL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiKOL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:57:53 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E117E29;
        Tue, 15 Nov 2022 03:57:50 -0800 (PST)
X-UUID: bc9f095473b4465eb2ea9d9bfc9b21b5-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N6VY9fx3MT9HipXzL6m9vT+7y0BitzqG7VGZUIjxq4E=;
        b=iuRAtzM8Iz25kg2MHRj/ZFw8KzAUWOzNIuCgV3bBLZrDY6eQOzd4M1ki2QtCFL8rh6Lpbb0h0KMVfyRI15XQEmcsV/7gQwmfEwGcZNI+wVhlKXKq9RW4ioYQoAK+g/lNt4qFa7ST7fe0RqZB/tp1dKBr5C9r5+aQw7Vn22n65sQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:888b3915-a227-4bb9-b67d-e75b047969fc,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:b29c8ef3-9094-45e8-b6eb-26f09041f731,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: bc9f095473b4465eb2ea9d9bfc9b21b5-20221115
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 576971824; Tue, 15 Nov 2022 19:57:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 15 Nov 2022 19:57:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 15 Nov 2022 19:57:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXc6aA7IOwLo5ufqNY6DW3spzgB+NsKgiOnJIf5+1oLOAS9Nq/YCSouF7CO8I5Wc6YOw43D8l/d/OjvQ0hswsidcZFDTp1PKWQ1ZuFuzKUK8dKANGaKf4bj2qRsnh9FT7+GIk388HED0aS87vPZ4meoQLQaDvq7yPonNLP2oi44LkxWSoD85iiSu2OT68b2L3aOjtka2mgmKynH7oKe15Ng4RyhyqeS4fwdLSBU+brxoHPTzQ5FKlMeHsPgrfga18FMiQoVRlJ+pwaVVq+t5UlcGLQMlvL2Cm5APVyg1iy9SzMK/XS7Bnr5PxbSUUnDLD6x4j8TUhmvrsdyqXdpmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6VY9fx3MT9HipXzL6m9vT+7y0BitzqG7VGZUIjxq4E=;
 b=FUVDLy+jzp4NcXr9cmpIpl8zzy5w6h8IsSZHe0OnCoevrGY134LwJ5j8HVWHP8BlQp//YSycgLYRKMKCwLD4kv9EZct26Tz3HJmXZVr/EHqMMtFDoPVduuVuJiFG41IbHzLzBtUbRa3sbbX9IsdWynllCz3bG8aa2aKCFDDfbeo4S6Mj2qNRbqrmMZVEl3Pw33cyWfQ0nCqOO+HsnXXJWZxujtHhUvU3BTHB9rNycPCkC6M2mRcSHcPRQv2N5jz+IRuf/Ud9JFgWP+ztJ6+BxAcLjmcyrDYsDVhqkYNO5RuEwA5WuL+rrfMeH2Bt4YLl9bYUaEzLW772Emj6vgmJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6VY9fx3MT9HipXzL6m9vT+7y0BitzqG7VGZUIjxq4E=;
 b=Gdgu90M43pQlypJyqIlXkLkePNdigxCLZodS8H500bG7YgfCXjpgu56eJTaHSPJpW8q0ezp3Wsz7wx2/M82Mxp54a7Z1nOBUDDEnGFHnohpuWYip0BYa4hYYSpTEHjPM+AQ0jidmHVs7qI/t/KT9voonl1MgT1ZAWVKw1qyToQU=
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com (2603:1096:4:11::15) by
 TY0PR03MB6632.apcprd03.prod.outlook.com (2603:1096:400:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 11:57:44 +0000
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::e692:7d40:92d:8189]) by SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::e692:7d40:92d:8189%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 11:57:43 +0000
From:   =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "acourbot@chromium.org" <acourbot@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TG9uZ2ZlaSBXYW5nICjnjovpvpnpo54p?= 
        <Longfei.Wang@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
Thread-Topic: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
Thread-Index: AQHY0Yt90aIhXHa1+UymMqXbj3zHz65ALbptgAACHIA=
Date:   Tue, 15 Nov 2022 11:57:43 +0000
Message-ID: <cd13d08aaa288fe5cd401f2be678bb6e68662711.camel@mediatek.com>
References: <20220926093501.26466-1-irui.wang@mediatek.com>
         <a386f704b43b117d8857a7d7f51b1652ddb40663.camel@mediatek.com>
         <ac1f56bc-2d38-8d0c-83ea-f5e36eb15e25@xs4all.nl>
In-Reply-To: <ac1f56bc-2d38-8d0c-83ea-f5e36eb15e25@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3035:EE_|TY0PR03MB6632:EE_
x-ms-office365-filtering-correlation-id: 7c9081af-7139-4366-b745-08dac7009ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 835gJNxbEDu16vqYDYT+GCVc8lDXb/B87RoAgZxN/HKSFjl62X2yTXcqf9OFdlixP+5FMuqwNyT58b/SJHGbKsSIQv7atCPeVeV9MLyg4xzUa9KbGDViFdFNgvgAiZseJ9LrsAOiaYuUGlKkorI0y0xFYj6Zg+sEwGdiPaxLfVbrw/2KhGsykitpfOOC4ZhVXIMwqQnXNJ0Mnr7bT8MMkT/uhHox9eEAjZwNqGwq9kYBclOMqx+0ulbCGKj1OztRMsGxUOEbfULgpbSjj6HGguEifMlaMk8K1Q5ixi+bd+w/Oc9z3D5RcFbvhcPJZQYt7zlIAtb0unW3CukX7CFyhjUEuUnxUh/nG8ctaZtQhBQCPfkoitBqS9oup9tleIO++KtpMSsbTlDgjXVaVRyRVJ4fAaiIl6nsnyeRImC29LviB4ZhOiDLBo4Rlxs1CHD3lj3Hnbc1S9V7Ze6dkP1kexLv2dqlyZrH/fCULVnpxflhHKGOpJY7FZ7S8fdMgdlbRF8kjwobpVA2llhQ6490LYHvLfS4+3XoBqmnfwZ405k4RYFlhijQBugWQ6Aw33z2GZ6VWFAcqWddUUJhiis7WdEbrbvJaGU11+5zRQgxQmAXfB/c3eTlH7HDZdn6MEiEZx2l0f7y3xd/ZSb9NEXi5HqpIEzF2/0nVxhj1vwlq3YE4q6C1XWlYof/ebPAoBiAF3ZubDmQCu3Nk/sBxgTX9AmbrCph6eS2MVNHtrg3FOcphqkZd2SkWS7r4iy4lZVct3pq+GfTzLqOaDD6Udd7TdCq+ZiTrVLWrIIM4UO1X4Whot4VGQO2QHbSirBWVbBy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(85182001)(71200400001)(54906003)(2906002)(5660300002)(122000001)(316002)(110136005)(36756003)(38100700002)(83380400001)(4001150100001)(53546011)(6506007)(86362001)(64756008)(4326008)(6512007)(8676002)(91956017)(26005)(186003)(7416002)(66446008)(66476007)(76116006)(66556008)(66946007)(41300700001)(38070700005)(2616005)(8936002)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDB4d3ExaUh0WDNvU25OSDBLMTBvMkViOGRJRWozUWJvTUR2ZUxjWGpHbThC?=
 =?utf-8?B?aDNhS2QyZjg1Smo5SXZFeWhQa09oMXdrQjVFcHNuUDUxNExWdTRqTTVCM3Fs?=
 =?utf-8?B?eUVoU2NRb1JYK2tadjFYQ1dxM3VkZWVIdDQyU2ZGd09TejM2U3hmYXFiMldM?=
 =?utf-8?B?c2V2cGk2ZVNaRE9NcmxzQzcwVVQ5NjErZStLak5YTkJ0emViU2FFdzVlVGRl?=
 =?utf-8?B?SkJHMW5QL2VSeHlQU0ZoRzh3TjBEQS9xVmF6NG8wU1NNclg0R3FpcXZPRUp0?=
 =?utf-8?B?ZTYwSVhIWUp1N1c3cE5BMEtvdmc0WWpyUWV4S2RrU0tKOUhyZmNtZkxMb2Rp?=
 =?utf-8?B?Rk84K3VEQU13K3kvclRnS2lObE13VTkwTEVlT0sxMlMwMzdqQ3BYUWFtSnoy?=
 =?utf-8?B?c2lSTTBIc3MxT1ZsRFFiQUltYVRiRk85bHlpTWtvM3drZXRHS2tucDFLN2lB?=
 =?utf-8?B?NVVrWUFjNGtSbWhwY3lvbnY1YURyRi9tcnNZQXQzWlRiQTYwR1hRNEdxWTZp?=
 =?utf-8?B?L3gyS2kvdHIrdmVrQkxkbFd2RXhsMWV3b3dub01ON3RCREtyYmhHYnpoWXBE?=
 =?utf-8?B?dm9HTHhqRFhNYVA1a2srT0FodklCVTd2RU5ZQ210U2F4MHpRK05XZUxuaVRU?=
 =?utf-8?B?RUhaWEFzYW40N2VwRVNzUDRSS2lMVmUwQ01oVnhkMHNUOW1XTXBDRDUyNlhG?=
 =?utf-8?B?a0o4SnlEQzlJSlJaMFIreXBGY0UvTTYwU3hSSEFhYy8rM1hIeDkwVDR3U3JC?=
 =?utf-8?B?QzM5U21nekpEcU9uUklPQmJKN1JhREFSYVJlMDZYVHJUcGJiTEQvTVBSb05B?=
 =?utf-8?B?bWRIdEtmN0hTc1d0dTNrWWt4SklJSzlDcFFXOXMzV3JjZS80VFh2eTRLYXp6?=
 =?utf-8?B?dENwWkE1ZkRSbTNKK1pWM0F1RDR1VE5yZ0Q1d3RreHh0TWFiUmpnL1N4MDFn?=
 =?utf-8?B?MVd3SkkwbGRyNTNTOFhibzJqeGtiU2dEOVF6QmNCcmdJTFBxejRVa09FTzF6?=
 =?utf-8?B?YVRSTkUyVlRNVXZmUGFFOWRYZERPU0EyaXFMTXhhTFdTbGlEd0NDbmdQWUhS?=
 =?utf-8?B?ODJHR3RxVXBVdVVXYzUzLzJmQnI2eE81Nm11Q0lYRDAvN2lDd1J5YjVwenp0?=
 =?utf-8?B?by9Jc3J4OVMxMHBLeUVkb0xWWmtackhxaWFMS0xXTW5pSXo3N29NanUycEdL?=
 =?utf-8?B?bFJESFZYQjZJcmhVREd3c2lDSUUvUmN3cVpzaTR3S1lkS002dWtyMGxlVjdX?=
 =?utf-8?B?WWJKcTkzR2VBVkJPMHB1QmVaTEdqeTFyNmt1MStGbHF0c3MrSWlrVmF2SkdF?=
 =?utf-8?B?UEJCT0FIL0RockExc3JaT1VGY0grTFJYQXVIQ0tMc1RDR2N6UUFEdXBvTWNV?=
 =?utf-8?B?eGlqUEsyWXJNWklPNEdkN053cE5YcVdML2VEd2xuemp6N0xFQ0hmcDZOdUZP?=
 =?utf-8?B?ZE5HQ2wxb1dTQURDVTMwV0NiQ2g4bUxwR1F3OUZ6bkVQM2VjcGI1eWZzN2cw?=
 =?utf-8?B?dmtsZ1E5TlVBejMzVzA0WWRhMHVBTUhDTzliMUV1VTdXSllDMzZtSkozK1Nu?=
 =?utf-8?B?Q2haeE5hY2k1VEJ6N3dtUG9iaklRS1VjbXhsalM0bFFUU2RvVUZvVXd6dWU4?=
 =?utf-8?B?dlBKcFJZOTJNTDdueXlDeFBkei9LTVpQS1NEN3pGaUlNZzNqYVVSQWxtc2Ev?=
 =?utf-8?B?em5tcGVHTlZFUzFya05lcjRzUEtBTVBoR3BGalNBOGJ4UStyczlROHhpUGpW?=
 =?utf-8?B?ZGdGdkhFNTVmRDdZMno2cjJ6Y21ZdXFKd09zYXU1amlXZy8zNm5GRWZNOFFu?=
 =?utf-8?B?YStTOUVGQ1NubWFMeDE4cGNpY2kyYzFzcHZJbnFxT09ySENIWkNFaWU4VjJT?=
 =?utf-8?B?c3JGRDA0WnNxdE15anAzaTFibEVWOGFtY3JOOTZlRExhNjNZR2V2bmxkMjc4?=
 =?utf-8?B?ZHNodEkyTG96M2FOVndxN2VGQ3hZc0JIQkM3YTAyUWl6ajhIUmR5TDkyQlpr?=
 =?utf-8?B?Yk02TVdvYXlnZ0V0WEhZMkM4ck1wdW5YcGpKK1ltWUNYdG9MbXdCblRST3Rh?=
 =?utf-8?B?cGg0VHNBd3lPakh4UGlFYlhxeld6dFYvL3BSTnNwVk1FTmpPSDlyWEdqTFVy?=
 =?utf-8?B?b0FmMzV3czRUVm9za3QzVUwxK0ZzbHFHNm95TmxiV0NOa3Irc1AvN1h6dCtU?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC9FD0F294BF642BAD5D0C949A1F648@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9081af-7139-4366-b745-08dac7009ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 11:57:43.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycl3/JWktkbcuRFT0IJwZ+NoowvB1VNcRnRSeEvlSWfy7fRGUlBIk983KJ8TS1SkrEbDJblE8VePRu6BBD5Bpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBIYW5zLA0KDQpHb3QgaXQsIHRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNCkJlc3QgUmVnYXJk
cw0KT24gVHVlLCAyMDIyLTExLTE1IGF0IDEyOjQ5ICswMTAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6
DQo+IEhpIElydWksDQo+IA0KPiBPbiAxMS8xNS8yMiAxMjo0MCwgSXJ1aSBXYW5nICjnjovnkZ4p
IHdyb3RlOg0KPiA+IERlYXIgSGFucywNCj4gPiANCj4gPiBHZW50bHkgcGluZyBmb3IgdGhpcyBw
YXRjaC4NCj4gPiBNYXkgSSBrbm93IHRoaXMgcGF0Y2ggY3VycmVudCBzdGF0dXM/IEl0IHNlZW1z
IGlzIHVuZGVyIHlvdXINCj4gPiByZXZpZXdpbmcNCj4gPiBzdGF0ZT8NCj4gDQo+IE1hdXJvIHdh
cyBvbiB2YWNhdGlvbiBsYXN0IHdlZWssIGJ1dCBoZSBzYWlkIHRoYXQgaGUgaG9wZXMgdG8gbWVy
Z2UNCj4gdGhlIHBlbmRpbmcgUFJzIHRvbW9ycm93LiBGaW5nZXJzIGNyb3NzZWQuLi4NCj4gDQo+
IFJlZ2FyZHMsDQo+IA0KPiAJSGFucw0KPiANCj4gPiANCj4gPiBUaGFua3MNCj4gPiBCZXN0IFJl
Z2FyZHMNCj4gPiANCj4gPiBPbiBNb24sIDIwMjItMDktMjYgYXQgMTc6MzUgKzA4MDAsIElydWkg
V2FuZyB3cm90ZToNCj4gPiA+IFRoZSBlbmNvZGVyIGRyaXZlciBzdXBwb3J0IGgyNjQgYmFzZWxp
bmUsIG1haW4sIGhpZ2ggZW5jb2Rlcg0KPiA+ID4gcHJvZmlsZSwgc2V0IG1hc2sgZm9yIFY0TDJf
Q0lEX01QRUdfVklERU9fSDI2NF9QUk9GSUxFIHRvIHNraXANCj4gPiA+IHRoZSB1bnN1cHBvcnRl
ZCBwcm9maWxlLg0KPiA+ID4gDQo+ID4gPiBnZXQgc3VwcG9ydGVkIGgyNjRfcHJvZmlsZSBieSBj
b21tYW5kOiB2NGwyLWN0bCAtZCAvZGV2L3ZpZGVvWCAtTA0KPiA+ID4gaDI2NF9wcm9maWxlIDB4
MDA5OTBhNmIgKG1lbnUpIDogbWluPTAgbWF4PTQgZGVmYXVsdD00IHZhbHVlPTQNCj4gPiA+ICAg
ICAgICAgMDogQmFzZWxpbmUNCj4gPiA+ICAgICAgICAgMjogTWFpbg0KPiA+ID4gICAgICAgICA0
OiBIaWdoDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IElydWkgV2FuZyA8aXJ1aS53YW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
bWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZW5jLmMgfCA1DQo+ID4gPiArKysrLQ0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L3Zjb2RlYy9tdGtfdmNvZGVjX2VuYy5jDQo+ID4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
bWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZW5jLmMNCj4gPiA+IGluZGV4IGQ4MTBhNzhkZGU1
MS4uZDY1ODAwYTNiODlkIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19lbmMuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19lbmMuYw0KPiA+ID4gQEAg
LTEzOTcsNyArMTM5NywxMCBAQCBpbnQgbXRrX3Zjb2RlY19lbmNfY3RybHNfc2V0dXAoc3RydWN0
DQo+ID4gPiBtdGtfdmNvZGVjX2N0eCAqY3R4KQ0KPiA+ID4gIDAsIFY0TDJfTVBFR19WSURFT19I
RUFERVJfTU9ERV9TRVBBUkFURSk7DQo+ID4gPiAgdjRsMl9jdHJsX25ld19zdGRfbWVudShoYW5k
bGVyLCBvcHMsDQo+ID4gPiBWNEwyX0NJRF9NUEVHX1ZJREVPX0gyNjRfUFJPRklMRSwNCj4gPiA+
ICBWNEwyX01QRUdfVklERU9fSDI2NF9QUk9GSUxFX0hJR0gsDQo+ID4gPiAtMCwgVjRMMl9NUEVH
X1ZJREVPX0gyNjRfUFJPRklMRV9ISUdIKTsNCj4gPiA+ICt+KCgxIDw8IFY0TDJfTVBFR19WSURF
T19IMjY0X1BST0ZJTEVfQkFTRUxJTkUpDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiArICAoMSA8
PCBWNEwyX01QRUdfVklERU9fSDI2NF9QUk9GSUxFX01BSU4pIHwNCj4gPiA+ICsgICgxIDw8IFY0
TDJfTVBFR19WSURFT19IMjY0X1BST0ZJTEVfSElHSCkpLA0KPiA+ID4gK1Y0TDJfTVBFR19WSURF
T19IMjY0X1BST0ZJTEVfSElHSCk7DQo+ID4gPiAgdjRsMl9jdHJsX25ld19zdGRfbWVudShoYW5k
bGVyLCBvcHMsDQo+ID4gPiBWNEwyX0NJRF9NUEVHX1ZJREVPX0gyNjRfTEVWRUwsDQo+ID4gPiAg
ICAgICAgIGgyNjRfbWF4X2xldmVsLA0KPiA+ID4gICAgICAgICAwLCBWNEwyX01QRUdfVklERU9f
SDI2NF9MRVZFTF80XzApOw0KPiA+IA0KPiA+ICoqKioqKioqKioqKiogTUVESUFURUsgQ29uZmlk
ZW50aWFsaXR5IE5vdGljZQ0KPiA+ICAqKioqKioqKioqKioqKioqKioqKg0KPiA+IFRoZSBpbmZv
cm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSAN
Cj4gPiBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZp
bGVnZWQsIG9yDQo+ID4gb3RoZXJ3aXNlDQo+ID4gZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRl
ciBhcHBsaWNhYmxlIGxhd3MuIEl0IGlzIGludGVuZGVkIHRvIGJlIA0KPiA+IGNvbnZleWVkIG9u
bHkgdG8gdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLA0KPiA+IGRpc3NlbWlu
YXRpb24sIA0KPiA+IGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5n
IG9mIHRoaXMgZS1tYWlsDQo+ID4gKGluY2x1ZGluZyBpdHMgDQo+ID4gYXR0YWNobWVudHMpIGJ5
IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kDQo+ID4g
bWF5IA0KPiA+IGJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGll
bnQgb2YgdGhpcyBlLW1haWwsDQo+ID4gb3IgYmVsaWV2ZQ0KPiA+ICANCj4gPiB0aGF0IHlvdSBo
YXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZQ0KPiA+
IHNlbmRlciANCj4gPiBpbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwpLCBk
ZWxldGUgYW55IGFuZCBhbGwgY29waWVzDQo+ID4gb2YgDQo+ID4gdGhpcyBlLW1haWwgKGluY2x1
ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBzeXN0ZW0sIGFuZCBkbw0KPiA+IG5vdA0K
PiA+IGRpc2Nsb3NlIHRoZSBjb250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJz
b24uIFRoYW5rIHlvdSENCj4gDQo+IA0K
