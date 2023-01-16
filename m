Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57766B9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjAPJKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjAPJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:10:16 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA761555E;
        Mon, 16 Jan 2023 01:08:41 -0800 (PST)
X-UUID: 5b85cd86957d11ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PMk1hiQpcwT8Mfpf4F3dTig6LcaugHlzNzjQJOGSgmE=;
        b=A09rVLPTtQQigN4JelyNftS5E29jfOyduiXmoPf7abIOuKU+4XuRlLIRkVsXm2X1CmBu6SPmNPlK2WAfTZf0co5w4W10ysg9hx/Xs6dR4p3X77VmKoS0oXDEt/uXmVPHdj7kvfy6osPNbIJSoUPS8tWk6tcCcReerG+PzUOHl9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:70b960da-cc51-47d8-b52a-898822f9e8e1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:70b960da-cc51-47d8-b52a-898822f9e8e1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:0aedc554-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2301131958164SMLHR2I,BulkQuantity:20,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:1,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 5b85cd86957d11ed945fc101203acc17-20230116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1924200616; Mon, 16 Jan 2023 17:08:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 16 Jan 2023 17:08:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 17:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPUZXVc3TenRzgRtT8oMWv8Avdo5Aaa9THjB4sEQoO6xUErzZnsLhrS3+KHCjRVqbbcmXTdZSJqMNJL3DW2mt7foCwN0lm58s+ZHO0VI95xcKFcgWQqZkthzNpyp6VtLdFO/zXpfK1NmpdNvcewbSfgW+33nO9WBrKqdFvKApCO1zMTAYCTOhURR9gtOHyhrkHYTfOkDvkHRMykUaWwrau7odQwHNdV2kjvJKE9hdCsBHAv9tRmruRhtJPmhZGW2pusbJLkITdCrPMuavYuQRFkq1wKLbfFEf2oOXspiyt/IXIzedeGiT/Pic7vA3ThtFPnQvHL36qbu94vpHfhv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMk1hiQpcwT8Mfpf4F3dTig6LcaugHlzNzjQJOGSgmE=;
 b=Bg4sQf8HWP12vimtUBBJnsjPf3VgVQA2zOlmFMYc92K608/5lw4FoB2lWALEUMBPuNeGFO0cWUNSt+m6obeteU3F5jZcVM+hjCe8fHIvJwlAp9rTiX2C+kgmLbWqJRMknLm8+0L6ATbgcAecyEnOd1XN+Pab+fTAmy0KCJG0/cxA4kFxEFWIIfTC1aKADDfFD6grFoMN5/8bDSYck6zZkcJPFUyYo6v1jPaFq8v3Sx+JqbU5Wwk3wa1Xw0ixwNKaJARHVvScOk76oYna8fr+MWKBsr8tfrXDJyvt9yenre/3LIhaJ+XKogxnmQGbw4NJ7rs6R0CXaOyLmoNDNCwnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMk1hiQpcwT8Mfpf4F3dTig6LcaugHlzNzjQJOGSgmE=;
 b=rcQSVE6sXcpdCktc1Mxi5wqk7u3gjpPbOoSDvWdmjCNPpILuVpOoG4yqzimHtwzrm4D8+ZITbWDpB4p3ENnPxtH0g0jOUkh/2aMqlWKbegT2JLVnaY5jFEhHkM5QmwfHxTqbVZP2Gj6UN3r7egA0OzzotR1cImnWtT1D4bEmiOo=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by KL1PR03MB6086.apcprd03.prod.outlook.com (2603:1096:820:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 09:08:32 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 09:08:32 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Thread-Topic: [PATCH v5 01/10] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Thread-Index: AQHZJxILUyhKsU0HSEOH8wZhL0XGK66cPnYAgAQbzwCAAFjnAIAAEuSA
Date:   Mon, 16 Jan 2023 09:08:31 +0000
Message-ID: <de1f1e594477e72e308f8f6f4392ef16b2d59cc9.camel@mediatek.com>
References: <20230113054304.21841-1-moudy.ho@mediatek.com>
         <20230113054304.21841-2-moudy.ho@mediatek.com>
         <329aed63-4522-9859-4359-2a450c46dcc0@linaro.org>
         <fa386a3ab2f2ed0c963d5fdec8bbea56ba276169.camel@mediatek.com>
         <ce4d2d3b-a826-ac59-e077-2fa452d115a3@linaro.org>
In-Reply-To: <ce4d2d3b-a826-ac59-e077-2fa452d115a3@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|KL1PR03MB6086:EE_
x-ms-office365-filtering-correlation-id: be334cf7-3ff9-4d9c-bb6f-08daf7a13d8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9As3hiNpj2EGyWdjxwpe/5NKYO330H7GQeVYhWwwulFOqX5a54Lsd87cY8Ct/okMBE2tN20dYbHjJt0QpP7G/I+QGmY/qX+VY7EEts12eDxCsdWigrRzItIHwbx5S+P/P3xP8HOCT/QuajOJfC1AD/lEO+ikcC0dz0HmAxUZabv7iJ/hWej+Q74tzvkVylAWNxn0YCXVwvLz0A18s3M7nJv+jT+tL8N/SfVsf3cCKPikims0IBdjZQ+RLTGwBu+Rp+TBFMGxpRil2hoTLce+VK71OsujxFn6OsomYGHUs6OVab9o78q6zRz9TPBr4Y8v22OYrHtXwclgm1uPatVC6WlFEcO1XXrwUKdcEMOZXCyLAl/4zjxZNycqeAivVATVk+yamVqVRWh+Efb/vyUnSKDAipcvWt/nIZT1jWOJo8FXu1vlHFtiDLtRpjwh7IEpodXopFDXUxYbutMd89VlFmPkzI0Syl9S1KLzsUv4HmSIOrV0iWrRJZxFxweuIUIjDFh54Bd4ZtVz8HDHHwxueVKxwwjRmf7IU9IUdfee++cYjOyuiSahYbCpFE0jEr57lU5yeDioM4R7y8eQ1QGGfdu3QYqpf91TzlFXI35hDSd0yMlU70kbkn87hjjCizYvd6wFQFLqbm78jp9yltvnh15lWu0Jn0iKVQ7eFm/XhqytMKSHZhUggwJe+WI5cOauNme8PT7rkWKpT+A31U33LzdiOSAtdN6GPOkW8j/2hDtvu+v5QohPCX83N9qOaTC4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(8936002)(76116006)(91956017)(86362001)(66446008)(64756008)(66476007)(66946007)(83380400001)(8676002)(4326008)(966005)(38070700005)(122000001)(38100700002)(36756003)(85182001)(5660300002)(478600001)(6486002)(66556008)(110136005)(7416002)(107886003)(41300700001)(2906002)(54906003)(6512007)(6506007)(53546011)(26005)(186003)(71200400001)(316002)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2ZJUHFhU1Iwa1ZxaFQxWWw3L1FIWEJUajZpY0tiYjBRV0pycExLa2hMeTZw?=
 =?utf-8?B?cG5lY3BQNDFRUlZ2L1FCS1BHRW9RMEUvWUYxUE5WelUyTnlxS2xkbEVtdHVK?=
 =?utf-8?B?RkhvOTZkV1hLK1FHRDVHb3luNTlaTTFtdTZrRXFzc29OeE9NWjNVT3ZTd2h2?=
 =?utf-8?B?RlZBaDM1ay9WTXltMXhBdDBYQmRHSmxQZ0UyYUVUOTJpb0I4Z3dvYjduWjVs?=
 =?utf-8?B?Tzh1V2RMWG9idU1uM2gwdmRCSlB2bWNjc1hXdy9VQktYUzRxbWhHY1ZNc3pF?=
 =?utf-8?B?a29CMFcrU1o4SVM5em42d3JwZjY0VWYzTTZ5SkJpUWI4SU5jSnYyRmhHK2ox?=
 =?utf-8?B?TFJrSFJqU3FuclQ0cVNoUXdpRU9ZUUhkcDNna2NwejI0Ly9JNC8xYzNlZlYw?=
 =?utf-8?B?R0VCTlZ2WDA3UWlsbG5DRFRHNHNxOUo5YVV4UGswdnN4R05TaWRQQm1pNGY4?=
 =?utf-8?B?eGw1MXBnbktGMVRDNENORmxwazlyekNKL2I3aWlJRDZtRVlMcUJ2dHFzVVBn?=
 =?utf-8?B?Wkk3YkQ1TkpnMytBbW9RN1VkMzVkK2tUR2ozU0Z4R2ZKSEdTQ0JrUmVTYS8z?=
 =?utf-8?B?Q0hCZmQ5Nk5CckpicURoQ3ZVcHR5enJFTG9YT25kQlpUbkVwbndLc0JWTll1?=
 =?utf-8?B?WGRXdEhtWW0xUjNJMFNBcC9qYXpPUGl5S1d6Q2FLTmJZRDdxdWpER01HOUQ2?=
 =?utf-8?B?ajFNTUhyNk9INExrb2tja2RzMUxnVm9VK0JCMzU3TlBaR2tjSUJjYWNTUFVZ?=
 =?utf-8?B?djc4NFhjNWdpQm5mNG02RDljNCtsQ0ZwK1FRbkdQaVVKSUkvN21XdkNYQys1?=
 =?utf-8?B?dGY2d0NOS1pJSzdZU01OOVM2YzY5S01EQXdCQVhsV1JkSUR3RTczVmoyYXNE?=
 =?utf-8?B?RW1zcGxjZ0lqNXo4UVNFdE5VcFg4MFIreElkeUdXTmN5ZHp2dVhaUzZLOEJC?=
 =?utf-8?B?SWRwZk5oL2lvNDhyNlR4ZWVYT3Z6V05ZUGkyU1dic1psN2RBdUkxRk45ZWlx?=
 =?utf-8?B?TksyYi9velRRYjU4bk90QXFoTzVFN1lJc3U1RzA4R1FMS3JKVEM0WmZMYVNq?=
 =?utf-8?B?aGRSdEZsdkdubUI5NGI2U3N6UDY0ZUkyL0ZXOTdSZkU4YmtHS0lIKzhweTE5?=
 =?utf-8?B?eGQ4VFJTekkxZlhJV3RTRkoxQ3YwcFkwZEN6L0RJM0RnTVVyZXBqR1RLM3oy?=
 =?utf-8?B?N0pEUnZGd3NXQUpIcnFsTWNqUUZEMXpmYWl4RlRITExlRk5sMWpORzAya2Ev?=
 =?utf-8?B?akpHZ3pRaXQ5WEptaFB1b2dCVW1udStLR1dHOXByYWNSQU5wV0U3clNYZ0hp?=
 =?utf-8?B?Y1hnL2M5M2RoRHN3OEo4OW1wL2JreFd5dnQ0RUlWSWRnK1lNaVNwblhHc2Fp?=
 =?utf-8?B?N1VVcGxLMzR1ZEFhOUlHbUtLSXVleG43WjA4VThhTlJPdGNGdzUvMlpIazRC?=
 =?utf-8?B?S1ZwM3ZMQWcwS2JicmJsb3htMjdhVUhUMnZ3WS9xcTI1ZlV4SjIvZ2Z4NkZn?=
 =?utf-8?B?VVBPRWR1VFZVbkpIQkhORjhtTlk4RlMxdE1SN0xZQVZxbiswOXVnT01sUEFM?=
 =?utf-8?B?Qk80QlA0SnVmV1Y5bWpYSFdrUENjZHpZbDRrQUY2bDNIT2RLNXo3UUlWaUdU?=
 =?utf-8?B?TlRGQWRuTlAwQnNBTEYzSjFVQWUzM0dzTWw4d3VtTUF0bUhpTC9SVU15bDNB?=
 =?utf-8?B?TUpMa0xHTksyTmR3ZDFsZ20vLzhrd0trUmdWTjhaREdtL05oTDdrWDVmSHB3?=
 =?utf-8?B?LzBnT1RLaVY5WDRpQjlCbjRTVnFyMURUeTkwRy9KcFdwZGNNNi9LUlFROVZ0?=
 =?utf-8?B?L0FIRTFYSWVVbXY4YzBQdm5EdG0wa3hFMzNnVnZnR1R3dDVWc3lVV280enNh?=
 =?utf-8?B?V1B5cld0dm4yWEtTdjg1bjc4T1hGYmVZTjJGMFZEbDZNamsrQ1BpTU5XM2tx?=
 =?utf-8?B?a0l6OGpuOTJvakNRNGx5WjVUNkpwZXJYT1N1U1c2dnBNeDZ5WTlJUXprc0xw?=
 =?utf-8?B?alEzN1dPc1ZSR2N3TVVUdVZjK3NzbHRMb0x5RTZPaUoxb1I4TWtKaDEySWJj?=
 =?utf-8?B?MUZ6MENXNzJld2FvazFza0RFV0ZUckpnSmdoeTdIK05JMWJIZFJvdnVqNGVq?=
 =?utf-8?B?QkdhL0xqUDhxcW5DbTJ6aEMwMlpGaUtkejRwNkNpUUZxMUkyVWxXMitlc3Yw?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6EF75E68CEB3E48B82045DD3AA652B2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be334cf7-3ff9-4d9c-bb6f-08daf7a13d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:08:32.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzY8Do5n//NseW3oM3EPAWQls5QA2Rq7aiMpzuC+IcJimQyCXUoPeNljfJMFcDqa4nIjbCuV62OSYhV2Nzslew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6086
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTE2IGF0IDA5OjAwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wMS8yMDIzIDAzOjQyLCBNb3VkeSBIbyAo5L2V5a6X5Y6fKSB3cm90ZToN
Cj4gPiBPbiBGcmksIDIwMjMtMDEtMTMgYXQgMTI6NTggKzAxMDAsIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6DQo+ID4gPiBPbiAxMy8wMS8yMDIzIDA2OjQyLCBNb3VkeSBIbyB3cm90ZToNCj4g
PiA+ID4gTVQ4MTk1IHZwcHN5czAvMSBzaG91bGQgYmUgcHJvYmVkIGZyb20gbXRrLW1tc3lzIGRy
aXZlciB0bw0KPiA+ID4gPiBwb3B1bGF0ZSBkZXZpY2UgYnkgcGxhdGZvcm1fZGV2aWNlX3JlZ2lz
dGVyX2RhdGEgdGhlbiBzdGFydA0KPiA+ID4gPiBpdHMgb3duIGNsb2NrIGRyaXZlci4NCj4gPiA+
IA0KPiA+ID4gVW5mb3J0dW5hdGVseSBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHRoaXMganVzdGlm
aWVzIHJlbW92YWwgb2YNCj4gPiA+IGNvbXBhdGlibGVzLg0KPiA+ID4gDQo+ID4gPiBIb3cgZG8g
eW91IHByb3BhZ2F0ZSBvciBpbnN0YW50aWF0ZSBkZXZpY2VzIGlzIG5vdCByZWFsbHkNCj4gPiA+
IGNvbm5lY3RlZA0KPiA+ID4gd2l0aA0KPiA+ID4gIHRoZSBoYXJkd2FyZSBkZXNjcmlwdGlvbi4N
Cj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gS3J6eXN6dG9mDQo+ID4gPiANCj4g
PiANCj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4gDQo+ID4gUmVmZXIgdG8gdGhlIGNvbW1lbnRzIG9m
IDAvOCBhbmQgMS84IGluIHRoZSBmb2xsb3dpbmcgc2VyaWVzOg0KPiA+IA0KaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NzAyNTE4X187ISFDVFJOS0E5d01nMEFSYnchaVI5b3F5
WXNCcnVqbmxfdjVERXVEWnJUR3A3NWlCS2tMSzk5S1dRVjM5MWtycXBaX2xLM2QyWXI5TUt4Z1JP
QnVWZ3EyZm5WOWNGczdqekd3UmpZWDVfempMMG8kwqANCj4gPiAgDQo+ID4gDQo+ID4gVGhpcyBw
YXRjaCBpcyB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggYW5vdGhlciBvbmUoTWVzc2FnZSBJRCA9
IA0KPiA+IDIwMjMwMTEzMDU0MzA0LjIxODQxLTctbW91ZHkuaG9AbWVkaWF0ZWsuY29tLykgdG8g
Zml4IHRoZSBiaW5kaW5nDQo+ID4gd2FybmluZ3MgY2F1c2VkIGJ5IG5ld2x5IGFkZGVkIGluIE1N
U1lTLg0KPiANCj4gVGhlIHBhdGNoIHNob3VsZCBzdGFuZCBvbiBpdHMgb3duLiBJT1csIGl0IHNo
b3VsZCBleHBsYWluIGV2ZXJ5dGhpbmcNCj4gbmVlZGVkIGFuZCBpdCBzaG91bGQganVzdGlmeSBp
dHMgZXhpc3RlbmNlLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkhp
IEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwgSSB3aWxsIHNwbGl0IGFs
bCByZWxhdGVkIHBhdGNoZXMgaW50bw0KYW5vdGhlciBzZXJpZXMuDQoNClNpbmNlcmVseSwNCk1v
dWR5DQo=
