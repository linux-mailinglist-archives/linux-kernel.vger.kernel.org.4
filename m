Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D87105C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjEYGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjEYGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:46:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F949C;
        Wed, 24 May 2023 23:46:33 -0700 (PDT)
X-UUID: dfe5f06afac711edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gDqdxgsxoWkf7cfiUuB5oh7LbJpwnADEfyVNUdQhXMo=;
        b=T0g45uFhCMaAFgvTw5xAhQUR9pCvsa0/RiVwqIkULr2nzIuTskVLDmAObCtjSdDJh9NAYpdsiOgs9GNe7H3OkZA2WQF+Y5vDvzCLJd7tg0UA2hFzzwoS9OmzG+kKFcQdqGxv9h+CESnTevP9YalhnNMMaoK3aUrWdGz3xzXoAu8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:c0201b84-218b-435e-951e-653bfd6d0b0d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:0afaf46c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: dfe5f06afac711edb20a276fd37b9834-20230525
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1701472325; Thu, 25 May 2023 14:46:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 14:46:27 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 14:46:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoLgxntH0dpEK1wC4+kjPnLNDl72MWucCcn4N9lBixAYg3G7/xp9KBltesFS1VL4zexpzf6QMcGhyjNy0zGszTx4nAuBzhrM6u5NSXrqO4ttni0F5+0NzP6cHDC4GqTtH1LTx5uUgHNDO6UG0m4p5YfxYSZ92FNX7QnsxxuiVshFeaGXwucBdGPS7nVXutW3932VspA5kApX/vkJZivZszKnPMMjW+HJ4EmALtmfaU8XNm4+uEH2lfac89UClf/7wLQv4xBi3w2jaPziEg8y9qE84ZnJKjAaM4OzE3W4lKvAyK2geK9auD8dIDFx4IjLWSfuWMKh0DtVP7kr5UhHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDqdxgsxoWkf7cfiUuB5oh7LbJpwnADEfyVNUdQhXMo=;
 b=UfGwR9njIBvHI2kKSmEPjcIunNOlDHjn5cvacz3/lYpQ8UlDJ+FMJPZsfxcoYdqE3eAmmZI3/koINJRNEDyq3fei8wO5rJ4uUd0X0uC1XtYATFfO8a8UYUMu0SFpB5dUtv314dFyy8gRDPrGbt2cy5eIKPMFwuJz6cfdgn2PmG8M9T671EhRlCIIJJ63NOYThPMMxnfHOT2ZUOua+pREIyoNRjEN8OYKaAZtgs/wWaESx6+Zu1goiKSjSA8wb39MprAynBJuFEyQoH8TNy0/u58yb2Lr7ldFVPjWRSiUfZR2qS2RrFZg8SYvnyvrw/hEd9NQ2V7jwusy7TiRA/jOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDqdxgsxoWkf7cfiUuB5oh7LbJpwnADEfyVNUdQhXMo=;
 b=C0flKCLLI8CgPkg8DgVLSomsQg+j+M3t0gJPPlMmVKYBeaFAFuu2fh/cvcm+01LKRFwQJ0Dv4aIgrvlc/WgJlvZU2ze3SpR59ECh2Qyu9XG23DyvnV6g2ZaOfjFymO37LtLnxeNAfstJWHM0UnnYed0J2tIIhVBCL/h9MKDcO0M=
