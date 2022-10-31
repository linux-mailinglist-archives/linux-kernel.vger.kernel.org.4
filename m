Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAD61330D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJaJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJaJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:50:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB4C77E;
        Mon, 31 Oct 2022 02:50:47 -0700 (PDT)
X-UUID: 88ea5f3829ec4f5880114fbd4dde4295-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wXK7R0VrP70obFWmdHfxAhAYLbXs3m1mRzgr75u+1yE=;
        b=r3a2MOxplAiJXCA2uY1HNbr39IwoyKjPpy911B94A1kQD8/87U+ZO1ksxedKOVK3o/UIUb+1+Vx8QsPxY1gMstfvS2se4HGfWhTjfvouAgCSMIFYw+/nLfzpHhwJ0fB8gWqhb1r1LTg7VUpk5K/WKH195BYD4BXCgJn1l0QmPw4=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:aa04bcad-4f27-45a5-aec9-bb1616f8375b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-INFO: VERSION:1.1.12,REQID:aa04bcad-4f27-45a5-aec9-bb1616f8375b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:r
        elease,TS:4
X-CID-META: VersionHash:62cd327,CLOUDID:bce7f5ea-84ac-4628-a416-bc50d5503da6,B
        ulkID:22103114591032KB6KJV,BulkQuantity:7,Recheck:0,SF:38|16|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 88ea5f3829ec4f5880114fbd4dde4295-20221031
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 198616210; Mon, 31 Oct 2022 17:50:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 31 Oct 2022 17:50:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 31 Oct 2022 17:50:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEaBDC6jTMyrcJvbViWfq/pHjI6Kk1bo8bKbuaSd9f1Qc9nQmmp4ji7jk9Ufa79b8I/nJtiLVyGp/HI8DcBLVESISl4Rs22rgkABZuJeRltN0fO3lWWgqlH6zMYiZjQR74RKfJNCn3ICDm9vDARRM2h5Ezj0C8Rp2iXb9Z6vDwkxwLVVrrh2MJp7Aud8Lug7nOwtbEIO4cxv/GHFrq17QyRbWYCbP672cGCvEsmApdojfTjsye7Vw9MSKQbcC7R4USamR8mdpYOcHskltD7/485BNeC50yXdjHXdC0L+VlToa4gNeT29C55bsgsPe1k832swCTeaaezhu8oXpJfWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXK7R0VrP70obFWmdHfxAhAYLbXs3m1mRzgr75u+1yE=;
 b=QxhVs9FzkGWcpGvT+JR65ZFK//QveOLMWUrLzCfiw588UYauRLA52vaR1UPNOtukKdOne5O0d4Vo1TG+y1TZt8bvTinow/TOzMfZnXvsBGjDV3j8rcazbb8h5bZjgr5Q+fAbHxj+t22fPucCd+k8ykq7aA4meL1dWE1KfeAK8odZB9evPzii8ZZ8uTyr7nZ4mcl+RfIfLoAUAj+xSMhT3VcQg4dcsR08575L7F4/Nlj2NTKTvYz0+SFuV1PAU44HGgJQ5doLVbjPrlNxVJSapsUKKPWmDTl/geFw8VXb+XAhKs52ZhmrqLa1iYgauFT0abXmyPIfoHlADVv5wKZd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXK7R0VrP70obFWmdHfxAhAYLbXs3m1mRzgr75u+1yE=;
 b=UlNplNEjCRn4KKYQJx7PSjzNFyqRZgVYoZTwWw2jB2movE6ocUq6lGJG7vKTA9NG+9v5xH85oSN+ynPOW7i5LE+3+dTjyOKQ5oDPVvqzlGwyK+NqIG0DcWXF1FbGj2zgjXKrmjPtjHuVIoUew9kS11T23f6luVveJGBWxuZ9+Ig=
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com (2603:1096:4:175::12)
 by TYZPR03MB6217.apcprd03.prod.outlook.com (2603:1096:400:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.10; Mon, 31 Oct
 2022 09:50:39 +0000
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::2023:6096:cfad:9e4]) by SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::2023:6096:cfad:9e4%3]) with mapi id 15.20.5791.017; Mon, 31 Oct 2022
 09:50:39 +0000
