Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A905ED8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiI1JSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiI1JSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:18:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70FC481E9;
        Wed, 28 Sep 2022 02:18:06 -0700 (PDT)
X-UUID: 68a422e9618042808144a61cd774942a-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ysg5u5ae6gFQfzo9PemFo2nhpUjQPyUyXu0+Uml0Wk8=;
        b=c8+OfHiZ/o9U2Wp5rYtkLELY5m4WLP0isgJZGlLKTBW1Kehh28ZFPS0mpYArkzUcX744OV4Az2ezgvY7w+lHI6LUAAfxkH6qQqCLCHNXh8gcNZK+b6GueF+SzxKF4+CmEsTsda7oOrktoYyp1nZ0WToftJTEUTi1/Yzhq2S6ja4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:e1bd4dee-a5db-4b99-a347-ecd8ffad7ffe,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:e1bd4dee-a5db-4b99-a347-ecd8ffad7ffe,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:1f9c5ba3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:220928171803F2LUGT9E,BulkQuantity:0,Recheck:0,SF:38|17|19|823|824|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0
X-UUID: 68a422e9618042808144a61cd774942a-20220928
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1068897010; Wed, 28 Sep 2022 17:18:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 28 Sep 2022 17:18:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Sep 2022 17:18:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCWrysnIE2cMUWtycq6ga52UlFEfZTBVB9Vg1QK3Q1T7gPp1b5Q0+fXs/JRSjgVbH7I5VVjeNzHk/xB7JWVvj6wS8/AFyJtxYarCyLqPdOzT22NbvFTvwkhGCnHNKgMAX1EYo6bXsnknctK/HT0ZxYSvNNsTWYwY1TQrgG1pSKlUmW0w1rZQO5EO02MpFB/jxcWJ3MWoBRYxulacqaoHZkSH5g/KqyQkdfCMbkBHCosL4c+7WCYd8K2BJP+K/7VKTmGRXkff0w4tlYHn11qTYXsGJsyzJtqClof1nX2KsHOHKLeQ+nKfcEkkVcvT6DK6Xk/FFpU139aaRH0NiGFXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysg5u5ae6gFQfzo9PemFo2nhpUjQPyUyXu0+Uml0Wk8=;
 b=AhjKa7gAq8YFi36o6mMODkFPiw7FIL0JcAmHj+/FSWbtjsMvOGVsOsXcNhM3f1BDXQp5OSoinZawt5wwDDTDy6qv+xU5LK7oBp3w+6/zyDrtraWaNP6cyN+YotdI/WgAOyFgCVoatkWmcC40E34IuGx1zXi96QozPcQp42P/rFw64NoS4MpQ8gAJQpKybygPYbYDANkq9Nkp6r4SYmn32c950729xXshLs9goJHwP7A/QRxGCn2qDiNw4r3OgyFR9ERj0W3j9IWN/y/KWjzlQsZzbMJWQXaP43jSdbAFHL1/NxeRhJ/rGEUgh2U+jCIuTjWoHT4ccww6+StrdAoAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysg5u5ae6gFQfzo9PemFo2nhpUjQPyUyXu0+Uml0Wk8=;
 b=Z66F5TA0pUct1TH8nQXgngXy63JB/0THPquxwBtUK7J8bP6172iPN4CgrXK93eOsrHM+cWG2WoAchTXJwWLLClyWMgEGJdNvLxj0QNP5LaCFZgZiMkPynheQvr09HjxburFQQ6VlAszEjWD3+hWnYE3al8bIsiHdSdCyXHxMdec=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TYZPR03MB6424.apcprd03.prod.outlook.com (2603:1096:400:1cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 09:17:57 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382%5]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 09:17:57 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
Thread-Topic: [PATCH v3 02/11] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
Thread-Index: AQHY0hz3qQeMfFUebkO+lkVL6qT3zK30bBcAgAAmEgA=
Date:   Wed, 28 Sep 2022 09:17:57 +0000
Message-ID: <d16002714baf1eccb9b0ef5a2ae60e9b25194701.camel@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
         <20220927025606.26673-3-tinghan.shen@mediatek.com>
         <08abade9-f6f5-77cf-b83d-739b0b81543a@oss.nxp.com>
