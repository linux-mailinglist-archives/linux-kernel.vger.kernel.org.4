Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00546668FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbjAMH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbjAMH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:59:39 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C196B1AB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:19 -0800 (PST)
X-UUID: 2b4c34d2931811ed945fc101203acc17-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X3u/c4SmJA3aO51WS2mgBKu8IlQK0n46XIGgyksUFh4=;
        b=k5y3S1zvNAp2jSV70wRyi+gPShb7po1bhT8DIHI8WrNln/GWi8rurSwd/805j7+12+hiDaoL65sqo/k+FJZ8CaAW+HaggPEwpfXPwmDD2/ithkcP9J5vENmOKkEZLIWzN6Ay/8S5ThSR4ISHQQ4ekwvYqLzfjMw5S/i58f2D100=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:4e024dc7-aedf-48db-9442-1c5c3c630a88,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:4e024dc7-aedf-48db-9442-1c5c3c630a88,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:fc858e54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230113155915PEDXBJLE,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:1,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 2b4c34d2931811ed945fc101203acc17-20230113
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1575061550; Fri, 13 Jan 2023 15:59:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 13 Jan 2023 15:59:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 13 Jan 2023 15:59:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8REKUTeln9fnS6g21goWpmp9RrthJtdPNW3bGNWN/jiC8p8HtTPFl5zhWBgSnHcOYKayCwRyyINi7yy6jxMgXLqSOC4wAVFS0pjuUIsEjWG+se2hkEZ5d1XbihDaJIUsw0HVTW20DjCESLE63QQnWcbI+Cq+S7tVnBldjvMFCnbQ/3e+xS0jRjsXdXZKTNuKER19XL0bVGt1EH8Zoj0AtqhGpHms9N1uHxLrWzBjsSW3EFv6e42FkNtrcToZDP2ojcO5/JJIBJ2rds73rsxSj821Z/Ei1j/jA5FUHs+rcnpVrPD8GFaAugeTzPEyUhXSozAc/znAVlvSHQuWnQAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3u/c4SmJA3aO51WS2mgBKu8IlQK0n46XIGgyksUFh4=;
 b=F5Z6aKxyI5pAf/LxpV0AmjiHPq2hJvtVgZTDN0e5nmM8vHVDGumkRCZ9f3QdmeLfceQp75GeAK76IC4n6R/Ssl3b8We6Q2T4Csw7PYPRDJst8LIaaBEOalBKMcblrLmZbRK4AzCI3Cil1RDXpFEMNJzx/zT3ywIPKHHt3P3GBTWsGQMfWMmWteHrrlCfvxGfeBxy8GLndkiufT+iTuuqed23mey+sPx1WGVMzxaxqcwSCleP7mam+QppNu6LLPGqGnAaUaihLQPLc8bLGAgwakrAXiZZQwwfI8vI8UFEw4ntak1hPLMeyUUXM8aLJSmIb8EfBq7joD9aztz5qeTsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3u/c4SmJA3aO51WS2mgBKu8IlQK0n46XIGgyksUFh4=;
 b=a8pw4MOXXM1DnP7XKrvYoJRY9KSELjeBH0DM68A64HRY9+fkZJ50jUPR7Yc5iB3Ky+VNEFVPfjm9+dGBJYE5/qTWJzxSZS6ehHJ+3irw3boNivXshmBvriycZdv8SEfzWYtTYX0yj3WBkvQyNhqS6mnFdptzJQvuQ+YcowtGB+w=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by TYZPR03MB5856.apcprd03.prod.outlook.com (2603:1096:400:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 07:59:09 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::c43a:ce45:4a27:bd80]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::c43a:ce45:4a27:bd80%9]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 07:59:09 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "dvyukov@google.com" <dvyukov@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "glider@google.com" <glider@google.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] kasan: infer the requested size by scanning shadow memory
Thread-Topic: [PATCH] kasan: infer the requested size by scanning shadow
 memory
