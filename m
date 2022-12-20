Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A826518D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 03:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiLTCgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 21:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTCgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 21:36:43 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043711834;
        Mon, 19 Dec 2022 18:36:36 -0800 (PST)
X-UUID: 4628212bc0c14223969f3d4481274414-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=olSPwUf/OE2n/13B0GTiwvvwih4POdExk/8AfIYMvpU=;
        b=LTAH73YnmaUHq8hdP8oY/DuLYDVTg2yBMBhR6b2Ivha8pPyVBVWkuR5LaxL1prjUHAjEPYIJTUjAC3iKdVR16lb2icovaLttm1JfEY4ib0JDW5uokvTJndV9GATKcemAa2BXkSQGdrx8vOA06TNOMboWtEoR1dLGEY21F2X1tYY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:69961920-29b1-4bba-84cb-cd1b5961147e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:69961920-29b1-4bba-84cb-cd1b5961147e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:45e863f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:221220103631GAVAEPSR,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4628212bc0c14223969f3d4481274414-20221220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1145990944; Tue, 20 Dec 2022 10:36:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Dec 2022 10:36:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 20 Dec 2022 10:36:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKjjcxPaiscuXwzpRs+3nGmPgAIRCjejt4mibVOUwjFtw9tFA3m72o96BWFb1bktqdaj7ZLZL74LNLljs1RLqmmLhJCmWvQqbvVL36bDnylDWLfvrUocaHeqydiFQlPFahRfc6fLa6vbQLQ+Jwnyr6dXJFiocpRyvMMnwEcadszJTdaQ9VrZ9IC4VTwCE6aEB6VIooFM0L9N9eaMyvuGKo81CMkb7LFA6bZAACgHRpQc10DySnNZHsjq4W7BMeY4EXYewA9ZPHjIktbLyTNbfDL3eW/N3aUiyP94kAeCro9lPZketkTtI7X0qjmjK8e+ksMEWr+KvxE10fa5p/jTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olSPwUf/OE2n/13B0GTiwvvwih4POdExk/8AfIYMvpU=;
 b=cf2eQKltCD6lRAYgSFZsodsF1QzxNTxZBNaZLaf3P6w7HAaimsJ64j4JZTaAOf/Lpozhx3WNkw/dJSudEl2iKi68WbeRyIymd832yMNHrkaNkvLfiBWTVtnuVTZTRyUR1apONBjj8pIYDZpfmOsgVQy6SlH4ZDyqi3zxOA6CBUa9WJbOPWu32FmlT8Mg7tAyz/vUlTG1JJjxCQ5SVtAcWSlUvgUklR85ORxXv2ACNunEt0yj0pzOoYXiIxtTFLlyzOWU77yD/izlhbNgeRxEhwhk9hlefRTRJU5R4dGIU/WAdAhV0tzYrHxSdRv3LOQzREwKBRr9nVBZg/D3SDNgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olSPwUf/OE2n/13B0GTiwvvwih4POdExk/8AfIYMvpU=;
 b=Ag9l2TN/MCfPx+zDfXSTgfXEhoC4ACKB4OHVrzWPWGwEyzWf+tq3U9260sCSSr+X4y9eaM3LMrh7sQLgHrxj4MlioAw3G5twVRVSqGPeqsZ5HeJw5yujqlYnFvDK0ZQKMk570YQJlaMuQOP9BGnGgmmRZt4BVm663KAz5/uWuu8=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 02:36:25 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 02:36:25 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/4] soc: mediatek: pm-domains: Add ADSP power domain data
 for MT8192
Thread-Topic: [PATCH 2/4] soc: mediatek: pm-domains: Add ADSP power domain
 data for MT8192
Thread-Index: AQHZEHzp5xrI/E0hYUOI1JQtWB7bva5wXoAAgAW4OgA=
Date:   Tue, 20 Dec 2022 02:36:25 +0000
Message-ID: <952b9e987996e694695a24581a86582186200a87.camel@mediatek.com>
References: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
         <20221215120016.26611-3-allen-kh.cheng@mediatek.com>
         <9511c5b1-203b-a7e3-b96b-614e1c52639a@gmail.com>
