Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7F6FC920
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjEIOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjEIOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:35:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC41C3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:35:20 -0700 (PDT)
X-UUID: b67892a8ee7611ed9cb5633481061a41-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8v88UaHkz8aO0R8oc4cVMLU7u6Ldh7jfNGWAiW9jTFc=;
        b=eNHzlm4nGoN65klzQ6quSj/za0wbXsSK7hYlTSwp4pmsDrfJpd/PpJ+uZFIqDRkvtC6/aje+YZNHKZoZ8mO15BqKp0A+J77S1xvgqyUBtihDVXM4rZVCLcfpdDfE+ZAeWpJ/fIBO7FRExxWAu6tNimrqQuN1ps9P8RcObRo0qKY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:83960446-21e1-4994-889a-9868f26f0262,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:178d4d4,CLOUDID:330549c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b67892a8ee7611ed9cb5633481061a41-20230509
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 712049865; Tue, 09 May 2023 22:35:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 22:35:14 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 22:35:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXIdBUv4FIRT9JmE+BDFyUM666xAr+lHO+Ln5LMZMXN3CXeJfAvpuCaZ1rMZDzUipkkJ3RYJWdy4KVBeVnCBJNL8RoihHlcU4qDufZFjejVMs8kH6TjIUfa7NsjcIZKKVbDv3cxSPtOKRLRfYiHXUk4EXTvaRUq5gl45rPHlChepQMUp7Q15vMjMdBjpw2FwBxyGsUjGfuX2YSUKwdV75j+kT8U6xtPAbYCgpqceGiT5WJcXNI7TTjuELQqWfZ1OSJfVE3W15jNkxJlomL6FTvGwa/tGFWHjUQgAPPWLYj1TkDOWIImfRru19AHi1POP/Fig5PcEefasZCWgWdOeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v88UaHkz8aO0R8oc4cVMLU7u6Ldh7jfNGWAiW9jTFc=;
 b=FV5WGC2uJRxWpwAAuP6uctTWw2uOLExG3ALxs4hi1brsoAVUORd57CdvEyfq2NuPO9pifM/bCjjx+RBIdRkEtu4cXQnEVKgHQaFvm2UVH/+MmpuHOtzgTbKi9EZPZIcf2GvjA4V1ANupZQku1lOL46nHK1q3sWDCmZMhgdjPQktmGBGYSkDglVKJBKS3rTy14XvhAgLnLN2auMqpFVFSrAkzWfrz6s6Mw5wLJFC9Wu4NyK0ad1HBMvq1FduM5pr7TAnK9cF5cOEq9YAvGrcNHWlcZ/buFuE2ED8Fq8laO+WmyTleVPx2MVULEYnlw4B5Zf9sbUnqcPoymErwyfSBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v88UaHkz8aO0R8oc4cVMLU7u6Ldh7jfNGWAiW9jTFc=;
 b=P86glPC3TLgrN1hMabCBGP9PFToKSMq3qP2MWm3aLoSTTlN6YZ5r+E5mvaXSvro8JUsrQQjrQJSOuGi51GGz7pXwoesPs/YU1v6eJEA7b/R2V/YDp0ZHG2LwlH9ErFAvvADlA+FxHSpJqzVoyH06CoyIi73qPBcQm25Jlf9541k=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by KL1PR03MB5948.apcprd03.prod.outlook.com (2603:1096:820:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:35:11 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::66d9:2bd0:26ba:d9bb]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::66d9:2bd0:26ba:d9bb%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 14:35:11 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 00/11] MediaTek DDP GAMMA - 12-bit LUT support
