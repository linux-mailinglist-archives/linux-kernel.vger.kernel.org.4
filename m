Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5697196EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjFAJ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjFAJ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:28:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FEBF2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:27:57 -0700 (PDT)
X-UUID: 94e0cc56005e11ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=g3npIdS2rySJDG2GCAz+O/32gL+28OPFQ5Fpms/FEbE=;
        b=Yy4KLPndFLZKb74oYAym6GhxXZ8+IHoogj055t5Ii/XO8Ez8S5/TX8joo7p1tY96kyQVixOjvvb+J12YgY317FxGc4tVhAao4b5GD3USeXnruuTVmEpveqxn/gsxpnGv0wY2r0L4EmDbkbrFqxvDEoRYweimimgNQZU9MzDcqvY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:a8c6bd27-f3eb-4ae8-985f-2b261974f534,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:fca8b46d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 94e0cc56005e11ee9cb5633481061a41-20230601
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <john.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1263324363; Thu, 01 Jun 2023 17:27:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 17:27:51 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 17:27:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtPuAzcJBPMnz4LssYsSs2vMjhAOlUry/MCnF/92M+nxUCAcAXllu95zoIN2UuRnoQxGwSe0/N8f6EgHr+5MnGdZNiEUAhYNNRp+ZO7OWeC3HTTp4ooXjEAGp4ipbchlRM+avg/IuCabQBEqOCVMYLLYK75KzhBwrvx0jXZSR3GRfNELwDkZtQLvCB1R5DMGuHGTd6+Y09sTP3RMPGXC1dfHQ+9839yS4JDav5hL+tvcQUS9bEwS+X8MBG6NRaOqPgoQJXPZzyC6/R2J/0k33A4e583V7lGbBIZxTVNXnfj6RI6jCjzyVSA167yO44j5r9abDXU5MQSZaNRYgY0tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3npIdS2rySJDG2GCAz+O/32gL+28OPFQ5Fpms/FEbE=;
 b=jdDIbfUKy6ba1P5RH+w4WWe9/A+Uzah8clOA3VZzHtCPL7UUA6R78MvzBPqJi6oapfXuy1/+LSK372rHfSSF8atG8MRy4vylarENQiCcisoHpBQWMeab8bcdw/nDDEiaKUohNr+Vk78/O9TAYlM6mMbgxILjUPOp5MuTr1xh1mTNUZj3tYwYP8lnyv9jg8RzOeH0IVa82wIJn0/LJTGBXeYGVsVm5TYGjOckygbCza1rHweVtNI++OB2QFGyEb1cha9FOjrgcZsjZFXBukeQYthvInb0r7qqfcFGEElvYHQgT+0Afvwr2MB5LOTKoLlTarM1FaN7XaJ/FnF262+6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3npIdS2rySJDG2GCAz+O/32gL+28OPFQ5Fpms/FEbE=;
 b=L9giSEFrJkUarMiB99eHS/qCwU5e3xGLH/xfYBzVT/S6iMkizPtkBT0sIlQTotthn34FuVGfSC+y7SA9q+xwQ9QU+bDS4n27GAdIXD+yCPnPA7ttef5R+b4RFLWrbVItsZ2iyl0XwKrF7Q/8VAFlVxmvPY86HuQvkEnjZFWuCTA=
