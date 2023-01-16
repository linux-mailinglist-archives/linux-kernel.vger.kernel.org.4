Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572BF66BA17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjAPJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjAPJRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:17:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76FF13D4D;
        Mon, 16 Jan 2023 01:16:58 -0800 (PST)
X-UUID: 84925da6957e11eda06fc9ecc4dadd91-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=z1e/e1824+WKAGPXw7RVk+Bcd6hVARsuB0n+PLfXi1M=;
        b=Sye0rVJJbeBP1Aj8HkjmXDMj9TBsFq+TFj5jVD59lIfl1Lx4GVryhnOuFDoHu7URBz4+1tg6InsThiLt+WC5PcXN6vM0IfGyCjRds4RKRqRFgtVTR0l1c4jmNfCL0IL9mLp1oOGRuZ46J3BLQtT+2THePy8s5MOdIuqiaVtsgRY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:1832865f-fc69-4b3b-940c-d7ac2d3f7214,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:1832865f-fc69-4b3b-940c-d7ac2d3f7214,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:922ac654-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230116160222SSXG88NK,BulkQuantity:20,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 84925da6957e11eda06fc9ecc4dadd91-20230116
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1949677436; Mon, 16 Jan 2023 17:16:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 17:16:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 16 Jan 2023 17:16:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB77VC30wegNFaahu7HzoZNHMyerhW2s/E9ssDD3qSaC6c0DYz+YBK1JWrt+vSMfT0OF6bF2hhrWgsX3KkvkJq6hPLYk5akZSHMLk0jicA0VEVdO2VaRji8q1NZmnJEQFfNyr5cTK2v8dECNI/ULOaqpKiHPOkxi4wZC5ilWk9rYSeQuF8/M9v7h1v7OiFTvLnco++azfsTi9XQvqg1jBkw+E3EDf7lELU226kUol/oCgUZMpHj9mZFKiZ6XNNZqXxhxBXEY7MzxlrU5MQcaWg94uk++tjrufNIXw8bpuKqw0eujDnrOE3t1IvR3J+yLPwX0woHgse0EuiNu6PwKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1e/e1824+WKAGPXw7RVk+Bcd6hVARsuB0n+PLfXi1M=;
 b=HRBxPIK6qEHJoc0m/luudAlTIzQsCmowrdu7W3KFnIkC7/SA38Txpu1xnGnDY8GAAZmI7QVfaquiJk992lS8BONVHAVu27YcTYdZqdjPlFCryZ7++2S/Lwfqte02NPjQyVFlCVnl4/UnDJhgoHowZv3eNqLbK6XDNbZmwvI/do7UC7btk1lqy908v7ZH2Za6rIqrXk5Hvx69KdI2iNA0Vhch3b4AmRtbXOBj7peFY9hthxcejtViryegKx8Zj8+Ig7140mSnC67Pmaxw1FezH03ls8TbEJAo3sGPIEC/eSwh82L9f9fDfK/Nq7NMl0X3ACLWmv7J1n7JweM3xoKGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1e/e1824+WKAGPXw7RVk+Bcd6hVARsuB0n+PLfXi1M=;
 b=rvofMvRNqENQ6NY7+g7USkfubZ12R6EURv7U/UVTWBDxDgYyNQUtk/ojXGjiNJ6lzT+k5hiNEItSmsdIbvDDLqZIYy+tWX0XnDQZGYvcfvPHAA4onN7hyB7eAHLl3ysUajxkSWBkO1QDLZ1OAWDwEheNAqqndryuNq9iLUYpNRY=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TY0PR03MB6728.apcprd03.prod.outlook.com (2603:1096:400:216::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Mon, 16 Jan 2023 09:16:50 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3%6]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 09:16:48 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        =?utf-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Thread-Topic: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Thread-Index: AQHZJxSslMi5KoPBoUSEhCSEsTrcmK6cAykAgASqhYCAAAcBgIAAE6uA
Date:   Mon, 16 Jan 2023 09:16:48 +0000
Message-ID: <3da13600844b8a6c3b788bdb26faa537d0287173.camel@mediatek.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
         <20230113060133.9394-2-yong.wu@mediatek.com>
         <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
         <796e7fb8619d114c63580e5c4289c59a57449843.camel@mediatek.com>
         <2e2a0c70-86d2-7ba1-c87c-aaaa9dd460b5@linaro.org>