Thread-Index: AQHZH0jgINbB3ihm8EOrOsTiVH1z6q6VruoAgAZcVwA=
Date:   Fri, 13 Jan 2023 07:59:09 +0000
Message-ID: <edbcce8a1e9e772e3a3fd032cd4600bd5677c877.camel@mediatek.com>
References: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
         <CACT4Y+b5hbCod=Gj6oGxFrq5CaFPbz5T9A0nomzhWooiXQy5aA@mail.gmail.com>
In-Reply-To: <CACT4Y+b5hbCod=Gj6oGxFrq5CaFPbz5T9A0nomzhWooiXQy5aA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|TYZPR03MB5856:EE_
x-ms-office365-filtering-correlation-id: 500a0f8a-d4af-4bff-f3ba-08daf53c0d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 16tlp0J7sEeBZItS8n9ecc3EnWEAVFyYF42PBolDA983cjXyof5yBGQmtytIY/ChyTCJHJhQ72O7UrwgVLJsE7zyDYLtV1ps0VubEtd6IhJizhhdL2SyvCfnvkRMXy60epWyDfxiHO7pbmfXdyiro55ZGreLxsdar8F00JcJ8lVfZuvA8NU9a4WAsP2PHiEm3eCOmcMWsqXDPCUaO82j2xFzzTblaAp4JTtGouVFOYiOC6SsMuU7pP/sV6qZsVfHMF17vOSx/Gt0uETpqA27xKk08hH4vQABCqg4DI1ouda/g3x6fCIfi5C5aUZyrJsq5zL2bk71LFEWramKMxrHuW96yT3MdDVEZ5q0QieAn5/lC5rDwmgObEsEtELanVF85mZO42GcwghMtxEoFDfn5b2lLjDdPQOZg6j7L0g8QpqFfDiHa1lEVtOqzKba/GGJKgOUDEz1sLbjIBPlk+RUzQl8yJOAZEDKIlCYgXtLkhvJKqnlYRraXPnVEIz0sekTsgizI5leh5dgqzT5trstjjdArrQZRFWE9NChfg7R/RpmCtekYr4gFbo1SQBgJGJgg1DEfUQFW5BKcUyrl452uk+zTGmW3oN6pYy4/61zEJVjIJ5rz7eKmRI1pU0MKn+9G1+hSr21G2zrIn6TZPccxsIyIhQPrm6zkq71FEgBITQPHeRvSCYdZm0MC+zbplCOX6R1vWguNnWfKcxRjXf7tcRBBLIXu/9p5/cE3JFRj5ZKDp2rC2K9TVwiITDBjn5l0dZLjz37XoaUAQeGo6LvnkVMbvzLzg9YkFMjbfWzyHSYcczH/7rnpmIAeAQNYo6RgbRPYwf4R/fPcKxLrMo1Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(86362001)(26005)(316002)(71200400001)(6512007)(186003)(5660300002)(478600001)(6486002)(966005)(2616005)(7416002)(64756008)(91956017)(41300700001)(54906003)(6916009)(66446008)(4326008)(66476007)(66556008)(66946007)(76116006)(8936002)(83380400001)(36756003)(38070700005)(85182001)(8676002)(6506007)(38100700002)(122000001)(2906002)(99106002)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1U2Y21sOE0veHVJRE1kUnZaTkFoYmNIbExsSER3ajB2VXRCMkF0MURKMyto?=
 =?utf-8?B?bmpDdnFsLzFMTGtJSXpqTmthLzFYRzFBU3Ewa1c4TDFMQkNuL1NBaTdRVXhV?=
 =?utf-8?B?OGxKZzlxM0VLc3haUDBRT0dFQTlWNnQyd0hRMi9Kd20zQUpGVlorK24reHNK?=
 =?utf-8?B?aUhhN1NaeTh4S0xLT2JRSnBMM1NnMVRnNDRmREpDZFNwTFUvVUtFN3ppMnlU?=
 =?utf-8?B?QVRyL3ZXdENYSGJIZ3hWZVlRU1hqVTJqN2xQUUF3WGR4Mm8rWGVsVkZUdW04?=
 =?utf-8?B?KzE2VnkvY0ViT3gwcmFmTXpRM3lsTWREcWtabGdsb0JOUG9Ib0twTHR1aU16?=
 =?utf-8?B?c3J3S1BaV2E0aWNzNlM0OXBCTFhGNWRuUHRZNlk1OFhZRnZuNzJkUlZYdTdl?=
 =?utf-8?B?RmdncVk4ODV0RWxhMHBxVVZjeWs5eWhOWkpiNzJYQXJTbFd3bk8xM0ZUR2ND?=
 =?utf-8?B?cHhwT2pLVGlBVE9sa1lKTGFId0E5Q1JzQVlsUEhuWC9kcS9tVmZjZDU1NHhV?=
 =?utf-8?B?NlkrRDZWY3VoQlVZLzNwdzlBb3NGa0RGU0gyMjZxOWl2dG13YS9XOTRKTU80?=
 =?utf-8?B?TmZnUzM1QWErSkFrWkhKVEdtai9qR3hsbGJLS0RtSVRrczVjUTFwQ2p2OGEx?=
 =?utf-8?B?eC90cnJuVG5RZ2dORFo2VnJhTmxJR2NWcnIyM3ZLdHN0dndWVUorU2dvWVBH?=
 =?utf-8?B?SmlBU1p6ZkR2cGRuNFFjNEFqZDZ0VFBQNGZWU3BrdlpqcGplSTI1Nnd0cHVx?=
 =?utf-8?B?QlRPYVJXY29TNmZUWDk5TFoxaFRFeTJEcllWdEZWR1ZMSFdsK3RzL0IxUy96?=
 =?utf-8?B?cnFFblFrVXdHVmcrZHlGOHdPcEtuSURyVkE1US9MUFp3dkk3ZnZKUG1mdjNu?=
 =?utf-8?B?MjdTVkxnRDBCSmNhenpJeEN0bUUyQ25yZTFSMm1UbWJvNFo3b0NUSGtrbHNL?=
 =?utf-8?B?ME9XZFluRXdkaGRWek9kUUF5eWFqTE4wMkdPeFhsRTVmZVhaSjN2MzRrRzBi?=
 =?utf-8?B?blN3YktSUWtjUnJxRGhZVzVweVk4VWFXcHlBUXhtelAvS0dneUFGNXM3ei95?=
 =?utf-8?B?UWdiNmhNY0NzSWxJTzlJdlhGSk1YZW15cDlWUG5WMnlkT3FpZmNKYzV6dVdk?=
 =?utf-8?B?TFRZVTYyU2V6Yk5jVU92aWU2dVFUMlJaMm9lajd4WlY4Zmk4cGlSS1BML09C?=
 =?utf-8?B?NUxKYjNhMXZFdjBlci8vaGluZGtiQTBoV09nZUpSYU1CTFdJazBJSVJDK1lt?=
 =?utf-8?B?bnpXQ2NWMndsYXJCVy9KWTEyOSttaG5ZakI5bE5IYXgzMklLdERQNEZmU1lZ?=
 =?utf-8?B?TTc4dE13azNHcUdUVEtJQ1hFNlQ5NnVaRWtOTUhPZ3lsQlpoZ21WbDlYUVVO?=
 =?utf-8?B?OXB0ak13dWkrTDlJODZRYXIraDFXRDNiSXVGZEZ1SlNoaURLcEJSV3o5bWw1?=
 =?utf-8?B?Q1Q3UzM2MkJLM1ZhVURTVTdPRVB3cldEQ2hGajBkdFhmRGVkdk5SenJLRVll?=
 =?utf-8?B?Sm1DRGNST3BGOEh4dWNBMVd5R0lyQzJtN3NKTWFEMlRRRXJHMExLcU9id24y?=
 =?utf-8?B?N0N2YWswa1FhQWNFTElSYUhKRFNDemllbmRQMXFkUDg4VUN6bytDRHQ4MElJ?=
 =?utf-8?B?ckRuK25BaWlKU1NSMlpGNHJTcDFobWNvLzZHMEdraW1UMXBiK0JwS0xqd3hF?=
 =?utf-8?B?L0taNys1a29wL1NRUWRwVHdybGJSRmtxYURRemNyZ3BCNTZPYlp6cDdsd04x?=
 =?utf-8?B?OUtVMFMwNWNyQ3A4SFhUNHJxRXJ4QnJlVUNjMS9ZMXNSeW5nNlEwNmwzV2Vs?=
 =?utf-8?B?TGZ6bE14b0dYN2FyVVdtdnJ5b0dnTHpmbHdHNUpITlA1UUFrVWREejZ6U3or?=
 =?utf-8?B?ejR1QTdLZTdtaGN3ZXVxZmQ3VHUyVFA0NGVHS2tDdnk2ZEE4Vm42bGZnLzJn?=
 =?utf-8?B?N2hMaU9TOWUrbGRzS0ViOENWNmF2L3YrUVpzYW1XN2VLSnkzR011YVRWM2xB?=
 =?utf-8?B?azVDMEppdG50VG0wclBaYitTL1NDZ2hJTGFpRU9CcllVb2tXeG90TXM4R09y?=
 =?utf-8?B?VmFQZmhjUTU2cnkyU0dicUZ1djVWaTU2Y0ZSUk10TEtmUkJoN3VqSGRJYWVk?=
 =?utf-8?B?bkd4Nlh1SkpVYzh0aDd2WjVoaWQ2M29oeWx5bkx6dWFKUFNQOS9oYnNHT2F6?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBBFFEA46E45FB46BC35692726A2FB98@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500a0f8a-d4af-4bff-f3ba-08daf53c0d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 07:59:09.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ATO185TH+PM7+Ac224CxxnK9o1JFUQwUsl322ZWXfORfKQNDxLdPJS1tnhDGGhUa1FgnDmFyq7+Rs/5nqOAvrRdu8CwcWjfj72rGGH63QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5856
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

