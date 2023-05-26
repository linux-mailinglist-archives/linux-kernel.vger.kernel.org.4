Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD271225E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbjEZIhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbjEZIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:37:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990EE7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:37:47 -0700 (PDT)
X-UUID: 9439d51cfba011edb20a276fd37b9834-20230526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1ptd85qkUeN8KW/MW6qskCLj/CKTWlpwlFo+NaXSJc0=;
        b=rIh37OdsLzE1xha0DzV91fIRO3SYHjTZLa2JFF4GeSUnljSKyLxeRMA9fpvpFJ2R6Bjs1lALOAv4G3lUGtLEWkcjiey0vzhQzMR7jQDPU09SqvWyJp7iRulzNPYIu4b6HwsxWwncDOoR1YWkfHsBTFxvAQlmvCc/jd5otEjd3SM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:5c63e002-f89c-43b8-9b38-56c62f5789dc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:8530733c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 9439d51cfba011edb20a276fd37b9834-20230526
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1890305124; Fri, 26 May 2023 16:37:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 16:37:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 16:37:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBYnwkWcg9CuZIve/XPYYxBh21hymgkrz2nxBUrvLg16b2IKfzKwp0uE+v9hz35pC3Sojy0zWQsD5tz9oygH8Crdg0s7iKvKoc74AxPUDjCARZMOfS5Jbp6ozuh/NVKpVozhX2ai8/LsgQzLJA/kQnm7QRxLFE8j1irHW5iziBEk5FYrUKaSpmAkIxNVFuDkfgeSNbzlFXilFfB8XlWsrX8YYKdW7zfA6j55QyfpAWFGwSpDHKJCjAZUFYq1/mobFUJtJqvd7oDJBphIMP4mrvrz3VRvFK5/uKPk1CmZRUbOxdMk55bHmXFYlOXYcI6uZf5Il2NImkmRm6sx8Nfhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ptd85qkUeN8KW/MW6qskCLj/CKTWlpwlFo+NaXSJc0=;
 b=dDWMF1AdGA9AM0HdgWVnYDqZfw+o2f2YUq+hgF5YCyJ0jToDTitWgNaSsp2A3dglE10+TEE7vYQ8GN0paBBkYZb4yrYqfPoANBLUDWazvkhLsSrsm2WmRPhAIzW2qEsaKMtchXcec07r2mUjVslfQp6jB7X5gpVOJPn2UaSQ1DU7Mywv+205yehj8W4M5Q4LdQh5T7zr7ZSMy+Rb35MdWVKk+h7yu9SplIHZ/aSzPMiK/ylAZZRNyqXuSg6yd95PLh2qUWGTZAUxnIrRnoPAo+cKJeJvHXQGtgkFS46+VeDwA0B1Dm9+r9wHMa3ExKfY93Wd+QQzWZlkuucGFKRDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ptd85qkUeN8KW/MW6qskCLj/CKTWlpwlFo+NaXSJc0=;
 b=hGqYmqmB3kIioHeI3TETDKErTzHkedfAx/C++f1xFbmOmAgVUKGlCdHyeudinHtu5Jhc1KJLElb9MRU+JFGRLZWJF44VUp+fu0F66QTsklovGx1aOlfd85wvPNceWmZBanzTBLMq6jmNa+KXRt+nF60YqPJm/oWoI81gu8InnOs=
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com (2603:1096:4:142::9) by
 SEYPR03MB7700.apcprd03.prod.outlook.com (2603:1096:101:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 08:37:35 +0000
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458]) by SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458%6]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 08:37:35 +0000
From:   =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>
To:     "daniel@makrotopia.org" <daniel@makrotopia.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "vincent@systemli.org" <vincent@systemli.org>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?Q2hlbiBaaG9uZyAo6ZKf6L6wKQ==?= <Chen.Zhong@mediatek.com>,
        "error27@gmail.com" <error27@gmail.com>
Subject: Re: [PATCH v2 4/4] cpufreq: mediatek: Raise proc and sram max voltage
 for MT7622/7623
Thread-Topic: [PATCH v2 4/4] cpufreq: mediatek: Raise proc and sram max
 voltage for MT7622/7623
Thread-Index: AQHZXjkW4Q3uqsjo4k+WdVF9MbgoKa9m8tgAgAFeTYCAACz2AIAA6CqAgAAU6gCAAELGAIAC3WWAgAAC1gA=
Date:   Fri, 26 May 2023 08:37:35 +0000
Message-ID: <2fdc8825eeadd0f440b98e2bd9523fba902f8f0b.camel@mediatek.com>
References: <20230324101130.14053-1-jia-wei.chang@mediatek.com>
         <20230324101130.14053-5-jia-wei.chang@mediatek.com>
         <ZGuuVPCqgpUO6p0Q@makrotopia.org>
         <a1793745-eae3-cae5-49fc-2e75fe0847f0@collabora.com>
         <ZGz55oEEAhlWZajK@makrotopia.org>
         <3054e2d9-7f77-a22a-293d-382f19494079@collabora.com>
         <4e5a8202f7446481def19e5926d1bfd6e6568dd7.camel@mediatek.com>
         <ZG4GNpxdbZ4TNq3K@makrotopia.org>
         <5dc13e13143aaffc4477fb9dcf565070cf1a9822.camel@mediatek.com>
