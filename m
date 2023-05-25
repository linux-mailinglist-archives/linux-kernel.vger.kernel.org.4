Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808EF710649
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbjEYH3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEYH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:29:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC72C0;
        Thu, 25 May 2023 00:28:55 -0700 (PDT)
X-UUID: b0254b74facb11ed9cb5633481061a41-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QBNlpIL8ZM1DvACU9DUVbrCfaTTtq6czOk/cLOxEcj0=;
        b=GMZiTHN9dpJgjFl0DwR66FXhFcMlyujnhqS6g413S4v4ux5+i5u98erRdzEg6eiDovtF9kCWVoLcbQgCY0xDU1JO+1K73AJlTqHWZJxSvaHoKmca1wUiedCHTKs5z6TGpIZ3yXDurd6KF6ygOyaOyz+O2zm63NLSoS46eTiTzJc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:d6fbcb35-61cd-49bf-9b10-51e08e6eca10,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.25,REQID:d6fbcb35-61cd-49bf-9b10-51e08e6eca10,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:d5b0ae3,CLOUDID:4bf4503c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:2305251446400FZYE849,BulkQuantity:6,Recheck:0,SF:17|19|38|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b0254b74facb11ed9cb5633481061a41-20230525
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 609296613; Thu, 25 May 2023 15:13:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 15:13:44 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 15:13:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joH5DcMHZn+i1m3ADrte+GDKR7dIMCeFFHWdZuPkFWW4sodRyXGrjQ3mhGni4rAWTeuzKJz5mA9JZ7j0fc0nrPWBLkPcbKAgoxkt8Cs4b3HduvOyztlFjjUfPFTGtrjs7VVRd1u1jAuKE/693r261cWMX1qyT1QL4cky8T0dQt1ZUngjXZ5e/hnipgUpo1KX+Dvc1SNbQd0eUFptBVkrLWYEv4F7uXqeu3n5DR3B+8t1SRUSBtftMwbKryLxrJOvMJK6Kqvmr5D9BemQK+bk+5nUffJSBt1sMPLZOg90CwQ8AoEfWvPQCR6L/w1WHk2JxMnQG+wUlYDERML1YQlR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBNlpIL8ZM1DvACU9DUVbrCfaTTtq6czOk/cLOxEcj0=;
 b=aoMYRUIryjK2iaA6j2PDnE4QhRX8b5Pfk4NEwi66ac4BdxucHean/z17KyWFxoGXXIzb4btS4FOwQ8mYnXGBucrMkllrnX0jTwyfC7TOkvBslvCyODEDEld3VgVX3oVrr+WLXHIChhGtpmOvhRMx59q7iBxikT73b8lEpVMXtfczpuBvHLkBiU16cuXEze9251/2AYN3wwOiC0FaB42AERnPpP4yl/bYfuURTzaITAUNxftxKV6ZFk7Gh09fpS7iZgIP7KhqI+ECaDq2uUgS+cHvhp1t70FvokRgMgxsylaiawNnuq2vcFsc+Q4HFiZ6cIuYPVdTJraK4GurVUJtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBNlpIL8ZM1DvACU9DUVbrCfaTTtq6czOk/cLOxEcj0=;
 b=ns0aE2v1xPAx3mEVPuEqr8ALO3WebrEExrYpS0CUh6W+JJkN7KrCgoaTeWdkKcdTSmdB4u1vDJUJzu9EJVdjaWvHbeLOnZytLKBHNvG7sOx4kWUIwQdt1ed+piWczA68yDtTCBNsnNmqalHPQ7FRjOej8OfPkvKNzwOPH+wZBHI=
