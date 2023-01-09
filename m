Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29A6661F85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjAIH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjAIH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:56:23 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79905BF61;
        Sun,  8 Jan 2023 23:56:21 -0800 (PST)
X-UUID: c3eddc78bb2f49cca708918be50e9fb0-20230109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bL10FdLg0vyKE5IlNcZZM52vxN4Yrw2+A6ieVEZL7pc=;
        b=dmB2bqhiScxh09smR4OssvxxbhOJaOMqKwJGXzuUxWtd+Mn1J1Tg4IyG1Q3XGGqK+444J1asX0aGwrvf3EB5LmKhQ7ta5ak77k6LpBp0W3ZywJHuO1c/Lbsm3lOG0GiW40mGIRc+bpWk1ld2uIFpzp9xPt344jmJY2Qh9Hzc2bA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:d78c3b5f-3cc8-4ac2-a8a3-687e5114f76f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:d78c3b5f-3cc8-4ac2-a8a3-687e5114f76f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:8cb5b08b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230109155617E28SLAFJ,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-BVR: 0
X-UUID: c3eddc78bb2f49cca708918be50e9fb0-20230109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1525050097; Mon, 09 Jan 2023 15:56:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 9 Jan 2023 15:56:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 9 Jan 2023 15:56:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5rTPYf999U6d4g1kNdih5cRiuxxZL92sP/9tZSw+IlI4BsQ1aD1CHacWPrEJw4a0RTEEtZN3FihwfH+A0hQIu3JKVA8zXj36P8lRLIZFzTnJfOZ0VCALrtp25SNjl5n2rhNzgrnvZH1O16aemmvC1VMQ0pqevjjcRxgcoJH1fBL3EwxCpM425ID9AdbDJlPeBautfPe2ldaBtAjpPbMLXCQdCuj76b5Gepq6A52LTZAq5LUyPl93lz4wqAbrZ1A+ooesdbZZ00pyyXlhV6/Cg9QrkH5F4ZoCJ5dShgPx7ZsblDDcm210m4ra6CIxq9umknjJKKZxOXHmF72G23/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bL10FdLg0vyKE5IlNcZZM52vxN4Yrw2+A6ieVEZL7pc=;
 b=UopTrCgW7XbYe8Qet3I/ODBuVnqxYhE6+KCrUDBOl15tAaxK4jPX7quhMUJyYd8h9S8gl0ri4aa2K9A7S2qr45Dk1POwItrf7A7DtcpMX5L8EQ/1Deo9C292VrJVP7BnlSG4PN9m9FEY3Z84nbkc6DN8HqDXop1aA86frFhNbypXcNUXpSCGcM2Yp5x6KkLYkba1yOfdEd84+BGZPXZOi8hR65PEUnWSVdh3/k0LuOep+Bqk1C4z+RIXHmnLILBVpeO4awaErHGmyDWUXQJzAEWpy64lgygOnWxXS2nXQeBOJp+wsexywRczLdekEranOy4BbRqpFhYFPL+b2/O0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL10FdLg0vyKE5IlNcZZM52vxN4Yrw2+A6ieVEZL7pc=;
 b=ef8bW8iJigh0fAiH/gqplI7jgA0p3ozY+eF8/oXe3PnWsYvPQrqHCVOX68ioXolKrEHa40c8GloAOBqjoQb1q3r/HK3bgXxtthu0LUqDzaRX3PCzaOksj086BtW4GN8acQIRStdwcWRl0WPGIAM8KBUZg9Et+jvMifRQwiuGltU=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SI2PR03MB6461.apcprd03.prod.outlook.com (2603:1096:4:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:56:11 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:56:11 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: mtk-wdt: Add reset-by-toprgu
 support
Thread-Topic: [PATCH 1/2] dt-bindings: watchdog: mtk-wdt: Add reset-by-toprgu
 support
Thread-Index: AQHZIcXBdVlzkwmZo0WdukFTupaz3a6RUeiAgARqN4A=
Date:   Mon, 9 Jan 2023 07:56:10 +0000
Message-ID: <41cbab99441c9475197cacd71a4b204b17f024f3.camel@mediatek.com>
References: <20230106115326.15374-1-allen-kh.cheng@mediatek.com>
         <20230106115326.15374-2-allen-kh.cheng@mediatek.com>
         <ba51e54c-8758-cbcb-bfdd-e8f2efbf905c@linaro.org>
In-Reply-To: <ba51e54c-8758-cbcb-bfdd-e8f2efbf905c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SI2PR03MB6461:EE_
x-ms-office365-filtering-correlation-id: 946a6a96-3bfb-4cb4-dc52-08daf216f926
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+UU+bxlL3VpudIN3XpKIqTRoZQsZ1xaafSVwD75NYJa2ZrOreTYDQhT2iuWElaW4K2gfoanCKH97t+xvgiXwhfecOnwhAJr7wB0L9eMOyIT7m5Z8FgHOSSw1HsBB5KorHG43jcKitHr5t/6e1W5V0RO0P+f689iogtfIH6Moph0ZqEhmUI0cAJ6FFSkSNPdcWRHmM3e/q+gC05CcOm78r2PM0imyndq69pS7Xgf/afI+Aas0NrAPVO3Ff6BTq70C9XON/x9RHUkD/93UGCF+mQCP/PtDA5lDjRuMRdW6oqOz50Q1NNDR9McAYelE55jKQMhVuHrjY4UV7ThKGUbrRwh3P4c5cjYRitjWIpHfF/uLy368BR48np9jaruzGZV1EqmQHMdjGrcaGiHM3O+zWCrm5+/pMX9dtAssC0Z45ftDCx1+SSMClR4Q4abLUWACRhV+TsfbGPJSFK8nDjh0mMa4v6vETQBZlySNJSz23JaCyybsDReuL1Qd4RKLjcjooUJNjla6DkpCkcXrHZuyjNpJsQyRD4OEFe6onSnUY5oWX6DOKN1A41wd067+NPcs1odueyqwAtr+twA+lmuHA+x6g0EF11+6NPCY3HSLd8os3wyQvVn6BX105gzODKh066vuaQN9UWRNa07u9ojObC44D7yI3hSBM9y0kUWKHovYZFkzZvWLuCmsI/A4Ajlc2VjDYHPMQofxHgNnXvR+hXM/rPz081mbkQKhafzEYijpowfePnZ1vGA9m9a0PKF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(53546011)(36756003)(85182001)(186003)(8936002)(122000001)(26005)(6506007)(6512007)(2616005)(54906003)(110136005)(5660300002)(66946007)(7416002)(66446008)(66476007)(66556008)(64756008)(6486002)(4326008)(91956017)(316002)(86362001)(38070700005)(71200400001)(38100700002)(76116006)(478600001)(41300700001)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZ6ZXJDQ3g0OURMSWVZZXR6U29rbXMzZ1daQTZSdzB2Ykc1STJQcGJJR2lP?=
 =?utf-8?B?aXR2VkdiWjNOR0NwdmpsR2xXWGtka2tSeWh3T3hqdWpSc1JJRm00cm15K0xO?=
 =?utf-8?B?ZE1hU3JvQnNZWmxnY2doRnEwaEE4NFNvUGt3YlpsMWVETlduS3RlZVZ3cG4v?=
 =?utf-8?B?Z1RpMmdFd0gxUU55SkdhUlZ0dTlCblYvWXVVZ2NNSVQvc2FuTUI5cjVONmgy?=
 =?utf-8?B?Y2ZsWG0rUzFQOEt6RnJETnpwS1BzbERtU3hxVHhBOStza3FOTzJyYlZDdHRr?=
 =?utf-8?B?L21FNU93Yi8vemUzYk91MWQ5U0F4WkEwcUpiTEdSaUxVUlVlTVlOR3psYlI3?=
 =?utf-8?B?NXBocnNZaDUvSkc1b3pHd3kxbVZxWG8yU0F3L202bVVBU1N0UDIyQ2NraG5W?=
 =?utf-8?B?d29Fc2RaZmlBRDg1RzNFQ05tZlNGZTdkTy9acSs5bFpjSjI2Rnk0OWtLdnpz?=
 =?utf-8?B?emlVQ0sxakdIK2R5UVNGckJVWUhjQTd1MkhDblBlZ3BXQmhhRGVBQk9jOGRP?=
 =?utf-8?B?eGJhWFhZMHRrNlR0UXpDN1Y4czJGbFQzU1VXUDdJeHl4dHpqdUthMllWZkc0?=
 =?utf-8?B?SW0zOHhjQlMrcktteFRsWlRRWnljaVZ0Q2kvS0hkNHh5VHJnbU8vSkpFbzdr?=
 =?utf-8?B?UmI2R2gzRmVoTHRqZXRXZEVFb251WlJkVk5OTWZlVk5WMjliOWhyVzhaYlU5?=
 =?utf-8?B?ajBEQTUvTTM4N0c5dG5OM3hneUVQb3N4ZGdxZlRtTFYzVzdlNmlwaHo2dDVr?=
 =?utf-8?B?cERsWE9uTTRrNTdacFl6MlJnWXJEaHhjbmpUVGsyVHdNRDV1dU5CTEp0MFRk?=
 =?utf-8?B?Z1JFUFhacEM4UGxwUkdrRFlxN21xbTRyWEtoc09OV1lXQnJLT25RT3lLVTdm?=
 =?utf-8?B?TjNudWozZGlOQkIxbVVQKy9CM3hIWDk3TFBjSjdhc1F6WWRmbVBXdjRQVFpE?=
 =?utf-8?B?VXl1U3BzU291NmNtRWxlZzhMWndlNktuM2FxYnNsSm4rYjlvMGM3VnpJS0hO?=
 =?utf-8?B?U3BQaVdQbXZLQjBnMDZHdlFnOU5GMFdaYWtsREZPcDk5ZXplY1Z5MC93TTln?=
 =?utf-8?B?bkpiemN5aEZRTnBmYVhwNzNzV3BtL2VUWjFHd1R4TGsvaVZaQ1VZaThySWcz?=
 =?utf-8?B?dGpDR29pVlNCY2M0ejVwQk1PNUk3RmppZ2tsb1hFeFlVWXRoUUpGOTlhTFB4?=
 =?utf-8?B?dDNNcGRMb0I4MTg0Nk5UQkFKRTlFcml3TUFlMFhRT3JrYlNPY2tvalphckd4?=
 =?utf-8?B?aVUzV1l3MlFYbEZCZXdSSmNKOUo3OWdjclFmNlNWYVhEdEc4SzZoZGZVYW51?=
 =?utf-8?B?bnAweE8rbFNGYUU0NFF4Zms5SXd3UlhqRHRrb1FCVUs4bktXWXhKWGYzQW5E?=
 =?utf-8?B?bWsvdGhNVUt4QUFuTkdUeTRQTXlzZ0NwYTk0WHJXOWVESThVS0d0VXhvTzFV?=
 =?utf-8?B?ZmFLNms3b3lGZ0ZNQ1A5SFZWV2w5K2NKOWJQbmJhT0Jtc25WU29TNjU5NStK?=
 =?utf-8?B?OE5PRlFtR3dIaVl4QllaZTFUUDFYSFEwY1RCTjZJMWNWOEkrUTFNeGl5SDJW?=
 =?utf-8?B?TWk0dllNaFhFZDFYdzQ3WVdWb1F5MHIzOW8rSmhaQ3dtZTdQOTdza2xuWUYv?=
 =?utf-8?B?b2tzTkNYejV4N3IxUFRDcUxHYnJEV1ZrOG50SmFJWmVrem84dlo4Q1NueGdS?=
 =?utf-8?B?RjhSbEdIenpUbXlpWTNFaEh0dXZUMUIraUZna0pMZUVRbXNZTG5KT2NEY1lZ?=
 =?utf-8?B?cS9TenltMk1BeVhpcDZZSlFIb08rWmN0YjdidnJicldXTUZCSDVkcUJoU2FT?=
 =?utf-8?B?NVg5Nkw3NnNoeWpGQ2tEbGVwNlNlWDBNYXBSWnRqMmdPcTNHeVFwM2Fnc3M1?=
 =?utf-8?B?YWluOWNaV2pjN2E2RkNJM2c4NkhLQVVVL094KzV0OHhXR2o0ejgyUGZSbUpT?=
 =?utf-8?B?d0pBOEE4dFJyemQzRm80RHYwaDRIK1k5T0l2ZFVNcTE2cFpSVDVocmVDVGpv?=
 =?utf-8?B?T3NyTFdwcWlqclhZZlRqVFd0aHlaSzFrSTVBQzJ3UkI4cGZDU285cmdWN3Fp?=
 =?utf-8?B?TVRNbGFUbFN6K2tSRlJuNkVjTnM3VHNxcTRtV2JPOHBkZS9nZXBlZTM2TW5M?=
 =?utf-8?B?aG0zVXFGL3luc2JOQkhJbEJXMk9uR2Z3VXE2OVBrL0FCdk01RkNRbDU0VXJy?=
 =?utf-8?Q?2f5gyBCUTr0YI4mn8BpsYOE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <767B0A0D285318499635D8AD6470FE8A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946a6a96-3bfb-4cb4-dc52-08daf216f926
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:56:10.9466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXrBD1pNPdpdPK7Sfw8PzaUwdnqhc2TtmEl0B6cLyCLIz4byIa1e4XdctRk9ANe7EKO5rTZov7/b2hnPmwwtnVDfj6+aQd4WG5a4esNoiNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBGcmksIDIwMjMtMDEtMDYgYXQgMTM6MzAgKzAxMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDA2LzAxLzIwMjMgMTI6NTMsIEFsbGVuLUtIIENo
ZW5nIHdyb3RlOg0KPiA+IEluIHNvbWUgYXBwbGljYXRpb25zLCB0aGUgbXRrLXdkdCByZXF1aXJl
cyB0aGUgdG9wcmd1IChUT1AgUmVzZXQNCj4gPiBHZW5lcmF0aW9uIFVuaXQpIHRvIHJlc2V0IGNv
dW50ZXIgYWZ0ZXIgd2R0IHJlc2V0cy4gQWRkIG9wdGlvbmFsDQo+ID4gbWVkaWF0ZWsscmVzZXQt
YnktdG9wcmd1IHByb3BlcnR5IHRvIGVuYWJsZSBpdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9tZWRpYXRlayxtdGstd2R0Lnlh
bWwgICAgICAgIHwgNA0KPiA+ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy93YXRjaGRvZy9tZWRpYXRlayxtdGstd2R0LnlhbWwNCj4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9tZWRpYXRlayxtdGstd2R0LnlhbWwN
Cj4gPiBpbmRleCBiMzYwNTYwODQxMGMuLmJmMDZkY2QwYzEyYyAxMDA2NDQNCj4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvbWVkaWF0ZWssbXRrLQ0K
PiA+IHdkdC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3dhdGNoZG9nL21lZGlhdGVrLG10ay0NCj4gPiB3ZHQueWFtbA0KPiA+IEBAIC01Miw2ICs1Miwx
MCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgZGVzY3JpcHRpb246IERpc2FibGUgc2VuZGluZyBv
dXRwdXQgcmVzZXQgc2lnbmFsDQo+ID4gICAgICB0eXBlOiBib29sZWFuDQo+ID4gIA0KPiA+ICsg
IG1lZGlhdGVrLHJlc2V0LWJ5LXRvcHJndToNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBSZXNldCBj
b3VudGVyIGJ5IHRvcHJndQ0KPiANCj4gRG8gbm90IGNvcHkgdGhlIHByb3BlcnR5IG5hbWUgaW4g
ZGVzY3JpcHRpb24gYnV0IGFjdHVhbGx5IGRlc2NyaWJlDQo+IGl0Lg0KPiANCj4gQWxzbyAidG9w
cmd1IiBpcyBhIGJpdCBjcnlwdGljLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cj4gDQoNClNvcnJ5IGZvciBiZWluZyB1bmNsZWFyLg0KDQpXZSBuYW1lIHRvcHJndSBmb3IgIlRP
UCBSZXNldCBHZW5lcmF0aW9uIFVuaXQiIGluIHRoZSBtdGsgU29DLCB3aGljaCBpcw0KdXNlZCB0
byByZXNldCB0aGUgc3lzdGVtLg0KDQptZWRpYXRlayxyZXNldC1ieS10b3ByZ3U6DQogICBkZXNj
cmlwdGlvbjogSWYgcHJlc2VudCwgbWVhbnMgdGhlIHdhdGNoZG9nIHRpbWVyIHdpbGwgcmVzZXQg
YnkNCnRvcHJndSBhZnRlciBzeXN0ZW0gcmVzZXRzLg0KDQpXaGF0IGRvIHlvdSB0aGluaz8NCg0K
DQoNClRoYW5rcywNCkFsbGVuDQo=