In-Reply-To: <9511c5b1-203b-a7e3-b96b-614e1c52639a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|PSAPR03MB5351:EE_
x-ms-office365-filtering-correlation-id: b51a3c02-ac0b-4c6d-0e33-08dae232fd4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMoykV0k4Zmr3xa+TaButFYidK2IZqShuHPOGuAxiNNYqWY9O30i5egaybFvlQ4QXJWOce1/efP7qVnuqhCdE6TwvzPaFXIrLZcTngjjKY4y13RRDYvT6984amJhOwK63jdllK03R6fvf6E0MaVA7H6LSM1vOwXW5trG5lOlsQXHkVhp8IsCwGx/Px9gAf8wHPpOg089IPHIAY837VQLbk+7619AKRy1tmctw/gp+fu3vXMPVgtGYhRLmcdEuZ4YOnOdEbHhStGCdUXdn4rXzrdmadkMIw6Uqmw8YQIFWmOo7sAu1MODdAB017+WOP5FW9XO5JZ4G1BRkRjbrMjIgZfJsXVwCE/zFM9hDLNn98pAyjfKyGqkuGr7aLOFuZX3XTDNsKHockxnjkGgS7LMkAbZEoCZLuvK8Y3X9EpUKt409DB0zdJLIkg5zAFw70Ba3aRoPcV8kHSWRyOMWIo8XIfUYXZHIG0689QrTr0UoD7zsH/6zKYt+RIFVcN/dIWQCQDC6Rrm5O307pwznoStj+NmezeW+f2TRZMCnVJ5QPS6ZIIuFg9VpCqyqxJknAhl+yq/kc6QWorNN7qbm/WYdLvz4IRJxpQCcQUXGPNXYpFsvtkiS9FXP64xTfnvE+1Ol4BMok10nOEFBjNbHmocBUQHR6vHGHxllSbriYoA3+9KVzu5Qr5Q3U8oy1W0mVdkyy1k8AWNN898dNHt+cfQHGYqtJ5M74KzdvhgfVhwnb14L7XIcblDvmhIyeq6uMBk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(6506007)(478600001)(71200400001)(53546011)(6486002)(26005)(186003)(2906002)(38070700005)(86362001)(6512007)(110136005)(54906003)(36756003)(64756008)(66946007)(8676002)(66446008)(66556008)(91956017)(66476007)(4326008)(76116006)(6636002)(85182001)(122000001)(2616005)(83380400001)(41300700001)(7416002)(8936002)(38100700002)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2xCUmlkSi96WkU4cWVXMXVIWVdmTXB6aW5TNkIwSEE1V2FtWVpsVGdhVGdR?=
 =?utf-8?B?T21RZy9RZnA1a3U1eDFsQy8vT3pWRDJTWFF4WjNqOXkrZExLZVBGcW54UDdz?=
 =?utf-8?B?RHFOZi9OeUxydEljRTE2ZFp2M1NpeU1TV1ZsVWNpdUlVbU1QWFZ6NG5VQ2N2?=
 =?utf-8?B?bTUxZDFhY0xPam84M2JXYkp2ejBWSUZnZCtNL3BKWjNhSVZoeW9Md0QzaU9x?=
 =?utf-8?B?UlhKU3diME1iWHBWWmlFNDErbG15dW5LQ2kyTzhONWtPSkxsSFdTS2lkT2Nr?=
 =?utf-8?B?c3d1QmY5SjlMd3JnQ3B6UGZEUDJJbXBJdE1qR3pYY1VabktPWTcyenZOTFA3?=
 =?utf-8?B?Q2FDUGVSVExKWE84K0Fub2p3SGt4SU9WZlJ0UGdOaDlJUGhYNERCeXZsR0kx?=
 =?utf-8?B?SDBYUWpwRlE4NFkyNWNwT1ZZQXI1Ky9haDNqZ0tuZmR0RHRaZnBEY1pvendQ?=
 =?utf-8?B?bGI4ZDZPQy9aQ0QwaHFiRmxhakd1cTR0ajZFYjh3dmJsdi9JbGRJeVBPcmtB?=
 =?utf-8?B?dU5HWjdkSktnZlBteEttSzdZZVlVcllUeG83NEM5VVpzNUd2cmVIRUFWT0Q1?=
 =?utf-8?B?OUIvbU4rL1c0aGNBd0hWSTNMRlI2WlR2dkJORVkxMnFoOGxneDBSTlViTFRj?=
 =?utf-8?B?TDdvMXFOcnlqUUdVRDBKODErM0tYQ3RlWlBYaWxVWXhlTGV6UzAzaWZnVGR1?=
 =?utf-8?B?SGRKdk1ZUjluREo5VG4vYVMyR3ZSQjVhRkJFQVM5MlFGeTNVdEFIU3JrdGpJ?=
 =?utf-8?B?RHdOMXBTUk1vclBXMFJoS0hmZjNUWWRpRVJFOGptMEdreVUyb2MxRjFIMm1j?=
 =?utf-8?B?OTZzSXo5dHNzd3lPVDVSNllhQTg0c3FhS3JyTzlrR2Y1ZmFIdFRkNnc2ZHVR?=
 =?utf-8?B?bG9PYlRPZ1dBbEQrUGJPVFBNMmhKRlRaRitVb2RGMkNraTVRVndjRGVxaXMy?=
 =?utf-8?B?K0NhQURHRHAxYmtucmpjNHBLY3F5RFFVL3RZZFFWNmlGU3c5ZHg0WmVmV2dC?=
 =?utf-8?B?QU9CNkt6eW1QbGptS3h3djN1MTcvMDl5WXhjMUUvbFlUV1dwQkxWVmVIT3l4?=
 =?utf-8?B?S1RlSTBXTjdYeDdZaWxBQzZaeE9uTFY1RHZnVXRjWGNySGIyb3lTNDNOc1JY?=
 =?utf-8?B?T3BBcGdVSFRWSTNBZGd0bEd4L2JXbWN4MjJvUkhqSjZBaDFlU1RtTkZEejJo?=
 =?utf-8?B?N0NzSkF5SmhOeEN1ZHBlZ0xtcktoeU1HdTFlMU9yWGpJaXIzdlhza3JoN0FK?=
 =?utf-8?B?ajUwdkFtaGZmTkpmNlVuRTF0bW1kRFdUUTRWYWg4eUhGUk5EU0J2Y1pXV2FG?=
 =?utf-8?B?Z3Jac0FYa1p2QlhwSlF2a25haHBVN0xuY1VrU2xja0llaXEySjJQY3QycUts?=
 =?utf-8?B?THl5UXQzR1ZWSDlMOWtyakx4eWVKbk9yQ2grR0kzRGVnQnd3MEc4VWxacHVK?=
 =?utf-8?B?QXZhMHQ5QmFMY2h4U2ptT3BTSU5Yb25NcWIwNzdQb0FLWVNmZXkycUY4Y0xJ?=
 =?utf-8?B?YWh4MXBheWo1Q01FRktnSUQ2NXp3TlR2TEkwck1icTU3dkh5eDhFUXFuejdn?=
 =?utf-8?B?L2p6eTZ1czVrbmd1T3poNXZHK1BPT3hDMFBwV2hFYmx6aXFhckd2WGlWZ25z?=
 =?utf-8?B?VmZDcENxeUx2OWwrdmlYM3pnT2hjTktmaHhxakIwK0QzbmF5bHBsL2ZZUld1?=
 =?utf-8?B?VVNXV0RUNkJjcHd5ZVJhMTVTcWpJaGEzSDBUYVh2OXhSb1dLa0pyY003NnQy?=
 =?utf-8?B?OUN5UERrejlQT0YxRTFqSFFJODNLQU9pcHZjUTVMb2VxL09CR0ptSVQwNjVS?=
 =?utf-8?B?U0NtRFR4RnEvTThjeVBYdWNzd093RERHOC9kT1hHZ3dWSHZqUDFKZWpuMk54?=
 =?utf-8?B?R2pRWWVHWTg0Y2gxQ0xXZFh0UjV1dEE5YnFuK2IwS2M5eHhBNWNIZi96U3Nr?=
 =?utf-8?B?OTg0SDNMMHBaa1dXTmh0V0VkSVdIdTRraUhRVmpQMUw0cERsMTV1U0hVNGZ2?=
 =?utf-8?B?R3YzaElpVjNZTGpRSm82ejMzL2sxZzdzUlJzZEU2ajhzRVhkS0ExKy9MSzZm?=
 =?utf-8?B?R2lNWDdhVEVwMFM0ZjlzUjdyOHdLM3F2Z21rTERPSGdibWh2V1c4SFJyK3dT?=
 =?utf-8?B?bEVBb0NpLzU4cjVGWWF6M09pWXgyVkRiQ1RGaGw5L3lNN1puM1k5aU5EcUZI?=
 =?utf-8?Q?a6mnkAeg5Vc5PTpiXkxwyuI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABE626F18180DC45B24C888BA82F897F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51a3c02-ac0b-4c6d-0e33-08dae232fd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 02:36:25.1871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6TLS85ntxGVzg6hPoMZ5rqrV5716DePxgmJadVTlrkvZ+N3/fIjQRBKsjxic2mWPpxTuoVzBzNlTw5vGmXi22cN8tp3/I+wMmuweI6N4G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLiBJIHdpbGwgY2hlY2sgdGhp
