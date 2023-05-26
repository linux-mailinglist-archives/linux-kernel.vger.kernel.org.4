Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C616C71224F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbjEZIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbjEZIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:34:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1DA19A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:34:41 -0700 (PDT)
X-UUID: 25132328fba011ed9cb5633481061a41-20230526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LtpSnBU4RktKotGADfFbmjgamuL4mEXAn5Y+1UGOKkE=;
        b=Ie5jfpay58e4LE74AhdoKY9EcZQ41LIXARDxzhRhU1NULi2J5FTW0tIW/7at3AEe1WyPjr/LfEkTb5+1cORj+5N4P7cEizQwynpIz9y6+fnakjq3tnHqnoxS0reQRZml9vEiRAopqoSYQvXu5qZmdam+SjTGE5+GReX+YFRz3pI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:8cc894bc-f91d-4f52-b7a1-e9938c74c3cf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.25,REQID:8cc894bc-f91d-4f52-b7a1-e9938c74c3cf,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:d5b0ae3,CLOUDID:9611733c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230526163436YH6BMYRB,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 25132328fba011ed9cb5633481061a41-20230526
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1718539834; Fri, 26 May 2023 16:34:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 16:34:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 16:34:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAx7ew2wtCZd/JyTFONrA4o+0l4Qu7D7ZJZF+Y5/tEPKDira2EXbYfX54sp0eMaAU/6drMdxvG5LY3kT9aL0SteQF0qQqpMKqNG0eRHYxzKsm6daOakBC7VmVJj8QwioibeRC8+hemxQIbLuCUCNSfOAeQgxYA6jUyCsAZzYuAcqWfJ04S2y53TNH9DrTknX62jdlyF2k1+ik3izb7KZqaKr3fpRrU22SqP3bWzuiG3t0uHukWyNrl/S5q6M0pn7BrBdrJ2DO7yhz2byjSOgfbi1gLklHIxbW13/4TveOM41+oHcAd4DLvF/CbvGGHMOQe7nhpngzrjxtO3qaVkP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtpSnBU4RktKotGADfFbmjgamuL4mEXAn5Y+1UGOKkE=;
 b=SoMNwI33JC+XniheFS2ID04nk+mLB9hIvXaTqbgBM/SkD4NV0Y5w1kmmGg/0kTm9NN/cGUCmQuCUL7WBGyxRiSgPqUyQp8mCTW6y31JBaUIWTTTgpTQRfaJ9GlMkzS/p/ywDnAoXRm5m01jhDeDn9xdgMNaNQSDHXXyDQnNGD6iL1FcqZzYd4OUkywxOsfcQ5QrxD5XfKr2GNLE+wYQOAa/k24cKrxFSBUVJb27l2dssToYFGJ6h4EVovnLIO6KTseXIkkacs4RYP3bzSx+E/SL3SpsxZl0gaYSpSB5pBgVdmqMYHF1CnouSprorapghaJ6P2X0/q53fTMflPCSRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtpSnBU4RktKotGADfFbmjgamuL4mEXAn5Y+1UGOKkE=;
 b=WZGrZvqYreX5HDUT9kcAWYEB3PmqR5HfhLCzf6TjTtQ1Ng/pLxmoAHlA7sjy9lxAzyTlPZDIl7BNSty4BlqDiblZngCzr8r98CvAznxTfVQ7aPvjh/OSj+GsaWJgZouNoVwkRFBLpGQgv7Xd0zCJXuyy9KEqZ2LbAWLp9QqmLNo=
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com (2603:1096:4:142::9) by
 SI2PR03MB6461.apcprd03.prod.outlook.com (2603:1096:4:1a1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27; Fri, 26 May 2023 08:27:26 +0000
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458]) by SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458%6]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 08:27:26 +0000
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
Thread-Index: AQHZXjkW4Q3uqsjo4k+WdVF9MbgoKa9m8tgAgAFeTYCAACz2AIAA6CqAgAAU6gCAAELGAIAC3WWA
Date:   Fri, 26 May 2023 08:27:25 +0000
Message-ID: <5dc13e13143aaffc4477fb9dcf565070cf1a9822.camel@mediatek.com>
References: <20230324101130.14053-1-jia-wei.chang@mediatek.com>
         <20230324101130.14053-5-jia-wei.chang@mediatek.com>
         <ZGuuVPCqgpUO6p0Q@makrotopia.org>
         <a1793745-eae3-cae5-49fc-2e75fe0847f0@collabora.com>
         <ZGz55oEEAhlWZajK@makrotopia.org>
         <3054e2d9-7f77-a22a-293d-382f19494079@collabora.com>
         <4e5a8202f7446481def19e5926d1bfd6e6568dd7.camel@mediatek.com>
         <ZG4GNpxdbZ4TNq3K@makrotopia.org>
