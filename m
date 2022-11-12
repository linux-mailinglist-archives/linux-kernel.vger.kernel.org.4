Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7083762674A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiKLGHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiKLGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:07:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA01A22F;
        Fri, 11 Nov 2022 22:07:06 -0800 (PST)
X-UUID: 34aa71b5fa834d9db1efe214db78a6ec-20221112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lRsDx+MAZtvD52eXlVq9x+AOjSOFxX7WpEdCiqQOJ78=;
        b=Zo/ZUvZQPz3hS3HX/BQAZ8nxo4c9AaKcOM4hNPLcX18dozAwvxNCcwqXh33lj9k6GunLmh9SB2Dg6IbA7iXWgXW1oEKiLuO7wVHKDag64Mv7wkd6LU1bzo5mgH2KnKj+MmyVK8FKrqXKrD42XWd6I6ekKxJXxvRHyFf0dJR9Mao=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:6630a688-7147-41f9-99f9-be11b36750a8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:41441551-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 34aa71b5fa834d9db1efe214db78a6ec-20221112
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 295234407; Sat, 12 Nov 2022 14:06:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 12 Nov 2022 14:06:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 12 Nov 2022 14:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHJfVchsseyRrkNle4ybZ9UoekNrHTlQSaxicDPXeLnBUCx2FlCKepBogotoTnlMWWVCLPftwTXUtfIv6pWObwAIbRC+JeHY/KKlOXQHXl4ZZ6SIyIAK1ss4Vec8D9o7ADYBnbUoVXkeF8+TzCcQHhPyeCIjh0Oe3h29ddcXGt9p81Ex4iahK/bfzaR9jz671VkLWuoosUCJ1e/3kb6USCPnld15sGbFNLB7WLBxbNMFRSBmjUrcJ9GP2dk8zNtYNnrcehrtBNvNbplqkKQlXmUgIE0sK8ayt/s9dChrB2q5MLWDZQcUV+if0orbQ7gLZj5U2iWnwnEPo3k3VBe0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRsDx+MAZtvD52eXlVq9x+AOjSOFxX7WpEdCiqQOJ78=;
 b=MOocwcCYJYiN5GXeDHuWZHqsPkC2RJ5KIOBx2lQ5YG6lW2BhMq7PZAOMyld/qZFqGahgjFxB56Z3ZNM8sJ0SYY1U7TKFyARt2ifTHkFDpsB1ECPhGqG/wzW7KNIgYKbSuJ3oK5ur6Gob/my874qS4WgQAW0HgH3Boz1iRof2+00ixb5kPo+RAEEKC3ed03NbLPhyfdDTMPfFDeXjr+xXUnjgstz8964j38miCzGRmP/K4lgHt/YnnG1jtLF6G38966UI0jJqFbIUFfC/PlSaMbIMPVjhhj8WUiPD1PLP1AlKi6F2mz9RlEIeEofeFJNsfoH/z84anxsXCd5QWEMrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRsDx+MAZtvD52eXlVq9x+AOjSOFxX7WpEdCiqQOJ78=;
 b=R5HnUmCK9uVdC3KtkGdJHdRGY6JVJUK7pztLCMmpTRnTNzXwvfJIpyBehb4YskRAYvBmF+4jGv5z/q6F2MSMaamSZCcLO4Dun0HvXaoyGjJ43w/en8VsSC5RFRgdCjYXe8JNE6wvo1QCc/W/fG/ULKoS43JdvibW6Q682G5xE5Y=
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com (2603:1096:300:86::18)
 by TYZPR03MB5440.apcprd03.prod.outlook.com (2603:1096:400:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Sat, 12 Nov
 2022 06:06:49 +0000
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::55cc:c325:bcf6:ce1f]) by PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::55cc:c325:bcf6:ce1f%7]) with mapi id 15.20.5813.013; Sat, 12 Nov 2022
 06:06:49 +0000
