Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C278164D82E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLOJCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLOJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:02:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB812B254;
        Thu, 15 Dec 2022 01:01:51 -0800 (PST)
X-UUID: 0758e80adff9454caabdcf48ee1281cb-20221215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DHmdiXbbChLKEUgd/iL228rQc7FYcC22zdhxQJ6Vaoc=;
        b=qSLcVVK62IO2mkSsGZMofpv/AWgtBDzHZK70VLg2rUtRKoC/p93C357YbdoRKREH6UTmk6RdNKn7pUNZtxYYDPQ4ptgoGcvPNatG/jFPW5i4bOhsl7kEg7gu3rCAdBPKqv/EtFK2Hk/f5esKHN8DWDXvcfhQPxjCFCRn0fLFLIM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:d59e53da-3896-491b-aac0-56dc1a371aa0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:e798acb4-d2e2-434d-b6d3-aeae88dfcc78,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0758e80adff9454caabdcf48ee1281cb-20221215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <elvis.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 991869963; Thu, 15 Dec 2022 17:01:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 15 Dec 2022 17:01:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Dec 2022 17:01:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdIz65jWtsX+Zx55w2vxcVR1eKN9wNMgE0GTO2JO2dJphxDhlfzhau9AXp81pATikZESanZmgl4WMuW8pkUiZLsllo7l+VN8268Hr57mtqfcpz41RJVX5pD0jGuaFBGn5xPizoc1q9iMQKqRZ2PnAtW6kEG18jOuWtIGPux+rSILdn8vyVmb463Gs5hGSaGhxtTIbufFcDCq8txtT0Y9M4GE8S8cjiQzaZhpG5pGYbnfI9MAeA2CWXLVyVekb6j7uQ/rhySGRPpHM7EwiBffheJqOOItNMU5FCmZcsJoYfAY8V/ztvRVhATskDzT1WPa/X54Vp/tFUUTYrpPHw2jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHmdiXbbChLKEUgd/iL228rQc7FYcC22zdhxQJ6Vaoc=;
 b=GBEkqnMPMO1jPWUiHQEBs0+vlmjs8AePBwOLCRYu5WJ+KURgCq1XWdA78S2zNYNjee5g0sdPUFdOoZBNXs4I3BsZVT34w1ch32kumbUrC2A1U28pr3WjtKwaXI8WKzqrKVCDTFwaPCfGd+p26ccqHT8tOPkKELJM0W/4zW5y7xl0tfx7g36QUfFfXSSnxKB53gqZTk5UIR+ZXmz06G+iWWUm1SRJvz2FzXF1GVDNhfYWQWIMEPiVwa62qxFYiLE173OaYzljpHC8/4IHUve6XWH9Uj6KjhjM/N0f1qLFTYUQaG8ayfKTTSU2DH6ig6GNOpjXoqgtDbJ/f2QWZpOawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHmdiXbbChLKEUgd/iL228rQc7FYcC22zdhxQJ6Vaoc=;
 b=NxTwU6cCVF0pttQKG2D7ig4pAWVaGbiQpQB1uBTQ5U4liGRfdetmNcM5rYiwRFDy1q4yWo6GlB0+IfaNHEa+tovdo5S/GK6cFGBH/q1S8Zlnlucz155eYuSyztO8hKdudZOiXlJVJZUZcsDAz4+yYGWoD2CazWlswTEPs1cVDLw=
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com (2603:1096:4:d::22) by
 SEZPR03MB7245.apcprd03.prod.outlook.com (2603:1096:101:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Thu, 15 Dec 2022 09:01:38 +0000
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::2cfd:6603:7f27:9fe3]) by SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::2cfd:6603:7f27:9fe3%7]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 09:01:38 +0000
From:   =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add GCE header file for
 mt8188
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: add GCE header file for
 mt8188
Thread-Index: AQHZBVR/t/fUQvforka9gOyhCdOA5q5Y8rsAgBXKSIA=
Date:   Thu, 15 Dec 2022 09:01:38 +0000
Message-ID: <b906dcacd40eb22441e54a62b7ffdd993bdb4a2f.camel@mediatek.com>
References: <20221201071316.24583-1-Elvis.Wang@mediatek.com>
         <20221201071316.24583-2-Elvis.Wang@mediatek.com>
         <2cac7d40-1807-63b2-9be7-9e88e721b68c@linaro.org>