In-Reply-To: <5dc13e13143aaffc4477fb9dcf565070cf1a9822.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5830:EE_|SEYPR03MB7700:EE_
x-ms-office365-filtering-correlation-id: 77c76d59-ba12-4655-517f-08db5dc474aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x//6UOe7azmPHuQTRVVJKPLhqkU4L3x4vPkYjI/fAvRWp/svh8P3vLOXumes2MjB1aPVlS554M7DBeI+HMxfT/jVH5rW83mraXjEQqhgD9VX8Q7yhPY/eE2t+cc8OilcQkkqt84IEftmgMm+LVXq6ZvEtDzIzpdG/T9baV5KA9KgJHCdUE4AdClLxA6ebKKDCKENQbo3jx+2w1/9Fr4ApPqemgvxQy/p9i0uP/6cgVvSElmie98WBIFx85fkuz6QHPjZ+vXSSpwsQWF9CNrOYf3alv7alG6yT5WAnc2xLbbXSF6xt3CoTgqlzItZkAqfI41a0Cz4IKCC1ZACnQ9dW9KfrQ1774lVVug33uKxHemXv2qy8/l9CgxTzhzkoDuTYVEd7R0Dfb7ASBEzmOPS6wN4SIi4O+aTxz6haRWz0wYyc1lc4KEY8ge5BxPS4IGmD3FFglGa6XTmqHBDeieIMSgt8wOIHT2xUVGbQD3qxWR4NCuklvxJxSmHx06PXUxCOcV0qFkZy2RJFkB28edIcHj+7bgqvGgaEtjTxUHUVC6oXCJaIG1KCvEfCopykJJ1dEBUGje0Ccvxud/hovRCKeapzaj0dplJ3L+uL5B4CPt2mt62GAiEN7HR+spFPCbp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5830.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(66476007)(76116006)(66946007)(66556008)(64756008)(6916009)(66446008)(4326008)(85182001)(8936002)(7416002)(8676002)(36756003)(5660300002)(91956017)(71200400001)(54906003)(316002)(478600001)(41300700001)(6486002)(122000001)(38100700002)(6512007)(30864003)(83380400001)(38070700005)(26005)(2906002)(186003)(6506007)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VStmK25DL1RST2ZhTWx6bDZmQTUrcXBwcHg0VmhZakQwdmF3TTF1SkM1eHUw?=
 =?utf-8?B?SFJpNGhDeHpQalh2dUwwQnc2V3JHeXVrc0czVVdqQm1SS29QVldncHY4OTVw?=
 =?utf-8?B?R2dnblZScWxYTkt4bzJITUtPSWU4c1JEMUo0YWVTSWh2OUJIcEhXeGFQZ2xq?=
 =?utf-8?B?YWhSWEI2dGVFR3NhbDJocjlGdTczNjdvZmtvN2x5QWFZNmFkNlMxamhOMTE0?=
 =?utf-8?B?VWVqSEJrWSt6M2psQnUvZlpJaGR0eDdSd2YrUFJJajc4UXVycjhxYmJwK2Q1?=
 =?utf-8?B?a3FlQ0NtZ2taaFBiYmdxUDBUdlE5TlRxTkJobjkwY0dNbVRLemd0WVgwZTk3?=
 =?utf-8?B?KzV3K3A4TTB6Zk5rd3dXdWwwQ1NNRmI0UERYSlRjSWRpSUtNTXFON215WUtO?=
 =?utf-8?B?QnVQcTRLZURvUjRzSnB3TWY3WVFCUmFITXc3Q0JMMkxpYnB5aU5KUDJlY2Nq?=
 =?utf-8?B?U0ZlLzR2SnBOSWw1ZHhpQlpoMUxuUGVQeXBmNVl3Nldhd3RVU2xRb0R6azI4?=
 =?utf-8?B?eHplMlF1cGkxam1GS1dXd2Y5eU9iSUgvdkhySDl5bmc3T2F2Y1RnaWoyc3Vm?=
 =?utf-8?B?V2VEcDloTTFhaWJXb2dVUnFhK0lWTVBwNlA2RjY2RWhrckdqSkFaUDhvNVJv?=
 =?utf-8?B?bE92K0NWQVpScW5Tam4zbDg5NXFYVFE0S2hHVHN0VElISWsyNlBGQU80VmZV?=
 =?utf-8?B?RnVPQ1ByM2R3R0UvMzI2Sys0dXZSbG5qVzNhTzlSdkM4S1h4Sk8vay9iWEZl?=
 =?utf-8?B?WFRRcUg3T2wwOTJzY0dBMTNoSnJ5MktPRmcwNVNCbnA3Y3ltRjBRbHNzV05K?=
 =?utf-8?B?b0tCazhReVo3OTlGVTVIWWs1SnJINXN1cTF3QWsvQ1NVeGhad2xsQVJFandM?=
 =?utf-8?B?SFJma3NhdndaSFgyVU1PRFJSWmRRdndqbm9UQkZjODErSzZvRjBGa3I5VmMw?=
 =?utf-8?B?TnJRdk1GM3E3ZVlzMTgxcm16bk5IazdFVkdlVDQwdzdmbjhtY2hsMTUyYUw4?=
 =?utf-8?B?Tys2czljYXpscEF5V3kyQVpMZVR4SEl1WUQ1b0hzNzAybmZNUmtTRSsxTEtP?=
 =?utf-8?B?eHBDdWwzdkcxaForOUVGdmhlMlRiOGtHdmM1Z0tuLzQvYUhNanpiQzlsYk9Z?=
 =?utf-8?B?ZFh2NllYSG9tY0gzRVJmREw0RzhweHhLMHJFL25nTGlNSTZGL0ZQQ1RJOVl4?=
 =?utf-8?B?L0hnMWovOSt0YlV0QkJ4MHZQa3VYZDBTTldWSGw3ZVY4QjlOdXRkUURyU2Ri?=
 =?utf-8?B?UzlTWVJOcDhuWWxUYjZWcXM0anhLcnRmemtCdElxVUJtMkVlRmRBUEM5SVhs?=
 =?utf-8?B?WnEwRzcxS0tBb20zUVAwdUpiZ3M3eWp0cmpTbnVSeEtFcEJrdW51c2orQThO?=
 =?utf-8?B?RTVlSS9ldHl5MUNEUVJZUThYa2pYNitHTjFzQk54Z20rT2VaNmVXK0Q2dHVw?=
 =?utf-8?B?RUpVcDhiYWoxK3U4QXRoYW1McFRlck1jQXhMYTc5akFiYk44MG15UGc2VlZZ?=
 =?utf-8?B?TTdoRzllVGlxQTdWVzh5RXlKOEpIdG0wZnBuZHJRMXBldWxzV3JCZVlpbXNB?=
 =?utf-8?B?Rlg4TTZTeks2Vi9pc0cwVEdxck1mWHJMWVpBUytDWWdpWWg2VCsvSkFaTk53?=
 =?utf-8?B?QUVyS1kvNXNTZEFaVEhlalorTGE5UnYwNEFiT2p0NjNjZFQ1S0hYb0xQMVoz?=
 =?utf-8?B?RHdYdGYzVXhFRTRzWkpEVmJib3g4NmNXeGxSZUZONi9mZUowYmJJV0JqZnhG?=
 =?utf-8?B?VE9rVGJPZzJSN3YwL0d4ZVc0R2FyUEVYYjBDRmQxYnBXSGU2MjJaVjgxSEdW?=
 =?utf-8?B?SGtsUTNla2xGQ1A0T01qbnBDVTFhbU9BbUNUTHVoOC9MMkJhVlRObFdxcEpK?=
 =?utf-8?B?VnRyUE15cEQvdjJtL0IvRHRIdlI2REFqOUVLT2JZSjhkSUJWaERhWjRPcFZ6?=
 =?utf-8?B?dGlTYjVhcW1FZTRMQzlGTlp6Qk5iQ1FzTlVXN1Y3Rm5NSStzaHEvZURkaFRD?=
 =?utf-8?B?aHI3QXZxTjRrc0JCZGhDVlZ0dy9TRHpOR2pCVjZ3SVlhNU5Zck9CMU5abHFN?=
 =?utf-8?B?cUJHcENEcTZBSkNSMVBkdVVWRFFwSFRjRGFOaXVBQk5CTzRiaGZ0dkZDWnBM?=
 =?utf-8?B?allNYk5MRUNCTUl0ZlkwbTVDWVMvdXZLRXkxSFZQODFJeG90ODF0TUd2cjJn?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB7D233177CEDF4592126D22D01CD877@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c76d59-ba12-4655-517f-08db5dc474aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 08:37:35.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fAyE+SZBERq4gXFNWMB/CRWBrX8AitrZK0oPfX9WBO2DPv5zfxKW66CCX8Ox/yQnd7mGpTMs98XW48uz+4t8J4W+bo0qZvkA3rWdzHiHpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTI2IGF0IDE2OjI3ICswODAwLCBKaWEtV2VpIENoYW5nIHdyb3RlOg0K
