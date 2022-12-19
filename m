Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895BC650753
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 06:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiLSFgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 00:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSFfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 00:35:53 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D321D0;
        Sun, 18 Dec 2022 21:35:42 -0800 (PST)
X-UUID: e6c7aa5f0abf4611a4e3bd5d3e8aaaa9-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+uMF6PgKpKMiFHQyezkbI7zVwgXHmFVpDvWnPfKzPAM=;
        b=PRg2vV3B079EkEAjD2abTJSJgLvHafzJFLmM16KckrGYn8UpVTgNyfT8oiwXP8OeRp2t1PQpXWeaLSAym7FltKW+8nIcpoX46VG8t45MQrsUKzOQbP84DFkpL3fnTaWWIHkVmH4fSYNutapACoAaOJ99N6fPtsv0YpyTI9XHiAM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:11a0dab1-3163-41ed-b67f-cdbbf8d90382,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:afea1e52-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e6c7aa5f0abf4611a4e3bd5d3e8aaaa9-20221219
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 557436370; Mon, 19 Dec 2022 13:35:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 13:35:33 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 19 Dec 2022 13:35:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO3vcBgZmEhdLktkwRGy3AS4VS+Br5QFvcdM0r5jkCAwp/1GhVBr/5FdVK6E16EmPlFd1UAQjWSFaZeywLYWtHgASwudy5A2aXq5KX2cASTMwfZBQtCg/tRah2R63H8KHkmGOcEFgRxbTPIwaqpaIuO4ihBLBXuUZuOh81B2ueD6shlUZQkmZ7IRb4ps8P+uPseocFai5ydoaLxXT2+faEx2abZMEkYctYzq4ykSMbDehDkx0Eds6KyZSOFKo2Shz6XXGn2LjeKU6Xw7+P+uD3zppSSssfw94QlpWszKSySOqW9dIHAy9vmdHDw/0WMFFM8cFoj3VREjZqb9xd4W5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uMF6PgKpKMiFHQyezkbI7zVwgXHmFVpDvWnPfKzPAM=;
 b=h9dj0mIkxJ8Q0gf5mzJUmUZEPvRxlKYKso6FgvxEDWg1cnlc7kKgf9cTju3og+LO5ZD6gjKtB0mVFEWOy+80zgYaGszYQKGRxvZwWHAu2uVqPfLsUO5hj5qecvbSXE4aFQa5eHss1ecJHtLg6TumrSAPGZ2JJJ3hkvIsgiayb5KS2BrFgzkbgdS2A396/Z+BPynDZYsYLgw/1bhIascMD+7mJFRw352DBvM7c1InVL7rKbJuy4e6PInb9ashzl6Ei1AjM9BbVuAZ4t08QIQ0GDXcWQVvmsmtXJRcjIukat1iVeAlNICl4u4M6VXKe87yaQCGmRcnSM3zNC0WGzXhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uMF6PgKpKMiFHQyezkbI7zVwgXHmFVpDvWnPfKzPAM=;
 b=FtNpipRgGoUoHOl/YyedcvK+VVW5lzR9Gjm3pOYVxSOgoW8Az85z/7TUnHgUoAm1zyyQumPsYwqwKBal7gp5shMmAOueVrBYjj42iXoajUlFrG2LjkGLLB9+6LPVdWtyW302N0H6mMLGZt9Pmnx674bMQvkBvOMwaw3eoLpJmOE=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PUZPR03MB6076.apcprd03.prod.outlook.com (2603:1096:301:b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 05:35:30 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%6]) with mapi id 15.20.5924.012; Mon, 19 Dec 2022
 05:35:30 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHZCrW9BCZh9S7ETU2R3v1AiYWaeq5lWPGAgAALRgCAAEMtAIAD6koAgABjwQCAAf37gIABXv+AgAdvk4A=
Date:   Mon, 19 Dec 2022 05:35:30 +0000
Message-ID: <ef251dd7c70a262c5144da3008ea7509f2a35a59.camel@mediatek.com>
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
         <20221208033148.21866-11-trevor.wu@mediatek.com>
         <d7d9f3c7-b3e3-1e13-a80f-c7bf7b38a5b1@linaro.org>
         <45b4b287dfd57b99e0ba5675bf99194f6d84d9da.camel@mediatek.com>
         <fb34e446-2904-a357-e54b-3e82a2b0745c@linaro.org>
         <e08fab2a694313abc12e0f8303de3e2e704b388c.camel@mediatek.com>
         <e20884d2-5d30-9519-d070-8e2ac07f2171@linaro.org>
         <6eae5d7eef22443b6152c6655c89bdfd70e59089.camel@mediatek.com>
         <dd2a373e-d3a7-cec9-6608-379d61f4228f@linaro.org>
