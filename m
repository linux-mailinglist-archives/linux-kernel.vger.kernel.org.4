Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1293166B8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjAPICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjAPICH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:02:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F348E1286F;
        Mon, 16 Jan 2023 00:01:36 -0800 (PST)
X-UUID: fdfcf698957311eda06fc9ecc4dadd91-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CGOpgh/lxP3WtzBoSPJeKC/UC4KtkQ17kkRAH13nvYs=;
        b=OBPyL0WGi9C1JVoTYDmlaPQ8CHtCssWlmC20zaDO3Wt1Mqf60/l058uzl95aNkkIoJq1zWhbZ1e1V2PpW8se/EXXRfvM9ff5MgUK/228M03nr27LHo7gnrkdo5ypJErEeiE5i541qjgvrknLzi/uDeKXvrO2tJqljVZKYU48nN4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:34166e74-cbb9-4ac5-995b-32ee6c9f62b9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:b0b05e8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: fdfcf698957311eda06fc9ecc4dadd91-20230116
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 939958641; Mon, 16 Jan 2023 16:01:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 16:01:32 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 16:01:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfCYXyf2wOWPvv7ubR69HvBUPkGRjzbdBtWyf/FwNuIAqV2ZfYzgfNaQ54TM9Pes0yEvuPx0xF9b05k4KIoiuKN1iNwtL0LF9pnUgl6I9xVz4u60lTxfW7MjKn5hy9aPfYdg5QlCzorLF+6terlpOSpo/sv/Jb5q/Epl039YYh29ABzIHOjO0LNF3uS1VQHhpyjg2eu9jTihgbkAIhzs2RurMqP/k2+DZZEcpLWzBKUavTy8Xt8hA5CIhiBOV2CAlqsjnxlnJKkS39uDs9BROL/fHJpKPTxgFDmNBg3fW7kEeYUMo+zx0PkyeJxNnyavfiLecksEOaudxINv1o9LmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGOpgh/lxP3WtzBoSPJeKC/UC4KtkQ17kkRAH13nvYs=;
 b=NiSdcqVO5O9/SkmcXHMK/XavVKcboa2PSpn6uTw4rMZo41tNYc2bZH5IwhVck5eAm3vx4tMWXAEM736QauPcDNU2j9yPC21f4jowk/1ow122EmzRzIMbLbB41E+nt+y7ELbs9Ci7KDvyiYv0aePxGZKCKX4EId0MEAglTYX1r4ABag6vOUIN90otZYiZAyPhBxugYgR4zRGd9ID/9Z8uE9Tp5ghpK/ieWImTt2YMi61Rl7xbv0M1jjhsO9vXc8mS0SRB7KCbVWGCRk+wVrMD2y4fL2jpxy8hA1JYAtOMSEMDAB/4XTiQpGgUrC/a5dF9ICFIJySc4uxLi4Y6iUBAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGOpgh/lxP3WtzBoSPJeKC/UC4KtkQ17kkRAH13nvYs=;
 b=DsJUg6jJ5OX+kVhQwQNCTa6pR1vxT0fhK6bgNWs23lwaqpD8MEJ2dGjv8Eavyc+l0mUyWx0qncY4X2jhtr1qOYPLhWitG/POI9I6qIpZhOWZKv3GYGs3hoZgMUuIN7/TA7IprBMtzR7mub9FkMyMyRmeZXSWPvQRkfR4JJ2ekVA=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYUPR03MB7179.apcprd03.prod.outlook.com (2603:1096:400:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 08:01:29 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3%6]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 08:01:29 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
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
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Thread-Topic: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Thread-Index: AQHZJxSslMi5KoPBoUSEhCSEsTrcmK6cAykAgASqhYA=
Date:   Mon, 16 Jan 2023 08:01:29 +0000
Message-ID: <796e7fb8619d114c63580e5c4289c59a57449843.camel@mediatek.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
         <20230113060133.9394-2-yong.wu@mediatek.com>
         <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
