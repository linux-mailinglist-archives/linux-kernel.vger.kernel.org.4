Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D117001F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbjELHz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbjELHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:55:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2510E4A;
        Fri, 12 May 2023 00:55:27 -0700 (PDT)
X-UUID: 49d9e13af09a11ed9cb5633481061a41-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lKAU7KgMRHeU2BQHkh1BP7QFHppTMojtKLN/XQFwsU4=;
        b=iraQf3ZBzKLNkkeNK8pAtKbM9aq5BKSMdrLV4E+JlYLu5neCVCxl/AYJwtRlctpcqHjIi1qxOpL1mIOJdJwtWJWuE9Th7xqcBDHM2vlD8HYKDE4AymaH1JW885OGcSoe2GN5y1UDEuvci9Gfr4ig6/TEkMaFlgoPtDw67jR+vP4=;
X-CID-CACHE: Type:Local,Time:202305121529+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:8df04c96-cd12-4897-abb8-9c1f2a4fda51,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:1bf2f33a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 49d9e13af09a11ed9cb5633481061a41-20230512
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1026101701; Fri, 12 May 2023 15:54:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:54:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 15:54:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BayQzkLCKl/0AVt34U0gW5+oGyyV8kUxtk+8KXAg6cdutkwUEV6h/u3kn/ibnC13qnKBvF8NV19pPR4l6/+SpE4+eDHDGO2EU5iecnBpzvaq6gO9s7VZV08Scu6hQp+Y5fsmErImnsdXNRdCEAMnD6ziwuIoNC1us5hmeniT1g+HAwCLVfnG7k6DKYQA6CzFbir3wY1VknA2NkvGMw220cu6FAdvwV1yPvL3nBA96i3huiPYvNu/PWV2EfErWMqzatr6/znyg5TfqnY3R/AwMrxMsxyGtVNvh2AU6P1E7KaU3evOHMD6OItjooj7Hqj4xFx+8p35/8Nfr+sxNzGDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKAU7KgMRHeU2BQHkh1BP7QFHppTMojtKLN/XQFwsU4=;
 b=Vo06Os/akMbOxDC6xhutrfNLkbV1fwrFCsSmQ0jMZx9J1HxNBNAkjoqbkEG4VcLUmqRMeAmTRtDUmloWdpbTIKyZe5Bh5yd5JijmKf7Mb1iz5QZObnTELiscHXyoBsM8sAOrdHlKv3qPVe+Oplj39yRQ30gbBhel07LNv67mCmZo4mdcL7KFXQTNbS451eKtb/7Hfr5jBOO/RUi1pjs5rG2wF/1z8Ij3OCF7elkrtgPxZ9thK1cXPMSkl+AxsW2i/0eCNa7K3LzI8IBWD925x+rNvrQJ8CsazrSeKgYYdtZ/tMQAxeIbdt50LEH/6BjFWsuMGKRhPF6GV70HVZQhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKAU7KgMRHeU2BQHkh1BP7QFHppTMojtKLN/XQFwsU4=;
 b=MStU/IepfXTzghrKOOxyzCzCThU0LhyV7W5zgTAA5MsfWX5Sa9+M/2ruR35X4cK8KaPa8+0wzypBJxEf5hZhIMIi7MTXhTGEAfME6+0yyS9cNecKuAAZzj86a4Qn59lhjRfCrBQhkW+EERpnMPOh+94Ui7XErBqERSe8kXkVUy0=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Fri, 12 May 2023 07:53:27 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:53:27 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
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
Thread-Index: AQHZbeeL18MyQqxT3UGeJoMyfQvhiK8pMrMAgABGroCAAQUyAIAAIt2AgCvQaoA=
Date:   Fri, 12 May 2023 07:53:27 +0000
Message-ID: <2cff10cae88067f8bc952a57b231c75f0009a982.camel@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
         <20230413090735.4182-4-yi-de.wu@mediatek.com>
         <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
         <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
         <533a1a9b653cf63f1e5df7f95d1b23902809561d.camel@mediatek.com>
         <a157c5e7-d90c-5b99-42bb-ae02b6677732@collabora.com>