Received: from SG2PR03MB6478.apcprd03.prod.outlook.com (2603:1096:4:1c5::14)
 by TYZPR03MB7155.apcprd03.prod.outlook.com (2603:1096:400:33e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 06:46:25 +0000
Received: from SG2PR03MB6478.apcprd03.prod.outlook.com
 ([fe80::d089:e748:fc01:8eb7]) by SG2PR03MB6478.apcprd03.prod.outlook.com
 ([fe80::d089:e748:fc01:8eb7%6]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 06:46:25 +0000
From:   =?utf-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clk: mediatek: reset: add infra_ao reset support
 for MT8188
Thread-Topic: [PATCH v2 2/2] clk: mediatek: reset: add infra_ao reset support
 for MT8188
Thread-Index: AQHZf1N7kyHhwXyKWkaCbmHvB/nzt69UC9UAgBaewAA=
Date:   Thu, 25 May 2023 06:46:25 +0000
Message-ID: <99f2b9a431d0f22f9144dad4732056f311d19f61.camel@mediatek.com>
References: <20230505131308.27190-1-runyang.chen@mediatek.com>
         <20230505131308.27190-3-runyang.chen@mediatek.com>
         <ca1e1df877652808ef76851d7f2ed781.sboyd@kernel.org>
In-Reply-To: <ca1e1df877652808ef76851d7f2ed781.sboyd@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6478:EE_|TYZPR03MB7155:EE_
x-ms-office365-filtering-correlation-id: b14cf9db-ff14-4117-afcd-08db5cebc27d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DB4OzOAABQGI+WjRXR5jD1EUmKcIgWrCSR29xOwI59kA4DA8lFw8I2LrYI7p8/6zSlFv2fafpqcPKYqCxFQTPXS+V7jpEG0SY1Ppr+7R1vEQKVvfjfD593hKKT0n65c75uiqB4kjg8we0AgU4CwaNjc3zWNeVOS28l+wy9va8bSVrxarJWi24A1sXxAu27rFlzh18SQ0kUvW5p5A4eQ24vCfCp3GcAU+2ewn4bQ5VOnbFUVaoOEPO6jnt8RVfa67btG/DlNj02xoplURpMsDKloCMeBl7V4kkDz/L7VEX12S54Ta3PdMoRxWSTLHuWLTU/d9QCq07BPv9St6nIMAM/suHEq5CqRSFLqx8VAoroY7DYs3qxqTVoJ1GtDkLNMrGJqyJp4BVk18fymQxovWi5hSCEJqw53TZwKhmh8Fjzy2NffMjtNK5bLk9eQvIcRY9/Y+B42sYTOBWc81wX1B1nJOTttATOhu4M1adQzmkkK0VK6xc2n83qeQe3X8Ixsl4be8tpDZ65JgvEbboO6AVhd6UL2EvOKfQF5d/eZxdHH6x/tYkW333oVfijQpybZ2Fmo784Q8CHQCffGRbLaHdPtwMaMYFnFWebfZtKAOiy62BPYMyWrH+7Xg5wnzgo1JMFnjfnlQg3gGShLaY+JNhGam3I3CkDMXDZWXBq+BbUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6478.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(2906002)(186003)(86362001)(2616005)(83380400001)(38100700002)(122000001)(7416002)(5660300002)(38070700005)(8676002)(316002)(36756003)(8936002)(41300700001)(110136005)(26005)(6512007)(6486002)(6506007)(71200400001)(64756008)(478600001)(66556008)(66476007)(54906003)(76116006)(66946007)(4326008)(66446008)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3V6UUpQZ3QzWkpzajVuRVZrWXlzSElReVB1cUxVTmV2MjVzNWpsb1lJS1BU?=
 =?utf-8?B?RDVvdERmS2dNQ1pFdE9MU3kxbi80VXprWTVldk1DY1lGL2tPOVlBUmxvSEVv?=
 =?utf-8?B?VmpwdjZRcUlibDhleHN5cWUyM205b3NpcER3MGo5aGNGYitWNEQvMWk5ODdH?=
 =?utf-8?B?ZUV1T2R1SWEvaUYwUU1jSk8wWlNHMkxEam82ZzRXaldmV3pPenpVZUZJeDcy?=
 =?utf-8?B?TDRtYUJXN2dZdlFtZ3NyMkRZczZjclU3Z1VtNm1ocUFxMzJCQzVlbG1FM1B3?=
 =?utf-8?B?bkFkOFVmMGhaYXBRdTcrdFJQOFREK0Q4cEhuOVliQ2Jnc25UYXIrT2dvZ0Ey?=
 =?utf-8?B?bnVzNDlCS1VCcXlGVnZNZEwxa3hSSGlCY3h0WGtHaFQwb2JsWVY3VGtSU0E3?=
 =?utf-8?B?Ump5Tmh6VE1tTUlVMGVEMGpCc0VBV2EyR1F5RnJIK2xVTTVIZlcyUGFVZmho?=
 =?utf-8?B?NlBzcjBPcG50WWlJMCsweGVSdE41Mm1IYTk2TTVHckhDUld2U3QreVJnRGZJ?=
 =?utf-8?B?bVFOT3EzYjRROTYrRE84M0ptTzhDVGd4YmZzTnczTGdTQ0NEWjJ4aWlDbkVK?=
 =?utf-8?B?K0R3akZuZzhMRytEWGdlOVl3aEZId3o0ZThPa2xlM0x3VzhoRnloNHFNUlpM?=
 =?utf-8?B?cE5nUjVUbmNLaWkzSEFzYy84aGVkQ2EzT0JnNVJYNnJGQlhXSVV3ZjhQZWp2?=
 =?utf-8?B?ZW5TQ0U2WEpSSjNRTUthejBwUHhwdUpja204T3lHMUMzSEFERy9EcStReFgw?=
 =?utf-8?B?NFprUTJ4RHBGbC9iaWZFV1AyanlsaHo2Vk82bmMzdG9rUHlXUko4V2NDTXQ4?=
 =?utf-8?B?ZlUxQXFtM2sxRW9qdHVjbjBqYUlJMXFVMVZQdEhPaUJnMmlLZmU1MTdDUExS?=
 =?utf-8?B?RjNLbUFMZTErTktlTEpnOTdzUUszWVdFQ3pkb1QxdjQ3T0s2M3JSeTZjQ2Zu?=
 =?utf-8?B?WXB4cmJSVWZJb2FMS2RzSERKN2tMZlpyS2hXd2tMZ3RPVWl6VERMWXIxVVBL?=
 =?utf-8?B?cy8ycy9ZVlM1ZGRZWmI5a3Yxb3NFaU5NL3NnZmJMQkdFYzYwdFpZVVdkZm1j?=
 =?utf-8?B?cWpwa0NUZ2gyeUNIYWlaWm91VmtMQmJPNFZrb0xPNVA5Qjl2b1NkQ3RBNmp0?=
 =?utf-8?B?Tmo0VVYxV1hqb3U5S0R1QTluT0crMnZUaDRWemRUTjJZZjJQeS9kQ3kzSEtG?=
 =?utf-8?B?M1ltZmlvODYwNEdLcElkdDhNU0pOTi9HOGN2bks4SHV0NUl2ZjVFa1ZobnBh?=
 =?utf-8?B?WFFQWHVZTldhWm5WVDRzUWJ6amRab0ZhMnFwdEVSc3p0eGJibEc4ZEcrcEZm?=
 =?utf-8?B?dGJuQWdhRFFrcXRndVl2a1NjMEJ0RFYyejduMm9RYjltUVg5bW5TaTdxU0xy?=
 =?utf-8?B?M2FNbyt4bjVPUkFWd3JOQzZMZ0EzZWRSU21tL0pWdGhOT0YwNlpXY2hTQlhP?=
 =?utf-8?B?QkgzSllVM242ZFB2eENnZVEzT0N0MlhXRWFuK2FueDJPTXNmQXRHL1ZGeHBC?=
 =?utf-8?B?TithTjNIZjRLdXRLSW96VEtOSlM2MWZ3UkpWazhRWnpOZ2hKajBoWEtheUZN?=
 =?utf-8?B?TlFhQ3RJUHFHeUpqNitDMmhzZjE4SFNYZXppd2dLb3ZkTW12bnlHUWJMTS8r?=
 =?utf-8?B?RnJ6c2o4OGxTK3AwRzhNYnNaUDBzdi9zUFN3M1B0T2NzRHBiRlVLY2hIZXdR?=
 =?utf-8?B?b1V5bXVNalNUVTR0bjBRbWgveExkM2haQ1pxUU0yamN6aHJEOEllYlVFZTJN?=
 =?utf-8?B?Z0FOVlAyK3FuTmhaRUE4V2JUalVMK1p6YjNTZ1RCUW42c21SSVNQYXJ1V21E?=
 =?utf-8?B?c28xRlloSWhEckExaU52WUNheUtvWGh2TC9pdC9jajNDVEpWRlZDWURPN28r?=
 =?utf-8?B?K2tJU1VqMC9BZUZJS3NaaS9sRk9lQWlJaU5JYVFjUjFHRjB3Z3JLRDc1T1p3?=
 =?utf-8?B?WWVqYkxlMks1ak9mUW5WdFpVTU5mZUNJaEx0dDk4YTVxRzNKQUFpMkFQSHky?=
 =?utf-8?B?bTR4MlE3em94Nnh4dHRxb2tVSnhjY0NFQ3FqL2pjRHQ0R2NjL0VRUU9sS1A4?=
 =?utf-8?B?bGxVZWRlczhDbDZCQ3pJdkI2VlBzamxoUU9oTUdRUnZSMHI4U2F4ZlArYW53?=
 =?utf-8?B?bFBiSUticGluMUZ5aERvZWtPYVFXdkh3Z1d5aHpNR1Vkams2b0NBa1BNQ2pF?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A6962F10732CD468710F64049C97F10@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6478.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14cf9db-ff14-4117-afcd-08db5cebc27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 06:46:25.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /73xvSXJUj0BqViQS512yRkIgK5FvcfZu5IZi9k9QjzeLuaObln+61rQSE63B92n7ZtBsgkgrHZhtEazkye2O+T0IZ7cvywUmZZM4RnHqXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTEwIGF0IDE0OjIwIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gUXVvdGluZyBSdW55YW5nIENoZW4gKDIwMjMtMDUtMDUgMDY6MTM6MDgp
DQo+ID4gQEAgLTE3Niw5ICsxNzcsMzIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBp
bmZyYV9hb19jbGtzW10gPQ0KPiA+IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICJpbmZy
YV9hb19hZXNfbXNkY2ZkZV8wcCIsDQo+ID4gInRvcF9hZXNfbXNkY2ZkZSIsIDE4KSwNCj4gPiAg
fTsNCj4gPiANCj4gPiArc3RhdGljIHUxNiBpbmZyYV9hb19yc3Rfb2ZzW10gPSB7DQo+IA0KPiBj
b25zdD8NCg0KVGhlIGluZnJhX2FvX3JzdF9vZnMgYW5kIGluZnJhX2FvX2lkeF9tYXAgd2lsbCBi
ZSBtb2RpZmllZCBieSB0aGUgcmVzZXQNCmNvbnRyb2xsZXIgZHJpdmVyLCBzbyBpdCBjb3VsZCBu
b3QgYmUgY29uc3RpZmllZC4gQW5kIHByZXZpb3VzIGNvZGUgZGlkDQpub3Qgc2V0IGl0IGFzIGNv
bnN0Lg0KPiANCj4gPiArICAgICAgIElORlJBX1JTVDBfU0VUX09GRlNFVCwNCj4gPiArICAgICAg
IElORlJBX1JTVDFfU0VUX09GRlNFVCwNCj4gPiArICAgICAgIElORlJBX1JTVDJfU0VUX09GRlNF
VCwNCj4gPiArICAgICAgIElORlJBX1JTVDNfU0VUX09GRlNFVCwNCj4gPiArICAgICAgIElORlJB
X1JTVDRfU0VUX09GRlNFVCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyB1MTYgaW5mcmFf
YW9faWR4X21hcFtdID0gew0KPiANCj4gY29uc3Q/DQo+IA0KPiA+ICsgICAgICAgW01UODE4OF9J
TkZSQV9SU1QxX1RIRVJNQUxfTUNVX1JTVF0gPSAxICogUlNUX05SX1BFUl9CQU5LICsNCj4gPiAy
LA0KPiA+ICsgICAgICAgW01UODE4OF9JTkZSQV9SU1QxX1RIRVJNQUxfQ1RSTF9SU1RdID0gMSAq
IFJTVF9OUl9QRVJfQkFOSw0KPiA+ICsgNCwNCj4gPiArICAgICAgIFtNVDgxODhfSU5GUkFfUlNU
M19QVFBfQ1RSTF9SU1RdID0gMyAqIFJTVF9OUl9QRVJfQkFOSyArIDUsDQo+ID4gK307DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3RydWN0IG10a19jbGtfcnN0X2Rlc2MgaW5mcmFfYW9fcnN0X2Rlc2Mg
PSB7DQoNCmluZnJhX2FvX3JzdF9kZXNjIHdpbGwgYmUgY29uc3RpZmllZCBhdCBWNC4NCg0KPiA+
ICsgICAgICAgLnZlcnNpb24gPSBNVEtfUlNUX1NFVF9DTFIsDQo+ID4gKyAgICAgICAucnN0X2Jh
bmtfb2ZzID0gaW5mcmFfYW9fcnN0X29mcywNCj4gPiArICAgICAgIC5yc3RfYmFua19uciA9IEFS
UkFZX1NJWkUoaW5mcmFfYW9fcnN0X29mcyksDQo+ID4gKyAgICAgICAucnN0X2lkeF9tYXAgPSBp
bmZyYV9hb19pZHhfbWFwLA0KPiA+ICsgICAgICAgLnJzdF9pZHhfbWFwX25yID0gQVJSQVlfU0la
RShpbmZyYV9hb19pZHhfbWFwKSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2Nsa19kZXNjIGluZnJhX2FvX2Rlc2MgPSB7DQo+ID4gICAgICAgICAuY2xrcyA9
IGluZnJhX2FvX2Nsa3MsDQo+ID4gICAgICAgICAubnVtX2Nsa3MgPSBBUlJBWV9TSVpFKGluZnJh
X2FvX2Nsa3MpLA0KPiA+ICsgICAgICAgLnJzdF9kZXNjID0gJmluZnJhX2FvX3JzdF9kZXNjLA0K
PiA+ICB9Ow0K
