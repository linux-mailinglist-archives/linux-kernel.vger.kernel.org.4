Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C3727573
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjFHDHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFHDHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:07:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65662688;
        Wed,  7 Jun 2023 20:07:41 -0700 (PDT)
X-UUID: 9cfd5d0005a911ee9cb5633481061a41-20230608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=w/x5LrLCrHnf4O6tMd+u6h6RpF7TcJAbpiHqL72CuPU=;
        b=q/9ggpDdDn1Aem23hQUnKaa6J0kqSQZZd0FdQbfUTHNsEOUWXCKN1I6tWHEtCmNTbWsR9uCw4+1bYO6524PSHnN1WPT05/LTuceBxSXgq3ZA5w6B3f05J82EqngI9vVKPXiiT2GoK4KYW8sFVAxs+UPQzvX37gfsuYemzhB8AqM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:8dcce7d6-a281-4a6a-95f4-a2c058e261f0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:68
X-CID-INFO: VERSION:1.1.26,REQID:8dcce7d6-a281-4a6a-95f4-a2c058e261f0,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:68
X-CID-META: VersionHash:cb9a4e1,CLOUDID:1e08ef3d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:2306071527481U3980PY,BulkQuantity:29,Recheck:0,SF:28|17|19|48|38|29|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 9cfd5d0005a911ee9cb5633481061a41-20230608
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1083293534; Thu, 08 Jun 2023 11:07:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 11:07:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Jun 2023 11:07:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jczm1DXAHGByGPF7sJ2f0OXz41Si8XuQ3z3ZP3ElnTBWglNmD/+oH6HUO5uXTlxM03LUZqoaFkmypi7/PC6mnXutLhR8rem5IZVE82glOLWnk3fQFrty5H9Ttjwg/5Y7PK/0jYX63M8u000P+cTg5tO+s03hjMf8Fo2gXEiDp2PnNEMo1wU3j37IrlkiIrd2VywLz9EJ3AG7TsjdcGm3fr59NXLboAAd0dh/qZDaEdWykp/HqZEFO3gScJX++5e5srh2MRunoPJSmqYGHFOG32nruRDAd8b/Ai/777daNyswft7Y86DkCuqVHtmQpLmA9VXzMHNaP2foHdxXuQ6Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/x5LrLCrHnf4O6tMd+u6h6RpF7TcJAbpiHqL72CuPU=;
 b=Iijj8k9wIbLQ4QxpMmm+btjaNakYwk0gQbneZVkZzXCQPi7omU8zIs6z8pjwUitKMlycyy5yEaFOuWfg1KKbczS6zv3UhnE1EdwCAvy6jaDKmTD/WjXWqWL4sfZK0VZ+k0sBdp2nfYa15AtxXBBI4/uO9KmL9WNvVREcMc3X2UzR/WSZy42fggnEEL5/hU6TQ2CeefbygnV2ncjJfZfR9i/9pBptiV95n8OH90ojWm1FhY0wbELmvdIDbyzwqzk76GFZ/7Yv4it+dM7xs3V1RVRSiq8u+Vsxp8qnGIyOqddVnUj13xME961dF7B+sRhanhMKvTNZ0mSSWJpLzoNO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/x5LrLCrHnf4O6tMd+u6h6RpF7TcJAbpiHqL72CuPU=;
 b=io8kG3Y6qMfFlpZZ1RTgrLUT/yylNCvMfsyWQZjlITL9pflkEfM4B+H4PcgjuLt50xMsQL25S08vroKolP6TlJIu5YmmwnrccDw1QMDLFUTejHLwU8hoKF0AnGDFpdhaT90gJMZvVM7KuNWhRRSbtd5UG8NR9zSdW7zCt3jlXiU=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SG2PR03MB6384.apcprd03.prod.outlook.com (2603:1096:4:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 03:07:30 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 03:07:30 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "fshao@google.com" <fshao@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits
 for VDOSYS1
Thread-Topic: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control
 bits for VDOSYS1
Thread-Index: AQHZmQccoZ+M6FRhCUuwkVRvA364Ja9+8QkAgAFJoIA=
Date:   Thu, 8 Jun 2023 03:07:30 +0000
Message-ID: <64e9b4f15353d9733896b2a43e411144789f7c37.camel@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
         <20230607061121.6732-3-shawn.sung@mediatek.com>
         <93eb3e7d-eff5-b040-5290-2de13699ed95@linaro.org>
In-Reply-To: <93eb3e7d-eff5-b040-5290-2de13699ed95@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SG2PR03MB6384:EE_
x-ms-office365-filtering-correlation-id: 24700f1f-0770-4b96-5384-08db67cd7f1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xP31JnEIUGIEA4UOz35UTTzwXXhtrpVX6FiEmPqtCkaBHpvrMzpCP4oMYhGkjKnbcn7s2SrH04pNfMtbGmSEVZyAj9Rp3xRQzZLw10xQiLsk9ltnCJTkMhY7dHlR8fUHD9ukD68MC0dKny79FOcr0y3jBYGAivFVMWflKFnhQpN5SpBjy3Qi/L4ymqdkC6tsK2I3NEi1T8q7U1i8i6ZEK7DiYaX+4Nv4mwT9TOXJnT02fdE+IOvBoo6JBC9qKEDQVKEejiBFMEsl32zWJxGiFn5vLDBlSLoNWgB22MJvV4DxXT0/oeFDYdE8UEjlWNpvcWS1hpQ8tHOZ3gxkAqQ016Iy52/pdXxvKKaxdYKJ1V3IFPIO+bcTQX/jlaRRbv0Hy30aNNjv+go2CxIOQCbZf4t1yJngvI8JzZPyENSDmRO84+O82YuPbokzBdyEiJxHcS6ywJ/HdYAQPDS+060koC/6BWw2xjq4MnbCGZ7VIqqP2Zokk1RXIVkOHj2Hw1rRM+5br3Ni/cUerMl7VQOiQ3ugjGiKaJTvsa67f1FedFEhUeAZjXhBs5OK4SOpqKs3tFhWP1dlvf/2dTn6KhjQlb6OFt1JnlgfK+VPa8AWnTMmYg5oDqKnZwmFmI9O/karK7ACMeaaIU48DEEjI10jxSi+xoZklidBk0gE8RVOLYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(7416002)(83380400001)(110136005)(54906003)(478600001)(8676002)(8936002)(41300700001)(38070700005)(316002)(76116006)(66946007)(66476007)(66556008)(66446008)(122000001)(64756008)(5660300002)(38100700002)(4326008)(86362001)(6486002)(36756003)(85182001)(71200400001)(2906002)(186003)(26005)(53546011)(6512007)(6506007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS8wRnJDYmdDTUZvNmpreU9WeXlRaHFxZ0Q3VzRPWDhvMlNsUHR6L3VRUDVx?=
 =?utf-8?B?eEhxeXkwVlhyN1hQOWFlM2VlZDZaVlpYUjY2TFR1UVM5MzlBZklDdlJiWVhN?=
 =?utf-8?B?a1hkL1NzWFg4YmJRdEc3UTVZelo0SHJ1N2lZUTVVK0NYRlFibzkvVjNKclFS?=
 =?utf-8?B?THN3T0V6bWV1cUdVM1kzdlNuR0lJemxmQ2VVSm5ndS9yU2lQYU82cWt2YXly?=
 =?utf-8?B?blI0K21ERWlja3pzaW1IaThRSnBrZ3A0ZFpzNTc2MkFwbGlNS0x6WFB2S0Zl?=
 =?utf-8?B?WHAxUmsydUF3d04vVDB6MFg3SjRQbVNsV3hMSnFGWk01SkxhNll6RFFxK3Ni?=
 =?utf-8?B?VmJFZDFmYlRwMVZNclVrRHNsMno1ZGdYYjdYdmZaVC9QZXNIMTc2VDJHQmZU?=
 =?utf-8?B?c3pqOGVMckRQQlRRQ0NzVjFtT05zblg4eDRoeVBhRmdPS1JZYjd4YWU1cDBG?=
 =?utf-8?B?cHgzVGZpaHc0SXBLTTlWTVFNQm5ublBmTlU4R3JRMUc5cWpiem04N2txdElT?=
 =?utf-8?B?QlRvWDZyVittSklPS21aRUZGSENBQno2djEzL1VJNnkyRE9BYjNpeFdqcXhO?=
 =?utf-8?B?WG1DVGs5cGFLa1lQWXQzV0YxOHVQdkV2OGVvV09KTjlPR2JVMGlGN04vWjJT?=
 =?utf-8?B?Y2NuRmRzUHFvL2JXbVhzNU5PY2pNQ01rVTJ3c3lHMkRDdEg5eURsZ3Q2RHBH?=
 =?utf-8?B?QW5EQ3c2VzNuUHVTYzFPcmJHc291MzZ2elpQb25WZzREeGpJMnVyVHI5WjFm?=
 =?utf-8?B?bkRIRlk2VVVpZHpKWWNDQzRtTlNxSkV5bURuUUl6b2xVU0x0RGJJK1VINnpz?=
 =?utf-8?B?VlR0aU1wYTlrMDAyZEdhM2tHTnB2cEhwalRHYXpTZ1JUcGVuWk1zZ2xuMUND?=
 =?utf-8?B?cXV3d3hDSzZOcjI1eXdJM0p2K0Y1TjZYeU1OWGI3d0gyejlOT3FGZ3dEWVND?=
 =?utf-8?B?MWpzYjZMRVYzZDVPQUpmSHBEOWFhWXdmb1YyOG85akFCU2pLRllZU3BadFpL?=
 =?utf-8?B?YkFWVnV6d2J6SlhXU1NqU0JEZ3N0MmI4N2J3TXdVMVplbTF2S2RSNno5MmJa?=
 =?utf-8?B?RzQyNXVCRzVBTjNUVXJuOTJzUGFGTWFsNlFiRWdIZXpmcFVMYnhsMncvWlZV?=
 =?utf-8?B?bDRtRFM3WWt5VVZ6VlB5Tk1ZUTcxK0Z0Y3dPSTIzTHZ5WkcvaytkUUUxZkgz?=
 =?utf-8?B?V1lOdU9uelpPNlBBR3pvMjJWM3ROQ1ZCakdEanhldlQ4ck8vcDNtWFJxck5a?=
 =?utf-8?B?bUk3cUpYRitFSXdFT3ZtcWV0UXhYaGg5blZ1RU1CTHhzdmVlaHMybVh0SWpZ?=
 =?utf-8?B?MTFMVEFPZ1JBODUrcmdNbktwRDJsOExDT3JDTk45dE5ueC9qOTJWTU1sTFhP?=
 =?utf-8?B?MzZzTUZRZ1llenFpQTlnSWhhcjJEMlYrcWF1RXZHUG9ZN3F0MmhUM016b3d4?=
 =?utf-8?B?RzZXYlhFeXBpM3VMZ0F4Ry9PWURYd3Y4dkpSUm92b3orOUdETTRtQjI0ZWw0?=
 =?utf-8?B?U0l4RVFyNSttYWFGWnJ0bGVBZXRVWW42ZGpnaTI1WmRVcVh5L09UVmFFcURM?=
 =?utf-8?B?Q21xYVhKWnpIOFZhaU1LejlXKytQWTRFUE5CYkFSTExOeXlmSDJ0T2Y3KzVo?=
 =?utf-8?B?WEZrbzE4c3lLODl0NGt1MEtxbDQyV2FObzFURERyT1IvZXJZbTRLWStYT2pX?=
 =?utf-8?B?UjlGQkV1YnVZSDhJNzduS2ZZcllNK2tRM0JySENGUWNmZmlGVXhJSWpwSjkz?=
 =?utf-8?B?Q2FLQkRVYzM1ZkF0UXZSWjZqNDM2RWZFMERaTndQK1J0TmRCVUxXdU1EenFR?=
 =?utf-8?B?K0dhQ2FBWUI2M0VML2Z4TWRRcUNrUkluSEwzU2srZitvQ2h5Yy9iUkJVZFpN?=
 =?utf-8?B?MDg0Y1dIT0VGSy9qNTR4UFZyMzhBQjArZlFPT2x5UTRqaW5wS3F3ZkRjWU02?=
 =?utf-8?B?VVhhMi9sTjkwempINVkvN1lXUGk2WVlPeGdKQ1VmenNpakVJVFB1YlZVRFFt?=
 =?utf-8?B?RGNydkU1dGhnVzMxT2tXSnE2cHBqM2ZRTU5zU2krakJ4V1lIRzM5MEdUWFZ2?=
 =?utf-8?B?aXBxSU93N3AwMWxjbStOYjZwZEpqVDErUDF4NVJKNzExRkFaVnJtYjNKT0VO?=
 =?utf-8?B?R3FjckdKTFI0WjJ2OVh1U0NIMU1JOVVGMUY5UHA4OW5jdzBvUW80SmRjaTBY?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <176C072E54AC3C4E9531A85F06476731@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24700f1f-0770-4b96-5384-08db67cd7f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 03:07:30.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpI95nC4F+k97nZXLGVZ8fi9s2vnZ6yWtqAqNiywUrUm2/eqVTI9bYnE1y1ZRWCdCUDc1e4KJ+0tTXJoAljbeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpHb3QgaXQsIEknbGwgc3F1YXNoIHRoaXMgY29tbWl0IHdpdGggdGhl
IG9uZSBhZGRzIGNvbXBhdGlibGUsIGFuZA0KY29tbWl0IGFub3RoZXIgcGF0Y2ggdG8gbW9kaWZ5
IG1tc3lzIHJlc2V0IGNvbnRyb2wgdG8gaGFuZGxlIHRoZSBuZXcNCnJ1bGUgb2YgaW5kZXhpbmcu
DQoNClRoYW5rcywNCkhzaWFvIENoaWVuIFN1bmcNCg0KT24gV2VkLCAyMDIzLTA2LTA3IGF0IDA5
OjI3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwg
ZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50
aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIA0K
PiBPbiAwNy8wNi8yMDIzIDA4OjExLCBIc2lhbyBDaGllbiBTdW5nIHdyb3RlOg0KPiA+IEFkZCBy
ZXNldCBjb250cm9sIGJpdHMgZm9yICBNVDgxODggVkRPU1lTMS4NCj4gDQo+IERvdWJsZSBzcGFj
ZSAtPiBvbmUgc3BhY2UuDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVu
IFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2R0
LWJpbmRpbmdzL3Jlc2V0L210ODE4OC1yZXNldHMuaCB8IDEyICsrKysrKysrKysrKw0KPiANCj4g
VGhpcyBzaG91bGQgYmUgc3F1YXNoZWQgd2l0aCBwYXRjaCBhZGRpbmcgY29tcGF0aWJsZS4NCj4g
DQo+IA0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L210ODE4OC1yZXNldHMuaA0KPiBi
L2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvbXQ4MTg4LXJlc2V0cy5oDQo+ID4gaW5kZXggMzc3
Y2RmZGE4MmE5Li40MzlhOWEyNWNhMTkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kdC1iaW5k
aW5ncy9yZXNldC9tdDgxODgtcmVzZXRzLmgNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdz
L3Jlc2V0L210ODE4OC1yZXNldHMuaA0KPiA+IEBAIC0zMyw0ICszMywxNiBAQA0KPiA+IA0KPiA+
ICAjZGVmaW5lIE1UODE4OF9UT1BSR1VfU1dfUlNUX05VTSAgICAgICAgICAgICAgIDI0DQo+ID4g
DQo+ID4gKy8qIFZET1NZUzEgKi8NCj4gPiArI2RlZmluZSBNVDgxODhfVkRPMV9SU1RfTUVSR0Uw
X0RMX0FTWU5DICAgICAgICAgOQ0KPiANCj4gSW5kaWNlcyBzdGFydCBmcm9tIDAuDQo+IA0KPiA+
ICsjZGVmaW5lIE1UODE4OF9WRE8xX1JTVF9NRVJHRTFfRExfQVNZTkMgICAgICAgICAxMA0KPiA+
ICsjZGVmaW5lIE1UODE4OF9WRE8xX1JTVF9NRVJHRTJfRExfQVNZTkMgICAgICAgICAxMQ0KPiA+
ICsjZGVmaW5lIE1UODE4OF9WRE8xX1JTVF9NRVJHRTNfRExfQVNZTkMgICAgICAgICAzMg0KPiAN
Cj4gLi4uIGFuZCBhcmUgY29udGludW91cy4NCj4gDQo+IENvbW1pdCBleHBsYWlucyBoZXJlIG5v
dGhpbmcgdGhhdCBpdCBpcyBmb3IgZXhpc3RpbmcgcmVzZXQsIHNvIHlvdQ0KPiBnb3QNCj4gc3Vj
aCByZXZpZXcuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg==