In-Reply-To: <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYUPR03MB7179:EE_
x-ms-office365-filtering-correlation-id: 356f8357-b118-47c9-c19c-08daf797dfb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7zUtrJDAUqNBzbpOBRe48IGq3QEg0RR4xs02LO9n7lzERVHRfH5H0Dnpl5fjXt0Mi3XrCnlKhefgNe+v+evl/ezlzyFTqSu+S9joCkNcvEsWkImKskoXRj5pC8mZtMdD2Zx5KwV8o9vNnZIo/Xhxqfo83iVdKUKuJZwmrHfaElZb4bcc3wTw9zNCL9Z+tBfofrcW673K5IEpzTVwEuDRyFGu0lFBDNA7zzrLbKo+I+8fqhDAzNeIlh1WXSM94O6716lbDD8ajpAVBQj/6HPP4Ow/ucNED9kGzKkRCypolRvDJLaxPGou4biNKq26Lw80yI1cX2tkuWXeJZ1lYWtntf2HpMwTUtqsVbe0EA54A7JHFn1MtZdFE5HX8JlzotoTiL4yUzjbzf8YRtKXUH212oCU9udJCLcm2LjcKH21J2obN2yk0aKAsR37V6Qxc5xAtYtD1wFV3UTmQngmMXSswpprUS9P7bgVaX662UAhKDCTEY1TUXT0p1o1mBNMrT4465GhL9gY7Y9IIbPFs2Qs9ar+EINC/tDKA4RsGQTYpo0oDim+FZlR+F6UFEE8LBZYxzU5mXxf1Hghz2dp+Rr/4Dk2g4B4ciETIPTDr8pduMfD8zpEqNQjkCEPSbHvVgMUf1Z+Bg/gHWSU0pE3QBciVHRPO96hkHReSkhny4XnORSXYNILTG3zuX/AeX7r29JDiPB+FV6g4CTdu5pufN9oWeX3upbtShMTBM8rm/yX3jc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199015)(64756008)(316002)(110136005)(54906003)(4326008)(66476007)(66556008)(66946007)(76116006)(41300700001)(8676002)(7416002)(36756003)(85182001)(5660300002)(8936002)(83380400001)(38070700005)(2616005)(38100700002)(122000001)(66446008)(86362001)(71200400001)(26005)(186003)(53546011)(6506007)(6512007)(6486002)(478600001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0tWK1BvZSt3d0MrZklwanlsR2txWnljQkVzZmtSY1FpbnRSSlhpeER5QXl3?=
 =?utf-8?B?Yzl5UUZrcUlVa28yR0VJNExjUVcrY1J5RHNQUEVJNTRZMjZud0l2UVdYYU44?=
 =?utf-8?B?eUN4bFZkRUNXYXZXK1pLYWpqUTlra1g3SFFYdTQ5YVJGYTlyOUM4bW1Qb1JY?=
 =?utf-8?B?emNxQi83dDMzYWtHbzh4NUF6UDR3RXI4M0w1UmdQMUtNYjFHSEFSaWl5UHdH?=
 =?utf-8?B?UXFIemZMdzhmOUZnajR0c0tIUldNRGV6d29seWFoOExIbVRQZTVLc00wSWFJ?=
 =?utf-8?B?TGxXZ3JMQkJBekZVNHI1ekw1Ynd4RUt4bitxby8wbFh2NzBhSmpHVXJkZ1ph?=
 =?utf-8?B?aGd5Zmcxc2d6OW4rMy92dTNnOFcrTm5xc3dvaXlHaG82Q1U1V2MxSHlueEc2?=
 =?utf-8?B?aEZRS0xQTVIrWGN2b2lOOHJUNGJmOHRic2lCaElFcVhVcHNic1lYNWpoMGtO?=
 =?utf-8?B?MXhMZWpNMDZKUkxnRWNYbHczajUza0twYnZSMklUT2NXRktuc3N0UUhrcWFD?=
 =?utf-8?B?aWFpalYvVUo1MUJObDRyeVhVM1dPV1RFOWZQUU9WaFF0Y29kbWVvRCsvVkRL?=
 =?utf-8?B?eWlSaTJoRWhHVC93UDhLck5FakxlZlR2bHlteG8vQjNzZlI2Y0tpL1RHOWxy?=
 =?utf-8?B?eG9rMFN3RXpCajZpOE94RzNpZXNmbnFJZXZ1UytrdktDQnZGYytkd3BGUUta?=
 =?utf-8?B?UUIvMGdNbkJGcGNCWjhPckRUM0dqWFAwZFkrWVgrek5hRXc2TjVNTzRLOSsw?=
 =?utf-8?B?aXZ0cG5mbkMxMmZPa1M5a1ViQ3o3Mm9OZ0VWbG5LRUpkSFE5MzBLdHJZZ2ZP?=
 =?utf-8?B?eUZDRXpqVFBaSVFidS9mbUk1U0lCVGo1YUlSelRhMXc5MFozM2JHdHVpV3NP?=
 =?utf-8?B?eUc5UWtBMUcxaEQrSFh1OUZWcVQ0RDVoTWZEU0I5QnI4dEg1WHBSazVUS1da?=
 =?utf-8?B?K3hqeXJlM2RwR2RCdStKTVRNY0dveENVYlNMeXpGZXYzVHRKOEdONStONXRO?=
 =?utf-8?B?RE42L1VvUk5Ed243RjFWcVhXOTdkOG55VVJYaVdsM0FvRTg1a1VLMWZiMUFS?=
 =?utf-8?B?Nk5VaUZSb3dPTU10eXAwZ0Jod1Y1TVdXZlA0UUtGWU1WT3ZVY1dVTlM4Nk9P?=
 =?utf-8?B?RE0wVmVCK0Q5dWlLaWtMNmR2YjBMRlpmK3pNMVhQU3NjeXdpMHpMMm4rNEZD?=
 =?utf-8?B?dTBvQjRnYklRandOVmZHaVptdkN2L1NaYjJJclRKTEZpcmM5clE2Zkdnb0kx?=
 =?utf-8?B?aFFjZDBpQVlvaEhFUGlNNldxS1V6UjlBNVhPbEorekpvcmovRE1qY21HeStZ?=
 =?utf-8?B?K1lLVFNITm5mcmZROE9tVzdVL0JTMFBlZ0VSMlYzZ2F5a21pQUJWTDFzR1gx?=
 =?utf-8?B?b1BQV3BGOEFMaTZFRnlvblNMNFY0aDRzSDdKNkpwekFJaGQrZUM3Z0thWU1Z?=
 =?utf-8?B?MGJHYW44YzZZc2xWaXhoZm4zS3JrSWg5UnFtb2tJZld6b1lOOTQ2eHczT2sy?=
 =?utf-8?B?MkpoWXppNEFMSkxDbHlpZFhUM1N5YjhVUkJ6U05INmlNMnZObTNrVUpud3Z1?=
 =?utf-8?B?M3U2M0pudlBsamowcVJNcDhZS3pDZUFjamd2aHRQUTVtSDJ0U0U1YTNlQjU5?=
 =?utf-8?B?QWpmQzJ5aVowNFZLYmx6c1AreDZKQzRIZ2V2ZmRPWCs0dFNoeEQ1RG1TMVdZ?=
 =?utf-8?B?UDZ4WHpvbUZvdmNRemhRTWZ6bkhuYWRXWjBZbGQzMW5YREthU3h5MnNFVG1j?=
 =?utf-8?B?VmUrbkdBcVpCdkM3VGxFNFVHRGN2dXYwVDMrN3VJS1g3K0ZnNXFjYytxSTZt?=
 =?utf-8?B?SXR6TXpFOXByVStENzVRdGNFMjZvUFcyb3NqQTF1MFlWU0VWSjZYdEpvb2c3?=
 =?utf-8?B?SThVa1Z4ZHRQcm9yY01RYlczTFlQRHZwMEt2STNCeDQxWkp5NWYzQ3RtSWU2?=
 =?utf-8?B?NEhycVNVQm4wb2R6dHF1eG1CWXJMVnVsbmV2TkhDRzRsSjdld09jUEtkMkE4?=
 =?utf-8?B?MFJFb0FMMmRoRUlFbTRKYkZGTmlSQjJvQWhIM0JnMXNvMm5FbHgwWTBscTZG?=
 =?utf-8?B?OVBvajdUTUgvYkdRYjF6WmlOamRkbVpQSEZtLzZ4QXhZRVJxNXJFUFJUaDBS?=
 =?utf-8?Q?+EWNvpueWLolXlKTrCTvl0Jp1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5EBC68AEEE816408C671E5B91EB868C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356f8357-b118-47c9-c19c-08daf797dfb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 08:01:29.1074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNrJVbLrxUkrduX0V+I5Oi/7R1mzi0MPrpVWXcar88mVhg3hnGkRCLjDZytMJnS7/K9Kv/MwN53z7HWUWP41YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7179
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDA5OjI1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMy8wMS8yMDIzIDA3OjAxLCBZb25nIFd1IHdyb3RlOg0KPiA+IE1lZGlhVGVr
IGlvbW11IGhhcyBhbHJlYWR5IGNvbnRyb2xsZWQgdGhlIG1hc3RlcnMnIGlvdmEgcmFuZ2VzIGJ5
DQo+ID4gdGhlDQo+ID4gbWFzdGVyJ3MgbGFyYi9wb3J0IGlkLiB0aGVuIHRoZSBkbWEtcmFuZ2Vz
IHByb3BlcnR5IGlzIHVubmVjZXNzYXJ5DQo+ID4gZm9yDQoNCj4gU2VudGVuY2VzIGluIEVuZ2xp
c2ggYWx3YXlzIHN0YXJ0IHdpdGggYSBjYXBpdGFsIGxldHRlciwgaG93ZXZlciBhbHNvDQo+IHRo
ZXkgZG8gbm90IHN0YXJ0IHdpdGggIlRoZW4iLiBNYWtlIGl0IGEgcHJvcGVyIGEgcHJvcGVyIHNl
bnRlbmNlLg0KDQpTb3JyeSBmb3IgdGhlIHN5bnRheCBpc3N1ZXMuIEkgdGhpbmsgaXQgaXMgIiwi
IGJlZm9yZSAidGhlbiIuDQoNCj4gPiB0aGUgbWFzdGVyJ3Mgbm9kZS4gdGhlIG1hc3RlciBpcyB2
Y29kZWMgaGVyZS4NCj4gDQo+IFVubmVjZXNzYXJ5IG9yIGludmFsaWQ/IA0KDQpGb3IgbXQ4MTk1
LCBJdCBpcyB1bm5lY2Vzc2FyeS4gRm9yIHRoZSBvdGhlciBTb0Mgd2hpY2ggZG9lc24ndCB1c2UN
CnBhcmVudC9jaGlsZCBub2RlLCB0aGUgcHJvcGVydHkgaXMgaW52YWxpZCwgaG93ZXZlciwgdGhl
cmUgaXMgbm8gdmNvZGVjDQpub2RlIGhhdmUgdGhpcyBwcm9wZXJ0eSBpbiB0aGlzIGNhc2UgaW4g
dGhlIGN1cnJlbnQgdXBzdHJlYW0gZHRzIG5vZGVzLg0KDQo+IERvbid0IHlvdSBkZXBlbmQgbm93
IG9uIHNvbWUgZmVhdHVyZSBvZiBkcml2ZXINCj4gYWRkZWQgZm9yIGV4YW1wbGUgcmVjZW50bHk/
DQoNCk5vLiBJdCBkb2Vzbid0IGRlcGVuZCBvbiBhbnkgdGhlIG90aGVyIHBhdGNoZXMuIEp1c3Qg
ZGVwZW5kDQpvbiB0aGUgY29kZSBjaGFuZ2luZyBpbiB0aGlzIHBhdGNoc2V0LiBJIGp1c3QgcHV0
IHRoZSBkdC1iaW5kaW5nDQphdCB0aGUgYmVnaW5uaW5nIG9mIHRoaXMgc2VyaWVzLg0KDQo+ID4g
DQo+ID4gQ2M6IFRpZmZhbnkgTGluIDx0aWZmYW55LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gQ2M6
IEFuZHJldy1DVCBDaGVuIDxhbmRyZXctY3QuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gQ2M6IFl1
bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gQ2M6IE1hdXJvIENhcnZh
bGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPg0KPiA+IENjOiBSb2IgSGVycmluZyA8cm9i
aCtkdEBrZXJuZWwub3JnPg0KPiA+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+IA0KPiBUaGVyZSBpcyBsaXR0bGUgcG9pbnQgaW4g
c3RvcmluZyBvdXRwdXQgb2YgZ2V0X21haW50YWluZXJzLnBsIGZvcmV2ZXINCj4gaW4NCj4gdGhl
IGdpdCBsb2cuIElmIHlvdSBuZWVkIGl0IGZvciBzb21lIHJlYXNvbiwgcGxlYXNlIGtlZXAgaXQg
YWZ0ZXIgLQ0KPiAtLS4NCg0KSSBkaWQgZ2V0IHRoZSBsaXN0IGZyb20gZ2V0X21haW50YWluZXJz
LnBsLiBTb3JyeSB0aGF0IEkgZGlkbid0DQpkaWZmZXJlbnRpYXRlLg0KDQpNYWlubHkgSSBjaGFu
Z2VkIHRoZSBpb21tdSBjb2RlIGJ1dCBjaGFuZ2VkIHRoZSBtZWRpYSBkdC1iaW5kaW5nLg0KSnVz
dCBleHBlY3QgdGhlIG1lZGlhIG93bmVycy9yZXZpZXdlcnMgdG8gdGFrZSBhIGxvb2sgYXQgdGhp
cy4NCg0KVGhhbmtzLg0KDQo+ID4gQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0Bn
bWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVr
LHZjb2RlYy1kZWNvZGVyLnlhbWwgfCA1IC0NCj4gPiAtLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy1lbmNvZGVyLnlhbWwgfCA1IC0NCj4gPiAt
LS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtc3ViZGV2LWRlY29k
ZXIueWFtbCAgICAgfCA3IC0NCj4gPiAtLS0tLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNyBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLQ0KPiA+IGRlY29kZXIueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVr
LHZjb2RlYy0NCj4gPiBkZWNvZGVyLnlhbWwNCj4gPiBpbmRleCBhYTU1Y2E2NWQ2ZWQuLmZhZDU5
YjQ4NmQ1ZCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLQ0KPiA+IGRlY29kZXIueWFtbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtDQo+
ID4gZGVjb2Rlci55YW1sDQo+ID4gQEAgLTU2LDExICs1Niw2IEBAIHByb3BlcnRpZXM6DQo+ID4g
ICAgICAgIExpc3Qgb2YgdGhlIGhhcmR3YXJlIHBvcnQgaW4gcmVzcGVjdGl2ZSBJT01NVSBibG9j
ayBmb3INCj4gPiBjdXJyZW50IFNvY3MuDQo+ID4gICAgICAgIFJlZmVyIHRvIGJpbmRpbmdzL2lv
bW11L21lZGlhdGVrLGlvbW11LnlhbWwuDQo+ID4gIA0KPiA+IC0gIGRtYS1yYW5nZXM6DQo+ID4g
LSAgICBtYXhJdGVtczogMQ0KPiA+IC0gICAgZGVzY3JpcHRpb246IHwNCj4gPiAtICAgICAgRGVz
Y3JpYmVzIHRoZSBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlIG9mIElPTU1VIG1hcHMgdG8NCj4gPiBt
ZW1vcnkuDQo+ID4gLQ0KPiA+ICAgIG1lZGlhdGVrLHZwdToNCj4gPiAgICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gPiAgICAgIGRlc2NyaXB0aW9u
Og0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtDQo+ID4gZW5jb2Rlci55YW1sDQo+ID4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLQ0KPiA+IGVu
Y29kZXIueWFtbA0KPiA+IGluZGV4IDBmMmVhOGQ5YTEwYy4uYTIwNTFiMzFmYTI5IDEwMDY0NA0K
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRl
ayx2Y29kZWMtDQo+ID4gZW5jb2Rlci55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy0NCj4gPiBlbmNvZGVyLnlhbWwN
Cj4gPiBAQCAtNDksMTEgKzQ5LDYgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgTGlzdCBvZiB0
aGUgaGFyZHdhcmUgcG9ydCBpbiByZXNwZWN0aXZlIElPTU1VIGJsb2NrIGZvcg0KPiA+IGN1cnJl
bnQgU29jcy4NCj4gPiAgICAgICAgUmVmZXIgdG8gYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9t
bXUueWFtbC4NCj4gPiAgDQo+ID4gLSAgZG1hLXJhbmdlczoNCj4gPiAtICAgIG1heEl0ZW1zOiAx
DQo+ID4gLSAgICBkZXNjcmlwdGlvbjogfA0KPiA+IC0gICAgICBEZXNjcmliZXMgdGhlIHBoeXNp
Y2FsIGFkZHJlc3Mgc3BhY2Ugb2YgSU9NTVUgbWFwcyB0bw0KPiA+IG1lbW9yeS4NCj4gPiAtDQo+
ID4gICAgbWVkaWF0ZWssdnB1Og0KPiA+ICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICAgICAgZGVzY3JpcHRpb246DQo+ID4gZGlmZiAtLWdp
dA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVr
LHZjb2RlYy1zdWJkZXYtDQo+ID4gZGVjb2Rlci55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLXN1YmRldi0NCj4gPiBkZWNv
ZGVyLnlhbWwNCj4gPiBpbmRleCBjNGYyMGFjZGMxZjguLjI5MDU5NGJjOTFjYyAxMDA2NDQNCj4g
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWss
dmNvZGVjLQ0KPiA+IHN1YmRldi1kZWNvZGVyLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLQ0KPiA+IHN1YmRldi1k
ZWNvZGVyLnlhbWwNCj4gPiBAQCAtNzYsMTEgKzc2LDYgQEAgcHJvcGVydGllczoNCj4gPiAgICAg
ICAgVGhlIG5vZGUgb2Ygc3lzdGVtIGNvbnRyb2wgcHJvY2Vzc29yIChTQ1ApLCB1c2luZw0KPiA+
ICAgICAgICB0aGUgcmVtb3RlcHJvYyAmIHJwbXNnIGZyYW1ld29yay4NCj4gPiAgDQo+ID4gLSAg
ZG1hLXJhbmdlczoNCj4gPiAtICAgIG1heEl0ZW1zOiAxDQo+ID4gLSAgICBkZXNjcmlwdGlvbjog
fA0KPiA+IC0gICAgICBEZXNjcmliZXMgdGhlIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2Ugb2YgSU9N
TVUgbWFwcyB0bw0KPiA+IG1lbW9yeS4NCj4gPiAtDQo+ID4gICAgIiNhZGRyZXNzLWNlbGxzIjoN
Cj4gPiAgICAgIGNvbnN0OiAyDQo+ID4gIA0KPiA+IEBAIC0yMDMsNyArMTk4LDYgQEAgcmVxdWly
ZWQ6DQo+ID4gICAgLSByZWcNCj4gPiAgICAtIGlvbW11cw0KPiA+ICAgIC0gbWVkaWF0ZWssc2Nw
DQo+ID4gLSAgLSBkbWEtcmFuZ2VzDQo+ID4gICAgLSByYW5nZXMNCj4gPiAgDQo+ID4gIGlmOg0K
PiA+IEBAIC0yMzYsNyArMjMwLDYgQEAgZXhhbXBsZXM6DQo+ID4gICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLXZjb2RlYy1kZWMiOw0KPiA+ICAgICAgICAgICAgICBt
ZWRpYXRlayxzY3AgPSA8JnNjcD47DQo+ID4gICAgICAgICAgICAgIGlvbW11cyA9IDwmaW9tbXUw
IE00VV9QT1JUX0w0X1ZERUNfTUNfRVhUPjsNCj4gPiAtICAgICAgICAgICAgZG1hLXJhbmdlcyA9
IDwweDEgMHgwIDB4MCAweDQwMDAwMDAwIDB4MCAweGZmZjAwMDAwPjsNCj4gPiAgICAgICAgICAg
ICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gICAgICAgICAgICAgICNzaXplLWNlbGxzID0g
PDI+Ow0KPiA+ICAgICAgICAgICAgICByYW5nZXMgPSA8MCAwIDAgMHgxNjAwMDAwMCAwIDB4NDAw
MDA+Ow0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+IA0K
