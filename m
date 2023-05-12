Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E709700187
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbjELH34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbjELH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:29:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC63D1733;
        Fri, 12 May 2023 00:29:43 -0700 (PDT)
X-UUID: bfb5d548f09611edb20a276fd37b9834-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pllTf2KhG5pgCr8Dz6R6Vgv7L9igJ1xUJY+ZKU+ltDM=;
        b=i4diqhxFQkPuJ3HXMa237c24HJcsHjf634p5xuzRblC/ZuCNRKlbBg2g6vBQFDsHCt5sFB0Md1o4tOai2mD47quFSelMt3i/S1IA2LpUzTxW8WpmmCFXWc8kEkFF9EmWOhvtMngKE4eCygJAmHqBJ5C2tAQpEvPhtS+BOOEQI7g=;
X-CID-CACHE: Type:Local,Time:202305121529+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:e297b577-cda0-463b-ab2d-e150ec0d2fa6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:84e5986b-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: bfb5d548f09611edb20a276fd37b9834-20230512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1942773497; Fri, 12 May 2023 15:29:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:29:35 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 15:29:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zyz5kFzfUKrBAcJG39jk9hMSMGH90kllLl1pJg0QH06eRtiZTx0R+SnV0H7hJlWovMZk5a7vS9sEm+bA7ArsYtV4gvwL1pMcNaHUBDCAQ2duGhKAGEL0Uco2vGnHP5gxR+hkhDeO1mtMoXcHZcNytiHyaVtC+huSuHitUG3xW6/E4ye14UNwWf9PRiH78T2lRn62Ts4cHKHz/YiH9OAwu4ysPth5Z75NFDiCMh/NssVVzMA01hfOKzRDYktBvbjozeDDRoUaGQap9PYhwPwv8qi8ConysZ1fiWy7B9fJNdHZN1YkgIjLqvYVVcUh0Vk/V9RoURSJwzhtfZA4xTBFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pllTf2KhG5pgCr8Dz6R6Vgv7L9igJ1xUJY+ZKU+ltDM=;
 b=dNuHykS+inP8a4ellSI+NGxMQ0mmfEo+nbXT0iuh/oYFpuXgCLDRpcqhAy0NRywqKNDEh1ksGXMH9ZD14Aj6YD7d7paw5I8Q02bP3yFaYlFVw7Qe62ijdH/0socFYFlYAfwoKtYx1qDjoDTTUCNq6yAA6hxhtwGRV8HifPGD6PPnz6tuNr3F9yUZQM78pg1AF42cIYNPfsh15yer319qdtgxIfIQiPdRuHaw7V5Em5Afs0T9rD0e684xUsPr4+D0B1HHZOd9nsZ7XZSkkoKSSpMG57R5d7qBzSu52aZ4glom9Y2bEv85Ui10rU3OWmCekVmgXYRqjEpSM2Z+TQZcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pllTf2KhG5pgCr8Dz6R6Vgv7L9igJ1xUJY+ZKU+ltDM=;
 b=r04FqeDKB1rmu5Jnbd3neQm8zhxth1hdiVEiJYs7pppRFp+jZJGPTHEol+9q3QjAPx7RcRoGRvIheXSssPeAEeUlmlxufwcBg1fNnC31u2yfOsXOnlLODilsgfCZBNslCSc7Gm4CC+bNRIBHRifOw5d1wVAh0oTOzwt9HsMVHzM=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 PUZPR03MB7061.apcprd03.prod.outlook.com (2603:1096:301:114::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21; Fri, 12 May 2023 07:29:33 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:29:33 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>
Subject: Re: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Thread-Topic: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Thread-Index: AQHZbeeL18MyQqxT3UGeJoMyfQvhiK8pMrMAgABGroCAAQUyAIAAAlyAgACNUQCAK1zsgA==
Date:   Fri, 12 May 2023 07:29:33 +0000
Message-ID: <00583dd78941a0952ef0f8ee332e462843861585.camel@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
         <20230413090735.4182-4-yi-de.wu@mediatek.com>
         <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
         <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
         <533a1a9b653cf63f1e5df7f95d1b23902809561d.camel@mediatek.com>
         <7256414b-5553-e025-334f-b8df48f40c31@linaro.org>
         <85b92732-5310-92ed-0d33-458dec906495@quicinc.com>
In-Reply-To: <85b92732-5310-92ed-0d33-458dec906495@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|PUZPR03MB7061:EE_
x-ms-office365-filtering-correlation-id: 275b6d9b-b63b-421d-83cf-08db52baa1a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1tpYfTOSlu2tO1rZhGnaaQNE6FZs50268gGk/Jyqa5seHU6ih9Y8VOTqMpKOL0TZD+Czxlm44uDkAjrFmCPr1ve28swsAk9dnxjZi0Gpv8heneJv1mvUXWOKNKCMK1jMDopTo+WJfhMJXX/vvzycfQCS1DbY3wK2wFwRKui8JVc4xOKK/iGmPwpmQNA6k7Ywkh3g7cG65+Y9kOFpZGXfIXA12wlz5BZLAJkHyoX4zx6Omx89ALZnQ7Xhw5rjQOO4FZ9dLdDYEdM+enSWjlC71woAY1LR5FSJGTbvmcFXT1gDCnrAk6RA37X8NJ6izuvj2Na3G8oBQCravW2E8XBMNYBB8rWgnfEdDQ60Ph5zmCGHpXPs+E2slQ5SUrDpIi0ZSWdk2/RtNtg0LNiKKioQtP3N9Plhr60sZBxtRX2ix+WefGieXpOWNE9QjM72X2MEj5I9ucG9GCks4/5+pFMc1iX5CsN5ChKz5NJGJhRCoc4K2voKN6HDgRQHSNB1kDynpV8sQ6duyroZOseEJ2QMe5NF84zkn/57xC7norYfQZ1/vpJk5miuJqvCHFYx1u47v6I7GnFInivK+9vC2izdq6QanV1ffelBT0TcUURBWJvW/H8++cQ559Fl1VcLIRY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(53546011)(2616005)(83380400001)(2906002)(91956017)(186003)(71200400001)(316002)(4326008)(76116006)(66476007)(66556008)(66446008)(64756008)(41300700001)(66946007)(54906003)(110136005)(6486002)(7416002)(5660300002)(478600001)(26005)(6512007)(6506007)(107886003)(966005)(8676002)(8936002)(38100700002)(122000001)(38070700005)(36756003)(86362001)(921005)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1ZXalRxMkJSV2U4Q1d6Vzc4Q0RxYTVmTUZsbm5wMC9lbDRiUlo3Yk5qbnMz?=
 =?utf-8?B?ZXNpL1hmWXpPRUgxUktnQkJiTWNMQUJhTlFVeWQ3bkYrM2R2dUY4SmNFeld2?=
 =?utf-8?B?M1JEVEFLWFRSZk14UVJYRXpnRXpkU2xmR3BWZStoRVNqQkxXWGFpMWVKcnpE?=
 =?utf-8?B?U3dzSnNMNk8xaWMyVzJoRTRoZzFkZTlHbnc2Wk15N2U2UDE0NGthVFhBNWFz?=
 =?utf-8?B?ejZYQzlWYXY0QThycjRkTDRrcGFiVnAvdW5HazU4MlcvdHpndE5tQy9oc1ov?=
 =?utf-8?B?UnBoYk5XcE8yZytrZFQxajFNTjJxQUpZTkxRaFByWUJadVIyRUVzKzB3UDdy?=
 =?utf-8?B?K1FHV3RkRTZuL09ibDVKVmx5NjUrRC9nMDhOQ1VXL3l1Z21IeGUydzZDYzdY?=
 =?utf-8?B?YjluUXZhRjFDbFU5NmpPS1hFRzh4cUZJeVlLYy9MS3lqa0ttdWJZVXVaMVd3?=
 =?utf-8?B?bXlQRDJVa2QzN2tFRVpSNS9GRHFSeDJHSGJLWDR6bVViS0lqRDdtM09Sdmxa?=
 =?utf-8?B?RzcxMGxTRFcrU3VrOUlXMDQ3U2pKSlI5S2ZmYUMzb05JQ1U3YU1pTmxRdmhS?=
 =?utf-8?B?bVRXZGl0b2JXNWx0ajEya2Y3OWF4VFJaMHRKQVREa0E2MHBUYVRGY0I3OTlY?=
 =?utf-8?B?eWIvRGdFMWRoUkpKMVFDc1dWRGdBcThYbVFaYTJ3aVlhZWJMMFpheXZCRW9H?=
 =?utf-8?B?NTYxc1FRVjRMbmRyRGlFdHVZazRXZkVrbW9QTjZSMFNla1VocnI3S0FoZ3NW?=
 =?utf-8?B?dCsza0VvUzJwSmdwN2lJUCtqaFpyazJjRTJCNlJQZ1hnKzNzcWFvL0JkQkdi?=
 =?utf-8?B?OHA4R0x1WmlzSlRjMmtKZVMxQ21kV3lFTHM0MVl6MXExdDRWeHJYM2pvcS9x?=
 =?utf-8?B?Tm9uNlBaZTJVV0FEMzhGUy84OTBxV1BtcC93TkVMekdoekF5QjF2dnZrMFpz?=
 =?utf-8?B?MHBzUjkvNys3R2NudUdnQkZoc2JzUTdNVVlJNGgxNEVSYTFyT05sS25WY0xI?=
 =?utf-8?B?TTRsOVdOd3NrRE92NWNwRnRya0JiSTdiNzJVTWxmSXJDYlZIOVB4SE1VVUlI?=
 =?utf-8?B?bDRTTUdiMEVENWNSSnFoUHluTEhpZTR0L3F5UEtkclRLUVc4NS9OZnJ3elFz?=
 =?utf-8?B?Sjk4ellBSkI4c1U3NXZ5OFNVMndJZ0RKVjZYU2NzYmZYY2N0UENVYVk1eSt1?=
 =?utf-8?B?dXBRS3pjbmttRDFBQW1BdFNodHNJZU95YUVOUzlNOEVLbGd0Y0JJbktLdUhO?=
 =?utf-8?B?UzZVQzRqaGdlc3JNSExESGYveEdQdlI5RDd6cDlGSHd5Y25HYVZVVDRJbzBS?=
 =?utf-8?B?MUhLT1VORFZZN1ErWDY2ZnVTWThiU0lsUE9oemd1YmhJWjM2YTdjU3BpdUVr?=
 =?utf-8?B?WEpTam1xRmo0eWxUL2dWUHYzdm82VlpLNXRmMlgzOFJRRmFlTUhBODlFN3Q4?=
 =?utf-8?B?ajczLzhjUEdwZDI1d0hDT3pYZG1pL0E4MC9KL2psODNUNVo0aGdVeDNXT1l5?=
 =?utf-8?B?TDgzYTVteGhTQnJRQzl4U1hFQ054UmViZHpPK2FzT2R0RDY5bkd1c0llUHlh?=
 =?utf-8?B?UWdHSXNnckoveFpOSmV1ck42SGtOcmlueHFEZU1wcUh6cWlvUFlZc2Y1YXRw?=
 =?utf-8?B?MnVjRG43aU1tUHZIZG5xKzJjdFpBY3Y5YXlleXUzMTlvVjBDZElGYXRjblZv?=
 =?utf-8?B?UkFCNlI1MGpmSGQrYy9DanVaOXRGblFuQXdNRDY2N1ZIcyt4NzdHeERycEFI?=
 =?utf-8?B?S0pWbHdPNk5zWDZtSTY5Z1J1eDVtUndjbW1LcjBqakdUYzZtL3ZvVERiZE93?=
 =?utf-8?B?TkEwL0FjNHJHZDY0WEd1TE1VN1loU2Z4TllPZmlUd21sZTd2SHZMWG5sMjVy?=
 =?utf-8?B?UXRGTmJITFBGQjMvZmt1SlBvQWd0RGdtNUE2T1pyWkZGcFVQMGliYmw2bW9x?=
 =?utf-8?B?TzhEb1FXMFZmWm5tT3VQNitmVUtvNlNoWVpmcVlSRnBhc2QvNksrZ1poVzA4?=
 =?utf-8?B?Ym92Y2xINzVIVi9EcFNDN0lTTlgvRk96OUx5Uk1hWlpHT0MweUprd1owM2d6?=
 =?utf-8?B?emkzenBiWHVkR2I3bUtUMXErRnljNzg1Rnd4eTQ3RTlUdm5kYU9lUlAzbkdW?=
 =?utf-8?B?Snlrai9xVGw5THFtb0drK1F1UWYyS3oyNXNHOEI1OXdJZncwNHFheWFmeXNN?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E43A82B7347B7F4188C57C8DACD36314@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275b6d9b-b63b-421d-83cf-08db52baa1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:29:33.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ca4OHV2ZX9OmdJk1+BraTuQexq0LU6iwguWhGI7O95aMKJsqv+65kbLKfhqXJX+Pyetgr8qHwaTDfR/acBfy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDEwOjE3IC0wNzAwLCBUcmlsb2sgU29uaSB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiA0LzE0LzIwMjMgMTo1MSBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3
cm90ZToNCj4gPiBPbiAxNC8wNC8yMDIzIDEwOjQzLCBZaS1EZSBXdSAo5ZCz5LiA5b63KSB3cm90
ZToNCj4gPiA+IE9uIFRodSwgMjAyMy0wNC0xMyBhdCAxOTowOCArMDIwMCwgTWF0dGhpYXMgQnJ1
Z2dlciB3cm90ZToNCj4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+ID4gdW50aWwNCj4gPiA+ID4geW91IGhh
dmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBPbiAxMy8wNC8yMDIzIDE0OjU1LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3Rl
Og0KPiA+ID4gPiA+IE9uIDEzLzA0LzIwMjMgMTE6MDcsIFlpLURlIFd1IHdyb3RlOg0KPiA+ID4g
PiA+ID4gRnJvbTogIllpbmdzaGl1YW4gUGFuIiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBHZW5pZVpvbmUgaXMgTWVkaWFUZWsgcHJvcHJp
ZXRhcnkgaHlwZXJ2aXNvciBzb2x1dGlvbiwgYW5kDQo+ID4gPiA+ID4gPiBpdCBpcw0KPiA+ID4g
PiA+ID4gcnVubmluZw0KPiA+ID4gPiA+ID4gaW4gRUwyIHN0YW5kIGFsb25lIGFzIGEgdHlwZS1J
IGh5cGVydmlzb3IuIFRoaXMgcGF0Y2gNCj4gPiA+ID4gPiA+IGV4cG9ydHMgYQ0KPiA+ID4gPiA+
ID4gc2V0IG9mDQo+ID4gPiA+ID4gPiBpb2N0bCBpbnRlcmZhY2VzIGZvciB1c2Vyc3BhY2UgVk1N
IChlLmcuLCBjcm9zdm0pIHRvDQo+ID4gPiA+ID4gPiBvcGVyYXRlDQo+ID4gPiA+ID4gPiBndWVz
dCBWTXMNCj4gPiA+ID4gPiA+IGxpZmVjeWNsZSAoY3JlYXRpb24sIHJ1bm5pbmcsIGFuZCBkZXN0
cm95KSBvbiBHZW5pZVpvbmUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFlpbmdzaGl1YW4gUGFuIDx5aW5nc2hpdWFuLnBhbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaS1EZSBXdSA8eWktZGUud3VAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgICBhcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20v
Z3p2bV9hcmNoLmggICAgICAgfCAgNzkgKysrKw0KPiA+ID4gPiA+ID4gICAgZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gPiA+ID4gPiA+ICAg
IGRyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArDQo+
ID4gPiA+ID4gPiAgICBkcml2ZXJzL3NvYy9tZWRpYXRlay92aXJ0L2dlbmllem9uZS9LY29uZmln
ICAgfCAgMTcgKw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEh5cGVydmlzb3IgZHJpdmVycyBkbyBu
b3QgZ28gdG8gc29jLiBTdG9wIHNob3ZpbmcgdGhlcmUNCj4gPiA+ID4gPiBldmVyeXRoaW5nDQo+
ID4gPiA+ID4gZnJvbQ0KPiA+ID4gPiA+IHlvdXIgZG93bnN0cmVhbS4gRmluZCBhcHByb3ByaWF0
ZSBkaXJlY3RvcnksIGUuZy4gbWF5YmUNCj4gPiA+ID4gPiBkcml2ZXJzL3ZpcnQuDQo+ID4gPiA+
IA0KPiA+ID4gPiBBY2tlZCwgd2hhdCBpcyB0aGUgcmVhc29uIHlvdSB3YW50IHRvIGFkZCB0aGlz
IHRvIGRyaXZlcnMvc29jDQo+ID4gPiA+IGluc3RlYWQNCj4gPiA+ID4gb2YNCj4gPiA+ID4gZHJp
dmVycy92aXJ0Pw0KPiA+ID4gPiANCj4gPiA+ID4gUmVnYXJkcywNCj4gPiA+ID4gTWF0dGhpYXMN
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IE5vdGVkLiBXZSB3b3VsZCB0YWtlIHlvdXIgYWR2aWNl
IGFuZCBtb3ZlIGl0IGZyb20NCj4gPiA+IGRyaXZlcnMvc29jL21lZGlhdGVrL3ZpcnQgdG8gL2Ry
aXZlcnMvdmlydCBvbiBuZXh0IHZlcnNpb24uDQo+ID4gPiANCj4gPiA+IFRoZSByZWFzb24gd2Ug
cHV0IGl0IHVuZGVyIG91ciBzb2MvIGlzIHRoYXQgdGhlIGRydmVyIGlzIGhpZ2hseQ0KPiA+ID4g
cHJvcGlldGFyeSBmb3IgbWVkaWF0ZWsncyBwcm9kdWN0IGFuZCBmb3IgYWFyY2g2NCBvbmx5LiBN
YXliZQ0KPiA+ID4gaXQncyBub3QNCj4gPiA+IGdlbmVyYWwgZW5vdWdoIHRvIHB1dCBpbiB1bmRl
ciAvZHJpdmVycy92aXJ0Lg0KPiA+IA0KPiA+IElmIHZpcnQgZm9sa3MgcmVqZWN0IHRoZSBkcml2
ZXIsIGJlY2F1c2UgaXQgaXMgaGlnaGx5IHByb3ByaWV0YXJ5LA0KPiA+IHRoZW4NCj4gPiBpdCBp
cyBub3Qgc3VpdGFibGUgZm9yIHNvYy9tZWRpYXRlayBlaXRoZXIuDQo+ID4gDQo+ID4gWW91ciBh
cmd1bWVudCBpcyBhY3R1YWxseSBub3QgaGVscGluZyB5b3UuIEl0J3MgcmF0aGVyIGEgcHJvb2Yg
dGhhdA0KPiA+IHRoaXMNCj4gPiBkcml2ZXIgbWlnaHQgbm90IGJlIHN1aXRhYmxlIGZvciBMaW51
eCBrZXJuZWwgYXQgYWxsLg0KPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9hbmRyb2lkLXJldmlldy5nb29nbGVzb3VyY2UuY29tL2Mv
a2VybmVsL2NvbW1vbi8qLzI0NDc1NDcvMS4uMi9kcml2ZXJzL3ZpcnQvZ2VuaWV6b25lL2d6dm0u
aCpiOTFfXztLeU0hIUNUUk5LQTl3TWcwQVJidyFnVjR6MG43RE5xLVF1WDY2T2xuMHcwZ3JLV1kz
a20xNGJNR1Z0di1rZVRmZU95Q1ZzVlFSWWZncUtQNFJXaUEzQmxnZmtnUzBPeXRPZjEyUHF1eFpz
OW8kDQo+ID4gDQo+ID4gSSBkb24ndCBzZWUgdGhlcmUgYW55dGhpbmcgc3VnZ2VzdGluZyBtb3Zp
bmcgdG8gc29jL21lZGlhdGVrLg0KPiA+IENvbW1lbnQNCj4gPiBmcm9tIFRyaWxvayAoK0NjKSBz
dWdnZXN0cyB0aGF0IHlvdXIgY29kZSBpcyBzaW1wbHkgbm90IHBvcnRhYmxlLg0KPiA+IFdyaXRl
DQo+ID4gY29kZSB3aGljaCBpcyBwb3J0YWJsZSBhbmQgcHJvcGVybHkgb3JnYW5pemVkLg0KPiAN
Cj4gVGhhbmtzIGZvciB0aGUgQ0MuIEkgZG9uJ3Qga25vdyBob3cgZGlmZmVyZW50IHRoZXNlIHBh
dGNoZXMgYXJlIGZyb20NCj4gdGhlDQo+IEFDSyBwb3N0LCBidXQgaWYgdGhleSBhcmUgc2ltaWxh
ciB0aGVuIEkgYW0gc3VycHJpc2VkIHRoYXQgcGF0Y2hlcyBvZg0KPiB0aGF0IHN0YXRlIGFyZSBw
b3N0ZWQgaGVyZSBzaW5jZSB0aGV5IHdpbGwgbmVlZCBsb3Qgb2Ygd29yayB0byBnZXQgaXQNCj4g
cmV2aWV3ZWQgaGVyZS4NCj4gDQo+IEFsc28sIGRvIHlvdSBwbGFuIHRvIG9wZW4tc291cmNlIHlv
dXIgaHlwZXJ2aXNvcj8gSSBhbSBub3Qgc3VyZSBpZg0KPiB0aGF0DQo+IGlzIHRoZSByZXF1aXJl
bWVudCBidXQgaXQgd2lsbCBiZSBnb29kIHRvIGtub3cgaWYgc29tZSB2ZXJzaW9uIG9mDQo+IHlv
dXINCj4gSHlwZXJ2aXNvciBpcyBvcGVuLXNvdXJjZWQgb3IgeW91IGhhdmUgcGxhbiBmb3IgdGhh
dC4NCj4gDQo+IC0tLVRyaWxvayBTb25pDQo+IA0KDQpUaGVyZSB3b3VsZCBiZSBzb21lIGRpZmZp
Y3VsdGllcyBmb3IgdXMgdG8gb3BlbiBzb3VyY2Ugb3VyIGh5cGVydmlzb3INCnJpZ2h0IG5vdy4g
QnV0IHdlIHdpbGwgdHJ5IG91ciB1dG1vc3QgdG8gYW5zd2VyIGFsbCB0aGUgcmVsYXRlZA0KcXVl
c3Rpb25zIHRvIG1ha2Ugb3VyIGRlc2lnbiBtb3JlIGNvbXByZWhlbnNpdmUgYW5kIHRyYW5zcGFy
ZW50IHRvIHRoZQ0KcHVibGljLg0K
