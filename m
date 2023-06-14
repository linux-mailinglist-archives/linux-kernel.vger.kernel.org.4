Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD772F83F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbjFNItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbjFNIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:48:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2C1BC9;
        Wed, 14 Jun 2023 01:48:34 -0700 (PDT)
X-UUID: 9042533e0a8811ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=2cQl4e72FJ5oH+bPzUD0NJi6h7vYecoIWWHrsLXKoks=;
        b=Wm89kBow04xYCL0JvE8wcpgQ7OgkpNOMZ7SDloY22U/9aGQLZ9Z883YYQhZ5qiNYu6oLZILq65sBl0OFpWejqtGhZ9XCK9jdy1EHvv7jLTVnTr35pZ16lVclSJZGV9ErYUzld1K7CaSNmxeFJledi6CuNfjEO6edJoXdnJ9ILLg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:2abd8ed4-427d-40f2-84c8-dcf2f619f70a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:92ba076f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9042533e0a8811ee9cb5633481061a41-20230614
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1770364599; Wed, 14 Jun 2023 15:53:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:53:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:53:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZttGCrugBtvcMNCPa+xmDewNxc+3ZxYiGK8za8V6GS/YAdSq5PuLerIa2PLFa/ZgsmW9WzI+ajm3ET7xw3JHhNXxbIDrU7V+mBAKOcql0mFOMMvEYtkXhQpbZA/ce7Azuian1XIbwzKedr9LiGKom/y3Q8JbcpcXbS55JQ6zY/V3r1qQPFvIzM1aduwSBpjJEMmP+BfUAcfN29/wPypDFJwP8JeTgUGeqwt6/ESYn5QTFhghSlpVNXfO+wd4g043bWgilPKKNazorkvLs0PHk1cnQjvJ1/G1i9OkKm65n/8Q1O0CkgP11sR894z7JKbANaQrML6qu08a7tZvFdCJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cQl4e72FJ5oH+bPzUD0NJi6h7vYecoIWWHrsLXKoks=;
 b=izdnn0VQfN7LkdcokIf5K4VdMUd0clGS7qqGOB9319R3o8Fjdtf6aWYfUtHaVLg05u3iQzo/Dro2VBSOg2hfPSOh/LIxOy+Isk8e3s5ZX283igiWZQiK/5Jh0/V3i0ZaDgwMRZDafMpS782hhRc21sIVx8T3jOKjqgjwKFAYCTMI59qNUlZgJbkz+OKaTky1z64o9AKI8M7LWPGIdMmtndbHm2sV0/qtMPwwayJuRjO2GcREFyayd6brHhZoHVOZVhL7Vx/a8u51OHQ6yKB4qRjlxNqhrdeCGt9JIGIQ0zLPFECSFpDx14PP9zlvphe+4xomlmQcr0lROmXZvVWs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cQl4e72FJ5oH+bPzUD0NJi6h7vYecoIWWHrsLXKoks=;
 b=SSoj31r+No7W8JOHIW9opcsuc2SLG4gKADNZI8+0mrbXdxnvLdFmRb4JpV3FWMm53CpXCSqEgSgz24tohBNQQyqZ4S+6psYUCpJ0y/gPG+yML6rtFKs1XWu3GpcmfHELvI1VPX7sdAko1vVo3xk9rQuTVdqhIGmRLV6GwdxkJFs=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB5390.apcprd03.prod.outlook.com (2603:1096:400:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 07:52:10 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%3]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 07:52:09 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 1/7] ASoC: mediatek: mt79xx: add common header
Thread-Topic: [PATCH 1/7] ASoC: mediatek: mt79xx: add common header
Thread-Index: AQHZnRwjudjTPsHoSk2l2wv7D1tHHq+J7fcAgAACDoA=
Date:   Wed, 14 Jun 2023 07:52:09 +0000
Message-ID: <78663818b4cae0e6c94058eafd6937a25c728660.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-2-maso.huang@mediatek.com>
         <2ad87d4a-3068-61c1-2192-bcd80dfa46d0@collabora.com>
