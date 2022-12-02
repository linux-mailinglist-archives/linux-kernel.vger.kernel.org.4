Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5396401D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiLBIP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiLBIPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:15:23 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797BABF660;
        Fri,  2 Dec 2022 00:13:36 -0800 (PST)
X-UUID: 3e5c35a28ae34fa39b7bbbbd6df00eba-20221202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7b/OP04S8kpKezZbHwGz4fy9MdoJJGFGIjw/v+o6CF4=;
        b=E2nHlxYXu7e1FZKzus5WydnJCptl8Ju95kN6pRvYN6dwfVQLDtIcDH+Q48yaKhMM1fG9GaP0TrR70RMS59bML0WbII4cwoZx8hVlIzAeB/wy2NErZZGzsrCAv/7PeD6UmcknGG84QIj2AF60/T4mCu3RCIopLXbuTfvzI5EWvzk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a1cd9457-fba2-4e6e-95e8-92502516369d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.14,REQID:a1cd9457-fba2-4e6e-95e8-92502516369d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:dcaaed0,CLOUDID:5bcc7b30-2938-482e-aafd-98d66723b8a9,B
        ulkID:221201165828UIUTA5DF,BulkQuantity:59,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 3e5c35a28ae34fa39b7bbbbd6df00eba-20221202
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1967271687; Fri, 02 Dec 2022 16:13:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 2 Dec 2022 16:13:24 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 2 Dec 2022 16:13:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oROE9Z+67roC+cW8J6YCq9eSdap2O0sQdfpBWCiMhNOqq6gTWIQDQ7KOW/YnkEISuBrJK8w4C1PHt/+YNPZdyPgb7za1D0Roio7x+tZn40reF1WwLrVxP0mKOGQQ9htZRtamrPxmiTnQAP/5VLWOjlGEsiP2BRwlDA5j2h9W09wXgoG1g6Ab7JzAY54J6dioDsKV6ss0IH+xLZRUdXbPj8GDIoRbhFEBI1mxtL2d9Bl+HAFTkXGUQNSF8UzXC0kAuYAXhYDaptJyE/HJQLdRJYoiEkAbc3VugFe/2tZaarIO9QwAAoinyJ7LLKSwi3mgwuh2mZT2Wx5USJhp+gntyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b/OP04S8kpKezZbHwGz4fy9MdoJJGFGIjw/v+o6CF4=;
 b=lsFDQNqfi6DTw8DNmb9dL+CrMOgYQQHXHS8IQBn900RCKECpowmS1FbZK/gUpMOGze393VJ3ZPgtrPy0RazBaOvJbqwHm/q+lKTXUWLvup5CEoZWPqcs8YgIHCyY9YF8E6I6bv33d2tslw/taregA7epsgyamalwoGecWbIrVFdzZZS49VuL2PvykUBvVN4D/Rxi2AAd67yEvxWutea9R8TPQx9Kg7FqoY3G8NwLQOWPKJod3hqU2zDFaX4Ol2wltWHKELtYXzLb9IdBS9JdmaVioayE8LlhXt573DZ08Impu3sYu8SGmxrQua0oI9Wkk0Qtgw45GRf0UzNSM66BnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b/OP04S8kpKezZbHwGz4fy9MdoJJGFGIjw/v+o6CF4=;
 b=WaDKBkvPdbdUPcaS97DE/ruGmC8Zk8AsSZY7sq8DX7nh6brbQGgh6rmOrnn6R7W6w1hHESQ5GwAM3jgwDTZEVdeBvu18X40GvFH46Ygo2BdF0hwV9XI5qFw4YdAes8fP2N0G7LQlJWuu2zmC0XN4j46dIQyY/6QRZETkc9rwpTI=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SI2PR03MB6685.apcprd03.prod.outlook.com (2603:1096:4:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 08:13:22 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2%9]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 08:13:22 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Thread-Topic: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Thread-Index: AQHZBVc4xOksO3burUGPCkRUXau3V65Y0u6AgAFuRYA=
Date:   Fri, 2 Dec 2022 08:13:21 +0000
Message-ID: <df3f29c2cc29ffe3f251819ca7e16afd531e2d9a.camel@mediatek.com>
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
         <8c1dc14f-e0b1-b5ce-aeef-68c20da5dc63@linaro.org>
