Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D263ABF1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiK1PHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiK1PHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:07:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E757763C0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:07:33 -0800 (PST)
X-UUID: 25cb56a791d94d4b88dab09c1e8b4242-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dINE6Xhvn7YUOai/PfP5uhy0ROfVawakvh71A0GPvZI=;
        b=FjHDA0JSOl9fJSfXADmKG16JJv8aEfeMXMTnwsx23B4fmeKpN0vHK97eAFghMhIntOtJYiWfsYGmK0odO0nZgKs8iHhC1ir27co9Vcv639hUub83VGXHvrUfLaKfuD/joyxrUcFngUnN0dQqs8s4DYTSdQ2K/JTCJoxY2wgyA6M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:bc2cae9f-c53f-42bf-bb88-271096aa29c5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:bc2cae9f-c53f-42bf-bb88-271096aa29c5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:7148861e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:221128230728FKRO8C18,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 25cb56a791d94d4b88dab09c1e8b4242-20221128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1121477426; Mon, 28 Nov 2022 23:07:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 23:07:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 28 Nov 2022 23:07:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QElXkx6VmMI4+D6Xq3yqeBia9dlgiNqFD9QmWBRYB+53SYM3G2JfGD3XhNLqn2GNJ5IvCl/xsFDkH/0xaC+hl/ggmyy9RTV9MtUC3Soyvli+LhEJFcs2cvEjvCuc20FdkcGXqn1qFKVZnPBCheRl4EIHkdpAvfCH1j456CXtxxV4cy3euf0EyoSTxsYmb3jsf7ACzJSc4ee5Zm0WMxbeqix489LVunVVo0WaobXMeWNiauVWmFHr5WrsMk5kUrGhckxbQPTi9Xhxro7f6G5RHUv8CXP7EyRSFA9d70OKINpsK6v+1hWdiSqqYEhOaEUAMASpYNkqHBWGFlA+Qxlstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dINE6Xhvn7YUOai/PfP5uhy0ROfVawakvh71A0GPvZI=;
 b=hDwYGtn7UG961vw6z57tfO+WPKmKc3FZ+DihtFdHZkEwjPB2VuY7RIYAOSSAfXLRNUJMQHI0MHpJdRC4iO9Ssq1695rMzLQrSToLYTT+SYuKp4zWqcWTPWhuKNKKwWmjZrCV7QrJbBN5Nwm2oIiJHo+TszfXAyc0X3dvnPeL5C7qHO/vbCKyIBwedCGidFnj8SUMlW3hh/ffCsBGWicfkBj/v1R/amgiZzTYdxLadyy3b2+13uoJX6p5NdOZviCx6u5JR62kuVYABoLANsVhWQmfGHfFRrs9XrXDl9hYJeeZecVvZ/uQAlHJYETm03oLn89BDIjZNIwKZ8i/l0X1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dINE6Xhvn7YUOai/PfP5uhy0ROfVawakvh71A0GPvZI=;
 b=gqvWsWInvVhBkxvVSKhBntLTxcaGpSJYW3MSpeaA33BwYBWdVBubP5p8YD5y77eBacm1h7fN0nXs8AOgcDaa06u1O+Q6wvpbnhli+AnI4HlPHeUcZEbJcj40DwTIpMJ3OtG8Cy37zxAxHQJrfRmB4Ya2VUWanol+6nwfUQ/CQko=
