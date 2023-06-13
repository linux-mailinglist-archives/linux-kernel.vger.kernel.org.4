Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DEF72DD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbjFMJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbjFMJFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:05:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F64B18E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:05:13 -0700 (PDT)
X-UUID: 658cfd3e09c911ee9cb5633481061a41-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CJIkLLAZOjCJHY/uYc5la/0If6dpqnboO2TOr/HMzic=;
        b=p1fVsT9KejW1Pdf2FAxNuCA57s+QuyqIvGh8uBFyiOYQ1tu8j9Qjx4TB24zmiTBUnOFZQONiWfiH+OsLJ6eAyxKbQFp2dGyw5hYt4aYbKSqagXLbxyCUo/E+rVQx3Leqv+Snsfeg+7sy5V8CJyYr+X0cTfAz+G6ZeRVNtRA2AhU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:99677155-b76a-4ef7-bcc5-a07a6e2714ae,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:5878773e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 658cfd3e09c911ee9cb5633481061a41-20230613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2114330623; Tue, 13 Jun 2023 17:05:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 17:05:07 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 17:05:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQf0hKk7cg3c1S6wYu3f5H5RXOtGS3WspFi58kTTwJcBuXOSTgv6vGzyoyB2sQ0PRw0vHvXm/3tzFVNfwuXbafNV7m7acONUYI5/D5SQPkuxYK/k6CMjlVUkXIj/PLgHLAxgcLOGItV7rJuTeHkNSSJpPzykONJZQIviFNSqZqTH6xSo0DnQ848gXTkZiH9ZVwBHeY8eG+ZK1Lk6W/nPQnWMmT49Z+aAABKmIInd617kBgftSDDKWue2P7rTGzfY521p6uVNIRhFVmCkltogYP5EPH5Mc4i/PRCgr2CnIpIPmHOvY6G+CVgXfUJPrAFpvz6Dws0ZfT91ON+G3KS4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJIkLLAZOjCJHY/uYc5la/0If6dpqnboO2TOr/HMzic=;
 b=Gv45TkzpN/GnalNwAC5/Mf8rxZfE8Dw77Pp5BxYeiJuCfIPxCb1sfZj7VUyNwA3nu6qvSI43RcHY2m9FeAfnexpHPyLlJCYVRNDZtJ1jcQemAXUSF21vDhrBKhHKlOrrtoybP7UrwaYrfjXp/7Hxj+Rnv1J0Bu7CqclLa34I/7MJWMYdooqnEVccwwDFcMG9KJJDuJXVL+moHbOi0GfqBy4FEZ9cr+VkHp0ER8B6dYc2rxIxjZPP0huwEmMApqVayBl5c4aqiw9nIwTC5jNtDYwbUBaTaV51XVYpGp7F1tjlERkStaEqApCdA7WBaEQ6HQLqNRXLr6fnkysrVofXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJIkLLAZOjCJHY/uYc5la/0If6dpqnboO2TOr/HMzic=;
 b=ETtpcWRYitez4a0H9pDXUgVTWFHtxoUgmCIjUbFLcd9pX5PM1NbSSGs/65jUQxKTA+Vv60+eYrug/suRX66ifXWa8tOXiH0NfsNSdwQ24pWRfOYIu3TvR+FPCwBk98GPf6WzB31CAG3FupYlnB03lt7epB6+tddq4A0L1HXdUjc=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7700.apcprd03.prod.outlook.com (2603:1096:101:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 09:05:04 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 09:05:03 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 5/5] drm/mediatek: Fix dereference before null check
Thread-Topic: [PATCH 5/5] drm/mediatek: Fix dereference before null check
Thread-Index: AQHZaRzWyNMPt/8yTUOH0HbKt5Eh2K+HSUoAgAGQw4A=
Date:   Tue, 13 Jun 2023 09:05:03 +0000
Message-ID: <137bc2a57c0eaeac7228fd3d1e1bb1fb126fe234.camel@mediatek.com>
References: <20230407064657.12350-1-jason-jh.lin@mediatek.com>
         <20230407064657.12350-6-jason-jh.lin@mediatek.com>
         <4ea5f2579f802e886eab057cc2635e91766ac45a.camel@mediatek.com>