In-Reply-To: <a157c5e7-d90c-5b99-42bb-ae02b6677732@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB7765:EE_
x-ms-office365-filtering-correlation-id: 565de892-e6ba-4fa1-1a3f-08db52bdf840
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nnx/LbxPOl3M+duPFB7/+O9PeYU9y0JJxIKv0SAgv/eKe0wp/fa0l07gxlaJCmHPb3LAM6OeMdud06P6ENw8CV8qGBCy9tAE0xOW99HK0NkWfmOfN3rdtdMHzcfZ0xdZcIU7J4l/6HAFgAHZLGXUpHn3MFhYVmj+6Upd2yXvKNF2xO2nvCS9Znhh5BbwhV+dsvrL6ZBRV5SlxqDOKoFxuIlve50yy8DaypWw0UpU38U1FiCONQ2DRXJ1h8nfpfV4R0jPN6sks9qCsQ0VaBnFZyqjewIPWJknCgLGcCj3Y02dcH8w92bD4UKQHJ/5gPix3ihnT1/2B6FxxHErndJyw0Myc87EWkyvPv4hEqLHK6wiZdfWnexeiQGkchdkRImmP7RzFhuSDlOh4EpR8sofsNJa+rH7JTiP1AeHVQUJG3f9xEYXJLgARNt1owgPPHmNC3n14CldAgPWcXYK6nBP9W+xZH8X2iUa6ZUXHN1ir6NwlRTi37elawyHv+E1lNBZxmBH6+gWRemxv8cWvB72dvpGI9eVXhNnsmyAhpfKhiNUJdheHJacRYQidaW3xgh0Q0DdHA0vB7KDZbLXzvsm4OCSlXeIC37yZzj2B7yjWBzN9xGQAjYwkVbxsDLE1Bxp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(7416002)(85182001)(36756003)(8676002)(8936002)(38070700005)(5660300002)(2906002)(91956017)(2616005)(64756008)(66476007)(66446008)(66556008)(76116006)(66946007)(41300700001)(83380400001)(86362001)(316002)(4326008)(26005)(107886003)(53546011)(6512007)(110136005)(6506007)(186003)(478600001)(54906003)(122000001)(71200400001)(38100700002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjZqZ3pEVlR1Rklvd3hOYXhZb3ozdlhvZjBOdUFLWnU5YWVhWU1iTHF2eE51?=
 =?utf-8?B?S1Rzdml0OFFtbnhDTFgvYlFyYm9GZVY1bE94Zzh6RjF3bG1tZGU2VkN2WHVI?=
 =?utf-8?B?RWhLRnNpd1h1ODMwaitkTmRNNm05blJteFAwN241YStnV0s2SWRIdGgzSER0?=
 =?utf-8?B?dno1Q3V4SFBOVThVek80SE1jRk5IS0Jmd25GamNoNTNoUzJ4VSt6a0J5ZjdV?=
 =?utf-8?B?L0Q0RUQ3SGIyMUZuUWhOaXVIVk15RWVNUnVoWnlDaElKRG5KMEtRNkovV0Nq?=
 =?utf-8?B?eSt1WGo1QTJWYkVZRGV2blNYc1dJd1pheFRHUmJsNVBEYkNqdDZSc3ovRm1V?=
 =?utf-8?B?bDJnS05DcHR4TFEyK29WTzF3SENOSWZaeUMwNXlPTHQ5eG0xdzBERVlKLys0?=
 =?utf-8?B?cEp5bWVQS0RyU1YrVVBJVURKYkpWaUVXRU9YcHF3aWNwa0tNRTZUVVNWZnh3?=
 =?utf-8?B?S3ZtTXBnT0VUazNEa0I1WGtNSUVuUzA3UEFNTGo0T0lEN0xxVHk4SmNka1JN?=
 =?utf-8?B?dmZPNlU3VHpqaGJHNTNrb1FjOU1HK1dvSTJ0YktaZHF5dTFsV1hsYStZQUZT?=
 =?utf-8?B?eVpMcnR3UG5ucnVLajd0Q2IxY3JTWWxQK0FMbVhMUVpqVm1xLzhnMnJNY01m?=
 =?utf-8?B?Si9LSm4raUZ6SWtVdlpqd1FsNEJCcStmT2NIaS9rN3dVQkVCVVFLdTNEK1pR?=
 =?utf-8?B?Yzc4WlFsZGNFMUo3dG9sa3JmQWRzRzQ0T1BlSThSeW5LMjJjOExVQ05UV0ZK?=
 =?utf-8?B?L0lyOHJHc2ZGbURiSFhtRWsxd1gwQU0vUHhzZmpna3gxOGRqYjhtNytTV0Vh?=
 =?utf-8?B?b2lrT2Z5TzdTcjFONkljT0szb1NuUVgzaGwraUN4ZFdrck9XbzhFbWVZOCtN?=
 =?utf-8?B?WWlGZTZ1d1hlM3RRa1ZSbUpzNVIvenhxejJseUwydDR4MzhPR1VQOTNOdmlG?=
 =?utf-8?B?aG0ydGNGb05KMFMwR21oVW5jWThWbnhaVEVWdkpEVG9LT3FoclFSRTJsOEUv?=
 =?utf-8?B?RkVobnFaY3dsTmhHUXZTQzd4K2xIWFBYOVZtVlpNR1gxc3M5U0RZeVJKeUk5?=
 =?utf-8?B?RjFabzZ6bjE3OTdZOUJ0VlZsbHRUcG04Tzg1OXRJc0Rhb0dFdkpVWGhML2Zk?=
 =?utf-8?B?Z3RscFMyL1pWeTlHNFNtb3ZJQ1ZFYkxSaG15TklVVFcvMTlDY002YVN3K0dk?=
 =?utf-8?B?bnVRbnlaVFFQVE1KM013OFB6eXZ1THF6aXc3WjcyZVVZcW9WRUpPZ0M4dnJn?=
 =?utf-8?B?emV6cTVDNDdPUjU0dXFsZlo3Q3djVUVrREtyN3FZSTlRL2Vwc0J4eEU4Y1BH?=
 =?utf-8?B?RlFodkxucld0TStIb1NscUszaTFpWmMzUHc0N2pjaEpPS1lQRlp3Y1ZuanR3?=
 =?utf-8?B?UDhzZzFqb1pUN2FFY3g0VXNSckxHaUV2OG1rMlI2VnZ3Yk9KVFRuSkYvNmYw?=
 =?utf-8?B?U2YrUTg5OVNiZkJFYmdRWXByVjhlOWQrMDFhVTM4MzhZQTREMGFCNTR5ZjZS?=
 =?utf-8?B?SHZUYkhZSHRJRHN1eERyeW5xUHZBRkw0SVhHUEZiK2VnbHExRTMyeEpwbEMv?=
 =?utf-8?B?TDA3UGgvUXkyQzNReG82dHA1enNKTVdhTnliNkJSTFNMSkJkU2d5K2hIKzcz?=
 =?utf-8?B?NjJNMnZxa2dhbFNmOE1wMS9NRXcwRlh0Q0hPcFdNQXpFQThwSlJUYjEyLzJG?=
 =?utf-8?B?aVNXanI4VndBSDlPdDZQMjMrTTJIYnBGVGtua1UyeElwdlZlU1g4MmJrRXM2?=
 =?utf-8?B?N0cvZE8wb3ZCRTlURWYxbFdyRE8yOUxwRW4wQ2RBSVhFcHY1b0lvR2doVlI3?=
 =?utf-8?B?QmJYU1UyNWdzR2F6ZFRYVUZhOW54RWZnWjhmdXFSZWFqdngwZWIyTXRTVFF6?=
 =?utf-8?B?T2U1VXNRYWZOV0VYTmQ2OEVNNjEza3JNU1Zyc3d3VFI0WTJXZFNpbFNCS0lh?=
 =?utf-8?B?NEI1WXlYQS94bGxGbFloeWMrM2xhWDdHYU93UWl1UjNTazNKY09qaVRwS0xX?=
 =?utf-8?B?T05wejNHTEJ0WWh2dVFSOGEybjgzVS9tK3I2YldGaTNTY3c0VWhHK0lQaGJm?=
 =?utf-8?B?bDljLzVBQlkxU1NtRXYwZFJITVhTNnNVZXliWFYzeUFTOFdSSFdVNlRzeW1F?=
 =?utf-8?B?M2pIQWM0LzNMbEhIeHF5R09OUU9aVEFqd1pIZGlORGtiSm1xbWxMMnZ2eld4?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B1F01AC0927B042965F7C3530583038@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565de892-e6ba-4fa1-1a3f-08db52bdf840
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:53:27.0200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqTfzjQDpKpezGc8Oqe8gvnhSnv1ugsQeC0PcPMLkg9saWbbRCNlsgNONJt9OxIL9scpM5ZLJgEjXezRP2J5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDEyOjQ4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNC8wNC8yMyAxMDo0MywgWWktRGUgV3Ug
KOWQs+S4gOW+tykgaGEgc2NyaXR0bzoNCj4gPiBPbiBUaHUsIDIwMjMtMDQtMTMgYXQgMTk6MDgg
KzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwN
Cj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gT24gMTMvMDQvMjAyMyAxNDo1NSwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gPiA+ID4gT24gMTMvMDQvMjAyMyAxMTowNywgWWktRGUgV3Ugd3JvdGU6DQo+
ID4gPiA+ID4gRnJvbTogIllpbmdzaGl1YW4gUGFuIiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEdlbmllWm9uZSBpcyBNZWRpYVRlayBwcm9wcmll
dGFyeSBoeXBlcnZpc29yIHNvbHV0aW9uLCBhbmQgaXQNCj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+
IHJ1bm5pbmcNCj4gPiA+ID4gPiBpbiBFTDIgc3RhbmQgYWxvbmUgYXMgYSB0eXBlLUkgaHlwZXJ2
aXNvci4gVGhpcyBwYXRjaCBleHBvcnRzDQo+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+IHNldCBvZg0K
PiA+ID4gPiA+IGlvY3RsIGludGVyZmFjZXMgZm9yIHVzZXJzcGFjZSBWTU0gKGUuZy4sIGNyb3N2
bSkgdG8gb3BlcmF0ZQ0KPiA+ID4gPiA+IGd1ZXN0IFZNcw0KPiA+ID4gPiA+IGxpZmVjeWNsZSAo
Y3JlYXRpb24sIHJ1bm5pbmcsIGFuZCBkZXN0cm95KSBvbiBHZW5pZVpvbmUuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFu
QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaS1EZSBXdSA8eWktZGUu
d3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICAgIGFyY2gvYXJtNjQv
aW5jbHVkZS91YXBpL2FzbS9nenZtX2FyY2guaCAgICAgICB8ICA3OSArKysrDQo+ID4gPiA+ID4g
ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAyICsN
Cj4gPiA+ID4gPiAgICBkcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KPiA+ID4gPiA+ICAgIGRyaXZlcnMvc29jL21lZGlhdGVrL3ZpcnQvZ2VuaWV6
b25lL0tjb25maWcgICB8ICAxNyArDQo+ID4gPiA+IA0KPiA+ID4gPiBIeXBlcnZpc29yIGRyaXZl
cnMgZG8gbm90IGdvIHRvIHNvYy4gU3RvcCBzaG92aW5nIHRoZXJlDQo+ID4gPiA+IGV2ZXJ5dGhp
bmcNCj4gPiA+ID4gZnJvbQ0KPiA+ID4gPiB5b3VyIGRvd25zdHJlYW0uIEZpbmQgYXBwcm9wcmlh
dGUgZGlyZWN0b3J5LCBlLmcuIG1heWJlDQo+ID4gPiA+IGRyaXZlcnMvdmlydC4NCj4gPiA+IA0K
PiA+ID4gQWNrZWQsIHdoYXQgaXMgdGhlIHJlYXNvbiB5b3Ugd2FudCB0byBhZGQgdGhpcyB0byBk
cml2ZXJzL3NvYw0KPiA+ID4gaW5zdGVhZA0KPiA+ID4gb2YNCj4gPiA+IGRyaXZlcnMvdmlydD8N
Cj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IE1hdHRoaWFzDQo+ID4gPiANCj4gPiANCj4g
PiBOb3RlZC4gV2Ugd291bGQgdGFrZSB5b3VyIGFkdmljZSBhbmQgbW92ZSBpdCBmcm9tDQo+ID4g
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvdmlydCB0byAvZHJpdmVycy92aXJ0IG9uIG5leHQgdmVyc2lv
bi4NCj4gPiANCj4gPiBUaGUgcmVhc29uIHdlIHB1dCBpdCB1bmRlciBvdXIgc29jLyBpcyB0aGF0
IHRoZSBkcnZlciBpcyBoaWdobHkNCj4gPiBwcm9waWV0YXJ5IGZvciBtZWRpYXRlaydzIHByb2R1
Y3QgYW5kIGZvciBhYXJjaDY0IG9ubHkuIE1heWJlIGl0J3MNCj4gPiBub3QNCj4gPiBnZW5lcmFs
IGVub3VnaCB0byBwdXQgaW4gdW5kZXIgL2RyaXZlcnMvdmlydC4NCj4gDQo+IFRoaXMgaXMgdGhl
IHNhbWUgcmVhc29uIHdoeSBtZWRpYXRlay1kcm0gaXMgaW4gZHJpdmVycy9ncHUvZHJtLyBhbmQN
Cj4gdGhlIHNhbWUgd2h5DQo+IG1lZGlhdGVrLWNwdWZyZXEgaXMgaW4gZHJpdmVycy9jcHVmcmVx
Ly4NCj4gDQo+IEkga25vdyB0aGF0IHRoaXMgaXMgYSBNZWRpYVRlayBzcGVjaWZpYyBpbXBsZW1l
bnRhdGlvbiwgYnV0IGl0ICppcyogYQ0KPiBoeXBlcnZpc29yDQo+IGRyaXZlciwgaGVuY2UgaXQg
YmVsb25ncyB0byB0aGUgaHlwZXJ2aXNvciBkcml2ZXJzIGZvbGRlci4NCj4gSXQncyBub3QgZXZl
biBncmFudGVkIHRoYXQgdGhpcyB3aWxsIG5vdCBzdXBwb3J0IG90aGVyIE1lZGlhVGVrDQo+IGFy
Y2hpdGVjdHVyZXMgaW4NCj4gdGhlIGZ1dHVyZSwgYnV0IHRoYXQncyBub3QgYSBkaXNjdXNzaW9u
IHRvIGRvIHJpZ2h0IGhlcmUgYW5kIHJpZ2h0DQo+IG5vdywgYW5kIGl0J3MNCj4gYW55d2F5IGly
cmVsZXZhbnQgaW4gdGhpcyBtb21lbnQuDQo+IA0KPiBCeSB0aGUgd2F5LCBnb29kIGpvYiB3aXRo
IHVwc3RyZWFtaW5nIHlvdXIgZHJpdmVycyB0YXJnZXRpbmcgTWVkaWFUZWsNCj4gQW5kcm9pZCBT
VyENCj4gSSdtIGVudGh1c2lhc3QgdG8gc2VlIHRoYXQuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdl
bG8NCj4gDQoNClRoYW5rIHlvdSBBbmdlbG8sIHdlJ3ZlIGFscmVhZHkgc2VwYXJhdGVkIHRoZSBn
ZW5lcmFsIGFuZCBhcmNoaXRlY3R1cmUNCmRlcGVuZGVudCBpbXBsZW1lbnRhdGlvbnMgYXMgeW91
IHN1Z2dlc3RlZCBhbmQgZGVsaXZlcmVkIGluIHYyLg0K