In-Reply-To: <8c1dc14f-e0b1-b5ce-aeef-68c20da5dc63@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SI2PR03MB6685:EE_
x-ms-office365-filtering-correlation-id: 40ac05c8-a11b-414e-5c68-08dad43d13da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxBP8HxTnVHZc5FU2l0IVt1l2m4zoS5Wt8ohk44y2NDcT7ZWIctNRsh7AjBOgO9UUTYKPvCA2irNaAeZjN8/tdWg6lhS+uSqEt+b+yrWdkwOfqG6LdqlMNHbGhJDtJHqN+KFI8yNUAtSj2PF7RCa/udXQ0Fkm6dusNaPXeIXw8BOTHhQnVDFJ+uuMiO7kGGqghn2cX42i+EdbgtNxRIM3uaqDcoG+WpgSC8wwMGHjXsFTw5W4JTtOWvuKXA+MPQ/+lMFj7EKEEtdIZ4mo72tnKzKItObiU34x5iAUA1+sEfWQsQdC/PcoLfTsMS4v6ktpTzsvSfp1CGO3TEujxPjud/W+j8doDXhAWTJzxEM2qEtWo4ttSDWIinhkutVZdWBSGFrz5HXgYKBhNxAJEMXmGZdgZF6okDWh8p/PU5ISWygIVMsX6/BWGxAFfvmwME/Ha0ghn0C0Swx8AT79KKD08xpTg17B08ekLWSrPzppJVZipTAwDGaq16zouIytvq65IN+0OJeAPMHPk32+QReSKCYgjJSgoOvMRR3bk9O8M6k7TZJogoEk69ArW9DJICBJgblMbAdDuSujD1r+G60u3pynlGyRfHTXOTHQBEYACEP0Jh7NzPL9panimfLFnPV0iXva9zeumi7ZeLcOScZLzZ4JBOWTJTlK9PlwIlDfdGc0Vl8LcYah2tbi/NANbXMAcrT8KaUiAHZNYvs/ze5Tj/Df6+gqGvqD5HZZaLMSYHiYWbsfcT0r08UdJ5LPJAIgacN7XTzQVx619eEV0hFRyDFasSbQrA0qJdVrfeYCu0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(36756003)(85182001)(2906002)(38100700002)(5660300002)(7416002)(122000001)(4744005)(110136005)(186003)(2616005)(38070700005)(54906003)(6512007)(316002)(8936002)(66556008)(86362001)(8676002)(478600001)(41300700001)(966005)(6486002)(76116006)(6506007)(66476007)(64756008)(26005)(66446008)(53546011)(71200400001)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3AyWGk5ZGlNMHorZ0t0MFdhQmUwRDF3YXgwRE5vTkk1Z1V0eVVtMU9zTVph?=
 =?utf-8?B?ZTdRMTNCODRzQkIrSWRiaGhvRzliK1ZpUFpaVCs2ZU4yVGRZd3RWNE9JZWxE?=
 =?utf-8?B?ZHFmTWQxSEl1VlBjMFVtUEpESFpUcU94RDYrTlZLZFNWNHFRUkd5QmZuWUgy?=
 =?utf-8?B?YytWTmJFZC9GN0p3c0RIaUdYcENXaFNwSzErUi9tY2VXb1V6cVhMZkhPU2tU?=
 =?utf-8?B?SkovcW1vbWpRd2JOVlMvOFhkMlBpcjZIbExGalJLcVBkdG1jVEY5V0pQbDdC?=
 =?utf-8?B?OTBva2U3dy9MVmFJdzJBQ3R1VGNQNFM3Ump0OXpPek9rSnVtZncySmdLMHZL?=
 =?utf-8?B?SlM3TUJNdUc5Rk82b1U2WEFzUlQyMTcwRm41U2ZtUCt0dDFHaFpaK0ZIQXB6?=
 =?utf-8?B?eGtxOHV0OTBsejNDWXZZOG1EZzlLQko5Qi9yV3N0WWY5QjR2L1kwN0JwSTRZ?=
 =?utf-8?B?ejI2U2czL2Q3WW9DUWc4MzdpWUU5SnVlL0M5Z1krUlN6WVdFaXFHLzJuQmZh?=
 =?utf-8?B?RWthcmJLK01GMEkvNllPWmVZSW9hc05ZVUxWMDJvbUVHV1hNcExDUVNuRGpY?=
 =?utf-8?B?MXVMRXpjZmZRSkVUUFZVbEc2cGl5WUJHNnJlTDRKRFVHYWF2Zk51VFJPSlZS?=
 =?utf-8?B?cGxaY1dhQ09MNjNPc2ZXSDNnL2ozSmo3NGlKTitDZkhvZ0RjdlphcE5BVmdl?=
 =?utf-8?B?cUwxb0JTY24vditMMXIycjVoU29LZ1k0elBHZkFRQ3NvdExqT2FFSVloOSth?=
 =?utf-8?B?bVFBbGU2emtFeDdYRWdQWlFRaEZpcUF6UUpjdU51a1R4VGN1UC84M3RuejRZ?=
 =?utf-8?B?aUdwNmxFWkpNOEVpSnhMaEw1aWF3SUJ5K0I1RTJkMGo2SVV5UGdsbjNBMUxu?=
 =?utf-8?B?S2hQMTF4L1YyZDVOakU1UkhmMWlwTEdFN24yWWkwNVBXT3pjWXhnQ2hVVGxR?=
 =?utf-8?B?aW03RzZTTm96YkpSdWd4WWt0OHFTVDZJWTM1eDlyR3FtUjBDcDd3UlJQZk9E?=
 =?utf-8?B?M3Z6TzVCbWpjVjA0djlpb1JlNmJYZjFOS3hvSWRIazNmLzk5aVZuVXlKK0Y5?=
 =?utf-8?B?WFZxcXpWeXJlTnJjNDVmb013a0ZaTzF2Snloc1J6RkVGdktEcG44UEpmSXhL?=
 =?utf-8?B?cXhhZnlDZmRUWWRlYzlFaWJvcUJTeUx2WGdFWXdDNCtOaHE3UEh1bkkxS040?=
 =?utf-8?B?aDdGSFlQYm9GOVBSNGZXN1Z4OWV3dk5uTkVvSTlRMVpOaUFHdnMxWm8xMEda?=
 =?utf-8?B?YU5BcTgrWXZMZ0tNTTZVdEpEV1JubVBPcjhrZ3ZKRm4yRXFxSU45dFlKNExX?=
 =?utf-8?B?ckEvTlNqQ1luWk1GU1R1N0VTSWsrU0x1MEhmYlJFR0hUOVNsWkp0YjFWMzVB?=
 =?utf-8?B?TjUycjViQmFrVEFsQzkzTUs1RWt3ZWR5Z29ZNTcwQ2EyRGc0Zmt5WlQvYm9u?=
 =?utf-8?B?NTk3UlVMSlJFc1VZOHJXU051NnNDcUM3UDJxbE4zK2RpeXVwSkZaUmI4aFQr?=
 =?utf-8?B?V3ptRnZUTG1XeDVtc3g3VU9yYWdOd0kwT3pvV2lDeDdDRmFzNzR1ZDMyQnF6?=
 =?utf-8?B?NjU2eVd6WXFwNENNeENSZWE2U1lTa0RCckNGc0lYL2FKWWFkZXBDWGRlYXc0?=
 =?utf-8?B?bUpJZWlhRTU5REdzVnB3OVVCRUl5OWN4cXMzR2pJWjlIcThlc2QxMDhkaTJK?=
 =?utf-8?B?MytuN1FMTlhDRWZpNUxvZFVRYzZVY09yS3ZkM2pyUkk3N2hMV0NCTkswUFNH?=
 =?utf-8?B?Q0x6Q0Faa3czTnVYeFlMU2lzUWlNalphUGlkN2l1TURvWFoyOFVtSldUYzQ1?=
 =?utf-8?B?bTNBcG9JVFlxZTBSczJFZ3liYkRYUlBpMVVpdkZqdXVhR1VkTU9SSmJzeERH?=
 =?utf-8?B?SWljdmdZaEI2M3BlQWx5b1FMRWt4WTRObHdublJkVWNrS1ZTY3VGWDBRbXFI?=
 =?utf-8?B?N3JCNXNzM1N4WDhYekszUHNYK001ZnlsajBDWEs5b3g1RTlQZ2xLTXQxYnBT?=
 =?utf-8?B?b0FQd3MwTk4xMWlleU1EVGMxZjNMaFpFMnFzVkFhOUczRk1VVlJBa1lDcnlN?=
 =?utf-8?B?TzFBS0EzWVAxU2tIVjg4ZW9DVUNLUXNLTzVTSFFFWVE4WVorUklJT1NZd3Bj?=
 =?utf-8?B?d1lXT25RYXZBV0lFWHBOL1NBMkNsa21pcldjM0pjY3NtYk1NOWQxdXdjM1BS?=
 =?utf-8?Q?dxp29XoehAllNYaLvnCGluI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <754E84D4E53F1643AEDE4ED96E70F0C8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ac05c8-a11b-414e-5c68-08dad43d13da
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 08:13:21.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN3sfyo3DwnyZRfp1LvhdDP22Jxz9USO+cf2qaSThLc/8YuaWmzLaHqfk5OFz30eGMXWyuLRAfcm5yj/rCS9mkTiJnTkExz2BHgjjgs99kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTAxIGF0IDExOjIyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwMS8xMi8yMDIyIDA4OjMzLCBBbGxlbi1LSCBDaGVuZyB3cm90ZToNCj4gPiBB
ZGQgYWRzcCBwb3dlciBkb21haW4gY29udHJvbGxlciBub2RlIGZvciBtdDgxOTIgU29DLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsbGVuLUtIIENoZW5nIDxhbGxlbi1raC5jaGVuZ0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gUmVmOiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMmVjODBiZDgtZGZlZi1kMmU2LWViNDEtNmU2MDg4MDQzZTMzQGNvbGxhYm9yYS5jb20v
DQo+ID4gICAgIFtBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tPl0N
Cj4gPiAtLS0NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
OTIuZHRzaSB8IDggKysrKysrKysNCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgx
OTItcG93ZXIuaCB8IDEgKw0KPiANCj4gQmluZGluZ3MgYXJlIHNlcGFyYXRlIHBhdGNoZXMuDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KTm90ZWQsIHdpbGwgZml4IGlu
IG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KQWxsZW4NCg==