In-Reply-To: <4ea5f2579f802e886eab057cc2635e91766ac45a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7700:EE_
x-ms-office365-filtering-correlation-id: 1da5857c-6388-4f11-adbe-08db6bed469b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L5b0LvI5YdOx6q5tsox7RfDiZ8U5mVBcQd2/aTz+0PijNGBdxgNKJChaboZ2d8QFIHstO6qf0gk7Edrd8E1qbQkEwKiGwZJ4cAWeVllAVq2JHkzAThggEh8PDkmsGJRPYammnVtx6QRF1wm5GQCsHiDgqg5m2hRIkzTBfimvxPMrA+llVNWC6v+XqqfIE5eS4W/O6GFqtsHGu+J5mY5kE3DxnCauD4XsDTZKRoa+x9innkzIOWVqHP14L0wwSJ8SczGskNheZhLCVgED7JqlMkCaBSd8HotmDnJLl4sfP6dRCZav1ofPPzr1b3qOZHCQzo/hnx8vXKImpK5Hzy2mJ8QoIPxW+0pZBWTeo+R3ZlUoQovOioAuAAQERoxhl5kDbTdxgDDZ2CGnHmWNHDGwajhDbzrAEVjDEbFwQYI77npkd8o4XNao6w+tv3ZwGWRRh/XJc5UMillS+OX8IIlLvELlZfwfir+BpgJtY8v6jFzU8ggxFC0Hx4XvN4xt/Zd+xY8qJFBx3x9bxewi8sJnf6d3W6gmsmyL/YdopfxUve2UuJt7j/jAS4KS98g/XB+P40uCzi6cqRfc1jDskBOU9G/RjS25nVlGW0NwCXfL0OIpWrNfOYs7AX8LxYzsLZ8D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(66946007)(66476007)(66556008)(76116006)(54906003)(110136005)(478600001)(91956017)(36756003)(5660300002)(8936002)(64756008)(66446008)(85182001)(4326008)(71200400001)(8676002)(41300700001)(6486002)(316002)(38100700002)(122000001)(107886003)(186003)(6512007)(26005)(6506007)(2906002)(2616005)(38070700005)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTlPbjFiOFg2SlpYdUF3Y3JhOHZQbGZnTjNsNGN3c3dENVNwRkV3ZzRDUmdj?=
 =?utf-8?B?ek5uZFloSXdJQU1pU2pzQ3dNeTJIcVdmdEZUdGhyQkpTd2Z5b3BsNkkvVHNj?=
 =?utf-8?B?MmFzcERTYTBEZDZQRVBmd2FiWk8vbkRXS0RZMTFlNEJPTjlnQmhnaWhJN3Z5?=
 =?utf-8?B?dG9HYk1jY2ZncmJWdkZ0N2lNZ1c2TWlvdEhTRWZtUGpyUVZMK0VkcTUrdXNJ?=
 =?utf-8?B?eFBhSDNZZHhDay95SUtLeW93M1RoRmNlVVZlMjJaN0orTEdKNU11V3pYSHFi?=
 =?utf-8?B?RGZQUlFJNGhTbXlOVk1ZT1B3M29wdUZjMklvbnRyTlpwZGlaNC9XRFlWVzNE?=
 =?utf-8?B?NjE3aVRaZXhzbUV6ZHI3U00weVg2dURrQkptNXJ4eU9VNVcxb2lUWFp5MFZ2?=
 =?utf-8?B?c3V3T3Y0NzBoeHgra1Zad0lGd3VOUzgydmt0b3VwY09XMy9WeXpiYjVITUxY?=
 =?utf-8?B?ZEUyM3FuV1h6MTE1djZ1a2dRUFA3QndERjNmeWtadEN5dHRqSnpkbzdTbVRL?=
 =?utf-8?B?WmNyRmFWcVlQY2hnWnFydjZKaFVuYnBTSHRNbzV2YmtrTVFtbEhUT0FMcDdS?=
 =?utf-8?B?NUFpdlJ0dHBZOWp5QWhiRi9hSXZqN3JDcUsrd3dGWUxDOUhnMmxnTVB6c1JH?=
 =?utf-8?B?UEdWUXpoenJlOTA5RG5HQTZ4dUdVOUFvV3VzaVowNHVIZFl5aEgzM3BjbUZ1?=
 =?utf-8?B?c1o5VzY5UGkwc1hSVHB6WUU5ajY5V1ZjcHVNVy82Y0hOa05DNUN1cG1EMkRv?=
 =?utf-8?B?NmxSeVFIUUxpRnJMK2c2dFF5L2d4bFgxVmJpMUNWNS9IQmdNWkNNSkFLOG5G?=
 =?utf-8?B?bFB5NkFtZk5jYWN0NTNPdkxiLzhPSCtJbTV1bEl0MDY0ZUdqQW5sTzJIVHJk?=
 =?utf-8?B?YXdXOVhYTDI0SGhpL0JJWWptMURVTUVwektFQ2RKV3NYNmtBRnhjakQ3UG4x?=
 =?utf-8?B?dGdWQUIrN2NDWXBHd21OUVN5bEVEK0IzcXR1WWVzUm1SSTB4SHR1TDMzY1di?=
 =?utf-8?B?V2dsNFVjWmtpTzJINnBORjdnSW5nRlJsSDNpTzlXSlRoVDdidk11VmNtRGNP?=
 =?utf-8?B?dWRLa1MrTkJNQXRHbnpLZHR6aU9ibTlTRnhsMXd5enVkUnE2M2g2R2VFdkZ1?=
 =?utf-8?B?d0VWbXRhejZoS056djg5WTAyNHlBM2xqdVk3QUhxc2p2aGk2TFlleHdBQ0Ja?=
 =?utf-8?B?RXlPRWFEc1NPSTdlLzY5Y0U3N3F4STJxcG9vLzhob2hqL1hGUzY2b0NwZSsw?=
 =?utf-8?B?S0QxSC9PRE1yZjV4NE1KMHBmMkxjM3ViV0MzUlJnbjI5MkhRcFdYNDk4aXhu?=
 =?utf-8?B?MXBGbFdoUGNWb2VsSG1VcG1jV3M0OE5hNTNSRUFpRTNwVTY5ZWVzM2RRdzU0?=
 =?utf-8?B?SFJZNDVYbnBmT2tURHFLcFJTU29QeVMxdnhwdllvOWlIQWlRVHoxUG4vVlpO?=
 =?utf-8?B?b2dVVXNPelNqeDFyVi9LSTg3SkhDNXVsVFc4SzZtd0FsWmxrWlNsK1BQbWNk?=
 =?utf-8?B?VnpGOW5GVnlNaUowRmxXZVBvSlZlKy9tREJiSHJKVk44N2lQRHF5ckJ1Sk91?=
 =?utf-8?B?RXFKRHF0SWh3OHBIZlBDSHZMM2dLV0FTWnJ1NnlDdFVoSWQwVHc5ZFVqOXJu?=
 =?utf-8?B?alpJbEJTS05GRllsUjZucUlZVkJlWnlJL2xZdmhqUzZIVThtakRXNlZaUjFz?=
 =?utf-8?B?VzNXNGF0VlgwbUZMRGxEUlRUUDlZaU4wMHk1NGdTZmMvb1ZJRWl5QzMzWUlh?=
 =?utf-8?B?bTgzclJTaXp1bkR3dHloSGtRSnZKdzl3TXJhVXhLTXUzME9HWVJhbFBkVW91?=
 =?utf-8?B?NHNNYjdBbkNXV1oxMHVXWjlnVmhkL0gvc2hFRElUeTBlNU1uUEw4emxLZlVp?=
 =?utf-8?B?YmxyZmJ1eGtRbCs1aEZkTnpPVW1NcVcyYWVHVnpLclJpQTk0QlJUS2VRUDBV?=
 =?utf-8?B?bjdnNGRvL1lJbWxjSEdBVHdTY3BONUozZjRCZG9hY3JBQ0dsanR0MTZnaHY0?=
 =?utf-8?B?UTZzTGZPaVJZZng4ZTJMZ2NNTmRhMmlEZFl0c2lRRnpFK0dzZnhoaHV6WG1l?=
 =?utf-8?B?TDI4V3FJMGVKN21DaDVOQVFTcWkvdysrMmNHSEEycFF4UEZJcUlCVXlrNmNC?=
 =?utf-8?B?YVBvWVJicUxvMjNMWVh3ZFJOZHR0Z210c3M0ejZzZWNlMEw0MlBYUXVVZE44?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CF222A45BDB564EB8B96532088DB07E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da5857c-6388-4f11-adbe-08db6bed469b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 09:05:03.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0kPD6oARQJMg1gmBOU9Xl7Y0kFTCV4u6lLq4bcgznRa9CKRNF3WTYdvjFEJUR1fohKAt1oXqRa9/0pOiD6sOnnm76YP4gFmJURUqVmaaVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMy0wNi0xMiBh
dCAwOToxMCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0wNC0wNyBhdCAxNDo0NiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IE51bGwtY2hlY2tpbmcgc3RhdGUgc3VnZ2VzdHMgdGhhdCBpdCBtYXkgYmUgbnVsbCwg
YnV0IGl0IGhhcw0KPiA+IGFscmVhZHkNCj4gPiBiZWVuIGRlcmVmZXJlbmNlZCBvbiBkcm1fYXRv
bWljX2dldF9uZXdfcGxhbmVfc3RhdGUoc3RhdGUsIHBsYW5lKS4NCj4gPiANCj4gPiBUaGUgcGFy
YW1ldGVyIHN0YXRlIHdpbGwgbmV2ZXIgYmUgTlVMTCBjdXJyZW50bHksIHNvIGp1c3QgcmVtb3Zl
DQo+ID4gdGhlDQo+ID4gc3RhdGUgaXMgTlVMTCBmbG93IGluIHRoaXMgZnVuY3Rpb24uDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsu
Y29tPg0KPiA+IEZpeGVzOiA1ZGRiMGJkNGRkYzMgKCJkcm0vYXRvbWljOiBQYXNzIHRoZSBmdWxs
IHN0YXRlIHRvIHBsYW5lcw0KPiA+IGFzeW5jDQo+ID4gYXRvbWljIGNoZWNrIGFuZCB1cGRhdGUi
KQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5j
IHwgOSArKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fcGxhbmUuYw0KPiA+IGluZGV4IGExMzM3ZjM4NmJiZi4uZTE0YjI5MjBkMjQyIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ID4gQEAgLTEw
Myw4ICsxMDMsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX3BsYW5lX2Rlc3Ryb3lfc3RhdGUoc3Ry
dWN0DQo+ID4gZHJtX3BsYW5lICpwbGFuZSwNCj4gPiAgc3RhdGljIGludCBtdGtfcGxhbmVfYXRv
bWljX2FzeW5jX2NoZWNrKHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAJCQkJCXN0cnVj
dCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkNCj4gPiAgew0KPiA+IC0Jc3RydWN0IGRybV9wbGFu
ZV9zdGF0ZSAqbmV3X3BsYW5lX3N0YXRlID0NCj4gPiBkcm1fYXRvbWljX2dldF9uZXdfcGxhbmVf
c3RhdGUoc3RhdGUsDQo+ID4gLQkJCQkJCQkJCQ0KPiA+IAkgcGxhbmUpOw0KPiA+ICsJc3RydWN0
IGRybV9wbGFuZV9zdGF0ZSAqbmV3X3BsYW5lX3N0YXRlID0NCj4gPiBkcm1fYXRvbWljX2dldF9u
ZXdfcGxhbmVfc3RhdGUoc3RhdGUsIHBsYW5lKTsNCj4gDQo+IFRoaXMgaXMgbm90IHJlbGF0ZWQg
dG8gdGhpcyBwYXRjaCwgc28gbW92ZSB0byBhbm90aGVyIHBhdGNoLg0KPiANCj4gUmVnYXJkcywN
Cj4gQ0sNCg0KT0ssIEknbGwgZHJvcCB0aGUgbW9kaWZpY2F0aW9uIGhlcmUuDQoNClJlZ2FyZHMs
DQpKYXNvbi1KSC5MaW4NCj4gDQo+ID4gIAlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKmNydGNfc3Rh
dGU7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+ICANCj4gPiBAQCAtMTIyLDExICsxMjEsNyBAQCBzdGF0
aWMgaW50IG10a19wbGFuZV9hdG9taWNfYXN5bmNfY2hlY2soc3RydWN0DQo+ID4gZHJtX3BsYW5l
ICpwbGFuZSwNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4g
LQlpZiAoc3RhdGUpDQo+ID4gLQkJY3J0Y19zdGF0ZSA9IGRybV9hdG9taWNfZ2V0X2V4aXN0aW5n
X2NydGNfc3RhdGUoc3RhdGUsDQo+ID4gLQkJCQkJCQkJbmV3X3BsYQ0KPiA+IG5lX3N0YXRlLT5j
cnRjKTsNCj4gPiAtCWVsc2UgLyogU3BlY2lhbCBjYXNlIGZvciBhc3luY2hyb25vdXMgY3Vyc29y
IHVwZGF0ZXMuICovDQo+ID4gLQkJY3J0Y19zdGF0ZSA9IG5ld19wbGFuZV9zdGF0ZS0+Y3J0Yy0+
c3RhdGU7DQo+ID4gKwljcnRjX3N0YXRlID0gZHJtX2F0b21pY19nZXRfZXhpc3RpbmdfY3J0Y19z
dGF0ZShzdGF0ZSwNCj4gPiBuZXdfcGxhbmVfc3RhdGUtPmNydGMpOw0KPiA+ICANCj4gPiAgCXJl
dHVybiBkcm1fYXRvbWljX2hlbHBlcl9jaGVja19wbGFuZV9zdGF0ZShwbGFuZS0+c3RhdGUsDQo+
ID4gY3J0Y19zdGF0ZSwNCj4gPiAgCQkJCQkJICAgRFJNX1BMQU5FX05PX1NDQUxJTkcNCj4gPiAs
DQo=
