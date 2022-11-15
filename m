Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C66297A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiKOLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKOLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:40:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24FF7E;
        Tue, 15 Nov 2022 03:40:44 -0800 (PST)
X-UUID: 85f6cfd73b2a4689b12694290579717a-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ErDff+mm0cEzLBThBvnMEoBJbRAnus8ETCc1WZ8030o=;
        b=P+E9Dt2/hpc9DKsd6y2qaYaAf7tuQ3YOm3Q7UCkLJJSyDi362NYIVqBOZ9Z7vX5FMNp5dIb6k2AwKG5fN5/M2J2LvFQ9u3+/IdlcYGBTzvNEJPs/A4WK1WXlCIs9ARZUiCK1jMXkax76c/3B5D54wWPS9gzAw5j50oiX4yZCuVU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:8cfea785-ae49-4dc7-9d00-018d51d265a6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-4
X-CID-INFO: VERSION:1.1.12,REQID:8cfea785-ae49-4dc7-9d00-018d51d265a6,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-4
X-CID-META: VersionHash:62cd327,CLOUDID:4485beac-70f0-4e5b-83e6-c0b7915231c3,B
        ulkID:2211151940419HCCBVEU,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 85f6cfd73b2a4689b12694290579717a-20221115
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1870209918; Tue, 15 Nov 2022 19:40:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 15 Nov 2022 19:40:37 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 15 Nov 2022 19:40:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtl2Q+9UJmxgqZfJCPqLXUGlVxYVNrcZQEH+T+ZlD2i4K+qCcVKXK30mzssns7lUKXsmP2OrDh5zQJjA+TLCZAUbSaqwS1R1H0gOlKUQmHafaHRJAdsTGAIWJaWwIJt1N1uFFl4FwS2QxojiM/c8DGYkYDKyFPXiQXo0UDPzwFoHUEftOWTq2ID56sRytU9FgdAecn4wisVq5619Bvis3cJRnxTl7igxEPeqJG5O1vBW+/HI/IcDLwbqXFti/7Ln4J+fh2bya7ETaYIlMr6r6hWnXRbTN2p9henzuQ52K9U3Iyph3KVk0L6whA+FLxeZ/bzl+aPRJiqo3O1xNCqAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErDff+mm0cEzLBThBvnMEoBJbRAnus8ETCc1WZ8030o=;
 b=IJzN9dXQuTKV2EM6GWa5lheAL1YYOQsmqZoKZlcAGKkr+goBlYywhnMHtNVnKYb9V5f1hS2zsLRgjUVk3mP0WxirH/n7P0Dl7wKiKrvDxtqiET8hOJKz8S7k7h6OmShCTsVChWzfaQYz9Ez6HrnDQi5LJVq4D8r1q0VqPcQj31VUGIZjT+c593KcWU0xYdCExATyXs0RaxDgWrje+uENX/x/xF7Bcjxas0uX7cYvX5Qyg6EC8frfQHskDOay4gfx6rPDovA2M9WmrkE4sv6EpAjgZuXV+HccAWTtsek2OfY4SB0629HuJeuUwuPBSCdnC31QvcR8eyeaIFquKSAIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErDff+mm0cEzLBThBvnMEoBJbRAnus8ETCc1WZ8030o=;
 b=oYlXzdZ5wZ+CjwZF8BdZ3RqY/XVUuOeT3Y2jH/6GrXk48dYZGckvKE+h7tOzOixQENubH1d7/OnJiz1rVMUOLXcbA0s1saZUfNMIqFoAhsu8y8O2d+sPHssJW5kYaLxjhFtN2aIt0fA2xus5iJ2VOOMc5k11Jmmvf03X9fpTfTA=
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com (2603:1096:4:11::15) by
 PSAPR03MB5624.apcprd03.prod.outlook.com (2603:1096:301:4f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 11:40:35 +0000
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::e692:7d40:92d:8189]) by SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::e692:7d40:92d:8189%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 11:40:35 +0000
From:   =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
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
Thread-Index: AQHY0Yt90aIhXHa1+UymMqXbj3zHz65AKw4A
Date:   Tue, 15 Nov 2022 11:40:34 +0000
Message-ID: <a386f704b43b117d8857a7d7f51b1652ddb40663.camel@mediatek.com>
References: <20220926093501.26466-1-irui.wang@mediatek.com>
In-Reply-To: <20220926093501.26466-1-irui.wang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3035:EE_|PSAPR03MB5624:EE_
x-ms-office365-filtering-correlation-id: 9ae4adb3-32d6-45fb-b110-08dac6fe35a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khM1d1P5o1ZJx3kPIVQ73ndmjLOOGwAl8ILsH3PtItXiZ8tz9HPJPZnpKLr/h+ahpLm00qGBF+VLgGzj6LR5wTYRgG+UdaEkFMAlX1GeUhnShZozmTOICqKCTdIdkcf24p30m0BpbuhufgD4JQYXIsXuIO7dZDqFuhmB9Rb4WbHM6eZEDUzpt1LYwfaU88aV1132r+Y5jBPQ+PGvZx8ksTl0WNqHLmSFXjZ3M0zBy/Z4Y7QV+jAs9m9Z5m9I7L5Eu6XHxuquQ5IiCPRB1KGOpUBhaFFGH5p/udg+JA7lviYBYGWc70MISYOA895A7FkD/bD/jnS+6mMFLv8uyWSHThC3HZDqeL4m0zarxnu4i+3jyE3ufWOKRxnfm0s5Dy/KjYcvOB9+/Dwh1AEFsrPGUryMVDTuwDgKmPHZeeShFgd57m9Qe5dU6OaGSFghv2Aey2DaLyJXrnAACLt25ShbzvHHG6g2jrY0UCCgFtZyURzsAqeOiY2GbXP2UkLyRABqlkYlSz9AO+O6vvJDGPDHjpsOXaPfc5enigShEI8CnYKyJWM8IXJSDgoJg6XlvIhLZmEuMj5E+6HaVNwwzYgp11fYWOIDTLgn6HcdcqKnbG83uPrOlzRm7b2SSvcT86j8QfTEqaAiuWiOpn7MP8ZXsaHJ+zG/mXLpgfgonfqzIA5OuYzXbaK5hxFPvsO0xZ+cmDKSyughqJMNMbKB7iBU//y11pzax6y1awJH2THU9y3k6Q57y/m39lmW5ueNMdBUx8IF6Tj1HRm6NI5T02OcHulgFzWQ2gJFlMerHYwr+l4/i22OVKiMikfg3qm7zuiK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(86362001)(85182001)(36756003)(2906002)(38100700002)(122000001)(7416002)(8936002)(83380400001)(38070700005)(2616005)(186003)(54906003)(110136005)(316002)(5660300002)(478600001)(6486002)(66446008)(64756008)(8676002)(76116006)(66946007)(41300700001)(4326008)(6506007)(66556008)(26005)(71200400001)(6512007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzNoS3BRSkNKZ08wZmV4eXd0b3BTOEpDSkFBL25IYmxoUnF0cWtraExnSXps?=
 =?utf-8?B?Zm9aUVlxTVl4RVNkNktXRUJ5QWFPdVBBS3R6Zk04ODJSNTV2ZVN2Smhla0lo?=
 =?utf-8?B?WDZQSlJlVkhkTzVyaWs0eno2V01sRms3SUpIVFRhdTdOc1dBTkswaVN5dE5t?=
 =?utf-8?B?MzkwYVBoZ2JQdnNuNHlRSHd5dWFNWHR0bVZqc0N4bGNHZk5iT2VUNm1mSWRn?=
 =?utf-8?B?RU10NUdycWNPQ1NudWhCZWNxbkNFRmVhUVUrM3VkSnlmUys2RExXSlBTTXJ2?=
 =?utf-8?B?Sk8ybnBNWUVLL0FPRjE2TFMvbStWeXhUUmhGSU5QS084VGtnTnZPTXpxbTlh?=
 =?utf-8?B?Q2ZtRmJlVC9ZR05idmQwUEpqRkxMVnFUV2Q1bVlzSEpuMnFTaHBlSVU4SkJI?=
 =?utf-8?B?bGttWHp6NDZvVGg4MVFuSzVPN3N4amlqT3RqdWdjeWVVSmZkOTRNRTF6Y3V5?=
 =?utf-8?B?QXJ6bjFBVWtGV3FDamMwVWE1Wi84OTZZcElJeUpmR0hCNlpiaDZ6Ry9NSzNE?=
 =?utf-8?B?NWcvSTduSGJIQTQ1OUVsR3lUSTFGSTJHdyt3OEx1bHZ4VE9SdHBHUTlHK2Ur?=
 =?utf-8?B?bmZkaHQ1L3F5cnZKWlp3ZG93SUJIcFZMQURGSXZNd3F6MWE3QmJJakVNSDUz?=
 =?utf-8?B?ODlXK2l4aHRHUjNQdjhJYXc2d1hUVFN5Mjg1RUpNdzlxSG43bUx5bU80eWdj?=
 =?utf-8?B?bEtHTFVTSzRpdG5NZXVrRWdUTkNkY0xOWlVjYnBXN3ZhVWVTTW1rUkRPNkZV?=
 =?utf-8?B?c2x2V3orWTZvd2JaNFJ1bmF3U01Teml5R3B0RTh5dWtzTFNMZkxjb0M3T1ls?=
 =?utf-8?B?RStIVWVhMlBSOGJGRnYreVZzVENRMVg0RXdlckgvTEdjWGRvWXhKSzlLVE0z?=
 =?utf-8?B?R09DWW00WGR2UUNYUC9OSmVScFhtTlJ0eHlHNms2V3B0cjF3NlR1VlFFeU85?=
 =?utf-8?B?NTZNQXZ3N25JV1JQUmlzY2hRYXp2WXVjTmluOUhXMEgyNHRabUxrWEN0ZTZB?=
 =?utf-8?B?NHhYMExjSGdTNk45M3dQN0ZjSUZmZ0pEc2JaNm1ReWtMUitsamcvbGFVZ1d0?=
 =?utf-8?B?RVhhc3E5SVRiMzRSNi90MzhhM1RNVDBJMk4zaUV3WU9ZVXpUMjBUTWFiTFdT?=
 =?utf-8?B?ZWhFSFBYK1IyK1BOeWFvYVVFNE44dkFGbEtMMlJpWDl5b1o1SE81MjFhU05j?=
 =?utf-8?B?NlRQOHZwMVFRQWJrUUNqaEtockhZekJwazRaRGlDUTFYckgzS2hPRlRjR09n?=
 =?utf-8?B?clVkTUEwM1B1Z3NORGhET1A3Z01kbTZoekxTZEJwRWZ3Y3h5ZHFVeDJJWHE2?=
 =?utf-8?B?QTY5SFhmSXUwbERxNUZUYmRvNnFMK3Uwd2VQRWdlVW5mVmVhaWUwZDEwK3BW?=
 =?utf-8?B?bzFRSlh0Y3UxMjlmYjJQY2hsaW8xTGtkRDNyckpsUmV3aFM1OHpKZzJMcEc0?=
 =?utf-8?B?cTN3cE00bmRGZWlwZjJ4cHJVeWZhS0pEUHFWVW04L1ZKRU0rQVZLT1dJOVQ1?=
 =?utf-8?B?NWJ5NFZoRXZodkhrUml5b2pLbWtzZmNIYkthYWFRb2JiOFM3OGoxbGVidXph?=
 =?utf-8?B?ZDV1c1U4VmxGdGZLcnJRV0U2V1YyK2hTSjBmSnhPZnZmWW9GL2pqemlsRVVG?=
 =?utf-8?B?d21kSUxWR1RycmNDcEMrMWxpS1JwN0NtUDhCeGlsOGt6N003dXBobTRSTmN6?=
 =?utf-8?B?OXNRbzg1dHV0eUxYQnZ3c3RXRnVHZ1VkWkRrRWN2ME5Pak1PcHRMVFJBRFNY?=
 =?utf-8?B?eDVJdDBwV3RsVUc0QlZSKzNOTlpTd0RYMkN0MHBuTnpoRStia2NHRWZJbmNK?=
 =?utf-8?B?Y0plK2RyOWcrYkRQdVp4bVZrRHFGK1ZYWnAxaU5GSTdpWW1CYW9DTzRoenZJ?=
 =?utf-8?B?by8xWWQ5aElUZGlPeGxhWWl3bGZtL0ovc0EyWm5TMnU0QjhSWHlsUElXN3Qx?=
 =?utf-8?B?VU5EbVA1bzJEUlBaMlF2a3F2OTAwWWhlU2tpTlJvaktxUGUxaUU2OUM5M1gz?=
 =?utf-8?B?WG9TOWl3STA3MjA2SWxhMk5SUWtqOEU1ZXgzWEY3QjRNYVJOSWRVWCtDd3c1?=
 =?utf-8?B?U3lrNWpMQ0dpRDdKWWl1VVZnVDNqeVJNYUJMbHF0bmZHNXJuQnpoQjNYZ3lE?=
 =?utf-8?B?dUF0ZUhuVXpoTFJCWjZsM09RSVQ1cnBFdGs2aWlxZ255Tzg2YzdlWXF6OTEy?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DE58315C3E4C441A472E2477B17718B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae4adb3-32d6-45fb-b110-08dac6fe35a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 11:40:34.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8c6bvz9u4QPGAej8VO68ppmnfL8ajnFvhzIiNClkCVLlPT+EgWK05llFLUSUtFTVpC96pTaUk8rVIlBIgt3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBIYW5zLA0KDQpHZW50bHkgcGluZyBmb3IgdGhpcyBwYXRjaC4NCk1heSBJIGtub3cgdGhp
