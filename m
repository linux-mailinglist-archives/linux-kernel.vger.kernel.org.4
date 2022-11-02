Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9D616042
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKBJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:54:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584F1F2D9;
        Wed,  2 Nov 2022 02:54:10 -0700 (PDT)
X-UUID: a2e59783e0c94889b587d99dab47f15c-20221102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U/NcZRE8nMB8rDzF3lXBn7AdiK0SILBceWcXhTnL/E8=;
        b=caxdIhI0KbQM7AmFRDjSh4v221MXdkcDZemKeAY/n23HENAU8jsLOaLpLjYM/WCkE8LkSv8Cv4xS1pjm2gXGzGc7BZPTcEgLIyBiBKH7W1lbcVe3nJk7LgWDXf/ZkRx9D2LGE8t1Ot12Fn1NnPaFn+fw7YEOgxlvuN7DDCAwj+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0399cce1-7767-4231-abc3-239da6513e1e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.12,REQID:0399cce1-7767-4231-abc3-239da6513e1e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:62cd327,CLOUDID:1aa56581-3116-4fbc-b86b-83475c3df513,B
        ulkID:221102175405P0QRDE0N,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a2e59783e0c94889b587d99dab47f15c-20221102
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <elvis.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 480716887; Wed, 02 Nov 2022 17:54:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 2 Nov 2022 17:54:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 2 Nov 2022 17:54:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C99hnd7mVWsMNUu3gSe0dTeabrI7a40GFOmznGKAWGSV1k7LZbs+B3boyIocTIB+cyg8NAucwmr4fPhHPFPeMmyOqwLHQ+/ZK8aPrWbd8AbBhQ17vKZQ234McsxiCA3PrFAkUIpe6tfHjF/QLHH20MpagGEkzonbQsq1llpEiUj73zIspRpqC4m4EvtoKxsEXUyTe7pJSGBNi75iGyuiYlnrONcNAIapZWDACEqXhfwk1jtjnSMO/S3FSFZPgxwTVVnF16iSM85odMvHckcnFPKgIjTVWy83wZtLOl/2hQ9QZGtp2tWI8mWGnKE/AsnX54wRN8FEJXb8zZgl4r19ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/NcZRE8nMB8rDzF3lXBn7AdiK0SILBceWcXhTnL/E8=;
 b=QtBHA8FJgFVCeFOWFDbRC4S05o8bjEbx+P1UcN0T2XvgIThibeiy/og/DWisYpZb3se76jz3TqBVHoGqBozqWXfK+L0kAy3/o0TGN83lZYPobr6RQ8gNrkHqQZdsvoq+2zyXewmoJtx8IMbcAVmhFMSW4TsyzXzLk7L1pfyBiKMq1tsCb63QTVqy2rMtiFppdu+wyGKPL1FPH8dpuBLyRgSpfR0udgSEzT3bYxicagEpIEcQ9PKAglg1x2PuEdP7c2MiqjORLYHnSXBhp+sgZ4uGLPM+0ZrA7Stmfg177C2iq03tgJipkDfZVK25RXGiZdSndL234bdpFw/E3tDnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/NcZRE8nMB8rDzF3lXBn7AdiK0SILBceWcXhTnL/E8=;
 b=TeHPPvAr0wyZNIxtd0A/GR64APvGXUyMIq9Rqc0wHS2fr7+uzTmFcQg9a3vJU3XtUY38w71MfNwFKgJVF1ARBxD9xS2VV2aklOc8Im2yDUZ8DaurVuFuS1DfC/oBhw6oBjfroJCgkawrjxkRmGbaMv/QG4vJM8cAZcdD5yszsjE=
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com (2603:1096:4:d::22) by
 PSAPR03MB5509.apcprd03.prod.outlook.com (2603:1096:301:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.17; Wed, 2 Nov 2022 09:54:02 +0000
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::9f80:493b:36dc:30bd]) by SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::9f80:493b:36dc:30bd%3]) with mapi id 15.20.5791.017; Wed, 2 Nov 2022
 09:54:01 +0000
From:   =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>
To:     =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?SG91bG9uZyBXZWkgKOmtj+WOmum+mSk=?= 
        <houlong.wei@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bingings: gce: add gce header file for mt8188
Thread-Topic: [PATCH v2 1/2] dt-bingings: gce: add gce header file for mt8188
Thread-Index: AQHY64RNwdaqaV1/j0yoBxgZriLaI64n0/6AgAOXCQA=
Date:   Wed, 2 Nov 2022 09:54:01 +0000
Message-ID: <777cdf431a67056068f9c76c1a97640590854bd9.camel@mediatek.com>
References: <20221029105017.20734-1-Elvis.Wang@mediatek.com>
         <20221029105017.20734-2-Elvis.Wang@mediatek.com>
         <d04b6b07c69becd7cf80736a88d556138340c974.camel@mediatek.com>