From:   =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= 
        <Mengqi.Zhang@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: mtk-sd: add Inline Crypto Engine support
Thread-Topic: [PATCH 1/2] mmc: mtk-sd: add Inline Crypto Engine support
Thread-Index: AQHY4jOa8JAJQkyflEOYpQs1p9mmD64T6bKAgBRuXAA=
Date:   Mon, 31 Oct 2022 09:50:39 +0000
Message-ID: <b557604932edfcd9847f0f033f410b7a68c704dc.camel@mediatek.com>
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
         <20221017142007.5408-2-mengqi.zhang@mediatek.com>
         <438bf06d-c4f4-74b2-8903-e89dc52196a7@collabora.com>
In-Reply-To: <438bf06d-c4f4-74b2-8903-e89dc52196a7@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6261:EE_|TYZPR03MB6217:EE_
x-ms-office365-filtering-correlation-id: dce1d892-7e17-422e-3c12-08dabb255e51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFBGsuStrSE2nVKk0HHu70Ftwb47txwcMid4DdAp8cTIgtGi+6U+BWTT9a53vrXDoaDNv0s+/nAfiezASuS1BBNHfdC7UYLtnTU7/bW/wQF9iNdOmWVKpOkrl8pVdFKB8gJ/qXEjRDQ7QI8P75MoGzNbr61WjNuZkc1DMHBj1OAQNOSwiGHVO1pNM+i7myFTyK2pwQfK6AtnTqhYdlkNtQBE+lkb8ilFwRP7QfGeajiPenQow8x/D/x+wV/bcXsFSLTLJJ9Sp+93kp2Sx6DklEzPmZikGZZfLJtrK9eSIlGq1qV7gBQ2UUvEAiN7FY30PDeFEOXB/mOEm+ug1JznmPwO7YOQFaPHM31YNJvfY9wyGFzjlrz7O7a3QK2RHMt9pDb1KDRRT64o2ITktFwIrKovUGXKxgApFlHS4KGrBfc56ViHaB1cJ2Nj8shBzT+XaAn4sgG9ibB5ZLuH1r5exQU6/TlOu5vKz6rRFcZQLNyCG843/cK0jDiVW5KQtecJaiTBrPNBtHsxMT9vvd6b9/UhEpZaG6nt3SceBw+qqHDpsP7a7FBOs4V5yEyTsqmVtmgTcCdKQfqGpDrvl1m4idFhq4s4cUzm1WC9BykfyRe8nxA1M61I6KNKHhuMQxw/5c5pqdyyhFb+CnL7RLpaSEhFq7t5xj4+cXFgk2TD3rQ0YAHVGkXMfV/AZTtH5E7dM+Jy13HSOFSbHmG7QB+Y6ZjOd8h5BUbqa0p5hCkw8UkandozGm0y7qLBasLg5PMPr6JHi20KRltPTZM1X/q+sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6261.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6506007)(66899015)(38070700005)(83380400001)(66446008)(110136005)(64756008)(76116006)(66946007)(66556008)(8676002)(4326008)(66476007)(122000001)(38100700002)(85182001)(36756003)(41300700001)(186003)(71200400001)(26005)(6486002)(6512007)(478600001)(86362001)(316002)(4001150100001)(54906003)(2906002)(8936002)(4744005)(7416002)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3dpUW8vL0Z6QitSNk9kaXgvVzR1ZWlkWExDWWNYZXllK1FCTWZad1BWbVl5?=
 =?utf-8?B?WlExKzJ1V3p5ZGpmdkJaTUZEQmtRUlZCcmRlNEc0TGw5d2dnL1h1MjRLM3JZ?=
 =?utf-8?B?aDVqTndxQW5wTTlTcC9lem10RjYrRStMZ2laV1NMNUZuOGNsZFhlMmpiOUwv?=
 =?utf-8?B?TW83NjgrL0dEanRjRHlMU3pzdStmcXNiZjROYWRLQ0h6QXc3eWwxZzlYVHdk?=
 =?utf-8?B?L2FURTRobWNGTTNBTFBnRnRVTnZUZjhIRW9UaTlQUCszMUtJLzhCT2p1K0JS?=
 =?utf-8?B?bkpUdHhaZlc0eFdOYi9VaGVMNld4clFIWEZ5Z29SRnhqNHdkcTRTdWpIeDVW?=
 =?utf-8?B?aUtYTE1MSE11dWFkdVB1dlJPUGhyRVNSQjJUL2swc2p2RHBQSmZVdUt1QjFU?=
 =?utf-8?B?em9uWDBsZ25kU2ZBaDVzemlDTTZuU0QwT2pqcnNDYm9hb1dGR1g4R1VzcExj?=
 =?utf-8?B?WFcwekxQZXVMVTlnSjFEWnp3d0xTZGgxV1Z6ZlQyK000ODdBL1ZXWFBLYmsr?=
 =?utf-8?B?WStJVmgvUmZ1K01ydnowV0NtSitKQi9IQ09lRlZuQzc5TWJ4UUR6dzdwcWxB?=
 =?utf-8?B?WmY4YUw4U3phWVRUL3RacUNhaURVQjAwd2JtL2pVWmFBc3M5NkdObmtwRnVy?=
 =?utf-8?B?QWxCaWt2dUtabnhIRjlibmRBQVVsK3BTS2JZNkpHclZKVDNiOHVLNG5QL3h0?=
 =?utf-8?B?Qk92aU42VmNNVTgzYjZEVUphUXlGS2xWNG9vMWFlV1d0TUU2eVdvN0lTaVI2?=
 =?utf-8?B?VnFXMHNpOFZPTm1lYlNJdkI0RklUY1hwdGxLYW9ndHh6UlZISDl1WW9YRjZr?=
 =?utf-8?B?Zm5vVThRWlhBeEpvSDJxWllMZURrWTROUnhIQWVZV1IxbTQ0S2RvZ1l6WFJG?=
 =?utf-8?B?U1pRM3pxQlFiK2R5NWEyWkFObHNaSVlkMS9QU3BJbGkzc21ZYUc4RnltdUlF?=
 =?utf-8?B?N0ZZdWt6RkVlemR4Z2RDOVZXVWhyNkc2QkJMbUtWekFJMGEzbVlvTm9Jblpy?=
 =?utf-8?B?bWRqMi8rdW5acXNQaFJIQm4vZkc5UmgybDQ2TnB2aktIWHVIMDZJK2Q2UUJB?=
 =?utf-8?B?MGg5a2JCWXg1bDlXL1ZOWTFDM014MXhRdndtSkxySTdZSmhmK0J0RUZINXBI?=
 =?utf-8?B?MWx2dXNPejBWL2RKQ2p2Q3cvWGxUaFV4Rng2Rk5YcjA2bEdXVjFwL2pHc3c3?=
 =?utf-8?B?eWY3dVpxTytia0ZidlFORHhQeElpSEQ0NlRmaGZTUEFXbjVpTysxa2VJTCt5?=
 =?utf-8?B?aW5MRzNCWTBraGlqQzVYdFdxRyttMVFqeHlNNTUvSDFJdTJZekJ3TjV2MFpQ?=
 =?utf-8?B?NWJmcEVHRmZ3RVM4aVZyTHBwKys4SXRjcUgrbkJtQzJmcmxVWTg2SU1HbnZj?=
 =?utf-8?B?K1ZLYmQ0Tzhoc1drdUE5MGUyRWg5NkRnZ2FQd3FpQ3ZRdi96d1pncVRmdUIr?=
 =?utf-8?B?WGRrL2VGN3ZYeVJEWFh5QXJVOE51anVaUWlwRWtRRU94TU90aXhlbVJydGIw?=
 =?utf-8?B?RnJsLy9QeWU1KzgzczlENEpBR29KTXhlYnpneVFwSmpSeTRaQUdLQXhQeCtk?=
 =?utf-8?B?cGpjeHhnSTUzOWtsRkZvbWRRam1TSjM1UTVlTXZjV2d2c2huWWI2bVVybW51?=
 =?utf-8?B?em5HR2lCeXlCNDIxWGhNcEk5TTByVWNlZzRBVEM4bGpHK200NWF6OGZybVpR?=
 =?utf-8?B?MkVOdCsyd3pjSnVPTElLcE5SOTViZGJVaG5XSGZQOXhkY0M3WEUwVWlDQlRX?=
 =?utf-8?B?ejhxTTZRTmxFVHFNbXNGeDZteE5UTXplWWFmN3gyL01acThSb3VWV1pKeHlR?=
 =?utf-8?B?dnpZSEdqNnU1VU1QS3JLR2RJTnZRK0RrMWUwL09mVTJNd1Y0QzluOWg1T2hr?=
 =?utf-8?B?WUZlZ2wvZmI0SW5qSXFwWHUxZEdkQkt4TlJ2TnhmUDZtT2traVFhTWx6RHhx?=
 =?utf-8?B?NkFEMThjMFkyVmlXOGRSYzRkSjRWQjQ2V0tvV3QwUDdUTmN4WXNYT0M2c1lE?=
 =?utf-8?B?ZE9rdFVMQSsvbHRMcEJ3bnk1cVlnOHV1aDd3bU5MR1VQSm5nRFdCUDJGVVZn?=
 =?utf-8?B?TWlpVlNBaG9jTVBSR3FpczgycEFScitHd2Rhd0RnUllRWWJLNHlPY3hua1di?=
 =?utf-8?B?VEFMSFNHWWF4V09saHVXNEd2RUNBd0sxZjNmanBhVWRZUlR5c08ySjNBU01V?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <379A633ADF9C42439F9A6920521F02AF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6261.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce1d892-7e17-422e-3c12-08dabb255e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 09:50:39.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OjtSfXTLzDmOsKSVUF42dbrEk2hR8tQZWndoouUdJoT5yrYn/JSfGtnCQEWPXcPJcO5XGw4RmlOwt2e885vzrEav2Ec4F1fojshcKV2Z+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6217
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDExOjUwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTcvMTAvMjIgMTY6MjAsIE1lbmdxaSBaaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IGFkZCBjcnlwdG8gY2xvY2sgY29udHJvbCBhbmQgdW5nYXRlIGl0IGJlZm9yZSBDUUhD
SSBpbml0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1lbmdxaSBaaGFuZyA8bWVuZ3FpLnpo
YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEhlbGxvIE1lbmdxaSwNCj4gSSdtIGEgYml0IHN1cnBy
aXNlZCB0aGF0IGVuYWJsaW5nIElDRSBvbmx5IHJlcXVpcmVzIGVuYWJsaW5nIGEgY2xvY2sNCj4g
YXMNCj4gb24gZG93bnN0cmVhbSBjb2RlIEkgc2VlIHNvbWUgU01DIGNhbGxzIHRvDQo+IE1US19T
SVBfS0VSTkVMX0hXX0ZERV9NU0RDX0NUTC4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4g
d2h5IFNNQyBjYWxscyBhcmUgbm90IG5lZWRlZCBoZXJlPw0KPiANCj4gVGhhbmtzLA0KPiBBbmdl
bG8NCj4gDQoNCkhpIEFuZ2VsbywNCg0KVGhlcmUgYXJlIG1hbnkgd3JvbmcgcXVvdGVzIGluIHBy
ZXZpb3VzIHJlcGx5LCBsZXQgbWUgZml4IGl0IGhlcmUuDQoNCkluIHNvbWUgTVRLIFNvQywgd2Ug
bmVlZCBzZXQgYSBlbmNyeXB0byBlbmFibGUgYml0DQpNVEtfU0lQX0tFUk5FTF9IV19GREVfTVNE
Q19DVEwgaW4gc2VjdXJlIHdvcmxkLCBzbyB3ZSB1c2UgU01DIGNhbGwgdG8NCmZpbmlzaCBpdC4N
CkJ1dCBub3QgZXZlcnkgTVRLIFNvQyBuZWVkIHRvIHNldCB0aGlzIGJpdCBpbiBzZWN1cmUgd29y
bGQuIFRoaXMgcGF0Y2gNCmlzIGZvciB0aGVzZSBTb0NzLg0KQXMgZm9yIFNNQyBjYWxsLCB3ZSBo
YXZlbid0IGZvdW5kIGEgcHJvcGVyIHdheSB0byBkZWFsIHdpdGggaXQsIHdlJ2xsDQpkbyBpdCBs
YXRlci4NCg0KVGhhbmtzLA0KTWVuZ3FpLlpoYW5nDQo=