T24gTW9uLCAyMDIzLTAxLTA5IGF0IDA3OjUxICswMTAwLCBEbWl0cnkgVnl1a292IHdyb3RlOg0K
PiBPbiBUdWUsIDMgSmFuIDIwMjMgYXQgMDg6NTYsICdLdWFuLVlpbmcgTGVlJyB2aWEga2FzYW4t
ZGV2DQo+IDxrYXNhbi1kZXZAZ29vZ2xlZ3JvdXBzLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gV2Ug
c2NhbiB0aGUgc2hhZG93IG1lbW9yeSB0byBpbmZlciB0aGUgcmVxdWVzdGVkIHNpemUgaW5zdGVh
ZCBvZg0KPiA+IHByaW50aW5nIGNhY2hlLT5vYmplY3Rfc2l6ZSBkaXJlY3RseS4NCj4gPiANCj4g
PiBUaGlzIHBhdGNoIHdpbGwgZml4IHRoZSBjb25mdXNpbmcgZ2VuZXJpYyBrYXNhbiByZXBvcnQg
bGlrZSBiZWxvdy4NCj4gPiBbMV0NCj4gPiBSZXBvcnQgc2hvd3MgImNhY2hlIGttYWxsb2MtMTky
IG9mIHNpemUgMTkyIiwgYnV0IHVzZXINCj4gPiBhY3R1YWxseSBrbWFsbG9jKDE4NCkuDQo+ID4g
DQo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+ID4gQlVHOiBLQVNBTjogc2xhYi1vdXQtb2YtYm91bmRzIGluIF9m
aW5kX25leHRfYml0KzB4MTQzLzB4MTYwDQo+ID4gbGliL2ZpbmRfYml0LmM6MTA5DQo+ID4gUmVh
ZCBvZiBzaXplIDggYXQgYWRkciBmZmZmODg4MDE3NTc2NmI4IGJ5IHRhc2sga3dvcmtlci8xOjEv
MjYNCj4gPiAuLi4NCj4gPiBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3Qg
YXQgZmZmZjg4ODAxNzU3NjYwMA0KPiA+ICB3aGljaCBiZWxvbmdzIHRvIHRoZSBjYWNoZSBrbWFs
bG9jLTE5MiBvZiBzaXplIDE5Mg0KPiA+IFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQgMTg0
IGJ5dGVzIGluc2lkZSBvZg0KPiA+ICAxOTItYnl0ZSByZWdpb24gW2ZmZmY4ODgwMTc1NzY2MDAs
IGZmZmY4ODgwMTc1NzY2YzApDQo+ID4gLi4uDQo+ID4gTWVtb3J5IHN0YXRlIGFyb3VuZCB0aGUg
YnVnZ3kgYWRkcmVzczoNCj4gPiAgZmZmZjg4ODAxNzU3NjU4MDogZmIgZmIgZmIgZmIgZmIgZmIg
ZmIgZmIgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gPiAgZmZmZjg4ODAxNzU3NjYwMDogMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPiA+IGZmZmY4
ODgwMTc1NzY2ODA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZj
IGZjDQo+ID4gDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4N
Cj4gPiAgZmZmZjg4ODAxNzU3NjcwMDogZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMNCj4gPiAgZmZmZjg4ODAxNzU3Njc4MDogZmMgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gPiA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiANCj4gPiBB
ZnRlciB0aGlzIHBhdGNoLCByZXBvcnQgd2lsbCBzaG93ICJjYWNoZSBrbWFsbG9jLTE5MiBvZiBz
aXplIDE4NCIuDQo+ID4gDQo+ID4gTGluazogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE2NDU3X187
ISFDVFJOS0E5d01nMEFSYnchbUxOY3VaODNjMzlkMFhrdXQtV01ZM0NjdlpjQVlEdUxDbXY0bXU3
SUFsZHc0X240aTZYdlg4R09SQmZqT2FkV3hPYTZkLU9EUWR4NlpDU3ZCMmcxM1EkDQo+ID4gJCAg
IFsxXQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEt1YW4tWWluZyBMZWUgPEt1YW4tWWluZy5M
ZWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS9rYXNhbi9rYXNhbi5oICAgICAgICAg
IHwgIDUgKysrKysNCj4gPiAgbW0va2FzYW4vcmVwb3J0LmMgICAgICAgICB8ICAzICsrLQ0KPiA+
ICBtbS9rYXNhbi9yZXBvcnRfZ2VuZXJpYy5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9tbS9rYXNhbi9rYXNhbi5oIGIvbW0va2FzYW4va2FzYW4uaA0KPiA+
IGluZGV4IDMyNDEzZjIyYWE4Mi4uN2JiNjI3ZDIxNTgwIDEwMDY0NA0KPiA+IC0tLSBhL21tL2th
c2FuL2thc2FuLmgNCj4gPiArKysgYi9tbS9rYXNhbi9rYXNhbi5oDQo+ID4gQEAgLTM0MCw4ICsz
NDAsMTMgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ID4ga2FzYW5fcHJpbnRfYWRkcmVzc19zdGFj
a19mcmFtZShjb25zdCB2b2lkICphZGRyKSB7IH0NCj4gPiANCj4gPiAgI2lmZGVmIENPTkZJR19L
QVNBTl9HRU5FUklDDQo+ID4gIHZvaWQga2FzYW5fcHJpbnRfYXV4X3N0YWNrcyhzdHJ1Y3Qga21l
bV9jYWNoZSAqY2FjaGUsIGNvbnN0IHZvaWQNCj4gPiAqb2JqZWN0KTsNCj4gPiAraW50IGthc2Fu
X2dldF9hbGxvY19zaXplKHZvaWQgKm9iamVjdF9hZGRyLCBzdHJ1Y3Qga21lbV9jYWNoZQ0KPiA+
ICpjYWNoZSk7DQo+ID4gICNlbHNlDQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9wcmlu
dF9hdXhfc3RhY2tzKHN0cnVjdCBrbWVtX2NhY2hlDQo+ID4gKmNhY2hlLCBjb25zdCB2b2lkICpv
YmplY3QpIHsgfQ0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBrYXNhbl9nZXRfYWxsb2Nfc2l6ZSh2
b2lkICpvYmplY3RfYWRkciwgc3RydWN0DQo+ID4ga21lbV9jYWNoZSAqY2FjaGUpDQo+ID4gK3sN
Cj4gPiArICAgICAgIHJldHVybiBjYWNoZS0+b2JqZWN0X3NpemU7DQo+ID4gK30NCj4gPiAgI2Vu
ZGlmDQo+ID4gDQo+ID4gIGJvb2wga2FzYW5fcmVwb3J0KHVuc2lnbmVkIGxvbmcgYWRkciwgc2l6
ZV90IHNpemUsDQo+ID4gZGlmZiAtLWdpdCBhL21tL2thc2FuL3JlcG9ydC5jIGIvbW0va2FzYW4v
cmVwb3J0LmMNCj4gPiBpbmRleCAxZDAyNzU3ZTkwYTMuLjZkZTQ1NGJiMmNhZCAxMDA2NDQNCj4g
PiAtLS0gYS9tbS9rYXNhbi9yZXBvcnQuYw0KPiA+ICsrKyBiL21tL2thc2FuL3JlcG9ydC5jDQo+
ID4gQEAgLTIzNiwxMiArMjM2LDEzIEBAIHN0YXRpYyB2b2lkIGRlc2NyaWJlX29iamVjdF9hZGRy
KGNvbnN0IHZvaWQNCj4gPiAqYWRkciwgc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLA0KPiA+ICB7
DQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGFjY2Vzc19hZGRyID0gKHVuc2lnbmVkIGxvbmcp
YWRkcjsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgb2JqZWN0X2FkZHIgPSAodW5zaWduZWQg
bG9uZylvYmplY3Q7DQo+ID4gKyAgICAgICBpbnQgcmVhbF9zaXplID0ga2FzYW5fZ2V0X2FsbG9j
X3NpemUoKHZvaWQgKilvYmplY3RfYWRkciwNCj4gPiBjYWNoZSk7DQo+ID4gICAgICAgICBjb25z
dCBjaGFyICpyZWxfdHlwZTsNCj4gPiAgICAgICAgIGludCByZWxfYnl0ZXM7DQo+ID4gDQo+ID4g
ICAgICAgICBwcl9lcnIoIlRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBh
dCAlcHhcbiINCj4gPiAgICAgICAgICAgICAgICAiIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hl
ICVzIG9mIHNpemUgJWRcbiIsDQo+ID4gLSAgICAgICAgICAgICAgIG9iamVjdCwgY2FjaGUtPm5h
bWUsIGNhY2hlLT5vYmplY3Rfc2l6ZSk7DQo+ID4gKyAgICAgICAgICAgICAgIG9iamVjdCwgY2Fj
aGUtPm5hbWUsIHJlYWxfc2l6ZSk7DQo+ID4gDQo+ID4gICAgICAgICBpZiAoYWNjZXNzX2FkZHIg
PCBvYmplY3RfYWRkcikgew0KPiA+ICAgICAgICAgICAgICAgICByZWxfdHlwZSA9ICJ0byB0aGUg
bGVmdCI7DQo+ID4gZGlmZiAtLWdpdCBhL21tL2thc2FuL3JlcG9ydF9nZW5lcmljLmMgYi9tbS9r
YXNhbi9yZXBvcnRfZ2VuZXJpYy5jDQo+ID4gaW5kZXggMDQzYzk0YjA0NjA1Li4wMWIzOGU0NTkz
NTIgMTAwNjQ0DQo+ID4gLS0tIGEvbW0va2FzYW4vcmVwb3J0X2dlbmVyaWMuYw0KPiA+ICsrKyBi
L21tL2thc2FuL3JlcG9ydF9nZW5lcmljLmMNCj4gPiBAQCAtNDMsNiArNDMsMjQgQEAgdm9pZCAq
a2FzYW5fZmluZF9maXJzdF9iYWRfYWRkcih2b2lkICphZGRyLA0KPiA+IHNpemVfdCBzaXplKQ0K
PiA+ICAgICAgICAgcmV0dXJuIHA7DQo+ID4gIH0NCj4gPiANCj4gPiAraW50IGthc2FuX2dldF9h
bGxvY19zaXplKHZvaWQgKmFkZHIsIHN0cnVjdCBrbWVtX2NhY2hlICpjYWNoZSkNCj4gPiArew0K
PiA+ICsgICAgICAgaW50IHNpemUgPSAwOw0KPiA+ICsgICAgICAgdTggKnNoYWRvdyA9ICh1OCAq
KWthc2FuX21lbV90b19zaGFkb3coYWRkcik7DQo+ID4gKw0KPiA+ICsgICAgICAgd2hpbGUgKHNp
emUgPCBjYWNoZS0+b2JqZWN0X3NpemUpIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCpzaGFk
b3cgPT0gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzaXplICs9IEtBU0FOX0dSQU5V
TEVfU0laRTsNCj4gPiArICAgICAgICAgICAgICAgZWxzZSBpZiAoKnNoYWRvdyA+PSAxICYmICpz
aGFkb3cgPD0NCj4gPiBLQVNBTl9HUkFOVUxFX1NJWkUgLSAxKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHNpemUgKz0gKnNoYWRvdzsNCj4gPiArICAgICAgICAgICAgICAgZWxzZQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBzaXplOw0KPiA+ICsgICAgICAgICAgICAg
ICBzaGFkb3crKzsNCj4gDQo+IFRoaXMgb25seSB3b3JrcyBmb3Igb3V0LW9mLWJvdW5kcyByZXBv
cnRzLCBidXQgSSBkb24ndCBzZWUgYW55IGNoZWNrcw0KPiBmb3IgcmVwb3J0IHR5cGUuIFdvbid0
IHRoaXMgYnJlYWsgcmVwb3J0aW5nIGZvciBhbGwgb3RoZXIgcmVwb3J0DQo+IHR5cGVzPw0KPiAN
Cg0KSSB0aGluayBpdCB3b24ndCBicmVhayByZXBvcnRpbmcgZm9yIG90aGVyIHJlcG9ydCB0eXBl
cy4NClRoaXMgZnVuY3Rpb24gaXMgb25seSBjYWxsZWQgYnkgc2xhYiBPT0IgYW5kIFVBRi4NCg0K
PiBJIHdvdWxkIGFsc28gcHJpbnQgdGhlIGNhY2hlIG5hbWUgYW55d2F5LiBTb21ldGltZXMgcmVw
b3J0cyBhcmUNCj4gcGVycGxleGluZyBhbmQvb3IgdGhpcyBsb2dpYyBtYXkgcmV0dXJuIGEgd3Jv
bmcgcmVzdWx0IGZvciBzb21lDQo+IHJlYXNvbi4gVGhlIHRvdGFsIG9iamVjdCBzaXplIG1heSBi
ZSB1c2VmdWwgdG8gdW5kZXJzdGFuZCBoYXJkZXINCj4gY2FzZXMuDQo+IA0KDQpPay4gSSB3aWxs
IGtlZXAgdGhlIGNhY2hlIG5hbWUgYW5kIHRoZSB0b3RhbCBvYmplY3Rfc2l6ZS4NCg0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBjYWNoZS0+b2JqZWN0X3NpemU7DQo+
ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBjaGFyICpnZXRfc2hhZG93X2J1Z190eXBl
KHN0cnVjdCBrYXNhbl9yZXBvcnRfaW5mbw0KPiA+ICppbmZvKQ0KPiA+ICB7DQo+ID4gICAgICAg
ICBjb25zdCBjaGFyICpidWdfdHlwZSA9ICJ1bmtub3duLWNyYXNoIjsNCg==
