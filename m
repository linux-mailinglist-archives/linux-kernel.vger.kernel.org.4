Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C172755D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjFHDBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFHDBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:01:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F202113;
        Wed,  7 Jun 2023 20:01:38 -0700 (PDT)
X-UUID: c539b41805a811eeb20a276fd37b9834-20230608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ofi/l0w8Q+5hlbGrLm3Xx85J/eFYi/60zNeYrEGJISI=;
        b=tT89yOx6g1lJ/gPZnVHlDVjcS27qTiOpdHcPELEFJzVWuz+mTX6dvaOelJouOkaTinAV0nXp02fGjmtvhbQpUxGQi7DeYAeI0HydOVbgN4fUyI4w8ZKsMy8f9VuHLcmPzC+U1Kra2ymP2h3Hu7jwNMUE8yyEXfeFgNGIFP9B8Pg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:385db9b6-453a-4ae5-b1a4-bb1b914966b3,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:cb9a4e1,CLOUDID:49f2bd3d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c539b41805a811eeb20a276fd37b9834-20230608
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1139106175; Thu, 08 Jun 2023 11:01:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 11:01:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Jun 2023 11:01:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPkvsc0xtgt6PRaX41KRim/nohOgTVLPhcNwhSaykN4jgFYsJ3TfpQmsQygiGkelImlb6Fr/iNK/+Ulhli1EHznwy7/aNf4kZtqWQYZPKQJ7YoSCMIDAgpviYp+WzNSfs1GvXUC3yEfTrHRs0E8AQbH/hzXtrNC+Ne8aEquCiPT7YEO1PYPKjrJd5GvljI7KnmVitxWxzj1Lp4OzryVFpKgiLrkibqTKkwoFEgBMpMikcvHkEWnrvcA09t4LNLnyBwLRw4+FALc4K4KjrbguwOiSGxKeP3gfjFWwm9oLSnOSl20RWotcslKc7bdJODhifqFRWoFudMwM0uHYvXJbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofi/l0w8Q+5hlbGrLm3Xx85J/eFYi/60zNeYrEGJISI=;
 b=kuLtBwJ1yq9CxHfJ2fzNbvzf6t4vWA3/jZyIZ9gp1r1+hKGByjWr4lp9AIcDwePPnTWFAupt67QefwhMuKQRG82PZJwwv7NSf8BS7+eOF9F/X8O1SVWKAmabNwv/FHIDJa8F7tZ1+4YzZ+EQEMC1paZN4US/E13XiPDHgoCkCqhs4osqAH4sKI0B3TfuheTzEy5CZ+gkJL0yC7fjc1qfsv0idiJfKwTvpttgNakpF9HKIRZK+6IcIBF7Iizn3qPCPElVhy3AlPOaEk3lixRI2tWZWHZF0IdZFg2jneyqKEj4EJFdMsBzniZLlYMBGbySxKfv0UwnaXDmE5rG2OpGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofi/l0w8Q+5hlbGrLm3Xx85J/eFYi/60zNeYrEGJISI=;
 b=g/prl0Y/AEsniEnXMtc9GbgvKEuM+KfnDzxQuF0FxWAPi+0/ygV8uB5qNOcongsxu9EKBhEw1hg+YbwPyRhvmFEpeHvwkacSoJW9tg5Je395DNQBLNcEdx1mrLgCyjHvNW3+x1Q1pH0QcDRo34T1eEBwbkPiQ01pw5HXOUNKTp0=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB6304.apcprd03.prod.outlook.com (2603:1096:820:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 03:01:28 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 03:01:28 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "fshao@google.com" <fshao@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits
 for VDOSYS1
Thread-Topic: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control
 bits for VDOSYS1
Thread-Index: AQHZmQccoZ+M6FRhCUuwkVRvA364Ja9+98iAgAFBMoA=
Date:   Thu, 8 Jun 2023 03:01:27 +0000
Message-ID: <a769105743d480c0da846a4c50de43811382626e.camel@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
         <20230607061121.6732-3-shawn.sung@mediatek.com>
         <72b71e37-f9e7-b182-824c-163d920723b8@collabora.com>
In-Reply-To: <72b71e37-f9e7-b182-824c-163d920723b8@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB6304:EE_
x-ms-office365-filtering-correlation-id: 82c64417-75af-410e-df5a-08db67cca739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzelxEdE5MPSvmRA1fISKtQpv8xtqg0x8p8iNZpgQ8tzO2+xVmufYC3SxnK1rXPjxZ9TDNXYEQ4zXbka3ktCsVL/k7dAbhnQxPNWURylk7vA2vfzXuVlGBcEEPXjQ9XHrNnZQc9V07MbM8VcQ3LBOOiEhkYDTqc2ylEevgkohoGVdAFsFVjjTUPTVmanuZokvmOJthejdAJEc0cpWSdM2cidOe19f1BpnDpnEnmaK00vSzMpAgyIGHbq4AhV6ZCwvgKvj8ZiuUDd68h2fBrhvtF/tW2WFwfLTC9EoEU/l7xjvPKmYHphi53BUKXaN4DzzD+1UACMKMljrgCzvZALdazuMrvrXWzq7GV8YvlwQAVtCUx4Q0kSJfuJzIf0wLO5rmLahu1lBwUboSxaPj3C1uFNCdYtZz6U4hnydckum9o4rPdNb97G9+1xCySNcbFdF8kSMdAQJt+HXSneGWU9yCVp4CDT/6jkf+/2y4K0UAhHQ6qt2jQ5mFf5VL14HF2MoTghSo16TeWgd0RtuIYXdW0KHgmfeqSUbYoGL/3ccLS66ESNsr9iZqpEsF9oaTgQED0ZwArCGWEvwNA9t0CDY5EKnTSBwQrvk8ruMNiFPHCtyarVKKKHUO6hrauOhcxV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(86362001)(7416002)(2906002)(54906003)(110136005)(41300700001)(38100700002)(8676002)(8936002)(5660300002)(36756003)(85182001)(122000001)(66446008)(4326008)(76116006)(316002)(64756008)(66476007)(66946007)(66556008)(6486002)(71200400001)(38070700005)(478600001)(186003)(83380400001)(2616005)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2pIZ01KV2JnOEpVd1RSVDJVVkRLNVFaUnc1dlV3Z203S2hPWFBEc3c0dldU?=
 =?utf-8?B?dzk5U2hjNnBFN014WVBpRjRVV3dvWFNTRmkwS21wd1U2TCtGVGRkNnNsNlZo?=
 =?utf-8?B?OXl2Yk5YSWRXRGtRTXNaRHJZT2I2K29YaVlzOTJOVWZyOHlhL3RqWjI3U3B2?=
 =?utf-8?B?LzVVMFBRb2tGUzVaK1o3N2ZCNXg3Y3M0emZqOUZ0cUQva0dUNkJndjRETndu?=
 =?utf-8?B?dTFNTmZyc0xjNDZqRUNPdURxMnR1aDUyVWxzQ0hYdlBLc21Ea1kxRnJidkNV?=
 =?utf-8?B?U1NIY2YzYVZkOFdUNnVlN3RxZUFtT1Z2VXdRbUFiYnZFdXFENEdrbkpnYlJK?=
 =?utf-8?B?YWl1c0wwQTVqNDV2NkVZT2FHZ3FxbUF6dzVhWlJldnc4ejJxTnlKd0E3OVh2?=
 =?utf-8?B?SmhBeFlPWkVJRDIzbS8ybmJiakNlaVc0RXcvNGJzc1NJQmFxSVV3T0dvSkFQ?=
 =?utf-8?B?UG1weHVLakdUa0MxWXlZaTBIUmZWNXo3WEhlQkRMdFZCR0kySTNUTFpGbkpO?=
 =?utf-8?B?ai9mZndBT1I2MFJMRGxKTm1jaXp4SW9pREVMS1JnUmJ1VHdYT21wSmp1QzBs?=
 =?utf-8?B?R1FqMVVsZmhjRW9pZDJ4SkJNc3hBVVBiME1Ta2NPRFVqYk8ydThLRTArOGxM?=
 =?utf-8?B?bnNXYkUzakVoK3NDZXlydzBvSEhJVGhvODFPSmdwZ0VPWlRiQlFhNTNJbFVu?=
 =?utf-8?B?elptZndpbTA4VFdFd3J0UXJzdWdselVNU05MMVQwTlBVRUpvOWhxRkF5U1B4?=
 =?utf-8?B?b1Z6R2VhTFpuaXNyaTdWV3J0NnlEOFZKeW04dnFLczl1UjZoZDBhOC8wdEJq?=
 =?utf-8?B?MEE4Mnh3VTlmNXluelJIejhrN25xbEhITDdwbzRIVFFWaFd0R2VoVUdwdHBQ?=
 =?utf-8?B?VGs4N1BLS0RWTzNnK04weEtBNXA2M3IwQlJ3SUs5QktKWXFwMW8raUZ3QjQ1?=
 =?utf-8?B?SEZwdTlKMGlKZDdOWXp4KzNLTlFhd2R3aEpsMjQxUEFhQjhFbllYNkQzTVpM?=
 =?utf-8?B?TUNqNy95cTlNWUk4clIyMW00b3M4MUFGaVdBZ0dVZWFzZVducFZXM1pOVGlT?=
 =?utf-8?B?WVRLUTV4UDg0WWx4WUNSMlZadm0wOXRaeUw1NFRmTjVZVnVubnZZekozU1Mw?=
 =?utf-8?B?djdtbmJINDMyd2d1dXY2R2I3ZHBlUHFVQWdlVE1LYTl6MTdBVklHOVVTTVp2?=
 =?utf-8?B?SXNiMS82SWUycDF3NVpJTnZmZTB2blRuenVMdDA5MldPNDFhWk5vd1JUUjZ6?=
 =?utf-8?B?emFhMGR2eWZXM2J3NTRlcXpTUDJhUUVWVWFpa0VtaGZSblh2YmU4a25SaVFy?=
 =?utf-8?B?bktKOFFuZHlzT2VuL1lqSFNYck4xZjVkemxRUmkzc1J5Vi81SkpQWk1oTTNU?=
 =?utf-8?B?SERpbWM2ejl2MXBFdytFWGU0VW0xTGwxa3VES0xiUFJ0NHZVYUxJWHI2bVpF?=
 =?utf-8?B?b1M1UFhZRnpvQk5Rb1UyTWgwTmhxek1mOGdKRnNWd1JmaFA4SDFjRFV3K3ZE?=
 =?utf-8?B?RmF0My85OFFNU0dKU2VXUzYwSVNYVGFPa040UG5UNFg4RFJnRDNmNmhIMkUr?=
 =?utf-8?B?cFlCa1pNMWlHZGNtNWFoV1FsdWo0TUhTR0UzZXNFOEY0U3A4cVl5V0RvZzJj?=
 =?utf-8?B?cXJoZVVXK250Vm1YQkRyWGRQSkdDdnRGMmp2Y3BIK2U2QmsxWTBITG9rdUhN?=
 =?utf-8?B?RDZrUVovZVZpMmlBUUQza1puWlFnaUxvcGZtOHRDZFc5U3FacEU2MGRzV0l1?=
 =?utf-8?B?dDBHanZBWDFDN2FKajFVL1U3SldQR0tNcVJXV3FtV2VvQ0VWaEt4UG9za2tw?=
 =?utf-8?B?ZG90djJDZ2krOGl0UUJjOUppQS9jTXY2czBMN0thbjcxTndBQXBqamIwUWxo?=
 =?utf-8?B?NWVtem1Pd0txZldRTmdHeE9vMHpBa1FuZms4QW9Eb1FXelFGYmdvSjNibWRV?=
 =?utf-8?B?UUxLK0ZjYzlCRDFNTHBMbUNUNk9Td1hBYndockl5TnhuU0tMQWgrRy93TEtU?=
 =?utf-8?B?alFYODRHcTVtamNtd0VJekdEaERKbmZrQ0l4ekRBaStnb0V6OVFzRWlydDVm?=
 =?utf-8?B?QVBNdEl6NHROVFd0T0d6L3RraS96a3Q2WTI4d1FSdW5NdEZ2UXM1VVNycFcw?=
 =?utf-8?B?YXk5a21DSzhYOTBvenNpNkcrbC9XLzVQd1BSVXcxWC8ycHB4c1VvYUNoczFk?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C526144443D2D4D97EE97207223B298@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c64417-75af-410e-df5a-08db67cca739
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 03:01:27.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ho66y/z7QwydZj/tj6PBj9ckr2pN2kH2tWuorX2NPDUu4S52LRTJaIF21gJYMrpzmkFqgb5DKMBRhkFEEwl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6304
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KU2hvdWxkIEkgdXNlIGVudW0gaW5zdGVhZCBvZiAjZGVm
aW5lIGlmIHJlc2V0IElEIG11c3Qgc3RhcnRzIGZyb20gMD8NCg0KVGhhbmtzLA0KSHNpYW8gQ2hp
ZW4gU3VuZw0KDQpPbiBXZWQsIDIwMjMtMDYtMDcgYXQgMDk6NTEgKzAyMDAsIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2Ug
ZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUg
dmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIA0KPiBJbCAwNy8wNi8yMyAw
ODoxMSwgSHNpYW8gQ2hpZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IEFkZCByZXNldCBjb250cm9s
IGJpdHMgZm9yICBNVDgxODggVkRPU1lTMS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lh
byBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGlu
Y2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvbXQ4MTg4LXJlc2V0cy5oIHwgMTIgKysrKysrKysrKysr
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L210ODE4OC1yZXNldHMuaA0KPiBiL2lu
Y2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvbXQ4MTg4LXJlc2V0cy5oDQo+ID4gaW5kZXggMzc3Y2Rm
ZGE4MmE5Li40MzlhOWEyNWNhMTkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5n
cy9yZXNldC9tdDgxODgtcmVzZXRzLmgNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jl
c2V0L210ODE4OC1yZXNldHMuaA0KPiA+IEBAIC0zMyw0ICszMywxNiBAQA0KPiA+IA0KPiA+ICAg
I2RlZmluZSBNVDgxODhfVE9QUkdVX1NXX1JTVF9OVU0gICAgICAgICAgICAgICAyNA0KPiA+IA0K
PiA+ICsvKiBWRE9TWVMxICovDQo+ID4gKyNkZWZpbmUgTVQ4MTg4X1ZETzFfUlNUX01FUkdFMF9E
TF9BU1lOQyAgICAgICAgIDkNCj4gDQo+IFNvcnJ5LCBJJ3ZlIGp1c3Qgbm90aWNlZCB0aGF0IHRo
ZXJlJ3Mgbm8gaW5kZXggMCBpbiBwcmV2aW91cw0KPiBkZWZpbml0aW9uczogdGhpcw0KPiBpcyB3
cm9uZywgaXQgbXVzdCBzdGFydCBmcm9tIDAgYW5kIG11c3QgYmUgc2VxdWVudGlhbC4NCj4gDQo+
IA0K
