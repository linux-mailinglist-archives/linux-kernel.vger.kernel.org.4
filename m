Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95FD66B826
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjAPHZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjAPHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:25:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9996CDE1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:24:58 -0800 (PST)
X-UUID: de5e3658956e11eda06fc9ecc4dadd91-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TrdENzasEFo/7kzHyHp3lM189mlED1Pv0ol2WyrhGqk=;
        b=F2bDqZmnvrhNV1v5eff2jwNa4rmpD8efKw8td4cwoPnIuFrnATu/mQpsP1eyN6wVpKhqvRvrSAyBeM5Y7hjmc6q7MlPHpPr/30G4TAs1pY+knOJ27begc0kGpemDuN9GIZJ4bFmhydojRPL15znPPssXC8y3jhoN3FacFNe81z0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:fa7b1def-05f6-4944-bd24-9fdad54f9818,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:fa7b1def-05f6-4944-bd24-9fdad54f9818,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:130ec254-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230114021304YBKD6RBN,BulkQuantity:19,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: de5e3658956e11eda06fc9ecc4dadd91-20230116
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 543204987; Mon, 16 Jan 2023 15:24:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 15:24:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 15:24:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsIO90c/F4/JT2/XA0e/SHbKByG3MSTB/D49IfrFVVm+bOPNHRUbmA/ssf9HzkEQ1UDibMrfP75kiDqsv9VV7D9idrvEaOUAQVrIPCG1nrF6Ze0kxmT4kK7HjTmU2sDTTxCoOXWBW4iScGQ0Q5Vo57htp4u3F6xejl1ioepkthkrdiFSgu6uD6eaCUulwTk/vPHu/eyT1uyV+1Y128LPpkfoJG5b5tHgPeTYGvKpd/hx/HlLSVRWK1ehGDBGqClFoeAFdv5o7Mjc3b2w48cHSyjc3K4mjWic6TxnSCALsqaz6rcvNZJ9a8+tMfq9MCV8s0DOrlwtARSRe2pgtzOhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrdENzasEFo/7kzHyHp3lM189mlED1Pv0ol2WyrhGqk=;
 b=lV0eqHPd8g6fCTcuL1fcvME8wLAR2nPdfbBqNF/4RZqxSceb2DPapjHfNY64LV/JfVMrz/BSBYyCz4nHDRbrtHD3sKI8EHfICKhnS5EYAHGl0AkDanYnTUx+KszjSKHvHX7X9EqB+HbDlerwLEnMUHPBH7hVvIOXKEHrvNNpAE5V+sjDiF72DboZeldiH1vxKvWBsRe4/eBVm/SBUjXqBCyAuAMZmn6ji4zpXFaxRKJRxMsKqQ4FA41sXSNGCby27ius8KGdkfUZD5gw6Fu4X222hccelV+9DcAEUy9BmDx9FmICAi0jrVSTpBS+SeTOs5IBiz3zN0jJWA/Fm8NVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrdENzasEFo/7kzHyHp3lM189mlED1Pv0ol2WyrhGqk=;
 b=ZYCEYosgM9kcswICGNkSPTZ1gQSwQxfA3heGaC3KakRxQ7DPqVy2D5qJ/ZHW7WKfOfBpToKFAEohGBgS0tWX46xktlD6Eqqt+Z2HnP2hmvnXPIxYhAxtb5U+RQkJQO+8qzdZiFuSZXtVHQ3gD6UnnMDkeeUFg0r8ZllOfl/MrG4=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB6239.apcprd03.prod.outlook.com (2603:1096:820:a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 07:24:49 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 07:24:49 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Topic: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Index: AQHZIEA7g6q5Ep2afU2pWWp4HJGwLq6ctM8AgAQB6wA=
Date:   Mon, 16 Jan 2023 07:24:48 +0000
Message-ID: <f7929b3f6e1b703e5130181ff043f646df1974ad.camel@mediatek.com>
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
         <Y8GfJpirOrRdOKLs@matsya>
In-Reply-To: <Y8GfJpirOrRdOKLs@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|KL1PR03MB6239:EE_
x-ms-office365-filtering-correlation-id: bc0de9f3-96e8-4c0d-b93a-08daf792c04e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SEvdQ3xTVtEkb4ZDxAShspUiyGmBgpGdntSAZYcAfUBCcZbSeDh1jF5WB+/19TzeyQPzBKXuIU41YSfjJhn0+6Y9yV7pyKxZbo8aszC1P1eKm2OpoWhlZkCnEmdZ0ZBCjA5xnRA2NR8uTzUwNsvCatNwq66BJwWsLJkmah+DIpe1UkA6ucI7PIZ3HpAlT6fGq0/tgprc+QAQaTrGQyl/BFQxIrPbRyagKcWM446MQFzV0nuklmUV1zNQuP5HkEjpDH3WCcS2qUVaze7c/opU3Cl0jVBK4NXdXmmPnmmnp2QK/EPmq2j7rPUgMYWOwt0TDLpzEuz2c1WGFldP2DkzZBOQMqj8jA/p42UIXuLZt/Ux07KgtTPwxm5gneFekboHgl8csLiw4mV/qqs616VIr+jIYJqiD1w6jaFO/467vNQ5WJkMYJHcq193NmuOUfclS1ccf5g9W1MXI/GzpI19rRTk5ECG6r+UNjVI7Txrr32piyOUyXKWBm3Rjb3YKXKGbOpqJH5FzOSDy6KM3zdrBdk61GKeHu/8I12A6tNlOTVUNd2bvnzZsz7zIHrtLqW37sR4AN1Ufvtz93PIqRlS/iTpHzUpF59z5s4QfaUTMtDtJKCVSp2grnMzIHZU1SlJzUs5Xma5QIw6+hVYoRhimE6K7Nl7EXGYdsSOx5Z71bxN/Pajugy0zOrQJWRYf0jk/pkkpCAl1+vPcOGJ89lMwqrMn6d3MVCjrZyh5Za9XCDxkNmIitCzUrzMe0a3O9Paf/AXErjG/mW5ERb0kEO9+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(2906002)(6506007)(86362001)(83380400001)(53546011)(7416002)(66946007)(186003)(5660300002)(6486002)(26005)(8936002)(36756003)(85182001)(66476007)(41300700001)(64756008)(66556008)(478600001)(6512007)(66446008)(76116006)(54906003)(8676002)(71200400001)(6916009)(38070700005)(2616005)(316002)(122000001)(38100700002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnlqMDNWYjIyT1RGcWV2dnNRQTU5RkFjVHB2MjduWnF3bVZwQnEwTDNTd0I4?=
 =?utf-8?B?ZUNQWVZBOG1neDdIcEQ3cW5od0hGdzRjcG8rcnFsYm9yZCs2K2ZZSklaRFYw?=
 =?utf-8?B?c29DNDRKbFExdlpQN04zWmovYUM4UUtjcUI2bk8xM3MwdGtUYXlWM2IzV3BF?=
 =?utf-8?B?ZGlDbW1xNDlPVGVMbEx4R29iTVltMTRza2hmTlVjdXFkVnNMQXRhQmI0UXhw?=
 =?utf-8?B?WmljdzlzTzV2OFJHYjlIcGNNV1JmZyt2R094MFpBRDRsS0hTU0tlR3lPR2d4?=
 =?utf-8?B?c0Y1YVRGb2xlWmtHWUhzTEZCT2VBb2VPbXQ2Yk9kNjFZS1UxeVpuQnhBZlg3?=
 =?utf-8?B?Kzkza1FiOU9ZWnY1ZkQxSElkK3lPekZVMVc5cUJ5ZHZ6dHBPRWRyeU43VXA1?=
 =?utf-8?B?Mk84NXNWSDNzVGt5UVFDcTE4L2xPVzZNUjh2dWVYQWZDRG1PeENXWGRSOEpM?=
 =?utf-8?B?NnBQRnczdVFvTk0wVWU2M3B1cnZkVHM5dDJlTzNtc3JubU5rNWNETmxRZ2tW?=
 =?utf-8?B?emxnZHE3OWRCL1JKZVN1NkRtUFBEdkxwM2lPRzRoOTZEODFWdXBpODVvMTRu?=
 =?utf-8?B?bUJ1V1RKMDNheSs5clh3Y09XUXhCd2N1WU5oeWVwVWsyTFBLL1kxUDlqN2dy?=
 =?utf-8?B?Wit4czNDMkE5ZkJSYnVrb1I4aDZIOVZidnRxdEZSMytJY2xnNHViQUNlMUVC?=
 =?utf-8?B?eVNqbkNzenF5WUQrbHI1azNyK3hFZ3Bucmo5Z09iTE9zczA1Mnp6cU5ObElW?=
 =?utf-8?B?eGR6OXkvRmFBMWJCS2liM2o2dll3Zk9raDVKNzc4N3Zyeis5SWlMRSs4Q214?=
 =?utf-8?B?ZCttYkRtdzQwSGs3eVhCVm1uSUswNnRXT1d1anNFbU1aQ1doczV1dk1iTkg1?=
 =?utf-8?B?d2dwdDB5UnRCUGVVaUxVWHBYMVM3dWlqNC84aXFjdzQ2ck4xY21HSmR4ZjFm?=
 =?utf-8?B?Ni9ENjYwOWxQSkpMdkltQlM0NmxKdmNoSC9CbHdRZVY1OUY2d0NhalJRRW43?=
 =?utf-8?B?MGNQNFh6VWVONUg2S2Z4UHl1aGVhcE9qVklBVlRISEJLanZtTU9FQlQvaFpn?=
 =?utf-8?B?UUwxendsRmhSbTVkQlF4SSsrdCtkalpKRVN0VXcrSGtCbXBrdnNIT3F1REJF?=
 =?utf-8?B?VVhTMmVmcG5FK3RUdDJyVjlxQnVWVnU1N0ZCemJHVENwd2RZeEM1NVdKcmhC?=
 =?utf-8?B?dWJFd3pNVWVMQ1NDREJmb1NFYnByTXNUeHlsdFdQVTZJU1A2cFdrZ2FLT04y?=
 =?utf-8?B?ODRPcHJlT0hobENmQ1BNSm9IZ2VUUVUwcGZzRTBQTXR2R215aWdLeDgySFpO?=
 =?utf-8?B?bDlZcnoxOThvWE9UZjJuWm1ZYkt0dlFKMll3b2RsV1hFUXVxRHcxV0oreU51?=
 =?utf-8?B?TXVtUm5TVzB4dFJUYktpcmJOK0ZYTERrTmVUV0dEa3Z6SnpGMTczZ0I2cllL?=
 =?utf-8?B?aHA0ZWVYby9acjhxOGxkZG8xTW1WZU5nQTdIVElsNlJmSjZ1SkZZbTJwa3M3?=
 =?utf-8?B?cFo2eWVNUkh3anlqWVhDOWluVmNZMHhsS1l1SHZGTUxvaFpNd1l4cFQ1VE9y?=
 =?utf-8?B?bEZLang3ZjE2c3YyN0NLdzdaVjlzTWpiYVRTcUVLRlNUQzZxRnNBQXJUTG44?=
 =?utf-8?B?WndBTHdHSDN2R0VJb3dvZis0bUVsV1JZR3gxUkVkR3ZGZ1pXWEgzaUdzMkVm?=
 =?utf-8?B?OG14bXl2b1BzTnB2SEFVZElVVGY3RnBEVzJpRHpoU1lhNnFQaW1QOThPUGRL?=
 =?utf-8?B?bjhURWkvcmd1ckM0RXI4bmxtc1F6REdBVkhGaHlaZzN6WTc5UHdFM2F4WVli?=
 =?utf-8?B?akxEK3ptUURVaHVxRFFSSkkwZkFuOS83cGJGRng2NzVkZGNkQVVlbXV1QkJy?=
 =?utf-8?B?ekRnN05NQnc3VHhjblJ3VEhVLy9NOG01ZzdvRHErN2xnRjMyQ2hvOUo2UDBJ?=
 =?utf-8?B?YXIyZi9OazN3VnQ5OWdVdDRCSkdTcFBnZE11K0htNVhqS3FTZlpmeWVTR092?=
 =?utf-8?B?aWx4N01weDBMZDJlUDdaeUExVFg5cTZLRURhTndKUVdSbmlkRjhMTkxuSG9I?=
 =?utf-8?B?K2hxQVNtaG1lN0h4cWNac2dyQmt5c3VMRFNKWnA2d0hMMWIxY0VUTDFYdFUv?=
 =?utf-8?B?bEFUWklNL0srdkdVSmRmcDdleUE4Q3BVTVREVUhnZnMxVEVqc2tZbUJGN3JL?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <366474EC63724A4AB69AA0ED7C135051@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0de9f3-96e8-4c0d-b93a-08daf792c04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:24:48.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ADUToQTC0O6Q7aJrKpwKDzvqpVXfPA3dXOURI9nmvOaM+7qLOTxjJg8KUYkPvq+1vcwO+vd7StHbLzNg43i2TimlN1l7ahY6OAgfDH4mk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6239
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDIzOjQyICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAwNC0wMS0yMywgMjE6MjYsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBSZW1vdmUgdGhlIHRl
bXBvcmFyeSBAbWFza18sIHRoaXMgbWF5IGNhdXNlIGJ1aWxkIHdhcm5pbmcgd2hlbiB1c2UNCj4g
PiBjbGFuZw0KPiA+IGNvbXBpbGVyIGZvciBwb3dlcnBjLCBidXQgY2FuJ3QgcmVwcm9kdWNlIGl0
IHdoZW4gY29tcGlsZSBmb3INCj4gPiBhcm02NC4NCj4gPiB0aGUgYnVpbGQgd2FybmluZyBpcyAt
V3RhdXRvbG9naWNhbC1jb25zdGFudC1vdXQtb2YtcmFuZ2UtY29tcGFyZSwNCj4gPiBhbmQNCj4g
PiBjYXVzZWQgYnkNCj4gPiAiQlVJTERfQlVHX09OX01TRyhfX2JmX2Nhc3RfdW5zaWduZWQoX21h
c2ssIF9tYXNrKSINCj4gPiANCj4gPiBBZnRlciByZW1vdmluZyBAbWFza18sIHRoZXJlIGlzIGEg
IkNIRUNLOk1BQ1JPX0FSR19SRVVTRSIgd2hlbiBydW4NCj4gPiBjaGVja3BhdGNoLnBsLCBkdWUg
dG8gQG1hc2sgaXMgY29uc3RhbnQsIG5vIHJldXNlIHByb2JsZW0gd2lsbA0KPiA+IGhhcHBlbi4N
Cj4gPiANCj4gPiBGaXhlczogODQ1MTNlY2NkNjc4ICgicGh5OiBtZWRpYXRlazogZml4IGJ1aWxk
IHdhcm5pbmcgb2YNCj4gPiBGSUVMRF9QUkVQKCkiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjY6IG1vZGlmeSB0
aGUgdGl0bGUNCj4gDQo+IFRpdGxlIHN0aWxsIGRvZXMgbm90IHRlbGwgd2hhdCB0aGlzIHBhdGNo
IGlzLi4gSXQgdGVsbHMgbWUgZWZmZWN0IG9mDQo+IHRoZQ0KPiBwYXRjaCBidXQgbm90IHRoZSBj
aGFuZ2VzLCBwbHMgcmV2aXNlLi4uDQo+IA0KPiAicmVtb3ZlIHRlbXAgbWFzayIgY2FuIGJlIGJl
dHRlciB0aXRsZQ0KR290IGl0LCB3aWxsIG1vZGlmeSBpdCBpbiBuZXh0IHZlcnNpb24sIHRoYW5r
cw0KDQo+IA0KPiA+IHY1OiBubyBjaGFuZ2VzDQo+ID4gdjQgbmV3IHBhdGNoLCBJJ20gbm90IHN1
cmUgaXQgY2FuIGZpeCBidWlsZCB3YXJuaW5nLCBkdWUgdG8gSSBkb24ndA0KPiA+IGNyb3NzIGNv
bXBpbGUNCj4gPiAgICAgaXQgZm9yIHBvd2VycGMgdXNpbmcgY2xhbmcgaW4gb2ZmaWNlLg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWlvLmggfCA0ICsrLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1pby5oDQo+ID4g
Yi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWlvLmgNCj4gPiBpbmRleCBkMjBhZDVlNWJl
ODEuLjU4ZjA2ZGI4MjJjYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9w
aHktbXRrLWlvLmgNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWlvLmgN
Cj4gPiBAQCAtMzksOCArMzksOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbXRrX3BoeV91cGRhdGVf
Yml0cyh2b2lkDQo+ID4gX19pb21lbSAqcmVnLCB1MzIgbWFzaywgdTMyIHZhbCkNCj4gPiAgLyog
ZmllbGQgQG1hc2sgc2hhbGwgYmUgY29uc3RhbnQgYW5kIGNvbnRpbnVvdXMgKi8NCj4gPiAgI2Rl
ZmluZSBtdGtfcGh5X3VwZGF0ZV9maWVsZChyZWcsIG1hc2ssIHZhbCkgXA0KPiA+ICAoeyBcDQo+
ID4gLQl0eXBlb2YobWFzaykgbWFza18gPSAobWFzayk7CVwNCj4gPiAtCW10a19waHlfdXBkYXRl
X2JpdHMocmVnLCBtYXNrXywgRklFTERfUFJFUChtYXNrXywgdmFsKSk7IFwNCj4gPiArCUJVSUxE
X0JVR19PTl9NU0coIV9fYnVpbHRpbl9jb25zdGFudF9wKG1hc2spLCAibWFzayBpcyBub3QNCj4g
PiBjb25zdGFudCIpOyBcDQo+ID4gKwltdGtfcGh5X3VwZGF0ZV9iaXRzKHJlZywgbWFzaywgRklF
TERfUFJFUChtYXNrLCB2YWwpKTsgXA0KPiA+ICB9KQ0KPiA+ICANCj4gPiAgI2VuZGlmDQo+ID4g
LS0gDQo+ID4gMi4xOC4wDQo+IA0KPiANCg==