In-Reply-To: <ZG4GNpxdbZ4TNq3K@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5830:EE_|SI2PR03MB6461:EE_
x-ms-office365-filtering-correlation-id: 15b08b40-4360-4608-b584-08db5dc30965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXv32f+Hocirua0/r2PTQCJp+/FGvwB4wRS+F6I0g20wfMammaxcMVAB0mLv/klunLaKyVoulMiu34MFwpSjcbMb/yX+x1mXH8H1puuUn/00i/I2QGxhXtvJefXRRXESb8N5xWdmyHXORSZH4mLclXCFb+9Wb7VBN4oX65388PBynu5wvRboN1rMhWC1eNJFr5xXMuBqXs2adtak2RdUpMT3ORRPR0uShcBYM1cNjNsvmHbQyuqVPwj4D5gvx0dY2LQ7nfLG4F249p3vCeM6VfKr+GCgVG2hj/Ty2SqkVdsAI1JgAKhR2TKUUQeZhPj7mDtTvXminfGurxsz5OSjIE8490ANQbrKMSjgL//8K1ULfFL1oieWy6mA1Kj+zbMBP3Ghb9cwvuzEUiwjKWSLRbxJBjcjm7iQCLMXbpaAWvfpznQTcdM5KB9oAx1b8Kc5dcvpOCkA8HDbzigSv292lRL59+To8dz+xJwM6zqmGtBuV8SMJBmf6+ji/KG41YhNfeg5pt9nBDXvmswq0+Rp34tBAvTFdNBSt7lw78N0d9WK7iNvHCYXLCm5UQkAbqzV3Pf1Z6v+blK6D9WwZ2dOJE9dzkhc/JqYMNJUDRzKKIRAbY847g7BYCjyofU8JFzIMXpdVV8M38FGuF0ZUl/VaJVkONQtUu7SjLx0sE+yl5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5830.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(66446008)(8676002)(5660300002)(7416002)(8936002)(186003)(36756003)(86362001)(2906002)(83380400001)(38070700005)(85182001)(122000001)(2616005)(38100700002)(6506007)(6512007)(26005)(4326008)(6916009)(316002)(66556008)(76116006)(64756008)(91956017)(71200400001)(66476007)(66946007)(54906003)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzRMQVNMMHRuUnIzT0NxS2NmRkR2VXVBUHduc25UZ3hrY25wdWZ4aHFNdHBO?=
 =?utf-8?B?RUd5bnRNS0VvUll4RWFHeXh6QTcxUU0xR1lFY2t2c25PT2VGR3hSQkZ4bHhO?=
 =?utf-8?B?ZEZFYnBLaW9wR241N29aRnhEemxZUEZjZFZ2dzBBMWpKOExXeEp1bTZYU2VF?=
 =?utf-8?B?YkpVWnd0V21zQVVwK2FyMFMrSk1qOC9zaXBsNmNlU1JxVjdtZ1VCMm90V0tJ?=
 =?utf-8?B?dDFkUTJlRUt5Y3IwY0ZSeER3cVBxTHl6cFNHNWpoSWRXajd6YVBvNjhOVnZ2?=
 =?utf-8?B?TlhWRlZsOU1ta09tTzBwRk9aQ1hYZCtYT2M5NnlpWVBpbGtVSU11aktWRWg3?=
 =?utf-8?B?aTZSWG1oUENrMlhHK3ZqMkpFblRiZW5HY00rK3ZEOVNDUVBLODlqYmd3VzZy?=
 =?utf-8?B?R1B6RFQrYkVDenR1dkJvakVod3ZuU3NyNjlGU2JyWUZ2RlZKWllFbHMzL1hR?=
 =?utf-8?B?N0Nqd2d0MXhFZnZLMEtqSTJXUGpkRWtnbFk2alhPVWFWQnN5VHVxbE83a09M?=
 =?utf-8?B?d1IrRTZBakpZMm92dnpka3FzbkhSUHFFLzl4Wk9QOXdodElxcnIyUDgxVjN3?=
 =?utf-8?B?V0NIa056V1NhVTdHMEM3VG5NeEEwcGEyMnM0Znhray94TU1obCs2Z2x4UHBv?=
 =?utf-8?B?YVdMU3dLNHFBb2NmeDFmc3preER1UFVRRkYvcE15dFlDa1JyakJzeGtQUHBC?=
 =?utf-8?B?TGpleFJ4WUF4NHZ2cUNOVVBiNlhFd05mSFlqK0p3M3VGdHh3aEZtK2tZaXBr?=
 =?utf-8?B?UmRvaWxnZHdnMUR3L3plSXNXT0JjdjI1eDlSa2psSURaS0FhSnZyNTdwRHBj?=
 =?utf-8?B?MDkxZHhtV0FXcHFHSXVsRGUrVndybElEZVNtcktxZ05URXQzMHJmNWNGbkwy?=
 =?utf-8?B?ZE1ndWhSNHVRQUVSSzBtMVJZMWYxVk5ueGhybXJlNFBHSHFZdzV2elV3N2d2?=
 =?utf-8?B?VlJzT2FwazJRa1FEY1BMdU04UDFZemRPK2VPOEoreXBqZGgxRGhBSkNTTVFj?=
 =?utf-8?B?MDBzNG9YNGZzRFp6cnZoVW90RW9wVUJFVUVyOUpEL0xrU3hOeU1xWjB5QmJB?=
 =?utf-8?B?d1RLaHFYMldVVFc5Ni96T2l5SEF6Y1pOMnZnMFFmT01yWUJpYlk3LzhjZGtt?=
 =?utf-8?B?MzV5VGNac0Eyb3RzTVorWVp5aGhINmtQclV3NnNwVWxHTERYTTdLZU5JL3lG?=
 =?utf-8?B?dTJOWEo4ZVFMNWwyVGdpTDY1bTRCWmRNS1A1TWwwS1lPVWNHd0NWeFduZkpV?=
 =?utf-8?B?cnRSWGR0c0djVnpvdW12cXdpSzB0R0Z5WHJQZmtJRG9vTkdzS0ljaXd0Qkdq?=
 =?utf-8?B?TDFPS1NxWWNJWC9tZzVrdmUzaFB3ekVHWStzZmt5KzZsQW1ZazdyV2NieWNC?=
 =?utf-8?B?dU0wLzlUdHBkd0JFMVNRbFA3Sy9YN3FxeHhWa0lMVDd2WVR6ZlVNc0RPd1RM?=
 =?utf-8?B?NkhYejgvbnNFTDVvOVoyZWlnaUZ1cXhuWVR3bVF6VjcrUEZQUDNWajlMdzAz?=
 =?utf-8?B?VEZmVjZ6MVRLZWFycm5LSFRMTUFiOWlLcXM0NkFxRlBSTldBbVlpcmF5d0d1?=
 =?utf-8?B?QmpGbkNCQThEek9RL080bTdqVjVRZFR5M3JaNy9Md3ZCclkwb2Nla3dvVGtV?=
 =?utf-8?B?Vmg3Q1BDWmhEUnRHbkNQSjNIdVA0QWF4N2wyZWdZK3dKMDg3aEhUU1VuOUpY?=
 =?utf-8?B?WitmVlR5S3hSVHJMYldwUVp6STdWSmdpay9VYW1BKytiR1dzUUNqSWNNMmd1?=
 =?utf-8?B?WlpKbHpNRWNITUNtK2JrZGNFUk1ROVRUdmJNbm9NVCsxdnBQUVgwWE9yRFVP?=
 =?utf-8?B?SDZlUmdOdDZ4alhRQWRkWFZ5Q0VjT0hOK3RoTVpYT0IwSjRvU215RlM5TkRj?=
 =?utf-8?B?azRoQU1UNVpxUUUyOFcrTWxQRWQzcEJPcVVNYU55dDZOUlZtS1VqajZ4aVVG?=
 =?utf-8?B?OG94alhDeFhmY2hlYVlWYUg4SElDTXJQZEp3dHl1bjkyazhoeklvbDgrbE03?=
 =?utf-8?B?bmNhbWtmNVdZMURnek5WZjlQRS9wWFJyaDJuQ253dzNTcWZCSWZSUWROVi9y?=
 =?utf-8?B?c2FmUCtEQTZqOU1PcDNReTlMSXExc28vMXdPOVpLTitVNnFNSDM4ekMvcWtu?=
 =?utf-8?B?TFQ5ME5Eb0dCbW5qUFJ2V1hUYitKbndWazJoYU14R0FJU3FpN0o3ek4zaTdK?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A727CB2C62937488D8CA1B356B41A06@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b08b40-4360-4608-b584-08db5dc30965
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 08:27:26.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7mN8HXT7SMuZ/g20KGVWnYiyjkofk4Rp+K0JQPvATQXVP5C+gC0zLvUD01sP7z/n95kkQQ1jfVkIwiV7FYPUMByw1uvqMHbF5cQbau0QTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDEzOjQyICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgMDg6NDM6MzFBTSArMDAwMCwg
SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjMtMDUtMjQg
YXQgMDk6MjggKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gd3JvdGU6DQo+
ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSWwgMjMvMDUvMjMgMTk6
MzcsIERhbmllbCBHb2xsZSBoYSBzY3JpdHRvOg0KPiA+ID4gPiBPbiBUdWUsIE1heSAyMywgMjAy
MyBhdCAwNDo1Njo0N1BNICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbA0KPiA+ID4gPiBSZWdu
byB3cm90ZToNCj4gPiA+ID4gPiBJbCAyMi8wNS8yMyAyMDowMywgRGFuaWVsIEdvbGxlIGhhIHNj
cml0dG86DQo+ID4gPiA+ID4gPiBIaSBKaWEtV2VpLA0KPiA+ID4gPiA+ID4gSGkgQW5nZWxvR2lv
YWNjaGlubywNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gRnJpLCBNYXIgMjQsIDIwMjMg
YXQgMDY6MTE6MzBQTSArMDgwMCwgamlhLXdlaS5jaGFuZw0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+IEZyb206IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiA+ID4g
PiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gRHVyaW5nIHRoZSBhZGRpdGlvbiBvZiBTUkFNIHZvbHRhZ2Ug
dHJhY2tpbmcgZm9yIENDSQ0KPiA+ID4gPiA+ID4gPiBzY2FsaW5nLA0KPiA+ID4gPiA+ID4gPiB0
aGlzDQo+ID4gPiA+ID4gPiA+IGRyaXZlciBnb3Qgc29tZSB2b2x0YWdlIGxpbWl0cyBzZXQgZm9y
IHRoZSB2dHJhY2sNCj4gPiA+ID4gPiA+ID4gYWxnb3JpdGhtOg0KPiA+ID4gPiA+ID4gPiB0aGVz
ZQ0KPiA+ID4gPiA+ID4gPiB3ZXJlIG1vdmVkIHRvIHBsYXRmb3JtIGRhdGEgZmlyc3QsIHRoZW4g
ZW5mb3JjZWQgaW4gYQ0KPiA+ID4gPiA+ID4gPiBsYXRlcg0KPiA+ID4gPiA+ID4gPiBjb21taXQN
Cj4gPiA+ID4gPiA+ID4gNmExN2IzODc2YmM4ICgiY3B1ZnJlcTogbWVkaWF0ZWs6IFJlZmluZQ0K
PiA+ID4gPiA+ID4gPiBtdGtfY3B1ZnJlcV92b2x0YWdlX3RyYWNraW5nKCkiKQ0KPiA+ID4gPiA+
ID4gPiB1c2luZyB0aGVzZSBhcyBtYXggdmFsdWVzIGZvciB0aGUgcmVndWxhdG9yX3NldF92b2x0
YWdlKCkNCj4gPiA+ID4gPiA+ID4gY2FsbHMuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiBJbiB0aGlzIGNhc2UsIHRoZSB2c3JhbS92cHJvYyBjb25zdHJhaW50cyBmb3IgTVQ3NjIyIGFu
ZA0KPiA+ID4gPiA+ID4gPiBNVDc2MjMNCj4gPiA+ID4gPiA+ID4gd2VyZSBzdXBwb3NlZCB0byBi
ZSB0aGUgc2FtZSBhcyBNVDI3MDEgKGFuZCBhIG51bWJlciBvZg0KPiA+ID4gPiA+ID4gPiBvdGhl
cg0KPiA+ID4gPiA+ID4gPiBTb0NzKSwNCj4gPiA+ID4gPiA+ID4gYnV0IHRoYXQgdHVybmVkIG91
dCB0byBiZSBhIG1pc3Rha2UgYmVjYXVzZSB0aGUNCj4gPiA+ID4gPiA+ID4gYWZvcmVtZW50aW9u
ZWQgdHdvDQo+ID4gPiA+ID4gPiA+IFNvQ3MnIG1heGltdW0gdm9sdGFnZSBmb3IgYm90aCBWUFJP
QyBhbmQgVlBST0NfU1JBTSBpcw0KPiA+ID4gPiA+ID4gPiAxLjM2Vi4NCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+IEZpeCB0aGF0IGJ5IGFkZGluZyBuZXcgcGxhdGZvcm0gZGF0YSBmb3Ig
TVQ3NjIyLzc2MjMNCj4gPiA+ID4gPiA+ID4gZGVjbGFyaW5nIHRoZQ0KPiA+ID4gPiA+ID4gPiBy
aWdodCB7cHJvYyxzcmFtfV9tYXhfdm9sdCBwYXJhbWV0ZXIuDQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiBGaXhlczogZWFkODU4YmQxMjhkICgiY3B1ZnJlcTogbWVkaWF0ZWs6IE1vdmUg
dm9sdGFnZQ0KPiA+ID4gPiA+ID4gPiBsaW1pdHMNCj4gPiA+ID4gPiA+ID4gdG8gcGxhdGZvcm0g
ZGF0YSIpDQo+ID4gPiA+ID4gPiA+IEZpeGVzOiA2YTE3YjM4NzZiYzggKCJjcHVmcmVxOiBtZWRp
YXRlazogUmVmaW5lDQo+ID4gPiA+ID4gPiA+IG10a19jcHVmcmVxX3ZvbHRhZ2VfdHJhY2tpbmco
KSIpDQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gPiA+ID4gPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPg0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKaWEtV2VpIENoYW5nIDxqaWEtd2Vp
LmNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ICAg
IGRyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMgfCAxMyArKysrKysrKysrKy0tDQo+
ID4gPiA+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMNCj4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL2Nw
dWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5jDQo+ID4gPiA+ID4gPiA+IGluZGV4IDc2NGU0ZmJkZDUz
Ni4uOWEzOWE3Y2NmYWU5IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2NwdWZy
ZXEvbWVkaWF0ZWstY3B1ZnJlcS5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJl
cS9tZWRpYXRlay1jcHVmcmVxLmMNCj4gPiA+ID4gPiA+ID4gQEAgLTY5Myw2ICs2OTMsMTUgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdA0KPiA+ID4gPiA+ID4gPiBtdGtfY3B1ZnJlcV9wbGF0Zm9ybV9k
YXRhIG10MjcwMV9wbGF0Zm9ybV9kYXRhID0gew0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAgIC5j
Y2lmcmVxX3N1cHBvcnRlZCA9IGZhbHNlLA0KPiA+ID4gPiA+ID4gPiAgICB9Ow0KPiA+ID4gPiA+
ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY3B1ZnJlcV9wbGF0Zm9ybV9kYXRhDQo+ID4g
PiA+ID4gPiA+IG10NzYyMl9wbGF0Zm9ybV9kYXRhID0gew0KPiA+ID4gPiA+ID4gPiArICAubWlu
X3ZvbHRfc2hpZnQgPSAxMDAwMDAsDQo+ID4gPiA+ID4gPiA+ICsgIC5tYXhfdm9sdF9zaGlmdCA9
IDIwMDAwMCwNCj4gPiA+ID4gPiA+ID4gKyAgLnByb2NfbWF4X3ZvbHQgPSAxMzYwMDAwLA0KPiA+
ID4gPiA+ID4gPiArICAuc3JhbV9taW5fdm9sdCA9IDAsDQo+ID4gPiA+ID4gPiA+ICsgIC5zcmFt
X21heF92b2x0ID0gMTM2MDAwMCwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpcyBjaGFu
Z2UgYnJlYWtzIGNwdWZyZXEgKHdpdGggb25kZW1hbmQgc2NoZWR1bGVyKSBvbiBteQ0KPiA+ID4g
PiA+ID4gQlBpDQo+ID4gPiA+ID4gPiBSNjQNCj4gPiA+ID4gPiA+IGJvYXJkIChoYXZpbmcgTVQ3
NjIyQVYgU29DIHdpdGggTVQ2MzgwTiBQTUlDKS4NCj4gPiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+
ID4gWyAgICAyLjU0MDA5MV0gY3B1ZnJlcTogX190YXJnZXRfaW5kZXg6IEZhaWxlZCB0byBjaGFu
Z2UNCj4gPiA+ID4gPiA+IGNwdQ0KPiA+ID4gPiA+ID4gZnJlcXVlbmN5OiAtMjINCj4gPiA+ID4g
PiA+IFsgICAgMi41NTY5ODVdIGNwdSBjcHUwOiBjcHUwOiBmYWlsZWQgdG8gc2NhbGUgdXAgdm9s
dGFnZSENCj4gPiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+ID4gKHJlcGVhdGluZyBhIGxvdCwgZXZl
cnkgdGltZSB0aGUgaGlnaGVzdCBvcGVyYXRpbmcgcG9pbnQgaXMNCj4gPiA+ID4gPiA+IHNlbGVj
dGVkDQo+ID4gPiA+ID4gPiBieSB0aGUgY3B1ZnJlcSBnb3Zlcm5vcikNCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBNVDYzODBOIGRvZXNuJ3Qgc3VwcG9y
dCAxMzYwMDAwdVYgb24NCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gc3VwcGx5DQo+ID4g
PiA+ID4gPiBvdXRwdXRzIHVzZWQgZm9yIFNSQU0gYW5kIHByb2Nlc3Nvci4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gQXMgZm9yIHNvbWUgcmVhc29uIGNwdWZyZXEtbWVkaWF0ZWsgdHJpZXMg
dG8gcmlzZSB0aGUgU1JBTQ0KPiA+ID4gPiA+ID4gc3VwcGx5DQo+ID4gPiA+ID4gPiB2b2x0YWdl
IHRvIHRoZSBtYXhpbXVtIGZvciBhIHNob3J0IG1vbWVudCAocHJvYmFibHkgYSBzaWRlLQ0KPiA+
ID4gPiA+ID4gZWZmZWN0IG9mDQo+ID4gPiA+ID4gPiB0aGUgdm9sdGFnZSB0cmFja2luZyBhbGdv
cml0aG0pLCB0aGlzIGZhaWxzIGJlY2F1c2UgdGhlDQo+ID4gPiA+ID4gPiBQTUlDDQo+ID4gPiA+
ID4gPiBvbmx5DQo+ID4gPiA+ID4gPiBzdXBwb3J0cyB1cCB0byAxMzUwMDAwdVYuIEFzIHRoZSBo
aWdoZXN0IG9wZXJhdGluZyBwb2ludCBpcw0KPiA+ID4gPiA+ID4gYW55d2F5DQo+ID4gPiA+ID4g
PiB1c2luZyBvbmx5IDEzMTAwMDB1ViB0aGUgc2ltcGxlIGZpeCBpcyBzZXR0aW5nIDEzNTAwMDB1
ViBhcw0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBtYXhpbXVtDQo+ID4gPiA+ID4gPiBp
bnN0ZWFkIGZvciBib3RoIHByb2NfbWF4X3ZvbHQgYW5kIHNyYW1fbWF4X3ZvbHQuDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IEEgc2ltaWxhciBzaXR1YXRpb24gYXBwbGllcyBhbHNvIGZvciBC
UGkgUjIgKE1UNzYyM05JIHdpdGgNCj4gPiA+ID4gPiA+IE1UNjMyM0wNCj4gPiA+ID4gPiA+IFBN
SUMpLCBoZXJlIHRoZSBtYXhpbXVtIHN1cHBvcnRlZCB2b2x0YWdlIG9mIHRoZSBQTUlDIHdoaWNo
DQo+ID4gPiA+ID4gPiBhbHNvIG9ubHkNCj4gPiA+ID4gPiA+IHN1cHBvcnRzIHVwIHRvIDEzNTAw
MDB1ViwgYW5kIHRoZSBTb0MgaGF2aW5nIGl0cyBoaWdoZXN0DQo+ID4gPiA+ID4gPiBvcGVyYXRp
bmcNCj4gPiA+ID4gPiA+IHZvbHRhZ2UgZGVmaW5lZCBhdCAxMzAwMDAwdVYuDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IElmIGFsbCBhZ3JlZSB3aXRoIHRoZSBzaW1wbGUgZml4IEkgd2lsbCBw
b3N0IGEgcGF0Y2ggZm9yDQo+ID4gPiA+ID4gPiB0aGF0Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBIb3dldmVyLCB0byBtZSBpdCBmZWVscyBmaXNoeSB0byBiZWdpbiB3aXRoIHRoYXQgdGhl
DQo+ID4gPiA+ID4gPiB0cmFja2luZw0KPiA+ID4gPiA+ID4gYWxnb3JpdGhtDQo+ID4gPiA+ID4g
PiB0cmllcyB0byByaXNlIHRoZSB2b2x0YWdlIGFib3ZlIHRoZSBoaWdoZXN0IG9wZXJhdGluZyBw
b2ludA0KPiA+ID4gPiA+ID4gZGVmaW5lZCBpbg0KPiA+ID4gPiA+ID4gZGV2aWNlIHRyZWUsIHNl
ZSBoZXJlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA2YTE3YjM4NzZiYzgzMCBkcml2ZXJz
L2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5jIChKaWEtV2VpDQo+ID4gPiA+ID4gPiBDaGFuZyAg
ICAgICAgICAgICAgMjAyMi0wNS0wNSAxOTo1MjoyMCArMDgwMA0KPiA+ID4gPiA+ID4gMTAwKSAg
ICBuZXdfdnNyYW0NCj4gPiA+ID4gPiA+ID0gY2xhbXAobmV3X3Zwcm9jICsgc29jX2RhdGEtPm1p
bl92b2x0X3NoaWZ0LA0KPiA+ID4gPiA+ID4gNmExN2IzODc2YmM4MzAgZHJpdmVycy9jcHVmcmVx
L21lZGlhdGVrLWNwdWZyZXEuYyAoSmlhLVdlaQ0KPiA+ID4gPiA+ID4gQ2hhbmcgICAgICAgICAg
ICAgIDIwMjItMDUtMDUgMTk6NTI6MjAgKzA4MDANCj4gPiA+ID4gPiA+IDEwMSkgICAgICAgICAg
ICAgICAgICAgICAgc29jX2RhdGEtPnNyYW1fbWluX3ZvbHQsDQo+ID4gPiA+ID4gPiBzb2NfZGF0
YS0NCj4gPiA+ID4gPiA+ID4gc3JhbV9tYXhfdm9sdCk7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IEhvd2V2ZXIsIEkgZGlkIG5vdCBpbnZlc3RpZ2F0ZSBpbiBkZXB0aCB0aGUgcHVycG9zZSBv
ZiB0aGlzDQo+ID4gPiA+ID4gPiBpbml0aWFsIHJpc2UgYW5kIGNhbiBpbXBvc3NpYmx5IHRlc3Qg
bXkgbW9kaWZpY2F0aW9ucyB0bw0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiB0cmFja2lu
ZyBhbGdvcml0aG0gb24gYWxsIHN1cHBvcnRlZCBTb0NzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gVGhhbmtzIGZvciBhY3R1YWxseSByZXBvcnRpbmcgdGhhdCwgSSBkb24n
dCB0aGluayB0aGF0DQo+ID4gPiA+ID4gdGhlcmUncw0KPiA+ID4gPiA+IGFueQ0KPiA+ID4gPiA+
IHZhbGlkIHJlYXNvbiB3aHkgdGhlIGFsZ29yaXRobSBzaG91bGQgc2V0IGEgdm9sdGFnZSBoaWdo
ZXINCj4gPiA+ID4gPiB0aGFuDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gbWF4aW11bSB2b3Rh
Z2Ugc3BlY2lmaWVkIGluIHRoZSBmYXN0ZXN0IE9QUC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBB
bnl3YXkgLSB0aGUgbG9naWMgZm9yIHRoZSBwbGF0Zm9ybSBkYXRhIG9mIHRoaXMgZHJpdmVyIGlz
IHRvDQo+ID4gPiA+ID4gZGVjbGFyZQ0KPiA+ID4gPiA+IHRoZSBtYXhpbXVtIHZvbHRhZ2UgdGhh
dCBTb0MgbW9kZWwgWCBzdXBwb3J0cywgcmVnYXJkbGVzcyBvZg0KPiA+ID4gPiA+IHRoZQ0KPiA+
ID4gPiA+IGFjdHVhbA0KPiA+ID4gPiA+IGJvYXJkLXNwZWNpZmljIE9QUHMsIHNvIHRoYXQgcGFy
dCBpcyByaWdodDsgdG8gc29sdmUgdGhpcw0KPiA+ID4gPiA+IGlzc3VlLA0KPiA+ID4gPiA+IEkg
Z3Vlc3MNCj4gPiA+ID4gPiB0aGF0IHRoZSBvbmx5IHdheSBpcyBmb3IgdGhpcyBkcml2ZXIgdG8g
cGFyc2UgdGhlIE9QUHMgZHVyaW5nDQo+ID4gPiA+ID4gLnByb2JlKCkNCj4gPiA+ID4gPiBhbmQg
dGhlbiBhbHdheXMgdXNlIGluIHRoZSBhbGdvcml0aG0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAg
ICAgIHZwcm9jX21heCA9IG1heChwcm9jX21heF92b2x0LCBvcHBfdnByb2NfbWF4KTsNCj4gPiA+
ID4gPiAgICAgIHZzcmFtX21heCA9IG1heChzcmFtX21heF92b2x0LCB2c3JhbV92cmVnX21heCk7
DQo+ID4gDQo+ID4gSGkgRGFuaWVsLCBBbmdlbG8gU2lyLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3Ig
dGhlIGlzc3VlIHJlcG9ydCBhbmQgc3VnZ2VzdGlvbnMuDQo+ID4gDQo+ID4gSXMgaXQgcG9zc2li
bGUgdG8gbW9kaWZ5IHRoZSB2YWx1ZSBvZiBwcm9jX21heF92b2x0IGFuZA0KPiA+IHNyYW1fbWF4
X3ZvbHQNCj4gPiB0byAxMzEwMDAwIGluIG10NzYyMl9wbGF0Zm9ybV9kYXRhIGFzIHRoZSBoaWdo
ZXN0IHZvbHRhZ2UgZGVjbGFyZWQNCj4gPiBpbg0KPiA+IG10NzYyMi5kdHNpIGFuZCB0aGVuIGdp
dmUgaXQgYSB0cnk/DQo+ID4gDQo+ID4gU29ycnksIEkgbmVlZCBzb21lb25lIGhlbHAgdG8gY2hl
Y2sgdGhpcyBvbiBtdDc2MjIgc2luY2UgSSBkb24ndA0KPiA+IGhhdmUNCj4gPiBtdDc2MjIgcGxh
dGZvcm0uLg0KPiANCj4gVW5mb3J0dW5hdGVseSBhbHNvIHNldHRpbmcgcHJvY19tYXhfdm9sdCBh
bmQgc3JhbV9tYXhfdm9sdCB0byAxMzEwMDAwDQo+IGRvZXNuJ3Qgd29yazoNCj4gWyAgICAxLjk4
MzMyNV0gY3B1IGNwdTA6IGNwdTA6IGZhaWxlZCB0byBzY2FsZSB1cCB2b2x0YWdlIQ0KPiBbICAg
IDEuOTg4NjIxXSBjcHVmcmVxOiBfX3RhcmdldF9pbmRleDogRmFpbGVkIHRvIGNoYW5nZSBjcHUN
Cj4gZnJlcXVlbmN5OiAtMjINCj4gOjpyZXBlYXRpbmcgaW5maW5pdGVseTo6DQo+IA0KPiBUaGlz
IGlzIGJlY2F1c2UgaW4gbXQ2MzgwLXJlZ3VsYXRvci5jIHlvdSBjYW4gc2VlDQo+IHN0YXRpYyBj
b25zdCB1bnNpZ25lZCBpbnQgbGRvX3ZvbHRfdGFibGUxW10gPSB7DQo+ICAgICAgICAgMTQwMDAw
MCwgMTM1MDAwMCwgMTMwMDAwMCwgMTI1MDAwMCwgMTIwMDAwMCwgMTE1MDAwMCwNCj4gMTEwMDAw
MCwgMTA1MDAwMCwNCj4gfTsNCj4gDQo+IFNvIDEzMTAwMDAgaXMgbm90IGFtb25nIHRoZSBzdXBw
b3J0ZWQgdm9sdGFnZXMgYnV0IG1lZGlhdGVrLWNwdWZyZXEuYw0KPiB3aWxsIHJlcGVhdGVkbHkg
Y2FsbA0KPiByZWd1bGF0b3Jfc2V0X3ZvbHRhZ2Uoc3JhbV9yZWcsIDEzMTAwMDAsIDEzMTAwMDAp
Ow0KPiB3aGljaCB3aWxsIGZhaWwgZm9yIG9idmlvdXMgcmVhc29ucy4NCj4gDQo+IFVzaW5nIDEz
NTAwMDAgZm9yIHByb2NfbWF4X3ZvbHQgYW5kIHNyYW1fbWF4X3ZvbHQgbGlrZSBJIGhhdmUNCj4g
c3VnZ2VzdGVkDQo+IGFzIGEgc2ltcGxlIHdvcmstYXJvdW5kIGRvZXMgd29yayBiZWNhdXNlIDEz
NTAwMDAgaXMgYW1vbmcgdGhlDQo+IHN1cHBvcnRlZA0KPiB2b2x0YWdlcyBvZiB0aGUgTVQ2Mzgw
IHJlZ3VsYXRvci4NCj4gDQo+IE9uIE1UNzYyMyB0aGUgd2hvbGUgcHJvYmxlbSBpcyBhbnl3YXkg
bm9uLWV4aXN0ZW50IGJlY2F1c2UgdGhlcmUgaXMNCj4gbm8NCj4gc2VwYXJhdGUgc3JhbS1zdXBw
bHksIGhlbmNlIHRoZSB0cmFja2luZyBhbGdvcml0aG0gaXNuJ3QgdXNlZCBhdCBhbGwuDQo+IA0K
DQpFeGFjdGx5Lg0KDQpGb3IgTVQ3NjIyIHBsYXRmb3JtIGRhdGEsIEkgdGhpbmsgaXQgaXMgcHJv
cGVyIHRvIGNvbmZpZ3VyZSBhczoNCi5wcm9jX21heF92b2x0ID0gMTMxMDAwMCwNCi5zcmFtX21h
eF92b2x0ID0gMTM1MDAwMCwgIC8vIHNpbmNlIG10NjM4MF92bV9yZWcgbGRvIG9ubHkgc3VwcG9y
dGluZw0Key4uLiwgMTMwMDAwMCwgMTM1MDAwMCwgMTQwMDAwMH0gYXMgeW91IG1lbnRpb25lZC4N
Cg0KRm9yIE1UNzYyMyBwbGF0Zm9ybSBkYXRhLCBpdCBpcyByZXF1aXJlZCB0byBhZGQgYSBuZXcg
b25lLg0KLnByb2NfbWF4X3ZvbHQgPSAxMzAwMDAwLA0KLnNyYW1fbWF4X3ZvbHQgPSAwLCAgLy8g
c2luY2Ugbm8gc3JhbS1zdXBwbHkgbGlrZSB5b3Ugc2FpZC4NCg0KSWYgTVQ3NjIyIGFuZCBNVDc2
MjMgc3VwcGxpZWQgdm9sdGFnZSBpc3N1ZXMgY2FuIGJlIGZpeGVkIGJ5IGFib3ZlDQpwbGF0Zm9y
bSBkYXRhLCBmZWVsIGZyZWUgdG8gc2VuZCB0aGUgZml4IHBhdGNoIG9yIGluZm9ybSBtZSB0byBk
byB0aGF0Lg0KDQpUaGFua3MgZm9yIHlvdXIgaGVscCEgOikNCg0KPiA+IA0KPiA+IFRoYW5rcy4N
Cj4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFlvdSBwcm9iYWJseSBtZWFudCB0byB3cml0ZQ0KPiA+
ID4gPiB2cHJvY19tYXggPSBtaW4ocHJvY19tYXhfdm9sdCwgb3BwX3Zwcm9jX21heCk7DQo+ID4g
PiA+IHZzcmFtX21heCA9IG1pbihzcmFtX21heF92b2x0LCB2c3JhbV92cmVnX21heCk7DQo+ID4g
PiA+IA0KPiA+ID4gPiByaWdodD8NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEFwcGFyZW50bHks
IHNvbWUgb2YgbXkgYnJhaW5jZWxscyB3YXMgYXBwYXJlbnRseSB0YWtpbmcgYSBicmVhay4NCj4g
PiA+IDotKQ0KPiA+ID4gDQo+ID4gPiBZZXMsIEkgd2FzIG1lYW5pbmcgbWluKCksIG5vdCBtYXgo
KSA6LSkNCj4gPiA+IA0KPiA+ID4gQ2hlZXJzIQ0KPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gSmlhLVdlaSwgY2FuIHlvdSBwbGVhc2UgaGFuZGxlIHRoaXM/DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+IEFuZ2Vsbw0KPiA+ID4gPiA+IA0KPiA+ID4gDQo+ID4g
PiANCj4gPiA+IA0K
