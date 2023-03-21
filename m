Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52DA6C29E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCUFeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUFeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:34:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA81C7E5;
        Mon, 20 Mar 2023 22:34:00 -0700 (PDT)
X-UUID: f83d0ae6c7a911edbd2e61cc88cc8f98-20230321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=B60lQ2Lw4aKnSa1DRnnxZqOW1rKlQS009mpLp7lm5F4=;
        b=FsNI3p0ynqKE13ppXseKX1kmdUTeeZA8WVaVN+Z99l0Z8E1AAJfqIkZrDSFaBc3bLkP3zzeKZbJ8TL/zHZzSrRRb+hReUNYEFSIEQOJl4t/89r+kYUR3DpF6wftL700Us64gCuvhGHGjWUyt9+3YfLbD5M4TKIL+iClZ4a6GYjk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e6cfa64e-def0-40ae-83e3-cae48dc65df7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:b001fd28-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: f83d0ae6c7a911edbd2e61cc88cc8f98-20230321
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 422781930; Tue, 21 Mar 2023 13:33:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 21 Mar 2023 13:33:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 21 Mar 2023 13:33:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf3XRcZ5EGK+Wils+nm/9cm8EoX/k7C6f00CMxtSsYsed3u7FUKUIPciXFvouo3s7h2HD6Zlr+FEHOUDJboJNekwwboQYS0N6xQ9JbR4qgvwSnhD0Y69Jl7PicOQwHU5TWqKZDjvl4j5iD9ACG3KTlom788SD4fjvVM8D5hGs0GTuVscH18kMc3i8TweWIcrp+s2gLzEaLNjwAb0BTCIK0nmmEIFu4oMCcjke2udQEXZuI8PKX13DZ5BtYoIYjfWWzU0W2bykz4RMxbUfSec0FF6BsrfZtGt0GEWHwwcEhGufErsMcOoTcmE6Pfce+r+eATv9rprdiDRc4XPla0+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B60lQ2Lw4aKnSa1DRnnxZqOW1rKlQS009mpLp7lm5F4=;
 b=iiaQW62wT8cFSvQuqwMM6gT0nKTv5OeugNdurzY8oEf3QHe3sIikYCprEQrQ9tk21WIu0V0yIdFEMXMwPB/tDhwWhZ0Q+UFf+/OoVpwywcAw6IKgxqB2YosTnMTP6C/JRu5gZmHEwVCPtXOt7+nVoEVP42c5QrOZVV4iiN5DjMUX7FTKIcZxCLeER7GIWjE3TYTDya0pdsnRhb4DianmDLMXtrTmEM9sTwLlJlrTB54JbW3c8He3GqF0xtwpSxads1GGZSD1FJaOHcUaKHNmRrhButE5w6oMbZ0OyQHL3Lh6mj1wsC6u0Bw/Yc9jZOaxjDgHLK6j9bYEbaXJI6dx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B60lQ2Lw4aKnSa1DRnnxZqOW1rKlQS009mpLp7lm5F4=;
 b=Qu+xMGqP6sBCT6MGWuXVDHwWDJeVSSHi3dNZuWjab7tQg01Oi1218osMhiwLvG4CLdFqzxsv4PlinflzhlR0FlqxPimzrJWaVLNU23CaR6AT0djNwfvbevqgRYioxPbBAZufoRnnAUVevx8WHWKjfUTBJQHtdp+uTEw6bA48ZG8=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by SEZPR03MB6644.apcprd03.prod.outlook.com (2603:1096:101:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:33:50 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:33:50 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v29 1/7] dt-bindings: mediatek: add ethdr definition for
 mt8195
Thread-Topic: [PATCH v29 1/7] dt-bindings: mediatek: add ethdr definition for
 mt8195