Thread-Topic: [PATCH v3 00/11] MediaTek DDP GAMMA - 12-bit LUT support
Thread-Index: AQHZgBdlwcmOJ71eeUOm0LT0SEWvAK9SBrsA
Date:   Tue, 9 May 2023 14:35:11 +0000
Message-ID: <5b53273cd76cc2a6453c2c04036760ca5e776def.camel@mediatek.com>
References: <20230506123549.101727-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230506123549.101727-1-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|KL1PR03MB5948:EE_
x-ms-office365-filtering-correlation-id: 0da024d1-92da-4e24-6664-08db509a986f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+KNbanquDNVsw0IJmhHAhytcSiNYCwrSygixhRIIiH2c3DJwkG9HQ71IaKCN8VXDGbcs+PXNF24PPWqBTtclM8PNVllerVAYvyaFhTUmleOe/oIsrmgKmk07weC6DFkU6KZBUsyV8BR8jOlEqbNKU6tbN5Uc9GMT6BqRG6idqkt8mtTl4Pzr87le74noyiW7cbs1+swq6TmBzDK+TUWA2eYtjb2Csv6CZguYIvklY661XADjyq9lZIZ5wPMRy7K9L4qAKwU+QOy/9lzF6e8nJdRXJuFVtfeqVScfgOGzrlpbHOd+b8f0w9zuTFLQIGxQzCqN7sdNHU/pDef3sWALAkdT5wxErAdCIMfTiO81p7MPYrWuIk7N/Td7ONuUilIG7UW0O1IcrryWMwmibTa/dve02Z8/vD31NuNfMDbKrvAMHF+W70hKEfyGfdaiP97pVS43cKxaGEA5n/ziPQ+YzJeotbmy75lwqmsUbpS02ZlogzUVClrM3iBvcFYJCxV9o/s9ihYMmzPoZumihXLfoVRj/R7mIXT+TrDihvDqKbGpzj4D+U9uhEC3/ei5bqgl/IDawZRdlLN7lgLAKxFy4js+tobMIUVHZv8/yWSYpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(6486002)(85182001)(36756003)(966005)(66476007)(186003)(38100700002)(316002)(6506007)(26005)(6512007)(66946007)(64756008)(86362001)(66556008)(66446008)(41300700001)(91956017)(4326008)(5660300002)(83380400001)(478600001)(2616005)(38070700005)(110136005)(7416002)(54906003)(71200400001)(76116006)(122000001)(8936002)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEZFUEhxZGJQUXY0Y3FCZGd1ZDhoZnJYMDZKcXNFTTVCdW83Nk8yQURpbjhj?=
 =?utf-8?B?WldZT2NZc01OYlk2cndWd1dmL0srUHo3bUMxUkh1amZRc1hwamt6MFF1ODVE?=
 =?utf-8?B?TjZZWC9GTURJWjRvSHMrWDZ0YTg3SVZ0VTFhenkyd3dNTEJOcGFHQlZmRlhT?=
 =?utf-8?B?dnNWOWhSZFZTTmVKVkVNMXpuOWl3RHROb2VVMWxrTUpieGlHUWQ3MGNQNnpj?=
 =?utf-8?B?di95ZnNYcS9xQTdoU3VmemtmSnNSVHp4WWdMSTZSN2l3dVFHb3BMNjZvRTZI?=
 =?utf-8?B?T21aMlREL2U3TmdEVVZiSlJWM29BaFpkdndKbUIwTVBsSW9Vam5sMkozc2tt?=
 =?utf-8?B?OCtEU1pqVGJWRDllM2R2VU1rdWhZTENGRGR4SVN5RHRxZFBiV1BqcWR3SzFW?=
 =?utf-8?B?R25Xcld2TzhrL045ajhNSFRING5oeFFwOWtaczZmTnVTMHpGVkcxYmxOZFU5?=
 =?utf-8?B?YkJuWUVFOEdFNUtUa0RBeDJldmhFNUUyQ1Zra2VuaEJjRGZzNnBpd3NWSzlJ?=
 =?utf-8?B?VVMvOHIrYTdtV0ZHRyt2WnNaNGlRSTVvVVByYlNKaEpXV1pkdFoxZkNJS2tR?=
 =?utf-8?B?cm1PcWtzeHovN0YzaTBmbk1BdWg5bjhmNEdNZ1VDd2pBMjQ1T3dONkJqM2RU?=
 =?utf-8?B?eFhoY0toTmFkeDRaeEJ4S2lpcFNBSER2UlpLaUpqa1I2WkQwZm0yNklRc1k3?=
 =?utf-8?B?NmpNaUJjQXJnOFlDdUFweFJJUnoybTJ2TEJOVVdFMngxNEtmRXROMFBSOVo5?=
 =?utf-8?B?eCtyN0hsVGJsZUtVTzNYaHpiMERaQUludzkreWR5YXhMa0VvbU91MS9uaW1r?=
 =?utf-8?B?YU10WGt1aDRQeGlmYmlNUHVKZzJOSG1XQ3dTaHhzQ1NZVmVLck1YUi9tMWR6?=
 =?utf-8?B?WkRjSGZBM2ZCNkpRMzB1UDJTZEh3STgyM0JGMEo3SkFKTUtDTzdjVllUYklD?=
 =?utf-8?B?QnBtU2ZQSlFSRE5FQ2poUGplR0tyYU9vL0Frd0V5V1NXa0cwUkxUN1NTbjJp?=
 =?utf-8?B?cDFPVXhYYWNVcVhidThPWVFwU3lWdmd1QXBidHdxMEpOcWs5emM1QkFJSmNB?=
 =?utf-8?B?K05MQ0N2L1lLQ2phdk9hVWI0NlN5dFduNTZOdktZNzJ2YVJVVFVwTDd6RUgy?=
 =?utf-8?B?S2JEN1o5UFIwclZTTGtXNnRuSVVoaHNPMW1WRWNOaXRSTTNnZlR0YVE0NDVT?=
 =?utf-8?B?SmI2d0JWTkQxQ3pUWGJscVZZalNCUjhEZWY1Y1JkM0c0bThVYytLM2Q4ODEz?=
 =?utf-8?B?KytHQXRhWmZ4dERVNkx1eHVSSHlkaVBBbS8xMlB0Rk4wcGlNNnRFRGJycjRL?=
 =?utf-8?B?N2dtbWVxbTJHT1Uwa3ZhK29rQ1NweEpGNXF4dTkxYlRvYjVmb202bHZ4RVVh?=
 =?utf-8?B?OUhaYmd0VHZkR2JZSnVDMlRvUUFBa1RQUEtmOVpBNUtPbUVWbmdoMU5yZ3Ru?=
 =?utf-8?B?cUtKVmhzMisvYUFuMTNSSlJST2dnZnUyWU0vSXZpUHR6dGNOTmZGTW9LMi9K?=
 =?utf-8?B?eWJpQnBBb2svOVE1WktjY2JBQmtRUW1Za2lnOENxeS9Kb1FRU1FwazBPT2h0?=
 =?utf-8?B?OEgxUjNRSytVWUNyRVlhcmkrS3BPS3N5MU5DMEVyZExzdWF3SjNkUm1yMW9X?=
 =?utf-8?B?ZGUyM0g0bGVCV1haRnplL1RSSUtKRDBwTUNxS3JRNCttM3NPMnNoUXNYNEtq?=
 =?utf-8?B?T2ZVeTYxSFhWMXdETHl4NFBFTkE4WUhlNDVYZDQvTThiYlArd1FOSktxRFkz?=
 =?utf-8?B?S3ZYMmlhSU5zNnUxYzhTZURjeTVqRjZWeE44ZGZvU2t2ZXFHM0lHN3huakdC?=
 =?utf-8?B?anRlSzlTMjYzRzd5a0ExOTJxM1lEQ2FiMXN0eDZWWVhQZzFwQlMwMDZuT1hj?=
 =?utf-8?B?bjg2a0NYRmNUcXZ4cDUzVW9wZW9UMXpSYmdHdkVlMFN6TUFHUUVIcmc3U3ZV?=
 =?utf-8?B?N1hzRnc5djJVSkM0NFI2R0tsa21FeHpnQzNlZ05jWHg4QVh3MkpRd0RmeTJE?=
 =?utf-8?B?d3cwYkRoUVBHMVlTWHlGem5jV2xXakdnQ1dnMnhyKzY4Z0d6ZWptZ2xxeWJh?=
 =?utf-8?B?MGp5a2xHczZ1WTlqd0hlQkt6TldUcGtmTkhHQkQ5anpFNU1JSnFFVVhJelFp?=
 =?utf-8?B?OThkUEFVQWd5YU1uQ0xscGN5RkZlckJ6b0VNOUlGR1RRVkZFOFh0NzNCNlky?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B91DF8B6A24A9D4E95E1AF830859B558@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da024d1-92da-4e24-6664-08db509a986f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 14:35:11.5648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZTeJXeYae/N+rJGm7AAAFG7BIAvdUoMyF3gdNEFE9GXaENnsyCmFXbB7EPWNcAEJBIUCct0Ev0uNdskDJbZBbkWUIHXn2A1YyCutQKCLas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpKdXN0IHJlbWluZGVyIHRoZXJlIGlzIGEgZHQtYmluZGluZyBwYXRjaCBb