In-Reply-To: <2cac7d40-1807-63b2-9be7-9e88e721b68c@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3228:EE_|SEZPR03MB7245:EE_
x-ms-office365-filtering-correlation-id: e8476b19-2046-40be-8a2b-08dade7af9ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37jryCT59du/oIJ3pNi9IkjksQtoK01dIFfXPzpJTOapFYZRq15byhIcOfVOjRKV3T8OqS2nuGtEBJRhJQuYwOx4iK5Y81Z8cbjCdnlrrtHdZt8tHLoJAi2yFOvWOczgQWyd//JSX11D+VgXPgUt12R0M3fePXtNrM+GkZiBC6vZJ1ERa4b6A8RyKxaJVoT+IFSqygp88vvcVAzF7YsgYgKMdhN2VK4sef1jpWMgDS6tKc/0odq7zZQqbozvC8FBBfx+c868tAsDbcBeZMQ9pF+ZatPsf2tH9BVL90Ggxrqh1xucJMuT0g0s5Sv4r6xRrp8rNFYroxfp0miiIPflfToGVOaWyVTqfc7F+xN1Jxou4AmggaVCTKZ0UJpNWXIzVDTxhGJglriUdh+RCGFjdGhjaIVEqmyP6wWH/cCQ3dSsvuzPuGbfkafgcqq+Fn5fU1gVavSfbjlWkaZISrmq9l41KHhhs42J8wZSyPoU/2WPVO4m+/VJOJFLNhLG4c97Rm8qonaUF1IIEsdwH9+EHTymXUwh8khpz+7zEBL1J3adXw5cCWwXINJoydBPW2q0dZqRZhhdQ1puL/I6p4p101+0fLUUFvU5IIzuv8YlPAMAiNhrzI3Xwj6qapiJLn9vd7fYtyvklENADOb6GGivVwO6EvDaThNfuHSyyGXAOflBNVBp0PhvZZq9vSTK9j7e/TIeOLJujea/oulSjp/seg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3228.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(8936002)(38070700005)(86362001)(478600001)(41300700001)(36756003)(6512007)(66946007)(64756008)(4326008)(2616005)(186003)(8676002)(66446008)(66556008)(66476007)(6506007)(53546011)(122000001)(316002)(6486002)(4744005)(54906003)(83380400001)(5660300002)(2906002)(26005)(110136005)(85182001)(38100700002)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9GWjh1ckNBL1BYc0ZEcXJKYndGQkxqSnMxRk5vcDZGQ1BoYVBDL0ROMjRs?=
 =?utf-8?B?TFZ6ejJXaEh0TkJYMi9lN1oyOFJPbDkwZmM4RWFuRmxmYXgrU1VYdW1qS0d0?=
 =?utf-8?B?WG10Z2hDTEkzazlZY1dLM2E4M281bnU1cUNIOVNzV3BKczAvK3V0K015WlFw?=
 =?utf-8?B?cGRJbTBaOC9nNGFKQWVHT1U1UDdkczkxdmhlMjdyc29RcXVKYlRWUzRnUEdX?=
 =?utf-8?B?RkhvbUlmVkFYdFRkdmVLOStCKy9BRm12T09pUVdBSjFyL3NmTWJMZ0xuYis4?=
 =?utf-8?B?NnI2eTFSZlBOanRFRW16RjNIMFowL013Tmdic1lTMkVDeEVKVTVQR0VQaEVD?=
 =?utf-8?B?d3krVE90d0tESHYzaUJ3UU9Qd0JJUWhra0pyTUpIYitkam5rcmt1aGJDRVVG?=
 =?utf-8?B?V3NJcXNFdlpTTVhOTWYwRjNNa1IzOUJXektlUVBPNm8rOEpDZU5XZmdHcWFO?=
 =?utf-8?B?NnByMGpwUks3NjY3SUlLNjBMU3Z6ZTRQQUE3NXZvSnQ3RFRNYnlmTEdKRVU0?=
 =?utf-8?B?cGZQRkxvVzhpZHlkSmRhL2IyQ0ljcGMrQldMeUxzdXcwbHI4RFRpWTM3d2pR?=
 =?utf-8?B?K1QremQ5SXMxN01BZzBGZitBVjRDWnVhRUhmVFYrd3pPbzlnRTIyN1VtUjcz?=
 =?utf-8?B?aXdwZ0ZYMGhraUpsZWZBbFQvZUVXdGRVa0JycDl0N1owU0xyVVVEKytIZExB?=
 =?utf-8?B?OTF4UHZrUVZwb25hWGM0VGthQ0d6RVZiOTFZMlhOSGVGRmliOWtDUXE4MVEv?=
 =?utf-8?B?RlMwamlOb1JUenhVQktySkJhTVpCQlBTbm5ZZHJQUzJVRnhYYmRXYjIxRXNn?=
 =?utf-8?B?ZWRMZVptUEhXWFA0NWZrZmJSWjZRWXR6VXEraHlVd25VTlowTkx3eWtaUDU1?=
 =?utf-8?B?L01hSEJ0N2lrQ1I1TjRtL3JWYTZrUDdpN3JFSUF4d2psWHlzZGQ4NGV6VEFl?=
 =?utf-8?B?ZFFScms5S1BHQnhOc29tT3NZZ2JOVHpmbDZiY2g0bFV1czZ0MFF3ZEgyNndq?=
 =?utf-8?B?MlRyWkFHM2N6U2VBQTZtb05NWXVBL1RsTFV2NWV1QVIyOWF3dVdiTHdRSE40?=
 =?utf-8?B?cnlwUkFBVnVQdFlsYTllcjkxOEFXSUNCbENHU0pRRHo5a3dsYUFudXBlUWZP?=
 =?utf-8?B?NjdHNkJrNHdqSi9lSHJveTdsTUpMS3VYQVgvRlVCRXBmbklWNWxydVQxOUI2?=
 =?utf-8?B?OUZFM1NhWVZoS2xHZWRnV2dQOHVBN0Rkc2tCL21xTkdHbHB3ZnRDUWdiWDBj?=
 =?utf-8?B?SGRuRHk0SEZYZEE0a05NcURsc2RQbnpSSHNtSWxnZGk3YnU1Rm5meTF4dDYy?=
 =?utf-8?B?cnJjS1NXdUVEajFpQUVGYUxia25WdUVFRndHem9GN2RqWklqalFBZmpCcmd1?=
 =?utf-8?B?Q1FMbXl6L1RqOXdTSk40dWkrZW10VUtwQXhCWDNjOWJnN2Zic1RzWWJPdm5Y?=
 =?utf-8?B?NlRMNUxST1k1OG9mNm1kWStIWVptOEZFRk9lV1kzM0NQRUdoby80SzJrek11?=
 =?utf-8?B?eUFmK1o2NTJ5SzA1UWQ4RUNHVTlvWjM4Y0w2dzZhbUN2eURucE1CS2xxYjU4?=
 =?utf-8?B?MTMrcTk1T1NFOGUyb1o2M2pSOGpsTWNrV3drR2svV3RJT2hlYm95MU9lK1Av?=
 =?utf-8?B?Ym5vMCtLYmcvalpLc1dvR1RMK0pCZEw2OWZDR2pzcWJrVVI1Z09sb0F0dVJU?=
 =?utf-8?B?RFE4TEhiNThuYUIwcGJOUy9HL3dya3VtNGovYTg1MEFVaHBDTllTUDFnREFi?=
 =?utf-8?B?Yll1bjhGUXVSM04rNWZWbW13L1pVQ3Q5RkwxSkFsRXBvbzdjM0RDVnNHS2pT?=
 =?utf-8?B?MUJsK2hWSUZWcm53N251VFZDTlhHeWlUWmVPd2UzellZejR5Q0ZEaVZkZnJR?=
 =?utf-8?B?TldubjMva3N3S1o4WVhuSGNqUHZYMXlyakh3ZzVsNkVzejB5QkxxWHJQdkJw?=
 =?utf-8?B?ZzBpbFZHNDBkeWpaWm05SDd2ZGxpT2R1YSsvNm5MZGNmeFRCUXhLUVZ0V296?=
 =?utf-8?B?czlvNEVJdG15MVBtek91aWNOWDlpZUQ1WmxNZ2VhMi9BNWxTMVUyMFh2UU41?=
 =?utf-8?B?WXhFMWswQ05kaUZqVnBBMmJMVkhISk1oQlQyK0h2bkMwUkRiOXllZXkvcGgy?=
 =?utf-8?B?Y0V5dDNCUGQycFZXVVJRODNnMGYzK1dSZVFXS1JpdkdwaWxPNFpFS2JGS1gy?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECE2BDCC537B5C4A854B5408753D901C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3228.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8476b19-2046-40be-8a2b-08dade7af9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 09:01:38.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1SxyqEMW03ap6XDZ70X4AKdd+AwZstkSC5GGcwquZaFzdrpp2PAfHG12wuPI0VroVqdR55JJ5Yikb4JVzDFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTAxIGF0IDEzOjE2ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwMS8xMi8yMDIyIDA4OjEzLCBFbHZpcy5XYW5nIHdyb3RlOg0KPiA+IEZyb206
IEVsdmlzIFdhbmcgPEVsdmlzLldhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBHbG9i
YWwgQ29tbWFuZCBFbmdpbmUoR0NFKSBoZWFkZXIgZmlsZSB0byBkZWZpbmUgdGhlIEdDRSB0aHJl
YWQNCj4gPiBwcmlvcml0eSwNCj4gPiBHQ0Ugc3Vic3lzIGlkLCBldmVudCBhbmQgY29uc3RhbnQg
Zm9yIG10ODE4OC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbHZpcyBXYW5nIDxFbHZpcy5X
YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm88DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+
IC0tLQ0KPiANCj4gWW91IGdvdCBteSBhY2sgaGVyZSBhbHJlYWR5Lg0KPiANCj4gQWNrZWQtYnk6
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KSGkgSmFzc2ksDQoNCiAgRG8geW91
IGhhdmUgYW55IGNvbW1lbnQgYWJvdXQgdGhpcyBzZXJpZXMgcGF0Y2g/DQoNClRoYW5rcw0KQmVz
dCByZWdhcmRzDQpFbHZpcw0K