Thread-Index: AQHZGcrXQb/1V2Icz0ST2hH4Pb2de677rZiAgAA66wCAAYJcAIAAA1eAgAA4mYCAABzVgIABVIIAgAATFQCAAAmAAIAABASAgAABlQCABf+CAA==
Date:   Tue, 21 Mar 2023 05:33:50 +0000
Message-ID: <74dca3fa90d5cd78286281e2ced45842bee21f91.camel@mediatek.com>
References: <20221227081011.6426-1-nancy.lin@mediatek.com>
         <20221227081011.6426-2-nancy.lin@mediatek.com>
         <4aff6a7a3b606f26ec793192d9c75774276935e0.camel@mediatek.com>
         <2700bd6c-f00d-fa99-b730-2fcdf89089fa@linaro.org>
         <1d65e8b2de708db18b5f7a0faaa53834e1002d9f.camel@mediatek.com>
         <b04eb48e-c9aa-0404-33ec-bef623b8282f@linaro.org>
         <e5ceec9e-d51b-2aeb-1db7-b79b151bd44c@collabora.com>
         <0ebf187d-972e-4228-d8a0-8c0ce02f642d@linaro.org>
         <72cf6344a1c5942bff0872d05dce82b787b49b76.camel@mediatek.com>
         <4027714e-b4e8-953b-68e2-f74f7a7f0e8e@linaro.org>
         <fdd0a157-eedb-bf21-c632-79b02a4cd6b0@collabora.com>
         <5695b8e5ab8339764c646ee581529cb6cee04346.camel@mediatek.com>
         <34c758c0-cbbb-da11-6263-e7b084040ed6@collabora.com>
