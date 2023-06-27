Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3873F4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjF0Gw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjF0Gwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:52:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F307B1BEB;
        Mon, 26 Jun 2023 23:52:36 -0700 (PDT)
X-UUID: 2f928f7014b711ee9cb5633481061a41-20230627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CWTs+WwtdfgdCWEVrB1GsNVMxfy3NxiNqtLaDZn/vu4=;
        b=IGNHjTKM+TCeWXyGGqZzkvvxuSyWxp20j5B8hbdEb2KKkvaFMazArFJPzgFvAyO36Fplm+ImejhNACO7WijEB2DaMFfAnbBelGQjNaVYWXGoTlOtNv/o+f/pnnd8xKHerfSunr6ztDa/N3jQzVEBbX0xlFv1pziKz1Y+dSe6xEk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:c686b166-ca2e-4379-a529-e5d09d5fe20d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:c686b166-ca2e-4379-a529-e5d09d5fe20d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:7131850d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230627145232COKG7M81,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: 2f928f7014b711ee9cb5633481061a41-20230627
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1513408051; Tue, 27 Jun 2023 14:52:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 14:52:29 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Jun 2023 14:52:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5746Jg5OocwERx6bLjjUbNGn84/Y2x4iAcBODkCSlNToo7rDs0RXBuH69UaTAJxwN5f/08mnL9guVnGCa9KO4zm3EJxp05aZrR7nFe+jODl8eZNFXaoZbXhvj/SCkqWpxWNStolV+/o/ebyvbwOPZKrfxfjjqkhSkY5DN41j3fCK+V/PaBHk0HnKu7hjvuPhWcblSOgvDHwXCa5Fr+FIMrOVoHIKKvpGiU3R5NvLMVLLy3wokWM3+/rxe5mgWPK2tZPpfNVeFj15vLvyaMtES+g9wt0Qrr17/6JRtfiepV4TQUBB8RsFu7Pmd+vbyoE4nXWCbI+u8JLUJrMvsiESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWTs+WwtdfgdCWEVrB1GsNVMxfy3NxiNqtLaDZn/vu4=;
 b=T2l4STfd5vHvf+BDyjh3ADXiwm/EyEEUkQs2uAeBYRu7NYY3XvDEG09GojjagwVPajQDk8nRVH4IbQ7pPqzK0vpXPGhDXq5XmT9a7gWsnVpNAZInIFT8d2X8U1Dast9m0f1u7nYGOwo/OmRXZGdE4xgLj68sBJJNYgwx/pkbhmhl6DsyPuu1CwANRcosHJJ4dzTxjcKRyBJJZOKG1iXgG/k6owJCrpnBjkhEgzwbSQRIbrQr8cEMzvRBGFVoDNd6aQysPkTfYY8vNuH9IXbIV2zl9osAPdZzPapYLz9BMsCc7WZl9C2NrieM99z7s6SQwEoky3mDTj9CANoHlo2FsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWTs+WwtdfgdCWEVrB1GsNVMxfy3NxiNqtLaDZn/vu4=;
 b=XIFSCXewJVlelFR7hGUiKTstblERQYGyr9kB8KzXMwsTEhCgLumBXPwaYq53WjJLQt/5HAG7HhM4xGiShkYcyZVqRMSoiXW+H9d9A5dTEN959sqlYl5wLKEeL0YeE8bgABhTmexSsfbYXkIPJHjSeAf93tfGiusSHXfFuL1nsb8=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB5294.apcprd03.prod.outlook.com (2603:1096:400:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 06:52:27 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::cfaf:d71b:dabc:6d0d]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::cfaf:d71b:dabc:6d0d%7]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 06:52:26 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: reset: mt8188: Add VDOSYS0 reset
 control bits
Thread-Topic: [PATCH v2 06/15] dt-bindings: reset: mt8188: Add VDOSYS0 reset
 control bits
Thread-Index: AQHZnpJz6hZ5BdsYREW1RdpmVdjT66+WGG2AgAgySwA=
Date:   Tue, 27 Jun 2023 06:52:26 +0000
Message-ID: <8a2ad17dc24cc67572986518e23c7a00c8b263f0.camel@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
         <20230614073125.17958-7-shawn.sung@mediatek.com>
         <168739814113.28500.13763614675316462646.robh@kernel.org>
