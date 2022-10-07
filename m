Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517AF5F7556
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJGIcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:32:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1A1B97A3;
        Fri,  7 Oct 2022 01:32:01 -0700 (PDT)
X-UUID: 6bcb8ed71e454958810a24336c8da0ce-20221007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=M6J//J6Fq13iMDaOT5b/GjHw3WgHNuCr8mtww6fN078=;
        b=JVTC4qoaXoiEBsN/cxjvrs79hhB9n9i4B1YjmIVxMuBklVn2zUjlSJ1qBOPLUkIAnMDWvYy4gx/IgzsEAW7ug7o89uUg5bSUCvE0tZATT/nRMr4806W9N+brC2vc8ujt/77kAI11qp2nZj0S59PsIpFsV2Bku3S1X63Q3Dp30Hk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8bc65ec7-a808-4e04-82b9-20d500d11ad9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:c2b8d4b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6bcb8ed71e454958810a24336c8da0ce-20221007
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1779876219; Fri, 07 Oct 2022 16:31:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 7 Oct 2022 16:31:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 7 Oct 2022 16:31:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnynBerzF+RF3E7L3r4B0iWFMDpK84tiPgpJb94i9357gL2t05ACSjHYhsxSFnaGVS8Pb/Ukd+glPCwQFiW/Zec3AMrGpSQhKOrRhUtqoJLn2YobNMAxjgALe2ZOLnaExpnPvugCxZLt6SpGjFhVwx2SAFspvEzNtLi5qq6pO4OHTX6UU0hGolfW9XBcJxTP5IHUl/ZpdAJr8XTDsImNsFlS0jT3JqImIvtWGkSh/dOwd/R04jqND1zbFd+Lp7FEuqMTAgE5cMEDvgC1OFcL3hW5tOvNKIS3anoeOIWY/ph3mmxCsQrNiTlstVNvKHif/Qn0AtxEClTVgaG3XKk9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6J//J6Fq13iMDaOT5b/GjHw3WgHNuCr8mtww6fN078=;
 b=Fisj8sQfjem3cGiWQVDBi3W/shRWqlVyErD65QX6cclOEi8SLnq4dEtBz74s4zccgXnq6XtrIdWJxdB7yEsBMIZwU6vZit4ddhZVXFZiOZKG0i2XKIdp0dnMH9byzR+5tzdjhpnPupAZa9uey/EXIIU8sXZ+whX457/QCPkXHx8a+2jAjsviJiI9Rep37AHXh5NNSH4Q9pd9mbDguAPERSuOOD8CmEHSTM3sS22I47/WNoZHV0JZ327zCBFalVG7kFQpNtq0Ruue92D0nrovFxzGWbSpTBYpsGgrLpsQd/gMKAYq7RfRPnNa6qUTM65qE/TE1nR1tKwMaFwy3m7s+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6J//J6Fq13iMDaOT5b/GjHw3WgHNuCr8mtww6fN078=;
 b=eaPBuGaXZQlJyUs1AjnXU6AdxRcR0xXuw1hQ2pab2/GO3ZWyRlVDrVxFFnrih6BrtgOV5MoItbm/9rAMIYXp+hULokD/5mmOxtnIBFB5tss9iHJyDr0I3LDGXV99WszrSaHMfKX+Go1JkkzAue4PsDenKteH8nEeABAVByS0nmU=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by KL1PR03MB6197.apcprd03.prod.outlook.com (2603:1096:820:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.9; Fri, 7 Oct
 2022 08:31:49 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5709.009; Fri, 7 Oct 2022
 08:31:49 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 5/8] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Thread-Topic: [PATCH 5/8] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Thread-Index: AQHY2Xxgj/Y4i7hVY0qggcHf6HNYqq4CiN6AgAASpAA=
