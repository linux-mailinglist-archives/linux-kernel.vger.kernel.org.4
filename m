Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735EC5EB78A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiI0CVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiI0CUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:20:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C2816A0;
        Mon, 26 Sep 2022 19:19:49 -0700 (PDT)
X-UUID: 26fd045651d2462f9e2635292ab2620f-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=W6CEKLq72AiAIWALMrbxD8ORLLx8Q9YPQptc6euU9yk=;
        b=tLESHiQNw53AH9hntzqbcc6Avhp6GNuf67cxBDh12vBl1B68U5EyLkNJOBLAU5BcYOe+Fw2q70kIeaMOAWYrwkLdxCvQlEe9tKzztdTIEAODsohQGbQh2KHGjIsxwMAXK19/dwMyeHJSO5l+zbX3uj/r/2t7/D1x3R2FzYN0/pk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:5b9cfe45-5c0d-4d1f-a15d-39a8118d4ccb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:e52f1b07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 26fd045651d2462f9e2635292ab2620f-20220927
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1241590199; Tue, 27 Sep 2022 10:19:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Sep 2022 10:19:35 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 27 Sep 2022 10:19:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3r56sjkfPSLbbrga0YV+UBnOmk9ZP9Hwkk/oNOXD5070TpwfjjUaEtyU+gRxJPSXNNktp8eRSPnCSONpPgKgRiOYqJnvOcRk2W6iAgKHZyutxen/SVwlwANC3XKNNOFIvArp49B5voxZcDgfhrfpKSYK7T0HGFN7GxjmtqBEWpefTkO2vcWcUnE2Ne8udxGFF3jTmnLjCRK8KfiKkZA8l4jajQLpsjZq5sTnsBWtiYu/lZLJCvgbTufE4olhrSoGWycNbnbRP/Ye8iZ0thgLiOBK6uWkg36u99jfTHpbVSgqUjknlR+57bFaO4/JtJu4ecbZW+t72COXthYlMN37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6CEKLq72AiAIWALMrbxD8ORLLx8Q9YPQptc6euU9yk=;
 b=m0wch6Y+gn35qTH/fUe7b4VBY6ofrNXYzxQytqs+MDS88Xdpk5TQsr9V9/z2Nj1nlqz+WWbSUhmM2hyh5H5VzckCuLCPdB7yuDrFJegQdfm+/J7jchYz4HYrjiTpHX7mEW08O6oHPPABOsSW1a8KpOUMgKxC+DoTVe/J432LGbF8/Vgjo/7u9h+0ut1XpBokZekzXTuo9iqmiPBL1VB0sKq2uTOVqlJSzmcbO9fq/b6JAOCB7GDz3G7Zo7VJWvjK+5wFJzG9hqry3sm/JliN7ySJZqlal81PRIT6dafOzKXs9xmpdfD/HLEMxJ7OfDyCS+GrGZVt94AlT+dLw3aW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6CEKLq72AiAIWALMrbxD8ORLLx8Q9YPQptc6euU9yk=;
 b=D7oBhRRJuilxGTGjB9d9qiQ1MWshoh/WVMo42MG2F9FLCT0VskaE92uJXbgvurwbcbe5BQ2bno0d/gs77Ab5HOi0nTkGHLl/uNHd01yQewqjOf09V6jgAXx2MblEv15ZcAxVJcNKO3J8nfG7brRkycFf3LKVz1u//sKPmo9qkRU=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by TY0PR03MB6474.apcprd03.prod.outlook.com (2603:1096:400:1be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Tue, 27 Sep
 2022 02:19:33 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5676.014; Tue, 27 Sep 2022
 02:19:33 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Topic: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Index: AQHY0ZXZ3y9DZV7pPEGmFoiEPn734q3x1joAgAC1wgA=
Date:   Tue, 27 Sep 2022 02:19:32 +0000
Message-ID: <d71334b63427df73d01ff1b9fa4d2dec94ad9c95.camel@mediatek.com>
References: <20220926105047.19419-1-allen-kh.cheng@mediatek.com>
         <4d1e8600-f73d-8d2b-2e7a-1b75be7624bd@collabora.com>
