Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DB617652
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKCFpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCFpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:45:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F29A13F64;
        Wed,  2 Nov 2022 22:45:18 -0700 (PDT)
X-UUID: 71707afcd19d443e91c45333fc38949f-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1iBDtIsNY4tOQaFFwzbWBkuAXOX3aBaRTdK4IkVdRps=;
        b=GlnFc/2b25WyAqiBXc0uCKo1xw1O1EAxVuV/UqrNW9c5NTJSew6+S2vbe8s2sPeTwZejw5RisNSEPmUHao9MJiapB6ZMbj/zWHp4eBjdcVUylWN0JPMA8CCDtQY4jgKHa3y4r7AC/UzncENuoHBoR3jalF7oC3TWdZzd4tgjm/E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:65766507-3c13-4793-82d0-88abb7408c3e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.12,REQID:65766507-3c13-4793-82d0-88abb7408c3e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:156c7290-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:221103042630DQVQK6L0,BulkQuantity:8,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 71707afcd19d443e91c45333fc38949f-20221103
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1764881680; Thu, 03 Nov 2022 13:45:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 3 Nov 2022 13:45:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 3 Nov 2022 13:45:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgMILPlSiyUvlcLpzaymS4v+w1KgoNNiFe0711+H7Ej5EzSI8btvl8NDquYf5jm0tfY5BemLthLvFNGHwYSBWLxIh4c5dTFZSp3mjnrJME5lpv07UbmSwVt9UYPAp/6X8AHZO9esA6Dvudoq9tGTnGLb8wZ+sNdXuffm24sqlGsQExj4Va3Zo+IT7c4DGIisS2TAOQXHndko4rXl46EiXqYpmufE1A8mNFu6lQh1Fp9gOheNQjM2OXJMuryKkPKjUAIqgcy9Z+D+yQLzY55RJ+QKgYrqP0P7nt3f9/qpZtceb+ipJp9ckVW7h46US9sPgyYKVchRGNC/N2/MkRoQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iBDtIsNY4tOQaFFwzbWBkuAXOX3aBaRTdK4IkVdRps=;
 b=G4V64j3c7hG6dcI1bxM9OffZbI4omI5sf4hL/LNRorwsjVXnjsTKC9j3+Vj2/GDkydLEjk8yCT8vWTgbfspzwAyq1Ssuh3o7l4ml1RRIdj5xGsKdE5pFzC18ME0ELXk3Km7fw8H83k750I1/7kf9f0QFqKxIvmI1cYUUUyL0TC69bhQ+lOP4rDekVkY7rlSIguezs2c9/eUY6850D995EFTxF+cLx0dN9YdoXNxC2B/9rwmnlqGkwfNAkGMuCugXhlbuN7STHeSqZ5HjY1axYLultKpREiJy4vBIm49RnGIon/GP2JfG+Xg9QeFOVGpfcvxnSxC1im9aTSo2YzcmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iBDtIsNY4tOQaFFwzbWBkuAXOX3aBaRTdK4IkVdRps=;
 b=RwImN/1uRqSroYtjTmRghQrae0S+nGF35ruC0s682HwQxDHpnsOHWiK8LIoLh3lvPL62qA/RhDveuSAAIN8pM2f48YzkT1TrXprQfxMzc51B6oaUVxovfGtTCmM6LwyD4o3pCxe3DbxyhNyPn3hx8knsHqtpEhpgfThyjwW8Q+U=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SG2PR03MB6683.apcprd03.prod.outlook.com (2603:1096:4:1d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 05:45:07 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::6059:8025:59fb:55b7]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::6059:8025:59fb:55b7%4]) with mapi id 15.20.5791.009; Thu, 3 Nov 2022
 05:45:07 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: watchdog: mediatek: Convert mtk-wdt
 to json-schema
Thread-Topic: [PATCH v3 5/7] dt-bindings: watchdog: mediatek: Convert mtk-wdt
 to json-schema