Date:   Fri, 7 Oct 2022 08:31:48 +0000
Message-ID: <054b23d46c3ef7960859444d51ce13f760ad7791.camel@mediatek.com>
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
         <20221006120715.24815-6-allen-kh.cheng@mediatek.com>
         <e9fe9674-8b33-dd6f-2db4-1ea4ed8d17af@linaro.org>
In-Reply-To: <e9fe9674-8b33-dd6f-2db4-1ea4ed8d17af@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|KL1PR03MB6197:EE_
x-ms-office365-filtering-correlation-id: e2027f30-731b-4812-3010-08daa83e60aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HOArdHhxddg58QtLJGJk/Toa7LqEwr2R5JFvE842BNUCpzasq74dHBO5Zhb/+DdLuWusUEvidmun1EUsxs/yptOwQiNHku08tOuRACBOnmUQFp5lirN3dE6s6APf2ldzU0p5DZNNiXi1b1xWtyD84GE1iSojZzRr4v22/p99CkZAccm6uskxMAwcHJHD2NOh95Bvqs2DIk+FY30cICUJXDQ7gQjVl8os1tQm4doTLnRjI88Qp5Z0FDO6ezRyie1uTa1G7D9Aw8GENw90WWodkxh93OqZmg7pdVgZ652JZq3fjjdrnFJ8ygYRsLup7kCyYbuqIEy9URe5vTtfr6rHEdPa2Qnr8+b9d2Q9rw9y/xeU/iQnRFXn5YsYbx1LiBmFg6iTWbaFjaMHS/N9mUghiGAQnbeGmf4+LdkhiPbTnmVqncXjTja0SEwuX+9P9TmkeYNGF6rNH4RpUY7FMvVRz3tZw6VXB10zd6Pe9f+BzKv10lzfoKES6Fa883pP5GW21ddSgf8h8RVGN4Q2pJ/zH8Aw6AOF66L+gNQkmUmM0kfFRcuDIryf50wiAcx5gKRM7tEbKXdcxrHb+oz1v1xLILHs1xWQlJf1FsMkU3xCjAK7kOvOYl4wbXV+WB1m00MsfVd6Aor0ktaQwFo5CsGJrz/5kCIJ+cbVDROKor7VtAr+h9z6l7XsuydQcMg8efp3MGS4B69B19ZbSWz9n7aCuRVvh82XLps/tfGdd1HQr+kjkBQPD3e/n/OI7qkLd0iyC+cibezRitQHCbCSR4Zmrcslzvvg2fPPeRdkVI74/FdLBFQYtsdjF2kFZfzkj3D4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(122000001)(53546011)(2616005)(26005)(186003)(6512007)(6506007)(4744005)(76116006)(478600001)(6486002)(8936002)(86362001)(7416002)(5660300002)(71200400001)(38070700005)(64756008)(110136005)(66556008)(38100700002)(54906003)(85182001)(316002)(2906002)(8676002)(66446008)(66476007)(4326008)(66946007)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejVhck91SGJWeCtKdXlGTm13cThUMThzdUlUK3FiSzRNRVJESEgwb1J4eFMw?=
 =?utf-8?B?V3pFOFA3TGgyckFoTEp6TzNqc2Q4eGprMXNrQWZLQVBGYzZNOFQ3VHVucVpM?=
 =?utf-8?B?dFdlMnVRV1IxcXRZT3psQkNTMlNVTnJxV0VneGtmZG1ScE1DcEtlbTR1QWtE?=
 =?utf-8?B?OVlWWWs2dE1JRFZKbVNKWVlGcXdsd3JXZWxyNGdCNVIwQi9UaU0zdExiZm5R?=
 =?utf-8?B?Sk1XOCs2RmR2alBXZUlMaXZZeGVBWU5NWHJKOXpOMkR0YmxrTUVCTnEyT0JQ?=
 =?utf-8?B?Q0haVm5XQkVXODcvOHZNNnpuWlNZaStjR2orVDNObHZ4T3R4TElBZWwrQjE1?=
 =?utf-8?B?N1UvT3loaVRSOHFTbXBYYjhxYXVBZktTQUJQNkJmOTlCYWYwbjVsQ0hwc0t5?=
 =?utf-8?B?Z2VFMHIzcjIzRENQb1NQNENDQ3lwdHBtTEEyTjRRZlJ1QkUyUzJSc2t1emJz?=
 =?utf-8?B?VDY4WUVRcG5FWWxVejZaemh4Q2U2SVFOd2luQ2l5dFlyTDlYRXZMMnQwUHFn?=
 =?utf-8?B?dWZXZTlORmY5dldueWtva1JENTUwSXgrRHRuM3FoVFFJN2NCS3E0SzJ6dHNV?=
 =?utf-8?B?bzZmOEpPN3RIL0pidWlna3QvMHZuRllsSnFnNmJ2QXhjc2lTeUUvMU90TEJw?=
 =?utf-8?B?V3BOVVR5alRqTFdRaWFtdm1OSFVrNE0rOThjbmpIYm9KS251ZUNxVFlqaWY4?=
 =?utf-8?B?dDR4SXpGQVZXdk5JSVdJNFZRUmE0Y01vSkRvWjUyV1czTnNFWk5hUXJDdjM2?=
 =?utf-8?B?UU9mUGlxcHFyS2p5TmRKSGZTSDRiTlJrV0l6b2dzZ3o2cG5uTXNnNXAwS0oy?=
 =?utf-8?B?N2VXbVMyWXd5QUVxTjZGVHYzWmZsOGZlVStvMElrdi9ZSHNDSDRXaG93US9i?=
 =?utf-8?B?NmNhSFJnL2hDVjZPZ05uaEdvSEp6aThUUVpwbGhiV1RDRG0wSHN2cUNOcGR0?=
 =?utf-8?B?YkZPck1DdkpOZDFBOEcwL3pJSzZKRDdQYjlXQkdra3NTWjRVKzNzODM0Z0Rn?=
 =?utf-8?B?KzFINU9MY3I4VVEyV2UzTWYrcGlrOUNUcCtrM0p1aHBUWnpzRVZ0cWJ6d0ov?=
 =?utf-8?B?ellIc1NFNWV3RDBUcElSa3lIZ3R5T2hoVGRzQ202R283WW5VbnorRUh2R3Qy?=
 =?utf-8?B?ZjhLK09sbDIvc1ZUT2FuNnFlR2djRlhxNGFJb1hmeE8zd2Z4ck1ZWXF6Unl4?=
 =?utf-8?B?RUZsUllDdXdTYTFEeTV5Qjg4K1pXMW90T2VrZ1c0NzI0aThIMFZWajc5ZnIx?=
 =?utf-8?B?Rno1SHA0cStHZHFuSExYbGRPQTQ3Qk5UTHBxang0SWU3T2lKUjhGWS9tVSts?=
 =?utf-8?B?T3dLSUlqT1lHS0NNVlN0Wlk4TjQ2dzdBcnhhSm80MXkybnNHOHlWVURodnBR?=
 =?utf-8?B?TjUzQ0JtRVJUTXE2UFo3QWVYMGVKWHh2bWRReU9CdXZ5eURkRVNxOW5LMzJI?=
 =?utf-8?B?UlY3Q2NRWkQvLzJhQndYTnRkTFBJSDJJaC8vZHZxcGl5clpZeVFiRTFqWi8z?=
 =?utf-8?B?cDRoK092cVVsKzRqcDFXamp2N05RWXN2YmJZNmhldWpKV01BYm5ZUE5pTnh5?=
 =?utf-8?B?dXBQREJUQ3dDbVd0TjVxcTlVUldyMzdmRlNJQnN6WXZLU3JBU0Q4ZXg3cHBE?=
 =?utf-8?B?SXBqdFBYSXFZWTBEQVhaRE5oQWdRUHcrZEcyNHlaTkZMOXQzUzQyU3VKTEhF?=
 =?utf-8?B?VnNzR0tHM051L0RLSStqSWJQZ0pNYVQ4N3puL1Vqc3oxRG5tL2prdXRtakdz?=
 =?utf-8?B?ZkZVbWVMYU8xUlhYOTNYWGlaaTVZYlZQd1ZjeWRTTXZyTW1QODBtcituQnlD?=
 =?utf-8?B?eG1ma0VVaXQxZmVJOTQwMDZBWkFUVDRCN2IvK3RBTm5qWVc1NzdmUkJMcTJ5?=
 =?utf-8?B?Ylp6c3RMVCtaNjdBVi8wUTRZNHorQngrd0ovRmtGVHQ3My9nc1EvYTYzQVdl?=
 =?utf-8?B?UExCY2JvblZoTTUvenE1R2F0N0tPRVBMak9KNGgvR1FRMTJmMENaWEhJL012?=
 =?utf-8?B?Vk9PUmNtRU9rU2VibkxodC9iZkNicDlSVldoQkNta2hLZW5DdWtMbGlWbWlw?=
 =?utf-8?B?bkZCTFhhcHZlUng1RXhQd1FSN3VZRDNlWGxsYTZqVVpXMC9HVG1UUjdNK0RQ?=
 =?utf-8?B?Q2RYdDJ4dzhKdy94WHFrSkg2Zzh1eFhrQ0hGNW4yWSt6S29UcDFtWEw5NzYw?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC80C78F009E734EA0C399DC1F6869EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2027f30-731b-4812-3010-08daa83e60aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 08:31:48.9238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GliYruxNpUEfga+2sh6I/RqrKk0XC8Xk49M2R6sO//XEIN7DZXM+95CSAilgAp/tvrUDJEkt/fXfyLh8PsCOyvJRhiI20aAhGge3JnbiK2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6197
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBGcmksIDIwMjItMTAtMDcgYXQgMDk6MjUgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDA2LzEwLzIwMjIgMTQ6MDcsIEFsbGVuLUtIIENo
ZW5nIHdyb3RlOg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBUaGVyZSBpcyBzb21l
dGhpbmcgdG8gZGlzY3Vzcy9pbXByb3ZlLg0KPiANCj4gDQo+ID4gKyAgLSBNYXR0aGlhcyBCcnVn
Z2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+
ID4gKyAgVGhlIHdhdGNoZG9nIHN1cHBvcnRzIGEgcHJlLXRpbWVvdXQgaW50ZXJydXB0IHRoYXQg
ZmlyZXMNCj4gPiArICB0aW1lb3V0LXNlYy8yIGJlZm9yZSB0aGUgZXhwaXJ5Lg0KPiA+ICsNCj4g
PiArYWxsT2Y6DQo+ID4gKyAgLSAkcmVmOiB3YXRjaGRvZy55YW1sIw0KPiA+ICsNCj4gPiArcHJv
cGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAg
IC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGVudW06DQo+IA0KPiBUaGlzIGlzIGp1c3Qgb25l
IGVudW0gaW4gIml0ZW1zIiwgc28gbm8gbmVlZCBmb3IgdGhlICJpdGVtcyIuDQo+IA0KDQpHb3Qg
aXQsIEkgd2lsbCBkcm9wIHRoaXMgZm9yIHYyLg0KDQpUaGFua3MsDQpBbGxlbg0KDQoNCj4gPiAr
ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10MjcxMi13ZHQNCj4gPiArICAgICAgICAgICAgICAt
IG1lZGlhdGVrLG10NjU4OS13ZHQNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Nzk4
Ni13ZHQNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My13ZHQNCj4gPiArICAg
ICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni13ZHQNCj4gPiArICAgICAgICAgICAgICAtIG1l
ZGlhdGVrLG10ODE5Mi13ZHQNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS13
ZHQNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K
