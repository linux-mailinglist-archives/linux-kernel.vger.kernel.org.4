Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7480B669365
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbjAMJzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjAMJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:54:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5762113D00;
        Fri, 13 Jan 2023 01:51:17 -0800 (PST)
X-UUID: ceed7c90932711ed945fc101203acc17-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lKlVCm5a7+ZRDB1kDr0f0gvys7YWDrPR4fIXcoBeuZA=;
        b=PWJKnkIcn/pkIyRbiYfQeKhycZ05QnBTUYojprUBrEWwYJN941ze6A/64p2R3g+qmlh/a5+i4l5LjCMNKUbr9m5va9oSsCEcruac70qGrbOfVSgsl/NGeWgqNWv2i0meeV7Nt8fKv8r5ObxaoczNhjqWa2NyI+7eHkkn6ozdsuk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:e6c4800a-24c2-4c4e-9760-b3dce5d604d1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:e6c4800a-24c2-4c4e-9760-b3dce5d604d1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:afe6bbf5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230113175113HICS2AWR,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0
X-UUID: ceed7c90932711ed945fc101203acc17-20230113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1389240408; Fri, 13 Jan 2023 17:51:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 13 Jan 2023 17:51:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 13 Jan 2023 17:51:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDpQEm2K3pZuW99jmDhz+SJBu48FdDs8Nz3TP610+wnqVXni7fOsO1o+2T1PvtnV7DWcBHeC3swZG7a9CrwyW0ykr2FcJrqEavBsPAz38ehG3WBuxl73hIiUwaaWE1rZuXe2SST0YX8hsNBXd3Lli4Cd2xnRyAfLBlEtUY3kDEmT8rSI04d8DVYjDS6bLh+8HVb0G5qteks93MFFB3RWXm54HtKt83j5hrIhHNOSvRbE/51kleiM78D8rRZhpxUrsKqoqNaRE6bhi+GtQxGTJCdhkOM2RdE4qof8M/j6yHbKr82FDHMEtSj/mpzc/u2bhzbg8H/iM3YyL6RdIlqMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKlVCm5a7+ZRDB1kDr0f0gvys7YWDrPR4fIXcoBeuZA=;
 b=IkFLbeoQkNNYd2MWrqqgBVh4t0DrC8A3+xLYOqkOe8xTLULKq2ioTKZKr+iNc5Yt6qYq8cUzuFdtolRZThYkk5KOlg4NWOcvI7Zdv2AC93EEqkfUzQuW/HpINdGbGg1ssngLbC8qglkdY289yF8C+FUpd4s6qeRKNuW9QzohOtcrsiM+IhWLRWCx0ZYrlqVrkf9xtQybr/gWobfbnBJcPWqRzT/5JuGMrsG+av6whDJ2R7Nvp3j73yNpxAMZRLr04SgJL1YzWsvc+P7Ufl+cBf7moZxZAp4PoDo24uPrapjOlp+B8UGjp87VRLACd69N/mDEnBHDDCPCGXSMOgbWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKlVCm5a7+ZRDB1kDr0f0gvys7YWDrPR4fIXcoBeuZA=;
 b=FiHJDp/eoJz4uFXa9SXtMI87q7u68gpKKWJhXGsoAaA5jrAcROOElwyFfkoJqRBbiwUx9dNHJ+/nI++RxQE/tgHFeggFtsqGXv3XEDgZACYLsoEMACnaGGzQFGc+9xZHc7JsqlgHfvOQHBeUpmSx8FgqCqVJhiOPTp7LE0NPtdk=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by SEZPR03MB6812.apcprd03.prod.outlook.com (2603:1096:101:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 09:51:07 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b%5]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 09:51:06 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v29 01/11] dt-bindings: arm: mediatek: mmsys: add vdosys1
 compatible for MT8195
Thread-Topic: [PATCH v29 01/11] dt-bindings: arm: mediatek: mmsys: add vdosys1
 compatible for MT8195
