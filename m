Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D658D6DD3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDKHWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDKHWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:22:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D63E4;
        Tue, 11 Apr 2023 00:22:41 -0700 (PDT)
X-UUID: a20a5e12d83911eda9a90f0bb45854f4-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FNm0toZRqKebfuDZnoPN3XEdhirFfZDW4AZxy2KNFvU=;
        b=hwU5TjXjT4rTg4Qu79FgqnrZa7NQo2N8bD2YX6/7swH/1kgdF2Cvvuq/naB4HC9iDo2oS+5dOaApE80ABNNWDRxc56qoAbvbnlfqJfq/2H8bZz8CuMriw2RGjsu0vACXHYcB6p4OkZahmaVTMjLhxAlpNzzS/13BHXKlN1OcaKA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:635729ad-993b-4862-823e-e3f956f05f58,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:7c0d90ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a20a5e12d83911eda9a90f0bb45854f4-20230411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1039116335; Tue, 11 Apr 2023 15:22:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 15:22:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 15:22:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXfOmEgN4xMLZfXCb9Jfqtc5n0C+XFqscNSlAitoTwTAlN7bZnjjkVni6zKa86bwhibGZywGCjm7cz5rCoaRw5veEDIiftrkprOlxlIwFbblWalyRrNPNCvC40lBbocmZoqNaN8IDLTuuOQ4UlhEaJKc78zPCkrH9ZesNcIBE6TOy1+4JBG+Du3ARfJQqsM0JWZRdUGKoMRFc//qaLO1Hs7BM6YilS0dgKXqnWsk27/6sQiUsQvLAc4oHKMDg/3CsORDal+aPJqHJXR7H0FmCBX6MzqSOf+fEj1WWr5IfzWX2vWA0rYUoz6LxT553zuBEVMMftby2mdbyp9j3l59yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNm0toZRqKebfuDZnoPN3XEdhirFfZDW4AZxy2KNFvU=;
 b=fwxJNm77Ntl0xupwuLrJOXfChPd1eLBEvfauwolI9ic4smPTBJwUOItxPkfAa0HtqmfgXkqTrJQvbOOtVYU3U5115quYh1zOGl1LJLjTHGSWsck78tx82xMc1GQb7fRUBsjPs59WSZ8YCTY+sCYfQHieR+vaI6UDdibeHisPjjmAzo08NVAC/Em5Ian8xJg9oBfaExz2nx1lxsrnUr3VTZG0OfhupQpgnPfkLHjTCcw8LrS3DtONeZC7vdwxd3yjLriU12BYDx4R1YjJfL3Ou1UsD0G+CjlttgtQqmBJle5UXoxfu91vycc/fvRnXAlDmCOkMQYgiIo1MjG42D9JlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNm0toZRqKebfuDZnoPN3XEdhirFfZDW4AZxy2KNFvU=;
 b=MsmJzMILBfycPcYvlB58sIaI6wMNpZJIBRWwY5cWG2IRagmXpzUvQ/azhleNeM/SQO8uk/HoF8zp8xM2SFlduMGYkcdHkedJs1+lXoNYl56G4zL22dLzdaUjZvFWHSbAC8kRbBhtwrHhnsfw7tL4CSUoF4ICTni+Drm0vfCfxyM=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SI2PR03MB5673.apcprd03.prod.outlook.com (2603:1096:4:150::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:22:32 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 07:22:31 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2, 2/2] media: mediatek: vcodec: make sure pointer isn't
 NULL before used
Thread-Topic: [PATCH v2, 2/2] media: mediatek: vcodec: make sure pointer isn't
 NULL before used
Thread-Index: AQHZbDooLqMORqeoNUWcdaTH79b1C68ltEsA
Date:   Tue, 11 Apr 2023 07:22:31 +0000
Message-ID: <55bc07edcca27b5be96642aede3d71fe076af668.camel@mediatek.com>
References: <20230411055413.539-1-irui.wang@mediatek.com>
         <20230411055413.539-3-irui.wang@mediatek.com>
