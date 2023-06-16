Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940BB733282
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbjFPNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:50:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E46C30E1;
        Fri, 16 Jun 2023 06:50:14 -0700 (PDT)
X-UUID: b6d409460c4c11ee9cb5633481061a41-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6roz/pXeZVYncJyhBUS4e/3iCK5ZMm9ooypAX2mtRIY=;
        b=UOEJsm4reYWx6Epc8KxxgNtuXHY1hw+4JopYaBNOQqfOhmYbkauSPKMktGA8w9BDlYWUekt5LiOAOWj68xbqUW/wT7un/wymyr08OCLEY67Y7X8epmFoI6zs93xpO9KJfYgyyBSgL/N+JUmTFAfYHR/yC6JYNehcslnAZ3OJJWE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:2d0ff1ab-fa37-440f-9924-adfd0b429b37,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.26,REQID:2d0ff1ab-fa37-440f-9924-adfd0b429b37,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:cb9a4e1,CLOUDID:ae8caa3e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230616200056BH4LB096,BulkQuantity:12,Recheck:0,SF:17|19|48|38|29|28|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_OBB
X-UUID: b6d409460c4c11ee9cb5633481061a41-20230616
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2134715510; Fri, 16 Jun 2023 21:50:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 21:50:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 21:50:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbnyfsxZ7trTn1K4Zw2uHV2TMQUWyeyb5X8f7u+BSS6MYYvaW+Id7BsK7PZhzQicDQjryVM7YLcVtrMAY4TDzWOxPN6bKSf8qunxKbOL5fyDEXMbCDSPY4wyiZBZb+TjO51rgmwtlFSsY4268YL3nQstG08Tx0NJTkktELNpKN+qxHrs3RBJubBfKVpc49ouz3QIqneHRCYDPWJheb98hjL59PVjS3FN9LgjwIRb8VjeUzaVc+21ij79FZg7TzLkp4C6DZkc/dGdeMJrw0Sr9j793ndFCFR099Gng7vZLWXR1BSWeRmWIhSgTSN/AggIGl6riJehr+gLlbFjz0OPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6roz/pXeZVYncJyhBUS4e/3iCK5ZMm9ooypAX2mtRIY=;
 b=WW3QWncjNX89kYiwi+QnUMYUgMF06o9ssL6n0OAD0htvPJM9luG9jqnJe+eC3H/kpD/KVPXZzNN3mRP636Cl1koWuJlKB4H998lor+n2y6lLZO5FSYcSGpy4mUhG2sBLtNswsnPJHIkTX41HlvLObNMehbjTUVOYdehb3J3lPRa5+EPB4SoaN2DoHgutyHGk200YFr0hq8aM91ZeQuzANd6hgUSVMUjxAhbPsubLH/6t+qLO9oraYXarG6cxTu7b6f+lcewzOUJe7CqO/pQ/BL1ukwyJFqw7G4XJM8DewWbTw65ubX3HkHqiKRzyVPfOj/wTSWwPwS6Q8wk9ezEzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6roz/pXeZVYncJyhBUS4e/3iCK5ZMm9ooypAX2mtRIY=;
 b=FG5LaYcRqx8Gtb+3s1bR3HGwwDiyPM3t9eNsM8i5oOl4sQXE/hWsNx0J/db0ESX578ZZMqtoLOoxUoQ8PpAY3jwxqq0cIfjP8HU6oGdVUo3G30a40xIHH05p5Q2BCSPlS/5tNmg8/J3Rn2yKAiArikUOU8k1RrUfESHlQ5C861o=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB6374.apcprd03.prod.outlook.com (2603:1096:820:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 13:50:08 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 13:50:08 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 02/13] dt-bindings: display: mediatek: mdp-rdma: Add
 compatible for MT8188
Thread-Topic: [PATCH v3 02/13] dt-bindings: display: mediatek: mdp-rdma: Add
 compatible for MT8188
Thread-Index: AQHZoEemJpSg8qsEdUqY6jBtv1KZ3K+NU9MAgAAeiIA=
Date:   Fri, 16 Jun 2023 13:50:07 +0000
Message-ID: <8f45b1afe4092e23836d43c00531cfdd863d6daf.camel@mediatek.com>
References: <20230616114111.17554-1-shawn.sung@mediatek.com>
         <20230616114111.17554-3-shawn.sung@mediatek.com>
         <30c913bb-fd8b-9290-65c6-4d757135b731@linaro.org>
