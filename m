Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B00700183
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjELH33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbjELH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:29:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC51733;
        Fri, 12 May 2023 00:29:16 -0700 (PDT)
X-UUID: b080b520f09611edb20a276fd37b9834-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wXtHsKLnGjhGU8wHR0oyMySpR00Yo0JEO+JlBOhjWAk=;
        b=KC/2lTFwc4T5hW2MRAnTGA859+I5C4jJOWugDIAFPj5pf57OKMQwuJ3rRPkrTGkLeRTGNpg6W/X8/mwUigrmcr4VdAojIQGi1WH/b9fuc6ul18+ZpiIgBgmNxAH+7lmccUjVkllqflP+3YjUElLFRcjvfMdsrYjubNjKwAqY+Qw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:6c3715b3-a525-44cf-a8b6-d37be329d908,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:b543a0c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b080b520f09611edb20a276fd37b9834-20230512
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1430886589; Fri, 12 May 2023 15:29:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:29:10 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 15:29:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7cTI1iTkdSQ22UZCCOruDTHThs1FKniPcZINw0g4uFulJ9mbe4irk6qVO5BSh3B869Lvt//LxBOOgUG4DhUBTHbLv2TiKHp+TeKpJKySyrM1mxfKC/jPH82OrUtlf36cx4jz9qeh0aBesadIpnBdNcV9xVEZlwyEAxpLDDhIKeB6g8DsMMzweaxJc9diSuyCsX0CegZ48zkoX6cZ5059+UKls5Kgxg6w57Eyuv/GgRU9H4iYFUpC+kaR3KlMBfsek9DOKozanIa/4QgizRGfrwdMFydNvP7fDoV2ZHD5l1iBhcjCpPX6Xpm/hG9e3+tQAjQ2gVJx7n9TQyDUlKAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXtHsKLnGjhGU8wHR0oyMySpR00Yo0JEO+JlBOhjWAk=;
 b=hiNqaLJeQqX5U1Hv1mboFNbUv0Dpw0eyPIsY8OCTpSgdbivno4nqJkn0bKGGSK+QR+NF3g0BsL8UQJlLnOJYfvAHaSC8wB8MPkeZc7gLtKNf9pA7iE8p2g9qGILuxtT5rLJSRtivkF2KlwTT/C1qiJzfS/TNMwIHcvitBlvW6pOq8n6CKO7RcNfQ5lRmLnYlTumZ+5wHJbQ2Fw9+v2loIz7bc8MNhFNUfybZ4vwkuX24gVv7f58BMfMwEjbBOrp/9BWfbFoq/Aavct7r2WRBmQrl1tp7rO4u15HpPOGyExkKh9nWlAyy2+q6rUt7Mbn+VqbridePQwFfi5xgKgE55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXtHsKLnGjhGU8wHR0oyMySpR00Yo0JEO+JlBOhjWAk=;
 b=cLJ5qD7e3TzoYAMldMufk6UnCG1M9gI7lgnw5FaAaSOcAnEyhVKjIRj7Pyz2j0QrrcRNytvZo+j2UYcR5TqQVoqdZZ/D0h2aWwGUicnEmjpzDjfLE4o6aoo+F5X5Bkqwk8BZfy56kK4hbJgcjq3YbsJtc32wHvT42IhX860KcnM=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 PUZPR03MB7061.apcprd03.prod.outlook.com (2603:1096:301:114::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21; Fri, 12 May 2023 07:29:07 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:29:07 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
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
Thread-Index: AQHZbeeL18MyQqxT3UGeJoMyfQvhiK8pMrMAgABGroCAAQUyAIAAAlyAgCvqHoA=
Date:   Fri, 12 May 2023 07:29:07 +0000
Message-ID: <5971aa3795bbe117c5efb9a9d0c8304b5ed1d77d.camel@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
         <20230413090735.4182-4-yi-de.wu@mediatek.com>
         <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
         <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
         <533a1a9b653cf63f1e5df7f95d1b23902809561d.camel@mediatek.com>
         <7256414b-5553-e025-334f-b8df48f40c31@linaro.org>
In-Reply-To: <7256414b-5553-e025-334f-b8df48f40c31@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|PUZPR03MB7061:EE_
x-ms-office365-filtering-correlation-id: f6e9c7bb-b874-4420-7c01-08db52ba924c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7/gerH0+kLcZpZhw3OUZrNjAG8fUG4iMkL65Rvc5AvRoVlhTRjB6v2fa8Jf6/yZGQ9rveOV4drFqefBAM/5dLI1xftt480rYP9G9D+1CNL07YkeidQriu7YuXdQR384I+hPzxMbGPtDuZ2a2XM6V1vjzaiU+eu5ugvMfeU/tFuDyvqMtGrXLSVGpy1LwgFWgrVWJ/LPtXv9UtbqQqPKgT8Ya0o9K1qB+Ikt8+tRDHRI1C/iqO4C+Qtjgqyp5FIB5NTAl0S2vKG25al4T5liOrseBu2ZFHdZI+5WXjK1S1NpBz3WnPJSBRrxzmvby7hZqu57s2v4I6/EHW2DlqX/SxWgCm6bCszQetpAsvCg+NmqP3ntEvZXmDnHIpZE/7Dx6e2gll5Zaz22JrWaEQYXkJ5qJRP5K8D8jVT+Xy5jyDEektkTFpZk77qssQvmgvMhOmnIh8vlutqaWvItrxkAFOZUemnd6Yd0ZM6YjMeZtzxhwC5iWVkA+7iWZG36URydMuhqgX/x0Xw6FeUoLFzBzS9SygVJbif6YD0M7TP4GyaJ+cqkYY7Ol4so9KfpCMPdMwzeuUUmOSLssItMEIYkk0SO5yVJJhHdcoL3vVbRWJUD7PvZ//eezzGQ6RzSUmu9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(53546011)(2616005)(83380400001)(2906002)(91956017)(186003)(71200400001)(316002)(4326008)(76116006)(66476007)(66556008)(66446008)(64756008)(41300700001)(66946007)(54906003)(110136005)(6486002)(7416002)(5660300002)(478600001)(26005)(6512007)(6506007)(107886003)(966005)(8676002)(8936002)(38100700002)(122000001)(38070700005)(36756003)(86362001)(921005)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xkQ2xKQU9SbXQxcGNqSCtZTmk4V1BRWmRRblBoeWExdUlRcmw0dXo3ZVhq?=
 =?utf-8?B?NTlNY3Y5VVg0eGFuR29rODdCM0N0YnRqNG0xZVVDcWNycmdsTGlmSE5XcS91?=
 =?utf-8?B?MG5aZWxxaWh1cW5uN3lXVE9UclUvUTlmTXl4ejRaVnZ1R1VKUXIyUnhuemh3?=
 =?utf-8?B?elhmcXBkTUlkdHFoN0pLYXpvc2UrVnFRZXlWczluVFVPZTBwS1VncG1zekd6?=
 =?utf-8?B?c1NyZEVSREtLZWVrZGtGVlpRMndhNUdNeDgvWVBYZ3Z0dmcvOFBFVVJZYjlh?=
 =?utf-8?B?TjZwakdlODMzSXg1U0dzYmFra0J1NjAvUjF1T3pWSFFYeTI2d25Lb252TzEw?=
 =?utf-8?B?b0g5dUZLSWdsVVZpVEN1Z0tscDN3bnh2ZVBEVU1TYnZMc2lOSk0zM2hiNU9G?=
 =?utf-8?B?YzZJVFRNc0pkWktQcVdEZGhXZTFqUnh6a05sRTYvQVlUcVF5SlA1TndwZmhr?=
 =?utf-8?B?QW80SldPTEJ6dzhBb3JLcTNQWkJzNjlYWllDNWRwak9rREcyVkh1eXp2ZCsy?=
 =?utf-8?B?SHFKRFh3bGxoWHpEVmdyeHExWG9yNytIUC8yK0wvTVZ4TUNuazRPVVk3SnZo?=
 =?utf-8?B?YzFhY1JPVi8xV0tBWW9WY1Nrano1anBhbUh5ckNWMWNrYkpFRWxER0ZEM0ha?=
 =?utf-8?B?Zm9wK1lxVEVUbHl2VFdmTks0ZVY1SHZtODhEYy90N2kxakVocVJaOEI4QUJK?=
 =?utf-8?B?OFhRcnNtS0xxK1UwbDNiTDgyMVZESmU3MEEzYWtHaXJZUDgyeHZMYnduZlFO?=
 =?utf-8?B?clY4RjJqa0FaYlpIbUhzcHMyV3ozYzYxcEtBMUUxc2QyZmw4N2pna2ZSVld5?=
 =?utf-8?B?Y2RFczBhaGdoZ0d6d0h0UStEYjBVSEh2a1FWU0tWb1VJa2QrUHl0UUJxSy9W?=
 =?utf-8?B?RG5SbFo3d1pxK0c1V1BIUURCb1JiYTZheE4reGpya0R1aHNuNEYra3hoM1BF?=
 =?utf-8?B?Mm9ybHNKcUhpWGZmTmdIYm5UMVJDSk4xWFArMmF5eVN6UjFjYWovbktrbCtE?=
 =?utf-8?B?dXhwRUNoNXZwaG9tWDRMZkhMM2dDSVFWLzZRTGo0VHUwZGhCcXBDdmQ5eUxi?=
 =?utf-8?B?cjQ1Mys5WlhiNjM3NE1sTnR4UDdZU0NVUjREWThBQ1ZrTndIeU0vTWpNZVdX?=
 =?utf-8?B?TnA3bnFBRXFKNnVZQWpJME5VaFpOKzJVRFZqOCt2MjJ3dUxIQjVEMlNQTU9k?=
 =?utf-8?B?WFpuWmRUZTY1eXdSKzM4Yzd0QU5MRmsrQ1gxUTN5TUxjaDg4UCtNNVdlYVZm?=
 =?utf-8?B?c1dBQzI5S01XaVp4OW1aeEI4a0ovMUhtYlhaeEpGZVpseTJBTlN1L1ZsTWZM?=
 =?utf-8?B?M2VlMTdtbm1NdW55N0QxY2RFdmErWXh1akRqbXE1S0FvZ3pETDg1d0NxVW1G?=
 =?utf-8?B?Z3h3WDdjcnNDWUZHL25kdDNlU0xSYnkzdWhka2hwbkVDSWp6dmZkcVFwTVpK?=
 =?utf-8?B?d0FBMUI5RmVyOGJ4QUw2RVcwZjEyQWFKUjFlcXJRUmZIeEcvM2Rzd1JGZVdz?=
 =?utf-8?B?NlBrd3ppamdNc3V4Vk10N3Z0Y3FaYXpzeFV1N1crN3FzdytSUE1pY0tqUDRG?=
 =?utf-8?B?OFQ2U09Oc3ppVzAzRis2L1dTY09UT2MwL25KTHpRVnAvbDE4dGpCb1M1SjZG?=
 =?utf-8?B?aWJjZHBPNFdaUUZQRzREZkc5M0dwazlWcFo4V3phNFpKVGVja29LNEF3cmZj?=
 =?utf-8?B?aTBhYnJJVWFPb3RsdDQ5aldsU0tPVm9PS1JUYS94QkRYV3U1cU0xQmU2bEU3?=
 =?utf-8?B?R2ZFdnVSakg1RWg0WlpVbmFZSjVpbWwyR0FrakFWdzFXaUhUUklwWkhKKzln?=
 =?utf-8?B?Q1lPTm01dmt3L0pnWXdTeUw2TW1wQXhuK0hoUS9DcURVdUFDM05CeGlXQkRO?=
 =?utf-8?B?biszSFhBcWhIZlpMdHlmQWZaOTdLRXdXQUcxVkluRFpYdnRkTEVYV2s3blpP?=
 =?utf-8?B?ek1xL09ZRXhEUGFQWmNtS3BDOUlxaWgyV0NKUlZSUndnNEMzYm9RSWJrSlZ5?=
 =?utf-8?B?aDMvUVFzSEpXZk15MHNENkVwMDg3SFhzcnlNUElMNUJEUHZ2NGE1L0YrRFBL?=
 =?utf-8?B?YzV6a1k5TlFHa25RZHpmcWcyaDcwaUpVcmNBS3FjaXV5cUt2V3I2bEpjWks3?=
 =?utf-8?B?akNmRFVwZ0ZwRTY5Z2dEd3dvVEM4cjlYdGtsZThGTXU1TjNEQ0REV1RpV1VM?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97057D9C58DC9345824A7B66CDE36C73@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e9c7bb-b874-4420-7c01-08db52ba924c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:29:07.4822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3czgAj90ygPt2/KdAk6rFdkwnI3Un/at+ARar84jyL55XYTHpX0LG2nhnDmpvlxziB7oD++kFkU/CR99Nv7YA==
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

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDEwOjUxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE0LzA0LzIwMjMgMTA6NDMsIFlpLURlIFd1ICjlkLPk
uIDlvrcpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wNC0xMyBhdCAxOTowOCArMDIwMCwgTWF0
dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4geW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBPbiAxMy8wNC8yMDIzIDE0OjU1LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0K
PiA+ID4gPiBPbiAxMy8wNC8yMDIzIDExOjA3LCBZaS1EZSBXdSB3cm90ZToNCj4gPiA+ID4gPiBG
cm9tOiAiWWluZ3NoaXVhbiBQYW4iIDx5aW5nc2hpdWFuLnBhbkBtZWRpYXRlay5jb20+DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gR2VuaWVab25lIGlzIE1lZGlhVGVrIHByb3ByaWV0YXJ5IGh5cGVy
dmlzb3Igc29sdXRpb24sIGFuZCBpdA0KPiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gcnVubmluZw0K
PiA+ID4gPiA+IGluIEVMMiBzdGFuZCBhbG9uZSBhcyBhIHR5cGUtSSBoeXBlcnZpc29yLiBUaGlz
IHBhdGNoIGV4cG9ydHMNCj4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gc2V0IG9mDQo+ID4gPiA+ID4g
aW9jdGwgaW50ZXJmYWNlcyBmb3IgdXNlcnNwYWNlIFZNTSAoZS5nLiwgY3Jvc3ZtKSB0byBvcGVy
YXRlDQo+ID4gPiA+ID4gZ3Vlc3QgVk1zDQo+ID4gPiA+ID4gbGlmZWN5Y2xlIChjcmVhdGlvbiwg
cnVubmluZywgYW5kIGRlc3Ryb3kpIG9uIEdlbmllWm9uZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBZaW5nc2hpdWFuIFBhbiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlpLURlIFd1IDx5aS1kZS53dUBtZWRpYXRl
ay5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gICBhcmNoL2FybTY0L2luY2x1ZGUvdWFw
aS9hc20vZ3p2bV9hcmNoLmggICAgICAgfCAgNzkgKysrKw0KPiA+ID4gPiA+ICAgZHJpdmVycy9z
b2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gPiA+ID4gPiAg
IGRyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArDQo+
ID4gPiA+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay92aXJ0L2dlbmllem9uZS9LY29uZmlnICAg
fCAgMTcgKw0KPiA+ID4gPiANCj4gPiA+ID4gSHlwZXJ2aXNvciBkcml2ZXJzIGRvIG5vdCBnbyB0
byBzb2MuIFN0b3Agc2hvdmluZyB0aGVyZQ0KPiA+ID4gPiBldmVyeXRoaW5nDQo+ID4gPiA+IGZy
b20NCj4gPiA+ID4geW91ciBkb3duc3RyZWFtLiBGaW5kIGFwcHJvcHJpYXRlIGRpcmVjdG9yeSwg
ZS5nLiBtYXliZQ0KPiA+ID4gPiBkcml2ZXJzL3ZpcnQuDQo+ID4gPiANCj4gPiA+IEFja2VkLCB3
aGF0IGlzIHRoZSByZWFzb24geW91IHdhbnQgdG8gYWRkIHRoaXMgdG8gZHJpdmVycy9zb2MNCj4g
PiA+IGluc3RlYWQNCj4gPiA+IG9mDQo+ID4gPiBkcml2ZXJzL3ZpcnQ/DQo+ID4gPiANCj4gPiA+
IFJlZ2FyZHMsDQo+ID4gPiBNYXR0aGlhcw0KPiA+ID4gDQo+ID4gDQo+ID4gTm90ZWQuIFdlIHdv
dWxkIHRha2UgeW91ciBhZHZpY2UgYW5kIG1vdmUgaXQgZnJvbQ0KPiA+IGRyaXZlcnMvc29jL21l
ZGlhdGVrL3ZpcnQgdG8gL2RyaXZlcnMvdmlydCBvbiBuZXh0IHZlcnNpb24uDQo+ID4gDQo+ID4g
VGhlIHJlYXNvbiB3ZSBwdXQgaXQgdW5kZXIgb3VyIHNvYy8gaXMgdGhhdCB0aGUgZHJ2ZXIgaXMg
aGlnaGx5DQo+ID4gcHJvcGlldGFyeSBmb3IgbWVkaWF0ZWsncyBwcm9kdWN0IGFuZCBmb3IgYWFy
Y2g2NCBvbmx5LiBNYXliZSBpdCdzDQo+ID4gbm90DQo+ID4gZ2VuZXJhbCBlbm91Z2ggdG8gcHV0
IGluIHVuZGVyIC9kcml2ZXJzL3ZpcnQuDQo+IA0KPiBJZiB2aXJ0IGZvbGtzIHJlamVjdCB0aGUg
ZHJpdmVyLCBiZWNhdXNlIGl0IGlzIGhpZ2hseSBwcm9wcmlldGFyeSwNCj4gdGhlbg0KPiBpdCBp
cyBub3Qgc3VpdGFibGUgZm9yIHNvYy9tZWRpYXRlayBlaXRoZXIuDQo+IA0KPiBZb3VyIGFyZ3Vt
ZW50IGlzIGFjdHVhbGx5IG5vdCBoZWxwaW5nIHlvdS4gSXQncyByYXRoZXIgYSBwcm9vZiB0aGF0
DQo+IHRoaXMNCj4gZHJpdmVyIG1pZ2h0IG5vdCBiZSBzdWl0YWJsZSBmb3IgTGludXgga2VybmVs
IGF0IGFsbC4NCj4gDQo+ID4gDQo+IA0KPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2FuZHJvaWQtcmV2aWV3Lmdvb2dsZXNvdXJjZS5jb20vYy9rZXJuZWwvY29tbW9uLyov
MjQ0NzU0Ny8xLi4yL2RyaXZlcnMvdmlydC9nZW5pZXpvbmUvZ3p2bS5oKmI5MV9fO0t5TSEhQ1RS
TktBOXdNZzBBUmJ3IWpKMEZSdl9zNmlMdWMxcnA0UlBBcGtrdEdwSWFyZjVxQVZFMF9EcTZYX0tD
cV8yODNLaDVES1c2amxNeURmYUhORnIxRGdsS3lSS3ExSmNFNFhUZFFqdzlYR3pfNFEkDQo+IA0K
PiBJIGRvbid0IHNlZSB0aGVyZSBhbnl0aGluZyBzdWdnZXN0aW5nIG1vdmluZyB0byBzb2MvbWVk
aWF0ZWsuIENvbW1lbnQNCj4gZnJvbSBUcmlsb2sgKCtDYykgc3VnZ2VzdHMgdGhhdCB5b3VyIGNv
ZGUgaXMgc2ltcGx5IG5vdCBwb3J0YWJsZS4NCj4gV3JpdGUNCj4gY29kZSB3aGljaCBpcyBwb3J0
YWJsZSBhbmQgcHJvcGVybHkgb3JnYW5pemVkLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCj4gDQoNCldlJ3ZlIGFscmVhZHkgbW92ZWQgbW9zdCBvZiBhbGwgd29ya3MgZnJvbQ0K
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvdmlydC9nZW5pZXpvbmUgdG8gZHJpdmVycy92aXJ0L2dlbmll
em9uZSBhbmQNCmFyY2gvYXJtNjQvZ2VuaWV6b25lIGZvciBnZW5lcmFsIGFuZCBhcmNoaXRlY3R1
cmUgZGVwZW5kZW50DQppbXBsZW1lbnRhdGlvbnMgcmVzcGVjdGl2ZWx5LiBBbmQgaG9wZWZ1bGx5
IHRoZSBjb2RlIGNvdWxkIGJlIHJldmlld2QNCm91dCB0aGVyZS4NCg==