PiBPbiBXZWQsIDIwMjMtMDUtMjQgYXQgMTM6NDIgKzAxMDAsIERhbmllbCBHb2xsZSB3cm90ZToN
Cj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gPiANCj4gPiANCj4gPiBPbiBXZWQsIE1heSAyNCwgMjAyMyBhdCAw
ODo0MzozMUFNICswMDAwLCBKaWEtd2VpIENoYW5nICjlvLXkvbPlgYkpDQo+ID4gd3JvdGU6DQo+
ID4gPiBPbiBXZWQsIDIwMjMtMDUtMjQgYXQgMDk6MjggKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8g
RGVsIFJlZ25vDQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2Ug
ZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+ID4gdW50aWwNCj4g
PiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJbCAyMy8wNS8yMyAxOTozNywgRGFuaWVsIEdvbGxlIGhh
IHNjcml0dG86DQo+ID4gPiA+ID4gT24gVHVlLCBNYXkgMjMsIDIwMjMgYXQgMDQ6NTY6NDdQTSAr
MDIwMCwgQW5nZWxvR2lvYWNjaGlubw0KPiA+ID4gPiA+IERlbA0KPiA+ID4gPiA+IFJlZ25vIHdy
b3RlOg0KPiA+ID4gPiA+ID4gSWwgMjIvMDUvMjMgMjA6MDMsIERhbmllbCBHb2xsZSBoYSBzY3Jp
dHRvOg0KPiA+ID4gPiA+ID4gPiBIaSBKaWEtV2VpLA0KPiA+ID4gPiA+ID4gPiBIaSBBbmdlbG9H
aW9hY2NoaW5vLA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24gRnJpLCBNYXIgMjQs
IDIwMjMgYXQgMDY6MTE6MzBQTSArMDgwMCwgamlhLXdlaS5jaGFuZw0KPiA+ID4gPiA+ID4gPiB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBGcm9tOiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
DQo+ID4gPiA+ID4gPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IER1cmluZyB0aGUgYWRkaXRpb24g
b2YgU1JBTSB2b2x0YWdlIHRyYWNraW5nIGZvciBDQ0kNCj4gPiA+ID4gPiA+ID4gPiBzY2FsaW5n
LA0KPiA+ID4gPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiA+ID4gPiBkcml2ZXIgZ290IHNvbWUg
dm9sdGFnZSBsaW1pdHMgc2V0IGZvciB0aGUgdnRyYWNrDQo+ID4gPiA+ID4gPiA+ID4gYWxnb3Jp
dGhtOg0KPiA+ID4gPiA+ID4gPiA+IHRoZXNlDQo+ID4gPiA+ID4gPiA+ID4gd2VyZSBtb3ZlZCB0
byBwbGF0Zm9ybSBkYXRhIGZpcnN0LCB0aGVuIGVuZm9yY2VkIGluIGENCj4gPiA+ID4gPiA+ID4g
PiBsYXRlcg0KPiA+ID4gPiA+ID4gPiA+IGNvbW1pdA0KPiA+ID4gPiA+ID4gPiA+IDZhMTdiMzg3
NmJjOCAoImNwdWZyZXE6IG1lZGlhdGVrOiBSZWZpbmUNCj4gPiA+ID4gPiA+ID4gPiBtdGtfY3B1
ZnJlcV92b2x0YWdlX3RyYWNraW5nKCkiKQ0KPiA+ID4gPiA+ID4gPiA+IHVzaW5nIHRoZXNlIGFz
IG1heCB2YWx1ZXMgZm9yIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IHJlZ3VsYXRvcl9zZXRfdm9sdGFn
ZSgpDQo+ID4gPiA+ID4gPiA+ID4gY2FsbHMuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+ID4gSW4gdGhpcyBjYXNlLCB0aGUgdnNyYW0vdnByb2MgY29uc3RyYWludHMgZm9yIE1UNzYy
Mg0KPiA+ID4gPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+ID4gPiA+IE1UNzYyMw0KPiA+ID4gPiA+
ID4gPiA+IHdlcmUgc3VwcG9zZWQgdG8gYmUgdGhlIHNhbWUgYXMgTVQyNzAxIChhbmQgYSBudW1i
ZXIgb2YNCj4gPiA+ID4gPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiA+ID4gPiA+IFNvQ3MpLA0KPiA+
ID4gPiA+ID4gPiA+IGJ1dCB0aGF0IHR1cm5lZCBvdXQgdG8gYmUgYSBtaXN0YWtlIGJlY2F1c2Ug
dGhlDQo+ID4gPiA+ID4gPiA+ID4gYWZvcmVtZW50aW9uZWQgdHdvDQo+ID4gPiA+ID4gPiA+ID4g
U29DcycgbWF4aW11bSB2b2x0YWdlIGZvciBib3RoIFZQUk9DIGFuZCBWUFJPQ19TUkFNIGlzDQo+
ID4gPiA+ID4gPiA+ID4gMS4zNlYuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4g
Rml4IHRoYXQgYnkgYWRkaW5nIG5ldyBwbGF0Zm9ybSBkYXRhIGZvciBNVDc2MjIvNzYyMw0KPiA+
ID4gPiA+ID4gPiA+IGRlY2xhcmluZyB0aGUNCj4gPiA+ID4gPiA+ID4gPiByaWdodCB7cHJvYyxz
cmFtfV9tYXhfdm9sdCBwYXJhbWV0ZXIuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
ID4gRml4ZXM6IGVhZDg1OGJkMTI4ZCAoImNwdWZyZXE6IG1lZGlhdGVrOiBNb3ZlIHZvbHRhZ2UN
Cj4gPiA+ID4gPiA+ID4gPiBsaW1pdHMNCj4gPiA+ID4gPiA+ID4gPiB0byBwbGF0Zm9ybSBkYXRh
IikNCj4gPiA+ID4gPiA+ID4gPiBGaXhlczogNmExN2IzODc2YmM4ICgiY3B1ZnJlcTogbWVkaWF0
ZWs6IFJlZmluZQ0KPiA+ID4gPiA+ID4gPiA+IG10a19jcHVmcmVxX3ZvbHRhZ2VfdHJhY2tpbmco
KSIpDQo+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gPA0KPiA+ID4gPiA+ID4gPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKaWEtV2VpIENoYW5nIDwN
Cj4gPiA+ID4gPiA+ID4gPiBqaWEtd2VpLmNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gPiAgICBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1
ZnJlcS5jIHwgMTMgKysrKysrKysrKystDQo+ID4gPiA+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ID4g
PiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nw
dWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5jDQo+ID4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL2NwdWZy
ZXEvbWVkaWF0ZWstY3B1ZnJlcS5jDQo+ID4gPiA+ID4gPiA+ID4gaW5kZXggNzY0ZTRmYmRkNTM2
Li45YTM5YTdjY2ZhZTkgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9jcHVm
cmVxL21lZGlhdGVrLWNwdWZyZXEuYw0KPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY3B1
ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMNCj4gPiA+ID4gPiA+ID4gPiBAQCAtNjkzLDYgKzY5Mywx
NSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0DQo+ID4gPiA+ID4gPiA+ID4gbXRrX2NwdWZyZXFfcGxh
dGZvcm1fZGF0YSBtdDI3MDFfcGxhdGZvcm1fZGF0YSA9IHsNCj4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgIC5jY2lmcmVxX3N1cHBvcnRlZCA9IGZhbHNlLA0KPiA+ID4gPiA+ID4gPiA+ICAgIH07
DQo+ID4gPiA+ID4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2NwdWZyZXFfcGxhdGZv
cm1fZGF0YQ0KPiA+ID4gPiA+ID4gPiA+IG10NzYyMl9wbGF0Zm9ybV9kYXRhID0gew0KPiA+ID4g
PiA+ID4gPiA+ICsgIC5taW5fdm9sdF9zaGlmdCA9IDEwMDAwMCwNCj4gPiA+ID4gPiA+ID4gPiAr
ICAubWF4X3ZvbHRfc2hpZnQgPSAyMDAwMDAsDQo+ID4gPiA+ID4gPiA+ID4gKyAgLnByb2NfbWF4
X3ZvbHQgPSAxMzYwMDAwLA0KPiA+ID4gPiA+ID4gPiA+ICsgIC5zcmFtX21pbl92b2x0ID0gMCwN
Cj4gPiA+ID4gPiA+ID4gPiArICAuc3JhbV9tYXhfdm9sdCA9IDEzNjAwMDAsDQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiBUaGlzIGNoYW5nZSBicmVha3MgY3B1ZnJlcSAod2l0aCBvbmRl
bWFuZCBzY2hlZHVsZXIpIG9uDQo+ID4gPiA+ID4gPiA+IG15DQo+ID4gPiA+ID4gPiA+IEJQaQ0K
PiA+ID4gPiA+ID4gPiBSNjQNCj4gPiA+ID4gPiA+ID4gYm9hcmQgKGhhdmluZyBNVDc2MjJBViBT
b0Mgd2l0aCBNVDYzODBOIFBNSUMpLg0KPiA+ID4gPiA+ID4gPiAuLi4NCj4gPiA+ID4gPiA+ID4g
WyAgICAyLjU0MDA5MV0gY3B1ZnJlcTogX190YXJnZXRfaW5kZXg6IEZhaWxlZCB0byBjaGFuZ2UN
Cj4gPiA+ID4gPiA+ID4gY3B1DQo+ID4gPiA+ID4gPiA+IGZyZXF1ZW5jeTogLTIyDQo+ID4gPiA+
ID4gPiA+IFsgICAgMi41NTY5ODVdIGNwdSBjcHUwOiBjcHUwOiBmYWlsZWQgdG8gc2NhbGUgdXAN
Cj4gPiA+ID4gPiA+ID4gdm9sdGFnZSENCj4gPiA+ID4gPiA+ID4gLi4uDQo+ID4gPiA+ID4gPiA+
IChyZXBlYXRpbmcgYSBsb3QsIGV2ZXJ5IHRpbWUgdGhlIGhpZ2hlc3Qgb3BlcmF0aW5nIHBvaW50
DQo+ID4gPiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gPiA+IHNlbGVjdGVkDQo+ID4gPiA+ID4gPiA+
IGJ5IHRoZSBjcHVmcmVxIGdvdmVybm9yKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
VGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBNVDYzODBOIGRvZXNuJ3Qgc3VwcG9ydCAxMzYwMDAwdVYN
Cj4gPiA+ID4gPiA+ID4gb24NCj4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+IHN1cHBs
eQ0KPiA+ID4gPiA+ID4gPiBvdXRwdXRzIHVzZWQgZm9yIFNSQU0gYW5kIHByb2Nlc3Nvci4NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEFzIGZvciBzb21lIHJlYXNvbiBjcHVmcmVxLW1l
ZGlhdGVrIHRyaWVzIHRvIHJpc2UgdGhlDQo+ID4gPiA+ID4gPiA+IFNSQU0NCj4gPiA+ID4gPiA+
ID4gc3VwcGx5DQo+ID4gPiA+ID4gPiA+IHZvbHRhZ2UgdG8gdGhlIG1heGltdW0gZm9yIGEgc2hv
cnQgbW9tZW50IChwcm9iYWJseSBhDQo+ID4gPiA+ID4gPiA+IHNpZGUtDQo+ID4gPiA+ID4gPiA+
IGVmZmVjdCBvZg0KPiA+ID4gPiA+ID4gPiB0aGUgdm9sdGFnZSB0cmFja2luZyBhbGdvcml0aG0p
LCB0aGlzIGZhaWxzIGJlY2F1c2UgdGhlDQo+ID4gPiA+ID4gPiA+IFBNSUMNCj4gPiA+ID4gPiA+
ID4gb25seQ0KPiA+ID4gPiA+ID4gPiBzdXBwb3J0cyB1cCB0byAxMzUwMDAwdVYuIEFzIHRoZSBo
aWdoZXN0IG9wZXJhdGluZyBwb2ludA0KPiA+ID4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+ID4gPiBh
bnl3YXkNCj4gPiA+ID4gPiA+ID4gdXNpbmcgb25seSAxMzEwMDAwdVYgdGhlIHNpbXBsZSBmaXgg
aXMgc2V0dGluZyAxMzUwMDAwdVYNCj4gPiA+ID4gPiA+ID4gYXMNCj4gPiA+ID4gPiA+ID4gdGhl
DQo+ID4gPiA+ID4gPiA+IG1heGltdW0NCj4gPiA+ID4gPiA+ID4gaW5zdGVhZCBmb3IgYm90aCBw
cm9jX21heF92b2x0IGFuZCBzcmFtX21heF92b2x0Lg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gQSBzaW1pbGFyIHNpdHVhdGlvbiBhcHBsaWVzIGFsc28gZm9yIEJQaSBSMiAoTVQ3NjIz
TkkNCj4gPiA+ID4gPiA+ID4gd2l0aA0KPiA+ID4gPiA+ID4gPiBNVDYzMjNMDQo+ID4gPiA+ID4g
PiA+IFBNSUMpLCBoZXJlIHRoZSBtYXhpbXVtIHN1cHBvcnRlZCB2b2x0YWdlIG9mIHRoZSBQTUlD
DQo+ID4gPiA+ID4gPiA+IHdoaWNoDQo+ID4gPiA+ID4gPiA+IGFsc28gb25seQ0KPiA+ID4gPiA+
ID4gPiBzdXBwb3J0cyB1cCB0byAxMzUwMDAwdVYsIGFuZCB0aGUgU29DIGhhdmluZyBpdHMgaGln
aGVzdA0KPiA+ID4gPiA+ID4gPiBvcGVyYXRpbmcNCj4gPiA+ID4gPiA+ID4gdm9sdGFnZSBkZWZp
bmVkIGF0IDEzMDAwMDB1Vi4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IElmIGFsbCBh
Z3JlZSB3aXRoIHRoZSBzaW1wbGUgZml4IEkgd2lsbCBwb3N0IGEgcGF0Y2ggZm9yDQo+ID4gPiA+
ID4gPiA+IHRoYXQuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBIb3dldmVyLCB0byBt
ZSBpdCBmZWVscyBmaXNoeSB0byBiZWdpbiB3aXRoIHRoYXQgdGhlDQo+ID4gPiA+ID4gPiA+IHRy
YWNraW5nDQo+ID4gPiA+ID4gPiA+IGFsZ29yaXRobQ0KPiA+ID4gPiA+ID4gPiB0cmllcyB0byBy
aXNlIHRoZSB2b2x0YWdlIGFib3ZlIHRoZSBoaWdoZXN0IG9wZXJhdGluZw0KPiA+ID4gPiA+ID4g
PiBwb2ludA0KPiA+ID4gPiA+ID4gPiBkZWZpbmVkIGluDQo+ID4gPiA+ID4gPiA+IGRldmljZSB0
cmVlLCBzZWUgaGVyZToNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IDZhMTdiMzg3NmJj
ODMwIGRyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMgKEppYS0NCj4gPiA+ID4gPiA+
ID4gV2VpDQo+ID4gPiA+ID4gPiA+IENoYW5nICAgICAgICAgICAgICAyMDIyLTA1LTA1IDE5OjUy
OjIwICswODAwDQo+ID4gPiA+ID4gPiA+IDEwMCkgICAgbmV3X3ZzcmFtDQo+ID4gPiA+ID4gPiA+
ID0gY2xhbXAobmV3X3Zwcm9jICsgc29jX2RhdGEtPm1pbl92b2x0X3NoaWZ0LA0KPiA+ID4gPiA+
ID4gPiA2YTE3YjM4NzZiYzgzMCBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5jIChK
aWEtDQo+ID4gPiA+ID4gPiA+IFdlaQ0KPiA+ID4gPiA+ID4gPiBDaGFuZyAgICAgICAgICAgICAg
MjAyMi0wNS0wNSAxOTo1MjoyMCArMDgwMA0KPiA+ID4gPiA+ID4gPiAxMDEpICAgICAgICAgICAg
ICAgICAgICAgIHNvY19kYXRhLT5zcmFtX21pbl92b2x0LA0KPiA+ID4gPiA+ID4gPiBzb2NfZGF0
YS0NCj4gPiA+ID4gPiA+ID4gPiBzcmFtX21heF92b2x0KTsNCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IEhvd2V2ZXIsIEkgZGlkIG5vdCBpbnZlc3RpZ2F0ZSBpbiBkZXB0aCB0aGUgcHVy
cG9zZSBvZg0KPiA+ID4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gPiA+IGluaXRpYWwgcmlzZSBh
bmQgY2FuIGltcG9zc2libHkgdGVzdCBteSBtb2RpZmljYXRpb25zIHRvDQo+ID4gPiA+ID4gPiA+
IHRoZQ0KPiA+ID4gPiA+ID4gPiB0cmFja2luZyBhbGdvcml0aG0gb24gYWxsIHN1cHBvcnRlZCBT
b0NzLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhhbmtzIGZv
ciBhY3R1YWxseSByZXBvcnRpbmcgdGhhdCwgSSBkb24ndCB0aGluayB0aGF0DQo+ID4gPiA+ID4g
PiB0aGVyZSdzDQo+ID4gPiA+ID4gPiBhbnkNCj4gPiA+ID4gPiA+IHZhbGlkIHJlYXNvbiB3aHkg
dGhlIGFsZ29yaXRobSBzaG91bGQgc2V0IGEgdm9sdGFnZSBoaWdoZXINCj4gPiA+ID4gPiA+IHRo
YW4NCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gbWF4aW11bSB2b3RhZ2Ugc3BlY2lmaWVk
IGluIHRoZSBmYXN0ZXN0IE9QUC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQW55d2F5IC0g
dGhlIGxvZ2ljIGZvciB0aGUgcGxhdGZvcm0gZGF0YSBvZiB0aGlzIGRyaXZlciBpcw0KPiA+ID4g
PiA+ID4gdG8NCj4gPiA+ID4gPiA+IGRlY2xhcmUNCj4gPiA+ID4gPiA+IHRoZSBtYXhpbXVtIHZv
bHRhZ2UgdGhhdCBTb0MgbW9kZWwgWCBzdXBwb3J0cywgcmVnYXJkbGVzcw0KPiA+ID4gPiA+ID4g
b2YNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gYWN0dWFsDQo+ID4gPiA+ID4gPiBib2Fy
ZC1zcGVjaWZpYyBPUFBzLCBzbyB0aGF0IHBhcnQgaXMgcmlnaHQ7IHRvIHNvbHZlIHRoaXMNCj4g
PiA+ID4gPiA+IGlzc3VlLA0KPiA+ID4gPiA+ID4gSSBndWVzcw0KPiA+ID4gPiA+ID4gdGhhdCB0
aGUgb25seSB3YXkgaXMgZm9yIHRoaXMgZHJpdmVyIHRvIHBhcnNlIHRoZSBPUFBzDQo+ID4gPiA+
ID4gPiBkdXJpbmcNCj4gPiA+ID4gPiA+IC5wcm9iZSgpDQo+ID4gPiA+ID4gPiBhbmQgdGhlbiBh
bHdheXMgdXNlIGluIHRoZSBhbGdvcml0aG0NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gICAg
ICB2cHJvY19tYXggPSBtYXgocHJvY19tYXhfdm9sdCwgb3BwX3Zwcm9jX21heCk7DQo+ID4gPiA+
ID4gPiAgICAgIHZzcmFtX21heCA9IG1heChzcmFtX21heF92b2x0LCB2c3JhbV92cmVnX21heCk7
DQo+ID4gPiANCj4gPiA+IEhpIERhbmllbCwgQW5nZWxvIFNpciwNCj4gPiA+IA0KPiA+ID4gVGhh
bmtzIGZvciB0aGUgaXNzdWUgcmVwb3J0IGFuZCBzdWdnZXN0aW9ucy4NCj4gPiA+IA0KPiA+ID4g
SXMgaXQgcG9zc2libGUgdG8gbW9kaWZ5IHRoZSB2YWx1ZSBvZiBwcm9jX21heF92b2x0IGFuZA0K
PiA+ID4gc3JhbV9tYXhfdm9sdA0KPiA+ID4gdG8gMTMxMDAwMCBpbiBtdDc2MjJfcGxhdGZvcm1f
ZGF0YSBhcyB0aGUgaGlnaGVzdCB2b2x0YWdlDQo+ID4gPiBkZWNsYXJlZA0KPiA+ID4gaW4NCj4g
PiA+IG10NzYyMi5kdHNpIGFuZCB0aGVuIGdpdmUgaXQgYSB0cnk/DQo+ID4gPiANCj4gPiA+IFNv
cnJ5LCBJIG5lZWQgc29tZW9uZSBoZWxwIHRvIGNoZWNrIHRoaXMgb24gbXQ3NjIyIHNpbmNlIEkg
ZG9uJ3QNCj4gPiA+IGhhdmUNCj4gPiA+IG10NzYyMiBwbGF0Zm9ybS4uDQo+ID4gDQo+ID4gVW5m
b3J0dW5hdGVseSBhbHNvIHNldHRpbmcgcHJvY19tYXhfdm9sdCBhbmQgc3JhbV9tYXhfdm9sdCB0
bw0KPiA+IDEzMTAwMDANCj4gPiBkb2Vzbid0IHdvcms6DQo+ID4gWyAgICAxLjk4MzMyNV0gY3B1
IGNwdTA6IGNwdTA6IGZhaWxlZCB0byBzY2FsZSB1cCB2b2x0YWdlIQ0KPiA+IFsgICAgMS45ODg2
MjFdIGNwdWZyZXE6IF9fdGFyZ2V0X2luZGV4OiBGYWlsZWQgdG8gY2hhbmdlIGNwdQ0KPiA+IGZy
ZXF1ZW5jeTogLTIyDQo+ID4gOjpyZXBlYXRpbmcgaW5maW5pdGVseTo6DQo+ID4gDQo+ID4gVGhp
cyBpcyBiZWNhdXNlIGluIG10NjM4MC1yZWd1bGF0b3IuYyB5b3UgY2FuIHNlZQ0KPiA+IHN0YXRp
YyBjb25zdCB1bnNpZ25lZCBpbnQgbGRvX3ZvbHRfdGFibGUxW10gPSB7DQo+ID4gICAgICAgICAx
NDAwMDAwLCAxMzUwMDAwLCAxMzAwMDAwLCAxMjUwMDAwLCAxMjAwMDAwLCAxMTUwMDAwLA0KPiA+
IDExMDAwMDAsIDEwNTAwMDAsDQo+ID4gfTsNCj4gPiANCj4gPiBTbyAxMzEwMDAwIGlzIG5vdCBh
bW9uZyB0aGUgc3VwcG9ydGVkIHZvbHRhZ2VzIGJ1dCBtZWRpYXRlay0NCj4gPiBjcHVmcmVxLmMN
Cj4gPiB3aWxsIHJlcGVhdGVkbHkgY2FsbA0KPiA+IHJlZ3VsYXRvcl9zZXRfdm9sdGFnZShzcmFt
X3JlZywgMTMxMDAwMCwgMTMxMDAwMCk7DQo+ID4gd2hpY2ggd2lsbCBmYWlsIGZvciBvYnZpb3Vz
IHJlYXNvbnMuDQo+ID4gDQo+ID4gVXNpbmcgMTM1MDAwMCBmb3IgcHJvY19tYXhfdm9sdCBhbmQg
c3JhbV9tYXhfdm9sdCBsaWtlIEkgaGF2ZQ0KPiA+IHN1Z2dlc3RlZA0KPiA+IGFzIGEgc2ltcGxl
IHdvcmstYXJvdW5kIGRvZXMgd29yayBiZWNhdXNlIDEzNTAwMDAgaXMgYW1vbmcgdGhlDQo+ID4g
c3VwcG9ydGVkDQo+ID4gdm9sdGFnZXMgb2YgdGhlIE1UNjM4MCByZWd1bGF0b3IuDQo+ID4gDQo+
ID4gT24gTVQ3NjIzIHRoZSB3aG9sZSBwcm9ibGVtIGlzIGFueXdheSBub24tZXhpc3RlbnQgYmVj
YXVzZSB0aGVyZSBpcw0KPiA+IG5vDQo+ID4gc2VwYXJhdGUgc3JhbS1zdXBwbHksIGhlbmNlIHRo
ZSB0cmFja2luZyBhbGdvcml0aG0gaXNuJ3QgdXNlZCBhdA0KPiA+IGFsbC4NCj4gPiANCj4gDQo+
IEV4YWN0bHkuDQo+IA0KPiBGb3IgTVQ3NjIyIHBsYXRmb3JtIGRhdGEsIEkgdGhpbmsgaXQgaXMg
cHJvcGVyIHRvIGNvbmZpZ3VyZSBhczoNCj4gLnByb2NfbWF4X3ZvbHQgPSAxMzEwMDAwLA0KPiAu
c3JhbV9tYXhfdm9sdCA9IDEzNTAwMDAsICAvLyBzaW5jZSBtdDYzODBfdm1fcmVnIGxkbyBvbmx5
IHN1cHBvcnRpbmcNCj4gey4uLiwgMTMwMDAwMCwgMTM1MDAwMCwgMTQwMDAwMH0gYXMgeW91IG1l
bnRpb25lZC4NCj4gDQo+IEZvciBNVDc2MjMgcGxhdGZvcm0gZGF0YSwgaXQgaXMgcmVxdWlyZWQg
dG8gYWRkIGEgbmV3IG9uZS4NCj4gLnByb2NfbWF4X3ZvbHQgPSAxMzAwMDAwLA0KPiAuc3JhbV9t
YXhfdm9sdCA9IDAsICAvLyBzaW5jZSBubyBzcmFtLXN1cHBseSBsaWtlIHlvdSBzYWlkLg0KPiAN
Cg0KTm90ZSB0aGF0Og0KDQpBY3R1YWxseSwgcHJvYyBhbmQgc3JhbSBvZiBNVDc2MjMgYXJlIHN1
cHBsaWVkIGJ5IG9uZSBwb3dlciByYWlsIHNvDQp0aGF0IHRvIGFkZCBzcmFtLXN1cHBseSBpbiBk
dHMgb3IgYXNzaWduIHNyYW1fbWF4X3ZvbHQgPSAxMzAwMDAwIGluDQpkcml2ZXIgYXJlIE5PVCBu
ZWNlc3NhcnkuDQoNCj4gSWYgTVQ3NjIyIGFuZCBNVDc2MjMgc3VwcGxpZWQgdm9sdGFnZSBpc3N1
ZXMgY2FuIGJlIGZpeGVkIGJ5IGFib3ZlDQo+IHBsYXRmb3JtIGRhdGEsIGZlZWwgZnJlZSB0byBz
ZW5kIHRoZSBmaXggcGF0Y2ggb3IgaW5mb3JtIG1lIHRvIGRvDQo+IHRoYXQuDQo+IA0KPiBUaGFu
a3MgZm9yIHlvdXIgaGVscCEgOikNCj4gDQo+ID4gPiANCj4gPiA+IFRoYW5rcy4NCj4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFlvdSBwcm9iYWJseSBtZWFudCB0byB3cml0ZQ0KPiA+ID4g
PiA+IHZwcm9jX21heCA9IG1pbihwcm9jX21heF92b2x0LCBvcHBfdnByb2NfbWF4KTsNCj4gPiA+
ID4gPiB2c3JhbV9tYXggPSBtaW4oc3JhbV9tYXhfdm9sdCwgdnNyYW1fdnJlZ19tYXgpOw0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IHJpZ2h0Pw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
QXBwYXJlbnRseSwgc29tZSBvZiBteSBicmFpbmNlbGxzIHdhcyBhcHBhcmVudGx5IHRha2luZyBh
DQo+ID4gPiA+IGJyZWFrLg0KPiA+ID4gPiA6LSkNCj4gPiA+ID4gDQo+ID4gPiA+IFllcywgSSB3
YXMgbWVhbmluZyBtaW4oKSwgbm90IG1heCgpIDotKQ0KPiA+ID4gPiANCj4gPiA+ID4gQ2hlZXJz
IQ0KPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSmlhLVdlaSwgY2FuIHlvdSBw
bGVhc2UgaGFuZGxlIHRoaXM/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoYW5rcywNCj4g
PiA+ID4gPiA+IEFuZ2Vsbw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+
ID4gDQo=
