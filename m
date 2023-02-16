Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F312B699405
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBPMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjBPMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:13:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA891A4A7;
        Thu, 16 Feb 2023 04:12:51 -0800 (PST)
X-UUID: 358f3ca0adf311ed945fc101203acc17-20230216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fUcyEHDfUFtSjbLAyIIqav9huLo8TunLdC5DAPV98W4=;
        b=Qitqf+/qlt05ou5AFeZ8WfIt58UKKLkxW2pNIU/Eq8625aSFH6T6oXeN15khQ0iAb11AqAsiAYndOG+zWJOB0ycjGCM04ocAffM0FKkWyInUgZoSONK09fEIHnMcE2hH8nomFB/jAplYWi7YEkkxEgG1HR8CJH1vNiYjhIjoBVM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:d281f414-6cc4-4eea-bdcf-f05395961fc7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:d281f414-6cc4-4eea-bdcf-f05395961fc7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:e80ea8b0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:2302162012415MJ5Z8O2,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 358f3ca0adf311ed945fc101203acc17-20230216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1338915580; Thu, 16 Feb 2023 20:12:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 16 Feb 2023 20:12:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 16 Feb 2023 20:12:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBgh6kjwFSefrHIIpFmbvH+1oP4GDcf0iyheWulkALzfEmOdqGzdvRS1vz31lv9ln4HCGg0Hj9xpyi/SZdLT1VJMcXxpGK9VvA88VIN+ZEPtP5hs2dCCKmZ/MfXbiNQaUhzLIq2DxhmIATB6Ah+0xKeMtCoVRrvPQ2xPSFjfejSCjxHdr4UxPRu5WMWw9+74e11lAxOQZiTsUqZqWMZfNwyao2aJoLBxNrOGL4HB4wb5NfgOULdZ2WiKe06LPksrekc72sXkl/kgAoGq6A6+aClhRhLCRqGpl16wlGTbR580f20tsndOaf449uGwrXXEua2LKewFEtLRTNZ8jiq96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUcyEHDfUFtSjbLAyIIqav9huLo8TunLdC5DAPV98W4=;
 b=HG/F3QkRT1QKg69bDPQPMYOdl0uz2UoYYqyGW74QlNOxt0pOlYdqDutavqOl2BZw+mjFa65F0ntBCgV4Oej8WHQBlHg80UaPPlbmxQs1OxkPYR4HFcPtjhZvOyc1o112oUiuunVcID3VAg0nLTnOSlYzVUwsB7om+7lUx7LPGG6A7sm5Al+z4PVvn3qtWIGjbWnjRspXvjsKoe3qLtx02TeJ7gMPtSRssdNebj5TiUHPwunG2JLx9gmFlNwatQ971cvTcXZ6dgMh4Qte38OsZK/21BJeBu9xLwm5r1j6jLmoOFOxKELEL/HpeF6DnIs8R5sDSxV3nczR6eX/4Gx3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUcyEHDfUFtSjbLAyIIqav9huLo8TunLdC5DAPV98W4=;
 b=YAywVJCcWMKFLKK8NExPXssAt/neqpDhBGc+Tqa9qqD/oMIgm6fNydQMBsG2gbeFT9yNfYAHXMc9zZnYTonGrl9xgNnkMdknmNuNaqnLr9ah6S58TffkOyE9zRWvhSygWpaRKdR/GQWOgkL6v7PBFTNo+uygeCdXIT8XlWXX1fw=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SEZPR03MB7193.apcprd03.prod.outlook.com (2603:1096:101:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 12:12:36 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8%9]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 12:12:36 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH 0/6] media: mediatek: Update video decoder nodes for
 MT8195 and MT8192
Thread-Topic: [PATCH 0/6] media: mediatek: Update video decoder nodes for
 MT8195 and MT8192
Thread-Index: AQHZNFukUPlx7xZ8+kmAN0xsyyLLEq65xEuAgBfS5YA=
Date:   Thu, 16 Feb 2023 12:12:36 +0000
Message-ID: <25759aec94edaf7108477e5a096eab8377f82231.camel@mediatek.com>
References: <20230130033305.31830-1-allen-kh.cheng@mediatek.com>
         <CAGXv+5E2r5T+Okrsz4biksCRF7DfPkBSbbgeKCsidg1MgOL3FA@mail.gmail.com>