In-Reply-To: <2ad87d4a-3068-61c1-2192-bcd80dfa46d0@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB5390:EE_
x-ms-office365-filtering-correlation-id: 1dbd6332-2005-48bd-e43d-08db6cac41c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PIpq6Q324af6PqxHzC3R8E3vMq31iIs3mpiuNeDNDhrYYFC+GTpYsgzLA3gVkz1r+qsnsk+w/gpoCn8e5IwThMTvdWe0MJzDgy4iMy7rbUL+aKQgkZhY5IgWtPx0SQIH5l5FRw6P5xyA3+iziWY1m+51iLO1l5oRPMBXZNkGxkOFiCGV39FrarWVd4Ber75uzcnSWw8wj3jhCgIfRkQcNSArvGUSy3urXu+6Y0F2BKBT//AveimQoQbB+bwnX1qVRnjY49tXGiqLdoTlDSAdYcWTwJ+tkDIY8GrPK6o/Deh9CnXL9rhgzUzMKNqlrcvGBCdCkBlFvYBKUSLB+5imyIaiNvw2+P8drObwctzfndFRySq1H2k2lciVsCN+D3Gysc0o0ySIVwP2nSx64y8FITYZCxm3whiJQOVPHtL4EAuxbwPqjqjl/tzXzO1uGmMDOSxQJLKvtk2miCrAQd740DQAk9hThS/iidnCPFbhL341yWj6fmUQ7oTSbzZsJsWjyqlOKESuKoMyeGUK19HhvUOcDNYNrW6lNACnW/jmaMJbIR6psyJM4pAK/qgdtQOGGQsSQbkUzoXvdFM5EkdwTuTgMh1gG7qRoLxgd4dwvpW595CNX1nmP9qYad213XA7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(86362001)(7416002)(6486002)(316002)(8676002)(41300700001)(38070700005)(83380400001)(26005)(5660300002)(6512007)(38100700002)(85182001)(921005)(6506007)(8936002)(122000001)(71200400001)(66556008)(66446008)(64756008)(36756003)(66946007)(91956017)(76116006)(478600001)(186003)(6636002)(2906002)(66476007)(110136005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJtdVdWR0daSEtOTTk1ZnVacEVMbWZmd0ZIMXVhbWNRcHYrOC82WUhlUmdi?=
 =?utf-8?B?SFFZNjdtTVVxTy9pZ05TeStCRUJPUG5iVkNpdVVpajJIWlFzQ1VHUENKZFBj?=
 =?utf-8?B?blBHMTI4K0w4VUx6UkJnRXlCVTk0cXlmUG9iZjM1d1RZWEk2enowOTA2cXZB?=
 =?utf-8?B?NlltK0txczdEcWRDczFWSEpyZGo5M21NQWZiSjAyeDlPaGdLNmQvWmhHVHZN?=
 =?utf-8?B?emU5Vnc3UHNaRFRWNHRmUmNPcC9mQU0wSHBsdjNmUCtCSDBaMVptVThtdnNX?=
 =?utf-8?B?Yk5QTFN3bjgzQTdleklLcG82WHVEVTVEQXBITkc0SWVOdjc3WGNwWWFZV29v?=
 =?utf-8?B?dFdYcEhzdDNaa3ZDZHZmSUtkMlRtM0p0azluSzBHK3hQSWM2dHRkTU03QUZv?=
 =?utf-8?B?S2d0Tkk4b1AwNXkwZk1GaWhKcnIzZVJ1THpTU3JDVEFqVG9VL1BYMkxRTVo2?=
 =?utf-8?B?VWplY05pMUh0ZE5iTXhBQ1hvWlArZkVyanJjeEJ3c0FrYUthSWJOWGpHcDEr?=
 =?utf-8?B?RWxnRHFoNVNWWjdsZXFHclRCbmNKZThWSGNMTjJJaStjQkJJbkhaVkowYjhF?=
 =?utf-8?B?aTYzR2J2R3dtTXpiM2xjd3BSU0Z6dEI1WlJIUjNoRTNka2xiR0Q0T05Bck5v?=
 =?utf-8?B?VGFjVTJNK1VkeTY5b1V4cm1Rc1V3OGo2WmRLM0VjY3RCMWNOMWtXOFBzRXRz?=
 =?utf-8?B?MklENVJrSUdRSjJRUk9hT05SdWxNTmlzWTdTMHAyOE1Sa2N4Ull4bDM5anhG?=
 =?utf-8?B?Nzk2Rzc2cFdWR0FjS3pwNUVVY3B5dkEyYTE0dzJLTVMwK3JMYklxZ0x5K3Ez?=
 =?utf-8?B?aWFpeXcyb09GRWFPREpJei9JUDVhdGJzQ2lmRm81M3dxV1Q0QVJ0N0pYNFZT?=
 =?utf-8?B?SFR0a1VIa0RobDMrRWd5aGV6Ny9zNzJWQkVLaGJtcWlLR1lrY0RqdHhiSm5P?=
 =?utf-8?B?MlFMSm1ueDNuVTdOZm5FTEtvNkVtNG1kb2tlSGlHWXlzbXNDKzlkNnJNZDFn?=
 =?utf-8?B?ZUJNNWNnUkdqTDZ4U0hXSkprSXlCQ3o1cFBEazdIdURJV2xJTjhxcTBKbXVG?=
 =?utf-8?B?K3ZhbEdVaXZqM1kySkQ5eEoydEwxNW8wb0orSUZ1cHh3MHRnQXlwOURUVWYr?=
 =?utf-8?B?T3ZjV0VKOEk3R2ZNVzRqTDFEd2E1MDYzdGFZMHJXbURlaUg4SklXYVN0UHM1?=
 =?utf-8?B?TTZmOFh4dERGRks2U0VtNTBpYWhxeFJvdkhOVXFxTHJRY3AvY3FUZkE3Y2Qr?=
 =?utf-8?B?K3NIb2tUTmVkNEpKM3MyM1hBekVwR2VIbW9QQndkUXFzYkZvSEpCdzNoT1Nu?=
 =?utf-8?B?dm1qRUJDVlNndVZPZFJVQ25mQXhqOEJaL0kzaDNZaTcyMVhnMk5Jb05VZVR0?=
 =?utf-8?B?bk42aEJ4aEVTMjhzcVdYVGNpcUxJaWcvN1I1VHpUUTVsYlpjVXduNkI2TWtD?=
 =?utf-8?B?U0kraFQ5RDVDUjgvUjZGQ3BVRzlzREZxRnY0MDV3UTgwVEdNbTl3MDVseFJI?=
 =?utf-8?B?MTJQUFRQZS9IOEhnQXg0UXZLYmVnZGUvY2hYTzdzREw2S21ZWk01c0NQTGtk?=
 =?utf-8?B?bUZlWDVHekRNU2lWaDNSdkxwaXB0YktrbDduS3pTQlVrZHFiVE1tTVVnTWUx?=
 =?utf-8?B?WXpqdFZOVjM1SW9tSXZ4aXRIME10dWdIVk9JRjFFZXN4YlZHY21qbVlxUUow?=
 =?utf-8?B?VTlwV2U1ZC9QVG9XSUxIc1JyRHNka0lDajdzQVJrb1hqNXN4enRFblNGUUFq?=
 =?utf-8?B?b0dFUk04REVic2s5bUl3YmdSVktBVVpMQ2VuSC9ERGtTOGhzYXVhYlVEWm1s?=
 =?utf-8?B?QmRaUnUydzYrTGltOE9nQkRNMCtmem5xTVFib2JyZWsybGUzRE9hVGJaMWZz?=
 =?utf-8?B?VmR4bUNmRjE1UXJ4NkIxWmhwLytibFE4WS9NYldDWitCRmtBL2dWdlB5TVRn?=
 =?utf-8?B?VWpKNWU1NktidVVkTm54ZnA0ZE1heThYRmFORjg2MEtkQkFKdmlMWFU5bEZu?=
 =?utf-8?B?QkVpdUJEcFpJM290bmZXUzYycHYxczdEWmJVODJremxNdnBQT0VLTHRCUXdJ?=
 =?utf-8?B?U3pFZS81ZkVseGtQSlFNd0c4Zk10L28yUjRJSUcyR2lMN0JTRGJrN0c1V2dh?=
 =?utf-8?B?YzlHV09CRkdEUDM1a3R3eXdiMWpOVUU0dmMzcWpjaUx2WDNDV0NZRFZhUENp?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49F65A1DDC531149AFD1C0F65AA7FA8D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbd6332-2005-48bd-e43d-08db6cac41c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 07:52:09.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkrtBUJ6tFvte+PxYiyJcvjBxeGBEHRQninzsKCWkn2xXLqulZ5xLZ2dg+0BpPblHWPOdhWu0cez2Rm51p33Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDA5OjQ0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAxMi8wNi8yMyAxMjo1MiwgTWFzbyBIdW5h