In-Reply-To: <34c758c0-cbbb-da11-6263-e7b084040ed6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|SEZPR03MB6644:EE_
x-ms-office365-filtering-correlation-id: fe3baa8d-bdc6-485a-bede-08db29cdd9d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tljLYhhPln5JaBPS+1b1Xyu+mHsMSc0mt+QH16dbuE1zYaAcL96+KNfacpURrY2VUvIuntS8fM4OrNn3pg6OSvfPFeIA82wZtIQVgCB5qJXTToI35HcBjkxIB8uA3q8nkxnG7tzQvElds41DiICdFAhwRuKQkXT88HXYGxvAj7FxGlKvsZQQQ61MjHcy8dC65wSthC8wD82HIZGUUPSp+dS/jm/9Y7drttlSE2D9c0o23RBaB6zvBOjhM47jw5iH0r5no21PhaiQInb3BR/RX98LLfivhWBtT5L2JT+l68/2FqHQ5yFm0jrHF5gazJmWIMKYr1eMRq5ULb0VasguvqlKRvMppg0LOa6InUY79BqLjwGzfZlVdEDrS9SMMyfEcRIklIP4NfPZQItCty9O9fzUhiU2JrEgblUGeWL0IL3QoCT2xyrHI15XSULNEYIV2k6LZLUeZsDe1CqlUOScCNDwrwx86qIJsTWWA4xgtOUQFmz/8zHeBvUPvU1RnziWqpGdKl7HXXZo/Y0takwP2p+eZmeK/O8obhM/CIw4AVxT0JNMO7fh8bekcpRNH+S9RLYaUFviE/AO7i3BSWqZAljETKTT9Qh2N4rPehLXDABjWJtD9ou36GRknqlPmLXubQf8+js4Rhd1rndRESC3/eK0ITROxgxuC9pK6bkR0HquOkwuscWSk0KTXb58NmYP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(2616005)(54906003)(83380400001)(86362001)(91956017)(38100700002)(38070700005)(122000001)(110136005)(8936002)(66446008)(4326008)(8676002)(64756008)(66556008)(36756003)(85182001)(66476007)(66946007)(2906002)(41300700001)(76116006)(5660300002)(53546011)(186003)(26005)(6486002)(6506007)(478600001)(6512007)(71200400001)(316002)(966005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?andtVUNnQjUxSGx3V2xkc1BycnQyajdGSHU5bkwyT0F6YkF5NnJZUzNSamJz?=
 =?utf-8?B?MURRaUV6bTNWZ01TQXFBUVBpZjBkV3RVR3ROVEFTT1QwZXpWRHpPTXBIeFNq?=
 =?utf-8?B?M2hyek10Und5eWJoK0ZMeUYwam9VSVVoN2owUXVtaVZvWU53MHppeDBHLytl?=
 =?utf-8?B?cDhnbEZwLzNmT2dHUExtYWxDYmw2UHJFeHFJZ1RrT2VqS1lWeEdCeEJ2LzBY?=
 =?utf-8?B?UG5zZC9rZkhiWVhtRlEwMU9GMThEM1RTdUZGaStmYUxabXMyc0hsZno1SXND?=
 =?utf-8?B?cEpXc2REaStKWFdUSWFpWmR3NmIwL3U3Snd6NUZybTZWUUh6T2VDOGJXMkxX?=
 =?utf-8?B?TFZYM0hQSVBienZHR0Q3bDhwTXc2d2hQcDJ2eVVmSDByajZ4QUd4ZTdtSHZx?=
 =?utf-8?B?Z2tleGZuUVgvUEJ5T1V3d0xNNUM2c1krYm02UkVRTFFCWlZuNHlPVk5HQTM2?=
 =?utf-8?B?Sko2ZnVsblNYR2E4MCtpYzNDM1pDWlZ6ZGd0a1BHQXZjUWlKNFZsUFBPNnpz?=
 =?utf-8?B?SFhYb0t4Zjc4NkljVjM3LzJlS1FKRjZOV3gvczFWWktML1RBL0U3ajBUS1d0?=
 =?utf-8?B?cG9TN08yV0drM1JTTHpWc1JrU1NoZHp0L3B6SFB2S1FZbU5DeEpXdkFxR3NQ?=
 =?utf-8?B?NmZqby8xRysxREtqV0xXVFZOZEdZbk9vOFhYbVl3ZFRsRDhWc2x4MU42VjNL?=
 =?utf-8?B?aEdUbE5VZ2hXY0JlenMxU250MUhrcjhDd3V5SjhlUE1rZE9DaGR6dWxoZTEr?=
 =?utf-8?B?Vlp5cDhnYzJwaEJoKzltdTRYL1RsdVVWNDZ4dFRuWkdweFA2T0VLYmIyNEsx?=
 =?utf-8?B?cDdyUkhJb1V0THM2akVjOXcwNU1pNzFWc01KV3NRbSs4TVZwaytkSVBNRGRD?=
 =?utf-8?B?OFdJaXJYeDhCQ3RRcVBMT1pza0s3ZkJoNWtoL3drS1ZCaGk2cDltOVI3ejJk?=
 =?utf-8?B?OFdDNlFad2Z4RUtud0F4NmhxRGxRYlUzL3hEeWU1eFhWUlgvcWU2NlRIY1RW?=
 =?utf-8?B?WGJUZklPVzE3K2srZ3BPbElOS2MzT2N5ZjMwRnl2N3NmQUVvQzNiWUpqS0lv?=
 =?utf-8?B?RS9sY2NKdW8yU2U2RXp0OEZNWWxFMjdXemc0aFNKcXozeG9aSlVEVldqalF0?=
 =?utf-8?B?Y2hxbDM1U0t1YmRBWkFINWhKRjlPRWsybGdud3prSzg5THJ3Z2twQkFPSGkx?=
 =?utf-8?B?UHo1NFAxZDM0NXlNOFc4WXNnRmVKcG5kc2NNNnFVRWczKy9KSk9DZUE5ZU5i?=
 =?utf-8?B?bmlxd0tBTjdzd2h4WnBxMnhKaTcrdzhHSysvZHlIeGJzaXp1eXlRUHdXS1ZX?=
 =?utf-8?B?eWdtWHlLUWF1WHFFdmhYRGtzVkpvbVVXZDcrSlh0ekRrZERrakRZY2NubUk1?=
 =?utf-8?B?SVh5c0Z5dVF3ZWpiSXM1bTBhb3loZDdzWWZuNW5NTzB4SVJubTdYTllTckZY?=
 =?utf-8?B?eWYwQThlWmhScEc2d0dsaEZQMGE1Uy9DUXR0K2wzUTZmTEFjLzdmNlhyS3lo?=
 =?utf-8?B?UjJ0c25hR2xCbG5oVkVzcUFaZ0poT2xTb2VhbHd2dWZDQkozVm02QkF3TmFm?=
 =?utf-8?B?eWI0OWZydGlNbVQwdzNsL2xGMXpMT3NnY2tWNDZ6V2s4TXFhbXJJUzVKZTlR?=
 =?utf-8?B?WDVyRXZOaEg5VGFMZHlHSXI3cXpURi8zQjlBZERoOVFmdTlyYkJZQXJ4c09V?=
 =?utf-8?B?SE9TUGRxd0t2NDNzYWUvU3gvODVRVHBDQ3U5SElXWHBBV3FsZkhHNVkyYmUz?=
 =?utf-8?B?UDA4RVZOWmx0dWtGNlExWWxKUnNkWWdYRk04WTg5TkNEdVZEY1lzU05CR2o1?=
 =?utf-8?B?a2VROTdoeUZYeWxaUEZFcVZtZ3A1eUYzL1VnVWJpQ012VDd2eHdVT3BHSlFz?=
 =?utf-8?B?bFRadDFid2dVU1lsUjFqRjRHUi9zRVV1TnZLY2ZON0dBeExnSUVvSWg0Unhh?=
 =?utf-8?B?MmxMQ1FKdkVuelZhVUhSY2tINStNSzFXdVZJdlI0emRIbjAzTmJ6RUdOY1or?=
 =?utf-8?B?S0Rwa1hyUkV6MEY2ZjlmUkJmakJaeHRxMzhGa2Z2R1R3YzN6d1I5Y25mdnBX?=
 =?utf-8?B?aGN6N1ZzZ3YyUnc2UHpKd2R2SWEvWU1FVG9Yb2pTbVNMK2V2eS9ja1hJZEJv?=
 =?utf-8?B?c3ZlbjdFTHloWXJtV09lcDZzUll1UXZlcFpNNUdIZE83VXdENVc2TnltQ2Ft?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2207BA0D6D02F94D9B19246B9A05FBCE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3baa8d-bdc6-485a-bede-08db29cdd9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 05:33:50.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4gvItNTGFwbGYqdFyYMsGIVMrdPT/lahy4H0TwZtNp3/Ko3KCPr27V3EGMwrwFJwXdlZgbWeuo5OMIE7CsWMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6644
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmdlbG8sDQoNClNvcnJ5IGZvciBsYXRlIHJlcGx5Lg0KDQpPbiBGcmksIDIwMjMtMDMt
MTcgYXQgMTA6NTggKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAxNy8wMy8yMyAxMDo1MiwgTmFuY3kgTGluICjmnpfmrKPonqIpIGhhIHNjcml0dG86DQo+ID4g
T24gRnJpLCAyMDIzLTAzLTE3IGF0IDEwOjM3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMTcvMDMvMjMgMTA6MDMsIEtyenlzenRvZiBLb3ps
b3dza2kgaGEgc2NyaXR0bzoNCj4gPiA+ID4gT24gMTcvMDMvMjAyMyAwODo1NSwgTmFuY3kgTGlu
ICjmnpfmrKPonqIpIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgMjAyMy0wMy0xNiBhdCAxMjoz
NiArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIDE2LzAz
LzIwMjMgMTA6NTMsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IEhlbGxvIEtyenlzenRvZiwgTmFuY3ksDQo+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiBTaW5jZSB0aGlzIHNlcmllcyBoYXMgcmVhY2hlZCB2MjksIGNhbiB3
ZSBwbGVhc2UgcmVhY2ggYW4NCj4gPiA+ID4gPiA+ID4gYWdyZWVtZW50DQo+ID4gPiA+ID4gPiA+
IG9uIHRoZSBiaW5kaW5ncw0KPiA+ID4gPiA+ID4gPiB0byB1c2UgaGVyZSwgc28gdGhhdCB3ZSBj
YW4gZ2V0IHRoaXMgZmluYWxseSB1cHN0cmVhbWVkPw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gSSB3aWxsIHB1dCBzb21lIGV4YW1wbGVzIHRvIHRyeSB0byBnZXQgdGhpcyBpc3N1ZQ0K
PiA+ID4gPiA+ID4gPiByZXNvbHZlZC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ICMj
IyBFeGFtcGxlIDE6IENvbnN0cmFpbiB0aGUgbnVtYmVyIG9mIEdDRSBlbnRyaWVzIHRvDQo+ID4g
PiA+ID4gPiA+ICpzZXZlbioNCj4gPiA+ID4gPiA+ID4gYXJyYXkNCj4gPiA+ID4gPiA+ID4gZWxl
bWVudHMgKDd4NCEpDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAgICAgIG1lZGlhdGVr
LGdjZS1jbGllbnQtcmVnOg0KPiA+ID4gPiA+ID4gPiAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS0NCj4gPiA+ID4gPiA+ID4gYXJyYXkNCj4gPiA+
ID4gPiA+ID4gICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4gPiA+ICAgICAgICBkZXNjcmlw
dGlvbjogVGhlIHJlZ2lzdGVyIG9mIGRpc3BsYXkgZnVuY3Rpb24NCj4gPiA+ID4gPiA+ID4gYmxv
Y2sgdG8NCj4gPiA+ID4gPiA+ID4gYmUgc2V0DQo+ID4gPiA+ID4gPiA+IGJ5IGdjZS4NCj4gPiA+
ID4gPiA+ID4gICAgICAgICAgVGhlcmUgYXJlIDQgYXJndW1lbnRzIGluIHRoaXMgcHJvcGVydHks
IGdjZQ0KPiA+ID4gPiA+ID4gPiBub2RlLA0KPiA+ID4gPiA+ID4gPiBzdWJzeXMgaWQsDQo+ID4g
PiA+ID4gPiA+IG9mZnNldCBhbmQNCj4gPiA+ID4gPiA+ID4gICAgICAgICAgcmVnaXN0ZXIgc2l6
ZS4gVGhlIHN1YnN5cyBpZCBpcyBkZWZpbmVkIGluIHRoZQ0KPiA+ID4gPiA+ID4gPiBnY2UNCj4g
PiA+ID4gPiA+ID4gaGVhZGVyIG9mDQo+ID4gPiA+ID4gPiA+IGVhY2ggY2hpcHMNCj4gPiA+ID4g
PiA+ID4gICAgICAgICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvPGNoaXA+LWdjZS5oLCBtYXBw
aW5nIHRvDQo+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiByZWdpc3RlciBvZiBkaXNw
bGF5DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgIGZ1bmN0aW9uIGJsb2NrLg0KPiA+ID4gPiA+ID4g
PiAgICAgICAgaXRlbXM6DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgIG1pbkl0ZW1zOiAyOA0KPiA+
ID4gPiA+ID4gPiAgICAgICAgICBtYXhJdGVtczogMjgNCj4gPiA+ID4gPiA+ID4gICAgICAgICAg
aXRlbXM6ICAgICAgICAgICAgICAgICAgICAgPC0tLS0tIHRoaXMgYmxvY2sNCj4gPiA+ID4gPiA+
ID4gZG9lc24ndA0KPiA+ID4gPiA+ID4gPiBzZWVtIHRvDQo+ID4gPiA+ID4gPiA+IGdldCBjaGVj
a2VkIDpcDQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhhbmRsZSBv
ZiBHQ0UNCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBHQ0Ugc3Vic3lz
IGlkDQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogcmVnaXN0ZXIgb2Zm
c2V0DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogcmVnaXN0ZXIgc2l6
ZQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGlzIGlzIHdoYXQgd2Ugd291bGQgbGlrZSB0
byBoYXZlIGJ1dCBpdCByZXF1aXJlcw0KPiA+ID4gPiA+ID4gZXhjZXB0aW9uIGluDQo+ID4gPiA+
ID4gPiBkdHNjaGVtYS4gVGh1czoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ICMjIyBFeGFtcGxlIDI6IERvbid0IGNhcmUgYWJvdXQg
Y29uc3RyYWluaW5nIHRoZSBudW1iZXINCj4gPiA+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiA+ID4g
YXJndW1lbnRzDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAgICAgIG1lZGlhdGVrLGdj
ZS1jbGllbnQtcmVnOg0KPiA+ID4gPiA+ID4gPiAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS0NCj4gPiA+ID4gPiA+ID4gYXJyYXkNCj4gPiA+ID4g
PiA+ID4gICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4gPiA+ICAgICAgICBkZXNjcmlwdGlv
bjogVGhlIHJlZ2lzdGVyIG9mIGRpc3BsYXkgZnVuY3Rpb24NCj4gPiA+ID4gPiA+ID4gYmxvY2sg
dG8NCj4gPiA+ID4gPiA+ID4gYmUgc2V0DQo+ID4gPiA+ID4gPiA+IGJ5IGdjZS4NCj4gPiA+ID4g
PiA+ID4gICAgICAgICAgVGhlcmUgYXJlIDQgYXJndW1lbnRzIGluIHRoaXMgcHJvcGVydHksIGdj
ZQ0KPiA+ID4gPiA+ID4gPiBub2RlLA0KPiA+ID4gPiA+ID4gPiBzdWJzeXMgaWQsDQo+ID4gPiA+
ID4gPiA+IG9mZnNldCBhbmQNCj4gPiA+ID4gPiA+ID4gICAgICAgICAgcmVnaXN0ZXIgc2l6ZS4g
VGhlIHN1YnN5cyBpZCBpcyBkZWZpbmVkIGluIHRoZQ0KPiA+ID4gPiA+ID4gPiBnY2UNCj4gPiA+
ID4gPiA+ID4gaGVhZGVyIG9mDQo+ID4gPiA+ID4gPiA+IGVhY2ggY2hpcHMNCj4gPiA+ID4gPiA+
ID4gICAgICAgICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvPGNoaXA+LWdjZS5oLCBtYXBwaW5n
IHRvDQo+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiByZWdpc3RlciBvZiBkaXNwbGF5
DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgIGZ1bmN0aW9uIGJsb2NrLg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiB1c2UgdGhpcy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQmVzdCByZWdh
cmRzLA0KPiA+ID4gPiA+ID4gS3J6eXN6dG9mDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSGkgS3J6eXN6dG9mLCBBbmdlbG8sDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhbmtz
IGZvciB0aGUgY29tbWVudC4NCj4gPiA+ID4gPiBUaGUgRXhhbXBsZSAyIGNhbiBwYXNzIGR0X2Jp
bmRpbmdfY2hlY2suDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQnV0IHRoZSBleGFtcGxlIGluIHRo
ZSBiaW5kaW5nIGhhcyA3IGl0ZW1zIFsxXSBhbmQgZHRzIFsyXS4NCj4gPiA+ID4gPiBEb2VzDQo+
ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gIm1heEl0ZW1zOiAxIiBhZmZlY3QgYW55IG90aGVyIHNj
aGVtYSBvciBkdHMgY2hlY2s/DQo+ID4gPiA+IA0KPiA+ID4gPiBBaCwgdGhlbiBpdCBzaG91bGQg
YmUgbWF4SXRlbXM6IDcsIG5vdCAxLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gS2VlcCBpbiBt
aW5kIGZvciB5b3VyIHYzMDoNCj4gPiA+IA0KPiA+ID4gbWF4SXRlbXM6IDcgd2lsbCBwYXNzIC0g
YnV0IG9ubHkgaWYgbWluSXRlbXMgaXMgKm5vdCogNyA6LSkNCj4gPiA+IA0KPiA+ID4gLT4gKHNv
LCBkbyBub3QgZGVjbGFyZSBtaW5JdGVtcywgYXMgZGVmYXVsdCBpcyAxKSA8LQ0KPiA+ID4gDQo+
ID4gPiBSZWdhcmRzLA0KPiA+ID4gQW5nZWxvDQo+ID4gPiANCj4gPiANCj4gPiBIaSBBbmdlbG8s
DQo+ID4gDQo+ID4gSSBzdGlsbCBoYXZlIG9uZSBtZXNzYWdlIFsxXSB3aGVuIHJ1bmluZyBkdF9i
aW5kaW5nX2NoZWNrIGZvcg0KPiA+ICJleGFtcGxlDQo+ID4gMiArIG1heEl0ZW1zOiA3IiBbMl0u
DQo+ID4gDQo+ID4gWzFdDQo+ID4gL3Byb2ovbXRrMTkzNDcvY3Jvcy9zcmMvdGhpcmRfcGFydHkv
a2VybmVsL3Y1LjEwL0RvY3VtZW50YXRpb24vZGV2aQ0KPiA+IGNldHINCj4gPiBlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGV0aGRyLmV4YW1wbGUuZHRiOg0KPiA+IGhkci1l
bmdpbmVAMWMxMTQwMDA6IG1lZGlhdGVrLGdjZS1jbGllbnQtcmVnOiBbWzQyOTQ5NjcyOTUsIDcs
DQo+ID4gMTYzODQsDQo+ID4gNDA5NiwgNDI5NDk2NzI5NSwgNywgMjA0ODAsIDQwOTYsIDQyOTQ5
NjcyOTUsIDcsIDI4NjcyLCA0MDk2LA0KPiA+IDQyOTQ5NjcyOTUsIDcsIDM2ODY0LCA0MDk2LCA0
Mjk0OTY3Mjk1LCA3LCA0MDk2MCwgNDA5NiwgNDI5NDk2NzI5NSwNCj4gPiA3LA0KPiA+IDQ1MDU2
LCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCA0OTE1MiwgNDA5Nl1dIGlzIHRvbyBzaG9ydA0KPiA+IA0K
PiA+IA0KPiA+IFsyXQ0KPiA+ICAgICBtZWRpYXRlayxnY2UtY2xpZW50LXJlZzoNCj4gPiAgICAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5DQo+
ID4gICAgICAgbWF4SXRlbXM6IDcNCj4gPiAgICAgICBkZXNjcmlwdGlvbjogVGhlIHJlZ2lzdGVy
IG9mIGRpc3BsYXkgZnVuY3Rpb24gYmxvY2sgdG8gYmUgc2V0DQo+ID4gYnkNCj4gPiBnY2UuDQo+
ID4gICAgICAgICBUaGVyZSBhcmUgNCBhcmd1bWVudHMgaW4gdGhpcyBwcm9wZXJ0eSwgZ2NlIG5v
ZGUsIHN1YnN5cw0KPiA+IGlkLA0KPiA+IG9mZnNldCBhbmQNCj4gPiAgICAgICAgIHJlZ2lzdGVy
IHNpemUuIFRoZSBzdWJzeXMgaWQgaXMgZGVmaW5lZCBpbiB0aGUgZ2NlIGhlYWRlcg0KPiA+IG9m
DQo+ID4gZWFjaCBjaGlwcw0KPiA+ICAgICAgICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvPGNo
aXA+LWdjZS5oLCBtYXBwaW5nIHRvIHRoZQ0KPiA+IHJlZ2lzdGVyIG9mDQo+ID4gZGlzcGxheQ0K
PiA+ICAgICAgICAgZnVuY3Rpb24gYmxvY2suDQo+ID4gDQo+IA0KPiBNYXliZSBJJ20gd3Jvbmcg
YWJvdXQgdGhlICJkbyBub3QgZGVjbGFyZSBtaW5JdGVtcyIuLi4gdHJ5IHdpdGgNCj4gDQo+IG1p
bkl0ZW1zOiAxDQo+IG1heEl0ZW1zOiA3DQo+IA0KPiANCj4gLi4uZG9lcyBpdCB3b3JrIG5vdz8N
Cj4gDQoNClllcywgSXQgd29ya3Mgd2VsbCB3aXRoICJleGFtcGxlMiArIG1pbkl0ZW1zOjEgKyBt
YXhJdGVtczogNyIgWzFdDQoNClsxXQ0KICBtZWRpYXRlayxnY2UtY2xpZW50LXJlZzoNCiAgICAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5DQogICAg
bWluSXRlbXM6IDENCiAgICBtYXhJdGVtczogNw0KICAgIGRlc2NyaXB0aW9uOiBUaGUgcmVnaXN0
ZXIgb2YgZGlzcGxheSBmdW5jdGlvbiBibG9jayB0byBiZSBzZXQgYnkNCmdjZS4NCiAgICAgIFRo
ZXJlIGFyZSA0IGFyZ3VtZW50cyBpbiB0aGlzIHByb3BlcnR5LCBnY2Ugbm9kZSwgc3Vic3lzIGlk
LA0Kb2Zmc2V0IGFuZA0KICAgICAgcmVnaXN0ZXIgc2l6ZS4gVGhlIHN1YnN5cyBpZCBpcyBkZWZp
bmVkIGluIHRoZSBnY2UgaGVhZGVyIG9mIGVhY2gNCmNoaXBzDQogICAgICBpbmNsdWRlL2R0LWJp
bmRpbmdzL2djZS88Y2hpcD4tZ2NlLmgsIG1hcHBpbmcgdG8gdGhlIHJlZ2lzdGVyIG9mDQpkaXNw
bGF5DQogICAgICBmdW5jdGlvbiBibG9jay4NCg0KUmVnYXJkcywNCk5hbmN5DQoNCg0KPiA+IFJl
Z2FyZHMsDQo+ID4gTmFuY3kNCj4gPiANCj4gPiANCj4gPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+
ID4gPiBLcnp5c3p0b2YNCj4gPiA+ID4gDQo+IA0KPiANCj4gDQo+IA0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
DQo=