In-Reply-To: <d04b6b07c69becd7cf80736a88d556138340c974.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3228:EE_|PSAPR03MB5509:EE_
x-ms-office365-filtering-correlation-id: d6028da0-4408-4420-9f0c-08dabcb82b58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqzvnmrpPlIKtWTaVLvyptGre12OpU8tjl1CIRfvZAcxlb7La3end1Zg4+dlOtf7WkA0hX5L6VQYSI58L6WBta29g2NbsSfUdQgP6hn4Oip0EWgUg/N0rAQulrIXeYDL0gKhayjtaquZ87BigXAlRb4TvkMtJDHu8V1q3Pp8NT3IAicrxR6YR16f1vHGRpnKtYoB/Dp7nZKbvLDNjXdadLp/2vNf3OYadlb0rcDrIjiCzbyJOC576Pos2jXfpz1Q4SD7lIazAbLRh3N/P0Vrx+sBY4+91mXWaOKj6+VznY8AzS5CAs1B/eQPW/y0kjV0JYFb2xxidWONuB0F8ddsjggEjGPH4DdsQDNMmCbgdcVe+dpb29QD8mLzAYlU1BJ7r/w8YskdFbk/lE7EF25QQ+blKMjoruHHmvDJ5TgpL8Jy4FXtqT7U3Usx3yAThKVBJkp87EgjhX8PsesP10cLgRX0VgzbwLBGN6dB/Sya8s/fotEEpWAXbaM+jkFSeOkdebDJWlxjJA0uHkPns6q+f1g2NcPqVbdDU0cEyfEOM/hqhuuKW03lXCiANq7MKRcBUWLW5mIe6sCOwLxkmQRIbJ43q/+lAmIE1gUsEYKLbcLv3eCyVXRovz3TuqNGeYrplNWMZSsvI01R0KQM/wkTUInNJvIeZXoOBI5Z6K2ApKEv/8uwOidndiYjC21mB/gN5IRiuAklJc+P1rkGwRCQirawTDRY2hFp+rq6XwSa32ttJBln9TCFVnYv25/AIgfCyN5lGUQpDx6JD9Y8hLacele8vgRXY6NWSS8/ZhP441Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3228.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(54906003)(85182001)(110136005)(76116006)(5660300002)(6512007)(2616005)(66476007)(26005)(4001150100001)(186003)(2906002)(66446008)(4326008)(66946007)(66556008)(41300700001)(36756003)(478600001)(64756008)(8676002)(86362001)(316002)(6506007)(83380400001)(71200400001)(8936002)(38100700002)(6486002)(966005)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDI2a2RKRXNDZkRuR1JMQ3I2dGRDcmo0S0hVVEZ5Vlp5eWFzK3dKdHRjQmFu?=
 =?utf-8?B?SCtuNXpqbnpyek5UZW5FVVB4YlVzTDc0Qlp5NGtkWXErMzVsMGpUTDhvdXRw?=
 =?utf-8?B?Y0tCMVFnejlJZmRMQjhlWFNiUXp3S3VyQXNESUszb2xVeVpNQm81ZHpSYVBw?=
 =?utf-8?B?c2hoRDVTMFpXV1pHUzIrNE5HZUpRTVFneURuM1g0ZzFwVEs5WVZtbGg1OU9z?=
 =?utf-8?B?UmJtQUh3Y0V1R09BZjhqRnpSbmxYQkh6b0wzZkNWRkx2Y2IvUU1OZjhPZ3I3?=
 =?utf-8?B?VVE4N05tOWN2RFdpd20zSlBza05hSHpNRVAzUXlpRnh4L0NUUGNCekRVc2lO?=
 =?utf-8?B?VnZPbUtVMnJQSDczQlFhb2ZYRGZWNEFJYmdNV0Z2elNBekkvQ3RMUXdLUFFz?=
 =?utf-8?B?UkE4LzVJUlBqMnBRbm05NG9CcW5JN2g4cmZTSmlZRHJNVUN0em9kb2tNbmkv?=
 =?utf-8?B?S0N3MEI2ZDFCYS9LS1NaeDFqcHNuTGpTZEhHSGV0Z3A5MlpQdlZ3anA2eHpJ?=
 =?utf-8?B?WGNLQkoyYlovN2d5RkxJL2dPbTkyRW9PTS9qeWRhUDgzWi9lbWVQejZtaXht?=
 =?utf-8?B?cHEwaGpsbnIrVEoyM3RtTDhreUVGTzlOY3l3bzFyNGF5S1NVSG9leDJ6MWEy?=
 =?utf-8?B?TnhTb284Lzg2OFdJWHpBQUZrc3M4bUh5elptaVpoM1BWTHBaWVphazFhNmdV?=
 =?utf-8?B?cTIwd09pVnpDNHNyb1BqRkh6L2MxNVJndFQvUDhtZE94QUhEY2t2Qk1hWm5v?=
 =?utf-8?B?TXlQTkNKY1NDWjVtY2RvalhrQW5idTBZRTdDRnRaNkVyTWFLN1E0bXBlUTcz?=
 =?utf-8?B?Y2VrS1lndkpIcjhwWENUKzhxaVozdFJNd3prc0VGQWQxUEY0eTRHSW9UNENR?=
 =?utf-8?B?QVhLZWxtbjV1Y0xpNE1ZcUwwa2d3Zkh1cW1tRURPNkdzWHErYU5GVG9qbDUv?=
 =?utf-8?B?SjdmbWRBNE5URCtsSWd5eDBPdzZRT250b1d2eFY0TEdpVVJZMzRGRE5NMG1j?=
 =?utf-8?B?QWZmUElMSjI2NXF6VDRFbk5nZ2NzUlVlKzVDVVl1YzZUUmRRcHNmOVpjMnow?=
 =?utf-8?B?bWsvNUR2QUJ6S3A5VWxCdmZpS0IvSGM1VSt3N3lsVVlDVUt0QnVUeFExRkE3?=
 =?utf-8?B?Q3JzalNNdlFzMXhLTSszb1BZTHdTSVBRbm5pa3pqYmRwcHpsYlFrMzVUcmZx?=
 =?utf-8?B?TDYzcWNKb0lMQjl3V3l3SWxiWERwWDk1bCtjUldEQzFuZ1Z3ckdubjBqNTd6?=
 =?utf-8?B?U2FFcnZXdkY2QlhQNW1tbWh1MktLV1gxNjUvUG8xZDlmR2xWWlJ3SFZZQktV?=
 =?utf-8?B?dUhkVFVMUm56ZERhN2dJT2RVN3JIOVBtVWlyRnZXTnV2Y0ZvUDRPb2daTVNw?=
 =?utf-8?B?VGhPNjFIOHQyT2dZT3hWVGZqK0ZpM0lFMldtVmRLT25LUXF4VjQyNUwya0Fl?=
 =?utf-8?B?RE5QRzVHbjdZQVZYcVQ0SFdFY25ld1hWZW5IMkM3VTJkbmg2V21xU1FvK3oz?=
 =?utf-8?B?YndJM2h4VjE4aGlFVWhIajNzcnZTMjBRWmNqcnl0WEJjVXFieG8rMVFJYnhv?=
 =?utf-8?B?NW96MFhZVnAxaDlBb29BazFVeUFJU1VaVWRacWZuRDZhdUxua3JEeWVqdWsr?=
 =?utf-8?B?WHpEclR4b0lxbE0vaFB2Zlc4R0k2QndCeVdITENNZWRRSVg0emZERW1ZcmQz?=
 =?utf-8?B?K0xUUWo1NHpLRkQ1TjV5cTQ3RlZqTUd0VFNaNkpRMmdyNmIrUHRwVGJLQmkw?=
 =?utf-8?B?WHE2T0Fab3BvWThUYnpreUdsalc1eXNZMENpaS9jc0ttUk9tNnM3bW9xSE9E?=
 =?utf-8?B?dzcwZW1mYmZyQlZkNzNDZjcrSDVBOGFhbVlEaU51YkxKeWdBc1FTVWdSa0kr?=
 =?utf-8?B?ZVpNS0RWVm02STBJYVk2Z1dsZEtMYm5OWE9pUnZRMndFUmlRb3RFTXVSelE1?=
 =?utf-8?B?d2xVdm9KMlJjZ3VIWERxcWI3VWF2Y2JoR1daZGlXVzdiL3d0eXlsbU4rbmZi?=
 =?utf-8?B?dFNvS25YbStLMDg2WmRoMUxTay8xVnZzTXdoeEhjdDBLMmtEODNxdXdwbzNS?=
 =?utf-8?B?NnYxTmRtRWFpTmJBWEExeGUyOVdwamd5bWphWU8yN3NrS05tOFQzNkoydGpI?=
 =?utf-8?B?NkNQdE5HNGpyejNJZzVNdmg4OFBqME9aMURmU0c2enBxZ1l2Y2ptMFh5dnBr?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02132E1F7E07084B91A76BE89F5E36E1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3228.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6028da0-4408-4420-9f0c-08dabcb82b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 09:54:01.3110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8fOVOVXqLwKebh4ript3k514s85M2rR9ODrDqPHft42+uZSoYuAw/PkOOdQ8gBrzUp7EYJjGxfWl2RZeqfhBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTMxIGF0IDAzOjA0ICswMDAwLCBSZXgtQkMgQ2hlbiAo6Zmz5p+P6L6w