cyBhbmQgcmVzZW5kIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzLA0KQWxsZW4NCg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhp
YXMuYmdnQGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXksIERlY2VtYmVyIDE2LCAyMDIyIDc6MTYg
UE0NClRvOiBBbGxlbi1LSCBDaGVuZyAo56iL5Yag5YuzKSA8QWxsZW4tS0guQ2hlbmdAbWVkaWF0
ZWsuY29tPjsgUm9iIEhlcnJpbmcgPA0Kcm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtv
emxvd3NraSA8DQprcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDaHVuLUppZSBD
aGVuICjpmbPmtZrmoYApIDwNCkNodW4tSmllLkNoZW5AbWVkaWF0ZWsuY29tPjsgU3RlcGhlbiBC
b3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgSWtqb29uDQpKYW5nIDxpa2puQGNocm9taXVtLm9yZz4N
CkNjOiBQcm9qZWN0X0dsb2JhbF9DaHJvbWVfVXBzdHJlYW1fR3JvdXAgPA0KUHJvamVjdF9HbG9i
YWxfQ2hyb21lX1Vwc3RyZWFtX0dyb3VwQG1lZGlhdGVrLmNvbT47IA0KYW5nZWxvZ2lvYWNjaGlu
by5kZWxyZWdub0Bjb2xsYWJvcmEuY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgDQps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IA0KbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQ2hlbi1ZdSBU
c2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gc29jOiBt
ZWRpYXRlazogcG0tZG9tYWluczogQWRkIEFEU1AgcG93ZXINCmRvbWFpbiBkYXRhIGZvciBNVDgx
OTINCg0KDQoNCk9uIDE1LzEyLzIwMjIgMTM6MDAsIEFsbGVuLUtIIENoZW5nIHdyb3RlOg0KPiBB
ZGQgQURTUCBwbS1kb21haW5zIChtdGNtb3MpIGRhdGEgZm9yIE1UODE5MiBTb0MuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxOTItcG0tZG9tYWlucy5oIHwg
MTYgKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTkyLXBtLWRvbWFp
bnMuaA0KPiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE5Mi1wbS1kb21haW5zLmgNCj4gaW5k
ZXggYjk3YjIwNTE5MjBmLi4xOWU1OGYwY2ExZGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ODE5Mi1wbS1kb21haW5zLmgNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXQ4MTkyLXBtLWRvbWFpbnMuaA0KPiBAQCAtMjg3LDYgKzI4NywyMiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNjcHN5c19kb21haW5fZGF0YQ0KPiBzY3BzeXNfZG9tYWluX2RhdGFfbXQ4MTky
W10gPSB7DQo+ICAgCQkuc3JhbV9wZG5fYml0cyA9IEdFTk1BU0soOCwgOCksDQo+ICAgCQkuc3Jh
bV9wZG5fYWNrX2JpdHMgPSBHRU5NQVNLKDEyLCAxMiksDQo+ICAgCX0sDQo+ICsJW01UODE5Ml9Q
T1dFUl9ET01BSU5fQURTUF0gPSB7DQo+ICsJCS5uYW1lID0gImFkc3AiLA0KPiArCQkuc3RhX21h
c2sgPSBCSVQoMjIpLA0KPiArCQkuY3RsX29mZnMgPSAweDAzNTgsDQo+ICsJCS5zcmFtX3Bkbl9i
aXRzID0gR0VOTUFTSyg4LCA4KSwNCj4gKwkJLnNyYW1fcGRuX2Fja19iaXRzID0gR0VOTUFTSygx
MiwgMTIpLA0KPiArCQkuZXh0X2J1Y2tfaXNvX29mZnMgPSAweDAzOUMsDQo+ICsJCS5leHRfYnVj
a19pc29fbWFzayA9IEJJVCgyKSwNCg0KTm90IGRlZmluZWQgaW4gdXBzdHJlYW0uIEl0IHNlZW1z
IHdlIGFyZSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlLg0KDQpSZWdhcmRzLA0KTWF0dGhpYXMNCg0K
PiArCQkuYnBfaW5mcmFjZmcgPSB7DQo+ICsJCQlCVVNfUFJPVF9XUihNVDgxOTJfVE9QX0FYSV9Q
Uk9UX0VOXzJfQURTUCwNCj4gKwkJCQkgICAgTVQ4MTkyX1RPUF9BWElfUFJPVF9FTl8yX1NFVCwN
Cj4gKwkJCQkgICAgTVQ4MTkyX1RPUF9BWElfUFJPVF9FTl8yX0NMUiwNCj4gKwkJCQkgICAgTVQ4
MTkyX1RPUF9BWElfUFJPVF9FTl8yX1NUQTEpLA0KPiArCQl9LA0KPiArCQkuY2FwcyA9IE1US19T
Q1BEX1NSQU1fSVNPIHwgTVRLX1NDUERfRVhUX0JVQ0tfSVNPLA0KPiArCX0sDQo+ICAgCVtNVDgx
OTJfUE9XRVJfRE9NQUlOX0NBTV0gPSB7DQo+ICAgCQkubmFtZSA9ICJjYW0iLA0KPiAgIAkJLnN0
YV9tYXNrID0gQklUKDIzKSwNCg==