cyBwYXRjaCBjdXJyZW50IHN0YXR1cz8gSXQgc2VlbXMgaXMgdW5kZXIgeW91ciByZXZpZXdpbmcN
CnN0YXRlPw0KDQpUaGFua3MNCkJlc3QgUmVnYXJkcw0KDQpPbiBNb24sIDIwMjItMDktMjYgYXQg
MTc6MzUgKzA4MDAsIElydWkgV2FuZyB3cm90ZToNCj4gVGhlIGVuY29kZXIgZHJpdmVyIHN1cHBv
cnQgaDI2NCBiYXNlbGluZSwgbWFpbiwgaGlnaCBlbmNvZGVyDQo+IHByb2ZpbGUsIHNldCBtYXNr
IGZvciBWNEwyX0NJRF9NUEVHX1ZJREVPX0gyNjRfUFJPRklMRSB0byBza2lwDQo+IHRoZSB1bnN1
cHBvcnRlZCBwcm9maWxlLg0KPiANCj4gZ2V0IHN1cHBvcnRlZCBoMjY0X3Byb2ZpbGUgYnkgY29t
bWFuZDogdjRsMi1jdGwgLWQgL2Rldi92aWRlb1ggLUwNCj4gaDI2NF9wcm9maWxlIDB4MDA5OTBh
NmIgKG1lbnUpIDogbWluPTAgbWF4PTQgZGVmYXVsdD00IHZhbHVlPTQNCj4gICAgICAgICAwOiBC
YXNlbGluZQ0KPiAgICAgICAgIDI6IE1haW4NCj4gICAgICAgICA0OiBIaWdoDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBJcnVpIFdhbmcgPGlydWkud2FuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19lbmMuYyB8
IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zj
b2RlYy9tdGtfdmNvZGVjX2VuYy5jDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvbXRrX3Zjb2RlY19lbmMuYw0KPiBpbmRleCBkODEwYTc4ZGRlNTEuLmQ2NTgwMGEz
Yjg5ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29k
ZWMvbXRrX3Zjb2RlY19lbmMuYw0KPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2VuYy5jDQo+IEBAIC0xMzk3LDcgKzEzOTcsMTAgQEAgaW50
IG10a192Y29kZWNfZW5jX2N0cmxzX3NldHVwKHN0cnVjdA0KPiBtdGtfdmNvZGVjX2N0eCAqY3R4
KQ0KPiAgCQkJMCwgVjRMMl9NUEVHX1ZJREVPX0hFQURFUl9NT0RFX1NFUEFSQVRFKTsNCj4gIAl2
NGwyX2N0cmxfbmV3X3N0ZF9tZW51KGhhbmRsZXIsIG9wcywNCj4gVjRMMl9DSURfTVBFR19WSURF
T19IMjY0X1BST0ZJTEUsDQo+ICAJCQlWNEwyX01QRUdfVklERU9fSDI2NF9QUk9GSUxFX0hJR0gs
DQo+IC0JCQkwLCBWNEwyX01QRUdfVklERU9fSDI2NF9QUk9GSUxFX0hJR0gpOw0KPiArCQkJfigo
MSA8PCBWNEwyX01QRUdfVklERU9fSDI2NF9QUk9GSUxFX0JBU0VMSU5FKQ0KPiB8DQo+ICsJCQkg
ICgxIDw8IFY0TDJfTVBFR19WSURFT19IMjY0X1BST0ZJTEVfTUFJTikgfA0KPiArCQkJICAoMSA8
PCBWNEwyX01QRUdfVklERU9fSDI2NF9QUk9GSUxFX0hJR0gpKSwNCj4gKwkJCVY0TDJfTVBFR19W
SURFT19IMjY0X1BST0ZJTEVfSElHSCk7DQo+ICAJdjRsMl9jdHJsX25ld19zdGRfbWVudShoYW5k
bGVyLCBvcHMsDQo+IFY0TDJfQ0lEX01QRUdfVklERU9fSDI2NF9MRVZFTCwNCj4gIAkJCSAgICAg
ICBoMjY0X21heF9sZXZlbCwNCj4gIAkJCSAgICAgICAwLCBWNEwyX01QRUdfVklERU9fSDI2NF9M
RVZFTF80XzApOw0K