Thread-Index: AQHZGcol0i/l8fqSpkSrcJKRGEgYGa6XjyIAgASmZIA=
Date:   Fri, 13 Jan 2023 09:51:06 +0000
Message-ID: <752d6f553af0aeaadaa518c2a6517a93fca4731f.camel@mediatek.com>
References: <20221227080443.6273-1-nancy.lin@mediatek.com>
         <20221227080443.6273-2-nancy.lin@mediatek.com>
         <cbd6ff49-a31b-00ad-c5bb-9a185391132d@linaro.org>
In-Reply-To: <cbd6ff49-a31b-00ad-c5bb-9a185391132d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|SEZPR03MB6812:EE_
x-ms-office365-filtering-correlation-id: 8b7c6309-7dcb-45e8-8297-08daf54bb0e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skKVXYOAMm26fYLk6q2e/d7zTl0ATBRv6W9lxIZ9K4hEwzlcNzJielfAfYDIVYo0AdZMJ6ZF5rAw86x77Qyd/OFu/eE8eYLGXhEJEbKzBA3xAllmWEi3VxrmcEpmxA0XLSbB8Y9DmE/gx35VyaoyktVdEKIROdSLD5+V13YNuEWvMUaLAO5/Lj6dVPQvtJfCfTmU5nmxQOp8ejdMx0RCIKIQOuyq/B8j6HRao9BteTIZRA1/l2K+IsnKAFWMJI1mx97EoqOuQQwaHTQMWubSjd2sv1lQwZjj37KmLqTS2v711bi6NPuu0KqVvHSM1xsLa75jxiDeTR5kz8FmtfhLK8z5fEYOkNOQAdoqILAC0de4XviQV1DyNXj7pu1+QXhXgBHkSarJt08lIn1kd/bLh4AkVChbnU3K37Lt4DPtHBuu7IomN6F8qtN3emMnczFPIDqBElj0xms9f8nHQVHZpSzGP4qfSoMkT5DSRPmGX/Gt34C5vBzZLdS0A8M17nWidN8vCqvXhaO20LY5avkp9NP9VcbD1QyWNO3pb8yBs+NqKlVtdmCgEUPAtlFov2QGieZ6/nrBm9yKerJHej7YQdFJ7Y6sAusRiHvb9qk5s+DvEilNJer+Iio1dJWKvVt4v4n2Z8UgBJXQ3hjPIUdc98yVig0M/h7QtOvrR3IJE63DaS+h1155TwXUWTlbO2OESSNDihkPkMfvZQN8vCnUprW2my60HjxGxpsUDyL4q/odaDgtoOpOj5g6zDAk47Y9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(26005)(2616005)(7416002)(316002)(6512007)(478600001)(71200400001)(186003)(5660300002)(38070700005)(4326008)(41300700001)(76116006)(8676002)(64756008)(66476007)(66556008)(110136005)(66446008)(66946007)(66574015)(54906003)(91956017)(83380400001)(8936002)(86362001)(85182001)(36756003)(6486002)(6506007)(122000001)(38100700002)(53546011)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RldxcDBtbEdtZnZQajJBQ21EdG9uR3FuNy9kMHl1c04wMVppTUJDcEpCM1Rs?=
 =?utf-8?B?V2F1cUozOXBFby94cHBOVFFUNDFaRnFlVlJYZVV4aC9XNkNyUFZWTXBXMFpI?=
 =?utf-8?B?OTNqUWRNNFFWZWc5dG93WTlZZmZ6OFFoQ0RvVnBIWmVra2R3dDhWbTFJU1FC?=
 =?utf-8?B?ajIxaXdKSUtnN2ZoNERSZkF4Yld0NW1JZUtwbUdETEZXelFaWEhJZDIxQVY2?=
 =?utf-8?B?RmFlSFZMZElOZEJRcEtPZi9oRWZTM0kyMmxrWEVtK0ROSG91U0ZWUEJqdnRa?=
 =?utf-8?B?KzZraUp3bHlhUE5ncjI1RUtoZVBMYmR6cGpqZ2VyQXB6T0dkdEJCNjdPTU1s?=
 =?utf-8?B?ZGdXNDVZV1RsUjVoOVQvOGNpbXVBVzY3K1lVaEVQeWhaNVJrWDhaeXc3UXk2?=
 =?utf-8?B?cW5LTGszTjFzYTJxK0E0WmpUZEhzODV6L0FKV1Y5c2VDYTBhSXk1bFNKeFZO?=
 =?utf-8?B?d0JkQ0p3d3ZrQmtTRVZmWkkxNTE1QkVTa0x3TXhKL014RWVvSFRJRHN0Wlhx?=
 =?utf-8?B?NzdkMnNZYlByTXh5dWNDVURmTXRPOWhLRFpzMUFEemRyaDRhaVVPQk9EU3Vu?=
 =?utf-8?B?eDFqdjZnR25IMjd0VWdOWmZBSk95dEt4QXk4UENCZlIydUViTjA0Z1lXMnF5?=
 =?utf-8?B?OUgyUkY4U2dVdkhaMGNXZ1JyYXliTkVIeFRTZ0FRQXhhSHkzdVkzQWpKSm9R?=
 =?utf-8?B?Rm1iQ0J3Y0hsWlptZEowc1FCckptNi80WXBnT1o5ZnBOWVN4VXViZFFaVlY5?=
 =?utf-8?B?aDN3Z2pWU29rRHZWYWo3QWk2cGRDMnBhUmpZUGlLUnNPMW1pUCtxV0FnL1JX?=
 =?utf-8?B?REJQZ0gxRmlsMUE1SlpPMmUydWlHRnJsZ1FleHR1d3VOUUIrQi9hb2VJR2o0?=
 =?utf-8?B?SWJHN2x0S0pGSzhkUzRmd2taRmhTclhQM3V2aVlVUERNVUNJWE9lOGJXVDdD?=
 =?utf-8?B?QjRwNHVTMmUrSWFTSStqSUxpMTI4b3BkdGhIa0pKRWgyb0htOVY2blcrZmFl?=
 =?utf-8?B?b3I5QW1qTEdGOEJ5SC9zdThsQTUwcEtJdmJNRFNQQ3RkZG10L2hwTUdpWWRt?=
 =?utf-8?B?NXJHMmxNUVFCMnkyZlJLY2VZOGhYUEU2N3ViUDVlbWFuTkk0VGo4SWdzUURT?=
 =?utf-8?B?TWhQdlIrbytmZWl6K2Iza2QreVZVcTlvSGI4M3MxNk1pWVBzK2NmQitzMVRt?=
 =?utf-8?B?SUw1T09oNmU3VG1ZZTU1WXkrYTFlYUtCYTRTMjBnZTdlMnVPTTJPa0E5OUhs?=
 =?utf-8?B?SmpZeUdBTzhjOExJdUp4bzViVFhJM1h5SEdVdmN3eVpsRGdnZDYvendpelNz?=
 =?utf-8?B?UGs5Qk9LYjZoS2JIQk9wMlN1bmY1OVprbWNRd0ZTYkd3elBHbTFSYzV5NkV6?=
 =?utf-8?B?QlJ5K2RwNUFMWnFKRE1scnBrSE1DZURSSlh2UDF4YklWNk5ONHBFYklVWlRm?=
 =?utf-8?B?VXFlaE5BT2R3RC9ab25pOGh6dXpHKy9pekpiTGpValQxM3lqM0grKzVCcjFU?=
 =?utf-8?B?STROV2VzTDNFQ3VNVk5TcHJMOEtLamQ4MlY0L21DcXQwZ2tGM0tkM3plZzJR?=
 =?utf-8?B?Z2JQUDNxaThaNEpvWDFsYmovWEJ0dWw0RzJXWG9oeWY3UXV2Ykx3a2pUTUVY?=
 =?utf-8?B?QUNvM28vTVcwNmNZY0tVWTdwQ29kQ2NjUnJjekVVMDhScUpkbzVlTTA0NEZk?=
 =?utf-8?B?QnNpbDBnQ25aeldUNUVyVHVWdmtHR2swbGY1Zy9OYnhEQVBTMlJWTTB0RUpn?=
 =?utf-8?B?b0szM1ZNN1laMmtqU3hmUTFBRWxLUUVveDgxZFZPbFhVSkxpR3dUSzNucWNE?=
 =?utf-8?B?TUZnUmxmV3JhZDJseG1OSXZVbEFDMXJkS3pKY3F6blBsWUgyL1JkYzM2RUhT?=
 =?utf-8?B?YVlEWHF2TVhOcUU3WW4yTHdielRwalZheWJ3Q2VPQmlSY0R1blpnS0FSd3cy?=
 =?utf-8?B?ekhJMUI3VjY4SzFyZFF5QVF5S0ZRKytjNytrYUVrT2N6ejM5b1NZRWtsUVJl?=
 =?utf-8?B?NHVxeDl4ZU0rVlVzM3ZiK3AzMXM4QTkyRkVUZHJDMmJvS00wMGFrM0gya1BX?=
 =?utf-8?B?U1o3dnVSTUtXcFI4cHh0bmdVb0pzZE50alFpYkFpSTlWa2pEbENYTWVEQ1g2?=
 =?utf-8?B?YXpmcUhvOVQ5T1NpOUNsOXFJeVZ2ZTZmZjdNTHJuSmswMXJzNHhhU0t5Mjlj?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E338D85A6DD41045B82DF21AD8674A0F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7c6309-7dcb-45e8-8297-08daf54bb0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 09:51:06.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzG7lx8XKY4TvNtmGWI8zTFg4uB5LHQdbubDBfaNKhdRgUzlvnsDUQTrNxicjvtiUr9AHdqS8lkOL/Vncxw6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBLcnp5c3p0b2YsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KT24gVHVlLCAyMDIz
