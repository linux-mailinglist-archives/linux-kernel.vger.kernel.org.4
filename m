Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA672614A95
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKAM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:26:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D017A90;
        Tue,  1 Nov 2022 05:26:13 -0700 (PDT)
X-UUID: 5dbbbf4998fc4656b96e70cde9e06c70-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pghZSC5IgTGCOzlNwV4CmoFQ8aF406V94a2jbS3Fca0=;
        b=cr+EYZZ+Fj8wtLL5P4N32yN5kdEdPPuG1ZITriBg22BEwF/Gjmt5PXofYnbVx/g1HZwHj1D5PH4wCxwQrDBWPf3Sz/PxeBDbaUq4pYPcy1xbRLgFBP9ZrZkSoXglxvbOcCFiX30aHBigV3tcAPG/bo1psjy4TOge0q8o5SShcQA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:af08a499-be21-4730-b399-cc69bb2f38c4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.12,REQID:af08a499-be21-4730-b399-cc69bb2f38c4,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:62cd327,CLOUDID:b2ed18eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:221101202610KI28YAZ7,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5dbbbf4998fc4656b96e70cde9e06c70-20221101
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 133689075; Tue, 01 Nov 2022 20:26:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 20:26:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 20:26:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQjkX0wwLUBGpLKrMnQ+JrxSAI98b7ZEhWji/bee8KdNHi/agaRqp5sesDPMSJ5rcPKjp/5OxrOCxzx+Pu7/5bQp6JeP8T4yeYQkVOvTQF6qcUOXAQRbHrtJR3fLCz4fh/f1f1daK1Y6ZnhjwOmC8HRLnKFRzN3/Gkmmp9dqUyidUIZOqgIlqYFrSAIruMO/OlWEAIvz1eyYvbNbKXH3dfcRih/qp1bqTxhsAOd7rV7d3hZydPM7/+6VsycOe4fMBD4Ug7L+kuwDbRgsXMo2RmY/4yQhwltk2fnwpuYCbatzOKh9TSut7roR1IyTheA2GQCYa36AJka1Z7vXAd7wQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pghZSC5IgTGCOzlNwV4CmoFQ8aF406V94a2jbS3Fca0=;
 b=fPijM5ONm6szl1dYKjguTT0/wcv88s2e4Dx9eullhjqPoUhYSpg/DulxVXfOaFMTA9UCdHrfs0d5cqjKCcynolwR9ebkeKU0TgdSGL0BUXtgJiBm36l0dU2mSuJs6lNBKkAGOfn6psML3OpT1ZqQnMFiHpr5imAkA/45HEr0J2LPtE1yHeiBv9EgROFs3J4d0XkgxEm08iUL75yjbO3LeITesd1rSo+0MRRm5HgdkC6eckufItkFD83ykKv9uNtTT2OC8x/8BS9OZ9HgByNFvapYhMwNbNoJjQg9Q6ca0hYs83a4xOHOolTKI0bMzqTzhRH5EL8EJLBisdhLxgSIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pghZSC5IgTGCOzlNwV4CmoFQ8aF406V94a2jbS3Fca0=;
 b=jZOCuV1fsjOb0Xe4HaFdMwTb2QlxkzKHb444d0LJu53vq9KzwEks7y91TFSnhhrrFUYk1tfh6zsTkyF0sRZQd6/wVxFawY/2XpnkvyANGWIX1Rmegz9aPd+/j+ygXTbY43i0X/kPOhIeLqvsJ7bD92+sfX++nhTiT5qvE0NfQTk=
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com (2603:1096:400:142::9)
 by SI2PR03MB5449.apcprd03.prod.outlook.com (2603:1096:4:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.10; Tue, 1 Nov
 2022 12:26:05 +0000
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::2669:ceb:938b:470e]) by TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::2669:ceb:938b:470e%5]) with mapi id 15.20.5791.017; Tue, 1 Nov 2022
 12:26:05 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Topic: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Index: AQHY3vZX+12K5aZzWEmPg4uSwosspa4OXRQAgAQ0XICAAGdXgIAFxsaAgBFcvYA=