In-Reply-To: <20230411055413.539-3-irui.wang@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SI2PR03MB5673:EE_
x-ms-office365-filtering-correlation-id: eef8d831-605f-4f8b-7985-08db3a5d8398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeh7O+vQGJopHffrKJij/v9NvE7z5yP2JDXuD78/r/S+tvaBeNSDB0NjLOKwT9uYCXsNVTRbXkbaYNtmyUqQxFAU5X1W2JUJ01+FGWTvxj21KZ5k7tXe4wKU9fzIi9n62QR9cXboutfMHtW6GOmj2Q1lcUK21TsIpdBQKb9HiEekpFSMnSODVMo/epLLj6jFJ2cZ5Fpf424CY3hf4AN86+HZoUa6fXVl5p6oHUUCL/s5aimaieEqt7Me29Od0wz68dgI1rbeRi5j9U+w25NvJxERHP4s+jb6Wryxy+V1ONu72oX3u8PCgmsCkP7pJkMT4QM235s2agat79L0egVmgsnUWoXjnaDCThzpmQweDP7CZPA8aX/tKiR+KbPHneVA3N6A/TWEjEzHgmYuWWSC/q6Q2YTV1TOVjObhlJ464T2yO0DEHUzLn59s/3KbDR9plAmVY/4wJ7Vl252rPHEVonKeNChZ/XNGk9GJctk52bWcrTgNUHvMJ2sVh/JLfDdw7EsWxjvKZR34T8hO3oOjKw+NtTJP0sIigATQTR4mngNd+ymqgvxLDABw6Go3vE68X+3n/ovP/T8ApxbHVcE1jPoWx1Ateugld2PiXkV873bb/xK0vRueGflkwni+f/aRRRXc2hNssxmaCkArpSvBfqxKFRXilHu6QjKx87j6YQdH82R3wWyKHOk1sEZoHgmg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(85182001)(36756003)(86362001)(41300700001)(316002)(76116006)(110136005)(91956017)(478600001)(6486002)(4326008)(66446008)(54906003)(66946007)(64756008)(8676002)(66476007)(66556008)(71200400001)(5660300002)(2906002)(8936002)(186003)(38100700002)(38070700005)(122000001)(107886003)(6512007)(6506007)(26005)(2616005)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0hWaW9DZGwyOTBuU0tLZ1UrYkdxVXY0RWFRK3BKMFhNYVJRQUcwU3VlR05h?=
 =?utf-8?B?dUp6V0QrR09hMXYwQlE2ZFcwbXZ0UGpDaTFwcGxrTjdOVlZ3b3ZvOU5OelM0?=
 =?utf-8?B?SUFWQ0JDb0RBV2gvOVh5WXVTT2ZVR1F4TlJNNC9IOWZNRnR2QStKdXl3YVJV?=
 =?utf-8?B?K2NQWDIvSnZHS1h1R3h3T3IvazVna3NJdnh1ZHoxZEltMGlxdTRFSitSL3pi?=
 =?utf-8?B?V3NRc2l0bGh5YWs4MmFQT3RreFg4RzdyQ1FRYTNsa1hJUTNDV01wY3FDSlNP?=
 =?utf-8?B?UlVySWFSZ1lmNzNhaEd0ZUFxZGt6VnZwSWtRWFlKUFBhTk0xVFV3RHhGK1Zp?=
 =?utf-8?B?aVJ0WmFzeHBHUVJRUDlmWGtXVC8zMUNzaHkzZ21hVkE5QXBkLzFDWC9rVTl4?=
 =?utf-8?B?eEEvSTVWY2hqQk1ZSmFxYWU5V2lPMWN6aVdYbFI2ZFA0cWdGSGpiY2p2ZEts?=
 =?utf-8?B?TmJVVUlQVnE1TG00SHI1byszK2JWYXJoeGF2VDgrbVhKZUE2MmJDdGtsbWJl?=
 =?utf-8?B?TW1oelFjV3RPczFmUWFYaDlqM3NBSkhEYXR1MWZvTzRQc3JkMDhzUXJwNXp5?=
 =?utf-8?B?NVZnYzhaVmRobnpQMWZ5cUZkZnkxK2NPbGZXSXBob2Rsc3RTNnd0NVN2YnY2?=
 =?utf-8?B?bWhpQit4WXhBYVpHU1duNTRrODhUZVUyQmpmWkViZjdYMng0dEhOWHlaUVRU?=
 =?utf-8?B?c3RMNUtCdnVNTlV1Y3dmMmpxRElFK3FqTWw2VWx2R0tBQzZVd0ZPQjIvWElO?=
 =?utf-8?B?RWZJSUg0d0NDZVdLVFBmN0svc0ZxMFhpSjJTZ3l1NEQvRUFvVWN0Z2JsZklN?=
 =?utf-8?B?c2d0c2EzL2xwVWhjbWZHTFMxdlZYeHVrbTFoNFF1V2I1cGlFSmlTd3NSemJr?=
 =?utf-8?B?V3hsQnJoZDFSS1RoNkdNbExDekdvYWZKSFIwMitxVU1nT1R4TWFCQ3BFNStJ?=
 =?utf-8?B?MU1rSXYrZFBCd1ZObWNYelJxNGNkWUdSaW9EUE9wcjdmNXNFV1VuMWNEQkMy?=
 =?utf-8?B?SFFzMGJoMTk5ZWUzdmFPK0M0bGxiWE0vellsWVY3MUJvUzZ3TmErai9KSUhK?=
 =?utf-8?B?VE9XdzAyejZUUSsrb1h1bzN5K21CckdkMnNMNEgyNk01MHM0b2E0ZVRCWk56?=
 =?utf-8?B?amlkZFN2OXk2cWkvZThDSVBERUc0QS9ibGtEU050RElrbXRHaGZSQXV6M3BJ?=
 =?utf-8?B?MWRrQmZveGE2T3lQVVVVOWhNY3V4cXN3ZGFQd1NSTm9hWE5HUFlLV3FHN3Q4?=
 =?utf-8?B?b1hqakRFanZEYnpEeEtnSk9hSm9kKzZaaE5LdEtWYkRWamJZQ3AzVHZHZE1u?=
 =?utf-8?B?VHBCUUxoUEZtNDNlY2cxRXRVd1Rqb0Z6WUMrQkhzRGU3VEhEQWpscE96cXkv?=
 =?utf-8?B?ME1SS21GSFI4VWcrVVBsbElyb1g2V283bGZlQkxjVlRmUDY0dXVmd0pXbnQx?=
 =?utf-8?B?K1Jrb1htdUVWUG91Yy9GWG14L0hDajJCOUhRbWtYM0Y3cmhnUDZyQm1FVU85?=
 =?utf-8?B?dDd1N0FjRVlnSHNGeHhkbzZESVF6QnFXTnhWUzJHUXVkc3Z3L052a0h4R0RW?=
 =?utf-8?B?Wjc0WHpCcDRJR2dTSklFVldSTzFlR1h0alRoZTVxdHArL2tzaUFXUEdVRjRs?=
 =?utf-8?B?ZUwyMisvdjhMbDJ2NzNJRUFRYUhCamRDd1dpMzduWmI4aFIrNzd0K05Yb3Jj?=
 =?utf-8?B?TTFpWTBlM2w5dGMzcldNUWJ2N1hrSnVvcnVFN3IyN1FjUFVkZXM0czhrdUtO?=
 =?utf-8?B?R2hXVGxIVkpRMGYrelBqRVA4QWVRenZ0NGtIcjZKYm9jb2x5YTB1RVVZWnpI?=
 =?utf-8?B?TC9PTU9wTlhrYVF5YjZ0SWJraElta1RiMVBPU1ZPdk5ML3pHZWRMd2tsSjdG?=
 =?utf-8?B?dTZHWnA4QVdZUjVkdW8wY2VhR2draE1YcjBKMUxpc015WmZEaVF0aFZaSHpj?=
 =?utf-8?B?RlgzSmRCeE14QllMYWw2azlpNnU2U1RtRWg0UlUyZ3VVV0J4TzVyaVc4a016?=
 =?utf-8?B?WWhpV3FIclJEeUtRWjFzQWUyNjlFQ1JVSmJXNHFuVm1maE1EdE10ZjNaRmNp?=
 =?utf-8?B?Rzg1RnJ4SXJkZ3V6VW1VWlMzaWtzVStvWFVTVCt4dkdzNzloYWhoOVhrcjBo?=
 =?utf-8?B?cDFwQjd3eVlrVk9VWVlTSnhDM1pxWnk4TmpKbFRmdTlrZitGQjRyQm14dlB1?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC56158BC1B47440B673113A447DF690@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef8d831-605f-4f8b-7985-08db3a5d8398
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:22:31.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NcJQ7f+xKKe3LS/XHIy9qtic7rALY5ovMgIFMNwLVM4mQRjzmISTJXm34o6hdnVv2hJTInmQRp4Yy2OYiDPjtafk7eCFx85JAWU58znMwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5673
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSXJ1aSwNCg0KT24gVHVlLCAyMDIzLTA0LTExIGF0IDEzOjU0ICswODAwLCBJcnVpIFdhbmcg
d3JvdGU6DQo+IENFUlQtQyBFeHByZXNzaW9uIGNoZWNrOg0KPiBEZXJlZmVyZW5jaW5nIGJ1Ziwg
d2hpY2ggaXMga25vd24gdG8gYmUgTlVMTCwgY2hlY2sgYnVmIGlzIG5vdCBOVUxMDQo+IGJlZm9y
ZSB1c2VkLg0KPiANCldoZXRoZXIgJ2RlcmVmZXJlbmNpbmcgYnVmJyBpcyBvbmUga2luZCBvZiBD
RVJULUMgRXhwcmVzc2lvbiBjaGVjaz8NCllvdSBjYW4gcmUtd3JpdGUgY29tbWl0IG1lc3NhZ2Ug
YW5kIHN1YmplY3QuDQoNCkNFUlQtQyBFeHByZXNzaW9uIGNoZWNrIChEZXJlZmVyZW5jaW5nIGJ1
Zik6DQpNYWtpbmcgc3VyZSB0aGUgcG9pbnRlciBpcyBub3QgTlVMTCBiZWZvcmUgdG8gYmUgdXNl
ZC4NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gU2lnbmVkLW9mZi1ieTogSXJ1aSBX
YW5nIDxpcnVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZW5jLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2VuYy5j
DQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19l
bmMuYw0KPiBpbmRleCBkNjU4MDBhM2I4OWQuLmRiNjVlNzdiZDM3MyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19lbmMuYw0K
PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVj
X2VuYy5jDQo+IEBAIC05NDMsNyArOTQzLDcgQEAgc3RhdGljIGludCB2YjJvcHNfdmVuY19zdGFy
dF9zdHJlYW1pbmcoc3RydWN0DQo+IHZiMl9xdWV1ZSAqcSwgdW5zaWduZWQgaW50IGNvdW50KQ0K
PiAgCQkgKiBGSVhNRTogVGhpcyBjaGVjayBpcyBub3QgbmVlZGVkIGFzIG9ubHkgYWN0aXZlDQo+
IGJ1ZmZlcnMNCj4gIAkJICogY2FuIGJlIG1hcmtlZCBhcyBkb25lLg0KPiAgCQkgKi8NCj4gLQkJ
aWYgKGJ1Zi0+c3RhdGUgPT0gVkIyX0JVRl9TVEFURV9BQ1RJVkUpIHsNCj4gKwkJaWYgKGJ1ZiAm
JiBidWYtPnN0YXRlID09IFZCMl9CVUZfU1RBVEVfQUNUSVZFKSB7DQo+ICAJCQltdGtfdjRsMl9k
ZWJ1ZygwLCAiWyVkXSBpZD0lZCwgdHlwZT0lZCwgJWQgLT4NCj4gVkIyX0JVRl9TVEFURV9RVUVV
RUQiLA0KPiAgCQkJCQljdHgtPmlkLCBpLCBxLT50eXBlLA0KPiAgCQkJCQkoaW50KWJ1Zi0+c3Rh
dGUpOw0K