KSB3cm90ZToNCj4gT24gU2F0LCAyMDIyLTEwLTI5IGF0IDE4OjUwICswODAwLCBFbHZpcy5XYW5n
IHdyb3RlOg0KPiA+IEZyb206IEVsdmlzIFdhbmcgPEVsdmlzLldhbmdAbWVkaWF0ZWsuY29tPg0K
PiA+IA0KPiA+IGFkZCBnY2UgaGVhZGVyIGZpbGUgdG8gZGVmaW5lIHRoZSBnY2UgdGhyZWFkIHBy
aW9yaXR5LCBnY2Ugc3Vic3lzDQo+ID4gaWQsDQo+ID4gIGV2ZW50IGFuZCBjb25zdGFudCBmb3Ig
bXQ4MTg4Lg0KPiA+IHYyIC0gdXNlIHZlbmRvciBpbiBmaWxlbmFtZSwgdXNlIER1YWwgbGljZW5z
ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbHZpcyBXYW5nIDxFbHZpcy5XYW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQm8tQ2hlbiBDaGVuIDxyZXgtYmMuY2hlbkBtZWRp
YXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPiANCj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXdz
LCBJIGhhdmUgZml4ZWQgdGhlbS4NCj4gPiANCj4gDQo+IEhlbGxvIEVsdmlzLA0KPiANCj4gSSB0
aGluayBLcnp5c3p0b2YgYW5kIEkgZG9uJ3QgZ2l2ZSB5b3Ugb3VyICJSZXZpZXdlZC1ieSIgdGFn
Lg0KPiBUaGlzIHRhZyBzaG93cyB0aGF0IHdlIGFjY2VwdCB5b3UgcGF0Y2ggYnV0IHdlIGRvbid0
IGFjY2VwdCB5b3VyDQo+IHBhdGNoLg0KPiANCj4gWW91IGNhbiBhZGQgdGhpcyB0YWcgaWYgeW91
IHNlZSBzb21lb25lIGxlYXZlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ICJSZXZpZXdlZC1ieTog
Qm8tQ2hlbiBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+IiBhbmQgdGhlbiB5b3UNCj4g
Y2FuDQo+IGFkZCBpdCB0byB5b3VyIHBhdGNoLg0KPiANCj4gUGxlYXNlIHJlbW92ZSB0aGVtLg0K
PiANCj4gUGxlYXNlIHJlYWQgdGhpczoNCj4gDQpIaSBCby1DaGVuLA0KDQpTb3JyeSBmb3IgdGhl
IGxhdGVyIHJlcGx5LCB0aGVyZSBpcyBzb21ldGhpbmcgd3Jvbmcgd2l0aCB0aGUgbWFpbA0Kc3lz
dGVtLg0KUmVnYXJkaW5nIHRoZSAiUmV2aWV3ZC1ieSIgaW4gdGhlIG1lc3NhZ2UsIG15IHByZXZp
b3VzIHVuZGVyc3RhbmRpbmcNCndhcyB3cm9uZy4gSSB1bmRlcnN0YW5kIGlzIHdobyByZXZpZXdl
ZCBpdCBub3QgYWNjZXB0ZWQgaXQuIA0KU29ycnkgZm9yIHRoZSB1bm5lY2Vzc2FyeSBtaXN1bmRl
cnN0YW5kaW5nLCBJIHdpbGwgZGVsZXRlIGl0IGluIHRoZQ0KbmV4dCB2ZXJzaW9uLCB0aGFua3Mu
DQo+IA0KPiANCj4gDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0LjE3L3Byb2Nl
c3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjdXNpbmctcmVwb3J0ZWQtYnktdGVzdGVkLWJ5LXJl
dmlld2VkLWJ5LXN1Z2dlc3RlZC1ieS1hbmQtZml4ZXMNCj4gDQo+IEJScywNCj4gQm8tQ2hlbg0K