In-Reply-To: <4d1e8600-f73d-8d2b-2e7a-1b75be7624bd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|TY0PR03MB6474:EE_
x-ms-office365-filtering-correlation-id: b2c7127a-8f17-4909-f9ad-08daa02eb755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nOyhwQ8lPgZ3d5C0rPC1woVmHhLv+50RFMzb5jGJwODeYMaXZ65qKGumm9R4NOUd/A0aTfkJAg6fpXCtlYErhqOIrArnvesRi3QLqhDYR7YYmQ6mjY0lJPpXZ6JAGY5YKVBE/0TsDXi4M9trPGb/iHcbgB9mJe0u2mNacvUA2f3fzbASswTIRNawLFtURVr//G2jVMRm61twf3GIwTwR0dDfLBAlSV7KBRWZT4/m9BQpu4UyDQhhjxShun985ZKfNJgrGX9UVuGmdx7/uIvvWNQtmgMyoH//4nkMerdlYQgpOGuRKZJrEJpgKY0GTljgz4r3jFAlk08l1SIPcuQbCd/CT8p45RiLmzRTiaEBmgedhwwlW/He8Kp46tNs0Z8L3m2/kakSTH7bG/gvys5EFgcP9FDCJ8SA1oagujpFYICGOEqM0m5nPxsA65nyQnq0U4d3F0pDQax8DX/w0jbgvWYGEJGCx+KiOqFW1NkdMHG6amY3SvQ8vLd+ehKGt9YnMrZFXDVrV/dCRNuhx0IwLen0fv/HiTobbvWp2hXCOFRNxv1HeEGxHd3f6BIs7F54aPjDOWTLeXPeRPuLfNSeeYJEeNmARWRoOH6K1v2P75hR3BJE7jjbCbRZBBRRxBmM3uuUfyaq05aivxUfI5Y4Oud0Y90jBPEkig1vwHHDnJYzJq7WUmzu+thXIFcyIO+93jPvXpaeanlQVdBU/qwx3YnacCq8uziOqg0OXEN8F70RbPcb9wWp67DcJ+5RpI8ir+AcmY5mXvRi8oKFBTWXwH78nyBZxXvoWXRRrqmH1idj514mKkoxlNGzASO5xSR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(122000001)(6512007)(26005)(6506007)(186003)(83380400001)(4326008)(5660300002)(2906002)(66946007)(8936002)(54906003)(6486002)(110136005)(66556008)(76116006)(66446008)(71200400001)(316002)(66476007)(478600001)(2616005)(41300700001)(64756008)(8676002)(38070700005)(85182001)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTEzR1U5TE5IRU9uM3hkOGVIWmQrY0JkYWU4Q1AwWW1JcTdnbkNWVk1RbW5p?=
 =?utf-8?B?Yk9Dd2VjUjR4TlY0c2lCdmxDL3hvSVV2U2E1Nng4ZkE1Nk9IemIyeE5jcURI?=
 =?utf-8?B?T1FRT2ZKRk9xZUErQzVXWC9Fb3dtc2t3MDZueGY0UnV2eXNmaGFmLzZZOHl6?=
 =?utf-8?B?cWEwWEVNSW1WT29YaVVXRnYzU2tMZ3B5emF6cVZmaUVCNkRMT05KWk9tRFpH?=
 =?utf-8?B?b2g4V2MxVjUwM0F1T1hSZVJMcmUwaEJoZnA3empFVXNSdVR3VEVWdTJLOWpD?=
 =?utf-8?B?UVE2VSt4L2luRGhUbzNNMGdhVHNVYUJ5dThubnpycnUyb0xJS2w5dXBZazBD?=
 =?utf-8?B?L0JRYlJFemo3WXRUNHlSaS9RcTV5aXFseUlUYXlCWUlyUnBGMW92bldwaktD?=
 =?utf-8?B?SWtYSFI4czNxZUUvR1VnNUt0SXYyN0xLUDJLaExhQ0xIbTJvZ3ZoRUYwMW9i?=
 =?utf-8?B?WTNaSGl0TlVvZ0xRYU14aUNJTkI2Q0k4UEYwOGVXVTRjNm9HQm54RENMa3R0?=
 =?utf-8?B?U0JIUDJibEhmdTlia2I2UjErdTRWcGJGVU5zYWt4WUYvRHQweEY4WDZITGZv?=
 =?utf-8?B?b2NuMFZyOG00Y0ZIdjR0NGd4ZGlGVVpkUFlrOXl0WVpWWUZvZlFsZS9RbXNS?=
 =?utf-8?B?R3Z4MVNLZkxYZkIrQTg0clREYklTQ1pLejY5TEUrRys3VEZtWHczSkRjY2ow?=
 =?utf-8?B?UWQrbmtMZHpqUUhzVGlVd2hzamlrbzlxTXhGRlN0YklEeEVQRzZpaURYVVFr?=
 =?utf-8?B?dng3SUpMU0dvbldUUVVIQzBkQkp2ZVBaTEhTOFUwUGpxWkFTZlArWUlnNnNm?=
 =?utf-8?B?Zmd0Y0JmakpRNVIydERmbkVoSHZJK2UzbjhjL25wYk5sSkxWbXhvTXpNUENP?=
 =?utf-8?B?WWZFT1NRWGdDcFFEMjBhYkR4R3VoU1Bzai9LWGFVWFZ3RWZsYkx3RjMyblQ0?=
 =?utf-8?B?eDRIN1hYanJaMXJrR2tzQWxwS2NubTBXV3RrQXhBKzJFTHVFL2tXT3ZjVCtT?=
 =?utf-8?B?VjhndXpmbzhCWjJPUVhlNzlrNnBSS0lKcFFBNGprWVJIc3NzaytxN0dmcmZK?=
 =?utf-8?B?VUpZSzlTZ0EvY0UrTWhJOHMyRnlFWUwyV25Mb1BKb2hGNGhRbWIvY2RpTXZK?=
 =?utf-8?B?SFU1eHFTZUp5aUE5TjdjYVhZd3dMNStQTWdxWlFVTEJ6bEgrTU01MXZoTXYw?=
 =?utf-8?B?cjEyNlMxeUtPSFcyd1NqODQrakIwNTVJcjk3Y2hza094TnpvbnlXVVBFcHJt?=
 =?utf-8?B?V1F2NURjZGl4bWJuUlYyaFhRV3E4VmJTdkpFenpINDNWOU5GbXIyeUJnYjVX?=
 =?utf-8?B?S2k5RHhBNTFTT2paaGxEVzZ4WGIySUlIaUo3RXBjdlN2RUNBcmNSdXFOQjVL?=
 =?utf-8?B?Mkl0NmJBRWJNbXhHOHhDZ2k3Z3VxY3RFeEc3Szg3ZHZMUFJBR2JqNjMrTlhZ?=
 =?utf-8?B?MURVV2xkM1AxUW50anFNVnJZZ2V5UStremtISWVyMnNHTDBJZ3V6RW55MEZ6?=
 =?utf-8?B?SHBhZGxPcld1UW55Y29kUjYxUjc0Y2hzZ3NHbmJYcWlqVXJuVWo2alVtYVlX?=
 =?utf-8?B?U3ppWDl4WUs4WERKL095WEJZU2ZnZFdLYTBWL1FkOWI4amlEZ0ZRWmpXbWh5?=
 =?utf-8?B?ekhDaDBJWnU5SE5BY2hwZTdVZGZ5aXVUejM1SDY3ekF1ZmxHbllLS0ZIYTds?=
 =?utf-8?B?WVU2Um9TY1pxQjg4NGtCaTZZVGtqTEl3QnRhWUtxRHpXNjZVa0xLd2pib2ZS?=
 =?utf-8?B?VmhJZ2RiU0JBUFZNek1WNTl5cUxBSnlnUFBkdDZEUlJUUHkyaVk5Q0J5TWF4?=
 =?utf-8?B?SlN1R00vSHh3NUxzMTN4L1l3WDlTMnA5c1J0ZjJXZi9jVkhyMVNydmQ1QkU0?=
 =?utf-8?B?bVdCeWxaTEl5WFVQeXd0WS9VT0g3QXM2eHpKamZVVjhhdnJOTWJPbDA4aHFR?=
 =?utf-8?B?SE1Kd0tnOHZRRlhKcCtHdi85MGYwSXZ0T3UwZzJGcWtxVFQrTDAxeVFnbW04?=
 =?utf-8?B?T2FYL3l4NWZUWGtQeVNGWGVvU3BWYkpBT0tSUnBiaStNMG1ueXZ0Ym5CTE93?=
 =?utf-8?B?SC93bGYyUHRxUStPVG1ibWs4ejlvcUNYTTY0YnRJMDNUWVJhRVhkb2ZvOGlu?=
 =?utf-8?B?Q0xJRDBueGdxY1NJbVRzTFlkNEJuWG1MZHptcDN6NnplVnMxSVFFa2U1R2Fx?=
 =?utf-8?Q?1Y5cDiFFQgH6vbjbz/uyhuE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <334E9F4D83C9F44E9445DCC24A4FB6E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c7127a-8f17-4909-f9ad-08daa02eb755
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 02:19:33.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmMNx/wVeiF39jETbheR1lj3HMMM+WGunllwn07CZuPmpUETI+ukcdiDZ8Psh+TtCQoR75vi/Th9EiAmEZ6t5RgGb2JMEaIzdjy9HX8FIaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6474
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBNb24sIDIwMjItMDktMjYgYXQgMTc6MjkgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyNi8wOS8yMiAxMjo1MCwgQWxsZW4tS0gg
Q2hlbmcgaGEgc2NyaXR0bzoNCj4gPiBBZGQgdmNvZGVjIGxhdCBhbmQgY29yZSBub2RlcyBmb3Ig
bXQ4MTkyIFNvQy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbi1LSCBDaGVuZyA8YWxs
ZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFRlc3RlZC1ieTogQ2hlbi1ZdSBUc2FpIDx3
ZW5zdEBjaHJvbWl1bS5vcmc+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGluIHYxOg0KPiA+ICAgICog
UmVwbGFjZSBub2RlIG5hbWVzIHdpdGggdmlkZW8tY29kZWMNCj4gPiAgICAgIFtBbGxlbi1LSCBD
aGVuZyA8YWxsZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tPl0NCj4gPiAtLS0NCj4gPiAtLS0NCj4g
PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgfCA2MA0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYwIGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIu
ZHRzaQ0KPiA+IGluZGV4IDZiMjAzNzYxOTFhNy4uMjE0ZGZjNmIwZWQxIDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQo+ID4gQEAgLTE0NDksNiAr
MTQ0OSw2NiBAQA0KPiA+ICAgCQkJcG93ZXItZG9tYWlucyA9IDwmc3BtDQo+ID4gTVQ4MTkyX1BP
V0VSX0RPTUFJTl9JU1AyPjsNCj4gPiAgIAkJfTsNCj4gPiAgIA0KPiA+ICsJCXZjb2RlY19kZWM6
IHZpZGVvLWNvZGVjQDE2MDAwMDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxOTItdmNvZGVjLWRlYyI7DQo+ID4gKwkJCXJlZyA9IDwwIDB4MTYwMDAwMDAgMCAweDEwMDA+
Ow0KPiA+ICsJCQltZWRpYXRlayxzY3AgPSA8JnNjcD47DQo+ID4gKwkJCWlvbW11cyA9IDwmaW9t
bXUwIE00VV9QT1JUX0w0X1ZERUNfTUNfRVhUPjsNCj4gPiArCQkJZG1hLXJhbmdlcyA9IDwweDEg
MHgwIDB4MCAweDQwMDAwMDAwIDB4MA0KPiA+IDB4ZmZmMDAwMDA+Ow0KPiA+ICsJCQkjYWRkcmVz
cy1jZWxscyA9IDwyPjsNCj4gPiArCQkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKwkJCXJhbmdl
cyA9IDwwIDAgMCAweDE2MDAwMDAwIDAgMHgyNjAwMD47DQo+ID4gKw0KPiA+ICsJCQl2Y29kZWNf
bGF0OiB2aWRlby1jb2RlY0AxMDAwMCB7DQo+IA0KPiBBbGxlbiwgdGhpcyB3b24ndCB3b3JrIDot
KA0KPiBDaGVjayBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0
ZWssdmNvZGVjLXN1YmRldi0NCj4gZGVjb2Rlci55YW1sDQo+IC4uLnRoZSBzY2hlbWEgcmVxdWly
ZXMgdmNvZGVjLWxhdEBbMC05YS1mXSBhbmQgdmNvZGVjLWNvcmVAWzAtOWEtZl0uDQo+IA0KPiBJ
ZiB5b3Ugd2FudCB0byBjYWxsIHRoZW0gYWxsIHZpZGVvLWNvZGVjQGFkZHIsIHlvdSBoYXZlIHRv
IGFsc28gZml4DQo+IHRoZSBzY2hlbWEuDQo+IA0KPiBQLlMuOiBEaWQgeW91IHRyeSB0byBydW4g
YG1ha2UgZHRic19jaGVja2A/DQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNClNvcnJ5
LCBteSBiYWQuIEkgYWxzd2F5cyBydW4gYG1ha2UgZHRic19jaGVja2AgdG8gY29uZmlybSBkdGIg
d2l0aA0KYmluZGluZ3MuIEkganVzdCB0aGluayB3ZSBkaWRuJ3QgbGltaXQgbm9kZSBuYW1lcyBp
biBtdGstdm9kZWMNCmJpbmRpbmdzLiBJIHdpbGwgcGF5IGF0dGVudGlvbiBuZXh0IHRpbWUuDQoN
Cg0KU2luY2UgY3VycmVudGx5IHRoZSB2Y29kZWMgbGF0IGFuZCBjb3JlIG5vZGVzIGFyZSBhYnNl
bnQgZnJvbSB0aGUgbXRrDQpkdHMsIGRvIHlvdSB0aGluayB0aGUgY2hpbGQgbm9kZSBuYW1lIHNo
b3VsZCBiZSBjaGFuZ2VkIHRvIHNvbWV0aGluZw0KbW9yZSBnZW5lcmFsIChleDogdmlkZW8tY29k
ZWMpIGluIG1lZGlhdGVrLHZjb2RlYy1zdWJkZXYtZGVjb2Rlcg0KYmluZGluZ3M/DQoNClRoYW5r
cywNCkFsbGVuDQoNCg0KDQoNCg0K
