Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8006E3D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDQBu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 21:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQBu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 21:50:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF31732;
        Sun, 16 Apr 2023 18:50:20 -0700 (PDT)
X-UUID: 335efd14dcc211edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HpFeHWmbYzngVhqwA0kLw1Mhwai+49ojH5z2h9Jz5wY=;
        b=Uj6hsiIr0sI4672jyImRUv5vr/zloexnEh/i9uCRcIAe3My3dNfbgsfHG/EyC/Eo3HM6/7Jp/sXA15GeBFxw23kcEJQBH0GEF8uyrFqamtjy1BngPkwdtUWM/l0KGcm3VglW3ke5Rqlzl2DUG/lfrMq3SVAYYJMr6XVHK3sUS/w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8ef784e0-609c-4086-aa11-741b2400bf33,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:4de33e84-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 335efd14dcc211edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 882438461; Mon, 17 Apr 2023 09:50:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 09:50:15 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 09:50:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKNB8S2VaOxlPZTWrNxe4NfyOQ6ekb0Ldcg0un3ol35KP/W1iKsBzoUR2BrgjnD+UM5ym+Z7CjOsXezxIks3ieTbR/seLWCrl03wWxLHfia+n9mQDezuxbKM1JOM2e50RvfFi+L8L6s+ttF4kHOleSqpyZ9G+g33vwM/2+hHJhXNEeOCkA+wMV2sZpuqVpPCiXY1LriNLYvLfx/nWml9SeIPF/PyNkXMp1mQ46lVE+dsWMZf8gzS3xmGKxWff7uzbg6zKmmTyG18v57tzp28ld1c/n0aIrwlKvlSQhju7zD5O+T0cWvsoI5EdcpengdA90q1L/IgJmEkg7bLKEkOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpFeHWmbYzngVhqwA0kLw1Mhwai+49ojH5z2h9Jz5wY=;
 b=VbibA2BWjTaZCAUB78kg+Dx01+o7WYp00AHbtGUbVSN81m+9uD6hIzCzyio8bhs0W7xr5ttHPXO9IsqH5UJePedmwXzcCSI6Q1k6PG9tMBtuXDlt49oX3g1HsgFG1v6N4VWB9rwaH0ra/vAxFp00WqfzKQQnLXtMAuPP6SF5iiiJrtLrd4izWCM1629nZK0p6doGg8S2c4exenZKWrzBYK22jCPu3rjTFm4lL6fliIphnBHYrz9rD6lBmEoOcUasPlHfVz7M5f5/X3t5/2DLBmot+5bOo78vV7kYpCZSiARnGqgXM8pkPdeER7No0TIAJhYesFG6N+ZizL5ECBS8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpFeHWmbYzngVhqwA0kLw1Mhwai+49ojH5z2h9Jz5wY=;
 b=LS8yTmACPeWjkH4CYsEffb34IguQ3BwwFsGYlCCwuDMpFgUkiAsGXm1/iLmwYoQjdpUqV1Yr3GH1DgxcUBQ489px1/4wXytNu7c0iYCqqcs1k3KNdsCNU5bu4t9jWI/FhtU7At7STUZVMwGk517hTIn18GFIw0x0IOiOa8HP4Ew=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SI2PR03MB5355.apcprd03.prod.outlook.com (2603:1096:4:ed::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Mon, 17 Apr 2023 01:50:13 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 01:50:13 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/7] usb: mtu3: fix kernel panic at qmu transfer done
 irq handler
Thread-Topic: [PATCH v2 3/7] usb: mtu3: fix kernel panic at qmu transfer done
 irq handler
Thread-Index: AQHZaSsaHT9p16q6RU6pA0m2SRH7k68fjt8AgA88roA=
Date:   Mon, 17 Apr 2023 01:50:12 +0000
Message-ID: <8610162dac0dee0c2abbabaf3a8ad8821bb4d742.camel@mediatek.com>
References: <20230407082937.14558-1-chunfeng.yun@mediatek.com>
         <20230407082937.14558-3-chunfeng.yun@mediatek.com>
         <0d4162ea-e161-5afd-8b27-92f8e53b52aa@collabora.com>