LTAxLTEwIGF0IDExOjUwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAy
Ny8xMi8yMDIyIDA5OjA0LCBOYW5jeS5MaW4gd3JvdGU6DQo+ID4gQWRkIHZkb3N5czEgbW1zeXMg
Y29tcGF0aWJsZSBmb3IgTVQ4MTk1IHBsYXRmb3JtLg0KPiA+IA0KPiA+IEZvciBNVDgxOTUsIFZE
T1NZUzAgYW5kIFZET1NZUzEgYXJlIDIgZGlzcGxheSBIVyBwaXBlbGluZXMgYmluZGluZw0KPiA+
IHRvDQo+ID4gMiBkaWZmZXJlbnQgcG93ZXIgZG9tYWlucywgZGlmZmVyZW50IGNsb2NrIGRyaXZl
cnMgYW5kIGRpZmZlcmVudA0KPiA+IG1lZGlhdGVrLWRybSBkcml2ZXJzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IE5hbmN5LkxpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gPG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVk
aWF0ZWssbW1zeXMueWFtbCAgICAgIHwgNA0KPiA+ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtDQo+
ID4gbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtbXN5cy55YW0NCj4gPiBsDQo+ID4gaW5kZXggMDcxMWYxODM0ZmJkLi4yNDJj
ZTVhNjk0MzIgMTAwNjQ0DQo+ID4gLS0tDQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlhbQ0KPiA+IGwNCj4gPiArKysN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVk
aWF0ZWssbW1zeXMueWFtDQo+ID4gbA0KPiA+IEBAIC01Miw2ICs1MiwxMCBAQCBwcm9wZXJ0aWVz
Og0KPiA+ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQo+ID4gICAg
ICAgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gPiAgDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4g
KyAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxOTUtdmRvc3lzMQ0KPiANCj4gVGhpcyBz
aG91bGQgYmUgcGFydCBvZiBmaXJzdCBlbnVtLiBEb24ndCBjcmVhdGUgcmVkdW5kYW50IGVudHJp
ZXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpPSywgSSB3aWxsIG1vZGlm
eSBhcyBmb2xsb3dpbmc6DQoNCkBAIC0zMyw2ICszMyw3IEBAIHByb3BlcnRpZXM6DQogICAgICAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1tbXN5cw0KICAgICAgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxODgtdmRvc3lzMA0KICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItbW1zeXMN
CisgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXZkb3N5czENCiAgICAgICAgICAgICAg
IC0gbWVkaWF0ZWssbXQ4MzY1LW1tc3lzDQogICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KDQpC
ZXN0LA0KTmFuY3kNCj4gDQo=