In-Reply-To: <dd2a373e-d3a7-cec9-6608-379d61f4228f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PUZPR03MB6076:EE_
x-ms-office365-filtering-correlation-id: bdcdb9c2-3e8d-4167-9c62-08dae182d765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 36ugEfNvxCXTfBnt/IRxZ1l1GImyhsaH+fKAlIA0vAe6WAm6IiQx/opvXeeF+au2tv9amSy9utNKR8MmumY2Ym7qgf12JC3PUwLkiEP3f6DXz3bfmvsB6f6ltExBWzusiFpmwDS6hyuxPqwi+52iKtdZQyFRFooMqN4Lc0RMuUaZft+hvTFhPT+Kvu/BpZdmJu4nIWlkiFTgU0GnF88N3vSxoTnMJK08A2zp31pEyqpJgSglbtDmLoel+dtRhifhwa2m8jRLtphXN3SWVa1dZCN2EHpPiT8fcLDlgK+hMpChT+srPukwnXXYFQ6Vzk2/Nnk/JGFDCuGa9wMn4rh9UasJVQFMO9wwMdYKIgeDj3roUXP6tamC/ttO+tCPHxH8hOmpE0lj1mrrVxdN64bB5Ubp+4KCWpSfzJe5t17u50KBdGYbPPVoRPaGQjmgtZDhCUJAmIeb9fFousQnSG2nC5+U2m7b1xZ9JNNT0dL2OOY3uJg6mB4nzWr0gnjn8dpjcsqV9s2j5aOiDPLh7jQAPIu2MrjK6qClcHObSQveQPc+jSk1zAINYuT09N/B0mZw6602Kok5Ifbj4Pv2a+A4HFlim/uidn3wDSOzAgK6gRIppapxMv6z3SZ7Hjqn+vhTXmB/B+L9BM7cr5bmS//s/58koeby2TkwMhalhj3wGonsatOo0QomT8Ihqac2RqND19qXRK8iAt7i4kdmnqpnBlASyclWHPllePlCLF8KXUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(478600001)(6486002)(71200400001)(66946007)(316002)(76116006)(2616005)(26005)(66556008)(66476007)(64756008)(66446008)(6512007)(186003)(110136005)(86362001)(54906003)(4326008)(8676002)(4001150100001)(2906002)(38100700002)(122000001)(41300700001)(6506007)(83380400001)(7416002)(53546011)(5660300002)(85182001)(38070700005)(8936002)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTU4anUzdjd6QmUzYXpkUU9jVGM2NVdncVBoeGgveEhMR0QwNkRTZ29vTSs0?=
 =?utf-8?B?Vk8vcndTamhOMFo3alFWYThUV0tDV2ZRbG85Rk1GU01NL01sY2l0M0o4Z091?=
 =?utf-8?B?SEVRSUlmWEV3QkovbFZqcnV2YUVRdE9qaEwrSjZQYVR6bFcrd0xTQXZZNHU3?=
 =?utf-8?B?ZkJNdC81ZXY0OGdGRE10MTBNYjFXSm5QN1ZNSnhINStJd2FHM0ZxaldXR3JK?=
 =?utf-8?B?S25WS0U3UFNEV2djalhrVi9kTFhGTytBSG5sMjVmMEJrL0lDcUNvMFMyYS9y?=
 =?utf-8?B?QU5EbXVIUWNZdE5uRzJDRUZlOEFIZVpCK3dzL3NYNTJva0g1SFFYSUZZY0ov?=
 =?utf-8?B?LzI1OHZjYnFGT3BGeUFTTXVOckFUdndMTFh1Mkg4Lyt0SVJTUm5KSm5YVFQ3?=
 =?utf-8?B?OUpvRzZ0T3d6SWhnc1MwaUcxZXBETGUwVy8yYVAxV2ROMFVpNkMxYVdLRkxE?=
 =?utf-8?B?MUVORWNZd0xsbS9ZSmRrL2J0Ni81VWl3RnhhV3FoeDVQSDJ5bUlobTA1Vnh3?=
 =?utf-8?B?VU9lQjI5Q1hrMDdMKzVQWFB5UjdOOHRWbkNJdG02SkduZWk4cU4zZHYraUd1?=
 =?utf-8?B?ZXJlK2xjaFk5czJySGhjWVlBMXZrZGN0K3gwZTdsY3RiSEFweFRBUmtpNXlq?=
 =?utf-8?B?VWs5Uyt1MHVzSDdHRS9tSWswZytWNVQ1VVgvY0liU3gxNEVjWHJ1SXdUS0RV?=
 =?utf-8?B?WlVtYjk2NDl4Sy8yV2JMUGswZ3hZK29kdTNTcmw4cFpoalYzSEtTTFRQS0l5?=
 =?utf-8?B?Z3p3TGhwM3FKcjYrLzFaTTJrajlla2tMaER2S29FWmgzZlQ1ZWNPdzdoNTV3?=
 =?utf-8?B?ZnVySzltZnBOaTVpeEIzYkxBb0E5Z3llaXllWm5LQlhya0ZSZUFyNU81MG5h?=
 =?utf-8?B?V3dYSENCcXRJYlRETkU5dWdHTHoxVUZ2TkRxUzZTSUZkYjkwKytNU0oyVWVJ?=
 =?utf-8?B?NDQ4UWF2RWxkWkpRWDZNbEhsalVzd21aWXhPTEVBU2g0N2lQbHF0WWRBTU1l?=
 =?utf-8?B?eXhGSGdhQU00RjFicHFLMVZoRFZVd043SnUwTE82ZXVKRmRxV05sUXJ4U2RS?=
 =?utf-8?B?TFpyckZKVGlROHI3NmNuTU43aWpOUzVFN3VDbW5CelBxczVnNks1YktBalE2?=
 =?utf-8?B?U1dhS2VCYVc5ekNZTllWNVhRQkFCbEpySFJYeXBlOWludzBNOTNGTkhkOFl6?=
 =?utf-8?B?Y0E5bFBPeW9BR0pGKzg2Q3JlcnpGZHZpQ0NxRFhLSmJSNmROOGk5enQ3Nzhl?=
 =?utf-8?B?VnkvV2RUMElCSVBCcjdxZ1JuOXQ1WDdEVnFiMzZYUm50eWtJRFlKWVRzVG9t?=
 =?utf-8?B?TDBYR2xrdlZEZThhak91WThNMTlMcnJRM1lmaThaZTVqMHJObG5wMGYrVUk4?=
 =?utf-8?B?cFYvbGJ6VFdkYmMxaDZVOExUOStmZUVPbWFISWNaUUJEdnJzZTF6S1piSm1t?=
 =?utf-8?B?UHJWRGVHVkVKV0FtU2l2OXVPMjhXVlJOV096RHJwNTR6ckVQcjlXTjZkbDMr?=
 =?utf-8?B?WDZCMWN1TzF0SW9WUkxGRUdsUXA5bmV4NG5FR3RYWkVtWVYrQVN3V3pRUEsz?=
 =?utf-8?B?RFhBdVJidE1mQ0I1S05OOHJVeEZOdy9oSVhHZ3d4R1FYZXlBRENTUWpaSTRZ?=
 =?utf-8?B?V29yMVhPZG93TXE4UHhpU1kvUGFvNzIybVlnRkw3d0taemp0cW9FUjhYU202?=
 =?utf-8?B?Rnd3d1lwMzNCZGV3aWVQZ2VXU0J0VmwxNWhTS0c0ZTdCRDlMYlFTb2hvb1lh?=
 =?utf-8?B?N05KdTY4bEQwMFVQMHlQd29xYS9tYXVMZlhuajBmWUdaQlh0bjllay9aSklO?=
 =?utf-8?B?R2R4WThwbEJYc2xCdnVOQk5IQTU1UHZYenhpN3NQSWhNU1h5ci9kaFdYZUJ6?=
 =?utf-8?B?NldhTUJnMWlkQXRUb0ZiRTlQUjlDN2JRc3VSL3U3bVZxSkhKV2dLVkRpZS9G?=
 =?utf-8?B?Vm5XNU93RTNRa3dSYmdWQ3NOMnZYTlFxeXRRTlk2MDVLRmtkZXRCMmUxRitW?=
 =?utf-8?B?eFFJYlZldUdPWmlZYWxweFFYTWJSMlNGb1hPWUNoRnBrTU5MdENYcjV3b2dN?=
 =?utf-8?B?bDZRa2FoUkVSMDgyUXlZSG9XdHcxMFROZFFDeFRIOWcwRUFIV2RWTzZNNldv?=
 =?utf-8?B?K0kvWGdaWTdUbS9FMmVhNW1mN1JpeUtPa1NjUVJoTS9ZWHpKVjQzaTJFUmw2?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <954A3356A102A14D9C93A45D3267E01D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcdb9c2-3e8d-4167-9c62-08dae182d765
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 05:35:30.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzOVHu73s2y1NTYfazm7h0ns48BdVPYEc7enLxsUNMuGyYU/tFj2MA9kjqWZDBVnT7tpGdRf0a9GFK6be40spA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6076
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTE0IGF0IDEzOjAyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMy8xMi8yMDIyIDE2OjA2LCBUcmV2b3IgV3UgKOWQs+aWh+iJrykgd3JvdGU6
DQo+ID4gT24gTW9uLCAyMDIyLTEyLTEyIGF0IDA5OjQwICswMTAwLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPiA+ID4gT24gMTIvMTIvMjAyMiAwMzo0MywgVHJldm9yIFd1ICjlkLPmlofo
ia8pIHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gKyAgICB1bmlxdWVJdGVt
czogdHJ1ZQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiA+ID4gPiA+ID4gKyAg
ICAgIG1pbmltdW06IDANCj4gPiA+ID4gPiA+ID4gPiArICAgICAgbWF4aW11bTogMTUNCj4gPiA+
ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gKyAgIl5tZWRpYXRlayxldGRtLWluWzEtMl0t
bWNsay1hbHdheXMtb24tcmF0ZS1oeiQiOg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgZGVzY3JpcHRp
b246IFNwZWNpZnkgZXRkbSBpbiBtY2xrIG91dHB1dCByYXRlIGZvcg0KPiA+ID4gPiA+ID4gPiA+
IGFsd2F5cw0KPiA+ID4gPiA+ID4gPiA+IG9uDQo+ID4gPiA+ID4gPiA+ID4gY2FzZS4NCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEhvdyBpcyBpdCBkaWZmZXJlbnQgdGhhbiBhc3NpZ25l
ZC1jbG9jay1yYXRlcz8NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IFRoaXMgaW5jbHVkZXMgY2xvY2sgZW5hYmxpbmcgYXQgaW5pdCBzdGFnZS4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBhc3NpZ25lZC1jbG9jay1yYXRlcyBhcmUgYWxzbyBhdCBpbml0IHN0YWdlLiBJ
IGFza2VkIHdoYXQgaXMNCj4gPiA+ID4gPiBkaWZmZXJlbnQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBJZiB0aGUgcHJvcGVydHkgaXMgdXNlZCwgdGhlcmUgYXJlIHRocmVlIHBhcnRz
IGluY2x1ZGVkIGluIGRhaQ0KPiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gcHJvYmUgZnVuY3Rpb24u
DQo+ID4gPiA+IA0KPiA+ID4gPiAxLiBzZXQgY2xvY2sgcGFyZW50ICh3aGljaCBBUExMKQ0KPiA+
ID4gPiAyLiBzZXQgY2xvY2sgcmF0ZSAoTUNMSyByYXRlKQ0KPiA+ID4gPiAzLiBlbmFibGUgY2xv
Y2sgKE1DTEsgT24pDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgZmlyc3QgdHdvIHBhcnRzIGNhbiBi
ZSBkb25lIGJ5IGV4aXN0aW5nIGR0cyBjbG9jaw0KPiA+ID4gPiBwcm9wZXJ0aWVzLA0KPiA+ID4g
PiBidXQNCj4gPiA+ID4gdGhlIGxhc3Qgb25lIGNhbid0Lg0KPiA+ID4gPiBXaGVuIE1DTEsgc2hv
dWxkIGJlIGVuYWJsZWQgYXQgYm9vdCB0aW1lIGFuZCBrZXB0IG9uLCB0aGlzDQo+ID4gPiA+IHBy
b3BlcnR5DQo+ID4gPiA+IGlzIHVzZWQuIFRoYXQncyB3aHkgSSBzYXkgdGhlIHByb3BlcnR5IGlz
IGRlc2lnbmVkIGZvciBhbHdheXMtDQo+ID4gPiA+IG9uDQo+ID4gPiA+IGNhc2UuDQo+ID4gPiAN
Cj4gPiA+IEhlaCwgc28gdGhlICJhbHdheXMgb24gY2FzZSIgbWVhbnMgdGhpcyBwcm9wZXJ0eSBl
bmFibGVzIGNsb2NrPw0KPiA+ID4gSG93DQo+ID4gPiBpcw0KPiA+ID4gdGhpcyBldmVuIERUIHBy
b3BlcnR5PyBUaGF0J3Mgbm90IGhvdyBjbG9ja3Mgc2hvdWxkIGJlIGtlcHQNCj4gPiA+IGVuYWJs
ZWQuDQo+ID4gPiBZb3UNCj4gPiA+IG5lZWQgcHJvcGVyIGNsb2NrIHByb3ZpZGVyIGFuZCBjb25z
dW1lci4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gSGkgS3J6eXN6dG9mLA0KPiA+IA0KPiA+
IFNvcnJ5LCBJIGRvbid0IGtub3cgaXQgaXMgbm90IGFwcHJvcHJpYXRlIHRvIG5vdGlmeSBkcml2
ZXIgdGhhdCB0aGUNCj4gPiBjbG9jayBzaG91bGQgYmUga2V0cCBlbmFibGVkIGFmdGVyIGJvb3Qu
DQo+ID4gDQo+ID4gVGhlIG9yaWdpbmFsIGlkZWEgaXMgdGhhdCBlbmFibGluZyB0aGlzIGNsb2Nr
IGluIHRoZSBtYWNoaW5lDQo+ID4gZHJpdmVyLA0KPiA+IGJ1dCBhIHByb3BlcnR5IHRvIGluZm9y
bSBtYWNoaW5lIGRyaXZlciBpcyBhbHNvIHJlcXVpcmVkIHdoZW4gdGhlDQo+ID4gbWFjaGluZSBk
cml2ZXIgaXMgc2hhcmVkIGJ5IGRpZmZlcmVudCBjb2RlYyBjb21iaW5hdGlvbi4gQW5kIGl0J3MN
Cj4gPiBlYXNpZXIgdG8gaGFuZGxlIHNldF9yYXRlIGFuZCBzZXRfcGFyZW50IGluIGV0ZG0gZGFp
IGRyaXZlciwgc28gSQ0KPiA+IHB1dA0KPiA+IHRoZSBwcm9wZXJ0eSBoZXJlLg0KPiA+IA0KPiA+
IERvIHlvdSBtZWFuIGlmIHRoZSBjbG9jayBjb25zdW1lcihhdWRpbyBjb2RlYyBvciBleHRlcm5h
bCBEU1ApDQo+ID4gcmVxdXJpZXMNCj4gPiB0aGUgY2xvY2ssIHRoZSBjb25zdW1lciBzaG91bGQg
ZW5hYmxlIHRoZSBjbG9jayBieSBpdHNlbGY/DQo+IA0KPiBZZXMsIHlvdXIgY2xvY2tzIHNob3Vs
ZCBoYXZlIGNvbnN1bWVycyBhbmQgdGhleSBrZWVwIHRoZSBjbG9jaw0KPiBlbmFibGVkDQo+IHdo
ZW4gbmVlZGVkLiBDZXJ0YWluIGNsb2NrcyBjYW4gYmUgbWFya2VkIGFzIElHTk9SRSBvciBDUklU
SUNBTCB0bw0KPiBrZWVwDQo+IGVuYWJsZWQgd2l0aG91dCBjb25zdW1lcnMgKG9yIGV2ZW4gd2hl
biBjb25zdW1lcnMgZGlzYWJsZSksIGJ1dA0KPiB0aGF0J3MNCj4gc3RpbGwgbm90IGEgRFQgcHJv
cGVydHkuDQo+IA0KPiANCkhpIEtyenlzenRvZiwNCg0KR290IGl0LiBJZiB0aGUgaW1wbGVtZW50
YXRpb24gaXMgbm90IHN1Z2dlc3RlZCwgSSB3aWxsIGRyb3AgdGhlDQpwcm9wZXJ0eSBpbiBWNCBh
bmQgYXNrIGNvbnN1bWVyIHRvIHVzZSBleGlzdGluZyBjbG9jayBwcm9wZXJ0eSB3aXRoDQpjbG9j
ayBjb250cm9sIEFQSSBpbnN0ZWFkIHdoZW4gd2UgaGF2ZSBzdWNoIGNhc2UuDQoNClRoYW5rcywN
ClRyZXZvcg0KDQoNCg0KPiANCg==