In-Reply-To: <168739814113.28500.13763614675316462646.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB5294:EE_
x-ms-office365-filtering-correlation-id: 56d43cf3-8c03-4784-7cd0-08db76db1199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGfF9Y1FOa08S3V8nkI1j47q9TJrzvhBz2aMApglyzZdf8/TrmAvy8l6xJFvvA+VXQcvrweFRtHKJmnQts6qJRbNvs55sPx8oReiw1BaLFIz+5CDE+Fsp6q5dxJ8lWmfLDvrieeDT1YEtcHWz0OtXRnZBVMzJSS7gqqfYZyrpe/55GP1OgTSpdW63T4t6pxcU5csFHju6bIYDKeMc6VMYeFOZ+Ye2m3T77JA0LTB2SAcNvm2p22XOJu0KUKOUXQPdktfsC8bBWaI1cpFfCjc7+ULSADuUQTB1Mz4g2xFqQQuFlSMUqO0Zy3hjvj2Bp8XpECvCcItbBDM1w46LEGYz7TDQ8ZjExXFZO85CVK3sZxiUuz9eax5mN0+TJC/cHlr8k1Z+Rk7r6cXw6Wf79JVje8pVGquHUy4Ez56EVQz6733vJ5dkO0EjjQwv2EOfSXXCrhwqoHzZf2JWhs5V5qRDRl4Av+NfsQ4laBJK2jPtXQsNZ6QVwa30QV0k0xEdTnQhH/dHGzBEWfnFFsFNlvG0md8NWvjZUAp1wUdkQxyT12oJjtuZ7FmH4IOTihl091JV6/OfmYoJqEoUm0AhNaTP1dQ+rpL0c/MQkYlNGRelRAMG/R4JXONvul25I9FtNTRvLs/HwCDj4y7SW7OHVGaxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(6512007)(38070700005)(66556008)(66476007)(122000001)(5660300002)(7416002)(86362001)(6916009)(8676002)(8936002)(41300700001)(4326008)(316002)(66946007)(76116006)(64756008)(36756003)(38100700002)(966005)(85182001)(6506007)(4744005)(66446008)(26005)(186003)(2906002)(6486002)(71200400001)(54906003)(2616005)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2VZRWNPTitiUFBHR2ZEVmxkYksrWDExRmdWY3lZYWpQRWpEajE3dWU2bG9B?=
 =?utf-8?B?WjVyd2liTVZqZytIS3JzV3BhUlNVdGV1TkRvaHNHUGFSZjJxQ2VMRXpkRkZM?=
 =?utf-8?B?andVSzVyaHhtWThIeVVuUHI5cTU5VFRVWnpTSUd3SWdqVUh6cUxmK0VXRkd3?=
 =?utf-8?B?QlZ2NExRL3R3WnBwdVF6N1lNMWV1Umk3MktORStKcFRWa3pPK0o5bmtkWkxk?=
 =?utf-8?B?RUViMk1Hbys2LzNscjVmRE90dTlMUEE0V3Y3cGgyeGNvZVJHeUpZZmJTWk96?=
 =?utf-8?B?aWFucWJUZVJtSnZ2OVVKbUZpdmdXR3hIUTNsMjZFNEJYeHRYUHc3RFhiN0t2?=
 =?utf-8?B?dlA5djl0cU1WUWt6SGhxWWNLRy91ckpOenVCbVRwTGpMbUVrMGJJdWxPZ3NW?=
 =?utf-8?B?NUovWlBUUVRSMWhMV0M3bXpvOUFBQ2x3djQzcG5vc25aVGIzZ1hveDVxSmNz?=
 =?utf-8?B?dWRLeVFBNVJUSTcwdnlpanlCQUdEcC9oRG4vbHhtK2ZiVVVRSDlhYXdKU0p6?=
 =?utf-8?B?bnFJUENkQS8zenBVdWhzTndWOHBjSXlNa1d6MXA3Y2U0SGR1NzRkdGpha09U?=
 =?utf-8?B?UmMwV3gvYzJRYUxOMWZpNm1WNWV1RzV2Tk0rSlg1bkFuSFZJTysxUVQzODdU?=
 =?utf-8?B?TGhGU05PMjUrUDNSakhJbmN5K21iRzBodGV5M1VXMSt2bGYzNkxxVlJtMVBS?=
 =?utf-8?B?TmZ0QVhZQ3FVdnd2NENUd0U3U1JlajlacmxOc2Jxa20xdXpTQm1ZMGpkZ0ov?=
 =?utf-8?B?MElFYXc3Vys5OFhsWW9mVkZhYXhhNXRtVk5GT2hnKzkrbm9wSHo1UzJSaldi?=
 =?utf-8?B?dDZnWUZPTWptWXkyZGtpeTA1Wlp6cWFmOVpFUll2K0N5MkxFdk1vc1A0WldD?=
 =?utf-8?B?aEdvaHZqdUpFdW1rT24wZkJ3L3hUS3NKaytNUElnUXltZXp4V0I2WVFSOHB6?=
 =?utf-8?B?RmduV1l1d002b2pMWDlpbzNTVk9UbVVIU2RBMHd2aFhEekRrZDVUNnBxTUZo?=
 =?utf-8?B?bE8wcHhzbFdsMERtaVNOK1lvZS96OXRteUE0U2pMSnZWa1BCM2xFK2ltM2p4?=
 =?utf-8?B?Ri9abVp2SlkxenlEQ2J3enRCSmFpZCtpanVLVGc5dnhkazh2VmMrb0plT2V0?=
 =?utf-8?B?OVdxME1zbGl0cDNqbXRPOHV5ZWl2bUt0dThPVmhlcW5yZE1QUmwwVGNBYzAv?=
 =?utf-8?B?NjFsZHJ2MnFYZmNnNzRadGFiYkNvRW1nNTJwWVZnSzZZTmxjQkpocUNOMHNk?=
 =?utf-8?B?VjlTdlFXR1d6K3lFbzEyK3Y4UmgxVUg2dFJ6azlIZFRKZnhhUFd0d2dRUG1B?=
 =?utf-8?B?VEgvZjluTEZoUDl3K2ZmWUFsR2xjVnZUcHBoK1lCbi9pMVJpWk1qd01XRnVJ?=
 =?utf-8?B?aEpnSlVROHd1dFVRb1dZa2R6MzZERnY4dzdONU9TalJkTlIrMUx4NGFUaHhL?=
 =?utf-8?B?NUNlS1ZHQVdFakJIK2hIZXZLNGRVeGFYQXlPN2VKdGVLZURkZnkrdG9EVndX?=
 =?utf-8?B?a1FSaGdBbVd0OElwWTVRbDBKWUVhS25pRkhuaHU5dEVJbVZOa1ZZY0ZLR285?=
 =?utf-8?B?WWhrUTdIVDhxYllEMDE1SjNJOTVISEZvbFY1eHN6RHAwT0t6cVZZSy9rTkhR?=
 =?utf-8?B?ZXRGS05VL2hUSjI0bWcvajhjaXlDVXhZYTRYL0NpaThuZGtzUGdmWTNkT3pq?=
 =?utf-8?B?RUpmOWFOSkNwMy9HWE4yT0VsTXIvUmdsTk1BVVhwM3JTakhXdEZjbnRaaE43?=
 =?utf-8?B?RXQrK1Zyd0tCV1lYaHR6YWVRRGgxZExzMXI3cHB2cFZzdUV2ZmhLaThEOTk5?=
 =?utf-8?B?WTVNOS8wd2ZsRXB0ckp6V1lvUmEwNE9lRGJHSGFDaXBQcFE4QUt0cE5jaWlU?=
 =?utf-8?B?SktQai9XM1ZIQUs0NUl0VjJoSlVCZnNQR0JCK1J4eng1Rk03OFhFODZNbkhx?=
 =?utf-8?B?cUxLZDg3bGpWQXNIc2FlYjhBM1VCSk1mNHYzV0JDVHJOYlFrOFNCTEttYW45?=
 =?utf-8?B?bnN6bnlSYlQ3QzlMS24yTWQwU29nTEpPL1BHczIvWlArWmlWQTNObHUzaGxm?=
 =?utf-8?B?TC9sdXRyL2JMMFcxczVXOXN4U1I5eFlDaXRkdEdFSnZqem5qSjlYTWhmWWNh?=
 =?utf-8?B?SFBPRURJTUlMK3Q5bTAvWWhFZzFnQnFWd0lkaHozeTNYYnQvOUJabjhFRnpM?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2792DD0043B9AF4EA62DE7FF953EF345@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d43cf3-8c03-4784-7cd0-08db76db1199
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 06:52:26.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZA8U90Br1PgMIVy7rqlBOaReY6uPluDDfxElfoRm97ih4qtAlW4tXnlXK1/gkZvEKAjjSRIpT94IHite4eAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiBXZWQsIDIwMjMtMDYtMjEgYXQgMTk6NDIgLTA2MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiA+ICAgICANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+IHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gIA0KPiA+IE9uIFdlZCwgMTQgSnVu
IDIwMjMgMTU6MzE6MTYgKzA4MDAsIEhzaWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+ID4gPiBBZGQg
TVQ4MTg4IFZET1NZUzAgcmVzZXQgY29udHJvbCBiaXRzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvbXQ4MTg4LXJlc2V0cy5oIHwg
MjANCj4gPiArKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspDQo+ID4gPiANCj4gPg0KPiA+IEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPg0KPiA+DQoNCiANClRoYW5rIHlvdSBmb3IgYWRkaW5nIHRoZSB0YWcsIHNp
bmNlIHRoZSBjb21taXQgeW91IGFja2VkIGhhcyBiZWVuDQptZXJnZWQgdG8gYSBuZXcgb25lLCBj
b3VsZCB5b3UgaGVscCB0byBjaGVjayB0aGUgZm9sbG93aW5nIGxpbmsgYWdhaW4NCnBsZWFzZT8N
Cg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwNjI3MDYzOTQ2LjE0OTM1LTctc2hh
d24uc3VuZ0BtZWRpYXRlay5jb20vDQoNClRoYW5rcywNCkhzaWFvIENoaWVuIFN1bmcNCg==
