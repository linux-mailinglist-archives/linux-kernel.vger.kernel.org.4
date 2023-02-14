Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4B695FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBNJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjBNJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:49:37 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5124CA5;
        Tue, 14 Feb 2023 01:49:23 -0800 (PST)
X-UUID: d99b125eac4c11ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ywl6KZkrUr9DGDcak82BykvWlGoWCh0WNQTuyz3OP0o=;
        b=at5mmRFH1T2XhL1jt6PPYEh+RPDeB0znfSupd8SrAP9FdcJvXB73dpjJq9qj+BOsGeWbzbdWjMrlZ6sVAzOTtYembkTfGpvbBNxnLKWwmOTuLklB/a1uhje7RloJd9rDFvwL7t4blu7hLQetHhIOS9PqCygP49PkCCrx5HRGbuM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:f8639a93-7521-4429-8a72-4f46d0051053,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:f8639a93-7521-4429-8a72-4f46d0051053,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:d6b768f8-ff42-4fb0-b929-626456a83c14,B
        ulkID:2302141749199I3893SK,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: d99b125eac4c11ed945fc101203acc17-20230214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 539367885; Tue, 14 Feb 2023 17:49:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 17:49:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Feb 2023 17:49:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0xyV6xZAy0H4ASXVsEB0gzvVLg+v46r6KuO+wb6amCy3vfyPOmp7nHHYQ3r4jsoqM5tJK6qVH4qAXjej8pyr+5SP+QrJKP7mErtWAzh8gA0zO6Iwjsjl2WxhjVfjd9KIatWnR2blOoBCEaH4f/3dIurd2OObvGNSTsoCyQHkkPrDrf+cHAUD4nQYk15x2/59YZEV1+pdNJbmqo8bwSiLWAcqnQkJCUd9JKGqaJQZeGnwTYsrNNNA8JPYRfuxkOc5TShlFVSxxZ0QWZeaBdSAu6r62X2PlhEM5qHyiHwJU0gr6/0psc8sMPnEETK3amOeyuwKk3bHcdA3ROUZhpj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywl6KZkrUr9DGDcak82BykvWlGoWCh0WNQTuyz3OP0o=;
 b=kSNYQm7s43dPPFQs5+M3HI/1QiVJxyTgUrIqGJiMoEwD32/XjQ9MGgezGrBeCiP4f8tw0VLextltN54VxZMfNSqGtASQ5Hp/86waqtEhCverfL4SgeQVDcK1ZESkseN4HRClNqt/tCV6wyPRz3d0r9FP/L/YeVwrwsfqadSYS7Y4LVVBO7ttLh00KrjnRJykgB4I1B7CDsJ9K1tzHQAppnlBQ/X3EisABP3Sm6jFy5rUk8/+ZqOqzv3Lu8MY028V4Ln/s7CF+HclSiR5DhqX7jjzJWi4IXoj82a+UZfts60Q7Pqb54QbiPS731ylBMe2j5oON4mb0+HCnnc5Qps11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywl6KZkrUr9DGDcak82BykvWlGoWCh0WNQTuyz3OP0o=;
 b=UYGNkpDa27ap9IRa/BN2wJGSkkbQLVVN6j/Bkt599gNQobgLengUzkTDyGs61N1xm5OFCNVz0ygGZFG82Y3RN4saLCi2nqsS8kN9OVqbCvD02kBZb0o0QMpKQ3s5e0fkTOjJG6nKp4ZDZvjuqR8Ddj+mCO1qN2gxGI7IjbLCtw4=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 KL1PR03MB7080.apcprd03.prod.outlook.com (2603:1096:820:d6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 09:49:15 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 09:49:15 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>, "will@kernel.org" <will@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v3 05/11] iommu/mediatek: mt8195: Add iova_region_larb_msk
Thread-Topic: [PATCH v3 05/11] iommu/mediatek: mt8195: Add
 iova_region_larb_msk