Received: from PS1PR03MB4940.apcprd03.prod.outlook.com (2603:1096:300:79::23)
 by JH0PR03MB7836.apcprd03.prod.outlook.com (2603:1096:990:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Thu, 1 Jun
 2023 09:27:49 +0000
Received: from PS1PR03MB4940.apcprd03.prod.outlook.com
 ([fe80::399b:64c3:f911:571d]) by PS1PR03MB4940.apcprd03.prod.outlook.com
 ([fe80::399b:64c3:f911:571d%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:27:49 +0000
From:   =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Subject: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Topic: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Index: AQHZlGtUVxF/D4yUkEWHx0C5BMjKqw==
Date:   Thu, 1 Jun 2023 09:27:49 +0000
Message-ID: <96e9b733d9360f207d3aeeff6fb571bd1ceb2b3b.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4940:EE_|JH0PR03MB7836:EE_
x-ms-office365-filtering-correlation-id: 3bf7b846-f19b-4b7d-347c-08db62827764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Fjo7YRFqFVUGmIJyXovPiYF7XdJNLMY6/R8nvAj4TRJbTW3tQ+ty2fAIcR5Z8W0pr9ul3HMRqWO+uTWCUO0eezH+eZjPmBRUjY4Gy4j65VaTpwZ7oHoYXatNdBtRblS3Neu6TFwoykGA7AhO+i42RCRn/orSmQNBw5H6Zw8Riobx0oYCrJB+154PVDS6Ahfnk4egyUAz2poKso5P3HhfSNReARZjLMx8nASlh8y4tkyY2Rwup1N0Fr+Mk6eZx97dhWwTa/Ecs1/UjBqZlAWvG/hXj17MF1zOkKL3SLapV7Q1JRAMuL1h/0sY1SBCxmMgVR3zMx5lHlZUq8AGLUPSVpSB4OtY9wBMuZ8ZCm5l7/ZpO2FWqJbTdFM7Igvqh9wVei7/u9oYiu30n6qaP9OnYgwGYRwKdCMI5WCmxG35i7cxBmm1HCvpUXu+6JLGMzN3MO+S0It6kllrktik6gjtVnqRmTZ3EnEk+MiaO6cz3IfucHkavck79Oo4yTWOIbyLYU+fJD+SR63x5aUIy5/z1XSE1rsxz6oU1/y+CgBt0sWL+RtaA0ILx/MdP68XltSECN7+GLDfsahT6c+8dx2Xi5B+RUm1IqZLHIPyNiiyZ7IfBUpOb5R1HkrpjFceKoj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4940.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(2616005)(26005)(8936002)(8676002)(6506007)(6512007)(4326008)(107886003)(186003)(41300700001)(86362001)(36756003)(85182001)(4744005)(2906002)(64756008)(91956017)(66446008)(66946007)(76116006)(5660300002)(54906003)(66476007)(66556008)(38070700005)(110136005)(316002)(478600001)(6486002)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdLdGZnaThtVTlDODFjd2pGZjUrVlFpa25PRXRscUdMV0tLVkVDQmFTQ25s?=
 =?utf-8?B?blQxOEREaERrT2hna0s3Y1M0VEFVZEdUczRWUVdoWTdFdDJZVFhwaGpZOGhI?=
 =?utf-8?B?QWRPcDZITTlyRHJLV0hYbEJsK0VYMUE4NHZKVlJBckZOa1paTGp2eDNxaFBC?=
 =?utf-8?B?RFdVMzhIeEdKM2hwU1BidENKUFFyY0FLdWZXK1VPZ0dWeVhqcFhoTUxxVnNF?=
 =?utf-8?B?ckNOQkwvcUF2VUU4a0dHeXdKNjdzYmQ1VHYzRTJ5R1lVbW44VlpvZ0JmY05W?=
 =?utf-8?B?QzUvc1dtYUd0aGE5SW9VUkNjZDR4Q1p5SkxrNmVHZXpvcjkrTkI4L1lSNWtC?=
 =?utf-8?B?eU1CN3lNc3pvbDVIaDA2QlhyVkNVeDlQVzRHdVVZbjZXeXQ5OTJqRW9VdTQr?=
 =?utf-8?B?WlpLb2UzMGwwaGp0cVozbEs4ZkliNzhZYktoWlNKVFVaM0RzTTJBWXQvZjIx?=
 =?utf-8?B?Yms0bExaQjB2cmFrY2pkL3dXeGszQWQ3aUlzWDkyM1lJMEhxb2VPTzUxbFFE?=
 =?utf-8?B?NjhSbDFzOTZudWNtbEdCQTZFMFY5eW5RMlE2TTlmSG9panppZ3ZrVUNyV1la?=
 =?utf-8?B?QjNyWGh2WHphTzV1TzZHK2NtZFVyUHZyT0t0ZDZpVFRlUTI3WXhkb29wMWF6?=
 =?utf-8?B?blZyQldHeFpJYUZrbld6RXpWYk9JVHAxVjVqRXFuYllGUEtZWklNRHY0dGxV?=
 =?utf-8?B?djlsMWlHcHJEekFpK2kydUU0QytkSUxZL1MrRVBtbVhUUmZxVmdXSE1QaVo5?=
 =?utf-8?B?MFNHbHdsb0hCWlRCV1BUajZLaGFUL1B4K0NBdklaSFhUQXFJbE56K0c5UXlO?=
 =?utf-8?B?dFJ0ODVsTzZUYkxDZVVxRlNicms5Z2NDS3IzZ2hkMWNOeDJTYkdWSS95NTlR?=
 =?utf-8?B?N3g2WEhxWlYxTlo2aTlzQXp5dGI5YUFKRkgrbkVtbWNDR05ubU90TWtEc2lU?=
 =?utf-8?B?RDdWRnA5N1hkVWx5ejFtYnl3U2pYaVpxdDh3ZXNlbkRtUDZsT3dwOVdOUkxj?=
 =?utf-8?B?SkFQTGlVNy95eDJNT2VuNHNCNFlaN21PNXJHT2lMUW01QklSY2Fia0VUaW9D?=
 =?utf-8?B?TXQ0ZWU2OEptUUM4T1pLNHpSTlFUMmZaY3RBQ2s1bnJva1doVnlkK041bmxq?=
 =?utf-8?B?dGVsVU1XakxRTTRHY0VIbXB5cEdwd290TVhBNU0zS0E0S3VDNklpbi9pKzh6?=
 =?utf-8?B?NXpOaHQwTXZmZzR5dGZVdjd1c1JlamhGMnA0T1JTWk4xbzJSQ0sxajNERWEz?=
 =?utf-8?B?cHZTM0dJbGFMdnRpam9IMFJIQWNzNWpRS1dRNWh3V1pUaHpiZ3paRHZoOVI3?=
 =?utf-8?B?bGVxeWtBNys3SUFXSVNxNkI2djAvam82RDJtSGh2RDJsMDB0czZQRW9uZXVv?=
 =?utf-8?B?TkhUUW9yZGU1UHdSdjl2TFdTTHJ6eGQvbWRzbDNQMWtIck5ZdzhQNXNxc3Ix?=
 =?utf-8?B?ZHhNTXlrMi9mZDkzQzBXdGVZUkRvSnJhZ1NpVFBUMTE3YVN2UnljY3A0RGp4?=
 =?utf-8?B?NkRGbXZZOFNYUlhmbmNtWWtWNGdlZElsa0tReFBnMlMzZjJoQzgvZzA0WVZW?=
 =?utf-8?B?YUNWaFBVK24zMGhIQnEvK040TWdZeTA2K1VacWc3eW85dDVzOE5TeFVqUlhl?=
 =?utf-8?B?ZGV3ZHhxaEJBWERCSUhGYzFxWTkxd20wcFpzREV4MDliaWFTVG51czRxci8w?=
 =?utf-8?B?bDZ5WDBSUkFBakUxSmlWU2dxRlRoUUZkbzBiMXBzeU5jR2YxUjR4dzFXZnlS?=
 =?utf-8?B?M1FHQzhERG5hQmJGOVBaVTZjMWViT3RQbURjRzFsVTQyVU5YOFpuNytzVzdl?=
 =?utf-8?B?V3lxcFg4MlUvRTJzMFB2SWk0T1hnMFlTOWVhem5Zc0VKWUR6OVd1Rm44L08z?=
 =?utf-8?B?VlVDZFc2SGU4b2k4cGtZMWdFZ1N0R3FHOVlPY2FZbUhuMERuWVliaFRqY2hC?=
 =?utf-8?B?SG42UmttNDZIbS8zSmlWU2Q5dFlSTHZRZENJWWpWNjk0R3A3bHlnbTFtZDJR?=
 =?utf-8?B?NVFGb04wc1IyM1FBYmNyMlVaSHpCTXp3TVV4K0VUcUIzcWVqM1dmYVphcW5q?=
 =?utf-8?B?VXZiVFZaWHdYUmxpM2o3WVp5ZWxmQjdzMkNzdjduYzB5S2RDenpkMzZ1aXhq?=
 =?utf-8?B?RURmRElHeUJyWWZBZUV3SFdZRExBQXcrcWFNa2EwNGtqWXUvcXVaTTF3UHlx?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B23F33EA3CC64242824245774669E0F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4940.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf7b846-f19b-4b7d-347c-08db62827764
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 09:27:49.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCSwVSMrOmHuDi/+4A3bdK86oLFKRqh9MA3DX3YrgmGZ1fKaMj0vpQ9ZE+iOmK458XOzDqodRERZ/57Dm0TDaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpXZSBtZXQgQlVHX09OIGluIG1hc19zdG9yZV9wcmVhbGxvYyB3aXRoIGtlcm5lbC02LjEg
c3RyZXNzIHRlc3RpbmcNCmVudmlyb25tZW50IC4NCkFjY29yZGluZyB0byBjb3JlZHVtcCwgQlVH
X09OIGlzIHRyaWdnZXJlZCBieSBtYXMtPm5vZGUgd2l0aCBlcnJvcg0KbnVtYmVyIC1FTk9NRU0o
MHhmZmZmZmZmZmZmZmZmZmQyKS4NClRoZXJlIGFyZSBzb21lIG1hc19ub2RlX2NvdW50IGZ1bmN0
aW9ucyBpbiBtYXNfd3Jfc3RvcmVfZW50cnksIGFuZCBpdA0Kc2VlbXMgdGhhdCBtYXMtPm5vZGUg
bWF5IGJlIHNldCB0byBlcnJvciBub2RlIHdpdGggLUVOT01FTSBpZiB0aGVyZSB3YXMNCm5vIGVu
b3VnaCBtZW1vcnkgc3BjYWNlIGZvciBtYXBsZSB0cmVlIG9wZXJhdGlvbnMuDQpXZSB0aGluayB0
aGF0IHJldHVybiAtRU5PTUVNIGluc3RlYWQgb2YgZGlyZWN0bHkgdHJpZ2dlcmluZyBCVUdfT04g
d2hlbg0KbWVtb3J5IGlzIG5vdCBhdmFpbGFibGUgaXMgc3VpdGFibGUsIGJlY2F1c2UgaW4gcmVh
bGl0eSB0aGUgdHJlZQ0Kb3BlcmF0aW9uIHNob3VsZG4ndCBiZSBwZXJmb3JtZWQgaW4gdGhpcyBz
aXR1YXRpb24uDQoNCmZvbGxvd2luZyBhcmUgdGhlIGJhY2t0cmFjZQ0KbWFzX3N0b3JlX3ByZWFs
bG9jKzB4MjNjLzB4NDg0DQp2bWFfbWFzX3N0b3JlKzB4ZTQvMHgyZDANCl9fdm1hX2FkanVzdCsw
eGFiMC8weDE0NzANCnZtYV9tZXJnZSsweDViOC8weDVkNA0KbXByb3RlY3RfZml4dXArMHgxZjQv
MHg0NzgNCl9fYXJtNjRfc3lzX21wcm90ZWN0KzB4NmIwLzB4OGYwDQppbnZva2Vfc3lzY2FsbCsw
eDg0LzB4MjY0DQplbDBfc3ZjX2NvbW1vbisweDExOC8weDFmMA0KZG9fZWwwX3N2YysweDVjLzB4
MTg0DQplbDBfc3ZjKzB4MzgvMHg5OA0KDQpBbnkgc3VnZ2VzdGlvbiBpcyBhcHByZWNpYXRlZC4N
Cg0KVGhhbmsgeW91Lg0KQlJzLA0KSm9obiBIc3UNCg==