Received: from PS1PR03MB3384.apcprd03.prod.outlook.com (2603:1096:803:49::13)
 by TYZPR03MB7060.apcprd03.prod.outlook.com (2603:1096:400:337::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 15:07:22 +0000
Received: from PS1PR03MB3384.apcprd03.prod.outlook.com
 ([fe80::2e82:cce2:3b26:ab6f]) by PS1PR03MB3384.apcprd03.prod.outlook.com
 ([fe80::2e82:cce2:3b26:ab6f%7]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 15:07:22 +0000
From:   =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Thread-Topic: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Thread-Index: AQHZALKPLtjy9JnSM0qA0l4xMT7+Dq5PjsoAgATmBQA=
Date:   Mon, 28 Nov 2022 15:07:22 +0000
Message-ID: <18c82f6f723cd97a9d6b9a7ff16c6ed62fd005d6.camel@mediatek.com>
References: <20221125094413.4940-1-jiaxin.yu@mediatek.com>
         <20221125094413.4940-2-jiaxin.yu@mediatek.com>
         <Y4Cysgk5Gic5ae9B@sirena.org.uk>
In-Reply-To: <Y4Cysgk5Gic5ae9B@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3384:EE_|TYZPR03MB7060:EE_
x-ms-office365-filtering-correlation-id: 05a8c6e5-402c-4a30-5301-08dad152406b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUCqNXMQEtJ4SD6UVqAGIE5WjXqNtQ2oc5kZdrt3FHHtXtpWCZ4t2e2SbFkxx7mwJ39D7YaoV62QW2ae0tTKJser6Z2oAz17KBTzgnAnTkLDekdQ4MCkGJF0XWbTzIn3dso1Ev2yhMK+o8CzJNwQ70I85zdfzJh10UEjQQiOwvOSW0X3hseQLPu3qu+r7qN0Kfk+allu5Db61eE0JFQKFCyQmPtWD8g8KMWvhG54V46iDPa2eloiuJXyEn2ZH2QBC7U4NsMoVH1eIoT7Qpb2Y62jsW1w/TpnkvWDsHjVTuBVNnRlcjFl4zsBuDba5URQhB7CepI17Q/5ycJCQMaqqQB8LOF5B07prd7Efg9cWmrCcmbsm4zT2I2Ka6im3l95rxoIlh0v2cS2JJdp9A3mJBwZOFjhkbidgo/v7+pIczFQ7gPSm1nJVVLZc1s+sNDPXb+IaOUZJPZzzs+HikCG9XVVCSz0A+MyF90Dc706zEyEA0YacC9IkSP/B+IGRBwt0++ALN3PhDkHBc736/MrBvny0FQSjQogbydLQZn+Wty/4mxEM63nOO9lfZSRXAA6wMg0j//r0N0YfraGggMd+rqiW51zychtxvNN4h0FY35HyLn42KPL68jvOUlI1QVx/FXhURbKhmpReinYqkW8SMVjeavppaDueBh11rwQ8HmVlclVBf4//YgWMZ/KWZgK4dnAkCKXNDZ0E6vKSGCtpqnEtTBTDL6rcu4c60ebezg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(85182001)(36756003)(2906002)(4001150100001)(86362001)(6486002)(7416002)(71200400001)(478600001)(76116006)(6506007)(316002)(66946007)(66446008)(91956017)(41300700001)(5660300002)(26005)(64756008)(54906003)(8676002)(66556008)(6916009)(8936002)(4326008)(66476007)(6512007)(122000001)(38100700002)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVNLK0dzNFc3c1ZsTTE5b01HNVgwbWRFVDhHcmlxZEg1T3JWaXRkK1hrWkZK?=
 =?utf-8?B?R2F1RTNDWWRsVVdFVGJhcmljS2NFbmtGdUZ6OHZNSllkWEJaNlU2L3BEVXNu?=
 =?utf-8?B?MHg5NDdSWnI5S2pUS1Y0YVpZL1B6YVJmM09sR2twMUx5SGI4MWIzK1J2R0FP?=
 =?utf-8?B?QkFWanlybE0xQWJueEt5NEU3VGNXUmhLZVFvanIrL2hZazJtOXVHTy9IZnJk?=
 =?utf-8?B?NjF4Y1NOWHJuZmpVeG13L3VDSm9QdFovWE5lVzF0Y3EzUEc0SFJDR0tMVTZ1?=
 =?utf-8?B?RVBVUFJpVU1JckhiZk5rSkpva24renJyRjliVEloNGhyY1Z1ZHR2K3JFNFN0?=
 =?utf-8?B?ckxJbVJpYXpWT1U4Uy9XcE1jaHRzK1RIcDQrV05XWTMzVFQzZ3V2dEQ3NEI5?=
 =?utf-8?B?V0RsOHZzbG9mWXVkUGYxTHAvT1ljSzY3eHNCNG9JQ1I4OWhmTkJRVkYwUWta?=
 =?utf-8?B?NDViUG94WUNocTUrV241em1xZUE3WlFQSkh0MjBCbFE3ZmFselEzMURhYTht?=
 =?utf-8?B?UUszMWFHcy9ZMkp6OEg4Yysrd3BjaVZXVUtyT2w1NjFwMVdiOFZLUllGNndE?=
 =?utf-8?B?MUFtRSs0MkRDUDJlQThYWU1PVFpHMUxxVS94YW95RWNzSEUweTJQNjB4amxO?=
 =?utf-8?B?L2NPQUx4WkE1TU5MZDVlTjVSQ2haRmoyY3BGSmJidmVKTzJRVDJkT3UwbE9P?=
 =?utf-8?B?UEZ4a2ZQRlhMY3lZRHFSV0ZOUVh6MGw4MkxqNitDdmkzWlpuYlVab1VoMFVL?=
 =?utf-8?B?UFpEZzV3d1lIa21UQ3FkbU96WW1PMkN1UFBrdXBEWUhWV3g0MEQvci81OXgz?=
 =?utf-8?B?cWEweEg4cXR6R3gwemE4UXN3MUlERTJCTWdWZzMwSEtoWTErSTVQOGVUd0pa?=
 =?utf-8?B?ZS9hVGFoYkQ2a2VmYnc4Zm8wT2g4SUZoWkZ3QWtENVlYbE9ueUE0VTUva243?=
 =?utf-8?B?R09hZUZPWUhPZDZiWXpFZ29DTjVmU0dDdjljd0R3ZmRucHBWZ1FNSjhUaWhI?=
 =?utf-8?B?T0xzZytZWVl0UUkrYnNmUEEyZVFQdGhOSEw1dENiR0RHbzU3ZHI0K09RV2hz?=
 =?utf-8?B?UzdBQnFrYytxTXBMOXdDVCtRakxOMklFM3JFSTlsMFlsOFpMdHFBRWlabjc5?=
 =?utf-8?B?V29LakVhaTFQcEJTOTJ6Q1RGNWx3cUEvajk0cmRlTHFEVU9iczhub1lWdExu?=
 =?utf-8?B?Yk9OQ25ZeDNvRTdsNEhJc1V3dVI1MUtwaFRkUkg1UUs5NVgvMFcvMEFJRGsr?=
 =?utf-8?B?MThIT0ZRVE1xL2NYWkRVc1M5N0RwV1cxaHFkcS8xOTc2SFR2dEtmeUFXQnVZ?=
 =?utf-8?B?anlEOUNCUEVCWlR1V1dSNmJmbmkvWCtEWkczRmIvUXBkUlZkRHRzZFNTUGZt?=
 =?utf-8?B?OXppU0VuUmt0enhMRGxNK2t2Q0xteXpsbEl0TDFLV3U4SWNGQU56S1Z1UkRB?=
 =?utf-8?B?ellDTDFVMTFnNndCYk50VW00V2RSNjhWcVExNUtiazhBQml1MDFmVHFqcUtS?=
 =?utf-8?B?Ym5KdC9kN2twRHBMTCtGbW93WlVITTFwc2JJOGtZc2JrdUNuNEVnLzhXcWFX?=
 =?utf-8?B?cUVNT3RJTnN4UnNIT0NxV1VsTGR5Z0tNTUJLRlhaeDE0Q2pEMWFaeEowcC8w?=
 =?utf-8?B?M0l2V1VhVS8wYkZmZU5VcDd6V21RVUcyMU15dDl4aFhVSEJCWmpwK0Uycnll?=
 =?utf-8?B?bHNDUVRDd2x1bDgyNC9Yc0pFanZQOEczcFNneDh6empNdFRjUlVZWTN5QWda?=
 =?utf-8?B?UlhLMWdpaHovYVhRaTJYdzhuT294NXpCMEpaNUgrb3BtTmVzcExyMlpYaDRv?=
 =?utf-8?B?L2xnQU1HM0NQeEtyVFAxSU1QVjJEUEljTkxmTnZEY21FMUMxMkd0cTR6cWQr?=
 =?utf-8?B?aS8wVURxMXlPOE8wSnkvcHVKSHlLUE8xOWFqV0lBRStHWWd6bDBZNG4rNnZa?=
 =?utf-8?B?dnZPUXZ3cERpR1hSZ3FKMzVFZlYwZFBCeFBXYmw4WEw2SmpyQWkrZFRENHZl?=
 =?utf-8?B?WS9OSTBWdW9LQmpXeE83L3VwWnFLcGs2eHZuWXRaZDIzLzBEMVpEdmFTK2Vz?=
 =?utf-8?B?em1Xd0p4R0xVakV1RmYxOEViU0FreThmZlJ6b0pmUjg0Y0FVMWpqT0RsbW1B?=
 =?utf-8?B?WlkxemNWWkZjU1lVZDZ4MUN4ZDNYTG1GMWtPUDhiV1NlWVQyOE5OWEtOcVkx?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F01B049A8C886944B1618C5C930AF989@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a8c6e5-402c-4a30-5301-08dad152406b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 15:07:22.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFQIqiOiXR3sau6G+UUuZ1e1N70Jb38RK/1QDqSNTs0eBAKR4Y8ZwB/Knq32LI4mSkYAU0vlUh63c4ijnf9IyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTI1IGF0IDEyOjE4ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIE5vdiAyNSwgMjAyMiBhdCAwNTo0NDoxMVBNICswODAwLCBKaWF4aW4gWXUgd3JvdGU6
DQo+IA0KPiA+ICsJLyoNCj4gPiArCSAqIFBDTSB0cmlnZ2VyIGNhbGxiYWNrLg0KPiA+ICsJICog
TWFuZGF0b3J5DQo+ID4gKwkgKi8NCj4gPiArCWludCAoKnRyaWdnZXIpKHN0cnVjdCBkZXZpY2Ug
KmRldiwgaW50IGNtZCk7DQo+ID4gKw0KPiANCj4gTWFraW5nIHRoaXMgbWFuZGF0b3J5IHdvdWxk
IGJyZWFrIGFsbCBleGlzdGluZyB1c2VycywgdGhvdWdoLi4uDQo+IA0KWWVzLCBpdCBzaG91bGQg
YmUgZGVzY3JpYmVkIGFzIG9wdGlvbmFsLg0KDQo+ID4gKwlzd2l0Y2ggKGV2ZW50KSB7DQo+ID4g
KwljYXNlIFNORF9TT0NfREFQTV9QUkVfUE1VOg0KPiA+ICsJCWlmIChoY3AtPmhjZC5vcHMtPnRy
aWdnZXIpDQo+ID4gKwkJCWhjcC0+aGNkLm9wcy0+dHJpZ2dlcihjb21wb25lbnQtPmRldi0+cGFy
ZW50LA0KPiA+IFNORFJWX1BDTV9UUklHR0VSX1NUQVJUKTsNCj4gDQo+IC4uaXQncyBub3QgYWN0
dWFsbHkgbWFuZGF0b3J5IHNvIGl0J3MganVzdCB0aGUgY29tbWVudCB0aGF0J3Mgd3JvbmcuDQoN
CkFncmVlZC4NCg0KPiBJJ20gYSBsaXR0bGUgdW5jbGVhciB3aHkgdGhpcyBpcyBiZWluZyBpbXBs
ZW1lbnRlZCBhcyBhIERBUE0NCj4gb3BlcmF0aW9uDQo+IHJhdGhlciB0aGFuIGhhdmluZyB0aGUg
ZHJpdmVyIGZvcndhcmQgdGhlIFBDTSB0cmlnZ2VyIG9wIGlmIGl0J3MNCj4gbmVlZGVkPw0KPiBP
ciBhbHRlcm5hdGl2ZWx5IGlmIGEgREFQTSBjYWxsYmFjayBpcyBuZWVkZWQgd2h5IG5vdCBwcm92
aWRlIG9uZQ0KPiBkaXJlY3RseSByYXRoZXIgdGhhbiBob29raW5nIGludG8gdGhlIHRyaWdnZXIg
ZnVuY3Rpb24gLSB0aGF0J3MgZ29pbmcNCj4gdG8NCj4gYmUgY2FsbGVkIG91dCBvZiBzZXF1ZW5j
ZSB3aXRoIHRoZSByZXN0IG9mIERBUE0gYW5kIGJlIHBvdGVudGlhbGx5DQo+IGNvbmZ1c2luZyBn
aXZlbiB0aGUgdmVyeSBkaWZmZXJlbnQgZW52aXJvbm1lbnRzIHRoYXQgdHJpZ2dlciBhbmQgREFQ
TQ0KPiBvcGVyYXRpb25zIHJ1biBpbi4gIEEgcXVpY2sgZ2xhbmNlIGF0IHRoZSBpdDY1MDUgZHJp
dmVyIHN1Z2dlc3RzIGl0J2QNCj4gYmUNCj4gaGFwcGllciB3aXRoIGEgREFQTSBjYWxsYmFjay4N
Cg0KTGV0IG1lIGRlc2NyaWJlIHRoZSBoYXJkd2FyZSBjb25uZWN0aW9uIGFib3V0IG10ODE4NiB3
aXRoIGl0NjUwNShoZG1pKQ0KYW5kIHJ0MTAxNXAoc3BlYWtlcnMpLg0KDQogICAgICAgICAgICAg
ICAgICAgICAgID09Pml0NjUwNSANCiAgICAgICAgICAgICAgICAgICAgID0gDQpETDEoRkUpID09
PkkyUzMoQkUpID0NCiAgICAgICAgICAgICAgICAgICAgID0NCiAgICAgICAgICAgICAgICAgICAg
ICAgPT0+cnQxMDE1cA0KDQpUaGV5IHNoYXJlZCB0aGUgc2FtZSBvbmUgaTJzIHBvcnQsIGJ1dCB3
ZSdkIGxpa2UgdG8gY29udHJvbCB0aGVtDQpzZXBhcmF0ZWx5LiBTbyBpZiBoZG1pLWNvZGVjIHVz
ZSB0aGUgUENNIHRyaWdnZXIgb3AsIHdobmUgd2UgdHVybiBvbg0KdGhlIHNwZWFrZXIsIGhkbWkt
Y29kZWMncyBQQ00gdHJpZ2dlciBvcCBpcyBhbHNvIGV4ZWN1dGVkLCByZXN1bHRpbmcgaW4NCnNv
dW5kIG9uIGJvdGggZGV2aWNlcy4NCklzIHRoZXJlIGFub3RoZXIgd2F5IHRvIGNvbnRyb2wgdGhl
bSBzZXBhcmF0ZWx5PyBUaGFuayB5b3UuDQoNCg0K