In-Reply-To: <CAGXv+5E2r5T+Okrsz4biksCRF7DfPkBSbbgeKCsidg1MgOL3FA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SEZPR03MB7193:EE_
x-ms-office365-filtering-correlation-id: 930c6ea3-7636-4f13-48fe-08db10171787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23qBzH8znzRBKwXbYFsRy738wc9r+XRyrtgoro9TBV3arc7lOTE+jfKAWQpRRoRwDp0731nvEDxUiosWUrReWYaJFIHBdMdsDY+LWqLrdTXrhmoYpno801SDnFseCC8uqMed/HqFhdNFOGW3lHQBcZRpIwP6GAyMgIzi7dXjga9aV61yyRP79tE3UkcqK+wbxiaTuLshwq0RBUtaFQJcYkCSzjUqwWuXd+GcqlRwxoY1it5A4IG41DPshvuvkuExbqIaH5POvY6dGvD/nI+GTSUH9cXiIooU4TxkBfLZNXio2TcxhlD/FpnPiT6lHgwzK93VsK/8tov1rrdSt+X8Kx6waNWp9tbZTQ7YSYBGQGCHX6EDxIOI/DEZeryW5CaDjDT7u47UwuBuv2Ljm99GgU1S8+Sg1J5H3VJzjZP9kjWYmORZoCuOPUMIxXKszslPBkoqy9NMlzDGtHua+KMsCxmrbUJI58nftqm1qpYsGwQVUkAeJ8me/wV9I1MRYxY2gV7dfpKxOUijZazhx72orc+9eEOWUE+vwY0pNrHUg3KI0qPSfLyYeAS3XFzIwJ+p4bMk9PqAm5U/PXuXABhxMJhl7dXBEIeohtAK+kK03W7U/e6WD73gdv6YmEsxKWZQ6x8u9uQLa8l9v2hYqsuuKCWZECxafm4hAPAe8ot4kY9Itf5ICyox0z4kD47k0+PZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(76116006)(36756003)(85182001)(110136005)(2906002)(15650500001)(54906003)(7416002)(5660300002)(8936002)(66556008)(66946007)(66476007)(316002)(71200400001)(4326008)(41300700001)(8676002)(66446008)(478600001)(64756008)(6486002)(86362001)(966005)(6512007)(38070700005)(186003)(26005)(6506007)(53546011)(2616005)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFlzQmRsNFdzSUVWdStCRVVzN3FJOHFzZ0NYdm40eThySDVYWEo1NDN1Wm5G?=
 =?utf-8?B?Ylg5WlRMVkxhTjdwZGdrTzJZSjhVWXdrUlQ0RWNWTTduVmRsUkx5SGsxNTZi?=
 =?utf-8?B?cFhWU3gySms3blVVM295akJxMThvTXAreCtvZ3BEdmhNUVdpTVpPSGFMQ0pO?=
 =?utf-8?B?V0JQd04ybG1mY29SVlBIWFoxelJuNWZjVE5oZzF5VnhzVmdSUy9OUVh4Y3pC?=
 =?utf-8?B?c3ZzMmhrZjVPNXZQVUpla3dnYi9ZK09CenVWVWdDbXp5b1gyK1MwRnpJOU5z?=
 =?utf-8?B?MHhPcHdSS3NOdzd0dnVKNUhnSTkyT2NSNUlKMVh4a1dpcnlaalBEVFBZekM1?=
 =?utf-8?B?MDlBTFRlU1RQWXVDWmtQSUlJZVMzZlpheTllMXFBQTg4cjFFS0M5VVU5UXhz?=
 =?utf-8?B?ZC9VSldsdHllaUNNVU1TazFQSHkzNlpXS3p2NGZ5QTZaNk02ZXFqL3hQeUxn?=
 =?utf-8?B?WkxucExHVkhudWErdmUwOXN3aGtqdzBMT1licnhmTEtTS1VCYjRLakxlUWty?=
 =?utf-8?B?Y2lxQk0rRDU5THQrNEl0VDJWdkpHYVB0MnZNR2FIQng5ZXNTdjNpcjMwZy81?=
 =?utf-8?B?MjhOdGdHS25PYlNhZnVGazNOL204K05hWWJxejFiWHFlNVl5N2phU2k3emhE?=
 =?utf-8?B?RkEranNTMVAvdUU1cFZCUVloRTlxTFNVelFOenFKZUtaWVBpREQ1eTloTHpR?=
 =?utf-8?B?aWRSYlBLY1BmNlN1aDhsNEpOclE4OTVrcElWTXd1V2wycE9vUGN4WXVVK2ti?=
 =?utf-8?B?a1NuQndFbFN2NHdpbVg0YlkzZkhRSUJyT0VVTkxDTkR3NndnT1dGY1dGSVoz?=
 =?utf-8?B?S2pSSE5LN2FGYUpwajB4ZWM1QmZhS0w5UlpycUJkWndEd3V1bUNrbHR4cnhM?=
 =?utf-8?B?dmdIaG1PWnBPUlZPN2pPMEZ6K0xMWndUL2pBV1pNMWtNYVNZSE1MdHRjTDc2?=
 =?utf-8?B?SElCbTluQ3JxWFRjUE1lS0tBcWRMSERscWlDbkI3VWFsanl4b1dPejdUUmg3?=
 =?utf-8?B?MGN0cWh1cXFHQ3c3VHNSalNCM21hbzVoY1BobjJXRkFNcVBMMmsxdWpRbDFY?=
 =?utf-8?B?QmJraHYvbjVwNDAxQzZUb0dCNkE5Y1BGcnBlTW9BK3hkNFJqcWUwMG9ZMnNV?=
 =?utf-8?B?V2RxbXoyMExBaGRPdjdCUGlybEcyZWpSRlliNnNsUHVSNFpJbStOMW1TbUwy?=
 =?utf-8?B?dUgyb0NLVlNHOU9yL2psOUtWWU5qaHlwRm8zbUxTVERBejN4QWVhcHRyaDdU?=
 =?utf-8?B?OXBpa1pUNHoyWG9CdWRzejZnUERrRzBuVVRBbG9VZFdzSzVkdFk5ZnViMG00?=
 =?utf-8?B?SGtxS1VEWUpzZm1rTU5SSFNqRHdLQk1FRXU3ck56cXZzRGhxYUMzTUJicEda?=
 =?utf-8?B?TFd0dnhxZjI4SE9sY1BycU5EaWYxcHh0dWlBOXRBNHBhOTUxTEw3QXg3RTln?=
 =?utf-8?B?c0ZxSEptSnZlendNT3Yzb0x6ZzlGeFA2NnpYQm14aXRxeDIvRGdKckMxcXRz?=
 =?utf-8?B?KzdBeW5abmNhd09wQnVwODhQUG95aWtYK3FDYUkzZ09CMHRsUE9tSTJNSy9s?=
 =?utf-8?B?S2xTcTcraUVNbEVndGFBNjJ4cUpyeWlhTWlKU0haTWVld3Q5OTRjeDEvd3RQ?=
 =?utf-8?B?di8wUU5mcVZmQnhGZnFicDFpM0JQZXJycm9SY0NVV3VySFExLzBuemE0Qllu?=
 =?utf-8?B?UlUyTENiUVJwckdnS0FaQlFlUjNaR1pyb3pVc0ZkT2t0bXMrelMvUlJud3hV?=
 =?utf-8?B?eUcwb2w0QUlKVzNMd3Ria3pqU05DbVdzdnRIVHpxV3FSbXhkcHo3WHhwMlZh?=
 =?utf-8?B?U0V6cE9kdkVJK3J3YWI5bzdyMjMxOFJhZFFwdlY1Tkp3cUhsaHpHa3hiNEZw?=
 =?utf-8?B?SE9KcWg0M2VZTmdSaUxXcFlLZ0NleElnNFNyTWtlMDFNT2NIblFoNlBLRU5U?=
 =?utf-8?B?SVlzbHB2R1pRMlYvMXQ0YWQ4cC9RdnJiMGFEeEpzZ25LQ1EvVG1Dc0hYanZq?=
 =?utf-8?B?Q21xUEpyYkQ2S2FrMTRZSlNkc2ZocUpsR1BSRURWaG1yaklzdEhjVmZpQ0hC?=
 =?utf-8?B?MWZNU2czY3cwSG9zN20yU0ZmMHJxMkZuZEVMUUJiak85TnRYQ0gwNGtvN2xP?=
 =?utf-8?B?RXJuZWlFUUhTUC9zUHJlOGM5RkNLTENoUHRVLzJxRVliTFZnSzk0NGVhbldX?=
 =?utf-8?Q?16bguFQKJUtJEuTfnASg0Ag=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <509DB505B1E63445BFCA6FF7642AD4DC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930c6ea3-7636-4f13-48fe-08db10171787
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 12:12:36.7466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhCLhjatHbXOepd+B0YqAVtp6SblURongRZ2Sj+S+4oMAXaV/0U7qBt3JF5o4yF4JuZaqm2RfJLycJSvsWoAxeJjIITN6ki4auD0L47Cw2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCkdlbnRsZSBwaW5nIGZvciB0aGlzIHNlcmllcy4NCg0KRG9lcyB0aGlz
IHNlcmllcyBsb29rIGdvb2QgdG8geW91Pw0KDQpUaGFua3MsDQpBbGxlbg0KDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaGVuLVl1IFRzYWkgPHdlbnN0QGNocm9taXVtLm9y
Zz4gDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDEsIDIwMjMgNDoyNCBQTQ0KVG86IEFsbGVu
LUtIIENoZW5nICjnqIvlhqDli7MpIDxBbGxlbi1LSC5DaGVuZ0BtZWRpYXRlay5jb20+OyBNYXR0
aGlhcw0KQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCkNjOiBNYXVybyBDYXJ2YWxo
byBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDwNCnJvYmgrZHRAa2Vy
bmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPA0Ka3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnPjsNClByb2plY3RfR2xvYmFsX0Nocm9tZV9VcHN0cmVhbV9Hcm91cCA8DQpQcm9q
ZWN0X0dsb2JhbF9DaHJvbWVfVXBzdHJlYW1fR3JvdXBAbWVkaWF0ZWsuY29tPjsgDQpsaW51eC1t
ZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyANCmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgDQpsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOyBZdW5mZWkgRG9uZyAo
6JGj5LqR6aOeKSA8DQpZdW5mZWkuRG9uZ0BtZWRpYXRlay5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIDAvNl0gbWVkaWE6IG1lZGlhdGVrOiBVcGRhdGUgdmlkZW8gZGVjb2RlciBub2Rlcw0KZm9y
IE1UODE5NSBhbmQgTVQ4MTkyDQoNCkhpLA0KDQpPbiBNb24sIEphbiAzMCwgMjAyMyBhdCAxMToz
MyBBTSBBbGxlbi1LSCBDaGVuZyA8DQphbGxlbi1raC5jaGVuZ0BtZWRpYXRlay5jb20+IHdyb3Rl
Og0KPiANCj4gVGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gbWF0dGhpYXMgZ2l0aHViLCBmb3ItbmV4
dC4gU2luY2UgdGhlcmUgaXMgYSANCj4gZGVwZW5kZW5jZSBpbiB0aGUgZm9sbG93aW5nIHNlcmll
cywgSSBzZW5kIGl0IGZvciB0aGVtLg0KPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgNCj4gLW1lZGlhdGVrL2xp
c3QvP3Nlcmllcz03MDI0MjNfXzshIUNUUk5LQTl3TWcwQVJidyFqN3Z6NngzV25tanQ3d1ZoYzBf
DQo+IEQNCj4gSFN6Qk9SQlFWZ0RJY3hhSWZVd29kYkRXdmpqN2d4Nnd0YVJNQVNsdGI5VlBZRU1U
TTVSVHlBRUFLWDJNVkVsakljc29DDQo+IDMNCj4gX0ZDSXROOXpqeXlCZjNQUSQgDQo+IA0KaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eA0KPiAtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTcwMjA3OF9fOyEhQ1RSTktBOXdN
ZzBBUmJ3IWo3dno2eDNXbm1qdDd3VmhjMF8NCj4gRA0KPiBIU3pCT1JCUVZnREljeGFJZlV3b2Ri
RFd2amo3Z3g2d3RhUk1BU2x0YjlWUFlFTVRNNVJUeUFFQUtYMk1WRWxqSWNzb0MNCj4gMw0KPiBf
RkNJdE45emlpcXd3azdRJA0KPiANCj4gQWxsZW4tS0ggQ2hlbmcgKDMpOg0KPiAgIG1lZGlhOiBk
dC1iaW5kaW5nczogbWVkaWE6IG1lZGlhdGVrOiBSZW5hbWUgY2hpbGQgbm9kZSBuYW1lcyBmb3IN
Cj4gICAgIGRlY29kZXINCj4gICBtZWRpYTogZHQtYmluZGluZ3M6IG1lZGlhOiBtZWRpYXRlazog
UmVtb3ZlICJkbWEtcmFuZ2VzIiBwcm9wZXJ0eQ0KPiBmb3INCj4gICAgIGRlY29kZXINCj4gICBh
cm02NDogZHRzOiBtdDgxOTI6IEFkZCB2aWRlby1jb2RlYyBub2Rlcw0KPiANCj4gWXVuZmVpIERv
bmcgKDMpOg0KPiAgIG1lZGlhOiBkdC1iaW5kaW5nczogbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6
IGFkYXB0IHRvIHRoZQ0KPiAgICAgJ2Nsb2NrLW5hbWVzJyBvZiBkaWZmZXJlbnQgcGxhdGZvcm1z
DQo+ICAgbWVkaWE6IGR0LWJpbmRpbmdzOiBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogQ2hhbmdl
IHRoZSBtYXggcmVnDQo+IHZhbHVlDQo+ICAgICB0byAyDQo+ICAgYXJtNjQ6IGR0czogbXQ4MTk1
OiBBZGQgdmlkZW8gZGVjb2RlciBub2RlDQoNCldob2xlIHNlcmllcyBpczoNCg0KUmV2aWV3ZWQt
Ynk6IENoZW4tWXUgVHNhaSA8d2Vuc3RAY2hyb21pdW0ub3JnPg0KVGVzdGVkLWJ5OiBDaGVuLVl1
IFRzYWkgPHdlbnN0QGNocm9taXVtLm9yZz4NCg==