ZyBoYSBzY3JpdHRvOg0KPiA+IEZyb206IE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+IA0KPiA+IEFkZCBoZWFkZXIgZmlsZXMgZm9yIHJlZ2lzdGVyIGRlZmluaXRpb24g
YW5kIHN0cnVjdHVyZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXNvIEh1YW5nIDxtYXNv
Lmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9t
dDc5eHgvbXQ3OXh4LWFmZS1jb21tb24uaCB8ICA0OSArKysrKw0KPiA+ICAgc291bmQvc29jL21l
ZGlhdGVrL210Nzl4eC9tdDc5eHgtcmVnLmggICAgICAgIHwgMjA2DQo+ICsrKysrKysrKysrKysr
KysrKw0KPiANCj4gUGxlYXNlLCBzL210Nzl4eC9tdDc5ODEvZy4gV2lsZGNhcmRzIGFyZSBub3Qg
cGVybWl0dGVkLg0KPiANCg0KSGkgQW5nZWxvLA0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NClRo
ZSBvbGRlc3QgaXMgbXQ3OTg2LCBzbyBJJ2xsIHVzZSBtdDc5ODYgaW5zdGVhZCBvZiBtdDc5eHgg
aW4gdjIgcGF0Y2guDQoNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjU1IGluc2VydGlvbnMoKykN
Cj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4L210Nzl4
eC1hZmUtY29tbW9uLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0
ZWsvbXQ3OXh4L210Nzl4eC1yZWcuaA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ3OXh4L210Nzl4eC1hZmUtY29tbW9uLmgNCj4gYi9zb3VuZC9zb2MvbWVkaWF0
ZWsvbXQ3OXh4L210Nzl4eC1hZmUtY29tbW9uLmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMTNjOWU1MWQ3YjM4DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5eHgvbXQ3OXh4LWFmZS1jb21tb24uaA0K
PiA+IEBAIC0wLDAgKzEsNDkgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAgKi8NCj4gPiArLyoNCj4gPiArICogbXQ3OXh4LWFmZS1jb21tb24uaCAgLS0gIE1lZGlh
VGVrIDc5eHggYXVkaW8gZHJpdmVyIGRlZmluaXRpb25zDQo+ID4gKyAqDQo+ID4gKyAqIENvcHly
aWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ID4gKyAqIEF1dGhvcjogVmljIFd1IDx2aWMu
d3VAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKiAgICAgICAgIE1hc28gSHVhbmcgPG1hc28uaHVhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpZm5kZWYgX01UXzc5WFhfQUZF
X0NPTU1PTl9IXw0KPiA+ICsjZGVmaW5lIF9NVF83OVhYX0FGRV9DT01NT05fSF8NCj4gPiArDQo+
ID4gKyNpbmNsdWRlIDxzb3VuZC9zb2MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ICsjaW5jbHVkZSAiLi4vY29tbW9u
L210ay1iYXNlLWFmZS5oIg0KPiA+ICsNCj4gPiArZW51bSB7DQo+ID4gK01UNzlYWF9NRU1JRl9E
TDEsDQo+ID4gK01UNzlYWF9NRU1JRl9WVUwxMiwNCj4gPiArTVQ3OVhYX01FTUlGX05VTSwNCj4g
PiArTVQ3OVhYX0RBSV9FVERNID0gTVQ3OVhYX01FTUlGX05VTSwNCj4gPiArTVQ3OVhYX0RBSV9O
VU0sDQo+ID4gK307DQo+IA0KPiBTYW1lIGZvciB0aGUgZW51bWVyYXRpb24gZW50cmllcywgYW5k
IHRoZSBkZWZpbml0aW9ucyBhbmQgdGhlDQo+IGZ1bmN0aW9uIG5hbWVzLg0KPiBQbGVhc2UgY2hh
bmdlIGV2ZXJ5dGhpbmcgdG8gYG10Nzk4MWAgKHN0cmF0ZWd5IGlzIHRvIHVzZSB0aGUgbmFtZSBv
Zg0KPiB0aGUgb2xkZXN0DQo+IFNvQzogaWYgdGhlIG9sZGVzdCBpcyBub3QgNzk4MSwgY2hhbmdl
IGFjY29yZGluZ2x5KS4NCj4gDQoNClRoZSBvbGRlc3QgaXMgbXQ3OTg2LCBzbyBJJ2xsIHVzZSBt
dDc5ODYgaW5zdGVhZCBvZiBtdDc5eHggaW4gdjIgcGF0Y2guDQoNCj4gPiArDQo+ID4gK2VudW0g
ew0KPiA+ICtNVDc5WFhfSVJRXzAsDQo+ID4gK01UNzlYWF9JUlFfMSwNCj4gPiArTVQ3OVhYX0lS
UV8yLA0KPiA+ICtNVDc5WFhfSVJRX05VTSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBj
bGs7DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbXQ3OXh4X2FmZV9wcml2YXRlIHsNCj4gPiArc3RydWN0
IGNsayAqKmNsazsNCj4gPiArDQo+ID4gK2ludCBwbV9ydW50aW1lX2J5cGFzc19yZWdfY3RsOw0K
PiA+ICsNCj4gPiArLyogZGFpICovDQo+ID4gK3ZvaWQgKmRhaV9wcml2W01UNzlYWF9EQUlfTlVN
XTsNCj4gPiArfTsNCj4gPiArDQo+ID4gK3Vuc2lnbmVkIGludCBtdDc5eHhfYWZlX3JhdGVfdHJh
bnNmb3JtKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCByYXRl
KTsNCj4gPiArDQo+ID4gKy8qIGRhaSByZWdpc3RlciAqLw0KPiA+ICtpbnQgbXQ3OXh4X2RhaV9l
dGRtX3JlZ2lzdGVyKHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSk7DQo+ID4gKyNlbmRpZg0KPiA+
IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4L210Nzl4eC1yZWcuaA0KPiBi
L3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5eHgvbXQ3OXh4LXJlZy5oDQo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjI4YzBhZWJhOWJkZg0KPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4L210Nzl4eC1yZWcu
aA0KPiA+IEBAIC0wLDAgKzEsMjA2IEBADQo+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wICovDQo+ID4gKy8qDQo+ID4gKyAqIG10Nzl4eC1yZWcuaCAgLS0gIE1lZGlhVGVr
IDc5eHggYXVkaW8gZHJpdmVyIHJlZyBkZWZpbml0aW9uDQo+ID4gKyAqDQo+ID4gKyAqIENvcHly
aWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ID4gKyAqIEF1dGhvcjogVmljIFd1IDx2aWMu
d3VAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKiAgICAgICAgIE1hc28gSHVhbmcgPG1hc28uaHVhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpZm5kZWYgX01UNzlYWF9SRUdf
SF8NCj4gPiArI2RlZmluZSBfTVQ3OVhYX1JFR19IXw0KPiANCj4gX01UNzk4MV9SRUdfSF8NCj4g
DQo+IEV2ZXJ5dGhpbmcgZWxzZSBsb29rcyBvay4NCj4gDQoNClRoZSBvbGRlc3QgaXMgbXQ3OTg2
LCBzbyBJJ2xsIHVzZSBtdDc5ODYgaW5zdGVhZCBvZiBtdDc5eHggaW4gdjIgcGF0Y2guDQoNCj4g
VGhhbmtzLA0KPiBBbmdlbG8NCj4gDQoNCkJlc3QgcmVnYXJkcywNCk1hc28NCg==