MV0NClsxXSBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBnYW1tYSBjb21wYXRpYmxlIGZvciBt
dDgxOTUNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlh
dGVrL3BhdGNoLzIwMjIwOTEyMDEzMDA2LjI3NTQxLTMtamFzb24tamgubGluQG1lZGlhdGVrLmNv
bS8NCg0KT24gU2F0LCAyMDIzLTA1LTA2IGF0IDE0OjM1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAgLSBG
aXhlZCBpc3N1ZXMgZHVlIHRvIHZhcmlhYmxlcyByZW5hbWluZyBkdXJpbmcgY2xlYW51cCAob29w
cykNCj4gIC0gVGhpcyBpcyBhY3R1YWxseSB0aGUgcmlnaHQgc2VyaWVzLCBzaW5jZSB2MiB3YXMg
dGFrZW4gZnJvbSB0aGUNCj4gICAgd3Jvbmcga2VybmVsIHRyZWUuLi4uIDotKQ0KPiANCj4gQ2hh
bmdlcyBpbiB2MjoNCj4gIC0gQWRkZWQgZXhwbGljaXQgaW5jbHVzaW9uIG9mIGxpbnV4L2JpdGZp
ZWxkLmggaW4gcGF0Y2ggWzA2LzExXQ0KPiANCj4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZv
ciBHQU1NQSBJUCByZXF1aXJpbmcgYW5kL29yIHN1cHBvcnRpbmcNCj4gYSAxMi1iaXRzIExVVCB1
c2luZyBhIHNsaWdodGx5IGRpZmZlcmVudCByZWdpc3RlciBsYXlvdXQgYW5kDQo+IHByb2dyYW1t
aW5nDQo+IHNlcXVlbmNlIGZvciBtdWx0aXBsZSBMVVQgYmFua3M6IHRoaXMgSVAgdmVyc2lvbiBp
cyBjdXJyZW50bHkgZm91bmQNCj4gb24gYSBudW1iZXIgb2YgU29Dcywgbm90IG9ubHkgaW5jbHVk
aW5nIHRoZSBDaHJvbWVib29rL0lvVCBvcmllbnRlZA0KPiBLb21wYW5pbyAxMjAwLzEzODAgTVQ4
MTk1L01UODE5NVQsIGJ1dCBhbHNvIFNtYXJ0cGhvbmUgY2hpcHMgc3VjaCBhcw0KPiB0aGUgRGlt
ZW5zaXR5IDkyMDAgKE1UNjk4NSkgYW5kIG90aGVycy4NCj4gDQo+IFRoaXMgc2VyaWVzIHdhcyB0
ZXN0ZWQgb24gTVQ4MTk1LCBNVDgxOTIsIE1UODE3MywgTVQ2Nzk1Og0KPiAgKiBNVDY3OTUsIE1U
ODE5MiwgTVQ4MTczOiBObyByZWdyZXNzaW9uLCB3b3JrcyBmaW5lLg0KPiAgKiBNVDgxOTU6IENv
bG9yIGNvcnJlY3Rpb24gaXMgZmluYWxseSB3b3JraW5nIQ0KDQpUaGFua3MgZm9yIHlvdXIgaGVs
cCA6KQ0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IEFuZ2Vsb0dpb2FjY2hpbm8g
RGVsIFJlZ25vICgxMCk6DQo+ICAgZHJtL21lZGlhdGVrOiBnYW1tYTogUmVkdWNlIGluZGVudGF0
aW9uIGluIG10a19nYW1tYV9zZXRfY29tbW9uKCkNCj4gICBkcm0vbWVkaWF0ZWs6IGdhbW1hOiBT
dXBwb3J0IFNvQyBzcGVjaWZpYyBMVVQgc2l6ZQ0KPiAgIGRybS9tZWRpYXRlazogZ2FtbWE6IElt
cHJvdmUgYW5kIHNpbXBsaWZ5IEhXIExVVCBjYWxjdWxhdGlvbg0KPiAgIGRybS9tZWRpYXRlazog
Z2FtbWE6IEVuYWJsZSB0aGUgR2FtbWEgTFVUIHRhYmxlIG9ubHkgYWZ0ZXINCj4gcHJvZ3JhbW1p
bmcNCj4gICBkcm0vbWVkaWF0ZWs6IGdhbW1hOiBVc2UgYml0ZmllbGQgbWFjcm9zDQo+ICAgZHJt
L21lZGlhdGVrOiBnYW1tYTogU3VwcG9ydCBzcGVjaWZ5aW5nIG51bWJlciBvZiBiaXRzIHBlciBM
VVQNCj4gICAgIGNvbXBvbmVudA0KPiAgIGRybS9tZWRpYXRlazogZ2FtbWE6IFN1cHBvcnQgbXVs
dGktYmFuayBnYW1tYSBMVVQNCj4gICBkcm0vbWVkaWF0ZWs6IGdhbW1hOiBBZGQgc3VwcG9ydCBm
b3IgMTItYml0IExVVCBhbmQgTVQ4MTk1DQo+ICAgZHJtL21lZGlhdGVrOiBnYW1tYTogTWFrZSBz
dXJlIHJlbGF5IG1vZGUgaXMgZGlzYWJsZWQNCj4gICBkcm0vbWVkaWF0ZWs6IGdhbW1hOiBQcm9n
cmFtIGdhbW1hIExVVCB0eXBlIGZvciBkZXNjZW5kaW5nIG9yDQo+IHJpc2luZw0KPiANCj4gSmFz
b24tSkguTGluICgxKToNCj4gICBkcm0vbWVkaWF0ZWs6IGdhbW1hOiBBZGp1c3QgbXRrX2RybV9n
YW1tYV9zZXRfY29tbW9uIHBhcmFtZXRlcnMNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfYWFsLmMgICAgIHwgICAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfZHJ2LmggICAgIHwgICAzICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfZ2FtbWEuYyAgIHwgMTk3ICsrKysrKysrKysrKysrKysrLQ0KPiAtLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8ICAgNCArLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5oICAgICB8ICAgMSAtDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgICAxICsNCj4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgIDkgKw0KPiAgNyBm
aWxlcyBjaGFuZ2VkLCAxODEgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pDQo+IA0KPiAt
LQ0KPiAyLjQwLjENCj4gDQo+IA0K