Received: from SG2PR03MB6478.apcprd03.prod.outlook.com (2603:1096:4:1c5::14)
 by SEZPR03MB6596.apcprd03.prod.outlook.com (2603:1096:101:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 07:12:41 +0000
Received: from SG2PR03MB6478.apcprd03.prod.outlook.com
 ([fe80::d089:e748:fc01:8eb7]) by SG2PR03MB6478.apcprd03.prod.outlook.com
 ([fe80::d089:e748:fc01:8eb7%6]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 07:12:41 +0000
From:   =?utf-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clk: mediatek: reset: add infra_ao reset support
 for MT8188
Thread-Topic: [PATCH v2 2/2] clk: mediatek: reset: add infra_ao reset support
 for MT8188
Thread-Index: AQHZf1N7kyHhwXyKWkaCbmHvB/nzt69UC9UAgBamEgA=
Date:   Thu, 25 May 2023 07:12:41 +0000
Message-ID: <60ae3c3497bb124733f3f0584b443c0fe5ec73e4.camel@mediatek.com>
References: <20230505131308.27190-1-runyang.chen@mediatek.com>
         <20230505131308.27190-3-runyang.chen@mediatek.com>
         <ca1e1df877652808ef76851d7f2ed781.sboyd@kernel.org>
In-Reply-To: <ca1e1df877652808ef76851d7f2ed781.sboyd@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6478:EE_|SEZPR03MB6596:EE_
x-ms-office365-filtering-correlation-id: b0449a71-5c8d-4ff4-db64-08db5cef6e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+ycHFuesUBl2I8wZQ1hDDBJzzOunjKZttQeq8AAHoh0RHwr29QqXxdtUi/Z3EEk2AWdF9hv/s0pDMAakX25gxHiA9B9KGx4+GKOIFmVq/WqNh7hnDpOGf0SHxzChp/7ufVRUeTJSSaESzgahE5ZSFrrqG+3s56KuNTnnDUAme+G8C7b/bq2T0+tgePEkAwut/VoReCTDEztyE6kTtub8EdbPgr2BEZ2CHx7XTI1hieuVq3fHlkBdLTQqYeOd99LhG2mc6r3ckx/SpE9YxfQIGjhNsrTobcvHZqUKze8pehkzaptiaW8p9v41tFyfb3UWr9eb4BZKfeZV/4Z+D5I68uxjNLklSbhVzci0OLXDN6Wjmdb35nO5rcbkk5AQpcEctKHjkzhl+s1I2eauEsoYDv2tADzQKy3qDgX+brGDvKLNF1HWumd9bwBty3v4kAcebAH0/W8iPbFDvSxqUQhKvpN/9CVb25HeRCXq30ZjEw+pbo8KN21xDQEBVH+ovlefV+s9NKdoTTgwoSrvYDGLzitMCKfePlV5t2wK8xq8DcVQSS+YmOsnORIkJ/yd+MRzxdLoVWbrKjvjmueA0VhAN0V4oh8dBdg8u4AjdiO5bxl7TuTJ2rMzBZZhY4ihkzP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6478.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(8936002)(8676002)(7416002)(5660300002)(83380400001)(186003)(6512007)(6506007)(2616005)(26005)(86362001)(122000001)(38070700005)(38100700002)(64756008)(71200400001)(478600001)(66946007)(6486002)(36756003)(66446008)(4326008)(76116006)(66556008)(85182001)(54906003)(110136005)(66476007)(316002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukc4MjVTRXl0aTZKQS9iaEJXOGxUWGUxQ1ZGclVzVDh4cHd5RDZiZzR2N295?=
 =?utf-8?B?czgzNlJRWm9rU25jSm9WRTdOeHh1RytYbm1ybWpHMDZWTHNoRUZXcm4vb2gx?=
 =?utf-8?B?K000NGZYem0ydW55RUN6TUNBTkx0SkNXWFVueDFUTzZwL0RDcENpVlJzQUdx?=
 =?utf-8?B?dGVSclZOTkFzS3YybGo5S2gza2YvUnJ5SVJJUG5yS3pTaXpzT1dXUUxNOVU4?=
 =?utf-8?B?a0U1b05sVWxMcGd1LzZXbk1qZ24xQTE3V2lYbWEzZmdsT2xlYUV5M2o2aW5h?=
 =?utf-8?B?RnhPQmR6dTBJUGlyWndaRlhvajhCRWwzOE1pWm9MZ09lTnBVY1EydE9FdGZY?=
 =?utf-8?B?U3RHNDZJVTlEZFl2UytFdkd3czRyTm1vOCt1ZEpUOVlabnhSTURWYmkxRkR5?=
 =?utf-8?B?bnlZaEwzUjc5empPVWRQOXgvaWRuNHhFYnArSGNaV0U2UHdOdHFZZnQ0S3BC?=
 =?utf-8?B?b2xOdURMb2pOaDhvWWFOVG0zcTdtUE1sVy9NU2R2bHpNRWhIcVFnTXczQzJM?=
 =?utf-8?B?em42b2NiQ0JwK3lYcG9WNjlZMGpvc3FXaGsyT2RCZjNYcUNSa2wzR0NxNjJl?=
 =?utf-8?B?RDI5SUZhaWhwOXZXQ0ZXalQzV3BPUkNDeHFUOXZBM3NXNzRsMmZDOWFmUXJW?=
 =?utf-8?B?UEdYWEp0c0tDMk00TC9RVUVBcHRWRUFEUEdmV1NiYjRtZFU5eXFTRHU0UUNt?=
 =?utf-8?B?NlpYSHcweW1aR0hMTnFmMlZhWkRKTnU0aVNIOGNFZXgxdURPd3ZxRndTU0N5?=
 =?utf-8?B?dDlJUHlBamgvRFdnd2QwOHdHYmhnWGphY0YrS010cVk0eStNVi9mWW5NY1JS?=
 =?utf-8?B?VThJcktRb2sxNjYxUU9GR3dicEp0bU1KcHF1dEZtbVNLc005RXRhY3RQMFZU?=
 =?utf-8?B?N2pnZXlWeGJkcFF5MTk2czhMMFQ0L01HUytXS1NXZGZLdmpVSHR3YUo0V0Zh?=
 =?utf-8?B?aGlybURNMDZsN1dHZUZya3RUVWVNUUtPaXZGaEZJZmZlZ0Zxa3V5UTQzazFx?=
 =?utf-8?B?S2dsZ2krSlMxYlhESS9FZTdPQUN2SG9oY3grek1SY1ZGTUhsQjhYbUp2cVJY?=
 =?utf-8?B?ZzltRERxL2owck9DRUZaeGZGUWd1UXU0MGFBSURheXdKS0VLRWpzclppMGxr?=
 =?utf-8?B?VjlYTVNyWWxhQ2JaUWc0eUpjblZHK1Q4bkoyRnJ5bll0RlB1eFNmQ3dWQkc0?=
 =?utf-8?B?TTl2cERjZlh5dlkxWEt4VUhvblR1Y3llUENKYk1tVjdoTWJncmlWNGN1V0NP?=
 =?utf-8?B?NWpVd3pmWHZralhja3VnUTNnRm40b3QxcjJpeWdaZ3I2OGU3YUxpZ2FkZm0z?=
 =?utf-8?B?dXlpNnFNNmpwTkdSbjFyU0gveGNMa0VDM1gzKzZOblZTdklZRjZUcEcycFZ4?=
 =?utf-8?B?MXk4UEcySk5RZUlGTXNLYTV0dnFPUHBFOXNGcVhQMVJURWtPMVl5ZFJwaFdx?=
 =?utf-8?B?Vk9wbGlCR01vUWNseDQ2K0Y2Z085ZkE0eW9JZndKRDVuaU91eDA5QWxmSWtQ?=
 =?utf-8?B?WXRJZnZlZGFnbE9Ya3dHdXZCdUNYSWx3aEwxM1VJclFNSmZSVjQ2T0w3a1J0?=
 =?utf-8?B?dVVIU1ROdVdVRmxIeEd2Zi9OSld5RytEWVI2MTFYVFk1OTlKNnpuYzUzODdR?=
 =?utf-8?B?WiszaUZxYWVoUitMeHYzeTZPaWlEWUNSdFVGVytrNDc2OTR5MEU4K2JsU0hn?=
 =?utf-8?B?aTNIUXo2L0toaGdiUk5qUVlhdGc0MStZcUl2b3Yvc1M1cU9yOW9VRi85eXVx?=
 =?utf-8?B?WUVPL1lHVTY5SGFCRG1GWW1SOW9FVFlHMnZ4Z25wWENZai96eXZvUktTdTlI?=
 =?utf-8?B?ZGRxdkNxVlRlN1FRQVFoT1ZTWVBmU1AxdXdsNEo4eWtmMGlZSG9UYXhRakNq?=
 =?utf-8?B?K3dTTzB3WElMcG56S2xKREZwMllLZDQwc1B6eWptNGR4WE1Ma1dSQUVSNXhp?=
 =?utf-8?B?RHZtdGJjREkzRTJLQ1hMVjNKWUpuSit1UEFYM2N5RGZodHdyd3hrbXp6TVQy?=
 =?utf-8?B?L01rNW03dTdSRmJwN3lUR1djMTc5THE1UGcvUlVtNWxUbitqY2tTNWYrTUxo?=
 =?utf-8?B?UGEzMGdVSTA5M2Zsa1h5M1Vaam94cDd3YXVqWGlBY2l2NFI3U2MxM1ZkMWZ2?=
 =?utf-8?B?ai9veWU3L3QyRkJyRkZBcS9ORWtpdnBQeURrS01xU1B4bDAwRXVQaGZ6eHJJ?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54030152DE1043499D9E7B83B36D1B54@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6478.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0449a71-5c8d-4ff4-db64-08db5cef6e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 07:12:41.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+UMfP8F4C+DuuI/g/dmNBSb0UkaQitEPRDS1MpexNzusjQwOeMNwSHqPOwtzyyP5e2dWiMdBVQclvOHCMuWkjiFF8ffojsyJpBdshMIMEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6596
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTEwIGF0IDE0OjIwIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gUXVvdGluZyBSdW55YW5nIENoZW4gKDIwMjMtMDUtMDUgMDY6MTM6MDgp
DQo+ID4gQEAgLTE3Niw5ICsxNzcsMzIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBp
bmZyYV9hb19jbGtzW10gPQ0KPiA+IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICJpbmZy
YV9hb19hZXNfbXNkY2ZkZV8wcCIsDQo+ID4gInRvcF9hZXNfbXNkY2ZkZSIsIDE4KSwNCj4gPiAg
fTsNCj4gPiANCj4gPiArc3RhdGljIHUxNiBpbmZyYV9hb19yc3Rfb2ZzW10gPSB7DQo+IA0KPiBj
b25zdD8NCg0KVGhlIGluZnJhX2FvX3JzdF9vZnMgYW5kIGluZnJhX2FvX2lkeF9tYXAgd2lsbCBi
ZSBtb2RpZmllZCBieSB0aGUgcmVzZXQNCmNvbnRyb2xsZXIgZHJpdmVyLCBzbyBpdCBjb3VsZCBu
b3QgYmUgY29uc3RpZmllZC4gQW5kIHByZXZpb3VzIGNvZGUgZGlkDQpub3Qgc2V0IGl0IGFzIGNv
bnN0Lg0KDQo+IA0KPiA+ICsgICAgICAgSU5GUkFfUlNUMF9TRVRfT0ZGU0VULA0KPiA+ICsgICAg
ICAgSU5GUkFfUlNUMV9TRVRfT0ZGU0VULA0KPiA+ICsgICAgICAgSU5GUkFfUlNUMl9TRVRfT0ZG
U0VULA0KPiA+ICsgICAgICAgSU5GUkFfUlNUM19TRVRfT0ZGU0VULA0KPiA+ICsgICAgICAgSU5G
UkFfUlNUNF9TRVRfT0ZGU0VULA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHUxNiBpbmZy
YV9hb19pZHhfbWFwW10gPSB7DQo+IA0KPiBjb25zdD8NCj4gDQo+ID4gKyAgICAgICBbTVQ4MTg4
X0lORlJBX1JTVDFfVEhFUk1BTF9NQ1VfUlNUXSA9IDEgKiBSU1RfTlJfUEVSX0JBTksgKw0KPiA+
IDIsDQo+ID4gKyAgICAgICBbTVQ4MTg4X0lORlJBX1JTVDFfVEhFUk1BTF9DVFJMX1JTVF0gPSAx
ICogUlNUX05SX1BFUl9CQU5LDQo+ID4gKyA0LA0KPiA+ICsgICAgICAgW01UODE4OF9JTkZSQV9S
U1QzX1BUUF9DVFJMX1JTVF0gPSAzICogUlNUX05SX1BFUl9CQU5LICsgNSwNCj4gPiArfTsNCj4g
PiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgbXRrX2Nsa19yc3RfZGVzYyBpbmZyYV9hb19yc3RfZGVz
YyA9IHsNCg0KaW5mcmFfYW9fcnN0X2Rlc2Mgd2lsbCBiZSBjb25zdGlmaWVkIGF0IFY0Lg0KDQo+
ID4gKyAgICAgICAudmVyc2lvbiA9IE1US19SU1RfU0VUX0NMUiwNCj4gPiArICAgICAgIC5yc3Rf
YmFua19vZnMgPSBpbmZyYV9hb19yc3Rfb2ZzLA0KPiA+ICsgICAgICAgLnJzdF9iYW5rX25yID0g
QVJSQVlfU0laRShpbmZyYV9hb19yc3Rfb2ZzKSwNCj4gPiArICAgICAgIC5yc3RfaWR4X21hcCA9
IGluZnJhX2FvX2lkeF9tYXAsDQo+ID4gKyAgICAgICAucnN0X2lkeF9tYXBfbnIgPSBBUlJBWV9T
SVpFKGluZnJhX2FvX2lkeF9tYXApLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfY2xrX2Rlc2MgaW5mcmFfYW9fZGVzYyA9IHsNCj4gPiAgICAgICAgIC5jbGtz
ID0gaW5mcmFfYW9fY2xrcywNCj4gPiAgICAgICAgIC5udW1fY2xrcyA9IEFSUkFZX1NJWkUoaW5m
cmFfYW9fY2xrcyksDQo+ID4gKyAgICAgICAucnN0X2Rlc2MgPSAmaW5mcmFfYW9fcnN0X2Rlc2Ms
DQo+ID4gIH07DQo=