From:   =?utf-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Topic: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Index: AQHY70U3L+QgZhq720C1cLpB3c3zja4s8viAgADXjICAAJv0AIAKtUCAgABiWYCAAV1JgA==
Date:   Sat, 12 Nov 2022 06:06:49 +0000
Message-ID: <e546de4ea3b1e29da6f9cdf56c8bf1582b70944e.camel@mediatek.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
         <20221103052843.2025-2-bayi.cheng@mediatek.com>
         <10529948-a9b8-2121-7adb-0e94cf3cbf6a@collabora.com>
         <c612cc0eb4fc463a9bfd9094ff652ac9@AcuMS.aculab.com>
         <617c0b563a2602668fde7d96e1bc98648870d30c.camel@mediatek.com>
         <794a0249500bf90a79f30a3522108e721fe06e17.camel@mediatek.com>
         <34de22c0-1773-10b4-c3fd-387fd311ac11@collabora.com>
In-Reply-To: <34de22c0-1773-10b4-c3fd-387fd311ac11@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4747:EE_|TYZPR03MB5440:EE_
x-ms-office365-filtering-correlation-id: ea986373-3a29-40c7-df4e-08dac474166d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRhNnv6e0S0eNr5hn/gOrNsLrkjUtw0wcvRRwtszuL5lRxmEMebYGQBrg/DYaVqLCEr0AMt4lOFhe7t73+Cd21pz9W2RXiKsFfm5ktz25c6DALdh/QdqheGVkhtb/XZr+W/E6GE0CJ/nkxhtkSesxq4ziByf+FsdVSSgasCzVRQyWJAGr9JOSys6z5o6mTllSCA9kL1ghrgLh3N79+vyhwi0lt620HtJNq18TlKz5t0NIfi9QJzuT3BcGXyTIPn7YJSBYrwyiY8ri0pYVljVA/WD0vGdYY6GxFQ8WwsxUto8sdjJxBh+MxrAfAZfWTNPCy4UCUl5ZnHEvW4UGJ+XVfdCa0FIZFglbogg1xwNart89nZ17gvT3+2YI7hkqyNxwS0NrN7OM57b3D8hUz+HQis9kXduVynNAsPI8ClMPvllEsFbUhsW1SsCpdvgscP/j0zoWCzCFpvsdF2vjq2qDPF3m1hnPoayWEI7J8pywf8cIls07JLfUy8U4fxXneM34SSbIBdbsQOex9W2Yq7zOWqy9CIvVF5H0RYhhSV9GTpqSxtePXFmBwfT/K2RfQ3RNkBrXljXdbtonWlvLXx7EWG3u/k/iDd0Pe65za0CU9YdTAUDqo0dNnCiwkUmzQcuNHgDqXaio6TIQYslG3atQ9dk1syIjF17KWdKxNWogE9dCovypkQVb1aZhfu5RqJ+ApkP/2/EUp9fsPPn8YfT3RwJtXvGiZHfuIjkpBPySGIMDXeHnff5IuEcSTfkDPdaWo49p1iTP/u8QixzIUtZahyjtfwsMh3Rv6ieKImnUc/o+YEEpPo0k5piCfmYRaCl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4747.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(4001150100001)(2906002)(41300700001)(26005)(5660300002)(6512007)(66556008)(91956017)(85182001)(66946007)(66476007)(66446008)(76116006)(64756008)(8676002)(4326008)(36756003)(186003)(8936002)(54906003)(110136005)(38100700002)(6506007)(122000001)(38070700005)(2616005)(316002)(478600001)(6486002)(86362001)(83380400001)(107886003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkxVN2Q3b2cyTUQ4ZjI3K0JGeXM5Mm5GMGxWK01sUzdya2dXU1ZQTlVmTmhM?=
 =?utf-8?B?MURVdUdKMlY3c2RQRFcrS0txN0VreXBzWG1GcHY2YmR1R3NwaEI5YmhJalFP?=
 =?utf-8?B?eWRqbmpCRS9uczN0T3cxWUliblVDYzc5YVo4d2lsMmM4M3NhRGJMUVp1WDBm?=
 =?utf-8?B?bU1yWTlUcUhuWUd4b1NWWDNEVWNrR3puSndxNVF2b0tMWXBRQnIzeGtGd0t0?=
 =?utf-8?B?SHVjNXp0VEpWdUdFV3d6cmdJamtjT2lpM3pxTzROZVc0dWt3OTVFazJHZi9O?=
 =?utf-8?B?YUlBUXJpeXZnSDlPcFF4cU8zK1hLbEdIZDF4SEsvUm5iNFhVU3IxUDV4SUlM?=
 =?utf-8?B?NjdaVURxQjF5eVRWSGZ0aE1iUjFRSWREZ3FNWTVqbExKSEtYQWRFYVNXblFW?=
 =?utf-8?B?VzNRRGRVY29Dc0tCTXpFSGhIbTFERTBSRFZ5WFo0NGMwZE4rb2RwcTQxaC9i?=
 =?utf-8?B?NVVJU3VudmNDUWJ0VW9pelcrVW1BNnBhb2JWODYva3pGcXB3dHZLTjBwemoz?=
 =?utf-8?B?Y3A4eVRoYUxGaFRZV0psM2VndWt2UzlpSXlNWlRqVE5ObTRoamFVbkRRSy9Z?=
 =?utf-8?B?bjg2RFg3UHdSRXdhZDVTRFZjd0Y5Y2ErM1ZIVDhTR01tOVBGTjNBVmxXU2Fl?=
 =?utf-8?B?bE1aQThNelRVYjgxNUI4WnRURHpUaXZibVprL1grbUVSSXJLeFpsZkZGVzNQ?=
 =?utf-8?B?N05OZEZoT24ybEtmRXVKMm0rSFVTRmxjVHh3ZWEvV21kUmFYWmJWeXJjMW9K?=
 =?utf-8?B?N3RYT1VhOE5oNnNlZVMySTlsbzlhTnpPQW5zcjVvWjNhaUd6R0VjblZ6MnZM?=
 =?utf-8?B?RWVSalFBQzF4dU16N1ROMktoenVCRTQwcVN3Q2dMYlRwQlBRUjVyWjdFYkZD?=
 =?utf-8?B?Z09oZEowUmpMQ2FQVzdPdUo4YkVRZHdxNWFiVlpubEZ3dUVJbkNualQrbTVB?=
 =?utf-8?B?TFlLQTBWTGNzOUFKNDFMYXhSTk0xNW80Q2RGWXF4Mm10TVUraUdPeUhMVzJO?=
 =?utf-8?B?eHJ5bWJhTXpvandLdVQ0NTczYjlzZWlzZGh1ZFBBbEgwQldvbXU4MkVLQ0ox?=
 =?utf-8?B?cjZneEprUXlTdHZ2WlpNdVBXWmJSOHQzMXNueE5OdUdYZm9TdzB5cWg3THVS?=
 =?utf-8?B?K3JGWW0ycU5DZEhLU1VWNEIwa3JDb0ltc0thU0prTHFubUg4aHFXUHZUcWFx?=
 =?utf-8?B?U0l1cFFaZk1KWDQ3Yk1sWVV5VnBrVzlPdmFLVHJFS3FHSGV3ZWg4QXFYdGEr?=
 =?utf-8?B?djlxWm5qbVhvOXh2UDF2Qk16K3VST0Y0Z0t4ZmN5eE9mejFiNUprTCtlaTND?=
 =?utf-8?B?WEM2cmliRStPaCtHZW9wTVkwZ2t2TzZuNFFrQi9PTHdlaHNVMll0bGMvdHdt?=
 =?utf-8?B?cThpRUxHUkFIN1h5Q29hWlhpRXlyazdoMk1aZzF6TERMOWVJbnhLN1dLTTRD?=
 =?utf-8?B?NFJKbHFsL09tQ1gxT2N5MmFlU2xTOHJ6ZSs3Rk9qS0c0bi9sa3NxUjVRTEdB?=
 =?utf-8?B?SUpDcHJyM215eDZEbENwbEdWRkxEeEl6cHJEeUtrWnplRUpoRkltbno3ZFVH?=
 =?utf-8?B?Q0pxUnlpRTRrS2UxcDdUU1BLYUxwbUNTcG93TEw4K294dkdSSi9CdHd5Q1RD?=
 =?utf-8?B?bXYrSnRVVFBTUWg5dGtxSHExb1I0K1JnaVdCSG5vZ3pHK0hnVTd2N2MvK0N3?=
 =?utf-8?B?K0lWQ3NKa0JLRmY1c041Q0FhL0pYb1B5MDdZSXNQQWhURGY0b0l1T3k4NEVQ?=
 =?utf-8?B?SVVPRjVwa1VBeExKNnVGVldDNUM2UFk4MFR2MzZjdS81VjQ2OGZ4YkY0Q0pH?=
 =?utf-8?B?Q3ozZStjWS9rcUMrQUZZRGZwUEdMU2trQS9pbjNJdUxwL0k1Lzc0b1hBOWJU?=
 =?utf-8?B?c3ZFTkVFVmtWOU1qTjZ2bkcxUmlYUWNJeVJZbGZlZklmL0dMK0VvMk9FMGVq?=
 =?utf-8?B?YzJKZnFQeUhQUGVsb25QaFd0QzFTUXFvTlprSzFEVERUZmlXSW1KMEZuaUdQ?=
 =?utf-8?B?REJRTFIvQWNtTjhPbmxLWU95N2xSYys5bXBhblhaWVhsL2dHVVFQbWdDNEtT?=
 =?utf-8?B?MG9DZHp1cS9menB4Zm1qdDVxTWtnSTdQS2pFSENHUi9WWWIrWDVrNExlak9F?=
 =?utf-8?B?YzhCTTVTWmhNWkNkVDJXY3NGMGdtNVo2N0Y1WlBaWktHa1FaanJTV3ZReG5J?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <806EEFEF602419428B63F6F17578BF7C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4747.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea986373-3a29-40c7-df4e-08dac474166d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 06:06:49.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jX+DxsDMXvVz7q27h1Dz1RzJb+PQwdyXop6wEAiaHXKU3beHcv5LvBopYDZmxtzFntEyerMepCUm0x9GuqrsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5440
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTExIGF0IDEwOjE2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTEvMTEvMjIgMDU6MTYsIEJheWkgQ2hlbmcgKOeoi+WFq+aEjykg
aGEgc2NyaXR0bzoNCj4gPiBPbiBGcmksIDIwMjItMTEtMDQgYXQgMDc6NTMgKzAwMDAsIEJheWkg
Q2hlbmcgKOeoi+WFq+aEjykgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwMjItMTEtMDMgYXQgMjI6
MzUgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiA+ID4gRnJvbTogQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8NCj4gPiA+ID4gPiBTZW50OiAwMyBOb3ZlbWJlciAyMDIyIDA5OjQ0DQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gSWwgMDMvMTEvMjIgMDY6MjgsIEJheWkgQ2hlbmcgaGEgc2Ny
aXR0bzoNCj4gPiA+ID4gPiA+IEZyb206IGJheWkgY2hlbmcgPGJheWkuY2hlbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGUgdGltZW91dCB2YWx1ZSBvZiB0aGUg
Y3VycmVudCBkbWEgcmVhZCBpcyB1bnJlYXNvbmFibGUuDQo+ID4gPiA+ID4gPiBGb3INCj4gPiA+
ID4gPiA+IGV4YW1wbGUsDQo+ID4gPiA+ID4gPiBJZiB0aGUgc3BpIGZsYXNoIGNsb2NrIGlzIDI2
TWh6LCBJdCB3aWxsIHRha2VzIGFib3V0IDEuM21zDQo+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+
ID4gcmVhZCBhDQo+ID4gPiA+ID4gPiA0S0IgZGF0YSBpbiBzcGkgbW9kZS4gQnV0IHRoZSBhY3R1
YWwgbWVhc3VyZW1lbnQgZXhjZWVkcw0KPiA+ID4gPiA+ID4gNTBzDQo+ID4gPiA+ID4gPiB3aGVu
DQo+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gPiBkbWEgcmVhZCB0aW1lb3V0IGlzIGVuY291bnRl
cmVkLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJbiBvcmRlciB0byBiZSBtb3JlIGFjY3Vy
YXRlbHksIEl0IGlzIG5lY2Vzc2FyeSB0byB1c2UNCj4gPiA+ID4gPiA+IG1zZWNzX3RvX2ppZmZp
ZXMsDQo+ID4gPiA+ID4gPiBBZnRlciBtb2RpZmljYXRpb24sIHRoZSBtZWFzdXJlZCB0aW1lb3V0
IHZhbHVlIGlzIGFib3V0DQo+ID4gPiA+ID4gPiAxMzBtcy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogYmF5aSBjaGVuZyA8YmF5aS5jaGVuZ0BtZWRpYXRlay5jb20+
DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICAgIGRyaXZlcnMvc3BpL3NwaS1tdGstbm9y
LmMgfCA3ICsrKystLS0NCj4gPiA+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NwaS9zcGktbXRrLW5vci5jIGIvZHJpdmVycy9zcGkvc3BpLQ0KPiA+ID4g
PiA+ID4gbXRrLQ0KPiA+ID4gPiA+ID4gbm9yLmMNCj4gPiA+ID4gPiA+IGluZGV4IGQxNjc2OTlh
MWE5Ni4uM2Q5ODlkYjgwZWU5IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9zcGkv
c3BpLW10ay1ub3IuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW10ay1ub3Iu
Yw0KPiA+ID4gPiA+ID4gQEAgLTM1NCw3ICszNTQsNyBAQCBzdGF0aWMgaW50IG10a19ub3JfZG1h
X2V4ZWMoc3RydWN0DQo+ID4gPiA+ID4gPiBtdGtfbm9yDQo+ID4gPiA+ID4gPiAqc3AsIHUzMiBm
cm9tLCB1bnNpZ25lZCBpbnQgbGVuZ3RoLA0KPiA+ID4gPiA+ID4gICAgCQkJICAgIGRtYV9hZGRy
X3QgZG1hX2FkZHIpDQo+ID4gPiA+ID4gPiAgICB7DQo+ID4gPiA+ID4gPiAgICAJaW50IHJldCA9
IDA7DQo+ID4gPiA+ID4gPiAtCXVsb25nIGRlbGF5Ow0KPiA+ID4gPiA+ID4gKwl1bG9uZyBkZWxh
eSwgdGltZW91dDsNCj4gPiA+ID4gPiA+ICAgIAl1MzIgcmVnOw0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiAgICAJd3JpdGVsKGZyb20sIHNwLT5iYXNlICsgTVRLX05PUl9SRUdfRE1BX0ZBRFIp
Ow0KPiA+ID4gPiA+ID4gQEAgLTM3NiwxNSArMzc2LDE2IEBAIHN0YXRpYyBpbnQgbXRrX25vcl9k
bWFfZXhlYyhzdHJ1Y3QNCj4gPiA+ID4gPiA+IG10a19ub3INCj4gPiA+ID4gPiA+ICpzcCwgdTMy
IGZyb20sIHVuc2lnbmVkIGludCBsZW5ndGgsDQo+ID4gPiA+ID4gPiAgICAJbXRrX25vcl9ybXco
c3AsIE1US19OT1JfUkVHX0RNQV9DVEwsIE1US19OT1JfRE1BX1NUQVJULA0KPiA+ID4gPiA+ID4g
MCk7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICAgIAlkZWxheSA9IENMS19UT19VUyhzcCwg
KGxlbmd0aCArIDUpICogQklUU19QRVJfQllURSk7DQo+ID4gPiA+ID4gPiArCXRpbWVvdXQgPSAo
ZGVsYXkgKyAxKSAqIDEwMDsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gICAgCWlmIChzcC0+
aGFzX2lycSkgew0KPiA+ID4gPiA+ID4gICAgCQlpZiAoIXdhaXRfZm9yX2NvbXBsZXRpb25fdGlt
ZW91dCgmc3AtPm9wX2RvbmUsDQo+ID4gPiA+ID4gPiAtCQkJCQkJIChkZWxheSArIDEpICoNCj4g
PiA+ID4gPiA+IDEwMCkpDQo+ID4gPiA+ID4gPiArCQkgICAgbXNlY3NfdG9famlmZmllcyhtYXhf
dChzaXplX3QsIHRpbWVvdXQgLw0KPiA+ID4gPiA+ID4gMTAwMCwNCj4gPiA+ID4gPiA+IDEwKSkp
KQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFlvdSdyZSBnaXZpbmcgYSBgc2l6ZV90YCB2YXJpYWJs
ZSB0byBtc2Vjc190b19qaWZmaWVzKCksIGJ1dA0KPiA+ID4gPiA+IGNoZWNraW5nIGBqaWZmaWVz
LmhgLA0KPiA+ID4gPiA+IHRoaXMgZnVuY3Rpb24gdGFrZXMgYSBgY29uc3QgdW5zaWduZWQgaW50
YCBwYXJhbS4NCj4gPiA+ID4gPiBQbGVhc2UgY2hhbmdlIHRoZSB0eXBlIHRvIG1hdGNoIHRoYXQu
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgdHlwZSBzaG91bGRuJ3QgbWF0dGVyIGF0IGFsbC4NCj4g
PiA+ID4gV2hhdCBtYXR0ZXJzIGlzIHRoZSBkb21haW4gb2YgdGhlIHZhbHVlLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gUXVpdGUgd2h5IHlvdSBuZWVkIHRvIHVzZSBtYXhfdChzaXplX3QsIC4uLikgaXMg
YW5vdGhlciBtYXR0ZXIuDQo+ID4gPiA+IHRpbWVvdXQgaXMgdWxvbmcgc28gbWF4KHRpbWVvdXQv
MTAwMCwgMTB1bCkgc2hvdWxkIGJlIGZpbmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBCdXQgaXMgdWxv
bmcgZXZlbiByaWdodD8NCj4gPiA+ID4gVGhlIGRvbWFpbiBvZiB0aGUgdmFsdWUgaXMgYWxtb3N0
IGNlcnRhaW5seSB0aGUgc2FtZSBvbiAzMmJpdA0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gNjRiaXQu
DQo+ID4gPiA+IFNvIHlvdSBhbG1vc3QgY2VydGFpbmx5IG5lZWQgdTMyIG9yIHU2NC4NCj4gPiA+
ID4gDQo+ID4gPiA+IAlEYXZpZA0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSGkgRGF2aWQgJiBB
bmdlbG8NCj4gPiA+IA0KPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzIQ0KPiA+ID4g
VG8gc3VtIHVwLCBJIHRoaW5rIHRoZSBuZXh0IHZlcnNpb24gd2lsbCBtYWtlIHRoZSBmb2xsb3dp
bmcgdHdvDQo+ID4gPiBjaGFuZ2VzOg0KPiA+ID4gMSwgVGhlIHRpbWVvdXQgdmFsdWUgd2lsbCBu
b3QgZXhjZWVkIHUzMiwgc28gdGhlIHR5cGUgb2YgdGltZW91dA0KPiA+ID4gd2lsbA0KPiA+ID4g
YmUgY2hhbmdlZCBmcm9tIHVsb25nIHRvIHUzMi4NCj4gPiA+IDIsIENoYW5nZSBtc2Vjc190b19q
aWZmaWVzKG1heF90KHNpemVfdCwgdGltZW91dCAvIDEwMDAsIDEwKSkgdG8NCj4gPiA+IGJlDQo+
ID4gPiBtc2Vjc190b19qaWZmaWVzKG1heCh0aW1lb3V0IC8gMTAwMCwgMTBVKSkuDQo+ID4gPiAN
Cj4gPiA+IElmIHlvdSB0aGluayB0aGVzZSBjaGFuZ2VzIGFyZSBub3QgZW5vdWdoLCBwbGVhc2Ug
bGV0IG1lIGtub3csDQo+ID4gPiBUaGFua3PvvIENCj4gPiA+IA0KPiA+ID4gQmVzdCBSZWdhcmRz
LA0KPiA+ID4gQmF5aQ0KPiA+ID4gDQo+ID4gDQo+ID4gSGkgQW5nZWxvLCBIaSBEYXZpZCwNCj4g
PiANCj4gPiBKdXN0IGEgZ2VudGxlIHBpbmcgb24gdGhpcy4NCj4gPiBDb3VsZCB5b3UgcGxlYXNl
IHJldmlldyB0aGlzIHBhdGNoIGFuZCBnaXZlIHVzIHNvbWUgc3VnZ2VzdGlvbj8NCj4gPiANCj4g
PiBQUzogV2l0aCB5b3VyIHBlcm1pc3Npb24sIEkgd2lsbCBtYWtlIHRoZSBmb2xsb3dpbmcgY2hh
bmdlcyBpbiB0aGUNCj4gPiBuZXh0DQo+ID4gdmVyc2lvbjoNCj4gPiANCj4gPiBDaGFuZ2UgaW4g
djI6DQo+ID4gICAgLUNoYW5nZSB0aGUgdHlwZSBvZiAidGltZW91dCIgZnJvbSB1bG9uZyB0byB1
MzIuDQo+ID4gICAgLVJlcGxhY2UgbWF4X3Qgd2l0aCBtYXguDQo+ID4gDQo+IA0KPiBJIHN0aWxs
IHJlY29tbWVuZCB0byB1c2UgdXNlY3NfdG9famlmZmllcygpIHdoZW4gYXBwcm9wcmlhdGUsIGlu
c3RlYWQNCj4gb2YNCj4gY29udmVydGluZyB1c2VjcyB0byBtc2VjcyBhbmQgdXNpbmcgbXNlY3Nf
dG9famlmZmllcygpLg0KPiANCj4gQXMgZm9yIHRoZSByZXN0IGluIHlvdXIgbGlzdDogeWVzLCBw
bGVhc2UuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFuZ2VsbywNCg0KVGhh
bmtzIGZvciB5b3VyIGNvbW1lbnRzISANCkkgd2lsbCBjaGFuZ2UgaXQgdG8gYmUgdXNlY3NfdG9f
amlmZmllcyhtYXgodGltZW91dCwgMTAwMDBVKSkgaW4gdGhlDQpuZXh0IHBhdGNoLg0KDQpCUnMs
DQpCYXlpIENoZW5nDQoNCg0KPiA+IA0KPiA+IFRoYW5rcy4NCj4gPiANCj4gPiBCUnMsDQo+ID4g
QmF5aSBDaGVuZw0KPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFzaWRlIGZyb20gdGhhdCwg
eW91ciBgdGltZW91dGAgdmFyaWFibGUgY29udGFpbnMgYSB0aW1lb3V0DQo+ID4gPiA+ID4gaW4N
Cj4gPiA+ID4gPiBtaWNyb3NlY29uZHMgYW5kDQo+ID4gPiA+ID4gdGhpcyBtZWFucyB0aGF0IGFj
dHVhbGx5IHVzaW5nIG1zZWNzX3RvX2ppZmZpZXMoKSBpcw0KPiA+ID4gPiA+IHN1Ym9wdGltYWwN
Cj4gPiA+ID4gPiBoZXJlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFBsZWFzZSB1c2UgdXNlY3Nf
dG9famlmZmllcygpIGluc3RlYWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUmVnYXJkcywNCj4g
PiA+ID4gPiBBbmdlbG8NCj4gPiA+ID4gDQo+ID4gPiA+IC0NCj4gPiA+ID4gUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbg0KPiA+ID4g
PiBLZXluZXMsDQo+ID4gPiA+IE1LMSAxUFQsIFVLDQo+ID4gPiA+IFJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo+IA0KPiANCg==