In-Reply-To: <08abade9-f6f5-77cf-b83d-739b0b81543a@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TYZPR03MB6424:EE_
x-ms-office365-filtering-correlation-id: df450d82-1a27-4a3a-3fd4-08daa1325501
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gEbV6pSEg7FZzZiAFq4M9c1kCDgD5RjyMXPVHt0DmuBkvlkxSuPsy65mpEZdDe+C/aQJIz4lrbQ6kFuIDoPmnpMTr8LJBSh/JMIg57mr91UCcg1kWJcZU9+zrfCFVAIvyJcQWMWbu8LQyfAo3yEuZqbyEdOWUNRdsGSySOt2OCxVyp9Xgz63FwTEhmM+zPgoWf6TiMVSDht/hcPmFtSuoR03eDmFeOrvXTKQn96IvTFqfAkdS2fKMZydX8rQPp4iWadD3yIjxOmidYlnfgUYlsgzLL03+IZ+xrkJgy3zTyajnZixHvSbqtLttKI107BtNwtSgo1SY4UDG5TDOKwJyTj0OW6dP1thSDgs34vhI++une+f3bj2oLyW2wsWA70617yK8xdLVjvRDh+yhzT9bp04jXMlAteI7uviSUv2E2CXREuIhigjLfdQZLjsM6xJ2dBg+pA4Yq9/VEVfTOXAIHVyqREICGwg87UjSf+TeMfsCTpeJseQt2wQfL8qCBry4UKvjid6EDCIt4uTpOnWpFZSbrrJMbjtEmcIe2rV+rO5v6p6mxd5fJx9QGHMeVGN6/HurFjbVCFUttudnYcTyIGQvHcnrWBnIuTdJmuSgpRLdBTLYzyyBfQhloFjp2VODbdXhYJk9Picc24dN5blsOKtD7IHrRdm/PXYKsFfv2NXXjGFlsBeVxYE9GOWMFHhVH9Xir8OwFCG5/RLB64n8J+068YOWknPmK5N2Y2NaljuUf6XlsLOcp5+BxWGdEYZh1dOW4JqTzZnTI9FlkaylxPKGVbPkU2fNUe1De6xJ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(7416002)(4744005)(6506007)(8936002)(6512007)(26005)(36756003)(5660300002)(921005)(38100700002)(41300700001)(71200400001)(83380400001)(2906002)(186003)(38070700005)(53546011)(85182001)(2616005)(122000001)(316002)(6486002)(110136005)(54906003)(8676002)(66476007)(66446008)(66946007)(86362001)(64756008)(76116006)(66556008)(478600001)(4326008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW9xb1Fzc1VQaVN3RVlZQnVKcys1N3NiaHdSQXA3TVlmK1NJczB6QXJUM0Z4?=
 =?utf-8?B?RVlrWFN0c1dzZUFBL2pqbTlYTE9lVmt1azhmRmwxOEFmeCtMeHhlak1XNWJp?=
 =?utf-8?B?RFJEeU5rb2V3UHYyYi85ZnJTVmw2TzNkYVh0RW5TeEJDc05EU2RoWEhZMG9t?=
 =?utf-8?B?ZVpOc0FFQWZmd3dPYm1wOG55VVdrUTRJM2ZJL0o1NmhiUGJRRWFDZ2pEMjVJ?=
 =?utf-8?B?N2thV3c2VjlGQUlPODBJK09IamhDMjRWKytmMnZUVE55bk95aUNvcDlnSUVh?=
 =?utf-8?B?K3FFeE5RUXowZVR2SHU2S0YzcnkzVFp1V3RudnROZHFmeW5PMng4Vll3Ri9D?=
 =?utf-8?B?cm9xbG5JKzhza2JmblM1aXNtZkhUVWZIMGxLcnNaOHJxVjV0cWl2cnV2Yjkx?=
 =?utf-8?B?Lzh0cTlvNU9kL2c2YmxYOGtmYm10WlhhblYxa0lkcFlzT1daTXdwOFQxMHhu?=
 =?utf-8?B?SzErV2pwbFk1QlNJemVPOEhhQldPVFRmSURab0UwQ09ERk0yYnJIVWc0S0ht?=
 =?utf-8?B?a2lIRDczUlJENWV1MzhWWlprclNhbG5ZeEhUQWFCT3Q2SkhDSTRhOWJSRU1y?=
 =?utf-8?B?M0t0dTQ5Q282TU1MOWxNMGtEb0hBeDdFTTA0Y0dOM29mVTZZSWlrVlNpbHNE?=
 =?utf-8?B?bFRTM2JKeUZlU2xUcHJDbCttUjNSeldNZDV3SmV6NlhFZVBvTE1IRFlhWlc4?=
 =?utf-8?B?S2E1a3kvRFE2d2I4c2kwOWVNRlVoNXNQcXdnTHAxT2U4NHp0WUZ3SWlIVFNa?=
 =?utf-8?B?Y0o5NWNka3FLenhBV2k1dkVNbVQvNDF3bWhEelZoYXA3eFVWalNZZ1JLWEtN?=
 =?utf-8?B?NXh4VzdQbUsrdk1Cb3FVUHI3ZkRCZW0za2FBRDRvWUpwdHh2dnVERzZNYlJD?=
 =?utf-8?B?UXh4SnZLMGovUWRSMWZrR05zVXFRYzc0eVUrVnpiaSsyNnJraFpwcG9URC84?=
 =?utf-8?B?Y2dvR2lESzNWcGpkbHQyUHVpSFZHNzFQNGNmYzVmMThnLzNJeWVSK0lmekJD?=
 =?utf-8?B?dklFN0xrWmQzY2pOM3dQWTRzZk9HNmFkRlNhak52eEt0ZUhRNDYvb3dwZHd6?=
 =?utf-8?B?L0RxU1NFbTZhcVM0NkV6czkya0JGb1JseTB3UnhST2hNTWhWVVorMEd4U24r?=
 =?utf-8?B?a2FSSU1ZMGhseTNCcG9IUzEzbW8xU2ZQY3JJQVlwS21DWWxSbmwzR0RyTWNq?=
 =?utf-8?B?ZU50T3FhcEpiRnpOUFQwZjVZVFJwWWd0M1dnWmVYNHFJWnAxVnAyVG5SQXFq?=
 =?utf-8?B?d0ttMkZoekhNQmFLMTYzRU4yMmc1b0NTK2JLNnByYXZ3aHRkK1dTL004SGIr?=
 =?utf-8?B?R0xKZ3YybDE4TEJLTmUrWUZHeXMwRnhCbW9teVVYU1pMeW5udm01ZmRuZ25Y?=
 =?utf-8?B?L2ZudzQzSGo4S3p1REVRZUJMeXVQMEoxS2VBYkhKT0pDYnNqZmlyNmlyWWJC?=
 =?utf-8?B?U3V2S2hwc00yR1BZb3NlaTVtL2x4TWQ5NHBTUk15TkRWWjE1em5laEhKTFk0?=
 =?utf-8?B?b0FSOE9jTGVnODRuZU1FalFSQUEwdTNCcTBzV1d1OHYxUm5DT1NjYUVOcE1M?=
 =?utf-8?B?cDJZV0drenB2dXFBZmVhb05SLzFFSHozNkFJZHRobjExc2lEUmdVMGM4TWU3?=
 =?utf-8?B?WTFtdzd6a3JIZFVPRmtjTnUvY0o1QjA3ZXRyWTh2NDYzSGRQSHhVWUpBYytK?=
 =?utf-8?B?ZmkyaS9wMlREUkNFU2YxM3VvcHpVQVZjQXFpQUFZRGQ1QklFaG9oQW5JZzFK?=
 =?utf-8?B?SkJDRFpTWHdHaHEzTmxRMS9HVVlhSzhFVzBkemdoMTVCczl4eFZnRFZGWW5v?=
 =?utf-8?B?T3hxdTFJYzk5RDFjLzRxMUlkUDMyem9pV0NpSGRwbDVIVFhYa3JEelFXTDZ1?=
 =?utf-8?B?SnZYcTJBNEpuUmpCOURPY2ppck9GWnVXOHVpRVl4UUx0dXZodVRvMTZEbWZt?=
 =?utf-8?B?UDVBTW9JYjFxbjd2aUIzVjhWbnpYRWpBRFdlaVpvaTQrR1c1MGtOS2IwOU92?=
 =?utf-8?B?OTlhMWNQNEhWYXJKQ09LNEdRYTh6bERhMC9IZHRGR3JCU0gwTEY4UjNSRG5Y?=
 =?utf-8?B?S0cyR2Y5R0x0QUZTbU80Q2M0cGpnWFlUaExtYXRIMkp3WStnUUZITzdqMEQv?=
 =?utf-8?B?T3BaRlhEYlBvdStNSkFCSGZTUTBMM1FZS05mekszZlhYRk1YUDRIMTUySm9F?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EA11B10E4354F4BA32C06A1A5D349EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df450d82-1a27-4a3a-3fd4-08daa1325501
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 09:17:57.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qCaOymbyegMTCYJljWUZkyUb4TTnuZtp7Oo6T6ENVytAWC8oAjZPyD9d7OzSXTBKNJ+mDpCdihsttapvn7OsNqcurFBEB6BEv7hPyTq8KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6424
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTI4IGF0IDE1OjAxICswODAwLCBQZW5nIEZhbiB3cm90ZToNCj4gDQo+
IE9uIDkvMjcvMjAyMiAxMDo1NSBBTSwgVGluZ2hhbiBTaGVuIHdyb3RlOg0KPiA+IFRoZSBNVDgx
OTUgU0NQIGlzIGEgZHVhbC1jb3JlIFJJU0MtViBNQ1UuIEV4dGVuZCB0aGUgeWFtbCBmaWxlDQo+
ID4gdG8gZGVzY3JpYmUgdGhlIDJuZCBjb3JlIGFzIGEgc3Vibm9kZSBvZiB0aGUgYm9vdCBjb3Jl
Lg0KPiA+IA0KPiA+IFRoZSBjb25maWd1cmF0aW9uIHJlZ2lzdGVyIGlzIHNoYXJlZCBieSBNVDgx
OTUgU0NQIGNvcmUgMA0KPiA+IGFuZCBjb3JlIDEuIFRoZSBjb3JlIDEgY2FuIHJldHJpZXZlIHRo
ZSBpbmZvcm1hdGlvbiBvZiBjb25maWd1cmF0aW9uDQo+ID4gcmVnaXN0ZXJzIGZyb20gcGFyZW50
IG5vZGUuDQo+IA0KPiBJIHRoaW5rIHRoZSBjb21taXQgbWVzc2FnZSB3b3VsZCBub3QgY29udmlu
Y2UgcGVvcGxlIHlvdSBwdXQNCj4gc2NwIDEgYXMgc3Vibm9kZSBvZiBzY3AgMC4NCj4gDQo+IFJl
Z2FyZHMsDQo+IFBlbmcuDQo+IA0KSGkgUGVuZywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4g
SSBzaG91bGQgZ2l2ZSB0aGUgbW9zdCByZWFzb25hYmxlIGV4cGxhbmF0aW9uDQpmb3Igd2h5IFND
UCAxIGlzIGEgc3Vibm9kZS4NCg0KQWRkaW5nIFNDUCAxIGFzIGEgc3Vibm9kZSBoZWxwcyB0byBh
c3N1cmUgZmluaXNoIHByb2JpbmcgU0NQIDENCmJlZm9yZSBzdGFydGluZyBTQ1AgMCBieSB1c2lu
ZyBvZl9wbGF0Zm9ybV9wb3B1bGF0ZS4gSXQncyBiZWNhdXNlDQp0aGF0IEkgd2FudCB0byBwcm9i
ZSBTQ1AgMSBhcyBhIHJlbW90ZXByb2Mgc3ViZGV2aWNlIG9mIFNDUCAwLg0Kc3VjaCB0aGF0IHdo
ZW4gU0NQIDAgY3Jhc2hlZCwgU0NQIDAgY2FuIHJlYm9vdCBTQ1AgMS4NCg0KUmVnYXJkcywNClRp
bmdIYW4NCg0KDQoNCg0KDQo=