Date:   Tue, 1 Nov 2022 12:26:05 +0000
Message-ID: <3abb912267895b39829e62ea2ce1c830adcf0a70.camel@mediatek.com>
References: <20221013112336.15438-1-johnson.wang@mediatek.com>
         <20221013112336.15438-3-johnson.wang@mediatek.com>
         <20221014204242.C7CAFC433B5@smtp.kernel.org>
         <6a866b8f4e997a33adeaaf4498c47de76e07fa35.camel@mediatek.com>
         <20221017190501.0B85AC433C1@smtp.kernel.org>
         <b5e4a2332942722f4138e5bf758f61e15dbad92e.camel@mediatek.com>
In-Reply-To: <b5e4a2332942722f4138e5bf758f61e15dbad92e.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6274:EE_|SI2PR03MB5449:EE_
x-ms-office365-filtering-correlation-id: 32b65d15-9bc2-4efc-a6c5-08dabc043f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvg3BRXwZAWMpkl75Djx3y69L4Dr1KD4PI2suT9oaRjwxsArSzac7o6+IYi+osGc8nnvThFXSGlzuM522qcess+V3MFqYfJR+j7kIUfWJ+0v0WvIuydLsKcL35g4Vz+4UGyRie1/a7rrU4ZrcSzsji7jbIcV7zv1jbFJfVhNhRGb8Ke7TRGwveEVzjqaImW3brADSdeKbMM3OSTWU8YxCT+iVEGwnUjOOtD4dLXqKmrZ9wigS7V+J4SLmdJpnFq5ltn1nvi3Ly4k/HuP7FrLijwJMgiVWqp3VMDadca1aQGA0AzoDbYrQeDWKBzc2aV1BgqR1ftwktpeHkI9nFUHSZaDXfO5n+xdUP2finJr9MoeD+/DVqq6IxSSf9m3HMBH/W97m9fR6CVsyEwOMRxCEk+jLxBw4MxzQfyoIFZDebjw+N7Zy6iJykZ7vRFDVtZ4cv/I9hSgNmL+oHQbgkiOGF4r3CpzNAahZvrB+WYclMHwX8xY0xO17WIhDCnXoeS+u8RlW6EP5JnRUH9qGJNdNKvZBFm5fLOcMLiCko7SFFvL4yMMLKv9bI4s86pa5vQ88evncWud2rvkzkvRX0GTw4hKtu9PUbqjrngf7UW7MoXhMCqwWl72KX/pu1VNi5LavwJKKksW2Htht9mYGwydfhj+5rlCbc7bYOwDTO65YBa5uFQr8a5az5EzTRVZLZPM13ls1NnxqyxiuLmvenShRFN5yEgp5c12ze7Wuyja4LuYUyuZLGmoH3jt7c2/oxzB8pRjjwErl1NATMDuPmXWIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6274.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(83380400001)(38070700005)(86362001)(38100700002)(85182001)(36756003)(107886003)(316002)(478600001)(6506007)(71200400001)(54906003)(110136005)(6486002)(8936002)(2906002)(4001150100001)(186003)(122000001)(2616005)(5660300002)(66556008)(66476007)(8676002)(4326008)(6512007)(64756008)(66946007)(41300700001)(66446008)(26005)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0o2ZVRXN0lOM045RmVrNDB3RUtoMmxJeUN6Y3BJTWJ6SEEyeFREbGY5enNX?=
 =?utf-8?B?THVEU2d1dmJDMGVLNlp2bFR4b0pGWTNlR2IxckVpVmpvSmxDU2diQjdyaGRy?=
 =?utf-8?B?TkZJRVlBWDdXdVpWYlllUUZJQVR4cUs5V2MyS0ZRdENLY1A1MzMzVkk1T0gw?=
 =?utf-8?B?R2JKOWE0QVlydkptMitGVndvZWtJaUZvcTVhWGNsL056SnpjT2JjVm82TWFi?=
 =?utf-8?B?Z05LNmU4ZHpIZTVRdHFXRWZLbFQxR2NQcmJFRHdNVjRyQ01UNDNiOFlwSlBy?=
 =?utf-8?B?NGpxZVVlUFYxTkI2MGVrQVFUQTZLajFBYmczYXhGMmpJeUhod2llZ1AzVU5E?=
 =?utf-8?B?Z1pGejRIMGl1d1JCakxOcVF5M2pEb0t3ZEV3WUJJNGJLNW1nU3RTY1FRYUxF?=
 =?utf-8?B?SSt6c2Y4WFMvaUg4SHB4djc2TUNEbVVpQi9PZ3BadzhwcVorVWFlbS95bHEy?=
 =?utf-8?B?VlVYa0F5ejlNRlpjY2NEL285SFN5WVovcXIyQ2hibXA5bEo2emlTTHdjRElL?=
 =?utf-8?B?TG9acWI1TGdPa1ZNSDh6cVNBM0dqejdCb0xpVFlKNE1pY1JiRndiVzF4V2or?=
 =?utf-8?B?QUNlWEFWa1lLcm9ZblcxNlZTb2NtdHhMT1liL24zMG1KYWhaZGJzbDMyVzFZ?=
 =?utf-8?B?TTIySnhJcXhQMGg4b3BkSER5MDJTWjlFUWl1UkRNMUI3L3U5cFFjQm1kaHNl?=
 =?utf-8?B?NkoyMHJPTnEybm1aem11UHBNbkIvSlppMm1aQzBJSm5hMEc2RzdOd1NnaURi?=
 =?utf-8?B?dUJvQW02U0UyWjJsOVVRQ20rTXRMdDNhZ25VYlFHUTdYVElLKzlEYmlyZkJZ?=
 =?utf-8?B?QlAwcFpuNUlFVmhDek5odUttSWFUR0RrYjZGbWRnWFFLbmdZUzRiV2J4ci9D?=
 =?utf-8?B?NFRYYXh6bWRZNkttQXc4SWNZaVRqR2NlamdOc0JoWVp5SzFPR1hwVEloK2VF?=
 =?utf-8?B?dEYwWldDMGlpWTJ1YVd0aGhZRmZ4UjNhd0x4d29pbXFRajI1WWlJaGRkdi9P?=
 =?utf-8?B?ZHZpYXRaL3N6RlUxQW90YjdkMXZLaCtHVElsMVZVWmJUMTUzOVV1bmhUK2pG?=
 =?utf-8?B?clppcnY0QUpvLzV1bk5TVFdnc0hVWU1DMmRnODFXWFd1UFdUY3JkTDNVRy9F?=
 =?utf-8?B?Y0dxTW1RZ2FiQUpzZDd4cUtrMFNERzBFdU11Z2FKcHZYUGlWZmltMGFjSndt?=
 =?utf-8?B?M2dYNnByN3BJcjdrbktuZk5hblE3d2NuMmd3a2FjM3FMRVlLeWsvQktJczlk?=
 =?utf-8?B?UFo5bFNIa0RnQ3NlVGpxM2pFVFY1MXBtVXlxbTNQSXkrUHE0YXIzVDVvMXFY?=
 =?utf-8?B?VFNUM2M5QnVLb1B0NURHZ2VtUWdWeXhXMjBOR1UyMndKekVDckRKRG9CQ0hL?=
 =?utf-8?B?TDR0bEJsa3RRdjB3RXU4aHo1YUlwc25wUXdnU3J4Q1pFZ043blRPSUFaYy9Q?=
 =?utf-8?B?QXorRWsrSStUZy8rRHpib1dtdHVIL0J6YXdPWmRlVWJkQ1ZOUG9XQmZ5TUlX?=
 =?utf-8?B?UkFCdmdmYkpmazFvQXdPM3B1V1JqVHFaWms2WEw3VENiY2FmYTdsOGhFVThP?=
 =?utf-8?B?SmVzWlF6eFVRMCtHdVVGUTYvNWErSm9nNEFxbG1INHlwa0pMbkM1QXhlMGg2?=
 =?utf-8?B?K0hHOHZPR0hqbTNicEhETFhjb1VvVC9vZWdYN09icTh1bGpzaEwwU3V3L2lr?=
 =?utf-8?B?aXdJa1p1dis4VTNFR0JTY25haVpQOS9FanduQmJVY3lEZTU3TVo3Tk9TMUZ0?=
 =?utf-8?B?ZVhUM1dmWlZoSzVQOXZHTmNZNUE3eFptdHdzYWg2eXJPWW9wZGJQV2huWGVh?=
 =?utf-8?B?Q3RxTTFiS1NlaGxqVk5UdGJ2SjdOR0dpOTBUYlo2akFORUtiaTZEMUlyZUVT?=
 =?utf-8?B?K1Y0dEJES0hnWDEzSy9sQjRmVjFtMURKSkE1ZzdIR2lVNWFrNDkycjJic0JH?=
 =?utf-8?B?Sk5TOGt2UkFjb1ZscTNmZTY1RFA1VTZjYldUQXYwT3J5aU12NkFiaFp2MFNS?=
 =?utf-8?B?NXhDeE5JWXBHc3pkRnNUZi8rK3l6cTdvbDVzMlBMSWMrWHhsYXZjdmRXTWdj?=
 =?utf-8?B?MStxWUpCTEZpWEYrOTFOakUvZnZMNnBmM1F5NkJqTjNZbmgvOHVKUWVmdEF1?=
 =?utf-8?B?YXBQTk5qU3VyblAxalNvN2djM2hIbHp2aGhvRUN5dXdmLy9UVHpEZUJyUE15?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DB1A89F84E5EC4AA8F8490774168F3C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6274.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b65d15-9bc2-4efc-a6c5-08dabc043f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 12:26:05.0989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXN0Net/V98zGs9OOIxUggj6+feF/QGAEstTyDqtismQJthY4/jn37+Fp3gznw+RSdfc0dX9t2kzU69Mrv7rMEA8YLDO3LT4EU+ObQgB0vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTIxIGF0IDExOjE3ICswMDAwLCBKb2huc29uIFdhbmcgKOeOi+iBlumR