In-Reply-To: <30c913bb-fd8b-9290-65c6-4d757135b731@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB6374:EE_
x-ms-office365-filtering-correlation-id: 46c9a380-c128-444e-94ed-08db6e7098ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNHIie6sY+lhiZFeGTi5kqGn+EdPFOGA79u5uouzlGzJP/frMPaoHEcSDS8rAjH7I60K4XwNLSFQUjKidXDOaoD3W+UhtZoG/WxP1Dp2gua1P07tYEUaJLzJuZlBMWLqYM645KlpjXAjrXaYWgbY9hVx1YNGtOeceNFXAXNKpJrXu5evkd/uE3aiqgnKOjJh08NwucltSyQnwnamPHb6n8QC2H3D8SqiUXi9C323/agPK0eSzKs9hxjna4l7KsXyQlgLZf2Ry2Wi8VsEUnvrxAZZQA7L/6u6PFxeQip0dPy3WDs6YskOkBi3UY/ji5lzQD+nD59VKVRhI/WZxQu4KNCNH7yuMdadQANb5GcNQbP6WIYfxIjhrscF4vs3i3d7yanN3h3phPxYuh7Tsvd7kw2MGuFd0gMieJ+a5jU5VXo5zICNMi3mJeKKmkTBrvPDGeQeIY9cyG5QtBeUivg/WEE1RAt8N4XMMkeyEopX+2jhf+oDena5NAFj4IT0F2eWeug/0x2DLcyhKISJLvhkp03CvgB6W/Xp+HZ8vQIsMxvWG1lyFDUBi2wVQU5b88XQ9k8NgVXwPJB7l85gwFtc+Imt6KbtiE8/ZpdTt2W0fDU9vHPjX5E5htu2TMmw1h8ID4wzBcXio0rbn07G+i1dA1eorzWGLR5oiFYzkASts94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(6486002)(2906002)(4744005)(7416002)(4326008)(8676002)(8936002)(122000001)(41300700001)(71200400001)(316002)(66946007)(66556008)(76116006)(66446008)(64756008)(66476007)(2616005)(186003)(36756003)(85182001)(38100700002)(86362001)(110136005)(54906003)(38070700005)(5660300002)(83380400001)(478600001)(6506007)(26005)(6512007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDVNdGFLUER0YkVvSW9iaWFNUDhwNEhQVkNQOUE5NkJnUGp4NVJEMWMwQVNi?=
 =?utf-8?B?VzBaRDIrM01vVHVrSDVxVXpHckh4UHk4QXZZMW1JdjR4dlJ6M242bnRMTlhF?=
 =?utf-8?B?OU5EZ2V5ZVo4cklOSXdpK0hpUG9taldBblF0Mm9kRWtYT1NwRmdpMHU0ZDlT?=
 =?utf-8?B?MWdMRm1RVVN2dHJlTFNmQmJrSDNUVHBMclRRMHA2TmdvNFp4bFZudnVka2Vl?=
 =?utf-8?B?L0lKRkF4Ylh5MmdqN2owWXJjRmFsL08xUFBQbzZueSs5akVMYmRnTFlrdVN2?=
 =?utf-8?B?ZXZqeTNVaXQrbVc1V0VOSE1kN2h0d2xvdlFLUlY4b2NRTVBlRHRKaU5Vbnkz?=
 =?utf-8?B?OEdzT0FoWThSNlIxWG5pQzJjbm8xa01PTi9kOFBQaXRKVHptMUZRczRzRDB0?=
 =?utf-8?B?V29UMkRya1hNSlN5ZVFjeFhKTzZxM0liaDFrQ0UyaU9UUmZuQU92bzI0OC80?=
 =?utf-8?B?d3Z0WUJNeko5bVIvVmF1Vk1oOFlmRW4rYU44d2ZSQmxEQU03RHBkbTZkd1lk?=
 =?utf-8?B?bmUra0tsNHJpMlJvU0JiQ1NLR1dURmQxWUErQWZSSW5Od3I2MDQ4SFl3SVFl?=
 =?utf-8?B?NlVGck1wRExuRHFNakxranluZ0hiUHAxM2JSWUxRZUhKdFRERHc3NHo3YlBt?=
 =?utf-8?B?ampxVWpWMkhDcnd6VHpMSVg3T1ZwMVplb0FpQUNlZ3dMWGtvM1F0UlhYa1Vr?=
 =?utf-8?B?TjVqdnllUEZvRWt5VkNWRXhxaHRJMnZMNFRDelRuZUlKYnhDaUtPYWxBYnBx?=
 =?utf-8?B?VHNUbm9mMGpwRG1vTUErZmRNeTN6VWJsMUFFanU1OXBTN3lPQkdValF4aERW?=
 =?utf-8?B?Um9QaDhoV2J4UFlXajhaVGNJTHR6cG1ySFplQlF6Q3I0dHVIdlFQN3dYeDky?=
 =?utf-8?B?c2RkT0ExazBQL2pIV2RnK3FKd3JwdWE1TEdrWUltUXZ4SmlhQnFVakZLZUUx?=
 =?utf-8?B?YXJUd3VWUHVkNG9aNW0wZnpYMzh0bzFOc1hWNS9Ha2lsOENqU3RzUFpQNlZS?=
 =?utf-8?B?TUt6bWZuM3J2aDA4N3FSUHlFSlZNWU01SzB3a3k0L2dSbXFoL05McldyUjU0?=
 =?utf-8?B?U2tUdXdVNk5QcnlpL2IrMHI5VlRBa0xWOHZKWVVLRVg4WHJKcjRZcmVjaXdl?=
 =?utf-8?B?V3lwVWIwcGpqUHdWUm1WWXM1WG92aC90ZjFXdnM4K0dLb3ZJalVUQUFQZVlt?=
 =?utf-8?B?VWNLak00WXdsRG8yMU9TcnVpRnc5dFAzcDRHL0ZuaXM2aTlzbjV4dDNKWjgw?=
 =?utf-8?B?WFEzakl4eGhkc1NaQ2ZvOFhWRHZlT3I5YXB0bVFITGR4Y0tRSURtOVRETmhN?=
 =?utf-8?B?RHdRU00rbDBJZGlKTS9RT05xWVhHMXJ1TjVsdkNVVEVObTdKekQwcVk2RnhT?=
 =?utf-8?B?aVR3TjBhRXhmVWdxRnZWbVBuVmVHUkVWZlkrNk9jdGh1bmFBQjBuRENHRkZS?=
 =?utf-8?B?ZzBudWM1UEppOE9ZUFR6NUIwd2V6bWNVdjlyY3FyMEsyRG5hdnMzLzZzaWI3?=
 =?utf-8?B?UkIvZE1naFFTY2k1di9FSGs0WFd2dnBUOTRnMjJ3cnI1SGxCdWRMUWJLM25W?=
 =?utf-8?B?WTB4dk1KczVYTDFVeFVwWmkyUHBHQ3BnT3cvQW8yZTc4Sk11SytjdmVZV0Nh?=
 =?utf-8?B?dStPN2JHdHJRMUwyWjRMZ090akhsTm5SRElpVjlCQm45L25mQlFKY2FXRXJD?=
 =?utf-8?B?ZGlEdWY3bTgyMERST1hmejFCYmZYMWN5aUZNb1BEZ1U0R3NZYS9mWFZzLzcv?=
 =?utf-8?B?YllLaDhmb05Ja0RuL3UrVXRocFppajR2ZEpGamVvRVFqODE5UzVRLzNXdUdP?=
 =?utf-8?B?U2lINHFUWld0M3pKN3MrRGxHeG9qdytDVFAxeEUxZGV1VXYwUUREVVNmVmpj?=
 =?utf-8?B?MlN5NHRKdHJnNzBxdEJ0UDE0R2tSUnVLOG5xU1V3U0ZhaUttY0NMYU9oVzl0?=
 =?utf-8?B?MFhZWlIzNVF5QlBFZHV2NDg2eVhDTCtJN2VqYWZYTjIyWHdrcmNETVpzcmM5?=
 =?utf-8?B?cURwUUpvd2tUSUVQR0RxajM4bmU4elRjZ0pPWlpVVUhrOFBjUmZ0OVJVOW5o?=
 =?utf-8?B?c0xPekJmdEhCdVVKbTZwclZJd29zeWhaZkIzYjhKUTRZd3lER3FNZG83ZXZo?=
 =?utf-8?B?bHp4Z1MwNUhCNU9YRVR5cnZrWjVrRGhodENkMXhlRFhRQzdlRm12TElsT2VM?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07BA0E70F362C74D9229909693CF9D52@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c9a380-c128-444e-94ed-08db6e7098ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 13:50:07.9406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StRIYB8QhgOyKRh85cHD4cs5pFbJTq/OVeByUdBfuj+9Hg0v28m9N0ZkuaOpFQMYlVx/Uvyi4gf2s4433lR0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDE0OjAwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE2LzA2LzIwMjMgMTM6NDEsIEhzaWFvIENoaWVuIFN1
bmcgd3JvdGU6DQo+ID4gQWRkIGNvbXBhdGlibGUgbmFtZSBmb3IgTWVkaWFUZWsgTVQ4MTg4IE1E
UC1SRE1BLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXdu
LnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gU28geW91IGlnbm9yZWQgdGhlIHRh
Z3MgZXZlcnl3aGVyZT8gSSBhbSBub3QgZ29pbmcgdGhyb3VnaCB0aGUNCj4gcGF0Y2hlcw0KPiBh
Z2FpbiwgaXQgd291bGQgYmUgYSB3YXN0ZSBvZiBteSB0aW1lLg0KDQpTb3JyeSBhYm91dCB0aGF0
LiBUaGFuayB5b3UgZm9yIHNoYXJpbmcgaW5mb3JtYXRpb24gaW4gdGhlIG90aGVyIHR3bw0KcmV2
aWV3cywgd2lsbCByZWFkIHRoZW0gYW5kIGNoZWNrIGhvdyB0byB1c2UgYjQgdG9vbC4NCg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkJlc3QgcmVnYXJkcywNCkhzaWFv
IENoaWVuIFN1bmcNCg==