In-Reply-To: <0d4162ea-e161-5afd-8b27-92f8e53b52aa@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SI2PR03MB5355:EE_
x-ms-office365-filtering-correlation-id: a471962f-b58b-4c9d-82bc-08db3ee61595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEkK+tDTBGioLMnhqujkBptXSlDhRpJxrO+tmjgL7+3amHU3YqWUKgPNamt2taNYMzrE6Z83N/3nuRFYxjMWyJ+YEOZ4r9x7n38CSNnM7dfbXJDEw/uCIIdNgiPq6YT4FpfkOkAQ4P9CO0lzcFBUUNVfL+5Ss/67H/HpWLyZDMOOPfnS0aQ1h/rQYYlA3crk3GFu36atGDY4ZnjXlyNAr2LSiD8BnX8g0oqJWnkm5wsbP3YxN20HKD0+o2nqZsiDJSMKFe2VFfng2vzm7YFgV6lT9hNjSylVW7PrsN7nxhx1g7xM6xoGYjT+5yWMVc5FrnwdarO0jxJ/2Z29PZgsV7663QEU5YaDrLpcnhFfnQU169OZctmkAq6Y7tcoVAI1wbGzRHMtpXt5UoSl3UOwjQL5iYhz+mevnj5+vrLMQGCMkMM6xC48bVmp5/L957JDLeK0sFsCZt4aq3xUEfJE6mTIkC6JsrqEIPFZVAeAw9S+yjpAnVba7hydHqmZtF5NcFvrcH32if246HiWaT6qBXz9cRO0g55FSGn3rZIXM9izIVVm7SYimxiFoW+BFltv2aD4li4vW5OfLSGxEHdts2QPdlYB7C3iNaKnVPFuni9pgYrSoqKIQ4l42mmdRR91YUwOSXEWMvWFeuhX7GOE0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(54906003)(110136005)(4326008)(316002)(64756008)(66476007)(76116006)(66946007)(66556008)(66446008)(478600001)(6486002)(71200400001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(7416002)(122000001)(86362001)(38070700005)(85182001)(36756003)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVRTcGo2eXd2OC9lUHVGR1N0d0hsNkZWRytwQ2duNUtwaW42RmxsNGN2RStS?=
 =?utf-8?B?SGwwZ0c0NGZSSGl5VWxZNVp3eE9oSGdLODZXa254V1k0cGxlcS9mN2N4N0pi?=
 =?utf-8?B?Y2FMWHJuM0R2ejltT3UvMUM1VmdMNUlTU1RrMS9BeVR3QXJzUTFFWmh1UGdH?=
 =?utf-8?B?ZmUydHJwcDBMMHJOMU1ZZ0J5VVN2TDRtejFLTXAwTmxOUnRlbVV6VmRZTjN0?=
 =?utf-8?B?SEtLWU03cmxqWWNUazBPNFF1V1pLL1BGNkZYSExZZlpEMDlOOWF6TmJKNHA2?=
 =?utf-8?B?SFZiUDAxNWM5bm4zdzdhbVVBaTJHY0ttMVlPN2dON3U2YllxdVRxTFk4ZU10?=
 =?utf-8?B?cXVJZFJTcGFFTjIzMHR6bmE3WnpnSDREUHY3cmtKdlMrbUJTWXlnQlBDR0hN?=
 =?utf-8?B?TllMQUpCbjlWS0hJd1llcFBreXhycGlUc0o4c3VrT0ErMEpmb1Rpc0d1TDYy?=
 =?utf-8?B?eHo1SDI1YjJGaGdmQVR5eC9lV2JTdy91NVFJRWFSS3JmQVFMbWVCTWx3Njgr?=
 =?utf-8?B?aXUzVmR1S1l4WWcxbjUyb28xZlpURXcvYkk1Y3Bnb3lwU0ZCbW45cW9UZ0Vs?=
 =?utf-8?B?VGF5UVBKNGZoWCtmSTh6M3BXamc3ejhTSytUY0E3cGpyeFFueDQwMXlGUDI4?=
 =?utf-8?B?dnhvS3lQenhWYXNXcyt5SnBaTVdNOE1pMDFRWmFTUFBBeW1tUzZiNVppMVcv?=
 =?utf-8?B?bnQ0UUNGUWJyblVGaDZSS29wMlI2U01iYm9SZ3dqYVJEMGhIcGE5NDk4WGhs?=
 =?utf-8?B?a2ZGR3B1aEFrenBZeDdjekhrZjhZeGRsNXVkQ0EwUFdRcEZacU0vTURSUDVu?=
 =?utf-8?B?UzZVNWdwNnBrUkFsUTdMT1VRUHoyZkNSOVdpUEdhSmNZZ25XdjNTeFNkenRi?=
 =?utf-8?B?UWgxdDRJeXNNS3ZCeFVJMjYzUzM5cUFZMXNwc3ZSMkhwNVY3elRXVzQ0d0dv?=
 =?utf-8?B?SzNYQktIbEVmaWVKS3Q2WllqWndUVDVmNjZxdmxKWFZRRlpmSU9lOS8xanJH?=
 =?utf-8?B?Zm55VGlvbGZPcFJIL3JkSE9RU2dOVk81U3RiSVV0cUpmcEQyU2l0M1ZIQXR2?=
 =?utf-8?B?aE5wb21YQk9RZ1JtbnlQR0ZJSHRnYmc5Rit0N3RIZVU2emxBQnpRNThwSk1l?=
 =?utf-8?B?cWRTUVdZTXNxOHNadUxEL1VMZDZaUEhUQW0zYVZPdHJQcmR4WVUvc0cvSXVj?=
 =?utf-8?B?SVRvTTJnZlRBUjhUbndhRWtQNXhqR25RdWRPbVlIb3VVaklFK1Nkb2UyNUcx?=
 =?utf-8?B?U0dwUDVKcmRvVTJzSU1yZGJYNDMybTlpaUY5M3lidnBnVSt1Zy9SM29Tdkpl?=
 =?utf-8?B?c09OWXBjTnVkdzI4aGFrV0s5SDNTamFnR2w4bGhiOWo1OFVSSmZMRXZROEdU?=
 =?utf-8?B?QzNFdjZiWCt0VEx4aU9oU0VERjhOeGpXS29PN3h1c3U1Vi9jRm5uZnRRa2pw?=
 =?utf-8?B?VmlKNVBxQ1dldTkzQk5nNHBuZHJMQ3U1dVZvdzEzbkgycEZ4Y2g1M09EMU5w?=
 =?utf-8?B?dk9OVDdDcE5HNTh0TnFERUJIMzkzV0ZuZ3BzbVV3WndiUytZcHQyN0VYeThr?=
 =?utf-8?B?OXhsMDNNaVBjRU8rcldaSng0bkFLMFBlVEp0bEhnS1c5MFZZSDFZajlLM2Fz?=
 =?utf-8?B?ekNma3h1a0ZUZGJkR2NEWjQwUWYyNU1QMjNOR3IzUkVtdHlQcmxReWk5cXNY?=
 =?utf-8?B?SG9tZE00VzZqWC85VGpGbGp2N3EyNENXQXBBZitFUURjMnFOOXplUW5RdWJB?=
 =?utf-8?B?Yytpdzk3bllVZ043SmVwYVNvTnl6dUMvbmErR1I5QUNKRlQ1R2FWd0syNXVp?=
 =?utf-8?B?VmNqWnhia3BpbTRtTWR4YzlNS1dQYWx2Rkh5cHJ4WFRYUTQzclN3RG0vMzR4?=
 =?utf-8?B?K0E5MkV4VmJveWQ1d1hrcTAwS1FITjBnTnh6M0NSbEp1T3ByQkxaS0ZUZU1s?=
 =?utf-8?B?d3VJM3FBNUlxeWNFb0dpTWxEUWNwS3N4M2lmT3luQ2s1bmlGTlM4MTk4eW01?=
 =?utf-8?B?WFdoTTNTZHkyaGd1MUNhQUh0N1lNNU1YYlAwYm5DaG1ONG5IOHVLVC9aU0ht?=
 =?utf-8?B?SXZMZUUxNmxGekpDaHN2ekVLTFp6ZVNWR09kaEpFb2treFhDUUx4TnNYTGdr?=
 =?utf-8?B?a2hsVGZ1S0RHM3dlWWJ0L1VZcTlQNmJlTHlmR3A4NWFmZGtZVXluUFliTTc2?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F0C22E36EB9B47B48B68A3581A9416@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a471962f-b58b-4c9d-82bc-08db3ee61595
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 01:50:12.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSvmBX/PSYnDnOAAzJroUOnO0tIWXToRs2u0SI0D2iZCXc8BhebGrX5CZ8WXRueIntDWI4vPyDfMZ0HL+P2OPZFThnUL2g3puWpe9adyecg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5355
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTA3IGF0IDExOjA5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwNy8wNC8yMyAxMDoyOSwgQ2h1bmZlbmcg
WXVuIGhhIHNjcml0dG86DQo+ID4gV2hlbiBoYW5kbGUgcW11IHRyYW5zZmVyIGlycSwgaXQgd2ls
bCB1bmxvY2sgQG10dS0+bG9jayBiZWZvcmUgZ2l2ZQ0KPiA+IGJhY2sNCj4gPiByZXF1ZXN0LCBp
ZiBhbm90aGVyIHRocmVhZCBoYW5kbGUgZGlzY29ubmVjdCBldmVudCBhdCB0aGUgc2FtZQ0KPiA+
IHRpbWUsIGFuZA0KPiA+IHRyeSB0byBkaXNhYmxlIGVwLCBpdCBtYXkgbG9jayBAbXR1LT5sb2Nr
IGFuZCBmcmVlIHFtdSByaW5nLCB0aGVuDQo+ID4gcW11DQo+ID4gaXJxIGhhbmxkZXIgbWF5IGdl
dCBhIE5VTEwgZ3BkLCBhdm9pZCB0aGUgS0UgYnkgY2hlY2tpbmcgZ3BkJ3MNCj4gPiB2YWx1ZSBi
ZWZvcmUNCj4gPiBoYW5kbGluZyBpdC4NCj4gPiANCj4gPiBlLmcuDQo+ID4gcW11IGRvbmUgaXJx
IG9uIGNwdTAgICAgICAgICAgICAgICAgIHRocmVhZCBydW5uaW5nIG9uIGNwdTENCj4gPiANCj4g
PiBxbXVfZG9uZV90eCgpDQo+ID4gICAgaGFuZGxlIGdwZCBbMF0NCj4gPiAgICAgIG10dTNfcmVx
dV9jb21wbGV0ZSgpICAgICAgICBtdHUzX2dhZGdldF9lcF9kaXNhYmxlKCkNCj4gPiAgICAgICAg
dW5sb2NrIEBtdHUtPmxvY2sNCj4gPiAgICAgICAgICBnaXZlIGJhY2sgcmVxdWVzdCAgICAgICAg
IGxvY2sgQG10dS0+bG9jaw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtdHUzX2VwX2Rpc2FibGUoKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG10dTNfZ3BkX3JpbmdfZnJlZSgpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5sb2NrIEBtdHUtPmxvY2sNCj4gPiAgICAgICAgbG9jayBAbXR1LT5sb2Nr
DQo+ID4gICAgICBnZXQgbmV4dCBncGQgWzFdDQo+ID4gDQo+ID4gWzFdOiBnb3RvIFswXSB0byBo
YW5kbGUgbmV4dCBncGQsIGFuZCBuZXh0IGdwZCBtYXkgYmUgTlVMTC4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IA0K
PiBOQUNLLiBZb3Ugc3RpbGwgbWlzcyB0aGUgRml4ZXMgdGFnLg0KT2ssIEknbGwgYWRkIGl0LCB0
aGFua3MNCg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0K