Thread-Index: AQHZQCJGohCcXEXQS0ep8IccjCW5aq7OL0eAgAADpQA=
Date:   Tue, 14 Feb 2023 09:49:15 +0000
Message-ID: <dacbffbc5cdcb892c1fcb296834c0b45d6e905ff.camel@mediatek.com>
References: <20230214031114.926-1-yong.wu@mediatek.com>
         <20230214031114.926-6-yong.wu@mediatek.com>
         <17239a6f-1d85-d725-89d6-02afe4fbe56a@collabora.com>
In-Reply-To: <17239a6f-1d85-d725-89d6-02afe4fbe56a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|KL1PR03MB7080:EE_
x-ms-office365-filtering-correlation-id: 03ae5869-003e-4c33-b63c-08db0e70bbd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wVcZTqQKhLzzsYrf/GQcqdNS4KBnWiGL4nb6kwUh+oxaLsCGXLI/6lc29eH/bV+4edC5k4H4dznmQNSsoFHcQ4X8wX76Dbt2We0w+Hp466+krx5Dnym97ladMcSHleS5kIpWHgifo/OQ0bI3lHVtJTfZI/IlYMJMeZLByHgQhARi63LF9HuHntuqJuMdxUgX+BkYb+WpZRhnAbw+N9IoBv/AtPLMd26zkGDgLxbj9NJjIRDiRQoz9izluxQ9XTh6/ac9ErUtKcLbp0lJPArHxYebJwkbMHpMheKEGk7mDGkmDs0aCixmq97TPmM/FBpw2wH4Z/e4IifSPJrzCg8aIQa6gmJ67eM4FbJet4VzqXZYf9IjAGXYU3Jtv1PwlXlw7mk/mR8jTwIf8kFt7YSaLvmqrgTcP6sZFOTSGj8fkJOJpvu+c+Shh63zIBuf4KUbIvSHwc1cFZduLCSLeOsRP7cJ5X5uFkpKE7iRGKgY/9B3Jkrov66u8ITdrGgcfLODJY0bl3zqFAc+s/Ifjko5EcWkP/U8d1qJjuo9PZsyYdWv+Ova50ENlNVwXXIetPMBsCn0yICCyTtSi6nRcaHIsyH/vC14QMwgY/p29Q3MUUcmLiUc0L4CWmgG5YNYfXc2/nLesRmeLmqXFFFaX6XmcRZkLIqlNrO078cwP5HGNot/XxfOZ4qc7jSqFDdoTvlds/tFoUekJxmBo+5lWoQBfyQZXfZZq9T395IYV7vgVdsRVP36rijTcYDDEeD2XQScQ2ShmaqyidQceocGT4gKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199018)(76116006)(66946007)(91956017)(54906003)(316002)(66476007)(66556008)(64756008)(7416002)(5660300002)(66446008)(8936002)(8676002)(478600001)(4326008)(2616005)(41300700001)(6512007)(6506007)(186003)(26005)(6486002)(71200400001)(110136005)(38070700005)(85182001)(36756003)(4744005)(2906002)(122000001)(38100700002)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01sZWdXTWNOa0psMG5LVzR0MkhQRFVETTJaajR2V1VvZkJML0xUalNQNzNi?=
 =?utf-8?B?VzVXS1lPUmExTHJtdCtMMVJ6cHU3WGFUYlRTODRwVXYzaHlub1czRGFFT1dJ?=
 =?utf-8?B?bXZDYXFNdk1mVi9OcVRFNk1wdmpMeVgzYWJEWm0yNEZiRXZxdE9YUWZLQS9o?=
 =?utf-8?B?VTlkbVcyMUYzMEJ6ODM5a2F3ZFFiQzVybkR3S3FTVkNBR3pTazBuZStNWm80?=
 =?utf-8?B?bGhYaVZNN1hPMDdsK2VZejBxeWlNYkZvUk5IektMNDhkQ0RIdk5hZ3I0d2Rw?=
 =?utf-8?B?V0ZCT1lyRU1wbVdLcng4RGNlTmE1UVJHdEs4YVl4ejdDQnNHY25hWTMvcmdD?=
 =?utf-8?B?cm5xeE1KR1JuWkZZNGlMVjhLZldQL0ExdllDaGJkOTRYVHhEMWNZY3ovVVV4?=
 =?utf-8?B?WjRvUEpTdlFyQURoRm40Q1BxREp4cHBjakpYVDJsNVY0SDJBVkdZSi9NbUM5?=
 =?utf-8?B?R0x5Z2dCV2NiTXpHTXROOWF0VXdFSHZPUHpqaG5vZlBWektkNkptdnFheity?=
 =?utf-8?B?Uk55SFlKUTNhZmcrZGlPVHJRT3pHcThwd1YzMFpyK2ViSWYra1BKbHBlZWxY?=
 =?utf-8?B?bXZ5TXFEd2xTVngvRFdCamdOSnFnTHhnemJlWE5ISzVOSjNrQzBWZ1NQSnRh?=
 =?utf-8?B?dUdScjJQRE1aby8xaWNYQUZja1pETTd5T25tdFhlTVZPaExxYVptVFZSdjZV?=
 =?utf-8?B?U1lSZWhGczZZbnZ5UUNuOGIzUmlIOGZOTndoOHN1b0NLV2d3ZmpvMWpKM0dB?=
 =?utf-8?B?bmhBaCsyQk5CQkNwMFZKZC9FMXhxa0dDY1daaTAxdWZmc2lWSWJiaWY4cE4z?=
 =?utf-8?B?SDl4b0RXS2pjVmNBMHJ4bmdjTHoxMGE5L3BIVGhuQ2hjS3NQb3RwUzZLZnlv?=
 =?utf-8?B?bzJLZFVtMzFZbGtwRm9ST3VqNEtUYStEdTNyRFRaNEJrWHZQek1lajN5Y05r?=
 =?utf-8?B?YUlhcUV5MENtTWp6YUpjNVpDRnFyMkt4K0xVaDY4M3JiTzIrOW9GNjRCNHpW?=
 =?utf-8?B?UE5oRUZPd2Z5UE01UWs4T01EUnhUbW1VdXFFNmpmWFRpemZhU0cxVU5uMWlK?=
 =?utf-8?B?MWlhcU00bzF0K3IrWEpDYlZ1NGFmRnIweG5HQWE3QitoOEt1Y01LNVVLbFJ5?=
 =?utf-8?B?VVlaNGZXN0VYWGx0VStyeW5GekxQUzdraERGTWFjRDJUQjI0ai9vaXQ3Rkdr?=
 =?utf-8?B?QVFoMjdnNklqM2J5Y1VjdTE0L1hZaHpYcmQ1QWJYeWp3VVZMOGNrQkRoN1Vi?=
 =?utf-8?B?SXI2aS9zRUVFNWx0TERjcVE2TlJXTUZRVy9Eb1NBL1VCeWw5QmxrNnNCdksy?=
 =?utf-8?B?emVwZnFXNHZDcjZkaFdJUFR4ZmpjUjN4V0NYamc4S3RXVkh4b3hKakNiVkJT?=
 =?utf-8?B?NEd1K3VyRHNDNWY2V3k1VlVROW82aGhCUkdrZExzcXp2UmtKSnh4NHN3UFk4?=
 =?utf-8?B?cUdtYkxzQUpaSXVFY0JlZmFLR0gzR3BhdVZlTStHSmRPeXZBWTlncTQ0bHNY?=
 =?utf-8?B?R2Y3WHN3OW5pRkc5YWtnbEplMkpOTE9Jai9OWVZmSy84QmVOVnZxU0cyeFh0?=
 =?utf-8?B?M1RJTEtXK1FDc0xPRGZFSjNIczI0QUQycFIwemZVVCs4bm5oRzFyM1ZOU2xz?=
 =?utf-8?B?bEN6c29vQ0puMjQzakREclVEZjV0ckQ2TEUrQWFaaUxVWklncVB0MjNNTUFw?=
 =?utf-8?B?OUdZekJDSGY3SjJQY3FNeFpDSWJNd3RTUlpBK3BkWkVXbDNKTnJoS2lKbWt4?=
 =?utf-8?B?SFV1bEZPaVZrakNoVkh2RUpBTUZwNjh6VTRjQVV4RzdlRENnZ1A4Q0kyMi90?=
 =?utf-8?B?WmdKbnNaYXpWRldkd0dRdDJqbmczT0Z6Qkpmc1gzdnJ0aXFudWRJU0dsUjhj?=
 =?utf-8?B?Mzg1citwaWpDZlFJYk85TVB0bmhRK1E2TXNKWGljQnNlYlZIVTRqZlQ5bTJO?=
 =?utf-8?B?eUc2cWxONC9KbmpyVU8zM0FJUDFBbUdyNU5EQlAzUnU0NHdZRFRmN1hjWCt0?=
 =?utf-8?B?Y1lleExlQ2s1aFJqbVV2ajVDNlN2ejV6RHdYM08rYXNEcGN3K1Z4RkNhRjVM?=
 =?utf-8?B?UTNtZk92NnBQOG9DcGRLMW5IU3FmUFdqcUhhZmM5NXJCdFVyYnNUbExXL3Y1?=
 =?utf-8?B?SFN4MVgza0JIOGlxZWNHKzVWTjZLZFVuZFRwbHFxMEJ2Ry9FOFNac3F2WmdL?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CDF395AD44E514A92F4561F876F678B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ae5869-003e-4c33-b63c-08db0e70bbd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 09:49:15.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPZej3CR+vp1jimEJ/TuceFZstLAsAyPREbFaxMrhvMRybLfAgNviiWB7IfD3I1KXdlgrCD4Wi3HuWN4d5uzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7080
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTE0IGF0IDEwOjM2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTQvMDIvMjMgMDQ6MTEsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBBZGQgaW92YV9yZWdpb25fbGFyYl9tc2sgZm9yIG10ODE5NS4gV2Ugc2VwYXJhdGUgdGhlIDE2
R0IgaW92YQ0KPiA+IHJlZ2lvbnMNCj4gPiBieSBlYWNoIGRldmljZSdzIGxhcmJpZC9wb3J0aWQu
DQo+ID4gUmVmZXIgdG8gaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTk1LW1lbW9yeS1w
b3J0LmgNCj4gPiANCj4gPiBEZWZpbmUgYSBuZXcgbWFjcm8gTVQ4MTkyX01VTFRJX1JFR0lPTl9N
QVhfTlIgdG8gaW5kaWNhdGUNCj4gPiB0aGUgaW5kZXggb2YgbXQ4eHh4X2xhcmJfcmVnaW9uX21z
ayBhbmQNCj4gPiAic3RydWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbiBtdDgxOTJfbXVsdGlfZG9t
Ig0KPiA+IGFyZSB0aGUgc2FtZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5
b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IFNvcnJ5IGJ1dC4uLiB5b3UgKmFyZSogaW50cm9k
dWNpbmcgYSBpb3ZhX3JlZ2lvbl9sYXJiX21zayBmb3IgTVQ4MTkyDQo+IGxhdGVyLA0KPiB3aGls
ZSB5b3UncmUgaW50cm9kdWNpbmcgZGVmaW5pdGlvbnMgY29udGFpbmluZyB0aGUgYE1UODE5MmAg
bmFtZSBpbg0KPiBhIGNvbW1pdA0KPiB0aGF0IGludHJvZHVjZXMgdGhlIHNhbWUgYnV0IGZvciBN
VDgxOTUuDQo+IA0KPiBJIHN0cm9uZ2x5IHN1Z2dlc3QgdG8sIGF0IHRoaXMgcG9pbnQsIGludHJv
ZHVjZSBNVDgxOTIgcmVnaW9uIG1hc2sNCj4gaGVyZSwgYWxvbmcNCj4gd2l0aCB0aGUgTVQ4MTky
IGRlZmluaXRpb25zLCBhbmQgTVQ4MTk1IGFmdGVyIHRoYXQgOi0pDQoNCk1ha2Ugc2Vuc2UuDQpU
aGFua3MgdmVyeSBtdWNoLiBXaWxsIGZpeCBpdC4NCg0KPiANCj4gDQo+IFJlZ2FyZHMsDQo+IEFu
Z2Vsbw0KPiANCj4gDQo=