qykgd3JvdGU6DQo+IE9uIE1vbiwgMjAyMi0xMC0xNyBhdCAxMjowNCAtMDcwMCwgU3RlcGhlbiBC
b3lkIHdyb3RlOg0KPiA+IFF1b3RpbmcgSm9obnNvbiBXYW5nICjnjovogZbpkaspICgyMDIyLTEw
LTE3IDA1OjU1OjA5KQ0KPiA+ID4gT24gRnJpLCAyMDIyLTEwLTE0IGF0IDEzOjQyIC0wNzAwLCBT
dGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gPiA+IFF1b3RpbmcgSm9obnNvbiBXYW5nICgyMDIyLTEw
LTEzIDA0OjIzOjM0KQ0KPiA+ID4gPiA+ICsgIC0gfA0KPiA+ID4gPiA+ICsgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2Nsb2NrL210ODE4Ni1jbGsuaD4NCj4gPiA+ID4gPiArICAgIGZoY3RsOiBm
aGN0bEAxMDAwY2UwMCB7DQo+ID4gPiA+IA0KPiA+ID4gPiBJcyBpdCBhIGNsb2NrLWNvbnRyb2xs
ZXI/ICdmaGN0bCcgaXNuJ3QgYSBnZW5lcmljIG5vZGUgbmFtZS4NCj4gPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IFRoaXMgbm9kZSBpcyB1c2VkIGZvciBkZXRlcm1pbmluZyBpZiBQTExzIGFkb3B0ICJo
b3BwaW5nIiBtZXRob2QNCj4gPiA+IHRvDQo+ID4gPiBhZGp1c3QgdGhlaXIgZnJlcXVlbmN5Lg0K
PiA+ID4gSXQgZG9lc24ndCBwcm92aWRlIGFueSBjbG9jayBidXQgYWN0dWFsbHkgY2hhbmdlIHRo
ZSBiZWhhdmlvciBvZg0KPiA+ID4gc29tZQ0KPiA+ID4gUExMcyB3aXRoIG5ldyAuc2V0X3JhdGUg
Y2FsbGJhY2suDQo+ID4gPiBEbyB5b3UgdGhpbmsgdGhpcyBub2RlIGFjdHMgbGlrZSBvbmUga2lu
ZCBvZiBjbG9jay1jb250cm9sbGVyPw0KPiA+IA0KPiA+IFdoeSBjYW4ndCB3ZSBhZGQgdGhlIHJl
ZyBhbmQgcHJvcGVydGllcyB0byB0aGUgbm9kZSB0aGF0IGltcGxlbWVudHMNCj4gPiB0aGUNCj4g
PiBQTEw/DQo+IA0KPiBIaSBTdGVwaGVuLA0KPiANCj4gTm93IHdlIHVzZSBzdGFuZGFyZCBjbG9j
a3MgcHJvcGVydHkgdG8gZ2V0IGNsb2NrIGluZGljZXMgZnJvbQ0KPiBhcG1peGVkc3lzIG5vZGUu
DQo+IA0KPiBJZiB3ZSBpbnRlZ3JhdGUgdGhlIHJlZyBhbmQgcHJvcGVydGllcyBpbnRvIGFwbWl4
ZWRzeXMgbm9kZSwgd2UgaGF2ZQ0KPiB0bw0KPiBmaWd1cmUgb3V0IGFub3RoZXIgd2F5IHRvIGdl
dCBpbmRpY2VzLi4uIChJIHRoaW5rIG9uZSBub2RlIHNob3VsZG4ndA0KPiB0YWtlIGl0c2VsZiBh
cyBpbnB1dD8pDQo+IA0KPiBUaGVyZSBpcyBhbiBpZGVhIGluIG15IG1pbmQuIEFkZCB0aGVzZSBw
cnBlcnRpZXMgaW50byBhcG1peGVkc3lzDQo+IG5vZGUuDQo+IA0KPiAJbWVkaWF0ZWssaG9wcGlu
Zy1jbG9ja3MgPSA8Q0xLX0FQTUlYRURfTUFJTlBMTD4sDQo+IAkJCSAgICAgICAgICA8Q0xLX0FQ
TUlYRURfTVNEQ1BMTD47DQo+IAltZWRpYXRlayxzc2MtcGVyY2VudCA9IDwyIDM+Ow0KPiANCj4g
DQo+IEJ1dCBJIGRvbid0IHJlYWxseSBrbm93IGlmIHRoaXMgdmlvbGF0ZXMgc29tZSBydWxlcy4N
Cj4gQ291bGQgeW91IHBsZWFzZSBnaXZlIHVzIHNvbWUgc3VnZ2VzdGlvbj8NCj4gVGhhbmtzIQ0K
PiANCj4gQlJzLA0KPiBKb2huc29uIFdhbmcNCg0KSGkgU3RlcGhlbiwNCg0KQSBnZW50bGUgcGlu
ZyBmb3IgdGhpcy4NCg0KQ291bGQgeW91IHBsZWFzZSBnaXZlIG1lIHNvbWUgYWR2aWNlcyBpZiB5
b3UgcHJlZmVyIGludGVyZ3JhdGluZyB0aGVzZQ0KaW50byBvbmUgbm9kZT8NCg0KVGhhbmsgeW91
IHZlcnkgbXVjaCENCg0KDQpCUnMsDQpKb2huc29uIFdhbmcNCg==
