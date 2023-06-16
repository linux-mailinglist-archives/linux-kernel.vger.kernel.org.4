Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525C732A13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbjFPIlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjFPIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:40:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D753630EA;
        Fri, 16 Jun 2023 01:40:49 -0700 (PDT)
X-UUID: 6b26218a0c2111eeb20a276fd37b9834-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OC6BUWVU7YmUod7hR2rMEPO/0wxPu9H+UXtJLzf46R4=;
        b=juRdppMiuSexOAIagEtDFAfyYASf94k3YO7lok0p3Ivg12/nFVQ+DhlIIKiKuJT+g/obBX7D/Ow9erHBxIhkPs8Xmj972AitEkpDYKJX7ss0DIsf2bclgzicbN2nXYSDZX7c4DYbYgbyPjtX17rSaJhBXttTxUjF7ivvBZiJ82c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:121856ca-d86f-4fa9-91ad-bdee12d66ea2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:42c0a33e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6b26218a0c2111eeb20a276fd37b9834-20230616
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 816186773; Fri, 16 Jun 2023 16:40:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 16:40:15 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 16:40:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tft41F5Ka+bSwNpVTBUEA0UC4GvTYCZ3rbvBD8tlG+1I/Bz+USCsXXi7YsegMQmetcisSyxfG7MusFfyzLbFl28EUVKuGLCM5IyJ/vPuseOOA3Tf/6BdoIoTlcA6Djcb9rcfuJeSl5YodGGvJA9otHiI1sdT24RyaHhF5rWY4NeobN5xOI5LRRHUHow5Pq+maWbIjIuYsGmRu4RVRJmtHnl0lJQpShE90xUnN4lGP2RdBlu8bJjdiHdWiyc9W5AozRxG/Dek9Y+h9KC4TUjqQln9GjPQUpwuknL7J5wRnTqIB9Q7GeBt+bHXR+WUD7TLG5rWWHJsKU/A1Zf4pedCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC6BUWVU7YmUod7hR2rMEPO/0wxPu9H+UXtJLzf46R4=;
 b=WdVsTqivaKN2/o2e8s/WqXW1TQ/ou/ncjwJUPGDSv40zZf2mbC+FSc7rxpfvKQKhy+NUA2akphCrD4OPr3NH7Xqpn1maEKlUjGXQX0UnX86QQj6YhS0xBZu9b9AHEVFOKa20DcPdJaAYIVhqZZIeA8qiGQXjauANQKTFZtjkxQu85Ge9a6mdfPYLHrQL0ZQWTxqhJCnQf4CqvB01pYY1pVO+Kp/y3YmagC4cvgj8dkW5wnwzu4pRgWyCW/tsTT6YmaJbNeCI8K2t5PBvrY10CGaHQ5ut/A9Ce7C7vCNnFBiM4IJ3NdBeubEito7esDhgbMSJx+VX0OJRd3Y529q5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC6BUWVU7YmUod7hR2rMEPO/0wxPu9H+UXtJLzf46R4=;
 b=MWczyO+OocyUdHPdez9j4Xqv5LUthSwP7w4CKerYZ+rqtmIct24qYu1vw41ChQLTz7vHm6o7V5bDMe3gVZ5EepTTMmPLSJSSBuW+Fshcl5wQMTckGNF9fZ5ApSSbm7PhZ0bu7AOKs1B5GzlwznVWv0ta9hhVjio5My+r32vvDCY=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB5826.apcprd03.prod.outlook.com (2603:1096:400:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 08:40:12 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 08:40:13 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Thread-Topic: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Thread-Index: AQHZnpJ04dr81uVobkOio2R0/Knn6q+LiYOAgAFgZgCAACwlAIAACSEA
Date:   Fri, 16 Jun 2023 08:40:13 +0000
Message-ID: <8153fbe67ccc70ff78390b78124a6983f9e329d8.camel@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
         <20230614073125.17958-4-shawn.sung@mediatek.com>
         <25816ad5-339c-e52f-adbb-686aa7977e9e@linaro.org>
         <61754861be70daa487b98475b246d8fed7e2dbd6.camel@mediatek.com>
         <643e6681-6ba7-e990-3e90-09071db904d2@linaro.org>
In-Reply-To: <643e6681-6ba7-e990-3e90-09071db904d2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB5826:EE_
x-ms-office365-filtering-correlation-id: 63343e01-2438-41a2-933c-08db6e454d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdzsIxpKxv4YyRoxLpXUsXle09IV9bHOPja6EcyjNVGMeE2YuFyPaxf/sRRQMvzxFny1mjZ4wMqdp3Kb/Fm5Ej8l8mzsD3MYN0bl6aemnaixGDkFjdliF7erZ2Mcur+RFQWqW5CvrsyLJzLC1Len25Ah6CUsaNapwLIR6jo/E7+yWPk8a27cA2zEl5v+H2JJGFmKK/5dZ7HEFnfrlEn5C53kd9ontlu/kmPXxTiCEHiztKpT1koSta6vxCaVysMNdS5BIDRamij4O/S6vc9714y6HSgCVtnWiPt5o8kcwI8uVL9UQZYG6bUu8DG9sDODhfphiGkzDC7GWYNH4fiD/2lSJCnhdO/pSpKPLn7XjH7q3lX53I7tDL/wv5W4USlBfC1A2KD0IeTshVHWiasp1y97H+m9ONytSl6LuDIWaZ/GKdX0M6K+/a+QU/jZFr2GDKjyyAaI0d4EmNci3iNoqHLVDi51zAR0rr6XLw1YtiqkvhUzK/cTsEcJVxYXj9SGSC13QprEzToSWjPed8YApdB+TH8e9oC9vrXPT4oAoun16iHbn1jLwQzX5r4XlUnA2upvKl8N44ja/LLf8RA4ZK3HsDYVx3cEvfbw1FWkM1hSRr42Sk198pAQkXKwzGrZ3M5fcn6f4XjqgzM8v61BieVFOiy2qtnE4rzoHgTIvu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(6486002)(5660300002)(76116006)(66556008)(66476007)(66946007)(64756008)(8936002)(66446008)(4326008)(83380400001)(71200400001)(316002)(38070700005)(7416002)(8676002)(41300700001)(85182001)(36756003)(6506007)(6512007)(186003)(26005)(2616005)(38100700002)(2906002)(122000001)(53546011)(478600001)(54906003)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlpEVFArOFAxNVByVDZhYlNvOEZjSnNsK1dMMGh4YUgwZXIvT2QwVkNQbWJ6?=
 =?utf-8?B?VUJ6alFiTHh6L0NibEFLQk43bmgwZVN1U1MrREpNS2dCNndEejFSakdvYzhO?=
 =?utf-8?B?YUZNODROVTZEOHZFMlZ6c3BvVzYxKzcydmIrN2lxd0hTaEU1dk9zNXd6blEz?=
 =?utf-8?B?bnZHQVQ0SU84UUxFRnM3ZDNEY2ptR0JES254czlBL1hUenRhcTE5ek9xU1BU?=
 =?utf-8?B?cnVLVjFIeTdSUXlnTjlwbkR4NGVqc1lYTlJFendrRGVvVTNOS2N4Y2FSNnEr?=
 =?utf-8?B?dmJWRTlBb20wS29oWjN6U2xZbVNBa0lCVXJkV3Y1NWFkWHFkUXNrNlFkVnNo?=
 =?utf-8?B?Y2ZIZy9IdnlmM2ZuaUVRdTg5SWtTY1A4NzBTS2t1Z3lNT0xFRnNTQ3AxbDV6?=
 =?utf-8?B?TXRBbEVITnJzY012OEVua2R1MzNrZy82ekJzbE1tZU1WRXhvUm53dGxrb1Bi?=
 =?utf-8?B?VjVpVEhpVnBCck9UYnFvSUpYbVd2K1MwY0xkSENVdjR6K2VWV05uUzhML0t5?=
 =?utf-8?B?K0R1VjhqbzBwQ2tKRE9NdUswQ1NySFlRVGErMXNZUnQ0T3ZiVDdHTDhWcU9m?=
 =?utf-8?B?T2kyRUVsZmF5d3EwSXpFV3hoOTlDbHUrMFpGcjJpUnkwVXA4NXlmVEJrM05V?=
 =?utf-8?B?Yy8wY1VjZlBYSjgvM2FLUDRyWHZoYnF6bDVWbjBIQXd2RDErNUVLUERyVzFk?=
 =?utf-8?B?VnBIOEQ4aWFSNDFFYnlnUHZ5UEdna0k0aXNqbEIxd1NsOXZhSlpnUEMrNkpR?=
 =?utf-8?B?NllXaUtZU0RPdE8wTjg2ZUkyTnlONXpJSGJxUHZWYk12RGtMRU5UREIvd0dp?=
 =?utf-8?B?bWg3Vk1TK3FGSUhWaHZVRFg4M2I0S3IwS0UrdkE1MDhqcVBVZU1hNjlQVitI?=
 =?utf-8?B?b0k5enZ2SVZjUnhIRStVNkUwTzAzV1VzTHVwaXBmUkhCaU42YjVEWjlBWG9F?=
 =?utf-8?B?OHNaMHlhQkU1d0cza2ZLanhpOVUwSEY1eFdNd3lJR3ZjMFNTU2pLMVpCWktt?=
 =?utf-8?B?bUZqcldpeWdndnVhUHk1OTdGVXJzU2R6QmpKaXFPVzVhU0JacWdDekJIcTd6?=
 =?utf-8?B?bXQ0WmRXQ1hkUEt3V2E2SHpNTEh5RFZZNTFCNGJhdFdKZ294U25wbUFZSlBn?=
 =?utf-8?B?MWxZbnJzaVJCYVJYVnhSNGdTcTJScjFjeHZRWnIwWE10WHUzNFF6LzRocFd1?=
 =?utf-8?B?OThGTWVwT1RLT3lMOVoyZEtzdlpjMlFjUWZSdHpCeSs4UUV2NFI0VzMrazBS?=
 =?utf-8?B?cVRSUXZpekhIRjRsTDdHQ0Y2SWtnMnpVYmdPY2xRSGlBQVJOalJNWkI5WlJI?=
 =?utf-8?B?T0Q5TElFdCtXSDFkaWxpSUJBMkRoekY3eVdQZDhBNGtHWHZnQ3NWRUltOGZ3?=
 =?utf-8?B?N091M0Z4alU3eGhLQ2tVemJIWndxTVBSVnRSL0JMbTV0eXVDVmF5SDJ5S2E2?=
 =?utf-8?B?VVRac3c0alY4c2lRVm04NlpjSlh4M2JORG9BUEhQRUZ4bGRtakErM3RTK21T?=
 =?utf-8?B?VWJhRzlUOHloR29FSVEvLzFiWVlyYjREeHhuWnZLWnEzNWJseCtxNVVZN0to?=
 =?utf-8?B?YnBaajEzV3FOV0ZIS0RRc3JvRms3cTkwMFM4UDhwWklNWmpNazBOY28vbUdu?=
 =?utf-8?B?a1l1Y2ZVOWk4R0hBNXBuRlJubXJJUHFqVXh2K1JhSlNRa2I2Q1VMQ2dPNnpv?=
 =?utf-8?B?ZFhocytvYlI2cEtHbDI3eVRqb0JCT0NGK2xHNS9TQzVJS3lRM1A3bTNjKzV1?=
 =?utf-8?B?THpBdHI3aWVhZzN2U1VYYjc2ZHVuUHRDSUo4cFBta1BXd0NFU0ptQ1hlVkNv?=
 =?utf-8?B?eXluaFJ1T3RLZmZtTDJ4S243dG0zUTNDR0hOcjhzRGRNRVlTNHc4bmxPZnVH?=
 =?utf-8?B?WHhkTGdmMUxibk0xd2FXdytyamtLMytLVE1QbW1nZU1uam1yM3dPbjBLU2Uy?=
 =?utf-8?B?dUJyUFFiWHk3NmNGbnRxL3dtOG9DSlNWUGRHL1VZOE1aVUVUNDhNTjk2cG9V?=
 =?utf-8?B?eGZnQlo1VWswa3lEek5vK0xlYjl4V1oyeUQ0VlZ6K3VjWEYwR3lmMk81c2xJ?=
 =?utf-8?B?QnBTTk1HbitFdjdoSlR0d09wQWpqMnVnMEFRUVM0d3FaT3ZtZU8yVy9qOGVG?=
 =?utf-8?B?OTBwcTUzdGNJaTh2UEV0bTd2eUV4RHpIaVhQcHRoRXh5V3FOamo1SzVqTld2?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFCAE59399D6DD44A08A26E6BC81E1DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63343e01-2438-41a2-933c-08db6e454d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 08:40:13.3841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybYEvpldMqNFmJgEiTMjEa7DpgKgFKOhFb1J8IqIN1IeZUujwFj64m/0dcx5qHmTctKxwHkI8xQkbjhAsHdFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5826
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDEwOjA3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE2LzA2LzIwMjMgMDc6MjksIFNoYXduIFN1bmcgKOWu
i+WtneismSkgd3JvdGU6DQo+ID4gSGkgS3J6eXN6dG9mLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3Ig
dGhlIHJlbWluZGVyLCBiZWNhdXNlIE1UODE4OCBpcyBub3QgcmVsYXRlZCB0byBNVDgxNzMsDQo+
IA0KPiBIb3cgZG9lcyBpdCBtYXR0ZXI/DQoNCkJlY2F1c2UgTVQ4MTg4IE1lcmdlIGlzIGZ1bGx5
IGNvbXBhdGlibGUgd2l0aCBNVDgxOTUsIHdlIGRpZG4ndCBhZGQgaXRzDQpjb21wYXRpYmxlIG5h
bWUgdG8gdGhlIGRyaXZlciwgYnV0IGp1c3QgbGlzdCBpdCBpbiBkdC1iaW5kaW5ncywgYW5kIHVz
ZQ0KTVQ4MTk1J3MgY29tcGF0aWJsZSBuYW1lIHRvIG1hdGNoIHRoZSBJRCBpbiBkZXZpY2UgdGFi
bGUuIEZvciBleGFtcGxlLA0KaW4gbXQ4MTg4LmR0c2k6DQoNCm1lcmdlMTogbWVyZ2VAMWMxMGMw
MDAgew0KICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1kaXNwLW1lcmdlIiwg
Im1lZGlhdGVrLG10ODE5NS0NCmRpc3AtbWVyZ2UiOw0KICAgICAgICAuLi4NCn07DQoNCklmIHdl
IGFkZCBNVDgxODggTWVyZ2UgYXMgYW4gZW51bSB3aXRoIE1UODE3MywgdGhlbiBvdXIgZGV2aWNl
IHRyZWUNCm11c3QgYmUgYXMgYmVsb3csIGFuZCBub3RoaW5nIHdpbGwgbWF0Y2ggaW4gTWVyZ2Ug
ZHJpdmVyLg0KDQptZXJnZTE6IG1lcmdlQDFjMTBjMDAwIHsNCiAgICAgICAgY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODgtZGlzcC0NCm1lcmdlIjsNCiAgICAgICAgLi4uDQp9Ow0KDQo+IA0K
PiA+ICBJ4oCZbGwNCj4gPiBrZWVwIGl0IGFzIGl0IGlzIGZvciBub3csIGhvd2V2ZXIsIEkgZG8g
ZmluZCB0aGF0IE1UODE5NSBkb2VzbuKAmXQNCj4gZXhpc3QNCj4gPiBpbiB0aGlzIGR0LWJpbmRp
bmdzIHdoaWNoIGl0IHNob3VsZCBiZSwgc28gdGhlcmUgbWF5IGJlIGNvbmZsaWN0cw0KPiB3aGVu
DQo+ID4gdGhpcyBzZXJpZXMgaXMgZ29pbmcgdG8gYmUgbWVyZ2VkLg0KPiANCj4gRG9uJ3QgdG9w
IHBvc3QuDQo+IA0KPiBObywgcmViYXNlIG9uIGN1cnJlbnQgbmV4dCBhbmQgaW1wbGVtZW50IG15
IGNvbW1lbnQuDQoNCldpbGwgcmViYXNlIGxpbnV4LW5leHQgaW4gdGhlIG5leHQgdmVyc2lvbi4N
Cg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkJlc3QgcmVnYXJkcywN
CkhzaWFvIENoaWVuIFN1bmcNCg==
