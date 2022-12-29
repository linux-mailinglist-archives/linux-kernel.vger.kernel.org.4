Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE1658821
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiL2Aha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL2Ah1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:37:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726612AA1;
        Wed, 28 Dec 2022 16:37:22 -0800 (PST)
X-UUID: b8c1691454e443c6b50faed95b5c7f05-20221229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2G0VKpdTJfw8H1OpNrrwQxLn4EXHIFAeUXpSKr/nUsw=;
        b=E32+hKB5VWA0KpSa+UOk9Etz4jLQaQQ6pRO6N8rwIUO67nWsXG5vJ6/4COHC5eqGBsnIpMT00h9lNxJTfA+4oo6GIHF8E/gwRpDYyBMEHDTJVopeq0kngu8I6R1wlOiW/JcLwKuaoN04D4Vb5993XZBeq42tFmJRjvu3y77DWco=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:eff1b791-2ffe-4ebe-bb59-407b7359a995,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:3e5d1153-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b8c1691454e443c6b50faed95b5c7f05-20221229
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 430600420; Thu, 29 Dec 2022 08:37:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Dec 2022 08:37:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 29 Dec 2022 08:37:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZiZj6o3dSGhp2cSlEVtSDRfQgJcjxt+0KkasmkJQsmp8w40lZbypTWaC07KuOtppel87He7GDuX7doG7LreH6hJXaNyO+w1Nq6YDpgoGs4DXXTvoJKGfDcukx9OCEP5JXULiWexyDPG7HbuoWlV/+QVE/zypFbMO5P6H1AFzEMsdN+W7eIWPtn/PZaHE/CLU45B265IZCuGA+xzqOXz2YfSyXzBylObKZwOAEBi4FXlmCJzVP5G+fURRc93NIrf9twhsN8crtXm/VAA9pXfzEo/s1Sk/5slkuqarUcRGfcNi9gYq3S5M6vRGSKyqXqYjK/rDHrEhaAF3SafizC+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G0VKpdTJfw8H1OpNrrwQxLn4EXHIFAeUXpSKr/nUsw=;
 b=IAMl4DqHT2pQK2a9uoq2pT35UwBNl/mFJtrIJiVU7hD4MZlOl3xiMWuxY+3st7vZ3ySxzZq/D+PY9mn7J+o73r7phfgBGa2crFmp2N94ExiDLndSrx6NvVNiqDHRdTK1BvunLiGZMY4+76V1lbCRw9pyX8tbHA3WQioUMHRSksSNuRbyZ+wjHsNn3+q1cg8zOv+PPmomOKEvxluUPDyPK9iJcg+9Jn7vNdgOqQA1Jr3Gl+Td7m2lMQf5FYedTiIK8/M3vluOQj00pNcW2B2nVCSaGXkolOI7srCjGWWQyWOUZcDLyziXJkdS059NRJUv2l2wZLLVuS0TaM78kHu8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G0VKpdTJfw8H1OpNrrwQxLn4EXHIFAeUXpSKr/nUsw=;
 b=X+AokzsCPHIETzbgeWwgD3fp8dUw8DbQ9HpQvD10sJ22HTc1DaSqY8JssNdMP3gYRKzz9UcwtbsC0LI1rd58csz4kxKgJusM0bbS7YyYvxRKfmG3pB6K27ZSHUAyzgfcZgOov+GQwMkpfMC5M3Q6jz5J7In0YfTxGQ5rWiyS+ws=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by TYZPR03MB5798.apcprd03.prod.outlook.com (2603:1096:400:121::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 00:37:10 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5944.018; Thu, 29 Dec 2022
 00:37:10 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Topic: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Index: AQHZFnD46s2/SRWVcEOB7S9zlZaYAa57hgWAgAQHhwCAAMBsAIABCWEAgAImxwCAAJBbAA==
Date:   Thu, 29 Dec 2022 00:37:10 +0000
Message-ID: <fc4926e561cb09e68626464e370d19b92f67aa28.camel@mediatek.com>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
         <20221223015029.24978-2-biao.huang@mediatek.com> <Y6W4vwJHG+6PI8fd@lunn.ch>
         <4a82aa5437e496e2b65b77ef08d7897a4b23f7e5.camel@mediatek.com>
         <Y6m7eNdWVL3IKFj2@lunn.ch>
         <5baa7c88716042421b0dd1d579c6aa70d253a546.camel@mediatek.com>
         <Y6xoHH6ETfbufX/a@lunn.ch>
In-Reply-To: <Y6xoHH6ETfbufX/a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|TYZPR03MB5798:EE_
x-ms-office365-filtering-correlation-id: b8848234-a20b-445f-746f-08dae934d260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nzhB/M6cGbrzpkXR3x08pcWiAj+ImDtWaqoQnMXP7QdcFSkokh6lBuJ+776QcJ1VwdUn/kguLmmzY2G/kjA7CDfKuKHn45r4Uyxoa5MtkJQc/XcH9WVnEblulWSR0k1QJ9xvnRiW6A5fluD0fmVMshFlyyketNvNS14ybMu80avYCxNQMLyaOnExCKRxqqT5brs9mbEdW+w+SrbvrBsI3lZzE2uqGdcIcqaOYmQyUsVKFHX2poKPnFE0G/00TGY4ZJJOrpV6LfnoNTupyRoIkPt868uX32ynL8TKPqsh8JKtNbA7L/BQEVIVXSnB5hg4UVH8AdKh9B+EZsJ6xTBFqZKH46SytmTk8Slg0kIpXTd+mzQHKKRf/2iDzsnqGVMjGPRE9+DBFsYbBFT/nsdK76g84OYeWjTCy/ugH7hhJGblxp9QHCd6gHCDTDAZqCNDXIua8vZYfomj3dOQktHvltbniTRea4fSWnTTJoFV15ZAUuQJ6uUGy4xF96+zTC5TvcQXi1I/XsJ1nXnsI8IbQHZa87gp0Y5b/q0KIu4XnAvk4yHGApuvkVy0qJJC1zhUMltwAmOgBpwdTiEla0a6vG33cuyJjjWlvPsH6o3i8mVfk0xohSpjS6Mz6c+s5eiS3QpMBga7gXFBRkEtRiQgCy//2Xx+HJ6qQIJsp/5UeYCxTdXkMH20Dmu7zPJCUSjtAgXj3UEN4/8Hs/wxlVKXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(4326008)(41300700001)(64756008)(86362001)(76116006)(66946007)(66556008)(66476007)(91956017)(66446008)(8676002)(8936002)(5660300002)(36756003)(7416002)(85182001)(316002)(2906002)(54906003)(4001150100001)(6916009)(83380400001)(71200400001)(38070700005)(2616005)(478600001)(6506007)(6486002)(26005)(6512007)(186003)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHVRN253aEd5eVdmcTVVNTNXMDhQTHhwVkVoeVh3a1ZBcFJVWWNpeDBROFVx?=
 =?utf-8?B?cFhjSkZCZ0ZXSjNCZzRHRG0wOUdkRDgvUU5zaUJ3WnpZWENvSURwNjlDMDJX?=
 =?utf-8?B?OUtpMmh0cmhQcm1iRSt4RHV1ekxCRWJFeEwvNUtWRzlFQVpCM0dCYTlZemFy?=
 =?utf-8?B?RDVWM1J3ZllxTkkxTWdiM1pFcmNXOEJYdjhBZE9JdDZDL1YxeDd5QUZVb3hN?=
 =?utf-8?B?K1hVcGkvckRHM0RYN3J6ZldLTmVMS1pkZkNkLzBGanl6TFpqcjlwMUNJZzc0?=
 =?utf-8?B?TStoK1RVYzY0VDNlbWNheC8vaFBHV29kUlcwYTdZcXM5bE5vMUNMdFFpaDRZ?=
 =?utf-8?B?dmRvSUJXVmhtZVlCNVk3ZHhTUU42eEUxeUdWR05nUjZlYUd2S09UTXJvUDV5?=
 =?utf-8?B?SU1qYkhLbWRJWUE4Uzd4RHphRHdlVFhVdDB3UmF6SHU3U2xCVklSQmZPUGVz?=
 =?utf-8?B?Qjc5UFppL2JHbGJFdXkxMEt1ODRENWtKSWNTL0FsS21laFNlZFh2dDd4NklO?=
 =?utf-8?B?WElpRDNndEcwTzdYcDFOSXBLdTI5TEUxeWxLb3ZsTjd3Wmx0YjFEL2MxQWVw?=
 =?utf-8?B?bmhGQVl3NmtIcWN6bTdMK0VXVVl2S1BNbUtMVDRyT1JacnN4MmhtVHdXT0Vy?=
 =?utf-8?B?N0xhenlKbUY4Tjk0QkZseU9UelRuWTBrSVZhd2FTVXNRMGpxZEJLOUJnME1I?=
 =?utf-8?B?Y1ZFQ1hyOWxqVzVzbHN4TktVcnJvZnJlWDBqaVlWTFVqNWhTUlRsZTFPYlRS?=
 =?utf-8?B?MnlXQ05OcFl2dlVLckN4bWV3WHRNSU9qYk9oYmIvSENHeVMweS9NbDdmYmlk?=
 =?utf-8?B?cHh3VVlleVZyVjUzSjlkOFUwS0sveTNLT2hxRG1KR0pYNXJyaEVzNVlmUTVH?=
 =?utf-8?B?VWhkQ201dmk3dFZyYkxoTE40a0pKb1V3UDdSdXA4R2Q0RFc1U1ZkL29NaVZs?=
 =?utf-8?B?UHRZS1B6OERSZkl5TnkxTS9XRmkxemFkOVJBOVdXVUVqZlpCZ0trOWVjNlNX?=
 =?utf-8?B?UXNRcDVFK2l4dk1tNmNKbkcrK3JpTFdYYW84dDNObFRrWGZVQnhCQXhYTjJG?=
 =?utf-8?B?QzkyeGxRTWJkZkp3SERMdmIvMjdXUmNPUDlOUWZnaW5sNk1iZm5WRVhQK3Z1?=
 =?utf-8?B?M29iWEtTTUluNnVqK1RHRm1wME0vbGd5ay9GeDRieW5DQjNBcENFRlVSdVBt?=
 =?utf-8?B?TW80YW1pWGRwNU9iVnE0dng2MTltZ0V2UkNNeXV3SlM3eFlZRHI4d0gvZEdS?=
 =?utf-8?B?OUdQLyt2dUZQS0ZySVVxZnpKM0RSZHhpdnVpcjhDK25EVmFESVQ0UkIrNjJG?=
 =?utf-8?B?VUo2a0Y0VVJ3NzFCc1hsZUhEeWJrUmhNSEYrR0dYNDhvZThnUkdXTmRHN2xU?=
 =?utf-8?B?OVVXQVFkc1BSRUxkNHRXTjRWUmFhWFF0WUpyRlZYRVV1OXdsZjBTc28vMWND?=
 =?utf-8?B?cWJXZUR3OEJXVVZwUjZhL1RFREgvbXZqU0tMZGU0ai9ZcjlFUDRCbUtOekNz?=
 =?utf-8?B?YmoxNWZWRWc4QUthTzNaSkE3V1grdDYyS3RneDRPTFJjOGxmZFRpM0RSb1Fl?=
 =?utf-8?B?NGtQWTZTdzdoampIcWdEUWtKY1BhWkxQUzRxU25RdG4ranNvOEFadnRFTWRi?=
 =?utf-8?B?dEVCaU1GQmoxNDA1TVRPNEhmOGE5NU4rOHNBSWJlS1IyYThHTE4zUmU3Vkwr?=
 =?utf-8?B?WTJJc0ZvRkFpemF0aDg3ejFyc0c2VVR5TWxtUlBVaFZxNkR6Q0hINnMzdlNT?=
 =?utf-8?B?TXhpTlVSTUZQWGpyMGZhYnBJTWk5V01Kc1VjVnJ5dTI1bUMwbUJSK0xLa0lt?=
 =?utf-8?B?SW9uZEREcnE4UVNRQ1BobzlYWkJLUi9oZ2M0b01LUyt6cERma2M1L3VSZjJM?=
 =?utf-8?B?cUlKSm9uNmlMODFaQVZEV1NhSDJUOENPRGJOUysxOVYwMnVDNnhYV1N4M25o?=
 =?utf-8?B?c2hvM2RSRTM3c1VEbVNIYXZzZkxNT0RmTTJuWVczdk1iemhORWt4NjUyYi9I?=
 =?utf-8?B?S1piUm1iSjFwbkVtQlQrSUdYL1ExRzhXSzVnbWM5RVBWbVF3VGJaK2tmaUNs?=
 =?utf-8?B?aytQa1FJdWlYMzJobWJGc0FwZW1meUl1QjNhNzlKekVFWnNDUG5MbkttVTYx?=
 =?utf-8?B?YmFlVkZTRE9hWTlqbFF2M0xQdUN1dDYwajk3Mk9nVXNlMHlaTXNiN3lqZUVK?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <403FEB4F6307EB4DA2909930CCBC4589@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8848234-a20b-445f-746f-08dae934d260
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2022 00:37:10.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSsZ1o8iXr3vBBK/6aRTADuE4GIaQ3uXj/IAnBwJ1mLik9YfuXqB73wJVOze9mAF7rpXszNiJ8EKq/8PXSGK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTI4IGF0IDE3OjAwICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiAqKioqKioqKioqKioqIE1FRElBVEVLIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioq
KioqKioqKioqKioNCj4gPiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWls
IG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkNCj4gPiBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVu
dGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yDQo+ID4gb3RoZXJ3aXNlDQo+ID4gZXhl
bXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxlIGxhd3MuIEl0IGlzIGludGVuZGVk
IHRvIGJlDQo+ID4gY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocyku
IEFueSB1c2UsDQo+ID4gZGlzc2VtaW5hdGlvbiwNCj4gPiBkaXN0cmlidXRpb24sIHByaW50aW5n
LCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbA0KPiA+IChpbmNsdWRpbmcgaXRz
DQo+ID4gYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5
IHByb2hpYml0ZWQgYW5kDQo+ID4gbWF5DQo+ID4gYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90
IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwNCj4gPiBvciBiZWxpZXZlDQo+
ID4gdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5v
dGlmeSB0aGUNCj4gPiBzZW5kZXINCj4gPiBpbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhp
cyBlLW1haWwpLCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVzDQo+ID4gb2YNCj4gPiB0aGlzIGUt
bWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5kIGRv
DQo+ID4gbm90DQo+ID4gZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8gYW55
IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0KPiANCj4gUGxlYXNlIHJlbW92ZSB0aGlzLiBZb3Ug
YXJlIGtub3dpbmdseSBwb3N0aW5nIHRvIGEgcHVibGljIG1haWxpbmcNCj4gbGlzdCwgd2hpY2gg
aXMgcHVibGljbHkgYXJjaGl2ZWQsIGV0Yy4NCk9LLCBJIHJlcGx5IHdpdGggdGhlIHdyb25nIG1h
aWxib3gsIHNvcnJ5IGZvciB0aGF0Lg0KPiANCj4gICAgICAgQW5kcmV3DQo+IA0KQmVzdCBSZWdh
cmRzIQ0KQmlhbw0KPiANCg==