In-Reply-To: <2e2a0c70-86d2-7ba1-c87c-aaaa9dd460b5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TY0PR03MB6728:EE_
x-ms-office365-filtering-correlation-id: 3befcf0d-fe6c-4769-f7af-08daf7a2659b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JrhfqPvACDb4SOsCdX7H0YhR8Jv5OKXfTBNNQESnQZnFD6GqRT3ZGqgtbiLdSyGNdWSewHoytBMdOlSWRfOnL/CzKHheLawla37B8WNIp+fPnbaKl4G3oJOskKzAa8xQwIyhdUUTujfVWU/EJGgK5fV0ihEzCR1ueF3eIfqTYKUp6fdMOpRSUK7YvSinZ3etFXgZjMnORDMz+XFFX28qO30r0oBfSx/pOnnhhsFF0KXLI3h2e1kt3YnvbI8/2Jc1pcBaC3tDkPETrm0Tq7wTpYebe4uRQccpM/c3hF7EiZb6oKtvm9TW+gLEEpsu6CaN7m87s4726gOvpPfnh3FWcdju7dBF2ADfkxF2QBTohT4NH7l52gBW2pf/Dpn8nVfVRQRCdQ+M1wttI1U1hmIoh8lYLJ3MF7+tMfjGKDARv1mmBGHJGySEvVlgstgnvfttB7s+K2stYtQ4IoDP6P/afvFHqRig2otkKbZDy6Ti+CwySjHbXicbN1GK2g2+V1usvXHokNer/9nhHgh/fg9ypzK8wAbzY+D97Jtv9XxRefDX0Q3RojO/CmT/SiEuITuuFzW853Nxv98fpiVEX5BPi05b8qI2Dh/CnCYrwPw2f8MuoOgXhWG9TRdY2J/fnfQHpQEtIOLIeiIVQPdvHrhHsdH33pNUfWWaOPsmcpPYn1GvM9JB2WlcKGuQoRqpPNrwh4MAxTjBgm/mgBEgw20RW+BoJcJ1ldlIf+WJwKtTFKT+EHNPo5SUz9kmzc3HJ29xKEWa8fRZF/tF82i5+87Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(53546011)(66556008)(66946007)(66476007)(41300700001)(2616005)(66446008)(76116006)(6512007)(26005)(91956017)(186003)(8676002)(6916009)(64756008)(4326008)(85182001)(36756003)(86362001)(83380400001)(5660300002)(8936002)(6486002)(478600001)(54906003)(71200400001)(6506007)(316002)(38100700002)(38070700005)(2906002)(7416002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkF3NTNRb1dDVDJoa3BVVG5sL2hzMzE5SUFDVEtwYmNjNFprYk80YlZzTFVp?=
 =?utf-8?B?U0YrV0FkeWFkaFkzZytiM3VsUDRBWDZhakRoOExjMlJRVVlJSGxZZW9XSm5Z?=
 =?utf-8?B?eDJ0UlhUNDNiTEVnUTBkQlN5d1l3eXNiSGMyaUdjUnlCR3FWcEczdzlkVWNN?=
 =?utf-8?B?b3ZCcUhsMXpQYjlwM0ZYN2h2MFhDNUttTWJLbllndHk5ZVVFTkE0bTRucjBl?=
 =?utf-8?B?TmtZR1VvN3plRGhqMWJoaFVjakkvdjVXdzRvV1Rad2xGU1FIWVEzUHJLOWd0?=
 =?utf-8?B?M1lveHI1Q0hET0pMaG5nbk1iRnZvd256SDJTMWcwS0ZjUjIwZm5ZdGljQ2o1?=
 =?utf-8?B?ZW1HNHUzb2Nqd09qZjdPZ0RnL25DeFNBRkY1TG84MHNGdnhPL2t2SHZtNkEv?=
 =?utf-8?B?QldrZzZwQWhPbjRJTURWTXpXT3dtUnhPR21WUHlJeXdONmpiSXkwUDNNMU1y?=
 =?utf-8?B?aXNJbG5PZnV0L29SY0VpZHlhOFdvTDMrN0FaUUxWczV6emRVL2xwRGZxaXFm?=
 =?utf-8?B?eTdQRzhvUUJldDBJRFlPbSs2c3o3SDhJVXIya2ZnSHAvbnNEQmY2MlUraEV2?=
 =?utf-8?B?QUNubkFQK1RsUEVDUFF2UVc1ZGRSdEVzWFZuVXFFY052em9WVTVrc1hYMkJ6?=
 =?utf-8?B?OCtobXIxS3hGMWxBbjVKMkxJS0QrREVRWHdqZXhCWE1hM2o1cXpZZm53b2N5?=
 =?utf-8?B?ZUE2anNUbnU2c0I1ekdDcTJ0MzFFS3lEeHY4b2FjRDJEWG4rYmVkK1dsT0JZ?=
 =?utf-8?B?MmlqTjJXeXkyTitjbkNFUndnaWFBb1AwaWRhVU45bzRNOHdlekwvSlcvdlJZ?=
 =?utf-8?B?azczcEtza0JDckR2WVZGUDRUWVUvUTN2SDVsbHY4QUdwZDFSbU1IREZzZXcx?=
 =?utf-8?B?N2ZMK3F2aXlScE0wTFJ2M3lRcDd5Tk9KLzVnV21RMklKL0NEWXgzaUs4d0h6?=
 =?utf-8?B?M1hlZkhWeDE3UGNjNmtsV2Y1OFVld2VQSEpwSk5JRWJCeGg1ZG5oWjc1K3Zn?=
 =?utf-8?B?bmlKOFNlTFo3ZEJkSHUwMGhGQ3BPWmljbkRyQmwrS1l4NHhOeVRqd2hySEg3?=
 =?utf-8?B?ZDJmZ1gySjcvcEZ6TVVseCsvMTZkeWNZYVhzMGFrbG5aOGY4VUlKaU1tbDEy?=
 =?utf-8?B?WW4xb0N1UFdPeGRRdmljaldQZmpUcVJMSnFCRi84blRKczZlTHBnTHBPWW5W?=
 =?utf-8?B?YXJOcFdxajM1RjZLQjI4YnVGWi8xTnFaL25XT0JXeXFBelFHaFZQTTllSVN3?=
 =?utf-8?B?ZCtWMWtCVlRYWG1aNHB4YWZVWHpsZXJZL0RqYks2S3lZSmRIYytvTkxkUGZv?=
 =?utf-8?B?RmlVWDVYVGt5clNqMGY5Y3pEMGdMQkFPdWE1dHBUczlDZEZxUHFEeUY5MG9v?=
 =?utf-8?B?VDd6cUltRU9BNi9meGRWS3ZEVnFkS0orYzJTd0VyNWRmN0lJVXZUQnhrUDQr?=
 =?utf-8?B?aUV6MzZCelg3dU16UCtpSmFLRnNUa1UrS3RhSUxCMjdWck1xdVpvd2hLS29K?=
 =?utf-8?B?MFdQbGFvUHZIY1dTUldMUFR6c3lmcGQ3dW1GQWRXUkgwaEJuLzM5ZXpabS9T?=
 =?utf-8?B?aWdzM3orTkFWMUJWRll4SXR2S1NFSStvV2R2NVY3cmFIWDR6MUJDbm80RWxE?=
 =?utf-8?B?Y3FKeU5iV0dpOEhWT05Zb25ZRmN1K01IL1BwUlRwN0lSWWVlVWFoUE1ZYkFG?=
 =?utf-8?B?QjZHUE1pYjk4UTdYZTVzNXBaNHJjcWhMeE9sYTRmakFMQXVmYjhuT2I1M2xG?=
 =?utf-8?B?RnIxcjNBMWwyRkFyMDRod1hZUFRnWFlIUDNvRFBxQ2VNVmUyNXh1MFJ4emxB?=
 =?utf-8?B?K1lhaDE4T3VoMzhNalU2eld1eG5TczJTa24wOXRsSk1rd2xNWW1OOXpOR0Q4?=
 =?utf-8?B?S2krVU1pdGpCL3ZhcXUrSU1SRnRmajFxeE51VldZNjhMZEozKzRCR25XU3dH?=
 =?utf-8?B?THpoRVhJcmVaNUdITkoxQ0ZXcDZhbjdhZ1lIMkMyazhBWG5ITU9zMWFzandr?=
 =?utf-8?B?bFhwSlEybzJuYzMvZnc4cExSc2JodVVla0pDT3pZcGZXZTJKMTlqY1AwNjBs?=
 =?utf-8?B?MFIwVUxxT1pDcVlJUjBPM3BaM2dXODdiKzlxa3l1alVmV1RYUUpHQzFWTE5I?=
 =?utf-8?B?bU11TkNuK3ovVURCRUJtNWJsNkZYejJ0MlJjSERKNURPWC9MSktyMitLVkNm?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D42A521492CD34EA57FA559D7E9BD20@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3befcf0d-fe6c-4769-f7af-08daf7a2659b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:16:48.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6M9gIsEN1BwZoecE8/rjEHxs0jvm05Za60i/rNQ/IeBb7z52PXJfQlej5W3xa0K1ig4O4V1gKhxZTBV/3guoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6728
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTE2IGF0IDA5OjA2ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wMS8yMDIzIDA5OjAxLCBZb25nIFd1ICjlkLTli4cpIHdyb3RlOg0KPiA+
IE9uIEZyaSwgMjAyMy0wMS0xMyBhdCAwOToyNSArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3
cm90ZToNCj4gPiA+IE9uIDEzLzAxLzIwMjMgMDc6MDEsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+
IE1lZGlhVGVrIGlvbW11IGhhcyBhbHJlYWR5IGNvbnRyb2xsZWQgdGhlIG1hc3RlcnMnIGlvdmEg
cmFuZ2VzDQo+ID4gPiA+IGJ5DQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBtYXN0ZXIncyBsYXJiL3Bv
cnQgaWQuIHRoZW4gdGhlIGRtYS1yYW5nZXMgcHJvcGVydHkgaXMNCj4gPiA+ID4gdW5uZWNlc3Nh
cnkNCj4gPiA+ID4gZm9yDQo+ID4gPiBTZW50ZW5jZXMgaW4gRW5nbGlzaCBhbHdheXMgc3RhcnQg
d2l0aCBhIGNhcGl0YWwgbGV0dGVyLCBob3dldmVyDQo+ID4gPiBhbHNvDQo+ID4gPiB0aGV5IGRv
IG5vdCBzdGFydCB3aXRoICJUaGVuIi4gTWFrZSBpdCBhIHByb3BlciBhIHByb3Blcg0KPiA+ID4g
c2VudGVuY2UuDQo+ID4gDQo+ID4gU29ycnkgZm9yIHRoZSBzeW50YXggaXNzdWVzLiBJIHRoaW5r
IGl0IGlzICIsIiBiZWZvcmUgInRoZW4iLg0KPiA+IA0KPiA+ID4gPiB0aGUgbWFzdGVyJ3Mgbm9k
ZS4gdGhlIG1hc3RlciBpcyB2Y29kZWMgaGVyZS4NCj4gPiA+IA0KPiA+ID4gVW5uZWNlc3Nhcnkg
b3IgaW52YWxpZD8gDQo+ID4gDQo+ID4gRm9yIG10ODE5NSwgSXQgaXMgdW5uZWNlc3NhcnkuIEZv
ciB0aGUgb3RoZXIgU29DIHdoaWNoIGRvZXNuJ3QgdXNlDQo+ID4gcGFyZW50L2NoaWxkIG5vZGUs
IHRoZSBwcm9wZXJ0eSBpcyBpbnZhbGlkLCBob3dldmVyLCB0aGVyZSBpcyBubw0KPiA+IHZjb2Rl
Yw0KPiA+IG5vZGUgaGF2ZSB0aGlzIHByb3BlcnR5IGluIHRoaXMgY2FzZSBpbiB0aGUgY3VycmVu
dCB1cHN0cmVhbSBkdHMNCj4gPiBub2Rlcy4NCj4gPiANCj4gPiA+IERvbid0IHlvdSBkZXBlbmQg
bm93IG9uIHNvbWUgZmVhdHVyZSBvZiBkcml2ZXINCj4gPiA+IGFkZGVkIGZvciBleGFtcGxlIHJl
Y2VudGx5Pw0KPiA+IA0KPiA+IE5vLiBJdCBkb2Vzbid0IGRlcGVuZCBvbiBhbnkgdGhlIG90aGVy
IHBhdGNoZXMuIEp1c3QgZGVwZW5kDQo+ID4gb24gdGhlIGNvZGUgY2hhbmdpbmcgaW4gdGhpcyBw
YXRjaHNldC4gSSBqdXN0IHB1dCB0aGUgZHQtYmluZGluZw0KPiA+IGF0IHRoZSBiZWdpbm5pbmcg
b2YgdGhpcyBzZXJpZXMuDQo+IA0KPiBTbyB0aGlzIGlzIGFuIEFCSSBjaGFuZ2Ugd2hlcmUgeW91
IGV4cGVjdCBubyB1cHN0cmVhbSB1c2VycyB0byBiZQ0KPiBhZmZlY3RlZD8gV2h5IHlvdSBkbyBu
b3QgY2xhcmlmeSBpdCBpbiBjb21taXQgbXNnPw0KDQpTb3JyeSBJIG1pc3NlZCBhIHZlbmMgbm9k
ZS4gSW4gWzkvMTBdIG9mIHRoaXMgc2VyaWVzLCBJIGRlbGV0ZWQgdGhpcw0KcHJvcGVydHkgZm9y
IG10ODE5NSB2ZW5jIG5vZGUsIHRoaXMgaGFzIGEgbGl0dGxlIGFmZmVjdC4gDQoNClZFTkMgd291
bGQgbGlrZSB0byBsb2NhdGUgdGhlIElPVkEgcmFuZ2Ugb2YgNEctOEcuIFdpdGhvdXQgdGhpcw0K
cGF0Y2hzZXQsIEl0IHdpbGwgZmFsbGJhY2sgdG8gMC00R0IuIEJ1dCB0aGlzIGlzIG5vdCBhIGZh
dGFsIGlzc3VlLiBJdCANCmFsc28gd29yayBmaW5lIHdpdGggMC00R0IgaW92YS4gSSB3aWxsIGNv
bW1lbnQgdGhpcyBpbiB0aGUgY29tbWl0DQptZXNzYWdlIGluIHRoZSBuZXh0IHZlcnNpb24uDQoN
Cj4gPiA+ID4gDQo+ID4gPiA+IENjOiBUaWZmYW55IExpbiA8dGlmZmFueS5saW5AbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gPiBDYzogQW5kcmV3LUNUIENoZW4gPGFuZHJldy1jdC5jaGVuQG1lZGlhdGVr
LmNvbT4NCj4gPiA+ID4gQ2M6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+
DQo+ID4gPiA+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz4N
Cj4gPiA+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+ID4gPiA+IENj
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+
DQo+ID4gPiANCj4gPiA+IFRoZXJlIGlzIGxpdHRsZSBwb2ludCBpbiBzdG9yaW5nIG91dHB1dCBv
ZiBnZXRfbWFpbnRhaW5lcnMucGwNCj4gPiA+IGZvcmV2ZXINCj4gPiA+IGluDQo+ID4gPiB0aGUg
Z2l0IGxvZy4gSWYgeW91IG5lZWQgaXQgZm9yIHNvbWUgcmVhc29uLCBwbGVhc2Uga2VlcCBpdCBh
ZnRlcg0KPiA+ID4gLQ0KPiA+ID4gLS0uDQo+ID4gDQo+ID4gSSBkaWQgZ2V0IHRoZSBsaXN0IGZy
b20gZ2V0X21haW50YWluZXJzLnBsLiBTb3JyeSB0aGF0IEkgZGlkbid0DQo+ID4gZGlmZmVyZW50
aWF0ZS4NCj4gDQo+IEdldHRpbmcgdGhlIGxpc3QgZnJvbSBnZXRfbWFpbnRhaW5lcnMucGwgaXMg
Y29ycmVjdCBidXQgc3RvcmluZyBpdA0KPiBmb3JldmVyIGluIGdpdCBsb2cgaXMgcmVhbGx5IHVu
bmVjZXNzYXJ5LiBJdCdzIG5vdCB1c2VmdWwuIEl0J3MganVzdA0KPiBhdXRvbWF0ZWQgb3V0cHV0
LCByZXByb2R1Y2libGUgYXQgYW55IGdpdmVuIHRpbWUuDQoNClRoaXMgcGF0Y2hzZXQgY3Jvc3Nl
cyBzZXZlcmFsIGRvbWFpbnMuIFRoaXMgcGF0Y2ggaXMgYWJvdXQgdmNvZGVjLCB0aGUNCm5leHQg
b25lIGlzIGFib3V0IGpwZWcgYW5kIHRoZSBsYXRlciBvbmVzIGFyZSBhYm91dCBpb21tdS4NClRo
ZSByZXZpZXdlcnMgbWF5IGJlIGRpZmZlcmVudCwgdGh1cyBJIHVzZSAiQ2M6IiBoZXJlLiBpcyB0
aGlzIE9LIGluDQp0aGlzIGNhc2U/IG9yIEkgc2hvdWxkIHJlbW92ZSB0aGlzLCBhbmQgcHV0IGFs
bCBvZiB0aGVtIGluIHRoZSBjYyBsaXN0DQpvZiB0aGUgbWFpbC4NCg0KVGhhbmtzLg0KDQo+ID4g
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg==