Thread-Index: AQHY7dCYbcSo20eJlkisUTojVQQSKq4sFxeAgACcIgA=
Date:   Thu, 3 Nov 2022 05:45:07 +0000
Message-ID: <e2c8061c4bcc388171243646cfebe5876a227dd4.camel@mediatek.com>
References: <20221101090116.27130-1-allen-kh.cheng@mediatek.com>
         <20221101090116.27130-6-allen-kh.cheng@mediatek.com>
         <20221102202617.ailu6xc5qfstnl6c@notapiano>
In-Reply-To: <20221102202617.ailu6xc5qfstnl6c@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SG2PR03MB6683:EE_
x-ms-office365-filtering-correlation-id: 3bb43bad-64cc-43c4-0834-08dabd5e909c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7dIclqw8wmcDiQxoFasHpJdxwbMCWhDQ/zJ8Na2XKm3nlRjtqnAbC+160uBVVKTu5ImgVvIZa1IY9fTypxpUrJud2e6I5FwkUgj+byaQpK/I9+8pwwlteGpdxpCa6fLUjVnptLcnVPQLL+LSeyiascHe29BG3X5/WDNMlQfA8v9D7X3n4wKruGbyqy8r6zf4WAlZ8tNWd/puEQ8xhA0H4F1eXe4s3e23/mlcYZ9Q2miQpbZ2BGos5tMmSjMcXxaoVaakudFwnkH4aOWMVk7SmP0vKHx+QCRiG+XbLOhuQFikhP3ysHkXrIPP+nQ3cBM25l7yyL9geVqbO2o7RiUracXiIw8ooec49C4mqIA39HaGzD/1ouZW14UrM5LurG7YbgJi1uqiwsg99u/BbkMSZCXEkvnQ7t6c5jnNmdRAO4TkIfzC+217cq7MYVkqxcUEDAJcymw5l6AkLtoN+ub8OfY0Dq+T96281Nq9meqhk+W4+NbrD/UxaDGzR8bAWDIC6iIs1WrABiAuadEP1wxu4eVuLAJoQ7lfNkIP6OhBYaGU73Wg8dGBGbit6VeDYViJlK9N+eh1WqykduZIVzV2bRaPfTcqHUbKT33ZuKlqgiMtSpshi5+a1af8neVeJuWXqHoyNnkQPu8qdheYzqw8ZB2qN0OpGJic7zhNKYwO1t1566yjOYnBxFDM8WS026g+ETogih9yta5uAjAF0lP97HbPUgV+5PBQyMRs820MqSOZ8wmfAzwEtvAWvsHYjQ+kgVDLuf8l4iRrBfLbJaCbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(186003)(122000001)(478600001)(2906002)(41300700001)(71200400001)(2616005)(36756003)(4744005)(6486002)(86362001)(8676002)(6916009)(54906003)(8936002)(6506007)(38100700002)(85182001)(6512007)(7416002)(64756008)(38070700005)(5660300002)(66946007)(66446008)(4326008)(66556008)(66476007)(26005)(76116006)(91956017)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hXdXNyWXpqRGhNdlVBRGtSOXFWRE82eFJmMi9vLzFSOVJwMFNTcmdybmRZ?=
 =?utf-8?B?QWRsMzB4aHFxRnd1RUlMUXhZcmV4OFJFQTNobU00OXZDbU5Ob01qZUVNS00r?=
 =?utf-8?B?T2lSeFNFTW0vclF2R3dqUGNhWWhWRVdaTm1LY2xRbkVtZ3lFU1AwMEswTlBy?=
 =?utf-8?B?Q1h5VXpvRnFJODl4SW0wbXFVNTY3Y0FOay9nZWVIUnZTYTFxNVlHQUxZeFor?=
 =?utf-8?B?Zzc0b2lneGhPUXhJdGVSVlo1eEJMMWNuQldMZ2RpYjZNaytZRXM2Q1pxUDFr?=
 =?utf-8?B?dm82NUN2L1pqdCt0NzVYT0JZWFhzekUzbWNRY0M3bHA3Yy9qYzdxR3dWTi9u?=
 =?utf-8?B?amJpZDhWY2wwS29sQndFd2lxN1JYMURscDBodkFDRTRtZm45N2RFOHZETTkv?=
 =?utf-8?B?V0NRQ0h5YnZ4Q2lWVTlFVFRXUGRhdXFmYWJTV1lRSlVkclpVdVd1RmJsb3hs?=
 =?utf-8?B?V2VTczJEaEVXMUt6MHB2WngrUUdXcVNWbElpeFIxcnpLTHltU0NJS2RuZnJ4?=
 =?utf-8?B?cDdyUlZLQ0Z3bFhNcHB6Sy90eVNLd3BxbDVaa2M0eDc3U2lDbEhSSnVVL0dC?=
 =?utf-8?B?dmtWTXlFYTkwaHlpcFJST29LUnFTSU1VNEhCc1hCL2x2Q3hUTzcxRUl3NTdy?=
 =?utf-8?B?U3h1M2RDQmQ4dE1DZnFBT2lvbWFQMXFPTmhteUdZVHRMUW82N2QvYUl0V0dQ?=
 =?utf-8?B?UFZBZkpVVWt5WS9SQ2tEMmJ0UWkxdUFJWWd2a3VxMGJ1YVFoSTdnWlpjdTA2?=
 =?utf-8?B?R2lBWU1EeG9YV3VwOWxENmtldDlHbDF6Z2pyS0dsTGFnZS8yVGx4SFowczhE?=
 =?utf-8?B?QnFva01mbXVhc1RpaTdYTFVEYzQ0QlFGMUhvYTZicWhQQ1d1SHUzOFRhaG95?=
 =?utf-8?B?N0dnL1RxVVRJUk9rSitKbjVRTmE2TmZ0TEVsajlGSy9MaldIRVNOOHFzM1po?=
 =?utf-8?B?UUYxYVMxK2xYbnVuaGVjTkFzejZseGZ0d21ieVJxS2xUOEJFMGZBSTZqajVE?=
 =?utf-8?B?V20wZWdyVzNHWTZBWDFGUVlnY1BsZWhsVzFMaGoxNTlTczZXcmIxdjhRZkcv?=
 =?utf-8?B?WUFSRXI2Z0dsRUFUaklNcHhQTStRNi9rd2JKQmtBaDVZQUM5bWNScmh5WVJ1?=
 =?utf-8?B?YWR3aWdoa3lLNkZtOHhCMW1ENjFOTEtrTldMMkZZZFR0YkNJUnZiZVZYaXNI?=
 =?utf-8?B?cXFMU3lZcTlBdWdSVnBKU1NtOVlaa0RGandJZ0k1NEI1YTJqRzFwVzF3NDN6?=
 =?utf-8?B?RFUvR0V5RC9kSHc1eVJZeGpONnZvNnBFVkNnMTExWGZwdEFZcGdHTTloUzZF?=
 =?utf-8?B?MCtkaU93MFU3NS9ST3M0SE9MMUN3OXc2ZHlyR3FOY0VNOEJ5c1JwcEVsODdX?=
 =?utf-8?B?MEM1K1k4WFBSazZ4QW1Sd3NQS2o2eDB5MWRDaUZHYkFOdE9MRWRleEF6ang4?=
 =?utf-8?B?Z0RZUzZHWlpPcmFCNjFTN1BUcHY3TUxmelUreWFWMS9LWlhValJEbjB5V1FR?=
 =?utf-8?B?eENTdHI0L292Q3RqdEpUMTVjVzEzdjBqby9tenhMV2l2R1NIM0tUbUVpUStD?=
 =?utf-8?B?Ty9OaWUxY1Y1ZzV2dFMzOHA1ZnUyNmVSajhTbXgyQ1BadjZ5cmtmWmNyRDhC?=
 =?utf-8?B?N0s5NzVQcGxEZWtQSFM2QlFaMy9aRHRkWGhNWkNYbS9JUTBaZ1VoQ1VaZmJM?=
 =?utf-8?B?SzIrNDV6anE2UlZNMXBRU2lDUkorcU9LZzB3MnQ3NUJPYWFseC9wdVNvSS9j?=
 =?utf-8?B?NlJ6a29GakI4aGJtTktIdmlZL0dBZTErY0NpekptOVlaQko3SS8wSGhsL3hY?=
 =?utf-8?B?VGhZREZ1TmY1bUlWbUhJd3hxblVpYXdnS0VhYmJzTXpUYW9hVlhPN0tkelNu?=
 =?utf-8?B?YjduNDZSaGZQdjc5TXRlM3FBbEI4TDl6elZ0Z0lGdk5TUjhqTngwc20zZmhp?=
 =?utf-8?B?czhvM1RESitFVWZvdFNpTXcwZ2lPeEY5OVVNa3RKdC9OeGpQK01mMU93K011?=
 =?utf-8?B?TUwwZmdEMEhObGltMDRlUEdGaGtqcWZra2U3eWRJQTBCU2hpb01PVEVEOU4w?=
 =?utf-8?B?U0dQeG50cXNsdHhaUE1sOE1wTCtIREhiOHhseDBZSHR3bmlnbDZ3bkpnQzMx?=
 =?utf-8?B?SU1rWFNZZE1weElSVG5HNUV3MTlKMFN0SmQrVG5PYjZPeEtSMkpoTnYrME5s?=
 =?utf-8?Q?pS8VDspy5YMxCx03VgAuXPQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE0C0FF52709D14B8602E3E305D2BD2B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb43bad-64cc-43c4-0834-08dabd5e909c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 05:45:07.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0mnzl19xW6OyoItGsZTdAkvJrm4IywzIm9+d+MBZ/DkgaPSYEKQLJdX/z+M8LSvwRWxmRChcd622THjasRoJN4B+sdCJyz7sH18mOdZg6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTAyIGF0IDE2OjI2IC0wNDAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFk
byB3cm90ZToNCj4gT24gVHVlLCBOb3YgMDEsIDIwMjIgYXQgMDU6MDE6MTRQTSArMDgwMCwgQWxs
ZW4tS0ggQ2hlbmcgd3JvdGU6DQo+IFsuLl0NCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL21lZGlhdGVrLG10ay0N
Cj4gPiB3ZHQueWFtbA0KPiANCj4gWy4uXQ0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4g
PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2lj
Lmg+DQo+ID4gKw0KPiA+ICsgICAgc29jIHsNCj4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwyPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArDQo+ID4gKyAgICAg
ICAgd2F0Y2hkb2c6IHdhdGNoZG9nQDEwMDA3MDAwIHsNCj4gDQo+IFlvdSBjb3VsZCBkcm9wIHRo
aXMgbGFiZWwgc2luY2UgaXQncyBub3QgdXNlZCBpbiB0aGUgZXhhbXBsZS4NCj4gDQo+IFJldmll
d2VkLWJ5OiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+
DQo+IA0KPiBUaGFua3MsDQo+IE7DrWNvbGFzDQo+IA0KDQpXaWxsIGRvLg0KDQpUaGFua3MsDQpB
bGxlbg0KDQo+ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXdk
dCI7DQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDwwIDB4MTAwMDcwMDAgMCAweDEwMD47DQo+ID4g
KyAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMzkgSVJRX1RZUEVfTEVWRUxfTE9X
PjsNCj4gPiArICAgICAgICAgICAgbWVkaWF0ZWssZGlzYWJsZS1leHRyc3Q7DQo+ID4gKyAgICAg
ICAgICAgIHRpbWVvdXQtc2VjID0gPDEwPjsNCj4gPiArICAgICAgICAgICAgI3Jlc2V0LWNlbGxz
ID0gPDE+Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICB9Ow0KPiANCj4gWy4uXQ0K
